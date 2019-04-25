 cluster. Note that multizone clusters are available in select locations only.
  * Choose what type of [hardware and isolation](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes) you want for your cluster's worker nodes, including the decision between virtual or bare metal machines.

6. You can [estimate the cost](/docs/billing-usage?topic=billing-usage-cost#cost) in the {{site.data.keyword.Bluemix_notm}} console. For more information on charges that might not be included in the estimator, see [Pricing and billing](/docs/containers?topic=containers-faqs#charges).

<br />


## Step 2: Create a private cluster
{: #create-private}

Choose one of the following private cluster setups.
* **[Calico-protected VRF cluster](#calico-pc-cluster)**: Create worker nodes on both public and private VLANs and use the private service endpoint to connect the Kubernetes master with worker nodes. This setup requires a VRF in your IBM Cloud infrastructure (SoftLayer) account. After you create the cluster, you can lock down the cluster's public interface as needed by blocking public VLAN traffic with Calico policies and restricting traffic to select edge nodes.
* **[Private VRF cluster](#standard-pc-cluster)**: TBD
* **[Private cluster with gateway device](#legacy-pc-cluster)**: Create worker nodes on private VLANs only. This setup requires gateway device to provide connectivity between the Kubernetes master and worker nodes, and to act as a firewall for your cluster.

Want more information on each setup? See [Private cluster network setups](/docs/containers?topic=containers-plan_clusters#private_clusters).
{: tip}

### Create a Calico-protected VRF cluster
{: #calico-pc-cluster}

1. Set up your IBM Cloud infrastructure (SoftLayer) networking.
  1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in your IBM Cloud infrastructure (SoftLayer) account.
  2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
  3. To run `kubectl` commands against your cluster over an IPSec VPN connection or through DirectLink, you must access the master through the private service endpoint. However, communication with the Kubernetes master must go through the `166.XXX.XXX` IP address range, which is not routable from a IPSec VPN connection or through DirectLink. You must set up a jump server on the private network. The VPN or DirectLink connection terminates at the jump server, and the jump server then routes communication through the internal `10.XXX.XXX` IP address range to the Kubernetes master.

2. Create a standard cluster that is connected to both public and private VLANs by following the steps in [Creating a standard cluster](/docs/containers?topic=containers-clusters#clusters_ui_standard). To ensure that the Kubernetes master and worker nodes communicate over the private network only, note the following changes:
  * If you use the console, in step 8, select **Private endpoint only**.
  * If you use the CLI, in step 7, include the `--private-service-endpoint` flag and do not include the `--public-service-endpoint` flag.

3. After you create the cluster, continue with [Step 3: Accessing your private cluster and viewing cluster states](#private_access_states).


### Create a private VRF cluster
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
    2. Select the specific zones in which you want to host your cluster. You must select at least 1 zone but you can select as many as you would like. If you select more than 1 zone, the worker nodes are spread across the zones that you choose which gives you higher availability. If you select only 1 zone, you can [add zones to your cluster](/docs/containers?topic=containers-add_workers#add_zone) after it is created.
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
  - **Machine types**: To decide what machine type to deploy, review the core, memory, and storage combinations of the [available worker node hardware](/docs/containers?topic=containers-planning_worker_nodes#shared_dedicated_node). After you create your cluster, you can add different physical or virtual machine types by [adding a worker pool](/docs/containers?topic=containers-add_workers#add_pool).

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


## Step 3: Accessing your cluster
{: #private_access_cluster}

After you cluster is created, you can setup access to begin working with your cluster.
{: shortdesc}

1. Verify that you are in your {{site.data.keyword.Bluemix_notm}} private network or are connected to the private network through a VPN connection.

2. If your network access is protected by a company firewall:
  1. [Allow your authorized cluster users to run `kubectl` commands](/docs/containers?topic=containers-firewall#firewall_kubectl) to access the master through the private service endpoint. Your cluster users must be in your {{site.data.keyword.Bluemix_notm}} private network or connect to the private network through a VPN connection to run `kubectl` commands.
  2. [Allow access to the public endpoints for the `ibmcloud` API and the `ibmcloud ks` API in your firewall](/docs/containers?topic=containers-firewall#firewall_bx). Although all communication to the master goes over the private network, `ibmcloud` and `ibmcloud ks` commands must go over the public API endpoints.

3. If you have a firewall on the private network, [allow communication between worker nodes and let your cluster access infrastructure resources over the private network](/docs/containers?topic=containers-firewall#firewall_private).

4. Set the cluster you created as the context for this session. Complete these configuration steps every time that you work with your cluster.

  If you want to use the {{site.data.keyword.Bluemix_notm}} console instead, after your cluster is created, you can run CLI commands directly from your web browser in the [Kubernetes Terminal](/docs/containers?topic=containers-cs_cli_install#cli_web).
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

<br />


## Next steps
{: #private_next_steps}

When the cluster is up and running, you can check out the following tasks:
- [ ]()
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

</staging>
