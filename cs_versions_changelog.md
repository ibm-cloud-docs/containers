---

copyright:
  years: 2014, 2020
lastupdated: "2020-05-19"

keywords: kubernetes, iks, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}


# Kubernetes version changelog
{: #changelog}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} Kubernetes clusters. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{:shortdesc}

## Overview
{: #changelog_overview}

Unless otherwise noted in the changelogs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Changelog entries that address other security vulnerabilities but do not also refer to an IBM security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some changelogs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other changelogs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

</br>

## Version 1.18 changelog
{: #118_changelog}

Review the version 1.18 changelog.
{: shortdesc}

### Changelog for 1.18.2_1512, released 11 May 2020
{: #1182_1512}

The following table shows the changes that are included in patch update 1.18.2_1512. If you update your cluster from Kubernetes 1.17, review the [preparation actions](/docs/containers?topic=containers-cs_versions#cs_v118).
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.12.1 | v3.13.3 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.13/release-notes/){: external}. |
| Cluster health image | v1.1.1 | v1.1.4 | When cluster add-ons do not support the current cluster version, a warning is now returned in the cluster health state. |
| CoreDNS configuration | N/A | N/A | To improve cluster DNS availability, CoreDNS [pods now prefer evenly distributed scheduling](https://kubernetes.io/blog/2020/05/introducing-podtopologyspread/){: external} across worker nodes and zones.  |
| etcd | v3.4.3 | v3.4.7 | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.4.7){: external}). |
| Gateway-enabled cluster controller | 1045 | 1082 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| GPU device plug-in and installer | 8c6538f | b9a418c | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| IBM Calico extension | 320 | 349 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.5-1 | v1.18.2-3 | Updated to support the Kubernetes 1.18.2 release and to use `calicoctl` version 3.13.3. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 358 | 371 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Kubernetes | v1.17.5 | v1.18.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.2){: external}. |
| Kubernetes admission controllers configuration | N/A | N/A | Added `CertificateApproval`, `CertificateSigning`, `CertificateSubjectRestriction` and `DefaultIngressClass` to the `--enable-admission-plugins` option for the cluster's [Kubernetes API server](/docs/containers?topic=containers-service-settings#kube-apiserver). |
| Kubernetes configuration | N/A | N/A |  Removed `batch/v2alpha1=true` from the `--runtime-config` option for the cluster's Kubernetes API server. |
| Kubernetes Dashboard | v2.0.0-rc7 | v2.0.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0){: external}. |
| Kubernetes NodeLocal DNS cache | 1.15.8 | 1.15.12 | <ul><li>See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.12){: external}.</li><li>[NodeLocal DNS cache](/docs/containers?topic=containers-cluster_dns#dns_cache) is now generally available, but still disabled by default.</li><li>In Kubernetes 1.18, you might also use [zone-aware DNS](/docs/containers?topic=containers-cluster_dns#dns_zone_aware) instead of just NodeLocal DNS cache, to increase DNS performance and availability in a multizone cluster.</li></ul> |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 177 | 207 | Improved application logging. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Pause container image | 3.1 | 3.2 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.5_1523" caption-side="top"}

<br />


## Version 1.17 changelog
{: #117_changelog}

Review the version 1.17 changelog.
{: shortdesc}

### Changelog for worker node fix pack 1.17.5_1524, released 11 May 2020
{: #1175_1524}

The following table shows the changes that are included in the worker node fix pack `1.17.5_1524`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1523" caption-side="top"}

### Changelog for worker node fix pack 1.17.5_1523, released 27 April 2020
{: #1175_1523}

The following table shows the changes that are included in the worker node fix pack `1.17.5_1523`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.3 | v1.3.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.4){: external}. |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Kubernetes | v1.17.4 | v1.17.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.5){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1521" caption-side="top"}

### Changelog for master fix pack 1.17.5_1522, released 23 April 2020
{: #1175_1522}

The following table shows the changes that are included in the master fix pack patch update `1.17.5_1522`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.4-3 | v1.17.5-1 | Updated to support the Kubernetes 1.17.5 release and to use `Go` version 1.13.9. |
| Kubernetes | v1.17.4 | v1.17.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.5){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1521" caption-side="top"}

### Changelog for master fix pack 1.17.4_1521, released 17 April 2020
{: #1174_1521_master}

The following table shows the changes that are included in the master fix pack patch update `1.17.4_1521`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.12.0 | v3.12.1 | See the [Calico release notes](https://docs.projectcalico.org/release-notes/){: external}. Updated to allow egress from the worker nodes via the the `allow-vrrp` `GlobalNetworkPolicy`. |
| CoreDNS | 1.6.7 | 1.6.9 | See the [CoreDNS release notes](https://coredns.io/2020/03/24/coredns-1.6.9-release/){: external}. Fixed a bug during Corefile migration that might generate invalid data that makes CoreDNS pods fail. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.4-1 | v1.17.4-3 | Updated to use `calicoctl` version 3.12.1. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| Kubernetes Dashboard | v2.0.0-rc5 | v2.0.0-rc7 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc7){: external}. Added a readiness probe to the Kubernetes Dashboard configuration. |
| Kubernetes Dashboard metrics scraper | v1.0.3 | v1.0.4 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.4){: external}. |
| OpenVPN client | N/A | N/A | Fixed problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
| Operator Lifecycle Manager Catalog | v1.5.11 | v1.6.1 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.6.1){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1520" caption-side="top"}

### Changelog for worker node fix pack 1.17.4_1521, released 13 April 2020
{: #1174_1521}

The following table shows the changes that are included in the worker node fix pack `1.17.4_1521`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1520" caption-side="top"}

### Changelog for worker node fix pack 1.17.4_1520, released 30 March 2020
{: #1174_1520}

The following table shows the changes that are included in the worker node fix pack `1.17.4_1520`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1519" caption-side="top"}

### Changelog for 1.17.4_1519, released 16 March 2020
{: #1174_1519}

The following table shows the changes that are included in the master and worker node update `1.17.4_1519`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | N/A | N/A | Cluster health status now includes links to {{site.data.keyword.cloud_notm}} documentation. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.17.3-1 | v1.17.4-1 | Updated to support the Kubernetes 1.17.4 release and to use `Go` version 1.13.8. Fixed VPC load balancer error message to use the current {{site.data.keyword.containerlong_notm}} plug-in CLI syntax. |
| Kubernetes | Both | v1.17.3 | v1.17.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 169 | 177 | Version 2.0 network load balancers (NLB) were updated to fix problems with long-lived network connections to endpoints that failed readiness probes. |
| Operator Lifecycle Manager Catalog | Master | v1.5.9 | v1.5.11 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.11){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | Worker |N/A | N/A | Updated worker node images with  package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.3_1518" caption-side="top"}

### Changelog for worker node fix pack 1.17.3_1518, released 2 March 2020
{: #1173_1518}

The following table shows the changes that are included in the worker node fix pack 1.17.3_1518. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU worker node provisioning | N/A | N/A | Fixed bug where new GPU worker nodes could not automatically join clusters that run Kubernetes version 1.16 or 1.17. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.3_1516" caption-side="top"}

### Changelog for fix pack 1.17.3_1516, released 17 February 2020
{: #1173_1516}

The following table shows the changes that are included in the master and worker node fix pack update `1.17.3_1516`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| containerd | Worker | v1.3.2 | v1.3.3 | See [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.3){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | affdfe2 | 49979f5 | Image updated for [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}, and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.17.2-4 | v1.17.3-1 | Updated to support the Kubernetes 1.17.3 release and to use `Go` version 1.13.6. |
| Kubernetes | Both | v1.17.2 | v1.17.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.3){: external}. The master update resolves CVE-2019-11254 and CVE-2020-8552 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6203780){: external}), and the worker node update resolves CVE-2020-8551 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6204874){: external}). |
| Kubernetes Dashboard | Master | v2.0.0-rc3 | v2.0.0-rc5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc5){: external}. |
| Operator Lifecycle Manager Catalog | Master | v1.5.8 | v1.5.9 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.9){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and[CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.2_1515" caption-side="top"}

### Changelog for 1.17.2_1515, released 10 February 2020
{: #1172_1515}

The following table shows the changes that are included in patch update 1.17.2_1515.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.5 | v3.12.0 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.12/release-notes/){: external}. |
| CoreDNS | 1.6.6 | 1.6.7 | See the [CoreDNS release notes](https://coredns.io/2020/01/28/coredns-1.6.7-release/){: external}. |
| etcd | v3.3.18 | v3.4.3 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.3){: external}. |
| GPU device plug-in and installer | da19df3 | affdfe2 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, and [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| **New**: {{site.data.keyword.cloud_notm}} Controller Manager | v1.16.5-148 | v1.17.2-4 | The {{site.data.keyword.cloud_notm}} Controller Manager component replaces the {{site.data.keyword.cloud_notm}} Provider component by moving the {{site.data.keyword.cloud_notm}} controllers from the Kubernetes [`kube-controller-manager`](https://kubernetes.io/docs/concepts/overview/components/#kube-controller-manager){: external} to the [`cloud-controller-manager`](https://kubernetes.io/docs/concepts/overview/components/#cloud-controller-manager){: external} component. The {{site.data.keyword.cloud_notm}} Controller Manager is updated to support the Kubernetes 1.17.2 release, to use `distroless/static` base image version `c6d59815`, and to use `calicoctl` version 3.12.0. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 357 | 358 | Made the `ibmc-file-gold` storage class the default storage class for new clusters only. The default storage class for existing clusters is unchanged. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass). In addition, the updated the image for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| Kubernetes | v1.16.5 | v1.17.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.2){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the OpenID Connect configuration for the cluster's Kubernetes API server to use the {{site.data.keyword.iamlong}} (IAM) `iam.cloud.ibm.com` endpoint. Added the `AllowInsecureBackendProxy=false` Kubernetes feature gate to prevent skipping TLS verification of kubelet during pod logs requests. |
| Kubernetes Dashboard | v2.0.0-rc2 | v2.0.0-rc3 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc3){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.2 | v1.0.3 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.3){: external}. |
| Kubernetes nodelocal DNS cache | 1.15.4 | 1.15.8 | See the [Kubernetes nodelocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.8){: external}. Now in Kubernetes 1.17, when you [apply the label to set up node local DNS caching](/docs/containers?topic=containers-cluster_dns#dns_cache), the requests are handled immediately and you do not need to reload the worker nodes. |
| OpenVPN server | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh){: external}. |
| Operator Lifecycle Manager Catalog | v1.5.6 | v1.5.8 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.8){: external}. |
| Operator Lifecycle Manager | 0.13.0 | 0.14.1 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.14.1){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.5_1522" caption-side="top"}

<br />


## Version 1.16 changelog
{: #116_changelog}

Review the version 1.16 changelog.
{: shortdesc}

### Changelog for worker node fix pack 1.16.9_1531, released 11 May 2020
{: #1169_1531}

The following table shows the changes that are included in the worker node fix pack `1.16.9_1531`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.9_1530" caption-side="top"}

### Changelog for worker node fix pack 1.16.9_1530, released 27 April 2020
{: #1169_1530}

The following table shows the changes that are included in the worker node fix pack `1.16.9_1530`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.3 | v1.3.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.4){: external}. |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Kubernetes | v1.16.8 | v1.16.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.9){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1528" caption-side="top"}

### Changelog for master fix pack 1.16.9_1529, released 23 April 2020
{: #1169_1529}

The following table shows the changes that are included in the master fix pack patch update `1.16.9_1529`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico configuration | N/A | N/A | Updated to allow egress from the worker nodes via the the `allow-vrrp` `GlobalNetworkPolicy`. |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| CoreDNS | 1.6.7 | 1.6.9 | See the [CoreDNS release notes](https://coredns.io/2020/03/24/coredns-1.6.9-release/){: external}. Fixed a bug during Corefile migration that might generate invalid data that makes CoreDNS pods fail. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.8-192 | v1.16.9-219 | Updated to support the Kubernetes 1.16.9 release and to use `Go` version 1.13.9. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| Kubernetes | v1.16.8 | v1.16.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.9){: external}. |
| Kubernetes Dashboard | v2.0.0-rc5 | v2.0.0-rc7 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc7){: external}. Added a readiness probe to the Kubernetes Dashboard configuration. |
| Kubernetes Dashboard metrics scraper | v1.0.3 | v1.0.4 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.4){: external}. |
| OpenVPN client | N/A | N/A | Fixed a problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
| Operator Lifecycle Manager Catalog | v1.5.11 | v1.6.1 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.6.1){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1528" caption-side="top"}

### Changelog for worker node fix pack 1.16.8_1528, released 13 April 2020
{: #1168_1528}

The following table shows the changes that are included in the worker node fix pack `1.16.8_1528`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1527" caption-side="top"}

### Changelog for worker node fix pack 1.16.8_1527, released 30 March 2020
{: #1168_1527}

The following table shows the changes that are included in the worker node fix pack `1.16.8_1527`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1526" caption-side="top"}

### Changelog for 1.16.8_1526, released 16 March 2020
{: #1168_1526}

The following table shows the changes that are included in the master and worker node update `1.16.8_1526`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | N/A | N/A | Cluster health status now includes links to {{site.data.keyword.cloud_notm}} documentation. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.16.7-170 | v1.16.8-192 | Updated to support the Kubernetes 1.16.8 release and to use `Go` version 1.13.8. Fixed VPC load balancer error message to use the current {{site.data.keyword.containerlong_notm}} plug-in CLI syntax. |
| Kubernetes | Both | v1.16.7 | v1.16.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.8){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 169 | 177 | Version 2.0 network load balancers (NLB) were updated to fix problems with long-lived network connections to endpoints that failed readiness probes. |
| Operator Lifecycle Manager Catalog | Master | v1.5.9 | v1.5.11 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.11){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | Worker |N/A | N/A | Updated worker node images with  package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.7_1525" caption-side="top"}

### Changelog for worker node fix pack 1.16.7_1525, released 2 March 2020
{: #1167_1525}

The following table shows the changes that are included in the worker node fix pack 1.16.7_1525. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU worker node provisioning | N/A | N/A | Fixed bug where new GPU worker nodes could not automatically join clusters that run Kubernetes version 1.16 or 1.17. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.7_1524" caption-side="top"}

### Changelog for fix pack 1.16.7_1524, released 17 February 2020
{: #1167_1524}

The following table shows the changes that are included in the master and worker node fix pack update `1.16.7_1524`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | -------- | ------- | ----------- |
| containerd | Worker | v1.3.2 | v1.3.3 | See [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.3){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253). |
| CoreDNS | Master | 1.6.6 | 1.6.7 | See the [CoreDNS release notes](https://coredns.io/2020/01/28/coredns-1.6.7-release/){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844) and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.16.5-148 | v1.16.7-170 | Updated to support the Kubernetes 1.16.7 release and to use `Go` version 1.13.6 and `calicoctl` version 3.9.5. |
| Kubernetes | Both | v1.16.5 | v1.16.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.7){: external}. The master update resolves CVE-2019-11254 and CVE-2020-8552 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6203780){: external}), and the worker node update resolves CVE-2020-8551 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6204874){: external}). |
| Kubernetes Dashboard | Master | v2.0.0-rc2 | v2.0.0-rc5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc5){: external}. |
| Kubernetes Dashboard Metrics Scraper | Master | v1.0.2 | v1.0.3 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.3){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh){: external}. |
| Operator Lifecycle Manager | Master | 0.13.0 | 0.14.1 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.14.1){: external}. |
| Operator Lifecycle Manager Catalog | Master | v1.5.6 | v1.5.9 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.9){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712). |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and[CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712). |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.5_1523" caption-side="top"}

### Changelog for worker node fix pack 1.16.5_1523, released 3 February 2020
{: #1165_1523}

The following table shows the changes that are included in the worker node fix pack 1.16.5_1523.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.5_1522" caption-side="top"}

### Changelog for 1.16.5_1522, released 20 January 2020
{: #1165_1522}

The following table shows the changes that are included in the master and worker node patch update 1.16.5_1522. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.3 | v3.9.5 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.9/release-notes/){: external}. |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| CoreDNS | 1.6.2 | 1.6.6 | See the [CoreDNS release notes](https://coredns.io/2019/12/11/coredns-1.6.6-release/){: external}. Update resolves [CVE-2019-19794](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19794){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Gateway-enabled cluster controller | 1032 | 1045 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| IBM Calico extension | 130 | 258 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`.</li><li>Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot).</li><li>Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}.</li></ul> |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.3-115 | v1.16.5-148 | Updated to support the Kubernetes 1.16.5 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.16.3 | v1.16.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.5){: external}. |
| Kubernetes Dashboard | v2.0.0-beta8 | v2.0.0-rc2 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc2){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Operator Lifecycle Manager Catalog | v1.5.4 | v1.5.6 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.6){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://nvd.nist.gov/vuln/detail/CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1521" caption-side="top"}


### Changelog for worker node fix pack 1.16.3_1521, released 23 December 2019
{: #1163_1521}

The following table shows the changes that are included in the worker node fix pack 1.16.3_1521.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://nvd.nist.gov/vuln/detail/CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1519" caption-side="top"}

### Changelog for master fix pack 1.16.3_1520, released 17 December 2019
{: #1163_1520}

The following table shows the changes that are included in the master fix pack 1.16.3_1520.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Gateway-enabled cluster controller | 924 | 1032 | Support for [Adding classic infrastructure servers to gateway-enabled classic clusters](/docs/containers?topic=containers-add_workers#gateway_vsi) is now generally available (GA). In addition, the controller is updated to use Alpine base image version 3.10 and to use Go version 1.12.11. |
| IBM Calico extension | N/A | 130 | **New!**: Added a Calico node init container that creates Calico private host endpoints for worker nodes. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| {{site.data.keyword.cloud_notm}} Provider	| v1.16.3-94 | v1.16.3-115 | Updated version 1.0 and 2.0 network load balancers (NLBs) to prefer scheduling NLB pods on worker nodes that do not currently run any NLB pods. In addition, the Virtual Private Cloud (VPC) load balancer plug-in is updated to use Go version 1.12.11. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
| Kubernetes add-on resizer | 1.8.5 | 1.8.7 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.7){: external}. |
| Kubernetes Metrics Server | N/A | N/A | The `nanny` container is fixed (see Kubernetes add-on resizer component) and added back to the `metrics-server` pod, which removes the Kubernetes 1.16 limitation to [Adjusting cluster metrics provider resources](/docs/containers?topic=containers-kernel#metrics). |
| Kubernetes Dashboard | v2.0.0-beta6 | v2.0.0-beta8 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta8){: external}.|
| Operator Lifecycle Manager Catalog | v1.4.0 | v1.5.4 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.4){: external}. |
| Operator Lifecycle Manager | 0.12.0 | 0.13.0 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.13.0){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1519" caption-side="top"}

### Changelog for worker node fix pack 1.16.3_1519, released 9 December 2019
{: #1163_1519_worker}

The following table shows the changes that are included in the worker node fix pack 1.16.3_1519.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.1 | v1.3.2 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.2){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1518" caption-side="top"}

### Changelog for worker node fix pack 1.16.3_1518, released 25 November 2019
{: #1163_1518_worker}

The following table shows the changes that are included in the worker node fix pack 1.16.3_1518.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.0 | v1.3.1 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.1){: external}. Update resolves [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external} and [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. |
| Kubernetes | v1.16.2 | v1.16.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.3){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.2_1515" caption-side="top"}

### Changelog for master fix pack 1.16.3_1518, released 21 November 2019
{: #1163_1518}

The following table shows the changes that are included in the master fix pack 1.16.3_1518.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.2 | v3.9.3 | See the [Calico release notes](https://docs.projectcalico.org/release-notes/){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}, and [DSA-4539-3](https://lists.debian.org/debian-security-announce/2019/msg00193.html){: external}. |
| GPU device plug-in and installer | 9cd3df7 |	f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 351 | 353 | Updated to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider	| v1.16.2-77 | v1.16.3-94 | Updated to support the Kubernetes 1.16.3 release. `calicoctl` version is updated to v3.9.3. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.16.2 | v1.16.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.3){: external}. |
| Kubernetes Dashboard | v2.0.0-beta5 | v2.0.0-beta6 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta6){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.2_1515" caption-side="top"}

### Changelog for worker node fix pack 1.16.2_1515, released 11 November 2019
{: #1162_1515_worker}

The following table shows the changes that are included in the worker node fix pack 1.16.2_1515.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.2_1514" caption-side="top"}

### Changelog for 1.16.2_1514, released 4 November 2019
{: #1162_1514}

The following tables show the changes that are included in the patch `1.16.2_1514`. If you update to this version from an earlier version, you choose when to update your cluster master and worker nodes. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types) and [Version 1.16](/docs/containers?topic=containers-cs_versions#cs_v116).
{: shortdesc}

**Master patch**

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Calico | v3.8.2 | v3.9.2 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.9/release-notes/){: external}.|
|CoreDNS |	1.3.1 |	1.6.2 |	See the [CoreDNS release notes](https://coredns.io/2019/08/13/coredns-1.6.2-release/). This update includes the following configuration changes. <ul><li>CoreDNS now runs `3` replica pods by default, and the pods prefer to schedule across worker nodes and zones to improve cluster DNS availability. If you update your cluster to version 1.16 from an earlier version, you can [configure the CoreDNS autoscaler](/docs/containers?topic=containers-cluster_dns#dns_autoscale) to use a minimum of `3` pods.</li><li>CoreDNS caching is updated to better support older DNS clients. If you disabled the CoreDNS `cache` plug-in due to [the known issue](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_issues), you can now re-enable the plug-in.</li><li>The CoreDNS deployment is now configured to check readiness by using the `ready` plug-in.</li><li>CoreDNS version 1.6 no longer supports the `proxy` plug-in, which is replaced by the `forward` plug-in. In addition, the CoreDNS `kubernetes` plug-in no longer supports the `resyncperiod` option and ignores the `upstream` option. </li></ul>|
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 350 | 351 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.10.|
| Kubernetes | v1.15.5 | v1.16.2 | See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.2).|
| Kubernetes configuration |	N/A |	N/A |	[Kubernetes service account token volume projection](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#service-account-token-volume-projection){: external} is enabled and issues tokens that use `https://kubernetes.default.svc` as the default API audience. |
| Kubernetes admission controllers configuration |	N/A |	N/A |	The `RuntimeClass` admission controller is disabled to align with the `RuntimeClass` feature gate, which was disabled in {{site.data.keyword.containerlong_notm}} version 1.14.|
| Kubernetes Dashboard |	v1.10.1 |	v2.0.0-beta5 |	See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta5){: external}. Unlike the previous version, the new Kubernetes dashboard version works with the `metrics-server` to display metrics. |
| Kubernetes Dashboard metrics scraper |	N/A |	v1.0.2 |	See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.2){: external}.|
| Kubernetes DNS autoscaler |	1.6.0 |	1.7.1 |	See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.7.1){: external}.|
| Operator Lifecycle Manager Catalog |	N/A |	v1.4.0 |	See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.4.0){: external}. |
| Operator Lifecycle Manager |	N/A |	0.12.0 |	See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.12.0){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Master patch: Changes since version 1.15.5_1520" caption-side="top"}

**Worker node patch**

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|containerd |	v1.2.10 |	v1.3.0 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.0){: external}. The containerd configuration now sets `stream_idle_timeout` to `30m`, lowered from `4h`. This `stream_idle_timeout` configuration is the maximum time that a streaming connection such as `kubectl exec` can be idle before the connection is closed. Also, the container runtime type is updated to `io.containerd.runc.v2`. |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Kubernetes | v1.15.5 | v1.16.2 | See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.2).|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Worker node patch: Changes since version 1.15.5_1521" caption-side="top"}

## Deprecated: Version 1.15 changelog
{: #115_changelog}

Review the version 1.15 changelog.
{: shortdesc}

Version 1.15 is deprecated. [Review the potential impact](/docs/containers?topic=containers-cs_versions#cs_versions) of each Kubernetes version update, and then [update your clusters](/docs/containers?topic=containers-update#update) immediately to at least 1.16.
{: deprecated}

### Changelog for worker node fix pack 1.15.11_1538, released 11 May 2020
{: #11511_1538}

The following table shows the changes that are included in the worker node fix pack `1.15.11_1538`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1537" caption-side="top"}

### Changelog for worker node fix pack 1.15.11_1537, released 27 April 2020
{: #11511_1537}

The following table shows the changes that are included in the worker node fix pack `1.15.11_1537`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1535" caption-side="top"}

### Changelog for master fix pack 1.15.11_1536, released 23 April 2020
{: #11511_1536}

The following table shows the changes that are included in the master fix pack patch update `1.15.11_1536`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico configuration | N/A | N/A | Updated to allow egress from the worker nodes via the the `allow-vrrp` `GlobalNetworkPolicy`. |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| OpenVPN client | N/A | N/A | Fixed a problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1535" caption-side="top"}

### Changelog for worker node fix pack 1.15.11_1535, released 13 April 2020
{: #11511_1535}

The following table shows the changes that are included in the worker node fix pack `1.15.11_1535`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1534" caption-side="top"}

### Changelog for worker node fix pack 1.15.11_1534, released 30 March 2020
{: #11511_1534}

The following table shows the changes that are included in the worker node fix pack `1.15.11_1534`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1533" caption-side="top"}

### Changelog for 1.15.11_1533, released 16 March 2020
{: #11511_1533}

The following table shows the changes that are included in the master and worker node update `1.15.11_1533`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | N/A | N/A | Cluster health status now includes links to {{site.data.keyword.cloud_notm}} documentation. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.15.10-252 | v1.15.11-274 | Updated to support the Kubernetes 1.15.11 release and to use `Go` version 1.12.17. Fixed VPC load balancer error message to use the current {{site.data.keyword.containerlong_notm}} plug-in CLI syntax. |
| Kubernetes | Both | v1.15.10 | v1.15.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.11){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | Worker |N/A | N/A | Updated worker node images with  package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.10_1532" caption-side="top"}

### Changelog for worker node fix pack 1.15.10_1532, released 2 March 2020
{: #11510_1532}

The following table shows the changes that are included in the worker node fix pack 1.15.10_1532. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.12 | v1.2.13 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.13){: external}. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.10_1531" caption-side="top"}

### Changelog for fix pack 1.15.10_1531, released 17 February 2020
{: #11510_1531}

The following table shows the changes that are included in the master and worker node fix pack update `1.15.10_1531`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}.|
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external} and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.15.8-230 | v1.15.10-252 | Updated to support the Kubernetes 1.15.10 release. |
| Kubernetes | Both | v1.15.8 | v1.15.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.10){: external}. The master update resolves CVE-2019-11254 and CVE-2020-8552 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6203780){: external}), and the worker node update resolves CVE-2020-8551 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6204874){: external}). |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}.|
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with  package updates for{: external}, [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.8_1530" caption-side="top"}

### Changelog for worker node fix pack 1.15.8_1530, released 3 February 2020
{: #1158_1530}

The following table shows the changes that are included in the worker node fix pack 1.15.8_1530.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.8_1529" caption-side="top"}

### Changelog for 1.15.8_1529, released 20 January 2020
{: #1158_1529}

The following table shows the changes that are included in the master and worker node patch update 1.15.8_1529. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.8.4 | v3.8.6 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.8/release-notes/){: external}. |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Gateway-enabled cluster controller | 1032 | 1045 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`.</li><li>Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot).</li><li>Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}.</li></ul> |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.6-200 | v1.15.8-230 | Updated to support the Kubernetes 1.15.8 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.15.6 | v1.15.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.8){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://nvd.nist.gov/vuln/detail/CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1528" caption-side="top"}

### Changelog for worker node fix pack 1.15.6_1528, released 23 December 2019
{: #1156_1528}

The following table shows the changes that are included in the worker node fix pack 1.15.6_1528.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://nvd.nist.gov/vuln/detail/CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1526" caption-side="top"}

### Changelog for master fix pack 1.15.6_1527, released 17 December 2019
{: #1156_1527}

The following table shows the changes that are included in the master fix pack 1.15.6_1527.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Gateway-enabled cluster controller | 924 | 1032 | Support for [Adding classic infrastructure servers to gateway-enabled classic clusters](/docs/containers?topic=containers-add_workers#gateway_vsi) is now generally available (GA). In addition, the controller is updated to use Alpine base image version 3.10 and to use Go version 1.12.11. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| {{site.data.keyword.cloud_notm}} Provider	| v1.15.6-182 | v1.15.6-200 | Updated version 1.0 and 2.0 network load balancers (NLBs) to prefer scheduling NLB pods on worker nodes that do not currently run any NLB pods. In addition, the Virtual Private Cloud (VPC) load balancer plug-in is updated to use Go version 1.12.11. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1526" caption-side="top"}

### Changelog for worker node fix pack 1.15.6_1526, released 9 December 2019
{: #1156_1526_worker}

The following table shows the changes that are included in the worker node fix pack 1.15.6_1526.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1525" caption-side="top"}

### Changelog for worker node fix pack 1.15.6_1525, released 25 November 2019
{: #1156_1525_worker}

The following table shows the changes that are included in the worker node fix pack 1.15.6_1525.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.15.5 | v1.15.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.6){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.5_1522" caption-side="top"}

### Changelog for master fix pack 1.15.6_1525, released 21 November 2019
{: #1156_1525}

The following table shows the changes that are included in the master fix pack 1.15.6_1525.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.8.2 | v3.8.4 | See the [Calico release notes](https://docs.projectcalico.org/release-notes/){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}, and [DSA-4539-3](https://lists.debian.org/debian-security-announce/2019/msg00193.html){: external}. |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider	| v1.15.5-159 | v1.15.6-182 | Updated to support the Kubernetes 1.15.6 release. `calicoctl` version is updated to v3.8.4. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.15.5 | v1.15.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.6){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.5_1522" caption-side="top"}

### Changelog for worker node fix pack 1.15.5_1522, released 11 November 2019
{: #1155_1522_worker}

The following table shows the changes that are included in the worker node fix pack 1.15.5_1522.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.5_1521" caption-side="top"}

### Changelog for worker node fix pack 1.15.5_1521, released 28 October 2019
{: #1155_1521}

The following table shows the changes that are included in the worker node fix pack `1.15.5_1521`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |	v1.15.4 |	v1.15.5	| See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.5){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic	| Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.15.5_1520" caption-side="top"}

### Changelog for master fix pack 1.15.5_1520, released 22 October 2019
{: #1155_1520}

The following table shows the changes that are included in the master fix pack `1.15.5_1520`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration to minimize [cluster service DNS resolution failures when CoreDNS pods are restarted](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_lameduck). Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| Gateway-enabled cluster controller | 844 | 924 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you do not need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.4-136 | v1.15.5-159 | Updated to support the Kubernetes 1.15.5 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |	v1.15.4 |	v1.15.5	| See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.5){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/1098759)) and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes Metrics Server | v0.3.4 |	v0.3.6	| See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6){: external}. The update also includes the following configuration changes to improve reliability and availability.<ul><li>Added [Kubernetes liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/){: external}.</li><li>Added [Kubernetes pod affinity rule](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/){: external} to prefer scheduling to the same worker node as the OpenVPN client `vpn` pod in the `kube-system` namespace.</li><li>Increased metrics resolution timeout from 30 to 45 seconds.</li></ul>|
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.15.4_1519" caption-side="top"}

### Changelog for worker node fix pack 1.15.4_1519, released 14 October 2019
{: #1154_1519_worker}

The following table shows the changes that are included in the worker node fix pack 1.15.4_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.15.4_1518">
<caption>Changes since version 1.15.4_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-0136 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-0136), [CVE-2018-20961 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20961), [CVE-2019-11487 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11487), [CVE-2016-10905 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2016-10905), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
</tbody>
</table>

### Changelog for 1.15.4_1518, released 1 October 2019
{: #1154_1518}




The following table shows the changes that are included in the patch 1.15.4_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.15.3_1517">
<caption>Changes since version 1.15.3_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.8.1</td>
<td>v3.8.2</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/archive/v3.8/release-notes/).</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to improve performance of master update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.9</td>
<td>v1.2.10</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.10). Update resolves [CVE-2019-16884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884) and [CVE-2019-16276 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276).</td>
</tr>
<tr>
<td>Default IBM file storage class</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class.</td>
</tr>
<tr>
<td>Gateway-enabled cluster controller</td>
<td>N/A</td>
<td>844</td>
<td>New! For [classic clusters with a gateway enabled](/docs/containers?topic=containers-clusters#gateway_cluster_cli), a `DaemonSet` is installed to configure settings for routing network traffic to worker nodes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.15.3-112</td>
<td>v1.15.4-136</td>
<td>Updated to support the Kubernetes 1.15.4 release. In addition, version 1.0 and 2.0 network load balancers (NLBs) were updated to support [classic clusters with a gateway enabled](/docs/containers?topic=containers-clusters#gateway_cluster_cli).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>212</td>
<td>221</td>
<td>Improved Kubernetes [key management service provider](/docs/containers?topic=containers-encryption#keyprotect) caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.3</td>
<td>v1.15.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.4).</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.3</td>
<td>v0.3.4</td>
<td>See the [Kubernetes Metrics Server release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.4).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>148</td>
<td>153</td>
<td>Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-115</td>
<td>2.4.6-r3-IKS-121</td>
<td>Updated images for [CVE-2019-1547 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547) and [CVE-2019-1563 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-15031 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15031), [CVE-2019-15030 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15030), and [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.15.3_1517, released 16 September 2019
{: #1153_1517_worker}

The following table shows the changes that are included in the worker node fix pack 1.15.3_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.15.3_1516">
<caption>Changes since version 1.15.3_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.8</td>
<td>v1.2.9</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.9). Update resolves [CVE-2019-9515 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515).</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2015-9383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2015-9383), [CVE-2019-10638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10638), [CVE-2019-3900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3900), [CVE-2018-20856 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20856), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2018-20406 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20406), and [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160), and [CVE-2019-15718 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15718).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.15.3_1516, released 3 September 2019
{: #1153_1516_worker}

The following table shows the changes that are included in the worker node fix pack 1.15.3_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.15.2_1514">
<caption>Changes since version 1.15.2_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.7</td>
<td>v1.2.8</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.8). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.2</td>
<td>v1.15.3</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.3). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for [CVE-2019-10222 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10222) and [CVE-2019-11922 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11922).</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.15.3_1515, released 28 August 2019
{: #1153_1515}

The following table shows the changes that are included in the master fix pack 1.15.3_1515.
{: shortdesc}

<table summary="Changes that were made since version 1.15.2_1514">
<caption>Changes since version 1.15.2_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`etcd`</td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the [`etcd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.15). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809). Updated the GPU drivers to [430.40 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/Download/driverResults.aspx/149138/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.15.2-94</td>
<td>v1.15.3-112</td>
<td>Updated to support the Kubernetes 1.15.3 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.2</td>
<td>v1.15.3</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.3). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.15.2_1514, released 19 August 2019
{: #1152_1514_worker}

The following table shows the changes that are included in the worker node fix pack 1.15.2_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.15.1_1511">
<caption>Changes since version 1.15.1_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA Proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA Proxy 1.8 to fix [socket leak in HA proxy ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/haproxy/haproxy/issues/136). Also added a liveliness check to monitor the health of HA Proxy. For more information, see [HA Proxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.8/src/CHANGELOG).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.1</td>
<td>v1.15.2</td>
<td>For more information, see the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.2).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-13012 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13012), [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-10126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), and [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2019-2101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2101), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-13233 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13233), [CVE-2019-13272 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13272), [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846), [CVE-2019-12818 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12818), [CVE-2019-12984 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12984), and [CVE-2019-12819 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12819).</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.15.2_1514, released 17 August 2019
{: #1152_1514}

The following table shows the changes that are included in the master fix pack 1.15.2_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.15.1_1513">
<caption>Changes since version 1.15.1_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.15.2_1513, released 15 August 2019
{: #1152_1513}

The following table shows the changes that are included in the master fix pack 1.15.2_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.15.1_1511">
<caption>Changes since version 1.15.1_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container. In addition, the `calico-node` deployment in the `kube-system` namespace no longer includes the `flexvol-driver` init container.</td>
</tr>
<tr>
<td>Cluster health</td>
<td>N/A</td>
<td>N/A</td>
<td>Cluster health shows `Warning` state if a cluster control plane operation failed or was canceled. For more information, see [Debugging clusters](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>d91d200</td>
<td>07c9b67</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.15.1-86</td>
<td>v1.15.2-94</td>
<td>Updated to support the Kubernetes 1.15.2 release.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.1</td>
<td>v1.15.2</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.2). Updates resolves [CVE-2019-11247 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967115)) and [CVE-2019-11249 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967123)).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-90</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
</tbody>
</table>

### Changelog for 1.15.1_1511, released 5 August 2019
{: #1151_1511}

The following table shows the changes that are included in the patch 1.15.1_1511.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1526">
<caption>Changes since version 1.14.4_1526</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.4</td>
<td>v3.8.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). In addition, Kubernetes version 1.15 clusters now have a new `allow-all-private-default` global network policy to allow all ingress and egress network traffic on private interface. For more information, see [Isolating clusters on the private network](/docs/containers?topic=containers-network_policies#isolate_workers).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.4-139</td>
<td>v1.15.1-86</td>
<td><ul><li>Updated to support the Kubernetes 1.15.1 release.</li><li>`calicoctl` version is updated to 3.8.1.</li><li>Virtual Private Cloud (VPC) load balancer support is added for VPC clusters.</li></ul>.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.4</td>
<td>v1.15.1</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.1) and [Kubernetes 1.15 blog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/blog/2019/06/19/kubernetes-1-15-release-announcement/). Update resolves [CVE-2019-11248 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967113)).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated Kubernetes API server default toleration seconds to 600 for the Kubernetes default `node.kubernetes.io/not-ready` and `node.kubernetes.io/unreachable` pod tolerations. For more information about tolerations, see [Taints and Tolerations ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/).</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.4</td>
<td>1.8.5</td>
<td>For more information, see the [Kubernetes add-on resizer release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.5).</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.4.0</td>
<td>1.6.0</td>
<td>For more information, see the [Kubernetes DNS autoscaler release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.6.0).</td>
</tr>
<tr>
<td>Kubernetes nodelocal DNS cache</td>
<td>N/A</td>
<td>1.15.4</td>
<td>For more information, see the [Kubernetes nodelocal DNS cache release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.15.4). For more information about this new beta feature, see [Setting up Nodelocal DNS Cache (beta)](/docs/containers?topic=containers-cluster_dns#dns_enablecache).</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.7-alpine</td>
<td>2.0.1-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/2.0/src/CHANGELOG).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>d91d200</td>
<td>Updated image for [CVE-2019-9924 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-11085 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11085), [CVE-2019-11815 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11815), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-11884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11884), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), and [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-2054 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2054), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), and [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638).</td>
</tr>
</tbody>
</table>

## Deprecated: Version 1.14 changelog
{: #114_changelog}

Review the version 1.14 changelog.
{: shortdesc}

Version 1.14 is deprecated. [Review the potential impact](/docs/containers?topic=containers-cs_versions#cs_versions) of each Kubernetes version update, and then [update your clusters](/docs/containers?topic=containers-update#update) immediately to at least 1.15.
{: deprecated}

### Changelog for worker node fix pack 1.14.10_1554, released 11 May 2020
{: #11410_1554}

The following table shows the changes that are included in the worker node fix pack `1.14.10_1554`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1553" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1553, released 27 April 2020
{: #11410_1553}

The following table shows the changes that are included in the worker node fix pack `1.14.10_1553`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1551" caption-side="top"}

### Changelog for master fix pack 1.14.10_1552, released 23 April 2020
{: #11410_1552}

The following table shows the changes that are included in the master fix pack patch update `1.14.10_1552`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico configuration | N/A | N/A | Updated to allow egress from the worker nodes via the the `allow-vrrp` `GlobalNetworkPolicy`. |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| OpenVPN client | N/A | N/A | Fixed a problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1551" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1551, released 13 April 2020
{: #11410_1551}

The following table shows the changes that are included in the worker node fix pack `1.14.10_1551`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1550" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1550, released 30 March 2020
{: #11410_1550}

The following table shows the changes that are included in the worker node fix pack `1.14.10_1550`. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1549" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1549, released 16 March 2020
{: #11410_1549}

The following table shows the changes that are included in the worker node fix pack 1.14.10_1549. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with  package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1548" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1548, released 2 March 2020
{: #11410_1548}

The following table shows the changes that are included in the worker node fix pack 1.14.10_1548. Worker node patch updates can be applied by updating or reloading the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.12 | v1.2.13 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.13){: external}. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1547" caption-side="top"}

### Changelog for fix pack 1.14.10_1547, released 17 February 2020
{: #11410_1547}

The following table shows the changes that are included in the master and worker node fix pack update `1.14.10_1547`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12). Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}, and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with  package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844) [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with  package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1546" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1546, released 3 February 2020
{: #11410_1546}

The following table shows the changes that are included in the worker node fix pack 1.14.10_1546.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1545" caption-side="top"}

### Changelog for 1.14.10_1545, released 20 January 2020
{: #11410_1545}

The following table shows the changes that are included in the master and worker node patch update 1.14.10_1545. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`.</li><li>Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot).</li><li>Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}.</li></ul> |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.9-239	| v1.14.10-288 | Updated to support the Kubernetes 1.14.10 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.14.9 |	v1.14.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.10){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://nvd.nist.gov/vuln/detail/CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1544" caption-side="top"}

### Changelog for worker node fix pack 1.14.9_1544, released 23 December 2019
{: #1149_1544}

The following table shows the changes that are included in the worker node fix pack 1.14.9_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://nvd.nist.gov/vuln/detail/CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1542" caption-side="top"}

### Changelog for master fix pack 1.14.9_1543, released 17 December 2019
{: #1149_1543}

The following table shows the changes that are included in the master fix pack 1.14.9_1543.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1542" caption-side="top"}

### Changelog for worker node fix pack 1.14.9_1542, released 9 December 2019
{: #1149_1542_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.9_1542.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1541" caption-side="top"}

### Changelog for worker node fix pack 1.14.9_1541, released 25 November 2019
{: #1149_1541_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.9_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.14.8 | v1.14.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.9){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.8_1538" caption-side="top"}

### Changelog for master fix pack 1.14.9_1541, released 21 November 2019
{: #1149_1541}

The following table shows the changes that are included in the master fix pack 1.14.9_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider	| v1.14.8-219 | v1.14.9-239 | Updated to support the Kubernetes 1.14.9 release. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.14.8 | v1.14.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.9){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.8_1538" caption-side="top"}

### Changelog for worker node fix pack 1.14.8_1538, released 11 November 2019
{: #1148_1538_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.8_1538.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.8_1537" caption-side="top"}

### Changelog for worker node fix pack 1.14.8_1537, released 28 October 2019
{: #1148_1537}

The following table shows the changes that are included in the worker node fix pack `1.14.8_1537`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |	v1.14.7 |	v1.14.8	| See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.8){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic	| Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.14.8_1536" caption-side="top"}

### Changelog for master fix pack 1.14.8_1536, released 22 October 2019
{: #1148_1536}

The following table shows the changes that are included in the master fix pack `1.14.8_1536`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration to minimize [cluster service DNS resolution failures when CoreDNS pods are restarted](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_lameduck). Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you do not need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.7-199 | v1.14.8-219 | Updated to support the Kubernetes 1.14.8 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |	v1.14.7 |	v1.14.8	| See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.8){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/1098759)) and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.14.7_1535" caption-side="top"}

### Changelog for worker node fix pack 1.14.7_1535, released 14 October 2019
{: #1147_1535_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.7_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.14.7_1534">
<caption>Changes since version 1.14.7_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-0136 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-0136), [CVE-2018-20961 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20961), [CVE-2019-11487 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11487), [CVE-2016-10905 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2016-10905), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.7_1534, released 1 October 2019
{: #1147_1534}

The following table shows the changes that are included in the patch 1.14.7_1534.
{: shortdesc}




<table summary="Changes that were made since version 1.14.6_1533">
<caption>Changes since version 1.14.6_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.4</td>
<td>v3.6.5</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/archive/v3.6/release-notes/).</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to improve performance of master update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.9</td>
<td>v1.2.10</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.10). Update resolves [CVE-2019-16884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884) and [CVE-2019-16276 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276).</td>
</tr>
<tr>
<td>Default IBM file storage class</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.6-172</td>
<td>v1.14.7-199</td>
<td>Updated to support the Kubernetes 1.14.7 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>212</td>
<td>221</td>
<td>Improved Kubernetes [key management service provider](/docs/containers?topic=containers-encryption#keyprotect) caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.6</td>
<td>v1.14.7</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.7).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>148</td>
<td>153</td>
<td>Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-115</td>
<td>2.4.6-r3-IKS-121</td>
<td>Updated images for [CVE-2019-1547 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547) and [CVE-2019-1563 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-15031 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15031), [CVE-2019-15030 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15030), and [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.14.6_1533, released 16 September 2019
{: #1146_1533_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.6_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.14.6_1532">
<caption>Changes since version 1.14.6_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.8</td>
<td>v1.2.9</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.9). Update resolves [CVE-2019-9515 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515).</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2015-9383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2015-9383), [CVE-2019-10638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10638), [CVE-2019-3900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3900), [CVE-2018-20856 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20856), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636),[CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2018-20406 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20406), and [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160), and [CVE-2019-15718 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15718).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.6_1532, released 3 September 2019
{: #1146_1532_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.6_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.14.5_1530">
<caption>Changes since version 1.14.5_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.7</td>
<td>v1.2.8</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.8). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.5</td>
<td>v1.14.6</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.6). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for [CVE-2019-10222 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10222) and [CVE-2019-11922 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11922).</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.14.6_1531, released 28 August 2019
{: #1146_1531}

The following table shows the changes that are included in the master fix pack 1.14.6_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.14.5_1530">
<caption>Changes since version 1.14.5_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`etcd`</td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the [`etcd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.15). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809). Updated the GPU drivers to [430.40 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/Download/driverResults.aspx/149138/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.5-160</td>
<td>v1.14.6-172</td>
<td>Updated to support the Kubernetes 1.14.6 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.5</td>
<td>v1.14.6</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.6). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.5_1530, released 19 August 2019
{: #1145_1530_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.5_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1527">
<caption>Changes since version 1.14.4_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA proxy 1.8 to fix [socket leak in HA proxy ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/haproxy/haproxy/issues/136). Also added a liveliness check to monitor the health of HA proxy. For more information, see [HA proxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.8/src/CHANGELOG).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.4</td>
<td>v1.14.5</td>
<td>For more information, see the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.5).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-13012 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13012), [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-10126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), and [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2019-2101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2101), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-13233 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13233), [CVE-2019-13272 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13272), [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846), [CVE-2019-12818 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12818), [CVE-2019-12984 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12984), and [CVE-2019-12819 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12819).</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.14.5_1530, released 17 August 2019
{: #1145_1530}

The following table shows the changes that are included in the master fix pack 1.14.5_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.14.5_1529">
<caption>Changes since version 1.14.5_1529</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.14.5_1529, released 15 August 2019
{: #1145_1529}

The following table shows the changes that are included in the master fix pack 1.14.5_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1527">
<caption>Changes since version 1.14.4_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container.</td>
</tr>
<tr>
<td>Cluster health</td>
<td>N/A</td>
<td>N/A</td>
<td>Cluster health shows `Warning` state if a cluster control plane operation failed or was canceled. For more information, see [Debugging clusters](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>07c9b67</td>
<td>Image updated for [CVE-2019-9924 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924) and [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.4-139</td>
<td>v1.14.5-160</td>
<td>Updated to support the Kubernetes 1.14.5 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.4</td>
<td>v1.14.5</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.5).  Updates resolves [CVE-2019-11247 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967115)) and [CVE-2019-11249 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967123)).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.4_1527, released 5 August 2019
{: #1144_1527_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.4_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1526">
<caption>Changes since version 1.14.4_1526</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-11085 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11085), [CVE-2019-11815 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11815), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-11884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11884), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), and [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-2054 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2054), [CVE-2019-11815 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11815), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-11884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11884), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), and [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638).</td>
</tr>
</tbody>  
</table>

### Changelog for worker node fix pack 1.14.4_1526, released 22 July 2019
{: #1144_1526_worker}

The following table shows the changes that are included in the worker node fix pack 1.14.4_1526.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1525">
<caption>Changes since version 1.14.3_1525</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.14.3</td>
<td>v1.14.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.4). Update resolves [CVE-2019-11248 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248). For more information, see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967113)).</td>
</tr>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for [CVE-2019-13012 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-13012) and [CVE-2019-7307 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-7307.html).</td>
</tr>
</tbody>  
</table>


### Changelog for master fix pack 1.14.4_1526, released 15 July 2019
{: #1144_1526}

The following table shows the changes that are included in the master fix pack 1.14.4_1526.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1525">
<caption>Changes since version 1.14.3_1525</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.1</td>
<td>v3.6.4</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [TTA-2019-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/#TTA-2019-001). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/959551).</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the `kubernetes` zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>5d34347</td>
<td>a7e8ece</td>
<td>Updated base image packages.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.3</td>
<td>v1.14.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.4).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.3-113</td>
<td>v1.14.4-139</td>
<td>Updated to support the Kubernetes 1.14.4 release. Additionally, `calicoctl` version is updated to 3.6.4.</td>
</tr>
  </tbody>
</table>

### Changelog for worker node fix pack 1.14.3_1525, released 8 July 2019
{: #1143_1525}

The following table shows the changes that are included in the worker node patch 1.14.3_1525.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1524">
<caption>Changes since version 1.14.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.14.3_1524, released 24 June 2019
{: #1143_1524}

The following table shows the changes that are included in the worker node patch 1.14.3_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1523">
<caption>Changes since version 1.14.3_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.6</td>
<td>1.2.7</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.7).</td>
</tr>
<tr>
<td>Max pods</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased the limit of maximum number of pods for worker nodes with more than 11 CPU cores to be 10 pods per core, up to a maximum of 250 pods per worker node.</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.3_1523, released 17 June 2019
{: #1143_1523}

The following table shows the changes that are included in the patch 1.14.3_1523.
{: shortdesc}

<table summary="Changes that were made since version 1.14.2_1521">
<caption>Changes since version 1.14.2_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>32257d3</td>
<td>5d34347</td>
<td>Updated image for [CVE-2019-8457 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457). Updated the GPU drivers to [430.14 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/Download/driverResults.aspx/147582/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>346</td>
<td>347</td>
<td>Updated so that the IAM API key can be either encrypted or unencrypted.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.2-100</td>
<td>v1.14.3-113</td>
<td>Updated to support the Kubernetes 1.14.3 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.2</td>
<td>v1.14.3</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.3).</td>
</tr>
<tr>
<td>Kubernetes feature gates configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the `SupportNodePidsLimit=true` configuration to reserve process IDs (PIDs) for use by the operating system and Kubernetes components. Added the `CustomCPUCFSQuotaPeriod=true` configuration to mitigate CPU throttling problems.</td>
</tr>
<tr>
<td>Public service endpoint for Kubernetes master</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed an issue to [enable the public service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.2_1521, released 4 June 2019
{: #1142_1521}

The following table shows the changes that are included in the patch 1.14.2_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.14.1_1519">
<caption>Changes since version 1.14.1_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster `create` or `update` operations.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.13).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.1-71</td>
<td>v1.14.2-100</td>
<td>Updated to support the Kubernetes 1.14.2 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.1</td>
<td>v1.14.2</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.2).</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.1</td>
<td>v0.3.3</td>
<td>See the [Kubernetes Metrics Server release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.1_1519, released 20 May 2019
{: #1141_1519}

The following table shows the changes that are included in the patch 1.14.1_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.14.1_1518">
<caption>Changes since version 1.14.1_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.1_1518, released 13 May 2019
{: #1141_1518}

The following table shows the changes that are included in the patch 1.14.1_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.14.1_1516">
<caption>Changes since version 1.14.1_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2019-6706 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e7182c7</td>
<td>13c7ef0</td>
<td>Updated image for [CVE-2016-7076 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076) and [CVE-2017-1000368 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368).</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.1_1516, released 7 May 2019
{: #1141_1516}

The following table shows the changes that are included in the patch 1.14.1_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1519">
<caption>Changes since version 1.13.5_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.4.4</td>
<td>v3.6.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/archive/v3.6/release-notes/).</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>1.2.6</td>
<td>1.3.1</td>
<td>See the [CoreDNS release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2019/01/13/coredns-1.3.1-release/). The update includes the addition of a [metrics port ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/plugins/metrics/) on the cluster DNS service. <br><br>CoreDNS is now the only supported cluster DNS provider. If you update a cluster to Kubernetes version 1.14 from an earlier version and used KubeDNS, KubeDNS is automatically migrated to CoreDNS during the cluster update. For more information or to test out CoreDNS before you update, see [Configure the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#cluster_dns).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>ed0dafc</td>
<td>Updated image for [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.5-107</td>
<td>v1.14.1-71</td>
<td>Updated to support the Kubernetes 1.14.1 release. Additionally, `calicoctl` version is updated to 3.6.1. Fixed updates to version 2.0 network load balancers (NLBs) with only one available worker node for the load balancer pods. Private load balancers now support running on [private edge workers nodes](/docs/containers?topic=containers-edge#edge).</td>
</tr>
<tr>
<td>IBM pod security policies</td>
<td>N/A</td>
<td>N/A</td>
<td>[IBM pod security policies](/docs/containers?topic=containers-psp#ibm_psp) are updated to support the Kubernetes [RunAsGroup ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups) feature.</td>
</tr>
<tr>
<td>`kubelet` configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the `--pod-max-pids` option to `14336` to prevent a single pod from consuming all process IDs on a worker node.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.5</td>
<td>v1.14.1</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.1) and [Kubernetes 1.14 blog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/blog/2019/03/25/kubernetes-1-14-release-announcement/).<br><br>The Kubernetes default role-based access control (RBAC) policies no longer grant access to [discovery and permission-checking APIs to unauthenticated users ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles). This change applies only to new version 1.14 clusters. If you update a cluster from a prior version, unauthenticated users still have access to the discovery and permission-checking APIs.</td>
</tr>
<tr>
<td>Kubernetes admission controllers configuration</td>
<td>N/A</td>
<td>N/A</td>
<td><ul>
<li>Added `NodeRestriction` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the related cluster resources to support this security enhancement.</li>
<li>Removed `Initializers` from the `--enable-admission-plugins` option and `admissionregistration.k8s.io/v1alpha1=true` from the `--runtime-config` option for the cluster's Kubernetes API server because these APIs are no longer supported. Instead, you can use [Kubernetes admission webhooks ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/).</li></ul></td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.3.0</td>
<td>1.4.0</td>
<td>See the [Kubernetes DNS autoscaler release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.4.0).</td>
</tr>
<tr>
<td>Kubernetes feature gates configuration</td>
<td>N/A</td>
<td>N/A</td>
<td><ul>
  <li>Added `RuntimeClass=false` to disable selection of the container runtime configuration.</li>
  <li>Removed `ExperimentalCriticalPodAnnotation=true` because the `scheduler.alpha.kubernetes.io/critical-pod` pod annotation is no longer supported. Instead, you can use [Kubernetes pod priority ![External link icon](../icons/launch-glyph.svg "External link icon")](/docs/containers?topic=containers-pod_priority#pod_priority).</li></ul></td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>e7182c7</td>
<td>Updated image for [CVE-2019-11068 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068).</td>
</tr>
</tbody>
</table>

<br />


## Archive
{: #changelog_archive}

Unsupported Kubernetes versions:
*  [Version 1.13](#113_changelog)
*  [Version 1.12](#112_changelog)
*  [Version 1.11](#111_changelog)
*  [Version 1.10](#110_changelog)
*  [Version 1.9](#19_changelog)
*  [Version 1.8](#18_changelog)
*  [Version 1.7](#17_changelog)

### Version 1.13 changelog (unsupported 22 February 2020)
{: #113_changelog}

Version 1.13 is unsupported. You can review the following archive of 1.12 changelogs.
{: shortdesc}

*   [Changelog for fix pack 1.13.12_1550, released 17 February 2020](#11312_1550)
*   [Changelog for worker node fix pack 1.13.12_1549, released 3 February 2020](#11312_1549)
*   [Changelog for 1.13.12_1548, released 20 January 2020](#11312_1548)
*   [Changelog for worker node fix pack 1.13.12_1547, released 23 December 2019](#11312_1547)
*   [Changelog for master fix pack 1.13.12_1546, released 17 December 2019](#11312_1546)
*   [Changelog for worker node fix pack 1.13.12_1545, released 9 December 2019](#11312_1545_worker)
*   [Changelog for worker node fix pack 1.13.12_1544, released 25 November 2019](#11312_1544_worker)
*   [Changelog for master fix pack 1.13.12_1544, released 21 November 2019](#11312_1544)
*   [Changelog for worker node fix pack 1.13.12_1541, released 11 November 2019](#11312_1541_worker)
*   [Changelog for worker node fix pack 1.13.12_1540, released 28 October 2019](#11312_1540)
*   [Changelog for master fix pack 1.13.12_1539, released 22 October 2019](#11312_1539)
*   [Changelog for worker node fix pack 1.13.11_1538, released 14 October 2019](#11311_1538_worker)
*   [Changelog for 1.13.11_1537, released 1 October 2019](#11311_1537)
*   [Changelog for worker node fix pack 1.13.10_1536, released 16 September 2019](#11310_1536_worker)
*   [Changelog for worker node fix pack 1.13.10_1535, released 3 September 2019](#11310_1535_worker)
*   [Changelog for master fix pack 1.13.10_1534, released 28 August 2019](#11310_1534)
*   [Changelog for worker node fix pack 1.13.9_1533, released 19 August 2019](#1139_1533_worker)
*   [Changelog for master fix pack 1.13.9_1533, released 17 August 2019](#1139_1533)
*   [Changelog for master fix pack 1.13.9_1532, released 15 August 2019](#1139_1532)
*   [Changelog for worker node fix pack 1.13.8_1530, released 5 August 2019](#1138_1530_worker)
*   [Changelog for worker node fix pack 1.13.8_1529, released 22 July 2019](#1138_1529_worker)
*   [Changelog for master fix pack 1.13.8_1529, released 15 July 2019](#1138_1529)
*   [Changelog for worker node fix pack 1.13.7_1528, released 8 July 2019](#1137_1528)
*   [Changelog for worker node fix pack 1.13.7_1527, released 24 June 2019](#1137_1527)
*   [Changelog for 1.13.7_1526, released 17 June 2019](#1137_1526)
*   [Changelog for 1.13.6_1524, released 4 June 2019](#1136_1524)
*   [Changelog for worker node fix pack 1.13.6_1522, released 20 May 2019](#1136_1522)
*   [Changelog for 1.13.6_1521, released 13 May 2019](#1136_1521)
*   [Changelog for worker node fix pack 1.13.5_1519, released 29 April 2019](#1135_1519)
*   [Changelog for worker node fix pack 1.13.5_1518, released 15 April 2019](#1135_1518)
*   [Changelog for 1.13.5_1517, released 8 April 2019](#1135_1517)
*   [Changelog for worker node fix pack 1.13.4_1516, released 1 April 2019](#1134_1516)
*   [Changelog for master fix pack 1.13.4_1515, released 26 March 2019](#1134_1515)
*   [Changelog for 1.13.4_1513, released 20 March 2019](#1134_1513)
*   [Changelog for 1.13.4_1510, released 4 March 2019](#1134_1510)
*   [Changelog for worker node fix pack 1.13.2_1509, released 27 February 2019](#1132_1509)
*   [Changelog for worker node fix pack 1.13.2_1508, released 15 February 2019](#1132_1508)
*   [Changelog for 1.13.2_1507, released 5 February 2019](#1132_1507)

#### Changelog for fix pack 1.13.12_1550, released 17 February 2020
{: #11312_1550}

The following table shows the changes that are included in the master and worker node fix pack update `1.13.12_1550`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844) and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with  package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712). |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1549" caption-side="top"}

#### Changelog for worker node fix pack 1.13.12_1549, released 3 February 2020
{: #11312_1549}

The following table shows the changes that are included in the worker node fix pack 1.13.12_1549.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://nvd.nist.gov/vuln/detail/CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1548" caption-side="top"}

#### Changelog for 1.13.12_1548, released 20 January 2020
{: #11312_1548}

The following table shows the changes that are included in the master and worker node patch update 1.13.12_1548. Master patch updates are applied automatically. Worker node patch updates can be applied by updating or reloading the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`.</li><li>Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot).</li><li>Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}.</li></ul> |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://nvd.nist.gov/vuln/detail/CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1547" caption-side="top"}

#### Changelog for worker node fix pack 1.13.12_1547, released 23 December 2019
{: #11312_1547}

The following table shows the changes that are included in the worker node fix pack 1.13.12_1547.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://nvd.nist.gov/vuln/detail/CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1545" caption-side="top"}

#### Changelog for master fix pack 1.13.12_1546, released 17 December 2019
{: #11312_1546}

The following table shows the changes that are included in the master fix pack 1.13.12_1546.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_troubleshoot_storage#cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1545" caption-side="top"}

#### Changelog for worker node fix pack 1.13.12_1545, released 9 December 2019
{: #11312_1545_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.12_1545.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1544" caption-side="top"}

#### Changelog for worker node fix pack 1.13.12_1544, released 25 November 2019
{: #11312_1544_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.12_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1541" caption-side="top"}

#### Changelog for master fix pack 1.13.12_1544, released 21 November 2019
{: #11312_1544}

The following table shows the changes that are included in the master fix pack 1.13.12_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor	| 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1541" caption-side="top"}

#### Changelog for worker node fix pack 1.13.12_1541, released 11 November 2019
{: #11312_1541_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.12_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1540" caption-side="top"}

#### Changelog for worker node fix pack 1.13.12_1540, released 28 October 2019
{: #11312_1540}

The following table shows the changes that are included in the worker node fix pack `1.13.12_1540`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |	v1.13.11 |	v1.13.12	| See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.12){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic	| Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.13.12_1539" caption-side="top"}

#### Changelog for master fix pack 1.13.12_1539, released 22 October 2019
{: #11312_1539}

The following table shows the changes that are included in the master fix pack `1.13.12_1539`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you do not need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.11-248 | v1.13.12-268 | Updated to support the Kubernetes 1.13.12 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |	v1.13.11 |	v1.13.12	| See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.12){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/1098759)) and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.13.11_1538" caption-side="top"}

#### Changelog for worker node fix pack 1.13.11_1538, released 14 October 2019
{: #11311_1538_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.13.11_1537">
<caption>Changes since version 1.13.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-0136 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-0136), [CVE-2018-20961 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20961), [CVE-2019-11487 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11487), [CVE-2016-10905 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2016-10905), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.11_1537, released 1 October 2019
{: #11311_1537}

The following table shows the changes that are included in the patch 1.13.11_1537.
{: shortdesc}





<table summary="Changes that were made since version 1.13.10_1536">
<caption>Changes since version 1.13.10_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.4</td>
<td>v3.6.5</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/archive/v3.6/release-notes/).</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to improve performance of master update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.9</td>
<td>v1.2.10</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.10). Update resolves [CVE-2019-16884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884) and [CVE-2019-16276 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276).</td>
</tr>
<tr>
<td>Default IBM file storage class</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.10-221</td>
<td>v1.13.11-248</td>
<td>Updated to support the Kubernetes 1.13.11 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>212</td>
<td>221</td>
<td>Improved Kubernetes [key management service provider](/docs/containers?topic=containers-encryption#keyprotect) caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.10</td>
<td>v1.13.11</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.11).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>148</td>
<td>153</td>
<td>Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-115</td>
<td>2.4.6-r3-IKS-121</td>
<td>Updated images for [CVE-2019-1547 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547) and [CVE-2019-1563 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-15031 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15031), [CVE-2019-15030 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15030), and [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.13.10_1536, released 16 September 2019
{: #11310_1536_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.10_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.13.10_1535">
<caption>Changes since version 1.13.10_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.8</td>
<td>v1.2.9</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.9). Update resolves [CVE-2019-9515 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515).</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2015-9383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2015-9383), [CVE-2019-10638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10638), [CVE-2019-3900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3900), [CVE-2018-20856 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20856), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636),[CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2018-20406 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20406), and [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160), and [CVE-2019-15718 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15718).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.10_1535, released 3 September 2019
{: #11310_1535_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.10_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.13.9_1533">
<caption>Changes since version 1.13.9_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.7</td>
<td>v1.2.8</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.8). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.9</td>
<td>v1.13.10</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.10). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for [CVE-2019-10222 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10222) and [CVE-2019-11922 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11922).</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.13.10_1534, released 28 August 2019
{: #11310_1534}

The following table shows the changes that are included in the master fix pack 1.13.10_1534.
{: shortdesc}

<table summary="Changes that were made since version 1.13.9_1533">
<caption>Changes since version 1.13.9_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`etcd`</td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the [`etcd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.15). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809). Updated the GPU drivers to [430.40 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/Download/driverResults.aspx/149138/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.9-209</td>
<td>v1.13.10-221</td>
<td>Updated to support the Kubernetes 1.13.10 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.9</td>
<td>v1.13.10</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.10). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514)), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.9_1533, released 19 August 2019
{: #1139_1533_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.9_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.13.8_1530">
<caption>Changes since version 1.13.8_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA proxy 1.8 to fix [socket leak in HA proxy ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/haproxy/haproxy/issues/136). Also added a liveliness check to monitor the health of HA proxy. For more information, see [HA proxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.8/src/CHANGELOG).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.8</td>
<td>v1.13.9</td>
<td>For more information, see the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.9).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-13012 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13012), [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-10126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), and [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2019-2101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2101), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-13233 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13233), [CVE-2019-13272 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13272), [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846), [CVE-2019-12818 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12818), [CVE-2019-12984 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12984), and [CVE-2019-12819 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12819).</td>
</tr>
</tbody>
</table>


#### Changelog for master fix pack 1.13.9_1533, released 17 August 2019
{: #1139_1533}

The following table shows the changes that are included in the master fix pack 1.13.9_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.13.9_1532">
<caption>Changes since version 1.13.9_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.13.9_1532, released 15 August 2019
{: #1139_1532}

The following table shows the changes that are included in the master fix pack 1.13.9_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.13.8_1530">
<caption>Changes since version 1.13.8_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>07c9b67</td>
<td>Image updated for [CVE-2019-9924 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924) and [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>{{site.data.keyword.filestorage_full_notm}} plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.8-188</td>
<td>v1.13.9-209</td>
<td>Updated to support the Kubernetes 1.13.9 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.8</td>
<td>v1.13.9</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.9).  Updates resolves [CVE-2019-11247 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967115)) and [CVE-2019-11249 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967123)).</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.13</td>
<td>1.15.4</td>
<td>See the [Kubernetes DNS release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.15.4). Image update resolves [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.8_1530, released 5 August 2019
{: #1138_1530_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.8_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.13.8_1529">
<caption>Changes since version 1.13.8_1529</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-11085 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11085), [CVE-2019-11815 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11815), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-11884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11884), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), and [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-2054 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2054), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), and [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638).</td>
</tr>
</tbody>  
</table>

#### Changelog for worker node fix pack 1.13.8_1529, released 22 July 2019
{: #1138_1529_worker}

The following table shows the changes that are included in the worker node fix pack 1.13.8_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1528">
<caption>Changes since version 1.13.7_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.13.7</td>
<td>v1.13.8</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.8). Update resolves [CVE-2019-11248 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248) (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967113)).</td>
</tr>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for [CVE-2019-13012 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-13012) and [CVE-2019-7307 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-7307.html).</td>
</tr>
  </tbody>
</table>


#### Changelog for master fix pack 1.13.8_1529, released 15 July 2019
{: #1138_1529}

The following table shows the changes that are included in the master fix pack 1.13.8_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1528">
<caption>Changes since version 1.13.7_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.4.4</td>
<td>v3.6.4</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [TTA-2019-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/#TTA-2019-001). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/959551).</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the `kubernetes` zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>5d34347</td>
<td>a7e8ece</td>
<td>Updated base image packages.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.7</td>
<td>v1.13.8</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.8).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.7-162</td>
<td>v1.13.8-188</td>
<td>Updated to support the Kubernetes 1.13.8 release. Additionally, `calicoctl` version is updated to 3.6.4.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.7_1528, released 8 July 2019
{: #1137_1528}

The following table shows the changes that are included in the worker node patch 1.13.7_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1527">
<caption>Changes since version 1.13.7_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.13.7_1527, released 24 June 2019
{: #1137_1527}

The following table shows the changes that are included in the worker node patch 1.13.7_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1526">
<caption>Changes since version 1.13.7_1526</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.6</td>
<td>1.2.7</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.7).</td>
</tr>
<tr>
<td>Max pods</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased the limit of maximum number of pods for worker nodes with more than 11 CPU cores to be 10 pods per core, up to a maximum of 250 pods per worker node.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.7_1526, released 17 June 2019
{: #1137_1526}

The following table shows the changes that are included in the patch 1.13.7_1526.
{: shortdesc}

<table summary="Changes that were made since version 1.13.6_1524">
<caption>Changes since version 1.13.6_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>32257d3</td>
<td>5d34347</td>
<td>Updated image for [CVE-2019-8457 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457). Updated the GPU drivers to [430.14 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/Download/driverResults.aspx/147582/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>346</td>
<td>347</td>
<td>Updated so that the IAM API key can be either encrypted or unencrypted.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.6-139</td>
<td>v1.13.7-162</td>
<td>Updated to support the Kubernetes 1.13.7 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.6</td>
<td>v1.13.7</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.7).</td>
</tr>
<td>Public service endpoint for Kubernetes master</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed an issue to [enable the public service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.6_1524, released 4 June 2019
{: #1136_1524}

The following table shows the changes that are included in the patch 1.13.6_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.13.6_1522">
<caption>Changes since version 1.13.6_1522</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster `create` or `update` operations.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.13).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.1</td>
<td>v0.3.3</td>
<td>See the [Kubernetes Metrics Server release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.6_1522, released 20 May 2019
{: #1136_1522}

The following table shows the changes that are included in the patch 1.13.6_1522.
{: shortdesc}

<table summary="Changes that were made since version 1.13.6_1521">
<caption>Changes since version 1.13.6_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.6_1521, released 13 May 2019
{: #1136_1521}

The following table shows the changes that are included in the patch 1.13.6_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1519">
<caption>Changes since version 1.13.5_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2019-6706 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>55c1f66</td>
<td>Updated image for [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.5-107</td>
<td>v1.13.6-139</td>
<td>Updated to support the Kubernetes 1.13.6 release. Also, fixed the update process for version 2.0 network load balancer that have only one available worker node for the load balancer pods.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.5</td>
<td>v1.13.6</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.6).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>13c7ef0</td>
<td>Updated image for [CVE-2016-7076 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076), [CVE-2017-1000368 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368), and [CVE-2019-11068 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.5_1519, released 29 April 2019
{: #1135_1519}

The following table shows the changes that are included in the worker node fix pack 1.13.5_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1518">
<caption>Changes since version 1.13.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.5</td>
<td>1.2.6</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.6).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.5_1518, released 15 April 2019
{: #1135_1518}

The following table shows the changes that are included in the worker node fix pack 1.13.5_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1517">
<caption>Changes since version 1.13.5_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-3842.html).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.5_1517, released 8 April 2019
{: #1135_1517}

The following table shows the changes that are included in the patch 1.13.5_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1516">
<caption>Changes since version 1.13.4_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.4.0</td>
<td>v3.4.4</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/releases/). Update resolves [CVE-2019-9946 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/879585).</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732), [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734), [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737), [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407), [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543), and [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.4-86</td>
<td>v1.13.5-107</td>
<td>Updated to support the Kubernetes 1.13.5 and Calico 3.4.4 releases.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.4</td>
<td>v1.13.5</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.5).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for [CVE-2017-12447 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.4_1516, released 1 April 2019
{: #1134_1516}

The following table shows the changes that are included in the worker node fix pack 1.13.4_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1515">
<caption>Changes since version 1.13.4_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.13.4_1515, released 26 March 2019
{: #1134_1515}

The following table shows the changes that are included in the master fix pack 1.13.4_1515.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1513">
<caption>Changes since version 1.13.4_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed the update process from Kubernetes version 1.11 to prevent the update from switching the cluster DNS provider to CoreDNS. You can still set up CoreDNS as the cluster DNS provider after the update.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.4_1513, released 20 March 2019
{: #1134_1513}

The following table shows the changes that are included in the patch 1.13.4_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1510">
<caption>Changes since version 1.13.4_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations, such as `refresh` or `update`, to fail when the unused cluster DNS must be scaled down.</td>
</tr>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the CoreDNS configuration to support [multiple Corefiles ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2017/07/23/corefile-explained/) after updating the cluster Kubernetes version from 1.12.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.4</td>
<td>1.2.5</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.5). Update includes improved fix for [CVE-2019-5736 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/871600).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to [418.43 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/object/unix.html). Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9741.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for [private service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se).</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for [CVE-2019-6133 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-6133.html).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for [CVE-2018-16890 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890), [CVE-2019-3822 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822), and [CVE-2019-3823 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for [CVE-2018-10779 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779), [CVE-2018-12900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900), [CVE-2018-17000 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000), [CVE-2018-19210 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210), [CVE-2019-6128 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128), and [CVE-2019-7663 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.4_1510, released 4 March 2019
{: #1134_1510}

The following table shows the changes that are included in the patch 1.13.4_1510.
{: shortdesc}

<table summary="Changes that were made since version 1.13.2_1509">
<caption>Changes since version 1.13.2_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS and CoreDNS pod memory limit from `170Mi` to `400Mi` in order to handle more cluster services.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.2-62</td>
<td>v1.13.4-86</td>
<td>Updated to support the Kubernetes 1.13.4 release. Fixed periodic connectivity problems for version 1.0 load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer version 1.0 and 2.0 events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.2</td>
<td>v1.13.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.4). Update resolves [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486) and [CVE-2019-1002100 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/873324).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `ExperimentalCriticalPodAnnotation=true` to the `--feature-gates` option. This setting helps migrate pods from the deprecated `scheduler.alpha.kubernetes.io/critical-pod` annotation to [Kubernetes pod priority support](/docs/containers?topic=containers-pod_priority#pod_priority).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.2_1509, released 27 February 2019
{: #1132_1509}

The following table shows the changes that are included in the worker node fix pack 1.13.2_1509.
{: shortdesc}

<table summary="Changes that were made since version 1.13.2_1508">
<caption>Changes since version 1.13.2_1508</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for [CVE-2018-19407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.13.2_1508, released 15 February 2019
{: #1132_1508}

The following table shows the changes that are included in the worker node fix pack 1.13.2_1508.
{: shortdesc}

<table summary="Changes that were made since version 1.13.2_1507">
<caption>Changes since version 1.13.2_1507</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the pod configuration `spec.priorityClassName` value to `system-node-critical` and set the `spec.priority` value to `2000001000`.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.2</td>
<td>1.2.4</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.4). Update resolves [CVE-2019-5736 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/871600).</td>
</tr>
<tr>
<td>Kubernetes `kubelet` configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction. Set the `event-qps` option to `0` to prevent rate limiting event creation.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.13.2_1507, released 5 February 2019
{: #1132_1507}

The following table shows the changes that are included in the patch 1.13.2_1507.
{: shortdesc}

<table summary="Changes that were made since version 1.12.4_1535">
<caption>Changes since version 1.12.4_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.1</td>
<td>v3.4.0</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/).</td>
</tr>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>CoreDNS is now the default cluster DNS provider for new clusters. If you update an existing cluster to 1.13 that uses KubeDNS as the cluster DNS provider, KubeDNS continues to be the cluster DNS provider.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.5</td>
<td>1.2.2</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.2).</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>1.2.2</td>
<td>1.2.6</td>
<td>See the [CoreDNS release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coredns/coredns/releases/tag/v1.2.6). Additionally, the CoreDNS configuration is updated to [support multiple Corefiles ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2017/07/23/corefile-explained/).</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.11). Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.4-118</td>
<td>v1.13.2-62</td>
<td>Updated to support the Kubernetes 1.13.2 release. Additionally, `calicoctl` version is updated to 3.4.0. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology).</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li>
<li>Adds a `CriticalAddonsOnly` toleration to the `ibm-file-plugin` and `ibm-storage-watcher` deployments in the `kube-system` namespace.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.4</td>
<td>v1.13.2</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.2).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests.</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.2.0</td>
<td>1.3.0</td>
<td>See the [Kubernetes DNS autoscaler release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.3.0).</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407). Added `CriticalAddonsOnly` toleration to the `vpn` deployment in the `kube-system` namespace. Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407).</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for [CVE-2018-16864 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864).</td>
</tr>
</tbody>
</table>

<br />


### Version 1.12 changelog (unsupported 3 November 2019)
{: #112_changelog}

Version 1.12 is unsupported. You can review the following archive of 1.12 changelogs.
{: shortdesc}

*   [Changelog for worker node fix pack 1.12.10_1570, released 28 October 2019](#11210_1570)
*   [Changelog for worker node fix pack 1.12.10_1569, released 14 October 2019](#11210_1569_worker)
*   [Changelog for worker node fix pack 1.12.10_1568, released 1 October 2019](#11210_1568_worker)
*   [Changelog for worker node fix pack 1.12.10_1567, released 16 September 2019](#11210_1567_worker)
*   [Changelog for worker node fix pack 1.12.10_1566, released 3 September 2019](#11210_1566_worker)
*   [Changelog for master fix pack 1.12.10_1565, released 28 August 2019](#11210_1565)
*   [Changelog for worker node fix pack 1.12.10_1564, released 19 August 2019](#11210_1564_worker)
*   [Changelog for master fix pack 1.12.10_1564, released 17 August 2019](#11210_1564)
*   [Changelog for master fix pack 1.12.10_1563, released 15 August 2019](#11210_1563)
*   [Changelog for worker node fix pack 1.12.10_1561, released 5 August 2019](#11210_1561_worker)
*   [Changelog for worker node fix pack 1.12.10_1560, released 22 July 2019](#11210_1560_worker)
*   [Changelog for master fix pack 1.12.10_1560, released 15 July 2019](#11210_1560)
*   [Changelog for worker node fix pack 1.12.9_1559, released 8 July 2019](#1129_1559)
*   [Changelog for worker node fix pack 1.12.9_1558, released 24 June 2019](#1129_1558)
*   [Changelog for 1.12.9_1557, released 17 June 2019](#1129_1557)
*   [Changelog for 1.12.9_1555, released 4 June 2019](#1129_1555)
*   [Changelog for worker node fix pack 1.12.8_1553, released 20 May 2019](#1128_1533)
*   [Changelog for 1.12.8_1552, released 13 May 2019](#1128_1552)
*   [Changelog for worker node fix pack 1.12.7_1550, released 29 April 2019](#1127_1550)
*   [Changelog for worker node fix pack 1.12.7_1549, released 15 April 2019](#1127_1549)
*   [Changelog for 1.12.7_1548, released 8 April 2019](#1127_1548)
*   [Changelog for worker node fix pack 1.12.6_1547, released 1 April 2019](#1126_1547)
*   [Changelog for master fix pack 1.12.6_1546, released 26 March 2019](#1126_1546)
*   [Changelog for 1.12.6_1544, released 20 March 2019](#1126_1544)
*   [Changelog for 1.12.6_1541, released 4 March 2019](#1126_1541)
*   [Changelog for worker node fix pack 1.12.5_1540, released 27 February 2019](#1125_1540)
*   [Changelog for worker node fix pack 1.12.5_1538, released 15 February 2019](#1125_1538)
*   [Changelog for 1.12.5_1537, released 5 February 2019](#1125_1537)
*   [Changelog for worker node fix pack 1.12.4_1535, released 28 January 2019](#1124_1535)
*   [Changelog for 1.12.4_1534, released 21 January 2019](#1124_1534)
*   [Changelog for worker node fix pack 1.12.3_1533, released 7 January 2019](#1123_1533)
*   [Changelog for worker node fix pack 1.12.3_1532, released 17 December 2018](#1123_1532)
*   [Changelog for 1.12.3_1531, released 5 December 2018](#1123_1531)
*   [Changelog for worker node fix pack 1.12.2_1530, released 4 December 2018](#1122_1530)
*   [Changelog for 1.12.2_1529, released 27 November 2018](#1122_1529)
*   [Changelog for worker node fix pack 1.12.2_1528, released 19 November 2018](#1122_1528)
*   [Changelog for 1.12.2_1527, released 7 November 2018](#1122_1527)

#### Changelog for worker node fix pack 1.12.10_1570, released 28 October 2019
{: #11210_1570}

The following table shows the changes that are included in the worker node fix pack `1.12.10_1570`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic	| Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.12.10_1569" caption-side="top"}

#### Changelog for worker node fix pack 1.12.10_1569, released 14 October 2019
{: #11210_1569_worker}

The following table shows the changes that are included in the worker node fix pack 1.12.10_1569.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1568">
<caption>Changes since version 1.12.10_1568</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-0136 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-0136), [CVE-2018-20961 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20961), [CVE-2019-11487 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11487), [CVE-2016-10905 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2016-10905), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5094 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5094), [CVE-2018-20976 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20976), [CVE-2019-16056 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16056), and [CVE-2019-16935 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-16935).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.10_1568, released 1 October 2019
{: #11210_1568_worker}

The following table shows the changes that are included in the patch 1.12.10_1568.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1567">
<caption>Changes since version 1.12.10_1567</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-15031 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15031), [CVE-2019-15030 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15030), and [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-14835 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14835).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.10_1567, released 16 September 2019
{: #11210_1567_worker}

The following table shows the changes that are included in the worker node fix pack 1.12.10_1567.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1566">
<caption>Changes since version 1.12.10_1566</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2015-9383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2015-9383), [CVE-2019-10638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10638), [CVE-2019-3900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3900), [CVE-2018-20856 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20856), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636),[CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2018-20406 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20406), and [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160).</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-5481 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5481), [CVE-2019-5482 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5482), [CVE-2019-15903 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15903), [CVE-2019-14283 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14283), [CVE-2019-14284 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-14284), [CVE-2018-20852 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-20852), [CVE-2019-5010 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-5010), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-9740 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9740), [CVE-2019-9947 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9947), [CVE-2019-9948 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9948), [CVE-2019-9636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-9636), [CVE-2019-10160 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10160), and [CVE-2019-15718 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-15718).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.10_1566, released 3 September 2019
{: #11210_1566_worker}

The following table shows the changes that are included in the worker node fix pack 1.12.10_1566.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1564">
<caption>Changes since version 1.12.10_1564</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for [CVE-2019-10222 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10222) and [CVE-2019-11922 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11922).</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.12.10_1565, released 28 August 2019
{: #11210_1565}

The following table shows the changes that are included in the master fix pack 1.12.10_1565.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1564">
<caption>Changes since version 1.12.10_1564</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`etcd`</td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the [`etcd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.15). Update resolves [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809). Updated the GPU drivers to [430.40 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/Download/driverResults.aspx/149138/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for [CVE-2019-9512 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512), [CVE-2019-9514 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514), and [CVE-2019-14809 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.10_1564, released 19 August 2019
{: #11210_1564_worker}

The following table shows the changes that are included in the worker node fix pack 1.12.10_1564.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1561">
<caption>Changes since version 1.12.10_1561</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA proxy 1.8 to fix [socket leak in HA proxy ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/haproxy/haproxy/issues/136). Also added a liveliness check to monitor the health of HA proxy. For more information, see [HA proxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.8/src/CHANGELOG).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-13012 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13012), [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-10126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), and [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-1125 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-1125), [CVE-2019-2101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2101), [CVE-2018-5383 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2018-5383), [CVE-2019-13233 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13233), [CVE-2019-13272 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13272), [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126), [CVE-2019-3846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-3846), [CVE-2019-12818 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12818), [CVE-2019-12984 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12984), and [CVE-2019-12819 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-12819).</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.12.10_1564, released 17 August 2019
{: #11210_1564}

The following table shows the changes that are included in the master fix pack 1.12.10_1564.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1563">
<caption>Changes since version 1.12.10_1563</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.12.10_1563, released 15 August 2019
{: #11210_1563}

The following table shows the changes that are included in the master fix pack 1.12.10_1563.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1561">
<caption>Changes since version 1.12.10_1561</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>07c9b67</td>
<td>Image updated for [CVE-2019-9924 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924) and [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.13</td>
<td>1.15.4</td>
<td>See the [Kubernetes DNS release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.15.4). Image update resolves [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.2.0</td>
<td>1.3.0</td>
<td>See the [Kubernetes DNS autoscaler release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.3.0). Image update resolves [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for [CVE-2019-14697 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.10_1561, released 5 August 2019
{: #11210_1561_worker}

The following table shows the changes that are included in the worker node fix pack 1.12.10_1561.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1560">
<caption>Changes since version 1.12.10_1560</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-11085 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11085), [CVE-2019-11815 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11815), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-11884 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11884), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638), and [CVE-2019-2054 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2054).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for [CVE-2019-2054 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-2054), [CVE-2019-11833 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-11833), [CVE-2019-13057 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13057), [CVE-2019-13565 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13565), [CVE-2019-13636 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13636), and [CVE-2019-13638 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://nvd.nist.gov/vuln/detail/CVE-2019-13638).</td>
</tr>
</tbody>  
</table>

#### Changelog for worker node fix pack 1.12.10_1560, released 22 July 2019
{: #11210_1560_worker}

The following table shows the changes that are included in the worker node fix pack 1.12.10_1560.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1559">
<caption>Changes since version 1.12.9_1559</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.12.9</td>
<td>v1.12.10</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.10). Update resolves [CVE-2019-11248 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248). For more information, see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/967113)).</td>
</tr>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for [CVE-2019-13012 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-13012) and [CVE-2019-7307 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-7307.html).</td>
</tr>
  </tbody>
</table>


#### Changelog for master fix pack 1.12.10_1560, released 15 July 2019
{: #11210_1560}

The following table shows the changes that are included in the master fix pack 1.12.10_1560.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1559">
<caption>Changes since version 1.12.9_1559</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.6</td>
<td>v3.6.4</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [TTA-2019-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/#TTA-2019-001). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/959551).</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the `kubernetes` zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize).
</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>5d34347</td>
<td>a7e8ece</td>
<td>Updated base image packages.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.9</td>
<td>v1.12.10</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.10).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.9-227</td>
<td>v1.12.10-259</td>
<td>Updated to support the Kubernetes 1.12.10 release. Additionally, `calicoctl` version is updated to 3.6.4.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.9_1559, released 8 July 2019
{: #1129_1559}

The following table shows the changes that are included in the worker node patch 1.12.9_1559.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1558">
<caption>Changes since version 1.12.9_1558</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.9_1558, released 24 June 2019
{: #1129_1558}

The following table shows the changes that are included in the worker node patch 1.12.9_1558.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1557">
<caption>Changes since version 1.12.9_1557</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/958863).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.6</td>
<td>1.2.7</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.7).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.12.9_1557, released 17 June 2019
{: #1129_1557}

The following table shows the changes that are included in the patch 1.12.9_1557.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1555">
<caption>Changes since version 1.12.9_1555</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>32257d3</td>
<td>5d34347</td>
<td>Updated image for [CVE-2019-8457 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457). Updated the GPU drivers to [430.14 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/Download/driverResults.aspx/147582/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>346</td>
<td>347</td>
<td>Updated so that the IAM API key can be either encrypted or unencrypted.</td>
</tr>
<td>Public service endpoint for Kubernetes master</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed an issue to [enable the public service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.12.9_1555, released 4 June 2019
{: #1129_1555}

The following table shows the changes that are included in the patch 1.12.9_1555.
{: shortdesc}

<table summary="Changes that were made since version 1.12.8_1553">
<caption>Changes since version 1.12.8_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster `create` or `update` operations.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.13).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.8-210</td>
<td>v1.12.9-227</td>
<td>Updated to support the Kubernetes 1.12.9 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.8</td>
<td>v1.12.9</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.9).</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.1</td>
<td>v0.3.3</td>
<td>See the [Kubernetes Metrics Server release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.8_1553, released 20 May 2019
{: #1128_1533}

The following table shows the changes that are included in the patch 1.12.8_1553.
{: shortdesc}

<table summary="Changes that were made since version 1.12.8_1553">
<caption>Changes since version 1.12.8_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.12.8_1552, released 13 May 2019
{: #1128_1552}

The following table shows the changes that are included in the patch 1.12.8_1552.
{: shortdesc}

<table summary="Changes that were made since version 1.12.7_1550">
<caption>Changes since version 1.12.7_1550</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2019-6706 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>55c1f66</td>
<td>Updated image for [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.7-180</td>
<td>v1.12.8-210</td>
<td>Updated to support the Kubernetes 1.12.8 release. Also, fixed the update process for version 2.0 network load balancer that have only one available worker node for the load balancer pods.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.7</td>
<td>v1.12.8</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.8).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>13c7ef0</td>
<td>Updated image for [CVE-2016-7076 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076), [CVE-2017-1000368 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368), and [CVE-2019-11068 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.7_1550, released 29 April 2019
{: #1127_1550}

The following table shows the changes that are included in the worker node fix pack 1.12.7_1550.
{: shortdesc}

<table summary="Changes that were made since version 1.12.7_1549">
<caption>Changes since version 1.12.7_1549</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.6</td>
<td>1.1.7</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.7).</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.12.7_1549, released 15 April 2019
{: #1127_1549}

The following table shows the changes that are included in the worker node fix pack 1.12.7_1549.
{: shortdesc}

<table summary="Changes that were made since version 1.12.7_1548">
<caption>Changes since version 1.12.7_1548</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-3842.html).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.12.7_1548, released 8 April 2019
{: #1127_1548}

The following table shows the changes that are included in the patch 1.12.7_1548.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1547">
<caption>Changes since version 1.12.6_1547</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.1</td>
<td>v3.3.6</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [CVE-2019-9946 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/879585).</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732), [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734), [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737), [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407), [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543), and [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.6-157</td>
<td>v1.12.7-180</td>
<td>Updated to support the Kubernetes 1.12.7 and Calico 3.3.6 releases.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.6</td>
<td>v1.12.7</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.7).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for [CVE-2017-12447 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.6_1547, released 1 April 2019
{: #1126_1547}

The following table shows the changes that are included in the worker node fix pack 1.12.6_1547.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1546">
<caption>Changes since version 1.12.6_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>


#### Changelog for master fix pack 1.12.6_1546, released 26 March 2019
{: #1126_1546}

The following table shows the changes that are included in the master fix pack 1.12.6_1546.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1544">
<caption>Changes since version 1.12.6_1544</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.12.6_1544, released 20 March 2019
{: #1126_1544}

The following table shows the changes that are included in the patch 1.12.6_1544.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1541">
<caption>Changes since version 1.12.6_1541</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations, such as `refresh` or `update`, to fail when the unused cluster DNS must be scaled down.</td>
</tr>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the CoreDNS configuration to support [multiple Corefiles ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2017/07/23/corefile-explained/).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to [418.43 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/object/unix.html). Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9741.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for [private service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se).</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for [CVE-2019-6133 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-6133.html).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for [CVE-2018-16890 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890), [CVE-2019-3822 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822), and [CVE-2019-3823 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for [CVE-2018-10779 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779), [CVE-2018-12900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900), [CVE-2018-17000 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000), [CVE-2018-19210 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210), [CVE-2019-6128 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128), and [CVE-2019-7663 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.12.6_1541, released 4 March 2019
{: #1126_1541}

The following table shows the changes that are included in the patch 1.12.6_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.12.5_1540">
<caption>Changes since version 1.12.5_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS and CoreDNS pod memory limit from `170Mi` to `400Mi` in order to handle more cluster services.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.5-137</td>
<td>v1.12.6-157</td>
<td>Updated to support the Kubernetes 1.12.6 release. Fixed periodic connectivity problems for version 1.0 load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer version 1.0 and 2.0 events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.5</td>
<td>v1.12.6</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.6). Update resolves [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486) and [CVE-2019-1002100 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/873324).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `ExperimentalCriticalPodAnnotation=true` to the `--feature-gates` option. This setting helps migrate pods from the deprecated `scheduler.alpha.kubernetes.io/critical-pod` annotation to [Kubernetes pod priority support](/docs/containers?topic=containers-pod_priority#pod_priority).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.5_1540, released 27 February 2019
{: #1125_1540}

The following table shows the changes that are included in the worker node fix pack 1.12.5_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.12.5_1538">
<caption>Changes since version 1.12.5_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for [CVE-2018-19407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.5_1538, released 15 February 2019
{: #1125_1538}

The following table shows the changes that are included in the worker node fix pack 1.12.5_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.12.5_1537">
<caption>Changes since version 1.12.5_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the pod configuration `spec.priorityClassName` value to `system-node-critical` and set the `spec.priority` value to `2000001000`.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.5</td>
<td>1.1.6</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.6). Update resolves [CVE-2019-5736 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/871600).</td>
</tr>
<tr>
<td>Kubernetes `kubelet` configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.12.5_1537, released 5 February 2019
{: #1125_1537}

The following table shows the changes that are included in the patch 1.12.5_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.12.4_1535">
<caption>Changes since version 1.12.4_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.11). Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.4-118</td>
<td>v1.12.5-137</td>
<td>Updated to support the Kubernetes 1.12.5 release. Additionally, `calicoctl` version is updated to 3.3.1. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology).</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.4</td>
<td>v1.12.5</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.5).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407). Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407).</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for [CVE-2018-16864 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.4_1535, released 28 January 2019
{: #1124_1535}

The following table shows the changes that are included in the worker node fix pack 1.12.4_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.12.4_1534">
<caption>Changes since version 1.12.4_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [USN-3863-1 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3863-1).</td>
</tr>
</tbody>
</table>


#### Changelog for 1.12.4_1534, released 21 January 2019
{: #1124_1534}

The following table shows the changes that are included in the patch 1.12.3_1534.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1533">
<caption>Changes since version 1.12.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.3-91</td>
<td>v1.12.4-118</td>
<td>Updated to support the Kubernetes 1.12.4 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.3</td>
<td>v1.12.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.4).</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the [Kubernetes add-on resizer release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4).</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the [Kubernetes dashboard release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1). Update resolves [CVE-2018-18264 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264).</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.3_1533, released 7 January 2019
{: #1123_1533}

The following table shows the changes that are included in the worker node fix pack 1.12.3_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1532">
<caption>Changes since version 1.12.3_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.3_1532, released 17 December 2018
{: #1123_1532}

The following table shows the changes that are included in the worker node fix pack 1.12.2_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1531">
<caption>Changes since version 1.12.3_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


#### Changelog for 1.12.3_1531, released 5 December 2018
{: #1123_1531}

The following table shows the changes that are included in the patch 1.12.3_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1530">
<caption>Changes since version 1.12.2_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.2-68</td>
<td>v1.12.3-91</td>
<td>Updated to support the Kubernetes 1.12.3 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.2</td>
<td>v1.12.3</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.3). Update resolves [CVE-2018-1002105 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/71411). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/743917).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.2_1530, released 4 December 2018
{: #1122_1530}

The following table shows the changes that are included in the worker node fix pack 1.12.2_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1529">
<caption>Changes since version 1.12.2_1529</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>



#### Changelog for 1.12.2_1529, released 27 November 2018
{: #1122_1529}

The following table shows the changes that are included in patch 1.12.2_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1528">
<caption>Changes since version 1.12.2_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/). For more information, see the [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/740799).</td>
</tr>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that could result in both Kubernetes DNS and CoreDNS pods to run after cluster creation or update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.0</td>
<td>v1.1.5</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.5). Updated containerd to fix a deadlock that can [stop pods from terminating ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/issues/2744).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.12.2_1528, released 19 November 2018
{: #1122_1528}

The following table shows the changes that are included in the worker node fix pack 1.12.2_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1527">
<caption>Changes since version 1.12.2_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>


#### Changelog for 1.12.2_1527, released 7 November 2018
{: #1122_1527}

The following table shows the changes that are included in patch 1.12.2_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1533">
<caption>Changes since version 1.11.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico `calico-*` pods in the `kube-system` namespace now set CPU and memory resource requests for all containers.</td>
</tr>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Kubernetes DNS (KubeDNS) remains the default cluster DNS provider..</td>
</tr>
<tr>
<td>Cluster metrics provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Kubernetes Metrics Server replaces Kubernetes Heapster (deprecated since Kubernetes version 1.8) as the cluster metrics provider.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.4</td>
<td>1.2.0</td>
<td>See the [containerd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.0).</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>N/A</td>
<td>1.2.2</td>
<td>See the [CoreDNS release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coredns/coredns/releases/tag/v1.2.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.12.2</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.2).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added three new IBM pod security policies and their associated cluster roles. For more information, see [Understanding default resources for IBM cluster management](/docs/containers?topic=containers-psp#ibm_psp).</td>
</tr>
<tr>
<td>Kubernetes Dashboard</td>
<td>v1.8.3</td>
<td>v1.10.0</td>
<td>See the [Kubernetes Dashboard release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.0).<br><br>
If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers?topic=containers-deploy_app#cli_dashboard). Additionally, you can now scale up the number of Kubernetes Dashboard pods by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.10</td>
<td>1.14.13</td>
<td>See the [Kubernetes DNS release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.14.13).</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>N/A</td>
<td>v0.3.1</td>
<td>See the [Kubernetes Metrics Server release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.1).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-118</td>
<td>v1.12.2-68</td>
<td>Updated to support the Kubernetes 1.12 release. Additional changes include the following:
<ul><li>Load balancer pods (`ibm-cloud-provider-ip-*` in `ibm-system` namespace) now set CPU and memory resource requests.</li>
<li>The `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation is added to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlan ls --zone <zone>`.</li>
<li>A new [load balancer 2.0](/docs/containers?topic=containers-loadbalancer-about#planning_ipvs) is available as a beta.</li></ul></td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>OpenVPN client `vpn-* pod` in the `kube-system` namespace now sets CPU and memory resource requests.</td>
</tr>
</tbody>
</table>

### Version 1.11 changelog (unsupported as of 20 July 2019)
{: #111_changelog}

Review the version 1.11 changelog.
{: shortdesc}

*   [Changelog for worker node fix pack 1.11.10_1564, released 8 July 2019](#11110_1564)
*   [Changelog for worker node fix pack 1.11.10_1563, released 24 June 2019](#11110_1563)
*   [Changelog for worker node fix pack 1.11.10_1562, released 17 June 2019](#11110_1562)
*   [Changelog for 1.11.10_1561, released 4 June 2019](#11110_1561)
*   [Changelog for worker node fix pack 1.11.10_1559, released 20 May 2019](#11110_1559)
*   [Changelog for 1.11.10_1558, released 13 May 2019](#11110_1558)
*   [Changelog for worker node fix pack 1.11.9_1556, released 29 April 2019](#1119_1556)
*   [Changelog for worker node fix pack 1.11.9_1555, released 15 April 2019](#1119_1555)
*   [Changelog for 1.11.9_1554, released 8 April 2019](#1119_1554)
*   [Changelog for worker node fix pack 1.11.8_1553, released 1 April 2019](#1118_1553)
*   [Changelog for master fix pack 1.11.8_1552, released 26 March 2019](#1118_1552)
*   [Changelog for 1.11.8_1550, released 20 March 2019](#1118_1550)
*   [Changelog for 1.11.8_1547, released 4 March 2019](#1118_1547)
*   [Changelog for worker node fix pack 1.11.7_1546, released 27 February 2019](#1117_1546)
*   [Changelog for worker node fix pack 1.11.7_1544, released 15 February 2019](#1117_1544)
*   [Changelog for 1.11.7_1543, released 5 February 2019](#1117_1543)
*   [Changelog for worker node fix pack 1.11.6_1541, released 28 January 2019](#1116_1541)
*   [Changelog for 1.11.6_1540, released 21 January 2019](#1116_1540)
*   [Changelog for worker node fix pack 1.11.5_1539, released 7 January 2019](#1115_1539)
*   [Changelog for worker node fix pack 1.11.5_1538, released 17 December 2018](#1115_1538)
*   [Changelog for 1.11.5_1537, released 5 December 2018](#1115_1537)
*   [Changelog for worker node fix pack 1.11.4_1536, released 4 December 2018](#1114_1536)
*   [Changelog for 1.11.4_1535, released 27 November 2018](#1114_1535)
*   [Changelog for worker node fix pack 1.11.3_1534, released 19 November 2018](#1113_1534)
*   [Changelog for 1.11.3_1533, released 7 November 2018](#1113_1533)
*   [Changelog for master fix pack 1.11.3_1531, released 1 November 2018](#1113_1531_ha-master)
*   [Changelog for worker node fix pack 1.11.3_1531, released 26 October 2018](#1113_1531)
*   [Changelog for master fix pack 1.11.3_1527, released 15 October 2018](#1113_1527)
*   [Changelog for worker node fix pack 1.11.3_1525, released 10 October 2018](#1113_1525)
*   [Changelog for 1.11.3_1524, released 2 October 2018](#1113_1524)
*   [Changelog for 1.11.3_1521, released 20 September 2018](#1113_1521)
*   [Changelog for 1.11.2_1516, released 4 September 2018](#1112_1516)
*   [Changelog for worker node fix pack 1.11.2_1514, released 23 August 2018](#1112_1514)
*   [Changelog for 1.11.2_1513, released 14 August 2018](#1112_1513)

#### Changelog for worker node fix pack 1.11.10_1564, released 8 July 2019
{: #11110_1564}

The following table shows the changes that are included in the worker node patch 1.11.10_1564.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1563">
<caption>Changes since version 1.11.10_1563</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html) and [CVE-2019-11479 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11479.html).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.10_1563, released 24 June 2019
{: #11110_1563}

The following table shows the changes that are included in the worker node patch 1.11.10_1563.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1562">
<caption>Changes since version 1.11.10_1562</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-11477 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11477.html) and [CVE-2019-11478 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-11478.html).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.10_1562, released 17 June 2019
{: #11110_1562}

The following table shows the changes that are included in the worker node patch 1.11.10_1562.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1561">
<caption>Changes since version 1.11.10_1561</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for [CVE-2019-10906 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-10906.html?_ga=2.184456110.929090212.1560547312-1880639276.1557078470).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.10_1561, released 4 June 2019
{: #11110_1561}

The following table shows the changes that are included in the patch 1.11.10_1561.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1559">
<caption>Changes since version 1.11.10_1559</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.13).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for [CVE-2018-10844 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844), [CVE-2018-10845 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845), [CVE-2018-10846 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846), [CVE-2019-3829 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829), [CVE-2019-3836 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836), [CVE-2019-9893 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893), [CVE-2019-5435 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435), and [CVE-2019-5436 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.10_1559, released 20 May 2019
{: #11110_1559}

The following table shows the changes that are included in the patch pack 1.11.10_1559.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1558">
<caption>Changes since version 1.11.10_1558</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for [CVE-2018-12126 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12126.html), [CVE-2018-12127 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12127.html), and [CVE-2018-12130 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2018/CVE-2018-12130.html).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.10_1558, released 13 May 2019
{: #11110_1558}

The following table shows the changes that are included in the patch 1.11.10_1558.
{: shortdesc}

<table summary="Changes that were made since version 1.11.9_1556">
<caption>Changes since version 1.11.9_1556</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2019-6706 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>55c1f66</td>
<td>Updated image for [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.9-241</td>
<td>v1.11.10-270</td>
<td>Updated to support the Kubernetes 1.11.10 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.9</td>
<td>v1.11.10</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.10).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>13c7ef0</td>
<td>Updated image for [CVE-2016-7076 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076), [CVE-2017-1000368 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368), and [CVE-2019-11068 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.9_1556, released 29 April 2019
{: #1119_1556}

The following table shows the changes that are included in the worker node fix pack 1.11.9_1556.
{: shortdesc}

<table summary="Changes that were made since version 1.11.9_1555">
<caption>Changes since version 1.11.9_1555</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.6</td>
<td>1.1.7</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.7).</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.11.9_1555, released 15 April 2019
{: #1119_1555}

The following table shows the changes that are included in the worker node fix pack 1.11.9_1555.
{: shortdesc}

<table summary="Changes that were made since version 1.11.9_1554">
<caption>Changes since 1.11.9_1554</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-3842.html).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.9_1554, released 8 April 2019
{: #1119_1554}

The following table shows the changes that are included in the patch 1.11.9_1554.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1553">
<caption>Changes since version 1.11.8_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.1</td>
<td>v3.3.6</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [CVE-2019-9946 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946).</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732), [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734), [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737), [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407), [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543), and [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.8-219</td>
<td>v1.11.9-241</td>
<td>Updated to support the Kubernetes 1.11.9 and Calico 3.3.6 releases.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.8</td>
<td>v1.11.9</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.9).</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.10</td>
<td>1.14.13</td>
<td>See the [Kubernetes DNS release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.14.13).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for [CVE-2017-12447 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.8_1553, released 1 April 2019
{: #1118_1553}

The following table shows the changes that are included in the worker node fix 1.11.8_1553.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1552">
<caption>Changes since version 1.11.8_1552</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.11.8_1552, released 26 March 2019
{: #1118_1552}

The following table shows the changes that are included in the master fix pack 1.11.8_1552.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1550">
<caption>Changes since version 1.11.8_1550</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.8_1550, released 20 March 2019
{: #1118_1550}

The following table shows the changes that are included in the patch 1.11.8_1550.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1547">
<caption>Changes since version 1.11.8_1547</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to [418.43 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/object/unix.html). Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9741.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for [private service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se).</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for [CVE-2019-6133 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-6133.html).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for [CVE-2018-16890 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890), [CVE-2019-3822 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822), and [CVE-2019-3823 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for [CVE-2018-10779 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779), [CVE-2018-12900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900), [CVE-2018-17000 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000), [CVE-2018-19210 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210), [CVE-2019-6128 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128), and [CVE-2019-7663 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.8_1547, released 4 March 2019
{: #1118_1547}

The following table shows the changes that are included in the patch 1.11.8_1547.
{: shortdesc}

<table summary="Changes that were made since version 1.11.7_1546">
<caption>Changes since version 1.11.7_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.7-198</td>
<td>v1.11.8-219</td>
<td>Updated to support the Kubernetes 1.11.8 release. Fixed periodic connectivity problems for load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.7</td>
<td>v1.11.8</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.8). Update resolves [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486) and [CVE-2019-1002100 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `ExperimentalCriticalPodAnnotation=true` to the `--feature-gates` option. This setting helps migrate pods from the deprecated `scheduler.alpha.kubernetes.io/critical-pod` annotation to [Kubernetes pod priority support](/docs/containers?topic=containers-pod_priority#pod_priority).</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS pod memory limit from `170Mi` to `400Mi` in order to handle more cluster services.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.7_1546, released 27 February 2019
{: #1117_1546}

The following table shows the changes that are included in the worker node fix pack 1.11.7_1546.
{: shortdesc}

<table summary="Changes that were made since version 1.11.7_1546">
<caption>Changes since version 1.11.7_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for [CVE-2018-19407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.7_1544, released 15 February 2019
{: #1117_1544}

The following table shows the changes that are included in the worker node fix pack 1.11.7_1544.
{: shortdesc}

<table summary="Changes that were made since version 1.11.7_1543">
<caption>Changes since version 1.11.7_1543</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the pod configuration `spec.priorityClassName` value to `system-node-critical` and set the `spec.priority` value to `2000001000`.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.5</td>
<td>1.1.6</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.6). Update resolves [CVE-2019-5736 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736).</td>
</tr>
<tr>
<td>Kubernetes `kubelet` configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.7_1543, released 5 February 2019
{: #1117_1543}

The following table shows the changes that are included in the patch 1.11.7_1543.
{: shortdesc}

<table summary="Changes that were made since version 1.11.6_1541">
<caption>Changes since version 1.11.6_1541</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.11). Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.6-180</td>
<td>v1.11.7-198</td>
<td>Updated to support the Kubernetes 1.11.7 release. Additionally, `calicoctl` version is updated to 3.3.1. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology).</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.6</td>
<td>v1.11.7</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.7).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407). Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407).</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for [CVE-2018-16864 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.6_1541, released 28 January 2019
{: #1116_1541}

The following table shows the changes that are included in the worker node fix pack 1.11.6_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.11.6_1540">
<caption>Changes since version 1.11.6_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) / [USN-3863-1 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3863-1).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.6_1540, released 21 January 2019
{: #1116_1540}

The following table shows the changes that are included in the patch 1.11.6_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1539">
<caption>Changes since version 1.11.5_1539</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.5-152</td>
<td>v1.11.6-180</td>
<td>Updated to support the Kubernetes 1.11.6 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.5</td>
<td>v1.11.6</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.6).</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the [Kubernetes add-on resizer release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4).</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the [Kubernetes dashboard release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1). Update resolves [CVE-2018-18264 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264).<br><br>If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers?topic=containers-deploy_app#cli_dashboard).</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.5_1539, released 7 January 2019
{: #1115_1539}

The following table shows the changes that are included in the worker node fix pack 1.11.5_1539.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1538">
<caption>Changes since version 1.11.5_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.5_1538, released 17 December 2018
{: #1115_1538}

The following table shows the changes that are included in the worker node fix pack 1.11.5_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1537">
<caption>Changes since version 1.11.5_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.5_1537, released 5 December 2018
{: #1115_1537}

The following table shows the changes that are included in the patch 1.11.5_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.11.4_1536">
<caption>Changes since version 1.11.4_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.4-142</td>
<td>v1.11.5-152</td>
<td>Updated to support the Kubernetes 1.11.5 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.4</td>
<td>v1.11.5</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.5). Update resolves [CVE-2018-1002105 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.4_1536, released 4 December 2018
{: #1114_1536}

The following table shows the changes that are included in the worker node fix pack 1.11.4_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.11.4_1535">
<caption>Changes since version 1.11.4_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.4_1535, released 27 November 2018
{: #1114_1535}

The following table shows the changes that are included in patch 1.11.4_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1534">
<caption>Changes since version 1.11.3_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.1.4</td>
<td>v1.1.5</td>
<td>See the [containerd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.5). Updated containerd to fix a deadlock that can [stop pods from terminating ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/issues/2744).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-127</td>
<td>v1.11.4-142</td>
<td>Updated to support the Kubernetes 1.11.4 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.11.4</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.4).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.3_1534, released 19 November 2018
{: #1113_1534}

The following table shows the changes that are included in the worker node fix pack 1.11.3_1534.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1533">
<caption>Changes since version 1.11.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>


#### Changelog for 1.11.3_1533, released 7 November 2018
{: #1113_1533}

The following table shows the changes that are included in patch 1.11.3_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1531">
<caption>Changes since version 1.11.3_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed the update to highly available (HA) masters for clusters that use admission webhooks such as `initializerconfigurations`, `mutatingwebhookconfigurations`, or `validatingwebhookconfigurations`. You might use these webhooks with Helm charts such as for [Container Image Security Enforcement](/docs/Registry?topic=Registry-security_enforce#security_enforce).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-100</td>
<td>v1.11.3-127</td>
<td>Added the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlan ls --zone <zone>`.</td>
</tr>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable) on an existing cluster, you need to [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks flavors --zone` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_machine_types).</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.11.3_1531, released 1 November 2018
{: #1113_1531_ha-master}

The following table shows the changes that are included in the master fix pack 1.11.3_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1527">
<caption>Changes since version 1.11.3_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts.</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Added an `ibm-master-proxy-*` pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>See the [etcd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.1).</td>
</tr>
<tr>
<td>Encrypting data in etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, [enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster](/docs/containers?topic=containers-encryption#keyprotect).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.3_1531, released 26 October 2018
{: #1113_1531}

The following table shows the changes that are included in the worker node fix pack 1.11.3_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1525">
<caption>Changes since version 1.11.3_1525</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.11.3_1527, released 15 October 2018
{: #1113_1527}

The following table shows the changes that are included in the master fix pack 1.11.3_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1524">
<caption>Changes since version 1.11.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed `calico-node` container readiness probe to better handle node failures.</td>
</tr>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.3_1525, released 10 October 2018
{: #1113_1525}

The following table shows the changes that are included in the worker node fix pack 1.11.3_1525.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1524">
<caption>Changes since version 1.11.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


#### Changelog for 1.11.3_1524, released 2 October 2018
{: #1113_1524}

The following table shows the changes that are included in patch 1.11.3_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1521">
<caption>Changes since version 1.11.3_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>1.1.3</td>
<td>1.1.4</td>
<td>See the [containerd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.4).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-91</td>
<td>v1.11.3-100</td>
<td>Updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.3_1521, released 20 September 2018
{: #1113_1521}

The following table shows the changes that are included in patch 1.11.3_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1516">
<caption>Changes since version 1.11.2_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.2-71</td>
<td>v1.11.3-91</td>
<td>Updated to support Kubernetes 1.11.3 release.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains `ibmc-file-bronze`. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass).</td>
</tr>
<tr>
<td>Key Management Service Provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the ability to use the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you [enable {{site.data.keyword.keymanagementserviceshort}} in your cluster](/docs/containers?topic=containers-encryption#keyprotect), all your Kubernetes secrets are encrypted.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.2</td>
<td>v1.11.3</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3).</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>See the [Kubernetes DNS autoscaler release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) or the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update).</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `containerd`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.2_1516, released 4 September 2018
{: #1112_1516}

The following table shows the changes that are included in patch 1.11.2_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1514">
<caption>Changes since version 1.11.2_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.2</td>
<td>1.1.3</td>
<td>See the [`containerd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.3).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.2-60</td>
<td>v1.11.2-71</td>
<td>Changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers?topic=containers-file_storage#nfs_version_class).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.11.2_1514, released 23 August 2018
{: #1112_1514}

The following table shows the changes that are included in the worker node fix pack 1.11.2_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1513">
<caption>Changes since version 1.11.2_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.11.2_1513, released 14 August 2018
{: #1112_1513}

The following table shows the changes that are included in patch 1.11.2_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1518">
<caption>Changes since version 1.10.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>N/A</td>
<td>1.1.2</td>
<td>`containerd` replaces Docker as the new container runtime for Kubernetes. See the [`containerd` release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.2).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>`containerd` replaces Docker as the new container runtime for Kubernetes, to enhance performance.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.14</td>
<td>v3.2.18</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.2.18).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.11.2-60</td>
<td>Updated to support Kubernetes 1.11 release. In addition, load balancer pods now use the new `ibm-app-cluster-critical` pod priority class.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated `incubator` version to 1.8. File storage is provisioned to the specific zone that you select. You cannot update an existing (static) PV instance labels.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.11.2</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the OpenID Connect configuration for the cluster's Kubernetes API server to support {{site.data.keyword.cloud_notm}} Identity Access and Management (IAM) access groups. Added `Priority` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the cluster to support pod priority. For more information, see:
<ul><li>[{{site.data.keyword.cloud_notm}} IAM access groups](/docs/containers?topic=containers-users#rbac)</li>
<li>[Configuring pod priority](/docs/containers?topic=containers-pod_priority#pod_priority)</li></ul></td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.2</td>
<td>v.1.5.4</td>
<td>Increased resource limits for the `heapster-nanny` container. See the [Kubernetes Heapster release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-retired/heapster/releases/tag/v1.5.4).</td>
</tr>
<tr>
<td>Logging configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The container log directory is now `/var/log/pods/` instead of the previous `/var/lib/docker/containers/`.</td>
</tr>
</tbody>
</table>

<br />



### Version 1.10 changelog (unsupported as of 16 May 2019)
{: #110_changelog}

Review the version 1.10 changelogs.
{: shortdesc}

*   [Changelog for worker node fix pack 1.10.13_1558, released 13 May 2019](#11013_1558)
*   [Changelog for worker node fix pack 1.10.13_1557, released 29 April 2019](#11013_1557)
*   [Changelog for worker node fix pack 1.10.13_1556, released 15 April 2019](#11013_1556)
*   [Changelog for 1.10.13_1555, released 8 April 2019](#11013_1555)
*   [Changelog for worker node fix pack 1.10.13_1554, released 1 April 2019](#11013_1554)
*   [Changelog for master fix pack 1.10.13_1553, released 26 March 2019](#11118_1553)
*   [Changelog for 1.10.13_1551, released 20 March 2019](#11013_1551)
*   [Changelog for 1.10.13_1548, released 4 March 2019](#11013_1548)
*   [Changelog for worker node fix pack 1.10.12_1546, released 27 February 2019](#11012_1546)
*   [Changelog for worker node fix pack 1.10.12_1544, released 15 February 2019](#11012_1544)
*   [Changelog for 1.10.12_1543, released 5 February 2019](#11012_1543)
*   [Changelog for worker node fix pack 1.10.12_1541, released 28 January 2019](#11012_1541)
*   [Changelog for 1.10.12_1540, released 21 January 2019](#11012_1540)
*   [Changelog for worker node fix pack 1.10.11_1538, released 7 January 2019](#11011_1538)
*   [Changelog for worker node fix pack 1.10.11_1537, released 17 December 2018](#11011_1537)
*   [Changelog for 1.10.11_1536, released 4 December 2018](#11011_1536)
*   [Changelog for worker node fix pack 1.10.8_1532, released 27 November 2018](#1108_1532)
*   [Changelog for worker node fix pack 1.10.8_1531, released 19 November 2018](#1108_1531)
*   [Changelog for 1.10.8_1530, released 7 November 2018](#1108_1530_ha-master)
*   [Changelog for worker node fix pack 1.10.8_1528, released 26 October 2018](#1108_1528)
*   [Changelog for worker node fix pack 1.10.8_1525, released 10 October 2018](#1108_1525)
*   [Changelog for 1.10.8_1524, released 2 October 2018](#1108_1524)
*   [Changelog for worker node fix pack 1.10.7_1521, released 20 September 2018](#1107_1521)
*   [Changelog for 1.10.7_1520, released 4 September 2018](#1107_1520)
*   [Changelog for worker node fix pack 1.10.5_1519, released 23 August 2018](#1105_1519)
*   [Changelog for worker node fix pack 1.10.5_1518, released 13 August 2018](#1105_1518)
*   [Changelog for 1.10.5_1517, released 27 July 2018](#1105_1517)
*   [Changelog for worker node fix pack 1.10.3_1514, released 3 July 2018](#1103_1514)
*   [Changelog for worker node fix pack 1.10.3_1513, released 21 June 2018](#1103_1513)
*   [Changelog for 1.10.3_1512, released 12 June 2018](#1103_1512)
*   [Changelog for worker node fix pack 1.10.1_1510, released 18 May 2018](#1101_1510)
*   [Changelog for worker node fix pack 1.10.1_1509, released 16 May 2018](#1101_1509)
*   [Changelog for 1.10.1_1508, released 01 May 2018](#1101_1508)

#### Changelog for worker node fix pack 1.10.13_1558, released 13 May 2019
{: #11013_1558}

The following table shows the changes that are included in the worker node fix pack 1.10.13_1558.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1557">
<caption>Changes since version 1.10.13_1557</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2019-6706 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.13_1557, released 29 April 2019
{: #11013_1557}

The following table shows the changes that are included in the worker node fix pack 1.10.13_1557.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1556">
<caption>Changes since 1.10.13_1556</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.10.13_1556, released 15 April 2019
{: #11013_1556}

The following table shows the changes that are included in the worker node fix pack 1.10.13_1556.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1555">
<caption>Changes since 1.10.13_1555</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-3842.html).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.13_1555, released 8 April 2019
{: #11013_1555}

The following table shows the changes that are included in the patch 1.10.13_1555.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1554">
<caption>Changes since version 1.10.13_1554</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the [HAProxy release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.haproxy.org/download/1.9/src/CHANGELOG). Update resolves [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732), [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734), [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737), [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407), [CVE-2019-1543 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543), and [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.10</td>
<td>1.14.13</td>
<td>See the [Kubernetes DNS release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.14.13).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for [CVE-2017-12447 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447).</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for [CVE-2019-9213 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9213.html).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.13_1554, released 1 April 2019
{: #11013_1554}

The following table shows the changes that are included in the worker node fix 1.10.13_1554.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1553">
<caption>Changes since version 1.10.13_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>


#### Changelog for master fix pack 1.10.13_1553, released 26 March 2019
{: #11118_1553}

The following table shows the changes that are included in the master fix pack 1.10.13_1553.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1551">
<caption>Changes since version 1.10.13_1551</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.13_1551, released 20 March 2019
{: #11013_1551}

The following table shows the changes that are included in the patch 1.10.13_1551.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1548">
<caption>Changes since version 1.10.13_1548</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to [418.43 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.nvidia.com/object/unix.html). Update includes fix for [CVE-2019-9741 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-9741.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for [private service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se).</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for [CVE-2019-6133 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://people.canonical.com/~ubuntu-security/cve/2019/CVE-2019-6133.html).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for [CVE-2018-16890 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890), [CVE-2019-3822 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822), and [CVE-2019-3823 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for [CVE-2018-10779 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779), [CVE-2018-12900 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900), [CVE-2018-17000 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000), [CVE-2018-19210 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210), [CVE-2019-6128 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128), and [CVE-2019-7663 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.13_1548, released 4 March 2019
{: #11013_1548}

The following table shows the changes that are included in the patch 1.10.13_1548.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1546">
<caption>Changes since version 1.10.12_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.12-252</td>
<td>v1.10.13-288</td>
<td>Updated to support the Kubernetes 1.10.13 release. Fixed periodic connectivity problems for load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.12</td>
<td>v1.10.13</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.13).</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS pod memory limit from `170Mi` to `400Mi` in order to handle more cluster services.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for [CVE-2019-1559 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559).</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for [CVE-2019-6454 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.12_1546, released 27 February 2019
{: #11012_1546}

The following table shows the changes that are included in the worker node fix pack 1.10.12_1546.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1544">
<caption>Changes since version 1.10.12_1544</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for [CVE-2018-19407 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.12_1544, released 15 February 2019
{: #11012_1544}

The following table shows the changes that are included in the worker node fix pack 1.10.12_1544.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1543">
<caption>Changes since version 1.10.12_1543</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>18.06.1-ce</td>
<td>18.06.2-ce</td>
<td>See the [Docker Community Edition release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/docker/docker-ce/releases/tag/v18.06.2-ce). Update resolves [CVE-2019-5736 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736).</td>
</tr>
<tr>
<td>Kubernetes `kubelet` configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.12_1543, released 5 February 2019
{: #11012_1543}

The following table shows the changes that are included in the patch 1.10.12_1543.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1541">
<caption>Changes since version 1.10.12_1541</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the [etcd release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.11). Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [CVE-2019-6486 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology).</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407). Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for [CVE-2018-0734 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734) and [CVE-2018-5407 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407).</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for [CVE-2018-16864 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.12_1541, released 28 January 2019
{: #11012_1541}

The following table shows the changes that are included in the worker node fix pack 1.10.12_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1540">
<caption>Changes since version 1.10.12_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462) and [USN-3863-1 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3863-1).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.12_1540, released 21 January 2019
{: #11012_1540}

The following table shows the changes that are included in the patch 1.10.12_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1538">
<caption>Changes since version 1.10.11_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.11-219</td>
<td>v1.10.12-252</td>
<td>Updated to support the Kubernetes 1.10.12 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.11</td>
<td>v1.10.12</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.12).</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the [Kubernetes add-on resizer release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4).</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the [Kubernetes dashboard release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1). Update resolves [CVE-2018-18264 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264).<br><br>If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers?topic=containers-deploy_app#cli_dashboard).</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.11_1538, released 7 January 2019
{: #11011_1538}

The following table shows the changes that are included in the worker node fix pack 1.10.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1537">
<caption>Changes since version 1.10.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.11_1537, released 17 December 2018
{: #11011_1537}

The following table shows the changes that are included in the worker node fix pack 1.10.11_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1536">
<caption>Changes since version 1.10.11_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


#### Changelog for 1.10.11_1536, released 4 December 2018
{: #11011_1536}

The following table shows the changes that are included in patch 1.10.11_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1532">
<caption>Changes since version 1.10.8_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.8-197</td>
<td>v1.10.11-219</td>
<td>Updated to support the Kubernetes 1.10.11 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.8</td>
<td>v1.10.11</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.11). Update resolves [CVE-2018-1002105 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/71411).</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.8_1532, released 27 November 2018
{: #1108_1532}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1531">
<caption>Changes since version 1.10.8_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>See the [Docker release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/engine/release-notes/#18061-ce).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.8_1531, released 19 November 2018
{: #1108_1531}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1530">
<caption>Changes since version 1.10.8_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.8_1530, released 7 November 2018
{: #1108_1530_ha-master}

The following table shows the changes that are included in patch 1.10.8_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1528">
<caption>Changes since version 1.10.8_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts. Further, if your cluster is in a multizone-capable zone, the masters are spread across zones.</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Added an `ibm-master-proxy-*` pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>See the [etcd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.1).</td>
</tr>
<tr>
<td>Encrypting data in etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, [enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster](/docs/containers?topic=containers-encryption#keyprotect).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.8-172</td>
<td>v1.10.8-197</td>
<td>Added the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlan ls --zone <zone>`.</td>
</tr>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable) on an existing cluster, you need to [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks flavors --zone` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_machine_types).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.8_1528, released 26 October 2018
{: #1108_1528}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1527">
<caption>Changes since version 1.10.8_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.10.8_1527, released 15 October 2018
{: #1108_1527}

The following table shows the changes that are included in the master fix pack 1.10.8_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1524">
<caption>Changes since version 1.10.8_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed `calico-node` container readiness probe to better handle node failures.</td>
</tr>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.8_1525, released 10 October 2018
{: #1108_1525}

The following table shows the changes that are included in the worker node fix pack 1.10.8_1525.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1524">
<caption>Changes since version 1.10.8_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


#### Changelog for 1.10.8_1524, released 2 October 2018
{: #1108_1524}

The following table shows the changes that are included in patch 1.10.8_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.10.7_1520">
<caption>Changes since version 1.10.7_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service Provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the ability to use the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you [enable {{site.data.keyword.keymanagementserviceshort}} in your cluster](/docs/containers?topic=containers-encryption#keyprotect), all your Kubernetes secrets are encrypted.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.7</td>
<td>v1.10.8</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8).</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>See the [Kubernetes DNS autoscaler release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.7-146</td>
<td>v1.10.8-172</td>
<td>Updated to support Kubernetes 1.10.8 release. Also, updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.7_1521, released 20 September 2018
{: #1107_1521}

The following table shows the changes that are included in the worker node fix pack 1.10.7_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.10.7_1520">
<caption>Changes since version 1.10.7_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) or the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update).</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Disabled the default Docker bridge so that the `172.17.0.0/16` IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing `docker` commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options.<ul><li>To ensure external network connectivity when you build the container, run `docker build . --network host`.</li>
<li>To explicitly create a network to use when you build the container, run `docker network create` and then use this network.</li></ul>
**Note**: Have dependencies on the Docker socket or Docker directly? Update to `containerd` instead of `docker` as the container runtime so that your clusters are prepared to run Kubernetes version 1.11 or later.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.7_1520, released 4 September 2018
{: #1107_1520}

The following table shows the changes that are included in patch 1.10.7_1520.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1519">
<caption>Changes since version 1.10.5_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>See the Calico [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.10.7-146</td>
<td>Updated to support Kubernetes 1.10.7 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You cannot update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.<br><br> Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers?topic=containers-file_storage#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.10.7</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7).</td>
</tr>
<tr>
<td>Kubernetes Heapster configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased resource limits for the `heapster-nanny` container.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.5_1519, released 23 August 2018
{: #1105_1519}

The following table shows the changes that are included in the worker node fix pack 1.10.5_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1518">
<caption>Changes since version 1.10.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.10.5_1518, released 13 August 2018
{: #1105_1518}

The following table shows the changes that are included in the worker node fix pack 1.10.5_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1517">
<caption>Changes since version 1.10.5_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.5_1517, released 27 July 2018
{: #1105_1517}

The following table shows the changes that are included in patch 1.10.5_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1514">
<caption>Changes since version 1.10.3_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>See the Calico [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/releases/).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Updated to support Kubernetes 1.10.5 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.3_1514, released 3 July 2018
{: #1103_1514}

The following table shows the changes that are included in the worker node fix pack 1.10.3_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1513">
<caption>Changes since version 1.10.3_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized `sysctl` for high performance networking workloads.</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.10.3_1513, released 21 June 2018
{: #1103_1513}

The following table shows the changes that are included in the worker node fix pack 1.10.3_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1512">
<caption>Changes since version 1.10.3_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.3_1512, released 12 June 2018
{: #1103_1512}

The following table shows the changes that are included in patch 1.10.3_1512.
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1510">
<caption>Changes since version 1.10.1_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `PodSecurityPolicy` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers?topic=containers-psp).</td>
</tr>
<tr>
<td>Kubelet Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the `--authentication-token-webhook` option to support API bearer and service account tokens for authenticating to the `kubelet` HTTPS endpoint.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Updated to support Kubernetes 1.10.3 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `livenessProbe` to the OpenVPN client `vpn` deployment that runs in the `kube-system` namespace.</td>
</tr>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>



#### Changelog for worker node fix pack 1.10.1_1510, released 18 May 2018
{: #1101_1510}

The following table shows the changes that are included in the worker node fix pack 1.10.1_1510.
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1509">
<caption>Changes since version 1.10.1_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.10.1_1509, released 16 May 2018
{: #1101_1509}

The following table shows the changes that are included in the worker node fix pack 1.10.1_1509.
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1508">
<caption>Changes since version 1.10.1_1508</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.10.1_1508, released 01 May 2018
{: #1101_1508}

The following table shows the changes that are included in patch 1.10.1_1508.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1510">
<caption>Changes since version 1.9.7_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>See the Calico [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/).</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>See the Kubernetes Heapster [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-retired/heapster/releases/tag/v1.5.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>StorageObjectInUseProtection</code> to the <code>--enable-admission-plugins</code> option for the cluster's Kubernetes API server.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>See the Kubernetes DNS [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.14.10).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Updated to support Kubernetes 1.10 release.</td>
</tr>
<tr>
<td>GPU support</td>
<td>N/A</td>
<td>N/A</td>
<td>Support for [graphics processing unit (GPU) container workloads](/docs/containers?topic=containers-deploy_app#gpu_app) is now available for scheduling and execution. For a list of available GPU flavors, see [Hardware for worker nodes](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes). For more information, see the Kubernetes documentation to [Schedule GPUs ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

<br />


### Version 1.9 changelog (unsupported as of 27 December 2018)
{: #19_changelog}

Review the version 1.9 changelogs.
{: shortdesc}

*   [Changelog for worker node fix pack 1.9.11_1539, released 17 December 2018](#1911_1539)
*   [Changelog for worker node fix pack 1.9.11_1538, released 4 December 2018](#1911_1538)
*   [Changelog for worker node fix pack 1.9.11_1537, released 27 November 2018](#1911_1537)
*   [Changelog for 1.9.11_1536, released 19 November 2018](#1911_1536)
*   [Changelog for worker node fix 1.9.10_1532, released 7 November 2018](#1910_1532)
*   [Changelog for worker node fix pack 1.9.10_1531, released 26 October 2018](#1910_1531)
*   [Changelog for master fix pack 1.9.10_1530 released 15 October 2018](#1910_1530)
*   [Changelog for worker node fix pack 1.9.10_1528, released 10 October 2018](#1910_1528)
*   [Changelog for 1.9.10_1527, released 2 October 2018](#1910_1527)
*   [Changelog for worker node fix pack 1.9.10_1524, released 20 September 2018](#1910_1524)
*   [Changelog for 1.9.10_1523, released 4 September 2018](#1910_1523)
*   [Changelog for worker node fix pack 1.9.9_1522, released 23 August 2018](#199_1522)
*   [Changelog for worker node fix pack 1.9.9_1521, released 13 August 2018](#199_1521)
*   [Changelog for 1.9.9_1520, released 27 July 2018](#199_1520)
*   [Changelog for worker node fix pack 1.9.8_1517, released 3 July 2018](#198_1517)
*   [Changelog for worker node fix pack 1.9.8_1516, released 21 June 2018](#198_1516)
*   [Changelog for 1.9.8_1515, released 19 June 2018](#198_1515)
*   [Changelog for worker node fix pack 1.9.7_1513, released 11 June 2018](#197_1513)
*   [Changelog for worker node fix pack 1.9.7_1512, released 18 May 2018](#197_1512)
*   [Changelog for worker node fix pack 1.9.7_1511, released 16 May 2018](#197_1511)
*   [Changelog for 1.9.7_1510, released 30 April 2018](#197_1510)

#### Changelog for worker node fix pack 1.9.11_1539, released 17 December 2018
{: #1911_1539}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1539.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1538">
<caption>Changes since version 1.9.11_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.11_1538, released 4 December 2018
{: #1911_1538}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1537">
<caption>Changes since version 1.9.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.11_1537, released 27 November 2018
{: #1911_1537}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1536">
<caption>Changes since version 1.9.11_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>See the [Docker release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/engine/release-notes/#18061-ce).</td>
</tr>
</tbody>
</table>

#### Changelog for 1.9.11_1536, released 19 November 2018
{: #1911_1536}

The following table shows the changes that are included in patch 1.9.11_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1532">
<caption>Changes since version 1.9.10_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v2.6.12</td>
<td>See the [Calico release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.projectcalico.org/release-notes/). Update resolves [Tigera Technical Advisory TTA-2018-001 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.projectcalico.org/security-bulletins/).</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for [CVE-2018-7755 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.10</td>
<td>v1.9.11</td>
<td>See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.11).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}}</td>
<td>v1.9.10-219</td>
<td>v1.9.11-249</td>
<td>Updated to support the Kubernetes 1.9.11 release.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r2</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for [CVE-2018-0732 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732) and [CVE-2018-0737 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix 1.9.10_1532, released 7 November 2018
{: #1910_1532}

The following table shows the changes that are included in the worker node fix pack 1.9.11_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1531">
<caption>Changes since version 1.9.10_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable) on an existing cluster, you need to [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks flavors --zone` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_machine_types).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.10_1531, released 26 October 2018
{: #1910_1531}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1530">
<caption>Changes since version 1.9.10_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

#### Changelog for master fix pack 1.9.10_1530 released 15 October 2018
{: #1910_1530}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1527">
<caption>Changes since version 1.9.10_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.10_1528, released 10 October 2018
{: #1910_1528}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1527">
<caption>Changes since version 1.9.10_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


#### Changelog for 1.9.10_1527, released 2 October 2018
{: #1910_1527}

The following table shows the changes that are included in patch 1.9.10_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1523">
<caption>Changes since version 1.9.10_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.10-192</td>
<td>v1.9.10-219</td>
<td>Updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.10_1524, released 20 September 2018
{: #1910_1524}

The following table shows the changes that are included in the worker node fix pack 1.9.10_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1523">
<caption>Changes since version 1.9.10_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) or the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update).</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Disabled the default Docker bridge so that the `172.17.0.0/16` IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing `docker` commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options.<ul><li>To ensure external network connectivity when you build the container, run `docker build . --network host`.</li>
<li>To explicitly create a network to use when you build the container, run `docker network create` and then use this network.</li></ul>
**Note**: Have dependencies on the Docker socket or Docker directly? Update to `containerd` instead of `docker` as the container runtime so that your clusters are prepared to run Kubernetes version 1.11 or later.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.9.10_1523, released 4 September 2018
{: #1910_1523}

The following table shows the changes that are included in patch 1.9.10_1523.
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1522">
<caption>Changes since version 1.9.9_1522</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.9-167</td>
<td>v1.9.10-192</td>
<td>Updated to support Kubernetes 1.9.10 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You cannot update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.<br><br>Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers?topic=containers-file_storage#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.9</td>
<td>v1.9.10</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10).</td>
</tr>
<tr>
<td>Kubernetes Heapster configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased resource limits for the `heapster-nanny` container.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.9_1522, released 23 August 2018
{: #199_1522}

The following table shows the changes that are included in the worker node fix pack 1.9.9_1522.
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1521">
<caption>Changes since version 1.9.9_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.9.9_1521, released 13 August 2018
{: #199_1521}

The following table shows the changes that are included in the worker node fix pack 1.9.9_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1520">
<caption>Changes since version 1.9.9_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.9.9_1520, released 27 July 2018
{: #199_1520}

The following table shows the changes that are included in patch 1.9.9_1520.
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1517">
<caption>Changes since version 1.9.8_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Updated to support Kubernetes 1.9.9 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.8_1517, released 3 July 2018
{: #198_1517}

The following table shows the changes that are included in the worker node fix pack 1.9.8_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1516">
<caption>Changes since version 1.9.8_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized `sysctl` for high performance networking workloads.</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.9.8_1516, released 21 June 2018
{: #198_1516}

The following table shows the changes that are included in the worker node fix pack 1.9.8_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1515">
<caption>Changes since version 1.9.8_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.9.8_1515, released 19 June 2018
{: #198_1515}

The following table shows the changes that are included in patch 1.9.8_1515.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1513">
<caption>Changes since version 1.9.7_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `PodSecurityPolicy` to the `--admission-control` option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers?topic=containers-psp).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Updated to support Kubernetes 1.9.8 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>livenessProbe</code> to the OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace.</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.9.7_1513, released 11 June 2018
{: #197_1513}

The following table shows the changes that are included in the worker node fix pack 1.9.7_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1512">
<caption>Changes since version 1.9.7_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.7_1512, released 18 May 2018
{: #197_1512}

The following table shows the changes that are included in the worker node fix pack 1.9.7_1512.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1511">
<caption>Changes since version 1.9.7_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.9.7_1511, released 16 May 2018
{: #197_1511}

The following table shows the changes that are included in the worker node fix pack 1.9.7_1511.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1510">
<caption>Changes since version 1.9.7_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.9.7_1510, released 30 April 2018
{: #197_1510}

The following table shows the changes that are included in patch 1.9.7_1510.
{: shortdesc}

<table summary="Changes that were made since version 1.9.3_1506">
<caption>Changes since version 1.9.3_1506</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.3</td>
<td>v1.9.7	</td>
<td><p>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). This release addresses [CVE-2017-1002101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) and [CVE-2017-1002102 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) vulnerabilities.</p><p><strong>Note</strong>: Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `admissionregistration.k8s.io/v1alpha1=true` to the `--runtime-config` option for the cluster's Kubernetes API server.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td>`NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations) by setting `service.spec.externalTrafficPolicy` to `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix [edge node](/docs/containers?topic=containers-edge#edge) toleration setup for older clusters.</td>
</tr>
</tbody>
</table>

<br />


### Version 1.8 changelog (Unsupported)
{: #18_changelog}

Review the version 1.8 changelogs.
{: shortdesc}

*   [Changelog for worker node fix pack 1.8.15_1521, released 20 September 2018](#1815_1521)
*   [Changelog for worker node fix pack 1.8.15_1520, released 23 August 2018](#1815_1520)
*   [Changelog for worker node fix pack 1.8.15_1519, released 13 August 2018](#1815_1519)
*   [Changelog for 1.8.15_1518, released 27 July 2018](#1815_1518)
*   [Changelog for worker node fix pack 1.8.13_1516, released 3 July 2018](#1813_1516)
*   [Changelog for worker node fix pack 1.8.13_1515, released 21 June 2018](#1813_1515)
*   [Changelog 1.8.13_1514, released 19 June 2018](#1813_1514)
*   [Changelog for worker node fix pack 1.8.11_1512, released 11 June 2018](#1811_1512)
*   [Changelog for worker node fix pack 1.8.11_1511, released 18 May 2018](#1811_1511)
*   [Changelog for worker node fix pack 1.8.11_1510, released 16 May 2018](#1811_1510)
*   [Changelog for 1.8.11_1509, released 19 April 2018](#1811_1509)

#### Changelog for worker node fix pack 1.8.15_1521, released 20 September 2018
{: #1815_1521}

<table summary="Changes that were made since version 1.8.15_1520">
<caption>Changes since version 1.8.15_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) or the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update).</td>
</tr>
<tr>
<td>Worker node runtime components (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, do not disable the expiration. Instead, you can [update](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.8.15_1520, released 23 August 2018
{: #1815_1520}

<table summary="Changes that were made since version 1.8.15_1519">
<caption>Changes since version 1.8.15_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Updated `systemd` to fix `cgroup` leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.8.15_1519, released 13 August 2018
{: #1815_1519}

<table summary="Changes that were made since version 1.8.15_1518">
<caption>Changes since version 1.8.15_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.8.15_1518, released 27 July 2018
{: #1815_1518}

<table summary="Changes that were made since version 1.8.13_1516">
<caption>Changes since version 1.8.13_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Updated to support Kubernetes 1.8.15 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>See the Kubernetes [release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.8.13_1516, released 3 July 2018
{: #1813_1516}

<table summary="Changes that were made since version 1.8.13_1515">
<caption>Changes since version 1.8.13_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized `sysctl` for high performance networking workloads.</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.8.13_1515, released 21 June 2018
{: #1813_1515}

<table summary="Changes that were made since version 1.8.13_1514">
<caption>Changes since version 1.8.13_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

#### Changelog 1.8.13_1514, released 19 June 2018
{: #1813_1514}

<table summary="Changes that were made since version 1.8.11_1512">
<caption>Changes since version 1.8.11_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13).</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added `PodSecurityPolicy` to the `--admission-control` option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers?topic=containers-psp).</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Updated to support Kubernetes 1.8.13 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>livenessProbe</code> to the OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace.</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.8.11_1512, released 11 June 2018
{: #1811_1512}

<table summary="Changes that were made since version 1.8.11_1511">
<caption>Changes since version 1.8.11_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>


#### Changelog for worker node fix pack 1.8.11_1511, released 18 May 2018
{: #1811_1511}

<table summary="Changes that were made since version 1.8.11_1510">
<caption>Changes since version 1.8.11_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.8.11_1510, released 16 May 2018
{: #1811_1510}

<table summary="Changes that were made since version 1.8.11_1509">
<caption>Changes since version 1.8.11_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>


#### Changelog for 1.8.11_1509, released 19 April 2018
{: #1811_1509}

<table summary="Changes that were made since version 1.8.8_1507">
<caption>Changes since version 1.8.8_1507</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td><p>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). This release addresses [CVE-2017-1002101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) and [CVE-2017-1002102 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) vulnerabilities.</p><p>Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<tr>
<td>Pause container image</td>
<td>3.0</td>
<td>3.1</td>
<td>Removes inherited orphaned zombie processes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>`NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations) by setting `service.spec.externalTrafficPolicy` to `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix [edge node](/docs/containers?topic=containers-edge#edge) toleration setup for older clusters.</td>
</tr>
</tbody>
</table>

<br />


### Version 1.7 changelog (Unsupported)
{: #17_changelog}

Review the version 1.7 changelogs.
{: shortdesc}

*   [Changelog for worker node fix pack 1.7.16_1514, released 11 June 2018](#1716_1514)
*   [Changelog for worker node fix pack 1.7.16_1513, released 18 May 2018](#1716_1513)
*   [Changelog for worker node fix pack 1.7.16_1512, released 16 May 2018](#1716_1512)
*   [Changelog for 1.7.16_1511, released 19 April 2018](#1716_1511)

#### Changelog for worker node fix pack 1.7.16_1514, released 11 June 2018
{: #1716_1514}

<table summary="Changes that were made since version 1.7.16_1513">
<caption>Changes since version 1.7.16_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for [CVE-2018-3639 ![External link icon](../icons/launch-glyph.svg "External link icon")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.7.16_1513, released 18 May 2018
{: #1716_1513}

<table summary="Changes that were made since version 1.7.16_1512">
<caption>Changes since version 1.7.16_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

#### Changelog for worker node fix pack 1.7.16_1512, released 16 May 2018
{: #1716_1512}

<table summary="Changes that were made since version 1.7.16_1511">
<caption>Changes since version 1.7.16_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

#### Changelog for 1.7.16_1511, released 19 April 2018
{: #1716_1511}

<table summary="Changes that were made since version 1.7.4_1509">
<caption>Changes since version 1.7.4_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td><p>See the [Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). This release addresses [CVE-2017-1002101 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) and [CVE-2017-1002102 ![External link icon](../icons/launch-glyph.svg "External link icon")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) vulnerabilities.</p><p>Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>`NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations) by setting `service.spec.externalTrafficPolicy` to `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix [edge node](/docs/containers?topic=containers-edge#edge) toleration setup for older clusters.</td>
</tr>
</tbody>
</table>
