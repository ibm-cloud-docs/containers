---

copyright: 
  years: 2022, 2022
lastupdated: "2022-11-15"

keywords: kubernetes, containers, 125, version 125, 125 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# 1.25 version information and update actions
{: #cs_versions_125}

Review information about version 1.25 of {{site.data.keyword.containerlong}}, released 03 October 2022.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}



![This badge indicates Kubernetes version 1.25 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Figure 1. Kubernetes version 1.25 certification badge" caption-side="bottom"} 

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.25 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._





For more information about Kubernetes project version 1.25, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}

## Release timeline 
{: #release_timeline_125}

The following table includes the expected release timeline for version 1.25 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.25 | Yes | 06 October 2022 | 13 December 2023 |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.25" caption-side="bottom"}

## Preparing to update
{: #prep-up-125}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.25. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_125) for version 1.25. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}

### Update before master
{: #before_125}

The following table shows the actions that you must take before you update the Kubernetes master.

[Pod security policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external} have been removed in Kubernetes version 1.25.  See the Kubernetes [Deprecated API migration guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#psp-v125){: external} for more information. Customers will have the option to replace Pod Security Policies with [Pod security admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){: external} or a [third party admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external}. For more information, see  [Migrating from PSPs to Pod Security Admission](/docs/containers?topic=containers-pod-security-admission-migration). Note that {{site.data.keyword.containerlong_notm}} will make a beta version of Pod Security available in version 1.24 to aid in the migration, but this support is not yet available.
{: important}


| Type | Description|
| --- | --- |
| **Unsupported:** Beta version of the `CronJob` API | Migrate manifests and API clients to use the `batch/v1` API version, available since Kubernetes version 1.21. For more information, see [Deprecated API Migration Guide - v1.25](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25){: external}. |
| **Unsupported:** Beta version of the `EndpointSlice` API | Migrate manifests and API clients to use the `discovery.k8s.io/v1` API version, available since Kubernetes version 1.21. For more information, see [Deprecated API Migration Guide - v1.25](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25){: external}. |
| **Unsupported:** Beta version of the `Event` API | Migrate manifests and API clients to use the `events.k8s.io/v1` API version, available since Kubernetes version 1.19. For more information, see [Deprecated API Migration Guide - v1.25](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25){: external}. |
| **Unsupported:** Beta version of the `HorizontalPodAutoscaler` API | Migrate manifests and API clients to use the `autoscaling/v2` API version, available since Kubernetes version 1.23. For more information, see [Deprecated API Migration Guide - v1.25](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25){: external}. |
| **Unsupported:** Beta version of the `PodDisruptionBudget` API | Migrate manifests and API clients to use the `policy/v1` API version, available since Kubernetes version 1.21. For more information, see [Deprecated API Migration Guide - v1.25](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25){: external}. |
| **Unsupported:** Beta version of the `RuntimeClass` API | Migrate manifests and API clients to use the `node.k8s.io/v1` API version, available since Kubernetes version 1.20. For more information, see [Deprecated API Migration Guide - v1.25](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25){: external}. |
| **Unsupported:** Pod Security Policies | [Pod Security Policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external} have been removed in Kubernetes version 1.25. See the Kubernetes [Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#psp-v125){: external} for more information. {{site.data.keyword.containerlong_notm}} version 1.25 now configures [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){: external} and no longer supports [Pod Security Policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}.  |
| **Unsupported:** Pod `kubectl.kubernetes.io/default-logs-container` annotation | Pods no longer support the `kubectl.kubernetes.io/default-logs-container` annotation. This annotation has been replaced by the `kubectl.kubernetes.io/default-container` annotation. If your pods rely on the unsupported annotation, update them to use the `kubectl.kubernetes.io/default-container` annotation instead. For more information, see [Well-Known Labels, Annotations and Taints](https://kubernetes.io/docs/reference/labels-annotations-taints/){: external}. |
| **Unsupported:** Pod `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io` annotations | Kubernetes no longer fully supports the pod `seccomp.security.alpha.kubernetes.io/pod` and `container.seccomp.security.alpha.kubernetes.io` annotations. These annotations have been deprecated since Kubernetes version 1.19 and has been replaced by the `securityContext.seccompProfile` field for pods and containers. All remaining support for these annotations is planned to be removed in Kubernetes version 1.27. If your pods rely on these unsupported annotations, update them to use the `securityContext.seccompProfile` field instead. For more information, see [Restrict a Container's Syscalls with seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/){: external}. |
| **Unsupported:** Select Kubernetes API server metrics removed | The following Kubernetes API service metrics were removed: `priority_level_seat_count_watermarks`, `priority_level_request_count_watermarks` and `read_vs_write_request_count_watermarks`. If you rely on these removed metrics, update accordingly. |
| **Unsupported:** Select Kubernetes API server metrics replaced | The following Kubernetes API service metrics were replaced: `priority_level_seat_count_samples` is replaced by `priority_level_seat_utilization`, `priority_level_request_count_samples` is replaced by `priority_level_request_utilization` and `read_vs_write_request_count_samples` is replaced by `read_vs_write_current_requests`. If you rely on these replaced metrics, update accordingly. |
| Service account tokens are not automatically generated | The `LegacyServiceAccountTokenNoAutoGeneration` feature gate has been enabled. As a result, secrets containing service account tokens are no longer automatically generated. Use the `TokenRequest` API to acquire service account tokens. Or if a non-expiring service account token is required, follow the [Service account token Secrets guide](https://kubernetes.io/docs/concepts/configuration/secret/#service-account-token-secrets){: external} to create one. During an upgrade to IKS version 1.25, existing service account token secrets remain in the cluster and continue to function as expected. |
| Application updates required for `natPortRange` changes. | Updates might be required if your app makes a lot of egress network connections from `pod-network` pods out to something external to the cluster. For example, if your app or has either 30,000+ of egress connections open on a single worker node at once, or opens over 30,000 egress connections on a single worker node within a few minutes of each other. For more information, see [Why am I running out of SNAT ports for egress connections from pods in my cluster?](/docs/containers?topic=containers-ts-network-snat-125). |
| Kubernetes CSI snapshot controller installed by default | {{site.data.keyword.containerlong_notm}} now installs and manages the [Kubernetes CSI snapshot controller](https://github.com/kubernetes-csi/external-snapshotter/releases){: external}. As a result, upgrade your storage drivers and plugins to versions that don't require installing their own version of the Kubernetes CSI snapshot controller. For example, see [Setting up snapshots with the Block Storage for VPC add-on](/docs/containers?topic=containers-vpc-volume-snapshot) for instructions to enable support for VPC block storage volume snapshots. You do not need to uninstall an existing [Kubernetes CSI snapshot controller](https://github.com/kubernetes-csi/external-snapshotter/releases){: external} install before the upgrade. However after the upgrade, {{site.data.keyword.containerlong_notm}} will take over management of the install. |
{: caption="Changes to make after you update the master to Kubernetes 1.25"}


### Update after master
{: #125_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| `kubectl diff` ignores managed fields by default | The `kubectl diff` command was changed to ignore managed fields by default. A new `--show-managed-fields` flag has been added to allow you to include managed fields in the diff. If your scripts rely on the previous behavior, update them. |
{: caption="Changes to make after you update the master to Kubernetes 1.25"}


