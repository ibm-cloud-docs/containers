---

copyright:
 years: 2014, 2023
lastupdated: "2023-02-08"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Version 1.16 changelog (unsupported as of 31 January 2021)
{: #116_changelog}


Version 1.16 is unsupported. You can review the following archive of 1.16 changelogs.
{: shortdesc}

## Change log for master fix pack 1.16.15_1557, released 19 January 2021
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
{: caption="Changes since version 1.16.15_1556" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1557, released 18 January 2021
{: #11615_1557}

The following table shows the changes that are in the worker node fix pack `1.16.15_1557`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | 4.4.0-197-generic | 4.4.0-200-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external} external}, and [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external} external}. |
| Ubuntu 18.04 packages | 4.15.0-128-generic | 4.15.0-132-generic | Updated worker node image with kernel and package updates for [CVE-2018-20482](https://nvd.nist.gov/vuln/detail/CVE-2018-20482){: external}, [CVE-2019-9923](https://nvd.nist.gov/vuln/detail/CVE-2019-9923){: external}, [CVE-2020-28374](https://nvd.nist.gov/vuln/detail/CVE-2020-28374){: external}, [CVE-2020-29361](https://nvd.nist.gov/vuln/detail/CVE-2020-29361){: external}, [CVE-2020-29362](https://nvd.nist.gov/vuln/detail/CVE-2020-29362){: external}, [CVE-2020-29363](https://nvd.nist.gov/vuln/detail/CVE-2020-29363){: external}, [CVE-2021-1052](https://nvd.nist.gov/vuln/detail/CVE-2021-1052){: external}, [CVE-2021-1053](https://nvd.nist.gov/vuln/detail/CVE-2021-1053){: external}, and [CVE-2019-19770](https://nvd.nist.gov/vuln/detail/CVE-2019-19770){: external}. |
{: caption="Changes since version 1.16.15_1555" caption-side="bottom"}

## Change log for master fix pack 1.16.15_1556, released 6 January 2021
{: #11615_1556}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1556`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Calico extension | 544 | 556 | Updated image to include the `ip` command. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | N/A | N/A | Updated to run with a privileged security context. |
| Operator Lifecycle Manager | 0.14.1-IKS-1 | 0.14.1-IKS-2 | Updated image for [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971){: external} and [CVE-2020-28928](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-28928){: external}. |
{: caption="Changes since version 1.16.15_1554" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1555, released 21 December 2020
{: #11615_1555}

The following table shows the changes that are in the worker node fix pack `1.16.15_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ubuntu 18.04 packages | 4.15.0-126-generic | 4.15.0-128-generic | Updated worker node image with kernel and package updates for: [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external}, [CVE-2020-27350](https://nvd.nist.gov/vuln/detail/CVE-2020-27350){: external}, [CVE-2020-27351](https://nvd.nist.gov/vuln/detail/CVE-2020-27351){: external}, [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284){: external}, [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285){: external}, and [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286){: external}. |
| Ephemeral storage reservations | N/A | N/A | Reserve local ephemeral storage to prevent workload evictions. |
| HAProxy | db4e6d | 9b2dca | Image update for [CVE-2020-1971](https://nvd.nist.gov/vuln/detail/CVE-2020-1971){: external} and [CVE-2020-24659](https://nvd.nist.gov/vuln/detail/CVE-2020-24659){: external}. |
{: caption="Changes since version 1.16.15_1554" caption-side="bottom"}

## Change log for master fix pack 1.16.15_1554, released 14 December 2020
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
{: caption="Changes since version 1.16.15_1552" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1554, released 11 December 2020
{: #11615_1554}

The following table shows the changes that are in the worker node fix pack `1.16.15_1554`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 bare metal kernel | 4.15.0-126-generic | 4.15.0-123-generic | **Bare metal worker nodes**: Reverted the kernel version for bare metal worker nodes while Canonical addresses issues with the previous version that prevented worker nodes from being reloaded or updated. |
{: caption="Changes since version 1.16.15_1553" caption-side="bottom"}


## Change log for worker node fix pack 1.16.15_1553, released 7 December 2020
{: #11615_1553}

The following table shows the changes that are in the worker node fix pack `1.16.15_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Containerd | v1.3.4 | 1.3.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.9){: external}. The update resolves CVE-2020–15257 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6387878){: external}). |
| HAProxy | 1.8.26-384f42 | db4e6d | Added provenance labels for source tracking. |
| Ubuntu 18.04 packages | 4.15.0-123-generic | 4.15.0-126-generic | Updated worker node image with   kernel and package updates for [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external} and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
| Ubuntu 16.04 packages | 4.4.0-194-generic | 4.4.0-197-generic | Updated worker node image with kernel and package updates for [CVE-2020-0427](https://nvd.nist.gov/vuln/detail/CVE-2020-0427){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-14351](https://nvd.nist.gov/vuln/detail/CVE-2020-14351){: external}, [CVE-2020-25645](https://nvd.nist.gov/vuln/detail/CVE-2020-25645){: external}, and [CVE-2020-4788](https://nvd.nist.gov/vuln/detail/CVE-2020-4788){: external}. |
{: caption="Changes since version 1.16.15_1552" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1552, released 23 November 2020
{: #11615_1552_worker}

The following table shows the changes that are in the worker node fix pack `1.16.15_1552`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-122-generic | 4.15.0-123-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
| Ubuntu 16.04 packages | 4.4.0-193-generic | 4.4.0-194-generic | Updated worker node image with kernel and package updates for [CVE-2020-25692](https://nvd.nist.gov/vuln/detail/CVE-2020-25692){: external}, [CVE-2020-25709](https://nvd.nist.gov/vuln/detail/CVE-2020-25709){: external}, [CVE-2020-25710](https://nvd.nist.gov/vuln/detail/CVE-2020-25710){: external}, [CVE-2020-28196](https://nvd.nist.gov/vuln/detail/CVE-2020-28196){: external}, and [CVE-2020-8694](https://nvd.nist.gov/vuln/detail/CVE-2020-8694){: external}. |
{: caption="Changes since version 1.16.15_1551" caption-side="bottom"}

## Change log for master fix pack 1.16.15_1552, released 16 November 2020
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
{: caption="Changes since version 1.16.15_1550" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1551, released 9 November 2020
{: #11615_1551}

The following table shows the changes that are in the worker node fix pack `1.16.15_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with kernel and package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}, and [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}. |
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2018-14036](https://nvd.nist.gov/vuln/detail/CVE-2018-14036){: external}, [CVE-2020-10543](https://nvd.nist.gov/vuln/detail/CVE-2020-10543){: external}, [CVE-2020-10878](https://nvd.nist.gov/vuln/detail/CVE-2020-10878){: external}, [CVE-2020-12723](https://nvd.nist.gov/vuln/detail/CVE-2020-12723){: external}, [CVE-2020-16126](https://nvd.nist.gov/vuln/detail/CVE-2020-16126){: external}, and [CVE-2020-25659](https://nvd.nist.gov/vuln/detail/CVE-2020-25659){: external}.|
{: caption="Changes since version 1.16.15_1550" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1550, released 26 October 2020
{: #11615_1550_worker}

The following table shows the changes that are in the worker node fix pack `1.16.15_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | 4.15.0-118-generic | 4.15.0-122-generic | Updated worker node images with kernel and package updates for [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external},[CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2019-20916](https://nvd.nist.gov/vuln/detail/CVE-2019-20916){: external}, [CVE-2020-12351](https://nvd.nist.gov/vuln/detail/CVE-2020-12351){: external}, [CVE-2020-12352](https://nvd.nist.gov/vuln/detail/CVE-2020-12352){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, [CVE-2020-16120](https://nvd.nist.gov/vuln/detail/CVE-2020-16120){: external}, [CVE-2020-24490](https://nvd.nist.gov/vuln/detail/CVE-2020-24490){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
|Ubuntu 16.04 packages | 4.4.0-190-generic | 4.4.0-193-generic | Updated worker node images with kernel and package updates for [CVE-2017-17087](https://nvd.nist.gov/vuln/detail/CVE-2017-17087){: external}, [CVE-2018-10322](https://nvd.nist.gov/vuln/detail/CVE-2018-10322){: external}, [CVE-2019-20807](https://nvd.nist.gov/vuln/detail/CVE-2019-20807){: external}, [CVE-2020-15999](https://nvd.nist.gov/vuln/detail/CVE-2020-15999){: external}, [CVE-2020-16119](https://nvd.nist.gov/vuln/detail/CVE-2020-16119){: external}, and [CVE-2020-26116](https://nvd.nist.gov/vuln/detail/CVE-2020-26116){: external}. |
{: caption="Changes since version 1.16.15_1549" caption-side="bottom"}

## Change log for master fix pack 1.16.15_1550, released 26 October 2020
{: #11615_1550}

The following table shows the changes that are in the master fix pack patch update `1.16.15_1550`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico configuration | N/A | N/A | Updated the `calico-node` daemon set in the `kube-system` namespace to set the `spec.updateStrategy.rollingUpdate.maxUnavailable` parameter to `10%` for clusters with more than 50 worker nodes. |
| Cluster health image | v1.1.11 | v1.1.12 | Updated to use `Go` version 1.15.2. |
| Gateway-enabled cluster controller | 1082 | 1105 | Updated to use `Go` version 1.15.2. |
| Kubernetes `NodeLocal` DNS cache | 1.15.13 | 1.15.14 | See the [Kubernetes `NodeLocal` DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.14){: external}. |
{: caption="Changes since version 1.16.15_1547" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1549, released 12 October 2020
{: #11615_1549}

The following table shows the changes that are in the worker node fix pack `1.16.15_1549`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2019-8936](https://nvd.nist.gov/vuln/detail/CVE-2019-8936){: external}, [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}, and [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external}.|
|Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-14365](https://nvd.nist.gov/vuln/detail/CVE-2020-14365){: external} and [CVE-2020-26137](https://nvd.nist.gov/vuln/detail/CVE-2020-26137){: external}. |
{: caption="Changes since version 1.16.15_1548" caption-side="bottom"}

## Change log for worker node fix pack 1.16.15_1548, released 28 September 2020
{: #11615_1548}

The following table shows the changes that are in the worker node fix pack `1.16.15_1548`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.16.14    | v1.16.15 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.15){: external}. |
| Ubuntu 18.04 packages | 4.15.0-117-generic | 4.15.0-118-generic | Updated worker node image with   kernel and package updates for [CVE-2018-1000500](https://nvd.nist.gov/vuln/detail/CVE-2018-1000500){: external}, [CVE-2018-7738](https://nvd.nist.gov/vuln/detail/CVE-2018-7738){: external}, [CVE-2019-14855](https://nvd.nist.gov/vuln/detail/CVE-2019-14855){: external}, [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, [CVE-2020-10753](https://nvd.nist.gov/vuln/detail/CVE-2020-10753){: external}, [CVE-2020-12059](https://nvd.nist.gov/vuln/detail/CVE-2020-12059){: external}, [CVE-2020-12888](https://nvd.nist.gov/vuln/detail/CVE-2020-12888){: external}, [CVE-2020-1760](https://nvd.nist.gov/vuln/detail/CVE-2020-1760){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}.|
| Ubuntu 16.04 packages | 4.4.0-189-generic | 4.4.0-190-generic | Updated worker node image with kernel and package updates for [CVE-2019-20811](https://nvd.nist.gov/vuln/detail/CVE-2019-20811){: external}, [CVE-2019-9453](https://nvd.nist.gov/vuln/detail/CVE-2019-9453){: external}, [CVE-2020-0067](https://nvd.nist.gov/vuln/detail/CVE-2020-0067){: external}, and [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968){: external}. |
{: caption="Changes since version 1.16.14_1546" caption-side="bottom"}

## Change log for master fix pack 1.16.15_1547, released 21 September 2020
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
{: caption="Changes since version 1.16.14_1546" caption-side="bottom"}

## Change log for worker node fix pack 1.16.14_1546, released 14 September 2020
{: #11614_1546}

The following table shows the changes that are in the worker node fix pack `1.16.14_1546`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-384f42 | 1.8.26-561f1a | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.|
| Ubuntu 18.04 packages | 4.15.0-112-generic | 4.15.0-117-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external}, [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}, and [CVE-2020-14386](https://nvd.nist.gov/vuln/detail/CVE-2020-14386){: external}. |
| Ubuntu 16.04 packages | 4.4.0-187-generic | 4.4.0-189-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external} and [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}. |
{: caption="Changes since version 1.16.14_1545" caption-side="bottom"}

## Change log for worker node fix pack 1.16.14_1545, released 31 August 2020
{: #11614_1545}

The following table shows the changes that are in the worker node fix pack `1.16.14_1545`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-12403](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12403){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}, and [CVE-2020-8624](https://nvd.nist.gov/vuln/detail/CVE-2020-8624){: external}. |
| Ubuntu 16.04 packages | 4.4.0-186-generic | 4.4.0-187-generic | Updated worker node image with kernel and package updates for [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, and [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}. |
{: caption="Changes since version 1.16.14_1544" caption-side="bottom"}

## Change log for master fix pack 1.16.14_1544, released 18 August 2020
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
{: caption="Changes since version 1.16.13_1542" caption-side="bottom"}

## Change log for worker node fix pack 1.16.14_1544, released 17 August 2020
{: #11614_1544}

The following table shows the changes that are in the worker node fix pack `1.16.14_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.16.13 | v1.16.14 | See the [Kubernetes changelogs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md#v11614){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-12400](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12400){: external}, [CVE-2020-12401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12401){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}, and [CVE-2020-6829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6829){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, and [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}. |
{: caption="Changes since version 1.16.13_1542" caption-side="bottom"}

## Change log for worker node fix pack 1.16.13_1542, released 3 August 2020
{: #11613_1542}

The following table shows the changes that are in the worker node fix pack `1.16.13_1542`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-111-generic | 4.15.0-112-generic | Updated worker node images with kernel and package updates for [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-10757](https://nvd.nist.gov/vuln/detail/CVE-2020-10757){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
| Ubuntu 16.04 packages | 4.4.0-185-generic | 4.4.0-186-generic | Updated worker node images with package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
{: caption="Changes since version 1.16.13_1539" caption-side="bottom"}

## Change log for master fix pack 1.16.13_1541, released 24 July 2020
{: #11613_1541}

The following table shows the changes that are in the master fix pack patch update `1.16.13_1541`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master operations | N/A | N/A | Fixed a problem that might cause pods to fail authentication to the Kubernetes API server after a cluster master operation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 375 | 376 | Updated to use `Go` version 1.13.8. |
{: caption="Changes since version 1.16.13_1540" caption-side="bottom"}

## Change log for master fix pack 1.16.13_1540, released 20 July 2020
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
{: caption="Changes since version 1.16.11_1537" caption-side="bottom"}

## Change log for worker node fix pack 1.16.13_1539, released 20 July 2020
{: #11613_1539}

The following table shows the changes that are in the worker node fix pack `1.16.13_1539`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 2.0.15-afe432 | 1.8.25-384f42 | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Fixes a connection leak that happens when HAProxy is under high load. |
| Kubernetes | v1.16.11 | v1.16.13 | See the [Kubernetes changelogs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md#v11613){: external}. The update resolves CVE-2020-8557 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6249941){: external}). |
| Ubuntu 18.04 packages | 4.15.0-109-generic | 4.15.0-111-generic | Updated worker node images with kernel and package updates for [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-19591](https://nvd.nist.gov/vuln/detail/CVE-2018-19591){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-12402](https://nvd.nist.gov/vuln/detail/CVE-2020-12402){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
| Ubuntu 16.04 packages | 4.4.0-184-generic | 4.4.0-185-generic | Updated worker node images with package updates for [CVE-2017-12133](https://nvd.nist.gov/vuln/detail/CVE-2017-12133){: external}, [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}, [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-6485](https://nvd.nist.gov/vuln/detail/CVE-2018-6485){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
{: caption="Changes since version 1.16.11_1537" caption-side="bottom"}

## Change log for worker node fix pack 1.16.11_1537, released 6 July 2020
{: #11611_1537}

The following table shows the changes that are in the worker node fix pack `1.16.11_1537`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-30b675 | 2.0.15-afe432 | See the [HAProxy changelog](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}. |
| Ubuntu 18.04 packages | 4.15.0-106-generic | 4.15.0-109-generic | Updated worker node images with kernel and package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-16089](https://nvd.nist.gov/vuln/detail/CVE-2019-16089){: external}, [CVE-2019-19036](https://nvd.nist.gov/vuln/detail/CVE-2019-19036){: external}, [CVE-2019-19039](https://nvd.nist.gov/vuln/detail/CVE-2019-19039){: external}, [CVE-2019-19318](https://nvd.nist.gov/vuln/detail/CVE-2019-19318){: external}, [CVE-2019-19642](https://nvd.nist.gov/vuln/detail/CVE-2019-19642){: external}, [CVE-2019-19813](https://nvd.nist.gov/vuln/detail/CVE-2019-19813){: external}, [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-19377](https://nvd.nist.gov/vuln/detail/CVE-2019-19377){: external}, and [CVE-2019-19816](https://nvd.nist.gov/vuln/detail/CVE-2019-19816){: external}. |
| Ubuntu 16.04 packages | N/A| N/A| Updated worker node images with package updates for [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external} and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}. |
| Worker node `drain` automation |N/A |N/A | Fixes a race condition that can cause worker node `drain` automation to fail. |
{: caption="Changes since version 1.16.11_1536" caption-side="bottom"}

## Change log for 1.16.11_1536, released 22 June 2020
{: #11611_1536}

The following table shows the changes that are in the master and worker node update `1.16.11_1536`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Calico | Master | v3.9.5 | v3.9.6 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/){: external}. The master update resolves CVE-2020-13597 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6226322){: external}). |
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
{: caption="Changes since version 1.16.10_1534" caption-side="bottom"}

## Change log for worker node fix pack 1.16.10_1534, released 8 June 2020
{: #11610_1534}

The following table shows the changes that are in the worker node fix pack `1.16.10_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1549](https://nvd.nist.gov/vuln/detail/CVE-2019-1549){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
{: caption="Changes since version 1.16.10_1533" caption-side="bottom"}

## Change log for 1.16.10_1533, released 26 May 2020
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
| Kubernetes `NodeLocal` DNS cache | Master | 1.15.4 | 1.15.13 |  - See the [Kubernetes `NodeLocal` DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.13){: external} \n - Now, when you [apply the label to set up node local DNS caching](/docs/containers?topic=containers-cluster_dns#dns_cache), the requests are handled immediately and you don't need to reload the worker nodes. \n - The `NodeLocal` DNS cache configuration now allows customization of stub domains and upstream DNS servers. \n - The `node-local-dns` daemon set is updated to include the `prometheus.io/port` and `prometheus.io/scrape` annotations on the pods. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | Master | 177 | 208 | Updated the version 2.0 network load balancers (NLB) to clean up unnecessary IPVS rules. Improved application logging. Updated image for [CVE-2020-1967](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | Worker | 4.15.0-99-generic | 4.15.0-101-generic | Updated worker node images with kernel and package updates for [CVE-2019-20795](https://nvd.nist.gov/vuln/detail/CVE-2019-20795){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: caption="Changes since version 1.16.9_1531" caption-side="bottom"}

## Change log for worker node fix pack 1.16.9_1531, released 11 May 2020
{: #1169_1531}

The following table shows the changes that are in the worker node fix pack `1.16.9_1531`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: caption="Changes since version 1.16.9_1530" caption-side="bottom"}

## Change log for worker node fix pack 1.16.9_1530, released 27 April 2020
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
{: caption="Changes since version 1.16.8_1528" caption-side="bottom"}

## Change log for master fix pack 1.16.9_1529, released 23 April 2020
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
{: caption="Changes since version 1.16.8_1528" caption-side="bottom"}

## Change log for worker node fix pack 1.16.8_1528, released 13 April 2020
{: #1168_1528}

The following table shows the changes that are in the worker node fix pack `1.16.8_1528`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: caption="Changes since version 1.16.8_1527" caption-side="bottom"}

## Change log for worker node fix pack 1.16.8_1527, released 30 March 2020
{: #1168_1527}

The following table shows the changes that are in the worker node fix pack `1.16.8_1527`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786){: external}, and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349){: external}, and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: caption="Changes since version 1.16.8_1526" caption-side="bottom"}

## Change log for 1.16.8_1526, released 16 March 2020
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
{: caption="Changes since version 1.16.7_1525" caption-side="bottom"}

## Change log for worker node fix pack 1.16.7_1525, released 2 March 2020
{: #1167_1525}

The following table shows the changes that are in the worker node fix pack 1.16.7_1525. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU worker node provisioning | N/A | N/A | Fixed bug where new GPU worker nodes could not automatically join clusters that run Kubernetes version 1.16 or 1.17. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: caption="Changes since version 1.16.7_1524" caption-side="bottom"}

## Change log for fix pack 1.16.7_1524, released 17 February 2020
{: #1167_1524}

The following table shows the changes that are in the master and worker node fix pack update `1.16.7_1524`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | -------- | ------- | ----------- |
| containerd | Worker | v1.3.2 | v1.3.3 | See [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.3){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| CoreDNS | Master | 1.6.6 | 1.6.7 | See the [CoreDNS release notes](https://coredns.io/2020/01/28/coredns-1.6.7-release/){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external} and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.16.5-148 | v1.16.7-170 | Updated to support the Kubernetes 1.16.7 release and to use `Go` version 1.13.6 and `calicoctl` version 3.9.5. |
| Kubernetes | Both | v1.16.5 | v1.16.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.7){: external}. The master update resolves CVE-2019-11254 and CVE-2020-8552 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6203780){: external}), and the worker node update resolves CVE-2020-8551 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6204874){: external}). |
| Kubernetes Dashboard | Master | v2.0.0-rc2 | v2.0.0-rc5 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-rc5){: external}. |
| Kubernetes Dashboard Metrics Scraper | Master | v1.0.2 | v1.0.3 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.3){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh){: external}. |
| Operator Lifecycle Manager | Master | 0.13.0 | 0.14.1 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.14.1){: external}. |
| Operator Lifecycle Manager Catalog | Master | v1.5.6 | v1.5.9 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.9){: external}. |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and[CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
{: caption="Changes since version 1.16.5_1523" caption-side="bottom"}

## Change log for worker node fix pack 1.16.5_1523, released 3 February 2020
{: #1165_1523}

The following table shows the changes that are in the worker node fix pack 1.16.5_1523.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}{: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: caption="Changes since version 1.16.5_1522" caption-side="bottom"}

## Change log for 1.16.5_1522, released 20 January 2020
{: #1165_1522}

The following table shows the changes that are in the master and worker node patch update 1.16.5_1522. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.3 | v3.9.5 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.9/release-notes/){: external}. |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| CoreDNS | 1.6.2 | 1.6.6 | See the [CoreDNS release notes](https://coredns.io/2019/12/11/coredns-1.6.6-release/){: external}. Update resolves [CVE-2019-19794](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19794){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Gateway-enabled cluster controller | 1032 | 1045 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external} and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| IBM Calico extension | 130 | 258 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 |  - Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`. \n - Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot). \n - Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
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
{: caption="Changes since version 1.16.3_1521" caption-side="bottom"}


## Change log for worker node fix pack 1.16.3_1521, released 23 December 2019
{: #1163_1521}

The following table shows the changes that are in the worker node fix pack 1.16.3_1521.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: caption="Changes since version 1.16.3_1519" caption-side="bottom"}

## Change log for master fix pack 1.16.3_1520, released 17 December 2019
{: #1163_1520}

The following table shows the changes that are in the master fix pack 1.16.3_1520.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Gateway-enabled cluster controller | 924 | 1032 | Support for [Adding classic infrastructure servers to gateway-enabled classic clusters](/docs/containers?topic=containers-add_workers#gateway_vsi) is now generally available (GA). In addition, the controller is updated to use Alpine base image version 3.10 and to use Go version 1.12.11. |
| IBM Calico extension | N/A | 130 | **New!**: Added a Calico node init container that creates Calico private host endpoints for worker nodes. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.16.3-94 | v1.16.3-115 | Updated version 1.0 and 2.0 network load balancers (NLBs) to prefer scheduling NLB pods on worker nodes that don't currently run any NLB pods. In addition, the Virtual Private Cloud (VPC) load balancer plug-in is updated to use Go version 1.12.11. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
| Kubernetes add-on resizer | 1.8.5 | 1.8.7 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.7){: external}. |
| Kubernetes Metrics Server | N/A | N/A | The `nanny` container is fixed (see Kubernetes add-on resizer component) and added back to the `metrics-server` pod, which removes the Kubernetes 1.16 limitation to [Adjusting cluster metrics provider resources](/docs/containers?topic=containers-kernel#metrics). |
| Kubernetes Dashboard | v2.0.0-beta6 | v2.0.0-beta8 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta8){: external}.|
| Operator Lifecycle Manager Catalog | v1.4.0 | v1.5.4 | See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.5.4){: external}. |
| Operator Lifecycle Manager | 0.12.0 | 0.13.0 | See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.13.0){: external}. |
{: caption="Changes since version 1.16.3_1519" caption-side="bottom"}

## Change log for worker node fix pack 1.16.3_1519, released 9 December 2019
{: #1163_1519_worker}

The following table shows the changes that are in the worker node fix pack 1.16.3_1519.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.1 | v1.3.2 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.2){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: caption="Changes since version 1.16.3_1518" caption-side="bottom"}

## Change log for worker node fix pack 1.16.3_1518, released 25 November 2019
{: #1163_1518_worker}

The following table shows the changes that are in the worker node fix pack 1.16.3_1518.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.3.0 | v1.3.1 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.1){: external}. Update resolves [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external} and [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. |
| Kubernetes | v1.16.2 | v1.16.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.3){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: caption="Changes since version 1.16.2_1515" caption-side="bottom"}

## Change log for master fix pack 1.16.3_1518, released 21 November 2019
{: #1163_1518}

The following table shows the changes that are in the master fix pack 1.16.3_1518.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.9.2 | v3.9.3 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}, and [DSA-4539-3](https://lists.debian.org/debian-security-announce/2019/msg00193.html){: external}. |
| GPU device plug-in and installer | 9cd3df7 |    f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor    | 351 | 353 | Updated to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.16.2-77 | v1.16.3-94 | Updated to support the Kubernetes 1.16.3 release. `calicoctl` version is updated to v3.9.3. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.16.2 | v1.16.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.3){: external}. |
| Kubernetes Dashboard | v2.0.0-beta5 | v2.0.0-beta6 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta6){: external}. |
{: caption="Changes since version 1.16.2_1515" caption-side="bottom"}

## Change log for worker node fix pack 1.16.2_1515, released 11 November 2019
{: #1162_1515_worker}

The following table shows the changes that are in the worker node fix pack 1.16.2_1515.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: caption="Changes since version 1.16.2_1514" caption-side="bottom"}

## Change log for 1.16.2_1514, released 4 November 2019
{: #1162_1514}

The following tables show the changes that are in the patch `1.16.2_1514`. If you update to this version from an earlier version, you choose when to update your cluster master and worker nodes. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types) and [Version 1.16](/docs/containers?topic=containers-cs_versions#k8s_version_archive).
{: shortdesc}

### Master patch
{: #1162_1514-master}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Calico | v3.8.2 | v3.9.2 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.9/release-notes/){: external}.|
|CoreDNS |    1.3.1 |    1.6.2 |    See the [CoreDNS release notes](https://coredns.io/2019/08/13/coredns-1.6.2-release/){: external}. This update includes the following configuration changes.  - CoreDNS now runs `3` replica pods by default, and the pods prefer to schedule across worker nodes and zones to improve cluster DNS availability. If you update your cluster to version 1.16 from an earlier version, you can [configure the CoreDNS autoscaler](/docs/containers?topic=containers-cluster_dns#dns_autoscale) to use a minimum of `3` pods. \n - CoreDNS caching is updated to better support older DNS clients. If you disabled the CoreDNS `cache` plug-in, you can now re-enable the plug-in. \n - The CoreDNS deployment is now configured to check readiness by using the `ready` plug-in. \n - CoreDNS version 1.6 no longer supports the `proxy` plug-in, which is replaced by the `forward` plug-in. In addition, the CoreDNS `kubernetes` plug-in no longer supports the `resyncperiod` option and ignores the `upstream` option. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 350 | 351 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.10.|
| Kubernetes | v1.15.5 | v1.16.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.2){: external}. |
| Kubernetes configuration |    N/A |    N/A |    [Kubernetes service account token volume projection](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#service-account-token-volume-projection){: external} is enabled and issues tokens that use `https://kubernetes.default.svc` as the default API audience. |
| Kubernetes admission controllers configuration |    N/A |    N/A |    The `RuntimeClass` admission controller is disabled to align with the `RuntimeClass` feature gate, which was disabled in {{site.data.keyword.containerlong_notm}} version 1.14.|
| Kubernetes Dashboard |    v1.10.1 |    v2.0.0-beta5 |    See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.0.0-beta5){: external}. Unlike the previous version, the new Kubernetes dashboard version works with the `metrics-server` to display metrics. |
| Kubernetes Dashboard metrics scraper |    N/A |    v1.0.2 |    See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.2){: external}.|
| Kubernetes DNS autoscaler |    1.6.0 |    1.7.1 |    See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.7.1){: external}.|
| Operator Lifecycle Manager Catalog |    N/A |    v1.4.0 |    See the [Operator Lifecycle Manager Catalog release notes](https://github.com/operator-framework/operator-registry/releases/tag/v1.4.0){: external}. |
| Operator Lifecycle Manager |    N/A |    0.12.0 |    See the [Operator Lifecycle Manager release notes](https://github.com/operator-framework/operator-lifecycle-manager/releases/tag/0.12.0){: external}.|
{: caption="Master patch: Changes since version 1.15.5_1520" caption-side="bottom"}

### Worker node patch
{: #1162_1514_worker}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|containerd |    v1.2.10 |    v1.3.0 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.3.0){: external}. The containerd configuration now sets `stream_idle_timeout` to `30m`, lowered from `4h`. This `stream_idle_timeout` configuration is the maximum time that a streaming connection such as `kubectl exec` can be idle before the connection is closed. Also, the container runtime type is updated to `io.containerd.runc.v2`. |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Kubernetes | v1.15.5 | v1.16.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.2){: external}. |
{: caption="Worker node patch: Changes since version 1.15.5_1521" caption-side="bottom"}
