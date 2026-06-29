---
copyright:
  years: 2026, 2026
lastupdated: "2026-06-29"

keywords: ingress, alb, application load balancer, traefik, ingress controller, network traffic, exposing apps

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Traefik Ingress in {{site.data.keyword.cloud_notm}}
{: #managed-traefik-ingress-about}

Ingress is a Kubernetes service discovery method that exposes the services in your cluster to the public or private network by forwarding requests to your apps and balancing network traffic workloads. Ingress manages external access to your services based on a set of routing rules that you configure and that are applied to all incoming traffic.
{: shortdesc}

When you provision an {{site.data.keyword.containerlong_notm}} cluster, you have the ability to enable one or more Traefik-based Ingress controllers. IBM provides all the components required to use the Ingress controller, you only have to create Ingress resources to specify how these components work together.

For more information about Kubernetes Ingress, see the [Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/){: external}. 

## Preview
{: #managed-traefik-ingress-preview}

Traefik-based Ingress is currently in a Preview state. This page contains important notes regarding that.

Read more about our Preview announcement [in our Blog Post](https://community.ibm.com/community/user/blogs/marcell-punkosd/2026/04/29/introducing-traefik-ingress-controller-preview){: external}.

### DNS handling on Classic clusters
{: #managed-traefik-ingress-dns-classic}

On Classic clusters, enabling or disabling public ALB instances automatically adds the IP addresses for these ALBs to the cluster's default domain.

From now on, when you enable different types of ALBs (mixing Traefik with Ingress-NGINX), DNS records are not added. This prevents the undesired situation where different ALB types are mixed behind a single domain, which could cause hard-to-debug issues. No new IP addresses are registered while this mixed state persists. IP address removal still functions as before.

When the last instance of the different type is disabled (either Traefik or Ingress-NGINX), the remaining ALBs are automatically re-registered to restore the desired state, where all public ALB instances are registered behind the cluster's default subdomain.

### Default Ingress Class Handling
{: #managed-traefik-ingress-default-ingress-class}

The default Ingress Class is now reconciled on each ALB enable or disable events. If the default ingress class left on the IBM default setting, and not configured by the user, then it is automatically updated. 

If the cluster will only have Traefik based ALBs enabled, then the `public-iks-traefik` or `private-iks-traefik` will be made default, depending on if `public-iks-k8s-nginx` or `private-iks-k8s-nginx` was the previous default. Similarly, if only Ingress-NGINX based ALBs are being enabled on the cluster, then the default ingress class is changed back to the Ingress-NGINX one.

Custom ingress classes never made default automatically.
