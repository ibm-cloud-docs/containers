---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}}的安全性
{: #security}

您可以使用内置安全性功能来进行风险分析和安全保护。这些功能有助于保护集群基础架构和网络通信，隔离计算资源，以及确保基础架构组件和容器部署中的安全合规性。
{: shortdesc}

## 集群组件的安全性
{: #cluster}

每个 {{site.data.keyword.containerlong_notm}} 集群都有内置到其[主](#master)节点和[工作程序](#worker)节点的安全功能。如果您有防火墙，需要从集群外部访问负载均衡，或者想要在企业网络策略阻止访问公用因特网端点时，从本地系统运行 `kubectl` 命令，那么可[在防火墙中打开端口](cs_firewall.html#firewall)。如果要将集群中的应用程序连接到内部部署网络或连接到集群外部的其他应用程序，请[设置 VPN 连接](cs_vpn.html#vpn)。
{: shortdesc}

在下图中，可以看到按 Kubernetes 主节点、工作程序节点和容器映像分组的安全功能。


<img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} 集群安全性" style="width:400px; border-style: none"/>


  <table summary="表中的第一行跨两列。其余行应从左到右阅读，其中第一列是服务器位置，第二列是要匹配的 IP 地址。">
  <thead>
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> {{site.data.keyword.containershort_notm}} 中的内置集群安全设置</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes 主节点</td>
      <td>每个集群中的 Kubernetes 主节点由 IBM 管理，具备高可用性，并且包含 {{site.data.keyword.containershort_notm}} 安全设置，用于确保工作程序节点的安全合规性以及保护与工作程序节点之间的往来通信。IBM 会根据需要执行更新。专用 Kubernetes 主节点集中控制和监视集群中的所有 Kubernetes 资源。根据集群中的部署需求和容量，Kubernetes 主节点会自动安排容器化应用程序在可用的工作程序节点之间进行部署。有关更多信息，请参阅 [Kubernetes 主节点安全性](#master)。</td>
    </tr>
    <tr>
      <td>工作程序节点</td>
      <td>容器部署在工作程序节点上；这些工作程序节点专用于集群，并确保为 IBM 客户提供计算、网络和存储隔离功能。{{site.data.keyword.containershort_notm}} 提供了内置安全性功能，以使工作程序节点在专用和公用网络上保持安全，并确保工作程序节点的安全合规性。有关更多信息，请参阅[工作程序节点安全性](#worker)。此外，可以添加 [Calico 网络策略](cs_network_policy.html#network_policies)，以进一步指定要允许或阻止与工作程序节点上的 pod 之间进出的哪些网络流量。
</td>
     </tr>
     <tr>
      <td>映像</td>
      <td>作为集群管理员，您可以在 {{site.data.keyword.registryshort_notm}} 中设置自己的安全 Docker 映像存储库，在其中可以存储 Docker 映像并在集群用户之间共享这些映像。为了确保容器部署的安全，漏洞顾问程序会扫描专用注册表中的每个映像。漏洞顾问程序是 {{site.data.keyword.registryshort_notm}} 的一个组件，用于扫描以查找潜在的漏洞，提出安全性建议，并提供解决漏洞的指示信息。有关更多信息，请参阅 [{{site.data.keyword.containershort_notm}} 中的映像安全性](#images)。</td>
    </tr>
  </tbody>
</table>

<br />


## Kubernetes 主节点
{: #master}

查看内置 Kubernetes 主节点安全功能，以保护 Kubernetes 主节点，并保护集群网络通信安全。
{: shortdesc}

<dl>
  <dt>全面管理的专用 Kubernetes 主节点</dt>
    <dd>{{site.data.keyword.containershort_notm}} 中的每个 Kubernetes 集群都由 IBM 拥有的 IBM Cloud Infrastructure(SoftLayer) 帐户中 IBM 管理的专用 Kubernetes 主节点进行控制。Kubernetes 主节点设置有以下专用组件，这些组件不与其他 IBM 客户共享。<ul><li>etcd 数据存储器：存储集群的所有 Kubernetes 资源，例如服务、部署和 pod。Kubernetes ConfigMaps 和 Secrets 是存储为键/值对的应用程序数据，可由 pod 中运行的应用程序使用。etcd 中的数据存储在加密磁盘上，该磁盘由 IBM 管理，并在发送到 pod 时通过 TLS 加密，以确保数据保护和数据完整性。</li>
    <li>kube-apiserver：充当从工作程序节点到 Kubernetes 主节点的所有请求的主入口点。kube-apiserver 会验证并处理请求，并可以对 etcd 数据存储器执行读写操作。</li>
    <li>kube-scheduler：决定 pod 的部署位置，同时考虑容量和性能需求、软硬件策略约束、反亲缘关系规范和工作负载需求。如果找不到与这些需求相匹配的工作程序节点，那么不会在集群中部署 pod。</li>
    <li>kube-controller-manager：负责监视副本集，并创建相应的 pod 以实现所需状态。</li>
    <li>OpenVPN：特定于 {{site.data.keyword.containershort_notm}} 的组件，用于为所有 Kubernetes 主节点到工作程序节点的通信提供安全的网络连接。</li></ul></dd>
  <dt>针对工作程序节点到 Kubernetes 主节点的所有通信，受到 TLS 保护的网络连接</dt>
    <dd>为了保护与 Kubernetes 主节点的网络通信，{{site.data.keyword.containershort_notm}} 会生成 TLS 证书，用于加密每个集群的 kube-apiserver 与 etcd 数据存储器组件之间的通信。这些证书从不会在集群之间或在 Kubernetes 主节点组件之间进行共享。</dd>
  <dt>针对 Kubernetes 主节点到工作程序节点的所有通信，受到 OpenVPN 保护的网络连接</dt>
    <dd>虽然 Kubernetes 会使用 `https` 协议来保护 Kubernetes 主节点与工作程序节点之间的通信，但缺省情况下不会在工作程序节点上提供任何认证。为了保护此通信，在创建集群时，{{site.data.keyword.containershort_notm}} 会自动设置 Kubernetes 主节点与工作程序节点之间的 OpenVPN 连接。</dd>
  <dt>持续监视 Kubernetes 主节点网络</dt>
    <dd>每个 Kubernetes 主节点都由 IBM 持续监视，以控制进程级别的拒绝服务 (DOS) 攻击，并采取相应的补救措施。</dd>
  <dt>Kubernetes 主节点安全合规性</dt>
    <dd>{{site.data.keyword.containershort_notm}} 会自动扫描部署了 Kubernetes 主节点的每个节点，以确定是否有 Kubernetes 中找到的漏洞，以及为确保保护主节点而需要应用的特定于操作系统的安全修订。如果找到了漏洞，{{site.data.keyword.containershort_notm}} 会自动代表用户应用修订并解决漏洞。</dd>
</dl>

<br />


## 工作程序节点
{: #worker}

查看内置工作程序节点安全功能，这些功能用于保护工作程序节点环境，并确保资源、网络和存储器隔离。
{: shortdesc}

<dl>
  <dt>计算、网络和存储基础架构隔离</dt>
    <dd>创建集群时，IBM 会将虚拟机作为客户 IBM Cloud infrastructure (SoftLayer) 帐户或专用 IBM Cloud infrastructure (SoftLayer) 帐户中的工作程序节点进行供应。工作程序节点专用于一个集群，而不托管其他集群的工作负载。<p> 每个 {{site.data.keyword.Bluemix_notm}} 帐户都设置有 IBM Cloud infrastructure (SoftLayer) VLAN，以确保工作程序节点上的高质量网络性能和隔离。</p> <p>要在集群中持久存储数据，可以从 IBM Cloud infrastructure (SoftLayer) 供应基于 NFS 的专用文件存储器，并利用该平台的内置数据安全功能。</p></dd>
  <dt>安全的工作程序节点设置</dt>
    <dd>每个工作程序节点都由用户无法更改的 Ubuntu 操作系统进行设置。为保护工作程序节点的操作系统免受潜在攻击，每个工作程序节点都使用 Linux iptable 规则强制实施的专家防火墙设置进行配置。<p> 在 Kubernetes 上运行的所有容器都通过集群创建期间在每个工作程序节点上配置的预定义 Calico 网络策略设置进行保护。此设置将确保工作程序节点与 pod 之间的安全网络通信。要进一步限制容器可以对工作程序节点执行的操作，用户可以选择在工作程序节点上配置 [AppArmor 策略 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tutorials/clusters/apparmor/)。</p><p> 工作程序节点上禁用了 SSH 访问权。如果要在工作程序节点上安装附加功能，那么您可以对要在每个工作程序节点上运行的任何对象使用 [Kubernetes 守护程序集 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset)，或者对您必须执行的任何一次性操作使用 [Kubernetes 作业 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/)。</p></dd>
  <dt>Kubernetes 工作程序节点安全合规性</dt>
    <dd>IBM 与内部和外部安全咨询团队合作，应对潜在的安全合规性漏洞。IBM 会维护对工作程序节点的访问权，以将更新和安全补丁部署到操作系统。
<p> <b>重要事项</b>：定期重新引导工作程序节点，以确保安装自动部署到操作系统的更新和安全补丁。IBM 不会重新引导您的工作程序节点。</p></dd>
  <dt id="encrypted_disks">加密磁盘</dt>
  <dd>缺省情况下，{{site.data.keyword.containershort_notm}} 会为所有供应的工作程序节点提供两个本地 SSD 加密数据分区。第一个分区未加密，第二个分区安装到 _/var/lib/docker_ 并使用 LUKS 加密密钥解锁。每个 Kubernetes 集群中的每个工作程序都有自己的唯一 LUKS 加密密钥，由 {{site.data.keyword.containershort_notm}} 管理。当您创建集群或将工作程序节点添加到现有集群时，将安全地拉取密钥，然后在解锁加密磁盘后废弃。<p><b>注</b>：加密可能会影响磁盘 I/O 性能。对于需要高性能磁盘 I/O 的工作负载，在启用和禁用加密的情况下测试集群以帮助您确定是否关闭加密。</p>
  </dd>
  <dt>对 IBM Cloud infrastructure (SoftLayer) 网络防火墙的支持</dt>
    <dd>{{site.data.keyword.containershort_notm}} 与所有 [IBM Cloud infrastructure (SoftLayer) 防火墙产品 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud-computing/bluemix/network-security) 相兼容。在 {{site.data.keyword.Bluemix_notm}} Public 上，可以使用定制网络策略来设置防火墙，以便为集群提供专用网络安全性，检测网络侵入并进行补救。例如，您可以选择设置 [Vyatta ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/topic/vyatta-1) 以充当防火墙并阻止不需要的流量。设置防火墙时，[还必须为每个区域打开必需的端口和 IP 地址](cs_firewall.html#firewall)，以便主节点和工作程序节点可以通信。</dd>
  <dt>使服务保持专用，或者有选择地将服务和应用程序公开到公用因特网</dt>
    <dd>可以选择使服务和应用程序保持专用，并且利用本主题中所述的内置安全性功能来确保工作程序节点与 pod 之间的安全通信。要将服务和应用程序公开到公用因特网，可以利用 Ingress 和负载均衡器支持来安全地使服务公共可用。</dd>
  <dt>将工作程序节点和应用程序安全地连接到内部部署的数据中心</dt>
  <dd>要将工作程序节点和应用程序连接到内部部署的数据中心，您可以使用 Strongswan 服务或通过 Vyatta 网关设备或 Fortigate 设备，来配置 VPN IPSec 端点。<br><ul><li><b>Strongswan IPSec VPN 服务</b>：您可以设置 [Strongswan IPSec VPN 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.strongswan.org/)，以将 Kubernetes 集群与内部部署网络安全连接。Strongswan IPSec VPN 服务基于业界标准因特网协议安全性 (IPsec) 协议组，通过因特网，提供安全的端到端通信信道。要在集群与内部部署网络之间设置安全连接，您必须在内部部署数据中心内安装 IPsec VPN 网关或 IBM Cloud infrastructure (SoftLayer) 服务器。然后，您可以在 Kubernetes pod 中[配置并部署 Strongswan IPSec VPN 服务](cs_vpn.html#vpn)。</li><li><b>Vyatta 网关设备或 Fortigate 设备</b>：如果您具有更大的集群，那么可选择设置 Vyatta 网关设备或 Fortigate 设备来配置 IPSec VPN 端点。有关更多信息，请参阅[将集群连接到内部部署数据中心 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) 上的这个博客帖子。</li></ul></dd>
  <dt>持续监视和记录集群活动</dt>
    <dd>对于标准集群，{{site.data.keyword.containershort_notm}} 将记录并监视所有与集群相关的事件（例如，添加工作程序节点、滚动更新进度或容量使用情况信息），然后将其发送给 {{site.data.keyword.loganalysislong_notm}} 和 {{site.data.keyword.monitoringlong_notm}}。有关设置日志记录和监视的信息，请参阅[配置集群日志记录](/docs/containers/cs_health.html#logging)和[配置集群监视](/docs/containers/cs_health.html#monitoring)。</dd>
</dl>

<br />


## 映像
{: #images}

使用内置安全性功能来管理映像的安全性与完整性。
{: shortdesc}

<dl>
<dt>{{site.data.keyword.registryshort_notm}} 中的安全 Docker 专用映像存储库</dt>
<dd>可以在 IBM 托管和管理的具备高可用性和高可扩展性的多租户专用映像注册表中设置自己的 Docker 映像存储库，以构建和安全地存储 Docker 映像，并在集群用户之间共享这些映像。</dd>

<dt>映像安全合规性</dt>
<dd>使用 {{site.data.keyword.registryshort_notm}} 时，可以利用漏洞顾问程序提供的内置安全性扫描。对于推送到名称空间的每个映像，都会自动根据包含已知 CentOS、Debian、Red Hat 和 Ubuntu 问题的数据库进行扫描以确定是否有漏洞。如果发现了漏洞，漏洞顾问程序会提供指示信息指导如何解决这些漏洞，以确保映像完整性和安全性。</dd>
</dl>

要查看映像的漏洞评估，请[查看漏洞顾问程序文档](/docs/services/va/va_index.html#va_registry_cli)。

<br />


## 集群内联网
{: #in_cluster_network}

工作程序节点与 pod 之间安全的集群内网络通信可通过专用虚拟局域网 (VLAN) 来实现。VLAN 会将一组工作程序节点和 pod 视为连接到同一物理连线那样进行配置。
{:shortdesc}

创建集群时，每个集群会自动连接到一个专用 VLAN。专用 VLAN 用于确定在集群创建期间分配给工作程序节点的专用 IP 地址。

|集群类型|集群的专用 VLAN 的管理方|
|------------|-------------------------------------------|
|{{site.data.keyword.Bluemix_notm}} 中的 Lite 集群|{{site.data.keyword.IBM_notm}}|
|{{site.data.keyword.Bluemix_notm}} 中的标准集群|您通过您的 IBM Cloud infrastructure (SoftLayer) 帐户<p>**提示**：要有权访问帐户中的所有 VLAN，请打开 [VLAN 生成 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://knowledgelayer.softlayer.com/procedure/enable-or-disable-vlan-spanning)。</p>|

此外，部署到一个工作程序节点的所有 pod 都会分配有一个专用 IP 地址。分配给 pod 的 IP 位于 172.30.0.0/16 专用地址范围内，并且这些 pod 仅在工作程序节点之间进行路由。为了避免冲突，请勿在将与工作程序节点通信的任何节点上使用此 IP 范围。工作程序节点和 pod 可以使用专用 IP 地址在专用网络上安全地通信。但是，当 pod 崩溃或需要重新创建工作程序节点时，会分配新的专用 IP 地址。

由于对于必须具备高可用性的应用程序，很难跟踪其不断变化的专用 IP 地址，因此可以使用内置 Kubernetes 服务发现功能，并将应用程序公开为集群中专用网络上的集群 IP 服务。Kubernetes 服务会将一些 pod 分组在一起，并提供与这些 pod 的网络连接，以供集群中的其他服务使用，而无需公开每个 pod 的实际专用 IP 地址。创建集群 IP 服务后，会从 10.10.10.0/24 专用地址范围中为该服务分配专用 IP 地址。与 pod 专用地址范围一样，请勿在将与工作程序节点通信的任何节点上使用此 IP 范围。此 IP 地址只能在集群内部访问。不能从因特网访问此 IP 地址。同时，会为该服务创建 DNS 查找条目，并将该条目存储在集群的 kube-dns 组件中。DNS 条目包含服务名称、在其中创建服务的名称空间以及指向分配的专用集群 IP 地址的链接。

如果集群中的应用程序需要访问位于集群 IP 服务后端的 pod，那么可以使用分配给该服务的专用集群 IP 地址，也可以使用该服务的名称发送请求。使用服务名称时，会在 kube-dns 组件中查找该名称，并将其路由到服务的专用集群 IP 地址。请求到达服务时，服务会确保所有请求都同等转发到 pod，而不考虑其专用 IP 地址和部署到的工作程序节点。

有关如何创建类型为集群 IP 的服务的更多信息，请参阅 [Kubernetes 服务 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services---service-types)。
