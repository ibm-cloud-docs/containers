---

copyright: 
  years: 2023, 2025
lastupdated: "2025-08-05"


keywords: kubernetes, containers, 129, version 129, 129 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.29 version information and update actions
{: #cs_versions_129}



This version is no longer supported. Update your cluster to a [supported version](/docs/containers?topic=containers-cs_versions) as soon as possible.
{: important}



Review information about version 1.29 of {{site.data.keyword.containerlong}}. For more information about Kubernetes project version 1.29, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}.
{: shortdesc}

![This badge indicates Kubernetes version 1.29 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Kubernetes version 1.29 certification badge" caption-side="bottom"} 

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.29 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._




## Release timeline 
{: #release_timeline_129}

The following table includes the expected release timeline for version 1.29 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.29 | No | {{site.data.keyword.kubernetes_129_release_date}} | {{site.data.keyword.kubernetes_129_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.29" caption-side="bottom"}


## Preparing to update
{: #prep-up-129}

This information summarizes updates that are likely to have an impact on deployed apps when you update a cluster to version 1.29. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_129) for version 1.29. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

The default `cgroup` for Ubuntu 24 is `cgroup` v2. In Ubuntu 24, `cgroup` v1 is not supported. Review the [Kubernetes migration documentation for `cgroup` v2](https://kubernetes.io/docs/concepts/architecture/cgroups/#migrating-to-cgroup-v2){: external} and verify that your applications fully support `cgroup` v2. There are known issues with older versions of Java that might cause out of memory (OOM) issues for workloads.
{: important}


### Update before master
{: #before_129}

The following table shows the actions that you must take before you update the Kubernetes master.

| Type | Description |
| --- | --- |
| **Unsupported:** `v1beta2` version of the `FlowSchema` and `PriorityLevelConfiguration` API | Migrate manifests and API clients to use the `flowcontrol.apiserver.k8s.io/v1beta3` API version, which is available since Kubernetes version 1.26. For more information, see [Deprecated API Migration Guide - v1.29](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-29). |
| **Unsupported:** `CronJob` time zone specifications | When creating a `CronJob` resource, setting the `CRON_TZ` or `TZ` time zone specifications by using `.spec.schedule` is no longer allowed. Migrate your `CronJob` resources to use `.spec.timeZone` instead. See [Unsupported TimeZone specification](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#unsupported-timezone-specification) for details. |
| Updated extra user claim prefix | In the [Kubernetes API server auditing records](/docs/containers?topic=containers-health-audit#audit-api-server), extra user claim information is prefixed with `cloud.ibm.com/authn_` instead of `authn_`. If your apps parsed this information, update them accordingly. |
| Tigera operator namespace migration | Tigera operator component is added and manages the Calico installation. As a result, Calico resources run in the `calico-system` and `tigera-operator` namespaces instead of `kube-system`. These namespaces are configured to be privileged like the `kube-system` namespace. During an upgrade, the Tigera operator migrates Calico resources and customizations from the `kube-system` namespace to the `calico-system` namespace. You can continue normal cluster operations during the migration because the migration might be in progress after the cluster master upgrade is completed. If your apps or operations tooling rely on Calico running in the `kube-system` namespace, update them accordingly. Before updating your cluster master, review the steps in the [Understanding the Tigera migration](#129-tigera-migration) section. |
| Calico custom resource short names | For new clusters, Calico custom resource short names `gnp` and `heps` are removed from the `globalnetworkpolicies.crd.projectcalico.org` and `hostendpoints.crd.projectcalico.org` custom resource definitions. Upgraded clusters retain the short names. Either way, if your `kubectl` commands rely on the short names, update them to use the standard names of `globalnetworkpolicies` and  `hostendpoints` instead. |
| Legacy service account token cleanup | [Kubernetes legacy service account token cleaner](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/#legacy-serviceaccount-token-cleaner) automatically labels, invalidates, and deletes unused legacy service account tokens. Tokens are labeled and invalidated when unused for one year, and then if unused for another year, deleted. You can use the `kubectl get secrets -A -l kubernetes.io/legacy-token-last-used -L kubernetes.io/legacy-token-last-used` command to determine when a legacy service account token was last used and the  `kubectl get secrets -A -l kubernetes.io/legacy-token-invalid-since -L kubernetes.io/legacy-token-invalid-since` command to determine if any legacy service account tokens are invalid and future candidates for deletion. Tokens labeled as invalid can be re-actived by removing the `kubernetes.io/legacy-token-invalid-since` label. For more information about these labels, see [`kubernetes.io/legacy-token-last-used`](https://kubernetes.io/docs/reference/labels-annotations-taints/#kubernetes-io-legacy-token-last-used) and [`kubernetes.io/legacy-token-invalid-since`](https://kubernetes.io/docs/reference/labels-annotations-taints/#kubernetes-io-legacy-token-invalid-since). |
| **Removed**: Node `Hostname` address type | Kubernetes no longer adds `Hostname` address type to `.status.addresses`. If you rely on the previous behavior, migrate to the `InternalIP` address type instead. For more information, see the related [Kubernetes community issue](https://github.com/kubernetes/kubernetes/issues/124453){: external} |
{: caption="Changes to make before you update the master to Kubernetes 1.29" caption-side="bottom"}


### Update after master
{: #after_129}

The following table shows the actions that you must take after you update the Kubernetes master.

| Type | Description |
| --- | --- |
| Tigera operator namespace migration | After the cluster master upgrade is completed, the Tigera operator namespace migration might still be in progress. For larger clusters, the migration might take several hours to complete. During the migration, Calico resources exist in both the `kube-system` and `calico-system` namespaces. When the migration is completed, Calico resources are fully removed from the `kube-system` namespace with the next cluster master operation. Wait for the migration to complete before upgrading worker nodes because updating, reloading, replacing, or adding nodes during the migration makes the process take longer to complete. The migration must be completed before your cluster is allowed to upgrade to version 1.30. To verify that the migration is complete, run the following commands. If no data is returned, the migration is complete. `kubectl get nodes -l projectcalico.org/operator-node-migration --no-headers --ignore-not-found ; kubectl get deployment calico-typha -n kube-system -o name --ignore-not-found`. If your apps or operation tooling rely on Calico running in the `kube-system` namespace, update them accordingly. |
| Customizing Calico configuration | Customizing your Calico configuration has changed. Your existing customizations are migrated for you. However, to customize your Calico configuration in the future, see [Changing the Calico maximum transmission unit (MTU)](/docs/containers?topic=containers-kernel#calico-mtu) and [Disabling the port map plug-in](/docs/containers?topic=containers-kernel#calico-portmap). |
{: caption="Changes to make after you update the master to Kubernetes 1.29" caption-side="bottom"}


### Understanding the Tigera Operator namespace migration
{: #129-tigera-migration}

In version 1.29, Tigera Operator was introduced to manage Calico resources. All the Calico components are migrated from the `kube-system` to the `calico-system` namespace. During the master upgrade process, a new deployment appears called Tigera Operator, which manages the migration process and the lifecycle of Calico components, such as `calico-node`, `calico-typha`, and `calico-kube-controllers`.

Before performing a master update, if your cluster has any tainted nodes, make sure that you have at least 6 untainted nodes so that the `calico-typha` pods can be migrated effectively. If you do not have 6 untainted nodes, then alternatively you can complete the following steps.
{: note}


1. Make sure that you have at least 4 untainted nodes.
1. Run the following command immediately before the master update to 1.29 to reduce the `kube-system/calico-typha` pod requirements to 1.
    ```sh
    kubectl scale deploy -n kube-system calico-typha --replicas 1
    ```
    {: pre}

1. Before updating, check the status of the Calico components. The operator can start its job only when all the Calico components are healthy, up, and running. If the Calico components are healthy, the rollout status returned by the command for each component is `successfully rolled out`.
    ```sh
    kubectl rollout status -n kube-system deploy/calico-typha deploy/calico-kube-controllers ds/calico-node
    ```
    {: pre}

1. Continue the master update.

1. After the master upgrade is finished, some Calico resources might remain in the `kube-system` namespace. These resources are no longer used by Calico and are no longer needed after the migration is complete. The next master operation removes them. Do not remove them yourself.
    ```txt
    - "kind": "ConfigMap", "name": "calico-config"
    - "kind": "Secret", "name": "calico-bgp-password"
    - "kind": "Service", "name": "calico-typha"
    - "kind": "Role", "name": "calico-node-secret-access"
    - "kind": "RoleBinding", "name": "calico-node-secret-access"
    - "kind": "PodDisruptionBudget", "name": "calico-kube-controllers"
    - "kind": "PodDisruptionBudget", "name": "calico-typha"
    - "kind": "ServiceAccount", "name": "calico-cni-plugin"
    - "kind": "ServiceAccount", "name": "calico-kube-controllers"
    - "kind": "ServiceAccount", "name": "calico-node"
    - "kind": "ClusterRole", "name": "calico-cni-plugin-migration"
    - "kind": "ClusterRole", "name": "calico-kube-controllers-migration"
    - "kind": "ClusterRoleBinding", "name": "calico-cni-plugin-migration"
    - "kind": "ClusterRoleBinding", "name": "calico-kube-controllers-migration"
    ```
    {: codeblock}
