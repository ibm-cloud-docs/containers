---

copyright:
  years: 2022, 2023
lastupdated: "2023-07-26"

keywords: ingress, alb, application load balancer, nginx, ingress controller, network traffic, exposing apps

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Ingress in {{site.data.keyword.cloud_notm}}
{: #managed-ingress-about}

Ingress is a Kubernetes service discovery method that exposes the services in your cluster to the public or private network by forwarding requests to your apps and balancing network traffic workloads. Ingress manages external access to your services based on a set of routing rules that you configure and that are applied to all incoming traffic. 
{: shortdesc}

When you provision an {{site.data.keyword.containerlong_notm}} cluster, IBM provides all the components required to use Ingress. Then, when you are ready to get started, you create an Ingress resource to specify how these components work together. 

For more information about Kubernetes Ingress, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external}. 


## IBM-provided Ingress components
{: #managed-ingress-components}

All the components required to use Ingress are provided for you when you create a cluster. You specify these components when you create your Ingress resource. 
{: shortdesc}

- Ingress domain
- Ingress class
- Application Load Balancers (ALBs)
- TLS certificate

If you do not want to use the IBM-provided components, you can [create custom components](/docs/containers) that you specify in your Ingress resource instead.


### Ingress domain
{: #managed-ingress-subdomain}

The default Ingress domain is used to form a unique URL for each app in your cluster, and is the domain that is referenced by the IP addresses of any ALBs in your cluster. When you create a cluster, a unique Ingress subdomain is automatically created and registered as the default domain. You can [change the default domain](/docs/containers?topic=containers-ingress-domains#ingress-domain-manage-default) to any domain that exists in your cluster. 
{: shortdesc}

You can also [create or add your own domain](/docs/containers?topic=containers-ingress-domains) registered with IBM Cloud's internal domain provider, or a domain registered with an external provider. Currently, {{site.data.keyword.cloud_notm}} supports external domains registered with {{site.data.keyword.cis_full_notm}}, Akamai, or Cloudflare.
{: tip}

Private ALBs do not reference the IBM-provided Ingress subdomain and instead require a [custom domain](/docs/containers?topic=containers-managed-ingress-setup#ingress-custom-domain).
{: note}

The subdomain is registered in the following format.

```sh
<cluster_name>.<globally_unique_account_HASH>-0000.<region>.containers.appdomain.cloud
```
{: screen}

The following table describes each portion of the subdomain.

|Subdomain component|Description|
|----|----|
|`*`|The wildcard for the subdomain is registered by default for your cluster.|
|`<cluster_name>`|The name of your cluster. \n - If the cluster name is 26 characters or fewer and the cluster name is unique in this region, the entire cluster name is included and is not modified: `myclustername`. \n - If the cluster name is 26 characters or fewer and there is an existing cluster of the same name in this region, the entire cluster name is included and a dash with six random characters is added: `myclustername-ABC123`. \n - If the cluster name is 26 characters or greater and the cluster name is unique in this region, only the first 24 characters of the cluster name are used: `myveryverylongclusternam`. \n - If the cluster name is 26 characters or greater and there is an existing cluster of the same name in this region, only the first 17 characters of the cluster name are used and a dash with six random characters is added: `myveryverylongclu-ABC123`.|
|`<globally_unique_account_HASH>`|A globally unique HASH is created for your {{site.data.keyword.cloud_notm}} account. All subdomains that you create for NLBs in clusters in your account use this globally unique HASH.|
|`0000`|The first and second characters indicate a public or a private (internal) subdomain. `00` indicates a subdomain that has a public DNS entry. `i0` indicates a subdomain that has a private DNS entry. The third and fourth characters, such as `00` or another number, act as a counter for each subdomain that is created in your cluster.|
|`<region>`|The region that the cluster is created in.|
|`containers.appdomain.cloud`|The subdomain for {{site.data.keyword.containerlong_notm}} subdomains.|
{: caption="Understanding the Ingress subdomain format"}

To form a unique URL for each app, the paths to your app services are appended to the public route. For example, see the following app URL.

```sh
mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-south.containers.appdomain.cloud/myapp1
```
{: screen}

### Ingress class
{: #managed-ingress-class}

The Ingress class determines the type of Ingress controller that is used. IBM provides two Ingress classes, one public (`public-iks-k8s-nginx`) and one private (`private-iks-k8s-nginx`). Both classes implement the NGINX Ingress controller. When you create your Ingress resource, the Ingress class you specify determines if your apps are publicly or privately exposed.
{: shortdesc}

You can use a custom Ingress class by creating your own `IngressClass` resource. 
{: tip}


### Application Load Balancers (ALBs)
{: #managed-ingress-albs}

ALBs listen for incoming HTTP, HTTPS, or TCP service requests and then forward those requests to the appropriate app pod according to the rules you define in the Ingress resource. When you create a standard cluster with either classic or VPC infrastructure, one public and one private ALB is automatically created for you in each zone.
{: shortdesc}

#### ALBs in classic clusters
{: #managed-ingress-alb-classic}

When you create a classic cluster, one public and one private ALB is automatically created for you in each zone. Public and private ALBs in classic clusters are assigned a static IP address that does not change for the life of the cluster.
{: shortdesc}

Public ALBs share the same IBM-provided Ingress subdomain that is registered for you when you provision a cluster, and each public ALB's individual IP address is linked to this subdomain. To find a public ALB's IP address, run `ibmcloud ks ingress alb ls` and check the **ALB IP** field in the output.

Private ALBs in classic clusters do not use the IBM-provided Ingress subdomain and are not automatically enabled. You must first enable private ALBs in the CLI and then specify the `private-iks-k8s-nginx` class in your Ingress resource. After the private ALBs are enabled, you can find the private IP addresses by running `ibmcloud ks ingress alb ls` and checking the **ALB IP** field in the output.

If a public or private ALB pod is rescheduled, it keeps the same IP address. However, removing a zone with an ALB, or removing all workers on a VLAN in that zone, removes that ALB's IP address.

#### ALBs in VPC 
{: #managed-ingress-alb-vpc}

When you create a VPC cluster, one public and one private ALB is automatically created for you in each zone. In addition, one public VPC load balancer is automatically created outside of your cluster in your VPC. When you enable private ALBs in your VPC cluster, a private VPC load balancer is also created. 
{: shortdesc}

IP addresses for ALBs in VPC clusters are not static and might change over time, therefore the VPC load balancers put the public or private IP address of your ALBs behind a static hostname. Separate hostnames are applied for public or private ALBs. Note that the ALB hostname is separate from the cluster's Ingress subdomain.

To find the hostname of an ALB in a VPC cluster, run `ibmcloud ks ingress alb ls`. Private hostnames are only listed if private ALBs are enabled.

#### Worker node requirements for ALBs
{: #managed-ingress-albs-reqs}

At least two worker nodes are required per zone in your cluster for ALBs to function with high availability and to receive periodic updates. Anti-affinity rules on ALB pods ensure that only one pod is scheduled to each worker node. When automatic updates are applied to ALB pods, the pod is reloaded. If you only have one worker node, and therefore one ALB pod, the pod does not automatically update to avoid traffic interruptions, and updates only apply when you manually delete the pod and reschedule a new one. Having at least two worker nodes per zone avoids this scenario. 
{: shortdesc}

Note that if a zone fails, you might experience intermittent failures in requests to the Ingress ALB in that zone.

### Default TLS certificate
{: #managed-ingress-tls}

When you create a cluster, a default TLS certificate is created that you can use with the IBM-provided Ingress subdomain. You can specify the default TLS certificate, or a custom certificate that you provide, in the Ingress resource. 
{: shortdesc}

Consider using [{{site.data.keyword.secrets-manager_short}}](/docs/containers?topic=containers-secrets-mgr) to centrally manage and automatically update your Ingress subdomain certificates and other secrets.
{: tip}

Setting up Ingress with TLS certificates involves creating or importing secrets. If you want to use the IBM Cloud Ingress API to complete these steps, you must have a default {{site.data.keyword.secrets-manager_short}} instance. Otherwise, you can use `kubectl` commands to copy your certificates.
{: important}

## Getting started with Ingress
{: #managed-ingress-getstarted}

When you are ready to use Ingress in your cluster, [create an Ingress resource](/docs/containers?topic=containers-managed-ingress-setup) to configure your Ingress components, define rules for routing requests, and specify the path to app services. A separate Ingress resource is required for each namespace that contains an app or service that you want to expose.
{: shortdesc}

