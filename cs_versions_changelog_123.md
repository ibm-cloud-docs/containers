
---

copyright:
 years: 2014, 2022
lastupdated: "2022-02-28"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch, 1.23

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Kubernetes version 1.23 change log
{: #changelog_123}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} Kubernetes clusters that run version 1.23. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.23 change log
{: #123_changelog}

Review the version 1.23 changelog.
{: shortdesc}

### Change log for worker node fix pack 1.23.3_1519, released 14 February 2022
{: #1233_1519}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Kubernetes | N/A | 1.23.3 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.23.3){: external}. |
| HA proxy | d38fa1 | f6a2b3 | [CVE-2021-3521](https://nvd.nist.gov/vuln/detail/CVE-2021-3521){: external}   [CVE-2021-4122](https://nvd.nist.gov/vuln/detail/CVE-2021-4122){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.23.2_1517" caption-side="top"}

### Change log for master fix pack 1.23.3_1518 and worker node fix pack 1.23.2_1517, released 9 Feb 2022
{: #1233_1518_and_1232_1517}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.20.3 | v3.21.4 | For more information, see the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| Cluster health image | v1.2.21 | v1.3.0 | Added new health check for cluster autoscaler add-on. |
| CoreDNS | 1.8.6 | 1.8.7 | See the [CoreDNS release notes](https://coredns.io/2021/12/09/coredns-1.8.7-release/){: external}. |
| GPU device plug-in and installer | eefc4ae | 4a174aa | Updated image for [CVE-2020-26160](https://nvd.nist.gov/vuln/detail/CVE-2020-26160){: external} and [CVE-2021-3538](https://nvd.nist.gov/vuln/detail/CVE-2021-3538){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.6-1 | v1.23.3-4 | Updated to support the Kubernetes `1.23.3` release and to use `Go` version `1.17.6`.  Classic load balancers have been updated to improve availability during updates. In addition, creating a mixed protocol load balancer is not supported. |
| Kubernetes (master) | v1.22.6 | v1.23.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.23.3){: external}. |
| Kubernetes (worker node) | v1.22.6 | v1.23.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.23.2){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates){: external}. |
| Kubernetes CSI snapshotter CRDs | v4.0.0 | v4.2.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v4.2.1){: external}. |
| Kubernetes Dashboard | v2.3.1 | v2.4.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.4.0){: external}. |
| Kubernetes Metrics Server | v0.5.2 | v0.6.0 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.0){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.3 | 1.21.4 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.21.4){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-15 | None | Operator Lifecycle Manager is no longer installed nor managed by IBM. Existing installs are left as-is and no longer managed after an upgrade. |
| Operator Lifecycle Manager Catalog | v1.15.3 | None | Operator Lifecycle Manager is no longer installed nor managed by IBM. Existing installs are left as-is and no longer managed after an upgrade. |
| Pause container image | 3.5 | 3.6 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.22.6_1537 (master) and 1.22.6_1538 (worker node)" caption-side="top"}



