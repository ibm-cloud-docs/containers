---

copyright:
  years: 2014, 2018
lastupdated: "2018-05-30"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Planning cluster networking
{: #planning}

With {{site.data.keyword.containerlong}}, you can manage both external networking by making apps publically or privately accessible and internal networking within your cluster.
{: shortdesc}

## Planning external networking with NodePort, LoadBalancer, or Ingress services
{: #external}

To make your apps externally accessible from the public internet or a private network, {{site.data.keyword.containershort_notm}} supports three networking services.
{:shortdesc}

<dl>
<dt><a href="cs_nodeport.html" target="_blank">NodePort service</a> (free and standard clusters)</dt>
<dd>
 <ul>
  <li>Expose a port on every worker node and use the public or private IP address of any worker node to access your service in the cluster.</li>
  <li>Iptables is a Linux kernel feature that load balances requests across the app's pods, provides high-performance networking routing, and provides network access control.</li>
  <li>The public and private IP addresses of the worker node are not permanent. When a worker node is removed or re-created, a new public and a new private IP address are assigned to the worker node.</li>
  <li>The NodePort service is great for testing public or private access. It can also be used if you need public or private access for only a short amount of time.</li>
 </ul>
</dd>
<dt><a href="cs_loadbalancer.html" target="_blank">LoadBalancer service</a> (standard clusters only)</dt>
<dd>
 <ul>
  <li>Every standard cluster is provisioned with four portable public and four portable private IP addresses that you can use to create an external TCP/UDP load balancer for your app.</li>
  <li>Iptables is a Linux kernel feature that load balances requests across the app's pods, provides high-performance networking routing, and provides network access control.</li>
  <li>The portable public and private IP addresses that are assigned to the load balancer are permanent and do not change when a worker node is re-created in the cluster.</li>
  <li>You can customize your load balancer by exposing any port that your app requires.</li></ul>
</dd>
<dt><a href="cs_ingress.html" target="_blank">Ingress</a> (standard clusters only)</dt>
<dd>
 <ul>
  <li>Expose multiple apps in a cluster by creating one external HTTP or HTTPS, TCP, or UDP load balancer. The load balancer uses a secured and unique public or private entry point to route incoming requests to your apps.</li>
  <li>You can use one route to expose multiple apps in your cluster as services.</li>
  <li>Ingress consists of two components:
   <ul>
    <li>The Ingress resource defines the rules for how to route and load balance incoming requests for an app.</li>
    <li>The application load balancer (ALB) listens for incoming HTTP or HTTPS, TCP, or UDP service requests. It forwards requests across the apps' pods based on the rules that you defined in the Ingress resource.</li>
    <li>The multizone load balancer (MZLB) handles all incoming requests to your apps and load balances the requests among the ALBs in the various zones.</li>
   </ul></li>
   
  <li>Use Ingress to implement your own ALB with custom routing rules and need SSL termination for your apps.</li>
 </ul>
</dd></dl>

To find out more about public networking, see [Planning public external networking](#public_access). To find out more about private networking, see [Planning private external networking to apps when worker nodes are connected to a public and a private VLAN](#private_both_vlans) or [Planning private external networking to apps when worker nodes are connected to only a private VLAN](#private_vlan).

To choose the best networking service for your app, you can follow this decision tree and click on one of the options to get started.

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="This image walks you through choosing the best networking option for your application. If this image is not displaying, the information can still be found in the documentation." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Nodeport service" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="LoadBalancer service" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Ingress service" shape="circle" coords="445, 420, 45"/>
</map>

## Planning public external networking
{: #public_access}

When you create a Kubernetes cluster in {{site.data.keyword.containershort_notm}}, you can connect the cluster to a public VLAN. The public VLAN determines the public IP address that is assigned to each worker node, which provides each worker node with a public network interface.
{:shortdesc}

The public network interface for the worker nodes in both free and standard clusters is protected by Calico network policies. These policies block most inbound traffic by default. However, inbound traffic that is necessary for Kubernetes to function is allowed, as are connections to NodePort, LoadBalancer, and Ingress services. For more information about these policies, including how to modify them, see [Network policies](cs_network_policy.html#network_policies).

|Cluster type|Manager of the public VLAN for the cluster|
|------------|------------------------------------------|
|Free clusters|{{site.data.keyword.IBM_notm}}|
|Standard clusters|You in your IBM Cloud infrastructure (SoftLayer) account|
{: caption="Managers of the public VLANs by cluster type" caption-side="top"}

To make an app publicly available to the internet, you must update your configuration file before you deploy the app into a cluster. Then, to make your app accessible from the internet, you can create a NodePort, LoadBalancer, or Ingress service. The following diagram shows how Kubernetes forwards public network traffic in {{site.data.keyword.containershort_notm}}.

![{{site.data.keyword.containershort_notm}} Kubernetes architecture](images/networking.png)

*Kubernetes data plane in {{site.data.keyword.containershort_notm}}*

For more information about securely connecting apps that run in a Kubernetes cluster to an on-premises network or to apps that are external to your cluster, see [Setting up VPN connectivity](cs_vpn.html).

<br />


## Planning private external networking when worker nodes are connected to a public and a private VLAN
{: #private_both_vlans}

When you create a Kubernetes cluster in {{site.data.keyword.containershort_notm}}, you must connect your cluster to a private VLAN. The private VLAN determines the private IP address that is assigned to each worker node, which provides each worker node with a private network interface.
{:shortdesc}

When you want to keep your apps connected to a private network only, you can use the private network interface for the worker nodes in standard clusters. However, when your worker nodes are connected to both a public and a private VLAN, you must also use Calico network policies to secure your cluster from unwanted public access.

### Expose your apps with private networking services and secure your cluster with Calico network policies
{: #private_both_vlans_calico}

The public network interface for worker nodes is protected by [predefined Calico network policy settings](cs_network_policy.html#default_policy) that are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked with the exception of a few ports that are opened so that network traffic can be monitored by IBM and for IBM to automatically install security updates for the Kubernetes master. Access to the worker node's kubelet is secured by an OpenVPN tunnel. For more information, see the [{{site.data.keyword.containershort_notm}} architecture](cs_tech.html).

If you expose your apps with a NodePort service, a LoadBalancer service, or an Ingress application load balancer, the default Calico policies also allow inbound network traffic from the internet to these services. To make your app accessible from a private network only, you can choose to use only private NodePort, LoadBalancer, or Ingress services and block all public traffic to the services.

**NodePort**
* [Create a NodePort service](cs_nodeport.html). In addition to the public IP address, a NodePort service is available over the private IP address of a worker node.
* A NodePort service opens a port on a worker node over both the private and public IP address of the worker node, so you must use a [Calico preDNAT network policy](cs_network_policy.html#block_ingress) to block the public NodePorts.

**LoadBalancer**
* [Create a private LoadBalancer service](cs_loadbalancer.html).
* A load balancer service with a portable private IP address still has a public node port open on every worker node, so you must use a [Calico preDNAT network policy](cs_network_policy.html#block_ingress) to block public node ports on it.

**Ingress**
* When you create a cluster, one public and one private Ingress application load balancer (ALB) are created automatically. Because the public ALB is enabled and the private ALB is disabled by default, you must [disable the public ALB](cs_cli_reference.html#cs_alb_configure) and [enable the private ALB](cs_ingress.html#private_ingress).
* Then, [create a private Ingress service](cs_ingress.html#ingress_expose_private).

### Isolate networking workloads to edge worker nodes
{: #private_both_vlans_edge}

Edge worker nodes can improve the security of your cluster by allowing fewer worker nodes to be accessed externally and by isolating the networking workload. To ensure that Ingress and load balancer pods are deployed to only specified worker nodes, [label worker nodes as edge nodes](cs_edge.html#edge_nodes). To also prevent other workloads from running on edge nodes, [taint the edge nodes](cs_edge.html#edge_workloads).

Then, use a [Calico preDNAT network policy](cs_network_policy.html#block_ingress) to block traffic to public node ports on clusters that are running edge worker nodes. Blocking node ports ensures that the edge worker nodes are the only worker nodes that handle incoming traffic.

### Connect to an on-premises database by using strongSwan VPN
{: #private_both_vlans_vpn}

To securely connect your worker nodes and apps to an on-premises network, you can set up a [strongSwan IPSec VPN service ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/). The strongSwan IPSec VPN service provides a secure end-to-end communication channel over the internet that is based on the industry-standard Internet Protocol Security (IPsec) protocol suite. To set up a secure connection between your cluster and an on-premises network, [configure and deploy the strongSwan IPSec VPN service](cs_vpn.html#vpn-setup) directly in a pod in your cluster.

<br />


## Planning private external networking to apps when worker nodes are connected to only a private VLAN
{: #private_vlan}

When you create a Kubernetes cluster in {{site.data.keyword.containershort_notm}}, you must connect your cluster to a private VLAN. The private VLAN determines the private IP address that is assigned to each worker node, which provides each worker node with a private network interface.
{:shortdesc}

When your worker nodes are connected to a private VLAN only, you can use the private network interface for the worker nodes to keep apps connect to the private network only. You can then use a gateway appliance to secure your cluster from unwanted public access.

### Configure a gateway appliance
{: #private_vlan_gateway}

If worker nodes are set up with a private VLAN only, you must configure an alternative solution for network connectivity. You can set up a firewall with custom network policies to provide dedicated network security for your standard cluster and to detect and remediate network intrusion. For example, you might choose to set up a [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) or a  to act as your firewall and block unwanted traffic. When you set up a firewall, [you must also open up the required ports and IP addresses](cs_firewall.html#firewall) for each region so that the master and the worker nodes can communicate. For more information, see [VLAN connection for worker nodes](cs_clusters.html#worker_vlan_connection).

### Expose your apps with private networking services
{: #private_vlan_services}

To make your app accessible from a private network only, you can use private NodePort, LoadBalancer, or Ingress services. Because your worker nodes are not connected to a public VLAN, no public traffic is routed to these services.

* **NodePort**: [Create a private NodePort service](cs_nodeport.html). The service is available over the private IP address of a worker node.

* **LoadBalancer** [Create a private LoadBalancer service](cs_loadbalancer.html). If your cluster is available on a private VLAN only, one of the four available portable private IP addresses is used.

* **Ingress**: When you create a cluster, a private Ingress application load balancer (ALB) is created automatically but is not enabled by default. You must [enable the private ALB](cs_ingress.html#private_ingress). Then, [create a private Ingress service](cs_ingress.html#ingress_expose_private).

### Connect to an on-premises database by using a VRA
{: #private_vlan_vpn}

To securely connect your worker nodes and apps to an on-premises network, you must set up a VPN gateway. You can use the [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) or [Fortigate Security Appliance (FSA)](/docs/infrastructure/fortigate-10g/about.html) that you set up as a firewall to also configure an IPSec VPN endpoint. To configure a VRA, see [Setting up VPN connectivity with VRA](cs_vpn.html#vyatta).

<br />


## Planning in-cluster networking
{: #in-cluster}

All pods that are deployed to a worker node are also assigned a private IP address. Pods are assigned an IP in the 172.30.0.0/16 private address range and are routed between worker nodes only. To avoid conflicts, do not use this IP range on any nodes that communicate with your worker nodes. Worker nodes and pods can securely communicate on the private network by using the private IP addresses. However, when a pod crashes or a worker node needs to be re-created, a new private IP address is assigned.

By default, it is difficult to track changing private IP addresses for apps that must be highly available. To avoid that, you can use the built-in Kubernetes service discovery features and expose apps as cluster IP services on the private network. A Kubernetes service groups a set of pods and provides a network connection to these pods for other services in the cluster without exposing the actual private IP address of each pod. When you create a cluster IP service, a private IP address is assigned to that service from the 10.10.10.0/24 private address range. As with the pod private address range, do not use this IP range on any nodes that communicate with your worker nodes. This IP address is accessible inside the cluster only. You cannot access this IP address from the internet. At the same time, a DNS lookup entry is created for the service and stored in the kube-dns component of the cluster. The DNS entry contains the name of the service, the namespace where the service was created, and the link to the assigned private cluster IP address.

To access a pod behind a cluster IP service, the app can either use the private cluster IP address of the service or send a request by using the name of the service. When you use the name of the service, the name is looked up in the kube-dns component and routed to the private cluster IP address of the service. When a request reaches the service, the service ensures that all requests are equally forwarded to the pods, independent of their private IP addresses and the worker node they are deployed to.
