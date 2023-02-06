---

copyright: 
  years: 2014, 2023
lastupdated: "2023-02-06"

keywords: kubernetes, logmet, logs, metrics, audit, events

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

* To see how the audit webhook collects logs, check out the {{site.data.keyword.containerlong_notm}} [`kube-audit` policy](https://github.com/IBM-Cloud/kube-samples/blob/master/kube-audit/kube-audit-policy.yaml){: external}{: external}.
    You can't modify the default policy or apply your own custom policy.
    {: note}

* For Kubernetes audit logs and verbosity, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/){: external}.
* Only one audit webhook can be created in a cluster.
* You must have the  [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform access role](/docs/containers?topic=containers-users#checking-perms) for the {{site.data.keyword.containerlong_notm}} cluster.

To get started, follow the instructions to send Kubernetes API audit logs [to {{site.data.keyword.la_full_notm}}](#audit-api-server-la), [to a resource in the {{site.data.keyword.cloud_notm}} private network](#audit-api-server-priv), or [to an external server](#audit-api-server-external).



### Forwarding Kubernetes API audit logs to a resource in the {{site.data.keyword.cloud_notm}} private network
{: #audit-api-server-priv}

Forward audit logs to a resource other than {{site.data.keyword.la_short}} that is outside of your cluster and accessible in the {{site.data.keyword.cloud_notm}} private network.
{: shortdesc}

Before you begin, ensure that you reviewed the [considerations and prerequisites](#prereqs-apiserver-logs).

1. Create a new directory `kube-audit-forwarder` and create a file `haproxy.cfg` in it with the following contents. Do not forget to replace `<REMOTE-IP>:<REMOTE-PORT>` in the file to the IP address and port of your remote log consumer.
    ```sh
    global
      log stdout format raw local0 info
    defaults
      mode http
      timeout client 10s
      timeout connect 5s
      timeout server 10s
      timeout http-request 10s
      log global
    frontend myfrontend
      bind :3000
      default_backend remotelogstash
    # Use remote log consumer IP and port here
    backend remotelogstash
      server s1 <REMOTE-IP>:<REMOTE-PORT> check
    ```
    {: codeblock}

    If your log consumer server is enforcing secure connection (TLS), you can add your certificate files to this directory and change the backend section in `haproxy.cfg` to use these files. For more information, see the [HAProxy documentation](https://haproxy-ingress.github.io/docs/){: external}.
    {: tip}

2. Create a configmap from the contents of `kube-audit-forwarder` directory.
    ```sh
    kubectl create configmap kube-audit-forwarder-cm --from-file=kube-audit-forwarder
    ```
    {: pre}

3. Create a configuration file that is named `kube-audit-forwarder-remote-private-ip.yaml`. This configuration file creates a deployment and a service that forwards audit logs from the cluster to the IP address of the remote resource through the {{site.data.keyword.cloud_notm}} private network.
    ```yaml
    kind: Deployment
    apiVersion: apps/v1
    metadata:
      labels:
        app: kube-audit-forwarder
      name: kube-audit-forwarder
    spec:
      revisionHistoryLimit: 2
      selector:
        matchLabels:
          app: kube-audit-forwarder
      strategy:
        rollingUpdate:
          maxUnavailable: 1
        type: RollingUpdate
      template:
        metadata:
          labels:
            app: kube-audit-forwarder
        spec:
          containers:
          - image: haproxytech/haproxy-alpine:2.6
            imagePullPolicy: IfNotPresent
            name: haproxy
            volumeMounts:
            - name: config-volume
              mountPath: /usr/local/etc/haproxy/haproxy.cfg
              subPath: haproxy.cfg
          volumes:
          - name: config-volume
            configMap:
              name: kube-audit-forwarder-cm
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: kube-audit-forwarder
    spec:
      selector:
        app: kube-audit-forwarder
      ports:
        - protocol: TCP
          port: 80
          targetPort: 3000
    ```
    {: codeblock}

    If you added certificate files to the `kube-audit-forwarder` in the previous step, do not forget to list those files in `volumeMounts` section as a `subPath`.
    {: tip}

4. Create the deployment and service.
    ```sh
    kubectl create -f kube-audit-forwarder-remote-private-ip.yaml
    ```
    {: pre}

5. Verify that the `kube-audit-forwarder` deployment and service is deployed in your cluster.
    ```sh
    kubectl get svc
    ```
    {: pre}

    Example output

    ```sh
    NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
    ...
    kube-audit-forwarder  ClusterIP   10.xxx.xx.xxx   <none>        80/TCP           1m
    ```
    {: screen}

    ```sh
    kubectl get deployment
    ```
    {: pre}

    Example output

    ```sh
    NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
    ...
    kube-audit-forwarder   1/1     1            1           6m27s
    ```
    {: screen}

6. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure) Make sure to specify the `--admin` option to download the `client-certificate` and the `client-key` files to your local machine. These files are used later to configure the audit webhook.
    ```sh
    ibmcloud ks cluster config --cluster <cluster> --admin
    ```
    {: pre}
    
7. Query the `certificate-authority` of the cluster and save it into a file.
   ```sh
    ibmcloud ks cluster ca get -c <cluster> --output json | jq -r .caCert | base64 -D > <certificate-authority>
    ```
    {: pre}

8. View your current config by running the `kubectl config view` command and review the output for the `client-certificate` and `client-key`.
    ```sh
    kubectl config view --minify
    ```
    {: pre}
    
    Example output
    
    ```sh
    clusters:
    - cluster:
        ...
        ...
        client-certificate: /Users/user/.bluemix/plugins/container-service/clusters/cluster-name-a111a11a11aa1aa11a11-admin/admin.pem
        client-key: /Users/user/.bluemix/plugins/container-service/clusters/cluster-name-a111a11a11aa1aa11a11-admin/admin-key.pem
    ```
    {: screen}

9. Configure the audit webhook and specify the `certificate-authority`, `client-certificate`, and `client-key` that you retrieved in the steps 5-7.
    ```sh
    ibmcloud ks cluster master audit-webhook set --cluster <cluster> --remote-server https://127.0.0.1:2040/api/v1/namespaces/default/services/kube-audit-forwarder/proxy/post --ca-cert <certificate-authority> --client-cert <client-certificate> --client-key <client-key>
    ```
    {: pre}

10. Verify that the audit webhook is created in your cluster.
    ```sh
    ibmcloud ks cluster master audit-webhook get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    OK
    Server:            https://127.0.0.1:2040/api/v1/namespaces/default/services/kube-audit-forwarder/proxy/post
    Policy:            default
    ```
    {: screen}

11. Apply the webhook to your Kubernetes API server by refreshing the cluster master. The master might take several minutes to refresh.
    ```sh
    ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

After the master refresh completes, your logs are sent to the private IP address of your logging resource.



### Forwarding Kubernetes API audit logs to an external server on the public Internet
{: #audit-api-server-external}

To audit any events that are passed through your Kubernetes API server, you can create a configuration that uses Fluentd to forward events to an external server.
{: shortdesc}

To see how Fluentd is used, see [Understanding log forwarding to an external server](/docs/containers?topic=containers-health#logging).

Before you begin, ensure that you reviewed the [considerations and prerequisites](#prereqs-apiserver-logs). Note that [log filters](/docs/containers?topic=containers-health#filter-logs) are not supported.

1. Set up the webhook. If you don't provide any information in the options, a default configuration is used.

    ```sh
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
    {: caption="Table 1. Understanding this command's components" caption-side="bottom"}

2. Verify that log forwarding was enabled by viewing the URL for the remote logging service.

    ```sh
    ibmcloud ks cluster master audit-webhook get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output

    ```sh
    OK
    Server:            https://8.8.8.8
    ```
    {: screen}

3. Apply the configuration update by restarting the Kubernetes master.

    ```sh
    ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. Optional: If you want to stop forwarding audit logs, you can disable your configuration.
    1. For the cluster that you want to stop collecting API server audit logs from: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2. Disable the webhook back-end configuration for the cluster's API server.

        ```sh
        ibmcloud ks cluster master audit-webhook unset --cluster <cluster_name_or_ID>
        ```
        {: pre}

    3. Apply the configuration update by restarting the Kubernetes master.

        ```sh
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


