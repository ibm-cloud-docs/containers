---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-19"


---

{:new_window: target="blank"}
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

# User access permissions
{: #understanding}



When you [assign cluster permissions](cs_users.html), it can be hard to judge which role you need to assign to a user. Use the tables in the following sections to determine the minimum level of permissions that are required to perform common tasks in {{site.data.keyword.containerlong}}.
{: shortdesc}

## {{site.data.keyword.Bluemix_notm}} IAM platform and Kubernetes RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}} is configured to use {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) roles. {{site.data.keyword.Bluemix_notm}} IAM platform roles determine the actions that users can perform on a cluster. Every user who is assigned a platform role is also automatically assigned a corresponding Kubernetes role-based access control (RBAC) role in the default namespace. Additionally, platform roles automatically set basic infrastructure permissions for users. To set policies, see [Assigning {{site.data.keyword.Bluemix_notm}} IAM platform permissions](cs_users.html#platform). To learn more about RBAC roles, see [Assigning RBAC permissions](cs_users.html#role-binding).
{: shortdesc}

The following table shows the cluster management permissions granted by each platform role and the Kubernetes resource permissions for the corresponding RBAC roles.

<table summary="The table shows user permissions for IAM platform roles and corresponding RBAC policies. Rows are to be read from the left to right, with the IAM platform role in column one, the cluster permission in column two and the corresponding RBAC role in column three.">
<caption>Cluster management permissions by platform and RBAC role</caption>
<thead>
    <th>Platform role</th>
    <th>Cluster management permissions</th>
    <th>Corresponding RBAC role and resource permissions</th>
</thead>
<tbody>
  <tr>
    <td>**Viewer**</td>
    <td>
      Cluster:<ul>
        <li>View the name and email address for the owner of the {{site.data.keyword.Bluemix_notm}} IAM API key for a resource group and region</li>
        <li>If your {{site.data.keyword.Bluemix_notm}} account uses different credentials to access the IBM Cloud infrastructure (SoftLayer) portfolio, view the infrastructure user name</li>
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
        <li>Assign and change {{site.data.keyword.Bluemix_notm}} IAM platform roles for other existing users in the account</li>
        <li>When set for all {{site.data.keyword.containerlong_notm}} instances (clusters) in all regions: List all available VLANs in the account</ul>
      Logging:<ul>
        <li>Create and update log forwarding configurations for type `kube-audit`</li>
        <li>Collect a snapshot of API server logs in an {{site.data.keyword.cos_full_notm}} bucket</li>
        <li>Enable and disable automatic updates for the Fluentd cluster add-on</li></ul>
      Ingress:<ul>
        <li>List all or view details for ALB secrets in a cluster</li>
        <li>Deploy a certificate from your {{site.data.keyword.cloudcerts_long_notm}} instance to an ALB</li>
        <li>Update or remove ALB secrets from a cluster</li></ul>
      <p class="note">To create resources such as machines, VLANs, and subnets, Administrator users need the **Super user** infrastructure role.</p>
    </td>
    <td>The <code>cluster-admin</code> cluster role is applied by the <code>ibm-admin</code> cluster role binding, providing the following permissions:
      <ul><li>Read/write access to resources in every namespace</li>
      <li>Create RBAC roles within a namespace</li>
      <li>Access the Kubernetes dashboard</li>
      <li>Create an Ingress resource that makes apps publicly available</li></ul>
    </td>
  </tr>
  </tbody>
</table>



## Cloud Foundry roles
{: #cloud-foundry}

Cloud Foundry roles grant access to organizations and spaces within the account. To see the list of Cloud Foundry-based services in {{site.data.keyword.Bluemix_notm}}, run `ibmcloud service list`. To learn more, see all available [org and space roles](/docs/iam/cfaccess.html) or the steps for [managing Cloud Foundry access](/docs/iam/mngcf.html) in the {{site.data.keyword.Bluemix_notm}} IAM documentation.
{: shortdesc}

The following table shows the Cloud Foundry roles required for cluster action permissions.

<table summary="The table shows user permissions for Cloud Foundry. Rows are to be read from the left to right, with the Cloud Foundry role in column one, and the cluster permission in column two.">
  <caption>Cluster management permissions by Cloud Foundry role</caption>
  <thead>
    <th>Cloud Foundry role</th>
    <th>Cluster management permissions</th>
  </thead>
  <tbody>
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
  </tbody>
</table>

## Infrastructure roles
{: #infra}

When a user with the **Super User** infrastructure access role [sets the API key for a region and resource group](cs_users.html#api_key), infrastructure permissions for the other users in the account are set by {{site.data.keyword.Bluemix_notm}} IAM platform roles. You do not need to edit the other users' IBM Cloud infrastructure (SoftLayer) permissions. Only use the following table to customize users' IBM Cloud infrastructure (SoftLayer) permissions when you can't assign **Super User** to the user who sets the API key. For more information, see [Customizing infrastructure permissions](cs_users.html#infra_access).
{: shortdesc}

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
     <td><strong>Devices</strong>:<ul><li>View Virtual Server Details</li><li>Reboot server and view IPMI system information</li><li>Issue OS Reloads and Initiate Rescue Kernel</li></ul><strong>Account</strong>: <ul><li>Add Server</li></ul></td>
   </tr>
   <tr>
     <td><strong>Cluster Administration</strong>: <ul><li>Create, update, and delete clusters.</li><li>Add, reload, and reboot worker nodes.</li><li>View VLANs.</li><li>Create subnets.</li><li>Deploy pods and load balancer services.</li></ul></td>
     <td><strong>Support</strong>:<ul><li>View Tickets</li><li>Add Tickets</li><li>Edit Tickets</li></ul>
     <strong>Devices</strong>:<ul><li>View Hardware Details</li><li>View Virtual Server Details</li><li>Reboot server and view IPMI system information</li><li>Issue OS Reloads and Initiate Rescue Kernel</li></ul>
     <strong>Network</strong>:<ul><li>Add Compute with Public Network Port</li></ul>
     <strong>Account</strong>:<ul><li>Cancel Server</li><li>Add Server</li></ul></td>
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
