
---

copyright:
  years: 2014, 2022
lastupdated: "2022-03-03"

keywords: kubernetes, versions, update, upgrade

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# Kubernetes version information and update actions  
{: #cs_versions}

Review this page for general information about {{site.data.keyword.containerlong}} versions and updating to newer versions. 
{: shortdesc}

For more information about the Kubernetes project versions, see the [Kubernetes change logs](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG).

## Available {{site.data.keyword.containerlong}} versions
{: #cs_versions_available}

{{site.data.keyword.containerlong_notm}} concurrently supports multiple versions of Kubernetes. When a latest version (`n`) is released, versions up to 2 behind (`n-2`) are supported. Versions more than 2 behind the latest (`n-3`) are first deprecated and then unsupported. For more information, see [Release lifecycle](#release_lifecycle).
{: shortdesc}

To continue receiving important security patch updates, make sure that your clusters always run a supported Kubernetes version. Deprecated clusters might not receive security updates.
{: important}

Review the supported versions of {{site.data.keyword.containerlong_notm}}. In the CLI, you can run `ibmcloud ks versions`.

**Supported Kubernetes versions**:
:    **Latest**: 1.23
     - [Version information and update actions](/docs/containers?topic=containers-cs_versions_123).
     - [Change log](/docs/containers?topic=containers-changelog_123)
   
:    **Default**: 1.22
     - [Version information and update actions](/docs/containers?topic=containers-cs_versions_122).
     - [Change log](/docs/containers?topic=containers-changelog_122)

:    **Other**: 1.21
     - [Version information and update actions](/docs/containers?topic=containers-cs_versions_121).
     - [Change log](/docs/containers?topic=containers-changelog_121)

**Deprecated Kubernetes versions**:
:    1.20
     - [Version information and update actions](/docs/containers?topic=containers-cs_versions_120)
     - [Change log](/docs/containers?topic=containers-changelog_120) 
:    1.19
     - [Version information and update actions](/docs/containers?topic=containers-cs_versions_119)
     - [Change log](/docs/containers?topic=containers-changelog_119)

**Unsupported Kubernetes versions**: 
:    1.5, 1.7, 1.8, 1.9, 1.10, 1.12, 1.13, 1.14, 1.15, 1.16, 1.17, 1.18
     - [Archived change logs](/docs/containers?topic=containers-cs_versions#k8s_version_archive)


To check the server version of a cluster, log in to the cluster and run the following command.
```sh
kubectl version  --short | grep -i server
```
{: pre}

Example output
```sh
Server Version: v1.22.7+IKS
```
{: screen}


## Update types
{: #update_types}

Your Kubernetes cluster has three types of updates: major, minor, and patch. As updates become available, you are notified when you view information about the cluster master or worker nodes, such as with the `ibmcloud ks cluster ls`, `cluster get`, `worker ls`, or `worker get` commands.
{: shortdesc}

|Update type|Examples of version labels|Updated by|Impact
|-----|-----|-----|-----|
|Major|1.x.x|You|Operation changes for clusters, including scripts or deployments.|
|Minor|x.21.x|You|Operation changes for clusters, including scripts or deployments.|
|Patch|x.x.4_1510|IBM and you|Kubernetes patches, as well as other {{site.data.keyword.cloud_notm}} Provider component updates such as security and operating system patches. IBM updates masters automatically, but you apply patches to worker nodes. See more about patches in the following section.|
{: caption="Impacts of Kubernetes updates" caption-side="top"}

Major and minor updates (1.x)
:   First, [update your master node](/docs/containers?topic=containers-update#master) and then [update the worker nodes](/docs/containers?topic=containers-update#worker_node).
    - You can't update a Kubernetes master two or more minor versions ahead (n+2). For example, if your current master is version 1.20 and you want to update to 1.22, you must update to 1.21 first.
    - Worker nodes can't run a Kubernetes major or minor version that is greater than the masters. Additionally, your worker nodes can be only up to two versions behind the master version (`n-2`).
    - If you use a `kubectl` CLI version that does not match at least the `major.minor` version of your clusters, you might experience unexpected results. Make sure to keep your Kubernetes cluster and [CLI versions](/docs/containers?topic=containers-cs_cli_install#kubectl) up-to-date.

Patch updates (x.x.4_1510)
:   Changes across patches are documented in the change log of each version. Master patches are applied automatically, but you initiate worker node patches and updates. Worker nodes can also run patch versions that are greater than the masters. As updates become available, you are notified when you view information about the master and worker nodes in the {{site.data.keyword.cloud_notm}} console or CLI, such as with the following commands: `ibmcloud ks cluster ls`, `cluster get`, `worker ls`, or `worker get`.
:   Patches can be for worker nodes, masters, or both.
    - **Worker node patches**: Check monthly to see whether an update is available, and use the [`ibmcloud ks worker update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_update) command or the [`ibmcloud ks worker reload`](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reload) command to apply these security and operating system patches. During an update or reload, your worker node machine is reimaged, and data is deleted if not [stored outside the worker node](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).
    - **Master patches**: Master patches are applied automatically over the course of several days, so a master patch version might show up as available before it is applied to your master. The update automation also skips clusters that are in an unhealthy state or have operations currently in progress. Occasionally, IBM might disable automatic updates for a specific master fix pack, as noted in the changelog, such as a patch that is only needed if a master is updated from one minor version to another. In any of these cases, you can choose to safely use the [`ibmcloud ks cluster master update`](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_update) command yourself without waiting for the update automation to apply.

## Release history
{: #release-history}
{: help}
{: support}

The following table records {{site.data.keyword.containerlong_notm}} version release history. You can use this information for planning purposes, such as to estimate general times when a certain release might become unsupported. After the Kubernetes community releases a version update, the IBM team begins a process of hardening and testing the release for {{site.data.keyword.containerlong_notm}} environments. Availability and unsupported release dates depend on the results of these tests, community updates, security patches, and technology changes between versions. Plan to keep your cluster master and worker node version up-to-date according to the `n-2` version support policy.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} was first generally available with Kubernetes version 1.5. Projected release or unsupported dates are subject to change. To go to the version update preparation steps, click the version number.

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

|  Version | Supported? | {{site.data.keyword.containerlong_notm}}<br>release date | {{site.data.keyword.containerlong_notm}}<br>unsupported date |
|------|------|----------|----------|
| [1.23](/docs/containers?topic=containers-cs_versions_123) | Yes | 09 Feb 2022 | April 2023 `†` |
| [1.22](/docs/containers?topic=containers-cs_versions_122) | Yes | 29 Sep 2021 | Nov 2022 `†` |
| [1.21](/docs/containers?topic=containers-cs_versions_121) | Yes | 09 Jun 2021 | Aug 2022 `†` |
| [1.20](/docs/containers?topic=containers-cs_versions_120) | Deprecated | 16 Feb 2021 | May 2022 `†` |
| [1.19](/docs/containers?topic=containers-cs_versions_119) | Deprecated | 13 Oct 2020 | 14 Mar 2022 `†` |
{: caption="Release history for {{site.data.keyword.containerlong_notm}}" caption-side="top"}

Earlier versions of {{site.data.keyword.containerlong_notm}} are [unsupported](#k8s_version_archive).

## Release lifecycle
{: #release_lifecycle}

{{site.data.keyword.containerlong_notm}} concurrently supports select versions of community Kubernetes releases. 
{: shortdesc}

Each supported version of {{site.data.keyword.containerlong_notm}} goes through a lifecycle of testing, development, general release, support, deprecation, and becoming unsupported. Review the following diagram to understand how each phase of the community Kubernetes and {{site.data.keyword.cloud_notm}} provider version lifecycles interact across time.

Estimated days and versions are provided for general understanding. Actual availability and release dates are subject to change and depend on various factors, such as community updates, security patches, and technology changes between versions.
{: note}

![Diagram of the lifecycle of community Kubernetes and supported {{site.data.keyword.cloud_notm}} releases across time](images/version_flowchart_kube.svg)

Review the descriptions of each phase of a version's lifecycle. 

1. The Kubernetes community releases the new version. IBM engineers begin a process of testing and hardening the community version in preparation to release a supported {{site.data.keyword.containerlong_notm}} version.
2. The version is released as the latest supported {{site.data.keyword.containerlong_notm}} version.
3. The version becomes the default supported {{site.data.keyword.containerlong_notm}} version.
4. The version  becomes the oldest supported {{site.data.keyword.containerlong_notm}} version.
5. The version  is deprecated, and security patch updates might not be provided. Depending on the community release cycle and version testing, you have approximately 45 days or less until the next phase of deprecation starts in step 6. During the deprecation period, your cluster is still functional, but might require updating to a supported release to fix security vulnerabilities. For example, you can add and reload worker nodes.
6. You receive a notification in the console and CLI that you have approximately 45 days to update your cluster to a supported version before its current version becomes unsupported. Similar to step 5, your cluster is still functional, but might require that you update to a supported release to fix security vulnerabilities.
7. The version is unsupported. Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes, or update the cluster to the next version. Review the potential impacts and immediately [update the cluster](/docs/containers?topic=containers-update#update) to continue receiving important security updates and support.
8. The cluster master runs two or more versions behind the oldest supported version. You can't update the cluster. Delete the cluster, and create a new one.

If you wait until your cluster is two or more minor versions behind the oldest supported version, you can't update the cluster. Instead, [create a new cluster](/docs/containers?topic=containers-clusters#clusters), [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster, and [delete](/docs/containers?topic=containers-remove) the unsupported cluster. To avoid this issue, update deprecated clusters to a supported version that is one or two behind the current version, such as 1.21 or 1.22 and then update to the latest version, 1.23. If the worker nodes run a version two or more behind the master, you might see your pods fail by entering a state such as `MatchNodeSelector`, `CrashLoopBackOff`, or `ContainerCreating` until you update the worker nodes to the same version as the master. After you update from a deprecated to a supported version, your cluster can resume normal operations and continue receiving support.<br><br>You can find out whether your cluster is **unsupported** by reviewing the **State** field in the output of the `ibmcloud ks cluster ls` command or in the [{{site.data.keyword.containerlong_notm}} console](https://cloud.ibm.com/kubernetes/clusters){: external}.
{: important}


## Preparing to update
{: #prep-up}

 Updating a cluster to a new version from the previous version is likely to have an impact on deployed apps. For a complete list of changes, review the [community Kubernetes changelogs](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG), [IBM version changelogs](/docs/containers?topic=containers-changelog){: external}, and [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

See the list below for actions you should take before and after updating to specific versions:
-  Version 1.23 [preparation actions](/docs/containers?topic=containers-cs_versions_123#prep-up-123)
-  Version 1.22 [preparation actions](/docs/containers?topic=containers-cs_versions_122#prep-up-122).
-  Version 1.21 [preparation actions](/docs/containers?topic=containers-cs_versions_121#prep-up-121).
-  **Deprecated**: Version 1.20 [preparation actions](/docs/containers?topic=containers-cs_versions_120#prep-up-120).
-  **Deprecated**: Version 1.19 [preparation actions](/docs/containers?topic=containers-cs_versions_119#prep-up-119).
-  [Archive](#k8s_version_archive) of unsupported versions.


## Archive
{: #k8s_version_archive}

Find an overview of Kubernetes versions that are unsupported in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

### Version 1.18 (Unsupported)
{: #cs_v118}

As of 10 October 2021, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.18](/docs/containers?topic=containers-118_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes, or update the cluster to the next version. Review the potential impacts and immediately [update the cluster](/docs/containers?topic=containers-update#update) to continue receiving important security updates and support.

### Version 1.17 (Unsupported)
{: #cs_v117}

As of 2 July 2021, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.17](/docs/containers?topic=containers-117_changelog) are unsupported.
{: shortdesc}

{[unsupported_n-2]

### Version 1.16 (Unsupported)
{: #cs_v116}

As of 31 January 2021, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.16](/docs/containers?topic=containers-116_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.15 (Unsupported)
{: #cs_v115}

As of 22 September 2020, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.15](/docs/containers?topic=containers-115_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.14 (Unsupported)
{: #cs_v114}

As of 31 May 2020, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.14](/docs/containers?topic=containers-114_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.13 (Unsupported)
{: #cs_v113}

As of 22 February 2020, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.13](/docs/containers?topic=containers-113_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.12 (Unsupported)
{: #cs_v112}

As of 3 November 2019, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.12](/docs/containers?topic=containers-112_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.11 (Unsupported)
{: #cs_v111}

As of 20 July 2019, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.11](/docs/containers?topic=containers-111_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.10 (Unsupported)
{: #cs_v110}

As of 16 May 2019, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.10](/docs/containers?topic=containers-110_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.9 (Unsupported)
{: #cs_v19}

As of 27 December 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.9](/docs/containers?topic=containers-19_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.8 (Unsupported)
{: #cs_v18}

As of 22 September 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.8](/docs/containers?topic=containers-18_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.7 (Unsupported)
{: #cs_v17}

As of 21 June 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.7](/docs/containers?topic=containers-17_changelog) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

### Version 1.5 (Unsupported)
{: #cs_v1-5}

As of 4 April 2018, {{site.data.keyword.containerlong_notm}} clusters that run [Kubernetes version 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.5.md) are unsupported.
{: shortdesc}

Unsupported clusters are not provided with security and patch updates and are not supported by {{site.data.keyword.cloud_notm}} Support. Although your cluster and apps might continue to run for a time, you can no longer create, reload, or take other corrective actions on your cluster master or worker nodes when an issue occurs. You can still delete the cluster or worker nodes. To continue running your apps in {{site.data.keyword.containerlong_notm}}, [make a new cluster](/docs/containers?topic=containers-clusters#clusters) and [deploy your apps](/docs/containers?topic=containers-app#app) to the new cluster.

