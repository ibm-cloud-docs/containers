---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-07"

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


# Planning to expose your apps with external networking
{: #cs_network_planning}

With {{site.data.keyword.containerlong}}, you can manage external networking by making apps publicly or privately accessible.
{: shortdesc}

This page helps you plan external networking for your apps. For information about setting up your cluster for networking, including information about VLANs, subnets, firewalls, and VPNs, see [Planning a cluster network setup](/docs/containers/cs_network_cluster.html).
{: tip}

## Choosing a NodePort, LoadBalancer, or Ingress service
{: #external}

To make your apps externally accessible from the public internet or a private network, {{site.data.keyword.containerlong_notm}} supports three networking services.
{:shortdesc}

**[NodePort service](/docs/containers/cs_nodeport.html)** (free and standard clusters)
* Expose a port on every worker node and use the public or private IP address of any worker node to access your service in the cluster.
* Iptables is a Linux kernel feature that load balances requests across the app's pods, provides high-performance networking routing, and provides network access control.
* The public and private IP addresses of the worker node are not permanent. When a worker node is removed or re-created, a new public and a new private IP address are assigned to the worker node.
* The NodePort service is great for testing public or private access. It can also be used if you need public or private access for only a short amount of time.

**[LoadBalancer service](/docs/containers/cs_loadbalancer.html)** (standard clusters only)
* Every standard cluster is provisioned with four portable public and four portable private IP addresses that you can use to create an external TCP/UDP load balancer for your app.
* Iptables is a Linux kernel feature that load balances requests across the app's pods, provides high-performance networking routing, and provides network access control.
* The portable public and private IP addresses that are assigned to the load balancer are permanent and do not change when a worker node is re-created in the cluster.
* You can customize your load balancer by exposing any port that your app requires.

**[Ingress](/docs/containers/cs_ingress.html)** (standard clusters only)
* Expose multiple apps in a cluster by creating one external HTTP or HTTPS, TCP, or UDP application load balancer (ALB). The ALB uses a secured and unique public or private entry point to route incoming requests to your apps.
* You can use one route to expose multiple apps in your cluster as services.
* Ingress consists of three components:
  * The Ingress resource defines the rules for how to route and load balance incoming requests for an app.
  * The ALB listens for incoming HTTP or HTTPS, TCP, or UDP service requests. It forwards requests across the apps' pods based on the rules that you defined in the Ingress resource.
  * The multizone load balancer (MZLB) handles all incoming requests to your apps and load balances the requests among the ALBs in the various zones.
* Use Ingress to implement your own ALB with custom routing rules and need SSL termination for your apps.

To choose the best networking service for your app, you can follow this decision tree and click one of the options to get started.

<img usemap="#networking_map" border="0" class="image" src="images/cs_network_planning_dt-01.png" width="500px" alt="This image walks you through choosing the best networking option for your application. If this image is not displaying, the information can still be found in the documentation." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Nodeport service" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="LoadBalancer service" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Ingress service" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## Planning public external networking
{: #public_access}

When you create a Kubernetes cluster in {{site.data.keyword.containerlong_notm}}, you can connect the cluster to a public VLAN. The public VLAN determines the public IP address that is assigned to each worker node, which provides each worker node with a public network interface.
{:shortdesc}

To make an app publicly available to the internet, you can create a NodePort, LoadBalancer, or Ingress service. To compare each service, see [Choosing a NodePort, LoadBalancer, or Ingress service](#external).

The following diagram shows how Kubernetes forwards public network traffic in {{site.data.keyword.containerlong_notm}}.

![{{site.data.keyword.containerlong_notm}} Kubernetes architecture](images/cs_network_planning_ov-01.png)

*Kubernetes data plane in {{site.data.keyword.containerlong_notm}}*

The public network interface for the worker nodes in both free and standard clusters is protected by Calico network policies. These policies block most inbound traffic by default. However, inbound traffic that is necessary for Kubernetes to function is allowed, as are connections to NodePort, LoadBalancer, and Ingress services. For more information about these policies, including how to modify them, see [Network policies](/docs/containers/cs_network_policy.html#network_policies).

<br />


## Planning private external networking for a public and private VLAN setup
{: #private_both_vlans}

When your worker nodes are connected to both a public and a private VLAN, you can make your app accessible from a private network only by creating private NodePort, LoadBalancer, or Ingress services. Then, you can create Calico policies to block public traffic to the services.
{: shortdesc}

**NodePort**
* [Create a NodePort service](/docs/containers/cs_nodeport.html). In addition to the public IP address, a NodePort service is available over the private IP address of a worker node.
* A NodePort service opens a port on a worker node over both the private and public IP address of the worker node. You must use a [Calico preDNAT network policy](/docs/containers/cs_network_policy.html#block_ingress) to block the public NodePorts.

**LoadBalancer**
* [Create a private LoadBalancer service](/docs/containers/cs_loadbalancer.html).
* A load balancer service with a portable private IP address still has a public node port open on every worker node. You must use a [Calico preDNAT network policy](/docs/containers/cs_network_policy.html#block_ingress) to block public node ports on it.

**Ingress**
* When you create a cluster, one public and one private Ingress application load balancer (ALB) are created automatically. Because the public ALB is enabled and the private ALB is disabled by default, you must [disable the public ALB](/docs/containers/cs_cli_reference.html#cs_alb_configure) and [enable the private ALB](/docs/containers/cs_ingress.html#private_ingress).
* Then, [create a private Ingress service](/docs/containers/cs_ingress.html#ingress_expose_private).

As an example, say that you created a private load balancer service. You also created a Calico preDNAT policy to block public traffic from reaching the public NodePorts opened by the load balancer. This private load balancer can be accessed by:
* Any pod in that same cluster
* Any pod in any cluster in the same {{site.data.keyword.Bluemix_notm}} account
* If you have [VLAN spanning enabled](/docs/containers/cs_subnets.html#subnet-routing), any system that is connected to any of the private VLANs in the same {{site.data.keyword.Bluemix_notm}} account
* If you're not in the {{site.data.keyword.Bluemix_notm}} account but still behind the company firewall, any system through a VPN connection to the subnet that the load balancer IP is on
* If you're in a different {{site.data.keyword.Bluemix_notm}} account, any system through a VPN connection to the subnet that the load balancer IP is on.

<br />


## Planning private external networking for a private VLAN only setup
{: #plan_private_vlan}

When your worker nodes are connected to a private VLAN only, you can make your app accessible from a private network only by creating private NodePort, LoadBalancer, or Ingress services. Because your worker nodes are not connected to a public VLAN, no public traffic is routed to these services.
{: shortdesc}

**NodePort**:
* [Create a private NodePort service](/docs/containers/cs_nodeport.html). The service is available over the private IP address of a worker node.
* In your private firewall, open the port that you configured when you deployed the service to the private IP addresses for all of the worker nodes to allow traffic to. To find the port, run `kubectl get svc`. The port is in the 20000-32000 range.

**LoadBalancer**
* [Create a private LoadBalancer service](/docs/containers/cs_loadbalancer.html). If your cluster is available on a private VLAN only, one of the four available portable private IP addresses is used.
* In your private firewall, open the port that you configured when you deployed the service to the load balancer service's private IP address.

**Ingress**:
* You must configure a [DNS service that is available on the private network ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
* When you create a cluster, a private Ingress application load balancer (ALB) is created automatically but is not enabled by default. You must [enable the private ALB](/docs/containers/cs_ingress.html#private_ingress).
* Then, [create a private Ingress service](/docs/containers/cs_ingress.html#ingress_expose_private).
* In your private firewall, open port 80 for HTTP or port 443 for HTTPS to the IP address for the private ALB.


