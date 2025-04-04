---

copyright:
 years: 2014, 2025
lastupdated: "2025-04-04"


keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch, 1.23

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Kubernetes version 1.22 change log
{: #changelog_122}




This version is no longer supported. Update your cluster to a [supported version](/docs/containers?topic=containers-cs_versions) as soon as possible.
{: important}




## Overview
{: #changelog_overview_122}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.22 change log
{: #122_changelog}


Review the version 1.22 change log.
{: shortdesc}




### Worker node fix pack 1.22.17_1584, released 02 January 2023
{: #12217_1584}

The following table shows the changes that are in the worker node fix pack 1.22.17_1584. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A|N/A|
| Ubuntu 20.04 packages |N/A|N/A|N/A|
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.22.17_1583" caption-side="bottom"}


### Worker node fix pack 1.22.17_1583, released 19 December 2022
{: #12217_1583}

The following table shows the changes that are in the worker node fix pack 1.22.17_1583. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|Containerd|1.5.14|1.5.16|See the [1.5.16 change log](https://github.com/containerd/containerd/releases/tag/v1.5.16){: external} and the [1.5.15 change log](https://github.com/containerd/containerd/releases/tag/v1.5.15), the security bulletin for [CVE-2022-23471](https://www.ibm.com/support/pages/node/6850799){: external}. |
| Ubuntu 18.04 packages | 4.15.0-197 | 4.15.0-200 | Worker node kernel & package updates for [CVE-2022-2309](https://nvd.nist.gov/vuln/detail/CVE-2022-2309){: external}, [CVE-2022-38533](https://nvd.nist.gov/vuln/detail/CVE-2022-38533){: external}, [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external}, [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external}, [CVE-2022-41916](https://nvd.nist.gov/vuln/detail/CVE-2022-41916){: external}, [CVE-2022-45061](https://nvd.nist.gov/vuln/detail/CVE-2022-45061){: external}. |
| Ubuntu 20.04 packages | 5.4.0-132 | 5.4.0-135 | Worker node kernel & package updates for [CVE-2022-2309](https://nvd.nist.gov/vuln/detail/CVE-2022-2309){: external}, [CVE-2022-38533](https://nvd.nist.gov/vuln/detail/CVE-2022-38533){: external}, [CVE-2022-40303](https://nvd.nist.gov/vuln/detail/CVE-2022-40303){: external}, [CVE-2022-40304](https://nvd.nist.gov/vuln/detail/CVE-2022-40304){: external}, [CVE-2022-41916](https://nvd.nist.gov/vuln/detail/CVE-2022-41916){: external}. |
| Kubernetes | 1.22.16 | 1.22.17 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.17){: external}. |
{: caption="Changes since version 1.22.16_1580" caption-side="bottom"}


### Master fix pack 1.22.17_1582, released 14 December 2022
{: #12217_1582}

The following table shows the changes that are in the master fix pack 1.22.17_1582. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.13 | v1.3.14 | Updated `Go` dependencies. Exclude ingress status from cluster status aggregation. |
| etcd | v3.4.21 | v3.4.22 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.22){: external}. |
| GPU device plug-in and installer | cce0cfa | 03fd318 | Update GPU images with `Go` version `1.19.2` to resolve vulnerabilities |
| {{site.data.keyword.IBM_notm}} Calico extension | 1213 | 1257 | Updated universal base image (UBI) to resolve: [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/cve-2022-1304){: external}, [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.15-7 | v1.22.16-1 | Updated to support the `Kubernetes 1.22.16` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 420 | 421 | Updated universal base image (UBI) to resolve [CVE-2022-42898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-42898){: external}. Updated `Go` to version `1.18.8` |
| Key Management Service provider | v2.5.11 | v2.5.12 | Updated `Go` dependencies. |
| Kubernetes | v1.22.16 | v1.22.17 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.17){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2110 | 2325 | Update `Go` to version `1.19.1` and update dependencies. |
{: caption="Changes since version 1.22.16_1578" caption-side="bottom"}


### Worker node fix pack 1.22.16_1580, released 05 December 2022
{: #12216_1580}

The following table shows the changes that are in the worker node fix pack 1.22.16_1580. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
|Containerd|1.5.13|1.5.14|See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.14){: external}. |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2013-4235](https://nvd.nist.gov/vuln/detail/CVE-2013-4235){: external}, [CVE-2022-3239](https://nvd.nist.gov/vuln/detail/CVE-2022-3239){: external}, [CVE-2022-3524](https://nvd.nist.gov/vuln/detail/CVE-2022-3524){: external}, [CVE-2022-3564](https://nvd.nist.gov/vuln/detail/CVE-2022-3564){: external}, [CVE-2022-3565](https://nvd.nist.gov/vuln/detail/CVE-2022-3565){: external}, [CVE-2022-3566](https://nvd.nist.gov/vuln/detail/CVE-2022-3566){: external}, [CVE-2022-3567](https://nvd.nist.gov/vuln/detail/CVE-2022-3567){: external}, [CVE-2022-3594](https://nvd.nist.gov/vuln/detail/CVE-2022-3594){: external}, [CVE-2022-3621](https://nvd.nist.gov/vuln/detail/CVE-2022-3621){: external}, [CVE-2022-42703](https://nvd.nist.gov/vuln/detail/CVE-2022-42703){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAPROXY | c619f4 | 508bf6 | [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}. |
| CUDA | fd4353 | 0ab756 | [CVE-2022-42898](https://nvd.nist.gov/vuln/detail/CVE-2022-42898){: external}. |
{: caption="Changes since version 1.22.16_1579" caption-side="bottom"}


### Worker node fix pack 1.22.16_1579, released 21 November 2022
{: #12216_1579}

The following table shows the changes that are in the worker node fix pack 1.22.16_1579. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-194 | 4.15.0-197 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external}, [CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external}, [CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external}, [CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2022-2978](https://nvd.nist.gov/vuln/detail/CVE-2022-2978){: external}, [CVE-2022-3028](https://nvd.nist.gov/vuln/detail/CVE-2022-3028){: external}, [CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external}, [CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-35737](https://nvd.nist.gov/vuln/detail/CVE-2022-35737){: external}, [CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external}, [CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external}, [CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external}, [CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674){: external}, [CVE-2022-40768](https://nvd.nist.gov/vuln/detail/CVE-2022-40768){: external}, [CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}, [CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external}, [CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external}, [CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.22.15 | 1.22.16 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.16){: external}. |
| RHEL 7 Packages |N/A|N/A| Worker node package updates for [CVE-2022-21233](https://nvd.nist.gov/vuln/detail/CVE-2022-21233){: external}, [CVE-2022-23816](https://nvd.nist.gov/vuln/detail/CVE-2022-23816){: external}, [CVE-2022-23825](https://nvd.nist.gov/vuln/detail/CVE-2022-23825){: external}, [CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external}, [CVE-2022-26373](https://nvd.nist.gov/vuln/detail/CVE-2022-26373){: external}, [CVE-2022-29900](https://nvd.nist.gov/vuln/detail/CVE-2022-29900){: external}, [CVE-2022-29901](https://nvd.nist.gov/vuln/detail/CVE-2022-29901){: external}, [CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}. |
| RHEL 8 Packages |N/A|N/A| Worker node package updates for [CVE-2015-20107](https://nvd.nist.gov/vuln/detail/CVE-2015-20107){: external}, [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2020-0256](https://nvd.nist.gov/vuln/detail/CVE-2020-0256){: external}, [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2020-36516](https://nvd.nist.gov/vuln/detail/CVE-2020-36516){: external}, [CVE-2020-36558](https://nvd.nist.gov/vuln/detail/CVE-2020-36558){: external}, [CVE-2021-0308](https://nvd.nist.gov/vuln/detail/CVE-2021-0308){: external}, [CVE-2021-25220](https://nvd.nist.gov/vuln/detail/CVE-2021-25220){: external}, [CVE-2021-30002](https://nvd.nist.gov/vuln/detail/CVE-2021-30002){: external}, [CVE-2021-36221](https://nvd.nist.gov/vuln/detail/CVE-2021-36221){: external}, [CVE-2021-3640](https://nvd.nist.gov/vuln/detail/CVE-2021-3640){: external}, [CVE-2021-41190](https://nvd.nist.gov/vuln/detail/CVE-2021-41190){: external}, [CVE-2022-0168](https://nvd.nist.gov/vuln/detail/CVE-2022-0168){: external}, [CVE-2022-0494](https://nvd.nist.gov/vuln/detail/CVE-2022-0494){: external}, [CVE-2022-0617](https://nvd.nist.gov/vuln/detail/CVE-2022-0617){: external}, [CVE-2022-0854](https://nvd.nist.gov/vuln/detail/CVE-2022-0854){: external}, [CVE-2022-1016](https://nvd.nist.gov/vuln/detail/CVE-2022-1016){: external}, [CVE-2022-1048](https://nvd.nist.gov/vuln/detail/CVE-2022-1048){: external}, [CVE-2022-1055](https://nvd.nist.gov/vuln/detail/CVE-2022-1055){: external}, [CVE-2022-1184](https://nvd.nist.gov/vuln/detail/CVE-2022-1184){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}, [CVE-2022-1353](https://nvd.nist.gov/vuln/detail/CVE-2022-1353){: external}, [CVE-2022-1708](https://nvd.nist.gov/vuln/detail/CVE-2022-1708){: external}, [CVE-2022-1852](https://nvd.nist.gov/vuln/detail/CVE-2022-1852){: external}, [CVE-2022-20368](https://nvd.nist.gov/vuln/detail/CVE-2022-20368){: external}, [CVE-2022-2078](https://nvd.nist.gov/vuln/detail/CVE-2022-2078){: external}, [CVE-2022-21499](https://nvd.nist.gov/vuln/detail/CVE-2022-21499){: external}, [CVE-2022-22624](https://nvd.nist.gov/vuln/detail/CVE-2022-22624){: external}, [CVE-2022-22628](https://nvd.nist.gov/vuln/detail/CVE-2022-22628){: external}, [CVE-2022-22629](https://nvd.nist.gov/vuln/detail/CVE-2022-22629){: external}, [CVE-2022-22662](https://nvd.nist.gov/vuln/detail/CVE-2022-22662){: external}, [CVE-2022-23816](https://nvd.nist.gov/vuln/detail/CVE-2022-23816){: external}, [CVE-2022-23825](https://nvd.nist.gov/vuln/detail/CVE-2022-23825){: external}, [CVE-2022-23960](https://nvd.nist.gov/vuln/detail/CVE-2022-23960){: external}, [CVE-2022-24448](https://nvd.nist.gov/vuln/detail/CVE-2022-24448){: external}, [CVE-2022-24795](https://nvd.nist.gov/vuln/detail/CVE-2022-24795){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-2586](https://nvd.nist.gov/vuln/detail/CVE-2022-2586){: external}, [CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external}, [CVE-2022-26373](https://nvd.nist.gov/vuln/detail/CVE-2022-26373){: external}, [CVE-2022-2639](https://nvd.nist.gov/vuln/detail/CVE-2022-2639){: external}, [CVE-2022-26700](https://nvd.nist.gov/vuln/detail/CVE-2022-26700){: external}, [CVE-2022-26709](https://nvd.nist.gov/vuln/detail/CVE-2022-26709){: external}, [CVE-2022-26710](https://nvd.nist.gov/vuln/detail/CVE-2022-26710){: external}, [CVE-2022-26716](https://nvd.nist.gov/vuln/detail/CVE-2022-26716){: external}, [CVE-2022-26717](https://nvd.nist.gov/vuln/detail/CVE-2022-26717){: external}, [CVE-2022-26719](https://nvd.nist.gov/vuln/detail/CVE-2022-26719){: external}, [CVE-2022-27191](https://nvd.nist.gov/vuln/detail/CVE-2022-27191){: external}, [CVE-2022-27404](https://nvd.nist.gov/vuln/detail/CVE-2022-27404){: external}, [CVE-2022-27405](https://nvd.nist.gov/vuln/detail/CVE-2022-27405){: external}, [CVE-2022-27406](https://nvd.nist.gov/vuln/detail/CVE-2022-27406){: external}, [CVE-2022-27950](https://nvd.nist.gov/vuln/detail/CVE-2022-27950){: external}, [CVE-2022-28390](https://nvd.nist.gov/vuln/detail/CVE-2022-28390){: external}, [CVE-2022-28893](https://nvd.nist.gov/vuln/detail/CVE-2022-28893){: external}, [CVE-2022-29162](https://nvd.nist.gov/vuln/detail/CVE-2022-29162){: external}, [CVE-2022-2938](https://nvd.nist.gov/vuln/detail/CVE-2022-2938){: external}, [CVE-2022-29581](https://nvd.nist.gov/vuln/detail/CVE-2022-29581){: external}, [CVE-2022-2989](https://nvd.nist.gov/vuln/detail/CVE-2022-2989){: external}, [CVE-2022-2990](https://nvd.nist.gov/vuln/detail/CVE-2022-2990){: external}, [CVE-2022-29900](https://nvd.nist.gov/vuln/detail/CVE-2022-29900){: external}, [CVE-2022-29901](https://nvd.nist.gov/vuln/detail/CVE-2022-29901){: external}, [CVE-2022-30293](https://nvd.nist.gov/vuln/detail/CVE-2022-30293){: external}, [CVE-2022-32746](https://nvd.nist.gov/vuln/detail/CVE-2022-32746){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-36946](https://nvd.nist.gov/vuln/detail/CVE-2022-36946){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-3787](https://nvd.nist.gov/vuln/detail/CVE-2022-3787){: external}, [CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674){: external}, [CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}. |
| CUDA | 576234 | cce0cf | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.22.15_1577" caption-side="bottom"}


### Master fix pack 1.22.16_1578, released 16 November 2022
{: #12216_1578}

The following table shows the changes that are in the master fix pack 1.22.16_1578. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.12 | v1.3.13 | Updated Go dependencies, `golangci-lint`, `gosec`, and to `Go` version 1.19.3. Updated base image version to 116. |
| etcd | v3.4.18 | v3.4.21 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.4.21){: external}. |
| Gateway-enabled cluster controller | 1823 | 1902 | `Go` module updates. |
| GPU device plug-in and installer | 373bb9f | cce0cfa | Updated the GPU driver 470 minor version |
| {{site.data.keyword.IBM_notm}} Calico extension | 1096 | 1213 | Updated image to fix the following CVEs: [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2022-3515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3515){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-32149](https://nvd.nist.gov/vuln/detail/CVE-2022-32149){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.15-3 | v1.22.15-7 | Key rotation and updated `Go` dependencies. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 416 | 420 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| Key Management Service provider | v2.5.10 | v2.5.11 | Updated `Go` dependencies and to `Go` version `1.19.3`. |
| Kubernetes | v1.22.15 | v1.22.16 | [CVE-2022-3294](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3294){: external} and [CVE-2022-3162](https://nvd.nist.gov/vuln/detail/CVE-2022-3162){: external}. For more information, see [{{site.data.keyword.containerlong_notm}} is affected by Kubernetes API server security vulnerabilities CVE-2022-3294 and CVE-2022-3162](https://www.ibm.com/support/pages/node/6844715){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.16){: external}. |
{: caption="Changes since version 1.22.15_1576" caption-side="bottom"}


### Worker node fix pack 1.22.15_1577, released 07 November 2022
{: #12215_1577}

The following table shows the changes that are in the worker node fix pack 1.22.15_1577. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external}, [CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external}, [CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external}, [CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external}, [CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes |N/A|N/A|N/A|
| HAPROXY | b034b2 | 3a1392 | [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}. |
| CUDA | 3ea43b | 576234 | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.22.15_1575" caption-side="bottom"}


### Master fix pack 1.22.15_1576, released 27 October 2022
{: #12215_1576}

The following table shows the changes that are in the master fix pack 1.22.15_1576. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.11 | v1.3.12 | Updated `Go` dependencies, golangci-lint, and to `Go` version 1.19.2. Updated base image version to 109. Excluded ingress status from cluster status calculation. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.14-2 | v1.22.15-3 | Updated to support the `Kubernetes 1.22.15` release. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | dc1725a | 778ef2b | Updated to `Go` version `1.18.6`. |
| Key Management Service provider | v2.5.9 | v2.5.10 | Updated `Go` dependencies and to `Go` version `1.19.2`. |
| Konnectivity agent and server | v0.0.32_363_iks | v0.0.33_418_iks | Updated Konnectivity to version v0.0.33 and added s390x functionality. See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.33){: external}. |
{: caption="Changes since version 1.22.151572" caption-side="bottom"}


### Worker node fix pack 1.22.15_1575, released 25 October 2022
{: #12215_1575}

The following table shows the changes that are in the worker node fix pack 1.22.15_1575. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-193 | 4.15.0-194 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external}, [CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external}, [CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external}, [CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external}, [CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external}. | 
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.22.15_1574" caption-side="bottom"}


### Worker node fix pack 1.22.15_1574, released 10 October 2022
{: #12215_1574}

The following table shows the changes that are in the worker node fix pack 1.22.15_1574. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A|N/A|
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.22.15_1573" caption-side="bottom"}


### Master fix pack 1.22.15_1572, released 26 September 2022
{: #12215_1572}

The following table shows the changes that are in the master fix pack 1.22.15_1572. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | N/A | N/A | Updated the Calico custom resource definitions to include `preserveUnknownFields: false`. |
| Cluster health image | v1.3.10 | v1.3.11 | Updated `Go` dependencies and to `Go` version `1.18.6`. |
| GPU device plug-in and installer | c58c299 | 373bb9f | Updated to `Go` version `1.19.1`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1006 | 1096 | Updated image for [CVE-2022-2526](https://nvd.nist.gov/vuln/detail/CVE-2022-2526){: external}. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.13-1 | v1.22.14-2 | Updated to support the Kubernetes `1.22.14` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 414 | 416 | Updated to `Go` version `1.18.6`. Updated universal base image (UBI) to version `8.6-941` to resolve CVEs. |
| Key Management Service Provider | v2.5.8 | v2.5.9 | Updated `Go` dependencies and to `Go` version `1.18.6`. |
| Kubernetes | v1.22.13 | v1.22.15 | This update resolves [CVE-2022-3172](https://nvd.nist.gov/vuln/detail/CVE-2022-3172){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6823785){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.15){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.6 | 1.22.11 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.11){: external}. |
{: caption="Changes since version 1.22.131570" caption-side="bottom"}


### Worker node fix pack 1.22.15_1573, released 26 September 2022
{: #12215_1573}

The following table shows the changes that are in the worker node fix pack 1.22.15_1573. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-192 | 4.15.0-193 | Worker node kernel & package updates for [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2021-33655](https://nvd.nist.gov/vuln/detail/CVE-2021-33655){: external}, [CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external}, [CVE-2022-0943](https://nvd.nist.gov/vuln/detail/CVE-2022-0943){: external}, [CVE-2022-1154](https://nvd.nist.gov/vuln/detail/CVE-2022-1154){: external}, [CVE-2022-1616](https://nvd.nist.gov/vuln/detail/CVE-2022-1616){: external}, [CVE-2022-1619](https://nvd.nist.gov/vuln/detail/CVE-2022-1619){: external}, [CVE-2022-1620](https://nvd.nist.gov/vuln/detail/CVE-2022-1620){: external}, [CVE-2022-1621](https://nvd.nist.gov/vuln/detail/CVE-2022-1621){: external}, [CVE-2022-2526](https://nvd.nist.gov/vuln/detail/CVE-2022-2526){: external}, [CVE-2022-2795](https://nvd.nist.gov/vuln/detail/CVE-2022-2795){: external}, [CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external}, [CVE-2022-36946](https://nvd.nist.gov/vuln/detail/CVE-2022-36946){: external}, [CVE-2022-38177](https://nvd.nist.gov/vuln/detail/CVE-2022-38177){: external}, [CVE-2022-38178](https://nvd.nist.gov/vuln/detail/CVE-2022-38178){: external}. |
| Kubernetes | 1.22.13 | 1.22.15 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.15){: external}. |
{: caption="Changes since version 1.22.13_1571" caption-side="bottom"}


### Worker node fix pack 1.22.13_1571, released 12 September 2022
{: #12213_1571}

The following table shows the changes that are in the worker node fix pack 1.22.13_1571. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-191 | 4.15.0-192 | Worker node kernel & package updates for [CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external}, [CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external}. |
| Kubernetes |N/A|N/A|N/A| 
{: caption="Changes since version 1.22.13_1568" caption-side="bottom"}


### Master fix pack 1.22.13_1570, released 1 September 2022
{: #12213_1570}

The following table shows the changes that are in the master fix pack 1.22.13_1570. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.21.5 | v3.21.6 | See the [Calico release notes](https://docs.tigera.io/archive/v3.21/release-notes/.#v3216){: external}. |
| Cluster health image | v1.3.9 | v1.3.10 | Updated `Go` dependencies and to `Go` version `1.18.5`. |
| CoreDNS | 1.8.7 | 1.8.6 | See the [CoreDNS release notes](https://coredns.io/2021/10/07/coredns-1.8.6-release/){: external}. |
| Gateway-enabled cluster controller | 1792 | 1823 | Updated to `Go` version `1.17.13`. |
| GPU device plug-in and installer | d8f1be0 | c58c299 | Enable DRM module and update `Go` to version `1.18.5`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 997 | 1006 | Updated to `Go` version `1.17.13`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.11-3 | v1.22.13-1 | Updated `vpcctl` binary to version `3367`. Updated to support the Kubernetes `1.22.13` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 412 | 414 | Updated to `Go` version `1.18.5`. Updated universal base image (UBI) to version `8.6-902` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 0a187a4 | dc1725a | Updated `Go` dependencies and to `Go` version `1.18.3`. |
| Key Management Service provider | v2.5.7 | v2.5.8 | Updated `Go` dependencies. |
| Konnectivity agent and server | v0.0.30_331_iks | v0.0.32_363_iks | Updated to `Go` version `1.17.13` and to `Konnectivity` version `v0.0.32`. |
| Kubernetes | v1.22.12 | v1.22.13 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.13){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.7 | v1.0.8 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.8){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.4 | 1.22.6 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2058 | 2110 | Updated `Go` dependencies and to `Go` version `1.17.13`. |
| Operator Lifecycle Manager | 0.16.1-IKS-18 | 0.16.1-IKS-19 | Update image for [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}. |
| Portieris admission controller | v0.12.5 | v0.12.6 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.6){: external}. |
{: caption="Changes since version 1.22.12_1566" caption-side="bottom"}


### Worker node fix pack 1.22.13_1568, released 29 August 2022
{: #12213_1568}

The following table shows the changes that are in the worker node fix pack 1.22.13_1568. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2019-5815](https://nvd.nist.gov/vuln/detail/CVE-2019-5815){: external}, [CVE-2021-30560](https://nvd.nist.gov/vuln/detail/CVE-2021-30560){: external}, [CVE-2022-31676](https://nvd.nist.gov/vuln/detail/CVE-2022-31676){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}. |
| Kubernetes | 1.22.12 | 1.22.13 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.13){: external}. | 
| HAPROXY | 6514a2 | c1634f | [CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external}, [CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}
{: caption="Changes since version 1.22.12_1566" caption-side="bottom"}


### Worker node fix pack 1.22.12_1566, released 16 August 2022
{: #12212_1566}

The following table shows the changes that are in the worker node fix pack 1.22.12_1566. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-189 | 4.15.0-191 | Worker node kernel & package updates for [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external}, [CVE-2021-4209](https://nvd.nist.gov/vuln/detail/CVE-2021-4209){: external}, [CVE-2022-1652](https://nvd.nist.gov/vuln/detail/CVE-2022-1652){: external}, [CVE-2022-1679](https://nvd.nist.gov/vuln/detail/CVE-2022-1679){: external}, [CVE-2022-1734](https://nvd.nist.gov/vuln/detail/CVE-2022-1734){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-2586](https://nvd.nist.gov/vuln/detail/CVE-2022-2586){: external}, [CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external}, [CVE-2022-34918](https://nvd.nist.gov/vuln/detail/CVE-2022-34918){: external}. |
| Kubernetes |N/A|N/A|N/A| 
{: caption="Changes since version 1.22.12_1565" caption-side="bottom"}


### Worker node fix pack 1.22.12_1565, released 01 August 2022
{: #12212_1565}

The following table shows the changes that are in the worker node fix pack 1.22.12_1565. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2022-27404](https://nvd.nist.gov/vuln/detail/CVE-2022-27404){: external}, [CVE-2022-27405](https://nvd.nist.gov/vuln/detail/CVE-2022-27405){: external}, [CVE-2022-27406](https://nvd.nist.gov/vuln/detail/CVE-2022-27406){: external}, [CVE-2022-29217](https://nvd.nist.gov/vuln/detail/CVE-2022-29217){: external}, [CVE-2022-31782](https://nvd.nist.gov/vuln/detail/CVE-2022-31782){: external}. |
| Kubernetes | 1.22.11 | 1.22.12 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.12){: external}. |
{: caption="Changes since version 1.22.11_1562" caption-side="bottom"}


### Master fix pack 1.22.12_1564, released 26 July 2022
{: #12212_1564}

The following table shows the changes that are in the master fix pack 1.22.12_1564. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.8 | v1.3.9 | Updated `Go` dependencies and to use `Go` version `1.18.4`. Fixed minor typographical error in the add-on `daemonset not available` health status. |
| Gateway-enabled cluster controller | 1680 | 1792 | Updated to use `Go` version `1.17.11`. Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external} and [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}. |
| GPU device plug-in and installer | 2b0b6d1 | d8f1be0 | Updated `Go` dependencies and to use `Go` version `1.18.3`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 980 | 997 | Updated to use `Go` version `1.17.11`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.10-3 | v1.22.11-3 | Updated `Go` dependencies. Updated to support the Kubernetes `1.22.11` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 410 | 412 | Updated to use `Go` version `1.18.3`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. Improved Kubernetes resource watch configuration. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8c96932 | 0a187a4 | Updated universal base image (UBI) to resolve CVEs. |
| Key Management Service provider | v2.5.6 | v2.5.7 | Updated `Go` dependencies and to use `Go` version `1.18.4`. |
| Kubernetes | v1.22.11 | v1.22.12 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.12){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1998 | 2058 | Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external}. |
| Operator Lifecycle Manager | 0.16.1-IKS-17 | 0.16.1-IKS-18 | Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external}. |
| Portieris admission controller | v0.12.4 | v0.12.5 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.5){: external}. |
{: caption="Changes since version 1.22.11_1556" caption-side="bottom"}


### Worker node fix pack 1.22.11_1562, released 18 July 2022
{: #12211_1562}

The following table shows the changes that are in the worker node fix pack 1.22.11_1562. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-188 | 4.15.0-189 | Worker node kernel & package updates for [CVE-2015-20107](https://nvd.nist.gov/vuln/detail/CVE-2015-20107){: external}, [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external}, [CVE-2022-22747](https://nvd.nist.gov/vuln/detail/CVE-2022-22747){: external}, [CVE-2022-24765](https://nvd.nist.gov/vuln/detail/CVE-2022-24765){: external}, [CVE-2022-29187](https://nvd.nist.gov/vuln/detail/CVE-2022-29187){: external}, [CVE-2022-34480](https://nvd.nist.gov/vuln/detail/CVE-2022-34480){: external}, [CVE-2022-34903](https://nvd.nist.gov/vuln/detail/CVE-2022-34903){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.22.11_1557" caption-side="bottom"}


### Worker node fix pack 1.22.11_1557, released 05 July 2022
{: #12211_1557}

The following table shows the changes that are in the worker node fix pack 1.22.11_1557. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-187 | 4.15.0-188 | Worker node kernel & package updates for [CVE-2022-1292](https://nvd.nist.gov/vuln/detail/CVE-2022-1292){: external}, [CVE-2022-2068](https://nvd.nist.gov/vuln/detail/CVE-2022-2068){: external}, [CVE-2022-2084](https://nvd.nist.gov/vuln/detail/CVE-2022-2084){: external}, [CVE-2022-28388](https://nvd.nist.gov/vuln/detail/CVE-2022-28388){: external}, [CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external}, [CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.22.11_1556" caption-side="bottom"}


### Master fix pack 1.22.11_1556, released 22 June 2022
{: #master_12211_1556}

The following table shows the changes that are in the master fix pack 1.22.11_1556. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.7 | v1.3.8 | Updated `Go` to version `1.17.11` and also updated the dependencies. |
| CoreDNS | 1.8.6 | 1.8.7 | See the [CoreDNS release notes](https://coredns.io/2021/12/09/coredns-1.8.7-release/){: external}. |
| GPU device plug-in and installer | 382ada9 | 2b0b6d1 | Updated universal base image (UBI) to version `8.6-751`. Updated `Go` to version `1.17.10`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.10-1 | v1.22.10-3 | Update prometheus/client_golang@v1.11.0 to `v1.11.1`. |
| Key Management Service provider | v2.5.5 | v2.5.6 | Updated `Go` to version `1.17.11` and also updated the dependencies. |
| Kubernetes | v1.22.10 | v1.22.11 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.11){: external}. |
| Kubernetes add-on resizer | 1.8.14 | 1.8.15 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.18.15){: external}. |
{: caption="Changes since version 1.22.10_1553" caption-side="bottom"}


### Worker node fix pack 1.22.11_1556, released 20 June 2022
{: #12211_1556}

The following table shows the changes that are in the worker node fix pack 1.22.11_1556. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-180 | 4.15.0-187 | Worker node kernel & package updates for [CVE-2021-46790](https://nvd.nist.gov/vuln/detail/CVE-2021-46790){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}, [CVE-2022-1419](https://nvd.nist.gov/vuln/detail/CVE-2022-1419){: external}, [CVE-2022-1966](https://nvd.nist.gov/vuln/detail/CVE-2022-1966){: external}, [CVE-2022-21123](https://nvd.nist.gov/vuln/detail/CVE-2022-21123){: external}, [CVE-2022-21125](https://nvd.nist.gov/vuln/detail/CVE-2022-21125){: external}, [CVE-2022-21166](https://nvd.nist.gov/vuln/detail/CVE-2022-21166){: external}, [CVE-2022-21499](https://nvd.nist.gov/vuln/detail/CVE-2022-21499){: external}, [CVE-2022-28390](https://nvd.nist.gov/vuln/detail/CVE-2022-28390){: external}, [CVE-2022-30783](https://nvd.nist.gov/vuln/detail/CVE-2022-30783){: external}, [CVE-2022-30784](https://nvd.nist.gov/vuln/detail/CVE-2022-30784){: external}, [CVE-2022-30785](https://nvd.nist.gov/vuln/detail/CVE-2022-30785){: external}, [CVE-2022-30786](https://nvd.nist.gov/vuln/detail/CVE-2022-30786){: external}, [CVE-2022-30787](https://nvd.nist.gov/vuln/detail/CVE-2022-30787){: external}, [CVE-2022-30788](https://nvd.nist.gov/vuln/detail/CVE-2022-30788){: external}, [CVE-2022-30789](https://nvd.nist.gov/vuln/detail/CVE-2022-30789){: external}. |
| Haproxy | 468c09 | 04f862 | [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}. |
| containerd | v1.5.11 | v1.5.13 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.5.13){: external}, the [security bulletin](https://www.ibm.com/support/pages/node/6597989){: external} for [CVE-2022-31030](https://nvd.nist.gov/vuln/detail/CVE-2022-31030){: external}, and the [security bulletin](https://www.ibm.com/support/pages/node/6598049){: external} for [CVE-2022-29162](https://nvd.nist.gov/vuln/detail/CVE-2022-29162){: external}. |
| Kubernetes | 1.22.10 | 1.22.11 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.11){: external}. |
{: caption="Changes since version 1.22.10_1554" caption-side="bottom"}


### Worker node fix pack 1.22.10_1554, released 7 June 2022
{: #12210_1554}

The following table shows the changes that are in the worker node fix pack 1.22.10_1554. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-177 | 4.15.0-180 | Worker node kernel & package updates for [CVE-2019-13050](https://nvd.nist.gov/vuln/detail/CVE-2019-13050){: external}, [CVE-2022-1664](https://nvd.nist.gov/vuln/detail/CVE-2022-1664){: external}, [CVE-2022-29581](https://nvd.nist.gov/vuln/detail/CVE-2022-29581){: external}. |
{: caption="Changes since version 1.22.9_1552" caption-side="bottom"}


### Master fix pack 1.22.10_1553, released 3 June 2022
{: #12210_1553}

The following table shows the changes that are in the master fix pack 1.22.10_1553. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.6 | v1.3.7 | Updated Go to version 1.17.10 and also updated the dependencies. Update registry base image version to `104` |
| GPU device plug-in and installer | 9485e14 | 382ada9 | Updated `Go` to version `1.17.9` |
| {{site.data.keyword.IBM_notm}} Calico extension | 954 | 980 | Updated to use `Go` version `1.17.10`. Updated minimal UBI to version `8.5`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.22.8-7 | v1.22.10-1 | Updated to support the Kubernetes `1.22.10` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 408 | 410 | Updated universal base image (UBI) to version `8.6-751` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8c8c82b | 8c96932 | Updated `Go` to version `1.18.1` |
| Key Management Service provider | v2.5.4 | v2.5.5 | Updated `Go` to version `1.17.10` and updated the golang dependencies. |
| Kubernetes | v1.22.9 | v1.22.10 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.22.10){: external}. |
| Kubernetes Dashboard | v2.3.1 | v2.3.1 | The **default** Kubernetes Dashboard settings found in the `kubernetes-dashboard-settings` config map in the `kube-system` namespace have been updated to set `resourceAutoRefreshTimeInterval` to `60`. This default change is only applied to new clusters. The previous default value was `5`. If your cluster has Kubernetes Dashboard performance problems, see the steps for [changing the auto refresh time interval](/docs/containers?topic=containers-ts-kube-dashboord-oom). | 
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1916 | 1998 | Updated `Go` to version `1.17.10` and updated dependencies. |
{: caption="Changes since version 1.22.9_1549" caption-side="bottom"}


### Worker node fix pack 1.22.9_1552, released 23 May 2022
{: #1229_1552}

The following table shows the changes that are in the worker node fix pack 1.22.9_1552. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-176 | 4.15.0-177 | Worker node kernel & package updates for [CVE-2019-20838](https://nvd.nist.gov/vuln/detail/CVE-2019-20838){: external}, [CVE-2020-14155](https://nvd.nist.gov/vuln/detail/CVE-2020-14155){: external}, [CVE-2020-25648](https://nvd.nist.gov/vuln/detail/CVE-2020-25648){: external}, [CVE-2020-35512](https://nvd.nist.gov/vuln/detail/CVE-2020-35512){: external}, [CVE-2021-26401](https://nvd.nist.gov/vuln/detail/CVE-2021-26401){: external}, [CVE-2022-0001](https://nvd.nist.gov/vuln/detail/CVE-2022-0001){: external}, [CVE-2022-0934](https://nvd.nist.gov/vuln/detail/CVE-2022-0934){: external}, [CVE-2022-26490](https://nvd.nist.gov/vuln/detail/CVE-2022-26490){: external}, [CVE-2022-27223](https://nvd.nist.gov/vuln/detail/CVE-2022-27223){: external}, [CVE-2022-27781](https://nvd.nist.gov/vuln/detail/CVE-2022-27781){: external}, [CVE-2022-27782](https://nvd.nist.gov/vuln/detail/CVE-2022-27782){: external}, [CVE-2022-28657](https://nvd.nist.gov/vuln/detail/CVE-2022-28657){: external}, [CVE-2022-29155](https://nvd.nist.gov/vuln/detail/CVE-2022-29155){: external}, [CVE-2022-29824](https://nvd.nist.gov/vuln/detail/CVE-2022-29824){: external}, [CVE-2017-9525](https://nvd.nist.gov/vuln/detail/CVE-2017-9525){: external}, [CVE-2022-28654](https://nvd.nist.gov/vuln/detail/CVE-2022-28654){: external}, [CVE-2022-28656](https://nvd.nist.gov/vuln/detail/CVE-2022-28656){: external}, [CVE-2022-28655](https://nvd.nist.gov/vuln/detail/CVE-2022-28655){: external}, [CVE-2022-28652](https://ubuntu.com/security/CVE-2022-28652){: external}, [CVE-2022-1242](https://nvd.nist.gov/vuln/detail/CVE-2022-1242){: external}, [CVE-2022-28658](https://nvd.nist.gov/vuln/detail/CVE-2022-28658){: external}, [CVE-2021-3899](https://nvd.nist.gov/vuln/detail/CVE-2021-3899){: external}. |
| HA proxy | 36b0307 | 468c09 | [CVE-2021-3634](https://nvd.nist.gov/vuln/detail/CVE-2021-3634){: external}. |
{: caption="Changes since version 1.22.9_1551" caption-side="bottom"}


### Worker node fix pack 1.22.9_1551, released 09 May 2022
{: #1229_1551}

The following table shows the changes that are in the worker node fix pack 1.22.9_1551. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | N/A | N/A | Worker node package updates for [CVE-2021-36084](https://nvd.nist.gov/vuln/detail/CVE-2021-36084){: external}, [CVE-2021-36085](https://nvd.nist.gov/vuln/detail/CVE-2021-36085){: external}, [CVE-2021-36086](https://nvd.nist.gov/vuln/detail/CVE-2021-36086){: external}, [CVE-2021-36087](https://nvd.nist.gov/vuln/detail/CVE-2021-36087){: external}, [CVE-2022-1292](https://nvd.nist.gov/vuln/detail/CVE-2022-1292){: external}, [CVE-2022-22576](https://nvd.nist.gov/vuln/detail/CVE-2022-22576){: external}, [CVE-2022-27774](https://nvd.nist.gov/vuln/detail/CVE-2022-27774){: external}, [CVE-2022-27775](https://nvd.nist.gov/vuln/detail/CVE-2022-27775){: external}, [CVE-2022-27776](https://nvd.nist.gov/vuln/detail/CVE-2022-27776){: external}, [CVE-2022-29799](https://nvd.nist.gov/vuln/detail/CVE-2022-29799){: external}, [CVE-2022-29800](https://nvd.nist.gov/vuln/detail/CVE-2022-29800){: external}. |
| Kubernetes | N/A | N/A | N/A |
| Haproxy | f53b22 | 36b030 | [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}, [CVE-2022-1154](https://nvd.nist.gov/vuln/detail/CVE-2022-1154){: external}, [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032){: external}. |
{: caption="Changes since version 1.22.9_1550" caption-side="bottom"}
