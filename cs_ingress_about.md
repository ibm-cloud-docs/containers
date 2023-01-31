---

copyright:
  years: 2014, 2023
lastupdated: "2023-01-31"

keywords: kubernetes, nginx, ingress controller

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# About Ingress
{: #ingress-about}

Ingress is a Kubernetes service discovery method that balances network traffic workloads in your cluster by forwarding public or private requests to your apps. You can use Ingress to expose multiple app services to the public or to a private network by using a unique public or private route.
{: shortdesc}

The Ingress application load balancer (ALB) is a layer 7 load balancer which implements the NGINX Ingress controller. A layer 4 `LoadBalancer` service exposes the ALB so that the ALB can receive external requests that come into your cluster. The ALB then routes requests to app pods in your cluster based on distinguishing layer 7 protocol characteristics, such as headers.

## What are the components of Ingress?
{: #ingress_components}

Ingress consists of three components:
*   Ingress resources
*   Application load balancers (ALBs)
*   A multizone load balancer (MZLB). A load balancer to handle incoming requests across zones. For classic clusters, this component is the multizone load balancer (MZLB) that {{site.data.keyword.containerlong_notm}} creates for you. For VPC clusters, this component is the VPC load balancer that is created for you in your VPC.
{: shortdesc}

### Ingress resource
{: #ingress-resource}

To expose an app by using Ingress, you must create a Kubernetes service for your app and register this service with Ingress by defining an Ingress resource. The Ingress resource is a Kubernetes resource that defines the rules for how to route incoming requests for apps.
{: shortdesc}

The Ingress resource also specifies the path to your app services. When you create a standard cluster, an Ingress subdomain is registered by default for your cluster in the format `<cluster_name>.<globally_unique_account_HASH>-0000.<region>.containers.appdomain.cloud`. The paths to your app services are appended to the public route to form a unique app URL such as `mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-south.containers.appdomain.cloud/myapp1`. The following table describes each component of the subdomain.

|Subdomain component|Description|
|----|----|
|`*`|The wildcard for the subdomain is registered by default for your cluster.|
|`<cluster_name>`|The name of your cluster. \n - If the cluster name is 26 characters or fewer and the cluster name is unique in this region, the entire cluster name is included and is not modified: `myclustername`. \n - If the cluster name is 26 characters or fewer and there is an existing cluster of the same name in this region, the entire cluster name is included and a dash with six random characters is added: `myclustername-ABC123`. \n - If the cluster name is 26 characters or greater and the cluster name is unique in this region, only the first 24 characters of the cluster name are used: `myveryverylongclusternam`. \n - If the cluster name is 26 characters or greater and there is an existing cluster of the same name in this region, only the first 17 characters of the cluster name are used and a dash with six random characters is added: `myveryverylongclu-ABC123`.|
|`<globally_unique_account_HASH>`|A globally unique HASH is created for your {{site.data.keyword.cloud_notm}} account. All subdomains that you create for NLBs in clusters in your account use this globally unique HASH.|
|`0000`|The first and second characters indicate a public or a private (internal) subdomain. `00` indicates a subdomain that has a public DNS entry. `i0` indicates a subdomain that has a private DNS entry. The third and fourth characters, such as `00` or another number, act as a counter for each subdomain that is created in your cluster.|
|`<region>`|The region that the cluster is created in.|
|`containers.appdomain.cloud`|The subdomain for {{site.data.keyword.containerlong_notm}} subdomains.|
{: caption="Understanding the Ingress subdomain format"}

One Ingress resource is required per namespace where you have apps that you want to expose.
* If the apps in your cluster are all in the same namespace, one Ingress resource is required to define routing rules for the apps that are exposed there. Note that if you want to use different domains for the apps within the same namespace, you can use a wildcard domain to specify multiple subdomain hosts within one resource.
* If the apps in your cluster are in different namespaces, you must create one resource per namespace to define rules for the apps that are exposed there. You must use a wildcard domain and specify a different subdomain in each Ingress resource.

### Application load balancer (ALB)
{: #alb-about}

The application load balancer (ALB) is an external load balancer that listens for incoming HTTP, HTTPS, or TCP service requests. The ALB then forwards requests to the appropriate app pod according to the rules defined in the Ingress resource.
{: shortdesc}

When you create a standard cluster, {{site.data.keyword.containerlong_notm}} automatically creates a highly available ALB in each zone where you have worker nodes and assigns a unique public domain which all public ALBs share. You can find the public domain for your cluster by running `ibmcloud ks cluster get --cluster <cluster_name_or_ID>` and looking for the **Ingress subdomain** in the format `mycluster-<hash>0001.us-south.containers.appdomain.cloud`. One default private ALB is also automatically created in each zone of your cluster, but the private ALBs are not automatically enabled and don't use the Ingress subdomain. Note that classic clusters with workers that are connected to private VLANs only are not assigned an IBM-provided Ingress subdomain.

####  Classic cluster ALB IP addresses
{: #classic-alb-ips}

In classic clusters, the Ingress subdomain for your cluster is linked to the public ALB IP addresses. You can find the IP address of each public ALB by running `ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>` and looking for the **ALB IP** field. The portable public and private ALB IP addresses are provisioned into your IBM Cloud infrastructure account during cluster creation and are static floating IPs that don't change for the life of the cluster. If the worker node is removed, Kubernetes deployment manager reschedules the ALB pods that were on that worker to another worker node in that zone. The rescheduled ALB pods retain the same static IP address. However, if you remove a zone from a cluster, then the ALB IP address for that zone is removed.

#### VPC cluster ALB hostnames
{: #vpc-alb-ips}

When you create a VPC cluster, one public VPC load balancer is automatically created outside of your cluster in your VPC. The public VPC load balancer puts the public IP addresses of your public ALBs behind one hostname. In VPC clusters, a hostname is assigned to the ALBs because the ALB IP addresses are not static and might change over time. Note that this ALB hostname is different than the Ingress subdomain for your cluster.

You can find the hostname that is assigned to your public ALBs and the hostname that is assigned to your private ALBs by running `ibmcloud ks ingress alb ls --cluster <cluster_name_or_ID>` and looking for the **Load Balancer Hostname** field. Because the private ALBs are disabled by default, a private VPC load balancer that puts your private ALBs behind one hostname is created only when you enable your private ALBs.

Do not delete the services that expose your ALBs on public or private IP addresses. These services are formatted such as `public-crdf253b6025d64944ab99ed63bb4567b6-alb1`.
{: note}

### Multizone load balancer (MZLB) or Load Balancer for VPC
{: #mzlb}

Depending on whether you have a classic or VPC cluster, an Akamai multizone load balancer (MZLB) or a Load Balancer for VPC health checks your ALBs. An Akamai multizone load balancer (MZLB) health checks your ALBs.
{: shortdesc}

#### Classic cluster multizone load balancer (MZLB)
{: #classic-mz-alb-ips}

Whenever you create a multizone cluster or [add a zone to a single zone cluster](/docs/containers?topic=containers-add_workers#add_zone), an Akamai multizone load balancer (MZLB) is automatically created and deployed so that 1 MZLB exists for each region. The MZLB puts the IP addresses of your ALBs behind the same subdomain and enables health checks on these IP addresses to determine whether they are available or not.

For example, if your cluster has worker nodes in 3 zones in the US-East region, the subdomain `mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-east.containers.appdomain.cloud` has 3 ALB IP addresses. The MZLB health checks the public ALB IP in each zone of a region and keeps the DNS lookup results updated based on these health checks. For example, if your ALBs have IP addresses `1.1.1.1`, `2.2.2.2`, and `3.3.3.3`, a normal operation DNS lookup of your Ingress subdomain returns all 3 IPs, 1 of which the client accesses at random. If the ALB with IP address `3.3.3.3` becomes unavailable for any reason, such as due to zone failure, then the health check for that zone fails, the MZLB removes the failed IP from the subdomain, and the DNS lookup returns only the healthy `1.1.1.1` and `2.2.2.2` ALB IPs. The subdomain has a 30 second time to live (TTL), so after 30 seconds, new client apps can access only one of the available, healthy ALB IPs.

In rare cases, some DNS resolvers or client apps might continue to use the unhealthy ALB IP after the 30-second TTL. These client apps might experience a longer load time until the client app abandons the `3.3.3.3` IP and tries to connect to `1.1.1.1` or `2.2.2.2`. Depending on the client browser or client app settings, the delay can range from a few seconds to a full TCP timeout.

Because Akamai is a public service, the MZLB load balances for public ALBs that use the IBM-provided Ingress subdomain only. If you use only private ALBs, you must manually check the health of the ALBs and update DNS lookup results. If you use public ALBs that use a custom domain, you can include the ALBs in MZLB load balancing by creating a CNAME in your DNS entry to forward requests from your custom domain to the IBM-provided Ingress subdomain for your cluster.

If you use Calico pre-DNAT network policies or another custom firewall to block incoming traffic to your cluster, you must allow inbound access on port 80 from the Kubernetes control plane and Akamai's IPv4 IP addresses to the IP addresses of your ALBs so that the Kubernetes control plane can check the health of your ALBs. For example, if you use Calico policies, [create a Calico pre-DNAT policy](/docs/containers?topic=containers-policy_tutorial#lesson3) to allow inbound access to your ALB IP addresses from [Akamai's source IP addresses](https://github.com/IBM-Cloud/kube-samples/tree/master/akamai/gtm-liveness-test){: external} on port 80 and the [control plane subnets for the region where your cluster is located](https://github.com/IBM-Cloud/kube-samples/tree/master/control-plane-ips){: external}.
{: note}


#### Load Balancer for VPC clusters
{: #loadbalancer-for-vpc-clus}


When you create a VPC cluster, one public and one private VPC load balancer are automatically created outside of your cluster in your VPC. The public VPC load balancer puts the public IP addresses of your public ALBs behind one hostname, and the private VPC load balancer puts the private IP addresses of your private ALBs behind one hostname. In VPC clusters, a hostname is assigned to the ALBs because the ALB IP addresses are not static and might change over time.

The Ingress subdomain for your cluster is automatically linked to the VPC load balancer hostname for your public ALBs. Note that the Ingress subdomain for your cluster, which looks like `<cluster_name>.<hash>-0000.<region>.containers.appdomain.cloud`, is different than the VPC load balancer-assigned hostname for your public ALBs, which looks like `01ab23cd-<region>.lb.appdomain.cloud`. The Ingress subdomain is the public route through which users access your app from the internet, and can be configured to use TLS termination. The assigned hostname for your public ALBs is what the VPC load balancer uses to manages your ALB IPs.

Before forwarding traffic to ALBs, the VPC load balancer also health checks the public ALB IP addresses that are behind the hostname to determine whether the ALBs are available or not. Every 5 seconds, the VPC load balancer health checks the floating public ALB IPs for your cluster and keeps the DNS lookup results updated based on these health checks. When a user sends a request to your app by using the cluster's Ingress subdomain and app route, such as `mycluster-<hash>-0000.us-south.containers.appdomain.cloud/myapp`, the VPC load balancer receives the request. If all ALBs are healthy, a normal operation DNS lookup of your Ingress subdomain returns all the floating IPs, 1 of which the client accesses at random. However, if one IP becomes unavailable for any reason, then the health check for that IP fails after 2 retries. The VPC load balancer removes the failed IP from the subdomain, and the DNS lookup returns only the healthy IPs while a new floating IP address is generated.

Note that the VPC load balancer health checks only public ALBs and updates DNS lookup results for the Ingress subdomain. If you use only private ALBs, you must manually check their health and update DNS lookup results.

If you set up [VPC security groups](/docs/openshift?topic=openshift-vpc-security-group) or [VPC access control lists (ACLs)](/docs/openshift?topic=openshift-vpc-acls) to secure your cluster network, ensure that you create the rules to allow the necessary traffic from the Kubernetes control plane IP addresses. Alternatively, to allow the inbound traffic for ALB healthchecks, you can create one rule to allow all incoming traffic on port 80.
{: note}



## How does a request get to my app in a classic cluster?
{: #architecture-classic}

### Single-zone cluster
{: #classic-single}

The following diagram shows how Ingress directs communication from the internet to an app in a classic single-zone cluster.
{: shortdesc}

![Expose an app in a single-zone cluster by using Ingress.](images/cs_ingress_singlezone.png){: caption="Figure 1. Expose an app in a single-zone cluster by using Ingress" caption-side="bottom"}

1. A user sends a request to your app by accessing your app's URL. This URL is the Ingress subdomain for your cluster appended with the Ingress resource path for your exposed app, such as `mycluster-<hash>-0000.us-south.containers.appdomain.cloud/myapp`.

2. A DNS system service resolves the subdomain in the URL to the portable public IP address of the load balancer that exposes the ALB in your cluster.

3. Based on the resolved IP address, the client sends the request to the Kubernetes load balancer service that exposes the ALB.

4. The load balancer service routes the request to the ALB.

5. The ALB checks if a routing rule for the `myapp` path in the cluster exists. If a matching rule is found, the request is proxied according to the rules that you defined in the Ingress resource to the pod where the app is deployed. The source IP address of the package is changed to the IP address of the worker node where the app pod runs. If multiple app instances are deployed in the cluster, the ALB load balances the requests between the app pods.

6. When the app returns a response packet, it uses the IP address of the worker node where the ALB that forwarded the client request exists. The ALB then sends the response packet to the client.

### Multizone cluster
{: #classic-multi}

The following diagram shows how Ingress directs communication from the internet to an app in a classic multizone cluster.
{: shortdesc}

![Expose an app in a multizone cluster by using Ingress.](images/cs_ingress_multizone.png){: caption="Figure 1. Expose an app in a multizone cluster by using Ingress" caption-side="bottom"}

1. A user sends a request to your app by accessing your app's URL. This URL is the Ingress subdomain for your cluster appended with the Ingress resource path for your exposed app, such as `mycluster-<hash>-0000.us-south.containers.appdomain.cloud/myapp`.

2. A DNS system service, which acts as the global load balancer, resolves the subdomain in the URL to an available IP address that was reported as healthy by the MZLB. The MZLB continuously checks the portable public IP addresses of the load balancer services that expose public ALBs in each zone in your cluster. The IP addresses are resolved in a round-robin cycle, ensuring that requests are equally load balanced among the healthy ALBs in various zones.

3. The client sends the request to the IP address of the Kubernetes load balancer service that exposes an ALB.

4. The load balancer service routes the request to the ALB.

5. The ALB checks if a routing rule for the `myapp` path in the cluster exists. If a matching rule is found, the request is proxied according to the rules that you defined in the Ingress resource to the pod where the app is deployed. The source IP address of the package is changed to the public IP address of the worker node where the app pod runs. If multiple app instances are deployed in the cluster, the ALB load balances the requests between app pods across all zones.

6. When the app returns a response packet, it uses the IP address of the worker node where the ALB that forwarded the client request exists. The ALB then sends the response packet to the client.

### Gateway-enabled cluster
{: #classic-gateway}

Gateway-enabled clusters are deprecated and become unsupported soon. If you have a gateway-enabled cluster, plan to create a new cluster before support ends. If you need similar functionality to gateway-enabled clusters, consider creating a cluster on VPC infrastructure. For more information, see [Understanding network basics of VPC clusters](/docs/containers?topic=containers-plan_vpc_basics). To get started creating a VPC cluster, see [Creating a standard VPC cluster](/docs/containers?topic=containers-cluster-create-vpc-gen2&interface=ui).
{: deprecated}

The following diagram shows how Ingress directs communication from the internet to an app in a [classic gateway-enabled cluster](/docs/containers?topic=containers-plan_basics#gateway).
{: shortdesc}

![Expose an app in a gateway-enabled cluster by using Ingress.](images/cs_ingress_gateway.png){: caption="Figure 1. Expose an app in a gateway-enabled cluster by using Ingress" caption-side="bottom"}

This diagram shows the traffic flow through a single-zone, gateway-enabled cluster. If your gateway-enabled cluster is multizone, one public ALB and one private ALB is created in each zone. Each ALB routes requests to the app instances in its own zone and to app instances in other zones.

1. A user sends a request to your app by accessing your app's URL. This URL is the Ingress subdomain for your cluster appended with the Ingress resource path for your exposed app, such as `mycluster-<hash>-0000.us-south.containers.appdomain.cloud/myapp`.

2. A DNS system service resolves the subdomain in the URL to the portable public IP address the ALB.

3. Based on the resolved IP address, the client sends the request to the NLB 2.0 that exposes the ALB. The NLB 2.0 is created automatically for your ALB and is scheduled to a worker node in the `gateway` worker pool, which has public network connectivity.

4. The load balancer service routes the request to the ALB over the private network. If you created an edge worker pool, the ALB pods are scheduled to a worker node in the edge pool, which has only private network connectivity. Otherwise, the ALB pods are scheduled to a worker in the `gateway` worker pool, which has public network connectivity.

5. The ALB checks if a routing rule for the `myapp` path in the cluster exists. If a matching rule is found, the request is proxied according to the rules that you defined in the Ingress resource to the pod where the app is deployed. The source IP address of the request package is changed to the public IP address of the gateway worker node where the NLB is deployed. If multiple app instances are deployed in the zone, the ALB load balances the requests between the app pods.

6. The app returns a response to the client. Equal Cost Multipath (ECMP) routing is used to balance the response traffic through a gateway on one of the gateway worker nodes to the client.



## How does a request get to my app in a VPC cluster?
{: #architecture-vpc}

The following diagram shows how Ingress directs communication from the internet to an app in a VPC multizone cluster.
{: shortdesc}

![Expose an app in a VPC cluster by using Ingress.](images/cs_ingress_vpc.png){: caption="Figure 1. Expose an app in a VPC cluster by using Ingress" caption-side="bottom"}

1. A user sends a request to your app by accessing your app's URL. This URL is the Ingress subdomain for your cluster for your exposed app appended with the Ingress resource path, such as `mycluster-<hash>-0000.us-south.containers.appdomain.cloud/myapp`.

2. A DNS service resolves the route subdomain to the VPC load balancer hostname that is assigned to the services for the ALBs. In VPC clusters, your ALB services' external IP addresses are floating, and are kept behind a VPC-assigned hostname.

3. The VPC load balancer resolves the VPC hostname to an available external IP address of an ALB service that was reported as healthy. The VPC load balancer continuously checks the external IP addresses of the ALBs in each zone in your cluster.

4. Based on the resolved IP address, the VPC load balancer sends the request to an ALB.

5. The ALB checks if a routing rule for the `myapp` path in the cluster exists. If a matching rule is found, the request is proxied according to the rules that you defined in the Ingress resource to the pod where the app is deployed. The source IP address of the package is changed to the IP address of the worker node where the app pod runs. If multiple app instances are deployed in the cluster, the ALB load balances the requests between app pods across all zones.



## How can I enable TLS certificates?
{: #enable-certs}

To load balance incoming HTTPS connections to your subdomain, you can configure the ALB to decrypt the network traffic and forward the decrypted request to the apps that are exposed in your cluster.
{: shortdesc}

When you configure the public ALB, you choose the domain that your apps are accessible through. If you use the IBM-provided domain, such as `mycluster-<hash>-0000.us-south.containers.appdomain.cloud/myapp`, you can use the default TLS certificate that is created for the Ingress subdomain. If you set up a CNAME record to map a custom domain to the IBM-provided domain, you can provide your own TLS certificate for your custom domain.

TLS secret configuration depends on the type of Ingress controller image that your ALB runs. For information about how to manage TLS certificates and secrets for Ingress, see the [Setting up {{site.data.keyword.secrets-manager_short}} in your Kubernetes Service cluster](/docs/containers?topic=containers-secrets-mgr).



## How can I customize routing?
{: #custom-routing}

You can modify default ALB settings and add annotations to your Ingress resources.
{: shortdesc}

* To manage how requests are routed to your app, specify [Kubernetes NGINX annotations](/docs/containers?topic=containers-comm-ingress-annotations) (`nginx.ingress.kubernetes.io/<annotation>`) in your Ingress resources.
* To modify default Ingress settings, such as to enable source IP preservation or configure SSL protocols, [change the `ibm-k8s-controller-config` or `ibm-ingress-deploy-config` ConfigMap resources](/docs/containers?topic=containers-comm-ingress-annotations) for your Ingress ALBs.



## How do I manage the lifecycle of my ALBs?
{: #alb-lifecycle}

Ingress ALBs are managed by {{site.data.keyword.containerlong_notm}}. To further modify and manage your ALBs, such as to manage version updates for your ALBs or to scale up ALB replicas, you can use `ibmcloud ks ingress alb` commands. For more information, see [Updating ALBs](/docs/containers?topic=containers-ingress-alb-manage#alb-update).
{: shortdesc}





