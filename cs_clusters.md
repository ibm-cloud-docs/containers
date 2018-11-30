---

copyright:
  years: 2014, 2018
lastupdated: "2018-11-30"

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
{:gif: data-image-type='gif'}


# Setting up clusters and worker nodes
{: #clusters}
Create clusters and add worker nodes to increase cluster capacity in {{site.data.keyword.containerlong}}. Still getting started? Try out the [creating a Kubernetes cluster tutorial](cs_tutorials.html#cs_cluster_tutorial).
{: shortdesc}

## Preparing to create clusters
{: #cluster_prepare}

With {{site.data.keyword.containerlong_notm}}, you can create a highly available and secure environment for your apps, with many additional capabilities built in or configurable. The many possibilities that you have with clusters also mean that you have many decisions to make when you create a cluster. The following steps outline what you must consider for setting up your account, permissions, resource groups, VLAN spanning, cluster set up for zone and hardware, and billing information.
{: shortdesc}

The list is divided into two parts:
*  **Account-level**: These are preparations that, after the account administrator makes them, you might not need to change them each time that you create a cluster. However, each time that you create a cluster, you still want to verify that the current account-level state is what you need it to be.
*  **Cluster-level**: These are preparations that impact your cluster each time that you create a cluster.

### Account-level
{: #prepare_account_level}

1.  [Create or upgrade your account to a billable account ({{site.data.keyword.Bluemix_notm}} Pay-As-You-Go or Subscription)](https://console.bluemix.net/registration/).
2.  [Set up an {{site.data.keyword.containerlong_notm}} API key](cs_users.html#api_key) in the regions that you want to create clusters. Assign the API key with the appropriate permissions to create clusters:
    *  **Super User** role for IBM Cloud infrastructure (SoftLayer).
    *  **Administrator** platform management role for {{site.data.keyword.containerlong_notm}} at the account level.
    *  **Administrator** platform management role for {{site.data.keyword.registrylong_notm}} at the account level.

    Are you the account owner? You already have the necessary permissions! When you create a cluster, the API key for that region and resource group is set with your credentials.
    {: tip}

3.  If your account uses multiple resource groups, figure out your account's strategy for [managing resource groups](cs_users.html#resource_groups). 
    *  The cluster is created in the resource group that you target when you log in to {{site.data.keyword.Bluemix_notm}}. If you do not target a resource group, the default resource group is automatically targeted.
    *  If you want to create a cluster in a different resource group than the default, you need at least the **Viewer** role for the resource group. If you do not have any role for the resource group but are still an **Administrator** for the service within the resource group, your cluster is created in the default resource group.
    *  You cannot change a cluster's resource group. The cluster can only integrate with other {{site.data.keyword.Bluemix_notm}} services that are in the same resource group or services that do not support resource groups, such as {{site.data.keyword.registrylong_notm}}.
    *  If you plan to use [{{site.data.keyword.monitoringlong_notm}} for metrics](cs_health.html#view_metrics), plan to give your cluster a name that is unique across all resource groups and regions in your account to avoid metrics naming conflicts.
    * If you have an {{site.data.keyword.Bluemix_dedicated}} account, you must create clusters in the default resource group only.
4.  Enable VLAN spanning. If you have multiple VLANs for a cluster, multiple subnets on the same VLAN, or a multizone cluster, you must enable [VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) for your IBM Cloud infrastructure (SoftLayer) account so your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](cs_users.html#infra_access), or you can request the account owner to enable it. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan-spanning-get` [command](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get). If you are using {{site.data.keyword.BluDirectLink}}, you must instead use a [Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). To enable VRF, contact your IBM Cloud infrastructure (SoftLayer) account representative.

### Cluster-level
{: #prepare_cluster_level}

1.  Verify that you have the **Administrator** platform role for {{site.data.keyword.containerlong_notm}}.
    1.  From the [{{site.data.keyword.Bluemix_notm}} console](https://console.bluemix.net/), click **Manage > Account > Users**.
    2.  From the table, select yourself.
    3.  From the **Access policies** tab, confirm that your **Role** is **Administrator**. You can be the **Administrator** for all the resources in the account, or at least for {{site.data.keyword.containershort_notm}}. **Note**: If you have the **Administrator** role for {{site.data.keyword.containershort_notm}} in only one resource group or region instead of the entire account, you must have at least the **Viewer** role at the account level to see the account's VLANs.
2.  Decide between a [free or standard cluster](cs_why.html#cluster_types). You can create 1 free cluster to try out some of the capabilities for 30 days, or create fully-customizable standard clusters with your choice of hardware isolation. Create a standard cluster to get more benefits and control over your cluster performance.
3.  [Plan your cluster set up](cs_clusters_planning.html#plan_clusters).
    *  Decide whether to create a [single zone](cs_clusters_planning.html#single_zone) or [multizone](cs_clusters_planning.html#multizone) cluster. Note that multizone clusters are available in select locations only.
    *  If you want to create a cluster that is not accessible publicly, review the additional [private cluster steps](cs_clusters_planning.html#private_clusters).
    *  Choose what type of [hardware and isolation](cs_clusters_planning.html#shared_dedicated_node) you want for your cluster's worker nodes, including the decision between virtual or bare metal machines.
4.  For standard clusters, you can [estimate the cost with the cost estimator ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/pricing/configure/iaas/containers-kubernetes). For more information on charges that might not be included in the estimator, see [Pricing and billing](cs_why.html#pricing).
<br>
<br>

**What's next?**
* [Creating clusters with the {{site.data.keyword.Bluemix_notm}} console](#clusters_ui)
* [Creating clusters with the {{site.data.keyword.Bluemix_notm}} CLI](#clusters_cli)

## Creating clusters with the {{site.data.keyword.Bluemix_notm}} console
{: #clusters_ui}

The purpose of the Kubernetes cluster is to define a set of resources, nodes, networks, and storage devices that keep apps highly available. Before you can deploy an app, you must create a cluster and set the definitions for the worker nodes in that cluster.
{:shortdesc}

### Creating a free cluster
{: #clusters_ui_free}

You can use your 1 free cluster to become familiar with how {{site.data.keyword.containerlong_notm}} works. With free clusters, you can learn the terminology, complete a tutorial, and get your bearings before you take the leap to production-level standard clusters. Don't worry, you still get a free cluster, even if you have a billable account.

Free clusters have a life span of 30 days. After that time, the cluster expires and the cluster and its data are deleted. The deleted data is not backed up by {{site.data.keyword.Bluemix_notm}} and cannot be restored. Be sure to back up any important data.
{: note}

1. [Prepare to create a cluster](#cluster_prepare) to ensure that you have the correct {{site.data.keyword.Bluemix_notm}} account setup and user permissions, and to decide on the cluster setup and the resource group that you want to use.

2. In the [catalog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/catalog/?category=containers), select **{{site.data.keyword.containershort_notm}}** to create a cluster.

3. Select a location in which to deploy your cluster. **Note**: You cannot create free clusters in the Washington DC (US East) or Tokyo (AP North) locations.

4. Select the **Free** cluster plan.

5. Give your cluster a name. The name must start with a letter, can contain letters, numbers, and hyphen (-), and must be 35 characters or fewer. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.


6. Click **Create cluster**. By default, a worker pool with one worker node is created. You can see the progress of the worker node deployment in the **Worker nodes** tab. When the deploy is done, you can see that your cluster is ready in the **Overview** tab.

    Changing the unique ID or domain name that is assigned during creation blocks the Kubernetes master from managing your cluster.
    {: tip}

</br>

### Creating a standard cluster
{: #clusters_ui_standard}

1. [Prepare to create a cluster](#cluster_prepare) to ensure that you have the correct {{site.data.keyword.Bluemix_notm}} account setup and user permissions, and to decide on the cluster setup and the resource group that you want to use.

2. In the [catalog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/catalog/?category=containers), select **{{site.data.keyword.containershort_notm}}** to create a cluster.

3. Select a resource group in which to create your cluster.
  **Note**:
    * A cluster can be created in only one resource group, and after the cluster is created, you can't change its resource group.
    * Free clusters are automatically created in the default resource group.
    * To create clusters in a resource group other than the default, you must have at least the [**Viewer** role](cs_users.html#platform) for the resource group.

4. Select an [{{site.data.keyword.Bluemix_notm}} location](cs_regions.html#regions-and-zones) in which to deploy your cluster. For the best performance, select the location that is physically closest to you. Keep in mind that if you select a zone that is outside of your country, you might require legal authorization prior to the data being stored.

5. Select the **Standard** cluster plan. With a standard cluster you have access to features like multiple worker nodes for a highly available environment.

6. Enter your zone details.

    1. Select **Single zone** or **Multizone** availability. In a multizone cluster the master node is deployed in a multizone-capable zone and your cluster's resources are spread across multiple zones. Your choices might be limited by region.

    2. Select the specific zones in which you want to host your cluster. You must select at least 1 zone but you can select as many as you would like. If you select more than 1 zone, the worker nodes are spread across the zones that you choose which gives you higher availability. If you select only 1 zone, you can [add zones to your cluster](#add_zone) after it is created.

    3. Select a public VLAN (optional) and a private VLAN (required) from your IBM Cloud infrastructure (SoftLayer) account. Worker nodes communicate with each other by using the private VLAN. To communicate with the Kubernetes master, you must configure public connectivity for your worker node.  If you do not have a public or private VLAN in this zone, leave it blank. A public and a private VLAN is automatically created for you. If you have existing VLANs and you do not specify a public VLAN, consider configuring a firewall, such as a [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html#about-the-vra). You can use the same VLAN for multiple clusters.
        If worker nodes are set up with a private VLAN only, you must configure an alternative solution for network connectivity. For more information, see [Planning private-only cluster networking](cs_network_cluster.html#private_vlan).
        {: note}

7. Configure your default worker pool. Worker pools are groups of worker nodes that share the same configuration. You can always add more worker pools to your cluster later.

    1. Select a type of hardware isolation. Virtual is billed hourly and bare metal is billed monthly.

        - **Virtual - Dedicated**: Your worker nodes are hosted on infrastructure that is devoted to your account. Your physical resources are completely isolated.

        - **Virtual - Shared**: Infrastructure resources, such as the hypervisor and physical hardware, are shared across you and other IBM customers, but each worker node is accessible only by you. Although this option is less expensive and sufficient in most cases, you might want to verify your performance and infrastructure requirements with your company policies.

        - **Bare Metal**: Billed monthly, bare metal servers are provisioned by manual interaction with IBM Cloud infrastructure (SoftLayer), and can take more than one business day to complete. Bare metal is best suited for high-performance applications that need more resources and host control. You can also choose to enable [Trusted Compute](cs_secure.html#trusted_compute) to verify your worker nodes against tampering. Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud ks feature-enable` [command](cs_cli_reference.html#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.

        Be sure that you want to provision a bare metal machine. Because it is billed monthly, if you cancel it immediately after an order by mistake, you are still charged the full month.
        {:tip}

    2. Select a machine type. The machine type defines the amount of virtual CPU, memory, and disk space that is set up in each worker node and made available to the containers. Available bare metal and virtual machines types vary by the zone in which you deploy the cluster. After you create your cluster, you can add different machine types by adding a worker or pool to the cluster.

    3. Specify the number of worker nodes that you need in the cluster. The number of workers that you enter is replicated across the number of zones that you selected. This means that if you have 2 zones and select 3 worker nodes, 6 nodes are provisioned, and 3 nodes live in each zone.

8. Give your cluster a unique name. **Note**: Changing the unique ID or domain name that is assigned during creation blocks the Kubernetes master from managing your cluster.

9. Choose the Kubernetes API server version for the cluster master node.

10. Click **Create cluster**. A worker pool is created with the number of workers that you specified. You can see the progress of the worker node deployment in the **Worker nodes** tab. When the deploy is done, you can see that your cluster is ready in the **Overview** tab.

**What's next?**

When the cluster is up and running, you can check out the following tasks:

-   If you created the cluster in a multizone capable zone, spread worker nodes by [adding a zone to your cluster](#add_zone).
-   [Install the CLIs to start working with your cluster.](cs_cli_install.html#cs_cli_install)
-   [Deploy an app in your cluster.](cs_app.html#app_cli)
-   [Set up your own private registry in {{site.data.keyword.Bluemix_notm}} to store and share Docker images with other users.](/docs/services/Registry/index.html)
-   If you have a firewall, you might need to [open the required ports](cs_firewall.html#firewall) to use `ibmcloud`, `kubectl`, or `calicotl` commands, to allow outbound traffic from your cluster, or to allow inbound traffic for networking services.
-   Clusters with Kubernetes version 1.10 or later: Control who can create pods in your cluster with [pod security policies](cs_psp.html).

<br />


## Creating clusters with the {{site.data.keyword.Bluemix_notm}} CLI
{: #clusters_cli}

The purpose of the Kubernetes cluster is to define a set of resources, nodes, networks, and storage devices that keep apps highly available. Before you can deploy an app, you must create a cluster and set the definitions for the worker nodes in that cluster.
{:shortdesc}

Before you begin, install the {{site.data.keyword.Bluemix_notm}} CLI and the [{{site.data.keyword.containerlong_notm}} plug-in](cs_cli_install.html#cs_cli_install).

To create a cluster:

1. [Prepare to create a cluster](#cluster_prepare) to ensure that you have the correct {{site.data.keyword.Bluemix_notm}} account setup and user permissions, and to decide on the cluster setup and the resource group that you want to use.

2.  Log in to the {{site.data.keyword.Bluemix_notm}} CLI.

    1.  Log in and enter your {{site.data.keyword.Bluemix_notm}} credentials when prompted.

        ```
        ibmcloud login
        ```
        {: pre}

        If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.Bluemix_notm}} CLI. Enter your user name and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
        {: tip}

    2. If you have multiple {{site.data.keyword.Bluemix_notm}} accounts, select the account where you want to create your Kubernetes cluster.

    3.  To create clusters in a resource group other than default, target that resource group.
      **Note**:
        * A cluster can be created in only one resource group, and after the cluster is created, you can't change its resource group.
        * You must have at least the [**Viewer** role](cs_users.html#platform) for the resource group.
        * Free clusters are automatically created in the the default resource group.
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4.  If you want to create or access Kubernetes clusters in a region other than the {{site.data.keyword.Bluemix_notm}} region that you selected earlier, run `ibmcloud ks region-set`.


4.  Create a cluster. Standard clusters can be created in any region and available zone. Free clusters cannot be created in the US East or AP North regions and corresponding zones, and you cannot select the zone.

    1.  **Standard clusters**: Review the zones that are available. The zones that are shown depend on the {{site.data.keyword.containerlong_notm}} region that you are logged in. To span your cluster across zones, you must create the cluster in a [multizone-capable zone](cs_regions.html#zones).

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **Standard clusters**: Choose a zone and review the machine types available in that zone. The machine type specifies the virtual or physical compute hosts that are available to each worker node.

        -  View the **Server Type** field to choose virtual or physical (bare metal) machines.
        -  **Virtual**: Billed hourly, virtual machines are provisioned on shared or dedicated hardware.
        -  **Physical**: Billed monthly, bare metal servers are provisioned by manual interaction with IBM Cloud infrastructure (SoftLayer), and can take more than one business day to complete. Bare metal is best suited for high-performance applications that need more resources and host control.
        - **Physical machines with Trusted Compute**: You can also choose to enable [Trusted Compute](cs_secure.html#trusted_compute) to verify your bare metal worker nodes against tampering. Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud ks feature-enable` [command](cs_cli_reference.html#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.
        -  **Machine types**: To decide what machine type to deploy, review the core, memory, and storage combinations of the [available worker node hardware](cs_clusters_planning.html#shared_dedicated_node). After you create your cluster, you can add different physical or virtual machine types by [adding a worker pool](#add_pool).

           Be sure that you want to provision a bare metal machine. Because it is billed monthly, if you cancel it immediately after an order by  mistake, you are still charged the full month.
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **Standard clusters**: Check to see if a public and private VLAN already exists in the IBM Cloud infrastructure (SoftLayer) for this account.

        ```
        ibmcloud ks vlans <zone>
        ```
        {: pre}

        ```
        ID        Name   Number   Type      Router
        1519999   vlan   1355     private   bcr02a.dal10
        1519898   vlan   1357     private   bcr02a.dal10
        1518787   vlan   1252     public    fcr02a.dal10
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        If a public and private VLAN already exist, note the matching routers. Private VLAN routers always begin with <code>bcr</code> (back-end router) and public VLAN routers always begin with <code>fcr</code> (front-end router). When creating a cluster and specifying the public and private VLANs, the number and letter combination after those prefixes must match. In the example output, any of the private VLANs can be used with any of public VLANs because the routers all include `02a.dal10`.

        You must connect your worker nodes to a private VLAN, and optionally, you can connect your worker nodes to a public VLAN. **Note**: If worker nodes are set up with a private VLAN only, you must configure an alternative solution for network connectivity. For more information, see [Planning private-only cluster networking](cs_network_cluster.html#private_vlan).

    4.  **Free and standard clusters**: Run the `cluster-create` command. You can choose between a free cluster, which includes one worker node set up with 2vCPU and 4GB memory and is automatically deleted after 30 days. When you create a standard cluster, by default, the worker node disks are encrypted, its hardware is shared by multiple IBM customers, and it is billed by hours of usage. </br>Example for a standard cluster. Specify the cluster's options:

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt] [--trusted]
        ```
        {: pre}

        Example for a free cluster. Specify the cluster name:

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>cluster-create components</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding this command's components</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>The command to create a cluster in your {{site.data.keyword.Bluemix_notm}} organization.</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**Standard clusters**: Replace <em>&lt;zone&gt;</em> with the {{site.data.keyword.Bluemix_notm}} zone ID where you want to create your cluster. Available zones depend on the {{site.data.keyword.containerlong_notm}} region that you are logged in to.<p class="note">The cluster worker nodes are deployed into this zone. To span your cluster across zones, you must create the cluster in a [multizone-capable zone](cs_regions.html#zones). After the cluster is created, you can [add a zone to the cluster](#add_zone).</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**Standard clusters**: Choose a machine type. You can deploy your worker nodes as virtual machines on shared or dedicated hardware, or as physical machines on bare metal. Available physical and virtual machines types vary by the zone in which you deploy the cluster. For more information, see the documentation for the `ibmcloud ks machine-type` [command](cs_cli_reference.html#cs_machine_types). For free clusters, you do not have to define the machine type.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**Standard clusters, virtual-only**: The level of hardware isolation for your worker node. Use dedicated to have available physical resources dedicated to you only, or shared to allow physical resources to be shared with other IBM customers. The default is shared. This value is optional for standard clusters and is not available for free clusters.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**Free clusters**: You do not have to define a public VLAN. Your free cluster is automatically connected to a public VLAN that is owned by IBM.</li>
          <li>**Standard clusters**: If you already have a public VLAN set up in your IBM Cloud infrastructure (SoftLayer) account for that zone, enter the ID of the public VLAN. If you want to connect your worker nodes to a private VLAN only, do not specify this option.
          <p>Private VLAN routers always begin with <code>bcr</code> (back-end router) and public VLAN routers always begin with <code>fcr</code> (front-end router). When creating a cluster and specifying the public and private VLANs, the number and letter combination after those prefixes must match.</p>
          <p class="note">If worker nodes are set up with a private VLAN only, you must configure an alternative solution for network connectivity. For more information, see [Planning private-only cluster networking](cs_network_cluster.html#private_vlan).</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Free clusters**: You do not have to define a private VLAN. Your free cluster is automatically connected to a private VLAN that is owned by IBM.</li><li>**Standard clusters**: If you already have a private VLAN set up in your IBM Cloud infrastructure (SoftLayer) account for that zone, enter the ID of the private VLAN. If you do not have a private VLAN in your account, do not specify this option. {{site.data.keyword.containerlong_notm}} automatically creates a private VLAN for you.<p>Private VLAN routers always begin with <code>bcr</code> (back-end router) and public VLAN routers always begin with <code>fcr</code> (front-end router). When creating a cluster and specifying the public and private VLANs, the number and letter combination after those prefixes must match.</p></li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Free and standard clusters**: Replace <em>&lt;name&gt;</em> with a name for your cluster. The name must start with a letter, can contain letters, numbers, and hyphen (-), and must be 35 characters or fewer. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**Standard clusters**: The number of worker nodes to include in the cluster. If the <code>--workers</code> option is not specified, 1 worker node is created.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Standard clusters**: The Kubernetes version for the cluster master node. This value is optional. When the version is not specified, the cluster is created with the default of supported Kubernetes versions. To see available versions, run <code>ibmcloud ks kube-versions</code>.
</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Free and standard clusters**: Worker nodes feature disk encryption by default; [learn more](cs_secure.html#encrypted_disk). If you want to disable encryption, include this option.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Standard bare metal clusters**: Enable [Trusted Compute](cs_secure.html#trusted_compute) to verify your bare metal worker nodes against tampering. Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud ks feature-enable` [command](cs_cli_reference.html#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.</td>
        </tr>
        </tbody></table>

5.  Verify that the creation of the cluster was requested. For virtual machines, it can take a few minutes for the worker node machines to be ordered, and for the cluster to be set up and provisioned in your account. Bare metal physical machines are provisioned by manual interaction with IBM Cloud infrastructure (SoftLayer), and can take more than one business day to complete.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    When the provisioning of your cluster is completed, the status of your cluster changes to **deployed**.

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.10.8      Default
    ```
    {: screen}

6.  Check the status of the worker nodes.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    When the worker nodes are ready, the state changes to **normal** and the status is **Ready**. When the node status is **Ready**, you can then access the cluster.

    Every worker node is assigned a unique worker node ID and domain name that must not be changed manually after the cluster is created. Changing the ID or domain name prevents the Kubernetes master from managing your cluster.
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.10.8      Default
    ```
    {: screen}

7.  Set the cluster you created as the context for this session. Complete these configuration steps every time that you work with your cluster.
    1.  Get the command to set the environment variable and download the Kubernetes configuration files.

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        When the download of the configuration files is finished, a command is displayed that you can use to set the path to the local Kubernetes configuration file as an environment variable.

        Example for OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  Copy and paste the command that is displayed in your terminal to set the `KUBECONFIG` environment variable.
    3.  Verify that the `KUBECONFIG` environment variable is set properly.

        Example for OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Output:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

8.  Launch your Kubernetes dashboard with the default port `8001`.
    1.  Set the proxy with the default port number.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Open the following URL in a web browser to see the Kubernetes dashboard.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**What's next?**

-   If you created the cluster in a multizone capable zone, spread worker nodes by [adding a zone to your cluster](#add_zone).
-   [Deploy an app in your cluster.](cs_app.html#app_cli)
-   [Manage your cluster with the `kubectl` command line. ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [Set up your own private registry in {{site.data.keyword.Bluemix_notm}} to store and share Docker images with other users.](/docs/services/Registry/index.html)
- If you have a firewall, you might need to [open the required ports](cs_firewall.html#firewall) to use `ibmcloud`, `kubectl`, or `calicotl` commands, to allow outbound traffic from your cluster, or to allow inbound traffic for networking services.
-  Clusters with Kubernetes version 1.10 or later: Control who can create pods in your cluster with [pod security policies](cs_psp.html).

<br />



## Adding worker nodes and zones to clusters
{: #add_workers}

To increase the availability of your apps, you can add worker nodes to an existing zone or multiple existing zones in your cluster. To help protect your apps from zone failures, you can add zones to your cluster.
{:shortdesc}

When you create a cluster, the worker nodes are provisioned in a worker pool. After cluster creation, you can add more worker nodes to a pool by resizing it or by adding more worker pools. By default, the worker pool exists in one zone. Clusters that have a worker pool in only one zone are called single zone clusters. When you add more zones to the cluster, the worker pool exists across the zones. Clusters that have a worker pool that is spread across more than one zone are called multizone clusters.

If you have a multizone cluster, keep its worker node resources balanced. Make sure that all the worker pools are spread across the same zones, and add or remove workers by resizing the pools instead of adding individual nodes.
{: tip}

Before you begin, make sure you have the [**Operator** or **Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](cs_users.html#platform). Then, choose one of the following sections:
  * [Add worker nodes by resizing an existing worker pool in your cluster](#resize_pool)
  * [Add worker nodes by adding a worker pool to your cluster](#add_pool)
  * [Add a zone to your cluster and replicate the worker nodes in your worker pools across multiple zones](#add_zone)
  * [Deprecated: Add a stand-alone worker node to a cluster](#standalone)


### Adding worker nodes by resizing an existing worker pool
{: #resize_pool}

You can add or reduce the number of worker nodes in your cluster by resizing an existing worker pool, regardless of whether the worker pool is in one zone or spread across multiple zones.
{: shortdesc}

For example, consider a cluster with one worker pool that has three worker nodes per zone.
* If the cluster is single zone and exists in `dal10`, then the worker pool has three worker nodes in `dal10`. The cluster has a total of three worker nodes.
* If the cluster is multizone and exists in `dal10` and `dal12`, then the worker pool has three worker nodes in `dal10` and three worker nodes in `dal12`. The cluster has a total of six worker nodes.

For bare metal worker pools, keep in mind that billing is monthly. If you resize up or down, it impacts your costs for the month.
{: tip}

To resize the worker pool, change the number of worker nodes that the worker pool deploys in each zone:

1. Get the name of the worker pool that you want to resize.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Resize the worker pool by designating the number of worker nodes that you want to deploy in each zone. The minimum value is 1.
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. Verify that the worker pool is resized.
    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Example output for a worker pool that is in two zones, `dal10` and `dal12`, and is resized to two worker nodes per zone:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Adding worker nodes by creating a new worker pool
{: #add_pool}

You can add worker nodes to your cluster by creating a new worker pool.
{:shortdesc}

1. Retrieve the **Worker Zones** of your cluster and choose the zone where you want to deploy the worker nodes in your worker pool. If you have a single zone cluster, you must use the zone that you see in the **Worker Zones** field. For multizone clusters, you can choose any of the existing **Worker Zones** of your cluster, or add one of the [multizone metro cities](cs_regions.html#zones) for the region that your cluster is in. You can list available zones by running `ibmcloud ks zones`.
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   Example output:
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. For each zone, list available private and public VLANs. Note the private and the public VLAN that you want to use. If you do not have a private or a public VLAN, the VLAN is automatically created for you when you add a zone to your worker pool.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3.  For each zone, review the [available machine types for worker nodes](cs_clusters_planning.html#shared_dedicated_node).

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. Create a worker pool. If you provision a bare metal worker pool, specify `--hardware dedicated`.
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. Verify that the worker pool is created.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. By default, adding a worker pool creates a pool with no zones. To deploy worker nodes in a zone, you must add the zones that you previously retrieved to the worker pool. If you want to spread your worker nodes across multiple zones, repeat this command for each zone.  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

7. Verify that worker nodes provision in the zone that you added. Your worker nodes are ready when the status changes from **provision_pending** to **normal**.
   ```
   ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   Example output:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Adding worker nodes by adding a zone to a worker pool
{: #add_zone}

You can span your cluster across multiple zones within one region by adding a zone to your existing worker pool.
{:shortdesc}

When you add a zone to a worker pool, the worker nodes that are defined in your worker pool are provisioned in the new zone and considered for future workload scheduling. {{site.data.keyword.containerlong_notm}} automatically adds the `failure-domain.beta.kubernetes.io/region` label for the region and the `failure-domain.beta.kubernetes.io/zone` label for the zone to each worker node. The Kubernetes scheduler uses these labels to spread pods across zones within the same region.

If you have multiple worker pools in your cluster, add the zone to all of them so that worker nodes are spread evenly across your cluster.

Before you begin:
*  To add a zone to your worker pool, your worker pool must be in a [multizone-capable zone](cs_regions.html#zones). If your worker pool is not in a multizone-capable zone, consider [creating a new worker pool](#add_pool).
*  If you have multiple VLANs for a cluster, multiple subnets on the same VLAN, or a multizone cluster, you must enable [VLAN spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) for your IBM Cloud infrastructure (SoftLayer) account so your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](cs_users.html#infra_access), or you can request the account owner to enable it. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan-spanning-get` [command](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get). If you are using {{site.data.keyword.BluDirectLink}}, you must instead use a [Virtual Router Function (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). To enable VRF, contact your IBM Cloud infrastructure (SoftLayer) account representative.

To add a zone with worker nodes to your worker pool:

1. List available zones and pick the zone that you want to add to your worker pool. The zone that you choose must be a multizone-capable zone.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. List available VLANs in that zone. If you do not have a private or a public VLAN, the VLAN is automatically created for you when you add a zone to your worker pool.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. List the worker pools in your cluster and note their names.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. Add the zone to your worker pool. If you have multiple worker pools, add the zone to all your worker pools so that your cluster is balanced in all zones. Replace `<pool1_id_or_name,pool2_id_or_name,...>` with the names of all of your worker pools in a comma-separated list.

    A private and a public VLAN must exist before you can add a zone to multiple worker pools. If you do not have a private and a public VLAN in that zone, add the zone to one worker pool first so that a private and a public VLAN is created for you. Then, you can add the zone to other worker pools by specifying the private and the public VLAN that was created for you.
    {: note}

   If you want to use different VLANs for different worker pools, repeat this command for each VLAN and its corresponding worker pools. Any new worker nodes are added to the VLANs that you specify, but the VLANs for any existing worker nodes are not changed.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. Verify that the zone is added to your cluster. Look for the added zone in the **Worker zones** field of the output. Note that the total number of workers in the **Workers** field has increased as new worker nodes are provisioned in the added zone.
    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    Example output:
    ```
    Name:                   mycluster
    ID:                     df253b6025d64944ab99ed63bb4567b6
    State:                  normal
    Created:                2018-09-28T15:43:15+0000
    Location:               dal10
    Master URL:             https://169.xx.xxx.xxx:30426
    Master Location:        Dallas
    Master Status:          Ready (21 hours ago)
    Ingress Subdomain:      ...
    Ingress Secret:         mycluster
    Workers:                6
    Worker Zones:           dal10, dal12
    Version:                1.11.3_1524
    Owner:                  owner@email.com
    Monitoring Dashboard:   ...
    Resource Group ID:      a8a12accd63b437bbd6d58fb6a462ca7
    Resource Group Name:    Default
    ```
    {: screen}  

### Deprecated: Adding stand-alone worker nodes
{: #standalone}

If you have a cluster that was created before worker pools were introduced, you can use the deprecated commands to add stand-alone worker nodes.
{: deprecated}

If you have a cluster that was created after worker pools were introduced, you cannot add stand-alone worker nodes. Instead, you can [create a worker pool](#add_pool), [resize an existing worker pool](#resize_pool), or [add a zone to a worker pool](#add_zone) to add worker nodes to your cluster.
{: note}

1. List available zones and pick the zone where you want to add worker nodes.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. List available VLANs in that zone and note their ID.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. List available machine types in that zone.
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

4. Add stand-alone worker nodes to the cluster.
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. Verify that the worker nodes are created.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}



## Viewing cluster states
{: #states}

Review the state of a Kubernetes cluster to get information about the availability and capacity of the cluster, and potential problems that might have occurred.
{:shortdesc}

To view information about a specific cluster, such as its zones, master URL, Ingress subdomain, version, owner, and monitoring dashboard, use the `ibmcloud ks cluster-get <cluster_name_or_ID>` [command](cs_cli_reference.html#cs_cluster_get). Include the `--showResources` flag to view more cluster resources such as add-ons for storage pods or subnet VLANs for public and private IPs.

You can view the current cluster state by running the `ibmcloud ks clusters` command and locating the **State** field. To troubleshoot your cluster and worker nodes, see [Troubleshooting clusters](cs_troubleshoot.html#debug_clusters).

<table summary="Every table row should be read left to right, with the cluster state in column one and a description in column two.">
<caption>Cluster states</caption>
   <thead>
   <th>Cluster state</th>
   <th>Description</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>The deletion of the cluster is requested by the user before the Kubernetes master is deployed. After the deletion of the cluster is completed, the cluster is removed from your dashboard. If your cluster is stuck in this state for a long time, open an [{{site.data.keyword.Bluemix_notm}} support case](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>The Kubernetes master cannot be reached or all worker nodes in the cluster are down. </td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>The Kubernetes master or at least one worker node cannot be deleted.  </td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>The cluster is deleted but not yet removed from your dashboard. If your cluster is stuck in this state for a long time, open an [{{site.data.keyword.Bluemix_notm}} support case](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>The cluster is being deleted and cluster infrastructure is being dismantled. You cannot access the cluster.  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>The deployment of the Kubernetes master could not be completed. You cannot resolve this state. Contact IBM Cloud support by opening an [{{site.data.keyword.Bluemix_notm}} support case](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>The Kubernetes master is not fully deployed yet. You cannot access your cluster. Wait until your cluster is fully deployed to review the health of your cluster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>All worker nodes in a cluster are up and running. You can access the cluster and deploy apps to the cluster. This state is considered healthy and does not require an action from you.<p class="note">Although the worker nodes might be normal, other infrastructure resources, such as [networking](cs_troubleshoot_network.html) and [storage](cs_troubleshoot_storage.html), might still need attention.</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>The Kubernetes master is deployed. The worker nodes are being provisioned and are not available in the cluster yet. You can access the cluster, but you cannot deploy apps to the cluster.  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>A request to create the cluster and order the infrastructure for the Kubernetes master and worker nodes is sent. When the deployment of the cluster starts, the cluster state changes to <code>Deploying</code>. If your cluster is stuck in the <code>Requested</code> state for a long time, open an [{{site.data.keyword.Bluemix_notm}} support case](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>The Kubernetes API server that runs in your Kubernetes master is being updated to a new Kubernetes API version. During the update, you cannot access or change the cluster. Worker nodes, apps, and resources that the user deployed are not modified and continue to run. Wait for the update to complete to review the health of your cluster. </td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>At least one worker node in the cluster is not available, but other worker nodes are available and can take over the workload. </td>
    </tr>
   </tbody>
 </table>


<br />


## Removing clusters
{: #remove}

Free and standard clusters that are created with a billable account must be removed manually when they are not needed anymore so that those clusters are no longer consuming resources.
{:shortdesc}

<p class="important">
No backups are created of your cluster or your data in your persistent storage. Deleting a cluster or persistent storage is permanent and cannot be undone.</br>
</br>When you remove a cluster, you also remove any subnets that were automatically provisioned when you created the cluster and that you created by using the `ibmcloud ks cluster-subnet-create` command. However, if you manually added existing subnets to your cluster by using the `ibmcloud ks cluster-subnet-add command`, these subnets are not removed from your IBM Cloud infrastructure (SoftLayer) account and you can reuse them in other clusters.</p>

Before you begin:
* Note your cluster ID. You might need the cluster ID to investigate and remove related IBM Cloud infrastructure (SoftLayer) resources that are not automatically deleted with your cluster.
* If you want to delete the data in your persistent storage, [understand the delete options](cs_storage_remove.html#cleanup).
* Make sure you have the [**Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](cs_users.html#platform).

To remove a cluster:

-   From the {{site.data.keyword.Bluemix_notm}} console
    1.  Select your cluster and click **Delete** from the **More actions...** menu.

-   From the {{site.data.keyword.Bluemix_notm}} CLI
    1.  List the available clusters.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  Delete the cluster.

        ```
        ibmcloud ks cluster-rm <cluster_name_or_ID>
        ```
        {: pre}

    3.  Follow the prompts and choose whether to delete cluster resources, which includes containers, pods, bound services, persistent storage, and secrets.
      - **Persistent storage**: Persistent storage provides high availability for your data. If you created a persistent volume claim by using an [existing file share](cs_storage_file.html#existing_file), then you cannot delete the file share when you delete the cluster. You must manually delete the file share later from your IBM Cloud infrastructure (SoftLayer) portfolio.

          Due to the monthly billing cycle, a persistent volume claim cannot be deleted on the last day of a month. If you delete the persistent volume claim on the last day of the month, the deletion remains pending until the beginning of the next month.
          {: note}

Next steps:
- After it is no longer listed in the available clusters list when you run the `ibmcloud ks clusters` command, you can reuse the name of a removed cluster.
- If you kept the subnets, you can [reuse them in a new cluster](cs_subnets.html#custom) or manually delete them later from your IBM Cloud infrastructure (SoftLayer) portfolio.
- If you kept the persistent storage, you can [delete your storage](cs_storage_remove.html#cleanup) later through the IBM Cloud infrastructure (SoftLayer) dashboard in the {{site.data.keyword.Bluemix_notm}} console.
