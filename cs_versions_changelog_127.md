---

copyright: 
  years: 2023, 2023
lastupdated: "2023-11-09"

keywords: kubernetes, containers, change log, 127 change log, 127 updates

subcollection: containers


---

# Kubernetes version 1.27 change log
{: #changelog_127}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.27. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_127}

In clusters that run version 1.23 or earlier, the {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. In version 1.24 and later, most new beta features are disabled by default. Kubernetes alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}




## Version 1.27 change log
{: #127_changelog}


Review the version 1.27 change log.
{: shortdesc}



### Change log for master fix pack 1.27.6_1544, released 25 October 2023
{: #1276_1544_M}

The following table shows the changes that are in the master fix pack 1.27.6_1544. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.26.1 | v3.26.3 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#v3.26.3){: external}. |
| Cluster health image | v1.4.2 | v1.4.4 | New version contains updates and security fixes. |
| GPU device plug-in and installer | 8e87e60 | 4319682 | New version contains updates and security fixes. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1390 | 1487 | New version contains security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.10 | v2.4.12 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.27.5-3 | v1.27.6-8 | New version contains updates and security fixes. The logic for the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-idle-connection-timeout` annotation has changed. The default idle timeout is dependent on your account settings. In most cases, this value is `50`. However some allowlisted accounts have larger timeout settings. If you don't set the annotation, your load balancers use the timeout setting in your account. You can explicitly specify the timeout by setting this annotation. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4e2f346 | f0d3265 | New version contains updates and security fixes. |
| Key Management Service provider | v2.8.2 | v2.8.4 | New version contains updates and security fixes. |
| Kubernetes | v1.27.5 | v1.27.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.6){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.23 | 1.22.24 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.24){: external}. |
| Portieris admission controller | v0.13.6 | v0.13.8 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.8){: external}. |
{: caption="Changes since version 1.27.5_1540" caption-side="bottom"}


### Change log for worker node fix pack 1.27.6_1545, released 23 October 2023
{: #1276_1545_W}

The following table shows the changes that are in the worker node fix pack 1.27.6_1545. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-164-generic | 5.4.0-165-generic | Worker node kernel & package updates for [CVE-2022-3234](https://nvd.nist.gov/vuln/detail/CVE-2022-3234){: external}, [CVE-2022-3256](https://nvd.nist.gov/vuln/detail/CVE-2022-3256){: external}, [CVE-2022-3324](https://nvd.nist.gov/vuln/detail/CVE-2022-3324){: external}, [CVE-2022-3352](https://nvd.nist.gov/vuln/detail/CVE-2022-3352){: external}, [CVE-2022-3520](https://nvd.nist.gov/vuln/detail/CVE-2022-3520){: external}, [CVE-2022-3591](https://nvd.nist.gov/vuln/detail/CVE-2022-3591){: external}, [CVE-2022-3705](https://nvd.nist.gov/vuln/detail/CVE-2022-3705){: external}, [CVE-2022-4292](https://nvd.nist.gov/vuln/detail/CVE-2022-4292){: external}, [CVE-2022-4293](https://nvd.nist.gov/vuln/detail/CVE-2022-4293){: external}, [CVE-2023-34319](https://nvd.nist.gov/vuln/detail/CVE-2023-34319){: external}, [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}, [CVE-2023-42752](https://nvd.nist.gov/vuln/detail/CVE-2023-42752){: external}, [CVE-2023-42753](https://nvd.nist.gov/vuln/detail/CVE-2023-42753){: external}, [CVE-2023-42755](https://nvd.nist.gov/vuln/detail/CVE-2023-42755){: external}, [CVE-2023-42756](https://nvd.nist.gov/vuln/detail/CVE-2023-42756){: external}, [CVE-2023-4622](https://nvd.nist.gov/vuln/detail/CVE-2023-4622){: external}, [CVE-2023-4623](https://nvd.nist.gov/vuln/detail/CVE-2023-4623){: external}, [CVE-2023-4881](https://nvd.nist.gov/vuln/detail/CVE-2023-4881){: external}, [CVE-2023-4921](https://nvd.nist.gov/vuln/detail/CVE-2023-4921){: external}. |
| Kubernetes | 1.27.5 | 1.27.6 | see [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.6){: external}. |
| Containerd | 1.7.6 | 1.7.7 | see [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.7){: external}. |
{: caption="Changes since version 1.27.5_1542" caption-side="bottom"}


### Change log for worker node fix pack 1.27.5_1542, released 9 October 2023
{: #1275_1542_W}

The following table shows the changes that are in the worker node fix pack 1.27.5_1542. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-163-generic | 5.4.0-164-generic | Worker node kernel & package updates for [CVE-2021-4001](https://nvd.nist.gov/vuln/detail/CVE-2021-4001){: external}, [CVE-2023-1206](https://nvd.nist.gov/vuln/detail/CVE-2023-1206){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-3212](https://nvd.nist.gov/vuln/detail/CVE-2023-3212){: external}, [CVE-2023-3863](https://nvd.nist.gov/vuln/detail/CVE-2023-3863){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-4194](https://nvd.nist.gov/vuln/detail/CVE-2023-4194){: external}, [CVE-2023-43785](https://nvd.nist.gov/vuln/detail/CVE-2023-43785){: external}, [CVE-2023-43786](https://nvd.nist.gov/vuln/detail/CVE-2023-43786){: external}, [CVE-2023-43787](https://nvd.nist.gov/vuln/detail/CVE-2023-43787){: external}. |
| Kubernetes | N/A |N/A|N/A|
| Containerd | N/A |N/A|N/A|
{: caption="Changes since version 1.27.5_1541" caption-side="bottom"}


### Change log for worker node fix pack 1.27.5_1541, released 27 September 2023
{: #1275_1541_W}

The following table shows the changes that are in the worker node fix pack 1.27.5_1541. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-162-generic | 5.4.0-163-generic| Package updates for [CVE-2023-3341](https://nvd.nist.gov/vuln/detail/CVE-2023-3341){: external}, [CVE-2023-4156](https://nvd.nist.gov/vuln/detail/CVE-2023-4156){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-20900](https://nvd.nist.gov/vuln/detail/CVE-2023-20900){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}. |
| RHEL 8 Packages | 4.18.0-477.21.1.el8_8 | 4.18.0-477.27.1.el8_8 | Worker node kernel & package updates for [CVE-2023-2002](https://nvd.nist.gov/vuln/detail/CVE-2023-2002){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-3776](https://nvd.nist.gov/vuln/detail/CVE-2023-3776){: external}, [CVE-2023-4004](https://nvd.nist.gov/vuln/detail/CVE-2023-4004){: external}, [CVE-2023-20593](https://nvd.nist.gov/vuln/detail/CVE-2023-20593){: external}, [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}, [CVE-2023-30630](https://nvd.nist.gov/vuln/detail/CVE-2023-30630){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}, [CVE-2023-35788](https://nvd.nist.gov/vuln/detail/CVE-2023-35788){: external}. |
{: caption="Changes since version 1.27.4_1538" caption-side="bottom"}


### Change log for master fix pack 1.27.5_1540, released 20 September 2023
{: #1275_1540_M}

The following table shows the changes that are in the master fix pack 1.27.5_1540. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.26.0 | v3.26.1 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#v3.26.1){: external}. |
| Cluster health image | v1.4.1 | v1.4.2 | Updated `Go` to version `1.20.8` and updated dependencies. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.5 | v2.4.10 | Updated `Go dependencies`. Updated to newer UBI base image. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.27.4-5 | v1.27.5-3 | Updated to support the `Kubernetes 1.27.5` release. Updated `Go` to version `1.20.7` and updated `Go dependencies`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 434 | 435 | Updated `Go` to version `1.20.6` and updated dependencies. Updated to newer UBI base image. |
| Key Management Service provider | v2.8.1 | v2.8.2 | Updated `Go dependencies`. |
| Kubernetes | v1.27.4 | v1.27.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2631 | 2681 | Updated `Go` to version `1.19.12` and updated `Go dependencies`. |
{: caption="Changes since version 1.27.4_1536" caption-side="bottom"}


### Change log for worker node fix pack 1.27.4_1538, released 12 September 2023
{: #1274_1538_W}

The following table shows the changes that are in the worker node fix pack 1.27.4_1538. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-156-generic | 5.4.0-162-generic | Worker node kernel & package updates for [CVE-2020-21047](https://nvd.nist.gov/vuln/detail/CVE-2020-21047){: external}, [CVE-2021-33294](https://nvd.nist.gov/vuln/detail/CVE-2021-33294){: external}, [CVE-2022-40982](https://nvd.nist.gov/vuln/detail/CVE-2022-40982){: external}, [CVE-2023-20593](https://nvd.nist.gov/vuln/detail/CVE-2023-20593){: external}[CVE-2023-2269](https://nvd.nist.gov/vuln/detail/CVE-2023-2269){: external}, [CVE-2023-31084](https://nvd.nist.gov/vuln/detail/CVE-2023-31084){: external}, [CVE-2023-3268](https://nvd.nist.gov/vuln/detail/CVE-2023-3268){: external}, [CVE-2023-3609](https://nvd.nist.gov/vuln/detail/CVE-2023-3609){: external}, [CVE-2023-3611](https://nvd.nist.gov/vuln/detail/CVE-2023-3611){: external}, [CVE-2023-3776](https://nvd.nist.gov/vuln/detail/CVE-2023-3776){: external}. |
| Containerd | 1.7.4| 1.7.5 |N/A|
{: caption="Changes since version 1.27.4_1537" caption-side="bottom"}


### Change log for master fix pack 1.27.4_1536, released 30 August 2023
{: #1274_1536_M}

The following table shows the changes that are in the master fix pack 1.27.4_1536. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.4.0 | v1.4.1 | Updated `Go` to version `1.19.12` and updated dependencies. |
| GPU device plug-in and installer | 495931a | 8e87e60 | Updated `Go` to version `1.19.11` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.27.4-1 | v1.27.4-5 | Updated `Go` dependencies to resolve a CVE. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 433 | 434 | Updated `Go` to version `1.20.6` and updated dependencies. Updated to newer UBI base image. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | d293d8b | a1edf56 | Updated `Go` to version `1.20.6`. |
| Key Management Service provider | v2.8.0 | v2.8.1 | Updated `Go` dependencies |
| Portieris admission controller | v0.13.5 | v0.13.6 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.6){: external}. |
{: caption="Changes since version 1.27.4_1533" caption-side="bottom"}


### Change log for worker node fix pack 1.27.4_1537, released 28th August 2023
{: #1274_1537_W}

The following table shows the changes that are in the worker node fix pack 1.27.4_1537. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-155-generic | 5.4.0-156-generic | Worker node kernel & package updates for [CVE-2022-2598](https://nvd.nist.gov/vuln/detail/CVE-2022-2598){: external}, [CVE-2022-3016](https://nvd.nist.gov/vuln/detail/CVE-2022-3016){: external}, [CVE-2022-3037](https://nvd.nist.gov/vuln/detail/CVE-2022-3037){: external}, [CVE-2022-3099](https://nvd.nist.gov/vuln/detail/CVE-2022-3099){: external}, [CVE-2023-40225](https://nvd.nist.gov/vuln/detail/CVE-2023-40225){: external}. |
{: caption="Changes since version 1.27.4_1535" caption-side="bottom"}


### Change log for worker node fix pack 1.27.4_1535, released 15th August 2023
{: #1274_1535_W}

The following table shows the changes that are in the worker node fix pack 1.27.4_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | N/A | N/A | Package updates for [CVE-2020-36691](https://nvd.nist.gov/vuln/detail/CVE-2020-36691){: external}, [CVE-2022-0168](https://nvd.nist.gov/vuln/detail/CVE-2022-0168){: external}, [CVE-2022-1184](https://nvd.nist.gov/vuln/detail/CVE-2022-1184){: external}, [CVE-2022-2208](https://nvd.nist.gov/vuln/detail/CVE-2022-2208){: external}, [CVE-2022-2210](https://nvd.nist.gov/vuln/detail/CVE-2022-2210){: external}, [CVE-2022-2257](https://nvd.nist.gov/vuln/detail/CVE-2022-2257){: external}, [CVE-2022-2264](https://nvd.nist.gov/vuln/detail/CVE-2022-2264){: external}, [CVE-2022-2284](https://nvd.nist.gov/vuln/detail/CVE-2022-2284){: external}, [CVE-2022-2285](https://nvd.nist.gov/vuln/detail/CVE-2022-2285){: external}, [CVE-2022-2286](https://nvd.nist.gov/vuln/detail/CVE-2022-2286){: external}, [CVE-2022-2287](https://nvd.nist.gov/vuln/detail/CVE-2022-2287){: external}, [CVE-2022-2289](https://nvd.nist.gov/vuln/detail/CVE-2022-2289){: external}, [CVE-2022-27672](https://nvd.nist.gov/vuln/detail/CVE-2022-27672){: external}, [CVE-2022-4269](https://nvd.nist.gov/vuln/detail/CVE-2022-4269){: external}, [CVE-2023-1611](https://nvd.nist.gov/vuln/detail/CVE-2023-1611){: external}, [CVE-2023-2124](https://nvd.nist.gov/vuln/detail/CVE-2023-2124){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-3111](https://nvd.nist.gov/vuln/detail/CVE-2023-3111){: external}, [CVE-2023-3141](https://nvd.nist.gov/vuln/detail/CVE-2023-3141){: external}, [CVE-2023-32629](https://nvd.nist.gov/vuln/detail/CVE-2023-32629){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}. |
| Kubernetes | N/A | N/A | N/A |
| Containerd | N/A | N/A | N/A |
{: caption="Changes since version 1.27.4_1534" caption-side="bottom"}


### Change log for worker node fix pack 1.27.4_1534, released 1 August 2023
{: #1274_1534_W}

The following table shows the changes that are in the worker node fix pack 1.27.4_1534. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-212-generic | 4.15.0-214-generic | Worker node kernel & package updates for [CVE-2020-13987](https://nvd.nist.gov/vuln/detail/CVE-2020-13987){: external}, [CVE-2020-13988](https://nvd.nist.gov/vuln/detail/CVE-2020-13988){: external}, [CVE-2020-17437](https://nvd.nist.gov/vuln/detail/CVE-2020-17437){: external}, [CVE-2022-1184](https://nvd.nist.gov/vuln/detail/CVE-2022-1184){: external}, [CVE-2022-3303](https://nvd.nist.gov/vuln/detail/CVE-2022-3303){: external}, [CVE-2023-1611](https://nvd.nist.gov/vuln/detail/CVE-2023-1611){: external}, [CVE-2023-1670](https://nvd.nist.gov/vuln/detail/CVE-2023-1670){: external}, [CVE-2023-1859](https://nvd.nist.gov/vuln/detail/CVE-2023-1859){: external}, [CVE-2023-1990](https://nvd.nist.gov/vuln/detail/CVE-2023-1990){: external}, [CVE-2023-20867](https://nvd.nist.gov/vuln/detail/CVE-2023-20867){: external}, [CVE-2023-2124](https://nvd.nist.gov/vuln/detail/CVE-2023-2124){: external}, [CVE-2023-2828](https://nvd.nist.gov/vuln/detail/CVE-2023-2828){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-3111](https://nvd.nist.gov/vuln/detail/CVE-2023-3111){: external}, [CVE-2023-3141](https://nvd.nist.gov/vuln/detail/CVE-2023-3141){: external}, [CVE-2023-3268](https://nvd.nist.gov/vuln/detail/CVE-2023-3268){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}. |
| Ubuntu 20.04 packages | 5.4.0-153-generic | 5.4.0-155-generic | Worker node kernel & package updates for [CVE-2020-13987](https://nvd.nist.gov/vuln/detail/CVE-2020-13987){: external}, [CVE-2020-13988](https://nvd.nist.gov/vuln/detail/CVE-2020-13988){: external}, [CVE-2020-17437](https://nvd.nist.gov/vuln/detail/CVE-2020-17437){: external}, [CVE-2023-20867](https://nvd.nist.gov/vuln/detail/CVE-2023-20867){: external}, [CVE-2023-28321](https://nvd.nist.gov/vuln/detail/CVE-2023-28321){: external}, [CVE-2023-28322](https://nvd.nist.gov/vuln/detail/CVE-2023-28322){: external}, [CVE-2023-3090](https://nvd.nist.gov/vuln/detail/CVE-2023-3090){: external}, [CVE-2023-32629](https://nvd.nist.gov/vuln/detail/CVE-2023-32629){: external}, [CVE-2023-3390](https://nvd.nist.gov/vuln/detail/CVE-2023-3390){: external}, [CVE-2023-35001](https://nvd.nist.gov/vuln/detail/CVE-2023-35001){: external}, [CVE-2023-38408](https://nvd.nist.gov/vuln/detail/CVE-2023-38408){: external}. |
| Kubernetes | 1.27.3 | 1.27.4 | see [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.4){: external}. |
| Containerd | 1.6.21 | 1.6.22 | see [change logs](https://github.com/containerd/containerd/releases/tag/v1.6.22){: external}. |
{: caption="Changes since version 1.27.3_1532" caption-side="bottom"}


### Change log for master fix pack 1.27.4_1533, released 27 July 2023
{: #1274_1533_M}

The following table shows the changes that are in the master fix pack 1.27.4_1533. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.21 | v1.4.0 | Updated `Go` to version `1.19.11` and updated `Go` dependencies. Updated UBI base image with FedRAMP enablement support. |
| etcd | N/A | N/A | etcd is now automatically defragmented when necessary. |
| GPU device plug-in and installer | 202b284 | 495931a | Updated `Go` to version `1.20.6`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.27.3-1 | v1.27.4-1 | Updated to support the Kubernetes `1.27.4` release. Updated `Go` dependencies and to `Go` version `1.20.6`. Updates to classic load balancers are now staggered. |
| Key Management Service provider | v2.6.7 | v2.8.0 | Updated `Go` to version `1.19.11` and updated `Go` dependencies. Updated UBI base image with FedRAMP enablement support. |
| Konnectivity agent and server | v0.1.2_591_iks | v0.1.3_5_iks | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.1.3){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.21 | 1.22.23 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.23){: external}. |
| Kubernetes | v1.27.3 | v1.27.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2584 | 2631 | Updated `Go` to version `1.19.10` and updated `Go` dependencies. Updated Alpine base image. |
{: caption="Changes since version 1.27.3_1529" caption-side="bottom"}


### Change log for worker node fix pack 1.27.3_1532, released 17 July 2023
{: #1273_1532_W}

The following table shows the changes that are in the worker node fix pack 1.27.3_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Kubernetes | N/A | N/A | N/A |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2023-24626](https://nvd.nist.gov/vuln/detail/CVE-2023-24626){: external}, [CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external}. |
| Ubuntu 20.04 packages | N/A | N/A | N/A |
{: caption="Changes since version 1.27.3_1530" caption-side="bottom"}


### Change log for worker node fix pack 1.27.3_1530, released 03 July 2023
{: #1273_1530_W}

The following table shows the changes that are in the worker node fix pack 1.27.3_1530. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2023-2603](https://nvd.nist.gov/vuln/detail/CVE-2023-2603){: external},[CVE-2023-3138](https://nvd.nist.gov/vuln/detail/CVE-2023-3138){: external}
| Ubuntu 20.04 packages | 5.4.0-150-generic | 5.4.0-153-generic | Worker node kernel & package updates for [CVE-2023-0461](https://nvd.nist.gov/vuln/detail/CVE-2023-0461){: external},[CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external},[CVE-2023-1670](https://nvd.nist.gov/vuln/detail/CVE-2023-1670){: external},[CVE-2023-1859](https://nvd.nist.gov/vuln/detail/CVE-2023-1859){: external},[CVE-2023-2612](https://nvd.nist.gov/vuln/detail/CVE-2023-2612){: external},[CVE-2023-2828](https://nvd.nist.gov/vuln/detail/CVE-2023-2828){: external},[CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external},[CVE-2023-3138](https://nvd.nist.gov/vuln/detail/CVE-2023-3138){: external},[CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external},[CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external},[CVE-2023-3297](https://nvd.nist.gov/vuln/detail/CVE-2023-3297){: external}. |
| Kubernetes | 1.27.2 | 1.27.3 |See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#v1273){: external}.|
{: caption="Changes since version 1.27.2_1528" caption-side="bottom"}


### Change log for master fix pack 1.27.3_1529, released 27 June 2023
{: #1273_1529_M}

The following table shows the changes that are in the master fix pack 1.27.3_1529. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.25.1 | v3.26.0 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#v3.26.0){: external}. |
| Cluster health image | v1.3.20 | v1.3.21 | Updated `Go` dependencies and to `Go` version `1.19.10`. |
| etcd | v3.5.8 | v3.5.9 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.9){: external}. |
| GPU device plug-in and installer | 28d80a0 | 202b284 | Updated to `Go` version `1.19.9` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.27.1-8 | v1.27.3-1 | Updated to support the `Kubernetes 1.27.3` release. Updated `Go` dependencies and to `Go` version `1.20.5`. Updated `calicoctl` and `vpcctl`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 431 | 433 | Updated `Go` to version `1.20.4`. Updated UBI base image. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | d842983 | d293d8b | Updated `Go` to version `1.20.5`. Updates to build and base images. |
| Key Management Service provider | v2.6.6 | v2.6.7 | Updated `Go` dependencies and to `Go` version `1.19.10`. |
| Kubernetes | v1.27.2 | v1.27.3 | [CVE-2023-2728](https://nvd.nist.gov/vuln/detail/CVE-2023-2728){: external}. For more information, see [{{site.data.keyword.containerlong_notm}} is affected by a Kubernetes API server security vulnerability (CVE-2023-2728)](https://www.ibm.com/support/pages/node/7011039){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.3){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2486 | 2584 | Updated `Go` dependencies and to `Go` version `1.19.9`. Updated base image. |
{: caption="Changes since version 1.27.2_1524" caption-side="bottom"}


### Change log for worker node fix pack 1.27.2_1528, released 19 June 2023
{: #1272_1528_W}

The following table shows the changes that are in the worker node fix pack 1.27.2_1528. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2020-11080](https://nvd.nist.gov/vuln/detail/CVE-2020-11080){: external},[CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external},[CVE-2023-2603](https://nvd.nist.gov/vuln/detail/CVE-2023-2603){: external},[CVE-2023-2609](https://nvd.nist.gov/vuln/detail/CVE-2023-2609){: external},[CVE-2023-2610](https://nvd.nist.gov/vuln/detail/CVE-2023-2610){: external},[CVE-2023-32681](https://nvd.nist.gov/vuln/detail/CVE-2023-32681){: external}
| Ubuntu 20.04 packages | 5.4.0-149-generic | 5.4.0-150-generic | Worker node kernel & package updates for [CVE-2020-11080](https://nvd.nist.gov/vuln/detail/CVE-2020-11080){: external},[CVE-2021-45078](https://nvd.nist.gov/vuln/detail/CVE-2021-45078){: external},[CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external},[CVE-2023-1667](https://nvd.nist.gov/vuln/detail/CVE-2023-1667){: external},[CVE-2023-1670](https://nvd.nist.gov/vuln/detail/CVE-2023-1670){: external},[CVE-2023-1859](https://nvd.nist.gov/vuln/detail/CVE-2023-1859){: external},[CVE-2023-2283](https://nvd.nist.gov/vuln/detail/CVE-2023-2283){: external},[CVE-2023-24329](https://nvd.nist.gov/vuln/detail/CVE-2023-24329){: external},[CVE-2023-24593](https://nvd.nist.gov/vuln/detail/CVE-2023-24593){: external},[CVE-2023-2602](https://nvd.nist.gov/vuln/detail/CVE-2023-2602){: external},[CVE-2023-2603](https://nvd.nist.gov/vuln/detail/CVE-2023-2603){: external},[CVE-2023-2609](https://nvd.nist.gov/vuln/detail/CVE-2023-2609){: external},[CVE-2023-2610](https://nvd.nist.gov/vuln/detail/CVE-2023-2610){: external},[CVE-2023-2612](https://nvd.nist.gov/vuln/detail/CVE-2023-2612){: external},[CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external},[CVE-2023-3138](https://nvd.nist.gov/vuln/detail/CVE-2023-3138){: external},[CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external},[CVE-2023-31484](https://nvd.nist.gov/vuln/detail/CVE-2023-31484){: external},[CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external},[CVE-2023-32643](https://nvd.nist.gov/vuln/detail/CVE-2023-32643){: external},[CVE-2023-32681](https://nvd.nist.gov/vuln/detail/CVE-2023-32681){: external}. |
| Kubernetes | N/A |N/A|N/A|
{: caption="Changes since version 1.27.2_1527" caption-side="bottom"}


### Change log for worker node fix pack 1.27.2_1527, released 5 June 2023
{: #1272_1527_W}

The following table shows the changes that are in the worker node fix pack 1.27.2_1527. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-211-generic | 4.15.0-212-generic | Worker node kernel & package updates for [CVE-2019-17595](https://nvd.nist.gov/vuln/detail/CVE-2019-17595){: external}, [CVE-2021-39537](https://nvd.nist.gov/vuln/detail/CVE-2021-39537){: external}, [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}, [CVE-2022-4304](https://nvd.nist.gov/vuln/detail/CVE-2022-4304){: external}, [CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external}, [CVE-2023-25584](https://nvd.nist.gov/vuln/detail/CVE-2023-25584){: external}, [CVE-2023-25585](https://nvd.nist.gov/vuln/detail/CVE-2023-25585){: external}, [CVE-2023-25588](https://nvd.nist.gov/vuln/detail/CVE-2023-25588){: external}, [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}, [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}, [CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external}, [CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external}, [CVE-2023-31484](https://nvd.nist.gov/vuln/detail/CVE-2023-31484){: external}, [CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external}. |
| Ubuntu 20.04 packages | 5.4.0-148-generic | 5.4.0-149-generic | Worker node kernel & package updates for [CVE-2021-39537](https://nvd.nist.gov/vuln/detail/CVE-2021-39537){: external}, [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}, [CVE-2023-1075](https://nvd.nist.gov/vuln/detail/CVE-2023-1075){: external}, [CVE-2023-1118](https://nvd.nist.gov/vuln/detail/CVE-2023-1118){: external}, [CVE-2023-1380](https://nvd.nist.gov/vuln/detail/CVE-2023-1380){: external}, [CVE-2023-25584](https://nvd.nist.gov/vuln/detail/CVE-2023-25584){: external}, [CVE-2023-25585](https://nvd.nist.gov/vuln/detail/CVE-2023-25585){: external}, [CVE-2023-25588](https://nvd.nist.gov/vuln/detail/CVE-2023-25588){: external}, [CVE-2023-2612](https://nvd.nist.gov/vuln/detail/CVE-2023-2612){: external}, [CVE-2023-2650](https://nvd.nist.gov/vuln/detail/CVE-2023-2650){: external}, [CVE-2023-29491](https://nvd.nist.gov/vuln/detail/CVE-2023-29491){: external}, [CVE-2023-30456](https://nvd.nist.gov/vuln/detail/CVE-2023-30456){: external}, [CVE-2023-31436](https://nvd.nist.gov/vuln/detail/CVE-2023-31436){: external}, [CVE-2023-32233](https://nvd.nist.gov/vuln/detail/CVE-2023-32233){: external}. |
| Kubernetes | N/A |N/A|N/A|
{: caption="Changes since version 1.27.2_1526" caption-side="bottom"}


### Change log for master fix pack 1.27.2_1524 and worker node fix pack 1.27.2_1526, released 24 May 2023
{: #1.27.2_1524M_and_1.27.2_1526W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| etcd configuration | N/A | N/A | Improved etcd probe configurations. |
| IBM Cloud Controller Manager | v1.26.4-7 | v1.27.1-8 | Updated to support the Kubernetes `1.27.1` release. Updated `Go` dependencies and to `Go` version `1.20.3`. Base image updated. Increased default number of concurrent node and service sync workers. VPC load balancer updates can now be complete asynchronously. |
| Kubernetes | v1.26.5 | v1.27.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.27.2). |
| Kubernetes add-on resizer | 1.8.16 | 1.8.18 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.18). |
| Kubernetes CSI snapshot controller and CRDs | v6.0.1 | v6.2.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.2.1). |
| Kubernetes DNS autoscaler configuration | N/A | N/A | Increased Kubernetes DNS autoscaler memory resource request to `10Mi`. |
| Kubernetes Metrics Server | v0.6.2 | v0.6.3 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.3). |
| Kubernetes NodeLocal DNS cache configuration | N/A | N/A | Increased Kubernetes NodeLocal DNS cache memory resource request to `20Mi`. |
{: caption="Changes since version 1.26." caption-side="bottom"}


