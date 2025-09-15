---

copyright:
  years: 2024, 2025

lastupdated: "2025-09-15"


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


### Worker node fix pack 1.32.8_1556, released 26 August 2025
{: #cl-boms-1328_1556_W}

The following table shows the components included in the worker node fix pack 1.32.8_1556. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-71-generic|Resolves the following CVEs: [CVE-2025-49796](https://nvd.nist.gov/vuln/detail/CVE-2025-49796){: external}, [CVE-2025-6021](https://nvd.nist.gov/vuln/detail/CVE-2025-6021){: external}, [CVE-2025-6069](https://nvd.nist.gov/vuln/detail/CVE-2025-6069){: external}, [CVE-2025-6170](https://nvd.nist.gov/vuln/detail/CVE-2025-6170){: external}, [CVE-2025-8176](https://nvd.nist.gov/vuln/detail/CVE-2025-8176){: external}, [CVE-2025-8194](https://nvd.nist.gov/vuln/detail/CVE-2025-8194){: external}, [CVE-2025-8534](https://nvd.nist.gov/vuln/detail/CVE-2025-8534){: external}, and [CVE-2025-8851](https://nvd.nist.gov/vuln/detail/CVE-2025-8851){: external}.|
|Kubernetes|1.32.8|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.8).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|3293782c542587d0ce46be4d053036b75509f4ef|Resolves the following CVEs: [CVE-2025-5914](https://nvd.nist.gov/vuln/detail/CVE-2025-5914){: external}.|
|GPU Device Plug-in and Installer|dc91132711527b5b44d0e89e563354769d3a4a0f|Resolves the following CVEs: [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}, [CVE-2025-5914](https://nvd.nist.gov/vuln/detail/CVE-2025-5914){: external}, [CVE-2024-47081](https://nvd.nist.gov/vuln/detail/CVE-2024-47081){: external}, and [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}.|
{: caption="1.32.8_1556 fix pack." caption-side="bottom"}
{: #cl-boms-1328_1556_W-component-table}



### Master fix pack 1.32.8_1555, released 20 August 2025
{: #1328_1555_M}

The following table shows the changes that are in the master fix pack 1.32.8_1555. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| etcd | v3.5.21 | v3.5.22 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.22){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.6-4 | v1.32.7-2 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.7 | v1.1.9 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 38dc95c | 8a12251 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.15 | v2.10.16 | New version contains updates and security fixes. |
| Kubernetes | v1.32.7 | v1.32.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.8){: external}. |
{: caption="Changes since version 1.32.7_1549" caption-side="bottom"}



### Worker node fix pack 1.32.7_1551, released 12 August 2025
{: #cl-boms-1327_1551_W}

The following table shows the components included in the worker node fix pack 1.32.7_1551. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-64-generic|Resolves the following CVEs: [CVE-2024-11584](https://nvd.nist.gov/vuln/detail/CVE-2024-11584){: external}, [CVE-2024-6174](https://nvd.nist.gov/vuln/detail/CVE-2024-6174){: external}, [CVE-2025-37797](https://nvd.nist.gov/vuln/detail/CVE-2025-37797){: external}, [CVE-2025-38083](https://nvd.nist.gov/vuln/detail/CVE-2025-38083){: external}, [CVE-2025-40909](https://nvd.nist.gov/vuln/detail/CVE-2025-40909){: external}, and [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}.|
|Kubernetes|1.32.7|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.7).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|3a9451f4782fa8e8e9ed60b060dc4393c7e1e31a|Resolves the following CVEs: [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}, [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}, and [CVE-2025-7425](https://nvd.nist.gov/vuln/detail/CVE-2025-7425){: external}.|
|GPU Device Plug-in and Installer|51c51a011ee21f6dcb8c8143b688c34412f58405|Resolves the following CVEs: [CVE-2025-8058](https://nvd.nist.gov/vuln/detail/CVE-2025-8058){: external}, [CVE-2025-7425](https://nvd.nist.gov/vuln/detail/CVE-2025-7425){: external}, [CVE-2024-47081](https://nvd.nist.gov/vuln/detail/CVE-2024-47081){: external}, [CVE-2025-5994](https://nvd.nist.gov/vuln/detail/CVE-2025-5994){: external}, [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}, and [CVE-2025-6965](https://nvd.nist.gov/vuln/detail/CVE-2025-6965){: external}.|
{: caption="1.32.7_1551 fix pack." caption-side="bottom"}
{: #cl-boms-1327_1551_W-component-table}



### Master fix pack 1.32.7_1549, released 30 July 2025
{: #1327_1549_M}

The following table shows the changes that are in the master fix pack 1.32.7_1549. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico API server | v3.29.3 | v3.29.4 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/about/){: external}. |
| Calico | v3.29.3 | v3.29.4 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#calico-open-source-3294-bug-fix-release){: external}. |
| Cluster health image | v1.6.9 | v1.6.10 | New version contains updates and security fixes. |
| CoreDNS | v1.12.1 | v1.12.2 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.19 | v2.5.20 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.5-4 | v1.32.6-4 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 450 | 451 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.6 | v1.1.7 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.14 | v2.10.15 | New version contains updates and security fixes. |
| Kubernetes | v1.32.5 | v1.32.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.7){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 3293 | 3347 | New version contains updates and security fixes. |
| Kubernetes NodeLocal DNS cache | 1.25.0 | 1.26.4 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.26.4){: external}. |
| Portieris admission controller | v0.13.28 | v0.13.29 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.29){: external}. |
| Tigera Operator | v1.36.8 | v1.36.11 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.11){: external}. |
{: caption="Changes since version 1.32.5_1544" caption-side="bottom"}



### Worker node fix pack 1.32.7_1550, released 28 July 2025
{: #cl-boms-1327_1550_W}

The following table shows the components included in the worker node fix pack 1.32.7_1550. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-64-generic|Resolves the following CVEs: [CVE-2024-23337](https://nvd.nist.gov/vuln/detail/CVE-2024-23337){: external}, [CVE-2024-49887](https://nvd.nist.gov/vuln/detail/CVE-2024-49887){: external}, [CVE-2024-53427](https://nvd.nist.gov/vuln/detail/CVE-2024-53427){: external}, [CVE-2024-56699](https://nvd.nist.gov/vuln/detail/CVE-2024-56699){: external}, [CVE-2024-57953](https://nvd.nist.gov/vuln/detail/CVE-2024-57953){: external}, [CVE-2024-57973](https://nvd.nist.gov/vuln/detail/CVE-2024-57973){: external}, [CVE-2024-57974](https://nvd.nist.gov/vuln/detail/CVE-2024-57974){: external}, [CVE-2024-57975](https://nvd.nist.gov/vuln/detail/CVE-2024-57975){: external}, [CVE-2024-57979](https://nvd.nist.gov/vuln/detail/CVE-2024-57979){: external}, [CVE-2024-57980](https://nvd.nist.gov/vuln/detail/CVE-2024-57980){: external}, [CVE-2024-57981](https://nvd.nist.gov/vuln/detail/CVE-2024-57981){: external}, [CVE-2024-57982](https://nvd.nist.gov/vuln/detail/CVE-2024-57982){: external}, [CVE-2024-57984](https://nvd.nist.gov/vuln/detail/CVE-2024-57984){: external}, [CVE-2024-57986](https://nvd.nist.gov/vuln/detail/CVE-2024-57986){: external}, [CVE-2024-57990](https://nvd.nist.gov/vuln/detail/CVE-2024-57990){: external}, [CVE-2024-57993](https://nvd.nist.gov/vuln/detail/CVE-2024-57993){: external}, [CVE-2024-57994](https://nvd.nist.gov/vuln/detail/CVE-2024-57994){: external}, [CVE-2024-57996](https://nvd.nist.gov/vuln/detail/CVE-2024-57996){: external}, [CVE-2024-57997](https://nvd.nist.gov/vuln/detail/CVE-2024-57997){: external}, [CVE-2024-57998](https://nvd.nist.gov/vuln/detail/CVE-2024-57998){: external}, [CVE-2024-57999](https://nvd.nist.gov/vuln/detail/CVE-2024-57999){: external}, [CVE-2024-58034](https://nvd.nist.gov/vuln/detail/CVE-2024-58034){: external}, [CVE-2024-58051](https://nvd.nist.gov/vuln/detail/CVE-2024-58051){: external}, [CVE-2024-58052](https://nvd.nist.gov/vuln/detail/CVE-2024-58052){: external}, [CVE-2024-58053](https://nvd.nist.gov/vuln/detail/CVE-2024-58053){: external}, [CVE-2024-58054](https://nvd.nist.gov/vuln/detail/CVE-2024-58054){: external}, [CVE-2024-58055](https://nvd.nist.gov/vuln/detail/CVE-2024-58055){: external}, [CVE-2024-58056](https://nvd.nist.gov/vuln/detail/CVE-2024-58056){: external}, [CVE-2024-58057](https://nvd.nist.gov/vuln/detail/CVE-2024-58057){: external}, [CVE-2024-58058](https://nvd.nist.gov/vuln/detail/CVE-2024-58058){: external}, [CVE-2024-58061](https://nvd.nist.gov/vuln/detail/CVE-2024-58061){: external}, [CVE-2024-58063](https://nvd.nist.gov/vuln/detail/CVE-2024-58063){: external}, [CVE-2024-58068](https://nvd.nist.gov/vuln/detail/CVE-2024-58068){: external}, [CVE-2024-58069](https://nvd.nist.gov/vuln/detail/CVE-2024-58069){: external}, [CVE-2024-58070](https://nvd.nist.gov/vuln/detail/CVE-2024-58070){: external}, [CVE-2024-58071](https://nvd.nist.gov/vuln/detail/CVE-2024-58071){: external}, [CVE-2024-58072](https://nvd.nist.gov/vuln/detail/CVE-2024-58072){: external}, [CVE-2025-21705](https://nvd.nist.gov/vuln/detail/CVE-2025-21705){: external}, [CVE-2025-21707](https://nvd.nist.gov/vuln/detail/CVE-2025-21707){: external}, [CVE-2025-21708](https://nvd.nist.gov/vuln/detail/CVE-2025-21708){: external}, [CVE-2025-21710](https://nvd.nist.gov/vuln/detail/CVE-2025-21710){: external}, [CVE-2025-21711](https://nvd.nist.gov/vuln/detail/CVE-2025-21711){: external}, [CVE-2025-21714](https://nvd.nist.gov/vuln/detail/CVE-2025-21714){: external}, [CVE-2025-21715](https://nvd.nist.gov/vuln/detail/CVE-2025-21715){: external}, [CVE-2025-21716](https://nvd.nist.gov/vuln/detail/CVE-2025-21716){: external}, [CVE-2025-21718](https://nvd.nist.gov/vuln/detail/CVE-2025-21718){: external}, [CVE-2025-21719](https://nvd.nist.gov/vuln/detail/CVE-2025-21719){: external}, [CVE-2025-21720](https://nvd.nist.gov/vuln/detail/CVE-2025-21720){: external}, [CVE-2025-21721](https://nvd.nist.gov/vuln/detail/CVE-2025-21721){: external}, [CVE-2025-21722](https://nvd.nist.gov/vuln/detail/CVE-2025-21722){: external}, [CVE-2025-21723](https://nvd.nist.gov/vuln/detail/CVE-2025-21723){: external}, [CVE-2025-21724](https://nvd.nist.gov/vuln/detail/CVE-2025-21724){: external}, [CVE-2025-21725](https://nvd.nist.gov/vuln/detail/CVE-2025-21725){: external}, [CVE-2025-21726](https://nvd.nist.gov/vuln/detail/CVE-2025-21726){: external}, [CVE-2025-21727](https://nvd.nist.gov/vuln/detail/CVE-2025-21727){: external}, [CVE-2025-21728](https://nvd.nist.gov/vuln/detail/CVE-2025-21728){: external}, [CVE-2025-21731](https://nvd.nist.gov/vuln/detail/CVE-2025-21731){: external}, [CVE-2025-21798](https://nvd.nist.gov/vuln/detail/CVE-2025-21798){: external}, [CVE-2025-21799](https://nvd.nist.gov/vuln/detail/CVE-2025-21799){: external}, [CVE-2025-21801](https://nvd.nist.gov/vuln/detail/CVE-2025-21801){: external}, [CVE-2025-21802](https://nvd.nist.gov/vuln/detail/CVE-2025-21802){: external}, [CVE-2025-21803](https://nvd.nist.gov/vuln/detail/CVE-2025-21803){: external}, [CVE-2025-21804](https://nvd.nist.gov/vuln/detail/CVE-2025-21804){: external}, [CVE-2025-21806](https://nvd.nist.gov/vuln/detail/CVE-2025-21806){: external}, [CVE-2025-21808](https://nvd.nist.gov/vuln/detail/CVE-2025-21808){: external}, [CVE-2025-21809](https://nvd.nist.gov/vuln/detail/CVE-2025-21809){: external}, [CVE-2025-21810](https://nvd.nist.gov/vuln/detail/CVE-2025-21810){: external}, [CVE-2025-21811](https://nvd.nist.gov/vuln/detail/CVE-2025-21811){: external}, [CVE-2025-21812](https://nvd.nist.gov/vuln/detail/CVE-2025-21812){: external}, [CVE-2025-21825](https://nvd.nist.gov/vuln/detail/CVE-2025-21825){: external}, [CVE-2025-21826](https://nvd.nist.gov/vuln/detail/CVE-2025-21826){: external}, [CVE-2025-21828](https://nvd.nist.gov/vuln/detail/CVE-2025-21828){: external}, [CVE-2025-21829](https://nvd.nist.gov/vuln/detail/CVE-2025-21829){: external}, [CVE-2025-21830](https://nvd.nist.gov/vuln/detail/CVE-2025-21830){: external}, [CVE-2025-22088](https://nvd.nist.gov/vuln/detail/CVE-2025-22088){: external}, [CVE-2025-32988](https://nvd.nist.gov/vuln/detail/CVE-2025-32988){: external}, [CVE-2025-32989](https://nvd.nist.gov/vuln/detail/CVE-2025-32989){: external}, [CVE-2025-32990](https://nvd.nist.gov/vuln/detail/CVE-2025-32990){: external}, [CVE-2025-37750](https://nvd.nist.gov/vuln/detail/CVE-2025-37750){: external}, [CVE-2025-37798](https://nvd.nist.gov/vuln/detail/CVE-2025-37798){: external}, [CVE-2025-37890](https://nvd.nist.gov/vuln/detail/CVE-2025-37890){: external}, [CVE-2025-37946](https://nvd.nist.gov/vuln/detail/CVE-2025-37946){: external}, [CVE-2025-37974](https://nvd.nist.gov/vuln/detail/CVE-2025-37974){: external}, [CVE-2025-37997](https://nvd.nist.gov/vuln/detail/CVE-2025-37997){: external}, [CVE-2025-40364](https://nvd.nist.gov/vuln/detail/CVE-2025-40364){: external}, [CVE-2025-47268](https://nvd.nist.gov/vuln/detail/CVE-2025-47268){: external}, [CVE-2025-48060](https://nvd.nist.gov/vuln/detail/CVE-2025-48060){: external}, [CVE-2025-48964](https://nvd.nist.gov/vuln/detail/CVE-2025-48964){: external}, [CVE-2025-5702](https://nvd.nist.gov/vuln/detail/CVE-2025-5702){: external}, and [CVE-2025-6395](https://nvd.nist.gov/vuln/detail/CVE-2025-6395){: external}.|
|Kubernetes|1.32.7|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.7).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|b19109a289be3a60985c14bfdaf2b48a472556c0|Resolves the following CVEs: [CVE-2024-54661](https://nvd.nist.gov/vuln/detail/CVE-2024-54661){: external}, [CVE-2024-34397](https://nvd.nist.gov/vuln/detail/CVE-2024-34397){: external}, [CVE-2019-17543](https://nvd.nist.gov/vuln/detail/CVE-2019-17543){: external}, [CVE-2024-52533](https://nvd.nist.gov/vuln/detail/CVE-2024-52533){: external}, and [CVE-2025-4373](https://nvd.nist.gov/vuln/detail/CVE-2025-4373){: external}.|
|GPU Device Plug-in and Installer|ad7322eabed8ea8245c806369db7a2410944b4b4|Resolves the following CVEs: [CVE-2019-17543](https://nvd.nist.gov/vuln/detail/CVE-2019-17543){: external}, [CVE-2024-52533](https://nvd.nist.gov/vuln/detail/CVE-2024-52533){: external}, [CVE-2024-34397](https://nvd.nist.gov/vuln/detail/CVE-2024-34397){: external}, [CVE-2025-4373](https://nvd.nist.gov/vuln/detail/CVE-2025-4373){: external}, and [CVE-2025-47273](https://nvd.nist.gov/vuln/detail/CVE-2025-47273){: external}.|
{: caption="1.32.7_1550 fix pack." caption-side="bottom"}
{: #cl-boms-1327_1550_W-component-table}



### Worker node fix pack 1.32.5_1548, released 14 July 2025
{: #cl-boms-1325_1548_W}

The following table shows the components included in the worker node fix pack 1.32.5_1548. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-63-generic|Resolves the following CVEs: [CVE-2025-22088](https://nvd.nist.gov/vuln/detail/CVE-2025-22088){: external}, [CVE-2025-27613](https://nvd.nist.gov/vuln/detail/CVE-2025-27613){: external}, [CVE-2025-27614](https://nvd.nist.gov/vuln/detail/CVE-2025-27614){: external}, [CVE-2025-30258](https://nvd.nist.gov/vuln/detail/CVE-2025-30258){: external}, [CVE-2025-32462](https://nvd.nist.gov/vuln/detail/CVE-2025-32462){: external}, [CVE-2025-32463](https://nvd.nist.gov/vuln/detail/CVE-2025-32463){: external}, [CVE-2025-37798](https://nvd.nist.gov/vuln/detail/CVE-2025-37798){: external}, [CVE-2025-37890](https://nvd.nist.gov/vuln/detail/CVE-2025-37890){: external}, [CVE-2025-37997](https://nvd.nist.gov/vuln/detail/CVE-2025-37997){: external}, [CVE-2025-46835](https://nvd.nist.gov/vuln/detail/CVE-2025-46835){: external}, [CVE-2025-48384](https://nvd.nist.gov/vuln/detail/CVE-2025-48384){: external}, [CVE-2025-48385](https://nvd.nist.gov/vuln/detail/CVE-2025-48385){: external}, [CVE-2025-48386](https://nvd.nist.gov/vuln/detail/CVE-2025-48386){: external}, [CVE-2025-4877](https://nvd.nist.gov/vuln/detail/CVE-2025-4877){: external}, [CVE-2025-4878](https://nvd.nist.gov/vuln/detail/CVE-2025-4878){: external}, [CVE-2025-5318](https://nvd.nist.gov/vuln/detail/CVE-2025-5318){: external}, [CVE-2025-5351](https://nvd.nist.gov/vuln/detail/CVE-2025-5351){: external}, [CVE-2025-5372](https://nvd.nist.gov/vuln/detail/CVE-2025-5372){: external}, and [CVE-2025-5987](https://nvd.nist.gov/vuln/detail/CVE-2025-5987){: external}.|
|Kubernetes|1.32.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.5).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|3bb13ac682885a0885eacb7edd1ee7a36d54e2a8|Resolves the following CVEs: [CVE-2025-6021](https://nvd.nist.gov/vuln/detail/CVE-2025-6021){: external}, [CVE-2025-49796](https://nvd.nist.gov/vuln/detail/CVE-2025-49796){: external}, [CVE-2025-49794](https://nvd.nist.gov/vuln/detail/CVE-2025-49794){: external}, and [CVE-2025-6020](https://nvd.nist.gov/vuln/detail/CVE-2025-6020){: external}.|
|GPU Device Plug-in and Installer|0c5c1f69809faf55f9375dd7eedde342c56cc63e|Resolves the following CVEs: [CVE-2025-6020](https://nvd.nist.gov/vuln/detail/CVE-2025-6020){: external}, [CVE-2025-4330](https://nvd.nist.gov/vuln/detail/CVE-2025-4330){: external}, [CVE-2025-4138](https://nvd.nist.gov/vuln/detail/CVE-2025-4138){: external}, [CVE-2025-4435](https://nvd.nist.gov/vuln/detail/CVE-2025-4435){: external}, [CVE-2025-6021](https://nvd.nist.gov/vuln/detail/CVE-2025-6021){: external}, [CVE-2025-4517](https://nvd.nist.gov/vuln/detail/CVE-2025-4517){: external}, [CVE-2024-12718](https://nvd.nist.gov/vuln/detail/CVE-2024-12718){: external}, [CVE-2025-49796](https://nvd.nist.gov/vuln/detail/CVE-2025-49796){: external}, and [CVE-2025-49794](https://nvd.nist.gov/vuln/detail/CVE-2025-49794){: external}.|
{: caption="1.32.5_1548 fix pack." caption-side="bottom"}
{: #cl-boms-1325_1548_W-component-table}



### Worker node fix pack 1.32.5_1547, released 01 July 2025
{: #cl-boms-1325_1547_W}

The following table shows the components included in the worker node fix pack 1.32.5_1547. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-62-generic|Resolves the following CVEs: [CVE-2024-12718](https://nvd.nist.gov/vuln/detail/CVE-2024-12718){: external}, [CVE-2024-47081](https://nvd.nist.gov/vuln/detail/CVE-2024-47081){: external}, [CVE-2024-50157](https://nvd.nist.gov/vuln/detail/CVE-2024-50157){: external}, [CVE-2024-53124](https://nvd.nist.gov/vuln/detail/CVE-2024-53124){: external}, [CVE-2024-57924](https://nvd.nist.gov/vuln/detail/CVE-2024-57924){: external}, [CVE-2024-57948](https://nvd.nist.gov/vuln/detail/CVE-2024-57948){: external}, [CVE-2024-57949](https://nvd.nist.gov/vuln/detail/CVE-2024-57949){: external}, [CVE-2024-57951](https://nvd.nist.gov/vuln/detail/CVE-2024-57951){: external}, [CVE-2025-1795](https://nvd.nist.gov/vuln/detail/CVE-2025-1795){: external}, [CVE-2025-21665](https://nvd.nist.gov/vuln/detail/CVE-2025-21665){: external}, [CVE-2025-21666](https://nvd.nist.gov/vuln/detail/CVE-2025-21666){: external}, [CVE-2025-21667](https://nvd.nist.gov/vuln/detail/CVE-2025-21667){: external}, [CVE-2025-21668](https://nvd.nist.gov/vuln/detail/CVE-2025-21668){: external}, [CVE-2025-21669](https://nvd.nist.gov/vuln/detail/CVE-2025-21669){: external}, [CVE-2025-21670](https://nvd.nist.gov/vuln/detail/CVE-2025-21670){: external}, [CVE-2025-21672](https://nvd.nist.gov/vuln/detail/CVE-2025-21672){: external}, [CVE-2025-21673](https://nvd.nist.gov/vuln/detail/CVE-2025-21673){: external}, [CVE-2025-21674](https://nvd.nist.gov/vuln/detail/CVE-2025-21674){: external}, [CVE-2025-21675](https://nvd.nist.gov/vuln/detail/CVE-2025-21675){: external}, [CVE-2025-21676](https://nvd.nist.gov/vuln/detail/CVE-2025-21676){: external}, [CVE-2025-21678](https://nvd.nist.gov/vuln/detail/CVE-2025-21678){: external}, [CVE-2025-21680](https://nvd.nist.gov/vuln/detail/CVE-2025-21680){: external}, [CVE-2025-21681](https://nvd.nist.gov/vuln/detail/CVE-2025-21681){: external}, [CVE-2025-21682](https://nvd.nist.gov/vuln/detail/CVE-2025-21682){: external}, [CVE-2025-21683](https://nvd.nist.gov/vuln/detail/CVE-2025-21683){: external}, [CVE-2025-21684](https://nvd.nist.gov/vuln/detail/CVE-2025-21684){: external}, [CVE-2025-21689](https://nvd.nist.gov/vuln/detail/CVE-2025-21689){: external}, [CVE-2025-21690](https://nvd.nist.gov/vuln/detail/CVE-2025-21690){: external}, [CVE-2025-21691](https://nvd.nist.gov/vuln/detail/CVE-2025-21691){: external}, [CVE-2025-21692](https://nvd.nist.gov/vuln/detail/CVE-2025-21692){: external}, [CVE-2025-21694](https://nvd.nist.gov/vuln/detail/CVE-2025-21694){: external}, [CVE-2025-21697](https://nvd.nist.gov/vuln/detail/CVE-2025-21697){: external}, [CVE-2025-21699](https://nvd.nist.gov/vuln/detail/CVE-2025-21699){: external}, [CVE-2025-2312](https://nvd.nist.gov/vuln/detail/CVE-2025-2312){: external}, [CVE-2025-4138](https://nvd.nist.gov/vuln/detail/CVE-2025-4138){: external}, [CVE-2025-4330](https://nvd.nist.gov/vuln/detail/CVE-2025-4330){: external}, [CVE-2025-4435](https://nvd.nist.gov/vuln/detail/CVE-2025-4435){: external}, [CVE-2025-4516](https://nvd.nist.gov/vuln/detail/CVE-2025-4516){: external}, [CVE-2025-4517](https://nvd.nist.gov/vuln/detail/CVE-2025-4517){: external}, [CVE-2025-50181](https://nvd.nist.gov/vuln/detail/CVE-2025-50181){: external}, [CVE-2025-5914](https://nvd.nist.gov/vuln/detail/CVE-2025-5914){: external}, [CVE-2025-5915](https://nvd.nist.gov/vuln/detail/CVE-2025-5915){: external}, [CVE-2025-5916](https://nvd.nist.gov/vuln/detail/CVE-2025-5916){: external}, [CVE-2025-5917](https://nvd.nist.gov/vuln/detail/CVE-2025-5917){: external}, [CVE-2025-6019](https://nvd.nist.gov/vuln/detail/CVE-2025-6019){: external}, and [CVE-2025-6020](https://nvd.nist.gov/vuln/detail/CVE-2025-6020){: external}.|
|Kubernetes|1.32.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.5).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|951efd90b46e95a54751966c644ac37c4c901f92|N/A|
|GPU Device Plug-in and Installer|cbca3eaad7d585c0d1181e478f39bab25579fb9a|N/A|
{: caption="1.32.5_1547 fix pack." caption-side="bottom"}
{: #cl-boms-1325_1547_W-component-table}



### Master fix pack 1.32.5_1544, released 18 June 2025
{: #1325_1544_M}

The following table shows the changes that are in the master fix pack 1.32.5_1544. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.29.2 | v3.29.3 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#v3.29.3){: external}. |
| CoreDNS | v1.12.0 | v1.12.1 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.17 | v2.5.19 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.5-1 | v1.32.5-4 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | d1545bd | 38dc95c | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.13 | v2.10.14 | New version contains updates and security fixes. |
| Tigera Operator | v1.36.5 | v1.36.8 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.36.8){: external}. |
{: caption="Changes since version 1.32.5_1541" caption-side="bottom"}



### Worker node fix pack 1.32.5_1545, released 16 June 2025
{: #cl-boms-1325_1545_W}

The following table shows the components included in the worker node fix pack 1.32.5_1545. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-60-generic|Resolves the following CVEs: [CVE-2025-4598](https://nvd.nist.gov/vuln/detail/CVE-2025-4598){: external}.|
|Kubernetes|1.32.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.5).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|951efd90b46e95a54751966c644ac37c4c901f92|Resolves the following CVEs: [CVE-2025-4802](https://nvd.nist.gov/vuln/detail/CVE-2025-4802){: external}, [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, and [CVE-2025-3576](https://nvd.nist.gov/vuln/detail/CVE-2025-3576){: external}.|
|GPU Device Plug-in and Installer|cbca3eaad7d585c0d1181e478f39bab25579fb9a|Resolves the following CVEs: [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, [CVE-2025-4802](https://nvd.nist.gov/vuln/detail/CVE-2025-4802){: external}, and [CVE-2025-3576](https://nvd.nist.gov/vuln/detail/CVE-2025-3576){: external}.|
{: caption="1.32.5_1545 fix pack." caption-side="bottom"}
{: #cl-boms-1325_1545_W-component-table}



### Worker node fix pack 1.32.5_1542, released 04 June 2025
{: #cl-boms-1325_1542_W}

The following table shows the components included in the worker node fix pack 1.32.5_1542. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-60-generic|Resolves the following CVEs: [CVE-2024-45774](https://nvd.nist.gov/vuln/detail/CVE-2024-45774){: external}, [CVE-2024-45775](https://nvd.nist.gov/vuln/detail/CVE-2024-45775){: external}, [CVE-2024-45776](https://nvd.nist.gov/vuln/detail/CVE-2024-45776){: external}, [CVE-2024-45777](https://nvd.nist.gov/vuln/detail/CVE-2024-45777){: external}, [CVE-2024-45778](https://nvd.nist.gov/vuln/detail/CVE-2024-45778){: external}, [CVE-2024-45779](https://nvd.nist.gov/vuln/detail/CVE-2024-45779){: external}, [CVE-2024-45780](https://nvd.nist.gov/vuln/detail/CVE-2024-45780){: external}, [CVE-2024-45781](https://nvd.nist.gov/vuln/detail/CVE-2024-45781){: external}, [CVE-2024-45782](https://nvd.nist.gov/vuln/detail/CVE-2024-45782){: external}, [CVE-2024-45783](https://nvd.nist.gov/vuln/detail/CVE-2024-45783){: external}, [CVE-2025-0622](https://nvd.nist.gov/vuln/detail/CVE-2025-0622){: external}, [CVE-2025-0624](https://nvd.nist.gov/vuln/detail/CVE-2025-0624){: external}, [CVE-2025-0677](https://nvd.nist.gov/vuln/detail/CVE-2025-0677){: external}, [CVE-2025-0678](https://nvd.nist.gov/vuln/detail/CVE-2025-0678){: external}, [CVE-2025-0684](https://nvd.nist.gov/vuln/detail/CVE-2025-0684){: external}, [CVE-2025-0685](https://nvd.nist.gov/vuln/detail/CVE-2025-0685){: external}, [CVE-2025-0686](https://nvd.nist.gov/vuln/detail/CVE-2025-0686){: external}, [CVE-2025-0689](https://nvd.nist.gov/vuln/detail/CVE-2025-0689){: external}, [CVE-2025-0690](https://nvd.nist.gov/vuln/detail/CVE-2025-0690){: external}, [CVE-2025-1118](https://nvd.nist.gov/vuln/detail/CVE-2025-1118){: external}, [CVE-2025-1125](https://nvd.nist.gov/vuln/detail/CVE-2025-1125){: external}, [CVE-2025-29087](https://nvd.nist.gov/vuln/detail/CVE-2025-29087){: external}, [CVE-2025-29088](https://nvd.nist.gov/vuln/detail/CVE-2025-29088){: external}, [CVE-2025-3277](https://nvd.nist.gov/vuln/detail/CVE-2025-3277){: external}, [CVE-2025-3576](https://nvd.nist.gov/vuln/detail/CVE-2025-3576){: external}, [CVE-2025-4373](https://nvd.nist.gov/vuln/detail/CVE-2025-4373){: external}, [CVE-2025-46836](https://nvd.nist.gov/vuln/detail/CVE-2025-46836){: external}, and [CVE-2025-47273](https://nvd.nist.gov/vuln/detail/CVE-2025-47273){: external}.|
|Kubernetes|1.32.5|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.5).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|978e3c26ee7634e39a940696aaf57d9e374db5ce|N/A|
|GPU Device Plug-in and Installer|9c52a5f3c684d3da2808c70936332fd18493d0c7|N/A|
{: caption="1.32.5_1542 fix pack." caption-side="bottom"}
{: #cl-boms-1325_1542_W-component-table}



### Master fix pack 1.32.5_1541, released 28 May 2025
{: #1325_1541_M}

The following table shows the changes that are in the master fix pack 1.32.5_1541. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.6.8 | v1.6.9 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.3-6 | v1.32.5-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 449 | 450 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.12 | v2.10.13 | New version contains updates and security fixes. |
| Kubernetes | v1.32.4 | v1.32.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 3232 | 3293 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.26 | v0.13.28 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.28){: external}. |
{: caption="Changes since version 1.32.4_1538" caption-side="bottom"}



### Worker node fix pack 1.32.4_1540, released 19 May 2025
{: #cl-boms-1324_1540_W}

The following table shows the components included in the worker node fix pack 1.32.4_1540. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-60-generic|Resolves the following CVEs: [CVE-2024-36476](https://nvd.nist.gov/vuln/detail/CVE-2024-36476){: external}, [CVE-2024-39282](https://nvd.nist.gov/vuln/detail/CVE-2024-39282){: external}, [CVE-2024-41013](https://nvd.nist.gov/vuln/detail/CVE-2024-41013){: external}, [CVE-2024-45774](https://nvd.nist.gov/vuln/detail/CVE-2024-45774){: external}, [CVE-2024-45775](https://nvd.nist.gov/vuln/detail/CVE-2024-45775){: external}, [CVE-2024-45776](https://nvd.nist.gov/vuln/detail/CVE-2024-45776){: external}, [CVE-2024-45777](https://nvd.nist.gov/vuln/detail/CVE-2024-45777){: external}, [CVE-2024-45778](https://nvd.nist.gov/vuln/detail/CVE-2024-45778){: external}, [CVE-2024-45779](https://nvd.nist.gov/vuln/detail/CVE-2024-45779){: external}, [CVE-2024-45780](https://nvd.nist.gov/vuln/detail/CVE-2024-45780){: external}, [CVE-2024-45781](https://nvd.nist.gov/vuln/detail/CVE-2024-45781){: external}, [CVE-2024-45782](https://nvd.nist.gov/vuln/detail/CVE-2024-45782){: external}, [CVE-2024-45783](https://nvd.nist.gov/vuln/detail/CVE-2024-45783){: external}, [CVE-2024-47408](https://nvd.nist.gov/vuln/detail/CVE-2024-47408){: external}, [CVE-2024-47736](https://nvd.nist.gov/vuln/detail/CVE-2024-47736){: external}, [CVE-2024-49568](https://nvd.nist.gov/vuln/detail/CVE-2024-49568){: external}, [CVE-2024-49571](https://nvd.nist.gov/vuln/detail/CVE-2024-49571){: external}, [CVE-2024-53125](https://nvd.nist.gov/vuln/detail/CVE-2024-53125){: external}, [CVE-2024-53179](https://nvd.nist.gov/vuln/detail/CVE-2024-53179){: external}, [CVE-2024-53685](https://nvd.nist.gov/vuln/detail/CVE-2024-53685){: external}, [CVE-2024-53687](https://nvd.nist.gov/vuln/detail/CVE-2024-53687){: external}, [CVE-2024-53690](https://nvd.nist.gov/vuln/detail/CVE-2024-53690){: external}, [CVE-2024-54193](https://nvd.nist.gov/vuln/detail/CVE-2024-54193){: external}, [CVE-2024-54455](https://nvd.nist.gov/vuln/detail/CVE-2024-54455){: external}, [CVE-2024-54460](https://nvd.nist.gov/vuln/detail/CVE-2024-54460){: external}, [CVE-2024-54683](https://nvd.nist.gov/vuln/detail/CVE-2024-54683){: external}, [CVE-2024-55639](https://nvd.nist.gov/vuln/detail/CVE-2024-55639){: external}, [CVE-2024-55881](https://nvd.nist.gov/vuln/detail/CVE-2024-55881){: external}, [CVE-2024-55916](https://nvd.nist.gov/vuln/detail/CVE-2024-55916){: external}, [CVE-2024-56369](https://nvd.nist.gov/vuln/detail/CVE-2024-56369){: external}, [CVE-2024-56372](https://nvd.nist.gov/vuln/detail/CVE-2024-56372){: external}, [CVE-2024-56652](https://nvd.nist.gov/vuln/detail/CVE-2024-56652){: external}, [CVE-2024-56653](https://nvd.nist.gov/vuln/detail/CVE-2024-56653){: external}, [CVE-2024-56654](https://nvd.nist.gov/vuln/detail/CVE-2024-56654){: external}, [CVE-2024-56656](https://nvd.nist.gov/vuln/detail/CVE-2024-56656){: external}, [CVE-2024-56657](https://nvd.nist.gov/vuln/detail/CVE-2024-56657){: external}, [CVE-2024-56659](https://nvd.nist.gov/vuln/detail/CVE-2024-56659){: external}, [CVE-2024-56660](https://nvd.nist.gov/vuln/detail/CVE-2024-56660){: external}, [CVE-2024-56662](https://nvd.nist.gov/vuln/detail/CVE-2024-56662){: external}, [CVE-2024-56664](https://nvd.nist.gov/vuln/detail/CVE-2024-56664){: external}, [CVE-2024-56667](https://nvd.nist.gov/vuln/detail/CVE-2024-56667){: external}, [CVE-2024-56670](https://nvd.nist.gov/vuln/detail/CVE-2024-56670){: external}, [CVE-2024-56675](https://nvd.nist.gov/vuln/detail/CVE-2024-56675){: external}, [CVE-2024-56709](https://nvd.nist.gov/vuln/detail/CVE-2024-56709){: external}, [CVE-2024-56710](https://nvd.nist.gov/vuln/detail/CVE-2024-56710){: external}, [CVE-2024-56715](https://nvd.nist.gov/vuln/detail/CVE-2024-56715){: external}, [CVE-2024-56716](https://nvd.nist.gov/vuln/detail/CVE-2024-56716){: external}, [CVE-2024-56717](https://nvd.nist.gov/vuln/detail/CVE-2024-56717){: external}, [CVE-2024-56718](https://nvd.nist.gov/vuln/detail/CVE-2024-56718){: external}, [CVE-2024-56758](https://nvd.nist.gov/vuln/detail/CVE-2024-56758){: external}, [CVE-2024-56759](https://nvd.nist.gov/vuln/detail/CVE-2024-56759){: external}, [CVE-2024-56760](https://nvd.nist.gov/vuln/detail/CVE-2024-56760){: external}, [CVE-2024-56761](https://nvd.nist.gov/vuln/detail/CVE-2024-56761){: external}, [CVE-2024-56763](https://nvd.nist.gov/vuln/detail/CVE-2024-56763){: external}, [CVE-2024-56764](https://nvd.nist.gov/vuln/detail/CVE-2024-56764){: external}, [CVE-2024-56767](https://nvd.nist.gov/vuln/detail/CVE-2024-56767){: external}, [CVE-2024-56769](https://nvd.nist.gov/vuln/detail/CVE-2024-56769){: external}, [CVE-2024-56770](https://nvd.nist.gov/vuln/detail/CVE-2024-56770){: external}, [CVE-2024-57791](https://nvd.nist.gov/vuln/detail/CVE-2024-57791){: external}, [CVE-2024-57792](https://nvd.nist.gov/vuln/detail/CVE-2024-57792){: external}, [CVE-2024-57793](https://nvd.nist.gov/vuln/detail/CVE-2024-57793){: external}, [CVE-2024-57801](https://nvd.nist.gov/vuln/detail/CVE-2024-57801){: external}, [CVE-2024-57802](https://nvd.nist.gov/vuln/detail/CVE-2024-57802){: external}, [CVE-2024-57804](https://nvd.nist.gov/vuln/detail/CVE-2024-57804){: external}, [CVE-2024-57806](https://nvd.nist.gov/vuln/detail/CVE-2024-57806){: external}, [CVE-2024-57807](https://nvd.nist.gov/vuln/detail/CVE-2024-57807){: external}, [CVE-2024-57841](https://nvd.nist.gov/vuln/detail/CVE-2024-57841){: external}, [CVE-2024-57879](https://nvd.nist.gov/vuln/detail/CVE-2024-57879){: external}, [CVE-2024-57882](https://nvd.nist.gov/vuln/detail/CVE-2024-57882){: external}, [CVE-2024-57883](https://nvd.nist.gov/vuln/detail/CVE-2024-57883){: external}, [CVE-2024-57884](https://nvd.nist.gov/vuln/detail/CVE-2024-57884){: external}, [CVE-2024-57885](https://nvd.nist.gov/vuln/detail/CVE-2024-57885){: external}, [CVE-2024-57887](https://nvd.nist.gov/vuln/detail/CVE-2024-57887){: external}, [CVE-2024-57888](https://nvd.nist.gov/vuln/detail/CVE-2024-57888){: external}, [CVE-2024-57889](https://nvd.nist.gov/vuln/detail/CVE-2024-57889){: external}, [CVE-2024-57890](https://nvd.nist.gov/vuln/detail/CVE-2024-57890){: external}, [CVE-2024-57892](https://nvd.nist.gov/vuln/detail/CVE-2024-57892){: external}, [CVE-2024-57893](https://nvd.nist.gov/vuln/detail/CVE-2024-57893){: external}, [CVE-2024-57895](https://nvd.nist.gov/vuln/detail/CVE-2024-57895){: external}, [CVE-2024-57896](https://nvd.nist.gov/vuln/detail/CVE-2024-57896){: external}, [CVE-2024-57897](https://nvd.nist.gov/vuln/detail/CVE-2024-57897){: external}, [CVE-2024-57898](https://nvd.nist.gov/vuln/detail/CVE-2024-57898){: external}, [CVE-2024-57899](https://nvd.nist.gov/vuln/detail/CVE-2024-57899){: external}, [CVE-2024-57900](https://nvd.nist.gov/vuln/detail/CVE-2024-57900){: external}, [CVE-2024-57901](https://nvd.nist.gov/vuln/detail/CVE-2024-57901){: external}, [CVE-2024-57902](https://nvd.nist.gov/vuln/detail/CVE-2024-57902){: external}, [CVE-2024-57903](https://nvd.nist.gov/vuln/detail/CVE-2024-57903){: external}, [CVE-2024-57904](https://nvd.nist.gov/vuln/detail/CVE-2024-57904){: external}, [CVE-2024-57906](https://nvd.nist.gov/vuln/detail/CVE-2024-57906){: external}, [CVE-2024-57907](https://nvd.nist.gov/vuln/detail/CVE-2024-57907){: external}, [CVE-2024-57908](https://nvd.nist.gov/vuln/detail/CVE-2024-57908){: external}, [CVE-2024-57910](https://nvd.nist.gov/vuln/detail/CVE-2024-57910){: external}, [CVE-2024-57911](https://nvd.nist.gov/vuln/detail/CVE-2024-57911){: external}, [CVE-2024-57912](https://nvd.nist.gov/vuln/detail/CVE-2024-57912){: external}, [CVE-2024-57913](https://nvd.nist.gov/vuln/detail/CVE-2024-57913){: external}, [CVE-2024-57916](https://nvd.nist.gov/vuln/detail/CVE-2024-57916){: external}, [CVE-2024-57917](https://nvd.nist.gov/vuln/detail/CVE-2024-57917){: external}, [CVE-2024-57925](https://nvd.nist.gov/vuln/detail/CVE-2024-57925){: external}, [CVE-2024-57926](https://nvd.nist.gov/vuln/detail/CVE-2024-57926){: external}, [CVE-2024-57929](https://nvd.nist.gov/vuln/detail/CVE-2024-57929){: external}, [CVE-2024-57931](https://nvd.nist.gov/vuln/detail/CVE-2024-57931){: external}, [CVE-2024-57932](https://nvd.nist.gov/vuln/detail/CVE-2024-57932){: external}, [CVE-2024-57933](https://nvd.nist.gov/vuln/detail/CVE-2024-57933){: external}, [CVE-2024-57938](https://nvd.nist.gov/vuln/detail/CVE-2024-57938){: external}, [CVE-2024-57939](https://nvd.nist.gov/vuln/detail/CVE-2024-57939){: external}, [CVE-2024-57940](https://nvd.nist.gov/vuln/detail/CVE-2024-57940){: external}, [CVE-2024-57945](https://nvd.nist.gov/vuln/detail/CVE-2024-57945){: external}, [CVE-2024-57946](https://nvd.nist.gov/vuln/detail/CVE-2024-57946){: external}, [CVE-2025-0622](https://nvd.nist.gov/vuln/detail/CVE-2025-0622){: external}, [CVE-2025-0624](https://nvd.nist.gov/vuln/detail/CVE-2025-0624){: external}, [CVE-2025-0677](https://nvd.nist.gov/vuln/detail/CVE-2025-0677){: external}, [CVE-2025-0678](https://nvd.nist.gov/vuln/detail/CVE-2025-0678){: external}, [CVE-2025-0684](https://nvd.nist.gov/vuln/detail/CVE-2025-0684){: external}, [CVE-2025-0685](https://nvd.nist.gov/vuln/detail/CVE-2025-0685){: external}, [CVE-2025-0686](https://nvd.nist.gov/vuln/detail/CVE-2025-0686){: external}, [CVE-2025-0689](https://nvd.nist.gov/vuln/detail/CVE-2025-0689){: external}, [CVE-2025-0690](https://nvd.nist.gov/vuln/detail/CVE-2025-0690){: external}, [CVE-2025-1118](https://nvd.nist.gov/vuln/detail/CVE-2025-1118){: external}, [CVE-2025-1125](https://nvd.nist.gov/vuln/detail/CVE-2025-1125){: external}, [CVE-2025-21631](https://nvd.nist.gov/vuln/detail/CVE-2025-21631){: external}, [CVE-2025-21632](https://nvd.nist.gov/vuln/detail/CVE-2025-21632){: external}, [CVE-2025-21634](https://nvd.nist.gov/vuln/detail/CVE-2025-21634){: external}, [CVE-2025-21635](https://nvd.nist.gov/vuln/detail/CVE-2025-21635){: external}, [CVE-2025-21636](https://nvd.nist.gov/vuln/detail/CVE-2025-21636){: external}, [CVE-2025-21637](https://nvd.nist.gov/vuln/detail/CVE-2025-21637){: external}, [CVE-2025-21638](https://nvd.nist.gov/vuln/detail/CVE-2025-21638){: external}, [CVE-2025-21639](https://nvd.nist.gov/vuln/detail/CVE-2025-21639){: external}, [CVE-2025-21640](https://nvd.nist.gov/vuln/detail/CVE-2025-21640){: external}, [CVE-2025-21642](https://nvd.nist.gov/vuln/detail/CVE-2025-21642){: external}, [CVE-2025-21643](https://nvd.nist.gov/vuln/detail/CVE-2025-21643){: external}, [CVE-2025-21645](https://nvd.nist.gov/vuln/detail/CVE-2025-21645){: external}, [CVE-2025-21646](https://nvd.nist.gov/vuln/detail/CVE-2025-21646){: external}, [CVE-2025-21647](https://nvd.nist.gov/vuln/detail/CVE-2025-21647){: external}, [CVE-2025-21648](https://nvd.nist.gov/vuln/detail/CVE-2025-21648){: external}, [CVE-2025-21649](https://nvd.nist.gov/vuln/detail/CVE-2025-21649){: external}, [CVE-2025-21650](https://nvd.nist.gov/vuln/detail/CVE-2025-21650){: external}, [CVE-2025-21651](https://nvd.nist.gov/vuln/detail/CVE-2025-21651){: external}, [CVE-2025-21652](https://nvd.nist.gov/vuln/detail/CVE-2025-21652){: external}, [CVE-2025-21653](https://nvd.nist.gov/vuln/detail/CVE-2025-21653){: external}, [CVE-2025-21654](https://nvd.nist.gov/vuln/detail/CVE-2025-21654){: external}, [CVE-2025-21655](https://nvd.nist.gov/vuln/detail/CVE-2025-21655){: external}, [CVE-2025-21656](https://nvd.nist.gov/vuln/detail/CVE-2025-21656){: external}, [CVE-2025-21658](https://nvd.nist.gov/vuln/detail/CVE-2025-21658){: external}, [CVE-2025-21659](https://nvd.nist.gov/vuln/detail/CVE-2025-21659){: external}, [CVE-2025-21660](https://nvd.nist.gov/vuln/detail/CVE-2025-21660){: external}, [CVE-2025-21662](https://nvd.nist.gov/vuln/detail/CVE-2025-21662){: external}, [CVE-2025-21663](https://nvd.nist.gov/vuln/detail/CVE-2025-21663){: external}, [CVE-2025-21664](https://nvd.nist.gov/vuln/detail/CVE-2025-21664){: external}, [CVE-2025-21971](https://nvd.nist.gov/vuln/detail/CVE-2025-21971){: external}, and [CVE-2025-22247](https://nvd.nist.gov/vuln/detail/CVE-2025-22247){: external}.|
|Kubernetes|1.32.4|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.4).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|978e3c26ee7634e39a940696aaf57d9e374db5ce|N/A|
|GPU Device Plug-in and Installer|9c52a5f3c684d3da2808c70936332fd18493d0c7|N/A|
{: caption="1.32.4_1540 fix pack." caption-side="bottom"}
{: #cl-boms-1324_1540_W-component-table}



### Worker node fix pack 1.32.4_1539, released 07 May 2025
{: #cl-boms-1324_1539_W}

The following table shows the components included in the worker node fix pack 1.32.4_1539. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-58-generic|Resolves the following CVEs: [CVE-2024-56653](https://nvd.nist.gov/vuln/detail/CVE-2024-56653){: external}, [CVE-2025-1632](https://nvd.nist.gov/vuln/detail/CVE-2025-1632){: external}, [CVE-2025-25724](https://nvd.nist.gov/vuln/detail/CVE-2025-25724){: external}, [CVE-2025-32414](https://nvd.nist.gov/vuln/detail/CVE-2025-32414){: external}, [CVE-2025-32415](https://nvd.nist.gov/vuln/detail/CVE-2025-32415){: external}, and [CVE-2025-32728](https://nvd.nist.gov/vuln/detail/CVE-2025-32728){: external}.|
|Kubernetes|1.32.4|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.4).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|978e3c26ee7634e39a940696aaf57d9e374db5ce|Resolves the following CVEs: [CVE-2024-12243](https://nvd.nist.gov/vuln/detail/CVE-2024-12243){: external}, and [CVE-2024-12133](https://nvd.nist.gov/vuln/detail/CVE-2024-12133){: external}.|
|GPU Device Plug-in and Installer|9c52a5f3c684d3da2808c70936332fd18493d0c7|Resolves the following CVEs: [CVE-2024-12243](https://nvd.nist.gov/vuln/detail/CVE-2024-12243){: external}, and [CVE-2024-12133](https://nvd.nist.gov/vuln/detail/CVE-2024-12133){: external}.|
{: caption="1.32.4_1539 fix pack." caption-side="bottom"}
{: #cl-boms-1324_1539_W-component-table}



### Master fix pack 1.32.4_1538, released 30 April 2025
{: #1324_1538_M}

The following table shows the changes that are in the master fix pack 1.32.4_1538. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.29.1 | v3.29.2 | See the [Calico release notes](https://docs.tigera.io/calico/3.29/release-notes/#v3.29.2){: external}. |
| Cluster health image | v1.6.7 | v1.6.8 | New version contains updates and security fixes. |
| etcd | v3.5.18 | v3.5.21 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.21){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.32.3-1 | v1.32.3-6 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.5 | v1.1.6 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | cb4f333 | d1545bd | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.11 | v2.10.12 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.31.1 | v0.32.0 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.32.0){: external}. |
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











### Worker node fix pack 1.32.8_1557, released 09 September 2024
{: #cl-boms-1328_1557_W}

The following table shows the components included in the worker node fix pack 1.32.8_1557. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Version | Description |
| ---- | ---- | ---- |
|UBUNTU_24_04|6.8.0-79-generic|Resolves the following CVEs: [CVE-2024-57996](https://nvd.nist.gov/vuln/detail/CVE-2024-57996){: external}, [CVE-2025-21887](https://nvd.nist.gov/vuln/detail/CVE-2025-21887){: external}, [CVE-2025-37752](https://nvd.nist.gov/vuln/detail/CVE-2025-37752){: external}, [CVE-2025-38350](https://nvd.nist.gov/vuln/detail/CVE-2025-38350){: external}, and [CVE-2025-8067](https://nvd.nist.gov/vuln/detail/CVE-2025-8067){: external}.|
|Kubernetes|1.32.8|For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.32.8).|
|containerd|1.7.27|For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.27).|
|HAProxy|e0a48fcf355d98dc769ea048d2fd02044b11ed62|Resolves the following CVEs: [CVE-2025-6020](https://nvd.nist.gov/vuln/detail/CVE-2025-6020){: external}, and [CVE-2025-8941](https://nvd.nist.gov/vuln/detail/CVE-2025-8941){: external}.|
|GPU Device Plug-in and Installer|95e0dbe6a9d2a09a11080e4bf18bc1e33e196ae0|Resolves the following CVEs: [CVE-2025-8941](https://nvd.nist.gov/vuln/detail/CVE-2025-8941){: external}, [CVE-2025-8194](https://nvd.nist.gov/vuln/detail/CVE-2025-8194){: external}, and [CVE-2025-6020](https://nvd.nist.gov/vuln/detail/CVE-2025-6020){: external}.|
{: caption="1.32.8_1557 fix pack." caption-side="bottom"}
{: #cl-boms-1328_1557_W-component-table}
