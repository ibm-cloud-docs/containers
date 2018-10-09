---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-09"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# User access permissions
{: #understanding}

When you [assign cluster permissions](cs_users.html), it can be hard to judge which role you need to assign to a user. Use the tables in the following sections to determine the minimum level of permissions that are required to perform common tasks in {{site.data.keyword.containerlong}}.
{: shortdesc}

## IAM platform and Kubernetes RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}} is configured to use {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) roles. IAM platform roles determine the actions that users can perform on a cluster. Every user who is assigned an IAM platform role is also automatically assigned a corresponding Kubernetes role-based access control (RBAC) role in the default namespace. Additionally, IAM platform roles automatically set basic infrastructure permissions for users. To set IAM policies, see [Assigning IAM platform permissions](cs_users.html#platform). To learn more about RBAC roles, see [Assigning RBAC permissions](cs_users.html#role-binding).

The following table shows the cluster management permissions granted by each IAM platform role and the Kubernetes resource permissions for the corresponding RBAC roles.

<table>
  <tr>
    <th>IAM platform role</th>
    <th>Cluster management permissions</th>
    <th>Corresponding RBAC role and resource permissions</th>
  </tr>
  <tr>
    <td>**Viewer**</td>
    <td>
      Cluster:<ul>
        <li>View the name and email address for the owner of the IAM API key for a resource group and region</li>
        <li>List all or view details for clusters, worker nodes, worker pools, services in a cluster, and webhooks</li>
        <li>View the VLAN spanning status for the infrastructure account</li>
        <li>List available subnets in the infrastructure account</li>
        <li>When set for one cluster: List VLANs that the cluster is connected to in a zone</li>
        <li>When set for all clusters in the account: List all available VLANs in a zone</li></ul>
      Logging:<ul>
        <li>View the default logging endpoint for the target region</li>
        <li>List or view details for log forwarding and filtering configurations</li>
        <li>View the status for automatic updates of the Fluentd add-on</li></ul>
      Ingress:<ul>
        <li>List all or view details for ALBs in a cluster</li>
        <li>View ALB types that are supported in the region</li></ul>
    </td>
    <td>The <code>view</code> cluster role is applied by the <code>ibm-view</code> role binding, providing the following permissions in the <code>default</code> namespace:<ul>
      <li>Read access to resources inside the default namespace</li>
      <li>No read access to Kubernetes secrets</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Editor** <br/><br/><strong>Tip</strong>: Use this role for app developers, and assign the <a href="#cloud-foundry">Cloud Foundry</a> **Developer** role.</td>
    <td>This role has all permissions from the Viewer role, plus the following:</br></br>
      Cluster:<ul>
        <li>Bind and unbind {{site.data.keyword.Bluemix_notm}} services to a cluster</li></ul>
      Logging:<ul>
        <li>Create, update, and delete API server audit webhooks</li>
        <li>Create cluster webhooks</li>
        <li>Create and delete log forwarding configurations for all types except `kube-audit`</li>
        <li>Update and refresh log forwarding configurations</li>
        <li>Create, update, and delete log filtering configurations</li></ul>
      Ingress:<ul>
        <li>Enable or disable ALBs</li></ul>
    </td>
    <td>The <code>edit</code> cluster role is applied by the <code>ibm-edit</code> role binding, providing the following permissions in the <code>default</code> namespace:
      <ul><li>Read/write access to resources inside the default namespace</li></ul></td>
  </tr>
  <tr>
    <td>**Operator**</td>
    <td>This role has all permissions from the Viewer role, plus the following:</br></br>
      Cluster:<ul>
        <li>Update a cluster</li>
        <li>Refresh the Kubernetes master</li>
        <li>Add and remove worker nodes</li>
        <li>Reboot, reload, and update worker nodes</li>
        <li>Create and delete worker pools</li>
        <li>Add and remove zones from worker pools</li>
        <li>Update the network configuration for a given zone in worker pools</li>
        <li>Resize and rebalance worker pools</li>
        <li>Create and add subnets to a cluster</li>
        <li>Add and remove user-managed subnets to and from a cluster</li></ul>
    </td>
    <td>The <code>admin</code> cluster role is applied by the <code>ibm-operate</code> cluster role binding, providing the following permissions:<ul>
      <li>Read/write access to resources inside a namespace but not to the namespace itself</li>
      <li>Create RBAC roles within a namespace</li></ul></td>
  </tr>
  <tr>
    <td>**Administrator**</td>
    <td>This role has all permissions from the Editor, Operator, and Viewer roles for all clusters in this account, plus the following:</br></br>
      Cluster:<ul>
        <li>Create free or standard clusters</li>
        <li>Delete clusters</li>
        <li>Encrypt Kubernetes secrets by using {{site.data.keyword.keymanagementservicefull}}</li>
        <li>Set the API key for the {{site.data.keyword.Bluemix_notm}} account to access the linked IBM Cloud infrastructure (SoftLayer) portfolio</li>
        <li>Set, view, and remove infrastructure credentials for the {{site.data.keyword.Bluemix_notm}} account to access a different IBM Cloud infrastructure (SoftLayer) portfolio</li>
        <li>Assign and change IAM platform roles for other existing users in the account</li>
        <li>When set for all {{site.data.keyword.containerlong_notm}} instances (clusters) in all regions: List all available VLANs in the account</ul>
      Logging:<ul>
        <li>Create and update log forwarding configurations for type `kube-audit`</li>
        <li>Collect a snapshot of API server logs in an {{site.data.keyword.cos_full_notm}} bucket</li>
        <li>Enable and disable automatic updates for the Fluentd cluster add-on</li></ul>
      Ingress:<ul>
        <li>List all or view details for ALB secrets in a cluster</li>
        <li>Deploy a certificate from your {{site.data.keyword.cloudcerts_long_notm}} instance to an ALB</li>
        <li>Update or remove ALB secrets from a cluster</li>
      <strong>Note</strong>: To create resources such as machines, VLANs, and subnets, Administrator users need the **Super user** infrastructure role.
    </td>
    <td>The <code>cluster-admin</code> cluster role is applied by the <code>ibm-admin</code> cluster role binding, providing the following permissions:
      <ul><li>Read/write access to resources in every namespace</li>
      <li>Create RBAC roles within a namespace</li>
      <li>Access the Kubernetes dashboard</li>
      <li>Create an Ingress resource that makes apps publicly available</li></ul>
    </td>
  </tr>
</table>

## Cloud Foundry
{: #cloud-foundry}

Cloud Foundry roles grant access to organizations and spaces within the account. To see the list of Cloud Foundry-based services in {{site.data.keyword.Bluemix_notm}}, run `ibmcloud service list`. To learn more, see all available [org and space roles](/docs/iam/cfaccess.html) or the steps for [managing Cloud Foundry access](/docs/iam/mngcf.html) in the IAM documentation.

The following table shows the Cloud Foundry roles required for cluster action permissions.

<table>
  <tr>
    <th>Cloud Foundry role</th>
    <th>Cluster management permissions</th>
  </tr>
  <tr>
    <td>Space role: Manager</td>
    <td>Manage user access to an {{site.data.keyword.Bluemix_notm}} space</td>
  </tr>
  <tr>
    <td>Space role: Developer</td>
    <td>
      <ul><li>Create {{site.data.keyword.Bluemix_notm}} service instances</li>
      <li>Bind {{site.data.keyword.Bluemix_notm}} service instances to clusters</li>
      <li>View logs from a cluster's log forwarding configuration at the space level</li></ul>
    </td>
  </tr>
</table>

## Infrastructure
{: #infra}

**Note**: When a user with the **Super User** infrastructure access role [sets the API key for a region and resource group](cs_users.html#api_key), infrastructure permissions for the other users in the account are set by IAM platform roles. You do not need to edit the other users' IBM Cloud infrastructure (SoftLayer) permissions. Only use the following table to customize users' IBM Cloud infrastructure (SoftLayer) permissions when you can't assign **Super User** to the user who sets the API key. For more information, see [Customizing infrastructure permissions](cs_users.html#infra_access).

The following table shows the infrastructure permissions required to complete groups of common tasks.

<table summary="Infrastructure permissions for common {{site.data.keyword.containerlong_notm}} scenarios.">
 <caption>Commonly required infrastructure permissions for {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Common tasks in {{site.data.keyword.containerlong_notm}}</th>
  <th>Required infrastructure permissions by tab</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Minimum permissions</strong>: <ul><li>Create a cluster.</li></ul></td>
     <td><strong>Devices</strong>:<ul><li>View Virtual Server Details</li><li>Reboot server and view IPMI system information</li><li>Issue OS Reloads and Initiate Rescue Kernel</li></ul><strong>Account</strong>: <ul><li>Add/Upgrade Cloud Instances</li><li>Add Server</li></ul></td>
   </tr>
   <tr>
     <td><strong>Cluster Administration</strong>: <ul><li>Create, update, and delete clusters.</li><li>Add, reload, and reboot worker nodes.</li><li>View VLANs.</li><li>Create subnets.</li><li>Deploy pods and load balancer services.</li></ul></td>
     <td><strong>Support</strong>:<ul><li>View Tickets</li><li>Add Tickets</li><li>Edit Tickets</li></ul>
     <strong>Devices</strong>:<ul><li>View Virtual Server Details</li><li>Reboot server and view IPMI system information</li><li>Upgrade Server</li><li>Issue OS Reloads and Initiate Rescue Kernel</li></ul>
     <strong>Services</strong>:<ul><li>Manage SSH Keys</li></ul>
     <strong>Account</strong>:<ul><li>View Account Summary</li><li>Add/Upgrade Cloud Instances</li><li>Cancel Server</li><li>Add Server</li></ul></td>
   </tr>
   <tr>
     <td><strong>Storage</strong>: <ul><li>Create persistent volume claims to provision persistent volumes.</li><li>Create and manage storage infrastructure resources.</li></ul></td>
     <td><strong>Services</strong>:<ul><li>Manage Storage</li></ul><strong>Account</strong>:<ul><li>Add Storage</li></ul></td>
   </tr>
   <tr>
     <td><strong>Private Networking</strong>: <ul><li>Manage private VLANs for in-cluster networking.</li><li>Set up VPN connectivity to private networks.</li></ul></td>
     <td><strong>Network</strong>:<ul><li>Manage Network Subnet Routes</li></ul></td>
   </tr>
   <tr>
     <td><strong>Public Networking</strong>:<ul><li>Set up public load balancer or Ingress networking to expose apps.</li></ul></td>
     <td><strong>Devices</strong>:<ul><li>Edit Hostname/Domain</li><li>Manage Port Control</li></ul>
     <strong>Network</strong>:<ul><li>Add Compute with Public Network Port</li><li>Manage Network Subnet Routes</li><li>Add IP Addresses</li></ul>
     <strong>Services</strong>:<ul><li>Manage DNS, Reverse DNS, and WHOIS</li><li>View Certificates (SSL)</li><li>Manage Certificates (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>

## Minimum permissions required per action
{: #commands}

The following tables show the minimum permissions that are required to run each cluster management, logging, or Ingress action as a {{site.data.keyword.containerlong_notm}} CLI plug-in command or API call. The actions that are listed as `None` indicate that any user in your account who runs the CLI command or makes the API call sees the result, even if the user has no assigned permissions.

**Note**: These tables show the minimum required permissions for each action. [The permissions allowed by some roles](#platform) are included in other roles as follows:
*	The **Administrator** IAM role includes all permissions that are granted by the **Viewer**, **Editor**, and **Operator** roles.
*	The **Editor** and **Operator** roles include the permissions that are granted by **Viewer**.
*	The **Viewer** role includes the permissions that are granted by None role.

The tables are organized alphabetically by CLI command name.

### Cluster management actions
{: #cluster-actions}

<table>
<caption>Minimum required permissions for each cluster management action</caption>
<thead>
<th colspan=2>Minimum required permissions for each cluster management action</th>
</thead>
<tbody>

<tr>
<td>Target or view the API endpoint for {{site.data.keyword.containerlong_notm}}.
<ul><li>[ibmcloud ks api](cs_cli_reference.html#cs_api)</li></ul></td>
<td>None</td>
</tr><tr>

<td>View the name and email address for the owner of the IAM API key for a resource group and region.
<ul><li>[ibmcloud ks api-key-info](cs_cli_reference.html#cs_api_key_info)</li>
<li>[GET /v1/logging/{idOrName}/clusterkeyowner](https://containers.bluemix.net/swagger-logging/#!/logging/GetClusterKeyOwner)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Set the API key for the {{site.data.keyword.Bluemix_notm}} account to access the linked IBM Cloud infrastructure (SoftLayer) portfolio.
<ul><li>[ibmcloud ks api-key-reset](cs_cli_reference.html#cs_api_key_reset)</li>
<li>[POST /v1/keys](https://containers.bluemix.net/swagger-api/#!/accounts/ResetUserAPIKey)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>Refresh the Kubernetes master.
<ul><li>[ibmcloud ks apiserver-refresh](cs_cli_reference.html#cs_apiserver_refresh)</li>
<li>[PUT /v1/clusters/{idOrName}/masters](https://containers.bluemix.net/swagger-api/#!/clusters/HandleMasterAPIServer)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Download Kubernetes configuration data and certificates to connect to your cluster and run `kubectl` commands.
<ul><li>[ibmcloud ks cluster-config](cs_cli_reference.html#cs_cluster_config)</li>
<li>[GET /v1/clusters/{idOrName}/config](https://containers.bluemix.net/swagger-api/#!/clusters/GetClusterConfig)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Create a free or standard cluster.
<ul><li>[ibmcloud ks cluster-create](cs_cli_reference.html#cs_cluster_create)</li>
<li>[POST /v1/clusters](https://containers.bluemix.net/swagger-api/#!/clusters/CreateCluster)</li></ul></td>
<td>IAM: Administrator for {{site.data.keyword.containerlong_notm}}, Administrator for {{site.data.keyword.registrylong_notm}} <br> RBAC: cluster-admin <br> Infrastructure: Super User</td>
</tr><tr>

<td>Enable a specified feature for a cluster, such as Trusted Compute for bare metal worker nodes.
<ul><li>[ibmcloud ks cluster-feature-enable](cs_cli_reference.html#cs_cluster_feature_enable)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>View information for a cluster.
<ul><li>[ibmcloud ks cluster-get](cs_cli_reference.html#cs_cluster_get)</li>
<li>[GET /v1/clusters/{idOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/GetCluster)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Delete a cluster.
<ul><li>[ibmcloud ks cluster-rm](cs_cli_reference.html#cs_cluster_rm)</li>
<li>[DELETE /v1/clusters/{idOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveCluster)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>Bind a service to a cluster.
<ul><li>[ibmcloud ks cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</li>
<li>[POST /v1/clusters/{idOrName}/services](https://containers.bluemix.net/swagger-api/#!/clusters/BindServiceToNamespace)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit <br> Cloud Foundry: Developer in the space that the service is in</td>
</tr><tr>

<td>Unbind a service from a cluster.
<ul><li>[ibmcloud ks cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</li>
<li>[DELETE /v1/clusters/{idOrName}/services/{namespace}/{serviceInstanceId}](https://containers.bluemix.net/swagger-api/#!/clusters/UnbindServiceFromNamespace)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit <br> Cloud Foundry: Developer in the space that the service is in</td>
</tr><tr>

<td>List all services in all namespaces that are bound to a cluster.
<ul><li>[ibmcloud ks cluster-services](cs_cli_reference.html#cs_cluster_services)</li>
<li>[GET /v1/clusters/{idOrName}/services](https://containers.bluemix.net/swagger-api/#!/clusters/ListServicesForAllNamespaces)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>List all services bound to a specific namespace.
<ul><li>[GET /v1/clusters/{idOrName}/services/{namespace}](https://containers.bluemix.net/swagger-api/#!/clusters/ListServicesInNamespace)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Add a subnet to a cluster.
<ul><li>[ibmcloud ks cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</li>
<li>[PUT /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.bluemix.net/swagger-api/#!/clusters/AddClusterSubnet)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Create a subnet.
<ul><li>[ibmcloud ks cluster-subnet-create](cs_cli_reference.html#cs_cluster_subnet_create)</li>
<li>[POST /v1/clusters/{idOrName}/vlans/{vlanId}](https://containers.bluemix.net/swagger-api/#!/clusters/CreateClusterSubnet)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Update a cluster.
<ul><li>[ibmcloud ks cluster-update](cs_cli_reference.html#cs_cluster_update)</li>
<li>[PUT /v1/clusters/{idOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateCluster)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Add a user-managed subnet to a cluster.
<ul><li>[ibmcloud ks cluster-user-subnet-add](cs_cli_reference.html#cs_cluster_user_subnet_add)</li>
<li>[POST /v1/clusters/{idOrName}/usersubnets](https://containers.bluemix.net/swagger-api/#!/clusters/AddClusterUserSubnet)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Remove a user-managed subnet from a cluster.
<ul><li>[ibmcloud ks cluster-user-subnet-rm](cs_cli_reference.html#cs_cluster_user_subnet_rm)</li>
<li>[DELETE /v1/clusters/{idOrName}/usersubnets/{subnetId}/vlans/{vlanId}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveClusterUserSubnet)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>List all user-managed subnets that are bound to a cluster.
<ul><li>[GET /v1/clusters/{idOrName}/usersubnets](https://containers.bluemix.net/swagger-api/#!/clusters/GetClusterUserSubnet)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>List all clusters.
<ul><li>[ibmcloud ks clusters](cs_cli_reference.html#cs_clusters)</li>
<li>[GET /v1/clusters](https://containers.bluemix.net/swagger-api/#!/clusters/GetClusters)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Set infrastructure credentials for the {{site.data.keyword.Bluemix_notm}} account to access a different IBM Cloud infrastructure (SoftLayer) portfolio.
<ul><li>[ibmcloud ks credentials-set](cs_cli_reference.html#cs_credentials_set)</li>
<li>[POST /v1/credentials](https://containers.bluemix.net/swagger-api/#!/clusters/accounts/StoreUserCredentials)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>Remove infrastructure credentials for the {{site.data.keyword.Bluemix_notm}} account to access a different IBM Cloud infrastructure (SoftLayer) portfolio.
<ul><li>[ibmcloud ks credentials-unset](cs_cli_reference.html#cs_credentials_unset)</li>
<li>[DELETE /v1/credentials](https://containers.bluemix.net/swagger-api/#!/clusters/accounts/RemoveUserCredentials)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>Get the infrastructure credentials that are set for the {{site.data.keyword.Bluemix_notm}} account to access a different IBM Cloud infrastructure (SoftLayer) portfolio.
<ul><li>[GET /v1/credentials](https://containers.bluemix.net/swagger-api/#!/accounts/GetUserCredentials)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>View a list of supported commands and parameters.
<ul><li>[ibmcloud ks help](cs_cli_reference.html#cs_help)</li></ul></td>
<td>None</td>
</tr><tr>

<td>Initialize the {{site.data.keyword.containerlong_notm}} plug-in or specify the region where you want to create or access Kubernetes clusters.
<ul><li>[ibmcloud ks init](cs_cli_reference.html#cs_init)</li></ul></td>
<td>None</td>
</tr><tr>

<td>Encrypt Kubernetes secrets by using {{site.data.keyword.keymanagementservicefull}}.
<ul><li>[ibmcloud ks key-protect-enable](cs_cli_reference.html#cs_messages)</li>
<li>[POST /v1/clusters/{idOrName}/kms](https://containers.bluemix.net/swagger-api/#!/clusters/CreateKMSConfig)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>View a list of Kubernetes versions supported in {{site.data.keyword.containerlong_notm}}. <ul><li>[ibmcloud ks kube-versions](cs_cli_reference.html#cs_kube_versions)</li>
<li>[GET /v1/kube-versions](https://containers.bluemix.net/swagger-api/#!/util/GetKubeVersions)</li></ul></td>
<td>None</td>
</tr><tr>

<td>View a list of available machine types for your worker nodes.
<ul><li>[ibmcloud ks machine-types](cs_cli_reference.html#cs_machine_types)</li>
<li>[GET /v1/datacenters/{datacenter}/machine-types](https://containers.bluemix.net/swagger-api/#!/util/GetDatacenterMachineTypes)</li></ul></td>
<td>None</td>
</tr><tr>

<td>View current messages for the IBMid user.
<ul><li>[ibmcloud ks messages](cs_cli_reference.html#cs_messages)</li>
<li>[GET /v1/messages](https://containers.bluemix.net/swagger-api/#!/util/GetMessages)</li></ul></td>
<td>None</td>
</tr><tr>

<td>Find the {{site.data.keyword.containerlong_notm}} region that you are currently in.
<ul><li>[ibmcloud ks region](cs_cli_reference.html#cs_region)</li></ul></td>
<td>None</td>
</tr><tr>

<td>Set the region for {{site.data.keyword.containerlong_notm}}.
<ul><li>[ibmcloud ks region-set](cs_cli_reference.html#cs_region-set)</li></ul></td>
<td>None</td>
</tr><tr>

<td>Lists the available regions.
<ul><li>[ibmcloud ks regions](cs_cli_reference.html#cs_regions)</li>
<li>[GET /v1/regions](https://containers.bluemix.net/swagger-api/#!/util/GetRegions)</li></ul></td>
<td>None</td>
</tr><tr>

<td>List available subnets in the infrastructure account.
<ul><li>[ibmcloud ks subnets](cs_cli_reference.html#cs_subnets)</li>
<li>[GET /v1/subnets](https://containers.bluemix.net/swagger-api/#!/properties/ListSubnets)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>View a vulnerability assessment report for a container in your cluster.
<ul><li>[ibmcloud ks va](cs_cli_reference.html#cs_va)</li></ul></td>
<td>IAM: Reader service access role for {{site.data.keyword.containerlong_notm}}</td>
</tr><tr>

<td>View the VLAN spanning status for the infrastructure account.
<ul><li>[ibmcloud ks vlan-spanning-get](cs_cli_reference.html#cs_vlan_spanning_get)</li>
<li>[GET /v1/subnets/vlan-spanning](https://containers.bluemix.net/swagger-api/#!/accounts/GetVlanSpanning)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>When set for one cluster: List VLANs that the cluster is connected to in a zone. When set for all clusters in the account: List all available VLANs in a zone.
<ul><li>[ibmcloud ks vlans](cs_cli_reference.html#cs_vlans)</li>
<li>[GET /v1/datacenters/{datacenter}/vlans](https://containers.bluemix.net/swagger-api/#!/properties/GetDatacenterVLANs)</li></ul></td>
<td>IAM: Viewer for one or all clusters in the account <br> RBAC: view</td>
</tr><tr>

<td>Create a webhook in a cluster.
<ul><li>[ibmcloud ks webhook-create](cs_cli_reference.html#cs_webhook_create)</li>
<li>[POST /v1/clusters/{idOrName}/webhooks](https://containers.bluemix.net/swagger-api/#!/clusters/AddClusterWebhooks)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>List all webhooks for a cluster.
<ul><li>[GET /v1/clusters/{idOrName}/webhooks](https://containers.bluemix.net/swagger-api/#!/clusters/GetClusterWebhooks)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Add worker nodes.
<ul><li>[ibmcloud ks worker-add (deprecated)](cs_cli_reference.html#cs_worker_add)</li>
<li>[POST /v1/clusters/{idOrName}/workers](https://containers.bluemix.net/swagger-api/#!/clusters/AddClusterWorkers)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>View information for a worker node.
<ul><li>[ibmcloud ks worker-get](cs_cli_reference.html#cs_worker_get)</li>
<li>[GET /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/GetWorkers)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Create a worker pool.
<ul><li>[ibmcloud ks worker-pool-create](cs_cli_reference.html#cs_worker_pool_create)</li>
<li>[POST /v1/clusters/{idOrName}/workerpools](https://containers.bluemix.net/swagger-api/#!/clusters/CreateWorkerPool)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>View information for a worker pool.
<ul><li>[ibmcloud ks worker-pool-get](cs_cli_reference.html#cs_worker_pool_get)</li>
<li>[GET /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/GetWorkerPool)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Rebalance a worker pool.
<ul><li>[ibmcloud ks worker-pool-rebalance](cs_cli_reference.html#cs_rebalance)</li>
<li>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/PatchWorkerPool)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Resize a worker pool.
<ul><li>[ibmcloud ks worker-pool-resize](cs_cli_reference.html#cs_worker_pool_resize)</li>
<li>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/PatchWorkerPool)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Delete a worker pool.
<ul><li>[ibmcloud ks worker-pool-rm](cs_cli_reference.html#cs_worker_pool_rm)</li>
<li>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveWorkerPool)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>List all worker pools in a cluster.
<ul><li>[ibmcloud ks worker-pools](cs_cli_reference.html#cs_worker_pools)</li>
<li>[GET /v1/clusters/{idOrName}/workerpools](https://containers.bluemix.net/swagger-api/#!/clusters/GetWorkerPools)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Reboot a worker node.
<ul><li>[ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot)</li>
<li>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateClusterWorker)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Reload a worker node.
<ul><li>[ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reload)</li>
<li>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateClusterWorker)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Remove a worker node.
<ul><li>[ibmcloud ks worker-rm](cs_cli_reference.html#cs_worker_rm)</li>
<li>[DELETE /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveClusterWorker)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Update a worker node.
<ul><li>[ibmcloud ks worker-update](cs_cli_reference.html#cs_worker_update)</li>
<li>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateClusterWorker)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>List all worker nodes in a cluster.
<ul><li>[ibmcloud ks workers](cs_cli_reference.html#cs_workers)</li>
<li>[GET /v1/clusters/{idOrName}/workers](https://containers.bluemix.net/swagger-api/#!/clusters/GetClusterWorkers)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Add a zones to a worker pool.
<ul><li>[ibmcloud ks zone-add](cs_cli_reference.html#cs_zone_add)</li>
<li>[POST /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones](https://containers.bluemix.net/swagger-api/#!/clusters/AddWorkerPoolZone)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Update the network configuration for a given zone in a worker pool.
<ul><li>[ibmcloud ks zone-network-set](cs_cli_reference.html#cs_zone_network_set)</li>
<li>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.bluemix.net/swagger-api/#!/clusters/AddWorkerPoolZoneNetwork)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>Remove a zone a from worker pool.
<ul><li>[ibmcloud ks zone-rm](cs_cli_reference.html#cs_zone_rm)</li>
<li>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveWorkerPoolZone)</li></ul></td>
<td>IAM: Operator <br> RBAC: admin</td>
</tr><tr>

<td>View a list of available zones for you to create a cluster in.
<ul><li>[ibmcloud ks zones](cs_cli_reference.html#cs_datacenters)</li>
<li>[GET /v1/zones](https://containers.bluemix.net/swagger-api/#!/util/GetZones)</li></ul></td>
<td>None</td></tr>
</tbody>
</table>

### Logging actions
{: #logging-actions}

<table>
<caption>Minimum required permissions for each logging action</caption>
<thead>
<th colspan=2>Minimum required permissions for each logging action</th>
</thead>
<tbody>
<tr>

<td>View details for an API server audit webhook.
<ul><li>[ibmcloud ks apiserver-config-get](cs_cli_reference.html#s_apiserver_config_get)</li>
<li>[GET /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.bluemix.net/swagger-api/#!/apiserverconfigs/GetAuditWebhook)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Create an API server audit webhook.
<ul><li>[ibmcloud ks apiserver-config-set](cs_cli_reference.html#s_apiserver_config_set)</li>
<li>[PUT /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.bluemix.net/swagger-api/#!/clusters/apiserverconfigs/UpdateAuditWebhook)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>Delete an API server audit webhook.
<ul><li>[ibmcloud ks apiserver-config-unset](cs_cli_reference.html#s_apiserver_config_unset)</li>
<li>[DELETE /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.bluemix.net/swagger-api/#!/apiserverconfigs/DeleteAuditWebhook)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>Disable automatic updates for the Fluentd cluster add-on.
<ul><li>[ibmcloud ks logging-autoupdate-disable](cs_cli_reference.html#cs_log_autoupdate_disable)</li>
<li>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.bluemix.net/swagger-logging/#!/logging/ChangeUpdatePolicy)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>Enable automatic updates for the Fluentd cluster add-on.
<ul><li>[ibmcloud ks logging-autoupdate-enable](cs_cli_reference.html#cs_log_autoupdate_enable)</li>
<li>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.bluemix.net/swagger-logging/#!/logging/ChangeUpdatePolicy)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>View the status for automatic updates of the Fluentd add-on.<ul><li>[ibmcloud ks logging-autoupdate-get](cs_cli_reference.html#cs_log_autoupdate_get)</li>
<li>[GET /v1/logging/{idOrName}/updatepolicy](https://containers.bluemix.net/swagger-logging/#!/logging/GetUpdatePolicy)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Collect a snapshot of API server logs in an {{site.data.keyword.cos_full_notm}} bucket.
<ul><li>[ibmcloud ks logging-collect](cs_cli_reference.html#cs_log_collect)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>See the status of the API server logs snapshot request.
<ul><li>[ibmcloud ks logging-collect-status](cs_cli_reference.html#cs_log_collect_status)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>View the default logging endpoint for the target region.
<ul><li>[GET /v1/logging/{idOrName}/default](https://containers.bluemix.net/swagger-logging/#!/logging/GetDefaultLoggingEndpoint)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Create a log forwarding configuration.
<ul><li>[ibmcloud ks logging-config-create](cs_cli_reference.html#cs_logging_create)</li>
<li>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.bluemix.net/swagger-logging/#!/logging/CreateLoggingConfig)</li></ul></td>
<td>IAM: Editor for all log sources except <code>kube-audit</code>, Administrator for log source <code>kube-audit</code> <br> RBAC: edit for all log source except <code>kube-audit</code>, cluster-admin for log source <code>kube-audit</code></td>
</tr><tr>

<td>View information for a log forwarding configuration.
<ul><li>[ibmcloud ks logging-config-get](cs_cli_reference.html#cs_logging_get)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Refresh a log forwarding configuration.
<ul><li>[ibmcloud ks logging-config-refresh](cs_cli_reference.html#cs_logging_refresh)</li>
<li>[PUT /v1/logging/{idOrName}/refresh](https://containers.bluemix.net/swagger-logging/#!/logging/RefreshLoggingConfig)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>Delete a log forwarding configuration.
<ul><li>[ibmcloud ks logging-config-rm](cs_cli_reference.html#cs_logging_rm)</li>
<li>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.bluemix.net/swagger-logging/#!/logging/DeleteLoggingConfig)</li></ul></td>
<td>IAM: Editor for all log source except <code>kube-audit</code>, Administrator for log source <code>kube-audit</code> <br> RBAC: edit for all log source except <code>kube-audit</code>, cluster-admin for log source <code>kube-audit</code></td>
</tr><tr>

<td>Update a log forwarding configuration.
<ul><li>[ibmcloud ks logging-config-update](cs_cli_reference.html#cs_logging_update)</li>
<li>[PUT /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.bluemix.net/swagger-logging/#!/logging/UpdateLoggingConfig)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>Delete all log forwarding configurations for a cluster.
<ul><li>[DELETE /v1/logging/{idOrName}/loggingconfig](https://containers.bluemix.net/swagger-logging/#!/logging/DeleteLoggingConfigs)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>List all log forwarding configurations in the cluster.
<ul><li>[GET /v1/logging/{idOrName}/loggingconfig](https://containers.bluemix.net/swagger-logging/#!/logging/FetchLoggingConfigs)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>List all log forwarding configurations for a log source in the cluster.
<ul><li>[GET /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.bluemix.net/swagger-logging/#!/logging/FetchLoggingConfigsForSource)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Delete all logging filter configurations for the Kubernetes cluster.
<ul><li>[DELETE /v1/logging/{idOrName}/filterconfigs](https://containers.bluemix.net/swagger-logging/#!/filter/DeleteFilterConfigs)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>List all logging filter configurations in the cluster.
<ul><li>[GET /v1/logging/{idOrName}/filterconfigs](https://containers.bluemix.net/swagger-logging/#!/filter/FetchFilterConfigs)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Create a log filtering configuration.
<ul><li>[ibmcloud ks logging-filter-create](cs_cli_reference.html#cs_log_filter_create)</li>
<li>[POST /v1/logging/{idOrName}/filterconfigs](https://containers.bluemix.net/swagger-logging/#!/filter/CreateFilterConfig)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>View information for a log filtering configuration.
<ul><li>[ibmcloud ks logging-filter-get](cs_cli_reference.html#cs_log_filter_view)</li>
<li>[GET /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.bluemix.net/swagger-logging/#!/filter/FetchFilterConfig)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>Delete a log filtering configuration.
<ul><li>[ibmcloud ks logging-filter-rm](cs_cli_reference.html#cs_log_filter_delete)</li>
<li>[DELETE /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.bluemix.net/swagger-logging/#!/filter/DeleteFilterConfig)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>Update a log filtering configuration.
<ul><li>[ibmcloud ks logging-filter-update](cs_cli_reference.html#cs_log_filter_update)</li>
<li>[PUT /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.bluemix.net/swagger-logging/#!/filter/UpdateFilterConfig)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

</tbody></table>

### Ingress actions
{: #ingress-actions}

<table>
<caption>Minimum required permissions for each Ingress action</caption>
<thead>
<th colspan=2>Minimum required permissions for each Ingress action</th>
</thead>
<tbody>
<tr>
<td>Deploy or update a certificate from your {{site.data.keyword.cloudcerts_long_notm}} instance to an ALB.
<ul><li>[ibmcloud ks alb-cert-deploy](cs_cli_reference.html#cs_alb_cert_deploy)</li>
<li>[POST /albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/CreateALBSecret) or [PUT /albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/UpdateALBSecret)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>View details for an ALB secret in a cluster.
<ul><li>[ibmcloud ks alb-cert-get](cs_cli_reference.html#cs_alb_cert_get)</li>
<li>[GET /clusters/{idOrName}/albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/ViewClusterALBSecrets)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>Remove an ALB secret from a cluster.
<ul><li>[ibmcloud ks alb-cert-rm](cs_cli_reference.html#cs_alb_cert_rm)</li>
<li>[DELETE /clusters/{idOrName}/albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/DeleteClusterALBSecrets)</li></ul></td>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>List all ALB secrets in a cluster.
<ul><li>[ibmcloud ks alb-certs](cs_cli_reference.html#cs_alb_certs)</li>
<td>IAM: Administrator <br> RBAC: cluster-admin</td>
</tr><tr>

<td>Enable or disable an Ingress ALB.
<ul><li>[ibmcloud ks alb-configure](cs_cli_reference.html#cs_alb_configure)</li>
<li>[POST /albs](https://containers.bluemix.net/swagger-alb-api/#!/alb/EnableALB) and [DELETE /albs/{albId}](https://containers.bluemix.net/swagger-alb-api/#/)</li></ul></td>
<td>IAM: Editor <br> RBAC: edit</td>
</tr><tr>

<td>View information for an Ingress ALB.
<ul><li>[ibmcloud ks alb-get](cs_cli_reference.html#cs_alb_get)</li>
<li>[GET /albs/{albId}](https://containers.bluemix.net/swagger-alb-api/#!/alb/GetClusterALB)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>View ALB types that are supported in the region.
<ul><li>[ibmcloud ks alb-types](cs_cli_reference.html#cs_alb_types)</li>
<li>[GET /albtypes](https://containers.bluemix.net/swagger-alb-api/#!/util/GetAvailableALBTypes)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr><tr>

<td>List all Ingress ALBs in a cluster.<ul><li>[ibmcloud ks albs](cs_cli_reference.html#cs_albs)</li>
<li>[GET /clusters/{idOrName}](https://containers.bluemix.net/swagger-alb-api/#!/alb/GetClusterALBs)</li></ul></td>
<td>IAM: Viewer <br> RBAC: view</td>
</tr>
</tbody></table>
