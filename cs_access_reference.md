---

copyright:
  years: 2014, 2018
lastupdated: "2018-11-01"


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

<tr>
<td>Enable or disable an Ingress ALB.</td>
<td>[ibmcloud ks alb-configure](cs_cli_reference.html#cs_alb_configure)</td>
<td>[POST /albs](https://containers.bluemix.net/swagger-alb-api/#!/alb/EnableALB) and [DELETE /albs/{albId}](https://containers.bluemix.net/swagger-alb-api/#/)</td>
</tr>
</tbody>
</table>

<table>
<caption></caption>
<thead>
<th>Logging action</th>
<th>CLI command</th>
<th>API call</th>
</thead>
<tbody>
<tr>
<td>Create an API server audit webhook.</td>
<td>[ibmcloud ks apiserver-config-set](cs_cli_reference.html#cs_apiserver_config_set)</td>
<td>[PUT /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.bluemix.net/swagger-api/#!/clusters/apiserverconfigs/UpdateAuditWebhook)</td>
</tr><tr>
<td>Delete an API server audit webhook.</td>
<td>[ibmcloud ks apiserver-config-unset](cs_cli_reference.html#cs_apiserver_config_unset)</td>
<td>[DELETE /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.bluemix.net/swagger-api/#!/apiserverconfigs/DeleteAuditWebhook)</td>
</tr><tr>
<td>Create a log forwarding configuration for all log sources except <code>kube-audit</code>.</td>
<td>[ibmcloud ks logging-config-create](cs_cli_reference.html#cs_logging_create)</td>
<td>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.bluemix.net/swagger-logging/#!/logging/CreateLoggingConfig)</td>
</tr><tr>
<td>Refresh a log forwarding configuration.</td>
<td>[ibmcloud ks logging-config-refresh](cs_cli_reference.html#cs_logging_refresh)</td>
<td>[PUT /v1/logging/{idOrName}/refresh](https://containers.bluemix.net/swagger-logging/#!/logging/RefreshLoggingConfig)</td>
</tr><tr>
<td>Delete a log forwarding configuration for all log sources except <code>kube-audit</code>.</td>
<td>[ibmcloud ks logging-config-rm](cs_cli_reference.html#cs_logging_rm)</td>
<td>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.bluemix.net/swagger-logging/#!/logging/DeleteLoggingConfig)</td>
</tr><tr>
<td>Delete all log forwarding configurations for a cluster.</td>
<td>-</td>
<td>[DELETE /v1/logging/{idOrName}/loggingconfig](https://containers.bluemix.net/swagger-logging/#!/logging/DeleteLoggingConfigs)</td>
</tr><tr>
<td>Update a log forwarding configuration.</td>
<td>[ibmcloud ks logging-config-update](cs_cli_reference.html#cs_logging_update)</td>
<td>[PUT /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.bluemix.net/swagger-logging/#!/logging/UpdateLoggingConfig)</td>
</tr><tr>
<td>Create a log filtering configuration.</td>
<td>[ibmcloud ks logging-filter-create](cs_cli_reference.html#cs_log_filter_create)</td>
<td>[POST /v1/logging/{idOrName}/filterconfigs](https://containers.bluemix.net/swagger-logging/#!/filter/CreateFilterConfig)</td>
</tr><tr>
<td>Delete a log filtering configuration.</td>
<td>[ibmcloud ks logging-filter-rm](cs_cli_reference.html#cs_log_filter_delete)</td>
<td>[DELETE /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.bluemix.net/swagger-logging/#!/filter/DeleteFilterConfig)</td>
</tr><tr>
<td>Delete all logging filter configurations for the Kubernetes cluster.</td>
<td>-</td>
<td>[DELETE /v1/logging/{idOrName}/filterconfigs](https://containers.bluemix.net/swagger-logging/#!/filter/DeleteFilterConfigs)</td>
</tr><tr>
<td>Update a log filtering configuration.</td>
<td>[ibmcloud ks logging-filter-update](cs_cli_reference.html#cs_log_filter_update)</td>
<td>[PUT /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.bluemix.net/swagger-logging/#!/filter/UpdateFilterConfig)</td>
</tr>
</tbody>
</table>

### Operator actions
{: #operator-actions}

The **Operator** IAM platform role includes the permissions that are granted by **Viewer**, plus the following:

<table>
<caption></caption>
<thead>
<th>Cluster management action</th>
<th>CLI command</th>
<th>API call</th>
</thead>
<tbody>
<tr><td>Refresh the Kubernetes master.
</td><td>[ibmcloud ks apiserver-refresh](cs_cli_reference.html#cs_apiserver_refresh)</td>
<td>[PUT /v1/clusters/{idOrName}/masters](https://containers.bluemix.net/swagger-api/#!/clusters/HandleMasterAPIServer)</td>
<td>IAM platform: Operator <br> IAM service: Manager for all namespaces</td>
</tr><tr>
<td>Disable automatic updates of the Kubernetes master to the latest patch version. **Note**: This command is feature-flagged for select use cases only.</td>
<td>[ibmcloud ks cluster-autoupdate-disable](cs_cli_reference.html#cs_cluster_autoupdate_disable)</td>
<td>-</td>
</tr><tr>
<td>Enable automatic updates of the Kubernetes master to the latest patch version. **Note**: This command is feature-flagged for select use cases only.</td>
<td>[ibmcloud ks cluster-autoupdate-enable](cs_cli_reference.html#cs_cluster_autoupdate_enable)</td>
<td>-</td>
</tr><tr>
<td>View whether your cluster is set to automatically update the Kubernetes master to the latest patch version. **Note**: This command is feature-flagged for select use cases only.</td>
<td>[ibmcloud ks cluster-autoupdate-get](cs_cli_reference.html#cs_cluster_autoupdate_get)</td>
<td>-</td>
</tr><tr>
<td>Add a subnet to a cluster.
</td><td>[ibmcloud ks cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
<td>[PUT /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.bluemix.net/swagger-api/#!/clusters/AddClusterSubnet)</td>
</tr><tr>
<td>Create a subnet.
</td><td>[ibmcloud ks cluster-subnet-create](cs_cli_reference.html#cs_cluster_subnet_create)</td>
<td>[POST /v1/clusters/{idOrName}/vlans/{vlanId}](https://containers.bluemix.net/swagger-api/#!/clusters/CreateClusterSubnet)</td>
</tr><tr>
<td>Update a cluster.
</td><td>[ibmcloud ks cluster-update](cs_cli_reference.html#cs_cluster_update)</td>
<td>[PUT /v1/clusters/{idOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateCluster)</td>
</tr><tr>
<td>Add a user-managed subnet to a cluster.
</td><td>[ibmcloud ks cluster-user-subnet-add](cs_cli_reference.html#cs_cluster_user_subnet_add)</td>
<td>[POST /v1/clusters/{idOrName}/usersubnets](https://containers.bluemix.net/swagger-api/#!/clusters/AddClusterUserSubnet)</td>
</tr><tr>
<td>Remove a user-managed subnet from a cluster.
</td><td>[ibmcloud ks cluster-user-subnet-rm](cs_cli_reference.html#cs_cluster_user_subnet_rm)</td>
<td>[DELETE /v1/clusters/{idOrName}/usersubnets/{subnetId}/vlans/{vlanId}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveClusterUserSubnet)</td>
</tr><tr>
<td>Add worker nodes.
</td><td>[ibmcloud ks worker-add (deprecated)](cs_cli_reference.html#cs_worker_add)</td>
<td>[POST /v1/clusters/{idOrName}/workers](https://containers.bluemix.net/swagger-api/#!/clusters/AddClusterWorkers)</td>
</tr><tr>
<td>Create a worker pool.
</td><td>[ibmcloud ks worker-pool-create](cs_cli_reference.html#cs_worker_pool_create)</td>
<td>[POST /v1/clusters/{idOrName}/workerpools](https://containers.bluemix.net/swagger-api/#!/clusters/CreateWorkerPool)</td>
</tr><tr>
<td>Rebalance a worker pool.
</td><td>[ibmcloud ks worker-pool-rebalance](cs_cli_reference.html#cs_rebalance)</td>
<td>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/PatchWorkerPool)</td>
</tr><tr>
<td>Resize a worker pool.
</td><td>[ibmcloud ks worker-pool-resize](cs_cli_reference.html#cs_worker_pool_resize)</td>
<td>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/PatchWorkerPool)</td>
</tr><tr>
<td>Delete a worker pool.
</td><td>[ibmcloud ks worker-pool-rm](cs_cli_reference.html#cs_worker_pool_rm)</td>
<td>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveWorkerPool)</td>
</tr><tr>
<td>Reboot a worker node.
</td><td>[ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
<td>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateClusterWorker)</td>
</tr><tr>
<td>Reload a worker node.
</td><td>[ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reload)</td>
<td>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateClusterWorker)</td>
</tr><tr>
<td>Remove a worker node.
</td><td>[ibmcloud ks worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
<td>[DELETE /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveClusterWorker)</td>
</tr><tr>
<td>Update a worker node.
</td><td>[ibmcloud ks worker-update](cs_cli_reference.html#cs_worker_update)</td>
<td>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.bluemix.net/swagger-api/#!/clusters/UpdateClusterWorker)</td>
</tr><tr>
<td>Add a zones to a worker pool.
</td><td>[ibmcloud ks zone-add](cs_cli_reference.html#cs_zone_add)</td>
<td>[POST /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones](https://containers.bluemix.net/swagger-api/#!/clusters/AddWorkerPoolZone)</td>
</tr><tr>
<td>Update the network configuration for a given zone in a worker pool.
</td><td>[ibmcloud ks zone-network-set](cs_cli_reference.html#cs_zone_network_set)</td>
<td>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.bluemix.net/swagger-api/#!/clusters/AddWorkerPoolZoneNetwork)</td>
</tr><tr>
<td>Remove a zone a from worker pool.
</td><td>[ibmcloud ks zone-rm](cs_cli_reference.html#cs_zone_rm)</td>
<td>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveWorkerPoolZone)</td>
</tr>
</tbody>
</table>

### Administrator actions
{: #admin-actions}

The **Administrator** IAM platform role includes all permissions that are granted by the **Viewer**, **Editor**, and **Operator** roles, plus the following. **Note**: To create resources such as machines, VLANs, and subnets, Administrator users need the **Super user** <a href="#infra">infrastructure role</a>.

<table>
<caption></caption>
<thead>
<th>Cluster management action</th>
<th>CLI command</th>
<th>API call</th>
</thead>
<tbody>
<tr>
<td>Set the API key for the {{site.data.keyword.Bluemix_notm}} account to access the linked IBM Cloud infrastructure (SoftLayer) portfolio.
</td><td>[ibmcloud ks api-key-reset](cs_cli_reference.html#cs_api_key_reset)</td>
<td>[POST /v1/keys](https://containers.bluemix.net/swagger-api/#!/accounts/ResetUserAPIKey)</td>
</tr><tr>
<td>Create a free or standard cluster. **Note**: The Administrator IAM platform role for {{site.data.keyword.registrylong_notm}} and the Super User infrastructure role are also required.
</td><td>[ibmcloud ks cluster-create](cs_cli_reference.html#cs_cluster_create)</td>
<td>[POST /v1/clusters](https://containers.bluemix.net/swagger-api/#!/clusters/CreateCluster)</td>
</tr><tr>
<td>Enable a specified feature for a cluster, such as Trusted Compute for bare metal worker nodes.
</td><td>[ibmcloud ks cluster-feature-enable](cs_cli_reference.html#cs_cluster_feature_enable)</td>
<td>-</td>
</tr><tr>
<td>Delete a cluster.
</td><td>[ibmcloud ks cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
<td>[DELETE /v1/clusters/{idOrName}](https://containers.bluemix.net/swagger-api/#!/clusters/RemoveCluster)</td>
</tr><tr>
<td>Set infrastructure credentials for the {{site.data.keyword.Bluemix_notm}} account to access a different IBM Cloud infrastructure (SoftLayer) portfolio.
</td><td>[ibmcloud ks credential-set](cs_cli_reference.html#cs_credentials_set)</td>
<td>[POST /v1/credentials](https://containers.bluemix.net/swagger-api/#!/clusters/accounts/StoreUserCredentials)</td>
</tr><tr>
<td>Remove infrastructure credentials for the {{site.data.keyword.Bluemix_notm}} account to access a different IBM Cloud infrastructure (SoftLayer) portfolio.
</td><td>[ibmcloud ks credential-unset](cs_cli_reference.html#cs_credentials_unset)</td>
<td>[DELETE /v1/credentials](https://containers.bluemix.net/swagger-api/#!/clusters/accounts/RemoveUserCredentials)</td>
</tr><tr>
<td>Encrypt Kubernetes secrets by using {{site.data.keyword.keymanagementservicefull}}.
</td><td>[ibmcloud ks key-protect-enable](cs_cli_reference.html#cs_messages)</td>
<td>[POST /v1/clusters/{idOrName}/kms](https://containers.bluemix.net/swagger-api/#!/clusters/CreateKMSConfig)</td>
</tr>
</tbody>
</table>

<table>
<caption></caption>
<thead>
<th>Ingress action</th>
<th>CLI command</th>
<th>API call</th>
</thead>
<tbody>
<tr>
<td>Deploy or update a certificate from your {{site.data.keyword.cloudcerts_long_notm}} instance to an ALB.</td>
<td>[ibmcloud ks alb-cert-deploy](cs_cli_reference.html#cs_alb_cert_deploy)</td>
<td>[POST /albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/CreateALBSecret) or [PUT /albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/UpdateALBSecret)</td>
</tr><tr>
<td>View details for an ALB secret in a cluster.</td>
<td>[ibmcloud ks alb-cert-get](cs_cli_reference.html#cs_alb_cert_get)</td>
<td>[GET /clusters/{idOrName}/albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/ViewClusterALBSecrets)</td>
</tr><tr>
<td>Remove an ALB secret from a cluster.</td>
<td>[ibmcloud ks alb-cert-rm](cs_cli_reference.html#cs_alb_cert_rm)</td>
<td>[DELETE /clusters/{idOrName}/albsecrets](https://containers.bluemix.net/swagger-alb-api/#!/alb/DeleteClusterALBSecrets)</td>
</tr><tr>
<td>List all ALB secrets in a cluster.</td>
<td>[ibmcloud ks alb-certs](cs_cli_reference.html#cs_alb_certs)</td>
<td>-</td>
</tr>
</tbody>
</table>

<table>
<caption></caption>
<thead>
<th>Logging action</th>
<th>CLI command</th>
<th>API call</th>
</thead>
<tbody>
<tr>
<td>Disable automatic updates for the Fluentd cluster add-on.</td>
<td>[ibmcloud ks logging-autoupdate-disable](cs_cli_reference.html#cs_log_autoupdate_disable)</td>
<td>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.bluemix.net/swagger-logging/#!/logging/ChangeUpdatePolicy)</td>
</tr><tr>
<td>Enable automatic updates for the Fluentd cluster add-on.</td>
<td>[ibmcloud ks logging-autoupdate-enable](cs_cli_reference.html#cs_log_autoupdate_enable)</td>
<td>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.bluemix.net/swagger-logging/#!/logging/ChangeUpdatePolicy)</td>
</tr><tr>
<td>Collect a snapshot of API server logs in an {{site.data.keyword.cos_full_notm}} bucket.</td>
<td>[ibmcloud ks logging-collect](cs_cli_reference.html#cs_log_collect)</td>
<td>-</td>
</tr><tr>
<td>See the status of the API server logs snapshot request.</td>
<td>[ibmcloud ks logging-collect-status](cs_cli_reference.html#cs_log_collect_status)</td>
<td>-</td>
</tr><tr>
<td>Create a log forwarding configuration for the <code>kube-audit</code> log source.</td>
<td>[ibmcloud ks logging-config-create](cs_cli_reference.html#cs_logging_create)</td>
<td>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.bluemix.net/swagger-logging/#!/logging/CreateLoggingConfig)</td>
</tr><tr>
<td>Delete a log forwarding configuration for the <code>kube-audit</code> log source.</td>
<td>[ibmcloud ks logging-config-rm](cs_cli_reference.html#cs_logging_rm)</td>
<td>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.bluemix.net/swagger-logging/#!/logging/DeleteLoggingConfig)</td>
</tr>
</tbody>
</table>

<br />


## Coming soon! IAM service roles (staging only)
{: #service}

Every user who is assigned an IAM service access role is also automatically assigned a corresponding Kubernetes role-based access control (RBAC) role in a specific namespace. To learn more about IAM service access roles, see [IAM service roles](cs_users.html#iam-service-namespaces). To learn more about RBAC roles, see [Assigning RBAC permissions](cs_users.html#role-binding).

Looking for which Kubernetes actions each service role grants through RBAC? See [Kubernetes resource permissions per RBAC role](#rbac).
{: tip}

The following table shows the Kubernetes resource permissions granted by each IAM service role and its corresponding RBAC role.

<table summary="The table shows Kubernetes resource permissions for IAM service roles and corresponding RBAC policies. Rows are to be read from the left to right, with the IAM service role in column one, the corresponding RBAC role in column two, and the Kubernetes resource permissions in column three.">
<caption>Kubernetes resource permissions by IAM service and corresponding RBAC roles</caption>
<thead>
    <th>IAM service role</th>
    <th>Corresponding RBAC role, binding, and scope</th>
    <th>Kubernetes resource permissions</th>
  </thead>
  <tr>
    <td>**Reader**</td>
    <td>When scoped to one namespace: <strong><code>view</code></strong> cluster role applied by the <strong><code>ibm-view</code></strong> role binding</br>When scoped to all namespaces: <strong><code>view</code></strong> cluster role applied by the <strong><code>ibm-view</code></strong> cluster role binding</td>
    <td><ul>
      <li>Read access to resources in a namespace</li>
      <li>No read access to roles and role bindings or to Kubernetes secrets</li>
      <li>Access the Kubernetes dashboard to view resources in a namespace</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Writer**</td>
    <td>When scoped to one namespace: <strong><code>edit</code></strong> cluster role applied by the <strong><code>ibm-edit</code></strong> role binding</br>When scoped to all namespaces: <strong><code>edit</code></strong> cluster role applied by the <strong><code>ibm-edit</code></strong> cluster role binding</td>
    <td><ul><li>Read/write access to resources in a namespace</li>
    <li>No read/write access to roles and role bindings</li>
    <li>Access the Kubernetes dashboard to view resources in a namespace</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Manager**</td>
    <td>When scoped to one namespace: <strong><code>admin</code></strong> cluster role applied by the <strong><code>ibm-operate</code></strong> role binding</br>When scoped to all namespaces: <strong><code>cluster-admin</code></strong> cluster role applied by the <strong><code>ibm-admin</code></strong> cluster role binding</td>
    <td>When scoped to one namespace:
      <ul><li>Read/write access to all resources in a namespace but not to the namespace itself</li>
      <li>Create RBAC roles and role bindings in a namespace</li>
      <li>Access the Kubernetes dashboard to view all resources in a namespace</li></ul>
    </br>When scoped to all namespaces:
        <ul><li>Read/write access to all resources in every namespace</li>
        <li>Create RBAC roles and role bindings in a namespace or cluster roles and cluster role bindings in all namespaces</li>
        <li>Access the Kubernetes dashboard</li>
        <li>Create an Ingress resource that makes apps publicly available</li>
        <li>Review cluster metrics such as with the <code>kubectl top nodes</code> or <code>kubectl get nodes</code> commands</li></ul>
    </td>
  </tr>
</table>

<br />


## Kubernetes resource permissions per RBAC role
{: #rbac}

Every user who is assigned an IAM service access role is also automatically assigned a corresponding, predefined Kubernetes role-based access control (RBAC) role.
{: shortdesc}

Wondering if you have the correct permissions to run a certain `kubectl` command on a resource in a namespace? Try the [`kubectl auth can-i` command ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-can-i-em-).
{: tip}

The following table shows the permissions that are granted by each RBAC role to individual Kubernetes resources. Permissions are shown as which verbs a user with that role can complete against the resource, such as "get", "list", "describe", "create", or "delete".

<table summary="Kubernetes resource permissions granted by each predefined RBAC role.">
 <caption>Kubernetes resource permissions granted by each predefined RBAC role</caption>
 <thead>
  <th>Kubernetes resource</th>
  <th><code>view</code></th>
  <th><code>edit</code></th>
  <th><code>admin</code> and <code>cluster-admin</code></th>
 </thead>
<tbody>
<tr>
  <td>bindings</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>configmaps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>endpoints </td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>events</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>limitranges</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>namespaces</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></br>**cluster-admin only:** <code>create</code>, <code>delete</code></td>
</tr><tr>
  <td>namespaces/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>persistentvolumeclaims</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/attach</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/exec</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/log</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/portforward</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>secrets</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>serviceaccounts</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
</tr><tr>
  <td>services</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>services/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.apps </td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>localsubjectaccessreviews</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code></td>
</tr><tr>
  <td>horizontalpodautoscalers.autoscaling</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>cronjobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>jobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.extensions </td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>ingresses.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>poddisruptionbudgets.policy</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>rolebindings</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>roles</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr>
</tbody>
</table>

<br />


</staging>

When you [assign cluster permissions](cs_users.html), it can be hard to judge which role you need to assign to a user. Use the tables in the following sections to determine the minimum level of permissions that are required to perform common tasks in {{site.data.keyword.containerlong}}.
{: shortdesc}

## IAM platform and Kubernetes RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}} is configured to use {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) roles. IAM platform roles determine the actions that users can perform on a cluster. Every user who is assigned an IAM platform role is also automatically assigned a corresponding Kubernetes role-based access control (RBAC) role in the default namespace. Additionally, IAM platform roles automatically set basic infrastructure permissions for users. To set IAM policies, see [Assigning IAM platform permissions](cs_users.html#platform). To learn more about RBAC roles, see [Assigning RBAC permissions](cs_users.html#role-binding).

The following table shows the cluster management permissions granted by each IAM platform role and the Kubernetes resource permissions for the corresponding RBAC roles.

<table summary="The table shows user permissions for IAM platform roles and corresponding RBAC policies. Rows are to be read from the left to right, with the IAM platform role in column one, the cluster permission in column two and the corresponding RBAC role in column three.">
<caption>Cluster management permissions by IAM platform and RBAC role</caption>
<thead>
    <th>IAM platform role</th>
    <th>Cluster management permissions</th>
    <th>Corresponding RBAC role and resource permissions</th>
</thead>
  <tr>
    <td>**Viewer**</td>
    <td>
      Cluster:<ul>
        <li>View the name and email address for the owner of the IAM API key for a resource group and region</li>
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
        <li>Assign and change IAM platform roles for other existing users in the account</li>
        <li>When set for all {{site.data.keyword.containerlong_notm}} instances (clusters) in all regions: List all available VLANs in the account</ul>
      Logging:<ul>
        <li>Create and update log forwarding configurations for type `kube-audit`</li>
        <li>Collect a snapshot of API server logs in an {{site.data.keyword.cos_full_notm}} bucket</li>
        <li>Enable and disable automatic updates for the Fluentd cluster add-on</li></ul>
      Ingress:<ul>
        <li>List all or view details for ALB secrets in a cluster</li>
        <li>Deploy a certificate from your {{site.data.keyword.cloudcerts_long_notm}} instance to an ALB</li>
        <li>Update or remove ALB secrets from a cluster</li></ul>
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



## Cloud Foundry roles
{: #cloud-foundry}

Cloud Foundry roles grant access to organizations and spaces within the account. To see the list of Cloud Foundry-based services in {{site.data.keyword.Bluemix_notm}}, run `ibmcloud service list`. To learn more, see all available [org and space roles](/docs/iam/cfaccess.html) or the steps for [managing Cloud Foundry access](/docs/iam/mngcf.html) in the IAM documentation.

The following table shows the Cloud Foundry roles required for cluster action permissions.

<table summary="The table shows user permissions for Cloud Foundry. Rows are to be read from the left to right, with the Cloud Foundry role in column one, and the cluster permission in column two.">
  <caption>Cluster management permissions by Cloud Foundry role</caption>
  <thead>
    <th>Cloud Foundry role</th>
    <th>Cluster management permissions</th>
  </thead>
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

## Infrastructure roles
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
