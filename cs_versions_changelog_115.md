---

copyright:
 years: 2014, 2022
lastupdated: "2022-12-01"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Version 1.15 changelog (unsupported 22 September 2020)
{: #115_changelog}

Version 1.15 is unsupported. You can review the following archive of 1.15 changelogs.
{: shortdesc}

## Change log for worker node fix pack 1.15.12_1552, released 14 September 2020
{: #11512_1552}

The following table shows the changes that are in the worker node fix pack `1.15.12_1552`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-384f42 | 1.8.26-561f1a | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.|
| Ubuntu 18.04 packages | 4.15.0-112-generic | 4.15.0-117-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external}, [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}, and [CVE-2020-14386](https://nvd.nist.gov/vuln/detail/CVE-2020-14386){: external}. |
| Ubuntu 16.04 packages | 4.4.0-187-generic | 4.4.0-189-generic | Updated worker node image with kernel and package updates for [CVE-2020-14344](https://nvd.nist.gov/vuln/detail/CVE-2020-14344){: external} and [CVE-2020-14363](https://nvd.nist.gov/vuln/detail/CVE-2020-14363){: external}. |
{: caption="Changes since version 1.15.12_1551" caption-side="bottom"}

## Change log for worker node fix pack 1.15.12_1551, released 31 August 2020
{: #11512_1551}

The following table shows the changes that are in the worker node fix pack `1.15.12_1551`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-12403](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12403){: external}, [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}, and [CVE-2020-8624](https://nvd.nist.gov/vuln/detail/CVE-2020-8624){: external}. |
| Ubuntu 16.04 packages | 4.4.0-186-generic | 4.4.0-187-generic | Updated worker node image with kernel and package updates for [CVE-2020-8231](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8231){: external}, [CVE-2020-8622](https://nvd.nist.gov/vuln/detail/CVE-2020-8622){: external}, and [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623){: external}. |
{: caption="Changes since version 1.15.12_1550" caption-side="bottom"}

## Change log for master fix pack 1.15.12_1550, released 18 August 2020
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
{: caption="Changes since version 1.15.12_1549" caption-side="bottom"}

## Change log for worker node fix pack 1.15.12_1550, released 17 August 2020
{: #11512_1550}

The following table shows the changes that are in the worker node fix pack `1.15.12_1550`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-12400](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12400){: external}, [CVE-2020-12401](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12401){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}, and [CVE-2020-6829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6829){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node image with package updates for [CVE-2020-11936](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11936){: external}, [CVE-2020-15701](https://nvd.nist.gov/vuln/detail/CVE-2020-15701){: external}, [CVE-2020-15702](https://nvd.nist.gov/vuln/detail/CVE-2020-15702){: external}, and [CVE-2020-15709](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-15709){: external}. |
{: caption="Changes since version 1.15.12_1549" caption-side="bottom"}

## Change log for worker node fix pack 1.15.12_1549, released 3 August 2020
{: #11512_1549}

The following table shows the changes that are in the worker node fix pack `1.15.12_1549`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-111-generic | 4.15.0-112-generic | Updated worker node images with kernel and package updates for [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-10757](https://nvd.nist.gov/vuln/detail/CVE-2020-10757){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
| Ubuntu 16.04 packages | 4.4.0-185-generic | 4.4.0-186-generic | Updated worker node images with package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-17514](https://nvd.nist.gov/vuln/detail/CVE-2019-17514){: external}, [CVE-2019-20907](https://nvd.nist.gov/vuln/detail/CVE-2019-20907){: external}, [CVE-2019-9674](https://nvd.nist.gov/vuln/detail/CVE-2019-9674){: external}, [CVE-2020-10713](https://nvd.nist.gov/vuln/detail/CVE-2020-10713){: external}, [CVE-2020-11935](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-11935){: external}, [CVE-2020-14308](https://nvd.nist.gov/vuln/detail/CVE-2020-14308){: external}, [CVE-2020-14309](https://nvd.nist.gov/vuln/detail/CVE-2020-14309){: external}, [CVE-2020-14310](https://nvd.nist.gov/vuln/detail/CVE-2020-14310){: external}, [CVE-2020-14311](https://nvd.nist.gov/vuln/detail/CVE-2020-14311){: external}, [CVE-2020-14422](https://nvd.nist.gov/vuln/detail/CVE-2020-14422){: external}, [CVE-2020-15705](https://nvd.nist.gov/vuln/detail/CVE-2020-15705){: external}, [CVE-2020-15706](https://nvd.nist.gov/vuln/detail/CVE-2020-15706){: external}, and [CVE-2020-15707](https://nvd.nist.gov/vuln/detail/CVE-2020-15707){: external}. |
{: caption="Changes since version 1.15.12_1546" caption-side="bottom"}

## Change log for master fix pack 1.15.12_1548, released 24 July 2020
{: #11512_1548}

The following table shows the changes that are in the master fix pack patch update `1.15.12_1548`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Cluster master operations | N/A | N/A | Fixed a problem that might cause pods to fail authentication to the Kubernetes API server after a cluster master operation. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 375 | 376 | Updated to use `Go` version 1.13.8. |
{: caption="Changes since version 1.15.12_1547" caption-side="bottom"}

## Change log for master fix pack 1.15.12_1547, released 20 July 2020
{: #11512_1547}

The following table shows the changes that are in the master fix pack patch update `1.15.12_1547`. Master patch updates are applied automatically.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| GPU device plug-in and installer | 31d4bb6 | 8c24345 | Updated image for [CVE-2017-12133](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12133){: external}, [CVE-2017-18269](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18269){: external}, [CVE-2018-11236](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11236){: external}, [CVE-2018-11237](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-11237){: external}, [CVE-2018-19591](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19591){: external}, [CVE-2018-6485](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6485){: external}, [CVE-2019-19126](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19126){: external}, [CVE-2019-9169](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9169){: external}, [CVE-2020-10029](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10029){: external}, [CVE-2020-1751](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1751){: external}, and [CVE-2020-1752](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1752){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor configuration | N/A | N/A | Added a pod memory limit. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `scheduling.k8s.io` API group and the `tokenreviews` resource. |
{: caption="Changes since version 1.15.12_1544" caption-side="bottom"}

## Change log for worker node fix pack 1.15.12_1546, released 20 July 2020
{: #11512_1546}

The following table shows the changes that are in the worker node fix pack `1.15.12_1546`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 2.0.15-afe432 | 1.8.25-384f42 | See the [HAProxy changelog](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Fixes a connection leak that happens when HAProxy is under high load. |
| Ubuntu 18.04 packages | 4.15.0-109-generic | 4.15.0-111-generic | Updated worker node images with kernel and package updates for [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-19591](https://nvd.nist.gov/vuln/detail/CVE-2018-19591){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-12402](https://nvd.nist.gov/vuln/detail/CVE-2020-12402){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
| Ubuntu 16.04 packages | 4.4.0-184-generic | 4.4.0-185-generic | Updated worker node images with package updates for [CVE-2017-12133](https://nvd.nist.gov/vuln/detail/CVE-2017-12133){: external}, [CVE-2017-18269](https://nvd.nist.gov/vuln/detail/CVE-2017-18269){: external}, [CVE-2018-11236](https://nvd.nist.gov/vuln/detail/CVE-2018-11236){: external}, [CVE-2018-11237](https://nvd.nist.gov/vuln/detail/CVE-2018-11237){: external}, [CVE-2018-6485](https://nvd.nist.gov/vuln/detail/CVE-2018-6485){: external}, [CVE-2019-19126](https://nvd.nist.gov/vuln/detail/CVE-2019-19126){: external}, [CVE-2019-9169](https://nvd.nist.gov/vuln/detail/CVE-2019-9169){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10029](https://nvd.nist.gov/vuln/detail/CVE-2020-10029){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-1751](https://nvd.nist.gov/vuln/detail/CVE-2020-1751){: external}, and [CVE-2020-1752](https://nvd.nist.gov/vuln/detail/CVE-2020-1752){: external}. |
{: caption="Changes since version 1.15.12_1544" caption-side="bottom"}

## Change log for worker node fix pack 1.15.12_1544, released 6 July 2020
{: #11512_1544}

The following table shows the changes that are in the worker node fix pack `1.15.12_1544`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HAProxy | 1.8.25-30b675 | 2.0.15-afe432 | See the [HAProxy changelog](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}. |
| Ubuntu 18.04 packages | 4.15.0-106-generic | 4.15.0-109-generic | Updated worker node images with kernel and package updates for [CVE-2019-12380](https://nvd.nist.gov/vuln/detail/CVE-2019-12380){: external}, [CVE-2019-16089](https://nvd.nist.gov/vuln/detail/CVE-2019-16089){: external}, [CVE-2019-19036](https://nvd.nist.gov/vuln/detail/CVE-2019-19036){: external}, [CVE-2019-19039](https://nvd.nist.gov/vuln/detail/CVE-2019-19039){: external}, [CVE-2019-19318](https://nvd.nist.gov/vuln/detail/CVE-2019-19318){: external}, [CVE-2019-19642](https://nvd.nist.gov/vuln/detail/CVE-2019-19642){: external}, [CVE-2019-19813](https://nvd.nist.gov/vuln/detail/CVE-2019-19813){: external}, [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-10711](https://nvd.nist.gov/vuln/detail/CVE-2020-10711){: external}, [CVE-2020-13143](https://nvd.nist.gov/vuln/detail/CVE-2020-13143){: external}, [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}, [CVE-2019-19377](https://nvd.nist.gov/vuln/detail/CVE-2019-19377){: external}, and [CVE-2019-19816](https://nvd.nist.gov/vuln/detail/CVE-2019-19816){: external}. |
| Ubuntu 16.04 packages |N/A |N/A | Updated worker node images with package updates for [CVE-2019-3689](https://nvd.nist.gov/vuln/detail/CVE-2019-3689){: external} and [CVE-2020-8177](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-8177){: external}. |
| Worker node `drain` automation | N/A| N/A| Fixes a race condition that can cause worker node `drain` automation to fail. |
{: caption="Changes since version 1.15.12_1543" caption-side="bottom"}

## Change log for 1.15.12_1543, released 22 June 2020
{: #11512_1543}

The following table shows the changes that are in the master and worker node update `1.15.12_1543`. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Location | Previous | Current | Description |
| --------- | -------- | ------- | -------- | ----------- |
| Calico | Master | v3.8.6 | v3.8.9 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. The master update resolves CVE-2020-13597 (see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6226322){: external}). |
| Cluster health image | Master | v1.1.5 | v1.1.8 | Additional status information is included when an add-on health state is `critical`. Improved performance when handling cluster status updates. |
| Cluster master operations | Master | N/A | N/A | Cluster master operations such as `refresh` or `update` are now canceled if a broken [Kubernetes admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/){: external} is detected. |
| etcd | Master | v3.3.20 | v3.3.22 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.22){: external}. |
| GPU device plug-in and installer | Master | 8b02302 | 31d4bb6 | Updated image for [CVE-2020-3810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-3810){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | Master | 373 | 375 | Fixed a bug that might cause error handling to create additional persistent volumes. |
| {{site.data.keyword.cloud_notm}} Provider | Master | v1.15.12-316 | v1.15.12-343 | Updated `calicoctl` version to 3.8.9. |
| Kubernetes configuration | Master | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include auditing the `apiextensions.k8s.io` API group and the `persistentvolumeclaims` and `persistentvolumes` resources. Additionally, the `http2-max-streams-per-connection` option is set to `1000` to mitigate network disruption impacts on the `kubelet` connection to the API server. |
| Ubuntu 18.04 packages | Worker | 4.15.0-101-generic | 4.15.0-106-generic | Updated worker node images with kernel and package updates for [CVE-2018-8740](https://nvd.nist.gov/vuln/detail/CVE-2018-8740){: external}, [CVE-2019-17023](https://nvd.nist.gov/vuln/detail/CVE-2019-17023){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-12399](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12399){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and [CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
| Ubuntu 16.04 packages | Worker | 4.4.0-179-generic | 4.4.0-184-generic | Updated worker node images with package and kernel updates for [CVE-2020-12049](https://nvd.nist.gov/vuln/detail/CVE-2020-12049){: external}, [CVE-2020-0543](https://nvd.nist.gov/vuln/detail/CVE-2020-0543){: external}, [CVE-2020-12769](https://nvd.nist.gov/vuln/detail/CVE-2020-12769){: external}, [CVE-2020-1749](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1749){: external}, [CVE-2020-13434](https://nvd.nist.gov/vuln/detail/CVE-2020-13434){: external}, [CVE-2020-13630](https://nvd.nist.gov/vuln/detail/CVE-2020-13630){: external}, and[CVE-2020-13632](https://nvd.nist.gov/vuln/detail/CVE-2020-13632){: external}. |
{: caption="Changes since version 1.15.12_1541" caption-side="bottom"}

## Change log for worker node fix pack 1.15.12_1541, released 8 June 2020
{: #11512_1541}

The following table shows the changes that are in the worker node fix pack `1.15.12_1541`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1549](https://nvd.nist.gov/vuln/detail/CVE-2019-1549){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
| Ubuntu 16.04 packages | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-1547](https://nvd.nist.gov/vuln/detail/CVE-2019-1547){: external}, [CVE-2019-1551](https://nvd.nist.gov/vuln/detail/CVE-2019-1551){: external}, [CVE-2019-1563](https://nvd.nist.gov/vuln/detail/CVE-2019-1563){: external}, and [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}. |
{: caption="Changes since version 1.15.12_1540" caption-side="bottom"}

## Change log for 1.15.12_1540, released 26 May 2020
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
| Ubuntu 16.04 packages | Worker | 4.4.0-178-generic | 4.4.0-179-generic | Updated worker node images with package and kernel updates for [CVE-2019-19060](https://nvd.nist.gov/vuln/detail/CVE-2019-19060){: external}, [CVE-2020-11494](https://nvd.nist.gov/vuln/detail/CVE-2020-11494){: external}, [CVE-2020-11608](https://nvd.nist.gov/vuln/detail/CVE-2020-11608){: external}, [CVE-2020-12762](https://nvd.nist.gov/vuln/detail/CVE-2020-12762){: external}, [CVE-2020-3810](https://nvd.nist.gov/vuln/detail/CVE-2020-3810){: external}, [CVE-2020-8616](https://nvd.nist.gov/vuln/detail/CVE-2020-8616){: external}, and [CVE-2020-8617](https://nvd.nist.gov/vuln/detail/CVE-2020-8617){: external}. |
{: caption="Changes since version 1.15.11_1538" caption-side="bottom"}

## Change log for worker node fix pack 1.15.11_1538, released 11 May 2020
{: #11511_1538}

The following table shows the changes that are in the worker node fix pack `1.15.11_1538`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-96-generic | 4.15.0-99-generic | Updated worker node images with kernel and package updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external}, [CVE-2020-11884](https://nvd.nist.gov/vuln/detail/CVE-2020-11884){: external}, and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
| Ubuntu 16.04 packages | 4.4.0-177-generic | 4.4.0-178-generic | Updated worker node images with package and kernel updates for [CVE-2019-19768](https://nvd.nist.gov/vuln/detail/CVE-2019-19768){: external} and [CVE-2020-12243](https://nvd.nist.gov/vuln/detail/CVE-2020-12243){: external}. |
{: caption="Changes since version 1.15.11_1537" caption-side="bottom"}

## Change log for worker node fix pack 1.15.11_1537, released 27 April 2020
{: #11511_1537}

The following table shows the changes that are in the worker node fix pack `1.15.11_1537`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.25-30b675 | 1.8.25-adb65d | The update addresses [CVE-2020-1967](https://nvd.nist.gov/vuln/detail/CVE-2020-1967){: external}. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2018-1000876](https://nvd.nist.gov/vuln/detail/CVE-2018-1000876){: external}, [CVE-2018-10372](https://nvd.nist.gov/vuln/detail/CVE-2018-10372){: external}, [CVE-2018-10373](https://nvd.nist.gov/vuln/detail/CVE-2018-10373){: external}, [CVE-2018-10534](https://nvd.nist.gov/vuln/detail/CVE-2018-10534){: external}, [CVE-2018-10535](https://nvd.nist.gov/vuln/detail/CVE-2018-10535){: external}, [CVE-2018-12641](https://nvd.nist.gov/vuln/detail/CVE-2018-12641){: external}, [CVE-2018-12697](https://nvd.nist.gov/vuln/detail/CVE-2018-12697){: external}, [CVE-2018-12698](https://nvd.nist.gov/vuln/detail/CVE-2018-12698){: external}, [CVE-2018-12699](https://nvd.nist.gov/vuln/detail/CVE-2018-12699){: external}, [CVE-2018-12700](https://nvd.nist.gov/vuln/detail/CVE-2018-12700){: external}, [CVE-2018-12934](https://nvd.nist.gov/vuln/detail/CVE-2018-12934){: external}, [CVE-2018-13033](https://nvd.nist.gov/vuln/detail/CVE-2018-13033){: external}, [CVE-2018-17358](https://nvd.nist.gov/vuln/detail/CVE-2018-17358){: external}, [CVE-2018-17359](https://nvd.nist.gov/vuln/detail/CVE-2018-17359){: external}, [CVE-2018-17360](https://nvd.nist.gov/vuln/detail/CVE-2018-17360){: external}, [CVE-2018-17794](https://nvd.nist.gov/vuln/detail/CVE-2018-17794){: external}, [CVE-2018-17985](https://nvd.nist.gov/vuln/detail/CVE-2018-17985){: external}, [CVE-2018-18309](https://nvd.nist.gov/vuln/detail/CVE-2018-18309){: external}, [CVE-2018-18483](https://nvd.nist.gov/vuln/detail/CVE-2018-18483){: external}, [CVE-2018-18484](https://nvd.nist.gov/vuln/detail/CVE-2018-18484){: external}, [CVE-2018-18605](https://nvd.nist.gov/vuln/detail/CVE-2018-18605){: external}, [CVE-2018-18606](https://nvd.nist.gov/vuln/detail/CVE-2018-18606){: external}, [CVE-2018-18607](https://nvd.nist.gov/vuln/detail/CVE-2018-18607){: external}, [CVE-2018-18700](https://nvd.nist.gov/vuln/detail/CVE-2018-18700){: external}, [CVE-2018-18701](https://nvd.nist.gov/vuln/detail/CVE-2018-18701){: external}, [CVE-2018-19931](https://nvd.nist.gov/vuln/detail/CVE-2018-19931){: external}, [CVE-2018-19932](https://nvd.nist.gov/vuln/detail/CVE-2018-19932){: external}, [CVE-2018-20002](https://nvd.nist.gov/vuln/detail/CVE-2018-20002){: external}, [CVE-2018-20623](https://nvd.nist.gov/vuln/detail/CVE-2018-20623){: external}, [CVE-2018-20651](https://nvd.nist.gov/vuln/detail/CVE-2018-20651){: external}, [CVE-2018-20671](https://nvd.nist.gov/vuln/detail/CVE-2018-20671){: external}, [CVE-2018-8945](https://nvd.nist.gov/vuln/detail/CVE-2018-8945){: external}, [CVE-2018-9138](https://nvd.nist.gov/vuln/detail/CVE-2018-9138){: external}, [CVE-2019-12972](https://nvd.nist.gov/vuln/detail/CVE-2019-12972){: external}, [CVE-2019-14250](https://nvd.nist.gov/vuln/detail/CVE-2019-14250){: external}, [CVE-2019-14444](https://nvd.nist.gov/vuln/detail/CVE-2019-14444){: external}, [CVE-2019-17450](https://nvd.nist.gov/vuln/detail/CVE-2019-17450){: external}, [CVE-2019-17451](https://nvd.nist.gov/vuln/detail/CVE-2019-17451){: external}, [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2019-9070](https://nvd.nist.gov/vuln/detail/CVE-2019-9070){: external}, [CVE-2019-9071](https://nvd.nist.gov/vuln/detail/CVE-2019-9071){: external}, [CVE-2019-9073](https://nvd.nist.gov/vuln/detail/CVE-2019-9073){: external}, [CVE-2019-9074](https://nvd.nist.gov/vuln/detail/CVE-2019-9074){: external}, [CVE-2019-9075](https://nvd.nist.gov/vuln/detail/CVE-2019-9075){: external}, [CVE-2019-9077](https://nvd.nist.gov/vuln/detail/CVE-2019-9077){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-18348](https://nvd.nist.gov/vuln/detail/CVE-2019-18348){: external}, [CVE-2020-11008](https://nvd.nist.gov/vuln/detail/CVE-2020-11008){: external}, [CVE-2020-5260](https://nvd.nist.gov/vuln/detail/CVE-2020-5260){: external}, and [CVE-2020-8492](https://nvd.nist.gov/vuln/detail/CVE-2020-8492){: external}. |
{: caption="Changes since version 1.15.11_1535" caption-side="bottom"}

## Change log for master fix pack 1.15.11_1536, released 23 April 2020
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
{: caption="Changes since version 1.15.11_1535" caption-side="bottom"}

## Change log for worker node fix pack 1.15.11_1535, released 13 April 2020
{: #11511_1535}

The following table shows the changes that are in the worker node fix pack `1.15.11_1535`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| HA proxy | 1.8.23 | 1.8.25 | See the [HA proxy changelogs](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. The update addresses [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}. |
| Ubuntu 18.04 packages | 4.15.0-91-generic | 4.15.0-96-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, [CVE-2020-11100](https://nvd.nist.gov/vuln/detail/CVE-2020-11100){: external}, and [CVE-2020-8834](https://nvd.nist.gov/vuln/detail/CVE-2020-8834){: external}. |
| Ubuntu 16.04 packages | 4.4.0-176-generic | 4.4.0-177-generic | Updated worker node images with package and kernel updates for [CVE-2020-8831](https://nvd.nist.gov/vuln/detail/CVE-2020-8831){: external}, [CVE-2020-8833](https://nvd.nist.gov/vuln/detail/CVE-2020-8833){: external}, and [CVE-2020-8428](https://nvd.nist.gov/vuln/detail/CVE-2020-8428){: external}. |
{: caption="Changes since version 1.15.11_1534" caption-side="bottom"}

## Change log for worker node fix pack 1.15.11_1534, released 30 March 2020
{: #11511_1534}

The following table shows the changes that are in the worker node fix pack `1.15.11_1534`. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-88-generic | 4.15.0-91-generic | Updated worker node images with package and kernel updates for [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700){: external}, [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2020-8832](https://nvd.nist.gov/vuln/detail/CVE-2020-8832){: external}, [CVE-2019-12387](https://nvd.nist.gov/vuln/detail/CVE-2019-12387){: external}, [CVE-2019-12855](https://nvd.nist.gov/vuln/detail/CVE-2019-12855){: external}, [CVE-2019-9512](https://nvd.nist.gov/vuln/detail/CVE-2019-9512){: external}, [CVE-2019-9514](https://nvd.nist.gov/vuln/detail/CVE-2019-9514){: external}, [CVE-2019-9515](https://nvd.nist.gov/vuln/detail/CVE-2019-9515){: external}, [CVE-2020-10108](https://nvd.nist.gov/vuln/detail/CVE-2020-10108){: external}, [CVE-2020-10109](https://nvd.nist.gov/vuln/detail/CVE-2020-10109){: external}, [CVE-2018-20786](https://nvd.nist.gov/vuln/detail/CVE-2018-20786){: external}, and [CVE-2019-20079](https://nvd.nist.gov/vuln/detail/CVE-2019-20079){: external}. |
| Ubuntu 16.04 packages |4.4.0-174-generic | 4.4.0-176-generic | Updated worker node images with package updates for [CVE-2020-10531](https://nvd.nist.gov/vuln/detail/CVE-2020-10531){: external}, [CVE-2020-2732](https://nvd.nist.gov/vuln/detail/CVE-2020-2732){: external}, [CVE-2017-11109](https://nvd.nist.gov/vuln/detail/CVE-2017-11109){: external}, [CVE-2017-6349](https://nvd.nist.gov/vuln/detail/CVE-2017-6349){: external}, and [CVE-2017-6350](https://nvd.nist.gov/vuln/detail/CVE-2017-6350){: external}.|
{: caption="Changes since version 1.15.11_1533" caption-side="bottom"}

## Change log for 1.15.11_1533, released 16 March 2020
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
{: caption="Changes since version 1.15.10_1532" caption-side="bottom"}

## Change log for worker node fix pack 1.15.10_1532, released 2 March 2020
{: #11510_1532}

The following table shows the changes that are in the worker node fix pack 1.15.10_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.12 | v1.2.13 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.13){: external}. |
| Ubuntu 18.04 packages | 4.15.0-76-generic | 4.15.0-88-generic | Updated worker node images with package updates for [CVE-2019-5108](https://nvd.nist.gov/vuln/detail/CVE-2019-5108){: external}, [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19082](https://nvd.nist.gov/vuln/detail/CVE-2019-19082){: external}, [CVE-2019-19078](https://nvd.nist.gov/vuln/detail/CVE-2019-19078){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
| Ubuntu 16.04 packages | 4.4.0-173-generic | 4.4.0-174-generic | Updated worker node images with kernel and package updates for [CVE-2019-20096](https://nvd.nist.gov/vuln/detail/CVE-2019-20096){: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}.|
{: caption="Changes since version 1.15.10_1531" caption-side="bottom"}

## Change log for fix pack 1.15.10_1531, released 17 February 2020
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
{: caption="Changes since version 1.15.8_1530" caption-side="bottom"}

## Change log for worker node fix pack 1.15.8_1530, released 3 February 2020
{: #1158_1530}

The following table shows the changes that are in the worker node fix pack 1.15.8_1530.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | 4.15.0-74-generic | 4.15.0-76-generic | Updated worker node images with kernel and package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2020-7053](https://nvd.nist.gov/vuln/detail/CVE-2020-7053){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, and [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}.|
| Ubuntu 16.04 packages | 4.4.0-171-generic | 4.4.0-173-generic | Updated worker node images with package updates for [CVE-2019-19906](https://nvd.nist.gov/vuln/detail/CVE-2019-19906){: external}, [CVE-2019-5188](https://nvd.nist.gov/vuln/detail/CVE-2019-5188){: external}, [CVE-2019-20367](https://nvd.nist.gov/vuln/detail/CVE-2019-20367){: external}, [CVE-2019-14615](https://nvd.nist.gov/vuln/detail/CVE-2019-14615){: external}, [CVE-2019-18885](https://nvd.nist.gov/vuln/detail/CVE-2019-18885){: external}, [CVE-2019-19332](https://nvd.nist.gov/vuln/detail/CVE-2019-19332){: external}, [CVE-2019-19062](https://nvd.nist.gov/vuln/detail/CVE-2019-19062){: external}, [CVE-2019-15796](https://nvd.nist.gov/vuln/detail/CVE-2019-15796){: external}, [CVE-2019-15795](https://nvd.nist.gov/vuln/detail/CVE-2019-15795){: external}, [CVE-2017-16808](https://nvd.nist.gov/vuln/detail/CVE-2017-16808){: external}, [CVE-2018-10103](https://nvd.nist.gov/vuln/detail/CVE-2018-10103){: external}, [CVE-2018-10105](https://nvd.nist.gov/vuln/detail/CVE-2018-10105){: external}, [CVE-2018-14461](https://nvd.nist.gov/vuln/detail/CVE-2018-14461){: external}, [CVE-2018-14462](https://nvd.nist.gov/vuln/detail/CVE-2018-14462){: external}, [CVE-2018-14463](https://nvd.nist.gov/vuln/detail/CVE-2018-14463){: external}, [CVE-2018-14464](https://nvd.nist.gov/vuln/detail/CVE-2018-14464){: external}, [CVE-2018-14465](https://nvd.nist.gov/vuln/detail/CVE-2018-14465){: external}, [CVE-2018-14466](https://nvd.nist.gov/vuln/detail/CVE-2018-14466){: external}, [CVE-2018-14467](https://nvd.nist.gov/vuln/detail/CVE-2018-14467){: external}, [CVE-2018-14468](https://nvd.nist.gov/vuln/detail/CVE-2018-14468){: external}, [CVE-2018-14469](https://nvd.nist.gov/vuln/detail/CVE-2018-14469){: external}, [CVE-2018-14470](https://nvd.nist.gov/vuln/detail/CVE-2018-14470){: external}, [CVE-2018-14879](https://nvd.nist.gov/vuln/detail/CVE-2018-14879){: external}, [CVE-2018-14880](https://nvd.nist.gov/vuln/detail/CVE-2018-14880){: external}, [CVE-2018-14881](https://nvd.nist.gov/vuln/detail/CVE-2018-14881){: external}, [CVE-2018-14882](https://nvd.nist.gov/vuln/detail/CVE-2018-14882){: external}, [CVE-2018-16227](https://nvd.nist.gov/vuln/detail/CVE-2018-16227){: external}, [CVE-2018-16228](https://nvd.nist.gov/vuln/detail/CVE-2018-16228){: external}, [CVE-2018-16229](https://nvd.nist.gov/vuln/detail/CVE-2018-16229){: external}, [CVE-2018-16230](https://nvd.nist.gov/vuln/detail/CVE-2018-16230){: external}, [CVE-2018-16300](https://nvd.nist.gov/vuln/detail/CVE-2018-16300){: external}, [CVE-2018-16451](https://nvd.nist.gov/vuln/detail/CVE-2018-16451){: external}, [CVE-2018-16452](https://nvd.nist.gov/vuln/detail/CVE-2018-16452){: external}, [CVE-2018-19519](https://nvd.nist.gov/vuln/detail/CVE-2018-19519){: external}, [CVE-2019-1010220](https://nvd.nist.gov/vuln/detail/CVE-2019-1010220){: external}, [CVE-2019-15166](https://nvd.nist.gov/vuln/detail/CVE-2019-15166){: external}, [CVE-2019-15167](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15167){: external}{: external}, [CVE-2016-9840](https://nvd.nist.gov/vuln/detail/CVE-2016-9840){: external}, [CVE-2016-9841](https://nvd.nist.gov/vuln/detail/CVE-2016-9841){: external}, [CVE-2016-9842](https://nvd.nist.gov/vuln/detail/CVE-2016-9842){: external}, and [CVE-2016-9843](https://nvd.nist.gov/vuln/detail/CVE-2016-9843){: external}. |
{: caption="Changes since version 1.15.8_1529" caption-side="bottom"}

## Change log for 1.15.8_1529, released 20 January 2020
{: #1158_1529}

The following table shows the changes that are in the master and worker node patch update 1.15.8_1529. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.8.4 | v3.8.6 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.8/release-notes/){: external}. |
| Cluster master HA Proxy | 1.8.21-alpine | 1.8.23-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| etcd | v3.3.17 | v3.3.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.18){: external}. Update resolves [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Gateway-enabled cluster controller | 1032 | 1045 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| GPU device plug-in and installer | f2e7bd7 | da19df3 | Updated image for [CVE-2019-13627](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13627){: external} and [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. Updated the GPU drivers to version [440.44](https://www.nvidia.com/Download/driverResults.aspx/156086/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 354 | 357 |  - Added the following storage classes: `ibmc-file-bronze-gid`, `ibmc-file-silver-gid`, and `ibmc-file-gold-gid`. \n - Fixed bugs in support of [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot). \n - Resolved [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.6-200 | v1.15.8-230 | Updated to support the Kubernetes 1.15.8 release. |
| Key Management Service provider | 270 | 277 | Updated the {{site.data.keyword.keymanagementservicelong_notm}} Go client. |
| Kubernetes | v1.15.6 | v1.15.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.8){: external}. |
| Kubernetes Metrics Server | N/A | N/A | Increased the `metrics-server` container's base CPU and memory to improve availability of the metrics server API service. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 159 | 169 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-121 | 2.4.6-r3-IKS-131 | Updated image for [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551){: external}. |
| Ubuntu 18.04 packages | 4.15.0-72-generic | 4.15.0-74-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, [CVE-2019-19083](https://nvd.nist.gov/vuln/detail/CVE-2019-19083){: external}, and [CVE-2019-17006](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17006){: external}. |
| Ubuntu 16.04 packages | 4.4.0-170-generic | 4.4.0-171-generic | Updated worker node images with package updates for [CVE-2019-13627](https://nvd.nist.gov/vuln/detail/CVE-2019-13627){: external}, [CVE-2019-14901](https://nvd.nist.gov/vuln/detail/CVE-2019-14901){: external}, [CVE-2019-14896](https://nvd.nist.gov/vuln/detail/CVE-2019-14896){: external}, [CVE-2019-14897](https://nvd.nist.gov/vuln/detail/CVE-2019-14897){: external}, [CVE-2019-14895](https://nvd.nist.gov/vuln/detail/CVE-2019-14895){: external}, [CVE-2019-18660](https://nvd.nist.gov/vuln/detail/CVE-2019-18660){: external}, and [CVE-2018-12327](https://nvd.nist.gov/vuln/detail/CVE-2018-12327){: external}. |
{: caption="Changes since version 1.15.6_1528" caption-side="bottom"}

## Change log for worker node fix pack 1.15.6_1528, released 23 December 2019
{: #1156_1528}

The following table shows the changes that are in the worker node fix pack 1.15.6_1528.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}, and [CVE-2019-17007](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17007){: external}. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-1348](https://nvd.nist.gov/vuln/detail/CVE-2019-1348){: external}, [CVE-2019-1349](https://nvd.nist.gov/vuln/detail/CVE-2019-1349){: external}, [CVE-2019-1350](https://nvd.nist.gov/vuln/detail/CVE-2019-1350){: external}, [CVE-2019-1351](https://nvd.nist.gov/vuln/detail/CVE-2019-1351){: external}, [CVE-2019-1352](https://nvd.nist.gov/vuln/detail/CVE-2019-1352){: external}, [CVE-2019-1353](https://nvd.nist.gov/vuln/detail/CVE-2019-1353){: external}, [CVE-2019-1354](https://nvd.nist.gov/vuln/detail/CVE-2019-1354){: external}, [CVE-2019-1387](https://nvd.nist.gov/vuln/detail/CVE-2019-1387){: external}, [CVE-2019-19604](https://nvd.nist.gov/vuln/detail/CVE-2019-19604){: external}, and [CVE-2019-15165](https://nvd.nist.gov/vuln/detail/CVE-2019-15165){: external}. |
{: caption="Changes since version 1.15.6_1526" caption-side="bottom"}

## Change log for master fix pack 1.15.6_1527, released 17 December 2019
{: #1156_1527}

The following table shows the changes that are in the master fix pack 1.15.6_1527.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Gateway-enabled cluster controller | 924 | 1032 | Support for [Adding classic infrastructure servers to gateway-enabled classic clusters](/docs/containers?topic=containers-add_workers#gateway_vsi) is now generally available (GA). In addition, the controller is updated to use Alpine base image version 3.10 and to use Go version 1.12.11. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor    | 353 | 354 | Updated to support [non-root user access to an NFS file share](/docs/containers?topic=containers-cs_storage_nonroot) by allocating a group ID (GID) in the storage class. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.15.6-182 | v1.15.6-200 | Updated version 1.0 and 2.0 network load balancers (NLBs) to prefer scheduling NLB pods on worker nodes that don't currently run any NLB pods. In addition, the Virtual Private Cloud (VPC) load balancer plug-in is updated to use Go version 1.12.11. |
| Key Management Service provider | 254 | 270 | Improves performance of secret management by minimizing the number of data encryption keys (DEKs) that are used to unwrap secrets in the cluster. In addition, the {{site.data.keyword.keymanagementservicelong_notm}} Go client is updated. |
{: caption="Changes since version 1.15.6_1526" caption-side="bottom"}

## Change log for worker node fix pack 1.15.6_1526, released 9 December 2019
{: #1156_1526_worker}

The following table shows the changes that are in the worker node fix pack 1.15.6_1526.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| containerd | v1.2.10 | v1.2.11 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.11){: external}. Update resolves [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}.|
| Ubuntu 16.04 kernel and packages | 4.4.0-169-generic | 4.4.0-170-generic | Updated worker node images with kernel and package updates for [CVE-2018-20784](https://nvd.nist.gov/vuln/detail/CVE-2018-20784){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-70-generic | 4.15.0-72-generic | Updated worker node images with a kernel and package updates for [CVE-2019-11745](https://nvd.nist.gov/vuln/detail/CVE-2019-11745){: external}, [CVE-2019-16168](https://nvd.nist.gov/vuln/detail/CVE-2019-16168){: external}, [CVE-2019-19330](https://nvd.nist.gov/vuln/detail/CVE-2019-19330){: external}, and [CVE-2019-5827](https://nvd.nist.gov/vuln/detail/CVE-2019-5827){: external}.|
{: caption="Changes since version 1.15.6_1525" caption-side="bottom"}

## Change log for worker node fix pack 1.15.6_1525, released 25 November 2019
{: #1156_1525_worker}

The following table shows the changes that are in the worker node fix pack 1.15.6_1525.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes | v1.15.5 | v1.15.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.6){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-166-generic | 4.4.0-169-generic | Updated worker node images with kernel and package updates for [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17052](https://nvd.nist.gov/vuln/detail/CVE-2019-17052){: external}, [CVE-2019-17053](https://nvd.nist.gov/vuln/detail/CVE-2019-17053){: external}, [CVE-2019-17054](https://nvd.nist.gov/vuln/detail/CVE-2019-17054){: external}, [CVE-2019-17055](https://nvd.nist.gov/vuln/detail/CVE-2019-17055){: external}, [CVE-2019-17056](https://nvd.nist.gov/vuln/detail/CVE-2019-17056){: external}, and [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}.|
| Ubuntu 18.04 kernel and packages | 4.15.0-66-generic | 4.15.0-70-generic | Updated worker node images with a kernel fix for unexpected configure fair group scheduler (CFS) throttling. The kernel and package updates resolve [CVE-2018-12207](https://nvd.nist.gov/vuln/detail/CVE-2018-12207){: external}, [CVE-2019-0154](https://nvd.nist.gov/vuln/detail/CVE-2019-0154){: external}, [CVE-2019-0155](https://nvd.nist.gov/vuln/detail/CVE-2019-0155){: external}, [CVE-2019-11135](https://nvd.nist.gov/vuln/detail/CVE-2019-11135){: external}, [CVE-2019-15098](https://nvd.nist.gov/vuln/detail/CVE-2019-15098){: external}, [CVE-2019-17666](https://nvd.nist.gov/vuln/detail/CVE-2019-17666){: external}, and [CVE-2019-6477](https://nvd.nist.gov/vuln/detail/CVE-2019-6477){: external}.|
{: caption="Changes since version 1.15.5_1522" caption-side="bottom"}

## Change log for master fix pack 1.15.6_1525, released 21 November 2019
{: #1156_1525}

The following table shows the changes that are in the master fix pack 1.15.6_1525.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Calico | v3.8.2 | v3.8.4 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}, and [DSA-4539-3](https://lists.debian.org/debian-security-announce/2019/msg00193.html){: external}. |
| GPU device plug-in and installer | 9cd3df7 | f2e7bd7 | Updated image for [CVE-2019-17596](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17596){: external}. Updated the GPU drivers to version [440.31](https://www.nvidia.com/Download/driverResults.aspx/153226/){: external}. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor    | 350 | 353 | Updated to use the `distroless/static` base image and to use `Go` version 1.12.11. |
| {{site.data.keyword.cloud_notm}} Provider    | v1.15.5-159 | v1.15.6-182 | Updated to support the Kubernetes 1.15.6 release. `calicoctl` version is updated to v3.8.4. |
| Key Management Service provider | 237 | 254 | Updated to use `Go` version 1.12.13. |
| Kubernetes | v1.15.5 | v1.15.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.6){: external}. |
{: caption="Changes since version 1.15.5_1522" caption-side="bottom"}

## Change log for worker node fix pack 1.15.5_1522, released 11 November 2019
{: #1155_1522_worker}

The following table shows the changes that are in the worker node fix pack 1.15.5_1522.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| `kubelet` configuration | N/A | N/A | Updated the `--pod-max-pids` option and the `pid` resource under the `--kube-reserved` and `--system-reserved` options to scale the available and reserved PIDs based on worker node flavor. |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-11481](https://nvd.nist.gov/vuln/detail/CVE-2019-11481){: external}, [CVE-2019-11482](https://nvd.nist.gov/vuln/detail/CVE-2019-11482){: external}, [CVE-2019-11483](https://nvd.nist.gov/vuln/detail/CVE-2019-11483){: external}, [CVE-2019-11485](https://nvd.nist.gov/vuln/detail/CVE-2019-11485){: external}, [CVE-2019-12290](https://nvd.nist.gov/vuln/detail/CVE-2019-12290){: external}, [CVE-2019-14866](https://nvd.nist.gov/vuln/detail/CVE-2019-14866){: external}, [CVE-2019-15790](https://nvd.nist.gov/vuln/detail/CVE-2019-15790){: external}, [CVE-2019-18218](https://nvd.nist.gov/vuln/detail/CVE-2019-18218){: external}, [CVE-2019-18224](https://nvd.nist.gov/vuln/detail/CVE-2019-18224){: external}, and [CVE-2019-18277](https://nvd.nist.gov/vuln/detail/CVE-2019-18277){: external}.|
{: caption="Changes since version 1.15.5_1521" caption-side="bottom"}

## Change log for worker node fix pack 1.15.5_1521, released 28 October 2019
{: #1155_1521}

The following table shows the changes that are in the worker node fix pack `1.15.5_1521`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Kubernetes |    v1.15.4 |    v1.15.5    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.5){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.15.5_1520" caption-side="bottom"}

## Change log for master fix pack 1.15.5_1520, released 22 October 2019
{: #1155_1520}

The following table shows the changes that are in the master fix pack `1.15.5_1520`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration to minimize [cluster service DNS resolution failures when CoreDNS pods are restarted](/docs/containers?topic=containers-coredns_lameduck). Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| etcd | v3.3.15 | v3.3.17 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.17){: external}. Update resolves [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| Gateway-enabled cluster controller | 844 | 924 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| GPU device plug-in and installer | de13f2a | 9cd3df7 | Updated image for [CVE-2019-5094](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5094){: external}. |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in and monitor | 349 | 350 | Added the ability to [scale down the plug-in replicas to zero](/docs/containers?topic=containers-file_storage#file_scaledown_plugin), to conserve cluster resources if you don't need file storage. Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, and [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.4-136 | v1.15.5-159 | Updated to support the Kubernetes 1.15.5 release. |
| Key Management Service provider | 221 | 237 | Updated image for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes |    v1.15.4 |    v1.15.5    | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.5){: external}. Update resolves [CVE-2019-11253](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11253){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/1098759){: external}){: external} and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
| Kubernetes Metrics Server | v0.3.4 |    v0.3.6    | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.6){: external}. The update also includes the following configuration changes to improve reliability and availability. \n - Added [Kubernetes liveness and readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/){: external}. \n - Added [Kubernetes pod affinity rule](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/){: external} to prefer scheduling to the same worker node as the OpenVPN client `vpn` pod in the `kube-system` namespace. \n - Increased metrics resolution timeout from 30 to 45 seconds. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 153 | 159 | Updated image for [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external}, [CVE-2019-1549](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1549){: external}, [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}, and [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}. |
{: caption="Changes since version 1.15.4_1519" caption-side="bottom"}

## Change log for worker node fix pack 1.15.4_1519, released 14 October 2019
{: #1154_1519_worker}

The following table shows the changes that are in the worker node fix pack 1.15.4_1519.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 packages and kernel | 4.4.0-164-generic | 4.4.0-165-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-0136](https://nvd.nist.gov/vuln/detail/CVE-2019-0136){: external}, [CVE-2018-20961](https://nvd.nist.gov/vuln/detail/CVE-2018-20961){: external}, [CVE-2019-11487](https://nvd.nist.gov/vuln/detail/CVE-2019-11487){: external}, [CVE-2016-10905](https://nvd.nist.gov/vuln/detail/CVE-2016-10905){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}.  |
| Ubuntu 18.04 packages and kernel | 4.15.0-64-generic | 4.15.0-65-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}. |
{: caption="Table 1. Changes since version 1.15.4_1518" caption-side="bottom"}


## Change log for 1.15.4_1518, released 1 October 2019
{: #1154_1518}

The following table shows the changes that are in the patch 1.15.4_1518. Master patch updates are applied automatically. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node. For more information, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
|Calico|v3.8.1|v3.8.2|See the [Calico release notes)](https://projectcalico.docs.tigera.io/archive/v3.8/release-notes/){: external}.|
|Cluster master HA configuration|N/A|N/A|Updated configuration to improve performance of master update operations.|
|Default IBM file storage class|N/A|N/A|Fixed a bug that might cause cluster master operations such as patch updates to clear the default IBM file storage class.|
|Gateway-enabled cluster controller|N/A|844|New! For classic clusters with a gateway enabled, a `DaemonSet` is installed to configure settings for routing network traffic to worker nodes.|
|{{site.data.keyword.cloud_notm}} Provider|v1.15.3-112|v1.15.4-136|Updated to support the Kubernetes 1.15.4 release. In addition, version 1.0 and 2.0 network load balancers (NLBs) were updated to support classic clusters with a gateway enabled.|
|Key Management Service provider|212|221|Improved Kubernetes [key management service provider](/docs/containers?topic=containers-encryption#keyprotect) caching of {{site.data.keyword.cloud_notm}} IAM tokens. In addition, fixed a problem with Kubernetes secret decryption when the cluster's root key is rotated.|
|Kubernetes|v1.15.3|v1.15.4|See the [Kubernetes release notes)](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.4){: external}.|
|Kubernetes Metrics Server|v0.3.3|v0.3.4|See the [Kubernetes Metrics Server release notes)](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.4){: external}.|
|Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider|148|153|Fixed issues with version 2.0 network load balancers (NLBs) that might cause all network traffic to drop or to be sent only to pods on one worker node.|
|OpenVPN server|2.4.6-r3-IKS-115|2.4.6-r3-IKS-121|Updated images for [CVE-2019-1547)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547){: external} and [CVE-2019-1563)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563){: external}.|
|containerd|v1.2.9|v1.2.10|See the [containerd release notes)](https://github.com/containerd/containerd/releases/tag/v1.2.10){: external}. Update resolves [CVE-2019-16884)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16884){: external} and [CVE-2019-16276)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276){: external}.|
|Kubernetes|v1.15.3|v1.15.4|See the [Kubernetes release notes)](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.4){: external}.|
|Ubuntu 18.04 kernel and packages|4.15.0-62-generic|4.15.0-64-generic|Updated worker node images with kernel and package updates for [CVE-2019-15031)](https://nvd.nist.gov/vuln/detail/CVE-2019-15031){: external}, [CVE-2019-15030)](https://nvd.nist.gov/vuln/detail/CVE-2019-15030){: external}, and [CVE-2019-14835)](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}.|
|Ubuntu 16.04 kernel and packages|4.4.0-161-generic|4.4.0-164-generic|Updated worker node images with kernel and package updates for [CVE-2019-14835)](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}.|
{: caption="Changes since version 1.15.3_1517" caption-side="bottom"}



## Change log for worker node fix pack 1.15.3_1517, released 16 September 2019
{: #1153_1517_worker}

The following table shows the changes that are in the worker node fix pack 1.15.3_1517.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | v1.2.8 | v1.2.9 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.9){: external}. Update resolves [CVE-2019-9515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9515){: external}.  |
| Ubuntu 16.04 packages and kernel | 4.4.0-159-generic | 4.4.0-161-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2015-9383](https://nvd.nist.gov/vuln/detail/CVE-2015-9383){: external}, [CVE-2019-10638](https://nvd.nist.gov/vuln/detail/CVE-2019-10638){: external}, [CVE-2019-3900](https://nvd.nist.gov/vuln/detail/CVE-2019-3900){: external}, [CVE-2018-20856](https://nvd.nist.gov/vuln/detail/CVE-2018-20856){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2018-20406](https://nvd.nist.gov/vuln/detail/CVE-2018-20406){: external}, and [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}.  |
| Ubuntu 18.04 packages and kernel | 4.15.0-58-generic | 4.15.0-62-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}, and [CVE-2019-15718](https://nvd.nist.gov/vuln/detail/CVE-2019-15718){: external}. |
{: caption="Table 1. Changes since version 1.15.3_1516" caption-side="bottom"}


## Change log for worker node fix pack 1.15.3_1516, released 3 September 2019
{: #1153_1516_worker}

The following table shows the changes that are in the worker node fix pack 1.15.3_1516.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | v1.2.7 | v1.2.8 | See the [Containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.8){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}.  |
| Kubernetes | v1.15.2 | v1.15.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.3){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external} (see [IBM security bulletin][IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external} (see (https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}.  |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates.  |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-10222](https://nvd.nist.gov/vuln/detail/CVE-2019-10222){: external} and [CVE-2019-11922](https://nvd.nist.gov/vuln/detail/CVE-2019-11922){: external}. |
{: caption="Table 1. Changes since version 1.15.2_1514" caption-side="bottom"}


## Change log for master fix pack 1.15.3_1515, released 28 August 2019
{: #1153_1515}

The following table shows the changes that are in the master fix pack 1.15.3_1515.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| etcd | v3.3.13 | v3.3.15 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.15){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}.  |
| GPU device plug-in and installer | 07c9b67 | de13f2a | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. Updated the GPU drivers to [430.40](https://www.nvidia.com/Download/driverResults.aspx/149138/){: external}.  |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in | 348 | 349 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.2-94 | v1.15.3-112 | Updated to support the Kubernetes 1.15.3 release.  |
| Key Management Service provider | 207 | 212 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}.  |
| Kubernetes | v1.15.2 | v1.15.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.3){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/security-bulletin-ibm-cloud-kubernetes-service-affected-kubernetes-security-vulnerabilities-cve-2019-9512-cve-2019-9514){: external}), and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}.  |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 147 | 148 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
{: caption="Table 1. Changes since version 1.15.2_1514" caption-side="bottom"}


## Change log for worker node fix pack 1.15.2_1514, released 19 August 2019
{: #1152_1514_worker}

The following table shows the changes that are in the worker node fix pack 1.15.2_1514.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA Proxy | 2.0.1-alpine | 1.8.21-alpine | Moved to HA Proxy 1.8 to fix [socket leak in HA proxy](https://github.com/haproxy/haproxy/issues/136){: external}. Also added a liveliness check to monitor the health of HA Proxy. For more information, see [HA Proxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}.  |
| Kubernetes | v1.15.1 | v1.15.2 | For more information, see the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.2){: external}.  |
| Ubuntu 16.04 kernel and packages | 4.4.0-157-generic | 4.4.0-159-generic | Updated worker node images with package updates for [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, and [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}.  |
| Ubuntu 18.04 kernel and packages | 4.15.0-55-generic | 4.15.0-58-generic | Updated worker node images with package updates for [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2019-2101](https://nvd.nist.gov/vuln/detail/CVE-2019-2101){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-13233](https://nvd.nist.gov/vuln/detail/CVE-2019-13233){: external}, [CVE-2019-13272](https://nvd.nist.gov/vuln/detail/CVE-2019-13272){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}, [CVE-2019-12818](https://nvd.nist.gov/vuln/detail/CVE-2019-12818){: external}, [CVE-2019-12984](https://nvd.nist.gov/vuln/detail/CVE-2019-12984){: external}, and [CVE-2019-12819](https://nvd.nist.gov/vuln/detail/CVE-2019-12819){: external}. |
{: caption="Table 1. Changes since version 1.15.1_1511" caption-side="bottom"}


## Change log for master fix pack 1.15.2_1514, released 17 August 2019
{: #1152_1514}

The following table shows the changes that are in the master fix pack 1.15.2_1514.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Key Management Service provider | 167 | 207 | Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets. |
{: caption="Table 1. Changes since version 1.15.1_1513" caption-side="bottom"}


## Change log for master fix pack 1.15.2_1513, released 15 August 2019
{: #1152_1513}

The following table shows the changes that are in the master fix pack 1.15.2_1513.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico configuration | N/A | N/A | Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container. In addition, the `calico-node` deployment in the `kube-system` namespace no longer includes the `flexvol-driver` init container.  |
| Cluster health | N/A | N/A | Cluster health shows `Warning` state if a cluster control plane operation failed or was canceled. For more information, see (/docs/containers?topic=containers-debug_clusters">Debugging clusters].  |
| GPU device plug-in and installer | d91d200 | 07c9b67 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.15.1-86 | v1.15.2-94 | Updated to support the Kubernetes 1.15.2 release.  |
| {{site.data.keyword.cloud_notm}} {{site.data.keyword.filestorage_short}} plug-in | 347 | 348 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.  |
| Kubernetes | v1.15.1 | v1.15.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.2){: external}. Updates resolves [CVE-2019-11247](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11247){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967115){: external}) and [CVE-2019-11249](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11249){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967123){: external}).  |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 146 | 147 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.  |
| OpenVPN client | 2.4.6-r3-IKS-90 | 2.4.6-r3-IKS-116 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}.  |
| OpenVPN server | 2.4.6-r3-IKS-25 | 2.4.6-r3-IKS-115 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
{: caption="Table 1. Changes since version 1.15.1_1511" caption-side="bottom"}


## Change log for 1.15.1_1511, released 5 August 2019
{: #1151_1511}

The following table shows the changes that are in the patch 1.15.1_1511.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.6.4 | v3.8.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. In addition, Kubernetes version 1.15 clusters now have a new `allow-all-private-default` global network policy to allow all ingress and egress network traffic on private interface. For more information, see [Isolating clusters on the private network](/docs/containers?topic=containers-network_policies#isolate_workers).  |
| {{site.data.keyword.cloud_notm}} Provider | v1.14.4-139 | v1.15.1-86 |  - Updated to support the Kubernetes 1.15.1 release. \n - `calicoctl` version is updated to 3.8.1. \n - Virtual Private Cloud (VPC) load balancer support is added for VPC clusters. |
| Kubernetes | v1.14.4 | v1.15.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.1){: external} and [Kubernetes 1.15 blog](https://kubernetes.io/blog/2019/06/19/kubernetes-1-15-release-announcement/){: external}. Update resolves [CVE-2019-11248](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248){: external} (see [IBM security bulletin](https://www.ibm.com/support/pages/node/967113){: external}).  |
| Kubernetes configuration | N/A | N/A | Updated Kubernetes API server default toleration seconds to 600 for the Kubernetes default `node.kubernetes.io/not-ready` and `node.kubernetes.io/unreachable` pod tolerations. For more information about tolerations, see [Taints and Tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/){: external}.  |
| Kubernetes add-on resizer | 1.8.4 | 1.8.5 | For more information, see the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.5){: external}.  |
| Kubernetes DNS autoscaler | 1.4.0 | 1.6.0 | For more information, see the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.6.0){: external}.  |
| Kubernetes nodelocal DNS cache | N/A | 1.15.4 | For more information, see the [Kubernetes nodelocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.15.4){: external}. For more information about this new beta feature, see [Setting up Nodelocal DNS Cache (beta)](/docs/containers?topic=containers-cluster_dns#dns_enablecache).  |
| Cluster master HA proxy | 1.9.7-alpine | 2.0.1-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/2.0/src/CHANGELOG){: external}.  |
| GPU device plug-in and installer | a7e8ece | d91d200 | Updated image for [CVE-2019-9924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924){: external}.  |
| Ubuntu 18.04 kernel and packages | 4.15.0-54-generic | 4.15.0-55-generic | Updated worker node images with package updates for [CVE-2019-11085](https://nvd.nist.gov/vuln/detail/CVE-2019-11085){: external}, [CVE-2019-11815](https://nvd.nist.gov/vuln/detail/CVE-2019-11815){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-11884](https://nvd.nist.gov/vuln/detail/CVE-2019-11884){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, and [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}.  |
| Ubuntu 16.04 kernel and packages | 4.4.0-154-generic | 4.4.0-157-generic | Updated worker node images with package updates for [CVE-2019-2054](https://nvd.nist.gov/vuln/detail/CVE-2019-2054){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, and [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}. |
{: caption="Table 1. Changes since version 1.14.4_1526" caption-side="bottom"}
