---

copyright: 
  years: 2023, 2024
lastupdated: "2024-04-23"


keywords: kubernetes, containers, 126, version 126, 126 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.26 version information and update actions
{: #cs_versions_126}

Review information about version 1.26 of {{site.data.keyword.containerlong}}.
{: shortdesc}


Kubernetes version 1.26 is deprecated. Update your cluster to at least [version 1.27](/docs/containers?topic=containers-cs_versions_127) as soon as possible.
{: deprecated}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}



![This badge indicates Kubernetes version 1.26 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Figure 1. Kubernetes version 1.26 certification badge" caption-side="bottom"} 

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.26 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._


For more information about Kubernetes project version 1.26, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}

## Release timeline 
{: #release_timeline_126}

The following table includes the expected release timeline for version 1.26 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.26 | Yes | {{site.data.keyword.kubernetes_126_release_date}} | {{site.data.keyword.kubernetes_126_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.26" caption-side="bottom"}

## Preparing to update
{: #prep-up-126}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.26. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_126) for version 1.26. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}



### Update before master
{: #before_126}

The following table shows the actions that you must take before you update the Kubernetes master.
Initial [1.26 version information and update actions](/docs/containers?topic=containers-cs_versions_126)

When you upgrade your cluster to version 1.26, a [BGP password](https://docs.tigera.io/calico/latest/reference/resources/bgppeer#bgppassword){: external} is automatically configured for Calico. This results in a several second disruption to pod networking while the BGP password configuration is applied.
{: note}


| Type | Description |
| --- | --- |
| **Unsupported:** Beta version of the `FlowSchema` and `PriorityLevelConfiguration` API | Migrate manifests and API clients to use the `flowcontrol.apiserver.k8s.io/v1beta2` API version, available since Kubernetes version 1.23. For more information, see [Deprecated API Migration Guide - v1.26](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-26){: external}. | 
| **Unsupported:** Beta version of the `HorizontalPodAutoscaler` API | Migrate manifests and API clients to use the `autoscaling/v2` API version, available since Kubernetes version 1.23. For more information, see [Deprecated API Migration Guide - v1.26](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-26){: external}. | 
| **Unsupported:** Storage class `volume.beta.kubernetes.io/storage-class` beta resource annotation | Migrate manifests and API clients to use the `spec.storageClassName` field on the  `PersistentVolumeClaim` and `PersistentVolume` resources instead. |
| **Unsupported:** Select Kubernetes API server metrics replaced | The following Kubernetes API service metrics were replaced: `etcd_db_total_size_in_bytes` is replaced by `apiserver_storage_db_total_size_in_bytes`, `job_sync_total` is replaced by `job_syncs_total`, `job_finished_total` is replaced by `jobs_finished_total`, and `cronjob_job_creation_skew_duration_seconds` is replaced by `job_creation_skew_duration_seconds`.  If you rely on these replaced metrics, update accordingly. |
{: caption="Changes to make before you update the master to Kubernetes 1.26" caption-side="bottom"}

### Update after master
{: #anchor}

| Type | Description |
| --- | --- |
| **Unsupported:** `localhost` `NodePort` services | To further reduce security risks related to CVE-2020-8558, `localhost` access to `NodePort` services has been disabled. If you apps rely on this behavior, update them to the node private IP address instead. |
| **Unsupported:** Legacy `kubectl` options relating to logging | The following legacy `kubectl` logging options have been removed: `--log-dir`, `--log-file`, `--log-flush-frequency`, `--logtostderr`, `--alsologtostderr`, `--one-output`, `--stderrthreshold`, `--log-file-max-size`, `--skip-log-headers`, `--add-dir-header`, `--skip-header`, and `--log-backtrace-at`. If your scripts rely on these flags, update them accordingly. For more information, see [Removal of legacy command line arguments relating to logging](https://kubernetes.io/blog/2022/11/18/upcoming-changes-in-kubernetes-1-26/#removal-of-legacy-command-line-arguments-relating-to-logging){: external}. |
{: caption="Changes to make after you update the master to Kubernetes 1.26" caption-side="bottom"}



