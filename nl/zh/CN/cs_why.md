---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# 为什么使用 {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containerlong}} 通过组合 Docker 容器、Kubernetes 技术、直观的用户体验以及内置安全性和隔离，提供功能强大的工具来自动对计算主机集群中的容器化应用程序进行部署、操作、扩展和监视。有关证书信息，请参阅 [Compliance on the {{site.data.keyword.Bluemix_notm}} ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/compliance)。
{:shortdesc}


## 使用服务的优点
{: #benefits}

集群会部署在提供本机 Kubernetes 和特定于 {{site.data.keyword.IBM_notm}} 的功能的计算主机上。
{:shortdesc}

|优点|描述|
|-------|-----------|
|隔离了计算、网络和存储基础架构的单租户 Kubernetes 集群|<ul><li>创建您自己的定制基础架构，以满足组织的需求。</li><li>使用 IBM Cloud Infrastructure (SoftLayer) 提供的资源来供应专用而安全的 Kubernetes 主节点、工作程序节点、虚拟网络和存储器。</li><li>由 {{site.data.keyword.IBM_notm}} 持续监视和更新的完全受管 Kubernetes 主节点，使您的集群可用。</li><li>用于将工作程序节点作为具有可信计算的裸机服务器供应的选项。</li><li>存储持久数据，在 Kubernetes pod 之间共享数据，以及在需要时使用集成和安全卷服务复原数据。</li><li>受益于对所有本机 Kubernetes API 的完全支持。</li></ul>|
|多专区集群可提高高可用性| <ul><li>通过工作程序池轻松管理同一机器类型（CPU、内存、虚拟或物理）的工作程序节点。</li><li>通过在精选多专区中均匀分布节点并对应用程序使用反亲缘关系 pod 部署，以防止专区故障。</li><li>通过使用多专区集群而不是在单独的集群中复制资源，从而降低成本。</li><li>通过在集群的每个专区中自动设置的多专区负载均衡器 (MZLB)，受益于跨应用程序的自动负载均衡。</li></ul>|
|高可用性主节点| <ul>在运行 Kubernetes V1.10 或更高版本的集群中可用。<li>缩短集群停机时间，例如在对创建集群时自动供应的高可用性主节点进行主节点更新期间。</li><li>在[多专区集群](cs_clusters_planning.html#multizone)中的各个专区中分布主节点，以防止集群发生专区故障。</li></ul> |
|使用漏洞顾问程序确保映像安全合规性|<ul><li>在安全的 Docker 专用映像注册表中设置您自己的存储库，映像会存储在该存储库中，并供组织中的所有用户共享。</li><li>受益于自动扫描专用 {{site.data.keyword.Bluemix_notm}} 注册表中的映像。</li><li>查看特定于映像中所用操作系统的建议，以修复潜在漏洞。</li></ul>|
|持续监视集群运行状况|<ul><li>使用集群仪表板可快速查看和管理集群、工作程序节点和容器部署的运行状况。</li><li>使用 {{site.data.keyword.monitoringlong}}，找到详细的使用量度量值，并快速扩展集群以满足工作负载需求。</li><li>使用 {{site.data.keyword.loganalysislong}} 复查日志记录信息，以查看详细的集群活动。</li></ul>|
|安全地向公众公开应用程序|<ul><li>在公共 IP 地址、{{site.data.keyword.IBM_notm}} 提供的路径或您自己的定制域之间进行选择，以通过因特网访问集群中的服务。</li></ul>|
|{{site.data.keyword.Bluemix_notm}} 服务集成|<ul><li>通过集成 {{site.data.keyword.Bluemix_notm}} 服务（例如，Watson API、Blockchain、数据服务或 Internet of Things）向应用程序添加额外的功能。</li></ul>|
{: caption="{{site.data.keyword.containerlong_notm}} 的优点" caption-side="top"}

准备好开始了吗？可尝试使用[创建 Kubernetes 集群教程](cs_tutorials.html#cs_cluster_tutorial)。


<br />


## 比较产品及其组合
{: #differentiation}

可以在 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 中、在 {{site.data.keyword.Bluemix_notm}} Private 中或者在混合设置中运行 {{site.data.keyword.containerlong_notm}}。
{:shortdesc}


<table>
<caption>{{site.data.keyword.containerlong_notm}} 设置之间的差异</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>{{site.data.keyword.containerlong_notm}} 设置</th>
 <th>描述</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Public
 </td>
 <td>使用位于[共享或专用硬件或者位于裸机机器上](cs_clusters_planning.html#shared_dedicated_node)的 {{site.data.keyword.Bluemix_notm}} Public 时，可以使用 {{site.data.keyword.containerlong_notm}} 在云上的集群中托管应用程序。您还可以使用多个专区中的工作程序池来创建集群，以提高应用程序的高可用性。{{site.data.keyword.containerlong_notm}} on {{site.data.keyword.Bluemix_notm}} Public 通过组合 Docker 容器、Kubernetes 技术、直观的用户体验以及内置安全性和隔离，提供功能强大的工具来自动对计算主机集群中的容器化应用程序进行部署、操作、扩展和监视。<br><br>有关更多信息，请参阅 [{{site.data.keyword.containerlong_notm}} 技术](cs_tech.html)。
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated 在云上提供的 {{site.data.keyword.containerlong_notm}} 功能与 {{site.data.keyword.Bluemix_notm}} Public 相同。但是，使用 {{site.data.keyword.Bluemix_notm}} Dedicated 帐户，可用[物理资源仅供您的集群专用](cs_clusters_planning.html#shared_dedicated_node)，而不会与其他 {{site.data.keyword.IBM_notm}} 客户的集群共享。需要对集群和使用的其他 {{site.data.keyword.Bluemix_notm}} 服务进行隔离时，您可能会选择设置 {{site.data.keyword.Bluemix_notm}} Dedicated 环境。<br><br>有关更多信息，请参阅[开始使用 {{site.data.keyword.Bluemix_notm}} Dedicated 中的集群](cs_dedicated.html#dedicated)。
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Private
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Private 是可以在您自己的机器上本地安装的应用程序平台。如果需要在防火墙后您自己的受控环境中开发和管理内部部署容器化应用程序，那么可以选择在 {{site.data.keyword.Bluemix_notm}} Private 中使用 Kubernetes。<br><br>有关更多信息，请参阅 [{{site.data.keyword.Bluemix_notm}} Private 产品文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html)。</td>
 </tr>
 <tr>
 <td>混合设置
 </td>
 <td>混合是将 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 中运行的服务与内部部署运行的其他服务（例如，{{site.data.keyword.Bluemix_notm}} Private 中的应用程序）组合使用。混合设置的示例：<ul><li>在 {{site.data.keyword.Bluemix_notm}} Public 中使用 {{site.data.keyword.containerlong_notm}} 供应集群，但将该集群连接到内部部署数据库。</li><li>在 {{site.data.keyword.Bluemix_notm}} Private 中使用 {{site.data.keyword.containerlong_notm}} 供应集群，并将应用程序部署到该集群中。但是，此应用程序可能会使用 {{site.data.keyword.Bluemix_notm}} Public 中的 {{site.data.keyword.ibmwatson}} 服务，例如 {{site.data.keyword.toneanalyzershort}}。</li></ul><br>要启用在 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 中运行的服务与内部部署运行的服务之间的通信，必须[设置 VPN 连接](cs_vpn.html)。
 有关更多信息，请参阅[将 {{site.data.keyword.containerlong_notm}} 用于 {{site.data.keyword.Bluemix_notm}} Private](cs_hybrid.html)。
 </td>
 </tr>
 </tbody>
</table>

<br />


## 比较免费和标准集群
{: #cluster_types}

您可以创建一个免费集群或创建任意数量的标准集群。试用免费集群以熟悉一些 Kubernetes 功能，或者创建标准集群以使用完整的 Kubernetes 功能来部署应用程序。
免费集群在 30 天后会被自动删除。
{:shortdesc}

如果您有免费集群并希望升级到标准集群，那么可以[创建标准集群](cs_clusters.html#clusters_ui)。然后，将使用免费集群创建的 Kubernetes 资源的任何 YAML 部署到标准集群中。

|特征|免费集群|标准集群|
|---------------|-------------|-----------------|
|[集群内联网](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[NodePort 服务对非稳定 IP 地址的公用网络应用程序访问权](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用户访问管理](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[从集群和应用程序访问 {{site.data.keyword.Bluemix_notm}} 服务](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[工作程序节点上用于非持久性存储的磁盘空间](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[能够在每个 {{site.data.keyword.containerlong_notm}} 区域中创建集群](cs_regions.html)| | <img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用于提高应用程序高可用性的多专区集群](cs_clusters_planning.html#multizone)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|实现更高可用性的复制主节点（Kubernetes 1.10 或更高版本）| | <img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用于增加容量的可扩展工作程序节点数](cs_app.html#app_scaling)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[基于 NFS 文件的持久存储器（带有卷）](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[LoadBalancer 服务对稳定 IP 地址的公共或专用网络应用程序访问权](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[Ingress 服务对稳定 IP 地址和可定制 URL 的公用网络应用程序访问权](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[可移植公共 IP 地址](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[日志记录和监视](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用于在物理（裸机服务器）服务器上供应工作程序节点的选项](cs_clusters_planning.html#shared_dedicated_node)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用于供应具有可信计算的裸机工作程序的选项](cs_clusters_planning.html#shared_dedicated_node)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[在 {{site.data.keyword.Bluemix_dedicated_notm}} 中可用](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
{: caption="免费和标准集群的特征" caption-side="top"}

<br />




## 定价和计费
{: #pricing}

请查看有关 {{site.data.keyword.containerlong_notm}} 定价和计费的一些常见问题。对于帐户级别问题，请查看[管理计费和使用情况文档](/docs/billing-usage/how_charged.html#charges)。有关帐户协议的详细信息，请参阅相应的 [{{site.data.keyword.Bluemix_notm}} 条款和声明](/docs/overview/terms-of-use/notices.html#terms)。
{: shortdesc}

### 如何查看和组织我的使用情况？
{: #usage}

**该如何检查我的计费和使用情况？**<br>
要检查使用情况和估算的总计，请参阅[查看使用情况](/docs/billing-usage/viewing_usage.html#viewingusage)。

如果您链接了 {{site.data.keyword.Bluemix_notm}} 和 IBM Cloud Infrastructure (SoftLayer) 帐户，那么将收到合并帐单。有关更多信息，请参阅[链接帐户的合并计费](/docs/customer-portal/linking_accounts.html#unifybillaccounts)。

**能按团队或部门对云资源分组以进行计费吗？**<br>
您可以[使用资源组](/docs/resources/bestpractice_rgs.html#bp_resourcegroups)将 {{site.data.keyword.Bluemix_notm}} 资源（包括集群）组织成组，从而对计费进行组织。

### 收费方式是什么？是按小时还是按月收费？
{: #monthly-charges}

收费取决于您使用的资源类型，资源可能是固定、计量、分层或保留资源。有关更多信息，请查看[收费方式](/docs/billing-usage/how_charged.html#charges)。

在 {{site.data.keyword.containerlong_notm}} 中，IBM Cloud Infrastructure (SoftLayer) 资源可以按小时或按月计费。
* 虚拟机 (VM) 工作程序节点按小时计费。
* 在 {{site.data.keyword.containerlong_notm}} 中，物理（裸机）工作程序节点是按月计费的资源。
* 对于其他基础架构资源（例如，文件存储器或块存储器），在创建资源时可能可以选择按小时或按月计费。

按月计费的资源根据上个月的使用量从当月的第一天开始计费。如果您是在月中订购的按月计费资源，那么会根据该月按比例分配的金额向您收费。但是，如果您在月中取消按月计费资源，那么仍会向您收取该资源的整月费用。

### 我能估算成本吗？
{: #estimate}

可以，请参阅[估算成本](/docs/billing-usage/estimating_costs.html#cost)和[成本估算器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/pricing/) 工具。请继续阅读有关成本估算器中未包含的成本的信息，例如出站联网。

### 使用 {{site.data.keyword.containerlong_notm}} 时，将向我收取多少费用？
{: #cluster-charges}

通过 {{site.data.keyword.containerlong_notm}} 集群，您可以将 IBM Cloud Infrastructure (SoftLayer) 计算、联网和存储资源与 Watson AI 或 Compose 数据库即服务等平台服务配合使用。每个资源都可能需要单独收费。
* [工作程序节点](#nodes)
* [出站联网](#bandwidth)
* [子网 IP 地址](#subnets)
* [存储器](#storage)
* [{{site.data.keyword.Bluemix_notm}} 服务](#services)

<dl>
<dt id="nodes">工作程序节点</dt>
  <dd><p>集群可以有两种主要类型的工作程序节点：虚拟机或物理（裸机）机器。机器类型的可用性和定价随集群部署到的专区而有所不同。</p>
  <p>相对于裸机，使用<strong>虚拟机</strong>能以更具成本效益的价格获得更高灵活性、更短供应时间以及更多自动可扩展性功能。但是，与裸机规范（例如，网络 Gbps、RAM 和内存阈值以及存储选项）相比，VM 的性能有所折衷。请牢记以下影响 VM 成本的因素：</p>
  <ul><li><strong>共享与专用</strong>：如果共享 VM 的底层硬件，那么成本低于专用硬件，但物理资源不专供 VM 使用。</li>
  <li><strong>仅按小时计费</strong>：使用按小时计费可更灵活性地快速订购和取消 VM。
  <li><strong>每月分层小时数</strong>：按小时计费是分层的。由于 VM 始终订购的是计费月份内的小时层，因此按小时收取的费率更低。各小时层如下：0 - 150 小时、151 - 290 小时、291 - 540 小时和 541 小时以上。</li></ul>
  <p><strong>物理机器（裸机）</strong>能为工作负载（例如，数据、AI 和 GPU）带来高性能优点。此外，所有硬件资源都专供您的工作负载使用，因此您没有“吵闹的邻居”。请牢记以下影响裸机成本的因素：</p>
  <ul><li><strong>仅按月计费</strong>：所有裸机均按月计费。</li>
  <li><strong>订购过程用时更长</strong>：由于订购和取消裸机服务器是通过 IBM Cloud Infrastructure (SoftLayer) 帐户手动执行的过程，因此可能需要一个工作日以上的时间才能完成。</li></ul>
  <p>有关机器规范的详细信息，请参阅[工作程序节点的可用硬件](/docs/containers/cs_clusters_planning.html#shared_dedicated_node)。</p></dd>

<dt id="bandwidth">公共带宽</dt>
  <dd><p>带宽是指入站和出站网络流量的公共数据传输，包括进出全球数据中心的 {{site.data.keyword.Bluemix_notm}} 资源的数据传输。公共带宽按每 GB 计费。您可以通过登录到 [{{site.data.keyword.Bluemix_notm}} 控制台](https://console.bluemix.net/)，从菜单 ![“菜单”图标](../icons/icon_hamburger.svg "“菜单”图标") 中选择**基础架构**，然后选择**网络 > 带宽 > 摘要**页面来查看当前带宽摘要。
  <p>查看影响公共带宽费用的以下因素：</p>
  <ul><li><strong>位置</strong>：与工作程序节点一样，费用随资源所部署到的专区而有所不同。</li>
  <li><strong>随附带宽或现买现付</strong>：工作程序节点机器可能分配有一定的每月出站联网带宽，例如 250 GB（对于 VM）或 500 GB（对于裸机）。或者，分配可能是根据 GB 使用量现买现付。</li>
  <li><strong>分层包</strong>：超过任何随附的带宽后，会根据按位置变化的分层使用量方案收费。如果超过了某个层分配量，可能还会向您收取标准数据传输费用。</li></ul>
  <p>有关更多信息，请参阅[带宽包 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/bandwidth)。</p></dd>

<dt id="subnets">子网 IP 地址</dt>
  <dd><p>创建标准集群时，会订购具有 8 个公共 IP 地址的可移植公用子网，并按月向您的帐户收费。</p><p>如果基础架构帐户中有可用的子网，那么可以改为使用这些子网。使用 `--no-subnets` [标志](cs_cli_reference.html#cs_cluster_create)创建集群，然后[复用子网](cs_subnets.html#custom)。</p>
  </dd>

<dt id="storage">存储器</dt>
  <dd>供应存储器时，可以选择适合您用例的存储类型和存储类。费用随存储类型、位置和存储实例的规范而有所不同。要选择正确的存储解决方案，请参阅[规划高可用性持久性存储器](cs_storage_planning.html#storage_planning)。有关更多信息，请参阅：<ul><li>[NFS 文件存储器定价 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[块存储器定价 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Object Storage 套餐 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} 服务</dt>
  <dd>与集群集成的每个服务都有自己的定价模型。有关更多信息，请查阅各产品文档和[成本估算器 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/pricing/)。</dd>

</dl>
