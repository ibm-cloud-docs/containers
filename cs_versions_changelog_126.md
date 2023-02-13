---

copyright: 
  years: 2023, 2023
lastupdated: "2023-02-13"

keywords: kubernetes, containers, change log, 126 change log, 126 updates

subcollection: containers


---

# Kubernetes version 1.26 change log
{: #changelog_126}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.26. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_126}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.26 change log
{: #126_changelog}


Review the version 1.26 change log.
{: shortdesc}


### Change log for master fix pack 1.26.1_1519 and worker node fix pack 1.26.1_1520, released 1 February 2022
{: #1261_1519_and_1261_1520}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Calico configuration now sets a [BGP password](https://docs.tigera.io/calico/latest/reference/resources/bgppeer#bgppassword){: external} and container network sysctl tuning for `net.ipv4.tcp_keepalive_intvl` to `15`, `net.ipv4.tcp_keepalive_probes` to `6` and `net.ipv4.tcp_keepalive_time` to `40`.  |
| containerd | v1.6.16 | v1.7.0-beta.2 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.7.0-beta.2){: external}. In addition, the image pull progress timeout has been configured to 5 minutes. |
| IBM Cloud Controller Manager | v1.25.6-2 | v1.26.1-2 | Updated to support the Kubernetes `1.26.1` release. Updated `Go` dependencies and to `Go` version `1.19.5`. VPC load balancer creation now honors a user specified name. VPC load balancer update now handles an empty default pool name. |
| Key Management Service provider | v2.5.13 | v2.6.2 | Delayed KMS pod termination until the Kubernetes API server terminates. Updated `Go` dependencies and to `Go` version `1.19.4`. |
| Konnectivity agent and server | v0.0.34_491_iks | v0.1.0_503_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.0){: external}. |
| Kubernetes | v1.25.6 | v1.26.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.26.1){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the [kube-proxy configuration](/docs/containers?topic=containers-service-settings#kube-proxy){: external}. |
| Kubernetes add-on resizer | 1.8.15 | 1.8.16 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.16){: external}. In addition, a liveness probe has been configured to improve availability. |
| Kubernetes DNS autoscaler configuration | N/A | N/A | Memory resource requests were increased from `5Mi` to `7Mi` to better align with normal resource utilization. In addition, a liveness probe has been configured to improve availability. |
| Kubernetes Metrics Server | v0.6.0 | v0.6.2 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.13 | 1.22.15 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.15){: external}. |
| Pause container image | 3.8 | 3.9 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: caption="Changes since version 1.25." caption-side="bottom"}


