---

copyright:
  years: 2026, 2026

lastupdated: "2026-11-03"


keywords: change log, version history, 1.37

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# 1.37 version change log
{: #changelog_137}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run this version. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview_137}

In Kubernetes, most new beta features are disabled by default. Alpha features, which are subject to change, are disabled in all versions. For more information, see the [Default service settings for Kubernetes components](/docs/containers?topic=containers-service-settings) and the [feature gates](/docs/containers?topic=containers-service-settings#feature-gates) for each version.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security){: external} for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#worker-update-cli) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cluster-master-update-cli). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}



## Version 1.37
{: #137_components}


## 03 November 2026, Master fix pack 1.37.1_1517
{: #cl-boms_master-1371_1517_M}

The following list shows the components that are in the master fix pack 1.37.1_1517. Master patch updates are applied automatically.
{: shortdesc}

Aqua Security kube-bench v0.16.0
:   See the [Aqua Security kube-bench release notes](https://github.com/aquasecurity/kube-bench/releases/tag/vv0.16.0){: external}.


Calico v3.32.2
:   See the [Calico release notes](https://docs.tigera.io/calico/3.32/release-notes/#calico-open-source-3322-bug-fix-release){: external}.


Cluster health image v1.6.21
:   New version contains updates and security fixes.


CoreDNS v1.14.7
:   See the [CoreDNS release notes](https://coredns.io/tags/notes/){: external}.


etcd v3.6.15
:   See the [etcd release notes](https://github.com/coreos/etcd/releases/v3.6.15){: external}.


IBM Cloud Block Storage driver and plug-in v2.5.29
:   New version contains updates and security fixes.


IBM Cloud Controller Manager v1.37.1-2
:   New version contains updates and security fixes.


IBM Cloud File Storage for Classic plug-in and monitor v458
:   New version contains updates and security fixes.


IBM Cloud RBAC Operator 109756b
:   New version contains updates and security fixes.


Key Management Service provider 2.10.31
:   New version contains updates and security fixes.


Kubernetes v1.37.1
:   See the [Kubernetes release notes](https://github.com/kubernetes/kubernetes/releases/tag/v1.37.1){: external}.


Kubernetes add-on resizer 1.8.24
:   See the [Kubernetes add-on resizer release notes](https://github.com/kubernetes/autoscaler/releases/tag/addon-resizer-1.8.24){: external}.


Kubernetes Metrics Server v0.9.0
:   See the [Kubernetes Metrics Server release notes](https://github.com/kubernetes-incubator/metrics-server/releases/tag/v0.9.0){: external}.


Kubernetes snapshot controller v8.6.0
:   See the [Kubernetes snapshot controller release notes](https://github.com/kubernetes-csi/external-snapshotter/releases/tag/v8.6.0){: external}.


Portieris admission controller v0.15.1
:   See the [Portieris admission controller release notes](https://github.com/IBM/portieris/releases/tag/v0.15.1){: external}


Tigera Operator v1.42.6
:   See the [Tigera Operator release notes](https://github.com/tigera/operator/releases/tag/v1.42.6){: external}.


## 02 November 2026, Worker node fix pack 1.37.1_1521
{: #cl-boms-1371_1521_W}

The following list shows the components included in the worker node fix pack 1.37.1_1521. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

UBUNTU 24 (VPC) 6.8.0-147-generic
:   Resolves the following CVEs: [CVE-2026-111497](https://nvd.nist.gov/vuln/detail/cve-2026-111497){: external}.


UBUNTU 24 (Classic) 6.8.0-147-generic
:   Resolves the following CVEs: [CVE-2026-111497](https://nvd.nist.gov/vuln/detail/cve-2026-111497){: external}.


Kubernetes 1.37.1
:   For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.37.1){: external}.


containerd 2.2.10
:   For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.2.10){: external}.


HAProxy e4345026edf8a112257b2c50ed3c8d373c87f59f
:   Resolves the following CVEs: [CVE-2026-80489](https://nvd.nist.gov/vuln/detail/cve-2026-80489){: external}, [CVE-2026-89158](https://nvd.nist.gov/vuln/detail/cve-2026-89158){: external}, [CVE-2026-77117](https://nvd.nist.gov/vuln/detail/cve-2026-77117){: external}, [CVE-2026-19542](https://nvd.nist.gov/vuln/detail/cve-2026-19542){: external}, [CVE-2026-86142](https://nvd.nist.gov/vuln/detail/cve-2026-86142){: external}, [CVE-2026-6368](https://nvd.nist.gov/vuln/detail/cve-2026-6368){: external}, [CVE-2026-89157](https://nvd.nist.gov/vuln/detail/cve-2026-89157){: external}, [CVE-2026-18374](https://nvd.nist.gov/vuln/detail/cve-2026-18374){: external}, [CVE-2026-6791](https://nvd.nist.gov/vuln/detail/cve-2026-6791){: external}, [CVE-2026-86145](https://nvd.nist.gov/vuln/detail/cve-2026-86145){: external}, and [CVE-2026-103111](https://nvd.nist.gov/vuln/detail/cve-2026-103111){: external}.


GPU Device Plug-in and Installer d2def2bba2034981c2a949fc5919ff4c35b191e1
:   Resolves the following CVEs: [CVE-2026-12345](https://nvd.nist.gov/vuln/detail/cve-2026-12345){: external}, [CVE-2026-6791](https://nvd.nist.gov/vuln/detail/cve-2026-6791){: external}, [CVE-2026-19542](https://nvd.nist.gov/vuln/detail/cve-2026-19542){: external}, [CVE-2026-77117](https://nvd.nist.gov/vuln/detail/cve-2026-77117){: external}, [CVE-2026-63072](https://nvd.nist.gov/vuln/detail/cve-2026-63072){: external}, [CVE-2026-18374](https://nvd.nist.gov/vuln/detail/cve-2026-18374){: external}, [CVE-2026-80489](https://nvd.nist.gov/vuln/detail/cve-2026-80489){: external}, [CVE-2026-6368](https://nvd.nist.gov/vuln/detail/cve-2026-6368){: external}, [CVE-2026-84782](https://nvd.nist.gov/vuln/detail/cve-2026-84782){: external}, [CVE-2026-19445](https://nvd.nist.gov/vuln/detail/cve-2026-19445){: external}, [CVE-2026-114406](https://nvd.nist.gov/vuln/detail/cve-2026-114406){: external}, and [CVE-2026-19553](https://nvd.nist.gov/vuln/detail/cve-2026-19553){: external}.


## 27 October 2026, Worker node fix pack 1.37.1_1520
{: #cl-boms-1371_1520_W}

The following list shows the components included in the worker node fix pack 1.37.1_1520. Worker node patch updates can be applied by updating, reloading (in classic infrastructure), or replacing (in VPC infrastructure) the worker node.
{: shortdesc}

UBUNTU 24 (VPC) 6.8.0-147-generic
:   Resolves the following CVEs: [USN-8944-1](https://ubuntu.com/security/notices/USN-8944-1){: external}, [USN-8947-1](https://ubuntu.com/security/notices/USN-8947-1){: external}, [CVE-2026-11386](https://nvd.nist.gov/vuln/detail/cve-2026-11386){: external}, [CVE-2026-12391](https://nvd.nist.gov/vuln/detail/cve-2026-12391){: external}, [CVE-2026-85091](https://nvd.nist.gov/vuln/detail/cve-2026-85091){: external}, and [CVE-2026-9494](https://nvd.nist.gov/vuln/detail/cve-2026-9494){: external}.


UBUNTU 24 (Classic) 6.8.0-146-generic
:   Resolves the following CVEs: [USN-8944-1](https://ubuntu.com/security/notices/USN-8944-1){: external}, [USN-8947-1](https://ubuntu.com/security/notices/USN-8947-1){: external}, [CVE-2026-11386](https://nvd.nist.gov/vuln/detail/cve-2026-11386){: external}, [CVE-2026-12391](https://nvd.nist.gov/vuln/detail/cve-2026-12391){: external}, [CVE-2026-85091](https://nvd.nist.gov/vuln/detail/cve-2026-85091){: external}, and [CVE-2026-9494](https://nvd.nist.gov/vuln/detail/cve-2026-9494){: external}.


Kubernetes 1.37.1
:   For more information, see the [change logs](https://github.com/kubernetes/kubernetes/releases/tag/v1.37.1){: external}.


containerd 2.2.10
:   For more information, see the [change logs](https://github.com/containerd/containerd/releases/tag/v2.2.10){: external}.


HAProxy a0d552a2759d3396f874ee765dc912055898f8bb
:   New version contains updates and security fixes.


GPU Device Plug-in and Installer 233d8fb3566b2f7a387eedffd104ad0389757cfb
:   New version contains updates and security fixes.
