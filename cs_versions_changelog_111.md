---

copyright:
 years: 2014, 2022
lastupdated: "2022-12-01"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Version 1.11 changelog (unsupported as of 20 July 2019)
{: #111_changelog}

Review the version 1.11 changelog.
{: shortdesc}

## Change log for worker node fix pack 1.11.10_1564, released 8 July 2019
{: #11110_1564}

The following table shows the changes that are in the worker node patch 1.11.10_1564.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-151-generic | 4.4.0-154-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-52-generic | 4.15.0-54-generic | Updated worker node images with kernel and package updates for [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external} and [CVE-2019-11479](https://ubuntu.com/security/CVE-2019-11479.html){: external}. |
{: caption="Changes since version 1.11.10_1563" caption-side="bottom"}


## Change log for worker node fix pack 1.11.10_1563, released 24 June 2019
{: #11110_1563}

The following table shows the changes that are in the worker node patch 1.11.10_1563.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-150-generic | 4.4.0-151-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-51-generic | 4.15.0-52-generic | Updated worker node images with kernel and package updates for [CVE-2019-11477](https://ubuntu.com/security/CVE-2019-11477.html){: external} and [CVE-2019-11478](https://ubuntu.com/security/CVE-2019-11478.html){: external}. |
{: caption="Changes since version 1.11.10_1562" caption-side="bottom"}


## Change log for worker node fix pack 1.11.10_1562, released 17 June 2019
{: #11110_1562}

The following table shows the changes that are in the worker node patch 1.11.10_1562.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-148-generic | 4.4.0-150-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-50-generic | 4.15.0-51-generic | Updated worker node images with kernel and package updates for [CVE-2019-10906](https://ubuntu.com/security/CVE-2019-10906){: external}. |
{: caption="Changes since version 1.11.10_1561" caption-side="bottom"}


## Change log for 1.11.10_1561, released 4 June 2019
{: #11110_1561}

The following table shows the changes that are in the patch 1.11.10_1561.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA configuration | N/A | N/A | Updated configuration to minimize intermittent master network connectivity failures during a master update. |
| etcd | v3.3.11 | v3.3.13 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.13){: external}. |
| GPU device plug-in and installer | 55c1f66 | 32257d3 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
| Trusted compute agent | 13c7ef0 | e8c6d72 | Updated image for [CVE-2018-10844](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844){: external}, [CVE-2018-10845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845){: external}, [CVE-2018-10846](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846){: external}, [CVE-2019-3829](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829){: external}, [CVE-2019-3836](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836){: external}, [CVE-2019-9893](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9893){: external}, [CVE-2019-5435](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435){: external}, and [CVE-2019-5436](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436){: external}. |
{: caption="Changes since version 1.11.10_1559" caption-side="bottom"}


## Change log for worker node fix pack 1.11.10_1559, released 20 May 2019
{: #11110_1559}

The following table shows the changes that are in the patch pack 1.11.10_1559.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu 16.04 kernel | 4.4.0-145-generic | 4.4.0-148-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-47-generic | 4.15.0-50-generic | Updated worker node images with kernel update for [CVE-2018-12126](https://ubuntu.com/security/CVE-2018-12126.html){: external}, [CVE-2018-12127](https://ubuntu.com/security/CVE-2018-12127.html){: external}, and [CVE-2018-12130](https://ubuntu.com/security/CVE-2018-12130.html){: external}. |
{: caption="Changes since version 1.11.10_1558" caption-side="bottom"}

## Change log for 1.11.10_1558, released 13 May 2019
{: #11110_1558}

The following table shows the changes that are in the patch 1.11.10_1558.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 1.9.6-alpine | 1.9.7-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2019-6706](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706){: external}. |
| GPU device plug-in and installer | 9ff3fda | 55c1f66 | Updated image for [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.9-241 | v1.11.10-270 | Updated to support the Kubernetes 1.11.10 release. |
| Kubernetes | v1.11.9 | v1.11.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.10){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to not log the `/openapi/v2*` read-only URL. In addition, the Kubernetes controller manager configuration increased the validity duration of signed `kubelet` certificates from 1 to 3 years. |
| OpenVPN client configuration | N/A | N/A | The OpenVPN client `vpn-*` pod in the `kube-system` namespace now sets `dnsPolicy` to `Default` to prevent the pod from failing when cluster DNS is down. |
| Trusted compute agent | e132aa4 | 13c7ef0 | Updated image for [CVE-2016-7076](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-7076){: external}, [CVE-2017-1000368](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000368){: external}, and [CVE-2019-11068](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11068){: external}. |
{: caption="Changes since version 1.11.9_1556" caption-side="bottom"}


## Change log for worker node fix pack 1.11.9_1556, released 29 April 2019
{: #1119_1556}

The following table shows the changes that are in the worker node fix pack 1.11.9_1556.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
| containerd | 1.1.6 | 1.1.7 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.7){: external}. |
{: caption="Changes since version 1.11.9_1555" caption-side="bottom"}


## Change log for worker node fix pack 1.11.9_1555, released 15 April 2019
{: #1119_1555}

The following table shows the changes that are in the worker node fix pack 1.11.9_1555.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842](https://ubuntu.com/security/CVE-2019-3842.html){: external}. |
{: caption="Changes since 1.11.9_1554" caption-side="bottom"}


## Change log for 1.11.9_1554, released 8 April 2019
{: #1119_1554}

The following table shows the changes that are in the patch 1.11.9_1554.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.3.1 | v3.3.6 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. Update resolves [CVE-2019-9946](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9946){: external}. |
| Cluster master HA proxy | 1.8.12-alpine | 1.9.6-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2018-0732](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external}, [CVE-2018-0734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external}, [CVE-2018-0737](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external}, [CVE-2018-5407](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}, [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}, and [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.8-219 | v1.11.9-241 | Updated to support the Kubernetes 1.11.9 and Calico 3.3.6 releases. |
| Kubernetes | v1.11.8 | v1.11.9 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.9){: external}. |
| Kubernetes DNS | 1.14.10 | 1.14.13 | See the [Kubernetes DNS release notes](https://github.com/kubernetes/dns/releases/tag/1.14.13){: external}. |
| Trusted compute agent | a02f765 | e132aa4 | Updated image for [CVE-2017-12447](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447){: external}. |
| Ubuntu 16.04 kernel | 4.4.0-143-generic | 4.4.0-145-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}. |
| Ubuntu 18.04 kernel | 4.15.0-46-generic | 4.15.0-47-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}. |
{: caption="Changes since version 1.11.8_1553" caption-side="bottom"}

## Change log for worker node fix pack 1.11.8_1553, released 1 April 2019
{: #1118_1553}

The following table shows the changes that are in the worker node fix 1.11.8_1553.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Worker node resource utilization | N/A | N/A | Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Changes since version 1.11.8_1552" caption-side="bottom"}


## Change log for master fix pack 1.11.8_1552, released 26 March 2019
{: #1118_1552}

The following table shows the changes that are in the master fix pack 1.11.8_1552.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 345 | 346 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
| Key Management Service provider | 166 | 167 | Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 143 | 146 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
{: caption="Changes since version 1.11.8_1550" caption-side="bottom"}


## Change log for 1.11.8_1550, released 20 March 2019
{: #1118_1550}

The following table shows the changes that are in the patch 1.11.8_1550.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy configuration | N/A | N/A | Updated configuration to better handle intermittent connection failures to the cluster master. |
| GPU device plug-in and installer | e32d51c | 9ff3fda | Updated the GPU drivers to [418.43](https://www.nvidia.com/object/unix.html){: external}. Update includes fix for [CVE-2019-9741](https://ubuntu.com/security/CVE-2019-9741.html){: external}. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 344 | 345 | Added support for [private cloud service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se). |
| Kernel | 4.4.0-141 | 4.4.0-143 | Updated worker node images with kernel update for [CVE-2019-6133](https://ubuntu.com/security/CVE-2019-6133.html){: external}. |
| Key Management Service provider | 136 | 166 | Updated image for [CVE-2018-16890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890){: external}, [CVE-2019-3822](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822){: external}, and [CVE-2019-3823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823){: external}. |
| Trusted compute agent | 5f3d092 | a02f765 | Updated image for [CVE-2018-10779](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779){: external}, [CVE-2018-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900){: external}, [CVE-2018-17000](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000){: external}, [CVE-2018-19210](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210){: external}, [CVE-2019-6128](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128){: external}, and [CVE-2019-7663](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663){: external}. |
{: caption="Changes since version 1.11.8_1547" caption-side="bottom"}


## Change log for 1.11.8_1547, released 4 March 2019
{: #1118_1547}

The following table shows the changes that are in the patch 1.11.8_1547.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| GPU device plug-in and installer | eb3a259 | e32d51c | Updated images for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.7-198 | v1.11.8-219 | Updated to support the Kubernetes 1.11.8 release. Fixed periodic connectivity problems for load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer events to use the latest {{site.data.keyword.cloud_notm}} documentation links. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 342 | 344 | Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| Key Management Service provider | 122 | 136 | Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| Kubernetes | v1.11.7 | v1.11.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.8){: external}. Update resolves [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external} and [CVE-2019-1002100](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1002100){: external}. |
| Kubernetes configuration | N/A | N/A | Added `ExperimentalCriticalPodAnnotation=true` to the `--feature-gates` option. This setting helps migrate pods from the deprecated `scheduler.alpha.kubernetes.io/critical-pod` annotation to [Kubernetes pod priority support](/docs/containers?topic=containers-pod_priority#pod_priority). |
| Kubernetes DNS | N/A | N/A | Increased Kubernetes DNS pod memory limit from `170Mi` to `400Mi` to handle more cluster services. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 132 | 143 | Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| OpenVPN client and server | 2.4.6-r3-IKS-13 | 2.4.6-r3-IKS-25 | Updated image for [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}. |
| Trusted compute agent | 1ea5ad3 | 5f3d092 | Updated image for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}. |
{: caption="Changes since version 1.11.7_1546" caption-side="bottom"}


## Change log for worker node fix pack 1.11.7_1546, released 27 February 2019
{: #1117_1546}

The following table shows the changes that are in the worker node fix pack 1.11.7_1546.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-141 | 4.4.0-142 | Updated worker node images with kernel update for [CVE-2018-19407](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog){: external}. |
{: caption="Changes since version 1.11.7_1546" caption-side="bottom"}


## Change log for worker node fix pack 1.11.7_1544, released 15 February 2019
{: #1117_1544}

The following table shows the changes that are in the worker node fix pack 1.11.7_1544.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy configuration | N/A | N/A | Changed the pod configuration `spec.priorityClassName` value to `system-node-critical` and set the `spec.priority` value to `2000001000`. |
| containerd | 1.1.5 | 1.1.6 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.6){: external}. Update resolves [CVE-2019-5736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736){: external}. |
| Kubernetes `kubelet` configuration | N/A | N/A | Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction. |
{: caption="Changes since version 1.11.7_1543" caption-side="bottom"}

## Change log for 1.11.7_1543, released 5 February 2019
{: #1117_1543}

The following table shows the changes that are in the patch 1.11.7_1543.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| etcd | v3.3.1 | v3.3.11 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.11){: external}. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more). |
| GPU device plug-in and installer | 13fdc0d | eb3a259 | Updated images for [CVE-2019-3462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462){: external} and [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.6-180 | v1.11.7-198 | Updated to support the Kubernetes 1.11.7 release. Additionally, `calicoctl` version is updated to 3.3.1. Fixed unnecessary configuration updates to version 2.0 network load balancers on worker node status changes. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 338 | 342 | The file storage plug-in is updated as follows: \n - Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology). \n - Ignores persistent volume claim (PVC) delete errors if the storage is already deleted. \n - Adds a failure message annotation to failed PVCs. \n - Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour. \n - Checks user permissions before starting the provisioning. |
| Key Management Service provider | 111 | 122 | Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}. |
| Kubernetes | v1.11.6 | v1.11.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.7){: external}. |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests. |
| OpenVPN client | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}. Additionally, the pod configuration is now obtained from a secret instead of from a configmap. |
| OpenVPN server | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}. |
| `systemd` | 230 | 229 | Security patch for [CVE-2018-16864](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864){: external}. |
{: caption="Changes since version 1.11.6_1541" caption-side="bottom"}


## Change log for worker node fix pack 1.11.6_1541, released 28 January 2019
{: #1116_1541}

The following table shows the changes that are in the worker node fix pack 1.11.6_1541.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462){: external} / [USN-3863-1](https://ubuntu.com/security/notices/USN-3863-1){: external}. |
{: caption="Changes since version 1.11.6_1540" caption-side="bottom"}


## Change log for 1.11.6_1540, released 21 January 2019
{: #1116_1540}

The following table shows the changes that are in the patch 1.11.6_1540.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.5-152 | v1.11.6-180 | Updated to support the Kubernetes 1.11.6 release. |
| Kubernetes | v1.11.5 | v1.11.6 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.6){: external}. |
| Kubernetes add-on resizer | 1.8.1 | 1.8.4 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4){: external}. |
| Kubernetes dashboard | v1.8.3 | v1.10.1 | See the [Kubernetes dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1){: external}. Update resolves [CVE-2018-18264](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264){: external}.  \n If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers?topic=containers-deploy_app#cli_dashboard). |
| GPU installer | 390.12 | 410.79 | Updated the installed GPU drivers to 410.79. |
{: caption="Changes since version 1.11.5_1539" caption-side="bottom"}


## Change log for worker node fix pack 1.11.5_1539, released 7 January 2019
{: #1115_1539}

The following table shows the changes that are in the worker node fix pack 1.11.5_1539.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-139 | 4.4.0-141 | Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog){: external}. |
{: caption="Changes since version 1.11.5_1538" caption-side="bottom"}

## Change log for worker node fix pack 1.11.5_1538, released 17 December 2018
{: #1115_1538}

The following table shows the changes that are in the worker node fix pack 1.11.5_1538.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
{: caption="Changes since version 1.11.5_1537" caption-side="bottom"}


## Change log for 1.11.5_1537, released 5 December 2018
{: #1115_1537}

The following table shows the changes that are in the patch 1.11.5_1537.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.4-142 | v1.11.5-152 | Updated to support the Kubernetes 1.11.5 release. |
| Kubernetes | v1.11.4 | v1.11.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.5){: external}. Update resolves [CVE-2018-1002105](https://github.com/kubernetes/kubernetes/issues/71411){: external}. |
{: caption="Changes since version 1.11.4_1536" caption-side="bottom"}


## Change log for worker node fix pack 1.11.4_1536, released 4 December 2018
{: #1114_1536}

The following table shows the changes that are in the worker node fix pack 1.11.4_1536.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Worker node resource utilization | N/A | N/A | Added dedicated cgroups for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Changes since version 1.11.4_1535" caption-side="bottom"}


## Change log for 1.11.4_1535, released 27 November 2018
{: #1114_1535}

The following table shows the changes that are in patch 1.11.4_1535.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.2.1 | v3.3.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. Update resolves [Tigera Technical Advisory TTA-2018-001](https://www.tigera.io/security-bulletins/){: external}. |
| containerd | v1.1.4 | v1.1.5 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.5){: external}. Updated containerd to fix a deadlock that can [stop pods from terminating](https://github.com/containerd/containerd/issues/2744){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.3-127 | v1.11.4-142 | Updated to support the Kubernetes 1.11.4 release. |
| Kubernetes | v1.11.3 | v1.11.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.4){: external}. |
| OpenVPN client and server | 2.4.4-r1-6 | 2.4.6-r3-IKS-8 | Updated image for [CVE-2018-0732](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external} and [CVE-2018-0737](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external}. |
{: caption="Changes since version 1.11.3_1534" caption-side="bottom"}

## Change log for worker node fix pack 1.11.3_1534, released 19 November 2018
{: #1113_1534}

The following table shows the changes that are in the worker node fix pack 1.11.3_1534.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-137 | 4.4.0-139 | Updated worker node images with kernel update for [CVE-2018-7755](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog){: external}. |
{: caption="Changes since version 1.11.3_1533" caption-side="bottom"}


## Change log for 1.11.3_1533, released 7 November 2018
{: #1113_1533}

The following table shows the changes that are in patch 1.11.3_1533.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA update | N/A | N/A | Fixed the update to highly available (HA) masters for clusters that use admission webhooks such as `initializerconfigurations`, `mutatingwebhookconfigurations`, or `validatingwebhookconfigurations`. You might use these webhooks with Helm charts or admission controller projects such as Portieris. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.3-100 | v1.11.3-127 | Added the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlan ls --zone &lt;zone&gt;`. |
| TPM-enabled kernel | N/A | N/A | Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers?topic=containers-kubernetes-service-cli) on an existing cluster, you need to [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks flavors --zone` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_machine_types). |
{: caption="Changes since version 1.11.3_1531" caption-side="bottom"}


## Change log for master fix pack 1.11.3_1531, released 1 November 2018
{: #1113_1531_ha-master}

The following table shows the changes that are in the master fix pack 1.11.3_1531.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master | N/A | N/A | Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts. |
| Cluster master HA proxy | N/A | 1.8.12-alpine | Added an `ibm-master-proxy-*` pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica. |
| etcd | v3.2.18 | v3.3.1 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.1){: external}(https://github.com/etcd-io/etcd/releases/v3.3.1]{: external}. |
| Encrypting data in etcd | N/A | N/A | Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, [enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster](/docs/containers?topic=containers-encryption#keyprotect). |
{: caption="Changes since version 1.11.3_1527" caption-side="bottom"}


## Change log for worker node fix pack 1.11.3_1531, released 26 October 2018
{: #1113_1531}

The following table shows the changes that are in the worker node fix pack 1.11.3_1531.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| OS interrupt handling | N/A | N/A | Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler. |
{: caption="Changes since version 1.11.3_1525" caption-side="bottom"}


## Change log for master fix pack 1.11.3_1527, released 15 October 2018
{: #1113_1527}

The following table shows the changes that are in the master fix pack 1.11.3_1527.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico configuration | N/A | N/A | Fixed `calico-node` container readiness probe to better handle node failures. |
| Cluster update | N/A | N/A | Fixed problem with updating cluster add-ons when the master is updated from an unsupported version. |
{: caption="Changes since version 1.11.3_1524" caption-side="bottom"}


## Change log for worker node fix pack 1.11.3_1525, released 10 October 2018
{: #1113_1525}

The following table shows the changes that are in the worker node fix pack 1.11.3_1525.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-133 | 4.4.0-137 | Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog){: external}. |
| Inactive session timeout | N/A | N/A | Set the inactive session timeout to 5 minutes for compliance reasons. |
{: caption="Changes since version 1.11.3_1524" caption-side="bottom"}


## Change log for 1.11.3_1524, released 2 October 2018
{: #1113_1524}

The following table shows the changes that are in patch 1.11.3_1524.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | 1.1.3 | 1.1.4 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.4]{: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.3-91 | v1.11.3-100 | Updated the documentation link in load balancer error messages. |
| {{site.data.keyword.IBM_notm}} file storage classes | N/A | N/A | Removed duplicate `reclaimPolicy` parameter in the {{site.data.keyword.IBM_notm}} file storage classes.  \n Also, now when you update the cluster master, the default {{site.data.keyword.IBM_notm}} file storage class remains unchanged. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass). |
{: caption="Changes since version 1.11.3_1521" caption-side="bottom"}



## Change log for 1.11.3_1521, released 20 September 2018
{: #1113_1521}

The following table shows the changes that are in patch 1.11.3_1521.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.2-71 | v1.11.3-91 | Updated to support Kubernetes 1.11.3 release. |
| {{site.data.keyword.IBM_notm}} file storage classes | N/A | N/A | Removed `mountOptions` in the {{site.data.keyword.IBM_notm}} file storage classes to use the default that is provided by the worker node.  \n Also, now when you update the cluster master, the default IBM file storage class remains `ibmc-file-bronze`. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass). |
| Key Management Service Provider | N/A | N/A | Added the ability to use the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you [enable {{site.data.keyword.keymanagementserviceshort}} or a key management service (KMS) provider in your cluster](/docs/containers?topic=containers-encryption#keyprotect), all your Kubernetes secrets are encrypted. |
| Kubernetes | v1.11.2 | v1.11.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3){: external}. |
| Kubernetes DNS autoscaler | 1.1.2-r2 | 1.2.0 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.2.0){: external}. |
| Log rotate | N/A | N/A | Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) or the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update). |
| Root password expiration | N/A | N/A | Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can [update](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days. |
| Worker node runtime components (`kubelet`, `kube-proxy`, `containerd`) | N/A | N/A | Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up. |
| systemd | N/A | N/A | Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345](https://github.com/kubernetes/kubernetes/issues/57345){: external}. |
{: caption="Changes since version 1.11.2_1516" caption-side="bottom"}


## Change log for 1.11.2_1516, released 4 September 2018
{: #1112_1516}

The following table shows the changes that are in patch 1.11.2_1516.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.1.3 | v3.2.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. |
| containerd | 1.1.2 | 1.1.3 | See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.3){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.11.2-60 | v1.11.2-71 | Changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in configuration | N/A | N/A | Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers?topic=containers-file_storage#nfs_version_class). |
{: caption="Changes since version 1.11.2_1514" caption-side="bottom"}


## Change log for worker node fix pack 1.11.2_1514, released 23 August 2018
{: #1112_1514}

The following table shows the changes that are in the worker node fix pack 1.11.2_1514.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| `systemd` | 229 | 230 | Updated `systemd` to fix `cgroup` leak. |
| Kernel | 4.4.0-127 | 4.4.0-133 | Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646](https://ubuntu.com/security/notices/USN-3741-1){: external}. |
{: caption="Changes since version 1.11.2_1513" caption-side="bottom"}


## Change log for 1.11.2_1513, released 14 August 2018
{: #1112_1513}

The following table shows the changes that are in patch 1.11.2_1513.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| containerd | N/A | 1.1.2 | `containerd` replaces Docker as the new container runtime for Kubernetes. See the [containerd release notes](https://github.com/containerd/containerd/releases/tag/v1.1.2){: external}. |
| Docker | N/A | N/A | `containerd` replaces Docker as the new container runtime for Kubernetes, to enhance performance. |
| etcd | v3.2.14 | v3.2.18 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.2.18){: external}. |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.5-118 | v1.11.2-60 | Updated to support Kubernetes 1.11 release. In addition, load balancer pods now use the new `ibm-app-cluster-critical` pod priority class. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 334 | 338 | Updated `incubator` version to 1.8. File storage is provisioned to the specific zone that you select. You can't update an existing (static) PV instance labels. |
| Kubernetes | v1.10.5 | v1.11.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the OpenID Connect configuration for the cluster's Kubernetes API server to support {{site.data.keyword.cloud_notm}} Identity Access and Management (IAM) access groups. Added `Priority` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the cluster to support pod priority. For more information, see: \n - [{{site.data.keyword.cloud_notm}} IAM access groups](/docs/containers?topic=containers-users#rbac) \n - [Configuring pod priority](/docs/containers?topic=containers-pod_priority#pod_priority) |
| Kubernetes Heapster | v1.5.2 | v.1.5.4 | Increased resource limits for the `heapster-nanny` container. See the [Kubernetes Heapster release notes](https://github.com/kubernetes-retired/heapster/releases/tag/v1.5.4){: external}. |
| Logging configuration | N/A | N/A | The container log directory is now `/var/log/pods/` instead of the previous `/var/lib/docker/containers/`. |
{: caption="Changes since version 1.10.5_1518" caption-side="bottom"}
