---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# 规划高可用性持久性存储器
{: #storage_planning}

## 非持久性数据存储选项
{: #non_persistent}

如果数据不需要持久存储，或者数据无需在应用程序实例间共享，那么可以使用非持久性存储选项。非持久性存储选项还可用于对应用程序组件进行单元测试或试用新功能。
{: shortdesc}

下图显示 {{site.data.keyword.containerlong_notm}} 中可用的非持久性数据存储选项。这些选项可用于免费和标准集群。
<p>
<img src="images/cs_storage_nonpersistent.png" alt="非持久性数据存储选项" width="500" style="width: 500px; border-style: none"/></p>

<table summary="该表显示非持久性存储选项。每行从左到右阅读，其中第一列是选项编号，第二列是选项标题，第三列是描述。" style="width: 100%">
<caption>非持久性存储选项</caption>
  <thead>
  <th>选项</th>
  <th>描述</th>
  </thead>
  <tbody>
    <tr>
      <td>1. 在容器或 pod 内</td>
      <td>根据设计，容器和 pod 的生存时间短，并且可能会意外发生故障。但是，您可以将数据写入容器的本地文件系统，以存储容器整个生命周期内的数据。容器内的数据不能与其他容器或 pod 共享，并且在容器崩溃或被除去时会丢失。有关更多信息，请参阅[存储容器中的数据](https://docs.docker.com/storage/)。</td>
    </tr>
  <tr>
    <td>2. 在工作程序节点上
</td>
    <td>每个工作程序节点都设置有主存储器和辅助存储器，这由您为工作程序节点选择的机器类型确定。主存储器用于存储来自操作系统的数据，并且无法使用 [Kubernetes <code>hostPath</code> 卷 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) 对其进行访问。辅助存储器用于存储来自 `kubelet` 和容器运行时引擎的数据。可以使用 [Kubernetes <code>emptyDir</code> 卷 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) 来访问辅助存储器。<br/><br/>虽然 <code>hostPath</code> 卷用于将文件从工作程序节点文件系统安装到 pod，但 <code>emptyDir</code> 会创建一个空目录，此目录将分配给集群中的 pod。该 pod 中的所有容器可以对该卷执行读写操作。由于卷会分配给一个特定 pod，因此数据无法与副本集内的其他 pod 共享。
<br/><br/><p>对于以下情况，会除去 <code>hostPath</code> 或 <code>emptyDir</code> 卷及其数据：<ul><li>工作程序节点已删除。</li><li>工作程序节点已重新装入或更新。</li><li>集群已删除。</li><li>{{site.data.keyword.Bluemix_notm}} 帐户进入暂挂状态。</li></ul></p><p>此外，在以下情况下，也将除去 <code>emptyDir</code> 卷中的数据：<ul><li>从工作程序节点中永久删除分配的 pod。</li><li>在其他工作程序节点上安排了分配的 pod。</li></ul></p><p><strong>注</strong>：如果 pod 内的容器崩溃，该卷中的数据在工作程序节点上仍可用。</p></td>
    </tr>
    </tbody>
    </table>


## 用于高可用性的持久性数据存储选项
{: #persistent}

创建高可用性有状态应用程序时，主要困难是如何在多个专区的多个应用程序实例中持久存储数据，并使数据始终保持同步。对于高可用性数据，您希望确保有一个包含多个实例的主数据库，这些实例分布在多个数据中心甚或多个区域中。此主数据库必须被持续复制以保持单个事实源。集群中的所有实例都必须对此主数据库执行读写操作。如果主数据库的一个实例停止运行，其他实例会接管工作负载，避免您的应用程序发生停机时间。
{: shortdesc}

下图显示您在 {{site.data.keyword.containerlong_notm}} 中具有的可使数据在标准集群中实现高可用性的选项。适合您的选项取决于以下因素：
  * **拥有的应用程序的类型：**例如，您可能有一个应用程序必须基于文件存储数据，而不是在数据库内存储数据。
  * **数据存储和路由的法律要求：**例如，您可能只能在美国存储和路由数据，而不能使用位于欧洲的服务。
  * **备份和复原选项：**每个存储选项都随附数据备份和复原功能。检查可用的备份和复原选项是否满足灾难恢复计划的需求，例如备份频率或在主数据中心外部存储数据的功能。
  * **全局复制：**为了实现高可用性，您可能希望设置多个存储器实例以分布在全球各数据中心并进行复制。

<br/>
<img src="images/cs_storage_mz-ha.png" alt="持久性存储器的高可用性选项"/>

<table summary="该表显示持久性存储选项。每行从左到右阅读，其中第一列是选项编号，第二列是选项标题，第三列是描述。" style="width: 100%">
<caption>持久性数据存储选项</caption>
  <thead>
  <th>选项</th>
  <th>描述</th>
  </thead>
  <tbody>
  <tr>
  <td>1. NFS 或块存储器</td>
  <td>使用此选项时，可以利用 Kubernetes 持久性卷在同一专区中持久存储应用程序和容器数据。</br></br><strong>如何供应文件存储器或块存储器？</strong></br>要在集群中供应文件存储器和块存储器，请[使用持久性卷 (PV) 和持久性卷申领 (PVC)](cs_storage_basics.html#pvc_pv)。PVC 和 PV 是 Kubernetes 概念，用于抽象 API 以供应物理文件或块存储设备。可以使用[动态](cs_storage_basics.html#dynamic_provisioning)或[静态](cs_storage_basics.html#static_provisioning)供应来创建 PVC 和 PV。</br></br><strong>可以在多专区集群中使用文件存储器或块存储器吗？</strong></br> 文件存储器和块存储设备特定于专区，不能跨专区或区域共享。要在集群中使用此类型的存储器，必须在存储器所在的专区中至少有一个工作程序节点。</br></br>如果在跨多个专区的集群中[动态供应](cs_storage_basics.html#dynamic_provisioning)文件存储器和块存储器，那么将仅在按循环法选择的 1 个专区中供应存储器。要在多专区集群的所有专区中供应持久性存储器，请重复这些步骤为每个专区供应动态存储器。例如，如果集群跨专区 `dal10`、`dal12` 和 `dal13`，那么第一次动态供应持久性存储器时，可能会在 `dal10` 中供应该存储器。另外创建两个 PVC 以涵盖 `dal12`和 `dal13`。</br></br><strong>如果要跨专区共享数据该怎么办？</strong></br>如果要跨专区共享数据，请使用云数据库服务，例如 [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) 或 [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage)。</td>
  </tr>
  <tr id="cloud-db-service">
    <td>2. Cloud 数据库服务</td>
    <td>使用此选项时，可以利用 {{site.data.keyword.Bluemix_notm}} 数据库服务（例如 [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant)）来持久存储数据。</br></br><strong>可以将云数据库服务用于多专区集群吗？</strong></br>通过云数据库服务，数据可存储在指定服务实例的集群外部。服务实例将供应到一个专区中。但是，每个服务实例都随附一个外部接口，可以使用该接口来访问数据。将数据库服务用于多专区集群时，可以在集群、专区和区域之间共享数据。要使服务实例可用性更高，可以选择跨专区设置多个实例，并在实例之间进行复制，以实现更高的可用性。 </br></br><strong>如何将云数据库服务添加到集群？</strong></br>要在集群中使用服务，必须[绑定 {{site.data.keyword.Bluemix_notm}} 服务](cs_integrations.html#adding_app)到集群中的名称空间。将该服务绑定到集群时，将创建 Kubernetes 私钥。Kubernetes 私钥会保存有关该服务的保密信息，例如服务的 URL、用户名和密码。可以将私钥作为私钥卷安装到 pod，并使用该私钥中的凭证来访问该服务。通过将私钥卷安装到其他 pod，还可以在 pod 之间共享数据。容器崩溃或从工作程序节点中除去 pod 时，数据不会除去，而是仍可由安装该私钥卷的其他 pod 访问。</br></br>大多数 {{site.data.keyword.Bluemix_notm}} 数据库服务都免费对较小的数据量提供磁盘空间，因此您可以测试其功能。
</p></td>
  </tr>
  <tr>
    <td>3. 内部部署数据库</td>
    <td>如果由于法律原因必须在现场存储数据，请[设置 VPN 连接](cs_vpn.html#vpn)以连接到内部部署数据库，并使用数据中心内的现有存储、备份和复制机制。</td>
  </tr>
  </tbody>
  </table>

{: caption="表. 用于在 Kubernetes 集群中进行部署的持久数据存储选项" caption-side="top"}
