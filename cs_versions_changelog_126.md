---

copyright: 
  years: 2023, 2023
lastupdated: "2023-05-26"

keywords: kubernetes, containers, change log, 126 change log, 126 updates

subcollection: containers


---

# Kubernetes version 1.26 change log
{: #changelog_126}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.26. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_126}

In clusters that run version 1.23 or earlier, the {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. In version 1.24 and later, most new beta features are disabled by default. Kubernetes alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.26 change log
{: #126_changelog}


Review the version 1.26 change log.
{: shortdesc}


### Change log for worker node fix pack 1.26.5_1538, released 23 May 2023
{: #1265_1538_W}

The following table shows the changes that are in the worker node fix pack 1.26.5_1538. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-210-generic | 4.15.0-211-generic | Worker node kernel & package updates for [CVE-2021-3979](https://nvd.nist.gov/vuln/detail/CVE-2021-3979){: external}, [CVE-2023-1118](https://nvd.nist.gov/vuln/detail/CVE-2023-1118){: external}. |
| Ubuntu 20.04 packages | 5.4.0-139-generic | 5.4.0-148-generic | Worker node kernel & package updates for [CVE-2023-2004](https://nvd.nist.gov/vuln/detail/CVE-2023-2004){: external}. |
| Kubernetes | 1.26.4 |1.26.5|see [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.26.5){: external}. |
| Haproxy | N\A | N\A | N\A|
{: caption="Changes since version 1.26.4_1536" caption-side="bottom"}


### Change log for worker node fix pack 1.26.4_1536, released 9 May 2023
{: #1264_1536_W}

The following table shows the changes that are in the worker node fix pack 1.26.4_1536. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-209-generic | 4.15.0-210-generic | Worker node kernel & package updates for [CVE-2023-1786](https://nvd.nist.gov/vuln/detail/CVE-2023-1786){: external}, [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}, [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}, [CVE-2023-1829](https://nvd.nist.gov/vuln/detail/CVE-2023-1829){: external}, [CVE-2023-25652](https://nvd.nist.gov/vuln/detail/CVE-2023-25652){: external}, [CVE-2023-25815](https://nvd.nist.gov/vuln/detail/CVE-2023-25815){: external}, [CVE-2023-29007](https://nvd.nist.gov/vuln/detail/CVE-2023-29007){: external}. |
| Ubuntu 20.04 packages | n/a | n/a | Worker node kernel & package updates for [CVE-2023-1786](https://nvd.nist.gov/vuln/detail/CVE-2023-1786){: external}, [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}, [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}, [CVE-2023-25652](https://nvd.nist.gov/vuln/detail/CVE-2023-25652){: external}, [CVE-2023-25815](https://nvd.nist.gov/vuln/detail/CVE-2023-25815){: external}, [CVE-2023-29007](https://nvd.nist.gov/vuln/detail/CVE-2023-29007){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.26.4_1535" caption-side="bottom"}


### Change log for master fix pack 1.26.4_1535, released 27 April 2023
{: #1264_1535M}

The following table shows the changes that are in the master fix pack 1.26.4_1535. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.25.0 | v3.25.1 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#v3.25.1){: external}. |
| Cluster health image | v1.3.17 | v1.3.19 | Updated `Go` to version `1.19.8` and updated dependencies. |
| Gateway-enabled cluster controller | 2024 | 2106 | Support Ubuntu 20 and update image to resolve CVEs. |
| GPU device plug-in | a873e90 | fc4cf22 | Updated `Go` to version `1.19.7`. |
| GPU installer | a873e90 | 28d80a0 | Updated `Go` to version `1.19.8`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1366 | 1390 | Eliminate IP syscall. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.0 | v2.4.5 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.19.8` and updated dependencies. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.26.3-1 | v1.26.4-1 | Updated to support the Kubernetes `1.26.4` release. Updated `Go` dependencies and to `Go` version `1.19.8`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 429 | 431 | Updated `Go` to version `1.19.8` and updated dependencies. Update UBI base image. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | N/A | d842983 | New component with multi-architecture support that replaces the existing metrics server configuration watcher. |
| Key Management Service provider | v2.6.4 | v2.6.5 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Konnectivity agent and server | v0.1.1_569_iks | v0.1.2_591_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.2){: external}. Updated configuration to set `keepalive-time` to `40s`. |
| Kubernetes | v1.26.3 | v1.26.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.26.4){: external}. |
| Kubernetes Metrics Server configuration | N/A | N/A | Updated to use TLS version 1.3 ciphers. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2420 | 2486 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Portieris admission controller | v0.13.3 | v0.13.4 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.4){: external}. |
{: caption="Changes since version 1.26.3_1531" caption-side="bottom"}


### Change log for worker node fix pack 1.26.4_1535, released 24 April 2023
{: #1264_1535}

The following table shows the changes that are in the worker node fix pack 1.26.4_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-208-generic | 4.15.0-209-generic | Worker node package updates for  [CVE-2021-4192](https://nvd.nist.gov/vuln/detail/CVE-2021-4192){: external}, [CVE-2021-4193](https://nvd.nist.gov/vuln/detail/CVE-2021-4193){: external}, [CVE-2022-0213](https://nvd.nist.gov/vuln/detail/CVE-2022-0213){: external}, [CVE-2022-0261](https://nvd.nist.gov/vuln/detail/CVE-2022-0261){: external}, [CVE-2022-0318](https://nvd.nist.gov/vuln/detail/CVE-2022-0318){: external}, [CVE-2022-0319](https://nvd.nist.gov/vuln/detail/CVE-2022-0319){: external}, [CVE-2022-0351](https://nvd.nist.gov/vuln/detail/CVE-2022-0351){: external}, [CVE-2022-0359](https://nvd.nist.gov/vuln/detail/CVE-2022-0359){: external}, [CVE-2022-0361](https://nvd.nist.gov/vuln/detail/CVE-2022-0361){: external}, [CVE-2022-0368](https://nvd.nist.gov/vuln/detail/CVE-2022-0368){: external}, [CVE-2022-0408](https://nvd.nist.gov/vuln/detail/CVE-2022-0408){: external}, [CVE-2022-0443](https://nvd.nist.gov/vuln/detail/CVE-2022-0443){: external}, [CVE-2022-0554](https://nvd.nist.gov/vuln/detail/CVE-2022-0554){: external}, [CVE-2022-0572](https://nvd.nist.gov/vuln/detail/CVE-2022-0572){: external}, [CVE-2022-0685](https://nvd.nist.gov/vuln/detail/CVE-2022-0685){: external}, [CVE-2022-0714](https://nvd.nist.gov/vuln/detail/CVE-2022-0714){: external}, [CVE-2022-0729](https://nvd.nist.gov/vuln/detail/CVE-2022-0729){: external}, [CVE-2022-2207](https://nvd.nist.gov/vuln/detail/CVE-2022-2207){: external}, [CVE-2022-3903](https://nvd.nist.gov/vuln/detail/CVE-2022-3903){: external}, [CVE-2023-1281](https://nvd.nist.gov/vuln/detail/CVE-2023-1281){: external}, [CVE-2023-1326](https://nvd.nist.gov/vuln/detail/CVE-2023-1326){: external}, [CVE-2023-26545](https://nvd.nist.gov/vuln/detail/CVE-2023-26545){: external}, [CVE-2023-28450](https://nvd.nist.gov/vuln/detail/CVE-2023-28450){: external}, [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}, [CVE-2023-28486](https://nvd.nist.gov/vuln/detail/CVE-2023-28486){: external}, [CVE-2023-28487](https://nvd.nist.gov/vuln/detail/CVE-2023-28487){: external}, [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-4166](https://nvd.nist.gov/vuln/detail/CVE-2021-4166){: external}, [CVE-2021-4192](https://nvd.nist.gov/vuln/detail/CVE-2021-4192){: external}, [CVE-2021-4193](https://nvd.nist.gov/vuln/detail/CVE-2021-4193){: external}, [CVE-2022-0213](https://nvd.nist.gov/vuln/detail/CVE-2022-0213){: external}, [CVE-2022-0261](https://nvd.nist.gov/vuln/detail/CVE-2022-0261){: external}, [CVE-2022-0318](https://nvd.nist.gov/vuln/detail/CVE-2022-0318){: external}, [CVE-2022-0319](https://nvd.nist.gov/vuln/detail/CVE-2022-0319){: external}, [CVE-2022-0351](https://nvd.nist.gov/vuln/detail/CVE-2022-0351){: external}, [CVE-2022-0359](https://nvd.nist.gov/vuln/detail/CVE-2022-0359){: external}, [CVE-2022-0361](https://nvd.nist.gov/vuln/detail/CVE-2022-0361){: external}, [CVE-2022-0368](https://nvd.nist.gov/vuln/detail/CVE-2022-0368){: external}, [CVE-2022-0408](https://nvd.nist.gov/vuln/detail/CVE-2022-0408){: external}, [CVE-2022-0443](https://nvd.nist.gov/vuln/detail/CVE-2022-0443){: external}, [CVE-2022-0554](https://nvd.nist.gov/vuln/detail/CVE-2022-0554){: external}, [CVE-2022-0572](https://nvd.nist.gov/vuln/detail/CVE-2022-0572){: external}, [CVE-2022-0629](https://nvd.nist.gov/vuln/detail/CVE-2022-0629){: external}, [CVE-2022-0685](https://nvd.nist.gov/vuln/detail/CVE-2022-0685){: external}, [CVE-2022-0714](https://nvd.nist.gov/vuln/detail/CVE-2022-0714){: external}, [CVE-2022-0729](https://nvd.nist.gov/vuln/detail/CVE-2022-0729){: external}, [CVE-2022-2207](https://nvd.nist.gov/vuln/detail/CVE-2022-2207){: external}, [CVE-2022-3108](https://nvd.nist.gov/vuln/detail/CVE-2022-3108){: external}, [CVE-2022-3903](https://nvd.nist.gov/vuln/detail/CVE-2022-3903){: external}, [CVE-2023-1281](https://nvd.nist.gov/vuln/detail/CVE-2023-1281){: external}, [CVE-2023-1326](https://nvd.nist.gov/vuln/detail/CVE-2023-1326){: external}, [CVE-2023-26545](https://nvd.nist.gov/vuln/detail/CVE-2023-26545){: external}, [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}, [CVE-2023-28486](https://nvd.nist.gov/vuln/detail/CVE-2023-28486){: external}, [CVE-2023-28487](https://nvd.nist.gov/vuln/detail/CVE-2023-28487){: external}, [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}. |
| Kubernetes | 1.26.3 | 1.26.4 | See [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.26.4){: external}. |
| Containerd |N/A|N/A|N/A|
| Haproxy |N/A|N/A|N/A|
{: caption="Changes since version 1.26.3_1533" caption-side="bottom"}


### Change log for worker node fix pack 1.26.3_1533, released 11 April 2023
{: #1263_1533}

The following table shows the changes that are in the worker node fix pack 1.26.3_1533. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-206 | 4.15.0-208 | Worker node kernel & package updates for [CVE-2021-3669](https://nvd.nist.gov/vuln/detail/CVE-2021-3669){: external}, [CVE-2022-0413](https://nvd.nist.gov/vuln/detail/CVE-2022-0413){: external}, [CVE-2022-1629](https://nvd.nist.gov/vuln/detail/CVE-2022-1629){: external}, [CVE-2022-1674](https://nvd.nist.gov/vuln/detail/CVE-2022-1674){: external}, [CVE-2022-1720](https://nvd.nist.gov/vuln/detail/CVE-2022-1720){: external}, [CVE-2022-1733](https://nvd.nist.gov/vuln/detail/CVE-2022-1733){: external}, [CVE-2022-1735](https://nvd.nist.gov/vuln/detail/CVE-2022-1735){: external}, [CVE-2022-1785](https://nvd.nist.gov/vuln/detail/CVE-2022-1785){: external}, [CVE-2022-1796](https://nvd.nist.gov/vuln/detail/CVE-2022-1796){: external}, [CVE-2022-1851](https://nvd.nist.gov/vuln/detail/CVE-2022-1851){: external}, [CVE-2022-1898](https://nvd.nist.gov/vuln/detail/CVE-2022-1898){: external}, [CVE-2022-1942](https://nvd.nist.gov/vuln/detail/CVE-2022-1942){: external}, [CVE-2022-1968](https://nvd.nist.gov/vuln/detail/CVE-2022-1968){: external}, [CVE-2022-2124](https://nvd.nist.gov/vuln/detail/CVE-2022-2124){: external}, [CVE-2022-2125](https://nvd.nist.gov/vuln/detail/CVE-2022-2125){: external}, [CVE-2022-2126](https://nvd.nist.gov/vuln/detail/CVE-2022-2126){: external}, [CVE-2022-2129](https://nvd.nist.gov/vuln/detail/CVE-2022-2129){: external}, [CVE-2022-2175](https://nvd.nist.gov/vuln/detail/CVE-2022-2175){: external}, [CVE-2022-2183](https://nvd.nist.gov/vuln/detail/CVE-2022-2183){: external}, [CVE-2022-2206](https://nvd.nist.gov/vuln/detail/CVE-2022-2206){: external}, [CVE-2022-2304](https://nvd.nist.gov/vuln/detail/CVE-2022-2304){: external}, [CVE-2022-2345](https://nvd.nist.gov/vuln/detail/CVE-2022-2345){: external}, [CVE-2022-2571](https://nvd.nist.gov/vuln/detail/CVE-2022-2571){: external}, [CVE-2022-2581](https://nvd.nist.gov/vuln/detail/CVE-2022-2581){: external}, [CVE-2022-2845](https://nvd.nist.gov/vuln/detail/CVE-2022-2845){: external}, [CVE-2022-2849](https://nvd.nist.gov/vuln/detail/CVE-2022-2849){: external}, [CVE-2022-2923](https://nvd.nist.gov/vuln/detail/CVE-2022-2923){: external}, [CVE-2022-2946](https://nvd.nist.gov/vuln/detail/CVE-2022-2946){: external}, [CVE-2022-41218](https://nvd.nist.gov/vuln/detail/CVE-2022-41218){: external}, [CVE-2023-0045](https://nvd.nist.gov/vuln/detail/CVE-2023-0045){: external}, [CVE-2023-0266](https://nvd.nist.gov/vuln/detail/CVE-2023-0266){: external}, [CVE-2023-23559](https://nvd.nist.gov/vuln/detail/CVE-2023-23559){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-0413](https://nvd.nist.gov/vuln/detail/CVE-2022-0413){: external}, [CVE-2022-1629](https://nvd.nist.gov/vuln/detail/CVE-2022-1629){: external}, [CVE-2022-1674](https://nvd.nist.gov/vuln/detail/CVE-2022-1674){: external}, [CVE-2022-1720](https://nvd.nist.gov/vuln/detail/CVE-2022-1720){: external}, [CVE-2022-1733](https://nvd.nist.gov/vuln/detail/CVE-2022-1733){: external}, [CVE-2022-1735](https://nvd.nist.gov/vuln/detail/CVE-2022-1735){: external}, [CVE-2022-1785](https://nvd.nist.gov/vuln/detail/CVE-2022-1785){: external}, [CVE-2022-1796](https://nvd.nist.gov/vuln/detail/CVE-2022-1796){: external}, [CVE-2022-1851](https://nvd.nist.gov/vuln/detail/CVE-2022-1851){: external}, [CVE-2022-1898](https://nvd.nist.gov/vuln/detail/CVE-2022-1898){: external}, [CVE-2022-1927](https://nvd.nist.gov/vuln/detail/CVE-2022-1927){: external}, [CVE-2022-1942](https://nvd.nist.gov/vuln/detail/CVE-2022-1942){: external}, [CVE-2022-1968](https://nvd.nist.gov/vuln/detail/CVE-2022-1968){: external}, [CVE-2022-2124](https://nvd.nist.gov/vuln/detail/CVE-2022-2124){: external}, [CVE-2022-2125](https://nvd.nist.gov/vuln/detail/CVE-2022-2125){: external}, [CVE-2022-2126](https://nvd.nist.gov/vuln/detail/CVE-2022-2126){: external}, [CVE-2022-2129](https://nvd.nist.gov/vuln/detail/CVE-2022-2129){: external}, [CVE-2022-2175](https://nvd.nist.gov/vuln/detail/CVE-2022-2175){: external}, [CVE-2022-2183](https://nvd.nist.gov/vuln/detail/CVE-2022-2183){: external}, [CVE-2022-2206](https://nvd.nist.gov/vuln/detail/CVE-2022-2206){: external}, [CVE-2022-2304](https://nvd.nist.gov/vuln/detail/CVE-2022-2304){: external}, [CVE-2022-2344](https://nvd.nist.gov/vuln/detail/CVE-2022-2344){: external}, [CVE-2022-2345](https://nvd.nist.gov/vuln/detail/CVE-2022-2345){: external}, [CVE-2022-2571](https://nvd.nist.gov/vuln/detail/CVE-2022-2571){: external}, [CVE-2022-2581](https://nvd.nist.gov/vuln/detail/CVE-2022-2581){: external}, [CVE-2022-2845](https://nvd.nist.gov/vuln/detail/CVE-2022-2845){: external}, [CVE-2022-2849](https://nvd.nist.gov/vuln/detail/CVE-2022-2849){: external}, [CVE-2022-2923](https://nvd.nist.gov/vuln/detail/CVE-2022-2923){: external}, [CVE-2022-2946](https://nvd.nist.gov/vuln/detail/CVE-2022-2946){: external}, [CVE-2022-2980](https://nvd.nist.gov/vuln/detail/CVE-2022-2980){: external}. Updated `sysctl` setting for `fs.inotify.max_user_instances` from default `128` to `1024`. |
| Kubernetes |N/A|N/A|N/A|
| Haproxy | 8398d1 | 8895ad | [CVE-2023-0361](https://nvd.nist.gov/vuln/detail/CVE-2023-0361){: external}. |
| Containerd |N/A|N/A|N/A|
{: caption="Changes since version 1.26.3_1531" caption-side="bottom"}


### Change log for worker node fix pack 1.26.3_1531, released 29 March 2023
{: #1263_1531}

The following table shows the changes that are in the worker node fix pack 1.26.3_1531. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-144 | 5.4.0-139 | Downgrading kernel to address [Upstream canonical bug](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2009325){: external}. |
{: caption="Changes since version 1.26.3_1529" caption-side="bottom"}


### Change log for master fix pack 1.26.3_1528, released 28 March 2023
{: #1263_1528}

The following table shows the changes that are in the master fix pack 1.26.3_1528. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.16 | v1.3.17 | Updated `Go` to version `1.19.7` and updated dependencies. |
| GPU device plug-in and installer | 79a2232 | a873e90 | Updated `Go` to version `1.19.6`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1308-amd64 | 1366-amd64 | Updated to resolve [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.7 | v2.4.0 | Removed ExpandInUsePersistentVolumes feature gate. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.26.1-16 | v1.26.3-1 | Updated to support the `Kubernetes 1.26.3` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 427 | 429 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.19.6` and updated dependencies. |
| Key Management Service provider | v2.6.3 | v2.6.4 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Kubernetes | v1.26.1 | v1.26.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.26.3){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.8 | v1.0.9 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.9){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2383 | 2420 | Updated the image to resolve CVEs. |
{: caption="Changes since version 1.26.1_1524" caption-side="bottom"}


### Change log for worker node fix pack 1.26.3_1529, released 27 March 2023
{: #1263_1529}

The following table shows the changes that are in the worker node fix pack 1.26.3_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2022-47024](https://nvd.nist.gov/vuln/detail/CVE-2022-47024){: external}, [CVE-2023-0049](https://nvd.nist.gov/vuln/detail/CVE-2023-0049){: external}, [CVE-2023-0054](https://nvd.nist.gov/vuln/detail/CVE-2023-0054){: external}, [CVE-2023-0288](https://nvd.nist.gov/vuln/detail/CVE-2023-0288){: external}, [CVE-2023-0433](https://nvd.nist.gov/vuln/detail/CVE-2023-0433){: external}, [CVE-2023-1170](https://nvd.nist.gov/vuln/detail/CVE-2023-1170){: external}, [CVE-2023-1175](https://nvd.nist.gov/vuln/detail/CVE-2023-1175){: external}, [CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external}, [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}, [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}, [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}, [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}, [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2022-47024](https://nvd.nist.gov/vuln/detail/CVE-2022-47024){: external}, [CVE-2023-0049](https://nvd.nist.gov/vuln/detail/CVE-2023-0049){: external}, [CVE-2023-0054](https://nvd.nist.gov/vuln/detail/CVE-2023-0054){: external}, [CVE-2023-0288](https://nvd.nist.gov/vuln/detail/CVE-2023-0288){: external}, [CVE-2023-0433](https://nvd.nist.gov/vuln/detail/CVE-2023-0433){: external}, [CVE-2023-1170](https://nvd.nist.gov/vuln/detail/CVE-2023-1170){: external}, [CVE-2023-1175](https://nvd.nist.gov/vuln/detail/CVE-2023-1175){: external}, [CVE-2023-1264](https://nvd.nist.gov/vuln/detail/CVE-2023-1264){: external}, [CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external}, [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}, [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}, [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}, [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}, [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}. |
| Kubernetes | 1.26.1 | 1.26.3 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.26.3){: external}. |
| Containerd | 1.7.0-rc.3 | 1.7.0 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.7.0){: external}. |
| Haproxy | af5031 | 8398d1 | [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
{: caption="Changes since version 1.26.1_1525" caption-side="bottom"}


### Change log for worker node fix pack 1.26.1_1525, released 13 March 2023
{: #1261_1525}

The following table shows the changes that are in the worker node fix pack 1.26.1_1525. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-139 | 5.4.0-144 | Worker node kernel & package updates for [CVE-2022-29154](https://nvd.nist.gov/vuln/detail/CVE-2022-29154){: external}, [CVE-2022-3545](https://nvd.nist.gov/vuln/detail/CVE-2022-3545){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-41218](https://nvd.nist.gov/vuln/detail/CVE-2022-41218){: external}, [CVE-2022-4139](https://nvd.nist.gov/vuln/detail/CVE-2022-4139){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2022-47520](https://nvd.nist.gov/vuln/detail/CVE-2022-47520){: external}, [CVE-2022-48303](https://nvd.nist.gov/vuln/detail/CVE-2022-48303){: external}, [CVE-2023-0266](https://nvd.nist.gov/vuln/detail/CVE-2023-0266){: external}, [CVE-2023-0361](https://nvd.nist.gov/vuln/detail/CVE-2023-0361){: external}, [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external}, [CVE-2023-0767](https://nvd.nist.gov/vuln/detail/CVE-2023-0767){: external}, [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| Ubuntu 18.04 packages | 4.15.0-204 | 4.15.0-206 | Worker node kernel & package updates for [CVE-2022-29154](https://nvd.nist.gov/vuln/detail/CVE-2022-29154){: external}, [CVE-2022-3545](https://nvd.nist.gov/vuln/detail/CVE-2022-3545){: external}, [CVE-2022-3628](https://nvd.nist.gov/vuln/detail/CVE-2022-3628){: external}, [CVE-2022-37454](https://nvd.nist.gov/vuln/detail/CVE-2022-37454){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-48303](https://nvd.nist.gov/vuln/detail/CVE-2022-48303){: external}, [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external}, [CVE-2023-0767](https://nvd.nist.gov/vuln/detail/CVE-2023-0767){: external}, [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| Kubernetes |N/A|N/A|N/A|
| Containerd | 1.7.0-rc.1 | 1.7.0-rc.3 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.7.0-rc.3){: external}. |
{: caption="Changes since version 1.26.1_1522" caption-side="bottom"}


### Change log for master fix pack 1.26.1_1524, released 2 March 2023
{: #1261_1524}

The following table shows the changes that are in the master fix pack 1.26.1_1524. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.24.5 | v3.25.0 | See the [Calico release notes](https://docs.tigera.io/archive/v3.24/release-notes/#v3245){: external}. |
| Cluster health image | v1.3.15 | v1.3.16 | Updated `Go` dependencies and to `Go` version `1.19.6`. Updated universal base image (UBI) to resolve CVEs. |
| CoreDNS | 1.10.0 | 1.10.1 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| etcd | v3.5.6 | v3.5.7 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.7){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1305-amd64 | 1308-amd64 | Updated universal base image (UBI) to resolve [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.6 | v2.3.7 | Updated universal base image (UBI) to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.26.1-2 | v1.26.1-16 | Updated `Go` dependencies. Updated `k8s.io/utils` digest to `a5ecb01`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 425 | 427 | Updated universal base image (UBI) to resolve CVEs. |
| Gateway-enabled cluster controller | 1902 | 1987 | Updated `armada-utils` to version `v1.9.35` |
| Key Management Service provider | v2.6.2 | v2.6.3 | Updated `Go` dependencies and to `Go` version `1.19.6`. |
| Konnectivity agent | v0.1.0_503_iks | v0.1.1_569_iks | Updated to Konnectivity version v0.1.1. |
| Kubernetes NodeLocal DNS cache | 1.22.15 | 1.22.18 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.18){: external}. |
| Load balancer and Load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2325 | 2383 | Updated to `armada-utils` version `1.9.35`. |
| Portieris admission controller | v0.12.6 | v0.13.3 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.3){: external}. |
{: caption="Changes since version 1.26.1_1519" caption-side="bottom"}


### Change log for worker node fix pack 1.26.1_1522, released 27 February 2023
{: #1261_1522}

The following table shows the changes that are in the worker node fix pack 1.26.1_1522. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|containerd| v1.6.17| v1.6.18| See the [1.6.18 change log](https://github.com/containerd/containerd/releases/tag/v1.6.18){: external} and the [security bulletin for CVE-2023-25153 and CVE-2023-25173](https://www.ibm.com/support/pages/node/6960181){: external}. |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23946](https://nvd.nist.gov/vuln/detail/CVE-2023-23946){: external}, [CVE-2023-25725](https://nvd.nist.gov/vuln/detail/CVE-2023-25725){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23946](https://nvd.nist.gov/vuln/detail/CVE-2023-23946){: external}, [CVE-2023-25725](https://nvd.nist.gov/vuln/detail/CVE-2023-25725){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | d38f89 | af5031 | [CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2020-10735](https://nvd.nist.gov/vuln/detail/CVE-2020-10735){: external}, [CVE-2021-28861](https://nvd.nist.gov/vuln/detail/CVE-2021-28861){: external}, [CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}. |
| Default Worker Pool | Ubuntu 18 | Ubuntu 20| For {{site.data.keyword.containerlong_notm}}, default worker-pool is created with Ubuntu 20 Operating system |
{: caption="Changes since version 1.26.1_1521" caption-side="bottom"}


### Change log for worker node fix pack 1.26.1_1521, released 13 February 2023
{: #1261_1521}

The following table shows the changes that are in the worker node fix pack 1.26.1_1521. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-202 | 4.15.0-204 | Worker node kernel & package updates for [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}, [CVE-2022-45142](https://nvd.nist.gov/vuln/detail/CVE-2022-45142){: external}, [CVE-2022-47016](https://nvd.nist.gov/vuln/detail/CVE-2022-47016){: external}, [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}, [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}. |
| Ubuntu 20.04 packages | 5.4.0-137 | 5.4.0-139 | Worker node kernel & package updates for [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}, [CVE-2022-45142](https://nvd.nist.gov/vuln/detail/CVE-2022-45142){: external}, [CVE-2022-47016](https://nvd.nist.gov/vuln/detail/CVE-2022-47016){: external}, [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}, [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | 8d6ea6 | 08c969 | [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
{: caption="Changes since version 1.26.1_1520" caption-side="bottom"}


### Change log for master fix pack 1.26.1_1519 and worker node fix pack 1.26.1_1520, released 1 February 2023
{: #1261_1519_and_1261_1520}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Calico configuration now sets a [BGP password](https://docs.tigera.io/calico/latest/reference/resources/bgppeer#bgppassword){: external} and container network sysctl tuning for `net.ipv4.tcp_keepalive_intvl` to `15`, `net.ipv4.tcp_keepalive_probes` to `6` and `net.ipv4.tcp_keepalive_time` to `40`.  |
| containerd | v1.6.16 | v1.7.0-beta.2 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.7.0-beta.2){: external}. In addition, the image pull progress timeout has been configured to 5 minutes. |
| IBM Cloud Controller Manager | v1.25.6-2 | v1.26.1-2 | Updated to support the Kubernetes `1.26.1` release. Updated `Go` dependencies and to `Go` version `1.19.5`. VPC load balancer creation now honors a user specified name. VPC load balancer update now handles an empty default pool name. |
| Key Management Service provider | v2.5.13 | v2.6.2 | Delayed KMS pod termination until the Kubernetes API server terminates. Updated `Go` dependencies and to `Go` version `1.19.4`. |
| Konnectivity agent and server | v0.0.34_491_iks | v0.1.0_503_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.0){: external}. |
| Kubernetes | v1.25.6 | v1.26.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.26.1){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the [kube-proxy configuration](/docs/containers?topic=containers-service-settings#kube-proxy){: external}. |
| Kubernetes add-on resizer | 1.8.15 | 1.8.16 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.16){: external}. In addition, a liveness probe has been configured to improve availability. |
| Kubernetes DNS autoscaler configuration | N/A | N/A | Memory resource requests were increased from `5Mi` to `7Mi` to better align with normal resource utilization. In addition, a liveness probe has been configured to improve availability. |
| Kubernetes Metrics Server | v0.6.0 | v0.6.2 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.2){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.13 | 1.22.15 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.15){: external}. |
| Pause container image | 3.8 | 3.9 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: caption="Changes since version 1.25." caption-side="bottom"}


