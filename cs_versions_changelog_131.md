---

copyright: 
  years: 2024, 2024
lastupdated: "2024-09-18"


keywords: kubernetes, containers, change log, 131 change log, 131 updates

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Kubernetes version 1.31 change log
{: #changelog_131}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.31. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_131}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}


## Version 1.31 change log
{: #131_changelog}

### Change log for master fix pack 1.31.0_1520 and worker node fix pack 1.31.0_1518, released 18 September 2024
{: #1310_1520M_and_1310_1518W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.27.4 | v3.28.1 | See the [Calico release notes](https://docs.tigera.io/calico/3.28/release-notes/){: external}. |
| Cluster health image | v1.5.8 | v1.6.2 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.13 | v2.5.14 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.30.4-1 | v1.31.0-3 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} File Storage for Classic plug-in and monitor | 445 | 446 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.4 | v1.1.5 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 897f067 | 5b17dab | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.30.2 | v0.30.3 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.30.3){: external}. |
| Kubernetes | v1.30.4 | v1.31.0 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.31.0){: external}. |
| Kubernetes add-on resizer | 1.8.20 | 1.8.22 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.22){: external}. |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](https://cloud.ibm.com/docs/containers?topic=containers-service-settings){: external}. |
| Kubernetes Metrics Server | v0.7.1 | v0.7.2 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.7.2){: external}. |
| Kubernetes snapshot controller | v6.3.3 | v8.0.1 | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v8.0.1){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 3022 | 3051 | New version contains updates and security fixes. |
| Pause container image | 3.9 | 3.10 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
| Tigera Operator | v1.32.10-124-iks | v1.34.3 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.34.3){: external}. |
{: caption="Changes since version 1.30." caption-side="bottom"}
