---

copyright:
  years: 2014, 2021
lastupdated: "2021-05-14"

keywords: kubernetes, iks, logmet, logs, metrics, audit, events

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}
 

# Reviewing service, API server, and worker node logs
{: #health-audit}

Forward audit logs for {{site.data.keyword.containerlong_notm}}, the Kubernetes API server, and the worker nodes to a logging instance such as {{site.data.keyword.at_full}}. With audit logs, you're able to understand better what operations are initiated by users in your cluster, which can help you troubleshoot issues or report compliance to industry and internal standards.
{: shortdesc}

## Kubernetes API server audit logs
{: #audit-api-server}

To monitor user-initiated, Kubernetes administrative activity made within your cluster, you can collect and forward audit events that are passed through your Kubernetes API server to {{site.data.keyword.la_full_notm}} or an external server. Although the Kubernetes API server for your cluster is enabled for auditing by default, no auditing data is available until you set up log forwarding.
{: shortdesc}

### Understanding the Kubernetes API audit configuration
{: #api-server-config}

To review the Kubernetes API audit configuration, review the following information.
* To see how the audit webhook collects logs, check out the {{site.data.keyword.containerlong_notm}} [`kube-audit` policy](https://github.com/IBM-Cloud/kube-samples/blob/master/kube-audit/kube-audit-policy.yaml){: external}.
  You cannot modify the default policy or apply your own custom policy.
  {: note}
* For Kubernetes audit logs and verbosity, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/){: external}.

### Forwarding Kubernetes API audit logs to {{site.data.keyword.la_short}}
{: #audit-api-server-la}

To set up your cluster to forward audit logs to {{site.data.keyword.la_full_notm}}, you can create a Kubernetes audit system by using the provided image and deployment.
{: shortdesc}

The Kubernetes audit system in your cluster consists of an audit webhook, a log collection service and webserver app, and a logging agent. The webhook collects the Kubernetes API server events from your cluster master. The log collection service is a Kubernetes `ClusterIP` service that is created from an image from the public {{site.data.keyword.cloud_notm}} registry. This service exposes a simple `node.js` HTTP webserver app that is exposed only on the private network. The webserver app parses the log data from the audit webhook and creates each log as a unique JSON line. Finally, the logging agent forwards the logs from the webserver app to {{site.data.keyword.la_full_notm}}, where you can view the logs.

For more information, see the following topics:
* To see how the audit webhook collects logs, check out the {{site.data.keyword.containerlong_notm}} [`kube-audit` policy](https://github.com/IBM-Cloud/kube-samples/blob/master/kube-audit/kube-audit-policy.yaml){: external}.
  You cannot modify the default policy or apply your own custom policy.
  {: note}
* For Kubernetes audit logs and verbosity, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/){: external}.

**Before you begin**:

* You must have the following permissions:
  * [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform access role](/docs/containers?topic=containers-users#platform) for the {{site.data.keyword.containerlong_notm}} cluster.
  * [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform access role](/docs/account?topic=account-userroles) for {{site.data.keyword.la_full_notm}}.
* For the cluster that you want to collect API server audit logs from: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
* Keep in mind that only one audit webhook can be created in a cluster. You can set up an audit webhook to forward logs to {{site.data.keyword.la_full_notm}} or to forward logs to an external syslog server, but not both.

**To forward Kubernetes API audit logs to {{site.data.keyword.la_full_notm}}:**

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

  Example output:
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

  Example output:
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

  Example output:
  ```
  OK
  Server:			http://172.21.xxx.xxx
  ```
  {: screen}

9. Apply the webhook to your Kubernetes API server by refreshing the cluster master. It might take several minutes for the master to refresh.
  ```
  ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

10. While the master refreshes, [provision an instance of {{site.data.keyword.la_full_notm}} and deploy a logging agent to every worker node in your cluster](/docs/log-analysis?topic=log-analysis-kube#kube). The logging agent is required to forward logs from inside your cluster to the {{site.data.keyword.la_full_notm}} service. If you already set up logging agents in your cluster, you can skip this step.

11. After the master refresh completes and the logging agents are running on your worker nodes, you can [view your Kubernetes API audit logs in {{site.data.keyword.la_full_notm}}](/docs/log-analysis?topic=log-analysis-kube#kube_step4).



### Forwarding Kubernetes API audit logs to an external server
{: #audit-api-server-external}



To audit any events that are passed through your Kubernetes API server, you can create a configuration that uses Fluentd to forward events to your external server.
{: shortdesc}

For more information, see the following topics:
* To see how Fluentd is used, see [Understanding log forwarding to an external server](/docs/containers?topic=containers-health#logging).
* To see how the audit webhook collects logs, check out the {{site.data.keyword.containerlong_notm}} [`kube-audit` policy](https://github.com/IBM-Cloud/kube-samples/blob/master/kube-audit/kube-audit-policy.yaml){: external}.
* For Kubernetes audit logs and verbosity, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/){: external}.

You cannot modify the default `kube-audit` policy or apply your own custom policy.
{: note}

**Limitations**:
* [Filters](/docs/containers?topic=containers-health#filter-logs) are not supported.
* Keep in mind that only one audit webhook can be created in a cluster. You can set up an audit webhook to forward logs to {{site.data.keyword.at_full_notm}} or to forward logs to an external syslog server, but not both.

**Before you begin**:
1. Set up a remote logging server where you can forward the logs. For example, you can [use Logstash with Kubernetes](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend){: external} to collect audit events.
2.  For the cluster that you want to collect API server audit logs from:
    1. Make sure that you have the [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform access role](/docs/containers?topic=containers-users#platform) for the cluster.
    2. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

**To forward Kubernetes API audit logs**:

1. Set up the webhook. If you do not provide any information in the flags, a default configuration is used.

    ```
    ibmcloud ks cluster master audit-webhook set --cluster <cluster_name_or_ID> --remote-server <server_URL_or_IP> --ca-cert <CA_cert_path> --client-cert <client_cert_path> --client-key <client_key_path>
    ```
    {: pre}

  <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
  <caption>Understanding this command's components</caption>
  <col width="20%">
  <thead>
  <th>Parameter</th>
  <th>Description</th>
    </thead>
    <tbody>
      <tr>
        <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
        <td>The name or ID of the cluster.</td>
      </tr>
      <tr>
        <td><code><em>&lt;server_URL&gt;</em></code></td>
        <td>The URL or IP address for the remote logging service that you want to send logs to. Certificates are ignored if you provide an unsecure server URL.</td>
      </tr>
      <tr>
        <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
        <td>The file path for the CA certificate that is used to verify the remote logging service.</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_cert_path&gt;</em></code></td>
        <td>The file path for the client certificate that is used to authenticate against the remote logging service.</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_key_path&gt;</em></code></td>
        <td>The file path for the corresponding client key that is used to connect to the remote logging service.</td>
      </tr>
    </tbody>
  </table>

2. Verify that log forwarding was enabled by viewing the URL for the remote logging service.

    ```
    ibmcloud ks cluster master audit-webhook get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example output:
    ```
    OK
    Server:			https://8.8.8.8
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



<br />



## Service audit logs
{: #audit-service}

By default, {{site.data.keyword.containerlong_notm}} generates and sends events to {{site.data.keyword.at_full_notm}}. To see these events, you must create an {{site.data.keyword.at_full_notm}} instance. For more information, see [{{site.data.keyword.at_full_notm}} events](/docs/containers?topic=containers-at_events).
