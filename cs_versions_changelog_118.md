---

copyright:
 years: 2014, 2024
lastupdated: "2024-03-15"


keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Version 1.18 change log 
{: #118_changelog}


Version 1.18 is unsupported. You can review the following archive of 1.18 change logs.
{: shortdesc}

## Change log for worker node fix pack 1.18.20_1566, released 27 September 2021
{: #11820_1566}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1566`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Disk identification | N/A | N/A | Enhanced the disk identification logic to handle the case of 2+ partitions. |
| HA proxy | 9c98dc5 | 07f1e9 | Updated image with fixes for [CVE-2021-22922](https://nvd.nist.gov/vuln/detail/CVE-2021-22922){: external}, [CVE-2021-22923](https://nvd.nist.gov/vuln/detail/CVE-2021-22923){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external}, [CVE-2021-36222](https://nvd.nist.gov/vuln/detail/CVE-2021-36222){: external}, and [CVE-2021-37750](https://nvd.nist.gov/vuln/detail/CVE-2021-37750){: external}. |
| Ubuntu 18.04 packages | 4.15.0-156 | 4.15.0-158 | Updated worker node images and kernel with package updates [CVE-2021-22946](https://nvd.nist.gov/vuln/detail/CVE-2021-22946){: external}, [CVE-2021-22947](https://nvd.nist.gov/vuln/detail/CVE-2021-22947){: external}, [CVE-2021-33560](https://nvd.nist.gov/vuln/detail/CVE-2021-33560){: external}, [CVE-2021-3709](https://nvd.nist.gov/vuln/detail/CVE-2021-3709){: external}, [CVE-2021-3710](https://nvd.nist.gov/vuln/detail/CVE-2021-3710){: external}, [CVE-2021-40330](https://nvd.nist.gov/vuln/detail/CVE-2021-40330){: external}, [CVE-2021-40528](https://nvd.nist.gov/vuln/detail/CVE-2021-40528){: external}, and [CVE-2021-41072](https://nvd.nist.gov/vuln/detail/CVE-2021-41072){: external}. | 
{: caption="Changes since version 1.18.20_1564" caption-side="bottom"}

## Change log for master fix pack 1.18.20_1565, released 28 September 2021
{: #11820_1565}

The following table shows the changes that are in the master fix pack patch update `1.18.20_1565`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Gateway-enabled cluster controller | 1444 | 1510 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| GPU device plug-in and installer | a9461a8 | eb817b2 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 945df65 | e3cb629 | Updated to use `Go` version `1.16.7`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 398 | 400 | Updated to use `Go` version `1.16.7`. Updated universal base image (UBI) to the latest `8.4-208` version to resolve CVEs. |
| Kubernetes API server auditing configuration | N/A | N/A| Updated to support `verbose` [Kubernetes API server auditing](/docs/containers?topic=containers-health-audit#audit-api-server). |
| Kubernetes NodeLocal DNS cache | N/A | N/A | Increased memory resource requests from `5Mi` to `8Mi` to better align with normal resource utilization. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1510 | 1550 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
| Operator Lifecycle Manager | 0.14.1-IKS-11 | 0.14.1-IKS-13 | Updated image for [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711){: external} and [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712){: external}. |
{: caption="Changes since version 1.18.20_1562" caption-side="bottom"}

## Change log for worker node fix pack 1.18.20_1564, released 13 September 2021
{: #11820_1564}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1564`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-154 | 4.15.0-156 | Updated worker node images and kernel with package updates for [CVE-2021-3653](https://nvd.nist.gov/vuln/detail/CVE-2021-3653){: external}, [CVE-2021-3656](https://nvd.nist.gov/vuln/detail/CVE-2021-3656){: external}, [CVE-2021-38185](https://nvd.nist.gov/vuln/detail/CVE-2021-38185){: external}, [CVE-2021-40153](https://nvd.nist.gov/vuln/detail/CVE-2021-40153){: external}. |
{: caption="Changes since version 1.18.20_1563" caption-side="bottom"}

## Change log for worker node fix pack 1.18.20_1563, released 30 August 2021
{: #11820_1563}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1563`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-153 | 4.15.0-154 | Updated worker node images and kernel with package updates for [CVE-2021-3711](https://nvd.nist.gov/vuln/detail/CVE-2021-3711){: external} and [CVE-2021-3712](https://nvd.nist.gov/vuln/detail/CVE-2021-3712){: external}. |
{: caption="Changes since version 1.18.20_1561" caption-side="bottom"}

## Change log for master fix pack 1.18.20_1562, released 25 August 2021
{: #11820_1562}

The following table shows the changes that are in the master fix pack patch update `1.18.20_1562`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.2.14 | v1.2.15 | Updated to use `Go` version `1.15.15`. Updated universal base image (UBI) to the latest `8.4` version to resolve CVEs. |
| Gateway-enabled cluster controller | 1348 | 1444 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
| GPU device plug-in and installer | 82ee77b | a9461a8 | Updated to use `Go` version `1.16.6`. |
| IBM Calico extension | 747 | 763 | Updated to use `Go` version `1.16.6`. Updated universal base image (UBI) to the latest `8.4-205` version to resolve CVEs. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 395 | 398 | Updated to use `Go` version `1.16.6`. Updated image for [CVE-2021-33910](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-33910){: external}. |
| Key Management Service provider | v2.3.6 | v2.3.7 | Updated to use `Go` version `1.15.15`. Updated UBI to the latest `8.4` version to resolve CVEs. |
| Kubernetes Dashboard metrics scraper | v1.0.6 | v1.0.7 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.7){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1328 | 1510 | Updated image for [CVE-2020-27780](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27780){: external}. |
| Operator Lifecycle Manager | 0.14.1-IKS-8 | 0.14.1-IKS-11 | Updated image for [CVE-2021-36159](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-36159){: external}. |
{: caption="Changes since version 1.18.20_1559" caption-side="bottom"}

## Change log for worker node fix pack 1.18.20_1561, released 16 August 2021
{: #11820_1561}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1561`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-151 | 4.15.0-153 | N/A |
| HA proxy | 68e6b3 | 9c98dc | Updated image with fixes for [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}. |
{: caption="Changes since version 1.18.20_1560" caption-side="bottom"}


## Change log for worker node fix pack 1.18.20_1560, released 02 August 2021
{: #11820_1560}

The following table shows the changes that are in the worker node fix pack patch update `1.18.20_1560`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-147 | 4.15.0-151 | Updated worker node images & Kernel with package updates: [CVE-2020-13529](https://nvd.nist.gov/vuln/detail/CVE-2020-13529){: external}, [CVE-2021-22898](https://nvd.nist.gov/vuln/detail/CVE-2021-22898){: external}, [CVE-2021-22924](https://nvd.nist.gov/vuln/detail/CVE-2021-22924){: external} [CVE-2021-22925](https://nvd.nist.gov/vuln/detail/CVE-2021-22925){: external}, [CVE-2021-33200](https://nvd.nist.gov/vuln/detail/CVE-2021-33200){: external}, [CVE-2021-33909](https://nvd.nist.gov/vuln/detail/CVE-2021-33909){: external}, and [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| HA proxy | aae810 | 68e6b3 | Updated image with fixes for [CVE-2021-33910](https://nvd.nist.gov/vuln/detail/CVE-2021-33910){: external}. |
| Registry endpoints | Added zonal public registry endpoints for clusters with both private and public service endpoints enabled. |
| Read only disk self healing | For VPC Gen2 workers. Added automation to recover from disks going read only. |
{: caption="Changes since version 1.18.29_1558" caption-side="bottom"}

## Change log for master fix pack 1.18.20_1559, released 27 July 2021
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
{: caption="Changes since version 1.18.20_1556" caption-side="bottom"}

## Change log for worker node fix pack 1.18.29_1558, released 19 July 2021
{: #11829_1558}

The following table shows the changes that are in the worker node fix pack `1.18.29_1558`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with kernel package updates. |
| Ubuntu 18.04 packages | N/A | N/A| Updated worker node images with kernel package updates. | 
{: caption="Changes since version 1.18.20_1557" caption-side="bottom"}

## Change log for worker node fix pack 1.18.20_1557, released 6 July 2021
{: #11820_1557}

The following table shows the changes that are in the worker node fix pack `1.18.20_1557`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 700dc6 | aae810 | Updated image with fixes for [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}, [CVE-2021-20271](https://nvd.nist.gov/vuln/detail/CVE-2021-20271){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external}, [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, and [CVE-2021-3541](https://nvd.nist.gov/vuln/detail/CVE-2021-3541){: external}. |
| Kubernetes | v1.18.19 | v1.18.20 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.20){: external}. |
| Ubuntu 18.04 packages | 4.15.0.144 | 4.15.0.147 | Updated worker node images with kernel package updates for [CVE-2021-23133](https://nvd.nist.gov/vuln/detail/CVE-2021-23133){: external}, [CVE-2021-3444](https://nvd.nist.gov/vuln/detail/CVE-2021-3444){: external}, and [CVE-2021-3600](https://nvd.nist.gov/vuln/detail/CVE-2021-3600){: external}. 
{: caption="Changes since version 1.18.19_1555" caption-side="bottom"}

## Change log for master fix pack 1.18.20_1556, released 28 June 2021
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
{: caption="Changes since version 1.18.19_1552" caption-side="bottom"}


## Change log for worker node fix pack 1.18.19_1555, released 22 June 2021
{: #11819_1555}

The following table shows the changes that are in the worker node fix pack `1.18.19_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | d3dc33 | Updated image with fixes for [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2017-14502](https://nvd.nist.gov/vuln/detail/CVE-2017-14502){: external}, [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external} and [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}.|
| {{site.data.keyword.registrylong_notm}} | N/A | N/A | Added private-only registry support for `ca.icr.io`, `br.icr.io` and `jp2.icr.io`. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2017-8779](https://nvd.nist.gov/vuln/detail/CVE-2017-8779){: external}, [CVE-2017-8872](https://nvd.nist.gov/vuln/detail/CVE-2017-8872){: external}, [CVE-2018-16869](https://nvd.nist.gov/vuln/detail/CVE-2018-16869){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2021-3516](https://nvd.nist.gov/vuln/detail/CVE-2021-3516){: external}, [CVE-2021-3517](https://nvd.nist.gov/vuln/detail/CVE-2021-3517){: external} [CVE-2021-3518](https://nvd.nist.gov/vuln/detail/CVE-2021-3518){: external}, [CVE-2021-3537](https://nvd.nist.gov/vuln/detail/CVE-2021-3537){: external}, [CVE-2021-3580](https://nvd.nist.gov/vuln/detail/CVE-2021-3580){: external}.|
{: caption="Changes since version 1.18.19_1554" caption-side="bottom"}

## Change log for worker node fix pack 1.18.19_1554, released 7 June 2021
{: #11819_1554}

The following table shows the changes that are in the worker node fix pack `1.18.19_1554`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 26c5cc | 700dc6 | Updated the image for [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}.|
| TCP `keepalive` optimization for VPC | N/A | N/A | Set the `net.ipv4.tcp_keepalive_time` setting to 180 seconds for compatibility with VPC gateways. |
| Ubuntu 18.04 packages | 4.15.0-143 | 4.15.0-144 | Updated worker node images with kernel package updates for [CVE-2021-25217](https://nvd.nist.gov/vuln/detail/CVE-2021-25217){: external}, [CVE-2021-31535](https://nvd.nist.gov/vuln/detail/CVE-2021-31535){: external}, [CVE-2021-32547](https://nvd.nist.gov/vuln/detail/CVE-2021-32547){: external}, [CVE-2021-32552](https://nvd.nist.gov/vuln/detail/CVE-2021-32552){: external}, [CVE-2021-32556](https://nvd.nist.gov/vuln/detail/CVE-2021-32556){: external}, [CVE-2021-32557](https://nvd.nist.gov/vuln/detail/CVE-2021-32557){: external}, [CVE-2021-3448](https://nvd.nist.gov/vuln/detail/CVE-2021-3448){: external}, and [CVE-2021-3520](https://nvd.nist.gov/vuln/detail/CVE-2021-3520){: external}.|
{: caption="Changes since version 1.18.19_1553" caption-side="bottom"}

## Change log for worker node fix pack 1.18.19_1553, released 24 May 2021
{: #11819_1553}

The following table shows the changes that are in the worker node fix pack `1.18.19_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | e0fa2f | 26c5cc | Updated image with fixes for [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}, [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2021-23336](https://nvd.nist.gov/vuln/detail/CVE-2021-23336){: external}, [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}, [CVE-2019-3842](https://nvd.nist.gov/vuln/detail/CVE-2019-3842){: external}, [CVE-2020-13776](https://nvd.nist.gov/vuln/detail/CVE-2020-13776){: external}, [CVE-2019-18276](https://nvd.nist.gov/vuln/detail/CVE-2019-18276){: external}, [CVE-2020-24977](https://nvd.nist.gov/vuln/detail/CVE-2020-24977){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-15358](https://nvd.nist.gov/vuln/detail/CVE-2020-15358){: external}, [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2020-13543](https://nvd.nist.gov/vuln/detail/CVE-2020-13543){: external}, [CVE-2020-13584](https://nvd.nist.gov/vuln/detail/CVE-2020-13584){: external}, [CVE-2020-9948](https://nvd.nist.gov/vuln/detail/CVE-2020-9948){: external}, [CVE-2020-9951](https://nvd.nist.gov/vuln/detail/CVE-2020-9951){: external}, [CVE-2020-9983](https://nvd.nist.gov/vuln/detail/CVE-2020-9983){: external}, [CVE-2020-8231](https://nvd.nist.gov/vuln/detail/CVE-2020-8231){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}, [CVE-2020-24330](https://nvd.nist.gov/vuln/detail/CVE-2020-24330){: external}, [CVE-2020-24331](https://nvd.nist.gov/vuln/detail/CVE-2020-24331){: external}, [CVE-2020-24332](https://nvd.nist.gov/vuln/detail/CVE-2020-24332){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, [CVE-2019-2708](https://nvd.nist.gov/vuln/detail/CVE-2019-2708){: external}, [CVE-2016-10228](https://nvd.nist.gov/vuln/detail/CVE-2016-10228){: external}, [CVE-2019-25013](https://nvd.nist.gov/vuln/detail/CVE-2019-25013){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-27618](https://nvd.nist.gov/vuln/detail/CVE-2020-27618){: external}, [CVE-2021-3326](https://nvd.nist.gov/vuln/detail/CVE-2021-3326){: external}, and [CVE-2020-8927](https://nvd.nist.gov/vuln/detail/CVE-2020-8927){: external}. |
| Kubernetes | v1.18.18 | v1.18.19 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.19){: external}. |
| Ubuntu 18.04 packages | 4.15.0-142 | 4.15.0-143 | Updated worker node images with kernel package updates for [CVE-2021-28688](https://nvd.nist.gov/vuln/detail/CVE-2021-28688){: external}, [CVE-2021-20292](https://nvd.nist.gov/vuln/detail/CVE-2021-20292){: external}, [CVE-2021-29264](https://nvd.nist.gov/vuln/detail/CVE-2021-29264){: external}, [CVE-2021-29265](https://nvd.nist.gov/vuln/detail/CVE-2021-29265){: external}, and [CVE-2021-29650](https://nvd.nist.gov/vuln/detail/CVE-2021-29650){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2009-5155](https://nvd.nist.gov/vuln/detail/CVE-2009-5155){: external} and [CVE-2020-6096](https://nvd.nist.gov/vuln/detail/CVE-2020-6096){: external}.|
{: caption="Changes since version 1.18.18_1551" caption-side="bottom"}

## Change log for master fix pack 1.18.19_1552, released 24 May 2021
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
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 390 | 392 | Improved the prerequisite validation logic for provisioning persistent volume claims (PVCs). Updated image to implement additional IBM security controls and for [CVE-2021-20305](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20305){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | b6a694b | 63cd064 | Updated image to implement additional IBM security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external}. |
| Key Management Service provider | v2.3.3 | v2.3.4 | Updated image to implement additional IBM security controls and for [CVE-2020-28483](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28483){: external} and [CVE-2020-26160](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26160){: external}. |
| Kubernetes | v1.18.18 | v1.18.19 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.19){: external}. The update resolves CVE-2020-8562 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457271){: external}) and CVE-2021-25737 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6457273){: external}). |
| Kubernetes add-on resizer | 1.8.11 | 1.8.12 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.12){: external}. |
| Kubernetes Metrics Server | v0.3.7 | v0.4.4 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.4.4){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1274 | 1328 | Updated to use `Go` version 1.15.11. Updated image to implement additional IBM security controls and for [CVE-2021-28831](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28831){: external}, [CVE-2021-30139](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-30139){: external}, [CVE-2021-3449](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3449){: external} and [CVE-2021-3450](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3450){: external}. |
| Portieris admission controller | v0.10.1 | v0.10.2 | See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.10.2){: external}. |
{: caption="Changes since version 1.18.18_1549" caption-side="bottom"}

## Change log for worker node fix pack 1.18.18_1551, released 10 May 2021
{: #11818_1551}

The following table shows the changes that are in the worker node fix pack `1.18.18_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}. |
| Ubuntu 16.04 packages |N/A | N/A | Updated worker node images with package updates for [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2021-25214](https://nvd.nist.gov/vuln/detail/CVE-2021-25214){: external}, [CVE-2021-25215](https://nvd.nist.gov/vuln/detail/CVE-2021-25215){: external}, and [CVE-2021-25216](https://nvd.nist.gov/vuln/detail/CVE-2021-25216){: external}.|
{: caption="Changes since version 1.18.18_1550" caption-side="bottom"}

## Change log for master fix pack 1.18.18_1549, released 27 April 2021
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
{: caption="Changes since version 1.18.17_1546" caption-side="bottom"}

## Change log for worker node fix pack 1.18.18_1550, released 26 April 2021
{: #11818_1550}

The following table shows the changes that are in the worker node fix pack `1.18.18_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | a3b1ff | e0fa2f | The update addresses [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Added resiliency to `systemd` units to prevent failures situations where the worker nodes are overused.  \n Updated worker node images with kernel and package updates for [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}, and [CVE-2021-3348](https://nvd.nist.gov/vuln/detail/CVE-2021-3348){: external}. |
| Ubuntu 16.04 packages |4.4.0-206 | 4.4.0-210 | Updated worker node images with kernel and package updates for [[CVE-2015-1350](https://nvd.nist.gov/vuln/detail/CVE-2015-1350){: external}, [CVE-2017-15107](https://nvd.nist.gov/vuln/detail/CVE-2017-15107){: external}, [CVE-2017-5967](https://nvd.nist.gov/vuln/detail/CVE-2017-5967){: external}, [CVE-2018-13095](https://nvd.nist.gov/vuln/detail/CVE-2018-13095){: external}, [CVE-2018-5953](https://nvd.nist.gov/vuln/detail/CVE-2018-5953){: external}, [CVE-2019-14513](https://nvd.nist.gov/vuln/detail/CVE-2019-14513){: external}, [CVE-2019-16231](https://nvd.nist.gov/vuln/detail/CVE-2019-16231){: external}, [CVE-2019-16232](https://nvd.nist.gov/vuln/detail/CVE-2019-16232){: external}, [CVE-2019-19061](https://nvd.nist.gov/vuln/detail/CVE-2019-19061){: external}, [CVE-2021-20305](https://nvd.nist.gov/vuln/detail/CVE-2021-20305){: external}, and [CVE-2021-29154](https://nvd.nist.gov/vuln/detail/CVE-2021-29154){: external}.|
{: caption="Changes since version 1.18.17_1548" caption-side="bottom"}

## Change log for worker node fix pack 1.18.17_1548, released 12 April 2021
{: #11817_1548}

The following table shows the changes that are in the worker node fix pack `1.18.17_1548`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 9b2dca | a3b1ff | The update addresses [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external} and [CVE-2021-3450](https://nvd.nist.gov/vuln/detail/CVE-2021-3450){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2021-22876](https://nvd.nist.gov/vuln/detail/CVE-2021-22876){: external}.|
{: caption="Changes since version 1.18.17_1547" caption-side="bottom"}

## Change log for master fix pack 1.18.17_1546, released 30 March 2021
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
{: caption="Changes since version 1.18.16_1544" caption-side="bottom"}

## Change log for worker node fix pack 1.18.17_1547, released 29 March 2021
{: #11817_1547}

The following table shows the changes that are in the worker node fix pack `1.18.17_1547`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-136-generic | 4.15.0-140-generic | Updated worker node images with kernel and package updates for [CVE-2020-27170](https://nvd.nist.gov/vuln/detail/CVE-2020-27170){: external}, [CVE-2020-27171](https://nvd.nist.gov/vuln/detail/CVE-2020-27171){: external}, [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}, and [CVE-2021-3449](https://nvd.nist.gov/vuln/detail/CVE-2021-3449){: external}. |
| Ubuntu 16.04 packages | 4.4.0-203-generic | 4.4.0-206-generic | Updated worker node images with kernel and package updates for [CVE-2021-27363](https://nvd.nist.gov/vuln/detail/CVE-2021-27363){: external}, [CVE-2021-27365](https://nvd.nist.gov/vuln/detail/CVE-2021-27365){: external}, and [CVE-2021-28153](https://nvd.nist.gov/vuln/detail/CVE-2021-28153){: external}.|
{: caption="Changes since version 1.18.16_1545" caption-side="bottom"}

## Change log for worker node fix pack 1.18.16_1545, released 12 March 2021
{: #11816_1545}

The following table shows the changes that are in the worker node fix pack `1.18.16_1545`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.9 | 1.3.10 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.10){: external}. The update resolves CVE-2021-21334 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6433475){: external}). |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-24031](https://nvd.nist.gov/vuln/detail/CVE-2021-24031){: external}, [CVE-2021-24032](https://nvd.nist.gov/vuln/detail/CVE-2021-24032){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, and [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for{: external}, [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300){: external}, [CVE-2021-27218](https://nvd.nist.gov/vuln/detail/CVE-2021-27218){: external}, [CVE-2021-27219](https://nvd.nist.gov/vuln/detail/CVE-2021-27219){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: caption="Changes since version 1.18.16_1544" caption-side="bottom"}

## Change log for worker node fix pack 1.18.16_1544, released 1 March 2021
{: #11816_1544}

The following table shows the changes that are in the worker node fix pack `1.18.16_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.15 | v1.18.16 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.16){: external}. |
| Ubuntu 18.04 packages | 4.15.0-135-generic | 4.15.0-136-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
| Ubuntu 16.04 packages | 4.4.0-201-generic | 4.4.0-203-generic | Updated worker node image with package updates for [CVE-2020-27619](https://nvd.nist.gov/vuln/detail/CVE-2020-27619){: external}, [CVE-2020-29372](https://nvd.nist.gov/vuln/detail/CVE-2020-29372){: external}, [CVE-2020-29374](https://nvd.nist.gov/vuln/detail/CVE-2020-29374){: external}, [CVE-2020-8625](https://nvd.nist.gov/vuln/detail/CVE-2020-8625){: external}, [CVE-2021-23840](https://nvd.nist.gov/vuln/detail/CVE-2021-23840){: external}, [CVE-2021-23841](https://nvd.nist.gov/vuln/detail/CVE-2021-23841){: external}, [CVE-2021-26937](https://nvd.nist.gov/vuln/detail/CVE-2021-26937){: external}, [CVE-2021-27212](https://nvd.nist.gov/vuln/detail/CVE-2021-27212){: external}, and [CVE-2021-3177](https://nvd.nist.gov/vuln/detail/CVE-2021-3177){: external}. |
{: caption="Changes since version 1.18.15_1541" caption-side="bottom"}

## Change log for master fix pack 1.18.16_1544, released 27 February 2021
{: #11816_1544_master}

The following table shows the changes that are in the master fix pack patch update `1.18.16_1543`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1165 | 1274 | Fixed a bug that might cause version 2.0 network load balancers (NLBs) to crash and restart on load balancer updates. |
{: caption="Changes since version 1.18.16_1543" caption-side="bottom"}

## Change log for master fix pack 1.18.16_1543, released 22 February 2021
{: #11816_1543}

The following table shows the changes that are in the master fix pack patch update `1.18.16_1543`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.13.4 | v3.13.5 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. |
| Cluster health image | v1.1.16 | v1.1.18 | Updated to use `Go` version 1.15.7. Updated image to implement additional IBM security controls. |
| Gateway-enabled cluster controller | 1195 | 1232 | Updated to use `Go` version 1.15.7. |
| IBM Calico extension | 567 | 618 | Updated to use `Go` version 1.15.7. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.15-3 | v1.18.16-2 | Updated to support the Kubernetes 1.18.16 release and to use `calicoctl` version 3.13.5. Updated image to implement additional IBM security controls and for [DLA-2509-1](https://lists.debian.org/debian-lts-announce/2020/12/msg00039.html){: external}. Updated version 1.0 and 2.0 network load balancers (NLBs) to run as a non-root user by default, with privileged escalation as needed. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 385 | 388 | Improved the retry logic for provisioning persistent volume claims (PVCs). |
| {{site.data.keyword.cloud_notm}} RBAC Operator | f859228 | 86de2b7 | Updated to use `Go` version 1.15.7. |
| Key Management Service provider | v2.2.3 | v2.2.5 | Updated to use `Go` version 1.15.7. Updated image to implement additional IBM security controls. |
| Kubernetes | v1.18.15 | v1.18.16 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.16){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1078 | 1165 | Updated to run as a non-root user by default, with privileged escalation as needed. Updated to use `Go` version 1.15.7. |
| Operator Lifecycle Manager | 0.14.1-IKS-2 | 0.14.1-IKS-4 | Updated image for [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839){: external}, [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840){: external}, and [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841){: external}. |
{: caption="Changes since version 1.18.15_1538" caption-side="bottom"}

## Change log for worker node fix pack 1.18.15_1541, released 15 February 2021
{: #11815_1541}

The following table shows the changes that are in the worker node fix pack `1.18.15_1541`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-36221](https://nvd.nist.gov/vuln/detail/CVE-2020-36221){: external}, [CVE-2020-36222](https://nvd.nist.gov/vuln/detail/CVE-2020-36222){: external}, [CVE-2020-36223](https://nvd.nist.gov/vuln/detail/CVE-2020-36223){: external}, [CVE-2020-36224](https://nvd.nist.gov/vuln/detail/CVE-2020-36224){: external}, [CVE-2020-36225](https://nvd.nist.gov/vuln/detail/CVE-2020-36225){: external}, [CVE-2020-36226](https://nvd.nist.gov/vuln/detail/CVE-2020-36226){: external}, [CVE-2020-36227](https://nvd.nist.gov/vuln/detail/CVE-2020-36227){: external}, [CVE-2020-36228](https://nvd.nist.gov/vuln/detail/CVE-2020-36228){: external}, [CVE-2020-36229](https://nvd.nist.gov/vuln/detail/CVE-2020-36229){: external}, [CVE-2020-36230](https://nvd.nist.gov/vuln/detail/CVE-2020-36230){: external}, [CVE-2021-25682](https://nvd.nist.gov/vuln/detail/CVE-2021-25682){: external}, [CVE-2021-25683](https://nvd.nist.gov/vuln/detail/CVE-2021-25683){: external}, and [CVE-2021-25684](https://nvd.nist.gov/vuln/detail/CVE-2021-25684){: external}. |
{: caption="Changes since version 1.18.15_1540" caption-side="bottom"}

## Change log for worker node fix pack 1.18.15_1540, released 3 February 2021
{: #11815_1540}

The following table shows the changes that are in the worker node fix pack `1.18.15_1540`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Metadata updates | N/A | N/A | Updated the worker node version fix pack metadata for internal documentation purposes. |
{: caption="Changes since version 1.18.15_1539" caption-side="bottom"}

## Change log for worker node fix pack 1.18.15_1539, released 1 February 2021
{: #11815_1539}

The following table shows the changes that are in the worker node fix pack `1.18.15_1539`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | 4.4.0-200-generic | 4.4.0-201-generic | Updated worker node image with kernel and package updates for [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
| Ubuntu 18.04 packages | 4.15.0-132-generic | 4.15.0-135-generic | Updated worker node image with kernel and package updates for [CVE-2019-12761](https://nvd.nist.gov/vuln/detail/CVE-2019-12761){: external}, [CVE-2019-14834](https://nvd.nist.gov/vuln/detail/CVE-2019-14834){: external}, [CVE-2020-25681](https://nvd.nist.gov/vuln/detail/CVE-2020-25681){: external}, [CVE-2020-25682](https://nvd.nist.gov/vuln/detail/CVE-2020-25682){: external}, [CVE-2020-25683](https://nvd.nist.gov/vuln/detail/CVE-2020-25683){: external}, [CVE-2020-25684](https://nvd.nist.gov/vuln/detail/CVE-2020-25684){: external}, [CVE-2020-25685](https://nvd.nist.gov/vuln/detail/CVE-2020-25685){: external}, [CVE-2020-25686](https://nvd.nist.gov/vuln/detail/CVE-2020-25686){: external}, [CVE-2020-25687](https://nvd.nist.gov/vuln/detail/CVE-2020-25687){: external}, [CVE-2020-27777](https://nvd.nist.gov/vuln/detail/CVE-2020-27777){: external}, [CVE-2021-23239](https://nvd.nist.gov/vuln/detail/CVE-2021-23239){: external}, and [CVE-2021-3156](https://nvd.nist.gov/vuln/detail/CVE-2021-3156){: external}. |
{: caption="Changes since version 1.18.15_1538" caption-side="bottom"}

## Change log for master fix pack 1.18.15_1538, released 19 January 2021
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
| Key Management Service provider | v2.2.2 | v2.2.3 | Fixed bug to ignore conflict errors during KMS secret re-encryption. Updated to use `Go` version 1.15.5. Updated image to implement additional IBM security controls and for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Kubernetes | v1.18.14 | v1.18.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.15){: external}. Updated to implement additional IBM security controls. |
| Kubernetes Dashboard | v2.0.4 | v2.0.5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.5){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.4 | v1.0.6 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1004 | 1078 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external}. |
| Operator Lifecycle Manager Catalog | v1.6.1 | v1.15.3 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.15.3){: external}. |
{: caption="Changes since version 1.18.14_1537" caption-side="bottom"}

## Change log for worker node fix pack 1.18.15_1538, released 18 January 2021
{: #11815_1538}

The following table shows the changes that are in the worker node fix pack `1.18.15_1538`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.13 | v1.18.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.15){: external}. |
| Ubuntu 16.04 packages | 4.4.0-197-generic | 4.4.0-200-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external} external}, and [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external} external}. |
| Ubuntu 18.04 packages | 4.15.0-128-generic | 4.15.0-132-generic | Updated worker node image with kernel and package updates for{: external}, [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2021-1052](https://nvd.nist.gov/vuln/detail/CVE-2021-1052){: external}, [CVE-2021-1053](https://nvd.nist.gov/vuln/detail/CVE-2021-1053){: external}, and [CVE-2019-19770](https://nvd.nist.gov/vuln/detail/CVE-2019-19770){: external}. |
{: caption="Changes since version 1.18.13_1536" caption-side="bottom"}

## Change log for master fix pack 1.18.14_1537, released 6 January 2021
{: #11814_1537}

The following table shows the changes that are in the master fix pack patch update `1.18.14_1537`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Calico extension | 544 | 556 | Updated image to include the `ip` command. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.18.13-1 | v1.18.14-1 | Updated to support the Kubernetes 1.18.14 release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | N/A | N/A | Updated to run with a privileged security context. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | c148a8a | f859228 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-24659](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-24659){: external}. |
| Key Management Service provider | v2.0.7 | v2.2.2 | Updated the key management service (KMS) provider support as follows. \n - Updated to use `Go` version 1.15.2. \n - Added support for [service-to-service authentication](/docs/account?topic=account-serviceauth). \n - Updated to use the KMS provider secret to identify when a [Key Protect](/docs/containers?topic=containers-encryption) key is enabled and disabled so that encryption and decryption requests are updated accordingly. |
| Kubernetes | v1.18.13 | v1.18.14 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.14){: external}. |
| Kubernetes `NodeLocal` DNS cache | N/A | N/A | Updated to run with a least privileged security context. |
| Operator Lifecycle Manager | 0.14.1-IKS-1 | 0.14.1-IKS-2 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. |
{: caption="Changes since version 1.18.13_1535" caption-side="bottom"}

## Change log for worker node fix pack 1.18.13_1536, released 21 December 2020
{: #11813_1536}

The following table shows the changes that are in the worker node fix pack `1.18.13_1536`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ubuntu 18.04 packages | 4.15.0-126-generic | 4.15.0-128-generic | Updated worker node image with kernel and package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Kubernetes | v1.18.12 | v1.18.13 | See the [Kubernetes change logs.](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.13){: external} |
| Ephemeral storage reservations | N/A | N/A | Reserve local ephemeral storage to prevent workload evictions. |
| HA proxy | db4e6d | 9b2dca | Image update for [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external} and [CVE-2020-24659](https://nvd.nist.gov/vuln/detail/CVE-2020-24659){: external}. |
{: caption="Changes since version 1.18.13_1535" caption-side="bottom"}

## Change log for master fix pack 1.18.13_1535, released 14 December 2020
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
{: caption="Changes since version 1.18.12_1533" caption-side="bottom"}

## Change log for worker node fix pack 1.18.12_1535, released 11 December 2020
{: #11812_1535}

The following table shows the changes that are in the worker node fix pack `1.18.12_1535`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 bare metal kernel | 4.15.0-126-generic | 4.15.0-123-generic | **Bare metal worker nodes**: Reverted the kernel version for bare metal worker nodes while Canonical addresses issues with the previous version that prevented worker nodes from being reloaded or updated. |
{: caption="Changes since version 1.18.12_1534" caption-side="bottom"}

## Change log for worker node fix pack 1.18.12_1534, released 7 December 2020
{: #11812_1534}

The following table shows the changes that are in the worker node fix pack `1.18.12_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.4 | 1.3.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.9){: external}. The update resolves CVE-2020–15257 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6387878){: external}). |
| HA proxy | 1.8.26-384f42 | db4e6d | Added provenance labels for source tracking. |
| Ubuntu 18.04 packages | 4.15.0-123-generic | 4.15.0-126-generic | Updated worker node image with kernel and package updates for [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external} and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
| Ubuntu 16.04 packages | 4.4.0-194-generic | 4.4.0-197-generic | Updated worker node image with kernel and package updates for [CVE-2020-0427](https://nvd.nist.gov/vuln/detail/CVE-2020-0427){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external}, [CVE-2020-25645](https://nvd.nist.gov/vuln/detail/CVE-2020-25645){: external}, and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
{: caption="Changes since version 1.18.12_1533" caption-side="bottom"}

## Change log for worker node fix pack 1.18.12_1533, released 23 November 2020
{: #11812_1533_worker}

The following table shows the changes that are in the worker node fix pack `1.18.12_1533`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.10 | v1.18.12 | See the [Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md#v11812){: external}.|
| Ubuntu 18.04 packages | 4.15.0-122-generic | 4.15.0-123-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
| Ubuntu 16.04 packages | 4.4.0-193-generic | 4.4.0-194-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
{: caption="Changes since version 1.18.10_1532" caption-side="bottom"}

## Change log for master fix pack 1.18.12_1533, released 16 November 2020
{: #11812_1533}

The following table shows the changes that are in the master fix pack patch update `1.18.12_1533`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.1.12 | v1.1.13 | Updated image for [DLA-2424-1](https://lists.debian.org/debian-lts-announce/2020/10/msg00037.html){: external}. |
| GPU device plug-in and installer | 0c07674 | b966c41 | Updated image for [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2020-8177](https://nvd.nist.gov/vuln/detail/CVE-2020-8177){: external}, [CVE-2019-14889](https://nvd.nist.gov/vuln/detail/CVE-2019-14889){: external}, [CVE-2020-1730](https://nvd.nist.gov/vuln/detail/CVE-2020-1730){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}, [CVE-2019-5018](https://nvd.nist.gov/vuln/detail/CVE-2019-5018){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, [CVE-2020-13631](https://nvd.nist.gov/vuln/detail/CVE-2020-13631){: external}, [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}, [CVE-2020-6405](https://nvd.nist.gov/vuln/detail/CVE-2020-6405){: external}, [CVE-2020-9327](https://nvd.nist.gov/vuln/detail/CVE-2020-9327){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-19221](https://nvd.nist.gov/vuln/detail/CVE-2019-19221){: external}, [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}, [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-20454](https://nvd.nist.gov/vuln/detail/CVE-2019-20454){: external}, [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2019-20388](https://nvd.nist.gov/vuln/detail/CVE-2019-20388){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2018-20843](https://nvd.nist.gov/vuln/detail/CVE-2018-20843){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, and [CVE-2019-20387](https://nvd.nist.gov/vuln/detail/CVE-2019-20387){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager |v1.18.10-1 | v1.18.12-1 | Updated to support the Kubernetes 1.18.12 release. Updated image for [DLA-2424-1](https://lists.debian.org/debian-lts-announce/2020/10/msg00037.html){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 378 | 379 | Updated to use the universal base image (UBI) and to use `Go` version 1.15.2. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 31c794a | 197bc70 | Updated image for [CVE-2019-20454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20454){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}, [CVE-2019-20807](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20807){: external}, [CVE-2019-16935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16935){: external}, [CVE-2019-20907](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20907){: external}, [CVE-2020-14422](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14422){: external}, [CVE-2020-8492](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8492){: external}, [CVE-2019-15165](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15165){: external}, [CVE-2019-16168](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16168){: external}, [CVE-2019-20218](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20218){: external}, [CVE-2019-5018](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5018){: external}, [CVE-2020-13630](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13630){: external}, [CVE-2020-13631](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13631){: external}, [CVE-2020-13632](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-13632){: external}, [CVE-2020-6405](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6405){: external}, [CVE-2020-9327](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9327){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-13050](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13050){: external}, [CVE-2018-20843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20843){: external}, [CVE-2019-15903](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15903){: external}, [CVE-2019-14889](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14889){: external}, [CVE-2020-1730](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1730){: external}, [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}, [CVE-2020-14382](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14382){: external}, [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external}, [CVE-2019-19956](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19956){: external}, [CVE-2019-20388](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20388){: external}, [CVE-2020-7595](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7595){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-19906](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19906){: external}, [CVE-2019-20387](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20387){: external}, and [CVE-2019-19221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19221){: external}.  |
| Key Management Service provider | v2.0.4 | v2.0.5 | Updated image for [DLA-2424-1](https://lists.debian.org/debian-lts-announce/2020/10/msg00037.html){: external}. |
| Kubernetes | v1.18.10 | v1.18.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.12){: external}. |
{: caption="Changes since version 1.18.10_1531" caption-side="bottom"}

## Change log for worker node fix pack 1.18.10_1532, released 9 November 2020
{: #11810_1532}

The following table shows the changes that are in the worker node fix pack `1.18.10_1532`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with kernel and package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}, and [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}. |
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, and [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}.|
{: caption="Changes since version 1.18.10_1531" caption-side="bottom"}

## Change log for worker node fix pack 1.18.10_1531, released 26 October 2020
{: #11810_1531_worker}

The following table shows the changes that are in the worker node fix pack `1.18.10_15313`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.9 | v1.18.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.10){: external}. |
|Ubuntu 18.04 packages | 4.15.0-118-generic | 4.15.0-122-generic | Updated worker node images with kernel and package updates for [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external}, [CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2019-20916](https://nvd.nist.gov/vuln/detail/CVE-2019-20916){: external}, [CVE-2020-12351](https://nvd.nist.gov/vuln/detail/CVE-2020-12351){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, [CVE-2020-16120](https://nvd.nist.gov/vuln/detail/CVE-2020-16120){: external}, [CVE-2020-24490](https://nvd.nist.gov/vuln/detail/CVE-2020-24490){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
|Ubuntu 16.04 packages | 4.4.0-190-generic | 4.4.0-193-generic | Updated worker node images with kernel and package updates for [CVE-2017-17087](https://nvd.nist.gov/vuln/detail/CVE-2017-17087){: external}, [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external}, [CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
{: caption="Changes since version 1.18.9_1530" caption-side="bottom"}

## Change log for master fix pack 1.18.10_1531, released 26 October 2020
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
{: caption="Changes since version 1.18.9_1528" caption-side="bottom"}

## Change log for worker node fix pack 1.18.9_1530, released 12 October 2020
{: #1189_1530}

The following table shows the changes that are in the worker node fix pack `1.18.9_1530`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2019-8936](https://nvd.nist.gov/vuln/detail/CVE-2019-8936){: external}, [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}, and [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external}.|
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external} and [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}. |
{: caption="Changes since version 1.18.8_1529" caption-side="bottom"}

## Change log for worker node fix pack 1.18.9_1529, released 28 September 2020
{: #1189_1529}

The following table shows the changes that are in the worker node fix pack `1.18.9_1529`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.8    | v1.18.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.9){: external}. |
| Ubuntu 18.04 packages | 4.15.0-117-generic | 4.15.0-118-generic | Updated worker node image with   kernel and package updates for [CVE-2018-1000500](https://nvd.nist.gov/vuln/detail/CVE-2018-1000500){: external}, [CVE-2018-7738](https://nvd.nist.gov/vuln/detail/CVE-2018-7738){: external}, [CVE-2019-14855](https://nvd.nist.gov/vuln/detail/CVE-2019-14855){: external}, [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, [CVE-2020-10753](https://nvd.nist.gov/vuln/detail/CVE-2020-10753){: external}, [CVE-2020-12059](https://nvd.nist.gov/vuln/detail/CVE-2020-12059){: external}, [CVE-2020-12888](https://nvd.nist.gov/vuln/detail/CVE-2020-12888){: external}, [CVE-2020-1760](https://nvd.nist.gov/vuln/detail/CVE-2020-1760){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}.|
| Ubuntu 16.04 packages | 4.4.0-189-generic | 4.4.0-190-generic | Updated worker node image with kernel and package updates for [CVE-2019-20811](https://nvd.nist.gov/vuln/detail/CVE-2019-20811){: external}, [CVE-2019-9453](https://nvd.nist.gov/vuln/detail/CVE-2019-9453){: external}, [CVE-2020-0067](https://nvd.nist.gov/vuln/detail/CVE-2020-0067){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}. |
{: caption="Changes since version 1.18.8_1527" caption-side="bottom"}

## Change log for master fix pack 1.18.9_1528, released 21 September 2020
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
{: caption="Changes since version 1.18.8_1527" caption-side="bottom"}

## Change log for worker node fix pack 1.18.8_1527, released 14 September 2020
{: #1188_1527}

The following table shows the changes that are in the worker node fix pack `1.18.8_1527`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-384f42 | 1.8.26-561f1a | See the [HA proxy change log](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.|
| Ubuntu 18.04 packages | 4.15.0-112-generic | 4.15.0-117-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external}, [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}, and [CVE-2020-14386](https://nvd.nist.gov/vuln/detail/CVE-2020-14386){: external}. |
| Ubuntu 16.04 packages | 4.4.0-187-generic | 4.4.0-189-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external} and [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}. |
{: caption="Changes since version 1.18.8_1526" caption-side="bottom"}

## Change log for worker node fix pack 1.18.8_1526, released 31 August 2020
{: #1188_1526}

The following table shows the changes that are in the worker node fix pack `1.18.8_1526`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-12403](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12403){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}, and [CVE-2020-8624](https://nvd.nist.gov/vuln/detail/CVE-2020-8624){: external}. |
| Ubuntu 16.04 packages | 4.4.0-186-generic | 4.4.0-187-generic | Updated worker node image with kernel and package updates for [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, and [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}. |
{: caption="Changes since version 1.18.8_1525" caption-side="bottom"}

## Change log for master fix pack 1.18.8_1525, released 18 August 2020
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
{: caption="Changes since version 1.18.6_1523" caption-side="bottom"}

## Change log for worker node fix pack 1.18.8_1525, released 17 August 2020
{: #1188_1525}

The following table shows the changes that are in the worker node fix pack `1.18.8_1525`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.18.6 | v1.18.8 | See the [Kubernetes change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md#v1188){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-12400](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12400){: external}, [CVE-2020-12401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12401){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}, and [CVE-2020-6829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6829){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, and [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}. |
{: caption="Changes since version 1.18.6_1523" caption-side="bottom"}

## Change log for worker node fix pack 1.18.6_1523, released 3 August 2020
{: #1186_1523}

The following table shows the changes that are in the worker node fix pack `1.18.6_1523`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-111-generic | 4.15.0-112-generic | Updated worker node images with kernel and package updates for [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-10757](https://nvd.nist.gov/vuln/detail/CVE-2020-10757){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
| Ubuntu 16.04 packages | 4.4.0-185-generic | 4.4.0-186-generic | Updated worker node images with package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
{: caption="Changes since version 1.18.6_1520" caption-side="bottom"}

## Change log for master fix pack 1.18.6_1522, released 24 July 2020
{: #1186_1522}

The following table shows the changes that are in the master fix pack patch update `1.18.6_1522`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master operations | N/A | N/A | Fixed a problem that might cause pods to fail authentication to the Kubernetes API server after a cluster master operation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 375 | 376 | Updated to use `Go` version 1.13.8. |
{: caption="Changes since version 1.18.6_1521" caption-side="bottom"}

## Change log for master fix pack 1.18.6_1521, released 20 July 2020
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
{: caption="Changes since version 1.18.4_1518" caption-side="bottom"}

## Change log for worker node fix pack 1.18.6_1520, released 20 July 2020
{: #1186_1520}

The following table shows the changes that are in the worker node fix pack `1.18.6_1520`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 2.0.15-afe432 | 1.8.25-384f42 | See the [HA proxy change log](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Fixes a connection leak that happens when HA proxy is under high load. |
| Kubernetes | v1.18.4 | v1.18.6 | See the [Kubernetes change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md#v1186){: external}. The update resolves CVE-2020-8557 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249941){: external}). |
| Ubuntu 18.04 packages | 4.15.0-109-generic | 4.15.0-111-generic | Updated worker node images with kernel and package updates for [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-19591](https://nvd.nist.gov/vuln/detail/CVE-2018-19591){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-12402](https://nvd.nist.gov/vuln/detail/CVE-2020-12402){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
| Ubuntu 16.04 packages | 4.4.0-184-generic | 4.4.0-185-generic | Updated worker node images with package updates for [CVE-2017-12133](https://nvd.nist.gov/vuln/detail/CVE-2017-12133){: external}, [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}, [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-6485](https://nvd.nist.gov/vuln/detail/CVE-2018-6485){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
{: caption="Changes since version 1.18.4_1518" caption-side="bottom"}

## Change log for worker node fix pack 1.18.4_1518, released 6 July 2020
{: #1184_1518}

The following table shows the changes that are in the worker node fix pack `1.18.4_1518`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-30b675 | 2.0.15-afe432 | See the [HA proxy change log](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}. |
| Ubuntu 18.04 packages | 4.15.0-106-generic | 4.15.0-109-generic | Updated worker node images with kernel and package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-16089](https://nvd.nist.gov/vuln/detail/CVE-2019-16089){: external}, [CVE-2019-19036](https://nvd.nist.gov/vuln/detail/CVE-2019-19036){: external}, [CVE-2019-19039](https://nvd.nist.gov/vuln/detail/CVE-2019-19039){: external}, [CVE-2019-19318](https://nvd.nist.gov/vuln/detail/CVE-2019-19318){: external}, [CVE-2019-19642](https://nvd.nist.gov/vuln/detail/CVE-2019-19642){: external}, [CVE-2019-19813](https://nvd.nist.gov/vuln/detail/CVE-2019-19813){: external}, [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-19377](https://nvd.nist.gov/vuln/detail/CVE-2019-19377){: external}, and [CVE-2019-19816](https://nvd.nist.gov/vuln/detail/CVE-2019-19816){: external}. |
| Ubuntu 16.04 packages |N/A | N/A| Updated worker node images with package updates for [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external} and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}. |
| Worker node `drain` automation |N/A | N/A| Fixes a race condition that can cause worker node `drain` automation to fail. |
{: caption="Changes since version 1.18.4_1517" caption-side="bottom"}

## Change log for 1.18.4_1517, released 22 June 2020
{: #1184_1517}

The following table shows the changes that are in the master and worker node update `1.18.4_1517`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Calico | Master | v3.13.3 | v3.13.4 | See the [Calico release notes](https://docs.tigera.io/archive){: external}. The master update resolves CVE-2020-13597 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6226322){: external}). |
| Cluster health image | Master | v1.1.5 | v1.1.8 | Additional status information is included when an add-on health state is `critical`. Improved performance when handling cluster status updates. |
| Cluster master operations | Master | N/A | N/A | Cluster master operations such as `refresh` or `update` are now canceled if a broken [Kubernetes admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} is detected. |
| etcd | Master | v3.4.7 | v3.4.9 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.9){: external}. |
| GPU device plug-in and installer | Master | b9a418c | 2bcf8e4 | Updated image for [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | Master | v1.18.3-1 | v1.18.4-1 | Updated to support the Kubernetes 1.18.4 release. Updated the version 2.0 private network load balancers (NLBs) to manage Calico global network policies. Updated `calicoctl` version to 3.13.4. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | Master | 373 | 375 | Fixed a bug that might cause error handling to create additional persistent volumes. |
| {{site.data.keyword.cloud_notm}} RBAC operator | Master | N/A | 08ce50e | **New!**: Added a control plane operator to synchronize [{{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) service access roles](/docs/containers?topic=containers-iam-platform-access-roles) with Kubernetes role-based access control (RBAC) roles. |
| Kubernetes | Both | v1.18.3 | v1.18.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.4){: external}. The master update resolves CVE-2020-8558 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249905){: external}). |
| Kubernetes configuration | Master | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `apiextensions.k8s.io` API group and the `persistentvolumeclaims` and `persistentvolumes` resources. Additionally, the `http2-max-streams-per-connection` option is set to `1000` to mitigate network disruption impacts on the `kubelet` connection to the API server. |
| Kubernetes Dashboard | Master | v2.0.0 | v2.0.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.1){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 211 | 223 | Improved startup performance of version 2.0 private network load balancers (NLBs). |
| Ubuntu 18.04 packages | Worker | 4.15.0-101-generic | 4.15.0-106-generic | Updated worker node images with kernel and package updates for [CVE-2018-8740](https://nvd.nist.gov/vuln/detail/CVE-2018-8740){: external}, [CVE-2019-17023](https://nvd.nist.gov/vuln/detail/CVE-2019-17023){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-12399](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12399){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-179-generic | 4.4.0-184-generic | Updated worker node images with package and kernel updates for [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12769](https://nvd.nist.gov/vuln/detail/CVE-2020-12769){: external}, [CVE-2020-1749](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1749){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and[CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
{: caption="Changes since version 1.18.3_1515" caption-side="bottom"}

## Change log for worker node fix pack 1.18.3_1515, released 8 June 2020
{: #1183_1515}

The following table shows the changes that are in the worker node fix pack `1.18.3_1515`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1549](https://nvd.nist.gov/vuln/detail/CVE-2019-1549){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
{: caption="Changes since version 1.18.3_1514" caption-side="bottom"}

## Change log for 1.18.3_1514, released 26 May 2020
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
| Ubuntu 16.04 packages | Worker | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: caption="Changes since version 1.18.2_1512" caption-side="bottom"}

## Change log for 1.18.2_1512, released 11 May 2020
{: #1182_1512}

The following table shows the changes that are in patch update 1.18.2_1512. If you update your cluster from Kubernetes 1.17, review the [preparation actions](/docs/containers?topic=containers-cs_versions#k8s_version_archive).
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.12.1 | v3.13.3 | See the [Calico release notes](https://docs.tigera.io/archive/v3.13/release-notes/.){: external}. |
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
| Kubernetes NodeLocal DNS cache | 1.15.8 | 1.15.12 | \n - See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.12){: external}. \n - [NodeLocal DNS cache](/docs/containers?topic=containers-cluster_dns#dns_cache) is now generally available, but still disabled by default. \n - In Kubernetes 1.18, you might also use [zone-aware DNS](/docs/containers?topic=containers-cluster_dns#dns_zone_aware) instead of just NodeLocal DNS cache, to increase DNS performance and availability in a multizone cluster. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 177 | 207 | Improved application logging. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Pause container image | 3.1 | 3.2 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: caption="Changes since version 1.17.5_1523" caption-side="bottom"}
