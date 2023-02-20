---

copyright:
 years: 2014, 2023
lastupdated: "2023-02-20"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Version 1.14 change log (unsupported 31 May 2020) 
{: #114_changelog}


Version 1.14 is unsupported. You can review the following archive of 1.14 change logs.
{: shortdesc}

## Change log for worker node fix pack 1.14.10_1555, released 26 May 2020
{: #11410_1555}

The following table shows the changes that are in the worker node fix pack `1.14.10_1555`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-99-generic | 4.15.0-101-generic | Updated worker node images with kernel and package updates for [CVE-2019-20795](https://nvd.nist.gov/vuln/detail/CVE-2019-20795){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: caption="Changes since version 1.14.10_1554" caption-side="bottom"}

## Change log for worker node fix pack 1.14.10_1554, released 11 May 2020
{: #11410_1554}

The following table shows the changes that are in the worker node fix pack `1.14.10_1554`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: caption="Changes since version 1.14.10_1553" caption-side="bottom"}

## Change log for worker node fix pack 1.14.10_1553, released 27 April 2020
{: #11410_1553}

The following table shows the changes that are in the worker node fix pack `1.14.10_1553`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: caption="Changes since version 1.14.10_1551" caption-side="bottom"}

## Change log for master fix pack 1.14.10_1552, released 23 April 2020
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
{: caption="Changes since version 1.14.10_1551" caption-side="bottom"}

## Change log for worker node fix pack 1.14.10_1551, released 13 April 2020
{: #11410_1551}

The following table shows the changes that are in the worker node fix pack `1.14.10_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy change logs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: caption="Changes since version 1.14.10_1550" caption-side="bottom"}

## Change log for worker node fix pack 1.14.10_1550, released 30 March 2020
{: #11410_1550}

The following table shows the changes that are in the worker node fix pack `1.14.10_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786){: external}, and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349){: external}, and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: caption="Changes since version 1.14.10_1549" caption-side="bottom"}

## Change log for worker node fix pack 1.14.10_1549, released 16 March 2020
{: #11410_1549}

The following table shows the changes that are in the worker node fix pack 1.14.10_1549. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19923](https://nvd.nist.gov/vuln/detail/CVE-2019-19923){: external}, [CVE-2019-19924](https://nvd.nist.gov/vuln/detail/CVE-2019-19924){: external}, [CVE-2019-19925](https://nvd.nist.gov/vuln/detail/CVE-2019-19925){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, [CVE-2019-19959](https://nvd.nist.gov/vuln/detail/CVE-2019-19959){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13734](https://nvd.nist.gov/vuln/detail/CVE-2019-13734){: external}, [CVE-2019-13750](https://nvd.nist.gov/vuln/detail/CVE-2019-13750){: external}, [CVE-2019-13751](https://nvd.nist.gov/vuln/detail/CVE-2019-13751){: external}, [CVE-2019-13752](https://nvd.nist.gov/vuln/detail/CVE-2019-13752){: external}, [CVE-2019-13753](https://nvd.nist.gov/vuln/detail/CVE-2019-13753){: external}, [CVE-2019-19926](https://nvd.nist.gov/vuln/detail/CVE-2019-19926){: external}, and [CVE-2019-20218](https://nvd.nist.gov/vuln/detail/CVE-2019-20218){: external}. |
{: caption="Changes since version 1.14.10_1548" caption-side="bottom"}

## Change log for worker node fix pack 1.14.10_1548, released 2 March 2020
{: #11410_1548}

The following table shows the changes that are in the worker node fix pack 1.14.10_1548. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.12 | v1.2.13 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.13){: external}. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: caption="Changes since version 1.14.10_1547" caption-side="bottom"}

## Change log for fix pack 1.14.10_1547, released 17 February 2020
{: #11410_1547}

The following table shows the changes that are in the master and worker node fix pack update `1.14.10_1547`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --- | --- | --- | --- | --- |
| containerd | Worker | v1.2.11 | v1.2.12 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.12){: external}. Update resolves [CVE-2019-19921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19921){: external}, [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external}, [CVE-2020-0601](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-0601){: external}, [CVE-2020-7919](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-7919){: external}, and [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external}. |
| GPU device plug-in and installer | Master | da19df3 | 49979f5 | Image updated for [CVE-2016-9840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9840){: external}, [CVE-2016-9841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9841){: external}, [CVE-2016-9842](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9842){: external}, [CVE-2016-9843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-9843){: external}, [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}, [CVE-2018-16888](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16888){: external}, [CVE-2019-20386](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20386){: external}, [CVE-2019-3843](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3843){: external}, [CVE-2019-3844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3844){: external}, and [CVE-2020-1712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1712){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | Master | 357 | 358 | Image updated for [CVE-2019-5188](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5188){: external}. |
| OpenVPN server | Master | N/A | N/A | OpenVPN server is now restarted during [cluster master refresh](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh). |
| Ubuntu 18.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2019-3843](https://nvd.nist.gov/vuln/detail/CVE-2019-3843){: external}, [CVE-2019-3844](https://nvd.nist.gov/vuln/detail/CVE-2019-3844){: external} [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
| Ubuntu 16.04 packages | Worker | N/A | N/A | Updated worker node images with package updates for [CVE-2019-19956](https://nvd.nist.gov/vuln/detail/CVE-2019-19956){: external}, [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595){: external}, [CVE-2019-18634](https://nvd.nist.gov/vuln/detail/CVE-2019-18634){: external}, [CVE-2018-16888](https://nvd.nist.gov/vuln/detail/CVE-2018-16888){: external}, [CVE-2019-20386](https://nvd.nist.gov/vuln/detail/CVE-2019-20386){: external}, and [CVE-2020-1712](https://nvd.nist.gov/vuln/detail/CVE-2020-1712){: external}. |
{: caption="Changes since version 1.14.10_1546" caption-side="bottom"}

## Change log for worker node fix pack 1.14.10_1546, released 3 February 2020
{: #11410_1546}

The following table shows the changes that are in the worker node fix pack 1.14.10_1546.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}{: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: caption="Changes since version 1.14.10_1545" caption-side="bottom"}

## Change log for 1.14.10_1545, released 20 January 2020
{: #11410_1545}

The following table shows the changes that are in the master and worker node patch update 1.14.10_1545. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external} and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 | - Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`. \n - Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot). \n - Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.9-239    | v1.14.10-288 | Updated to support the Kubernetes 1.14.10 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.14.9 |    v1.14.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.10){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: caption="Changes since version 1.14.9_1544" caption-side="bottom"}

## Change log for worker node fix pack 1.14.9_1544, released 23 December 2019
{: #1149_1544}

The following table shows the changes that are in the worker node fix pack 1.14.9_1544.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: caption="Changes since version 1.14.9_1542" caption-side="bottom"}

## Change log for master fix pack 1.14.9_1543, released 17 December 2019
{: #1149_1543}

The following table shows the changes that are in the master fix pack 1.14.9_1543.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: caption="Changes since version 1.14.9_1542" caption-side="bottom"}

## Change log for worker node fix pack 1.14.9_1542, released 9 December 2019
{: #1149_1542_worker}

The following table shows the changes that are in the worker node fix pack 1.14.9_1542.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: caption="Changes since version 1.14.9_1541" caption-side="bottom"}

## Change log for worker node fix pack 1.14.9_1541, released 25 November 2019
{: #1149_1541_worker}

The following table shows the changes that are in the worker node fix pack 1.14.9_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.14.8 | v1.14.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.9){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: caption="Changes since version 1.14.8_1538" caption-side="bottom"}

## Change log for master fix pack 1.14.9_1541, released 21 November 2019
{: #1149_1541}

The following table shows the changes that are in the master fix pack 1.14.9_1541.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor    | 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.14.8-219 | v1.14.9-239 | Updated to support the Kubernetes 1.14.9 release. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.14.8 | v1.14.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.9){: external}. |
{: caption="Changes since version 1.14.8_1538" caption-side="bottom"}

## Change log for worker node fix pack 1.14.8_1538, released 11 November 2019
{: #1148_1538_worker}

The following table shows the changes that are in the worker node fix pack 1.14.8_1538.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: caption="Changes since version 1.14.8_1537" caption-side="bottom"}

## Change log for worker node fix pack 1.14.8_1537, released 28 October 2019
{: #1148_1537}

The following table shows the changes that are in the worker node fix pack `1.14.8_1537`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |    v1.14.7 |    v1.14.8    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.8){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.14.8_1536" caption-side="bottom"}

## Change log for master fix pack 1.14.8_1536, released 22 October 2019
{: #1148_1536}

The following table shows the changes that are in the master fix pack `1.14.8_1536`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration to minimize [cluster service DNS resolution failures when CoreDNS pods are restarted](/docs/containers?topic=containers-coredns_lameduck). Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you don't need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.7-199 | v1.14.8-219 | Updated to support the Kubernetes 1.14.8 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |    v1.14.7 |    v1.14.8    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.8){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/1098759)){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.14.7_1535" caption-side="bottom"}

## Change log for worker node fix pack 1.14.7_1535, released 14 October 2019
{: #1147_1535_worker}

The following table shows the changes that are in the worker node fix pack 1.14.7_1535.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 packages and kernel | 4.4.0-164-generic | 4.4.0-165-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-0136](https://nvd.nist.gov/vuln/detail/CVE-2019-0136){: external}, [CVE-2018-20961](https://nvd.nist.gov/vuln/detail/CVE-2018-20961){: external}, [CVE-2019-11487](https://nvd.nist.gov/vuln/detail/CVE-2019-11487){: external}, [CVE-2016-10905](https://nvd.nist.gov/vuln/detail/CVE-2016-10905){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-64-generic | 4.15.0-65-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}. |
{: caption="Table 1. Changes since version 1.14.7_1534" caption-side="bottom"}

## Change log for 1.14.7_1534, released 1 October 2019
{: #1147_1534}

The following table shows the changes that are in the patch 1.14.7_1534.
{: shortdesc}


| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Calico|v3.6.4|v3.6.5|See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.6/release-notes/){: external}. |
|Cluster master HA configuration|N/A|N/A|Updated configuration to improve performance of master update operations. |
|containerd|v1.2.9|v1.2.10|See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.10){: external}. Update resolves [CVE-2019-16884](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
|Default IBM file storage class|N/A|N/A|Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class. |
|{{site.data.keyword.cloud_notm}} Provider|v1.14.6-172|v1.14.7-199|Updated to support the Kubernetes 1.14.7 release. |
|Key Management Service provider|212|221|Improved Kubernetes [key management service provider](/docs/containers?topic=containers-encryption#keyprotect) caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated. |
|Kubernetes|v1.14.6|v1.14.7|See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.7){: external}. |
|Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider|148|153|Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node. |
|OpenVPN server|2.4.6-r3-IKS-115|2.4.6-r3-IKS-121|Updated images for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external} and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
|Kubernetes|v1.14.6|v1.14.7|See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.7){: external}. |
|Ubuntu 18.04 kernel and packages|4.15.0-62-generic|4.15.0-64-generic|Updated worker node images with kernel and package updates for [CVE-2019-15031](https://nvd.nist.gov/vuln/detail/CVE-2019-15031){: external}, [CVE-2019-15030](https://nvd.nist.gov/vuln/detail/CVE-2019-15030){: external}, and [CVE-2019-14835](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}. |
|Ubuntu 16.04 kernel and packages|4.4.0-161-generic|4.4.0-164-generic|Updated worker node images with kernel and package updates for [CVE-2019-14835](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}. |
{: caption="Changes since version 1.14.6_1533" caption-side="bottom"}

## Change log for worker node fix pack 1.14.6_1533, released 16 September 2019
{: #1146_1533_worker}

The following table shows the changes that are in the worker node fix pack 1.14.6_1533.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | v1.2.8 | v1.2.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.9){: external}. Update resolves [CVE-2019-9515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-159-generic | 4.4.0-161-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2015-9383](https://nvd.nist.gov/vuln/detail/CVE-2015-9383){: external}, [CVE-2019-10638](https://nvd.nist.gov/vuln/detail/CVE-2019-10638){: external}, [CVE-2019-3900](https://nvd.nist.gov/vuln/detail/CVE-2019-3900){: external}, [CVE-2018-20856](https://nvd.nist.gov/vuln/detail/CVE-2018-20856){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2018-20406](https://nvd.nist.gov/vuln/detail/CVE-2018-20406){: external}, and [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-58-generic | 4.15.0-62-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}, and [CVE-2019-15718](https://nvd.nist.gov/vuln/detail/CVE-2019-15718){: external}. |
{: caption="Table 1. Changes since version 1.14.6_1532" caption-side="bottom"}

## Change log for worker node fix pack 1.14.6_1532, released 3 September 2019
{: #1146_1532_worker}

The following table shows the changes that are in the worker node fix pack 1.14.6_1532.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | v1.2.7 | v1.2.8 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.8){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Kubernetes | v1.14.5 | v1.14.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.6){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-10222](https://nvd.nist.gov/vuln/detail/CVE-2019-10222){: external} and [CVE-2019-11922](https://nvd.nist.gov/vuln/detail/CVE-2019-11922){: external}. |
{: caption="Table 1. Changes since version 1.14.5_1530" caption-side="bottom"}


## Change log for master fix pack 1.14.6_1531, released 28 August 2019
{: #1146_1531}

The following table shows the changes that are in the master fix pack 1.14.6_1531.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| etcd | v3.3.13 | v3.3.15 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.15){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| GPU device plug-in and installer | 07c9b67 | de13f2a | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. Updated the GPU drivers to [430.40](https://www.nvidia.com/Download/driverResults.aspx/149138/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 348 | 349 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.5-160 | v1.14.6-172 | Updated to support the Kubernetes 1.14.6 release. |
| Key Management Service provider | 207 | 212 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Kubernetes | v1.14.5 | v1.14.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.6){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 147 | 148 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
{: caption="Table 1. Changes since version 1.14.5_1530" caption-side="bottom"}


## Change log for worker node fix pack 1.14.5_1530, released 19 August 2019
{: #1145_1530_worker}

The following table shows the changes that are in the worker node fix pack 1.14.5_1530.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 2.0.1-alpine | 1.8.21-alpine | Moved to HA proxy 1.8 to fix [socket leak in HA proxy](https://github.com/haproxy/haproxy/issues/136){: external}. Also added a liveliness check to monitor the health of HA proxy. For more information, see [HA proxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. |
| Kubernetes | v1.14.4 | v1.14.5 | For more information, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.5){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-157-generic | 4.4.0-159-generic | Updated worker node images with package updates for [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, and [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}. |
| Ubuntu 18.04 kernel and packages | 4.15.0-55-generic | 4.15.0-58-generic | Updated worker node images with package updates for [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2019-2101](https://nvd.nist.gov/vuln/detail/CVE-2019-2101){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-13233](https://nvd.nist.gov/vuln/detail/CVE-2019-13233){: external}, [CVE-2019-13272](https://nvd.nist.gov/vuln/detail/CVE-2019-13272){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}, [CVE-2019-12818](https://nvd.nist.gov/vuln/detail/CVE-2019-12818){: external}, [CVE-2019-12984](https://nvd.nist.gov/vuln/detail/CVE-2019-12984){: external}, and [CVE-2019-12819](https://nvd.nist.gov/vuln/detail/CVE-2019-12819){: external}. |
{: caption="Table 1. Changes since version 1.14.4_1527" caption-side="bottom"}


## Change log for master fix pack 1.14.5_1530, released 17 August 2019
{: #1145_1530}

The following table shows the changes that are in the master fix pack 1.14.5_1530.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Key Management Service provider | 167 | 207 | Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets. |
{: caption="Table 1. Changes since version 1.14.5_1529" caption-side="bottom"}


## Change log for master fix pack 1.14.5_1529, released 15 August 2019
{: #1145_1529}

The following table shows the changes that are in the master fix pack 1.14.5_1529.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico configuration | N/A | N/A | Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container. |
| Cluster health | N/A | N/A | Cluster health shows `Warning` state if a cluster control plane operation failed or was canceled. For more information, see [Debugging clusters](/docs/containers?topic=containers-debug_clusters). |
| GPU device plug-in and installer | a7e8ece | 07c9b67 | Image updated for [CVE-2019-9924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924){: external} and [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 347 | 348 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.4-139 | v1.14.5-160 | Updated to support the Kubernetes 1.14.5 release. |
| Kubernetes | v1.14.4 | v1.14.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.5){: external}. Updates resolves [CVE-2019-11247](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967115){: external}) and [CVE-2019-11249](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967123){: external}). |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 146 | 147 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-13 | 2.4.6-r3-IKS-116 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-25 | 2.4.6-r3-IKS-115 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
{: caption="Table 1. Changes since version 1.14.4_1527" caption-side="bottom"}


## Change log for worker node fix pack 1.14.4_1527, released 5 August 2019
{: #1144_1527_worker}

The following table shows the changes that are in the worker node fix pack 1.14.4_1527.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 18.04 kernel and packages | 4.15.0-54-generic | 4.15.0-55-generic | Updated worker node images with package updates for [CVE-2019-11085](https://nvd.nist.gov/vuln/detail/CVE-2019-11085){: external}, [CVE-2019-11815](https://nvd.nist.gov/vuln/detail/CVE-2019-11815){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-11884](https://nvd.nist.gov/vuln/detail/CVE-2019-11884){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, and [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-154-generic | 4.4.0-157-generic | Updated worker node images with package updates for [CVE-2019-2054](https://nvd.nist.gov/vuln/detail/CVE-2019-2054){: external}, [CVE-2019-11815](https://nvd.nist.gov/vuln/detail/CVE-2019-11815){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-11884](https://nvd.nist.gov/vuln/detail/CVE-2019-11884){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, and [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}. |
{: caption="Table 1. Changes since version 1.14.4_1526" caption-side="bottom"}

## Change log for worker node fix pack 1.14.4_1526, released 22 July 2019
{: #1144_1526_worker}

The following table shows the changes that are in the worker node fix pack 1.14.4_1526.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.14.3 | v1.14.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.4){: external}. Update resolves [CVE-2019-11248](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248){: external}. For more information, see [IBM security bulletin](https://www.ibm.com/support/pages/node/967113){: external}). |
| Ubuntu packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13012](https://ubuntu.com/security/CVE-2019-13012){: external} and [CVE-2019-7307](https://ubuntu.com/security/CVE-2019-7307.html){: external}. |
{: caption="Table 1. Changes since version 1.14.3_1525" caption-side="bottom"}



## Change log for master fix pack 1.14.4_1526, released 15 July 2019
{: #1144_1526}

The following table shows the changes that are in the master fix pack 1.14.4_1526.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.6.1 | v3.6.4 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/){: external}. Update resolves [TTA-2019-001](https://www.tigera.io/security-bulletins/#TTA-2019-001){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/959551){: external}. |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the `kubernetes` zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider}(/docs/containers?topic=containers-cluster_dns#dns_customize). |
| GPU device plug-in and installer | 5d34347 | a7e8ece | Updated base image packages. |
| Kubernetes | v1.14.3 | v1.14.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.4){: external}.
| {{site.data.keyword.cloud_notm}} Provider | v1.14.3-113 | v1.14.4-139 | Updated to support the Kubernetes 1.14.4 release. Additionally, `calicoctl` version is updated to 3.6.4. |
{: caption="Table 1. Changes since version 1.14.3_1525" caption-side="bottom"}

## Change log for worker node fix pack 1.14.3_1525, released 8 July 2019
{: #1143_1525}

The following table shows the changes that are in the worker node patch 1.14.3_1525.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-151-generic | 4.4.0-154-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-52-generic | 4.15.0-54-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
{: caption="Table 1. Changes since version 1.14.3_1524" caption-side="bottom"}

## Change log for worker node fix pack 1.14.3_1524, released 24 June 2019
{: #1143_1524}

The following table shows the changes that are in the worker node patch 1.14.3_1524.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-150-generic | 4.4.0-151-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-51-generic | 4.15.0-52-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| containerd | 1.2.6 | 1.2.7 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.7){: external}. |
| Max pods | N/A | N/A | Increased the limit of maximum number of pods for worker nodes with more than 11 CPU cores to be 10 pods per core, up to a maximum of 250 pods per worker node. |
{: caption="Table 1. Changes since version 1.14.3_1524" caption-side="bottom"}

## Change log for 1.14.3_1523, released 17 June 2019
{: #1143_1523}

The following table shows the changes that are in the patch 1.14.3_1523.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| GPU device plug-in and installer | 32257d3 | 5d34347 | Updated image for [CVE-2019-8457](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457){: external}. Updated the GPU drivers to [430.14](https://www.nvidia.com/Download/driverResults.aspx/147582/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 346 | 347 | Updated so that the IAM API key can be either encrypted or unencrypted.
| {{site.data.keyword.cloud_notm}} Provider | v1.14.2-100 | v1.14.3-113 | Updated to support the Kubernetes 1.14.3 release. |
| Kubernetes | v1.14.2 | v1.14.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.3){: external}. |
| Kubernetes feature gates configuration | N/A | N/A | Added the `SupportNodePidsLimit=true` configuration to reserve process IDs (PIDs) for use by the operating system and Kubernetes components. Added the `CustomCPUCFSQuotaPeriod=true` configuration to mitigate CPU throttling problems. |
| Public service endpoint for Kubernetes master | N/A | N/A | Fixed an issue to [enable the public cloud service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se). |
| Ubuntu 16.04 kernel | 4.4.0-148-generic | 4.4.0-150-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-50-generic | 4.15.0-51-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
{: caption="Table 1. Changes since version 1.14.2_1521" caption-side="bottom"}

## Change log for 1.14.2_1521, released 4 June 2019
{: #1142_1521}

The following table shows the changes that are in the patch 1.14.2_1521.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS configuration | N/A | N/A | Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster `create` or `update` operations. |
| Cluster master HA configuration | N/A | N/A | Updated configuration to minimize intermittent master network connectivity failures during a master update. |
| etcd | v3.3.11 | v3.3.13 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.13){: external}. |
| GPU device plug-in and installer | 55c1f66 | 32257d3 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.1-71 | v1.14.2-100 | Updated to support the Kubernetes 1.14.2 release. |
| Kubernetes | v1.14.1 | v1.14.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.2){: external}. |
| Kubernetes Metrics Server | v0.3.1 | v0.3.3 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3){: external}. |
| Trusted compute agent | 13c7ef0 | e8c6d72 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
{: caption="Table 1. Changes since version 1.14.1_1519" caption-side="bottom"}


## Change log for worker node fix pack 1.14.1_1519, released 20 May 2019
{: #1141_1519}

The following table shows the changes that are in the patch 1.14.1_1519.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-145-generic | 4.4.0-148-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-47-generic | 4.15.0-50-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
{: caption="Table 1. Changes since version 1.14.1_1518" caption-side="bottom"}


## Change log for 1.14.1_1518, released 13 May 2019
{: #1141_1518}

The following table shows the changes that are in the patch 1.14.1_1518.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 1.9.6-alpine | 1.9.7-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2019-6706](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years. |
| OpenVPN client configuration | N/A | N/A | The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down. |
| Trusted compute agent | e7182c7 | 13c7ef0 | Updated image for [CVE-2016-7076](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076){: external} and [CVE-2017-1000368](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368){: external}. |
{: caption="Table 1. Changes since version 1.14.1_1516" caption-side="bottom"}

## Change log for 1.14.1_1516, released 7 May 2019
{: #1141_1516}

The following table shows the changes that are in the patch 1.14.1_1516.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.4.4 | v3.6.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.6/release-notes/){: external}. |
| CoreDNS | 1.2.6 | 1.3.1 | See the [CoreDNS release notes](https://coredns.io/2019/01/13/coredns-1.3.1-release/){: external}. The update includes the addition of a [metrics port](https://coredns.io/plugins/metrics/){: external} on the cluster DNS service.  \n CoreDNS is now the only supported cluster DNS provider. If you update a cluster to Kubernetes version 1.14 from an earlier version and used KubeDNS, KubeDNS is automatically migrated to CoreDNS during the cluster update. For more information or to test out CoreDNS before you update, see [Configure the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#cluster_dns). |
| GPU device plug-in and installer | 9ff3fda | ed0dafc | Updated image for [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.13.5-107 | v1.14.1-71 | Updated to support the Kubernetes 1.14.1 release. Additionally, `calicoctl` version is updated to 3.6.1. Fixed updates to version 2.0 network load balancers (NLBs) with only one available worker node for the load balancer pods. Private load balancers now support running on [private edge workers nodes](/docs/containers?topic=containers-edge#edge). |
| IBM pod security policies | N/A | N/A | [IBM pod security policies](/docs/containers?topic=containers-psp#ibm_psp) are updated to support the Kubernetes [RunAsGroup](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external} feature. |
| `kubelet` configuration | N/A | N/A | Set the `--pod-max-pids` option to `14336` to prevent a single pod from consuming all process IDs on a worker node. |
| Kubernetes | v1.13.5 | v1.14.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.1){: external} and [Kubernetes 1.14 blog](https://kubernetes.io/blog/2019/03/25/kubernetes-1-14-release-announcement/){: external}.  \n The Kubernetes default role-based access control (RBAC) policies no longer grant access to [discovery and permission-checking APIs to unauthenticated users](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles){: external}. This change applies only to new version 1.14 clusters. If you update a cluster from a prior version, unauthenticated users still have access to the discovery and permission-checking APIs. |
| Kubernetes admission controllers configuration | N/A | N/A |  - Added `NodeRestriction` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the related cluster resources to support this security enhancement. \n - Removed `Initializers` from the `--enable-admission-plugins` option and `admissionregistration.k8s.io/v1alpha1=true` from the `--runtime-config` option for the cluster's Kubernetes API server because these APIs are no longer supported. Instead, you can use [Kubernetes admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external}. |
| Kubernetes DNS autoscaler | 1.3.0 | 1.4.0 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.4.0){: external}. |
| Kubernetes feature gates configuration | N/A | N/A |  - Added `RuntimeClass=false` to disable selection of the container runtime configuration. \n - Removed `ExperimentalCriticalPodAnnotation=true` because the `scheduler.alpha.kubernetes.io/critical-pod` pod annotation is no longer supported. Instead, you can use [Kubernetes pod priority](/docs/containers?topic=containers-pod_priority#pod_priority){: external}. |
| Trusted compute agent | e132aa4 | e7182c7 | Updated image for [CVE-2019-11068](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068){: external}. |
{: caption="Table 1. Changes since version 1.13.5_1519" caption-side="bottom"}

