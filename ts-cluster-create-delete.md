---

copyright: 
  years: 2014, 2025
lastupdated: "2025-09-26"


keywords: kubernetes, containers

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}





# Why can't I create or delete clusters or worker nodes?
{: #cluster_infra_errors}
{: troubleshoot}
{: support}

You can't perform infrastructure-related commands on your cluster, such as:
* Adding worker nodes in an existing cluster or when creating a new cluster.
* Removing worker nodes.
* Reloading or rebooting worker nodes.
* Resizing worker pools.
* Updating your cluster.
* Deleting your cluster.

Review the error messages in the following sections to troubleshoot infrastructure-related issues that are caused by [incorrect cluster permissions](#cs_credentials), [orphaned clusters in other infrastructure accounts](#orphaned), or [a time-based one-time passcode (TOTP) on the account](#cs_totp).

## Unable to create or delete clusters or worker nodes due to permission and credential errors
{: #cs_credentials}


You can't manage worker nodes for your cluster, and you receive an error message that mentions `permissions`, `credentials`, `SoftLayer`, `API keys`, or `role`.
{: tsSymptoms}

Review the information on [permission and credential errors](/docs/containers?topic=containers-ts-perms-creds) and follow the relevant steps. 
{: tsResolve}


## Unable to create or delete worker nodes due to incorrect account error
{: #orphaned}

[Classic infrastructure]{: tag-classic-inf}



You can't manage worker nodes for your cluster or view the cluster worker nodes in your classic IBM Cloud infrastructure account. However, you can update and manage other clusters in the account.
{: tsSymptoms}

Further, you verified that you have the [proper infrastructure credentials](#cs_credentials).

You might receive an error message in your worker node status similar to the following example.
```sh
incorrect account for worker - The 'classic' infrastructure user credentials changed and no longer match the worker node instance infrastructure account.
```
{: screen}


The cluster might be provisioned in a classic IBM Cloud infrastructure account that is no longer linked to your {{site.data.keyword.containerlong_notm}} account. The cluster is orphaned. Because the resources are in a different account, you don't have the infrastructure credentials to modify the resources.
{: tsCauses}

Consider the following example scenario to understand how clusters might become orphaned.
1. You have an {{site.data.keyword.cloud_notm}} Pay-As-You-Go account.
2. You create a cluster named `Cluster1`. The worker nodes and other infrastructure resources are provisioned into the infrastructure account that comes with your Pay-As-You-Go account.
3. Later, you find out that your team uses a legacy or shared classic IBM Cloud infrastructure account. You use the `ibmcloud ks credential set` command to change the IBM Cloud infrastructure credentials to use your team account.
4. You create another cluster named `Cluster2`. The worker nodes and other infrastructure resources are provisioned into the team infrastructure account.
5. You notice that `Cluster1` needs a worker node update, a worker node reload, or you just want to clean it up by deleting it. However, because `Cluster1` was provisioned into a different infrastructure account, you can't modify its infrastructure resources. `Cluster1` is orphaned.
6. You follow the resolution steps in the following section, but don't set your infrastructure credentials back to your team account. You can delete `Cluster1`, but now `Cluster2` is orphaned.
7. You change your infrastructure credentials back to the team account that created `Cluster2`. Now, you no longer have an orphaned cluster!




Follow the steps to review your infrastructure credentials and determine why you are seeing the credentials error.
{: tsResolve}

1. Log in to the [console](https://cloud.ibm.com/containers/cluster-management/clusters){: external}.
1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster).
1. Check which infrastructure account the region that your cluster is in currently uses to provision clusters. Replace `REGION` with the {{site.data.keyword.cloud_notm}} region that the cluster is in.
    ```sh
    ibmcloud ks credential get --region REGION
    ```
    {: pre}

    If you see a message similar to the following, then the account uses the default, linked infrastructure account.
    ```sh
    No credentials set for resource group <resource group>.: The user credentials could not be found.
    ```
    {: screen}

1. Check which infrastructure account was used to provision the cluster.
    1. In the **Worker Nodes** tab, select a worker node and note its **ID**.
    2. Open the menu ![Menu icon](../../icons/icon_hamburger.svg "Menu icon") and click **Infrastructure** > **Classic Infrastructure**.
    3. From the infrastructure navigation pane, click **Devices > Device List**.
    4. Search for the worker node ID that you previously noted.
    5. If you don't find the worker node ID, the worker node is not provisioned into this infrastructure account. Switch to a different infrastructure account and try again.
1. Compare the infrastructure accounts.
    *   **If the worker nodes are in the linked infrastructure account**: Use the `ibmcloud ks credential unset` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_credentials_unset) to resume using the default infrastructure credentials that are linked with your Pay-As-You-Go account.
    *   **If the worker nodes are in a different infrastructure account**: Use the `ibmcloud ks credential set` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_credentials_set) to change your infrastructure credentials to the account that the cluster worker nodes are provisioned in, which you found in the previous step.

        If you no longer have access to the infrastructure credentials, you can open an {{site.data.keyword.cloud_notm}} support case to determine an email address for the administrator of the other infrastructure account. However, {{site.data.keyword.cloud_notm}} Support can't remove the orphaned cluster for you, and you must contact the administrator of the other account to get the infrastructure credentials.
        {: note}

    *   **If the infrastructure accounts match**: Check the rest of the worker nodes in the cluster and see if any are assigned to different infrastructure account. Make sure that you checked the worker nodes in the cluster that have the credentials issue. Review other [common infrastructure credential issues](/docs/containers?topic=containers-cluster_infra_errors).
1. Now that the infrastructure credentials are updated, retry the blocked action, such as updating or deleting a worker node, and verify that the action succeeds.
1. If you have other clusters in the same region and resource that require the previous infrastructure credentials, repeat Step 3 to reset the infrastructure credentials to the previous account. Note that if you created clusters with a different infrastructure account than the account that you switch to, you might orphan those clusters.

    Tired of switching infrastructure accounts each time you need to perform a cluster or worker action? Consider re-creating all the clusters in the region and resource group in the same infrastructure account. Then, migrate your workloads and remove the old clusters from the different infrastructure account.
    {: note}

## Unable to create or delete worker nodes due to endpoints error
{: #vpe-ts}


You can't manage worker nodes for your cluster, and you receive an error message similar to one of the following.
{: tsSymptoms}

```sh
Worker deploy failed due to network communications failing to master or registry endpoints. Please verify your network setup is allowing traffic from this subnet then attempt a worker replace on this worker
```
{: screen}

```sh
Pending endpoint gateway creation
```
{: screen}


Worker nodes can communicate with the Kubernetes master through the cluster's virtual private endpoint (VPE).
{: tsCauses}

One VPE gateway resource is created per cluster in your VPC. If the VPE gateway for your cluster is not correctly created in your VPC, the VPE gateway is deleted from your VPC, or the IP address that is reserved for the VPE is deleted from your VPC subnet, worker nodes lose connectivity with the Kubernetes master.

Re-establish the VPE connection between your worker nodes and Kubernetes master.
{: tsResolve}

1. To check the VPE gateway for your cluster in the VPC infrastructure console, open the [Virtual private endpoint gateways for VPC dashboard](https://cloud.ibm.com/infrastructure/network/endpointGateways){: external} and look for the VPE gateway in the format `iks-<cluster_ID>`.
    * If the gateway for your cluster is not listed, continue to the next step.
    * If the gateway for your cluster is listed but its status is not `Stable`, [open a support case](/docs/containers?topic=containers-get-help). In the case details, include the cluster ID.
    * If the gateway for your cluster is listed and its status is `Stable`, you might have firewall or security group rules that are blocking worker node communication to the cluster master. [Configure your security group rules to allow outgoing traffic to the appropriate ports and IP addresses](/docs/containers?topic=containers-vpc-security-group).

2. Refresh the cluster master. If the VPE gateway does not exist in your VPC, it is created, and connectivity to the reserved IP addresses on the subnets that your worker nodes are connected to is re-established. After you refresh the cluster, wait a few minutes to allow the operation to complete.
    ```sh
    ibmcloud ks cluster master refresh -c <cluster_name_or_ID>
    ```
    {: pre}

3. Verify that the VPE gateway for your cluster is created by opening the [Virtual private endpoint gateways for VPC dashboard](https://cloud.ibm.com/infrastructure/network/endpointGateways){: external} and looking for the VPE gateway in the format `iks-<cluster_ID>`.

4. If you still can't manage worker nodes after the cluster master is refreshed, replace the worker nodes that you can't access.
    1. List all worker nodes in your cluster and note the **name** of the worker node that you want to replace.
        ```sh
        kubectl get nodes
        ```
        {: pre}

        The **name** that is returned in this command is the private IP address that is assigned to your worker node. You can find more information about your worker node when you run the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command and look for the worker node with the same **Private IP** address.

    2. Replace the worker node. As part of the replace process, the pods that run on the worker node are drained and rescheduled onto remaining worker nodes in the cluster. The worker node is also cordoned, or marked as unavailable for future pod scheduling. Use the worker node ID that is returned from the `ibmcloud ks worker ls --cluster <cluster_name_or_ID>` command.
        ```sh
        ibmcloud ks worker replace --cluster <cluster_name_or_ID> --worker <worker_node_ID>
        ```
        {: pre}

    3. Verify that the worker node is replaced.
        ```sh
        ibmcloud ks worker ls --cluster <cluster_name_or_ID>
        ```
        {: pre}

## Unable to create or delete worker nodes due to paid account or one time password error
{: #cs_totp}

[Classic infrastructure]{: tag-classic-inf}



You can't manage worker nodes for your cluster, and you receive an error message similar to one of the following examples.
{: tsSymptoms}

```sh
Unable to connect to the IBM Cloud account. Ensure that you have a paid account.
```
{: screen}

```sh
can't authenticate the infrastructure user: Time-based One Time Password authentication is required to log in with this user.
```
{: screen}


Your {{site.data.keyword.cloud_notm}} account uses its own automatically linked infrastructure through a Pay-as-you-Go account.
{: tsCauses}

However, the account administrator enabled the time-based one-time passcode (TOTP) option so that users are prompted for a time-based one-time passcode (TOTP) at login. This type of [multifactor authentication (MFA)](/docs/account?topic=account-enablemfa) is account-based, and affects all access to the account. TOTP MFA also affects the access that {{site.data.keyword.containerlong_notm}} requires to make calls to {{site.data.keyword.cloud_notm}} infrastructure. If TOTP is enabled for the account, you can't create and manage clusters and worker nodes in {{site.data.keyword.containerlong_notm}}.


The {{site.data.keyword.cloud_notm}} account owner or an account administrator must take one of the following actions.
{: tsResolve}

* Disable TOTP for the account, and continue to use the automatically linked infrastructure credentials for {{site.data.keyword.containerlong_notm}}.
* Continue to use TOTP, but create an infrastructure API key that {{site.data.keyword.containerlong_notm}} can use to make direct calls to the {{site.data.keyword.cloud_notm}} infrastructure API.

### Disabling TOTP MFA for the account
{: #disable-totp-mfa-account}

1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external}. From the menu bar, select **Manage > Access (IAM)**.
2. Click the **Settings** page.
3. Under **Multifactor authentication**, click **Edit**.
4. Select **None**, and click **Update**.

### Using TOTP MFA to create an infrastructure API key for {{site.data.keyword.containerlong_notm}}
{: #create-api-key-totp-mfa}

1. From the [{{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/){: external} console, select **Manage** > **Access (IAM)** > **Users** and click the name of the account owner. **Note**: If you don't use the account owner's credentials, [ensure that the identity whose credentials you use has the Administrator platform role in {{site.data.keyword.containerlong_notm}} and, if using a service ID, the Operator platform role in the IAM Identity Service](/docs/containers?topic=containers-iam-platform-access-roles).
2. In the **API Keys** section, find or create a classic infrastructure API key.
3. Use the infrastructure API key to set the infrastructure API credentials for {{site.data.keyword.containerlong_notm}}. Repeat this command for each region where you create clusters.
    ```sh
    ibmcloud ks credential set classic --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key> --region <region>
    ```
    {: pre}

4. Verify that the correct credentials are set.
    ```sh
    ibmcloud ks credential get --region <region>
    ```
    {: pre}

    Example output

    ```sh
    Infrastructure credentials for user name user@email.com set for resource group default.
    ```
    {: screen}

5. To ensure that existing clusters use the updated infrastructure API credentials, run `ibmcloud ks api-key reset --region <region>` in each region where you have clusters.
