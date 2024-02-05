---

copyright: 
  years: 2023, 2024
lastupdated: "2024-02-05"


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
{: #128_changelog}


Review the version 1.28 change log.
{: shortdesc}



### Change log for master fix pack 1.28.6_1542, released 31 January 2024
{: #1286_1542_M}

The following table shows the changes that are in the master fix pack 1.28.6_1542. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.26.3 | v3.26.4 | See the [Calico release notes](https://docs.tigera.io/calico/3.26/release-notes/#v3.26.4){: external}. |
| Cluster health image | v1.4.5 | v1.4.6 | New version contains security fixes. |
| etcd | v3.5.10 | v3.5.11 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.11){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1487 | 1525 | New version contains security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.28.4-6 | v1.28.6-3 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | 58e69e0 | 90a78ef | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | e544e35 | 7185ea1 | New version contains updates and security fixes. |
| Key Management Service provider | v2.8.5 | v2.8.6 | New version contains updates and security fixes. |
| Kubernetes | v1.28.4 | v1.28.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.6){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.27 | 1.22.28 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.28){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2767 | 2789 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.10 | v0.13.11 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.11){: external}. |
{: caption="Changes since version 1.28.4_1537" caption-side="bottom"}


### Change log for worker node fix pack 1.28.6_1543, released 29 January 2024
{: #1286_1543_W}

The following table shows the changes that are in the worker node fix pack 1.28.6_1543. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-169-generic | 5.4.0-170-generic | Worker node package and kernel updates for [CVE-2020-28493](https://nvd.nist.gov/vuln/detail/CVE-2020-28493){: external}, [CVE-2022-44840](https://nvd.nist.gov/vuln/detail/CVE-2022-44840){: external}, [CVE-2022-45703](https://nvd.nist.gov/vuln/detail/CVE-2022-45703){: external}, [CVE-2022-47007](https://nvd.nist.gov/vuln/detail/CVE-2022-47007){: external}, [CVE-2022-47008](https://nvd.nist.gov/vuln/detail/CVE-2022-47008){: external}, [CVE-2022-47010](https://nvd.nist.gov/vuln/detail/CVE-2022-47010){: external}, [CVE-2022-47011](https://nvd.nist.gov/vuln/detail/CVE-2022-47011){: external}, [CVE-2023-6004](https://nvd.nist.gov/vuln/detail/CVE-2023-6004){: external}, [CVE-2023-6040](https://nvd.nist.gov/vuln/detail/CVE-2023-6040){: external}, [CVE-2023-6606](https://nvd.nist.gov/vuln/detail/CVE-2023-6606){: external}, [CVE-2023-6918](https://nvd.nist.gov/vuln/detail/CVE-2023-6918){: external}, [CVE-2023-6931](https://nvd.nist.gov/vuln/detail/CVE-2023-6931){: external}, [CVE-2023-6932](https://nvd.nist.gov/vuln/detail/CVE-2023-6932){: external}, [CVE-2024-0553](https://nvd.nist.gov/vuln/detail/CVE-2024-0553){: external}, [CVE-2024-22195](https://nvd.nist.gov/vuln/detail/CVE-2024-22195){: external}, [CVE-2024-22365](https://nvd.nist.gov/vuln/detail/CVE-2024-22365){: external}. |
| Kubernetes | 1.28.4 | 1.28.6 | For more information, see [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.6){: external}. |
| Containerd | 1.7.12 | 1.7.12 | N/A |
| GPU device plug-in and installer | 6273cd0 | 0aa042f | Security fixes for [CVE-2021-44716](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-44716){: external}, [CVE-2022-27664](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-27664){: external}, [CVE-2022-29526](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-29526){: external}, [CVE-2022-32149](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-32149){: external}, [CVE-2022-41717](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-41717){: external}, [CVE-2022-41723](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-41723){: external}, [CVE-2023-39325](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-39325){: external}, [CVE-2023-3978](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-3978){: external}, [CVE-2023-44487](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-44487){: external}. |
| HAProxy | e105dc | a13673 | Security fixes for [CVE-2023-7104](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-7104){: external}, [CVE-2023-27043](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-27043){: external}. |
{: caption="Changes since version 1.28.4_1541" caption-side="bottom"}


### Change log for worker node fix pack 1.28.4_1541, released 16 January 2024
{: #1284_1541_W}

The following table shows the changes that are in the worker node fix pack 1.28.4_1541. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-169-generic | 5.4.0-169-generic | Worker node package updates for [CVE-2021-41617](https://nvd.nist.gov/vuln/detail/CVE-2021-41617){: external}, [CVE-2022-39348](https://nvd.nist.gov/vuln/detail/CVE-2022-39348){: external}, [CVE-2023-46137](https://nvd.nist.gov/vuln/detail/CVE-2023-46137){: external}, [CVE-2023-51385](https://nvd.nist.gov/vuln/detail/CVE-2023-51385){: external}, [CVE-2023-7104](https://nvd.nist.gov/vuln/detail/CVE-2023-7104){: external}. |
| Kubernetes | 1.28.4 | 1.28.4 | N/A |
| Containerd | 1.7.11 | 1.7.12 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.12){: external}. |
| GPU device plug-in and installer | b9c978a | 6273cd0 | New version contains security fixes. |
| Haproxy | 3060b0 | e105dc | [CVE-2023-39615](https://nvd.nist.gov/vuln/detail/CVE-2023-39615){: external}, [CVE-2023-5981](https://nvd.nist.gov/vuln/detail/CVE-2023-5981){: external}, [CVE-2022-48560](https://nvd.nist.gov/vuln/detail/CVE-2022-48560){: external}, [CVE-2022-48564](https://nvd.nist.gov/vuln/detail/CVE-2022-48564){: external}. |
{: caption="Changes since version 1.28.4_1540" caption-side="bottom"}


### Change log for worker node fix pack 1.28.4_1540, released 02 January 2024
{: #1284_1540_W}

The following table shows the changes that are in the worker node fix pack 1.28.4_1540. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-169-generic | 5.4.0-169-generic | Worker node package updates for [CVE-2023-48795](https://nvd.nist.gov/vuln/detail/CVE-2023-48795){: external}. |
| Kubernetes | 1.28.4 | 1.28.4 | N/A |
| Containerd | 1.7.11 | 1.7.11 | N/A |
| GPU device plug-in and installer | 2d51c7a | b9c978a | New version contains security fixes. |
{: caption="Changes since version 1.28.4_1539" caption-side="bottom"}


### Change log for worker node fix pack 1.28.4_1539, released 18 December 2023
{: #1284_1539_W}

The following table shows the changes that are in the worker node fix pack 1.28.4_1539. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-167-generic | 5.4.0-169-generic | Worker node kernel & package updates for [CVE-2020-19726](https://nvd.nist.gov/vuln/detail/CVE-2020-19726){: external}, [CVE-2021-46174](https://nvd.nist.gov/vuln/detail/CVE-2021-46174){: external}, [CVE-2022-1725](https://nvd.nist.gov/vuln/detail/CVE-2022-1725){: external}, [CVE-2022-1771](https://nvd.nist.gov/vuln/detail/CVE-2022-1771){: external}, [CVE-2022-1897](https://nvd.nist.gov/vuln/detail/CVE-2022-1897){: external}, [CVE-2022-2000](https://nvd.nist.gov/vuln/detail/CVE-2022-2000){: external}, [CVE-2022-35205](https://nvd.nist.gov/vuln/detail/CVE-2022-35205){: external}, [CVE-2023-23931](https://nvd.nist.gov/vuln/detail/CVE-2023-23931){: external}, [CVE-2023-31085](https://nvd.nist.gov/vuln/detail/CVE-2023-31085){: external}, [CVE-2023-37453](https://nvd.nist.gov/vuln/detail/CVE-2023-37453){: external}, [CVE-2023-39192](https://nvd.nist.gov/vuln/detail/CVE-2023-39192){: external}, [CVE-2023-39193](https://nvd.nist.gov/vuln/detail/CVE-2023-39193){: external}, [CVE-2023-39804](https://nvd.nist.gov/vuln/detail/CVE-2023-39804){: external}, [CVE-2023-42754](https://nvd.nist.gov/vuln/detail/CVE-2023-42754){: external}, [CVE-2023-45539](https://nvd.nist.gov/vuln/detail/CVE-2023-45539){: external}, [CVE-2023-45871](https://nvd.nist.gov/vuln/detail/CVE-2023-45871){: external}, [CVE-2023-46218](https://nvd.nist.gov/vuln/detail/CVE-2023-46218){: external}, [CVE-2023-46246](https://nvd.nist.gov/vuln/detail/CVE-2023-46246){: external}, [CVE-2023-4806](https://nvd.nist.gov/vuln/detail/CVE-2023-4806){: external}, [CVE-2023-4813](https://nvd.nist.gov/vuln/detail/CVE-2023-4813){: external}, [CVE-2023-48231](https://nvd.nist.gov/vuln/detail/CVE-2023-48231){: external}, [CVE-2023-48233](https://nvd.nist.gov/vuln/detail/CVE-2023-48233){: external}, [CVE-2023-48234](https://nvd.nist.gov/vuln/detail/CVE-2023-48234){: external}, [CVE-2023-48235](https://nvd.nist.gov/vuln/detail/CVE-2023-48235){: external}, [CVE-2023-48236](https://nvd.nist.gov/vuln/detail/CVE-2023-48236){: external}, [CVE-2023-48237](https://nvd.nist.gov/vuln/detail/CVE-2023-48237){: external}, [CVE-2023-5178](https://nvd.nist.gov/vuln/detail/CVE-2023-5178){: external}, [CVE-2023-5717](https://nvd.nist.gov/vuln/detail/CVE-2023-5717){: external}. |
| Kubernetes | N/A |N/A|N/A|
| Containerd | 1.7.10 |1.7.11| For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.11){: external}. |
{: caption="Changes since version 1.28.4_1538" caption-side="bottom"}


### Change log for master fix pack 1.28.4_1537, released 06 December 2023
{: #1284_1537_M}

The following table shows the changes that are in the master fix pack 1.28.4_1537. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| GPU device plug-in and installer | 99267c4 | 0e3950c | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.12 | v2.4.14 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.28.3-5 | v1.28.4-6 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 438 | 439 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | c33e6e7 | 58e69e0 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.1.5_39_iks | v0.1.5_47_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.5){: external}. |
| Kubernetes | v1.28.3 | v1.28.4 | Review the [community Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.4){: external}. Resolves [CVE-2023-39325](https://nvd.nist.gov/vuln/detail/CVE-2023-39325){: external} and [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}. For more information, see [Security Bulletin: IBM Cloud Kubernetes Service is affected by Kubernetes API server security vulnerabilities (CVE-2023-39325 and CVE-2023-44487)](https://www.ibm.com/support/pages/node/7091444){: external}. |
| Load balancer and Load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2731 | 2767 | New version contains updates and security fixes. |
| Kubernetes NodeLocal DNS cache | 1.22.24 | 1.22.27 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.27){: external}. |
{: caption="Changes since version 1.28.3_1534" caption-side="bottom"}


### Change log for worker node fix pack 1.28.4_1538, released 04 December 2023
{: #1284_1538_W}

The following table shows the changes that are in the worker node fix pack 1.28.4_1538. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-166-generic | 5.4.0-167-generic | Worker node kernel & package updates for [CVE-2023-31085](https://nvd.nist.gov/vuln/detail/CVE-2023-31085){: external}, [CVE-2023-40217](https://nvd.nist.gov/vuln/detail/CVE-2023-40217){: external}, [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487){: external}, [CVE-2023-45871](https://nvd.nist.gov/vuln/detail/CVE-2023-45871){: external}, [CVE-2023-47038](https://nvd.nist.gov/vuln/detail/CVE-2023-47038){: external}, [CVE-2023-5981](https://nvd.nist.gov/vuln/detail/CVE-2023-5981){: external}. |
| Kubernetes | 1.28.3 | 1.28.4 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.4){: external}. |
| Containerd | 1.7.9 | 1.7.10 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.10){: external}. |
| GPU device plug-in and installer | 0e3950c | 2d51c7a | New version contains updates and security fixes. Driver version upgraded from [535.54.03](http://docs.nvidia.com/datacenter/tesla/tesla-release-notes-535-54-03/index.html){: external} to [535.129.03](https://docs.nvidia.com/datacenter/tesla/tesla-release-notes-535-129-03/index.html){: external}. |
{: caption="Changes since version 1.28.3_1535" caption-side="bottom"}


### Change log for worker node fix pack 1.28.3_1535, released 29 November 2023
{: #1283_1535_W}

The following table shows the changes that are in the worker node fix pack 1.28.3_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-166-generic | 5.4.0-166-generic | Worker node package updates for [CVE-2023-36054](https://nvd.nist.gov/vuln/detail/CVE-2023-36054){: external}, [CVE-2023-4016](https://nvd.nist.gov/vuln/detail/CVE-2023-4016){: external}, [CVE-2023-43804](https://nvd.nist.gov/vuln/detail/CVE-2023-43804){: external}, [CVE-2023-45803](https://nvd.nist.gov/vuln/detail/CVE-2023-45803){: external}. |
| GPU device plug-in and installer | 99267c4 | 0e3950c | New version contains updates and security fixes. |
| Kubernetes | 1.28.2 | 1.28.3 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.3){: external}. |
| Containerd| 1.7.8 | 1.7.9 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.9){: external}. |
{: caption="Changes since version 1.28.2_1533" caption-side="bottom"}


### Change log for master fix pack 1.28.3_1534, released 15 November 2023
{: #1283_1534_M}

The following table shows the changes that are in the master fix pack 1.28.3_1534. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.4.4 | v1.4.5 | New version contains updates and security fixes. |
| etcd | v3.5.9 | v3.5.10 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.10){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.28.2-10 | v1.28.3-5 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 435 | 438 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | a1edf56 | c33e6e7 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | f0d3265 | e544e35 | New version contains updates and security fixes. |
| Key Management Service provider | v2.8.4 | v2.8.5 | New version contains updates and security fixes. |
| Kubernetes | v1.28.2 | v1.28.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.3){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2681 | 2731 | New version contains updates and security fixes. |
| Konnectivity agent and server | v0.1.3_5_iks | v0.1.5_39_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.5){: external}. |
| Portieris admission controller | v0.13.8 | v0.13.10 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.10){: external}. |
{: caption="Changes since version 1.28.2_1531" caption-side="bottom"}


### Change log for worker node fix pack 1.28.2_1533, released 08 November 2023
{: #1282_1533_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1533. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|Ubuntu 20.04 packages | 5.4.0-165-generic | 5.4.0-166-generic | Worker node kernel & package updates for [CVE-2023-0597](https://nvd.nist.gov/vuln/detail/CVE-2023-0597){: external}, [CVE-2023-31083](https://nvd.nist.gov/vuln/detail/CVE-2023-31083){: external}, [CVE-2023-34058](https://nvd.nist.gov/vuln/detail/CVE-2023-34058){: external}, [CVE-2023-34059](https://nvd.nist.gov/vuln/detail/CVE-2023-34059){: external}, [CVE-2023-34319](https://nvd.nist.gov/vuln/detail/CVE-2023-34319){: external}, [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}, [CVE-2023-3772](https://nvd.nist.gov/vuln/detail/CVE-2023-3772){: external}, [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}, [CVE-2023-4132](https://nvd.nist.gov/vuln/detail/CVE-2023-4132){: external}, [CVE-2023-42752](https://nvd.nist.gov/vuln/detail/CVE-2023-42752){: external}, [CVE-2023-42753](https://nvd.nist.gov/vuln/detail/CVE-2023-42753){: external}, [CVE-2023-42755](https://nvd.nist.gov/vuln/detail/CVE-2023-42755){: external}, [CVE-2023-42756](https://nvd.nist.gov/vuln/detail/CVE-2023-42756){: external}, [CVE-2023-4622](https://nvd.nist.gov/vuln/detail/CVE-2023-4622){: external}, [CVE-2023-4623](https://nvd.nist.gov/vuln/detail/CVE-2023-4623){: external}, [CVE-2023-4733](https://nvd.nist.gov/vuln/detail/CVE-2023-4733){: external}, [CVE-2023-4735](https://nvd.nist.gov/vuln/detail/CVE-2023-4735){: external}, [CVE-2023-4750](https://nvd.nist.gov/vuln/detail/CVE-2023-4750){: external}, [CVE-2023-4751](https://nvd.nist.gov/vuln/detail/CVE-2023-4751){: external}, [CVE-2023-4752](https://nvd.nist.gov/vuln/detail/CVE-2023-4752){: external}, [CVE-2023-4781](https://nvd.nist.gov/vuln/detail/CVE-2023-4781){: external}, [CVE-2023-4881](https://nvd.nist.gov/vuln/detail/CVE-2023-4881){: external}, [CVE-2023-4921](https://nvd.nist.gov/vuln/detail/CVE-2023-4921){: external}, [CVE-2023-5344](https://nvd.nist.gov/vuln/detail/CVE-2023-5344){: external}, [CVE-2023-5441](https://nvd.nist.gov/vuln/detail/CVE-2023-5441){: external}, [CVE-2023-5535](https://nvd.nist.gov/vuln/detail/CVE-2023-5535){: external}. |
| GPU device plug-in and installer | 4319682 | 99267c4 | New version contains updates and security fixes. |
| Containerd | 1.7.7 | 1.7.8 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.8){: external}. |
{: caption="Changes since version 1.28.2_1532" caption-side="bottom"}


### Change log for master fix pack 1.28.2_1531, released 25 October 2023
{: #1282_1531_M}

The following table shows the changes that are in the master fix pack 1.28.2_1531. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.26.1 | v3.26.3 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#v3.26.3){: external}. |
| Cluster health image | v1.4.2 | v1.4.4 | New version contains updates and security fixes. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1390 | 1487 | New version contains security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.10 | v2.4.12 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.28.1-3 | v1.28.2-10 | New version contains updates and security fixes. The logic for the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-idle-connection-timeout` annotation has changed. The default idle timeout is dependent on your account settings. Usually, this value is `50`. However, some allowlisted accounts have larger timeout settings. If you don't set the annotation, your load balancers use the timeout setting in your account. You can explicitly specify the timeout by setting this annotation. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4e2f346 | f0d3265 | New version contains updates and security fixes. |
| Key Management Service provider | v2.8.2 | v2.8.4 | New version contains updates and security fixes. |
| Kubernetes NodeLocal DNS cache | 1.22.23 | 1.22.24 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.24){: external}. |
| Portieris admission controller | v0.13.6 | v0.13.8 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.8){: external}. |
{: caption="Changes since version 1.28.2_1527" caption-side="bottom"}


### Change log for worker node fix pack 1.28.2_1532, released 23 October 2023
{: #1282_1532_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-164-generic | 5.4.0-165-generic | Worker node kernel & package updates for [CVE-2022-3234](https://nvd.nist.gov/vuln/detail/CVE-2022-3234){: external}, [CVE-2022-3256](https://nvd.nist.gov/vuln/detail/CVE-2022-3256){: external}, [CVE-2022-3324](https://nvd.nist.gov/vuln/detail/CVE-2022-3324){: external}, [CVE-2022-3352](https://nvd.nist.gov/vuln/detail/CVE-2022-3352){: external}, [CVE-2022-3520](https://nvd.nist.gov/vuln/detail/CVE-2022-3520){: external}, [CVE-2022-3591](https://nvd.nist.gov/vuln/detail/CVE-2022-3591){: external}, [CVE-2022-3705](https://nvd.nist.gov/vuln/detail/CVE-2022-3705){: external}, [CVE-2022-4292](https://nvd.nist.gov/vuln/detail/CVE-2022-4292){: external}, [CVE-2022-4293](https://nvd.nist.gov/vuln/detail/CVE-2022-4293){: external}, [CVE-2023-34319](https://nvd.nist.gov/vuln/detail/CVE-2023-34319){: external}, [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}, [CVE-2023-42752](https://nvd.nist.gov/vuln/detail/CVE-2023-42752){: external}, [CVE-2023-42753](https://nvd.nist.gov/vuln/detail/CVE-2023-42753){: external}, [CVE-2023-42755](https://nvd.nist.gov/vuln/detail/CVE-2023-42755){: external}, [CVE-2023-42756](https://nvd.nist.gov/vuln/detail/CVE-2023-42756){: external}, [CVE-2023-4622](https://nvd.nist.gov/vuln/detail/CVE-2023-4622){: external}, [CVE-2023-4623](https://nvd.nist.gov/vuln/detail/CVE-2023-4623){: external}, [CVE-2023-4881](https://nvd.nist.gov/vuln/detail/CVE-2023-4881){: external}, [CVE-2023-4921](https://nvd.nist.gov/vuln/detail/CVE-2023-4921){: external}. |
|Ubuntu 18.04 packages (`s390x`)|4.15.0-218-generic|4.15.0-218-generic|Worker node kernel & package updates for [CVE-2020-19189](https://nvd.nist.gov/vuln/detail/CVE-2020-19189){: external}, [CVE-2023-4733](https://nvd.nist.gov/vuln/detail/CVE-2023-4733){: external}, [CVE-2023-4735](https://nvd.nist.gov/vuln/detail/CVE-2023-4735){: external}, [CVE-2023-4750](https://nvd.nist.gov/vuln/detail/CVE-2023-4750){: external}, [CVE-2023-4751](https://nvd.nist.gov/vuln/detail/CVE-2023-4751){: external}, [CVE-2023-5344](https://nvd.nist.gov/vuln/detail/CVE-2023-5344){: external}, [CVE-2023-5441](https://nvd.nist.gov/vuln/detail/CVE-2023-5441){: external}. |
|Ubuntu 20.04 packages (`s390x`)|5.4.0-164-generic|5.4.0-165-generic|Worker node kernel & package updates for [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}, [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}, [CVE-2023-4733](https://nvd.nist.gov/vuln/detail/CVE-2023-4733){: external}, [CVE-2023-4735](https://nvd.nist.gov/vuln/detail/CVE-2023-4735){: external}, [CVE-2023-4750](https://nvd.nist.gov/vuln/detail/CVE-2023-4750){: external}, [CVE-2023-4751](https://nvd.nist.gov/vuln/detail/CVE-2023-4751){: external}, [CVE-2023-4752](https://nvd.nist.gov/vuln/detail/CVE-2023-4752){: external}, [CVE-2023-4781](https://nvd.nist.gov/vuln/detail/CVE-2023-4781){: external}, [CVE-2023-5344](https://nvd.nist.gov/vuln/detail/CVE-2023-5344){: external}, [CVE-2023-5441](https://nvd.nist.gov/vuln/detail/CVE-2023-5441){: external}, [CVE-2023-5535](https://nvd.nist.gov/vuln/detail/CVE-2023-5535){: external}. |
| Kubernetes |N/A|N/A|N/A|
| Containerd | 1.7.6 | 1.7.7 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.7){: external}. |
{: caption="Changes since version 1.28.2_1529" caption-side="bottom"}


### Change log for worker node fix pack 1.28.2_1529, released 9 October 2023
{: #1282_1529_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-163-generic | 5.4.0-164-generic | Worker node kernel & package updates for [CVE-2021-4001](https://nvd.nist.gov/vuln/detail/CVE-2021-4001){: external}, [CVE-2023-1206](https://nvd.nist.gov/vuln/detail/CVE-2023-1206){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-3212](https://nvd.nist.gov/vuln/detail/CVE-2023-3212){: external}, [CVE-2023-3863](https://nvd.nist.gov/vuln/detail/CVE-2023-3863){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-4194](https://nvd.nist.gov/vuln/detail/CVE-2023-4194){: external}, [CVE-2023-43785](https://nvd.nist.gov/vuln/detail/CVE-2023-43785){: external}, [CVE-2023-43786](https://nvd.nist.gov/vuln/detail/CVE-2023-43786){: external}, [CVE-2023-43787](https://nvd.nist.gov/vuln/detail/CVE-2023-43787){: external}. |
| GPU device plug-in and installer |	61afd3d	| 4319682	|New version contains updates and security fixes. |
| Kubernetes | N/A |N/A|N/A|
| Containerd | N/A |N/A|N/A|
{: caption="Changes since version 1.28.2_1528" caption-side="bottom"}


### Change log for worker node fix pack 1.28.2_1528, released 27 September 2023
{: #1282_1528_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1528. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-162-generic | 5.4.0-163-generic| Package updates for [CVE-2023-3341](https://nvd.nist.gov/vuln/detail/CVE-2023-3341){: external}, [CVE-2023-4156](https://nvd.nist.gov/vuln/detail/CVE-2023-4156){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-20900](https://nvd.nist.gov/vuln/detail/CVE-2023-20900){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}. |
| Containerd | 1.7.5 | 1.7.6 |N/A|
| Kubernetes | 1.28.1 | 1.28.2 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.28.md#change log-since-v1281){: external}. |
{: caption="Changes since version 1.28.1_1523" caption-side="bottom"}


### Change log for master fix pack 1.28.2_1527 and worker node fix pack 1.28.1_1523, released 20 September 2023
{: #1.28.2_1527M-and-1.28.1_1523W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| CoreDNS | 1.10.1 | 1.11.1 | See the [CoreDNS release notes](https://coredns.io/2023/08/15/coredns-1.11.1-release/). CoreDNS now runs as a non-root user and has an updated role-based access control (RBAC) configuration. |
| Containerd |  1.7.4| 1.7.5 | NA |
| HAProxy configuration | N/A | N/A | Updated master health probes to use the `/livez/ping` endpoint. |
| IBM Cloud Controller Manager | v1.27.5-3 | v1.28.1-3 | Updated to support the Kubernetes `1.28.1` release. Updated `Go` dependencies and to `Go` version `1.20.7`. New nodes are now registered with the `node.kubernetes.io/network-unavailable` taint which is cleared when Calico is initialized on the node. |
| Kubernetes add-on resizer | 1.8.18 | 1.8.19 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.19). |
| Kubernetes (master) | v1.27.5 | v1.28.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.2). |
| Kubernetes (worker node) | v1.27.4 | v1.28.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.1). |
| Ubuntu 20.04 packages | 5.4.0-156-generic | 5.4.0-162-generic | Worker node kernel & package updates for [CVE-2020-21047](https://nvd.nist.gov/vuln/detail/CVE-2020-21047){: external} , [CVE-2021-33294](https://nvd.nist.gov/vuln/detail/CVE-2021-33294){: external} , [CVE-2022-40982](https://nvd.nist.gov/vuln/detail/CVE-2022-40982){: external} , [CVE-2023-20593](https://nvd.nist.gov/vuln/detail/CVE-2023-20593){: external} , [CVE-2023-2269](https://nvd.nist.gov/vuln/detail/CVE-2023-2269){: external} , [CVE-2023-31084](https://nvd.nist.gov/vuln/detail/CVE-2023-31084){: external} , [CVE-2023-3268](https://nvd.nist.gov/vuln/detail/CVE-2023-3268){: external} , [CVE-2023-3609](https://nvd.nist.gov/vuln/detail/CVE-2023-3609){: external} , [CVE-2023-3611](https://nvd.nist.gov/vuln/detail/CVE-2023-3611){: external} , [CVE-2023-3776](https://nvd.nist.gov/vuln/detail/CVE-2023-3776){: external} |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings). In addition, both `default` and `verbose` [Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server) records now contain extra user claim information. |
| GPU device plug-in and installer | NA | 61afd3d | Driver version: [535.54.03](http://docs.nvidia.com/datacenter/tesla/tesla-release-notes-535-54-03/index.html). |
| Kubernetes Dashboard metrics scraper | N/A |	N/A | Increased Kubernetes Dashboard metrics scraper CPU resource request to `20m`. |
| Kubernetes DNS autoscaler | v1.8.8 | v1.8.9 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/v1.8.9). |
| Kubernetes Metrics Server | v0.6.3 | v0.6.4 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.4). In addition, the Kubernetes Metrics Server has an updated role-based access control (RBAC) configuration. |
| Kubernetes CSI snapshot controller and CRDs | v6.2.1 | v6.2.2 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.2.2). |
{: caption="Changes since version 1.27." caption-side="bottom"}


