---

copyright:
 years: 2014, 2023
lastupdated: "2023-02-01"

keywords: kubernetes, versions, update, upgrade, BOM, bill of materials, versions, patch

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Kubernetes version change logs
{: #changelog}

View information of version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} Kubernetes clusters. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version change logs
{: #change-logs-by-version}

Review the change logs in the following list. 

Supported Kubernetes versions
:   [1.26 change log](/docs/containers?topic=containers-changelog_126)
:   [1.25 change log](/docs/containers?topic=containers-changelog_125)
:   [1.24 change log](/docs/containers?topic=containers-changelog_124)

Deprecated Kubernetes versions
:   [1.23 change log](/docs/containers?topic=containers-changelog_123)
:   [1.22 change log](/docs/containers?topic=containers-changelog_122)

Unsupported Kubernetes versions 
:   [Archived change logs](/docs/containers?topic=containers-cs_versions#k8s_version_archive)

