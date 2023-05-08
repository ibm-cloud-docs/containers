---

copyright: 
  years: 2022, 2023
lastupdated: "2023-05-08"

keywords: kubernetes, containers

subcollection: containers


---
# Kubernetes version 1.24 change log
{: #changelog_124}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.24. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_124}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.24 change log
{: #124_changelog}


Review the version 1.24 change log.
{: shortdesc}


### Change log for worker node fix pack 1.24.13_1567, released 9 May 2023
{: #12413_1567}

The following table shows the changes that are in the worker node fix pack 1.24.13_1567. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-209-generic | 4.15.0-210-generic | Worker node kernel & package updates for [CVE-2023-1786](https://nvd.nist.gov/vuln/detail/CVE-2023-1786){: external}, [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}, [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}, [CVE-2023-1829](https://nvd.nist.gov/vuln/detail/CVE-2023-1829){: external}, [CVE-2023-25652](https://nvd.nist.gov/vuln/detail/CVE-2023-25652){: external}, [CVE-2023-25815](https://nvd.nist.gov/vuln/detail/CVE-2023-25815){: external}, [CVE-2023-29007](https://nvd.nist.gov/vuln/detail/CVE-2023-29007){: external}. |
| Ubuntu 20.04 packages | 5.4.0-139-generic | 5.4.0-148-generic| Worker node kernel & package updates for [CVE-2023-1786](https://nvd.nist.gov/vuln/detail/CVE-2023-1786){: external}, [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}, [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}, [CVE-2023-1829](https://nvd.nist.gov/vuln/detail/CVE-2023-1829){: external}, [CVE-2023-25652](https://nvd.nist.gov/vuln/detail/CVE-2023-25652){: external}, [CVE-2023-25815](https://nvd.nist.gov/vuln/detail/CVE-2023-25815){: external}, [CVE-2023-29007](https://nvd.nist.gov/vuln/detail/CVE-2023-29007){: external}. |
| Kubernetes | N/A |N/A|N/A|
{: caption="Changes since version 1.24.13_1566" caption-side="bottom"}


### Change log for master fix pack 1.24.13_1566, released 27 April 2023
{: #12413_1566}

The following table shows the changes that are in the master fix pack 1.24.13_1566. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.17 | v1.3.19 | Updated `Go` to version `1.19.8` and updated dependencies. |
| Gateway-enabled cluster controller | 2024 | 2106 | Support Ubuntu 20 and update image to resolve CVEs. |
| GPU device plug-in | a873e90 | fc4cf22 | Updated `Go` to version `1.19.7`. |
| GPU installer | a873e90 | 28d80a0 | Updated `Go` to version `1.19.8`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1366-amd64 | 1390-amd64 | Eliminate IP syscall. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.0 | v2.4.5 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.19.8` and updated dependencies. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.12-1 | v1.24.13-1 | Updated to support the Kubernetes `1.24.13` release. Updated `Go` dependencies and to `Go` version `1.19.8`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 429 | 431 | Updated `Go` to version `1.19.8` and updated dependencies. Update UBI base image. |
| Key Management Service provider | v2.6.4 | v2.6.5 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Konnectivity agent and server | v0.1.1_569_iks-amd64 | v0.1.2_591_iks-amd64 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.2){: external}. Updated configuration to set `keepalive-time` to `40s`. |
| Kubernetes | v1.24.12 | v1.24.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.13){: external}. |
| Kubernetes Metrics Server configuration | N/A | N/A | Updated to use TLS version 1.3 ciphers. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2420 | 2486 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Portieris admission controller | v0.13.3 | v0.13.4 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.4){: external}. |
{: caption="Changes since version 1.24.12_1559" caption-side="bottom"}


### Change log for worker node fix pack 1.24.13_1566, released 24 April 2023
{: #12413_1566}

The following table shows the changes that are in the worker node fix pack 1.24.13_1566. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-208-generic | 4.15.0-209-generic | Worker node package updates for  [CVE-2021-4192](https://nvd.nist.gov/vuln/detail/CVE-2021-4192){: external}, [CVE-2021-4193](https://nvd.nist.gov/vuln/detail/CVE-2021-4193){: external}, [CVE-2022-0213](https://nvd.nist.gov/vuln/detail/CVE-2022-0213){: external}, [CVE-2022-0261](https://nvd.nist.gov/vuln/detail/CVE-2022-0261){: external}, [CVE-2022-0318](https://nvd.nist.gov/vuln/detail/CVE-2022-0318){: external}, [CVE-2022-0319](https://nvd.nist.gov/vuln/detail/CVE-2022-0319){: external}, [CVE-2022-0351](https://nvd.nist.gov/vuln/detail/CVE-2022-0351){: external}, [CVE-2022-0359](https://nvd.nist.gov/vuln/detail/CVE-2022-0359){: external}, [CVE-2022-0361](https://nvd.nist.gov/vuln/detail/CVE-2022-0361){: external}, [CVE-2022-0368](https://nvd.nist.gov/vuln/detail/CVE-2022-0368){: external}, [CVE-2022-0408](https://nvd.nist.gov/vuln/detail/CVE-2022-0408){: external}, [CVE-2022-0443](https://nvd.nist.gov/vuln/detail/CVE-2022-0443){: external}, [CVE-2022-0554](https://nvd.nist.gov/vuln/detail/CVE-2022-0554){: external}, [CVE-2022-0572](https://nvd.nist.gov/vuln/detail/CVE-2022-0572){: external}, [CVE-2022-0685](https://nvd.nist.gov/vuln/detail/CVE-2022-0685){: external}, [CVE-2022-0714](https://nvd.nist.gov/vuln/detail/CVE-2022-0714){: external}, [CVE-2022-0729](https://nvd.nist.gov/vuln/detail/CVE-2022-0729){: external}, [CVE-2022-2207](https://nvd.nist.gov/vuln/detail/CVE-2022-2207){: external}, [CVE-2022-3903](https://nvd.nist.gov/vuln/detail/CVE-2022-3903){: external}, [CVE-2023-1281](https://nvd.nist.gov/vuln/detail/CVE-2023-1281){: external}, [CVE-2023-1326](https://nvd.nist.gov/vuln/detail/CVE-2023-1326){: external}, [CVE-2023-26545](https://nvd.nist.gov/vuln/detail/CVE-2023-26545){: external}, [CVE-2023-28450](https://nvd.nist.gov/vuln/detail/CVE-2023-28450){: external}, [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}, [CVE-2023-28486](https://nvd.nist.gov/vuln/detail/CVE-2023-28486){: external}, [CVE-2023-28487](https://nvd.nist.gov/vuln/detail/CVE-2023-28487){: external}, [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-4166](https://nvd.nist.gov/vuln/detail/CVE-2021-4166){: external}, [CVE-2021-4192](https://nvd.nist.gov/vuln/detail/CVE-2021-4192){: external}, [CVE-2021-4193](https://nvd.nist.gov/vuln/detail/CVE-2021-4193){: external}, [CVE-2022-0213](https://nvd.nist.gov/vuln/detail/CVE-2022-0213){: external}, [CVE-2022-0261](https://nvd.nist.gov/vuln/detail/CVE-2022-0261){: external}, [CVE-2022-0318](https://nvd.nist.gov/vuln/detail/CVE-2022-0318){: external}, [CVE-2022-0319](https://nvd.nist.gov/vuln/detail/CVE-2022-0319){: external}, [CVE-2022-0351](https://nvd.nist.gov/vuln/detail/CVE-2022-0351){: external}, [CVE-2022-0359](https://nvd.nist.gov/vuln/detail/CVE-2022-0359){: external}, [CVE-2022-0361](https://nvd.nist.gov/vuln/detail/CVE-2022-0361){: external}, [CVE-2022-0368](https://nvd.nist.gov/vuln/detail/CVE-2022-0368){: external}, [CVE-2022-0408](https://nvd.nist.gov/vuln/detail/CVE-2022-0408){: external}, [CVE-2022-0443](https://nvd.nist.gov/vuln/detail/CVE-2022-0443){: external}, [CVE-2022-0554](https://nvd.nist.gov/vuln/detail/CVE-2022-0554){: external}, [CVE-2022-0572](https://nvd.nist.gov/vuln/detail/CVE-2022-0572){: external}, [CVE-2022-0629](https://nvd.nist.gov/vuln/detail/CVE-2022-0629){: external}, [CVE-2022-0685](https://nvd.nist.gov/vuln/detail/CVE-2022-0685){: external}, [CVE-2022-0714](https://nvd.nist.gov/vuln/detail/CVE-2022-0714){: external}, [CVE-2022-0729](https://nvd.nist.gov/vuln/detail/CVE-2022-0729){: external}, [CVE-2022-2207](https://nvd.nist.gov/vuln/detail/CVE-2022-2207){: external}, [CVE-2022-3108](https://nvd.nist.gov/vuln/detail/CVE-2022-3108){: external}, [CVE-2022-3903](https://nvd.nist.gov/vuln/detail/CVE-2022-3903){: external}, [CVE-2023-1281](https://nvd.nist.gov/vuln/detail/CVE-2023-1281){: external}, [CVE-2023-1326](https://nvd.nist.gov/vuln/detail/CVE-2023-1326){: external}, [CVE-2023-26545](https://nvd.nist.gov/vuln/detail/CVE-2023-26545){: external}, [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}, [CVE-2023-28486](https://nvd.nist.gov/vuln/detail/CVE-2023-28486){: external}, [CVE-2023-28487](https://nvd.nist.gov/vuln/detail/CVE-2023-28487){: external}, [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}. |
| Kubernetes | 1.24.12 | 1.24.13 | See [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.13){: external}. |
| Containerd |N/A|N/A|N/A|
| Haproxy |N/A|N/A|N/A|
{: caption="Changes since version 1.24.12_1564" caption-side="bottom"}


### Change log for worker node fix pack 1.24.12_1564, released 11 April 2023
{: #12412_1564}

The following table shows the changes that are in the worker node fix pack 1.24.12_1564. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-206 | 4.15.0-208 | Worker node kernel & package updates for [CVE-2021-3669](https://nvd.nist.gov/vuln/detail/CVE-2021-3669){: external}, [CVE-2022-0413](https://nvd.nist.gov/vuln/detail/CVE-2022-0413){: external}, [CVE-2022-1629](https://nvd.nist.gov/vuln/detail/CVE-2022-1629){: external}, [CVE-2022-1674](https://nvd.nist.gov/vuln/detail/CVE-2022-1674){: external}, [CVE-2022-1720](https://nvd.nist.gov/vuln/detail/CVE-2022-1720){: external}, [CVE-2022-1733](https://nvd.nist.gov/vuln/detail/CVE-2022-1733){: external}, [CVE-2022-1735](https://nvd.nist.gov/vuln/detail/CVE-2022-1735){: external}, [CVE-2022-1785](https://nvd.nist.gov/vuln/detail/CVE-2022-1785){: external}, [CVE-2022-1796](https://nvd.nist.gov/vuln/detail/CVE-2022-1796){: external}, [CVE-2022-1851](https://nvd.nist.gov/vuln/detail/CVE-2022-1851){: external}, [CVE-2022-1898](https://nvd.nist.gov/vuln/detail/CVE-2022-1898){: external}, [CVE-2022-1942](https://nvd.nist.gov/vuln/detail/CVE-2022-1942){: external}, [CVE-2022-1968](https://nvd.nist.gov/vuln/detail/CVE-2022-1968){: external}, [CVE-2022-2124](https://nvd.nist.gov/vuln/detail/CVE-2022-2124){: external}, [CVE-2022-2125](https://nvd.nist.gov/vuln/detail/CVE-2022-2125){: external}, [CVE-2022-2126](https://nvd.nist.gov/vuln/detail/CVE-2022-2126){: external}, [CVE-2022-2129](https://nvd.nist.gov/vuln/detail/CVE-2022-2129){: external}, [CVE-2022-2175](https://nvd.nist.gov/vuln/detail/CVE-2022-2175){: external}, [CVE-2022-2183](https://nvd.nist.gov/vuln/detail/CVE-2022-2183){: external}, [CVE-2022-2206](https://nvd.nist.gov/vuln/detail/CVE-2022-2206){: external}, [CVE-2022-2304](https://nvd.nist.gov/vuln/detail/CVE-2022-2304){: external}, [CVE-2022-2345](https://nvd.nist.gov/vuln/detail/CVE-2022-2345){: external}, [CVE-2022-2571](https://nvd.nist.gov/vuln/detail/CVE-2022-2571){: external}, [CVE-2022-2581](https://nvd.nist.gov/vuln/detail/CVE-2022-2581){: external}, [CVE-2022-2845](https://nvd.nist.gov/vuln/detail/CVE-2022-2845){: external}, [CVE-2022-2849](https://nvd.nist.gov/vuln/detail/CVE-2022-2849){: external}, [CVE-2022-2923](https://nvd.nist.gov/vuln/detail/CVE-2022-2923){: external}, [CVE-2022-2946](https://nvd.nist.gov/vuln/detail/CVE-2022-2946){: external}, [CVE-2022-41218](https://nvd.nist.gov/vuln/detail/CVE-2022-41218){: external}, [CVE-2023-0045](https://nvd.nist.gov/vuln/detail/CVE-2023-0045){: external}, [CVE-2023-0266](https://nvd.nist.gov/vuln/detail/CVE-2023-0266){: external}, [CVE-2023-23559](https://nvd.nist.gov/vuln/detail/CVE-2023-23559){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-0413](https://nvd.nist.gov/vuln/detail/CVE-2022-0413){: external}, [CVE-2022-1629](https://nvd.nist.gov/vuln/detail/CVE-2022-1629){: external}, [CVE-2022-1674](https://nvd.nist.gov/vuln/detail/CVE-2022-1674){: external}, [CVE-2022-1720](https://nvd.nist.gov/vuln/detail/CVE-2022-1720){: external}, [CVE-2022-1733](https://nvd.nist.gov/vuln/detail/CVE-2022-1733){: external}, [CVE-2022-1735](https://nvd.nist.gov/vuln/detail/CVE-2022-1735){: external}, [CVE-2022-1785](https://nvd.nist.gov/vuln/detail/CVE-2022-1785){: external}, [CVE-2022-1796](https://nvd.nist.gov/vuln/detail/CVE-2022-1796){: external}, [CVE-2022-1851](https://nvd.nist.gov/vuln/detail/CVE-2022-1851){: external}, [CVE-2022-1898](https://nvd.nist.gov/vuln/detail/CVE-2022-1898){: external}, [CVE-2022-1927](https://nvd.nist.gov/vuln/detail/CVE-2022-1927){: external}, [CVE-2022-1942](https://nvd.nist.gov/vuln/detail/CVE-2022-1942){: external}, [CVE-2022-1968](https://nvd.nist.gov/vuln/detail/CVE-2022-1968){: external}, [CVE-2022-2124](https://nvd.nist.gov/vuln/detail/CVE-2022-2124){: external}, [CVE-2022-2125](https://nvd.nist.gov/vuln/detail/CVE-2022-2125){: external}, [CVE-2022-2126](https://nvd.nist.gov/vuln/detail/CVE-2022-2126){: external}, [CVE-2022-2129](https://nvd.nist.gov/vuln/detail/CVE-2022-2129){: external}, [CVE-2022-2175](https://nvd.nist.gov/vuln/detail/CVE-2022-2175){: external}, [CVE-2022-2183](https://nvd.nist.gov/vuln/detail/CVE-2022-2183){: external}, [CVE-2022-2206](https://nvd.nist.gov/vuln/detail/CVE-2022-2206){: external}, [CVE-2022-2304](https://nvd.nist.gov/vuln/detail/CVE-2022-2304){: external}, [CVE-2022-2344](https://nvd.nist.gov/vuln/detail/CVE-2022-2344){: external}, [CVE-2022-2345](https://nvd.nist.gov/vuln/detail/CVE-2022-2345){: external}, [CVE-2022-2571](https://nvd.nist.gov/vuln/detail/CVE-2022-2571){: external}, [CVE-2022-2581](https://nvd.nist.gov/vuln/detail/CVE-2022-2581){: external}, [CVE-2022-2845](https://nvd.nist.gov/vuln/detail/CVE-2022-2845){: external}, [CVE-2022-2849](https://nvd.nist.gov/vuln/detail/CVE-2022-2849){: external}, [CVE-2022-2923](https://nvd.nist.gov/vuln/detail/CVE-2022-2923){: external}, [CVE-2022-2946](https://nvd.nist.gov/vuln/detail/CVE-2022-2946){: external}, [CVE-2022-2980](https://nvd.nist.gov/vuln/detail/CVE-2022-2980){: external}. Updated `sysctl` setting for `fs.inotify.max_user_instances` from default `128` to `1024`. |
| Kubernetes |N/A|N/A|N/A|
| Haproxy | 8398d1 | 8895ad | [CVE-2023-0361](https://nvd.nist.gov/vuln/detail/CVE-2023-0361){: external}. |
| Containerd | 1.6.19 | 1.6.20 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.20){: external}. |
{: caption="Changes since version 1.24.12_1562" caption-side="bottom"}


### Change log for worker node fix pack 1.24.12_1562, released 29 March 2023
{: #12412_1562}

The following table shows the changes that are in the worker node fix pack 1.24.12_1562. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-144 | 5.4.0-139 | Downgrading kernel to address [Upstream canonical bug](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2009325){: external}. |
{: caption="Changes since version 1.24.12_1560" caption-side="bottom"}


### Change log for master fix pack 1.24.12_1559, released 28 March 2023
{: #12412_1559}

The following table shows the changes that are in the master fix pack 1.24.12_1559. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Calico configuration now sets container network `sysctl` tuning for `net.ipv4.tcp_keepalive_intvl` to `15`, `net.ipv4.tcp_keepalive_probes` to `6` and `net.ipv4.tcp_keepalive_time` to `40`.  |
| Cluster health image | v1.3.16 | v1.3.17 | Updated `Go` to version `1.19.7` and updated dependencies. |
| GPU device plug-in and installer | 79a2232 | a873e90 | Updated `Go` to version `1.19.6`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1308-amd64 | 1366-amd64 | Updated to resolve [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.7 | v2.4.0 | Removed ExpandInUsePersistentVolumes feature gate. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.10-10 | v1.24.12-1 | Updated to support the `Kubernetes 1.24.12` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 427 | 429 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.19.6` and updated dependencies. |
| Key Management Service provider | v2.6.3 | v2.6.4 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Kubernetes | v1.24.10 | v1.24.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.12){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2383 | 2420 | Updated the image to resolve CVEs. |
{: caption="Changes since version 1.24.10_1557" caption-side="bottom"}


### Change log for worker node fix pack 1.24.12_1560, released 27 March 2023
{: #12412_1560}

The following table shows the changes that are in the worker node fix pack 1.24.12_1560. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2022-47024](https://nvd.nist.gov/vuln/detail/CVE-2022-47024){: external}, [CVE-2023-0049](https://nvd.nist.gov/vuln/detail/CVE-2023-0049){: external}, [CVE-2023-0054](https://nvd.nist.gov/vuln/detail/CVE-2023-0054){: external}, [CVE-2023-0288](https://nvd.nist.gov/vuln/detail/CVE-2023-0288){: external}, [CVE-2023-0433](https://nvd.nist.gov/vuln/detail/CVE-2023-0433){: external}, [CVE-2023-1170](https://nvd.nist.gov/vuln/detail/CVE-2023-1170){: external}, [CVE-2023-1175](https://nvd.nist.gov/vuln/detail/CVE-2023-1175){: external}, [CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external}, [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}, [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}, [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}, [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}, [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2022-47024](https://nvd.nist.gov/vuln/detail/CVE-2022-47024){: external}, [CVE-2023-0049](https://nvd.nist.gov/vuln/detail/CVE-2023-0049){: external}, [CVE-2023-0054](https://nvd.nist.gov/vuln/detail/CVE-2023-0054){: external}, [CVE-2023-0288](https://nvd.nist.gov/vuln/detail/CVE-2023-0288){: external}, [CVE-2023-0433](https://nvd.nist.gov/vuln/detail/CVE-2023-0433){: external}, [CVE-2023-1170](https://nvd.nist.gov/vuln/detail/CVE-2023-1170){: external}, [CVE-2023-1175](https://nvd.nist.gov/vuln/detail/CVE-2023-1175){: external}, [CVE-2023-1264](https://nvd.nist.gov/vuln/detail/CVE-2023-1264){: external}, [CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external}, [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}, [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}, [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}, [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}, [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}. |
| Kubernetes | 1.24.10 | 1.24.12 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.12){: external}. |
| Containerd |N/A|N/A|N/A|
| Haproxy | af5031 | 8398d1 | [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
{: caption="Changes since version 1.24.10_1558" caption-side="bottom"}


### Change log for worker node fix pack 1.24.10_1558, released 13 March 2023
{: #12410_1558}

The following table shows the changes that are in the worker node fix pack 1.24.10_1558. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-139 | 5.4.0-144 | Worker node kernel & package updates for [CVE-2022-29154](https://nvd.nist.gov/vuln/detail/CVE-2022-29154){: external}, [CVE-2022-3545](https://nvd.nist.gov/vuln/detail/CVE-2022-3545){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-41218](https://nvd.nist.gov/vuln/detail/CVE-2022-41218){: external}, [CVE-2022-4139](https://nvd.nist.gov/vuln/detail/CVE-2022-4139){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2022-47520](https://nvd.nist.gov/vuln/detail/CVE-2022-47520){: external}, [CVE-2022-48303](https://nvd.nist.gov/vuln/detail/CVE-2022-48303){: external}, [CVE-2023-0266](https://nvd.nist.gov/vuln/detail/CVE-2023-0266){: external}, [CVE-2023-0361](https://nvd.nist.gov/vuln/detail/CVE-2023-0361){: external}, [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external}, [CVE-2023-0767](https://nvd.nist.gov/vuln/detail/CVE-2023-0767){: external}, [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| Ubuntu 18.04 packages | 4.15.0-204 | 4.15.0-206 | Worker node kernel & package updates for [CVE-2022-29154](https://nvd.nist.gov/vuln/detail/CVE-2022-29154){: external}, [CVE-2022-3545](https://nvd.nist.gov/vuln/detail/CVE-2022-3545){: external}, [CVE-2022-3628](https://nvd.nist.gov/vuln/detail/CVE-2022-3628){: external}, [CVE-2022-37454](https://nvd.nist.gov/vuln/detail/CVE-2022-37454){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-48303](https://nvd.nist.gov/vuln/detail/CVE-2022-48303){: external}, [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external}, [CVE-2023-0767](https://nvd.nist.gov/vuln/detail/CVE-2023-0767){: external}, [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| Kubernetes |N/A|N/A|N/A|
| Containerd | 1.6.18 | 1.6.19 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.19){: external}. |
{: caption="Changes since version 1.24.10_1554" caption-side="bottom"}


### Change log for master fix pack 1.24.10_1557, released 2 March 2023
{: #12410_1557}

The following table shows the changes that are in the master fix pack 1.24.10_1557. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.15 | v1.3.16 | Updated `Go` dependencies and to `Go` version `1.19.6`. Updated universal base image (UBI) to resolve CVEs. |
| etcd | v3.5.6 | v3.5.7 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.7){: external}. |
| Gateway-enabled cluster controller | 1902 | 1987 | Updated `armada-utils` to version `v1.9.35` |
| {{site.data.keyword.IBM_notm}} Calico extension | 1280-amd64 | 1308-amd64 | Updated universal base image (UBI) to resolve [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.6 | v2.3.7 | Updated universal base image (UBI) to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.10-2 | v1.24.10-10 | Updated `Go` dependencies. Updated `k8s.io/utils` digest to `a5ecb01`. Updated `vpcctl` to `v0.10.0`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 425 | 427 | Updated universal base image (UBI) to resolve CVEs. |
| Key Management Service provider | v2.5.13 | v2.6.3 | Updated `Go` dependencies and to `Go` version `1.19.6`. |
| Konnectivity agent and server | v0.0.34_491_iks | v0.1.1_569_iks-amd64 | Updated to Konnectivity version v0.1.0. |
| Kubernetes NodeLocal DNS cache | 1.22.11 | 1.22.18-amd64 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.18){: external}. |
| Load balancer and Load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2325 | 2383 | Updated to `armada-utils` version `1.9.35`. |
| Portieris admission controller | v0.12.6 | v0.13.3 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.3){: external}. |
{: caption="Changes since version 1.24.10_1551" caption-side="bottom"}


### Change log for worker node fix pack 1.24.10_1554, released 27 February 2023
{: #12410_1554}

The following table shows the changes that are in the worker node fix pack 1.24.10_1554. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|containerd| v1.6.17| v1.6.18| See the [1.6.18 change log](https://github.com/containerd/containerd/releases/tag/v1.6.18){: external} and the [security bulletin for CVE-2023-25153 and CVE-2023-25173](https://www.ibm.com/support/pages/node/6960181){: external}. |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23946](https://nvd.nist.gov/vuln/detail/CVE-2023-23946){: external}, [CVE-2023-25725](https://nvd.nist.gov/vuln/detail/CVE-2023-25725){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23946](https://nvd.nist.gov/vuln/detail/CVE-2023-23946){: external}, [CVE-2023-25725](https://nvd.nist.gov/vuln/detail/CVE-2023-25725){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | d38f89 | af5031 | [CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2020-10735](https://nvd.nist.gov/vuln/detail/CVE-2020-10735){: external}, [CVE-2021-28861](https://nvd.nist.gov/vuln/detail/CVE-2021-28861){: external}, [CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}. |
| Default Worker Pool | Ubuntu 18 | Ubuntu 20| For {{site.data.keyword.containerlong_notm}}, default `worker-pool` is created with Ubuntu 20 Operating system |
{: caption="Changes since version 1.24.10_1553" caption-side="bottom"}


### Change log for worker node fix pack 1.24.10_1553, released 13 February 2023
{: #12410_1553}

The following table shows the changes that are in the worker node fix pack 1.24.10_1553. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-202 | 4.15.0-204 | Worker node kernel & package updates for [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}, [CVE-2022-45142](https://nvd.nist.gov/vuln/detail/CVE-2022-45142){: external}, [CVE-2022-47016](https://nvd.nist.gov/vuln/detail/CVE-2022-47016){: external}, [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}, [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}. |
| Ubuntu 20.04 packages | 5.4.0-137 | 5.4.0-139 | Worker node kernel & package updates for [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}, [CVE-2022-45142](https://nvd.nist.gov/vuln/detail/CVE-2022-45142){: external}, [CVE-2022-47016](https://nvd.nist.gov/vuln/detail/CVE-2022-47016){: external}, [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}, [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | 8d6ea6 | 08c969 | [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
{: caption="Changes since version 1.24.10_1552" caption-side="bottom"}


### Change log for master fix pack 1.24.10_1551, released 30 January 2023
{: #12410_1551}

The following table shows the changes that are in the master fix pack 1.24.10_1551. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.14 | v1.3.15 | Updated `Go` dependencies and to `Go` version `1.19.4`. |
| GPU device plug-in and installer | 03fd318 | 79a2232 | Updated `Go` to version `1.19.4`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1257 | 1280 | Publish s390x image. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.4 | v2.3.6 | Updated `UBI images` to `8.7-1031` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.8-3 | v1.24.10-2 | Updated to support the `Kubernetes 1.24.10` release. Updated `Go` dependencies and to `Go` version `1.19.5`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 421 | 425 | Fixes for [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external} and [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external}. |
| Key Management Service provider | v2.5.12 | v2.5.13 | Updated `Go` dependencies and to `Go` version `1.19.4`. Changed to focal distribution. |
| Konnectivity agent and server | v0.0.33_418_iks | v0.0.34_491_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.34){: external}. |
| Kubernetes | v1.24.9 | v1.24.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.10){: external}. |
{: caption="Changes since version 1.24.9_1547" caption-side="bottom"}


### Change log for worker node fix pack 1.24.10_1552, released 30 January 2023
{: #12410_1552}

The following table shows the changes that are in the worker node fix pack 1.24.10_1552. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2018-20217](https://nvd.nist.gov/vuln/detail/CVE-2018-20217){: external},[CVE-2022-23521](https://nvd.nist.gov/vuln/detail/CVE-2022-23521){: external},[CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external},[CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external},[CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external},[CVE-2022-41903](https://nvd.nist.gov/vuln/detail/CVE-2022-41903){: external},[CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external},[CVE-2023-22809](https://nvd.nist.gov/vuln/detail/CVE-2023-22809){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2021-33503](https://nvd.nist.gov/vuln/detail/CVE-2021-33503){: external},[CVE-2022-23521](https://nvd.nist.gov/vuln/detail/CVE-2022-23521){: external},[CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external},[CVE-2022-3094](https://nvd.nist.gov/vuln/detail/CVE-2022-3094){: external},[CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external},[CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external},[CVE-2022-41903](https://nvd.nist.gov/vuln/detail/CVE-2022-41903){: external},[CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external},[CVE-2023-0056](https://nvd.nist.gov/vuln/detail/CVE-2023-0056){: external},[CVE-2023-22809](https://nvd.nist.gov/vuln/detail/CVE-2023-22809){: external}. |
| Kubernetes | 1.24.9 | 1.24.10 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.10){: external}. |
| HAProxy | 508bf6 | 8d6ea6 | [CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external},[CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external},[CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external},[CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external},[CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external},[CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external},[CVE-2022-35737](https://nvd.nist.gov/vuln/detail/CVE-2022-35737){: external},[CVE-2022-43680](https://nvd.nist.gov/vuln/detail/CVE-2022-43680){: external},[CVE-2021-46848](https://nvd.nist.gov/vuln/detail/CVE-2021-46848){: external}. |
{: caption="Changes since version 1.24.9_1550" caption-side="bottom"}


### Change log for worker node fix pack 1.24.9_1550, released 16 January 2023
{: #1249_1550}

The following table shows the changes that are in the worker node fix pack 1.24.9_1550. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-200 | 4.15.0-202 | Worker node kernel & package updates for [CVE-2021-44758](https://nvd.nist.gov/vuln/detail/CVE-2021-44758){: external},[CVE-2022-0392](https://nvd.nist.gov/vuln/detail/CVE-2022-0392){: external},[CVE-2022-2663](https://nvd.nist.gov/vuln/detail/CVE-2022-2663){: external},[CVE-2022-3061](https://nvd.nist.gov/vuln/detail/CVE-2022-3061){: external},[CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external},[CVE-2022-3643](https://nvd.nist.gov/vuln/detail/CVE-2022-3643){: external},[CVE-2022-42896](https://nvd.nist.gov/vuln/detail/CVE-2022-42896){: external},[CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external},[CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external},[CVE-2022-43945](https://nvd.nist.gov/vuln/detail/CVE-2022-43945){: external},[CVE-2022-44640](https://nvd.nist.gov/vuln/detail/CVE-2022-44640){: external},[CVE-2022-45934](https://nvd.nist.gov/vuln/detail/CVE-2022-45934){: external},[CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
| Ubuntu 20.04 packages | 5.4.0-135 | 5.4.0-137 | Worker node kernel & package updates for [CVE-2021-44758](https://nvd.nist.gov/vuln/detail/CVE-2021-44758){: external},[CVE-2022-0392](https://nvd.nist.gov/vuln/detail/CVE-2022-0392){: external},[CVE-2022-0417](https://nvd.nist.gov/vuln/detail/CVE-2022-0417){: external},[CVE-2022-2663](https://nvd.nist.gov/vuln/detail/CVE-2022-2663){: external},[CVE-2022-3061](https://nvd.nist.gov/vuln/detail/CVE-2022-3061){: external},[CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external},[CVE-2022-3643](https://nvd.nist.gov/vuln/detail/CVE-2022-3643){: external},[CVE-2022-42896](https://nvd.nist.gov/vuln/detail/CVE-2022-42896){: external},[CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external},[CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external},[CVE-2022-43945](https://nvd.nist.gov/vuln/detail/CVE-2022-43945){: external},[CVE-2022-44640](https://nvd.nist.gov/vuln/detail/CVE-2022-44640){: external},[CVE-2022-45934](https://nvd.nist.gov/vuln/detail/CVE-2022-45934){: external},[CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.9_1549" caption-side="bottom"}


### Change log for worker node fix pack 1.24.9_1549, released 02 January 2023
{: #1249_1549}

The following table shows the changes that are in the worker node fix pack 1.24.9_1549. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A|N/A|
| Ubuntu 20.04 packages |N/A|N/A|N/A|
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.9_1548" caption-side="bottom"}


### Change log for worker node fix pack 1.24.9_1548, released 19 December 2022
{: #1249_1548}

The following table shows the changes that are in the worker node fix pack 1.24.9_1548. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|Containerd|1.6.10|1.6.12|See the [1.6.12 change log](https://github.com/containerd/containerd/releases/tag/v1.6.12){: external}, the [1.6.11 change log](https://github.com/containerd/containerd/releases/tag/v1.6.11){: external}, and the security bulletin for [CVE-2022-23471](https://www.ibm.com/support/pages/node/6850799){: external}. |
| Ubuntu 18.04 packages | 4.15.0-197 | 4.15.0-200 | Worker node kernel & package updates for [CVE-2022-2309](https://nvd.nist.gov/vuln/detail/CVE-2022-2309){: external},[CVE-2022-38533](https://nvd.nist.gov/vuln/detail/CVE-2022-38533){: external},[CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external},[CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external},[CVE-2022-41916](https://nvd.nist.gov/vuln/detail/CVE-2022-41916){: external},[CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}. |
| Ubuntu 20.04 packages | 5.4.0-132 | 5.4.0-135 | Worker node kernel & package updates for [CVE-2022-2309](https://nvd.nist.gov/vuln/detail/CVE-2022-2309){: external},[CVE-2022-38533](https://nvd.nist.gov/vuln/detail/CVE-2022-38533){: external},[CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external},[CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external},[CVE-2022-41916](https://nvd.nist.gov/vuln/detail/CVE-2022-41916){: external}. |
| Kubernetes | 1.24.8 | 1.24.9 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.9){: external}. |
{: caption="Changes since version 1.24.8_1546" caption-side="bottom"}


### Change log for master fix pack 1.24.9_1547, released 14 December 2022
{: #1249_1547}

The following table shows the changes that are in the master fix pack 1.24.9_1547. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.13 | v1.3.14 | Updated `Go` dependencies. Exclude ingress status from cluster status aggregation. |
| etcd | v3.5.5 | v3.5.6 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.6){: external}. |
| GPU device plug-in and installer | cce0cfa | 03fd318 | Update GPU images with `Go` version `1.19.2` to resolve vulnerabilities |
| {{site.data.keyword.IBM_notm}} Calico extension | 1213 | 1257 | Updated universal base image (UBI) to resolve: [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/cve-2022-1304){: external}, [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.3 | v2.3.4 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.18.6` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.7-10 | v1.24.8-3 | Updated to support the `Kubernetes 1.24.8` release. Enable mixed protocol for LoadBalancer Service. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 420 | 421 | Updated universal base image (UBI) to resolve [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. Updated `Go` to version `1.18.8` |
| Key Management Service provider | v2.5.11 | v2.5.12 | Updated `Go` dependencies. |
| Kubernetes | v1.24.8 | v1.24.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.9){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2110 | 2325 | Update `Go` to version `1.19.1` and update dependencies. |
{: caption="Changes since version 1.24.8_1544" caption-side="bottom"}


### Change log for worker node fix pack 1.24.8_1546, released 05 December 2022
{: #1248_1546}

The following table shows the changes that are in the worker node fix pack 1.24.8_1546. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|Containerd|1.6.8|1.6.10|See the [1.6.10 change log](https://github.com/containerd/containerd/releases/tag/v1.6.10){: external} and the [1.6.9 change log](https://github.com/containerd/containerd/releases/tag/v1.6.9){: external}. |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2013-4235](https://nvd.nist.gov/vuln/detail/CVE-2013-4235){: external},[CVE-2022-3239](https://nvd.nist.gov/vuln/detail/CVE-2022-3239){: external},[CVE-2022-3524](https://nvd.nist.gov/vuln/detail/CVE-2022-3524){: external},[CVE-2022-3564](https://nvd.nist.gov/vuln/detail/CVE-2022-3564){: external},[CVE-2022-3565](https://nvd.nist.gov/vuln/detail/CVE-2022-3565){: external},[CVE-2022-3566](https://nvd.nist.gov/vuln/detail/CVE-2022-3566){: external},[CVE-2022-3567](https://nvd.nist.gov/vuln/detail/CVE-2022-3567){: external},[CVE-2022-3594](https://nvd.nist.gov/vuln/detail/CVE-2022-3594){: external},[CVE-2022-3621](https://nvd.nist.gov/vuln/detail/CVE-2022-3621){: external},[CVE-2022-42703](https://nvd.nist.gov/vuln/detail/CVE-2022-42703){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | c619f4 | 508bf6 | [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}. |
| CUDA | fd4353 | 0ab756 | [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}. |
{: caption="Changes since version 1.24.8_1545" caption-side="bottom"}


### Change log for worker node fix pack 1.24.8_1545, released 21 November 2022
{: #1248_1545}

The following table shows the changes that are in the worker node fix pack 1.24.8_1545. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-194 | 4.15.0-197 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external},[CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external},[CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external},[CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external},[CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external},[CVE-2022-2978](https://nvd.nist.gov/vuln/detail/CVE-2022-2978){: external},[CVE-2022-3028](https://nvd.nist.gov/vuln/detail/CVE-2022-3028){: external},[CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external},[CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-35737](https://nvd.nist.gov/vuln/detail/CVE-2022-35737){: external},[CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external},[CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external},[CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external},[CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674){: external},[CVE-2022-40768](https://nvd.nist.gov/vuln/detail/CVE-2022-40768){: external},[CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external},[CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external},[CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external},[CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.24.7 | 1.24.8 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.8){: external}. |
| CUDA | 576234 | cce0cf | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.24.7_1543" caption-side="bottom"}


### Change log for master fix pack 1.24.8_1544, released 16 November 2022
{: #1248_1544}

The following table shows the changes that are in the master fix pack 1.24.8_1544. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.23.3 | v3.24.5 | See the [Calico release notes](https://docs.tigera.io/archive/v3.24/release-notes/#v3245){: external}. |
| Cluster health image | v1.3.12 | v1.3.13 | Updated Go dependencies, `golangci-lint`, `gosec`, and to `Go` version 1.19.3. Updated base image version to 116. |
| etcd | v3.5.4 | v3.5.5 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.5){: external}. |
| Gateway-enabled cluster controller | 1823 | 1902 | `Go` module updates. |
| GPU device plug-in and installer | 373bb9f | cce0cfa | Updated the GPU driver 470 minor version |
| {{site.data.keyword.IBM_notm}} Calico extension | 1096 | 1213 | Updated image to fix the following CVEs: [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2022-3515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3515){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-32149](https://nvd.nist.gov/vuln/detail/CVE-2022-32149){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.1 | v2.3.3 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.7-1 | v1.24.7-10 | Key rotation and updated `Go` dependencies. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 416 | 420 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| Key Management Service provider | v2.5.10 | v2.5.11 | Updated `Go` dependencies and to `Go` version `1.19.3`. |
| Kubernetes | v1.24.7 | v1.24.8 | [CVE-2022-3294](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3294){: external} and [CVE-2022-3162](https://nvd.nist.gov/vuln/detail/CVE-2022-3162){: external}. For more information, see [{{site.data.keyword.containerlong_notm}} is affected by Kubernetes API server security vulnerabilities CVE-2022-3294 and CVE-2022-3162](https://www.ibm.com/support/pages/node/6844715){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.8){: external}. |
{: caption="Changes since version 1.24.7_1542" caption-side="bottom"}


### Change log for worker node fix pack 1.24.7_1543, released 07 November 2022
{: #1247_1543}

The following table shows the changes that are in the worker node fix pack 1.24.7_1543. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external},[CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external},[CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external},[CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external},[CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.24.6 | 1.24.7 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.7){: external}. |
| HAProxy | b034b2 | 3a1392 | [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}. |
| CUDA | 3ea43b | 576234 | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.24.6_1541" caption-side="bottom"}


### Change log for master fix pack 1.24.7_1542, released 27 October 2022
{: #1247_1542}

The following table shows the changes that are in the master fix pack 1.24.7_1542. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.11 | v1.3.12 | Updated `Go` dependencies, golangci-lint, and to `Go` version 1.19.2. Updated base image version to 109. Excluded ingress status from cluster status calculation. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.5-1 | v1.24.7-1 | Updated to support the `Kubernetes 1.24.7` release. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | dc1725a | 778ef2b | Updated to `Go` version `1.18.6`. |
| Key Management Service provider | v2.5.9 | v2.5.10 | Updated `Go` dependencies and to `Go` version `1.19.2`. |
| Kubernetes | v1.24.6 | v1.24.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.7){: external}. |
| Konnectivity agent and server | v0.0.32_363_iks | v0.0.33_418_iks | Updated Konnectivity to version v0.0.33 and added s390x functionality. See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.33){: external}. |
{: caption="Changes since version 1.24.6_1538" caption-side="bottom"}


### Change log for worker node fix pack 1.24.6_1541, released 25 October 2022
{: #1246_1541}

The following table shows the changes that are in the worker node fix pack 1.24.6_1541. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-193 | 4.15.0-194 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external}, [CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external}, [CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external}, [CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external}, [CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.6_1540" caption-side="bottom"}


### Change log for worker node fix pack 1.24.6_1540, released 10 October 2022
{: #1246_1540}

The following table shows the changes that are in the worker node fix pack 1.24.6_1540. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A|N/A|
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.6_1539" caption-side="bottom"}


### Change log for master fix pack 1.24.6_1538, released 26 September 2022
{: #1246_1538}

The following table shows the changes that are in the master fix pack 1.24.6_1538. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.10 | v1.3.11 | Updated `Go` dependencies and to `Go` version `1.18.6`. |
| GPU device plug-in and installer | c58c299 | 373bb9f | Updated to `Go` version `1.19.1`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1006 | 1096 | Updated image for [CVE-2022-2526](https://nvd.nist.gov/vuln/detail/CVE-2022-2526){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.9 | v2.3.1 | Updated to `Go` version `1.18.6`. Updated universal base image (UBI) to version `8.6-941` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.4-1 | v1.24.5-1 | Updated `Go` dependencies and to use `Go` version `1.18.6`. Updated to support the Kubernetes `1.24.5` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 414 | 416 | Updated to `Go` version `1.18.6`. Updated universal base image (UBI) to version `8.6-941` to resolve CVEs. |
| Key Management Service Provider | v2.5.8 | v2.5.9 | Updated `Go` dependencies and to `Go` version `1.18.6`. |
| Kubernetes | v1.24.4 | v1.24.6 | This update resolves [CVE-2022-3172](https://nvd.nist.gov/vuln/detail/CVE-2022-3172){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6823785){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.6){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.6 | 1.22.11 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.11){: external}. |
{: caption="Changes since version 1.24.41536" caption-side="bottom"}


### Change log for worker node fix pack 1.24.6_1539, released 26 September 2022
{: #1246_1539}

The following table shows the changes that are in the worker node fix pack 1.24.6_1539. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-192 | 4.15.0-193 | Worker node kernel & package updates for [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2021-33655](https://nvd.nist.gov/vuln/detail/CVE-2021-33655){: external},[CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external},[CVE-2022-0943](https://nvd.nist.gov/vuln/detail/CVE-2022-0943){: external},[CVE-2022-1154](https://nvd.nist.gov/vuln/detail/CVE-2022-1154){: external},[CVE-2022-1616](https://nvd.nist.gov/vuln/detail/CVE-2022-1616){: external},[CVE-2022-1619](https://nvd.nist.gov/vuln/detail/CVE-2022-1619){: external},[CVE-2022-1620](https://nvd.nist.gov/vuln/detail/CVE-2022-1620){: external},[CVE-2022-1621](https://nvd.nist.gov/vuln/detail/CVE-2022-1621){: external},[CVE-2022-2526](https://nvd.nist.gov/vuln/detail/CVE-2022-2526){: external},[CVE-2022-2795](https://nvd.nist.gov/vuln/detail/CVE-2022-2795){: external},[CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external},[CVE-2022-36946](https://nvd.nist.gov/vuln/detail/CVE-2022-36946){: external},[CVE-2022-38177](https://nvd.nist.gov/vuln/detail/CVE-2022-38177){: external},[CVE-2022-38178](https://nvd.nist.gov/vuln/detail/CVE-2022-38178){: external}. |
| Kubernetes | 1.24.4 | 1.24.6 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.6){: external}. |
{: caption="Changes since version 1.24.4_1537" caption-side="bottom"}


### Change log for worker node fix pack 1.24.4_1537, released 12 September 2022
{: #1244_1537}

The following table shows the changes that are in the worker node fix pack 1.24.4_1537. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-191 | 4.15.0-192 | Worker node kernel & package updates for [CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external},[CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external}. |
| Kubernetes |N/A|N/A|N/A| 
{: caption="Changes since version 1.24.4_1535" caption-side="bottom"}


### Change log for master fix pack 1.24.4_1536, released 1 September 2022
{: #1244_1536}

The following table shows the changes that are in the master fix pack 1.24.4_1536. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.9 | v1.3.10 | Updated `Go` dependencies and to `Go` version `1.18.5`. |
| Gateway-enabled cluster controller | 1792 | 1823 | Updated to `Go` version `1.17.13`. |
| GPU device plug-in and installer | d8f1be0 | c58c299 | Enable DRM module and update `Go` to version `1.18.5`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 997 | 1006 | Updated to `Go` version `1.17.13`. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.8 | v2.2.9 | Updated to `Go` version `1.18.5`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.2-8 | v1.24.4-1 | Updated `vpcctl` binary to version `3367`. Updated to support the Kubernetes `1.24.4` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 412 | 414 | Updated to `Go` version `1.18.5`. Updated universal base image (UBI) to version `8.6-902` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 0a187a4 | dc1725a | Updated `Go` dependencies and to `Go` version `1.18.3`. |
| Key Management Service provider | v2.5.7 | v2.5.8 | Updated `Go` dependencies. |
| Konnectivity agent and server | v0.0.30_331_iks | v0.0.32_363_iks | Updated to `Go` version `1.17.13` and to `Konnectivity` version `v0.0.32`. |
| Kubernetes | v1.24.3 | v1.24.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.4){: external}. |
| Kubernetes Dashboard | v2.5.0 | v2.6.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.6.1){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.7 | v1.0.8 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.8){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.5 | 1.22.6 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2058 | 2110 | Updated `Go` dependencies and to `Go` version `1.17.13`. |
| Portieris admission controller | v0.12.5 | v0.12.6 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.6){: external}. |
{: caption="Changes since version 1.24.3_1531" caption-side="bottom"}


### Change log for worker node fix pack 1.24.4_1535, released 29 August 2022
{: #1244_1535}

The following table shows the changes that are in the worker node fix pack 1.24.4_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2019-5815](https://nvd.nist.gov/vuln/detail/CVE-2019-5815){: external},[CVE-2021-30560](https://nvd.nist.gov/vuln/detail/CVE-2021-30560){: external},[CVE-2022-31676](https://nvd.nist.gov/vuln/detail/CVE-2022-31676){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}. |
| Kubernetes | 1.24.3 | 1.24.4 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.4){: external}. | 
| HAProxy | 6514a2 | c1634f | [CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external},[CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}
{: caption="Changes since version 1.24.3_1533" caption-side="bottom"}


### Change log for worker node fix pack 1.24.3_1533, released 16 August 2022
{: #1243_1533}

The following table shows the changes that are in the worker node fix pack 1.24.3_1533. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-189 | 4.15.0-191 | Worker node kernel & package updates for [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external},[CVE-2021-4209](https://nvd.nist.gov/vuln/detail/CVE-2021-4209){: external},[CVE-2022-1652](https://nvd.nist.gov/vuln/detail/CVE-2022-1652){: external},[CVE-2022-1679](https://nvd.nist.gov/vuln/detail/CVE-2022-1679){: external},[CVE-2022-1734](https://nvd.nist.gov/vuln/detail/CVE-2022-1734){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-2586](https://nvd.nist.gov/vuln/detail/CVE-2022-2586){: external},[CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external},[CVE-2022-34918](https://nvd.nist.gov/vuln/detail/CVE-2022-34918){: external}. |
| Kubernetes |N/A|N/A|N/A| 
| containerd | 1.6.6 | 1.6.8 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.8){: external}. |
{: caption="Changes since version 1.24.3_1532" caption-side="bottom"}


### Change log for worker node fix pack 1.24.3_1532, released 01 August 2022
{: #1243_1532}

The following table shows the changes that are in the worker node fix pack 1.24.3_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2022-27404](https://nvd.nist.gov/vuln/detail/CVE-2022-27404){: external},[CVE-2022-27405](https://nvd.nist.gov/vuln/detail/CVE-2022-27405){: external},[CVE-2022-27406](https://nvd.nist.gov/vuln/detail/CVE-2022-27406){: external},[CVE-2022-29217](https://nvd.nist.gov/vuln/detail/CVE-2022-29217){: external},[CVE-2022-31782](https://nvd.nist.gov/vuln/detail/CVE-2022-31782){: external}. |
| Kubernetes | 1.24.2 | 1.24.3 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.3){: external}. |
{: caption="Changes since version 1.24.2_1529" caption-side="bottom"}


### Change log for master fix pack 1.24.3_1531, released 26 July 2022
{: #1243_1531}

The following table shows the changes that are in the master fix pack 1.24.3_1531. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.23.1 | v3.23.3 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. Updated the Calico custom resource definitions to include `preserveUnknownFields: false`. |
| Cluster health image | v1.3.8 | v1.3.9 | Updated `Go` dependencies and to use `Go` version `1.18.4`. Fixed minor typographical error in the add-on `daemonset not available` health status. |
| Gateway-enabled cluster controller | 1680 | 1792 | Updated to use `Go` version `1.17.11`. Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external} and [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}. |
| GPU device plug-in and installer | 2b0b6d1 | d8f1be0 | Updated `Go` dependencies and to use `Go` version `1.18.3`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 980 | 997 | Updated to use `Go` version `1.17.11`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.6 | v2.2.8 | Updated to use `Go` version `1.18.3`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.1-7 | v1.24.2-8 | Updated `Go` dependencies and to use `Go` version `1.18.3`. Updated to support the Kubernetes `1.24.2` release. [Disabling load balancer NodePort allocation](https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-nodeport-allocation){: external} is now prevented for VPC load balancers. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 410 | 412 | Updated to use `Go` version `1.18.3`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. Improved Kubernetes resource watch configuration. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8c96932 | 0a187a4 | Updated universal base image (UBI) to resolve CVEs. |
| Key Management Service provider | v2.5.6 | v2.5.7 | Updated `Go` dependencies and to use `Go` version `1.18.4`. |
| Kubernetes | v1.24.2 | v1.24.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.3){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.2 | 1.22.5 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1998 | 2058 | Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external}. |
| Portieris admission controller | v0.12.4 | v0.12.5 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.5){: external}. |
{: caption="Changes since version 1.24.2_1526" caption-side="bottom"}


### Change log for worker node fix pack 1.24.2_1529, released 18 July 2022
{: #1242_1529}

The following table shows the changes that are in the worker node fix pack 1.24.2_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-188 | 4.15.0-189 | Worker node kernel & package updates for [CVE-2015-20107](https://nvd.nist.gov/vuln/detail/CVE-2015-20107){: external}, [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external},[CVE-2022-22747](https://nvd.nist.gov/vuln/detail/CVE-2022-22747){: external}, [CVE-2022-24765](https://nvd.nist.gov/vuln/detail/CVE-2022-24765){: external}, [CVE-2022-29187](https://nvd.nist.gov/vuln/detail/CVE-2022-29187){: external},[CVE-2022-34480](https://nvd.nist.gov/vuln/detail/CVE-2022-34480){: external},[CVE-2022-34903](https://nvd.nist.gov/vuln/detail/CVE-2022-34903){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.2_1527" caption-side="bottom"}


### Change log for worker node fix pack 1.24.2_1527, released 05 July 2022
{: #1242_1527}

The following table shows the changes that are in the worker node fix pack 1.24.2_1527. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-187 | 4.15.0-188 | Worker node kernel & package updates for [CVE-2022-1292](https://nvd.nist.gov/vuln/detail/CVE-2022-1292){: external},[CVE-2022-2068](https://nvd.nist.gov/vuln/detail/CVE-2022-2068){: external},[CVE-2022-2084](https://nvd.nist.gov/vuln/detail/CVE-2022-2084){: external},[CVE-2022-28388](https://nvd.nist.gov/vuln/detail/CVE-2022-28388){: external},[CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external},[CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.2_1526" caption-side="bottom"}


### Change log for master fix pack 1.24.2_1526, released 22 June 2022
{: #master_1242_1526}

The following table shows the changes that are in the master fix pack 1.24.2_1526. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.4 | v2.2.6 | Bug fixes for the driver installation. Block plugin base images were updated to `ubi`: `8.6-751.1655117800` for CVE-2022-1271 |
| Kubernetes | v1.24.1 | v1.24.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.2){: external}. |
| Kubernetes add-on resizer | 1.8.14 | 1.8.15 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.18.15){: external}. |
{: caption="Changes since version 1.24.1_1523" caption-side="bottom"}


### Change log for worker node fix pack 1.24.2_1526, released 20 June 2022
{: #1242_1526}

The following table shows the changes that are in the worker node fix pack 1.24.2_1526. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-180 | 4.15.0-187 | Worker node kernel & package updates for [CVE-2021-46790](https://nvd.nist.gov/vuln/detail/CVE-2021-46790){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}, [CVE-2022-1419](https://nvd.nist.gov/vuln/detail/CVE-2022-1419){: external}, [CVE-2022-1966](https://nvd.nist.gov/vuln/detail/CVE-2022-1966){: external}, [CVE-2022-21123](https://nvd.nist.gov/vuln/detail/CVE-2022-21123){: external}, [CVE-2022-21125](https://nvd.nist.gov/vuln/detail/CVE-2022-21125){: external}, [CVE-2022-21166](https://nvd.nist.gov/vuln/detail/CVE-2022-21166){: external}, [CVE-2022-21499](https://nvd.nist.gov/vuln/detail/CVE-2022-21499){: external}, [CVE-2022-28390](https://nvd.nist.gov/vuln/detail/CVE-2022-28390){: external}, [CVE-2022-30783](https://nvd.nist.gov/vuln/detail/CVE-2022-30783){: external}, [CVE-2022-30784](https://nvd.nist.gov/vuln/detail/CVE-2022-30784){: external}, [CVE-2022-30785](https://nvd.nist.gov/vuln/detail/CVE-2022-30785){: external}, [CVE-2022-30786](https://nvd.nist.gov/vuln/detail/CVE-2022-30786){: external}, [CVE-2022-30787](https://nvd.nist.gov/vuln/detail/CVE-2022-30787){: external}, [CVE-2022-30788](https://nvd.nist.gov/vuln/detail/CVE-2022-30788){: external}, [CVE-2022-30789](https://nvd.nist.gov/vuln/detail/CVE-2022-30789){: external}. |
| HAProxy | 468c09 | 04f862 | [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}. |
| containerd | v1.6.4 | v1.6.6 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.6){: external}, the [security bulletin](https://www.ibm.com/support/pages/node/6597989){: external} for [CVE-2022-31030](https://nvd.nist.gov/vuln/detail/CVE-2022-31030){: external}, and the [security bulletin](https://www.ibm.com/support/pages/node/6598049){: external} for [CVE-2022-29162](https://nvd.nist.gov/vuln/detail/CVE-2022-29162){: external}. |
| Kubernetes | 1.24.1 | 1.24.2 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.2){: external}. | 
{: caption="Changes since version 1.24.1_1522" caption-side="bottom"}


### Change log for master fix pack 1.24.1_1523 and worker node fix pack 1.24.1_1522, released 9 June 2022
{: #1241_1522}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.21.5 | v3.23.1 | See the [Calico release notes](https://docs.tigera.io/archive/v3.23/release-notes/){: external}. The **default** BGP configuration found in the `default` [BGP Configuration](https://docs.tigera.io/calico/latest/reference/resources/bgpconfig){: external} resource has been updated to set `nodeMeshMaxRestartTime` to `30m`.  This default change is only applied if the cluster does not have a custom BGP configuration. The previous default value was `120s`. |
| CoreDNS | 1.8.7 | 1.9.2 | See the [CoreDNS release notes](https://github.com/coredns/coredns/blob/v1.9.2/notes/coredns-1.9.2.md){: external}. |
| etcd | v3.4.18 | v3.5.4 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.4){: external}. |
| GPU device plug-in and installer | 382ada9 | 2b0b6d1 | Updated image for [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032){: external}, [CVE-2021-3634](https://nvd.nist.gov/vuln/detail/CVE-2021-3634){: external}, [CVE-2021-3737](https://nvd.nist.gov/vuln/detail/CVE-2021-3737){: external} and [CVE-2021-4189](https://nvd.nist.gov/vuln/detail/CVE-2021-4189){: external}. |
| {{site.data.keyword.blockstoragefull}} driver and plug-in | None | v2.2.5 | The {{site.data.keyword.blockstoragefull}} driver and plug-in component is now installed on clusters running classic infrastructure. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.23.7-4 | v1.24.1-4 | Updated to support the Kubernetes `1.24.1` release and `Go` version `1.18.2`. [Disabling load balancer NodePort allocation](https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-nodeport-allocation){: external} is not supported for VPC load balancers. |
| Kubernetes | v1.23.7 | v1.24.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.1){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates). |
| Kubernetes CSI snapshotter CRDs | v4.2.1 | v5.0.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v5.0.1){: external}. |
| Kubernetes Dashboard | v2.4.0 | v2.5.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.5.0){: external}. |
| Kubernetes DNS autoscaler | 1.8.4 | 1.8.5 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.5){: external}. |
| Kubernetes Metrics Server | v0.6.0 | v0.6.0 | Updated to run with a highly available configuration. For more information on this configuration, see the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.0){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.4 | 1.22.2 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.2){: external}. |
| Pause container image | 3.6 | 3.7 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. | 
{: caption="Changes since version 1.23.7_1531 (master) and 1.23.7_1532 (worker node)" caption-side="bottom"}


