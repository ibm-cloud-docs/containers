---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-11"

keywords: kubernetes, iks

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

# Setting up your cluster network
{: #cs_network_cluster}

Set up a networking configuration in your {{site.data.keyword.containerlong}} cluster.
{:shortdesc}

This page helps you set up your cluster's network configuration. Not sure which setup to choose? See [Planning your cluster network](/docs/containers?topic=containers-cs_network_ov).
{: tip}

## Setting up cluster networking with a public and a private VLAN
{: #both_vlans}

Set up your cluster with access to [a public VLAN and a private VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options).
{: shortdesc}

This networking setup consists of the following required networking configurations during cluster creation and optional networking configurations after cluster creation.

1. If you create the cluster in an environment behind a firewall, [allow outbound network traffic to the public and private IPs](/docs/containers?topic=containers-firewall#firewall_outbound) for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.

2. Create a cluster that is connected to a public and a private VLAN. If you create a multizone cluster, you can choose VLAN pairs for each zone.

3. Choose how your Kubernetes master and worker nodes communicate.
  * If VRF is enabled in your {{site.data.keyword.Bluemix_notm}} account, enable [public-only](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public), [public and private](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both), or [private-only service endpoints](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private).
  * If you cannot or do not want to enable VRF, enable the [public service endpoint only](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public) and [enable VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

4. After you create your cluster, you can configure the following networking options:
  * Set up a [strongSwan VPN connection service](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_public) to allow communication between your cluster and an on-premises network or {{site.data.keyword.icpfull_notm}}.
  * Create [Kubernetes discovery services](/docs/containers?topic=containers-cs_network_planning#in-cluster) to allow in-cluster communication between pods.
  * Create [public](/docs/containers?topic=containers-cs_network_planning#public_access) Ingress, load balancer, or node port services to expose apps to public networks.
  * Create [private](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) Ingress, load balancer, or node port services to expose apps to private networks and create Calico network policies to secure your cluster from public access.
  * Isolate networking workloads to [edge worker nodes](#both_vlans_private_edge).
  * [Isolate your cluster on the private network](#isolate).

<br />


## Setting up cluster networking with a private VLAN only
{: #setup_private_vlan}

If you have specific security requirements or need to create custom network policies and routing rules to provide dedicated network security, set up your cluster with access to [a private VLAN only](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options).
{: shortdesc}

This networking setup consists of the following required networking configurations during cluster creation and optional networking configurations after cluster creation.

1. If you create the cluster in an environment behind a firewall, [allow outbound network traffic to the public and private IPs](/docs/containers?topic=containers-firewall#firewall_outbound) for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.

2. Create a cluster that is connected to [private VLAN only](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). If you create a multizone cluster, you can choose a private VLAN in each zone.

3. Choose how your Kubernetes master and worker nodes communicate.
  * If VRF is enabled in your {{site.data.keyword.Bluemix_notm}} account, [enable a private service endpoint](#set-up-private-se).
  * If you cannot or do not want to enable VRF, your Kubernetes master and worker nodes can't automatically connect to the master. You must configure your cluster with a [gateway appliance](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private).

4. After you create your cluster, you can configure the following networking options:
  * [Set up a VPN gateway](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private) to allow communication between your cluster and an on-premises network or {{site.data.keyword.icpfull_notm}}. If you previously set up a VRA (Vyatta) or FSA to allow communication between the master and worker nodes, you can configure an IPSec VPN endpoint on the VRA or FSA.
  * Create [Kubernetes discovery services](/docs/containers?topic=containers-cs_network_planning#in-cluster) to allow in-cluster communication between pods.
  * Create [private](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan) Ingress, load balancer, or node port services to expose apps on private networks.
  * Isolate networking workloads to [edge worker nodes](#both_vlans_private_edge).
  * [Isolate your cluster on the private network](#isolate).

<br />


## Changing your worker node VLAN connections
{: #change-vlans}

When you create a cluster, you choose whether to connect your worker nodes to a private and a public VLAN or to a private VLAN only. Your worker nodes are part of worker pools, which store networking metadata that includes the VLANs to use to provision future worker nodes in the pool. You might want to change your cluster's VLAN connectivity setup later, in cases such as the following.
{: shortdesc}

* The worker pool VLANs in a zone run out of capacity, and you need to provision a new VLAN for your cluster worker nodes to use.
* You have a cluster with worker nodes that are on both public and private VLANs, but you want to change to a [private-only cluster](#setup_private_vlan).
* You have a private-only cluster, but you want some worker nodes such as a worker pool of [edge nodes](/docs/containers?topic=containers-edge#edge) on the public VLAN to expose your apps on the internet.

Trying to change the service endpoint for master-worker communication instead? Check out the topics to set up [public](#set-up-public-se) and [private](#set-up-private-se) service endpoints.
{: tip}

Before you begin:
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
* If your worker nodes are stand-alone (not part of a worker pool), [update them to worker pools](/docs/containers?topic=containers-update#standalone_to_workerpool).

To change the VLANs that a worker pool uses to provision worker nodes:

1. List the names of the worker pools in your cluster.
  ```
  ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Determine the zones for one of the worker pools. In the output, look for the **Zones** field.
  ```
  ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

3. For each zone that you found in the previous step, get an available public and private VLAN that are compatible with each other.

  1. Check the available public and private VLANs that are listed under **Type** in the output.
     ```
     ibmcloud ks vlans --zone <zone>
     ```
     {: pre}

  2. Check that the public and private VLANs in the zone are compatible. To be compatible, the **Router** must have the same pod ID. In this example output, the **Router** pod IDs match: `01a` and `01a`. If one pod ID were `01a` and the other were `02a`, you cannot set these public and private VLAN IDs for your worker pool.
     ```
     ID        Name   Number   Type      Router         Supports Virtual Workers
     229xxxx          1234     private   bcr01a.dal12   true
     229xxxx          5678     public    fcr01a.dal12   true
     ```
     {: screen}

  3. If you need to order a new public or private VLAN for the zone, you can order in the [{{site.data.keyword.Bluemix_notm}} console](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans), or use the following command. Remember that the VLANs must be compatible, with matching **Router** pod IDs as in the previous step. If you are creating a pair of new public and private VLANs, they must be compatible with each other.
     ```
     ibmcloud sl vlan create -t [public|private] -d <zone> -r <compatible_router>
     ```
     {: pre}

  4. Note the IDs of the compatible VLANs.

4. Set up a worker pool with the new VLAN network metadata for each zone. You can create a new worker pool, or modify an existing worker pool.

  * **Create a new worker pool**: See [adding worker nodes by creating a new worker pool](/docs/containers?topic=containers-clusters#add_pool).

  * **Modify an existing worker pool**: Set the worker pool's network metadata to use the VLAN for each zone. Worker nodes that were already created in the pool continue to use the previous VLANs, but new worker nodes in the pool use new VLAN metadata that you set.

    * Example to add both public and private VLANs, such as if you change from private-only to both private and public:
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

    * Example to add only a private VLAN, such as if you change from public and private VLANs to private-only when you have a [VRF-enabled account that uses service endpoints](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started):
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

5. Add worker nodes to the worker pool by resizing the pool.
   ```
   ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

   If you want to remove worker nodes that use the previous network metadata, change the number of workers per zone to double the previous amount of workers per zone. Later in these steps, you can cordon, drain, and remove the previous worker nodes.
  {: tip}

6. Verify that new worker nodes are created with the appropriate **Public IP** and **Private IP** in the output. For example, if you change the worker pool from a public and private VLAN to private-only, the new worker nodes have only a private IP. If you change the worker pool from private-only to both public and private VLANs, the new worker nodes have both public and private IPs.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

7. Optional: Remove the worker nodes with the previous network metadata from the worker pool.
  1. In the output of the previous step, note the **ID** and **Private IP** of the worker nodes that you want to remove from the worker pool.
  2. Mark the worker node as unschedulable in a process that is known as cordoning. When you cordon a worker node, you make it unavailable for future pod scheduling.
     ```
     kubectl cordon <worker_private_ip>
     ```
     {: pre}
  3. Verify that pod scheduling is disabled for your worker node.
     ```
     kubectl get nodes
     ```
     {: pre}
     Your worker node is disabled for pod scheduling if the status displays **`SchedulingDisabled`**.
  4. Force pods to be removed from your worker node and rescheduled onto remaining worker nodes in the cluster.
     ```
     kubectl drain <worker_private_ip>
     ```
     {: pre}
     This process can take a few minutes.
  5. Remove the worker node. Use the worker ID that you previously retrieved.
     ```
     ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
     ```
     {: pre}
  6. Verify that the worker node is removed.
     ```
     ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
     ```
     {: pre}
 
8. Optional: You can repeat steps 2 - 7 for each worker pool in your cluster. After you complete these steps, all worker nodes in your cluster are set up with the new VLANs.

<br />


## Setting up the private service endpoint
{: #set-up-private-se}

In clusters that run Kubernetes version 1.11 or later, enable or disable the private service endpoint for your cluster.
{: shortdesc}

The private service endpoint makes your Kubernetes master privately accessible. Your worker nodes and your authorized cluster users can communicate with the Kubernetes master over the private network. To determine whether you can enable the private service endpoint, see [Planning master-to-worker communication](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master). Note that you cannot disable the private service endpoint after you enable it.

**Steps to enable during cluster creation**</br>
1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in your IBM Cloud infrastructure (SoftLayer) account.
2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
3. If you create the cluster in an environment behind a firewall, [allow outbound network traffic to the public and private IPs](/docs/containers?topic=containers-firewall#firewall_outbound) for infrastructure resources and for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.
4. Create a cluster:
  * [Create a cluster with the CLI](/docs/containers?topic=containers-clusters#clusters_cli) and use the `--private-service-endpoint` flag. If you want to enable the public service endpoint too, use the `--public-service-endpoint` flag also.
  * [Create a cluster with the UI](/docs/containers?topic=containers-clusters#clusters_ui_standard) and select **Private endpoint only**. If you want to enable the public service endpoint too, select **Both private & public endpoints**.
5. If you enable the private service endpoint only for a cluster in an environment behind a firewall:
  1. Verify that you are in your {{site.data.keyword.Bluemix_notm}} private network or are connected to the private network through a VPN connection.
  2. [Allow your authorized cluster users to run `kubectl` commands](/docs/containers?topic=containers-firewall#firewall_kubectl) to access the master through the private service endpoint. Your cluster users must be in your {{site.data.keyword.Bluemix_notm}} private network or connect to the private network through a VPN connection to run `kubectl` commands.
  3. If your network access is protected by a company firewall, you must [allow access to the public endpoints for the `ibmcloud` API and the `ibmcloud ks` API in your firewall](/docs/containers?topic=containers-firewall#firewall_bx). Although all communication to the master goes over the private network, `ibmcloud` and `ibmcloud ks` commands must go over the public API endpoints.

  </br>

**Steps to enable after cluster creation**</br>
1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in your IBM Cloud infrastructure (SoftLayer) account.
2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
3. Enable the private service endpoint.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
4. Refresh the Kubernetes master API server to use the private service endpoint. You can follow the prompt in the CLI, or manually run the following command.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}

5. [Create a configmap](/docs/containers?topic=containers-update#worker-up-configmap) to control the maximum number of worker nodes that can be unavailable at a time in your cluster. When you update your worker nodes, the configmap helps prevent downtime for your apps as the apps are rescheduled orderly onto available worker nodes.
6. Update all the worker nodes in your cluster to pick up the private service endpoint configuration.

   <p class="important">By issuing the update command, the worker nodes are reloaded to pick up the service endpoint configuration. If no worker update is available, you must [reload the worker nodes manually](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). If you reload, be sure to cordon, drain, and manage the order to control the maximum number of worker nodes that are unavailable at a time.</p>
   ```
   ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
   ```
   {: pre}

8. If the cluster is in an environment behind a firewall:
  * [Allow your authorized cluster users to run `kubectl` commands to access the master through the private service endpoint.](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * [Allow outbound network traffic to the private IPs](/docs/containers?topic=containers-firewall#firewall_outbound) for infrastructure resources and for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.

9. Optional: To use the private service endpoint only, disable the public service endpoint.
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
  </br>

**Steps to disable**</br>
The private service endpoint cannot be disabled.

## Setting up the public service endpoint
{: #set-up-public-se}

Enable or disable the public service endpoint for your cluster.
{: shortdesc}

The public service endpoint makes your Kubernetes master publicly accessible. Your worker nodes and your authorized cluster users can securely communicate with the Kubernetes master over the public network. To determine whether you can enable the public service endpoint, see [Planning communication between worker nodes and the Kubernetes master](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master).

**Steps to enable during cluster creation**</br>

1. If you create the cluster in an environment behind a firewall, [allow outbound network traffic to the public and private IPs](/docs/containers?topic=containers-firewall#firewall_outbound) for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.

2. Create a cluster:
  * [Create a cluster with the CLI](/docs/containers?topic=containers-clusters#clusters_cli) and use the `--public-service-endpoint` flag. If you want to enable the private service endpoint too, use the `--private-service-endpoint` flag also.
  * [Create a cluster with the UI](/docs/containers?topic=containers-clusters#clusters_ui_standard) and select **Public endpoint only**. If you want to enable the private service endpoint too, select **Both private & public endpoints**.

3. If you create the cluster in an environment behind a firewall, [allow your authorized cluster users to run `kubectl` commands to access the master through the public service endpoint only or through the public and private service endpoints.](/docs/containers?topic=containers-firewall#firewall_kubectl)

  </br>

**Steps to enable after cluster creation**</br>
If you previously disabled the public endpoint, you can re-enable it.
1. Enable the public service endpoint.
   ```
   ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
2. Refresh the Kubernetes master API server to use the public service endpoint. You can follow the prompt in the CLI, or manually run the following command.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}

   </br>

**Steps to disable**</br>
To disable the public service endpoint, you must first enable the private service endpoint so that your worker nodes can communicate with the Kubernetes master.
1. Enable the private service endpoint.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
2. Refresh the Kubernetes master API server to use the private service endpoint by following the CLI prompt or by manually running the following command.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}
3. [Create a configmap](/docs/containers?topic=containers-update#worker-up-configmap) to control the maximum number of worker nodes that can be unavailable at a time in your cluster. When you update your worker nodes, the configmap helps prevent downtime for your apps as the apps are rescheduled orderly onto available worker nodes.

4. Update all the worker nodes in your cluster to pick up the private service endpoint configuration.

   <p class="important">By issuing the update command, the worker nodes are reloaded to pick up the service endpoint configuration. If no worker update is available, you must [reload the worker nodes manually](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). If you reload, be sure to cordon, drain, and manage the order to control the maximum number of worker nodes that are unavailable at a time.</p>
   ```
   ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
   ```
  {: pre}
5. Disable the public service endpoint.
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}

## Switching from the public service endpoint to the private service endpoint
{: #migrate-to-private-se}

In clusters that run Kubernetes version 1.11 or later, enable worker nodes to communicate with the master over the private network instead of the public network by enabling the private service endpoint.
{: shortdesc}

All clusters that are connected to a public and a private VLAN use the public service endpoint by default. Your worker nodes and your authorized cluster users can securely communicate with the Kubernetes master over the public network. To enable worker nodes to communicate with the Kubernetes master over the private network instead of the public network, you can enable the private service endpoint. Then, you can optionally disable the public service endpoint.
* If you enable the private service endpoint and keep the public service endpoint enabled too, workers always communicate with the master over the private network, but your users can communicate with the master over either the public or private network.
* If you enable the private service endpoint but disable the public service endpoint, workers and users must communicate with the master over the private network.

Note that you cannot disable the private service endpoint after you enable it.

1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in your IBM Cloud infrastructure (SoftLayer) account.
2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
3. Enable the private service endpoint.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
4. Refresh the Kubernetes master API server to use the private service endpoint by following the CLI prompt or by manually running the following command.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}
5. [Create a configmap](/docs/containers?topic=containers-update#worker-up-configmap) to control the maximum number of worker nodes that can be unavailable at a time in your cluster. When you update your worker nodes, the configmap helps prevent downtime for your apps as the apps are rescheduled orderly onto available worker nodes.

6.  Update all the worker nodes in your cluster to pick up the private service endpoint configuration.

    <p class="important">By issuing the update command, the worker nodes are reloaded to pick up the service endpoint configuration. If no worker update is available, you must [reload the worker nodes manually](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). If you reload, be sure to cordon, drain, and manage the order to control the maximum number of worker nodes that are unavailable at a time.</p>
    ```
    ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
    {: pre}

7. Optional: Disable the public service endpoint.
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## Optional: Isolating networking workloads to edge worker nodes
{: #both_vlans_private_edge}

Edge worker nodes can improve the security of your cluster by allowing fewer worker nodes to be accessed externally and by isolating the networking workload. To ensure that Ingress and load balancer pods are deployed to only specified worker nodes, [label worker nodes as edge nodes](/docs/containers?topic=containers-edge#edge_nodes). To also prevent other workloads from running on edge nodes, [taint the edge nodes](/docs/containers?topic=containers-edge#edge_workloads).
{: shortdesc}

If your cluster is connected to a public VLAN but you want to block traffic to public NodePorts on edge worker nodes, you can also use a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress). Blocking node ports ensures that the edge worker nodes are the only worker nodes that handle incoming traffic.

## Optional: Isolating your cluster on the private network
{: #isolate}

If you have a multizone cluster, multiple VLANs for a single zone cluster, or multiple subnets on the same VLAN, you must [enable VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) or [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) so that your worker nodes can communicate with each other on the private network. However, when VLAN spanning or VRF is enabled, any system that is connected to any of the private VLANs in the same IBM Cloud account can access your workers. You can isolate your multizone cluster from other systems on the private network by using [Calico network policies](/docs/containers?topic=containers-network_policies#isolate_workers). These policies also allow ingress and egress for the private IP ranges and ports that you opened in your private firewall.
{: shortdesc}
