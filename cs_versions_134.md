---

copyright: 
  years: 2025, 2026
lastupdated: "2026-01-13"


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

[Portworx](/docs/containers?topic=containers-storage_portworx_about) does not yet support version 1.34. Do not upgrade your cluster to version 1.34 if your apps use Portworx.
{: important}


[CoreDNS](/docs/containers?topic=containers-cluster_dns) The default DNS cache time in both CoreDNS and NodeLocal DNS configurations has been increased from 30 seconds to 120 seconds.
{: important}

Istio add-on version 1.25 is not supported for IBM Cloud Kubernetes Service version 1.34 because the Istio add-on does not support Istio 1.28. Do not update to IBM Cloud Kubernetes Service version 1.34 if you use the add-on in your cluster. As an alternative, you can [migrate from the Istio add-on to community Istio](/docs/containers?topic=containers-istio&interface=ui#migrate).
{: important}

### Update before master
{: #before_134}

The following table shows the actions that you must take before you update the Kubernetes master.

| Type | Description |
| --- | --- |
| **Cluster autoscaler**: Only version 2.0.0 and later of the [cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) is supported in version 1.34. | Upgrade your cluster autoscaler to at least version 2.0.0 before updating your cluster to version 1.34. |
| **Pod Topology Spread**: The implementation of `matchLabelKeys` in `topologySpreadConstraints` now merges into `labelSelector`. | Do not upgrade directly from v1.32 to v1.34 if using this feature; upgrade to v1.33 first. Ensure pods created at v1.32 using `matchLabelKeys` are scheduled or removed before upgrading to v1.34. |
| **Pod Security Admission**: The `baseline` and `restricted` policies now block the `.host` field in probes and lifecycle handlers (e.g., `livenessProbe`, `httpGet`). | Remove `.host` from your pod configurations if using these policies. |
| **AppArmor**: AppArmor profiles in `SecurityContext` are no longer synced to the deprecated `container.apparmor.security.beta.kubernetes.io/` annotations. | Update tools to read from `SecurityContext`. |
| **Leader Election**: The `endpoint-controller` and `workload-leader-election` FlowSchemas were removed. | Workloads relying on `configmapsleases` or `endpointsleases` for leader election must migrate to the `leases` lock type. |
| **Metrics**: `apiserver_cache_list_fetched_objects_total`, `apiserver_cache_list_returned_objects_total`, `apiserver_cache_list_total` | Replace `resource_prefix` label with API `group` and `resource` labels. |
| **Metrics**: `apiserver_selfrequest_total` | Add a API `group` label. |
| **Metrics**: `apiserver_watch_events_sizes` and `apiserver_watch_events_total` | Replace API `kind` label with `resource` label. |
| **Metrics**: `apiserver_request_body_size_bytes`, `apiserver_storage_events_received_total`, `apiserver_storage_list_evaluated_objects_total`, `apiserver_storage_list_fetched_objects_total`, `apiserver_storage_list_returned_objects_total`, `apiserver_storage_list_total`, `apiserver_watch_cache_events_dispatched_total`, `apiserver_watch_cache_events_received_total`, `apiserver_watch_cache_initializations_total`, `apiserver_watch_cache_resource_version`, `watch_cache_capacity`, `apiserver_init_events_total`, `apiserver_terminated_watchers_total`, `watch_cache_capacity_increase_total`, `watch_cache_capacity_decrease_total`, `apiserver_watch_cache_read_wait_seconds`, `apiserver_watch_cache_consistent_read_total`, `apiserver_storage_consistency_checks_total`, `etcd_bookmark_counts`, `storage_decode_errors_total` | Extract the API group from `resource` label and put it in new `group` label. For more information, see [#131845](https://github.com/kubernetes/kubernetes/pull/131845) SIG API Machinery, Etcd, Instrumentation and Testing. |
| **Containerd 2.0 Docker Schema 1**: Docker Schema 1 image format (application/vnd.docker.distribution.manifest.v1+prettyjws) is no longer supported by default. | Ensure your images are Docker Schema 2 or OCI compliant. |
| **Containerd 2.0 - CRI API**: The CRI v1alpha2 API has been removed. | Ensure Kubernetes components and tools interacting with containerd are using the CRI v1 API. |
| **Containerd 2.0 - Runtimes**: Runtime V1 and Runc V1 shims have been removed. | Verify your workloads are compatible with containerd's Runtime V2 shims. |
| **Containerd 2.0 Unprivileged Ports and ICMP**: Unprivileged ports and ICMP are now enabled by default. | Review your application security contexts and remove additional capabilities or sysctls (like `NET_BIND_SERVICE` or `net.ipv4.ping_group_range`) that were previously required for these features. Consult the [upstream changelogs](https://github.com/containerd/containerd/blob/main/docs/containerd-2.0.md#unprivileged-ports-and-icmp-by-default-for-cri) for the details. |
{: caption="Changes to make before you update the master to Kubernetes 1.34" caption-side="bottom"}


### Update after master
{: #after_134}

No actions required.
