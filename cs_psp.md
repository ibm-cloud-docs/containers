---

copyright:
  years: 2014, 2025
lastupdated: "2025-01-29"


keywords: kubernetes

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Configuring pod security policies
{: #psp}

With [pod security policies (PSPs)](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}, you can
configure policies to authorize who can create and update pods in {{site.data.keyword.containerlong}}.

Pod security policies are not available in clusters that run version 1.25 or later. In clusters that run version 1.25 or later, use [Pod Security admission](/docs/containers?topic=containers-pod-security-admission) instead. To upgrade a cluster with pod security policies from version 1.24 to version 1.25, follow the steps in [Migrating from PSPs to Pod Security Admission](/docs/containers?topic=containers-pod-security-admission-migration). 
{: note}

## FAQ
{: #psp-faqs}

Learn about some common FAQ for configuring your pod security policies.

### Why do I set pod security policies?
{: #why-set-psps}

As a cluster admin, you want to control what happens in your cluster, especially actions that affect the cluster's security or readiness. Pod security policies can help you control usage of privileged containers, root privileges, host networking and ports, volume types, host file systems, Linux capabilities, and more.

With the `PodSecurityPolicy` admission controller, pod creation is controlled by pod security policies and related role-based access control (RBAC). By default, {{site.data.keyword.containerlong_notm}} clusters don't restrict pod creation for any authenticated users or service accounts. To secure your cluster, customize the pod security policies. This customization can have unintended side-effects, so make sure to thoroughly test your customizations. To deploy apps, the user and service accounts must all be authorized by the pod security policies that are required to deploy pods.

Trying to control which users have access to the {{site.data.keyword.containerlong_notm}}? See [Assigning cluster access](/docs/containers?topic=containers-iam-platform-access-roles) to set {{site.data.keyword.cloud_notm}} IAM and infrastructure permissions.
{: tip}

### Are any policies set by default? What can I add?
{: #psp-defaults}

By default, {{site.data.keyword.containerlong_notm}} configures the `PodSecurityPolicy` admission controller with [resources for {{site.data.keyword.IBM_notm}} cluster management](#ibm_psp) that you can't delete or modify. You also can't disable the admission controller.

Pod actions are not locked down by default. Instead, two role-based access control (RBAC) resources in the cluster authorize all administrators, users, services, and nodes to create privileged and unprivileged pods. Additional RBAC resources are included for portability with {{site.data.keyword.cloud_notm}} Private packages that are used for hybrid deployments.

If you want to prevent certain users from creating or updating pods, you can [modify these RBAC resources or create your own](#customize_psp).

### How does policy authorization work?
{: #psp-auth}

When you as a user create a pod directly and not by using a controller such as a deployment, your credentials are validated against the pod security policies that you are authorized to use. If no policy supports the pod security requirements, the pod is not created.

When you create a pod by using a resource controller such as a deployment, Kubernetes validates the pod's service account credentials against the pod security policies that the service account is authorized to use. If no policy supports the pod security requirements, the controller succeeds, but the pod is not created.

For common error messages, see [Pods fail to deploy because of a pod security policy](/docs/containers?topic=containers-psp).

### Why can I still create privileged pods when I am not part of the `privileged-psp-user` cluster role binding?
{: #psp-role-binding}

Other cluster role bindings or namespace-scoped role bindings might give you other pod security policies that authorize you to create privileged pods. Additionally by default, cluster administrators have access to all resources, including pod security policies, and so can add themselves to PSPs or create privileged resources.

## Customizing pod security policies
{: #customize_psp}

To prevent unauthorized pod actions, you can modify existing pod security policy resources or create your own. You must be a cluster admin to customize policies.
{: shortdesc}

What existing policies can I modify?
:   By default, your cluster contains the following RBAC resources that enable cluster administrators, authenticated users, service accounts, and nodes to use the `ibm-privileged-psp` and `ibm-restricted-psp` pod security policies. These policies allow the users to create and update privileged and unprivileged (restricted) pods.

| Name | Namespace | Type | Purpose |
|---|---|---|---|
| `privileged-psp-user` | All | `ClusterRoleBinding` | Enables cluster administrators, authenticated users, service accounts, and nodes to use `ibm-privileged-psp` pod security policy. |
| `restricted-psp-user` | All | `ClusterRoleBinding` | Enables cluster administrators, authenticated users, service accounts, and nodes to use `ibm-restricted-psp` pod security policy. |
{: caption="Default RBAC resources that you can modify" caption-side="bottom"}

You can modify these RBAC roles to remove or add administrators, users, services, or nodes to the policy. These modifications don't prevent cluster administrators, service accounts, and nodes from using the privileged pod security policy in the `kube-system`, `ibm-system`, and `ibm-operators` namespaces. Do not modify these system namespaces, which are privileged namespaces.

Before you begin
* [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
* Understand working with RBAC roles. For more information, see [Authorizing users with custom Kubernetes RBAC roles](/docs/containers?topic=containers-iam-platform-access-roles) or the [Kubernetes documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview){: external}.
* Ensure you have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-iam-platform-access-roles) for all namespaces.

When you modify the default configuration, you can prevent important cluster actions, such as pod deployments or cluster updates. Test your changes in a non-production cluster that other teams don't rely on.
{: important}

### Modifying the RBAC resources
{: #modify_rbac}

1. Get the name of the RBAC cluster role binding. The following steps use the `privileged-psp-user` RBAC as an example, but you can take similar steps for the `restricted-psp-user` RBAC or custom pod security policies.
    ```sh
    kubectl get clusterrolebinding
    ```
    {: pre}

2. Download the cluster role binding as a `.yaml` file that you can edit locally.

    ```sh
    kubectl get clusterrolebinding privileged-psp-user -o yaml > privileged-psp-user.yaml
    ```
    {: pre}

    You might want to save a copy of the existing policy so that you can revert to it if the modified policy yields unexpected results.
    {: tip}

    Example cluster role binding file

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      creationTimestamp: 2018-06-20T21:19:50Z
      name: privileged-psp-user
      resourceVersion: "1234567"
      selfLink: /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/privileged-psp-user
      uid: aa1a1111-11aa-11a1-aaaa-1a1111aa11a1
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: ibm-privileged-psp-user
    subjects:
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:masters
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:nodes
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:serviceaccounts
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:authenticated
    ```
    {: codeblock}

3. Edit the cluster role binding `.yaml` file. To understand what you can edit, review the [Kubernetes documentation](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}. Example actions:

    - **Service accounts**: You might want to authorize service accounts so that deployments can occur only in specific namespaces. For example, if you scope the policy to allow actions within the `default` namespace, the service account can deploy privileged pods in that namespace. However, actions in other namespaces are no longer authorized because you changed the scope from service accounts generally to service accounts specifically in the `default` namespace.

        Do not scope the policy to namespaces that run system components, such as the `kube-system`, `ibm-system`, or `ibm-operators` namespaces. These namespaces already have [their own policies](/docs/containers?topic=containers-psp#ibm_psp). Changing the system component policies might cause unexpected results, such as all service accounts in all namespaces being able to deploy privileged pods.
        {: important}

        To scope the policy to allow actions in a specific namespace, change the `system:serviceaccounts` to `system:serviceaccount:<namespace>`.
        ```yaml
        - apiGroup: rbac.authorization.k8s.io
          kind: Group
          name: system:serviceaccounts:default
        ```
        {: codeblock}

        To scope the policy to multiple namespaces, copy the subject group and update the namespace.
        ```yaml
        - apiGroup: rbac.authorization.k8s.io
          kind: Group
          name: system:serviceaccounts:default
        - apiGroup: rbac.authorization.k8s.io
          kind: Group
          name: system:serviceaccounts:test
        ```
        {: codeblock}

    - **Users**: You might want to remove authorization for all authenticated users to deploy pods with privileged access. Remove the following `system:authenticated` entry.
        ```yaml
        - apiGroup: rbac.authorization.k8s.io
          kind: Group
          name: system:authenticated
        ```
        {: codeblock}

4. Create the modified cluster role binding resource in your cluster. Now, any users and service accounts that are not explicitly authorized to the privileged pod security policy can create pods only by using the restricted pod security policy.

    ```sh
    kubectl apply -f privileged-psp-user.yaml
    ```
    {: pre}

5. Verify that the resource was modified.

    ```sh
    kubectl get clusterrolebinding privileged-psp-user -o yaml
    ```
    {: pre}

### Deleting RBAC resources
{: #delete_rbac}

To delete the RBAC resources,

1. Get the name of the RBAC cluster role binding. The following steps use the `privileged-psp-user` RBAC as an example, but you can take similar steps for the `restricted-psp-user` RBAC or custom pod security policies.
    ```sh
    kubectl get clusterrolebinding
    ```
    {: pre}

2. Delete the RBAC role that you want to remove. Now, any users and service accounts can create pods only by using the restricted pod security policy.
    ```sh
    kubectl delete clusterrolebinding privileged-psp-user
    ```
    {: pre}

3. Verify that the RBAC cluster role binding is no longer in your cluster.
    ```sh
    kubectl get clusterrolebinding
    ```
    {: pre}

### Creating your own pod security policy
{: #creating_security_policy}

To create your own pod security policy resource and authorize users with RBAC, review the [Kubernetes documentation](https://kubernetes.io/docs/concepts/security/pod-security-policy/){: external}.

Make sure that you modified the existing policies so that the new policy that you create does not conflict with the existing policy. For example, the existing policy permits users to create and update privileged pods. If you create a policy that does not permit users to create or update privileged pods, the conflict between the existing and the new policy might cause unexpected results.

## Understanding default resources for {{site.data.keyword.IBM_notm}} cluster management
{: #ibm_psp}

Your Kubernetes cluster in {{site.data.keyword.containerlong_notm}} contains the following
pod security policies and related RBAC resources to allow {{site.data.keyword.IBM_notm}} to properly manage your cluster.
{: shortdesc}

The default `PodSecurityPolicy` resources refer to the pod security policies that are set by {{site.data.keyword.IBM_notm}}.

You must not delete or modify these resources.
{: important}

| Name | Namespace | Type | Purpose |
|---|---|---|---|
| `ibm-anyuid-hostaccess-psp` | All | `PodSecurityPolicy` | Policy for full host access pod creation. |
| `ibm-anyuid-hostaccess-psp-user` | All | `ClusterRole` | Cluster role that allows the use of `ibm-anyuid-hostaccess-psp` pod security policy. |
| `ibm-anyuid-hostpath-psp` | All | `PodSecurityPolicy` | Policy for host path access pod creation. |
| `ibm-anyuid-hostpath-psp-user` | All | `ClusterRole` | Cluster role that allows the use of `ibm-anyuid-hostpath-psp` pod security policy. |
| `ibm-anyuid-psp` | All | `PodSecurityPolicy` | Policy for any UID/GID executable pod creation. |
| `ibm-anyuid-psp-user` | All | `ClusterRole` | Cluster role that allows the use of `ibm-anyuid-psp` pod security policy. |
| `ibm-privileged-psp` | All | `PodSecurityPolicy` | Policy for privileged pod creation. |
| `ibm-privileged-psp-user` | All | `ClusterRole` | Cluster role that allows the use of `ibm-privileged-psp` pod security policy. |
| `ibm-privileged-psp-user` | `ibm-operators` | `RoleBinding` |  Enables cluster administrators, service accounts, and nodes to use `ibm-privileged-psp pod` security policy in the `ibm-operators` namespace.|
| `ibm-privileged-psp-user` | `ibm-system` | `RoleBinding` | Enables cluster administrators, service accounts, and nodes to use `ibm-privileged-psp` pod security policy in the `ibm-system` namespace. |
| `ibm-privileged-psp-user` | `kube-system` | `RoleBinding` | Enables cluster administrators, service accounts, and nodes to use `ibm-privileged-psp` pod security policy in the `kube-system` namespace. |
| `ibm-restricted-psp` | All | `PodSecurityPolicy` | Policy for unprivileged, or restricted, pod creation. |
| `ibm-restricted-psp-user` | All | `ClusterRole` | Cluster role that allows the use of `ibm-restricted-psp` pod security policy. |
{: caption="IBM pod security policies resources that you must not modify" caption-side="bottom"}
