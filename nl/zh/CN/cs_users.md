---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 分配集群访问权
{: #users}

作为集群管理员，您可以为 Kubernetes 集群定义访问策略，以便为不同用户创建不同级别的访问权。例如，您可以授权某些用户使用集群资源，而其他用户只能部署容器。
{: shortdesc}


## 了解访问策略和许可权
{: #access_policies}

<dl>
  <dt>是否必须设置访问策略？</dt>
    <dd>必须为使用 {{site.data.keyword.containershort_notm}} 的每个用户定义访问策略。访问策略的作用域基于用户定义的一个或多个角色，这些角色确定允许用户执行的操作。某些策略是预定义策略，但其他策略可以进行定制。无论用户是通过 {{site.data.keyword.containershort_notm}} GUI 还是通过 CLI 发出请求，都将强制执行同一策略；即便在 IBM Cloud Infrastructure (SoftLayer) 中完成这些操作也是如此。</dd>

  <dt>有哪些许可权类型？</dt>
    <dd><p><strong>平台</strong>：{{site.data.keyword.containershort_notm}} 配置为使用 {{site.data.keyword.Bluemix_notm}} 平台角色来确定个人可在集群上执行的操作。角色许可权基于彼此进行构建，这意味着`编辑者`角色具有与`查看者`角色相同的所有许可权，外加授予编辑者的许可权。可以按区域设置这些策略。这些策略必须与基础架构策略一起设置，并具有自动分配给缺省名称空间的相应 RBAC 角色。操作示例包括创建或除去集群，或者添加额外的工作程序节点。</p> <p><strong>基础架构</strong>：可以确定基础架构的访问级别，例如集群节点机器、联网或存储资源。必须将此类型的策略与 {{site.data.keyword.containershort_notm}} 平台访问策略一起设置。要了解可用角色的信息，请查看[基础架构许可权](/docs/iam/infrastructureaccess.html#infrapermission)。除了授予特定的基础架构角色外，您还必须将设备访问权授予使用基础架构的用户。
要开始分配角色，请执行[定制用户的基础架构许可权](#infra_access)中的步骤。<strong>注</strong>：确保您的 {{site.data.keyword.Bluemix_notm}} 帐户已[设置为有权访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合](cs_troubleshoot_clusters.html#cs_credentials)，以便授权用户可以根据分配的许可权在 IBM Cloud Infrastructure (SoftLayer) 帐户中执行操作。</p> <p><strong>RBAC</strong>：基于资源的访问控制 (RBAC) 是一种保护集群内部资源并决定谁可以执行哪些 Kubernetes 操作的方法。分配了平台访问策略的每个用户都会自动分配有 Kubernetes 角色。在 Kubernetes 中，[基于角色的访问控制 (RBAC) ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) 将确定用户可以对集群中的资源执行的操作。<strong>注</strong>：对于缺省名称空间，RBAC 角色会与平台角色一起自动设置。作为集群管理员，您可以针对其他名称空间[更新或分配角色](#rbac)。</p> <p><strong>Cloud Foundry</strong>：并非所有服务都可以通过 Cloud IAM 进行管理。如果使用的是无法通过 Cloud IAM 管理的其中一个服务，那么可以继续使用 [Cloud Foundry 用户角色](/docs/iam/cfaccess.html#cfaccess)来控制对服务的访问。示例操作用于绑定服务或创建新的服务实例。</p></dd>

  <dt>如何设置许可权？</dt>
    <dd><p>设置“平台”许可权时，可以为特定用户、一组用户或缺省资源组分配访问权。设置平台许可权时，会自动为缺省名称空间配置 RBAC 角色，并创建 RoleBinding。</p>
    <p><strong>用户</strong>：您可能有特定用户需要多于或少于团队其他用户的许可权。您可以分别定制许可权，以便每人都具有完成任务所需的合适许可权。</p>
    <p><strong>访问组</strong>：可以创建用户组，然后为特定组分配许可权。例如，可以将所有团队负责人分成一组，并向该组授予管理员访问权。同时，开发者组仅具有写访问权。</p>
    <p><strong>资源组</strong>：通过 IAM，可以为一组资源创建访问策略，并授予用户对此组的访问权。这些资源可以是一个 {{site.data.keyword.Bluemix_notm}} 服务的一部分，或者还可以对跨服务实例的资源（例如，{{site.data.keyword.containershort_notm}} 集群和 CF 应用程序）分组。</p> <p>**重要信息**：{{site.data.keyword.containershort_notm}} 仅支持 <code>default</code> 资源组。所有与集群相关的资源都会在 <code>default</code> 资源组中自动提供。如果 {{site.data.keyword.Bluemix_notm}} 帐户中有要用于集群的其他服务，那么这些服务也必须位于 <code>default</code> 资源组中。</p></dd>
</dl>


有些不知所措？请尝试了解有关[组织用户、团队和应用程序的最佳实践](/docs/tutorials/users-teams-applications.html)的这一教程。
{: tip}

<br />


## 访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合
{: #api_key}

<dl>
  <dt>为什么需要对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权？</dt>
    <dd>要成功供应和使用帐户中的集群，必须确保帐户已正确设置为访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。根据帐户设置，可以使用通过 `ibmcloud ks credentials-set` 命令手动设置的 IAM API 密钥或基础架构凭证。</dd>

  <dt>IAM API 密钥如何用于 Container Service？</dt>
    <dd><p>执行需要 {{site.data.keyword.containershort_notm}} 管理员访问策略的第一个操作时，会自动针对区域设置 Identity and Access Management (IAM) API 密钥。例如，某个管理用户在 <code>us-south</code> 区域中创建了第一个集群。通过执行此操作，此用户的 IAM API 密钥将存储在此区域的帐户中。API 密钥用于订购 IBM Cloud Infrastructure (SoftLayer)，例如新的工作程序节点或 VLAN。</p> <p>其他用户在此区域中执行需要与 IBM Cloud Infrastructure (SoftLayer) 产品服务组合进行交互的操作（例如，创建新集群或重新装入工作程序节点）时，将使用存储的 API 密钥来确定是否存在执行该操作的足够许可权。要确保可以成功执行集群中与基础架构相关的操作，请为 {{site.data.keyword.containershort_notm}} 管理用户分配<strong>超级用户</strong>基础架构访问策略。</p> <p>您可以通过运行 [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info) 来查找当前 API 密钥所有者。如果发现需要更新为某个区域存储的 API 密钥，那么可以通过运行 [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 命令来执行此操作。此命令需要 {{site.data.keyword.containershort_notm}} 管理员访问策略，并在帐户中存储执行此命令的用户的 API 密钥。如果使用 <code>bx cs credentials-set</code> 命令手动设置了 IBM Cloud Infrastructure (SoftLayer) 凭证，那么可能不会使用为该区域存储的 API 密钥。</p> <p><strong>注：</strong>确保需要重置密钥并了解此操作对应用程序的影响。密钥会在多个不同位置中使用，如果进行不必要地更改，可能会导致重大更改。</p></dd>

  <dt><code>ibmcloud ks credentials-set</code> 命令执行的是什么操作？</dt>
    <dd><p>如果您有 {{site.data.keyword.Bluemix_notm}} 现买现付帐户，那么缺省情况下您可以访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。但是，您可能希望使用已经拥有的其他 IBM Cloud Infrastructure (SoftLayer) 帐户来订购基础架构。您可以使用 [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set) 命令将此基础架构帐户链接到 {{site.data.keyword.Bluemix_notm}} 帐户。</p> <p>要除去手动设置的 IBM Cloud Infrastructure (SoftLayer) 凭证，可以使用 [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) 命令。除去凭证后，将使用 IAM API 密钥来订购基础架构。</p></dd>

  <dt>这两者有区别吗？</dt>
    <dd>API 密钥和 <code>ibmcloud ks credentials-set</code> 命令完成的任务相同。如果通过 <code>ibmcloud ks credentials-set</code> 命令手动设置凭证，那么设置的凭证将覆盖由 API 密钥授予的任何访问权。但是，如果存储了其凭证的用户没有必需的许可权来订购基础架构，那么与基础架构相关的操作（例如，创建集群或重新装入工作程序节点）可能会失败。</dd>
</dl>


要更轻松地使用 API 密钥，请尝试创建可用于设置许可权的功能标识。
{: tip}

<br />



## 了解角色关系
{: #user-roles}

在了解哪些角色可以执行各个操作之前，了解角色如何组合使用很重要。
{: shortdesc}

下图显示了组织中每种类型的人员可能需要的角色。但是，对于每个组织，角色各不相同。

![{{site.data.keyword.containershort_notm}} 访问角色](/images/user-policies.png)

图. {{site.data.keyword.containershort_notm}} 的访问许可权（按角色类型）

<br />



## 使用 GUI 分配角色
{: #add_users}

可以通过 GUI 将用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户以授予对集群的访问权。
{: shortdesc}

**开始之前**

- 验证用户是否已添加到帐户。如果没有，请添加[用户](../iam/iamuserinv.html#iamuserinv)。
- 验证您是否已分配有对在其中工作的 {{site.data.keyword.Bluemix_notm}} 帐户的`管理员` [Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。

**为用户分配访问权**

1. 浏览到**管理 > 用户**。这将显示具有帐户访问权的用户的列表。

2. 单击要为其设置许可权的用户的名称。如果该用户未显示，请单击 **邀请用户**以将其添加到帐户。

3. 分配策略。
  * 对于资源组：
    1. 选择 **default** 资源组。只能为 default 资源组配置 {{site.data.keyword.containershort_notm}} 访问权。
  * 对于特定资源：
    1. 从**服务**列表中，选择 **{{site.data.keyword.containershort_notm}}**。
    2. 从**区域**列表中，选择区域。
    3. 从**服务实例**列表中，选择要邀请用户加入的集群。要找到特定集群的标识，请运行 `ibmcloud ks clusters`。

4. 在**选择角色**部分中，选择角色。 

5. 单击**分配**。

6. 分配 [Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。

7. 可选：分配[基础架构角色](/docs/iam/infrastructureaccess.html#infrapermission)。

</br>

**为组分配访问权**

1. 浏览到**管理 > 访问组**。

2. 创建访问组。
  1. 单击 **创建**，然后为组提供**名称**和**描述**。单击**创建**。
  2. 单击**添加用户**以将人员添加到访问组。这将显示有权访问帐户的用户的列表。
  3. 选中要添加到组的用户旁边的框。这将显示一个对话框。
  4. 单击**添加到组**。

3. 要分配对特定服务的访问权，请添加服务标识。
  1. 单击**添加服务标识**。
  2. 选中要添加到组的用户旁边的框。这将显示一个弹出窗口。
  3. 单击**添加到组**。

4. 分配访问策略。请务必仔细检查添加到组的人员。组中的每个人都会提供有相同的访问级别。
    * 对于资源组：
        1. 选择 **default** 资源组。只能为 default 资源组配置 {{site.data.keyword.containershort_notm}} 访问权。
    * 对于特定资源：
        1. 从**服务**列表中，选择 **{{site.data.keyword.containershort_notm}}**。
        2. 从**区域**列表中，选择区域。
        3. 从**服务实例**列表中，选择要邀请用户加入的集群。要找到特定集群的标识，请运行 `ibmcloud ks clusters`。

5. 在**选择角色**部分中，选择角色。 

6. 单击**分配**。

7. 分配 [Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。

8. 可选：分配[基础架构角色](/docs/iam/infrastructureaccess.html#infrapermission)。

<br />






## 授予用户定制 Kubernetes RBAC 角色
{: #rbac}

{{site.data.keyword.containershort_notm}} 访问策略对应于一些 Kubernetes 基于角色的访问控制 (RBAC) 角色。要授权不同于相应访问策略的其他 Kubernetes 角色，您可以定制 RBAC 角色，然后将这些角色分配给个人或用户组。
{: shortdesc}

有时，您可能需要访问策略的详细程度高于 IAM 策略所能允许的详细程度。没问题！您可以为用户或组分配特定 Kubernetes 资源的访问策略。您可以创建角色，然后将角色绑定到特定用户或组。有关更多信息，请参阅 Kubernetes 文档中的[使用 RBAC 授权 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview)。

为组创建绑定时，会影响添加到组中或从组中除去的任何用户。如果将用户添加到组，那么这些用户还具有其他访问权。如果从组中除去用户，那么将撤销其访问权。
{: tip}

如果要分配对服务（例如，Continuous Integration 和 Continuous Delivery Pipeline）的访问权，您可以使用 [Kubernetes 服务帐户 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)。

**开始之前**

- 设定 [Kubernetes CLI](cs_cli_install.html#cs_cli_configure) 的目标为集群。
- 确保用户或组在服务级别至少具有`查看者`访问权。


**定制 RBAC 角色**

1.  创建具有要分配的访问权的角色。

    1. 创建 `.yaml` 文件以定义具有要分配的访问权的角色。

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
        <caption>了解此 YAML 的组成部分</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此 YAML 的组成部分</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>使用 `Role` 来授予对单个名称空间内资源的访问权，或使用 `ClusterRole` 授予对集群范围内资源的访问权。</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>对于运行 Kubernetes 1.8 或更高版本的集群，请使用 `rbac.authorization.k8s.io/v1`。</li><li>对于更早的版本，请使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>对于 `Role` 类型：指定授予其访问权的 Kubernetes 名称空间。</li><li>如果要创建在集群级别应用的 `ClusterRole`，请不要使用 `namespace` 字段。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>对角色命名，并在稍后绑定角色时使用该名称。</td>
            </tr>
            <tr>
              <td><code>rules/apiGroups</code></td>
              <td><ul><li>指定您希望用户能够与之进行交互的 Kubernetes API 组，例如 `"apps"`、`"batch"` 或 `"extensions"`。</li><li>要访问 REST 路径 `api/v1` 上的核心 API 组，请将该组保留为空：`[""]`。</li><li>有关更多信息，请参阅 Kubernetes 文档中的 [API 组 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)。</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>指定要授予其访问权的 Kubernetes 资源，例如 `"daemonsets"`、`"deployments"`、`"events"` 或 `"ingresses"`。</li><li>如果指定 `"nodes"`，那么角色类型必须为 `ClusterRole`。</li><li>有关资源列表，请参阅 Kubernetes 备忘单中的[资源类型 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 表。</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>指定希望用户能够执行的操作的类型，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</li><li>有关完整的动词列表，请参阅 [`kubectl` 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/)。</li></ul></td>
            </tr>
          </tbody>
        </table>

    2.  在集群中创建角色。

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  验证角色是否已创建。

        ```
        kubectl get roles
        ```
        {: pre}

2.  将用户绑定到角色。

    1. 创建 `.yaml` 文件以将用户绑定到角色。记下用于每个主体名称的唯一 URL。

        ```
kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: system:serviceaccount:<namespace>:<service_account_name>
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>了解此 YAML 的组成部分</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此 YAML 的组成部分</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>对于以下两种类型的角色 `.yaml` 文件，将 `kind` 指定为 `RoleBinding`：名称空间 `Role` 和集群范围的 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>对于运行 Kubernetes 1.8 或更高版本的集群，请使用 `rbac.authorization.k8s.io/v1`。</li><li>对于更早的版本，请使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>对于 `Role` 类型：指定授予其访问权的 Kubernetes 名称空间。</li><li>如果要创建在集群级别应用的 `ClusterRole`，请不要使用 `namespace` 字段。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>对角色绑定命名。</td>
            </tr>
            <tr>
              <td><code>subjects/kind</code></td>
              <td>将 kind 指定为 `User`。</td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**对于个人用户**：将用户的电子邮件地址附加到以下 URL：`https://iam.ng.bluemix.net/kubernetes#`。例如，`https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**对于服务帐户**：指定名称空间和服务名称。例如：`system:serviceaccount:<namespace>:<service_account_name>`</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td>使用 `rbac.authorization.k8s.io`。</td>
            </tr>
            <tr>
              <td><code>roleRef/kind</code></td>
              <td>在角色 `.yaml` 文件中输入与 `kind` 相同的值：`Role` 或 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>roleRef/name</code></td>
              <td>输入角色 `.yaml` 文件的名称。</td>
            </tr>
            <tr>
              <td><code>roleRef/apiGroup</code></td>
              <td>使用 `rbac.authorization.k8s.io`。</td>
            </tr>
          </tbody>
        </table>

    2. 在集群中创建角色绑定资源。

        ```
        kubectl apply -f filepath/my_role_team1.yaml
        ```
        {: pre}

    3.  验证绑定是否已创建。

        ```
        kubectl get rolebinding
        ```
        {: pre}

现在您已经创建并绑定了定制 Kubernetes RBAC 角色，接下来该由用户进行操作。请要求用户测试根据其角色有权完成的操作，例如删除 pod。


<br />



## 定制用户的基础架构许可权
{: #infra_access}

在 Identity and Access Management 中设置基础架构策略时，会向用户授予与角色相关联的许可权。某些策略是预定义策略，但其他策略可以进行定制。要定制这些许可权，必须登录到 IBM Cloud Infrastructure (SoftLayer) 并在其中调整许可权。
{: #view_access}

例如，**基本用户**可以重新引导工作程序节点，但无法重新装入工作程序节点。在不授予此人**超级用户**许可权的情况下，可以调整 IBM Cloud Infrastructure (SoftLayer) 许可权，并添加许可权以运行重新装入命令。

如果您有多专区集群，那么 IBM Cloud Infrastructure (SoftLayer) 帐户所有者需要启用 VLAN 生成，以便不同专区中的节点可以在集群中进行通信。帐户所有者还可以为用户分配**网络 > 管理网络 VLAN 生成**许可权，以便用户能够启用 VLAN 生成。
{: tip}


1.  登录到 [{{site.data.keyword.Bluemix_notm}} 帐户](https://console.bluemix.net/)，然后从菜单中选择**基础架构**。

2.  转至**帐户** > **用户** > **用户列表**。

3.  要修改许可权，请选择用户概要文件的名称或**设备访问权**列。

4.  在**门户网站许可权**选项卡中，定制用户的访问权。用户所需的许可权取决于需要使用的基础架构资源：

    * 使用**快速许可权**下拉列表来分配**超级用户**角色，此角色将授予用户所有许可权。
    * 使用**快速许可权**下拉列表来分配**基本用户**角色，此角色将授予用户部分（而不是全部）所需的许可权。
    * 如果不想授予**超级用户**角色的所有许可权，或者不需要添加除**基本用户**角色以外的许可权，请查看下表中对 {{site.data.keyword.containershort_notm}} 中执行常见任务所需许可权的描述。

    <table summary="常见 {{site.data.keyword.containershort_notm}} 场景的基础架构许可权。">
     <caption>{{site.data.keyword.containershort_notm}} 通常必需的基础架构许可权</caption>
     <thead>
      <th>{{site.data.keyword.containershort_notm}} 中的常见任务</th>
      <th>必需的基础架构许可权（按选项卡）</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>最低许可权</strong>：<ul><li>创建集群。</li></ul></td>
         <td><strong>设备</strong>：<ul><li>查看虚拟服务器详细信息</li><li>重新引导服务器并查看 IPMI 系统信息</li><li>发出操作系统重装并启动急救内核</li></ul><strong>帐户</strong>：<ul><li>添加/升级云实例</li><li>添加服务器</li></ul></td>
       </tr>
       <tr>
         <td><strong>集群管理</strong>：<ul><li>创建、更新和删除集群。</li><li>添加、重新装入和重新引导工作程序节点。</li><li>查看 VLAN。</li><li>创建子网。</li><li>部署 pod 和 LoadBalancer 服务。</li></ul></td>
         <td><strong>支持</strong>：<ul><li>查看凭单</li><li>添加凭单</li><li>编辑凭单</li></ul>
         <strong>设备</strong>：<ul><li>查看虚拟服务器详细信息</li><li>重新引导服务器并查看 IPMI 系统信息</li><li>升级服务器</li><li>发出操作系统重装并启动急救内核</li></ul>
         <strong>服务</strong>：<ul><li>管理 SSH 密钥</li></ul>
         <strong>帐户</strong>：<ul><li>查看帐户摘要</li><li>添加/升级云实例</li><li>取消服务器</li><li>添加服务器</li></ul></td>
       </tr>
       <tr>
         <td><strong>存储器</strong>：<ul><li>创建持久性卷申领以供应持久卷。</li><li>创建和管理存储器基础架构资源。</li></ul></td>
         <td><strong>服务</strong>：<ul><li>管理存储器</li></ul><strong>帐户</strong>：<ul><li>添加存储器</li></ul></td>
       </tr>
       <tr>
         <td><strong>专用联网</strong>：<ul><li>管理用于集群内联网的专用 VLAN。</li><li>设置与专用网络的 VPN 连接。</li></ul></td>
         <td><strong>网络</strong>：<ul><li>管理网络子网路径</li><li>管理 IPSEC 网络隧道</li><li>管理网络网关</li><li>VPN 管理</li></ul></td>
       </tr>
       <tr>
         <td><strong>公用网络</strong>：<ul><li>设置公共负载均衡器或 Ingress 联网以公开应用程序。</li></ul></td>
         <td><strong>设备</strong>：<ul><li>管理负载均衡器</li><li>编辑主机名/域</li><li>管理端口控制</li></ul>
         <strong>网络</strong>：<ul><li>使用公用网络端口添加计算</li><li>管理网络子网路径</li><li>添加 IP 地址</li></ul>
         <strong>服务</strong>：<ul><li>管理 DNS、逆向 DNS 和 WHOIS</li><li>查看证书 (SSL)</li><li>管理证书 (SSL)</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  要保存更改，请单击**编辑门户网站许可权**。

6.  在**设备访问权**选项卡中，选择要向其授予访问权的设备。

    * 在**设备类型**下拉列表中，可以授予对**所有虚拟服务器**的访问权。
    * 要允许用户访问所创建的新设备，请选择**添加新设备时自动授予访问权**。
    * 要保存更改，请单击**更新设备访问权**。

要降级许可权？完成此操作可能需要几分钟时间。
{: tip}

<br />

