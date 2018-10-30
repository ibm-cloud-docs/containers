---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-30"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Assigning cluster access
{: #users}

As a cluster administrator, you can define access policies for your {{site.data.keyword.containerlong}} cluster to create different levels of access for different users. For example, you can authorize certain users to work with cluster infrastructure resources and others to deploy only containers.
{: shortdesc}

## Understanding access policies and roles
{: #access_policies}

Access policies determine the level of access that users in your {{site.data.keyword.Bluemix_notm}} account have to resources across the {{site.data.keyword.Bluemix_notm}} platform. A policy assigns a user one or more roles that define the scope of access to a single service or to a set of services and resources organized together in a resource group. Each service in {{site.data.keyword.Bluemix_notm}} might require its own set of access policies.
{: shortdesc}

As you develop your plan to manage user access, consider the following general steps:
1.  [Pick the right access policy and role for your users](#access_roles)
2.  [Assign access roles to individual or groups of users in IAM](#iam_individuals_groups)
3.  [Scope user access to cluster instances or resource groups](#resource_groups)

After you understand how roles, users, and resources in your account can be managed, check out [Setting up access to your cluster](#access-checklist) for a checklist of how to configure access.

### Pick the right access policy and role for your users
{: #access_roles}

You must define access policies for every user that works with {{site.data.keyword.containerlong_notm}}. The scope of an access policy is based on a user's defined role or roles, which determine the actions the user can perform. Some policies are pre-defined but others can be customized. The same policy is enforced whether the user makes the request from the {{site.data.keyword.containerlong_notm}} GUI or through the CLI, even when the actions are completed in IBM Cloud infrastructure (SoftLayer).
{: shortdesc}

Learn about the different types of permissions and roles, which role can perform each action, and how the roles relate to each other.

To see the specific {{site.data.keyword.containerlong_notm}} permissions by each role, check out the [User access permissions](cs_access_reference.html) reference topic.
{: tip}

<dl>

<dt><a href="#platform">IAM platform</a></dt>
<dd>{{site.data.keyword.containerlong_notm}} uses {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) roles to grant users access to the cluster. IAM platform roles determine the actions that users can perform on a cluster. You can set the policies for these roles by region. Every user who is assigned an IAM platform role is also automatically assigned a corresponding RBAC role in the `default` Kubernetes namespace. Additionally, IAM platform roles authorize you to perform infrastructure actions on the cluster, but do not grant access to the IBM Cloud infrastructure (SoftLayer) resources. Access to the IBM Cloud infrastructure (SoftLayer) resources is determined by the [API key that is set for the region](#api_key).</br></br>
Example actions that are permitted by IAM platform roles are creating or removing clusters, binding services to a cluster, or adding extra worker nodes.</dd>
<dt><a href="#role-binding">RBAC</a></dt>
<dd>In Kubernetes, role-based access control (RBAC) is a way of securing the resources inside your cluster. RBAC roles determine the Kubernetes actions that users can perform on those resources. Every user who is assigned an IAM platform role is automatically assigned a corresponding RBAC cluster role in the `default` Kubernetes. This RBAC cluster role is applied either in the default namespace or in all namespaces, depending on the IAM platform role that you choose.</br></br>
Example actions that are permitted by RBAC roles are creating objects such as pods or reading pod logs.</dd>
<dt><a href="#api_key">Infrastructure</a></dt>
<dd>Infrastructure roles enable access to your IBM Cloud infrastructure (SoftLayer) resources. Set up a user with **Super User** infrastructure role, and store this user's infrastructure credentials in an API key. Then, set the API key in each region that you want to create clusters in. After you set up the API key, other users that you grant access to {{site.data.keyword.containerlong_notm}} do not need infrastructure roles as the API key is shared for all users within the region. Instead, IAM platform roles determine the infrastructure actions that users are allowed to perform. If you don't set up the API key with full <strong>Super User</strong> infrastructure or you need to grant specific device access to users, you can [customize infrastructure permissions](#infra_access). </br></br>
Example actions that are permitted by infrastructure roles are viewing the details of cluster worker node machines or editing networking and storage resources.</dd>
<dt>Cloud Foundry</dt>
<dd>Not all services can be managed with {{site.data.keyword.Bluemix_notm}} IAM. If you're using one of these services, you can continue to use Cloud Foundry user roles to control access to those services. Cloud Foundry roles grant access to organizations and spaces within the account. To see the list of Cloud Foundry-based services in {{site.data.keyword.Bluemix_notm}}, run <code>ibmcloud service list</code>.</br></br>
Example actions that are permitted by Cloud Foundry roles are creating a new Cloud Foundry service instance or binding a Cloud Foundry service instance to a cluster. To learn more, see the available [org and space roles](/docs/iam/cfaccess.html) or the steps for [managing Cloud Foundry access](/docs/iam/mngcf.html) in the IAM documentation.</dd>
</dl>

### Assign access roles to individual or groups of users in IAM
{: #iam_individuals_groups}

When you set IAM policies, you can assign roles to an individual user or to a group of users.
{: shortdesc}

<dl>
<dt>Individual users</dt>
<dd>You might have a specific user that needs more or less permissions than the rest of your team. You can customize permissions on an individual basis so that each person has the permissions that they need to complete their tasks. You can assign more than one IAM role to each user.</dd>
<dt>Multiple users in an access group</dt>
<dd>You can create a group of users and then assign permissions to that group. For example, you can group all team leaders and assign administrator access to the group. Then, you can group all developers and assign only write access to that group. You can assign more than one IAM role to each access group. When you assign permissions to a group, any user that is added or removed from that group is affected. If you add a user to the group, then they also have the additional access. If they are removed, their access is revoked.</dd>
</dl>

IAM roles can't be assigned to a service account. Instead, you can directly [assign RBAC roles to service accounts](#rbac).
{: tip}

You must also specify whether users have access to one cluster in a resource group, all clusters in a resource group, or all clusters in all resource groups in your account.

### Scope user access to cluster instances or resource groups
{: #resource_groups}

In IAM, you can assign user access roles to resource instances or resource groups.
{: shortdesc}

When you create your {{site.data.keyword.Bluemix_notm}} account, the default resource group is created automatically. If you do not specify a resource group when you create the resource, resource instances (clusters) belong to the default resource group. If you want to add a resource group in your account, see [Best practices for setting up your account ![External link icon](../icons/launch-glyph.svg "External link icon")](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications) and [Setting up your resource groups](/docs/resources/bestpractice_rgs.html#setting-up-your-resource-groups).

<dl>
<dt>Resource instance</dt>
  <dd><p>Each {{site.data.keyword.Bluemix_notm}} service in your account is a resource that has instances. The instance differs by service. For example, in {{site.data.keyword.containerlong_notm}}, the instance is a cluster, but in {{site.data.keyword.cloudcerts_long_notm}}, the instance is a certificate. By default, resources also belong to the default resource group in your account. You can assign users an access role to a resource instance for the following scenarios.
  <ul><li>All IAM services in your account, including all clusters in {{site.data.keyword.containerlong_notm}} and images in {{site.data.keyword.registrylong_notm}}.</li>
  <li>All instances within a service, such as all the clusters in {{site.data.keyword.containerlong_notm}}.</li>
  <li>All instances within a region of a service, such as all the clusters in the **US South** region of {{site.data.keyword.containerlong_notm}}.</li>
  <li>To an individual instance, such as one cluster.</li></ul></dd>
<dt>Resource group</dt>
  <dd><p>You can organize your account resources in customizable groupings so that you can quickly assign individual or groups of users access to more than one resource at a time. Resource groups can help operators and administrators filter resources to view their current usage, troubleshoot issues, and manage teams.</p>
  <p>**Important**: If you have other services in your {{site.data.keyword.Bluemix_notm}} account that you want to use with your cluster, the services and your cluster must be in the same resource group. A resource can be created in only one resource group that you can't change afterward. If you create a cluster in the wrong resource group, you must delete the cluster and recreate it in the correct resource group.</p>
  <p>If you plan to use [{{site.data.keyword.monitoringlong_notm}} for metrics](cs_health.html#view_metrics), consider giving clusters unique names across resource groups and regions in your account to avoid metrics naming conflicts. You cannot rename a cluster.</p>
  <p>You can assign users an access role to a resource group for the following scenarios. Note that unlike resource instances, you cannot grant access to an individual instance within a resource group.</p>
  <ul><li>All IAM services in the resource group, including all clusters in {{site.data.keyword.containerlong_notm}} and images in {{site.data.keyword.registrylong_notm}}.</li>
  <li>All instances within a service in the resource group, such as all the clusters in {{site.data.keyword.containerlong_notm}}.</li>
  <li>All instances within a region of a service in the resource group, such as all the clusters in the **US South** region of {{site.data.keyword.containerlong_notm}}.</li></ul></dd>
</dl>

<br />


## Setting up access to your cluster
{: #access-checklist}

After you [understand how roles, users, and resources in your account](#access_policies) can be managed, use the following checklist to configure user access in your cluster.
{: shortdesc}

1. [Set the API key](#api_key) for all the regions and resource groups that you want to create clusters in.
2. Invite users to your account and [assign them IAM roles](#platform) for the {{site.data.keyword.containerlong_notm}}. 
3. To allow users to bind services to the cluster or to view logs that are forwarded from cluster logging configurations, [grant users Cloud Foundry roles](/docs/iam/mngcf.html) for the org and space that the services are deployed to or where logs are collected.
4. If you use Kubernetes namespaces to isolate resources within the cluster, [copy the Kubernetes RBAC role bindings for the **Viewer** and **Editor** IAM platform roles to other namespaces](#role-binding).
5. For any automation tooling such as in your CI/CD pipeline, set up service accounts and [assign the service accounts Kubernetes RBAC permissions](#rbac).
6. For other advanced configurations to control access to your cluster resources at the pod level, see [Configuring pod security](/docs/containers/cs_psp.html).

</br>

For more information about setting up your account and resources, try out this tutorial about the [best practices for organizing users, teams, and applications](/docs/tutorials/users-teams-applications.html#best-practices-for-organizing-users-teams-applications).
{: tip}

<br />


## Setting up the API key to enable access to the infrastructure portfolio
{: #api_key}

To successfully provision and work with clusters, you must ensure that your {{site.data.keyword.Bluemix_notm}} account is correctly set up to access the IBM Cloud infrastructure (SoftLayer) portfolio.
{: shortdesc}

**Most cases**: Your {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account already has access to the IBM Cloud infrastructure (SoftLayer) portfolio. To set up {{site.data.keyword.containerlong_notm}} access the portfolio, the **account owner** must set the API key for the region and resource group.

1. Log in to the terminal as the account owner.
    ```
    ibmcloud login [--sso]
    ```
    {: pre}

2. Target the resource group where you want to set the API key. If you do not target a resource group, the API key is set for the default resource group.
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {:pre}

3. If you're in a different region, change to the region where you want to set the API key.
    ```
    ibmcloud ks region-set
    ```
    {: pre}

4. Set the API key for the region and resource group.
    ```
    ibmcloud ks api-key-reset
    ```
    {: pre}    

5. Verify that the API key is set.
    ```
    ibmcloud ks api-key-info <cluster_name_or_ID>
    ```
    {: pre}

6. Repeat for each region and resource group that you want to create clusters in.

**Alternative options and more information**: For different ways to access the IBM Cloud infrastructure (SoftLayer) portfolio, check out the following sections.
* If you aren't sure whether your account already has access to the IBM Cloud infrastructure (SoftLayer) portfolio, see [Understanding access to the IBM Cloud infrastructure (SoftLayer) portfolio](#understand_infra).
* If the account owner is not setting the API key, [ensure that the user who sets the API key has the correct permissions](#owner_permissions).
* For more information about using your default account to set the API key, see [Accessing the infrastructure portfolio with your default {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account](#default_account).
* If you don't have a default Pay-As-You-Go account or need to use a different IBM Cloud infrastructure (SoftLayer) account, see [Accessing a different IBM Cloud infrastructure (SoftLayer) account](#credentials).

### Understanding access to the IBM Cloud infrastructure (SoftLayer) portfolio
{: #understand_infra}

Determine whether your account has access to the IBM Cloud infrastructure (SoftLayer) portfolio and learn about how {{site.data.keyword.containerlong_notm}} uses the API key to access the portfolio.
{: shortdesc}

**Does my account already have access to the IBM Cloud infrastructure (SoftLayer) portfolio?**</br>

To access the IBM Cloud infrastructure (SoftLayer) portfolio, you use an {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account. If you have a different type of account, view your options in the following table.

<table summary="The table shows the standard cluster creation options by account type. Rows are to be read from the left to right, with the account description in column one, and the options to create a standard cluster in column two.">
<caption>Standard cluster creation options by account type</caption>
  <thead>
  <th>Account description</th>
  <th>Options to create a standard cluster</th>
  </thead>
  <tbody>
    <tr>
      <td>**Lite accounts** cannot provision clusters.</td>
      <td>[Upgrade your Lite account to an {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account](/docs/account/index.html#paygo).</td>
    </tr>
    <tr>
      <td>**Pay-As-You-Go** accounts come with access to the infrastructure portfolio.</td>
      <td>You can create standard clusters. Use an API key to set up infrastructure permissions for your clusters.</td>
    </tr>
    <tr>
      <td>**Subscription accounts** are not set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio.</td>
      <td><p><strong>Option 1:</strong> [Create a new Pay-As-You-Go account](/docs/account/index.html#paygo) that is set up with access to the IBM Cloud infrastructure (SoftLayer) portfolio. When you choose this option, you have two separate {{site.data.keyword.Bluemix_notm}} accounts and billings.</p><p>If you want to continue using your Subscription account, you can use your new Pay-As-You-Go account to generate an API key in IBM Cloud infrastructure (SoftLayer). Then, you must manually set the IBM Cloud infrastructure (SoftLayer) API key for your Subscription account. Keep in mind that IBM Cloud infrastructure (SoftLayer) resources are billed through your new Pay-As-You-Go account.</p><p><strong>Option 2:</strong> If you already have an existing IBM Cloud infrastructure (SoftLayer) account that you want to use, you can manually set IBM Cloud infrastructure (SoftLayer) credentials for your {{site.data.keyword.Bluemix_notm}} account.</p><p>**Note:** When you manually link to an IBM Cloud infrastructure (SoftLayer) account, the credentials are used for every IBM Cloud infrastructure (SoftLayer) specific action in your {{site.data.keyword.Bluemix_notm}} account. You must ensure that the API key that you set has [sufficient infrastructure permissions](cs_users.html#infra_access) so that your users can create and work with clusters.</p></td>
    </tr>
    <tr>
      <td>**IBM Cloud infrastructure (SoftLayer) accounts**, no {{site.data.keyword.Bluemix_notm}} account</td>
      <td><p>[Create an {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account](/docs/account/index.html#paygo). You have two separate IBM Cloud infrastructure (SoftLayer) accounts and billing.</p><p>By default, your new {{site.data.keyword.Bluemix_notm}} account uses the new infrastructure account. To continue using the old infrastructure account, manually set the credentials.</p></td>
    </tr>
  </tbody>
  </table>

**Now that my infrastructure portfolio is set up, how does {{site.data.keyword.containerlong_notm}} access the portfolio?**</br>

{{site.data.keyword.containerlong_notm}} accesses the IBM Cloud infrastructure (SoftLayer) portfolio by using an API key. The API key stores the credentials of a user with access to an IBM Cloud infrastructure (SoftLayer) account. API keys are set by region within a resource group, and are shared by users in that region.
 
To enable all users to access the IBM Cloud infrastructure (SoftLayer) portfolio, the user whose credentials that you store in the API key must have [the **Super User** infrastructure role and the **Administrator** platform role](#owner_permissions) for {{site.data.keyword.containerlong_notm}} in you IBM Cloud account. Then, let that user perform the first admin action in a region. The user's infrastructure credentials are stored in an API key for that region. Other users within the account share the API key for accessing the infrastructure. You can then control which infrastructure actions the users can perform by assigning the appropriate [IAM platform role](#platform).

For example, if you want to create a cluster in a new region, make sure that the first cluster is created by a user with the **Super User** infrastructure role, such as the account owner. After, you can invite individual users or users in IAM access groups to that region by setting IAM platform management policies for them in that region. A user with a `Viewer` IAM platform role isn't authorized to add a worker node. Therefore, the `worker-add` action fails, even though the API key has the correct infrastructure permissions. If you change the user's IAM platform role to **Operator**, the user is authorized to add a worker node. The `worker-add` action succeeds because the user role is authorized and the API key is set correctly. You don't need to edit the user's IBM Cloud infrastructure (SoftLayer) permissions.

**What if I don't want to assign the API key owner or credentials owner the Super User infrastructure role?**</br>

For compliance, security, or billing reasons, you might not want to give the **Super User** infrastructure role to the user who sets the API key or whose credentials are set with the `ibmcloud ks credential-set` command. However, if this user doesn't have the **Super User** role, then infrastructure-related actions, such as creating a cluster or reloading a worker node, can fail. Instead of using IAM platform roles to control users' infrastructure access, you must [set specific IBM Cloud infrastructure (SoftLayer) permissions](#infra_access) for users.

**How do I set up the API key for my cluster?**</br>

It depends on what type of account that you're using to access the IBM Cloud infrastructure (SoftLayer) portfolio:
* [A default {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account](#default_account)
* [A different IBM Cloud infrastructure (SoftLayer) account that is not linked to your default {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account](#credentials)

### Ensuring that the API key or infrastructure credentials owner has the correct permissions
{: #owner_permissions}

To ensure that all infrastructure-related actions can be successfully completed in the cluster, the user whose credentials you want to set for the API key must have the proper permissions.
{: shortdesc}

1. Log in to the [{{site.data.keyword.Bluemix_notm}} console![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/).

2. To make sure that all account-related actions can be successfully performed, verify that the user has the correct IAM platform roles.
    1. Navigate to **Manage > Account > Users**.
    2. Click the name of the user who you want to set the API key or whose credentials you want to set for the API key.
    3. If the user doesn't have the **Administrator** role for all {{site.data.keyword.containerlong_notm}} clusters in all regions, [assign that platform role to the user](#platform).
    4. If the user doesn't have at least the **Viewer** role for the resource group where you want to set the API key, [assign that resource group role to the user](#platform).
    5. To create clusters, the user also needs the **Administrator** role for {{site.data.keyword.registryshort_notm}}.

3. To make sure that all infrastructure-related actions in your cluster can be successfully performed, verify that the user has the correct infrastructure access policies.
    1. From the expanding menu, select **Infrastructure**.
    2. From the menu bar, select **Account** > **Users** > **User List**.
    3. In the **API Key** column, verify that the user has an API Key, or click **Generate**.
    4. Select the user profile's name and check the user's permissions.
    5. If the user doesn't have the **Super User** role, click the **Portal Permissions** tab.
        1. Use the **Quick Permissions** drop-down list to assign the **Super User** role.
        2. Click **Set Permissions**.

### Accessing the infrastructure portfolio with your default {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account
{: #default_account}

If you have an {{site.data.keyword.Bluemix_notm}} Pay-As-You-Go account, you have access to a linked IBM Cloud infrastructure (SoftLayer) portfolio by default. The API key is used to order infrastructure resources from this IBM Cloud infrastructure (SoftLayer) portfolio, such as new worker nodes or VLANs.
{: shortdec}

You can find the current API key owner by running [`ibmcloud ks api-key-info`](cs_cli_reference.html#cs_api_key_info). If you find that you need to update the API key that is stored for a region, you can do so by running the [`ibmcloud ks api-key-reset`](cs_cli_reference.html#cs_api_key_reset) command. This command requires the {{site.data.keyword.containerlong_notm}} admin access policy and stores the API key of the user that executes this command in the account. **Note**: Be sure that you want to reset the key and understand the impact to your app. The key is used in several different places and can cause breaking changes if it's unnecessarily changed.

**Before you begin**:
- If the account owner is not setting the API key, [ensure that the user who sets the API key has the correct permissions](#owner_permissions).
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

To set the API key to access the IBM Cloud infrastructure (SoftLayer) portfolio:

1.  Set the API key for the region and resource group that the cluster is in.
    1.  Log in to the terminal with the user whose infrastructure permissions you want to use.
    2.  Target the resource group where you want to set the API key. If you do not target a resource group, the API key is set for the default resource group.
        ```
        ibmcloud target -g <resource_group_name>
        ```
        {:pre}
    3.  If you're in a different region, change to the region where you want to set the API key.
        ```
        ibmcloud ks region-set
        ```
        {: pre}
    4.  Set the user's API key for the region.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    5.  Verify that the API key is set.
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

2. [Create a cluster](cs_clusters.html). To create the cluster, the API key credentials that you set for the region and resource group are used.

### Accessing a different IBM Cloud infrastructure (SoftLayer) account
{: #credentials}

Instead of using the default linked IBM Cloud infrastructure (SoftLayer) account to order infrastructure for clusters within a region, you might want to use a different IBM Cloud infrastructure (SoftLayer) account that you already have. You can link this infrastructure account to your {{site.data.keyword.Bluemix_notm}} account by using the [`ibmcloud ks credential-set`](cs_cli_reference.html#cs_credentials_set) command. The IBM Cloud infrastructure (SoftLayer) credentials are used instead of the default Pay-As-You-Go account's credentials that are stored for the region.

**Important**: The IBM Cloud infrastructure (SoftLayer) credentials set by the `ibmcloud ks credential-set` command persist after your session ends. If you remove IBM Cloud infrastructure (SoftLayer) credentials that were manually set with the [`ibmcloud ks credential-unset`](cs_cli_reference.html#cs_credentials_unset) command, the default Pay-As-You-Go account credentials are used. However, this change in infrastructure account credentials might cause [orphaned clusters](cs_troubleshoot_clusters.html#orphaned).

**Before you begin**:
- If you are not using the account owner's credentials, [ensure that the user whose credentials you want to set for the API key has the correct permissions](#owner_permissions).
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

To set infrastructure account credentials to access the IBM Cloud infrastructure (SoftLayer) portofolio:

1. Get the infrastructure account that you want to use to access the IBM Cloud infrastructure (SoftLayer) portfolio. You have different options that depend on your [current account type](#understand_infra).

2.  Set the infrastructure API credentials with the user for the correct account.

    1.  Get the user's infrastructure API credentials. **Note**: The credentials differ from the IBMid.

        1.  From the [{{site.data.keyword.Bluemix_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/) console **Infrastructure** > **Account** > **Users** > **User List** table, click the **IBMid or Username**.

        2.  In the **API Access Information** section, view the **API Username** and **Authentication Key**.    

    2.  Set the infrastructure API credentials to use.
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

    3. Verify that the correct credentials are set.
        ```
        ibmcloud ks credential-get
        ```
        Example output:
        ```
        Infrastructure credentials for user name user@email.com set for resource group default.
        ```
        {: screen}

3. [Create a cluster](cs_clusters.html). To create the cluster, the infrastructure credentials that you set for the region and resource group are used.

4. Verify that your cluster uses the infrastructure account credentials that you set.
  1. Open the [IBM Cloud Kubernetes Service GUI ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/containers-kubernetes/clusters) and select your cluster. 
  2. In the Overview tab, look for an **Infrastructure User** field. 
  3. If you see that field, you do not use the default infrastructure credentials that come with your Pay-As-You-Go account in this region. Instead, the region is set to use the different infrastructure account credentials that you set.

<br />


## Granting users access to your cluster through IAM
{: #platform}

Set IAM platform management policies in the [GUI](#add_users) or [CLI](#add_users_cli) so that users can work with clusters in {{site.data.keyword.containerlong_notm}}. Before you begin, check out [Understanding access policies and roles](#access_policies) to review what policies are, whom you can assign policies to, and what resources can be granted policies.
{: shortdesc}

IAM roles can't be assigned to a service account. Instead, you can directly [assign RBAC roles to service accounts](#rbac).
{: tip}

### Assigning IAM roles with the GUI
{: #add_users}

Grant users access to your clusters by assigning IAM platform management roles with the GUI.
{: shortdesc}

Before you begin, verify that you're assigned the **Administrator** IAM platform role for the {{site.data.keyword.Bluemix_notm}} account in which you're working.

1. Log in to the [IBM Cloud GUI](https://console.bluemix.net/) and navigate to **Manage > Account > Users**.

2. Select users individually or create an access group of users.
    * To assign roles to an individual user:
      1. Click the name of the user that you want to set permissions for. If the user isn't shown, click **Invite users** to add them to the account.
      2. Click **Assign access**.
    * To assign roles to multiple users in an access group:
      1. In the left navigation, click **Access groups**.
      2. Click **Create** and give your group a **Name** and **Description**. Click **Create**.
      3. Click **Add users** to add people to your access group. A list of users that have access to your account is shown.
      4. Check the box next to the users that you want to add to the group. A dialog box displays.
      5. Click **Add to group**.
      6. Click **Access policies**.
      7. Click **Assign access**.

3. Assign a policy.
  * For access to all clusters in a resource group:
    1. Click **Assign access within a resource group**.
    2. Select the resource group name.
    3. From the **Services** list, select **{{site.data.keyword.containershort_notm}}**.
    4. From the **Region** list, select one or all regions.
    5. Select a **Platform access role**. To find a list of supported actions per role, see [User access permissions](/cs_access_reference.html#platform).
    6. Click **Assign**.
  * For access to one cluster in one resource group, or to all clusters in all resource groups:
    1. Click **Assign access to resources**.
    2. From the **Services** list, select **{{site.data.keyword.containershort_notm}}**.
    3. From the **Region** list, select one or all regions.
    4. From the **Service instance** list, select a cluster name or **All service instances**.
    5. In the **Select roles** section, choose an IAM platform access role. To find a list of supported actions per role, see [User access permissions](/cs_access_reference.html#platform). Note: If you assign a user the **Administrator** IAM platform role for only one cluster, you must also assign the user the **Viewer** role for all clusters in that region in the resource group.
    6. Click **Assign**.

4. If you want users to be able to work with clusters in a resource group other than the default, these users need additional access to the resource groups that clusters are in. You can assign these users at least the **Viewer** role for resource groups.
  1. Click **Assign access within a resource group**.
  2. Select the resource group name.
  3. From the **Assign access to a resource group** list, select the **Viewer** role. This role permits users to access the resource group itself, but not to resources within the group.
  4. Click **Assign**.

### Assigning IAM roles with the CLI
{: #add_users_cli}

Grant users access to your clusters by assigning IAM platform management roles with the CLI.
{: shortdesc}

**Before you begin**:

- Verify that you're assigned the `cluster-admin` IAM platform role for the {{site.data.keyword.Bluemix_notm}} account in which you're working.
- Verify that the user is added to the account. If the user is not, invite the user to your account by running `ibmcloud account user-invite <user@email.com>`.
- [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).

**To assign IAM roles to an individual user with the CLI:**

1.  Create an IAM access policy to set permissions for {{site.data.keyword.containerlong_notm}} (**`--service-name containers-kubernetes`**). You can choose Viewer, Editor, Operator, and Administrator for the IAM platform role. To find a list of supported actions per role, see [User access permissions](cs_access_reference.html#platform).
    * To assign access to one cluster in a resource group:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **Note**: If you assign a user the **Administrator** IAM platform role for only one cluster, you must also assign the user the **Viewer** role for all clusters in the region within the resource group.

    * To assign access to all clusters in a resource group:
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

    * To assign access to all clusters in all resource groups:
      ```
      ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

2. If you want users to be able to work with clusters in a resource group other than the default, these users need additional access to the resource groups that clusters are in. You can assign these users at least the **Viewer** role for resource groups. You can find the resource group ID by running `ibmcloud resource group <resource_group_name> --id`.
    ```
    ibmcloud iam user-policy-create <user-email_OR_access-group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

3. For the changes to take effect, refresh your cluster configuration.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

4. The IAM platform role is automatically applied as a corresponding [RBAC role binding or cluster role binding](#role-binding). Verify that the user is added to the RBAC role by running one of the following commands for the IAM platform role you assigned:
    * Viewer:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Administrator:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  For example, if you assign user `john@email.com` the **Viewer** IAM platform role and run `kubectl get rolebinding ibm-view -o yaml -n default`, the output looks like the following:

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
    name: https://iam.ng.bluemix.net/IAM#user@email.com
  ```
  {: screen}


**To assign IAM platform roles multiple users in an access group with the CLI:**

1. Create an access group.
    ```
    ibmcloud iam access-group-create <access_group_name>
    ```
    {: pre}

2. Add users to the access group.
    ```
    ibmcloud iam access-group-user-add <access_group_name> <user_email>
    ```
    {: pre}

3. Create an IAM access policy to set permissions for {{site.data.keyword.containerlong_notm}}. You can choose Viewer, Editor, Operator, and Administrator for the IAM platform role. To find a list of supported actions per role, see [User access permissions](/cs_access_reference.html#platform).
  * To assign access to one cluster in a resource group:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **Note**: If you assign a user the **Administrator** IAM platform role for only one cluster, you must also assign the user the **Viewer** role for all clusters in the region within the resource group.

  * To assign access to all clusters in a resource group:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

  * To assign access to all clusters in all resource groups:
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

4. If you want users to be able to work with clusters in a resource group other than the default, these users need additional access to the resource groups that clusters are in. You can assign these users at least the **Viewer** role for resource groups. You can find the resource group ID by running `ibmcloud resource group <resource_group_name> --id`.
    ```
    ibmcloud iam access-group-policy-create <access_group_name> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

    1. If you assigned access to all clusters in all resource groups, repeat this command for each resource group in the account.

5. For the changes to take effect, refresh your cluster configuration.
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

6. The IAM platform role is automatically applied as a corresponding [RBAC role binding or cluster role binding](#role-binding). Verify that the user is added to the RBAC role by running one of the following commands for the IAM platform role you assigned:
    * Viewer:
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * Editor:
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * Operator:
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * Administrator:
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  For example, if you assign the access group `team1` the **Viewer** IAM platform role and run `kubectl get rolebinding ibm-view -o yaml -n default`, the output looks like the following:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-edit
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-edit
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team1
  ```
  {: screen}

<br />




## Assigning RBAC permissions
{: #role-binding}

**What are RBAC roles and cluster roles?**</br>

RBAC roles and cluster roles define a set of permissions for how users can interact with Kubernetes resources in your cluster. A role is scoped to resources within a specific namespace, like a deployment. A cluster role is scoped to cluster-wide resources, like worker nodes, or to namespace-scoped resources that can be found in each namespace, like pods.

**What are RBAC role bindings and cluster role bindings?**</br>

Role bindings apply RBAC roles or cluster roles to a specific namespace. When you use a role binding to apply a role, you give a user access to a specific resource in a specific namespace. When you use a role binding to apply a cluster role, you give a user access to namespace-scoped resources that can be found in each namespace, like pods, but only within a specific namespace.

Cluster role bindings apply RBAC cluster roles to all namespaces in the cluster. When you use a cluster role binding to apply a cluster role, you give a user access to cluster-wide resources, like worker nodes, or to namespace-scoped resources in every namespace, like pods.

**What do these roles look like in my cluster?**</br>

Every user who is assigned a [IAM platform managment role](#platform) is automatically assigned a corresponding RBAC cluster role. These RBAC cluster roles are predefined and permit users to interact with Kubernetes resources in your cluster. Additionally, a role binding is created to apply the cluster role to a specific namespace, or a cluster role binding is created to apply the cluster role to all namespaces.

The following table describes the relationships between the IAM platform roles and the corresponding cluster roles and role bindings or cluster role bindings that are automatically created for the IAM platform roles.

<table>
  <tr>
    <th>IAM platform role</th>
    <th>RBAC cluster role</th>
    <th>RBAC role binding</th>
    <th>RBAC cluster role binding</th>
  </tr>
  <tr>
    <td>Viewer</td>
    <td><code>view</code></td>
    <td><code>ibm-view</code> in the default namespace</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Editor</td>
    <td><code>edit</code></td>
    <td><code>ibm-edit</code> in the default namespace</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Operator</td>
    <td><code>admin</code></td>
    <td>-</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Administrator</td>
    <td><code>cluster-admin</code></td>
    <td>-</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

To learn more about the actions permitted by each RBAC role, check out the [User access permissions](cs_access_reference.html#platform) reference topic.
{: tip}

**How can I manage RBAC permissions for specific namespaces in my cluster?**

If you use [Kubernetes namespaces to partition your cluster and provide isolation for workloads](cs_secure.html#container), you must assign user access to specific namespaces. When you assign a user the **Operator** or **Administrator** IAM platform roles, the corresponding `admin` and `cluster-admin` predefined cluster roles are automatically applied to the entire cluster. However, when you assign a user the **Viewer** or **Editor** IAM platform roles, the corresponding `view` and `edit` predefined cluster roles are automatically applied only in the default namespace. To enforce the same level of user access in other namespaces, you can [copy the role bindings](#rbac_copy) for those cluster roles, `ibm-view` and `ibm-edit`, to other namespaces.

**Can I create custom roles or cluster roles?**

The `view`, `edit`, `admin` and `cluster-admin` cluster roles are predefined roles that are automatically created when you assign a user the corresponding IAM platform role. To grant other Kubernetes permissions, you can [create custom RBAC permissions](#rbac).

**When do I need to use cluster role bindings and role bindings that are not tied to the IAM permissions that I set?**

You might want to authorize who can create and update pods in your cluster. With [pod security policies](https://console.bluemix.net/docs/containers/cs_psp.html#psp), you can use existing cluster role bindings that come with your cluster, or create your own.

You might also want to integrate add-ons to your cluster. For example, when you [set up Helm in your cluster](cs_integrations.html#helm), you must create a service account for Tiller in the `kube-system` namespace and a Kubernetes RBAC cluster role binding for the `tiller-deploy` pod.

### Copying an RBAC role binding to another namespace
{: #rbac_copy}

Some roles and cluster roles are applied only to one namespace. For example, the `view` and `edit` predefined cluster roles are automatically applied only in the `default` namespace. To enforce the same level of user access in other namespaces, you can copy the role bindings for those roles or cluster roles to other namespaces.
{: shortdesc}

For example, say you assign user "john@email.com" the **Editor** IAM platform management role. The predefined RBAC cluster role `edit` is automatically created in your cluster, and the `ibm-edit` role binding applies the permissions in the `default` namespace. You want "john@email.com" to also have Editor access in your development namespace, so you copy the `ibm-edit` role binding from `default` to `development`. **Note**: You must copy the role binding each time a user is added to the `view` or `edit` roles.

1. Copy the role binding from `default` to another namespace.
    ```
    kubectl get rolebinding <role_binding_name> -o yaml | sed 's/default/<namespace>/g' | kubectl -n <namespace> create -f -
    ```
    {: pre}

    For example, to copy the `ibm-edit` role binding to the `testns` namespace:
    ```
    kubectl get rolebinding ibm-edit -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
    ```
    {: pre}

2. Verify that the `ibm-edit` role binding is copied.
    ```
    kubectl get rolebinding -n <namespace>
    ```
    {: pre}

<br />


### Creating custom RBAC permissions for users, groups, or service accounts
{: #rbac}

The `view`, `edit`, `admin` and `cluster-admin` cluster roles are automatically created when you assign the corresponding IAM platform management role. Do you need your cluster access policies to be more granular than these predefined permissions allow? No problem! You can create custom RBAC roles and cluster roles.
{: shortdesc}

You can assign custom RBAC roles and cluster roles to individual users, groups of users (in clusters that run Kubernetes v1.11 or later), or service accounts. When a binding is created for a group, it affects any user that is added or removed from that group. When you add users to a group, they get the access rights of the group in addition to any individual access rights that you grant them. If they are removed, their access is revoked. **Note**: You can't add service accounts to access groups.

If you want to assign access to a process that runs in pods, such as a continuous delivery toolchain, you can use [Kubernetes ServiceAccounts ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/). To follow a tutorial that demonstrates how to set up service accounts for Travis and Jenkins and to assign custom RBAC roles to the ServiceAccounts, see the blog post [Kubernetes ServiceAccounts for use in automated systems ![External link icon](../icons/launch-glyph.svg "External link icon")](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982).

**Note**: To prevent breaking changes, do not change the predefined `view`, `edit`, `admin` and `cluster-admin` cluster roles.

**Do I create a role or a cluster role? Do I apply it with a role binding or a cluster role binding?**

* To allow a user, access group, or service account to access a resource within a specific namespace, choose one of the following combinations:
  * Create a role, and apply it with a role binding. This option is useful for controlling access to a unique resource that exists only in one namespace, like an app deployment.
  * Create a cluster role, and apply it with a role binding. This option is useful for controlling access to general resources in one namespace, like pods.
* To allow a user or an access group to access cluster-wide resources or resources in all namespaces, create a cluster role, and apply it with a cluster role binding. This option is useful for controlling access to resources that are not scoped to namespaces, like worker nodes, or resources in all namespaces in your cluster, like pods in each namespace.

Before you begin:

- Target the [Kubernetes CLI](cs_cli_install.html#cs_cli_configure) to your cluster.
- To assign access to individual users or users in an access group, ensure that the user or group has been assigned at least one [IAM platform role](#platform) at the {{site.data.keyword.containerlong_notm}} service level.

To create custom RBAC permissions:

1. Create the role or cluster role with the access that you want to assign.

    1. Create a `.yaml` file to define the role or cluster role.

        ```
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

        <table>
        <caption>Understanding the YAML components</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML components</th>
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
              <td>Specify the Kubernetes [API groups ![External link icon](../icons/launch-glyph.svg "External link icon")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) that you want users to be able to interact with, such as `"apps"`, `"batch"`, or `"extensions"`. For access to the core API group at REST path `api/v1`, leave the group blank: `[""]`.</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>Specify the Kubernetes [resource types ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) to which you want to grant access, such as `"daemonsets"`, `"deployments"`, `"events"`, or `"ingresses"`. If you specify `"nodes"`, then the kind must be `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>Specify the types of [actions ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/reference/kubectl/overview/) that you want users to be able to do, such as `"get"`, `"list"`, `"describe"`, `"create"`, or `"delete"`.</td>
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

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/IAM#user1@example.com
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

        <table>
        <caption>Understanding the YAML components</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Understanding the YAML components</th>
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
              <li>`Group`: For clusters that run Kubernetes 1.11 or later, bind the RBAC role or cluster role to an [IAM access group](/docs/iam/groups.html#groups) in your account.</li>
              <li>`ServiceAccount`: Bind the RBAC role or cluster role to a service account in a namespace in your cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>For `User`: Append the individual user's email address to one the following URLs.<ul><li>For clusters that run Kubernetes 1.11 or later: <code>https://iam.ng.bluemix.net/IAM#user_email</code></li><li>For clusters that run Kubernetes 1.10 or earlier: <code>https://iam.ng.bluemix.net/kubernetes#user_email</code></li></ul></li>
              <li>For `Group`: For clusters that run Kubernetes 1.11 or later, specify the name of the [IAM group](/docs/iam/groups.html#groups) in your account.</li>
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

Now that you created and bound a custom Kubernetes RBAC role or cluster role, follow up with users. Ask them to test an action that they have permission to complete due to the role, such as deleting a pod.

<br />




## Customizing infrastructure permissions
{: #infra_access}

When you assign the **Super User** infrastructure role to the admin who sets the API key or whose infrastructure credentials are set, other users within the account share the API key or credentials for performing infrastructure actions. You can then control which infrastructure actions the users can perform by assigning the appropriate [IAM platform role](#platform). You don't need to edit the user's IBM Cloud infrastructure (SoftLayer) permissions.
{: shortdesc}

For compliance, security, or billing reasons, you might not want to give the **Super User** infrastructure role to the user who sets the API key or whose credentials are set with the `ibmcloud ks credential-set` command. However, if this user doesn't have the **Super User** role, then infrastructure-related actions, such as creating a cluster or reloading a worker node, can fail. Instead of using IAM platform roles to control users' infrastructure access, you must set specific IBM Cloud infrastructure (SoftLayer) permissions for users.

If you have multizone clusters, your IBM Cloud infrastructure (SoftLayer) account owner needs to turn on VLAN spanning so that the nodes in different zones can communicate within the cluster. The account owner can also assign a user the **Network > Manage Network VLAN Spanning** permission so that the user can enable VLAN spanning. To check if VLAN spanning is already enabled, use the `ibmcloud ks vlan-spanning-get` [command](cs_cli_reference.html#cs_vlan_spanning_get).
{: tip}

Before you begin, make sure that you are the account owner or have **Super User** and all device access. You can't grant a user access that you don't have.

1. Log in to the [IBM Cloud GUI](https://console.bluemix.net/) and navigate to **Manage > Account > Users**.

2. Click the name of the user that you want to set permissions for.

3. Click **Assign access**, and click **Assign access to your SoftLayer account**.

4. Click the **Portal Permissions** tab to customize the user's access. The permissions that users need depend on what infrastructure resources they need to use. You have two options for assigning access:
    * Use the **Quick Permissions** drop-down list to assign one of the following predefined roles. After selecting a role, click **Set Permissions**.
        * **View Only User** gives the user permissions to view infrastructure details only.
        * **Basic User** gives the user some, but not all, infrastructure permissions.
        * **Super User** gives the user all infrastructure permissions.
    * Select individual permissions in each tab. To review permissions that are needed to perform common tasks in {{site.data.keyword.containerlong_notm}}, see [User access permissions](cs_access_reference.html#infra).

5.  To save your changes, click **Edit Portal Permissions**.

6.  In the **Device Access** tab, select the devices to grant access to.

    * In the **Device Type** drop-down list, you can grant access to **All Devices** so that users can work with both virtual and physical (bare metal hardware) machine types for worker nodes.
    * To allow users access to new devices that are created, select **Automatically grant access when new devices are added**.
    * In the table of devices, make sure that the appropriate devices are selected.

7. To save your changes, click **Update Device Access**.

Downgrading permissions? The action can take a few minutes to complete.
{: tip}

<br />


## Removing user permissions
{: #removing}

If a user no longer needs specific access permissions, or if the user is leaving your organization, the {{site.data.keyword.Bluemix_notm}} account owner can remove that user's permissions.
{: shortdesc}

**Important**: Before you remove a user's specific access permissions or remove a user from your account completely, ensure that the user's infrastructure credentials are not used to set the API key or for the `ibmcloud ks credential-set` command. Otherwise, the other users in the account might lose access to the IBM Cloud infrastructure (SoftLayer) portal and infrastructure-related commands might fail.

1. Target your CLI context to a region and resource group where you have clusters.
    ```
    ibmcloud target -g <resource_group_name> -r <region>
    ```
    {: pre}

2. Check the owner of the API key or infrastructure credentials set for that region and resource group.
    * If you use the [API key to access the IBM Cloud infrastructure (SoftLayer) portfolio](#default_account):
        ```
        ibmcloud ks api-key-info --cluster <cluster_name_or_id>
        ```
        {: pre}
    * If you set [infrastructure credentials to access the IBM Cloud infrastructure (SoftLayer) portfolio](#credentials):
        ```
        ibmcloud ks credential-get
        ```
        {: pre}

3. If the user's user name is returned, use another user's credentials to set the API key or infrastructure credentials. **Note**: If the account owner is not setting the API key, or if you are not setting the account owner's infrastructure credentials, [ensure that the user who sets the API key or whose credentials you are setting has the correct permissions](#owner_permissions).
    * To reset the API key:
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}
    * To reset the infrastructure credentials:
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4. Repeat these steps for each combination of resource groups and regions where you have clusters.

### Removing a user from your account
{: #remove_user}

If a user in your account is leaving your organization, you must remove permissions for that user carefully to ensure that you do not orphan clusters or other resources. After, you can remove the user from your {{site.data.keyword.Bluemix_notm}} account.
{: shortdesc}

Before you begin:
- [Ensure that the user's infrastructure credentials are not used to set the API key or for the `ibmcloud ks credential-set` command](#removing).
- If you have other service instances in your {{site.data.keyword.Bluemix_notm}} account that the user might have provisioned, check the documentation for those services for any steps that you must complete before you remove the user from the account.

Before the user leaves, the {{site.data.keyword.Bluemix_notm}} account owner must complete the following steps to prevent breaking changes in {{site.data.keyword.containerlong_notm}}.

1. Determine which clusters the user created.
    1.  Log in to the [{{site.data.keyword.containerlong_notm}} GUI ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/containers-kubernetes/clusters).
    2.  From the table, select your cluster.
    3.  In the **Overview** tab, look for the **Owner** field.

2. For each cluster that the user created, follow these steps:
    1. Check which infrastructure account the user used to provision the cluster.
        1.  In the **Worker Nodes** tab, select a worker node and note its **ID**.
        2.  Open the expandable menu and click **Infrastructure**.
        3.  From the infrastructure menu, click **Devices > Device List**.
        4.  Search for the worker node ID that you previously noted.
        5.  If you do not find the worker node ID, the worker node is not provisioned into this infrastructure account. Switch to a different infrastructure account and try again.
    2. Determine what happens to the infrastructure account that the user used to provision the clusters after the user leaves.
        * If the user does not own the infrastructure account, then other users have access to this infrastructure account and it persists after the user leaves. You can continue to work with these clusters in your account. Make sure at least one other user has the [**Administrator** IAM platform role](#platform) for the clusters.
        * If the user owns the infrastructure account, then the infrastructure account is deleted when the user leaves. You cannot continue to work with these clusters. To prevent the cluster from becoming orphaned, the user must delete the clusters before the user leaves. If the user has left but the clusters were not deleted, you must use the `ibmcloud ks credential-set` command to change your infrastructure credentials to the account that the cluster worker nodes are provisioned in, and delete the cluster. For more information, see [Unable to modify or delete infrastructure in an orphaned cluster](cs_troubleshoot_clusters.html#orphaned).

3. Remove the user from the {{site.data.keyword.Bluemix_notm}} account.
    1. Navigate to **Manage > Account > Users**.
    2. Click the user's username.
    3. In the table entry for the user, click the actions menu and select **Remove user**. When you remove a user, the user's assigned IAM platform roles, Cloud Foundry roles, and IBM Cloud infrastructure (SoftLayer) roles are automatically removed.

4. When IAM platform permissions are removed, the user's permissions are also automatically removed from the associated predefined RBAC roles. However, if you created custom RBAC roles or cluster roles, [remove the user from those RBAC role bindings or cluster role bindings](#remove_custom_rbac).

5. If you have a Pay-As-You-Go account that is automatically linked to your {{site.data.keyword.Bluemix_notm}} account, the user's IBM Cloud infrastructure (SoftLayer) roles are automatically removed. However, if you have a [different type of account](#understand_infra), you might need to manually remove the user from IBM Cloud infrastructure (SoftLayer).
    1. In the [IBM Cloud GUI](https://console.bluemix.net/) menu, click **Infrastructure**.
    2. Navigate to **Account > Users > User List**.
    2. Look for a table entry for the user.
        * If you don't see an entry for the user, the user has already been removed. No further action is required.
        * If you do see an entry for the user, continue to the next step.
    3. In the table entry for the user, click the Actions menu.
    4. Select **Change User Status**.
    5. In the Status list, select **Disabled**. Click **Save**.


### Removing specific permissions
{: #remove_permissions}

If you want to remove specific permissions for a user, you can remove individual access policies that have been assigned to the user.
{: shortdesc}

Before you begin, [ensure that the user's infrastructure credentials are not used to set the API key or for the `ibmcloud ks credential-set` command](#removing). After, you can remove:
* [a user from an access group](#remove_access_group)
* [a user's IAM platform and associated RBAC permissions](#remove_iam_rbac)
* [a user's custom RBAC permissions](#remove_custom_rbac)
* [a user's Cloud Foundry permissions](#remove_cloud_foundry)
* [a user's infrastructure permissions](#remove_infra)

#### Remove a user from an access group
{: #remove_access_group}

1. Log in to the [IBM Cloud GUI](https://console.bluemix.net/) and navigate to **Manage > Account > Users**.
2. Click the name of the user that you want to remove permissions from.
3. Click the **Access group** tab.
4. In the table entry for the access group, click the actions menu and select **Remove user**. When the user is removed, any roles that were assigned to the access group are removed from the user.

#### Remove IAM platform permissions and the associated pre-defined RBAC permissions
{: #remove_iam_rbac}

1. Log in to the [IBM Cloud GUI](https://console.bluemix.net/) and navigate to **Manage > Account > Users**.
2. Click the name of the user that you want to remove permissions from.
3. In the table entry for the permission that you want to remove, click the actions menu.
4. Select **Remove.**
5. When IAM platform permissions are removed, the user's permissions are also automatically removed from the associated predefined RBAC roles. To update the RBAC roles with the changes, run `ibmcloud ks cluster-config`. However, if you created [custom RBAC roles or cluster roles](#rbac), you must remove the user from the `.yaml` files for those RBAC role bindings or cluster role bindings. See steps to remove custom RBAC permissions below.

#### Remove custom RBAC permissions
{: #remove_custom_rbac}

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

To remove all of a user's Cloud Foundry permissions, you can remove the user's organization roles. If you only want to remove a user's ability, for example, to bind services in a cluster, only remove the user's space roles.

1. Log in to the [IBM Cloud GUI](https://console.bluemix.net/) and navigate to **Manage > Account > Users**.
2. Click the name of the user that you want to remove permissions from.
3. Click the **Cloud Foundry Access** tab.
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

#### Remove IBM Cloud infrastructure (SoftLayer) permissions
{: #remove_infra}

1. Log in to the [IBM Cloud GUI](https://console.bluemix.net/).
2. From the menu, click **Infrastructure**.
3. Click the user's email address.
4. Click the **Portal Permissions** tab.
5. In each tab, deselect specific permissions.
6. To save your changes, click **Edit Portal Permissions**.
7. In the **Device Access** tab, deselect specific devices.
8. To save your changes, click **Update device access**. Permissions are downgraded after a few minutes.

<br />



