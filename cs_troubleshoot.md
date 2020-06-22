---

copyright:
  years: 2014, 2020
lastupdated: "2020-06-22"

keywords: kubernetes, iks, help, debug

subcollection: containers

---

{:beta: .beta}
{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}



# Clusters and masters
{: #cs_troubleshoot}

As you use {{site.data.keyword.containerlong}}, consider these techniques for general troubleshooting and debugging your cluster and cluster master.
{: shortdesc}

**General ways to resolve issues**<br>
1. Keep your cluster environment up to date.
   * Check monthly for available security and operating system patches to [update your worker nodes](/docs/containers?topic=containers-update#worker_node).
   * [Update your cluster](/docs/containers?topic=containers-update#master) to the latest default version for [{{site.data.keyword.containershort}}](/docs/containers?topic=containers-cs_versions).
2. Make sure that your command line tools are up to date.
   * In the terminal, you are notified when updates to the `ibmcloud` CLI and plug-ins are available. Be sure to keep your CLI up-to-date so that you can use all available commands and flags.
   * Make sure that [your `kubectl` CLI](/docs/containers?topic=containers-cs_cli_install#kubectl) client matches the same Kubernetes version as your cluster server. [Kubernetes does not support](https://kubernetes.io/docs/setup/release/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2).
<br>

**Reviewing issues and status**<br>
1. To see whether {{site.data.keyword.cloud_notm}} is available, [check the {{site.data.keyword.cloud_notm}} status page](https://cloud.ibm.com/status?selected=status){: external}.
2. Filter for the **Kubernetes Service** component.

## Running tests with the Diagnostics and Debug Tool
{: #debug_utility}
{: troubleshoot}
{: support}

While you troubleshoot, you can use the {{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool to run tests and gather pertinent information from your cluster.
{: shortdesc}

**Before you begin**:
If you previously installed the debug tool by using Helm, first uninstall the `ibmcloud-iks-debug` Helm chart.
1. Find the installation name of your Helm chart.
  ```
  helm list -n <namespace> | grep ibmcloud-iks-debug
  ```
  {: pre}

  Example output:
  ```
  <helm_chart_name> 1 Thu Sep 13 16:41:44 2019 DEPLOYED ibmcloud-iks-debug-1.0.0 default
  ```
  {: screen}

2. Uninstall the debug tool installation by deleting the Helm chart.
  ```
  helm uninstall <helm_chart_name> -n <namespace>
  ```
  {: pre}

3. Verify that the debug tool pods are removed. When the uninstallation is complete, no pods are returned by the following command.
  ```
  kubectl get pod --all-namespaces | grep ibmcloud-iks-debug
  ```
  {: pre}

</br>**To enable and use the Diagnostics and Debug Tool add-on:**

1. In your [cluster dashboard](https://cloud.ibm.com/kubernetes/clusters){: external}, click the name of the cluster where you want to install the debug tool add-on.

2. Click the **Add-ons** tab.

3. On the Diagnostics and Debug Tool card, click **Install**.

4. In the dialog box, click **Install**. Note that it can take a few minutes for the add-on to be installed. <p class="tip">To resolve some common issues that you might encounter during the add-on deployment, see [Reviewing add-on state and statuses](/docs/containers?topic=containers-cs_troubleshoot_addons#debug_addons).</p>

5. On the Diagnostics and Debug Tool card, click **Dashboard**.

6. In the debug tool dashboard, select individual tests or a group of tests to run. Some tests check for potential warnings, errors, or issues, and some tests only gather information that you can reference while you troubleshoot. For more information about the function of each test, click the information icon next to the test's name.

7. Click **Run**.

8. Check the results of each test.
  * If any test fails, click the information icon next to the test's name in the left column for information about how to resolve the issue.
  * You can also use the results of tests to gather information, such as complete YAMLs, that can help you debug your cluster in the following sections.

## Debugging clusters
{: #debug_clusters}
{: troubleshoot}
{: support}

Review the options to debug your clusters and find the root causes for failures.

1.  List your cluster and find the `State` of the cluster.

  ```
  ibmcloud ks cluster ls
  ```
  {: pre}

2.  Review the `State` of your cluster. If your cluster is in a **Critical**, **Delete failed**, or **Warning** state, or is stuck in the **Pending** state for a long time, start [debugging the worker nodes](/docs/containers?topic=containers-cs_troubleshoot_clusters#debug_worker_nodes).

    You can view the current cluster state by running the `ibmcloud ks cluster ls` command and locating the **State** field.
{: shortdesc}
    <table summary="Every table row should be read left to right, with the cluster state in column one and a description in column two.">
    <caption>Cluster states</caption>
       <thead>
       <th>Cluster state</th>
       <th>Description</th>
       </thead>
       <tbody>
    <tr>
       <td>`Aborted`</td>
       <td>The deletion of the cluster is requested by the user before the Kubernetes master is deployed. After the deletion of the cluster is completed, the cluster is removed from your dashboard. If your cluster is stuck in this state for a long time, open an [{{site.data.keyword.cloud_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#getting_help).</td>
       </tr>
     <tr>
         <td>`Critical`</td>
         <td>The Kubernetes master cannot be reached or all worker nodes in the cluster are down. If you enabled {{site.data.keyword.keymanagementservicelong_notm}} in your cluster, the {{site.data.keyword.keymanagementserviceshort}} container might fail to encrypt or decrypt your cluster secrets. If so, you can view an error with more information when you run `kubectl get secrets`.</td>
        </tr>
       <tr>
         <td>`Delete failed`</td>
         <td>The Kubernetes master or at least one worker node cannot be deleted.  </td>
       </tr>
       <tr>
         <td>`Deleted`</td>
         <td>The cluster is deleted but not yet removed from your dashboard. If your cluster is stuck in this state for a long time, open an [{{site.data.keyword.cloud_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#getting_help). </td>
       </tr>
       <tr>
       <td>`Deleting`</td>
       <td>The cluster is being deleted and cluster infrastructure is being dismantled. You cannot access the cluster.  </td>
       </tr>
       <tr>
         <td>`Deploy failed`</td>
         <td>The deployment of the Kubernetes master could not be completed. You cannot resolve this state. Contact IBM Cloud support by opening an [{{site.data.keyword.cloud_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#getting_help).</td>
       </tr>
         <tr>
           <td>`Deploying`</td>
           <td>The Kubernetes master is not fully deployed yet. You cannot access your cluster. Wait until your cluster is fully deployed to review the health of your cluster.</td>
          </tr>
          <tr>
           <td>`Normal`</td>
           <td>All worker nodes in a cluster are up and running. You can access the cluster and deploy apps to the cluster. This state is considered healthy and does not require an action from you.<p class="note">Although the worker nodes might be normal, other infrastructure resources, such as [networking](/docs/containers?topic=containers-cs_troubleshoot_network) and [storage](/docs/containers?topic=containers-cs_troubleshoot_storage), might still need attention. If you just created the cluster, some parts of the cluster that are used by other services such as Ingress secrets or registry image pull secrets, might still be in process.</p></td>
        </tr>
          <tr>
           <td>`Pending`</td>
           <td>The Kubernetes master is deployed. The worker nodes are being provisioned and are not available in the cluster yet. You can access the cluster, but you cannot deploy apps to the cluster.  </td>
         </tr>
       <tr>
         <td>`Requested`</td>
         <td>A request to create the cluster and order the infrastructure for the Kubernetes master and worker nodes is sent. When the deployment of the cluster starts, the cluster state changes to <code>Deploying</code>. If your cluster is stuck in the <code>Requested</code> state for a long time, open an [{{site.data.keyword.cloud_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#getting_help). </td>
       </tr>
       <tr>
         <td>`Updating`</td>
         <td>The Kubernetes API server that runs in your Kubernetes master is being updated to a new Kubernetes API version. During the update, you cannot access or change the cluster. Worker nodes, apps, and resources that the user deployed are not modified and continue to run. Wait for the update to complete to review the health of your cluster. </td>
       </tr>
       <tr>
        <td>`Unsupported`</td>
        <td>The [Kubernetes version](/docs/containers?topic=containers-cs_versions#cs_versions) that the cluster runs is no longer supported. Your cluster's health is no longer actively monitored or reported. Additionally, you cannot add or reload worker nodes. To continue receiving important security updates and support, you must update your cluster. Review the [version update preparation actions](/docs/containers?topic=containers-cs_versions#prep-up), then [update your cluster](/docs/containers?topic=containers-update#update) to a supported Kubernetes version.</td>
       </tr>
        <tr>
           <td>`Warning`</td>
           <td><ul><li>At least one worker node in the cluster is not available, but other worker nodes are available and can take over the workload. Try to [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) the unavailable worker nodes.</li>
           <li>Your cluster has zero worker nodes, such as if you created a cluster without any worker nodes or manually removed all the worker nodes from the cluster. [Resize your worker pool](/docs/containers?topic=containers-add_workers#resize_pool) to add worker nodes to recover from a `Warning` state.</li>
           <li>A control plane operation for your cluster failed. View the cluster in the console or run `ibmcloud ks cluster get --cluster <cluster_name_or_ID>` to [check the **Master Status** for further debugging](/docs/containers?topic=containers-cs_troubleshoot#debug_master).</li></ul></td>
        </tr>
       </tbody>
     </table>


<p>The [Kubernetes master](/docs/containers?topic=containers-service-arch) is the main component that keeps your cluster up and running. The master stores cluster resources and their configurations in the etcd database that serves as the single point of truth for your cluster. The Kubernetes API server is the main entry point for all cluster management requests from the worker nodes to the master, or when you want to interact with your cluster resources.<br><br>If a master failure occurs, your workloads continue to run on the worker nodes, but you cannot use `kubectl` commands to work with your cluster resources or view the cluster health until the Kubernetes API server in the master is back up. If a pod goes down during the master outage, the pod cannot be rescheduled until the worker node can reach the Kubernetes API server again.<br><br>During a master outage, you can still run `ibmcloud ks` commands against the {{site.data.keyword.containerlong_notm}} API to work with your infrastructure resources, such as worker nodes or VLANs. If you change the current cluster configuration by adding or removing worker nodes to the cluster, your changes do not happen until the master is back up.</p>
<p class="important">Do not restart or reboot a worker node during a master outage. This action removes the pods from your worker node. Because the Kubernetes API server is unavailable, the pods cannot be rescheduled onto other worker nodes in the cluster.</p>


<br />


## Reviewing master health
{: #debug_master}
{: troubleshoot}
{: support}

Your {{site.data.keyword.containerlong_notm}} includes an IBM-managed master with highly available replicas, automatic security patch updates applied for you, and automation in place to recover in case of an incident. You can check the health, status, and state of the cluster master by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>`.
{: shortdesc}

**Master Health**<br>
The **Master Health** reflects the state of master components and notifies you if something needs your attention. The health might be one of the following:
*   `error`: The master is not operational. IBM is automatically notified and takes action to resolve this issue. You can continue monitoring the health until the master is `normal`. You can also [open an {{site.data.keyword.cloud_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#getting_help).
*   `normal`: The master is operational and healthy. No action is required.
*   `unavailable`: The master might not be accessible, which means some actions such as resizing a worker pool are temporarily unavailable. IBM is automatically notified and takes action to resolve this issue. You can continue monitoring the health until the master is `normal`.
*   `unsupported`: The master runs an unsupported version of Kubernetes. You must [update your cluster](/docs/containers?topic=containers-update) to return the master to `normal` health.

**Master Status and State**<br>
The **Master Status** provides details of what operation from the master state is in progress. The status includes a timestamp of how long the master has been in the same state, such as `Ready (1 month ago)`. The **Master State** reflects the lifecycle of possible operations that can be performed on the master, such as deploying, updating, and deleting. Each state is described in the following table.

|Master state|Description|
|--- |--- |
|`deployed`|The master is successfully deployed. Check the status to verify that the master is `Ready` or to see if an update is available.|
|`deploying`|The master is currently deploying. Wait for the state to become `deployed` before working with your cluster, such as adding worker nodes.|
|`deploy_failed`|The master failed to deploy. IBM Support is notified and works to resolve the issue. Check the **Master Status** field for more information, or wait for the state to become `deployed`.|
|`deleting`|The master is currently deleting because you deleted the cluster. You cannot undo a deletion. After the cluster is deleted, you can no longer check the master state because the cluster is completely removed.|
|`delete_failed`|The master failed to delete. IBM Support is notified and works to resolve the issue. You cannot resolve the issue by trying to delete the cluster again. Instead, check the **Master Status** field for more information, or wait for the cluster to delete. You can also [open an {{site.data.keyword.cloud_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#getting_help).|
|`updating`|The master is updating its Kubernetes version. The update might be a patch update that is automatically applied, or a minor or major version that you applied by updating the cluster. During the update, your highly available master can continue processing requests, and your app workloads and worker nodes continue to run. After the master update is complete, you can [update your worker nodes](/docs/containers?topic=containers-update#worker_node).</br></br>If the update is unsuccessful, the master returns to a `deployed` state and continues running the previous version. IBM Support is notified and works to resolve the issue. You can check if the update failed in the **Master Status** field.|
|`update_cancelled`|The master update is canceled because the cluster was not in a healthy state at the time of the update. Your master remains in this state until your cluster is healthy and you manually update the master. To update the master, use the `ibmcloud ks cluster master update` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update).If you do not want to update the master to the default `major.minor` version during the update, include the `--version` flag and specify the latest patch version that is available for the `major.minor` version that you want, such as `1.17.7`. To list available versions, run `ibmcloud ks versions`.|
|`update_failed`|The master update failed. IBM Support is notified and works to resolve the issue. You can continue to monitor the health of the master until the master reaches a normal state. If the master remains in this state for more than 1 day, [open an {{site.data.keyword.cloud_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#getting_help). IBM Support might identify other issues in your cluster that you must fix before the master can be updated.|
{: caption="Master states"}
{: summary="Table rows read from left to right, with the master state in column one and a description in column two."}


<br />




## Common CLI issues
{: #ts_clis}
{: troubleshoot}
{: support}

Review the following common reasons for CLI connection issues or command failures.

### Firewall prevents running CLI commands
{: #ts_firewall_clis}

{: tsSymptoms}
When you run `ibmcloud`, `kubectl`, or `calicoctl` commands from the CLI, they fail.

{: tsCauses}
You might have corporate network policies that prevent access from your local system to public endpoints via proxies or firewalls.

{: tsResolve}
[Allow TCP access for the CLI commands to work](/docs/containers?topic=containers-firewall#firewall_bx). This task requires the [**Administrator** {{site.data.keyword.cloud_notm}} IAM platform role](/docs/containers?topic=containers-users#platform) for the cluster.

<br />


### `kubectl` commands do not work
{: #kubectl_fails}

{: tsSymptoms}
When you run `kubectl` commands against your cluster, your commands fail with an error message similar to the following.

```
No resources found.
Error from server (NotAcceptable): unknown (get nodes)
```
{: screen}

```
invalid object doesn't have additional properties
```
{: screen}

```
error: No Auth Provider found for name "oidc"
```
{: screen}

{: tsCauses}
You have a different version of `kubectl` than your cluster version. [Kubernetes does not support](https://kubernetes.io/docs/setup/release/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2). If you use a community Kubernetes cluster, you might also have the OpenShift version of `kubectl`, which does not work with community Kubernetes clusters.

To check your client `kubectl` version against the cluster server version, run `kubectl version --short`.

{: tsResolve}
[Install the version of `kubectl`](/docs/containers?topic=containers-cs_cli_install#kubectl) that matches the Kubernetes version of your cluster.

If you have multiple clusters at different Kubernetes versions or different container platforms such as OpenShift, download each `kubectl` version binary file to a separate directory. Then, you can set up an alias in your local terminal profile to point to the `kubectl` binary file directory that matches the `kubectl` version of the cluster that you want to work with, or you might be able to use a tool such as `brew switch kubernetes-cli <major.minor>`.

<br />



### `kubectl` commands time out
{: #exec_logs_fail}

{: tsSymptoms}
If you run commands such as `kubectl exec`, `kubectl attach`, `kubectl proxy`, `kubectl port-forward`, or `kubectl logs`, you see the following message.

  ```
  <workerIP>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
The OpenVPN connection between the master node and worker nodes is not functioning properly.

{: tsResolve}
1. In classic clusters, if you have multiple VLANs for your cluster, multiple subnets on the same VLAN, or a multizone classic cluster, you must enable a [Virtual Router Function (VRF)](/docs/dl?topic=dl-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) for your IBM Cloud infrastructure account so your worker nodes can communicate with each other on the private network. To enable VRF, [contact your IBM Cloud infrastructure account representative](/docs/dl?topic=dl-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#benefits-of-moving-to-vrf). To check whether a VRF is already enabled, use the `ibmcloud account show` command. If you cannot or do not want to enable VRF, enable [VLAN spanning](/docs/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-users#infra_access), or you can request the account owner to enable it. To check whether VLAN spanning is already enabled, use the `ibmcloud ks vlan spanning get --region <region>` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get).
2. Restart the OpenVPN client pod.
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. If you still see the same error message, then the worker node that the VPN pod is on might be unhealthy. To restart the VPN pod and reschedule it to a different worker node, [cordon, drain, and reboot the worker node](/docs/openshift?topic=openshift-kubernetes-service-cli#cs_worker_reboot) that the VPN pod is on.

<br />



<br />


## Unable to create a cluster or manage worker nodes due to permission errors
{: #cs_credentials}
{: troubleshoot}
{: support}

{: tsSymptoms}
You try to manage worker nodes for a new or an existing cluster by running one of the following commands.
* Provision workers: `ibmcloud ks cluster create classic`, `ibmcloud ks worker-pool rebalance`, or `ibmcloud ks worker-pool resize`
* Reload workers: `ibmcloud ks worker reload` or `ibmcloud ks worker update`
* Reboot workers: `ibmcloud ks worker reboot`
* Delete workers: `ibmcloud ks cluster rm`, `ibmcloud ks worker rm`, `ibmcloud ks worker-pool rebalance`, or `ibmcloud ks worker-pool resize`

However, you receive an error message similar to one of the following.

```
We were unable to connect to your IBM Cloud infrastructure account.
Creating a standard cluster requires that you have either a
Pay-As-You-Go account that is linked to an IBM Cloud infrastructure
account term or that you have used the {{site.data.keyword.containerlong_notm}}
CLI to set your {{site.data.keyword.cloud_notm}} Infrastructure API keys.
```
{: screen}

```
'Item' must be ordered with permission.
```
{: screen}

```
The worker node instance '<ID>' cannot be found. Review '<provider>' infrastructure user permissions.
```
{: screen}

```
The worker node instance cannot be found. Review '<provider>' infrastructure user permissions.
```
{: screen}

```
The worker node instance cannot be identified. Review '<provider>' infrastructure user permissions.
```
{: screen}

```
The IAM token exchange request failed with the message: <message>
IAM token exchange request failed: <message>
```
{: screen}

```
The cluster could not be configured with the registry. Make sure that you have the Administrator role for {{site.data.keyword.registrylong_notm}}.
```
{: screen}

{: tsCauses}
The infrastructure credentials that are set for the region and resource group are missing the appropriate [infrastructure permissions](/docs/containers?topic=containers-access_reference#infra). The user's infrastructure permissions are most commonly stored as an [API key](/docs/containers?topic=containers-users#api_key) for the region and resource group. More rarely, if you use a [different {{site.data.keyword.cloud_notm}} account type](/docs/containers?topic=containers-users#understand_infra), you might have [set infrastructure credentials manually](/docs/containers?topic=containers-users#credentials). If you use a different classic IBM Cloud infrastructure account to provision infrastructure resources, you might also have [orphaned clusters](/docs/containers?topic=containers-cs_troubleshoot_clusters#orphaned) in your account.

{: tsResolve}
The account owner must set up the infrastructure account credentials properly. The credentials depend on what type of infrastructure account you are using.

Before you begin, [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Identify what user credentials are used for the region and resource group's infrastructure permissions.
    1.  Check the API key for a region and resource group of the cluster.
        ```
        ibmcloud ks api-key info --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Example output:
        ```
        Getting information about the API key owner for cluster <cluster_name>...
        OK
        Name                Email
        <user_name>         <name@email.com>
        ```
        {: screen}
    2.  Check if the classic infrastructure account for the region and resource group is manually set to use a different IBM Cloud infrastructure account.
        ```
        ibmcloud ks credential get --region <us-south>
        ```
        {: pre}

        **Example output if credentials are set to use a different classic account**. In this case, the user's infrastructure credentials are used for the region and resource group that you targeted, even if a different user's credentials are stored in the API key that you retrieved in the previous step.
        ```
        OK
        Infrastructure credentials for user name <1234567_name@email.com> set for resource group <resource_group_name>.
        ```
        {: screen}

        **Example output if credentials are not set to use a different classic account**. In this case, the API key owner that you retrieved in the previous step has the infrastructure credentials that are used for the region and resource group.
        ```
        FAILED
        No credentials set for resource group <resource_group_name>.: The user credentials could not be found. (E0051)
        ```
        {: screen}
2.  Validate the infrastructure permissions that the user has.
    1.  List the suggested and required infrastructure permissions for the region and resource group.
        ```
        ibmcloud ks infra-permissions get --region <region>
        ```
        {: pre}

        For console and CLI commands to assign these permissions, see [Classic infrastructure roles](/docs/containers?topic=containers-access_reference#infra).
        {: tip}
    2.  Make sure that the [infrastructure credentials owner for the API key or the manually-set account has the correct permissions](/docs/containers?topic=containers-users#owner_permissions).
    3.  If necessary, you can change the [API key](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_api_key_reset) or [manually-set](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_set) infrastructure credentials owner for the region and resource group.
3.  Test that the changed permissions permit authorized users to perform infrastructure operations for the cluster.
    1.  For example, you might try to a delete a worker node.
        ```
        ibmcloud ks worker rm --cluster <cluster_name_or_ID> --worker <worker_node_ID>
        ```
        {: pre}
    2.  Check to see if the worker node is removed.
        ```
        ibmcloud ks worker get --cluster <cluster_name_or_ID> --worker <worker_node_ID>
        ```
        {: pre}

        Example output if the worker node removal is successful. The `worker get` operation fails because the worker node is deleted. The infrastructure permissions are correctly set up.
        ```
        FAILED
        The specified worker node could not be found. (E0011)
        ```
        {: screen}

    3.  If the worker node is not removed, review that [**State** and **Status** fields](/docs/containers?topic=containers-cs_troubleshoot_clusters#debug_worker_nodes) and the [common issues with worker nodes](/docs/containers?topic=containers-cs_troubleshoot_clusters#common_worker_nodes_issues) to continue debugging.
    4.  If you manually set credentials and still cannot see the cluster's worker nodes in your infrastructure account, you might check whether the [cluster is orphaned](/docs/containers?topic=containers-cs_troubleshoot_clusters#orphaned).

<br />


## Unable to create a cluster or manage worker nodes due to paid account error
{: #cs_totp}

{: tsSymptoms}
You try to manage worker nodes for a new or an existing cluster by running one of the following commands.
* Provision clusters and workers: `ibmcloud ks cluster create classic`, `ibmcloud ks worker-pool rebalance`, or `ibmcloud ks worker-pool resize`
* Reload workers: `ibmcloud ks worker reload` or `ibmcloud ks worker update`
* Reboot workers: `ibmcloud ks worker reboot`
* Delete clusters and workers: `ibmcloud ks cluster rm`, `ibmcloud ks worker rm`, `ibmcloud ks worker-pool rebalance`, or `ibmcloud ks worker-pool resize`

However, you receive an error message similar to the following.
```
Unable to connect to the IBM Cloud account. Ensure that you have a paid account.
```
{: screen}

{: tsCauses}
Your {{site.data.keyword.cloud_notm}} account uses its own automatically linked infrastructure through a Pay-as-you-Go account. However, the account administrator enabled the time-based one-time passcode (TOTP) option so that users are prompted for a time-based one-time passcode (TOTP) at login. This type of [multifactor authentication (MFA)](/docs/iam?topic=iam-types#account-based) is account-based, and affects all access to the account. TOTP MFA also affects the access that {{site.data.keyword.containerlong_notm}} requires to make calls to {{site.data.keyword.cloud_notm}} infrastructure. If TOTP is enabled for the account, you cannot create and manage clusters and worker nodes in {{site.data.keyword.containerlong_notm}}.

{: tsResolve}
Classic clusters only: The {{site.data.keyword.cloud_notm}} account owner or an account administrator must either:
* Disable TOTP for the account, and continue to use the automatically linked infrastructure credentials for {{site.data.keyword.containerlong_notm}}.
* Continue to use TOTP, but create an infrastructure API key that {{site.data.keyword.containerlong_notm}} can use to make direct calls to the {{site.data.keyword.cloud_notm}} infrastructure API.
**Note**: You cannot use TOTP if you want to use VPC clusters, because {{site.data.keyword.containerlong_notm}} does not support manually setting infrastructure credentials for VPC clusters.

**To disable TOTP MFA for the account:**
1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external}. From the menu bar, select **Manage > Access (IAM)**.
2. In the left navigation, click the **Settings** page.
3. Under **Multifactor authentication**, click **Edit**.
4. Select **None**, and click **Update**.

**To use TOTP MFA and create an infrastructure API key for {{site.data.keyword.containerlong_notm}}:**
1. From the [{{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/){: external} console, select **Manage** > **Access (IAM)** > **Users** and click the name of the account owner. **Note**: If you do not use the account owner's credentials, first [ensure that the user whose credentials you use has the correct permissions](/docs/containers?topic=containers-users#owner_permissions).
2. In the **API Keys** section, find or create a classic infrastructure API key.
3. Use the infrastructure API key to set the infrastructure API credentials for {{site.data.keyword.containerlong_notm}}. Repeat this command for each region where you create clusters.
    ```
    ibmcloud ks credential set classic --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key> --region <region>
    ```
    {: pre}
4. Verify that the correct credentials are set.
    ```
    ibmcloud ks credential get --region <region>
    ```
    Example output:
    ```
    Infrastructure credentials for user name user@email.com set for resource group default.
    ```
    {: screen}
5. To ensure that existing clusters use the updated infrastructure API credentials, run `ibmcloud ks api-key reset --region <region>` in each region where you have clusters.

<br />





## Unable to create a cluster in the console due to `No VPC is available` error
{: #ts_no_vpc}

{: tsSymptoms}
You try to create a VPC cluster by using the [{{site.data.keyword.containerlong_notm}} console](https://cloud.ibm.com/kubernetes/catalog/create){: external}. You have an existing [VPC for Generation 1 compute](https://cloud.ibm.com/vpc){: external} in your account, but when you try to select an existing **Virtual Private Cloud** to create the cluster in, you see the following error message:
```
No VPC is available. Create a VPC.
```
{: screen}

{: tsCauses}
During cluster creation, the {{site.data.keyword.containerlong_notm}} console uses the API key that is set for the `default` resource group to list the VPCs that are available in your {{site.data.keyword.cloud_notm}} account. If no API key is set for the `default` resource group, no VPCs are listed in the {{site.data.keyword.containerlong_notm}} console, even if your VPC exists in a different resource group and an API key is set for that resource group.

{: tsResolve}
To set an API key for the `default` resource group, use the {{site.data.keyword.containerlong_notm}} CLI.
1. Log in to the terminal as the account owner. If you want a different user than the account owner to set the API key, first [ensure that the API key owner has the correct permissions](/docs/containers?topic=containers-users#owner_permissions).
    ```
    ibmcloud login [--sso]
    ```
    {: pre}

2. Target the `default` resource group.
    ```
    ibmcloud target -g default
    ```
    {:pre}

3. Set the API key for the region and resource group.
    ```
    ibmcloud ks api-key reset --region <region>
    ```
    {: pre}

4. In the [{{site.data.keyword.containerlong_notm}} console](https://cloud.ibm.com/kubernetes/catalog/create){: external}, click **Refresh VPCs**. Your available VPCs are now listed in a drop-down menu.

<br />




## Cluster create error cannot pull images from {{site.data.keyword.registrylong_notm}}
{: #ts_image_pull_create}

{: tsSymptoms}
When you created a cluster, you received an error message similar to the following.


```
Your cluster cannot pull images from the {{site.data.keyword.registrylong_notm}} 'icr.io' domains because an IAM access policy could not be created. Make sure that you have the IAM Administrator platform role to {{site.data.keyword.registrylong_notm}}. Then, create an image pull secret with IAM credentials to the registry by running 'ibmcloud ks cluster pull-secret apply'.
```
{: screen}

{: tsCauses}
During cluster creation, a service ID is created for your cluster and assigned the **Reader** service access policy to {{site.data.keyword.registrylong_notm}}. Then, an API key for this service ID is generated and stored in [an image pull secret](/docs/containers?topic=containers-registry#cluster_registry_auth) to authorize the cluster to pull images from {{site.data.keyword.registrylong_notm}}.

To successfully assign the **Reader** service access policy to the service ID during cluster creation, you must have the **Administrator** platform access policy to {{site.data.keyword.registrylong_notm}}.

{: tsResolve}

Steps:
1.  Make sure that the account owner gives you the **Administrator** role to {{site.data.keyword.registrylong_notm}}.
    ```
    ibmcloud iam user-policy-create <your_user_email> --service-name container-registry --roles Administrator
    ```
    {: pre}
2.  [Use the `ibmcloud ks cluster pull-secret apply` command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_pull_secret_apply) to re-create an image pull secret with the appropriate registry credentials.

<br />


## Cluster cannot update because of broken webhook
{: #webhooks_update}

{: tsSymptoms}
During a master operation such as updating your cluster version, the cluster had a broken webhook application. Now, master operations cannot complete. You see an error seimilar to the following:

```
Cannot complete cluster master operations because the cluster has a broken webhook application. For more information, see the troubleshooting docs: 'https://ibm.biz/master_webhook'
```
{: screen}

{: tsCauses}
Your Kubernetes cluster has configurable webhook resources, validating or mutating admission webhooks, that can intercept and modify requests from various services in the cluster to the API server in the cluster master. Because webhooks can change or reject requests, broken webhooks can impact the functionality of the cluster in various ways, such as preventing you from updating the master version or other maintenance operations. For more information, see the [Dynamic Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} in the Kubernetes documentation.

Potential causes for broken webhooks include:
*   The underlying resource that issues the request is missing or unhealthy, such as a Kubernetes service, endpoint, or pod. 
*   The webhook is part of an add-on or other plug-in application that did not install correctly or is unhealthy.
*   Your cluster might have a networking connectivity issue that prevents the webhook from communicating with the Kubernetes API server in the cluster master.

{: tsResolve}
Identify and restore the resource that causes the broken webhook.

1.  Create a test pod to get an error that identifies the broken webhook.
    ```
    kubectl run webhook-test --generator=run-pod/v1 --image pause:latest
    ```
    {: pre}
2.  In the error, copy the broken webhook. In the following example, the webhook is `trust.hooks.securityenforcement.admission.cloud.ibm.com`.
    ```
    Error from server (InternalError): Internal error occurred: failed calling webhook "trust.hooks.securityenforcement.admission.cloud.ibm.com": Post https://ibmcloud-image-enforcement.ibm-system.svc:443/mutating-pods?timeout=30s: dial tcp 172.21.xxx.xxx:443: connect: connection timed out
    ```
    {: screen}
3.  Get the name of the broken webhook. Replace `trust.hooks.securityenforcement.admission.cloud.ibm.com` with the broken webhook that you previously identified.
    ```
    kubectl get mutatingwebhookconfigurations,validatingwebhookconfigurations -o jsonpath='{.items[?(@.webhooks[*].name=="trust.hooks.securityenforcement.admission.cloud.ibm.com")].metadata.name}{"\n"}'
    ```
    {: pre}

    Example output:
    ```
    image-admission-config
    ```
    {: pre}
4.  Review the service and location details of the mutating or validating webhook configuration in the `clientConfig` section in the output of the following command. Replace `image-admission-config` with the name that you previously identified. If the webhook exists outside the cluster, contact the cluster owner to check the webhook status.
    ```
    kubectl get mutatingwebhookconfiguration image-admission-config -o yaml
    ```
    {: pre}

    ```
    kubectl get validatingwebhookconfigurations image-admission-config -o yaml
    ```
    {: pre}

    Example output:
    ```
      clientConfig:
        caBundle: <redacted>
        service:
            name: <name>
            namespace: <namespace>
            path: /inject
            port: 443
    ```
    {: screen}
5.  **Optional**: Back up the webhooks, especially if you do not know how to reinstall the webhoook.
    ```
    kubectl get mutatingwebhookconfiguration <name> -o yaml > mutatingwebhook-backup.yaml
    ```
    {: pre}

    ```
    kubectl get validatingwebhookconfiguration <name> -o yaml > validatingwebhook-backup.yaml
    ```
    {: pre}
6.  Check the status of the related service and pods for the webhook.
    1.  Check the service **Type**, **Selector**, and **Endpoint** fields.
        ```
        kubectl describe service -n <namespace> <service_name>
        ```
        {: pre}
    2.  If the service type is **ClusterIP**, check that the OpenVPN pod is in a **Running** status so that the webhook can connect securely to the Kubernetes API in the cluster master. If the pod is not healthy, check the pod events, logs, worker node health, and other components to troubleshoot. For more information, see [Debugging app deployments](/docs/containers?topic=containers-cs_troubleshoot_app).
        ```
        kubectl describe pods -n kube-system -l app=vpn
        ```
        {: pre}
    3.  If the service does not have an endpoint, check the health of the backing resources, such as a deployment or pod. If the resource is not healthy, check the pod events, logs, worker node health, and other components to troubleshoot. For more information, see [Debugging app deployments](/docs/containers?topic=containers-cs_troubleshoot_app).
        ```
        kubectl get all -n my-service-namespace -l <key=value>
        ```
        {: pre}
    4.  If the service does not have any backing resources, or if troubleshooting the pods does not resolve the issue, remove the webhook.
        *   If the webhook is managed by an add-on that you installed, uninstall the add-on. Common add-ons that cause webhook issues include the following:
            *   [Container image security enforcement](/docs/Registry?topic=Registry-security_enforce).
            *   [Istio](/docs/containers?topic=containers-istio#istio_uninstall).
            *   [Knative](/docs/containers?topic=containers-serverless-apps-knative).
        *   If the webhook is a custom webhook that you added, delete the webhook.
            ```
            kubectl delete mutatingwebhook <name>
            ```
            {: pre}
7.  Retry the cluster master operation, such as updating the cluster.
8.  If you still see the error, you might have worker node or network connectivity issues.
    *   [Worker node troubleshooting](/docs/containers?topic=containers-cs_troubleshoot_clusters).
    *   Make sure that the webhook can connect to the Kubernetes API server in the cluster master. For example, if you use Calico network policies, security groups, or some other type of firewall, set up your [classic](/docs/containers?topic=containers-firewall) or [VPC](/docs/containers?topic=containers-vpc-firewall) cluster with the appropriate access.
9.  Re-create the webhook or reinstall the add-on.

<br />


## Cluster remains in a pending State
{: #cs_cluster_pending}

{: tsSymptoms}
When you deploy your cluster, it remains in a pending state and doesn't start.

{: tsCauses}
If you just created the cluster, the worker nodes might still be configuring. If you already wait for a while, you might have an invalid VLAN.

{: tsResolve}

You can try one of the following solutions:
  - Check the status of your cluster by running `ibmcloud ks cluster ls`. Then, check to be sure that your worker nodes are deployed by running `ibmcloud ks worker ls --cluster <cluster_name>`.
  - Check to see whether your VLAN is valid. To be valid, a VLAN must be associated with infrastructure that can host a worker with local disk storage. You can [list your VLANs](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlans) by running `ibmcloud ks vlan ls --zone <zone>` if the VLAN does not show in the list, then it is not valid. Choose a different VLAN.

<br />



## Unable to view or work with a cluster
{: #cs_cluster_access}

{: tsSymptoms}
* You are not able to find a cluster. When you run `ibmcloud ks cluster ls`, the cluster is not listed in the output.
* You are not able to work with a cluster. When you run `ibmcloud ks cluster config` or other cluster-specific commands, the cluster is not found.


{: tsCauses}
In {{site.data.keyword.cloud_notm}}, each resource must be in a resource group. For example, cluster `mycluster` might exist in the `default` resource group. When the account owner gives you access to resources by assigning you an {{site.data.keyword.cloud_notm}} IAM platform role, the access can be to a specific resource or to the resource group. When you are given access to a specific resource, you don't have access to the resource group. In this case, you don't need to target a resource group to work with the clusters you have access to. If you target a different resource group than the group that the cluster is in, actions against that cluster can fail. Conversely, when you are given access to a resource as part of your access to a resource group, you must target a resource group to work with a cluster in that group. If you don't target your CLI session to the resource group that the cluster is in, actions against that cluster can fail.

If you cannot find or work with a cluster, you might be experiencing one of the following issues:
* You have access to the cluster and the resource group that the cluster is in, but your CLI session is not targeted to the resource group that the cluster is in.
* You have access to the cluster, but not as part of the resource group that the cluster is in. Your CLI session is targeted to this or another resource group.
* You don't have access to the cluster.

{: tsResolve}
To check your user access permissions:

1. List all of your user permissions.
    ```
    ibmcloud iam user-policies <your_user_name>
    ```
    {: pre}

2. Check if you have access to the cluster and to the resource group that the cluster is in.
    1. Look for a policy that has a **Resource Group Name** value of the cluster's resource group and a **Memo** value of `Policy applies to the resource group`. If you have this policy, you have access to the resource group. For example, this policy indicates that a user has access to the `test-rg` resource group:
        ```
        Policy ID:   3ec2c069-fc64-4916-af9e-e6f318e2a16c
        Roles:       Viewer
        Resources:
                     Resource Group ID     50c9b81c983e438b8e42b2e8eca04065
                     Resource Group Name   test-rg
                     Memo                  Policy applies to the resource group
        ```
        {: screen}
    2. Look for a policy that has a **Resource Group Name** value of the cluster's resource group, a **Service Name** value of `containers-kubernetes` or no value, and a **Memo** value of `Policy applies to the resource(s) within the resource group`. If you this policy, you have access to clusters or to all resources within the resource group. For example, this policy indicates that a user has access to clusters in the `test-rg` resource group:
        ```
        Policy ID:   e0ad889d-56ba-416c-89ae-a03f3cd8eeea
        Roles:       Administrator
        Resources:
                     Resource Group ID     a8a12accd63b437bbd6d58fb6a462ca7
                     Resource Group Name   test-rg
                     Service Name          containers-kubernetes
                     Service Instance
                     Region
                     Resource Type
                     Resource
                     Memo                  Policy applies to the resource(s) within the resource group
        ```
        {: screen}
    3. If you have both of these policies, skip to Step 4, first bullet. If you don't have the policy from Step 2a, but you do have the policy from Step 2b, skip to Step 4, second bullet. If you do not have either of these policies, continue to Step 3.

3. Check if you have access to the cluster, but not as part of access to the resource group that the cluster is in.
    1. Look for a policy that has no values besides the **Policy ID** and **Roles** fields. If you have this policy, you have access to the cluster as part of access to the entire account. For example, this policy indicates that a user has access to all resources in the account:
        ```
        Policy ID:   8898bdfd-d520-49a7-85f8-c0d382c4934e
        Roles:       Administrator, Manager
        Resources:
                     Service Name
                     Service Instance
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    2. Look for a policy that has a **Service Name** value of `containers-kubernetes` and a **Service Instance** value of the cluster's ID. You can find a cluster ID by running `ibmcloud ks cluster get --cluster <cluster_name>`. For example, this policy indicates that a user has access to a specific cluster:
        ```
        Policy ID:   140555ce-93ac-4fb2-b15d-6ad726795d90
        Roles:       Administrator
        Resources:
                     Service Name       containers-kubernetes
                     Service Instance   df253b6025d64944ab99ed63bb4567b6
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    3. If you have either of these policies, skip to the second bullet point of step 4. If you do not have either of these policies, skip to the third bullet point of step 4.

4. Depending on your access policies, choose one of the following options.
    * If you have access to the cluster and to the resource group that the cluster is in:
      1. Target the resource group. **Note**: You can't work with clusters in other resource groups until you untarget this resource group.
          ```
          ibmcloud target -g <resource_group>
          ```
          {: pre}

      2. Target the cluster.
          ```
          ibmcloud ks cluster config --cluster <cluster_name_or_ID>
          ```
          {: pre}

    * If you have access to the cluster but not to the resource group that the cluster is in:
      1. Do not target a resource group. If you already targeted a resource group, untarget it:
        ```
        ibmcloud target --unset-resource-group
        ```
        {: pre}

      2. Target the cluster.
        ```
        ibmcloud ks cluster config --cluster <cluster_name_or_ID>
        ```
        {: pre}

    * If you do not have access to the cluster:
        1. Ask your account owner to assign an [{{site.data.keyword.cloud_notm}} IAM platform role](/docs/containers?topic=containers-users#platform) to you for that cluster.
        2. Do not target a resource group. If you already targeted a resource group, untarget it:
          ```
          ibmcloud target --unset-resource-group
          ```
          {: pre}
        3. Target the cluster.
          ```
          ibmcloud ks cluster config --cluster <cluster_name_or_ID>
          ```
          {: pre}

<br />



## Cannot access resources in a cluster
{: #cs_firewall}

{: tsSymptoms}
When the worker nodes in your cluster cannot communicate on the private network, you might see various different symptoms.

- Sample error message when you run `kubectl exec`, `attach`, `logs`, `proxy`, or `port-forward`:
  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

- Sample error message when `kubectl proxy` succeeds, but the Kubernetes dashboard is not available:
  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}

- Sample error message when `kubectl proxy` fails or the connection to your service fails:
  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}


{: tsCauses}
To access resources in the cluster, your worker nodes must be able to communicate on the private network. You might have a Vyatta or another firewall set up, or customized your existing firewall settings in your IBM Cloud infrastructure account. {{site.data.keyword.containerlong_notm}} requires certain IP addresses and ports to be opened to allow communication from the worker node to the Kubernetes master and vice versa. If your worker nodes are spread across multiple zones, you must allow private network communication by enabling VLAN spanning. Communication between worker nodes might also not be possible if your worker nodes are stuck in a reloading loop.

{: tsResolve}
1. List the worker nodes in your cluster and verify that your worker nodes are not stuck in a `Reloading` state.
   ```
   ibmcloud ks worker ls --cluster <cluster_name_or_id>
   ```
   {: pre}

2. If you have a multizone cluster and your account is not enabled for VRF, verify that you [enabled VLAN spanning](/docs/containers?topic=containers-subnets#subnet-routing) for your account.
3. If you have a Vyatta or custom firewall settings, make sure that you [opened up the required ports](/docs/containers?topic=containers-firewall#firewall_outbound) to allow the cluster to access infrastructure resources and services.

<br />




## Feedback, questions, and support
{: #getting_help}
{: troubleshoot}
{: support}

Still having issues with your cluster? Review different ways to get help and support for your {{site.data.keyword.containerlong_notm}} clusters. For any questions or feedback, post in Slack.
{: shortdesc}

**General ways to resolve issues**<br>
1. Keep your cluster environment up to date.
   * Check monthly for available security and operating system patches to [update your worker nodes](/docs/containers?topic=containers-update#worker_node).
   * [Update your cluster](/docs/containers?topic=containers-update#master) to the latest default version for [{{site.data.keyword.containershort}}](/docs/containers?topic=containers-cs_versions).
2. Make sure that your command line tools are up to date.
   * In the terminal, you are notified when updates to the `ibmcloud` CLI and plug-ins are available. Be sure to keep your CLI up-to-date so that you can use all available commands and flags.
   * Make sure that [your `kubectl` CLI](/docs/containers?topic=containers-cs_cli_install#kubectl) client matches the same Kubernetes version as your cluster server. [Kubernetes does not support](https://kubernetes.io/docs/setup/release/version-skew-policy/){: external} `kubectl` client versions that are 2 or more versions apart from the server version (n +/- 2).
<br>

**Reviewing issues and status**<br>
1. To see whether {{site.data.keyword.cloud_notm}} is available, [check the {{site.data.keyword.cloud_notm}} status page](https://cloud.ibm.com/status?selected=status){: external}.
2. Filter for the **Kubernetes Service** component.
<br>

**Feedback and questions**<br>
1. Post in the {{site.data.keyword.containershort}} Slack.
   * If you are an external user, post in the [#general](https://ibm-cloud-success.slack.com/archives/C4G6362ER){: external} channel.
   * If you are an IBMer, use the [#armada-users](https://ibm-argonauts.slack.com/archives/C4S4NUCB1) channel.<p class="tip">If you do not use an IBMid for your {{site.data.keyword.cloud_notm}} account, [request an invitation](https://cloud.ibm.com/kubernetes/slack){: external} to this Slack.</p>
2. Review forums such as {{site.data.keyword.containershort}} help or Stack Overflow to see whether other users ran into the same issue. When you use the forums to ask a question, tag your question so that it is seen by the {{site.data.keyword.cloud_notm}} development teams.
   * If you have technical questions about developing or deploying clusters or apps with {{site.data.keyword.containerlong_notm}}, post your question on [Stack Overflow](https://stackoverflow.com/questions/tagged/ibm-cloud+containers){: external} and tag your question with `ibm-cloud` and `containers`.
   * See [Getting help](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) for more details about using the forums.
<br>

**Getting help**<br>
1. Before you open a support case, gather relevant information about your cluster environment.
   1. Get your cluster details.
      ```
      ibmcloud ks cluster get -c <cluster_name_or_ID>
      ```
      {: pre}
   2. If your issue involves worker nodes, get the worker node details.
      1. List all worker nodes in the cluster, and note the **ID** of any worker nodes with an unhealthy **State** or **Status**.
         ```
         ibmcloud ks worker ls -c <cluster_name_or_ID>
         ```
         {: pre}
      2. Get the details of the unhealthy worker node.
         ```
         ibmcloud ks worker get -w <worker_ID> -c <cluster_name_or_ID>
         ```
         {: pre}
   3. For issues with resources within your cluster such as pods or services, log in to the cluster and use the Kubernetes API to get more information about them.

   You can also use the [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) to gather and export pertinent information to share with IBM Support.
   {: tip}

2.  Contact IBM Support by opening a case. To learn about opening an IBM support case, or about support levels and case severities, see [Contacting support](/docs/get-support?topic=get-support-getting-customer-support).
3.  In your support case, for **Category**, select **Containers**.
4.  For the **Offering**, select your {{site.data.keyword.containershort}} cluster. Include the relevant information that you previously gathered.


