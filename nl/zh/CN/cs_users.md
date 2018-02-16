---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

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

您可以授予组织中其他用户对集群的访问权，以确保只有授权用户才能使用集群以及将应用程序部署到集群。
{:shortdesc}




## 管理集群访问权
{: #managing}

每个使用 {{site.data.keyword.containershort_notm}} 的用户都必须分配有服务特点用户角色的组合，以确定用户可以执行的操作。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 访问策略</dt>
<dd>在 Identity and Access Management 中，{{site.data.keyword.containershort_notm}} 访问策略用于确定可以在集群上执行的集群管理操作，例如创建或除去集群，以及添加或除去多余的工作程序节点。这些策略必须与基础架构策略一起设置。</dd>
<dt>基础架构访问策略</dt>
<dd>在 Identity and Access Management 中，基础架构访问策略允许从 {{site.data.keyword.containershort_notm}} 用户界面或 CLI 请求的操作在 IBM Cloud infrastructure (SoftLayer) 中完成。这些策略必须与 {{site.data.keyword.containershort_notm}} 访问策略一起设置。[了解有关可用基础架构角色的更多信息](/docs/iam/infrastructureaccess.html#infrapermission)。</dd>
<dt>资源组</dt>
<dd>资源组用于将 {{site.data.keyword.Bluemix_notm}} 服务组织成分组，以便您可以一次性快速为用户分配对多个资源的访问权。[了解如何使用资源组来管理用户](/docs/admin/resourcegroups.html#rgs)。</dd>
<dt>Cloud Foundry 角色</dt>
<dd>在 Identity and Access Management 中，必须为每个用户分配 Cloud Foundry 用户角色。此角色将确定用户可以在 {{site.data.keyword.Bluemix_notm}} 帐户上执行的操作，例如邀请其他用户或查看配额使用情况。[了解有关可用 Cloud Foundry 角色的更多信息](/docs/iam/cfaccess.html#cfaccess)。</dd>
<dt>Kubernetes RBAC 角色</dt>
<dd>分配了 {{site.data.keyword.containershort_notm}} 访问策略的每个用户都将自动分配有 Kubernetes RBAC 角色。在 Kubernetes 中，RBAC 角色将确定可以在集群内部的 Kubernetes 资源上执行的操作。只会为缺省名称空间设置 RBAC 角色。集群管理员可以为集群中的其他名称空间添加 RBAC 角色。有关更多信息，请参阅 Kubernetes 文档中的[使用 RBAC 授权 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</dd>
</dl>

<br />


## 访问策略和许可权
{: #access_policies}

查看可以授予 {{site.data.keyword.Bluemix_notm}} 帐户中用户的访问策略和许可权。“操作员”和“编辑者”角色具有不同的许可权。例如，如果希望用户添加工作程序节点和绑定服务，那么必须为用户同时分配“操作员”和“编辑者”角色。

|{{site.data.keyword.containershort_notm}} 访问策略|集群管理许可权|Kubernetes 资源许可权|
|-------------|------------------------------|-------------------------------|
|管理员|此角色会继承此帐户中所有集群的“编辑者”、“操作员”和“查看者”角色的许可权。<br/><br/>为所有当前服务实例设置时：<ul><li>创建 Lite 或标准集群</li><li>为 {{site.data.keyword.Bluemix_notm}} 帐户设置凭证以访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合</li><li>除去集群</li><li>为此帐户中的其他现有用户分配和更改 {{site.data.keyword.containershort_notm}} 访问策略。</li></ul><p>为特定集群标识设置时：<ul><li>除去特定集群。</li></ul></p>相应的基础架构访问策略：超级用户<br/><br/><b>注</b>：要创建资源（如机器、VLAN 和子网），用户需要**超级用户**基础架构角色。|<ul><li>RBAC 角色：集群管理员</li><li>对每个名称空间中资源的读/写访问权</li><li>在名称空间内创建角色</li><li>访问 Kubbernees 仪表板</li><li>创建使应用程序公共可用的 Ingress 资源</li></ul>|
|操作员|<ul><li>向集群添加其他工作程序节点</li><li>从集群中除去工作程序节点</li><li>重新引导工作程序节点</li><li>重新装入工作程序节点</li><li>向集群添加子网</li></ul><p>相应的基础架构访问策略：基本用户</p>|<ul><li>RBAC 角色：管理员</li><li>具有对缺省名称空间内部资源的读/写访问权，但对名称空间本身没有读/写访问权</li><li>在名称空间内创建角色</li></ul>|
|编辑者<br/><br/><b>提示</b>：将此角色用于应用程序开发者。|<ul><li>将 {{site.data.keyword.Bluemix_notm}} 服务绑定到集群。</li><li>取消 {{site.data.keyword.Bluemix_notm}} 服务与集群的绑定。</li><li>创建 Webhook。</li></ul><p>相应的基础架构访问策略：基本用户|<ul><li>RBAC 角色：编辑</li><li>对缺省名称空间内部资源的读/写访问权</li></ul></p>|
|查看者|<ul><li>列出集群</li><li>查看集群的详细信息</li></ul><p>相应的基础架构访问策略：仅查看</p>|<ul><li>RBAC 角色：查看</li><li>对缺省名称空间内部资源的读访问权</li><li>对 Kubernetes 私钥无读访问权</li></ul>|

|Cloud Foundry 访问策略|帐户管理许可权|
|-------------|------------------------------|
|组织角色：管理员|<ul><li>将其他用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户</li></ul>| |
|空间角色：开发者|<ul><li>创建 {{site.data.keyword.Bluemix_notm}} 服务实例</li><li>将 {{site.data.keyword.Bluemix_notm}} 服务实例绑定到集群</li></ul>| 
<br />


## 向 {{site.data.keyword.Bluemix_notm}} 帐户添加用户
{: #add_users}

可以将其他用户添加到 {{site.data.keyword.Bluemix_notm}} 帐户以授予对集群的访问权。

开始之前，请验证您是否已分配有对 {{site.data.keyword.Bluemix_notm}} 帐户的“管理员”Cloud Foundry 角色。

1.  [向帐户添加用户](../iam/iamuserinv.html#iamuserinv).
2.  在**访问权**部分中，展开**服务**。
3.  分配 {{site.data.keyword.containershort_notm}} 访问角色。从**分配访问权**下拉列表中，决定是要仅授予对 {{site.data.keyword.containershort_notm}} 帐户（**资源**）的访问权，还是授予对帐户内各种资源的集合（**资源组**）的访问权。
  -  对于**资源**：
      1. 从**服务**下拉列表中，选择 **{{site.data.keyword.containershort_notm}}**。
      2. 从**区域**下拉列表中，选择要邀请用户加入的区域。
      3. 从**服务实例**下拉列表中，选择要邀请用户加入的集群。要找到特定集群的标识，请运行 `bx cs clusters`。
      4. 在**选择角色**部分中，选择角色。要查找每个角色的受支持操作列表，请参阅[访问策略和许可权](#access_policies)。
  - 对于**资源组**：
      1. 从**资源组**下拉列表中，选择包含帐户的 {{site.data.keyword.containershort_notm}} 资源许可权的资源组。
      2. 从**分配对资源组的访问权**下拉列表中，选择角色。要查找每个角色的受支持操作列表，请参阅[访问策略和许可权](#access_policies)。
4. [可选：分配基础架构角色](/docs/iam/mnginfra.html#managing-infrastructure-access)。
5. [可选：分配 Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。
5. 单击**邀请用户**。

<br />


## 定制用户的基础架构许可权
{: #infra_access}

在 Identity and Access Management 中设置基础架构策略时，会向用户授予与角色相关联的许可权。要定制这些许可权，必须登录到 IBM Cloud infrastructure (SoftLayer) 并调整许可权。
{: #view_access}

例如，基本用户可以重新引导工作程序节点，但它们无法重新装入工作程序节点。在不提供人员超级用户许可权的情况下，您可以调整 IBM Cloud infrastructure (SoftLayer) 许可权，并添加许可权以运行重新装入命令。

1.  登录到 IBM Cloud infrastructure (SoftLayer) 帐户。
2.  选择要更新的用户概要文件。
3.  在**门户网站许可权**中，定制用户访问权。例如，要添加重新装入许可权，请在**设备**选项卡中选择**发出操作系统重新装入并启动急救内核**。
9.  保存更改。
