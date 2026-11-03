---

copyright:
  years: 2026, 2026
lastupdated: "2026-11-03"


keywords: kubernetes, containers, 137, version 137, 137 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.37 version information and update actions
{: #cs_versions_137}


Review information about version 1.37 of {{site.data.keyword.containerlong}}. For more information about Kubernetes project version 1.37, see the [Kubernetes change log](https://kubernetes.io/releases/notes/){: external}.
{: shortdesc}



## Release timeline
{: #release_timeline_137}

The following table includes the expected release timeline for version 1.37 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported.
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.37 | Yes | {{site.data.keyword.kubernetes_137_release_date}} | {{site.data.keyword.kubernetes_137_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.37" caption-side="bottom"}


## Preparing to update
{: #prep-up-137}

For a complete list of changes that might impact your deployed apps when you update your cluster, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.37.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_137) for version 1.37. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

The [cluster autoscaler](/docs/containers?topic=containers-cluster-scaling-classic-vpc) does not yet support version 1.37. If your cluster uses the cluster autoscaler, do not update your cluster to version 1.37.
{: important}

### Update before master
{: #before-master-137}

Review the following changes that you must make before you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| --- | --- |
| **Action required:** SELinuxMount | The `SELinuxMount` feature gate graduates to GA and is enabled by default in version 1.37. The kubelet now mounts volumes with the Pod's SELinux label directly on the mount point instead of relying on recursive relabeling. On clusters with SELinux enforcing, workloads that share the same volume between Pods with different SELinux labels might fail to access the volume after the update. Before you update, audit your workloads by using the guidance in the [Kubernetes blog post](https://kubernetes.io/blog/2026/04/22/breaking-changes-in-selinux-volume-labeling/){: external}. Clusters that don't have SELinux enabled are not affected. |
| **Removed:** `scheduling.k8s.io/v1alpha2` API | The `scheduling.k8s.io` API group is promoted from `v1alpha2` to `v1alpha3`, and `v1alpha2` is dropped entirely. If your cluster uses Workload-Aware Scheduling resources such as `PodGroup` or `Workload` objects through the `v1alpha2` API, delete all `v1alpha2` objects before you update the master. |
| **Removed:** cAdvisor metrics | The following kubelet cAdvisor metrics are no longer exported from `/metrics/cadvisor`: `container_cpu_load_average_10s`, `container_cpu_load_d_average_10s`, and `container_tasks_state`. The `userDefinedMetrics` field in `/stats/summary` and the `container_application_*` metric families are also removed. If you use custom monitoring dashboards or alerting rules that reference these metric names, update them before you update your cluster. |
| **Removed:** `apiserver_cache_list_*` metrics | The API server metrics `apiserver_cache_list_total`, `apiserver_cache_list_fetched_objects_total`, and `apiserver_cache_list_returned_objects_total` are no longer exposed. Before you update your cluster, migrate any dashboards or alerts to `apiserver_storage_list_total{storage="watchcache"}`, `apiserver_storage_list_fetched_objects_total{storage="watchcache"}`, and `apiserver_storage_list_returned_objects_total{storage="watchcache"}`. |
| **Changed:** Admission webhooks no longer called for virtual resources | Admission webhooks are no longer invoked for virtual authentication and authorization resources such as `tokenreviews`, `subjectaccessreviews`, and `selfsubjectreviews`. If you have a `ValidatingWebhookConfiguration` or `MutatingWebhookConfiguration` that intercepts these resources, for example for audit or policy enforcement, it silently stops receiving those calls after you update the master. Review and update your webhook configurations. |
{: caption="Changes to make before you update the master to Kubernetes 1.37" caption-side="bottom"}

### Update after master
{: #after-master-137}

Review the following changes that you must make after you update the Kubernetes master.
{: shortdesc}

| Type | Description |
| --- | --- |
| **Not yet supported:** `metrics.k8s.io/v1` API | The Metrics API graduates from `v1beta1` to `v1` in Kubernetes version 1.37, as described in the [Kubernetes blog post](https://kubernetes.io/blog/2026/08/27/kubernetes-v1-37-metrics-api-ga/){: external}. {{site.data.keyword.containerlong_notm}} does not yet support the `v1` endpoint because full support is pending an upstream metrics-server release. The `v1beta1` endpoint continues to work without interruption. |
| **Changed:** `MaxUnavailableStatefulSet` enabled by default | The `MaxUnavailableStatefulSet` feature is now enabled by default. StatefulSet rolling updates can now proceed with more than one Pod unavailable at a time when `maxUnavailable` is set. If your workloads assume one-at-a-time StatefulSet rollout behavior, review your `updateStrategy` configuration after you update. |
| **Changed:** HPA scale to and from zero | HorizontalPodAutoscaler (HPA) can now scale workloads to zero replicas, and back, by default. HPAs that previously could not scale below one replica might now scale to zero under low-load conditions. If you require a minimum of one running replica at all times, review your HPA `minReplicas` settings. |
| **Changed:** Sidecar container ephemeral-storage limits now enforced | The kubelet now enforces `ephemeral-storage` resource limits on restartable init containers (sidecars). Pods with sidecar containers that previously exceeded their declared `ephemeral-storage` limit without being stopped are evicted after you update the worker nodes. Audit sidecar container resource declarations and increase limits where needed. |
| **Changed:** MemoryQoS throttling no longer applied by default | The `memoryThrottlingFactor` field in the kubelet configuration now defaults to `nil`, which means that cgroup v2 `memory.high` soft throttling is no longer applied by default on nodes that have cgroup v2 enabled. Workloads that were previously soft-throttled before they reached their memory limit might now consume memory up to the hard limit before they are OOM-killed. Review memory requests and limits for memory-intensive workloads on cgroup v2 nodes. |
| **Changed:** Earlier pod eviction on nodes with hugepages | The kubelet now correctly excludes hugepage-reserved memory from available memory calculations. On nodes that have hugepages configured, pods are evicted earlier than before because the node reports less available memory. If you run workloads on hugepage-enabled nodes, such as DPDK, database, or HPC workloads, review memory requests and limits to avoid unexpected evictions. You can disable the `HugepageAwareEviction` feature gate, which is enabled by default, to restore the previous behavior. |
| **Changed:** `kubectl get crd` output columns | The default output of `kubectl get crd` now includes the additional columns `GROUP`, `SCOPE`, `VERSIONS`, and `CREATED AT`. Scripts or CI pipelines that parse `kubectl get crd` output by column position produce incorrect results. For reliable programmatic parsing, use `-o json` or `-o jsonpath`. |
| **Changed:** `kubectl cluster-info dump` file permissions | The `kubectl cluster-info dump --output-directory` command now creates files with mode `0600` and directories with mode `0700`. Automation or CI pipelines that run the dump as one OS user and then read the output as a different user receive permission denied errors. Update your tooling to run as the same user, or explicitly change the permissions after the dump. |
| **Changed:** containerd runtime updated to version 2.3 | The containerd runtime on worker nodes is updated from [version 2.2.9](https://github.com/containerd/containerd/releases/tag/v2.2.9){: external} to [version 2.3.6](https://github.com/containerd/containerd/releases/tag/v2.3.6){: external}. Review the [containerd version 2.3 release notes](https://github.com/containerd/containerd/releases/tag/v2.3.6){: external} for any changes that might affect your workloads. |
{: caption="Changes to make after you update the master to Kubernetes 1.37" caption-side="bottom"}
