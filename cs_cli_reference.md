---

copyright:
  years: 2014, 2018
lastupdated: "2018-07-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# {{site.data.keyword.containerlong_notm}} CLI reference
{: #cs_cli_reference}

Refer to these commands to create and manage Kubernetes clusters in {{site.data.keyword.containerlong}}.
{:shortdesc}

To install the CLI plug-in, see [Installing the CLI](cs_cli_install.html#cs_cli_install_steps).

Looking for `ibmcloud cr` commands? See the [{{site.data.keyword.registryshort_notm}} CLI reference](/docs/cli/plugins/registry/index.html). Looking for `kubectl` commands? See the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/overview/).
{:tip}

## ibmcloud cs commands
{: #cs_commands}

**Tip:** To see the version of the {{site.data.keyword.containershort_notm}} plug-in, run the following command.

```
ibmcloud plugin list
```
{: pre}



<table summary="API commands table">
<caption>API commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>API commands</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud cs api](#cs_api)</td>
    <td>[ibmcloud cs api-key-info](#cs_api_key_info)</td>
    <td>[ibmcloud cs api-key-reset](#cs_api_key_reset)</td>
    <td>[ibmcloud cs apiserver-config-get](#cs_apiserver_config_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud cs apiserver-config-set](#cs_apiserver_config_set)</td>
    <td>[ibmcloud cs apiserver-config-unset](#cs_apiserver_config_unset)</td>
    <td>[ibmcloud cs apiserver-refresh](#cs_apiserver_refresh)</td>
    <td></td>
 </tr>
</tbody>
</table>

<br>

<table summary="CLI plug-in usage commands table">
<caption>CLI plug-in usage commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>CLI plug-in usage commands</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud cs help](#cs_help)</td>
    <td>[ibmcloud cs init](#cs_init)</td>
    <td>[ibmcloud cs messages](#cs_messages)</td>
    <td></td>
  </tr>
</tbody>
</table>

<br>

<table summary="Cluster commands: Management table">
<caption>Cluster commands: Management commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Cluster commands: Management</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud cs cluster-config](#cs_cluster_config)</td>
    <td>[ibmcloud cs cluster-create](#cs_cluster_create)</td>
    <td>[ibmcloud cs cluster-feature-enable](#cs_cluster_feature_enable)</td>
    <td>[ibmcloud cs cluster-get](#cs_cluster_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud cs cluster-rm](#cs_cluster_rm)</td>
    <td>[ibmcloud cs cluster-update](#cs_cluster_update)</td>
    <td>[ibmcloud cs clusters](#cs_clusters)</td>
    <td>[ibmcloud cs kube-versions](#cs_kube_versions)</td>
  </tr>
</tbody>
</table>

<br>

<table summary="Cluster commands: Services and integrations table">
<caption>Cluster commands: Services and integrations commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Cluster commands: Services and integrations</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud cs cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[ibmcloud cs cluster-service-unbind](#cs_cluster_service_unbind)</td>
    <td>[ibmcloud cs cluster-services](#cs_cluster_services)</td>
    <td>[ibmcloud cs webhook-create](#cs_webhook_create)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="Cluster commands: Subnets table">
<caption>Cluster commands: Subnets commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Cluster commands: Subnets</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud cs cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[ibmcloud cs cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[ibmcloud cs cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[ibmcloud cs cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
  </tr>
  <tr>
    <td>[ibmcloud cs subnets](#cs_subnets)</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>

</br>

<table summary="Infrastructure commands table">
<caption>Cluster commands: Infrastructure commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Infrastructure commands</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud cs credentials-set](#cs_credentials_set)</td>
    <td>[ibmcloud cs credentials-unset](#cs_credentials_unset)</td>
    <td>[ibmcloud cs machine-types](#cs_machine_types)</td>
    <td>[ibmcloud cs vlans](#cs_vlans)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="Ingress application load balancer (ALB) commands table">
<caption>Ingress application load balancer (ALB) commands</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Ingress application load balancer (ALB) commands</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud cs alb-cert-deploy](#cs_alb_cert_deploy)</td>
      <td>[ibmcloud cs alb-cert-get](#cs_alb_cert_get)</td>
      <td>[ibmcloud cs alb-cert-rm](#cs_alb_cert_rm)</td>
      <td>[ibmcloud cs alb-certs](#cs_alb_certs)</td>
    </tr>
    <tr>
      <td>[ibmcloud cs alb-configure](#cs_alb_configure)</td>
      <td>[ibmcloud cs alb-get](#cs_alb_get)</td>
      <td>[ibmcloud cs alb-types](#cs_alb_types)</td>
      <td>[ibmcloud cs albs](#cs_albs)</td>
    </tr>
  </tbody>
</table>

</br>

<table summary="Logging commands table">
<caption>Logging commands</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Logging commands</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud cs logging-config-create](#cs_logging_create)</td>
      <td>[ibmcloud cs logging-config-get](#cs_logging_get)</td>
      <td>[ibmcloud cs logging-config-refresh](#cs_logging_refresh)</td>
      <td>[ibmcloud cs logging-config-rm](#cs_logging_rm)</td>
    </tr>
    <tr>
      <td>[ibmcloud cs logging-config-update](#cs_logging_update)</td>
      <td>[ibmcloud cs logging-filter-create](#cs_log_filter_create)</td>
      <td>[ibmcloud cs logging-filter-update](#cs_log_filter_update)</td>
      <td>[ibmcloud cs logging-filter-get](#cs_log_filter_view)</td>
    </tr>
    <tr>
      <td>[ibmcloud cs logging-filter-rm](#cs_log_filter_delete)</td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table>

</br>

<table summary="Region commands table">
<caption>Region commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Region commands</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud cs locations](#cs_datacenters)</td>
    <td>[ibmcloud cs region](#cs_region)</td>
    <td>[ibmcloud cs region-set](#cs_region-set)</td>
    <td>[ibmcloud cs regions](#cs_regions)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="Worker node commands table">
<caption>Worker node commands</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Worker node commands</th>
 </thead>
 <tbody>
    <tr>
      <td>[ibmcloud cs worker-add](#cs_worker_add)</td>
      <td>[ibmcloud cs worker-get](#cs_worker_get)</td>
      <td>[ibmcloud cs worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud cs worker-reload](#cs_worker_reload)</td>
    </tr>
    <tr>
      <td>[ibmcloud cs worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud cs worker-update](#cs_worker_update)</td>
      <td>[ibmcloud cs workers](#cs_workers)</td>
      <td>[ibmcloud cs worker-get](#cs_worker_get)</td>
    </tr>
    <tr>
      <td>[ibmcloud cs worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud cs worker-reload](#cs_worker_reload)</td>
      <td>[ibmcloud cs worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud cs workers](#cs_workers)</td>
    </tr>
  </tbody>
</table>



## API commands
{: #api_commands}

### ibmcloud cs api ENDPOINT [--insecure] [--skip-ssl-validation] [--api-version VALUE] [-s]
{: #cs_api}

Target the API endpoint for {{site.data.keyword.containershort_notm}}. If you do not specify an endpoint, you can view information about the current endpoint that is targeted.

Switching regions? Use the `ibmcloud cs region-set` [command](#cs_region-set) instead.
{: tip}

<strong>Command options</strong>:

   <dl>
   <dt><code><em>ENDPOINT</em></code></dt>
   <dd>The {{site.data.keyword.containershort_notm}} API endpoint. Note that this endpoint is different than the {{site.data.keyword.Bluemix_notm}} endpoints. This value is required to set the API endpoint. Accepted values are:<ul>
   <li>Global endpoint: https://containers.bluemix.net</li>
   <li>AP North endpoint: https://ap-north.containers.bluemix.net</li>
   <li>AP South endpoint: https://ap-south.containers.bluemix.net</li>
   <li>EU Central endpoint: https://eu-central.containers.bluemix.net</li>
   <li>UK South endpoint: https://uk-south.containers.bluemix.net</li>
   <li>US East endpoint: https://us-east.containers.bluemix.net</li>
   <li>US South endpoint: https://us-south.containers.bluemix.net</li></ul>
   </dd>

   <dt><code>--insecure</code></dt>
   <dd>Allow an insecure HTTP connection. This flag is optional.</dd>

   <dt><code>--skip-ssl-validation</code></dt>
   <dd>Allow insecure SSL certificates. This flag is optional.</dd>

   <dt><code>--api-version VALUE</code></dt>
   <dd>Specify the API version of the service that you want to use. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**: View information about the current API endpoint that is targeted.
```
ibmcloud cs api
```
{: pre}

```
API Endpoint:          https://containers.bluemix.net   
API Version:           v1   
Skip SSL Validation:   false   
Region:                us-south
```
{: screen}


### ibmcloud cs api-key-info CLUSTER [--json] [-s]
{: #cs_api_key_info}

View the name and email address for the owner of the IAM API key in an {{site.data.keyword.containershort_notm}} region.

The Identity and Access Management (IAM) API key is automatically set for a region when the first action that requires the {{site.data.keyword.containershort_notm}} admin access policy is performed. For example, one of your admin users creates the first cluster in the `us-south` region. By doing that, the IAM API key for this user is stored in the account for this region. The API key is used to order resources in IBM Cloud infrastructure (SoftLayer), such as new worker nodes or VLANs.

When a different user performs an action in this region that requires interaction with the IBM Cloud infrastructure (SoftLayer) portfolio, such as creating a new cluster or reloading a worker node, the stored API key is used to determine if sufficient permissions exist to perform that action. To make sure that infrastructure-related actions in your cluster can be successfully performed, assign your {{site.data.keyword.containershort_notm}} admin users the **Super user** infrastructure access policy. For more information, see [Managing user access](cs_users.html#infra_access).

If you find that you need to update the API key that is stored for a region, you can do so by running the [ibmcloud cs api-key-reset](#cs_api_key_reset) command. This command requires the {{site.data.keyword.containershort_notm}} admin access policy and stores the API key of the user that executes this command in the account.

**Tip:** The API key that is returned in this command might not be used if IBM Cloud infrastructure (SoftLayer) credentials were manually set by using the [ibmcloud cs credentials-set](#cs_credentials_set) command.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs api-key-info my_cluster
  ```
  {: pre}


### ibmcloud cs api-key-reset [-s]
{: #cs_api_key_reset}

Replace the current IAM API key in an {{site.data.keyword.containershort_notm}} region.

This command requires the {{site.data.keyword.containershort_notm}} admin access policy and stores the API key of the user that executes this command in the account. The IAM API key is required to order infrastructure from the IBM Cloud infrastructure (SoftLayer) portfolio. Once stored, the API key is used for every action in a region that requires infrastructure permissions independent of the user that executes this command. For more information about how IAM API keys work, see the [`ibmcloud cs api-key-info` command](#cs_api_key_info).

**Important** Before you use this command, make sure that the user who executes this command has the required [{{site.data.keyword.containershort_notm}} and IBM Cloud infrastructure (SoftLayer) permissions](cs_users.html#users).

<strong>Command options</strong>:

   <dl>
   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>


**Example**:

  ```
  ibmcloud cs api-key-reset
  ```
  {: pre}


### ibmcloud cs apiserver-config-get
{: #cs_apiserver_config_get}

Get information about an option for a cluster's Kubernetes API server configuration. This command must be combined with one of the following subcommands for the configuration option you want information on.

#### ibmcloud cs apiserver-config-get audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_get}

View the URL for the remote logging service that you are sending API server audit logs to. The URL was specified when you created the webhook backend for the API server configuration.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs apiserver-config-get audit-webhook my_cluster
  ```
  {: pre}

### ibmcloud cs apiserver-config-set
{: #cs_apiserver_config_set}

Set an option for a cluster's Kubernetes API server configuration. This command must be combined with one of the following subcommands for the configuration option you want to set.

#### ibmcloud cs apiserver-config-set audit-webhook CLUSTER [--remoteServer SERVER_URL_OR_IP] [--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH] [--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_api_webhook_set}

Set the webhook backend for the API server configuration. The webhook backend forwards API server audit logs to a remote server. A webhook configuration is created based on the information you provide in this command's flags. If you do not provide any information in the flags, a default webhook configuration is used.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--remoteServer <em>SERVER_URL</em></code></dt>
   <dd>The URL or IP address for the remote logging service you want to send audit logs to. If you provide an insecure server URL, any certificates are ignored. This value is optional.</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>The filepath for the CA certificate that is used to verify the remote logging service. This value is optional.</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>The filepath for the client certificate that is used to authenticate against the remote logging service. This value is optional.</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>The filepath for the corresponding client key that is used to connect to the remote logging service. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs apiserver-config-set audit-webhook my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}


### ibmcloud cs apiserver-config-unset
{: #cs_apiserver_config_unset}

Disable an option for a cluster's Kubernetes API server configuration. This command must be combined with one of the following subcommands for the configuration option you want to unset.

#### ibmcloud cs apiserver-config-unset audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_unset}

Disable the webhook backend configuration for the cluster's API server. Disabling the webhook backend stops forwarding API server audit logs to a remote server.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs apiserver-config-unset audit-webhook my_cluster
  ```
  {: pre}

### ibmcloud cs apiserver-refresh CLUSTER [-s]
{: #cs_apiserver_refresh}

Restart the Kubernetes master in the cluster to apply changes to the API server configuration.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs apiserver-refresh my_cluster
  ```
  {: pre}


<br />


## CLI plug-in usage commands
{: #cli_plug-in_commands}

### ibmcloud cs help
{: #cs_help}

View a list of supported commands and parameters.

<strong>Command options</strong>:

   None

**Example**:

  ```
  ibmcloud cs help
  ```
  {: pre}


### ibmcloud cs init [--host HOST] [--insecure] [-p] [-u] [-s]
{: #cs_init}

Initialize the {{site.data.keyword.containershort_notm}} plug-in or specify the region where you want to create or access Kubernetes clusters.

<strong>Command options</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>The {{site.data.keyword.containershort_notm}} API endpoint to use.  This value is optional. [View the available API endpoint values.](cs_regions.html#container_regions)</dd>

   <dt><code>--insecure</code></dt>
   <dd>Allow an insecure HTTP connection.</dd>

   <dt><code>-p</code></dt>
   <dd>Your IBM Cloud password.</dd>

   <dt><code>-u</code></dt>
   <dd>Your IBM Cloud username.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:


```
ibmcloud cs init --host https://uk-south.containers.bluemix.net
```
{: pre}


### ibmcloud cs messages
{: #cs_messages}

View current messages for the IBMid user.

**Example**:

```
ibmcloud cs messages
```
{: pre}


<br />


## Cluster commands: Management
{: #cluster_mgmt_commands}


### ibmcloud cs cluster-config CLUSTER [--admin] [--export] [-s] [--yaml]
{: #cs_cluster_config}

After logging in, download Kubernetes configuration data and certificates to connect to your cluster and run `kubectl` commands. The files are downloaded to `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Command options**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--admin</code></dt>
   <dd>Download the TLS certificates and permission files for the Super User role. You can use the certs to automate tasks in a cluster without having to re-authenticate. The files are downloaded to `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`. This value is optional.</dd>

   <dt><code>--export</code></dt>
   <dd>Download Kubernetes configuration data and certificates without any messages other than the export command. Because no messages are displayed, you can use this flag when you create automated scripts. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

  <dt><code>--yaml</code></dt>
  <dd>Prints the command output in YAML format. This value is optional.</dd>

   </dl>

**Example**:

```
ibmcloud cs cluster-config my_cluster
```
{: pre}


### ibmcloud cs cluster-create [--file FILE_LOCATION] [--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH] [--no-subnet] [--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN] [--workers WORKER] [--disable-disk-encrypt] [--trusted] [-s]
{: #cs_cluster_create}

Create a cluster in your organization. For free clusters, you specify the cluster name; everything else is set to a default value. A free cluster is automatically deleted after 30 days. You can have one free cluster at a time. To take advantage of the full capabilities of Kubernetes, create a standard cluster.

<strong>Command options</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>The path to the YAML file to create your standard cluster. Instead of defining the characteristics of your cluster by using the options provided in this command, you can use a YAML file.  This value is optional for standard clusters and is not available for free clusters.

<p><strong>Note:</strong> If you provide the same option in the command as parameter in the YAML file, the value in the command takes precedence over the value in the YAML. For example, you define a location in your YAML file and use the <code>--location</code> option in the command, the value that you entered in the command option overrides the value in the YAML file.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
diskEncryption: <em>false</em>
trusted: <em>true</em>
</code></pre>


<table>
    <caption>Understanding the YAML file components</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Replace <code><em>&lt;cluster_name&gt;</em></code> with a name for your cluster. The name must start with a letter, can contain letters, numbers, and hyphen (-), and must be 35 characters or fewer. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.
</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>Replace <code><em>&lt;location&gt;</em></code> with the location where you want to create your cluster. The available locations are dependent on the region that you are logged in. To list available locations, run <code>ibmcloud cs locations</code>. </td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>By default, a public and a private portable subnet are created on the VLAN associated with the cluster. Replace <code><em>&lt;no-subnet&gt;</em></code> with <code><em>true</em></code> to avoid creating subnets with the cluster. You can [create](#cs_cluster_subnet_create) or [add](#cs_cluster_subnet_add) subnets to a cluster later.</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Replace <code><em>&lt;machine_type&gt;</em></code> with the type of machine that you want to deploy your worker nodes to. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the location in which you deploy the cluster. For more information, see the documentation for the `ibmcloud cs machine-type` [command](cs_cli_reference.html#cs_machine_types).</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Replace <code><em>&lt;private_VLAN&gt;</em></code> with the ID of the private VLAN that you want to use for your worker nodes. To list available VLANs, run <code>ibmcloud cs vlans <em>&lt;location&gt;</em></code> and look for VLAN routers that start with <code>bcr</code> (back-end router).</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Replace <code><em>&lt;public_VLAN&gt;</em></code> with the ID of the public VLAN that you want to use for your worker nodes. To list available VLANs, run <code>ibmcloud cs vlans <em>&lt;location&gt;</em></code> and look for VLAN routers that start with <code>fcr</code> (front-end router).</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>For virtual machine types: The level of hardware isolation for your worker node. Use dedicated if you want to have available physical resources dedicated to you only, or shared to allow physical resources to be shared with other IBM customers. The default is <code>shared</code>.</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Replace <code><em>&lt;number_workers&gt;</em></code> with the number of worker nodes that you want to deploy.</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>The Kubernetes version for the cluster master node. This value is optional. When the version is not specified, the cluster is created with the default of supported Kubernetes versions. To see available versions, run <code>ibmcloud cs kube-versions</code>.
</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>Worker nodes feature disk encryption by default; [learn more](cs_secure.html#encrypted_disk). To disable encryption, include this option and set the value to <code>false</code>.</td></tr>
      <tr>
      <td><code>trusted: <em>true</em></code></td>
      <td>**Bare metal only**: Enable [Trusted Compute](cs_secure.html#trusted_compute) to verify your bare metal worker nodes against tampering. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud cs feature-enable` [command](cs_cli_reference.html#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>The level of hardware isolation for your worker node. Use dedicated to have available physical resources dedicated to you only, or shared to allow physical resources to be shared with other IBM customers. The default is shared.  This value is optional for standard clusters and is not available for free clusters.</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>The location where you want to create the cluster. The locations that are available to you depend on the {{site.data.keyword.Bluemix_notm}} region you are logged in to. Select the region that is physically closest to you for best performance.  This value is required for standard clusters and is optional for free clusters.

<p>Review [available locations](cs_regions.html#locations).
</p>

<p><strong>Note:</strong> When you select a location that is located outside your country, keep in mind that you might require legal authorization before data can be physically stored in a foreign country.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Choose a machine type. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the location in which you deploy the cluster. For more information, see the documentation for the `ibmcloud cs machine-types` [command](cs_cli_reference.html#cs_machine_types). This value is required for standard clusters and is not available for free clusters.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>The name for the cluster.  This value is required. The name must start with a letter, can contain letters, numbers, and hyphen (-), and must be 35 characters or fewer. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.
</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>The Kubernetes version for the cluster master node. This value is optional. When the version is not specified, the cluster is created with the default of supported Kubernetes versions. To see available versions, run <code>ibmcloud cs kube-versions</code>.
</dd>

<dt><code>--no-subnet</code></dt>
<dd>By default, a public and a private portable subnet are created on the VLAN associated with the cluster. Include the <code>--no-subnet</code> flag to avoid creating subnets with the cluster. You can [create](#cs_cluster_subnet_create) or [add](#cs_cluster_subnet_add) subnets to a cluster later.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>This parameter is not available for free clusters.</li>
<li>If this standard cluster is the first standard cluster that you create in this location, do not include this flag. A private VLAN is created for you when the clusters is created.</li>
<li>If you created a standard cluster before in this location or created a private VLAN in IBM Cloud infrastructure (SoftLayer) before, you must specify that private VLAN.

<p><strong>Note:</strong> Private VLAN routers always begin with <code>bcr</code> (back-end router) and public VLAN routers always begin with <code>fcr</code> (front-end router). When creating a cluster and specifying the public and private VLANs, the number and letter combination after those prefixes must match.</p></li>
</ul>

<p>To find out if you already have a private VLAN for a specific location or to find the name of an existing private VLAN, run <code>ibmcloud cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>This parameter is not available for free clusters.</li>
<li>If this standard cluster is the first standard cluster that you create in this location, do not use this flag. A public VLAN is created for you when the cluster is created.</li>
<li>If you created a standard cluster before in this location or created a public VLAN in IBM Cloud infrastructure (SoftLayer) before, specify that public VLAN. If you want to connect your worker nodes to a private VLAN only, do not specify this option.

<p><strong>Note:</strong> Private VLAN routers always begin with <code>bcr</code> (back-end router) and public VLAN routers always begin with <code>fcr</code> (front-end router). When creating a cluster and specifying the public and private VLANs, the number and letter combination after those prefixes must match.</p></li>
</ul>

<p>To find out if you already have a public VLAN for a specific location or to find the name of an existing public VLAN, run <code>ibmcloud cs vlans <em>&lt;location&gt;</em></code>.</p></dd>



<dt><code>--workers WORKER</code></dt>
<dd>The number of worker nodes that you want to deploy in your cluster. If you do not specify this option, a cluster with 1 worker node is created. This value is optional for standard clusters and is not available for free clusters.

<p><strong>Note:</strong> Every worker node is assigned a unique worker node ID and domain name that must not be manually changed after the cluster is created. Changing the ID or domain name prevents the Kubernetes master from managing your cluster.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Worker nodes feature disk encryption by default; [learn more](cs_secure.html#encrypted_disk). To disable encryption, include this option.</dd>

<dt><code>--trusted</code></dt>
<dd><p>**Bare metal only**: Enable [Trusted Compute](cs_secure.html#trusted_compute) to verify your bare metal worker nodes against tampering. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud cs feature-enable` [command](cs_cli_reference.html#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.</p>
<p>To check whether the bare metal machine type supports trust, check the `Trustable` field in the output of the `ibmcloud cs machine-types <location>` [command](#cs_machine_types). To verify that a cluster is trust-enabled, view the **Trust ready** field in the output of the `ibmcloud cs cluster-get` [command](#cs_cluster_get). To verify a bare metal worker node is trust-enabled, view the **Trust** field in the output of the `ibmcloud cs worker-get` [command](#cs_worker_get).</p></dd>

<dt><code>-s</code></dt>
<dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>

**Examples**:

  

  **Create a free cluster**: Specify the cluster name only; everything else is set to a default value. A free cluster is automatically deleted after 30 days. You can have one free cluster at a time. To take advantage of the full capabilities of Kubernetes, create a standard cluster.

  ```
  ibmcloud cs cluster-create --name my_cluster
  ```
  {: pre}

  **Create your first standard cluster**: The first standard cluster that is created in a location also creates a private VLAN. Therefore, do not include the `--public-vlan` flag.
  {: #example_cluster_create}

  ```
  ibmcloud cs cluster-create --location dal10 --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Create subsequent standard clusters**: If you already created a standard cluster in this location or created a public VLAN in IBM Cloud infrastructure (SoftLayer) before, specify that public VLAN with the `--public-vlan` flag. To find out if you already have a public VLAN for a specific location or to find the name of an existing public VLAN, run `ibmcloud cs vlans <location>`.

  ```
  ibmcloud cs cluster-create --location dal10 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Create a cluster in an {{site.data.keyword.Bluemix_dedicated_notm}} environment**:

  ```
  ibmcloud cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}

### ibmcloud cs cluster-feature-enable [-f] CLUSTER [--trusted] [-s]
{: #cs_cluster_feature_enable}

Enable a feature on an existing cluster.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>-f</code></dt>
   <dd>Use this option to force the <code>--trusted</code> option with no user prompts. This value is optional.</dd>

   <dt><code><em>--trusted</em></code></dt>
   <dd><p>Include the flag to enable [Trusted Compute](cs_secure.html#trusted_compute) for all supported bare metal worker nodes that are in the cluster. After you enable trust, you cannot later disable it for the cluster.</p>
   <p>To check whether the bare metal machine type supports trust, check the **Trustable** field in the output of the `ibmcloud cs machine-types <location>` [command](#cs_machine_types). To verify that a cluster is trust-enabled, view the **Trust ready** field in the output of the `ibmcloud cs cluster-get` [command](#cs_cluster_get). To verify a bare metal worker node is trust-enabled, view the **Trust** field in the output of the `ibmcloud cs worker-get` [command](#cs_worker_get).</p></dd>

  <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>

**Example command**:

  ```
  ibmcloud cs cluster-feature-enable my_cluster --trusted=true
  ```
  {: pre}

### ibmcloud cs cluster-get CLUSTER [--json] [--showResources] [-s]
{: #cs_cluster_get}

View information about a cluster in your organization.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>Show more cluster resources such as add-ons, VLANs, subnets, and storage.</dd>


  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>



**Example command**:

  ```
  ibmcloud cs cluster-get my_cluster --showResources
  ```
  {: pre}

**Example output**:

  ```
  Name:        my_cluster
  ID:          abc1234567
  State:       normal
  Trust ready: false
  Created:     2018-01-01T17:19:28+0000
  Location:    dal10
  Master URL:  https://169.xx.xxx.xxx:xxxxx
  Master Location: Dallas
  Ingress subdomain: my_cluster.us-south.containers.appdomain.cloud
  Ingress secret:    my_cluster
  Workers:     3
  Worker Locations: dal10
  Version:     1.10.3
  Owner Email: name@example.com
  Monitoring dashboard: https://metrics.ng.bluemix.net/app/#/grafana4/dashboard/db/link

  Addons
  Name                   Enabled
  customer-storage-pod   true
  basic-ingress-v2       true
  storage-watcher-pod    true

  Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false

  ```
  {: screen}

### ibmcloud cs cluster-rm [-f] CLUSTER [-s]
{: #cs_cluster_rm}

Remove a cluster from your organization.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>-f</code></dt>
   <dd>Use this option to force the removal of a cluster with no user prompts. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs cluster-rm my_cluster
  ```
  {: pre}


### ibmcloud cs cluster-update [-f] CLUSTER [--kube-version MAJOR.MINOR.PATCH] [--force-update] [-s]
{: #cs_cluster_update}

Update the Kubernetes master to the default API version. During the update, you cannot access or change the cluster. Worker nodes, apps, and resources that were deployed by the user are not modified and continue to run.

You might need to change your YAML files for future deployments. Review this [release note](cs_versions.html) for details.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>The Kubernetes version of the cluster. If you do not specify a version, the Kubernetes master is updated to the default API version. To see available versions, run [ibmcloud cs kube-versions](#cs_kube_versions). This value is optional.</dd>

   <dt><code>-f</code></dt>
   <dd>Use this option to force the update of the master with no user prompts. This value is optional.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Attempt the update even if the change is greater than two minor versions. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs cluster-update my_cluster
  ```
  {: pre}


### ibmcloud cs clusters [--json] [-s]
{: #cs_clusters}

View a list of clusters in your organization.

<strong>Command options</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Example**:

  ```
  ibmcloud cs clusters
  ```
  {: pre}


### ibmcloud cs kube-versions [--json] [-s]
{: #cs_kube_versions}

View a list of Kubernetes versions supported in {{site.data.keyword.containershort_notm}}. Update your [cluster master](#cs_cluster_update) and [worker nodes](cs_cli_reference.html#cs_worker_update) to the default version for the latest, stable capabilities.

**Command options**:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Example**:

  ```
  ibmcloud cs kube-versions
  ```
  {: pre}

<br />



## Cluster commands: Services and integrations
{: #cluster_services_commands}


### ibmcloud cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_NAME [-s]
{: #cs_cluster_service_bind}

Add an {{site.data.keyword.Bluemix_notm}} service to a cluster. To view available {{site.data.keyword.Bluemix_notm}} services from the {{site.data.keyword.Bluemix_notm}} catalog, run `ibmcloud service offerings`. **Note**: You can only add {{site.data.keyword.Bluemix_notm}} services that support service keys.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>The name of the Kubernetes namespace. This value is required.</dd>

   <dt><code><em>SERVICE_INSTANCE_NAME</em></code></dt>
   <dd>The name of the {{site.data.keyword.Bluemix_notm}} service instance that you want to bind. To find the name of your service instance, run <code>ibmcloud service list</code>. If more than one instance has the same name in the account, use the service instance ID instead of the name. To find the ID, run <code>ibmcloud service show <service instance name> --guid</code>. One of these values is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs cluster-service-bind my_cluster my_namespace my_service_instance
  ```
  {: pre}


### ibmcloud cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID [-s]
{: #cs_cluster_service_unbind}

Remove an {{site.data.keyword.Bluemix_notm}} service from a cluster.

**Note:** When you remove an {{site.data.keyword.Bluemix_notm}} service, the service credentials are removed from the cluster. If a pod is still using the service, it fails because the service credentials cannot be found.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>The name of the Kubernetes namespace. This value is required.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>The ID of the {{site.data.keyword.Bluemix_notm}} service instance that you want to remove. To find the ID of the service instance, run `ibmcloud cs cluster-services <cluster_name_or_ID>`.This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs cluster-service-unbind my_cluster my_namespace 8567221
  ```
  {: pre}


### ibmcloud cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE] [--all-namespaces] [--json] [-s]
{: #cs_cluster_services}

List the services that are bound to one or all of the Kubernetes namespace in a cluster. If no options are specified, the services for the default namespace are displayed.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Include the services that are bound to a specific namespace in a cluster. This value is optional.</dd>

   <dt><code>--all-namespaces</code></dt>
   <dd>Include the services that are bound to all of the namespaces in a cluster. This value is optional.</dd>

   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}

### ibmcloud cs va CONTAINER_ID [--extended] [--vulnerabilities] [--configuration-issues] [--json]
{: #cs_va}

After you [install the container scanner](/docs/services/va/va_index.html#va_install_container_scanner), view a detailed vulnerability assessment report for a container in your cluster.

**Command options**:

<dl>
<dt><code>CONTAINER_ID</code></dt>
<dd><p>The ID of the container. This value is required.</p>
<p>To find the ID of your container:<ol><li>[Target the Kubernetes CLI to your cluster](cs_cli_install.html#cs_cli_configure).</li><li>List your pods by running `kubectl get pods`.</li><li>Find the **Container ID** field in the output of the `kubectl describe pod <pod_name>` command. For example, `Container ID: docker://1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li><li>Remove the `docker://` prefix from the ID before you use the container ID for the `ibmcloud cs va` command. For example, `1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li></ol></p></dd>

<dt><code>--extended</code></dt>
<dd><p>Extend the command output to show more fix information for vulnerable packages. This value is optional.</p>
<p>By default, the scan results show the ID, policy status, affected packages, and how to resolve. With the `--extended` flag, it adds information such as the summary, vendor security notice, and official notice link.</p></dd>

<dt><code>--vulnerabilities</code></dt>
<dd>Restrict the command output to show package vulnerabilities only. This value is optional. You cannot use this flag if you use the `--configuration-issues` flag.</dd>

<dt><code>--configuration-issues</code></dt>
<dd>Restrict the command output to show configuration issues only. This value is optional. You cannot use this flag if you use the `--vulnerabilities` flag.</dd>

<dt><code>--json</code></dt>
<dd>Prints the command output in JSON format. This value is optional.</dd>
</dl>

**Example**:

```
ibmcloud cs va 1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15 --extended --vulnerabilities --json
```
{: pre}


### ibmcloud cs webhook-create --cluster CLUSTER --level LEVEL --type slack --url URL  [-s]
{: #cs_webhook_create}

Register a webhook.

<strong>Command options</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>The notification level, such as <code>Normal</code> or <code>Warning</code>. <code>Warning</code> is the default value. This value is optional.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>The webhook type. Currently slack is supported. This value is required.</dd>

   <dt><code>--url <em>URL</em></code></dt>
   <dd>The URL for the webhook. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs webhook-create --cluster my_cluster --level Normal --type slack --url http://github.com/mywebhook
  ```
  {: pre}


<br />


## Cluster commands: Subnets
{: #cluster_subnets_commands}

### ibmcloud cs cluster-subnet-add CLUSTER SUBNET [-s]
{: #cs_cluster_subnet_add}

You can add existing portable public or private subnets from your IBM Cloud infrastructure (SoftLayer) account to your Kubernetes cluster or reuse subnets from a deleted cluster instead of using the automatically provisioned subnets.

**Note:**
* Portable public IP addresses are charged monthly. If you remove portable public IP addresses after your cluster is provisioned, you still must pay the monthly charge, even if you used them only for a short amount of time.
* When you make a subnet available to a cluster, IP addresses of this subnet are used for cluster networking purposes. To avoid IP address conflicts, make sure that you use a subnet with one cluster only. Do not use a subnet for multiple clusters or for other purposes outside of {{site.data.keyword.containershort_notm}} at the same time.
* To route between subnets on the same VLAN, you must [turn on VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>The ID of the subnet. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs cluster-subnet-add my_cluster 1643389
  ```
  {: pre}


### ibmcloud cs cluster-subnet-create CLUSTER SIZE VLAN_ID [-s]
{: #cs_cluster_subnet_create}

Create a subnet in an IBM Cloud infrastructure (SoftLayer) account and make it available to a specified cluster in {{site.data.keyword.containershort_notm}}.

**Note:**
* When you make a subnet available to a cluster, IP addresses of this subnet are used for cluster networking purposes. To avoid IP address conflicts, make sure that you use a subnet with one cluster only. Do not use a subnet for multiple clusters or for other purposes outside of {{site.data.keyword.containershort_notm}} at the same time.
* To route between subnets on the same VLAN, you must [turn on VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required. To list your clusters, use the `ibmcloud cs clusters` [command](#cs_clusters).</dd>

   <dt><code><em>SIZE</em></code></dt>
   <dd>The number of subnet IP addresses. This value is required. Possible values are 8, 16, 32, or 64.</dd>

   <dt><code><em>VLAN_ID</em></code></dt>
   <dd>The VLAN in which to create the subnet. This value is required. To list available VLANS, use the `ibmcloud cs vlans <location>` [command](#cs_vlans). </dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs cluster-subnet-create my_cluster 8 1764905
  ```
  {: pre}


### ibmcloud cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

Bring your own private subnet to your {{site.data.keyword.containershort_notm}} clusters.

This private subnet is not one provided by IBM Cloud infrastructure (SoftLayer). As such, you must configure any inbound and outbound network traffic routing for the subnet. To add an IBM Cloud infrastructure (SoftLayer) subnet, use the `ibmcloud cs cluster-subnet-add` [command](#cs_cluster_subnet_add).

**Note**:
* When you add a private user subnet to a cluster, IP addresses of this subnet are used for private Load Balancers in the cluster. To avoid IP address conflicts, make sure that you use a subnet with one cluster only. Do not use a subnet for multiple clusters or for other purposes outside of {{site.data.keyword.containershort_notm}} at the same time.
* To route between subnets on the same VLAN, you must [turn on VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>The subnet Classless InterDomain Routing (CIDR). This value is required, and must not conflict with any subnet that is used by IBM Cloud infrastructure (SoftLayer).

   Supported prefixes range from `/30` (1 IP address) to `/24` (253 IP addresses). If you set the CIDR at one prefix length and later need to change it, first add the new CIDR, then [remove the old CIDR](#cs_cluster_user_subnet_rm).</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>The ID of the private VLAN. This value is required. It must match the private VLAN ID of one or more of the worker nodes in the cluster.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs cluster-user-subnet-add my_cluster 169.xx.xxx.xxx/29 1502175
  ```
  {: pre}


### ibmcloud cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

Remove your own private subnet from a specified cluster.

**Note:** Any service that was deployed to an IP address from your own private subnet remains active after the subnet is removed.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>The subnet Classless InterDomain Routing (CIDR). This value is required, and must match the CIDR that was set by the `ibmcloud cs cluster-user-subnet-add` [command](#cs_cluster_user_subnet_add).</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>The ID of the private VLAN. This value is required, and must match the VLAN ID that was set by the `ibmcloud cs cluster-user-subnet-add` [command](#cs_cluster_user_subnet_add).</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs cluster-user-subnet-rm my_cluster 169.xx.xxx.xxx/29 1502175
  ```
  {: pre}

### ibmcloud cs subnets [--json] [-s]
{: #cs_subnets}

View a list of subnets that are available in an IBM Cloud infrastructure (SoftLayer) account.

<strong>Command options</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Example**:

  ```
  ibmcloud cs subnets
  ```
  {: pre}


<br />


## Ingress application load balancer (ALB) commands
{: #alb_commands}

### ibmcloud cs alb-cert-deploy [--update] --cluster CLUSTER --secret-name SECRET_NAME --cert-crn CERTIFICATE_CRN [-s]
{: #cs_alb_cert_deploy}

Deploy or update a certificate from your {{site.data.keyword.cloudcerts_long_notm}} instance to the ALB in a cluster.

**Note:**
* Only a user with the Administrator access role can execute this command.
* You can only update certificates that are imported from the same {{site.data.keyword.cloudcerts_long_notm}} instance.

<strong>Command options</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>--update</code></dt>
   <dd>Update the certificate for an ALB secret in a cluster. This value is optional.</dd>

   <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
   <dd>The name of the ALB secret. This value is required.</dd>

   <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
   <dd>The certificate CRN. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Examples**:

Example for deploying an ALB secret:

   ```
   ibmcloud cs alb-cert-deploy --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
   {: pre}

Example for updating an existing ALB secret:

 ```
 ibmcloud cs alb-cert-deploy --update --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### ibmcloud cs alb-cert-get --cluster CLUSTER [--secret-name SECRET_NAME] [--cert-crn CERTIFICATE_CRN] [--json] [-s]
{: #cs_alb_cert_get}

View information about an ALB secret in a cluster.

**Note:** Only a user with the Administrator access role can execute this command.

<strong>Command options</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>The name or ID of the cluster. This value is required.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>The name of the ALB secret. This value is required to get information on a specific ALB secret in the cluster.</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>The certificate CRN. This value is required to get information on all ALB secrets matching a specific certificate CRN in the cluster.</dd>

  <dt><code>--json</code></dt>
  <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Examples**:

 Example for fetching information on an ALB secret:

 ```
 ibmcloud cs alb-cert-get --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 Example for fetching information on all ALB secrets that match a specified certificate CRN:

 ```
 ibmcloud cs alb-cert-get --cluster my_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud cs alb-cert-rm --cluster CLUSTER [--secret-name SECRET_NAME] [--cert-crn CERTIFICATE_CRN] [-s]
{: #cs_alb_cert_rm}

Remove an ALB secret in a cluster.

**Note:** Only a user with the Administrator access role can execute this command.

<strong>Command options</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>The name or ID of the cluster. This value is required.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>The name of the ALB secret. This value is required to remove a specific ALB secret in the cluster.</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>The certificate CRN. This value is required to remove all ALB secrets matching a specific certificate CRN in the cluster.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

  </dl>

**Examples**:

 Example for removing an ALB secret:

 ```
 ibmcloud cs alb-cert-rm --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 Example for removing all ALB secrets that match a specified certificate CRN:

 ```
 ibmcloud cs alb-cert-rm --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud cs alb-certs --cluster CLUSTER [--json] [-s]
{: #cs_alb_certs}

View a list of ALB secrets in a cluster.

**Note:** Only users with the Administrator access role can execute this command.

<strong>Command options</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>
   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>
   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

 ```
 ibmcloud cs alb-certs --cluster my_cluster
 ```
 {: pre}

### ibmcloud cs alb-configure --albID ALB_ID [--enable][--disable][--user-ip USERIP] [-s]
{: #cs_alb_configure}

Enable or disable an ALB in your standard cluster. The public ALB is enabled by default.

**Command options**:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>The ID for an ALB. Run <code>ibmcloud cs albs <em>--cluster </em>CLUSTER</code> to view the IDs for the ALBs in a cluster. This value is required.</dd>

   <dt><code>--enable</code></dt>
   <dd>Include this flag to enable an ALB in a cluster.</dd>

   <dt><code>--disable</code></dt>
   <dd>Include this flag to disable an ALB in a cluster.</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>This parameter is available for enabling a private ALB only.</li>
    <li>The private ALB is deployed with an IP address from a user-provided private subnet. If no IP address is provided, the ALB is deployed with a private IP address from the portable private subnet that was provisioned automatically when you created the cluster.</li>
   </ul>
   </dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Examples**:

  Example for enabling an ALB:

  ```
  ibmcloud cs alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable
  ```
  {: pre}

  Example for enabling an ALB with a user-provided IP address:

  ```
  ibmcloud cs alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable --user-ip user_ip
  ```
  {: pre}

  Example for disabling an ALB:

  ```
  ibmcloud cs alb-configure --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --disable
  ```
  {: pre}

### ibmcloud cs alb-get --albID ALB_ID [--json] [-s]
{: #cs_alb_get}

View the details of an ALB.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>The ID for an ALB. Run <code>ibmcloud cs albs --cluster <em>CLUSTER</em></code> to view the IDs for the ALBs in a cluster. This value is required.</dd>

   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs alb-get --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1
  ```
  {: pre}

### ibmcloud cs alb-types [--json] [-s]
{: #cs_alb_types}

View the ALB types that are supported in the region.

<strong>Command options</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Example**:

  ```
  ibmcloud cs alb-types
  ```
  {: pre}


### ibmcloud cs albs --cluster CLUSTER [--json] [-s]
{: #cs_albs}

View the status of all ALBs in a cluster. If no ALB IDs are returned, then the cluster does not have a portable subnet. You can [create](#cs_cluster_subnet_create) or [add](#cs_cluster_subnet_add) subnets to a cluster.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>The name or ID of the cluster where you list available ALBs. This value is required.</dd>

   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs albs --cluster my_cluster
  ```
  {: pre}


<br />


## Infrastructure commands
{: #infrastructure_commands}

### ibmcloud cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME [-s]
{: #cs_credentials_set}

Set IBM Cloud infrastructure (SoftLayer) account credentials for your {{site.data.keyword.containershort_notm}} account.

If you have an {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account, you have access to the IBM Cloud infrastructure (SoftLayer) portfolio by default. However, you might want to use a different IBM Cloud infrastructure (SoftLayer) account that you already have to order infrastructure. You can link this infrastructure account to your {{site.data.keyword.Bluemix_notm}} account by using this command.

If IBM Cloud infrastructure (SoftLayer) credentials are manually set, these credentials are used to order infrastructure, even if an [IAM API key](#cs_api_key_info) already exists for the account. If the user whose credentials are stored does not have the required permissions to order infrastructure, then infrastructure-related actions, such as creating a cluster or reloading a worker node can fail.

You cannot set multiple credentials for one {{site.data.keyword.containershort_notm}} account. Every {{site.data.keyword.containershort_notm}} account is linked to one IBM Cloud infrastructure (SoftLayer) portfolio only.

**Important:** Before you use this command, make sure that the user whose credentials are used has the required [{{site.data.keyword.containershort_notm}} and IBM Cloud infrastructure (SoftLayer) permissions](cs_users.html#users).

<strong>Command options</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>IBM Cloud infrastructure (SoftLayer) account username. This value is required.</dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>IBM Cloud infrastructure (SoftLayer) account API key. This value is required.

 <p>
  To generate an API key:

  <ol>
  <li>Log in to the [IBM Cloud infrastructure (SoftLayer) portal ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.bluemix.com/).</li>
  <li>Select <strong>Account</strong>, and then <strong>Users</strong>.</li>
  <li>Click <strong>Generate</strong> to generate an IBM Cloud infrastructure (SoftLayer) API key for your account.</li>
  <li>Copy the API key to use in this command.</li>
  </ol>

  To view your existing API key:
  <ol>
  <li>Log in to the [IBM Cloud infrastructure (SoftLayer)portal ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.bluemix.com/).</li>
  <li>Select <strong>Account</strong>, and then <strong>Users</strong>.</li>
  <li>Click <strong>View</strong> to see your existing API key.</li>
  <li>Copy the API key to use in this command.</li>
  </ol>
  </p></dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

  </dl>

**Example**:

  ```
  ibmcloud cs credentials-set --infrastructure-api-key <api_key> --infrastructure-username dbmanager
  ```
  {: pre}


### ibmcloud cs credentials-unset
{: #cs_credentials_unset}

Remove IBM Cloud infrastructure (SoftLayer) account credentials from your {{site.data.keyword.containershort_notm}} account.

After you remove the credentials, the [IAM API key](#cs_api_key_info) is used to order resources in IBM Cloud infrastructure (SoftLayer).

<strong>Command options</strong>:

  <dl>
  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Example**:

  ```
  ibmcloud cs credentials-unset
  ```
  {: pre}


### ibmcloud cs machine-types LOCATION [--json] [-s]
{: #cs_machine_types}

View a list of available machine types for your worker nodes. Machine types vary by location. Each machine type includes the amount of virtual CPU, memory, and disk space for each worker node in the cluster. By default, the secondary storage disk directory where all container data is stored, is encrypted with LUKS encryption. If the `disable-disk-encrypt` option is included during cluster creation, then the host's Docker data is not encrypted. [Learn more about the ecryption](cs_secure.html#encrypted_disk).
{:shortdesc}

You can provision your worker node as a virtual machine on shared or dedicated hardware, or as a physical machine on bare metal. [Learn more about your machine type options](cs_clusters.html#shared_dedicated_node).

<strong>Command options</strong>:

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>Enter the location where you want to list available machine types. This value is required. Review [available locations](cs_regions.html#locations).</dd>

   <dt><code>--json</code></dt>
  <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Example command**:

  ```
  ibmcloud cs machine-types dal10
  ```
  {: pre}

### ibmcloud cs vlans LOCATION [--all] [--json] [-s]
{: #cs_vlans}

List the public and private VLANs that are available for a location in your IBM Cloud infrastructure (SoftLayer) account. To list available VLANs, you must have a paid account.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>Enter the location where you want to list your private and public VLANs. This value is required. Review [available locations](cs_regions.html#locations).</dd>

   <dt><code>--all</code></dt>
   <dd>Lists all available VLANs. By default VLANs are filtered to show only those VLANS that are valid. To be valid, a VLAN must be associated with infrastructure that can host a worker with local disk storage.</dd>

   <dt><code>--json</code></dt>
  <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs vlans dal10
  ```
  {: pre}


<br />


## Logging commands
{: #logging_commands}

### ibmcloud cs logging-config-create CLUSTER --logsource LOG_SOURCE --type LOG_TYPE [--namespace KUBERNETES_NAMESPACE] [--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT] [--space CLUSTER_SPACE] [--org CLUSTER_ORG] [--app-containers CONTAINERS] [--app-paths PATHS_TO_LOGS] [--syslog-protocol PROTOCOL]  [--json] [--skip-validation] [-s]
{: #cs_logging_create}

Create a logging configuration. You can use this command to forward logs for containers, applications, worker nodes, Kubernetes clusters, and Ingress application load balancers to {{site.data.keyword.loganalysisshort_notm}} or to an external syslog server.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
    <dd>The name or ID of the cluster.</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>    
    <dd>The log source to enable log forwarding for. This argument supports a comma-separated list of log sources to apply the configuration for. Accepted values are <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, and <code>ingress</code>, and <code>kube-audit</code>. If you do not provide a log source, configurations are created for <code>container</code> and <code>ingress</code>.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Where you want to forward your logs. Options are <code>ibm</code>, which forwards your logs to {{site.data.keyword.loganalysisshort_notm}} and <code>syslog</code>, which forwards your logs to an external server.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>The Kubernetes namespace that you want to forward logs from. Log forwarding is not supported for the <code>ibm-system</code> and <code>kube-system</code> Kubernetes namespaces. This value is valid only for the container log source and is optional. If you do not specify a namespace, then all namespaces in the cluster use this configuration.</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
    <dd>When the logging type is <code>syslog</code>, the hostname or IP address of the log collector server. This value is required for <code>syslog</code>. When the logging type is <code>ibm</code>, the {{site.data.keyword.loganalysislong_notm}} ingestion URL. You can find the list of available ingestion URLs [here](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). If you do not specify an ingestion URL, the endpoint for the region where your cluster was created is used.</dd>

  <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
    <dd>The port of the log collector server. This value is optional. If you do not specify a port, then the standard port <code>514</code> is used for <code>syslog</code> and the standard port <code>9091</code> is used for <code>ibm</code>.</dd>

  <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
    <dd>The name of the Cloud Foundry space that you want to send logs to. This value is valid only for log type <code>ibm</code> and is optional. If you do not specify a space, logs are sent to the account level.</dd>

  <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
    <dd>The name of the Cloud Foundry org that the space is in. This value is valid only for log type <code>ibm</code> and is required if you specified a space.</dd>

  <dt><code>--app-paths</code></dt>
    <dd>The path on the container that the apps are logging to. To forward logs with source type <code>application</code>, you must provide a path. To specify more than one path, use a comma-separated list. This value is required for log source <code>application</code>. Example: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

  <dt><code>--syslog-protocol</code></dt>
    <dd>The transfer layer protocol that is used when the logging type is <code>syslog</code>. Supported values are <code>tcp</code> and the default <code>udp</code>. When forwarding to an rsyslog server with the <code>udp</code> protocol, logs that are over 1KB are truncated.</dd>

  <dt><code>--app-containers</code></dt>
    <dd>To forward logs from apps, you can specify the name of the container that contains your app. You can specify more than one container by using a comma-separated list. If no containers are specified, logs are forwarded from all of the containers that contain the paths that you provided. This option is only valid for log source <code>application</code>.</dd>

  <dt><code>--json</code></dt>
    <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>--skip-validation</code></dt>
    <dd>Skip validation of the org and space names when they are specified. Skipping validation decreases processing time, but an invalid logging configuration does not correctly forward logs. This value is optional.</dd>

    <dt><code>-s</code></dt>
    <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>

**Examples**:

Example for log type `ibm` that forwards from a `container` log source on default port 9091:

  ```
  ibmcloud cs logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

Example for log type `syslog` that forwards from a `container` log source on default port 514:

  ```
  ibmcloud cs logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname 169.xx.xxx.xxx --type syslog
  ```
  {: pre}

Example for log type `syslog` that forwards logs from an `ingress` source on a port different than the default:

  ```
  ibmcloud cs logging-config-create my_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
  ```
  {: pre}

### ibmcloud cs logging-config-get CLUSTER [--logsource LOG_SOURCE] [--json] [-s]
{: #cs_logging_get}

View all log forwarding configurations for a cluster, or filter logging configurations based on log source.

<strong>Command options</strong>:

 <dl>
  <dt><code><em>CLUSTER</em></code></dt>
    <dd>The name or ID of the cluster. This value is required.</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
    <dd>The kind of log source for which you want to filter. Only logging configurations of this log source in the cluster are returned. Accepted values are <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code>, and <code>kube-audit</code>. This value is optional.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Shows the logging filters that render previous filters obsolete.</dd>

  <dt><code>--json</code></dt>
    <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
 </dl>

**Example**:

  ```
  ibmcloud cs logging-config-get my_cluster --logsource worker
  ```
  {: pre}


### ibmcloud cs logging-config-refresh CLUSTER [-s]
{: #cs_logging_refresh}

Refresh the logging configuration for the cluster. This refreshes the logging token for any logging configuration that is forwarding to the space level in your cluster.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>-s</code></dt>
     <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>

**Example**:

  ```
  ibmcloud cs logging-config-refresh my_cluster
  ```
  {: pre}


### ibmcloud cs logging-config-rm CLUSTER [--id LOG_CONFIG_ID] [--all] [-s]
{: #cs_logging_rm}

Delete one log forwarding configuration or all logging configurations for a cluster. This stops log forwarding to a remote syslog server or to {{site.data.keyword.loganalysisshort_notm}}.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>If you want to remove a single logging configuration, the logging configuration ID.</dd>

  <dt><code>--all</code></dt>
   <dd>The flag to remove all logging configurations in a cluster.</dd>

   <dt><code>-s</code></dt>
     <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>

**Example**:

  ```
  ibmcloud cs logging-config-rm my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### ibmcloud cs logging-config-update CLUSTER --id LOG_CONFIG_ID --type LOG_TYPE  [--namespace NAMESPACE] [--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT] [--space CLUSTER_SPACE] [--org CLUSTER_ORG] [--app-paths PATH] [--app-containers PATH] [--json] [--skipValidation] [-s]
{: #cs_logging_update}

Update the details of a log forwarding configuration.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>The logging configuration ID that you want to update. This value is required.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>The log forwarding protocol that you want to use. Currently, <code>syslog</code> and <code>ibm</code> are supported. This value is required.</dd>

  <dt><code>--namespace <em>NAMESPACE</em></code>
    <dd>The Kubernetes namespace that you want to forward logs from. Log forwarding is not supported for the <code>ibm-system</code> and <code>kube-system</code> Kubernetes namespaces. This value is valid only for the <code>container</code> log source. If you do not specify a namespace, then all namespaces in the cluster use this configuration.</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>When the logging type is <code>syslog</code>, the hostname or IP address of the log collector server. This value is required for <code>syslog</code>. When the logging type is <code>ibm</code>, the {{site.data.keyword.loganalysislong_notm}} ingestion URL. You can find the list of available ingestion URLs [here](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). If you do not specify an ingestion URL, the endpoint for the region where your cluster was created is used.</dd>

   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>The port of the log collector server. This value is optional when the logging type is <code>syslog</code>. If you do not specify a port, then the standard port <code>514</code> is used for <code>syslog</code> and <code>9091</code> is used for <code>ibm</code>.</dd>

   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>The name of the space that you want to send logs to. This value is valid only for log type <code>ibm</code> and is optional. If you do not specify a space, logs are sent to the account level.</dd>

   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>The name of the org that the space is in. This value is valid only for log type <code>ibm</code> and is required if you specified a space.</dd>

   <dt><code>--app-paths <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>An absolute file path in the container to collect logs from. Wildcards, such as '/var/log/*.log', can be used, but recursive globs, such as '/var/log/**/test.log', cannot be used. To specify more than one path, use a comma separated list. This value is required when you specify 'application' for the log source. </dd>

   <dt><code>--app-containers <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>The path on the containers that the apps are logging to. To forward logs with source type <code>application</code>, you must provide a path. To specify more than one path, use a comma separated list. Example: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

   <dt><code>--json</code></dt>
    <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code>--skipValidation</code></dt>
    <dd>Skip validation of the org and space names when they are specified. Skipping validation decreases processing time, but an invalid logging configuration does not correctly forward logs. This value is optional.</dd>

   <dt><code>-s</code></dt>
     <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
  </dl>

**Example for log type `ibm`**:

  ```
  ibmcloud cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Example for log type `syslog`**:

  ```
  ibmcloud cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### ibmcloud cs logging-filter-create CLUSTER --type LOG_TYPE [--logging-configs CONFIGS] [--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME] [--level LOGGING_LEVEL] [--regex-message MESSAGE] [--json] [-s]
{: #cs_log_filter_create}

Create a logging filter. You can use this command to filter out logs that are forwarded by your logging configuration.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
    <dd>The name or ID of the cluster that you want to create a logging filter for. This value is required.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>The type of logs that you want to apply the filter to. Currently <code>all</code>, <code>container</code>, and <code>host</code> are supported.</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>A comma separated list of your logging configuration IDs. If not provided, the filter is applied to all of the cluster logging configurations that are passed to the filter. You can view log configurations that match the filter by using the <code>--show-matching-configs</code> flag with the command. This value is optional.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>The Kubernetes namespace from which you want to filter logs. This value is optional.</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>The name of the container from which you want to filter out logs. This flag applies only when you are using log type <code>container</code>. This value is optional.</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>Filters out logs that are at the specified level and less. Acceptable values in their canonical order are <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code>, and <code>trace</code>. This value is optional. As an example, if you filtered logs at the <code>info</code> level, <code>debug</code>, and <code>trace</code> are also filtered. **Note**: You can use this flag only when log messages are in JSON format and contain a level field. Example output: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>Filters out any logs that contain a specified message that is written as a regular expression anywhere in the log. This value is optional.</dd>

  <dt><code>--json</code></dt>
    <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>

**Examples**:

This example filters out all logs that are forwarded from containers with the name `test-container` in the default namespace that are at the debug level or less, and have a log message that contains "GET request".

  ```
  ibmcloud cs logging-filter-create example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

This example filters out all of the logs that are forwarded, at an info level or less, from a specific cluster. The output is returned as JSON.

  ```
  ibmcloud cs logging-filter-create example-cluster --type all --level info --json
  ```
  {: pre}



### ibmcloud cs logging-filter-get CLUSTER [--id FILTER_ID] [--show-matching-configs] [--show-covering-filters] [--json] [-s]
{: #cs_log_filter_view}

View a logging filter configuration. You can use this command to view the logging filters that you created.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
    <dd>The name or ID of the cluster that you want to view filters from. This value is required.</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>The ID of the log filter that you want to view.</dd>

  <dt><code>--show-matching-configs</code></dt>
    <dd>Show the logging configurations that match the configuration that you're viewing. This value is optional.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Show the logging filters that render previous filters obsolete. This value is optional.</dd>

  <dt><code>--json</code></dt>
    <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code>-s</code></dt>
     <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>


### ibmcloud cs logging-filter-rm CLUSTER [--id FILTER_ID] [--all] [-s]
{: #cs_log_filter_delete}

Delete a logging filter. You can use this command to remove a logging filter that you created.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
    <dd>The name or ID of the cluster that you want to delete a filter from.</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>The ID of the log filter to delete.</dd>

  <dt><code>--all</code></dt>
    <dd>Delete all of your log forwarding filters. This value is optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>


### ibmcloud cs logging-filter-update CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-configs CONFIGS] [--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME] [--level LOGGING_LEVEL] [--message MESSAGE] [--json] [-s]
{: #cs_log_filter_update}

Update a logging filter. You can use this command to update a logging filter that you created.

<strong>Command options</strong>:

<dl>
  <dt><code><em>CLUSTER</em></code></dt>
    <dd>The name or ID of the cluster that you want to update a logging filter for. This value is required.</dd>

 <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>The ID of the log filter to update.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>The type of logs that you want to apply the filter to. Currently <code>all</code>, <code>container</code>, and <code>host</code> are supported.</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>A comma separated list of your logging configuration IDs. If not provided, the filter is applied to all of the cluster logging configurations that are passed to the filter. You can view log configurations that match the filter by using the <code>--show-matching-configs</code> flag with the command. This value is optional.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>The Kubernetes namespace from which you want to filter logs. This value is optional.</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>The name of the container from which you want to filter out logs. This flag applies only when you are using log type <code>container</code>. This value is optional.</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>Filters out logs that are at the specified level and less. Acceptable values in their canonical order are <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code>, and <code>trace</code>. This value is optional. As an example, if you filtered logs at the <code>info</code> level, <code>debug</code>, and <code>trace</code> are also filtered. **Note**: You can use this flag only when log messages are in JSON format and contain a level field. Example output: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>Filters out any logs that contain a specified message anywhere in the log. The message is matched literally and not as an expression. Example: The messages “Hello”, “!”, and “Hello, World!”, would apply to the log “Hello, World!”. This value is optional.</dd>

  <dt><code>--json</code></dt>
    <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
</dl>


<br />


## Region commands
{: #region_commands}

### ibmcloud cs locations [--json] [-s]
{: #cs_datacenters}

View a list of available locations for you to create a cluster in. The available locations vary by the region that you are logged in to. To switch regions, run `ibmcloud cs region-set`.

<strong>Command options</strong>:

   <dl>
   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs locations
  ```
  {: pre}


### ibmcloud cs region
{: #cs_region}

Find the {{site.data.keyword.containershort_notm}} region that you are currently in. You create and manage clusters specific to the region. Use the `ibmcloud cs region-set` command to change regions.

**Example**:

```
ibmcloud cs region
```
{: pre}

**Output**:
```
Region: us-south
```
{: screen}

### ibmcloud cs region-set [REGION]
{: #cs_region-set}

Set the region for {{site.data.keyword.containershort_notm}}. You create and manage clusters specific to the region, and you might want clusters in multiple regions for high availability.

For example, you can log in to {{site.data.keyword.Bluemix_notm}} in the US South region and create a cluster. Next, you can use `ibmcloud cs region-set eu-central` to target the EU Central region and create another cluster. Finally, you can use `ibmcloud cs region-set us-south` to return to US South to manage your cluster in that region.

**Command options**:

<dl>
<dt><code><em>REGION</em></code></dt>
<dd>Enter the region that you want to target. This value is optional. If you do not provide the region, you can select it from the list in the output.

For a list of available regions, review [regions and locations](cs_regions.html) or use the `ibmcloud cs regions` [command](#cs_regions).</dd></dl>

**Example**:

```
ibmcloud cs region-set eu-central
```
{: pre}

```
ibmcloud cs region-set
```
{: pre}

**Output**:
```
Choose a region:
1. ap-north
2. ap-south
3. eu-central
4. uk-south
5. us-east
6. us-south
Enter a number> 3
OK
```
{: screen}

### ibmcloud cs regions
{: #cs_regions}

Lists the available regions. The `Region Name` is the {{site.data.keyword.containershort_notm}} name, and the `Region Alias` is the general {{site.data.keyword.Bluemix_notm}} name for the region.

**Example**:

```
ibmcloud cs regions
```
{: pre}

**Output**:
```
Region Name   Region Alias
ap-north      jp-tok
ap-south      au-syd
eu-central    eu-de
uk-south      eu-gb
us-east       us-east
us-south      us-south
```
{: screen}


<br />


## Worker node commands
{: worker_node_commands}


###  ibmcloud cs worker-add --cluster CLUSTER [--file FILE_LOCATION] [--hardware HARDWARE] --machine-type MACHINE_TYPE --workers NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt] [-s]
{: #cs_worker_add}

Add worker nodes to your standard cluster.

<strong>Command options</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>The name or ID of the cluster. This value is required.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>The path to the YAML file to add worker nodes to the cluster. Instead of defining additional worker nodes by using the options provided in this command, you can use a YAML file. This value is optional.

<p><strong>Note:</strong> If you provide the same option in the command as the parameter in the YAML file, the value in the command takes precedence over the value in the YAML. For example, you define a machine type in your YAML file and use the --machine-type option in the command, the value that you entered in the command option overrides the value in the YAML file.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_ID&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
diskEncryption: <em>false</em></code></pre>

<table>
<caption>Understanding the YAML file components</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML file components</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Replace <code><em>&lt;cluster_name_or_ID&gt;</em></code> with the name or ID of the cluster where you want to add worker nodes.</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>Replace <code><em>&lt;location&gt;</em></code> with the location to deploy your worker nodes. The available locations are dependent on the region that you are logged in. To list available locations, run <code>ibmcloud cs locations</code>.</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Replace <code><em>&lt;machine_type&gt;</em></code> with the type of machine that you want to deploy your worker nodes to. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the location in which you deploy the cluster. For more information, see the `ibmcloud cs machine-types` [command](cs_cli_reference.html#cs_machine_types).</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Replace <code><em>&lt;private_VLAN&gt;</em></code> with the ID of the private VLAN that you want to use for your worker nodes. To list available VLANs, run <code>ibmcloud cs vlans <em>&lt;location&gt;</em></code> and look for VLAN routers that start with <code>bcr</code> (back-end router).</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Replace <code>&lt;public_VLAN&gt;</code> with the ID of the public VLAN that you want to use for your worker nodes. To list available VLANs, run <code>ibmcloud cs vlans &lt;location&gt;</code> and look for VLAN routers that start with <code>fcr</code> (front-end router). <br><strong>Note</strong>: {[private_VLAN_vyatta]}</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>For virtual machine types: The level of hardware isolation for your worker node. Use dedicated if you want to have available physical resources dedicated to you only, or shared to allow physical resources to be shared with other IBM customers. The default is shared.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Replace <code><em>&lt;number_workers&gt;</em></code> with the number of worker nodes that you want to deploy.</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>Worker nodes feature disk encryption by default; [learn more](cs_secure.html#encrypted_disk). To disable encryption, include this option and set the value to <code>false</code>.</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>The level of hardware isolation for your worker node. Use dedicated if you want to have available physical resources dedicated to you only, or shared to allow physical resources to be shared with other IBM customers. The default is shared. This value is optional.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Choose a machine type. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the location in which you deploy the cluster. For more information, see the documentation for the `ibmcloud cs machine-types` [command](cs_cli_reference.html#cs_machine_types). This value is required for standard clusters and is not available for free clusters.</dd>

<dt><code>--workers <em>NUMBER</em></code></dt>
<dd>An integer that represents the number of worker nodes to create in the cluster. The default value is 1. This value is optional.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>The private VLAN that was specified when the cluster was created. This value is required.

<p><strong>Note:</strong> Private VLAN routers always begin with <code>bcr</code> (back-end router) and public VLAN routers always begin with <code>fcr</code> (front-end router). When creating a cluster and specifying the public and private VLANs, the number and letter combination after those prefixes must match.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>The public VLAN that was specified when the cluster was created. This value is optional. If you want your worker nodes to exist on a private VLAN only, do not provide a public VLAN ID. <strong>Note</strong>: {[private_VLAN_vyatta]}

<p><strong>Note:</strong> Private VLAN routers always begin with <code>bcr</code> (back-end router) and public VLAN routers always begin with <code>fcr</code> (front-end router). When creating a cluster and specifying the public and private VLANs, the number and letter combination after those prefixes must match.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Worker nodes feature disk encryption by default; [learn more](cs_secure.html#encrypted_disk). To disable encryption, include this option.</dd>

<dt><code>-s</code></dt>
<dd>Do not show the message of the day or update reminders. This value is optional.</dd>

</dl>

**Examples**:

  ```
  ibmcloud cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --hardware shared
  ```
  {: pre}

  Example for {{site.data.keyword.Bluemix_dedicated_notm}}:

  ```
  ibmcloud cs worker-add --cluster my_cluster --number 3 --machine-type b2c.4x16
  ```
  {: pre}

### ibmcloud cs worker-get [CLUSTER_NAME_OR_ID] WORKER_NODE_ID [--json] [-s]
{: #cs_worker_get}

View the details of a worker node.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>The name or ID of the worker node's cluster. This value is optional.</dd>

   <dt><code><em>WORKER_NODE_ID</em></code></dt>
   <dd>The name of your worker node. Run <code>ibmcloud cs workers <em>CLUSTER</em></code> to view the IDs for the worker nodes in a cluster. This value is required.</dd>

   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example command**:

  ```
  ibmcloud cs worker-get my_cluster kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
  ```
  {: pre}

**Example output**:

  ```
  ID:           kube-dal10-123456789-w1
  State:        normal
  Status:       Ready
  Trust:        disabled
  Private VLAN: 223xxxx
  Public VLAN:  223xxxx
  Private IP:   10.xxx.xx.xxx
  Public IP:    169.xx.xxx.xxx
  Hardware:     shared
  Zone:         dal10
  Version:      1.8.11_1509
  ```
  {: screen}

### ibmcloud cs worker-reboot [-f] [--hard] CLUSTER WORKER [WORKER] [-s]
{: #cs_worker_reboot}

Reboot a worker node in a cluster. During the reboot, the state of your worker node does not change.

**Attention:** Rebooting a worker node can cause data corruption on the worker node. Use this command with caution and when you know that a reboot can help recover your worker node. In all other cases, [reload your worker node](#cs_worker_reload) instead.

Before you reboot your worker node, make sure that pods are rescheduled on other worker nodes to help avoid a downtime for your app or data corruption on your worker node.

1. List all worker nodes in your cluster and note the **name** of the worker node that you want to reboot.
   ```
   kubectl get nodes
   ```
   The**name** that is returned in this command is the private IP address that is assigned to your worker node. You can find more information about your worker node when you run the `ibmcloud cs workers <cluster_name_or_ID>` command and look for the worker node with the same **Private IP** address.
2. Mark the worker node as unschedulable in a process that is known as cordoning. When you cordon a worker node, you make it unavailable for future pod scheduling. Use the **name** of the worker node that you retrieved in the previous step.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Verify that pod scheduling is disabled for your worker node.
   ```
   kubectl get nodes
   ```
   {: pre}
   Your worker node is disabled for pod scheduling if the status displays **SchedulingDisabled**.
 4. Force pods to be removed from your worker node and rescheduled onto remaining worker nodes in the cluster.
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    This process can take a few minutes.
 5. Reboot the worker node. Use the worker ID that is returned from the `ibmcloud cs workers <cluster_name_or_ID>` command.
    ```
    ibmcloud cs worker-reboot <cluster_name_or_ID> <worker_name_or_ID>
    ```
    {: pre}
 6. Wait about 5 minutes before you make your worker node available for pod scheduling to ensure that the reboot is finished. During the reboot, the state of your worker node does not change. The reboot of a worker node is usually completed in a few seconds.
 7. Make your worker node available for pod scheduling. Use the **name** for your worker node that is returned from the `kubectl get nodes` command.
    ```
    kubectl uncordon <worker_name>
    ```
    {: pre}
    </br>

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>-f</code></dt>
   <dd>Use this option to force the restart of the worker node with no user prompts. This value is optional.</dd>

   <dt><code>--hard</code></dt>
   <dd>Use this option to force a hard restart of a worker node by cutting off power to the worker node. Use this option if the worker node is unresponsive or the worker node has a Docker hang. This value is optional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>The name or ID of one or more worker nodes. Use a space to list multiple worker nodes. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs worker-reboot my_cluster kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud cs worker-reload [-f] CLUSTER WORKER [WORKER] [-s]
{: #cs_worker_reload}

Reload all the necessary configurations for a worker node. A reload can be useful if your worker node experiences problems, such as slow performance or if your worker node is stuck in an unhealthy state.

Reloading a worker node applies patch version updates to your worker node, but not major or minor updates. To see the changes from one patch version to the next, review the [Version changelog](cs_versions_changelog.html#changelog) documentation.
{: tip}

Before you reload your worker node, make sure that pods are rescheduled on other worker nodes to help avoid a downtime for your app or data corruption on your worker node.

1. List all worker nodes in your cluster and note the **name** of the worker node that you want to reload.
   ```
   kubectl get nodes
   ```
   The **name** that is returned in this command is the private IP address that is assigned to your worker node. You can find more information about your worker node when you run the `ibmcloud cs workers <cluster_name_or_ID>` command and look for the worker node with the same **Private IP** address.
2. Mark the worker node as unschedulable in a process that is known as cordoning. When you cordon a worker node, you make it unavailable for future pod scheduling. Use the **name** of the worker node that you retrieved in the previous step.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Verify that pod scheduling is disabled for your worker node.
   ```
   kubectl get nodes
   ```
   {: pre}
   Your worker node is disabled for pod scheduling if the status displays **SchedulingDisabled**.
 4. Force pods to be removed from your worker node and rescheduled onto remaining worker nodes in the cluster.
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    This process can take a few minutes.
 5. Reload the worker node. Use the worker ID that is returned from the `ibmcloud cs workers <cluster_name_or_ID>` command.
    ```
    ibmcloud cs worker-reload <cluster_name_or_ID> <worker_name_or_ID>
    ```
    {: pre}
 6. Wait for the reload to complete.
 7. Make your worker node available for pod scheduling. Use the **name** for your worker node that is returned from the `kubectl get nodes` command.
    ```
    kubectl uncordon <worker_name>
    ```
</br>
<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>-f</code></dt>
   <dd>Use this option to force the reload of a worker node with no user prompts. This value is optional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>The name or ID of one or more worker nodes. Use a space to list multiple worker nodes. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs worker-reload my_cluster kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud cs worker-rm [-f] CLUSTER WORKER [WORKER] [-s]
{: #cs_worker_rm}

Remove one or more worker nodes from a cluster. If you remove a worker node, your cluster becomes unbalanced. 

Before you remove your worker node, make sure that pods are rescheduled on other worker nodes to help avoid a downtime for your app or data corruption on your worker node.
{: tip}

1. List all worker nodes in your cluster and note the **name** of the worker node that you want to remove.
   ```
   kubectl get nodes
   ```
   The **name** that is returned in this command is the private IP address that is assigned to your worker node. You can find more information about your worker node when you run the `ibmcloud cs workers <cluster_name_or_ID>` command and look for the worker node with the same **Private IP** address.
2. Mark the worker node as unschedulable in a process that is known as cordoning. When you cordon a worker node, you make it unavailable for future pod scheduling. Use the **name** of the worker node that you retrieved in the previous step.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Verify that pod scheduling is disabled for your worker node.
   ```
   kubectl get nodes
   ```
   {: pre}
   Your worker node is disabled for pod scheduling if the status displays **SchedulingDisabled**.
4. Force pods to be removed from your worker node and rescheduled onto remaining worker nodes in the cluster.
   ```
   kubectl drain <worker_name>
   ```
   {: pre}
   This process can take a few minutes.
5. Remove the worker node. Use the worker ID that is returned from the `ibmcloud cs workers <cluster_name_or_ID>` command.
   ```
   ibmcloud cs worker-rm <cluster_name_or_ID> <worker_name_or_ID>
   ```
   {: pre}

6. Verify that the worker node is removed.
   ```
   ibmcloud cs workers <cluster_name_or_ID>
   ```
</br>
<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster. This value is required.</dd>

   <dt><code>-f</code></dt>
   <dd>Use this option to force the removal of a worker node with no user prompts. This value is optional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>The name or ID of one or more worker nodes. Use a space to list multiple worker nodes. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs worker-rm my_cluster kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud cs worker-update [-f] CLUSTER WORKER [WORKER] [--kube-version MAJOR.MINOR.PATCH] [--force-update] [-s]
{: #cs_worker_update}

Update worker nodes to apply the latest security updates and patches to the operating system, and to update the Kubernetes version to match the version of the master node. You can update the master node Kubernetes version with the `ibmcloud cs cluster-update` [command](cs_cli_reference.html#cs_cluster_update).

**Important**: Running `ibmcloud cs worker-update` can cause downtime for your apps and services. During the update, all pods are rescheduled onto other worker nodes and data is deleted if not stored outside the pod. To avoid downtime, [ensure that you have enough worker nodes to handle your workload while the selected worker nodes are updating](cs_cluster_update.html#worker_node).

You might need to change your YAML files for deployments before updating. Review this [release note](cs_versions.html) for details.

<strong>Command options</strong>:

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>The name or ID of the cluster where you list available worker nodes. This value is required.</dd>

   <dt><code>-f</code></dt>
   <dd>Use this option to force the update of the master with no user prompts. This value is optional.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Attempt the update even if the change is greater than two minor versions. This value is optional.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
     <dd>The version of Kubernetes that you want your worker nodes to be updated with. The default version is used if this value is not specified.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>The ID of one or more worker nodes. Use a space to list multiple worker nodes. This value is required.</dd>

   <dt><code>-s</code></dt>
   <dd>Do not show the message of the day or update reminders. This value is optional.</dd>

   </dl>

**Example**:

  ```
  ibmcloud cs worker-update my_cluster kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud cs workers CLUSTER [--show-deleted] [--json] [-s]
{: #cs_workers}

View a list of worker nodes and the status for each in a cluster.

<strong>Command options</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>The name or ID of the cluster for the available worker nodes. This value is required.</dd>

   

   <dt><code>--show-deleted</code></dt>
   <dd>View worker nodes that were deleted from the cluster, including the reason for deletion. This value is optional.</dd>

   <dt><code>--json</code></dt>
   <dd>Prints the command output in JSON format. This value is optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Do not show the message of the day or update reminders. This value is optional.</dd>
   </dl>

**Example**:

  ```
  ibmcloud cs workers my_cluster
  ```
  {: pre}

<br />



