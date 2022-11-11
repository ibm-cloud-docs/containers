---

copyright:
 years: 2014, 2022
lastupdated: "2022-11-11"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Version 1.13 changelog (unsupported 22 February 2020)
{: #113_changelog}

Version 1.13 is unsupported. You can review the following archive of 1.13 changelogs.
{: shortdesc}

## Change log for fix pack 1.13.12_1550, released 17 February 2020
{: #11312_1550}

The following table shows the changes that are in the master and worker node fix pack update `1.13.12_1550`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external} and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
{: caption="Changes since version 1.13.12_1549" caption-side="bottom"}

## Change log for worker node fix pack 1.13.12_1549, released 3 February 2020
{: #11312_1549}

The following table shows the changes that are in the worker node fix pack 1.13.12_1549.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}{: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: caption="Changes since version 1.13.12_1548" caption-side="bottom"}

## Change log for 1.13.12_1548, released 20 January 2020
{: #11312_1548}

The following table shows the changes that are in the master and worker node patch update 1.13.12_1548. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external} and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | - Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`. \n - Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot). \n - Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: caption="Changes since version 1.13.12_1547" caption-side="bottom"}

## Change log for worker node fix pack 1.13.12_1547, released 23 December 2019
{: #11312_1547}

The following table shows the changes that are in the worker node fix pack 1.13.12_1547.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: caption="Changes since version 1.13.12_1545" caption-side="bottom"}

### Change log for master fix pack 1.13.12_1546, released 17 December 2019
{: #11312_1546}

The following table shows the changes that are in the master fix pack 1.13.12_1546.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| {{site.data.keyword.filestorage_full_notm}} and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: caption="Changes since version 1.13.12_1545" caption-side="bottom"}

## Change log for worker node fix pack 1.13.12_1545, released 9 December 2019
{: #11312_1545_worker}

The following table shows the changes that are in the worker node fix pack 1.13.12_1545.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: caption="Changes since version 1.13.12_1544" caption-side="bottom"}

## Change log for worker node fix pack 1.13.12_1544, released 25 November 2019
{: #11312_1544_worker}

The following table shows the changes that are in the worker node fix pack 1.13.12_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}. |
{: caption="Changes since version 1.13.12_1541" caption-side="bottom"}

## Change log for master fix pack 1.13.12_1544, released 21 November 2019
{: #11312_1544}

The following table shows the changes that are in the master fix pack 1.13.12_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor    | 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
{: caption="Changes since version 1.13.12_1541" caption-side="bottom"}

## Change log for worker node fix pack 1.13.12_1541, released 11 November 2019
{: #11312_1541_worker}

The following table shows the changes that are in the worker node fix pack 1.13.12_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: caption="Changes since version 1.13.12_1540" caption-side="bottom"}

## Change log for worker node fix pack 1.13.12_1540, released 28 October 2019
{: #11312_1540}

The following table shows the changes that are in the worker node fix pack `1.13.12_1540`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |    v1.13.11 |    v1.13.12    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.12){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.13.12_1539" caption-side="bottom"}

## Change log for master fix pack 1.13.12_1539, released 22 October 2019
{: #11312_1539}

The following table shows the changes that are in the master fix pack `1.13.12_1539`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you don't need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.11-248 | v1.13.12-268 | Updated to support the Kubernetes 1.13.12 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |    v1.13.11 |    v1.13.12    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.12){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/1098759){: external}) and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.13.11_1538" caption-side="bottom"}

## Change log for worker node fix pack 1.13.11_1538, released 14 October 2019
{: #11311_1538_worker}

The following table shows the changes that are in the worker node fix pack 1.13.11_1538.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 packages and kernel | 4.4.0-164-generic | 4.4.0-165-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-0136](https://nvd.nist.gov/vuln/detail/CVE-2019-0136){: external}, [CVE-2018-20961](https://nvd.nist.gov/vuln/detail/CVE-2018-20961){: external}, [CVE-2019-11487](https://nvd.nist.gov/vuln/detail/CVE-2019-11487){: external}, [CVE-2016-10905](https://nvd.nist.gov/vuln/detail/CVE-2016-10905){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-64-generic | 4.15.0-65-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}. |
{: caption="Table 1. Changes since version 1.13.11_1537" caption-side="bottom"}


## Change log for 1.13.11_1537, released 1 October 2019
{: #11311_1537}

The following table shows the changes that are in the patch 1.13.11_1537.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Calico|v3.6.4|v3.6.5|See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.6/release-notes/){: external}. |
|Cluster master HA configuration|N/A|N/A|Updated configuration to improve performance of master update operations. |
|containerd|v1.2.9|v1.2.10|See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.10){: external}. Update resolves [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
|Default IBM file storage class|N/A|N/A|Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class. |
|{{site.data.keyword.cloud_notm}} Provider|v1.13.10-221|v1.13.11-248|Updated to support the Kubernetes 1.13.11 release. |
|Key Management Service provider|212|221|Improved Kubernetes [key management service provider](/docs/containers?topic=containers-encryption#keyprotect) caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated. |
|Kubernetes|v1.13.10|v1.13.11|See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.11){: external}. |
|Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider|148|153|Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node. |
|OpenVPN server|2.4.6-r3-IKS-115|2.4.6-r3-IKS-121|Updated images for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external} and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
|Kubernetes|v1.13.10|v1.13.11|See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.11){: external}. |
|Ubuntu 18.04 kernel and packages|4.15.0-62-generic|4.15.0-64-generic|Updated worker node images with kernel and package updates for [CVE-2019-15031](https://nvd.nist.gov/vuln/detail/CVE-2019-15031){: external}, [CVE-2019-15030](https://nvd.nist.gov/vuln/detail/CVE-2019-15030){: external}, and [CVE-2019-14835](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}. |
|Ubuntu 16.04 kernel and packages|4.4.0-161-generic|4.4.0-164-generic|Updated worker node images with kernel and package updates for [CVE-2019-14835](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}. |
{: caption="Changes since version 1.13.10_1536" caption-side="bottom"}

## Change log for worker node fix pack 1.13.10_1536, released 16 September 2019
{: #11310_1536_worker}

The following table shows the changes that are in the worker node fix pack 1.13.10_1536.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | v1.2.8 | v1.2.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.9){: external}. Update resolves [CVE-2019-9515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-159-generic | 4.4.0-161-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2015-9383](https://nvd.nist.gov/vuln/detail/CVE-2015-9383){: external}, [CVE-2019-10638](https://nvd.nist.gov/vuln/detail/CVE-2019-10638){: external}, [CVE-2019-3900](https://nvd.nist.gov/vuln/detail/CVE-2019-3900){: external}, [CVE-2018-20856](https://nvd.nist.gov/vuln/detail/CVE-2018-20856){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2018-20406](https://nvd.nist.gov/vuln/detail/CVE-2018-20406){: external}, and [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-58-generic | 4.15.0-62-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}, and [CVE-2019-15718](https://nvd.nist.gov/vuln/detail/CVE-2019-15718){: external}. |
{: caption="Table 1. Changes since version 1.13.10_1535" caption-side="bottom"}

## Change log for worker node fix pack 1.13.10_1535, released 3 September 2019
{: #11310_1535_worker}

The following table shows the changes that are in the worker node fix pack 1.13.10_1535.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | v1.2.7 | v1.2.8 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.8){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Kubernetes | v1.13.9 | v1.13.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.10){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-10222](https://nvd.nist.gov/vuln/detail/CVE-2019-10222){: external} and [CVE-2019-11922](https://nvd.nist.gov/vuln/detail/CVE-2019-11922){: external}. |
{: caption="Table 1. Changes since version 1.13.9_1533" caption-side="bottom"}

## Change log for master fix pack 1.13.10_1534, released 28 August 2019
{: #11310_1534}

The following table shows the changes that are in the master fix pack 1.13.10_1534.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| etcd | v3.3.13 | v3.3.15 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.15){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| GPU device plug-in and installer | 07c9b67 | de13f2a | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. Updated the GPU drivers to [430.40](https://www.nvidia.com/Download/driverResults.aspx/149138/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 348 | 349 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.9-209 | v1.13.10-221 | Updated to support the Kubernetes 1.13.10 release. |
| Key Management Service provider | 207 | 212 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Kubernetes | v1.13.9 | v1.13.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.10){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 147 | 148 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
{: caption="Table 1. Changes since version 1.13.9_1533" caption-side="bottom"}

## Change log for worker node fix pack 1.13.9_1533, released 19 August 2019
{: #1139_1533_worker}

The following table shows the changes that are in the worker node fix pack 1.13.9_1533.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 2.0.1-alpine | 1.8.21-alpine | Moved to HA proxy 1.8 to fix [socket leak in HA proxy](https://github.com/haproxy/haproxy/issues/136){: external}. Also added a liveliness check to monitor the health of HA proxy. For more information, see [HA proxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. |
| Kubernetes | v1.13.8 | v1.13.9 | For more information, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.9){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-157-generic | 4.4.0-159-generic | Updated worker node images with package updates for [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, and [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}. |
| Ubuntu 18.04 kernel and packages | 4.15.0-55-generic | 4.15.0-58-generic | Updated worker node images with package updates for [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2019-2101](https://nvd.nist.gov/vuln/detail/CVE-2019-2101){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-13233](https://nvd.nist.gov/vuln/detail/CVE-2019-13233){: external}, [CVE-2019-13272](https://nvd.nist.gov/vuln/detail/CVE-2019-13272){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}, [CVE-2019-12818](https://nvd.nist.gov/vuln/detail/CVE-2019-12818){: external}, [CVE-2019-12984](https://nvd.nist.gov/vuln/detail/CVE-2019-12984){: external}, and [CVE-2019-12819](https://nvd.nist.gov/vuln/detail/CVE-2019-12819){: external}. |
{: caption="Table 1. Changes since version 1.13.8_1530" caption-side="bottom"}

## Change log for master fix pack 1.13.9_1533, released 17 August 2019
{: #1139_1533}

The following table shows the changes that are in the master fix pack 1.13.9_1533.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Key Management Service provider | 167 | 207 | Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets. |
{: caption="Table 1. Changes since version 1.13.9_1532" caption-side="bottom"}


## Change log for master fix pack 1.13.9_1532, released 15 August 2019
{: #1139_1532}

The following table shows the changes that are in the master fix pack 1.13.9_1532.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico configuration | N/A | N/A | Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container. |
| GPU device plug-in and installer | a7e8ece | 07c9b67 | Image updated for [CVE-2019-9924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924){: external} and [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 347 | 348 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.
| {{site.data.keyword.cloud_notm}} Provider | v1.13.8-188 | v1.13.9-209 | Updated to support the Kubernetes 1.13.9 release. |
| Kubernetes | v1.13.8 | v1.13.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.9){: external}. Updates resolves [CVE-2019-11247](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967115){: external}) and [CVE-2019-11249](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967123){: external}).
| Kubernetes DNS | 1.14.13 | 1.15.4 | See the [Kubernetes DNS release notes](https://github.com/kubernetes/dns/releases/tag/1.15.4){: external}. Image update resolves [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 146 | 147 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-13 | 2.4.6-r3-IKS-116 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-25 | 2.4.6-r3-IKS-115 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
{: caption="Table 1. Changes since version 1.13.8_1530" caption-side="bottom"}


## Change log for worker node fix pack 1.13.8_1530, released 5 August 2019
{: #1138_1530_worker}

The following table shows the changes that are in the worker node fix pack 1.13.8_1530.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 18.04 kernel and packages | 4.15.0-54-generic | 4.15.0-55-generic | Updated worker node images with package updates for [CVE-2019-11085](https://nvd.nist.gov/vuln/detail/CVE-2019-11085){: external}, [CVE-2019-11815](https://nvd.nist.gov/vuln/detail/CVE-2019-11815){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-11884](https://nvd.nist.gov/vuln/detail/CVE-2019-11884){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, and [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-154-generic | 4.4.0-157-generic | Updated worker node images with package updates for [CVE-2019-2054](https://nvd.nist.gov/vuln/detail/CVE-2019-2054){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, and [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}. |
{: caption="Table 1. Changes since version 1.13.8_1529" caption-side="bottom"}


## Change log for worker node fix pack 1.13.8_1529, released 22 July 2019
{: #1138_1529_worker}

The following table shows the changes that are in the worker node fix pack 1.13.8_1529.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.13.7 | v1.13.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.8){: external}. Update resolves [CVE-2019-11248](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967113){: external}). |
| Ubuntu packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13012](https://ubuntu.com/security/CVE-2019-13012){: external} and [CVE-2019-7307](https://ubuntu.com/security/CVE-2019-7307.html){: external}. |
{: caption="Table 1. Changes since version 1.13.7_1528" caption-side="bottom"}


## Change log for master fix pack 1.13.8_1529, released 15 July 2019
{: #1138_1529}

The following table shows the changes that are in the master fix pack 1.13.8_1529.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.4.4 | v3.6.4 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. Update resolves [TTA-2019-001](https://www.tigera.io/security-bulletins/#TTA-2019-001){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/959551){: external}. |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the `kubernetes` zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| GPU device plug-in and installer | 5d34347 | a7e8ece | Updated base image packages. |
| Kubernetes | v1.13.7 | v1.13.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.8){: external}.
| {{site.data.keyword.cloud_notm}} Provider | v1.13.7-162 | v1.13.8-188 | Updated to support the Kubernetes 1.13.8 release. Additionally, `calicoctl` version is updated to 3.6.4. |
{: caption="Table 1. Changes since version 1.13.7_1528" caption-side="bottom"}


## Change log for worker node fix pack 1.13.7_1528, released 8 July 2019
{: #1137_1528}

The following table shows the changes that are in the worker node patch 1.13.7_1528.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-151-generic | 4.4.0-154-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-52-generic | 4.15.0-54-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
{: caption="Table 1. Changes since version 1.13.7_1527" caption-side="bottom"}



## Change log for worker node fix pack 1.13.7_1527, released 24 June 2019
{: #1137_1527}

The following table shows the changes that are in the worker node patch 1.13.7_1527.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-150-generic | 4.4.0-151-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-51-generic | 4.15.0-52-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| containerd | 1.2.6 | 1.2.7 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.7){: external}.
| Max pods | N/A | N/A | Increased the limit of maximum number of pods for worker nodes with more than 11 CPU cores to be 10 pods per core, up to a maximum of 250 pods per worker node. |
{: caption="Table 1. Changes since version 1.13.7_1526" caption-side="bottom"}

## Change log for 1.13.7_1526, released 17 June 2019
{: #1137_1526}

The following table shows the changes that are in the patch 1.13.7_1526.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| GPU device plug-in and installer | 32257d3 | 5d34347 | Updated image for [CVE-2019-8457](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457){: external}. Updated the GPU drivers to [430.14](https://www.nvidia.com/Download/driverResults.aspx/147582/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 346 | 347 | Updated so that the IAM API key can be either encrypted or unencrypted. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.6-139 | v1.13.7-162 | Updated to support the Kubernetes 1.13.7 release. |
| Kubernetes | v1.13.6 | v1.13.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.7){: external}. |
| Public service endpoint for Kubernetes master | N/A | N/A | Fixed an issue to [enable the public cloud service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se). |
| Ubuntu 16.04 kernel | 4.4.0-148-generic | 4.4.0-150-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-50-generic | 4.15.0-51-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
{: caption="Table 1. Changes since version 1.13.6_1524" caption-side="bottom"}



## Change log for 1.13.6_1524, released 4 June 2019
{: #1136_1524}

The following table shows the changes that are in the patch 1.13.6_1524.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS configuration | N/A | N/A | Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster `create` or `update` operations. |
| Cluster master HA configuration | N/A | N/A | Updated configuration to minimize intermittent master network connectivity failures during a master update. |
| etcd | v3.3.11 | v3.3.13 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.13){: external}. |
| GPU device plug-in and installer | 55c1f66 | 32257d3 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
| Kubernetes Metrics Server | v0.3.1 | v0.3.3 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3){: external}. |
| Trusted compute agent | 13c7ef0 | e8c6d72 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
{: caption="Table 1. Changes since version 1.13.6_1522" caption-side="bottom"}

## Change log for worker node fix pack 1.13.6_1522, released 20 May 2019
{: #1136_1522}

The following table shows the changes that are in the patch 1.13.6_1522.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-145-generic | 4.4.0-148-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-47-generic | 4.15.0-50-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
{: caption="Table 1. Changes since version 1.13.6_1521" caption-side="bottom"}


## Change log for 1.13.6_1521, released 13 May 2019
{: #1136_1521}

The following table shows the changes that are in the patch 1.13.6_1521.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 1.9.6-alpine | 1.9.7-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2019-6706](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706){: external}. |
| GPU device plug-in and installer | 9ff3fda | 55c1f66 | Updated image for [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.5-107 | v1.13.6-139 | Updated to support the Kubernetes 1.13.6 release. Also, fixed the update process for version 2.0 network load balancer that have only one available worker node for the load balancer pods. |
| Kubernetes | v1.13.5 | v1.13.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.6){: external}.
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years. |
| OpenVPN client configuration | N/A | N/A | The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down. |
| Trusted compute agent | e132aa4 | 13c7ef0 | Updated image for [CVE-2016-7076](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076){: external}, [CVE-2017-1000368](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368){: external}, and [CVE-2019-11068](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068){: external}. |
{: caption="Table 1. Changes since version 1.13.5_1519" caption-side="bottom"}


## Change log for worker node fix pack 1.13.5_1519, released 29 April 2019
{: #1135_1519}

The following table shows the changes that are in the worker node fix pack 1.13.5_1519.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages.
| containerd | 1.2.5 | 1.2.6 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.6){: external}. |
{: caption="Table 1. Changes since version 1.13.5_1518" caption-side="bottom"}


## Change log for worker node fix pack 1.13.5_1518, released 15 April 2019
{: #1135_1518}

The following table shows the changes that are in the worker node fix pack 1.13.5_1518.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842](https://ubuntu.com/security/CVE-2019-3842.html){: external}. |
{: caption="Table 1. Changes since version 1.13.5_1517" caption-side="bottom"}


## Change log for 1.13.5_1517, released 8 April 2019
{: #1135_1517}

The following table shows the changes that are in the patch 1.13.5_1517.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.4.0 | v3.4.4 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases/){: external}. Update resolves [CVE-2019-9946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/879585){: external}. |
| Cluster master HA proxy | 1.8.12-alpine | 1.9.6-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2018-0732](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external}, [CVE-2018-0734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external}, [CVE-2018-0737](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external}, [CVE-2018-5407](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}, [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}, and [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.4-86 | v1.13.5-107 | Updated to support the Kubernetes 1.13.5 and Calico 3.4.4 releases. |
| Kubernetes | v1.13.4 | v1.13.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.5){: external}. |
| Trusted compute agent | a02f765 | e132aa4 | Updated image for [CVE-2017-12447](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447){: external}. |
| Ubuntu 16.04 kernel | 4.4.0-143-generic | 4.4.0-145-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-46-generic | 4.15.0-47-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}. |
{: caption="Table 1. Changes since version 1.13.4_1516" caption-side="bottom"}


## Change log for worker node fix pack 1.13.4_1516, released 1 April 2019
{: #1134_1516}

The following table shows the changes that are in the worker node fix pack 1.13.4_1516.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Worker node resource utilization | N/A | N/A | Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Table 1. Changes since version 1.13.4_1515" caption-side="bottom"}

## Change log for master fix pack 1.13.4_1515, released 26 March 2019
{: #1134_1515}

The following table shows the changes that are in the master fix pack 1.13.4_1515.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS configuration | N/A | N/A | Fixed the update process from Kubernetes version 1.11 to prevent the update from switching the cluster DNS provider to CoreDNS. You can still set up CoreDNS as the cluster DNS provider after the update. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 345 | 346 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}.
| Key Management Service provider | 166 | 167 | Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 143 | 146 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
{: caption="Table 1. Changes since version 1.13.4_1513" caption-side="bottom"}



## Change log for 1.13.4_1513, released 20 March 2019
{: #1134_1513}

The following table shows the changes that are in the patch 1.13.4_1513.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS configuration | N/A | N/A | Fixed a bug that might cause cluster master operations, such as `refresh` or `update`, to fail when the unused cluster DNS must be scaled down. |
| Cluster master HA proxy configuration | N/A | N/A | Updated configuration to better handle intermittent connection failures to the cluster master.
| CoreDNS configuration | N/A | N/A | Updated the CoreDNS configuration to support [multiple Corefiles](https://coredns.io/2017/07/23/corefile-explained/){: external} after updating the cluster Kubernetes version from 1.12. |
| containerd | 1.2.4 | 1.2.5 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.5){: external}. Update includes improved fix for [CVE-2019-5736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/871600){: external}. |
| GPU device plug-in and installer | e32d51c | 9ff3fda | Updated the GPU drivers to [418.43](https://www.nvidia.com/object/unix.html){: external}. Update includes fix for [CVE-2019-9741](https://ubuntu.com/security/CVE-2019-9741.html){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 344 | 345 | Added support for [private cloud service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se). |
| Kernel | 4.4.0-141 | 4.4.0-143 | Updated worker node images with kernel update for [CVE-2019-6133](https://ubuntu.com/security/CVE-2019-6133.html){: external}.
| Key Management Service provider | 136 | 166 | Updated image for [CVE-2018-16890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890){: external}, [CVE-2019-3822](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822){: external}, and [CVE-2019-3823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823){: external}. |
| Trusted compute agent | 5f3d092 | a02f765 | Updated image for [CVE-2018-10779](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779){: external}, [CVE-2018-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900){: external}, [CVE-2018-17000](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000){: external}, [CVE-2018-19210](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210){: external}, [CVE-2019-6128](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128){: external}, and [CVE-2019-7663](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663){: external}. |
{: caption="Table 1. Changes since version 1.13.4_1510" caption-side="bottom"}



## Change log for 1.13.4_1510, released 4 March 2019
{: #1134_1510}

The following table shows the changes that are in the patch 1.13.4_1510.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS provider | N/A | N/A | Increased Kubernetes DNS and CoreDNS pod memory limit from `170Mi` to `400Mi` in order to handle more cluster services.
| GPU device plug-in and installer | eb3a259 | e32d51c | Updated images for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.2-62 | v1.13.4-86 | Updated to support the Kubernetes 1.13.4 release. Fixed periodic connectivity problems for version 1.0 load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer version 1.0 and 2.0 events to use the latest {{site.data.keyword.cloud_notm}} documentation links. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 342 | 344 | Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| Key Management Service provider | 122 | 136 | Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| Kubernetes | v1.13.2 | v1.13.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.4){: external}. Update resolves [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external} and [CVE-2019-1002100](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/873324){: external}. |
| Kubernetes configuration | N/A | N/A | Added `ExperimentalCriticalPodAnnotation=true` to the `--feature-gates` option. This setting helps migrate pods from the deprecated `scheduler.alpha.kubernetes.io/critical-pod` annotation to [Kubernetes pod priority support](/docs/containers?topic=containers-pod_priority#pod_priority). |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 132 | 143 | Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| OpenVPN client and server | 2.4.6-r3-IKS-13 | 2.4.6-r3-IKS-25 | Updated image for [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}. |
| Trusted compute agent | 1ea5ad3 | 5f3d092 | Updated image for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}. |
{: caption="Table 1. Changes since version 1.13.2_1509" caption-side="bottom"}


## Change log for worker node fix pack 1.13.2_1509, released 27 February 2019
{: #1132_1509}

The following table shows the changes that are in the worker node fix pack 1.13.2_1509.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-141 | 4.4.0-142 | Updated worker node images with kernel update for [CVE-2018-19407](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog){: external}. |
{: caption="Table 1. Changes since version 1.13.2_1508" caption-side="bottom"}

## Change log for worker node fix pack 1.13.2_1508, released 15 February 2019
{: #1132_1508}

The following table shows the changes that are in the worker node fix pack 1.13.2_1508.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy configuration | N/A | N/A | Changed the pod configuration `spec.priorityClassName` value to `system-node-critical` and set the `spec.priority` value to `2000001000`. |
| containerd | 1.2.2 | 1.2.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.4){: external}. Update resolves [CVE-2019-5736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/871600){: external}. |
| Kubernetes `kubelet` configuration | N/A | N/A | Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction. Set the `event-qps` option to `0` to prevent rate limiting event creation. |
{: caption="Table 1. Changes since version 1.13.2_1507" caption-side="bottom"}

## Change log for 1.13.2_1507, released 5 February 2019
{: #1132_1507}

The following table shows the changes that are in the patch 1.13.2_1507.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.3.1 | v3.4.0 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. |
| Cluster DNS provider | N/A | N/A | CoreDNS is now the default cluster DNS provider for new clusters. If you update an existing cluster to 1.13 that uses KubeDNS as the cluster DNS provider, KubeDNS continues to be the cluster DNS provider. |
| containerd | 1.1.5 | 1.2.2 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.2){: external}. |
| CoreDNS | 1.2.2 | 1.2.6 | See the [CoreDNS release notes](https://github.com/coredns/coredns/releases/tag/v1.2.6){: external}. Additionally, the CoreDNS configuration is updated to [support multiple Corefiles](https://coredns.io/2017/07/23/corefile-explained/){: external}. |
| etcd | v3.3.1 | v3.3.11 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.11){: external}. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more). |
| GPU device plug-in and installer | 13fdc0d | eb3a259 | Updated images for [CVE-2019-3462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462){: external} and [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.4-118 | v1.13.2-62 | Updated to support the Kubernetes 1.13.2 release. Additionally, `calicoctl` version is updated to 3.4.0. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 338 | 342 | The {{site.data.keyword.filestorage_short}} plug-in is updated as follows: \n - Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology). \n - Ignores persistent volume claim (PVC) delete errors if the storage is already deleted. \n - Adds a failure message annotation to failed PVCs. \n - Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour.< \n - Checks user permissions before starting the provisioning. \n - Adds a `CriticalAddonsOnly` toleration to the `ibm-file-plugin` and `ibm-storage-watcher` deployments in the `kube-system` namespace. |
| Key Management Service provider | 111 | 122 | Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}. |
| Kubernetes | v1.12.4 | v1.13.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.13.2){: external}.
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests. |
| Kubernetes DNS autoscaler | 1.2.0 | 1.3.0 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.3.0){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}. Added `CriticalAddonsOnly` toleration to the `vpn` deployment in the `kube-system` namespace. Additionally, the pod configuration is now obtained from a secret instead of from a ConfigMap. |
| OpenVPN server | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}. |
| systemd | 230 | 229 | Security patch for [CVE-2018-16864](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864){: external}. |
{: caption="Table 1. Changes since version 1.12.4_1535" caption-side="bottom"}
