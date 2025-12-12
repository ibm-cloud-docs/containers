---

copyright: 
  years: 2025, 2025
lastupdated: "2025-12-12"


keywords: kubernetes, containers, 134, version 134, 134 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.34 version information and update actions
{: #cs_versions_134}


Review information about version 1.34 of {{site.data.keyword.containerlong}}. For more information about Kubernetes project version 1.34, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}.
{: shortdesc}


![This badge indicates Kubernetes version 1.34 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Kubernetes version 1.34 certification badge" caption-side="bottom"} 

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.34 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._



## Release timeline 
{: #release_timeline_134}

The following table includes the expected release timeline for version 1.34 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.34 | Yes | {{site.data.keyword.kubernetes_134_release_date}} | {{site.data.keyword.kubernetes_134_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.34" caption-side="bottom"}


## Preparing to update
{: #prep-up-134}

This information summarizes updates that are likely to have an impact on deployed apps when you update a cluster to version 1.34. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.34.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_134) for version 1.34. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

[Cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) does not yet support version 1.34. Do not upgrade your cluster to version 1.34 if your cluster uses cluster autoscaler.
{: important}

[Portworx](/docs/containers?topic=containers-storage_portworx_about) does not yet support version 1.34. Do not upgrade your cluster to version 1.34 if your apps use Portworx.
{: important}

### Update before master
{: #before_134}

The following table shows the actions that you must take before you update the Kubernetes master.

| Type | Description |
| --- | --- |
| **Action Required**: DRA Label Update | If you are using Dynamic Resource Allocation (DRA) with admin access, the label `resource.k8s.io/admin-access` has been renamed to `resource.kubernetes.io/admin-access`. Before upgrading, apply the new label `resource.kubernetes.io/admin-access=true` to any namespaces that currently have the old label. You can keep both labels during the upgrade and remove the old one afterwards. |
| **Action Required**: DRA Drivers |DRA drivers using the v1alpha3 or v1alpha4 APIs will stop working. Ensure your DRA drivers are updated to versions supporting the v1 (or v1beta1) API before upgrading the master. |
{: caption="Changes to make before you update the master to Kubernetes 1.34" caption-side="bottom"}


### Update after master
{: #after_134}

The following table shows the actions that you must take after you update the Kubernetes master.


| Type | Description |
| --- | --- |
| **Deprecated**: Deprecated `MessageCountMap` and `CreateAggregateFromMessageCountMap` from `apimachinery/pkg/util/errors` package. | Use `errors.Join` instead. For more information, see [`apimachinery/pkg/util/errors`](https://github.com/kubernetes/kubernetes/issues/131726){: external} |
| **Deprecated**: Deprecated the preferences field in kubeconfig in favor of kuberc. | No specific action required. For more information, see [Separate kubectl user preferences from cluster configs](https://github.com/kubernetes/enhancements/issues/3104){: external} |
{: caption="Changes to make after you update the master to Kubernetes 1.34" caption-side="bottom"}
