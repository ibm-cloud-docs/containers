---

copyright: 
  years: 2022, 2023
lastupdated: "2023-10-26"

keywords: kubernetes, containers, change log, 125 change log, 125 updates

subcollection: containers


---

# Kubernetes version 1.25 change log
{: #changelog_125}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.25. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_125}

In clusters that run version 1.23 or earlier, the {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. In version 1.24 and later, most new beta features are disabled by default. Kubernetes alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.25 change log
{: #125_changelog}


Review the version 1.25 change log.
{: shortdesc}






### Change log for master fix pack 1.25.14_1564, released 25 October 2023
{: #12514_1564_M}

The following table shows the changes that are in the master fix pack 1.25.14_1564. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.4.2 | v1.4.4 | New version contains updates and security fixes. |
| GPU device plug-in and installer | 8e87e60 | 4319682 | New version contains updates and security fixes. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1390 | 1487 | New version contains security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.10 | v2.4.12 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.13-3 | v1.25.14-6 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4e2f346 | f0d3265 | New version contains updates and security fixes. |
| Key Management Service provider | v2.8.2 | v2.8.4 | New version contains updates and security fixes. |
| Kubernetes | v1.25.13 | v1.25.14 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.14){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.23 | 1.22.24 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.24){: external}. |
| Portieris admission controller | v0.13.6 | v0.13.8 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.8){: external}. |
{: caption="Changes since version 1.25.13_1561" caption-side="bottom"}


### Change log for worker node fix pack 1.25.14_1565, released 23 October 2023
{: #12514_1565_W}

The following table shows the changes that are in the worker node fix pack 1.25.14_1565. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-164-generic | 5.4.0-165-generic | Worker node kernel & package updates for [CVE-2022-3234](https://nvd.nist.gov/vuln/detail/CVE-2022-3234){: external}, [CVE-2022-3256](https://nvd.nist.gov/vuln/detail/CVE-2022-3256){: external}, [CVE-2022-3324](https://nvd.nist.gov/vuln/detail/CVE-2022-3324){: external}, [CVE-2022-3352](https://nvd.nist.gov/vuln/detail/CVE-2022-3352){: external}, [CVE-2022-3520](https://nvd.nist.gov/vuln/detail/CVE-2022-3520){: external}, [CVE-2022-3591](https://nvd.nist.gov/vuln/detail/CVE-2022-3591){: external}, [CVE-2022-3705](https://nvd.nist.gov/vuln/detail/CVE-2022-3705){: external}, [CVE-2022-4292](https://nvd.nist.gov/vuln/detail/CVE-2022-4292){: external}, [CVE-2022-4293](https://nvd.nist.gov/vuln/detail/CVE-2022-4293){: external}, [CVE-2023-34319](https://nvd.nist.gov/vuln/detail/CVE-2023-34319){: external}, [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}, [CVE-2023-42752](https://nvd.nist.gov/vuln/detail/CVE-2023-42752){: external}, [CVE-2023-42753](https://nvd.nist.gov/vuln/detail/CVE-2023-42753){: external}, [CVE-2023-42755](https://nvd.nist.gov/vuln/detail/CVE-2023-42755){: external}, [CVE-2023-42756](https://nvd.nist.gov/vuln/detail/CVE-2023-42756){: external}, [CVE-2023-4622](https://nvd.nist.gov/vuln/detail/CVE-2023-4622){: external}, [CVE-2023-4623](https://nvd.nist.gov/vuln/detail/CVE-2023-4623){: external}, [CVE-2023-4881](https://nvd.nist.gov/vuln/detail/CVE-2023-4881){: external}, [CVE-2023-4921](https://nvd.nist.gov/vuln/detail/CVE-2023-4921){: external}. |
| Kubernetes | 1.25.13 | 1.25.14 | see [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.14){: external}. |
| Containerd |N/A|N/A|N/A|
{: caption="Changes since version 1.25.13_1563" caption-side="bottom"}


### Change log for worker node fix pack 1.25.13_1563, released 9 October 2023
{: #12513_1563_W}

The following table shows the changes that are in the worker node fix pack 1.25.13_1563. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-163-generic | 5.4.0-164-generic | Worker node kernel & package updates for [CVE-2021-4001](https://nvd.nist.gov/vuln/detail/CVE-2021-4001){: external}, [CVE-2023-1206](https://nvd.nist.gov/vuln/detail/CVE-2023-1206){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-3212](https://nvd.nist.gov/vuln/detail/CVE-2023-3212){: external}, [CVE-2023-3863](https://nvd.nist.gov/vuln/detail/CVE-2023-3863){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-4194](https://nvd.nist.gov/vuln/detail/CVE-2023-4194){: external}, [CVE-2023-43785](https://nvd.nist.gov/vuln/detail/CVE-2023-43785){: external}, [CVE-2023-43786](https://nvd.nist.gov/vuln/detail/CVE-2023-43786){: external}, [CVE-2023-43787](https://nvd.nist.gov/vuln/detail/CVE-2023-43787){: external}. |
| Kubernetes | N/A |N/A|N/A|
| Containerd | N/A |N/A|N/A|
{: caption="Changes since version 1.25.13_1562" caption-side="bottom"}


### Change log for worker node fix pack 1.25.12_1562, released 27 September 2023
{: #12512_1562_W}

The following table shows the changes that are in the worker node fix pack 1.25.12_1562. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-162-generic | 5.4.0-163-generic| Package updates for [CVE-2023-3341](https://nvd.nist.gov/vuln/detail/CVE-2023-3341){: external}, [CVE-2023-4156](https://nvd.nist.gov/vuln/detail/CVE-2023-4156){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-20900](https://nvd.nist.gov/vuln/detail/CVE-2023-20900){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}. |
| RHEL 8 Packages | 4.18.0-477.21.1.el8_8 | 4.18.0-477.27.1.el8_8 | Worker node kernel & package updates for [CVE-2023-2002](https://nvd.nist.gov/vuln/detail/CVE-2023-2002){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-3776](https://nvd.nist.gov/vuln/detail/CVE-2023-3776){: external}, [CVE-2023-4004](https://nvd.nist.gov/vuln/detail/CVE-2023-4004){: external}, [CVE-2023-20593](https://nvd.nist.gov/vuln/detail/CVE-2023-20593){: external}, [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}, [CVE-2023-30630](https://nvd.nist.gov/vuln/detail/CVE-2023-30630){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}, [CVE-2023-35788](https://nvd.nist.gov/vuln/detail/CVE-2023-35788){: external}. |
{: caption="Changes since version 1.25.12_1558" caption-side="bottom"}


### Change log for master fix pack 1.25.13_1561, released 20 September 2023
{: #12513_1561_M}

The following table shows the changes that are in the master fix pack 1.25.13_1561. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.25.1-amd64 | v3.25.2-amd64 | See the [Calico release notes](https://docs.tigera.io/calico/3.25/release-notes/#v3.25.2){: external}. |
| Cluster health image | v1.3.24 | v1.4.2 | Updated `Go` to version `1.20.8` and updated dependencies. Updated to new base image. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.5 | v2.4.10 | Updated `Go dependencies`. Updated to newer UBI base image. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.12-4 | v1.25.13-3 | Updated to support the `Kubernetes 1.25.13` release. Updated `Go` to version `1.20.7` and updated `Go dependencies`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 434 | 435 | Updated `Go` to version `1.20.6` and updated dependencies. Updated to newer UBI base image. |
| Key Management Service provider | v2.7.3 | v2.8.2 | Updated `Go dependencies`. Changed to new base image. |
| Kubernetes | v1.25.12 | v1.25.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.13){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2631 | 2681 | Updated `Go` to version `1.19.12` and updated `Go dependencies`. |
{: caption="Changes since version 1.25.12_1556" caption-side="bottom"}


### Change log for worker node fix pack 1.25.12_1558, released 12 September 2023
{: #12512_1558_W}

The following table shows the changes that are in the worker node fix pack 1.25.12_1558. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-156-generic | 5.4.0-162-generic | Worker node kernel & package updates for [CVE-2020-21047](https://nvd.nist.gov/vuln/detail/CVE-2020-21047){: external}, [CVE-2021-33294](https://nvd.nist.gov/vuln/detail/CVE-2021-33294){: external}, [CVE-2022-40982](https://nvd.nist.gov/vuln/detail/CVE-2022-40982){: external}, [CVE-2023-20593](https://nvd.nist.gov/vuln/detail/CVE-2023-20593){: external}[CVE-2023-2269](https://nvd.nist.gov/vuln/detail/CVE-2023-2269){: external}, [CVE-2023-31084](https://nvd.nist.gov/vuln/detail/CVE-2023-31084){: external}, [CVE-2023-3268](https://nvd.nist.gov/vuln/detail/CVE-2023-3268){: external}, [CVE-2023-3609](https://nvd.nist.gov/vuln/detail/CVE-2023-3609){: external}, [CVE-2023-3611](https://nvd.nist.gov/vuln/detail/CVE-2023-3611){: external}, [CVE-2023-3776](https://nvd.nist.gov/vuln/detail/CVE-2023-3776){: external}. |
| Containerd | 1.7.4| 1.7.5 |N/A|
{: caption="Changes since version 1.25.12_1557" caption-side="bottom"}


### Change log for master fix pack 1.25.12_1556, released 30 August 2023
{: #12512_1556_M}

The following table shows the changes that are in the master fix pack 1.25.12_1556. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.23 | v1.3.24 | Updated `Go` to version `1.19.12` and updated dependencies. Updated base image version to 378. |
| Gateway-enabled cluster controller | 2322 | 2366 | Update `Go` dependencies to fix [CVE-2023-3978](https://nvd.nist.gov/vuln/detail/CVE-2023-3978){: external}. |
| GPU device plug-in and installer | 495931a | 8e87e60 | Updated `Go` to version `1.19.11` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.12-1 | v1.25.12-4 | Updated `Go` dependencies to resolve a CVE. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 433 | 434 | Updated `Go` to version `1.20.6` and updated dependencies. Updated to newer UBI base image. |
| Key Management Service provider | v2.7.2 | v2.7.3 | Updated `Go` dependencies. |
| Portieris admission controller | v0.13.5 | v0.13.6 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.6){: external}. |
{: caption="Changes since version 1.25.12_1553" caption-side="bottom"}


### Change log for worker node fix pack 1.25.12_1557, released 28th August 2023
{: #12512_1557_W}

The following table shows the changes that are in the worker node fix pack 1.25.12_1557. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-155-generic | 5.4.0-156-generic | Worker node kernel & package updates for [CVE-2022-2598](https://nvd.nist.gov/vuln/detail/CVE-2022-2598){: external}, [CVE-2022-3016](https://nvd.nist.gov/vuln/detail/CVE-2022-3016){: external}, [CVE-2022-3037](https://nvd.nist.gov/vuln/detail/CVE-2022-3037){: external}, [CVE-2022-3099](https://nvd.nist.gov/vuln/detail/CVE-2022-3099){: external}, [CVE-2023-40225](https://nvd.nist.gov/vuln/detail/CVE-2023-40225){: external}. |
{: caption="Changes since version 1.25.12_1555" caption-side="bottom"}


### Change log for worker node fix pack 1.25.12_1555, released 15th August 2023
{: #12512_1555_W}

The following table shows the changes that are in the worker node fix pack 1.25.12_1555. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | N/A | N/A | Package updates for [CVE-2020-36691](https://nvd.nist.gov/vuln/detail/CVE-2020-36691){: external}, [CVE-2022-0168](https://nvd.nist.gov/vuln/detail/CVE-2022-0168){: external}, [CVE-2022-1184](https://nvd.nist.gov/vuln/detail/CVE-2022-1184){: external}, [CVE-2022-2208](https://nvd.nist.gov/vuln/detail/CVE-2022-2208){: external}, [CVE-2022-2210](https://nvd.nist.gov/vuln/detail/CVE-2022-2210){: external}, [CVE-2022-2257](https://nvd.nist.gov/vuln/detail/CVE-2022-2257){: external}, [CVE-2022-2264](https://nvd.nist.gov/vuln/detail/CVE-2022-2264){: external}, [CVE-2022-2284](https://nvd.nist.gov/vuln/detail/CVE-2022-2284){: external}, [CVE-2022-2285](https://nvd.nist.gov/vuln/detail/CVE-2022-2285){: external}, [CVE-2022-2286](https://nvd.nist.gov/vuln/detail/CVE-2022-2286){: external}, [CVE-2022-2287](https://nvd.nist.gov/vuln/detail/CVE-2022-2287){: external}, [CVE-2022-2289](https://nvd.nist.gov/vuln/detail/CVE-2022-2289){: external}, [CVE-2022-27672](https://nvd.nist.gov/vuln/detail/CVE-2022-27672){: external}, [CVE-2022-4269](https://nvd.nist.gov/vuln/detail/CVE-2022-4269){: external}, [CVE-2023-1611](https://nvd.nist.gov/vuln/detail/CVE-2023-1611){: external}, [CVE-2023-2124](https://nvd.nist.gov/vuln/detail/CVE-2023-2124){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-3111](https://nvd.nist.gov/vuln/detail/CVE-2023-3111){: external}, [CVE-2023-3141](https://nvd.nist.gov/vuln/detail/CVE-2023-3141){: external}, [CVE-2023-32629](https://nvd.nist.gov/vuln/detail/CVE-2023-32629){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}. |
| Kubernetes | N/A | N/A | N/A |
| Containerd | N/A | N/A | N/A |
{: caption="Changes since version 1.25.12_1554" caption-side="bottom"}


### Change log for worker node fix pack 1.25.12_1554, released 1 August 2023
{: #12512_1554_W}

The following table shows the changes that are in the worker node fix pack 1.25.12_1554. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-212-generic | 4.15.0-214-generic | Worker node kernel & package updates for [CVE-2020-13987](https://nvd.nist.gov/vuln/detail/CVE-2020-13987){: external}, [CVE-2020-13988](https://nvd.nist.gov/vuln/detail/CVE-2020-13988){: external}, [CVE-2020-17437](https://nvd.nist.gov/vuln/detail/CVE-2020-17437){: external}, [CVE-2022-1184](https://nvd.nist.gov/vuln/detail/CVE-2022-1184){: external}, [CVE-2022-3303](https://nvd.nist.gov/vuln/detail/CVE-2022-3303){: external}, [CVE-2023-1611](https://nvd.nist.gov/vuln/detail/CVE-2023-1611){: external}, [CVE-2023-1670](https://nvd.nist.gov/vuln/detail/CVE-2023-1670){: external}, [CVE-2023-1859](https://nvd.nist.gov/vuln/detail/CVE-2023-1859){: external}, [CVE-2023-1990](https://nvd.nist.gov/vuln/detail/CVE-2023-1990){: external}, [CVE-2023-20867](https://nvd.nist.gov/vuln/detail/CVE-2023-20867){: external}, [CVE-2023-2124](https://nvd.nist.gov/vuln/detail/CVE-2023-2124){: external}, [CVE-2023-2828](https://nvd.nist.gov/vuln/detail/CVE-2023-2828){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-3111](https://nvd.nist.gov/vuln/detail/CVE-2023-3111){: external}, [CVE-2023-3141](https://nvd.nist.gov/vuln/detail/CVE-2023-3141){: external}, [CVE-2023-3268](https://nvd.nist.gov/vuln/detail/CVE-2023-3268){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}. |
| Ubuntu 20.04 packages | 5.4.0-153-generic | 5.4.0-155-generic | Worker node kernel & package updates for [CVE-2020-13987](https://nvd.nist.gov/vuln/detail/CVE-2020-13987){: external}, [CVE-2020-13988](https://nvd.nist.gov/vuln/detail/CVE-2020-13988){: external}, [CVE-2020-17437](https://nvd.nist.gov/vuln/detail/CVE-2020-17437){: external}, [CVE-2023-20867](https://nvd.nist.gov/vuln/detail/CVE-2023-20867){: external}, [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}, [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-32629](https://nvd.nist.gov/vuln/detail/CVE-2023-32629){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}, [CVE-2023-38408](https://nvd.nist.gov/vuln/detail/CVE-2023-38408){: external}. |
| Kubernetes | 1.25.11 | 1.25.12 | see [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.12){: external}. |
| Containerd | 1.6.21 | 1.6.22 | see [change logs](https://github.com/containerd/containerd/releases/tag/v1.6.22){: external}. |
{: caption="Changes since version 1.25.11_1552" caption-side="bottom"}


### Change log for master fix pack 1.25.12_1553, released 27 July 2023
{: #12512_1553_M}

The following table shows the changes that are in the master fix pack 1.25.12_1553. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.21 | v1.3.23 | Updated `Go` to version `1.19.11` and updated `Go` dependencies. Updated UBI base image. |
| GPU device plug-in and installer | 202b284 | 495931a | Updated `Go` to version `1.20.6`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.11-1 | v1.25.12-1 | Updated to support the Kubernetes `1.25.12` release. Updated `Go` dependencies and to `Go` version `1.20.6`. |
| Key Management Service provider | v2.6.7 | v2.7.2 | Updated `Go` to version `1.19.11` and updated `Go` dependencies. Updated UBI base image. |
| Konnectivity agent and server | v0.1.2_591_iks | v0.1.3_5_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.3){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.21 | 1.22.23 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.23){: external}. |
| Kubernetes | v1.25.11 | v1.25.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.12){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2584 | 2631 | Updated `Go` to version `1.19.10` and updated `Go` dependencies. Updated Alpine base image. |
{: caption="Changes since version 1.25.11_1549" caption-side="bottom"}


### Change log for worker node fix pack 1.25.11_1552, released 17 July 2023
{: #12511_1552_W}

The following table shows the changes that are in the worker node fix pack 1.25.11_1552. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Kubernetes | N/A | N/A | N/A |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2023-24626](https://nvd.nist.gov/vuln/detail/CVE-2023-24626){: external}, [CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external}. |
| Ubuntu 20.04 packages | N/A | N/A | N/A |
{: caption="Changes since version 1.25.11_1550" caption-side="bottom"}


### Change log for worker node fix pack 1.25.11_1550, released 03 July 2023
{: #12511_1550_W}

The following table shows the changes that are in the worker node fix pack 1.25.11_1550. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2023-2603](https://nvd.nist.gov/vuln/detail/CVE-2023-2603){: external},[CVE-2023-3138](https://nvd.nist.gov/vuln/detail/CVE-2023-3138){: external}
| Ubuntu 20.04 packages | 5.4.0-150-generic | 5.4.0-153-generic | Worker node kernel & package updates for [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external},[CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external},[CVE-2023-1670](https://nvd.nist.gov/vuln/detail/CVE-2023-1670){: external},[CVE-2023-1859](https://nvd.nist.gov/vuln/detail/CVE-2023-1859){: external},[CVE-2023-2612](https://nvd.nist.gov/vuln/detail/CVE-2023-2612){: external},[CVE-2023-2828](https://nvd.nist.gov/vuln/detail/CVE-2023-2828){: external},[CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external},[CVE-2023-3138](https://nvd.nist.gov/vuln/detail/CVE-2023-3138){: external},[CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external},[CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external},[CVE-2023-3297](https://nvd.nist.gov/vuln/detail/CVE-2023-3297){: external}. |
| Kubernetes | 1.25.10 | 1.25.11 |See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md){: external}.|
{: caption="Changes since version 1.25.10_1548" caption-side="bottom"}


### Change log for master fix pack 1.25.11_1549, released 27 June 2023
{: #12511_1549_M}

The following table shows the changes that are in the master fix pack 1.25.11_1549. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.24.5 | v3.25.1 | See the [Calico release notes](https://docs.tigera.io/calico/3.25/release-notes/#v3.25.1){: external}. |
| Cluster health image | v1.3.20 | v1.3.21 | Updated `Go` dependencies and to `Go` version `1.19.10`. |
| etcd | v3.5.8 | v3.5.9 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.9){: external}. |
| Gateway-enabled cluster controller | 2106 | 2322 | Updated image to resolve [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}. |
| GPU device plug-in and installer | 28d80a0 | 202b284 | Updated to `Go` version `1.19.9` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.9-7 | v1.25.11-1 | Updated to support the `Kubernetes 1.25.11` release. Updated `Go` dependencies and to `Go` version `1.19.10`. Updated `calicoctl` and `vpcctl`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 431 | 433 | Updated `Go` to version `1.20.4`. Updated UBI base image. |
| Key Management Service provider | v2.6.6 | v2.6.7 | Updated `Go` dependencies and to `Go` version `1.19.10`. |
| Kubernetes | v1.25.10 | v1.25.11 | [CVE-2023-2728](https://nvd.nist.gov/vuln/detail/CVE-2023-2728){: external}. For more information, see [{{site.data.keyword.containerlong_notm}} is affected by a Kubernetes API server security vulnerability (CVE-2023-2728)](https://www.ibm.com/support/pages/node/7011039){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.11){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2486 | 2584 | Updated `Go` dependencies and to `Go` version `1.19.9`. Updated base image. |
{: caption="Changes since version 1.25.10_1545" caption-side="bottom"}


### Change log for worker node fix pack 1.25.10_1548, released 19 June 2023
{: #12510_1548_W}

The following table shows the changes that are in the worker node fix pack 1.25.10_1548. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2020-11080](https://nvd.nist.gov/vuln/detail/CVE-2020-11080){: external},[CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external},[CVE-2023-2603](https://nvd.nist.gov/vuln/detail/CVE-2023-2603){: external},[CVE-2023-2609](https://nvd.nist.gov/vuln/detail/CVE-2023-2609){: external},[CVE-2023-2610](https://nvd.nist.gov/vuln/detail/CVE-2023-2610){: external},[CVE-2023-32681](https://nvd.nist.gov/vuln/detail/CVE-2023-32681){: external}
| Ubuntu 20.04 packages | 5.4.0-149-generic | 5.4.0-150-generic | Worker node kernel & package updates for [CVE-2020-11080](https://nvd.nist.gov/vuln/detail/CVE-2020-11080){: external},[CVE-2021-45078](https://nvd.nist.gov/vuln/detail/CVE-2021-45078){: external},[CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external},[CVE-2023-1667](https://nvd.nist.gov/vuln/detail/CVE-2023-1667){: external},[CVE-2023-1670](https://nvd.nist.gov/vuln/detail/CVE-2023-1670){: external},[CVE-2023-1859](https://nvd.nist.gov/vuln/detail/CVE-2023-1859){: external},[CVE-2023-2283](https://nvd.nist.gov/vuln/detail/CVE-2023-2283){: external},[CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external},[CVE-2023-24593](https://nvd.nist.gov/vuln/detail/CVE-2023-24593){: external},[CVE-2023-2602](https://nvd.nist.gov/vuln/detail/CVE-2023-2602){: external},[CVE-2023-2603](https://nvd.nist.gov/vuln/detail/CVE-2023-2603){: external},[CVE-2023-2609](https://nvd.nist.gov/vuln/detail/CVE-2023-2609){: external},[CVE-2023-2610](https://nvd.nist.gov/vuln/detail/CVE-2023-2610){: external},[CVE-2023-2612](https://nvd.nist.gov/vuln/detail/CVE-2023-2612){: external},[CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external},[CVE-2023-3138](https://nvd.nist.gov/vuln/detail/CVE-2023-3138){: external},[CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external},[CVE-2023-31484](https://nvd.nist.gov/vuln/detail/CVE-2023-31484){: external},[CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external},[CVE-2023-32643](https://nvd.nist.gov/vuln/detail/CVE-2023-32643){: external},[CVE-2023-32681](https://nvd.nist.gov/vuln/detail/CVE-2023-32681){: external}. |
| Kubernetes | N/A |N/A|N/A|
{: caption="Changes since version 1.25.10_1547" caption-side="bottom"}


### Change log for worker node fix pack 1.25.10_1547, released 5 June 2023
{: #12510_1547_W}

The following table shows the changes that are in the worker node fix pack 1.25.10_1547. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-211-generic | 4.15.0-212-generic | Worker node kernel & package updates for [CVE-2019-17595](https://nvd.nist.gov/vuln/detail/CVE-2019-17595){: external}, [CVE-2021-39537](https://nvd.nist.gov/vuln/detail/CVE-2021-39537){: external}, [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external}, [CVE-2023-25584](https://nvd.nist.gov/vuln/detail/CVE-2023-25584){: external}, [CVE-2023-25585](https://nvd.nist.gov/vuln/detail/CVE-2023-25585){: external}, [CVE-2023-25588](https://nvd.nist.gov/vuln/detail/CVE-2023-25588){: external}, [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}, [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}, [CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external}, [CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external}, [CVE-2023-31484](https://nvd.nist.gov/vuln/detail/CVE-2023-31484){: external}, [CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external}. |
| Ubuntu 20.04 packages | 5.4.0-148-generic | 5.4.0-149-generic | Worker node kernel & package updates for [CVE-2021-39537](https://nvd.nist.gov/vuln/detail/CVE-2021-39537){: external}, [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}, [CVE-2023-1075](https://nvd.nist.gov/vuln/detail/CVE-2023-1075){: external}, [CVE-2023-1118](https://nvd.nist.gov/vuln/detail/CVE-2023-1118){: external}, [CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external}, [CVE-2023-25584](https://nvd.nist.gov/vuln/detail/CVE-2023-25584){: external}, [CVE-2023-25585](https://nvd.nist.gov/vuln/detail/CVE-2023-25585){: external}, [CVE-2023-25588](https://nvd.nist.gov/vuln/detail/CVE-2023-25588){: external}, [CVE-2023-2612](https://nvd.nist.gov/vuln/detail/CVE-2023-2612){: external}, [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}, [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}, [CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external}, [CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external}, [CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external}. |
| Kubernetes | N/A |N/A|N/A|
{: caption="Changes since version 1.25.10_1546" caption-side="bottom"}


### Change log for master fix pack 1.25.10_1545, released 23 May 2023
{: #12510_1545_M}

The following table shows the changes that are in the master fix pack 1.25.10_1545. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.19 | v1.3.20 | Updated `Go` to version `1.19.9` and updated dependencies. Updated the base image. Resolved add-on health bugs. |
| etcd | v3.5.7 | v3.5.8 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.8){: external}. |
| GPU device plug-in | fc4cf22 | 28d80a0 | Updated `Go` to version `1.19.8` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.9-1 | v1.25.9-7 | Updated support of the Kubernetes 1.25.9 release. Updated Go dependencies. Key rotation. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 778ef2b | 4e2f346 | Make armada-rbac-sync FIPS compliant |
| Key Management Service provider | v2.6.5 | v2.6.6 | Updated `Go` to version `1.19.9` and updated dependencies. |
| Kubernetes | v1.25.9 | v1.25.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.10){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.18 | 1.22.21 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.21){: external}. |
| Portieris admission controller | v0.13.4 | v0.13.5 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.5){: external}. |
{: caption="Changes since version 1.25.9_1543" caption-side="bottom"}


### Change log for worker node fix pack 1.25.10_1546, released 23 May 2023
{: #12510_1546_W}

The following table shows the changes that are in the worker node fix pack 1.25.10_1546. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-210-generic | 4.15.0-211-generic | Worker node kernel & package updates for [CVE-2021-3979](https://nvd.nist.gov/vuln/detail/CVE-2021-3979){: external}, [CVE-2023-1118](https://nvd.nist.gov/vuln/detail/CVE-2023-1118){: external}. |
| Ubuntu 20.04 packages | 5.4.0-139-generic | 5.4.0-148-generic | Worker node kernel & package updates for [CVE-2023-2004](https://nvd.nist.gov/vuln/detail/CVE-2023-2004){: external}. |
| Kubernetes | 1.25.9 | 1.25.10 | [CVE-2023-2431](https://nvd.nist.gov/vuln/detail/CVE-2023-2431){: external}. For more information, see [{{site.data.keyword.containerlong_notm}} is affected by a kubelet security vulnerability (CVE-2023-2431)](https://www.ibm.com/support/pages/node/7009655){: external}. See [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.10){: external}. |
| Haproxy | N\A | N\A | N\A|
{: caption="Changes since version 1.25.9_1544" caption-side="bottom"}


### Change log for worker node fix pack 1.25.9_1544, released 9 May 2023
{: #1259_1544_W}

The following table shows the changes that are in the worker node fix pack 1.25.9_1544. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-209-generic | 4.15.0-210-generic | Worker node kernel & package updates for [CVE-2023-1786](https://nvd.nist.gov/vuln/detail/CVE-2023-1786){: external}, [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}, [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}, [CVE-2023-1829](https://nvd.nist.gov/vuln/detail/CVE-2023-1829){: external}, [CVE-2023-25652](https://nvd.nist.gov/vuln/detail/CVE-2023-25652){: external}, [CVE-2023-25815](https://nvd.nist.gov/vuln/detail/CVE-2023-25815){: external}, [CVE-2023-29007](https://nvd.nist.gov/vuln/detail/CVE-2023-29007){: external}. |
| Ubuntu 20.04 packages | n/a | n/a | Worker node kernel & package updates for [CVE-2023-1786](https://nvd.nist.gov/vuln/detail/CVE-2023-1786){: external}, [CVE-2023-0464](https://nvd.nist.gov/vuln/detail/CVE-2023-0464){: external}, [CVE-2023-0466](https://nvd.nist.gov/vuln/detail/CVE-2023-0466){: external}, [CVE-2023-25652](https://nvd.nist.gov/vuln/detail/CVE-2023-25652){: external}, [CVE-2023-25815](https://nvd.nist.gov/vuln/detail/CVE-2023-25815){: external}, [CVE-2023-29007](https://nvd.nist.gov/vuln/detail/CVE-2023-29007){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.25.9_1543" caption-side="bottom"}


### Change log for master fix pack 1.25.9_1543, released 27 April 2023
{: #1259_1543M}

The following table shows the changes that are in the master fix pack 1.25.9_1543. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.17 | v1.3.19 | Updated `Go` to version `1.19.8` and updated dependencies. |
| Gateway-enabled cluster controller | 2024 | 2106 | Support Ubuntu 20 and update image to resolve CVEs. |
| GPU device plug-in | a873e90 | fc4cf22 | Updated `Go` to version `1.19.7`. |
| GPU installer | a873e90 | 28d80a0 | Updated `Go` to version `1.19.8`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1366-amd64 | 1390-amd64 | Eliminate IP syscall. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.0 | v2.4.5 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.19.8` and updated dependencies. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.8-1 | v1.25.9-1 | Updated to support the Kubernetes `1.25.9` release. Updated `Go` dependencies and to `Go` version `1.19.8`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 429 | 431 | Updated `Go` to version `1.19.8` and updated dependencies. Update UBI base image. |
| Key Management Service provider | v2.6.4 | v2.6.5 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Konnectivity agent and server | v0.1.1_569_iks-amd64 | v0.1.2_591_iks-amd64 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.2){: external}. Updated configuration to set `keepalive-time` to `40s`. |
| Kubernetes | v1.25.8 | v1.25.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.9){: external}. |
| Kubernetes Metrics Server configuration | N/A | N/A | Updated to use TLS version 1.3 ciphers. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2420 | 2486 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Portieris admission controller | v0.13.3 | v0.13.4 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.4){: external}. |
{: caption="Changes since version 1.25.8_1536" caption-side="bottom"}


### Change log for worker node fix pack 1.25.9_1543, released 24 April 2023
{: #1259_1543}

The following table shows the changes that are in the worker node fix pack 1.25.9_1543. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-208-generic | 4.15.0-209-generic | Worker node package updates for  [CVE-2021-4192](https://nvd.nist.gov/vuln/detail/CVE-2021-4192){: external}, [CVE-2021-4193](https://nvd.nist.gov/vuln/detail/CVE-2021-4193){: external}, [CVE-2022-0213](https://nvd.nist.gov/vuln/detail/CVE-2022-0213){: external}, [CVE-2022-0261](https://nvd.nist.gov/vuln/detail/CVE-2022-0261){: external}, [CVE-2022-0318](https://nvd.nist.gov/vuln/detail/CVE-2022-0318){: external}, [CVE-2022-0319](https://nvd.nist.gov/vuln/detail/CVE-2022-0319){: external}, [CVE-2022-0351](https://nvd.nist.gov/vuln/detail/CVE-2022-0351){: external}, [CVE-2022-0359](https://nvd.nist.gov/vuln/detail/CVE-2022-0359){: external}, [CVE-2022-0361](https://nvd.nist.gov/vuln/detail/CVE-2022-0361){: external}, [CVE-2022-0368](https://nvd.nist.gov/vuln/detail/CVE-2022-0368){: external}, [CVE-2022-0408](https://nvd.nist.gov/vuln/detail/CVE-2022-0408){: external}, [CVE-2022-0443](https://nvd.nist.gov/vuln/detail/CVE-2022-0443){: external}, [CVE-2022-0554](https://nvd.nist.gov/vuln/detail/CVE-2022-0554){: external}, [CVE-2022-0572](https://nvd.nist.gov/vuln/detail/CVE-2022-0572){: external}, [CVE-2022-0685](https://nvd.nist.gov/vuln/detail/CVE-2022-0685){: external}, [CVE-2022-0714](https://nvd.nist.gov/vuln/detail/CVE-2022-0714){: external}, [CVE-2022-0729](https://nvd.nist.gov/vuln/detail/CVE-2022-0729){: external}, [CVE-2022-2207](https://nvd.nist.gov/vuln/detail/CVE-2022-2207){: external}, [CVE-2022-3903](https://nvd.nist.gov/vuln/detail/CVE-2022-3903){: external}, [CVE-2023-1281](https://nvd.nist.gov/vuln/detail/CVE-2023-1281){: external}, [CVE-2023-1326](https://nvd.nist.gov/vuln/detail/CVE-2023-1326){: external}, [CVE-2023-26545](https://nvd.nist.gov/vuln/detail/CVE-2023-26545){: external}, [CVE-2023-28450](https://nvd.nist.gov/vuln/detail/CVE-2023-28450){: external}, [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}, [CVE-2023-28486](https://nvd.nist.gov/vuln/detail/CVE-2023-28486){: external}, [CVE-2023-28487](https://nvd.nist.gov/vuln/detail/CVE-2023-28487){: external}, [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-4166](https://nvd.nist.gov/vuln/detail/CVE-2021-4166){: external}, [CVE-2021-4192](https://nvd.nist.gov/vuln/detail/CVE-2021-4192){: external}, [CVE-2021-4193](https://nvd.nist.gov/vuln/detail/CVE-2021-4193){: external}, [CVE-2022-0213](https://nvd.nist.gov/vuln/detail/CVE-2022-0213){: external}, [CVE-2022-0261](https://nvd.nist.gov/vuln/detail/CVE-2022-0261){: external}, [CVE-2022-0318](https://nvd.nist.gov/vuln/detail/CVE-2022-0318){: external}, [CVE-2022-0319](https://nvd.nist.gov/vuln/detail/CVE-2022-0319){: external}, [CVE-2022-0351](https://nvd.nist.gov/vuln/detail/CVE-2022-0351){: external}, [CVE-2022-0359](https://nvd.nist.gov/vuln/detail/CVE-2022-0359){: external}, [CVE-2022-0361](https://nvd.nist.gov/vuln/detail/CVE-2022-0361){: external}, [CVE-2022-0368](https://nvd.nist.gov/vuln/detail/CVE-2022-0368){: external}, [CVE-2022-0408](https://nvd.nist.gov/vuln/detail/CVE-2022-0408){: external}, [CVE-2022-0443](https://nvd.nist.gov/vuln/detail/CVE-2022-0443){: external}, [CVE-2022-0554](https://nvd.nist.gov/vuln/detail/CVE-2022-0554){: external}, [CVE-2022-0572](https://nvd.nist.gov/vuln/detail/CVE-2022-0572){: external}, [CVE-2022-0629](https://nvd.nist.gov/vuln/detail/CVE-2022-0629){: external}, [CVE-2022-0685](https://nvd.nist.gov/vuln/detail/CVE-2022-0685){: external}, [CVE-2022-0714](https://nvd.nist.gov/vuln/detail/CVE-2022-0714){: external}, [CVE-2022-0729](https://nvd.nist.gov/vuln/detail/CVE-2022-0729){: external}, [CVE-2022-2207](https://nvd.nist.gov/vuln/detail/CVE-2022-2207){: external}, [CVE-2022-3108](https://nvd.nist.gov/vuln/detail/CVE-2022-3108){: external}, [CVE-2022-3903](https://nvd.nist.gov/vuln/detail/CVE-2022-3903){: external}, [CVE-2023-1281](https://nvd.nist.gov/vuln/detail/CVE-2023-1281){: external}, [CVE-2023-1326](https://nvd.nist.gov/vuln/detail/CVE-2023-1326){: external}, [CVE-2023-26545](https://nvd.nist.gov/vuln/detail/CVE-2023-26545){: external}, [CVE-2023-28484](https://nvd.nist.gov/vuln/detail/CVE-2023-28484){: external}, [CVE-2023-28486](https://nvd.nist.gov/vuln/detail/CVE-2023-28486){: external}, [CVE-2023-28487](https://nvd.nist.gov/vuln/detail/CVE-2023-28487){: external}, [CVE-2023-29469](https://nvd.nist.gov/vuln/detail/CVE-2023-29469){: external}. |
| Kubernetes | 1.25.8 | 1.25.9 | See [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.9){: external}. |
| Containerd |N/A|N/A|N/A|
| Haproxy |N/A|N/A|N/A|
{: caption="Changes since version 1.25.8_1541" caption-side="bottom"}


### Change log for worker node fix pack 1.25.8_1541, released 11 April 2023
{: #1258_1541}

The following table shows the changes that are in the worker node fix pack 1.25.8_1541. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-206 | 4.15.0-208 | Worker node kernel & package updates for [CVE-2021-3669](https://nvd.nist.gov/vuln/detail/CVE-2021-3669){: external}, [CVE-2022-0413](https://nvd.nist.gov/vuln/detail/CVE-2022-0413){: external}, [CVE-2022-1629](https://nvd.nist.gov/vuln/detail/CVE-2022-1629){: external}, [CVE-2022-1674](https://nvd.nist.gov/vuln/detail/CVE-2022-1674){: external}, [CVE-2022-1720](https://nvd.nist.gov/vuln/detail/CVE-2022-1720){: external}, [CVE-2022-1733](https://nvd.nist.gov/vuln/detail/CVE-2022-1733){: external}, [CVE-2022-1735](https://nvd.nist.gov/vuln/detail/CVE-2022-1735){: external}, [CVE-2022-1785](https://nvd.nist.gov/vuln/detail/CVE-2022-1785){: external}, [CVE-2022-1796](https://nvd.nist.gov/vuln/detail/CVE-2022-1796){: external}, [CVE-2022-1851](https://nvd.nist.gov/vuln/detail/CVE-2022-1851){: external}, [CVE-2022-1898](https://nvd.nist.gov/vuln/detail/CVE-2022-1898){: external}, [CVE-2022-1942](https://nvd.nist.gov/vuln/detail/CVE-2022-1942){: external}, [CVE-2022-1968](https://nvd.nist.gov/vuln/detail/CVE-2022-1968){: external}, [CVE-2022-2124](https://nvd.nist.gov/vuln/detail/CVE-2022-2124){: external}, [CVE-2022-2125](https://nvd.nist.gov/vuln/detail/CVE-2022-2125){: external}, [CVE-2022-2126](https://nvd.nist.gov/vuln/detail/CVE-2022-2126){: external}, [CVE-2022-2129](https://nvd.nist.gov/vuln/detail/CVE-2022-2129){: external}, [CVE-2022-2175](https://nvd.nist.gov/vuln/detail/CVE-2022-2175){: external}, [CVE-2022-2183](https://nvd.nist.gov/vuln/detail/CVE-2022-2183){: external}, [CVE-2022-2206](https://nvd.nist.gov/vuln/detail/CVE-2022-2206){: external}, [CVE-2022-2304](https://nvd.nist.gov/vuln/detail/CVE-2022-2304){: external}, [CVE-2022-2345](https://nvd.nist.gov/vuln/detail/CVE-2022-2345){: external}, [CVE-2022-2571](https://nvd.nist.gov/vuln/detail/CVE-2022-2571){: external}, [CVE-2022-2581](https://nvd.nist.gov/vuln/detail/CVE-2022-2581){: external}, [CVE-2022-2845](https://nvd.nist.gov/vuln/detail/CVE-2022-2845){: external}, [CVE-2022-2849](https://nvd.nist.gov/vuln/detail/CVE-2022-2849){: external}, [CVE-2022-2923](https://nvd.nist.gov/vuln/detail/CVE-2022-2923){: external}, [CVE-2022-2946](https://nvd.nist.gov/vuln/detail/CVE-2022-2946){: external}, [CVE-2022-41218](https://nvd.nist.gov/vuln/detail/CVE-2022-41218){: external}, [CVE-2023-0045](https://nvd.nist.gov/vuln/detail/CVE-2023-0045){: external}, [CVE-2023-0266](https://nvd.nist.gov/vuln/detail/CVE-2023-0266){: external}, [CVE-2023-23559](https://nvd.nist.gov/vuln/detail/CVE-2023-23559){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-0413](https://nvd.nist.gov/vuln/detail/CVE-2022-0413){: external}, [CVE-2022-1629](https://nvd.nist.gov/vuln/detail/CVE-2022-1629){: external}, [CVE-2022-1674](https://nvd.nist.gov/vuln/detail/CVE-2022-1674){: external}, [CVE-2022-1720](https://nvd.nist.gov/vuln/detail/CVE-2022-1720){: external}, [CVE-2022-1733](https://nvd.nist.gov/vuln/detail/CVE-2022-1733){: external}, [CVE-2022-1735](https://nvd.nist.gov/vuln/detail/CVE-2022-1735){: external}, [CVE-2022-1785](https://nvd.nist.gov/vuln/detail/CVE-2022-1785){: external}, [CVE-2022-1796](https://nvd.nist.gov/vuln/detail/CVE-2022-1796){: external}, [CVE-2022-1851](https://nvd.nist.gov/vuln/detail/CVE-2022-1851){: external}, [CVE-2022-1898](https://nvd.nist.gov/vuln/detail/CVE-2022-1898){: external}, [CVE-2022-1927](https://nvd.nist.gov/vuln/detail/CVE-2022-1927){: external}, [CVE-2022-1942](https://nvd.nist.gov/vuln/detail/CVE-2022-1942){: external}, [CVE-2022-1968](https://nvd.nist.gov/vuln/detail/CVE-2022-1968){: external}, [CVE-2022-2124](https://nvd.nist.gov/vuln/detail/CVE-2022-2124){: external}, [CVE-2022-2125](https://nvd.nist.gov/vuln/detail/CVE-2022-2125){: external}, [CVE-2022-2126](https://nvd.nist.gov/vuln/detail/CVE-2022-2126){: external}, [CVE-2022-2129](https://nvd.nist.gov/vuln/detail/CVE-2022-2129){: external}, [CVE-2022-2175](https://nvd.nist.gov/vuln/detail/CVE-2022-2175){: external}, [CVE-2022-2183](https://nvd.nist.gov/vuln/detail/CVE-2022-2183){: external}, [CVE-2022-2206](https://nvd.nist.gov/vuln/detail/CVE-2022-2206){: external}, [CVE-2022-2304](https://nvd.nist.gov/vuln/detail/CVE-2022-2304){: external}, [CVE-2022-2344](https://nvd.nist.gov/vuln/detail/CVE-2022-2344){: external}, [CVE-2022-2345](https://nvd.nist.gov/vuln/detail/CVE-2022-2345){: external}, [CVE-2022-2571](https://nvd.nist.gov/vuln/detail/CVE-2022-2571){: external}, [CVE-2022-2581](https://nvd.nist.gov/vuln/detail/CVE-2022-2581){: external}, [CVE-2022-2845](https://nvd.nist.gov/vuln/detail/CVE-2022-2845){: external}, [CVE-2022-2849](https://nvd.nist.gov/vuln/detail/CVE-2022-2849){: external}, [CVE-2022-2923](https://nvd.nist.gov/vuln/detail/CVE-2022-2923){: external}, [CVE-2022-2946](https://nvd.nist.gov/vuln/detail/CVE-2022-2946){: external}, [CVE-2022-2980](https://nvd.nist.gov/vuln/detail/CVE-2022-2980){: external}. Updated `sysctl` setting for `fs.inotify.max_user_instances` from default `128` to `1024`. |
| Kubernetes |N/A|N/A|N/A|
| Haproxy | 8398d1 | 8895ad | [CVE-2023-0361](https://nvd.nist.gov/vuln/detail/CVE-2023-0361){: external}. |
| Containerd | 1.6.19 | 1.6.21 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.21){: external} and [security bulletin for CVE-2023-28642 and CVE-2023-27561](https://www.ibm.com/support/pages/node/7001317){: external}. |
{: caption="Changes since version 1.25.8_1539" caption-side="bottom"}


### Change log for worker node fix pack 1.25.8_1539, released 29 March 2023
{: #1258_1539}

The following table shows the changes that are in the worker node fix pack 1.25.8_1539. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-144 | 5.4.0-139 | Downgrading kernel to address [Upstream canonical bug](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2009325){: external}. |
{: caption="Changes since version 1.25.8_1537" caption-side="bottom"}


### Change log for master fix pack 1.25.8_1536, released 28 March 2023
{: #1258_1536}

The following table shows the changes that are in the master fix pack 1.25.8_1536. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.16 | v1.3.17 | Updated `Go` to version `1.19.7` and updated dependencies. |
| GPU device plug-in and installer | 79a2232 | a873e90 | Updated `Go` to version `1.19.6`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1308-amd64 | 1366-amd64 | Updated to resolve [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.7 | v2.4.0 | Removed ExpandInUsePersistentVolumes feature gate. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.6-10 | v1.25.8-1 | Updated to support the `Kubernetes 1.25.8` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 427 | 429 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.19.6` and updated dependencies. |
| Key Management Service provider | v2.6.3 | v2.6.4 | Updated `Go` to version `1.19.7` and updated dependencies. |
| Kubernetes | v1.25.6 | v1.25.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.8){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2383 | 2420 | Updated the image to resolve CVEs. |
{: caption="Changes since version 1.25.6_1534" caption-side="bottom"}


### Change log for worker node fix pack 1.25.8_1537, released 27 March 2023
{: #1258_1537}

The following table shows the changes that are in the worker node fix pack 1.25.8_1537. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2022-47024](https://nvd.nist.gov/vuln/detail/CVE-2022-47024){: external}, [CVE-2023-0049](https://nvd.nist.gov/vuln/detail/CVE-2023-0049){: external}, [CVE-2023-0054](https://nvd.nist.gov/vuln/detail/CVE-2023-0054){: external}, [CVE-2023-0288](https://nvd.nist.gov/vuln/detail/CVE-2023-0288){: external}, [CVE-2023-0433](https://nvd.nist.gov/vuln/detail/CVE-2023-0433){: external}, [CVE-2023-1170](https://nvd.nist.gov/vuln/detail/CVE-2023-1170){: external}, [CVE-2023-1175](https://nvd.nist.gov/vuln/detail/CVE-2023-1175){: external}, [CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external}, [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}, [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}, [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}, [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}, [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2022-47024](https://nvd.nist.gov/vuln/detail/CVE-2022-47024){: external}, [CVE-2023-0049](https://nvd.nist.gov/vuln/detail/CVE-2023-0049){: external}, [CVE-2023-0054](https://nvd.nist.gov/vuln/detail/CVE-2023-0054){: external}, [CVE-2023-0288](https://nvd.nist.gov/vuln/detail/CVE-2023-0288){: external}, [CVE-2023-0433](https://nvd.nist.gov/vuln/detail/CVE-2023-0433){: external}, [CVE-2023-1170](https://nvd.nist.gov/vuln/detail/CVE-2023-1170){: external}, [CVE-2023-1175](https://nvd.nist.gov/vuln/detail/CVE-2023-1175){: external}, [CVE-2023-1264](https://nvd.nist.gov/vuln/detail/CVE-2023-1264){: external}, [CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external}, [CVE-2023-27533](https://nvd.nist.gov/vuln/detail/CVE-2023-27533){: external}, [CVE-2023-27534](https://nvd.nist.gov/vuln/detail/CVE-2023-27534){: external}, [CVE-2023-27535](https://nvd.nist.gov/vuln/detail/CVE-2023-27535){: external}, [CVE-2023-27536](https://nvd.nist.gov/vuln/detail/CVE-2023-27536){: external}, [CVE-2023-27538](https://nvd.nist.gov/vuln/detail/CVE-2023-27538){: external}. |
| Kubernetes | 1.25.6 | 1.25.8 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.8){: external}. |
| Containerd |N/A|N/A|N/A|
| Haproxy | af5031 | 8398d1 | [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
{: caption="Changes since version 1.25.6_1535" caption-side="bottom"}


### Change log for worker node fix pack 1.25.6_1535, released 13 March 2023
{: #1256_1535}

The following table shows the changes that are in the worker node fix pack 1.25.6_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-139 | 5.4.0-144 | Worker node kernel & package updates for [CVE-2022-29154](https://nvd.nist.gov/vuln/detail/CVE-2022-29154){: external}, [CVE-2022-3545](https://nvd.nist.gov/vuln/detail/CVE-2022-3545){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-41218](https://nvd.nist.gov/vuln/detail/CVE-2022-41218){: external}, [CVE-2022-4139](https://nvd.nist.gov/vuln/detail/CVE-2022-4139){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2022-47520](https://nvd.nist.gov/vuln/detail/CVE-2022-47520){: external}, [CVE-2022-48303](https://nvd.nist.gov/vuln/detail/CVE-2022-48303){: external}, [CVE-2023-0266](https://nvd.nist.gov/vuln/detail/CVE-2023-0266){: external}, [CVE-2023-0361](https://nvd.nist.gov/vuln/detail/CVE-2023-0361){: external}, [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external}, [CVE-2023-0767](https://nvd.nist.gov/vuln/detail/CVE-2023-0767){: external}, [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| Ubuntu 18.04 packages | 4.15.0-204 | 4.15.0-206 | Worker node kernel & package updates for [CVE-2022-29154](https://nvd.nist.gov/vuln/detail/CVE-2022-29154){: external}, [CVE-2022-3545](https://nvd.nist.gov/vuln/detail/CVE-2022-3545){: external}, [CVE-2022-3628](https://nvd.nist.gov/vuln/detail/CVE-2022-3628){: external}, [CVE-2022-37454](https://nvd.nist.gov/vuln/detail/CVE-2022-37454){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-48303](https://nvd.nist.gov/vuln/detail/CVE-2022-48303){: external}, [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external}, [CVE-2023-0767](https://nvd.nist.gov/vuln/detail/CVE-2023-0767){: external}, [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23916](https://nvd.nist.gov/vuln/detail/CVE-2023-23916){: external}. |
| Kubernetes |N/A|N/A|N/A|
| Containerd | 1.6.18 | 1.6.19 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.19){: external}. |
{: caption="Changes since version 1.25.6_1532" caption-side="bottom"}


### Change log for master fix pack 1.25.6_1534, released 2 March 2023
{: #1256_1534}

The following table shows the changes that are in the master fix pack 1.25.6_1534. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Calico configuration now sets container network `sysctl` tuning for `net.ipv4.tcp_keepalive_intvl` to `15`, `net.ipv4.tcp_keepalive_probes` to `6` and `net.ipv4.tcp_keepalive_time` to `40`.  |
| Cluster health image | v1.3.15 | v1.3.16 | Updated `Go` dependencies and to `Go` version `1.19.6`. Updated universal base image (UBI) to resolve CVEs. |
| etcd | v3.5.6 | v3.5.7 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.7){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1305-amd64 | 1308-amd64 | Updated universal base image (UBI) to resolve [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.6 | v2.3.7 | Updated universal base image (UBI) to resolve CVEs. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 425 | 427 | Updated universal base image (UBI) to resolve CVEs. |
| Gateway-enabled cluster controller | 1902 | 1987 | Updated `armada-utils` to version `v1.9.35` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.6-2 | v1.25.6-10 | Updated `Go` dependencies. Updated `k8s.io/utils` digest to `a5ecb01`. |
| Key Management Service provider | v2.5.13 | v2.6.3 | Updated `Go` dependencies and to `Go` version `1.19.6`. |
| Konnectivity agent and server | v0.0.34_491_iks | v0.1.1_569_iks-amd64 | Updated to Konnectivity version v0.1.0. |
| Kubernetes NodeLocal DNS cache | 1.22.13 | 1.22.18-amd64 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.18){: external}. |
| Load balancer and Load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2325 | 2383 | Updated to `armada-utils` version `1.9.35`. |
| Portieris admission controller | v0.12.6 | v0.13.3 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.3){: external}. |
{: caption="Changes since version 1.25.6_1529" caption-side="bottom"}


### Change log for worker node fix pack 1.25.6_1532, released 27 February 2023
{: #1256_1532}

The following table shows the changes that are in the worker node fix pack 1.25.6_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|containerd| v1.6.17| v1.6.18| See the [1.6.18 change log](https://github.com/containerd/containerd/releases/tag/v1.6.18){: external} and the [security bulletin for CVE-2023-25153 and CVE-2023-25173](https://www.ibm.com/support/pages/node/6960181){: external}. |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23946](https://nvd.nist.gov/vuln/detail/CVE-2023-23946){: external}, [CVE-2023-25725](https://nvd.nist.gov/vuln/detail/CVE-2023-25725){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node package updates for [CVE-2023-22490](https://nvd.nist.gov/vuln/detail/CVE-2023-22490){: external}, [CVE-2023-23946](https://nvd.nist.gov/vuln/detail/CVE-2023-23946){: external}, [CVE-2023-25725](https://nvd.nist.gov/vuln/detail/CVE-2023-25725){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | d38f89 | af5031 | [CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external}, [CVE-2022-4415](https://nvd.nist.gov/vuln/detail/CVE-2022-4415){: external}, [CVE-2020-10735](https://nvd.nist.gov/vuln/detail/CVE-2020-10735){: external}, [CVE-2021-28861](https://nvd.nist.gov/vuln/detail/CVE-2021-28861){: external}, [CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}. |
| Default Worker Pool | Ubuntu 18 | Ubuntu 20| For {{site.data.keyword.containerlong_notm}}, default `worker-pool` is created with Ubuntu 20 Operating system |
{: caption="Changes since version 1.25.6_1531" caption-side="bottom"}


### Change log for worker node fix pack 1.25.6_1531, released 13 February 2023
{: #1256_1531}

The following table shows the changes that are in the worker node fix pack 1.25.6_1531. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-202 | 4.15.0-204 | Worker node kernel & package updates for [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}, [CVE-2022-45142](https://nvd.nist.gov/vuln/detail/CVE-2022-45142){: external}, [CVE-2022-47016](https://nvd.nist.gov/vuln/detail/CVE-2022-47016){: external}, [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}, [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}. |
| Ubuntu 20.04 packages | 5.4.0-137 | 5.4.0-139 | Worker node kernel & package updates for [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2022-4450](https://nvd.nist.gov/vuln/detail/CVE-2022-4450){: external}, [CVE-2022-45142](https://nvd.nist.gov/vuln/detail/CVE-2022-45142){: external}, [CVE-2022-47016](https://nvd.nist.gov/vuln/detail/CVE-2022-47016){: external}, [CVE-2023-0215](https://nvd.nist.gov/vuln/detail/CVE-2023-0215){: external}, [CVE-2023-0286](https://nvd.nist.gov/vuln/detail/CVE-2023-0286){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | 8d6ea6 | 08c969 | [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. | 
{: caption="Changes since version 1.25.6_1530" caption-side="bottom"}


### Change log for master fix pack 1.25.6_1529, released 30 January 2023
{: #1256_1529}

The following table shows the changes that are in the master fix pack 1.25.6_1529. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.14 | v1.3.15 | Updated `Go` dependencies and to `Go` version `1.19.4`. |
| GPU device plug-in and installer | 03fd318 | 79a2232 | Updated `Go` to version `1.19.4`. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.4 | v2.3.6 | Updated `UBI images` to `8.7-1031` |
| {{site.data.keyword.IBM_notm}} Calico extension | 1257 | 1280 | Publish s390x image. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.4-2 | v1.25.6-2 | Updated to support the `Kubernetes 1.25.6` release. Updated `Go` dependencies and to `Go` version `1.19.5`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 421 | 425 | Fixes for [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external} and [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external}. |
| Key Management Service provider | v2.5.12 | v2.5.13 | Updated `Go` dependencies and to `Go` version `1.19.4`. Changed to focal distribution. |
| Konnectivity agent and server | v0.0.33_418_iks | v0.0.34_491_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.34){: external}. |
| Kubernetes | v1.25.5 | v1.25.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.6){: external}. |
{: caption="Changes since version 1.25.5_1525" caption-side="bottom"}


### Change log for worker node fix pack 1.25.6_1530, released 30 January 2023
{: #1256_1530}

The following table shows the changes that are in the worker node fix pack 1.25.6_1530. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2018-20217](https://nvd.nist.gov/vuln/detail/CVE-2018-20217){: external}, [CVE-2022-23521](https://nvd.nist.gov/vuln/detail/CVE-2022-23521){: external}, [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-41903](https://nvd.nist.gov/vuln/detail/CVE-2022-41903){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2023-22809](https://nvd.nist.gov/vuln/detail/CVE-2023-22809){: external}. |
| Ubuntu 20.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2021-33503](https://nvd.nist.gov/vuln/detail/CVE-2021-33503){: external}, [CVE-2022-23521](https://nvd.nist.gov/vuln/detail/CVE-2022-23521){: external}, [CVE-2022-28321](https://nvd.nist.gov/vuln/detail/CVE-2022-28321){: external}, [CVE-2022-3094](https://nvd.nist.gov/vuln/detail/CVE-2022-3094){: external}, [CVE-2022-40897](https://nvd.nist.gov/vuln/detail/CVE-2022-40897){: external}, [CVE-2022-40898](https://nvd.nist.gov/vuln/detail/CVE-2022-40898){: external}, [CVE-2022-41903](https://nvd.nist.gov/vuln/detail/CVE-2022-41903){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2023-0056](https://nvd.nist.gov/vuln/detail/CVE-2023-0056){: external}, [CVE-2023-22809](https://nvd.nist.gov/vuln/detail/CVE-2023-22809){: external}. |
| Kubernetes | 1.25.5 | 1.25.6 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.6){: external}. |
| HAProxy | 508bf6 | 8d6ea6 | [CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external}, [CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external}, [CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}, [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external}, [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external}, [CVE-2022-3821](https://nvd.nist.gov/vuln/detail/CVE-2022-3821){: external}, [CVE-2022-35737](https://nvd.nist.gov/vuln/detail/CVE-2022-35737){: external}, [CVE-2022-43680](https://nvd.nist.gov/vuln/detail/CVE-2022-43680){: external}, [CVE-2021-46848](https://nvd.nist.gov/vuln/detail/CVE-2021-46848){: external}. |
{: caption="Changes since version 1.25.5_1528" caption-side="bottom"}


### Change log for worker node fix pack 1.25.5_1528, released 16 January 2023
{: #1255_1528}

The following table shows the changes that are in the worker node fix pack 1.25.5_1528. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-200 | 4.15.0-202 | Worker node kernel & package updates for [CVE-2021-44758](https://nvd.nist.gov/vuln/detail/CVE-2021-44758){: external}, [CVE-2022-0392](https://nvd.nist.gov/vuln/detail/CVE-2022-0392){: external}, [CVE-2022-2663](https://nvd.nist.gov/vuln/detail/CVE-2022-2663){: external}, [CVE-2022-3061](https://nvd.nist.gov/vuln/detail/CVE-2022-3061){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-3643](https://nvd.nist.gov/vuln/detail/CVE-2022-3643){: external}, [CVE-2022-42896](https://nvd.nist.gov/vuln/detail/CVE-2022-42896){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external}, [CVE-2022-43945](https://nvd.nist.gov/vuln/detail/CVE-2022-43945){: external}, [CVE-2022-44640](https://nvd.nist.gov/vuln/detail/CVE-2022-44640){: external}, [CVE-2022-45934](https://nvd.nist.gov/vuln/detail/CVE-2022-45934){: external}, [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
| Ubuntu 20.04 packages | 5.4.0-135 | 5.4.0-137 | Worker node kernel & package updates for [CVE-2021-44758](https://nvd.nist.gov/vuln/detail/CVE-2021-44758){: external}, [CVE-2022-0392](https://nvd.nist.gov/vuln/detail/CVE-2022-0392){: external}, [CVE-2022-0417](https://nvd.nist.gov/vuln/detail/CVE-2022-0417){: external}, [CVE-2022-2663](https://nvd.nist.gov/vuln/detail/CVE-2022-2663){: external}, [CVE-2022-3061](https://nvd.nist.gov/vuln/detail/CVE-2022-3061){: external}, [CVE-2022-3437](https://nvd.nist.gov/vuln/detail/CVE-2022-3437){: external}, [CVE-2022-3643](https://nvd.nist.gov/vuln/detail/CVE-2022-3643){: external}, [CVE-2022-42896](https://nvd.nist.gov/vuln/detail/CVE-2022-42896){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2022-43552](https://nvd.nist.gov/vuln/detail/CVE-2022-43552){: external}, [CVE-2022-43945](https://nvd.nist.gov/vuln/detail/CVE-2022-43945){: external}, [CVE-2022-44640](https://nvd.nist.gov/vuln/detail/CVE-2022-44640){: external}, [CVE-2022-45934](https://nvd.nist.gov/vuln/detail/CVE-2022-45934){: external}, [CVE-2022-47629](https://nvd.nist.gov/vuln/detail/CVE-2022-47629){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.25.5_1527" caption-side="bottom"}


### Change log for worker node fix pack 1.25.5_1527, released 02 January 2023
{: #1255_1527}

The following table shows the changes that are in the worker node fix pack 1.25.5_1527. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A|N/A|
| Ubuntu 20.04 packages |N/A|N/A|N/A|
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.25.5_1526" caption-side="bottom"}


### Change log for worker node fix pack 1.25.5_1526, released 19 December 2022
{: #1255_1526}

The following table shows the changes that are in the worker node fix pack 1.25.5_1526. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Containerd | 1.6.10 | 1.6.12 | See the [1.6.12 change log](https://github.com/containerd/containerd/releases/tag/v1.6.12){: external}, the [1.6.11 change log](https://github.com/containerd/containerd/releases/tag/v1.6.11){: external}, and the security bulletin for [CVE-2022-23471](https://www.ibm.com/support/pages/node/6850799){: external}. |
| Ubuntu 18.04 packages | 4.15.0-197 | 4.15.0-200 | Worker node kernel & package updates for [CVE-2022-2309](https://nvd.nist.gov/vuln/detail/CVE-2022-2309){: external}, [CVE-2022-38533](https://nvd.nist.gov/vuln/detail/CVE-2022-38533){: external}, [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external}, [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external}, [CVE-2022-41916](https://nvd.nist.gov/vuln/detail/CVE-2022-41916){: external}, [CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}. |
| Ubuntu 20.04 packages | 5.4.0-132 | 5.4.0-135 | Worker node kernel & package updates for [CVE-2022-2309](https://nvd.nist.gov/vuln/detail/CVE-2022-2309){: external}, [CVE-2022-38533](https://nvd.nist.gov/vuln/detail/CVE-2022-38533){: external}, [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external}, [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external}, [CVE-2022-41916](https://nvd.nist.gov/vuln/detail/CVE-2022-41916){: external}. |
| Kubernetes | 1.25.4 | 1.25.5 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.5){: external}. |
{: caption="Changes since version 1.25.4_1524" caption-side="bottom"}


### Change log for master fix pack 1.25.5_1525, released 14 December 2022
{: #1255_1525}

The following table shows the changes that are in the master fix pack 1.25.5_1525. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.13 | v1.3.14 | Updated `Go` dependencies. Exclude ingress status from cluster status aggregation. |
| etcd | v3.5.5 | v3.5.6 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.6){: external}. |
| GPU device plug-in and installer | cce0cfa | 03fd318 | Update GPU images with `Go` version `1.19.2` to resolve vulnerabilities |
| {{site.data.keyword.IBM_notm}} Calico extension | 1213 | 1257 | Updated universal base image (UBI) to resolve: [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/cve-2022-1304){: external}, [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.3 | v2.3.4 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.18.6` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.3-10 | v1.25.4-2 | Updated to support the `Kubernetes 1.25.4` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 420 | 421 | Updated universal base image (UBI) to resolve [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. Updated `Go` to version `1.18.8` |
| Key Management Service provider | v2.5.11 | v2.5.12 | Updated `Go` dependencies. |
| Kubernetes | v1.25.4 | v1.25.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2110 | 2325 | Update `Go` to version `1.19.1` and update dependencies. |
{: caption="Changes since version 1.25.4_1522" caption-side="bottom"}


### Change log for worker node fix pack 1.25.4_1524, released 05 December 2022
{: #1254_1524}

The following table shows the changes that are in the worker node fix pack 1.25.4_1524. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|Containerd|1.6.8|1.6.10|See the [1.6.10 change log](https://github.com/containerd/containerd/releases/tag/v1.6.10){: external} and the [1.6.9 change log](https://github.com/containerd/containerd/releases/tag/v1.6.9){: external}. |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2013-4235](https://nvd.nist.gov/vuln/detail/CVE-2013-4235){: external}, [CVE-2022-3239](https://nvd.nist.gov/vuln/detail/CVE-2022-3239){: external}, [CVE-2022-3524](https://nvd.nist.gov/vuln/detail/CVE-2022-3524){: external}, [CVE-2022-3564](https://nvd.nist.gov/vuln/detail/CVE-2022-3564){: external}, [CVE-2022-3565](https://nvd.nist.gov/vuln/detail/CVE-2022-3565){: external}, [CVE-2022-3566](https://nvd.nist.gov/vuln/detail/CVE-2022-3566){: external}, [CVE-2022-3567](https://nvd.nist.gov/vuln/detail/CVE-2022-3567){: external}, [CVE-2022-3594](https://nvd.nist.gov/vuln/detail/CVE-2022-3594){: external}, [CVE-2022-3621](https://nvd.nist.gov/vuln/detail/CVE-2022-3621){: external}, [CVE-2022-42703](https://nvd.nist.gov/vuln/detail/CVE-2022-42703){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAProxy | c619f4 | 508bf6 | [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}. |
| CUDA | fd4353 | 0ab756 | [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}. |
{: caption="Changes since version 1.25.4_1523" caption-side="bottom"}


### Change log for worker node fix pack 1.25.4_1523, released 21 November 2022
{: #1254_1523}

The following table shows the changes that are in the worker node fix pack 1.25.4_1523. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-194 | 4.15.0-197 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external}, [CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external}, [CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external}, [CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2022-2978](https://nvd.nist.gov/vuln/detail/CVE-2022-2978){: external}, [CVE-2022-3028](https://nvd.nist.gov/vuln/detail/CVE-2022-3028){: external}, [CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external}, [CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-35737](https://nvd.nist.gov/vuln/detail/CVE-2022-35737){: external}, [CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external}, [CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external}, [CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external}, [CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674){: external}, [CVE-2022-40768](https://nvd.nist.gov/vuln/detail/CVE-2022-40768){: external}, [CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}, [CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external}, [CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external}, [CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.25.3 | 1.25.4 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.4){: external}. |
| CUDA | 576234 | cce0cf | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.25.3_1521" caption-side="bottom"}


### Change log for master fix pack 1.25.4_1522, released 16 November 2022
{: #1254_1522}

The following table shows the changes that are in the master fix pack 1.25.4_1522. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.24.1 | v3.24.5 | See the [Calico release notes](https://docs.tigera.io/archive/v3.24/release-notes/#v3245){: external}. |
| Cluster health image | v1.3.12 | v1.3.13 | Updated `Go` dependencies, `golangci-lint`, `gosec`, in `Go` version 1.19.3. Updated base image version to 116. |
| etcd | v3.5.4 | v3.5.5 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.5){: external}. |
| Gateway-enabled cluster controller | 1823 | 1902 | `Go` module updates. |
| GPU device plug-in and installer | 373bb9f | cce0cfa | Updated the GPU driver 470 minor version |
| {{site.data.keyword.IBM_notm}} Calico extension | 1096 | 1213 | Updated image to fix the following CVEs: [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2022-3515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3515){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-32149](https://nvd.nist.gov/vuln/detail/CVE-2022-32149){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.1 | v2.3.3 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.3-1 | v1.25.3-10 | Key rotation, updated `Go` to version `1.19`, and updated `Go` dependencies. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 416 | 420 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| Key Management Service provider | v2.5.10 | v2.5.11 | Updated `Go` dependencies and to `Go` version `1.19.3`. |
| Kubernetes | v1.25.3 | v1.25.4 | [CVE-2022-3294](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3294){: external} and [CVE-2022-3162](https://nvd.nist.gov/vuln/detail/CVE-2022-3162){: external}. For more information, see [{{site.data.keyword.containerlong_notm}} is affected by Kubernetes API server security vulnerabilities CVE-2022-3294 and CVE-2022-3162](https://www.ibm.com/support/pages/node/6844715){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.4){: external}. |
{: caption="Changes since version 1.25.3_1520" caption-side="bottom"}


### Change log for worker node fix pack 1.25.3_1521, released 07 November 2022
{: #1253_1521}

The following table shows the changes that are in the worker node fix pack 1.25.3_1521. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external}, [CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external}, [CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external}, [CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external}, [CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.25.2 | 1.25.3 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.3){: external}. |
| HAProxy | b034b2 | 3a1392 | [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}. |
| CUDA | 3ea43b | 576234 | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.25.2_1519" caption-side="bottom"}


### Change log for master fix pack 1.25.3_1520, released 27 October 2022
{: #1253_1520}

The following table shows the changes that are in the master fix pack 1.25.3_1520. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.11 | v1.3.12 | Updated `Go` dependencies, golangci-lint, and to `Go` version 1.19.2. Updated base image version to 109. Excluded ingress status from cluster status calculation. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.2-2 | v1.25.3-1 | Updated to support the `Kubernetes 1.25.3` release. |
| Key Management Service provider | v2.5.9 | v2.5.10 | Updated `Go` dependencies and to `Go` version `1.19.2`. |
| Kubernetes | v1.25.2 | v1.25.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.3){: external}. |
| Konnectivity agent and server | v0.0.32_363_iks | v0.0.33_418_iks | Updated Konnectivity to version v0.0.33 and added s390x functionality. See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.33){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | dc1725a | 778ef2b | Updated to `Go` version `1.18.6`. |
{: caption="Changes since version 1.25.21517" caption-side="bottom"}


### Change log for worker node fix pack 1.25.2_1519, released 25 October 2022
{: #1252_1519}

The following table shows the changes that are in the worker node fix pack 1.25.2_1519. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-193 | 4.15.0-194 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external}, [CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external}, [CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external}, [CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external}, [CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external}. | 
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.25.2_1518" caption-side="bottom"}


### Change log for master fix pack 1.25.2_1517 and worker node fix pack 1.25.2_1516, released 6 October 2022
{: #1252_1517_and_1252_1516}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.23.3 | v3.24.1 | See the [Calico release notes](https://docs.tigera.io/archive/v3.24/release-notes/){: external}. In addition, a `default` `FelixConfiguration` resource is created if it doesn't exist. The resource has `natPortRange` set to `32768:65535`. For more information, see [Why am I seeing SNAT port issues and egress connection failures?](/docs/containers?topic=containers-ts-network-snat-125){: external} |
| CoreDNS | 1.9.3 | 1.10.0 | See the [CoreDNS release notes](https://github.com/coredns/coredns/blob/v1.10.0/notes/coredns-1.10.0.md){: external}. |
| IBM Cloud Controller Manager | v1.24.5-1 | v1.25.2-2 | Updated to support the Kubernetes `1.25.2` release and `Go` version `1.19.1`. |
| Kubernetes | v1.24.6 | v1.25.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.2){: external}. |
| Kubernetes admission controllers configuration | N/A | N/A | Enabled the `PodSecurity` and removed the `PodSecurityPolicy` admission controllers. [Pod Security Policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external} were removed in Kubernetes version 1.25. See the Kubernetes [Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#psp-v125){: external} for more information. {{site.data.keyword.containerlong_notm}} version 1.25 now configures [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){: external} and no longer supports [Pod Security Policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. For more information, see [Migrating from PSPs to Pod Security Admission](/docs/containers?topic=containers-pod-security-admission-migration). |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates). |
| Kubernetes CSI snapshot CRDs | v5.0.1 | v6.0.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.0.1){: external}. |
| Kubernetes CSI snapshot controller | None | v6.0.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.0.1){: external}. |
| Kubernetes Dashboard | v2.6.1 | v2.7.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.7.0){: external}. |
| Kubernetes DNS autoscaler | 1.8.5 | 1.8.6 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.6){: external}. In addition, CPU resource requests were reduced from `5m` to `1m` to better align with normal resource utilization. |
| Pause container image | 3.7 | 3.8 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: caption="Changes since version 1.24.6_1538 master and 1.24.6_1539 worker node."}


