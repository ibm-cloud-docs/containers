---

copyright: 
  years: 2023, 2023
lastupdated: "2023-11-15"

keywords: kubernetes, containers, change log, 128 change log, 128 updates

subcollection: containers


---

# Kubernetes version 1.28 change log
{: #changelog_128}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.28. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_128}

In clusters that run version 1.23 or earlier, the {{site.data.keyword.cloud_notm}} provider version enables Kubernetes APIs and features that are at beta. In version 1.24 and later, most new beta features are disabled by default. Kubernetes alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}




## Version 1.28 change log
{: #128_changelog}


Review the version 1.28 change log.
{: shortdesc}



### Change log for worker node fix pack 1.28.2_1533, released 08 November 2023
{: #1282_1533_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1533. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|Ubuntu 20.04 packages | 5.4.0-165-generic | 5.4.0-166-generic | Worker node kernel & package updates for [CVE-2023-0597](https://nvd.nist.gov/vuln/detail/CVE-2023-0597){: external}, [CVE-2023-31083](https://nvd.nist.gov/vuln/detail/CVE-2023-31083){: external}, [CVE-2023-34058](https://nvd.nist.gov/vuln/detail/CVE-2023-34058){: external}, [CVE-2023-34059](https://nvd.nist.gov/vuln/detail/CVE-2023-34059){: external}, [CVE-2023-34319](https://nvd.nist.gov/vuln/detail/CVE-2023-34319){: external}, [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}, [CVE-2023-3772](https://nvd.nist.gov/vuln/detail/CVE-2023-3772){: external}, [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}, [CVE-2023-4132](https://nvd.nist.gov/vuln/detail/CVE-2023-4132){: external}, [CVE-2023-42752](https://nvd.nist.gov/vuln/detail/CVE-2023-42752){: external}, [CVE-2023-42753](https://nvd.nist.gov/vuln/detail/CVE-2023-42753){: external}, [CVE-2023-42755](https://nvd.nist.gov/vuln/detail/CVE-2023-42755){: external}, [CVE-2023-42756](https://nvd.nist.gov/vuln/detail/CVE-2023-42756){: external}, [CVE-2023-4622](https://nvd.nist.gov/vuln/detail/CVE-2023-4622){: external}, [CVE-2023-4623](https://nvd.nist.gov/vuln/detail/CVE-2023-4623){: external}, [CVE-2023-4733](https://nvd.nist.gov/vuln/detail/CVE-2023-4733){: external}, [CVE-2023-4735](https://nvd.nist.gov/vuln/detail/CVE-2023-4735){: external}, [CVE-2023-4750](https://nvd.nist.gov/vuln/detail/CVE-2023-4750){: external}, [CVE-2023-4751](https://nvd.nist.gov/vuln/detail/CVE-2023-4751){: external}, [CVE-2023-4752](https://nvd.nist.gov/vuln/detail/CVE-2023-4752){: external}, [CVE-2023-4781](https://nvd.nist.gov/vuln/detail/CVE-2023-4781){: external}, [CVE-2023-4881](https://nvd.nist.gov/vuln/detail/CVE-2023-4881){: external}, [CVE-2023-4921](https://nvd.nist.gov/vuln/detail/CVE-2023-4921){: external}, [CVE-2023-5344](https://nvd.nist.gov/vuln/detail/CVE-2023-5344){: external}, [CVE-2023-5441](https://nvd.nist.gov/vuln/detail/CVE-2023-5441){: external}, [CVE-2023-5535](https://nvd.nist.gov/vuln/detail/CVE-2023-5535){: external}. |
| Containerd | 1.7.7 | 1.7.8 | see [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.8){: external}. |
{: caption="Changes since version 1.28.2_1532" caption-side="bottom"}


### Change log for master fix pack 1.28.2_1531, released 25 October 2023
{: #1282_1531_M}

The following table shows the changes that are in the master fix pack 1.28.2_1531. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.26.1 | v3.26.3 | See the [Calico release notes](https://docs.tigera.io/calico/latest/release-notes/#v3.26.3){: external}. |
| Cluster health image | v1.4.2 | v1.4.4 | New version contains updates and security fixes. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1390 | 1487 | New version contains security fixes. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.4.10 | v2.4.12 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.28.1-3 | v1.28.2-10 | New version contains updates and security fixes. The logic for the `service.kubernetes.io/ibm-load-balancer-cloud-provider-vpc-idle-connection-timeout` annotation has changed. The default idle timeout is dependent on your account settings. In most cases, this value is `50`. However some allowlisted accounts have larger timeout settings. If you don't set the annotation, your load balancers use the timeout setting in your account. You can explicitly specify the timeout by setting this annotation. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4e2f346 | f0d3265 | New version contains updates and security fixes. |
| Key Management Service provider | v2.8.2 | v2.8.4 | New version contains updates and security fixes. |
| Kubernetes NodeLocal DNS cache | 1.22.23 | 1.22.24 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.24){: external}. |
| Portieris admission controller | v0.13.6 | v0.13.8 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.8){: external}. |
{: caption="Changes since version 1.28.2_1527" caption-side="bottom"}


### Change log for worker node fix pack 1.28.2_1532, released 23 October 2023
{: #1282_1532_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-164-generic | 5.4.0-165-generic | Worker node kernel & package updates for [CVE-2022-3234](https://nvd.nist.gov/vuln/detail/CVE-2022-3234){: external}, [CVE-2022-3256](https://nvd.nist.gov/vuln/detail/CVE-2022-3256){: external}, [CVE-2022-3324](https://nvd.nist.gov/vuln/detail/CVE-2022-3324){: external}, [CVE-2022-3352](https://nvd.nist.gov/vuln/detail/CVE-2022-3352){: external}, [CVE-2022-3520](https://nvd.nist.gov/vuln/detail/CVE-2022-3520){: external}, [CVE-2022-3591](https://nvd.nist.gov/vuln/detail/CVE-2022-3591){: external}, [CVE-2022-3705](https://nvd.nist.gov/vuln/detail/CVE-2022-3705){: external}, [CVE-2022-4292](https://nvd.nist.gov/vuln/detail/CVE-2022-4292){: external}, [CVE-2022-4293](https://nvd.nist.gov/vuln/detail/CVE-2022-4293){: external}, [CVE-2023-34319](https://nvd.nist.gov/vuln/detail/CVE-2023-34319){: external}, [CVE-2023-38546](https://nvd.nist.gov/vuln/detail/CVE-2023-38546){: external}, [CVE-2023-42752](https://nvd.nist.gov/vuln/detail/CVE-2023-42752){: external}, [CVE-2023-42753](https://nvd.nist.gov/vuln/detail/CVE-2023-42753){: external}, [CVE-2023-42755](https://nvd.nist.gov/vuln/detail/CVE-2023-42755){: external}, [CVE-2023-42756](https://nvd.nist.gov/vuln/detail/CVE-2023-42756){: external}, [CVE-2023-4622](https://nvd.nist.gov/vuln/detail/CVE-2023-4622){: external}, [CVE-2023-4623](https://nvd.nist.gov/vuln/detail/CVE-2023-4623){: external}, [CVE-2023-4881](https://nvd.nist.gov/vuln/detail/CVE-2023-4881){: external}, [CVE-2023-4921](https://nvd.nist.gov/vuln/detail/CVE-2023-4921){: external}. |
|Ubuntu 18.04 packages (`s390x`)|4.15.0-218-generic|4.15.0-218-generic|Worker node kernel & package updates for [CVE-2020-19189](https://nvd.nist.gov/vuln/detail/CVE-2020-19189){: external}, [CVE-2023-4733](https://nvd.nist.gov/vuln/detail/CVE-2023-4733){: external}, [CVE-2023-4735](https://nvd.nist.gov/vuln/detail/CVE-2023-4735){: external}, [CVE-2023-4750](https://nvd.nist.gov/vuln/detail/CVE-2023-4750){: external}, [CVE-2023-4751](https://nvd.nist.gov/vuln/detail/CVE-2023-4751){: external}, [CVE-2023-5344](https://nvd.nist.gov/vuln/detail/CVE-2023-5344){: external}, [CVE-2023-5441](https://nvd.nist.gov/vuln/detail/CVE-2023-5441){: external}. |
|Ubuntu 20.04 packages (`s390x`)|5.4.0-164-generic|5.4.0-165-generic|Worker node kernel & package updates for [CVE-2023-3446](https://nvd.nist.gov/vuln/detail/CVE-2023-3446){: external}, [CVE-2023-3817](https://nvd.nist.gov/vuln/detail/CVE-2023-3817){: external}, [CVE-2023-4733](https://nvd.nist.gov/vuln/detail/CVE-2023-4733){: external}, [CVE-2023-4735](https://nvd.nist.gov/vuln/detail/CVE-2023-4735){: external}, [CVE-2023-4750](https://nvd.nist.gov/vuln/detail/CVE-2023-4750){: external}, [CVE-2023-4751](https://nvd.nist.gov/vuln/detail/CVE-2023-4751){: external}, [CVE-2023-4752](https://nvd.nist.gov/vuln/detail/CVE-2023-4752){: external}, [CVE-2023-4781](https://nvd.nist.gov/vuln/detail/CVE-2023-4781){: external}, [CVE-2023-5344](https://nvd.nist.gov/vuln/detail/CVE-2023-5344){: external}, [CVE-2023-5441](https://nvd.nist.gov/vuln/detail/CVE-2023-5441){: external}, [CVE-2023-5535](https://nvd.nist.gov/vuln/detail/CVE-2023-5535){: external}. |
| Kubernetes |N/A|N/A|N/A|
| Containerd | 1.7.6 | 1.7.7 | see [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.7){: external}. |
{: caption="Changes since version 1.28.2_1529" caption-side="bottom"}


### Change log for worker node fix pack 1.28.2_1529, released 9 October 2023
{: #1282_1529_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-163-generic | 5.4.0-164-generic | Worker node kernel & package updates for [CVE-2021-4001](https://nvd.nist.gov/vuln/detail/CVE-2021-4001){: external}, [CVE-2023-1206](https://nvd.nist.gov/vuln/detail/CVE-2023-1206){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-3212](https://nvd.nist.gov/vuln/detail/CVE-2023-3212){: external}, [CVE-2023-3863](https://nvd.nist.gov/vuln/detail/CVE-2023-3863){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-4194](https://nvd.nist.gov/vuln/detail/CVE-2023-4194){: external}, [CVE-2023-43785](https://nvd.nist.gov/vuln/detail/CVE-2023-43785){: external}, [CVE-2023-43786](https://nvd.nist.gov/vuln/detail/CVE-2023-43786){: external}, [CVE-2023-43787](https://nvd.nist.gov/vuln/detail/CVE-2023-43787){: external}. |
| Kubernetes | N/A |N/A|N/A|
| Containerd | N/A |N/A|N/A|
{: caption="Changes since version 1.28.2_1528" caption-side="bottom"}


### Change log for worker node fix pack 1.28.2_1528, released 27 September 2023
{: #1282_1528_W}

The following table shows the changes that are in the worker node fix pack 1.28.2_1528. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-162-generic | 5.4.0-163-generic| Package updates for [CVE-2023-3341](https://nvd.nist.gov/vuln/detail/CVE-2023-3341){: external}, [CVE-2023-4156](https://nvd.nist.gov/vuln/detail/CVE-2023-4156){: external}, [CVE-2023-4128](https://nvd.nist.gov/vuln/detail/CVE-2023-4128){: external}, [CVE-2023-20588](https://nvd.nist.gov/vuln/detail/CVE-2023-20588){: external}, [CVE-2023-20900](https://nvd.nist.gov/vuln/detail/CVE-2023-20900){: external}, [CVE-2023-40283](https://nvd.nist.gov/vuln/detail/CVE-2023-40283){: external}. |
| Containerd | 1.7.5 | 1.7.6 |N/A|
| Kubernetes | 1.28.1 | 1.28.2 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.28.md#change log-since-v1281){: external}. |
{: caption="Changes since version 1.28.1_1523" caption-side="bottom"}


### Change log for master fix pack 1.28.2_1527 and worker node fix pack 1.28.1_1523, released 20 September 2023
{: #1.28.2_1527M-and-1.28.1_1523W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| CoreDNS | 1.10.1 | 1.11.1 | See the [CoreDNS release notes](https://coredns.io/2023/08/15/coredns-1.11.1-release/). CoreDNS now runs as a non-root user and has an updated role-based access control (RBAC) configuration. |
| Containerd |  1.7.4| 1.7.5 | NA |
| HAProxy configuration | N/A | N/A | Updated master health probes to use the `/livez/ping` endpoint. |
| IBM Cloud Controller Manager | v1.27.5-3 | v1.28.1-3 | Updated to support the Kubernetes `1.28.1` release. Updated `Go` dependencies and to `Go` version `1.20.7`. New nodes are now registered with the `node.kubernetes.io/network-unavailable` taint which is cleared when Calico is initialized on the node. |
| Kubernetes add-on resizer | 1.8.18 | 1.8.19 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.19). |
| Kubernetes (master) | v1.27.5 | v1.28.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.2). |
| Kubernetes (worker node) | v1.27.4 | v1.28.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.28.1). |
| Ubuntu 20.04 packages | 5.4.0-156-generic | 5.4.0-162-generic | Worker node kernel & package updates for [CVE-2020-21047](https://nvd.nist.gov/vuln/detail/CVE-2020-21047){: external} , [CVE-2021-33294](https://nvd.nist.gov/vuln/detail/CVE-2021-33294){: external} , [CVE-2022-40982](https://nvd.nist.gov/vuln/detail/CVE-2022-40982){: external} , [CVE-2023-20593](https://nvd.nist.gov/vuln/detail/CVE-2023-20593){: external} , [CVE-2023-2269](https://nvd.nist.gov/vuln/detail/CVE-2023-2269){: external} , [CVE-2023-31084](https://nvd.nist.gov/vuln/detail/CVE-2023-31084){: external} , [CVE-2023-3268](https://nvd.nist.gov/vuln/detail/CVE-2023-3268){: external} , [CVE-2023-3609](https://nvd.nist.gov/vuln/detail/CVE-2023-3609){: external} , [CVE-2023-3611](https://nvd.nist.gov/vuln/detail/CVE-2023-3611){: external} , [CVE-2023-3776](https://nvd.nist.gov/vuln/detail/CVE-2023-3776){: external} |
| Kubernetes configuration | N/A | N/A | See [Default service settings for Kubernetes components](https://cloud.ibm.com/docs/containers?topic=containers-service-settings). In addition, both `default` and `verbose` [Kubernetes API server auditing](https://cloud.ibm.com/docs/containers?topic=containers-health-audit#audit-api-server) records now contain extra user claim information. |
| GPU device plug-in and installer | NA | 61afd3d | Driver version: [535.54.03](http://docs.nvidia.com/datacenter/tesla/tesla-release-notes-535-54-03/index.html). |
| Kubernetes Dashboard metrics scraper | N/A |	N/A | Increased Kubernetes Dashboard metrics scraper CPU resource request to `20m`. |
| Kubernetes DNS autoscaler | v1.8.8 | v1.8.9 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/v1.8.9). |
| Kubernetes Metrics Server | v0.6.3 | v0.6.4 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.6.4). In addition, the Kubernetes Metrics Server has an updated role-based access control (RBAC) configuration. |
| Kubernetes CSI snapshot controller and CRDs | v6.2.1 | v6.2.2 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.2.2). |
{: caption="Changes since version 1.27." caption-side="bottom"}


