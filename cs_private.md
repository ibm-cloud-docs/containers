---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-24"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

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
{:gif: data-image-type='gif'}


# Setting up private clusters
{: #cs_clusters_private}

Create private clusters and add worker nodes to increase cluster capacity in {{site.data.keyword.containerlong}}.
{: shortdesc}

Not sure which cluster setup to choose? See [Planning your private cluster and worker node setup](/docs/containers?topic=containers-cs_private_planning).
{: tip}

Have you created a cluster before and are just looking for a quick example command? Try this example to create a standard private cluster that uses the private service endpoint only:
```
ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --private-service-endpoint --private-vlan <private_VLAN_ID> --private-only
```
{: pre}

## Step 1: Prepare to create private clusters
{: #prepare-private}

Follow the steps to prepare your {{site.data.keyword.Bluemix_notm}} account for {{site.data.keyword.containerlong_notm}}. These are preparations that, after the account administrator makes them, you might not need to change each time that you create a cluster. However, each time that you create a cluster, you still want to verify that the current account-level state is what you need it to be.
{: shortdesc}

1. [Create or upgrade your account to a billable account ({{site.data.keyword.Bluemix_notm}} Pay-As-You-Go or Subscription)](https://cloud.ibm.com/registration/).

2. [Set up an {{site.data.keyword.containerlong_notm}} API key](/docs/containers?topic=containers-users#api_key) in the regions that you want to create clusters. Assign the API key with the appropriate permissions to create clusters:
  * **Super User** role for IBM Cloud infrastructure (SoftLayer).
  * **Administrator** platform management role for {{site.data.keyword.containerlong_notm}} at the account level.
  * **Administrator** platform management role for {{site.data.keyword.registrylong_notm}} at the account level. If your account predates 4 October 2018, you need to [enable {{site.data.keyword.Bluemix_notm}} IAM policies for {{site.data.keyword.registryshort_notm}}](/docs/services/Registry?topic=registry-user#existing_users). With IAM policies, you can control access to resources such as registry namespaces.

  Are you the account owner? You already have the necessary permissions! When you create a cluster, the API key for that region and resource group is set with your credentials.
    {: tip}

3. Verify that you have the **Administrator** platform role for {{site.data.keyword.containerlong_notm}}. To allow your cluster to pull images from the private registry, you also need the **Administrator** platform role for {{site.data.keyword.registrylong_notm}}.
    1. From the [{{site.data.keyword.Bluemix_notm}} console ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/) menu bar, click **Manage > Access (IAM)**.
    2. Click the **Users** page, and then from the table, select yourself.
    3. From the **Access policies** tab, confirm that your **Role** is **Administrator**. You can be the **Administrator** for all the resources in the account, or at least for {{site.data.keyword.containershort_notm}}. **Note**: If you have the **Administrator** role for {{site.data.keyword.containershort_notm}} in only one resource group or region instead of the entire account, you must have at least the **Viewer** role at the account level to see the account's VLANs.
    <p class="tip">Make sure that your account administrator does not assign you the **Administrator** platform role at the same time as a service role. You must assign platform and service roles separately.</p>

4. If your account uses multiple resource groups, figure out your account's strategy for [managing resource groups](/docs/containers?topic=containers-users#resource_groups).
  * The cluster is created in the resource group that you target when you log in to {{site.data.keyword.Bluemix_notm}}. If you do not target a resource group, the default resource group is automatically targeted.
  * If you want to create a cluster in a different resource group than the default, you need at least the **Viewer** role for the resource group. If you do not have any role for the resource group but are still an **Administrator** for the service within the resource group, your cluster is created in the default resource group.
  * You cannot change a cluster's resource group. Furthermore, if you need to use the `ibmcloud ks cluster-service-bind` [command](/docs/containers-cli-plugin?topic=containers-cli-plugin-cs_cli_reference#cs_cluster_service_bind) to [integrate with an {{site.data.keyword.Bluemix_notm}} service](/docs/containers?topic=containers-service-binding#bind-services), that service must be in the same resource group as the cluster. Services that do not use resource groups like {{site.data.keyword.registrylong_notm}} or that do not need service binding like {{site.data.keyword.la_full_notm}} work even if the cluster is in a different resource group.
  * If you plan to use [{{site.data.keyword.monitoringlong_notm}} for metrics](/docs/containers?topic=containers-health#view_metrics), plan to give your cluster a name that is unique across all resource groups and regions in your account to avoid metrics naming conflicts.

5. [Plan your cluster set up](/docs/containers?topic=containers-plan_clusters#plan_clusters).
  * Decide whether to create a [single zone](/docs/containers?topic=containers-plan_clusters#single_zone) or [multizone](/docs/containers?topic=containers-plan_clusters#multizone) cluster. Note that multizone clusters are available in select locations only.
  * Choose what type of [hardware and isolation](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node) you want for your cluster's worker nodes, including the decision between virtual or bare metal machines.

6. You can [estimate the cost](/docs/billing-usage?topic=billing-usage-cost#cost) in the {{site.data.keyword.Bluemix_notm}} console. For more information on charges that might not be included in the estimator, see [Pricing and billing](/docs/containers?topic=containers-faqs#charges).

<br />


## Step 2: Create a private cluster
{: #create-private}

Choose one of the following private cluster setups.
* **[Calico-protected VRF cluster](#calico-pc-cluster)**: Create worker nodes on both public and private VLANs and use the private service endpoint to connect the Kubernetes master with worker nodes. This setup requires a VRF in your IBM Cloud infrastructure (SoftLayer) account. After you create the cluster, you can lock down the cluster's public interface as needed by blocking public VLAN traffic with Calico policies and restricting traffic to select edge nodes.
* **[Private VRF cluster](#standard-pc-cluster)**: TBD
* **[Private cluster with gateway device](#legacy-pc-cluster)**: Create worker nodes on private VLANs only. This setup requires gateway device to provide connectivity between the Kubernetes master and worker nodes, and to act as a firewall for your cluster.

Want more information on each setup? See [Private cluster network setups](/docs/containers?topic=containers-cs_private_planning#private_setups).
{: tip}

### Create a Calico-protected VRF cluster
{: #calico-pc-cluster}

1. Set up your IBM Cloud infrastructure (SoftLayer) networking.
  1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in your IBM Cloud infrastructure (SoftLayer) account.
  2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
  3. To run `kubectl` commands against your cluster over an IPSec VPN connection or through DirectLink, you must access the master through the private service endpoint. However, communication with the Kubernetes master must go through the `166.XXX.XXX` IP address range, which is not routable from a IPSec VPN connection or through DirectLink. You must set up a jump server on the private network. The VPN or DirectLink connection terminates at the jump server, and the jump server then routes communication through the internal `10.XXX.XXX` IP address range to the Kubernetes master.

2. Create a standard cluster that is connected to both public and private VLANs by following the steps in [Creating a standard cluster](#clusters_ui_standard). To ensure that the Kubernetes master and worker nodes communicate over the private network only, note the following changes:
  * If you use the console, in step 8, select **Private endpoint only**.
  * If you use the CLI, in step 7, include the `--private-service-endpoint` flag and do not include the `--public-service-endpoint` flag.

3. After you create the cluster, continue with [Step 3: Accessing your private cluster and viewing cluster states](#private_access_states).


### Creating a private VRF cluster
{: #standard-pc-cluster}

TBD


### Create a private cluster with a gateway device
{: #legacy-pc-cluster}

1. Set up your IBM Cloud infrastructure (SoftLayer) networking.
  1. Configure a gateway device. For example, you might choose to set up a [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) or a [Fortigate Security Appliance](/docs/services/vmwaresolutions/services?topic=vmware-solutions-fsa_considerations) to act as your firewall to allow necessary traffic and block unwanted traffic.
  2. If you have an existing router appliance and then add a cluster, the new portable subnets that are ordered for the cluster aren't configured on the router appliance. In order to use networking services, you must enable routing between the subnets on the same VLAN by [enabling VLAN spanning](/docs/containers?topic=containers-subnets#vra-routing). You must also enable VLAN spanning if you have multiple VLANs for a cluster, multiple subnets on the same VLAN, or a multizone cluster so that your worker nodes can communicate with each other on the private network. To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-users#infra_access), or you can request the account owner to enable it. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan-spanning-get` [command](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get).
  3. [Open up the required private IP addresses and ports](/docs/containers?topic=containers-firewall#firewall_outbound) for each region so that the master and the worker nodes can communicate and for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.

2. Create a standard cluster that is connected to private VLANs only in the {{site.data.keyword.Bluemix_notm}} console or CLI.

</br>
**Using the {{site.data.keyword.Bluemix_notm}} console**</br>

1. In the [catalog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cloud.ibm.com/catalog?category=containers), select **{{site.data.keyword.containershort_notm}}** to create a cluster.

2. Select a resource group in which to create your cluster.
  **Note**:
    * A cluster can be created in only one resource group, and after the cluster is created, you can't change its resource group.
    * To create clusters in a resource group other than the default, you must have at least the [**Viewer** role](/docs/containers?topic=containers-users#platform) for the resource group.

3. Select a geography in which to deploy your cluster.

4. Give your cluster a unique name. The name must start with a letter, can contain letters, numbers, and hyphen (-), and must be 35 characters or fewer. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.
 **Note**: Changing the unique ID or domain name that is assigned during creation blocks the Kubernetes master from managing your cluster.

5. Select **Single zone** or **Multizone** availability. In a multizone cluster, the master node is deployed in a multizone-capable zone and your cluster's resources are spread across multiple zones.

6. Enter your metro and zone details.
  * Multizone clusters:
    1. Select a metro location. For the best performance, select the metro location that is physically closest to you. Your choices might be limited by geography.
    2. Select the specific zones in which you want to host your cluster. You must select at least 1 zone but you can select as many as you would like. If you select more than 1 zone, the worker nodes are spread across the zones that you choose which gives you higher availability. If you select only 1 zone, you can [add zones to your cluster](#add_zone) after it is created.
  * Single zone clusters: Select a zone in which you want to host your cluster. For the best performance, select the zone that is physically closest to you.

7. For each zone, choose a private VLAN.
  1. Select a private VLAN from your IBM Cloud infrastructure (SoftLayer) account. Worker nodes communicate with each other by using the private VLAN. If you do not have a private VLAN in a zone, a private VLAN is automatically created for you. You can use the same VLAN for multiple clusters.
  2. For the public VLAN, select **None**.

8. Configure your default worker pool. Worker pools are groups of worker nodes that share the same configuration. You can always add more worker pools to your cluster later.
  1. Choose the Kubernetes API server version for the cluster master node and worker nodes.
  2. Filter the worker flavors by selecting a machine type. Virtual is billed hourly and bare metal is billed monthly.
    - **Bare metal**: Billed monthly, bare metal servers are provisioned manually by IBM Cloud infrastructure (SoftLayer) after you order, and can take more than one business day to complete. Bare metal is best suited for high-performance applications that need more resources and host control. You can also choose to enable [Trusted Compute](/docs/containers?topic=containers-security#trusted_compute) to verify your worker nodes against tampering. Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud ks feature-enable` [command](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.
    Be sure that you want to provision a bare metal machine. Because it is billed monthly, if you cancel it immediately after an order by mistake, you are still charged the full month.
    {:tip}
    - **Virtual - shared**: Infrastructure resources, such as the hypervisor and physical hardware, are shared across you and other IBM customers, but each worker node is accessible only by you. Although this option is less expensive and sufficient in most cases, you might want to verify your performance and infrastructure requirements with your company policies.
    - **Virtual - dedicated**: Your worker nodes are hosted on infrastructure that is devoted to your account. Your physical resources are completely isolated.
  3. Select a flavor. The flavor defines the amount of virtual CPU, memory, and disk space that is set up in each worker node and made available to the containers. Available bare metal and virtual machines types vary by the zone in which you deploy the cluster. After you create your cluster, you can add different machine types by adding a worker or pool to the cluster.
  4. Specify the number of worker nodes that you need in the cluster. The number of workers that you enter is replicated across the number of zones that you selected. This means that if you have 2 zones and select 3 worker nodes, 6 nodes are provisioned, and 3 nodes live in each zone.

9. Click **Create cluster**. A worker pool is created with the number of workers that you specified. You can see the progress of the worker node deployment in the **Worker nodes** tab. When the deploy is done, you can see that your cluster is ready in the **Overview** tab. Note that even if the cluster is ready, some parts of the cluster that are used by other services, such as Ingress secrets or registry image pull secrets, might still be in process.

</br>
**Using the {{site.data.keyword.Bluemix_notm}} CLI**</br>

Before you begin, install the {{site.data.keyword.Bluemix_notm}} CLI and the [{{site.data.keyword.containerlong_notm}} plug-in](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).

1. Log in to the {{site.data.keyword.Bluemix_notm}} CLI.
  1. Log in and enter your {{site.data.keyword.Bluemix_notm}} credentials when prompted.
     ```
     ibmcloud login
     ```
     {: pre}

     If you have a federated ID, use `ibmcloud login --sso` to log in to the {{site.data.keyword.Bluemix_notm}} CLI. Enter your user name and use the provided URL in your CLI output to retrieve your one-time passcode. You know you have a federated ID when the login fails without the `--sso` and succeeds with the `--sso` option.
     {: tip}

  2. If you have multiple {{site.data.keyword.Bluemix_notm}} accounts, select the account where you want to create your Kubernetes cluster.

  3. To create clusters in a resource group other than default, target that resource group.
      **Note**:
        * A cluster can be created in only one resource group, and after the cluster is created, you can't change its resource group.
        * You must have at least the [**Viewer** role](/docs/containers?topic=containers-users#platform) for the resource group.
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

3. Review the zones that are available and note the zone ID. To see zones in a specific location, such as a geography, country, or a metro, you can specify the location in the `--locations` flag. To span your cluster across zones, you must create the cluster in a [multizone-capable zone](/docs/containers?topic=containers-regions-and-zones#zones).
    ```
    ibmcloud ks zones [--locations <location>]
    ```
    {: pre}
    When you select a zone that is located outside your country, keep in mind that you might require legal authorization before data can be physically stored in a foreign country.
    {: note}

4. Review the worker node flavors that are available in that zone. The worker flavor specifies the virtual or physical compute hosts that are available to each worker node.
  - **Virtual**: Billed hourly, virtual machines are provisioned on shared or dedicated hardware.
  - **Physical**: Billed monthly, bare metal servers are provisioned manually by IBM Cloud infrastructure (SoftLayer) after you order, and can take more than one business day to complete. Bare metal is best suited for high-performance applications that need more resources and host control.
  - **Physical machines with Trusted Compute**: You can also choose to enable [Trusted Compute](/docs/containers?topic=containers-security#trusted_compute) to verify your bare metal worker nodes against tampering. Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud ks feature-enable` [command](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.
  - **Machine types**: To decide what machine type to deploy, review the core, memory, and storage combinations of the [available worker node hardware](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node). After you create your cluster, you can add different physical or virtual machine types by [adding a worker pool](#add_pool).

     Be sure that you want to provision a bare metal machine. Because it is billed monthly, if you cancel it immediately after an order by mistake, you are still charged the full month.
     {:tip}

  ```
  ibmcloud ks machine-types --zone <zone>
  ```
  {: pre}

5. Check to see if a private VLAN for the zone already exists in the IBM Cloud infrastructure (SoftLayer) for this account. If you have a private VLAN, note the ID.
    ```
    ibmcloud ks vlans --zone <zone>
    ```
    {: pre}

    ```
    ID        Name   Number   Type      Router
    1519999   vlan   1355     private   bcr02a.dal10
    1519898   vlan   1357     private   bcr02a.dal10
    ```
    {: screen}

6. Run the `cluster-create` command. By default, the worker node disks are AES 256-bit encrypted and the cluster is billed by hours of usage.
    ```
    ibmcloud ks cluster-create --zone <zone> --machine-type b3c.4x16 --hardware <shared_or_dedicated> --private-vlan <private_VLAN_ID> --private-only --private-service-endpoint --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt] [--trusted]
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
    <td>Specify the {{site.data.keyword.Bluemix_notm}} zone ID where you want to create your cluster that you chose in step 3.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Specify the machine type that you chose in step 4.</td>
    </tr>
    <tr>
    <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
    <td>Specify with the level of hardware isolation for your worker node. Use dedicated to have available physical resources dedicated to you only, or shared to allow physical resources to be shared with other IBM customers. The default is shared. This value is optional for VM standard clusters. For bare metal machine types, specify `dedicated`.</td>
    </tr>
    <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
    <td>If you already have a private VLAN set up in your IBM Cloud infrastructure (SoftLayer) account for that zone, enter the ID of the private VLAN that you found in step 5. If you do not have a private VLAN in your account, do not specify this option. {{site.data.keyword.containerlong_notm}} automatically creates a private VLAN for you.</td>
    </tr>
    <tr>
    <td><code>--private-only</code></td>
    <td>Create the cluster with private VLANs only.</td>
    </tr>
    <tr>
    <td><code>--private-service-endpoint</code></td>
    <td>**In [VRF-enabled accounts](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)**: Enable the private service endpoint so that your Kubernetes master and the worker nodes can communicate over the private VLAN. You must be connected to the private VLAN to communicate with your Kubernetes master. After you create the cluster, you can get the endpoint by running `ibmcloud ks cluster-get <cluster_name_or_ID>`.</br></br>If your account is not VRF enabled, you must enable connection between your master and worker nodes by setting up your own gateway device.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Specify a name for your cluster. The name must start with a letter, can contain letters, numbers, and hyphen (-), and must be 35 characters or fewer. The cluster name and the region in which the cluster is deployed form the fully qualified domain name for the Ingress subdomain. To ensure that the Ingress subdomain is unique within a region, the cluster name might be truncated and appended with a random value within the Ingress domain name.
</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>Specify the number of worker nodes to include in the cluster. If the <code>--workers</code> option is not specified, 1 worker node is created.</td>
    </tr>
    <tr>
    <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
    <td>The Kubernetes version for the cluster master node. This value is optional. When the version is not specified, the cluster is created with the default of supported Kubernetes versions. To see available versions, run <code>ibmcloud ks kube-versions</code>.
</td>
    </tr>
    <tr>
    <td><code>--disable-disk-encrypt</code></td>
    <td>Worker nodes feature AES 256-bit [disk encryption](/docs/containers?topic=containers-security#encrypted_disk) by default. If you want to disable encryption, include this option.</td>
    </tr>
    <tr>
    <td><code>--trusted</code></td>
    <td>**Bare metal clusters**: Enable [Trusted Compute](/docs/containers?topic=containers-security#trusted_compute) to verify your bare metal worker nodes against tampering. Trusted Compute is available for select bare metal machine types. For example, `mgXc` GPU flavors do not support Trusted Compute. If you don't enable trust during cluster creation but want to later, you can use the `ibmcloud ks feature-enable` [command](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable). After you enable trust, you cannot disable it later.</td>
    </tr>
    </tbody></table>

7. Verify that the creation of the cluster was requested. For virtual machines, it can take a few minutes for the worker node machines to be ordered, and for the cluster to be set up and provisioned in your account. Bare metal physical machines are provisioned by manual interaction with IBM Cloud infrastructure (SoftLayer), and can take more than one business day to complete.
    ```
    ibmcloud ks clusters
    ```
    {: pre}

    When the provisioning of your cluster is completed, the status of your cluster changes to **deployed**.
    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.12.7      Default
    ```
    {: screen}

8. Check the status of the worker nodes.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    When the worker nodes are ready, the state changes to **normal** and the status is **Ready**. When the node status is **Ready**, you can then access the cluster. Note that even if the cluster is ready, some parts of the cluster that are used by other services, such as Ingress secrets or registry image pull secrets, might still be in process.

    Every worker node is assigned a unique worker node ID and domain name that must not be changed manually after the cluster is created. Changing the ID or domain name prevents the Kubernetes master from managing your cluster.
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   -               10.xxx.xx.xxx   standard       normal   Ready    mil01       1.12.7      Default
    ```
    {: screen}

<br />


## Step 3: Accessing your private cluster and viewing cluster states
{: #private_access_states}

After you cluster is created, you can begin working with your cluster and view its state.
{: shortdesc}

### Accessing your cluster
{: #private_access_cluster}

Get access to your cluster by configuring your CLI session.
{: shortdesc}

1. Verify that you are in your {{site.data.keyword.Bluemix_notm}} private network or are connected to the private network through a VPN connection.

2. If your network access is protected by a company firewall:
  1. [Allow your authorized cluster users to run `kubectl` commands](/docs/containers?topic=containers-firewall#firewall_kubectl) to access the master through the private service endpoint. Your cluster users must be in your {{site.data.keyword.Bluemix_notm}} private network or connect to the private network through a VPN connection to run `kubectl` commands.
  2. [Allow access to the public endpoints for the `ibmcloud` API and the `ibmcloud ks` API in your firewall](/docs/containers?topic=containers-firewall#firewall_bx). Although all communication to the master goes over the private network, `ibmcloud` and `ibmcloud ks` commands must go over the public API endpoints.

3. If you have a firewall on the private network, [allow communication between worker nodes and let your cluster access infrastructure resources over the private network](/docs/containers?topic=containers-firewall#firewall_private).

4. Set the cluster you created as the context for this session. Complete these configuration steps every time that you work with your cluster.
  If you want to use the {{site.data.keyword.Bluemix_notm}} console instead, after your cluster is created, you can run CLI commands directly from your web browser in the [Kubernetes Terminal](#cli_web).
  {: tip}
  1. Get the command to set the environment variable and download the Kubernetes configuration files.
      ```
      ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
      ```
      {: pre}
      When the download of the configuration files is finished, a command is displayed that you can use to set the path to the local Kubernetes configuration file as an environment variable.

      Example for OS X:
      ```
      export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
      ```
      {: screen}
  2. Copy and paste the command that is displayed in your terminal to set the `KUBECONFIG` environment variable.
  3. Verify that the `KUBECONFIG` environment variable is set properly.
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

6. Launch your Kubernetes dashboard with the default port `8001`.
  1. Set the proxy with the default port number.
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

### Viewing cluster states
{: #private_states}

Review the state of a Kubernetes cluster to get information about the availability and capacity of the cluster, and potential problems that might have occurred.
{:shortdesc}

To view information about a specific cluster, such as its zones, service endpoint URLs, Ingress subdomain, version, owner, and monitoring dashboard, use the `ibmcloud ks cluster-get <cluster_name_or_ID>` [command](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get). Include the `--showResources` flag to view more cluster resources such as add-ons for storage pods or subnet VLANs for public and private IPs.

You can view the current cluster state by running the `ibmcloud ks clusters` command and locating the **State** field. To troubleshoot your cluster and worker nodes, see [Troubleshooting clusters](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters).

<table summary="Every table row should be read left to right, with the cluster state in column one and a description in column two.">
<caption>Cluster states</caption>
   <thead>
   <th>Cluster state</th>
   <th>Description</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>The deletion of the cluster is requested by the user before the Kubernetes master is deployed. After the deletion of the cluster is completed, the cluster is removed from your dashboard. If your cluster is stuck in this state for a long time, open an [{{site.data.keyword.Bluemix_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
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
     <td>The cluster is deleted but not yet removed from your dashboard. If your cluster is stuck in this state for a long time, open an [{{site.data.keyword.Bluemix_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>The cluster is being deleted and cluster infrastructure is being dismantled. You cannot access the cluster.  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>The deployment of the Kubernetes master could not be completed. You cannot resolve this state. Contact IBM Cloud support by opening an [{{site.data.keyword.Bluemix_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>The Kubernetes master is not fully deployed yet. You cannot access your cluster. Wait until your cluster is fully deployed to review the health of your cluster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>All worker nodes in a cluster are up and running. You can access the cluster and deploy apps to the cluster. This state is considered healthy and does not require an action from you.<p class="note">Although the worker nodes might be normal, other infrastructure resources, such as [networking](/docs/containers?topic=containers-cs_troubleshoot_network) and [storage](/docs/containers?topic=containers-cs_troubleshoot_storage), might still need attention. If you just created the cluster, some parts of the cluster that are used by other services such as Ingress secrets or registry image pull secrets, might still be in process.</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>The Kubernetes master is deployed. The worker nodes are being provisioned and are not available in the cluster yet. You can access the cluster, but you cannot deploy apps to the cluster.  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>A request to create the cluster and order the infrastructure for the Kubernetes master and worker nodes is sent. When the deployment of the cluster starts, the cluster state changes to <code>Deploying</code>. If your cluster is stuck in the <code>Requested</code> state for a long time, open an [{{site.data.keyword.Bluemix_notm}} support case](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
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


## Step 4: Adding worker nodes and zones to clusters
{: #private_add_workers}

To increase the availability of your apps, you can add worker nodes to an existing zone or multiple existing zones in your cluster. To help protect your apps from zone failures, you can add zones to your cluster.
{:shortdesc}

When you create a cluster, the worker nodes are provisioned in a worker pool. After cluster creation, you can add more worker nodes to a pool by resizing it or by adding more worker pools. By default, the worker pool exists in one zone. Clusters that have a worker pool in only one zone are called single zone clusters. When you add more zones to the cluster, the worker pool exists across the zones. Clusters that have a worker pool that is spread across more than one zone are called multizone clusters.

If you have a multizone cluster, keep its worker node resources balanced. Make sure that all the worker pools are spread across the same zones, and add or remove workers by resizing the pools instead of adding individual nodes.
{: tip}

Before you begin, make sure you have the [**Operator** or **Administrator** {{site.data.keyword.Bluemix_notm}} IAM platform role](/docs/containers?topic=containers-users#platform). Then, choose one of the following sections:
  * [Add worker nodes by resizing an existing worker pool in your cluster](#resize_pool)
  * [Add worker nodes by adding a worker pool to your cluster](#add_pool)
  * [Add a zone to your cluster and replicate the worker nodes in your worker pools across multiple zones](#add_zone)
  * [Deprecated: Add a stand-alone worker node to a cluster](#standalone)

After you set up your worker pool, you can [set up the cluster autoscaler](/docs/containers?topic=containers-ca#ca) to automatically add or remove worker nodes from your worker pools based on your workload resource requests.
{:tip}

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
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name> --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. Verify that the worker pool is resized.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Example output for a worker pool that is in two zones, `dal10` and `dal12`, and is resized to two worker nodes per zone:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Adding worker nodes by creating a new worker pool
{: #add_pool}

You can add worker nodes to your cluster by creating a new worker pool.
{:shortdesc}

1. Retrieve the **Worker Zones** of your cluster and choose the zone where you want to deploy the worker nodes in your worker pool. If you have a single zone cluster, you must use the zone that you see in the **Worker Zones** field. For multizone clusters, you can choose any of the existing **Worker Zones** of your cluster, or add one of the [multizone metro locations](/docs/containers?topic=containers-regions-and-zones#zones) for the region that your cluster is in. You can list available zones by running `ibmcloud ks zones`.
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

2. For each zone, list available private VLANs and note the private VLAN that you want to use. If you do not have a private VLAN, the VLAN is automatically created for you when you add a zone to your worker pool.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3.  For each zone, review the [available machine types for worker nodes](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node).

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
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID>
   ```
   {: pre}

7. Verify that worker nodes provision in the zone that you added. Your worker nodes are ready when the status changes from **provision_pending** to **normal**.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   Example output:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Adding worker nodes by adding a zone to a worker pool
{: #add_zone}

You can span your cluster across multiple zones within one region by adding a zone to your existing worker pool.
{:shortdesc}

When you add a zone to a worker pool, the worker nodes that are defined in your worker pool are provisioned in the new zone and considered for future workload scheduling. {{site.data.keyword.containerlong_notm}} automatically adds the `failure-domain.beta.kubernetes.io/region` label for the region and the `failure-domain.beta.kubernetes.io/zone` label for the zone to each worker node. The Kubernetes scheduler uses these labels to spread pods across zones within the same region.

If you have multiple worker pools in your cluster, add the zone to all of them so that worker nodes are spread evenly across your cluster.

Before you begin:
*  To add a zone to your worker pool, your worker pool must be in a [multizone-capable zone](/docs/containers?topic=containers-regions-and-zones#zones). If your worker pool is not in a multizone-capable zone, consider [creating a new worker pool](#add_pool).
*  If you have multiple VLANs for a cluster, multiple subnets on the same VLAN, or a multizone cluster, you must enable a [Virtual Router Function (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) for your IBM Cloud infrastructure (SoftLayer) account so your worker nodes can communicate with each other on the private network. To enable VRF, [contact your IBM Cloud infrastructure (SoftLayer) account representative](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). If you cannot or do not want to enable VRF, enable [VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). To perform this action, you need the **Network > Manage Network VLAN Spanning** [infrastructure permission](/docs/containers?topic=containers-users#infra_access), or you can request the account owner to enable it. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan-spanning-get` [command](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get).

To add a zone with worker nodes to your worker pool:

1. List available zones and pick the zone that you want to add to your worker pool. The zone that you choose must be a multizone-capable zone.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. List available VLANs in that zone and note the private VLAN that you want to use. If you do not have a private VLAN, the VLAN is automatically created for you when you add a zone to your worker pool.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. List the worker pools in your cluster and note their names.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. Add the zone to your worker pool. If you have multiple worker pools, add the zone to all your worker pools so that your cluster is balanced in all zones. Replace `<pool1_id_or_name,pool2_id_or_name,...>` with the names of all of your worker pools in a comma-separated list.

    A private VLAN must exist before you can add a zone to multiple worker pools. If you do not have a private VLAN in that zone, add the zone to one worker pool first so that a private VLAN is created for you. Then, you can add the zone to other worker pools by specifying the private VLAN that was created for you.
    {: note}

   If you want to use different VLANs for different worker pools, repeat this command for each VLAN and its corresponding worker pools. Any new worker nodes are added to the VLANs that you specify, but the VLANs for any existing worker nodes are not changed.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID>
   ```
   {: pre}

5. Verify that the zone is added to your cluster. Look for the added zone in the **Worker zones** field of the output. Note that the total number of workers in the **Workers** field has increased as new worker nodes are provisioned in the added zone.
  ```
  ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Example output:
  ```
  Name:                           mycluster
  ID:                             df253b6025d64944ab99ed63bb4567b6
  State:                          normal
  Created:                        2018-09-28T15:43:15+0000
  Location:                       dal10
  Master URL:                     https://c3-private.<region>.containers.cloud.ibm.com:31140
  Public Service Endpoint URL:    -
  Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
  Master Location:                Dallas
  Master Status:                  Ready (21 hours ago)
  Ingress Subdomain:              mycluster.us-south.containers.appdomain.cloud
  Ingress Secret:                 mycluster
  Workers:                        6
  Worker Zones:                   dal10, dal12
  Version:                        1.11.3_1524
  Owner:                          owner@email.com
  Monitoring Dashboard:           ...
  Resource Group ID:              a8a12accd63b437bbd6d58fb6a462ca7
  Resource Group Name:            Default
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
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. List available machine types in that zone.
   ```
   ibmcloud ks machine-types --zone <zone>
   ```
   {: pre}

4. Add stand-alone worker nodes to the cluster. For bare metal machine types, specify `dedicated`.
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. Verify that the worker nodes are created.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## Next steps
{: #private_next_steps}

When the cluster is up and running, you can check out the following tasks:
- [Deploy an app in your cluster.](/docs/containers?topic=containers-app#app_cli)
- [Set up your own private registry in {{site.data.keyword.Bluemix_notm}} to store and share Docker images with other users.](/docs/services/Registry?topic=registry-getting-started)
- [Set up the cluster autoscaler](/docs/containers?topic=containers-ca#ca) to automatically add or remove worker nodes from your worker pools based on your workload resource requests.
- Control who can create pods in your cluster with [pod security policies](/docs/containers?topic=containers-psp).

You can also check out the following additional network configuration steps for your private cluster setup:
* Calico-protected VRF clusters:
  * [Create Calico host network policies](/docs/containers?topic=containers-network_policies#isolate_workers) to block public access to pods, isolate your cluster on the private network, and allow access to other {{site.data.keyword.Bluemix_notm}} services.
  * Isolate networking workloads to [edge worker nodes](/docs/containers?topic=containers-edge).
  * Expose your apps with [private networking services](/docs/containers?topic=containers-cs_network_planning#private_access).
  * Set up a [strongSwan IPSec VPN service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/about.html) to allow communication between apps and services in your cluster and an on-premises network or {{site.data.keyword.icpfull_notm}}.
* Private VRF clusters:
  * TBD
* Private clusters with gateway devices:
  * To securely connect your worker nodes and apps to an on-premises network, set up an IPSec VPN endpoint on your gateway device. Then, [configure the strongSwan IPSec VPN service](/docs/containers?topic=containers-vpn#vpn-setup) in your cluster to use the VPN endpoint on your gateway or [set up VPN connectivity directly with VRA](/docs/containers?topic=containers-vpn#vyatta).
  * Expose your apps with [private networking services](/docs/containers?topic=containers-cs_network_planning#private_access).
  * [Open up the required ports and IP addresses](/docs/containers?topic=containers-firewall#firewall_inbound) in your gateway device firewall to permit inbound traffic to networking services.
