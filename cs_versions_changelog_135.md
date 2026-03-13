---

copyright:
  years: 2025, 2026

lastupdated: "2026-03-13"


keywords: change log, version history, 1.35

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# 1.35 version change log
{: #changelog_135}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run this version. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_135}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.35
{: #135_components}


### Worker node fix pack 1.35.1_1521, released 11 March 2026
{: #cl-boms-1351_1521_W}

The following table shows the components included in the worker node fix pack 1.35.1_1521. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU 24 (VPC)|6.8.0-100-generic|Resolves the following CVEs: [CVE-2025-10148](https://nvd.nist.gov/vuln/detail/CVE-2025-10148){: external}, [CVE-2025-14017](https://nvd.nist.gov/vuln/detail/CVE-2025-14017){: external}, [CVE-2025-14524](https://nvd.nist.gov/vuln/detail/CVE-2025-14524){: external}, [CVE-2025-14819](https://nvd.nist.gov/vuln/detail/CVE-2025-14819){: external}, [CVE-2025-15079](https://nvd.nist.gov/vuln/detail/CVE-2025-15079){: external}, [CVE-2025-15224](https://nvd.nist.gov/vuln/detail/CVE-2025-15224){: external}, [CVE-2025-22037](https://nvd.nist.gov/vuln/detail/CVE-2025-22037){: external}, [CVE-2025-37899](https://nvd.nist.gov/vuln/detail/CVE-2025-37899){: external}, and [CVE-2026-2781](https://nvd.nist.gov/vuln/detail/CVE-2026-2781){: external}.|
|UBUNTU 24 (Classic)|6.8.0-100-generic|Resolves the following CVEs: [CVE-2025-10148](https://nvd.nist.gov/vuln/detail/CVE-2025-10148){: external}, [CVE-2025-14017](https://nvd.nist.gov/vuln/detail/CVE-2025-14017){: external}, [CVE-2025-14524](https://nvd.nist.gov/vuln/detail/CVE-2025-14524){: external}, [CVE-2025-14819](https://nvd.nist.gov/vuln/detail/CVE-2025-14819){: external}, [CVE-2025-15079](https://nvd.nist.gov/vuln/detail/CVE-2025-15079){: external}, [CVE-2025-15224](https://nvd.nist.gov/vuln/detail/CVE-2025-15224){: external}, [CVE-2025-22037](https://nvd.nist.gov/vuln/detail/CVE-2025-22037){: external}, [CVE-2025-37899](https://nvd.nist.gov/vuln/detail/CVE-2025-37899){: external}, and [CVE-2026-2781](https://nvd.nist.gov/vuln/detail/CVE-2026-2781){: external}.|
|Kubernetes|1.35.1|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.35.1).|
|containerd|2.2.1|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.2.1).|
|HAProxy|965c403695b15b3410d87a3772002edbc5ed2569|Resolves the following CVEs: [CVE-2025-69419](https://nvd.nist.gov/vuln/detail/CVE-2025-69419){: external}.|
|GPU Device Plug-in and Installer|dc588cffda45a3831875a9236f7c34eb4aadb71c|Resolves the following CVEs: [CVE-2025-69419](https://nvd.nist.gov/vuln/detail/CVE-2025-69419){: external}.|
{: caption="1.35.1_1521 fix pack." caption-side="bottom"}
{: #cl-boms-1351_1521_W-component-table}


### Worker node fix pack 1.35.1_1520, released 5 March 2026
{: #cl-boms-1351_1520_W}

The following table shows the components included in the worker node fix pack 1.35.1_1520. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.29.6 | v3.30.6 | See the [Calico release notes](https://docs.tigera.io/calico/3.30/release-notes/#calico-open-source-3306-bug-fix-release){: external}. |
| Cluster health image | v1.6.10 | v1.6.14 | New version contains updates and security fixes. |
| CoreDNS | v1.12.2 | v1.12.4 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| etcd | v3.5.23 | v3.5.27 | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.5.27){: external}. |
| IBM Cloud Block Storage driver and plug-in | v2.5.20 | v2.5.24 | New version contains updates and security fixes. |
| IBM Cloud Controller Manager | v1.34.1-1 | v1.35.1-1 | New version contains updates and security fixes. |
| IBM Cloud File Storage for Classic plug-in and monitor | 452 | v453 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.17 | 2.10.21 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.33.0 | v0.34.0 | See the Konnectivity release notes. |
| Kubernetes | v1.34.3 | v1.35.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.35.1){: external}. |
| Kubernetes Metrics Server | v0.8.0 | v0.8.1 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.8.1){: external}. |
| Portieris admission controller | v0.13.30 | v0.13.35 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.13.35){: external} |
| Tigera Operator | v1.36.14 | v1.38.11 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.38.11){: external}. |
{: caption="1.34.3_1542 fix pack." caption-side="bottom"}
{: #cl-boms-1343_1542_W-component-table}
