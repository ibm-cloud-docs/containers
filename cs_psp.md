---

copyright:
  years: 2014, 2018
lastupdated: "2018-06-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Configuring pod security policies
{: #psp}

With [pod security policies ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/), you can
configure policies to authorize who can create and update pods in {{site.data.keyword.containerlong}}. Clusters that run Kubernetes version 1.10.3 or later support the `PodSecurityPolicy` admission controller that enforces these policies. 
{: shortdesc}

Using an older version of Kubernetes? [Update your cluster](cs_cluster_update.html) today.
{: tip}

**Why do I set pod security policies?**

As a cluster admin, you want to control what happens in your cluster, especially actions that affect the cluster's security or readiness. Pod security policies can help you control usage of privileged containers, root namespaces, host networking and ports, volume types, host file systems, Linux permissions such as read-only or group IDs, and more.

With the the `PodSecurityPolicy` admission controller, no pods can be created until after you [authorize policies](#customize_psp). Setting up pod security policies can have unintended side-effects, so make sure to test out a deployment after you change the policy. To deploy apps, the user and service accounts must all be authorized by the pod security policies that are required to deploy pods. For example, if you install apps by using [Helm](cs_integrations.html#helm_links), the Helm tiller component creates pods, and so you must have the correct pod security policy authorization.

**Are any policies set by default? What can I add?**

By default, {{site.data.keyword.containershort_notm}} configures the `PodSecurityPolicy` admission controller with [resources for {{site.data.keyword.IBM_notm}} cluster management](#ibm_psp) that you cannot delete or modify. You also cannot disable the admission controller. 

Pod actions are not locked down by default. Instead, two role-based access control (RBAC) resources in the cluster authorize all admins, users, services, and nodes to create privileged and unprivileged pods. If you want to prevent certain users from creating or updating pods, you can [modify these RBAC resources](#customize_psp) or [create your own](#create_psp).

**How does policy authorization work?**

When you as a user create a pod directly and not by using a controller such as a deployment, your credentials are validated against the pod security policies that you are authorized to use. If no policy supports the pod security requirements, the pod is not created.

When you create a pod by using a resource controller such as a deployment, Kubernetes validates the pod's service account credentials against the pod security policies that the service account is authorized to use. If no policy supports the pod security requirements, the controller succeeds, but the pod is not created.

For common error messages, see [Pods fail to deploy because of a pod security policy](cs_troubleshoot_clusters.html#cs_psp).

## Customizing pod security policies
{: #customize_psp}

To prevent unauthorized pod actions, you can modify existing pod security policy resources or create your own. You must be a cluster admin to customize policies.
{: shortdesc}

### Modifying existing pod security policies
{: #modify_psp}

By default, your cluster contains the following RBAC resources that enable cluster
administrators, authenticated users, service accounts, and nodes to use the
`ibm-privileged-psp` and `ibm-restricted-psp` pod security policies. These
policies allow the users to create and update privileged and unprivileged (restricted) pods.

| Name | Namespace | Type | Purpose |
|---|---|---|---|
| `privileged-psp-user` | cluster-wide | `ClusterRoleBinding` | Enables cluster administrators, authenticated users, service accounts, and nodes to use `ibm-privileged-psp` pod security policy. |
| `restricted-psp-user` | cluster-wide | `ClusterRoleBinding` | Enables cluster administrators, authenticated users, service accounts, and nodes to use `ibm-restricted-psp` pod security policy. |
{: caption="Default RBAC resources that you can modify" caption-side="top"}

You can modify these RBAC roles to remove or add admins, users, services, or nodes to the policy.

Before you begin: 
*  [Target your CLI](cs_cli_install.html#cs_cli_configure) to your cluster.
*  Understand working with RBAC roles. For more information, see [Authorizing users with custom Kubernetes RBAC roles](cs_users.html#rbac) or the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview).

**To modify the RBAC resources**:
1.  Get the name of the RBAC cluster role binding.
    ```
    kubectl get clusterrolebinding
    ```
    {: pre}
    
2.  Download the cluster role binding as a `.yaml` file that you can edit locally.
    ```
    kubectl get clusterrolebinding privileged-psp-user -o yaml > privileged-psp-user.yaml
    ```
    {: pre}
    
3.  Edit the cluster role binding `.yaml` file. Example actions:
    *   You might want to authorize service accounts, such as deployments, only in specific namespaces. Change the `system:serviceaccounts` field to `system:serviceaccount:<namespace>`.
    *   You might want to remove authorization for all authenticated users to deploy pods with privileged access. Remove the `system:authenticated` entry.
        ```
        - kind: Group
        apiGroup: rbac.authorization.k8s.io
        name: system:authenticated
        ```
        {: screen}

4.  Create the modified cluster role binding resource in your cluster.

    ```
    kubectl apply -f privileged-psp-user.yaml
    ```
    {: pre}
    
5.  Verify that the resource was modified.

    ```
    kubectl get clusterrolebinding privileged-psp-user -o yaml
    ```
    {: pre}

**To delete the RBAC resources**:
1.  Get the name of the RBAC cluster role binding.
    ```
    kubectl get clusterrolebinding
    ```
    {: pre}

2.  Delete the RBAC role that you want to remove.
    ```
    kubectl delete clusterrolebinding privileged-psp-user
    ```
    {: pre}
    
3.  Verify that the RBAC cluster role binding is no longer in your cluster.
    ```
    kubectl get clusterrolebinding
    ```
    {: pre}

### Creating pod security policies
{: #create_psp}

To create your own pod security policy, review the [Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/).

## Understanding default resources for {{site.data.keyword.IBM_notm}} cluster management
{: #ibm_psp}

Your Kubernetes cluster in {{site.data.keyword.containershort_notm}} contains the following
pod security policies and related RBAC resources to allow {{site.data.keyword.IBM_notm}} to properly manage your cluster.
{: shortdesc}

The default `privileged-psp-user` and `restricted-psp-user` RBAC resources refer to the pod security policies that are set by {{site.data.keyword.IBM_notm}}. 

**Attention**: You must not delete or modify these resources.

| Name | Namespace | Type | Purpose |
|---|---|---|---|
| `ibm-privileged-psp` | cluster-wide | `PodSecurityPolicy` | Policy for privileged pod creation. |
| `ibm-privileged-psp-user` | cluster-wide | `ClusterRole` | Cluster role that allows the use of `ibm-privileged-psp` pod security policy. |
| `ibm-privileged-psp-user` | `kube-system` | `RoleBinding` | Enables cluster administrators, service accounts, and nodes to use `ibm-privileged-psp` pod security policy in the `kube-system` namespace. |
| `ibm-privileged-psp-user` | `ibm-system` | `RoleBinding` | Enables cluster administrators, service accounts, and nodes to use `ibm-privileged-psp` pod security policy in the `ibm-system` namespace. |
| `ibm-privileged-psp-user` | `kubx-cit` | `RoleBinding` | Enables cluster administrators, service accounts, and nodes to use `ibm-privileged-psp` pod security policy in the `kubx-cit` namespace. |
| `ibm-restricted-psp` | cluster-wide | `PodSecurityPolicy` | Policy for unprivileged, or restricted, pod creation. |
| `ibm-restricted-psp-user` | cluster-wide | `ClusterRole` | Cluster role that allows the use of `ibm-restricted-psp` pod security policy. |
{: caption="IBM pod security policies resources that you must not modify" caption-side="top"}
