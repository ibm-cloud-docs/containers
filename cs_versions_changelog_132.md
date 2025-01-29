---

copyright: 
  years: 2024, 2025
lastupdated: "2025-01-29"


keywords: kubernetes, containers, change log, 132 change log, 132 updates

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Kubernetes version 1.32 change log
{: #changelog_132}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.32. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_132}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}


## Version 1.32 change log
{: #132_changelog}


### Change log for master fix pack 1.32.1_1527 and worker node fix pack 1.32.0_1524, released 29 January 2025
{: #1321_1527M_and_13201524W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.28.2 | v3.29.1 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/){: external}. |
| CoreDNS | v1.11.4 | v1.12.0 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. In addition, the default CoreDNS configuration now has an updated caching configuration. |
| IBM Cloud Controller Manager | v1.31.4-3 | v1.32.1-1 | New version contains updates and security fixes. |
| Konnectivity agent configuration | N/A | N/A | Konnectivity agent is now configured with a readiness probe to make it easier to identify possible cluster networking problems. |
| Kubernetes (master) | v1.31.5 | v1.32.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.1){: external}. |
| Kubernetes (worker node) | v1.31.3 | v1.32.0 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.0){: external}. |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings). |
| Kubernetes DNS autoscaler | v1.8.9 | v1.9.0 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/v1.9.0){: external}. |
| Kubernetes NodeLocal DNS cache | 1.23.1 | 1.24.0 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.24.0){: external}. |
| Tigera Operator | v1.34.5 | v1.36.3 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.3){: external}. |
{: caption="Changes since version 1.31." caption-side="bottom"}






