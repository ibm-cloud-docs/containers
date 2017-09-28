---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-014"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# {{site.data.keyword.containerlong_notm}} 入门
{: #container_index}

管理 {{site.data.keyword.IBM}} 云上 Docker 容器和 Kubernetes 集群内的高可用性应用程序。容器是一种标准的打包方法，用于打包应用程序及其所有依赖项，以便应用程序可以在环境之间移动，并且无需更改即可运行。与虚拟机不同，容器不会捆绑操作系统。容器中仅打包有应用程序代码、运行时、系统工具、库和设置，这使得容器比虚拟机更轻便、可移植性更高且更高效。


单击选项以开始：

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="使用 Bluemix Public，可以创建 Kubernetes 集群或将单个和可扩展容器组迁移到集群。使用 Bluemix Dedicated 时，请单击此图标以查看选项。" style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="在 Bluemix 中开始使用 Kubernetes 集群" title="在 Bluemix 中开始使用 Kubernetes 集群" shape="rect" coords="-7, -8, 108, 211" />
    <area href="cs_classic.html#cs_classic" alt="在 IBM Bluemix Container Service (Kraken) 中运行单个和可扩展容器" title="在 IBM Bluemix Container Service (Kraken) 中运行单个和可扩展容器" shape="rect" coords="155, -1, 289, 210" />
    <area href="cs_ov.html#dedicated_environment" alt="Bluemix Dedicated 云环境" title="Bluemix Dedicated 云环境" shape="rect" coords="326, -10, 448, 218" />
</map>


## 在 {{site.data.keyword.Bluemix_notm}} 中开始使用集群
{: #clusters}

Kubernetes 是一种编排工具，用于将应用程序容器安排到计算机器的集群中。使用 Kubernetes，开发者可以通过利用容器的强大功能和灵活性，快速开发出高可用性应用程序。
{:shortdesc}

要使用 Kubernetes 部署应用程序，请先创建集群。集群是组织成网络的一组工作程序节点。集群的用途是定义一组资源、节点、网络和存储设备，以便使应用程序保持高可用性。

要创建 Lite 集群，请执行以下操作：

1.  在[**目录** ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/catalog/?category=containers) 的**容器**类别中，单击 **Kubernetes 集群**。

2.  输入集群详细信息。缺省集群类型为 Lite，所以您只需要定制为数不多的几个字段。接下来，可以创建标准集群，并定义其他定制，如集群中的工作程序节点数。
    1.  输入**集群名称**。
    2.  选择要在其中部署集群的**位置**。可用的位置取决于您登录到的区域。选择物理上与您最近的区域，以获得最佳性能。


    可用位置为：

    <ul><li>美国南部<ul><li>dal10 [达拉斯]</li><li>dal12 [达拉斯]</li></ul></li><li>英国南部<ul><li>lon02 [伦敦]</li><li>lon04 [伦敦]</li></ul></li><li>欧洲中部<ul><li>ams03 [阿姆斯特丹]</li><li>ra02 [法兰克福]</li></ul></li><li>亚太南部<ul><li>syd01 [悉尼]</li><li>syd04 [悉尼]</li></ul></li></ul>
        
3.  单击**创建集群**。这将打开集群的详细信息，但集群中的工作程序节点需要几分钟的时间才能供应。可以在**工作程序节点**选项卡中查看工作程序节点的状态。状态为“`就绪`”时，说明工作程序节点已准备就绪可供使用。

非常好！您已创建第一个集群！

*   Lite 集群有一个工作程序节点，其中有 2 个 CPU 和 4 GB 内存可供应用程序使用。
*   工作程序节点由 {{site.data.keyword.IBM_notm}} 拥有的一个专用高可用性 Kubernetes 主节点进行集中监视和管理，该主节点控制和监视集群中的所有 Kubernetes 资源。此外，您可以专注于工作程序节点以及该工作程序节点中部署的应用程序，而不必担心如何管理此主节点。
*   运行集群所需的资源（例如 VLAN 和 IP 地址）在 {{site.data.keyword.IBM_notm}} 拥有的 {{site.data.keyword.BluSoftlayer_full}} 帐户中进行管理。创建标准集群时，可在您自己的 {{site.data.keyword.BluSoftlayer_notm}} 帐户中管理这些资源。创建标准集群时，可以了解有关这些资源的更多信息。
*   **提示**：在免费试用期结束后，除非您[升级到 {{site.data.keyword.Bluemix_notm}} 现买现付帐户](/docs/pricing/billable.html#upgradetopayg)，否则将自动除去使用 {{site.data.keyword.Bluemix_notm}} 免费试用帐户创建的 Lite 集群。


**接下来要做什么？**

集群启动并开始运行后，可以检查以下任务。

* [安装 CLI 以开始使用集群。](cs_cli_install.html#cs_cli_install)
* [在集群中部署应用程序。](cs_apps.html#cs_apps_cli)
* [创建具有多个节点的标准集群以获得更高可用性。](cs_cluster.html#cs_cluster_ui)
* [在 {{site.data.keyword.Bluemix_notm}} 中设置自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry/index.html)


## 在 {{site.data.keyword.Bluemix_notm}} Dedicated 中开始使用集群（封闭 Beta 版）
{: #dedicated}

Kubernetes 是一种编排工具，用于将应用程序容器安排到计算机器的集群中。使用 Kubernetes，开发者可以通过利用其 {{site.data.keyword.Bluemix_notm}} Dedicated 实例中容器的强大功能和灵活性，快速开发出高可用性应用程序。
{:shortdesc}

开始之前，请[设置 {{site.data.keyword.Bluemix_notm}} Dedicated 环境](cs_ov.html#setup_dedicated)。然后，您可以创建集群。集群是组织成网络的一组工作程序节点。集群的用途是定义一组资源、节点、网络和存储设备，以便使应用程序保持高可用性。拥有集群后，可以将应用程序部署到该集群中。

**提示：**如果您的组织还没有 {{site.data.keyword.Bluemix_notm}} Dedicated 环境，那么您可能不需要该环境。[首先在 {{site.data.keyword.Bluemix_notm}} Public 环境中尝试专用的标准集群。](cs_cluster.html#cs_cluster_ui)

要在 {{site.data.keyword.Bluemix_notm}} Dedicated 中部署集群，请执行以下操作：

1.  使用您的 IBM 标识登录到 {{site.data.keyword.Bluemix_notm}} Public 控制台 ([https://console.bluemix.net ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/catalog/?category=containers))。虽然您必须向 {{site.data.keyword.Bluemix_notm}} Public 请求集群，但却要将该集群部署到 {{site.data.keyword.Bluemix_notm}} Dedicated 帐户中。
2.  如果您有多个帐户，请在“帐户”菜单中选择 {{site.data.keyword.Bluemix_notm}} 帐户。
3.  在目录的**容器**类别中，单击 **Kubernetes 集群**。
4.  输入集群详细信息。
    1.  输入**集群名称**。
    2.  选择要在工作程序节点中使用的 **Kubernetes 版本**。 
    3.  选择**机器类型**。机器类型用于定义在每个工作程序节点中设置并可用于节点中部署的所有容器的虚拟 CPU 量和内存量。
    4.  选择需要的**工作程序节点数**。选择 3 以实现集群的更高可用性。
    
    集群类型、位置、公用 VLAN、专用 VLAN 和硬件字段是在 {{site.data.keyword.Bluemix_notm}} Dedicated 帐户的创建过程中定义的，因此您无法调整这些值。
5.  单击**创建集群**。这将打开集群的详细信息，但集群中的工作程序节点需要几分钟的时间才能供应。可以在**工作程序节点**选项卡中查看工作程序节点的状态。状态为“`就绪`”时，说明工作程序节点已准备就绪可供使用。

    工作程序节点由 {{site.data.keyword.IBM_notm}} 拥有的一个专用高可用性 Kubernetes 主节点进行集中监视和管理，该主节点控制和监视集群中的所有 Kubernetes 资源。此外，您可以专注于工作程序节点以及该工作程序节点中部署的应用程序，而不必担心如何管理此主节点。

非常好！您已创建第一个集群！


**接下来要做什么？**

集群启动并开始运行后，可以检查以下任务。

* [安装 CLI 以开始使用集群。](cs_cli_install.html#cs_cli_install)
* [将应用程序部署到集群](cs_apps.html#cs_apps_cli)。
* [将 {{site.data.keyword.Bluemix_notm}} 服务添加到集群](cs_cluster.html#binding_dedicated)。
* [了解 {{site.data.keyword.Bluemix_notm}} Dedicated 和 Public 中集群之间的差异](cs_ov.html#env_differences)。

