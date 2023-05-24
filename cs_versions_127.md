---

copyright: 
  years: 2023, 2023
lastupdated: "2023-05-24"

keywords: kubernetes, containers, 127, version 127, 127 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.27 version information and update actions
{: #cs_versions_127}

Review information about version 1.27 of {{site.data.keyword.containerlong}}, released {{site.data.keyword.kubernetes_127_release_date}}.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}



For more information about Kubernetes project version 1.27, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}.

## Release timeline 
{: #release_timeline_127}

The following table includes the expected release timeline for version 1.27 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.27 | Yes | {{site.data.keyword.kubernetes_127_release_date}} | {{site.data.keyword.kubernetes_127_unsupported_date}}`†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.27" caption-side="bottom"}

## Preparing to update
{: #prep-up-127}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.27. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_127) for version 1.27. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

[Portworx](/docs/containers?topic=containers-storage_portworx_about) does not yet support version 1.27. Do not upgrade your cluster to version 1.27 if your apps use Portworx.
{: important}

[Cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) does not yet support version 1.27. Do not upgrade your cluster to version 1.27 if your cluster uses the cluster autoscaler.
{: important}

Gateway-enabled clusters on Classic infrastructure are deprecated and will be unsupported soon. The end of support dates are linked directly to the end of support of IBM Cloud Kubernetes Service version 1.26. Gateway-enabled clusters are not supported on version 1.27 and later. If your cluster is gateway-enabled, plan to create a new cluster before support ends. If you need similar functionality, consider creating a cluster on VPC infrastructure.
{: important}


### Update before master
{: #before_127}

The following table shows the actions that you must take before you update the Kubernetes master.



| Type | Description |
| --- | --- |
| **Unsupported:** Beta version of the `CSIStorageCapacity` API | Migrate manifests and API clients to use the `storage.k8s.io/v1` API version, available since Kubernetes version 1.24. For more information, see [Deprecated API Migration Guide - v1.27](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-27){: external}. | 
| **Unsupported:** Pod `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io` annotations | Kubernetes no longer supports the pod `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io` annotations. These annotations have been deprecated since Kubernetes version 1.19 and has been replaced by the `securityContext.seccompProfile` field for pods and containers. If your pods rely on these unsupported annotations, update them to use the `securityContext.seccompProfile` field instead. For more information, see [Create Pod that uses the container runtime default seccomp profile](https://kubernetes.io/docs/tutorials/security/seccomp/#create-pod-that-uses-the-container-runtime-default-seccomp-profile){: external}. |
| `k8s.gcr.io` redirect to `registry.k8s.io` | Kubernetes version 1.27 release artifacts are not published to the `k8s.gcr.io` registry. Futhermore, `k8s.gcr.io` registry traffic will be redirected to `registry.k8s.io`. For more information, see [k8s.gcr.io Redirect to registry.k8s.io - What You Need to Know](https://kubernetes.io/blog/2023/03/10/image-registry-redirect/){: external}. Note that IBM Cloud Kubernetes Service has already handled this migration action for all resources provided by IBM. |
| `kubelet` legacy iptables rules | `kubelet` no longer creates certain legacy iptables rules by default. It is possible that this will cause problems with some third-party components that improperly depended on those rules. For more information, see [Kubernetes’s IPTables Chains Are Not API](https://kubernetes.io/blog/2022/09/07/iptables-chains-not-api/){: external}. |

{: caption="Changes to make before you update the master to Kubernetes 1.27" caption-side="bottom"}






