---

copyright: 
  years: 2023, 2023
lastupdated: "2023-09-26"

keywords: kubernetes, containers, change log, 128 change log, 128 updates

subcollection: containers


---

# Kubernetes version 1.28 change log
{: #changelog_128}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.28. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_128}

In clusters that run version 1.23 or earlier, the {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. In version 1.24 and later, most new beta features are disabled by default. Kubernetes alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}




## Version 1.28 change log
{: #127_changelog}


Review the version 1.28 change log.
{: shortdesc}



### Change log for master fix pack 1.28.2_1527 and worker node fix pack 1.28.1_1523, released 20 September 2023
{: #1.28.2_1527M-and-1.28.1_1523W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| CoreDNS | 1.10.1 | 1.11.1 | See the [CoreDNS release notes](https://coredns.io/2023/08/15/coredns-1.11.1-release/). CoreDNS now runs as a non-root user and has an updated role-based access control (RBAC) configuration. |
| HAProxy configuration | N/A | N/A | Updated master health probes to use the `/livez/ping` endpoint. |
| IBM Cloud Controller Manager | v1.27.5-3 | v1.28.1-3 | Updated to support the Kubernetes `1.28.1` release. Updated `Go` dependencies and to `Go` version `1.20.7`. New nodes are now registered with the `node.kubernetes.io/network-unavailable` taint which is cleared when Calico is initialized on the node. |
| Kubernetes add-on resizer | 1.8.18 | 1.8.19 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.19). |
| Kubernetes (master) | v1.27.5 | v1.28.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.2). |
| Kubernetes (worker node) | v1.27.4 | v1.28.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.1). |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](https://cloud.ibm.com/docs/containers?topic=containers-service-settings). In addition, `verbose` [Kubernetes API server auditing](https://cloud.ibm.com/docs/containers?topic=containers-health-audit#audit-api-server) records now contain extra user claim information. |
| Kubernetes Dashboard metrics scraper | N/A |	N/A | Increased Kubernetes Dashboard metrics scraper CPU resource request to `20m`. |
| Kubernetes DNS autoscaler | v1.8.8 | v1.8.9 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/v1.8.9). |
| Kubernetes Metrics Server | v0.6.3 | v0.6.4 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.6.4). In addition, the Kubernetes Metrics Server has an updated role-based access control (RBAC) configuration. |
| Kubernetes CSI snapshot controller and CRDs | v6.2.1 | v6.2.2 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.2.2). |
{: caption="Changes since version 1.27." caption-side="bottom"}


