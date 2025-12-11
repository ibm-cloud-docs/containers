---

copyright:
  years: 2025, 2025

lastupdated: "2025-12-11"


keywords: change log, version history, 1.34

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# 1.34 version change log
{: #changelog_134}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run this version. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_134}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.34
{: #134_components}


### Worker node fix pack 1.34.1_1531, released 03 December 2025
{: #cl-boms-1341_1531_W}

The following table shows the components included in the worker node fix pack 1.34.1_1531. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU 24|6.8.0-87-generic|Resolves the following CVEs: [CVE-2025-37838](https://nvd.nist.gov/vuln/detail/CVE-2025-37838){: external}, [CVE-2025-38118](https://nvd.nist.gov/vuln/detail/CVE-2025-38118){: external}, [CVE-2025-38352](https://nvd.nist.gov/vuln/detail/CVE-2025-38352){: external}, [CVE-2025-40300](https://nvd.nist.gov/vuln/detail/CVE-2025-40300){: external}, [CVE-2025-6075](https://nvd.nist.gov/vuln/detail/CVE-2025-6075){: external}, and [CVE-2025-8291](https://nvd.nist.gov/vuln/detail/CVE-2025-8291){: external}.|
|Kubernetes|1.34.1|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.1).|
|containerd|2.2.0|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.2.0).|
|HAProxy|03b74b82b63cd53403b6b587b84233c93edef18d|Resolves the following CVEs: [CVE-2025-59375](https://nvd.nist.gov/vuln/detail/CVE-2025-59375){: external}, [CVE-2025-5372](https://nvd.nist.gov/vuln/detail/CVE-2025-5372){: external}, [CVE-2024-28757](https://nvd.nist.gov/vuln/detail/CVE-2024-28757){: external}, and [CVE-2022-23990](https://nvd.nist.gov/vuln/detail/CVE-2022-23990){: external}.|
|GPU Device Plug-in and Installer|184bbc2d05e029bb5b0c3c18798c10697e950967|Resolves the following CVEs: [CVE-2025-59375](https://nvd.nist.gov/vuln/detail/CVE-2025-59375){: external}.|
{: caption="1.34.1_1531 fix pack." caption-side="bottom"}
{: #cl-boms-1341_1531_W-component-table}


### Master fix pack 1.34.1_1529 and worker node fix pack 1.34.1_1530, released 20 November 2025
{: #1341_1529M_and_1341_1530W}

| Calico     | v3.29.5   | v3.29.6   | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#calico-open-source-3296-bug-fix-release).     |
| Cluster health control-plane operator     | v0.1.8    | v0.1.11   | <https://github.ibm.com/alchemy-containers/armada-health-operator/releases/tag/v0.1.11> |
| Cluster health image    | v1.6.10   | v1.6.13   | New version contains updates and security fixes. |
| containerd | 1.7.29    | 2.1.5     | For more information, see the [changelogs](https://github.com/containerd/containerd/releases/tag/v2.1.5). |
| CoreDNS    | v1.12.2   | v1.12.4   | See the [CoreDNS release notes](https://coredns.io/tags/notes/).      |
| etcd  | v3.5.22   | v3.5.24   | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.5.24).     |
| IBM Cloud Block Storage driver and plug-in   | v2.5.21   | v2.5.22   | New version contains updates and security fixes. |
| IBM Cloud Controller Manager | v1.33.5-1 | v1.34.1-6 | New version contains updates and security fixes. |
| IBM Cloud File Storage for Classic plug-in and monitor | 450  | 452  | New version contains updates and security fixes. |
| IBM Cloud Metrics Server Config Watcher   | v1.1.6    | v1.1.9    | New version contains updates and security fixes. |
| IBM Cloud RBAC Operator | 38dc95c   | 8a12251   | New version contains updates and security fixes. |
| Key Management Service provider      | v2.10.17  | 2.10.18   | New version contains updates and security fixes. |
| Kubernetes | 1.33.5    | 1.34.1    | For more information, see the [changelogs](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.1).   |
| Kubernetes Metrics Server    | v0.7.2    | v0.8.0    | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.8.0). |
| Kubernetes NodeLocal DNS cache  | 1.26.4    | 1.26.5    | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.26.5).    |
| Kubernetes snapshot controller  | v8.2.1    | v8.3.0    | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v8.3.0). |
| Portieris admission controller  | v0.13.30  | v0.13.31  | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.13.31)    |
| Tigera Operator | v1.36.13  | v1.36.14  | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.14).   |
{: caption="Changes since version 1.33." caption-side="bottom"}




