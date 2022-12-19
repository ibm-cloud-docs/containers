---

copyright: 
  years: 2022, 2022
lastupdated: "2022-12-19"

keywords: kubernetes, containers, change log, 125 change log, 125 updates

subcollection: containers


---

# Kubernetes version 1.25 change log
{: #changelog_125}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.25. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_125}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.25 change log
{: #125_changelog}

Review the version 1.25 change log.
{: shortdesc}




### Change log for master fix pack 1.25.5_1525, released 14 December 2022
{: #1255_1525}

The following table shows the changes that are in the master fix pack 1.25.5_1525. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.13 | v1.3.14 | Updated `Go` dependencies. Exclude ingress status from cluster status aggregation. |
| etcd | v3.5.5 | v3.5.6 | See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.5.6){: external}. |
| GPU device plug-in and installer | cce0cfa | 03fd318 | Update GPU images with `Go` version `1.19.2` to resolve vulnerabilities |
| {{site.data.keyword.IBM_notm}} Calico extension | 1213 | 1257 | Updated universal base image (UBI) to resolve: [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/cve-2022-1304){: external}, [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.3 | v2.3.4 | Updated universal base image (UBI) to resolve CVEs. Updated `Go` to version `1.18.6` |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.3-10 | v1.25.4-2 | Updated to support the `Kubernetes 1.25.4` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 420 | 421 | Updated universal base image (UBI) to resolve [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. Updated `Go` to version `1.18.8` |
| Key Management Service provider | v2.5.11 | v2.5.12 | Updated `Go` dependencies. |
| Kubernetes | v1.25.4 | v1.25.5 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2110 | 2325 | Update `Go` to version `1.19.1` and update dependencies. |
{: caption="Changes since version 1.25.4_1522" caption-side="bottom"}


### Change log for worker node fix pack 1.25.4_1524, released 05 December 2022
{: #1254_1524}

The following table shows the changes that are in the worker node fix pack 1.25.4_1524. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2013-4235](https://nvd.nist.gov/vuln/detail/CVE-2013-4235){: external},[CVE-2022-3239](https://nvd.nist.gov/vuln/detail/CVE-2022-3239){: external},[CVE-2022-3524](https://nvd.nist.gov/vuln/detail/CVE-2022-3524){: external},[CVE-2022-3564](https://nvd.nist.gov/vuln/detail/CVE-2022-3564){: external},[CVE-2022-3565](https://nvd.nist.gov/vuln/detail/CVE-2022-3565){: external},[CVE-2022-3566](https://nvd.nist.gov/vuln/detail/CVE-2022-3566){: external},[CVE-2022-3567](https://nvd.nist.gov/vuln/detail/CVE-2022-3567){: external},[CVE-2022-3594](https://nvd.nist.gov/vuln/detail/CVE-2022-3594){: external},[CVE-2022-3621](https://nvd.nist.gov/vuln/detail/CVE-2022-3621){: external},[CVE-2022-42703](https://nvd.nist.gov/vuln/detail/CVE-2022-42703){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAPROXY | c619f4 | 508bf6 | [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}. |
| CUDA | fd4353 | 0ab756 | [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}. |
{: caption="Changes since version 1.25.4_1523" caption-side="top"}


### Change log for worker node fix pack 1.25.4_1523, released 21 November 2022
{: #1254_1523}

The following table shows the changes that are in the worker node fix pack 1.25.4_1523. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-194 | 4.15.0-197 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external},[CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external},[CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external},[CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external},[CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external},[CVE-2022-2978](https://nvd.nist.gov/vuln/detail/CVE-2022-2978){: external},[CVE-2022-3028](https://nvd.nist.gov/vuln/detail/CVE-2022-3028){: external},[CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external},[CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-35737](https://nvd.nist.gov/vuln/detail/CVE-2022-35737){: external},[CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external},[CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external},[CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external},[CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674){: external},[CVE-2022-40768](https://nvd.nist.gov/vuln/detail/CVE-2022-40768){: external},[CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external},[CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external},[CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external},[CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.25.3 | 1.25.4 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.4){: external}. |
| CUDA | 576234 | cce0cf | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.25.3_1521" caption-side="top"}


### Change log for master fix pack 1.25.4_1522, released 16 November 2022
{: #1254_1522}

The following table shows the changes that are in the master fix pack 1.25.4_1522. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.24.1 | v3.24.5 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245){: external}. |
| Cluster health image | v1.3.12 | v1.3.13 | Updated Go dependencies, golangci-lint, gosec, and to `Go` version 1.19.3. Updated base image version to 116. |
| etcd | v3.5.4 | v3.5.5 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.5){: external}. |
| Gateway-enabled cluster controller | 1823 | 1902 | `Go` module updates. |
| GPU device plug-in and installer | 373bb9f | cce0cfa | Updated the GPU driver 470 minor version |
| {{site.data.keyword.IBM_notm}} Calico extension | 1096 | 1213 | Updated image to fix the following CVEs: [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2022-3515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3515){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-32149](https://nvd.nist.gov/vuln/detail/CVE-2022-32149){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.1 | v2.3.3 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.3-1 | v1.25.3-10 | Key rotation, updated `Go` to version `1.19`, and updated `Go` dependencies. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 416 | 420 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| Key Management Service provider | v2.5.10 | v2.5.11 | Updated `Go` dependencies and to `Go` version `1.19.3`. |
| Kubernetes | v1.25.3 | v1.25.4 | [CVE-2022-3294](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3294){: external} and [CVE-2022-3162](https://nvd.nist.gov/vuln/detail/CVE-2022-3162){: external}. For more information, see [{{site.data.keyword.containerlong_notm}} is affected by Kubernetes API server security vulnerabilities CVE-2022-3294 and CVE-2022-3162](https://www.ibm.com/support/pages/node/6844715){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.4){: external}. |
{: caption="Changes since version 1.25.3_1520" caption-side="bottom"}


### Change log for worker node fix pack 1.25.3_1521, released 07 November 2022
{: #1253_1521}

The following table shows the changes that are in the worker node fix pack 1.25.3_1521. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external},[CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external},[CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external},[CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external},[CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.25.2 | 1.25.3 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.3){: external}. |
| HAPROXY | b034b2 | 3a1392 | [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}. |
| CUDA | 3ea43b | 576234 | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.25.2_1519" caption-side="top"}


### Change log for master fix pack 1.25.3_1520, released 27 October 2022
{: #1253_1520}

The following table shows the changes that are in the master fix pack 1.25.3_1520. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.11 | v1.3.12 | Updated `Go` dependencies, golangci-lint, and to `Go` version 1.19.2. Updated base image version to 109. Excluded ingress status from cluster status calculation. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.25.2-2 | v1.25.3-1 | Updated to support the `Kubernetes 1.25.3` release. |
| Key Management Service provider | v2.5.9 | v2.5.10 | Updated `Go` dependencies and to `Go` version `1.19.2`. |
| Kubernetes | v1.25.2 | v1.25.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.3){: external}. |
| Konnectivity agent and server | v0.0.32_363_iks | v0.0.33_418_iks | Updated Konnectivity to version v0.0.33 and added s390x functionality. See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.33){: external}. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | dc1725a | 778ef2b | Updated to `Go` version `1.18.6`. |
{: caption="Changes since version 1.25.21517" caption-side="bottom"}


### Change log for worker node fix pack 1.25.2_1519, released 25 October 2022
{: #1252_1519}

The following table shows the changes that are in the worker node fix pack 1.25.2_1519. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-193 | 4.15.0-194 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external}, [CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external}, [CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external}, [CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external}, [CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external}. | 
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.25.2_1518" caption-side="bottom"}


### Change log for master fix pack 1.25.2_1517 and worker node fix pack 1.25.2_1516, released 6 October 2022
{: #1252_1517_and_1252_1516}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.23.3 | v3.24.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/){: external}. In addition, a `default` `FelixConfiguration` resource is created if it doesn't exist. The resource has `natPortRange` set to `32768:65535`. For more information, see [Why am I seeing SNAT port issues and egress connection failures?](/docs/containers?topic=containers-ts-network-snat-125){: external} |
| CoreDNS | 1.9.3 | 1.10.0 | See the [CoreDNS release notes](https://github.com/coredns/coredns/blob/v1.10.0/notes/coredns-1.10.0.md){: external}. |
| IBM Cloud Controller Manager | v1.24.5-1 | v1.25.2-2 | Updated to support the Kubernetes `1.25.2` release and `Go` version `1.19.1`. |
| Kubernetes | v1.24.6 | v1.25.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.25.2){: external}. |
| Kubernetes admission controllers configuration | N/A | N/A | Enabled the `PodSecurity` and removed the `PodSecurityPolicy` admission controllers. [Pod Security Policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external} were removed in Kubernetes version 1.25. See the Kubernetes [Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#psp-v125){: external} for more information. {{site.data.keyword.containerlong_notm}} version 1.25 now configures [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){: external} and no longer supports [Pod Security Policies](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. For more information, see [Migrating from PSPs to Pod Security Admission](/docs/containers?topic=containers-pod-security-admission-migration). |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates). |
| Kubernetes CSI snapshot CRDs | v5.0.1 | v6.0.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.0.1){: external}. |
| Kubernetes CSI snapshot controller | None | v6.0.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.0.1){: external}. |
| Kubernetes Dashboard | v2.6.1 | v2.7.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.7.0){: external}. |
| Kubernetes DNS autoscaler | 1.8.5 | 1.8.6 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.6){: external}. In addition, CPU resource requests were reduced from `5m` to `1m` to better align with normal resource utilization. |
| Pause container image | 3.7 | 3.8 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. |
{: caption="Changes since version 1.24.6_1538 master and 1.24.6_1539 worker node."}


