---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks, logmet, logs, metrics

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# Logging and monitoring
{: #health}

Set up logging and monitoring in {{site.data.keyword.containerlong}} to help you troubleshoot issues and improve the health and performance of your Kubernetes clusters and apps.
{: shortdesc}

Continuous monitoring and logging is the key to detecting attacks on your cluster and troubleshooting issues as they arise. By continuously monitoring your cluster, you're able to better understand your cluster capacity and the availability of resources that are available to your app. With this insight, you can prepare to protect your apps against downtime. **Note**: To configure logging and monitoring, you must use a standard cluster in {{site.data.keyword.containerlong_notm}}.



## Choosing a logging solution
{: #logging_overview}

By default, logs are generated and written locally for all of the following {{site.data.keyword.containerlong_notm}} cluster components: worker nodes, containers, applications, persistent storage, Ingress application load balancer, Kubernetes API, and the `kube-system` namespace. Several logging solutions are available to collect, forward, and view these logs.
{: shortdesc}

You can choose your logging solution based on which cluster components you need to collect logs for. A common implementation is to choose a logging service that you prefer based on its analysis and interface capabilities, such as {{site.data.keyword.loganalysisfull}}, {{site.data.keyword.la_full}}, or a third-party service. You can then use {{site.data.keyword.cloudaccesstrailfull}} to audit user activity in the cluster and backup cluster master logs to {{site.data.keyword.cos_full}}. **Note**: To configure logging, you must have a standard Kubernetes cluster.

<dl>

<dt>{{site.data.keyword.la_full_notm}}</dt>
<dd>Manage pod container logs by deploying LogDNA as a third-party service to your cluster. To use {{site.data.keyword.la_full_notm}}, you must deploy a logging agent to every worker node in your cluster. This agent collects logs with the extension `*.log` and extensionless files that are stored in the `/var/log` directory of your pod from all namespaces, including `kube-system`. The agent then forwards the logs to the {{site.data.keyword.la_full_notm}} service. For more information about the service, see the [{{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about) documentation. To get started, see [Managing Kubernetes cluster logs with {{site.data.keyword.loganalysisfull_notm}} with LogDNA](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube).</dd>

<dt>Fluentd with {{site.data.keyword.loganalysisfull_notm}} or syslog</dt>
<dd>To collect, forward, and view logs for a cluster component, you can create a logging configuration by using Fluentd. When you create a logging configuration, the [Fluentd ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.fluentd.org/) cluster add-on collects logs from the paths for a specified source. Fluentd then forwards these logs to {{site.data.keyword.loganalysisfull_notm}} or an external syslog server.

<ul><li><strong>{{site.data.keyword.loganalysisfull_notm}}</strong>: [{{site.data.keyword.loganalysisshort}}](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_analysis_ov) expands your log collection, retention, and search abilities. When you create a logging configuration that forwards logs for a source to {{site.data.keyword.loganalysisshort_notm}}, you can view your logs in a Kibana dashboard.<p class="deprecated">{{site.data.keyword.loganalysisfull_notm}} is deprecated. As of 30 April 2019, you cannot provision new {{site.data.keyword.loganalysisshort_notm}} instances, and all Lite plan instances are deleted. Existing premium plan instances are supported until 30 September 2019. To continue collecting logs for your cluster, you can forward logs collected by Fluentd to an external syslog server or set up {{site.data.keyword.la_full_notm}}.</p></li>

<li><strong>External syslog server</strong>: Set up an external server that accepts a syslog protocol. Then, you can create a logging configuration for a source in your cluster to forward logs to that external server.</li></ul>

To get started, see [Understanding cluster and app log forwarding](#logging).
</dd>

<dt>{{site.data.keyword.cloudaccesstrailfull_notm}}</dt>
<dd>To monitor user-initiated administrative activity made in your cluster, you can collect and forward audit logs to {{site.data.keyword.cloudaccesstrailfull_notm}}. Clusters generate two types of {{site.data.keyword.cloudaccesstrailshort}} events.

<ul><li>Cluster management events are automatically generated and forwarded to {{site.data.keyword.cloudaccesstrailshort}}.</li>

<li>Kubernetes API server audit events are automatically generated, but you must [create a logging configuration](#api_forward) so that Fluentd can forward these logs to {{site.data.keyword.cloudaccesstrailshort}}.</li></ul>

For more information about the types of {{site.data.keyword.containerlong_notm}} events that you can track, see [Activity Tracker events](/docs/containers?topic=containers-at_events). For more information about the service, see the [Activity Tracker](/docs/services/cloud-activity-tracker?topic=cloud-activity-tracker-getting-started-with-cla) documentation.
</dd>

<dt>{{site.data.keyword.cos_full_notm}}</dt>
<dd>To collect, forward, and view logs for your cluster's Kubernetes master, you can take a snapshot of your master logs at any point in time to collect in an {{site.data.keyword.cos_full_notm}} bucket. The snapshot includes anything that is sent through the API server, such as pod scheduling, deployments, or RBAC policies. To get started, see [Collecting master logs](#collect_master).</dd>

<dt>Third-party services</dt>
<dd>If you have special requirements, you can set up your own logging solution. Check out third-party logging services that you can add to your cluster in [Logging and monitoring integrations](/docs/containers?topic=containers-supported_integrations#health_services). In clusters that run Kubernetes version 1.11 or later, you can collect container logs from the `/var/log/pods/` path. In clusters that run Kubernetes version 1.10 or earlier, you can collect container logs from the `/var/lib/docker/containers/` path.</dd>

</dl>

## Understanding cluster and app log forwarding to syslog
{: #logging}

By default, logs are collected by the [Fluentd ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.fluentd.org/) add-on in your cluster. When you create a logging configuration for a source in your cluster such as a container, the logs that Fluentd collects from that source's paths are forwarded to {{site.data.keyword.loganalysisshort_notm}} or to an external syslog server. The traffic from the source to the logging service on the ingestion port is encrypted.
{: shortdesc}

{{site.data.keyword.loganalysisfull_notm}} is deprecated. As of 30 April 2019, you cannot provision new {{site.data.keyword.loganalysisshort_notm}} instances, and all Lite plan instances are deleted. Existing premium plan instances are supported until 30 September 2019. To continue collecting logs for your cluster, you can forward logs collected by Fluentd to an external syslog server or set up {{site.data.keyword.la_full_notm}}.
{: deprecated}

**What are the sources that I can configure log forwarding for?**

In the following image you can see the location of the sources that you can configure logging for.

<img src="images/log_sources.png" width="600" alt="Log sources in your cluster" style="width:600px; border-style: none"/>

1. `worker`: Information that is specific to the infrastructure configuration that you have for your worker node. Worker logs are captured in syslog and contain operating system events. In `auth.log` you can find information on the authentication requests that are made to the OS.</br>**Paths**:
    * `/var/log/syslog`
    * `/var/log/auth.log`

2. `container`: Information that is logged by a running container.</br>**Paths**: Anything written to `STDOUT` or `STDERR`.

3. `application`: Information about events that occur at the application level. This could be a notification that an event has taken place such as a successful login, a warning about storage, or other operations that can be performed at the app level.</br>**Paths**: You can set the paths that your logs are forwarded to. However, in order for logs to be sent, you must use an absolute path in your logging configuration or the logs cannot be read. If your path is mounted to your worker node, it might have created a symlink. Example: If the specified path is `/usr/local/spark/work/app-0546/0/stderr` but the logs actually go to `/usr/local/spark-1.0-hadoop-1.2/work/app-0546/0/stderr`, then the logs cannot be read.

4. `storage`: Information about persistent storage that is set up in your cluster. Storage logs can help you set up problem determination dashboards and alerts as part of your DevOps pipeline and production releases. **Note**: The paths `/var/log/kubelet.log` and `/var/log/syslog` also contain storage logs, but logs from these paths are collected by the `kubernetes` and `worker` log sources.</br>**Paths**:
    * `/var/log/ibmc-s3fs.log`
    * `/var/log/ibmc-block.log`

  **Pods**:
    * `portworx-***`
    * `ibmcloud-block-storage-attacher-***`
    * `ibmcloud-block-storage-driver-***`
    * `ibmcloud-block-storage-plugin-***`
    * `ibmcloud-object-storage-plugin-***`

5. `kubernetes`: Information from the kubelet, the kube-proxy, and other Kubernetes events that happen in the kube-system namespace of the worker node.</br>**Paths**:
    * `/var/log/kubelet.log`
    * `/var/log/kube-proxy.log`
    * `/var/log/event-exporter/1..log`

6. `kube-audit`: Information about cluster-related actions that is sent to the Kubernetes API server, including the time, the user, and the affected resource.

7. `ingress`: Information about the network traffic that comes into a cluster through the Ingress ALB.</br>**Paths**:
    * `/var/log/alb/ids/*.log`
    * `/var/log/alb/ids/*.err`
    * `/var/log/alb/customerlogs/*.log`
    * `/var/log/alb/customerlogs/*.err`

</br>

**What configuration options do I have?**

The following table shows the different options that you have when configuring logging and their descriptions.

<table>
<caption> Understanding logging configuration options</caption>
  <thead>
    <th>Option</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
      <td>The name or ID of the cluster.</td>
    </tr>
    <tr>
      <td><code><em>--log_source</em></code></td>
      <td>The source that you want to forward logs from. Accepted values are <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code>, <code>storage</code>, and <code>kube-audit</code>. This argument supports a comma separated list of log sources to apply the configuration for. If you do not provide a log source, logging configurations are created for <code>container</code> and <code>ingress</code> log sources.</td>
    </tr>
    <tr>
      <td><code><em>--type</em></code></td>
      <td>Where you want to forward your logs. Options are <code>ibm</code>, which forwards your logs to {{site.data.keyword.loganalysisshort_notm}} and <code>syslog</code>, which forwards your logs to an external server. <p class="deprecated">{{site.data.keyword.loganalysisfull_notm}} is deprecated. Existing premium plan instances are supported until 30 September 2019. Forward logs to an external syslog server by using <code>--type syslog</code>.</td>
    </tr>
    <tr>
      <td><code><em>--namespace</em></code></td>
      <td>Optional: The Kubernetes namespace that you want to forward logs from. Log forwarding is not supported for the <code>ibm-system</code> and <code>kube-system</code> Kubernetes namespaces. This value is valid only for the <code>container</code> log source. If you do not specify a namespace, then all namespaces in the cluster use this configuration.</td>
    </tr>
    <tr>
      <td><code><em>--hostname</em></code></td>
      <td><p>For {{site.data.keyword.loganalysisshort_notm}}, use the [ingestion URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls). If you do not specify an ingestion URL, the endpoint for the region in which you created your cluster is used.</p>
      <p>For syslog, specify the host name or IP address of the log collector service.</p></td>
    </tr>
    <tr>
      <td><code><em>--port</em></code></td>
      <td>The ingestion port. If you do not specify a port, then the standard port <code>9091</code> is used.
      <p>For syslog, specify the port of the log collector server. If you do not specify a port, then the standard port <code>514</code> is used.</td>
    </tr>
    <tr>
      <td><code><em>--space</em></code></td>
      <td>Optional: The name of the Cloud Foundry space that you want to send logs to. When forwarding logs to {{site.data.keyword.loganalysisshort_notm}}, the space and org are specified in the ingestion point. If you do not specify a space, logs are sent to the account level. If you do specify a space, then you must also specify an org.</td>
    </tr>
    <tr>
      <td><code><em>--org</em></code></td>
      <td>Optional: The name of the Cloud Foundry org that the space is in. This value is required if you specified a space.</td>
    </tr>
    <tr>
      <td><code><em>--app-containers</em></code></td>
      <td>Optional: To forward logs from apps, you can specify the name of the container that contains your app. You can specify more than one container by using a comma-separated list. If no containers are specified, logs are forwarded from all of the containers that contain the paths that you provided.</td>
    </tr>
    <tr>
      <td><code><em>--app-paths</em></code></td>
      <td>The path on a container that the apps log to. To forward logs with source type <code>application</code>, you must provide a path. To specify more than one path, use a comma-separated list. Example: <code>/var/log/myApp1/*,/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>--syslog-protocol</em></code></td>
      <td>When the logging type is <code>syslog</code>, the transport layer protocol. You can use the following protocols: `udp`, `tls`, or `tcp`. When forwarding to an rsyslog server with the <code>udp</code> protocol, logs that are over 1KB are truncated.</td>
    </tr>
    <tr>
      <td><code><em>--ca-cert</em></code></td>
      <td>Required: When the logging type is <code>syslog</code> and the protocol is <code>tls</code>, the Kubernetes secret name that contains the Certificate Authority certificate.</td>
    </tr>
    <tr>
      <td><code><em>--verify-mode</em></code></td>
      <td>When the logging type is <code>syslog</code> and the protocol is <code>tls</code>, the verification mode. Supported values are <code>verify-peer</code> and the default <code>verify-none</code>.</td>
    </tr>
    <tr>
      <td><code><em>--skip-validation</em></code></td>
      <td>Optional: Skip the validation of the org and space names when they are specified. Skipping validation decreases processing time, but an invalid logging configuration will not correctly forward logs.</td>
    </tr>
  </tbody>
</table>

**Am I responsible for keeping Fluentd updated?**

In order to make changes to your logging or filter configurations, the Fluentd logging add-on must be at the latest version. By default, automatic updates to the add-on are enabled. To disable automatic updates, see [Updating cluster add-ons: Fluentd for logging](/docs/containers?topic=containers-update#logging-up).

**Can I forward some logs, but not others, from one source in my cluster?**

Yes. For example, if you have a particularly chatty pod, you might want to prevent logs from that pod from taking up log storage space, while still allowing other pods' logs to be forwarded. To prevent logs from a specific pod from being forwarded, see [Filtering logs](#filter-logs).

**Multiple teams work in one cluster. How can I separate logs by team?**

You can forward container logs from one namespace to one Cloud Foundry space, and container logs from another namespace to a different Cloud Foundry space. For each namespace, create a log forwarding configuration for the `container` log source. Specify the team's namespace that you want to apply the configuration to in the `--namespace` flag, and the team's space that the logs are forwarded to in the `--space` flag. You can also optionally specify a Cloud Foundry org within the space in the `--org` flag.

<br />


## Forwarding cluster and app logs to syslog
{: #configuring}

You can configure logging for {{site.data.keyword.containerlong_notm}} standard clusters through the console or through the CLI.
{: shortdesc}

{{site.data.keyword.loganalysisfull_notm}} is deprecated. As of 30 April 2019, you cannot provision new {{site.data.keyword.loganalysisshort_notm}} instances, and all Lite plan instances are deleted. Existing premium plan instances are supported until 30 September 2019. To continue collecting logs for your cluster, you can forward logs collected by Fluentd to an external syslog server or set up {{site.data.keyword.la_full_notm}}.
{: deprecated}

### Enabling log forwarding with the {{site.data.keyword.Bluemix_notm}} console
{: #enable-forwarding-ui}

You can configure log forwarding in the {{site.data.keyword.containerlong_notm}} dashboard. It can take a few minutes for the process to complete, so if you don't see logs immediately, try waiting a few minutes and then check back.
{: shortdesc}

To create a configuration at the account level, for a specific container namespace, or for app logging use the CLI.
{: tip}

Before you begin, [create](/docs/containers?topic=containers-clusters#clusters) or identify a standard cluster to use.

1. Log in to the [{{site.data.keyword.Bluemix_notm}} console](https://cloud.ibm.com/kubernetes/clusters) and navigate to **Kubernetes > Clusters**.
2. Select your standard cluster and from the **Overview** tab **Logs** field, click **Enable**.
3. Select the **Cloud Foundry Org** and **Space** from which you want to forward logs. When you configure log forwarding in the dashboard, logs are sent to the default {{site.data.keyword.loganalysisshort_notm}} endpoint for your cluster. To forward logs to an external server, or to another {{site.data.keyword.loganalysisshort_notm}} endpoint, you can use the CLI to configure logging.
4. Select the **Log sources** from which you want to forward logs.
5. Click **Create**.

</br>
</br>

### Enabling log forwarding with the CLI
{: #enable-forwarding}

You can create a configuration for cluster logging. You can differentiate between the different logging options by using flags.
{: shortdesc}

Before you begin, [create](/docs/containers?topic=containers-clusters#clusters) or identify a standard cluster to use.

**Forwarding logs to your own server over the `udp` or `tcp` protocols**

1. Ensure you have the [**Editor** or **Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](/docs/containers?topic=containers-users#platform).

2. For the cluster where the log source is located: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. To forward logs to syslog, set up a server that accepts a syslog protocol in one of two ways:
  * Set up and manage your own server or have a provider manage it for you. If a provider manages the server for you, get the logging endpoint from the logging provider.

  * Run syslog from a container. For example, you can use this [deployment .yaml file ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) to fetch a Docker public image that runs a container in your cluster. The image publishes the port `514` on the public cluster IP address, and uses this public cluster IP address to configure the syslog host.

  You can see your logs as valid JSON by removing syslog prefixes. To do so, add the following code to the top of your <code>etc/rsyslog.conf</code> file where your rsyslog server is running: <code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

4. Create a log forwarding configuration.
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br></br>

**Forwarding logs to your own server over the `tls` protocol**

The following steps are general instructions. Prior to using the container in a production environment, be sure that any security requirements that you need, are met.
{: tip}

1. Ensure you have the following [{{site.data.keyword.Bluemix_notm}} IAM roles](/docs/containers?topic=containers-users#platform):
    * **Editor** or **Administrator** platform role for the cluster
    * **Writer** or **Manager** service role for the `kube-system` namespace

2. For the cluster where the log source is located: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. Set up a server that accepts a syslog protocol in one of two ways:
  * Set up and manage your own server or have a provider manage it for you. If a provider manages the server for you, get the logging endpoint from the logging provider.

  * Run syslog from a container. For example, you can use this [deployment .yaml file ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) to fetch a Docker public image that runs a container in your cluster. The image publishes the port `514` on the public cluster IP address, and uses this public cluster IP address to configure the syslog host. You must inject the relevant Certificate Authority and server-side certificates and update the `syslog.conf` to enable `tls` on your server.

4. Save your Certificate Authority certificate to a file named `ca-cert`. It must be that exact name.

5. Create a secret in the `kube-system` namespace for the `ca-cert` file. When you create your logging configuration, you will use the secret name for the `--ca-cert` flag.
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

6. Create a log forwarding configuration.
    ```
    ibmcloud ks logging-config-create <cluster name or id> --logsource <log source> --type syslog --syslog-protocol tls --hostname <ip address of syslog server> --port <port for syslog server, 514 is default> --ca-cert <secret name> --verify-mode <defaults to verify-none>
    ```
    {: pre}

</br></br>

**Forwarding logs to {{site.data.keyword.loganalysisfull_notm}}**

{{site.data.keyword.loganalysisfull_notm}} is deprecated. As of 30 April 2019, you cannot provision new {{site.data.keyword.loganalysisshort_notm}} instances, and all Lite plan instances are deleted. Existing premium plan instances are supported until 30 September 2019. To continue collecting logs for your cluster, you can forward logs collected by Fluentd to an external syslog server or set up {{site.data.keyword.la_full_notm}}.
{: deprecated}

1. Verify permissions.
    1. Ensure you have the [**Editor** or **Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](/docs/containers?topic=containers-users#platform).
    2. If you specified a space when you created the cluster, both you and the {{site.data.keyword.containerlong_notm}} API key owner need the [**Developer** Cloud Foundry role](/docs/iam?topic=iam-mngcf) in that space.
      * If you don't know who the {{site.data.keyword.containerlong_notm}} API key owner is, run the following command.
          ```
          ibmcloud ks api-key-info --cluster <cluster_name>
          ```
          {: pre}
      * If you change permissions, you can immediately apply the changes by running the following command.
          ```
          ibmcloud ks logging-config-refresh --cluster <cluster_name>
          ```
          {: pre}

2.  For the standard cluster where the log source is located: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

3. Create a log forwarding configuration.
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --type ibm --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs> --skip-validation
    ```
    {: pre}

  * Example container logging configuration for the default namespace and output:
    ```
    ibmcloud ks logging-config-create mycluster
    Creating cluster mycluster logging configurations...
    OK
    ID                                      Source      Namespace    Host                                 Port    Org  Space   Server Type   Protocol   Application Containers   Paths
    4e155cf0-f574-4bdb-a2bc-76af972cae47    container       *        ingest.logging.eu-gb.bluemix.net✣   9091✣    -     -        ibm           -                  -               -
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

  * Example application logging configuration and output:
    ```
    ibmcloud ks logging-config-create cluster2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'container1,container2,container3'
    Creating logging configuration for application logs in cluster cluster2...
    OK
    Id                                     Source        Namespace   Host                                    Port    Org   Space   Server Type   Protocol   Application Containers               Paths
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

If you have apps that run in your containers that can't be configured to write logs to STDOUT or STDERR, you can create a logging configuration to forward logs from app log files.
{: tip}

</br></br>

### Verifying log forwarding
{: verify-logging}

You can verify that your configuration is set up correctly in one of two ways:

* To list all of the logging configurations in a cluster:
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

* To list the logging configurations for one type of log source:
    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br></br>

### Updating log forwarding
{: #updating-forwarding}

You can update a logging configuration that you already created.
{: shortdesc}

1. Update a log forwarding configuration.
    ```
    ibmcloud ks logging-config-update --cluster <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### Stopping log forwarding
{: #log_sources_delete}

You can stop forwarding logs one or all of the logging configurations for a cluster.
{: shortdesc}

1. For the cluster where the log source is located: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

2. Delete the logging configuration.
  <ul>
  <li>To delete one logging configuration:</br>
    <pre><code>ibmcloud ks logging-config-rm --cluster &lt;cluster_name_or_ID&gt; --id &lt;log_config_ID&gt;</pre></code></li>
  <li>To delete all of the logging configurations:</br>
    <pre><code>ibmcloud ks logging-config-rm --cluster <my_cluster> --all</pre></code></li>
  </ul>

</br>
</br>

### Viewing logs
{: #view_logs}

To view logs for clusters and containers, you can use the standard Kubernetes and container runtime logging features.
{:shortdesc}

**{{site.data.keyword.loganalysislong_notm}}**
{: #view_logs_k8s}

You can view the logs that you forwarded to {{site.data.keyword.loganalysislong_notm}} through the Kibana dashboard.
{: shortdesc}

If you used the default values to create your configuration file, then your logs can be found in the account, or org and space, in which the cluster was created. If you specified an org and space in your configuration file, then you can find your logs in that space. For more information about logging, see [Logging for {{site.data.keyword.containerlong_notm}}](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes).

To access the Kibana dashboard, go to one of the following URLs and select the {{site.data.keyword.Bluemix_notm}} account or space where you configured log forwarding for the cluster.
- US-South and US-East: `https://logging.ng.bluemix.net`
- UK-South: `https://logging.eu-gb.bluemix.net`
- EU-Central: `https://logging.eu-fra.bluemix.net`
- AP-South and AP-North: `https://logging.au-syd.bluemix.net`

For more information about viewing logs, see [Navigating to Kibana from a web browser](/docs/services/CloudLogAnalysis/kibana?topic=cloudloganalysis-launch#launch_Kibana_from_browser).

</br>

**Container logs**

You can leverage the built-in container runtime logging capabilities to review activities on the standard STDOUT and STDERR output streams. For more information, see [Viewing container logs for a container that runs in a Kubernetes cluster](/docs/services/CloudLogAnalysis/containers?topic=cloudloganalysis-containers_kubernetes#containers_kubernetes).

<br />


## Filtering logs that are forwarded to syslog
{: #filter-logs}

You can choose which logs that you forward by filtering out specific logs for a period of time. You can differentiate between the different filtering options by using flags.
{: shortdesc}

<table>
<caption>Understanding the options for log filtering</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding log filtering options</th>
  </thead>
  <tbody>
    <tr>
      <td>&lt;cluster_name_or_ID&gt;</td>
      <td>Required: The name or ID of the cluster that you want to filter logs for.</td>
    </tr>
    <tr>
      <td><code>&lt;log_type&gt;</code></td>
      <td>The type of logs that you want to apply the filter to. Currently <code>all</code>, <code>container</code>, and <code>host</code> are supported.</td>
    </tr>
    <tr>
      <td><code>&lt;configs&gt;</code></td>
      <td>Optional: A comma-separated list of your logging configuration IDs. If not provided, the filter is applied to all of the cluster logging configurations that are passed to the filter. You can view log configurations that match the filter by using the <code>--show-matching-configs</code> option.</td>
    </tr>
    <tr>
      <td><code>&lt;kubernetes_namespace&gt;</code></td>
      <td>Optional: The Kubernetes namespace that you want to forward logs from. This flag applies only when you are using log type <code>container</code>.</td>
    </tr>
    <tr>
      <td><code>&lt;container_name&gt;</code></td>
      <td>Optional: The name of the container from which you want to filter logs.</td>
    </tr>
    <tr>
      <td><code>&lt;logging_level&gt;</code></td>
      <td>Optional: Filters out logs that are at the specified level and less. Acceptable values in their canonical order are <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code>, and <code>trace</code>. As an example, if you filtered logs at the <code>info</code> level, <code>debug</code>, and <code>trace</code> are also filtered. **Note**: You can use this flag only when log messages are in JSON format and contain a level field. To display your messages in JSON, append the <code>--json</code> flag to the command.</td>
    </tr>
    <tr>
      <td><code>&lt;message&gt;</code></td>
      <td>Optional: Filters out logs that contain a specified message that is written as a regular expression.</td>
    </tr>
    <tr>
      <td><code>&lt;filter_ID&gt;</code></td>
      <td>Optional: The ID of the log filter.</td>
    </tr>
    <tr>
      <td><code>--show-matching-configs</code></td>
      <td>Optional: Show the logging configurations that each filter applies to.</td>
    </tr>
    <tr>
      <td><code>--all</code></td>
      <td>Optional: Delete all of your log forwarding filters.</td>
    </tr>
  </tbody>
</table>

1. Create a logging filter.
  ```
  ibmcloud ks logging-filter-create <cluster_name_or_ID> --type <log_type> --logging-configs <configs> --namespace <kubernetes_namespace> --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

2. View the log filter that you created.

  ```
  ibmcloud ks logging-filter-get --cluster <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. Update the log filter that you created.
  ```
  ibmcloud ks logging-filter-update --cluster <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. Delete a log filter that you created.

  ```
  ibmcloud ks logging-filter-rm --cluster <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## Forwarding Kubernetes API audit logs to {{site.data.keyword.cloudaccesstrailfull_notm}} or syslog
{: #api_forward}

Kubernetes automatically audits any events that are passed through your Kubernetes API server. You can forward the events to {{site.data.keyword.cloudaccesstrailfull_notm}} or to an external server.
{: shortdesc}

For more information about Kubernetes audit logs, see the <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">auditing topic <img src="../icons/launch-glyph.svg" alt="External link icon"></a> in the Kubernetes documentation.

* Currently, a default audit policy is used for all clusters with this logging configuration.
* Currently, filters are not supported.
* There can be only one `kube-audit` configuration per cluster, but you can forward logs to {{site.data.keyword.cloudaccesstrailshort}} and an external server by creating a logging configuration and a webhook.
* You must have the [**Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](/docs/containers?topic=containers-users#platform) for the cluster.

### Forwarding audit logs to {{site.data.keyword.cloudaccesstrailfull_notm}}
{: #audit_enable_loganalysis}

You can forward your Kubernetes API server audit logs to {{site.data.keyword.cloudaccesstrailfull_notm}}.
{: shortdesc}

**Before you begin**

1. Verify permissions. If you specified a space when you created the cluster, then both the account owner and {{site.data.keyword.containerlong_notm}} key owner need Manager, Developer, or Auditor permissions in that space.

2. For the cluster that you want to collect API server audit logs from: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

**Forwarding logs**

1. Create a logging configuration.

    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource kube-audit --space <cluster_space> --org <cluster_org> --hostname <ingestion_URL> --type ibm
    ```
    {: pre}

    Example command and output:

    ```
    ibmcloud ks logging-config-create myCluster --logsource kube-audit
    Creating logging configuration for kube-audit logs in cluster myCluster...
    OK
    Id                                     Source      Namespace   Host                                   Port     Org    Space   Server Type   Protocol  Application Containers   Paths
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -         ingest-au-syd.logging.bluemix.net✣    9091✣     -       -         ibm          -              -                  -

    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

    ```
    {: screen}

    <table>
    <caption>Understanding this command's components</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
      </thead>
      <tbody>
        <tr>
          <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
          <td>The name or ID of the cluster.</td>
        </tr>
        <tr>
          <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
          <td>The endpoint where you want to forward logs. If you do not specify an [ingestion URL](/docs/services/CloudLogAnalysis?topic=cloudloganalysis-log_ingestion#log_ingestion_urls), the endpoint for the region in which you created your cluster is used.</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_space&gt;</em></code></td>
          <td>Optional: The name of the Cloud Foundry space that you want to send logs to. When forwarding logs to {{site.data.keyword.loganalysisshort_notm}}, the space and org are specified in the ingestion point. If you do not specify a space, logs are sent to the account level.</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_org&gt;</em></code></td>
          <td>The name of the Cloud Foundry org that the space is in. This value is required if you specified a space.</td>
        </tr>
      </tbody>
    </table>

2. View your cluster logging configuration to verify that it was implemented the way that you intended.

    ```
    ibmcloud ks logging-config-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Example command and output:
    ```
    ibmcloud ks logging-config-get --cluster myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. Optional: If you want to stop forwarding audit logs, you can [delete your configuration](#log_sources_delete).

### Forwarding audit logs to an external syslog server
{: #audit_enable}

**Before you begin**

1. Set up a remote logging server where you can forward the logs. For example, you can [use Logstash with Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) to collect audit events.

2. For the cluster that you want to collect API server audit logs from: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To forward Kubernetes API audit logs:

1. Set up the webhook. If you do not provide any information in the flags, a default configuration is used.

    ```
    ibmcloud ks apiserver-config-set audit-webhook <cluster_name_or_ID> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

  <table>
  <caption>Understanding this command's components</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
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
    ibmcloud ks apiserver-config-get audit-webhook <cluster_name_or_ID>
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
    ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. Optional: If you want to stop forwarding audit logs, you can disable your configuration.
    1. For the cluster that you want to stop collecting API server audit logs from: [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
    2. Disable the webhook back-end configuration for the cluster's API server.

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. Apply the configuration update by restarting the Kubernetes master.

        ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
        {: pre}

<br />


## Collecting master logs in an {{site.data.keyword.cos_full_notm}} bucket
{: #collect_master}

With {{site.data.keyword.containerlong_notm}}, you can take a snapshot of your master logs at any point in time to collect in an {{site.data.keyword.cos_full_notm}} bucket. The snapshot includes anything that is sent through the API server, such as pod scheduling, deployments, or RBAC policies.
{: shortdesc}

Because Kubernetes API Server logs are automatically streamed, they're also automatically deleted to make room for the new logs coming in. By keeping a snapshot of logs at a specific point in time, you can better troubleshoot issues, look into usage differences, and find patterns to help maintain more secure applications.

**Before you begin**

* [Provision an instance](/docs/services/cloud-object-storage/basics?topic=cloud-object-storage-gs-dev) of {{site.data.keyword.cos_short}} from the {{site.data.keyword.Bluemix_notm}} catalog.
* Ensure you have the [**Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](/docs/containers?topic=containers-users#platform) for the cluster.

**Creating a snapshot**

1. Create an Object Storage bucket through the {{site.data.keyword.Bluemix_notm}} console by following [this getting started tutorial](/docs/services/cloud-object-storage?topic=cloud-object-storage-getting-started-tutorial#gs-create-buckets).

2. Generate [HMAC service credentials](/docs/services/cloud-object-storage/iam?topic=cloud-object-storage-service-credentials) in the bucket that you created.
  1. In the **Service Credentials** tab of the {{site.data.keyword.cos_short}} dashboard, click **New Credential**.
  2. Give the HMAC credentials the `Writer` service role.
  3. In the **Add Inline Configuration Parameters** field, specify `{"HMAC":true}`.

3. Through the CLI, make a request for a snapshot of your master logs.

  ```
  ibmcloud ks logging-collect --cluster <cluster name or ID>  --type <type_of_log_to_collect> --cos-bucket <COS_bucket_name> --cos-endpoint <location_of_COS_bucket> --hmac-key-id <HMAC_access_key_ID> --hmac-key <HMAC_access_key> --type <log_type>
  ```
  {: pre}

  Example command and response:

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

4. Check the status of your request. It can take some time for the snapshot to complete, but you can check to see whether your request is successfully being completed or not. You can find the name of the file that contains your master logs in the response and use the {{site.data.keyword.Bluemix_notm}} console to download the file.

  ```
  ibmcloud ks logging-collect-status --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## Choosing a monitoring solution
{: #view_metrics}

Metrics help you monitor the health and performance of your clusters. You can use the standard Kubernetes and container runtime features to monitor the health of your clusters and apps. **Note**: Monitoring is supported only for standard clusters.
{:shortdesc}

**Does IBM monitor my cluster?**

Every Kubernetes master is continuously monitored by IBM. {{site.data.keyword.containerlong_notm}} automatically scans every node where the Kubernetes master is deployed for vulnerabilities that are found in Kubernetes and OS-specific security fixes. If vulnerabilities are found, {{site.data.keyword.containerlong_notm}} automatically applies fixes and resolves vulnerabilities on behalf of the user to ensure master node protection. You are responsible for monitoring and analyzing the logs for the rest of your cluster components.

To avoid conflicts when using metrics services, be sure that clusters across resource groups and regions have unique names.
{: tip}

<dl>
  <dt>Cluster details page in {{site.data.keyword.Bluemix_notm}}</dt>
    <dd>{{site.data.keyword.containerlong_notm}} provides information about the health and capacity of your cluster and the usage of your cluster resources. You can use this console to scale out your cluster, work with your persistent storage, and add more capabilities to your cluster through {{site.data.keyword.Bluemix_notm}} service binding. To view the cluster details page, go to your **{{site.data.keyword.Bluemix_notm}} Dashboard** and select a cluster.</dd>
  <dt>Kubernetes dashboard</dt>
    <dd>The Kubernetes dashboard is an administrative web interface where you can review the health of your worker nodes, find Kubernetes resources, deploy containerized apps, and troubleshoot apps with logging and monitoring information. For more information about how to access your Kubernetes dashboard, see [Launching the Kubernetes dashboard for {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-app#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>Metrics for standard clusters are located in the {{site.data.keyword.Bluemix_notm}} account that was logged in to when the Kubernetes cluster was created. If you specified an {{site.data.keyword.Bluemix_notm}} space when you created the cluster, then metrics are located in that space. Container metrics are collected automatically for all containers that are deployed in a cluster. These metrics are sent and are made available through Grafana. For more information about metrics, see [Monitoring for the {{site.data.keyword.containerlong_notm}}](/docs/services/cloud-monitoring/containers?topic=cloud-monitoring-monitoring_bmx_containers_ov#monitoring_bmx_containers_ov).</p>
    <p>To access the Grafana dashboard, go to one of the following URLs and select the {{site.data.keyword.Bluemix_notm}} account or space where you created the cluster.</p>
    <table summary="The first row in the table spans both columns. The rest of the rows should be read left to right, with the server zone in column one and IP addresses to match in column two.">
      <caption>IP addresses to open for monitoring traffic</caption>
            <thead>
            <th>{{site.data.keyword.containerlong_notm}} region</th>
            <th>Monitoring address</th>
            <th>Monitoring subnets</th>
            </thead>
          <tbody>
            <tr>
             <td>EU Central</td>
             <td><code>metrics.eu-de.bluemix.net</code></td>
             <td><code>158.177.65.80/30</code></td>
            </tr>
            <tr>
             <td>UK South</td>
             <td><code>metrics.eu-gb.bluemix.net</code></td>
             <td><code>169.50.196.136/29</code></td>
            </tr>
            <tr>
              <td>US East, US South, AP North, AP South</td>
              <td><code>metrics.ng.bluemix.net</code></td>
              <td><code>169.47.204.128/29</code></td>
             </tr>
            </tbody>
          </table> </dd>
  <dt>{{site.data.keyword.mon_full_notm}}</dt>
  <dd>Gain operational visibility into the performance and health of your apps by deploying Sysdig as a third-party service to your worker nodes to forward metrics to {{site.data.keyword.monitoringlong}}. For more information, see [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster).</dd>
</dl>

### Other health monitoring tools
{: #health_tools}

You can configure other tools for more monitoring capabilities.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus is an open source monitoring, logging, and alerting tool that was designed for Kubernetes. The tool retrieves detailed information about the cluster, worker nodes, and deployment health based on the Kubernetes logging information. For setup information, see the [CoreOS instructions ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus).</dd>
</dl>

<br />


## Configuring health monitoring for worker nodes with Autorecovery
{: #autorecovery}

The Autorecovery system uses various checks to query worker node health status. If Autorecovery detects an unhealthy worker node based on the configured checks, Autorecovery triggers a corrective action like an OS reload on the worker node. Only one worker node undergoes a corrective action at a time. The worker node must successfully complete the corrective action before any other worker node undergoes a corrective action. For more information, see this [Autorecovery blog post ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
{: shortdesc}</br> </br>

Autorecovery requires at least one healthy node to function properly. Configure Autorecovery with active checks only in clusters with two or more worker nodes.
{: note}

Before you begin:
- Ensure you have the following [{{site.data.keyword.Bluemix_notm}} IAM roles](/docs/containers?topic=containers-users#platform):
    - **Administrator** platform role for the cluster
    - **Writer** or **Manager** service role for the `kube-system` namespace
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

To configure Autorecovery:

1.  [Follow the instructions](/docs/containers?topic=containers-helm#public_helm_install) to install the Helm client on your local machine, install the Helm server (tiller) with a service account, and add the {{site.data.keyword.Bluemix_notm}} Helm repository.

2.  Verify that tiller is installed with a service account.
    ```
    kubectl get serviceaccount -n kube-system | grep tiller
    ```
    {: pre}

    Example output:
    ```
    NAME                                 SECRETS   AGE
    tiller                               1         2m
    ```
    {: screen}

3. Create a configuration map file that defines your checks in JSON format. For example, the following YAML file defines three checks: an HTTP check and two Kubernetes API server checks. Refer to the tables following the example YAML file for information about the three kinds of checks and information about the individual components of the checks.
</br>
   **Tip:** Define each check as a unique key in the `data` section of the configuration map.

   ```
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: ibm-worker-recovery-checks
     namespace: kube-system
   data:
     checknode.json: |
       {
         "Check":"KUBEAPI",
         "Resource":"NODE",
         "FailureThreshold":3,
         "CorrectiveAction":"RELOAD",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Enabled":true
       }
     checkpod.json: |
       {
         "Check":"KUBEAPI",
         "Resource":"POD",
         "PodFailureThresholdPercent":50,
         "FailureThreshold":3,
         "CorrectiveAction":"RELOAD",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Enabled":true
       }
     checkhttp.json: |
       {
         "Check":"HTTP",
         "FailureThreshold":3,
         "CorrectiveAction":"REBOOT",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Port":80,
         "ExpectedStatus":200,
         "Route":"/myhealth",
         "Enabled":false
       }
   ```
   {:codeblock}

   <table summary="Understanding the components of the configmap">
   <caption>Understanding the configmap components</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Idea icon"/>Understanding the configmap components</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>The configuration name <code>ibm-worker-recovery-checks</code> is a constant and cannot be changed.</td>
   </tr>
   <tr>
   <td><code>namespace</code></td>
   <td>The <code>kube-system</code> namespace is a constant and cannot be changed.</td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>Defines a Kubernetes API node check that checks whether each worker node is in the <code>Ready</code> state. The check for a specific worker node counts as a failure if the worker node is not in the <code>Ready</code> state. The check in the example YAML runs every 3 minutes. If it fails three consecutive times, the worker node is reloaded. This action is equivalent to running <code>ibmcloud ks worker-reload</code>.<br></br>The node check is enabled until you set the <b>Enabled</b> field to <code>false</code> or remove the check.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>
   Defines a Kubernetes API pod check that checks the total percentage of <code>NotReady</code> pods on a worker node based on the total pods that are assigned to that worker node. The check for a specific worker node counts as a failure if the total percentage of <code>NotReady</code> pods is greater than the defined <code>PodFailureThresholdPercent</code>. The check in the example YAML runs every 3 minutes. If it fails three consecutive times, the worker node is reloaded. This action is equivalent to running <code>ibmcloud ks worker-reload</code>. For example, the default <code>PodFailureThresholdPercent</code> is 50%. If the percentage of <code>NotReady</code> pods is greater than 50% three consecutive times, the worker node is reloaded. <br></br>By default, pods in all namespaces are checked. To restrict the check to only pods in a specified namespace, add the <code>Namespace</code> field to the check. The pod check is enabled until you set the <b>Enabled</b> field to <code>false</code> or remove the check.
   </td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>Defines an HTTP check that checks if an HTTP server that runs on your worker node is healthy. To use this check you must deploy an HTTP server on every worker node in your cluster by using a [daemon set ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). You must implement a health check that is available at the <code>/myhealth</code> path and that can verify if your HTTP server is healthy. You can define other paths by changing the <strong>Route</strong> parameter. If the HTTP server is healthy, you must return the HTTP response code that is defined in <strong><code>ExpectedStatus</code></strong>. The HTTP server must be configured to listen on the private IP address of the worker node. You can find the private IP address by running <code>kubectl get nodes</code>.<br></br>
   For example, consider two nodes in a cluster that have the private IP addresses 10.10.10.1 and 10.10.10.2. In this example, two routes are checked for a 200 HTTP response: <code>http://10.10.10.1:80/myhealth</code> and <code>http://10.10.10.2:80/myhealth</code>.
   The check in the example YAML runs every 3 minutes. If it fails three consecutive times, the worker node is rebooted. This action is equivalent to running <code>ibmcloud ks worker-reboot</code>.<br></br>The HTTP check is disabled until you set the <b>Enabled</b> field to <code>true</code>.</td>
   </tr>
   </tbody>
   </table>

   <table summary="Understanding individual components of checks">
   <caption>Understanding the individual components of checks</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Idea icon"/>Understanding the individual components of checks </th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Enter the type of check that you want Autorecovery to use. <ul><li><code>HTTP</code>: Autorecovery calls HTTP servers that run on each node to determine whether the nodes are running properly.</li><li><code>KUBEAPI</code>: Autorecovery calls the Kubernetes API server and reads the health status data reported by the worker nodes.</li></ul></td>
   </tr>
   <tr>
   <td><code>Resource</code></td>
   <td>When the check type is <code>KUBEAPI</code>, enter the type of resource that you want Autorecovery to check. Accepted values are <code>NODE</code> or <code>POD</code>.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>Enter the threshold for the number of consecutive failed checks. When this threshold is met, Autorecovery triggers the specified corrective action. For example, if the value is 3 and Autorecovery fails a configured check three consecutive times, Autorecovery triggers the corrective action that is associated with the check.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>When the resource type is <code>POD</code>, enter the threshold for the percentage of pods on a worker node that can be in a [<strong><code>NotReady</code></strong> ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) state. This percentage is based on the total number of pods that are scheduled to a worker node. When a check determines that the percentage of unhealthy pods is greater than the threshold, the check counts as one failure.</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>Enter the action to run when the failure threshold is met. A corrective action runs only while no other workers are being repaired and when this worker node is not in a cool-off period from a previous action. <ul><li><code>REBOOT</code>: Reboots the worker node.</li><li><code>RELOAD</code>: Reloads all of the necessary configurations for the worker node from a clean OS.</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>Enter the number of seconds Autorecovery must wait to issue another corrective action for a node that was already issued a corrective action. The cool off period starts at the time a corrective action is issued.</td>
   </tr>
   <tr>
   <td><code>IntervalSeconds</code></td>
   <td>Enter the number of seconds in between consecutive checks. For example, if the value is 180, Autorecovery runs the check on each node every 3 minutes.</td>
   </tr>
   <tr>
   <td><code>TimeoutSeconds</code></td>
   <td>Enter the maximum number of seconds that a check call to the database takes before Autorecovery terminates the call operation. The value for <code>TimeoutSeconds</code> must be less than the value for <code>IntervalSeconds</code>.</td>
   </tr>
   <tr>
   <td><code>Port</code></td>
   <td>When the check type is <code>HTTP</code>, enter the port that the HTTP server must bind to on the worker nodes. This port must be exposed on the IP of every worker node in the cluster. Autorecovery requires a constant port number across all nodes for checking servers. Use [daemon sets ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) when you deploy a custom server into a cluster.</td>
   </tr>
   <tr>
   <td><code>ExpectedStatus</code></td>
   <td>When the check type is <code>HTTP</code>, enter the HTTP server status that you expect to be returned from the check. For example, a value of 200 indicates that you expect an <code>OK</code> response from the server.</td>
   </tr>
   <tr>
   <td><code>Route</code></td>
   <td>When the check type is <code>HTTP</code>, enter the path that is requested from the HTTP server. This value is typically the metrics path for the server that is running on all of the worker nodes.</td>
   </tr>
   <tr>
   <td><code>Enabled</code></td>
   <td>Enter <code>true</code> to enable the check or <code>false</code> to disable the check.</td>
   </tr>
   <tr>
   <td><code>Namespace</code></td>
   <td> Optional: To restrict <code>checkpod.json</code> to checking only pods in one namespace, add the <code>Namespace</code> field and enter the namespace.</td>
   </tr>
   </tbody>
   </table>

4. Create the configuration map in your cluster.
    ```
    kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

5. Verify that you created the configuration map with the name `ibm-worker-recovery-checks` in the `kube-system` namespace with the proper checks.
    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

6. Deploy Autorecovery into your cluster by installing the `ibm-worker-recovery` Helm chart.
    ```
    helm install --name ibm-worker-recovery ibm/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

7. After a few minutes, you can check the `Events` section in the output of the following command to see activity on the Autorecovery deployment.
    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

8. If you do not see activity on the Autorecovery deployment, you can check the Helm deployment by running the tests that are included in the Autorecovery chart definition.
    ```
    helm test ibm-worker-recovery
    ```
    {: pre}




