---

copyright:
 years: 2014, 2023
lastupdated: "2023-03-29"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}




# Version 1.9 change log (unsupported as of 27 December 2018)
{: #19_changelog}


Review the version 1.9 change logs.
{: shortdesc}


## Change log for worker node fix pack 1.9.11_1539, released 17 December 2018
{: #1911_1539}

The following table shows the changes that are in the worker node fix pack 1.9.11_1539.
{: shortdesc}


| Component | Previous | Current | Description || -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
{: caption="Table 1. Changes since version 1.9.11_1538" caption-side="bottom"}

## Change log for worker node fix pack 1.9.11_1538, released 4 December 2018
{: #1911_1538}

The following table shows the changes that are in the worker node fix pack 1.9.11_1538.
{: shortdesc}

| Component | Previous | Current | Description || -------------- | -------------- | -------------- | ------------- |
| Worker node resource utilization | N/A | N/A | Added dedicated cgroups for the kubelet and docker to prevent these components from running out of resources. For more information, see [Worker node resource reserves](/docs/containers?topic=containers-planning_worker_nodes#resource_limit_node). |
{: caption="Table 1. Changes since version 1.9.11_1537" caption-side="bottom"}


## Change log for worker node fix pack 1.9.11_1537, released 27 November 2018
{: #1911_1537}

The following table shows the changes that are in the worker node fix pack 1.9.11_1537.
{: shortdesc}

| Component | Previous | Current | Description || -------------- | -------------- | -------------- | ------------- |
| Docker | 17.06.2 | 18.06.1 | See the [Docker release notes](https://docs.docker.com/engine/release-notes/23.0/#18061-ce){: external} |
{: caption="Table 1. Changes since version 1.9.11_1536" caption-side="bottom"}


## Change log for 1.9.11_1536, released 19 November 2018
{: #1911_1536}

The following table shows the changes that are in patch 1.9.11_1536.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Calico | v2.6.5 | v2.6.12 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/.){: external} {: external} Update resolves [Tigera Technical Advisory TTA-2018-001](https://www.tigera.io/security-bulletins/){: external} |
| Kernel | 4.4.0-137 | 4.4.0-139 | Updated worker node images with kernel update for  [CVE-2018-7755](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-139.165/changelog){: external} |
| Kubernetes | v1.9.10 | v1.9.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.11){: external} |
| {{site.data.keyword.cloud_notm}} | v1.9.10-219 | v1.9.11-249 | Updated to support the Kubernetes 1.9.11 release. |
| OpenVPN client and server | 2.4.4-r2 | 2.4.6-r3-IKS-8 | Updated image for  [CVE-2018-0732](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0732){: external} and  [CVE-2018-0737](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-0737){: external} |
{: caption="Table 1. Changes since version 1.9.10_1532" caption-side="bottom"}


## Change log for worker node fix 1.9.10_1532, released 7 November 2018
{: #1910_1532}

The following table shows the changes that are in the worker node fix pack 1.9.11_1532.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| TPM-enabled kernel | N/A | N/A | Bare metal worker nodes with TPM chips for Trusted Compute use the default Ubuntu kernel until trust is enabled. If you [enable trust](/docs/containers?topic=containers-kubernetes-service-cli) on an existing cluster, you need to [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) any existing bare metal worker nodes with TPM chips. To check if a bare metal worker node has a TPM chip, review the **`Trustable`** field after running the `ibmcloud ks flavors --zone` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_machine_types). |
{: caption="Table 1. Changes since version 1.9.10_1531" caption-side="bottom"}

## Change log for worker node fix pack 1.9.10_1531, released 26 October 2018
{: #1910_1531}

The following table shows the changes that are in the worker node fix pack 1.9.10_1531.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| OS interrupt handling | N/A | N/A | Replaced the interrupt request (IRQ) system daemon with a more performant interrupt handler. |
{: caption="Table 1. Changes since version 1.9.10_1530" caption-side="bottom"}


## Change log for master fix pack 1.9.10_1530 released 15 October 2018
{: #1910_1530}

The following table shows the changes that are in the worker node fix pack 1.9.10_1530.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Cluster update | N/A | N/A | Fixed problem with updating cluster add-ons when the master is updated from an unsupported version. |
{: caption="Table 1. Changes since version 1.9.10_1527" caption-side="bottom"}


## Change log for worker node fix pack 1.9.10_1528, released 10 October 2018
{: #1910_1528}

The following table shows the changes that are in the worker node fix pack 1.9.10_1528.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | 4.4.0-133 | 4.4.0-137 | Updated worker node images with kernel update for [CVE-2018-14633, CVE-2018-17182](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog){: external} {: external} |
| Inactive session timeout | N/A | N/A | Set the inactive session timeout to 5 minutes for compliance reasons. |
{: caption="Table 1. Changes since version 1.9.10_1527" caption-side="bottom"}



## Change log for 1.9.10_1527, released 2 October 2018
{: #1910_1527}

The following table shows the changes that are in patch 1.9.10_1527.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.9.10-192 | v1.9.10-219 | Updated the documentation link in load balancer error messages. |
| {{site.data.keyword.cloud_notm}} file storage classes | N/A | N/A | Removed `mountOptions` in the IBM file storage classes to use the default that is provided by the worker node. Removed duplicate `reclaimPolicy` parameter in the IBM file storage classes.  \n Also, now when you update the cluster master, the default IBM file storage class remains unchanged. |
{: caption="Table 1. Changes since version 1.9.10_1523" caption-side="bottom"}


## Change log for worker node fix pack 1.9.10_1524, released 20 September 2018
{: #1910_1524}

The following table shows the changes that are in the worker node fix pack 1.9.10_1524.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Log rotate | N/A | N/A | Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the `ibmcloud ks worker reload` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) or the `ibmcloud ks worker update` [command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update). |
| Worker node runtime components (`kubelet`, `kube-proxy`, `docker`) | N/A | N/A | Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up. |
| Root password expiration | N/A | N/A | Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can [update](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days. |
| `systemd` | N/A | N/A | Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345](https://github.com/kubernetes/kubernetes/issues/57345){: external} |
| Docker | N/A | N/A | Disabled the default Docker bridge so that the `172.17.0.0/16` IP range is now used for private routes. If you rely on building Docker containers in worker nodes by executing `docker` commands on the host directly or by using a pod that mounts the Docker socket, choose from the following options. \n - To ensure external network connectivity when you build the container, run `docker build . --network host`. \n - To explicitly create a network to use when you build the container, run `docker network create` and then use this network. \n **Note**: Have dependencies on the Docker socket or Docker directly? Update to `containerd` instead of `docker` as the container runtime so that your clusters are prepared to run Kubernetes version 1.11 or later. |
{: caption="Table 1. Changes since version 1.9.10_1523" caption-side="bottom"}


## Change log for 1.9.10_1523, released 4 September 2018
{: #1910_1523}

The following table shows the changes that are in patch 1.9.10_1523.
{: shortdesc}


| Component | Previous | Current | Description || -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.9.9-167 | v1.9.10-192 | Updated to support Kubernetes 1.9.10 release. In addition, changed the cloud provider configuration to better handle updates for load balancer services with `externalTrafficPolicy` set to `local`. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 334 | 338 | Updated incubator version to 1.8. File storage is provisioned to the specific zone that you select. You can't update an existing (static) PV instance's labels, unless you are using a multizone cluster and need to add the region and zone labels.  \n Removed the default NFS version from the mount options in the IBM-provided file storage classes. The host's operating system now negotiates the NFS version with the IBM Cloud infrastructure NFS server. To manually set a specific NFS version, or to change the NFS version of your PV that was negotiated by the host's operating system, see [Changing the default NFS version](/docs/containers?topic=containers-file_storage#nfs_version_class). |
| Kubernetes | v1.9.9 | v1.9.10 | See the Kubernetes [release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10){: external} |
| Kubernetes Heapster configuration | N/A | N/A | Increased resource limits for the `heapster-nanny` container. |
{: caption="Table 1. Changes since version 1.9.9_1522" caption-side="bottom"}

## Change log for worker node fix pack 1.9.9_1522, released 23 August 2018
{: #199_1522}

The following table shows the changes that are in the worker node fix pack 1.9.9_1522.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| `systemd` | 229 | 230 | Updated `systemd` to fix `cgroup` leak. |
| Kernel | 4.4.0-127 | 4.4.0-133 | Updated worker node images with kernel update for  [CVE-2018-3620,CVE-2018-3646](https://ubuntu.com/security/notices/USN-3741-1){: external} |
{: caption="Table 1. Changes since version 1.9.9_1521" caption-side="bottom"}


## Change log for worker node fix pack 1.9.9_1521, released 13 August 2018
{: #199_1521}

The following table shows the changes that are in the worker node fix pack 1.9.9_1521.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
{: caption="Table 1. Changes since version 1.9.9_1520" caption-side="bottom"}

## Change log for 1.9.9_1520, released 27 July 2018
{: #199_1520}

The following table shows the changes that are in patch 1.9.9_1520.
{: shortdesc}


| Component | Previous | Current | Description || -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.9.8-141 | v1.9.9-167 | Updated to support Kubernetes 1.9.9 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 320 | 334 | Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes. |
| Kubernetes | v1.9.8 | v1.9.9 | See the Kubernetes [release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9){: external} {: external} |
| Kernel | N/A | N/A | Minor improvements to worker node network settings for high performance networking workloads. |
| OpenVPN client | N/A | N/A | The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`. |
{: caption="Table 1. Changes since version 1.9.8_1517" caption-side="bottom"}


## Change log for worker node fix pack 1.9.8_1517, released 3 July 2018
{: #198_1517}

The following table shows the changes that are in the worker node fix pack 1.9.8_1517.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | N/A | N/A | Optimized `sysctl` for high performance networking workloads. |
{: caption="Table 1. Changes since version 1.9.8_1516" caption-side="bottom"}


## Change log for worker node fix pack 1.9.8_1516, released 21 June 2018
{: #198_1516}

The following table shows the changes that are in the worker node fix pack 1.9.8_1516.
{: shortdesc}



| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Docker | N/A | N/A | For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node. |
{: caption="Table 1. Changes since version 1.9.8_1515" caption-side="bottom"}

## Change log for 1.9.8_1515, released 19 June 2018
{: #198_1515}

The following table shows the changes that are in patch 1.9.8_1515.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.9.7 | v1.9.8 | See th [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8]{: external} |
| Kubernetes Configuration | N/A | N/A | Added `PodSecurityPolicy` to the `--admission-control` option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see (/docs/containers?topic=containers-psp) [Configuring pod security policies]. |
| {{site.data.keyword.cloud_notm}} Provider | v1.9.7-102 | v1.9.8-141 | Updated to support Kubernetes 1.9.8 release. |
| OpenVPN client | N/A | N/A | Added `livenessProbe` to the OpenVPN client `vpn` deployment that runs in the `kube-system` namespace. |
{: caption="Table 1. Changes since version 1.9.7_1513" caption-side="bottom"}


## Change log for worker node fix pack 1.9.7_1513, released 11 June 2018
{: #197_1513}

The following table shows the changes that are in the worker node fix pack 1.9.7_1513.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel update | 4.4.0-116 | 4.4.0-127 | New worker node images with kernel update for [CVE-2018-3639](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639){: external} |
{: caption="Table 1. Changes since version 1.9.7_1512" caption-side="bottom"}

## Change log for worker node fix pack 1.9.7_1512, released 18 May 2018
{: #197_1512}

The following table shows the changes that are in the worker node fix pack 1.9.7_1512.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | Fix to address a bug that occurred if you used the block storage plug-in. |
{: caption="Table 1. Changes since version 1.9.7_1511" caption-side="bottom"}

## Change log for worker node fix pack 1.9.7_1511, released 16 May 2018
{: #197_1511}

The following table shows the changes that are in the worker node fix pack 1.9.7_1511.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine. |
{: caption="Table 1. Changes since version 1.9.7_1510" caption-side="bottom"}

## Change log for 1.9.7_1510, released 30 April 2018
{: #197_1510}

The following table shows the changes that are in patch 1.9.7_1510.
{: shortdesc}


| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.9.3 | v1.9.7     | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7){: external} This release addresses  [CVE-2017-1002101](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101){: external} and [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102){: external}  vulnerabilities.  \n **Note**: Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly. |
| Kubernetes configuration | N/A | N/A | Added `admissionregistration.k8s.io/v1alpha1=true` to the `--runtime-config` option for the cluster's Kubernetes API server. |
| {{site.data.keyword.cloud_notm}} Provider | v1.9.3-71 | v1.9.7-102 | `NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers?topic=containers-loadbalancer#lb_source_ip) by setting `service.spec.externalTrafficPolicy` to `Local`. |
| General | N/A | N/A | Fix [edge node](/docs/containers?topic=containers-edge#edge) toleration setup for older clusters. |
{: caption="Table 1. Changes since version 1.9.3_1506" caption-side="bottom"}
