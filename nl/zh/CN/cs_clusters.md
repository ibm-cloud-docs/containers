---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

subcollection: containers

---

{:new_window: target="_blank"}
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
{:gif: data-image-type='gif'}


# 设置集群和工作程序节点
{: #clusters}
创建集群并添加工作程序节点以提高 {{site.data.keyword.containerlong}} 中的集群容量。您已经开始设置集群了吗？可尝试使用[创建 Kubernetes 集群教程](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial)。
{: shortdesc}

## 准备创建集群
{: #cluster_prepare}

通过 {{site.data.keyword.containerlong_notm}}，您可以为应用程序创建安全的高可用性环境，其中带有内置或可配置的其他许多功能。您可以利用集群实现许多目标，这也意味着您在创建集群时要做许多决策。以下步骤概述了设置帐户、许可权、资源组、VLAN 生成、为专区和硬件设置的集群以及计费信息时必须考虑的内容。
{: shortdesc}

列表分为两个部分：
*  **帐户级别**：这些准备工作由帐户管理员完成，完成后，您可能无需在每次创建集群时对其进行更改。但是，每次创建集群时，您仍希望验证当前帐户级别状态是否为所需的状态。
*  **集群级别**：这些是每次创建集群时会影响集群的准备工作。

### 帐户级别
{: #prepare_account_level}

执行以下步骤来准备 {{site.data.keyword.Bluemix_notm}} 帐户以使用 {{site.data.keyword.containerlong_notm}}。
{: shortdesc}

1.  [创建计费帐户或将帐户升级到计费帐户（{{site.data.keyword.Bluemix_notm}} 现收现付或预订帐户）](https://cloud.ibm.com/registration/)。
2.  [在要创建集群的区域中设置 {{site.data.keyword.containerlong_notm}} API 密钥](/docs/containers?topic=containers-users#api_key)。为 API 密钥分配可创建集群的相应许可权：
    *  IBM Cloud Infrastructure (SoftLayer) 的**超级用户**角色。
    *  帐户级别的 {{site.data.keyword.containerlong_notm}} 的**管理员**平台管理角色。
    *  帐户级别的 {{site.data.keyword.registrylong_notm}} 的**管理员**平台管理角色。如果您的帐户是在 2018 年 10 月 4 日之前注册的，那么您需要[为 {{site.data.keyword.registryshort_notm}} 启用 {{site.data.keyword.Bluemix_notm}} IAM 策略](/docs/services/Registry?topic=registry-user#existing_users)。通过 IAM 策略，您可以控制对资源（例如，注册表名称空间）的访问。

    您是帐户所有者吗？如果是，那么您已具有必需的许可权！创建集群时，该区域和资源组的 API 密钥将使用您的凭证进行设置。
    {: tip}

3.  如果帐户使用了多个资源组，请确定[管理资源组](/docs/containers?topic=containers-users#resource_groups)的帐户策略。 
    *  在您登录到 {{site.data.keyword.Bluemix_notm}} 后，将在您设定为目标的资源组中创建集群。如果未将某个资源组设定为目标，那么会自动将缺省资源组设定为目标。
    *  如果要在非缺省资源组中创建集群，那么您至少需要该资源组的**查看者**角色。如果您不具有该资源组的任何角色，但仍然是该资源组中服务的**管理员**，那么将在缺省资源组中创建集群。
    *  无法更改集群的资源组。集群只能与同一资源组中的其他 {{site.data.keyword.Bluemix_notm}} 服务集成，或与不支持资源组的服务（例如，{{site.data.keyword.registrylong_notm}}）集成。
    *  如果计划将 [{{site.data.keyword.monitoringlong_notm}} 用于度量值](/docs/containers?topic=containers-health#view_metrics)，请计划为集群提供在您帐户中的所有资源组和区域之间唯一的名称，以避免发生度量值命名冲突。
    * 如果您具有 {{site.data.keyword.Bluemix_dedicated}} 帐户，那么只能在缺省资源组中创建集群。

4.  设置 IBM Cloud Infrastructure (SoftLayer) 联网。可以从以下选项中进行选择：
    *  **启用 VRF**：通过虚拟路由和转发 (VRF) 及其多重隔离分隔技术，可以使用公共和专用服务端点与运行 Kubernetes V1.11 或更高版本的集群中的 Kubernetes 主节点进行通信。通过使用[专用服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)，Kubernetes 主节点与工作程序节点之间的通信可保持在专用 VLAN 上进行。如果要从本地计算机对集群运行 `kubectl` 命令，那么必须连接到 Kubernetes 主节点所在的专用 VLAN。要将应用程序公开到因特网，工作程序节点必须连接到公用 VLAN，这样才能将入局网络流量转发到应用程序。要通过因特网对集群运行 `kubectl` 命令，可以使用公共服务端点。使用公共服务端点时，网络流量通过公用 VLAN 进行路由，并使用 OpenVPN 隧道进行保护。要使用专用服务端点，必须为帐户启用 VRF 和服务端点，这需要开具 IBM Cloud Infrastructure (SoftLayer) 支持案例。有关更多信息，请参阅 [{{site.data.keyword.Bluemix_notm}} 上的 VRF 概述](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)和[为帐户启用服务端点](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)。
    *  **非 VRF**：如果您不希望或无法为帐户启用 VRF，或者创建的是运行 Kubernetes V1.10 的集群，那么工作程序节点可以通过[公共服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)在公用网络上自动连接到 Kubernetes 主节点。为了保护此通信，在创建集群时，{{site.data.keyword.containerlong_notm}} 会自动设置 Kubernetes 主节点与工作程序节点之间的 OpenVPN 连接。如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud Infrastructure (SoftLayer) 帐户启用 [VLAN 生成](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)，从而使工作程序节点可以在专用网络上相互通信。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](/docs/containers?topic=containers-users#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。

### 集群级别
{: #prepare_cluster_level}

执行以下步骤来准备设置集群。
{: shortdesc}

1.  验证您是否具有 {{site.data.keyword.containerlong_notm}} 的**管理员**平台角色。
    1.  在 [{{site.data.keyword.Bluemix_notm}} 控制台 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/) 菜单栏中，选择**管理 > 访问权 (IAM)**。
    2.  单击**用户**页面，然后从表中选择您自己。
    3.  在**访问策略**选项卡中，确认您的**角色**为**管理员**。您可以是帐户中所有资源的**管理员**，也可以至少是 {{site.data.keyword.containershort_notm}} 的管理员。**注**：如果您仅具有一个资源组或区域（而不是整个帐户）中 {{site.data.keyword.containershort_notm}} 的**管理员**角色，那么您必须至少在帐户级别具有**查看者**角色才能查看帐户的 VLAN。
2.  决定是[免费还是标准集群](/docs/containers?topic=containers-cs_ov#cluster_types)。您可以创建 1 个免费集群来试用部分功能 30 天，或者创建具有所选硬件隔离的可完全定制的标准集群。创建标准集群可获取更多收益并控制集群性能。
3.  [规划集群设置](/docs/containers?topic=containers-plan_clusters#plan_clusters)。
    *  确定是创建[单专区](/docs/containers?topic=containers-plan_clusters#single_zone)还是[多专区](/docs/containers?topic=containers-plan_clusters#multizone)集群。请注意，多专区集群仅在精选位置可用。
    *  如果要创建不能以公共方式访问的集群，请查看其他[专用集群步骤](/docs/containers?topic=containers-plan_clusters#private_clusters)。
    *  选择要用于集群的工作程序节点的[硬件和隔离](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)类型，包括决定是使用虚拟机还是裸机机器。
4.  对于标准集群，可以在 {{site.data.keyword.Bluemix_notm}} 控制台中[估算成本](/docs/billing-usage?topic=billing-usage-cost#cost)。有关估算工具中可能不包含的费用的更多信息，请参阅[定价和计费](/docs/containers?topic=containers-faqs#charges)。
5.  如果是在防火墙后的环境中创建集群，请针对计划使用的 {{site.data.keyword.Bluemix_notm}} 服务，[允许流至公共和专用 IP 的出站网络流量](/docs/containers?topic=containers-firewall#firewall_outbound)。
<br>
<br>

**接下来要做什么？**
* [使用 {{site.data.keyword.Bluemix_notm}} 控制台创建集群](#clusters_ui)
* [使用 {{site.data.keyword.Bluemix_notm}} CLI 创建集群](#clusters_cli)

## 使用 {{site.data.keyword.Bluemix_notm}} 控制台创建集群
{: #clusters_ui}

Kubernetes 集群的用途是定义一组资源、节点、网络和存储设备，以便使应用程序保持高可用性。要部署应用程序，必须先创建集群，并在该集群中设置工作程序节点的定义。
{:shortdesc}

要创建将[服务端点](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)用于[主节点到工作程序的通信](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)的集群吗？您必须[使用 CLI](#clusters_cli) 来创建集群。
{: note}

### 创建免费集群
{: #clusters_ui_free}

可以使用 1 个免费集群来熟悉 {{site.data.keyword.containerlong_notm}} 的工作方式。通过免费集群，您可以了解术语，完成教程，弄清状况，然后再跃升到生产级别的标准集群。别担心，就算您拥有的是计费帐户，也仍会获得免费集群。
{: shortdesc}

免费集群的生命周期为 30 天。在此时间之后，免费集群将到期，并且会删除该集群及其数据。{{site.data.keyword.Bluemix_notm}} 不会备份删除的数据，因此无法复原这些数据。请确保备份任何重要数据。
{: note}

1. [准备创建集群](#cluster_prepare)，以确保您具有正确的 {{site.data.keyword.Bluemix_notm}} 帐户设置和用户许可权，并决定要使用的集群设置和资源组。
2. 在[目录 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/catalog?category=containers) 中，选择 **{{site.data.keyword.containershort_notm}}** 以创建集群。
3. 选择要在其中部署集群的位置。**注**：无法在华盛顿（美国东部）或东京（亚太北部）位置中创建免费集群。
4. 选择**免费**集群套餐。
5. 为集群提供名称。名称必须以字母开头，可以包含字母、数字和连字符 (-)，并且不能超过 35 个字符。集群名称和部署集群的区域构成了 Ingress 子域的标准域名。为了确保 Ingress 子域在区域内是唯一的，可能会截断 Ingress 域名中的集群名称并附加随机值。

6. 单击**创建集群**。缺省情况下，将创建包含一个工作程序节点的工作程序池。您可以在**工作程序节点**选项卡中查看工作程序节点部署的进度。完成部署后，您可以在**概述**选项卡中看到集群已就绪。

    更改创建期间分配的唯一标识或域名，会导致 Kubernetes 主节点无法管理集群。
    {: tip}

</br>

### 创建标准集群
{: #clusters_ui_standard}

1. [准备创建集群](#cluster_prepare)，以确保您具有正确的 {{site.data.keyword.Bluemix_notm}} 帐户设置和用户许可权，并决定要使用的集群设置和资源组。
2. 在[目录 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/catalog?category=containers) 中，选择 **{{site.data.keyword.containershort_notm}}** 以创建集群。
3. 选择要在其中创建集群的资源组。
  **注**：
    * 只能在一个资源组中创建集群，在创建集群后，即无法更改其资源组。
    * 免费集群会自动在缺省资源组中创建。
    * 要在非缺省资源组中创建集群，您必须至少具有该资源组的[**查看者**角色](/docs/containers?topic=containers-users#platform)。
4. 选择要在其中部署集群的 [{{site.data.keyword.Bluemix_notm}} 位置](/docs/containers?topic=containers-regions-and-zones#regions-and-zones)。要获得最佳性能，请选择实际离您最近的位置。请记住，如果选择的是您所在国家或地区以外的专区，那么在存储数据之前可能需要法律授权。
5. 选择**标准**集群套餐。通过标准集群，您有权访问多种功能，如高可用性环境的多个工作程序节点。
6. 输入专区详细信息。
    1. 选择**单专区**或**多专区**可用性。在多专区集群中，主节点部署在支持多专区的专区中，并且集群的资源会在多个专区中进行分布。根据区域的不同，您的选择可能会受到限制。
    2. 选择要在其中托管集群的特定专区。必须选择至少一个专区，但您可以选择任意多数量的专区。如果选择多个专区，那么工作程序节点会跨您选择的专区分布，从而为您提供更高的可用性。如果仅选择 1 个专区，那么在创建该专区后，可以[向集群添加专区](#add_zone)。
    3. 从 IBM Cloud Infrastructure (SoftLayer) 帐户中选择公用 VLAN（可选）和专用 VLAN（必需）。工作程序节点使用专用 VLAN 相互通信。要与 Kubernetes 主节点通信，必须为工作程序节点配置公共连接。如果在此专区中没有公用或专用 VLAN，请使其留空。系统将自动创建公用和专用 VLAN。如果您有现有 VLAN，并且未指定公用 VLAN，请考虑配置防火墙，例如[虚拟路由器设备](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra)。可以对多个集群使用相同的 VLAN。
如果工作程序节点设置为仅使用专用 VLAN，那么必须通过[启用专用服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置网关设备](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)，允许工作程序节点和集群主节点进行通信。
        {: note}

7. 配置缺省工作程序池。工作程序池是共享相同配置的成组的工作程序节点。日后，始终可以向集群添加更多工作程序池。

    1. 选择硬件隔离的类型。“虚拟”按小时计费，“裸机”按月计费。

        - **虚拟 - 专用**：工作程序节点在帐户专用的基础架构上托管。物理资源完全隔离。

        - **虚拟 - 共享**：基础架构资源（例如，系统管理程序和物理硬件）在您与其他 IBM 客户之间共享，但每个工作程序节点只能由您访问。虽然此选项更便宜，并且足以满足大多数情况，但您可能希望使用公司策略来验证性能和基础架构需求。

        - **裸机**：裸机服务器按月计费，订购后由 IBM Cloud Infrastructure (SoftLayer) 手动供应，可能需要一个工作日以上的时间才能完成。裸机最适用于需要更多资源和主机控制的高性能应用程序。还可以选择启用[可信计算](/docs/containers?topic=containers-security#trusted_compute)来验证工作程序节点是否被篡改。可信计算可用于精选的裸机机器类型。例如，`mgXc` GPU 类型模板不支持可信计算。如果在创建集群期间未启用信任，但希望日后启用，那么可以使用 `ibmcloud ks feature-enable` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)。启用信任后，日后无法将其禁用。

        确保要供应裸机机器。因为裸机机器是按月计费的，所以如果在错误下单后立即将其取消，也仍然会按整月向您收费。
        {:tip}

    2. 选择机器类型。机器类型用于定义在每个工作程序节点中设置并可供容器使用的虚拟 CPU 量、内存量和磁盘空间量。可用的裸机和虚拟机类型随部署集群的专区而变化。创建集群后，可以通过将工作程序或池添加到集群来添加不同的机器类型。

    3. 指定集群中需要的工作程序节点数。输入的工作程序数将在所选数量的专区之间进行复制。这意味着如果您有 2 个专区并选择了 3 个工作程序节点，那么会供应 6 个节点，并且每个专区中存在 3 个节点。

8. 为集群提供唯一名称。**注**：更改创建期间分配的唯一标识或域名，会导致 Kubernetes 主节点无法管理集群。
9. 为集群主节点选择 Kubernetes API 服务器版本。
10. 单击**创建集群**。这将创建具有指定工作程序数的工作程序池。您可以在**工作程序节点**选项卡中查看工作程序节点部署的进度。完成部署后，您可以在**概述**选项卡中看到集群已就绪。

**接下来要做什么？**

集群启动并开始运行后，可查看以下任务：

-   如果在支持多专区的专区中创建了集群，请通过[向集群添加专区](#add_zone)来分布工作程序节点。
-   [安装 CLI 以开始使用集群。](/docs/containers?topic=containers-cs_cli_install#cs_cli_install)
-   [在集群中部署应用程序。](/docs/containers?topic=containers-app#app_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中设置您自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry?topic=registry-index)
-   如果您有防火墙，那么可能需要[打开必要的端口](/docs/containers?topic=containers-firewall#firewall)才能使用 `ibmcloud`、`kubectl` 或 `calicotl` 命令，以允许来自集群的出站流量，或允许联网服务的入站流量。
-   [设置集群自动缩放器](/docs/containers?topic=containers-ca#ca)，以根据工作负载资源请求，自动在工作程序池中添加或除去工作程序节点。
-   使用 Kubernetes V1.10 或更高版本的集群：使用 [pod 安全策略](/docs/containers?topic=containers-psp)控制谁可以在集群中创建 pod。

<br />


## 使用 {{site.data.keyword.Bluemix_notm}} CLI 创建集群
{: #clusters_cli}

Kubernetes 集群的用途是定义一组资源、节点、网络和存储设备，以便使应用程序保持高可用性。要部署应用程序，必须先创建集群，并在该集群中设置工作程序节点的定义。
{:shortdesc}

是否之前已创建集群，现在只需要了解快速示例命令？请尝试以下示例。
*  **免费集群**：
   ```
        ibmcloud ks cluster-create --name my_cluster
        ```
   {: pre}
*  **标准集群（共享虚拟机）**：
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b2c.4x16 --hardware shared --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **标准集群（裸机）**：
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **标准集群（在启用 VRF 的帐户中使用[公共和专用服务端点](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)的虚拟机）**：
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b2c.4x16 --hardware shared --workers 3 --public-service-endpoint --private-service-endpoint --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}

开始之前，请安装 {{site.data.keyword.Bluemix_notm}} CLI 和 [{{site.data.keyword.containerlong_notm}} 插件](/docs/containers?topic=containers-cs_cli_install#cs_cli_install)。

要创建集群，请执行以下操作：

1. [准备创建集群](#cluster_prepare)，以确保您具有正确的 {{site.data.keyword.Bluemix_notm}} 帐户设置和用户许可权，并决定要使用的集群设置和资源组。

2.  登录到 {{site.data.keyword.Bluemix_notm}} CLI。

    1.  登录并根据提示输入 {{site.data.keyword.Bluemix_notm}} 凭证。

        ```
        ibmcloud login
        ```
        {: pre}

        如果您有联合标识，请使用 `ibmcloud login --sso` 登录到 {{site.data.keyword.Bluemix_notm}} CLI。输入您的用户名，并使用 CLI 输出中提供的 URL 来检索一次性密码。如果不使用 `--sso` 时登录失败，而使用 `--sso` 选项时登录成功，说明您拥有的是联合标识。
        {: tip}

    2. 如果有多个 {{site.data.keyword.Bluemix_notm}} 帐户，请选择要在其中创建 Kubernetes 集群的帐户。

    3.  要在非缺省资源组中创建集群，请将该资源组设定为目标。
      **注**：
        * 只能在一个资源组中创建集群，在创建集群后，即无法更改其资源组。
        * 您必须至少具有该资源组的[**查看者**角色](/docs/containers?topic=containers-users#platform)。
        * 免费集群会自动在缺省资源组中创建。
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4.  如果要在先前选择的 {{site.data.keyword.Bluemix_notm}} 区域以外的区域中创建或访问 Kubernetes 集群，请运行 `ibmcloud ks region-set`。

4.  创建集群。可在任何区域和可用专区中创建标准集群。无法在美国东部或亚太北部区域以及对应的专区中创建免费集群，并且无法选择专区。

    1.  **标准集群**：查看可用的专区。显示的专区取决于您登录到的 {{site.data.keyword.containerlong_notm}} 区域。要使集群跨多个专区，必须在[支持多专区的专区](/docs/containers?topic=containers-regions-and-zones#zones)中创建集群。

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **标准集群**：选择专区并查看该专区中可用的机器类型。机器类型指定可供每个工作程序节点使用的虚拟或物理计算主机。

        -  查看**服务器类型**字段，以选择虚拟或物理（裸机）机器。
        -  **虚拟**：虚拟机按小时计费，在共享或专用硬件上供应。
        -  **物理**：裸机服务器按月计费，订购后由 IBM Cloud Infrastructure (SoftLayer) 手动供应，可能需要一个工作日以上的时间才能完成。裸机最适用于需要更多资源和主机控制的高性能应用程序。
        - **具有可信计算的物理机器**：您还可以选择启用[可信计算](/docs/containers?topic=containers-security#trusted_compute)来验证裸机工作程序节点是否被篡改。可信计算可用于精选的裸机机器类型。例如，`mgXc` GPU 类型模板不支持可信计算。如果在创建集群期间未启用信任，但希望日后启用，那么可以使用 `ibmcloud ks feature-enable` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)。启用信任后，日后无法将其禁用。
        -  **机器类型**：要确定需要部署的机器类型，请查看[可用工作程序节点硬件](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)的核心、内存和存储器组合。创建集群后，可以通过[添加工作程序池](#add_pool)来添加不同的物理或虚拟机类型。

           确保要供应裸机机器。因为裸机机器是按月计费的，所以如果在错误下单后立即将其取消，也仍然会按整月向您收费。
        {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **标准集群**：检查以确定 IBM Cloud Infrastructure (SoftLayer) 中是否已存在此帐户的公用和专用 VLAN。

        ```
        ibmcloud ks vlans --zone <zone>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10 
        ```
        {: screen}

        如果公用和专用 VLAN 已经存在，请记下匹配的路由器。专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。在示例输出中，任一专用 VLAN 都可以与任一公用 VLAN 一起使用，因为路由器全都包含 `02a.dal10`。

        必须将工作程序节点连接到专用 VLAN，还可以选择将工作程序节点连接到公用 VLAN。**注**：如果工作程序节点设置为仅使用专用 VLAN，那么必须通过[启用专用服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置网关设备](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)，允许工作程序节点和集群主节点进行通信。

    4.  **免费和标准集群**：运行 `cluster-create` 命令。您可以选择免费集群（包含设置有 2 个 vCPU 和 4 GB 内存的一个工作程序节点），在 30 天后会自动删除该集群。创建标准集群时，缺省情况下会对工作程序节点磁盘进行 AES 256 位加密，其硬件由多个 IBM 客户共享，并且会按使用小时数对其进行计费。</br>标准集群的示例。指定集群的选项：

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--private-service-endpoint][--public-service-endpoint] [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        免费集群的示例。指定集群名称：

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>cluster-create 组成部分</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解此命令的组成部分</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>此命令在 {{site.data.keyword.Bluemix_notm}} 组织中创建集群。</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**标准集群**：将 <em>&lt;zone&gt;</em> 替换为要在其中创建集群的 {{site.data.keyword.Bluemix_notm}} 专区的标识。可用专区取决于您登录到的 {{site.data.keyword.containerlong_notm}} 区域。<p class="note">集群工作程序节点会部署到此专区中。要使集群跨多个专区，必须在[支持多专区的专区](/docs/containers?topic=containers-regions-and-zones#zones)中创建集群。创建集群后，可以[向集群添加专区](#add_zone)。</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**标准集群**：选择机器类型。可以将工作程序节点作为虚拟机部署在共享或专用硬件上，也可以作为物理机器部署在裸机上。可用的物理和虚拟机类型随集群的部署专区而变化。有关更多信息，请参阅 `ibmcloud ks machine-type` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)的文档。对于免费集群，无需定义机器类型。</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**标准集群**：工作程序节点的硬件隔离级别。如果希望可用的物理资源仅供您专用，请使用 dedicated，或者要允许物理资源与其他 IBM 客户共享，请使用 shared。缺省值为 shared。此值对于 VM 标准集群是可选的，且不可用于免费集群。对于裸机机器类型，请指定 `dedicated`。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**免费集群**：无需定义公用 VLAN。免费集群会自动连接到 IBM 拥有的公用 VLAN。</li>
          <li>**标准集群**：如果已经在 IBM Cloud Infrastructure (SoftLayer) 帐户中为该专区设置了公用 VLAN，请输入该公用 VLAN 的标识。如果要将工作程序节点仅连接到专用 VLAN，请不要指定此选项。<p>专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。</p>
          <p class="note">如果工作程序节点设置为仅使用专用 VLAN，那么必须通过[启用专用服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置网关设备](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)，允许工作程序节点和集群主节点进行通信。</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**免费集群**：无需定义专用 VLAN。免费集群会自动连接到 IBM 拥有的专用 VLAN。</li><li>**标准集群**：如果已经在 IBM Cloud Infrastructure (SoftLayer) 帐户中为该专区设置了专用 VLAN，请输入该专用 VLAN 的标识。如果帐户中没有专用 VLAN，请不要指定此选项。{{site.data.keyword.containerlong_notm}} 会自动为您创建专用 VLAN。<p>专用 VLAN 路由器始终以 <code>bcr</code>（后端路由器）开头，而公用 VLAN 路由器始终以 <code>fcr</code>（前端路由器）开头。创建集群并指定公用和专用 VLAN 时，在这些前缀之后的数字和字母组合必须匹配。</p></li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**免费和标准集群**：将 <em>&lt;name&gt;</em> 替换为集群的名称。名称必须以字母开头，可以包含字母、数字和连字符 (-)，并且不能超过 35 个字符。集群名称和部署集群的区域构成了 Ingress 子域的标准域名。为了确保 Ingress 子域在区域内是唯一的，可能会截断 Ingress 域名中的集群名称并附加随机值。
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**标准集群**：要包含在集群中的工作程序节点数。如果未指定 <code>--workers</code> 选项，那么会创建 1 个工作程序节点。</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**标准集群**：集群主节点的 Kubernetes 版本。此值是可选的。未指定版本时，会使用受支持 Kubernetes 版本的缺省值来创建集群。要查看可用版本，请运行 <code>ibmcloud ks kube-versions</code>。
</td>
        </tr>
        <tr>
        <td><code>--private-service-endpoint</code></td>
        <td>**在[启用 VRF 的帐户](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started)中的标准集群**：启用[专用服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)，以便 Kubernetes 主节点和工作程序节点可通过专用 VLAN 进行通信。此外，可以选择使用 `--public-service-endpoint` 标志来启用公共服务端点，以通过因特网访问集群。如果仅启用专用服务端点，那么必须连接到专用 VLAN 才能与 Kubernetes 主节点进行通信。启用专用服务端点后，日后无法将其禁用。<br><br>创建集群后，可以通过运行 `ibmcloud ks cluster-get <cluster_name_or_ID>` 来获取端点。</td>
        </tr>
        <tr>
        <td><code>--public-service-endpoint</code></td>
        <td>**标准集群**：启用[公共服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)，以便可以通过公用网络访问 Kubernetes 主节点，例如通过终端运行 `kubectl` 命令。如果还包含了 `--private-service-endpoint` 标志，那么在启用 VRF 的帐户中，[主节点与工作程序节点的通信](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both)在专用网络上执行。如果日后希望使用仅专用集群，那么可以禁用公共服务端点。<br><br>创建集群后，可以通过运行 `ibmcloud ks cluster-get <cluster_name_or_ID>` 来获取端点。</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**免费和标准集群**：工作程序节点缺省情况下具有 AES 256 位[磁盘加密功能](/docs/containers?topic=containers-security#encrypted_disk)。如果要禁用加密，请包括此选项。</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**标准裸机集群**：启用[可信计算](/docs/containers?topic=containers-security#trusted_compute)以验证裸机工作程序节点是否被篡改。可信计算可用于精选的裸机机器类型。例如，`mgXc` GPU 类型模板不支持可信计算。如果在创建集群期间未启用信任，但希望日后启用，那么可以使用 `ibmcloud ks feature-enable` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)。启用信任后，日后无法将其禁用。</td>
        </tr>
        </tbody></table>

5.  验证是否请求了创建集群。对于虚拟机，可能需要几分钟时间，才能订购好工作程序节点机器并且在帐户中设置并供应集群。裸机物理机器通过与 IBM Cloud Infrastructure (SoftLayer) 进行手动交互来供应，可能需要一个工作日以上的时间才能完成。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    当完成集群供应时，集群的状态会更改为**已部署**。

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.12.6      Default
    ```
    {: screen}

6.  检查工作程序节点的状态。

    ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
    {: pre}

    当工作程序节点已准备就绪时，状态会更改为 **normal**，而阶段状态为 **Ready**。节点阶段状态为 **Ready** 时，可以访问集群。

    系统会为每个工作程序节点分配唯一的工作程序节点标识和域名，在创建集群后，不得手动更改该标识和域名。更改标识或域名会阻止 Kubernetes 主节点管理集群。
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.12.6      Default
    ```
    {: screen}

7.  将所创建的集群设置为此会话的上下文。每次使用集群时都完成这些配置步骤。
    1.  获取命令以设置环境变量并下载 Kubernetes 配置文件。

        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        配置文件下载完成后，会显示一个命令，您可以使用该命令将本地 Kubernetes 配置文件的路径设置为环境变量。

        OS X 的示例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  复制并粘贴终端中显示的命令，以设置 `KUBECONFIG` 环境变量。
    3.  验证是否已正确设置 `KUBECONFIG` 环境变量。

        OS X 的示例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        输出：

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        

        ```
        {: screen}

8.  使用缺省端口 `8001` 启动 Kubernetes 仪表板。
    1.  使用缺省端口号设置代理。

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  在 Web 浏览器中打开以下 URL 以查看 Kubernetes 仪表板。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**接下来要做什么？**

-   如果在支持多专区的专区中创建了集群，请通过[向集群添加专区](#add_zone)来分布工作程序节点。
-   [在集群中部署应用程序。](/docs/containers?topic=containers-app#app_cli)
-   [使用 `kubectl` 命令行管理集群。![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中设置您自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry?topic=registry-index)
- 如果您有防火墙，那么可能需要[打开必要的端口](/docs/containers?topic=containers-firewall#firewall)才能使用 `ibmcloud`、`kubectl` 或 `calicotl` 命令，以允许来自集群的出站流量，或允许联网服务的入站流量。
-   [设置集群自动缩放器](/docs/containers?topic=containers-ca#ca)，以根据工作负载资源请求，自动在工作程序池中添加或除去工作程序节点。
-  使用 Kubernetes V1.10 或更高版本的集群：使用 [pod 安全策略](/docs/containers?topic=containers-psp)控制谁可以在集群中创建 pod。

<br />



## 向集群添加工作程序节点和专区
{: #add_workers}

要提高应用程序的可用性，可以将工作程序节点添加到集群中的一个或多个现有专区中。为了帮助保护应用程序免受专区故障的影响，您可以向集群添加专区。
{:shortdesc}

创建集群时，会在工作程序池中供应工作程序节点。创建集群后，可以通过调整其大小或添加更多工作程序池，将更多工作程序节点添加到池。缺省情况下，工作程序池存在于一个专区中。仅在一个专区中有工作程序池的集群称为单专区集群。向集群添加更多专区时，该工作程序池会跨多个专区。具有跨多个专区分布的工作程序池的集群称为多专区集群。

如果您有多专区集群，请使其工作程序节点资源保持均衡。确保所有工作程序池跨相同专区进行分布，并通过调整池大小（而不采用添加单个节点的方式）来添加或除去工作程序。
{: tip}

开始之前，请确保您具有 [{{site.data.keyword.Bluemix_notm}} IAM **操作员**或**管理员**平台角色](/docs/containers?topic=containers-users#platform)。然后，选择下列其中一个部分：
  * [通过调整集群中现有工作程序池的大小来添加工作程序节点](#resize_pool)
  * [通过向集群添加工作程序池来添加工作程序节点](#add_pool)
  * [向集群添加专区并在跨多个专区的工作程序池中复制工作程序节点](#add_zone)
  * [不推荐：向集群添加独立工作程序节点](#standalone)

设置工作程序池后，可以[设置集群自动缩放器](/docs/containers?topic=containers-ca#ca)，以根据工作负载资源请求，自动在工作程序池中添加或除去工作程序节点。
{:tip}

### 通过调整集群中现有工作程序池的大小来添加工作程序节点
{: #resize_pool}

您可以通过调整现有工作程序池的大小来添加或减少集群中的工作程序节点数，而不管工作程序池是位于一个专区中还是或跨多个专区分布。
{: shortdesc}

例如，假设一个集群有一个工作程序池，该工作程序池在每个专区有 3 个工作程序节点。
* 如果该集群是单专区集群，并且存在于 `dal10` 中，那么工作程序池在 `dal10` 中有 3 个工作程序节点。集群共有 3 个工作程序节点。
* 如果该集群是多专区集群，并且存在于 `dal10` 和 `dal12` 中，那么工作程序池在 `dal10` 中有 3 个工作程序节点，在 `dal12` 中有 3 个工作程序节点。集群共有 6 个工作程序节点。

请记住，裸机工作程序池是按月计费的。如果向上或向下调整大小，都会影响您当月的成本。
{: tip}

要调整工作程序池大小，请更改工作程序池在每个专区中部署的工作程序节点数：

1. 获取要调整其大小的工作程序池的名称。
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. 通过指定要在每个专区中部署的工作程序节点数来调整工作程序池的大小。最小值为 1。
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. 验证工作程序池的大小是否已调整。
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    两个专区（`dal10` 和 `dal12`）中的工作程序池的示例输出，此池的大小已调整为每个专区 2 个工作程序节点：
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### 通过创建新的工作程序池来添加工作程序节点
{: #add_pool}

可以通过创建新的工作程序池，向集群添加工作程序节点。
{:shortdesc}

1. 检索集群的**工作程序专区**，并选择要在其中部署工作程序池中工作程序节点的专区。如果您具有单专区集群，那么必须使用在 **Worker Zones** 字段中看到的专区。对于多专区集群，可以选择集群的任何现有**工作程序专区**，也可以为集群所在的区域添加其中一个[多专区大城市](/docs/containers?topic=containers-regions-and-zones#zones)。可以通过运行 `ibmcloud ks zones` 来列出可用专区。
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   输出示例：
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. 对于每个专区，列出可用的专用和公用 VLAN。请记下要使用的专用和公用 VLAN。如果没有专用或公用 VLAN，那么在向工作程序池添加专区时，会自动创建 VLAN。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3.  对于每个专区，请查看[可用于工作程序节点的机器类型](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)。

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. 创建工作程序池。如果供应的是裸机工作程序池，请指定 `--hardware dedicated`。
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. 验证工作程序池是否已创建。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. 缺省情况下，添加工作程序池将创建不包含专区的池。要在专区中部署工作程序节点，必须将先前检索到的专区添加到工作程序池。如果要跨多个专区分布工作程序节点，请对每个专区重复此命令。  
   ```
ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
   {: pre}

7. 验证工作程序节点是否在添加的专区中供应。当状态从 **provision_pending** 更改为 **normal** 时，说明工作程序节点已就绪。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   输出示例：
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### 通过向工作程序池添加专区来添加工作程序节点
{: #add_zone}

可以通过向现有工作程序池添加专区，使集群跨一个区域内的多个专区。
{:shortdesc}

将专区添加到工作程序池时，将在新专区中供应工作程序池中定义的工作程序节点数，并考虑用于未来的工作负载安排。{{site.data.keyword.containerlong_notm}} 会自动将区域的 `failure-domain.beta.kubernetes.io/region` 标签和专区的 `failure-domain.beta.kubernetes.io/zone` 标签添加到每个工作程序节点。Kubernetes 调度程序使用这些标签在同一区域内的各个专区之间分布 pod。

如果集群中有多个工作程序池，请将该专区添加到所有这些工作程序池，以便工作程序节点在集群中均匀分布。

开始之前：
*  要将专区添加到工作程序池，工作程序池必须位于[支持多专区的专区](/docs/containers?topic=containers-regions-and-zones#zones)中。如果工作程序池不位于支持多专区的专区中，请考虑[创建新的工作程序池](#add_pool)。
*  如果有多个 VLAN 用于一个集群、在同一 VLAN 上有多个子网或者有一个多专区集群，那么必须针对 IBM Cloud Infrastructure (SoftLayer) 帐户启用[虚拟路由器功能 (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview)，从而使工作程序节点可以在专用网络上相互通信。要启用 VRF，请[联系 IBM Cloud Infrastructure (SoftLayer) 客户代表](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion)。如果无法启用 VRF 或不想启用 VRF，请启用 [VLAN 生成](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)。要执行此操作，您需要**网络 > 管理网络 VLAN 生成**[基础架构许可权](/docs/containers?topic=containers-users#infra_access)，或者可以请求帐户所有者启用 VLAN 生成。要检查是否已启用 VLAN 生成，请使用 `ibmcloud ks vlan-spanning-get` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。

要将具有工作程序节点的专区添加到工作程序池，请执行以下操作：

1. 列出可用专区，然后选取要添加到工作程序池的专区。选择的专区必须是支持多专区的专区。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 列出该专区中可用的 VLAN。如果没有专用或公用 VLAN，那么在向工作程序池添加专区时，会自动创建 VLAN。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. 列出集群中的工作程序池并记下其名称。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. 将专区添加到工作程序池。如果您有多个工作程序池，请将专区添加到所有工作程序池，以便在所有专区中均衡集群。将 `<pool1_id_or_name,pool2_id_or_name,...>` 替换为所有工作程序池的名称（采用逗号分隔列表形式）。

    必须存在专用和公用 VLAN，才能将专区添加到多个工作程序池。如果在该专区中没有专用和公用 VLAN，请首先将该专区添加到一个工作程序池，以便创建专用和公用 VLAN。然后，可以通过指定创建的专用和公用 VLAN，将该专区添加到其他工作程序池。
    {: note}

   如果要对不同工作程序池使用不同的 VLAN，请对每个 VLAN 及其相应的工作程序池重复此命令。任何新的工作程序节点都会添加到指定的 VLAN，但不会更改任何现有工作程序节点的 VLAN。
      {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. 验证是否已将专区添加到集群。在输出的 **Worker zones** 字段中查找添加的专区。请注意，在添加的专区中供应了新的工作程序节点，因此 **Workers** 字段中的工作程序总数已增加。
    
  ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
  {: pre}

  输出示例：
  ```
  Name:                           mycluster
  ID:                             df253b6025d64944ab99ed63bb4567b6
  State:                          normal
  Created:                        2018-09-28T15:43:15+0000
  Location:                       dal10
  Master URL:                     https://c3.<region>.containers.cloud.ibm.com:30426
  Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
  Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
  Master Location:                Dallas
  Master Status:                  Ready (21 hours ago)
  Ingress Subdomain:              mycluster.us-south.containers.appdomain.cloud
  Ingress Secret:                 mycluster
  Workers:                        6
  Worker Zones:                   dal10, dal12
  Version:                        1.11.3_1524
  Owner:                          owner@email.com
  Monitoring Dashboard:           ...
  Resource Group ID:              a8a12accd63b437bbd6d58fb6a462ca7
  Resource Group Name:            Default
  ```
  {: screen}  

### 不推荐：添加独立工作程序节点
{: #standalone}

如果您的集群是在引入工作程序池之前创建的，那么可以使用不推荐的命令来添加独立工作程序节点。
{: deprecated}

如果您的集群是在引入工作程序池后创建的，那么无法添加独立工作程序节点。您可以改为通过[创建工作程序池](#add_pool)、[调整现有工作程序池大小](#resize_pool)或[向工作程序池添加专区](#add_zone)，将工作程序节点添加到集群。
{: note}

1. 列出可用专区，然后选取要添加工作程序节点的专区。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 列出该专区中的可用 VLAN，并记下其标识。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. 列出该专区中的可用机器类型。
   ```
   ibmcloud ks machine-types --zone <zone>
   ```
   {: pre}

4. 向集群添加独立工作程序节点。对于裸机机器类型，请指定 `dedicated`。
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. 验证工作程序节点是否已创建。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## 查看集群状态
{: #states}

查看 Kubernetes 集群的状态，以获取有关集群可用性和容量的信息以及可能已发生的潜在问题。
{:shortdesc}

要查看有关特定集群的信息（例如，其专区、服务端点 URL、Ingress 子域、版本、所有者和监视仪表板），请使用 `ibmcloud ks cluster-get <cluster_name_or_ID>` [命令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get)。包含 `--showResources` 标志可查看更多集群资源，例如存储 pod 的附加组件或公共和专用 IP 的子网 VLAN。

您可以通过运行 `ibmcloud ks clusters` 命令并找到 **State** 字段，查看当前集群状态。要对集群和工作程序节点进行故障诊断，请参阅[集群故障诊断](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters)。

<table summary="每个表行都应从左到右阅读，其中第一列是集群状态，第二列是描述。">
  <caption>集群状态</caption>
   <thead>
   <th>集群状态</th>
   <th>描述</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>在部署 Kubernetes 主节点之前，用户请求删除集群。在集群删除完成后，将从仪表板中除去集群。如果集群长时间卡在此状态，请打开 [{{site.data.keyword.Bluemix_notm}} 支持案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)。</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>无法访问 Kubernetes 主节点，或者集群中的所有工作程序节点都已停止运行。</td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>Kubernetes 主节点或至少一个工作程序节点无法删除。</td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>集群已删除，但尚未从仪表板中除去。如果集群长时间卡在此状态，请打开 [{{site.data.keyword.Bluemix_notm}} 支持案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)。</td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>正在删除集群，并且正在拆除集群基础架构。无法访问集群。</td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>无法完成 Kubernetes 主节点的部署。您无法解决此状态。请通过打开 [{{site.data.keyword.Bluemix_notm}} 支持案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)来联系 IBM Cloud 支持人员。</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Kubernetes 主节点尚未完全部署。无法访问集群。请等待集群完全部署后，再复查集群的运行状况。</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>集群中的所有工作程序节点都已启动并正在运行。您可以访问集群，并将应用程序部署到集群。此状态视为正常运行，不需要您执行操作。<p class="note">虽然工作程序节点可能是正常的，但其他基础架构资源（例如，[联网](/docs/containers?topic=containers-cs_troubleshoot_network)和[存储](/docs/containers?topic=containers-cs_troubleshoot_storage)）可能仍然需要注意。</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Kubernetes 主节点已部署。正在供应工作程序节点，这些节点在集群中尚不可用。您可以访问集群，但无法将应用程序部署到集群。</td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>发送了用于创建集群并为 Kubernetes 主节点和工作程序节点订购基础架构的请求。集群部署启动后，集群状态将更改为 <code>Deploying</code>。如果集群长时间卡在 <code>Requested</code> 状态，请打开 [{{site.data.keyword.Bluemix_notm}} 支持案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)。</td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>在 Kubernetes 主节点中运行的 Kubernetes API 服务器正在更新到新的 Kubernetes API 版本。在更新期间，您无法访问或更改集群。用户已部署的工作程序节点、应用程序和资源不会被修改，并且将继续运行。等待更新完成后，再复查集群的运行状况。</td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>集群中至少有一个工作程序节点不可用，但其他工作程序节点可用，并且可以接管工作负载。</td>
    </tr>
   </tbody>
 </table>


<br />


## 除去集群
{: #remove}

对于使用计费帐户创建的免费和标准集群，不再需要这些集群时，必须手动将其除去，以便这些集群不再耗用资源。
{:shortdesc}

<p class="important">
不会为持久性存储器中的集群或数据创建备份。删除集群时，可以选择删除持久性存储器。如果选择删除持久性存储器，那么使用 `delete` 存储类供应的持久性存储器将从 IBM Cloud Infrastructure (SoftLayer) 中永久删除。如果是使用 `retain` 存储类供应的持久性存储器，并且选择删除存储器，那么将删除集群、PV 和 PVC，但 IBM Cloud Infrastructure (SoftLayer) 帐户中的持久性存储器实例会保留。</br>
</br>除去集群时，还会除去创建集群时自动供应的任何子网，以及使用 `ibmcloud ks cluster-subnet-create` 命令创建的任何子网。但是，如果是使用 `ibmcloud ks cluster-subnet-add 命令`以手动方式将现有子网添加到集群的，那么不会从 IBM Cloud Infrastructure (SoftLayer) 帐户中除去这些子网，并且您可以在其他集群中复用这些子网。</p>

开始之前：
* 记下集群标识。您可能需要集群标识来调查和除去未随集群一起自动删除的相关 IBM Cloud Infrastructure (SoftLayer) 资源。
* 如果要删除持久性存储器中的数据，请[了解删除选项](/docs/containers?topic=containers-cleanup#cleanup)。
* 确保您具有 [{{site.data.keyword.Bluemix_notm}} IAM **管理员**平台角色](/docs/containers?topic=containers-users#platform)。

要除去集群，请执行以下操作：

-   在 {{site.data.keyword.Bluemix_notm}} 控制台中
    1.  选择集群，然后单击**更多操作...** 菜单中的**删除**。

-   通过 {{site.data.keyword.Bluemix_notm}} CLI
    1.  列出可用的集群。


        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  删除集群。

        ```
        ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
        ```
        {: pre}

    3.  遵循提示并选择是否删除集群资源，包括容器、pod、绑定的服务、持久性存储器和私钥。
      - **持久性存储器**：持久性存储器为数据提供了高可用性。如果使用[现有文件共享](/docs/containers?topic=containers-file_storage#existing_file)创建了持久卷声明，那么在删除集群时无法删除该文件共享。必须日后从 IBM Cloud Infrastructure (SoftLayer) 产品服务组合中手动删除此文件共享。

          受每月计费周期的影响，无法在一个月的最后一天删除持久卷声明。如果在一个月的最后一天删除持久卷声明，那么删除操作会保持暂挂，直到下个月开始再执行。
          {: note}

后续步骤：
- 运行 `ibmcloud ks cluster` 命令时，已除去的集群不再列在可用集群列表中之后，您可以复用该集群的名称。
- 如果保留子网，那么可以[在新集群中复用子网](/docs/containers?topic=containers-subnets#subnets_custom)，也可以日后从 IBM Cloud Infrastructure (SoftLayer) 产品服务组合中手动删除这些子网。
- 如果保留了持久性存储器，那么日后可以通过 {{site.data.keyword.Bluemix_notm}} 控制台中的 IBM Cloud Infrastructure (SoftLayer) 仪表板来[删除存储器](/docs/containers?topic=containers-cleanup#cleanup)。
