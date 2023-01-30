---

copyright:
  years: 2014, 2023
lastupdated: "2023-01-30"

keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why does DNS resolution fail when CoreDNS pods are restarted?
{: #coredns_lameduck}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


Your app sometimes fails to resolve DNS names for cluster services around the same time that one or more CoreDNS pods are restarted, such as during a worker reload or patch update.
{: tsSymptoms}


Your app's DNS request was sent to a CoreDNS pod that was in the process of terminating.
{: tsCauses}


To help the CoreDNS pods terminate without disruption, you can edit the `coredns` configmap in the `kube-system` namespace.
{: tsResolve}

In the `health` plug-in configuration of the main Corefile, add `lameduck 10s`. For more information on customizing CoreDNS, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). The resulting customization looks like the following example.

```txt
health {
    lameduck 10s
}
```
{: screen}






