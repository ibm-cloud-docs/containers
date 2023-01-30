---

copyright:
 years: 2014, 2023
lastupdated: "2023-01-30"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch, 1.19

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Kubernetes version 1.19 change log 
{: #changelog_119}

Version 1.19 is unsupported. You can review the following archive of 1.19 change logs.
{: shortdesc}

## Overview
{: #changelog_overview_119}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.19 change log
{: #119_changelog}


Review the version 1.19 change log.
{: shortdesc}

Kubernetes version 1.19 is deprecated, with a tentative unsupported date of 14 Mar 2022. Update your cluster to at least [version 1.20](/docs/containers?topic=containers-cs_versions_120) as soon as possible.
{: deprecated}

### Change log for worker node fix pack 1.19.16_1579, released 14 March 2022
{: #11916_1579-1}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-169-generic | 4.15.0-171-generic | Kernel and package updates for [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2020-29562](https://nvd.nist.gov/vuln/detail/CVE-2020-29562){: external}, [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2021-35942](https://nvd.nist.gov/vuln/detail/CVE-2021-35942){: external}, [CVE-2021-3999](https://nvd.nist.gov/vuln/detail/CVE-2021-3999){: external}, [CVE-2022-0001](https://nvd.nist.gov/vuln/detail/CVE-2022-0001){: external}, [CVE-2022-23218](https://nvd.nist.gov/vuln/detail/CVE-2022-23218){: external}, [CVE-2022-23219](https://nvd.nist.gov/vuln/detail/CVE-2022-23219){: external}, [CVE-2022-25313](https://nvd.nist.gov/vuln/detail/CVE-2022-25313){: external}, [CVE-2022-25314](https://nvd.nist.gov/vuln/detail/CVE-2022-25314){: external}, [CVE-2022-25315](https://nvd.nist.gov/vuln/detail/CVE-2022-25315){: external}. |
{: caption="Changes since version 1.19.16_1579" caption-side="bottom"}

### Change log for master fix pack 1.19.16_1578, released 3 March 2022
{: #11916_1578}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.21 | v1.2.23 | Updated `golang.org/x/crypto` to `v0.0.0-20220214200702-86341886e292`. Adds fix for  [CVE-2021-43565](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-43565){: external}. Adds Golang dependency updates. |
| Gateway-enabled cluster controller | 1586 | 1653 | Updated to use `Go` version `1.17.7` and updated `Go` modules to fix CVEs. |
| IBM Calico extension | 923 | 929 | Updated universal base image (UBI) to version `8.5-230` to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| IBM Cloud Controller Manager | v1.19.16-6 | v1.19.16-9 | Adds changes to the renovate rules. |
| IBM Cloud {{site.data.keyword.filestorage_short}} plug-in and monitor | 404 | 405 | Fix for [CVE-2021-3538](https://nvd.nist.gov/vuln/detail/CVE-2021-3538){: external}. Adds dependency updates. |
| Key Management Service provider | v2.3.13 | v2.4.3 | Updated `golang.org/x/crypto` to `v0.0.0-20220214200702-86341886e292`. Adds fix for [CVE-2021-43565](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2021-43565){: external}. Adds Golang dependency updates. |
{: caption="Changes since version 1.19.16_1575" caption-side="bottom"}


### Change log for worker node fix pack 1.19.16_1579, released 28 February 2022
{: #11916_1579}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-167-generic | 4.15.0-169-generic | Kernel and package updates for [CVE-2021-4083](https://nvd.nist.gov/vuln/detail/CVE-2021-4083){: external}, [CVE-2021-4155](https://nvd.nist.gov/vuln/detail/CVE-2021-4155){: external}, [CVE-2021-45960](https://nvd.nist.gov/vuln/detail/CVE-2021-45960){: external}, [CVE-2021-46143](https://nvd.nist.gov/vuln/detail/CVE-2021-46143){: external}, [CVE-2022-0330](https://nvd.nist.gov/vuln/detail/CVE-2022-0330){: external}, [CVE-2022-22822](https://nvd.nist.gov/vuln/detail/CVE-2022-22822){: external}, [CVE-2022-22823](https://nvd.nist.gov/vuln/detail/CVE-2022-22823){: external}, [CVE-2022-22824](https://nvd.nist.gov/vuln/detail/CVE-2022-22824){: external}, [CVE-2022-22825](https://nvd.nist.gov/vuln/detail/CVE-2022-22825){: external}, [CVE-2022-22826](https://nvd.nist.gov/vuln/detail/CVE-2022-22826){: external}, [CVE-2022-22827](https://nvd.nist.gov/vuln/detail/CVE-2022-22827){: external}, [CVE-2022-22942](https://nvd.nist.gov/vuln/detail/CVE-2022-22942){: external}, [CVE-2022-23852](https://nvd.nist.gov/vuln/detail/CVE-2022-23852){: external}, [CVE-2022-23990](https://nvd.nist.gov/vuln/detail/CVE-2022-23990){: external}, [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external}, [CVE-2022-25235](https://nvd.nist.gov/vuln/detail/CVE-2022-25235){: external}, [CVE-2022-25236](https://nvd.nist.gov/vuln/detail/CVE-2022-25236){: external}. |
| HA proxy | f6a2b3 | 15198fb | Contains fixes for [CVE-2022-24407](https://nvd.nist.gov/vuln/detail/CVE-2022-24407){: external}. | 
{: caption="Changes since version 1.19.16_1577" caption-side="bottom"}


### Change log for worker node fix pack 1.19.16_1577, released 14 February 2022
{: #11916_1577}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | N/A |
| Kubernetes | N/A | N/A | N/A |
| HA proxy | d38fa1 | f6a2b3 | [CVE-2021-3521](https://nvd.nist.gov/vuln/detail/CVE-2021-3521){: external}   [CVE-2021-4122](https://nvd.nist.gov/vuln/detail/CVE-2021-4122){: external}. |
{: caption="Changes since version 1.19.16_1576" caption-side="bottom"}


### Change log for worker node fix pack 1.19.16_1576, released 31 January 2022
{: #11916_1576}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-7169](https://nvd.nist.gov/vuln/detail/CVE-2018-7169){: external}, [CVE-2021-3984](https://nvd.nist.gov/vuln/detail/CVE-2021-3984){: external}, [CVE-2021-4019](https://nvd.nist.gov/vuln/detail/CVE-2021-4019){: external}, [CVE-2021-4034](https://nvd.nist.gov/vuln/detail/CVE-2021-4034){: external}, [CVE-2021-4069](https://nvd.nist.gov/vuln/detail/CVE-2021-4069){: external}. |
{: caption="Changes since version 1.19.16_1575" caption-side="bottom"}

### Change log for master fix pack 1.19.16_1575, released 26 January 2022
{: #11916_1575}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Changed to improve Calico availability during updates. |
| Cluster health image | v1.2.20 | v1.2.21 | Updated to use `Go` version `1.17.5`, updated Go dependencies and golangci-lint |
| GPU device plug-in and installer | cc634b2 | 9be025c | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 900 | 923 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.16-5 | v1.19.16-6 | Exclude `CVE-2020-14312` from scanning |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 402 | 404 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 3430e03 | 0fc9949 | Updated universal base image (UBI) to the `8.5-218` version to resolve CVEs. Updated to use `Go` version `1.16.13`. |
| Key Management Service provider | v2.3.12 | v2.3.13 | Updated `Go` module dependencies and golangci-lint |
| Kubernetes | N/A | N/A | 	Changed the duration of the Kubernetes API server certificate from 825 days to 730 days. Changed the duration of the cluster CA certificate from 30 years to 10 years. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.16){: external}. |
| Kubernetes Metrics Server | v0.4.4 | v0.4.5 | Metrics server now dynamically reloads `NannyConfiguration` updates. See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1660 | 1748 | Updated the Alpine base image to the `3.15` version to resolve CVEs. Updated to use `Go` version `1.17.6`. |
| OpenVPN client | 2.4.6-r3-IKS-463 | 2.5.4-r0-IKS-556 | Update base image to alpine `3.15` to address CVEs, no longer set the `--compress config` option, updated scripts |
| OpenVPN server | 2.4.6-r3-IKS-462 | 2.5.4-r0-IKS-555 | Update base image to alpine `3.15` to address CVEs, no longer set the `--compress config` option, updated scripts |
{: caption="Changes since version 1.19.16_1573" caption-side="bottom"}


### Change log for worker node fix pack 1.19.16_1574, released 18 January 2022
{: #11916_1574}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-163-generic | 4.15.0-166-generic | Kernel and package updates for [CVE-2018-25020](https://nvd.nist.gov/vuln/detail/CVE-2018-25020){: external} and [CVE-2021-4002](https://nvd.nist.gov/vuln/detail/CVE-2021-4002){: external}. |
{: caption="Changes since version 1.19.16_1573" caption-side="bottom"}

### Change log for worker node fix pack 1.19.16_1573, released 4 January 2022
{: #11916_1573}

The following table shows the changes that are in the worker node fix pack patch update `1.19.16_1573`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| HA proxy | 3b8663 | d38fa1 | Contains fixes for [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image packages for [CVE-2019-19449](https://nvd.nist.gov/vuln/detail/CVE-2019-19449){: external}, [CVE-2020-16592](https://nvd.nist.gov/vuln/detail/CVE-2020-16592){: external}, [CVE-2020-21913](https://nvd.nist.gov/vuln/detail/CVE-2020-21913){: external}, [CVE-2020-27781](https://nvd.nist.gov/vuln/detail/CVE-2020-27781){: external}, [CVE-2020-36322](https://nvd.nist.gov/vuln/detail/CVE-2020-36322){: external}, [CVE-2020-36385](https://nvd.nist.gov/vuln/detail/CVE-2020-36385){: external}, [CVE-2021-25219](https://nvd.nist.gov/vuln/detail/CVE-2021-25219){: external}, [CVE-2021-28831](https://nvd.nist.gov/vuln/detail/CVE-2021-28831){: external}, [CVE-2021-28950](https://nvd.nist.gov/vuln/detail/CVE-2021-28950){: external}, [CVE-2021-3487](https://nvd.nist.gov/vuln/detail/CVE-2021-3487){: external}, [CVE-2021-3524](https://nvd.nist.gov/vuln/detail/CVE-2021-3524){: external}, [CVE-2021-3531](https://nvd.nist.gov/vuln/detail/CVE-2021-3531){: external}, [CVE-2021-3733](https://nvd.nist.gov/vuln/detail/CVE-2021-3733){: external}, [CVE-2021-3737](https://nvd.nist.gov/vuln/detail/CVE-2021-3737){: external}, [CVE-2021-3759](https://nvd.nist.gov/vuln/detail/CVE-2021-3759){: external}, [CVE-2021-3778](https://nvd.nist.gov/vuln/detail/CVE-2021-3778){: external}, [CVE-2021-3796](https://nvd.nist.gov/vuln/detail/CVE-2021-3796){: external}, [CVE-2021-3800](https://nvd.nist.gov/vuln/detail/CVE-2021-3800){: external}, [CVE-2021-38199](https://nvd.nist.gov/vuln/detail/CVE-2021-38199){: external}, [CVE-2021-3903](https://nvd.nist.gov/vuln/detail/CVE-2021-3903){: external}, [CVE-2021-3927](https://nvd.nist.gov/vuln/detail/CVE-2021-3927){: external}, [CVE-2021-3928](https://nvd.nist.gov/vuln/detail/CVE-2021-3928){: external}, [CVE-2021-40490](https://nvd.nist.gov/vuln/detail/CVE-2021-40490){: external}, [CVE-2021-42374](https://nvd.nist.gov/vuln/detail/CVE-2021-42374){: external}, [CVE-2021-42378](https://nvd.nist.gov/vuln/detail/CVE-2021-42378){: external}, [CVE-2021-42384](https://nvd.nist.gov/vuln/detail/CVE-2021-42384){: external}, and [CVE-2021-43527](https://nvd.nist.gov/vuln/detail/CVE-2021-43527){: external}. |
{: caption="Changes since version 1.19.16_1571" caption-side="bottom"}

### Change log for master fix pack 1.19.16_1570, released 7 December 2021
{: #11916_1570}


The following table shows the changes that are in the master fix pack patch update `1.19.16_1570`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.18 | v1.2.20 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Gateway-enabled cluster controller | 1567 | 1586 | Updated Alpine base image to the latest `3.14` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| GPU device plug-in and installer| b87bfa2 | cc634b2 | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 864 | 900 | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 401 | 402 | Updated universal base image (UBI) to the `8.5-204` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4ca5637 | 3430e03 | Updated universal base image (UBI) to the latest `8.5` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Key Management Service provider | v2.3.10 | v2.3.12 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1589 | 1660 | Updated Alpine base image to the latest `3.14` version to resolve CVEs. Updated to use `Go` version `1.16.10`. |
| Operator Lifecycle Manager | 0.16.1-IKS-14 | 0.16.1-IKS-15 | Updated image for [CVE-2021-42374](https://nvd.nist.gov/vuln/detail/CVE-2021-42374){: external}, [CVE-2021-42375](https://nvd.nist.gov/vuln/detail/CVE-2021-42375){: external}, [CVE-2021-42378](https://nvd.nist.gov/vuln/detail/CVE-2021-42378){: external}, [CVE-2021-42379](https://nvd.nist.gov/vuln/detail/CVE-2021-42379){: external}, [CVE-2021-42380](https://nvd.nist.gov/vuln/detail/CVE-2021-42380){: external}, [CVE-2021-42381](https://nvd.nist.gov/vuln/detail/CVE-2021-42381){: external}, [CVE-2021-42382](https://nvd.nist.gov/vuln/detail/CVE-2021-42382){: external}, [CVE-2021-42383](https://nvd.nist.gov/vuln/detail/CVE-2021-42383){: external}, [CVE-2021-42384](https://nvd.nist.gov/vuln/detail/CVE-2021-42384){: external}, [CVE-2021-42385](https://nvd.nist.gov/vuln/detail/CVE-2021-42385){: external}, and [CVE-2021-42386](https://nvd.nist.gov/vuln/detail/CVE-2021-42386){: external}. |
{: caption="Changes since version 1.19.16_1568" caption-side="bottom"}

### Change log for worker node fix pack 1.19.16_1571, released 6 December 2021
{: #11916_1571}

The following table shows the changes that are in the worker node fix pack patch update `1.19.16_1571`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-162 | 4.15.0-163 | Updated worker node images and kernel with package updates. Contains fixes for [CVE-2021-43527](https://nvd.nist.gov/vuln/detail/CVE-2021-43527){: external} | 
| Containerd | v1.4.11 | v1.4.12 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.4.12){: external} and the [security bulletin](https://www.ibm.com/support/pages/node/6524974){: external}. | 
{: caption="Changes since version 1.19.16_1569" caption-side="bottom"}

### Change log for worker node fix pack 1.19.16_1569, released 22 November 2021
{: #11916_1569}

The following table shows the changes that are in the worker node fix pack patch update `1.19.16_1569`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Kubernetes | 1.19.15 | 1.19.16 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.16){: external}. | 
| HA proxy | 07f1e9e | 3b8663 | Contains fixes for [CVE-2021-20231](https://nvd.nist.gov/vuln/detail/CVE-2021-20231){: external}, [CVE-2021-20232](https://nvd.nist.gov/vuln/detail/CVE-2021-20232){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}, [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2019-20838](https://nvd.nist.gov/vuln/detail/CVE-2019-20838){: external}, [CVE-2020-14155](https://nvd.nist.gov/vuln/detail/CVE-2020-14155){: external}, [CVE-2018-20673](https://nvd.nist.gov/vuln/detail/CVE-2018-20673){: external}, [CVE-2021-42574](https://nvd.nist.gov/vuln/detail/CVE-2021-42574){: external}, [CVE-2019-17594](https://nvd.nist.gov/vuln/detail/CVE-2019-17594){: external}, [CVE-2019-17595](https://nvd.nist.gov/vuln/detail/CVE-2019-17595){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-16135](https://nvd.nist.gov/vuln/detail/CVE-2020-16135){: external}, [CVE-2021-3445](https://nvd.nist.gov/vuln/detail/CVE-2021-3445){: external}, [CVE-2021-36084](https://nvd.nist.gov/vuln/detail/CVE-2021-36084){: external}, [CVE-2021-36085](https://nvd.nist.gov/vuln/detail/CVE-2021-36085){: external}, [CVE-2021-36086](https://nvd.nist.gov/vuln/detail/CVE-2021-36086){: external}, [CVE-2021-36087](https://nvd.nist.gov/vuln/detail/CVE-2021-36087){: external}, [CVE-2021-20266](https://nvd.nist.gov/vuln/detail/CVE-2021-20266){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-27645](https://nvd.nist.gov/vuln/detail/CVE-2021-27645){: external}, [CVE-2021-33574](https://nvd.nist.gov/vuln/detail/CVE-2021-33574){: external}, [CVE-2021-35942](https://nvd.nist.gov/vuln/detail/CVE-2021-35942){: external}, [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-19603](https://nvd.nist.gov/vuln/detail/CVE-2019-19603){: external}, [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}, [CVE-2020-13435](https://nvd.nist.gov/vuln/detail/CVE-2020-13435){: external}, [CVE-2020-24370](https://nvd.nist.gov/vuln/detail/CVE-2020-24370){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, [CVE-2021-3800](https://nvd.nist.gov/vuln/detail/CVE-2021-3800){: external}, [CVE-2021-33928](https://nvd.nist.gov/vuln/detail/CVE-2021-33928){: external}, [CVE-2021-33929](https://nvd.nist.gov/vuln/detail/CVE-2021-33929){: external}, [CVE-2021-33930](https://nvd.nist.gov/vuln/detail/CVE-2021-33930){: external}, [CVE-2021-33938](https://nvd.nist.gov/vuln/detail/CVE-2021-33938){: external}, and[CVE-2021-3200](https://nvd.nist.gov/vuln/detail/CVE-2021-3200){: external} |
| Ubuntu 18.04 packages | 4.15.0-161 | 4.15.0-162 | Updated worker node images and kernel with package fixes for[CVE-2019-19449](https://nvd.nist.gov/vuln/detail/CVE-2019-19449){: external}, [CVE-2020-36322](https://nvd.nist.gov/vuln/detail/CVE-2020-36322){: external}, [CVE-2020-36385](https://nvd.nist.gov/vuln/detail/CVE-2020-36385){: external}, [CVE-2021-28950](https://nvd.nist.gov/vuln/detail/CVE-2021-28950){: external}, [CVE-2021-3759](https://nvd.nist.gov/vuln/detail/CVE-2021-3759){: external}, [CVE-2021-38199](https://nvd.nist.gov/vuln/detail/CVE-2021-38199){: external}, [CVE-2021-3903](https://nvd.nist.gov/vuln/detail/CVE-2021-3903){: external}, [CVE-2021-3927](https://nvd.nist.gov/vuln/detail/CVE-2021-3927){: external}, and[CVE-2021-3928](https://nvd.nist.gov/vuln/detail/CVE-2021-3928){: external}. |
{: caption="Changes since version 1.19.15_1567" caption-side="bottom"}

### Change log for master fix pack 1.19.16_1568, released 17 November 2021
{: #11916_1568}

The following table shows the changes that are in the master fix pack patch update `1.19.16_1568`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.16 | v1.2.18 | Updated `Go` module dependencies and to use `Go` version `1.16.9`.  Updated image for [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-33928](https://nvd.nist.gov/vuln/detail/CVE-2021-33928){: external}, [CVE-2021-33929](https://nvd.nist.gov/vuln/detail/CVE-2021-33929){: external} and [CVE-2021-33930](https://nvd.nist.gov/vuln/detail/CVE-2021-33930){: external}.  |
| etcd | v3.4.17 | v3.4.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.18){: external}. |
| Gateway-enabled cluster controller | 1510 | 1567 | Updated to use `Go` version `1.16.9`. |
| GPU device plug-in and installer | eb817b2 | b87bfa2 | Updated image for [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external} and [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.15-3 | v1.19.16-3 | Updated to support the Kubernetes `1.19.16` release. Updated image for [DLA-2797-1](https://www.debian.org/lts/security/2021/dla-2797){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | e3cb629 | 4ca5637 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Key Management Service provider | v2.3.8 | v2.3.10 | Updated `Go` module dependencies and to use `Go` version `1.16.9`.  Updated image for [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}. |
| Kubernetes | v1.19.15 | v1.19.16 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.16){: external}. |
| Kubernetes add-on resizer | 1.8.12 | 1.8.13 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.13){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1550 | 1589 | Updated to use `Go` version `1.16.9`. |
| OpenVPN client | 2.4.6-r3-IKS-386 | 2.4.6-r3-IKS-463 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| OpenVPN server | 2.4.6-r3-IKS-385 | 2.4.6-r3-IKS-462 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
{: caption="Changes since version 1.19.15_1565" caption-side="bottom"}

### Change log for worker node fix pack 1.19.15_1567, released 10 November 2021
{: #11915_1567}

The following table shows the changes that are in the worker node fix pack patch update `1.19.15_1567`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image packages for [CVE-2020-16592](https://nvd.nist.gov/vuln/detail/CVE-2020-16592){: external}, [CVE-2020-27781](https://nvd.nist.gov/vuln/detail/CVE-2020-27781){: external}, [CVE-2021-25219](https://nvd.nist.gov/vuln/detail/CVE-2021-25219){: external}, [CVE-2021-3487](https://nvd.nist.gov/vuln/detail/CVE-2021-3487){: external}, [CVE-2021-3524](https://nvd.nist.gov/vuln/detail/CVE-2021-3524){: external}, [CVE-2021-3531](https://nvd.nist.gov/vuln/detail/CVE-2021-3531){: external}, and [CVE-2021-40490](https://nvd.nist.gov/vuln/detail/CVE-2021-40490){: external}.| 
{: caption="Changes since version 1.19.15_1566" caption-side="bottom"}


### Change log for master fix pack 1.19.15_1565, released 29 October 2021
{: #11915_1565}

The following table shows the changes that are in the master fix pack patch update `1.19.15_1565`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.15 | v1.2.16 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs:  [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, and [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}. |
| etcd | v3.4.16 | v3.4.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.17){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 763 | 864 | Updated to use `Go` version `1.16.9`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.15-1 | v1.19.15-3 | Updated to ignore VPC load balancer (LB) state when a LB delete is requested. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 400 | 401 | Updated universal base image (UBI) to the latest `8.4-210` version to resolve CVEs. |
| Key Management Service provider | v2.3.7 | v2.3.8 | Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs:  [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}, [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, and [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}. |
{: caption="Changes since version 1.19.15_1560" caption-side="bottom"}

### Change log for worker node fix pack 1.19.15_1566, released 25 October 2021
{: #11915_1566}

The following table shows the changes that are in the worker node fix pack patch update `1.19.15_1566`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates. Contains fix for cloud-init performance problem. |
| Worker-pool taint automation | N/A | N/A | Fixes known issue related to worker-pool taint automation that prevents workers from getting providerID. |
{: caption="Changes since version 1.19.15_1562" caption-side="bottom"}

### Change log for worker node fix pack 1.19.15_1562, released 11 October 2021
{: #11915_1562}

The following table shows the changes that are in the worker node fix pack patch update `1.19.15_1562`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Containerd | v1.4.9 | v1.4.11 | See the [security bulletin](https://www.ibm.com/support/pages/node/6501867){: external} and the [change logs](https://github.com/containerd/containerd/releases/tag/v1.4.11){: external}. |
| Ubuntu 18.04 packages | 4.15.0-158 | 4.15.0-159 | Updated worker node images and kernel with package updates [CVE-2021-3778](https://nvd.nist.gov/vuln/detail/CVE-2021-3778){: external} and [CVE-2021-3796](https://nvd.nist.gov/vuln/detail/CVE-2021-3796){: external}. |
{: caption="Changes since version 1.19.15_1561" caption-side="bottom"}

### Change log for worker node fix pack 1.19.15_1561, released 27 September 2021
{: #11915_1561}

The following table shows the changes that are in the worker node fix pack patch update `1.19.15_1561`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Disk identification | N/A | N/A | Enhanced the disk identification logic to handle the case of 2+ partitions. |
| HA proxy | 9c98dc5 | 07f1e9 | Updated image with fixes for [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}, [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, and [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}. |
| Kubernetes | 1.19.14 | 1.19.15 | See the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.15){: external}. This update resolves [CVE-2021-25741](https://nvd.nist.gov/vuln/detail/CVE-2021-25741){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6496649){: external}). |
| Ubuntu 18.04 packages | 4.15.0-156 | 4.15.0-158 | Updated worker node images and kernel with package updates [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external} [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2021-3709](https://nvd.nist.gov/vuln/detail/CVE-2021-3709){: external}, [CVE-2021-3710](https://nvd.nist.gov/vuln/detail/CVE-2021-3710){: external}, [CVE-2021-40330](https://nvd.nist.gov/vuln/detail/CVE-2021-40330){: external}, [CVE-2021-40528](https://nvd.nist.gov/vuln/detail/CVE-2021-40528){: external}, and [CVE-2021-41072](https://nvd.nist.gov/vuln/detail/CVE-2021-41072){: external}. | 
{: caption="Changes since version 1.19.14_1559" caption-side="bottom"}


### Change log for master fix pack 1.19.15_1560, released 28 September 2021
{: #11915_1560}

The following table shows the changes that are in the master fix pack patch update `1.19.15_1560`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Increased liveness and readiness probe timeouts to 10 seconds. |
| Gateway-enabled cluster controller | 1444 | 1510 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| GPU device plug-in and installer | a9461a8 | eb817b2 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.14-1 | v1.19.15-1 | Updated to support the Kubernetes `1.19.15` release. Fixed a bug that may cause node initialization to fail when a new node reuses the name of a deleted node. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 945df65 | e3cb629 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor | 398 | 400 | Updated to use `Go` version `1.16.7`. Updated universal base image (UBI) to the latest `8.4-208` version to resolve CVEs. |
| Kubernetes | v1.19.14 | v1.19.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.15){: external}. |
| Kubernetes API server auditing configuration | N/A | N/A| Updated to support `verbose` [Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| Kubernetes NodeLocal DNS cache | N/A | N/A | Increased memory resource requests from `5Mi` to `8Mi` to better align with normal resource utilization. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1510 | 1550 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-12 | 0.16.1-IKS-14 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
{: caption="Changes since version 1.19.14_1557" caption-side="bottom"}



### Change log for worker node fix pack 1.19.14_1559, released 13 September 2021
{: #11914_1559}

The following table shows the changes that are in the worker node fix pack patch update `1.1914_1559`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-154 | 4.15.0-156 | Updated worker node images and kernel with package updates for [CVE-2021-3653](https://nvd.nist.gov/vuln/detail/CVE-2021-3653){: external}, [CVE-2021-3656](https://nvd.nist.gov/vuln/detail/CVE-2021-3656){: external}, [CVE-2021-38185](https://nvd.nist.gov/vuln/detail/CVE-2021-38185){: external}, [CVE-2021-40153](https://nvd.nist.gov/vuln/detail/CVE-2021-40153){: external}. |
{: caption="Changes since version 1.19.14_1558" caption-side="bottom"}

### Change log for worker node fix pack 1.19.14_1558, released 30 August 2021
{: #11914_1558}

The following table shows the changes that are in the worker node fix pack patch update `1.19.14_1558`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-153 | 4.15.0-154 | Updated worker node images and kernel with package updates for [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external} and [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}. |
{: caption="Changes since version 1.19.13_1556" caption-side="bottom"}

### Change log for master fix pack 1.19.14_1557, released 25 August 2021
{: #11914_1557}

The following table shows the changes that are in the master fix pack patch update `1.19.14_1557`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Updated the rolling update configuration for the `calico-node` daemonset in the `kube-system` namespace.  The configuration is now the same regardless of the number of cluster worker nodes. |
| Cluster health image | v1.2.14 | v1.2.15 | Updated to use `Go` version `1.15.15`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Gateway-enabled cluster controller | 1348 | 1444 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
| GPU device plug-in and installer | 82ee77b | a9461a8 | Updated to use `Go` version `1.16.6`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 747 | 763 | Updated to use `Go` version `1.16.6`. Updated UBI to the latest `8.4-205` version to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.13-1 | v1.19.14-1 | Updated to support the Kubernetes `1.19.14` release and to use `Go` version `1.15.15`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 395 | 398 | Updated to use `Go` version `1.16.6`. Updated image for [CVE-2021-33910](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33910){: external}. |
| Key Management Service provider | v2.3.6 | v2.3.7 | Updated to use `Go` version `1.15.15`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Kubernetes | v1.19.13 | v1.19.14 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.14){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.6 | v1.0.7 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.7){: external}. |
| Kubernetes DNS autoscaler | 1.8.3 | 1.8.4 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1328 | 1510 | Updated image for [CVE-2020-27780](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27780){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-10 | 0.16.1-IKS-12 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
{: caption="Changes since version 1.19.13_1554" caption-side="bottom"}

### Change log for worker node fix pack 1.19.13_1556, released 16 August 2021
{: #11913_1556}

The following table shows the changes that are in the worker node fix pack patch update `1.19.13_1556`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-151 | 4.15.0-153 | N/A |
| HA proxy | 68e6b3 | 9c98dc | Updated image with fixes for [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}. |
{: caption="Changes since version 1.19.13_1555" caption-side="bottom"}

### Change log for worker node fix pack 1.19.13_1555, released 02 August 2021
{: #11913_1555}

The following table shows the changes that are in the worker node fix pack patch update `1.19.13_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-147 | 4.15.0-151 | Updated worker node images & Kernel with package updates: [CVE-2020-13529](https://nvd.nist.gov/vuln/detail/CVE-2020-13529){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2021-33200](https://nvd.nist.gov/vuln/detail/CVE-2021-33200){: external}, [CVE-2021-33909](https://nvd.nist.gov/vuln/detail/CVE-2021-33909){: external}, and [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| Containerd | v1.4.6 | v1.4.8 | See [change logs](https://github.com/containerd/containerd/releases/tag/v1.4.8){: external}. The update resolves CVE-2021-32760 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6478995){: external}). |
| HA proxy | aae810 | 68e6b3 | Updated image with fixes for [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| Registry endpoints | Added zonal public registry endpoints for clusters with both private and public service endpoints enabled. |
| Read only disk self healing | For VPC Gen2 workers. Added automation to recover from disks going read only. |
| Kubernetes | v1.19.12 | v1.19.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.20.9){: external}.  |
{: caption="Changes since version 1.19.12_1553" caption-side="bottom"}

### Change log for master fix pack 1.19.13_1554, released 27 July 2021
{: #11913_1554}

The following table shows the changes that are in the master fix pack patch update `1.19.13_1554`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.13 | v1.2.14 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
| etcd | v3.4.14 | v3.4.16 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.16){: external}. |
| GPU device plug-in and installer | 22e2e0d | 82ee77b | Updated image for [CVE-2021-20271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20271){: external}, [CVE-2021-3516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3516){: external}, [CVE-2021-3517](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3517){: external}, [CVE-2021-3518](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3518){: external}, [CVE-2021-3537](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3537){: external}, [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: external} and [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 730 | 747 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.12-2 | v1.19.13-1 | Updated to support the Kubernetes `1.19.13` release and to use Go version `1.15.14`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 394 | 395 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | b68ea92 | 945df65 | Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Key Management Service provider | v2.3.5 | v2.3.6 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
| Kubernetes | v1.19.12 | v1.19.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.13){: external}. |
{: caption="Changes since version 1.19.12_1551" caption-side="bottom"}

### Change log for worker node fix pack 1.19.12_1553, released 19 July 2021
{: #11912_1553}

The following table shows the changes that are in the worker node fix pack `1.19.12_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with kernel package updates. |
| Ubuntu 18.04 packages | N/A | N/A| Updated worker node images with kernel package updates. | 
{: caption="Changes since version 1.19.12_1552" caption-side="bottom"}

### Change log for worker node fix pack 1.19.12_1552, released 6 July 2021
{: #11912_1552}

The following table shows the changes that are in the worker node fix pack `1.19.12_1552`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 700dc6 | aae810 | Updated image with fixes for [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}, [CVE-2021-20271](https://nvd.nist.gov/vuln/detail/CVE-2021-20271){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external}, [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, and [CVE-2021-3541](https://nvd.nist.gov/vuln/detail/CVE-2021-3541){: external}. |
| Kubernetes | v1.19.11 | v1.19.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.12){: external}. |
| Ubuntu 18.04 packages | 4.15.0.144 | 4.15.0.147 | Updated worker node images with kernel package updates for [CVE-2021-23133](https://nvd.nist.gov/vuln/detail/CVE-2021-23133){: external}, [CVE-2021-3444](https://nvd.nist.gov/vuln/detail/CVE-2021-3444){: external}, and [CVE-2021-3600](https://nvd.nist.gov/vuln/detail/CVE-2021-3600){: external}. |
{: caption="Changes since version 1.19.11_1550" caption-side="bottom"}

### Change log for master fix pack 1.19.12_1551, released 28 June 2021
{: #11912_1551}

The following table shows the changes that are in the master fix pack patch update `1.19.12_1551`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.16.8 | v3.16.10 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| Cluster health image | v1.2.12 | v1.2.13 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Gateway-enabled cluster controller | 1352 | 1348 | Updated to run as a non-root user by default, with privileged escalation as needed. |
| GPU device plug-in and installer | 19bf25c | 22e2e0d | Updated to use `Go` version `1.15.12`. Updated universal base image (UBI) to version `8.4` to resolve CVEs. Updated the GPU drivers to version [460.73.01](https://www.nvidia.com/Download/driverResults.aspx/173142/){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 689 | 730 | Updated to use `Go` version `1.16.15`. Updated minimal UBI to version `8.4` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.11-3 | v1.19.12-2 | Updated to support the Kubernetes `1.19.12` release and to use `Go` version `1.15.13`. Updated `Go` dependencies to resolve CVEs. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 392 | 394 | Updated to use `Go` version `1.15.12`. Updated UBI to version `8.4` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 63cd064 | b68ea92 | Updated to use `Go` version `1.16.4`. Updated UBI to version `8.4` to resolve CVEs. |
| Key Management Service provider | v2.3.4 | v2.3.5 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Kubernetes | v1.19.11 | v1.19.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.12){: external}. |
| Portieris admission controller | v0.10.2 | v0.10.3 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.3){: external}. |
{: caption="Changes since version 1.19.11_1547" caption-side="bottom"}

### Change log for worker node fix pack 1.19.11_1550, released 22 June 2021
{: #11911_1550}

The following table shows the changes that are in the worker node fix pack `1.19.11_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | d3dc33 | Updated image with fixes for [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2017-14502](https://nvd.nist.gov/vuln/detail/CVE-2017-14502){: external}, [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external} and [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}.|
| {{site.data.keyword.registrylong_notm}} | N/A | N/A | Added private-only registry support for `ca.icr.io`, `br.icr.io` and `jp2.icr.io`. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2017-8779](https://nvd.nist.gov/vuln/detail/CVE-2017-8779){: external}, [CVE-2017-8872](https://nvd.nist.gov/vuln/detail/CVE-2017-8872){: external}, [CVE-2018-16869](https://nvd.nist.gov/vuln/detail/CVE-2018-16869){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external} [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}.|
{: caption="Changes since version 1.19.11_1549" caption-side="bottom"}

### Change log for worker node fix pack 1.19.11_1549, released 7 June 2021
{: #11911_1549}

The following table shows the changes that are in the worker node fix pack `1.19.11_1549`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | 700dc6 | Updated the image for [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}.|
| TCP `keepalive` optimization for VPC | N/A | N/A | Set the `net.ipv4.tcp_keepalive_time` setting to 180 seconds for compatibility with VPC gateways. |
| Ubuntu 18.04 packages | 4.15.0-143 | 4.15.0-144 | Updated worker node images with kernel package updates for [CVE-2021-25217](https://nvd.nist.gov/vuln/detail/CVE-2021-25217){: external}, [CVE-2021-31535](https://nvd.nist.gov/vuln/detail/CVE-2021-31535){: external}, [CVE-2021-32547](https://nvd.nist.gov/vuln/detail/CVE-2021-32547){: external}, [CVE-2021-32552](https://nvd.nist.gov/vuln/detail/CVE-2021-32552){: external}, [CVE-2021-32556](https://nvd.nist.gov/vuln/detail/CVE-2021-32556){: external}, [CVE-2021-32557](https://nvd.nist.gov/vuln/detail/CVE-2021-32557){: external}, [CVE-2021-3448](https://nvd.nist.gov/vuln/detail/CVE-2021-3448){: external}, and [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}.|
{: caption="Changes since version 1.19.11_1548" caption-side="bottom"}

### Change log for worker node fix pack 1.19.11_1548, released 24 May 2021
{: #11911_1548}

The following table shows the changes that are in the worker node fix pack `1.19.11_1548`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.4.5 | v1.4.6 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.4.6){: external}. The update resolves CVE-2021-30465 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6456943){: external}). |
| HA proxy | e0fa2f | 26c5cc | Updated image with fixes for [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2019-18276](https://nvd.nist.gov/vuln/detail/CVE-2019-18276){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, and [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external}. |
| Kubernetes | v1.19.10 | v1.19.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.11){: external}. |
| Ubuntu 18.04 packages | 4.15.0-142 | 4.15.0-143 | Updated worker node images with kernel package updates for [CVE-2021-28688](https://nvd.nist.gov/vuln/detail/CVE-2021-28688){: external}, [CVE-2021-20292](https://nvd.nist.gov/vuln/detail/CVE-2021-20292){: external}, [CVE-2021-29264](https://nvd.nist.gov/vuln/detail/CVE-2021-29264){: external}, [CVE-2021-29265](https://nvd.nist.gov/vuln/detail/CVE-2021-29265){: external}, and [CVE-2021-29650](https://nvd.nist.gov/vuln/detail/CVE-2021-29650){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2009-5155](https://nvd.nist.gov/vuln/detail/CVE-2009-5155){: external} and [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}.|
{: caption="Changes since version 1.19.10_1546" caption-side="bottom"}

### Change log for master fix pack 1.19.11_1547, released 24 May 2021
{: #11911_1547}

The following table shows the changes that are in the master fix pack patch update `1.19.11_1547`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.11 | v1.2.12 | Improved the add-on status information that is displayed when errors occur. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}, [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| CoreDNS | 1.8.3 | 1.8.0 | See the [CoreDNS release notes](https://coredns.io/2020/10/22/coredns-1.8.0-release/){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 661 | 689 | Updated to use `Go` version 1.15.12. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.10-2 | v1.19.11-3 | Updated to support the Kubernetes 1.19.11 release and to use `Go` version 1.15.12. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 390 | 392 | Improved the prerequisite validation logic for provisioning persistent volume claims (PVCs). Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | b6a694b | 63cd064 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external}. |
| Key Management Service provider | v2.3.3 | v2.3.4 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}. |
| Kubernetes | v1.19.10 | v1.19.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.11){: external}. The update resolves CVE-2020-8562 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457271){: external}) and CVE-2021-25737 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457273){: external}). |
| Kubernetes add-on resizer | 1.8.11 | 1.8.12 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.12){: external}. |
| Kubernetes Metrics Server | v0.3.7 | v0.4.4 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.4){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-9 | 0.16.1-IKS-10 | Fixed a bug that was caused by a missing `/bin/cpb` binary file. |
| Portieris admission controller | v0.10.1 | v0.10.2 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.2){: external}. |
{: caption="Changes since version 1.19.10_1545" caption-side="bottom"}

### Change log for worker node fix pack 1.19.10_1546, released 10 May 2021
{: #11910_1546}

The following table shows the changes that are in the worker node fix pack `1.19.10_1546`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}.|
{: caption="Changes since version 1.19.10_1544" caption-side="bottom"}

### Change log for master fix pack 1.19.10_1545, released 4 May 2021
{: #11910_1545}

The following table shows the changes that are in the master fix pack patch update `1.19.10_1545`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.IBM_notm}} Calico extension | 618 | 661 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-14391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CCVE-2020-14391){: external}, [CVE-2020-25661](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25661){: external} and [CVE-2020-25662](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25662){: external}. |
| Gateway-enabled cluster controller | 1322 | 1352 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.10-1 | v1.19.10-2 | Updated to support VPC private network load balancers. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1274 | 1328 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
{: caption="Changes since version 1.19.10_1543" caption-side="bottom"}

### Change log for master fix pack 1.19.10_1543, released 27 April 2021
{: #11910_1543}

The following table shows the changes that are in the master fix pack patch update `1.19.10_1543`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.9 | v1.2.11 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| CoreDNS | 1.8.0 | 1.8.3 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| GPU device plug-in and installer | c1c6dd3 | 19bf25c | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.9-1 | v1.19.10-1 | Updated to support the Kubernetes 1.19.10 release and to use `Go` version 1.15.10. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 389 | 390 | Updated to use `Go` version 1.15.9 and for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external} and [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}. |
|{{site.data.keyword.cloud_notm}} RBAC Operator | 3dd6bbc | b6a694b | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| Key Management Service provider | v2.2.5 | v2.3.3 | Updated to use `Go` version 1.15.11. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| Kubernetes | v1.19.9 | v1.19.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.10){: external}. The update resolves CVE-2021-25735 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6447812){: external}). |
| Kubernetes NodeLocal DNS cache | 1.15.14 | 1.17.3 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.17.3){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-5 | 0.16.1-IKS-9 | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-386 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| OpenVPN server | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-385 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
{: caption="Changes since version 1.19.9_1540" caption-side="bottom"}

### Change log for worker node fix pack 1.19.10_1544, released 26 April 2021
{: #11910_1544}

The following table shows the changes that are in the worker node fix pack `1.19.10_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | a3b1ff | e0fa2f | The update addresses [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Added resiliency to `systemd` units to prevent failures situations where the worker nodes are overused. Updated worker node images with kernel and package updates for [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}, and [CVE-2021-3348](https://nvd.nist.gov/vuln/detail/CVE-2021-3348){: external}. |
| Ubuntu 16.04 packages |4.4.0-206 | 4.4.0-210 | Updated worker node images with kernel and package updates for [[CVE-2015-1350](https://nvd.nist.gov/vuln/detail/CVE-2015-1350){: external}, [CVE-2017-15107](https://nvd.nist.gov/vuln/detail/CVE-2017-15107){: external}, [CVE-2017-5967](https://nvd.nist.gov/vuln/detail/CVE-2017-5967){: external}, [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2018-5953](https://nvd.nist.gov/vuln/detail/CVE-2018-5953){: external}, [CVE-2019-14513](https://nvd.nist.gov/vuln/detail/CVE-2019-14513){: external}, [CVE-2019-16231](https://nvd.nist.gov/vuln/detail/CVE-2019-16231){: external}, [CVE-2019-16232](https://nvd.nist.gov/vuln/detail/CVE-2019-16232){: external}, [CVE-2019-19061](https://nvd.nist.gov/vuln/detail/CVE-2019-19061){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, and [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}.|
{: caption="Changes since version 1.19.9_1542" caption-side="bottom"}

### Change log for worker node fix pack 1.19.9_1542, released 12 April 2021
{: #1199_1542}

The following table shows the changes that are in the worker node fix pack `1.19.9_1542`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 9b2dca | a3b1ff | The update addresses [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external} and [CVE-2021-3450](https://nvd.nist.gov/vuln/detail/CVE-2021-3450){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}.|
{: caption="Changes since version 1.19.9_1541" caption-side="bottom"}

### Change log for master fix pack 1.19.9_1540, released 30 March 2021
{: #1199_1540}

The following table shows the changes that are in the master fix pack patch update `1.19.9_1540`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.at_short}} event | N/A | N/A | Now, the `containers-kubernetes.version.update` event is sent to {{site.data.keyword.at_short}} when a master fix pack update is initiated for a cluster. |
| Cluster health image | v1.2.8 | v1.2.9 | Updated image for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}. |
| Gateway-enabled cluster controller | 1232 | 1322 | Updated to use `Go` version 1.15.10 and for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
| GPU device plug-in and installer | af5a6cb | c1c6dd3 | Updated image for [CVE-2021-27919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27919){: external}, [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}, and [CVE-2020-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28852){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.8-4 | v1.19.9-1 | Updated to support the Kubernetes 1.19.9 release. Fixed a bug that prevented VPC load balancers from supporting more than 50 subnets in an account. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 388 | 389 | Updated to use `Go` version 1.15.8. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 86de2b7 | 3dd6bbc | Updated image for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}. |
| Kubernetes | v1.19.8 | v1.19.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.9){: external}. |
{: caption="Changes since version 1.19.8_1538" caption-side="bottom"}

### Change log for worker node fix pack 1.19.9_1541, released 29 March 2021
{: #1199_1541}

The following table shows the changes that are in the worker node fix pack `1.19.9_1541`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-136-generic | 4.15.0-140-generic | Updated worker node images with kernel and package updates for [CVE-2020-27170](https://nvd.nist.gov/vuln/detail/CVE-2020-27170){: external}, [CVE-2020-27171](https://nvd.nist.gov/vuln/detail/CVE-2020-27171){: external}, [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, and [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external}. |
| Ubuntu 16.04 packages | 4.4.0-203-generic | 4.4.0-206-generic | Updated worker node images with kernel and package updates for [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, and [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}.|
{: caption="Changes since version 1.19.8_1539" caption-side="bottom"}

### Change log for worker node fix pack 1.19.8_1539, released 12 March 2021
{: #1198_1539}

The following table shows the changes that are in the worker node fix pack `1.19.8_1539`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.4.3 | v1.4.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.4.4){: external}. The update resolves CVE-2021-21334 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6433475){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-24031](https://nvd.nist.gov/vuln/detail/CVE-2021-24031){: external}, [CVE-2021-24032](https://nvd.nist.gov/vuln/detail/CVE-2021-24032){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, and [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for{: external}, [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: caption="Changes since version 1.19.8_1538" caption-side="bottom"}

### Change log for worker node fix pack 1.19.8_1538, released 1 March 2021
{: #1198_1538}

The following table shows the changes that are in the worker node fix pack `1.19.8_1538`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.19.7 | v1.19.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.8){: external}. |
| Ubuntu 18.04 packages | 4.15.0-135-generic | 4.15.0-136-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
| Ubuntu 16.04 packages | 4.4.0-201-generic | 4.4.0-203-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: caption="Changes since version 1.19.7_1535" caption-side="bottom"}

### Change log for master fix pack 1.19.8_1538, released 27 February 2021
{: #1198_1538_master}

The following table shows the changes that are in the master fix pack patch update `1.19.8_1538`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.16.7 | v3.16.8 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.8-2 | v1.19.8-4 | Updated to use `calicoctl` version 3.16.8. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1165 | 1274 | Fixed a bug that might cause version 2.0 network load balancers (NLBs) to crash and restart on load balancer updates. |
{: caption="Changes since version 1.19.8_1537" caption-side="bottom"}

### Change log for master fix pack 1.19.8_1537, released 22 February 2021
{: #1198_1537}

The following table shows the changes that are in the master fix pack patch update `1.19.8_1537`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.16.5 | v3.16.7 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| Cluster health image | v1.2.6 | v1.2.8 | Updated to use `Go` version 1.15.7. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Gateway-enabled cluster controller | 1195 | 1232 | Updated to use `Go` version 1.15.7. |
| {{site.data.keyword.IBM_notm}} Calico extension | 567 | 618 | Updated to use `Go` version 1.15.7. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.7-4 | v1.19.8-2 | Updated to support the Kubernetes 1.19.8 release, to use `Go` version 1.15.8, and to use `calicoctl` version 3.16.7. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [DLA-2509-1](https://www.debian.org/lts/security/2020/dla-2509){: external}. Updated version 1.0 and 2.0 network load balancers (NLBs) to run as a non-root user by default, with privileged escalation as needed. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 385 | 388 | Improved the retry logic for provisioning persistent volume claims (PVCs). |
| {{site.data.keyword.cloud_notm}} RBAC Operator | f859228 | 86de2b7 | Updated to use `Go` version 1.15.7. |
| Key Management Service provider | v2.2.3 | v2.2.5 | Updated to use `Go` version 1.15.7. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Kubernetes | v1.19.7 | v1.19.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.8){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1078 | 1165 | Updated to run as a non-root user by default, with privileged escalation as needed. Updated to use `Go` version 1.15.7. |
| Operator Lifecycle Manager | 0.16.1-IKS-3 | 0.16.1-IKS-5 | Updated image for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
{: caption="Changes since version 1.19.7_1532" caption-side="bottom"}

### Change log for worker node fix pack 1.19.7_1535, released 15 February 2021
{: #1197_1535}

The following table shows the changes that are in the worker node fix pack `1.19.7_1535`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
{: caption="Changes since version 1.19.7_1534" caption-side="bottom"}

### Change log for worker node fix pack 1.19.7_1534, released 3 February 2021
{: #1197_1534}

The following table shows the changes that are in the worker node fix pack `1.19.7_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Metadata updates | N/A | N/A | Updated the worker node version fix pack metadata for internal documentation purposes. |
{: caption="Changes since version 1.19.7_1533" caption-side="bottom"}

### Change log for worker node fix pack 1.19.7_1533, released 1 February 2021
{: #1197_1533}

The following table shows the changes that are in the worker node fix pack `1.19.7_1533`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | 4.4.0-200-generic | 4.4.0-201-generic | Updated worker node image with kernel and package updates for [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
| Ubuntu 18.04 packages | 4.15.0-132-generic | 4.15.0-135-generic | Updated worker node image with kernel and package updates for [CVE-2019-12761](https://nvd.nist.gov/vuln/detail/CVE-2019-12761){: external}, [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
{: caption="Changes since version 1.19.7_1532" caption-side="bottom"}

### Change log for master fix pack 1.19.7_1532, released 19 January 2021
{: #1197_1532_master}

The following table shows the changes that are in the master fix pack patch update `1.19.7_1532`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.4 | v1.2.6 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Gateway-enabled cluster controller | 1184 | 1195 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| GPU device plug-in and installer | c26e2ae | af5a6cb | Updated image for [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}, [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}, [CVE-2020-27350](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350){: external}, [CVE-2020-29361](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29361){: external}, [CVE-2020-29362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29362){: external}, [CVE-2020-29363](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29363){: external}, [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8284](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8284){: external}, [CVE-2020-8285](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8285){: external}, and [CVE-2020-8286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8286){: external}. |
| {{site.data.keyword.IBM_notm}} Calico extension | 556 | 567 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.6-1 | v1.19.7-4 | Updated to support the Kubernetes 1.19.7 release and to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 384 | 385 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Key Management Service provider | v2.2.2 | v2.2.3 | Fixed bug to ignore conflict errors during KMS secret reencryption. Updated to use `Go` version 1.15.5. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls and for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Kubernetes | v1.19.6 | v1.19.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.7){: external}. Updated to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Kubernetes Dashboard | v2.0.4 | v2.0.5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.5){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.4 | v1.0.6 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1004 | 1078 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Operator Lifecycle Manager Catalog | v1.14.0 | v1.15.3 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.15.3){: external}. |
| Operator Lifecycle Manager | 0.16.1 | 0.16.1-IKS-3 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
{: caption="Changes since version 1.19.6_1531" caption-side="bottom"}

### Change log for worker node fix pack 1.19.7_1532, released 18 January 2021
{: #1197_1532}

The following table shows the changes that are in the worker node fix pack `1.19.7_1532`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.19.5 | v1.19.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.7){: external}. |
| Ubuntu 16.04 packages | 4.4.0-197-generic | 4.4.0-200-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external} external}, and [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external} external}. |
| Ubuntu 18.04 packages | 4.15.0-128-generic | 4.15.0-132-generic | Updated worker node image with kernel and package updates for{: external}, [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2021-1052](https://nvd.nist.gov/vuln/detail/CVE-2021-1052){: external}, [CVE-2021-1053](https://nvd.nist.gov/vuln/detail/CVE-2021-1053){: external}, and [CVE-2019-19770](https://nvd.nist.gov/vuln/detail/CVE-2019-19770){: external}. |
{: caption="Changes since version 1.19.5_1530" caption-side="bottom"}

### Change log for master fix pack 1.19.6_1531, released 6 January 2021
{: #1196_1531}

The following table shows the changes that are in the master fix pack patch update `1.19.6_1531`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.IBM_notm}} Calico extension | 538 | 556 | Updated image to include the `ip` command. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.5-1 | v1.19.6-1 | Updated to support the Kubernetes 1.19.6 release and to use `Go` version 1.15.5. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | N/A | N/A | Updated to run with a privileged security context. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | c148a8a | f859228 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Kubernetes | v1.19.5 | v1.19.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.6){: external}. |
| Kubernetes `NodeLocal` DNS cache | N/A | N/A | Updated to run with a least privileged security context. |
{: caption="Changes since version 1.19.5_1529" caption-side="bottom"}

### Change log for worker node fix pack 1.19.5_1530, released 21 December 2020
{: #1195_1530}

The following table shows the changes that are in the worker node fix pack `1.19.5_1530`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ubuntu 18.04 packages | 4.15.0-126-generic | 4.15.0-128-generic | Updated worker node image with kernel and package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Kubernetes | v1.19.4 | v1.19.5 | See the [Kubernetes change logs.](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.5){: external} |
| Ephemeral storage reservations | N/A | N/A | Reserve local ephemeral storage to prevent workload evictions. |
| HA proxy | db4e6d | 9b2dca | Image update for [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external} and [CVE-2020-24659](https://nvd.nist.gov/vuln/detail/CVE-2020-24659){: external}. |
{: caption="Changes since version 1.19.5_1529" caption-side="bottom"}

### Change log for master fix pack 1.19.5_1529, released 14 December 2020
{: #1195_1529}

The following table shows the changes that are in the master fix pack patch update `1.19.5_1529`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.3 | v1.2.4 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| etcd | v3.4.13 | v3.4.14 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.14){: external}. |
| Gateway-enabled cluster controller | 1105 | 1184 | Updated to use `Go` version 1.15.5. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| GPU device plug-in and installer | b966c41 | c26e2ae | Updated the GPU drivers to version [450.80.02](https://www.nvidia.com/download/driverResults.aspx/165294){: external}. Updated image for [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}, [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}, and [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.IBM_notm}} Calico extension | 378 | 538 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.5. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.cloud_notm}} Controller Manager |  v1.19.4-1 | v1.19.5-1 | Updated to support the Kubernetes 1.19.5 release. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. Fixed a bug in VPC load balancer creation when the cluster, VPC, or subnet are in a different resource group.  |
| {{site.data.keyword.filestorage_full_notm}} monitor | 379 | 384 | Updated to use `Go` version 1.15.5 and to run as a non-root user. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 379 | 384 | Updated to use `Go` version 1.15.5 and to run with a least privileged security context. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 197bc70 | c148a8a | Updated to use `Go` version 1.15.6 and updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Key management service (KMS) provider | v2.2.1 | v2.2.2 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Kubernetes | v1.19.4 | v1.19.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.5){: external}. |
| Kubernetes `NodeLocal` DNS cache | N/A | N/A | Updated the `NodeLocal` DNS cache configuration to support [customizing the `node-local-dns` config map](/docs/containers?topic=containers-cluster_dns#dns_nodelocal_customize). |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 208 | 1004 | Updated Alpine base image to version 3.12 and to use `Go` version 1.15.5. Updated image for [CVE-2020-8037](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8037){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| Operator Lifecycle Manager | N/A | N/A | Updated to run as a non-root user. |
| OpenVPN client | 2.4.6-r3-IKS-116 | 2.4.6-r3-IKS-301 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
| OpenVPN server | 2.4.6-r3-IKS-222 | 2.4.6-r3-IKS-301 | Updated image to implement additional {{site.data.keyword.IBM_notm}} security controls. |
{: caption="Changes since version 1.19.4_1527" caption-side="bottom"}

### Change log for worker node fix pack 1.19.4_1529, released 11 December 2020
{: #1194_1529}

The following table shows the changes that are in the worker node fix pack `1.19.4_1529`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 bare metal kernel | 4.15.0-126-generic | 4.15.0-123-generic | **Bare metal worker nodes**: Reverted the kernel version for bare metal worker nodes while Canonical addresses issues with the previous version that prevented worker nodes from being reloaded or updated. |
{: caption="Changes since version 1.19.4_1528" caption-side="bottom"}

### Change log for worker node fix pack 1.19.4_1528, released 7 December 2020
{: #1194_1528}

The following table shows the changes that are in the worker node fix pack `1.19.4_1528`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.4.1 | v1.4.3 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.4.3){: external}. The update resolves CVE-2020–15257 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6387878){: external}). |
| HA proxy | 1.8.26-384f42 | db4e6d | Added provenance labels for source tracking. |
| Ubuntu 18.04 packages | 4.15.0-123-generic | 4.15.0-126-generic | Updated worker node image with kernel and package updates for [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external} and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
| Ubuntu 16.04 packages | 4.4.0-194-generic | 4.4.0-197-generic | Updated worker node image with kernel and package updates for [CVE-2020-0427](https://nvd.nist.gov/vuln/detail/CVE-2020-0427){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external}, [CVE-2020-25645](https://nvd.nist.gov/vuln/detail/CVE-2020-25645){: external}, and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
{: caption="Changes since version 1.19.4_1527" caption-side="bottom"}

### Change log for worker node fix pack 1.19.4_1527, released 23 November 2020
{: #1194_1527_worker}

The following table shows the changes that are in the worker node fix pack `1.19.4_1527`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.19.3 | v1.19.4 | See the [Kubernetes changelog](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md#v1194){: external}.|
| Ubuntu 18.04 packages | 4.15.0-122-generic | 4.15.0-123-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
| Ubuntu 16.04 packages | 4.4.0-193-generic | 4.4.0-194-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
{: caption="Changes since version 1.19.3_1526" caption-side="bottom"}

### Change log for master fix pack 1.19.4_1527, released 16 November 2020
{: #1194_1527}

The following table shows the changes that are in the master fix pack patch update `1.19.4_1527`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.16.4 | v3.16.5 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| Cluster health image | v1.2.2 | v1.2.3 | Status codes have been added to add-on health messages. Set add-on health state to `critical` and status to `unknown` when cluster health is `critical`. When a cluster has a Kubernetes key management service (KMS) provider enabled and a disabled [Key Protect](/docs/containers?topic=containers-encryption#keyprotect) key, cluster health state is now set to `critical`. Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| CoreDNS | 1.7.1 | 1.8.0 | See the [CoreDNS release notes](https://coredns.io/2020/10/22/coredns-1.8.0-release/){: external}. |
| GPU device plug-in and installer | 0c07674 | b966c41 | Updated image for [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2020-8177](https://nvd.nist.gov/vuln/detail/CVE-2020-8177){: external}, [CVE-2019-14889](https://nvd.nist.gov/vuln/detail/CVE-2019-14889){: external}, [CVE-2020-1730](https://nvd.nist.gov/vuln/detail/CVE-2020-1730){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}, [CVE-2019-5018](https://nvd.nist.gov/vuln/detail/CVE-2019-5018){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, [CVE-2020-13631](https://nvd.nist.gov/vuln/detail/CVE-2020-13631){: external}, [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}, [CVE-2020-6405](https://nvd.nist.gov/vuln/detail/CVE-2020-6405){: external}, [CVE-2020-9327](https://nvd.nist.gov/vuln/detail/CVE-2020-9327){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-19221](https://nvd.nist.gov/vuln/detail/CVE-2019-19221){: external}, [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}, [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-20454](https://nvd.nist.gov/vuln/detail/CVE-2019-20454){: external}, [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2018-20843](https://nvd.nist.gov/vuln/detail/CVE-2018-20843){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, and [CVE-2019-20387](https://nvd.nist.gov/vuln/detail/CVE-2019-20387){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.3-3 | v1.19.4-1 | Updated to support the Kubernetes 1.19.4 release. Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 31c794a | 197bc70 | Updated image for [CVE-2019-20454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20454){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}, [CVE-2019-20807](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20807){: external}, [CVE-2019-16935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16935){: external}, [CVE-2019-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20907){: external}, [CVE-2020-14422](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14422){: external}, [CVE-2020-8492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8492){: external}, [CVE-2019-15165](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15165){: external}, [CVE-2019-16168](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16168){: external}, [CVE-2019-20218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20218){: external}, [CVE-2019-5018](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5018){: external}, [CVE-2020-13630](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13630){: external}, [CVE-2020-13631](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13631){: external}, [CVE-2020-13632](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13632){: external}, [CVE-2020-6405](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6405){: external}, [CVE-2020-9327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9327){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-13050](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13050){: external}, [CVE-2018-20843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20843){: external}, [CVE-2019-15903](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15903){: external}, [CVE-2019-14889](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14889){: external}, [CVE-2020-1730](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1730){: external}, [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}, [CVE-2020-14382](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14382){: external}, [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external}, [CVE-2019-19956](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19956){: external}, [CVE-2019-20388](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20388){: external}, [CVE-2020-7595](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7595){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-19906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19906){: external}, [CVE-2019-20387](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20387){: external}, and [CVE-2019-19221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19221){: external}.  |
| Key Management Service provider | v2.1.0 | v2.2.1 | Updated to support service to service authentication and to use `Go` version 1.15.2.  Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| Kubernetes | v1.19.3 | v1.19.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.4){: external}. |
{: caption="Changes since version 1.19.3_1525" caption-side="bottom"}

### Change log for worker node fix pack 1.19.3_1526, released 9 November 2020
{: #1193_1526}

The following table shows the changes that are in the worker node fix pack `1.19.3_1526`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with kernel and package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}, and [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}. |
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, and [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}.|
{: caption="Changes since version 1.19.3_1525" caption-side="bottom"}

### Change log for worker node fix pack 1.19.3_1525, released 26 October 2020
{: #1193_1525_worker}

The following table shows the changes that are in the worker node fix pack `1.19.3_1525`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.19.2 | v1.19.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.3){: external}. |
|Ubuntu 18.04 packages | 4.15.0-118-generic | 4.15.0-122-generic | Updated worker node images with kernel and package updates for [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external},[CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2019-20916](https://nvd.nist.gov/vuln/detail/CVE-2019-20916){: external}, [CVE-2020-12351](https://nvd.nist.gov/vuln/detail/CVE-2020-12351){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, [CVE-2020-16120](https://nvd.nist.gov/vuln/detail/CVE-2020-16120){: external}, [CVE-2020-24490](https://nvd.nist.gov/vuln/detail/CVE-2020-24490){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
|Ubuntu 16.04 packages | 4.4.0-190-generic | 4.4.0-193-generic | Updated worker node images with kernel and package updates for [CVE-2017-17087](https://nvd.nist.gov/vuln/detail/CVE-2017-17087){: external}, [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external}, [CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
{: caption="Changes since version 1.19.2_1524" caption-side="bottom"}

### Change log for master fix pack 1.19.3_1525, released 26 October 2020
{: #1193_1525}

The following table shows the changes that are in the master fix pack patch update `1.19.3_1525`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.16.2 | v3.16.4 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. |
| Calico configuration | N/A | N/A | Updated the `calico-node` daemon set in the `kube-system` namespace to set the `spec.updateStrategy.rollingUpdate.maxUnavailable` parameter to `10%` for clusters with more than 50 worker nodes. |
| Cluster health image | v1.2.1 | v1.2.2 | Fixed the cluster health status for when add-on customizations are used. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.19.2-9 | v1.19.3-3 | Updated to support the Kubernetes 1.19.3 release and to use `Go` version 1.15.2. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 378 | 379 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.2. |
| Kubernetes | v1.19.2 | v1.19.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.3){: external}. |
{: caption="Changes since version 1.19.2_1524" caption-side="bottom"}

### Change log for 1.19.2_1524, released 13 October 2020
{: #1192_1524}

The following table shows the changes that are in the `1.19.2_1524` version update.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.13.4 | v3.16.2 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. In addition, the Calico configuration was updated to use the [Kubernetes API data store driver](https://projectcalico.docs.tigera.io/getting-started/kubernetes/hardway/the-calico-datastore){: external}. |
| Cluster health image | v1.1.11 | v1.2.1 | When a cluster has a Kubernetes key management service (KMS) provider enabled and a disabled [{{site.data.keyword.keymanagementserviceshort}}](/docs/containers?topic=containers-encryption#keyprotect) key, a warning is now returned in the cluster health state. In addition, updated to use `Go` version 1.15.2. |
| containerd | 1.3.4 | 1.4.1 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.4.1){: external}. |
| CoreDNS | 1.6.9 | 1.7.1 | See the [CoreDNS release notes](https://coredns.io/2020/09/21/coredns-1.7.1-release/){: external}. In addition, the CoreDNS configuration was updated to increase the weight of scheduling CoreDNS pods to different worker nodes and zones. |
| Gateway-enabled cluster controller | 1082 | 1105 | Updated to use `Go` version 1.15.2. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.9-1 | v1.19.2-9 | Updated to support the Kubernetes 1.19.2 release and to use `Go` version 1.15 and `calicoctl` version 3.16.2. Classic network load balancers (NLBs) now set `NET_RAW` security context. In addition, support was added for VPC network load balancers. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4b47693 | 31c794a | Updated to use `Go` version 1.15.2. |
| Key Management Service provider | v2.0.4 | v2.1.0 | Updated to use the key management service (KMS) provider secret to identify when a [{{site.data.keyword.keymanagementserviceshort}}](/docs/containers?topic=containers-encryption#keyprotect) key is enabled and disabled so that encryption and decryption requests are updated accordingly. |
| Kubernetes | v1.18.9 | v1.19.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.2){: external}. |
| Kubernetes configuration | N/A | N/A | Disabled the Kubernetes `SCTPSupport` and `ServiceAppProtocol` feature gates. |
| Kubernetes DNS autoscaler | 1.7.1 | 1.8.3 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.3){: external}. In addition, the Kubernetes DNS autoscaler configuration was updated to include unschedulable worker nodes in scaling calculations. |
| Kubernetes NodeLocal DNS cache | 1.15.13 | 1.15.14 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.14){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 223 | 234 | Updated to use `Go` version 1.15.2. |
| Operator Lifecycle Manager Catalog | v1.6.1 | v1.14.0 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.14.0){: external}. |
| Operator Lifecycle Manager | 0.14.1-IKS-1 | 0.16.1 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.16.1){: external}. |
{: caption="Changes since version 1.18.9_1528" caption-side="bottom"}

