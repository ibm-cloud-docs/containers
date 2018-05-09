---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 为用户分配对集群的访问权
{: #users}

您可以授予对 Kubernetes 集群的访问权，以确保只有授权用户才能使用集群以及将容器部署到 {{site.data.keyword.containerlong}} 中的集群。
{:shortdesc}


## 规划通信过程
作为集群管理员，请考虑如何为组织的成员建立通信过程，以向您传递访问请求，以便您可以有条不紊地进行通信。
{:shortdesc}

向集群用户提供有关如何请求对集群的访问或如何从集群管理员那里获取任何类型常见任务帮助的指示信息。由于 Kubernetes 不会为这种通信提供便利，因此每个团队的首选过程可以有所变化。

您可以选择以下任一方法，也可以建立自己的方法。
- 创建凭单系统
- 创建表单模板
- 创建 Wiki 页面
- 需要电子邮件请求
- 使用您已用于跟踪团队日常工作的问题跟踪方法


## 管理集群访问权
{: #managing}

每个使用 {{site.data.keyword.containershort_notm}} 的用户都必须分配有服务特点用户角色的组合，以确定用户可以执行的操作。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 访问策略</dt>
<dd>在 Identity and Access Management 中，{{site.data.keyword.containershort_notm}} 访问策略用于确定可以在集群上执行的集群管理操作，例如创建或除去集群，以及添加或除去多余的工作程序节点。这些策略必须与基础架构策略一起设置。您可以基于区域授予对集群的访问权。</dd>
<dt>基础架构访问策略</dt>
<dd>在 Identity and Access Management 中，基础架构访问策略允许从 {{site.data.keyword.containershort_notm}} 用户界面或 CLI 请求的操作在 IBM Cloud infrastructure (SoftLayer) 中完成。这些策略必须与 {{site.data.keyword.containershort_notm}} 访问策略一起设置。[了解有关可用基础架构角色的更多信息](/docs/iam/infrastructureaccess.html#infrapermission)。</dd>
<dt>资源组</dt>
<dd>资源组用于将 {{site.data.keyword.Bluemix_notm}} 服务组织成分组，以便您可以一次性快速为用户分配对多个资源的访问权。[了解如何使用资源组来管理用户](/docs/account/resourcegroups.html#rgs)。</dd>
<dt>Cloud Foundry 角色</dt>
<dd>在 Identity and Access Management 中，必须为每个用户分配 Cloud Foundry 用户角色。此角色将确定用户可以在 {{site.data.keyword.Bluemix_notm}} 帐户上执行的操作，例如邀请其他用户或查看配额使用情况。[了解有关可用 Cloud Foundry 角色的更多信息](/docs/iam/cfaccess.html#cfaccess)。</dd>
<dt>Kubernetes RBAC 角色</dt>
<dd>分配了 {{site.data.keyword.containershort_notm}} 访问策略的每个用户都将自动分配有 Kubernetes RBAC 角色。在 Kubernetes 中，RBAC 角色将确定可以在集群内部的 Kubernetes 资源上执行的操作。只会为缺省名称空间设置 RBAC 角色。集群管理员可以为集群中的其他名称空间添加 RBAC 角色。请参阅[访问策略和许可权](#access_policies)部分中的下表，以了解哪个 RBAC 角色对应于哪个 {{site.data.keyword.containershort_notm}} 访问策略。有关 RBAC 角色的更多常规信息，请参阅 Kubernetes 文档中的[使用 RBAC 授权 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</dd>
</dl>

<br />


## 访问策略和许可权
{: #access_policies}

查看可以授予 {{site.data.keyword.Bluemix_notm}} 帐户中用户的访问策略和许可权。
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM)“操作员”和“编辑者”角色具有不同的许可权。例如，如果希望用户添加工作程序节点和绑定服务，那么必须为用户同时分配“操作员”和“编辑者”角色。有关相应的基础架构访问策略的更多详细信息，请参阅[定制用户的基础架构许可权](#infra_access)。<br/><br/>如果更改用户的访问策略，会清除集群中与更改关联的 RBAC 策略。</br></br>**注：**对许可权降级后，例如您希望将“查看者”访问权分配给前集群管理员，那么您必须等待几分钟才能完成降级。

|{{site.data.keyword.containershort_notm}} 访问策略|集群管理许可权|Kubernetes 资源许可权|
|-------------|------------------------------|-------------------------------|
|管理员|此角色会继承此帐户中所有集群的“编辑者”、“操作员”和“查看者”角色的许可权。<br/><br/>为所有当前服务实例设置时：<ul><li>创建免费或标准集群</li><li>为 {{site.data.keyword.Bluemix_notm}} 帐户设置凭证以访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合</li><li>除去集群</li><li>为此帐户中的其他现有用户分配和更改 {{site.data.keyword.containershort_notm}} 访问策略。</li></ul><p>为特定集群标识设置时：<ul><li>除去特定集群。</li></ul></p>相应的基础架构访问策略：超级用户<br/><br/><strong>注</strong>：要创建资源（如机器、VLAN 和子网），用户需要**超级用户**基础架构角色。|<ul><li>RBAC 角色：集群管理员</li><li>对每个名称空间中资源的读/写访问权</li><li>在名称空间内创建角色</li><li>访问 Kubbernees 仪表板</li><li>创建使应用程序公共可用的 Ingress 资源</li></ul>|
|操作员|<ul><li>向集群添加其他工作程序节点</li><li>从集群中除去工作程序节点</li><li>重新引导工作程序节点</li><li>重新装入工作程序节点</li><li>向集群添加子网</li></ul><p>相应的基础架构访问策略：[定制](#infra_access)</p>|<ul><li>RBAC 角色：管理员</li><li>具有对缺省名称空间内部资源的读/写访问权，但对名称空间本身没有读/写访问权</li><li>在名称空间内创建角色</li></ul>|
|编辑者<br/><br/><strong>提示</strong>：将此角色用于应用程序开发者。|<ul><li>将 {{site.data.keyword.Bluemix_notm}} 服务绑定到集群。</li><li>取消 {{site.data.keyword.Bluemix_notm}} 服务与集群的绑定。</li><li>创建 Webhook。</li></ul><p>相应的基础架构访问策略：[定制](#infra_access)|<ul><li>RBAC 角色：编辑</li><li>对缺省名称空间内部资源的读/写访问权</li></ul></p>|
|查看者|<ul><li>列出集群</li><li>查看集群的详细信息</li></ul><p>相应的基础架构访问策略：仅查看</p>|<ul><li>RBAC 角色：查看</li><li>对缺省名称空间内部资源的读访问权</li><li>对 Kubernetes 私钥无读访问权</li></ul>|

|Cloud Foundry 访问策略|帐户管理许可权|
|-------------|------------------------------|
|组织角色：管理员|<ul><li>将其他用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户</li></ul>| |
|空间角色：开发者|<ul><li>创建 {{site.data.keyword.Bluemix_notm}} 服务实例</li><li>将 {{site.data.keyword.Bluemix_notm}} 服务实例绑定到集群</li></ul>| 

<br />



## 了解 IAM API 密钥和 `bx cs credentials-set` 命令
{: #api_key}

要成功供应和使用帐户中的集群，必须确保帐户已正确设置，以用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。根据帐户设置，可以使用通过 `bx cs credentials-set` 命令手动设置的 IAM API 密钥或基础架构凭证。

<dl>
  <dt>IAM API 密钥</dt>
  <dd>执行需要 {{site.data.keyword.containershort_notm}} 管理员访问策略的第一个操作时，会自动针对区域设置 Identity and Access Management (IAM) API 密钥。例如，某个管理用户在 <code>us-south</code> 区域中创建了第一个集群。通过执行此操作，此用户的 IAM API 密钥将存储在此区域的帐户中。API 密钥用于订购 IBM Cloud Infrastructure (SoftLayer)，例如新的工作程序节点或 VLAN。</br></br>
其他用户在此区域中执行需要与 IBM Cloud Infrastructure (SoftLayer) 产品服务组合进行交互的操作（例如，创建新集群或重新装入工作程序节点）时，将使用存储的 API 密钥来确定是否存在执行该操作的足够许可权。要确保可以成功执行集群中与基础架构相关的操作，请为 {{site.data.keyword.containershort_notm}} 管理用户分配<strong>超级用户</strong>基础架构访问策略。</br></br>您可以通过运行 [<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info) 来查找当前 API 密钥所有者。如果发现需要更新为区域存储的 API 密钥，那么可以通过运行 [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 命令来执行此操作。此命令需要 {{site.data.keyword.containershort_notm}} 管理员访问策略，并在帐户中存储执行此命令的用户的 API 密钥。</br></br> <strong>注：</strong>如果使用 <code>bx cs credentials-set</code> 命令手动设置了 IBM Cloud Infrastructure (SoftLayer) 凭证，那么可能不会使用为该区域存储的 API 密钥。</dd>
<dt>通过 <code>bx cs credentials-set</code> 设置的 IBM Cloud Infrastructure (SoftLayer) 凭证</dt>
<dd>如果您有 {{site.data.keyword.Bluemix_notm}} 现买现付帐户，那么缺省情况下您可以访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。但是，您可能希望使用已经拥有的其他 IBM Cloud Infrastructure (SoftLayer) 帐户来订购基础架构。您可以使用 [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set) 命令将此基础架构帐户链接到 {{site.data.keyword.Bluemix_notm}} 帐户。</br></br>如果手动设置了 IBM Cloud Infrastructure (SoftLayer) 凭证，那么这些凭证会用于订购基础架构，即使已存在帐户的 IAM API 密钥也不例外。如果存储了其凭证的用户没有必需的许可权来订购基础架构，那么与基础架构相关的操作（例如，创建集群或重新装入工作程序节点）可能会失败。</br></br> 要除去手动设置的 IBM Cloud Infrastructure (SoftLayer) 凭证，可以使用 [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) 命令。除去凭证后，将使用 IAM API 密钥来订购基础架构。</dd>
</dl>

## 向 {{site.data.keyword.Bluemix_notm}} 帐户添加用户
{: #add_users}

可以将用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户以授予对集群的访问权。
{:shortdesc}

开始之前，请验证您是否已分配有对 {{site.data.keyword.Bluemix_notm}} 帐户的“管理员”Cloud Foundry 角色。

1.  [向帐户添加用户](../iam/iamuserinv.html#iamuserinv).
2.  在**访问权**部分中，展开**服务**。
3.  分配 {{site.data.keyword.containershort_notm}} 访问角色。从**分配访问权**下拉列表中，决定是要仅授予对 {{site.data.keyword.containershort_notm}} 帐户（**资源**）的访问权，还是授予对帐户内各种资源的集合（**资源组**）的访问权。
  -  对于**资源**：
      1. 从**服务**下拉列表中，选择 **{{site.data.keyword.containershort_notm}}**。
      2. 从**区域**下拉列表中，选择要邀请用户加入的区域。**注**：要访问[亚太地区北部区域](cs_regions.html#locations)中的集群，请参阅[授予用户对亚太地区北部区域内集群的 IAM 访问权](#iam_cluster_region)。
      3. 从**服务实例**下拉列表中，选择要邀请用户加入的集群。要找到特定集群的标识，请运行 `bx cs clusters`。
      4. 在**选择角色**部分中，选择角色。要查找每个角色的受支持操作列表，请参阅[访问策略和许可权](#access_policies)。
  - 对于**资源组**：
      1. 从**资源组**下拉列表中，选择包含帐户的 {{site.data.keyword.containershort_notm}} 资源许可权的资源组。
      2. 从**分配对资源组的访问权**下拉列表中，选择角色。要查找每个角色的受支持操作列表，请参阅[访问策略和许可权](#access_policies)。
4. [可选：分配 Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。
5. [可选：分配基础架构角色](/docs/iam/infrastructureaccess.html#infrapermission)。
6. 单击**邀请用户**。

<br />


### 授予用户对亚太地区北部区域内集群的 IAM 访问权
{: #iam_cluster_region}

[将用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户](#add_users)时，请选择向这些用户授予了访问权的区域。但是，某些区域（例如，亚太地区北部）可能在控制台中不可用，因此必须使用 CLI 进行添加。
{:shortdesc}

开始之前，请验证您是否为 {{site.data.keyword.Bluemix_notm}} 帐户的管理员。

1.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。选择要使用的帐户。

    ```
    bx login [--sso]
    ```
    {: pre}

    **注**：如果您有联合标识，请使用 `bx login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。

2.  确定要授予其许可权的环境，例如亚太地区北部区域 (`jp-tok`)。有关命令选项（例如，组织和空间）的更多详细信息，请参阅 [`bluemix target` 命令](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target)。

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  获取要向其授予访问权的区域集群的名称或标识。

    ```
    bx cs clusters
    ```
    {: pre}

4.  获取要向其授予访问权的用户标识。

    ```
    bx account users
    ```
    {: pre}

5.  选择访问策略的角色。

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  通过相应的角色授予用户对集群的访问权。此示例为三个集群分配 `user@example.com` `Operator` 和 `Editor` 角色。

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    要授予对区域中现有和未来集群的访问权，请不要指定 `--service-instance` 标志。有关更多信息，请参阅 [`bluemix iam user-policy-create` 命令](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create)。
    {:tip}

## 定制用户的基础架构许可权
{: #infra_access}

在 Identity and Access Management 中设置基础架构策略时，会向用户授予与角色相关联的许可权。要定制这些许可权，必须登录到 IBM Cloud Infrastructure (SoftLayer) 并在其中调整许可权。
{: #view_access}

例如，**基本用户**可以重新引导工作程序节点，但无法重新装入工作程序节点。在不授予此人**超级用户**许可权的情况下，可以调整 IBM Cloud Infrastructure (SoftLayer) 许可权，并添加许可权以运行重新装入命令。

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
     <td><strong>网络</strong>：<ul><li>管理网络子网路径</li><li>管理网络 VLAN 生成</li><li>管理 IPSEC 网络隧道</li><li>管理网络网关</li><li>VPN 管理</li></ul></td>
     </tr>
     <tr>
     <td><strong>公用网络</strong>：<ul><li>设置公共负载均衡器或 Ingress 联网以公开应用程序。</li></ul></td>
     <td><strong>设备</strong>：<ul><li>管理负载均衡器</li><li>编辑主机名/域</li><li>管理端口控制</li></ul>
     <strong>网络</strong>：<ul><li>使用公用网络端口添加计算</li><li>管理网络子网路径</li><li>管理网络 VLAN 生成</li><li>添加 IP 地址</li></ul>
     <strong>服务</strong>：<ul><li>管理 DNS、逆向 DNS 和 WHOIS</li><li>查看证书 (SSL)</li><li>管理证书 (SSL)</li></ul></td>
     </tr>
     </tbody></table>

5.  要保存更改，请单击**编辑门户网站许可权**。

6.  在**设备访问权**选项卡中，选择要向其授予访问权的设备。

    * 在**设备类型**下拉列表中，可以向**所有虚拟服务器**授予访问权。
    * 要允许用户访问所创建的新设备，请选中**添加新设备时自动授予访问权**。
    * 要保存更改，请单击**更新设备访问权**。

7.  返回到用户概要文件列表，并验证是否授予了**设备访问权**。

## 授予用户定制 Kubernetes RBAC 角色
{: #rbac}

{{site.data.keyword.containershort_notm}} 访问策略与特定 Kubernetes 基于角色的访问控制 (RBAC) 角色相对应，如[访问策略和许可权](#access_policies)中所述。要授权不同于相应访问策略的其他 Kubernetes 角色，您可以定制 RBAC 角色，然后将这些角色分配给个人或用户组。
{: shortdesc}

例如，您可能希望授予开发者团队许可权，以对特定 API 组或集群中某个 Kubernetes 名称空间内的资源（而不是整个集群）进行操作。使用对 {{site.data.keyword.containershort_notm}} 唯一的用户名创建角色，然后将该角色绑定到用户。有关更多详细信息，请参阅 Kubernetes 文档中的[使用 RBAC 授权 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。

开始之前，请[设定 Kubernetes CLI 的目标为集群](cs_cli_install.html#cs_cli_configure)

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
        <caption>表. 了解此 YAML 的组成部分</caption>
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
        <td><ul><li>指定您希望用户能够与之进行交互的 Kubernetes API 组，例如 `"apps"`、`"batch"` 或 `"extensions"`。</li><li>要访问 REST 路径 `api/v1` 上的核心 API 组，请将该组保留为空：`[""]`。</li><li>有关更多信息，请参阅 Kubernetes 文档中的 [API 组 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/api-overview/#api-groups)。</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>指定要授予其访问权的 Kubernetes 资源，例如 `"daemonsets"`、`"deployments"`、`"events"` 或 `"ingresses"`。</li><li>如果指定 `"nodes"`，那么角色类型必须为 `ClusterRole`。</li><li>有关资源列表，请参阅 Kubernetes 备忘单中的[资源类型 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 表。</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>指定希望用户能够执行的操作的类型，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</li><li>有关完整的动词列表，请参阅 [`kubectl` 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)。</li></ul></td>
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
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>表. 了解此 YAML 的组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此 YAML 的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>对于以下两种类型的角色 `.yaml` 文件，将 `kind` 指定为 `RoleBinding`：名称空间 `Role` 和集群范围的 `ClusterRole`.</td>
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
        <td><ul><li>将用户的电子邮件地址附加到以下 URL：`https://iam.ng.bluemix.net/kubernetes#`。</li><li>例如，`https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li></ul></td>
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
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  验证绑定是否已创建。

        ```
        kubectl get rolebinding
        ```
        {: pre}

现在您已经创建并绑定了定制 Kubernetes RBAC 角色，接下来该由用户进行操作。请要求用户测试根据其角色有权完成的操作，例如删除 pod。
