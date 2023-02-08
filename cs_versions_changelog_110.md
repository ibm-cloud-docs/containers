---

copyright:
 years: 2014, 2023
lastupdated: "2023-02-08"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Version 1.10 changelog (unsupported as of 16 May 2019)
{: #110_changelog}


Review the version 1.10 changelogs.
{: shortdesc}


## Change log for worker node fix pack 1.10.13_1558, released 13 May 2019
{: #11013_1558}

The following table shows the changes that are in the worker node fix pack 1.10.13_1558.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 1.9.6-alpine | 1.9.7-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2019-6706](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6706){: external}. 
{: caption="Table 1. Changes since version 1.10.13_1557" caption-side="bottom"}

## Change log for worker node fix pack 1.10.13_1557, released 29 April 2019
{: #11013_1557}

The following table shows the changes that are in the worker node fix pack 1.10.13_1557.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
{: caption="Table 1. Changes since 1.10.13_1556" caption-side="bottom"}


## Change log for worker node fix pack 1.10.13_1556, released 15 April 2019
{: #11013_1556}

The following table shows the changes that are in the worker node fix pack 1.10.13_1556.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages including `systemd` for [CVE-2019-3842](https://ubuntu.com/security/CVE-2019-3842.html){: external}. |
{: caption="Table 1. Changes since 1.10.13_1555" caption-side="bottom"}

## Change log for 1.10.13_1555, released 8 April 2019
{: #11013_1555}

The following table shows the changes that are in the patch 1.10.13_1555.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy | 1.8.12-alpine | 1.9.6-alpine | See the [HAProxy release notes](https://www.haproxy.org/download/1.9/src/CHANGELOG){: external}. Update resolves [CVE-2018-0732](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external}, [CVE-2018-0734](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external}, [CVE-2018-0737](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external}, [CVE-2018-5407](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}, [CVE-2019-1543](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1543){: external}, and [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}.  |
| Kubernetes DNS | 1.14.10 | 1.14.13 | See the [Kubernetes DNS release notes](https://github.com/kubernetes/dns/releases/tag/1.14.13){: external}.  |
| Trusted compute agent | a02f765 | e132aa4 | Updated image for [CVE-2017-12447](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-12447){: external}.  |
| Ubuntu 16.04 kernel | 4.4.0-143-generic | 4.4.0-145-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}.  |
| Ubuntu 18.04 kernel | 4.15.0-46-generic | 4.15.0-47-generic | Updated worker node images with kernel update for [CVE-2019-9213](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9213){: external}. |
{: caption="Table 1. Changes since version 1.10.13_1554" caption-side="bottom"}

## Change log for worker node fix pack 1.10.13_1554, released 1 April 2019
{: #11013_1554}

The following table shows the changes that are in the worker node fix 1.10.13_1554.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Worker node resource utilization | N/A | N/A | Increased memory reservations for the kubelet and containerd to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Table 1. Changes since version 1.10.13_1553" caption-side="bottom"}



## Change log for master fix pack 1.10.13_1553, released 26 March 2019
{: #11118_1553}

The following table shows the changes that are in the master fix pack 1.10.13_1553.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 345 | 346 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}.  |
| Key Management Service provider | 166 | 167 | Fixes intermittent `context deadline exceeded` and `timeout` errors for managing Kubernetes secrets. In addition, fixes updates to the key management service that might leave existing Kubernetes secrets unencrypted. Update includes fix for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}.  |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 143 | 146 | Updated image for [CVE-2019-9741](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9741){: external}. |
{: caption="Table 1. Changes since version 1.10.13_1551" caption-side="bottom"}


## Change log for 1.10.13_1551, released 20 March 2019
{: #11013_1551}

The following table shows the changes that are in the patch 1.10.13_1551.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master HA proxy configuration | N/A | N/A | Updated configuration to better handle intermittent connection failures to the cluster master.  |
| GPU device plug-in and installer | e32d51c | 9ff3fda | Updated the GPU drivers to [418.43](https://www.nvidia.com/object/unix.html){: external}. Update includes fix for [CVE-2019-9741](https://ubuntu.com/security/CVE-2019-9741.html){: external}.  |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 344 | 345 | Added support for [private cloud service endpoints](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se).  |
| Kernel | 4.4.0-141 | 4.4.0-143 | Updated worker node images with kernel update for [CVE-2019-6133](https://ubuntu.com/security/CVE-2019-6133.html){: external}.  |
| Key Management Service provider | 136 | 166 | Updated image for [CVE-2018-16890](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16890){: external}, [CVE-2019-3822](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3822){: external}, and [CVE-2019-3823](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3823){: external}.  |
| Trusted compute agent | 5f3d092 | a02f765 | Updated image for [CVE-2018-10779](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10779){: external}, [CVE-2018-12900](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12900){: external}, [CVE-2018-17000](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-17000){: external}, [CVE-2018-19210](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19210){: external}, [CVE-2019-6128](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6128){: external}, and [CVE-2019-7663](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7663){: external}. |
{: caption="Table 1. Changes since version 1.10.13_1548" caption-side="bottom"}


## Change log for 1.10.13_1548, released 4 March 2019
{: #11013_1548}

The following table shows the changes that are in the patch 1.10.13_1548.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| GPU device plug-in and installer | eb3a259 | e32d51c | Updated images for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.12-252 | v1.10.13-288 | Updated to support the Kubernetes 1.10.13 release. Fixed periodic connectivity problems for load balancers that set `externalTrafficPolicy` to `local`. Updated load balancer events to use the latest {{site.data.keyword.cloud_notm}} documentation links.  |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 342 | 344 | Changed the base operating system for the image from Fedora to Alpine. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}.  |
| Key Management Service provider | 122 | 136 | Increased client timeout to {{site.data.keyword.keymanagementservicefull_notm}}. Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}.  |
| Kubernetes | v1.10.12 | v1.10.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.13){: external}.  |
| Kubernetes DNS | N/A | N/A | Increased Kubernetes DNS pod memory limit from `170Mi` to `400Mi` to handle more cluster services.  |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 132 | 143 | Updated image for [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}.  |
| OpenVPN client and server | 2.4.6-r3-IKS-13 | 2.4.6-r3-IKS-25 | Updated image for [CVE-2019-1559](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1559){: external}.  |
| Trusted compute agent | 1ea5ad3 | 5f3d092 | Updated image for [CVE-2019-6454](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6454){: external}. |
{: caption="Table 1. Changes since version 1.10.12_1546" caption-side="bottom"}


## Change log for worker node fix pack 1.10.12_1546, released 27 February 2019
{: #11012_1546}

The following table shows the changes that are in the worker node fix pack 1.10.12_1546.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-141 | 4.4.0-142 | Updated worker node images with kernel update for [CVE-2018-19407](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-142.168/changelog){: external}. |
{: caption="Table 1. Changes since version 1.10.12_1544" caption-side="bottom"}


## Change log for worker node fix pack 1.10.12_1544, released 15 February 2019
{: #11012_1544}

The following table shows the changes that are in the worker node fix pack 1.10.12_1544.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Docker | 18.06.1-ce | 18.06.2-ce | See the [Docker Community Edition release notes](https://github.com/docker/docker-ce/releases/tag/v18.06.2-ce){: external}. Update resolves [CVE-2019-5736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736){: external}.  |
| Kubernetes `kubelet` configuration | N/A | N/A | Enabled the `ExperimentalCriticalPodAnnotation` feature gate to prevent critical static pod eviction. |
{: caption="Table 1. Changes since version 1.10.12_1543" caption-side="bottom"}


## Change log for 1.10.12_1543, released 5 February 2019
{: #11012_1543}

The following table shows the changes that are in the patch 1.10.12_1543.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| etcd | v3.3.1 | v3.3.11 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.11){: external}. Additionally, the supported cipher suites to etcd are now restricted to a subset with high strength encryption (128 bits or more).  |
| GPU device plug-in and installer | 13fdc0d | eb3a259 | Updated images for [CVE-2019-3462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462){: external} and [CVE-2019-6486](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6486){: external}.  |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 338 | 342 | The file storage plug-in is updated as follows: \n - Supports dynamic provisioning with [volume topology-aware scheduling](/docs/containers?topic=containers-file_storage#file-topology). \n - Ignores persistent volume claim (PVC) delete errors if the storage is already deleted. \n - Adds a failure message annotation to failed PVCs. \n - Optimizes the storage provisioner controller's leader election and resync period settings, and increases the provisioning timeout from 30 minutes to 1 hour. \n - Checks user permissions before starting the provisioning. |
| Key Management Service provider | 111 | 122 | Added retry logic to avoid temporary failures when Kubernetes secrets are managed by {{site.data.keyword.keymanagementservicefull_notm}}.  |
| Kubernetes configuration | N/A | N/A | The Kubernetes API server audit policy configuration is updated to include logging metadata for `cluster-admin` requests and logging the request body of workload `create`, `update`, and `patch` requests.  |
| OpenVPN client | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}. Additionally, the pod configuration is now obtained from a secret instead of from a ConfigMap.  |
| OpenVPN server | 2.4.6-r3-IKS-8 | 2.4.6-r3-IKS-13 | Updated image for [CVE-2018-0734](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0734){: external} and [CVE-2018-5407](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5407){: external}.  |
| `systemd` | 230 | 229 | Security patch for [CVE-2018-16864](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16864){: external}. |
{: caption="Table 1. Changes since version 1.10.12_1541" caption-side="bottom"}


## Change log for worker node fix pack 1.10.12_1541, released 28 January 2019
{: #11012_1541}

The following table shows the changes that are in the worker node fix pack 1.10.12_1541.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages including `apt` for [CVE-2019-3462](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3462){: external} and [USN-3863-1](https://ubuntu.com/security/notices/USN-3863-1){: external}. |
{: caption="Table 1. Changes since version 1.10.12_1540" caption-side="bottom"}


## Change log for 1.10.12_1540, released 21 January 2019
{: #11012_1540}

The following table shows the changes that are in the patch 1.10.12_1540.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.11-219 | v1.10.12-252 | Updated to support the Kubernetes 1.10.12 release.  |
| Kubernetes | v1.10.11 | v1.10.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.12){: external}.  |
| Kubernetes add-on resizer | 1.8.1 | 1.8.4 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.4){: external}.  |
| Kubernetes dashboard | v1.8.3 | v1.10.1 | See the [Kubernetes dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v1.10.1){: external}. Update resolves [CVE-2018-18264](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-18264){: external}.  \n If you access the dashboard via `kubectl proxy`, the **SKIP** button on the login page is removed. Instead, [use a **Token** to log in](/docs/containers?topic=containers-deploy_app#cli_dashboard).  |
| GPU installer | 390.12 | 410.79 | Updated the installed GPU drivers to 410.79. |
{: caption="Table 1. Changes since version 1.10.11_1538" caption-side="bottom"}


## Change log for worker node fix pack 1.10.11_1538, released 7 January 2019
{: #11011_1538}

The following table shows the changes that are in the worker node fix pack 1.10.11_1538.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-139 | 4.4.0-141 | Updated worker node images with kernel update for [CVE-2017-5753, CVE-2018-18690](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-141.167/changelog){: external}. |
{: caption="Table 1. Changes since version 1.10.11_1537" caption-side="bottom"}


## Change log for worker node fix pack 1.10.11_1537, released 17 December 2018
{: #11011_1537}

The following table shows the changes that are in the worker node fix pack 1.10.11_1537.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. 
{: caption="Table 1. Changes since version 1.10.11_1536" caption-side="bottom"}


## Change log for 1.10.11_1536, released 4 December 2018
{: #11011_1536}

The following table shows the changes that are in patch 1.10.11_1536.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.2.1 | v3.3.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}. Update resolves [Tigera Technical Advisory TTA-2018-001](https://www.tigera.io/security-bulletins/){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.8-197 | v1.10.11-219 | Updated to support the Kubernetes 1.10.11 release.  |
| Kubernetes | v1.10.8 | v1.10.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.11){: external}. Update resolves [CVE-2018-1002105](https://github.com/kubernetes/kubernetes/issues/71411){: external}.  |
| OpenVPN client and server | 2.4.4-r1-6 | 2.4.6-r3-IKS-8 | Updated image for [CVE-2018-0732](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external} and [CVE-2018-0737](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external}.  |
| Worker node resource utilization | N/A | N/A | Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Table 1. Changes since version 1.10.8_1532" caption-side="bottom"}


## Change log for worker node fix pack 1.10.8_1532, released 27 November 2018
{: #1108_1532}

The following table shows the changes that are in the worker node fix pack 1.10.8_1532.
{: shortdesc}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Docker | 17.06.2 | 18.06.1 | See the [Docker release notes](https://docs.docker.com/engine/release-notes/23.0/#18061-ce){: external}. |
{: caption="Table 1. Changes since version 1.10.8_1531" caption-side="bottom"}

## Change log for worker node fix pack 1.10.8_1531, released 19 November 2018
{: #1108_1531}

The following table shows the changes that are in the worker node fix pack 1.10.8_1531.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-137 | 4.4.0-139 | Updated worker node images with kernel update for [CVE-2018-7755](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog){: external}. |
{: caption="Table 1. Changes since version 1.10.8_1530" caption-side="bottom"}

## Change log for 1.10.8_1530, released 7 November 2018
{: #1108_1530_ha-master}

The following table shows the changes that are in patch 1.10.8_1530.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster master | N/A | N/A | Updated the cluster master configuration to increase high availability (HA). Clusters now have three Kubernetes master replicas that are set up with a highly available (HA) configuration, with each master deployed on separate physical hosts. Further, if your cluster is in a multizone-capable zone, the masters are spread across zones.  |
| Cluster master HA proxy | N/A | 1.8.12-alpine | Added an `ibm-master-proxy-*` pod for client-side load balancing on all worker nodes, so that each worker node client can route requests to an available HA master replica.  |
| etcd | v3.2.18 | v3.3.1 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.3.1](https://github.com/etcd-io/etcd/releases/v3.3.1){: external}.  |
| Encrypting data in etcd | N/A | N/A | Previously, etcd data was stored on a master’s NFS file storage instance that is encrypted at rest. Now, etcd data is stored on the master’s local disk and backed up to {{site.data.keyword.cos_full_notm}}. Data is encrypted during transit to {{site.data.keyword.cos_full_notm}} and at rest. However, the etcd data on the master’s local disk is not encrypted. If you want your master’s local etcd data to be encrypted, [enable {{site.data.keyword.keymanagementservicelong_notm}} in your cluster](/docs/containers?topic=containers-encryption#keyprotect).  |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.8-172 | v1.10.8-197 | Added the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan` annotation to specify the VLAN that the load balancer service deploys to. To see available VLANs in your cluster, run `ibmcloud ks vlan ls --zone <zone>`.  |
| TPM-enabled kernel | N/A | N/A | Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers?topic=containers-kubernetes-service-cli) on an existing cluster, you need to [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **Trustable** field after running the `ibmcloud ks flavors --zone` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_machine_types). |
{: caption="Table 1. Changes since version 1.10.8_1528" caption-side="bottom"}


## Change log for worker node fix pack 1.10.8_1528, released 26 October 2018
{: #1108_1528}

The following table shows the changes that are in the worker node fix pack 1.10.8_1528.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| OS interrupt handling | N/A | N/A | Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler. 
{: caption="Table 1. Changes since version 1.10.8_1527" caption-side="bottom"}

## Change log for master fix pack 1.10.8_1527, released 15 October 2018
{: #1108_1527}

The following table shows the changes that are in the master fix pack 1.10.8_1527.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico configuration | N/A | N/A | Fixed `calico-node` container readiness probe to better handle node failures.  |
| Cluster update | N/A | N/A | Fixed problem with updating cluster add-ons when the master is updated from an unsupported version. 
{: caption="Table 1. Changes since version 1.10.8_1524" caption-side="bottom"}


## Change log for worker node fix pack 1.10.8_1525, released 10 October 2018
{: #1108_1525}

The following table shows the changes that are in the worker node fix pack 1.10.8_1525.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-133 | 4.4.0-137 | Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog){: external}.  |
| Inactive session timeout | N/A | N/A | Set the inactive session timeout to 5 minutes for compliance reasons. 
{: caption="Table 1. Changes since version 1.10.8_1524" caption-side="bottom"}


## Change log for 1.10.8_1524, released 2 October 2018
{: #1108_1524}

The following table shows the changes that are in patch 1.10.8_1524.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Key Management Service Provider | N/A | N/A | Added the ability to use the Kubernetes [key management service (KMS) provider](/docs/containers?topic=containers-encryption#keyprotect) in the cluster, to support {{site.data.keyword.keymanagementservicefull}}. When you [enable {{site.data.keyword.keymanagementserviceshort}} or a key management service (KMS) provider in your cluster](/docs/containers?topic=containers-encryption#keyprotect), all your Kubernetes secrets are encrypted.  |
| Kubernetes | v1.10.7 | v1.10.8 | See the [Kubernetes release notes (https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8){: external}.  |
| Kubernetes DNS autoscaler | 1.1.2-r2 | 1.2.0 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.2.0){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.7-146 | v1.10.8-172 | Updated to support Kubernetes 1.10.8 release. Also, updated the documentation link in load balancer error messages.  |
| IBM file storage classes | N/A | N/A | Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.  \n  Also, now when you update the cluster master, the default IBM file storage class remains unchanged. If you want to set your own default, see [Changing the default storage class](/docs/containers?topic=containers-kube_concepts#default_storageclass). |
{: caption="Table 1. Changes since version 1.10.7_1520" caption-side="bottom"}


## Change log for worker node fix pack 1.10.7_1521, released 20 September 2018
{: #1107_1521}

The following table shows the changes that are in the worker node fix pack 1.10.7_1521.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Log rotate | N/A | N/A | Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) or the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update).  |
| Worker node runtime components (`kubelet`, `kube-proxy`, `docker`) | N/A | N/A | Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up.  |
| Root password expiration | N/A | N/A | Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can [update](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days.  |
| `systemd` | N/A | N/A | Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345](https://github.com/kubernetes/kubernetes/issues/57345){: external}.  |
| Docker | N/A | N/A | Disabled the default Docker bridge so that the `172.17.0.0/16` IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing `docker` commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options. \n - To ensure external network connectivity when you build the container, run `docker build . --network host`. \n - To explicitly create a network to use when you build the container, run `docker network create` and then use this network. \n **Note**: Have dependencies on the Docker socket or Docker directly? Update to `containerd` instead of `docker` as the container runtime so that your clusters are prepared to run Kubernetes version 1.11 or later. |
{: caption="Table 1. Changes since version 1.10.7_1520" caption-side="bottom"}


## Change log for 1.10.7_1520, released 4 September 2018
{: #1107_1520}

The following table shows the changes that are in patch 1.10.7_1520.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.1.3 | v3.2.1 | See the Calico [release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.5-118 | v1.10.7-146 | Updated to support Kubernetes 1.10.7 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`.  |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 334 | 338 | Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You can't update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.  \n Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers?topic=containers-file_storage#nfs_version_class).  |
| Kubernetes | v1.10.5 | v1.10.7 | See the Kubernetes [release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7){: external}.  |
| Kubernetes Heapster configuration | N/A | N/A | Increased resource limits for the `heapster-nanny` container. |
{: caption="Table 1. Changes since version 1.10.5_1519" caption-side="bottom"}


## Change log for worker node fix pack 1.10.5_1519, released 23 August 2018
{: #1105_1519}

The following table shows the changes that are in the worker node fix pack 1.10.5_1519.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| `systemd` | 229 | 230 | Updated `systemd` to fix `cgroup` leak.  |
| Kernel | 4.4.0-127 | 4.4.0-133 | Updated worker node images with kernel update for [CVE-2018-3620,CVE-2018-3646](https://ubuntu.com/security/notices/USN-3741-1){: external}. |
{: caption="Table 1. Changes since version 1.10.5_1518" caption-side="bottom"}


## Change log for worker node fix pack 1.10.5_1518, released 13 August 2018
{: #1105_1518}

The following table shows the changes that are in the worker node fix pack 1.10.5_1518.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
{: caption="Table 1. Changes since version 1.10.5_1517" caption-side="bottom"}


## Change log for 1.10.5_1517, released 27 July 2018
{: #1105_1517}

The following table shows the changes that are in patch 1.10.5_1517.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v3.1.1 | v3.1.3 | See the Calico [release notes](https://docs.tigera.io/calico/latest/release-notes//){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.3-85 | v1.10.5-118 | Updated to support Kubernetes 1.10.5 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors.  |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 320 | 334 | Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes.  |
| Kubernetes | v1.10.3 | v1.10.5 | See the Kubernetes [release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5){: external}.  |
| Kernel | N/A | N/A | Minor improvements to worker node network settings for high performance networking workloads.  |
| OpenVPN client | N/A | N/A | The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`. |
{: caption="Table 1. Changes since version 1.10.3_1514" caption-side="bottom"}

## Change log for worker node fix pack 1.10.3_1514, released 3 July 2018
{: #1103_1514}

The following table shows the changes that are in the worker node fix pack 1.10.3_1514.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | N/A | N/A | Optimized `sysctl` for high performance networking workloads. 
{: caption="Table 1. Changes since version 1.10.3_1513" caption-side="bottom"}


## Change log for worker node fix pack 1.10.3_1513, released 21 June 2018
{: #1103_1513}

The following table shows the changes that are in the worker node fix pack 1.10.3_1513.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Docker | N/A | N/A | For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node. 
{: caption="Table 1. Changes since version 1.10.3_1512" caption-side="bottom"}

## Change log for 1.10.3_1512, released 12 June 2018
{: #1103_1512}

The following table shows the changes that are in patch 1.10.3_1512.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.10.1 | v1.10.3 | See the Kubernetes [release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3){: external}.  |
| Kubernetes Configuration | N/A | N/A | Added `PodSecurityPolicy` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers?topic=containers-psp).  |
| Kubelet Configuration | N/A | N/A | Enabled the `--authentication-token-webhook` option to support API bearer and service account tokens for authenticating to the `kubelet` HTTPS endpoint.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.10.1-52 | v1.10.3-85 | Updated to support Kubernetes 1.10.3 release.  |
| OpenVPN client | N/A | N/A | Added `livenessProbe` to the OpenVPN client `vpn` deployment that runs in the `kube-system` namespace.  |
| Kernel update | 4.4.0-116 | 4.4.0-127 | New worker node images with kernel update for [CVE-2018-3639](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639){: external}. 
{: caption="Table 1. Changes since version 1.10.1_1510" caption-side="bottom"}



## Change log for worker node fix pack 1.10.1_1510, released 18 May 2018
{: #1101_1510}

The following table shows the changes that are in the worker node fix pack 1.10.1_1510.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | Fix to address a bug that occurred if you used the block storage plug-in. |
{: caption="Table 1. Changes since version 1.10.1_1509" caption-side="bottom"}


## Change log for worker node fix pack 1.10.1_1509, released 16 May 2018
{: #1101_1509}

The following table shows the changes that are in the worker node fix pack 1.10.1_1509.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine. |
{: caption="Table 1. Changes since version 1.10.1_1508" caption-side="bottom"}


## Change log for 1.10.1_1508, released 01 May 2018
{: #1101_1508}

The following table shows the changes that are in patch 1.10.1_1508.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v2.6.5 | v3.1.1 | See the Calico [release notes](https://projectcalico.docs.tigera.io/release-notes/){: external}.  |
| Kubernetes Heapster | v1.5.0 | v1.5.2 | See the Kubernetes Heapster [release notes](https://github.com/kubernetes-retired/heapster/releases/tag/v1.5.2){: external}.  |
| Kubernetes | v1.9.7 | v1.10.1 | See the Kubernetes [release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1){: external}.  |
| Kubernetes Configuration | N/A | N/A | Added `StorageObjectInUseProtection` to the `--enable-admission-plugins` option for the cluster's Kubernetes API server.  |
| Kubernetes DNS | 1.14.8 | 1.14.10 | See the Kubernetes DNS [release notes](https://github.com/kubernetes/dns/releases/tag/1.14.10){: external}.  |
| {{site.data.keyword.cloud_notm}} Provider | v1.9.7-102 | v1.10.1-52 | Updated to support Kubernetes 1.10 release.  |
| GPU support | N/A | N/A | Support for [graphics processing unit (GPU) container workloads](/docs/containers?topic=containers-deploy_app#gpu_app) is now available for scheduling and execution. For a list of available GPU flavors, see [Hardware for worker nodes](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes). For more information, see the Kubernetes documentation to [Schedule GPUs](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/){: external}. |
{: caption="Table 1. Changes since version 1.9.7_1510" caption-side="bottom"}

