---

copyright: 
  years: 2024, 2025
lastupdated: "2025-04-28"


keywords: kubernetes, containers, 132, version 132, 132 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.32 version information and update actions
{: #cs_versions_132}


Review information about version 1.32 of {{site.data.keyword.containerlong}}. For more information about Kubernetes project version 1.32, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}.
{: shortdesc}


![This badge indicates Kubernetes version 1.32 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Kubernetes version 1.32 certification badge" caption-side="bottom"} 

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.32 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._


## Release timeline 
{: #release_timeline_132}

The following table includes the expected release timeline for version 1.32 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.32 | Yes | {{site.data.keyword.kubernetes_132_release_date}} | {{site.data.keyword.kubernetes_132_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.32" caption-side="bottom"}


## Preparing to update
{: #prep-up-132}

This information summarizes updates that are likely to have an impact on deployed apps when you update a cluster to version 1.32. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.32.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_132) for version 1.32. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

[Cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) does not yet support version 1.32. Do not upgrade your cluster to version 1.32 if your cluster uses cluster autoscaler.
{: important}

[Portworx](https://cloud.ibm.com/docs/containers?topic=containers-storage_portworx_about) does not yet support version 1.32. Do not upgrade your cluster to version 1.32 if your apps use Portworx.
{: important}

The Istio add-on version 1.23 is not supported for {{site.data.keyword.containerlong_notm}} version 1.32 because the Istio add-on does not support Istio 1.25. Do not update to {{site.data.keyword.containerlong_notm}} version 1.32 if you use the add-on in your cluster. As an alternative, you can [migrate from the Istio add-on to community Istio](/docs/containers?topic=containers-istio&interface=ui#migrate).
{: important}

### Update before master
{: #before_132}

The following table shows the actions that you must take before you update the Kubernetes master.

| Type | Description |
| --- | --- |
| **Unsupported:** `v1beta3` version of the `FlowSchema` and `PriorityLevelConfiguration` API | Migrate manifests and API clients to use the `flowcontrol.apiserver.k8s.io/v1` API version, which is available since Kubernetes version 1.29. For more information, see [Deprecated API Migration Guide - v1.32](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-32){: external}. |
| Calico API server namespace security | The `calico-apiserver` namespace is now a [restricted namespace](/docs/containers?topic=containers-pod-security-admission). This namespace should only contain system resources provided by IBM. If you installed resources to this namespace, then you must migrate the resources to a new namespace. |
{: caption="Changes to make before you update the master to Kubernetes 1.32" caption-side="bottom"}


### Update after master
{: #after_132}

The following table shows the actions that you must take after you update the Kubernetes master.

| Type | Description |
| --- | --- |
| Ubuntu 24 is the only supported operating system | Ubuntu 24 is now the only operating system supported for IBM Cloud Kubernetes version 1.32 clusters. Clusters  upgraded to version 1.32 with Ubuntu 20 worker nodes must migrate to Ubuntu 24 worker nodes after the master update. For more information and possible migration actions related to Ubuntu 24, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate). |
{: caption="Changes to make after you update the master to Kubernetes 1.32" caption-side="bottom"}
