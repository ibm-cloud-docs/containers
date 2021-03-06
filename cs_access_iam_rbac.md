---

copyright:
  years: 2014, 2021
lastupdated: "2021-07-12"

keywords: kubernetes, iks, infrastructure, rbac, policy

subcollection: containers

---

{:DomainName: data-hd-keyref="APPDomain"}
{:DomainName: data-hd-keyref="DomainName"}
{:android: data-hd-operatingsystem="android"}
{:api: .ph data-hd-interface='api'}
{:apikey: data-credential-placeholder='apikey'}
{:app_key: data-hd-keyref="app_key"}
{:app_name: data-hd-keyref="app_name"}
{:app_secret: data-hd-keyref="app_secret"}
{:app_url: data-hd-keyref="app_url"}
{:authenticated-content: .authenticated-content}
{:beta: .beta}
{:c#: data-hd-programlang="c#"}
{:cli: .ph data-hd-interface='cli'}
{:codeblock: .codeblock}
{:curl: .ph data-hd-programlang='curl'}
{:deprecated: .deprecated}
{:dotnet-standard: .ph data-hd-programlang='dotnet-standard'}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:fuzzybunny: .ph data-hd-programlang='fuzzybunny'}
{:generic: data-hd-operatingsystem="generic"}
{:generic: data-hd-programlang="generic"}
{:gif: data-image-type='gif'}
{:go: .ph data-hd-programlang='go'}
{:help: data-hd-content-type='help'}
{:hide-dashboard: .hide-dashboard}
{:hide-in-docs: .hide-in-docs}
{:important: .important}
{:ios: data-hd-operatingsystem="ios"}
{:java: .ph data-hd-programlang='java'}
{:java: data-hd-programlang="java"}
{:javascript: .ph data-hd-programlang='javascript'}
{:javascript: data-hd-programlang="javascript"}
{:new_window: target="_blank"}
{:note .note}
{:note: .note}
{:objectc data-hd-programlang="objectc"}
{:org_name: data-hd-keyref="org_name"}
{:php: data-hd-programlang="php"}
{:pre: .pre}
{:preview: .preview}
{:python: .ph data-hd-programlang='python'}
{:python: data-hd-programlang="python"}
{:route: data-hd-keyref="route"}
{:row-headers: .row-headers}
{:ruby: .ph data-hd-programlang='ruby'}
{:ruby: data-hd-programlang="ruby"}
{:runtime: architecture="runtime"}
{:runtimeIcon: .runtimeIcon}
{:runtimeIconList: .runtimeIconList}
{:runtimeLink: .runtimeLink}
{:runtimeTitle: .runtimeTitle}
{:screen: .screen}
{:script: data-hd-video='script'}
{:service: architecture="service"}
{:service_instance_name: data-hd-keyref="service_instance_name"}
{:service_name: data-hd-keyref="service_name"}
{:shortdesc: .shortdesc}
{:space_name: data-hd-keyref="space_name"}
{:step: data-tutorial-type='step'}
{:subsection: outputclass="subsection"}
{:support: data-reuse='support'}
{:swift: .ph data-hd-programlang='swift'}
{:swift: data-hd-programlang="swift"}
{:table: .aria-labeledby="caption"}
{:term: .term}
{:terraform: .ph data-hd-interface='terraform'}
{:tip: .tip}
{:tooling-url: data-tooling-url-placeholder='tooling-url'}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}
{:tutorial: data-hd-content-type='tutorial'}
{:ui: .ph data-hd-interface='ui'}
{:unity: .ph data-hd-programlang='unity'}
{:url: data-credential-placeholder='url'}
{:user_ID: data-hd-keyref="user_ID"}
{:vbnet: .ph data-hd-programlang='vb.net'}
{:video: .video}
  
  

# Controlling user access with {{site.data.keyword.cloud_notm}} IAM and Kubernetes RBAC
{: #users}

Set {{site.data.keyword.cloud_notm}} IAM platform access and service access policies in the {{site.data.keyword.cloud_notm}} console or CLI so that users can work with clusters in {{site.data.keyword.containerlong_notm}}. IAM service access roles correspond with Kubernetes role-based access control (RBAC) within the cluster.
{: shortdesc}

Before you begin, check out [Understanding access policies and roles](/docs/containers?topic=containers-access-overview#access_policies) to review what policies are, whom you can assign policies to, and what resources can be granted policies.
{: shortdesc}

{{site.data.keyword.cloud_notm}} IAM roles can't be assigned to a service account. Instead, you can directly [assign RBAC roles to service accounts](#rbac).
{: note}

## Example cluster use cases and IAM roles
{: #example-iam}

Wondering which access roles to assign to your cluster users? Use the examples in following table to determine which roles and scope to assign. You can find more information about what roles authorize which types of actions on the user access reference page in the table's links.
{: shortdesc}

| Use case | Example roles and scope |
| --- | --- |
| App auditor | [Viewer platform access role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#iam_platform), [Reader service access role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#service). |
| App developers | [Editor platform access role for a cluster](/docs/containers?topic=containers-access_reference#iam_platform), [Writer service access role scoped to a namespace](/docs/containers?topic=containers-access_reference#service), [Cloud Foundry developer space role](/docs/containers?topic=containers-access_reference#cloud-foundry). |
| Billing | [Viewer platform access role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#iam_platform). |
| Create a cluster | See [Permissions to create a cluster](/docs/containers?topic=containers-access_reference#cluster_create_permissions).|
| Cluster administrator | [Administrator platform access role for a cluster](/docs/containers?topic=containers-access_reference#iam_platform), [Manager service access role not scoped to a namespace (for the whole cluster)](/docs/containers?topic=containers-access_reference#service).|
| DevOps operator | [Operator platform access role for a cluster](/docs/containers?topic=containers-access_reference#iam_platform), [Writer service access role not scoped to a namespace (for the whole cluster)](/docs/containers?topic=containers-access_reference#service), [Cloud Foundry developer space role](/docs/containers?topic=containers-access_reference#cloud-foundry).  |
| Operator or site reliability engineer | [Administrator platform access role for a cluster, region, or resource group](/docs/containers?topic=containers-access_reference#iam_platform), [Reader service access role for a cluster or region](/docs/containers?topic=containers-access_reference#service) or [Manager service access role for all cluster namespaces](/docs/containers?topic=containers-access_reference#service) to be able to use `kubectl top nodes,pods` commands. |
{: summary="The first column contains the use case, which is typically the role of a user. The second column is the example role and scope of the role that you assign the user in {{site.data.keyword.cloud_notm}} IAM."}
{: caption="Types of roles you might assign to meet different use cases." caption-side="top"}

<br />

## Assigning {{site.data.keyword.cloud_notm}} IAM roles with the console
{: #add_users}

Grant users access to your {{site.data.keyword.containerlong_notm}} clusters by assigning {{site.data.keyword.cloud_notm}} IAM platform access and service access roles with the {{site.data.keyword.cloud_notm}} console.
{: shortdesc}

<p class="tip">Do not assign platform access roles at the same time as a service access role. You must assign platform and service access roles separately.</p>

Before you begin, verify that you're assigned the **Administrator** platform access role for the {{site.data.keyword.cloud_notm}} account in which you're working.

1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external}. From the menu bar, select **Manage > Access (IAM)**.

2. Select users individually or create an access group of users.
    * **To assign roles to an individual user**:
      1. In the left navigation, click the **Users** page, and then click the name of the user that you want to set permissions for. If the user isn't shown, click **Invite users** to add them to the account.
      2. Click the **Access policies** tab, and then click **Assign access**. Now, the breadcrumbs on the page are **Users / Manage User**.
      3. Optional: Add the user to an access group that has access to {{site.data.keyword.containerlong_notm}}.
    * **To assign roles to multiple users in an access group**:
      1. In the left navigation, click the **Access groups** page.
      2. Click **Create** and give your group a **Name** and **Description**. Click **Create**.
      3. Click **Add users** to add people to your access group. A list of users that have access to your account is shown.
      4. Check the box next to the users that you want to add to the group. A dialog box displays.
      5. Click **Add to group**.
      6. Click the **Access policies** tab.
      7. Click **Assign access**. Now, the breadcrumbs on the page are **Groups / Manage Group**.

3. Assign an access policy to {{site.data.keyword.containerlong_notm}}.
   1. Click the **IAM services** tile.
   2. In the services drop-down list, select **Kubernetes Service**. You can enter text in the drop-down list instead of scrolling through the list.
   3. **Optional**: To scope the access policy to a resource group, select the resource group from the resource group drop-down list. If you want to scope the policy to a Kubernetes namespace, make sure to clear the resource group drop-down list. You cannot scope an access policy to both a Kubernetes namespace and a resource group at the same time.
   4. From the **Region** list, select one or all regions.
   5. From the **Cluster** `string equals` drop-down list, select the cluster that you want to scope the access policy to. To scope the policy to all clusters, clear or leave the field blank.
   6. From the **Namespace** `string equals` field, enter the Kubernetes namespace that you want to scope the access policy to.<p class="note">You cannot scope an access policy to a namespace if you also scope the access policy to a resource group. Additionally, if you scope an access policy to a namespace, you must assign only a **service access** role. Do not assign a **platform access** role at the same time as you assign a service access role. Assign a platform access role separately.</p>
   7. Select roles for the access policy.
      * **Platform access role**: Grants access to {{site.data.keyword.containerlong_notm}} so that users can manage infrastructure resources such as clusters, worker nodes, worker pools, Ingress application load balancers, and storage. To find a list of supported actions per role, see [platform access roles reference page](/docs/containers?topic=containers-access_reference#iam_platform).<p class="note">If you assign a user the **Administrator** platform access role for only one cluster, you must also assign the user the **Viewer** platform access role for all clusters in that region in the resource group.</p>
      * **Service access role**: Grants access to the Kubernetes API from within a cluster so that users can manage Kubernetes resources such as pods, deployments, services, and namespaces. To find a list of supported actions per role, see [service access roles reference page](/docs/containers?topic=containers-access_reference#service).<p class="note">Do not assign a platform access role at the same time as you assign a service access role. If you also want the user to have a platform access role, repeat these steps but leave the namespace field blank and assign only a platform access role (do not assign a service access role again).</p>
   8. Click **Add**.
   9.  If you assigned only service access roles to users, the users must [launch the Kubernetes dashboard from the CLI](/docs/containers?topic=containers-deploy_app#db_cli) instead of the {{site.data.keyword.cloud_notm}} console. Otherwise, [give the users the platform **Viewer** role](#add_users_cli_platform).

4.  Assign the users **Viewer** access to the resource group so that they can work with clusters in resource groups other than default. Note that users must have access to the resource group to create clusters.
    1.  Click the **IAM services** tile.
    2.  In the services drop-down list, select **No service access**.
    3.  In the next drop-down list, scope the policy to **All resource groups** or to particular resource groups.
    4.  Select **Viewer**.
    5.  Click **Add**.

5.  In the side panel, review the **Access summary** of your changes, and click **Assign**. If you assigned a service access role, the role might take a couple minutes to sync with your cluster's RBAC.

<br />

## Assigning {{site.data.keyword.cloud_notm}} IAM roles with the CLI
{: #add_users_cli}

Grant users access to your {{site.data.keyword.containerlong_notm}} clusters by assigning {{site.data.keyword.cloud_notm}} IAM platform access and service access roles with the CLI.
{: shortdesc}

**Before you begin**:

- Verify that you're assigned the `cluster-admin` {{site.data.keyword.cloud_notm}} IAM platform access role for the {{site.data.keyword.cloud_notm}} account in which you're working.
- Verify that the user is added to the account. If the user is not, invite the user to your account by running `ibmcloud account user-invite <user@email.com>`.
- [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
- Decide whether to assign [platform or service access](/docs/containers?topic=containers-access-overview#access_policies) roles. The CLI steps vary depending on which access role you want to assign:
  * [Assign platform access roles from the CLI](#add_users_cli_platform)
  * [Assign service access roles from the CLI](#add_users_cli_service)

<br>

**To assign {{site.data.keyword.cloud_notm}} IAM _platform_ roles from the CLI:**
{: #add_users_cli_platform}

1.  Create an {{site.data.keyword.cloud_notm}} IAM access policy to set permissions for {{site.data.keyword.containerlong_notm}} (**`--service-name containers-kubernetes`**). Scope the access policy based on what you want to assign access to.

    <table summary="The table describes the access areas that you can scope the policy to by using CLI flags. Rows are to be read from the left to right, with the scope in column one, the CLI flag in column two, and the description in column three.">
    <caption>Options to scope the access policy</caption>
      <thead>
      <th>Scope</th>
      <th>CLI flag</th>
      <th>Description</th>
      </thead>
      <tbody>
        <tr>
        <td>User</td>
        <td>N/A</td>
        <td>You can assign the policy to an individual or group of users. Place this positional argument immediately following the command.
        <ul><li>**Individual user**: Enter the email address of the user.</li>
        <li>**Access group**: Enter the name of the access group of users. You can create an access group with the `ibmcloud iam access-group-create` command. To list available access groups, run `ibmcloud iam access-groups`. To add a user to an access group, run `ibmcloud iam access-group-user-add <access_group_name> <user_email>`.</li></ul></td>
        </tr>
        <tr>
        <td>Resource group</td>
        <td>`--resource-group-name`</td>
        <td>You can grant a policy for a resource group. If you do not specify a resource group or a specific cluster ID, the policy applies to all clusters for all resource groups. To list available resource groups, run `ibmcloud resource groups`.</td>
        </tr>
        <tr>
        <td>Cluster</td>
        <td>`--service-instance`</td>
        <td>You can limit the policy to a single cluster. To list your cluster IDs, run `ibmcloud ks cluster ls`. **Note**: If you assign a user the **Administrator** platform access role for only one cluster, you must also assign the user the **Viewer** platform access role for all clusters in the region within the resource group.</td>
        </tr>
        <tr>
        <td>Region</td>
        <td>`--region`</td>
        <td>You can scope the policy to apply to clusters within a particular region. If you do not specify a region or specific cluster ID, the policy applies to all clusters for all regions. To list available regions, review the [Previous region](/docs/containers?topic=containers-regions-and-zones#zones-mz) column in the {{site.data.keyword.containerlong_notm}} locations table.</td>
        </tr>
        <tr>
        <td>Role</td>
        <td>`--role`</td>
        <td>Choose the [platform access role](/docs/containers?topic=containers-access_reference#iam_platform) that you want to assign. Possible values are: `Administrator`, `Operator`, `Editor`, or `Viewer`.</td>
        </tr>
      </tbody>
      </table>

    **Example commands**:

    *  Assign an individual user the **Viewer** platform access role to one cluster in the default resource group and US East region:
       ```
       ibmcloud iam user-policy-create user@email.com --resource-group-name default --service-name containers-kubernetes --region us-east --service-instance clusterID-1111aa2b2bb22bb3333c3c4444dd4ee5 --roles Viewer
       ```
       {: pre}

    *  Assign an individual user **Administrator** platform access to all clusters in a `HR` resource group:
       ```
       ibmcloud iam user-policy-create user@email.com --resource-group-name HR --service-name containers-kubernetes [--region <region>] --roles Administrator
       ```
       {: pre}

    *  Assign an `auditors` group of users the **Viewer** platform access role to all clusters in all resource groups:
       ```
       ibmcloud iam access-group-policy-create auditors --service-name containers-kubernetes --roles Viewer
       ```
       {: pre}

2. Assign the users **Viewer** access to the resource group so that they can work with clusters in resource groups other than default. Note that users must have access to the resource group to create clusters. You can find the resource group ID by running `ibmcloud resource group <resource_group_name> --id`.
    *   For individual users:
        ```
        ibmcloud iam user-policy-create <user@email.com> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
        ```
        {: pre}
    *   For access groups:
        ```
        ibmcloud iam access-group-policy-create <access_group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
        ```
        {: pre}

3.  Verify that the user or access group has the assigned platform access role.
    *   For individual users:
        ```
        ibmcloud iam user-policies <user@email.com>
        ```
        {: pre}
    *   For access groups:
        ```
        ibmcloud iam access-group-policies <access_group>
        ```
        {: pre}

<br>
<br>

**To assign {{site.data.keyword.cloud_notm}} IAM _service_ roles from the CLI:**
{: #add_users_cli_service}



1.  Get the user information for the individual user or access group that you want to assign the service access role to.

    1.  Get your **Account ID**.
        ```
        ibmcloud account show
        ```
        {: pre}
    2.  For individual users, get the user's **userID** and **ibmUniqueId**.
        ```
        ibmcloud account users --account-id <account_ID> --output JSON
        ```
        {: pre}
    3.  For access groups, get the **Name** and **ID**.
        ```
        ibmcloud iam access-groups
        ```
        {: pre}

2.  Create a `policy.json` file that scopes the service access role to a Kubernetes namespace in your cluster.

    ```json
    {
        "subjects": [
            {
                "attributes": [
                    {
                        "name": "(iam_id|access_group_id)",
                        "value": "<user_or_group_ID>"
                    }
                ]
            }
        ],
        "roles": [
            {
                "role_id": "crn:v1:bluemix:public:iam::::serviceRole:<(Manager|Writer|Reader)>"
            }
        ],
        "resources": [
            {
                "attributes": [
                    {
                        "name": "accountId",
                        "value": "<account_ID>"
                    },
                    {
                        "name": "serviceName",
                        "value": "containers-kubernetes"
                    },
                    {
                        "name": "serviceInstance",
                        "value": "<cluster_ID1,cluster_ID2>"
                    },
                    {
                        "name": "namespace",
                        "value": "<namespace_name>"
                    }
                ]
            }
        ]
    }
    ```
    {: codeblock}

    <table summary="The table describes the fields to fill in for the JSON file. Rows are to be read from the left to right, with the scope in column one, the CLI flag in column two, and the description in column three.">
    <caption>Understanding the JSON file components</caption>
      <thead>
      <col width="25%">
      <th>Component</th>
      <th>Description</th>
      </thead>
      <tbody>
        <tr>
        <td>`subjects.attributes`</td>
        <td>Enter the {{site.data.keyword.cloud_notm}} IAM details for the individual user or access group that you previously retrieved.
        <ul><li>For individual users, set `iam_id` for the `name` field. Enter the previously retrieved **ibmUniqueId** for the `value` field.</li>
        <li>For access groups, set `access_group_id` for the `name` field. Enter the previously retrieved **ID** for the `value` field.</li></ul></td>
        </tr>
        <tr>
        <td>`roles.role_id`</td>
        <td>Choose the [IAM service access role](/docs/containers?topic=containers-access_reference#service) that you want to assign. Possible values are:
        <ul><li>`crn:v1:bluemix:public:iam::::serviceRole:Manager`</li>
        <li>`crn:v1:bluemix:public:iam::::serviceRole:Writer`</li>
        <li>`crn:v1:bluemix:public:iam::::serviceRole:Reader`</li></ul></td>
        </tr>
        <tr>
        <td>`resources.attributes`</td>
        <td>Configure the scope of the policy to your account, cluster, and namespace. Leave the `"name"` fields as given in the example, and enter certain `"value"` fields as follows.
        <ul><li>**For `"accountId"`**: Enter your {{site.data.keyword.cloud_notm}} account ID that you previously retrieved</li>
        <li>**For `"serviceName"`**: Leave the service name as given: `containers-kubernetes`.</li>
        <li>**For `"serviceInstance"`**: Enter your cluster ID. For multiple clusters, separate with a comma. To get your cluster ID, run `ibmcloud ks cluster ls`.</li>
        <li>**For `"namespace"`**: Enter a Kubernetes namespace in your cluster. To list the namespaces in your cluster, run `kubectl get namespaces`. <p class="note">To assign the access policy to all namespaces in a cluster, remove the entire `{"name": "namespace", "value": "<namespace_name"}` entry.</p></li></td>
        </tr>
      </tbody>
      </table>

3.  Apply the {{site.data.keyword.cloud_notm}} IAM policy to an individual user or access group.
    *   For individual users:
        ```
        ibmcloud iam user-policy-create <user@email.com> --file <filepath>/policy.json
        ```
        {: pre}
    *   For access groups:
        ```
        ibmcloud iam access-group-policy-create <access_group> --file <filepath>/policy.json
        ```
        {: pre}

4.  If you assigned only service access roles to users, the users must [launch the Kubernetes dashboard from the CLI](/docs/containers?topic=containers-deploy_app#db_cli) instead of the {{site.data.keyword.cloud_notm}} console. Otherwise, [give the users the platform **Viewer** role](#add_users_cli_platform).

5.  **Optional**: After a couple minutes, verify that the user is added to the corresponding [RBAC role binding or cluster role binding](#checking-rbac). 

<br />


## Understanding RBAC permissions
{: #understand-rbac}

RBAC roles and cluster roles define a set of permissions for how users can interact with Kubernetes resources in your cluster.
{: shortdesc}

With {{site.data.keyword.cloud_notm}} IAM, you can automatically manage RBAC from {{site.data.keyword.cloud_notm}}, by assigning users [service access roles](#add_users). You might want a deeper understanding of RBAC to customize access for resources within your cluster, like service accounts.
{: note}

**What are the types of RBAC roles?**

*   A Kubernetes _role_ is scoped to resources within a specific namespace, like a deployment or service.
*   A Kubernetes _cluster role_ is scoped to cluster-wide resources, like worker nodes, or to namespace-scoped resources that can be found in each namespace, like pods.

**What are RBAC role bindings and cluster role bindings?**

Role bindings apply RBAC roles or cluster roles to a specific namespace. When you use a role binding to apply a role, you give a user access to a specific resource in a specific namespace. When you use a role binding to apply a cluster role, you give a user access to namespace-scoped resources that can be found in each namespace, like pods, but only within a specific namespace.

Cluster role bindings apply RBAC cluster roles to all namespaces in the cluster. When you use a cluster role binding to apply a cluster role, you give a user access to cluster-wide resources, like worker nodes, or to namespace-scoped resources in every namespace, like pods.

**What do these roles look like in my cluster?**

If you want users to be able to interact with Kubernetes resources from within a cluster, you must assign user access to one or more namespaces through [{{site.data.keyword.cloud_notm}} IAM service access roles](#add_users). Every user who is assigned a service access role is automatically assigned a corresponding RBAC cluster role. These RBAC cluster roles are predefined and permit users to interact with Kubernetes resources in your cluster. Additionally, a role binding is created to apply the cluster role to a specific namespace, or a cluster role binding is created to apply the cluster role to all namespaces.

To learn more about the actions permitted by each RBAC role, check out the [{{site.data.keyword.cloud_notm}} IAM service access roles](/docs/containers?topic=containers-access_reference#service) reference topic. To see the permissions that are granted by each RBAC role to individual Kubernetes resources, check out [Kubernetes resource permissions per RBAC role](/docs/containers?topic=containers-access_reference#rbac_ref).

**Can I create custom roles or cluster roles?**

The `view`, `edit`, `admin`, and `cluster-admin` cluster roles are predefined roles that are automatically created when you assign a user the corresponding {{site.data.keyword.cloud_notm}} IAM service access role. To grant other Kubernetes permissions, you can [create custom RBAC permissions](#rbac). Custom RBAC roles are in addition to and do not change or override any RBAC roles that you might have assigned with service access roles. Note that to create custom RBAC permissions, you must have the IAM **Manager** service access role that gives you the `cluster-admin` Kubernetes RBAC role. However, the other users do not need an IAM service access role if you manage your own custom Kubernetes RBAC roles.

Making your own custom RBAC policies? Be sure not to edit the existing IBM role bindings that are in the cluster, or name new role bindings with the same name. Any changes to IBM-provided RBAC role bindings are overwritten periodically. Instead, create your own role bindings.
{: tip}



**When do I need to use cluster role bindings and role bindings that are not tied to the {{site.data.keyword.cloud_notm}} IAM permissions that I set?**

You might want to authorize who can create and update pods in your cluster. With [pod security policies (PSPs)](/docs/containers?topic=containers-psp), you can use existing cluster role bindings that come with your cluster, or create your own.

You might also want to integrate add-ons to your cluster. For example, when you [set up Helm in your cluster](/docs/containers?topic=containers-helm)

<br />

## Creating custom RBAC permissions for users, groups, or service accounts
{: #rbac}

The `view`, `edit`, `admin`, and `cluster-admin` cluster roles are automatically created when you assign the corresponding {{site.data.keyword.cloud_notm}} IAM service access role. Do you need your cluster access policies to be more granular than these predefined permissions allow? No problem! You can create custom RBAC roles and cluster roles.
{: shortdesc}

You can assign custom RBAC roles and cluster roles to individual users, groups of users, or service accounts. When a binding is created for a group, it affects any user that is added or removed from that group. When you add users to a group, they get the access rights of the group in addition to any individual access rights that you grant them. If they are removed, their access is revoked. Note that you can't add service accounts to access groups.

If you want to assign access to a process that runs in pods, such as a continuous delivery toolchain, you can use [Kubernetes `ServiceAccounts`](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/){: external}. To follow a tutorial that demonstrates how to set up service accounts for Travis and Jenkins and to assign custom RBAC roles to the service accounts, see the blog post [Kubernetes `ServiceAccounts` for use in automated systems](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982){: external}.

To prevent breaking changes, do not change the predefined `view`, `edit`, `admin`, and `cluster-admin` cluster roles. Custom RBAC roles are in addition to and do not change or override any RBAC roles that you might have assigned with {{site.data.keyword.cloud_notm}} IAM service access roles.
{: important}

**Do I create a role or a cluster role? Do I apply it with a role binding or a cluster role binding?**

* **Namespace access**: To allow a user, access group, or service account to access a resource within a specific namespace, choose one of the following combinations:
  * Create a role, and apply it with a role binding. This option is useful for controlling access to a unique resource that exists only in one namespace, like an app deployment.
  * Create a cluster role, and apply it with a role binding. This option is useful for controlling access to general resources in one namespace, like pods.
* **Cluster-wide access**: To allow a user or an access group to access cluster-wide resources or resources in all namespaces, create a cluster role, and apply it with a cluster role binding. This option is useful for controlling access to resources that are not scoped to namespaces, like worker nodes, or resources in all namespaces in your cluster, like pods in each namespace.

**Before you begin**:

- Target the [Kubernetes CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure) to your cluster.
- Ensure you that have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service access role](#add_users) for all namespaces.
- To assign access to individual users or users in an access group, ensure that the user or group has been assigned at least one [{{site.data.keyword.cloud_notm}} IAM platform access role](#add_users) at the {{site.data.keyword.containerlong_notm}} service level.

**To create custom RBAC permissions**:

1. Create the role or cluster role with the access that you want to assign.

    1. Create a `.yaml` file to define the role or cluster role.

        ```yaml
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
        <caption>Understanding the YAML components</caption>
          <col width="25%">
          <thead>
          <th>Parameter</th>
          <th>Description</th>
          </thead>
          <tbody>
          <tr>
          <td><code>kind</code></td>
          <td>Use `Role` to grant access to resources within a specific namespace. Use `ClusterRole` to grant access to cluster-wide resources such as worker nodes, or to namespace-scoped resources such as pods in all namespaces.</td>
          </tr>
          <tr>
          <td><code>apiVersion</code></td>
          <td><ul><li>For clusters that run Kubernetes 1.8 or later, use `rbac.authorization.k8s.io/v1`. </li><li>For earlier versions, use `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
          </tr>
          <tr>
          <td><code>metadata.namespace</code></td>
          <td>For kind `Role` only: Specify the Kubernetes namespace to which access is granted.</td>
          </tr>
          <tr>
          <td><code>metadata.name</code></td>
          <td>Name the role or cluster role.</td>
          </tr>
          <tr>
          <td><code>rules.apiGroups</code></td>
          <td>Specify the Kubernetes [API groups ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/using-api/api-overview/#api-groups) that you want users to be able to interact with, such as `"apps"`, `"batch"`, or `"extensions"`. For access to the core API group at REST path `api/v1`, leave the group blank: `[""]`.</td>
          </tr>
          <tr>
          <td><code>rules.resources</code></td>
          <td>Specify the Kubernetes [resource types ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) to which you want to grant access, such as `"daemonsets"`, `"deployments"`, `"events"`, or `"ingresses"`. If you specify `"nodes"`, then the kind must be `ClusterRole`.</td>
          </tr>
          <tr>
          <td><code>rules.verbs</code></td>
          <td>Specify the types of [actions ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubectl.docs.kubernetes.io/) that you want users to be able to do, such as `"get"`, `"list"`, `"describe"`, `"create"`, or `"delete"`.</td>
          </tr>
          </tbody>
        </table>

    2. Create the role or cluster role in your cluster.

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. Verify that the role or cluster role is created.
      * Role:
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * Cluster role:
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. Bind users to the role or cluster role.

    1. Create a `.yaml` file to bind users to your role or cluster role. Note the unique URL to use for each subject's name.

        ```yaml
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: IAM#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
        <caption>Understanding the YAML components</caption>
          <col width="25%">
          <thead>
          <th>Parameter</th>
          <th>Description</th>
          </thead>
          <tbody>
          <tr>
          <td><code>kind</code></td>
          <td><ul><li>Specify `RoleBinding` for a namespace-specific `Role` or `ClusterRole`.</li><li>Specify `ClusterRoleBinding` for a cluster-wide `ClusterRole`.</li></ul></td>
          </tr>
          <tr>
          <td><code>apiVersion</code></td>
          <td><ul><li>For clusters that run Kubernetes 1.8 or later, use `rbac.authorization.k8s.io/v1`. </li><li>For earlier versions, use `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
          </tr>
          <tr>
          <td><code>metadata.namespace</code></td>
          <td><ul><li>For kind `RoleBinding`: Specify the Kubernetes namespace to which access is granted.</li><li>For kind `ClusterRoleBinding`: don't use the `namespace` field.</li></ul></td>
          </tr>
          <tr>
          <td><code>metadata.name</code></td>
          <td>Name the role binding or cluster role binding.</td>
          </tr>
          <tr>
          <td><code>subjects.kind</code></td>
          <td>Specify the kind as one of the following:
          <ul><li>`User`: Bind the RBAC role or cluster role to an individual user in your account.</li>
          <li>`Group`: Bind the RBAC role or cluster role to an [{{site.data.keyword.cloud_notm}} IAM access group](/docs/account?topic=account-groups#groups) in your account.</li>
          <li>`ServiceAccount`: Bind the RBAC role or cluster role to a service account in a namespace in your cluster.</li></ul></td>
          </tr>
          <tr>
          <td><code>subjects.name</code></td>
          <td><ul><li>For `User`: Append the individual user's email address to `IAM#` as follows: <code>IAM#user@email.com</code>.</li>
          <li>For `Group`: Specify the name of the [{{site.data.keyword.cloud_notm}} IAM access group](/docs/account?topic=account-groups#groups) in your account.</li>
          <li>For `ServiceAccount`: Specify the service account name.</li></ul></td>
          </tr>
          <tr>
          <td><code>subjects.apiGroup</code></td>
          <td><ul><li>For `User` or `Group`: use `rbac.authorization.k8s.io`.</li>
          <li>For `ServiceAccount`: don't include this field.</li></ul></td>
          </tr>
          <tr>
          <td><code>subjects.namespace</code></td>
          <td>For `ServiceAccount` only: Specify the name of the Kubernetes namespace that the service account is deployed to.</td>
          </tr>
          <tr>
          <td><code>roleRef.kind</code></td>
          <td>Enter the same value as the `kind` in the role `.yaml` file: `Role` or `ClusterRole`.</td>
          </tr>
          <tr>
          <td><code>roleRef.name</code></td>
          <td>Enter the name of the role `.yaml` file.</td>
          </tr>
          <tr>
          <td><code>roleRef.apiGroup</code></td>
          <td>Use `rbac.authorization.k8s.io`.</td>
          </tr>
          </tbody>
        </table>

    2. Create the role binding or cluster role binding resource in your cluster.

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  Verify that the binding is created.

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

3. Optional: To enforce the same level of user access in other namespaces, you can copy the role bindings for those roles or cluster roles to other namespaces.
    1. Copy the role binding from one namespace to another namespace.
        ```
        kubectl get rolebinding <role_binding_name> -o yaml | sed 's/<namespace_1>/<namespace_2>/g' | kubectl -n <namespace_2> create -f -
        ```
        {: pre}

        For example, to copy the `custom-role` role binding from the `default` namespace to the `testns` namespace:
        ```
        kubectl get rolebinding custom-role -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
        ```
        {: pre}

    2. Verify that the role binding is copied. If you added an {{site.data.keyword.cloud_notm}} IAM access group to the role binding, each user in that group is added individually, not as an access group ID.
        ```
        kubectl get rolebinding -n <namespace_2>
        ```
        {: pre}

Now that you created and bound a custom Kubernetes RBAC role or cluster role, follow up with users. Ask them to test an action that they have permission to complete due to the role, such as deleting a pod.

<br />

## Extending existing permissions by aggregating cluster roles
{: #rbac_aggregate}

You can extend your users' existing permissions by aggregating, or combining, cluster roles with other cluster roles. When you assign a user an {{site.data.keyword.cloud_notm}} service access role, the user is added to a [corresponding Kubernetes RBAC cluster role](/docs/containers?topic=containers-access_reference#service). However, you might want to allow certain users to perform additional operations.
{: shortdesc}

For example, a user with the namespace-scoped `admin` cluster role cannot use the `kubectl top pods` command to view pod metrics for all the pods in the namespace. You might aggregate a cluster role so that users in the `admin` cluster role are authorized to run the `top pods` command. For more information, [see the Kubernetes docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#aggregated-clusterroles){: external}.

**What are some common operations that I might want to extend permissions for a default cluster role?**

Review [the operations that each default RBAC cluster role permits](/docs/containers?topic=containers-access_reference#rbac_ref) to get a good idea of what your users can do, and then compare the permitted operations to what you want them to be able to do.

If your users in the same cluster role encounter errors similar to the following for the same type of operation, you might want to extend the cluster role to include this operation.

```
Error from server (Forbidden): pods.metrics.k8s.io is forbidden: User "IAM#myname@example.com" cannot list resource "pods" in API group "metrics.k8s.io" in the namespace "mynamespace"
```
{: screen}

**To aggregate cluster roles**:

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Create a cluster role YAML file. In the `labels` section, specify the existing cluster role that you want to aggregate permissions to. The following example extends the predefined `admin` cluster role to allow users to run `kubectl top pods`. For more examples, [see the Kubernetes docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#aggregated-clusterroles){: external}.
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: view-pod-metrics
      labels:
        rbac.authorization.k8s.io/aggregate-to-admin: "true"
    rules:
    - apiGroups:
      - "metrics.k8s.io"
      resources:
      - pods
      verbs:
      - list
    ```
    {: codeblock}

    <table summary="The columns are read from left to right. The first column has the parameter of the YAML file. The second column describes the parameter.">
    <caption>Understanding the YAML components</caption>
      <col width="25%">
      <thead>
      <th>Parameter</th>
      <th>Description</th>
      </thead>
      <tbody>
      <tr>
      <td><code>metadata.name</code></td>
      <td>Enter a name for the cluster role. **Do not** use the predefined cluster role names: `view`, `edit`, `admin`, and `cluster-admin`.</td>
      </tr>
      <tr>
      <td><code>metadata.labels</code></td>
      <td>Add a label that matches the cluster role that you want to aggregate to in the format `rbac.authorization.k8s.io/aggregate-to-<cluster_role>: "true"`. The labels for the predefined cluster roles are as follows.<ul>
      <li>IAM **Manager** service access role, scoped to a namespace: `rbac.authorization.k8s.io/aggregate-to-admin: "true"`</li>
      <li>IAM **Writer** service access role: `rbac.authorization.k8s.io/aggregate-to-edit: "true"`</li>
      <li>IAM **Reader** service access role: `rbac.authorization.k8s.io/aggregate-to-view: "true"`</li></ul></td>
      </tr>
      <tr>
      <td><code>rules.apiGroups</code></td>
      <td>Specify the Kubernetes [API groups ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/using-api/api-overview/#api-groups) that you want users to be able to interact with, such as `"apps"`, `"batch"`, or `"extensions"`. For access to the core API group at REST path `api/v1`, leave the group blank: `[""]`.</td>
      </tr>
      <tr>
      <td><code>rules.resources</code></td>
      <td>Specify the Kubernetes [resource types ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) to which you want to grant access, such as `"daemonsets"`, `"deployments"`, `"events"`, or `"ingresses"`.</td>
      </tr>
      <tr>
      <td><code>rules.verbs</code></td>
      <td>Specify the types of [actions ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubectl.docs.kubernetes.io/) that you want users to be able to do, such as `"get"`, `"list"`, `"describe"`, `"create"`, or `"delete"`.</td>
      </tr>
      </tbody>
    </table>
2.  Create the cluster role in your cluster. Any users that have a role binding to the `admin` cluster role now have the additional permissions from the `view-pod-metrics` cluster role.
    ```
    kubectl apply -f <cluster_role_file.yaml>
    ```
    {: pre}
3.  Follow up with users that have the `admin` cluster role. Ask them to [refresh their cluster configuration](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure) and test the action, such as `kubectl top pods`.

<br />


## Checking user permissions
{: #checking-perms}

Before you complete a task, you might want to check that you have the appropriate permissions in {{site.data.keyword.cloud}} Identity and Access Management (IAM).
{: shortdesc}

### Checking IAM platform and service access roles
{: #checking-iam}

Check your access policies that are assigned by IAM platform and service access roles.
{: shortdesc}

**From the UI**:
1.  Log in to the [{{site.data.keyword.cloud_notm}} IAM console](https://cloud.ibm.com/iam){: external}.
2.  From the navigation menu, click the **Users** tab.
3.  In the table, click the user with the tag `self` for yourself or the user that you want to check.
4.  Click the **Access policies** tab.
5.  Review the **Resource attributes** column for a short description of the access. Click the number tag to view all the allowed actions for the role.

    Service access roles are synchronized with Kubernetes RBAC roles within your cluster. If you have a service access role, you might want to [verify your RBAC role](#checking-rbac), too.
    {: tip}

6.  To review what the roles and allowed actions permit, see the following topics.
    *   [IAM roles and actions](/docs/account?topic=account-iam-service-roles-actions)
    *   [{{site.data.keyword.containerlong_notm}} user access permissions](/docs/containers?topic=containers-access_reference)
7.  To change or assign new access policies, see [Assigning {{site.data.keyword.containerlong_notm}} roles](#add_users).

<br>

**From the CLI**:

1.  Log in to your {{site.data.keyword.cloud_notm}} account. If you have a federated ID, include the `--sso` flag.
    ```
    ibmcloud login -r [--sso]
    ```
    {: pre}
2.  Find the **User ID** of the user whose permissions you want to check.
    ```
    ibmcloud account users
    ```
    {: pre}
3.  Check the IAM access policies of the user.
    ```
    ibmcloud iam user-policies <user_id>
    ```
    {: pre}

    Service access roles are synchronized with Kubernetes RBAC roles within your cluster. If you have a service access role, you might want to [verify your RBAC role](#checking-rbac), too.
    {: tip}

4.  To review what the roles and allowed actions permit, see the following topics.
    *   [IAM roles and actions](/docs/account?topic=account-iam-service-roles-actions)
    *   [{{site.data.keyword.containerlong_notm}} user access permissions](/docs/containers?topic=containers-access_reference)
5.  To change or assign new access policies, see [Assigning {{site.data.keyword.containerlong_notm}} roles](#add_users_cli).

### Checking RBAC roles
{: #checking-rbac}

Verify your custom RBAC or synchronized IAM service access to RBAC roles in your {{site.data.keyword.containerlong_notm}} cluster.
{: shortdesc} 

**From the UI**:
1.  Log in to the [Kubernetes clusters console](https://cloud.ibm.com/kubernetes/clusters){: external}.
2.  Click the cluster with the RBAC roles that you want to check.
3.  Click the **Kubernetes Dashboard**. 
    
    If you have a private network only cluster, you might not be able to open the dashboard unless you are on a VPN. See [Accessing clusters through the private cloud service endpoint](/docs/containers?topic=containers-access_cluster#access_private_se).
    {: note}

4.  From the **Cluster** section, review the **Cluster Role Bindings**, **Cluster Roles**, **Role Bindings**, and **Roles**.

<br>

**From the CLI**:

1.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
2.  Check that the user is added to the RBAC role. Users are not added to a role binding if they have a higher permission. For example, if users have a cluster role and are in a cluster role binding, they are not added to each individual namespace role binding as well.

    You must be a cluster administrator (**Manager** service access role in all namespaces) to check role bindings and cluster role bindings.
    {: note}

    *   Reader:
        ```
        kubectl get rolebinding ibm-view -o yaml -n <namespace>
        ```
        {: pre}
    *   Writer:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n <namespace>
        ```
        {: pre}
    *   Manager, scoped to a namespace:
        ```
        kubectl get rolebinding ibm-operate -o yaml -n <namespace>
        ```
        {: pre}
    *   Manager, all namespaces:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

    **Example output**: If you assign user `user@email.com` and access group `team1` the **Reader** service access role, and then run `kubectl get rolebinding ibm-view -o yaml -n default`, you get the following example output.

    ```
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      creationTimestamp: 2018-05-23T14:34:24Z
      name: ibm-view
      namespace: default
      resourceVersion: "8192510"
      selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-view
      uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: view
    subjects:
    - apiGroup: rbac.authorization.k8s.io
      kind: User
      name: IAM#user@email.com
    - apiGroup: rbac.authorization.k8s.io
      kind: group
      name: team1
    ```
    {: screen}

### Checking infrastructure roles
{: #checking-infra}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> Check your {{site.data.keyword.cloud_notm}} classic infrastructure roles. For more information, see [Understanding access to the infrastructure portfolio](/docs/containers?topic=containers-access-creds#understand_infra).
{: shortdesc}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> VPC infrastructure permissions are managed with [IAM platform and service access roles](#checking-iam).
{: note}

If you are an administrator for the region and resource group, you might want to [check if the user's credentials are used for infrastructure permissions](#removing_check_infra), especially before removing the user.
{: tip}

**From the UI**:
1.  Log in to the [{{site.data.keyword.cloud_notm}} IAM console](https://cloud.ibm.com/iam){: external}.
2.  From the navigation menu, click the **Users** tab.
3.  In the table, click the user with the tag `self` for yourself or the user that you want to check.
4.  Click the **Classic infrastructure** tab.
5.  Review each of the classic infrastructure tabs.
    1.  **Permissions**: Expand the categories to review the permissions that the user has.
    2.  **Devices**: Review the devices that the user has permissions to. A common issue is when a user has administrator permissions but the `Enable future access` was not checked so whenever a new device is ordered, the user cannot administer the device.
    3.  **VPN subnets**: The subnets permission is important if the user must administer the subnets for the cluster.
6.  To review what the roles and allowed actions permit, see the following topics.
    *   [Account classic infrastructure permissions](/docs/account?topic=account-infrapermission)
    *   [{{site.data.keyword.containerlong_notm}} classic infrastructure roles](/docs/containers?topic=containers-access_reference#infra)
7.  To change or assign new access policies, see [Customizing infrastructure permissions](/docs/containers?topic=containers-access-creds#infra_access).

<br>

**From the CLI**:

1.  Log in to your {{site.data.keyword.cloud_notm}} account. If you have a federated ID, include the `--sso` flag.
    ```
    ibmcloud login -r [--sso]
    ```
    {: pre}
2.  List the users in your classic infrastructure account and note the **id** of the user whose credentials are set manually or by the API key.
    ```
    ibmcloud sl user list
    ```
    {: pre}
3.  List the current classic infrastructure permissions that the user has.
    ```
    ibmcloud sl user permissions <user_id>
    ```
    {: pre}
4.  To review what the roles and allowed actions permit, see the following topics.
    *   [Account classic infrastructure permissions](/docs/account?topic=account-infrapermission)
    *   [{{site.data.keyword.containerlong_notm}} classic infrastructure roles](/docs/containers?topic=containers-access_reference#infra)
5.  To change or assign new access policies, see [Customizing infrastructure permissions](/docs/containers?topic=containers-access-creds#infra_access).



## Removing user permissions
{: #removing}

If a user no longer needs specific access permissions, or if the user is leaving your organization, the {{site.data.keyword.cloud_notm}} account owner can remove that user's permissions.
{: shortdesc}

### Checking if the user's credentials are used for infrastructure permissions
{: #removing_check_infra}

Before you remove a user's specific access permissions or remove a user from your account completely, ensure that the user's infrastructure credentials are not used to set the API key or for the `ibmcloud ks credential set` command. Otherwise, the other users in the account might lose access to the IBM Cloud infrastructure portal and infrastructure-related commands might fail.
{: shortdesc}

To avoid this issue for future users, consider using a functional ID user for the API key owner instead of a personal user. In case the person leaves the team, the functional ID user remains the API key owner.
{: tip}

1. Target your CLI context to a region and resource group where you have clusters.
    ```
    ibmcloud target -g <resource_group_name> -r <region>
    ```
    {: pre}

2. Check the owner of the API key or infrastructure credentials set for that region and resource group.
    * If you use the [API key to access the IBM Cloud infrastructure portfolio](/docs/containers?topic=containers-access-creds#default_account):
        ```
        ibmcloud ks api-key info --cluster <cluster_name_or_id>
        ```
        {: pre}
    * If you set [infrastructure credentials to access the IBM Cloud infrastructure portfolio](/docs/containers?topic=containers-access-creds#credentials):
        ```
        ibmcloud ks credential get --region <region>
        ```
        {: pre}

3.  **API key**: If the user's username is returned, use another user's credentials to set the API key.
    1.  [Invite a functional ID user](/docs/account?topic=account-iamuserinv) to your {{site.data.keyword.cloud_notm}} account to use to set the API key infrastructure credentials, instead of a personal user. In case a person leaves the team, the functional ID user remains the API key owner.
    2.  [Ensure that the functional ID user who sets the API key has the correct permissions](/docs/containers?topic=containers-access-creds#owner_permissions).
    3.  Log in as the functional ID.
        ```
        ibmcloud login
        ```
        {: pre}
    4.  Change the infrastructure credentials to the functional ID user.
        ```
        ibmcloud ks api-key reset --region <region>
        ```
        {: pre}
    5.  Refresh the clusters in the region to pick up on the new API key configuration.
        ```
        ibmcloud ks cluster master refresh -c <cluster_name_or_ID>
        ```
        {: pre}
4.  **Infrastructure account**: If the user's username is returned as the owner of the infrastructure account, migrate your existing clusters to a different infrastructure account before removing the user. For each cluster that the user created, follow these steps:
    1. Check which infrastructure account the user used to provision the cluster.
        1.  In the **Worker Nodes** tab, select a worker node and note its **ID**.
        2.  Open the menu ![Menu icon](../icons/icon_hamburger.svg "Menu icon") and click **Classic Infrastructure**.
        3.  From the infrastructure navigation pane, click **Devices > Device List**.
        4.  Search for the worker node ID that you previously noted.
        5.  If you do not find the worker node ID, the worker node is not provisioned into this infrastructure account. Switch to a different infrastructure account and try again.
    2. Determine what happens to the infrastructure account that the user used to provision the clusters after the user leaves.
        * If the user does not own the infrastructure account, then other users have access to this infrastructure account and it persists after the user leaves. You can continue to work with these clusters in your account. Make sure that at least one other user has the [**Administrator** platform access role](#add_users) for the clusters.
        * If the user owns the infrastructure account, then the infrastructure account is deleted when the user leaves. You cannot continue to work with these clusters. To prevent the cluster from becoming orphaned, the user must delete the clusters before the user leaves. If the user has left but the clusters were not deleted, you must use the `ibmcloud ks credential set` command to change your infrastructure credentials to the account that the cluster worker nodes are provisioned in, and delete the cluster. For more information, see [Unable to modify or delete infrastructure in an orphaned cluster](/docs/containers?topic=containers-worker_infra_errors#orphaned).
5. Repeat these steps for each combination of resource groups and regions where you have clusters.

### Removing a user from your account
{: #remove_user}

If a user in your account is leaving your organization, you must remove permissions for that user carefully to ensure that you do not orphan clusters or other resources. After you remove permissions, you can remove the user from your {{site.data.keyword.cloud_notm}} account.
{: shortdesc}

1.  [Check that the user's infrastructure credentials are not used](#removing_check_infra) for any {{site.data.keyword.containerlong_notm}} resources.
2.  If you have other service instances in your {{site.data.keyword.cloud_notm}} account that the user might have provisioned, check the documentation for those services for any steps that you must complete before you remove the user from the account.
3.  [Remove the user from the {{site.data.keyword.cloud_notm}} account](/docs/account?topic=account-remove). When you remove a user, the user's assigned {{site.data.keyword.cloud_notm}} IAM platform access roles, Cloud Foundry roles, and IBM Cloud infrastructure roles are automatically removed.
4.  When {{site.data.keyword.cloud_notm}} IAM platform permissions are removed, the user's permissions are also automatically removed from the associated predefined RBAC roles. However, if you created custom RBAC roles or cluster roles, [remove the user from those RBAC role bindings or cluster role bindings](#remove_custom_rbac).<p class="note">The {{site.data.keyword.cloud_notm}} IAM permission removal process is asynchronous and can take some time to complete.</p>
5. Optional: If the user had admin access to your cluster, you can [rotate your cluster's certificate authority (CA) certificates](/docs/containers?topic=containers-security#cert-rotate).

### Removing specific permissions
{: #remove_permissions}

If you want to remove specific permissions for a user, you can remove individual access policies that have been assigned to the user.
{: shortdesc}

Before you begin, [check that the user's infrastructure credentials are not used](#removing_check_infra) for any {{site.data.keyword.containerlong_notm}} resources. After checking, you can remove:
* [a user from an access group](/docs/account?topic=account-assign-access-resources)
* [a user's {{site.data.keyword.cloud_notm}} IAM platform and associated RBAC permissions](#remove_iam_rbac)
* [a user's custom RBAC permissions](#remove_custom_rbac)
* [a user's Cloud Foundry permissions](#remove_cloud_foundry)
* [a user's infrastructure permissions](#remove_infra)

#### Remove {{site.data.keyword.cloud_notm}} IAM platform permissions and the associated pre-defined RBAC permissions
{: #remove_iam_rbac}

1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external}. From the menu bar, select **Manage > Access (IAM)**.
2. Click the **Users** page, and then click the name of the user that you want to remove permissions from.
3. In the table entry for the user, click the **Actions menu** ![Action menu icon](../icons/action-menu-icon.svg "Action menu icon") **> Remove user**.
5. When {{site.data.keyword.cloud_notm}} IAM platform permissions are removed, the user's permissions are also automatically removed from the associated predefined RBAC roles. To update the RBAC roles with the changes, run `ibmcloud ks cluster config`. However, if you created [custom RBAC roles or cluster roles](#rbac), you must remove the user from the `.yaml` files for those RBAC role bindings or cluster role bindings. See steps to remove custom RBAC permissions in the next section.

#### Remove custom RBAC permissions
{: #remove_custom_rbac}

If you do not need custom RBAC permissions anymore, you can remove them.
{: shortdesc}

1. Open the `.yaml` file for the role binding or cluster role binding that you created.
2. In the `subjects` section, remove the section for the user.
3. Save the file.
4. Apply the changes in the role binding or cluster role binding resource in your cluster.
    ```
    kubectl apply -f my_role_binding.yaml
    ```
    {: pre}

#### Remove Cloud Foundry permissions
{: #remove_cloud_foundry}

To remove all of a user's Cloud Foundry permissions, you can remove the user's organization roles. If you want to remove only a user's ability, for example, to bind services in a cluster, then remove only the user's space roles.
{: shortdesc}

1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/). From the menu bar, select **Manage > Access (IAM)**.
2. Click the **Users** page, and then click the name of the user that you want to remove permissions from.
3. Click the **Cloud Foundry access** tab.
    * To remove the user's space role:
        1. Expand the table entry for the organization that the space is in.
        2. In the table entry for the space role, click the actions menu and select **Edit space role**.
        3. Delete a role by clicking the close button.
        4. To remove all space roles, select **No space role** in the drop-down list.
        5. Click **Save role**.
    * To remove the user's organization role:
        1. In the table entry for the organization role, click the actions menu and select **Edit organization role**.
        3. Delete a role by clicking the close button.
        4. To remove all organization roles, select **No organization role** in the drop-down list.
        5. Click **Save role**.

#### Remove classic infrastructure permissions
{: #remove_infra}

You can remove IBM Cloud infrastructure permissions for a user by using the {{site.data.keyword.cloud_notm}} console.
{: shortdesc}

Classic infrastructure permissions apply only to classic clusters. For VPC clusters, see [Granting user permissions for VPC resources](/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources).
{: note}

1. Log in to the [{{site.data.keyword.cloud_notm}} console](https://cloud.ibm.com/){: external}. From the menu bar, select **Manage > Access (IAM)**.
2. Click the **Users** page, and then click the name of the user that you want to remove permissions from.
3. Click the **Classic infrastructure** tab, then click the **Permissions, Devices, or VPN subnets** tabs.
4. In each tab, deselect specific permissions.
5. To save your changes, click **Set** and **Save**. Permissions are downgraded after a few minutes.