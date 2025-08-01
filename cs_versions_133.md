---

copyright: 
  years: 2025, 2025
lastupdated: "2025-08-01"


keywords: kubernetes, containers, 133, version 133, 133 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.33 version information and update actions
{: #cs_versions_133}


Review information about version 1.33 of {{site.data.keyword.containerlong}}. For more information about Kubernetes project version 1.33, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}.
{: shortdesc}




## Release timeline 
{: #release_timeline_133}

The following table includes the expected release timeline for version 1.33 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.33 | Yes | {{site.data.keyword.kubernetes_133_release_date}} | {{site.data.keyword.kubernetes_133_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.33" caption-side="bottom"}


## Preparing to update
{: #prep-up-133}

This information summarizes updates that are likely to have an impact on deployed apps when you update a cluster to version 1.33. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.33.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_133) for version 1.33. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

[Cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) does not yet support version 1.33. Do not upgrade your cluster to version 1.33 if your cluster uses cluster autoscaler.
{: important}

[Portworx](https://cloud.ibm.com/docs/containers?topic=containers-storage_portworx_about) does not yet support version 1.33. Do not upgrade your cluster to version 1.33 if your apps use Portworx.
{: important}

The Istio add-on version 1.23 is not supported for {{site.data.keyword.containerlong_notm}} version 1.33 because the Istio add-on does not support Istio 1.25. Do not update to {{site.data.keyword.containerlong_notm}} version 1.33 if you use the add-on in your cluster. As an alternative, you can [migrate from the Istio add-on to community Istio](/docs/containers?topic=containers-istio&interface=ui#migrate).
{: important}

### Update before master
{: #before_133}

The following table shows the actions that you must take before you update the Kubernetes master.

| Type | Description |
| --- | --- |
| **Unsupported:** `gitRepo` volume driver | The `gitRepo` volume driver is not supported and cannot not be enabled via the `GitRepoVolumeDriver` feature gate. There are alternatives, such as using an `EmptyDir` volume mount with an `init` container to clone a repository by using `git`. For more information, see the [Removal of in-tree `gitRepo` volume driver](https://kubernetes.io/blog/2025/04/23/kubernetes-v1-33-release/#removal-of-in-tree-gitrepo-volume-driver). |
{: caption="Changes to make before you update the master to Kubernetes 1.33" caption-side="bottom"}


### Update after master
{: #after_133}

The following table shows the actions that you must take after you update the Kubernetes master.


| Type | Description |
| --- | --- |
| **Deprecated:** Service annotation `service.kubernetes.io/topology-mode` |  The service annotation `service.kubernetes.io/topology-mode` is deprecated and is not graduating from beta to GA. Migrate to the [service `.spec.trafficDistribution` field](https://kubernetes.io/docs/concepts/services-networking/service/#traffic-distribution) instead. This field is closely related to the `service.kubernetes.io/topology-mode` annotation and provides flexible options for traffic routing within Kubernetes. |
| **Deprecated:** `v1` version of the `Endpoints` API | The `v1` `Endpoints` API is deprecated. Migrate to the `discovery.k8s.io/v1` `EndpointSlice` API instead. For more information, see [Kubernetes v1.33: Continuing the transition from Endpoints to EndpointSlices](https://kubernetes.io/blog/2025/04/24/endpoints-deprecation/). |
{: caption="Changes to make after you update the master to Kubernetes 1.33" caption-side="bottom"}

