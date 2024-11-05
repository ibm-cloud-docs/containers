---

copyright: 
  years: 2023, 2024
lastupdated: "2024-11-05"


keywords: kubernetes, containers, change log, 129 change log, 129 updates

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Kubernetes version 1.29 change log
{: #changelog_129}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.29. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_129}

In clusters that run version 1.23 or earlier, the {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. Most new beta features are disabled by default. Kubernetes alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}




## Version 1.29 change log
{: #129_changelog}


Review the version 1.29 change log.
{: shortdesc}


### Change log for worker node fix pack 1.29.9_1564, released 04 November 2024
{: #1299_1564_W}

The following table shows the changes that are in the worker node fix pack 1.29.9_1564. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages	| 5.4.0-198-generic	| 5.4.0-200-generic	| Kernel and package updates for [CVE-2021-47212](https://nvd.nist.gov/vuln/detail/CVE-2021-47212){: external}, [CVE-2022-36402](https://nvd.nist.gov/vuln/detail/CVE-2022-36402){: external}, [CVE-2023-52531](https://nvd.nist.gov/vuln/detail/CVE-2023-52531){: external}, [CVE-2023-52614](https://nvd.nist.gov/vuln/detail/CVE-2023-52614){: external}, [CVE-2024-20696](https://nvd.nist.gov/vuln/detail/CVE-2024-20696){: external}, [CVE-2024-26607](https://nvd.nist.gov/vuln/detail/CVE-2024-26607){: external}, [CVE-2024-26640](https://nvd.nist.gov/vuln/detail/CVE-2024-26640){: external}, [CVE-2024-26641](https://nvd.nist.gov/vuln/detail/CVE-2024-26641){: external}, [CVE-2024-26668](https://nvd.nist.gov/vuln/detail/CVE-2024-26668){: external}, [CVE-2024-26669](https://nvd.nist.gov/vuln/detail/CVE-2024-26669){: external}, [CVE-2024-26800](https://nvd.nist.gov/vuln/detail/CVE-2024-26800){: external}, [CVE-2024-26885](https://nvd.nist.gov/vuln/detail/CVE-2024-26885){: external}, [CVE-2024-26891](https://nvd.nist.gov/vuln/detail/CVE-2024-26891){: external}, [CVE-2024-26960](https://nvd.nist.gov/vuln/detail/CVE-2024-26960){: external}, [CVE-2024-27051](https://nvd.nist.gov/vuln/detail/CVE-2024-27051){: external}, [CVE-2024-27397](https://nvd.nist.gov/vuln/detail/CVE-2024-27397){: external}, [CVE-2024-35848](https://nvd.nist.gov/vuln/detail/CVE-2024-35848){: external}, [CVE-2024-37891](https://nvd.nist.gov/vuln/detail/CVE-2024-37891){: external}, [CVE-2024-38602](https://nvd.nist.gov/vuln/detail/CVE-2024-38602){: external}, [CVE-2024-38611](https://nvd.nist.gov/vuln/detail/CVE-2024-38611){: external}, [CVE-2024-38630](https://nvd.nist.gov/vuln/detail/CVE-2024-38630){: external}, [CVE-2024-40929](https://nvd.nist.gov/vuln/detail/CVE-2024-40929){: external}, [CVE-2024-41071](https://nvd.nist.gov/vuln/detail/CVE-2024-41071){: external}, [CVE-2024-41073](https://nvd.nist.gov/vuln/detail/CVE-2024-41073){: external}, [CVE-2024-42229](https://nvd.nist.gov/vuln/detail/CVE-2024-42229){: external}, [CVE-2024-42244](https://nvd.nist.gov/vuln/detail/CVE-2024-42244){: external}, [CVE-2024-45016](https://nvd.nist.gov/vuln/detail/CVE-2024-45016){: external}	|
| Ubuntu 24.04 Packages	| 6.8.0-47-generic	| 6.8.0-48-generic	| Kernel and package updates for [CVE-2024-20696](https://nvd.nist.gov/vuln/detail/CVE-2024-20696){: external}, [CVE-2024-27022](https://nvd.nist.gov/vuln/detail/CVE-2024-27022){: external}, [CVE-2024-37891](https://nvd.nist.gov/vuln/detail/CVE-2024-37891){: external}, [CVE-2024-41022](https://nvd.nist.gov/vuln/detail/CVE-2024-41022){: external}, [CVE-2024-41311](https://nvd.nist.gov/vuln/detail/CVE-2024-41311){: external}, [CVE-2024-42271](https://nvd.nist.gov/vuln/detail/CVE-2024-42271){: external}, [CVE-2024-42280](https://nvd.nist.gov/vuln/detail/CVE-2024-42280){: external}, [CVE-2024-43858](https://nvd.nist.gov/vuln/detail/CVE-2024-43858){: external}, [CVE-2024-45016](https://nvd.nist.gov/vuln/detail/CVE-2024-45016){: external}	|
| GPU Device Plug-in and Installer	| 68e8137	| 33c70dd	| Driver update and security fixes for [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}	|
{: caption="Changes since version 1.29.9_1562" caption-side="bottom"}


### Change log for master fix pack 1.29.9_1563, released 30 October 2024
{: #1299_1563_M}

The following table shows the changes that are in the master fix pack 1.29.9_1563. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.5.8 | v1.5.9 | New version contains updates and security fixes. |
| etcd | v3.5.15 | v3.5.16 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.16){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.9-1 | v1.29.9-6 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 446 | 447 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 5b17dab | 77dac6b | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.10 | v2.9.12 | New version contains updates and security fixes. |
| Kubernetes add-on resizer | 1.8.19 | 1.8.22 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.22){: external}. |
| Kubernetes Metrics Server | v0.6.4 | v0.7.2 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.2){: external}. |
| Portieris admission controller | v0.13.18 | v0.13.20 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.20){: external}. |
{: caption="Changes since version 1.29.9_1559" caption-side="bottom"}


### Change log for worker node fix pack 1.29.9_1562, released 21 October 2024
{: #1299_1562_W}

The following table shows the changes that are in the worker node fix pack 1.29.9_1562. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | 5.4.0-196-generic | 5.4.0-198-generic | Kernel and package updates for [CVE-2022-36227](https://nvd.nist.gov/vuln/detail/CVE-2022-36227){: external}, [CVE-2024-26960](https://nvd.nist.gov/vuln/detail/CVE-2024-26960){: external}, [CVE-2024-27397](https://nvd.nist.gov/vuln/detail/CVE-2024-27397){: external}, [CVE-2024-38630](https://nvd.nist.gov/vuln/detail/CVE-2024-38630){: external}, [CVE-2024-45016](https://nvd.nist.gov/vuln/detail/CVE-2024-45016){: external}, [CVE-2024-5742](https://nvd.nist.gov/vuln/detail/CVE-2024-5742){: external}. | 
| Containerd | 1.7.22 | 1.7.23 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.23){: external}. |
| Haproxy | 67d03375 | 88598691 | Security fixes for [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}. |
{: caption="Changes since version 1.29.9_1561" caption-side="bottom"}


### Change log for worker node fix pack 1.29.9_1561, released 09 October 2024
{: #1299_1561_W}

The following table shows the changes that are in the worker node fix pack 1.29.9_1561. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | N/A | N/A | Package updates for [CVE-2023-26112](https://nvd.nist.gov/vuln/detail/CVE-2023-26112){: external}, [CVE-2024-43802](https://nvd.nist.gov/vuln/detail/CVE-2024-43802){: external}. |
| Ubuntu 24.04 Packages | N/A |N/A | Package updates for [CVE-2024-43802](https://nvd.nist.gov/vuln/detail/CVE-2024-43802){: external}. |
| Containerd | N/A | N/A | |
| Kubernetes | N/A | N/A | |
| Haproxy | 546887ab | 67d03375 | Security fixes for [CVE-2024-4032](https://nvd.nist.gov/vuln/detail/CVE-2024-4032){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}. |
| GPU Device Plug-in and Installer | a248cf6b | 68e8137 | Driver update and security fixes for [CVE-2024-26880](https://nvd.nist.gov/vuln/detail/CVE-2024-26880){: external}, [CVE-2024-26894](https://nvd.nist.gov/vuln/detail/CVE-2024-26894){: external}, [CVE-2024-39506](https://nvd.nist.gov/vuln/detail/CVE-2024-39506){: external}, [CVE-2024-41040](https://nvd.nist.gov/vuln/detail/CVE-2024-41040){: external}, [CVE-2023-52800](https://nvd.nist.gov/vuln/detail/CVE-2023-52800){: external}, [CVE-2024-40989](https://nvd.nist.gov/vuln/detail/CVE-2024-40989){: external}, [CVE-2024-42090](https://nvd.nist.gov/vuln/detail/CVE-2024-42090){: external}, [CVE-2021-47385](https://nvd.nist.gov/vuln/detail/CVE-2021-47385){: external}, [CVE-2023-52470](https://nvd.nist.gov/vuln/detail/CVE-2023-52470){: external}, [CVE-2023-52683](https://nvd.nist.gov/vuln/detail/CVE-2023-52683){: external}, [CVE-2024-42238](https://nvd.nist.gov/vuln/detail/CVE-2024-42238){: external}, [CVE-2024-42265](https://nvd.nist.gov/vuln/detail/CVE-2024-42265){: external}, [CVE-2021-47384](https://nvd.nist.gov/vuln/detail/CVE-2021-47384){: external}, [CVE-2024-36922](https://nvd.nist.gov/vuln/detail/CVE-2024-36922){: external}, [CVE-2024-42114](https://nvd.nist.gov/vuln/detail/CVE-2024-42114){: external}, [CVE-2024-42228](https://nvd.nist.gov/vuln/detail/CVE-2024-42228){: external}, [CVE-2024-40912](https://nvd.nist.gov/vuln/detail/CVE-2024-40912){: external}, [CVE-2024-40931](https://nvd.nist.gov/vuln/detail/CVE-2024-40931){: external}, [CVE-2024-42124](https://nvd.nist.gov/vuln/detail/CVE-2024-42124){: external}, [CVE-2021-47289](https://nvd.nist.gov/vuln/detail/CVE-2021-47289){: external}, [CVE-2023-52840](https://nvd.nist.gov/vuln/detail/CVE-2023-52840){: external}, [CVE-2024-26595](https://nvd.nist.gov/vuln/detail/CVE-2024-26595){: external}, [CVE-2024-36901](https://nvd.nist.gov/vuln/detail/CVE-2024-36901){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-38558](https://nvd.nist.gov/vuln/detail/CVE-2024-38558){: external}, [CVE-2024-41008](https://nvd.nist.gov/vuln/detail/CVE-2024-41008){: external}, [CVE-2024-41012](https://nvd.nist.gov/vuln/detail/CVE-2024-41012){: external}, [CVE-2024-4032](https://nvd.nist.gov/vuln/detail/CVE-2024-4032){: external}, [CVE-2024-41007](https://nvd.nist.gov/vuln/detail/CVE-2024-41007){: external}, [CVE-2024-41035](https://nvd.nist.gov/vuln/detail/CVE-2024-41035){: external}, [CVE-2021-47527](https://nvd.nist.gov/vuln/detail/CVE-2021-47527){: external}, [CVE-2022-48754](https://nvd.nist.gov/vuln/detail/CVE-2022-48754){: external}, [CVE-2023-6040](https://nvd.nist.gov/vuln/detail/CVE-2023-6040){: external}, [CVE-2024-40978](https://nvd.nist.gov/vuln/detail/CVE-2024-40978){: external}, [CVE-2021-47582](https://nvd.nist.gov/vuln/detail/CVE-2021-47582){: external}, [CVE-2024-38581](https://nvd.nist.gov/vuln/detail/CVE-2024-38581){: external}, [CVE-2024-41090](https://nvd.nist.gov/vuln/detail/CVE-2024-41090){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}, [CVE-2021-47321](https://nvd.nist.gov/vuln/detail/CVE-2021-47321){: external}, [CVE-2024-36920](https://nvd.nist.gov/vuln/detail/CVE-2024-36920){: external}, [CVE-2024-40954](https://nvd.nist.gov/vuln/detail/CVE-2024-40954){: external}, [CVE-2024-40995](https://nvd.nist.gov/vuln/detail/CVE-2024-40995){: external}, [CVE-2024-40998](https://nvd.nist.gov/vuln/detail/CVE-2024-40998){: external}, [CVE-2024-42152](https://nvd.nist.gov/vuln/detail/CVE-2024-42152){: external}, [CVE-2021-46984](https://nvd.nist.gov/vuln/detail/CVE-2021-46984){: external}, [CVE-2023-52817](https://nvd.nist.gov/vuln/detail/CVE-2023-52817){: external}, [CVE-2024-35809](https://nvd.nist.gov/vuln/detail/CVE-2024-35809){: external}, [CVE-2024-35944](https://nvd.nist.gov/vuln/detail/CVE-2024-35944){: external}, [CVE-2024-23848](https://nvd.nist.gov/vuln/detail/CVE-2024-23848){: external}, [CVE-2024-42226](https://nvd.nist.gov/vuln/detail/CVE-2024-42226){: external}, [CVE-2024-42094](https://nvd.nist.gov/vuln/detail/CVE-2024-42094){: external}, [CVE-2021-47101](https://nvd.nist.gov/vuln/detail/CVE-2021-47101){: external}, [CVE-2024-26720](https://nvd.nist.gov/vuln/detail/CVE-2024-26720){: external}, [CVE-2024-26923](https://nvd.nist.gov/vuln/detail/CVE-2024-26923){: external}, [CVE-2024-41005](https://nvd.nist.gov/vuln/detail/CVE-2024-41005){: external}, [CVE-2023-52798](https://nvd.nist.gov/vuln/detail/CVE-2023-52798){: external}, [CVE-2024-42096](https://nvd.nist.gov/vuln/detail/CVE-2024-42096){: external}, [CVE-2024-40988](https://nvd.nist.gov/vuln/detail/CVE-2024-40988){: external}, [CVE-2024-42084](https://nvd.nist.gov/vuln/detail/CVE-2024-42084){: external}, [CVE-2024-42240](https://nvd.nist.gov/vuln/detail/CVE-2024-42240){: external}, [CVE-2024-41014](https://nvd.nist.gov/vuln/detail/CVE-2024-41014){: external}, [CVE-2024-41041](https://nvd.nist.gov/vuln/detail/CVE-2024-41041){: external}, [CVE-2024-41065](https://nvd.nist.gov/vuln/detail/CVE-2024-41065){: external}, [CVE-2024-42322](https://nvd.nist.gov/vuln/detail/CVE-2024-42322){: external}, [CVE-2022-48760](https://nvd.nist.gov/vuln/detail/CVE-2022-48760){: external}, [CVE-2024-26600](https://nvd.nist.gov/vuln/detail/CVE-2024-26600){: external}, [CVE-2024-26939](https://nvd.nist.gov/vuln/detail/CVE-2024-26939){: external}, [CVE-2024-40972](https://nvd.nist.gov/vuln/detail/CVE-2024-40972){: external}, [CVE-2024-40997](https://nvd.nist.gov/vuln/detail/CVE-2024-40997){: external}, [CVE-2024-43830](https://nvd.nist.gov/vuln/detail/CVE-2024-43830){: external}, [CVE-2024-38559](https://nvd.nist.gov/vuln/detail/CVE-2024-38559){: external}, [CVE-2024-38619](https://nvd.nist.gov/vuln/detail/CVE-2024-38619){: external}, [CVE-2024-39501](https://nvd.nist.gov/vuln/detail/CVE-2024-39501){: external}, [CVE-2024-42131](https://nvd.nist.gov/vuln/detail/CVE-2024-42131){: external}, [CVE-2021-47393](https://nvd.nist.gov/vuln/detail/CVE-2021-47393){: external}, [CVE-2022-48836](https://nvd.nist.gov/vuln/detail/CVE-2022-48836){: external}, [CVE-2023-52809](https://nvd.nist.gov/vuln/detail/CVE-2023-52809){: external}, [CVE-2024-26638](https://nvd.nist.gov/vuln/detail/CVE-2024-26638){: external}, [CVE-2021-47609](https://nvd.nist.gov/vuln/detail/CVE-2021-47609){: external}, [CVE-2024-26855](https://nvd.nist.gov/vuln/detail/CVE-2024-26855){: external}, [CVE-2024-36902](https://nvd.nist.gov/vuln/detail/CVE-2024-36902){: external}, [CVE-2021-47287](https://nvd.nist.gov/vuln/detail/CVE-2021-47287){: external}, [CVE-2024-40960](https://nvd.nist.gov/vuln/detail/CVE-2024-40960){: external}, [CVE-2024-41064](https://nvd.nist.gov/vuln/detail/CVE-2024-41064){: external}, [CVE-2024-41071](https://nvd.nist.gov/vuln/detail/CVE-2024-41071){: external}, [CVE-2024-42225](https://nvd.nist.gov/vuln/detail/CVE-2024-42225){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2021-47352](https://nvd.nist.gov/vuln/detail/CVE-2021-47352){: external}, [CVE-2024-26769](https://nvd.nist.gov/vuln/detail/CVE-2024-26769){: external}, [CVE-2024-36939](https://nvd.nist.gov/vuln/detail/CVE-2024-36939){: external}, [CVE-2024-40977](https://nvd.nist.gov/vuln/detail/CVE-2024-40977){: external}, [CVE-2024-42154](https://nvd.nist.gov/vuln/detail/CVE-2024-42154){: external}, [CVE-2024-35989](https://nvd.nist.gov/vuln/detail/CVE-2024-35989){: external}, [CVE-2024-36919](https://nvd.nist.gov/vuln/detail/CVE-2024-36919){: external}, [CVE-2024-38579](https://nvd.nist.gov/vuln/detail/CVE-2024-38579){: external}, [CVE-2024-41076](https://nvd.nist.gov/vuln/detail/CVE-2024-41076){: external}, [CVE-2024-26645](https://nvd.nist.gov/vuln/detail/CVE-2024-26645){: external}, [CVE-2024-40958](https://nvd.nist.gov/vuln/detail/CVE-2024-40958){: external}, [CVE-2024-41023](https://nvd.nist.gov/vuln/detail/CVE-2024-41023){: external}, [CVE-2024-43871](https://nvd.nist.gov/vuln/detail/CVE-2024-43871){: external}, [CVE-2021-47441](https://nvd.nist.gov/vuln/detail/CVE-2021-47441){: external}, [CVE-2022-48804](https://nvd.nist.gov/vuln/detail/CVE-2022-48804){: external}, [CVE-2023-52478](https://nvd.nist.gov/vuln/detail/CVE-2023-52478){: external}, [CVE-2023-52605](https://nvd.nist.gov/vuln/detail/CVE-2023-52605){: external}, [CVE-2024-26665](https://nvd.nist.gov/vuln/detail/CVE-2024-26665){: external}, [CVE-2024-40904](https://nvd.nist.gov/vuln/detail/CVE-2024-40904){: external}, [CVE-2024-40911](https://nvd.nist.gov/vuln/detail/CVE-2024-40911){: external}, [CVE-2024-41044](https://nvd.nist.gov/vuln/detail/CVE-2024-41044){: external}, [CVE-2024-41039](https://nvd.nist.gov/vuln/detail/CVE-2024-41039){: external}, [CVE-2024-41060](https://nvd.nist.gov/vuln/detail/CVE-2024-41060){: external}, [CVE-2024-42246](https://nvd.nist.gov/vuln/detail/CVE-2024-42246){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2021-47338](https://nvd.nist.gov/vuln/detail/CVE-2021-47338){: external}, [CVE-2021-47432](https://nvd.nist.gov/vuln/detail/CVE-2021-47432){: external}, [CVE-2021-47560](https://nvd.nist.gov/vuln/detail/CVE-2021-47560){: external}, [CVE-2024-27042](https://nvd.nist.gov/vuln/detail/CVE-2024-27042){: external}, [CVE-2021-47383](https://nvd.nist.gov/vuln/detail/CVE-2021-47383){: external}, [CVE-2024-36953](https://nvd.nist.gov/vuln/detail/CVE-2024-36953){: external}, [CVE-2024-40959](https://nvd.nist.gov/vuln/detail/CVE-2024-40959){: external}, [CVE-2021-47097](https://nvd.nist.gov/vuln/detail/CVE-2021-47097){: external}, [CVE-2024-26717](https://nvd.nist.gov/vuln/detail/CVE-2024-26717){: external}, [CVE-2024-37356](https://nvd.nist.gov/vuln/detail/CVE-2024-37356){: external}, [CVE-2024-41038](https://nvd.nist.gov/vuln/detail/CVE-2024-41038){: external}, [CVE-2024-39471](https://nvd.nist.gov/vuln/detail/CVE-2024-39471){: external}, [CVE-2021-47497](https://nvd.nist.gov/vuln/detail/CVE-2021-47497){: external}, [CVE-2022-48619](https://nvd.nist.gov/vuln/detail/CVE-2022-48619){: external}, [CVE-2022-48866](https://nvd.nist.gov/vuln/detail/CVE-2022-48866){: external}, [CVE-2023-52476](https://nvd.nist.gov/vuln/detail/CVE-2023-52476){: external}, [CVE-2021-47466](https://nvd.nist.gov/vuln/detail/CVE-2021-47466){: external}, [CVE-2023-52522](https://nvd.nist.gov/vuln/detail/CVE-2023-52522){: external}, [CVE-2024-41097](https://nvd.nist.gov/vuln/detail/CVE-2024-41097){: external}, [CVE-2024-42237](https://nvd.nist.gov/vuln/detail/CVE-2024-42237){: external}, [CVE-2021-47412](https://nvd.nist.gov/vuln/detail/CVE-2021-47412){: external}, [CVE-2024-26649](https://nvd.nist.gov/vuln/detail/CVE-2024-26649){: external}, [CVE-2024-41056](https://nvd.nist.gov/vuln/detail/CVE-2024-41056){: external}, [CVE-2024-41013](https://nvd.nist.gov/vuln/detail/CVE-2024-41013){: external}, [CVE-2024-41055](https://nvd.nist.gov/vuln/detail/CVE-2024-41055){: external}, [CVE-2024-26846](https://nvd.nist.gov/vuln/detail/CVE-2024-26846){: external}, [CVE-2024-35884](https://nvd.nist.gov/vuln/detail/CVE-2024-35884){: external}, [CVE-2024-36883](https://nvd.nist.gov/vuln/detail/CVE-2024-36883){: external}, [CVE-2024-40929](https://nvd.nist.gov/vuln/detail/CVE-2024-40929){: external}, [CVE-2024-40901](https://nvd.nist.gov/vuln/detail/CVE-2024-40901){: external}, [CVE-2024-40941](https://nvd.nist.gov/vuln/detail/CVE-2024-40941){: external}, [CVE-2024-41091](https://nvd.nist.gov/vuln/detail/CVE-2024-41091){: external}, [CVE-2021-47386](https://nvd.nist.gov/vuln/detail/CVE-2021-47386){: external}, [CVE-2024-27013](https://nvd.nist.gov/vuln/detail/CVE-2024-27013){: external}, [CVE-2024-35877](https://nvd.nist.gov/vuln/detail/CVE-2024-35877){: external}, [CVE-2024-39499](https://nvd.nist.gov/vuln/detail/CVE-2024-39499){: external}, [CVE-2021-47455](https://nvd.nist.gov/vuln/detail/CVE-2021-47455){: external}, [CVE-2024-38570](https://nvd.nist.gov/vuln/detail/CVE-2024-38570){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}. |
{: caption="Changes since version 1.29.9_1560" caption-side="bottom"}


### Change log for master fix pack 1.29.9_1559, released 25 September 2024
{: #1299_1559_M}

The following table shows the changes that are in the master fix pack 1.29.9_1559. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.13 | v2.5.15 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.8-1 | v1.29.9-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 445 | 446 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.4 | v1.1.5 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 897f067 | 5b17dab | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.9 | v2.9.10 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.29.2 | v0.29.3 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.29.3){: external}. |
| Kubernetes | v1.29.8 | v1.29.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.9){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 3022 | 3051 | New version contains updates and security fixes. |
{: caption="Changes since version 1.29.8_1556" caption-side="bottom"}


### Change log for worker node fix pack 1.29.9_1560, released 23 September 2024
{: #1299_1560_W}

The following table shows the changes that are in the worker node fix pack 1.29.9_1560. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | 5.4.0-193-generic | 5.4.0-196-generic | Worker node kernel & package updates for [CVE-2016-1585](https://nvd.nist.gov/vuln/detail/CVE-2016-1585){: external}, [CVE-2021-46926](https://nvd.nist.gov/vuln/detail/CVE-2021-46926){: external}, [CVE-2021-47188](https://nvd.nist.gov/vuln/detail/CVE-2021-47188){: external}, [CVE-2022-48791](https://nvd.nist.gov/vuln/detail/CVE-2022-48791){: external}, [CVE-2022-48863](https://nvd.nist.gov/vuln/detail/CVE-2022-48863){: external}, [CVE-2023-27043](https://nvd.nist.gov/vuln/detail/CVE-2023-27043){: external}, [CVE-2023-52629](https://nvd.nist.gov/vuln/detail/CVE-2023-52629){: external}, [CVE-2023-52760](https://nvd.nist.gov/vuln/detail/CVE-2023-52760){: external}, [CVE-2024-2201](https://nvd.nist.gov/vuln/detail/CVE-2024-2201){: external}, [CVE-2024-24860](https://nvd.nist.gov/vuln/detail/CVE-2024-24860){: external}, [CVE-2024-26677](https://nvd.nist.gov/vuln/detail/CVE-2024-26677){: external}, [CVE-2024-26787](https://nvd.nist.gov/vuln/detail/CVE-2024-26787){: external}, [CVE-2024-26830](https://nvd.nist.gov/vuln/detail/CVE-2024-26830){: external}, [CVE-2024-26921](https://nvd.nist.gov/vuln/detail/CVE-2024-26921){: external}, [CVE-2024-26929](https://nvd.nist.gov/vuln/detail/CVE-2024-26929){: external}, [CVE-2024-27012](https://nvd.nist.gov/vuln/detail/CVE-2024-27012){: external}, [CVE-2024-36901](https://nvd.nist.gov/vuln/detail/CVE-2024-36901){: external}, [CVE-2024-38570](https://nvd.nist.gov/vuln/detail/CVE-2024-38570){: external}, [CVE-2024-39484](https://nvd.nist.gov/vuln/detail/CVE-2024-39484){: external}, [CVE-2024-39494](https://nvd.nist.gov/vuln/detail/CVE-2024-39494){: external}, [CVE-2024-42160](https://nvd.nist.gov/vuln/detail/CVE-2024-42160){: external}, [CVE-2024-42228](https://nvd.nist.gov/vuln/detail/CVE-2024-42228){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}, [CVE-2024-6345](https://nvd.nist.gov/vuln/detail/CVE-2024-6345){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-7592](https://nvd.nist.gov/vuln/detail/CVE-2024-7592){: external}, [CVE-2024-8088](https://nvd.nist.gov/vuln/detail/CVE-2024-8088){: external}, [CVE-2024-8096](https://nvd.nist.gov/vuln/detail/CVE-2024-8096){: external}
| Ubuntu 24.04 packages | 6.8.0-41-generic | 6.8.0-45-generic | Worker node package updates for [CVE-2023-27043](https://nvd.nist.gov/vuln/detail/CVE-2023-27043){: external}, [CVE-2024-39292](https://nvd.nist.gov/vuln/detail/CVE-2024-39292){: external}, [CVE-2024-39484](https://nvd.nist.gov/vuln/detail/CVE-2024-39484){: external}, [CVE-2024-41009](https://nvd.nist.gov/vuln/detail/CVE-2024-41009){: external}, [CVE-2024-42154](https://nvd.nist.gov/vuln/detail/CVE-2024-42154){: external}, [CVE-2024-42159](https://nvd.nist.gov/vuln/detail/CVE-2024-42159){: external}, [CVE-2024-42160](https://nvd.nist.gov/vuln/detail/CVE-2024-42160){: external}, [CVE-2024-42224](https://nvd.nist.gov/vuln/detail/CVE-2024-42224){: external}, [CVE-2024-42228](https://nvd.nist.gov/vuln/detail/CVE-2024-42228){: external}, [CVE-2024-45490](https://nvd.nist.gov/vuln/detail/CVE-2024-45490){: external}, [CVE-2024-45491](https://nvd.nist.gov/vuln/detail/CVE-2024-45491){: external}, [CVE-2024-45492](https://nvd.nist.gov/vuln/detail/CVE-2024-45492){: external}, [CVE-2024-6232](https://nvd.nist.gov/vuln/detail/CVE-2024-6232){: external}, [CVE-2024-6345](https://nvd.nist.gov/vuln/detail/CVE-2024-6345){: external}, [CVE-2024-6923](https://nvd.nist.gov/vuln/detail/CVE-2024-6923){: external}, [CVE-2024-7006](https://nvd.nist.gov/vuln/detail/CVE-2024-7006){: external}, [CVE-2024-7592](https://nvd.nist.gov/vuln/detail/CVE-2024-7592){: external}, [CVE-2024-8088](https://nvd.nist.gov/vuln/detail/CVE-2024-8088){: external}, [CVE-2024-8096](https://nvd.nist.gov/vuln/detail/CVE-2024-8096){: external}. |
| Containerd | 1.7.21 | 1.7.22 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.22){: external} and [security bulletin for CVE-2024-45310](https://www.ibm.com/support/pages/node/7172017){: external}. |
| Kubernetes | 1.29.8 | 1.29.9 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.9){: external}. |
| Haproxy | N/A | N/A | N/A |
| GPU Device Plug-in and Installer | 91f881a3 | a248cf6b | Security fixes for [CVE-2024-6119](https://exchange.xforce.ibmcloud.com/vulnerabilities/352483){: external}, [CVE-2024-45490](https://exchange.xforce.ibmcloud.com/vulnerabilities/352411){: external}, [CVE-2024-45491](https://exchange.xforce.ibmcloud.com/vulnerabilities/352412){: external}, [CVE-2024-45492](https://exchange.xforce.ibmcloud.com/vulnerabilities/352413){: external}, [CVE-2024-34397](https://exchange.xforce.ibmcloud.com/vulnerabilities/290032){: external}. |
{: caption="Changes since version 1.29.8_1558" caption-side="bottom"}


### Change log for worker node fix pack 1.29.8_1558, released 10 September 2024
{: #1298_1558_W}

The following table shows the changes that are in the worker node fix pack 1.29.8_1558. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | N/A | N/A | Worker node package updates for [CVE-2016-1585](https://nvd.nist.gov/vuln/detail/CVE-2016-1585){: external}, [CVE-2024-41810](https://nvd.nist.gov/vuln/detail/CVE-2024-41810){: external}, [CVE-2024-41957](https://nvd.nist.gov/vuln/detail/CVE-2024-41957){: external}, [CVE-2024-43374](https://nvd.nist.gov/vuln/detail/CVE-2024-43374){: external}. |
| Ubuntu 24.04 packages | N/A | N/A | Worker node package updates for [CVE-2016-1585](https://nvd.nist.gov/vuln/detail/CVE-2016-1585){: external}, [CVE-2024-41810](https://nvd.nist.gov/vuln/detail/CVE-2024-41810){: external}, [CVE-2024-41957](https://nvd.nist.gov/vuln/detail/CVE-2024-41957){: external}, [CVE-2024-43374](https://nvd.nist.gov/vuln/detail/CVE-2024-43374){: external}. |
| Kubernetes | N/A | N/A | N/A |
| Containerd | 1.7.20 | 1.7.21 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.21){: external}. |
| GPU device plug-in and installer | c2e2956 | 91f881a | Security fixes for [CVE-2019-11236](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2019-11236){: external}, [CVE-2019-20916](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2019-20916){: external}, [CVE-2020-26137](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2020-26137){: external}, [CVE-2021-3572](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-3572){: external}, [CVE-2022-40897](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-40897){: external}, [CVE-2023-32681](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-32681){: external}, [CVE-2023-43804](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-43804){: external}, [CVE-2023-45803](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-45803){: external}, [CVE-2023-5752](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-5752){: external}, [CVE-2024-35195](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-35195){: external}, [CVE-2024-3651](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-3651){: external}, [CVE-2024-37891](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-37891){: external}, [CVE-2024-6345](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-6345){: external}, [CVE-2023-44487](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-44487){: external}, [GO-2023-2153](https://exchange.xforce.ibmcloud.com/vulnerabilities/GO-2023-2153){: external}. |
{: caption="Changes since version 1.29.8_1557" caption-side="bottom"}


### Change log for master fix pack 1.29.8_1556, released 28 August 2024
{: #1298_1556_M}

The following table shows the changes that are in the master fix pack 1.29.8_1556. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.5.7 | v1.5.8 | New version contains updates and security fixes. |
| CoreDNS | 1.11.1 | 1.11.3 | See the [CoreDNS release notes](https://github.com/coredns/coredns/releases/tag/v1.11.3){: external}. |
| etcd | v3.5.14 | v3.5.15 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.15){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.12 | v2.5.13 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.7-1 | v1.29.8-1 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 312030f | 897f067 | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.8 | v2.9.9 | New version contains updates and security fixes. |
| Kubernetes | v1.29.7 | v1.29.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.8){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2967 | 3022 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.17 | v0.13.18 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.18){: external}. |
| Tigera Operator | v1.32.10-109-iks | v1.32.10-124-iks | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.32.10){: external}. |
{: caption="Changes since version 1.29.7_1553" caption-side="bottom"}


### Change log for worker node fix pack 1.29.8_1557, released 26 August 2024
{: #1298_1557_W}

The following table shows the changes that are in the worker node fix pack 1.29.8_1557. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 Packages | 5.4.0-192-generic | 5.4.0-193-generic | Worker node kernel & package updates for [CVE-2021-46926](https://nvd.nist.gov/vuln/detail/CVE-2021-46926){: external}, [CVE-2022-48174](https://nvd.nist.gov/vuln/detail/CVE-2022-48174){: external}, [CVE-2023-52629](https://nvd.nist.gov/vuln/detail/CVE-2023-52629){: external}, [CVE-2023-52760](https://nvd.nist.gov/vuln/detail/CVE-2023-52760){: external}, [CVE-2024-2201](https://nvd.nist.gov/vuln/detail/CVE-2024-2201){: external}, [CVE-2024-24860](https://nvd.nist.gov/vuln/detail/CVE-2024-24860){: external}, [CVE-2024-26830](https://nvd.nist.gov/vuln/detail/CVE-2024-26830){: external}, [CVE-2024-26921](https://nvd.nist.gov/vuln/detail/CVE-2024-26921){: external}, [CVE-2024-26929](https://nvd.nist.gov/vuln/detail/CVE-2024-26929){: external}, [CVE-2024-36901](https://nvd.nist.gov/vuln/detail/CVE-2024-36901){: external}, [CVE-2024-39484](https://nvd.nist.gov/vuln/detail/CVE-2024-39484){: external}, CIS benchmark compliance: [1.1.10](https://workbench.cisecurity.org/sections/1985903/recommendations/3181697){: external}, [5.1.3](https://workbench.cisecurity.org/sections/1985916/recommendations/3181709){: external}. |
| Ubuntu 24.04 Packages | 6.8.0-40-generic | 6.8.0-41-generic | Worker node kernel & package updates for [CVE-2022-48174](https://nvd.nist.gov/vuln/detail/CVE-2022-48174){: external}, [CVE-2022-4968](https://nvd.nist.gov/vuln/detail/CVE-2022-4968){: external}, [CVE-2023-42363](https://nvd.nist.gov/vuln/detail/CVE-2023-42363){: external}, [CVE-2023-42364](https://nvd.nist.gov/vuln/detail/CVE-2023-42364){: external}, [CVE-2023-42365](https://nvd.nist.gov/vuln/detail/CVE-2023-42365){: external}, [CVE-2024-39292](https://nvd.nist.gov/vuln/detail/CVE-2024-39292){: external}, [CVE-2024-39484](https://nvd.nist.gov/vuln/detail/CVE-2024-39484){: external}. | 
| Containerd | N/A | N/A | N/A |
| Kubernetes | 1.29.7 | 1.29.8 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.8){: external}. |
| Haproxy | c91c765 | 546887a | Security fixes for [CVE-2024-2398](https://exchange.xforce.ibmcloud.com/vulnerabilities/286430){: external}, [CVE-2024-37370](https://exchange.xforce.ibmcloud.com/vulnerabilities/296012){: external}, [CVE-2024-37371](https://exchange.xforce.ibmcloud.com/vulnerabilities/296013){: external}, [CVE-2024-6345](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-6345){: external}. |
| GPU Device Plug-in and Installer | 184b5e23 | c2e29569 | Security fixes for [CVE-2024-6345](https://exchange.xforce.ibmcloud.com/vulnerabilities/298014){: external}, [CVE-2024-2398](https://exchange.xforce.ibmcloud.com/vulnerabilities/286430){: external}. |
{: caption="Changes since version 1.29.7_1555" caption-side="bottom"}


### Change log for worker node fix pack 1.29.7_1555, released 12 August 2024
{: #1297_1555_W}

The following table shows the changes that are in the worker node fix pack 1.29.7_1555. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-190-generic | 5.4.0-192-generic | Worker node kernel & package updates for [CVE-2022-48655](https://nvd.nist.gov/vuln/detail/CVE-2022-48655){: external}, [CVE-2022-48674](https://nvd.nist.gov/vuln/detail/CVE-2022-48674){: external}, [CVE-2023-52752](https://nvd.nist.gov/vuln/detail/CVE-2023-52752){: external}, [CVE-2024-0397](https://nvd.nist.gov/vuln/detail/CVE-2024-0397){: external}, [CVE-2024-2511](https://nvd.nist.gov/vuln/detail/CVE-2024-2511){: external}, [CVE-2024-26583](https://nvd.nist.gov/vuln/detail/CVE-2024-26583){: external}, [CVE-2024-26584](https://nvd.nist.gov/vuln/detail/CVE-2024-26584){: external}, [CVE-2024-26585](https://nvd.nist.gov/vuln/detail/CVE-2024-26585){: external}, [CVE-2024-26886](https://nvd.nist.gov/vuln/detail/CVE-2024-26886){: external}, [CVE-2024-26907](https://nvd.nist.gov/vuln/detail/CVE-2024-26907){: external}, [CVE-2024-27019](https://nvd.nist.gov/vuln/detail/CVE-2024-27019){: external}, [CVE-2024-36016](https://nvd.nist.gov/vuln/detail/CVE-2024-36016){: external}, [CVE-2024-37370](https://nvd.nist.gov/vuln/detail/CVE-2024-37370){: external}, [CVE-2024-37371](https://nvd.nist.gov/vuln/detail/CVE-2024-37371){: external}, [CVE-2024-4032](https://nvd.nist.gov/vuln/detail/CVE-2024-4032){: external}, [CVE-2024-4741](https://nvd.nist.gov/vuln/detail/CVE-2024-4741){: external}, [CVE-2024-5535](https://nvd.nist.gov/vuln/detail/CVE-2024-5535){: external}, [CVE-2024-7264](https://nvd.nist.gov/vuln/detail/CVE-2024-7264){: external}. |
| GPU device plug-in and installer | 47ed2ef |4bd77eb| Updates for [CVE-2019-11236](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2019-11236){: external},[CVE-2019-20916](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2019-20916){: external},[CVE-2020-26137](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2020-26137){: external},[CVE-2021-3572](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-3572){: external}, [CVE-2022-40897](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-40897){: external}, [CVE-2023-32681](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-32681){: external}, [CVE-2023-43804](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-43804){: external}, [CVE-2023-45803](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-45803){: external}, [CVE-2024-37891](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-37891){: external}, [CVE-2024-6345](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-6345){: external}, [CVE-2023-52803](https://nvd.nist.gov/vuln/detail/CVE-2023-52803){: external}. |
{: caption="Changes since version 1.29.7_1554" caption-side="bottom"}


### Change log for master fix pack 1.29.7_1553, released 31 July 2024
{: #1297_1553_M}

The following table shows the changes that are in the master fix pack 1.29.7_1553. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.27.2 | v3.27.4 | See the [Calico release notes](https://docs.tigera.io/calico/3.27/release-notes/#v3.27.4){: external}. |
| Cluster health image | v1.4.11 | v1.5.7 | New version contains updates and security fixes. |
| etcd | v3.5.13 | v3.5.14 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.14){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.9 | v2.5.12 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.5-5 | v1.29.7-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 443 | 445 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 14d0ab5 | 312030f | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.7 | v2.9.8 | New version contains updates and security fixes. |
| Kubernetes | v1.29.6 | v1.29.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.7){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2933 | 2967 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.16 | v0.13.17 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.17){: external}. |
| Tigera Operator | v1.32.5-91-iks | v1.32.10-109-iks | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.32.10){: external}. |
{: caption="Changes since version 1.29.6_1545" caption-side="bottom"}


### Change log for worker node fix pack 1.29.7_1554, released 29 July 2024
{: #1297_1554_W}

The following table shows the changes that are in the worker node fix pack 1.29.7_1554. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-189-generic | 5.4.0-190-generic | Worker node kernel & package updates for [CVE-2022-48655](https://nvd.nist.gov/vuln/detail/CVE-2022-48655){: external}, [CVE-2024-0760](https://nvd.nist.gov/vuln/detail/CVE-2024-0760){: external}, [CVE-2024-1737](https://nvd.nist.gov/vuln/detail/CVE-2024-1737){: external}, [CVE-2024-1975](https://nvd.nist.gov/vuln/detail/CVE-2024-1975){: external}, [CVE-2024-26583](https://nvd.nist.gov/vuln/detail/CVE-2024-26583){: external}, [CVE-2024-26584](https://nvd.nist.gov/vuln/detail/CVE-2024-26584){: external}, [CVE-2024-26585](https://nvd.nist.gov/vuln/detail/CVE-2024-26585){: external}, [CVE-2024-26907](https://nvd.nist.gov/vuln/detail/CVE-2024-26907){: external}, [CVE-2024-36016](https://nvd.nist.gov/vuln/detail/CVE-2024-36016){: external}, [CVE-2024-4076](https://nvd.nist.gov/vuln/detail/CVE-2024-4076){: external}, [CVE-2024-5569](https://nvd.nist.gov/vuln/detail/CVE-2024-5569){: external}. |
| Ubuntu 24.04 packages | 6.8.0-38-generic | 6.8.0-39-generic | Worker node kernel & package updates for [CVE-2024-0760](https://nvd.nist.gov/vuln/detail/CVE-2024-0760){: external}, [CVE-2024-1737](https://nvd.nist.gov/vuln/detail/CVE-2024-1737){: external}, [CVE-2024-1975](https://nvd.nist.gov/vuln/detail/CVE-2024-1975){: external}, [CVE-2024-25742](https://nvd.nist.gov/vuln/detail/CVE-2024-25742){: external}, [CVE-2024-35984](https://nvd.nist.gov/vuln/detail/CVE-2024-35984){: external}, [CVE-2024-35990](https://nvd.nist.gov/vuln/detail/CVE-2024-35990){: external}, [CVE-2024-35992](https://nvd.nist.gov/vuln/detail/CVE-2024-35992){: external}, [CVE-2024-35997](https://nvd.nist.gov/vuln/detail/CVE-2024-35997){: external}, [CVE-2024-36008](https://nvd.nist.gov/vuln/detail/CVE-2024-36008){: external}, [CVE-2024-36016](https://nvd.nist.gov/vuln/detail/CVE-2024-36016){: external}, [CVE-2024-4076](https://nvd.nist.gov/vuln/detail/CVE-2024-4076){: external}. |
| Containerd | 1.7.19 | 1.7.20 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.20){: external}. |
| Kubernetes | 1.29.6 | 1.29.7 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.7){: external}. |
| GPU device plug-in and installer | 184b5e2 | 47ed2ef | Security fixes for [CVE-2024-4032](https://nvd.nist.gov/vuln/detail/CVE-2024-4032){: external}. |
| Haproxy | N/A | N/A | N/A |
{: caption="Changes since version 1.29.6_1548" caption-side="bottom"}


### Change log for worker node fix pack 1.29.6_1548, released 15 July 2024
{: #1296_1548_W}

The following table shows the changes that are in the worker node fix pack 1.29.6_1548. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-187-generic | 5.4.0-189-generic | Worker node kernel & package updates for [CVE-2023-6270](https://nvd.nist.gov/vuln/detail/CVE-2023-6270){: external}, [CVE-2023-6597](https://nvd.nist.gov/vuln/detail/CVE-2023-6597){: external}, [CVE-2024-0450](https://nvd.nist.gov/vuln/detail/CVE-2024-0450){: external}, [CVE-2024-2201](https://nvd.nist.gov/vuln/detail/CVE-2024-2201){: external}, [CVE-2024-23307](https://nvd.nist.gov/vuln/detail/CVE-2024-23307){: external}, [CVE-2024-24861](https://nvd.nist.gov/vuln/detail/CVE-2024-24861){: external}, [CVE-2024-26586](https://nvd.nist.gov/vuln/detail/CVE-2024-26586){: external}, [CVE-2024-26642](https://nvd.nist.gov/vuln/detail/CVE-2024-26642){: external}, [CVE-2024-26643](https://nvd.nist.gov/vuln/detail/CVE-2024-26643){: external}, [CVE-2024-26828](https://nvd.nist.gov/vuln/detail/CVE-2024-26828){: external}, [CVE-2024-26889](https://nvd.nist.gov/vuln/detail/CVE-2024-26889){: external}, [CVE-2024-26922](https://nvd.nist.gov/vuln/detail/CVE-2024-26922){: external}, [CVE-2024-26923](https://nvd.nist.gov/vuln/detail/CVE-2024-26923){: external}, [CVE-2024-26925](https://nvd.nist.gov/vuln/detail/CVE-2024-26925){: external}, [CVE-2024-26926](https://nvd.nist.gov/vuln/detail/CVE-2024-26926){: external}. |
| Ubuntu 24.04 packages | 6.8.0-36-generic | 6.8.0-38-generic| Worker node kernel & package updates for [CVE-2024-26922](https://nvd.nist.gov/vuln/detail/CVE-2024-26922){: external}, [CVE-2024-26924](https://nvd.nist.gov/vuln/detail/CVE-2024-26924){: external}, [CVE-2024-26926](https://nvd.nist.gov/vuln/detail/CVE-2024-26926){: external}, [CVE-2024-39894](https://nvd.nist.gov/vuln/detail/CVE-2024-39894){: external}. |
| Containerd | 1.7.18 | 1.7.19 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.19){: external}. |
| HAProxy | e77d4ca | c91c765 | Security fixes for [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external},[CVE-2024-25062](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external}. |
| GPU device plug-in and installer | fbdf629 | 184b5e23 | Security fixes for [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external},[CVE-2021-47069](https://nvd.nist.gov/vuln/detail/CVE-2021-47069){: external},[CVE-2024-26801](https://nvd.nist.gov/vuln/detail/CVE-2024-26801){: external},[CVE-2024-35854](https://nvd.nist.gov/vuln/detail/CVE-2024-35854){: external},[CVE-2024-35960](https://nvd.nist.gov/vuln/detail/CVE-2024-35960){: external},[CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external},[CVE-2024-26584](https://nvd.nist.gov/vuln/detail/CVE-2024-26584){: external},[CVE-2024-26759](https://nvd.nist.gov/vuln/detail/CVE-2024-26759){: external},[CVE-2024-35890](https://nvd.nist.gov/vuln/detail/CVE-2024-35890){: external},[CVE-2024-26982](https://nvd.nist.gov/vuln/detail/CVE-2024-26982){: external},[CVE-2024-35835](https://nvd.nist.gov/vuln/detail/CVE-2024-35835){: external},[CVE-2021-46972](https://nvd.nist.gov/vuln/detail/CVE-2021-46972){: external},[CVE-2021-47353](https://nvd.nist.gov/vuln/detail/CVE-2021-47353){: external},[CVE-2021-47356](https://nvd.nist.gov/vuln/detail/CVE-2021-47356){: external},[CVE-2024-26675](https://nvd.nist.gov/vuln/detail/CVE-2024-26675){: external},[CVE-2021-47236](https://nvd.nist.gov/vuln/detail/CVE-2021-47236){: external},[CVE-2023-52781](https://nvd.nist.gov/vuln/detail/CVE-2023-52781){: external},[CVE-2024-26656](https://nvd.nist.gov/vuln/detail/CVE-2024-26656){: external},[CVE-2021-47311](https://nvd.nist.gov/vuln/detail/CVE-2021-47311){: external},[CVE-2023-52675](https://nvd.nist.gov/vuln/detail/CVE-2023-52675){: external},[CVE-2024-35789](https://nvd.nist.gov/vuln/detail/CVE-2024-35789){: external},[CVE-2024-35958](https://nvd.nist.gov/vuln/detail/CVE-2024-35958){: external},[CVE-2021-47456](https://nvd.nist.gov/vuln/detail/CVE-2021-47456){: external},[CVE-2024-26583](https://nvd.nist.gov/vuln/detail/CVE-2024-26583){: external},[CVE-2024-26974](https://nvd.nist.gov/vuln/detail/CVE-2024-26974){: external},[CVE-2024-36004](https://nvd.nist.gov/vuln/detail/CVE-2024-36004){: external},[CVE-2021-47073](https://nvd.nist.gov/vuln/detail/CVE-2021-47073){: external},[CVE-2023-52464](https://nvd.nist.gov/vuln/detail/CVE-2023-52464){: external},[CVE-2023-52667](https://nvd.nist.gov/vuln/detail/CVE-2023-52667){: external},[CVE-2024-35838](https://nvd.nist.gov/vuln/detail/CVE-2024-35838){: external},[CVE-2024-26906](https://nvd.nist.gov/vuln/detail/CVE-2024-26906){: external},[CVE-2024-27410](https://nvd.nist.gov/vuln/detail/CVE-2024-27410){: external},[CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external},[CVE-2023-52560](https://nvd.nist.gov/vuln/detail/CVE-2023-52560){: external},[CVE-2023-52615](https://nvd.nist.gov/vuln/detail/CVE-2023-52615){: external},[CVE-2023-52686](https://nvd.nist.gov/vuln/detail/CVE-2023-52686){: external},[CVE-2023-52700](https://nvd.nist.gov/vuln/detail/CVE-2023-52700){: external},[CVE-2023-52669](https://nvd.nist.gov/vuln/detail/CVE-2023-52669){: external},[CVE-2024-26804](https://nvd.nist.gov/vuln/detail/CVE-2024-26804){: external},[CVE-2024-26859](https://nvd.nist.gov/vuln/detail/CVE-2024-26859){: external},[CVE-2024-35853](https://nvd.nist.gov/vuln/detail/CVE-2024-35853){: external},[CVE-2024-35852](https://nvd.nist.gov/vuln/detail/CVE-2024-35852){: external},[CVE-2023-52813](https://nvd.nist.gov/vuln/detail/CVE-2023-52813){: external},[CVE-2023-52881](https://nvd.nist.gov/vuln/detail/CVE-2023-52881){: external},[CVE-2024-26735](https://nvd.nist.gov/vuln/detail/CVE-2024-26735){: external},[CVE-2024-26826](https://nvd.nist.gov/vuln/detail/CVE-2024-26826){: external},[CVE-2023-52703](https://nvd.nist.gov/vuln/detail/CVE-2023-52703){: external},[CVE-2024-26907](https://nvd.nist.gov/vuln/detail/CVE-2024-26907){: external},[CVE-2021-46909](https://nvd.nist.gov/vuln/detail/CVE-2021-46909){: external},[CVE-2023-52877](https://nvd.nist.gov/vuln/detail/CVE-2023-52877){: external},[CVE-2024-27397](https://nvd.nist.gov/vuln/detail/CVE-2024-27397){: external},[CVE-2024-3651](https://nvd.nist.gov/vuln/detail/CVE-2024-3651){: external},[CVE-2021-47495](https://nvd.nist.gov/vuln/detail/CVE-2021-47495){: external},[CVE-2023-52626](https://nvd.nist.gov/vuln/detail/CVE-2023-52626){: external},[CVE-2024-35959](https://nvd.nist.gov/vuln/detail/CVE-2024-35959){: external},[CVE-2024-36007](https://nvd.nist.gov/vuln/detail/CVE-2024-36007){: external},[CVE-2024-35845](https://nvd.nist.gov/vuln/detail/CVE-2024-35845){: external},[CVE-2024-35855](https://nvd.nist.gov/vuln/detail/CVE-2024-35855){: external},[CVE-2024-35888](https://nvd.nist.gov/vuln/detail/CVE-2024-35888){: external},[CVE-2021-47310](https://nvd.nist.gov/vuln/detail/CVE-2021-47310){: external},[CVE-2023-52835](https://nvd.nist.gov/vuln/detail/CVE-2023-52835){: external},[CVE-2023-52878](https://nvd.nist.gov/vuln/detail/CVE-2023-52878){: external},[CVE-2024-26585](https://nvd.nist.gov/vuln/detail/CVE-2024-26585){: external},[CVE-2020-26555](https://nvd.nist.gov/vuln/detail/CVE-2020-26555){: external},[CVE-2023-5090](https://nvd.nist.gov/vuln/detail/CVE-2023-5090){: external}. |
{: caption="Changes since version 1.29.6_1547" caption-side="bottom"}


### Change log for worker node fix pack 1.29.6_1547, released 09 July 2024
{: #1296_1547_W}

The following table shows the changes that are in the worker node fix pack 1.29.6_1547. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-186-generic | 5.4.0-187-generic | Worker node kernel & package updates for [CVE-2022-4968](https://nvd.nist.gov/vuln/detail/CVE-2022-4968){: external}, [CVE-2024-2201](https://nvd.nist.gov/vuln/detail/CVE-2024-2201){: external}, [CVE-2024-26643](https://nvd.nist.gov/vuln/detail/CVE-2024-26643){: external}, [CVE-2024-26925](https://nvd.nist.gov/vuln/detail/CVE-2024-26925){: external}, [CVE-2024-32002](https://nvd.nist.gov/vuln/detail/CVE-2024-32002){: external}, [CVE-2024-38428](https://nvd.nist.gov/vuln/detail/CVE-2024-38428){: external}. |
| Ubuntu 24.04 packages | 6.8.0-35-generic | 6.8.0-36-generic | Worker node kernel & package updates for [CVE-2022-4968](https://nvd.nist.gov/vuln/detail/CVE-2022-4968){: external}, [CVE-2024-26924](https://nvd.nist.gov/vuln/detail/CVE-2024-26924){: external}, [CVE-2024-38428](https://nvd.nist.gov/vuln/detail/CVE-2024-38428){: external}, [CVE-2024-6387](https://nvd.nist.gov/vuln/detail/CVE-2024-6387){: external}. |
| HAProxy | 18889dd | e77d4ca | New version contains security fixes |
| GPU device plug-in and installer | 8ef78ef | fbdf629 | New version contains updates and security fixes. |
{: caption="Changes since version 1.29.6_1546" caption-side="bottom"}


### Change log for master fix pack 1.29.6_1545, released 19 June 2024
{: #1296_1545_M}

The following table shows the changes that are in the master fix pack 1.29.6_1545. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.4.10 | v1.4.11 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.5-1 | v1.29.5-5 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.3 | v1.1.4 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4c5d156 | 14d0ab5 | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.6 | v2.9.7 | New version contains updates and security fixes. |
| Kubernetes | v1.29.5 | v1.29.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.6){: external}. |
| Kubernetes NodeLocal DNS cache | 1.23.0 | 1.23.1 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.23.1){: external}. |
| Portieris admission controller | v0.13.15 | v0.13.16 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.16){: external}. |
{: caption="Changes since version 1.29.5_1540" caption-side="bottom"}


### Change log for worker node fix pack 1.29.6_1546, released 18 June 2024
{: #1296_1546_W}

The following table shows the changes that are in the worker node fix pack 1.29.6_1546. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-182-generic | 5.4.0-186-generic | Worker node kernel and package updates [CVE-2021-47063](https://nvd.nist.gov/vuln/detail/CVE-2021-47063){: external}, [CVE-2021-47070](https://nvd.nist.gov/vuln/detail/CVE-2021-47070){: external}, [CVE-2023-47233](https://nvd.nist.gov/vuln/detail/CVE-2023-47233){: external}, [CVE-2023-52530](https://nvd.nist.gov/vuln/detail/CVE-2023-52530){: external}, [CVE-2024-26614](https://nvd.nist.gov/vuln/detail/CVE-2024-26614){: external}, [CVE-2024-26622](https://nvd.nist.gov/vuln/detail/CVE-2024-26622){: external}, [CVE-2024-26712](https://nvd.nist.gov/vuln/detail/CVE-2024-26712){: external}, [CVE-2024-26733](https://nvd.nist.gov/vuln/detail/CVE-2024-26733){: external}, CIS benchmark compliance: [1.5.4](https://workbench.cisecurity.org/sections/1985936/recommendations/3181745){: external}, [1.5.5](https://workbench.cisecurity.org/sections/1985936/recommendations/3181749){: external}, [4.5.5](https://workbench.cisecurity.org/sections/1985957/recommendations/3181909){: external}, [3.3.4](https://workbench.cisecurity.org/sections/1985946/recommendations/3181810){: external}, [3.3.9](https://workbench.cisecurity.org/sections/1985946/recommendations/3181824){: external}, [1.1.1.2](https://workbench.cisecurity.org/sections/1985904/recommendations/3181628){: external}, [1.1.1.3](https://workbench.cisecurity.org/sections/1985904/recommendations/3181629){: external}, [1.1.1.4](https://workbench.cisecurity.org/sections/1985904/recommendations/3181631){: external}, [1.1.1.5](https://workbench.cisecurity.org/sections/1985904/recommendations/3181633){: external}. |
| Ubuntu 24.04 packages | N/A | 6.8.0-35-generic | N/A |
| Kubernetes | 1.29.5 | 1.29.6 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md){: external}. |
| Containerd | 1.7.17 | 1.7.18 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.18){: external}. |
| HAProxy | 0062a3c | 18889dd | Security fixes for [CVE-2024-25062](https://nvd.nist.gov/vuln/detail/CVE-2024-25062){: external}. |
| GPU device plug-in and installer | fdf201e | 8ef78ef | Security fixes for [CVE-2019-25162](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2019-25162){: external}, [CVE-2020-36777](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2020-36777){: external}, [CVE-2021-46934](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-46934){: external}, [CVE-2021-47013](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47013){: external}, [CVE-2021-47055](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47055){: external}, [CVE-2021-47118](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47118){: external}, [CVE-2021-47153](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47153){: external}, [CVE-2021-47171](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47171){: external}, [CVE-2021-47185](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47185){: external}, [CVE-2022-48627](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-48627){: external}, [CVE-2022-48669](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-48669){: external}, [CVE-2023-52439](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52439){: external}, [CVE-2023-52445](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52445){: external}, [CVE-2023-52477](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52477){: external}, [CVE-2023-52513](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52513){: external}, [CVE-2023-52520](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52520){: external}, [CVE-2023-52528](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52528){: external}, [CVE-2023-52565](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52565){: external}, [CVE-2023-52578](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52578){: external}, [CVE-2023-52594](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52594){: external}, [CVE-2023-52595](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52595){: external}, [CVE-2023-52598](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52598){: external}, [CVE-2023-52606](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52606){: external}, [CVE-2023-52607](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52607){: external}, [CVE-2023-52610](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52610){: external}, [CVE-2023-6240](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-6240){: external}, [CVE-2024-0340](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-0340){: external}, [CVE-2024-23307](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-23307){: external}, [CVE-2024-25744](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-25744){: external}, [CVE-2024-26593](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26593){: external}, [CVE-2024-26603](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26603){: external}, [CVE-2024-26610](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26610){: external}, [CVE-2024-26615](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26615){: external}, [CVE-2024-26642](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26642){: external}, [CVE-2024-26643](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26643){: external}, [CVE-2024-26659](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26659){: external}, [CVE-2024-26664](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26664){: external}, [CVE-2024-26693](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26693){: external}, [CVE-2024-26694](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26694){: external}, [CVE-2024-26743](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26743){: external}, [CVE-2024-26744](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26744){: external}, [CVE-2024-26779](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26779){: external}, [CVE-2024-26872](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26872){: external}, [CVE-2024-26892](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26892){: external}, [CVE-2024-26897](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26897){: external}, [CVE-2024-26901](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26901){: external}, [CVE-2024-26919](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26919){: external}, [CVE-2024-26933](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26933){: external}, [CVE-2024-26934](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26934){: external}, [CVE-2024-26964](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26964){: external}, [CVE-2024-26973](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26973){: external}, [CVE-2024-26993](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26993){: external}, [CVE-2024-27014](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27014){: external}, [CVE-2024-27048](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27048){: external}, [CVE-2024-27052](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27052){: external}, [CVE-2024-27056](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27056){: external}, [CVE-2024-27059](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27059){: external}, [CVE-2024-25062](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-25062){: external}. |
{: caption="Changes since version 1.29.5_1541" caption-side="bottom"}


### Change log for worker node fix pack 1.29.5_1541, released 03 June 2024
{: #1295_1541_W}

The following table shows the changes that are in the worker node fix pack 1.29.5_1541. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-182-generic | 5.4.0-182-generic | Worker node package updates [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, [CVE-2024-32004](https://nvd.nist.gov/vuln/detail/CVE-2024-32004){: external}, [CVE-2024-32020](https://nvd.nist.gov/vuln/detail/CVE-2024-32020){: external}, [CVE-2024-32021](https://nvd.nist.gov/vuln/detail/CVE-2024-32021){: external}, [CVE-2024-32465](https://nvd.nist.gov/vuln/detail/CVE-2024-32465){: external}, [CVE-2024-33599](https://nvd.nist.gov/vuln/detail/CVE-2024-33599){: external}, [CVE-2024-33600](https://nvd.nist.gov/vuln/detail/CVE-2024-33600){: external}, [CVE-2024-33601](https://nvd.nist.gov/vuln/detail/CVE-2024-33601){: external}, [CVE-2024-33602](https://nvd.nist.gov/vuln/detail/CVE-2024-33602){: external}, [CVE-2024-34064](https://nvd.nist.gov/vuln/detail/CVE-2024-34064){: external}, [CVE-2024-3651](https://nvd.nist.gov/vuln/detail/CVE-2024-3651){: external}. |
| Kubernetes | 1.29.4 | 1.29.5 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md){: external}. |
| Containerd | 1.7.17 | 1.7.17 | N/A |
| HAProxy | e88695e | 0062a3c | Security fixes for [CVE-2024-0450](https://nvd.nist.gov/vuln/detail/CVE-2024-0450){: external}, [CVE-2024-33599](https://nvd.nist.gov/vuln/detail/CVE-2024-33599){: external}, [CVE-2024-26461](https://nvd.nist.gov/vuln/detail/CVE-2024-26461){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2024-22365](https://nvd.nist.gov/vuln/detail/CVE-2024-22365){: external}, [CVE-2023-6597](https://nvd.nist.gov/vuln/detail/CVE-2023-6597){: external}, [CVE-2024-26458](https://nvd.nist.gov/vuln/detail/CVE-2024-26458){: external}, [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}, [CVE-2024-33601](https://nvd.nist.gov/vuln/detail/CVE-2024-33601){: external}, [CVE-2024-33602](https://nvd.nist.gov/vuln/detail/CVE-2024-33602){: external}, [CVE-2023-7008](https://nvd.nist.gov/vuln/detail/CVE-2023-7008){: external}, [CVE-2023-6004](https://nvd.nist.gov/vuln/detail/CVE-2023-6004){: external}, [CVE-2023-6918](https://nvd.nist.gov/vuln/detail/CVE-2023-6918){: external}, [CVE-2024-33600](https://nvd.nist.gov/vuln/detail/CVE-2024-33600){: external}. |
| GPU device plug-in and installer | 806184d | fdf201e | Security fixes for [CVE-2024-33602](https://nvd.nist.gov/vuln/detail/CVE-2024-33602){: external}, [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external}, [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}, [CVE-2024-33599](https://nvd.nist.gov/vuln/detail/CVE-2024-33599){: external}, [CVE-2024-33600](https://nvd.nist.gov/vuln/detail/CVE-2024-33600){: external}, [CVE-2024-33601](https://nvd.nist.gov/vuln/detail/CVE-2024-33601){: external}. |
{: caption="Changes since version 1.29.4_1538" caption-side="bottom"}


### Change log for master fix pack 1.29.5_1540, released 29 May 2024
{: #1295_1540_M}

The following table shows the changes that are in the master fix pack 1.29.5_1540. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.4.9 | v1.4.10 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.8 | v2.5.9 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.4-1 | v1.29.5-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 442 | 443 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.2 | v1.1.3 | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.5 | v2.9.6 | New version contains updates and security fixes. |
| Konnectivity server and agent | v0.29.0 | v0.29.2_105_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.29.2){: external}. |
| Kubernetes | v1.29.4 | v1.29.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2867 | 2933 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.13 | v0.13.15 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.15){: external}. |
{: caption="Changes since version 1.29.4_1535" caption-side="bottom"}


### Change log for worker node fix pack 1.29.4_1538, released 23 May 2024
{: #1294_1538_W}

The following table shows the changes that are in the worker node fix pack 1.29.4_1538. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-177-generic | 5.4.0-182-generic | Worker node package and kernel updates [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2023-23000](https://nvd.nist.gov/vuln/detail/CVE-2023-23000){: external}, [CVE-2023-23004](https://nvd.nist.gov/vuln/detail/CVE-2023-23004){: external}, [CVE-2023-24023](https://nvd.nist.gov/vuln/detail/CVE-2023-24023){: external}, [CVE-2023-4421](https://nvd.nist.gov/vuln/detail/CVE-2023-4421){: external}, [CVE-2023-46838](https://nvd.nist.gov/vuln/detail/CVE-2023-46838){: external}, [CVE-2023-52600](https://nvd.nist.gov/vuln/detail/CVE-2023-52600){: external}, [CVE-2023-52603](https://nvd.nist.gov/vuln/detail/CVE-2023-52603){: external}, [CVE-2023-5388](https://nvd.nist.gov/vuln/detail/CVE-2023-5388){: external}, [CVE-2023-6135](https://nvd.nist.gov/vuln/detail/CVE-2023-6135){: external}, [CVE-2024-0607](https://nvd.nist.gov/vuln/detail/CVE-2024-0607){: external}, [CVE-2024-1086](https://nvd.nist.gov/vuln/detail/CVE-2024-1086){: external}, [CVE-2024-23851](https://nvd.nist.gov/vuln/detail/CVE-2024-23851){: external}, [CVE-2024-24855](https://nvd.nist.gov/vuln/detail/CVE-2024-24855){: external}, [CVE-2024-26581](https://nvd.nist.gov/vuln/detail/CVE-2024-26581){: external}, [CVE-2024-26589](https://nvd.nist.gov/vuln/detail/CVE-2024-26589){: external}, [CVE-2024-28085](https://nvd.nist.gov/vuln/detail/CVE-2024-28085){: external}, [CVE-2024-28834](https://nvd.nist.gov/vuln/detail/CVE-2024-28834){: external}, [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}, CIS benchmark compliance: [4.5.1.6](https://workbench.cisecurity.org/sections/1985958/recommendations/3181904){: external}, [4.5.1.7](https://workbench.cisecurity.org/sections/1985958/recommendations/3181905){: external}, [4.5.7](https://workbench.cisecurity.org/sections/1985957/recommendations/3181911){: external}. |
| Kubernetes | 1.29.4 | 1.29.4 | N/A |
| Containerd | 1.7.16 | 1.7.17 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.17){: external}. |
| HAProxy | d225100 | 4e826da | [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}, [CVE-2024-28834](https://nvd.nist.gov/vuln/detail/CVE-2024-28834){: external}. |
| GPU device plug-in and installer | 806184d | c0e1605 | Security fixes for [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}. |
{: caption="Changes since version 1.29.4_1537" caption-side="bottom"}


### Change log for worker node fix pack 1.29.4_1537, released 06 May 2024
{: #1294_1537_W}

The following table shows the changes that are in the worker node fix pack 1.29.4_1537. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-177-generic | 5.4.0-177-generic | Worker node package updates for [CVE-2015-1197](https://nvd.nist.gov/vuln/detail/CVE-2015-1197){: external}, [CVE-2023-7207](https://nvd.nist.gov/vuln/detail/CVE-2023-7207){: external}, [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external}, [CVE-2024-32487](https://nvd.nist.gov/vuln/detail/CVE-2024-32487){: external}. CIS benchmark compliance: [1.1.2.1](https://workbench.cisecurity.org/sections/1985909/recommendations/3181638){: external}, [1.1.2.2](https://workbench.cisecurity.org/sections/1985909/recommendations/3181639){: external}, [1.1.2.3](https://workbench.cisecurity.org/sections/1985909/recommendations/3181640){: external}, and [1.1.2.4](https://workbench.cisecurity.org/sections/1985909/recommendations/3181642){: external}.  |
| Kubernetes | 1.29.4 | 1.29.4 | N/A |
| Containerd | 1.7.15 | 1.7.16 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.16){: external}. |
| HAProxy | 295dba8 | 295dba8 | N/A |
| GPU device plug-in and installer | 9fad43c | 806184d | Security fixes for [CVE-2022-48554](https://nvd.nist.gov/vuln/detail/CVE-2022-48554){: external}, [CVE-2023-2975](https://nvd.nist.gov/vuln/detail/CVE-2023-2975){: external}, [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}, [CVE-2023-5678](https://nvd.nist.gov/vuln/detail/CVE-2023-5678){: external}, [CVE-2024-22365](https://nvd.nist.gov/vuln/detail/CVE-2024-22365){: external}, [CVE-2023-7008](https://nvd.nist.gov/vuln/detail/CVE-2023-7008){: external}, [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}, [CVE-2023-6129](https://nvd.nist.gov/vuln/detail/CVE-2023-6129){: external}, [CVE-2023-6237](https://nvd.nist.gov/vuln/detail/CVE-2023-6237){: external}, [CVE-2024-0727](https://nvd.nist.gov/vuln/detail/CVE-2024-0727){: external}. |
{: caption="Changes since version 1.29.4_1536" caption-side="bottom"}


### Change log for master fix pack 1.29.4_1535, released 24 April 2024
{: #1294_1535_M}

The following table shows the changes that are in the master fix pack 1.29.4_1535. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.27.3 | v3.27.2 | See the [Calico release notes](https://docs.tigera.io/calico/3.27/release-notes/#v3.27.2){: external}. |
| Cluster health image | v1.4.8 | v1.4.9 | New version contains updates and security fixes. |
| etcd | v3.5.12 | v3.5.13 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.13){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.3-1 | v1.29.4-1 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.1 | v1.1.2 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | bd30030 | 4c5d156 | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.4 | v2.9.5 | New version contains updates and security fixes. |
| Kubernetes | v1.29.3 | v1.29.4 | Update resolves [CVE-2024-3177](https://nvd.nist.gov/vuln/detail/CVE-2024-3177). For more information, see the [Security Bulletin](https://www.ibm.com/support/pages/node/7148966){: external} and the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2831 | 2867 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.12 | v0.13.13 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.13){: external}. |
| Tigera Operator | v1.32.7-97-iks | v1.32.5-91-iks | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.32.5){: external}. |
{: caption="Changes since version 1.29.3_1531" caption-side="bottom"}


### Change log for worker node fix pack 1.29.4_1536, released 22 April 2024
{: #1294_1536_W}

The following table shows the changes that are in the worker node fix pack 1.29.4_1536. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-174-generic | 5.4.0-177-generic | Worker node and kernel package updates for [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2023-23000](https://nvd.nist.gov/vuln/detail/CVE-2023-23000){: external}, [CVE-2023-23004](https://nvd.nist.gov/vuln/detail/CVE-2023-23004){: external}, [CVE-2023-24023](https://nvd.nist.gov/vuln/detail/CVE-2023-24023){: external}, [CVE-2023-4421](https://nvd.nist.gov/vuln/detail/CVE-2023-4421){: external}, [CVE-2023-46838](https://nvd.nist.gov/vuln/detail/CVE-2023-46838){: external}, [CVE-2023-52600](https://nvd.nist.gov/vuln/detail/CVE-2023-52600){: external}, [CVE-2023-52603](https://nvd.nist.gov/vuln/detail/CVE-2023-52603){: external}, [CVE-2023-5388](https://nvd.nist.gov/vuln/detail/CVE-2023-5388){: external}, [CVE-2023-6135](https://nvd.nist.gov/vuln/detail/CVE-2023-6135){: external}, [CVE-2024-0607](https://nvd.nist.gov/vuln/detail/CVE-2024-0607){: external}, [CVE-2024-1086](https://nvd.nist.gov/vuln/detail/CVE-2024-1086){: external}, [CVE-2024-23851](https://nvd.nist.gov/vuln/detail/CVE-2024-23851){: external}, [CVE-2024-24855](https://nvd.nist.gov/vuln/detail/CVE-2024-24855){: external}, [CVE-2024-26581](https://nvd.nist.gov/vuln/detail/CVE-2024-26581){: external}, [CVE-2024-26589](https://nvd.nist.gov/vuln/detail/CVE-2024-26589){: external}, [CVE-2024-28085](https://nvd.nist.gov/vuln/detail/CVE-2024-28085){: external}, [CVE-2024-28834](https://nvd.nist.gov/vuln/detail/CVE-2024-28834){: external}, [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}. |
| Kubernetes | 1.29.3 | 1.29.4 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md){: external}. |
| Containerd | 1.7.13 | 1.7.15 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.15){: external}. |
| HAProxy | 295dba8 | 4e826da | Security fixes for [CVE-2024-28834](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-28834){: external}. |
| GPU device plug-in and installer | 206b5a6 | 9fad43c1 | Security fixes for [CVE-2024-1488](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-1488){: external}, [CVE-2024-28834](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-28834){: external}, [CVE-2024-28835](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-28835){: external}. |
{: caption="Changes since version 1.29.3_1533" caption-side="bottom"}


### Change log for worker node fix pack 1.29.3_1533, released 8 April 2024
{: #1293_1533_W}

The following table shows the changes that are in the worker node fix pack 1.29.3_1533. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-174-generic | 5.4.0-174-generic | Worker node package updates for [CVE-2024-2398](https://nvd.nist.gov/vuln/detail/CVE-2024-2398){: external}, [CVE-2024-28085](https://nvd.nist.gov/vuln/detail/CVE-2024-28085){: external}. |
| Kubernetes | 1.29.3 | 1.29.3 | N/A |
| Containerd | 1.7.14 | 1.7.13 | Reverted due to a [bug](https://github.com/containerd/containerd/issues/10036){: external}. |
| HAProxy | 512b32a | 295dba8 | Security fixes for [CVE-2023-28322](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-28322){: external}, [CVE-2023-38546](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-38546){: external}, [CVE-2023-46218](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-46218){: external}, [CVE-2023-52425](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52425){: external}
| GPU device plug-in and installer | 5b69345 | 206b5a6 | Security fixes for [CVE-2023-28322](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-28322){: external}, [CVE-2023-38546](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-38546){: external}, [CVE-2023-46218](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-46218){: external}, [CVE-2023-52425](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52425){: external}
{: caption="Changes since version 1.29.3_1532" caption-side="bottom"}


### Change log for master fix pack 1.29.3_1531, released 27 March 2024
{: #1293_1531_M}

The following table shows the changes that are in the master fix pack 1.29.3_1531. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.27.0 | v3.27.2 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#calico-open-source-3272-bug-fix-release){: external}. |
| Cluster health image | v1.4.7 | v1.4.8 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.7 | v2.5.8 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.2-2 | v1.29.3-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 441 | 442 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.0 | v1.1.1 | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.2 | v2.9.4 | New version contains updates and security fixes. |
| Kubernetes | v1.29.2 | v1.29.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.3){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.28 | 1.23.0 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.23.0){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2807 | 2831 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.11 | v0.13.12 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.12){: external}. |
| Tigera Operator | v1.32.4-82-iks | v1.32.5-91-iks | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.32.6){: external}. |
{: caption="Changes since version 1.29.2_1528" caption-side="bottom"}


### Change log for worker node fix pack 1.29.3_1532, released 25 March 2024
{: #1293_1532_W}

The following table shows the changes that are in the worker node fix pack 1.29.3_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-173-generic | 5.4.0-174-generic | Worker node kernel and package updates for [CVE-2012-6655](https://nvd.nist.gov/vuln/detail/CVE-2012-6655){: external}, [CVE-2023-23000](https://nvd.nist.gov/vuln/detail/CVE-2023-23000){: external}, [CVE-2023-23004](https://nvd.nist.gov/vuln/detail/CVE-2023-23004){: external}, [CVE-2024-1086](https://nvd.nist.gov/vuln/detail/CVE-2024-1086){: external}, [CVE-2024-22667](https://nvd.nist.gov/vuln/detail/CVE-2024-22667){: external}, [CVE-2024-24855](https://nvd.nist.gov/vuln/detail/CVE-2024-24855){: external}. |
| Kubernetes | 1.29.2 | 1.29.3 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.3){: external}. |
| Containerd | 1.7.14 | 1.7.14 | N/A |
| HAProxy | 512b32 | 512b32 | N/A |
{: caption="Changes since version 1.29.2_1529" caption-side="bottom"}


### Change log for worker node fix pack 1.29.2_1529, released 13 March 2024
{: #1292_1529_W}

The following table shows the changes that are in the worker node fix pack 1.29.2_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-172-generic | 5.4.0-173-generic | Worker node kernel and package updates for [CVE-2022-47695](https://nvd.nist.gov/vuln/detail/CVE-2022-47695){: external}, [CVE-2022-48063](https://nvd.nist.gov/vuln/detail/CVE-2022-48063){: external}, [CVE-2022-48065](https://nvd.nist.gov/vuln/detail/CVE-2022-48065){: external}, [CVE-2022-48624](https://nvd.nist.gov/vuln/detail/CVE-2022-48624){: external}, [CVE-2023-0340](https://nvd.nist.gov/vuln/detail/CVE-2023-0340){: external}, [CVE-2023-22995](https://nvd.nist.gov/vuln/detail/CVE-2023-22995){: external}, [CVE-2023-50782](https://nvd.nist.gov/vuln/detail/CVE-2023-50782){: external}, [CVE-2023-51779](https://nvd.nist.gov/vuln/detail/CVE-2023-51779){: external}, [CVE-2023-51781](https://nvd.nist.gov/vuln/detail/CVE-2023-51781){: external}, [CVE-2023-51782](https://nvd.nist.gov/vuln/detail/CVE-2023-51782){: external}, [CVE-2023-6915](https://nvd.nist.gov/vuln/detail/CVE-2023-6915){: external}, [CVE-2024-0565](https://nvd.nist.gov/vuln/detail/CVE-2024-0565){: external}, [CVE-2024-0646](https://nvd.nist.gov/vuln/detail/CVE-2024-0646){: external}, [CVE-2024-24806](https://nvd.nist.gov/vuln/detail/CVE-2024-24806){: external}, [CVE-2024-25062](https://nvd.nist.gov/vuln/detail/CVE-2024-25062){: external}. |
| Kubernetes | 1.29.2 | 1.29.2 | N/A |
| GPU device plug-in and installer | 71cb7f | 5b6934 | N/A |
| HAProxy | 9b0400 | 512b32 | N/A |
| Containerd | 1.7.13 | 1.7.14 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.14){: external}. |
{: caption="Changes since version 1.29.2_1530" caption-side="bottom"}


### Change log for master fix pack 1.29.2_1528, released 28 February 2024
{: #1292_1528_M}

The following table shows the changes that are in the master fix pack 1.29.2_1528. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.4.6 | v1.4.7 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.4 | v2.5.7 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.29.1-7 | v1.29.2-2 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 7185ea1 | bd30030 | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.0 | v2.9.2 | New version contains updates and security fixes. |
| Kubernetes | v1.29.1 | v1.29.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.2){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2789 | 2807 | New version contains updates and security fixes. |
| Tigera Operator | v1.32.4-74-iks | v1.32.4-82-iks | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.32.4){: external}. |
{: caption="Changes since version 1.29.1_1524" caption-side="bottom"}


### Change log for worker node fix pack 1.29.2_1529, released 26 February 2024
{: #1292_1529_W_feb}

The following table shows the changes that are in the worker node fix pack 1.29.2_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | N/A| 5.4.0-172-generic | Worker node kernel & package updates for [CVE-2023-4408](https://nvd.nist.gov/vuln/detail/CVE-2023-4408){: external}, [CVE-2023-4641](https://nvd.nist.gov/vuln/detail/CVE-2023-4641){: external}, [CVE-2023-50387](https://nvd.nist.gov/vuln/detail/CVE-2023-50387){: external}, [CVE-2023-50868](https://nvd.nist.gov/vuln/detail/CVE-2023-50868){: external}, [CVE-2023-51781](https://nvd.nist.gov/vuln/detail/CVE-2023-51781){: external}, [CVE-2023-5517](https://nvd.nist.gov/vuln/detail/CVE-2023-5517){: external}, [CVE-2023-6516](https://nvd.nist.gov/vuln/detail/CVE-2023-6516){: external}, [CVE-2023-6915](https://nvd.nist.gov/vuln/detail/CVE-2023-6915){: external}, [CVE-2024-0565](https://nvd.nist.gov/vuln/detail/CVE-2024-0565){: external}, [CVE-2024-0646](https://nvd.nist.gov/vuln/detail/CVE-2024-0646){: external}. |
| GPU device plug-in and installer | d992fea | 71cb7f7 | Security fixes for [CVE-2023-50387](https://nvd.nist.gov/vuln/detail/CVE-2023-50387){: external}, [CVE-2023-50868](https://nvd.nist.gov/vuln/detail/CVE-2023-50868){: external}. |
| Containerd | N/A | 1.7.13 | N/A |
{: caption="Changes since version N/A" caption-side="bottom"}


### Change log for master fix pack 1.29.1_1524 and worker node fix pack 1.29.1_1525, released 14 February 2024
{: #1291_1524M_and_1291_1525W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.26.4 | v3.27.0 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#v3.27.0). |
| Tigera Operator | N/A | v1.32.4-74-iks | **New:** See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.32.4). |
| etcd | v3.5.11 | v3.5.12 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.12). |
| IBM Calico extension | 1525 | N/A | Component has been removed. |
| IBM Cloud Block Storage driver and plug-in | v2.4.14 | v2.5.4 | New version contains updates and security fixes. |
| IBM Cloud Controller Manager | v1.28.6-3 | v1.29.1-7 | New version contains updates and security fixes. |
| IBM Cloud File Storage plug-in and monitor | 439 | 441 | New version contains updates and security fixes. |
| IBM Cloud Metrics Server Config Watcher | 90a78ef | v1.1.0 | New version contains updates and security fixes. |
| Key Management Service provider | v2.8.6 | v2.9.0 | New version contains updates and security fixes. In addition, both [KMS v1 and v2](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) are now supported. KMS v1 instances are migrated to KMS v2 on upgrade and KMS v2 is now the default. |
| Konnectivity agent and server | v0.1.5_47_iks | v0.29.0 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.29.0). |
| Kubernetes | v1.28.6 | v1.29.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.29.1). |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](https://cloud.ibm.com/docs/containers?topic=containers-service-settings). |
| Kubernetes snapshot controller | v6.2.2 | v6.3.0 | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.3.0). |
{: caption="Changes since version 1.28" caption-side="bottom"}
