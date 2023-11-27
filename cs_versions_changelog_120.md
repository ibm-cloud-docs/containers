---

copyright:
 years: 2014, 2023
lastupdated: "2023-11-27"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch, 1.20

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Kubernetes version 1.20 change log
{: #changelog_120}

Version 1.20 is unsupported. You can review the following archive of 1.20 change logs.
{: shortdesc}

## Overview
{: #changelog_overview_120}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.20 change log
{: #120_changelog}


Kubernetes version 1.20 is unsupported as of 19 June 2022. Update your cluster to at least [version 1.21](/docs/containers?topic=containers-cs_versions_121) as soon as possible.
{: important}









### Change log for worker node fix pack 1.20.15_1583, released 7 June 2022
{: #12015_1583}

The following table shows the changes that are in the worker node fix pack 1.20.15_1583. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-177 | 4.15.0-180 | Worker node kernel & package updates for [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2022-1664](https://nvd.nist.gov/vuln/detail/CVE-2022-1664){: external}, [CVE-2022-29581](https://nvd.nist.gov/vuln/detail/CVE-2022-29581){: external}. |
{: caption="Changes since version 1.20.15_1581" caption-side="bottom"}

### Change log for master fix pack 1.20.15_1582, released 3 June 2022
{: #12015_1582}

The following table shows the changes that are in the master fix pack 1.20.15_1582. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.6 | v1.3.7 | Updated Go to version 1.17.10 and also updated the dependencies. Update registry base image version to `104` |
| GPU device plug-in and installer | 9485e14 | 382ada9 | Updated `Go` to version `1.17.9` |
| {{site.data.keyword.IBM_notm}} Calico extension | 954 | 980 | Updated to use `Go` version `1.17.10`. Updated minimal UBI to version `8.5`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.15-9 | v1.20.15-11 | Build changes for new key. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 408 | 410 | Updated universal base image (UBI) to version `8.6-751` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8c8c82b | 8c96932 | Updated `Go` to version `1.18.1` |
| Key Management Service provider | v2.5.4 | v2.5.5 | Updated `Go` to version `1.17.10` and updated the golang dependencies. |
| Kubernetes add-on resizer | 1.8.13 | 1.8.14 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.14){: external}. |
| Kubernetes Dashboard | v2.3.1 | v2.3.1 | The **default** Kubernetes Dashboard settings found in the `kubernetes-dashboard-settings` config map in the `kube-system` namespace have been updated to set `resourceAutoRefreshTimeInterval` to `60`. This default change is only applied to new clusters. The previous default value was `5`. If your cluster has Kubernetes Dashboard performance problems, see the steps for [changing the auto refresh time interval](/docs/containers?topic=containers-ts-kube-dashboord-oom). | 
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1916 | 1998 | Updated `Go` to version `1.17.10` and updated dependencies. |
{: caption="Changes since version 1.20.15_1578" caption-side="bottom"}

### Change log for worker node fix pack 1.20.15_1581, released 23 May 2022
{: #12015_1581}

The following table shows the changes that are in the worker node fix pack 1.20.15_1581. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-176 | 4.15.0-177 | Worker node kernel & package updates for [CVE-2019-20838](https://nvd.nist.gov/vuln/detail/CVE-2019-20838){: external}, [CVE-2020-14155](https://nvd.nist.gov/vuln/detail/CVE-2020-14155){: external}, [CVE-2020-25648](https://nvd.nist.gov/vuln/detail/CVE-2020-25648){: external}, [CVE-2020-35512](https://nvd.nist.gov/vuln/detail/CVE-2020-35512){: external}, [CVE-2021-26401](https://nvd.nist.gov/vuln/detail/CVE-2021-26401){: external}, [CVE-2022-0001](https://nvd.nist.gov/vuln/detail/CVE-2022-0001){: external}, [CVE-2022-0934](https://nvd.nist.gov/vuln/detail/CVE-2022-0934){: external}, [CVE-2022-26490](https://nvd.nist.gov/vuln/detail/CVE-2022-26490){: external}, [CVE-2022-27223](https://nvd.nist.gov/vuln/detail/CVE-2022-27223){: external}, [CVE-2022-27781](https://nvd.nist.gov/vuln/detail/CVE-2022-27781){: external}, [CVE-2022-27782](https://nvd.nist.gov/vuln/detail/CVE-2022-27782){: external}, [CVE-2022-28657](https://nvd.nist.gov/vuln/detail/CVE-2022-28657){: external}, [CVE-2022-29155](https://nvd.nist.gov/vuln/detail/CVE-2022-29155){: external}, [CVE-2022-29824](https://nvd.nist.gov/vuln/detail/CVE-2022-29824){: external}, [CVE-2017-9525](https://nvd.nist.gov/vuln/detail/CVE-2017-9525){: external}, [CVE-2022-28654](https://nvd.nist.gov/vuln/detail/CVE-2022-28654){: external}, [CVE-2022-28656](https://nvd.nist.gov/vuln/detail/CVE-2022-28656){: external}, [CVE-2022-28655](https://nvd.nist.gov/vuln/detail/CVE-2022-28655){: external}, [CVE-2022-28652](https://nvd.nist.gov/vuln/detail/CVE-2022-28652){: external}, [CVE-2022-1242](https://nvd.nist.gov/vuln/detail/CVE-2022-1242){: external}, [CVE-2022-28658](https://nvd.nist.gov/vuln/detail/CVE-2022-28658){: external}, [CVE-2021-3899](https://nvd.nist.gov/vuln/detail/CVE-2021-3899){: external}. |
| HA proxy | 36b0307 | 468c09 | [CVE-2021-3634](https://nvd.nist.gov/vuln/detail/CVE-2021-3634){: external}. | 
{: caption="Changes since version 1.20.15_1580" caption-side="bottom"}

### Change log for worker node fix pack 1.20.15_1580, released 09 May 2022
{: #12015_1580}

The following table shows the changes that are in the worker node fix pack 1.20.15_1580. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2021-36084](https://nvd.nist.gov/vuln/detail/CVE-2021-36084){: external}, [CVE-2021-36085](https://nvd.nist.gov/vuln/detail/CVE-2021-36085){: external}, [CVE-2021-36086](https://nvd.nist.gov/vuln/detail/CVE-2021-36086){: external}, [CVE-2021-36087](https://nvd.nist.gov/vuln/detail/CVE-2021-36087){: external}, [CVE-2022-1292](https://nvd.nist.gov/vuln/detail/CVE-2022-1292){: external}, [CVE-2022-22576](https://nvd.nist.gov/vuln/detail/CVE-2022-22576){: external}, [CVE-2022-27774](https://nvd.nist.gov/vuln/detail/CVE-2022-27774){: external}, [CVE-2022-27775](https://nvd.nist.gov/vuln/detail/CVE-2022-27775){: external}, [CVE-2022-27776](https://nvd.nist.gov/vuln/detail/CVE-2022-27776){: external}, [CVE-2022-29799](https://nvd.nist.gov/vuln/detail/CVE-2022-29799){: external}, [CVE-2022-29800](https://nvd.nist.gov/vuln/detail/CVE-2022-29800){: external}. |
| Kubernetes | N/A | N/A | N/A |
| Haproxy | f53b22 | 36b030 | [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}, [CVE-2022-1154](https://nvd.nist.gov/vuln/detail/CVE-2022-1154){: external}, [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032){: external}. |
{: caption="Changes since version 1.20.15_1579" caption-side="bottom"}

### Change log for master fix pack 1.20.15_1578, released 26 April 2022
{: #12015_1578}

The following table shows the changes that are in the master fix pack 1.20.15_1578. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.5 | v1.3.6 | Updated `Go` to version `1.17.9` and also updated the dependencies. Update `registry base image` version to `103`. |
| Gateway-enabled cluster controller | 1669 | 1680 | Updated metadata for a rotated key. |
| GPU device plug-in and installer | 13677d2 | 9485e14 | Updated Drivers to `470.103.01`. Updated metadata for a rotated key. |
| {{site.data.keyword.IBM_notm}} Calico extension | 950 | 954 | Updated to latest UBI-minimal image to resolve [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}, [CVE-2022-23308](https://nvd.nist.gov/vuln/detail/CVE-2022-23308){: external}, [CVE-2021-23177](https://nvd.nist.gov/vuln/detail/CVE-2021-23177){: external}, and [CVE-2021-31566](https://nvd.nist.gov/vuln/detail/CVE-2021-31566){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.15-6 | v1.20.15-9 | Updated `vpcctl` to the `3003` binary image. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 407 | 408 | Fixed [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 6c43ef1 | 8c8c82b | Updated `Go` to version `1.17.8` |
| Key Management Service provider | v2.5.3 | v2.5.4 | Moved to a different base image, version `102`, to reduce CVE footprint. Resolved [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.3 | 1.21.4 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.21.4){: external}. |
| Load balancer and Load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1899 | 1916 | Updated the image to resolve CVEs. |
| OpenVPN client | 2.5.4-r0-IKS-579 | 2.5.6-r0-IKS-592 | Upgrade openvpn to version `2.5.6-r0`. |
| OpenVPN server | 2.5.4-r0-IKS-578 | 2.5.6-r0-IKS-591 | Upgrade openvpn to version `2.5.6-r0`. |
{: caption="Changes since version 1.20.15_1576" caption-side="bottom"}



### Change log for worker node fix pack 1.20.15_1579, released 25 April 2022
{: #12015_1579}




| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-175-generic | 4.15.0-176-generic | Kernel and package updates for [CVE-2018-16301](https://nvd.nist.gov/vuln/detail/CVE-2018-16301){: external}, [CVE-2019-18276](https://nvd.nist.gov/vuln/detail/CVE-2019-18276){: external}, [CVE-2020-8037](https://nvd.nist.gov/vuln/detail/CVE-2020-8037){: external}, [CVE-2021-31870](https://nvd.nist.gov/vuln/detail/CVE-2021-31870){: external}, [CVE-2021-31871](https://nvd.nist.gov/vuln/detail/CVE-2021-31871){: external}, [CVE-2021-31872](https://nvd.nist.gov/vuln/detail/CVE-2021-31872){: external}, [CVE-2021-31873](https://nvd.nist.gov/vuln/detail/CVE-2021-31873){: external}, [CVE-2021-43975](https://nvd.nist.gov/vuln/detail/CVE-2021-43975){: external}, [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}, [CVE-2022-24765](https://nvd.nist.gov/vuln/detail/CVE-2022-24765){: external}. |
{: caption="Changes since version 1.20.15_1577" caption-side="bottom"}





### Change log for worker node fix pack 1.20.15_1577, released 11 April 2022
{: #12015_1577}

The following table shows the changes that are in the worker node fix pack 1.20.15_1577. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-173-generic | 4.15.0-175-generic | Kernel and package updates for [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032) [CVE-2021-3426](https://nvd.nist.gov/vuln/detail/CVE-2021-3426) [CVE-2021-4189](https://nvd.nist.gov/vuln/detail/CVE-2021-4189) [CVE-2022-0391](https://nvd.nist.gov/vuln/detail/CVE-2022-0391) [CVE-2022-21712](https://nvd.nist.gov/vuln/detail/CVE-2022-21712) [CVE-2022-21716](https://nvd.nist.gov/vuln/detail/CVE-2022-21716) [CVE-2022-25308](https://nvd.nist.gov/vuln/detail/CVE-2022-25308) [CVE-2022-25309](https://nvd.nist.gov/vuln/detail/CVE-2022-25309) [CVE-2022-25310](https://nvd.nist.gov/vuln/detail/CVE-2022-25310) [CVE-2022-27666](https://nvd.nist.gov/vuln/detail/CVE-2022-27666). | 
{: caption="Changes since version 1.20.15_1575" caption-side="bottom"}





### Change log for master fix pack 1.20.15_1576, released 6 April 2022
{: #12015_1576}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1865 | 1899 | Revert setting gratuitous ARP on LBv1. |
{: caption="Changes since version 1.20.15_1574" caption-side="bottom"}







### Change log for master fix pack 1.20.15_1574, released 30 March 2022
{: #12015_1574}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.3 | v1.3.5 | Updated image to fix CVEs [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}.  Updated golang dependencies. |
| Gateway-enabled cluster controller | 1653 | 1669 | Updated to use `Go` version `1.17.8`. |
| GPU device plug-in and installer | d7daae6 | 13677d2 | Updated GPU images to resolve CVEs. |
| IBM Calico extension | 929 | 950 | Updated to use `Go` version `1.17.8`. Updated universal base image (UBI) to resolve CVEs. |
| IBM Cloud {{site.data.keyword.filestorage_short}} plug-in and monitor | 405 | 407 | Updated `Go` to version `1.16.14`.  Updated `UBI` image to version `8.5-240`. |
| IBM Cloud RBAC Operator | 0fc9949 | 6c43ef1 | Upgraded `Go` packages to resolve vulnerabilities |
| Key Management Service provider | v2.4.3 | v2.5.3 | Updated to use `Go` version `1.17.8`. Updated golang dependencies.  Fixed CVE [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external} |
| Load balancer and Load balancer monitor for IBM Cloud Provider | 1747 | 1865 | Updated the image to resolve CVEs. Updated to use `Go` version `1.17.8`. Set gratuitous ARP at the correct time on LBv1. |
| OpenVPN client | 2.5.4-r0-IKS-556 | 2.5.4-r0-IKS-579 | Updated `Go` to version `1.16.15`. |
| OpenVPN server | 2.5.4-r0-IKS-555 | 2.5.4-r0-IKS-578 | Updated `Go` to version `1.16.15`. |
| Operator Lifecycle Manager | 0.16.1-IKS-15 | 0.16.1-IKS-16 | Resolve [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}. |
{: caption="Changes since version 1.20.15_1571" caption-side="bottom"}





### Change log for worker node fix pack 1.20.15_1575, released 28 March 2022
{: #12015_1575}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-171-generic | 4.15.0-173-generic | Kernel and package updates for [CVE-2021-20193](https://nvd.nist.gov/vuln/detail/CVE-2021-20193){: external}, [CVE-2021-25220](https://nvd.nist.gov/vuln/detail/CVE-2021-25220){: external}, [CVE-2021-3506](https://nvd.nist.gov/vuln/detail/CVE-2021-3506){: external}, [CVE-2022-0435](https://nvd.nist.gov/vuln/detail/CVE-2022-0435){: external}, [CVE-2022-0492](https://nvd.nist.gov/vuln/detail/CVE-2022-0492){: external}, [CVE-2022-0778](https://nvd.nist.gov/vuln/detail/CVE-2022-0778){: external}, [CVE-2022-0847](https://nvd.nist.gov/vuln/detail/CVE-2022-0847){: external}, [CVE-2022-23308](https://nvd.nist.gov/vuln/detail/CVE-2022-23308){: external}. |
| HA proxy | 15198f | b40c07 | [CVE-2021-45960](https://nvd.nist.gov/vuln/detail/CVE-2021-45960){: external}, [CVE-2021-46143](https://nvd.nist.gov/vuln/detail/CVE-2021-46143){: external}, [CVE-2022-22822](https://nvd.nist.gov/vuln/detail/CVE-2022-22822){: external}, [CVE-2022-22823](https://nvd.nist.gov/vuln/detail/CVE-2022-22823){: external}, [CVE-2022-22824](https://nvd.nist.gov/vuln/detail/CVE-2022-22824){: external}, [CVE-2022-22825](https://nvd.nist.gov/vuln/detail/CVE-2022-22825){: external}, [CVE-2022-22826](https://nvd.nist.gov/vuln/detail/CVE-2022-22826){: external}, [CVE-2022-22827](https://nvd.nist.gov/vuln/detail/CVE-2022-22827){: external}, [CVE-2022-23852](https://nvd.nist.gov/vuln/detail/CVE-2022-23852){: external}, [CVE-2022-25235](https://nvd.nist.gov/vuln/detail/CVE-2022-25235){: external}, [CVE-2022-25236](https://nvd.nist.gov/vuln/detail/CVE-2022-25236){: external}, [CVE-2022-25315](https://nvd.nist.gov/vuln/detail/CVE-2022-25315){: external}, [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}, [CVE-2022-23308](https://nvd.nist.gov/vuln/detail/CVE-2022-23308){: external}, [CVE-2021-23177](https://nvd.nist.gov/vuln/detail/CVE-2021-23177){: external}, [CVE-2021-31566](https://nvd.nist.gov/vuln/detail/CVE-2021-31566){: external}. |
| Kubernetes | N/A | N/A | N/A |
{: caption="Changes since version 1.20.15_1573" caption-side="bottom"}





### Change log for worker node fix pack 1.20.15_1573, released 14 March 2022
{: #12015_1573}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Containerd | v1.4.12 | v1.4.13 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.4.13){: external} and the [security bulletin](https://www.ibm.com/support/pages/node/6564653){: external}. |
| Ubuntu 18.04 packages | 4.15.0-169-generic | 4.15.0-171-generic | Kernel and package updates for [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2020-29562](https://nvd.nist.gov/vuln/detail/CVE-2020-29562){: external}, [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2021-35942](https://nvd.nist.gov/vuln/detail/CVE-2021-35942){: external}, [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-0001](https://nvd.nist.gov/vuln/detail/CVE-2022-0001){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}, [CVE-2022-25313](https://nvd.nist.gov/vuln/detail/CVE-2022-25313){: external}, [CVE-2022-25314](https://nvd.nist.gov/vuln/detail/CVE-2022-25314){: external}, [CVE-2022-25315](https://nvd.nist.gov/vuln/detail/CVE-2022-25315){: external}. |
{: caption="Changes since version 1.20.15_1572" caption-side="bottom"}





### Change log for master fix pack 1.20.15_1571, released 3 March 2022
{: #12015_1571}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.21 | v1.3.3 | Updated `golang.org/x/crypto` to `v0.0.0-20220214200702-86341886e292`. Adds fix for [CVE-2021-43565](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-43565){: external}. Adds Golang dependency updates. |
| Gateway-enabled cluster controller | 1586 | 1653 | Updated to use `Go` version `1.17.7` and updated `Go` modules to fix CVEs. |
| GPU device plug-in and installer | eefc4ae | d7daae6 | Updated GPU images to resolve CVEs. |
| IBM Calico extension | 923 | 929 | Updated universal base image (UBI) to the `8.5-230` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| IBM Cloud Controller Manager | v1.20.15-1 | v1.20.15-4 | Adds changes to the renovate rules. |
| IBM Cloud {{site.data.keyword.filestorage_short}} plug-in and monitor | 404 | 405 | Fix for [CVE-2021-3538](https://nvd.nist.gov/vuln/detail/CVE-2021-3538){: external} and adds dependency updates. |
| Key Management Service provider | v2.3.13 | v2.4.3 | Updated `golang.org/x/crypto` to `v0.0.0-20220214200702-86341886e292`. Adds fix for [CVE-2021-43565](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-43565){: external}. Adds Golang dependency updates. |
{: caption="Changes since version 1.20.15_1568" caption-side="bottom"}





### Change log for worker node fix pack 1.20.15_1572, released 28 February 2022
{: #12015_1572}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-167-generic | 4.15.0-169-generic | Kernel and package updates for [CVE-2021-4083](https://nvd.nist.gov/vuln/detail/CVE-2021-4083){: external}, [CVE-2021-4155](https://nvd.nist.gov/vuln/detail/CVE-2021-4155){: external}, [CVE-2021-45960](https://nvd.nist.gov/vuln/detail/CVE-2021-45960){: external}, [CVE-2021-46143](https://nvd.nist.gov/vuln/detail/CVE-2021-46143){: external}, [CVE-2022-0330](https://nvd.nist.gov/vuln/detail/CVE-2022-0330){: external}, [CVE-2022-22822](https://nvd.nist.gov/vuln/detail/CVE-2022-22822){: external}, [CVE-2022-22823](https://nvd.nist.gov/vuln/detail/CVE-2022-22823){: external}, [CVE-2022-22824](https://nvd.nist.gov/vuln/detail/CVE-2022-22824){: external}, [CVE-2022-22825](https://nvd.nist.gov/vuln/detail/CVE-2022-22825){: external}, [CVE-2022-22826](https://nvd.nist.gov/vuln/detail/CVE-2022-22826){: external}, [CVE-2022-22827](https://nvd.nist.gov/vuln/detail/CVE-2022-22827){: external}, [CVE-2022-22942](https://nvd.nist.gov/vuln/detail/CVE-2022-22942){: external}, [CVE-2022-23852](https://nvd.nist.gov/vuln/detail/CVE-2022-23852){: external}, [CVE-2022-23990](https://nvd.nist.gov/vuln/detail/CVE-2022-23990){: external}, [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external}, [CVE-2022-25235](https://nvd.nist.gov/vuln/detail/CVE-2022-25235){: external}, [CVE-2022-25236](https://nvd.nist.gov/vuln/detail/CVE-2022-25236){: external}. |
| HA proxy | f6a2b3 | 15198fb | Contains fixes for [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external}. | 
{: caption="Changes since version 1.20.15_1570" caption-side="bottom"}





### Change log for worker node fix pack 1.20.15_1570, released 14 February 2022
{: #12015_1570}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | N/A |
| Kubernetes | N/A | N/A | N/A |
| HA proxy | d38fa1 | f6a2b3 | [CVE-2021-3521](https://nvd.nist.gov/vuln/detail/CVE-2021-3521){: external}   [CVE-2021-4122](https://nvd.nist.gov/vuln/detail/CVE-2021-4122){: external}. |
{: caption="Changes since version 1.20.15_1569" caption-side="bottom"}






### Change log for worker node fix pack 1.20.15_1569, released 31 January 2022
{: #12015_1569}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-7169](https://nvd.nist.gov/vuln/detail/CVE-2018-7169){: external}, [CVE-2021-3984](https://nvd.nist.gov/vuln/detail/CVE-2021-3984){: external}, [CVE-2021-4019](https://nvd.nist.gov/vuln/detail/CVE-2021-4019){: external}, [CVE-2021-4034](https://nvd.nist.gov/vuln/detail/CVE-2021-4034){: external}, [CVE-2021-4069](https://nvd.nist.gov/vuln/detail/CVE-2021-4069){: external}. |
| Kubernetes | 1.20.13 | 1.20.15 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.15){: external}. |
{: caption="Changes since version 1.20.13_1567" caption-side="bottom"}





### Change log for master fix pack 1.20.15_1568, released 26 January 2022
{: #12015_1568}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Changed to improve Calico availability during updates. |
| Cluster health image | v1.2.20 | v1.2.21 | Updated to use `Go` version `1.17.5`, updated Go dependencies and golangci-lint |
| GPU device plug-in and installer | cc634b2 | 9be025c | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 900 | 923 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.13-4 | v1.20.15-1 | Updated to support the Kubernetes 1.20.15 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 402 | 404 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 3430e03 | 0fc9949 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| Key Management Service provider | v2.3.12 | v2.3.13 | Updated `Go` dependencies and golangci-lint |
| Kubernetes | 1.20.13 | 1.20.15 | 	Changed the duration of the Kubernetes API server certificate from 825 days to 730 days. Changed the duration of the cluster CA certificate from 30 years to 10 years. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.15){: external}. |
| Kubernetes Metrics Server | v0.4.4 | v0.4.5 | Metrics server now dynamically reloads `NannyConfiguration` updates. See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.5){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.1 | 1.21.3 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.21.3){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1659 | 1747 | Updated the Alpine base image to the `3.15` version to resolve CVEs. Updated to use `Go` version `1.17.6`. |
| OpenVPN client | 2.4.6-r3-IKS-463 | 2.5.4-r0-IKS-556 | Update base image to alpine `3.15` to address CVEs, no longer set the --compress config option, updated scripts |
| OpenVPN server | 2.4.6-r3-IKS-462 | 2.5.4-r0-IKS-555 | Update base image to alpine `3.15` to address CVEs, no longer set the --compress config option, updated scripts |
{: caption="Changes since version 1.20.13_1563" caption-side="bottom"}






### Change log for worker node fix pack 1.20.13_1567, released 18 January 2022
{: #12013_1567}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-163-generic | 4.15.0-166-generic | Kernel and package updates for [CVE-2018-25020](https://nvd.nist.gov/vuln/detail/CVE-2018-25020){: external} and [CVE-2021-4002](https://nvd.nist.gov/vuln/detail/CVE-2021-4002){: external}. |
| Containerd | v1.5.8 | v1.5.9 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.9){: external}. |
{: caption="Changes since version 1.20.13_1566" caption-side="bottom"}





### Change log for worker node fix pack 1.20.13_1566, released 4 January 2022
{: #12013_1566}

The following table shows the changes that are in the worker node fix pack patch update `1.20.13_1566`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| HA proxy | 3b8663 | d38fa1 | Contains fixes for [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image packages for [CVE-2019-19449](https://nvd.nist.gov/vuln/detail/CVE-2019-19449){: external}, [CVE-2020-16592](https://nvd.nist.gov/vuln/detail/CVE-2020-16592){: external}, [CVE-2020-21913](https://nvd.nist.gov/vuln/detail/CVE-2020-21913){: external}, [CVE-2020-27781](https://nvd.nist.gov/vuln/detail/CVE-2020-27781){: external}, [CVE-2020-36322](https://nvd.nist.gov/vuln/detail/CVE-2020-36322){: external}, [CVE-2020-36385](https://nvd.nist.gov/vuln/detail/CVE-2020-36385){: external}, [CVE-2021-25219](https://nvd.nist.gov/vuln/detail/CVE-2021-25219){: external}, [CVE-2021-28831](https://nvd.nist.gov/vuln/detail/CVE-2021-28831){: external}, [CVE-2021-28950](https://nvd.nist.gov/vuln/detail/CVE-2021-28950){: external}, [CVE-2021-3487](https://nvd.nist.gov/vuln/detail/CVE-2021-3487){: external}, [CVE-2021-3524](https://nvd.nist.gov/vuln/detail/CVE-2021-3524){: external}, [CVE-2021-3531](https://nvd.nist.gov/vuln/detail/CVE-2021-3531){: external}, [CVE-2021-3733](https://nvd.nist.gov/vuln/detail/CVE-2021-3733){: external}, [CVE-2021-3737](https://nvd.nist.gov/vuln/detail/CVE-2021-3737){: external}, [CVE-2021-3759](https://nvd.nist.gov/vuln/detail/CVE-2021-3759){: external}, [CVE-2021-3778](https://nvd.nist.gov/vuln/detail/CVE-2021-3778){: external}, [CVE-2021-3796](https://nvd.nist.gov/vuln/detail/CVE-2021-3796){: external}, [CVE-2021-3800](https://nvd.nist.gov/vuln/detail/CVE-2021-3800){: external}, [CVE-2021-38199](https://nvd.nist.gov/vuln/detail/CVE-2021-38199){: external}, [CVE-2021-3903](https://nvd.nist.gov/vuln/detail/CVE-2021-3903){: external}, [CVE-2021-3927](https://nvd.nist.gov/vuln/detail/CVE-2021-3927){: external}, [CVE-2021-3928](https://nvd.nist.gov/vuln/detail/CVE-2021-3928){: external}, [CVE-2021-40490](https://nvd.nist.gov/vuln/detail/CVE-2021-40490){: external}, [CVE-2021-42374](https://nvd.nist.gov/vuln/detail/CVE-2021-42374){: external}, [CVE-2021-42378](https://nvd.nist.gov/vuln/detail/CVE-2021-42378){: external}, [CVE-2021-42384](https://nvd.nist.gov/vuln/detail/CVE-2021-42384){: external}, and [CVE-2021-43527](https://nvd.nist.gov/vuln/detail/CVE-2021-43527){: external}. |
{: caption="Changes since version 1.20.13_1564" caption-side="bottom"}





### Change log for master fix pack 1.20.13_1563, released 7 December 2021
{: #12013_1563}

The following table shows the changes that are in the master fix pack update `1.20.13_1563`.  Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.17.5 | v3.17.6 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. |
| Cluster health image | v1.2.18 | v1.2.20 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| CoreDNS | 1.8.4 | 1.8.6 | See the [CoreDNS release notes](https://coredns.io/2021/10/07/coredns-1.8.6-release/){: external}. |
| Gateway-enabled cluster controller | 1567 | 1586 | Updated Alpine base image to the latest `3.14` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| GPU device plug-in and installer | 7fd867d | c9bfc8c | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 864 | 900 | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.12-3 | v1.20.13-4 | Updated to support the Kubernetes `1.20.13` release and to use `calicoctl` version `3.17.6`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 401 | 402 | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.IBM_notm}} Cloud RBAC Operator | 4ca5637 | 3430e03 | Updated universal base image (UBI) to the latest `8.5` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Key Management Service provider | v2.3.10 | v2.3.12 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Kubernetes | v1.20.12 | v1.20.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.13){: external}. |
| Kubernetes NodeLocal DNS cache | 1.17.3 | 1.21.1 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.21.1){: external}. Increased memory resource requests from `8Mi` to `10Mi` to better align with normal resource utilization. |
| Load balancer and load balancer monitor for {{site.data.keyword.IBM_notm}} Cloud Provider | 1590 | 1659 | Updated Alpine base image to the latest `3.14` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Operator Lifecycle Manager | 0.16.1-IKS-14 | 0.16.1-IKS-15 | Updated image for [CVE-2021-42374](https://nvd.nist.gov/vuln/detail/CVE-2021-42374){: external}, [CVE-2021-42375](https://nvd.nist.gov/vuln/detail/CVE-2021-42375){: external}, [CVE-2021-42378](https://nvd.nist.gov/vuln/detail/CVE-2021-42378){: external}, [CVE-2021-42379](https://nvd.nist.gov/vuln/detail/CVE-2021-42379){: external}, [CVE-2021-42380](https://nvd.nist.gov/vuln/detail/CVE-2021-42380){: external}, [CVE-2021-42381](https://nvd.nist.gov/vuln/detail/CVE-2021-42381){: external}, [CVE-2021-42382](https://nvd.nist.gov/vuln/detail/CVE-2021-42382){: external}, [CVE-2021-42383](https://nvd.nist.gov/vuln/detail/CVE-2021-42383){: external}, [CVE-2021-42384](https://nvd.nist.gov/vuln/detail/CVE-2021-42384){: external}, [CVE-2021-42385](https://nvd.nist.gov/vuln/detail/CVE-2021-42385){: external}, and [CVE-2021-42386](https://nvd.nist.gov/vuln/detail/CVE-2021-42386){: external}. |
{: caption="Changes since version 1.20.12_1561" caption-side="bottom"}





### Change log for worker node fix pack 1.20.13_1564, released 6 December 2021
{: #12013_1564}

The following table shows the changes that are in the worker node fix pack patch update `1.20.13_1564`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-162 | 4.15.0-163 | Updated worker node images and kernel with package updates. Contains fixes for [CVE-2021-43527](https://nvd.nist.gov/vuln/detail/CVE-2021-43527){: external} |
| Kubernetes | 1.20.12 | 1.20.13 | See the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.13){: external} | 
| Containerd | v1.4.11 | v1.4.12 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.4.12){: external} and the [security bulletin](https://www.ibm.com/support/pages/node/6524974){: external}.  | 
{: caption="Changes since version 1.20.12_1562" caption-side="bottom"}





### Change log for worker node fix pack 1.20.12_1562, released 22 November 2021
{: #12012_1562}

The following table shows the changes that are in the worker node fix pack patch update `1.20.12_1562`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Kubernetes | 1.20.11 | 1.20.12 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.12){: external}. | 
| HA proxy | 07f1e9e | 3b8663 | Contains fixes for [CVE-2021-20231](https://nvd.nist.gov/vuln/detail/CVE-2021-20231){: external}, [CVE-2021-20232](https://nvd.nist.gov/vuln/detail/CVE-2021-20232){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}, [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2019-20838](https://nvd.nist.gov/vuln/detail/CVE-2019-20838){: external}, [CVE-2020-14155](https://nvd.nist.gov/vuln/detail/CVE-2020-14155){: external}, [CVE-2018-20673](https://nvd.nist.gov/vuln/detail/CVE-2018-20673){: external}, [CVE-2021-42574](https://nvd.nist.gov/vuln/detail/CVE-2021-42574){: external}, [CVE-2019-17594](https://nvd.nist.gov/vuln/detail/CVE-2019-17594){: external}, [CVE-2019-17595](https://nvd.nist.gov/vuln/detail/CVE-2019-17595){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-16135](https://nvd.nist.gov/vuln/detail/CVE-2020-16135){: external}, [CVE-2021-3445](https://nvd.nist.gov/vuln/detail/CVE-2021-3445){: external}, [CVE-2021-36084](https://nvd.nist.gov/vuln/detail/CVE-2021-36084){: external}, [CVE-2021-36085](https://nvd.nist.gov/vuln/detail/CVE-2021-36085){: external}, [CVE-2021-36086](https://nvd.nist.gov/vuln/detail/CVE-2021-36086){: external}, [CVE-2021-36087](https://nvd.nist.gov/vuln/detail/CVE-2021-36087){: external}, [CVE-2021-20266](https://nvd.nist.gov/vuln/detail/CVE-2021-20266){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-27645](https://nvd.nist.gov/vuln/detail/CVE-2021-27645){: external}, [CVE-2021-33574](https://nvd.nist.gov/vuln/detail/CVE-2021-33574){: external}, [CVE-2021-35942](https://nvd.nist.gov/vuln/detail/CVE-2021-35942){: external}, [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-19603](https://nvd.nist.gov/vuln/detail/CVE-2019-19603){: external}, [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}, [CVE-2020-13435](https://nvd.nist.gov/vuln/detail/CVE-2020-13435){: external}, [CVE-2020-24370](https://nvd.nist.gov/vuln/detail/CVE-2020-24370){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, [CVE-2021-3800](https://nvd.nist.gov/vuln/detail/CVE-2021-3800){: external}, [CVE-2021-33928](https://nvd.nist.gov/vuln/detail/CVE-2021-33928){: external}, [CVE-2021-33929](https://nvd.nist.gov/vuln/detail/CVE-2021-33929){: external}, [CVE-2021-33930](https://nvd.nist.gov/vuln/detail/CVE-2021-33930){: external}, [CVE-2021-33938](https://nvd.nist.gov/vuln/detail/CVE-2021-33938){: external}, and[CVE-2021-3200](https://nvd.nist.gov/vuln/detail/CVE-2021-3200){: external} |
| Ubuntu 18.04 packages | 4.15.0-161 | 4.15.0-162  | Updated worker node images and kernel with package fixes for[CVE-2019-19449](https://nvd.nist.gov/vuln/detail/CVE-2019-19449){: external}, [CVE-2020-36322](https://nvd.nist.gov/vuln/detail/CVE-2020-36322){: external}, [CVE-2020-36385](https://nvd.nist.gov/vuln/detail/CVE-2020-36385){: external}, [CVE-2021-28950](https://nvd.nist.gov/vuln/detail/CVE-2021-28950){: external}, [CVE-2021-3759](https://nvd.nist.gov/vuln/detail/CVE-2021-3759){: external}, [CVE-2021-38199](https://nvd.nist.gov/vuln/detail/CVE-2021-38199){: external}, [CVE-2021-3903](https://nvd.nist.gov/vuln/detail/CVE-2021-3903){: external}, [CVE-2021-3927](https://nvd.nist.gov/vuln/detail/CVE-2021-3927){: external}, and [CVE-2021-3928](https://nvd.nist.gov/vuln/detail/CVE-2021-3928){: external}. |
{: caption="Changes since version 1.20.11_1560" caption-side="bottom"}





### Change log for master fix pack 1.20.12_1561, released 17 November 2021
{: #12012_1561}

The following table shows the changes that are in the master fix pack patch update `1.20.11_1561`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.16 | v1.2.18 | Updated `Go` module dependencies and to use `Go` version `1.16.9`.  Updated image for [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-33928](https://nvd.nist.gov/vuln/detail/CVE-2021-33928){: external}, [CVE-2021-33929](https://nvd.nist.gov/vuln/detail/CVE-2021-33929){: external} and [CVE-2021-33930](https://nvd.nist.gov/vuln/detail/CVE-2021-33930){: external}.  |
| etcd | v3.4.17 | v3.4.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.18){: external}. |
| Gateway-enabled cluster controller | 1510 | 1567 | Updated to use `Go` version `1.16.9`. |
| GPU device plug-in and installer | 58d7589 | 7fd867d | Updated image for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external} and [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}. |
| Kubernetes add-on resizer | 1.8.12 | 1.8.13 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.13){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.11-2 | v1.20.12-3 | Updated to support the Kubernetes `1.20.12` release. Updated image for [DLA-2797-1](https://www.debian.org/lts/security/2021/dla-2797){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | e3cb629 | 4ca5637 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Key Management Service provider | v2.3.8 | v2.3.10 | Updated `Go` module dependencies and to use `Go` version `1.16.9`.  Updated image for [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}. |
| Kubernetes | v1.20.11 | v1.20.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.12){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1547 | 1590 | Updated to use `Go` version `1.16.9`. |
| OpenVPN client | 2.4.6-r3-IKS-386 | 2.4.6-r3-IKS-463 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| OpenVPN server | 2.4.6-r3-IKS-385 | 2.4.6-r3-IKS-462 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
{: caption="Changes since version 1.20.11_1558" caption-side="bottom"}





### Change log for worker node fix pack 1.20.11_1560, released 10 November 2021
{: #12011_1560}

The following table shows the changes that are in the worker node fix pack patch update `1.20.11_1560`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image packages for [CVE-2020-16592](https://nvd.nist.gov/vuln/detail/CVE-2020-16592){: external}, [CVE-2020-27781](https://nvd.nist.gov/vuln/detail/CVE-2020-27781){: external}, [CVE-2021-25219](https://nvd.nist.gov/vuln/detail/CVE-2021-25219){: external}, [CVE-2021-3487](https://nvd.nist.gov/vuln/detail/CVE-2021-3487){: external}, [CVE-2021-3524](https://nvd.nist.gov/vuln/detail/CVE-2021-3524){: external}, [CVE-2021-3531](https://nvd.nist.gov/vuln/detail/CVE-2021-3531){: external}, and [CVE-2021-40490](https://nvd.nist.gov/vuln/detail/CVE-2021-40490){: external}. |
{: caption="Changes since version 1.20.11_1559" caption-side="bottom"}





### Change log for master fix pack 1.20.11_1558, released 29 October 2021
{: #12011_1558}

The following table shows the changes that are in the master fix pack patch update `1.20.11_1558`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.15 | v1.2.16 | Move from dependency `form3tech-oss/jwt-go` to `golang-jwt/jwt` since the former is no longer maintained. Updated universal base image (UBI) to the latest 8.4 version to resolve CVEs:  [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} |
| etcd | v3.4.16 | v3.4.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.17){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 763 | 864 | Updated to use Go version 1.16.9. Updated universal base image (UBI) to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager |  v1.20.11-1 | v1.20.11-2 | Updated to ignore VPC load balancer (LB) state when a LB delete is requested. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor | 400 | 401 | Updated universal base image (UBI) to the latest 8.4-210 version |
| Key Management Service provider | v2.3.7 | v2.3.8 | Updated universal base image (UBI) to the latest 8.4 version to resolve CVEs:  [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} |
{: caption="Changes since version 1.20.11_1553" caption-side="bottom"}





### Change log for worker node fix pack 1.20.11_1559, released 25 October 2021
{: #12011_1559}

The following table shows the changes that are in the worker node fix pack patch update `1.20.11_1559`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates. Contains fix for cloud-init performance problem. |
| Worker-pool taint automation | N/A | N/A | Fixes known issue related to worker-pool taint automation that prevents workers from getting providerID. |
{: caption="Changes since version 1.20.11_1555" caption-side="bottom"}





### Change log for worker node fix pack 1.20.11_1555, released 11 October 2021
{: #12011_1555}

The following table shows the changes that are in the worker node fix pack patch update `1.20.11_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Containerd | v1.4.9 | v1.4.11 | See the [security bulletin](https://www.ibm.com/support/pages/node/6501867){: external} and the [change logs](https://github.com/containerd/containerd/releases/tag/v1.4.11){: external}. |
| Ubuntu 18.04 packages | 4.15.0-158 | 4.15.0-159 | Updated worker node images and kernel with package updates [CVE-2021-3778](https://nvd.nist.gov/vuln/detail/CVE-2021-3778){: external} and [CVE-2021-3796](https://nvd.nist.gov/vuln/detail/CVE-2021-3796){: external}. |
{: caption="Changes since version 1.20.11_1554" caption-side="bottom"}





### Change log for master fix pack 1.20.11_1553, released 28 September 2021
{: #12011_1553}

The following table shows the changes that are in the master fix pack patch update `1.21.1_1553`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.17.4 | v3.17.5 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. Increased liveness and readiness probe timeouts to 10 seconds. |
| CoreDNS | 1.8.0 | 1.8.4 | See the [CoreDNS release notes](https://coredns.io/2021/05/28/coredns-1.8.4-release/){: external}. |
| Gateway-enabled cluster controller | 1444 | 1510 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| GPU device plug-in and installer | 8c8bcdf | 58d7589 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.10-1 | v1.20.11-1 | Updated to support the Kubernetes `1.20.11` release. Fixed a bug that may cause node initialization to fail when a new node reuses the name of a deleted node. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 945df65 | e3cb629 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor | 398 | 400 | Updated to use `Go` version `1.16.7`. Updated universal base image (UBI) to the latest `8.4-208` version to resolve CVEs. |
| Kubernetes | v1.20.10 | v1.20.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.11){: external}. |
| Kubernetes API server auditing configuration | N/A | N/A| Updated to support `verbose` [Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| Kubernetes NodeLocal DNS cache | N/A | N/A | Increased memory resource requests from `5Mi` to `8Mi` to better align with normal resource utilization. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1510 | 1547 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-12 | 0.16.1-IKS-14 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
{: caption="Changes since version 1.20.10_1550" caption-side="bottom"}






### Change log for worker node fix pack 1.20.11_1554, released 27 September 2021
{: #12011_1554}

The following table shows the changes that are in the worker node fix pack patch update `1.20.11_1554`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Disk identification | N/A | N/A | Enhanced the disk identification logic to handle the case of 2+ partitions. |
| HA proxy | 9c98dc5 | 07f1e9 | Updated image with fixes for [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}, [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, and [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}. |
| Kubernetes | 1.20.10 | 1.20.11 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.11){: external}. This update resolves [CVE-2021-25741](https://nvd.nist.gov/vuln/detail/CVE-2021-25741){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6496649){: external}). |
| Ubuntu 18.04 packages | 4.15.0-156 | 4.15.0-158 | Updated worker node images and kernel with package updates [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2021-3709](https://nvd.nist.gov/vuln/detail/CVE-2021-3709){: external}, [CVE-2021-3710](https://nvd.nist.gov/vuln/detail/CVE-2021-3710){: external}, [CVE-2021-40330](https://nvd.nist.gov/vuln/detail/CVE-2021-40330){: external}, [CVE-2021-40528](https://nvd.nist.gov/vuln/detail/CVE-2021-40528){: external}, and [CVE-2021-41072](https://nvd.nist.gov/vuln/detail/CVE-2021-41072){: external}. | 
{: caption="Changes since version 1.20.10_1552" caption-side="bottom"}





### Change log for worker node fix pack 1.20.10_1552, released 13 September 2021
{: #12010_1552}

The following table shows the changes that are in the worker node fix pack patch update `1.20.10_1552`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-154 | 4.15.0-156 | Updated worker node images and kernel with package updates for [CVE-2021-3653](https://nvd.nist.gov/vuln/detail/CVE-2021-3653){: external}, [CVE-2021-3656](https://nvd.nist.gov/vuln/detail/CVE-2021-3656){: external}, [CVE-2021-38185](https://nvd.nist.gov/vuln/detail/CVE-2021-38185){: external}, [CVE-2021-40153](https://nvd.nist.gov/vuln/detail/CVE-2021-40153){: external}. |
{: caption="Changes since version 1.20.10_1551" caption-side="bottom"}





### Change log for worker node fix pack 1.20.10_1551, released 30 August 2021
{: #12010_1551}

The following table shows the changes that are in the worker node fix pack patch update `1.20.10_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-153 | 4.15.0-154 | Updated worker node images and kernel with package updates for [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external} and [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}. |
{: caption="Changes since version 1.20.9_1549" caption-side="bottom"}





### Change log for master fix pack 1.20.10_1550 released 25 August 2021
{: #12010_1550}

The following table shows the changes that are in the master fix pack patch update `1.20.10_1550`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Updated the rolling update configuration for the `calico-node` daemonset in the `kube-system` namespace.  The configuration is now the same regardless of the number of cluster worker nodes. |
| Cluster health image | v1.2.14 | v1.2.15 | Updated to use `Go` version `1.15.15`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Gateway-enabled cluster controller | 1348 | 1444 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
| GPU device plug-in and installer | 483ccc2 | 8c8bcdf | Updated to use `Go` version `1.16.6`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 747 | 763 | Updated to use `Go` version `1.16.6`. Updated universal base image (UBI) to the latest `8.4-205` version to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.9-1 | v1.20.10-1 | Updated to support the Kubernetes `1.20.10` release and to use `Go` version `1.15.15`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 395 | 398 | Updated to use `Go` version `1.16.6`. Updated image for [CVE-2021-33910](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33910){: external}. |
| Key Management Service provider | v2.3.6 | v2.3.7 | Updated to use `Go` version `1.15.15`. Updated UBI to the latest `8.4` version to resolve CVEs. |
| Kubernetes | v1.20.9 | v1.20.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.10){: external}. |
| Kubernetes Dashboard | v2.1.0 | v2.3.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.3.1){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.6 | v1.0.7 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.7){: external}. |
| Kubernetes DNS autoscaler | 1.8.3 | 1.8.4 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1328 | 1510 | Updated image for [CVE-2020-27780](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27780){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-10 | 0.16.1-IKS-12 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
{: caption="Changes since version 1.20.9_1547" caption-side="bottom"}





### Change log for worker node fix pack 1.20.9_1549, released 16 August 2021
{: #1209_1549}

The following table shows the changes that are in the worker node fix pack patch update `1.20.9_1549`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-151 | 4.15.0-153 | N/A |
| HA proxy | 68e6b3 | 9c98dc | Updated image with fixes for [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}. |
{: caption="Changes since version 1.20.9_1548" caption-side="bottom"}





### Change log for worker node fix pack 1.20.9_1548, released 02 August 2021
{: #1209_1548}

The following table shows the changes that are in the worker node fix pack patch update `1.20.9_1548`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-147 | 4.15.0-151 | Updated worker node images & Kernel with package updates: [CVE-2020-13529](https://nvd.nist.gov/vuln/detail/CVE-2020-13529){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2021-33200](https://nvd.nist.gov/vuln/detail/CVE-2021-33200){: external}, [CVE-2021-33909](https://nvd.nist.gov/vuln/detail/CVE-2021-33909){: external}, and [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| HA proxy | aae810 | 68e6b3 | Updated image with fixes for [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| Registry endpoints | Added zonal public registry endpoints for clusters with both private and public service endpoints enabled. |
| Read only disk self healing | For VPC Gen2 workers. Added automation to recover from disks going read only. |
| Containerd | v1.4.6 | v1.4.8 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.4.8){: external}. The update resolves CVE-2021-32760 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6478995){: external}). |
| Kubernetes | v1.20.8 | v1.20.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.9){: external}. |
{: caption="Changes since version 1.20.8_1546" caption-side="bottom"}





### Change log for master fix pack 1.20.9_1547, released 27 July 2021
{: #1209_1547}

The following table shows the changes that are in the master fix pack patch update `1.20.9_1547`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.13 | v1.2.14 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
| etcd | v3.4.14 | v3.4.16 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.16){: external}. |
| GPU device plug-in and installer | 772e15f | 483ccc2 | Updated image for [CVE-2021-20271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20271){: external}, [CVE-2021-3516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3516){: external}, [CVE-2021-3517](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3517){: external}, [CVE-2021-3518](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3518){: external}, [CVE-2021-3537](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3537){: external}, [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: external} and [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 730 | 747 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.8-2 | v1.20.9-1 | Updated to support the Kubernetes `1.20.9` release and to use Go version `1.15.14`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 394 | 395 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | b68ea92 | 945df65 | Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Key Management Service provider | v2.3.5 | v2.3.6 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
| Kubernetes | v1.20.8 | v1.20.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.9){: external}. |
{: caption="Changes since version 1.20.8_1544" caption-side="bottom"}





### Change log for worker node fix pack 1.20.8_1546, released 19 July 2021
{: #1208_1546}

The following table shows the changes that are in the worker node fix pack `1.20.8_1546`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with kernel package updates. |
| Ubuntu 18.04 packages | N/A | N/A| Updated worker node images with kernel package updates. | 
{: caption="Changes since version 1.20.8_1545" caption-side="bottom"}





### Change log for worker node fix pack 1.20.8_1545, released 6 July 2021
{: #1208_1545}

The following table shows the changes that are in the worker node fix pack `1.20.8_1545`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 700dc6 | aae810 | Updated image with fixes for [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}, [CVE-2021-20271](https://nvd.nist.gov/vuln/detail/CVE-2021-20271){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external}, [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, and [CVE-2021-3541](https://nvd.nist.gov/vuln/detail/CVE-2021-3541){: external}. |
| Kubernetes | v1.20.7 | v1.20.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.8){: external}. |
| Ubuntu 18.04 packages | 4.15.0.144 | 4.15.0.147 | Updated worker node images with kernel package updates for [CVE-2021-23133](https://nvd.nist.gov/vuln/detail/CVE-2021-23133){: external}, [CVE-2021-3444](https://nvd.nist.gov/vuln/detail/CVE-2021-3444){: external}, and [CVE-2021-3600](https://nvd.nist.gov/vuln/detail/CVE-2021-3600){: external}.
{: caption="Changes since version 1.20.7_1543" caption-side="bottom"}





### Change log for master fix pack 1.20.8_1544, released 28 June 2021
{: #1208_1544}

The following table shows the changes that are in the master fix pack patch update `1.20.8_1544`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.17.3 | v3.17.4 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. |
| Cluster health image | v1.2.12 | v1.2.13 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Gateway-enabled cluster controller | 1352 | 1348 | Updated to run as a non-root user by default, with privileged escalation as needed. |
| GPU device plug-in and installer | 9a5e70b | 772e15f | Updated to use `Go` version `1.15.12`. Updated universal base image (UBI) to version 8.4 to resolve CVEs. Updated the GPU drivers to version [460.73.01](https://www.nvidia.com/Download/driverResults.aspx/173142/){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 689 | 730 | Updated to use `Go` version `1.16.15`. Updated minimal UBI to version 8.4 to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.7-3 | v1.20.8-2 | Updated to support the Kubernetes `1.20.8` release and to use `Go` version `1.15.13`. Updated `Go` dependencies to resolve CVEs. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 392 | 394 | Updated to use `Go` version `1.15.12`. Updated UBI to version `8.4` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 63cd064 | b68ea92 | Updated to use `Go` version `1.16.4`. Updated UBI to version `8.4` to resolve CVEs. |
| Key Management Service provider | v2.3.4 | v2.3.5 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Kubernetes | v1.20.7 | v1.20.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.8){: external}. |
| Portieris admission controller | v0.10.2 | v0.10.3 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.3){: external}. |
{: caption="Changes since version 1.20.7_1540" caption-side="bottom"}





### Change log for worker node fix pack 1.20.7_1543, released 22 June 2021
{: #1207_1543}

The following table shows the changes that are in the worker node fix pack `1.20.7_1543`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | d3dc33 | Updated image with fixes for [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2017-14502](https://nvd.nist.gov/vuln/detail/CVE-2017-14502){: external}, [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external} and [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}.|
| {{site.data.keyword.registrylong_notm}} | N/A | N/A | Added private-only registry support for `ca.icr.io`, `br.icr.io` and `jp2.icr.io`. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2017-8779](https://nvd.nist.gov/vuln/detail/CVE-2017-8779){: external}, [CVE-2017-8872](https://nvd.nist.gov/vuln/detail/CVE-2017-8872){: external}, [CVE-2018-16869](https://nvd.nist.gov/vuln/detail/CVE-2018-16869){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external} [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}.|
{: caption="Changes since version 1.20.7_1542" caption-side="bottom"}





### Change log for worker node fix pack 1.20.7_1542, released 7 June 2021
{: #1207_1542}

The following table shows the changes that are in the worker node fix pack `1.20.7_1542`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | 700dc6 | Updated the image for [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}.|
| TCP `keepalive` optimization for VPC | N/A | N/A | Set the `net.ipv4.tcp_keepalive_time` setting to 180 seconds for compatibility with VPC gateways. |
| Ubuntu 18.04 packages | 4.15.0-143 | 4.15.0-144 | Updated worker node images with kernel package updates for [CVE-2021-25217](https://nvd.nist.gov/vuln/detail/CVE-2021-25217){: external}, [CVE-2021-31535](https://nvd.nist.gov/vuln/detail/CVE-2021-31535){: external}, [CVE-2021-32547](https://nvd.nist.gov/vuln/detail/CVE-2021-32547){: external}, [CVE-2021-32552](https://nvd.nist.gov/vuln/detail/CVE-2021-32552){: external}, [CVE-2021-32556](https://nvd.nist.gov/vuln/detail/CVE-2021-32556){: external}, [CVE-2021-32557](https://nvd.nist.gov/vuln/detail/CVE-2021-32557){: external}, [CVE-2021-3448](https://nvd.nist.gov/vuln/detail/CVE-2021-3448){: external}, and [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}.|
{: caption="Changes since version 1.20.7_1541" caption-side="bottom"}





### Change log for worker node fix pack 1.20.7_1541, released 24 May 2021
{: #1207_1541}

The following table shows the changes that are in the worker node fix pack `1.20.7_1541`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.4.5 | v1.4.6 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.4.6){: external}. The update resolves CVE-2021-30465 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6456943){: external}). |
| HA proxy | e0fa2f | 26c5cc | Updated image with fixes for [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2019-18276](https://nvd.nist.gov/vuln/detail/CVE-2019-18276){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, and [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external}. |
| Kubernetes | v1.20.6 | v1.20.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.7){: external}. |
| Ubuntu 18.04 packages | 4.15.0-142 | 4.15.0-143 | Updated worker node images with kernel package updates for [CVE-2021-28688](https://nvd.nist.gov/vuln/detail/CVE-2021-28688){: external}, [CVE-2021-20292](https://nvd.nist.gov/vuln/detail/CVE-2021-20292){: external}, [CVE-2021-29264](https://nvd.nist.gov/vuln/detail/CVE-2021-29264){: external}, [CVE-2021-29265](https://nvd.nist.gov/vuln/detail/CVE-2021-29265){: external}, and [CVE-2021-29650](https://nvd.nist.gov/vuln/detail/CVE-2021-29650){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2009-5155](https://nvd.nist.gov/vuln/detail/CVE-2009-5155){: external} and [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}.|
{: caption="Changes since version 1.20.6_1539" caption-side="bottom"}





### Change log for master fix pack 1.20.7_1540, released 24 May 2021
{: #1207_1540}

The following table shows the changes that are in the master fix pack patch update `1.20.7_1540`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.11 | v1.2.12 | Improved the add-on status information that is displayed when errors occur. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}, [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| CoreDNS | 1.8.3 | 1.8.0 | See the [CoreDNS release notes](https://coredns.io/2020/10/22/coredns-1.8.0-release/){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 661 | 689 | Updated to use `Go` version 1.15.12. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.6-2 | v1.20.7-3 | Updated to support the Kubernetes 1.20.7 release and to use `Go` version 1.15.12. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 390 | 392 | Improved the prerequisite validation logic for provisioning persistent volume claims (PVCs). Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.cloud_notm}}  RBAC Operator | b6a694b | 63cd064 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external}. |
| Key Management Service provider | v2.3.3 | v2.3.4 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}. |
| Kubernetes | v1.20.6 | v1.20.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.7){: external}. The update resolves CVE-2020-8562 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457271){: external}) and CVE-2021-25737 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457273){: external}). |
| Kubernetes add-on resizer | 1.8.11 | 1.8.12 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.12){: external}. |
| Kubernetes Metrics Server | v0.4.2 | v0.4.4 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.4){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-9 | 0.16.1-IKS-10 | Fixed a bug that was caused by a missing `/bin/cpb` binary file. |
| Portieris admission controller | v0.10.1 | v0.10.2 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.2){: external}. |
{: caption="Changes since version 1.20.6_1538" caption-side="bottom"}





### Change log for worker node fix pack 1.20.6_1539, released 10 May 2021
{: #1206_1539}

The following table shows the changes that are in the worker node fix pack `1.20.6_1539`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}.|
{: caption="Changes since version 1.20.6_1537" caption-side="bottom"}





### Change log for master fix pack 1.20.6_1538, released 4 May 2021
{: #1206_1538}

The following table shows the changes that are in the master fix pack patch update `1.20.6_1538`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.IBM_notm}} Calico extension | 618 | 661 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-14391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CCVE-2020-14391){: external}, [CVE-2020-25661](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25661){: external} and [CVE-2020-25662](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25662){: external}. |
| Gateway-enabled cluster controller | 1322 | 1352 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.6-1 | v1.20.6-2 | Updated to support VPC private network load balancers. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1274 | 1328 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
{: caption="Changes since version 1.20.6_1536" caption-side="bottom"}





### Change log for master fix pack 1.20.6_1536, released 27 April 2021
{: #1206_1536}

The following table shows the changes that are in the master fix pack patch update `1.20.6_1536`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.9 | v1.2.11 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| GPU device plug-in and installer | b9ec8af | 9a5e70b | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.5-1 | v1.20.6-1 | Updated to support the Kubernetes 1.20.6 release and to use `Go` version 1.15.10. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 389 | 390 | Updated to use `Go` version 1.15.9 and for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external} and [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 3dd6bbc | b6a694b | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| Key Management Service provider | v2.3.0 | v2.3.3 | Updated to use `Go` version 1.15.11 and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| Kubernetes | v1.20.5 | v1.20.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.6){: external}. The update resolves CVE-2021-25735 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6447812){: external}). |
| Kubernetes NodeLocal DNS cache | 1.17.1 | 1.17.3 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.17.3){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-386 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| OpenVPN server | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-385 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Operator Lifecycle Manager | 0.16.1-IKS-5 | 0.16.1-IKS-9 | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}. |
{: caption="Changes since version 1.20.5_1533" caption-side="bottom"}





### Change log for worker node fix pack 1.20.6_1537, released 26 April 2021
{: #1206_1537}

The following table shows the changes that are in the worker node fix pack `1.20.6_1537`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | a3b1ff | e0fa2f | The update addresses [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Added resiliency to `systemd` units to prevent failures situations where the worker nodes are overused.   Updated worker node images with kernel and package updates for [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}, and [CVE-2021-3348](https://nvd.nist.gov/vuln/detail/CVE-2021-3348){: external}. |
| Ubuntu 16.04 packages |4.4.0-206 | 4.4.0-210 | Updated worker node images with kernel and package updates for [[CVE-2015-1350](https://nvd.nist.gov/vuln/detail/CVE-2015-1350){: external}, [CVE-2017-15107](https://nvd.nist.gov/vuln/detail/CVE-2017-15107){: external}, [CVE-2017-5967](https://nvd.nist.gov/vuln/detail/CVE-2017-5967){: external}, [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2018-5953](https://nvd.nist.gov/vuln/detail/CVE-2018-5953){: external}, [CVE-2019-14513](https://nvd.nist.gov/vuln/detail/CVE-2019-14513){: external}, [CVE-2019-16231](https://nvd.nist.gov/vuln/detail/CVE-2019-16231){: external}, [CVE-2019-16232](https://nvd.nist.gov/vuln/detail/CVE-2019-16232){: external}, [CVE-2019-19061](https://nvd.nist.gov/vuln/detail/CVE-2019-19061){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, and [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}.|
{: caption="Changes since version 1.20.5_1535" caption-side="bottom"}





### Change log for worker node fix pack 1.20.5_1535, released 12 April 2021
{: #1205_1535}

The following table shows the changes that are in the worker node fix pack `1.20.5_1535`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 9b2dca | a3b1ff | The update addresses [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external} and [CVE-2021-3450](https://nvd.nist.gov/vuln/detail/CVE-2021-3450){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}.|
{: caption="Changes since version 1.20.5_1534" caption-side="bottom"}





### Change log for master fix pack 1.20.5_1533, released 30 March 2021
{: #1205_1533}

The following table shows the changes that are in the master fix pack patch update `1.20.5_1533`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.at_short}} event | N/A | N/A | Now, the `containers-kubernetes.version.update` event is sent to {{site.data.keyword.at_short}} when a master fix pack update is initiated for a cluster. |
| Cluster health image | v1.2.8 | v1.2.9 | Updated image for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}. |
| CoreDNS | 1.8.0 | 1.8.3 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| Gateway-enabled cluster controller | 1232 | 1322 | Updated to use `Go` version 1.15.10 and for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
| GPU device plug-in and installer | 1c41e4b | b9ec8af | Updated image for [CVE-2021-27919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27919){: external}, [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}, and [CVE-2020-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28852){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.4-4 | v1.20.5-1 | Updated to support the Kubernetes 1.20.5 release. Fixed a bug that prevented VPC load balancers from supporting more than 50 subnets in an account. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 388 | 389 | Updated to use `Go` version 1.15.8. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 86de2b7 | 3dd6bbc | Updated image for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}. |
| Kubernetes | v1.20.4 | v1.20.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.5){: external}. |
| Kubernetes NodeLocal DNS cache | 1.16.0 | 1.17.1 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.17.1){: external}. |
{: caption="Changes since version 1.20.4_1531" caption-side="bottom"}





### Change log for worker node fix pack 1.20.5_1534, released 29 March 2021
{: #1205_1534}

The following table shows the changes that are in the worker node fix pack `1.20.5_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-136-generic | 4.15.0-140-generic | Updated worker node images with kernel and package updates for [CVE-2020-27170](https://nvd.nist.gov/vuln/detail/CVE-2020-27170){: external}, [CVE-2020-27171](https://nvd.nist.gov/vuln/detail/CVE-2020-27171){: external}, [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, and [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external}. |
| Ubuntu 16.04 packages | 4.4.0-203-generic | 4.4.0-206-generic | Updated worker node images with kernel and package updates for [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, and [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}.|
{: caption="Changes since version 1.20.4_1532" caption-side="bottom"}





### Change log for worker node fix pack 1.20.4_1532, released 12 March 2021
{: #1204_1532}

The following table shows the changes that are in the worker node fix pack `1.20.4_1532`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.4.3 | v1.4.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.4.4){: external}. The update resolves CVE-2021-21334 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6433475){: external}). |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-24031](https://nvd.nist.gov/vuln/detail/CVE-2021-24031){: external}, [CVE-2021-24032](https://nvd.nist.gov/vuln/detail/CVE-2021-24032){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, and [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for{: external}, [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: caption="Changes since version 1.20.4_1531" caption-side="bottom"}





### Change log for worker node fix pack 1.20.4_1531, released 1 March 2021
{: #1204_1531}

The following table shows the changes that are in the worker node fix pack `1.20.4_1531`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.20.2 | v1.20.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.4){: external}. |
| Ubuntu 18.04 packages | 4.15.0-135-generic | 4.15.0-136-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
| Ubuntu 16.04 packages | 4.4.0-201-generic | 4.4.0-203-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: caption="Changes since version 1.20.2_1527" caption-side="bottom"}





### Change log for master fix pack 1.20.4_1531, released 27 February 2021
{: #1204_1531_master}

The following table shows the changes that are in the master fix pack patch update `1.20.4_1531`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.17.2 | v3.17.3 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.4-2 | v1.20.4-4 | Updated to use `calicoctl` version 3.17.3. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1165 | 1274 | Fixed a bug that might cause version 2.0 network load balancers (NLBs) to crash and restart on load balancer updates. |
{: caption="Changes since version 1.20.4_1530." caption-side="bottom"}





### Change log for master fix pack 1.20.4_1530, released 22 February 2021
{: #1204_1530}

The following table shows the changes that are in the master fix pack patch update `1.20.4_1530`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.20.2-15 | v1.20.4-2 | Updated to support the Kubernetes 1.20.4 release and to use `Go` version 1.15.8. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Key Management Service provider | v2.2.4 | v2.3.0 | Updated to use `Go` version 1.15.7. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Kubernetes | v1.20.2 | v1.20.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.4){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-3 | 0.16.1-IKS-5 | Updated image for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
{: caption="Changes since version 1.20.2_1528." caption-side="bottom"}





### Change log for 1.20.2_1528 (master) and 1.20.2_1527 (worker node), released 17 February 2021
{: #1202_1528}

The following table shows the changes that are in the version updates for `1.20.2_1528` master fix pack and `1.20.2_1527` worker node fix pack.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.16.5 | v3.17.2 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. |
| Cluster health image | v1.2.6 | v1.2.8 | Updated to use `Go` version 1.15.7. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Gateway-enabled cluster controller | 1195 | 1232 | Updated to use `Go` version 1.15.7. |
| GPU device plug-in and installer | af5a6cb | 1c41e4b | Updated to support the Kubernetes 1.20 release. |
| {{site.data.keyword.IBM_notm}} Calico extension | 567 | 618 | Updated to use `Go` version 1.15.7. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.7-4 | v1.20.2-15 | Updated to:  \n - Support the Kubernetes 1.20.2 release.  \n - Use `calicoctl` version 3.17.2.  \n - Implement additional {{site.data.keyword.IBM_notm}} security controls.  \n - Address [DLA-2509-1](https://www.debian.org/lts/security/2020/dla-2509){: external}.  \n - Make version 1.0 and 2.0 network load balancers (NLBs) to run as a non-root user by default, with privileged escalation as needed. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 385 | 388 | Improved the retry logic for provisioning persistent volume claims (PVCs). |
| {{site.data.keyword.cloud_notm}} RBAC Operator | f859228 | 86de2b7 | Updated to use `Go` version 1.15.7. |
| Key Management Service provider | v2.2.3 | v2.2.4 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Kubernetes | v1.19.7 | v1.20.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.2){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates). |
| Kubernetes CSI snapshotter CRDs | N/A | v3.0.2 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v3.0.2){: external}. |
| Kubernetes Dashboard | v2.0.5 | v2.1.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.1.0){: external}. |
| Kubernetes Dashboard metrics scraper configuration | N/A | N/A | [Default Kubernetes network policy added](/docs/containers?topic=containers-network_policies#default_policy) to block most pods from accessing the Kubernetes Dashboard metrics. |
| Kubernetes Metrics Server | v0.3.7 | v0.4.2 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.2){: external}. |
| Kubernetes NodeLocal DNS cache | 1.15.14 | 1.16.0 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.16.0){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1078 | 1165 | Updated to run as a non-root user by default, with privileged escalation as needed. Updated to use `Go` version 1.15.7. |
{: caption="Changes since version 1.19.7_1532 (master) and 1.19.7_1535 (worker node)." caption-side="bottom"}
