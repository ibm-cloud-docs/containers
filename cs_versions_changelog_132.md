---

copyright:
  years: 2024, 2025

lastupdated: "2025-05-06"


keywords: change log, version history, 1.32

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

<!-- The content in this topic is auto-generated except for reuse-snippets indicated with {[ ]}. -->


# 1.32 version change log
{: #changelog_132}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run this version. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_132}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.32
{: #132_components}


### Master fix pack 1.32.4_1538, released 30 April 2025
{: #1324_1538_M}

The following table shows the changes that are in the master fix pack 1.32.4_1538. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.29.1 | v3.29.2 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#v3.29.2){: external}. |
| Cluster health image | v1.6.7 | v1.6.8 | New version contains updates and security fixes. |
| etcd | v3.5.18 | v3.5.21 | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.5.21){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.3-1 | v1.32.3-6 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.5 | v1.1.6 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | cb4f333 | d1545bd | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.11 | v2.10.12 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.31.1 | v0.32.0 | See the [Konnectivity release notes](https://github.ibm.com/alchemy-containers/armada-konnectivity-community-build/releases/tag/v0.32.0){: external}. |
| Kubernetes | v1.32.3 | v1.32.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.4){: external}. |
| Portieris admission controller | v0.13.25 | v0.13.26 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.26){: external}. |
| Tigera Operator | v1.36.3 | v1.36.5 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.5){: external}. |
{: caption="Changes since version 1.32.3_1533" caption-side="bottom"}



### Worker node fix pack 1.32.3_1536, released 21 April 2025
{: #cl-boms-1323_1536_W}

The following table shows the components included in the worker node fix pack 1.32.3_1536. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-55-generic|Resolves the following CVEs: [CVE-2024-56406](https://nvd.nist.gov/vuln/detail/CVE-2024-56406){: external}, [CVE-2024-8176](https://nvd.nist.gov/vuln/detail/CVE-2024-8176){: external}, [CVE-2025-1153](https://nvd.nist.gov/vuln/detail/CVE-2025-1153){: external}, [CVE-2025-1176](https://nvd.nist.gov/vuln/detail/CVE-2025-1176){: external}, [CVE-2025-1178](https://nvd.nist.gov/vuln/detail/CVE-2025-1178){: external}, [CVE-2025-1181](https://nvd.nist.gov/vuln/detail/CVE-2025-1181){: external}, [CVE-2025-1182](https://nvd.nist.gov/vuln/detail/CVE-2025-1182){: external}, [CVE-2025-1215](https://nvd.nist.gov/vuln/detail/CVE-2025-1215){: external}, [CVE-2025-26603](https://nvd.nist.gov/vuln/detail/CVE-2025-26603){: external}, and [CVE-2025-32464](https://nvd.nist.gov/vuln/detail/CVE-2025-32464){: external}.|
|Kubernetes|1.32.3|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.3).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27) and the [security bulletin for CVE-2024-40635](https://www.ibm.com/support/pages/node/7229615).|
|HAProxy|bb0015364d95e0a2e7ab83d4a659d1541cee183e|Resolves the following CVEs: [CVE-2025-0395](https://nvd.nist.gov/vuln/detail/CVE-2025-0395){: external}, and [CVE-2024-8176](https://nvd.nist.gov/vuln/detail/CVE-2024-8176){: external}.|
|GPU Device Plug-in and Installer|b7d507fd50989efa6ba8a9595d2a5681fc2380bf|Resolves the following CVEs: [CVE-2024-8176](https://nvd.nist.gov/vuln/detail/CVE-2024-8176){: external}, and [CVE-2025-0395](https://nvd.nist.gov/vuln/detail/CVE-2025-0395){: external}.|
{: caption="1.32.3_1536 fix pack." caption-side="bottom"}
{: #cl-boms-1323_1536_W-component-table}



### Worker node fix pack 1.32.3_1535, released 08 April 2025
{: #cl-boms-1323_1535_W}

The following table shows the components included in the worker node fix pack 1.32.3_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-55-generic|Resolves the following CVEs: [CVE-2024-25260](https://nvd.nist.gov/vuln/detail/CVE-2024-25260){: external}, [CVE-2025-1365](https://nvd.nist.gov/vuln/detail/CVE-2025-1365){: external}, [CVE-2025-1371](https://nvd.nist.gov/vuln/detail/CVE-2025-1371){: external}, [CVE-2025-1372](https://nvd.nist.gov/vuln/detail/CVE-2025-1372){: external}, [CVE-2025-1377](https://nvd.nist.gov/vuln/detail/CVE-2025-1377){: external}, [CVE-2025-24014](https://nvd.nist.gov/vuln/detail/CVE-2025-24014){: external}, [CVE-2025-30258](https://nvd.nist.gov/vuln/detail/CVE-2025-30258){: external}, and [CVE-2025-31115](https://nvd.nist.gov/vuln/detail/CVE-2025-31115){: external}.|
|Kubernetes|1.32.3|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.3).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27) and the [security bulletin for CVE-2024-40635](https://www.ibm.com/support/pages/node/7229615).|
|HAProxy|997a4ab1e89a5c8ccf3a6823785d7ab5e34b0c83|N/A|
|GPU Device Plug-in and Installer|c9d9c47b1404651b3a3c022f288a6d90bb5a44b2|N/A|
{: caption="1.32.3_1535 fix pack." caption-side="bottom"}
{: #cl-boms-1323_1535_W-component-table}



### Master fix pack 1.32.3_1533, released 26 March 2025
{: #1323_1533_M}

The following table shows the changes that are in the master fix pack 1.32.3_1533. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.6.4 | v1.6.7 | New version contains updates and security fixes. |
| etcd | v3.5.17 | v3.5.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.18){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.1-2 | v1.32.3-1 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.10 | v2.10.11 | New version contains updates and security fixes. |
| Kubernetes | v1.32.1 | v1.32.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.3){: external}. |
| Kubernetes NodeLocal DNS cache | 1.24.0 | 1.25.0 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.25.0){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 3178 | 3232 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.23 | v0.13.25 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.25){: external}. |
{: caption="Changes since version 1.32.1_1530" caption-side="bottom"}



### Worker node fix pack 1.32.3_1534, released 24 March 2025
{: #cl-boms-1323_1534_W}

The following table shows the components included in the worker node fix pack 1.32.3_1534. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-55-generic|Resolves the following CVEs: [CVE-2024-55549](https://nvd.nist.gov/vuln/detail/CVE-2024-55549){: external}, [CVE-2025-24855](https://nvd.nist.gov/vuln/detail/CVE-2025-24855){: external}, and [CVE-2025-27516](https://nvd.nist.gov/vuln/detail/CVE-2025-27516){: external}.|
|Kubernetes|1.32.3|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.3).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27) and the [security bulletin for CVE-2024-40635](https://www.ibm.com/support/pages/node/7229615).|
|HAProxy|997a4ab1e89a5c8ccf3a6823785d7ab5e34b0c83|Resolves the following CVEs: [CVE-2024-56171](https://nvd.nist.gov/vuln/detail/CVE-2024-56171){: external}, [CVE-2025-24528](https://nvd.nist.gov/vuln/detail/CVE-2025-24528){: external}, and [CVE-2025-24928](https://nvd.nist.gov/vuln/detail/CVE-2025-24928){: external}.|
|GPU Device Plug-in and Installer|c9d9c47b1404651b3a3c022f288a6d90bb5a44b2|Resolves the following CVEs: [CVE-2024-56171](https://nvd.nist.gov/vuln/detail/CVE-2024-56171){: external}, [CVE-2025-24928](https://nvd.nist.gov/vuln/detail/CVE-2025-24928){: external}, and [CVE-2025-24528](https://nvd.nist.gov/vuln/detail/CVE-2025-24528){: external}.|
{: caption="1.32.3_1534 fix pack." caption-side="bottom"}
{: #cl-boms-1323_1534_W-component-table}



### Worker node fix pack 1.32.1_1532, released 11 March 2025
{: #cl-boms-1321_1532_W}

The following table shows the components included in the worker node fix pack 1.32.1_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-52-generic|N/A|
|Kubernetes|1.32.1|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.1).|
|containerd|1.7.26|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.26).|
|HAProxy|1d72cc8c7d02da6ba0340191fa8d9a86550e5090|N/A|
|GPU Device Plug-in and Installer|57c31795f069cb17cd235792f3ac21ac0e086360|Resolves the following CVEs: [CVE-2024-1488](https://nvd.nist.gov/vuln/detail/CVE-2024-1488){: external}, [CVE-2020-11023](https://nvd.nist.gov/vuln/detail/CVE-2020-11023){: external}, [CVE-2024-8508](https://nvd.nist.gov/vuln/detail/CVE-2024-8508){: external}, and [CVE-2022-49043](https://nvd.nist.gov/vuln/detail/CVE-2022-49043){: external}.|
{: caption="1.32.1_1532 fix pack." caption-side="bottom"}
{: #cl-boms-1321_1532_W-component-table}



### Worker node fix pack 1.32.1_1531, released 24 February 2025
{: #cl-boms-1321_1531_W}

The following table shows the components included in the worker node fix pack 1.32.1_1531. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-52-generic|Resolves the following CVEs: [CVE-2024-12133](https://nvd.nist.gov/vuln/detail/CVE-2024-12133){: external}, [CVE-2024-12243](https://nvd.nist.gov/vuln/detail/CVE-2024-12243){: external}, [CVE-2024-13176](https://nvd.nist.gov/vuln/detail/CVE-2024-13176){: external}, [CVE-2024-9143](https://nvd.nist.gov/vuln/detail/CVE-2024-9143){: external}, [CVE-2025-0938](https://nvd.nist.gov/vuln/detail/CVE-2025-0938){: external}, [CVE-2025-26465](https://nvd.nist.gov/vuln/detail/CVE-2025-26465){: external}, and [CVE-2025-26466](https://nvd.nist.gov/vuln/detail/CVE-2025-26466){: external}.|
|Kubernetes|1.32.1|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.1).|
|containerd|1.7.25|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.25).|
|HAProxy|1d72cc8c7d02da6ba0340191fa8d9a86550e5090|Resolves the following CVEs: [CVE-2020-11023](https://nvd.nist.gov/vuln/detail/CVE-2020-11023){: external}, and [CVE-2022-49043](https://nvd.nist.gov/vuln/detail/CVE-2022-49043){: external}.|
|GPU Device Plug-in and Installer|e41a0d57a0f7696dfa3698c6af3bcc8765e76cfd|Resolves the following CVEs: [CVE-2024-8508](https://nvd.nist.gov/vuln/detail/CVE-2024-8508){: external}, [CVE-2022-49043](https://nvd.nist.gov/vuln/detail/CVE-2022-49043){: external}, [CVE-2024-1488](https://nvd.nist.gov/vuln/detail/CVE-2024-1488){: external}, and [CVE-2020-11023](https://nvd.nist.gov/vuln/detail/CVE-2020-11023){: external}.|
{: caption="1.32.1_1531 fix pack." caption-side="bottom"}
{: #cl-boms-1321_1531_W-component-table}



### Master fix pack 1.32.1_1530, released 19 February 2025
{: #1321_1530_M}

The following table shows the changes that are in the master fix pack 1.32.1_1530. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.1-1 | v1.32.1-2 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 447 | 449 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.9 | v2.10.10 | New version contains updates and security fixes. |
{: caption="Changes since version 1.32.1_1527" caption-side="bottom"}



### Worker node fix pack 1.32.1_1529, released 11 February 2025
{: #cl-boms-1321_1529_W}

The following table shows the components included in the worker node fix pack 1.32.1_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-52-generic|Resolves the following CVEs: [CVE-2022-49043](https://nvd.nist.gov/vuln/detail/CVE-2022-49043){: external}, [CVE-2024-11187](https://nvd.nist.gov/vuln/detail/CVE-2024-11187){: external}, [CVE-2024-12705](https://nvd.nist.gov/vuln/detail/CVE-2024-12705){: external}, [CVE-2024-34459](https://nvd.nist.gov/vuln/detail/CVE-2024-34459){: external}, [CVE-2024-3596](https://nvd.nist.gov/vuln/detail/CVE-2024-3596){: external}, [CVE-2024-53103](https://nvd.nist.gov/vuln/detail/CVE-2024-53103){: external}, [CVE-2024-53141](https://nvd.nist.gov/vuln/detail/CVE-2024-53141){: external}, [CVE-2024-53164](https://nvd.nist.gov/vuln/detail/CVE-2024-53164){: external}, [CVE-2024-56201](https://nvd.nist.gov/vuln/detail/CVE-2024-56201){: external}, [CVE-2024-56201](https://nvd.nist.gov/vuln/detail/CVE-2024-56201){: external}, [CVE-2024-56326](https://nvd.nist.gov/vuln/detail/CVE-2024-56326){: external}, [CVE-2024-56326](https://nvd.nist.gov/vuln/detail/CVE-2024-56326){: external}, and [CVE-2025-0395](https://nvd.nist.gov/vuln/detail/CVE-2025-0395){: external}.|
|Kubernetes|1.32.1|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.1).|
|containerd|1.7.25|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.25).|
|HAProxy|03d1ee01e9241d0e5ec93b9eb8986feb2771a01a|Resolves the following CVEs: [CVE-2019-12900](https://nvd.nist.gov/vuln/detail/CVE-2019-12900){: external}.|
|GPU Device Plug-in and Installer|639e505cf0c0f21d6a0a09d157ac7be7f16a77c8|Resolves the following CVEs: [CVE-2024-1488](https://nvd.nist.gov/vuln/detail/CVE-2024-1488){: external}, and [CVE-2024-8508](https://nvd.nist.gov/vuln/detail/CVE-2024-8508){: external}.|
{: caption="1.32.1_1529 fix pack." caption-side="bottom"}
{: #cl-boms-1321_1529_W-component-table}



### Worker node fix pack 1.32.1_1528, released 29 January 2025
{: #cl-boms-1321_1528_W}

The following table shows the components included in the worker node fix pack 1.32.1_1528. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_20_04|5.4.0-204-generic|Resolves the following CVEs: [CVE-2024-11168](https://nvd.nist.gov/vuln/detail/CVE-2024-11168){: external}, and [CVE-2025-22134](https://nvd.nist.gov/vuln/detail/CVE-2025-22134){: external}.|
|UBUNTU_24_04|6.8.0-51-generic|Resolves the following CVEs: [CVE-2024-12254](https://nvd.nist.gov/vuln/detail/CVE-2024-12254){: external}, [CVE-2024-50349](https://nvd.nist.gov/vuln/detail/CVE-2024-50349){: external}, [CVE-2024-52006](https://nvd.nist.gov/vuln/detail/CVE-2024-52006){: external}, and [CVE-2025-22134](https://nvd.nist.gov/vuln/detail/CVE-2025-22134){: external}.|
|Kubernetes|1.32.1|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.1).|
|containerd|1.7.25|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.25).|
|HAProxy|14daa781a66ca5ed5754656ce53c3cca4af580b5|N/A|
|GPU Device Plug-in and Installer|6563a84c30f22dd511f6e2d80227040a12c3af9a|Resolves the following CVEs: [CVE-2019-12900](https://nvd.nist.gov/vuln/detail/CVE-2019-12900){: external}.|
{: caption="1.32.1_1528 fix pack." caption-side="bottom"}
{: #cl-boms-1321_1528_W-component-table}



### Master fix pack 1.32.1_1527 and worker node fix pack 1.32.0_1524, released 29 January 2025
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
| Kubernetes DNS autoscaler | v1.8.9 | v1.9.0 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/v1.9.0){: external}. |
| Kubernetes NodeLocal DNS cache | 1.23.1 | 1.24.0 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.24.0){: external}. |
| Tigera Operator | v1.34.5 | v1.36.3 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.3){: external}. |
{: caption="Changes since version 1.31." caption-side="bottom"}
