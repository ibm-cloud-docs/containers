# `Version change log` page template
Use this template when creating a new version information page when a new version is relesed  

Link structure: https://cloud.ibm.com/docs/containers?topic=containers-changelog_1XX
File name: cs_versions_changelog_1XX.md

* Replace the `XX` with the new minor version. 


## IKS Template

---------------------------------------------------------------------------------------------------------------------------------------------------------

# Kubernetes version 1.XX change log
{: #changelog_1XX}

View information about version changes for major, minor, and patch updates that are available for your {{site.data.keyword.containerlong}} clusters that run version 1.XX. Changes include updates to Kubernetes and {{site.data.keyword.cloud_notm}} Provider components.
{: shortdesc}

## Overview
{: #changelog_overview}

Unless otherwise noted in the change logs, the {{site.data.keyword.containerlong_notm}} provider version enables Kubernetes APIs and features that are at beta. Kubernetes alpha features, which are subject to change, are disabled.

For more information about major, minor, and patch versions and preparation actions between minor versions, see [Kubernetes versions](/docs/containers?topic=containers-cs_versions).
{: tip}

Check the [Security Bulletins on {{site.data.keyword.cloud_notm}} Status](https://cloud.ibm.com/status?component=containers-kubernetes&selected=security) for security vulnerabilities that affect {{site.data.keyword.containerlong_notm}}. You can filter the results to view only Kubernetes Cluster security bulletins that are relevant to {{site.data.keyword.containerlong_notm}}. Change log entries that address other security vulnerabilities but don't also refer to an {{site.data.keyword.IBM_notm}} security bulletin are for vulnerabilities that are not known to affect {{site.data.keyword.containerlong_notm}} in normal usage. If you run privileged containers, run commands on the workers, or execute untrusted code, then you might be at risk.

Some change logs are for _worker node fix packs_, and apply only to worker nodes. You must [apply these patches](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) to ensure security compliance for your worker nodes. These worker node fix packs can be at a higher version than the master because some build fix packs are specific to worker nodes. Other change logs are for _master fix packs_, and apply only to the cluster master. Master fix packs might not be automatically applied. You can choose to [apply them manually](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update). For more information about patch types, see [Update types](/docs/containers?topic=containers-cs_versions#update_types).
{: note}

## Version 1.XX change log
{: #1XX_changelog}

Review the version 1.XX change log.
{: shortdesc}