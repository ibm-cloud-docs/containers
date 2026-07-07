---
copyright:
  years: 2026, 2026
lastupdated: "2026-07-07"

keywords: ingress, alb, application load balancer, traefik, ingress controller, network traffic, exposing apps

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Traefik Ingress in {{site.data.keyword.cloud_notm}}
{: #managed-traefik-ingress-about}

Ingress exposes services in your cluster to a public or private network. It forwards requests to your apps and manages external access based on the routing rules that you configure.
{: shortdesc}

When you provision an {{site.data.keyword.containerlong_notm}} cluster, you can enable one or more Traefik-based Ingress controllers. {{site.data.keyword.IBM_notm}} provides the components that you need to use the Ingress controller. To define how the components work together, create Ingress resources.

For more information about Kubernetes Ingress, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external}.


## IBM-provided Ingress components
{: #traefik-managed-ingress-components}

When you create a cluster, {{site.data.keyword.IBM_notm}} provides the components that you need to use Ingress. In your Ingress resource, you specify how these components are used.

- Ingress domain
- Ingress class
- Application Load Balancers (ALBs)
- TLS certificate


### Ingress domain
{: #traefik-managed-ingress-subdomain}

The default Ingress domain forms a unique URL for each app in your cluster. This domain is referenced by the IP addresses of any ALBs in your cluster.

When you create a cluster, a unique Ingress subdomain is automatically created and registered as the default domain. You can [change the default domain](/docs/containers?topic=containers-ingress-domains#ingress-domain-manage-default) to any domain that exists in your cluster.

Private ALBs do not reference the IBM-provided Ingress subdomain and instead require a [custom domain](/docs/containers?topic=containers-managed-traefik-ingress-setup#ingress-custom-domain).
{: note}

You can also [create or add your own domain](/docs/containers?topic=containers-ingress-domains) registered with {{site.data.keyword.cloud_notm}}'s internal domain provider or with an {{site.data.keyword.cis_full_notm}} external provider.
{: tip}

The subdomain is registered in the following format.

```sh
<cluster_name>.<globally_unique_account_HASH>-0000.<region>.containers.appdomain.cloud
```
{: screen}

The following table describes each part of the subdomain.

| Subdomain component | Description |
| ------------------- | ----------- |
| `*` | The wildcard for the subdomain is registered by default for your cluster. |
| `<cluster_name>` | The name of your cluster. \n - If the cluster name is 26 characters or fewer and the cluster name is unique in this region, the full cluster name is used: `myclustername`. \n - If the cluster name is 26 characters or fewer and another cluster with the same name exists in this region, the full cluster name is used and a dash plus six random characters is added: `myclustername-ABC123`. \n - If the cluster name is 26 characters or more and the cluster name is unique in this region, only the first 24 characters are used: `myveryverylongclusternam`. \n - If the cluster name is 26 characters or more and another cluster with the same name exists in this region, only the first 17 characters are used and a dash plus six random characters is added: `myveryverylongclu-ABC123`. |
| `<globally_unique_account_HASH>` | A globally unique hash is created for your {{site.data.keyword.cloud_notm}} account. All subdomains that you create for NLBs in clusters in your account use this hash. |
| `0000` | Acts as a counter for each subdomain that is created in your cluster. |
| `<region>` | The region where the cluster is created. |
| `containers.appdomain.cloud` | The subdomain for {{site.data.keyword.containerlong_notm}} subdomains. |
{: caption="Understanding the Ingress subdomain format" caption-side="bottom"}

To form a unique URL for each app, the paths to your app services are appended to the public route. For example, see the following app URL.

```sh
mycluster-a1b2cdef345678g9hi012j3kl4567890-0000.us-south.containers.appdomain.cloud/myapp1
```
{: screen}

### Ingress class
{: #traefik-managed-ingress-class}

The Ingress class determines the type of Ingress controller that is used. {{site.data.keyword.IBM_notm}} provides two Ingress classes: one public (`public-iks-traefik`) and one private (`private-iks-traefik`). Both classes implement the Traefik Ingress controller. When you create your Ingress resource, the Ingress class that you specify determines whether your apps are publicly or privately exposed.

You can use a custom Ingress class by configuring `ingressClass` in the [customizable deployment config](/docs/containers?topic=containers-traefik-ingress-customization#create-ingress-configmap-custom).
{: tip}


### Application Load Balancers (ALBs)
{: #traefik-managed-ingress-albs}

ALBs listen for incoming HTTP, HTTPS, or TCP service requests and forward those requests to the appropriate app pod according to the rules that you define in the Ingress resource.

When you create a standard cluster with either classic or VPC infrastructure, one public and one private ALB are automatically created for you in each zone.

#### ALBs in classic clusters
{: #traefik-managed-ingress-alb-classic}

When you create a classic cluster, one public and one private ALB are automatically created for you in each zone. Public and private ALBs in classic clusters are assigned a static IP address that does not change for the life of the cluster.

Public ALBs share the same IBM-provided Ingress subdomain that is registered for you when you provision a cluster, and each public ALB's individual IP address is linked to this subdomain. To find a public ALB's IP address, run `ibmcloud ks ingress alb ls` and check the **ALB IP** field in the output.

Private ALBs in classic clusters do not use the IBM-provided Ingress subdomain and are not automatically enabled. You must first enable private ALBs in the CLI and then specify the `private-iks-traefik` class in your Ingress resource. After the private ALBs are enabled, you can find the private IP addresses by running `ibmcloud ks ingress alb ls` and checking the **ALB IP** field in the output.

If a public or private ALB pod is rescheduled, it keeps the same IP address. However, removing a zone with an ALB, or removing all workers on a VLAN in that zone, removes that ALB's IP address.

#### ALBs in VPC
{: #traefik-managed-ingress-alb-vpc}

When you create a VPC cluster, one public and one private ALB are automatically created for you in each zone. In addition, one public VPC load balancer is automatically created outside of your cluster in your VPC. When you enable private ALBs in your VPC cluster, a private VPC load balancer is also created.

IP addresses for ALBs in VPC clusters are not static and might change over time. Therefore, the VPC load balancers place the public or private IP address of your ALBs behind a static hostname. Separate hostnames are applied for public and private ALBs. The ALB hostname is separate from the cluster's Ingress subdomain.

To find the hostname of an ALB in a VPC cluster, run `ibmcloud ks ingress alb ls`. Private hostnames are only listed if private ALBs are enabled.

#### Worker node requirements for ALBs
{: #managed-traefik-ingress-albs-reqs}

At least two worker nodes are required per zone in your cluster for ALBs to function with high availability and receive periodic updates.

Anti-affinity rules on ALB pods ensure that only one pod is scheduled to each worker node. When automatic updates are applied to ALB pods, the pod is reloaded.

If you have only one worker node, and therefore one ALB pod, the pod does not automatically update to avoid traffic interruptions. In that case, updates are applied only when you manually delete the pod and reschedule a new one. Having at least two worker nodes per zone avoids this scenario.

Note that if a zone fails, you might experience intermittent failures in requests to the Ingress ALB in that zone.

### Default TLS certificate
{: #traefik-managed-ingress-tls}

When you create a cluster, a default TLS certificate is created that you can use with the IBM-provided Ingress subdomain. You can specify either the default TLS certificate or a custom certificate that you provide in the Ingress resource.

Consider using [{{site.data.keyword.secrets-manager_short}}](/docs/containers?topic=containers-secrets-mgr) to centrally manage and automatically update your Ingress subdomain certificates and other secrets.
{: tip}

Setting up Ingress with TLS certificates involves creating or importing secrets. If you want to use the IBM Cloud Ingress API to complete these steps, you must have a default {{site.data.keyword.secrets-manager_short}} instance. Otherwise, you can use `kubectl` commands to copy your certificates.
{: important}

## Getting started with Ingress
{: #traefik-managed-ingress-getstarted}

When you are ready to use Ingress in your cluster, [create an Ingress resource](/docs/containers?topic=containers-managed-traefik-ingress-setup) to configure your Ingress components, define rules for routing requests, and specify the path to app services. A separate Ingress resource is required for each namespace that contains an app or service that you want to expose.
