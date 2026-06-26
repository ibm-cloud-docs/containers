---

copyright:
  years: 2026, 2026

lastupdated: "2026-06-26"


keywords: change log, version history, 1.36

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# 1.36 version change log
{: #changelog_136}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run this version. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_136}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.36
{: #136_components}


### Change log for Master fix pack 1.36.2_1518, released 26 June 2026
{: #1362_1518_M}

The following table shows the changes that are in the master fix pack 1.36.2_1518. Master patch updates are applied automatically.


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.30.6 | v3.31.5 | See the [Calico release notes](https://docs.tigera.io/calico/3.31/release-notes/#calico-open-source-3315-bug-fix-release){: external}. |
| Cluster health image | v1.6.15 | v1.6.16 | New version contains updates and security fixes. |
| CoreDNS | v1.12.4 | v1.14.3 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| etcd | v3.5.29 | v3.5.30 | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.5.30){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.25 | v2.5.26 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.35.4-4 | v1.36.2-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | v454 | v455 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.9 | v1.1.11 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.24 | 2.10.25 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.34.0 | v0.36.0 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.36.0){: external}. |
| Kubernetes | v1.36.0 | v1.36.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.36.2){: external}. |
| Kubernetes Dashboard | v2.7.0 | N/A | Open source Kubernetes Dashboard is deprecated and archived. The Kubernetes Dashboard will no longer be installed on newly provisioned clusters and will be removed from clusters on earlier versions upgrading to 1.36. [The Headlamp add-on](https://cloud.ibm.com/docs/containers?topic=containers-headlamp-addon){: external} is available as a replacement Kubernetes UI. |
| Kubernetes DNS autoscaler | v1.9.0 | v1.10.3 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/v1.10.3){: external}. |
| Kubernetes NodeLocal DNS cache | 1.26.5 | 1.26.8 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.26.8){: external}. |
| Kubernetes snapshot controller | v8.3.0 | v8.5.0 | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v8.5.0){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 3534 | 3563 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.38 | v0.14.1 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.14.1){: external}. |
| Tigera Operator | v1.38.11 | v1.40.9 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.40.9){: external}. |
{: caption="Changes since version 1.35.5-1530" caption-side="bottom"}
