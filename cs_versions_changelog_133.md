---

copyright:
  years: 2025, 2025

lastupdated: "2025-12-03"


keywords: change log, version history, 1.33

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# 1.33 version change log
{: #changelog_133}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run this version. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_133}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.33
{: #133_components}


### Worker node fix pack 1.33.5_1550, released 17 November 2025
{: #cl-boms-1335_1550_W}

The following table shows the components included in the worker node fix pack 1.33.5_1550. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-86-generic|CIS benchmark compliance [2.2.4](https://workbench.cisecurity.org/sections/2891131/recommendations/4685418), [2.3.2.1](https://workbench.cisecurity.org/sections/2891135/recommendations/4685426), [5.1.1](https://workbench.cisecurity.org/sections/2891075/recommendations/4685147)Resolves the following CVEs: [CVE-2024-53008](https://nvd.nist.gov/vuln/detail/CVE-2024-53008){: external}, and [CVE-2025-32464](https://nvd.nist.gov/vuln/detail/CVE-2025-32464){: external}.|
|Kubernetes|1.33.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.5).|
|containerd|1.7.29|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.29).|
|HAProxy|fbe9b8146f23bbd12b2566a79fa897d5981e7273|N/A|
|GPU Device Plug-in and Installer|1e3d028d8b22980ae70339db3b7f41575fe5ee5f|Resolves the following CVEs: [CVE-2025-5318](https://nvd.nist.gov/vuln/detail/CVE-2025-5318){: external}.|
{: caption="1.33.5_1550 fix pack." caption-side="bottom"}
{: #cl-boms-1335_1550_W-component-table}



### Master fix pack 1.33.5_1549, released 15 November 2025
{: #1335_1549_M}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.29.5 | v3.29.6 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#calico-open-source-3296-bug-fix-release). |
| CoreDNS | v1.12.2 | v1.12.4 | See the [CoreDNS release notes](https://coredns.io/tags/notes/). |
| etcd | v3.5.22 | v3.5.24 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.24). |
| IBM Cloud Block Storage driver and plug-in | v2.5.20 | v2.5.22 | New version contains updates and security fixes. |
| IBM Cloud Controller Manager | v1.33.5-1 | v1.33.5-6 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.30 | v0.13.31 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.13.31) |
| Tigera Operator | v1.36.13 | v1.36.14 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.14). |
{: caption="Changes since version 1.33.5_1544" caption-side="bottom"}



### Worker node fix pack 1.33.5_1548, released 06 November 2025
{: #cl-boms-1335_1548_W}

The following table shows the components included in the worker node fix pack 1.33.5_1548. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-85-generic|Resolves the following CVEs: [CVE-2025-11082](https://nvd.nist.gov/vuln/detail/CVE-2025-11082){: external}, [CVE-2025-11083](https://nvd.nist.gov/vuln/detail/CVE-2025-11083){: external}, [CVE-2025-1147](https://nvd.nist.gov/vuln/detail/CVE-2025-1147){: external}, [CVE-2025-1148](https://nvd.nist.gov/vuln/detail/CVE-2025-1148){: external}, [CVE-2025-3198](https://nvd.nist.gov/vuln/detail/CVE-2025-3198){: external}, [CVE-2025-40778](https://nvd.nist.gov/vuln/detail/CVE-2025-40778){: external}, [CVE-2025-40780](https://nvd.nist.gov/vuln/detail/CVE-2025-40780){: external}, [CVE-2025-5244](https://nvd.nist.gov/vuln/detail/CVE-2025-5244){: external}, [CVE-2025-5245](https://nvd.nist.gov/vuln/detail/CVE-2025-5245){: external}, [CVE-2025-7425](https://nvd.nist.gov/vuln/detail/CVE-2025-7425){: external}, [CVE-2025-7545](https://nvd.nist.gov/vuln/detail/CVE-2025-7545){: external}, [CVE-2025-7546](https://nvd.nist.gov/vuln/detail/CVE-2025-7546){: external}, [CVE-2025-8114](https://nvd.nist.gov/vuln/detail/CVE-2025-8114){: external}, [CVE-2025-8225](https://nvd.nist.gov/vuln/detail/CVE-2025-8225){: external}, and [CVE-2025-8677](https://nvd.nist.gov/vuln/detail/CVE-2025-8677){: external}.|
|Kubernetes|1.33.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.5).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|fbe9b8146f23bbd12b2566a79fa897d5981e7273|Resolves the following CVEs: [CVE-2025-5318](https://nvd.nist.gov/vuln/detail/CVE-2025-5318){: external}.|
|GPU Device Plug-in and Installer|e15a40cb6d9e0ac0b9c345d302c629faad596b30|N/A|
{: caption="1.33.5_1548 fix pack." caption-side="bottom"}
{: #cl-boms-1335_1548_W-component-table}



### Worker node fix pack 1.33.5_1547, released 21 October 2025
{: #cl-boms-1335_1547_W}

The following table shows the components included in the worker node fix pack 1.33.5_1547. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-85-generic|Resolves the following CVEs: [CVE-2023-45803](https://nvd.nist.gov/vuln/detail/CVE-2023-45803){: external}, [CVE-2024-10963](https://nvd.nist.gov/vuln/detail/CVE-2024-10963){: external}, [CVE-2024-3651](https://nvd.nist.gov/vuln/detail/CVE-2024-3651){: external}, [CVE-2024-47081](https://nvd.nist.gov/vuln/detail/CVE-2024-47081){: external}, [CVE-2025-11230](https://nvd.nist.gov/vuln/detail/CVE-2025-11230){: external}, [CVE-2025-22247](https://nvd.nist.gov/vuln/detail/CVE-2025-22247){: external}, [CVE-2025-37756](https://nvd.nist.gov/vuln/detail/CVE-2025-37756){: external}, [CVE-2025-37785](https://nvd.nist.gov/vuln/detail/CVE-2025-37785){: external}, [CVE-2025-38477](https://nvd.nist.gov/vuln/detail/CVE-2025-38477){: external}, [CVE-2025-38500](https://nvd.nist.gov/vuln/detail/CVE-2025-38500){: external}, [CVE-2025-38617](https://nvd.nist.gov/vuln/detail/CVE-2025-38617){: external}, [CVE-2025-38618](https://nvd.nist.gov/vuln/detail/CVE-2025-38618){: external}, [CVE-2025-41244](https://nvd.nist.gov/vuln/detail/CVE-2025-41244){: external}, [CVE-2025-6297](https://nvd.nist.gov/vuln/detail/CVE-2025-6297){: external}, [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}, [CVE-2025-8961](https://nvd.nist.gov/vuln/detail/CVE-2025-8961){: external}, [CVE-2025-9165](https://nvd.nist.gov/vuln/detail/CVE-2025-9165){: external}, [CVE-2025-9230](https://nvd.nist.gov/vuln/detail/CVE-2025-9230){: external}, and [CVE-2025-9900](https://nvd.nist.gov/vuln/detail/CVE-2025-9900){: external}.|
|Kubernetes|1.33.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.5).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|c01cd5322cd5c284286c07fe9ad0cc0ef3ab5360|Resolves the following CVEs: [CVE-2025-32988](https://nvd.nist.gov/vuln/detail/CVE-2025-32988){: external}, [CVE-2025-6395](https://nvd.nist.gov/vuln/detail/CVE-2025-6395){: external}, and [CVE-2025-32990](https://nvd.nist.gov/vuln/detail/CVE-2025-32990){: external}.|
|GPU Device Plug-in and Installer|e15a40cb6d9e0ac0b9c345d302c629faad596b30|Resolves the following CVEs: [CVE-2025-53906](https://nvd.nist.gov/vuln/detail/CVE-2025-53906){: external}, [CVE-2025-53905](https://nvd.nist.gov/vuln/detail/CVE-2025-53905){: external}, [CVE-2025-32990](https://nvd.nist.gov/vuln/detail/CVE-2025-32990){: external}, [CVE-2025-32988](https://nvd.nist.gov/vuln/detail/CVE-2025-32988){: external}, [CVE-2025-6395](https://nvd.nist.gov/vuln/detail/CVE-2025-6395){: external}, and [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}.|
{: caption="1.33.5_1547 fix pack." caption-side="bottom"}
{: #cl-boms-1335_1547_W-component-table}



### Worker node fix pack 1.33.5_1545, released 08 October 2025
{: #cl-boms-1335_1545_W}

The following table shows the components included in the worker node fix pack 1.33.5_1545. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-83-generic|N/A|
|Kubernetes|1.33.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.5).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|e0a48fcf355d98dc769ea048d2fd02044b11ed62|N/A|
|GPU Device Plug-in and Installer|45bd1f84378a5eb92041b5102ef21a5cfe8b36d5|N/A|
{: caption="1.33.5_1545 fix pack." caption-side="bottom"}
{: #cl-boms-1335_1545_W-component-table}



### Master fix pack 1.33.5_1544, released 03 October 2025
{: #1335_1544_M}

The following table shows the changes that are in the master fix pack 1.33.5_1544. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.29.4 | v3.29.5 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#v3.29.5){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.33.3-2 | v1.33.5-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 451 | 452 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.16 | v2.10.17 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.32.0 | v0.33.0 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.33){: external}. |
| Kubernetes | v1.33.4 | v1.33.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.5){: external}. |
| Kubernetes NodeLocal DNS cache | 1.26.4 | 1.26.5 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.26.5){: external}. |
| Portieris admission controller | v0.13.29 | v0.13.30 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.30){: external}. |
| Tigera Operator | v1.36.11 | v1.36.13 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.13){: external}. |
{: caption="Changes since version 1.33.4_1537" caption-side="bottom"}



### Worker node fix pack 1.33.4_1541, released 23 September 2025
{: #cl-boms-1334_1541_W}

The following table shows the components included in the worker node fix pack 1.33.4_1541. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-83-generic|Resolves the following CVEs: [CVE-2024-11187](https://nvd.nist.gov/vuln/detail/CVE-2024-11187){: external}, [CVE-2024-12705](https://nvd.nist.gov/vuln/detail/CVE-2024-12705){: external}, [CVE-2025-53905](https://nvd.nist.gov/vuln/detail/CVE-2025-53905){: external}, [CVE-2025-53906](https://nvd.nist.gov/vuln/detail/CVE-2025-53906){: external}, [CVE-2025-7709](https://nvd.nist.gov/vuln/detail/CVE-2025-7709){: external}, and [CVE-2025-9714](https://nvd.nist.gov/vuln/detail/CVE-2025-9714){: external}.|
|Kubernetes|1.33.4|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.4).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|e0a48fcf355d98dc769ea048d2fd02044b11ed62|N/A|
|GPU Device Plug-in and Installer|45bd1f84378a5eb92041b5102ef21a5cfe8b36d5|N/A|
{: caption="1.33.4_1541 fix pack." caption-side="bottom"}
{: #cl-boms-1334_1541_W-component-table}



### Worker node fix pack 1.33.4_1539, released 09 September 2025
{: #cl-boms-1334_1539_W}

The following table shows the components included in the worker node fix pack 1.33.4_1539. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-79-generic|Resolves the following CVEs: [CVE-2024-57996](https://nvd.nist.gov/vuln/detail/CVE-2024-57996){: external}, [CVE-2025-21887](https://nvd.nist.gov/vuln/detail/CVE-2025-21887){: external}, [CVE-2025-37752](https://nvd.nist.gov/vuln/detail/CVE-2025-37752){: external}, [CVE-2025-38350](https://nvd.nist.gov/vuln/detail/CVE-2025-38350){: external}, and [CVE-2025-8067](https://nvd.nist.gov/vuln/detail/CVE-2025-8067){: external}.|
|Kubernetes|1.33.4|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.4).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|e0a48fcf355d98dc769ea048d2fd02044b11ed62|Resolves the following CVEs: [CVE-2025-6020](https://nvd.nist.gov/vuln/detail/CVE-2025-6020){: external}, and [CVE-2025-8941](https://nvd.nist.gov/vuln/detail/CVE-2025-8941){: external}.|
|GPU Device Plug-in and Installer|95e0dbe6a9d2a09a11080e4bf18bc1e33e196ae0|Resolves the following CVEs: [CVE-2025-8941](https://nvd.nist.gov/vuln/detail/CVE-2025-8941){: external}, [CVE-2025-8194](https://nvd.nist.gov/vuln/detail/CVE-2025-8194){: external}, and [CVE-2025-6020](https://nvd.nist.gov/vuln/detail/CVE-2025-6020){: external}.|
{: caption="1.33.4_1539 fix pack." caption-side="bottom"}
{: #cl-boms-1334_1539_W-component-table}



### Worker node fix pack 1.33.4_1538, released 26 August 2025
{: #cl-boms-1334_1538_W}

The following table shows the components included in the worker node fix pack 1.33.4_1538. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-71-generic|Resolves the following CVEs: [CVE-2025-49796](https://nvd.nist.gov/vuln/detail/CVE-2025-49796){: external}, [CVE-2025-6021](https://nvd.nist.gov/vuln/detail/CVE-2025-6021){: external}, [CVE-2025-6069](https://nvd.nist.gov/vuln/detail/CVE-2025-6069){: external}, [CVE-2025-6170](https://nvd.nist.gov/vuln/detail/CVE-2025-6170){: external}, [CVE-2025-8176](https://nvd.nist.gov/vuln/detail/CVE-2025-8176){: external}, [CVE-2025-8194](https://nvd.nist.gov/vuln/detail/CVE-2025-8194){: external}, [CVE-2025-8534](https://nvd.nist.gov/vuln/detail/CVE-2025-8534){: external}, and [CVE-2025-8851](https://nvd.nist.gov/vuln/detail/CVE-2025-8851){: external}.|
|Kubernetes|1.33.4|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.4).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|3293782c542587d0ce46be4d053036b75509f4ef|Resolves the following CVEs: [CVE-2025-5914](https://nvd.nist.gov/vuln/detail/CVE-2025-5914){: external}.|
|GPU Device Plug-in and Installer|dc91132711527b5b44d0e89e563354769d3a4a0f|Resolves the following CVEs: [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}, [CVE-2025-5914](https://nvd.nist.gov/vuln/detail/CVE-2025-5914){: external}, [CVE-2024-47081](https://nvd.nist.gov/vuln/detail/CVE-2024-47081){: external}, and [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}.|
{: caption="1.33.4_1538 fix pack." caption-side="bottom"}
{: #cl-boms-1334_1538_W-component-table}



### Master fix pack 1.33.4_1537, released 20 August 2025
{: #1334_1537_M}

The following table shows the changes that are in the master fix pack 1.33.4_1537. Master patch updates are applied automatically. 


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| etcd | v3.5.21 | v3.5.22 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.22){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.33.2-4 | v1.33.3-2 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.7 | v1.1.9 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 38dc95c | 8a12251 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.15 | v2.10.16 | New version contains updates and security fixes. |
| Kubernetes | v1.33.3 | v1.33.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.4){: external} and the [Security Bulletin for CVE-2025-5187](https://www.ibm.com/support/pages/node/7245968){: external}. |
{: caption="Changes since version 1.33.3_1532" caption-side="bottom"}



### Worker node fix pack 1.33.3_1534, released 12 August 2025
{: #cl-boms-1333_1534_W}

The following table shows the components included in the worker node fix pack 1.33.3_1534. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-64-generic|Resolves the following CVEs: [CVE-2024-11584](https://nvd.nist.gov/vuln/detail/CVE-2024-11584){: external}, [CVE-2024-6174](https://nvd.nist.gov/vuln/detail/CVE-2024-6174){: external}, [CVE-2025-37797](https://nvd.nist.gov/vuln/detail/CVE-2025-37797){: external}, [CVE-2025-38083](https://nvd.nist.gov/vuln/detail/CVE-2025-38083){: external}, [CVE-2025-40909](https://nvd.nist.gov/vuln/detail/CVE-2025-40909){: external}, and [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}.|
|Kubernetes|1.33.3|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.3).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|3a9451f4782fa8e8e9ed60b060dc4393c7e1e31a|Resolves the following CVEs: [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}, [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}, and [CVE-2025-7425](https://nvd.nist.gov/vuln/detail/CVE-2025-7425){: external}.|
|GPU Device Plug-in and Installer|51c51a011ee21f6dcb8c8143b688c34412f58405|Resolves the following CVEs: [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}, [CVE-2025-7425](https://nvd.nist.gov/vuln/detail/CVE-2025-7425){: external}, [CVE-2024-47081](https://nvd.nist.gov/vuln/detail/CVE-2024-47081){: external}, [CVE-2025-5994](https://nvd.nist.gov/vuln/detail/CVE-2025-5994){: external}, [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}, and [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}.|
{: caption="1.33.3_1534 fix pack." caption-side="bottom"}
{: #cl-boms-1333_1534_W-component-table}



### Change log for master fix pack 1.33.3_1532 and worker node fix pack 1.33.3_1533, released 31 July 2025
{: #1333_1532M_and_1333_1533W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Cloud Controller Manager | v1.32.6-4 | v1.33.2-4 | New version contains updates and security fixes. |
| IBM Cloud Cluster Health Operator | N/A | v0.1.11 | **New:** Cluster health operator offers more detailed status reports for your cluster’s managed components. |
| Kubernetes | v1.32.7 | v1.33.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.33.3). |
| Kubernetes add-on resizer | 1.8.22 | 1.8.23 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.23). |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings). |
| Kubernetes Metrics Server | v0.7.2 | v0.8.0 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.8.0). |
| Kubernetes snapshot controller | v8.0.1 | v8.2.1 | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v8.2.1). |
{: caption="Changes since version 1.32." caption-side="bottom"}
