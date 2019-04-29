---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

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



# 使用 {{site.data.keyword.containerlong_notm}} 的责任
了解使用 {{site.data.keyword.containerlong}} 时，您的集群管理责任以及相关条款和条件。
{:shortdesc}

## 集群管理责任
{: #responsibilities}

查看您与 IBM 共享的用于管理集群的责任。
{:shortdesc}

**IBM 负责：**

- 在集群中部署主节点、工作程序节点和管理组件，例如在集群创建时部署 Ingress 应用程序负载均衡器
- 为集群的 Kubernetes 主节点提供安全性更新、监视、隔离和恢复功能
- 使版本更新和安全补丁可供您应用于集群工作程序节点
- 监视工作程序节点的运行状况并为这些工作程序节点的更新和恢复提供自动化
- 对基础架构帐户执行自动化任务，包括添加工作程序节点、除去工作程序节点以及创建缺省子网
- 管理、更新和恢复集群内的操作组件，例如 Ingress 应用程序负载均衡器和存储插件
- 在持久卷声明请求时供应存储卷
- 在所有工作程序节点上提供安全性设置

</br>

**您负责：**

- [为 {{site.data.keyword.containerlong_notm}} API 密钥配置相应许可权，以访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合和其他 {{site.data.keyword.Bluemix_notm}} 服务](/docs/containers?topic=containers-users#api_key)
- [在集群中部署和管理 Kubernetes 资源，例如，Pod、服务和部署](/docs/containers?topic=containers-app#app_cli)
- [利用服务和 Kubernetes 的功能以确保应用程序的高可用性](/docs/containers?topic=containers-app#highly_available_apps)
- [通过调整工作程序池大小来添加或除去集群容量](/docs/containers?topic=containers-clusters#add_workers)
- [启用 VLAN 生成并使多专区工作程序池跨专区保持均衡](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [在 IBM Cloud Infrastructure (SoftLayer) 中创建公用和专用 VLAN 以针对集群进行网络隔离](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [确保所有工作程序节点都具有到 Kubernetes Service 端点 URL 的网络连接](/docs/containers?topic=containers-firewall#firewall)<p class="note">如果工作程序节点同时具有公用和专用 VLAN，那么已配置网络连接。如果工作程序节点设置为仅使用专用 VLAN，那么必须通过[启用专用服务端点](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置网关设备](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)，允许工作程序节点和集群主节点进行通信。
        如果设置了防火墙，那么必须管理和配置其设置，以允许访问用于集群的 {{site.data.keyword.containerlong_notm}} 和其他 {{site.data.keyword.Bluemix_notm}} 服务。</p>
- [Kubernetes 版本更新可用时更新主 kube-apiserver](/docs/containers?topic=containers-update#master)
- [使主版本、次版本和补丁版本上的工作程序节点保持最新](/docs/containers?topic=containers-update#worker_node) <p class="note">不能更改工作程序节点的操作系统或登录到工作程序节点。工作程序节点更新由 IBM 以包含最新安全补丁的完整工作程序节点映像形式提供。要应用更新，必须使用新映像重新创建工作程序节点的映像并重新装入工作程序节点。重新装入工作程序节点时，会自动轮换 root 用户的密钥。
</p>
- [通过设置集群组件的日志转发来监视集群的运行状况](/docs/containers?topic=containers-health#health)。   
- [通过运行 `kubectl` 命令（如 `cordon` 或 `drain`）以及运行 `ibmcloud ks` 命令（如 `reboot`、`reload` 或 `delete`](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)）来恢复有故障的工作程序节点。
- [根据需要在 IBM Cloud Infrastructure (SoftLayer) 中添加或除去子网](/docs/containers?topic=containers-subnets#subnets)
- [在 IBM Cloud Infrastructure (SoftLayer) 中备份和复原持久性存储器中的数据 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- 设置[日志记录](/docs/containers?topic=containers-health#logging)和[监视](/docs/containers?topic=containers-health#view_metrics)服务，为集群的运行状况和性能提供支持
- [使用自动恢复为工作程序节点配置运行状况监视](/docs/containers?topic=containers-health#autorecovery)
- 审计用于更改集群中资源的事件，例如通过使用 [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) 查看用于更改 {{site.data.keyword.containerlong_notm}} 实例状态的用户启动活动来实现此操作

<br />


## 滥用 {{site.data.keyword.containerlong_notm}}
{: #terms}

客户机不能滥用 {{site.data.keyword.containerlong_notm}}。
{:shortdesc}

滥用包括：

*   任何非法活动
*   分发或执行恶意软件
*   损害 {{site.data.keyword.containerlong_notm}} 或干扰任何人使用 {{site.data.keyword.containerlong_notm}}
*   损害或干扰任何人使用任何其他服务或系统
*   对任何服务或系统进行未经授权的访问
*   对任何服务或系统进行未经授权的修改
*   侵犯他人的权利

请参阅 [Cloud Services 条款](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms)，以获取总体使用条款。
