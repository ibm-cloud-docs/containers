---

copyright:
 years: 2014, 2023
lastupdated: "2023-01-11"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch, 1.21

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Kubernetes version 1.21 change log
{: #changelog_121}

Kubernetes version 1.21 is unsupported as of 14 September 2022. Update your cluster to at least [version 1.22](/docs/containers?topic=containers-cs_versions_121) as soon as possible.
{: note}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.21. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}


## Overview
{: #changelog_overview_121}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.21 change log
{: #121_changelog}


Review the version 1.21 change log.
{: shortdesc}







### Change log for worker node fix pack 1.21.14_1578, released 26 September 2022
{: #12114_1578}

The following table shows the changes that are in the worker node fix pack 1.21.14_1578. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-192 | 4.15.0-193 | Worker node kernel & package updates for [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2021-33655](https://nvd.nist.gov/vuln/detail/CVE-2021-33655){: external},[CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external},[CVE-2022-0943](https://nvd.nist.gov/vuln/detail/CVE-2022-0943){: external},[CVE-2022-1154](https://nvd.nist.gov/vuln/detail/CVE-2022-1154){: external},[CVE-2022-1616](https://nvd.nist.gov/vuln/detail/CVE-2022-1616){: external},[CVE-2022-1619](https://nvd.nist.gov/vuln/detail/CVE-2022-1619){: external},[CVE-2022-1620](https://nvd.nist.gov/vuln/detail/CVE-2022-1620){: external},[CVE-2022-1621](https://nvd.nist.gov/vuln/detail/CVE-2022-1621){: external},[CVE-2022-2526](https://nvd.nist.gov/vuln/detail/CVE-2022-2526){: external},[CVE-2022-2795](https://nvd.nist.gov/vuln/detail/CVE-2022-2795){: external},[CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external},[CVE-2022-36946](https://nvd.nist.gov/vuln/detail/CVE-2022-36946){: external},[CVE-2022-38177](https://nvd.nist.gov/vuln/detail/CVE-2022-38177){: external},[CVE-2022-38178](https://nvd.nist.gov/vuln/detail/CVE-2022-38178){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.21.14_1578" caption-side="bottom"}

### Change log for worker node fix pack 1.21.14_1578, released 12 September 2022
{: #12114_1578_2}

The following table shows the changes that are in the worker node fix pack 1.21.14_1578. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-191 | 4.15.0-192 | Worker node kernel & package updates for [CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external},[CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external}. |
| Kubernetes |N/A|N/A|N/A| 
{: caption="Changes since version 1.21.14_1578" caption-side="bottom"}

### Change log for master fix pack 1.21.14_1579, released 1 September 2022
{: #12114_1579}

The following table shows the changes that are in the master fix pack 1.21.14_1579. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.20.5 | v3.20.6 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.20/release-notes/#v3206){: external}. |
| Cluster health image | v1.3.9 | v1.3.10 | Updated `Go` dependencies and to `Go` version `1.18.5`. |
| CoreDNS | 1.8.7 | 1.8.6 | See the [CoreDNS release notes](https://coredns.io/2021/10/07/coredns-1.8.6-release/){: external}. |
| Gateway-enabled cluster controller | 1792 | 1823 | Updated to `Go` version `1.17.13`. |
| GPU device plug-in and installer | d8f1be0 | c58c299 | Enable DRM module and update `Go` to version `1.18.5`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 997 | 1006 | Updated to `Go` version `1.17.13`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.14-3 | v1.21.14-4 | Updated `vpcctl` binary to version `3367`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 412 | 414 | Updated to `Go` version `1.18.5`. Updated universal base image (UBI) to version `8.6-902` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 0a187a4 | dc1725a | Updated `Go` dependencies and to `Go` version `1.18.3`. |
| Key Management Service provider | v2.5.7 | v2.5.8 | Updated `Go` dependencies. |
| Konnectivity agent and server | v0.0.30_331_iks | v0.0.32_363_iks | Updated to `Go` version `1.17.13` and to `Konnectivity` version `v0.0.32`. |
| Kubernetes NodeLocal DNS cache | 1.21.4 | 1.22.6 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2058 | 2110 | Updated `Go` dependencies and to `Go` version `1.17.13`. |
| Operator Lifecycle Manager | 0.16.1-IKS-18 | 0.16.1-IKS-19 | Update image for [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}. |
| Portieris admission controller | v0.12.5 | v0.12.6 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.6){: external}. |
{: caption="Changes since version 1.21.14_1576" caption-side="bottom"}

### Change log for worker node fix pack 1.21.14_1578, released 29 August 2022
{: #12114_1578_3}

The following table shows the changes that are in the worker node fix pack 1.21.14_1578. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2019-5815](https://nvd.nist.gov/vuln/detail/CVE-2019-5815){: external},[CVE-2021-30560](https://nvd.nist.gov/vuln/detail/CVE-2021-30560){: external},[CVE-2022-31676](https://nvd.nist.gov/vuln/detail/CVE-2022-31676){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}. |
| Kubernetes |N/A|N/A|N/A| 
| HAPROXY | 6514a2 | c1634f | [CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external},[CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}
{: caption="Changes since version 1.21.14_1576" caption-side="bottom"}

### Change log for worker node fix pack 1.21.14_1576, released 16 August 2022
{: #12114_1576}

The following table shows the changes that are in the worker node fix pack 1.21.14_1576. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-189 | 4.15.0-191 | Worker node kernel & package updates for [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external},[CVE-2021-4209](https://nvd.nist.gov/vuln/detail/CVE-2021-4209){: external},[CVE-2022-1652](https://nvd.nist.gov/vuln/detail/CVE-2022-1652){: external},[CVE-2022-1679](https://nvd.nist.gov/vuln/detail/CVE-2022-1679){: external},[CVE-2022-1734](https://nvd.nist.gov/vuln/detail/CVE-2022-1734){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-2586](https://nvd.nist.gov/vuln/detail/CVE-2022-2586){: external},[CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external},[CVE-2022-34918](https://nvd.nist.gov/vuln/detail/CVE-2022-34918){: external}. |
| Kubernetes |N/A|N/A|N/A| 
| containerd | 1.6.6 | 1.6.8 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.8){: external}. |
{: caption="Changes since version 1.21.14_1575" caption-side="bottom"}

### Change log for worker node fix pack 1.21.14_1575, released 01 August 2022
{: #12114_1575}

The following table shows the changes that are in the worker node fix pack 1.21.14_1575. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2022-27404](https://nvd.nist.gov/vuln/detail/CVE-2022-27404){: external},[CVE-2022-27405](https://nvd.nist.gov/vuln/detail/CVE-2022-27405){: external},[CVE-2022-27406](https://nvd.nist.gov/vuln/detail/CVE-2022-27406){: external},[CVE-2022-29217](https://nvd.nist.gov/vuln/detail/CVE-2022-29217){: external},[CVE-2022-31782](https://nvd.nist.gov/vuln/detail/CVE-2022-31782){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.21.14_1572" caption-side="bottom"}

### Change log for master fix pack 1.21.14_1574, released 26 July 2022
{: #12114_1574}

The following table shows the changes that are in the master fix pack 1.21.14_1574. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.8 | v1.3.9 | Updated `Go` dependencies and to use `Go` version `1.18.4`. Fixed minor typographical error in the add-on `daemonset not available` health status. |
| Gateway-enabled cluster controller | 1680 | 1792 | Updated to use `Go` version `1.17.11`. Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external} and [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}. |
| GPU device plug-in and installer | 2b0b6d1 | d8f1be0 | Updated `Go` dependencies and to use `Go` version `1.18.3`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 980 | 997 | Updated to use `Go` version `1.17.11`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.13-5 | v1.21.14-3 | Updated `Go` dependencies. Updated to support the Kubernetes `1.21.14` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 410 | 412 | Updated to use `Go` version `1.18.3`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. Improved Kubernetes resource watch configuration. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8c96932 | 0a187a4 | Updated universal base image (UBI) to resolve CVEs. |
| Key Management Service provider | v2.5.6 | v2.5.7 | Updated `Go` dependencies and to use `Go` version `1.18.4`. |
| Operator Lifecycle Manager | 0.16.1-IKS-17 | 0.16.1-IKS-18 | Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1998 | 2058 | Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external}. |
| Portieris admission controller | v0.12.4 | v0.12.5 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.5){: external}. |
{: caption="Changes since version 1.21.14_1564" caption-side="bottom"}

### Change log for worker node fix pack 1.21.14_1572, released 18 July 2022
{: #12114_1572}

The following table shows the changes that are in the worker node fix pack 1.21.14_1572. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-188 | 4.15.0-189 | Worker node kernel & package updates for [CVE-2015-20107](https://nvd.nist.gov/vuln/detail/CVE-2015-20107){: external}, [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external},[CVE-2022-22747](https://nvd.nist.gov/vuln/detail/CVE-2022-22747){: external}, [CVE-2022-24765](https://nvd.nist.gov/vuln/detail/CVE-2022-24765){: external}, [CVE-2022-29187](https://nvd.nist.gov/vuln/detail/CVE-2022-29187){: external},[CVE-2022-34480](https://nvd.nist.gov/vuln/detail/CVE-2022-34480){: external},[CVE-2022-34903](https://nvd.nist.gov/vuln/detail/CVE-2022-34903){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.21.14_1565" caption-side="bottom"}

### Change log for worker node fix pack 1.21.14_1565, released 05 July 2022
{: #12114_1565}

The following table shows the changes that are in the worker node fix pack 1.21.14_1565. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-187 | 4.15.0-188 | Worker node kernel & package updates for [CVE-2022-1292](https://nvd.nist.gov/vuln/detail/CVE-2022-1292){: external},[CVE-2022-2068](https://nvd.nist.gov/vuln/detail/CVE-2022-2068){: external},[CVE-2022-2084](https://nvd.nist.gov/vuln/detail/CVE-2022-2084){: external},[CVE-2022-28388](https://nvd.nist.gov/vuln/detail/CVE-2022-28388){: external},[CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external},[CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.21.14_1564" caption-side="bottom"}

### Change log for master fix pack 1.21.14_1564, released 22 June 2022
{: #master_12114_1564}

The following table shows the changes that are in the master fix pack 1.21.14_1564. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.7 | v1.3.8 | Updated `Go` to version `1.17.11` and also updated the dependencies. |
| CoreDNS | 1.8.6 | 1.8.7 | See the [CoreDNS release notes](https://coredns.io/2021/12/09/coredns-1.8.7-release/){: external}. |
| GPU device plug-in and installer | 382ada9 | 2b0b6d1 | Updated universal base image (UBI) to version `8.6-751`. Updated `Go` to version `1.17.10`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.13-2 | v1.21.13-5 | Update prometheus/client_golang@v1.7.1 to `v1.11.1` |
| Key Management Service provider | v2.5.5 | v2.5.6 | Updated `Go` to version `1.17.11` and also updated the dependencies. |
| Kubernetes | v1.21.13 | v1.21.14 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.14){: external}. |
| Kubernetes add-on resizer | 1.8.14 | 1.8.15 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.18.15){: external}. |
{: caption="Changes since version 1.21.13_1561" caption-side="bottom"}

### Change log for worker node fix pack 1.21.14_1564, released 20 June 2022
{: #12114_1564}

The following table shows the changes that are in the worker node fix pack 1.21.14_1564. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-180 | 4.15.0-187 | Worker node kernel & package updates for [CVE-2021-46790](https://nvd.nist.gov/vuln/detail/CVE-2021-46790){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}, [CVE-2022-1419](https://nvd.nist.gov/vuln/detail/CVE-2022-1419){: external}, [CVE-2022-1966](https://nvd.nist.gov/vuln/detail/CVE-2022-1966){: external}, [CVE-2022-21123](https://nvd.nist.gov/vuln/detail/CVE-2022-21123){: external}, [CVE-2022-21125](https://nvd.nist.gov/vuln/detail/CVE-2022-21125){: external}, [CVE-2022-21166](https://nvd.nist.gov/vuln/detail/CVE-2022-21166){: external}, [CVE-2022-21499](https://nvd.nist.gov/vuln/detail/CVE-2022-21499){: external}, [CVE-2022-28390](https://nvd.nist.gov/vuln/detail/CVE-2022-28390){: external}, [CVE-2022-30783](https://nvd.nist.gov/vuln/detail/CVE-2022-30783){: external}, [CVE-2022-30784](https://nvd.nist.gov/vuln/detail/CVE-2022-30784){: external}, [CVE-2022-30785](https://nvd.nist.gov/vuln/detail/CVE-2022-30785){: external}, [CVE-2022-30786](https://nvd.nist.gov/vuln/detail/CVE-2022-30786){: external}, [CVE-2022-30787](https://nvd.nist.gov/vuln/detail/CVE-2022-30787){: external}, [CVE-2022-30788](https://nvd.nist.gov/vuln/detail/CVE-2022-30788){: external}, [CVE-2022-30789](https://nvd.nist.gov/vuln/detail/CVE-2022-30789){: external}. |
| Haproxy | 468c09 | 04f862 | [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}. |
| containerd | v1.5.11 | v1.5.13 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.13){: external}, the [security bulletin](https://www.ibm.com/support/pages/node/6597989){: external} for [CVE-2022-31030](https://nvd.nist.gov/vuln/detail/CVE-2022-31030){: external}, and the [security bulletin](https://www.ibm.com/support/pages/node/6598049){: external} for [CVE-2022-29162](https://nvd.nist.gov/vuln/detail/CVE-2022-29162){: external}. |
| Kubernetes | 1.21.13 | 1.21.14 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.14){: external}. | 
{: caption="Changes since version 1.21.13_1562" caption-side="bottom"}

### Change log for worker node fix pack 1.21.13_1562, released 7 June 2022
{: #12113_1562}

The following table shows the changes that are in the worker node fix pack 1.21.13_1562. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-177 | 4.15.0-180 | Worker node kernel & package updates for [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2022-1664](https://nvd.nist.gov/vuln/detail/CVE-2022-1664){: external}, [CVE-2022-29581](https://nvd.nist.gov/vuln/detail/CVE-2022-29581){: external}. |
{: caption="Changes since version 1.21.12_1560" caption-side="bottom"}

### Change log for master fix pack 1.21.13_1561, released 3 June 2022
{: #12113_1561}

The following table shows the changes that are in the master fix pack 1.21.13_1561. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.6 | v1.3.7 | Updated Go to version 1.17.10 and also updated the dependencies. Update registry base image version to `104` |
| GPU device plug-in and installer | 9485e14 | 382ada9 | Updated `Go` to version `1.17.9` |
| {{site.data.keyword.IBM_notm}} Calico extension | 954 | 980 | Updated to use `Go` version `1.17.10`. Updated minimal UBI to version `8.5`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.11-6 | v1.21.13-2 | Updated to support the Kubernetes `1.21.13` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 408 | 410 | Updated universal base image (UBI) to version `8.6-751` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8c8c82b | 8c96932 | Updated `Go` to version `1.18.1` |
| Key Management Service provider | v2.5.4 | v2.5.5 | Updated `Go` to version `1.17.10` and updated the golang dependencies. |
| Kubernetes | v1.21.12 | v1.21.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.13){: external}. |
| Kubernetes add-on resizer | 1.8.13 | 1.8.14 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.14){: external}. |
| Kubernetes Dashboard | v2.3.1 | v2.3.1 | The **default** Kubernetes Dashboard settings found in the `kubernetes-dashboard-settings` config map in the `kube-system` namespace have been updated to set `resourceAutoRefreshTimeInterval` to `60`. This default change is only applied to new clusters. The previous default value was `5`. If your cluster has Kubernetes Dashboard performance problems, see the steps for [changing the auto refresh time interval](/docs/containers?topic=containers-ts-kube-dashboord-oom). | 
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1916 | 1998 | Updated `Go` to version `1.17.10` and updated dependencies. |
| Portieris admission controller | v0.10.3 | v0.12.4 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.4){: external}. |
{: caption="Changes since version 1.21.12_1557" caption-side="bottom"}

### Change log for worker node fix pack 1.21.12_1560, released 23 May 2022
{: #12112_1560}

The following table shows the changes that are in the worker node fix pack 1.21.12_1560. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-176 | 4.15.0-177 | Worker node kernel & package updates for [CVE-2019-20838](https://nvd.nist.gov/vuln/detail/CVE-2019-20838){: external}, [CVE-2020-14155](https://nvd.nist.gov/vuln/detail/CVE-2020-14155){: external}, [CVE-2020-25648](https://nvd.nist.gov/vuln/detail/CVE-2020-25648){: external}, [CVE-2020-35512](https://nvd.nist.gov/vuln/detail/CVE-2020-35512){: external}, [CVE-2021-26401](https://nvd.nist.gov/vuln/detail/CVE-2021-26401){: external}, [CVE-2022-0001](https://nvd.nist.gov/vuln/detail/CVE-2022-0001){: external}, [CVE-2022-0934](https://nvd.nist.gov/vuln/detail/CVE-2022-0934){: external}, [CVE-2022-26490](https://nvd.nist.gov/vuln/detail/CVE-2022-26490){: external}, [CVE-2022-27223](https://nvd.nist.gov/vuln/detail/CVE-2022-27223){: external}, [CVE-2022-27781](https://nvd.nist.gov/vuln/detail/CVE-2022-27781){: external}, [CVE-2022-27782](https://nvd.nist.gov/vuln/detail/CVE-2022-27782){: external}, [CVE-2022-28657](https://nvd.nist.gov/vuln/detail/CVE-2022-28657){: external}, [CVE-2022-29155](https://nvd.nist.gov/vuln/detail/CVE-2022-29155){: external}, [CVE-2022-29824](https://nvd.nist.gov/vuln/detail/CVE-2022-29824){: external}, [CVE-2017-9525](https://nvd.nist.gov/vuln/detail/CVE-2017-9525){: external}, [CVE-2022-28654](https://nvd.nist.gov/vuln/detail/CVE-2022-28654){: external}, [CVE-2022-28656](https://nvd.nist.gov/vuln/detail/CVE-2022-28656){: external}, [CVE-2022-28655](https://nvd.nist.gov/vuln/detail/CVE-2022-28655){: external}, [CVE-2022-28652](https://nvd.nist.gov/vuln/detail/CVE-2022-28652){: external}, [CVE-2022-1242](https://nvd.nist.gov/vuln/detail/CVE-2022-1242){: external}, [CVE-2022-28658](https://nvd.nist.gov/vuln/detail/CVE-2022-28658){: external}, [CVE-2021-3899](https://nvd.nist.gov/vuln/detail/CVE-2021-3899){: external}. |
| HA proxy | 36b0307 | 468c09 | [CVE-2021-3634](https://nvd.nist.gov/vuln/detail/CVE-2021-3634){: external}. |
{: caption="Changes since version 1.21.12_1559" caption-side="bottom"}

### Change log for worker node fix pack 1.21.12_1559, released 09 May 2022
{: #12112_1559}

The following table shows the changes that are in the worker node fix pack 1.21.12_1559. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2021-36084](https://nvd.nist.gov/vuln/detail/CVE-2021-36084){: external}, [CVE-2021-36085](https://nvd.nist.gov/vuln/detail/CVE-2021-36085){: external}, [CVE-2021-36086](https://nvd.nist.gov/vuln/detail/CVE-2021-36086){: external}, [CVE-2021-36087](https://nvd.nist.gov/vuln/detail/CVE-2021-36087){: external}, [CVE-2022-1292](https://nvd.nist.gov/vuln/detail/CVE-2022-1292){: external}, [CVE-2022-22576](https://nvd.nist.gov/vuln/detail/CVE-2022-22576){: external}, [CVE-2022-27774](https://nvd.nist.gov/vuln/detail/CVE-2022-27774){: external}, [CVE-2022-27775](https://nvd.nist.gov/vuln/detail/CVE-2022-27775){: external}, [CVE-2022-27776](https://nvd.nist.gov/vuln/detail/CVE-2022-27776){: external}, [CVE-2022-29799](https://nvd.nist.gov/vuln/detail/CVE-2022-29799){: external}, [CVE-2022-29800](https://nvd.nist.gov/vuln/detail/CVE-2022-29800){: external}. |
| Kubernetes | N/A | N/A | N/A |
| Haproxy | f53b22 | 36b030 | [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}, [CVE-2022-1154](https://nvd.nist.gov/vuln/detail/CVE-2022-1154){: external}, [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032){: external}. |
{: caption="Changes since version 1.21.12_1558" caption-side="bottom"}

### Change log for master fix pack 1.21.12_1557, released 26 April 2022
{: #12112_1557}

The following table shows the changes that are in the master fix pack 1.21.12_1557. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.20.4 | v3.20.5 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.20/release-notes/#v3205){: external}. |
| Cluster health image | v1.3.5 | v1.3.6 | Updated `Go` to version `1.17.9` and also updated the dependencies. Update `registry base image` version to `103`. |
| Gateway-enabled cluster controller | 1669 | 1680 | Updated metadata for a rotated key. |
| GPU device plug-in and installer | 13677d2 | 9485e14 | Updated Drivers to `470.103.01`. Updated metadata for a rotated key. |
| {{site.data.keyword.IBM_notm}} Calico extension | 950 | 954 | Updated to latest UBI-minimal image to resolve [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}, [CVE-2022-23308](https://nvd.nist.gov/vuln/detail/CVE-2022-23308){: external}, [CVE-2021-23177](https://nvd.nist.gov/vuln/detail/CVE-2021-23177){: external}, and [CVE-2021-31566](https://nvd.nist.gov/vuln/detail/CVE-2021-31566){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.11-3 | v1.21.11-6 | Updated `vpcctl` to the `3003` binary image. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 407 | 408 | Fixed [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 6c43ef1 | 8c8c82b | Updated `Go` to version `1.17.8` |
| Key Management Service provider | v2.5.3 | v2.5.4 | Moved to a different base image, version `102`, to reduce CVE footprint. Resolved [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}. |
| Kubernetes | v1.21.11 | v1.21.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.12){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.3 | 1.21.4 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.21.4){: external}. |
| Load balancer and Load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1899 | 1916 | Updated the image to resolve CVEs. |
{: caption="Changes since version 1.21.11_1555" caption-side="bottom"}



### Change log for worker node fix pack 1.21.12_1558, released 25 April 2022
{: #12112_1558}




| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-175-generic | 4.15.0-176-generic | Kernel and package updates for [CVE-2018-16301](https://nvd.nist.gov/vuln/detail/CVE-2018-16301){: external}, [CVE-2019-18276](https://nvd.nist.gov/vuln/detail/CVE-2019-18276){: external}, [CVE-2020-8037](https://nvd.nist.gov/vuln/detail/CVE-2020-8037){: external}, [CVE-2021-31870](https://nvd.nist.gov/vuln/detail/CVE-2021-31870){: external}, [CVE-2021-31871](https://nvd.nist.gov/vuln/detail/CVE-2021-31871){: external}, [CVE-2021-31872](https://nvd.nist.gov/vuln/detail/CVE-2021-31872){: external}, [CVE-2021-31873](https://nvd.nist.gov/vuln/detail/CVE-2021-31873){: external}, [CVE-2021-43975](https://nvd.nist.gov/vuln/detail/CVE-2021-43975){: external}, [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}, [CVE-2022-24765](https://nvd.nist.gov/vuln/detail/CVE-2022-24765){: external}. |
| Kubernetes | v1.21.11 | v1.21.12 | See [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.12){: external}. |
{: caption="Changes since version 1.21.11_1556" caption-side="bottom"}








### Change log for worker node fix pack 1.21.11_1556, released 11 April 2022
{: #12111_1556}

The following table shows the changes that are in the worker node fix pack 1.21.11_1556. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Containerd | v1.5.10 | v1.5.11 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.11){: external} and the [security bulletin](https://www.ibm.com/support/pages/node/6572257){: external}. |
| Ubuntu 18.04 packages | 4.15.0-173-generic | 4.15.0-175-generic | Kernel and package updates for [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032) [CVE-2021-3426](https://nvd.nist.gov/vuln/detail/CVE-2021-3426) [CVE-2021-4189](https://nvd.nist.gov/vuln/detail/CVE-2021-4189) [CVE-2022-0391](https://nvd.nist.gov/vuln/detail/CVE-2022-0391) [CVE-2022-21712](https://nvd.nist.gov/vuln/detail/CVE-2022-21712) [CVE-2022-21716](https://nvd.nist.gov/vuln/detail/CVE-2022-21716) [CVE-2022-25308](https://nvd.nist.gov/vuln/detail/CVE-2022-25308) [CVE-2022-25309](https://nvd.nist.gov/vuln/detail/CVE-2022-25309) [CVE-2022-25310](https://nvd.nist.gov/vuln/detail/CVE-2022-25310) [CVE-2022-27666](https://nvd.nist.gov/vuln/detail/CVE-2022-27666). |
{: caption="Changes since version 1.21.11_1554" caption-side="bottom"}






### Change log for master fix pack 1.21.11_1555, released 6 April 2022
{: #12111_1555}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1865 | 1899 | Revert setting gratuitous arp on LBv1. |
{: caption="Changes since version 1.21.11_1553" caption-side="bottom"}






### Change log for master fix pack 1.21.11_1553, released 30 March 2022
{: #12111_1553}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.19.4 | v3.20.4 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.20/release-notes/){: external}. |
| Cluster health image | v1.3.3 | v1.3.5 | Updated image to fix CVEs [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}.  Updated golang dependencies. |
| Gateway-enabled cluster controller | 1653 | 1669 | Updated to use `Go` version `1.17.8`. |
| GPU device plug-in and installer | d7daae6 | 13677d2 | Updated GPU images to resolve CVEs. |
| IBM Calico extension | 929 | 950 | Updated to use `Go` version `1.17.8`. Updated universal base image (UBI) to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.10-2 | v1.21.11-3 | Updated to support the `Kubernetes 1.21.11` release and to use `Go` version `1.16.15`. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor | 405 | 407 | Updated `Go` to version `1.16.14`.  Updated `UBI` image to version `8.5-240`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 0fc9949 | 6c43ef1 | Upgraded `Go` packages to resolve vulnerabilities |
| Key Management Service provider | v2.4.3 | v2.5.3 | Updated to use `Go` version `1.17.8`. Updated golang dependencies.  Fixed CVE [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external} |
| Konnectivity agent | v0.0.27_a6b5248a_323_iks | v0.0.30_331_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.30){: external}.  Updated to use `Go` version `1.17.8`. |
| Konnectivity server | v0.0.27_a6b5248a_323_iks | v0.0.30_331_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.30){: external}.  Updated to use `Go` version `1.17.8`. |
| Kubernetes | v1.21.10 | v1.21.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.11){: external}. |
| Load balancer and Load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1747 | 1865 | Updated the image to resolve CVEs. Updated to use `Go` version `1.17.8`. Set gratuitous arp at the correct time on LBv1. |
| Operator Lifecycle Manager | 0.16.1-IKS-15 | 0.16.1-IKS-16 | Resolve [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}. |
{: caption="Changes since version 1.21.10_1550" caption-side="bottom"}





### Change log for worker node fix pack 1.21.11_1554, released 28 March 2022
{: #12110_1554}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-171-generic | 4.15.0-173-generic | Kernel and package updates for [CVE-2021-20193](https://nvd.nist.gov/vuln/detail/CVE-2021-20193){: external}, [CVE-2021-25220](https://nvd.nist.gov/vuln/detail/CVE-2021-25220){: external}, [CVE-2021-3506](https://nvd.nist.gov/vuln/detail/CVE-2021-3506){: external}, [CVE-2022-0435](https://nvd.nist.gov/vuln/detail/CVE-2022-0435){: external}, [CVE-2022-0492](https://nvd.nist.gov/vuln/detail/CVE-2022-0492){: external}, [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}, [CVE-2022-0847](https://nvd.nist.gov/vuln/detail/CVE-2022-0847){: external}, [CVE-2022-23308](https://nvd.nist.gov/vuln/detail/CVE-2022-23308){: external}. |
| HA proxy | 15198f | b40c07 | [CVE-2021-45960](https://nvd.nist.gov/vuln/detail/CVE-2021-45960){: external}, [CVE-2021-46143](https://nvd.nist.gov/vuln/detail/CVE-2021-46143){: external}, [CVE-2022-22822](https://nvd.nist.gov/vuln/detail/CVE-2022-22822){: external}, [CVE-2022-22823](https://nvd.nist.gov/vuln/detail/CVE-2022-22823){: external}, [CVE-2022-22824](https://nvd.nist.gov/vuln/detail/CVE-2022-22824){: external}, [CVE-2022-22825](https://nvd.nist.gov/vuln/detail/CVE-2022-22825){: external}, [CVE-2022-22826](https://nvd.nist.gov/vuln/detail/CVE-2022-22826){: external}, [CVE-2022-22827](https://nvd.nist.gov/vuln/detail/CVE-2022-22827){: external}, [CVE-2022-23852](https://nvd.nist.gov/vuln/detail/CVE-2022-23852){: external}, [CVE-2022-25235](https://nvd.nist.gov/vuln/detail/CVE-2022-25235){: external}, [CVE-2022-25236](https://nvd.nist.gov/vuln/detail/CVE-2022-25236){: external}, [CVE-2022-25315](https://nvd.nist.gov/vuln/detail/CVE-2022-25315){: external}, [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}, [CVE-2022-23308](https://nvd.nist.gov/vuln/detail/CVE-2022-23308){: external}, [CVE-2021-23177](https://nvd.nist.gov/vuln/detail/CVE-2021-23177){: external}, [CVE-2021-31566](https://nvd.nist.gov/vuln/detail/CVE-2021-31566){: external}. |
| Kubernetes | 1.21.10 | 1.21.11 | See [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.11){: external}. |
{: caption="Changes since version 1.21.10_1552" caption-side="bottom"}






### Change log for worker node fix pack 1.21.10_1552, released 14 March 2022
{: #12110_1552}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Containerd | v1.5.9 | v1.5.10 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.10){: external} and the [security bulletin](https://www.ibm.com/support/pages/node/6564653){: external}. |
| Ubuntu 18.04 packages | 4.15.0-169-generic | 4.15.0-171-generic | Kernel and package updates for [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2020-29562](https://nvd.nist.gov/vuln/detail/CVE-2020-29562){: external}, [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2021-35942](https://nvd.nist.gov/vuln/detail/CVE-2021-35942){: external}, [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-0001](https://nvd.nist.gov/vuln/detail/CVE-2022-0001){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}, [CVE-2022-25313](https://nvd.nist.gov/vuln/detail/CVE-2022-25313){: external}, [CVE-2022-25314](https://nvd.nist.gov/vuln/detail/CVE-2022-25314){: external}, [CVE-2022-25315](https://nvd.nist.gov/vuln/detail/CVE-2022-25315){: external}. |
{: caption="Changes since version 1.21.10_1551" caption-side="bottom"}





### Change log for master fix pack 1.21.10_1550, released 3 March 2022
{: #12110_1550}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.19.3 | v3.19.4 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| Cluster health image | v1.2.21 | v1.3.3 | Updated `golang.org/x/crypto` to `v0.0.0-20220214200702-86341886e292`. Adds fix for [CVE-2021-43565](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-43565){: external}. Adds Golang dependency updates. |
| Gateway-enabled cluster controller | 1586 | 1653 | Updated to use `Go` version `1.17.7` and updated `Go` modules to fix CVEs. |
| GPU device plug-in and installer | eefc4ae | d7daae6 | Updated GPU images to resolve CVEs. |
| IBM Calico extension | 923 | 929 | Updated universal base image (UBI) to the `8.5-230` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.9-1 | v1.21.10-2 | Updated to support the Kubernetes `1.21.10` release and to use `Go` version `1.16.14`. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor | 404 | 405 | Adds fix for [CVE-2021-3538](https://nvd.nist.gov/vuln/detail/CVE-2021-3538){: external} and adds dependency updates. |
| Key Management Service provider | v2.3.13 | v2.4.3 | Updated `golang.org/x/crypto` to `v0.0.0-20220214200702-86341886e292`. Adds fix for [CVE-2021-43565](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-43565){: external}. Adds Golang dependency updates. |
| Konnectivity agent | v0.0.27_309_iks | v0.0.27_a6b5248a_323_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.27){: external}. Updates universal base image (UBI) to the `8.5-230` version to resolve CVEs.  Updates to use `Go` version `1.17.5`. |
| Konnectivity server | v0.0.27_309_iks | v0.0.27_a6b5248a_323_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.27){: external}. Updates universal base image (UBI) to the `8.5-230` version to resolve CVEs. Updates to use `Go` version `1.17.5`. |
| Kubernetes | v1.21.9 | v1.21.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.10){: external}. |
{: caption="Changes since version 1.21.9_1547" caption-side="bottom"}





### Change log for worker node fix pack 1.21.10_1551, released 28 February 2022
{: #12110_1551}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-167-generic | 4.15.0-169-generic | Kernel and package updates for [CVE-2021-4083](https://nvd.nist.gov/vuln/detail/CVE-2021-4083){: external}, [CVE-2021-4155](https://nvd.nist.gov/vuln/detail/CVE-2021-4155){: external}, [CVE-2021-45960](https://nvd.nist.gov/vuln/detail/CVE-2021-45960){: external}, [CVE-2021-46143](https://nvd.nist.gov/vuln/detail/CVE-2021-46143){: external}, [CVE-2022-0330](https://nvd.nist.gov/vuln/detail/CVE-2022-0330){: external}, [CVE-2022-22822](https://nvd.nist.gov/vuln/detail/CVE-2022-22822){: external}, [CVE-2022-22823](https://nvd.nist.gov/vuln/detail/CVE-2022-22823){: external}, [CVE-2022-22824](https://nvd.nist.gov/vuln/detail/CVE-2022-22824){: external}, [CVE-2022-22825](https://nvd.nist.gov/vuln/detail/CVE-2022-22825){: external}, [CVE-2022-22826](https://nvd.nist.gov/vuln/detail/CVE-2022-22826){: external}, [CVE-2022-22827](https://nvd.nist.gov/vuln/detail/CVE-2022-22827){: external}, [CVE-2022-22942](https://nvd.nist.gov/vuln/detail/CVE-2022-22942){: external}, [CVE-2022-23852](https://nvd.nist.gov/vuln/detail/CVE-2022-23852){: external}, [CVE-2022-23990](https://nvd.nist.gov/vuln/detail/CVE-2022-23990){: external}, [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external}, [CVE-2022-25235](https://nvd.nist.gov/vuln/detail/CVE-2022-25235){: external}, [CVE-2022-25236](https://nvd.nist.gov/vuln/detail/CVE-2022-25236){: external}. |
| Kubernetes | v1.21.9 | v1.21.10 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.10){: external}. |
| HA proxy | f6a2b3 | 15198fb | Contains fixes for [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external}, | 
{: caption="Changes since version 1.21.9_1549" caption-side="bottom"}





### Change log for worker node fix pack 1.21.9_1549, released 14 February 2022
{: #1219_1549}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | N/A |
| Kubernetes | N/A | N/A | N/A |
| HA proxy | d38fa1 | f6a2b3 | [CVE-2021-3521](https://nvd.nist.gov/vuln/detail/CVE-2021-3521){: external}   [CVE-2021-4122](https://nvd.nist.gov/vuln/detail/CVE-2021-4122){: external}. |
{: caption="Changes since version 1.20.15_1569" caption-side="bottom"}





### Change log for worker node fix pack 1.21.9_1548, released 31 January 2022
{: #1219_1548}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-7169](https://nvd.nist.gov/vuln/detail/CVE-2018-7169){: external}, [CVE-2021-3984](https://nvd.nist.gov/vuln/detail/CVE-2021-3984){: external}, [CVE-2021-4019](https://nvd.nist.gov/vuln/detail/CVE-2021-4019){: external}, [CVE-2021-4034](https://nvd.nist.gov/vuln/detail/CVE-2021-4034){: external}, [CVE-2021-4069](https://nvd.nist.gov/vuln/detail/CVE-2021-4069){: external}. |
| Kubernetes | 1.21.7 | 1.21.9 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.9){: external}. |
{: caption="Changes since version 1.20.13_1567" caption-side="bottom"}





### Change log for master fix pack 1.21.9_1547, released 26 January 2022
{: #1219_1547}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Changed to improve Calico availability during updates. |
| Cluster health image | v1.2.20 | v1.2.21 | Updated to use `Go` version `1.17.5`, updated Go dependencies and golangci-lint |
| GPU device plug-in and installer | c9bfc8c | eefc4ae | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 900 | 923 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.7-3 | v1.21.9-1 | Updated to support the Kubernetes `1.21.9` release and to use `Go` version `1.16.12`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 402 | 404 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 3430e03 | 0fc9949 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| Key Management Service provider | v2.3.12 | v2.3.13 | Updated `Go` dependencies and golangci-lint |
| Konnectivity agent | v0.0.26_282_iks | v0.0.27_309_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.27){: external}.  Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.17.5`. |
| Konnectivity server | v0.0.26_282_iks | v0.0.27_309_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.27){: external}.  Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.17.5`. |
| Kubernetes | 1.21.7 | 1.21.9 |  Changed the duration of the Kubernetes API server certificate from 825 days to 365 days. Changed the duration of the cluster CA certificate from 30 years to 10 years. Changed the duration of worker node certificates from 3 years to 2 years. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.9){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates) |
| Kubernetes Metrics Server | v0.4.4 | v0.4.5 | Metrics server now dynamically reloads `NannyConfiguration` updates. See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.5){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.1 | 1.21.3 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.21.3){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1659 | 1747 | Updated the Alpine base image to the `3.15` version to resolve CVEs. Updated to use `Go` version `1.17.6`. |
{: caption="Changes since version 1.21.7_1541" caption-side="bottom"}





### Change log for worker node fix pack 1.21.7_1546, released 18 January 2022
{: #1217_1546}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-163-generic | 4.15.0-166-generic | Kernel and package updates for [CVE-2018-25020](https://nvd.nist.gov/vuln/detail/CVE-2018-25020){: external} and [CVE-2021-4002](https://nvd.nist.gov/vuln/detail/CVE-2021-4002){: external}. |
| Containerd | v1.5.8 | v1.5.9 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.9){: external}. |
{: caption="Changes since version 1.21.7_1544" caption-side="bottom"}





### Change log for worker node fix pack 1.21.7_1544, released 4 January 2022
{: #1217_1544}

The following table shows the changes that are in the worker node fix pack patch update `1.21.7_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| HA proxy | 3b8663 | d38fa1 | Contains fixes for [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image packages for [CVE-2019-19449](https://nvd.nist.gov/vuln/detail/CVE-2019-19449){: external}, [CVE-2020-16592](https://nvd.nist.gov/vuln/detail/CVE-2020-16592){: external}, [CVE-2020-21913](https://nvd.nist.gov/vuln/detail/CVE-2020-21913){: external}, [CVE-2020-27781](https://nvd.nist.gov/vuln/detail/CVE-2020-27781){: external}, [CVE-2020-36322](https://nvd.nist.gov/vuln/detail/CVE-2020-36322){: external}, [CVE-2020-36385](https://nvd.nist.gov/vuln/detail/CVE-2020-36385){: external}, [CVE-2021-25219](https://nvd.nist.gov/vuln/detail/CVE-2021-25219){: external}, [CVE-2021-28831](https://nvd.nist.gov/vuln/detail/CVE-2021-28831){: external}, [CVE-2021-28950](https://nvd.nist.gov/vuln/detail/CVE-2021-28950){: external}, [CVE-2021-3487](https://nvd.nist.gov/vuln/detail/CVE-2021-3487){: external}, [CVE-2021-3524](https://nvd.nist.gov/vuln/detail/CVE-2021-3524){: external}, [CVE-2021-3531](https://nvd.nist.gov/vuln/detail/CVE-2021-3531){: external}, [CVE-2021-3733](https://nvd.nist.gov/vuln/detail/CVE-2021-3733){: external}, [CVE-2021-3737](https://nvd.nist.gov/vuln/detail/CVE-2021-3737){: external}, [CVE-2021-3759](https://nvd.nist.gov/vuln/detail/CVE-2021-3759){: external}, [CVE-2021-3778](https://nvd.nist.gov/vuln/detail/CVE-2021-3778){: external}, [CVE-2021-3796](https://nvd.nist.gov/vuln/detail/CVE-2021-3796){: external}, [CVE-2021-3800](https://nvd.nist.gov/vuln/detail/CVE-2021-3800){: external}, [CVE-2021-38199](https://nvd.nist.gov/vuln/detail/CVE-2021-38199){: external}, [CVE-2021-3903](https://nvd.nist.gov/vuln/detail/CVE-2021-3903){: external}, [CVE-2021-3927](https://nvd.nist.gov/vuln/detail/CVE-2021-3927){: external}, [CVE-2021-3928](https://nvd.nist.gov/vuln/detail/CVE-2021-3928){: external}, [CVE-2021-40490](https://nvd.nist.gov/vuln/detail/CVE-2021-40490){: external}, [CVE-2021-42374](https://nvd.nist.gov/vuln/detail/CVE-2021-42374){: external}, [CVE-2021-42378](https://nvd.nist.gov/vuln/detail/CVE-2021-42378){: external}, [CVE-2021-42384](https://nvd.nist.gov/vuln/detail/CVE-2021-42384){: external}, and [CVE-2021-43527](https://nvd.nist.gov/vuln/detail/CVE-2021-43527){: external}. |
{: caption="Changes since version 1.21.7_1542" caption-side="bottom"}





### Change log for master fix pack 1.21.7_1541, released 7 December 2021
{: #1217_1541}

The following table shows the changes that are in the master fix pack update `1.21.7_1541`.  Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.18 | v1.2.20 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| CoreDNS | 1.8.4 | 1.8.6 | See the [CoreDNS release notes](https://coredns.io/2021/10/07/coredns-1.8.6-release/){: external}. |
| Gateway-enabled cluster controller | 1567 | 1586 | Updated Alpine base image to the latest `3.14` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| GPU device plug-in and installer | 7fd867d | c9bfc8c | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 864 | 900 | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.6-2 | v1.21.7-3 | Updated to support the Kubernetes `1.21.7` release and to use `Go` version `1.16.10`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 401 | 402 | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4ca5637 | 3430e03 | Updated universal base image (UBI) to the latest `8.5` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Key Management Service provider | v2.3.10 | v2.3.12 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Konnectivity agent | v0.0.24_268_iks | v0.0.26_282_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.26){: external}. |
| Konnectivity server | v0.0.24_268_iks | v0.0.26_282_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.26){: external}. Updated to use TLS version 1.3 ciphers.|
| Kubernetes | v1.21.6 | v1.21.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.7){: external}. |
| Kubernetes NodeLocal DNS cache | 1.17.3 | 1.21.1 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.21.1){: external}. Increased memory resource requests from `8Mi` to `10Mi` to better align with normal resource utilization. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1590 | 1659 | Updated Alpine base image to the latest `3.14` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Operator Lifecycle Manager | 0.16.1-IKS-14 | 0.16.1-IKS-15 | Updated image for [CVE-2021-42374](https://nvd.nist.gov/vuln/detail/CVE-2021-42374){: external}, [CVE-2021-42375](https://nvd.nist.gov/vuln/detail/CVE-2021-42375){: external}, [CVE-2021-42378](https://nvd.nist.gov/vuln/detail/CVE-2021-42378){: external}, [CVE-2021-42379](https://nvd.nist.gov/vuln/detail/CVE-2021-42379){: external}, [CVE-2021-42380](https://nvd.nist.gov/vuln/detail/CVE-2021-42380){: external}, [CVE-2021-42381](https://nvd.nist.gov/vuln/detail/CVE-2021-42381){: external}, [CVE-2021-42382](https://nvd.nist.gov/vuln/detail/CVE-2021-42382){: external}, [CVE-2021-42383](https://nvd.nist.gov/vuln/detail/CVE-2021-42383){: external}, [CVE-2021-42384](https://nvd.nist.gov/vuln/detail/CVE-2021-42384){: external}, [CVE-2021-42385](https://nvd.nist.gov/vuln/detail/CVE-2021-42385){: external}, and [CVE-2021-42386](https://nvd.nist.gov/vuln/detail/CVE-2021-42386){: external}. |
{: caption="Changes since version 1.21.6_1539" caption-side="bottom"}





### Change log for worker node fix pack 1.21.7_1542, released 6 December 2021
{: #1217_1542}

The following table shows the changes that are in the worker node fix pack patch update `1.21.7_1542`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-162 | 4.15.0-163 | Updated worker node images and kernel with package updates. Contains fixes for [CVE-2021-43527](https://nvd.nist.gov/vuln/detail/CVE-2021-43527){: external} |
| Kubernetes | 1.21.6 | 1.21.7 | See the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.7){: external} | 
| Containerd | v1.5.7 | v1.5.8 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.8){: external} and the [security bulletin](https://www.ibm.com/support/pages/node/6524974){: external}  | 
{: caption="Changes since version 1.21.6_1540" caption-side="bottom"}





### Change log for worker node fix pack 1.21.6_1540, released 22 November 2021
{: #1216_1540}

The following table shows the changes that are in the worker node fix pack patch update `1.21.6_1540`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Kubernetes | 1.21.5 | 1.21.6 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.6){: external}. | 
| HA proxy | 07f1e9e | 3b8663 | Contains fixes for [CVE-2021-20231](https://nvd.nist.gov/vuln/detail/CVE-2021-20231){: external}, [CVE-2021-20232](https://nvd.nist.gov/vuln/detail/CVE-2021-20232){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}, [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2019-20838](https://nvd.nist.gov/vuln/detail/CVE-2019-20838){: external}, [CVE-2020-14155](https://nvd.nist.gov/vuln/detail/CVE-2020-14155){: external}, [CVE-2018-20673](https://nvd.nist.gov/vuln/detail/CVE-2018-20673){: external}, [CVE-2021-42574](https://nvd.nist.gov/vuln/detail/CVE-2021-42574){: external}, [CVE-2019-17594](https://nvd.nist.gov/vuln/detail/CVE-2019-17594){: external}, [CVE-2019-17595](https://nvd.nist.gov/vuln/detail/CVE-2019-17595){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-16135](https://nvd.nist.gov/vuln/detail/CVE-2020-16135){: external}, [CVE-2021-3445](https://nvd.nist.gov/vuln/detail/CVE-2021-3445){: external}, [CVE-2021-36084](https://nvd.nist.gov/vuln/detail/CVE-2021-36084){: external}, [CVE-2021-36085](https://nvd.nist.gov/vuln/detail/CVE-2021-36085){: external}, [CVE-2021-36086](https://nvd.nist.gov/vuln/detail/CVE-2021-36086){: external}, [CVE-2021-36087](https://nvd.nist.gov/vuln/detail/CVE-2021-36087){: external}, [CVE-2021-20266](https://nvd.nist.gov/vuln/detail/CVE-2021-20266){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-27645](https://nvd.nist.gov/vuln/detail/CVE-2021-27645){: external}, [CVE-2021-33574](https://nvd.nist.gov/vuln/detail/CVE-2021-33574){: external}, [CVE-2021-35942](https://nvd.nist.gov/vuln/detail/CVE-2021-35942){: external}, [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-19603](https://nvd.nist.gov/vuln/detail/CVE-2019-19603){: external}, [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}, [CVE-2020-13435](https://nvd.nist.gov/vuln/detail/CVE-2020-13435){: external}, [CVE-2020-24370](https://nvd.nist.gov/vuln/detail/CVE-2020-24370){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, [CVE-2021-3800](https://nvd.nist.gov/vuln/detail/CVE-2021-3800){: external}, [CVE-2021-33928](https://nvd.nist.gov/vuln/detail/CVE-2021-33928){: external}, [CVE-2021-33929](https://nvd.nist.gov/vuln/detail/CVE-2021-33929){: external}, [CVE-2021-33930](https://nvd.nist.gov/vuln/detail/CVE-2021-33930){: external}, [CVE-2021-33938](https://nvd.nist.gov/vuln/detail/CVE-2021-33938){: external}, and[CVE-2021-3200](https://nvd.nist.gov/vuln/detail/CVE-2021-3200){: external} |
| Ubuntu 18.04 packages | 4.15.0-161 | 4.15.0-162  | Updated worker node images and kernel with package fixes for[CVE-2019-19449](https://nvd.nist.gov/vuln/detail/CVE-2019-19449){: external}, [CVE-2020-36322](https://nvd.nist.gov/vuln/detail/CVE-2020-36322){: external}, [CVE-2020-36385](https://nvd.nist.gov/vuln/detail/CVE-2020-36385){: external}, [CVE-2021-28950](https://nvd.nist.gov/vuln/detail/CVE-2021-28950){: external}, [CVE-2021-3759](https://nvd.nist.gov/vuln/detail/CVE-2021-3759){: external}, [CVE-2021-38199](https://nvd.nist.gov/vuln/detail/CVE-2021-38199){: external}, [CVE-2021-3903](https://nvd.nist.gov/vuln/detail/CVE-2021-3903){: external}, [CVE-2021-3927](https://nvd.nist.gov/vuln/detail/CVE-2021-3927){: external}, and [CVE-2021-3928](https://nvd.nist.gov/vuln/detail/CVE-2021-3928){: external}. |
{: caption="Changes since version 1.21.5_1538" caption-side="bottom"}





### Change log for master fix pack 1.21.6_1539, released 17 November 2021
{: #1216_1539}

The following table shows the changes that are in the master fix pack update `1.21.5_1539`.  Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.16 | v1.2.18 | Updated `Go` module dependencies and to use `Go` version `1.16.9`.  Updated image for [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-33928](https://nvd.nist.gov/vuln/detail/CVE-2021-33928){: external}, [CVE-2021-33929](https://nvd.nist.gov/vuln/detail/CVE-2021-33929){: external} and [CVE-2021-33930](https://nvd.nist.gov/vuln/detail/CVE-2021-33930){: external}.  |
| etcd | v3.4.17 | v3.4.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.18){: external}. |
| Gateway-enabled cluster controller | 1510 | 1567 | Updated to use `Go` version `1.16.9`. |
| GPU device plug-in and installer | 58d7589 | 7fd867d | Updated image for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external} and [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.5-2 | v1.21.6-2 | Updated to support the Kubernetes `1.21.6` release and to use `Go` version `1.16.9`. Updated image for [DLA-2797-1](https://www.debian.org/lts/security/2021/dla-2797){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | e3cb629 | 4ca5637| Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Key Management Service provider | v2.3.8 | v2.3.10 | Updated `Go` module dependencies and to use `Go` version `1.16.9`.  Updated image for [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}. |
| Konnectivity agent | v0.0.24_262_iks | v0.0.24_268_iks | Update to use `Go` version `1.16.9`. |
| Konnectivity server | v0.0.24_262_iks | v0.0.24_268_iks | Update to use `Go` version `1.16.9`. |
| Kubernetes | v1.21.5 | v1.21.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1547 | 1590 | Updated to use `Go` version `1.16.9`. |
{: caption="Changes since version 1.21.5_1536" caption-side="bottom"}





### Change log for worker node fix pack 1.21.5_1538, released 10 November 2021
{: #1215_1538}

The following table shows the changes that are in the worker node fix pack patch update `1.21.5_1538`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image packages for [CVE-2020-16592](https://nvd.nist.gov/vuln/detail/CVE-2020-16592){: external}, [CVE-2020-27781](https://nvd.nist.gov/vuln/detail/CVE-2020-27781){: external}, [CVE-2021-25219](https://nvd.nist.gov/vuln/detail/CVE-2021-25219){: external}, [CVE-2021-3487](https://nvd.nist.gov/vuln/detail/CVE-2021-3487){: external}, [CVE-2021-3524](https://nvd.nist.gov/vuln/detail/CVE-2021-3524){: external}, [CVE-2021-3531](https://nvd.nist.gov/vuln/detail/CVE-2021-3531){: external}, and [CVE-2021-40490](https://nvd.nist.gov/vuln/detail/CVE-2021-40490){: external}. |
{: caption="Changes since version 1.21.5_1537" caption-side="bottom"}





### Change log for master fix pack 1.21.5_1536, released 29 October 2021
{: #1215_1536}

The following table shows the changes that are in the master fix pack update `1.21.5_1536`.  Master patch updates are applied automatically.
{: shortdesc}

 Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.15 | v1.2.16 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs:  [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, and [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}. |
| etcd | v3.4.16 | v3.4.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.17){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 763 | 864 | Updated to use `Go` version `1.16.9`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.5-1 | v1.21.5-2 | Updated to ignore VPC load balancer (LB) state when a LB delete is requested. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 400 | 401 | Updated universal base image (UBI) to the latest `8.4-210` version to resolve CVEs. |
| Key Management Service provider | v2.3.7 | v2.3.8 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs:  [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} |
| Konnectivity agent | v0.0.23_245_iks | v0.0.24_262_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.24){: external}.  Modified Konnectivity agent CPU and memory resource requests and memory resource limit and removed the CPU resource limit. |
| Konnectivity server | v0.0.23_245_iks | v0.0.24_262_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.24){: external}. |
{: caption="Changes since version 1.21.5_1531" caption-side="bottom"}





### Change log for worker node fix pack 1.21.5_1537, released 25 October 2021
{: #1215_1537}

The following table shows the changes that are in the worker node fix pack patch update `1.21.25_1537`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates. Contains fix for cloud-init performance problem. |
| Worker-pool taint automation | N/A | N/A | Fixes known issue related to worker-pool taint automation that prevents workers from getting providerID. | 
{: caption="Changes since version 1.21.5_1533" caption-side="bottom"}





### Change log for worker node fix pack 1.21.5_1533, released 11 October 2021
{: #1215_1533}

The following table shows the changes that are in the worker node fix pack patch update `1.21.5_1533`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Containerd | v1.5.5 | v1.5.7 | See the [security bulletin](https://www.ibm.com/support/pages/node/6501867){: external} and the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.7){: external}. |
| Ubuntu 18.04 packages | 4.15.0-158 | 4.15.0-159 | Updated worker node images and kernel with package updates [CVE-2021-3778](https://nvd.nist.gov/vuln/detail/CVE-2021-3778){: external} and [CVE-2021-3796](https://nvd.nist.gov/vuln/detail/CVE-2021-3796){: external}. |
{: caption="Changes since version 1.21.5_1532" caption-side="bottom"}





### Change log for master fix pack 1.21.5_1531, released 28 September 2021
{: #1215_1531}

The following table shows the changes that are in the master fix pack patch update `1.21.5_1531`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.19.1 | v3.19.3 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. Increased liveness and readiness probe timeouts to 10 seconds. |
| Gateway-enabled cluster controller | 1444 | 1510 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| GPU device plug-in and installer | 8c8bcdf | 58d7589 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.4-1 | v1.21.5-1 | Updated to support the Kubernetes `1.21.5` release and to use `Go` version `1.16.8` and calicoctl version `3.19.3`. Fixed a bug that may cause node initialization to fail when a new node reuses the name of a deleted node. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 398 | 400 | Updated to use `Go` version `1.16.7`. Updated universal base image (UBI) to the latest `8.4-208` version to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 945df65 | e3cb629 | Updated to use `Go` version `1.16.7`. |
| Konnectivity agent | v0.0.21e_231_iks | v0.0.23_245_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.23){: external}. |
| Konnectivity server | v0.0.21e_231_iks | v0.0.23_245_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.23){: external}. |
| Kubernetes | v1.21.4 | v1.21.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.5){: external}. |
| Kubernetes API server auditing configuration | N/A | N/A| Updated to support `verbose` [Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| Kubernetes NodeLocal DNS cache | N/A | N/A | Increased memory resource requests from `5Mi` to `8Mi` to better align with normal resource utilization. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1510 | 1547 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-12 | 0.16.1-IKS-14 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
{: caption="Changes since version 1.21.4_1528" caption-side="bottom"}





### Change log for worker node fix pack 1.21.5_1532, released 27 September 2021
{: #1215_1532}

The following table shows the changes that are in the worker node fix pack patch update `1.21.5_1532`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Disk identification | N/A | N/A | Enhanced the disk identification logic to handle the case of 2+ partitions. |
| HA proxy | 9c98dc5 | 07f1e9 | Updated image with fixes for [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}, [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, and [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}. |
| Kubernetes | 1.21.4 | 1.21.5 | See the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.5){: external}. This update resolves [CVE-2021-25741](https://nvd.nist.gov/vuln/detail/CVE-2021-25741){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6496649){: external}). |
| Ubuntu 18.04 packages | 4.15.0-156 | 4.15.0-158 | Updated worker node images and kernel with package updates [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2021-3709](https://nvd.nist.gov/vuln/detail/CVE-2021-3709){: external}, [CVE-2021-3710](https://nvd.nist.gov/vuln/detail/CVE-2021-3710){: external}, [CVE-2021-40330](https://nvd.nist.gov/vuln/detail/CVE-2021-40330){: external}, [CVE-2021-40528](https://nvd.nist.gov/vuln/detail/CVE-2021-40528){: external}, and [CVE-2021-41072](https://nvd.nist.gov/vuln/detail/CVE-2021-41072){: external}. | 
{: caption="Changes since version 1.21.4_1530" caption-side="bottom"}





### Change log for worker node fix pack 1.21.4_1530, released 13 September 2021
{: #12104_1530}

The following table shows the changes that are in the worker node fix pack patch update `1.21.4_1530`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-154 | 4.15.0-156 | Updated worker node images and kernel with package updates for [CVE-2021-3653](https://nvd.nist.gov/vuln/detail/CVE-2021-3653){: external}, [CVE-2021-3656](https://nvd.nist.gov/vuln/detail/CVE-2021-3656){: external}, [CVE-2021-38185](https://nvd.nist.gov/vuln/detail/CVE-2021-38185){: external} , and [CVE-2021-40153](https://nvd.nist.gov/vuln/detail/CVE-2021-40153){: external}. | 
{: caption="Changes since version 1.21.2_1529" caption-side="bottom"}





### Change log for worker node fix pack 1.21.4_1529, released 30 August 2021
{: #12104_1529}

The following table shows the changes that are in the worker node fix pack patch update `1.21.4_1529`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-153 | 4.15.0-154 | Updated worker node images and kernel with package updates for [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external} and [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}. |
{: caption="Changes since version 1.21.2_1524" caption-side="bottom"}





### Change log for master fix pack 1.21.4_1528, released 25 August 2021
{: #1214_1528}

The following table shows the changes that are in the master fix pack patch update `1.21.4_1528`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Updated the rolling update configuration for the `calico-node` daemonset in the `kube-system` namespace. The configuration is now the same regardless of the number of cluster worker nodes. |
| Cluster health image | v1.2.14 | v1.2.15 | Updated to use `Go` version `1.15.15`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| CoreDNS | 1.8.0 | 1.8.4 | See the [CoreDNS release notes](https://coredns.io/2021/05/28/coredns-1.8.4-release/){: external}. |
| Gateway-enabled cluster controller | 1348 | 1444 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
| GPU device plug-in and installer | 483ccc2 | 8c8bcdf | Updated to use `Go` version `1.16.6`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 747 | 763 | Updated to use `Go` version `1.16.6`. Updated UBI to the latest `8.4-205` version to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.3-2 | v1.21.4-1 | Updated to support the Kubernetes `1.21.4` release and to use `Go` version `1.16.7` and calicoctl version `3.19.2`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 395 | 398 | Updated to use `Go` version `1.16.6`. Updated image for [CVE-2021-33910](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33910){: external}. |
| Key Management Service provider | v2.3.6 | v2.3.7 | Updated to use `Go` version `1.15.15`. Updated UBI to the latest `8.4` version to resolve CVEs. |
| Kubernetes | v1.21.3 | v1.21.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.4){: external}. |
| Kubernetes Dashboard | v2.2.0 | v2.3.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.3.1){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.6 | v1.0.7 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.7){: external}. |
| Kubernetes DNS autoscaler | 1.8.3 | 1.8.4 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1328 | 1510 | Updated image for [CVE-2020-27780](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27780){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-10 | 0.16.1-IKS-12 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
{: caption="Changes since version 1.21.3_1525" caption-side="bottom"}





### Change log for worker node fix pack 1.21.3_1527, released 16 August 2021
{: #1213_1527}

The following table shows the changes that are in the worker node fix pack patch update `1.21.3_1527`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-151 | 4.15.0-153 | N/A |
| HA proxy | 68e6b3 | 9c98dc | Updated image with fixes for [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}. |
{: caption="Changes since version 1.21.3_1526" caption-side="bottom"}





### Change log for worker node fix pack 1.21.3_1526, released 02 August 2021
{: #1213_1526}

The following table shows the changes that are in the worker node fix pack patch update `1.21.3_1526`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-147 | 4.15.0-151 | Updated worker node images & Kernel with package updates: [CVE-2020-13529](https://nvd.nist.gov/vuln/detail/CVE-2020-13529){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2021-33200](https://nvd.nist.gov/vuln/detail/CVE-2021-33200){: external}, [CVE-2021-33909](https://nvd.nist.gov/vuln/detail/CVE-2021-33909){: external}, and [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| HA proxy | aae810 | 68e6b3 | Updated image with fixes for [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| Registry endpoints | N/A | N/A | Added zonal public registry endpoints for clusters with both private and public service endpoints enabled. |
| Read only disk self healing | N/A | N/A | For VPC Gen2 workers. Added automation to recover from disks going read only. |
| Containerd | v1.5.2 | v1.5.4 | See [change logs](https://github.com/containerd/containerd/releases/tag/v1.5.4){: external}. The update resolves CVE-2021-32760 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6478995){: external}).  |
| Kubernetes | v1.21.2 | v1.21.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.3){: external}. |
{: caption="Changes since version 1.21.2_1524" caption-side="bottom"}





### Change log for master fix pack 1.21.3_1525, released 27 July 2021
{: #1213_1525}

The following table shows the changes that are in the master fix pack patch update `1.21.3_1525`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.13 | v1.2.14 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
| etcd | v3.4.14 | v3.4.16 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.16){: external}. |
| GPU device plug-in and installer | 772e15f | 483ccc2 | Updated image for [CVE-2021-20271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20271){: external}, [CVE-2021-3516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3516){: external}, [CVE-2021-3517](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3517){: external}, [CVE-2021-3518](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3518){: external}, [CVE-2021-3537](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3537){: external}, [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: external}, and [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 730 | 747 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.2-2 | v1.21.3-2 | Updated to support the Kubernetes `1.21.3` release and to use Go version `1.16.6` and calicoctl version `3.19.1`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 394 | 395 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | b68ea92 | 945df65 | Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Key Management Service provider | v2.3.5 | v2.3.6 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
| Konnectivity agent | v0.0.19e_206_iks | v0.0.21e_231_iks | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| Konnectivity server | v0.0.19e_206_iks | v0.0.21e_231_iks | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| Kubernetes | v1.21.2 | v1.21.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.3){: external}. |
{: caption="Changes since version 1.21.2_1522" caption-side="bottom"}





### Change log for worker node fix pack 1.21.2_1524, released 19 July 2021
{: #1212_1524}

The following table shows the changes that are in the worker node fix pack `1.21.2_1524`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with kernel package updates. |
| Ubuntu 18.04 packages | N/A | N/A| Updated worker node images with kernel package updates. | 
{: caption="Changes since version 1.21.2_1523" caption-side="bottom"}





### Change log for worker node fix pack 1.21.2_1523, released 6 July 2021
{: #1212_1523}

The following table shows the changes that are in the worker node fix pack `1.21.2_1523`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 700dc6 | aae810 | Updated image with fixes for [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}, [CVE-2021-20271](https://nvd.nist.gov/vuln/detail/CVE-2021-20271){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external}, [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, and [CVE-2021-3541](https://nvd.nist.gov/vuln/detail/CVE-2021-3541){: external}. |
| Kubernetes | v1.21.1 | v1.21.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.2){: external}. |
| Ubuntu 18.04 packages | 4.15.0.144 | 4.15.0.147 | Updated worker node images with kernel package updates for [CVE-2021-23133](https://nvd.nist.gov/vuln/detail/CVE-2021-23133){: external}, [CVE-2021-3444](https://nvd.nist.gov/vuln/detail/CVE-2021-3444){: external}, and [CVE-2021-3600](https://nvd.nist.gov/vuln/detail/CVE-2021-3600){: external}. |
{: caption="Changes since version 1.21.1_1521" caption-side="bottom"}





### Change log for master fix pack 1.21.2_1522, released 28 June 2021
{: #1212_1522}

The following table shows the changes that are in the master fix pack patch update `1.21.2_1522`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.12 | v1.2.13 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| GPU device plug-in and installer | c7b87b1 | 772e15f | Updated image for [CVE-2021-27219](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27219){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 695 | 730 | Updated to use `Go` version `1.16.15`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.21.1-4 | v1.21.2-2 | Updated to support the Kubernetes `1.21.2` release and to use `Go` version `1.16.5`. Updated `Go` dependencies to resolve CVEs. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 393 | 394 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external} and [CVE-2021-27219](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27219){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | cfd8ae9 | b68ea92 | Updated image for [CVE-2021-27219](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27219){: external}. |
| Key Management Service provider | v2.3.4 | v2.3.5 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Konnectivity agent | v0.0.19e_201_iks | v0.0.19e_206_iks | Updated image for [CVE-2021-27219](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27219){: external}. |
| Konnectivity server | v0.0.19e_201_iks | v0.0.19e_206_iks | Updated image for [CVE-2021-27219](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27219){: external}. |
| Kubernetes | v1.21.1 | v1.21.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.2){: external}. |
| Portieris admission controller | v0.10.2 | v0.10.3 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.3){: external}. |
{: caption="Changes since version 1.21.1_1519" caption-side="bottom"}





### Change log for worker node fix pack 1.21.1_1521, released 22 June 2021
{: #1211_1521}

The following table shows the changes that are in the worker node fix pack `1.21.1_1521`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | d3dc33 | Updated image with fixes for [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2017-14502](https://nvd.nist.gov/vuln/detail/CVE-2017-14502){: external}, [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external} and [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}.|
| {{site.data.keyword.registrylong_notm}} | N/A | N/A | Added private-only registry support for `ca.icr.io`, `br.icr.io` and `jp2.icr.io`. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2017-8779](https://nvd.nist.gov/vuln/detail/CVE-2017-8779){: external}, [CVE-2017-8872](https://nvd.nist.gov/vuln/detail/CVE-2017-8872){: external}, [CVE-2018-16869](https://nvd.nist.gov/vuln/detail/CVE-2018-16869){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external} [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}.|
{: caption="Changes since version 1.21.1_1520" caption-side="bottom"}





### Change log for worker node fix pack 1.21.1_1520, released 9 June 2021
{: #1211_1520}

The following table shows the changes that are in the worker node fix pack `1.21.1_1520`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.4.6 | v1.5.2 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.5.2){: external}. |
| HA proxy | 26c5cc | 700dc6 | Updated the image for [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}.|
| Kubernetes | 1.20.7 | 1.21.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.1){: external}. |
| TCP `keepalive` optimization for VPC | N/A | N/A | Set the `net.ipv4.tcp_keepalive_time` setting to 180 seconds for compatibility with VPC gateways. |
| Ubuntu 18.04 packages | 4.15.0-143 | 4.15.0-144 | Updated worker node images with kernel package updates for [CVE-2021-25217](https://nvd.nist.gov/vuln/detail/CVE-2021-25217){: external}, [CVE-2021-31535](https://nvd.nist.gov/vuln/detail/CVE-2021-31535){: external}, [CVE-2021-32547](https://nvd.nist.gov/vuln/detail/CVE-2021-32547){: external}, [CVE-2021-32552](https://nvd.nist.gov/vuln/detail/CVE-2021-32552){: external}, [CVE-2021-32556](https://nvd.nist.gov/vuln/detail/CVE-2021-32556){: external}, [CVE-2021-32557](https://nvd.nist.gov/vuln/detail/CVE-2021-32557){: external}, [CVE-2021-3448](https://nvd.nist.gov/vuln/detail/CVE-2021-3448){: external}, and [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}.|
{: caption="Changes since version 1.20.7_1542" caption-side="bottom"}





### Change log for master fix pack 1.21.1_1519 released 9 June 2021
{: #1211_1519_new}

The following table shows the changes that are in the master fix pack patch update `1.21.1_1519`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.17.3 | v3.19.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| Gateway-enabled cluster controller | 1352 | 1348 | Updated to run as a non-root user by default, with privileged escalation as needed. |
| GPU device plug-in and installer | 9a5e70b | c7b87b1 | Updated to use Go version `1.15.12`. Updated universal base image (UBI) to version 8.4 to resolve CVEs. Updated the GPU drivers to version [460.73.01](https://www.nvidia.com/Download/driverResults.aspx/173142/){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 689 | 695 | Updated UBI minimal base image to version 8.4 to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.7-3 | v1.21.1-4 | Updated to support the Kubernetes 1.21.1 release and to use `Go` version 1.16.4 and `calicoctl` version 3.19.0. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 392 | 393 | Updated UBI  to version 8.4 to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 63cd064 | cfd8ae9 | Updated to use `Go` version 1.16.4. Updated UBI  to version 8.4 to resolve CVEs. |
| Konnectivity agent | N/A | v0.0.19e_201_iks | [Konnectivity](https://kubernetes.io/docs/tasks/extend-kubernetes/setup-konnectivity/){: external} replaces OpenVPN as the network proxy that is used to secure the communication of the Kubernetes API server master to worker nodes in the cluster. See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.19){: external}. |
| Konnectivity server | N/A | v0.0.19e_201_iks | [Konnectivity](https://kubernetes.io/docs/tasks/extend-kubernetes/setup-konnectivity/){: external} replaces OpenVPN as the network proxy that is used to secure the communication of the Kubernetes API server master to worker nodes in the cluster. See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.19){: external}. |
| Kubernetes | v1.20.7 | v1.21.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.21.1){: external}. |
| Kubernetes admission controllers configuration | N/A | N/A | Added `DenyServiceExternalIPs` to the `--enable-admission-plugins` option for the cluster's [Kubernetes API server](/docs/containers?topic=containers-service-settings#kube-apiserver). The update resolves CVE-2020-8554 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6428013){: external}). |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates). |
| Kubernetes add-on resizer | 1.8.12 | 1.8.13 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.13){: external}. |
| Kubernetes Dashboard | v2.1.0 | v2.2.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.2.0){: external}. |
| Pause container image | 3.2 | 3.5 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: caption="Changes since version 1.20.7_1540" caption-side="bottom"}
