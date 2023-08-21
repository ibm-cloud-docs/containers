---

copyright:
  years: 2014, 2023
lastupdated: "2023-08-21"

keywords: kubernetes, 1.22, versions, update, upgrade

subcollection: containers

---

# 1.22 version information and update actions
{: #cs_versions_122}

{{site.data.keyword.attribute-definition-list}}


Kubernetes version 1.22 becomes unsupported on 14 September 2022. Update your cluster to at least [version 1.23](/docs/containers?topic=containers-cs_versions_123) as soon as possible.
{: deprecated}


Review information about version 1.22 of {{site.data.keyword.containerlong}}, released 29 Sept 2021.
{: shortdesc}

Looking for general information on updating {{site.data.keyword.containerlong}} clusters, or information on a different version? See [Kubernetes version information and update actions](/docs/containers?topic=containers-cs_versions).
{: tip}

![This badge indicates Kubernetes version 1.22 certification for {{site.data.keyword.containerlong_notm}}](images/certified-kubernetes-color.svg){: caption="Figure 1. Kubernetes version 1.22 certification badge" caption-side="bottom"}

{{site.data.keyword.containerlong_notm}} is a Certified Kubernetes product for version 1.22 under the CNCF Kubernetes Software Conformance Certification program. _Kubernetes® is a registered trademark of The Linux Foundation in the United States and other countries, and is used pursuant to a license from The Linux Foundation._

For more information about Kubernetes project version 1.22, see the Kubernetes change log.

## Release timeline
{: #release_timeline_122}

The following table includes the expected release timeline for version 1.22 of {{site.data.keyword.containerlong}}. You can use this information for planning purposes, such as to estimate the general time that the version might become unsupported. 
{: shortdesc}

Dates that are marked with a dagger (`†`) are tentative and subject to change.
{: important}

|  Version | Supported? | {{site.data.keyword.containerlong_notm}} \n release date | {{site.data.keyword.containerlong_notm}} \n unsupported date |
|------|------|----------|----------|
| 1.22 | Yes | 29 Sept 2021 | 14 Dec 2022 `†` |
{: caption="Release timeline for {{site.data.keyword.containerlong_notm}} version 1.22" caption-side="bottom"}

## Preparing to update
{: #prep-up-122}

This information summarizes updates that are likely to have and impact on deployed apps when you update a cluster to version 1.22. For a complete list of changes, review the [community Kubernetes change log](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md){: external} and [IBM version change log](/docs/containers?topic=containers-changelog_122) for version 1.22. You can also review the [Kubernetes helpful warnings](https://kubernetes.io/blog/2020/09/03/warnings/){: external}. 
{: shortdesc}

Review [Security Bulletin: IBM Cloud Kubernetes Service is affected by an endpoint resource security design flaw in Kubernetes (CVE-2021-25740)](https://www.ibm.com/support/pages/node/6574821){: external}before updating.
{: important}



### Update before master
{: #122_before}

The following table shows the actions that you must take before you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| **Unsupported:** Beta versions of `PriorityClass` API | Migrate manifests and API clients to use the `scheduling.k8s.io/v1` API version, available since Kubernetes version 1.14. For more information, see [Deprecated API Migration Guide - v1.22](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22){: external}. |
| **Unsupported**:  Beta versions of `ClusterRole`, `ClusterRoleBinding`, `Role`, and `RoleBinding APIs` | Migrate manifests and API clients to use the `rbac.authorization.k8s.io/v1` API version, available since Kubernetes version 1.8. For more information, see [Deprecated API Migration Guide - v1.22](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-22){: external}. |
| **Unsupported**:  Beta versions of `ValidatingWebhookConfiguration` and `MutatingWebhookConfiguration` APIs | Migrate manifests and API clients to use the `admissionregistration.k8s.io/v1` API version, available since Kubernetes version 1.16. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**:  Beta version of `CustomResourceDefinition` API | Migrate manifests and API clients to use the `apiextensions.k8s.io/v1` API version, available since Kubernetes version 1.16. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**:  Beta version of `APIService` API | Migrate manifests and API clients to use the `apiregistration.k8s.io/v1` API version, available since Kubernetes version 1.10. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**:  Beta version of `TokenReview` API | Migrate manifests and API clients to use the `authentication.k8s.io/v1` API version, available since Kubernetes version 1.10. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**:  Beta versions of `SubjectAccessReview`, `LocalSubjectAccessReview`, `SelfSubjectAccessReview` APIs | Migrate manifests and API clients to use the `authorization.k8s.io/v1` API version, available since Kubernetes version 1.6. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**:  Beta version of `CertificateSigningRequest` API | Migrate manifests and API clients to use the `certificates.k8s.io/v1` API version, available since Kubernetes version 1.19. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**:  Beta version of `Lease` API | Migrate manifests and API clients to use the `coordination.k8s.io/v1` API version, available since Kubernetes version 1.14. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**:  Beta versions of `Ingress` API | Migrate manifests and API clients to use the `networking.k8s.io/v1` API version, available since Kubernetes version 1.19. For more information, see [Kubernetes API and Feature Removals In 1.22: Here’s What You Need To Know](https://kubernetes.io/blog/2021/07/14/upcoming-changes-in-kubernetes-1-22/){: external}. |
| **Unsupported**: IBM Cloud Kubernetes Ingress Controller | As of 1 Jun 2021, the IBM Cloud Kubernetes Ingress Controller is no longer supported on {{site.data.keyword.containerlong_notm}}. Migrate your IBM Cloud Kubernetes Ingress Controller based ALBs to the Kubernetes Ingress Controller. |
| Ingress | Kubernetes 1.22 supports Ingress and IngressClass resources with `networking.k8s.io/v1` version, which is only available on Kubernetes Ingress Controller version 1.0.0 and newer. Kubernetes Ingress Controller version 1.0.0 is supported on {{site.data.keyword.containerlong_notm}} cluster versions 1.19 or newer.  \n - **Cluster versions 1.19, 1.20, and 1.21**: Ingress and IngressClass resources that were created on clusters that run on Kubernetes versions 1.19, 1.20 or 1.21 and Ingress Controller version 1.0.0 are automatically updated during the cluster update to 1.22. The Kubernetes API Server dynamically manages the conversion from the earlier `extensions/v1beta1` and `networking.k8s.io/v1beta1` Ingresses to the new `networking.k8s.io/v1`.  \n - **External Ingress resources**: For Ingress resources that are stored outside of Kubernetes clusters, such as in a version control system or any other external storage, the `extensions/v1beta1` and `networking.k8s.io/v1beta1` descriptors can't be used with Kubernetes 1.22. Convert these descriptors to `networking.k8s.io/v1` Ingresses and IngressClasses.  \n - If you have ALB auto updates enabled, you don't need to manually update your ALBs.  \n - If you have ALB auto updates disabled, you must update your Kubernetes Ingress Controller based ALBs to a supported 0.4.x version before updating to 1.0.0 or newer. To check your auto update settings, run the `ibmcloud ks ingress alb autoupdate` get command.  \n - **ALB OAuth-Proxy add-on**: `networking.k8s.io/v1beta1` is compatible with ALB OAuth-Proxy add-on version 2.0.0 only. If you use the ALB OAuth-Proxy add-on you must update the add-on to version 2.0.0 before updating your cluster to 1.22. |
| **Unsupported**: Service `service.alpha.kubernetes.io/tolerate-unready-endpoints` annotation | Services no longer support the `service.alpha.kubernetes.io/tolerate-unready-endpoints` annotation. The annotation has been deprecated since Kubernetes version 1.11 and has been replaced by the `spec.publishNotReadyAddresses` field. If your services rely on this annotation, update them to use the `spec.publishNotReadyAddresses` field instead. For more information on this field, see [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/){: external}. |
{: caption="Changes to make before you update the master to Kubernetes 1.22" caption-side="bottom"}


### Update after master
{: #122_after}

The following table shows the actions that you must take after you update the Kubernetes master.
{: shortdesc}

| Type | Description|
| --- | --- |
| Endpoint Security Mitigation | Kubernetes cluster role `system:aggregate-to-edit` has removed `endpoints` permissions as a security mitigation for [CVE-2021-25740](https://nvd.nist.gov/vuln/detail/CVE-2021-25740){: external}. If your cluster does not require any customizations to the `system:aggregate-to-edit` cluster role, besides removing the `endpoints` permission, allow Kubernetes to reconcile the permissions by running the `kubectl annotate --overwrite clusterrole/system:aggregate-to-edit rbac.authorization.kubernetes.io/autoupdate=true` command. Subsequent cluster master operations (for example, `ibmcloud ks cluster master refresh`) will then ensure the permissions are reconciled by Kubernetes. |
| **Unsupported**:  `kubectl autoscale` removes `--generator` option | The `kubectl austoscale` no longer uses the deprecated `--generator` option. If your scripts rely on this option, update them. |
| **Unsupported**: `kubectl create deployment` removes `--generator` option | The `kubectl create deployment` command no longer uses the deprecated `--generator` option. If your scripts rely on this option, update them. |
| `system:aggregate-to-edit` write access for Endpoints API | The `system:aggregate-to-edit` role no longer includes write access to the Endpoints API. Existing clusters that are upgraded to Kubernetes 1.22 are not impacted. However, in new Kubernetes 1.22 clusters, the Editor and Administrator roles don't have write access to the Endpoints API. For more information on retaining this access in newly created 1.22 clusters, see [Write access for Endpoints](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#write-access-for-endpoints){: external}. This update is a mitigation for [CVE-2021-25740](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25740){: external}. |
{: caption="Changes to make after you update the master to Kubernetes 1.22" caption-side="bottom"}

