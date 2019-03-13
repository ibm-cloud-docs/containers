---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-13"

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


# Planning in-cluster and private networking
{: #cs_network_cluster}

Plan a networking setup for your {{site.data.keyword.containerlong}} cluster.
{: shortdesc}

## Understanding in-cluster networking
{: #in-cluster}

All pods that are deployed to a worker node are assigned a private IP address in the 172.30.0.0/16 range and are routed between worker nodes only. To avoid conflicts, don't use this IP range on any nodes that communicate with your worker nodes. Worker nodes and pods can securely communicate on the private network by using private IP addresses. However, when a pod crashes or a worker node needs to be re-created, a new private IP address is assigned.
{: shortdesc}

By default, it's difficult to track changing private IP addresses for apps that must be highly available. Instead, you can use the built-in Kubernetes service discovery features to expose apps as cluster IP services on the private network. A Kubernetes service groups a set of pods and provides a network connection to these pods. This connection provides connectivity to other services in the cluster without exposing the actual private IP address of each pod. Services are assigned an in-cluster IP address that is accessible inside the cluster only.
* Older clusters: In clusters that were created before February 2018 in the dal13 zone or before October 2017 in any other zone, the services are assigned an IP from one of 254 IPs in the 10.10.10.0/24 range. If you hit the limit of 254 services and need more services, you must create a new cluster.
* Newer clusters: In clusters that were created after February 2018 in the dal13 zone or after October 2017 in any other zone, the services are assigned an IP from one of the 65,000 IPs in the 172.21.0.0/16 range.

To avoid conflicts, don't use this IP range on any nodes that communicate with your worker nodes. A DNS lookup entry is also created for the service and stored in the `kube-dns` component of the cluster. The DNS entry contains the name of the service, the namespace where the service was created, and the link to the assigned in-cluster IP address.

To access a pod behind a cluster service, apps can either use the in-cluster IP address of the service or send a request by using the name of the service. When you use the name of the service, the name is looked up in the `kube-dns` component and routed to the in-cluster IP address of the service. When a request reaches the service, the service forwards requests to the pods equally, independent of pods' in-cluster IP addresses and the worker node that they are deployed to.

<br />


## Understanding VLAN connections and network interfaces
{: #interfaces}

{{site.data.keyword.containerlong_notm}} provides IBM Cloud infrastructure (SoftLayer) VLANs that ensure quality network performance and network isolation for worker nodes. A VLAN configures a group of worker nodes and pods as if they were attached to the same physical wire. VLANs are dedicated to your {{site.data.keyword.Bluemix_notm}} account and not shared across IBM customers.
{: shortdesc}

By default, all clusters are connected to a private VLAN. The private VLAN determines the private IP address that is assigned to each worker node. Your workers have a private network interface and are accessible over the private network. When you create a cluster that is also connected to a public VLAN, your cluster has a public network interface too. The public VLAN allows the worker nodes to automatically and securely connect to the master. For more information about the default VLANs for your cluster, see [Default VLANs, subnets, and IPs for clusters](/docs/containers?topic=containers-subnets#default_vlans_subnets).

Cluster networking setups can be defined by the cluster's network interfaces:

* **Default cluster networking**: A cluster with both a private and public network interface
* **Customized default cluster networking**: A cluster with both a private and public network interface and Calico network policies to block incoming public traffic
* **Private-only cluster networking**: A cluster with only a private network interface

Click one of the following setups to plan networking for your cluster:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/network_imagemap.png" width="575" alt="Click a card to plan your cluster networking setup." style="width:575px;" />
<map name="home_map" id="home_map">
<area href="#both_vlans" alt="Planning default cluster networking" title="Planning default cluster networking" shape="rect" coords="-7, -8, 149, 211" />
<area href="#both_vlans_private" alt="Planning customized default cluster networking" title="Planning customized default cluster networking" shape="rect" coords="196, -1, 362, 210" />
<area href="#plan_setup_private_vlan" alt="Planning private-only cluster networking" title="Planning private-only cluster networking" shape="rect" coords="409, -10, 572, 218" />
</map>

<br />


## Planning default cluster networking
{: #both_vlans}

By default, {{site.data.keyword.containerlong_notm}} sets up your cluster with access to a public VLAN and a private VLAN.
{:shortdesc}



**What does my cluster get with this setup?**
* A public IP address for each worker node, which gives worker nodes a public network interface
* A private IP address for each worker node, which gives worker nodes a private network interface
* An automatic, secure OpenVPN connection between all worker nodes and the master

**Why might I use this setup?**

* You have an app that must be accessible to the public internet in a single-zone cluster.
* You have an app that must be accessible to the public internet in a multizone cluster. Because you must enable [VLAN spanning](/docs/containers?topic=containers-subnets#subnet-routing) to create a multizone cluster, the cluster can communicate with other systems that are connected to any private VLAN in the same IBM Cloud account. To isolate your multizone cluster on the private network, you can use [Calico network policies](/docs/containers?topic=containers-network_policies#isolate_workers).

**What are my options for managing public and private access to my cluster?**
</br>The following sections describe the capabilities across {{site.data.keyword.containerlong_notm}} that you can use to set up networking for clusters that are connected to a public and a private VLAN.

### Expose your apps with networking services
{: #both_vlans_services}

The public network interface for worker nodes is protected by [predefined Calico network policy settings](/docs/containers?topic=containers-network_policies#default_policy) that are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked except for a few ports. These ports are opened so that IBM can monitor network traffic and automatically install security updates for the Kubernetes master.
{: shortdesc}

If you want to expose your apps to the public or to a private network, you can create public or private NodePort, LoadBalancer, or Ingress services. For more information about each service, see [Choosing a NodePort, LoadBalancer, or Ingress service](/docs/containers?topic=containers-cs_network_planning#external).

### Optional: Isolate networking workloads to edge worker nodes
{: #both_vlans_edge}

Edge worker nodes can improve the security of your cluster by allowing fewer worker nodes to be accessed externally and by isolating the networking workload. To ensure that Ingress and load balancer pods are deployed to only specified worker nodes, [label worker nodes as edge nodes](/docs/containers?topic=containers-edge#edge_nodes). To also prevent other workloads from running on edge nodes, [taint the edge nodes](/docs/containers?topic=containers-edge#edge_workloads).


### Optional: Connect to an on-premises network or IBM Cloud Private by using strongSwan VPN
{: #both_vlans_vpn}

To securely connect your worker nodes and apps to an on-premises network, you can set up a [strongSwan IPSec VPN service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/about.html). The strongSwan IPSec VPN service provides a secure end-to-end communication channel over the internet that is based on the industry-standard Internet Protocol Security (IPSec) protocol suite.
* To set up a secure connection between your cluster and an on-premises network, [configure and deploy the strongSwan IPSec VPN service](/docs/containers?topic=containers-vpn#vpn-setup) directly in a pod in your cluster.
* To set up a secure connection between your cluster and an IBM Cloud Private instance, see [Connecting your public and private cloud with the strongSwan VPN](/docs/containers?topic=containers-hybrid_iks_icp#hybrid_vpn).


<br />


## Planning customized default cluster networking
{: #both_vlans_private}

By default, {{site.data.keyword.containerlong_notm}} sets up your cluster with access to a public VLAN and a private VLAN. However, you can customize the default networking setup by using network policies to block public access.
{:shortdesc}



**What does my cluster get with this setup?**
* A public IP address for each worker node, which gives worker nodes a public network interface
* A private IP address for each worker node, which gives worker nodes a private network interface
* An automatic, secure OpenVPN connection between all worker nodes and the master

**Why might I use this setup?**

* You have an app in a single-zone cluster. You want to expose the app only to pods within the cluster or in other clusters that are connected to the same private VLAN.
* You have an app in a multizone cluster. You want to expose the app only to pods within the cluster or in other clusters that are connected to the same private VLANs as your cluster. However, because [VLAN spanning](/docs/containers?topic=containers-subnets#subnet-routing) must be enabled for multizone clusters, other systems that are connected to any private VLAN in the same IBM Cloud account can access the cluster. You want to isolate your multizone cluster from other systems.

**What are my options for managing public and private access to my cluster?**</br>The following sections describe the capabilities across {{site.data.keyword.containerlong_notm}} that you can use to set up private-only networking and lock down public networking for clusters that are connected to a public and a private VLAN.

### Expose your apps with private networking services and secure your cluster from public access with Calico network policies
{: #both_vlans_private_services}

The public network interface for worker nodes is protected by [predefined Calico network policy settings](/docs/containers?topic=containers-network_policies#default_policy) that are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked except for a few ports. These ports are opened so that IBM can monitor network traffic and automatically install security updates for the Kubernetes master.
{: shortdesc}

If you want to expose your apps over a private network only, you can create private NodePort, a LoadBalancer, or Ingress services. For more information about planning private external networking, see [Planning private external networking for a public and private VLAN setup](/docs/containers?topic=containers-cs_network_planning#private_both_vlans).

However, the default Calico network policies also allow inbound public network traffic from the internet to these services. You can create Calico policies to instead block all public traffic to the services. For example, a NodePort service opens a port on a worker node over both the private and public IP address of the worker node. A load balancer service with a portable private IP address opens a public NodePort on every worker node. You must create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block public NodePorts.

As an example, say you created a private load balancer service. You also created a Calico preDNAT policy to block public traffic from reaching the public NodePorts opened by the load balancer. This private load balancer can be accessed by:
* [Any pod in that same cluster](#in-cluster)
* Any pod in any cluster that is connected to the same private VLAN
* If you have [VLAN spanning enabled](/docs/containers?topic=containers-subnets#subnet-routing), any system that is connected to any of the private VLANs in the same IBM Cloud account
* If you're not in the IBM Cloud account but still behind the company firewall, any system through a VPN connection to the subnet that the load balancer IP is on
* If you're in a different IBM Cloud account, any system through a VPN connection to the subnet that the load balancer IP is on

### Isolate your cluster on the private network
{: #isolate}

If you have a multizone cluster, multiple VLANs for a single zone cluster, or multiple subnets on the same VLAN, you must [enable VLAN spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) so that your worker nodes can communicate with each other on the private network. However, when VLAN spanning is enabled, any system that is connected to any of the private VLANs in the same IBM Cloud account can access your workers. You can isolate your multizone cluster from other systems on the private network by using [Calico network policies](/docs/containers?topic=containers-network_policies#isolate_workers). These policies also allow ingress and egress for the private IP ranges and ports that you opened in your private firewall.
{: shortdesc}

### Optional: Isolate networking workloads to edge worker nodes
{: #both_vlans_private_edge}

Edge worker nodes can improve the security of your cluster by allowing fewer worker nodes to be accessed externally and by isolating the networking workload. To ensure that Ingress and load balancer pods are deployed to only specified worker nodes, [label worker nodes as edge nodes](/docs/containers?topic=containers-edge#edge_nodes). To also prevent other workloads from running on edge nodes, [taint the edge nodes](/docs/containers?topic=containers-edge#edge_workloads).


Then, use a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to public NodePorts on clusters that are running edge worker nodes. Blocking node ports ensures that the edge worker nodes are the only worker nodes that handle incoming traffic.

### Optional: Connect to an on-premises network or IBM Cloud Private by using strongSwan VPN
{: #both_vlans_private_vpn}

To securely connect your worker nodes and apps to an on-premises network, you can set up a [strongSwan IPSec VPN service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/about.html). The strongSwan IPSec VPN service provides a secure end-to-end communication channel over the internet that is based on the industry-standard Internet Protocol Security (IPSec) protocol suite.
* To set up a secure connection between your cluster and an on-premises network, [configure and deploy the strongSwan IPSec VPN service](/docs/containers?topic=containers-vpn#vpn-setup) directly in a pod in your cluster.
* To set up a secure connection between your cluster and an IBM Cloud Private instance, see [Connecting your public and private cloud with the strongSwan VPN](/docs/containers?topic=containers-hybrid_iks_icp#hybrid_vpn).


<br />


## Planning private-only cluster networking
{: #plan_setup_private_vlan}

You can choose to [create a private-VLAN only cluster](/docs/containers?topic=containers-clusters#clusters_cli) by including the `--private-only` flag in the CLI. When your worker nodes are connected to a private VLAN only, the worker nodes can't automatically connect to the master. You must use a gateway appliance to connect the worker nodes to the master. You can also use the gateway appliance as a firewall to secure your cluster from unwanted access.
{:shortdesc}



**What does my cluster get with this setup?**
* A private IP address for each worker node, which gives worker nodes a private network interface

**What does my cluster not get with this setup?**
* A public IP address for each worker node, which gives worker nodes a public network interface. The cluster is never available to the public.
* An automatic connection between all worker nodes and the master. You must provide this connection by [configuring a gateway appliance](#private_vlan_gateway).

**Why might I use this setup?**
</br>You have specific security requirements or need to create custom network policies and routing rules to provide dedicated network security. Note that using a gateway appliance incurs separate costs. For details, see the [documentation](/docs/infrastructure/fortigate-10g?topic=fortigate-10g-exploring-firewalls).

**What are my options for managing public and private access to my cluster?**
</br>The following sections describe the capabilities across {{site.data.keyword.containerlong_notm}} that you can use to set up networking for clusters that are connected to a private VLAN only.

### Configure a gateway appliance
{: #private_vlan_gateway}

If worker nodes are set up with a private VLAN only, you must configure an alternative solution for network connectivity between your worker nodes and the master. You can set up a firewall with custom network policies to provide dedicated network security for your standard cluster and to detect and remediate network intrusion. For example, you might choose to set up a [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) or a [Fortigate Security Appliance](/docs/services/vmwaresolutions/services?topic=vmware-solutions-fsa_considerations) to act as your firewall and block unwanted traffic. When you set up a firewall, you must also [open up the required ports and IP addresses](/docs/containers?topic=containers-firewall#firewall_outbound) for each region so that the master and the worker nodes can communicate.
{: shortdesc}

If you have an existing router appliance and then add a cluster, the new portable subnets that are ordered for the cluster aren't configured on the router appliance. In order to use networking services, you must enable routing between the subnets on the same VLAN by [enabling VLAN spanning](/docs/containers?topic=containers-subnets#vra-routing).
{: important}

### Expose your apps with private networking services
{: #private_vlan_services}

To make your app accessible from a private network only, you can use private NodePort, LoadBalancer, or Ingress services. Because your worker nodes aren't connected to a public VLAN, no public traffic is routed to these services. You must also [open up the required ports and IP addresses](/docs/containers?topic=containers-firewall#firewall_inbound) to permit inbound traffic to these services.
{: shortdesc}

For more information about each service, see [Choosing a NodePort, LoadBalancer, or Ingress service](/docs/containers?topic=containers-cs_network_planning#external).

### Optional: Connect to an on-premises database by using the gateway appliance
{: #private_vlan_vpn}

To securely connect your worker nodes and apps to an on-premises network, you must set up a VPN gateway. You can use the VRA or FSA that you previously set up to also configure an IPSec VPN endpoint. To configure a VRA, see [Setting up VPN connectivity with a VRA](/docs/containers?topic=containers-vpn#vyatta).
{: shortdesc}








<br />


## Setting up the private service endpoint
{: #set-up-private-se}

Enable or disable the private service endpoint for your cluster.
{: shortdesc}

The private service endpoint makes your Kubernetes master privately accessible. Your worker nodes and your authorized cluster users can communicate with the Kubernetes master over the private network. To determine whether you can enable the private service endpoint, see [Planning master-to-worker communication](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master). Note that you cannot disable the private service endpoint after you enable it.

**Steps to enable during cluster creation**</br>
1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) in your IBM Cloud infrastructure (SoftLayer) account.
2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Create a cluster:
  * [Create a cluster with the CLI](/docs/containers?topic=containers-clusters#clusters_cli) and use the `--private-service-endpoint` flag. If you want to enable the public service endpoint too, use the `--public-service-endpoint` flag also.
  * [Create a cluster with the UI](/docs/containers?topic=containers-clusters#clusters_ui_standard) and select **Private endpoint only**. If you want to enable the public service endpoint too, select **Public and private endpoints**.
4. If you create the cluster in an environment behind a firewall:
  * [Allow your authorized cluster users to run `kubectl` commands to access the master through the private service endpoint only or through the public and private service endpoints.](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * [Allow outbound network traffic to the public and private IPs](/docs/containers?topic=containers-firewall#firewall_outbound) for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.

  </br>

**Steps to enable after cluster creation**</br>
1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) in your IBM Cloud infrastructure (SoftLayer) account.
2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Enable the private service endpoint.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. Refresh the Kubernetes master API server to use the private service endpoint.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
5. [Create a configmap](/docs/containers?topic=containers-update#worker-up-configmap) to control the maximum number of worker nodes that can be unavailable at a time in your cluster. When you reload your worker nodes, the configmap helps prevent downtime for your apps as the apps are rescheduled orderly onto available worker nodes.
6. Reload all the worker nodes in your cluster to pick up the private service endpoint configuration.
  ```
  ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}

7. If the cluster is in an environment behind a firewall:
  * [Allow your authorized cluster users to run `kubectl` commands to access the master through the private service endpoint.](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * [Allow outbound network traffic to the private IPs](/docs/containers?topic=containers-firewall#firewall_outbound) for the {{site.data.keyword.Bluemix_notm}} services that you plan to use.

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
  * [Create a cluster with the UI](/docs/containers?topic=containers-clusters#clusters_ui_standard) and select **Public endpoint only**. If you want to enable the private service endpoint too, select **Public and private endpoints**.

3. If you create the cluster in an environment behind a firewall, [allow your authorized cluster users to run `kubectl` commands to access the master through the public service endpoint only or through the public and private service endpoints.](/docs/containers?topic=containers-firewall#firewall_kubectl)

  </br>

**Steps to enable after cluster creation**</br>
If you previously disabled the public endpoint, you can re-enable it.
1.  Enable the public service endpoint.
  ```
  ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
2.  Refresh the Kubernetes master API server to use the public service endpoint.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

  </br>

**Steps to disable**</br>
To disable the public service endpoint, you must first enable the private service endpoint so that your worker nodes can communicate with the Kubernetes master.
1.  Enable the private service endpoint.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
2.  Refresh the Kubernetes master API server to use the private service endpoint.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
3.  [Create a configmap](/docs/containers?topic=containers-update#worker-up-configmap) to control the maximum number of worker nodes that can be unavailable at a time in your cluster. When you reload your worker nodes, the configmap helps prevent downtime for your apps as the apps are rescheduled orderly onto available worker nodes.
4.  Reload all the worker nodes in your cluster to pick up the private service endpoint configuration.
  ```
  ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}
5.  Disable the public service endpoint.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}

## Switching from the public service endpoint to the private service endpoint
{: #migrate-to-private-se}

Enable worker nodes to communicate with the master over the private network instead of the public network by enabling the private service endpoint.
{: shortdesc}

All clusters that are connected to a public and a private VLAN use the public service endpoint by default. Your worker nodes and your authorized cluster users can securely communicate with the Kubernetes master over the public network. To enable worker nodes to communicate with the Kubernetes master over the private network instead of the public network, you can enable the private service endpoint. Afterwards, you can optionally disable the public service endpoint.
* If you enable the private service endpoint and keep the public service endpoint enabled too, workers always communicate with the master over the private network, but your users can communicate with the master over either the public or private network.
* If you enable the private service endpoint but disable the public service endpoint, workers and users must communicate with the master over the private network.

Note that you cannot disable the private service endpoint after you enable it.

1. Enable [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) in your IBM Cloud infrastructure (SoftLayer) account.
2. [Enable your {{site.data.keyword.Bluemix_notm}} account to use service endpoints](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Enable the private service endpoint.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. Refresh the Kubernetes master API server to use the private service endpoint.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
5. [Create a configmap](/docs/containers?topic=containers-update#worker-up-configmap) to control the maximum number of worker nodes that can be unavailable at a time in your cluster. When you reload your worker nodes, the configmap helps prevent downtime for your apps as the apps are rescheduled orderly onto available worker nodes.
6. Reload all the worker nodes in your cluster to pick up the private service endpoint configuration.
  ```
  ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}
7. Optional: Disable the public service endpoint.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
</staging>
