---

copyright: 
  years: 2022, 2022
lastupdated: "2022-11-11"

keywords: kubernetes, deploy, pod security admission, pod security, security profiles

subcollection: containers


---

{{site.data.keyword.attribute-definition-list}}


# Pod security admission
{: #pod-security-admission}

Pod security admission implements the Kubernetes pod security standards that restrict the behavior of pods, providing warning messages and `kube-apiserver` audit events for pods that violate the pod security profile policy configured for the relevant namespace.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} version 1.25 and later includes support for Kubernetes pod security admission. For more information, see [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/){: external} and [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/){: external} in the Kubernetes documentation.

Pod Security Admission is always enabled for {{site.data.keyword.containerlong_notm}} version 1.25 and later. Earlier versions of Kubernetes use [pod security policies](/docs/containers?topic=containers-psp).
{: note}

## Understanding security profiles
{: #pod_security_profiles}

The Kubernetes pod security standards define the following three profiles.
{: shortdesc}

Privileged
:   The default pod security configuration globally enforces the `privileged` Kubernetes pod security profile, which is unrestricted and allows for known privilege escalations, and generates warnings and audit events based on the policies set by the `restricted` profile.

Baseline
:   The `baseline` profile is a restrictive profile that prevents known privilege escalations. Allows the default (minimally specified) Pod configuration.

Restricted
:   The `restricted` profile is heavily restricted and follows the current pod hardening best practices. 

For more information about pod security profiles, see [Profile details](https://kubernetes.io/docs/concepts/security/pod-security-standards/){: external} in the Kubernetes documentation.


Pod Security Admission contains three modes that define what action the control plane takes if a potential violation is detected.

enforce
:   Policy violations cause the pod to be rejected.

audit
:   Policy violations trigger the addition of an audit annotation to the event recorded in the audit log, but are otherwise allowed.

warn
:   Policy violations trigger a user-facing warning, but are otherwise allowed.

As security standards or profiles implementations change to address new features, you can configure Pod Security Admission to use a specific version of the roles. The following versions are supported.

- A Kubernetes major.minor version (i.e. `v1.25`)
- `latest`

## What if Pod Security Admission isn't the right choice for me?
{: #what-if-psa}

While Pod Security Admission is always enabled, it can be one of multiple admission controllers. You can configure third-party Kubernetes admission controllers to implement other security policy models that suit your use case.

If you configure Pod Security Admission to enforce, warn, and audit by using the `privileged` profile, then the control plane allows all pods to run. You can then configure other admission controllers to reject them.

You can install a third-party admission controller as long as it doesn't take either of the following actions.
- It doesn't install its own pod security policies (PSPs).
- It doesn't rely on PSPs to enforce parts of the policy.

## Configuring Pod Security admission namespace labels
{: #psa-namespace-labels}

You can define the admission control mode you want to use for pod security in each namespace. Kubernetes defines a set of labels that you can set to define which of the predefined Pod Security Standard profiles you want to use for a namespace. The label you select defines what action the control plane takes if a potential violation is detected.

By default, {{site.data.keyword.containerlong_notm}} adds the `privileged` Pod Security labels to the following namespaces. These namespaces are labeled to `enforce`, `audit`, and `warn` by using the `privileged` profile.

- `kube-system` 
- `ibm-system`
- `ibm-operators`


Do not remove or change the labels for these namespaces.
{: important}



A namespace can be labeled to set the pod security profile for any or all of the Pod Security Admission `modes`. 

For example, you can label a namespace to enforce the `privileged` profile in additon to using `warn` or `audit` by using the `baseline` profile.

This allows administators and application developers to dry-run applications by looking for only warnings and audit records against the `baseline` profile without rejecting pods. Then, you can make necessary changes to your workloads before changing the enforce mode to `baseline`.

The Pod Security Admission namespace labels are of the form `pod-security.kubernetes.io/<MODE>: <LEVEL>` and `pod-security.kubernetes.io/<MODE>-version: <VERSION>`.

- `pod-security.kubernetes.io/enforce`
- `pod-security.kubernetes.io/enforce-version`
- `pod-security.kubernetes.io/audit`
- `pod-security.kubernetes.io/audit-version`
- `pod-security.kubernetes.io/warn`
- `pod-security.kubernetes.io/warn-version`

To label a namespace to enforce the `privileged` profile and generate warnings and audit events for violations of the `baseline` profile, use the following labels.

- `pod-security.kubernetes.io/enforce: privileged`
- `pod-security.kubernetes.io/enforce-version: latest`
- `pod-security.kubernetes.io/audit: baseline`
- `pod-security.kubernetes.io/audit-version: latest`
- `pod-security.kubernetes.io/warn: baseline`
- `pod-security.kubernetes.io/warn-version: latest`


## Pod Security Admission plug-in configuration
{: #psa-plugin-config}

{{site.data.keyword.containerlong_notm}} uses the following `PodSecurityConfiguration` definition by default. Note that it is not currently possible to modify the Pod Security Admission configuration. 

```yaml
apiVersion: pod-security.admission.config.k8s.io/v1
kind: PodSecurityConfiguration
defaults:
  enforce: "privileged"
  enforce-version: "latest"
  audit: "privileged"
  audit-version: "latest"
  warn: "privileged"
  warn-version: "latest"
exemptions:
  usernames: []
  runtimeClasses: []
  namespaces: []
```
{: codeblock}


## Pod Security Admission roadmap
{: #psa-roadmap}

Support for Pod Security Admission is expected to delivered in phases.

Support for migrating clusters that use customized PSP configurations to v1.25 is not yet available as this requires the ability to have both Pod Security Policies and Pod Security Admission enabled simultaneously.

Full functionality for v1.25 is not yet available: Administrators cannot configure the cluster wide Pod Security Admission plug-in configuration.

| Functionality | Availability |
| ---| ---|
| Provide default Pod Security Admission plugin configuration that enforces the `privileged` profile.  | Available |
| Support upgrade from v1.24 to v1.25 for clusters with only the default IBM PSPs and associated RBAC. | Available |
| Cancel upgrades for clusters not using the default IBM PSPs and associated RBAC. | Available |
| Optionally enable Pod Security Admission in v1.24 to support migration process. | 4Q 2022 |
| Optionally disable Pod Security Policies in v1.24 to support migration process. | 4Q 2022 | 
| Provide migration guide. | 4Q 2022 |
| Customize the cluster wide Pod Security Admission plugin configuration. | 1Q 2023 |
{: caption="Table 1. Availability for 1.25 functions" caption-side="bottom"}





