---

copyright:
  years: 2014, 2022
lastupdated: "2022-12-12"

keywords: kubernetes, 1.21, versions, update, upgrade

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}


# 1.21 version information and update actions
{: #cs_versions_121}

Kubernetes version 1.21 becomes unsupported on 14 September 2022. Update your cluster to at least [version 1.22](/docs/containers?topic=containers-cs_versions_122) as soon as possible.
{: deprecated}

Review information about version 1.21 of {{site.data.keyword.containerlong}}, released 09 Jun 2021.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}

![This badge indicates Kubernetes version 1.21 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Figure 1. Kubernetes version 1.21 certification badge" caption-side="bottom"}

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.21 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._

For more information about Kubernetes project version 1.21, see the [Kubernetes change log](https://v1-21.docs.kubernetes.io/releases/notes/){: external}.

## Release timeline
{: #release_timeline_121}

The following table includes the expected release timeline for version 1.21 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}


Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

|  Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.21 | Yes | 09 June 2021 | 14 September 2022 |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.21" caption-side="bottom"}

## Preparing to update
{: #prep-up-121}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.21. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.21.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_121) for version 1.21. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}


There is a known issue when updating an existing classic cluster to version 1.21. If your classic cluster has both private and public service endpoints enabled, but you don't have both VRF and Service Endpoint enabled in your account, don't update to 1.21. For more information, see [After upgrading my classic cluster to version 1.21, I'm finding connectivity issues](/docs/containers?topic=containers-ts-network-classic121).
{: note}



### Update before master
{: #121_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| **Unsupported**: Kubernetes REST API `export` query parameter removed | The `export` query parameter is removed from the Kubernetes REST API and now returns a `400` error status response. If you use this query parameter, remove it from your API requests. |
| **Unsupported**: Kubernetes external IP services | The Kubernetes [DenyServiceExternalIPs admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#denyserviceexternalips){: external} is enabled, which prevents creating or updating Kubernetes external IP services. If you use Kubernetes external IP services, migrate to a supported service type. For more information, see the [IBM security bulletin](https://www.ibm.com/support/pages/node/6428013){: external}. |
| Kubernetes snapshot CRDs | {{site.data.keyword.containerlong_notm}} installs Kubernetes snapshot custom resource definition (CRD) version `v1beta1`. If you use other Kubernetes snapshot CRD versions `v1` or `v1alpha1`, you must change the version to `v1beta1`. To check the currently installed version of your snapshot CRDs, run `grep snapshot.storage.k8s.io <<(kubectl get apiservices)`. Follow the Kubernetes documentation to [Upgrade from v1alpha1 to v1beta1](https://github.com/kubernetes-csi/external-snapshotter#upgrade-from-v1alpha1-to-v1beta1){: external} to make sure that your snapshot CRDs are at the correct `v1beta1` version. The steps to downgrade from version `v1` to `v1beta1` are the same as those to upgrade from `v1alpha1`. Do not follow the instructions to upgrade from version `v1beta1` to version `v1`. |
| OpenVPN replaced by Konnectivity | [Konnectivity](https://kubernetes.io/docs/tasks/extend-kubernetes/setup-konnectivity/){: external} replaces OpenVPN as the network proxy that is used to secure the communication of the Kubernetes API server master to worker nodes in the cluster. If your apps rely on the OpenVPN implementation of Kubernetes master to worker node communication, update them to support [Konnectivity](https://kubernetes.io/docs/tasks/extend-kubernetes/setup-konnectivity/){: external}. |
| Pod access via service account token | For clusters that run Kubernetes 1.21 and later, the service account tokens that pods use to communicate with the Kubernetes API server are time-limited, automatically refreshed, scoped to a particular audience of users (the pod), and invalidated after the pod is deleted. To continue communicating with the API server, you must design your apps to read the refreshed token value on a regular basis, such as every minute. For applications that invoke the `setuid` internally, you must [manually set the `fsGroup` in the pod security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod){: external}. For more information, see [Bound Service Account Tokens](https://github.com/kubernetes/enhancements/blob/master/keps/sig-auth/1205-bound-service-account-tokens/README.md){: external}. |
| **Unsupported**: Service `service.alpha.kubernetes.io/tolerate-unready-endpoints` annotation | Services no longer support the `service.alpha.kubernetes.io/tolerate-unready-endpoints` annotation. The annotation has been deprecated since Kubernetes version 1.11 and has been replaced by the `Service` `spec.publishNotReadyAddresses` field. If your services rely on this annotation, update them to use the `spec.publishNotReadyAddresses` field instead. For more information on this field, see [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/){: external} |
{: caption="Changes to make before you update the master to Kubernetes 1.21" caption-side="bottom"}

### Update after master
{: #121_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| **Unsupported:** `kubect alpha debug` removed | The `kubectl alpha debug` command is removed. Instead, use the `kubectl debug` command. |
| **Unsupported:** `kubectl run` removed deprecated options | The `kubectl run` command removes the following deprecated flags: `--generator`, `--replicas`, `--service-generator`, `--service-overrides` and `--schedule`. If your scripts use `kubectl run` to create resources other than pods, such as deployments, or if your scripts use the removed options, update the scripts to use the `kubectl create` or `kubectl apply` commands instead. |
| `kubectl get` removes `managedFields` by default  | Now, the `kubectl get` command omits `managedFields` in the `-o json` or `-o yaml` output by default. If you use `kubectl get` to retrieve `managedFields` by using `-o json` or `-o yaml` output, update your `kubectl get` calls to include the `--show-managed-fields=true` option.  |
| **Unsupported**: Select `kubelet` metrics | The following cAdvisor `kubelet` metrics are removed: `/stats/container`, `/stats/<pod_name>/<container_name>`, and `/stats/<namespace>/<pod_name>/<pod_uid>/<container_name>`. Stop using these metrics. |
| Ingress resource API version | The support for `networking.k8s.io/v1beta1` and `extensions/v1beta1` API versions in Ingress resources are deprecated and are planned for removal in Kubernetes version 1.22. The `networking.k8s.io/v1` API version is supported instead. Although not required in version 1.21, you can begin converting your existing resources in preparation for the removal of the API versions before version 1.22. |
{: caption="Changes to make after you update the master to Kubernetes 1.21" caption-side="bottom"}

