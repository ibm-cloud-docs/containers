---

copyright: 
  years: 2024, 2025
lastupdated: "2025-03-04"


keywords: kubernetes, containers, 131, version 131, 131 update actions

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}



# 1.31 version information and update actions
{: #cs_versions_131}


Review information about version 1.31 of {{site.data.keyword.containerlong}}. For more information about Kubernetes project version 1.31, see the [Kubernetes change log](https://kubernetes.io/releases/notes/.){: external}.
{: shortdesc}


![This badge indicates Kubernetes version 1.31 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Kubernetes version 1.31 certification badge" caption-side="bottom"} 

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.31 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._




## Release timeline 
{: #release_timeline_131}

The following table includes the expected release timeline for version 1.31 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

| Version | Supported? | Release date | Unsupported date |
|------|------|----------|----------|
| 1.31 | Yes | {{site.data.keyword.kubernetes_131_release_date}} | {{site.data.keyword.kubernetes_131_unsupported_date}} `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.31" caption-side="bottom"}


## Preparing to update
{: #prep-up-131}

This information summarizes updates that are likely to have an impact on deployed apps when you update a cluster to version 1.31. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.31.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_131) for version 1.31. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}.
{: shortdesc}

[Portworx](/docs/containers?topic=containers-storage_portworx_about) does not yet support version 1.31. Do not upgrade your cluster to version 1.31 if your apps use Portworx.
{: important}


### Update before master
{: #before_131}

The following table shows the actions that you must take before you update the Kubernetes master.

| Type | Description |
| --- | --- |
| Calico API server is a managed resource | {{site.data.keyword.containerfull_notm}} now manages the installation of and updates to the Calico API server component. If your cluster contains the `calico-apiserver` namespace, then you must uninstall the Calico API server before upgrading. Also, if you have any network policies blocking egress out of the kube-system/konnectivity-agent pods, including something based on an example policy like [allow-egress-pods-public](https://github.com/IBM-Cloud/kube-samples/blob/master/calico-policies/public-network-isolation/us-south/allow-egress-pods-public.yaml){: external} that applies to all pods, you need to also allow egress from the kube-system/konnectivity-agent pods to port 5443 on the calico-apiserver/calico-apiserver pods. |
| Prevent volume mode conversion | Kubernetes snapshot controller now rejects volume mode changes when creating a persistent volume claim from a volume snapshot unless the `snapshot.storage.kubernetes.io/allow-volume-mode-change: "true"` annotation has been added to the `VolumeSnapshotContent` that corresponds to the `VolumeSnapshot`. For more information, see [Converting the volume mode of a Snapshot](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#convert-volume-mode){: external}. |
| Ubuntu 24 is the default operating system | Ubuntu 24 is now the default operating system for {{site.data.keyword.containerfull_notm}} version 1.31 clusters. Clusters upgraded to version 1.31 continue to support either Ubuntu 20 or 24 worker nodes and the current operating system for an existing worker pool remains unchanged. For more information and possible migration actions related to Ubuntu 24, see [Migrating to a new Ubuntu version](/docs/containers?topic=containers-ubuntu-migrate). |
{: caption="Changes to make before you update the master to Kubernetes 1.31" caption-side="bottom"}


### Update after master
{: #after_131}

The following table shows the actions that you must take after you update the Kubernetes master.

| Type | Description |
| --- | --- |
| **Unsupported:** `kubectl exec` command execution without dash | The deprecated `kubectl exec [POD] [COMMAND]` command execution has been removed and is replaced by `kubectl exec [POD] -- [COMMAND]`.  If your scripts rely on the previous behavior, update them. |
| **Unsupported:** `kubectl drain` `--delete-local-data` option | The deprecated `--delete-local-data` option for the `kubectl drain` command has been removed and is replaced by the `--delete-emptydir-data` option. If your scripts rely on the previous behavior, update them. |
| **Unsupported:** Numerous `kubectl run` options | The deprecated `--filename`, `--force`, `--grace-period`, `--kustomize`, `--recursive`, `--timeout`, and `--wait` options for the `kubectl run` command have been removed. If your scripts rely on the previous behavior, update them. |
| **Deprecated:** Pod `container.apparmor.security.beta.kubernetes.io` annotations | Pod `container.apparmor.security.beta.kubernetes.io` annotations are now deprecated. These annotations are replaced by the `securityContext.appArmorProfile` field for pods and containers. If your pods rely on these deprecated annotations, update them to use the `securityContext.appArmorProfile` field instead. For more information, see [AppArmor support is now stable](https://kubernetes.io/blog/2024/08/13/kubernetes-v1-31-release/#apparmor-support-is-now-stable){: external}. |
| **Deprecated:** Persistent volume `volume.beta.kubernetes.io/mount-options` annotation | The persistent volume `volume.beta.kubernetes.io/mount-options` annotation is now deprecated. This annotation is replaced by the `spec.mountOptions` field. If your pods rely on this deprecated annotation, update them to use the `spec.mountOptions` field instead. For more information, see [Mount Options](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#mount-options){: external}. |
{: caption="Changes to make after you update the master to Kubernetes 1.31" caption-side="bottom"}
