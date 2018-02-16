---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-13"

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

通过在 Kubernees 集群中运行的 Docker 容器中部署高可用性应用程序，可迅速开始使用 {{site.data.keyword.Bluemix_notm}}。容器是打包应用程序及其所有依赖项的标准方法，以便您可以无缝地在环境之间移动应用程序。与虚拟机不同，容器不会捆绑操作系统。在容器中只会打包应用程序代码、运行时、系统工具、库和设置。因此容器比虚拟机更轻便、可移植性更高且更高效。
{:shortdesc}


单击以下选项以开始：

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="单击图标以快速开始使用 {{site.data.keyword.containershort_notm}}。使用 {{site.data.keyword.Bluemix_dedicated_notm}}，单击此图标以查看选项。" style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="在 {{site.data.keyword.Bluemix_notm}} 中开始使用 Kubernetes 集群" title="在 {{site.data.keyword.Bluemix_notm}} 中开始使用 Kubernetes 集群" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="安装 CLI。" title="安装 CLI。" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} 云环境" title="{{site.data.keyword.Bluemix_notm}} 云环境" shape="rect" coords="326, -10, 448, 218" />
</map>


## 集群入门
{: #clusters}

想在容器中部署应用程序？稍等一下！请首先创建 Kubernetes 集群。Kubernetes 是一种用于容器的编排工具。使用 Kubernetes，开发者可以通过利用集群的强大功能和灵活性，快速部署高可用性应用程序。
{:shortdesc}

那么什么是集群呢？集群是一组资源、工作程序节点、网络和存储设备，用于使应用程序保持高可用性。拥有集群后，可以将应用程序部署到容器中。

[在开始之前，必须具有“现买现付”或“预订”{{site.data.keyword.Bluemix_notm}} 帐户才能创建 Lite 集群。](https://console.bluemix.net/registration/)


要创建 Lite 集群，请执行以下操作：

1.  在[**目录** ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/catalog/?category=containers) 的**容器**类别中，单击 **Kubernetes 集群**。

2.  输入**集群名称**。缺省集群类型为 Lite。下一次，您可以创建标准集群，并定义其他定制字段，如集群中的工作程序节点数。

3.  单击**创建集群**。这将打开集群的详细信息，但供应集群中的工作程序节点还需要几分钟的时间。您可以在**工作程序节点**选项卡中查看工作程序节点的状态。当状态变为“`就绪`”时，说明工作程序节点已准备就绪可供使用。

非常好！您已创建第一个集群！

*   Lite 集群有一个工作程序节点，其中有 2 个 CPU 和 4 GB 内存可供应用程序使用。
*   工作程序节点由 {{site.data.keyword.IBM_notm}} 拥有的一个专用高可用性 Kubernetes 主节点进行集中监视和管理，该主节点控制和监视集群中的所有 Kubernetes 资源。此外，您可以专注于工作程序节点以及该工作程序节点中部署的应用程序，而不必担心如何管理此主节点。
*   运行集群所需的资源（例如 VLAN 和 IP 地址）在 {{site.data.keyword.IBM_notm}} 拥有的 IBM Cloud infrastructure (SoftLayer) 帐户中进行管理。创建标准集群时，可在您自己的 IBM Cloud infrastructure (SoftLayer) 帐户中管理这些资源。创建标准集群时，可以了解有关这些资源的更多信息。


**接下来要做什么？**

集群启动并开始运行后，请首先对集群执行一些操作。

* [安装 CLI 以开始使用集群。](cs_cli_install.html#cs_cli_install)
* [在集群中部署应用程序。](cs_app.html#app_cli)
* [创建具有多个节点的标准集群以获得更高可用性。](cs_clusters.html#clusters_ui)
* [在 {{site.data.keyword.Bluemix_notm}} 中设置自己的专用注册表，以存储 Docker 映像并与其他用户共享这些映像。](/docs/services/Registry/index.html)
