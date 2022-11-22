---

copyright:
  years: 2014, 2022
lastupdated: "2022-11-22"

keywords: kubernetes, 1.20, versions, update, upgrade

subcollection: containers

---

# 1.20 version information and update actions
{: #cs_versions_120}

Kubernetes version 1.20 is unsupported as of 19 June 2022. Update your cluster to at least [version 1.21](/docs/containers?topic=containers-cs_versions_121) as soon as possible.
{: important}

Review information about version 1.20 of {{site.data.keyword.containerlong}}, released 16 Feb 2021.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}

![This badge indicates Kubernetes version 1.20 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Figure 1. Kubernetes version 1.20 certification badge" caption-side="bottom"}

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.20 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._

For more information about Kubernetes project version 1.20, see [Kubernetes documentation](https://kubernetes.io/docs/home/){: external}.

## Release timeline
{: #release_timeline_120}

The following table includes the expected release timeline for version 1.20 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

|  Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.20 | Unsupported | 16 Feb 2021 | 19 June 2022 |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.20" caption-side="bottom"}

## Preparing to update
{: #prep-up-120}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.20. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_120) for version 1.20. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}

### Update before master
{: #120_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| Kubernetes snapshot CRDs | {{site.data.keyword.containerlong_notm}} installs Kubernetes snapshot custom resource definition (CRD) version `v1beta1`. If you use other Kubernetes snapshot CRD versions `v1` or `v1alpha1`, you must change the version to `v1beta1`. To check the currently installed version of your snapshot CRDs, run `grep snapshot.storage.k8s.io <<(kubectl get apiservices)`. Follow the Kubernetes documentation to [Upgrade from v1alpha1 to v1beta1](https://github.com/kubernetes-csi/external-snapshotter#upgrade-from-v1alpha1-to-v1beta1){: external} to make sure that your snapshot CRDs are at the correct `v1beta1` version. The steps to downgrade from version `v1` to `v1beta1` are the same as those to upgrade from `v1alpha1`. Do not follow the instructions to upgrade from version `v1beta1` to version `v1`. |
| **Unsupported:** Open access to the Kubernetes Dashboard metrics scraper | A Kubernetes network policy is added to protect access to the Kubernetes Dashboard metrics scraper. If a pod requires access to the dashboard metrics scraper, deploy the pod in a namespace that has the `dashboard-metrics-scraper-policy: allow` label. For more information, see [Controlling traffic with network policies](/docs/containers?topic=containers-network_policies). |
| Resolve non-deterministic behavior of owner references | Kubernetes garbage collector is updated to resolve non-deterministic behavior of owner references. Before you update your cluster, review the [Kubernetes community recommendation](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#urgent-upgrade-notes){: external} that you run the [kubectl-check-ownerreferences](https://github.com/kubernetes-sigs/kubectl-check-ownerreferences){: external} tool to locate existing objects with invalid owner references. |
| **Unsupported**: Service `service.alpha.kubernetes.io/tolerate-unready-endpoints` annotation | Services no longer support the `service.alpha.kubernetes.io/tolerate-unready-endpoints` annotation. The annotation has been deprecated since Kubernetes version 1.11 and has been replaced by the `spec.publishNotReadyAddresses` field. If your services rely on this annotation, update them to use the `spec.publishNotReadyAddresses` field instead. For more information on this field, see [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/){: external}. |
| VPC clusters: App URL character length | DNS resolution is managed by the cluster's [virtual private endpoint (VPE)](/docs/containers?topic=containers-vpc-subnets#vpc_basics_vpe), which can resolve URLs up to 130 characters. If you expose apps in your cluster with URLs, such as the Ingress subdomain, ensure that the URLs are 130 characters or fewer. |
{: caption="Changes to make before you update the master to Kubernetes 1.20" caption-side="bottom"}

### Update after master
{: #120_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| **Unsupported:** `kubectl autoscale --generator` removed | The deprecated `--generator` flag is removed from the `kubectl autoscale` command. If your scripts rely on this flag, update them. |
{: caption="Changes to make after you update the master to Kubernetes 1.20" caption-side="bottom"}

