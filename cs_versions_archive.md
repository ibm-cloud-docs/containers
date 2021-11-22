---

copyright:
 years: 2014, 2021
lastupdated: "2021-11-22"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Archived Kubernetes version changelogs
{: #changelog_archive}

The following Kubernetes versions are no longer supported for {{site.data.keyword.containerlong}}. You can review the archive of the changelogs.
{: shortdesc}

Unsupported Kubernetes versions: 1.5, 1.7, 1.8, 1.9, 1.10, 1.11, 1.12, 1.13, 1.14, 1.15, 1.16, 1.17, 1.18

Looking for the changelogs of supported versions? See [Kubernetes version changelog](/docs/containers?topic=containers-changelog).
{: tip}

## Version 1.18 changelog (Unsupported as of 10 October 2021)
{: #118_changelog}

Version 1.18 is unsupported. You can review the following archive of 1.18 changelogs.
{: shortdesc}


### Changelog for worker node fix pack 1.18.20_1566, released 27 September 2021
{: #11820_1566}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1566`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Disk identification | NA | NA | Enhanced the disk identification logic to handle the case of 2+ partitions. |
| Haproxy | 9c98dc5 | 07f1e9 | Updated image with fixes for [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}, [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, and [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}. |
| Ubuntu 18.04 packages | 4.15.0-156 | 4.15.0-158 | Updated worker node images and kernel with package updates [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2021-3709](https://nvd.nist.gov/vuln/detail/CVE-2021-3709){: external}, [CVE-2021-3710](https://nvd.nist.gov/vuln/detail/CVE-2021-3710){: external}, [CVE-2021-40330](https://nvd.nist.gov/vuln/detail/CVE-2021-40330){: external}, [CVE-2021-40528](https://nvd.nist.gov/vuln/detail/CVE-2021-40528){: external}, and [CVE-2021-41072](https://nvd.nist.gov/vuln/detail/CVE-2021-41072){: external}. | 
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1564" caption-side="top"}

### Changelog for master fix pack 1.18.20_1565, released 28 September 2021
{: #11820_1565}

The following table shows the changes that are in the master fix pack patch update `1.18.20_1565`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Gateway-enabled cluster controller | 1444 | 1510 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| GPU device plug-in and installer | a9461a8 | eb817b2 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 945df65 | e3cb629 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor | 398 | 400 | Updated to use `Go` version `1.16.7`. Updated universal base image (UBI) to the latest `8.4-208` version to resolve CVEs. |<ff-122>
| Kubernetes API server auditing configuration | N/A | N/A| Updated to support `verbose` [Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |</ff-122>
| Kubernetes NodeLocal DNS cache | N/A | N/A | Increased memory resource requests from `5Mi` to `8Mi` to better align with normal resource utilization. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1510 | 1550 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711) and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| Operator Lifecycle Manager | 0.14.1-IKS-11 | 0.14.1-IKS-13 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1562" caption-side="top"}

### Changelog for worker node fix pack 1.18.20_1564, released 13 September 2021
{: #11820_1564}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1564`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-154 | 4.15.0-156 | Updated worker node images and kernel with package updates for [CVE-2021-3653](https://nvd.nist.gov/vuln/detail/CVE-2021-3653){: external}, [CVE-2021-3656](https://nvd.nist.gov/vuln/detail/CVE-2021-3656){: external}, [CVE-2021-38185](https://nvd.nist.gov/vuln/detail/CVE-2021-38185){: external}, [CVE-2021-40153](https://nvd.nist.gov/vuln/detail/CVE-2021-40153){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1563" caption-side="top"}

### Changelog for worker node fix pack 1.18.20_1563, released 30 August 2021
{: #11820_1563}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1563`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-153 | 4.15.0-154 | Updated worker node images and kernel with package updates for [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711) and [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712). |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1561" caption-side="top"}

### Changelog for master fix pack 1.18.20_1562, released 25 August 2021
{: #11820_1562}

The following table shows the changes that are in the master fix pack patch update `1.18.20_1562`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.14 | v1.2.15 | Updated to use `Go` version `1.15.15`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Gateway-enabled cluster controller | 1348 | 1444 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){:external}. |
| GPU device plug-in and installer | 82ee77b | a9461a8 | Updated to use `Go` version `1.16.6`. |
| IBM Calico extension | 747 | 763 | Updated to use `Go` version `1.16.6`. Updated universal base image (UBI) to the latest `8.4-205` version to resolve CVEs. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 395 | 398 | Updated to use `Go` version `1.16.6`. Updated image for [CVE-2021-33910](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33910){:external}. |
| Key Management Service provider | v2.3.6 | v2.3.7 | Updated to use `Go` version `1.15.15`. Updated UBI to the latest `8.4` version to resolve CVEs. |
| Kubernetes Dashboard metrics scraper | v1.0.6 | v1.0.7 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.7){:external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1328 | 1510 | Updated image for [CVE-2020-27780](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27780){:external}. |
| Operator Lifecycle Manager | 0.14.1-IKS-8 | 0.14.1-IKS-11 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){:external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1559" caption-side="top"}

### Changelog for worker node fix pack 1.18.20_1561, released 16 August 2021
{: #11820_1561}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1561`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-151 | 4.15.0-153 | N/A |
| HA proxy | 68e6b3 | 9c98dc | Updated image with fixes for [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1560" caption-side="top"}


### Changelog for worker node fix pack 1.18.20_1560, released 02 August 2021
{: #11820_1560}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1560`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-147 | 4.15.0-151 | Updated worker node images & Kernel with package updates: [CVE-2020-13529](https://nvd.nist.gov/vuln/detail/CVE-2020-13529){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2021-33200](https://nvd.nist.gov/vuln/detail/CVE-2021-33200){: external}, [CVE-2021-33909](https://nvd.nist.gov/vuln/detail/CVE-2021-33909){: external}, and [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| HA proxy | aae810 | 68e6b3 | Updated image with fixes for [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| Registry endpoints | Added zonal public registry endpoints for clusters with both private and public service endpoints enabled. |
| Read only disk self healing | For VPC Gen2 workers. Added automation to recover from disks going read only. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.29_1558" caption-side="top"}

### Changelog for master fix pack 1.18.20_1559, released 27 July 2021
{: #11820_1559}

The following table shows the changes that are in the master fix pack patch update `1.18.20_1559`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.23 | v1.1.24 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
| etcd | v3.4.14 | v3.4.16 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.16){: external}. |
| GPU device plug-in and installer | 22e2e0d | 82ee77b | Updated image for [CVE-2021-20271](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20271){: external}, [CVE-2021-3516](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3516){: external}, [CVE-2021-3517](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3517){: external}, [CVE-2021-3518](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3518){: external}, [CVE-2021-3537](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3537){: external}, [CVE-2021-3541](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3541){: external} and [CVE-2021-3520](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3520){: external}. |
| IBM Calico extension | 730 | 747 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 394 | 395 | Updated universal base image (UBI) to version `8.4-205` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | b68ea92 | 945df65 | Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Key Management Service provider | v2.3.5 | v2.3.6 | Updated universal base image (UBI) to the latest version to resolve CVEs. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1556" caption-side="top"}

### Changelog for worker node fix pack 1.18.29_1558, released 19 July 2021
{: #11829_1558}

The following table shows the changes that are in the worker node fix pack `1.18.29_1558`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with kernel package updates. |
| Ubuntu 18.04 packages | N/A | N/A| Updated worker node images with kernel package updates. | 
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.20_1557" caption-side="top"}

### Changelog for worker node fix pack 1.18.20_1557, released 6 July 2021
{: #11820_1557}

The following table shows the changes that are in the worker node fix pack `1.18.20_1557`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 700dc6 | aae810 | Updated image with fixes for [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}, [CVE-2021-20271](https://nvd.nist.gov/vuln/detail/CVE-2021-20271){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external}, [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, and [CVE-2021-3541](https://nvd.nist.gov/vuln/detail/CVE-2021-3541){: external}. |
| Kubernetes | v1.18.19 | v1.18.20 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.20){: external}. |
| Ubuntu 18.04 packages | 4.15.0.144 | 4.15.0.147 | Updated worker node images with kernel package updates for [CVE-2021-23133](https://nvd.nist.gov/vuln/detail/CVE-2021-23133){: external}, [CVE-2021-3444](https://nvd.nist.gov/vuln/detail/CVE-2021-3444){: external}, and [CVE-2021-3600](https://nvd.nist.gov/vuln/detail/CVE-2021-3600){: external}. 
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.19_1555" caption-side="top"}

### Changelog for master fix pack 1.18.20_1556, released 28 June 2021
{: #11820_1556}

The following table shows the changes that are in the master fix pack patch update `1.18.20_1556`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.22 | v1.1.23 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Gateway-enabled cluster controller | 1352 | 1348 | Updated to run as a non-root user by default, with privileged escalation as needed. |
| GPU device plug-in and installer | 19bf25c | 22e2e0d | Updated to use `Go` version `1.15.12`. Updated universal base image (UBI) to version `8.4` to resolve CVEs. Updated the GPU drivers to version [460.73.01](https://www.nvidia.com/Download/driverResults.aspx/173142/){: external}. |
| IBM Calico extension | 689 | 730 | Updated to use `Go` version `1.16.15`. Updated minimal UBI to version `8.4` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.19-2 | v1.18.20-1 | Updated to support the Kubernetes `1.18.20` release. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 392 | 394 | Updated to use `Go` version `1.15.12`. Updated UBI base image to version `8.4` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 63cd064 | b68ea92 | Updated to use `Go` version `1.16.4`. Updated UBI base image to version `8.4` to resolve CVEs. |
| Key Management Service provider | v2.3.4 | v2.3.5 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| Kubernetes | v1.18.19 | v1.18.20 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.20){: external}. |
| Portieris admission controller | v0.10.2 | v0.10.3 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.3){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.19_1552" caption-side="top"}


### Changelog for worker node fix pack 1.18.19_1555, released 22 June 2021
{: #11819_1555}

The following table shows the changes that are in the worker node fix pack `1.18.19_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | d3dc33 | Updated image with fixes for [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2017-14502](https://nvd.nist.gov/vuln/detail/CVE-2017-14502){: external}, [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external} and [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}.|
| {{site.data.keyword.registrylong_notm}} | N/A | N/A | Added private-only registry support for `ca.icr.io`, `br.icr.io` and `jp2.icr.io`. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2017-8779](https://nvd.nist.gov/vuln/detail/CVE-2017-8779){: external}, [CVE-2017-8872](https://nvd.nist.gov/vuln/detail/CVE-2017-8872){: external}, [CVE-2018-16869](https://nvd.nist.gov/vuln/detail/CVE-2018-16869){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517) [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.19_1554" caption-side="top"}

### Changelog for worker node fix pack 1.18.19_1554, released 7 June 2021
{: #11819_1554}

The following table shows the changes that are in the worker node fix pack `1.18.19_1554`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | 700dc6 | Updated the image for [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}.|
| TCP `keepalive` optimization for VPC | N/A | N/A | Set the `net.ipv4.tcp_keepalive_time` setting to 180 seconds for compatibility with VPC gateways. |
| Ubuntu 18.04 packages | 4.15.0-143 | 4.15.0-144 | Updated worker node images with kernel package updates for [CVE-2021-25217](https://nvd.nist.gov/vuln/detail/CVE-2021-25217){: external}, [CVE-2021-31535](https://nvd.nist.gov/vuln/detail/CVE-2021-31535){: external}, [CVE-2021-32547](https://nvd.nist.gov/vuln/detail/CVE-2021-32547){: external}, [CVE-2021-32552](https://nvd.nist.gov/vuln/detail/CVE-2021-32552){: external}, [CVE-2021-32556](https://nvd.nist.gov/vuln/detail/CVE-2021-32556){: external}, [CVE-2021-32557](https://nvd.nist.gov/vuln/detail/CVE-2021-32557){: external}, [CVE-2021-3448](https://nvd.nist.gov/vuln/detail/CVE-2021-3448){: external}, and [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.19_1553" caption-side="top"}

### Changelog for worker node fix pack 1.18.19_1553, released 24 May 2021
{: #11819_1553}

The following table shows the changes that are in the worker node fix pack `1.18.19_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | e0fa2f | 26c5cc | Updated image with fixes for [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2019-18276](https://nvd.nist.gov/vuln/detail/CVE-2019-18276){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, and [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external}. |
| Kubernetes | v1.18.18 | v1.18.19 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.19){: external}. |
| Ubuntu 18.04 packages | 4.15.0-142 | 4.15.0-143 | Updated worker node images with kernel package updates for [CVE-2021-28688](https://nvd.nist.gov/vuln/detail/CVE-2021-28688){: external}, [CVE-2021-20292](https://nvd.nist.gov/vuln/detail/CVE-2021-20292){: external}, [CVE-2021-29264](https://nvd.nist.gov/vuln/detail/CVE-2021-29264){: external}, [CVE-2021-29265](https://nvd.nist.gov/vuln/detail/CVE-2021-29265){: external}, and [CVE-2021-29650](https://nvd.nist.gov/vuln/detail/CVE-2021-29650){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2009-5155](https://nvd.nist.gov/vuln/detail/CVE-2009-5155){: external} and [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.18_1551" caption-side="top"}

### Changelog for master fix pack 1.18.19_1552, released 24 May 2021
{: #11819_1552}

The following table shows the changes that are in the master fix pack patch update `1.18.19_1552`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.21 | v1.1.22 | Updated image to implement additional IBM security controls and for [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}, [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| CoreDNS | 1.8.3 | 1.8.0 | See the [CoreDNS release notes](https://coredns.io/2020/10/22/coredns-1.8.0-release/){: external}. |
| Gateway-enabled cluster controller | 1322 | 1352 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| IBM Calico extension | 618 | 689 | Updated to use `Go` version 1.15.12. Updated image to implement additional IBM security controls and for [CVE-2020-14391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14391){: external}, [CVE-2020-25661](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25661){: external} and [CVE-2020-25662](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25662){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.18-1 | v1.18.19-2 | Updated to support the Kubernetes 1.18.19 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 390 | 392 | Improved the pre-requisite validation logic for provisioning persistent volume claims (PVCs). Updated image to implement additional IBM security controls and for [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | b6a694b | 63cd064 | Updated image to implement additional IBM security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external}. |
| Key Management Service provider | v2.3.3 | v2.3.4 | Updated image to implement additional IBM security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}. |
| Kubernetes | v1.18.18 | v1.18.19 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.19){: external}. The update resolves CVE-2020-8562 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457271){: external}) and CVE-2021-25737 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457273){: external}). |
| Kubernetes add-on resizer | 1.8.11 | 1.8.12 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.12){: external}. |
| Kubernetes Metrics Server | v0.3.7 | v0.4.4 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1274 | 1328 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| Portieris admission controller | v0.10.1 | v0.10.2 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.2){: external}. |
{: caption="Changes since version 1.18.18_1549" caption-side="top"}

### Changelog for worker node fix pack 1.18.18_1551, released 10 May 2021
{: #11818_1551}

The following table shows the changes that are in the worker node fix pack `1.18.18_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.18_1550" caption-side="top"}

### Changelog for master fix pack 1.18.18_1549, released 27 April 2021
{: #11818_1549}

The following table shows the changes that are in the master fix pack patch update `1.18.18_1549`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.19 | v1.1.21 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| CoreDNS | 1.8.0 | 1.8.3 | See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}. |
| GPU device plug-in and installer | c1c6dd3 | 19bf25c | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.17-1 | v1.18.18-1 | Updated to support the Kubernetes 1.18.18 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 389 | 390 | Updated to use `Go` version 1.15.9 and for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external} and [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}. |
|{{site.data.keyword.cloud_notm}} RBAC Operator | 3dd6bbc | b6a694b | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| Key Management Service provider | v2.2.5 | v2.3.3 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| Kubernetes | v1.18.17 | v1.18.18 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.18){: external}. The update resolves CVE-2021-25735 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6447812){: external}). |
| Kubernetes NodeLocal DNS cache | 1.15.14 | 1.17.3 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.17.3){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-386 | Updated image to implement additional IBM security controls. |
| OpenVPN server | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-385 | Updated image to implement additional IBM security controls. |
| Operator Lifecycle Manager | 0.14.1-IKS-4 | 0.14.1-IKS-8 | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.17_1546" caption-side="top"}

### Changelog for worker node fix pack 1.18.18_1550, released 26 April 2021
{: #11818_1550}

The following table shows the changes that are in the worker node fix pack `1.18.18_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | a3b1ff | e0fa2f | The update addresses [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Added resiliency to `systemd` units to prevent failures situations where the worker nodes are overused.<br><br>Updated worker node images with kernel and package updates for [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}, and [CVE-2021-3348](https://nvd.nist.gov/vuln/detail/CVE-2021-3348){: external}. |
| Ubuntu 16.04 packages |4.4.0-206 | 4.4.0-210 | Updated worker node images with kernel and package updates for [[CVE-2015-1350](https://nvd.nist.gov/vuln/detail/CVE-2015-1350){: external}, [CVE-2017-15107](https://nvd.nist.gov/vuln/detail/CVE-2017-15107){: external}, [CVE-2017-5967](https://nvd.nist.gov/vuln/detail/CVE-2017-5967){: external}, [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2018-5953](https://nvd.nist.gov/vuln/detail/CVE-2018-5953){: external}, [CVE-2019-14513](https://nvd.nist.gov/vuln/detail/CVE-2019-14513){: external}, [CVE-2019-16231](https://nvd.nist.gov/vuln/detail/CVE-2019-16231){: external}, [CVE-2019-16232](https://nvd.nist.gov/vuln/detail/CVE-2019-16232){: external}, [CVE-2019-19061](https://nvd.nist.gov/vuln/detail/CVE-2019-19061){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, and [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.17_1548" caption-side="top"}

### Changelog for worker node fix pack 1.18.17_1548, released 12 April 2021
{: #11817_1548}

The following table shows the changes that are in the worker node fix pack `1.18.17_1548`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 9b2dca | a3b1ff | The update addresses [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external} and [CVE-2021-3450](https://nvd.nist.gov/vuln/detail/CVE-2021-3450){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.17_1547" caption-side="top"}

### Changelog for master fix pack 1.18.17_1546, released 30 March 2021
{: #11817_1546}

The following table shows the changes that are in the master fix pack patch update `1.18.17_1546`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.at_short}} event | N/A | N/A | Now, the `containers-kubernetes.version.update` event is sent to {{site.data.keyword.at_short}} when a master fix pack update is initiated for a cluster. |
| Cluster health image | v1.1.18 | v1.1.19 | Updated image for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}. |
| Gateway-enabled cluster controller | 1232 | 1322 | Updated to use `Go` version 1.15.10 and for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
| GPU device plug-in and installer | af5a6cb | c1c6dd3 | Updated image for [CVE-2021-27919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27919){: external}, [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}, and [CVE-2020-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28852){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.16-2 | v1.18.17-1 | Updated to support the Kubernetes 1.18.17 release. Fixed a bug that prevented VPC load balancers from supporting more than 50 subnets in an account. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 388 | 389 | Updated to use `Go` version 1.15.8. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 86de2b7 | 3dd6bbc | Updated image for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}. |
| Kubernetes | v1.18.16 | v1.18.17 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.17){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.16_1544" caption-side="top"}

### Changelog for worker node fix pack 1.18.17_1547, released 29 March 2021
{: #11817_1547}

The following table shows the changes that are in the worker node fix pack `1.18.17_1547`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-136-generic | 4.15.0-140-generic | Updated worker node images with kernel and package updates for [CVE-2020-27170](https://nvd.nist.gov/vuln/detail/CVE-2020-27170){: external}, [CVE-2020-27171](https://nvd.nist.gov/vuln/detail/CVE-2020-27171){: external}, [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, and [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external}. |
| Ubuntu 16.04 packages | 4.4.0-203-generic | 4.4.0-206-generic | Updated worker node images with kernel and package updates for [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, and [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.16_1545" caption-side="top"}

### Changelog for worker node fix pack 1.18.16_1545, released 12 March 2021
{: #11816_1545}

The following table shows the changes that are in the worker node fix pack `1.18.16_1545`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.9 | 1.3.10 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.10){: external}. The update resolves CVE-2021-21334 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6433475){: external}). |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-24031](https://nvd.nist.gov/vuln/detail/CVE-2021-24031){: external}, [CVE-2021-24032](https://nvd.nist.gov/vuln/detail/CVE-2021-24032){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, and [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for{: external}, [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.16_1544" caption-side="top"}

### Changelog for worker node fix pack 1.18.16_1544, released 1 March 2021
{: #11816_1544}

The following table shows the changes that are in the worker node fix pack `1.18.16_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.15 | v1.18.16 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.16){: external}. |
| Ubuntu 18.04 packages | 4.15.0-135-generic | 4.15.0-136-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
| Ubuntu 16.04 packages | 4.4.0-201-generic | 4.4.0-203-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.15_1541" caption-side="top"}

### Changelog for master fix pack 1.18.16_1544, released 27 February 2021
{: #11816_1544_master}

The following table shows the changes that are in the master fix pack patch update `1.18.16_1543`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1165 | 1274 | Fixed a bug that might cause version 2.0 network load balancers (NLBs) to crash and restart on load balancer updates. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.16_1543" caption-side="top"}

### Changelog for master fix pack 1.18.16_1543, released 22 February 2021
{: #11816_1543}

The following table shows the changes that are in the master fix pack patch update `1.18.16_1543`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.13.4 | v3.13.5 | See the [Calico release notes](https://docs.projectcalico.org/releases){: external}. |
| Cluster health image | v1.1.16 | v1.1.18 | Updated to use `Go` version 1.15.7. Updated image to implement additional IBM security controls. |
| Gateway-enabled cluster controller | 1195 | 1232 | Updated to use `Go` version 1.15.7. |
| IBM Calico extension | 567 | 618 | Updated to use `Go` version 1.15.7. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.15-3 | v1.18.16-2 | Updated to support the Kubernetes 1.18.16 release and to use `calicoctl` version 3.13.5. Updated image to implement additional IBM security controls and for [DLA-2509-1](https://www.debian.org/lts/security/2020/dla-2509){: external}. Updated version 1.0 and 2.0 network load balancers (NLBs) to run as a non-root user by default, with privileged escalation as needed. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 385 | 388 | Improved the retry logic for provisioning persistent volume claims (PVCs). |
| {{site.data.keyword.cloud_notm}} RBAC Operator | f859228 | 86de2b7 | Updated to use `Go` version 1.15.7. |
| Key Management Service provider | v2.2.3 | v2.2.5 | Updated to use `Go` version 1.15.7. Updated image to implement additional IBM security controls. |
| Kubernetes | v1.18.15 | v1.18.16 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.16){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1078 | 1165 | Updated to run as a non-root user by default, with privileged escalation as needed. Updated to use `Go` version 1.15.7. |
| Operator Lifecycle Manager | 0.14.1-IKS-2 | 0.14.1-IKS-4 | Updated image for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.15_1538" caption-side="top"}

### Changelog for worker node fix pack 1.18.15_1541, released 15 February 2021
{: #11815_1541}

The following table shows the changes that are in the worker node fix pack `1.18.15_1541`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.15_1540" caption-side="top"}

### Changelog for worker node fix pack 1.18.15_1540, released 3 February 2021
{: #11815_1540}

The following table shows the changes that are in the worker node fix pack `1.18.15_1540`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Metadata updates | N/A | N/A | Updated the worker node version fix pack metadata for internal documentation purposes. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.15_1539" caption-side="top"}

### Changelog for worker node fix pack 1.18.15_1539, released 1 February 2021
{: #11815_1539}

The following table shows the changes that are in the worker node fix pack `1.18.15_1539`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | 4.4.0-200-generic | 4.4.0-201-generic | Updated worker node image with kernel and package updates for [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
| Ubuntu 18.04 packages | 4.15.0-132-generic | 4.15.0-135-generic | Updated worker node image with kernel and package updates for [CVE-2019-12761](https://nvd.nist.gov/vuln/detail/CVE-2019-12761){: external}, [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.15_1538" caption-side="top"}

### Changelog for master fix pack 1.18.15_1538, released 19 January 2021
{: #11815_1538_master}

The following table shows the changes that are in the master fix pack patch update `1.18.15_1538`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.14 | v1.1.16 | Updated image to implement additional IBM security controls. |
| Gateway-enabled cluster controller | 1184 | 1195 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| GPU device plug-in and installer | c26e2ae | af5a6cb | Updated image for [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}, [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}, [CVE-2020-27350](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350){: external}, [CVE-2020-29361](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29361){: external}, [CVE-2020-29362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29362){: external}, [CVE-2020-29363](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29363){: external}, [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8284](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8284){: external}, [CVE-2020-8285](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8285){: external}, and [CVE-2020-8286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8286){: external}. |
| IBM Calico extension | 556 | 567 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.14-1 | v1.18.15-3 | Updated to support the Kubernetes 1.18.5 release and to implement additional IBM security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 384 | 385 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Key Management Service provider | v2.2.2 | v2.2.3 | Fixed bug to ignore conflict errors during KMS secret reencryption. Updated to use `Go` version 1.15.5. Updated image to implement additional IBM security controls and for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Kubernetes | v1.18.14 | v1.18.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.15){: external}. Updated to implement additional IBM security controls. |
| Kubernetes Dashboard | v2.0.4 | v2.0.5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.5){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.4 | v1.0.6 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1004 | 1078 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Operator Lifecycle Manager Catalog | v1.6.1 | v1.15.3 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.15.3){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.14_1537" caption-side="top"}

### Changelog for worker node fix pack 1.18.15_1538, released 18 January 2021
{: #11815_1538}

The following table shows the changes that are in the worker node fix pack `1.18.15_1538`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.13 | v1.18.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.15){: external}. |
| Ubuntu 16.04 packages | 4.4.0-197-generic | 4.4.0-200-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361) external}, and [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362) external}. |
| Ubuntu 18.04 packages | 4.15.0-128-generic | 4.15.0-132-generic | Updated worker node image with kernel and package updates for{: external}, [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2021-1052](https://nvd.nist.gov/vuln/detail/CVE-2021-1052){: external}, [CVE-2021-1053](https://nvd.nist.gov/vuln/detail/CVE-2021-1053){: external}, and [CVE-2019-19770](https://nvd.nist.gov/vuln/detail/CVE-2019-19770){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.13_1536" caption-side="top"}

### Changelog for master fix pack 1.18.14_1537, released 6 January 2021
{: #11814_1537}

The following table shows the changes that are in the master fix pack patch update `1.18.14_1537`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Calico extension | 544 | 556 | Updated image to include the `ip` command. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.13-1 | v1.18.14-1 | Updated to support the Kubernetes 1.18.14 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | N/A | N/A | Updated to run with a privileged security context. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | c148a8a | f859228 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Key Management Service provider | v2.0.7 | v2.2.2 | Updated the key management service (KMS) provider support as follows.<ul><li>Updated to use <code>Go</code> version 1.15.2.</li><li>Added support for <a href="/docs/account?topic=account-serviceauth">service-to-service authentication</a>.</li><li>Updated to use the KMS provider secret to identify when a <a href="/docs/containers?topic=containers-encryption#keyprotect">Key Protect</a> key is enabled and disabled so that encryption and decryption requests are updated accordingly.</li></ul> |
| Kubernetes | v1.18.13 | v1.18.14 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.14){: external}. |
| Kubernetes `NodeLocal` DNS cache | N/A | N/A | Updated to run with a least privileged security context. |
| Operator Lifecycle Manager | 0.14.1-IKS-1 | 0.14.1-IKS-2 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.13_1535" caption-side="top"}

### Changelog for worker node fix pack 1.18.13_1536, released 21 December 2020
{: #11813_1536}

The following table shows the changes that are in the worker node fix pack `1.18.13_1536`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ubuntu 18.04 packages | 4.15.0-126-generic | 4.15.0-128-generic | Updated worker node image with kernel and package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Kubernetes | v1.18.12 | v1.18.13 | See the [Kubernetes change logs.](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.13){: external} |
| Ephemeral storage reservations | N/A | N/A | Reserve local ephemeral storage to prevent workload evictions. |
| HAProxy | db4e6d | 9b2dca | Image update for [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external} and [CVE-2020-24659](https://nvd.nist.gov/vuln/detail/CVE-2020-24659){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.13_1535" caption-side="top"}

### Changelog for master fix pack 1.18.13_1535, released 14 December 2020
{: #11813_1535}

The following table shows the changes that are in the master fix pack patch update `1.18.13_1535`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.13 | v1.1.14 | Updated image to implement additional IBM security controls. |
| CoreDNS | 1.6.9 | 1.8.0 | See the [CoreDNS release notes](https://coredns.io/2020/10/22/coredns-1.8.0-release/){: external}. Additionally, updated the CoreDNS configuration to increase the weight of scheduling CoreDNS pods to different worker nodes and zones. |
| etcd | v3.4.13 | v3.4.14 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.14){: external}. |
| Gateway-enabled cluster controller | 1105 | 1184 | Updated to use `Go` version 1.15.5. Updated image to implement additional IBM security controls. |
| GPU device plug-in and installer | b966c41 | c26e2ae | Updated the GPU drivers to version [450.80.02](https://www.nvidia.com/download/driverResults.aspx/165294){: external}. Updated image for [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}, [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}, and [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}. Updated image to implement additional IBM security controls. |
| IBM Calico extension | 378 | 544 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.5. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.12-1 | v1.18.13-1 | Updated to support the Kubernetes 1.18.13 release. Updated image to implement additional IBM security controls. Fixed a bug in VPC load balancer creation when the cluster, VPC, or subnet are in a different resource group.  |
| {{site.data.keyword.filestorage_full_notm}} monitor | 379 | 384 | Updated to use `Go` version 1.15.5 and to run as a non-root user. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 379 | 384 | Updated to use `Go` version 1.15.5 and to run with a least privileged security context. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 197bc70 | c148a8a | Updated to use `Go` version 1.15.6 and updated image to implement additional IBM security controls. |
| Key management service (KMS) provider | v2.0.5 | v2.0.7 | Updated image to implement additional IBM security controls. |
| Kubernetes | v1.18.12 | v1.18.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.13){: external}. |
| Kubernetes `NodeLocal` DNS cache | N/A | N/A | Updated the `NodeLocal` DNS cache configuration to support [customizing the `node-local-dns` config map](/docs/containers?topic=containers-cluster_dns#dns_nodelocal_customize). |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 208 | 1004 | Updated Alpine base image to version 3.12 and to use `Go` version 1.15.5. Updated image for [CVE-2020-8037](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8037){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. Updated image to implement additional IBM security controls. |
| Operator Lifecycle Manager | N/A | N/A | Updated to run as a non-root user. |
| OpenVPN client | 2.4.6-r3-IKS-116 | 2.4.6-r3-IKS-301 | Updated image to implement additional IBM security controls. |
| OpenVPN server | 2.4.6-r3-IKS-222 | 2.4.6-r3-IKS-301 | Updated image to implement additional IBM security controls. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.12_1533" caption-side="top"}

### Changelog for worker node fix pack 1.18.12_1535, released 11 December 2020
{: #11812_1535}

The following table shows the changes that are in the worker node fix pack `1.18.12_1535`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 bare metal kernel | 4.15.0-126-generic | 4.15.0-123-generic | **Bare metal worker nodes**: Reverted the kernel version for bare metal worker nodes while Canonical addresses issues with the previous version that prevented worker nodes from being reloaded or updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.12_1534" caption-side="top"}

### Changelog for worker node fix pack 1.18.12_1534, released 7 December 2020
{: #11812_1534}

The following table shows the changes that are in the worker node fix pack `1.18.12_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.4 | 1.3.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.9){: external}. The update resolves CVE-2020–15257 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6387878){: external}). |
| HAProxy | 1.8.26-384f42 | db4e6d | Added provenance labels for source tracking. |
| Ubuntu 18.04 packages | 4.15.0-123-generic | 4.15.0-126-generic | Updated worker node image with kernel and package updates for [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external} and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
| Ubuntu 16.04 packages | 4.4.0-194-generic | 4.4.0-197-generic | Updated worker node image with kernel and package updates for [CVE-2020-0427](https://nvd.nist.gov/vuln/detail/CVE-2020-0427){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external}, [CVE-2020-25645](https://nvd.nist.gov/vuln/detail/CVE-2020-25645){: external}, and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.12_1533" caption-side="top"}

### Changelog for worker node fix pack 1.18.12_1533, released 23 November 2020
{: #11812_1533_worker}

The following table shows the changes that are in the worker node fix pack `1.18.12_1533`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.10 | v1.18.12 | See the [Kubernetes changelog](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md#v11812){: external}.|
| Ubuntu 18.04 packages | 4.15.0-122-generic | 4.15.0-123-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
| Ubuntu 16.04 packages | 4.4.0-193-generic | 4.4.0-194-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.10_1532" caption-side="top"}

### Changelog for master fix pack 1.18.12_1533, released 16 November 2020
{: #11812_1533}

The following table shows the changes that are in the master fix pack patch update `1.18.12_1533`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.12 | v1.1.13 | Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| GPU device plug-in and installer | 0c07674 | b966c41 | Updated image for [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2020-8177](https://nvd.nist.gov/vuln/detail/CVE-2020-8177){: external}, [CVE-2019-14889](https://nvd.nist.gov/vuln/detail/CVE-2019-14889){: external}, [CVE-2020-1730](https://nvd.nist.gov/vuln/detail/CVE-2020-1730){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}, [CVE-2019-5018](https://nvd.nist.gov/vuln/detail/CVE-2019-5018){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, [CVE-2020-13631](https://nvd.nist.gov/vuln/detail/CVE-2020-13631){: external}, [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}, [CVE-2020-6405](https://nvd.nist.gov/vuln/detail/CVE-2020-6405){: external}, [CVE-2020-9327](https://nvd.nist.gov/vuln/detail/CVE-2020-9327){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-19221](https://nvd.nist.gov/vuln/detail/CVE-2019-19221){: external}, [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}, [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-20454](https://nvd.nist.gov/vuln/detail/CVE-2019-20454){: external}, [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2018-20843](https://nvd.nist.gov/vuln/detail/CVE-2018-20843){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, and [CVE-2019-20387](https://nvd.nist.gov/vuln/detail/CVE-2019-20387){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager |v1.18.10-1 | v1.18.12-1 | Updated to support the Kubernetes 1.18.12 release. Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 378 | 379 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.2. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 31c794a | 197bc70 | Updated image for [CVE-2019-20454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20454){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}, [CVE-2019-20807](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20807){: external}, [CVE-2019-16935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16935){: external}, [CVE-2019-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20907){: external}, [CVE-2020-14422](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14422){: external}, [CVE-2020-8492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8492){: external}, [CVE-2019-15165](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15165){: external}, [CVE-2019-16168](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16168){: external}, [CVE-2019-20218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20218){: external}, [CVE-2019-5018](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5018){: external}, [CVE-2020-13630](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13630){: external}, [CVE-2020-13631](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13631){: external}, [CVE-2020-13632](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13632){: external}, [CVE-2020-6405](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6405){: external}, [CVE-2020-9327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9327){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-13050](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13050){: external}, [CVE-2018-20843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20843){: external}, [CVE-2019-15903](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15903){: external}, [CVE-2019-14889](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14889){: external}, [CVE-2020-1730](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1730){: external}, [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}, [CVE-2020-14382](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14382){: external}, [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external}, [CVE-2019-19956](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19956){: external}, [CVE-2019-20388](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20388){: external}, [CVE-2020-7595](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7595){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-19906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19906){: external}, [CVE-2019-20387](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20387){: external}, and [CVE-2019-19221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19221){: external}.  |
| Key Management Service provider | v2.0.4 | v2.0.5 | Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| Kubernetes | v1.18.10 | v1.18.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.12){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.10_1531" caption-side="top"}

### Changelog for worker node fix pack 1.18.10_1532, released 9 November 2020
{: #11810_1532}

The following table shows the changes that are in the worker node fix pack `1.18.10_1532`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with kernel and package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}, and [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}. |
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, and [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.10_1531" caption-side="top"}

### Changelog for worker node fix pack 1.18.10_1531, released 26 October 2020
{: #11810_1531_worker}

The following table shows the changes that are in the worker node fix pack `1.18.10_15313`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.9 | v1.18.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.10){: external}. |
|Ubuntu 18.04 packages | 4.15.0-118-generic | 4.15.0-122-generic | Updated worker node images with kernel and package updates for [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external},[CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2019-20916](https://nvd.nist.gov/vuln/detail/CVE-2019-20916){: external}, [CVE-2020-12351](https://nvd.nist.gov/vuln/detail/CVE-2020-12351){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, [CVE-2020-16120](https://nvd.nist.gov/vuln/detail/CVE-2020-16120){: external}, [CVE-2020-24490](https://nvd.nist.gov/vuln/detail/CVE-2020-24490){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
|Ubuntu 16.04 packages | 4.4.0-190-generic | 4.4.0-193-generic | Updated worker node images with kernel and package updates for [CVE-2017-17087](https://nvd.nist.gov/vuln/detail/CVE-2017-17087){: external}, [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external}, [CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.9_1530" caption-side="top"}

### Changelog for master fix pack 1.18.10_1531, released 26 October 2020
{: #11810_1531}

The following table shows the changes that are in the master fix pack patch update `1.18.10_1531`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Updated the `calico-node` daemon set in the `kube-system` namespace to set the `spec.updateStrategy.rollingUpdate.maxUnavailable` parameter to `10%` for clusters with more than 50 worker nodes. |
| Cluster health image | v1.1.11 | v1.1.12 | Updated to use `Go` version 1.15.2. |
| Gateway-enabled cluster controller | 1082 | 1105 | Updated to use `Go` version 1.15.2. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.9-1 | v1.18.10-1 | Updated to support the Kubernetes 1.18.10 release. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4b47693 | 31c794a | Updated to use `Go` version 1.15.2. |
| Kubernetes | v1.18.9 | v1.18.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.10){: external}. |
| Kubernetes `NodeLocal` DNS cache | 1.15.13 | 1.15.14 | See the [Kubernetes `NodeLocal` DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.14){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.9_1528" caption-side="top"}

### Changelog for worker node fix pack 1.18.9_1530, released 12 October 2020
{: #1189_1530}

The following table shows the changes that are in the worker node fix pack `1.18.9_1530`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2019-8936](https://nvd.nist.gov/vuln/detail/CVE-2019-8936){: external}, [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}, and [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external}.|
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external} and [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.8_1529" caption-side="top"}

### Changelog for worker node fix pack 1.18.9_1529, released 28 September 2020
{: #1189_1529}

The following table shows the changes that are in the worker node fix pack `1.18.9_1529`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.8    | v1.18.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.9){: external}. |
| Ubuntu 18.04 packages | 4.15.0-117-generic | 4.15.0-118-generic | Updated worker node image with   kernel and package updates for [CVE-2018-1000500](https://nvd.nist.gov/vuln/detail/CVE-2018-1000500){: external}, [CVE-2018-7738](https://nvd.nist.gov/vuln/detail/CVE-2018-7738){: external}, [CVE-2019-14855](https://nvd.nist.gov/vuln/detail/CVE-2019-14855){: external}, [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, [CVE-2020-10753](https://nvd.nist.gov/vuln/detail/CVE-2020-10753){: external}, [CVE-2020-12059](https://nvd.nist.gov/vuln/detail/CVE-2020-12059){: external}, [CVE-2020-12888](https://nvd.nist.gov/vuln/detail/CVE-2020-12888){: external}, [CVE-2020-1760](https://nvd.nist.gov/vuln/detail/CVE-2020-1760){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}.|
| Ubuntu 16.04 packages | 4.4.0-189-generic | 4.4.0-190-generic | Updated worker node image with kernel and package updates for [CVE-2019-20811](https://nvd.nist.gov/vuln/detail/CVE-2019-20811){: external}, [CVE-2019-9453](https://nvd.nist.gov/vuln/detail/CVE-2019-9453){: external}, [CVE-2020-0067](https://nvd.nist.gov/vuln/detail/CVE-2020-0067){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.8_1527" caption-side="top"}

### Changelog for master fix pack 1.18.9_1528, released 21 September 2020
{: #1189_1528}

The following table shows the changes that are in the master fix pack patch update `1.18.9_1528`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.9 | v1.1.11 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. |
| etcd | v3.4.10 | v3.4.13 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.13){: external}. |
| GPU device plug-in and installer | bacb9e1 | edd26a4 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. Updated the GPU drivers to version [450.51.06](https://www.nvidia.com/download/driverResults.aspx/162630){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.6-1 | v1.18.9-1 | Updated to support the Kubernetes 1.18.9 release and to use `Go` version 1.13.15. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 377 | 378 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | d80b738 | 4b47693 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and image for [CVE-2020-14352](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14352){: external}. |
| Key Management Service provider | v2.0.2 | v2.0.4 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. |
| Kubernetes | v1.18.8 | v1.18.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.9){: external}. |
| Kubernetes Dashboard | v2.0.3 | v2.0.4 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.4){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.8_1527" caption-side="top"}

### Changelog for worker node fix pack 1.18.8_1527, released 14 September 2020
{: #1188_1527}

The following table shows the changes that are in the worker node fix pack `1.18.8_1527`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-384f42 | 1.8.26-561f1a | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.|
| Ubuntu 18.04 packages | 4.15.0-112-generic | 4.15.0-117-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external}, [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}, and [CVE-2020-14386](https://nvd.nist.gov/vuln/detail/CVE-2020-14386){: external}. |
| Ubuntu 16.04 packages | 4.4.0-187-generic | 4.4.0-189-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external} and [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.8_1526" caption-side="top"}

### Changelog for worker node fix pack 1.18.8_1526, released 31 August 2020
{: #1188_1526}

The following table shows the changes that are in the worker node fix pack `1.18.8_1526`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-12403](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12403){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}, and [CVE-2020-8624](https://nvd.nist.gov/vuln/detail/CVE-2020-8624){: external}. |
| Ubuntu 16.04 packages | 4.4.0-186-generic | 4.4.0-187-generic | Updated worker node image with kernel and package updates for [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, and [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.8_1525" caption-side="top"}

### Changelog for master fix pack 1.18.8_1525, released 18 August 2020
{: #1188_1525_master}

The following table shows the changes that are in the master fix pack patch update `1.18.8_1525`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster health image | v1.1.8 | v1.1.9 | Updated to use `Go` version 1.13.13. |
| etcd | v3.4.9 | v3.4.10 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.10){: external}. |
| GPU device plug-in and installer | 6847df8 | f22c75e | Updated image for [CVE-2020-14039](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14039){: external} and [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 376 | 377 | Fixed a bug that prevents persistent volume claim (PVC) creation failures from being retried. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8882606 | d80b738 | Updated image for [CVE-2020-12049](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12049){: external} and to use `Go` version 1.13.14. |
| Key Management Service provider | v1.0.0 | v2.0.2 | Updated image for [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| Kubernetes | v1.18.6 | v1.18.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.8){: external}. |
| Kubernetes add-on resizer | 1.8.7 | 1.8.11 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.11){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing of all API groups except `apiregistration.k8s.io` and `coordination.k8s.io`. |
| Kubernetes Metrics Server | v0.3.6 | v0.3.7 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.7){: external}. |
| Kubernetes `NodeLocal` DNS cache configuration | N/A | N/A | Increased the pod termination grace period. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.6_1523" caption-side="top"}

### Changelog for worker node fix pack 1.18.8_1525, released 17 August 2020
{: #1188_1525}

The following table shows the changes that are in the worker node fix pack `1.18.8_1525`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.6 | v1.18.8 | See the [Kubernetes change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md#v1188){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-12400](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12400){: external}, [CVE-2020-12401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12401){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}, and [CVE-2020-6829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6829){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, and [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.6_1523" caption-side="top"}

### Changelog for worker node fix pack 1.18.6_1523, released 3 August 2020
{: #1186_1523}

The following table shows the changes that are in the worker node fix pack `1.18.6_1523`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-111-generic | 4.15.0-112-generic | Updated worker node images with kernel and package updates for [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-10757](https://nvd.nist.gov/vuln/detail/CVE-2020-10757){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
| Ubuntu 16.04 packages | 4.4.0-185-generic | 4.4.0-186-generic | Updated worker node images with package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.6_1520" caption-side="top"}

### Changelog for master fix pack 1.18.6_1522, released 24 July 2020
{: #1186_1522}

The following table shows the changes that are in the master fix pack patch update `1.18.6_1522`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master operations | N/A | N/A | Fixed a problem that might cause pods to fail authentication to the Kubernetes API server after a cluster master operation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 375 | 376 | Updated to use `Go` version 1.13.8. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.6_1521" caption-side="top"}

### Changelog for master fix pack 1.18.6_1521, released 20 July 2020
{: #1186_1521}

The following table shows the changes that are in the master fix pack patch update `1.18.6_1521`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 31d4bb6 | 8c24345 | Updated image for [CVE-2017-12133](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12133){: external}, [CVE-2017-18269](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18269){: external}, [CVE-2018-11236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11236){: external}, [CVE-2018-11237](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11237){: external}, [CVE-2018-19591](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19591){: external}, [CVE-2018-6485](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6485){: external}, [CVE-2019-19126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19126){: external}, [CVE-2019-9169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9169){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, and [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}. |
| IBM Calico extension | 353 | 378 | Updated to handle any `ens` network interface. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.4-1 | v1.18.6-1 |Updated to support the Kubernetes 1.18.6 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor configuration | N/A | N/A | Added a pod memory limit. |
| {{site.data.keyword.cloud_notm}} RBAC operator | 08ce50e | 8882606 | Updated image for [CVE-2020-13777](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13777){: external} and to use `Go` version 1.13.12. |
| Kubernetes | v1.18.4 | v1.18.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.6){: external}. The update resolves CVE-2020-8559 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249915){: external}). |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `scheduling.k8s.io` API group and the `tokenreviews` resource. |
| Kubernetes Dashboard | v2.0.1 | v2.0.3 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.3){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-131 | 2.4.6-r3-IKS-222 | Removed the deprecated `comp-lzo` compression configuration option and updated the default cipher that is used for encryption. |
| Operator Lifecycle Manager | 0.14.1 | 0.14.1-IKS-1 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.4_1518" caption-side="top"}

### Changelog for worker node fix pack 1.18.6_1520, released 20 July 2020
{: #1186_1520}

The following table shows the changes that are in the worker node fix pack `1.18.6_1520`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 2.0.15-afe432 | 1.8.25-384f42 | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Fixes a connection leak that happens when HAProxy is under high load. |
| Kubernetes | v1.18.4 | v1.18.6 | See the [Kubernetes change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md#v1186){: external}. The update resolves CVE-2020-8557 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249941){: external}). |
| Ubuntu 18.04 packages | 4.15.0-109-generic | 4.15.0-111-generic | Updated worker node images with kernel and package updates for [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-19591](https://nvd.nist.gov/vuln/detail/CVE-2018-19591){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-12402](https://nvd.nist.gov/vuln/detail/CVE-2020-12402){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
| Ubuntu 16.04 packages | 4.4.0-184-generic | 4.4.0-185-generic | Updated worker node images with package updates for [CVE-2017-12133](https://nvd.nist.gov/vuln/detail/CVE-2017-12133){: external}, [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}, [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-6485](https://nvd.nist.gov/vuln/detail/CVE-2018-6485){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.4_1518" caption-side="top"}

### Changelog for worker node fix pack 1.18.4_1518, released 6 July 2020
{: #1184_1518}

The following table shows the changes that are in the worker node fix pack `1.18.4_1518`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-30b675 | 2.0.15-afe432 | See the [HAProxy changelog](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}. |
| Ubuntu 18.04 packages | 4.15.0-106-generic | 4.15.0-109-generic | Updated worker node images with kernel and package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-16089](https://nvd.nist.gov/vuln/detail/CVE-2019-16089){: external}, [CVE-2019-19036](https://nvd.nist.gov/vuln/detail/CVE-2019-19036){: external}, [CVE-2019-19039](https://nvd.nist.gov/vuln/detail/CVE-2019-19039){: external}, [CVE-2019-19318](https://nvd.nist.gov/vuln/detail/CVE-2019-19318){: external}, [CVE-2019-19642](https://nvd.nist.gov/vuln/detail/CVE-2019-19642){: external}, [CVE-2019-19813](https://nvd.nist.gov/vuln/detail/CVE-2019-19813){: external}, [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-19377](https://nvd.nist.gov/vuln/detail/CVE-2019-19377){: external}, and [CVE-2019-19816](https://nvd.nist.gov/vuln/detail/CVE-2019-19816){: external}. |
| Ubuntu 16.04 packages |N/A | N/A| Updated worker node images with package updates for [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external} and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}. |
| Worker node `drain` automation |N/A | N/A| Fixes a race condition that can cause worker node `drain` automation to fail. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.4_1517" caption-side="top"}

### Changelog for 1.18.4_1517, released 22 June 2020
{: #1184_1517}

The following table shows the changes that are in the master and worker node update `1.18.4_1517`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Calico | Master | v3.13.3 | v3.13.4 | See the [Calico release notes](https://docs.projectcalico.org/releases){: external}. The master update resolves CVE-2020-13597 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6226322){: external}). |
| Cluster health image | Master | v1.1.5 | v1.1.8 | Additional status information is included when an add-on health state is `critical`. Improved performance when handling cluster status updates. |
| Cluster master operations | Master | N/A | N/A | Cluster master operations such as `refresh` or `update` are now canceled if a broken [Kubernetes admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} is detected. |
| etcd | Master | v3.4.7 | v3.4.9 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.9){: external}. |
| GPU device plug-in and installer | Master | b9a418c | 2bcf8e4 | Updated image for [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.18.3-1 | v1.18.4-1 | Updated to support the Kubernetes 1.18.4 release. Updated the version 2.0 private network load balancers (NLBs) to manage Calico global network policies. Updated `calicoctl` version to 3.13.4. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | Master | 373 | 375 | Fixed a bug that might cause error handling to create additional persistent volumes. |
| {{site.data.keyword.cloud_notm}} RBAC operator | Master | N/A | 08ce50e | **New!**: Added a control plane operator to synchronize [{{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) service access roles](/docs/containers?topic=containers-access_reference#service) with Kubernetes role-based access control (RBAC) roles. |
| Kubernetes | Both | v1.18.3 | v1.18.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.4){: external}. The master update resolves CVE-2020-8558 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249905){: external}). |
| Kubernetes configuration | Master | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `apiextensions.k8s.io` API group and the `persistentvolumeclaims` and `persistentvolumes` resources. Additionally, the `http2-max-streams-per-connection` option is set to `1000` to mitigate network disruption impacts on the `kubelet` connection to the API server. |
| Kubernetes Dashboard | Master | v2.0.0 | v2.0.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.1){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 211 | 223 | Improved startup performance of version 2.0 private network load balancers (NLBs). |
| Ubuntu 18.04 packages | Worker | 4.15.0-101-generic | 4.15.0-106-generic | Updated worker node images with kernel and package updates for [CVE-2018-8740](https://nvd.nist.gov/vuln/detail/CVE-2018-8740){: external}, [CVE-2019-17023](https://nvd.nist.gov/vuln/detail/CVE-2019-17023){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-12399](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12399){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-179-generic | 4.4.0-184-generic | Updated worker node images with package and kernel updates for [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12769](https://nvd.nist.gov/vuln/detail/CVE-2020-12769){: external}, [CVE-2020-1749](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1749){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and[CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.3_1515" caption-side="top"}

### Changelog for worker node fix pack 1.18.3_1515, released 8 June 2020
{: #1183_1515}

The following table shows the changes that are in the worker node fix pack `1.18.3_1515`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1549](https://nvd.nist.gov/vuln/detail/CVE-2019-1549){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.3_1514" caption-side="top"}

### Changelog for 1.18.3_1514, released 26 May 2020
{: #1183_1514}

The following table shows the changes that are in the master and worker node update `1.18.3_1514`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| IBM Calico extension | Master | 349 | 353 | Skips creating a Calico host endpoint when no endpoint is needed. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.18.2-3 | v1.18.3-1 | Updated to support the Kubernetes 1.18.3 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 371 | 373 | Image updated for [CVE-2020-11655](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11655){: external}. |
| Kubernetes | Both | v1.18.2 | v1.18.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.3){: external}. |
| Kubernetes Metrics Server | Master | N/A | N/A | Increased the CPU per node for the `metrics-server` container to improve availability of the metrics server API service for large clusters. |
| Kubernetes `NodeLocal` DNS cache | Master | 1.15.12 | 1.15.13 | See the [Kubernetes `NodeLocal` DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.13){: external}. Updated the `node-local-dns` daemon set to include the `prometheus.io/port` and `prometheus.io/scrape` annotations on the pods. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 207 | 211 | Updated the version 2.0 network load balancers (NLB) to clean up unnecessary IPVS rules. |
| Ubuntu 18.04 packages | Worker | 4.15.0-99-generic | 4.15.0-101-generic | Updated worker node images with kernel and package updates for [CVE-2019-20795](https://nvd.nist.gov/vuln/detail/CVE-2019-20795){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616), and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.18.2_1512" caption-side="top"}

### Changelog for 1.18.2_1512, released 11 May 2020
{: #1182_1512}

The following table shows the changes that are in patch update 1.18.2_1512. If you update your cluster from Kubernetes 1.17, review the [preparation actions](/docs/containers?topic=containers-cs_versions#cs_v118).
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.12.1 | v3.13.3 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.13/release-notes/){: external}. |
| Cluster health image | v1.1.1 | v1.1.4 | When cluster add-ons don't support the current cluster version, a warning is now returned in the cluster health state. |
| CoreDNS configuration | N/A | N/A | To improve cluster DNS availability, CoreDNS [pods now prefer evenly distributed scheduling](https://kubernetes.io/blog/2020/05/introducing-podtopologyspread/){: external} across worker nodes and zones. |
| etcd | v3.4.3 | v3.4.7 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.7){: external}). |
| Gateway-enabled cluster controller | 1045 | 1082 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| GPU device plug-in and installer | 8c6538f | b9a418c | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| IBM Calico extension | 320 | 349 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.5-1 | v1.18.2-3 | Updated to support the Kubernetes 1.18.2 release and to use `calicoctl` version 3.13.3. Updated network load balancer (NLB) events to use the latest {{site.data.keyword.cloud_notm}} troubleshooting documentation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 358 | 371 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Kubernetes | v1.17.5 | v1.18.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.2){: external}. The master update resolves CVE-2020-8555 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6220220){: external}). |
| Kubernetes admission controllers configuration | N/A | N/A | Added `CertificateApproval`, `CertificateSigning`, `CertificateSubjectRestriction` and `DefaultIngressClass` to the `--enable-admission-plugins` option for the cluster's [Kubernetes API server](/docs/containers?topic=containers-service-settings#kube-apiserver). |
| Kubernetes configuration | N/A | N/A | Removed `batch/v2alpha1=true` from the `--runtime-config` option for the cluster's Kubernetes API server. |
| Kubernetes Dashboard | v2.0.0-rc7 | v2.0.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0){: external}. |
| Kubernetes NodeLocal DNS cache | 1.15.8 | 1.15.12 | <ul><li>See the <a href="https://github.com/kubernetes/dns/releases/tag/1.15.12">Kubernetes NodeLocal DNS cache release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li><li><a href="/docs/containers?topic=containers-cluster_dns#dns_cache">NodeLocal DNS cache</a> is now generally available, but still disabled by default.</li><li>In Kubernetes 1.18, you might also use <a href="/docs/containers?topic=containers-cluster_dns#dns_zone_aware">zone-aware DNS</a> instead of just NodeLocal DNS cache, to increase DNS performance and availability in a multizone cluster.</li></ul> |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 177 | 207 | Improved application logging. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Pause container image | 3.1 | 3.2 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.5_1523" caption-side="top"}




## Version 1.17 changelog (unsupported as of 2 July 2021)
{: #117_changelog}

Version 1.17 is unsupported. You can review the following archive of 1.17 changelogs.
{: shortdesc}

### Changelog for worker node fix pack 1.17.17_1568, released 19 July 2021
{: #1171_1568}

The following table shows the changes that are in the worker node fix pack `1.17.17_1568`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with kernel package updates. |
| Ubuntu 18.04 packages | N/A | N/A| Updated worker node images with kernel package updates. | 
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1567" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1567, released 6 July 2021
{: #11717_1567_worker}

The following table shows the changes that are in the worker node fix pack `1.17.17_1567`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 700dc6 | aae810 | Updated image with fixes for [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}, [CVE-2021-20271](https://nvd.nist.gov/vuln/detail/CVE-2021-20271){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external}, [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, and [CVE-2021-3541](https://nvd.nist.gov/vuln/detail/CVE-2021-3541){: external}. |
| Ubuntu 18.04 packages | 4.15.0.144 | 4.15.0.147 | Updated worker node images with kernel package updates for [CVE-2021-23133](https://nvd.nist.gov/vuln/detail/CVE-2021-23133){: external}, [CVE-2021-3444](https://nvd.nist.gov/vuln/detail/CVE-2021-3444){: external}, and [CVE-2021-3600](https://nvd.nist.gov/vuln/detail/CVE-2021-3600){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1566" caption-side="top"}

### Changelog for master fix pack 1.17.17_1567, released 28 June 2021
{: #11717_1567}

The following table shows the changes that are in the master fix pack patch update `1.17.17_1567`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.22 | v1.1.23 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
| GPU device plug-in and installer | 4aa248d | 83ae89b | Updated to use `Go` version `1.15.12`. Updated universal base image (UBI) to version `8.4` to resolve CVEs. Updated the GPU drivers to version [460.73.01](https://www.nvidia.com/Download/driverResults.aspx/173142/). |
| IBM Calico extension | 689 | 730 | Updated to use `Go` version `1.16.15`. Updated UBI minimal base image to version `8.4` to resolve CVEs. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 392 | 394 | Updated to use `Go` version `1.15.12`. Updated UBI base image to version `8.4` to resolve CVEs. |
| Key Management Service provider | v1.0.14 | v1.0.15 | Updated to use `Go` version `1.15.12`. Updated image for [CVE-2021-33194](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33194){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1563" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1566, released 22 June 2021
{: #11717_1566}

The following table shows the changes that are in the worker node fix pack `1.17.17_1566`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | d3dc33 | Updated image with fixes for [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2017-14502](https://nvd.nist.gov/vuln/detail/CVE-2017-14502){: external}, [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external} and [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}.|
| {{site.data.keyword.registrylong_notm}} | N/A | N/A | Added private-only registry support for `ca.icr.io`, `br.icr.io` and `jp2.icr.io`. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2017-8779](https://nvd.nist.gov/vuln/detail/CVE-2017-8779){: external}, [CVE-2017-8872](https://nvd.nist.gov/vuln/detail/CVE-2017-8872){: external}, [CVE-2018-16869](https://nvd.nist.gov/vuln/detail/CVE-2018-16869){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517) [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1565" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1565, released 7 June 2021
{: #11717_1565}

The following table shows the changes that are in the worker node fix pack `1.17.17_1565`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | 700dc6 | Updated the image for [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}.|
| TCP `keepalive` optimization for VPC | N/A | N/A | Set the `net.ipv4.tcp_keepalive_time` setting to 180 seconds for compatibility with VPC gateways. |
| Ubuntu 18.04 packages | 4.15.0-143 | 4.15.0-144 | Updated worker node images with kernel package updates for [CVE-2021-25217](https://nvd.nist.gov/vuln/detail/CVE-2021-25217){: external}, [CVE-2021-31535](https://nvd.nist.gov/vuln/detail/CVE-2021-31535){: external}, [CVE-2021-32547](https://nvd.nist.gov/vuln/detail/CVE-2021-32547){: external}, [CVE-2021-32552](https://nvd.nist.gov/vuln/detail/CVE-2021-32552){: external}, [CVE-2021-32556](https://nvd.nist.gov/vuln/detail/CVE-2021-32556){: external}, [CVE-2021-32557](https://nvd.nist.gov/vuln/detail/CVE-2021-32557){: external}, [CVE-2021-3448](https://nvd.nist.gov/vuln/detail/CVE-2021-3448){: external}, and [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1564" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1564, released 24 May 2021
{: #11717_1564}

The following table shows the changes that are in the worker node fix pack `1.17.17_1564`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | e0fa2f | 26c5cc | Updated image with fixes for [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2019-18276](https://nvd.nist.gov/vuln/detail/CVE-2019-18276){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, and [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external}. |
| Ubuntu 18.04 packages | 4.15.0-142 | 4.15.0-143 | Updated worker node images with kernel package updates for [CVE-2021-28688](https://nvd.nist.gov/vuln/detail/CVE-2021-28688){: external}, [CVE-2021-20292](https://nvd.nist.gov/vuln/detail/CVE-2021-20292){: external}, [CVE-2021-29264](https://nvd.nist.gov/vuln/detail/CVE-2021-29264){: external}, [CVE-2021-29265](https://nvd.nist.gov/vuln/detail/CVE-2021-29265){: external}, and [CVE-2021-29650](https://nvd.nist.gov/vuln/detail/CVE-2021-29650){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2009-5155](https://nvd.nist.gov/vuln/detail/CVE-2009-5155){: external} and [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1562" caption-side="top"}

### Changelog for master fix pack 1.17.17_1563, released 24 May 2021
{: #11717_1563}

The following table shows the changes that are in the master fix pack patch update `1.17.17_1563`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.21 | v1.1.22 | Updated image to implement additional IBM security controls and for [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}, [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| Gateway-enabled cluster controller | 1322 | 1352 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| IBM Calico extension | 618 | 689 | Updated to use `Go` version 1.15.12. Updated image to implement additional IBM security controls and for [CVE-2020-14391](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14391){: external}, [CVE-2020-25661](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25661){: external} and [CVE-2020-25662](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25662){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 390 | 392 | Improved the pre-requisite validation logic for provisioning persistent volume claims (PVCs). Updated image to implement additional IBM security controls and for [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| Key Management Service provider | v1.0.12 | v1.0.14 | Updated image to implement additional IBM security controls and for [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external} and [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1274 | 1328 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
{: caption="Changes since version 1.17.17_1560" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1562, released 10 May 2021
{: #11717_1562}

The following table shows the changes that are in the worker node fix pack `1.17.17_1562`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1561" caption-side="top"}

### Changelog for master fix pack 1.17.17_1560, released 27 April 2021
{: #11717_1560}

The following table shows the changes that are in the master fix pack patch update `1.17.17_1560`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.19 | v1.1.21 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| GPU device plug-in and installer | 65e4401 | 4aa248d | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 389 | 390 | Updated to use `Go` version 1.15.9 and for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external} and [CVE-2021-3121](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3121){: external}. |
| Key Management Service provider | v1.0.10 | v1.0.12 | Updated to use `Go` version 1.15.11 and for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-386 | Updated image to implement additional IBM security controls. |
| OpenVPN server | 2.4.6-r3-IKS-301 | 2.4.6-r3-IKS-385 | Updated image to implement additional IBM security controls. |
| Operator Lifecycle Manager | 0.14.1-IKS-4 | 0.14.1-IKS-8 | Updated image for [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external}, [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}, and [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1557" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1561, released 26 April 2021
{: #11717_1561}

The following table shows the changes that are in the worker node fix pack `1.17.17_1561`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | a3b1ff | e0fa2f | The update addresses [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Added resiliency to `systemd` units to prevent failures situations where the worker nodes are overused.<br><br>Updated worker node images with kernel and package updates for [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}, and [CVE-2021-3348](https://nvd.nist.gov/vuln/detail/CVE-2021-3348){: external}. |
| Ubuntu 16.04 packages |4.4.0-206 | 4.4.0-210 | Updated worker node images with kernel and package updates for [[CVE-2015-1350](https://nvd.nist.gov/vuln/detail/CVE-2015-1350){: external}, [CVE-2017-15107](https://nvd.nist.gov/vuln/detail/CVE-2017-15107){: external}, [CVE-2017-5967](https://nvd.nist.gov/vuln/detail/CVE-2017-5967){: external}, [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2018-5953](https://nvd.nist.gov/vuln/detail/CVE-2018-5953){: external}, [CVE-2019-14513](https://nvd.nist.gov/vuln/detail/CVE-2019-14513){: external}, [CVE-2019-16231](https://nvd.nist.gov/vuln/detail/CVE-2019-16231){: external}, [CVE-2019-16232](https://nvd.nist.gov/vuln/detail/CVE-2019-16232){: external}, [CVE-2019-19061](https://nvd.nist.gov/vuln/detail/CVE-2019-19061){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, and [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1559" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1559, released 12 April 2021
{: #11717_1559}

The following table shows the changes that are in the worker node fix pack `1.17.17_1559`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 9b2dca | a3b1ff | The update addresses [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external} and [CVE-2021-3450](https://nvd.nist.gov/vuln/detail/CVE-2021-3450){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1558" caption-side="top"}

### Changelog for master fix pack 1.17.17_1557, released 30 March 2021
{: #11717_1557}

The following table shows the changes that are in the master fix pack patch update `1.17.17_1557`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.at_short}} event | N/A | N/A | Now, the `containers-kubernetes.version.update` event is sent to {{site.data.keyword.at_short}} when a master fix pack update is initiated for a cluster. |
| Cluster health image | v1.1.18 | v1.1.19 | Updated image for [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}. |
| Gateway-enabled cluster controller | 1232 | 1322 | Updated to use `Go` version 1.15.10 and for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
| GPU device plug-in | 4d3b934f | 65e4401 | Updated image for [CVE-2021-27919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-27919){: external}, [CVE-2020-28851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28851){: external}, and [CVE-2020-28852](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28852){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 388 | 389 | Updated to use `Go` version 1.15.8. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1165 | 1274 | Fixed a bug that might cause version 2.0 network load balancers (NLBs) to crash and restart on load balancer updates. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1555" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1558, released 29 March 2021
{: #11717_1558}

The following table shows the changes that are in the worker node fix pack `1.17.17_1558`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-136-generic | 4.15.0-140-generic | Updated worker node images with kernel and package updates for [CVE-2020-27170](https://nvd.nist.gov/vuln/detail/CVE-2020-27170){: external}, [CVE-2020-27171](https://nvd.nist.gov/vuln/detail/CVE-2020-27171){: external}, [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, and [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external}. |
| Ubuntu 16.04 packages | 4.4.0-203-generic | 4.4.0-206-generic | Updated worker node images with kernel and package updates for [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, and [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1556" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1556, released 12 March 2021
{: #11717_1556}

The following table shows the changes that are in the worker node fix pack `1.17.17_1556`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.9 | 1.3.10 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.10){: external}. The update resolves CVE-2021-21334 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6433475){: external}). |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-24031](https://nvd.nist.gov/vuln/detail/CVE-2021-24031){: external}, [CVE-2021-24032](https://nvd.nist.gov/vuln/detail/CVE-2021-24032){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, and [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for{: external}, [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1555" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1555, released 1 March 2021
{: #11717_1555_worker}

The following table shows the changes that are in the worker node fix pack `1.17.17_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-135-generic | 4.15.0-136-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
| Ubuntu 16.04 packages | 4.4.0-201-generic | 4.4.0-203-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1553" caption-side="top"}

### Changelog for master fix pack 1.17.17_1555, released 22 February 2021
{: #11717_1555}

The following table shows the changes that are in the master fix pack patch update `1.17.17_1555`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.16 | v1.1.18 | Updated to use `Go` version 1.15.7. Updated image to implement additional IBM security controls. |
| Gateway-enabled cluster controller | 1195 | 1232 | Updated to use `Go` version 1.15.7. |
| IBM Calico extension | 567 | 618 | Updated to use `Go` version 1.15.7. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.17-1 | v1.17.17-6 | Updated image for for [DLA-2509-1](https://www.debian.org/lts/security/2020/dla-2509){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 385 | 388 | Improved the retry logic for provisioning persistent volume claims (PVCs). |
| Key Management Service provider | v1.0.7 | v1.0.10 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1078 | 1165 | Updated to use `Go` version 1.15.7. |
| Operator Lifecycle Manager | 0.14.1-IKS-2 | 0.14.1-IKS-4 | Updated image for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1551" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1553, released 15 February 2021
{: #11717_1553}

The following table shows the changes that are in the worker node fix pack `1.17.17_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1552" caption-side="top"}
### Changelog for worker node fix pack 1.17.17_1552, released 1 February 2021
{: #11717_1552}

The following table shows the changes that are in the worker node fix pack `1.17.17_1552`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | 4.4.0-200-generic | 4.4.0-201-generic | Updated worker node image with kernel and package updates for [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
| Ubuntu 18.04 packages | 4.15.0-132-generic | 4.15.0-135-generic | Updated worker node image with kernel and package updates for [CVE-2019-12761](https://nvd.nist.gov/vuln/detail/CVE-2019-12761){: external}, [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.17_1551" caption-side="top"}

### Changelog for master fix pack 1.17.17_1551, released 19 January 2021
{: #11717_1551_master}

The following table shows the changes that are in the master fix pack patch update `1.17.17_1551`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.13 | v1.1.16 | Updated image to implement additional IBM security controls. |
| Gateway-enabled cluster controller | 1184 | 1195 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| GPU device plug-in and installer | adcae42 | 4d3b934f | Updated image for [CVE-2021-3114](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3114){: external}, [CVE-2021-3115](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3115){: external}, [CVE-2020-27350](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350){: external}, [CVE-2020-29361](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29361){: external}, [CVE-2020-29362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29362){: external}, [CVE-2020-29363](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29363){: external}, [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8284](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8284){: external}, [CVE-2020-8285](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8285){: external}, and [CVE-2020-8286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8286){: external}. |
| IBM Calico extension | 556 | 567 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.16-1 | v1.17.17-1 | Updated to support the Kubernetes 1.17.17 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 384 | 385 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Key Management Service provider | v1.0.5 | v1.0.7 | Fixed bug to ignore conflict errors during KMS secret reencryption. Updated to use `Go` version 1.15.5. Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Kubernetes | v1.17.16 | v1.17.17 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.17){: external}.  Updated to implement additional IBM security controls. |
| Kubernetes Dashboard | v2.0.4 | v2.0.5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.5){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.4 | v1.0.6 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1004 | 1078 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.16_1550" caption-side="top"}

### Changelog for worker node fix pack 1.17.17_1551, released 18 January 2021
{: #11717_1551}

The following table shows the changes that are in the worker node fix pack `1.17.17_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.17.15 | v1.17.17 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.17){: external}. |
| Ubuntu 16.04 packages | 4.4.0-197-generic | 4.4.0-200-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361) external}, and [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362) external}. |
| Ubuntu 18.04 packages | 4.15.0-128-generic | 4.15.0-132-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2021-1052](https://nvd.nist.gov/vuln/detail/CVE-2021-1052){: external}, [CVE-2021-1053](https://nvd.nist.gov/vuln/detail/CVE-2021-1053){: external}, and [CVE-2019-19770](https://nvd.nist.gov/vuln/detail/CVE-2019-19770){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.15_1549" caption-side="top"}

### Changelog for master fix pack 1.17.16_1550, released 6 January 2021
{: #11716_1550}

The following table shows the changes that are in the master fix pack patch update `1.17.16_1550`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Calico extension | 544 | 556 | Updated image to include the `ip` command. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.15-1 | v1.17.16-1 | Updated to support the Kubernetes 1.17.16 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | N/A | N/A | Updated to run with a privileged security context. |
| Kubernetes | v1.17.15 | v1.17.16 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.16){: external}. |
| Operator Lifecycle Manager | 0.14.1-IKS-1 | 0.14.1-IKS-2 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.15_1548" caption-side="top"}
### Changelog for worker node fix pack 1.17.15_1549, released 21 December 2020
{: #11715_1549}

The following table shows the changes that are in the worker node fix pack `1.17.15_1549`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ubuntu 18.04 packages | 4.15.0-126-generic | 4.15.0-128-generic | Updated worker node image with kernel and package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Kubernetes | v1.17.14 | v1.17.15 | See the [Kubernetes changelogs.](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.15){: external} |
| Ephemeral storage reservations | N/A | N/A | Reserve local ephemeral storage to prevent workload evictions. |
| HAProxy | db4e6d | 9b2dca | Image update for [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external} and [CVE-2020-24659](https://nvd.nist.gov/vuln/detail/CVE-2020-24659){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.15_1548" caption-side="top"}

### Changelog for master fix pack 1.17.15_1548, released 14 December 2020
{: #11715_1548}

The following table shows the changes that are in the master fix pack patch update `1.17.15_1548`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| CoreDNS | 1.6.9 | 1.8.0 | See the [CoreDNS release notes](https://coredns.io/2020/10/22/coredns-1.8.0-release/){: external}. Additionally, updated the CoreDNS configuration to increase the weight of scheduling CoreDNS pods to different worker nodes and zones. |
| etcd | v3.4.13 | v3.4.14 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.14){: external}. |
| Gateway-enabled cluster controller | 1105 | 1184 | Updated to use `Go` version 1.15.5. Updated image to implement additional IBM security controls. |
| GPU device plug-in and installer | c7a8cf7 | adcae42 | Updated the GPU drivers to version [450.80.02](https://www.nvidia.com/download/driverResults.aspx/165294){: external}. Updated image for [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}, [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}, and [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}. Updated image to implement additional IBM security controls. |
| IBM Calico extension | 378 | 544 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.5. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.14-1 | v1.17.15-1 | Updated to support the Kubernetes 1.17.15 release. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.filestorage_full_notm}} monitor | 379 | 384 | Updated to use `Go` version 1.15.5 and to run as a non-root user. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 379 | 384 | Updated to use `Go` version 1.15.5 and to run with a least privileged security context. Updated image to implement additional IBM security controls. |
| Key management service (KMS) provider | v1.0.4 | v1.0.5 | Updated image to implement additional IBM security controls. |
| Kubernetes | v1.17.14 | v1.17.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.15){: external}. |
| Kubernetes `NodeLocal` DNS cache | N/A | N/A | Updated the `NodeLocal` DNS cache configuration to support [customizing the `node-local-dns` config map](/docs/containers?topic=containers-cluster_dns#dns_nodelocal_customize). |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 208 | 1004 | Updated Alpine base image to version 3.12 and to use `Go` version 1.15.5. Updated image for [CVE-2020-8037](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8037){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. Updated image to implement additional IBM security controls. |
| OpenVPN client | 2.4.6-r3-IKS-116 | 2.4.6-r3-IKS-301 | Updated image to implement additional IBM security controls. |
| OpenVPN server | 2.4.6-r3-IKS-222 | 2.4.6-r3-IKS-301 | Updated image to implement additional IBM security controls. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.14_1545" caption-side="top"}

### Changelog for worker node fix pack 1.17.14_1548, released 11 December 2020
{: #11714_1548}

The following table shows the changes that are in the worker node fix pack `1.17.14_1548`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 bare metal kernel | 4.15.0-126-generic | 4.15.0-123-generic | **Bare metal worker nodes**: Reverted the kernel version for bare metal worker nodes while Canonical addresses issues with the previous version that prevented worker nodes from being reloaded or updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.14_1546" caption-side="top"}

### Changelog for worker node fix pack 1.17.14_1546, released 7 December 2020
{: #11714_1546}

The following table shows the changes that are in the worker node fix pack `1.17.14_1546`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.4 | 1.3.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.9){: external}. The update resolves CVE-2020–15257 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6387878){: external}). |
| HAProxy | 1.8.26-384f42 | db4e6d | Added provenance labels for source tracking. |
| Ubuntu 18.04 packages | 4.15.0-123-generic | 4.15.0-126-generic | Updated worker node image with   kernel and package updates for [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external} and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
| Ubuntu 16.04 packages | 4.4.0-194-generic | 4.4.0-197-generic | Updated worker node image with kernel and package updates for [CVE-2020-0427](https://nvd.nist.gov/vuln/detail/CVE-2020-0427){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external}, [CVE-2020-25645](https://nvd.nist.gov/vuln/detail/CVE-2020-25645){: external}, and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.14_1545" caption-side="top"}

### Changelog for worker node fix pack 1.17.14_1545, released 23 November 2020
{: #11714_1545_worker}

The following table shows the changes that are in the worker node fix pack `1.17.14_1545`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.17.13 | v1.17.14 | See the [Kubernetes changelog](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.17.md#v11714){: external}.|
| Ubuntu 18.04 packages | 4.15.0-122-generic | 4.15.0-123-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
| Ubuntu 16.04 packages | 4.4.0-193-generic | 4.4.0-194-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.13_1544" caption-side="top"}

### Changelog for master fix pack 1.17.14_1545, released 16 November 2020
{: #11714_1545}

The following table shows the changes that are in the master fix pack patch update `1.17.14_1545`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.12 | v1.1.13 | Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| GPU device plug-in and installer | edd26a4 | c7a8cf7 | Updated image for [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2020-8177](https://nvd.nist.gov/vuln/detail/CVE-2020-8177){: external}, [CVE-2019-14889](https://nvd.nist.gov/vuln/detail/CVE-2019-14889){: external}, [CVE-2020-1730](https://nvd.nist.gov/vuln/detail/CVE-2020-1730){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}, [CVE-2019-5018](https://nvd.nist.gov/vuln/detail/CVE-2019-5018){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, [CVE-2020-13631](https://nvd.nist.gov/vuln/detail/CVE-2020-13631){: external}, [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}, [CVE-2020-6405](https://nvd.nist.gov/vuln/detail/CVE-2020-6405){: external}, [CVE-2020-9327](https://nvd.nist.gov/vuln/detail/CVE-2020-9327){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-19221](https://nvd.nist.gov/vuln/detail/CVE-2019-19221){: external}, [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}, [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-20454](https://nvd.nist.gov/vuln/detail/CVE-2019-20454){: external}, [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2018-20843](https://nvd.nist.gov/vuln/detail/CVE-2018-20843){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, and [CVE-2019-20387](https://nvd.nist.gov/vuln/detail/CVE-2019-20387){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.13-1 | v1.17.14-1 | Updated to support the Kubernetes 1.17.14 release. Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 378 | 379 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.2. |
| Key Management Service provider | v1.0.3 | v1.0.4 | Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| Kubernetes | v1.17.13 | v1.17.14 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.14){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.13_1543" caption-side="top"}

### Changelog for worker node fix pack 1.17.13_1544, released 9 November 2020
{: #11713_1544}

The following table shows the changes that are in the worker node fix pack `1.17.13_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with kernel and package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}, and [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}. |
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, and [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.13_1543" caption-side="top"}

### Changelog for worker node fix pack 1.17.13_1543, released 26 October 2020
{: #11713_1543_worker}

The following table shows the changes that are in the worker node fix pack `1.17.13_1543`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.17.12 | v1.17.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.13){: external}. |
|Ubuntu 18.04 packages | 4.15.0-118-generic | 4.15.0-122-generic | Updated worker node images with kernel and package updates for [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external},[CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2019-20916](https://nvd.nist.gov/vuln/detail/CVE-2019-20916){: external}, [CVE-2020-12351](https://nvd.nist.gov/vuln/detail/CVE-2020-12351){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, [CVE-2020-16120](https://nvd.nist.gov/vuln/detail/CVE-2020-16120){: external}, [CVE-2020-24490](https://nvd.nist.gov/vuln/detail/CVE-2020-24490){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
|Ubuntu 16.04 packages | 4.4.0-190-generic | 4.4.0-193-generic | Updated worker node images with kernel and package updates for [CVE-2017-17087](https://nvd.nist.gov/vuln/detail/CVE-2017-17087){: external}, [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external}, [CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.12_1542" caption-side="top"}

### Changelog for master fix pack 1.17.13_1543, released 26 October 2020
{: #11713_1543}

The following table shows the changes that are in the master fix pack patch update `1.17.13_1543`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Updated the `calico-node` daemon set in the `kube-system` namespace to set the `spec.updateStrategy.rollingUpdate.maxUnavailable` parameter to `10%` for clusters with more than 50 worker nodes. |
| Cluster health image | v1.1.11 | v1.1.12 | Updated to use `Go` version 1.15.2. |
| Gateway-enabled cluster controller | 1082 | 1105 | Updated to use `Go` version 1.15.2. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.12-1 | v1.17.13-1 | Updated to support the Kubernetes 1.17.13 release. |
| Kubernetes | v1.17.12 | v1.17.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.13){: external}. |
| Kubernetes `NodeLocal` DNS cache | 1.15.13 | 1.15.14 | See the [Kubernetes `NodeLocal` DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.14){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.12_1540" caption-side="top"}

### Changelog for worker node fix pack 1.17.12_1542, released 12 October 2020
{: #11712_1542}

The following table shows the changes that are in the worker node fix pack `1.17.12_1542`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2019-8936](https://nvd.nist.gov/vuln/detail/CVE-2019-8936){: external}, [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}, and [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external}.|
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external} and [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.12_1541" caption-side="top"}

### Changelog for worker node fix pack 1.17.12_1541, released 28 September 2020
{: #11712_1541}

The following table shows the changes that are in the worker node fix pack `1.17.12_1541`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.17.11    | v1.17.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.12){: external}. |
| Ubuntu 18.04 packages | 4.15.0-117-generic | 4.15.0-118-generic | Updated worker node image with   kernel and package updates for [CVE-2018-1000500](https://nvd.nist.gov/vuln/detail/CVE-2018-1000500){: external}, [CVE-2018-7738](https://nvd.nist.gov/vuln/detail/CVE-2018-7738){: external}, [CVE-2019-14855](https://nvd.nist.gov/vuln/detail/CVE-2019-14855){: external}, [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, [CVE-2020-10753](https://nvd.nist.gov/vuln/detail/CVE-2020-10753){: external}, [CVE-2020-12059](https://nvd.nist.gov/vuln/detail/CVE-2020-12059){: external}, [CVE-2020-12888](https://nvd.nist.gov/vuln/detail/CVE-2020-12888){: external}, [CVE-2020-1760](https://nvd.nist.gov/vuln/detail/CVE-2020-1760){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}.|
| Ubuntu 16.04 packages | 4.4.0-189-generic | 4.4.0-190-generic | Updated worker node image with kernel and package updates for [CVE-2019-20811](https://nvd.nist.gov/vuln/detail/CVE-2019-20811){: external}, [CVE-2019-9453](https://nvd.nist.gov/vuln/detail/CVE-2019-9453){: external}, [CVE-2020-0067](https://nvd.nist.gov/vuln/detail/CVE-2020-0067){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.11_1539" caption-side="top"}

### Changelog for master fix pack 1.17.12_1540, released 21 September 2020
{: #11712_1540}

The following table shows the changes that are in the master fix pack patch update `1.17.12_1540`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.9 | v1.1.11 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. |
| etcd | v3.4.10 | v3.4.13 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.13){: external}. |
| GPU device plug-in and installer | bacb9e1 | edd26a4 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. Updated the GPU drivers to version [450.51.06](https://www.nvidia.com/download/driverResults.aspx/162630){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.9-1 | v1.17.12-1 | Updated to support the Kubernetes 1.17.12 release and to use `Go` version 1.13.15. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 377 | 378 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external}. |
| Key Management Service provider | v1.0.1 | v1.0.3 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. |
| Kubernetes | v1.17.11 | v1.17.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.12){: external}. |
| Kubernetes Dashboard | v2.0.3 | v2.0.4 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.4){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.11_1539" caption-side="top"}

### Changelog for worker node fix pack 1.17.11_1539, released 14 September 2020
{: #11711_1539}

The following table shows the changes that are in the worker node fix pack `1.17.11_1539`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-384f42 | 1.8.26-561f1a | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.|
| Ubuntu 18.04 packages | 4.15.0-112-generic | 4.15.0-117-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external}, [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}, and [CVE-2020-14386](https://nvd.nist.gov/vuln/detail/CVE-2020-14386){: external}. |
| Ubuntu 16.04 packages | 4.4.0-187-generic | 4.4.0-189-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external} and [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.11_1538" caption-side="top"}

### Changelog for worker node fix pack 1.17.11_1538, released 31 August 2020
{: #11711_1538}

The following table shows the changes that are in the worker node fix pack `1.17.11_1538`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-12403](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12403){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}, and [CVE-2020-8624](https://nvd.nist.gov/vuln/detail/CVE-2020-8624){: external}. |
| Ubuntu 16.04 packages | 4.4.0-186-generic | 4.4.0-187-generic | Updated worker node image with kernel and package updates for [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, and [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.11_1537" caption-side="top"}

### Changelog for master fix pack 1.17.11_1537, released 18 August 2020
{: #11711_1537_master}

The following table shows the changes that are in the master fix pack patch update `1.17.11_1537`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster health image | v1.1.8 | v1.1.9 | Updated to use `Go` version 1.13.13. |
| etcd | v3.4.9 | v3.4.10 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.10){: external}. |
| GPU device plug-in and installer | 8c24345 | bacb9e1 | Updated image for [CVE-2020-14039](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14039){: external} and [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 376 | 377 | Fixed a bug that prevents persistent volume claim (PVC) creation failures from being retried. |
| Key Management Service provider | v1.0.0 | v1.0.1 | Updated image for [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| Kubernetes | v1.17.9 | v1.17.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.11){: external}. |
| Kubernetes add-on resizer | 1.8.5 | 1.8.11 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.11){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing of all API groups except `apiregistration.k8s.io` and `coordination.k8s.io`. |
| Kubernetes Metrics Server | v0.3.6 | v0.3.7 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.7){: external}. |
| Kubernetes `NodeLocal` DNS cache configuration | N/A | N/A | Increased the pod termination grace period. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.9_1535" caption-side="top"}

### Changelog for worker node fix pack 1.17.11_1537, released 17 August 2020
{: #11711_1537}

The following table shows the changes that are in the worker node fix pack `1.17.11_1537`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.17.9 | v1.17.11 | See the [Kubernetes changelogs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.17.md#v11711){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-12400](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12400){: external}, [CVE-2020-12401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12401){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}, and [CVE-2020-6829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6829){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, and [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.9_1535" caption-side="top"}

### Changelog for worker node fix pack 1.17.9_1535, released 3 August 2020
{: #1179_1535}

The following table shows the changes that are in the worker node fix pack `1.17.9_1535`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-111-generic | 4.15.0-112-generic | Updated worker node images with kernel and package updates for [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-10757](https://nvd.nist.gov/vuln/detail/CVE-2020-10757){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
| Ubuntu 16.04 packages | 4.4.0-185-generic | 4.4.0-186-generic | Updated worker node images with package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.9_1532" caption-side="top"}

### Changelog for master fix pack 1.17.9_1534, released 24 July 2020
{: #1179_1534}

The following table shows the changes that are in the master fix pack patch update `1.17.9_1534`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master operations | N/A | N/A | Fixed a problem that might cause pods to fail authentication to the Kubernetes API server after a cluster master operation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 375 | 376 | Updated to use `Go` version 1.13.8. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.9_1533" caption-side="top"}

### Changelog for master fix pack 1.17.9_1533, released 20 July 2020
{: #1179_1533}

The following table shows the changes that are in the master fix pack patch update `1.17.9_1533`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 31d4bb6 | 8c24345 | Updated image for [CVE-2017-12133](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12133){: external}, [CVE-2017-18269](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18269){: external}, [CVE-2018-11236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11236){: external}, [CVE-2018-11237](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11237){: external}, [CVE-2018-19591](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19591){: external}, [CVE-2018-6485](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6485){: external}, [CVE-2019-19126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19126){: external}, [CVE-2019-9169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9169){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, and [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}. |
| IBM Calico extension | 353 | 378 | Updated to handle any `ens` network interface. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.7-1 | v1.17.9-1 | Updated to support the Kubernetes 1.17.9 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor configuration | N/A | N/A | Added a pod memory limit. |
| Kubernetes | v1.17.7 | v1.17.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.9){: external}. The update resolves CVE-2020-8559 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249915){: external}). |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `scheduling.k8s.io` API group and the `tokenreviews` resource. |
| Kubernetes Dashboard | v2.0.1 | v2.0.3 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.3){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-131 | 2.4.6-r3-IKS-222 | Removed the deprecated `comp-lzo` compression configuration option and updated the default cipher that is used for encryption. |
| Operator Lifecycle Manager | 0.14.1 | 0.14.1-IKS-1 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.7_1530" caption-side="top"}

### Changelog for worker node fix pack 1.17.9_1532, released 20 July 2020
{: #1179_1532}

The following table shows the changes that are in the worker node fix pack `1.17.9_1532`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 2.0.15-afe432 | 1.8.25-384f42 | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Fixes a connection leak that happens when HAProxy is under high load. |
| Kubernetes | v1.17.7 | v1.17.9 | See the [Kubernetes changelogs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.17.md#v1179){: external}. The update resolves CVE-2020-8557 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249941){: external}). |
| Ubuntu 18.04 packages | 4.15.0-109-generic | 4.15.0-111-generic | Updated worker node images with kernel and package updates for [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-19591](https://nvd.nist.gov/vuln/detail/CVE-2018-19591){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-12402](https://nvd.nist.gov/vuln/detail/CVE-2020-12402){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
| Ubuntu 16.04 packages | 4.4.0-184-generic | 4.4.0-185-generic | Updated worker node images with package updates for [CVE-2017-12133](https://nvd.nist.gov/vuln/detail/CVE-2017-12133){: external}, [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}, [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-6485](https://nvd.nist.gov/vuln/detail/CVE-2018-6485){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.7_1530" caption-side="top"}

### Changelog for worker node fix pack 1.17.7_1530, released 6 July 2020
{: #1177_1530}

The following table shows the changes that are in the worker node fix pack `1.17.7_1530`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-30b675 | 2.0.15-afe432 | See the [HAProxy changelog](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}. |
| Ubuntu 18.04 packages | 4.15.0-106-generic | 4.15.0-109-generic | Updated worker node images with kernel and package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-16089](https://nvd.nist.gov/vuln/detail/CVE-2019-16089){: external}, [CVE-2019-19036](https://nvd.nist.gov/vuln/detail/CVE-2019-19036){: external}, [CVE-2019-19039](https://nvd.nist.gov/vuln/detail/CVE-2019-19039){: external}, [CVE-2019-19318](https://nvd.nist.gov/vuln/detail/CVE-2019-19318){: external}, [CVE-2019-19642](https://nvd.nist.gov/vuln/detail/CVE-2019-19642){: external}, [CVE-2019-19813](https://nvd.nist.gov/vuln/detail/CVE-2019-19813){: external}, [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-19377](https://nvd.nist.gov/vuln/detail/CVE-2019-19377){: external}, and [CVE-2019-19816](https://nvd.nist.gov/vuln/detail/CVE-2019-19816){: external}. |
| Ubuntu 16.04 packages | N/A|N/A | Updated worker node images with package updates for [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external} and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}. |
| Worker node `drain` automation | N/A|N/A | Fixes a race condition that can cause worker node `drain` automation to fail. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.7_1529" caption-side="top"}

### Changelog for 1.17.7_1529, released 22 June 2020
{: #1177_1529}

The following table shows the changes that are in the master and worker node update `1.17.7_1529`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Calico | Master | v3.12.1 | v3.12.2 | See the [Calico release notes](https://docs.projectcalico.org/releases){: external}. The master update resolves CVE-2020-13597 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6226322){: external}). |
| Cluster health image | Master | v1.1.5 | v1.1.8 | Additional status information is included when an add-on health state is `critical`. Improved performance when handling cluster status updates. |
| Cluster master operations | Master | N/A | N/A | Cluster master operations such as `refresh` or `update` are now canceled if a broken [Kubernetes admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} is detected. |
| etcd | Master | v3.4.7 | v3.4.9 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.9){: external}. |
| GPU device plug-in and installer | Master | 8b02302 | 31d4bb6 | Updated image for [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.17.6-1 | v1.17.7-1 | Updated to support the Kubernetes 1.17.7 release. Updated the version 2.0 private network load balancers (NLBs) to manage Calico global network policies. Updated `calicoctl` version to 3.12.2. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | Master | 373 | 375 | Fixed a bug that might cause error handling to create additional persistent volumes. |
| Kubernetes | Both | v1.17.6 | v1.17.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.7){: external}. The master update resolves CVE-2020-8558 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249905){: external}). |
| Kubernetes configuration | Master | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `apiextensions.k8s.io` API group and the `persistentvolumeclaims` and `persistentvolumes` resources. Additionally, the `http2-max-streams-per-connection` option is set to `1000` to mitigate network disruption impacts on the `kubelet` connection to the API server. |
| Kubernetes Dashboard | Master | v2.0.0 | v2.0.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.1){: external}. |
| Ubuntu 18.04 packages | Worker | 4.15.0-101-generic | 4.15.0-106-generic | Updated worker node images with kernel and package updates for [CVE-2018-8740](https://nvd.nist.gov/vuln/detail/CVE-2018-8740){: external}, [CVE-2019-17023](https://nvd.nist.gov/vuln/detail/CVE-2019-17023){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-12399](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12399){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-179-generic | 4.4.0-184-generic | Updated worker node images with package and kernel updates for [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12769](https://nvd.nist.gov/vuln/detail/CVE-2020-12769){: external}, [CVE-2020-1749](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1749){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and[CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.6_1527" caption-side="top"}

### Changelog for worker node fix pack 1.17.6_1527, released 8 June 2020
{: #1176_1527}

The following table shows the changes that are in the worker node fix pack `1.17.6_1527`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1549](https://nvd.nist.gov/vuln/detail/CVE-2019-1549){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.6_1526" caption-side="top"}

### Changelog for 1.17.6_1526, released 26 May 2020
{: #1176_1526}

The following table shows the changes that are in the master and worker node update `1.17.6_1526`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | v1.1.1 | v1.1.4 | When cluster add-ons don't support the current cluster version, a warning is now returned in the cluster health state. |
| etcd | Master | v3.4.3 | v3.4.7 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.7){: external}. |
| Gateway-enabled cluster controller | Master | 1045 | 1082 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| GPU device plug-in and installer | Master | 8c6538f | 8b02302 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| IBM Calico extension | Master | 320 | 353 | Skips creating a Calico host endpoint when no endpoint is needed. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.17.5-1 | v1.17.6-1 | Updated to support the Kubernetes 1.17.6 release. Updated network load balancer (NLB) events to use the latest {{site.data.keyword.cloud_notm}} troubleshooting documentation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 358 | 373 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external} and [CVE-2020-11655](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11655){: external}. |
| Kubernetes | Both | v1.17.5 | v1.17.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.6){: external}. |
| Kubernetes Dashboard | Master | v2.0.0-rc7 | v2.0.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0){: external}. |
| Kubernetes Metrics Server | Master | N/A | N/A | Increased the CPU per node for the `metrics-server` container to improve availability of the metrics server API service for large clusters. |
| Kubernetes NodeLocal DNS cache | Master | 1.15.8 | 1.15.13 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.13){: external}. Updated the `node-local-dns` daemon set to include the `prometheus.io/port` and `prometheus.io/scrape` annotations on the pods. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 177 | 208 | Updated the version 2.0 network load balancers (NLB) to clean up unnecessary IPVS rules. Improved application logging. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | Worker | 4.15.0-99-generic | 4.15.0-101-generic | Updated worker node images with kernel and package updates for [CVE-2019-20795](https://nvd.nist.gov/vuln/detail/CVE-2019-20795){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616), and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.5_1524" caption-side="top"}

### Changelog for worker node fix pack 1.17.5_1524, released 11 May 2020
{: #1175_1524}

The following table shows the changes that are in the worker node fix pack `1.17.5_1524`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1523" caption-side="top"}

### Changelog for worker node fix pack 1.17.5_1523, released 27 April 2020
{: #1175_1523}

The following table shows the changes that are in the worker node fix pack `1.17.5_1523`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.3 | v1.3.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.4){: external}. |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Kubernetes | v1.17.4 | v1.17.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.5){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1521" caption-side="top"}

### Changelog for master fix pack 1.17.5_1522, released 23 April 2020
{: #1175_1522}

The following table shows the changes that are in the master fix pack patch update `1.17.5_1522`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.4-3 | v1.17.5-1 | Updated to support the Kubernetes 1.17.5 release and to use `Go` version 1.13.9. |
| Kubernetes | v1.17.4 | v1.17.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.5){: external}. The update resolves CVE-2020-8555 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6220220){: external}). |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1521" caption-side="top"}

### Changelog for master fix pack 1.17.4_1521, released 17 April 2020
{: #1174_1521_master}

The following table shows the changes that are in the master fix pack patch update `1.17.4_1521`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.12.0 | v3.12.1 | See the [Calico release notes](https://docs.projectcalico.org/release-notes/){: external}. Updated to allow egress from the worker nodes via the `allow-vrrp` `GlobalNetworkPolicy`. |
| CoreDNS | 1.6.7 | 1.6.9 | See the [CoreDNS release notes](https://coredns.io/2020/03/24/coredns-1.6.9-release/){: external}. Fixed a bug during Corefile migration that might generate invalid data that makes CoreDNS pods fail. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.17.4-1 | v1.17.4-3 | Updated to use `calicoctl` version 3.12.1. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| Kubernetes Dashboard | v2.0.0-rc5 | v2.0.0-rc7 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc7){: external}. Added a readiness probe to the Kubernetes Dashboard configuration. |
| Kubernetes Dashboard metrics scraper | v1.0.3 | v1.0.4 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.4){: external}. |
| OpenVPN client | N/A | N/A | Fixed problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
| Operator Lifecycle Manager Catalog | v1.5.11 | v1.6.1 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.6.1){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1520" caption-side="top"}

### Changelog for worker node fix pack 1.17.4_1521, released 13 April 2020
{: #1174_1521}

The following table shows the changes that are in the worker node fix pack `1.17.4_1521`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1520" caption-side="top"}

### Changelog for worker node fix pack 1.17.4_1520, released 30 March 2020
{: #1174_1520}

The following table shows the changes that are in the worker node fix pack `1.17.4_1520`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.4_1519" caption-side="top"}

### Changelog for 1.17.4_1519, released 16 March 2020
{: #1174_1519}

The following table shows the changes that are in the master and worker node update `1.17.4_1519`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | N/A | N/A | Cluster health status now includes links to {{site.data.keyword.cloud_notm}} documentation. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.17.3-1 | v1.17.4-1 | Updated to support the Kubernetes 1.17.4 release and to use `Go` version 1.13.8. Fixed VPC load balancer error message to use the current {{site.data.keyword.containerlong_notm}} plug-in CLI syntax. |
| Kubernetes | Both | v1.17.3 | v1.17.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 169 | 177 | Version 2.0 network load balancers (NLB) were updated to fix problems with long-lived network connections to endpoints that failed readiness probes. |
| Operator Lifecycle Manager Catalog | Master | v1.5.9 | v1.5.11 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.11){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | Worker |N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.3_1518" caption-side="top"}

### Changelog for worker node fix pack 1.17.3_1518, released 2 March 2020
{: #1173_1518}

The following table shows the changes that are in the worker node fix pack 1.17.3_1518. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU worker node provisioning | N/A | N/A | Fixed bug where new GPU worker nodes could not automatically join clusters that run Kubernetes version 1.16 or 1.17. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.3_1516" caption-side="top"}

### Changelog for fix pack 1.17.3_1516, released 17 February 2020
{: #1173_1516}

The following table shows the changes that are in the master and worker node fix pack update `1.17.3_1516`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| containerd | Worker | v1.3.2 | v1.3.3 | See [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.3){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | affdfe2 | 49979f5 | Image updated for [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}, and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.17.2-4 | v1.17.3-1 | Updated to support the Kubernetes 1.17.3 release and to use `Go` version 1.13.6. |
| Kubernetes | Both | v1.17.2 | v1.17.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.3){: external}. The master update resolves CVE-2019-11254 and CVE-2020-8552 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6203780){: external}), and the worker node update resolves CVE-2020-8551 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6204874){: external}). |
| Kubernetes Dashboard | Master | v2.0.0-rc3 | v2.0.0-rc5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc5){: external}. |
| Operator Lifecycle Manager Catalog | Master | v1.5.8 | v1.5.9 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.9){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and[CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.17.2_1515" caption-side="top"}

### Changelog for 1.17.2_1515, released 10 February 2020
{: #1172_1515}

The following table shows the changes that are in patch update 1.17.2_1515.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.5 | v3.12.0 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.12/release-notes/){: external}. |
| CoreDNS | 1.6.6 | 1.6.7 | See the [CoreDNS release notes](https://coredns.io/2020/01/28/coredns-1.6.7-release/){: external}. |
| etcd | v3.3.18 | v3.4.3 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.3){: external}. |
| GPU device plug-in and installer | da19df3 | affdfe2 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, and [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| **New**: {{site.data.keyword.cloud_notm}} Controller Manager | v1.16.5-148 | v1.17.2-4 | The {{site.data.keyword.cloud_notm}} Controller Manager component replaces the {{site.data.keyword.cloud_notm}} Provider component by moving the {{site.data.keyword.cloud_notm}} controllers from the Kubernetes [`kube-controller-manager`](https://kubernetes.io/docs/concepts/overview/components/#kube-controller-manager){: external} to the [`cloud-controller-manager`](https://kubernetes.io/docs/concepts/overview/components/#cloud-controller-manager){: external} component. The {{site.data.keyword.cloud_notm}} Controller Manager is updated to support the Kubernetes 1.17.2 release, to use `distroless/static` base image version `c6d59815`, and to use `calicoctl` version 3.12.0. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 357 | 358 | Made the `ibmc-file-gold` storage class the default storage class for new clusters only. The default storage class for existing clusters is unchanged. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass). In addition, the updated the image for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| Kubernetes | v1.16.5 | v1.17.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.17.2){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the OpenID Connect configuration for the cluster's Kubernetes API server to use the {{site.data.keyword.iamlong}} (IAM) `iam.cloud.ibm.com` endpoint. Added the `AllowInsecureBackendProxy=false` Kubernetes feature gate to prevent skipping TLS verification of kubelet during pod logs requests. |
| Kubernetes Dashboard | v2.0.0-rc2 | v2.0.0-rc3 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc3){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.2 | v1.0.3 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.3){: external}. |
| Kubernetes nodelocal DNS cache | 1.15.4 | 1.15.8 | See the [Kubernetes nodelocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.8){: external}. Now in Kubernetes 1.17, when you [apply the label to set up node local DNS caching](/docs/containers?topic=containers-cluster_dns#dns_cache), the requests are handled immediately and you don't need to reload the worker nodes. |
| OpenVPN server | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh){: external}. |
| Operator Lifecycle Manager Catalog | v1.5.6 | v1.5.8 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.8){: external}. |
| Operator Lifecycle Manager | 0.13.0 | 0.14.1 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.14.1){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.5_1522" caption-side="top"}



## Version 1.16 changelog (unsupported as of 31 January 2021)
{: #116_changelog}

Version 1.16 is unsupported. You can review the following archive of 1.16 changelogs.
{: shortdesc}

### Changelog for master fix pack 1.16.15_1557, released 19 January 2021
{: #11615_1557_master}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1557`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.13 | v1.1.16 | Updated image to implement additional IBM security controls. |
| Gateway-enabled cluster controller | 1184 | 1195 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| GPU device plug-in and installer | adcae42 | 4d3b934f | Updated image for [CVE-2020-27350](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350){: external}, [CVE-2020-29361](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29361){: external}, [CVE-2020-29362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29362){: external}, [CVE-2020-29363](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29363){: external}, [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8284](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8284){: external}, [CVE-2020-8285](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8285){: external}, and [CVE-2020-8286](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8286){: external}. |
| IBM Calico extension | 556 | 567 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 384 | 385 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Key Management Service provider | v1.0.5 | v1.0.7 | Fixed bug to ignore conflict errors during KMS secret reencryption. Updated to use `Go` version 1.15.5. Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Kubernetes | N/A | N/A | Updated to implement additional IBM security controls. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1004 | 1078 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1556" caption-side="top"}

### Changelog for worker node fix pack 1.16.15_1557, released 18 January 2021
{: #11615_1557}

The following table shows the changes that are in the worker node fix pack `1.16.15_1557`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | 4.4.0-197-generic | 4.4.0-200-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361) external}, and [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362) external}. |
| Ubuntu 18.04 packages | 4.15.0-128-generic | 4.15.0-132-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2021-1052](https://nvd.nist.gov/vuln/detail/CVE-2021-1052){: external}, [CVE-2021-1053](https://nvd.nist.gov/vuln/detail/CVE-2021-1053){: external}, and [CVE-2019-19770](https://nvd.nist.gov/vuln/detail/CVE-2019-19770){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1555" caption-side="top"}

### Changelog for master fix pack 1.16.15_1556, released 6 January 2021
{: #11615_1556}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1556`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Calico extension | 544 | 556 | Updated image to include the `ip` command. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | N/A | N/A | Updated to run with a privileged security context. |
| Operator Lifecycle Manager | 0.14.1-IKS-1 | 0.14.1-IKS-2 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1554" caption-side="top"}
### Changelog for worker node fix pack 1.16.15_1555, released 21 December 2020
{: #11615_1555}

The following table shows the changes that are in the worker node fix pack `1.16.15_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ubuntu 18.04 packages | 4.15.0-126-generic | 4.15.0-128-generic | Updated worker node image with kernel and package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ephemeral storage reservations | N/A | N/A | Reserve local ephemeral storage to prevent workload evictions. |
| HAProxy | db4e6d | 9b2dca | Image update for [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external} and [CVE-2020-24659](https://nvd.nist.gov/vuln/detail/CVE-2020-24659){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1554" caption-side="top"}

### Changelog for master fix pack 1.16.15_1554, released 14 December 2020
{: #11615_1554_master}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1554`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Gateway-enabled cluster controller | 1105 | 1184 | Updated to use `Go` version 1.15.5. Updated image to implement additional IBM security controls. |
| GPU device plug-in and installer | c7a8cf7 | adcae42 | Updated the GPU drivers to version [450.80.02](https://www.nvidia.com/download/driverResults.aspx/165294){: external}. Updated image for [CVE-2020-28367](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28367){: external}, [CVE-2020-28366](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28366){: external}, and [CVE-2020-28362](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28362){: external}. Updated image to implement additional IBM security controls. |
| IBM Calico extension | 378 | 544 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.5. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.filestorage_full_notm}} monitor | 379 | 384 | Updated to use `Go` version 1.15.5 and to run as a non-root user. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 379 | 384 | Updated to use `Go` version 1.15.5 and to run with a least privileged security context. Updated image to implement additional IBM security controls. |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.15-382 | v1.16.15-394 | Updated image to implement additional IBM security controls. |
| Key management service (KMS) provider | v1.0.4 | v1.0.5 | Updated image to implement additional IBM security controls. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 208 | 1004 | Updated Alpine base image to version 3.12 and to use `Go` version 1.15.5. Updated image for [CVE-2020-8037](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8037){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. Updated image to implement additional IBM security controls. |
| OpenVPN client | 2.4.6-r3-IKS-116 | 2.4.6-r3-IKS-301 | Updated image to implement additional IBM security controls. |
| OpenVPN server | 2.4.6-r3-IKS-131 | 2.4.6-r3-IKS-301 | Updated image to implement additional IBM security controls. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1552" caption-side="top"}

### Changelog for worker node fix pack 1.16.15_1554, released 11 December 2020
{: #11615_1554}

The following table shows the changes that are in the worker node fix pack `1.16.15_1554`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 bare metal kernel | 4.15.0-126-generic | 4.15.0-123-generic | **Bare metal worker nodes**: Reverted the kernel version for bare metal worker nodes while Canonical addresses issues with the previous version that prevented worker nodes from being reloaded or updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1553" caption-side="top"}
### Changelog for worker node fix pack 1.16.15_1553, released 7 December 2020
{: #11615_1553}

The following table shows the changes that are in the worker node fix pack `1.16.15_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.4 | 1.3.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.9){: external}. The update resolves CVE-2020–15257 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6387878){: external}). |
| HAProxy | 1.8.26-384f42 | db4e6d | Added provenance labels for source tracking. |
| Ubuntu 18.04 packages | 4.15.0-123-generic | 4.15.0-126-generic | Updated worker node image with   kernel and package updates for [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external} and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
| Ubuntu 16.04 packages | 4.4.0-194-generic | 4.4.0-197-generic | Updated worker node image with kernel and package updates for [CVE-2020-0427](https://nvd.nist.gov/vuln/detail/CVE-2020-0427){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external}, [CVE-2020-25645](https://nvd.nist.gov/vuln/detail/CVE-2020-25645){: external}, and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1552" caption-side="top"}

### Changelog for worker node fix pack 1.16.15_1552, released 23 November 2020
{: #11615_1552_worker}

The following table shows the changes that are in the worker node fix pack `1.16.15_1552`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-122-generic | 4.15.0-123-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
| Ubuntu 16.04 packages | 4.4.0-193-generic | 4.4.0-194-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1551" caption-side="top"}
### Changelog for master fix pack 1.16.15_1552, released 16 November 2020
{: #11615_1552}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1552`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.12 | v1.1.13 | Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| GPU device plug-in and installer | edd26a4 | c7a8cf7 | Updated image for [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2020-8177](https://nvd.nist.gov/vuln/detail/CVE-2020-8177){: external}, [CVE-2019-14889](https://nvd.nist.gov/vuln/detail/CVE-2019-14889){: external}, [CVE-2020-1730](https://nvd.nist.gov/vuln/detail/CVE-2020-1730){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}, [CVE-2019-5018](https://nvd.nist.gov/vuln/detail/CVE-2019-5018){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, [CVE-2020-13631](https://nvd.nist.gov/vuln/detail/CVE-2020-13631){: external}, [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}, [CVE-2020-6405](https://nvd.nist.gov/vuln/detail/CVE-2020-6405){: external}, [CVE-2020-9327](https://nvd.nist.gov/vuln/detail/CVE-2020-9327){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-19221](https://nvd.nist.gov/vuln/detail/CVE-2019-19221){: external}, [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}, [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-20454](https://nvd.nist.gov/vuln/detail/CVE-2019-20454){: external}, [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2018-20843](https://nvd.nist.gov/vuln/detail/CVE-2018-20843){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, and [CVE-2019-20387](https://nvd.nist.gov/vuln/detail/CVE-2019-20387){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 378 | 379 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.2. |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.15-331 | v1.16.15-382 | Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
| Key Management Service provider | v1.0.3 | v1.0.4 | Updated image for [DLA-2424-1](https://www.debian.org/lts/security/2020/dla-2424){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1550" caption-side="top"}

### Changelog for worker node fix pack 1.16.15_1551, released 9 November 2020
{: #11615_1551}

The following table shows the changes that are in the worker node fix pack `1.16.15_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with kernel and package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}, and [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}. |
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, and [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1550" caption-side="top"}

### Changelog for worker node fix pack 1.16.15_1550, released 26 October 2020
{: #11615_1550_worker}

The following table shows the changes that are in the worker node fix pack `1.16.15_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | 4.15.0-118-generic | 4.15.0-122-generic | Updated worker node images with kernel and package updates for [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external},[CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2019-20916](https://nvd.nist.gov/vuln/detail/CVE-2019-20916){: external}, [CVE-2020-12351](https://nvd.nist.gov/vuln/detail/CVE-2020-12351){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, [CVE-2020-16120](https://nvd.nist.gov/vuln/detail/CVE-2020-16120){: external}, [CVE-2020-24490](https://nvd.nist.gov/vuln/detail/CVE-2020-24490){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
|Ubuntu 16.04 packages | 4.4.0-190-generic | 4.4.0-193-generic | Updated worker node images with kernel and package updates for [CVE-2017-17087](https://nvd.nist.gov/vuln/detail/CVE-2017-17087){: external}, [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external}, [CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1549" caption-side="top"}

### Changelog for master fix pack 1.16.15_1550, released 26 October 2020
{: #11615_1550}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1550`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Updated the `calico-node` daemon set in the `kube-system` namespace to set the `spec.updateStrategy.rollingUpdate.maxUnavailable` parameter to `10%` for clusters with more than 50 worker nodes. |
| Cluster health image | v1.1.11 | v1.1.12 | Updated to use `Go` version 1.15.2. |
| Gateway-enabled cluster controller | 1082 | 1105 | Updated to use `Go` version 1.15.2. |
| Kubernetes `NodeLocal` DNS cache | 1.15.13 | 1.15.14 | See the [Kubernetes `NodeLocal` DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.14){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1547" caption-side="top"}

### Changelog for worker node fix pack 1.16.15_1549, released 12 October 2020
{: #11615_1549}

The following table shows the changes that are in the worker node fix pack `1.16.15_1549`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2019-8936](https://nvd.nist.gov/vuln/detail/CVE-2019-8936){: external}, [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}, and [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external}.|
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external} and [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.15_1548" caption-side="top"}

### Changelog for worker node fix pack 1.16.15_1548, released 28 September 2020
{: #11615_1548}

The following table shows the changes that are in the worker node fix pack `1.16.15_1548`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.16.14    | v1.16.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.15){: external}. |
| Ubuntu 18.04 packages | 4.15.0-117-generic | 4.15.0-118-generic | Updated worker node image with   kernel and package updates for [CVE-2018-1000500](https://nvd.nist.gov/vuln/detail/CVE-2018-1000500){: external}, [CVE-2018-7738](https://nvd.nist.gov/vuln/detail/CVE-2018-7738){: external}, [CVE-2019-14855](https://nvd.nist.gov/vuln/detail/CVE-2019-14855){: external}, [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, [CVE-2020-10753](https://nvd.nist.gov/vuln/detail/CVE-2020-10753){: external}, [CVE-2020-12059](https://nvd.nist.gov/vuln/detail/CVE-2020-12059){: external}, [CVE-2020-12888](https://nvd.nist.gov/vuln/detail/CVE-2020-12888){: external}, [CVE-2020-1760](https://nvd.nist.gov/vuln/detail/CVE-2020-1760){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}.|
| Ubuntu 16.04 packages | 4.4.0-189-generic | 4.4.0-190-generic | Updated worker node image with kernel and package updates for [CVE-2019-20811](https://nvd.nist.gov/vuln/detail/CVE-2019-20811){: external}, [CVE-2019-9453](https://nvd.nist.gov/vuln/detail/CVE-2019-9453){: external}, [CVE-2020-0067](https://nvd.nist.gov/vuln/detail/CVE-2020-0067){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.14_1546" caption-side="top"}

### Changelog for master fix pack 1.16.15_1547, released 21 September 2020
{: #11615_1547}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1547`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.9 | v1.1.11 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. |
| etcd | v3.3.22 | v3.3.25 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.25){: external}. |
| GPU device plug-in and installer | bacb9e1 | edd26a4 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. Updated the GPU drivers to version [450.51.06](https://www.nvidia.com/download/driverResults.aspx/162630){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 377 | 378 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external}. |
| IBM Cloud Provider | v1.16.14-311 | v1.16.15-331 | Updated to support the Kubernetes 1.16.15 release. |
| Key Management Service provider | v1.0.1 | v1.0.3 | Updated `Go` version for [CVE-2020-16845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-16845){: external} and [CVE-2020-24553](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24553){: external}. |
| Kubernetes | v1.16.14 | v1.16.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.15){: external}. |
| Kubernetes Dashboard | v2.0.3 | v2.0.4 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.4){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.14_1546" caption-side="top"}

### Changelog for worker node fix pack 1.16.14_1546, released 14 September 2020
{: #11614_1546}

The following table shows the changes that are in the worker node fix pack `1.16.14_1546`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-384f42 | 1.8.26-561f1a | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.|
| Ubuntu 18.04 packages | 4.15.0-112-generic | 4.15.0-117-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external}, [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}, and [CVE-2020-14386](https://nvd.nist.gov/vuln/detail/CVE-2020-14386){: external}. |
| Ubuntu 16.04 packages | 4.4.0-187-generic | 4.4.0-189-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external} and [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.14_1545" caption-side="top"}

### Changelog for worker node fix pack 1.16.14_1545, released 31 August 2020
{: #11614_1545}

The following table shows the changes that are in the worker node fix pack `1.16.14_1545`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-12403](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12403){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}, and [CVE-2020-8624](https://nvd.nist.gov/vuln/detail/CVE-2020-8624){: external}. |
| Ubuntu 16.04 packages | 4.4.0-186-generic | 4.4.0-187-generic | Updated worker node image with kernel and package updates for [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, and [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.14_1544" caption-side="top"}

### Changelog for master fix pack 1.16.14_1544, released 18 August 2020
{: #11614_1544_master}

The following table shows the changes that are in the master fix pack patch update `1.16.14_1544`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster health image | v1.1.8 | v1.1.9 | Updated to use `Go` version 1.13.13. |
| GPU device plug-in and installer | 8c24345 | bacb9e1 | Updated image for [CVE-2020-14039](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14039){: external} and [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.13-289 | v1.16.14-311 | Updated to support the Kubernetes 1.16.14 release and to use `Go` version 1.13.15. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 376 | 377 | Fixed a bug that prevents persistent volume claim (PVC) creation failures from being retried. |
| Key Management Service provider | v1.0.0 | v1.0.1 | Updated image for [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| Kubernetes | v1.16.13 | v1.16.14 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.14){: external}. |
| Kubernetes add-on resizer | 1.8.5 | 1.8.11 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.11){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing of all API groups except `apiregistration.k8s.io` and `coordination.k8s.io`. |
| Kubernetes Metrics Server | v0.3.6 | v0.3.7 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.7){: external}. |
| Kubernetes `NodeLocal` DNS cache configuration | N/A | N/A | Increased the pod termination grace period. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.13_1542" caption-side="top"}

### Changelog for worker node fix pack 1.16.14_1544, released 17 August 2020
{: #11614_1544}

The following table shows the changes that are in the worker node fix pack `1.16.14_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.16.13 | v1.16.14 | See the [Kubernetes changelogs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md#v11614){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-12400](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12400){: external}, [CVE-2020-12401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12401){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}, and [CVE-2020-6829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6829){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, and [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.13_1542" caption-side="top"}

### Changelog for worker node fix pack 1.16.13_1542, released 3 August 2020
{: #11613_1542}

The following table shows the changes that are in the worker node fix pack `1.16.13_1542`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-111-generic | 4.15.0-112-generic | Updated worker node images with kernel and package updates for [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-10757](https://nvd.nist.gov/vuln/detail/CVE-2020-10757){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
| Ubuntu 16.04 packages | 4.4.0-185-generic | 4.4.0-186-generic | Updated worker node images with package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.13_1539" caption-side="top"}

### Changelog for master fix pack 1.16.13_1541, released 24 July 2020
{: #11613_1541}

The following table shows the changes that are in the master fix pack patch update `1.16.13_1541`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master operations | N/A | N/A | Fixed a problem that might cause pods to fail authentication to the Kubernetes API server after a cluster master operation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 375 | 376 | Updated to use `Go` version 1.13.8. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.13_1540" caption-side="top"}

### Changelog for master fix pack 1.16.13_1540, released 20 July 2020
{: #11613_1540}

The following table shows the changes that are in the master fix pack patch update `1.16.13_1540`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 31d4bb6 | 8c24345 | Updated image for [CVE-2017-12133](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12133){: external}, [CVE-2017-18269](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18269){: external}, [CVE-2018-11236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11236){: external}, [CVE-2018-11237](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11237){: external}, [CVE-2018-19591](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19591){: external}, [CVE-2018-6485](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6485){: external}, [CVE-2019-19126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19126){: external}, [CVE-2019-9169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9169){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, and [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}. |
| IBM Calico extension | 353 | 378 | Updated to handle any `ens` network interface. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor configuration | N/A | N/A | Added a pod memory limit. |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.11-267 | v1.16.13-289 | Updated to support the Kubernetes 1.16.13 release. |
| Kubernetes | v1.16.11 | v1.16.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.13){: external}. The update resolves CVE-2020-8559 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249915){: external}). |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `scheduling.k8s.io` API group and the `tokenreviews` resource. |
| Kubernetes Dashboard | v2.0.1 | v2.0.3 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.3){: external}. |
| Operator Lifecycle Manager | 0.14.1 | 0.14.1-IKS-1 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.11_1537" caption-side="top"}

### Changelog for worker node fix pack 1.16.13_1539, released 20 July 2020
{: #11613_1539}

The following table shows the changes that are in the worker node fix pack `1.16.13_1539`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 2.0.15-afe432 | 1.8.25-384f42 | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Fixes a connection leak that happens when HAProxy is under high load. |
| Kubernetes | v1.16.11 | v1.16.13 | See the [Kubernetes changelogs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md#v11613){: external}. The update resolves CVE-2020-8557 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249941){: external}). |
| Ubuntu 18.04 packages | 4.15.0-109-generic | 4.15.0-111-generic | Updated worker node images with kernel and package updates for [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-19591](https://nvd.nist.gov/vuln/detail/CVE-2018-19591){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-12402](https://nvd.nist.gov/vuln/detail/CVE-2020-12402){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
| Ubuntu 16.04 packages | 4.4.0-184-generic | 4.4.0-185-generic | Updated worker node images with package updates for [CVE-2017-12133](https://nvd.nist.gov/vuln/detail/CVE-2017-12133){: external}, [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}, [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-6485](https://nvd.nist.gov/vuln/detail/CVE-2018-6485){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.11_1537" caption-side="top"}

### Changelog for worker node fix pack 1.16.11_1537, released 6 July 2020
{: #11611_1537}

The following table shows the changes that are in the worker node fix pack `1.16.11_1537`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-30b675 | 2.0.15-afe432 | See the [HAProxy changelog](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}. |
| Ubuntu 18.04 packages | 4.15.0-106-generic | 4.15.0-109-generic | Updated worker node images with kernel and package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-16089](https://nvd.nist.gov/vuln/detail/CVE-2019-16089){: external}, [CVE-2019-19036](https://nvd.nist.gov/vuln/detail/CVE-2019-19036){: external}, [CVE-2019-19039](https://nvd.nist.gov/vuln/detail/CVE-2019-19039){: external}, [CVE-2019-19318](https://nvd.nist.gov/vuln/detail/CVE-2019-19318){: external}, [CVE-2019-19642](https://nvd.nist.gov/vuln/detail/CVE-2019-19642){: external}, [CVE-2019-19813](https://nvd.nist.gov/vuln/detail/CVE-2019-19813){: external}, [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-19377](https://nvd.nist.gov/vuln/detail/CVE-2019-19377){: external}, and [CVE-2019-19816](https://nvd.nist.gov/vuln/detail/CVE-2019-19816){: external}. |
| Ubuntu 16.04 packages | N/A| N/A| Updated worker node images with package updates for [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external} and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}. |
| Worker node `drain` automation |N/A |N/A | Fixes a race condition that can cause worker node `drain` automation to fail. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.11_1536" caption-side="top"}

### Changelog for 1.16.11_1536, released 22 June 2020
{: #11611_1536}

The following table shows the changes that are in the master and worker node update `1.16.11_1536`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Calico | Master | v3.9.5 | v3.9.6 | See the [Calico release notes](https://docs.projectcalico.org/releases){: external}. The master update resolves CVE-2020-13597 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6226322){: external}). |
| Cluster health image | Master | v1.1.5 | v1.1.8 | Additional status information is included when an add-on health state is `critical`. Improved performance when handling cluster status updates. |
| Cluster master operations | Master | N/A | N/A | Cluster master operations such as `refresh` or `update` are now canceled if a broken [Kubernetes admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} is detected. |
| etcd | Master | v3.3.20 | v3.3.22 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.22){: external}. |
| GPU device plug-in and installer | Master | 8b02302 | 31d4bb6 | Updated image for [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | Master | 373 | 375 | Fixed a bug that might cause error handling to create additional persistent volumes. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.16.10-243 | v1.16.11-267 | Updated to support the Kubernetes 1.16.11 release. Updated the version 2.0 private network load balancers (NLBs) to manage Calico global network policies. Updated `calicoctl` version to 3.9.6. |
| Kubernetes | Both | v1.16.10 | v1.16.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.11){: external}. The master update resolves CVE-2020-8558 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249905){: external}). |
| Kubernetes configuration | Master | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `apiextensions.k8s.io` API group and the `persistentvolumeclaims` and `persistentvolumes` resources. Additionally, the `http2-max-streams-per-connection` option is set to `1000` to mitigate network disruption impacts on the `kubelet` connection to the API server. |
| Kubernetes Dashboard | Master | v2.0.0 | v2.0.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.1){: external}. |
| Ubuntu 18.04 packages | Worker | 4.15.0-101-generic | 4.15.0-106-generic | Updated worker node images with kernel and package updates for [CVE-2018-8740](https://nvd.nist.gov/vuln/detail/CVE-2018-8740){: external}, [CVE-2019-17023](https://nvd.nist.gov/vuln/detail/CVE-2019-17023){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-12399](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12399){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-179-generic | 4.4.0-184-generic | Updated worker node images with package and kernel updates for [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12769](https://nvd.nist.gov/vuln/detail/CVE-2020-12769){: external}, [CVE-2020-1749](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1749){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and[CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.10_1534" caption-side="top"}

### Changelog for worker node fix pack 1.16.10_1534, released 8 June 2020
{: #11610_1534}

The following table shows the changes that are in the worker node fix pack `1.16.10_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1549](https://nvd.nist.gov/vuln/detail/CVE-2019-1549){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.10_1533" caption-side="top"}

### Changelog for 1.16.10_1533, released 26 May 2020
{: #11610_1533}

The following table shows the changes that are in the master and worker node update `1.16.10_1533`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | v1.1.1 | v1.1.4 | When cluster add-ons don't support the current cluster version, a warning is now returned in the cluster health state. |
| etcd | Master | v3.3.18 | v3.3.20 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.20){: external}. |
| Gateway-enabled cluster controller | Master | 1045 | 1082 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| GPU device plug-in and installer | Master | 8c6538f | 8b02302 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| IBM Calico extension | Master | 320 | 353 | Skips creating a Calico host endpoint when no endpoint is needed. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 358 | 373 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external} and [CVE-2020-11655](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11655){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.16.9-219 | v1.16.10-243 | Updated to support the Kubernetes 1.16.10 release. Updated network load balancer (NLB) events to use the latest {{site.data.keyword.cloud_notm}} troubleshooting documentation. |
| Kubernetes | Both | v1.16.9 | v1.16.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.10){: external}. |
| Kubernetes Dashboard | Master | v2.0.0-rc7 | v2.0.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0){: external}. |
| Kubernetes Metrics Server | Master | N/A | N/A | Increased the CPU per node for the `metrics-server` container to improve availability of the metrics server API service for large clusters. |
| Kubernetes `NodeLocal` DNS cache | Master | 1.15.4 | 1.15.13 | <ul><li>See the <a href="https://github.com/kubernetes/dns/releases/tag/1.15.13">Kubernetes <code>NodeLocal</code> DNS cache release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon"></li><li>Now, when you <a href="/docs/containers?topic=containers-cluster_dns#dns_cache">apply the label to set up node local DNS caching</a>, the requests are handled immediately and you don't need to reload the worker nodes.</li><li>The <code>NodeLocal</code> DNS cache configuration now allows customization of stub domains and upstream DNS servers.</li><li>The <code>node-local-dns</code> daemon set is updated to include the <code>prometheus.io/port</code> and <code>prometheus.io/scrape</code> annotations on the pods.</li></ul> |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 177 | 208 | Updated the version 2.0 network load balancers (NLB) to clean up unnecessary IPVS rules. Improved application logging. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | Worker | 4.15.0-99-generic | 4.15.0-101-generic | Updated worker node images with kernel and package updates for [CVE-2019-20795](https://nvd.nist.gov/vuln/detail/CVE-2019-20795){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616), and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.9_1531" caption-side="top"}

### Changelog for worker node fix pack 1.16.9_1531, released 11 May 2020
{: #1169_1531}

The following table shows the changes that are in the worker node fix pack `1.16.9_1531`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.9_1530" caption-side="top"}

### Changelog for worker node fix pack 1.16.9_1530, released 27 April 2020
{: #1169_1530}

The following table shows the changes that are in the worker node fix pack `1.16.9_1530`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.3 | v1.3.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.4){: external}. |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Kubernetes | v1.16.8 | v1.16.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.9){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1528" caption-side="top"}

### Changelog for master fix pack 1.16.9_1529, released 23 April 2020
{: #1169_1529}

The following table shows the changes that are in the master fix pack patch update `1.16.9_1529`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico configuration | N/A | N/A | Updated to allow egress from the worker nodes via the `allow-vrrp` `GlobalNetworkPolicy`. |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| CoreDNS | 1.6.7 | 1.6.9 | See the [CoreDNS release notes](https://coredns.io/2020/03/24/coredns-1.6.9-release/){: external}. Fixed a bug during Corefile migration that might generate invalid data that makes CoreDNS pods fail. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.8-192 | v1.16.9-219 | Updated to support the Kubernetes 1.16.9 release and to use `Go` version 1.13.9. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| Kubernetes | v1.16.8 | v1.16.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.9){: external}. The update resolves CVE-2020-8555 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6220220){: external}). |
| Kubernetes Dashboard | v2.0.0-rc5 | v2.0.0-rc7 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc7){: external}. Added a readiness probe to the Kubernetes Dashboard configuration. |
| Kubernetes Dashboard metrics scraper | v1.0.3 | v1.0.4 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.4){: external}. |
| OpenVPN client | N/A | N/A | Fixed a problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
| Operator Lifecycle Manager Catalog | v1.5.11 | v1.6.1 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.6.1){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1528" caption-side="top"}

### Changelog for worker node fix pack 1.16.8_1528, released 13 April 2020
{: #1168_1528}

The following table shows the changes that are in the worker node fix pack `1.16.8_1528`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1527" caption-side="top"}

### Changelog for worker node fix pack 1.16.8_1527, released 30 March 2020
{: #1168_1527}

The following table shows the changes that are in the worker node fix pack `1.16.8_1527`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.8_1526" caption-side="top"}

### Changelog for 1.16.8_1526, released 16 March 2020
{: #1168_1526}

The following table shows the changes that are in the master and worker node update `1.16.8_1526`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | N/A | N/A | Cluster health status now includes links to {{site.data.keyword.cloud_notm}} documentation. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.16.7-170 | v1.16.8-192 | Updated to support the Kubernetes 1.16.8 release and to use `Go` version 1.13.8. Fixed VPC load balancer error message to use the current {{site.data.keyword.containerlong_notm}} plug-in CLI syntax. |
| Kubernetes | Both | v1.16.7 | v1.16.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.8){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 169 | 177 | Version 2.0 network load balancers (NLB) were updated to fix problems with long-lived network connections to endpoints that failed readiness probes. |
| Operator Lifecycle Manager Catalog | Master | v1.5.9 | v1.5.11 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.11){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | Worker |N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.7_1525" caption-side="top"}

### Changelog for worker node fix pack 1.16.7_1525, released 2 March 2020
{: #1167_1525}

The following table shows the changes that are in the worker node fix pack 1.16.7_1525. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU worker node provisioning | N/A | N/A | Fixed bug where new GPU worker nodes could not automatically join clusters that run Kubernetes version 1.16 or 1.17. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.7_1524" caption-side="top"}

### Changelog for fix pack 1.16.7_1524, released 17 February 2020
{: #1167_1524}

The following table shows the changes that are in the master and worker node fix pack update `1.16.7_1524`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | -------- | ------- | ----------- |
| containerd | Worker | v1.3.2 | v1.3.3 | See [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.3){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253). |
| CoreDNS | Master | 1.6.6 | 1.6.7 | See the [CoreDNS release notes](https://coredns.io/2020/01/28/coredns-1.6.7-release/){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844) and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.16.5-148 | v1.16.7-170 | Updated to support the Kubernetes 1.16.7 release and to use `Go` version 1.13.6 and `calicoctl` version 3.9.5. |
| Kubernetes | Both | v1.16.5 | v1.16.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.7){: external}. The master update resolves CVE-2019-11254 and CVE-2020-8552 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6203780){: external}), and the worker node update resolves CVE-2020-8551 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6204874){: external}). |
| Kubernetes Dashboard | Master | v2.0.0-rc2 | v2.0.0-rc5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc5){: external}. |
| Kubernetes Dashboard Metrics Scraper | Master | v1.0.2 | v1.0.3 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.3){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh){: external}. |
| Operator Lifecycle Manager | Master | 0.13.0 | 0.14.1 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.14.1){: external}. |
| Operator Lifecycle Manager Catalog | Master | v1.5.6 | v1.5.9 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.9){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712). |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and[CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712). |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.5_1523" caption-side="top"}

### Changelog for worker node fix pack 1.16.5_1523, released 3 February 2020
{: #1165_1523}

The following table shows the changes that are in the worker node fix pack 1.16.5_1523.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.5_1522" caption-side="top"}

### Changelog for 1.16.5_1522, released 20 January 2020
{: #1165_1522}

The following table shows the changes that are in the master and worker node patch update 1.16.5_1522. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.3 | v3.9.5 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.9/release-notes/){: external}. |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| CoreDNS | 1.6.2 | 1.6.6 | See the [CoreDNS release notes](https://coredns.io/2019/12/11/coredns-1.6.6-release/){: external}. Update resolves [CVE-2019-19794](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19794){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Gateway-enabled cluster controller | 1032 | 1045 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| IBM Calico extension | 130 | 258 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: <code>ibmc-file-bronze-gid</code>, <code>ibmc-file-silver-gid</code>, and <code>ibmc-file-gold-gid</code>.</li><li>Fixed bugs in support of <a href="/docs/containers?topic=containers-cs_storage_nonroot">non-root user access to an NFS file share</a>.</li><li>Resolved <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551">CVE-2019-1551</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li></ul> |
| {{site.data.keyword.cloud_notm}} Provider | v1.16.3-115 | v1.16.5-148 | Updated to support the Kubernetes 1.16.5 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.16.3 | v1.16.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.5){: external}. |
| Kubernetes Dashboard | v2.0.0-beta8 | v2.0.0-rc2 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc2){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Operator Lifecycle Manager Catalog | v1.5.4 | v1.5.6 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.6){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1521" caption-side="top"}


### Changelog for worker node fix pack 1.16.3_1521, released 23 December 2019
{: #1163_1521}

The following table shows the changes that are in the worker node fix pack 1.16.3_1521.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1519" caption-side="top"}

### Changelog for master fix pack 1.16.3_1520, released 17 December 2019
{: #1163_1520}

The following table shows the changes that are in the master fix pack 1.16.3_1520.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Gateway-enabled cluster controller | 924 | 1032 | Support for [Adding classic infrastructure servers to gateway-enabled classic clusters](/docs/containers?topic=containers-add_workers#gateway_vsi) is now generally available (GA). In addition, the controller is updated to use Alpine base image version 3.10 and to use Go version 1.12.11. |
| IBM Calico extension | N/A | 130 | **New!**: Added a Calico node init container that creates Calico private host endpoints for worker nodes. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.16.3-94 | v1.16.3-115 | Updated version 1.0 and 2.0 network load balancers (NLBs) to prefer scheduling NLB pods on worker nodes that don't currently run any NLB pods. In addition, the Virtual Private Cloud (VPC) load balancer plug-in is updated to use Go version 1.12.11. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
| Kubernetes add-on resizer | 1.8.5 | 1.8.7 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.7){: external}. |
| Kubernetes Metrics Server | N/A | N/A | The `nanny` container is fixed (see Kubernetes add-on resizer component) and added back to the `metrics-server` pod, which removes the Kubernetes 1.16 limitation to [Adjusting cluster metrics provider resources](/docs/containers?topic=containers-kernel#metrics). |
| Kubernetes Dashboard | v2.0.0-beta6 | v2.0.0-beta8 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta8){: external}.|
| Operator Lifecycle Manager Catalog | v1.4.0 | v1.5.4 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.4){: external}. |
| Operator Lifecycle Manager | 0.12.0 | 0.13.0 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.13.0){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1519" caption-side="top"}

### Changelog for worker node fix pack 1.16.3_1519, released 9 December 2019
{: #1163_1519_worker}

The following table shows the changes that are in the worker node fix pack 1.16.3_1519.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.1 | v1.3.2 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.2){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.3_1518" caption-side="top"}

### Changelog for worker node fix pack 1.16.3_1518, released 25 November 2019
{: #1163_1518_worker}

The following table shows the changes that are in the worker node fix pack 1.16.3_1518.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.0 | v1.3.1 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.1){: external}. Update resolves [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external} and [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. |
| Kubernetes | v1.16.2 | v1.16.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.3){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.2_1515" caption-side="top"}

### Changelog for master fix pack 1.16.3_1518, released 21 November 2019
{: #1163_1518}

The following table shows the changes that are in the master fix pack 1.16.3_1518.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.2 | v3.9.3 | See the [Calico release notes](https://docs.projectcalico.org/release-notes/){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}, and [DSA-4539-3](https://lists.debian.org/debian-security-announce/2019/msg00193.html){: external}. |
| GPU device plug-in and installer | 9cd3df7 |    f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 351 | 353 | Updated to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.16.2-77 | v1.16.3-94 | Updated to support the Kubernetes 1.16.3 release. `calicoctl` version is updated to v3.9.3. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.16.2 | v1.16.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.3){: external}. |
| Kubernetes Dashboard | v2.0.0-beta5 | v2.0.0-beta6 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta6){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.2_1515" caption-side="top"}

### Changelog for worker node fix pack 1.16.2_1515, released 11 November 2019
{: #1162_1515_worker}

The following table shows the changes that are in the worker node fix pack 1.16.2_1515.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.16.2_1514" caption-side="top"}

### Changelog for 1.16.2_1514, released 4 November 2019
{: #1162_1514}

The following tables show the changes that are in the patch `1.16.2_1514`. If you update to this version from an earlier version, you choose when to update your cluster master and worker nodes. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types) and [Version 1.16](/docs/containers?topic=containers-cs_versions#cs_v116).
{: shortdesc}

**Master patch**

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Calico | v3.8.2 | v3.9.2 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.9/release-notes/){: external}.|
|CoreDNS |    1.3.1 |    1.6.2 |    See the [CoreDNS release notes](https://coredns.io/2019/08/13/coredns-1.6.2-release/). This update includes the following configuration changes. <ul><li>CoreDNS now runs <code>3</code> replica pods by default, and the pods prefer to schedule across worker nodes and zones to improve cluster DNS availability. If you update your cluster to version 1.16 from an earlier version, you can <a href="/docs/containers?topic=containers-cluster_dns#dns_autoscale">configure the CoreDNS autoscaler</a> to use a minimum of <code>3</code> pods.</li><li>CoreDNS caching is updated to better support older DNS clients. If you disabled the CoreDNS <code>cache</code> plug-in, you can now re-enable the plug-in.</li><li>The CoreDNS deployment is now configured to check readiness by using the <code>ready</code> plug-in.</li><li>CoreDNS version 1.6 no longer supports the <code>proxy</code> plug-in, which is replaced by the <code>forward</code> plug-in. In addition, the CoreDNS <code>kubernetes</code> plug-in no longer supports the <code>resyncperiod</code> option and ignores the <code>upstream</code> option. </li></ul>|
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 350 | 351 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.10.|
| Kubernetes | v1.15.5 | v1.16.2 | See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.2).|
| Kubernetes configuration |    N/A |    N/A |    [Kubernetes service account token volume projection](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#service-account-token-volume-projection){: external} is enabled and issues tokens that use `https://kubernetes.default.svc` as the default API audience. |
| Kubernetes admission controllers configuration |    N/A |    N/A |    The `RuntimeClass` admission controller is disabled to align with the `RuntimeClass` feature gate, which was disabled in {{site.data.keyword.containerlong_notm}} version 1.14.|
| Kubernetes Dashboard |    v1.10.1 |    v2.0.0-beta5 |    See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta5){: external}. Unlike the previous version, the new Kubernetes dashboard version works with the `metrics-server` to display metrics. |
| Kubernetes Dashboard metrics scraper |    N/A |    v1.0.2 |    See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.2){: external}.|
| Kubernetes DNS autoscaler |    1.6.0 |    1.7.1 |    See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.7.1){: external}.|
| Operator Lifecycle Manager Catalog |    N/A |    v1.4.0 |    See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.4.0){: external}. |
| Operator Lifecycle Manager |    N/A |    0.12.0 |    See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.12.0){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Master patch: Changes since version 1.15.5_1520" caption-side="top"}

**Worker node patch**

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|containerd |    v1.2.10 |    v1.3.0 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.0){: external}. The containerd configuration now sets `stream_idle_timeout` to `30m`, lowered from `4h`. This `stream_idle_timeout` configuration is the maximum time that a streaming connection such as `kubectl exec` can be idle before the connection is closed. Also, the container runtime type is updated to `io.containerd.runc.v2`. |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Kubernetes | v1.15.5 | v1.16.2 | See the [Kubernetes release notes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.2).|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Worker node patch: Changes since version 1.15.5_1521" caption-side="top"}



## Version 1.15 changelog (unsupported 22 September 2020)
{: #115_changelog}

Version 1.15 is unsupported. You can review the following archive of 1.15 changelogs.
{: shortdesc}

### Changelog for worker node fix pack 1.15.12_1552, released 14 September 2020
{: #11512_1552}

The following table shows the changes that are in the worker node fix pack `1.15.12_1552`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-384f42 | 1.8.26-561f1a | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.|
| Ubuntu 18.04 packages | 4.15.0-112-generic | 4.15.0-117-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external}, [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}, and [CVE-2020-14386](https://nvd.nist.gov/vuln/detail/CVE-2020-14386){: external}. |
| Ubuntu 16.04 packages | 4.4.0-187-generic | 4.4.0-189-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external} and [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1551" caption-side="top"}

### Changelog for worker node fix pack 1.15.12_1551, released 31 August 2020
{: #11512_1551}

The following table shows the changes that are in the worker node fix pack `1.15.12_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-12403](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12403){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}, and [CVE-2020-8624](https://nvd.nist.gov/vuln/detail/CVE-2020-8624){: external}. |
| Ubuntu 16.04 packages | 4.4.0-186-generic | 4.4.0-187-generic | Updated worker node image with kernel and package updates for [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, and [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1550" caption-side="top"}

### Changelog for master fix pack 1.15.12_1550, released 18 August 2020
{: #11512_1550_master}

The following table shows the changes that are in the master fix pack patch update `1.15.12_1550`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster health image | v1.1.8 | v1.1.9 | Updated to use `Go` version 1.13.13. |
| GPU device plug-in and installer | 8c24345 | bacb9e1 | Updated image for [CVE-2020-14039](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14039){: external} and [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 376 | 377 | Fixed a bug that prevents persistent volume claim (PVC) creation failures from being retried. |
| Key Management Service provider | v1.0.0 | v1.0.1 | Updated image for [CVE-2020-15586](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15586){: external}. |
| Kubernetes add-on resizer | 1.8.5 | 1.8.11 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.11){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing of all API groups except `apiregistration.k8s.io` and `coordination.k8s.io`. |
| Kubernetes Metrics Server | v0.3.6 | v0.3.7 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.7){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1549" caption-side="top"}

### Changelog for worker node fix pack 1.15.12_1550, released 17 August 2020
{: #11512_1550}

The following table shows the changes that are in the worker node fix pack `1.15.12_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-12400](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12400){: external}, [CVE-2020-12401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12401){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}, and [CVE-2020-6829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6829){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, and [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1549" caption-side="top"}

### Changelog for worker node fix pack 1.15.12_1549, released 3 August 2020
{: #11512_1549}

The following table shows the changes that are in the worker node fix pack `1.15.12_1549`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-111-generic | 4.15.0-112-generic | Updated worker node images with kernel and package updates for [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-10757](https://nvd.nist.gov/vuln/detail/CVE-2020-10757){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
| Ubuntu 16.04 packages | 4.4.0-185-generic | 4.4.0-186-generic | Updated worker node images with package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1546" caption-side="top"}

### Changelog for master fix pack 1.15.12_1548, released 24 July 2020
{: #11512_1548}

The following table shows the changes that are in the master fix pack patch update `1.15.12_1548`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master operations | N/A | N/A | Fixed a problem that might cause pods to fail authentication to the Kubernetes API server after a cluster master operation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 375 | 376 | Updated to use `Go` version 1.13.8. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1547" caption-side="top"}

### Changelog for master fix pack 1.15.12_1547, released 20 July 2020
{: #11512_1547}

The following table shows the changes that are in the master fix pack patch update `1.15.12_1547`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 31d4bb6 | 8c24345 | Updated image for [CVE-2017-12133](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12133){: external}, [CVE-2017-18269](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18269){: external}, [CVE-2018-11236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11236){: external}, [CVE-2018-11237](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11237){: external}, [CVE-2018-19591](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19591){: external}, [CVE-2018-6485](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6485){: external}, [CVE-2019-19126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19126){: external}, [CVE-2019-9169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9169){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, and [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor configuration | N/A | N/A | Added a pod memory limit. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `scheduling.k8s.io` API group and the `tokenreviews` resource. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1544" caption-side="top"}

### Changelog for worker node fix pack 1.15.12_1546, released 20 July 2020
{: #11512_1546}

The following table shows the changes that are in the worker node fix pack `1.15.12_1546`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 2.0.15-afe432 | 1.8.25-384f42 | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Fixes a connection leak that happens when HAProxy is under high load. |
| Ubuntu 18.04 packages | 4.15.0-109-generic | 4.15.0-111-generic | Updated worker node images with kernel and package updates for [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-19591](https://nvd.nist.gov/vuln/detail/CVE-2018-19591){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-12402](https://nvd.nist.gov/vuln/detail/CVE-2020-12402){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
| Ubuntu 16.04 packages | 4.4.0-184-generic | 4.4.0-185-generic | Updated worker node images with package updates for [CVE-2017-12133](https://nvd.nist.gov/vuln/detail/CVE-2017-12133){: external}, [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}, [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-6485](https://nvd.nist.gov/vuln/detail/CVE-2018-6485){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1544" caption-side="top"}

### Changelog for worker node fix pack 1.15.12_1544, released 6 July 2020
{: #11512_1544}

The following table shows the changes that are in the worker node fix pack `1.15.12_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-30b675 | 2.0.15-afe432 | See the [HAProxy changelog](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}. |
| Ubuntu 18.04 packages | 4.15.0-106-generic | 4.15.0-109-generic | Updated worker node images with kernel and package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-16089](https://nvd.nist.gov/vuln/detail/CVE-2019-16089){: external}, [CVE-2019-19036](https://nvd.nist.gov/vuln/detail/CVE-2019-19036){: external}, [CVE-2019-19039](https://nvd.nist.gov/vuln/detail/CVE-2019-19039){: external}, [CVE-2019-19318](https://nvd.nist.gov/vuln/detail/CVE-2019-19318){: external}, [CVE-2019-19642](https://nvd.nist.gov/vuln/detail/CVE-2019-19642){: external}, [CVE-2019-19813](https://nvd.nist.gov/vuln/detail/CVE-2019-19813){: external}, [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-19377](https://nvd.nist.gov/vuln/detail/CVE-2019-19377){: external}, and [CVE-2019-19816](https://nvd.nist.gov/vuln/detail/CVE-2019-19816){: external}. |
| Ubuntu 16.04 packages |N/A |N/A | Updated worker node images with package updates for [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external} and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}. |
| Worker node `drain` automation | N/A| N/A| Fixes a race condition that can cause worker node `drain` automation to fail. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1543" caption-side="top"}

### Changelog for 1.15.12_1543, released 22 June 2020
{: #11512_1543}

The following table shows the changes that are in the master and worker node update `1.15.12_1543`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Calico | Master | v3.8.6 | v3.8.9 | See the [Calico release notes](https://docs.projectcalico.org/releases){: external}. The master update resolves CVE-2020-13597 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6226322){: external}). |
| Cluster health image | Master | v1.1.5 | v1.1.8 | Additional status information is included when an add-on health state is `critical`. Improved performance when handling cluster status updates. |
| Cluster master operations | Master | N/A | N/A | Cluster master operations such as `refresh` or `update` are now canceled if a broken [Kubernetes admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} is detected. |
| etcd | Master | v3.3.20 | v3.3.22 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.22){: external}. |
| GPU device plug-in and installer | Master | 8b02302 | 31d4bb6 | Updated image for [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | Master | 373 | 375 | Fixed a bug that might cause error handling to create additional persistent volumes. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.15.12-316 | v1.15.12-343 | Updated `calicoctl` version to 3.8.9. |
| Kubernetes configuration | Master | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `apiextensions.k8s.io` API group and the `persistentvolumeclaims` and `persistentvolumes` resources. Additionally, the `http2-max-streams-per-connection` option is set to `1000` to mitigate network disruption impacts on the `kubelet` connection to the API server. |
| Ubuntu 18.04 packages | Worker | 4.15.0-101-generic | 4.15.0-106-generic | Updated worker node images with kernel and package updates for [CVE-2018-8740](https://nvd.nist.gov/vuln/detail/CVE-2018-8740){: external}, [CVE-2019-17023](https://nvd.nist.gov/vuln/detail/CVE-2019-17023){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-12399](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12399){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-179-generic | 4.4.0-184-generic | Updated worker node images with package and kernel updates for [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12769](https://nvd.nist.gov/vuln/detail/CVE-2020-12769){: external}, [CVE-2020-1749](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1749){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and[CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1541" caption-side="top"}

### Changelog for worker node fix pack 1.15.12_1541, released 8 June 2020
{: #11512_1541}

The following table shows the changes that are in the worker node fix pack `1.15.12_1541`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1549](https://nvd.nist.gov/vuln/detail/CVE-2019-1549){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.12_1540" caption-side="top"}

### Changelog for 1.15.12_1540, released 26 May 2020
{: #11512_1540}

The following table shows the changes that are in the master and worker node update `1.15.12_1540`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | v1.1.1 | v1.1.4 | When cluster add-ons don't support the current cluster version, a warning is now returned in the cluster health state. |
| etcd | Master | v3.3.18 | v3.3.20 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.20){: external}. |
| Gateway-enabled cluster controller | Master | 1045 | 1082 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| GPU device plug-in and installer | Master | 8c6538f | 8b02302 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 358 | 373 | Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external} and [CVE-2020-11655](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11655){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.15.11-274 | v1.15.12-316 | Updated to support the Kubernetes 1.15.2 release. |
| Kubernetes | Both | v1.15.11 | v1.15.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.12){: external}. The master update resolves CVE-2020-8555 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6220220){: external}). |
| Kubernetes Metrics Server | Master | N/A | N/A | Increased the CPU per node for the `metrics-server` container to improve availability of the metrics server API service for large clusters. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 169 | 203 | Updated the version 2.0 network load balancers (NLB) to fix problems with long-lived network connections to endpoints that failed readiness probes. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | Worker | 4.15.0-99-generic | 4.15.0-101-generic | Updated worker node images with kernel and package updates for [CVE-2019-20795](https://nvd.nist.gov/vuln/detail/CVE-2019-20795){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616), and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1538" caption-side="top"}

### Changelog for worker node fix pack 1.15.11_1538, released 11 May 2020
{: #11511_1538}

The following table shows the changes that are in the worker node fix pack `1.15.11_1538`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1537" caption-side="top"}

### Changelog for worker node fix pack 1.15.11_1537, released 27 April 2020
{: #11511_1537}

The following table shows the changes that are in the worker node fix pack `1.15.11_1537`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1535" caption-side="top"}

### Changelog for master fix pack 1.15.11_1536, released 23 April 2020
{: #11511_1536}

The following table shows the changes that are in the master fix pack patch update `1.15.11_1536`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico configuration | N/A | N/A | Updated to allow egress from the worker nodes via the `allow-vrrp` `GlobalNetworkPolicy`. |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| OpenVPN client | N/A | N/A | Fixed a problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1535" caption-side="top"}

### Changelog for worker node fix pack 1.15.11_1535, released 13 April 2020
{: #11511_1535}

The following table shows the changes that are in the worker node fix pack `1.15.11_1535`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1534" caption-side="top"}

### Changelog for worker node fix pack 1.15.11_1534, released 30 March 2020
{: #11511_1534}

The following table shows the changes that are in the worker node fix pack `1.15.11_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.11_1533" caption-side="top"}

### Changelog for 1.15.11_1533, released 16 March 2020
{: #11511_1533}

The following table shows the changes that are in the master and worker node update `1.15.11_1533`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Cluster health image | Master | N/A | N/A | Cluster health status now includes links to {{site.data.keyword.cloud_notm}} documentation. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.15.10-252 | v1.15.11-274 | Updated to support the Kubernetes 1.15.11 release and to use `Go` version 1.12.17. Fixed VPC load balancer error message to use the current {{site.data.keyword.containerlong_notm}} plug-in CLI syntax. |
| Kubernetes | Both | v1.15.10 | v1.15.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.11){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | Worker |N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.10_1532" caption-side="top"}

### Changelog for worker node fix pack 1.15.10_1532, released 2 March 2020
{: #11510_1532}

The following table shows the changes that are in the worker node fix pack 1.15.10_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.12 | v1.2.13 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.13){: external}. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.10_1531" caption-side="top"}

### Changelog for fix pack 1.15.10_1531, released 17 February 2020
{: #11510_1531}

The following table shows the changes that are in the master and worker node fix pack update `1.15.10_1531`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}.|
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external} and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.15.8-230 | v1.15.10-252 | Updated to support the Kubernetes 1.15.10 release. |
| Kubernetes | Both | v1.15.8 | v1.15.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.10){: external}. The master update resolves CVE-2019-11254 and CVE-2020-8552 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6203780){: external}), and the worker node update resolves CVE-2020-8551 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6204874){: external}). |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}.|
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.8_1530" caption-side="top"}

### Changelog for worker node fix pack 1.15.8_1530, released 3 February 2020
{: #1158_1530}

The following table shows the changes that are in the worker node fix pack 1.15.8_1530.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.8_1529" caption-side="top"}

### Changelog for 1.15.8_1529, released 20 January 2020
{: #1158_1529}

The following table shows the changes that are in the master and worker node patch update 1.15.8_1529. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.8.4 | v3.8.6 | See the [Calico release notes](https://docs.projectcalico.org/archive/v3.8/release-notes/){: external}. |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Gateway-enabled cluster controller | 1032 | 1045 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: <code>ibmc-file-bronze-gid</code>, <code>ibmc-file-silver-gid</code>, and <code>ibmc-file-gold-gid</code>.</li><li>Fixed bugs in support of <a href="/docs/containers?topic=containers-cs_storage_nonroot">non-root user access to an NFS file share</a>.</li><li>Resolved <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551">CVE-2019-1551</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li></ul> |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.6-200 | v1.15.8-230 | Updated to support the Kubernetes 1.15.8 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.15.6 | v1.15.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.8){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1528" caption-side="top"}

### Changelog for worker node fix pack 1.15.6_1528, released 23 December 2019
{: #1156_1528}

The following table shows the changes that are in the worker node fix pack 1.15.6_1528.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1526" caption-side="top"}

### Changelog for master fix pack 1.15.6_1527, released 17 December 2019
{: #1156_1527}

The following table shows the changes that are in the master fix pack 1.15.6_1527.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Gateway-enabled cluster controller | 924 | 1032 | Support for [Adding classic infrastructure servers to gateway-enabled classic clusters](/docs/containers?topic=containers-add_workers#gateway_vsi) is now generally available (GA). In addition, the controller is updated to use Alpine base image version 3.10 and to use Go version 1.12.11. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.15.6-182 | v1.15.6-200 | Updated version 1.0 and 2.0 network load balancers (NLBs) to prefer scheduling NLB pods on worker nodes that don't currently run any NLB pods. In addition, the Virtual Private Cloud (VPC) load balancer plug-in is updated to use Go version 1.12.11. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1526" caption-side="top"}

### Changelog for worker node fix pack 1.15.6_1526, released 9 December 2019
{: #1156_1526_worker}

The following table shows the changes that are in the worker node fix pack 1.15.6_1526.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.6_1525" caption-side="top"}

### Changelog for worker node fix pack 1.15.6_1525, released 25 November 2019
{: #1156_1525_worker}

The following table shows the changes that are in the worker node fix pack 1.15.6_1525.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.15.5 | v1.15.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.6){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.5_1522" caption-side="top"}

### Changelog for master fix pack 1.15.6_1525, released 21 November 2019
{: #1156_1525}

The following table shows the changes that are in the master fix pack 1.15.6_1525.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.8.2 | v3.8.4 | See the [Calico release notes](https://docs.projectcalico.org/release-notes/){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}, and [DSA-4539-3](https://lists.debian.org/debian-security-announce/2019/msg00193.html){: external}. |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.15.5-159 | v1.15.6-182 | Updated to support the Kubernetes 1.15.6 release. `calicoctl` version is updated to v3.8.4. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.15.5 | v1.15.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.6){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.5_1522" caption-side="top"}

### Changelog for worker node fix pack 1.15.5_1522, released 11 November 2019
{: #1155_1522_worker}

The following table shows the changes that are in the worker node fix pack 1.15.5_1522.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.15.5_1521" caption-side="top"}

### Changelog for worker node fix pack 1.15.5_1521, released 28 October 2019
{: #1155_1521}

The following table shows the changes that are in the worker node fix pack `1.15.5_1521`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |    v1.15.4 |    v1.15.5    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.5){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.15.5_1520" caption-side="top"}

### Changelog for master fix pack 1.15.5_1520, released 22 October 2019
{: #1155_1520}

The following table shows the changes that are in the master fix pack `1.15.5_1520`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration to minimize [cluster service DNS resolution failures when CoreDNS pods are restarted](/docs/containers?topic=containers-coredns_lameduck). Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| Gateway-enabled cluster controller | 844 | 924 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you don't need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.4-136 | v1.15.5-159 | Updated to support the Kubernetes 1.15.5 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |    v1.15.4 |    v1.15.5    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.5){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/1098759)) and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes Metrics Server | v0.3.4 |    v0.3.6    | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6){: external}. The update also includes the following configuration changes to improve reliability and availability.<ul><li>Added <a href="https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/">Kubernetes liveness and readiness probes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li><li>Added <a href="https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/">Kubernetes pod affinity rule</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> to prefer scheduling to the same worker node as the OpenVPN client <code>vpn</code> pod in the <code>kube-system</code> namespace.</li><li>Increased metrics resolution timeout from 30 to 45 seconds.</li></ul>|
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.15.4_1519" caption-side="top"}

### Changelog for worker node fix pack 1.15.4_1519, released 14 October 2019
{: #1154_1519_worker}

The following table shows the changes that are in the worker node fix pack 1.15.4_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.15.4_1518">
<caption>Changes since version 1.15.4_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-0136">CVE-2019-0136</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20961">CVE-2018-20961</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11487">CVE-2019-11487</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2016-10905">CVE-2016-10905</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.15.4_1518, released 1 October 2019
{: #1154_1518}




The following table shows the changes that are in the patch 1.15.4_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.15.3_1517">
<caption>Changes since version 1.15.3_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.8.1</td>
<td>v3.8.2</td>
<td>See the <a href="https://docs.projectcalico.org/archive/v3.8/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to improve performance of master update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.9</td>
<td>v1.2.10</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.10">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884">CVE-2019-16884</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276">CVE-2019-16276</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Default IBM file storage class</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class.</td>
</tr>
<tr>
<td>Gateway-enabled cluster controller</td>
<td>N/A</td>
<td>844</td>
<td>New! For <a href="/docs/containers?topic=containers-clusters#gateway_cluster_cli">classic clusters with a gateway enabled</a>, a <code>DaemonSet</code> is installed to configure settings for routing network traffic to worker nodes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.15.3-112</td>
<td>v1.15.4-136</td>
<td>Updated to support the Kubernetes 1.15.4 release. In addition, version 1.0 and 2.0 network load balancers (NLBs) were updated to support <a href="/docs/containers?topic=containers-clusters#gateway_cluster_cli">classic clusters with a gateway enabled</a>.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>212</td>
<td>221</td>
<td>Improved Kubernetes <a href="/docs/containers?topic=containers-encryption#keyprotect">key management service provider</a> caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.3</td>
<td>v1.15.4</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.15.4">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.3</td>
<td>v0.3.4</td>
<td>See the <a href="https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.4">Kubernetes Metrics Server release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>148</td>
<td>153</td>
<td>Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-115</td>
<td>2.4.6-r3-IKS-121</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547">CVE-2019-1547</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563">CVE-2019-1563</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15031">CVE-2019-15031</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15030">CVE-2019-15030</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.15.3_1517, released 16 September 2019
{: #1153_1517_worker}

The following table shows the changes that are in the worker node fix pack 1.15.3_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.15.3_1516">
<caption>Changes since version 1.15.3_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.8</td>
<td>v1.2.9</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.9">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515">CVE-2019-9515</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2015-9383">CVE-2015-9383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10638">CVE-2019-10638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3900">CVE-2019-3900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20856">CVE-2018-20856</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20406">CVE-2018-20406</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15718">CVE-2019-15718</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.15.3_1516, released 3 September 2019
{: #1153_1516_worker}

The following table shows the changes that are in the worker node fix pack 1.15.3_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.15.2_1514">
<caption>Changes since version 1.15.2_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.7</td>
<td>v1.2.8</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.8">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.2</td>
<td>v1.15.3</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.15.3">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10222">CVE-2019-10222</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11922">CVE-2019-11922</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.15.3_1515, released 28 August 2019
{: #1153_1515}

The following table shows the changes that are in the master fix pack 1.15.3_1515.
{: shortdesc}

<table summary="Changes that were made since version 1.15.2_1514">
<caption>Changes since version 1.15.2_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>etcd</code></td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.15"><code>etcd</code> release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated the GPU drivers to <a href="https://www.nvidia.com/Download/driverResults.aspx/149138/">430.40</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.15.2-94</td>
<td>v1.15.3-112</td>
<td>Updated to support the Kubernetes 1.15.3 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.2</td>
<td>v1.15.3</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.15.3">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.15.2_1514, released 19 August 2019
{: #1152_1514_worker}

The following table shows the changes that are in the worker node fix pack 1.15.2_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.15.1_1511">
<caption>Changes since version 1.15.1_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA Proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA Proxy 1.8 to fix <a href="https://github.com/haproxy/haproxy/issues/136">socket leak in HA proxy</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Also added a liveliness check to monitor the health of HA Proxy. For more information, see <a href="https://www.haproxy.org/download/1.8/src/CHANGELOG">HA Proxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.1</td>
<td>v1.15.2</td>
<td>For more information, see the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.15.2">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13012">CVE-2019-13012</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2101">CVE-2019-2101</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13233">CVE-2019-13233</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13272">CVE-2019-13272</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a>, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12818">CVE-2019-12818</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12984">CVE-2019-12984</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12819">CVE-2019-12819</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.15.2_1514, released 17 August 2019
{: #1152_1514}

The following table shows the changes that are in the master fix pack 1.15.2_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.15.1_1513">
<caption>Changes since version 1.15.1_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.15.2_1513, released 15 August 2019
{: #1152_1513}

The following table shows the changes that are in the master fix pack 1.15.2_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.15.1_1511">
<caption>Changes since version 1.15.1_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico <code>calico-kube-controllers</code> deployment in the <code>kube-system</code> namespace sets a memory limit on the <code>calico-kube-controllers</code> container. In addition, the <code>calico-node</code> deployment in the <code>kube-system</code> namespace no longer includes the <code>flexvol-driver</code> init container.</td>
</tr>
<tr>
<td>Cluster health</td>
<td>N/A</td>
<td>N/A</td>
<td>Cluster health shows <code>Warning</code> state if a cluster control plane operation failed or was canceled. For more information, see <a href="/docs/containers?topic=containers-debug_clusters">Debugging clusters</a>.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>d91d200</td>
<td>07c9b67</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.15.1-86</td>
<td>v1.15.2-94</td>
<td>Updated to support the Kubernetes 1.15.2 release.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.15.1</td>
<td>v1.15.2</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.15.2">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updates resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247">CVE-2019-11247</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967115">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">) and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249">CVE-2019-11249</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967123">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-90</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.15.1_1511, released 5 August 2019
{: #1151_1511}

The following table shows the changes that are in the patch 1.15.1_1511.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1526">
<caption>Changes since version 1.14.4_1526</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.4</td>
<td>v3.8.1</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. In addition, Kubernetes version 1.15 clusters now have a new <code>allow-all-private-default</code> global network policy to allow all ingress and egress network traffic on private interface. For more information, see <a href="/docs/containers?topic=containers-network_policies#isolate_workers">Isolating clusters on the private network</a>.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.4-139</td>
<td>v1.15.1-86</td>
<td><ul><li>Updated to support the Kubernetes 1.15.1 release.</li><li><code>calicoctl</code> version is updated to 3.8.1.</li><li>Virtual Private Cloud (VPC) load balancer support is added for VPC clusters.</li></ul>.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.4</td>
<td>v1.15.1</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.15.1">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://kubernetes.io/blog/2019/06/19/kubernetes-1-15-release-announcement/">Kubernetes 1.15 blog</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248">CVE-2019-11248</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967113">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">).</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated Kubernetes API server default toleration seconds to 600 for the Kubernetes default <code>node.kubernetes.io/not-ready</code> and <code>node.kubernetes.io/unreachable</code> pod tolerations. For more information about tolerations, see <a href="https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/">Taints and Tolerations</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.4</td>
<td>1.8.5</td>
<td>For more information, see the <a href="https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.5">Kubernetes add-on resizer release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.4.0</td>
<td>1.6.0</td>
<td>For more information, see the <a href="https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.6.0">Kubernetes DNS autoscaler release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes nodelocal DNS cache</td>
<td>N/A</td>
<td>1.15.4</td>
<td>For more information, see the <a href="https://github.com/kubernetes/dns/releases/tag/1.15.4">Kubernetes nodelocal DNS cache release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information about this new beta feature, see [Setting up Nodelocal DNS Cache (beta)](/docs/containers?topic=containers-cluster_dns#dns_enablecache).</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.7-alpine</td>
<td>2.0.1-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/2.0/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>d91d200</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924">CVE-2019-9924</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11085">CVE-2019-11085</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11815">CVE-2019-11815</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11884">CVE-2019-11884</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2054">CVE-2019-2054</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>



## Version 1.14 changelog (unsupported 31 May 2020)
{: #114_changelog}

Version 1.14 is unsupported. You can review the following archive of 1.14 changelogs.
{: shortdesc}

*  [Changelog for worker node fix pack 1.14.10_1555, released 26 May 2020](#11410_1555)
*  [Changelog for worker node fix pack 1.14.10_1554, released 11 May 2020](#11410_1554)
*  [Changelog for worker node fix pack 1.14.10_1553, released 27 April 2020](#11410_1553)
*  [Changelog for master fix pack 1.14.10_1552, released 23 April 2020](#11410_1552)
*  [Changelog for worker node fix pack 1.14.10_1551, released 13 April 2020](#11410_1551)
*  [Changelog for worker node fix pack 1.14.10_1550, released 30 March 2020](#11410_1550)
*  [Changelog for worker node fix pack 1.14.10_1549, released 16 March 2020](#11410_1549)
*  [Changelog for worker node fix pack 1.14.10_1548, released 2 March 2020](#11410_1548)
*  [Changelog for fix pack 1.14.10_1547, released 17 February 2020](#11410_1547)
*  [Changelog for worker node fix pack 1.14.10_1546, released 3 February 2020](#11410_1546)
*  [Changelog for 1.14.10_1545, released 20 January 2020](#11410_1545)
*  [Changelog for worker node fix pack 1.14.9_1544, released 23 December 2019](#1149_1544)
*  [Changelog for master fix pack 1.14.9_1543, released 17 December 2019](#1149_1543)
*  [Changelog for worker node fix pack 1.14.9_1542, released 9 December 2019](#1149_1542_worker)
*  [Changelog for worker node fix pack 1.14.9_1541, released 25 November 2019](#1149_1541_worker)
*  [Changelog for master fix pack 1.14.9_1541, released 21 November 2019](#1149_1541)
*  [Changelog for worker node fix pack 1.14.8_1538, released 11 November 2019](#1148_1538_worker)
*  [Changelog for worker node fix pack 1.14.8_1537, released 28 October 2019](#1148_1537)
*  [Changelog for master fix pack 1.14.8_1536, released 22 October 2019](#1148_1536)
*  [Changelog for worker node fix pack 1.14.7_1535, released 14 October 2019](#1147_1535_worker)
*  [Changelog for 1.14.7_1534, released 1 October 2019](#1147_1534)
*  [Changelog for worker node fix pack 1.14.6_1533, released 16 September 2019](#1146_1533_worker)
*  [Changelog for worker node fix pack 1.14.6_1532, released 3 September 2019](#1146_1532_worker)
*  [Changelog for master fix pack 1.14.6_1531, released 28 August 2019](#1146_1531)
*  [Changelog for worker node fix pack 1.14.5_1530, released 19 August 2019](#1145_1530_worker)
*  [Changelog for master fix pack 1.14.5_1530, released 17 August 2019](#1145_1530)
*  [Changelog for master fix pack 1.14.5_1529, released 15 August 2019](#1145_1529)
*  [Changelog for worker node fix pack 1.14.4_1527, released 5 August 2019](#1144_1527_worker)
*  [Changelog for worker node fix pack 1.14.4_1526, released 22 July 2019](#1144_1526_worker)
*  [Changelog for master fix pack 1.14.4_1526, released 15 July 2019](#1144_1526)
*  [Changelog for worker node fix pack 1.14.3_1525, released 8 July 2019](#1143_1525)
*  [Changelog for worker node fix pack 1.14.3_1524, released 24 June 2019](#1143_1524)
*  [Changelog for 1.14.3_1523, released 17 June 2019](#1143_1523)
*  [Changelog for 1.14.2_1521, released 4 June 2019](#1142_1521)
*  [Changelog for worker node fix pack 1.14.1_1519, released 20 May 2019](#1141_1519)
*  [Changelog for 1.14.1_1518, released 13 May 2019](#1141_1518)
*  [Changelog for 1.14.1_1516, released 7 May 2019](#1141_1516)

### Changelog for worker node fix pack 1.14.10_1555, released 26 May 2020
{: #11410_1555}

The following table shows the changes that are in the worker node fix pack `1.14.10_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-99-generic | 4.15.0-101-generic | Updated worker node images with kernel and package updates for [CVE-2019-20795](https://nvd.nist.gov/vuln/detail/CVE-2019-20795){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616), and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1554" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1554, released 11 May 2020
{: #11410_1554}

The following table shows the changes that are in the worker node fix pack `1.14.10_1554`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1553" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1553, released 27 April 2020
{: #11410_1553}

The following table shows the changes that are in the worker node fix pack `1.14.10_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1551" caption-side="top"}

### Changelog for master fix pack 1.14.10_1552, released 23 April 2020
{: #11410_1552}

The following table shows the changes that are in the master fix pack patch update `1.14.10_1552`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico configuration | N/A | N/A | Updated to allow egress from the worker nodes via the `allow-vrrp` `GlobalNetworkPolicy`. |
| Cluster health | N/A | v1.1.1 | Cluster health now includes more add-on status information. |
| GPU device plug-in and installer | 49979f5 | 8c6538f | Updated the GPU drivers to version [440.33.01](https://www.nvidia.com/download/driverResults.aspx/154570){: external}. |
| Key Management Service provider | 277 | v1.0.0 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} `Go` client. |
| OpenVPN client | N/A | N/A | Fixed a problem that might cause the `vpn-config` secret in the `kube-system` namespace to be deleted during cluster master operations. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1551" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1551, released 13 April 2020
{: #11410_1551}

The following table shows the changes that are in the worker node fix pack `1.14.10_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1550" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1550, released 30 March 2020
{: #11410_1550}

The following table shows the changes that are in the worker node fix pack `1.14.10_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786), and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349), and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1549" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1549, released 16 March 2020
{: #11410_1549}

The following table shows the changes that are in the worker node fix pack 1.14.10_1549. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1548" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1548, released 2 March 2020
{: #11410_1548}

The following table shows the changes that are in the worker node fix pack 1.14.10_1548. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.12 | v1.2.13 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.13){: external}. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1547" caption-side="top"}

### Changelog for fix pack 1.14.10_1547, released 17 February 2020
{: #11410_1547}

The following table shows the changes that are in the master and worker node fix pack update `1.14.10_1547`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12). Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}, and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844) [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1546" caption-side="top"}

### Changelog for worker node fix pack 1.14.10_1546, released 3 February 2020
{: #11410_1546}

The following table shows the changes that are in the worker node fix pack 1.14.10_1546.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.10_1545" caption-side="top"}

### Changelog for 1.14.10_1545, released 20 January 2020
{: #11410_1545}

The following table shows the changes that are in the master and worker node patch update 1.14.10_1545. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: <code>ibmc-file-bronze-gid</code>, <code>ibmc-file-silver-gid</code>, and <code>ibmc-file-gold-gid</code>.</li><li>Fixed bugs in support of <a href="/docs/containers?topic=containers-cs_storage_nonroot">non-root user access to an NFS file share</a>.</li><li>Resolved <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551">CVE-2019-1551</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li></ul> |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.9-239    | v1.14.10-288 | Updated to support the Kubernetes 1.14.10 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.14.9 |    v1.14.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.10){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1544" caption-side="top"}

### Changelog for worker node fix pack 1.14.9_1544, released 23 December 2019
{: #1149_1544}

The following table shows the changes that are in the worker node fix pack 1.14.9_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1542" caption-side="top"}

### Changelog for master fix pack 1.14.9_1543, released 17 December 2019
{: #1149_1543}

The following table shows the changes that are in the master fix pack 1.14.9_1543.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1542" caption-side="top"}

### Changelog for worker node fix pack 1.14.9_1542, released 9 December 2019
{: #1149_1542_worker}

The following table shows the changes that are in the worker node fix pack 1.14.9_1542.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.9_1541" caption-side="top"}

### Changelog for worker node fix pack 1.14.9_1541, released 25 November 2019
{: #1149_1541_worker}

The following table shows the changes that are in the worker node fix pack 1.14.9_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.14.8 | v1.14.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.9){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.8_1538" caption-side="top"}

### Changelog for master fix pack 1.14.9_1541, released 21 November 2019
{: #1149_1541}

The following table shows the changes that are in the master fix pack 1.14.9_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.14.8-219 | v1.14.9-239 | Updated to support the Kubernetes 1.14.9 release. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.14.8 | v1.14.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.9){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.8_1538" caption-side="top"}

### Changelog for worker node fix pack 1.14.8_1538, released 11 November 2019
{: #1148_1538_worker}

The following table shows the changes that are in the worker node fix pack 1.14.8_1538.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.14.8_1537" caption-side="top"}

### Changelog for worker node fix pack 1.14.8_1537, released 28 October 2019
{: #1148_1537}

The following table shows the changes that are in the worker node fix pack `1.14.8_1537`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |    v1.14.7 |    v1.14.8    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.8){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.14.8_1536" caption-side="top"}

### Changelog for master fix pack 1.14.8_1536, released 22 October 2019
{: #1148_1536}

The following table shows the changes that are in the master fix pack `1.14.8_1536`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration to minimize [cluster service DNS resolution failures when CoreDNS pods are restarted](/docs/containers?topic=containers-coredns_lameduck). Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you don't need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.7-199 | v1.14.8-219 | Updated to support the Kubernetes 1.14.8 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |    v1.14.7 |    v1.14.8    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.8){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/1098759)) and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.14.7_1535" caption-side="top"}

### Changelog for worker node fix pack 1.14.7_1535, released 14 October 2019
{: #1147_1535_worker}

The following table shows the changes that are in the worker node fix pack 1.14.7_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.14.7_1534">
<caption>Changes since version 1.14.7_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-0136">CVE-2019-0136</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20961">CVE-2018-20961</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11487">CVE-2019-11487</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2016-10905">CVE-2016-10905</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.7_1534, released 1 October 2019
{: #1147_1534}

The following table shows the changes that are in the patch 1.14.7_1534.
{: shortdesc}




<table summary="Changes that were made since version 1.14.6_1533">
<caption>Changes since version 1.14.6_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.4</td>
<td>v3.6.5</td>
<td>See the <a href="https://docs.projectcalico.org/archive/v3.6/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to improve performance of master update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.9</td>
<td>v1.2.10</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.10">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884">CVE-2019-16884</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276">CVE-2019-16276</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Default IBM file storage class</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.6-172</td>
<td>v1.14.7-199</td>
<td>Updated to support the Kubernetes 1.14.7 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>212</td>
<td>221</td>
<td>Improved Kubernetes <a href="/docs/containers?topic=containers-encryption#keyprotect">key management service provider</a> caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.6</td>
<td>v1.14.7</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.7">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>148</td>
<td>153</td>
<td>Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-115</td>
<td>2.4.6-r3-IKS-121</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547">CVE-2019-1547</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563">CVE-2019-1563</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15031">CVE-2019-15031</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15030">CVE-2019-15030</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.14.6_1533, released 16 September 2019
{: #1146_1533_worker}

The following table shows the changes that are in the worker node fix pack 1.14.6_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.14.6_1532">
<caption>Changes since version 1.14.6_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.8</td>
<td>v1.2.9</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.9">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515">CVE-2019-9515</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2015-9383">CVE-2015-9383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10638">CVE-2019-10638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3900">CVE-2019-3900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20856">CVE-2018-20856</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">,<a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20406">CVE-2018-20406</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15718">CVE-2019-15718</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.6_1532, released 3 September 2019
{: #1146_1532_worker}

The following table shows the changes that are in the worker node fix pack 1.14.6_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.14.5_1530">
<caption>Changes since version 1.14.5_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.7</td>
<td>v1.2.8</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.8">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.5</td>
<td>v1.14.6</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.6">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10222">CVE-2019-10222</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11922">CVE-2019-11922</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.14.6_1531, released 28 August 2019
{: #1146_1531}

The following table shows the changes that are in the master fix pack 1.14.6_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.14.5_1530">
<caption>Changes since version 1.14.5_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>etcd</code></td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.15"><code>etcd</code> release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated the GPU drivers to <a href="https://www.nvidia.com/Download/driverResults.aspx/149138/">430.40</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.5-160</td>
<td>v1.14.6-172</td>
<td>Updated to support the Kubernetes 1.14.6 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.5</td>
<td>v1.14.6</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.6">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.5_1530, released 19 August 2019
{: #1145_1530_worker}

The following table shows the changes that are in the worker node fix pack 1.14.5_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1527">
<caption>Changes since version 1.14.4_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA proxy 1.8 to fix <a href="https://github.com/haproxy/haproxy/issues/136">socket leak in HA proxy</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Also added a liveliness check to monitor the health of HA proxy. For more information, see <a href="https://www.haproxy.org/download/1.8/src/CHANGELOG">HA proxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.4</td>
<td>v1.14.5</td>
<td>For more information, see the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.5">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13012">CVE-2019-13012</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2101">CVE-2019-2101</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13233">CVE-2019-13233</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13272">CVE-2019-13272</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a>, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12818">CVE-2019-12818</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12984">CVE-2019-12984</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12819">CVE-2019-12819</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.14.5_1530, released 17 August 2019
{: #1145_1530}

The following table shows the changes that are in the master fix pack 1.14.5_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.14.5_1529">
<caption>Changes since version 1.14.5_1529</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.14.5_1529, released 15 August 2019
{: #1145_1529}

The following table shows the changes that are in the master fix pack 1.14.5_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1527">
<caption>Changes since version 1.14.4_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico <code>calico-kube-controllers</code> deployment in the <code>kube-system</code> namespace sets a memory limit on the <code>calico-kube-controllers</code> container.</td>
</tr>
<tr>
<td>Cluster health</td>
<td>N/A</td>
<td>N/A</td>
<td>Cluster health shows <code>Warning</code> state if a cluster control plane operation failed or was canceled. For more information, see <a href="/docs/containers?topic=containers-debug_clusters">Debugging clusters</a>.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>07c9b67</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924">CVE-2019-9924</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.4-139</td>
<td>v1.14.5-160</td>
<td>Updated to support the Kubernetes 1.14.5 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.4</td>
<td>v1.14.5</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.5">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updates resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247">CVE-2019-11247</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967115">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">) and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249">CVE-2019-11249</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967123">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">).</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.4_1527, released 5 August 2019
{: #1144_1527_worker}

The following table shows the changes that are in the worker node fix pack 1.14.4_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.14.4_1526">
<caption>Changes since version 1.14.4_1526</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11085">CVE-2019-11085</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11815">CVE-2019-11815</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11884">CVE-2019-11884</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2054">CVE-2019-2054</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11815">CVE-2019-11815</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11884">CVE-2019-11884</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.4_1526, released 22 July 2019
{: #1144_1526_worker}

The following table shows the changes that are in the worker node fix pack 1.14.4_1526.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1525">
<caption>Changes since version 1.14.3_1525</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.14.3</td>
<td>v1.14.4</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.4">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248">CVE-2019-11248</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see <a href="https://www.ibm.com/support/pages/node/967113">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">).</td>
</tr>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for <a href="https://ubuntu.com/security/CVE-2019-13012">CVE-2019-13012</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-7307.html">CVE-2019-7307</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for master fix pack 1.14.4_1526, released 15 July 2019
{: #1144_1526}

The following table shows the changes that are in the master fix pack 1.14.4_1526.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1525">
<caption>Changes since version 1.14.3_1525</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.1</td>
<td>v3.6.4</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://www.tigera.io/security-bulletins/#TTA-2019-001">TTA-2019-001</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/959551">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the <code>kubernetes</code> zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see <a href="/docs/containers?topic=containers-cluster_dns#dns_customize">Customizing the cluster DNS provider</a>.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>5d34347</td>
<td>a7e8ece</td>
<td>Updated base image packages.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.3</td>
<td>v1.14.4</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.4">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.3-113</td>
<td>v1.14.4-139</td>
<td>Updated to support the Kubernetes 1.14.4 release. Additionally, <code>calicoctl</code> version is updated to 3.6.4.</td>
</tr>
    </tbody>
</table>

### Changelog for worker node fix pack 1.14.3_1525, released 8 July 2019
{: #1143_1525}

The following table shows the changes that are in the worker node patch 1.14.3_1525.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1524">
<caption>Changes since version 1.14.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.14.3_1524, released 24 June 2019
{: #1143_1524}

The following table shows the changes that are in the worker node patch 1.14.3_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.14.3_1523">
<caption>Changes since version 1.14.3_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.6</td>
<td>1.2.7</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.7">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Max pods</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased the limit of maximum number of pods for worker nodes with more than 11 CPU cores to be 10 pods per core, up to a maximum of 250 pods per worker node.</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.3_1523, released 17 June 2019
{: #1143_1523}

The following table shows the changes that are in the patch 1.14.3_1523.
{: shortdesc}

<table summary="Changes that were made since version 1.14.2_1521">
<caption>Changes since version 1.14.2_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>32257d3</td>
<td>5d34347</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457">CVE-2019-8457</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated the GPU drivers to <a href="https://www.nvidia.com/Download/driverResults.aspx/147582/">430.14</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>346</td>
<td>347</td>
<td>Updated so that the IAM API key can be either encrypted or unencrypted.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.2-100</td>
<td>v1.14.3-113</td>
<td>Updated to support the Kubernetes 1.14.3 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.2</td>
<td>v1.14.3</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.3">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes feature gates configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the <code>SupportNodePidsLimit=true</code> configuration to reserve process IDs (PIDs) for use by the operating system and Kubernetes components. Added the <code>CustomCPUCFSQuotaPeriod=true</code> configuration to mitigate CPU throttling problems.</td>
</tr>
<tr>
<td>Public service endpoint for Kubernetes master</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed an issue to <a href="/docs/containers?topic=containers-cs_network_cluster#set-up-public-se">enable the public cloud service endpoint</a>.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.2_1521, released 4 June 2019
{: #1142_1521}

The following table shows the changes that are in the patch 1.14.2_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.14.1_1519">
<caption>Changes since version 1.14.1_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster <code>create</code> or <code>update</code> operations.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.13">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.14.1-71</td>
<td>v1.14.2-100</td>
<td>Updated to support the Kubernetes 1.14.2 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.14.1</td>
<td>v1.14.2</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.2">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.1</td>
<td>v0.3.3</td>
<td>See the <a href="https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3">Kubernetes Metrics Server release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.14.1_1519, released 20 May 2019
{: #1141_1519}

The following table shows the changes that are in the patch 1.14.1_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.14.1_1518">
<caption>Changes since version 1.14.1_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.1_1518, released 13 May 2019
{: #1141_1518}

The following table shows the changes that are in the patch 1.14.1_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.14.1_1516">
<caption>Changes since version 1.14.1_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706">CVE-2019-6706</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the <code>/openapi/v2*</code> read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed <code>kubelet</code> certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client <code>vpn-*</code> pod in the <code>kube-system</code> namespace now sets <code>dnsPolicy</code> to <code>Default</code> to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e7182c7</td>
<td>13c7ef0</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076">CVE-2016-7076</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368">CVE-2017-1000368</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.14.1_1516, released 7 May 2019
{: #1141_1516}

The following table shows the changes that are in the patch 1.14.1_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1519">
<caption>Changes since version 1.13.5_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.4.4</td>
<td>v3.6.1</td>
<td>See the <a href="https://docs.projectcalico.org/archive/v3.6/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>1.2.6</td>
<td>1.3.1</td>
<td>See the <a href="https://coredns.io/2019/01/13/coredns-1.3.1-release/">CoreDNS release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. The update includes the addition of a <a href="https://coredns.io/plugins/metrics/">metrics port</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> on the cluster DNS service. <br><br>CoreDNS is now the only supported cluster DNS provider. If you update a cluster to Kubernetes version 1.14 from an earlier version and used KubeDNS, KubeDNS is automatically migrated to CoreDNS during the cluster update. For more information or to test out CoreDNS before you update, see <a href="/docs/containers?topic=containers-cluster_dns#cluster_dns">Configure the cluster DNS provider</a>.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>ed0dafc</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.5-107</td>
<td>v1.14.1-71</td>
<td>Updated to support the Kubernetes 1.14.1 release. Additionally, <code>calicoctl</code> version is updated to 3.6.1. Fixed updates to version 2.0 network load balancers (NLBs) with only one available worker node for the load balancer pods. Private load balancers now support running on <a href="/docs/containers?topic=containers-edge#edge">private edge workers nodes</a>.</td>
</tr>
<tr>
<td>IBM pod security policies</td>
<td>N/A</td>
<td>N/A</td>
<td><a href="/docs/containers?topic=containers-psp#ibm_psp">IBM pod security policies</a> are updated to support the Kubernetes <a href="https://kubernetes.io/docs/concepts/policy/pod-security-policy/#users-and-groups">RunAsGroup</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> feature.</td>
</tr>
<tr>
<td><code>kubelet</code> configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the <code>--pod-max-pids</code> option to <code>14336</code> to prevent a single pod from consuming all process IDs on a worker node.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.5</td>
<td>v1.14.1</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.14.1">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://kubernetes.io/blog/2019/03/25/kubernetes-1-14-release-announcement/">Kubernetes 1.14 blog</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.<br><br>The Kubernetes default role-based access control (RBAC) policies no longer grant access to <a href="https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles">discovery and permission-checking APIs to unauthenticated users</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. This change applies only to new version 1.14 clusters. If you update a cluster from a prior version, unauthenticated users still have access to the discovery and permission-checking APIs.</td>
</tr>
<tr>
<td>Kubernetes admission controllers configuration</td>
<td>N/A</td>
<td>N/A</td>
<td><ul>
<li>Added <code>NodeRestriction</code> to the <code>--enable-admission-plugins</code> option for the cluster's Kubernetes API server and configured the related cluster resources to support this security enhancement.</li>
<li>Removed <code>Initializers</code> from the <code>--enable-admission-plugins</code> option and <code>admissionregistration.k8s.io/v1alpha1=true</code> from the <code>--runtime-config</code> option for the cluster's Kubernetes API server because these APIs are no longer supported. Instead, you can use <a href="https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/">Kubernetes admission webhooks</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li></ul></td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.3.0</td>
<td>1.4.0</td>
<td>See the <a href="https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.4.0">Kubernetes DNS autoscaler release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes feature gates configuration</td>
<td>N/A</td>
<td>N/A</td>
<td><ul>
    <li>Added <code>RuntimeClass=false</code> to disable selection of the container runtime configuration.</li>
    <li>Removed <code>ExperimentalCriticalPodAnnotation=true</code> because the <code>scheduler.alpha.kubernetes.io/critical-pod</code> pod annotation is no longer supported. Instead, you can use <a href="/docs/containers?topic=containers-pod_priority#pod_priority">Kubernetes pod priority</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li></ul></td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>e7182c7</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068">CVE-2019-11068</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>



## Version 1.13 changelog (unsupported 22 February 2020)
{: #113_changelog}

Version 1.13 is unsupported. You can review the following archive of 1.13 changelogs.
{: shortdesc}

* [Changelog for fix pack 1.13.12_1550, released 17 February 2020](#11312_1550)
* [Changelog for worker node fix pack 1.13.12_1549, released 3 February 2020](#11312_1549)
* [Changelog for 1.13.12_1548, released 20 January 2020](#11312_1548)
* [Changelog for worker node fix pack 1.13.12_1547, released 23 December 2019](#11312_1547)
* [Changelog for master fix pack 1.13.12_1546, released 17 December 2019](#11312_1546)
* [Changelog for worker node fix pack 1.13.12_1545, released 9 December 2019](#11312_1545_worker)
* [Changelog for worker node fix pack 1.13.12_1544, released 25 November 2019](#11312_1544_worker)
* [Changelog for master fix pack 1.13.12_1544, released 21 November 2019](#11312_1544)
* [Changelog for worker node fix pack 1.13.12_1541, released 11 November 2019](#11312_1541_worker)
* [Changelog for worker node fix pack 1.13.12_1540, released 28 October 2019](#11312_1540)
* [Changelog for master fix pack 1.13.12_1539, released 22 October 2019](#11312_1539)
* [Changelog for worker node fix pack 1.13.11_1538, released 14 October 2019](#11311_1538_worker)
* [Changelog for 1.13.11_1537, released 1 October 2019](#11311_1537)
* [Changelog for worker node fix pack 1.13.10_1536, released 16 September 2019](#11310_1536_worker)
* [Changelog for worker node fix pack 1.13.10_1535, released 3 September 2019](#11310_1535_worker)
* [Changelog for master fix pack 1.13.10_1534, released 28 August 2019](#11310_1534)
* [Changelog for worker node fix pack 1.13.9_1533, released 19 August 2019](#1139_1533_worker)
* [Changelog for master fix pack 1.13.9_1533, released 17 August 2019](#1139_1533)
* [Changelog for master fix pack 1.13.9_1532, released 15 August 2019](#1139_1532)
* [Changelog for worker node fix pack 1.13.8_1530, released 5 August 2019](#1138_1530_worker)
* [Changelog for worker node fix pack 1.13.8_1529, released 22 July 2019](#1138_1529_worker)
* [Changelog for master fix pack 1.13.8_1529, released 15 July 2019](#1138_1529)
* [Changelog for worker node fix pack 1.13.7_1528, released 8 July 2019](#1137_1528)
* [Changelog for worker node fix pack 1.13.7_1527, released 24 June 2019](#1137_1527)
* [Changelog for 1.13.7_1526, released 17 June 2019](#1137_1526)
* [Changelog for 1.13.6_1524, released 4 June 2019](#1136_1524)
* [Changelog for worker node fix pack 1.13.6_1522, released 20 May 2019](#1136_1522)
* [Changelog for 1.13.6_1521, released 13 May 2019](#1136_1521)
* [Changelog for worker node fix pack 1.13.5_1519, released 29 April 2019](#1135_1519)
* [Changelog for worker node fix pack 1.13.5_1518, released 15 April 2019](#1135_1518)
* [Changelog for 1.13.5_1517, released 8 April 2019](#1135_1517)
* [Changelog for worker node fix pack 1.13.4_1516, released 1 April 2019](#1134_1516)
* [Changelog for master fix pack 1.13.4_1515, released 26 March 2019](#1134_1515)
* [Changelog for 1.13.4_1513, released 20 March 2019](#1134_1513)
* [Changelog for 1.13.4_1510, released 4 March 2019](#1134_1510)
* [Changelog for worker node fix pack 1.13.2_1509, released 27 February 2019](#1132_1509)
* [Changelog for worker node fix pack 1.13.2_1508, released 15 February 2019](#1132_1508)
* [Changelog for 1.13.2_1507, released 5 February 2019](#1132_1507)

### Changelog for fix pack 1.13.12_1550, released 17 February 2020
{: #11312_1550}

The following table shows the changes that are in the master and worker node fix pack update `1.13.12_1550`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844) and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712). |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is where the component is located, the master, worker node, or both. The third column is the previous version number of the component. The fourth column is the current version number of the component. The fifth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1549" caption-side="top"}

### Changelog for worker node fix pack 1.13.12_1549, released 3 February 2020
{: #11312_1549}

The following table shows the changes that are in the worker node fix pack 1.13.12_1549.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1548" caption-side="top"}

### Changelog for 1.13.12_1548, released 20 January 2020
{: #11312_1548}

The following table shows the changes that are in the master and worker node patch update 1.13.12_1548. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627) and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | <ul><li>Added the following storage classes: <code>ibmc-file-bronze-gid</code>, <code>ibmc-file-silver-gid</code>, and <code>ibmc-file-gold-gid</code>.</li><li>Fixed bugs in support of <a href="/docs/containers?topic=containers-cs_storage_nonroot">non-root user access to an NFS file share</a>.</li><li>Resolved <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551">CVE-2019-1551</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</li></ul> |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1547" caption-side="top"}

### Changelog for worker node fix pack 1.13.12_1547, released 23 December 2019
{: #11312_1547}

The following table shows the changes that are in the worker node fix pack 1.13.12_1547.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1545" caption-side="top"}

### Changelog for master fix pack 1.13.12_1546, released 17 December 2019
{: #11312_1546}

The following table shows the changes that are in the master fix pack 1.13.12_1546.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1545" caption-side="top"}

### Changelog for worker node fix pack 1.13.12_1545, released 9 December 2019
{: #11312_1545_worker}

The following table shows the changes that are in the worker node fix pack 1.13.12_1545.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1544" caption-side="top"}

### Changelog for worker node fix pack 1.13.12_1544, released 25 November 2019
{: #11312_1544_worker}

The following table shows the changes that are in the worker node fix pack 1.13.12_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1541" caption-side="top"}

### Changelog for master fix pack 1.13.12_1544, released 21 November 2019
{: #11312_1544}

The following table shows the changes that are in the master fix pack 1.13.12_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor    | 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1541" caption-side="top"}

### Changelog for worker node fix pack 1.13.12_1541, released 11 November 2019
{: #11312_1541_worker}

The following table shows the changes that are in the worker node fix pack 1.13.12_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: summary="The rows are read from left to right. The first column is the changed component. The second column is the previous version number of the component. The third column is the current version number of the component. The fourth column contains a brief description of the change made to the component."}
{: caption="Changes since version 1.13.12_1540" caption-side="top"}

### Changelog for worker node fix pack 1.13.12_1540, released 28 October 2019
{: #11312_1540}

The following table shows the changes that are in the worker node fix pack `1.13.12_1540`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |    v1.13.11 |    v1.13.12    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.12){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.13.12_1539" caption-side="top"}

### Changelog for master fix pack 1.13.12_1539, released 22 October 2019
{: #11312_1539}

The following table shows the changes that are in the master fix pack `1.13.12_1539`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.cloud_notm}} File Storage plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you don't need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.11-248 | v1.13.12-268 | Updated to support the Kubernetes 1.13.12 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |    v1.13.11 |    v1.13.12    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.12){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/support/pages/node/1098759)) and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.13.11_1538" caption-side="top"}

### Changelog for worker node fix pack 1.13.11_1538, released 14 October 2019
{: #11311_1538_worker}

The following table shows the changes that are in the worker node fix pack 1.13.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.13.11_1537">
<caption>Changes since version 1.13.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-0136">CVE-2019-0136</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20961">CVE-2018-20961</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11487">CVE-2019-11487</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2016-10905">CVE-2016-10905</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.11_1537, released 1 October 2019
{: #11311_1537}

The following table shows the changes that are in the patch 1.13.11_1537.
{: shortdesc}





<table summary="Changes that were made since version 1.13.10_1536">
<caption>Changes since version 1.13.10_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.6.4</td>
<td>v3.6.5</td>
<td>See the <a href="https://docs.projectcalico.org/archive/v3.6/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to improve performance of master update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.9</td>
<td>v1.2.10</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.10">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884">CVE-2019-16884</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276">CVE-2019-16276</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Default IBM file storage class</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.10-221</td>
<td>v1.13.11-248</td>
<td>Updated to support the Kubernetes 1.13.11 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>212</td>
<td>221</td>
<td>Improved Kubernetes <a href="/docs/containers?topic=containers-encryption#keyprotect">key management service provider</a> caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.10</td>
<td>v1.13.11</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.11">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>148</td>
<td>153</td>
<td>Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-115</td>
<td>2.4.6-r3-IKS-121</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547">CVE-2019-1547</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563">CVE-2019-1563</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15031">CVE-2019-15031</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15030">CVE-2019-15030</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.13.10_1536, released 16 September 2019
{: #11310_1536_worker}

The following table shows the changes that are in the worker node fix pack 1.13.10_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.13.10_1535">
<caption>Changes since version 1.13.10_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.8</td>
<td>v1.2.9</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.9">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515">CVE-2019-9515</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2015-9383">CVE-2015-9383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10638">CVE-2019-10638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3900">CVE-2019-3900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20856">CVE-2018-20856</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">,<a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20406">CVE-2018-20406</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15718">CVE-2019-15718</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.10_1535, released 3 September 2019
{: #11310_1535_worker}

The following table shows the changes that are in the worker node fix pack 1.13.10_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.13.9_1533">
<caption>Changes since version 1.13.9_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>v1.2.7</td>
<td>v1.2.8</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.8">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.9</td>
<td>v1.13.10</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.10">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10222">CVE-2019-10222</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11922">CVE-2019-11922</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.13.10_1534, released 28 August 2019
{: #11310_1534}

The following table shows the changes that are in the master fix pack 1.13.10_1534.
{: shortdesc}

<table summary="Changes that were made since version 1.13.9_1533">
<caption>Changes since version 1.13.9_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>etcd</code></td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.15"><code>etcd</code> release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated the GPU drivers to <a href="https://www.nvidia.com/Download/driverResults.aspx/149138/">430.40</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.9-209</td>
<td>v1.13.10-221</td>
<td>Updated to support the Kubernetes 1.13.10 release.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.9</td>
<td>v1.13.10</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.10">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">), and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.9_1533, released 19 August 2019
{: #1139_1533_worker}

The following table shows the changes that are in the worker node fix pack 1.13.9_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.13.8_1530">
<caption>Changes since version 1.13.8_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA proxy 1.8 to fix <a href="https://github.com/haproxy/haproxy/issues/136">socket leak in HA proxy</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Also added a liveliness check to monitor the health of HA proxy. For more information, see <a href="https://www.haproxy.org/download/1.8/src/CHANGELOG">HA proxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.8</td>
<td>v1.13.9</td>
<td>For more information, see the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.9">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13012">CVE-2019-13012</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2101">CVE-2019-2101</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13233">CVE-2019-13233</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13272">CVE-2019-13272</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a>, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12818">CVE-2019-12818</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12984">CVE-2019-12984</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12819">CVE-2019-12819</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for master fix pack 1.13.9_1533, released 17 August 2019
{: #1139_1533}

The following table shows the changes that are in the master fix pack 1.13.9_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.13.9_1532">
<caption>Changes since version 1.13.9_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.13.9_1532, released 15 August 2019
{: #1139_1532}

The following table shows the changes that are in the master fix pack 1.13.9_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.13.8_1530">
<caption>Changes since version 1.13.8_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico <code>calico-kube-controllers</code> deployment in the <code>kube-system</code> namespace sets a memory limit on the <code>calico-kube-controllers</code> container.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>07c9b67</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924">CVE-2019-9924</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.filestorage_full_notm}} plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.8-188</td>
<td>v1.13.9-209</td>
<td>Updated to support the Kubernetes 1.13.9 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.8</td>
<td>v1.13.9</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.9">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updates resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247">CVE-2019-11247</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967115">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">) and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249">CVE-2019-11249</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967123">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">).</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.13</td>
<td>1.15.4</td>
<td>See the <a href="https://github.com/kubernetes/dns/releases/tag/1.15.4">Kubernetes DNS release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Image update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.8_1530, released 5 August 2019
{: #1138_1530_worker}

The following table shows the changes that are in the worker node fix pack 1.13.8_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.13.8_1529">
<caption>Changes since version 1.13.8_1529</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11085">CVE-2019-11085</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11815">CVE-2019-11815</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11884">CVE-2019-11884</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2054">CVE-2019-2054</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.8_1529, released 22 July 2019
{: #1138_1529_worker}

The following table shows the changes that are in the worker node fix pack 1.13.8_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1528">
<caption>Changes since version 1.13.7_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.13.7</td>
<td>v1.13.8</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.8">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248">CVE-2019-11248</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> (see <a href="https://www.ibm.com/support/pages/node/967113">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">).</td>
</tr>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for <a href="https://ubuntu.com/security/CVE-2019-13012">CVE-2019-13012</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-7307.html">CVE-2019-7307</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
    </tbody>
</table>


### Changelog for master fix pack 1.13.8_1529, released 15 July 2019
{: #1138_1529}

The following table shows the changes that are in the master fix pack 1.13.8_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1528">
<caption>Changes since version 1.13.7_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.4.4</td>
<td>v3.6.4</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://www.tigera.io/security-bulletins/#TTA-2019-001">TTA-2019-001</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/959551">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the <code>kubernetes</code> zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see <a href="/docs/containers?topic=containers-cluster_dns#dns_customize">Customizing the cluster DNS provider</a>.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>5d34347</td>
<td>a7e8ece</td>
<td>Updated base image packages.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.7</td>
<td>v1.13.8</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.8">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.7-162</td>
<td>v1.13.8-188</td>
<td>Updated to support the Kubernetes 1.13.8 release. Additionally, <code>calicoctl</code> version is updated to 3.6.4.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.7_1528, released 8 July 2019
{: #1137_1528}

The following table shows the changes that are in the worker node patch 1.13.7_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1527">
<caption>Changes since version 1.13.7_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.13.7_1527, released 24 June 2019
{: #1137_1527}

The following table shows the changes that are in the worker node patch 1.13.7_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.13.7_1526">
<caption>Changes since version 1.13.7_1526</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.6</td>
<td>1.2.7</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.7">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Max pods</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased the limit of maximum number of pods for worker nodes with more than 11 CPU cores to be 10 pods per core, up to a maximum of 250 pods per worker node.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.7_1526, released 17 June 2019
{: #1137_1526}

The following table shows the changes that are in the patch 1.13.7_1526.
{: shortdesc}

<table summary="Changes that were made since version 1.13.6_1524">
<caption>Changes since version 1.13.6_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>32257d3</td>
<td>5d34347</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457">CVE-2019-8457</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated the GPU drivers to <a href="https://www.nvidia.com/Download/driverResults.aspx/147582/">430.14</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>346</td>
<td>347</td>
<td>Updated so that the IAM API key can be either encrypted or unencrypted.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.6-139</td>
<td>v1.13.7-162</td>
<td>Updated to support the Kubernetes 1.13.7 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.6</td>
<td>v1.13.7</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.7">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<td>Public service endpoint for Kubernetes master</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed an issue to <a href="/docs/containers?topic=containers-cs_network_cluster#set-up-public-se">enable the public cloud service endpoint</a>.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.6_1524, released 4 June 2019
{: #1136_1524}

The following table shows the changes that are in the patch 1.13.6_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.13.6_1522">
<caption>Changes since version 1.13.6_1522</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster <code>create</code> or <code>update</code> operations.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.13">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.1</td>
<td>v0.3.3</td>
<td>See the <a href="https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3">Kubernetes Metrics Server release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.6_1522, released 20 May 2019
{: #1136_1522}

The following table shows the changes that are in the patch 1.13.6_1522.
{: shortdesc}

<table summary="Changes that were made since version 1.13.6_1521">
<caption>Changes since version 1.13.6_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.6_1521, released 13 May 2019
{: #1136_1521}

The following table shows the changes that are in the patch 1.13.6_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1519">
<caption>Changes since version 1.13.5_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706">CVE-2019-6706</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>55c1f66</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.5-107</td>
<td>v1.13.6-139</td>
<td>Updated to support the Kubernetes 1.13.6 release. Also, fixed the update process for version 2.0 network load balancer that have only one available worker node for the load balancer pods.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.5</td>
<td>v1.13.6</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.6">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the <code>/openapi/v2*</code> read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed <code>kubelet</code> certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client <code>vpn-*</code> pod in the <code>kube-system</code> namespace now sets <code>dnsPolicy</code> to <code>Default</code> to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>13c7ef0</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076">CVE-2016-7076</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368">CVE-2017-1000368</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068">CVE-2019-11068</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.5_1519, released 29 April 2019
{: #1135_1519}

The following table shows the changes that are in the worker node fix pack 1.13.5_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1518">
<caption>Changes since version 1.13.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.5</td>
<td>1.2.6</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.6">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.5_1518, released 15 April 2019
{: #1135_1518}

The following table shows the changes that are in the worker node fix pack 1.13.5_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.13.5_1517">
<caption>Changes since version 1.13.5_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including <code>systemd</code> for <a href="https://ubuntu.com/security/CVE-2019-3842.html">CVE-2019-3842</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.5_1517, released 8 April 2019
{: #1135_1517}

The following table shows the changes that are in the patch 1.13.5_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1516">
<caption>Changes since version 1.13.4_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.4.0</td>
<td>v3.4.4</td>
<td>See the <a href="https://docs.projectcalico.org/releases/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946">CVE-2019-9946</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/879585">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.4-86</td>
<td>v1.13.5-107</td>
<td>Updated to support the Kubernetes 1.13.5 and Calico 3.4.4 releases.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.4</td>
<td>v1.13.5</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.5">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447">CVE-2017-12447</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.4_1516, released 1 April 2019
{: #1134_1516}

The following table shows the changes that are in the worker node fix pack 1.13.4_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1515">
<caption>Changes since version 1.13.4_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.13.4_1515, released 26 March 2019
{: #1134_1515}

The following table shows the changes that are in the master fix pack 1.13.4_1515.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1513">
<caption>Changes since version 1.13.4_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed the update process from Kubernetes version 1.11 to prevent the update from switching the cluster DNS provider to CoreDNS. You can still set up CoreDNS as the cluster DNS provider after the update.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent <code>context deadline exceeded</code> and <code>timeout</code> errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.4_1513, released 20 March 2019
{: #1134_1513}

The following table shows the changes that are in the patch 1.13.4_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.13.4_1510">
<caption>Changes since version 1.13.4_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations, such as <code>refresh</code> or <code>update</code>, to fail when the unused cluster DNS must be scaled down.</td>
</tr>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the CoreDNS configuration to support <a href="https://coredns.io/2017/07/23/corefile-explained/">multiple Corefiles</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> after updating the cluster Kubernetes version from 1.12.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.4</td>
<td>1.2.5</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.5">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update includes improved fix for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736">CVE-2019-5736</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/871600">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to <a href="https://www.nvidia.com/object/unix.html">418.43</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update includes fix for <a href="https://ubuntu.com/security/CVE-2019-9741.html">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for <a href="/docs/containers?topic=containers-cs_network_cluster#set-up-private-se">private cloud service endpoints</a>.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-6133.html">CVE-2019-6133</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890">CVE-2018-16890</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822">CVE-2019-3822</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823">CVE-2019-3823</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779">CVE-2018-10779</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900">CVE-2018-12900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000">CVE-2018-17000</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210">CVE-2018-19210</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128">CVE-2019-6128</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663">CVE-2019-7663</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.4_1510, released 4 March 2019
{: #1134_1510}

The following table shows the changes that are in the patch 1.13.4_1510.
{: shortdesc}

<table summary="Changes that were made since version 1.13.2_1509">
<caption>Changes since version 1.13.2_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS and CoreDNS pod memory limit from <code>170Mi</code> to <code>400Mi</code> in order to handle more cluster services.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.13.2-62</td>
<td>v1.13.4-86</td>
<td>Updated to support the Kubernetes 1.13.4 release. Fixed periodic connectivity problems for version 1.0 load balancers that set <code>externalTrafficPolicy</code> to <code>local</code>. Updated load balancer version 1.0 and 2.0 events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.13.2</td>
<td>v1.13.4</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.4">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100">CVE-2019-1002100</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/873324">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>ExperimentalCriticalPodAnnotation=true</code> to the <code>--feature-gates</code> option. This setting helps migrate pods from the deprecated <code>scheduler.alpha.kubernetes.io/critical-pod</code> annotation to <a href="/docs/containers?topic=containers-pod_priority#pod_priority">Kubernetes pod priority support</a>.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.2_1509, released 27 February 2019
{: #1132_1509}

The following table shows the changes that are in the worker node fix pack 1.13.2_1509.
{: shortdesc}

<table summary="Changes that were made since version 1.13.2_1508">
<caption>Changes since version 1.13.2_1508</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog">CVE-2018-19407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.13.2_1508, released 15 February 2019
{: #1132_1508}

The following table shows the changes that are in the worker node fix pack 1.13.2_1508.
{: shortdesc}

<table summary="Changes that were made since version 1.13.2_1507">
<caption>Changes since version 1.13.2_1507</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the pod configuration <code>spec.priorityClassName</code> value to <code>system-node-critical</code> and set the <code>spec.priority</code> value to <code>2000001000</code>.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.2</td>
<td>1.2.4</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.4">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736">CVE-2019-5736</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/871600">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes <code>kubelet</code> configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the <code>ExperimentalCriticalPodAnnotation</code> feature gate to prevent critical static pod eviction. Set the <code>event-qps</code> option to <code>0</code> to prevent rate limiting event creation.</td>
</tr>
</tbody>
</table>

### Changelog for 1.13.2_1507, released 5 February 2019
{: #1132_1507}

The following table shows the changes that are in the patch 1.13.2_1507.
{: shortdesc}

<table summary="Changes that were made since version 1.12.4_1535">
<caption>Changes since version 1.12.4_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.1</td>
<td>v3.4.0</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>CoreDNS is now the default cluster DNS provider for new clusters. If you update an existing cluster to 1.13 that uses KubeDNS as the cluster DNS provider, KubeDNS continues to be the cluster DNS provider.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.5</td>
<td>1.2.2</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.2">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>1.2.2</td>
<td>1.2.6</td>
<td>See the <a href="https://github.com/coredns/coredns/releases/tag/v1.2.6">CoreDNS release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the CoreDNS configuration is updated to <a href="https://coredns.io/2017/07/23/corefile-explained/">support multiple Corefiles</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.11">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462">CVE-2019-3462</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.4-118</td>
<td>v1.13.2-62</td>
<td>Updated to support the Kubernetes 1.13.2 release. Additionally, <code>calicoctl</code> version is updated to 3.4.0. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with <a href="/docs/containers?topic=containers-file_storage#file-topology">volume topology-aware scheduling</a>.</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li>
<li>Adds a <code>CriticalAddonsOnly</code> toleration to the <code>ibm-file-plugin</code> and <code>ibm-storage-watcher</code> deployments in the <code>kube-system</code> namespace.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.4</td>
<td>v1.13.2</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.2">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for <code>cluster-admin</code> requests and logging the request body of workload <code>create</code>, <code>update</code>, and <code>patch</code> requests.</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.2.0</td>
<td>1.3.0</td>
<td>See the <a href="https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.3.0">Kubernetes DNS autoscaler release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Added <code>CriticalAddonsOnly</code> toleration to the <code>vpn</code> deployment in the <code>kube-system</code> namespace. Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864">CVE-2018-16864</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>



## Version 1.12 changelog (unsupported 3 November 2019)
{: #112_changelog}

Version 1.12 is unsupported. You can review the following archive of 1.12 changelogs.
{: shortdesc}

* [Changelog for worker node fix pack 1.12.10_1570, released 28 October 2019](#11210_1570)
* [Changelog for worker node fix pack 1.12.10_1569, released 14 October 2019](#11210_1569_worker)
* [Changelog for worker node fix pack 1.12.10_1568, released 1 October 2019](#11210_1568_worker)
* [Changelog for worker node fix pack 1.12.10_1567, released 16 September 2019](#11210_1567_worker)
* [Changelog for worker node fix pack 1.12.10_1566, released 3 September 2019](#11210_1566_worker)
* [Changelog for master fix pack 1.12.10_1565, released 28 August 2019](#11210_1565)
* [Changelog for worker node fix pack 1.12.10_1564, released 19 August 2019](#11210_1564_worker)
* [Changelog for master fix pack 1.12.10_1564, released 17 August 2019](#11210_1564)
* [Changelog for master fix pack 1.12.10_1563, released 15 August 2019](#11210_1563)
* [Changelog for worker node fix pack 1.12.10_1561, released 5 August 2019](#11210_1561_worker)
* [Changelog for worker node fix pack 1.12.10_1560, released 22 July 2019](#11210_1560_worker)
* [Changelog for master fix pack 1.12.10_1560, released 15 July 2019](#11210_1560)
* [Changelog for worker node fix pack 1.12.9_1559, released 8 July 2019](#1129_1559)
* [Changelog for worker node fix pack 1.12.9_1558, released 24 June 2019](#1129_1558)
* [Changelog for 1.12.9_1557, released 17 June 2019](#1129_1557)
* [Changelog for 1.12.9_1555, released 4 June 2019](#1129_1555)
* [Changelog for worker node fix pack 1.12.8_1553, released 20 May 2019](#1128_1533)
* [Changelog for 1.12.8_1552, released 13 May 2019](#1128_1552)
* [Changelog for worker node fix pack 1.12.7_1550, released 29 April 2019](#1127_1550)
* [Changelog for worker node fix pack 1.12.7_1549, released 15 April 2019](#1127_1549)
* [Changelog for 1.12.7_1548, released 8 April 2019](#1127_1548)
* [Changelog for worker node fix pack 1.12.6_1547, released 1 April 2019](#1126_1547)
* [Changelog for master fix pack 1.12.6_1546, released 26 March 2019](#1126_1546)
* [Changelog for 1.12.6_1544, released 20 March 2019](#1126_1544)
* [Changelog for 1.12.6_1541, released 4 March 2019](#1126_1541)
* [Changelog for worker node fix pack 1.12.5_1540, released 27 February 2019](#1125_1540)
* [Changelog for worker node fix pack 1.12.5_1538, released 15 February 2019](#1125_1538)
* [Changelog for 1.12.5_1537, released 5 February 2019](#1125_1537)
* [Changelog for worker node fix pack 1.12.4_1535, released 28 January 2019](#1124_1535)
* [Changelog for 1.12.4_1534, released 21 January 2019](#1124_1534)
* [Changelog for worker node fix pack 1.12.3_1533, released 7 January 2019](#1123_1533)
* [Changelog for worker node fix pack 1.12.3_1532, released 17 December 2018](#1123_1532)
* [Changelog for 1.12.3_1531, released 5 December 2018](#1123_1531)
* [Changelog for worker node fix pack 1.12.2_1530, released 4 December 2018](#1122_1530)
* [Changelog for 1.12.2_1529, released 27 November 2018](#1122_1529)
* [Changelog for worker node fix pack 1.12.2_1528, released 19 November 2018](#1122_1528)
* [Changelog for 1.12.2_1527, released 7 November 2018](#1122_1527)

### Changelog for worker node fix pack 1.12.10_1570, released 28 October 2019
{: #11210_1570}

The following table shows the changes that are in the worker node fix pack `1.12.10_1570`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.12.10_1569" caption-side="top"}

### Changelog for worker node fix pack 1.12.10_1569, released 14 October 2019
{: #11210_1569_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1569.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1568">
<caption>Changes since version 1.12.10_1568</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-164-generic</td>
<td>4.4.0-165-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-0136">CVE-2019-0136</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20961">CVE-2018-20961</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11487">CVE-2019-11487</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2016-10905">CVE-2016-10905</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-64-generic</td>
<td>4.15.0-65-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5094">CVE-2019-5094</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20976">CVE-2018-20976</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16056">CVE-2019-16056</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-16935">CVE-2019-16935</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.10_1568, released 1 October 2019
{: #11210_1568_worker}

The following table shows the changes that are in the patch 1.12.10_1568.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1567">
<caption>Changes since version 1.12.10_1567</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-62-generic</td>
<td>4.15.0-64-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15031">CVE-2019-15031</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15030">CVE-2019-15030</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-161-generic</td>
<td>4.4.0-164-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14835">CVE-2019-14835</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.10_1567, released 16 September 2019
{: #11210_1567_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1567.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1566">
<caption>Changes since version 1.12.10_1566</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages and kernel</td>
<td>4.4.0-159-generic</td>
<td>4.4.0-161-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2015-9383">CVE-2015-9383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10638">CVE-2019-10638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3900">CVE-2019-3900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20856">CVE-2018-20856</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">,<a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20406">CVE-2018-20406</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages and kernel</td>
<td>4.15.0-58-generic</td>
<td>4.15.0-62-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5481">CVE-2019-5481</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5482">CVE-2019-5482</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15903">CVE-2019-15903</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14283">CVE-2019-14283</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-14284">CVE-2019-14284</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20852">CVE-2018-20852</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-5010">CVE-2019-5010</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9740">CVE-2019-9740</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9947">CVE-2019-9947</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9948">CVE-2019-9948</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-9636">CVE-2019-9636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10160">CVE-2019-10160</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-15718">CVE-2019-15718</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.10_1566, released 3 September 2019
{: #11210_1566_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1566.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1564">
<caption>Changes since version 1.12.10_1564</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates.</td>
</tr>
<tr>
<td>Ubuntu 18.04 packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10222">CVE-2019-10222</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11922">CVE-2019-11922</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.12.10_1565, released 28 August 2019
{: #11210_1565}

The following table shows the changes that are in the master fix pack 1.12.10_1565.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1564">
<caption>Changes since version 1.12.10_1564</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>etcd</code></td>
<td>v3.3.13</td>
<td>v3.3.15</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.15"><code>etcd</code> release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>07c9b67</td>
<td>de13f2a</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated the GPU drivers to <a href="https://www.nvidia.com/Download/driverResults.aspx/149138/">430.40</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>348</td>
<td>349</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>207</td>
<td>212</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>147</td>
<td>148</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512">CVE-2019-9512</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514">CVE-2019-9514</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809">CVE-2019-14809</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.10_1564, released 19 August 2019
{: #11210_1564_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1564.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1561">
<caption>Changes since version 1.12.10_1561</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>2.0.1-alpine</td>
<td>1.8.21-alpine</td>
<td>Moved to HA proxy 1.8 to fix <a href="https://github.com/haproxy/haproxy/issues/136">socket leak in HA proxy</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Also added a liveliness check to monitor the health of HA proxy. For more information, see <a href="https://www.haproxy.org/download/1.8/src/CHANGELOG">HA proxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-157-generic</td>
<td>4.4.0-159-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13012">CVE-2019-13012</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-55-generic</td>
<td>4.15.0-58-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-1125">CVE-2019-1125</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2101">CVE-2019-2101</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2018-5383">CVE-2018-5383</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13233">CVE-2019-13233</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13272">CVE-2019-13272</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-10126">CVE-2019-10126</a>, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-3846">CVE-2019-3846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12818">CVE-2019-12818</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12984">CVE-2019-12984</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-12819">CVE-2019-12819</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.12.10_1564, released 17 August 2019
{: #11210_1564}

The following table shows the changes that are in the master fix pack 1.12.10_1564.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1563">
<caption>Changes since version 1.12.10_1563</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service provider</td>
<td>167</td>
<td>207</td>
<td>Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.12.10_1563, released 15 August 2019
{: #11210_1563}

The following table shows the changes that are in the master fix pack 1.12.10_1563.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1561">
<caption>Changes since version 1.12.10_1561</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico <code>calico-kube-controllers</code> deployment in the <code>kube-system</code> namespace sets a memory limit on the <code>calico-kube-controllers</code> container.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>a7e8ece</td>
<td>07c9b67</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924">CVE-2019-9924</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>347</td>
<td>348</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.13</td>
<td>1.15.4</td>
<td>See the <a href="https://github.com/kubernetes/dns/releases/tag/1.15.4">Kubernetes DNS release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Image update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.2.0</td>
<td>1.3.0</td>
<td>See the <a href="https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.3.0">Kubernetes DNS autoscaler release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Image update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>146</td>
<td>147</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-116</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-25</td>
<td>2.4.6-r3-IKS-115</td>
<td>Image updated for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697">CVE-2019-14697</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.10_1561, released 5 August 2019
{: #11210_1561_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1561.
{: shortdesc}

<table summary="Changes that were made since version 1.12.10_1560">
<caption>Changes since version 1.12.10_1560</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 18.04 kernel and packages</td>
<td>4.15.0-54-generic</td>
<td>4.15.0-55-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11085">CVE-2019-11085</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11815">CVE-2019-11815</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11884">CVE-2019-11884</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2054">CVE-2019-2054</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel and packages</td>
<td>4.4.0-154-generic</td>
<td>4.4.0-157-generic</td>
<td>Updated worker node images with package updates for <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-2054">CVE-2019-2054</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-11833">CVE-2019-11833</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13057">CVE-2019-13057</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13565">CVE-2019-13565</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13636">CVE-2019-13636</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://nvd.nist.gov/vuln/detail/CVE-2019-13638">CVE-2019-13638</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.10_1560, released 22 July 2019
{: #11210_1560_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1560.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1559">
<caption>Changes since version 1.12.9_1559</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.12.9</td>
<td>v1.12.10</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.10">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248">CVE-2019-11248</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see <a href="https://www.ibm.com/support/pages/node/967113">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">).</td>
</tr>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated worker node images with package updates for <a href="https://ubuntu.com/security/CVE-2019-13012">CVE-2019-13012</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-7307.html">CVE-2019-7307</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
    </tbody>
</table>


### Changelog for master fix pack 1.12.10_1560, released 15 July 2019
{: #11210_1560}

The following table shows the changes that are in the master fix pack 1.12.10_1560.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1559">
<caption>Changes since version 1.12.9_1559</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.6</td>
<td>v3.6.4</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://www.tigera.io/security-bulletins/#TTA-2019-001">TTA-2019-001</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/959551">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the <code>kubernetes</code> zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see <a href="/docs/containers?topic=containers-cluster_dns#dns_customize">Customizing the cluster DNS provider</a>.
</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>5d34347</td>
<td>a7e8ece</td>
<td>Updated base image packages.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.9</td>
<td>v1.12.10</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.10">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.9-227</td>
<td>v1.12.10-259</td>
<td>Updated to support the Kubernetes 1.12.10 release. Additionally, <code>calicoctl</code> version is updated to 3.6.4.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.9_1559, released 8 July 2019
{: #1129_1559}

The following table shows the changes that are in the worker node patch 1.12.9_1559.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1558">
<caption>Changes since version 1.12.9_1558</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.9_1558, released 24 June 2019
{: #1129_1558}

The following table shows the changes that are in the worker node patch 1.12.9_1558.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1557">
<caption>Changes since version 1.12.9_1557</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/958863">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.2.6</td>
<td>1.2.7</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.7">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.12.9_1557, released 17 June 2019
{: #1129_1557}

The following table shows the changes that are in the patch 1.12.9_1557.
{: shortdesc}

<table summary="Changes that were made since version 1.12.9_1555">
<caption>Changes since version 1.12.9_1555</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>32257d3</td>
<td>5d34347</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457">CVE-2019-8457</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated the GPU drivers to <a href="https://www.nvidia.com/Download/driverResults.aspx/147582/">430.14</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>346</td>
<td>347</td>
<td>Updated so that the IAM API key can be either encrypted or unencrypted.</td>
</tr>
<td>Public service endpoint for Kubernetes master</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed an issue to <a href="/docs/containers?topic=containers-cs_network_cluster#set-up-public-se">enable the public cloud service endpoint</a>.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.12.9_1555, released 4 June 2019
{: #1129_1555}

The following table shows the changes that are in the patch 1.12.9_1555.
{: shortdesc}

<table summary="Changes that were made since version 1.12.8_1553">
<caption>Changes since version 1.12.8_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster <code>create</code> or <code>update</code> operations.</td>
</tr>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.13">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.8-210</td>
<td>v1.12.9-227</td>
<td>Updated to support the Kubernetes 1.12.9 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.8</td>
<td>v1.12.9</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.9">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>v0.3.1</td>
<td>v0.3.3</td>
<td>See the <a href="https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3">Kubernetes Metrics Server release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.8_1553, released 20 May 2019
{: #1128_1533}

The following table shows the changes that are in the patch 1.12.8_1553.
{: shortdesc}

<table summary="Changes that were made since version 1.12.8_1553">
<caption>Changes since version 1.12.8_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.12.8_1552, released 13 May 2019
{: #1128_1552}

The following table shows the changes that are in the patch 1.12.8_1552.
{: shortdesc}

<table summary="Changes that were made since version 1.12.7_1550">
<caption>Changes since version 1.12.7_1550</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706">CVE-2019-6706</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>55c1f66</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.7-180</td>
<td>v1.12.8-210</td>
<td>Updated to support the Kubernetes 1.12.8 release. Also, fixed the update process for version 2.0 network load balancer that have only one available worker node for the load balancer pods.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.7</td>
<td>v1.12.8</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.8">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the <code>/openapi/v2*</code> read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed <code>kubelet</code> certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client <code>vpn-*</code> pod in the <code>kube-system</code> namespace now sets <code>dnsPolicy</code> to <code>Default</code> to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>13c7ef0</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076">CVE-2016-7076</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368">CVE-2017-1000368</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068">CVE-2019-11068</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.7_1550, released 29 April 2019
{: #1127_1550}

The following table shows the changes that are in the worker node fix pack 1.12.7_1550.
{: shortdesc}

<table summary="Changes that were made since version 1.12.7_1549">
<caption>Changes since version 1.12.7_1549</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.6</td>
<td>1.1.7</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.7">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.12.7_1549, released 15 April 2019
{: #1127_1549}

The following table shows the changes that are in the worker node fix pack 1.12.7_1549.
{: shortdesc}

<table summary="Changes that were made since version 1.12.7_1548">
<caption>Changes since version 1.12.7_1548</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including <code>systemd</code> for <a href="https://ubuntu.com/security/CVE-2019-3842.html">CVE-2019-3842</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.12.7_1548, released 8 April 2019
{: #1127_1548}

The following table shows the changes that are in the patch 1.12.7_1548.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1547">
<caption>Changes since version 1.12.6_1547</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.1</td>
<td>v3.3.6</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946">CVE-2019-9946</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/879585">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.6-157</td>
<td>v1.12.7-180</td>
<td>Updated to support the Kubernetes 1.12.7 and Calico 3.3.6 releases.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.6</td>
<td>v1.12.7</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.7">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447">CVE-2017-12447</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.6_1547, released 1 April 2019
{: #1126_1547}

The following table shows the changes that are in the worker node fix pack 1.12.6_1547.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1546">
<caption>Changes since version 1.12.6_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>


### Changelog for master fix pack 1.12.6_1546, released 26 March 2019
{: #1126_1546}

The following table shows the changes that are in the master fix pack 1.12.6_1546.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1544">
<caption>Changes since version 1.12.6_1544</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent <code>context deadline exceeded</code> and <code>timeout</code> errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.12.6_1544, released 20 March 2019
{: #1126_1544}

The following table shows the changes that are in the patch 1.12.6_1544.
{: shortdesc}

<table summary="Changes that were made since version 1.12.6_1541">
<caption>Changes since version 1.12.6_1541</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that might cause cluster master operations, such as <code>refresh</code> or <code>update</code>, to fail when the unused cluster DNS must be scaled down.</td>
</tr>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>CoreDNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the CoreDNS configuration to support <a href="https://coredns.io/2017/07/23/corefile-explained/">multiple Corefiles</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to <a href="https://www.nvidia.com/object/unix.html">418.43</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update includes fix for <a href="https://ubuntu.com/security/CVE-2019-9741.html">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for <a href="/docs/containers?topic=containers-cs_network_cluster#set-up-private-se">private cloud service endpoints</a>.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-6133.html">CVE-2019-6133</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890">CVE-2018-16890</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822">CVE-2019-3822</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823">CVE-2019-3823</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779">CVE-2018-10779</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900">CVE-2018-12900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000">CVE-2018-17000</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210">CVE-2018-19210</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128">CVE-2019-6128</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663">CVE-2019-7663</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.12.6_1541, released 4 March 2019
{: #1126_1541}

The following table shows the changes that are in the patch 1.12.6_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.12.5_1540">
<caption>Changes since version 1.12.5_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS and CoreDNS pod memory limit from <code>170Mi</code> to <code>400Mi</code> in order to handle more cluster services.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.5-137</td>
<td>v1.12.6-157</td>
<td>Updated to support the Kubernetes 1.12.6 release. Fixed periodic connectivity problems for version 1.0 load balancers that set <code>externalTrafficPolicy</code> to <code>local</code>. Updated load balancer version 1.0 and 2.0 events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.5</td>
<td>v1.12.6</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.6">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100">CVE-2019-1002100</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/873324">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>ExperimentalCriticalPodAnnotation=true</code> to the <code>--feature-gates</code> option. This setting helps migrate pods from the deprecated <code>scheduler.alpha.kubernetes.io/critical-pod</code> annotation to <a href="/docs/containers?topic=containers-pod_priority#pod_priority">Kubernetes pod priority support</a>.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.5_1540, released 27 February 2019
{: #1125_1540}

The following table shows the changes that are in the worker node fix pack 1.12.5_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.12.5_1538">
<caption>Changes since version 1.12.5_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog">CVE-2018-19407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.5_1538, released 15 February 2019
{: #1125_1538}

The following table shows the changes that are in the worker node fix pack 1.12.5_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.12.5_1537">
<caption>Changes since version 1.12.5_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the pod configuration <code>spec.priorityClassName</code> value to <code>system-node-critical</code> and set the <code>spec.priority</code> value to <code>2000001000</code>.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.5</td>
<td>1.1.6</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.6">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736">CVE-2019-5736</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/871600">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes <code>kubelet</code> configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the <code>ExperimentalCriticalPodAnnotation</code> feature gate to prevent critical static pod eviction.</td>
</tr>
</tbody>
</table>

### Changelog for 1.12.5_1537, released 5 February 2019
{: #1125_1537}

The following table shows the changes that are in the patch 1.12.5_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.12.4_1535">
<caption>Changes since version 1.12.4_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.11">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462">CVE-2019-3462</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.4-118</td>
<td>v1.12.5-137</td>
<td>Updated to support the Kubernetes 1.12.5 release. Additionally, <code>calicoctl</code> version is updated to 3.3.1. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with <a href="/docs/containers?topic=containers-file_storage#file-topology">volume topology-aware scheduling</a>.</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.4</td>
<td>v1.12.5</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.5">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for <code>cluster-admin</code> requests and logging the request body of workload <code>create</code>, <code>update</code>, and <code>patch</code> requests.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864">CVE-2018-16864</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.4_1535, released 28 January 2019
{: #1124_1535}

The following table shows the changes that are in the worker node fix pack 1.12.4_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.12.4_1534">
<caption>Changes since version 1.12.4_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including <code>apt</code> for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462">CVE-2019-3462</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/notices/USN-3863-1">USN-3863-1</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for 1.12.4_1534, released 21 January 2019
{: #1124_1534}

The following table shows the changes that are in the patch 1.12.3_1534.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1533">
<caption>Changes since version 1.12.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.3-91</td>
<td>v1.12.4-118</td>
<td>Updated to support the Kubernetes 1.12.4 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.3</td>
<td>v1.12.4</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.4">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the <a href="https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4">Kubernetes add-on resizer release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the <a href="https://github.com/kubernetes/dashboard/releases/tag/v1.10.1">Kubernetes dashboard release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264">CVE-2018-18264</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.3_1533, released 7 January 2019
{: #1123_1533}

The following table shows the changes that are in the worker node fix pack 1.12.3_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1532">
<caption>Changes since version 1.12.3_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog">CVE-2017-5753, CVE-2018-18690</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.3_1532, released 17 December 2018
{: #1123_1532}

The following table shows the changes that are in the worker node fix pack 1.12.2_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.12.3_1531">
<caption>Changes since version 1.12.3_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


### Changelog for 1.12.3_1531, released 5 December 2018
{: #1123_1531}

The following table shows the changes that are in the patch 1.12.3_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1530">
<caption>Changes since version 1.12.2_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.12.2-68</td>
<td>v1.12.3-91</td>
<td>Updated to support the Kubernetes 1.12.3 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.12.2</td>
<td>v1.12.3</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.3">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://github.com/kubernetes/kubernetes/issues/71411">CVE-2018-1002105</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/743917">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.2_1530, released 4 December 2018
{: #1122_1530}

The following table shows the changes that are in the worker node fix pack 1.12.2_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1529">
<caption>Changes since version 1.12.2_1529</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>



### Changelog for 1.12.2_1529, released 27 November 2018
{: #1122_1529}

The following table shows the changes that are in patch 1.12.2_1529.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1528">
<caption>Changes since version 1.12.2_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://www.tigera.io/security-bulletins/">Tigera Technical Advisory TTA-2018-001</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. For more information, see the <a href="https://www.ibm.com/support/pages/node/740799">IBM security bulletin</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster DNS configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed a bug that could result in both Kubernetes DNS and CoreDNS pods to run after cluster creation or update operations.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.2.0</td>
<td>v1.1.5</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.5">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated containerd to fix a deadlock that can <a href="https://github.com/containerd/containerd/issues/2744">stop pods from terminating</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.12.2_1528, released 19 November 2018
{: #1122_1528}

The following table shows the changes that are in the worker node fix pack 1.12.2_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.12.2_1527">
<caption>Changes since version 1.12.2_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog">CVE-2018-7755</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for 1.12.2_1527, released 7 November 2018
{: #1122_1527}

The following table shows the changes that are in patch 1.12.2_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1533">
<caption>Changes since version 1.11.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Calico <code>calico-*</code> pods in the <code>kube-system</code> namespace now set CPU and memory resource requests for all containers.</td>
</tr>
<tr>
<td>Cluster DNS provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Kubernetes DNS (KubeDNS) remains the default cluster DNS provider..</td>
</tr>
<tr>
<td>Cluster metrics provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Kubernetes Metrics Server replaces Kubernetes Heapster (deprecated since Kubernetes version 1.8) as the cluster metrics provider.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.4</td>
<td>1.2.0</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.2.0">containerd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.2.0</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>CoreDNS</td>
<td>N/A</td>
<td>1.2.2</td>
<td>See the <a href="https://github.com/coredns/coredns/releases/tag/v1.2.2">CoreDNS release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/coredns/coredns/releases/tag/v1.2.2</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.12.2</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.12.2">Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.2</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added three new IBM pod security policies and their associated cluster roles. For more information, see <a href="/docs/containers?topic=containers-psp#ibm_psp">Understanding default resources for IBM cluster management</a>.</td>
</tr>
<tr>
<td>Kubernetes Dashboard</td>
<td>v1.8.3</td>
<td>v1.10.0</td>
<td>See the <a href="https://github.com/kubernetes/dashboard/releases/tag/v1.10.0">Kubernetes Dashboard release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dashboard/releases/tag/v1.10.0</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.<br><br>
If you access the dashboard via <code>kubectl proxy</code>, the <strong>SKIP</strong> button on the login page is removed. Instead, <a href="/docs/containers?topic=containers-deploy_app#cli_dashboard">use a <strong>Token</strong> to log in</a>. Additionally, you can now scale up the number of Kubernetes Dashboard pods by running <code>kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3</code>.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.10</td>
<td>1.14.13</td>
<td>See the <a href="https://github.com/kubernetes/dns/releases/tag/1.14.13">Kubernetes DNS release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/dns/releases/tag/1.14.13</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Metrics Server</td>
<td>N/A</td>
<td>v0.3.1</td>
<td>See the <a href="https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.1">Kubernetes Metrics Server release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.1</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-118</td>
<td>v1.12.2-68</td>
<td>Updated to support the Kubernetes 1.12 release. Additional changes include the following:
<ul><li>Load balancer pods (<code>ibm-cloud-provider-ip-*</code> in <code>ibm-system</code> namespace) now set CPU and memory resource requests.</li>
<li>The <code>service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan</code> annotation is added to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run <code>ibmcloud ks vlan ls --zone &lt;zone&gt;</code>.</li>
<li>A new <a href="/docs/containers?topic=containers-loadbalancer-about#planning_ipvs">load balancer 2.0</a> is available as a beta.</li></ul></td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>OpenVPN client <code>vpn-* pod</code> in the <code>kube-system</code> namespace now sets CPU and memory resource requests.</td>
</tr>
</tbody>
</table>



## Version 1.11 changelog (unsupported as of 20 July 2019)
{: #111_changelog}

Review the version 1.11 changelog.
{: shortdesc}

* [Changelog for worker node fix pack 1.11.10_1564, released 8 July 2019](#11110_1564)
* [Changelog for worker node fix pack 1.11.10_1563, released 24 June 2019](#11110_1563)
* [Changelog for worker node fix pack 1.11.10_1562, released 17 June 2019](#11110_1562)
* [Changelog for 1.11.10_1561, released 4 June 2019](#11110_1561)
* [Changelog for worker node fix pack 1.11.10_1559, released 20 May 2019](#11110_1559)
* [Changelog for 1.11.10_1558, released 13 May 2019](#11110_1558)
* [Changelog for worker node fix pack 1.11.9_1556, released 29 April 2019](#1119_1556)
* [Changelog for worker node fix pack 1.11.9_1555, released 15 April 2019](#1119_1555)
* [Changelog for 1.11.9_1554, released 8 April 2019](#1119_1554)
* [Changelog for worker node fix pack 1.11.8_1553, released 1 April 2019](#1118_1553)
* [Changelog for master fix pack 1.11.8_1552, released 26 March 2019](#1118_1552)
* [Changelog for 1.11.8_1550, released 20 March 2019](#1118_1550)
* [Changelog for 1.11.8_1547, released 4 March 2019](#1118_1547)
* [Changelog for worker node fix pack 1.11.7_1546, released 27 February 2019](#1117_1546)
* [Changelog for worker node fix pack 1.11.7_1544, released 15 February 2019](#1117_1544)
* [Changelog for 1.11.7_1543, released 5 February 2019](#1117_1543)
* [Changelog for worker node fix pack 1.11.6_1541, released 28 January 2019](#1116_1541)
* [Changelog for 1.11.6_1540, released 21 January 2019](#1116_1540)
* [Changelog for worker node fix pack 1.11.5_1539, released 7 January 2019](#1115_1539)
* [Changelog for worker node fix pack 1.11.5_1538, released 17 December 2018](#1115_1538)
* [Changelog for 1.11.5_1537, released 5 December 2018](#1115_1537)
* [Changelog for worker node fix pack 1.11.4_1536, released 4 December 2018](#1114_1536)
* [Changelog for 1.11.4_1535, released 27 November 2018](#1114_1535)
* [Changelog for worker node fix pack 1.11.3_1534, released 19 November 2018](#1113_1534)
* [Changelog for 1.11.3_1533, released 7 November 2018](#1113_1533)
* [Changelog for master fix pack 1.11.3_1531, released 1 November 2018](#1113_1531_ha-master)
* [Changelog for worker node fix pack 1.11.3_1531, released 26 October 2018](#1113_1531)
* [Changelog for master fix pack 1.11.3_1527, released 15 October 2018](#1113_1527)
* [Changelog for worker node fix pack 1.11.3_1525, released 10 October 2018](#1113_1525)
* [Changelog for 1.11.3_1524, released 2 October 2018](#1113_1524)
* [Changelog for 1.11.3_1521, released 20 September 2018](#1113_1521)
* [Changelog for 1.11.2_1516, released 4 September 2018](#1112_1516)
* [Changelog for worker node fix pack 1.11.2_1514, released 23 August 2018](#1112_1514)
* [Changelog for 1.11.2_1513, released 14 August 2018](#1112_1513)

### Changelog for worker node fix pack 1.11.10_1564, released 8 July 2019
{: #11110_1564}

The following table shows the changes that are in the worker node patch 1.11.10_1564.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1563">
<caption>Changes since version 1.11.10_1563</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-151-generic</td>
<td>4.4.0-154-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-52-generic</td>
<td>4.15.0-54-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11479.html">CVE-2019-11479</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.10_1563, released 24 June 2019
{: #11110_1563}

The following table shows the changes that are in the worker node patch 1.11.10_1563.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1562">
<caption>Changes since version 1.11.10_1562</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-150-generic</td>
<td>4.4.0-151-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-51-generic</td>
<td>4.15.0-52-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-11477.html">CVE-2019-11477</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/CVE-2019-11478.html">CVE-2019-11478</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.10_1562, released 17 June 2019
{: #11110_1562}

The following table shows the changes that are in the worker node patch 1.11.10_1562.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1561">
<caption>Changes since version 1.11.10_1561</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-148-generic</td>
<td>4.4.0-150-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-50-generic</td>
<td>4.15.0-51-generic</td>
<td>Updated worker node images with kernel and package updates for <a href="https://ubuntu.com/security/CVE-2019-10906">CVE-2019-10906</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.10_1561, released 4 June 2019
{: #11110_1561}

The following table shows the changes that are in the patch 1.11.10_1561.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1559">
<caption>Changes since version 1.11.10_1559</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to minimize intermittent master network connectivity failures during a master update.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.3.11</td>
<td>v3.3.13</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.13">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>55c1f66</td>
<td>32257d3</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>13c7ef0</td>
<td>e8c6d72</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844">CVE-2018-10844</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845">CVE-2018-10845</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846">CVE-2018-10846</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829">CVE-2019-3829</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836">CVE-2019-3836</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893">CVE-2019-9893</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435">CVE-2019-5435</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436">CVE-2019-5436</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.10_1559, released 20 May 2019
{: #11110_1559}

The following table shows the changes that are in the patch pack 1.11.10_1559.
{: shortdesc}

<table summary="Changes that were made since version 1.11.10_1558">
<caption>Changes since version 1.11.10_1558</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-145-generic</td>
<td>4.4.0-148-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-47-generic</td>
<td>4.15.0-50-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2018-12126.html">CVE-2018-12126</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://ubuntu.com/security/CVE-2018-12127.html">CVE-2018-12127</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://ubuntu.com/security/CVE-2018-12130.html">CVE-2018-12130</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.10_1558, released 13 May 2019
{: #11110_1558}

The following table shows the changes that are in the patch 1.11.10_1558.
{: shortdesc}

<table summary="Changes that were made since version 1.11.9_1556">
<caption>Changes since version 1.11.9_1556</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706">CVE-2019-6706</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>9ff3fda</td>
<td>55c1f66</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.9-241</td>
<td>v1.11.10-270</td>
<td>Updated to support the Kubernetes 1.11.10 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.9</td>
<td>v1.11.10</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.10">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to not log the <code>/openapi/v2*</code> read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed <code>kubelet</code> certificates from 1 to 3 years.</td>
</tr>
<tr>
<td>OpenVPN client configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client <code>vpn-*</code> pod in the <code>kube-system</code> namespace now sets <code>dnsPolicy</code> to <code>Default</code> to prevent the pod from failing when cluster DNS is down.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>e132aa4</td>
<td>13c7ef0</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076">CVE-2016-7076</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368">CVE-2017-1000368</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068">CVE-2019-11068</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.9_1556, released 29 April 2019
{: #1119_1556}

The following table shows the changes that are in the worker node fix pack 1.11.9_1556.
{: shortdesc}

<table summary="Changes that were made since version 1.11.9_1555">
<caption>Changes since version 1.11.9_1555</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.6</td>
<td>1.1.7</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.7">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.11.9_1555, released 15 April 2019
{: #1119_1555}

The following table shows the changes that are in the worker node fix pack 1.11.9_1555.
{: shortdesc}

<table summary="Changes that were made since version 1.11.9_1554">
<caption>Changes since 1.11.9_1554</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including <code>systemd</code> for <a href="https://ubuntu.com/security/CVE-2019-3842.html">CVE-2019-3842</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.9_1554, released 8 April 2019
{: #1119_1554}

The following table shows the changes that are in the patch 1.11.9_1554.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1553">
<caption>Changes since version 1.11.8_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.3.1</td>
<td>v3.3.6</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946">CVE-2019-9946</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.8-219</td>
<td>v1.11.9-241</td>
<td>Updated to support the Kubernetes 1.11.9 and Calico 3.3.6 releases.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.8</td>
<td>v1.11.9</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.9">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.10</td>
<td>1.14.13</td>
<td>See the <a href="https://github.com/kubernetes/dns/releases/tag/1.14.13">Kubernetes DNS release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447">CVE-2017-12447</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.8_1553, released 1 April 2019
{: #1118_1553}

The following table shows the changes that are in the worker node fix 1.11.8_1553.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1552">
<caption>Changes since version 1.11.8_1552</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.11.8_1552, released 26 March 2019
{: #1118_1552}

The following table shows the changes that are in the master fix pack 1.11.8_1552.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1550">
<caption>Changes since version 1.11.8_1550</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent <code>context deadline exceeded</code> and <code>timeout</code> errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.8_1550, released 20 March 2019
{: #1118_1550}

The following table shows the changes that are in the patch 1.11.8_1550.
{: shortdesc}

<table summary="Changes that were made since version 1.11.8_1547">
<caption>Changes since version 1.11.8_1547</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to <a href="https://www.nvidia.com/object/unix.html">418.43</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update includes fix for <a href="https://ubuntu.com/security/CVE-2019-9741.html">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for <a href="/docs/containers?topic=containers-cs_network_cluster#set-up-private-se">private cloud service endpoints</a>.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-6133.html">CVE-2019-6133</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890">CVE-2018-16890</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822">CVE-2019-3822</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823">CVE-2019-3823</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779">CVE-2018-10779</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900">CVE-2018-12900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000">CVE-2018-17000</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210">CVE-2018-19210</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128">CVE-2019-6128</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663">CVE-2019-7663</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.8_1547, released 4 March 2019
{: #1118_1547}

The following table shows the changes that are in the patch 1.11.8_1547.
{: shortdesc}

<table summary="Changes that were made since version 1.11.7_1546">
<caption>Changes since version 1.11.7_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.7-198</td>
<td>v1.11.8-219</td>
<td>Updated to support the Kubernetes 1.11.8 release. Fixed periodic connectivity problems for load balancers that set <code>externalTrafficPolicy</code> to <code>local</code>. Updated load balancer events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.7</td>
<td>v1.11.8</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.8">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100">CVE-2019-1002100</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>ExperimentalCriticalPodAnnotation=true</code> to the <code>--feature-gates</code> option. This setting helps migrate pods from the deprecated <code>scheduler.alpha.kubernetes.io/critical-pod</code> annotation to <a href="/docs/containers?topic=containers-pod_priority#pod_priority">Kubernetes pod priority support</a>.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS pod memory limit from <code>170Mi</code> to <code>400Mi</code> in order to handle more cluster services.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.7_1546, released 27 February 2019
{: #1117_1546}

The following table shows the changes that are in the worker node fix pack 1.11.7_1546.
{: shortdesc}

<table summary="Changes that were made since version 1.11.7_1546">
<caption>Changes since version 1.11.7_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog">CVE-2018-19407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.7_1544, released 15 February 2019
{: #1117_1544}

The following table shows the changes that are in the worker node fix pack 1.11.7_1544.
{: shortdesc}

<table summary="Changes that were made since version 1.11.7_1543">
<caption>Changes since version 1.11.7_1543</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Changed the pod configuration <code>spec.priorityClassName</code> value to <code>system-node-critical</code> and set the <code>spec.priority</code> value to <code>2000001000</code>.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.5</td>
<td>1.1.6</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.6">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736">CVE-2019-5736</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes <code>kubelet</code> configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the <code>ExperimentalCriticalPodAnnotation</code> feature gate to prevent critical static pod eviction.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.7_1543, released 5 February 2019
{: #1117_1543}

The following table shows the changes that are in the patch 1.11.7_1543.
{: shortdesc}

<table summary="Changes that were made since version 1.11.6_1541">
<caption>Changes since version 1.11.6_1541</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.11">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462">CVE-2019-3462</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.6-180</td>
<td>v1.11.7-198</td>
<td>Updated to support the Kubernetes 1.11.7 release. Additionally, <code>calicoctl</code> version is updated to 3.3.1. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with <a href="/docs/containers?topic=containers-file_storage#file-topology">volume topology-aware scheduling</a>.</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.6</td>
<td>v1.11.7</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.7">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for <code>cluster-admin</code> requests and logging the request body of workload <code>create</code>, <code>update</code>, and <code>patch</code> requests.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864">CVE-2018-16864</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.6_1541, released 28 January 2019
{: #1116_1541}

The following table shows the changes that are in the worker node fix pack 1.11.6_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.11.6_1540">
<caption>Changes since version 1.11.6_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including <code>apt</code> for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462">CVE-2019-3462</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> / <a href="https://ubuntu.com/security/notices/USN-3863-1">USN-3863-1</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.6_1540, released 21 January 2019
{: #1116_1540}

The following table shows the changes that are in the patch 1.11.6_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1539">
<caption>Changes since version 1.11.5_1539</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.5-152</td>
<td>v1.11.6-180</td>
<td>Updated to support the Kubernetes 1.11.6 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.5</td>
<td>v1.11.6</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.6">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the <a href="https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4">Kubernetes add-on resizer release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the <a href="https://github.com/kubernetes/dashboard/releases/tag/v1.10.1">Kubernetes dashboard release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264">CVE-2018-18264</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.<br><br>If you access the dashboard via <code>kubectl proxy</code>, the <strong>SKIP</strong> button on the login page is removed. Instead, <a href="/docs/containers?topic=containers-deploy_app#cli_dashboard">use a <strong>Token</strong> to log in</a>.</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.5_1539, released 7 January 2019
{: #1115_1539}

The following table shows the changes that are in the worker node fix pack 1.11.5_1539.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1538">
<caption>Changes since version 1.11.5_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog">CVE-2017-5753, CVE-2018-18690</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.5_1538, released 17 December 2018
{: #1115_1538}

The following table shows the changes that are in the worker node fix pack 1.11.5_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.11.5_1537">
<caption>Changes since version 1.11.5_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.5_1537, released 5 December 2018
{: #1115_1537}

The following table shows the changes that are in the patch 1.11.5_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.11.4_1536">
<caption>Changes since version 1.11.4_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.4-142</td>
<td>v1.11.5-152</td>
<td>Updated to support the Kubernetes 1.11.5 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.4</td>
<td>v1.11.5</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.5">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://github.com/kubernetes/kubernetes/issues/71411">CVE-2018-1002105</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.4_1536, released 4 December 2018
{: #1114_1536}

The following table shows the changes that are in the worker node fix pack 1.11.4_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.11.4_1535">
<caption>Changes since version 1.11.4_1535</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.4_1535, released 27 November 2018
{: #1114_1535}

The following table shows the changes that are in patch 1.11.4_1535.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1534">
<caption>Changes since version 1.11.3_1534</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://www.tigera.io/security-bulletins/">Tigera Technical Advisory TTA-2018-001</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>containerd</td>
<td>v1.1.4</td>
<td>v1.1.5</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.5">containerd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Updated containerd to fix a deadlock that can <a href="https://github.com/containerd/containerd/issues/2744">stop pods from terminating</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-127</td>
<td>v1.11.4-142</td>
<td>Updated to support the Kubernetes 1.11.4 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.3</td>
<td>v1.11.4</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.4">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.3_1534, released 19 November 2018
{: #1113_1534}

The following table shows the changes that are in the worker node fix pack 1.11.3_1534.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1533">
<caption>Changes since version 1.11.3_1533</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog">CVE-2018-7755</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for 1.11.3_1533, released 7 November 2018
{: #1113_1533}

The following table shows the changes that are in patch 1.11.3_1533.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1531">
<caption>Changes since version 1.11.3_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed the update to highly available (HA) masters for clusters that use admission webhooks such as <code>initializerconfigurations</code>, <code>mutatingwebhookconfigurations</code>, or <code>validatingwebhookconfigurations</code>. You might use these webhooks with Helm charts or admission controller projects such as Portieris.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-100</td>
<td>v1.11.3-127</td>
<td>Added the <code>service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan</code> annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run <code>ibmcloud ks vlan ls --zone &lt;zone&gt;</code>.</td>
</tr>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you <a href="/docs/containers?topic=containers-kubernetes-service-cli">enable trust</a> on an existing cluster, you need to <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">reload</a> any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the <strong>Trustable</strong> field after running the <code>ibmcloud ks flavors --zone</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_machine_types">command</a>.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.11.3_1531, released 1 November 2018
{: #1113_1531_ha-master}

The following table shows the changes that are in the master fix pack 1.11.3_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1527">
<caption>Changes since version 1.11.3_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts.</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Added an <code>ibm-master-proxy-*</code> pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.1">etcd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.1</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Encrypting data in etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, <a href="/docs/containers?topic=containers-encryption#keyprotect">enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.3_1531, released 26 October 2018
{: #1113_1531}

The following table shows the changes that are in the worker node fix pack 1.11.3_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1525">
<caption>Changes since version 1.11.3_1525</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.11.3_1527, released 15 October 2018
{: #1113_1527}

The following table shows the changes that are in the master fix pack 1.11.3_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1524">
<caption>Changes since version 1.11.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed <code>calico-node</code> container readiness probe to better handle node failures.</td>
</tr>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.3_1525, released 10 October 2018
{: #1113_1525}

The following table shows the changes that are in the worker node fix pack 1.11.3_1525.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1524">
<caption>Changes since version 1.11.3_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog">CVE-2018-14633, CVE-2018-17182</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


### Changelog for 1.11.3_1524, released 2 October 2018
{: #1113_1524}

The following table shows the changes that are in patch 1.11.3_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.11.3_1521">
<caption>Changes since version 1.11.3_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>1.1.3</td>
<td>1.1.4</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.4">containerd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/containerd/containerd/releases/tag/v1.1.4</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.3-91</td>
<td>v1.11.3-100</td>
<td>Updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed duplicate <code>reclaimPolicy</code> parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to set your own default, see <a href="/docs/containers?topic=containers-kube_concepts#default_storageclass">Changing the default storage class</a>.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.3_1521, released 20 September 2018
{: #1113_1521}

The following table shows the changes that are in patch 1.11.3_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1516">
<caption>Changes since version 1.11.2_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.2-71</td>
<td>v1.11.3-91</td>
<td>Updated to support Kubernetes 1.11.3 release.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed <code>mountOptions</code> in the IBM file storage classes to use the default that is provided by the worker node.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains <code>ibmc-file-bronze</code>. If you want to set your own default, see <a href="/docs/containers?topic=containers-kube_concepts#default_storageclass">Changing the default storage class</a>.</td>
</tr>
<tr>
<td>Key Management Service Provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the ability to use the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you <a href="/docs/containers?topic=containers-encryption#keyprotect">enable {{site.data.keyword.keymanagementserviceshort}} in your cluster</a>, all your Kubernetes secrets are encrypted.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.2</td>
<td>v1.11.3</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>See the <a href="https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.2.0">Kubernetes DNS autoscaler release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use <code>systemd</code> timers instead of <code>cronjobs</code> to prevent <code>logrotate</code> from failing on worker nodes that are not reloaded or updated within 90 days. <strong>Note</strong>: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the <code>ibmcloud ks worker reload</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">command</a> or the <code>ibmcloud ks worker update</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">command</a>.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running <code>chage -M -1 root</code>. <strong>Note</strong>: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">update</a> or <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">reload</a> your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>Worker node runtime components (<code>kubelet</code>, <code>kube-proxy</code>, <code>containerd</code>)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses <a href="https://github.com/kubernetes/kubernetes/issues/57345">Kubernetes issue 57345</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.2_1516, released 4 September 2018
{: #1112_1516}

The following table shows the changes that are in patch 1.11.2_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1514">
<caption>Changes since version 1.11.2_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.2</td>
<td>1.1.3</td>
<td>See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.3"><code>containerd</code> release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.11.2-60</td>
<td>v1.11.2-71</td>
<td>Changed the cloud provider configuration to better handle updates for load balancer services with <code>externalTrafficPolicy</code> set to <code>local</code>.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see <a href="/docs/containers?topic=containers-file_storage#nfs_version_class">Changing the default NFS version</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.11.2_1514, released 23 August 2018
{: #1112_1514}

The following table shows the changes that are in the worker node fix pack 1.11.2_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.11.2_1513">
<caption>Changes since version 1.11.2_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>systemd</code></td>
<td>229</td>
<td>230</td>
<td>Updated <code>systemd</code> to fix <code>cgroup</code> leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/notices/USN-3741-1/">CVE-2018-3620,CVE-2018-3646</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.11.2_1513, released 14 August 2018
{: #1112_1513}

The following table shows the changes that are in patch 1.11.2_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1518">
<caption>Changes since version 1.10.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>N/A</td>
<td>1.1.2</td>
<td><code>containerd</code> replaces Docker as the new container runtime for Kubernetes. See the <a href="https://github.com/containerd/containerd/releases/tag/v1.1.2"><code>containerd</code> release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td><code>containerd</code> replaces Docker as the new container runtime for Kubernetes, to enhance performance.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.14</td>
<td>v3.2.18</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.2.18">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.11.2-60</td>
<td>Updated to support Kubernetes 1.11 release. In addition, load balancer pods now use the new <code>ibm-app-cluster-critical</code> pod priority class.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated <code>incubator</code> version to 1.8. File storage is provisioned to the specific zone that you select. You can't update an existing (static) PV instance labels.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.11.2</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the OpenID Connect configuration for the cluster's Kubernetes API server to support {{site.data.keyword.cloud_notm}} Identity Access and Management (IAM) access groups. Added <code>Priority</code> to the <code>--enable-admission-plugins</code> option for the cluster's Kubernetes API server and configured the cluster to support pod priority. For more information, see:
<ul><li><a href="/docs/containers?topic=containers-users#rbac">{{site.data.keyword.cloud_notm}} IAM access groups</a></li>
<li><a href="/docs/containers?topic=containers-pod_priority#pod_priority">Configuring pod priority</a></li></ul></td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.2</td>
<td>v.1.5.4</td>
<td>Increased resource limits for the <code>heapster-nanny</code> container. See the <a href="https://github.com/kubernetes-retired/heapster/releases/tag/v1.5.4">Kubernetes Heapster release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Logging configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The container log directory is now <code>/var/log/pods/</code> instead of the previous <code>/var/lib/docker/containers/</code>.</td>
</tr>
</tbody>
</table>



## Version 1.10 changelog (unsupported as of 16 May 2019)
{: #110_changelog}

Review the version 1.10 changelogs.
{: shortdesc}

* [Changelog for worker node fix pack 1.10.13_1558, released 13 May 2019](#11013_1558)
* [Changelog for worker node fix pack 1.10.13_1557, released 29 April 2019](#11013_1557)
* [Changelog for worker node fix pack 1.10.13_1556, released 15 April 2019](#11013_1556)
* [Changelog for 1.10.13_1555, released 8 April 2019](#11013_1555)
* [Changelog for worker node fix pack 1.10.13_1554, released 1 April 2019](#11013_1554)
* [Changelog for master fix pack 1.10.13_1553, released 26 March 2019](#11118_1553)
* [Changelog for 1.10.13_1551, released 20 March 2019](#11013_1551)
* [Changelog for 1.10.13_1548, released 4 March 2019](#11013_1548)
* [Changelog for worker node fix pack 1.10.12_1546, released 27 February 2019](#11012_1546)
* [Changelog for worker node fix pack 1.10.12_1544, released 15 February 2019](#11012_1544)
* [Changelog for 1.10.12_1543, released 5 February 2019](#11012_1543)
* [Changelog for worker node fix pack 1.10.12_1541, released 28 January 2019](#11012_1541)
* [Changelog for 1.10.12_1540, released 21 January 2019](#11012_1540)
* [Changelog for worker node fix pack 1.10.11_1538, released 7 January 2019](#11011_1538)
* [Changelog for worker node fix pack 1.10.11_1537, released 17 December 2018](#11011_1537)
* [Changelog for 1.10.11_1536, released 4 December 2018](#11011_1536)
* [Changelog for worker node fix pack 1.10.8_1532, released 27 November 2018](#1108_1532)
* [Changelog for worker node fix pack 1.10.8_1531, released 19 November 2018](#1108_1531)
* [Changelog for 1.10.8_1530, released 7 November 2018](#1108_1530_ha-master)
* [Changelog for worker node fix pack 1.10.8_1528, released 26 October 2018](#1108_1528)
* [Changelog for worker node fix pack 1.10.8_1525, released 10 October 2018](#1108_1525)
* [Changelog for 1.10.8_1524, released 2 October 2018](#1108_1524)
* [Changelog for worker node fix pack 1.10.7_1521, released 20 September 2018](#1107_1521)
* [Changelog for 1.10.7_1520, released 4 September 2018](#1107_1520)
* [Changelog for worker node fix pack 1.10.5_1519, released 23 August 2018](#1105_1519)
* [Changelog for worker node fix pack 1.10.5_1518, released 13 August 2018](#1105_1518)
* [Changelog for 1.10.5_1517, released 27 July 2018](#1105_1517)
* [Changelog for worker node fix pack 1.10.3_1514, released 3 July 2018](#1103_1514)
* [Changelog for worker node fix pack 1.10.3_1513, released 21 June 2018](#1103_1513)
* [Changelog for 1.10.3_1512, released 12 June 2018](#1103_1512)
* [Changelog for worker node fix pack 1.10.1_1510, released 18 May 2018](#1101_1510)
* [Changelog for worker node fix pack 1.10.1_1509, released 16 May 2018](#1101_1509)
* [Changelog for 1.10.1_1508, released 01 May 2018](#1101_1508)

### Changelog for worker node fix pack 1.10.13_1558, released 13 May 2019
{: #11013_1558}

The following table shows the changes that are in the worker node fix pack 1.10.13_1558.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1557">
<caption>Changes since version 1.10.13_1557</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.9.6-alpine</td>
<td>1.9.7-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706">CVE-2019-6706</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.13_1557, released 29 April 2019
{: #11013_1557}

The following table shows the changes that are in the worker node fix pack 1.10.13_1557.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1556">
<caption>Changes since 1.10.13_1556</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.10.13_1556, released 15 April 2019
{: #11013_1556}

The following table shows the changes that are in the worker node fix pack 1.10.13_1556.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1555">
<caption>Changes since 1.10.13_1555</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including <code>systemd</code> for <a href="https://ubuntu.com/security/CVE-2019-3842.html">CVE-2019-3842</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.13_1555, released 8 April 2019
{: #11013_1555}

The following table shows the changes that are in the patch 1.10.13_1555.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1554">
<caption>Changes since version 1.10.13_1554</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy</td>
<td>1.8.12-alpine</td>
<td>1.9.6-alpine</td>
<td>See the <a href="https://www.haproxy.org/download/1.9/src/CHANGELOG">HAProxy release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543">CVE-2019-1543</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.10</td>
<td>1.14.13</td>
<td>See the <a href="https://github.com/kubernetes/dns/releases/tag/1.14.13">Kubernetes DNS release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>a02f765</td>
<td>e132aa4</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447">CVE-2017-12447</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 16.04 kernel</td>
<td>4.4.0-143-generic</td>
<td>4.4.0-145-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Ubuntu 18.04 kernel</td>
<td>4.15.0-46-generic</td>
<td>4.15.0-47-generic</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-9213.html">CVE-2019-9213</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.13_1554, released 1 April 2019
{: #11013_1554}

The following table shows the changes that are in the worker node fix 1.10.13_1554.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1553">
<caption>Changes since version 1.10.13_1553</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>


### Changelog for master fix pack 1.10.13_1553, released 26 March 2019
{: #11118_1553}

The following table shows the changes that are in the master fix pack 1.10.13_1553.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1551">
<caption>Changes since version 1.10.13_1551</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>345</td>
<td>346</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>166</td>
<td>167</td>
<td>Fixes intermittent <code>context deadline exceeded</code> and <code>timeout</code> errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>143</td>
<td>146</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.13_1551, released 20 March 2019
{: #11013_1551}

The following table shows the changes that are in the patch 1.10.13_1551.
{: shortdesc}

<table summary="Changes that were made since version 1.10.13_1548">
<caption>Changes since version 1.10.13_1548</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master HA proxy configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated configuration to better handle intermittent connection failures to the cluster master.</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>e32d51c</td>
<td>9ff3fda</td>
<td>Updated the GPU drivers to <a href="https://www.nvidia.com/object/unix.html">418.43</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update includes fix for <a href="https://ubuntu.com/security/CVE-2019-9741.html">CVE-2019-9741</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>344</td>
<td>345</td>
<td>Added support for <a href="/docs/containers?topic=containers-cs_network_cluster#set-up-private-se">private cloud service endpoints</a>.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-143</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/CVE-2019-6133.html">CVE-2019-6133</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>136</td>
<td>166</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890">CVE-2018-16890</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822">CVE-2019-3822</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823">CVE-2019-3823</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>5f3d092</td>
<td>a02f765</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779">CVE-2018-10779</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900">CVE-2018-12900</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000">CVE-2018-17000</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210">CVE-2018-19210</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128">CVE-2019-6128</a> <img src="../icons/launch-glyph.svg" alt="External link icon">, and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663">CVE-2019-7663</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.13_1548, released 4 March 2019
{: #11013_1548}

The following table shows the changes that are in the patch 1.10.13_1548.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1546">
<caption>Changes since version 1.10.12_1546</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>GPU device plug-in and installer</td>
<td>eb3a259</td>
<td>e32d51c</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.12-252</td>
<td>v1.10.13-288</td>
<td>Updated to support the Kubernetes 1.10.13 release. Fixed periodic connectivity problems for load balancers that set <code>externalTrafficPolicy</code> to <code>local</code>. Updated load balancer events to use the latest {{site.data.keyword.cloud_notm}} documentation links.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>342</td>
<td>344</td>
<td>Changed the base operating system for the image from Fedora to Alpine. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>122</td>
<td>136</td>
<td>Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.12</td>
<td>v1.10.13</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.13">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased Kubernetes DNS pod memory limit from <code>170Mi</code> to <code>400Mi</code> in order to handle more cluster services.</td>
</tr>
<tr>
<td>Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider</td>
<td>132</td>
<td>143</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.6-r3-IKS-13</td>
<td>2.4.6-r3-IKS-25</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559">CVE-2019-1559</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Trusted compute agent</td>
<td>1ea5ad3</td>
<td>5f3d092</td>
<td>Updated image for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454">CVE-2019-6454</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.12_1546, released 27 February 2019
{: #11012_1546}

The following table shows the changes that are in the worker node fix pack 1.10.12_1546.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1544">
<caption>Changes since version 1.10.12_1544</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-141</td>
<td>4.4.0-142</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog">CVE-2018-19407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.12_1544, released 15 February 2019
{: #11012_1544}

The following table shows the changes that are in the worker node fix pack 1.10.12_1544.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1543">
<caption>Changes since version 1.10.12_1543</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>18.06.1-ce</td>
<td>18.06.2-ce</td>
<td>See the <a href="https://github.com/docker/docker-ce/releases/tag/v18.06.2-ce">Docker Community Edition release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736">CVE-2019-5736</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes <code>kubelet</code> configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the <code>ExperimentalCriticalPodAnnotation</code> feature gate to prevent critical static pod eviction.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.12_1543, released 5 February 2019
{: #11012_1543}

The following table shows the changes that are in the patch 1.10.12_1543.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1541">
<caption>Changes since version 1.10.12_1541</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>etcd</td>
<td>v3.3.1</td>
<td>v3.3.11</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.11">etcd release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).</td>
</tr>
<tr>
<td>GPU device plug-in and installer</td>
<td>13fdc0d</td>
<td>eb3a259</td>
<td>Updated images for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462">CVE-2019-3462</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486">CVE-2019-6486</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>338</td>
<td>342</td>
<td>The file storage plug-in is updated as follows:
<ul><li>Supports dynamic provisioning with <a href="/docs/containers?topic=containers-file_storage#file-topology">volume topology-aware scheduling</a>.</li>
<li>Ignores persistent volume claim (PVC) delete errors if the storage is already deleted.</li>
<li>Adds a failure message annotation to failed PVCs.</li>
<li>Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.</li>
<li>Checks user permissions before starting the provisioning.</li></ul></td>
</tr>
<tr>
<td>Key Management Service provider</td>
<td>111</td>
<td>122</td>
<td>Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.</td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>The Kubernetes API server audit policy configuration is updated to include logging metadata for <code>cluster-admin</code> requests and logging the request body of workload <code>create</code>, <code>update</code>, and <code>patch</code> requests.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Additionally, the pod configuration is now obtained from a secret instead of from a configmap.</td>
</tr>
<tr>
<td>OpenVPN server</td>
<td>2.4.6-r3-IKS-8</td>
<td>2.4.6-r3-IKS-13</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734">CVE-2018-0734</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407">CVE-2018-5407</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>systemd</td>
<td>230</td>
<td>229</td>
<td>Security patch for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864">CVE-2018-16864</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.12_1541, released 28 January 2019
{: #11012_1541}

The following table shows the changes that are in the worker node fix pack 1.10.12_1541.
{: shortdesc}

<table summary="Changes that were made since version 1.10.12_1540">
<caption>Changes since version 1.10.12_1540</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages including <code>apt</code> for <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462">CVE-2019-3462</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://ubuntu.com/security/notices/USN-3863-1">USN-3863-1</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.12_1540, released 21 January 2019
{: #11012_1540}

The following table shows the changes that are in the patch 1.10.12_1540.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1538">
<caption>Changes since version 1.10.11_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.11-219</td>
<td>v1.10.12-252</td>
<td>Updated to support the Kubernetes 1.10.12 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.11</td>
<td>v1.10.12</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.12">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes add-on resizer</td>
<td>1.8.1</td>
<td>1.8.4</td>
<td>See the <a href="https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4">Kubernetes add-on resizer release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes dashboard</td>
<td>v1.8.3</td>
<td>v1.10.1</td>
<td>See the <a href="https://github.com/kubernetes/dashboard/releases/tag/v1.10.1">Kubernetes dashboard release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264">CVE-2018-18264</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.<br><br>If you access the dashboard via <code>kubectl proxy</code>, the <strong>SKIP</strong> button on the login page is removed. Instead, <a href="/docs/containers?topic=containers-deploy_app#cli_dashboard">use a <strong>Token</strong> to log in</a>.</td>
</tr>
<tr>
<td>GPU installer</td>
<td>390.12</td>
<td>410.79</td>
<td>Updated the installed GPU drivers to 410.79.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.11_1538, released 7 January 2019
{: #11011_1538}

The following table shows the changes that are in the worker node fix pack 1.10.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1537">
<caption>Changes since version 1.10.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-139</td>
<td>4.4.0-141</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog">CVE-2017-5753, CVE-2018-18690</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.11_1537, released 17 December 2018
{: #11011_1537}

The following table shows the changes that are in the worker node fix pack 1.10.11_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.10.11_1536">
<caption>Changes since version 1.10.11_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>


### Changelog for 1.10.11_1536, released 4 December 2018
{: #11011_1536}

The following table shows the changes that are in patch 1.10.11_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1532">
<caption>Changes since version 1.10.8_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.2.1</td>
<td>v3.3.1</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://www.tigera.io/security-bulletins/">Tigera Technical Advisory TTA-2018-001</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.8-197</td>
<td>v1.10.11-219</td>
<td>Updated to support the Kubernetes 1.10.11 release.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.8</td>
<td>v1.10.11</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.11">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://github.com/kubernetes/kubernetes/issues/71411">CVE-2018-1002105</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r1-6</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1532, released 27 November 2018
{: #1108_1532}

The following table shows the changes that are in the worker node fix pack 1.10.8_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1531">
<caption>Changes since version 1.10.8_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>See the <a href="https://docs.docker.com/engine/release-notes/#18061-ce">Docker release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1531, released 19 November 2018
{: #1108_1531}

The following table shows the changes that are in the worker node fix pack 1.10.8_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1530">
<caption>Changes since version 1.10.8_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog">CVE-2018-7755</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.8_1530, released 7 November 2018
{: #1108_1530_ha-master}

The following table shows the changes that are in patch 1.10.8_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1528">
<caption>Changes since version 1.10.8_1528</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster master</td>
<td>N/A</td>
<td>N/A</td>
<td>Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts. Further, if your cluster is in a multizone-capable zone, the masters are spread across zones.</td>
</tr>
<tr>
<td>Cluster master HA proxy</td>
<td>N/A</td>
<td>1.8.12-alpine</td>
<td>Added an <code>ibm-master-proxy-*</code> pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica.</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.18</td>
<td>v3.3.1</td>
<td>See the <a href="https://github.com/etcd-io/etcd/releases/v3.3.1">etcd release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/etcd-io/etcd/releases/v3.3.1</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Encrypting data in etcd</td>
<td>N/A</td>
<td>N/A</td>
<td>Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, <a href="/docs/containers?topic=containers-encryption#keyprotect">enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster</a>.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.8-172</td>
<td>v1.10.8-197</td>
<td>Added the <code>service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan</code> annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run <code>ibmcloud ks vlan ls --zone &lt;zone&gt;</code>.</td>
</tr>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you <a href="/docs/containers?topic=containers-kubernetes-service-cli">enable trust</a> on an existing cluster, you need to <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">reload</a> any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the <strong>Trustable</strong> field after running the <code>ibmcloud ks flavors --zone</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_machine_types">command</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1528, released 26 October 2018
{: #1108_1528}

The following table shows the changes that are in the worker node fix pack 1.10.8_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1527">
<caption>Changes since version 1.10.8_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.10.8_1527, released 15 October 2018
{: #1108_1527}

The following table shows the changes that are in the master fix pack 1.10.8_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1524">
<caption>Changes since version 1.10.8_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed <code>calico-node</code> container readiness probe to better handle node failures.</td>
</tr>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.8_1525, released 10 October 2018
{: #1108_1525}

The following table shows the changes that are in the worker node fix pack 1.10.8_1525.
{: shortdesc}

<table summary="Changes that were made since version 1.10.8_1524">
<caption>Changes since version 1.10.8_1524</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog">CVE-2018-14633, CVE-2018-17182</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


### Changelog for 1.10.8_1524, released 2 October 2018
{: #1108_1524}

The following table shows the changes that are in patch 1.10.8_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.10.7_1520">
<caption>Changes since version 1.10.7_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service Provider</td>
<td>N/A</td>
<td>N/A</td>
<td>Added the ability to use the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you <a href="/docs/containers?topic=containers-encryption#keyprotect">enable {{site.data.keyword.keymanagementserviceshort}} in your cluster</a>, all your Kubernetes secrets are encrypted.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.7</td>
<td>v1.10.8</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8">Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes DNS autoscaler</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>See the <a href="https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.2.0">Kubernetes DNS autoscaler release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.2.0</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.7-146</td>
<td>v1.10.8-172</td>
<td>Updated to support Kubernetes 1.10.8 release. Also, updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed <code>mountOptions</code> in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate <code>reclaimPolicy</code> parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to set your own default, see <a href="/docs/containers?topic=containers-kube_concepts#default_storageclass">Changing the default storage class</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.7_1521, released 20 September 2018
{: #1107_1521}

The following table shows the changes that are in the worker node fix pack 1.10.7_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.10.7_1520">
<caption>Changes since version 1.10.7_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use <code>systemd</code> timers instead of <code>cronjobs</code> to prevent <code>logrotate</code> from failing on worker nodes that are not reloaded or updated within 90 days. <strong>Note</strong>: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the <code>ibmcloud ks worker reload</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">command</a> or the <code>ibmcloud ks worker update</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">command</a>.</td>
</tr>
<tr>
<td>Worker node runtime components (<code>kubelet</code>, <code>kube-proxy</code>, <code>docker</code>)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running <code>chage -M -1 root</code>. <strong>Note</strong>: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">update</a> or <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">reload</a> your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses <a href="https://github.com/kubernetes/kubernetes/issues/57345">Kubernetes issue 57345</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Disabled the default Docker bridge so that the <code>172.17.0.0/16</code> IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing <code>docker</code> commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options.<ul><li>To ensure external network connectivity when you build the container, run <code>docker build . --network host</code>.</li>
<li>To explicitly create a network to use when you build the container, run <code>docker network create</code> and then use this network.</li></ul>
<strong>Note</strong>: Have dependencies on the Docker socket or Docker directly? Update to <code>containerd</code> instead of <code>docker</code> as the container runtime so that your clusters are prepared to run Kubernetes version 1.11 or later.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.7_1520, released 4 September 2018
{: #1107_1520}

The following table shows the changes that are in patch 1.10.7_1520.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1519">
<caption>Changes since version 1.10.5_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>See the Calico <a href="https://docs.projectcalico.org/release-notes/">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.10.7-146</td>
<td>Updated to support Kubernetes 1.10.7 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with <code>externalTrafficPolicy</code> set to <code>local</code>.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You can't update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.<br><br> Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see <a href="/docs/containers?topic=containers-file_storage#nfs_version_class">Changing the default NFS version</a>.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.10.7</td>
<td>See the Kubernetes <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Heapster configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased resource limits for the <code>heapster-nanny</code> container.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.5_1519, released 23 August 2018
{: #1105_1519}

The following table shows the changes that are in the worker node fix pack 1.10.5_1519.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1518">
<caption>Changes since version 1.10.5_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>systemd</code></td>
<td>229</td>
<td>230</td>
<td>Updated <code>systemd</code> to fix <code>cgroup</code> leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/notices/USN-3741-1/">CVE-2018-3620,CVE-2018-3646</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.10.5_1518, released 13 August 2018
{: #1105_1518}

The following table shows the changes that are in the worker node fix pack 1.10.5_1518.
{: shortdesc}

<table summary="Changes that were made since version 1.10.5_1517">
<caption>Changes since version 1.10.5_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.5_1517, released 27 July 2018
{: #1105_1517}

The following table shows the changes that are in patch 1.10.5_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1514">
<caption>Changes since version 1.10.3_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>See the Calico <a href="https://docs.projectcalico.org/releases/">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Updated to support Kubernetes 1.10.5 release. In addition, LoadBalancer service <code>create failure</code> events now include any portable subnet errors.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to <code>hourly</code>. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the <strong>Notes</strong> field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>See the Kubernetes <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace is now managed by the Kubernetes <code>addon-manager</code>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.3_1514, released 3 July 2018
{: #1103_1514}

The following table shows the changes that are in the worker node fix pack 1.10.3_1514.
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1513">
<caption>Changes since version 1.10.3_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized <code>sysctl</code> for high performance networking workloads.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.10.3_1513, released 21 June 2018
{: #1103_1513}

The following table shows the changes that are in the worker node fix pack 1.10.3_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.10.3_1512">
<caption>Changes since version 1.10.3_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.3_1512, released 12 June 2018
{: #1103_1512}

The following table shows the changes that are in patch 1.10.3_1512.
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1510">
<caption>Changes since version 1.10.1_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>See the Kubernetes <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>PodSecurityPolicy</code> to the <code>--enable-admission-plugins</code> option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see <a href="/docs/containers?topic=containers-psp">Configuring pod security policies</a>.</td>
</tr>
<tr>
<td>Kubelet Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Enabled the <code>--authentication-token-webhook</code> option to support API bearer and service account tokens for authenticating to the <code>kubelet</code> HTTPS endpoint.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Updated to support Kubernetes 1.10.3 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>livenessProbe</code> to the OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace.</td>
</tr>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639">CVE-2018-3639</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>



### Changelog for worker node fix pack 1.10.1_1510, released 18 May 2018
{: #1101_1510}

The following table shows the changes that are in the worker node fix pack 1.10.1_1510.
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1509">
<caption>Changes since version 1.10.1_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.10.1_1509, released 16 May 2018
{: #1101_1509}

The following table shows the changes that are in the worker node fix pack 1.10.1_1509.
{: shortdesc}

<table summary="Changes that were made since version 1.10.1_1508">
<caption>Changes since version 1.10.1_1508</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the <code>kubelet</code> root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

### Changelog for 1.10.1_1508, released 01 May 2018
{: #1101_1508}

The following table shows the changes that are in patch 1.10.1_1508.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1510">
<caption>Changes since version 1.9.7_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>See the Calico <a href="https://docs.projectcalico.org/release-notes/">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>See the Kubernetes Heapster <a href="https://github.com/kubernetes-retired/heapster/releases/tag/v1.5.2">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>See the Kubernetes <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>StorageObjectInUseProtection</code> to the <code>--enable-admission-plugins</code> option for the cluster's Kubernetes API server.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>See the Kubernetes DNS <a href="https://github.com/kubernetes/dns/releases/tag/1.14.10">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Updated to support Kubernetes 1.10 release.</td>
</tr>
<tr>
<td>GPU support</td>
<td>N/A</td>
<td>N/A</td>
<td>Support for [graphics processing unit (GPU) container workloads](/docs/containers?topic=containers-deploy_app#gpu_app) is now available for scheduling and execution. For a list of available GPU flavors, see <a href="/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes">Hardware for worker nodes</a>. For more information, see the Kubernetes documentation to <a href="https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/">Schedule GPUs</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>



## Version 1.9 changelog (unsupported as of 27 December 2018)
{: #19_changelog}

Review the version 1.9 changelogs.
{: shortdesc}

* [Changelog for worker node fix pack 1.9.11_1539, released 17 December 2018](#1911_1539)
* [Changelog for worker node fix pack 1.9.11_1538, released 4 December 2018](#1911_1538)
* [Changelog for worker node fix pack 1.9.11_1537, released 27 November 2018](#1911_1537)
* [Changelog for 1.9.11_1536, released 19 November 2018](#1911_1536)
* [Changelog for worker node fix 1.9.10_1532, released 7 November 2018](#1910_1532)
* [Changelog for worker node fix pack 1.9.10_1531, released 26 October 2018](#1910_1531)
* [Changelog for master fix pack 1.9.10_1530 released 15 October 2018](#1910_1530)
* [Changelog for worker node fix pack 1.9.10_1528, released 10 October 2018](#1910_1528)
* [Changelog for 1.9.10_1527, released 2 October 2018](#1910_1527)
* [Changelog for worker node fix pack 1.9.10_1524, released 20 September 2018](#1910_1524)
* [Changelog for 1.9.10_1523, released 4 September 2018](#1910_1523)
* [Changelog for worker node fix pack 1.9.9_1522, released 23 August 2018](#199_1522)
* [Changelog for worker node fix pack 1.9.9_1521, released 13 August 2018](#199_1521)
* [Changelog for 1.9.9_1520, released 27 July 2018](#199_1520)
* [Changelog for worker node fix pack 1.9.8_1517, released 3 July 2018](#198_1517)
* [Changelog for worker node fix pack 1.9.8_1516, released 21 June 2018](#198_1516)
* [Changelog for 1.9.8_1515, released 19 June 2018](#198_1515)
* [Changelog for worker node fix pack 1.9.7_1513, released 11 June 2018](#197_1513)
* [Changelog for worker node fix pack 1.9.7_1512, released 18 May 2018](#197_1512)
* [Changelog for worker node fix pack 1.9.7_1511, released 16 May 2018](#197_1511)
* [Changelog for 1.9.7_1510, released 30 April 2018](#197_1510)

### Changelog for worker node fix pack 1.9.11_1539, released 17 December 2018
{: #1911_1539}

The following table shows the changes that are in the worker node fix pack 1.9.11_1539.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1538">
<caption>Changes since version 1.9.11_1538</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.11_1538, released 4 December 2018
{: #1911_1538}

The following table shows the changes that are in the worker node fix pack 1.9.11_1538.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1537">
<caption>Changes since version 1.9.11_1537</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Worker node resource utilization</td>
<td>N/A</td>
<td>N/A</td>
<td>Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see <a href="/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node">Worker node resource reserves</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.11_1537, released 27 November 2018
{: #1911_1537}

The following table shows the changes that are in the worker node fix pack 1.9.11_1537.
{: shortdesc}

<table summary="Changes that were made since version 1.9.11_1536">
<caption>Changes since version 1.9.11_1536</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>17.06.2</td>
<td>18.06.1</td>
<td>See the <a href="https://docs.docker.com/engine/release-notes/#18061-ce">Docker release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.11_1536, released 19 November 2018
{: #1911_1536}

The following table shows the changes that are in patch 1.9.11_1536.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1532">
<caption>Changes since version 1.9.10_1532</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v2.6.12</td>
<td>See the <a href="https://docs.projectcalico.org/release-notes/">Calico release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. Update resolves <a href="https://www.tigera.io/security-bulletins/">Tigera Technical Advisory TTA-2018-001</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-137</td>
<td>4.4.0-139</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog">CVE-2018-7755</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.10</td>
<td>v1.9.11</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.9.11">Kubernetes release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}}</td>
<td>v1.9.10-219</td>
<td>v1.9.11-249</td>
<td>Updated to support the Kubernetes 1.9.11 release.</td>
</tr>
<tr>
<td>OpenVPN client and server</td>
<td>2.4.4-r2</td>
<td>2.4.6-r3-IKS-8</td>
<td>Updated image for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732">CVE-2018-0732</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737">CVE-2018-0737</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix 1.9.10_1532, released 7 November 2018
{: #1910_1532}

The following table shows the changes that are in the worker node fix pack 1.9.11_1532.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1531">
<caption>Changes since version 1.9.10_1531</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>TPM-enabled kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you <a href="/docs/containers?topic=containers-kubernetes-service-cli">enable trust</a> on an existing cluster, you need to <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">reload</a> any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the <strong>Trustable</strong> field after running the <code>ibmcloud ks flavors --zone</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_machine_types">command</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.10_1531, released 26 October 2018
{: #1910_1531}

The following table shows the changes that are in the worker node fix pack 1.9.10_1531.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1530">
<caption>Changes since version 1.9.10_1530</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>OS interrupt handling</td>
<td>N/A</td>
<td>N/A</td>
<td>Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler.</td>
</tr>
</tbody>
</table>

### Changelog for master fix pack 1.9.10_1530 released 15 October 2018
{: #1910_1530}

The following table shows the changes that are in the worker node fix pack 1.9.10_1530.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1527">
<caption>Changes since version 1.9.10_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cluster update</td>
<td>N/A</td>
<td>N/A</td>
<td>Fixed problem with updating cluster add-ons when the master is updated from an unsupported version.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.10_1528, released 10 October 2018
{: #1910_1528}

The following table shows the changes that are in the worker node fix pack 1.9.10_1528.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1527">
<caption>Changes since version 1.9.10_1527</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Updated worker node images with kernel update for <a href="https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog">CVE-2018-14633, CVE-2018-17182</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Inactive session timeout</td>
<td>N/A</td>
<td>N/A</td>
<td>Set the inactive session timeout to 5 minutes for compliance reasons.</td>
</tr>
</tbody>
</table>


### Changelog for 1.9.10_1527, released 2 October 2018
{: #1910_1527}

The following table shows the changes that are in patch 1.9.10_1527.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1523">
<caption>Changes since version 1.9.10_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.10-192</td>
<td>v1.9.10-219</td>
<td>Updated the documentation link in load balancer error messages.</td>
</tr>
<tr>
<td>IBM file storage classes</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed <code>mountOptions</code> in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate <code>reclaimPolicy</code> parameter in the IBM file storage classes.<br><br>
Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to set your own default, see <a href="/docs/containers?topic=containers-kube_concepts#default_storageclass">Changing the default storage class</a>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.10_1524, released 20 September 2018
{: #1910_1524}

The following table shows the changes that are in the worker node fix pack 1.9.10_1524.
{: shortdesc}

<table summary="Changes that were made since version 1.9.10_1523">
<caption>Changes since version 1.9.10_1523</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use <code>systemd</code> timers instead of <code>cronjobs</code> to prevent <code>logrotate</code> from failing on worker nodes that are not reloaded or updated within 90 days. <strong>Note</strong>: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the <code>ibmcloud ks worker reload</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">command</a> or the <code>ibmcloud ks worker update</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">command</a>.</td>
</tr>
<tr>
<td>Worker node runtime components (<code>kubelet</code>, <code>kube-proxy</code>, <code>docker</code>)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running <code>chage -M -1 root</code>. <strong>Note</strong>: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">update</a> or <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">reload</a> your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses <a href="https://github.com/kubernetes/kubernetes/issues/57345">Kubernetes issue 57345</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Disabled the default Docker bridge so that the <code>172.17.0.0/16</code> IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing <code>docker</code> commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options.<ul><li>To ensure external network connectivity when you build the container, run <code>docker build . --network host</code>.</li>
<li>To explicitly create a network to use when you build the container, run <code>docker network create</code> and then use this network.</li></ul>
<strong>Note</strong>: Have dependencies on the Docker socket or Docker directly? Update to <code>containerd</code> instead of <code>docker</code> as the container runtime so that your clusters are prepared to run Kubernetes version 1.11 or later.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.10_1523, released 4 September 2018
{: #1910_1523}

The following table shows the changes that are in patch 1.9.10_1523.
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1522">
<caption>Changes since version 1.9.9_1522</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.9-167</td>
<td>v1.9.10-192</td>
<td>Updated to support Kubernetes 1.9.10 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with <code>externalTrafficPolicy</code> set to <code>local</code>.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>334</td>
<td>338</td>
<td>Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You can't update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.<br><br>Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see <a href="/docs/containers?topic=containers-file_storage#nfs_version_class">Changing the default NFS version</a>.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.9</td>
<td>v1.9.10</td>
<td>See the Kubernetes <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Heapster configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Increased resource limits for the <code>heapster-nanny</code> container.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.9_1522, released 23 August 2018
{: #199_1522}

The following table shows the changes that are in the worker node fix pack 1.9.9_1522.
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1521">
<caption>Changes since version 1.9.9_1521</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>systemd</code></td>
<td>229</td>
<td>230</td>
<td>Updated <code>systemd</code> to fix <code>cgroup</code> leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/notices/USN-3741-1/">CVE-2018-3620,CVE-2018-3646</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.9.9_1521, released 13 August 2018
{: #199_1521}

The following table shows the changes that are in the worker node fix pack 1.9.9_1521.
{: shortdesc}

<table summary="Changes that were made since version 1.9.9_1520">
<caption>Changes since version 1.9.9_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.9_1520, released 27 July 2018
{: #199_1520}

The following table shows the changes that are in patch 1.9.9_1520.
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1517">
<caption>Changes since version 1.9.8_1517</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Updated to support Kubernetes 1.9.9 release. In addition, LoadBalancer service <code>create failure</code> events now include any portable subnet errors.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to <code>hourly</code>. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the <strong>Notes</strong> field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>See the Kubernetes <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace is now managed by the Kubernetes <code>addon-manager</code>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.8_1517, released 3 July 2018
{: #198_1517}

The following table shows the changes that are in the worker node fix pack 1.9.8_1517.
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1516">
<caption>Changes since version 1.9.8_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized <code>sysctl</code> for high performance networking workloads.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.9.8_1516, released 21 June 2018
{: #198_1516}

The following table shows the changes that are in the worker node fix pack 1.9.8_1516.
{: shortdesc}

<table summary="Changes that were made since version 1.9.8_1515">
<caption>Changes since version 1.9.8_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.8_1515, released 19 June 2018
{: #198_1515}

The following table shows the changes that are in patch 1.9.8_1515.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1513">
<caption>Changes since version 1.9.7_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8">Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>PodSecurityPolicy</code> to the <code>--admission-control</code> option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see <a href="/docs/containers?topic=containers-psp">Configuring pod security policies</a>.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Updated to support Kubernetes 1.9.8 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>livenessProbe</code> to the OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.9.7_1513, released 11 June 2018
{: #197_1513}

The following table shows the changes that are in the worker node fix pack 1.9.7_1513.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1512">
<caption>Changes since version 1.9.7_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639">CVE-2018-3639</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.7_1512, released 18 May 2018
{: #197_1512}

The following table shows the changes that are in the worker node fix pack 1.9.7_1512.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1511">
<caption>Changes since version 1.9.7_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.9.7_1511, released 16 May 2018
{: #197_1511}

The following table shows the changes that are in the worker node fix pack 1.9.7_1511.
{: shortdesc}

<table summary="Changes that were made since version 1.9.7_1510">
<caption>Changes since version 1.9.7_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the <code>kubelet</code> root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

### Changelog for 1.9.7_1510, released 30 April 2018
{: #197_1510}

The following table shows the changes that are in patch 1.9.7_1510.
{: shortdesc}

<table summary="Changes that were made since version 1.9.3_1506">
<caption>Changes since version 1.9.3_1506</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.3</td>
<td>v1.9.7    </td>
<td><p>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7">Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. This release addresses <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101">CVE-2017-1002101</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102">CVE-2017-1002102</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> vulnerabilities.</p><p><strong>Note</strong>: Now <code>secret</code>, <code>configMap</code>, <code>downwardAPI</code>, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<tr>
<td>Kubernetes configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>admissionregistration.k8s.io/v1alpha1=true</code> to the <code>--runtime-config</code> option for the cluster's Kubernetes API server.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td><code>NodePort</code> and <code>LoadBalancer</code> services now support <a href="/docs/containers?topic=containers-loadbalancer#lb_source_ip">preserving the client source IP</a> by setting <code>service.spec.externalTrafficPolicy</code> to <code>Local</code>.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix <a href="/docs/containers?topic=containers-edge#edge">edge node</a> toleration setup for older clusters.</td>
</tr>
</tbody>
</table>



## Version 1.8 changelog (Unsupported)
{: #18_changelog}

Review the version 1.8 changelogs.
{: shortdesc}

* [Changelog for worker node fix pack 1.8.15_1521, released 20 September 2018](#1815_1521)
* [Changelog for worker node fix pack 1.8.15_1520, released 23 August 2018](#1815_1520)
* [Changelog for worker node fix pack 1.8.15_1519, released 13 August 2018](#1815_1519)
* [Changelog for 1.8.15_1518, released 27 July 2018](#1815_1518)
* [Changelog for worker node fix pack 1.8.13_1516, released 3 July 2018](#1813_1516)
* [Changelog for worker node fix pack 1.8.13_1515, released 21 June 2018](#1813_1515)
* [Changelog 1.8.13_1514, released 19 June 2018](#1813_1514)
* [Changelog for worker node fix pack 1.8.11_1512, released 11 June 2018](#1811_1512)
* [Changelog for worker node fix pack 1.8.11_1511, released 18 May 2018](#1811_1511)
* [Changelog for worker node fix pack 1.8.11_1510, released 16 May 2018](#1811_1510)
* [Changelog for 1.8.11_1509, released 19 April 2018](#1811_1509)

### Changelog for worker node fix pack 1.8.15_1521, released 20 September 2018
{: #1815_1521}

<table summary="Changes that were made since version 1.8.15_1520">
<caption>Changes since version 1.8.15_1520</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Log rotate</td>
<td>N/A</td>
<td>N/A</td>
<td>Switched to use <code>systemd</code> timers instead of <code>cronjobs</code> to prevent <code>logrotate</code> from failing on worker nodes that are not reloaded or updated within 90 days. <strong>Note</strong>: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the <code>ibmcloud ks worker reload</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">command</a> or the <code>ibmcloud ks worker update</code> <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">command</a>.</td>
</tr>
<tr>
<td>Worker node runtime components (<code>kubelet</code>, <code>kube-proxy</code>, <code>docker</code>)</td>
<td>N/A</td>
<td>N/A</td>
<td>Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.</td>
</tr>
<tr>
<td>Root password expiration</td>
<td>N/A</td>
<td>N/A</td>
<td>Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running <code>chage -M -1 root</code>. <strong>Note</strong>: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update">update</a> or <a href="/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload">reload</a> your worker nodes at least every 90 days.</td>
</tr>
<tr>
<td>systemd</td>
<td>N/A</td>
<td>N/A</td>
<td>Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses <a href="https://github.com/kubernetes/kubernetes/issues/57345">Kubernetes issue 57345</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.15_1520, released 23 August 2018
{: #1815_1520}

<table summary="Changes that were made since version 1.8.15_1519">
<caption>Changes since version 1.8.15_1519</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>systemd</code></td>
<td>229</td>
<td>230</td>
<td>Updated <code>systemd</code> to fix <code>cgroup</code> leak.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Updated worker node images with kernel update for <a href="https://ubuntu.com/security/notices/USN-3741-1/">CVE-2018-3620,CVE-2018-3646</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.15_1519, released 13 August 2018
{: #1815_1519}

<table summary="Changes that were made since version 1.8.15_1518">
<caption>Changes since version 1.8.15_1518</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu packages</td>
<td>N/A</td>
<td>N/A</td>
<td>Updates to installed Ubuntu packages.</td>
</tr>
</tbody>
</table>

### Changelog for 1.8.15_1518, released 27 July 2018
{: #1815_1518}

<table summary="Changes that were made since version 1.8.13_1516">
<caption>Changes since version 1.8.13_1516</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Updated to support Kubernetes 1.8.15 release. In addition, LoadBalancer service <code>create failure</code> events now include any portable subnet errors.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} File Storage plug-in</td>
<td>320</td>
<td>334</td>
<td>Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to <code>hourly</code>. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the <strong>Notes</strong> field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>See the Kubernetes <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15">release notes</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Minor improvements to worker node network settings for high performance networking workloads.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>The OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace is now managed by the Kubernetes <code>addon-manager</code>.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.13_1516, released 3 July 2018
{: #1813_1516}

<table summary="Changes that were made since version 1.8.13_1515">
<caption>Changes since version 1.8.13_1515</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimized <code>sysctl</code> for high performance networking workloads.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.8.13_1515, released 21 June 2018
{: #1813_1515}

<table summary="Changes that were made since version 1.8.13_1514">
<caption>Changes since version 1.8.13_1514</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node.</td>
</tr>
</tbody>
</table>

### Changelog 1.8.13_1514, released 19 June 2018
{: #1813_1514}

<table summary="Changes that were made since version 1.8.11_1512">
<caption>Changes since version 1.8.11_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13">Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
<tr>
<td>Kubernetes Configuration</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>PodSecurityPolicy</code> to the <code>--admission-control</code> option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see <a href="/docs/containers?topic=containers-psp">Configuring pod security policies</a>.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Updated to support Kubernetes 1.8.13 release.</td>
</tr>
<tr>
<td>OpenVPN client</td>
<td>N/A</td>
<td>N/A</td>
<td>Added <code>livenessProbe</code> to the OpenVPN client <code>vpn</code> deployment that runs in the <code>kube-system</code> namespace.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.8.11_1512, released 11 June 2018
{: #1811_1512}

<table summary="Changes that were made since version 1.8.11_1511">
<caption>Changes since version 1.8.11_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639">CVE-2018-3639</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>


### Changelog for worker node fix pack 1.8.11_1511, released 18 May 2018
{: #1811_1511}

<table summary="Changes that were made since version 1.8.11_1510">
<caption>Changes since version 1.8.11_1510</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.8.11_1510, released 16 May 2018
{: #1811_1510}

<table summary="Changes that were made since version 1.8.11_1509">
<caption>Changes since version 1.8.11_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the <code>kubelet</code> root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>


### Changelog for 1.8.11_1509, released 19 April 2018
{: #1811_1509}

<table summary="Changes that were made since version 1.8.8_1507">
<caption>Changes since version 1.8.8_1507</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11    </td>
<td><p>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11">Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. This release addresses <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101">CVE-2017-1002101</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102">CVE-2017-1002102</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> vulnerabilities.</p><p>Now <code>secret</code>, <code>configMap</code>, <code>downwardAPI</code>, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<tr>
<td>Pause container image</td>
<td>3.0</td>
<td>3.1</td>
<td>Removes inherited orphaned zombie processes.</td>
</tr>
<tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td><code>NodePort</code> and <code>LoadBalancer</code> services now support <a href="/docs/containers?topic=containers-loadbalancer#lb_source_ip">preserving the client source IP</a> by setting <code>service.spec.externalTrafficPolicy</code> to <code>Local</code>.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix <a href="/docs/containers?topic=containers-edge#edge">edge node</a> toleration setup for older clusters.</td>
</tr>
</tbody>
</table>



## Version 1.7 changelog (Unsupported)
{: #17_changelog}

Review the version 1.7 changelogs.
{: shortdesc}

* [Changelog for worker node fix pack 1.7.16_1514, released 11 June 2018](#1716_1514)
* [Changelog for worker node fix pack 1.7.16_1513, released 18 May 2018](#1716_1513)
* [Changelog for worker node fix pack 1.7.16_1512, released 16 May 2018](#1716_1512)
* [Changelog for 1.7.16_1511, released 19 April 2018](#1716_1511)

### Changelog for worker node fix pack 1.7.16_1514, released 11 June 2018
{: #1716_1514}

<table summary="Changes that were made since version 1.7.16_1513">
<caption>Changes since version 1.7.16_1513</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel update</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>New worker node images with kernel update for <a href="http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639">CVE-2018-3639</a> <img src="../icons/launch-glyph.svg" alt="External link icon">.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.7.16_1513, released 18 May 2018
{: #1716_1513}

<table summary="Changes that were made since version 1.7.16_1512">
<caption>Changes since version 1.7.16_1512</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Fix to address a bug that occurred if you used the block storage plug-in.</td>
</tr>
</tbody>
</table>

### Changelog for worker node fix pack 1.7.16_1512, released 16 May 2018
{: #1716_1512}

<table summary="Changes that were made since version 1.7.16_1511">
<caption>Changes since version 1.7.16_1511</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>The data that you store in the <code>kubelet</code> root directory is now saved on the larger, secondary disk of your worker node machine.</td>
</tr>
</tbody>
</table>

### Changelog for 1.7.16_1511, released 19 April 2018
{: #1716_1511}

<table summary="Changes that were made since version 1.7.4_1509">
<caption>Changes since version 1.7.4_1509</caption>
<thead>
<tr>
<th>Component</th>
<th>Previous</th>
<th>Current</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16    </td>
<td><p>See the <a href="https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16">Kubernetes release notes![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16</a> <img src="../icons/launch-glyph.svg" alt="External link icon">. This release addresses <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101">CVE-2017-1002101</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> and <a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102">CVE-2017-1002102</a> <img src="../icons/launch-glyph.svg" alt="External link icon"> vulnerabilities.</p><p>Now <code>secret</code>, <code>configMap</code>, <code>downwardAPI</code>, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly.</p></td>
</tr>
<td>{{site.data.keyword.cloud_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td><code>NodePort</code> and <code>LoadBalancer</code> services now support <a href="/docs/containers?topic=containers-loadbalancer#lb_source_ip">preserving the client source IP</a> by setting <code>service.spec.externalTrafficPolicy</code> to <code>Local</code>.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Fix <a href="/docs/containers?topic=containers-edge#edge">edge node</a> toleration setup for older clusters.</td>
</tr>
</tbody>
</table>






