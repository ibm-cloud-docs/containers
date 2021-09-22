---

copyright:
  years: 2014, 2021
lastupdated: "2021-09-22"

keywords: kubernetes, iks, logmet, logs, metrics, audit, events

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}  

# Reviewing service, API server, and worker node logs
{: #health-audit}

Forward audit logs for {{site.data.keyword.containerlong_notm}}, the Kubernetes API server, and the worker nodes to a logging instance such as {{site.data.keyword.at_full}}. With audit logs, you're able to understand better what operations are initiated by users in your cluster, which can help you troubleshoot issues or report compliance to industry and internal standards.
{: shortdesc}

## Kubernetes API server audit logs
{: #audit-api-server}

To monitor user-initiated, Kubernetes administrative activity made within your cluster, you can collect and forward audit events that are passed through your Kubernetes API server to {{site.data.keyword.la_full_notm}} or an external server. Although the Kubernetes API server for your cluster is enabled for auditing by default, no auditing data is available until you set up log forwarding.
{: shortdesc}

### Considerations and prerequisites
{: #prereqs-apiserver-logs}

Before you set up a Kubernetes API audit configuration, review the following information.
{: shortdesc}

* To see how the audit webhook collects logs, check out the {{site.data.keyword.containerlong_notm}} [`kube-audit` policy](https://github.com/IBM-Cloud/kube-samples/blob/master/kube-audit/kube-audit-policy.yaml){: external}.
    You cannot modify the default policy or apply your own custom policy.
    {: note}

* For Kubernetes audit logs and verbosity, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/){: external}.
* Only one audit webhook can be created in a cluster.
* You must have the  [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform access role](/docs/containers?topic=containers-users#checking-perms) for the {{site.data.keyword.containerlong_notm}} cluster.

To get started, follow the instructions to send Kubernetes API audit logs [to {{site.data.keyword.la_full_notm}}](#audit-api-server-la), [to a resource in the {{site.data.keyword.cloud_notm}} private network](#audit-api-server-priv), or [to an external server](#audit-api-server-external).

### Forwarding Kubernetes API audit logs to {{site.data.keyword.la_short}}
{: #audit-api-server-la}

To forward audit logs to {{site.data.keyword.la_full_notm}}, you can create a Kubernetes audit system by using the provided image and deployment.
{: shortdesc}

The Kubernetes audit system in your cluster consists of an audit webhook, a log collection service and webserver app, and a logging agent. The webhook collects the Kubernetes API server events from your cluster master. The log collection service is a Kubernetes `ClusterIP` service that is created from an image from the public {{site.data.keyword.cloud_notm}} registry. This service exposes a simple `node.js` HTTP webserver app that is exposed only on the private network. The webserver app parses the log data from the audit webhook and creates each log as a unique JSON line. Finally, the logging agent forwards the logs from the webserver app to {{site.data.keyword.la_full_notm}}, where you can view the logs.

**Before you begin**: Ensure that you reviewed the [considerations and prerequisites](#prereqs-apiserver-logs) and that you have the [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform access role](/docs/account?topic=account-userroles) for {{site.data.keyword.la_full_notm}}.

1. Target the global container registry for public {{site.data.keyword.cloud_notm}} images.
    ```
    ibmcloud cr region-set global
    ```
    {: pre}

2. Optional: For more information about the `kube-audit` image, inspect `icr.io/ibm/ibmcloud-kube-audit-to-logdna`.
    ```
    ibmcloud cr image-inspect icr.io/ibm/ibmcloud-kube-audit-to-logdna
    ```
    {: pre}

3. Create a configuration file that is named `ibmcloud-kube-audit.yaml`. This configuration file creates a log collection service and a deployment that pulls the `icr.io/ibm/ibmcloud-kube-audit-to-logdna` image to create a log collection container.
    ```yaml
    apiVersion: v1
    kind: List
    metadata:
      name: ibmcloud-kube-audit
    items:
      - apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: ibmcloud-kube-audit
          labels:
            app: ibmcloud-kube-audit
        spec:
          replicas: 1
          selector:
            matchLabels:
              app: ibmcloud-kube-audit
          template:
            metadata:
              labels:
                app: ibmcloud-kube-audit
            spec:
              containers:
                - name: ibmcloud-kube-audit
                  image: 'icr.io/ibm/ibmcloud-kube-audit-to-logdna:latest'
                  ports:
                    - containerPort: 3000
      - apiVersion: v1
        kind: Service
        metadata:
          name: ibmcloud-kube-audit-service
          labels:
            app: ibmcloud-kube-audit
        spec:
          selector:
            app: ibmcloud-kube-audit
          ports:
            - protocol: TCP
              port: 80
              targetPort: 3000
          type: ClusterIP
    ```
    {: codeblock}

4. Create the deployment in the `default` namespace of your cluster.
    ```
    kubectl create -f ibmcloud-kube-audit.yaml
    ```
    {: pre}

5. Verify that the `ibmcloud-kube-audit-service` pod has a **STATUS** of `Running`.
    ```
    kubectl get pods -l app=ibmcloud-kube-audit
    ```
    {: pre}

    Example output
    ```
    NAME                                             READY   STATUS             RESTARTS   AGE
    ibmcloud-kube-audit-c75cb84c5-qtzqd              1/1     Running   0          21s
    ```
    {: screen}

6. Verify that the `ibmcloud-kube-audit-service` service is deployed in your cluster. In the output, note the **CLUSTER_IP**.
    ```
    kubectl get svc -l app=ibmcloud-kube-audit
    ```
    {: pre}

    Example output
    ```
    NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
    ibmcloud-kube-audit-service   ClusterIP   172.21.xxx.xxx   <none>        80/TCP           1m
    ```
    {: screen}

7. Create the audit webhook to collect Kubernetes API server event logs. Add the `http://` prefix to the **CLUSTER_IP**.
    ```
    ibmcloud ks cluster master audit-webhook set --cluster <cluster_name_or_ID> --remote-server http://172.21.xxx.xxx 
    ```
    {: pre}

8. Verify that the audit webhook is created in your cluster.
    ```
    ibmcloud ks cluster master audit-webhook get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output
    ```
    OK
    Server:            http://172.21.xxx.xxx
    ```
    {: screen}

9. Apply the webhook to your Kubernetes API server by refreshing the cluster master. It might take several minutes for the master to refresh.
    ```
    ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

10. While the master refreshes, [provision an instance of {{site.data.keyword.la_full_notm}} and deploy a logging agent to every worker node in your cluster](/docs/log-analysis?topic=log-analysis-tutorial-use-logdna). The logging agent is required to forward logs from inside your cluster to the {{site.data.keyword.la_full_notm}} service. If you already set up logging agents in your cluster, you can skip this step.

11. After the master refresh completes and the logging agents are running on your worker nodes, you can [view your Kubernetes API audit logs in {{site.data.keyword.la_full_notm}}](/docs/log-analysis?topic=log-analysis-tutorial-use-logdna).

After you set up the audit webhook in your cluster, you can monitor version updates to the `kube-audit-to-logdna` image by running `ibmcloud cr image-list --include-ibm | grep ibmcloud-kube-audit`. To see the version of the image that currently runs in your cluster, run `kubectl get pods | grep ibmcloud-kube-audit` to find the audit pod name, and run `kubectl describe pod <pod_name>` to see the image version.
{: tip}

### Forwarding Kubernetes API audit logs to a resource in the {{site.data.keyword.cloud_notm}} private network
{: #audit-api-server-priv}

Forward audit logs to a resource other than {{site.data.keyword.la_short}} that is outside of your cluster and accessible in the {{site.data.keyword.cloud_notm}} private network.
{: shortdesc}

Before you begin, ensure that you reviewed the [considerations and prerequisites](#prereqs-apiserver-logs).

1. Create a configuration file that is named `kube-audit-remote-private-ip.yaml`. This configuration file creates an endpoint and service for the IP address of the resource that your cluster sends logs to through the {{site.data.keyword.cloud_notm}} private network. Do not include a selector in the service.
    ```yaml
    apiVersion: v1
    kind: Endpoints
    metadata:
      name: kube-audit-remote-private-ip
    subsets:
      - addresses:
          - ip: <logging_resource_private_IP>
        ports:
          - port: 31100
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: kube-audit-remote-private-ip
    spec:
      ports:
        - protocol: TCP
          port: 80
          targetPort: 31100
    ```
    {: codeblock}

2. Create the endpoint and service.
    ```
    kubectl create -f kube-audit-remote-private-ip.yaml
    ```
    {: pre}

3. Verify that the `kube-audit-remote-private-ip` service is deployed in your cluster. In the output, note the **CLUSTER-IP**.
    ```
    kubectl get svc
    ```
    {: pre}

    Example output
    ```
    NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
    ...
    kube-audit-remote-private-ip  ClusterIP   172.21.xxx.xxx   <none>        80/TCP           1m
    ```
    {: screen}

4. Create the audit webhook to collect Kubernetes API server event logs. Add the `http://` prefix to the `CLUSTER-IP` of the service that you previously retrieved.
    ```
    ibmcloud ks cluster master audit-webhook set --cluster <cluster_name_or_ID> --remote-server http://172.21.xxx.xxx
    ```
    {: pre}

5. Verify that the audit webhook is created in your cluster.
    ```
    ibmcloud ks cluster master audit-webhook get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output
    ```
    OK
    Server:            http://172.21.xxx.xxx
    ```
    {: screen}

6. Apply the webhook to your Kubernetes API server by refreshing the cluster master. The master might take several minutes to refresh.
    ```
    ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

After the master refresh completes, your logs are sent to the private IP address of your logging resource.



### Forwarding Kubernetes API audit logs to an external server
{: #audit-api-server-external}

To audit any events that are passed through your Kubernetes API server, you can create a configuration that uses Fluentd to forward events to an external server.
{: shortdesc}

For example, you might [use Logstash with Kubernetes](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend){: external} to collect audit events. To see how Fluentd is used, see [Understanding log forwarding to an external server](/docs/containers?topic=containers-health#logging).

Before you begin, ensure that you reviewed the [considerations and prerequisites](#prereqs-apiserver-logs). Note that [log filters](/docs/containers?topic=containers-health#filter-logs) are not supported.

1. Set up the webhook. If you do not provide any information in the flags, a default configuration is used.

    ```
    ibmcloud ks cluster master audit-webhook set --cluster <cluster_name_or_ID> --remote-server <server_URL_or_IP> --ca-cert <CA_cert_path> --client-cert <client_cert_path> --client-key <client_key_path>
    ```
    {: pre}
    
    | Option | Description |
    | --- | ------ |
    | `<cluster_name_or_ID>` | The name or ID of the cluster. |
    | `<server_URL>` | A publicly accessible URL or IP address for the remote logging service that you want to send logs to. Certificates are ignored if you provide an unsecure server URL. |
    | `<CA_cert_path>` | The file path for the CA certificate that is used to verify the remote logging service. |
    | `<client_cert_path>` | The file path for the client certificate that is used to authenticate against the remote logging service. |
    | `<client_key_path>` | The file path for the corresponding client key that is used to connect to the remote logging service. |
    {: caption="Table 1. Understanding this command's components" caption-side="top"}

2. Verify that log forwarding was enabled by viewing the URL for the remote logging service.

    ```
    ibmcloud ks cluster master audit-webhook get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output:
    ```
    OK
    Server:            https://8.8.8.8
    ```
    {: screen}

3. Apply the configuration update by restarting the Kubernetes master.

    ```
    ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. Optional: If you want to stop forwarding audit logs, you can disable your configuration.
    1. For the cluster that you want to stop collecting API server audit logs from: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2. Disable the webhook back-end configuration for the cluster's API server.

        ```
        ibmcloud ks cluster master audit-webhook unset --cluster <cluster_name_or_ID>
        ```
        {: pre}

    3. Apply the configuration update by restarting the Kubernetes master.

        ```
        ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
        ```
        {: pre}

### Managing API server log forwarding
{: #audit-api-server-manage}

See [Verifying, updating, and deleting log forwarding](/docs/containers?topic=containers-health#verifying-log-forwarding).

### Taking a snapshot of API server logs
{: #audit-api-server-snapshot}

See [Collecting master logs in an {{site.data.keyword.cos_full_notm}} bucket](/docs/containers?topic=containers-health#collect_master).





## Service audit logs
{: #audit-service}

By default, {{site.data.keyword.containerlong_notm}} generates and sends events to {{site.data.keyword.at_full_notm}}. To see these events, you must create an {{site.data.keyword.at_full_notm}} instance. For more information, see [{{site.data.keyword.at_full_notm}} events](/docs/containers?topic=containers-at_events).


