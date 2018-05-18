---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 为什么使用 {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containerlong}} 通过组合 Docker 和 Kubernetes 技术、直观的用户体验以及内置安全性和隔离，提供功能强大的工具来自动对计算主机集群中的容器化应用程序进行部署、操作、扩展和监视。
{:shortdesc}

## 使用服务的优点
{: #benefits}

集群会部署在提供本机 Kubernetes 和特定于 {{site.data.keyword.IBM_notm}} 的功能的计算主机上。
{:shortdesc}

|优点|描述|
|-------|-----------|
|隔离了计算、网络和存储基础架构的单租户 Kubernetes 集群|<ul><li>创建自己的定制基础架构，以满足组织的需求。</li><li>使用 IBM Cloud infrastructure (SoftLayer) 提供的资源来供应专用而安全的 Kubernetes 主节点、工作程序节点、虚拟网络和存储器。</li><li>由 {{site.data.keyword.IBM_notm}} 持续监视和更新的完全受管 Kubernetes 主节点，使您的集群可用。</li><li>用于将工作程序节点作为具有可信计算的裸机服务器供应的选项。</li><li>存储持久数据，在 Kubernetes pod 之间共享数据，以及在需要时使用集成和安全卷服务复原数据。</li><li>受益于对所有本机 Kubernetes API 的完全支持。</li></ul>|
|使用漏洞顾问程序确保映像安全合规性|<ul><li>设置自己的安全 Docker 专用映像注册表，映像会存储在该注册表中，并供组织中的所有用户共享。</li><li>受益于自动扫描专用 {{site.data.keyword.Bluemix_notm}} 注册表中的映像。</li><li>查看特定于映像中所用操作系统的建议，以修复潜在漏洞。</li></ul>|
|持续监视集群运行状况|<ul><li>使用集群仪表板可快速查看和管理集群、工作程序节点和容器部署的运行状况。</li><li>使用 {{site.data.keyword.monitoringlong}}，找到详细的使用量度量值，并快速扩展集群以满足工作负载需求。</li><li>使用 {{site.data.keyword.loganalysislong}} 复查日志记录信息，以查看详细的集群活动。</li></ul>|
|安全地向公众公开应用程序|<ul><li>在公共 IP 地址、{{site.data.keyword.IBM_notm}} 提供的路径或自己的定制域之间进行选择，以通过因特网访问集群中的服务。</li></ul>|
|{{site.data.keyword.Bluemix_notm}} 服务集成|<ul><li>通过集成 {{site.data.keyword.Bluemix_notm}} 服务（例如，Watson API、Blockchain、数据服务或 Internet of Things）向应用程序添加额外的功能。</li></ul>|



<br />




## 比较免费和标准集群
{: #cluster_types}

您可以创建一个免费集群或创建任意数量的标准集群。试用免费集群以熟悉和测试一些 Kubernetes 功能，或者创建标准集群以使用完整的 Kubernetes 功能来部署应用程序。
{:shortdesc}

|特征|免费集群|标准集群|
|---------------|-------------|-----------------|
|[集群内联网](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[NodePort 服务对非稳定 IP 地址的公用网络应用程序访问权](cs_nodeport.html#planning)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用户访问管理](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[从集群和应用程序访问 {{site.data.keyword.Bluemix_notm}} 服务](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[工作程序节点上用于非持久性存储的磁盘空间](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[基于 NFS 文件的持久存储器（带有卷）](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[LoadBalancer 服务对稳定 IP 地址的公用或专用网络应用程序访问权](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[Ingress 服务对稳定 IP 地址和可定制 URL 的公用网络应用程序访问权](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[可移植公共 IP 地址](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[日志记录和监视](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用于在物理（裸机服务器）服务器上供应工作程序节点的选项](cs_clusters.html#shared_dedicated_node)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[用于供应具有可信计算的裸机工作程序的选项](cs_clusters.html#shared_dedicated_node)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|
|[在 {{site.data.keyword.Bluemix_dedicated_notm}} 中可用](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="功能可用" style="width:32px;" />|

<br />



## 集群管理责任
{: #responsibilities}

查看您与 IBM 共享的用于管理集群的责任。
{:shortdesc}

**IBM 负责：**

- 在集群中部署主节点、工作程序节点和管理组件，例如在集群创建时部署 Ingress 应用程序负载均衡器
- 管理集群的 Kubernetes 主节点的更新、监视和恢复
- 监视工作程序节点的运行状况并为这些工作程序节点的更新和恢复提供自动化
- 对基础架构帐户执行自动化任务，包括添加工作程序节点、除去工作程序节点以及创建缺省子网
- 管理、更新和恢复集群内的操作组件，例如 Ingress 应用程序负载均衡器和存储插件
- 在持久性卷申领请求时供应存储卷
- 在所有工作程序节点上提供安全性设置

</br>
**您负责：**

- [在集群中部署和管理 Kubernetes 资源，例如，Pod、服务和部署](cs_app.html#app_cli)
- [利用服务和 Kubernetes 的功能以确保应用程序的高可用性](cs_app.html#highly_available_apps)
- [通过使用 CLI 添加或除去工作程序节点来添加或除去容量](cs_cli_reference.html#cs_worker_add)
- [在 IBM Cloud infrastructure (SoftLayer) 中创建公用和专用 VLAN 以针对集群进行网络隔离](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [确保所有工作程序节点都具有到 Kibernetes 主节点 URL 的网络连接](cs_firewall.html#firewall)<p>**注**：如果工作程序节点同时具有公用和专用 VLAN，那么已配置网络连接。如果工作程序节点采用了仅专用 VLAN 的设置，那么需要 Vyatta 来提供网络连接。</p>
- [Kubernetes 主版本或次版本更新可用时，更新 kube-apiserver 主节点和工作程序节点](cs_cluster_update.html#master)
- [通过运行 `kubectl` 命令（如 `cordon` 或 `drain`）以及运行 `bx cs` 命令（如 `reboot`、`reload` 或 `delete`](cs_cli_reference.html#cs_worker_reboot)）来恢复有故障的工作程序节点。
- [根据需要在 IBM Cloud infrastructure (SoftLayer) 中添加或除去子网](cs_subnets.html#subnets)
- [在 IBM Cloud infrastructure (SoftLayer) 中备份和复原持久性存储器中的数据 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](../services/RegistryImages/ibm-backup-restore/index.html)
- [使用自动恢复为工作程序节点配置运行状况监视](cs_health.html#autorecovery)

<br />


## 容器滥用
{: #terms}

客户机不能滥用 {{site.data.keyword.containershort_notm}}。
{:shortdesc}

滥用包括：

*   任何非法活动
*   分发或执行恶意软件
*   损害 {{site.data.keyword.containershort_notm}} 或干扰任何人使用 {{site.data.keyword.containershort_notm}}
*   损害或干扰任何人使用任何其他服务或系统
*   对任何服务或系统进行未经授权的访问
*   对任何服务或系统进行未经授权的修改
*   侵犯他人的权利

请参阅 [Cloud Services 条款](/docs/navigation/notices.html#terms)，以获取总体使用条款。
