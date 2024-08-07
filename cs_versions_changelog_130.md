---

copyright: 
  years: 2024, 2024
lastupdated: "2024-08-01"


keywords: kubernetes, containers, change log, 130 change log, 130 updates

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}

# Kubernetes version 1.30 change log
{: #changelog_130}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.30. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_130}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.30 change log
{: #130_changelog}

### Change log for master fix pack 1.30.3_1531, released 31 July 2024
{: #1303_1531_M}

The following table shows the changes that are in the master fix pack 1.30.3_1531. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Calico | v3.27.2 | v3.27.4 | See the [Calico release notes](https://docs.tigera.io/calico/3.27/release-notes/#v3.27.4){: external}. |
| Cluster health image | v1.5.6 | v1.5.7 | New version contains updates and security fixes. |
| etcd | v3.5.13 | v3.5.14 | See the [etcd release notes](https://github.com/etcd-io/etcd/releases/v3.5.14){: external}. |
| {{site.data.keyword.cloud_notm}} Block Storage driver and plug-in | v2.5.9 | v2.5.12 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.30.1-7 | v1.30.3-1 | New version contains updates and security fixes. |
| {{site.data.keyword.filestorage_full_notm}} for Classic plug-in and monitor | 443 | 445 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 14d0ab5 | 312030f | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.2 | v2.10.3 | New version contains updates and security fixes. |
| Kubernetes | v1.30.2 | v1.30.3 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.30.3){: external}. |
| Load balancer and load balancer monitor for {{site.data.keyword.cloud_notm}} Provider | 2933 | 2967 | New version contains updates and security fixes. |
| Portieris admission controller | v0.13.16 | v0.13.17 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.17){: external}. |
| Tigera Operator | v1.32.5-91-iks | v1.32.10-109-iks | See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.32.10){: external}. |
{: caption="Changes since version 1.30.2_1525" caption-side="bottom"}


### Change log for worker node fix pack 1.30.3_1532, released 29 July 2024
{: #1303_1532_W}

The following table shows the changes that are in the worker node fix pack 1.30.3_1532. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-189-generic | 5.4.0-190-generic | Worker node kernel & package updates for [CVE-2022-48655](https://nvd.nist.gov/vuln/detail/CVE-2022-48655){: external}, [CVE-2024-0760](https://nvd.nist.gov/vuln/detail/CVE-2024-0760){: external}, [CVE-2024-1737](https://nvd.nist.gov/vuln/detail/CVE-2024-1737){: external}, [CVE-2024-1975](https://nvd.nist.gov/vuln/detail/CVE-2024-1975){: external}, [CVE-2024-26583](https://nvd.nist.gov/vuln/detail/CVE-2024-26583){: external}, [CVE-2024-26584](https://nvd.nist.gov/vuln/detail/CVE-2024-26584){: external}, [CVE-2024-26585](https://nvd.nist.gov/vuln/detail/CVE-2024-26585){: external}, [CVE-2024-26907](https://nvd.nist.gov/vuln/detail/CVE-2024-26907){: external}, [CVE-2024-36016](https://nvd.nist.gov/vuln/detail/CVE-2024-36016){: external}, [CVE-2024-4076](https://nvd.nist.gov/vuln/detail/CVE-2024-4076){: external}, [CVE-2024-5569](https://nvd.nist.gov/vuln/detail/CVE-2024-5569){: external}. |
| Ubuntu 24.04 packages | 6.8.0-38-generic | 6.8.0-39-generic | Worker node kernel & package updates for [CVE-2024-0760](https://nvd.nist.gov/vuln/detail/CVE-2024-0760){: external}, [CVE-2024-1737](https://nvd.nist.gov/vuln/detail/CVE-2024-1737){: external}, [CVE-2024-1975](https://nvd.nist.gov/vuln/detail/CVE-2024-1975){: external}, [CVE-2024-25742](https://nvd.nist.gov/vuln/detail/CVE-2024-25742){: external}, [CVE-2024-35984](https://nvd.nist.gov/vuln/detail/CVE-2024-35984){: external}, [CVE-2024-35990](https://nvd.nist.gov/vuln/detail/CVE-2024-35990){: external}, [CVE-2024-35992](https://nvd.nist.gov/vuln/detail/CVE-2024-35992){: external}, [CVE-2024-35997](https://nvd.nist.gov/vuln/detail/CVE-2024-35997){: external}, [CVE-2024-36008](https://nvd.nist.gov/vuln/detail/CVE-2024-36008){: external}, [CVE-2024-36016](https://nvd.nist.gov/vuln/detail/CVE-2024-36016){: external}, [CVE-2024-4076](https://nvd.nist.gov/vuln/detail/CVE-2024-4076){: external}. |
| Containerd | 1.7.19 | 1.7.20 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.20){: external}. |
| Kubernetes | 1.30.2 | 1.30.3 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.30.3){: external}. |
| GPU device plug-in and installer | 184b5e2 | 47ed2ef | Security fixes for [CVE-2024-4032](https://nvd.nist.gov/vuln/detail/CVE-2024-4032){: external}. |
| Haproxy | N/A | N/A | N/A |
{: caption="Changes since version 1.30.2_1528" caption-side="bottom"}


### Change log for worker node fix pack 1.30.2_1528, released 15 July 2024
{: #1302_1528_W}

The following table shows the changes that are in the worker node fix pack 1.30.2_1528. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-187-generic | 5.4.0-189-generic | Worker node kernel & package updates for [CVE-2023-6270](https://nvd.nist.gov/vuln/detail/CVE-2023-6270){: external}, [CVE-2023-6597](https://nvd.nist.gov/vuln/detail/CVE-2023-6597){: external}, [CVE-2024-0450](https://nvd.nist.gov/vuln/detail/CVE-2024-0450){: external}, [CVE-2024-2201](https://nvd.nist.gov/vuln/detail/CVE-2024-2201){: external}, [CVE-2024-23307](https://nvd.nist.gov/vuln/detail/CVE-2024-23307){: external}, [CVE-2024-24861](https://nvd.nist.gov/vuln/detail/CVE-2024-24861){: external}, [CVE-2024-26586](https://nvd.nist.gov/vuln/detail/CVE-2024-26586){: external}, [CVE-2024-26642](https://nvd.nist.gov/vuln/detail/CVE-2024-26642){: external}, [CVE-2024-26643](https://nvd.nist.gov/vuln/detail/CVE-2024-26643){: external}, [CVE-2024-26828](https://nvd.nist.gov/vuln/detail/CVE-2024-26828){: external}, [CVE-2024-26889](https://nvd.nist.gov/vuln/detail/CVE-2024-26889){: external}, [CVE-2024-26922](https://nvd.nist.gov/vuln/detail/CVE-2024-26922){: external}, [CVE-2024-26923](https://nvd.nist.gov/vuln/detail/CVE-2024-26923){: external}, [CVE-2024-26925](https://nvd.nist.gov/vuln/detail/CVE-2024-26925){: external}, [CVE-2024-26926](https://nvd.nist.gov/vuln/detail/CVE-2024-26926){: external}. |
| Ubuntu 24.04 packages | 6.8.0-36-generic | 6.8.0-38-generic| Worker node kernel & package updates for [CVE-2024-26922](https://nvd.nist.gov/vuln/detail/CVE-2024-26922){: external}, [CVE-2024-26924](https://nvd.nist.gov/vuln/detail/CVE-2024-26924){: external}, [CVE-2024-26926](https://nvd.nist.gov/vuln/detail/CVE-2024-26926){: external}, [CVE-2024-39894](https://nvd.nist.gov/vuln/detail/CVE-2024-39894){: external}. |
| Containerd | 1.7.18 | 1.7.19 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.19){: external}. |
| HAProxy | e77d4ca | c91c765 | Security fixes for [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external},[CVE-2024-25062](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external}. |
| GPU device plug-in and installer | fbdf629 | 184b5e23 | Security fixes for [CVE-2023-45288](https://nvd.nist.gov/vuln/detail/CVE-2023-45288){: external},[CVE-2021-47069](https://nvd.nist.gov/vuln/detail/CVE-2021-47069){: external},[CVE-2024-26801](https://nvd.nist.gov/vuln/detail/CVE-2024-26801){: external},[CVE-2024-35854](https://nvd.nist.gov/vuln/detail/CVE-2024-35854){: external},[CVE-2024-35960](https://nvd.nist.gov/vuln/detail/CVE-2024-35960){: external},[CVE-2023-2953](https://nvd.nist.gov/vuln/detail/CVE-2023-2953){: external},[CVE-2024-26584](https://nvd.nist.gov/vuln/detail/CVE-2024-26584){: external},[CVE-2024-26759](https://nvd.nist.gov/vuln/detail/CVE-2024-26759){: external},[CVE-2024-35890](https://nvd.nist.gov/vuln/detail/CVE-2024-35890){: external},[CVE-2024-26982](https://nvd.nist.gov/vuln/detail/CVE-2024-26982){: external},[CVE-2024-35835](https://nvd.nist.gov/vuln/detail/CVE-2024-35835){: external},[CVE-2021-46972](https://nvd.nist.gov/vuln/detail/CVE-2021-46972){: external},[CVE-2021-47353](https://nvd.nist.gov/vuln/detail/CVE-2021-47353){: external},[CVE-2021-47356](https://nvd.nist.gov/vuln/detail/CVE-2021-47356){: external},[CVE-2024-26675](https://nvd.nist.gov/vuln/detail/CVE-2024-26675){: external},[CVE-2021-47236](https://nvd.nist.gov/vuln/detail/CVE-2021-47236){: external},[CVE-2023-52781](https://nvd.nist.gov/vuln/detail/CVE-2023-52781){: external},[CVE-2024-26656](https://nvd.nist.gov/vuln/detail/CVE-2024-26656){: external},[CVE-2021-47311](https://nvd.nist.gov/vuln/detail/CVE-2021-47311){: external},[CVE-2023-52675](https://nvd.nist.gov/vuln/detail/CVE-2023-52675){: external},[CVE-2024-35789](https://nvd.nist.gov/vuln/detail/CVE-2024-35789){: external},[CVE-2024-35958](https://nvd.nist.gov/vuln/detail/CVE-2024-35958){: external},[CVE-2021-47456](https://nvd.nist.gov/vuln/detail/CVE-2021-47456){: external},[CVE-2024-26583](https://nvd.nist.gov/vuln/detail/CVE-2024-26583){: external},[CVE-2024-26974](https://nvd.nist.gov/vuln/detail/CVE-2024-26974){: external},[CVE-2024-36004](https://nvd.nist.gov/vuln/detail/CVE-2024-36004){: external},[CVE-2021-47073](https://nvd.nist.gov/vuln/detail/CVE-2021-47073){: external},[CVE-2023-52464](https://nvd.nist.gov/vuln/detail/CVE-2023-52464){: external},[CVE-2023-52667](https://nvd.nist.gov/vuln/detail/CVE-2023-52667){: external},[CVE-2024-35838](https://nvd.nist.gov/vuln/detail/CVE-2024-35838){: external},[CVE-2024-26906](https://nvd.nist.gov/vuln/detail/CVE-2024-26906){: external},[CVE-2024-27410](https://nvd.nist.gov/vuln/detail/CVE-2024-27410){: external},[CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external},[CVE-2023-52560](https://nvd.nist.gov/vuln/detail/CVE-2023-52560){: external},[CVE-2023-52615](https://nvd.nist.gov/vuln/detail/CVE-2023-52615){: external},[CVE-2023-52686](https://nvd.nist.gov/vuln/detail/CVE-2023-52686){: external},[CVE-2023-52700](https://nvd.nist.gov/vuln/detail/CVE-2023-52700){: external},[CVE-2023-52669](https://nvd.nist.gov/vuln/detail/CVE-2023-52669){: external},[CVE-2024-26804](https://nvd.nist.gov/vuln/detail/CVE-2024-26804){: external},[CVE-2024-26859](https://nvd.nist.gov/vuln/detail/CVE-2024-26859){: external},[CVE-2024-35853](https://nvd.nist.gov/vuln/detail/CVE-2024-35853){: external},[CVE-2024-35852](https://nvd.nist.gov/vuln/detail/CVE-2024-35852){: external},[CVE-2023-52813](https://nvd.nist.gov/vuln/detail/CVE-2023-52813){: external},[CVE-2023-52881](https://nvd.nist.gov/vuln/detail/CVE-2023-52881){: external},[CVE-2024-26735](https://nvd.nist.gov/vuln/detail/CVE-2024-26735){: external},[CVE-2024-26826](https://nvd.nist.gov/vuln/detail/CVE-2024-26826){: external},[CVE-2023-52703](https://nvd.nist.gov/vuln/detail/CVE-2023-52703){: external},[CVE-2024-26907](https://nvd.nist.gov/vuln/detail/CVE-2024-26907){: external},[CVE-2021-46909](https://nvd.nist.gov/vuln/detail/CVE-2021-46909){: external},[CVE-2023-52877](https://nvd.nist.gov/vuln/detail/CVE-2023-52877){: external},[CVE-2024-27397](https://nvd.nist.gov/vuln/detail/CVE-2024-27397){: external},[CVE-2024-3651](https://nvd.nist.gov/vuln/detail/CVE-2024-3651){: external},[CVE-2021-47495](https://nvd.nist.gov/vuln/detail/CVE-2021-47495){: external},[CVE-2023-52626](https://nvd.nist.gov/vuln/detail/CVE-2023-52626){: external},[CVE-2024-35959](https://nvd.nist.gov/vuln/detail/CVE-2024-35959){: external},[CVE-2024-36007](https://nvd.nist.gov/vuln/detail/CVE-2024-36007){: external},[CVE-2024-35845](https://nvd.nist.gov/vuln/detail/CVE-2024-35845){: external},[CVE-2024-35855](https://nvd.nist.gov/vuln/detail/CVE-2024-35855){: external},[CVE-2024-35888](https://nvd.nist.gov/vuln/detail/CVE-2024-35888){: external},[CVE-2021-47310](https://nvd.nist.gov/vuln/detail/CVE-2021-47310){: external},[CVE-2023-52835](https://nvd.nist.gov/vuln/detail/CVE-2023-52835){: external},[CVE-2023-52878](https://nvd.nist.gov/vuln/detail/CVE-2023-52878){: external},[CVE-2024-26585](https://nvd.nist.gov/vuln/detail/CVE-2024-26585){: external},[CVE-2020-26555](https://nvd.nist.gov/vuln/detail/CVE-2020-26555){: external},[CVE-2023-5090](https://nvd.nist.gov/vuln/detail/CVE-2023-5090){: external}. |
{: caption="Changes since version 1.30.2_1527" caption-side="bottom"}


### Change log for worker node fix pack 1.30.2_1527, released 09 July 2024
{: #1302_1527_W}

The following table shows the changes that are in the worker node fix pack 1.30.2_1527. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-186-generic | 5.4.0-187-generic | Worker node kernel & package updates for [CVE-2022-4968](https://nvd.nist.gov/vuln/detail/CVE-2022-4968){: external}, [CVE-2024-2201](https://nvd.nist.gov/vuln/detail/CVE-2024-2201){: external}, [CVE-2024-26643](https://nvd.nist.gov/vuln/detail/CVE-2024-26643){: external}, [CVE-2024-26925](https://nvd.nist.gov/vuln/detail/CVE-2024-26925){: external}, [CVE-2024-32002](https://nvd.nist.gov/vuln/detail/CVE-2024-32002){: external}, [CVE-2024-38428](https://nvd.nist.gov/vuln/detail/CVE-2024-38428){: external}. |
| Ubuntu 24.04 packages | 6.8.0-35-generic | 6.8.0-36-generic | Worker node kernel & package updates for [CVE-2022-4968](https://nvd.nist.gov/vuln/detail/CVE-2022-4968){: external}, [CVE-2024-26924](https://nvd.nist.gov/vuln/detail/CVE-2024-26924){: external}, [CVE-2024-38428](https://nvd.nist.gov/vuln/detail/CVE-2024-38428){: external}, [CVE-2024-6387](https://nvd.nist.gov/vuln/detail/CVE-2024-6387){: external}. |
| HAProxy | 18889dd | e77d4ca | New version contains security fixes |
| GPU device plug-in and installer | 8ef78ef | fbdf629 | New version contains updates and security fixes. |
{: caption="Changes since version 1.30.2_1526" caption-side="bottom"}


### Change log for master fix pack 1.30.2_1525, released 19 June 2024
{: #1302_1525_M}

The following table shows the changes that are in the master fix pack 1.30.2_1525. Master patch updates are applied automatically. 



| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Cluster health image | v1.4.10 | v1.5.6 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Controller Manager | v1.30.1-2 | v1.30.1-7 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} Metrics Server Config Watcher | v1.1.3 | v1.1.4 | New version contains updates and security fixes. |
| {{site.data.keyword.cloud_notm}} RBAC Operator | 4c5d156 | 14d0ab5 | New version contains updates and security fixes. |
| Key Management Service provider | v2.10.1 | v2.10.2 | New version contains updates and security fixes. |
| Kubernetes | v1.30.1 | v1.30.2 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.30.2){: external}. |
| Kubernetes feature gates configuration | CustomCPUCFSQuotaPeriod=true,UnauthenticatedHTTP2DOSMitigation=true | CustomCPUCFSQuotaPeriod=true,UnauthenticatedHTTP2DOSMitigation=true,StrictCostEnforcementForVAP=true,StrictCostEnforcementForWebhooks=true | https://github.com/kubernetes/kubernetes/issues/124542 |
| Kubernetes NodeLocal DNS cache | 1.23.0 | 1.23.1 | See the [Kubernetes NodeLocal DNS cache release notes](https://github.com/kubernetes/dns/releases/tag/1.23.1){: external}. |
| Portieris admission controller | v0.13.15 | v0.13.16 | See the [Portieris admission controller release notes](https://github.com/{{site.data.keyword.IBM_notm}}/portieris/releases/tag/v0.13.16){: external}. |
{: caption="Changes since version 1.30.1_1520" caption-side="bottom"}


### Change log for worker node fix pack 1.30.2_1526, released 18 June 2024
{: #1302_1526_W}

The following table shows the changes that are in the worker node fix pack 1.30.2_1526. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-182-generic | 5.4.0-186-generic | Worker node kernel and package updates [CVE-2021-47063](https://nvd.nist.gov/vuln/detail/CVE-2021-47063){: external}, [CVE-2021-47070](https://nvd.nist.gov/vuln/detail/CVE-2021-47070){: external}, [CVE-2023-47233](https://nvd.nist.gov/vuln/detail/CVE-2023-47233){: external}, [CVE-2023-52530](https://nvd.nist.gov/vuln/detail/CVE-2023-52530){: external}, [CVE-2024-26614](https://nvd.nist.gov/vuln/detail/CVE-2024-26614){: external}, [CVE-2024-26622](https://nvd.nist.gov/vuln/detail/CVE-2024-26622){: external}, [CVE-2024-26712](https://nvd.nist.gov/vuln/detail/CVE-2024-26712){: external}, [CVE-2024-26733](https://nvd.nist.gov/vuln/detail/CVE-2024-26733){: external}, CIS benchmark compliance: [1.5.4](https://workbench.cisecurity.org/sections/1985936/recommendations/3181745){: external}, [1.5.5](https://workbench.cisecurity.org/sections/1985936/recommendations/3181749){: external}, [4.5.5](https://workbench.cisecurity.org/sections/1985957/recommendations/3181909){: external}, [3.3.4](https://workbench.cisecurity.org/sections/1985946/recommendations/3181810){: external}, [3.3.9](https://workbench.cisecurity.org/sections/1985946/recommendations/3181824){: external}, [1.1.1.2](https://workbench.cisecurity.org/sections/1985904/recommendations/3181628){: external}, [1.1.1.3](https://workbench.cisecurity.org/sections/1985904/recommendations/3181629){: external}, [1.1.1.4](https://workbench.cisecurity.org/sections/1985904/recommendations/3181631){: external}, [1.1.1.5](https://workbench.cisecurity.org/sections/1985904/recommendations/3181633){: external}. |
| Ubuntu 24.04 packages | N/A | 6.8.0-35-generic | N/A |
| Kubernetes | 1.30.1 | 1.30.2 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md){: external}. |
| Containerd | 1.7.17 | 1.7.18 | For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v1.7.18){: external}. |
| HAProxy | 0062a3c | 18889dd | Security fixes for [CVE-2024-25062](https://nvd.nist.gov/vuln/detail/CVE-2024-25062){: external}. |
| GPU device plug-in and installer | fdf201e | 8ef78ef | Security fixes for [CVE-2019-25162](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2019-25162){: external}, [CVE-2020-36777](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2020-36777){: external}, [CVE-2021-46934](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-46934){: external}, [CVE-2021-47013](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47013){: external}, [CVE-2021-47055](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47055){: external}, [CVE-2021-47118](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47118){: external}, [CVE-2021-47153](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47153){: external}, [CVE-2021-47171](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47171){: external}, [CVE-2021-47185](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2021-47185){: external}, [CVE-2022-48627](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-48627){: external}, [CVE-2022-48669](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2022-48669){: external}, [CVE-2023-52439](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52439){: external}, [CVE-2023-52445](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52445){: external}, [CVE-2023-52477](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52477){: external}, [CVE-2023-52513](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52513){: external}, [CVE-2023-52520](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52520){: external}, [CVE-2023-52528](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52528){: external}, [CVE-2023-52565](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52565){: external}, [CVE-2023-52578](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52578){: external}, [CVE-2023-52594](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52594){: external}, [CVE-2023-52595](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52595){: external}, [CVE-2023-52598](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52598){: external}, [CVE-2023-52606](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52606){: external}, [CVE-2023-52607](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52607){: external}, [CVE-2023-52610](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-52610){: external}, [CVE-2023-6240](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2023-6240){: external}, [CVE-2024-0340](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-0340){: external}, [CVE-2024-23307](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-23307){: external}, [CVE-2024-25744](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-25744){: external}, [CVE-2024-26593](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26593){: external}, [CVE-2024-26603](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26603){: external}, [CVE-2024-26610](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26610){: external}, [CVE-2024-26615](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26615){: external}, [CVE-2024-26642](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26642){: external}, [CVE-2024-26643](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26643){: external}, [CVE-2024-26659](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26659){: external}, [CVE-2024-26664](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26664){: external}, [CVE-2024-26693](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26693){: external}, [CVE-2024-26694](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26694){: external}, [CVE-2024-26743](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26743){: external}, [CVE-2024-26744](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26744){: external}, [CVE-2024-26779](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26779){: external}, [CVE-2024-26872](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26872){: external}, [CVE-2024-26892](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26892){: external}, [CVE-2024-26897](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26897){: external}, [CVE-2024-26901](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26901){: external}, [CVE-2024-26919](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26919){: external}, [CVE-2024-26933](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26933){: external}, [CVE-2024-26934](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26934){: external}, [CVE-2024-26964](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26964){: external}, [CVE-2024-26973](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26973){: external}, [CVE-2024-26993](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-26993){: external}, [CVE-2024-27014](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27014){: external}, [CVE-2024-27048](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27048){: external}, [CVE-2024-27052](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27052){: external}, [CVE-2024-27056](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27056){: external}, [CVE-2024-27059](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-27059){: external}, [CVE-2024-25062](https://exchange.xforce.ibmcloud.com/vulnerabilities/CVE-2024-25062){: external}. |
{: caption="Changes since version 1.30.1_1521" caption-side="bottom"}


### Change log for worker node fix pack 1.30.1_1521, released 03 June 2024
{: #1301_1521_W}

The following table shows the changes that are in the worker node fix pack 1.30.1_1521. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| Ubuntu 20.04 packages | 5.4.0-182-generic | 5.4.0-182-generic | Worker node package updates [CVE-2023-22745](https://nvd.nist.gov/vuln/detail/CVE-2023-22745){: external}, [CVE-2024-32004](https://nvd.nist.gov/vuln/detail/CVE-2024-32004){: external}, [CVE-2024-32020](https://nvd.nist.gov/vuln/detail/CVE-2024-32020){: external}, [CVE-2024-32021](https://nvd.nist.gov/vuln/detail/CVE-2024-32021){: external}, [CVE-2024-32465](https://nvd.nist.gov/vuln/detail/CVE-2024-32465){: external}, [CVE-2024-33599](https://nvd.nist.gov/vuln/detail/CVE-2024-33599){: external}, [CVE-2024-33600](https://nvd.nist.gov/vuln/detail/CVE-2024-33600){: external}, [CVE-2024-33601](https://nvd.nist.gov/vuln/detail/CVE-2024-33601){: external}, [CVE-2024-33602](https://nvd.nist.gov/vuln/detail/CVE-2024-33602){: external}, [CVE-2024-34064](https://nvd.nist.gov/vuln/detail/CVE-2024-34064){: external}, [CVE-2024-3651](https://nvd.nist.gov/vuln/detail/CVE-2024-3651){: external}. |
| Kubernetes | 1.30.0 | 1.30.1 | For more information, see the [change logs](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md){: external}. |
| Containerd | 1.7.17 | 1.7.17 | N/A |
| HAProxy | e88695e | 0062a3c | Security fixes for [CVE-2024-0450](https://nvd.nist.gov/vuln/detail/CVE-2024-0450){: external}, [CVE-2024-33599](https://nvd.nist.gov/vuln/detail/CVE-2024-33599){: external}, [CVE-2024-26461](https://nvd.nist.gov/vuln/detail/CVE-2024-26461){: external}, [CVE-2021-43618](https://nvd.nist.gov/vuln/detail/CVE-2021-43618){: external}, [CVE-2024-22365](https://nvd.nist.gov/vuln/detail/CVE-2024-22365){: external}, [CVE-2023-6597](https://nvd.nist.gov/vuln/detail/CVE-2023-6597){: external}, [CVE-2024-26458](https://nvd.nist.gov/vuln/detail/CVE-2024-26458){: external}, [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}, [CVE-2024-33601](https://nvd.nist.gov/vuln/detail/CVE-2024-33601){: external}, [CVE-2024-33602](https://nvd.nist.gov/vuln/detail/CVE-2024-33602){: external}, [CVE-2023-7008](https://nvd.nist.gov/vuln/detail/CVE-2023-7008){: external}, [CVE-2023-6004](https://nvd.nist.gov/vuln/detail/CVE-2023-6004){: external}, [CVE-2023-6918](https://nvd.nist.gov/vuln/detail/CVE-2023-6918){: external}, [CVE-2024-33600](https://nvd.nist.gov/vuln/detail/CVE-2024-33600){: external}. |
| GPU device plug-in and installer | 806184d | fdf201e | Security fixes for [CVE-2024-33602](https://nvd.nist.gov/vuln/detail/CVE-2024-33602){: external}, [CVE-2024-28182](https://nvd.nist.gov/vuln/detail/CVE-2024-28182){: external}, [CVE-2024-2961](https://nvd.nist.gov/vuln/detail/CVE-2024-2961){: external}, [CVE-2024-33599](https://nvd.nist.gov/vuln/detail/CVE-2024-33599){: external}, [CVE-2024-33600](https://nvd.nist.gov/vuln/detail/CVE-2024-33600){: external}, [CVE-2024-33601](https://nvd.nist.gov/vuln/detail/CVE-2024-33601){: external}. |
{: caption="Changes since version 1.30.0_1518" caption-side="bottom"}


### Change log for master fix pack 1.30.1_1520 and worker node fix pack 1.30.0_1518, released 29 May 2024
{: #1301_1520M_and_1300_1518W}

| Component | Previous | Current | Description |
| --- | --- | --- | --- |
| IBM Cloud Controller Manager | v1.29.5-1 | v1.30.1-2 | New version contains updates and security fixes. |
| Key Management Service provider | v2.9.6 | v2.10.1 | New version contains updates and security fixes. In addition, only [KMS v2](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) is supported. KMS v1 instances were migrated to KMS v2 as part of the IBM Cloud Kubernetes Service version 1.29 release. |
| Konnectivity agent and server | v0.29.2_105_iks | v0.30.2 | See the [Konnectivity release notes](https://github.com/kubernetes-sigs/apiserver-network-proxy/releases/tag/v0.30.2). |
| Kubernetes | v1.29.5 | v1.30.1 | See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.30.1). |
| Kubernetes add-on resizer | 1.8.19 | 1.8.20 | See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.20). |
| Kubernetes configurations | N/A | N/A | See [Default service settings for Kubernetes components](https://cloud.ibm.com/docs/containers?topic=containers-service-settings). |
| Kubernetes Metrics Server | v0.6.4 | v0.7.1 | See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-sigs/metrics-server/releases/tag/v0.7.1). |
| Kubernetes snapshot controller | v6.3.0 | v6.3.3 | See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v6.3.3). |
{: caption="Changes since version 1.29" caption-side="bottom"}


