---

copyright:
 years: 2014, 2023
lastupdated: "2023-01-11"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Version 1.8 changelog (Unsupported)
{: #18_changelog}


Review the version 1.8 changelogs.
{: shortdesc}

## Change log for worker node fix pack 1.8.15_1521, released 20 September 2018
{: #1815_1521}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Log rotate | N/A | N/A | Switched to use `systemd` timers instead of `cronjobs` to prevent `logrotate` from failing on worker nodes that are not reloaded or updated within 90 days. **Note**: In all earlier versions for this minor release, the primary disk fills up after the cron job fails because the logs are not rotated. The cron job fails after the worker node is active for 90 days without being updated or reloaded. If the logs fill up the entire primary disk, the worker node enters a failed state. The worker node can be fixed by using the [`ibmcloud ks worker reload` command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) or the [`ibmcloud ks worker update` command](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update). |
| Worker node runtime components (`kubelet`, `kube-proxy`, `docker`) | N/A | N/A | Removed dependencies of runtime components on the primary disk. This enhancement prevents worker nodes from failing when the primary disk is filled up. |
| Root password expiration | N/A | N/A | Root passwords for the worker nodes expire after 90 days for compliance reasons. If your automation tooling needs to log in to the worker node as root or relies on cron jobs that run as root, you can disable the password expiration by logging into the worker node and running `chage -M -1 root`. **Note**: If you have security compliance requirements that prevent running as root or removing password expiration, don't disable the expiration. Instead, you can [update](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) or [reload](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) your worker nodes at least every 90 days. |
| `systemd` | N/A | N/A | Periodically clean transient mount units to prevent them from becoming unbounded. This action addresses [Kubernetes issue 57345](https://github.com/kubernetes/kubernetes/issues/57345){: external} |
{: caption="Table 1. Changes since version 1.8.15_1520" caption-side="bottom"}


## Change log for worker node fix pack 1.8.15_1520, released 23 August 2018
{: #1815_1520}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| `systemd` | 229 | 230 | Updated `systemd` to fix `cgroup` leak. |
| Kernel | 4.4.0-127 | 4.4.0-133 | Updated worker node images with kernel update for  [CVE-2018-3620,CVE-2018-3646](https://ubuntu.com/security/notices/USN-3741-1){: external} |
{: caption="Table 1. Changes since version 1.8.15_1519" caption-side="bottom"}


## Change log for worker node fix pack 1.8.15_1519, released 13 August 2018
{: #1815_1519}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Ubuntu packages | N/A | N/A | Updates to installed Ubuntu packages. |
{: caption="Table 1. Changes since version 1.8.15_1518" caption-side="bottom"}


## Change log for 1.8.15_1518, released 27 July 2018
{: #1815_1518}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| {{site.data.keyword.cloud_notm}} Provider | v1.8.13-176 | v1.8.15-204 | Updated to support Kubernetes 1.8.15 release. In addition, LoadBalancer service `create failure` events now include any portable subnet errors. |
| {{site.data.keyword.filestorage_full_notm}} plug-in | 320 | 334 | Increased the timeout for persistent volume creation from 15 to 30 minutes. Changed the default billing type to `hourly`. Added mount options to the pre-defined storage classes. In the NFS file storage instance in your IBM Cloud infrastructure account, changed the **Notes** field to JSON format and added the Kubernetes namespace that the PV is deployed to. To support multizone clusters, added zone and region labels to persistent volumes. |
| Kubernetes | v1.8.13 | v1.8.15 | See the Kubernetes [release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15){: external} |
| Kernel | N/A | N/A | Minor improvements to worker node network settings for high performance networking workloads. |
| OpenVPN client | N/A | N/A | The OpenVPN client `vpn` deployment that runs in the `kube-system` namespace is now managed by the Kubernetes `addon-manager`. |
{: caption="Table 1. Changes since version 1.8.13_1516" caption-side="bottom"}


## Change log for worker node fix pack 1.8.13_1516, released 3 July 2018
{: #1813_1516}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel | N/A | N/A | Optimized `sysctl` for high performance networking workloads. |
{: caption="Table 1. Changes since version 1.8.13_1515" caption-side="bottom"}


## Change log for worker node fix pack 1.8.13_1515, released 21 June 2018
{: #1813_1515}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Docker | N/A | N/A | For non-encrypted flavors, the secondary disk is cleaned by getting a fresh file system when you reload or update the worker node. |
{: caption="Table 1. Changes since version 1.8.13_1514" caption-side="bottom"}


## Changelog 1.8.13_1514, released 19 June 2018
{: #1813_1514}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.8.11 | v1.8.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13]{: external} |
| Kubernetes Configuration | N/A | N/A | Added `PodSecurityPolicy` to the `--admission-control` option for the cluster's Kubernetes API server and configured the cluster to support pod security policies. For more information, see [Configuring pod security policies](/docs/containers?topic=containers-psp). |
| {{site.data.keyword.cloud_notm}} Provider | v1.8.11-126 | v1.8.13-176 | Updated to support Kubernetes 1.8.13 release. |
| OpenVPN client | N/A | N/A | Added `livenessProbe` to the OpenVPN client `vpn` deployment that runs in the `kube-system` namespace. |
{: caption="Table 1. Changes since version 1.8.11_1512" caption-side="bottom"}


## Change log for worker node fix pack 1.8.11_1512, released 11 June 2018
{: #1811_1512}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kernel update | 4.4.0-116 | 4.4.0-127 | New worker node images with kernel update for [CVE-2018-3639](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639){: external} |
{: caption="Table 1. Changes since version 1.8.11_1511" caption-side="bottom"}


## Change log for worker node fix pack 1.8.11_1511, released 18 May 2018
{: #1811_1511}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | Fix to address a bug that occurred if you used the block storage plug-in. |
{: caption="Table 1. Changes since version 1.8.11_1510" caption-side="bottom"}


## Change log for worker node fix pack 1.8.11_1510, released 16 May 2018
{: #1811_1510}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubelet | N/A | N/A | The data that you store in the `kubelet` root directory is now saved on the larger, secondary disk of your worker node machine. |
{: caption="Table 1. Changes since version 1.8.11_1509" caption-side="bottom"}


## Change log for 1.8.11_1509, released 19 April 2018
{: #1811_1509}

| Component | Previous | Current | Description |
| -------------- | -------------- | -------------- | ------------- |
| Kubernetes | v1.8.8 | v1.8.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11]{: external}. This release addresses  [CVE-2017-1002101](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101){: external}[ and [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102){: external}[ vulnerabilities.  \n Now `secret`, `configMap`, `downwardAPI`, and projected volumes are mounted as read-only. Previously, apps could write data to these volumes, but the system could automatically revert the data. If your apps rely on the previous insecure behavior, modify them accordingly. |
| Pause container image | 3.0 | 3.1 | Removes inherited orphaned zombie processes. |
| {{site.data.keyword.cloud_notm}} Provider | v1.8.8-86 | v1.8.11-126 | `NodePort` and `LoadBalancer` services now support [preserving the client source IP](/docs/containers?topic=containers-loadbalancer#lb_source_ip) by setting `service.spec.externalTrafficPolicy` to `Local`. |
| General | N/A | N/A | Fix [edge node](/docs/containers?topic=containers-edge#edge) toleration setup for older clusters. |
{: caption="Table 1. Changes since version 1.8.8_1507" caption-side="bottom"}
