---

copyright:
  years: 2014, 2024
lastupdated: "2024-06-20"


keywords: kubernetes, 1.23, versions, update, upgrade

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# 1.23 version information and update actions
{: #cs_versions_123}



This version is no longer supported. Update your cluster to a [supported version](/docs/containers?topic=containers-cs_versions) as soon as possible.
{: important}



Review information about version 1.23.
{: shortdesc}

![This badge indicates Kubernetes version 1.23 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Figure 1. Kubernetes version 1.23 certification badge" caption-side="bottom"}

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.23 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._

For more information about Kubernetes project version 1.23, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}

## Release timeline 
{: #release_timeline_123}

The following table includes the expected release timeline for version 1.23 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

|  Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.23 | Yes | 09 Feb 2022 |  08 May 2023 `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.23" caption-side="bottom"}

## Preparing to update
{: #prep-up-123}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.23. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_123) for version 1.23. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}


### Update before master
{: #123_before_123}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| **Unsupported:** CoreDNS wildcard queries via Kubernetes plugin | CoreDNS no longer supports wildcard DNS queries via the Kubernetes plugin. Applications using such queries must be updated to use an alternative DNS query method.|
| Kubernetes service IP advertisement over BGP | If you are using Calico's [Kubernetes Service IP Advertisement over BGP feature](https://www.tigera.io/blog/advertising-kubernetes-service-ips-with-calico-and-bgp/){: external}, you need to [add the service IP CIDRs that you want to advertise to the default BGP configuration resource](https://docs.tigera.io/archive/v3.21/reference/resources/bgpconfig){: external}. In previous releases, the entire service IP range was advertised by setting an environment variable in the `calico-node` daemonset. |
{: caption="Changes to make after you update the master to Kubernetes 1.23" caption-side="bottom"}



### Update after master
{: #123_after_123}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| Operator Lifecycle Manager (OLM) install no longer managed | OLM is no longer installed nor managed by IBM. Existing installs are unchanged and no longer managed after the update. If you are using the OLM components then you must manage updates. If unused, you might [uninstall the OLM components](/docs/containers?topic=containers-ts-delete-olm). Refer to the [open source documentation](https://olm.operatorframework.io/){: external} for information on available resources including how to install a new instance of OLM on your cluster. |
| Recreate volume snapshots | Volume snapshots must be recreated after the update. Run `kubectl get volumesnapshots -A` to get a list of volume snapshots. |
{: caption="Changes to make after you update the master to Kubernetes 1.23" caption-side="bottom"}




