---

copyright:
  years: 2014, 2022
lastupdated: "2022-11-16"

keywords: kubernetes, networking

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Choosing an app exposure service
{: #cs_network_planning}

With {{site.data.keyword.containerlong}}, you can manage in-cluster and external networking by making apps publicly or privately accessible.
{: shortdesc}

To quickly get started with app networking, follow this decision tree and click an option to see its setup docs:

![Choosing an app exposure service](images/cs-network-planning.svg "Choosing an app exposure service"){: caption="Figure 1. This image walks you through choosing the best networking option for your application caption-side="bottom"}

## Understanding load balancing for apps through Kubernetes service discovery
{: #in-cluster}

Kubernetes service discovery provides apps with a network connection by using network services and a local Kubernetes proxy.
{: shortdesc}

### Services
{: #app-exposure-service}

All pods that are deployed to a worker node are assigned a private IP address in the 172.30.0.0/16 range and are routed between worker nodes only. To avoid conflicts, don't use this IP range on any nodes that communicate with your worker nodes. Worker nodes and pods can securely communicate on the private network by using private IP addresses. However, when a pod crashes or a worker node needs to be re-created, a new private IP address is assigned.

Instead of trying to track changing private IP addresses for apps that must be highly available, you can use built-in Kubernetes service discovery features to expose apps as services. A Kubernetes service groups a set of pods and provides a network connection to these pods. The service selects the targeted pods that it routes traffic to via labels.

A service provides connectivity between your app pods and other services in the cluster without exposing the actual private IP address of each pod. Services are assigned an in-cluster IP address, the `clusterIP`, that is accessible inside the cluster only. This IP address is tied to the service for its entire lifespan and does not change while the service exists.
* Newer clusters: In clusters that were created after February 2018 in the dal13 zone or after October 2017 in any other zone, services are assigned an IP from one of the 65,000 IPs in the 172.21.0.0/16 range.
* Older clusters: In clusters that were created before February 2018 in the dal13 zone or before October 2017 in any other zone, services are assigned an IP from one of 254 IPs in the 10.10.10.0/24 range. If you hit the limit of 254 services and need more services, you must create a new cluster.

To avoid conflicts, don't use this IP range on any nodes that communicate with your worker nodes. A DNS lookup entry is also created for the service and stored in the `kube-dns` component of the cluster. The DNS entry contains the name of the service, the namespace where the service was created, and the link to the assigned in-cluster IP address.

If you plan to connect your cluster to on-premises networks through {{site.data.keyword.cloud_notm}} or a VPN service, you might have subnet conflicts with the default 172.30.0.0/16 range for pods and 172.21.0.0/16 range for services. You can avoid subnet conflicts when you [create a cluster](/docs/containers?topic=containers-kubernetes-service-cli#pod-subnet) by specifying a custom subnet CIDR for pods in the `--pod-subnet` flag and a custom subnet CIDR for services in the `--service-subnet` flag.
{: tip}

## kube-proxy
{: #app-exposure-proxy}

To provide basic load balancing of all TCP and UDP network traffic for services, a local Kubernetes network proxy, `kube-proxy`, runs as a daemon on each worker node in the `kube-system` namespace. `kube-proxy` uses Iptables rules, a Linux kernel feature, to direct requests to the pod behind a service equally, independent of pods' in-cluster IP addresses and the worker node that they are deployed to.

For example, apps inside the cluster can access a pod behind a cluster service by using the service's in-cluster IP or by sending a request to the name of the service. When you use the name of the service, `kube-proxy` looks up the name in the cluster DNS provider and routes the request to the in-cluster IP address of the service.

If you use a service that provides both an internal cluster IP address and an external IP address, clients outside of the cluster can send requests to the service's external public or private IP address. `kube-proxy` forwards the requests to the service's in-cluster IP address and load balances between the app pods behind the service.

The following image demonstrates how Kubernetes forwards public network traffic through `kube-proxy` and NodePort, LoadBalancer, or Ingress services in {{site.data.keyword.containerlong_notm}}.

![{{site.data.keyword.containerlong_notm}} external traffic network architecture](images/cs_network_planning_ov-01.png "External traffic network architecture"){: caption="How Kubernetes forwards public network traffic through NodePort, LoadBalancer, and Ingress services}


## Understanding Kubernetes service types
{: #external}
{: help}
{: support}

Kubernetes supports four basic types of network services: `ClusterIP`, `NodePort`, `LoadBalancer`, and `Ingress`. `ClusterIP` services make your apps accessible internally to allow communication between pods in your cluster only. `NodePort`, `LoadBalancer`, and `Ingress` services make your apps externally accessible from the public internet or a private network.
{: shortdesc}

[ClusterIP](https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service){: external}
:   You can expose apps only as cluster IP services on the private network. A `clusterIP` service provides an in-cluster IP address that is accessible by other pods and services inside the cluster only. No external IP address is created for the app. To access a pod behind a cluster service, other apps in the cluster can either use the in-cluster IP address of the service or send a request by using the name of the service. When a request reaches the service, the service forwards requests to the pods equally, independent of pods' in-cluster IP addresses and the worker node that they are deployed to. Note that if you don't specify a `type` in a service's YAML configuration file, the `ClusterIP` type is created by default.

[NodePort](/docs/containers?topic=containers-nodeport)
:   When you expose apps with a NodePort service, a NodePort in the range of 30000 - 32767 and an internal cluster IP address is assigned to the service. To access the service from outside the cluster, you use the public or private IP address of any worker node and the NodePort in the format `<IP_address>:<nodeport>`. However, the public and private IP addresses of the worker node are not permanent. When a worker node is removed or re-created, a new public and a new private IP address are assigned to the worker node. NodePorts are ideal for testing public or private access or providing access for only a short amount of time. **Note**: Because worker nodes in VPC clusters don't have a public IP address, you can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection.

LoadBalancer
:   The LoadBalancer service type is implemented differently depending on your cluster's infrastructure provider.
    * Classic clusters: [Network load balancer (NLB)](/docs/containers?topic=containers-loadbalancer). Every standard cluster is provisioned with four portable public and four portable private IP addresses that you can use to create a layer 4 TCP/UDP network load balancer (NLB) for your app. You can customize your NLB by exposing any port that your app requires. The portable public and private IP addresses that are assigned to the NLB are permanent and don't change when a worker node is re-created in the cluster. You can create a subdomain for your app that registers public NLB IP addresses with a DNS entry. You can also enable health check monitors on the NLB IPs for each subdomain.
    * VPC clusters: [Load Balancer for VPC](/docs/containers?topic=containers-vpc-lbaas). When you create a Kubernetes LoadBalancer service for an app in your cluster, a layer 7 VPC load balancer is automatically created in your VPC outside of your cluster. The VPC load balancer is multizonal and routes requests for your app through the private NodePorts that are automatically opened on your worker nodes. By default, the load balancer is also created with a hostname that you can use to access your app.

[Ingress](/docs/containers?topic=containers-ingress-types)
:   Expose multiple apps in a cluster by setting up routing with the Ingress application load balancer (ALB). The ALB uses a secured and unique public or private entry point, an Ingress subdomain, to route incoming requests to your apps. You can use one subdomain to expose multiple apps in your cluster as services. Ingress consists of three components:
    * The Ingress resource defines the rules for how to route and load balance incoming requests for an app.
    * The ALB listens for incoming HTTP, HTTPS, or TCP service requests. It forwards requests across the apps' pods based on the rules that you defined in the Ingress resource.
    * The multizone load balancer (MZLB) for classic clusters or the VPC load balancer for VPC clusters handles all incoming requests to your apps and load balances the requests among the ALBs in the various zones. It also enables health checks for the public Ingress IP addresses.


The following table compares the features of each network service type.

|Characteristics|ClusterIP|NodePort|LoadBalancer (Classic - NLB)|LoadBalancer (VPC load balancer)|Ingress|
|---------------|---------|--------|----------------------------|--------------------------------|-------|
|Free clusters|Yes|Yes| | | |
|Standard clusters|Yes|Yes|Yes|Yes|Yes|
|Externally accessible| |Yes|Yes|Yes|Yes|
|External hostname| | |Yes|Yes|Yes|
|Stable external IP| | |Yes| |Yes|
|HTTP(S) load balancing| | |Yes*|Yes*|Yes|
|TLS termination| | | | |Yes|
|Custom routing rules| | | | |Yes|
|Multiple apps per service| | | | |Yes|
{: caption="Characteristics of Kubernetes network service types" caption-side="bottom"}

`*` An SSL certificate for HTTPS load balancing is provided by `ibmcloud ks nlb-dns` commands. In classic clusters, these commands are supported for public NLBs only.
{: note}



## Planning public external load balancing
{: #public_access}

Publicly expose an app in your cluster to the internet.
{: shortdesc}

In **classic** clusters, you can connect worker nodes to a public VLAN. The public VLAN determines the public IP address that is assigned to each worker node, which provides each worker node with a public network interface. Public networking services connect to this public network interface by providing your app with a public IP address and, optionally, a public URL.

In **VPC** clusters, your worker nodes are connected to private VPC subnets only. However, when you create public networking services, a VPC load balancer is automatically created. The VPC load balancer can route public requests to your app by providing your app a public URL. When an app is publicly exposed, anyone that has the public URL can send a request to your app.

When an app is publicly exposed, anyone that has the public service IP address or the URL that you set up for your app can send a request to your app. For this reason, expose as few apps as possible. Expose an app to the public only when your app is ready to accept traffic from external web clients or users.

The public network interface for worker nodes is protected by [predefined Calico network policy settings](/docs/containers?topic=containers-network_policies#default_policy) that are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked except for a few ports. These ports are opened so that IBM can monitor network traffic and automatically install security updates for the Kubernetes master, and so that connections can be established to NodePort, LoadBalancer, and Ingress services. For more information about these policies, including how to modify them, see [Network policies](/docs/containers?topic=containers-network_policies#network_policies).

### Choosing a deployment pattern for classic clusters
{: #pattern_public}

To make an app publicly available to the internet in a classic cluster, choose a load balancing deployment pattern that uses public NodePort, LoadBalancer, or Ingress services. The following table describes each possible deployment pattern, why you might use it, and how to set it up. For basic information about the networking services that these deployment patterns use, see [Understanding Kubernetes service types](#external).


NodePort
:   **Load-balancing method**: Port on a worker node that exposes the app on the worker's public IP address
:   **Use case**: Test public access to one app or provide access for only a short amount of time.
:   **Implementation**: [Create a public NodePort service](/docs/containers?topic=containers-nodeport#nodeport_config).


NLB v1.0 (+ subdomain)
:   **Load-balancing method**: Basic load balancing that exposes the app with an IP address or a subdomain.
:   **Use case**: Quickly expose one app to the public with an IP address or a subdomain that supports SSL termination.
:   **Implementation**:
        1. Create a public network load balancer (NLB) 1.0 in a [single](/docs/containers?topic=containers-loadbalancer#lb_config) or [multizone](/docs/containers?topic=containers-loadbalancer#multi_zone_config) cluster.  
        2. Optionally [register](/docs/containers?topic=containers-loadbalancer_hostname) a subdomain and health checks.
    
NLB v2.0 (+ subdomain)
:   **Load-balancing method**: DSR load balancing that exposes the app with an IP address or a subdomain
:   **Use case**: Expose an app that might receive high levels of traffic to the public with an IP address or a subdomain that supports SSL termination.
:   **Implementation**: 
        1. Complete the [prerequisites](/docs/containers?topic=containers-loadbalancer-v2#ipvs_provision).
        2. Create a public NLB 2.0 in a [single](/docs/containers?topic=containers-loadbalancer-v2#ipvs_single_zone_config) or [multizone](/docs/containers?topic=containers-loadbalancer-v2#ipvs_multi_zone_config) cluster.
        3. Optionally [register](/docs/containers?topic=containers-loadbalancer_hostname) a subdomain and health checks.
    
Istio + NLB subdomain
:   **Load-balancing method**: Basic load balancing that exposes the app with a subdomain and uses Istio routing rules.
:   **Use case**: Implement Istio post-routing rules, such as rules for different versions of one app microservice, and expose an Istio-managed app with a public subdomain.
:   **Implementation**:
        1. Install the [managed Istio add-on](/docs/containers?topic=containers-istio#istio_install).
        2. Include your app in the [Istio service mesh](/docs/containers?topic=containers-istio-mesh#istio_sidecar).
        3. Register the default Istio load balancer with [a subdomain](/docs/containers?topic=containers-istio-mesh#istio_expose).
        
Ingress ALB
:   **Load-balancing method**: HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules.
:   **Use case**: Implement custom routing rules and SSL termination for multiple apps.
:   **Implementation**:
        1. Create an [Ingress service](/docs/containers?topic=containers-ingress-types#alb-comm-create) for the public ALB.
        2. Customize ALB routing rules with [annotations](/docs/containers?topic=containers-comm-ingress-annotations).



Still want more details about the load balancing deployment patterns that are available in {{site.data.keyword.containerlong_notm}}? Check out this [blog post](https://www.ibm.com/cloud/blog/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability){: external}.
{: tip}

### Choosing a deployment pattern for VPC clusters
{: #pattern_public_vpc}

To make an app publicly available to the internet in a VPC cluster, choose a load balancing deployment pattern that uses public `LoadBalancer` or `Ingress` services. The following table describes each possible deployment pattern, why you might use it, and how to set it up. For basic information about the networking services that these deployment patterns use, see [Understanding Kubernetes service types](#external).
{: shortdesc}

When you create a VPC cluster that runs Kubernetes version 1.18 or earlier, the VPC is created with a default security group that does not allow incoming traffic to your worker nodes. You must modify the security group for the VPC to allow incoming TCP traffic to ports `30000 - 32767`. For more information, see the "Before you begin" section of the [VPC load balancer](/docs/containers?topic=containers-vpc-lbaas#setup_vpc_ks_vpc_lb) or [Ingress](/docs/containers?topic=containers-ingress-types#alb-comm-create) setup topics.
{: note}


VPC load balancer
:   **Load-balancing method**: Basic load balancing that exposes the app with a hostname
:   **Use case**: Quickly expose one app to the public with a VPC load balancer-assigned hostname.
:   **Implementation**: [Create a public `LoadBalancer` service](/docs/containers?topic=containers-vpc-lbaas) in your cluster. A VPC load balancer is automatically created in your VPC that assigns a hostname to your `LoadBalancer` service for your app.

Istio
:   **Load-balancing method**: Basic load balancing that exposes the app with a hostname and uses Istio routing rules
:   **Use case**: Implement Istio post-routing rules, such as rules for different versions of one app microservice, and expose an Istio-managed app with a public hostname.
:   **Implementation**: 
        1. Install the [managed Istio add-on](/docs/containers?topic=containers-istio#istio_install).
        2. Include your app in the [Istio service mesh](/docs/containers?topic=containers-istio-mesh#istio_sidecar).
        3. Register the default Istio load balancer with [a hostname](/docs/containers?topic=containers-istio-mesh#istio_expose).
        
        
Ingress ALB
:   **Load-balancing method**: HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules.
:   **Use case**: Implement custom routing rules and SSL termination for multiple apps.
:   **Implementation**: 
        1. Create an [Ingress service](/docs/containers?topic=containers-ingress-types#alb-comm-create) for the public ALB.
        2. Customize ALB routing rules with [annotations](/docs/containers?topic=containers-comm-ingress-annotations).




## Planning private external load balancing
{: #private_access}

Privately expose an app in your cluster to the private network only.
{: shortdesc}

When you deploy an app in a Kubernetes cluster in {{site.data.keyword.containerlong_notm}}, you might want to make the app accessible to only users and services that are on the same private network as your cluster. Private load balancing is ideal for making your app available to requests from outside the cluster without exposing the app to the general public. You can also use private load balancing to test access, request routing, and other configurations for your app before you later expose your app to the public with public network services.

As an example, say that you create a private load balancer for your app. This private load balancer can be accessed by:
* Any pod in that same cluster.
* Any pod in any cluster in the same {{site.data.keyword.cloud_notm}} account.
* If you're not in the {{site.data.keyword.cloud_notm}} account but still behind the company firewall, any system through a VPN connection to the subnet that the load balancer IP is on.
* If you're in a different {{site.data.keyword.cloud_notm}} account, any system through a VPN connection to the subnet that the load balancer IP is on.
* In classic clusters, if you have [VRF or VLAN spanning](/docs/containers?topic=containers-subnets#basics_segmentation) enabled, any system that is connected to any of the private VLANs in the same {{site.data.keyword.cloud_notm}} account.
* In VPC clusters:
    * If you permit traffic between VPC subnets, any system in the same VPC.
    * If you permit traffic between VPCs, any system that has access to the VPC that the cluster is in.

### Choosing a deployment pattern for classic clusters
{: #pattern_private_classic}

To make an app available over a private network only in classic clusters, choose a load balancing deployment pattern based on your cluster's VLAN setup:
* [Public and private VLAN setup](#private_both_vlans)
* [Private VLAN only setup](#plan_private_vlan)

#### Setting up private load balancing in a public and private VLAN setup
{: #private_both_vlans}

When your worker nodes are connected to both a public and a private VLAN, you can make your app accessible from a private network only by creating private NodePort, LoadBalancer, or Ingress services. Then, you can create Calico policies to block public traffic to the services.
{: shortdesc}

[Predefined Calico network policy settings](/docs/containers?topic=containers-network_policies#default_policy) protect the public network interface for worker nodes and are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked except for a few ports. These ports allow IBM to monitor network traffic and automatically install security updates for the Kubernetes master, and so that connections can be established to NodePort, LoadBalancer, and Ingress services.

Because the default Calico network policies allow inbound public traffic to these services, you can create Calico policies to instead block all public traffic to the services. For example, a NodePort service opens a port on a worker node over both the private and public IP address of the worker node. An NLB service with a portable private IP address opens a public NodePort on every worker node. You must create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block public NodePorts.

Review the load balancing deployment patterns for private networking.


NodePort
:   **Load-balancing method**: Port on a worker node that exposes the app on the worker's private IP address
:   **Use case**: Test private access to one app or provide access for only a short amount of time.
:   **Implementation**: [Create a NodePort service](/docs/containers?topic=containers-nodeport). A NodePort service opens a port on a worker node over both the private and public IP address of the worker node. You must use a [Calico preDNAT](/docs/containers?topic=containers-network_policies#block_ingress) network policy to block traffic to the public NodePorts.

NLB v1.0
:   **Load-balancing method**: Basic load balancing that exposes the app with a private IP address.
:   **Use case**: Quickly expose one app to a private network with a private IP address.
:   **Implementation**: 
        1. [Create a private NLB service](/docs/containers?topic=containers-loadbalancer). An NLB with a portable private IP address still has a public node port open on every worker node. 
        2. Create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to the public NodePorts.
        
NLB v2.0
:   **Load-balancing method**: DSR load balancing that exposes the app with a private IP address.
:   **Use case**: Expose an app that might receive high levels of traffic to a private network with an IP address.
:   **Implementation**:
        1. Complete the [prerequisites](/docs/containers?topic=containers-loadbalancer-v2#ipvs_provision).
        2. Create a private NLB 2.0 in a [single](/docs/containers?topic=containers-loadbalancer-v2#ipvs_single_zone_config) or [multizone](/docs/containers?topic=containers-loadbalancer-v2#ipvs_multi_zone_config) cluster.
        3. An NLB with a portable private IP address still has a public node port open on every worker node. Create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to the public NodePorts.

Ingress ALB
:   **Load-balancing method**: HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules.
:   **Use case**: Implement custom routing rules and SSL termination for multiple apps.
:   **Implementation**:
        1. [Disable the public ALB](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure).
        2. [Enable the private ALB and create an Ingress resource](/docs/containers?topic=containers-ingress-types#alb-comm-create-private).
        3. Customize ALB routing rules with [annotations](/docs/containers?topic=containers-comm-ingress-annotations).
        4. An NLB with a portable private IP address still has a public node port open on every worker node. Create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to the public NodePorts.




#### Setting up private load balancing for a private VLAN only setup
{: #plan_private_vlan}

When your worker nodes are connected to a private VLAN only, you can make your app externally accessible from a private network only by creating private NodePort, LoadBalancer, or Ingress services.
{: shortdesc}

If your cluster is connected to a private VLAN only and you enable the master and worker nodes to communicate through a private-only service endpoint, you can't automatically expose your apps to a private network. You must set up a gateway appliance, such as a [VRA (Vyatta)](/docs/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) or an [FSA](/docs/vmwaresolutions/services?topic=vmwaresolutions-fsa_considerations) to act as your firewall and block or allow traffic. Because your worker nodes aren't connected to a public VLAN, no public traffic is routed to NodePort, LoadBalancer, or Ingress services. However, you must open up the required ports and IP addresses in your gateway appliance firewall to permit inbound traffic to these services.

Check out the following load balancing deployment patterns for private networking:


NodePort
:   **Load-balancing method**: Port on a worker node that exposes the app on the worker's private IP address
:   **Use case**: Test private access to one app or provide access for only a short amount of time.
:   **Implementation**:
        1. [Create a NodePort service](/docs/containers?topic=containers-nodeport).
        2. In your private firewall, open the port that you configured when you deployed the service to the private IP addresses for all the worker nodes to allow traffic to. To find the port, run `kubectl get svc`. The port is in the `30000-32767` range.

NLB v1.0
:   **Load-balancing method**: Basic load balancing that exposes the app with a private IP address.
:   **Use case**: Quickly expose one app to a private network with a private IP address.
:   **Implementation**: 
        1. [Create a private NLB service](/docs/containers?topic=containers-loadbalancer).
        2. In your private firewall, open the port that you configured when you deployed the service to the NLB's private IP address.

NLB v2.0
:   **Load-balancing method**: DSR load balancing that exposes the app with a private IP address.
:   **Use case**: Expose an app that might receive high levels of traffic to a private network with an IP address.
:    **Implementation**:
        1. [Create a private NLB service](/docs/containers?topic=containers-loadbalancer).
        2. In your private firewall, open the port that you configured when you deployed the service to the NLB's private IP address.

Ingress ALB
:   **Load-balancing method**: HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules.
:   **Use case**: Implement custom routing rules and SSL termination for multiple apps.
:   **Implementation**:
        1. Configure a [DNS service that is available on the private network](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external}.
        2. [Enable the private ALB and create an Ingress resource](/docs/containers?topic=containers-ingress-types#alb-comm-create-private).
        3. In your private firewall, open port 80 for HTTP or port 443 for HTTPS to the IP address for the private ALB.
        4. Customize ALB routing rules with [annotations](/docs/containers?topic=containers-comm-ingress-annotations).


### Choosing a deployment pattern for VPC clusters
{: #pattern_private_vpc}

Make your app accessible from only a private network by creating private NodePort, LoadBalancer, or Ingress services.
{: shortdesc}

Check out the following load balancing deployment patterns for private app networking in VPC clusters:


NodePort
:   **Load-balancing method**: Port on a worker node that exposes the app on the worker's private IP address.
:   **Use case**: Test private access to one app or provide access for only a short amount of time. **Note**: You can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection.
:   **Implementation**: [Create a private NodePort service](/docs/containers?topic=containers-nodeport).

VPC application load balancer
:   **Load-balancing method**:Basic load balancing that exposes the app with a private hostname.
:   **Use case**: Quickly expose one app to a private network with a VPC application load balancer-assigned private hostname.
:   **Implementation**: [Create a private `LoadBalancer` service](/docs/containers?topic=containers-vpc-lbaas#setup_vpc_ks_vpc_lb) in your cluster. A multizonal VPC application load balancer is automatically created in your VPC that assigns a hostname to your `LoadBalancer` service for your app.

Ingress ALB
:   **Load-balancing method**: HTTPS load balancing that exposes the app with a hostname and uses custom routing rules.
:   **Use case**: Implement custom routing rules and SSL termination for multiple apps.
:   **Implementation**:
        1. [Enable the private ALB, create a subdomain to register the ALB with a DNS entry, and create an Ingress resource](/docs/containers?topic=containers-ingress-types#alb-comm-create-private).
        2. Customize ALB routing rules with [annotations](/docs/containers?topic=containers-comm-ingress-annotations).






