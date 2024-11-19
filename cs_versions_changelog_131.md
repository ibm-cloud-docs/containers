---

copyright: 
  years: 2024, 2024
lastupdated: "2024-11-19"


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

### Change log for worker node fix pack 1.31.2_1529, released 18 November 2024
{: #1312_1529_W}

The following table shows the changes that are in the worker node fix pack 1.31.2_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | 5.4.0-200-generic | 5.4.0-200-generic | N/A |
| Ubuntu 24.04 Packages | 6.8.0-48-generic | 6.8.0-48-generic | N/A |
| Containerd | 1.7.23 | 1.7.23 | N/A |
| Kubernetes | 1.31.1 | 1.31.2 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.31.2){: external}. |
| HAProxy | 885986 | 55c148 | Security fixes for [CVE-2023-45539](https://nvd.nist.gov/vuln/detail/CVE-2023-45539){: external}, [CVE-2024-3596](https://nvd.nist.gov/vuln/detail/CVE-2024-3596){: external}, [CVE-2019-12900](https://nvd.nist.gov/vuln/detail/CVE-2019-12900){: external}, [CVE-2024-50602](https://nvd.nist.gov/vuln/detail/CVE-2024-50602){: external}. |
| GPU Device Plug-in and Installer | 33c70dd | 96f9b63 | Security fixes for [CVE-2022-48773](https://nvd.nist.gov/vuln/detail/CVE-2022-48773){: external}, [CVE-2022-48936](https://nvd.nist.gov/vuln/detail/CVE-2022-48936){: external}, [CVE-2023-52492](https://nvd.nist.gov/vuln/detail/CVE-2023-52492){: external}, [CVE-2024-24857](https://nvd.nist.gov/vuln/detail/CVE-2024-24857){: external}, [CVE-2024-26851](https://nvd.nist.gov/vuln/detail/CVE-2024-26851){: external}, [CVE-2024-26924](https://nvd.nist.gov/vuln/detail/CVE-2024-26924){: external}, [CVE-2024-26976](https://nvd.nist.gov/vuln/detail/CVE-2024-26976){: external}, [CVE-2024-27017](https://nvd.nist.gov/vuln/detail/CVE-2024-27017){: external}, [CVE-2024-27062](https://nvd.nist.gov/vuln/detail/CVE-2024-27062){: external}, [CVE-2024-35839](https://nvd.nist.gov/vuln/detail/CVE-2024-35839){: external}, [CVE-2024-35898](https://nvd.nist.gov/vuln/detail/CVE-2024-35898){: external}, [CVE-2024-35939](https://nvd.nist.gov/vuln/detail/CVE-2024-35939){: external}, [CVE-2024-38540](https://nvd.nist.gov/vuln/detail/CVE-2024-38540){: external}, [CVE-2024-38541](https://nvd.nist.gov/vuln/detail/CVE-2024-38541){: external}, [CVE-2024-38586](https://nvd.nist.gov/vuln/detail/CVE-2024-38586){: external}, [CVE-2024-38608](https://nvd.nist.gov/vuln/detail/CVE-2024-38608){: external}, [CVE-2024-39503](https://nvd.nist.gov/vuln/detail/CVE-2024-39503){: external}, [CVE-2024-40924](https://nvd.nist.gov/vuln/detail/CVE-2024-40924){: external}, [CVE-2024-40961](https://nvd.nist.gov/vuln/detail/CVE-2024-40961){: external}, [CVE-2024-40983](https://nvd.nist.gov/vuln/detail/CVE-2024-40983){: external}, [CVE-2024-40984](https://nvd.nist.gov/vuln/detail/CVE-2024-40984){: external}, [CVE-2024-41009](https://nvd.nist.gov/vuln/detail/CVE-2024-41009){: external}, [CVE-2024-41042](https://nvd.nist.gov/vuln/detail/CVE-2024-41042){: external}, [CVE-2024-41066](https://nvd.nist.gov/vuln/detail/CVE-2024-41066){: external}, [CVE-2024-41092](https://nvd.nist.gov/vuln/detail/CVE-2024-41092){: external}, [CVE-2024-41093](https://nvd.nist.gov/vuln/detail/CVE-2024-41093){: external}, [CVE-2024-42070](https://nvd.nist.gov/vuln/detail/CVE-2024-42070){: external}, [CVE-2024-42079](https://nvd.nist.gov/vuln/detail/CVE-2024-42079){: external}, [CVE-2024-42244](https://nvd.nist.gov/vuln/detail/CVE-2024-42244){: external}, [CVE-2024-42284](https://nvd.nist.gov/vuln/detail/CVE-2024-42284){: external}, [CVE-2024-42292](https://nvd.nist.gov/vuln/detail/CVE-2024-42292){: external}, [CVE-2024-42301](https://nvd.nist.gov/vuln/detail/CVE-2024-42301){: external}, [CVE-2024-43854](https://nvd.nist.gov/vuln/detail/CVE-2024-43854){: external}, [CVE-2024-43880](https://nvd.nist.gov/vuln/detail/CVE-2024-43880){: external}, [CVE-2024-43889](https://nvd.nist.gov/vuln/detail/CVE-2024-43889){: external}, [CVE-2024-43892](https://nvd.nist.gov/vuln/detail/CVE-2024-43892){: external}, [CVE-2024-44935](https://nvd.nist.gov/vuln/detail/CVE-2024-44935){: external}, [CVE-2024-44989](https://nvd.nist.gov/vuln/detail/CVE-2024-44989){: external}, [CVE-2024-44990](https://nvd.nist.gov/vuln/detail/CVE-2024-44990){: external}, [CVE-2024-45018](https://nvd.nist.gov/vuln/detail/CVE-2024-45018){: external}, [CVE-2024-46826](https://nvd.nist.gov/vuln/detail/CVE-2024-46826){: external}, [CVE-2024-47668](https://nvd.nist.gov/vuln/detail/CVE-2024-47668){: external}, [CVE-2024-3596](https://nvd.nist.gov/vuln/detail/CVE-2024-3596){: external}, [CVE-2019-12900](https://nvd.nist.gov/vuln/detail/CVE-2019-12900){: external}, [CVE-2024-50602](https://nvd.nist.gov/vuln/detail/CVE-2024-50602){: external}. |
{: caption="Changes since version 1.31.1_1527" caption-side="bottom"}


### Change log for master fix pack 1.31.2_1528, released 13 November 2024
{: #1312_1528_M}

The following table shows the changes that are in the master fix pack 1.31.2_1528. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.15 | v2.5.16 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.31.1-6 | v1.31.2-2 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 77dac6b | c4a05b0 | New version contains updates and security fixes. |
| Kubernetes | v1.31.1 | v1.31.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.31.2){: external}. |
{: caption="Changes since version 1.31.1_1526" caption-side="bottom"}


### Change log for worker node fix pack 1.31.1_1527, released 04 November 2024
{: #1311_1527_W}

The following table shows the changes that are in the worker node fix pack 1.31.1_1527. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages	| 5.4.0-198-generic	| 5.4.0-200-generic	| Kernel and package updates for [CVE-2021-47212](https://nvd.nist.gov/vuln/detail/CVE-2021-47212){: external}, [CVE-2022-36402](https://nvd.nist.gov/vuln/detail/CVE-2022-36402){: external}, [CVE-2023-52531](https://nvd.nist.gov/vuln/detail/CVE-2023-52531){: external}, [CVE-2023-52614](https://nvd.nist.gov/vuln/detail/CVE-2023-52614){: external}, [CVE-2024-20696](https://nvd.nist.gov/vuln/detail/CVE-2024-20696){: external}, [CVE-2024-26607](https://nvd.nist.gov/vuln/detail/CVE-2024-26607){: external}, [CVE-2024-26640](https://nvd.nist.gov/vuln/detail/CVE-2024-26640){: external}, [CVE-2024-26641](https://nvd.nist.gov/vuln/detail/CVE-2024-26641){: external}, [CVE-2024-26668](https://nvd.nist.gov/vuln/detail/CVE-2024-26668){: external}, [CVE-2024-26669](https://nvd.nist.gov/vuln/detail/CVE-2024-26669){: external}, [CVE-2024-26800](https://nvd.nist.gov/vuln/detail/CVE-2024-26800){: external}, [CVE-2024-26885](https://nvd.nist.gov/vuln/detail/CVE-2024-26885){: external}, [CVE-2024-26891](https://nvd.nist.gov/vuln/detail/CVE-2024-26891){: external}, [CVE-2024-26960](https://nvd.nist.gov/vuln/detail/CVE-2024-26960){: external}, [CVE-2024-27051](https://nvd.nist.gov/vuln/detail/CVE-2024-27051){: external}, [CVE-2024-27397](https://nvd.nist.gov/vuln/detail/CVE-2024-27397){: external}, [CVE-2024-35848](https://nvd.nist.gov/vuln/detail/CVE-2024-35848){: external}, [CVE-2024-37891](https://nvd.nist.gov/vuln/detail/CVE-2024-37891){: external}, [CVE-2024-38602](https://nvd.nist.gov/vuln/detail/CVE-2024-38602){: external}, [CVE-2024-38611](https://nvd.nist.gov/vuln/detail/CVE-2024-38611){: external}, [CVE-2024-38630](https://nvd.nist.gov/vuln/detail/CVE-2024-38630){: external}, [CVE-2024-40929](https://nvd.nist.gov/vuln/detail/CVE-2024-40929){: external}, [CVE-2024-41071](https://nvd.nist.gov/vuln/detail/CVE-2024-41071){: external}, [CVE-2024-41073](https://nvd.nist.gov/vuln/detail/CVE-2024-41073){: external}, [CVE-2024-42229](https://nvd.nist.gov/vuln/detail/CVE-2024-42229){: external}, [CVE-2024-42244](https://nvd.nist.gov/vuln/detail/CVE-2024-42244){: external}, [CVE-2024-45016](https://nvd.nist.gov/vuln/detail/CVE-2024-45016){: external}	|
| Ubuntu 24.04 Packages	| 6.8.0-47-generic	| 6.8.0-48-generic	| Kernel and package updates for [CVE-2024-20696](https://nvd.nist.gov/vuln/detail/CVE-2024-20696){: external}, [CVE-2024-27022](https://nvd.nist.gov/vuln/detail/CVE-2024-27022){: external}, [CVE-2024-37891](https://nvd.nist.gov/vuln/detail/CVE-2024-37891){: external}, [CVE-2024-41022](https://nvd.nist.gov/vuln/detail/CVE-2024-41022){: external}, [CVE-2024-41311](https://nvd.nist.gov/vuln/detail/CVE-2024-41311){: external}, [CVE-2024-42271](https://nvd.nist.gov/vuln/detail/CVE-2024-42271){: external}, [CVE-2024-42280](https://nvd.nist.gov/vuln/detail/CVE-2024-42280){: external}, [CVE-2024-43858](https://nvd.nist.gov/vuln/detail/CVE-2024-43858){: external}, [CVE-2024-45016](https://nvd.nist.gov/vuln/detail/CVE-2024-45016){: external}	|
| GPU Device Plug-in and Installer	| 68e8137	| 33c70dd	| Driver update and security fixes for [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}	|
{: caption="Changes since version 1.31.1_1524" caption-side="bottom"}


### Change log for master fix pack 1.31.1_1526, released 30 October 2024
{: #1311_1526_M}

The following table shows the changes that are in the master fix pack 1.31.1_1526. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.28.1 | v3.28.2 | See the [Calico release notes](https://docs.tigera.io/calico/3.28/release-notes/#v3.28.2){: external}. |
| Cluster health image | v1.6.2 | v1.6.3 | New version contains updates and security fixes. |
| etcd | v3.5.15 | v3.5.16 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.16){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.31.1-1 | v1.31.1-6 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 446 | 447 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 5b17dab | 77dac6b | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.5 | v2.10.7 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.18 | v0.13.20 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.20){: external}. |
| Tigera Operator | v1.34.3 | v1.34.5 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.34.5){: external}. |
{: caption="Changes since version 1.31.1_1521" caption-side="bottom"}


### Change log for worker node fix pack 1.31.1_1524, released 21 October 2024
{: #1311_1524_W}

The following table shows the changes that are in the worker node fix pack 1.31.1_1524. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | 5.4.0-196-generic | 5.4.0-198-generic | Kernel and package updates for [CVE-2022-36227](https://nvd.nist.gov/vuln/detail/CVE-2022-36227){: external}, [CVE-2024-26960](https://nvd.nist.gov/vuln/detail/CVE-2024-26960){: external}, [CVE-2024-27397](https://nvd.nist.gov/vuln/detail/CVE-2024-27397){: external}, [CVE-2024-38630](https://nvd.nist.gov/vuln/detail/CVE-2024-38630){: external}, [CVE-2024-45016](https://nvd.nist.gov/vuln/detail/CVE-2024-45016){: external}, [CVE-2024-5742](https://nvd.nist.gov/vuln/detail/CVE-2024-5742){: external}. | 
| Haproxy | 67d03375 | 88598691 | Security fixes for [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}. |
{: caption="Changes since version 1.31.1_1523" caption-side="bottom"}


### Change log for worker node fix pack 1.31.1_1523, released 09 October 2024
{: #1311_1523_W}

The following table shows the changes that are in the worker node fix pack 1.31.1_1523. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | N/A | N/A | Package updates for [CVE-2023-26112](https://nvd.nist.gov/vuln/detail/CVE-2023-26112){: external}, [CVE-2024-43802](https://nvd.nist.gov/vuln/detail/CVE-2024-43802){: external}. |
| Ubuntu 24.04 Packages | N/A | N/A | Package updates for [CVE-2024-43802](https://nvd.nist.gov/vuln/detail/CVE-2024-43802){: external}. |
| Haproxy | 546887ab | 67d03375 | Security fixes for [CVE-2024-4032](https://nvd.nist.gov/vuln/detail/CVE-2024-4032){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}. |
| GPU Device Plug-in and Installer | a248cf6b | 68e8137 | Driver update and security fixes for [CVE-2024-26880](https://nvd.nist.gov/vuln/detail/CVE-2024-26880){: external}, [CVE-2024-26894](https://nvd.nist.gov/vuln/detail/CVE-2024-26894){: external}, [CVE-2024-39506](https://nvd.nist.gov/vuln/detail/CVE-2024-39506){: external}, [CVE-2024-41040](https://nvd.nist.gov/vuln/detail/CVE-2024-41040){: external}, [CVE-2023-52800](https://nvd.nist.gov/vuln/detail/CVE-2023-52800){: external}, [CVE-2024-40989](https://nvd.nist.gov/vuln/detail/CVE-2024-40989){: external}, [CVE-2024-42090](https://nvd.nist.gov/vuln/detail/CVE-2024-42090){: external}, [CVE-2021-47385](https://nvd.nist.gov/vuln/detail/CVE-2021-47385){: external}, [CVE-2023-52470](https://nvd.nist.gov/vuln/detail/CVE-2023-52470){: external}, [CVE-2023-52683](https://nvd.nist.gov/vuln/detail/CVE-2023-52683){: external}, [CVE-2024-42238](https://nvd.nist.gov/vuln/detail/CVE-2024-42238){: external}, [CVE-2024-42265](https://nvd.nist.gov/vuln/detail/CVE-2024-42265){: external}, [CVE-2021-47384](https://nvd.nist.gov/vuln/detail/CVE-2021-47384){: external}, [CVE-2024-36922](https://nvd.nist.gov/vuln/detail/CVE-2024-36922){: external}, [CVE-2024-42114](https://nvd.nist.gov/vuln/detail/CVE-2024-42114){: external}, [CVE-2024-42228](https://nvd.nist.gov/vuln/detail/CVE-2024-42228){: external}, [CVE-2024-40912](https://nvd.nist.gov/vuln/detail/CVE-2024-40912){: external}, [CVE-2024-40931](https://nvd.nist.gov/vuln/detail/CVE-2024-40931){: external}, [CVE-2024-42124](https://nvd.nist.gov/vuln/detail/CVE-2024-42124){: external}, [CVE-2021-47289](https://nvd.nist.gov/vuln/detail/CVE-2021-47289){: external}, [CVE-2023-52840](https://nvd.nist.gov/vuln/detail/CVE-2023-52840){: external}, [CVE-2024-26595](https://nvd.nist.gov/vuln/detail/CVE-2024-26595){: external}, [CVE-2024-36901](https://nvd.nist.gov/vuln/detail/CVE-2024-36901){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-38558](https://nvd.nist.gov/vuln/detail/CVE-2024-38558){: external}, [CVE-2024-41008](https://nvd.nist.gov/vuln/detail/CVE-2024-41008){: external}, [CVE-2024-41012](https://nvd.nist.gov/vuln/detail/CVE-2024-41012){: external}, [CVE-2024-4032](https://nvd.nist.gov/vuln/detail/CVE-2024-4032){: external}, [CVE-2024-41007](https://nvd.nist.gov/vuln/detail/CVE-2024-41007){: external}, [CVE-2024-41035](https://nvd.nist.gov/vuln/detail/CVE-2024-41035){: external}, [CVE-2021-47527](https://nvd.nist.gov/vuln/detail/CVE-2021-47527){: external}, [CVE-2022-48754](https://nvd.nist.gov/vuln/detail/CVE-2022-48754){: external}, [CVE-2023-6040](https://nvd.nist.gov/vuln/detail/CVE-2023-6040){: external}, [CVE-2024-40978](https://nvd.nist.gov/vuln/detail/CVE-2024-40978){: external}, [CVE-2021-47582](https://nvd.nist.gov/vuln/detail/CVE-2021-47582){: external}, [CVE-2024-38581](https://nvd.nist.gov/vuln/detail/CVE-2024-38581){: external}, [CVE-2024-41090](https://nvd.nist.gov/vuln/detail/CVE-2024-41090){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}, [CVE-2021-47321](https://nvd.nist.gov/vuln/detail/CVE-2021-47321){: external}, [CVE-2024-36920](https://nvd.nist.gov/vuln/detail/CVE-2024-36920){: external}, [CVE-2024-40954](https://nvd.nist.gov/vuln/detail/CVE-2024-40954){: external}, [CVE-2024-40995](https://nvd.nist.gov/vuln/detail/CVE-2024-40995){: external}, [CVE-2024-40998](https://nvd.nist.gov/vuln/detail/CVE-2024-40998){: external}, [CVE-2024-42152](https://nvd.nist.gov/vuln/detail/CVE-2024-42152){: external}, [CVE-2021-46984](https://nvd.nist.gov/vuln/detail/CVE-2021-46984){: external}, [CVE-2023-52817](https://nvd.nist.gov/vuln/detail/CVE-2023-52817){: external}, [CVE-2024-35809](https://nvd.nist.gov/vuln/detail/CVE-2024-35809){: external}, [CVE-2024-35944](https://nvd.nist.gov/vuln/detail/CVE-2024-35944){: external}, [CVE-2024-23848](https://nvd.nist.gov/vuln/detail/CVE-2024-23848){: external}, [CVE-2024-42226](https://nvd.nist.gov/vuln/detail/CVE-2024-42226){: external}, [CVE-2024-42094](https://nvd.nist.gov/vuln/detail/CVE-2024-42094){: external}, [CVE-2021-47101](https://nvd.nist.gov/vuln/detail/CVE-2021-47101){: external}, [CVE-2024-26720](https://nvd.nist.gov/vuln/detail/CVE-2024-26720){: external}, [CVE-2024-26923](https://nvd.nist.gov/vuln/detail/CVE-2024-26923){: external}, [CVE-2024-41005](https://nvd.nist.gov/vuln/detail/CVE-2024-41005){: external}, [CVE-2023-52798](https://nvd.nist.gov/vuln/detail/CVE-2023-52798){: external}, [CVE-2024-42096](https://nvd.nist.gov/vuln/detail/CVE-2024-42096){: external}, [CVE-2024-40988](https://nvd.nist.gov/vuln/detail/CVE-2024-40988){: external}, [CVE-2024-42084](https://nvd.nist.gov/vuln/detail/CVE-2024-42084){: external}, [CVE-2024-42240](https://nvd.nist.gov/vuln/detail/CVE-2024-42240){: external}, [CVE-2024-41014](https://nvd.nist.gov/vuln/detail/CVE-2024-41014){: external}, [CVE-2024-41041](https://nvd.nist.gov/vuln/detail/CVE-2024-41041){: external}, [CVE-2024-41065](https://nvd.nist.gov/vuln/detail/CVE-2024-41065){: external}, [CVE-2024-42322](https://nvd.nist.gov/vuln/detail/CVE-2024-42322){: external}, [CVE-2022-48760](https://nvd.nist.gov/vuln/detail/CVE-2022-48760){: external}, [CVE-2024-26600](https://nvd.nist.gov/vuln/detail/CVE-2024-26600){: external}, [CVE-2024-26939](https://nvd.nist.gov/vuln/detail/CVE-2024-26939){: external}, [CVE-2024-40972](https://nvd.nist.gov/vuln/detail/CVE-2024-40972){: external}, [CVE-2024-40997](https://nvd.nist.gov/vuln/detail/CVE-2024-40997){: external}, [CVE-2024-43830](https://nvd.nist.gov/vuln/detail/CVE-2024-43830){: external}, [CVE-2024-38559](https://nvd.nist.gov/vuln/detail/CVE-2024-38559){: external}, [CVE-2024-38619](https://nvd.nist.gov/vuln/detail/CVE-2024-38619){: external}, [CVE-2024-39501](https://nvd.nist.gov/vuln/detail/CVE-2024-39501){: external}, [CVE-2024-42131](https://nvd.nist.gov/vuln/detail/CVE-2024-42131){: external}, [CVE-2021-47393](https://nvd.nist.gov/vuln/detail/CVE-2021-47393){: external}, [CVE-2022-48836](https://nvd.nist.gov/vuln/detail/CVE-2022-48836){: external}, [CVE-2023-52809](https://nvd.nist.gov/vuln/detail/CVE-2023-52809){: external}, [CVE-2024-26638](https://nvd.nist.gov/vuln/detail/CVE-2024-26638){: external}, [CVE-2021-47609](https://nvd.nist.gov/vuln/detail/CVE-2021-47609){: external}, [CVE-2024-26855](https://nvd.nist.gov/vuln/detail/CVE-2024-26855){: external}, [CVE-2024-36902](https://nvd.nist.gov/vuln/detail/CVE-2024-36902){: external}, [CVE-2021-47287](https://nvd.nist.gov/vuln/detail/CVE-2021-47287){: external}, [CVE-2024-40960](https://nvd.nist.gov/vuln/detail/CVE-2024-40960){: external}, [CVE-2024-41064](https://nvd.nist.gov/vuln/detail/CVE-2024-41064){: external}, [CVE-2024-41071](https://nvd.nist.gov/vuln/detail/CVE-2024-41071){: external}, [CVE-2024-42225](https://nvd.nist.gov/vuln/detail/CVE-2024-42225){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2021-47352](https://nvd.nist.gov/vuln/detail/CVE-2021-47352){: external}, [CVE-2024-26769](https://nvd.nist.gov/vuln/detail/CVE-2024-26769){: external}, [CVE-2024-36939](https://nvd.nist.gov/vuln/detail/CVE-2024-36939){: external}, [CVE-2024-40977](https://nvd.nist.gov/vuln/detail/CVE-2024-40977){: external}, [CVE-2024-42154](https://nvd.nist.gov/vuln/detail/CVE-2024-42154){: external}, [CVE-2024-35989](https://nvd.nist.gov/vuln/detail/CVE-2024-35989){: external}, [CVE-2024-36919](https://nvd.nist.gov/vuln/detail/CVE-2024-36919){: external}, [CVE-2024-38579](https://nvd.nist.gov/vuln/detail/CVE-2024-38579){: external}, [CVE-2024-41076](https://nvd.nist.gov/vuln/detail/CVE-2024-41076){: external}, [CVE-2024-26645](https://nvd.nist.gov/vuln/detail/CVE-2024-26645){: external}, [CVE-2024-40958](https://nvd.nist.gov/vuln/detail/CVE-2024-40958){: external}, [CVE-2024-41023](https://nvd.nist.gov/vuln/detail/CVE-2024-41023){: external}, [CVE-2024-43871](https://nvd.nist.gov/vuln/detail/CVE-2024-43871){: external}, [CVE-2021-47441](https://nvd.nist.gov/vuln/detail/CVE-2021-47441){: external}, [CVE-2022-48804](https://nvd.nist.gov/vuln/detail/CVE-2022-48804){: external}, [CVE-2023-52478](https://nvd.nist.gov/vuln/detail/CVE-2023-52478){: external}, [CVE-2023-52605](https://nvd.nist.gov/vuln/detail/CVE-2023-52605){: external}, [CVE-2024-26665](https://nvd.nist.gov/vuln/detail/CVE-2024-26665){: external}, [CVE-2024-40904](https://nvd.nist.gov/vuln/detail/CVE-2024-40904){: external}, [CVE-2024-40911](https://nvd.nist.gov/vuln/detail/CVE-2024-40911){: external}, [CVE-2024-41044](https://nvd.nist.gov/vuln/detail/CVE-2024-41044){: external}, [CVE-2024-41039](https://nvd.nist.gov/vuln/detail/CVE-2024-41039){: external}, [CVE-2024-41060](https://nvd.nist.gov/vuln/detail/CVE-2024-41060){: external}, [CVE-2024-42246](https://nvd.nist.gov/vuln/detail/CVE-2024-42246){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2021-47338](https://nvd.nist.gov/vuln/detail/CVE-2021-47338){: external}, [CVE-2021-47432](https://nvd.nist.gov/vuln/detail/CVE-2021-47432){: external}, [CVE-2021-47560](https://nvd.nist.gov/vuln/detail/CVE-2021-47560){: external}, [CVE-2024-27042](https://nvd.nist.gov/vuln/detail/CVE-2024-27042){: external}, [CVE-2021-47383](https://nvd.nist.gov/vuln/detail/CVE-2021-47383){: external}, [CVE-2024-36953](https://nvd.nist.gov/vuln/detail/CVE-2024-36953){: external}, [CVE-2024-40959](https://nvd.nist.gov/vuln/detail/CVE-2024-40959){: external}, [CVE-2021-47097](https://nvd.nist.gov/vuln/detail/CVE-2021-47097){: external}, [CVE-2024-26717](https://nvd.nist.gov/vuln/detail/CVE-2024-26717){: external}, [CVE-2024-37356](https://nvd.nist.gov/vuln/detail/CVE-2024-37356){: external}, [CVE-2024-41038](https://nvd.nist.gov/vuln/detail/CVE-2024-41038){: external}, [CVE-2024-39471](https://nvd.nist.gov/vuln/detail/CVE-2024-39471){: external}, [CVE-2021-47497](https://nvd.nist.gov/vuln/detail/CVE-2021-47497){: external}, [CVE-2022-48619](https://nvd.nist.gov/vuln/detail/CVE-2022-48619){: external}, [CVE-2022-48866](https://nvd.nist.gov/vuln/detail/CVE-2022-48866){: external}, [CVE-2023-52476](https://nvd.nist.gov/vuln/detail/CVE-2023-52476){: external}, [CVE-2021-47466](https://nvd.nist.gov/vuln/detail/CVE-2021-47466){: external}, [CVE-2023-52522](https://nvd.nist.gov/vuln/detail/CVE-2023-52522){: external}, [CVE-2024-41097](https://nvd.nist.gov/vuln/detail/CVE-2024-41097){: external}, [CVE-2024-42237](https://nvd.nist.gov/vuln/detail/CVE-2024-42237){: external}, [CVE-2021-47412](https://nvd.nist.gov/vuln/detail/CVE-2021-47412){: external}, [CVE-2024-26649](https://nvd.nist.gov/vuln/detail/CVE-2024-26649){: external}, [CVE-2024-41056](https://nvd.nist.gov/vuln/detail/CVE-2024-41056){: external}, [CVE-2024-41013](https://nvd.nist.gov/vuln/detail/CVE-2024-41013){: external}, [CVE-2024-41055](https://nvd.nist.gov/vuln/detail/CVE-2024-41055){: external}, [CVE-2024-26846](https://nvd.nist.gov/vuln/detail/CVE-2024-26846){: external}, [CVE-2024-35884](https://nvd.nist.gov/vuln/detail/CVE-2024-35884){: external}, [CVE-2024-36883](https://nvd.nist.gov/vuln/detail/CVE-2024-36883){: external}, [CVE-2024-40929](https://nvd.nist.gov/vuln/detail/CVE-2024-40929){: external}, [CVE-2024-40901](https://nvd.nist.gov/vuln/detail/CVE-2024-40901){: external}, [CVE-2024-40941](https://nvd.nist.gov/vuln/detail/CVE-2024-40941){: external}, [CVE-2024-41091](https://nvd.nist.gov/vuln/detail/CVE-2024-41091){: external}, [CVE-2021-47386](https://nvd.nist.gov/vuln/detail/CVE-2021-47386){: external}, [CVE-2024-27013](https://nvd.nist.gov/vuln/detail/CVE-2024-27013){: external}, [CVE-2024-35877](https://nvd.nist.gov/vuln/detail/CVE-2024-35877){: external}, [CVE-2024-39499](https://nvd.nist.gov/vuln/detail/CVE-2024-39499){: external}, [CVE-2021-47455](https://nvd.nist.gov/vuln/detail/CVE-2021-47455){: external}, [CVE-2024-38570](https://nvd.nist.gov/vuln/detail/CVE-2024-38570){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}. |
{: caption="Changes since version 1.31.1_1522" caption-side="bottom"}


### Change log for master fix pack 1.31.1_1521, released 25 September 2024
{: #1311_1521_M}

The following table shows the changes that are in the master fix pack 1.31.1_1521. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.14 | v2.5.15 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.31.0-3 | v1.31.1-1 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.4 | v2.10.5 | New version contains updates and security fixes. |
| Kubernetes | v1.31.0 | v1.31.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.31.1){: external}. |
{: caption="Changes since version 1.31.0_1520" caption-side="bottom"}


### Change log for worker node fix pack 1.31.1_1522, released 23 September 2024
{: #1311_1522_W}

The following table shows the changes that are in the worker node fix pack 1.31.1_1522. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | 5.4.0-193-generic | 5.4.0-196-generic | Worker node kernel & package updates for [CVE-2016-1585](https://nvd.nist.gov/vuln/detail/CVE-2016-1585){: external}, [CVE-2021-46926](https://nvd.nist.gov/vuln/detail/CVE-2021-46926){: external}, [CVE-2021-47188](https://nvd.nist.gov/vuln/detail/CVE-2021-47188){: external}, [CVE-2022-48791](https://nvd.nist.gov/vuln/detail/CVE-2022-48791){: external}, [CVE-2022-48863](https://nvd.nist.gov/vuln/detail/CVE-2022-48863){: external}, [CVE-2023-27043](https://nvd.nist.gov/vuln/detail/CVE-2023-27043){: external}, [CVE-2023-52629](https://nvd.nist.gov/vuln/detail/CVE-2023-52629){: external}, [CVE-2023-52760](https://nvd.nist.gov/vuln/detail/CVE-2023-52760){: external}, [CVE-2024-2201](https://nvd.nist.gov/vuln/detail/CVE-2024-2201){: external}, [CVE-2024-24860](https://nvd.nist.gov/vuln/detail/CVE-2024-24860){: external}, [CVE-2024-26677](https://nvd.nist.gov/vuln/detail/CVE-2024-26677){: external}, [CVE-2024-26787](https://nvd.nist.gov/vuln/detail/CVE-2024-26787){: external}, [CVE-2024-26830](https://nvd.nist.gov/vuln/detail/CVE-2024-26830){: external}, [CVE-2024-26921](https://nvd.nist.gov/vuln/detail/CVE-2024-26921){: external}, [CVE-2024-26929](https://nvd.nist.gov/vuln/detail/CVE-2024-26929){: external}, [CVE-2024-27012](https://nvd.nist.gov/vuln/detail/CVE-2024-27012){: external}, [CVE-2024-36901](https://nvd.nist.gov/vuln/detail/CVE-2024-36901){: external}, [CVE-2024-38570](https://nvd.nist.gov/vuln/detail/CVE-2024-38570){: external}, [CVE-2024-39484](https://nvd.nist.gov/vuln/detail/CVE-2024-39484){: external}, [CVE-2024-39494](https://nvd.nist.gov/vuln/detail/CVE-2024-39494){: external}, [CVE-2024-42160](https://nvd.nist.gov/vuln/detail/CVE-2024-42160){: external}, [CVE-2024-42228](https://nvd.nist.gov/vuln/detail/CVE-2024-42228){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}, [CVE-2024-6345](https://nvd.nist.gov/vuln/detail/CVE-2024-6345){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-7592](https://nvd.nist.gov/vuln/detail/CVE-2024-7592){: external}, [CVE-2024-8088](https://nvd.nist.gov/vuln/detail/CVE-2024-8088){: external}, [CVE-2024-8096](https://nvd.nist.gov/vuln/detail/CVE-2024-8096){: external}
| Ubuntu 24.04 packages | 6.8.0-41-generic | 6.8.0-45-generic | Worker node package updates for [CVE-2023-27043](https://nvd.nist.gov/vuln/detail/CVE-2023-27043){: external}, [CVE-2024-39292](https://nvd.nist.gov/vuln/detail/CVE-2024-39292){: external}, [CVE-2024-39484](https://nvd.nist.gov/vuln/detail/CVE-2024-39484){: external}, [CVE-2024-41009](https://nvd.nist.gov/vuln/detail/CVE-2024-41009){: external}, [CVE-2024-42154](https://nvd.nist.gov/vuln/detail/CVE-2024-42154){: external}, [CVE-2024-42159](https://nvd.nist.gov/vuln/detail/CVE-2024-42159){: external}, [CVE-2024-42160](https://nvd.nist.gov/vuln/detail/CVE-2024-42160){: external}, [CVE-2024-42224](https://nvd.nist.gov/vuln/detail/CVE-2024-42224){: external}, [CVE-2024-42228](https://nvd.nist.gov/vuln/detail/CVE-2024-42228){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}, [CVE-2024-6345](https://nvd.nist.gov/vuln/detail/CVE-2024-6345){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-7006](https://nvd.nist.gov/vuln/detail/CVE-2024-7006){: external}, [CVE-2024-7592](https://nvd.nist.gov/vuln/detail/CVE-2024-7592){: external}, [CVE-2024-8088](https://nvd.nist.gov/vuln/detail/CVE-2024-8088){: external}, [CVE-2024-8096](https://nvd.nist.gov/vuln/detail/CVE-2024-8096){: external}. |
| Containerd | 1.7.21 | 1.7.22 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.22){: external} and [security bulletin for CVE-2024-45310](https://www.ibm.com/support/pages/node/7172017){: external}. |
| Kubernetes | 1.31.0 | 1.31.1 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.31.1){: external}. |
| Haproxy | N/A | N/A | N/A |
| GPU Device Plug-in and Installer | 91f881a3 | a248cf6b | Security fixes for [CVE-2024-6119](https://exchange.xforce.ibmcloud.com/vulnerabilities/352483){: external}, [CVE-2024-45490](https://exchange.xforce.ibmcloud.com/vulnerabilities/352411){: external}, [CVE-2024-45491](https://exchange.xforce.ibmcloud.com/vulnerabilities/352412){: external}, [CVE-2024-45492](https://exchange.xforce.ibmcloud.com/vulnerabilities/352413){: external}, [CVE-2024-34397](https://exchange.xforce.ibmcloud.com/vulnerabilities/290032){: external}. |
{: caption="Changes since version 1.31.0_1517" caption-side="bottom"}


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
| Kubernetes Metrics Server | v0.7.1 | v0.7.2 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.2){: external}. |
| Kubernetes snapshot controller | v6.3.3 | v8.0.1 | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v8.0.1){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 3022 | 3051 | New version contains updates and security fixes. |
| Pause container image | 3.9 | 3.10 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
| Tigera Operator | v1.32.10-124-iks | v1.34.3 | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.34.3){: external}. |
{: caption="Changes since version 1.30." caption-side="bottom"}
