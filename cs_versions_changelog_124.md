---

copyright: 
  years: 2022, 2022
lastupdated: "2022-11-23"

keywords: kubernetes, containers

subcollection: containers


---

# Kubernetes version 1.24 change log
{: #changelog_124}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.24. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_124}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.24 change log
{: #124_changelog}

Review the version 1.24 change log.
{: shortdesc}


### Change log for worker node fix pack 1.24.8_1545, released 21 November 2022
{: #1248_1545}

The following table shows the changes that are in the worker node fix pack 1.24.8_1545. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-194 | 4.15.0-197 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external},[CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external},[CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external},[CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external},[CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external},[CVE-2022-2978](https://nvd.nist.gov/vuln/detail/CVE-2022-2978){: external},[CVE-2022-3028](https://nvd.nist.gov/vuln/detail/CVE-2022-3028){: external},[CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external},[CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-35737](https://nvd.nist.gov/vuln/detail/CVE-2022-35737){: external},[CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external},[CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external},[CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external},[CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674){: external},[CVE-2022-40768](https://nvd.nist.gov/vuln/detail/CVE-2022-40768){: external},[CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external},[CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external},[CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external},[CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external},[CVE-2022-43680](https://nvd.nist.gov/vuln/detail/CVE-2022-43680){: external}. |
| Kubernetes | 1.24.7 | 1.24.8 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.8){: external}. |
| RHEL 7 Packages |N/A|N/A| Worker node package updates for [CVE-2022-21233](https://nvd.nist.gov/vuln/detail/CVE-2022-21233){: external},[CVE-2022-23816](https://nvd.nist.gov/vuln/detail/CVE-2022-23816){: external},[CVE-2022-23825](https://nvd.nist.gov/vuln/detail/CVE-2022-23825){: external},[CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external},[CVE-2022-26373](https://nvd.nist.gov/vuln/detail/CVE-2022-26373){: external},[CVE-2022-29900](https://nvd.nist.gov/vuln/detail/CVE-2022-29900){: external},[CVE-2022-29901](https://nvd.nist.gov/vuln/detail/CVE-2022-29901){: external},[CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}. |
| RHEL 8 Packages |N/A|N/A| Worker node package updates for [CVE-2015-20107](https://nvd.nist.gov/vuln/detail/CVE-2015-20107){: external},[CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external},[CVE-2020-0256](https://nvd.nist.gov/vuln/detail/CVE-2020-0256){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external},[CVE-2020-36516](https://nvd.nist.gov/vuln/detail/CVE-2020-36516){: external},[CVE-2020-36558](https://nvd.nist.gov/vuln/detail/CVE-2020-36558){: external},[CVE-2021-0308](https://nvd.nist.gov/vuln/detail/CVE-2021-0308){: external},[CVE-2021-25220](https://nvd.nist.gov/vuln/detail/CVE-2021-25220){: external},[CVE-2021-30002](https://nvd.nist.gov/vuln/detail/CVE-2021-30002){: external},[CVE-2021-36221](https://nvd.nist.gov/vuln/detail/CVE-2021-36221){: external},[CVE-2021-3640](https://nvd.nist.gov/vuln/detail/CVE-2021-3640){: external},[CVE-2021-41190](https://nvd.nist.gov/vuln/detail/CVE-2021-41190){: external},[CVE-2022-0168](https://nvd.nist.gov/vuln/detail/CVE-2022-0168){: external},[CVE-2022-0494](https://nvd.nist.gov/vuln/detail/CVE-2022-0494){: external},[CVE-2022-0617](https://nvd.nist.gov/vuln/detail/CVE-2022-0617){: external},[CVE-2022-0854](https://nvd.nist.gov/vuln/detail/CVE-2022-0854){: external},[CVE-2022-1016](https://nvd.nist.gov/vuln/detail/CVE-2022-1016){: external},[CVE-2022-1048](https://nvd.nist.gov/vuln/detail/CVE-2022-1048){: external},[CVE-2022-1055](https://nvd.nist.gov/vuln/detail/CVE-2022-1055){: external},[CVE-2022-1184](https://nvd.nist.gov/vuln/detail/CVE-2022-1184){: external},[CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external},[CVE-2022-1353](https://nvd.nist.gov/vuln/detail/CVE-2022-1353){: external},[CVE-2022-1708](https://nvd.nist.gov/vuln/detail/CVE-2022-1708){: external},[CVE-2022-1852](https://nvd.nist.gov/vuln/detail/CVE-2022-1852){: external},[CVE-2022-20368](https://nvd.nist.gov/vuln/detail/CVE-2022-20368){: external},[CVE-2022-2078](https://nvd.nist.gov/vuln/detail/CVE-2022-2078){: external},[CVE-2022-21499](https://nvd.nist.gov/vuln/detail/CVE-2022-21499){: external},[CVE-2022-22624](https://nvd.nist.gov/vuln/detail/CVE-2022-22624){: external},[CVE-2022-22628](https://nvd.nist.gov/vuln/detail/CVE-2022-22628){: external},[CVE-2022-22629](https://nvd.nist.gov/vuln/detail/CVE-2022-22629){: external},[CVE-2022-22662](https://nvd.nist.gov/vuln/detail/CVE-2022-22662){: external},[CVE-2022-23816](https://nvd.nist.gov/vuln/detail/CVE-2022-23816){: external},[CVE-2022-23825](https://nvd.nist.gov/vuln/detail/CVE-2022-23825){: external},[CVE-2022-23960](https://nvd.nist.gov/vuln/detail/CVE-2022-23960){: external},[CVE-2022-24448](https://nvd.nist.gov/vuln/detail/CVE-2022-24448){: external},[CVE-2022-24795](https://nvd.nist.gov/vuln/detail/CVE-2022-24795){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-2586](https://nvd.nist.gov/vuln/detail/CVE-2022-2586){: external},[CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external},[CVE-2022-26373](https://nvd.nist.gov/vuln/detail/CVE-2022-26373){: external},[CVE-2022-2639](https://nvd.nist.gov/vuln/detail/CVE-2022-2639){: external},[CVE-2022-26700](https://nvd.nist.gov/vuln/detail/CVE-2022-26700){: external},[CVE-2022-26709](https://nvd.nist.gov/vuln/detail/CVE-2022-26709){: external},[CVE-2022-26710](https://nvd.nist.gov/vuln/detail/CVE-2022-26710){: external},[CVE-2022-26716](https://nvd.nist.gov/vuln/detail/CVE-2022-26716){: external},[CVE-2022-26717](https://nvd.nist.gov/vuln/detail/CVE-2022-26717){: external},[CVE-2022-26719](https://nvd.nist.gov/vuln/detail/CVE-2022-26719){: external},[CVE-2022-27191](https://nvd.nist.gov/vuln/detail/CVE-2022-27191){: external},[CVE-2022-27404](https://nvd.nist.gov/vuln/detail/CVE-2022-27404){: external},[CVE-2022-27405](https://nvd.nist.gov/vuln/detail/CVE-2022-27405){: external},[CVE-2022-27406](https://nvd.nist.gov/vuln/detail/CVE-2022-27406){: external},[CVE-2022-27950](https://nvd.nist.gov/vuln/detail/CVE-2022-27950){: external},[CVE-2022-28390](https://nvd.nist.gov/vuln/detail/CVE-2022-28390){: external},[CVE-2022-28893](https://nvd.nist.gov/vuln/detail/CVE-2022-28893){: external},[CVE-2022-29162](https://nvd.nist.gov/vuln/detail/CVE-2022-29162){: external},[CVE-2022-2938](https://nvd.nist.gov/vuln/detail/CVE-2022-2938){: external},[CVE-2022-29581](https://nvd.nist.gov/vuln/detail/CVE-2022-29581){: external},[CVE-2022-2989](https://nvd.nist.gov/vuln/detail/CVE-2022-2989){: external},[CVE-2022-2990](https://nvd.nist.gov/vuln/detail/CVE-2022-2990){: external},[CVE-2022-29900](https://nvd.nist.gov/vuln/detail/CVE-2022-29900){: external},[CVE-2022-29901](https://nvd.nist.gov/vuln/detail/CVE-2022-29901){: external},[CVE-2022-30293](https://nvd.nist.gov/vuln/detail/CVE-2022-30293){: external},[CVE-2022-32746](https://nvd.nist.gov/vuln/detail/CVE-2022-32746){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-36946](https://nvd.nist.gov/vuln/detail/CVE-2022-36946){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2022-3787](https://nvd.nist.gov/vuln/detail/CVE-2022-3787){: external},[CVE-2022-40674](https://nvd.nist.gov/vuln/detail/CVE-2022-40674){: external},[CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}. |
| CUDA | 576234 | cce0cf | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.24.7_1543" caption-side="top"}


### Change log for master fix pack 1.24.8_1544, released 16 November 2022
{: #1248_1544}

The following table shows the changes that are in the master fix pack 1.24.8_1544. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.23.3 | v3.24.5 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.24/release-notes/#v3245){: external}. |
| Cluster health image | v1.3.12 | v1.3.13 | Updated Go dependencies, golangci-lint, gosec, and to `Go` version 1.19.3. Updated base image version to 116. |
| etcd | v3.5.4 | v3.5.5 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.5){: external}. |
| Gateway-enabled cluster controller | 1823 | 1902 | `Go` module updates. |
| GPU device plug-in and installer | 373bb9f | cce0cfa | Updated the GPU driver 470 minor version |
| {{site.data.keyword.IBM_notm}} Calico extension | 1096 | 1213 | Updated image to fix the following CVEs: [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external}, [CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}, [CVE-2022-3515](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-3515){: external}, [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}, [CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}, [CVE-2022-32149](https://nvd.nist.gov/vuln/detail/CVE-2022-32149){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.3.1 | v2.3.3 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.7-1 | v1.24.7-10 | Key rotation and updated `Go` dependencies. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 416 | 420 | Updated universal base image (UBI) to version `8.7-923` to resolve CVEs. |
| Key Management Service provider | v2.5.10 | v2.5.11 | Updated `Go` dependencies and to `Go` version `1.19.3`. |
| Kubernetes | v1.24.7 | v1.24.8 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.8){: external}. |
{: caption="Changes since version 1.24.7_1542" caption-side="bottom"}


### Change log for worker node fix pack 1.24.7_1543, released 07 November 2022
{: #1247_1543}

The following table shows the changes that are in the worker node fix pack 1.24.7_1543. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node package updates for [CVE-2022-32221](https://nvd.nist.gov/vuln/detail/CVE-2022-32221){: external},[CVE-2022-40284](https://nvd.nist.gov/vuln/detail/CVE-2022-40284){: external},[CVE-2022-42010](https://nvd.nist.gov/vuln/detail/CVE-2022-42010){: external},[CVE-2022-42011](https://nvd.nist.gov/vuln/detail/CVE-2022-42011){: external},[CVE-2022-42012](https://nvd.nist.gov/vuln/detail/CVE-2022-42012){: external}. |
| Kubernetes | 1.24.6 | 1.24.7 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.7){: external}. |
| RHEL 7 Packages | 3.10.0-1160.76.1 | 3.10.0-1160.80.1 | Worker node kernel & package updates for [CVE-2022-21233](https://nvd.nist.gov/vuln/detail/CVE-2022-21233){: external},[CVE-2022-23816](https://nvd.nist.gov/vuln/detail/CVE-2022-23816){: external},[CVE-2022-23825](https://nvd.nist.gov/vuln/detail/CVE-2022-23825){: external},[CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external},[CVE-2022-26373](https://nvd.nist.gov/vuln/detail/CVE-2022-26373){: external},[CVE-2022-29900](https://nvd.nist.gov/vuln/detail/CVE-2022-29900){: external},[CVE-2022-29901](https://nvd.nist.gov/vuln/detail/CVE-2022-29901){: external},[CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}. |
| RHEL 8 Packages | 4.18.0-372.26.1 | 4.18.0-372.32.1 | Worker node kernel & package updates for [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external},[CVE-2022-0494](https://nvd.nist.gov/vuln/detail/CVE-2022-0494){: external},[CVE-2022-1353](https://nvd.nist.gov/vuln/detail/CVE-2022-1353){: external},[CVE-2022-23816](https://nvd.nist.gov/vuln/detail/CVE-2022-23816){: external},[CVE-2022-23825](https://nvd.nist.gov/vuln/detail/CVE-2022-23825){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external},[CVE-2022-29900](https://nvd.nist.gov/vuln/detail/CVE-2022-29900){: external},[CVE-2022-29901](https://nvd.nist.gov/vuln/detail/CVE-2022-29901){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2022-41974](https://nvd.nist.gov/vuln/detail/CVE-2022-41974){: external}. |
| HAPROXY | b034b2 | 3a1392 | [CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external},[CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external}. |
| CUDA | 3ea43b | 576234 | [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external},[CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2020-35527](https://nvd.nist.gov/vuln/detail/CVE-2020-35527){: external}. |
{: caption="Changes since version 1.24.6_1541" caption-side="top"}


### Change log for master fix pack 1.24.7_1542, released 27 October 2022
{: #1247_1542}

The following table shows the changes that are in the master fix pack 1.24.7_1542. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.11 | v1.3.12 | Updated `Go` dependencies, golangci-lint, and to `Go` version 1.19.2. Updated base image version to 109. Excluded ingress status from cluster status calculation. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.5-1 | v1.24.7-1 | Updated to support the `Kubernetes 1.24.7` release. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | dc1725a | 778ef2b | Updated to `Go` version `1.18.6`. |
| Key Management Service provider | v2.5.9 | v2.5.10 | Updated `Go` dependencies and to `Go` version `1.19.2`. |
| Kubernetes | v1.24.6 | v1.24.7 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.7){: external}. |
| Konnectivity agent and server | v0.0.32_363_iks | v0.0.33_418_iks | Updated Konnectivity to version v0.0.33 and added s390x functionality. See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.0.33){: external}. |
{: caption="Changes since version 1.24.6_1538" caption-side="bottom"}


### Change log for worker node fix pack 1.24.6_1541, released 25 October 2022
{: #1246_1541}

The following table shows the changes that are in the worker node fix pack 1.24.6_1541. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-193 | 4.15.0-194 | Worker node kernel & package updates for [CVE-2018-16860](https://nvd.nist.gov/vuln/detail/CVE-2018-16860){: external}, [CVE-2019-12098](https://nvd.nist.gov/vuln/detail/CVE-2019-12098){: external}, [CVE-2020-16156](https://nvd.nist.gov/vuln/detail/CVE-2020-16156){: external}, [CVE-2021-3671](https://nvd.nist.gov/vuln/detail/CVE-2021-3671){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2022-3116](https://nvd.nist.gov/vuln/detail/CVE-2022-3116){: external}, [CVE-2022-3515](https://nvd.nist.gov/vuln/detail/CVE-2022-3515){: external}, [CVE-2022-39253](https://nvd.nist.gov/vuln/detail/CVE-2022-39253){: external}, [CVE-2022-39260](https://nvd.nist.gov/vuln/detail/CVE-2022-39260){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.6_1540" caption-side="bottom"}


### Change log for worker node fix pack 1.24.6_1540, released 10 October 2022
{: #1246_1540}

The following table shows the changes that are in the worker node fix pack 1.24.6_1540. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A|N/A|
| Kubernetes |N/A|N/A|N/A|
| RHEL 7 Packages |N/A|N/A|N/A|
| RHEL 8 Packages |N/A|N/A|N/A|
{: caption="Changes since version 1.24.6_1539" caption-side="bottom"}


### Change log for master fix pack 1.24.6_1538, released 26 September 2022
{: #1246_1538}

The following table shows the changes that are in the master fix pack 1.24.6_1538. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.10 | v1.3.11 | Updated `Go` dependencies and to `Go` version `1.18.6`. |
| GPU device plug-in and installer | c58c299 | 373bb9f | Updated to `Go` version `1.19.1`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 1006 | 1096 | Updated image for [CVE-2022-2526](https://nvd.nist.gov/vuln/detail/CVE-2022-2526){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.9 | v2.3.1 | Updated to `Go` version `1.18.6`. Updated universal base image (UBI) to version `8.6-941` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.4-1 | v1.24.5-1 | Updated `Go` dependencies and to use `Go` version `1.18.6`. Updated to support the Kubernetes `1.24.5` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 414 | 416 | Updated to `Go` version `1.18.6`. Updated universal base image (UBI) to version `8.6-941` to resolve CVEs. |
| Key Management Service Provider | v2.5.8 | v2.5.9 | Updated `Go` dependencies and to `Go` version `1.18.6`. |
| Kubernetes | v1.24.4 | v1.24.6 | This update resolves [CVE-2022-3172](https://nvd.nist.gov/vuln/detail/CVE-2022-3172){: external}. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6823785){: external}. See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.6){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.6 | 1.22.11 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.11){: external}. |
{: caption="Changes since version 1.24.41536" caption-side="bottom"}


### Change log for worker node fix pack 1.24.6_1539, released 26 September 2022
{: #1246_1539}

The following table shows the changes that are in the worker node fix pack 1.24.6_1539. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-192 | 4.15.0-193 | Worker node kernel & package updates for [CVE-2020-35525](https://nvd.nist.gov/vuln/detail/CVE-2020-35525){: external},[CVE-2021-33655](https://nvd.nist.gov/vuln/detail/CVE-2021-33655){: external},[CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external},[CVE-2022-0943](https://nvd.nist.gov/vuln/detail/CVE-2022-0943){: external},[CVE-2022-1154](https://nvd.nist.gov/vuln/detail/CVE-2022-1154){: external},[CVE-2022-1616](https://nvd.nist.gov/vuln/detail/CVE-2022-1616){: external},[CVE-2022-1619](https://nvd.nist.gov/vuln/detail/CVE-2022-1619){: external},[CVE-2022-1620](https://nvd.nist.gov/vuln/detail/CVE-2022-1620){: external},[CVE-2022-1621](https://nvd.nist.gov/vuln/detail/CVE-2022-1621){: external},[CVE-2022-2526](https://nvd.nist.gov/vuln/detail/CVE-2022-2526){: external},[CVE-2022-2795](https://nvd.nist.gov/vuln/detail/CVE-2022-2795){: external},[CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external},[CVE-2022-36946](https://nvd.nist.gov/vuln/detail/CVE-2022-36946){: external},[CVE-2022-38177](https://nvd.nist.gov/vuln/detail/CVE-2022-38177){: external},[CVE-2022-38178](https://nvd.nist.gov/vuln/detail/CVE-2022-38178){: external}. |
| Kubernetes | 1.24.4 | 1.24.6 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.6){: external}. |
| RHEL 7 Packages |N/A|N/A|N/A|
| RHEL 8 Packages | 4.18.0-372.19.1 | 4.18.0-372.26.1 |N/A|
{: caption="Changes since version 1.24.4_1537" caption-side="bottom"}


### Change log for worker node fix pack 1.24.4_1537, released 12 September 2022
{: #1244_1537}

The following table shows the changes that are in the worker node fix pack 1.24.4_1537. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-191 | 4.15.0-192 | Worker node kernel & package updates for [CVE-2021-33656](https://nvd.nist.gov/vuln/detail/CVE-2021-33656){: external},[CVE-2022-35252](https://nvd.nist.gov/vuln/detail/CVE-2022-35252){: external}. |
| Kubernetes |N/A|N/A|N/A| 
{: caption="Changes since version 1.24.4_1535" caption-side="bottom"}


### Change log for master fix pack 1.24.4_1536, released 1 September 2022
{: #1244_1536}

The following table shows the changes that are in the master fix pack 1.24.4_1536. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.3.9 | v1.3.10 | Updated `Go` dependencies and to `Go` version `1.18.5`. |
| Gateway-enabled cluster controller | 1792 | 1823 | Updated to `Go` version `1.17.13`. |
| GPU device plug-in and installer | d8f1be0 | c58c299 | Enable DRM module and update `Go` to version `1.18.5`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 997 | 1006 | Updated to `Go` version `1.17.13`. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.8 | v2.2.9 | Updated to `Go` version `1.18.5`. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.2-8 | v1.24.4-1 | Updated `vpcctl` binary to version `3367`. Updated to support the Kubernetes `1.24.4` release. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 412 | 414 | Updated to `Go` version `1.18.5`. Updated universal base image (UBI) to version `8.6-902` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 0a187a4 | dc1725a | Updated `Go` dependencies and to `Go` version `1.18.3`. |
| Key Management Service provider | v2.5.7 | v2.5.8 | Updated `Go` dependencies. |
| Konnectivity agent and server | v0.0.30_331_iks | v0.0.32_363_iks | Updated to `Go` version `1.17.13` and to `Konnectivity` version `v0.0.32`. |
| Kubernetes | v1.24.3 | v1.24.4 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.4){: external}. |
| Kubernetes Dashboard | v2.5.0 | v2.6.1 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.6.1){: external}. |
| Kubernetes Dashboard metrics scraper | v1.0.7 | v1.0.8 | See the [Kubernetes Dashboard metrics scraper release notes](https://github.com/kubernetes-sigs/dashboard-metrics-scraper/releases/tag/v1.0.8){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.5 | 1.22.6 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.6){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2058 | 2110 | Updated `Go` dependencies and to `Go` version `1.17.13`. |
| Portieris admission controller | v0.12.5 | v0.12.6 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.6){: external}. |
{: caption="Changes since version 1.24.3_1531" caption-side="bottom"}


### Change log for worker node fix pack 1.24.4_1535, released 29 August 2022
{: #1244_1535}

The following table shows the changes that are in the worker node fix pack 1.24.4_1535. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2019-5815](https://nvd.nist.gov/vuln/detail/CVE-2019-5815){: external},[CVE-2021-30560](https://nvd.nist.gov/vuln/detail/CVE-2021-30560){: external},[CVE-2022-31676](https://nvd.nist.gov/vuln/detail/CVE-2022-31676){: external},[CVE-2022-37434](https://nvd.nist.gov/vuln/detail/CVE-2022-37434){: external}. |
| Kubernetes | 1.24.3 | 1.24.4 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.4){: external}. | 
| HAPROXY | 6514a2 | c1634f | [CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external},[CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}
{: caption="Changes since version 1.24.3_1533" caption-side="bottom"}


### Change log for worker node fix pack 1.24.3_1533, released 16 August 2022
{: #1243_1533}

The following table shows the changes that are in the worker node fix pack 1.24.3_1533. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-189 | 4.15.0-191 | Worker node kernel & package updates for [CVE-2016-3709](https://nvd.nist.gov/vuln/detail/CVE-2016-3709){: external},[CVE-2021-4209](https://nvd.nist.gov/vuln/detail/CVE-2021-4209){: external},[CVE-2022-1652](https://nvd.nist.gov/vuln/detail/CVE-2022-1652){: external},[CVE-2022-1679](https://nvd.nist.gov/vuln/detail/CVE-2022-1679){: external},[CVE-2022-1734](https://nvd.nist.gov/vuln/detail/CVE-2022-1734){: external},[CVE-2022-2509](https://nvd.nist.gov/vuln/detail/CVE-2022-2509){: external},[CVE-2022-2586](https://nvd.nist.gov/vuln/detail/CVE-2022-2586){: external},[CVE-2022-2588](https://nvd.nist.gov/vuln/detail/CVE-2022-2588){: external},[CVE-2022-34918](https://nvd.nist.gov/vuln/detail/CVE-2022-34918){: external}. |
| Kubernetes |N/A|N/A|N/A| 
| containerd | 1.6.6 | 1.6.8 | For more information, see the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.8){: external}. |
{: caption="Changes since version 1.24.3_1532" caption-side="bottom"}


### Change log for worker node fix pack 1.24.3_1532, released 01 August 2022
{: #1243_1532}

The following table shows the changes that are in the worker node fix pack 1.24.3_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages |N/A|N/A| Worker node kernel & package updates for [CVE-2022-27404](https://nvd.nist.gov/vuln/detail/CVE-2022-27404){: external},[CVE-2022-27405](https://nvd.nist.gov/vuln/detail/CVE-2022-27405){: external},[CVE-2022-27406](https://nvd.nist.gov/vuln/detail/CVE-2022-27406){: external},[CVE-2022-29217](https://nvd.nist.gov/vuln/detail/CVE-2022-29217){: external},[CVE-2022-31782](https://nvd.nist.gov/vuln/detail/CVE-2022-31782){: external}. |
| Kubernetes | 1.24.2 | 1.24.3 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.3){: external}. |
{: caption="Changes since version 1.24.2_1529" caption-side="bottom"}


### Change log for master fix pack 1.24.3_1531, released 26 July 2022
{: #1243_1531}

The following table shows the changes that are in the master fix pack 1.24.3_1531. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.23.1 | v3.23.3 | See the [Calico release notes](https://projectcalico.docs.tigera.io/releases){: external}. Updated the Calico custom resource definitions to include `preserveUnknownFields: false`. |
| Cluster health image | v1.3.8 | v1.3.9 | Updated `Go` dependencies and to use `Go` version `1.18.4`. Fixed minor typo in addon `daemonset not available` health status. |
| Gateway-enabled cluster controller | 1680 | 1792 | Updated to use `Go` version `1.17.11`. Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external} and [CVE-2022-29458](https://nvd.nist.gov/vuln/detail/CVE-2022-29458){: external}. |
| GPU device plug-in and installer | 2b0b6d1 | d8f1be0 | Updated `Go` dependencies and to use `Go` version `1.18.3`. |
| {{site.data.keyword.IBM_notm}} Calico extension | 980 | 997 | Updated to use `Go` version `1.17.11`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.6 | v2.2.8 | Updated to use `Go` version `1.18.3`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.24.1-7 | v1.24.2-8 | Updated `Go` dependencies and to use `Go` version `1.18.3`. Updated to support the Kubernetes `1.24.2` release. [Disabling load balancer NodePort allocation](https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-nodeport-allocation){: external} is now prevented for VPC load balancers. |
| {{site.data.keyword.filestorage_full_notm}} plug-in and monitor | 410 | 412 | Updated to use `Go` version `1.18.3`. Updated universal base image (UBI) to version `8.6-854` to resolve CVEs. Improved Kubernetes resource watch configuration. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 8c96932 | 0a187a4 | Updated universal base image (UBI) to resolve CVEs. |
| Key Management Service provider | v2.5.6 | v2.5.7 | Updated `Go` dependencies and to use `Go` version `1.18.4`. |
| Kubernetes | v1.24.2 | v1.24.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.3){: external}. |
| Kubernetes NodeLocal DNS cache | 1.22.2 | 1.22.5 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.5){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 1998 | 2058 | Updated image for [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external}. |
| Portieris admission controller | v0.12.4 | v0.12.5 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.12.5){: external}. |
{: caption="Changes since version 1.24.2_1526" caption-side="bottom"}


### Change log for worker node fix pack 1.24.2_1529, released 18 July 2022
{: #1242_1529}

The following table shows the changes that are in the worker node fix pack 1.24.2_1529. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-188 | 4.15.0-189 | Worker node kernel & package updates for [CVE-2015-20107](https://nvd.nist.gov/vuln/detail/CVE-2015-20107){: external}, [CVE-2022-2097](https://nvd.nist.gov/vuln/detail/CVE-2022-2097){: external},[CVE-2022-22747](https://nvd.nist.gov/vuln/detail/CVE-2022-22747){: external}, [CVE-2022-24765](https://nvd.nist.gov/vuln/detail/CVE-2022-24765){: external}, [CVE-2022-29187](https://nvd.nist.gov/vuln/detail/CVE-2022-29187){: external},[CVE-2022-34480](https://nvd.nist.gov/vuln/detail/CVE-2022-34480){: external},[CVE-2022-34903](https://nvd.nist.gov/vuln/detail/CVE-2022-34903){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.2_1527" caption-side="bottom"}


### Change log for worker node fix pack 1.24.2_1527, released 05 July 2022
{: #1242_1527}

The following table shows the changes that are in the worker node fix pack 1.24.2_1527. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-187 | 4.15.0-188 | Worker node kernel & package updates for [CVE-2022-1292](https://nvd.nist.gov/vuln/detail/CVE-2022-1292){: external},[CVE-2022-2068](https://nvd.nist.gov/vuln/detail/CVE-2022-2068){: external},[CVE-2022-2084](https://nvd.nist.gov/vuln/detail/CVE-2022-2084){: external},[CVE-2022-28388](https://nvd.nist.gov/vuln/detail/CVE-2022-28388){: external},[CVE-2022-32206](https://nvd.nist.gov/vuln/detail/CVE-2022-32206){: external},[CVE-2022-32208](https://nvd.nist.gov/vuln/detail/CVE-2022-32208){: external}. |
| Kubernetes |N/A|N/A|N/A|
{: caption="Changes since version 1.24.2_1526" caption-side="bottom"}


### Change log for master fix pack 1.24.2_1526, released 22 June 2022
{: #master_1242_1526}

The following table shows the changes that are in the master fix pack 1.24.2_1526. Master patch updates are applied automatically. 
{: shortdesc}


| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.2.4 | v2.2.6 | Bug fixes for the driver installation. Block plugin base images were updated to `ubi`: `8.6-751.1655117800` for CVE-2022-1271 |
| Kubernetes | v1.24.1 | v1.24.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.2){: external}. |
| Kubernetes add-on resizer | 1.8.14 | 1.8.15 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.18.15){: external}. |
{: caption="Changes since version 1.24.1_1523" caption-side="bottom"}


### Change log for worker node fix pack 1.24.2_1526, released 20 June 2022
{: #1242_1526}

The following table shows the changes that are in the worker node fix pack 1.24.2_1526. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 18.04 packages | 4.15.0-180 | 4.15.0-187 | Worker node kernel & package updates for [CVE-2021-46790](https://nvd.nist.gov/vuln/detail/CVE-2021-46790){: external}, [CVE-2022-1304](https://nvd.nist.gov/vuln/detail/CVE-2022-1304){: external}, [CVE-2022-1419](https://nvd.nist.gov/vuln/detail/CVE-2022-1419){: external}, [CVE-2022-1966](https://nvd.nist.gov/vuln/detail/CVE-2022-1966){: external}, [CVE-2022-21123](https://nvd.nist.gov/vuln/detail/CVE-2022-21123){: external}, [CVE-2022-21125](https://nvd.nist.gov/vuln/detail/CVE-2022-21125){: external}, [CVE-2022-21166](https://nvd.nist.gov/vuln/detail/CVE-2022-21166){: external}, [CVE-2022-21499](https://nvd.nist.gov/vuln/detail/CVE-2022-21499){: external}, [CVE-2022-28390](https://nvd.nist.gov/vuln/detail/CVE-2022-28390){: external}, [CVE-2022-30783](https://nvd.nist.gov/vuln/detail/CVE-2022-30783){: external}, [CVE-2022-30784](https://nvd.nist.gov/vuln/detail/CVE-2022-30784){: external}, [CVE-2022-30785](https://nvd.nist.gov/vuln/detail/CVE-2022-30785){: external}, [CVE-2022-30786](https://nvd.nist.gov/vuln/detail/CVE-2022-30786){: external}, [CVE-2022-30787](https://nvd.nist.gov/vuln/detail/CVE-2022-30787){: external}, [CVE-2022-30788](https://nvd.nist.gov/vuln/detail/CVE-2022-30788){: external}, [CVE-2022-30789](https://nvd.nist.gov/vuln/detail/CVE-2022-30789){: external}. |
| Haproxy | 468c09 | 04f862 | [CVE-2022-1271](https://nvd.nist.gov/vuln/detail/CVE-2022-1271){: external}. |
| containerd | v1.6.4 | v1.6.6 | See the [change log](https://github.com/containerd/containerd/releases/tag/v1.6.6){: external}, the [security bulletin](https://www.ibm.com/support/pages/node/6597989){: external} for [CVE-2022-31030](https://nvd.nist.gov/vuln/detail/CVE-2022-31030){: external}, and the [security bulletin](https://www.ibm.com/support/pages/node/6598049){: external} for [CVE-2022-29162](https://nvd.nist.gov/vuln/detail/CVE-2022-29162){: external}. |
| Kubernetes | 1.24.1 | 1.24.2 | For more information, see the [change log](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.2){: external}. | 
{: caption="Changes since version 1.24.1_1522" caption-side="bottom"}


### Change log for master fix pack 1.24.1_1523 and worker node fix pack 1.24.1_1522, released 9 June 2022
{: #1241_1522}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.21.5 | v3.23.1 | See the [Calico release notes](https://projectcalico.docs.tigera.io/archive/v3.23/release-notes/){: external}. The **default** BGP configuration found in the `default` [BGPConfiguration](https://projectcalico.docs.tigera.io/reference/resources/bgpconfig){: external} resource has been updated to set `nodeMeshMaxRestartTime` to `30m`.  This default change is only applied if the cluster does not have a custom BGP configuration. The previous default value was `120s`. |
| CoreDNS | 1.8.7 | 1.9.2 | See the [CoreDNS release notes](https://github.com/coredns/coredns/blob/v1.9.2/notes/coredns-1.9.2.md){: external}. |
| etcd | v3.4.18 | v3.5.4 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.4){: external}. |
| GPU device plug-in and installer | 382ada9 | 2b0b6d1 | Updated image for [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/CVE-2018-25032){: external}, [CVE-2021-3634](https://nvd.nist.gov/vuln/detail/CVE-2021-3634){: external}, [CVE-2021-3737](https://nvd.nist.gov/vuln/detail/CVE-2021-3737){: external} and [CVE-2021-4189](https://nvd.nist.gov/vuln/detail/CVE-2021-4189){: external}. |
| {{site.data.keyword.blockstoragefull}} driver and plug-in | None | v2.2.5 | The {{site.data.keyword.blockstoragefull}} driver and plug-in component is now installed on clusters running classic infrastructure. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.23.7-4 | v1.24.1-4 | Updated to support the Kubernetes `1.24.1` release and `Go` version `1.18.2`. [Disabling load balancer NodePort allocation](https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-nodeport-allocation){: external} is not supported for VPC load balancers. |
| Kubernetes | v1.23.7 | v1.24.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.24.1){: external}. |
| Kubernetes configuration | N/A | N/A | Updated the [feature gate configuration](/docs/containers?topic=containers-service-settings#feature-gates). |
| Kubernetes CSI snapshotter CRDs | v4.2.1 | v5.0.1 | See the [Kubernetes container storage interface (CSI) snapshotter release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v5.0.1){: external}. |
| Kubernetes Dashboard | v2.4.0 | v2.5.0 | See the [Kubernetes Dashboard release notes](https://github.com/kubernetes/dashboard/releases/tag/v2.5.0){: external}. |
| Kubernetes DNS autoscaler | 1.8.4 | 1.8.5 | See the [Kubernetes DNS autoscaler release notes](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/releases/tag/1.8.5){: external}. |
| Kubernetes Metrics Server | v0.6.0 | v0.6.0 | Updated to run with a highly available configuration. For more information on this configuration, see the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.6.0){: external}. |
| Kubernetes NodeLocal DNS cache | 1.21.4 | 1.22.2 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.22.2){: external}. |
| Pause container image | 3.6 | 3.7 | See the [pause container image release notes](https://github.com/kubernetes/kubernetes/blob/master/build/pause/CHANGELOG.md){: external}. | 
{: caption="Changes since version 1.23.7_1531 (master) and 1.23.7_1532 (worker node)" caption-side="bottom"}


