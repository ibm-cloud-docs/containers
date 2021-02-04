---

copyright:
  years: 2014, 2021
lastupdated: "2021-02-04"

keywords: kubernetes, iks, networking

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}



# Choosing an app exposure service
{: #cs_network_planning}

With {{site.data.keyword.containerlong}}, you can manage in-cluster and external networking by making apps publicly or privately accessible.
{: shortdesc}

To quickly get started with app networking, follow this decision tree and click an option to see its setup docs:

<img usemap="#networking_map" border="0" class="image" src="images/cs_network_planning_dt.png" width="700" alt="This image walks you through choosing the best networking option for your application." style="width:700px;" />
<map name="networking_map" id="networking_map">
    <area target="" alt="NodePort service" title="NodePort service" href="/docs/containers?topic=containers-nodeport" coords="52,300,35" shape="circle">
    <area target="" alt="Network load balancer (NLB) service" title="Network load balancer (NLB) service" href="/docs/containers?topic=containers-loadbalancer-about" coords="309,594,46" shape="circle">
    <area target="" alt="Ingress application load balancer (ALB) service" title="Ingress application load balancer (ALB) service" href="/docs/containers?topic=containers-ingress-about" coords="463,595,51" shape="circle">
    <area target="" alt="Load Balancer for VPC" title="Load Balancer for VPC" href="/docs/containers?topic=containers-vpc-lbaas" coords="619,593,44" shape="circle">
</map>

## Understanding load balancing for apps through Kubernetes service discovery
{: #in-cluster}

Kubernetes service discovery provides apps with a network connection by using network services and a local Kubernetes proxy.
{: shortdesc}

**Services**

All pods that are deployed to a worker node are assigned a private IP address in the 172.30.0.0/16 range and are routed between worker nodes only. To avoid conflicts, don't use this IP range on any nodes that communicate with your worker nodes. Worker nodes and pods can securely communicate on the private network by using private IP addresses. However, when a pod crashes or a worker node needs to be re-created, a new private IP address is assigned.

Instead of trying to track changing private IP addresses for apps that must be highly available, you can use built-in Kubernetes service discovery features to expose apps as services. A Kubernetes service groups a set of pods and provides a network connection to these pods. The service selects the targeted pods that it routes traffic to via labels.

A service provides connectivity between your app pods and other services in the cluster without exposing the actual private IP address of each pod. Services are assigned an in-cluster IP address, the `clusterIP`, that is accessible inside the cluster only. This IP address is tied to the service for its entire lifespan and does not change while the service exists.
* Newer clusters: In clusters that were created after February 2018 in the dal13 zone or after October 2017 in any other zone, services are assigned an IP from one of the 65,000 IPs in the 172.21.0.0/16 range.
* Older clusters: In clusters that were created before February 2018 in the dal13 zone or before October 2017 in any other zone, services are assigned an IP from one of 254 IPs in the 10.10.10.0/24 range. If you hit the limit of 254 services and need more services, you must create a new cluster.

To avoid conflicts, don't use this IP range on any nodes that communicate with your worker nodes. A DNS lookup entry is also created for the service and stored in the `kube-dns` component of the cluster. The DNS entry contains the name of the service, the namespace where the service was created, and the link to the assigned in-cluster IP address.

If you plan to connect your cluster to on-premises networks through {{site.data.keyword.cloud_notm}} or a VPN service, you might have subnet conflicts with the default 172.30.0.0/16 range for pods and 172.21.0.0/16 range for services. You can avoid subnet conflicts when you [create a cluster](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#pod-subnet) by specifying a custom subnet CIDR for pods in the `--pod-subnet` flag and a custom subnet CIDR for services in the `--service-subnet` flag.
{: tip}

**`kube-proxy`**

To provide basic load balancing of all TCP and UDP network traffic for services, a local Kubernetes network proxy, `kube-proxy`, runs as a daemon on each worker node in the `kube-system` namespace. `kube-proxy` uses Iptables rules, a Linux kernel feature, to direct requests to the pod behind a service equally, independent of pods' in-cluster IP addresses and the worker node that they are deployed to.

For example, apps inside the cluster can access a pod behind a cluster service by using the service's in-cluster IP or by sending a request to the name of the service. When you use the name of the service, `kube-proxy` looks up the name in the cluster DNS provider and routes the request to the in-cluster IP address of the service.

If you use a service that provides both an internal cluster IP address and an external IP address, clients outside of the cluster can send requests to the service's external public or private IP address. `kube-proxy` forwards the requests to the service's in-cluster IP address and load balances between the app pods behind the service.

The following image demonstrates how Kubernetes forwards public network traffic through `kube-proxy` and NodePort, LoadBalancer, or Ingress services in {{site.data.keyword.containerlong_notm}}.
<p>
<figure>
 <img src="images/cs_network_planning_ov-01.png" alt="{{site.data.keyword.containerlong_notm}} external traffic network architecture">
 <figcaption>How Kubernetes forwards public network traffic through NodePort, LoadBalancer, and Ingress services in {{site.data.keyword.containerlong_notm}}</figcaption>
</figure>
</p>

<br />

## Understanding Kubernetes service types
{: #external}
{: help}
{: support}

Kubernetes supports four basic types of network services: `ClusterIP`, `NodePort`, `LoadBalancer`, and `Ingress`. `ClusterIP` services make your apps accessible internally to allow communication between pods in your cluster only. `NodePort`, `LoadBalancer`, and `Ingress` services make your apps externally accessible from the public internet or a private network.
{: shortdesc}

**[ClusterIP](https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service)**

You can expose apps only as cluster IP services on the private network. A `clusterIP` service provides an in-cluster IP address that is accessible by other pods and services inside the cluster only. No external IP address is created for the app. To access a pod behind a cluster service, other apps in the cluster can either use the in-cluster IP address of the service or send a request by using the name of the service. When a request reaches the service, the service forwards requests to the pods equally, independent of pods' in-cluster IP addresses and the worker node that they are deployed to. Note that if you do not specify a `type` in a service's YAML configuration file, the `ClusterIP` type is created by default.

**[NodePort](/docs/containers?topic=containers-nodeport)**

When you expose apps with a NodePort service, a NodePort in the range of 30000 - 32767 and an internal cluster IP address is assigned to the service. To access the service from outside the cluster, you use the public or private IP address of any worker node and the NodePort in the format `<IP_address>:<nodeport>`. However, the public and private IP addresses of the worker node are not permanent. When a worker node is removed or re-created, a new public and a new private IP address are assigned to the worker node. NodePorts are ideal for testing public or private access or providing access for only a short amount of time. **Note**: Because worker nodes in VPC clusters do not have a public IP address, you can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection.

**LoadBalancer**

The LoadBalancer service type is implemented differently depending on your cluster's infrastructure provider.
* <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Classic clusters: [Network load balancer (NLB)](/docs/containers?topic=containers-loadbalancer). Every standard cluster is provisioned with four portable public and four portable private IP addresses that you can use to create a layer 4 TCP/UDP network load balancer (NLB) for your app. You can customize your NLB by exposing any port that your app requires. The portable public and private IP addresses that are assigned to the NLB are permanent and do not change when a worker node is re-created in the cluster. You can create a subdomain for your app that registers public NLB IP addresses with a DNS entry. You can also enable health check monitors on the NLB IPs for each subdomain.
* <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC clusters: [Load Balancer for VPC](/docs/containers?topic=containers-vpc-lbaas). When you create a Kubernetes LoadBalancer service for an app in your cluster, a layer 7 VPC load balancer is automatically created in your VPC outside of your cluster. The VPC load balancer is multizonal and routes requests for your app through the private NodePorts that are automatically opened on your worker nodes. By default, the load balancer is also created with a hostname that you can use to access your app.

**[Ingress](/docs/containers?topic=containers-ingress)**

Expose multiple apps in a cluster by setting up routing with the Ingress application load balancer (ALB). The ALB uses a secured and unique public or private entry point, an Ingress subdomain, to route incoming requests to your apps. You can use one subdomain to expose multiple apps in your cluster as services. Ingress consists of three components:
* The Ingress resource defines the rules for how to route and load balance incoming requests for an app.
* The ALB listens for incoming HTTP, HTTPS, or TCP service requests. It forwards requests across the apps' pods based on the rules that you defined in the Ingress resource.
* The multizone load balancer (MZLB) for classic clusters or the VPC load balancer for VPC clusters handles all incoming requests to your apps and load balances the requests among the ALBs in the various zones. It also enables health checks for the public Ingress IP addresses.

</br>
The following table compares the features of each network service type.

|Characteristics|ClusterIP|NodePort|LoadBalancer (Classic - NLB)|LoadBalancer (VPC load balancer)|Ingress|
|---------------|---------|--------|----------------------------|--------------------------------|-------|
|Free clusters|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />| | | |
|Standard clusters|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Externally accessible| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|External hostname| | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Stable external IP| | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />| |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|HTTP(S) load balancing| | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />*|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />*|<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|TLS termination| | | | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Custom routing rules| | | | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
|Multiple apps per service| | | | |<img src="images/confirm.svg" width="32" alt="Feature available" style="width:32px;" />|
{: caption="Characteristics of Kubernetes network service types" caption-side="top"}

`*` An SSL certificate for HTTPS load balancing is provided by `ibmcloud ks nlb-dns` commands. In classic clusters, these commands are supported for public NLBs only.
{: note}

<br />

## Planning public external load balancing
{: #public_access}

Publicly expose an app in your cluster to the internet.
{: shortdesc}

In <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **classic** clusters, you can connect worker nodes to a public VLAN. The public VLAN determines the public IP address that is assigned to each worker node, which provides each worker node with a public network interface. Public networking services connect to this public network interface by providing your app with a public IP address and, optionally, a public URL.

In <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **VPC** clusters, your worker nodes are connected to private VPC subnets only. However, when you create public networking services, a VPC load balancer is automatically created. The VPC load balancer can route public requests to your app by providing your app a public URL. When an app is publicly exposed, anyone that has the public URL can send a request to your app.

When an app is publicly exposed, anyone that has the public service IP address or the URL that you set up for your app can send a request to your app. For this reason, expose as few apps as possible. Expose an app to the public only when your app is ready to accept traffic from external web clients or users.

The public network interface for worker nodes is protected by [predefined Calico network policy settings](/docs/containers?topic=containers-network_policies#default_policy) that are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked except for a few ports. These ports are opened so that IBM can monitor network traffic and automatically install security updates for the Kubernetes master, and so that connections can be established to NodePort, LoadBalancer, and Ingress services. For more information about these policies, including how to modify them, see [Network policies](/docs/containers?topic=containers-network_policies#network_policies).

### Choosing a deployment pattern for classic clusters
{: #pattern_public}

To make an app publicly available to the internet in a classic cluster, choose a load balancing deployment pattern that uses public NodePort, LoadBalancer, or Ingress services. The following table describes each possible deployment pattern, why you might use it, and how to set it up. For basic information about the networking services that these deployment patterns use, see [Understanding Kubernetes service types](#external).

|Name|Load-balancing method|Use case|Implementation|
|----|---------------------|--------|--------------|
| NodePort | Port on a worker node that exposes the app on the worker's public IP address | Test public access to one app or provide access for only a short amount of time. | [Create a public NodePort service](/docs/containers?topic=containers-nodeport#nodeport_config).<p class="note">**Gateway-enabled clusters that run Kubernetes version 1.17 only**: If you have a gateway-enabled cluster and use a public node port to expose your app, public traffic on the node port is blocked by default in Kubernetes version 1.17. Instead, use a [load balancer service](/docs/containers?topic=containers-loadbalancer-qs) or [create a preDNAT Calico policy](/docs/containers?topic=containers-policy_tutorial) with an order number that is lower than `1800` and with a selector `ibm.role == 'worker_public'` so that public traffic is explicitly allowed to the node port.</p>|
| NLB v1.0 (+ subdomain) | Basic load balancing that exposes the app with an IP address or a subdomain | Quickly expose one app to the public with an IP address or a subdomain that supports SSL termination. | <ol><li>Create a public network load balancer (NLB) 1.0 in a [single-](/docs/containers?topic=containers-loadbalancer#lb_config) or [multizone](/docs/containers?topic=containers-loadbalancer#multi_zone_config) cluster.</li><li>Optionally [register](/docs/containers?topic=containers-loadbalancer_hostname) a subdomain and health checks.</li></ol>|
| NLB v2.0 (+ subdomain) | DSR load balancing that exposes the app with an IP address or a subdomain | Expose an app that might receive high levels of traffic to the public with an IP address or a subdomain that supports SSL termination. | <ol><li>Complete the [prerequisites](/docs/containers?topic=containers-loadbalancer-v2#ipvs_provision).</li><li>Create a public NLB 2.0 in a [single-](/docs/containers?topic=containers-loadbalancer-v2#ipvs_single_zone_config) or [multizone](/docs/containers?topic=containers-loadbalancer-v2#ipvs_multi_zone_config) cluster.</li><li>Optionally [register](/docs/containers?topic=containers-loadbalancer_hostname) a subdomain and health checks.</li></ol>|
| Istio + NLB subdomain | Basic load balancing that exposes the app with a subdomain and uses Istio routing rules | Implement Istio post-routing rules, such as rules for different versions of one app microservice, and expose an Istio-managed app with a public subdomain.</li></ol> | <ol><li>Install the [managed Istio add-on](/docs/containers?topic=containers-istio#istio_install).</li><li>Include your app in the [Istio service mesh](/docs/containers?topic=containers-istio-mesh#istio_sidecar).</li><li>Register the default Istio load balancer with [a subdomain](/docs/containers?topic=containers-istio-mesh#istio_expose).</li></ol>|
| Ingress ALB | HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules | Implement custom routing rules and SSL termination for multiple apps. | <ol><li>Create an [Ingress service](/docs/containers?topic=containers-ingress#ingress_expose_public) for the public ALB.</li><li>Customize ALB routing rules with [annotations](/docs/containers?topic=containers-ingress_annotation).</li></ol>|
| Bring your own Ingress controller + NLB subdomain | HTTPS load balancing with a custom Ingress controller that exposes the app with the IBM-provided ALB subdomain and uses custom routing rules | Implement custom routing rules or other specific requirements for custom tuning for multiple apps. | [Deploy your Ingress controller and leverage an IBM-provided subdomain](/docs/containers?topic=containers-ingress-user_managed).|
{: caption="Characteristics of public network deployment patterns in {{site.data.keyword.containerlong_notm}} classic clusters" caption-side="top"}
{: summary="This table reads left to right about the name, characteristics, use cases, and deployment steps of public network deployment patterns in classic clusters."}

Still want more details about the load balancing deployment patterns that are available in {{site.data.keyword.containerlong_notm}}? Check out this [blog post](https://www.ibm.com/cloud/blog/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability){: external}.
{: tip}

### Choosing a deployment pattern for VPC clusters
{: #pattern_public_vpc}

To make an app publicly available to the internet in a VPC cluster, choose a load balancing deployment pattern that uses public `LoadBalancer` or `Ingress` services. The following table describes each possible deployment pattern, why you might use it, and how to set it up. For basic information about the networking services that these deployment patterns use, see [Understanding Kubernetes service types](#external).
{: shortdesc}

When you create a VPC Gen 2 cluster that runs Kubernetes version 1.18 or earlier, the VPC is created with a default security group that does not allow incoming traffic to your worker nodes. You must modify the security group for the VPC to allow incoming TCP traffic to ports `30000 - 32767`. For more information, see the "Before you begin" section of the [VPC load balancer](/docs/containers?topic=containers-vpc-lbaas#setup_vpc_ks_vpc_lb) or [Ingress](/docs/containers?topic=containers-ingress#ingress_expose_public) setup topics.
{: note}

|Name|Load-balancing method|Use case|Implementation|
|----|---------------------|--------|--------------|
| VPC load balancer | Basic load balancing that exposes the app with a hostname | Quickly expose one app to the public with a VPC load balancer-assigned hostname. | [Create a public `LoadBalancer` service](/docs/containers?topic=containers-vpc-lbaas) in your cluster. A VPC load balancer is automatically created in your VPC that assigns a hostname to your `LoadBalancer` service for your app.|
| Istio | Basic load balancing that exposes the app with a hostname and uses Istio routing rules | Implement Istio post-routing rules, such as rules for different versions of one app microservice, and expose an Istio-managed app with a public hostname.</li></ol> | <ol><li>Install the [managed Istio add-on](/docs/containers?topic=containers-istio#istio_install).</li><li>Include your app in the [Istio service mesh](/docs/containers?topic=containers-istio-mesh#istio_sidecar).</li><li>Register the default Istio load balancer with [a hostname](/docs/containers?topic=containers-istio-mesh#istio_expose).</li></ol>|
| Ingress ALB | HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules | Implement custom routing rules and SSL termination for multiple apps. | <ol><li>Create an [Ingress service](/docs/containers?topic=containers-ingress#ingress_expose_public) for the public ALB.</li><li>Customize ALB routing rules with [annotations](/docs/containers?topic=containers-ingress_annotation).</li></ol>|
{: caption="Characteristics of public network deployment patterns in {{site.data.keyword.containerlong_notm}} VPC clusters" caption-side="top"}
{: summary="This table reads left to right about the name, characteristics, use cases, and deployment steps of public network deployment patterns in VPC clusters."}

<br />

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
  * If traffic is permitted between VPC subnets, any system in the same VPC.
  * If traffic is permitted between VPCs, any system that has access to the VPC that the cluster is in.

### Choosing a deployment pattern for classic clusters
{: #pattern_private_classic}

To make an app available over a private network only in classic clusters, choose a load balancing deployment pattern based on your cluster's VLAN setup:
* [Public and private VLAN setup](#private_both_vlans)
* [Private VLAN only setup](#plan_private_vlan)

#### Setting up private load balancing in a public and private VLAN setup
{: #private_both_vlans}

When your worker nodes are connected to both a public and a private VLAN, you can make your app accessible from a private network only by creating private NodePort, LoadBalancer, or Ingress services. Then, you can create Calico policies to block public traffic to the services.
{: shortdesc}

The public network interface for worker nodes is protected by [predefined Calico network policy settings](/docs/containers?topic=containers-network_policies#default_policy) that are configured on every worker node during cluster creation. By default, all outbound network traffic is allowed for all worker nodes. Inbound network traffic is blocked except for a few ports. These ports are opened so that IBM can monitor network traffic and automatically install security updates for the Kubernetes master, and so that connections can be established to NodePort, LoadBalancer, and Ingress services.

Because the default Calico network policies allow inbound public traffic to these services, you can create Calico policies to instead block all public traffic to the services. For example, a NodePort service opens a port on a worker node over both the private and public IP address of the worker node. An NLB service with a portable private IP address opens a public NodePort on every worker node. You must create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block public NodePorts.

Check out the following load balancing deployment patterns for private networking:

|Name|Load-balancing method|Use case|Implementation|
|----|---------------------|--------|--------------|
|NodePort|Port on a worker node that exposes the app on the worker's private IP address|Test private access to one app or provide access for only a short amount of time.|<ol><li>[Create a NodePort service](/docs/containers?topic=containers-nodeport).</li><li>A NodePort service opens a port on a worker node over both the private and public IP address of the worker node. You must use a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to the public NodePorts.</li></ol>|
|NLB v1.0|Basic load balancing that exposes the app with a private IP address|Quickly expose one app to a private network with a private IP address.|<ol><li>[Create a private NLB service](/docs/containers?topic=containers-loadbalancer).</li><li>An NLB with a portable private IP address still has a public node port open on every worker node. Create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to the public NodePorts.</li></ol>|
|NLB v2.0|DSR load balancing that exposes the app with a private IP address|Expose an app that might receive high levels of traffic to a private network with an IP address.|<ol><li>Complete the [prerequisites](/docs/containers?topic=containers-loadbalancer-v2#ipvs_provision).</li><li>Create a private NLB 2.0 in a [single-](/docs/containers?topic=containers-loadbalancer-v2#ipvs_single_zone_config) or [multizone](/docs/containers?topic=containers-loadbalancer-v2#ipvs_multi_zone_config) cluster.</li><li>An NLB with a portable private IP address still has a public node port open on every worker node. Create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to the public NodePorts.</li></ol>|
|Ingress ALB|HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules|Implement custom routing rules and SSL termination for multiple apps.|<ol><li>[Disable the public ALB.](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure)</li><li>[Enable the private ALB and create an Ingress resource](/docs/containers?topic=containers-ingress#ingress_expose_private).</li><li>Customize ALB routing rules with [annotations](/docs/containers?topic=containers-ingress_annotation).</li><li>An NLB with a portable private IP address still has a public node port open on every worker node. Create a [Calico preDNAT network policy](/docs/containers?topic=containers-network_policies#block_ingress) to block traffic to the public NodePorts.</li></ol>|
{: caption="Characteristics of network deployment patterns for a public and a private VLAN setup" caption-side="top"}
{: summary="This table reads left to right about the name, characteristics, use cases, and deployment steps of private network deployment patterns in classic clusters."}

<br />

#### Setting up private load balancing for a private VLAN only setup
{: #plan_private_vlan}

When your worker nodes are connected to a private VLAN only, you can make your app externally accessible from a private network only by creating private NodePort, LoadBalancer, or Ingress services.
{: shortdesc}

If your cluster is connected to a private VLAN only and you enable the master and worker nodes to communicate through a private-only service endpoint, you cannot automatically expose your apps to a private network. You must set up a gateway appliance, such as a [VRA (Vyatta)](/docs/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) or an [FSA](/docs/vmwaresolutions/services?topic=vmwaresolutions-fsa_considerations) to act as your firewall and block or allow traffic. Because your worker nodes aren't connected to a public VLAN, no public traffic is routed to NodePort, LoadBalancer, or Ingress services. However, you must open up the required ports and IP addresses in your gateway appliance firewall to permit inbound traffic to these services.

Check out the following load balancing deployment patterns for private networking:

|Name|Load-balancing method|Use case|Implementation|
|----|---------------------|--------|--------------|
|NodePort|Port on a worker node that exposes the app on the worker's private IP address|Test private access to one app or provide access for only a short amount of time.|<ol><li>[Create a NodePort service](/docs/containers?topic=containers-nodeport).</li><li>In your private firewall, open the port that you configured when you deployed the service to the private IP addresses for all of the worker nodes to allow traffic to. To find the port, run `kubectl get svc`. The port is in the 30000-32767 range.</li></ol>|
|NLB v1.0|Basic load balancing that exposes the app with a private IP address|Quickly expose one app to a private network with a private IP address.|<ol><li>[Create a private NLB service](/docs/containers?topic=containers-loadbalancer).</li><li>In your private firewall, open the port that you configured when you deployed the service to the NLB's private IP address.</li></ol>|
|NLB v2.0|DSR load balancing that exposes the app with a private IP address|Expose an app that might receive high levels of traffic to a private network with an IP address.|<ol><li>[Create a private NLB service](/docs/containers?topic=containers-loadbalancer).</li><li>In your private firewall, open the port that you configured when you deployed the service to the NLB's private IP address.</li></ol>|
|Ingress ALB|HTTPS load balancing that exposes the app with a subdomain and uses custom routing rules|Implement custom routing rules and SSL termination for multiple apps.|<ol><li>Configure a [DNS service that is available on the private network](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external}.</li><li>[Enable the private ALB and create an Ingress resource](/docs/containers?topic=containers-ingress#private_ingress).</li><li>In your private firewall, open port 80 for HTTP or port 443 for HTTPS to the IP address for the private ALB.</li><li>Customize ALB routing rules with [annotations](/docs/containers?topic=containers-ingress_annotation).</li></ol>|
{: caption="Characteristics of network deployment patterns for a private VLAN only setup" caption-side="top"}
{: summary="This table reads left to right about the name, characteristics, use cases, and deployment steps of private network deployment patterns in classic clusters."}

### Choosing a deployment pattern for VPC clusters
{: #pattern_private_vpc}

Make your app accessible from only a private network by creating private NodePort, LoadBalancer, or Ingress services.
{: shortdesc}

Check out the following load balancing deployment patterns for private app networking in VPC clusters:

|Name|Load-balancing method|Use case|Implementation|
|----|---------------------|--------|--------------|
|NodePort|Port on a worker node that exposes the app on the worker's private IP address|Test private access to one app or provide access for only a short amount of time. **Note**: You can access an app through a NodePort only if you are connected to your private VPC network, such as through a VPN connection or by using the [Kubernetes web terminal](/docs/containers?topic=containers-cs_cli_install#cli_web).|[Create a private NodePort service](/docs/containers?topic=containers-nodeport).|
|VPC application load balancer|Basic load balancing that exposes the app with a private hostname|Quickly expose one app to a private network with a VPC application load balancer-assigned private hostname.|[Create a private `LoadBalancer` service](/docs/containers?topic=containers-vpc-lbaas#setup_vpc_ks_vpc_lb) in your cluster. A multizonal VPC application load balancer is automatically created in your VPC that assigns a hostname to your `LoadBalancer` service for your app.|
|Ingress ALB|HTTPS load balancing that exposes the app with a hostname and uses custom routing rules|Implement custom routing rules and SSL termination for multiple apps.|<ol><li>[Enable the private ALB, create a subdomain to register the ALB with a DNS entry, and create an Ingress resource](/docs/containers?topic=containers-ingress#ingress_expose_vpc_private).</li><li>Customize ALB routing rules with [annotations](/docs/containers?topic=containers-ingress_annotation).</li></ol>|
{: caption="Characteristics of private network deployment patterns for a VPC cluster" caption-side="top"}
{: summary="This table reads left to right about the name, characteristics, use cases, and deployment steps of private network deployment patterns in VPC clusters."}
