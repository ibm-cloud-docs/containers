---

copyright:
  years: 2025, 2025

lastupdated: "2025-08-22"


keywords: change log, version history, 1.33

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

<!-- The content in this topic is auto-generated except for reuse-snippets indicated with {[ ]}. -->


# 1.33 version change log
{: #changelog_133}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run this version. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_133}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.33
{: #133_components}


### Master fix pack 1.33.4_1537, released 20 August 2025
{: #1334_1537_M}

The following table shows the changes that are in the master fix pack 1.33.4_1537. Master patch updates are applied automatically. 


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| etcd | v3.5.21 | v3.5.22 | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.5.22){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.33.2-4 | v1.33.3-2 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.7 | v1.1.9 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 38dc95c | 8a12251 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.15 | v2.10.16 | New version contains updates and security fixes. |
| Kubernetes | v1.33.3 | v1.33.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.4){: external}. |
{: caption="Changes since version 1.33.3_1532" caption-side="bottom"}


### Worker node fix pack 1.33.3_1534, released 12 August 2025
{: #cl-boms-1333_1534_W}

The following table shows the components included in the worker node fix pack 1.33.3_1534. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-64-generic|Resolves the following CVEs: [CVE-2024-11584](https://nvd.nist.gov/vuln/detail/CVE-2024-11584){: external}, [CVE-2024-6174](https://nvd.nist.gov/vuln/detail/CVE-2024-6174){: external}, [CVE-2025-37797](https://nvd.nist.gov/vuln/detail/CVE-2025-37797){: external}, [CVE-2025-38083](https://nvd.nist.gov/vuln/detail/CVE-2025-38083){: external}, [CVE-2025-40909](https://nvd.nist.gov/vuln/detail/CVE-2025-40909){: external}, and [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}.|
|Kubernetes|1.33.3|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.3).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|3a9451f4782fa8e8e9ed60b060dc4393c7e1e31a|Resolves the following CVEs: [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}, [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}, and [CVE-2025-7425](https://nvd.nist.gov/vuln/detail/CVE-2025-7425){: external}.|
|GPU Device Plug-in and Installer|51c51a011ee21f6dcb8c8143b688c34412f58405|Resolves the following CVEs: [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}, [CVE-2025-7425](https://nvd.nist.gov/vuln/detail/CVE-2025-7425){: external}, [CVE-2024-47081](https://nvd.nist.gov/vuln/detail/CVE-2024-47081){: external}, [CVE-2025-5994](https://nvd.nist.gov/vuln/detail/CVE-2025-5994){: external}, [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}, and [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}.|
{: caption="1.33.3_1534 fix pack." caption-side="bottom"}
{: #cl-boms-1333_1534_W-component-table}


### Change log for master fix pack 1.33.3_1532 and worker node fix pack 1.33.3_1533, released 31 July 2025
{: #1333_1532M_and_1333_1533W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Cloud Controller Manager | v1.32.6-4 | v1.33.2-4 | New version contains updates and security fixes. |
| IBM Cloud Cluster Health Operator | N/A | v0.1.11 | **New:** Cluster health operator offers more detailed status reports for your cluster’s managed components. |
| Kubernetes | v1.32.7 | v1.33.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.3). |
| Kubernetes add-on resizer | 1.8.22 | 1.8.23 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.23). |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](https://cloud.ibm.com/docs/containers?topic=containers-service-settings). |
| Kubernetes Metrics Server | v0.7.2 | v0.8.0 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.8.0). |
| Kubernetes snapshot controller | v8.0.1 | v8.2.1 | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v8.2.1). |
{: caption="Changes since version 1.32." caption-side="bottom"}
