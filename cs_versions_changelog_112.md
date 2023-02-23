---

copyright:
 years: 2014, 2023
lastupdated: "2023-02-23"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Version 1.12 change log (unsupported 3 November 2019)
{: #112_changelog}


Version 1.12 is unsupported. You can review the following archive of 1.12 change logs.
{: shortdesc}


## Change log for worker node fix pack 1.12.10_1570, released 28 October 2019
{: #11210_1570}

The following table shows the changes that are in the worker node fix pack `1.12.10_1570`.
{: shortdesc}

| Component | Previous | Current | Description |
| --------- | -------- | ------- | ----------- |
| Ubuntu 18.04 packages and kernel | 4.15.0-65-generic | 4.15.0-66-generic    | Updated worker node images with kernel and package updates for [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
| Ubuntu 16.04 packages and kernel | 4.4.0-165-generic | 4.4.0-166-generic | Updated worker node images with kernel and package updates for [CVE-2017-18232](https://nvd.nist.gov/vuln/detail/CVE-2017-18232){: external}, [CVE-2018-21008](https://nvd.nist.gov/vuln/detail/CVE-2018-21008){: external}, [CVE-2019-13117](https://nvd.nist.gov/vuln/detail/CVE-2019-13117){: external}, [CVE-2019-13118](https://nvd.nist.gov/vuln/detail/CVE-2019-13118){: external}, [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287){: external}, [CVE-2019-14821](https://nvd.nist.gov/vuln/detail/CVE-2019-14821){: external}, and [CVE-2019-18197](https://nvd.nist.gov/vuln/detail/CVE-2019-18197){: external}. |
{: caption="Changes since version 1.12.10_1569" caption-side="bottom"}

## Change log for worker node fix pack 1.12.10_1569, released 14 October 2019
{: #11210_1569_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1569.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 packages and kernel | 4.4.0-164-generic | 4.4.0-165-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-0136](https://nvd.nist.gov/vuln/detail/CVE-2019-0136){: external}, [CVE-2018-20961](https://nvd.nist.gov/vuln/detail/CVE-2018-20961){: external}, [CVE-2019-11487](https://nvd.nist.gov/vuln/detail/CVE-2019-11487){: external}, [CVE-2016-10905](https://nvd.nist.gov/vuln/detail/CVE-2016-10905){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-64-generic | 4.15.0-65-generic | Updated worker node images with kernel and package updates for [CVE-2019-5094](https://nvd.nist.gov/vuln/detail/CVE-2019-5094){: external}, [CVE-2018-20976](https://nvd.nist.gov/vuln/detail/CVE-2018-20976){: external}, [CVE-2019-16056](https://nvd.nist.gov/vuln/detail/CVE-2019-16056){: external}, and [CVE-2019-16935](https://nvd.nist.gov/vuln/detail/CVE-2019-16935){: external}. |
{: caption="Changes since version 1.12.10_1568" caption-side="bottom"}


## Change log for worker node fix pack 1.12.10_1568, released 1 October 2019
{: #11210_1568_worker}

The following table shows the changes that are in the patch 1.12.10_1568.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 18.04 kernel and packages | 4.15.0-62-generic | 4.15.0-64-generic | Updated worker node images with kernel and package updates for [CVE-2019-15031](https://nvd.nist.gov/vuln/detail/CVE-2019-15031){: external}, [CVE-2019-15030](https://nvd.nist.gov/vuln/detail/CVE-2019-15030){: external}, and [CVE-2019-14835](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-161-generic | 4.4.0-164-generic | Updated worker node images with kernel and package updates for [CVE-2019-14835](https://nvd.nist.gov/vuln/detail/CVE-2019-14835){: external}. |
{: caption="Changes since version 1.12.10_1567" caption-side="bottom"}


## Change log for worker node fix pack 1.12.10_1567, released 16 September 2019
{: #11210_1567_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1567.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 packages and kernel | 4.4.0-159-generic | 4.4.0-161-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2015-9383](https://nvd.nist.gov/vuln/detail/CVE-2015-9383){: external}, [CVE-2019-10638](https://nvd.nist.gov/vuln/detail/CVE-2019-10638){: external}, [CVE-2019-3900](https://nvd.nist.gov/vuln/detail/CVE-2019-3900){: external}, [CVE-2018-20856](https://nvd.nist.gov/vuln/detail/CVE-2018-20856){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external},[CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2018-20406](https://nvd.nist.gov/vuln/detail/CVE-2018-20406){: external}, and [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}. |
| Ubuntu 18.04 packages and kernel | 4.15.0-58-generic | 4.15.0-62-generic | Updated worker node images with kernel and package updates for [CVE-2019-5481](https://nvd.nist.gov/vuln/detail/CVE-2019-5481){: external}, [CVE-2019-5482](https://nvd.nist.gov/vuln/detail/CVE-2019-5482){: external}, [CVE-2019-15903](https://nvd.nist.gov/vuln/detail/CVE-2019-15903){: external}, [CVE-2019-14283](https://nvd.nist.gov/vuln/detail/CVE-2019-14283){: external}, [CVE-2019-14284](https://nvd.nist.gov/vuln/detail/CVE-2019-14284){: external}, [CVE-2018-20852](https://nvd.nist.gov/vuln/detail/CVE-2018-20852){: external}, [CVE-2019-5010](https://nvd.nist.gov/vuln/detail/CVE-2019-5010){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-9740](https://nvd.nist.gov/vuln/detail/CVE-2019-9740){: external}, [CVE-2019-9947](https://nvd.nist.gov/vuln/detail/CVE-2019-9947){: external}, [CVE-2019-9948](https://nvd.nist.gov/vuln/detail/CVE-2019-9948){: external}, [CVE-2019-9636](https://nvd.nist.gov/vuln/detail/CVE-2019-9636){: external}, [CVE-2019-10160](https://nvd.nist.gov/vuln/detail/CVE-2019-10160){: external}, and [CVE-2019-15718](https://nvd.nist.gov/vuln/detail/CVE-2019-15718){: external}. |
{: caption="Changes since version 1.12.10_1566" caption-side="bottom"}


## Change log for worker node fix pack 1.12.10_1566, released 3 September 2019
{: #11210_1566_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1566.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 packages | N/A | N/A | Updated worker node images with package updates. |
| Ubuntu 18.04 packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-10222](https://nvd.nist.gov/vuln/detail/CVE-2019-10222){: external} and [CVE-2019-11922](https://nvd.nist.gov/vuln/detail/CVE-2019-11922){: external}. |
{: caption="Changes since version 1.12.10_1564" caption-side="bottom"}


## Change log for master fix pack 1.12.10_1565, released 28 August 2019
{: #11210_1565}

The following table shows the changes that are in the master fix pack 1.12.10_1565.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| etcd | v3.3.13 | v3.3.15 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.15){: external}. Update resolves [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| GPU device plug-in and installer | 07c9b67 | de13f2a | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. Updated the GPU drivers to [430.40](https://www.nvidia.com/Download/driverResults.aspx/149138/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 348 | 349 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Key Management Service provider | 207 | 212 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 147 | 148 | Image updated for [CVE-2019-9512](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9512){: external}, [CVE-2019-9514](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9514){: external}, and [CVE-2019-14809](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14809){: external}. |
{: caption="Changes since version 1.12.10_1564" caption-side="bottom"}


## Change log for worker node fix pack 1.12.10_1564, released 19 August 2019
{: #11210_1564_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1564.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 2.0.1-alpine | 1.8.21-alpine | Moved to HA proxy 1.8 to fix [socket leak in HA proxy](https://github.com/haproxy/haproxy/issues/136){: external}. Also added a liveliness check to monitor the health of HA proxy. For more information, see [HA proxy release notes](https://www.haproxy.org/download/1.8/src/CHANGELOG){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-157-generic | 4.4.0-159-generic | Updated worker node images with package updates for [CVE-2019-13012](https://nvd.nist.gov/vuln/detail/CVE-2019-13012){: external}, [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, and [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}. |
| Ubuntu 18.04 kernel and packages | 4.15.0-55-generic | 4.15.0-58-generic | Updated worker node images with package updates for [CVE-2019-1125](https://nvd.nist.gov/vuln/detail/CVE-2019-1125){: external}, [CVE-2019-2101](https://nvd.nist.gov/vuln/detail/CVE-2019-2101){: external}, [CVE-2018-5383](https://nvd.nist.gov/vuln/detail/CVE-2018-5383){: external}, [CVE-2019-13233](https://nvd.nist.gov/vuln/detail/CVE-2019-13233){: external}, [CVE-2019-13272](https://nvd.nist.gov/vuln/detail/CVE-2019-13272){: external}, [CVE-2019-10126](https://nvd.nist.gov/vuln/detail/CVE-2019-10126){: external}, [CVE-2019-3846](https://nvd.nist.gov/vuln/detail/CVE-2019-3846){: external}, [CVE-2019-12818](https://nvd.nist.gov/vuln/detail/CVE-2019-12818){: external}, [CVE-2019-12984](https://nvd.nist.gov/vuln/detail/CVE-2019-12984){: external}, and [CVE-2019-12819](https://nvd.nist.gov/vuln/detail/CVE-2019-12819){: external}. |
{: caption="Changes since version 1.12.10_1561" caption-side="bottom"}

## Change log for master fix pack 1.12.10_1564, released 17 August 2019
{: #11210_1564}

The following table shows the changes that are in the master fix pack 1.12.10_1564.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Key Management Service provider | 167 | 207 | Fixed an issue that causes the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) to fail to manage Kubernetes secrets. |
{: caption="Changes since version 1.12.10_1563" caption-side="bottom"}

## Change log for master fix pack 1.12.10_1563, released 15 August 2019
{: #11210_1563}

The following table shows the changes that are in the master fix pack 1.12.10_1563.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico configuration | N/A | N/A | Calico `calico-kube-controllers` deployment in the `kube-system` namespace sets a memory limit on the `calico-kube-controllers` container. |
| GPU device plug-in and installer | a7e8ece | 07c9b67 | Image updated for [CVE-2019-9924](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924){: external} and [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 347 | 348 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| Kubernetes DNS | 1.14.13 | 1.15.4 | See the [Kubernetes DNS release notes](https://github.com/kubernetes/dns/releases/tag/1.15.4){: external}. Image update resolves [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| Kubernetes DNS autoscaler | 1.2.0 | 1.3.0 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.3.0){: external}. Image update resolves [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 146 | 147 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| OpenVPN client | 2.4.6-r3-IKS-13 | 2.4.6-r3-IKS-116 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
| OpenVPN server | 2.4.6-r3-IKS-25 | 2.4.6-r3-IKS-115 | Image updated for [CVE-2019-14697](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697){: external}. |
{: caption="Changes since version 1.12.10_1561" caption-side="bottom"}


## Change log for worker node fix pack 1.12.10_1561, released 5 August 2019
{: #11210_1561_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1561.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 18.04 kernel and packages | 4.15.0-54-generic | 4.15.0-55-generic | Updated worker node images with package updates for [CVE-2019-11085](https://nvd.nist.gov/vuln/detail/CVE-2019-11085){: external}, [CVE-2019-11815](https://nvd.nist.gov/vuln/detail/CVE-2019-11815){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-11884](https://nvd.nist.gov/vuln/detail/CVE-2019-11884){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}, and [CVE-2019-2054](https://nvd.nist.gov/vuln/detail/CVE-2019-2054){: external}. |
| Ubuntu 16.04 kernel and packages | 4.4.0-154-generic | 4.4.0-157-generic | Updated worker node images with package updates for [CVE-2019-2054](https://nvd.nist.gov/vuln/detail/CVE-2019-2054){: external}, [CVE-2019-11833](https://nvd.nist.gov/vuln/detail/CVE-2019-11833){: external}, [CVE-2019-13057](https://nvd.nist.gov/vuln/detail/CVE-2019-13057){: external}, [CVE-2019-13565](https://nvd.nist.gov/vuln/detail/CVE-2019-13565){: external}, [CVE-2019-13636](https://nvd.nist.gov/vuln/detail/CVE-2019-13636){: external}, and [CVE-2019-13638](https://nvd.nist.gov/vuln/detail/CVE-2019-13638){: external}. |
{: caption="Changes since version 1.12.10_1560" caption-side="bottom"}


## Change log for worker node fix pack 1.12.10_1560, released 22 July 2019
{: #11210_1560_worker}

The following table shows the changes that are in the worker node fix pack 1.12.10_1560.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.12.9 | v1.12.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.10){: external}. Update resolves [CVE-2019-11248](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11248){: external}. For more information, see [IBM security bulletin](https://www.ibm.com/support/pages/node/967113){: external}). |
| Ubuntu packages | N/A | N/A | Updated worker node images with package updates for [CVE-2019-13012](https://ubuntu.com/security/CVE-2019-13012){: external} and [CVE-2019-7307](https://ubuntu.com/security/CVE-2019-7307.html){: external}. |
{: caption="Changes since version 1.12.9_1559" caption-side="bottom"}


## Change log for master fix pack 1.12.10_1560, released 15 July 2019
{: #11210_1560}

The following table shows the changes that are in the master fix pack 1.12.10_1560.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.3.6 | v3.6.4 | See the [Calico release notes](https://docs.tigera.io/calico/3.25/release-notes/){: external}. Update resolves [TTA-2019-001](https://www.tigera.io/security-bulletins/#TTA-2019-001){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/959551){: external}. |
| CoreDNS configuration | N/A | N/A | Changed the default CoreDNS configuration from a 5 to 30 second TTL for DNS records in the `kubernetes` zone. This change aligns with the default KubeDNS configuration. Existing CoreDNS configurations are unchanged. For more information about changing your CoreDNS configuration, see [Customizing the cluster DNS provider](/docs/containers?topic=containers-cluster_dns#dns_customize). |
| GPU device plug-in and installer | 5d34347 | a7e8ece | Updated base image packages. |
| Kubernetes | v1.12.9 | v1.12.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.10){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.9-227 | v1.12.10-259 | Updated to support the Kubernetes 1.12.10 release. Additionally, `calicoctl` version is updated to 3.6.4. |
{: caption="Changes since version 1.12.9_1559" caption-side="bottom"}

## Change log for worker node fix pack 1.12.9_1559, released 8 July 2019
{: #1129_1559}

The following table shows the changes that are in the worker node patch 1.12.9_1559.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-151-generic | 4.4.0-154-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-52-generic | 4.15.0-54-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
{: caption="Changes since version 1.12.9_1558" caption-side="bottom"}


## Change log for worker node fix pack 1.12.9_1558, released 24 June 2019
{: #1129_1558}

The following table shows the changes that are in the worker node patch 1.12.9_1558.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-150-generic | 4.4.0-151-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-51-generic | 4.15.0-52-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/958863){: external}. |
| containerd | 1.2.6 | 1.2.7 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.7){: external}. |
{: caption="Changes since version 1.12.9_1557" caption-side="bottom"}


## Change log for 1.12.9_1557, released 17 June 2019
{: #1129_1557}

The following table shows the changes that are in the patch 1.12.9_1557.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| GPU device plug-in and installer | 32257d3 | 5d34347 | Updated image for [CVE-2019-8457](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457){: external}. Updated the GPU drivers to [430.14](https://www.nvidia.com/Download/driverResults.aspx/147582/){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 346 | 347 | Updated so that the IAM API key can be either encrypted or unencrypted. |
| Public service endpoint for Kubernetes master | N/A | N/A | Fixed an issue to [enable the public cloud service endpoint](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se). |
| Ubuntu 16.04 kernel | 4.4.0-148-generic | 4.4.0-150-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-50-generic | 4.15.0-51-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
{: caption="Changes since version 1.12.9_1555" caption-side="bottom"}


## Change log for 1.12.9_1555, released 4 June 2019
{: #1129_1555}

The following table shows the changes that are in the patch 1.12.9_1555.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS configuration | N/A | N/A | Fixed a bug that might leave both Kubernetes DNS and CoreDNS pods running after cluster `create` or `update` operations. |
| Cluster master HA configuration | N/A | N/A | Updated configuration to minimize intermittent master network connectivity failures during a master update. |
| etcd | v3.3.11 | v3.3.13 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.13){: external}. |
| GPU device plug-in and installer | 55c1f66 | 32257d3 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.8-210 | v1.12.9-227 | Updated to support the Kubernetes 1.12.9 release. |
| Kubernetes | v1.12.8 | v1.12.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.9){: external}. |
| Kubernetes Metrics Server | v0.3.1 | v0.3.3 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.3){: external}. |
| Trusted compute agent | 13c7ef0 | e8c6d72 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
{: caption="Changes since version 1.12.8_1553" caption-side="bottom"}


## Change log for worker node fix pack 1.12.8_1553, released 20 May 2019
{: #1128_1533}

The following table shows the changes that are in the patch 1.12.8_1553.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-145-generic | 4.4.0-148-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-47-generic | 4.15.0-50-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
{: caption="Changes since version 1.12.8_1553" caption-side="bottom"}


## Change log for 1.12.8_1552, released 13 May 2019
{: #1128_1552}

The following table shows the changes that are in the patch 1.12.8_1552.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 1.9.6-alpine | 1.9.7-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2019-6706](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706){: external}. |
| GPU device plug-in and installer | 9ff3fda | 55c1f66 | Updated image for [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.7-180 | v1.12.8-210 | Updated to support the Kubernetes 1.12.8 release. Also, fixed the update process for version 2.0 network load balancer that have only one available worker node for the load balancer pods. |
| Kubernetes | v1.12.7 | v1.12.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.8){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years. |
| OpenVPN client configuration | N/A | N/A | The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down. |
| Trusted compute agent | e132aa4 | 13c7ef0 | Updated image for [CVE-2016-7076](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076){: external}, [CVE-2017-1000368](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368){: external}, and [CVE-2019-11068](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068){: external}. |
{: caption="Changes since version 1.12.7_1550" caption-side="bottom"}

## Change log for worker node fix pack 1.12.7_1550, released 29 April 2019
{: #1127_1550}

The following table shows the changes that are in the worker node fix pack 1.12.7_1550.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
| containerd | 1.1.6 | 1.1.7 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.7){: external}. |
{: caption="Changes since version 1.12.7_1549" caption-side="bottom"}


## Change log for worker node fix pack 1.12.7_1549, released 15 April 2019
{: #1127_1549}

The following table shows the changes that are in the worker node fix pack 1.12.7_1549.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842](https://ubuntu.com/security/CVE-2019-3842.html){: external}. |
{: caption="Changes since version 1.12.7_1548" caption-side="bottom"}


## Change log for 1.12.7_1548, released 8 April 2019
{: #1127_1548}

The following table shows the changes that are in the patch 1.12.7_1548.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.3.1 | v3.3.6 | See the [Calico release notes](https://docs.tigera.io/calico/3.25/release-notes/){: external}. Update resolves [CVE-2019-9946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/879585){: external}. |
| Cluster master HA proxy | 1.8.12-alpine | 1.9.6-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2018-0732](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external}, [CVE-2018-0734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external}, [CVE-2018-0737](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external}, [CVE-2018-5407](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}, [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}, and [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.6-157 | v1.12.7-180 | Updated to support the Kubernetes 1.12.7 and Calico 3.3.6 releases. |
| Kubernetes | v1.12.6 | v1.12.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.7){: external}. |
| Trusted compute agent | a02f765 | e132aa4 | Updated image for [CVE-2017-12447](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447){: external}. |
| Ubuntu 16.04 kernel | 4.4.0-143-generic | 4.4.0-145-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-46-generic | 4.15.0-47-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}. |
{: caption="Changes since version 1.12.6_1547" caption-side="bottom"}

## Change log for worker node fix pack 1.12.6_1547, released 1 April 2019
{: #1126_1547}

The following table shows the changes that are in the worker node fix pack 1.12.6_1547.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Worker node resource utilization | N/A | N/A | Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Changes since version 1.12.6_1546" caption-side="bottom"}


## Change log for master fix pack 1.12.6_1546, released 26 March 2019
{: #1126_1546}

The following table shows the changes that are in the master fix pack 1.12.6_1546.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 345 | 346 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
| Key Management Service provider | 166 | 167 | Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 143 | 146 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
{: caption="Changes since version 1.12.6_1544" caption-side="bottom"}


## Change log for 1.12.6_1544, released 20 March 2019
{: #1126_1544}

The following table shows the changes that are in the patch 1.12.6_1544.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS configuration | N/A | N/A | Fixed a bug that might cause cluster master operations, such as `refresh` or `update`, to fail when the unused cluster DNS must be scaled down. |
| Cluster master HA proxy configuration | N/A | N/A | Updated configuration to better handle intermittent connection failures to the cluster master. |
| CoreDNS configuration | N/A | N/A | Updated the CoreDNS configuration to support [multiple Corefiles](https://coredns.io/2017/07/23/corefile-explained/){: external}. |
| GPU device plug-in and installer | e32d51c | 9ff3fda | Updated the GPU drivers to [418.43](https://www.nvidia.com/object/unix.html){: external}. Update includes fix for [CVE-2019-9741](https://ubuntu.com/security/CVE-2019-9741.html){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 344 | 345 | Added support for [private cloud service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se). |
| Kernel | 4.4.0-141 | 4.4.0-143 | Updated worker node images with kernel update for [CVE-2019-6133](https://ubuntu.com/security/CVE-2019-6133.html){: external}. |
| Key Management Service provider | 136 | 166 | Updated image for [CVE-2018-16890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890){: external}, [CVE-2019-3822](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822){: external}, and [CVE-2019-3823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823){: external}. |
| Trusted compute agent | 5f3d092 | a02f765 | Updated image for [CVE-2018-10779](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779){: external}, [CVE-2018-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900){: external}, [CVE-2018-17000](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000){: external}, [CVE-2018-19210](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210){: external}, [CVE-2019-6128](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128){: external}, and [CVE-2019-7663](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663){: external}. |
{: caption="Changes since version 1.12.6_1541" caption-side="bottom"}


## Change log for 1.12.6_1541, released 4 March 2019
{: #1126_1541}

The following table shows the changes that are in the patch 1.12.6_1541.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster DNS provider | N/A | N/A | Increased Kubernetes DNS and CoreDNS pod memory limit from `170Mi` to `400Mi` to handle more cluster services. |
| GPU device plug-in and installer | eb3a259 | e32d51c | Updated images for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.5-137 | v1.12.6-157 | Updated to support the Kubernetes 1.12.6 release. Fixed periodic connectivity problems for version 1.0 load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer version 1.0 and 2.0 events to use the latest {{site.data.keyword.cloud_notm}} documentation links. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 342 | 344 | Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| Key Management Service provider | 122 | 136 | Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| Kubernetes | v1.12.5 | v1.12.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.6){: external}. Update resolves [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external} and [CVE-2019-1002100](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/873324){: external}. |
| Kubernetes configuration | N/A | N/A | Added `ExperimentalCriticalPodAnnotation=true` to the `--feature-gates` option. This setting helps migrate pods from the deprecated `scheduler.alpha.kubernetes.io/critical-pod` annotation to [Kubernetes pod priority support](/docs/containers?topic=containers-pod_priority#pod_priority). |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 132 | 143 | Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| OpenVPN client and server | 2.4.6-r3-IKS-13 | 2.4.6-r3-IKS-25 | Updated image for [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}. |
| Trusted compute agent | 1ea5ad3 | 5f3d092 | Updated image for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}. |
{: caption="Changes since version 1.12.5_1540" caption-side="bottom"}


## Change log for worker node fix pack 1.12.5_1540, released 27 February 2019
{: #1125_1540}

The following table shows the changes that are in the worker node fix pack 1.12.5_1540.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-141 | 4.4.0-142 | Updated worker node images with kernel update for [CVE-2018-19407](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog){: external}. |
{: caption="Changes since version 1.12.5_1538" caption-side="bottom"}


## Change log for worker node fix pack 1.12.5_1538, released 15 February 2019
{: #1125_1538}

The following table shows the changes that are in the worker node fix pack 1.12.5_1538.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy configuration | N/A | N/A | Changed the pod configuration `spec.priorityClassName` value to `system-node-critical` and set the `spec.priority` value to `2000001000`. |
| containerd | 1.1.5 | 1.1.6 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.6){: external}. Update resolves [CVE-2019-5736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/871600){: external}. |
| Kubernetes `kubelet` configuration | N/A | N/A | Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction. |
{: caption="Changes since version 1.12.5_1537" caption-side="bottom"}

## Change log for 1.12.5_1537, released 5 February 2019
{: #1125_1537}

The following table shows the changes that are in the patch 1.12.5_1537.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| etcd | v3.3.1 | v3.3.11 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.11){: external}. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more). |
| GPU device plug-in and installer | 13fdc0d | eb3a259 | Updated images for [CVE-2019-3462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462){: external} and [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.4-118 | v1.12.5-137 | Updated to support the Kubernetes 1.12.5 release. Additionally, `calicoctl` version is updated to 3.3.1. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 338 | 342 | The {{site.data.keyword.filestorage_short}} plug-in is updated as follows: \n - Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology). \n - Ignores persistent volume claim (PVC) delete errors if the storage is already deleted. \n - Adds a failure message annotation to failed PVCs. \n - Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour. \n - Checks user permissions before starting the provisioning. |
| Key Management Service provider | 111 | 122 | Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}. |
| Kubernetes | v1.12.4 | v1.12.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.5){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests. |
| OpenVPN client | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}. Additionally, the pod configuration is now obtained from a secret instead of from a ConfigMap. |
| OpenVPN server | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}. |
| systemd | 230 | 229 | Security patch for [CVE-2018-16864](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864){: external}. |
{: caption="Changes since version 1.12.4_1535" caption-side="bottom"}


## Change log for worker node fix pack 1.12.4_1535, released 28 January 2019
{: #1124_1535}

The following table shows the changes that are in the worker node fix pack 1.12.4_1535.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462){: external} and [USN-3863-1](https://ubuntu.com/security/notices/USN-3863-1){: external}. |
{: caption="Changes since version 1.12.4_1534" caption-side="bottom"}


## Change log for 1.12.4_1534, released 21 January 2019
{: #1124_1534}

The following table shows the changes that are in the patch 1.12.3_1534.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.3-91 | v1.12.4-118 | Updated to support the Kubernetes 1.12.4 release. |
| Kubernetes | v1.12.3 | v1.12.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.4){: external}. |
| Kubernetes add-on resizer | 1.8.1 | 1.8.4 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4){: external}. |
| Kubernetes dashboard | v1.8.3 | v1.10.1 | See the [Kubernetes dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1){: external}. Update resolves [CVE-2018-18264](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264){: external}. |
| GPU installer | 390.12 | 410.79 | Updated the installed GPU drivers to 410.79. |
{: caption="Changes since version 1.12.3_1533" caption-side="bottom"}


## Change log for worker node fix pack 1.12.3_1533, released 7 January 2019
{: #1123_1533}

The following table shows the changes that are in the worker node fix pack 1.12.3_1533.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-139 | 4.4.0-141 | Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog){: external}. |
{: caption="Changes since version 1.12.3_1532" caption-side="bottom"}

## Change log for worker node fix pack 1.12.3_1532, released 17 December 2018
{: #1123_1532}

The following table shows the changes that are in the worker node fix pack 1.12.2_1532.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
{: caption="Changes since version 1.12.3_1531" caption-side="bottom"}


## Change log for 1.12.3_1531, released 5 December 2018
{: #1123_1531}

The following table shows the changes that are in the patch 1.12.3_1531.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.12.2-68 | v1.12.3-91 | Updated to support the Kubernetes 1.12.3 release. |
| Kubernetes | v1.12.2 | v1.12.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.3){: external}. Update resolves [CVE-2018-1002105](https://github.com/kubernetes/kubernetes/issues/71411){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/743917){: external}. |
{: caption="Changes since version 1.12.2_1530" caption-side="bottom"}

## Change log for worker node fix pack 1.12.2_1530, released 4 December 2018
{: #1122_1530}

The following table shows the changes that are in the worker node fix pack 1.12.2_1530.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Worker node resource utilization | N/A | N/A | Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Changes since version 1.12.2_1529" caption-side="bottom"}



## Change log for 1.12.2_1529, released 27 November 2018
{: #1122_1529}

The following table shows the changes that are in patch 1.12.2_1529.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.2.1 | v3.3.1 | See the [Calico release notes](https://docs.tigera.io/calico/3.25/release-notes/){: external}. Update resolves [Tigera Technical Advisory TTA-2018-001](https://www.tigera.io/security-bulletins/){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/740799){: external}. |
| Cluster DNS configuration | N/A | N/A | Fixed a bug that could result in both Kubernetes DNS and CoreDNS pods to run after cluster creation or update operations. |
| containerd | v1.2.0 | v1.1.5 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.5){: external}. Updated containerd to fix a deadlock that can [stop pods from terminating](https://github.com/containerd/containerd/issues/2744){: external}. |
| OpenVPN client and server | 2.4.4-r1-6 | 2.4.6-r3-IKS-8 | Updated image for [CVE-2018-0732](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external} and [CVE-2018-0737](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external}. |
{: caption="Changes since version 1.12.2_1528" caption-side="bottom"}


## Change log for worker node fix pack 1.12.2_1528, released 19 November 2018
{: #1122_1528}

The following table shows the changes that are in the worker node fix pack 1.12.2_1528.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-137 | 4.4.0-139 | Updated worker node images with kernel update for [CVE-2018-7755](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog){: external}. |
{: caption="Changes since version 1.12.2_1527" caption-side="bottom"}


## Change log for 1.12.2_1527, released 7 November 2018
{: #1122_1527}

The following table shows the changes that are in patch 1.12.2_1527.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico configuration | N/A | N/A | Calico `calico-*` pods in the `kube-system` namespace now set CPU and memory resource requests for all containers. |
| Cluster DNS provider | N/A | N/A | Kubernetes DNS (KubeDNS) remains the default cluster DNS provider.. |
| Cluster metrics provider | N/A | N/A | Kubernetes Metrics Server replaces Kubernetes Heapster (deprecated since Kubernetes version 1.8) as the cluster metrics provider. |
| containerd | 1.1.4 | 1.2.0 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.2.0]{: external}. |
| CoreDNS | N/A | 1.2.2 | See the [CoreDNS release notes](https://github.com/coredns/coredns/releases/tag/v1.2.2]{: external}. |
| Kubernetes | v1.11.3 | v1.12.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.12.2]{: external}. |
| Kubernetes configuration | N/A | N/A | Added three new IBM pod security policies and their associated cluster roles. For more information, see [Understanding default resources for IBM cluster management](/docs/containers?topic=containers-psp#ibm_psp). |
| Kubernetes Dashboard | v1.8.3 | v1.10.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v1.10.0){: external}.  \n If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers?topic=containers-deploy_app#cli_dashboard). Additionally, you can now scale up the number of Kubernetes Dashboard pods by running `kubectl -n kube-system scale deploy kubernetes-dashboard --replicas=3`. |
| Kubernetes DNS | 1.14.10 | 1.14.13 | See the [Kubernetes DNS release notes](https://github.com/kubernetes/dns/releases/tag/1.14.13]{: external}. |
| Kubernetes Metrics Server | N/A | v0.3.1 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.3.1]{: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.3-118 | v1.12.2-68 | Updated to support the Kubernetes 1.12 release. Additional changes include the following: \n - Load balancer pods (`ibm-cloud-provider-ip-*` in `ibm-system` namespace) now set CPU and memory resource requests. \n - The `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation is added to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlan ls --zone <zone>`. \n - A new [load balancer 2.0](/docs/containers?topic=containers-loadbalancer-about#planning_ipvs) is available as a beta. |
| OpenVPN client configuration | N/A | N/A | OpenVPN client `vpn-* pod` in the `kube-system` namespace now sets CPU and memory resource requests. |
{: caption="Changes since version 1.11.3_1533" caption-side="bottom"}

