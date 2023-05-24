---

copyright: 
  years: 2023, 2023
lastupdated: "2023-05-24"

keywords: kubernetes, containers, change log, 127 change log, 127 updates

subcollection: containers


---

# Kubernetes version 1.27 change log
{: #changelog_127}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.27. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_127}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}




## Version 1.27 change log
{: #127_changelog}


Review the version 1.27 change log.
{: shortdesc}


### Change log for master fix pack 1.27.2_1524 and worker node fix pack 1.27.2_1526, released 24 May 2023
{: #1.27.2_1524M_and_1.27.2_1526W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| etcd configuration | N/A | N/A | Improved etcd probe configurations. |
| IBM Cloud Controller Manager | v1.26.4-7 | v1.27.1-8 | Updated to support the Kubernetes `1.27.1` release. Updated `Go` dependencies and to `Go` version `1.20.3`. Base image updated. Increased default number of concurrent node and service sync workers. VPC load balancer updates can now be complete asynchronously. |
| Kubernetes | v1.26.5 | v1.27.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.2). |
| Kubernetes add-on resizer | 1.8.16 | 1.8.18 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.18). |
| Kubernetes CSI snapshot controller and CRDs | v6.0.1 | v6.2.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.2.1). |
| Kubernetes DNS autoscaler configuration | N/A | N/A | Increased Kubernetes DNS autoscaler memory resource request to `10Mi`. |
| Kubernetes Metrics Server | v0.6.2 | v0.6.3 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.6.3). |
| Kubernetes NodeLocal DNS cache configuration | N/A | N/A | Increased Kubernetes NodeLocal DNS cache memory resource request to `20Mi`. |
{: caption="Changes since version 1.26." caption-side="bottom"}

