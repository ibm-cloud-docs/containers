---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}


# 分配集群访问权
{: #users}

作为集群管理员，您可以为 {{site.data.keyword.containerlong}} 集群定义访问策略，以便为不同用户创建不同级别的访问权。例如，您可以授权某些用户使用集群基础架构资源，而其他用户只能部署容器。
{: shortdesc}

## 了解访问策略和角色
{: #access_policies}

访问策略确定 {{site.data.keyword.Bluemix_notm}} 帐户中用户对整个 {{site.data.keyword.Bluemix_notm}} 平台上资源具有的访问级别。策略会为用户分配一个或多个角色，这些角色定义对单个服务或在资源组中组织在一起的一组服务和资源的访问权作用域。{{site.data.keyword.Bluemix_notm}} 中的每个服务可能都需要自己的一组访问策略。
{: shortdesc}

在制定管理用户访问权的计划时，请考虑以下常规步骤：
1.  [为用户选取适当的访问策略和角色](#access_roles)
2.  [在 {{site.data.keyword.Bluemix_notm}} IAM 中将访问角色分配给单个用户或用户组](#iam_individuals_groups)
3.  [将用户访问权的作用域限定为集群实例或资源组](#resource_groups)

了解如何管理帐户中的角色、用户和资源后，请查看[设置集群访问权](#access-checklist)以获取如何配置访问权的核对表。

### 为用户选取适当的访问策略和角色
{: #access_roles}

必须为使用 {{site.data.keyword.containerlong_notm}} 的每个用户定义访问策略。访问策略的作用域基于用户定义的一个或多个角色，这些角色确定用户可以执行的操作。某些策略是预定义策略，但其他策略可以进行定制。无论用户是通过 {{site.data.keyword.containerlong_notm}} 控制台还是通过 CLI 发出请求，都将强制执行同一策略；即便在 IBM Cloud Infrastructure (SoftLayer) 中完成这些操作也是如此。
{: shortdesc}

了解不同类型的许可权和角色，每个操作可由哪个角色执行，以及这些角色如何相互关联。

要查看每个角色的特定 {{site.data.keyword.containerlong_notm}} 许可权，请查看[用户访问许可权](cs_access_reference.html)参考主题。
{: tip}

<dl>

<dt><a href="#platform">IAM 平台</a></dt>
<dd>{{site.data.keyword.containerlong_notm}} 使用 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 角色来授予用户对集群的访问权。IAM 平台角色确定用户可对集群执行的操作。您可以按区域为这些角色设置策略。分配有 IAM 平台角色的每个用户还会在 Kubernetes 名称空间 `default` 中自动分配有相应的 RBAC 角色。此外，IAM 平台角色会授权您对集群执行基础架构操作，但不会授予对 IBM Cloud Infrastructure (SoftLayer) 资源的访问权。对 IBM Cloud Infrastructure (SoftLayer) 资源的访问权由[为区域设置的 API 密钥](#api_key)确定。</br></br>
IAM 平台角色允许的示例操作包括创建或除去集群、将服务绑定到集群或添加额外的工作程序节点。</dd>
<dt><a href="#role-binding">RBAC</a></dt>
<dd>在 Kubernetes 中，基于角色的访问控制 (RBAC) 是保护集群中资源的一种方法。RBAC 角色确定用户可对这些资源执行的 Kubernetes 操作。分配有 IAM 平台角色的每个用户还会在 Kubernetes 名称空间 `default` 中自动分配有相应的 RBAC 集群角色。此 RBAC 集群角色将应用于 default 名称空间或所有名称空间，具体取决于您选择的 IAM 平台角色。</br></br>
RBAC 角色允许的示例操作包括创建对象（如 pod）或读取 pod 日志。</dd>
<dt><a href="#api_key">基础架构</a></dt>
<dd>基础架构角色支持访问 IBM Cloud Infrastructure (SoftLayer) 资源。设置具有**超级用户**基础架构角色的用户，并将此用户的基础架构凭证存储在 API 密钥中。然后，在要创建集群的每个区域中设置 API 密钥。设置 API 密钥后，您为其授予 {{site.data.keyword.containerlong_notm}} 访问权的其他用户无需基础架构角色，因为该区域中的所有用户会共享该 API 密钥。{{site.data.keyword.Bluemix_notm}} IAM 平台角色改为确定允许用户执行的基础架构操作。如果未使用完全<strong>超级用户</strong>基础架构角色设置 API 密钥，或者需要为用户授予特定设备访问权，那么可以[定制基础架构许可权](#infra_access)。</br></br>
基础架构角色允许的示例操作包括查看集群工作程序节点机器的详细信息或编辑联网和存储资源。</dd>
<dt>Cloud Foundry</dt>
<dd>并非所有服务都可以通过 {{site.data.keyword.Bluemix_notm}} IAM 进行管理。如果使用的是无法通过 IAM 管理的其中一个服务，那么可以继续使用 Cloud Foundry 用户角色来控制对这些服务的访问。Cloud Foundry 角色会授予对帐户内组织和空间的访问权。要在 {{site.data.keyword.Bluemix_notm}} 中查看基于 Cloud Foundry 的服务的列表，请运行 <code>ibmcloud service list</code>。</br></br>
Cloud Foundry 角色允许的示例操作包括创建新的 Cloud Foundry 服务实例或将 Cloud Foundry 服务实例绑定到集群。要了解更多信息，请参阅 {{site.data.keyword.Bluemix_notm}} IAM 文档中的可用[组织和空间角色](/docs/iam/cfaccess.html)或[管理 Cloud Foundry 访问权](/docs/iam/mngcf.html)的步骤。</dd>
</dl>

### 在 {{site.data.keyword.Bluemix_notm}} IAM 中将访问角色分配给单个用户或用户组
{: #iam_individuals_groups}

设置 {{site.data.keyword.Bluemix_notm}} IAM 策略时，可以将角色分配给单个用户或用户组。
{: shortdesc}

<dl>
<dt>单个用户</dt>
<dd>您可能有特定用户需要的许可权多于或少于团队中其他用户的许可权。您可以分别定制许可权，以便每人都具有完成其任务所需的许可权。您可以为每个用户分配多个 {{site.data.keyword.Bluemix_notm}} IAM 角色。</dd>
<dt>访问组中的多个用户</dt>
<dd>您可以创建一组用户，然后为该组分配许可权。例如，您可以将所有团队负责人分组在一起，并将管理员访问权分配给该组。然后，可以将所有开发者分组在一起，并为该组仅分配写访问权。您可以为每个访问组分配多个 {{site.data.keyword.Bluemix_notm}} IAM 角色。为组分配许可权后，将影响添加到该组或从该组中除去的任何用户。如果将用户添加到组，那么这些用户还具有该组所授予的额外访问权。如果从组中除去用户，那么将撤销其访问权。
</dd>
</dl>

无法为服务帐户分配 {{site.data.keyword.Bluemix_notm}} IAM 角色。可以改为直接[为服务帐户分配 RBAC 角色](#rbac)。
{: tip}

您还必须指定用户是有权访问一个资源组中的一个集群、一个资源组中的所有集群，还是帐户中所有资源组中的所有集群。

### 将用户访问权的作用域限定为集群实例或资源组
{: #resource_groups}

在 {{site.data.keyword.Bluemix_notm}} IAM 中，您可以为用户分配对资源实例或资源组的访问角色。
{: shortdesc}

创建 {{site.data.keyword.Bluemix_notm}} 帐户时，将自动创建缺省资源组。如果在创建资源时未指定资源组，那么资源实例（集群）会属于缺省资源组。如果要在帐户中添加资源组，请参阅[设置帐户的最佳实践 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](/docs/tutorials/users-teams-applications.html) 和[设置资源组](/docs/resources/bestpractice_rgs.html#setting-up-your-resource-groups)。

<dl>
<dt>资源实例</dt>
  <dd><p>帐户中的每个 {{site.data.keyword.Bluemix_notm}} 服务都是具有实例的资源。实例因服务而异。例如，在 {{site.data.keyword.containerlong_notm}} 中，实例是集群，但在 {{site.data.keyword.cloudcerts_long_notm}} 中，实例是证书。缺省情况下，资源还属于您帐户中的缺省资源组。对于以下场景，您可以为用户分配对资源实例的访问角色。
  <ul><li>帐户中的所有 {{site.data.keyword.Bluemix_notm}} IAM 服务，包括 {{site.data.keyword.containerlong_notm}} 中的所有集群和 {{site.data.keyword.registrylong_notm}} 中的映像。</li>
  <li>服务内的所有实例，例如 {{site.data.keyword.containerlong_notm}} 中的所有集群。</li>
  <li>服务区域内的所有实例，例如 {{site.data.keyword.containerlong_notm}} 的**美国南部**区域中的所有集群。</li>
  <li>单个实例（例如，一个集群）。</li></ul></dd>
<dt>资源组</dt>
  <dd><p>您可以在可定制的分组中组织帐户资源，以便可以一次快速为单个用户或用户组分配对多个资源的访问权。资源组可以帮助操作员和管理员过滤资源，以查看其当前使用情况，对问题进行故障诊断以及管理团队。</p>
  <p class="important">集群只能与同一资源组中的其他 {{site.data.keyword.Bluemix_notm}} 服务集成，或与不支持资源组的服务（例如，{{site.data.keyword.registrylong_notm}}）集成。只能在一个资源组中创建集群，并且在此之后无法更改资源组。如果在错误的资源组中创建了集群，那么必须删除该集群，然后在正确的资源组中重新创建该集群。</p>
  <p>如果计划将 [{{site.data.keyword.monitoringlong_notm}} 用于监视度量值](cs_health.html#view_metrics)，请考虑为集群提供在帐户中的各资源组和区域中唯一的名称，以避免发生度量值命名冲突。不能重命名集群。</p>
  <p>对于以下场景，您可以为用户分配对资源组的访问角色。请注意，与资源实例不同，您无法授予对资源组中单个实例的访问权。</p>
  <ul><li>资源组中的所有 {{site.data.keyword.Bluemix_notm}} IAM 服务，包括 {{site.data.keyword.containerlong_notm}} 中的所有集群和 {{site.data.keyword.registrylong_notm}} 中的映像。</li>
  <li>资源组中服务内的所有实例，例如 {{site.data.keyword.containerlong_notm}} 中的所有集群。</li>
  <li>资源组中服务的区域内的所有实例，例如 {{site.data.keyword.containerlong_notm}} 的**美国南部**区域中的所有集群。</li></ul></dd>
</dl>

<br />


## 设置对集群的访问权
{: #access-checklist}

[了解帐户中的角色、用户和资源](#access_policies)的管理方式后，使用以下核对表来配置集群中的用户访问权。
{: shortdesc}

1. 对于要在其中创建集群的所有区域和资源组，[设置 API 密钥](#api_key)。
2. 邀请用户加入您的帐户，并[为用户分配 {{site.data.keyword.Bluemix_notm}} IAM 角色](#platform)以访问 {{site.data.keyword.containerlong_notm}}。
3. 要允许用户将服务绑定到集群或查看通过集群日志记录配置转发的日志，请[授予用户 Cloud Foundry 角色](/docs/iam/mngcf.html)，以访问将服务部署到其中或在其中收集日志的组织和空间。
4. 如果使用 Kubernetes 名称空间来隔离集群中的资源，请将 [IAM 平台**查看者**和**编辑者** {{site.data.keyword.Bluemix_notm}}角色的 Kubernetes RBAC 角色绑定复制到其他名称空间](#role-binding)。
5. 对于任何自动化工具（例如，在 CI/CD 管道中），设置服务帐户并[为服务帐户分配 Kubernetes RBAC 许可权](#rbac)。
6. 有关用于控制对 pod 级别集群资源的访问的其他高级配置，请参阅[配置 pod 安全性](/docs/containers/cs_psp.html)。

</br>

有关设置帐户和资源的更多信息，请尝试使用本教程中有关[组织用户、团队和应用程序的最佳实践](/docs/tutorials/users-teams-applications.html)的内容。
{: tip}

<br />


## 设置 API 密钥以启用对基础架构产品服务组合的访问
{: #api_key}

要成功供应和使用集群，必须确保 {{site.data.keyword.Bluemix_notm}} 帐户已正确设置为访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。
{: shortdesc}

**大多数情况**：{{site.data.keyword.Bluemix_notm}} 现买现付帐户已有权访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。要设置 {{site.data.keyword.containerlong_notm}} 来访问产品服务组合，**帐户所有者**必须为区域和资源组设置 API 密钥。

1. 以帐户所有者身份登录到终端。
    ```
    ibmcloud login [--sso]
    ```
    {: pre}

2. 将要在其中设置 API 密钥的资源组设定为目标。如果未将某个资源组设定为目标，那么会自动为缺省资源组设置 API 密钥。
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {:pre}

3. 如果您位于其他区域，请切换到要设置 API 密钥的区域。
    ```
ibmcloud ks region-set
```
    {: pre}

4. 为区域和资源组设置 API 密钥。
    ```
  ibmcloud ks api-key-reset
  ```
    {: pre}    

5. 验证 API 密钥是否已设置。
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
    {: pre}

6. 对于要在其中创建集群的每个区域和资源组重复上述操作。

**备用选项和更多信息**：有关访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的其他方式，请查看以下各部分。
* 如果不确定您的帐户是否有权访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合，请参阅[了解对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权](#understand_infra)。
* 如果帐户所有者未设置 API 密钥，请[确保设置 API 密钥的用户具有正确的许可权](#owner_permissions)。
* 有关使用缺省帐户设置 API 密钥的更多信息，请参阅[使用缺省 {{site.data.keyword.Bluemix_notm}} 现买现付帐户访问基础架构产品服务组合](#default_account)。
* 如果您没有缺省现买现付帐户或需要使用其他 IBM Cloud Infrastructure (SoftLayer) 帐户，请参阅[访问其他 IBM Cloud Infrastructure (SoftLayer) 帐户](#credentials)。

### 了解对 IBM Cloud infrastructure (SoftLayer) 产品服务组合的访问权
{: #understand_infra}

确定您的帐户是否有权访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合，并了解有关 {{site.data.keyword.containerlong_notm}} 如何使用 API 密钥来访问产品服务组合的信息。
{: shortdesc}

**我的帐户是否已有权访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合？**</br>

要访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合，请使用 {{site.data.keyword.Bluemix_notm}} 现买现付帐户。如果您具有其他类型的帐户，请在下表中查看您的选项。

<table summary="该表显示了按帐户类型列出的标准集群创建选项。每行从左到右阅读，其中第一列是帐户描述，第二列是用于创建标准集群的选项。">
    <caption>按帐户类型列出的标准集群创建选项</caption>
  <thead>
  <th>帐户描述</th>
  <th>用于创建标准集群的选项</th>
  </thead>
  <tbody>
    <tr>
      <td>**轻量帐户**无法供应集群。</td>
      <td>[将轻量帐户升级到 {{site.data.keyword.Bluemix_notm}} 现买现付帐户](/docs/account/index.html#paygo)。</td>
    </tr>
    <tr>
      <td>**现买现付**帐户随附对基础架构产品服务组合的访问权。</td>
      <td>可以创建标准集群。使用 API 密钥可为集群设置基础架构许可权。</td>
    </tr>
    <tr>
      <td>**预订帐户**未设置为具有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。</td>
      <td><p><strong>选项 1：</strong>[创建新的现买现付帐户](/docs/account/index.html#paygo)，该帐户设置为具有对 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的访问权。选择此选项时，您有两个单独的 {{site.data.keyword.Bluemix_notm}} 帐户和帐单。</p><p>如果要继续使用预订帐户，那么可以使用新的现买现付帐户在 IBM Cloud Infrastructure (SoftLayer) 中生成 API 密钥。然后，必须手动为预订帐户设置 IBM Cloud Infrastructure (SoftLayer) API 密钥。请记住，IBM Cloud Infrastructure (SoftLayer) 资源将通过新的现买现付帐户进行计费。</p><p><strong>选项 2：</strong>如果您已经拥有要使用的现有 IBM Cloud Infrastructure (SoftLayer) 帐户，那么可以为 {{site.data.keyword.Bluemix_notm}} 帐户手动设置 IBM Cloud Infrastructure (SoftLayer) 凭证。</p><p class="note">手动链接到 IBM Cloud Infrastructure (SoftLayer) 帐户时，凭证用于 {{site.data.keyword.Bluemix_notm}} 帐户中每个特定于 IBM Cloud Infrastructure (SoftLayer) 的操作。您必须确保设置的 API 密钥具有[足够的基础架构许可权](cs_users.html#infra_access)，以便用户可以创建和使用集群。</p></td>
    </tr>
    <tr>
      <td>**IBM Cloud infrastructure (SoftLayer) 帐户**，无 {{site.data.keyword.Bluemix_notm}} 帐户</td>
      <td><p>[创建 {{site.data.keyword.Bluemix_notm}} 现买现付帐户](/docs/account/index.html#paygo)。您有两个独立的 IBM Cloud Infrastructure (SoftLayer) 帐户，两者单独进行计费。</p><p>缺省情况下，新的 {{site.data.keyword.Bluemix_notm}} 帐户将使用新的基础架构帐户。要继续使用旧基础架构帐户，请手动设置凭证。</p></td>
    </tr>
  </tbody>
  </table>

**现在，我的基础架构产品服务组合已设置，{{site.data.keyword.containerlong_notm}} 会如何访问产品服务组合？**</br>

{{site.data.keyword.containerlong_notm}} 使用 API 密钥来访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。API 密钥用于存储有权访问 IBM Cloud Infrastructure (SoftLayer) 帐户的用户的凭证。API 密钥由资源组内的区域设置，并且由该区域中的用户共享。

要支持所有用户访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合，在 API 密钥中存储其凭证的用户必须在您的 {{site.data.keyword.Bluemix_notm}} 帐户中具有 [{{site.data.keyword.containerlong_notm}} 和 {{site.data.keyword.registryshort_notm}} 的**超级用户**基础架构角色和**管理员**平台角色](#owner_permissions)。然后，允许该用户在区域和资源组中执行第一个管理操作。用户的基础架构凭证会存储在该区域和资源组的 API 密钥中。

帐户内的其他用户将共享该 API 密钥来访问基础架构。当用户登录到 {{site.data.keyword.Bluemix_notm}} 帐户时，会针对 CLI 会话生成基于 API 密钥的 {{site.data.keyword.Bluemix_notm}} IAM 令牌，并支持与基础架构相关的命令在集群中运行。

要查看用于 CLI 会话的 {{site.data.keyword.Bluemix_notm}} IAM 令牌，可以运行 `ibmcloud iam oauth-tokens`。{{site.data.keyword.Bluemix_notm}} IAM 令牌还可用于[直接调用 {{site.data.keyword.containerlong_notm}} API](cs_cli_install.html#cs_api)。
{: tip}

**如果用户通过 {{site.data.keyword.Bluemix_notm}} IAM 令牌有权访问产品服务组合，我该如何限制用户可以运行的命令？**

为您帐户中的用户设置对产品服务组合的访问权之后，您可以通过分配相应的[平台角色](#platform)来控制用户可以执行哪些基础架构操作。通过将 {{site.data.keyword.Bluemix_notm}} IAM 角色分配给用户，可以限制用户可以对集群运行的命令。例如，由于 API 密钥所有者具有**超级用户**基础架构角色，因此可以在集群中运行所有与基础架构相关的命令。但是，根据分配给用户的 {{site.data.keyword.Bluemix_notm}} IAM 角色，用户只能运行其中某些与基础架构相关的命令。

例如，如果要在新区域中创建集群，请确保第一个集群由具有**超级用户**基础架构角色（例如，帐户所有者）的用户创建。此后，可以通过在该区域中为单个用户或 {{site.data.keyword.Bluemix_notm}} IAM 访问组中的用户设置平台管理策略，以邀请这些用户加入该区域。例如，具有**查看者**平台角色的用户无权添加工作程序节点。因此，`worker-add` 操作失败，尽管 API 密钥具有正确的基础架构许可权。如果将用户的平台角色更改为**操作员**，那么用户有权添加工作程序节点。`worker-add` 操作成功，因为用户已获得授权，并且 API 密钥设置正确。您无需编辑用户的 IBM Cloud Infrastructure (SoftLayer) 许可权。

要审计您帐户中的用户运行的操作，可以使用 [{{site.data.keyword.cloudaccesstrailshort}}](cs_at_events.html) 来查看所有与集群相关的事件。
{: tip}

**如果我不想为 API 密钥所有者或凭证所有者分配超级用户基础架构角色该怎么做？**</br>

出于合规性、安全性或计费原因，您可能不想将**超级用户**基础架构角色授予设置 API 密钥的用户或使用 `ibmcloud ks credential-set` 命令设置其凭证的用户。但是，如果此用户没有**超级用户**角色，那么与基础架构相关的操作（例如，创建集群或重新装入工作程序节点）可能会失败。您必须为用户[设置特定 IBM Cloud Infrastructure (SoftLayer) 许可权](#infra_access)，而不使用 {{site.data.keyword.Bluemix_notm}} IAM 平台角色来控制用户的基础架构访问权。

**如果设置区域和资源组的 API 密钥的用户离开了公司，会发生什么情况？**

如果用户离开组织，{{site.data.keyword.Bluemix_notm}} 帐户所有者可以除去该用户的许可权。但是，在除去用户的特定访问许可权或从帐户中完全除去用户之前，必须使用其他用户的基础架构凭证来重置 API 密钥。否则，帐户中的其他用户可能会失去对 IBM Cloud Infrastructure (SoftLayer) 门户网站的访问权，并且与基础架构相关的命令可能会失败。有关更多信息，请参阅[除去用户许可权](#removing)。

**如果我的 API 密钥泄露，我该如何锁定集群？**

如果为集群中的区域和资源组设置了 API 密钥，请[删除 API 密钥](../iam/userid_keys.html#deleting-an-api-key)，这样就无法再使用 API 密钥作为认证方式来进行其他调用。有关保护对 Kubernetes API 服务器的访问权的更多信息，请参阅 [Kubernetes API 服务器和 etcd](cs_secure.html#apiserver) 安全性主题。

**如何为集群设置 API 密钥？**</br>

这取决于要用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的帐户的类型：
* [缺省 {{site.data.keyword.Bluemix_notm}} 现买现付帐户](#default_account)
* [未链接到缺省 {{site.data.keyword.Bluemix_notm}} 现买现付帐户的其他 IBM Cloud Infrastructure (SoftLayer) 帐户](#credentials)

### 确保 API 密钥或基础架构凭证所有者具有正确的许可权
{: #owner_permissions}

要确保可以在集群中成功完成所有与基础架构相关的操作，您要为 API 密钥设置其凭证的用户必须具有正确的许可权。
{: shortdesc}

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/)。

2. 要确保可以成功执行与帐户相关的所有操作，请验证用户是否具有正确的 {{site.data.keyword.Bluemix_notm}} IAM 平台角色。
    1. 浏览至**管理 > 帐户 > 用户**。
    2. 单击要设置 API 密钥的用户的名称，或者单击要为 API 密钥设置其凭证的用户的名称。
    3. 如果用户对于所有区域中的所有 {{site.data.keyword.containerlong_notm}} 集群都不具有**管理员**平台角色，请[为用户分配该平台角色](#platform)。
    4. 如果用户对于要在其中设置 API 密钥的资源组并未至少具有**查看者**平台角色，请[为用户分配该资源组角色](#platform)。
    5. 要创建集群，用户还需要对 {{site.data.keyword.registrylong_notm}} 的帐户级别的**管理员**平台角色。不要将 {{site.data.keyword.registryshort_notm}} 的策略限制为资源组级别。

3. 要确保可以成功执行集群中与基础架构相关的所有操作，请验证用户是否具有正确的基础架构访问策略。
    1. 在菜单 ![“菜单”图标](../icons/icon_hamburger.svg "“菜单”图标") 中，选择**基础架构**。
    2. 在菜单栏中，选择**帐户** > **用户** > **用户列表**。
    3. 在 **API 密钥**列中，验证用户是否具有 API 密钥，如果没有，请单击**生成**。
    4. 选择用户概要文件的名称并检查用户的许可权。
    5. 如果用户没有**超级用户**角色，请单击**门户网站许可权**选项卡。
        1. 使用**快速许可权**下拉列表来分配**超级用户**角色。
        2. 单击**设置许可权**。

### 使用缺省 {{site.data.keyword.Bluemix_notm}} 现买现付帐户访问基础架构产品服务组合
{: #default_account}

如果您有 {{site.data.keyword.Bluemix_notm}} 现买现付帐户，那么缺省情况下您有权访问链接的 IBM Cloud Infrastructure (SoftLayer) 产品服务组合。API 密钥用于订购此 IBM Cloud Infrastructure (SoftLayer) 产品服务组合中的基础架构资源，例如新的工作程序节点或 VLAN。
{: shortdec}

您可以通过运行 [`ibmcloud ks api-key-info`](cs_cli_reference.html#cs_api_key_info) 来查找当前 API 密钥所有者。如果发现需要更新为某个区域存储的 API 密钥，那么可以通过运行 [`ibmcloud ks api-key-reset`](cs_cli_reference.html#cs_api_key_reset) 命令来执行此操作。此命令需要 {{site.data.keyword.containerlong_notm}} 管理员访问策略，并在帐户中存储执行此命令的用户的 API 密钥。

请确定您需要重置密钥并了解此操作对应用程序的影响。密钥会在多个不同位置中使用，如果进行不必要地更改，可能会导致重大更改。
{: note}

**开始之前**：
- 如果帐户所有者未设置 API 密钥，请[确保设置 API 密钥的用户具有正确的许可权](#owner_permissions)。
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

要设置用于访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合的 API 密钥，请执行以下操作：

1.  为集群所在的区域和资源组设置 API 密钥。
    1.  使用要使用其基础架构许可权的用户登录到终端。
    2.  将要在其中设置 API 密钥的资源组设定为目标。如果未将某个资源组设定为目标，那么会自动为缺省资源组设置 API 密钥。
        ```
        ibmcloud target -g <resource_group_name>
        ```
        {:pre}
    3.  如果您位于其他区域，请切换到要设置 API 密钥的区域。
        ```
        ibmcloud ks region-set
        ```
        {: pre}
    4.  设置该区域的用户 API 密钥。
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    5.  验证 API 密钥是否已设置。
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

2. [创建集群](cs_clusters.html)。要创建集群，请使用为区域和资源组设置的 API 密钥凭证。

### 访问其他 IBM Cloud Infrastructure (SoftLayer) 帐户
{: #credentials}

您可能希望使用已经拥有的其他 IBM Cloud Infrastructure (SoftLayer) 帐户，而不是使用缺省链接的 IBM Cloud Infrastructure (SoftLayer) 帐户来为区域内的集群订购基础架构。您可以使用 [`ibmcloud ks credential-set`](cs_cli_reference.html#cs_credentials_set) 命令将此基础架构帐户链接到 {{site.data.keyword.Bluemix_notm}} 帐户。这将使用 IBM Cloud infrastructure (SoftLayer) 凭证，而不使用为区域存储的缺省现买现付帐户凭证。
{: shortdesc}

`ibmcloud ks credential-set` 命令设置的 IBM Cloud Infrastructure (SoftLayer) 凭证在会话结束后仍然会持久存储。如果使用 [`ibmcloud ks credential-unset`](cs_cli_reference.html#cs_credentials_unset) 命令除去手动设置的 IBM Cloud Infrastructure (SoftLayer) 凭证，那么将使用缺省现买现付帐户凭证。但是，基础架构帐户凭证中的此更改可能导致[孤立集群](cs_troubleshoot_clusters.html#orphaned)。
{: important}

**开始之前**：
- 如果不打算使用帐户所有者的凭证，请[确保要为 API 密钥设置其凭证的用户具有正确的许可权](#owner_permissions)。
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

要设置用于访问 IBM Cloud infrastructure (SoftLayer) 产品服务组合的基础架构帐户凭证，请执行以下操作：

1. 获取要用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的基础架构帐户。根据您[当前的帐户类型](#understand_infra)，您会有不同的选项。

2.  为正确帐户的用户设置基础架构 API 凭证。

    1.  获取用户的基础架构 API 凭证。请注意，凭证与 IBM 标识不同。

        1.  在 [{{site.data.keyword.Bluemix_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/) 的**基础架构** > **帐户** > **用户** > **用户列表**表中，单击 **IBM 标识或用户名**。

        2.  在 **API 访问信息**部分中，查看 **API 用户名**和**认证密钥**。    

    2.  设置要使用的基础架构 API 凭证。
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

    3. 验证是否已设置正确的凭证。
        ```
        ibmcloud ks credential-get
        ```
输出示例：
        ```
        Infrastructure credentials for user name user@email.com set for resource group default.
        ```
        {: screen}

3. [创建集群](cs_clusters.html)。要创建集群，请使用为区域和资源组设置的基础架构凭证。

4. 验证集群是否使用的是您设置的基础架构帐户凭证。
  1. 打开 [{{site.data.keyword.containerlong_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/containers-kubernetes/clusters)，然后选择集群。
  2. 在“概述”选项卡中，查找**基础架构用户**字段。
  3. 如果看到此字段，那么请勿使用此区域中的现买现付帐户随附的缺省基础架构凭证。此区域会改为设置为使用您设置的其他基础架构帐户凭证。

<br />


## 通过 {{site.data.keyword.Bluemix_notm}} IAM 授予用户对集群的访问权
{: #platform}

在 [{{site.data.keyword.Bluemix_notm}} 控制台](#add_users)或 [CLI](#add_users_cli) 中设置 {{site.data.keyword.Bluemix_notm}} IAM 平台管理策略，以便用户可以使用 {{site.data.keyword.containerlong_notm}} 中的集群。开始之前，请先查看[了解访问权策略和角色](#access_policies)，以查看什么是策略，可为谁分配策略，以及可为哪些资源授予策略。
{: shortdesc}

无法为服务帐户分配 {{site.data.keyword.Bluemix_notm}} IAM 角色。可以改为直接[为服务帐户分配 RBAC 角色](#rbac)。
{: tip}

### 使用控制台分配 {{site.data.keyword.Bluemix_notm}} IAM 角色
{: #add_users}

通过使用 {{site.data.keyword.Bluemix_notm}} 控制台分配 {{site.data.keyword.Bluemix_notm}} IAM 平台管理角色，授予用户对集群的访问权。
{: shortdesc}

开始之前，请验证是否已为您分配了要在其中工作的 {{site.data.keyword.Bluemix_notm}} 帐户的**管理员**平台角色。

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)，并浏览至**管理 > 帐户 > 用户**。

2. 单独选择用户或创建用户的访问组。
    * 要为单个用户分配角色：
      1. 单击要为其设置许可权的用户的名称。如果该用户未显示，请单击**邀请用户**以将其添加到帐户。
      2. 单击**分配访问权**。
    * 要为访问组中的多个用户分配角色：
      1. 在左侧导航中，单击**访问组**。
      2. 单击**创建**，然后为组提供**名称**和**描述**。单击**创建**。
      3. 单击**添加用户**以将人员添加到访问组。这将显示有权访问帐户的用户的列表。
      4. 选中要添加到组的用户旁边的框。这将显示一个对话框。
      5. 单击**添加到组**。
      6. 单击**访问策略**。
      7. 单击**分配访问权**。

3. 分配策略。
  * 要访问资源组中的所有集群：
    1. 单击**在资源组中分配访问权**。
    2. 选择资源组名称。
    3. 从**服务**列表中，选择 **{{site.data.keyword.containershort_notm}}**。
    4. 从**区域**列表中，选择一个或所有区域。
    5. 选择**平台访问角色**。要查找每个角色的受支持操作列表，请参阅[用户访问许可权](/cs_access_reference.html#platform)。
    6. 单击**分配**。
  * 要访问一个资源组中的一个集群，或访问所有资源组中的所有集群：
    1. 单击**分配对资源的访问权**。
    2. 从**服务**列表中，选择 **{{site.data.keyword.containershort_notm}}**。
    3. 从**区域**列表中，选择一个或所有区域。
    4. 从**服务实例**列表中，选择集群名称或**所有服务实例**。
    5. 在**选择角色**部分中，选择 {{site.data.keyword.Bluemix_notm}} IAM 平台访问角色。要查找每个角色的受支持操作列表，请参阅[用户访问许可权](/cs_access_reference.html#platform)。注：如果为用户分配了仅对一个集群的**管理员**平台角色，那么还必须为用户分配对该资源组的该区域内所有集群的**查看者**平台角色。
    6. 单击**分配**。

4. 如果希望用户能够使用非缺省资源组中的集群，那么这些用户需要对集群所在的资源组的其他访问权。您可以为这些用户至少分配对资源组的**查看者**平台角色。
  1. 单击**在资源组中分配访问权**。
  2. 选择资源组名称。
  3. 从**分配对资源组的访问权**列表中，选择**查看者**角色。此角色允许用户访问资源组本身，但不允许访问组内的资源。
  4. 单击**分配**。

### 使用 CLI 分配 {{site.data.keyword.Bluemix_notm}} IAM 角色
{: #add_users_cli}

通过使用 CLI 分配 {{site.data.keyword.Bluemix_notm}} IAM 平台管理角色，授予用户对集群的访问权。
{: shortdesc}

**开始之前**：

- 验证是否已为要在其中工作的 {{site.data.keyword.Bluemix_notm}} 帐户分配了 IAM 平台 `cluster-admin` {{site.data.keyword.Bluemix_notm}} 角色。
- 验证用户是否已添加到该帐户。如果用户未添加到该帐户，请通过运行 `ibmcloud account user-invite <user@email.com>`.
- [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](cs_cli_install.html#cs_cli_configure)。

**使用 CLI 将 {{site.data.keyword.Bluemix_notm}} IAM 角色分配给单个用户：**

1.  创建 {{site.data.keyword.Bluemix_notm}} IAM 访问策略以设置 {{site.data.keyword.containerlong_notm}} 的许可权 (**`--service-name containers-kubernetes`**)。对于平台角色，您可以选择“查看者”、“编辑者”、“操作员”和“管理员”。要查找每个角色的受支持操作列表，请参阅[用户访问许可权](cs_access_reference.html#platform)。
    * 分配对一个资源组中一个集群的访问权：
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **注**：如果为用户分配了仅对一个集群的**管理员**平台角色，那么还必须为用户分配对该资源组的该区域内所有集群的**查看者**平台角色。

    * 分配对一个资源组中所有集群的访问权：
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

    * 分配对所有资源组中所有集群的访问权：
      ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
  ```
      {: pre}

2. 如果希望用户能够使用非缺省资源组中的集群，那么这些用户需要对集群所在的资源组的其他访问权。您可以为这些用户至少分配对资源组的**查看者**角色。可以通过运行 `ibmcloud resource group <resource_group_name> --id` 来查找资源组标识。
    ```
    ibmcloud iam user-policy-create <user-email_OR_access-group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

3. 要使更改生效，请刷新集群配置。
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

4. {{site.data.keyword.Bluemix_notm}} IAM 平台角色将自动应用为相应的 [RBAC 角色绑定或集群角色绑定](#role-binding)。通过对分配的平台角色运行下列其中一个命令，验证用户是否已添加到 RBAC 角色：
    * 查看者：
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * 编辑者：
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * 操作员：
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * 管理员：
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  例如，如果为用户 `john@email.com` 分配了**查看者**平台角色并运行了 `kubectl get rolebinding ibm-view -o yaml -n default`，那么输出如下所示：

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
  ```
  {: screen}


**使用 CLI 为访问组中的多个用户分配 {{site.data.keyword.Bluemix_notm}} IAM 平台角色：**

1. 创建访问组。
    ```
    ibmcloud iam access-group-create <access_group_name>
    ```
    {: pre}

2. 将用户添加到访问组。
    ```
    ibmcloud iam access-group-user-add <access_group_name> <user_email>
    ```
    {: pre}

3. 创建 {{site.data.keyword.Bluemix_notm}} IAM 访问策略以设置 {{site.data.keyword.containerlong_notm}} 的许可权。对于平台角色，您可以选择“查看者”、“编辑者”、“操作员”和“管理员”。要查找每个角色的受支持操作列表，请参阅[用户访问许可权](/cs_access_reference.html#platform)。
  * 分配对一个资源组中一个集群的访问权：
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      如果为用户分配了仅对一个集群的**管理员**平台角色，那么还必须为用户分配对该资源组的该区域内所有集群的**查看者**平台角色。
      {: note}

  * 分配对一个资源组中所有集群的访问权：
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

  * 分配对所有资源组中所有集群的访问权：
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

4. 如果希望用户能够使用非缺省资源组中的集群，那么这些用户需要对集群所在的资源组的其他访问权。您可以为这些用户至少分配对资源组的**查看者**角色。可以通过运行 `ibmcloud resource group <resource_group_name> --id` 来查找资源组标识。
    ```
    ibmcloud iam access-group-policy-create <access_group_name> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

    1. 如果已分配对所有资源组中所有集群的访问权，请对帐户中的每个资源组重复此命令。

5. 要使更改生效，请刷新集群配置。
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

6. {{site.data.keyword.Bluemix_notm}} IAM 平台角色将自动应用为相应的 [RBAC 角色绑定或集群角色绑定](#role-binding)。通过对分配的平台角色运行下列其中一个命令，验证用户是否已添加到 RBAC 角色：
    * 查看者：
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * 编辑者：
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * 操作员：
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * 管理员：
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  例如，如果为访问组 `team1` 分配了**查看者**平台角色并运行了 `kubectl get rolebinding ibm-view -o yaml -n default`，那么输出如下所示：
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



- 要为单个用户或访问组中的用户分配访问权，请确保已在 {{site.data.keyword.containerlong_notm}} 服务级别为用户或组分配了至少一个 [{{site.data.keyword.Bluemix_notm}}IAM 平台角色](#platform)。

要创建定制 RBAC 许可权，请执行以下操作：

1. 创建具有要分配的访问权的角色或集群角色。

    1. 创建 `.yaml` 文件以定义角色或集群角色。

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
        <caption>了解 YAML 的组成部分</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 的组成部分</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>使用 `Role` 来授予对特定名称空间中资源的访问权。使用 `ClusterRole` 来授予对集群范围资源（如工作程序节点）的访问权，或授予对所有名称空间中作用域限定为名称空间的资源（如 pod）的访问权。</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>对于运行 Kubernetes 1.8 或更高版本的集群，请使用 `rbac.authorization.k8s.io/v1`。</li><li>对于更早的版本，请使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>仅限 kind 为 `Role` 的情况：指定授予其访问权的 Kubernetes 名称空间。</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>对角色或集群角色命名。</td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>指定您希望用户能够与之进行交互的 Kubernetes [API 组 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)，例如 `"apps"`、`"batch"` 或 `"extensions"`。要访问 REST 路径 `api/v1` 上的核心 API 组，请将该组保留为空：`[""]`。</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>指定要授予其访问权的 Kubernetes [资源类型 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)，例如 `"daemonsets"`、`"deployments"`、`"events"` 或 `"ingresses"`。如果指定 `"nodes"`，那么 kind 必须为 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>指定希望用户能够执行的[操作 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/) 的类型，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</td>
            </tr>
          </tbody>
        </table>

    2. 在集群中创建角色或集群角色。

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. 验证角色或集群角色是否已创建。
      * 角色：
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * 集群角色：
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. 将用户绑定到角色或集群角色。

    1. 创建 `.yaml` 文件以将用户绑定到角色或集群角色。记下用于每个主体名称的唯一 URL。

        ```
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

        <table>
        <caption>了解 YAML 的组成部分</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 的组成部分</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>对于特定于名称空间的 `Role` 或 `ClusterRole`，指定 `RoleBinding`。</li><li>对于集群范围的 `ClusterRole`，指定 `ClusterRoleBinding`。</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>对于运行 Kubernetes 1.8 或更高版本的集群，请使用 `rbac.authorization.k8s.io/v1`。</li><li>对于更早的版本，请使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>对于 kind 为 `RoleBinding` 的情况：指定授予其访问权的 Kubernetes 名称空间。</li><li>对于 kind 为 `ClusterRoleBinding` 的情况：请勿使用 `namespace` 字段。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>对角色绑定或集群角色绑定命名。</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>将种类指定为以下某项：<ul><li>`User`：将 RBAC 角色或集群角色绑定到帐户中的单个用户。</li>
              <li>`Group`：对于运行 Kubernetes 1.11 或更高版本的集群，将 RBAC 角色或集群角色绑定到帐户中的 [{{site.data.keyword.Bluemix_notm}}IAM 访问组](/docs/iam/groups.html#groups)。</li>
              <li>`ServiceAccount`：将 RBAC 角色或集群角色绑定到集群的名称空间中的服务帐户。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>对于 `User`：将单个用户的电子邮件地址附加到下列其中一个 URL。<ul><li>对于运行 Kubernetes 1.11 或更高版本的集群：<code>IAM#user@email.com</code></li><li>对于运行 Kubernetes 1.10 或更低版本的集群：<code>https://iam.ng.bluemix.net/kubernetes#user@email.com</code></li></ul></li>
              <li>对于 `Group`：对于运行 Kubernetes 1.11 或更高版本的集群，指定帐户中 [{{site.data.keyword.Bluemix_notm}} IAM 访问组](/docs/iam/groups.html#groups)的名称。</li>
              <li>对于 `ServiceAccount`：指定服务帐户名称。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>对于 `User` 或 `Group`：使用 `rbac.authorization.k8s.io`。</li>
              <li>对于 `ServiceAccount`：请勿包含此字段。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>仅限 `ServiceAccount`：指定要将服务帐户部署到的 Kubernetes 名称空间的名称。</td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>在角色 `.yaml` 文件中输入与 `kind` 相同的值：`Role` 或 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>输入角色 `.yaml` 文件的名称。</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>使用 `rbac.authorization.k8s.io`。</td>
            </tr>
          </tbody>
        </table>

    2. 在集群中创建角色绑定或集群角色绑定资源。

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  验证绑定是否已创建。

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

3. （可选）要强制将相同的用户访问级别应用于其他名称空间，可以将这些角色或集群角色的角色绑定复制到其他名称空间。
    1. 将角色绑定从一个名称空间复制到其他名称空间。
        ```
        kubectl get rolebinding <role_binding_name> -o yaml | sed 's/<namespace_1>/<namespace_2>/g' | kubectl -n <namespace_2> create -f -
        ```
        {: pre}

        例如，将 `custom-role` 角色绑定从 `default` 名称空间复制到 `testns` 名称空间：
        ```
        kubectl get rolebinding custom-role -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
        ```
        {: pre}

    2. 验证角色绑定是否已复制。如果已将 {{site.data.keyword.Bluemix_notm}} IAM 访问组添加到角色绑定，那么会分别添加该组中的每个用户，而不会作为访问组标识添加。
        ```
        kubectl get rolebinding -n <namespace_2>
        ```
        {: pre}

即然您已经创建并绑定了定制 Kubernetes RBAC 角色或集群角色，接下来该由用户进行操作。请要求用户测试根据其角色有权完成的操作，例如删除 pod。

<br />


</staging>

## 分配 RBAC 许可权
{: #role-binding}

使用 RBAC 角色定义用户可以执行以使用集群中 Kubernetes 资源的操作。
{: shortdesc}

**什么是 RBAC 角色和集群角色？**</br>

RBAC 角色和集群角色定义了一组许可权，确定用户可以如何与集群中的 Kubernetes 资源进行交互。角色的作用域限定为特定名称空间（如部署）中的资源。集群角色的作用域限定为集群范围的资源（如工作程序节点），或限定为可在每个名称空间中找到的作用域限定于名称空间的资源（如 pod）。

**什么是 RBAC 角色绑定和集群角色绑定？**</br>

角色绑定将 RBAC 角色或集群角色应用于特定名称空间。使用角色绑定来应用角色时，即授予用户对特定名称空间中特定资源的访问权。使用角色绑定来应用集群角色时，即授予用户对可在每个名称空间中找到的作用域限定于名称空间的资源（如 pod）的访问权，但仅限于访问该特定名称空间内的资源。

集群角色绑定将 RBAC 集群角色应用于集群中的所有名称空间。使用集群角色绑定来应用集群角色时，即授予用户对集群范围资源（如工作程序节点）的访问权，或授予用户对每个名称空间中作用域限定于名称空间的资源（如 pod）的访问权。

**在集群中这些角色是怎样的？**</br>

分配有 [{{site.data.keyword.Bluemix_notm}}IAM 平台管理角色](#platform)的每个用户都将自动分配有相应的 RBAC 集群角色。这些 RBAC 集群角色是预定义的，并允许用户与集群中的 Kubernetes 资源进行交互。此外，还会创建角色绑定以将集群角色应用于特定名称空间，或创建集群角色绑定以将集群角色应用于所有名称空间。

下表描述了 {{site.data.keyword.Bluemix_notm}} 平台角色与为平台角色自动创建的相应集群角色和角色绑定或集群角色绑定之间的关系。

<table>
  <tr>
    <th>{{site.data.keyword.Bluemix_notm}} IAM 平台角色</th>
    <th>RBAC 集群角色</th>
    <th>RBAC 角色绑定</th>
    <th>RBAC 集群角色绑定</th>
  </tr>
  <tr>
    <td>查看者</td>
    <td><code>view</code></td>
    <td><code>ibm-view</code>（在缺省名称空间中）</td>
    <td>-</td>
  </tr>
  <tr>
    <td>编辑者</td>
    <td><code>edit</code></td>
    <td><code>ibm-edit</code>（在缺省名称空间中）</td>
    <td>-</td>
  </tr>
  <tr>
    <td>操作员</td>
    <td><code>admin</code></td>
    <td>-</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>管理员</td>
    <td><code>cluster-admin</code></td>
    <td>-</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

要了解有关每个 RBAC 角色所允许的操作的更多信息，请查看[用户访问许可权](cs_access_reference.html#platform)参考主题。
{: tip}

**如何管理集群中特定名称空间的 RBAC 许可权？**

如果[使用 Kubernetes 名称空间对集群分区并为工作负载提供隔离](cs_secure.html#container)，那么必须为用户分配对特定名称空间的访问权。为用户分配**操作员**或**管理员**平台角色后，相应的 `admin` 和 `cluster-admin` 预定义集群角色会自动应用于整个集群。但是，为用户分配**查看者**或**编辑者**平台角色后，相应的 `view` 和 `edit` 预定义集群角色只会自动应用于缺省名称空间。要强制将相同的用户访问级别应用于其他名称空间，可以[复制角色绑定](#rbac_copy)（即这些集群角色的角色绑定）`ibm-view` 和 `ibm-edit` 到其他名称空间。

**可以创建定制角色或集群角色吗？**

`view`、`edit`、`admin` 和 `cluster-admin` 集群角色是预定义角色，在为用户分配相应的 {{site.data.keyword.Bluemix_notm}} IAM 平台角色时会自动创建。要授予其他 Kubernetes 许可权，可以[创建定制 RBAC 许可权](#rbac)。

**何时需要使用未与我设置的 {{site.data.keyword.Bluemix_notm}} IAM 许可权绑定的集群角色绑定和角色绑定？**

您可能希望授权谁可以在集群中创建和更新 pod。通过 [pod 安全策略](https://console.bluemix.net/docs/containers/cs_psp.html#psp)，您可以使用集群随附的现有集群角色绑定，也可以创建自己的集群角色绑定。

您可能还希望将附加组件集成到集群。例如，[在集群中设置 Helm](cs_integrations.html#helm) 时，必须在 `kube-system` 名称空间中为 Tiller 创建服务帐户，并为 `tiller-deploy` pod 创建 Kubernetes RBAC 集群角色绑定。

### 将 RBAC 角色绑定复制到其他名称空间
{: #rbac_copy}

某些角色和集群角色仅应用于一个名称空间。例如，`view` 和 `edit` 预定义集群角色仅自动应用于 `default` 名称空间。要强制将相同的用户访问级别应用于其他名称空间，可以将这些角色或集群角色的角色绑定复制到其他名称空间。
{: shortdesc}

例如，假设为用户“john@email.com”分配了**编辑者**平台管理角色。这将自动在集群中创建预定义的 RBAC 集群角色 `edit`，并且 `ibm-edit` 角色绑定会将许可权应用于 `default` 名称空间。您希望“john@email.com”在开发名称空间中也具有“编辑者”访问权，因此将 `ibm-edit` 角色绑定从 `default` 复制到了 `development`。**注**：每次向 `view` 或 `edit` 角色添加用户时，都必须复制角色绑定。

1. 将角色绑定从 `default` 名称空间复制到其他名称空间。
    ```
    kubectl get rolebinding <role_binding_name> -o yaml | sed 's/default/<namespace>/g' | kubectl -n <namespace> create -f -
    ```
    {: pre}

    例如，要将 `ibm-edit` 角色绑定复制到 `testns` 名称空间：
    ```
    kubectl get rolebinding ibm-edit -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
    ```
    {: pre}

2. 验证是否复制了 `ibm-edit` 角色绑定。
    ```
    kubectl get rolebinding -n <namespace>
    ```
    {: pre}

<br />


### 为用户、组或服务帐户创建定制 RBAC 许可权
{: #rbac}

在为用户分配相应的 {{site.data.keyword.Bluemix_notm}} IAM 平台管理角色时，会自动创建 `view`、`edit`、`admin` 和 `cluster-admin` 集群角色。需要集群访问策略的详细程度高于这些预定义许可权所允许的详细程度吗？没问题！您可以创建定制 RBAC 角色和集群角色。
{: shortdesc}

您可以将定制 RBAC 角色和集群角色分配给单个用户、用户组（在运行 Kubernetes V1.11 或更高版本的集群中）或服务帐户。为组创建绑定时，会影响添加到组中或从组中除去的任何用户。将用户添加到组时，除了您授予用户的任何单个访问权之外，他们还会获得组的访问权。如果从组中除去用户，那么将撤销其访问权。
**注**：您无法向访问组添加服务帐户。

如果要分配对在 pod 中运行的进程（例如，持续交付工具链）的访问权，可以使用 [Kubernetes 服务帐户 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)。要遵循演示如何为 Travis 和 Jenkins 设置服务帐户以及为服务帐户分配定制 RBAC 角色的教程，请参阅博客帖子 [Kubernetes ServiceAccounts for use in automated systems ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982)。

**注**：为了避免发生重大更改，请勿更改预定义的 `view`、`edit`、`admin` 和 `cluster-admin` 集群角色。

**我是否要创建角色或集群角色？是否要通过角色绑定或集群角色绑定来应用此角色？**

* 要允许用户、访问组或服务帐户访问特定名称空间中的资源，请选择下列其中一个组合：
  * 创建角色，然后通过角色绑定来应用该角色。要控制对仅在一个名称空间（如应用程序部署）中存在的唯一资源的访问，此选项非常有用。
  * 创建集群角色，然后通过角色绑定来应用该角色。要控制对一个名称空间中常规资源（如 pod）的访问，此选项非常有用。
* 要允许用户或访问组访问集群范围的资源或访问所有名称空间中的资源，请创建集群角色，然后通过集群角色绑定来应用该角色。要控制对未将作用域限定为名称空间的资源（如工作程序节点）的访问，或控制对集群中所有名称空间中资源（如每个名称空间中的 pod）的访问，此选项非常有用。

开始之前：

- 设定 [Kubernetes CLI](cs_cli_install.html#cs_cli_configure) 的目标为集群。
- 要为单个用户或访问组中的用户分配访问权，请确保已在 {{site.data.keyword.containerlong_notm}} 服务级别为用户或组分配了至少一个 [{{site.data.keyword.Bluemix_notm}}IAM 平台角色](#platform)。

要创建定制 RBAC 许可权，请执行以下操作：

1. 创建具有要分配的访问权的角色或集群角色。

    1. 创建 `.yaml` 文件以定义角色或集群角色。

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
        <caption>了解 YAML 的组成部分</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 的组成部分</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>使用 `Role` 来授予对特定名称空间中资源的访问权。使用 `ClusterRole` 来授予对集群范围资源（如工作程序节点）的访问权，或授予对所有名称空间中作用域限定为名称空间的资源（如 pod）的访问权。</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>对于运行 Kubernetes 1.8 或更高版本的集群，请使用 `rbac.authorization.k8s.io/v1`。</li><li>对于更早的版本，请使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>仅限 kind 为 `Role` 的情况：指定授予其访问权的 Kubernetes 名称空间。</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>对角色或集群角色命名。</td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>指定您希望用户能够与之进行交互的 Kubernetes [API 组 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)，例如 `"apps"`、`"batch"` 或 `"extensions"`。要访问 REST 路径 `api/v1` 上的核心 API 组，请将该组保留为空：`[""]`。</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>指定要授予其访问权的 Kubernetes [资源类型 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)，例如 `"daemonsets"`、`"deployments"`、`"events"` 或 `"ingresses"`。如果指定 `"nodes"`，那么 kind 必须为 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>指定希望用户能够执行的[操作 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/) 的类型，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</td>
            </tr>
          </tbody>
        </table>

    2. 在集群中创建角色或集群角色。

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. 验证角色或集群角色是否已创建。
      * 角色：
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * 集群角色：
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. 将用户绑定到角色或集群角色。

    1. 创建 `.yaml` 文件以将用户绑定到角色或集群角色。记下用于每个主体名称的唯一 URL。

        ```
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

        <table>
        <caption>了解 YAML 的组成部分</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 的组成部分</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>对于特定于名称空间的 `Role` 或 `ClusterRole`，指定 `RoleBinding`。</li><li>对于集群范围的 `ClusterRole`，指定 `ClusterRoleBinding`。</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>对于运行 Kubernetes 1.8 或更高版本的集群，请使用 `rbac.authorization.k8s.io/v1`。</li><li>对于更早的版本，请使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>对于 kind 为 `RoleBinding` 的情况：指定授予其访问权的 Kubernetes 名称空间。</li><li>对于 kind 为 `ClusterRoleBinding` 的情况：请勿使用 `namespace` 字段。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>对角色绑定或集群角色绑定命名。</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>将种类指定为以下某项：<ul><li>`User`：将 RBAC 角色或集群角色绑定到帐户中的单个用户。</li>
              <li>`Group`：对于运行 Kubernetes 1.11 或更高版本的集群，将 RBAC 角色或集群角色绑定到帐户中的 [{{site.data.keyword.Bluemix_notm}}IAM 访问组](/docs/iam/groups.html#groups)。</li>
              <li>`ServiceAccount`：将 RBAC 角色或集群角色绑定到集群的名称空间中的服务帐户。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>对于 `User`：将单个用户的电子邮件地址附加到下列其中一个 URL。<ul><li>对于运行 Kubernetes 1.11 或更高版本的集群：<code>IAM#user@email.com</code></li><li>对于运行 Kubernetes 1.10 或更低版本的集群：<code>https://iam.ng.bluemix.net/kubernetes#user@email.com</code></li></ul></li>
              <li>对于 `Group`：对于运行 Kubernetes 1.11 或更高版本的集群，指定帐户中 [{{site.data.keyword.Bluemix_notm}}IAM 组](/docs/iam/groups.html#groups)的名称。</li>
              <li>对于 `ServiceAccount`：指定服务帐户名称。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>对于 `User` 或 `Group`：使用 `rbac.authorization.k8s.io`。</li>
              <li>对于 `ServiceAccount`：请勿包含此字段。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>仅限 `ServiceAccount`：指定要将服务帐户部署到的 Kubernetes 名称空间的名称。</td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>在角色 `.yaml` 文件中输入与 `kind` 相同的值：`Role` 或 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>输入角色 `.yaml` 文件的名称。</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>使用 `rbac.authorization.k8s.io`。</td>
            </tr>
          </tbody>
        </table>

    2. 在集群中创建角色绑定或集群角色绑定资源。

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  验证绑定是否已创建。

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

即然您已经创建并绑定了定制 Kubernetes RBAC 角色或集群角色，接下来该由用户进行操作。请要求用户测试根据其角色有权完成的操作，例如删除 pod。

<br />




## 定制基础架构许可权
{: #infra_access}

将**超级用户**基础架构角色分配给设置 API 密钥或设置其基础架构凭证的管理员时，帐户中的其他用户将共享用于执行基础架构操作的 API 密钥或凭证。然后，您可以通过分配相应的 [{{site.data.keyword.Bluemix_notm}}IAM 平台角色](#platform)来控制用户可以执行哪些基础架构操作。您无需编辑用户的 IBM Cloud infrastructure (SoftLayer) 许可权。
{: shortdesc}

出于合规性、安全性或计费原因，您可能不想将**超级用户**基础架构角色授予设置 API 密钥的用户或使用 `ibmcloud ks credential-set` 命令设置其凭证的用户。但是，如果此用户没有**超级用户**角色，那么与基础架构相关的操作（例如，创建集群或重新装入工作程序节点）可能会失败。您必须为用户设置特定 IBM Cloud Infrastructure (SoftLayer) 许可权，而不使用 {{site.data.keyword.Bluemix_notm}} IAM 平台角色来控制用户的基础架构访问权。

如果您有多专区集群，那么 IBM Cloud Infrastructure (SoftLayer) 帐户所有者需要启用 VLAN 生成，以便不同专区中的节点可以在集群中进行通信。帐户所有者还可以为用户分配**网络 > 管理网络 VLAN 生成**许可权，以便用户能够启用 VLAN 生成。
要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](cs_cli_reference.html#cs_vlan_spanning_get)。
{: tip}

开始之前，请确保您是帐户所有者，或者具有**超级用户**和所有设备访问权。您无法授予用户您自己没有的访问权。

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)，并浏览至**管理 > 帐户 > 用户**。

2. 单击要为其设置许可权的用户的名称。

3. 单击**分配访问权**，然后单击**为 SoftLayer 帐户分配访问权**。

4. 单击**门户网站许可权**选项卡以定制用户的访问权。用户所需的许可权取决于用户需要使用的基础架构资源。您具有两个访问权分配选项：
    * 使用**快速许可权**下拉列表来分配下列其中一个预定义角色。选择角色后，单击**设置许可权**。
        * **仅查看用户**授予用户仅查看基础架构详细信息的许可权。
        * **基本用户**授予用户一些（但不是全部）基础架构许可权。
        * **超级用户**授予用户所有基础架构许可权。
    * 在每个选项卡中选择各个许可权。要查看在 {{site.data.keyword.containerlong_notm}} 中执行常见任务所需的许可权，请参阅[用户访问许可权](cs_access_reference.html#infra)。

5.  要保存更改，请单击**编辑门户网站许可权**。

6.  在**设备访问权**选项卡中，选择要向其授予访问权的设备。

    * 在**设备类型**下拉列表中，可以授予对**所有设备**的访问权，以便用户可以使用工作程序节点的虚拟和物理（裸机硬件）机器类型。
    * 要允许用户访问所创建的新设备，请选择**添加新设备时自动授予访问权**。
    * 在设备表中，确保选择了相应的设备。

7. 要保存更改，请单击**更新设备访问权**。

要降级许可权？此操作可能需要几分钟才能完成。
{: tip}

<br />


## 除去用户许可权
{: #removing}

如果用户不再需要特定的访问许可权，或者如果用户离开组织，{{site.data.keyword.Bluemix_notm}} 帐户所有者可以除去该用户的许可权。
{: shortdesc}

但是，在除去用户的特定访问许可权或从帐户中完全除去用户之前，请确保该用户的基础架构凭证未用于设置 API 密钥，也未用于 `ibmcloud ks credential-set` 命令。否则，帐户中的其他用户可能会失去对 IBM Cloud Infrastructure (SoftLayer) 门户网站的访问权，并且与基础架构相关的命令可能会失败。
{: important}

1. 将 CLI 上下文的目标设定为您在其中具有集群的区域和资源组。
    ```
    ibmcloud target -g <resource_group_name> -r <region>
    ```
    {: pre}

2. 检查为该区域和资源组设置的 API 密钥或基础架构凭证的所有者。
    * 如果使用了[用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的 API 密钥](#default_account)：
        ```
        ibmcloud ks api-key-info --cluster <cluster_name_or_id>
        ```
        {: pre}
    * 如果设置了[用于访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的基础架构帐户凭证](#credentials)：
        ```
        ibmcloud ks credential-get
        ```
        {: pre}

3. 如果返回用户的用户名，请使用其他用户的凭证来设置 API 密钥或基础架构凭证。

  如果帐户所有者未设置 API 密钥，或者如果您未设置帐户所有者的基础架构凭证，请[确保设置 API 密钥的用户或要设置其凭证的用户具有正确的许可权](#owner_permissions)。
  {: note}

    * 重置 API 密钥：
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}
    * 重置基础架构凭证：
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4. 对您在其中具有集群的资源组和区域的每个组合重复这些步骤。

### 从帐户中除去用户
{: #remove_user}

如果您帐户中的某个用户离开组织，请务必小心地除去该用户的许可权，以确保您不会使集群或其他资源孤立。然后，可以从 {{site.data.keyword.Bluemix_notm}} 帐户中除去该用户。
{: shortdesc}

开始之前：
- [确保用户的基础架构凭证未用于设置 API 密钥，也未用于 `ibmcloud ks credential-set` 命令](#removing)。
- 如果 {{site.data.keyword.Bluemix_notm}} 帐户中有该用户可能供应的其他服务实例，请查看这些服务的文档，以了解在从帐户中除去该用户之前必须完成的任何步骤。

在用户离开之前，{{site.data.keyword.Bluemix_notm}} 帐户所有者必须完成以下步骤以防止 {{site.data.keyword.containerlong_notm}} 中发生中断性更改。

1. 确定用户创建的集群。
    1.  登录到 [{{site.data.keyword.containerlong_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/containers-kubernetes/clusters)。
    2.  从表中选择您的集群。
    3.  在**概述**选项卡中，查找**所有者**字段。

2. 对于用户创建的每个集群，执行以下步骤：
    1. 检查用户使用了哪个基础架构帐户来供应集群。
        1.  在**工作程序节点**选项卡中，选择工作程序节点，并记下其**标识**。
        2.  打开菜单 ![“菜单”图标](../icons/icon_hamburger.svg "“菜单”图标")，然后单击**基础架构**。
        3.  在基础架构导航窗格中，单击**设备 > 设备列表**。
        4.  搜索您先前记下的工作程序节点标识。
        5.  如果找不到工作程序节点标识，说明工作程序节点未供应到此基础架构帐户中。请切换到其他基础架构帐户，然后重试。
    2. 确定用户离开后，该用户用于供应集群的基础架构帐户会发生什么情况。
        * 如果用户不拥有基础架构帐户，那么在该用户离开后，其他用户有权访问此基础架构帐户，并且此帐户会持久存储。您可以继续在帐户中使用这些集群。请确保另外至少有一个用户具有对这些集群的[**管理员**平台角色](#platform)。
        * 如果用户拥有基础架构帐户，那么在该用户离开时将删除此基础架构帐户。您无法继续使用这些集群。要防止集群变成孤立集群，用户必须在离开之前先删除这些集群。如果用户已离开，但未删除集群，那么您必须使用 `ibmcloud ks credential-set` 命令将基础架构凭证更改为供应集群工作程序节点的帐户，然后删除本该删除的集群。有关更多信息，请参阅[无法修改或删除孤立集群中的基础架构](cs_troubleshoot_clusters.html#orphaned)。

3. 从 {{site.data.keyword.Bluemix_notm}} 帐户中除去用户。
    1. 浏览至**管理 > 帐户 > 用户**。
    2. 单击用户的用户名。
    3. 在用户的表条目中，单击“操作”菜单，然后选择**除去用户**。除去用户时，会自动除去为用户分配的 {{site.data.keyword.Bluemix_notm}} IAM 平台角色、Cloud Foundry 角色和 IBM Cloud Infrastructure (SoftLayer) 角色。

4. 除去 {{site.data.keyword.Bluemix_notm}} IAM 平台许可权时，还会自动从关联的预定义 RBAC 角色中除去用户的许可权。但是，如果创建的是定制 RBAC 角色或集群角色，请[从 RBAC 角色绑定或集群角色绑定中除去用户](#remove_custom_rbac)。

5. 如果您有自动链接到 {{site.data.keyword.Bluemix_notm}} 帐户的现买现付帐户，那么会自动除去用户的 IBM Cloud Infrastructure (SoftLayer) 角色。但是，如果您有[其他类型的帐户](#understand_infra)，那么可能需要从 IBM Cloud Infrastructure (SoftLayer) 中手动除去该用户。
    1. 在 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)菜单 ![“菜单”图标](../icons/icon_hamburger.svg "“菜单”图标") 中，单击**基础架构**。
    2. 浏览至**帐户 > 用户 > 用户列表**。
    2. 查找用户的表条目。
        * 如果您看不到该用户的条目，说明已经除去该用户。无需执行进一步的操作。
        * 如果您确实看到该用户的条目，请继续执行下一步。
    3. 在用户的表条目中，单击“操作”菜单。
    4. 选择**更改用户状态**。
    5. 在“状态”列表中，选择**已禁用**。单击**保存**。


### 除去特定许可权
{: #remove_permissions}

如果要除去某个用户的特定许可权，您可以除去已分配给该用户的单个访问策略。
{: shortdesc}

开始之前，请[确保用户的基础架构凭证未用于设置 API 密钥，也未用于 `ibmcloud ks credential-set` 命令](#removing)。在此之后，您可以执行以下除去操作：
* [从访问组中除去用户](#remove_access_group)
* [除去用户的 {{site.data.keyword.Bluemix_notm}} IAM 平台许可权和关联的 RBAC 许可权](#remove_iam_rbac)
* [除去用户的定制 RBAC 许可权](#remove_custom_rbac)
* [除去用户的 Cloud Foundry 许可权](#remove_cloud_foundry)
* [除去用户的基础架构许可权](#remove_infra)

#### 从访问组中除去用户
{: #remove_access_group}

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)，并浏览至**管理 > 帐户 > 用户**。
2. 单击要除去其许可权的用户的名称。
3. 单击**访问组**选项卡。
4. 在访问组的表条目中，单击“操作”菜单，然后选择**除去用户**。除去用户时，将除去通过访问组分配给该用户的任何角色。

#### 除去 {{site.data.keyword.Bluemix_notm}} IAM 平台许可权和关联的预定义 RBAC 许可权
{: #remove_iam_rbac}

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)，并浏览至**管理 > 帐户 > 用户**。
2. 单击要除去其许可权的用户的名称。
3. 在要除去的许可权的表条目中，单击“操作”菜单。
4. 选择**除去**。
5. 除去 {{site.data.keyword.Bluemix_notm}} IAM 平台许可权时，还会自动从关联的预定义 RBAC 角色中除去用户的许可权。要使用更改来更新 RBAC 角色，请运行 `ibmcloud ks cluster-config`。但是，如果您创建的是[定制 RBAC 角色或集群角色](#rbac)，那么必须从这些 RBAC 角色绑定或集群角色绑定的 `.yaml` 文件中除去该用户。请参阅下面除去定制 RBAC 许可权的步骤。

#### 除去定制 RBAC 许可权
{: #remove_custom_rbac}

如果不再需要定制 RBAC 许可权，那么可以将其除去。
{: shortdesc}

1. 打开已创建的角色绑定或集群角色绑定的 `.yaml` 文件。
2. 在 `subjects` 部分中，除去与用户相关的部分。
3. 保存该文件。
4. 将更改应用于集群中的角色绑定或集群角色绑定资源。
    ```
        kubectl apply -f my_role_binding.yaml
        ```
    {: pre}

#### 除去 Cloud Foundry 许可权
{: #remove_cloud_foundry}

要除去用户的所有 Cloud Foundry 许可权，您可以除去用户的组织角色。如果您只想除去用户的能力（例如，绑定集群中的服务的能力），请仅除去用户的空间角色。
{: shortdesc}

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)，并浏览至**管理 > 帐户 > 用户**。
2. 单击要除去其许可权的用户的名称。
3. 单击 **Cloud Foundry 访问权**选项卡。
    * 要除去用户的空间角色，请执行以下操作：
        1. 展开该空间所在的组织的表条目。
        2. 在空间角色的表条目中，单击“操作”菜单，然后选择**编辑空间角色**。
        3. 通过单击“关闭”按钮来删除角色。
        4. 要除去所有空间角色，请在下拉列表中选择**无空间角色**。
        5. 单击**保存角色**。
    * 要除去用户的组织角色，请执行以下操作：
        1. 在组织角色的表条目中，单击“操作”菜单，然后选择**编辑组织角色**。
        3. 通过单击“关闭”按钮来删除角色。
        4. 要除去所有组织角色，请在下拉列表中选择**无组织角色**。
        5. 单击**保存角色**。

#### 除去 IBM Cloud Infrastructure (SoftLayer) 许可权
{: #remove_infra}

您可以使用 {{site.data.keyword.Bluemix_notm}} 控制台来除去用户的 IBM Cloud Infrastructure (SoftLayer) 许可权。
{: shortdesc}

1. 登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)。
2. 在菜单 ![“菜单”图标](../icons/icon_hamburger.svg "“菜单”图标") 中，单击**基础架构**。
3. 单击用户的电子邮件地址。
4. 单击**门户网站许可权**选项卡。
5. 在每个选项卡中，取消选择特定许可权。
6. 要保存更改，请单击**编辑门户网站许可权**。
7. 在**设备访问权**选项卡中，取消选择特定设备。
8. 要保存更改，请单击**更新设备访问权**。许可权会在几分钟后降级。

<br />



