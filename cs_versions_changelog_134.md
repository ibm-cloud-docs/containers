---

copyright:
  years: 2025, 2026

lastupdated: "2026-01-20"


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


### Master fix pack 1.34.3_1539, released 21 January 2026
{: #1343_1539_M}

The following table shows the changes that are in the master fix pack 1.34.3_1539. Master patch updates are applied automatically. 


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health control-plane operator | v0.1.11 | v0.1.15 | New version contains updates and security fixes. |
| etcd | v3.5.25 | v3.5.26 | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.5.26){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.34.2-3 | v1.34.3-3 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.19 | 2.10.20 | New version contains updates and security fixes. |
| Kubernetes | v1.34.2 | v1.34.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.3){: external}. |
{: caption="Changes since version 1.34.2-1534" caption-side="bottom"}


### Worker node fix pack 1.34.2_1537, released 12 January 2026
{: #cl-boms-1342_1537_W}

The following table shows the components included in the worker node fix pack 1.34.2_1537. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU 24|6.8.0-90-generic|CIS benchmark compliance [1.1.1.1](https://workbench.cisecurity.org/sections/2891083/recommendations/4685173), [2.2.6](https://workbench.cisecurity.org/sections/2891131/recommendations/4685422), [4.4.3.1](https://workbench.cisecurity.org/sections/2891129/recommendations/4685398), [4.4.3.2](https://workbench.cisecurity.org/sections/2891129/recommendations/4685401), [5.3.2.2](https://workbench.cisecurity.org/sections/2891109/recommendations/4685304), [5.3.3.1.1](https://workbench.cisecurity.org/sections/2891115/recommendations/4685316), [5.3.3.1.2](https://workbench.cisecurity.org/sections/2891115/recommendations/4685322), [5.3.3.2.5](https://workbench.cisecurity.org/sections/2891119/recommendations/4685360), [5.3.3.2.8](https://workbench.cisecurity.org/sections/2891119/recommendations/4685376), [5.3.3.3.1](https://workbench.cisecurity.org/sections/2891124/recommendations/4685379), [5.3.3.3.2](https://workbench.cisecurity.org/sections/2891124/recommendations/4685381), [5.3.3.3.3](https://workbench.cisecurity.org/sections/2891124/recommendations/4685383), [5.3.3.4.1](https://workbench.cisecurity.org/sections/2891125/recommendations/4685385),[5.4.1.5](https://workbench.cisecurity.org/sections/2891128/recommendations/4685402), [6.1.1.3](https://workbench.cisecurity.org/sections/2891070/recommendations/4685135), [6.1.4.1](https://workbench.cisecurity.org/sections/2891076/recommendations/4685155)Resolves the following CVEs: [CVE-2025-13601](https://nvd.nist.gov/vuln/detail/CVE-2025-13601){: external}, [CVE-2025-14087](https://nvd.nist.gov/vuln/detail/CVE-2025-14087){: external}, [CVE-2025-3360](https://nvd.nist.gov/vuln/detail/CVE-2025-3360){: external}, [CVE-2025-6052](https://nvd.nist.gov/vuln/detail/CVE-2025-6052){: external}, [CVE-2025-68973](https://nvd.nist.gov/vuln/detail/CVE-2025-68973){: external}, [CVE-2025-69277](https://nvd.nist.gov/vuln/detail/CVE-2025-69277){: external}, [CVE-2025-7039](https://nvd.nist.gov/vuln/detail/CVE-2025-7039){: external}, and [CVE-2025-7424](https://nvd.nist.gov/vuln/detail/CVE-2025-7424){: external}.|
|Kubernetes|1.34.2|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.2).|
|containerd|2.2.0|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.2.0).|
|HAProxy|d04e61c5b29aa5328bc72455edb95e08e8f6d85c|N/A|
|GPU Device Plug-in and Installer|b47cd687497789860e50db2fb84d0b43a4b6d5a4|Resolves the following CVEs: [CVE-2025-45582](https://nvd.nist.gov/vuln/detail/CVE-2025-45582){: external}.|
{: caption="1.34.2_1537 fix pack." caption-side="bottom"}
{: #cl-boms-1342_1537_W-component-table}


### Worker node fix pack 1.34.2_1536, released 29 December 2025
{: #cl-boms-1342_1536_W}

The following table shows the components included in the worker node fix pack 1.34.2_1536. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU 24|6.8.0-90-generic|Resolves the following CVEs: [CVE-2025-39993](https://nvd.nist.gov/vuln/detail/CVE-2025-39993){: external}, [CVE-2025-40018](https://nvd.nist.gov/vuln/detail/CVE-2025-40018){: external}, [CVE-2025-39964](https://nvd.nist.gov/vuln/detail/CVE-2025-39964){: external}, [CVE-2025-37958](https://nvd.nist.gov/vuln/detail/CVE-2025-37958){: external}, and [CVE-2025-38666](https://nvd.nist.gov/vuln/detail/CVE-2025-38666){: external}.|
|Kubernetes|1.34.2|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.2).|
|containerd|2.2.0|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.2.0).|
|HAProxy|d04e61c5b29aa5328bc72455edb95e08e8f6d85c|Resolves the following CVEs: [CVE-2025-9086](https://nvd.nist.gov/vuln/detail/CVE-2025-9086){: external}.|
|GPU Device Plug-in and Installer|0057dcb30bc3a8446f9a4eeef56228e56e935b66|Resolves the following CVEs: [CVE-2025-8291](https://nvd.nist.gov/vuln/detail/CVE-2025-8291){: external}, [CVE-2025-6069](https://nvd.nist.gov/vuln/detail/CVE-2025-6069){: external}, [CVE-2024-5642](https://nvd.nist.gov/vuln/detail/CVE-2024-5642){: external}, and [CVE-2025-6075](https://nvd.nist.gov/vuln/detail/CVE-2025-6075){: external}.|
{: caption="1.34.2_1536 fix pack." caption-side="bottom"}
{: #cl-boms-1342_1536_W-component-table}


### Worker node fix pack 1.34.2_1535, released 16 December 2025
{: #cl-boms-1342_1535_W}

The following table shows the components included in the worker node fix pack 1.34.2_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU 24|6.8.0-88-generic|Resolves the following CVEs: [CVE-2025-11412](https://nvd.nist.gov/vuln/detail/CVE-2025-11412){: external}, [CVE-2025-11413](https://nvd.nist.gov/vuln/detail/CVE-2025-11413){: external}, [CVE-2025-11414](https://nvd.nist.gov/vuln/detail/CVE-2025-11414){: external}, [CVE-2025-11494](https://nvd.nist.gov/vuln/detail/CVE-2025-11494){: external}, [CVE-2025-11839](https://nvd.nist.gov/vuln/detail/CVE-2025-11839){: external}, [CVE-2025-11840](https://nvd.nist.gov/vuln/detail/CVE-2025-11840){: external}, [CVE-2025-37958](https://nvd.nist.gov/vuln/detail/CVE-2025-37958){: external}, [CVE-2025-38666](https://nvd.nist.gov/vuln/detail/CVE-2025-38666){: external}, [CVE-2025-39964](https://nvd.nist.gov/vuln/detail/CVE-2025-39964){: external}, [CVE-2025-39993](https://nvd.nist.gov/vuln/detail/CVE-2025-39993){: external}, [CVE-2025-40018](https://nvd.nist.gov/vuln/detail/CVE-2025-40018){: external}, [CVE-2025-64505](https://nvd.nist.gov/vuln/detail/CVE-2025-64505){: external}, [CVE-2025-64506](https://nvd.nist.gov/vuln/detail/CVE-2025-64506){: external}, [CVE-2025-64720](https://nvd.nist.gov/vuln/detail/CVE-2025-64720){: external}, [CVE-2025-65018](https://nvd.nist.gov/vuln/detail/CVE-2025-65018){: external}, [CVE-2025-66418](https://nvd.nist.gov/vuln/detail/CVE-2025-66418){: external}, [CVE-2025-66471](https://nvd.nist.gov/vuln/detail/CVE-2025-66471){: external}, and [CVE-2025-6966](https://nvd.nist.gov/vuln/detail/CVE-2025-6966){: external}.|
|Kubernetes|1.34.2|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.2).|
|containerd|2.2.0|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.2.0).|
|HAProxy|03b74b82b63cd53403b6b587b84233c93edef18d|N/A|
|GPU Device Plug-in and Installer|1b40f92bf929456042c1f42ba54fa73cdaafb653|Resolves the following CVEs: [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}.|
{: caption="1.34.2_1535 fix pack." caption-side="bottom"}
{: #cl-boms-1342_1535_W-component-table}


### Master fix pack 1.34.2_1534, released 10 December 2025
{: #1342_1534_M}

The following table shows the changes that are in the master fix pack 1.34.2_1534. Master patch updates are applied automatically. 


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.29.6 | v3.29.7 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#calico-open-source-3297-bug-fix-release){: external}. |
| Cluster health image | v1.6.10 | v1.6.13 | New version contains updates and security fixes. |
| etcd | v3.5.24 | v3.5.25 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.25){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.34.1-6 | v1.34.2-3 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.18 | 2.10.19 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.33.0 | v0.34.0 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.34.0){: external}. |
| Kubernetes | v1.34.1 | v1.34.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.2){: external}. |
| Portieris admission controller | v0.13.31 | v0.13.33 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.33){: external}. |
| Tigera Operator | v1.36.14 | v1.36.16 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.16){: external}. |
{: caption="Changes since version 1.34.1-1529" caption-side="bottom"}


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


### Worker node fix pack 1.34.1_1530, released 17 November 2025
{: #cl-boms-1341_1530_W}

The following table shows the components included in the worker node fix pack 1.34.1_1530. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-86-generic|CIS benchmark compliance [2.2.4](https://workbench.cisecurity.org/sections/2891131/recommendations/4685418), [2.3.2.1](https://workbench.cisecurity.org/sections/2891135/recommendations/4685426), [5.1.1](https://workbench.cisecurity.org/sections/2891075/recommendations/4685147)Resolves the following CVEs: [CVE-2024-53008](https://nvd.nist.gov/vuln/detail/CVE-2024-53008){: external}, and [CVE-2025-32464](https://nvd.nist.gov/vuln/detail/CVE-2025-32464){: external}.|
|Kubernetes|1.34.1|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.34.1).|
|containerd|2.1.5|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.1.5).|
|HAProxy|fbe9b8146f23bbd12b2566a79fa897d5981e7273|N/A|
|GPU Device Plug-in and Installer|1e3d028d8b22980ae70339db3b7f41575fe5ee5f|Resolves the following CVEs: [CVE-2025-5318](https://nvd.nist.gov/vuln/detail/CVE-2025-5318){: external}.|
{: caption="1.34.1_1530 fix pack." caption-side="bottom"}
{: #cl-boms-1341_1530_W-component-table}
