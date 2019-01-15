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

# 用户访问许可权
{: #understanding}



[分配集群许可权](cs_users.html)时，很难判断需要将哪个角色分配给用户。请使用以下各部分中的表来确定在 {{site.data.keyword.containerlong}} 中执行常见任务所需的最低许可权级别。
{: shortdesc}

## {{site.data.keyword.Bluemix_notm}} IAM 平台和 Kubernetes RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}} 已配置为使用 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 角色。{{site.data.keyword.Bluemix_notm}} IAM 平台角色确定用户可对集群执行的操作。分配有平台角色的每个用户还会在缺省名称空间中自动分配有相应的 Kubernetes 基于角色的访问控制 (RBAC) 角色。此外，平台角色会自动为用户设置基本的基础架构许可权。要设置策略，请参阅[分配 {{site.data.keyword.Bluemix_notm}} IAM 平台许可权](cs_users.html#platform)。要了解有关 RBAC 角色的更多信息，请参阅[分配 RBAC 许可权](cs_users.html#role-binding)。
{: shortdesc}

下表显示了每个平台角色授予的集群管理许可权，以及相应 RBAC 角色的 Kubernetes 资源许可权。

<table summary="该表显示了 IAM 平台角色的用户许可权和相应 RBAC 策略。每行从左到右阅读，其中第一列是 IAM 平台角色，第二列是集群许可权，第三列是相应的 RBAC 角色。">
<caption>集群管理许可权（按平台和 RBAC 角色）</caption>
<thead>
    <th>平台角色</th>
    <th>集群管理许可权</th>
    <th>相应的 RBAC 角色和资源许可权</th>
</thead>
<tbody>
  <tr>
    <td>**查看者**</td>
    <td>
      集群：<ul>
        <li>查看资源组和区域的 {{site.data.keyword.Bluemix_notm}} IAM API 密钥所有者的姓名和电子邮件地址</li>
        <li>如果 {{site.data.keyword.Bluemix_notm}} 帐户使用其他凭证来访问 IBM Cloud Infrastructure (SoftLayer) 产品服务组合，那么可查看基础架构用户名</li>
        <li>列出所有集群、工作程序节点、工作程序池、集群中的服务和 Webhook，或查看这些对象的详细信息</li>
        <li>查看基础架构帐户的 VLAN 生成状态</li>
        <li>列出基础架构帐户中的可用子网</li>
        <li>为一个集群设置时：列出专区中集群连接到的 VLAN</li>
        <li>为帐户中的所有集群设置时：列出专区中的所有可用 VLAN</li></ul>
      日志记录：<ul>
        <li>查看目标区域的缺省日志记录端点</li>
        <li>列出日志转发和过滤配置或查看这些配置的详细信息</li>
        <li>查看 Fluentd 附加组件自动更新的状态</li></ul>
      Ingress：<ul>
        <li>列出集群中的所有 ALB 或查看这些 ALB 的详细信息</li>
        <li>查看区域中支持的 ALB 类型</li></ul>
    </td>
    <td><code>view</code> 集群角色由 <code>ibm-view</code> 角色绑定进行应用，在 <code>default</code> 名称空间中提供以下许可权：<ul>
      <li>对缺省名称空间内部资源的读访问权</li>
      <li>对 Kubernetes 私钥无读访问权</li></ul>
    </td>
  </tr>
  <tr>
    <td>**编辑者** <br/><br/><strong>提示</strong>：将此角色用于应用程序开发者，并分配 <a href="#cloud-foundry">Cloud Foundry</a> **开发者**角色。</td>
    <td>此角色具有“查看者”角色中的所有许可权，另外还有以下许可权：</br></br>
      集群：<ul>
        <li>将 {{site.data.keyword.Bluemix_notm}} 服务绑定到集群以及取消服务到集群的绑定</li></ul>
      日志记录：<ul>
        <li>创建、更新和删除 API 服务器审计 Webhook</li>
        <li>创建集群 Webhook</li>
        <li>针对除 `kube-audit` 以外的其他所有类型创建和删除日志转发配置</li>
        <li>更新和刷新日志转发配置</li>
        <li>创建、更新和删除日志过滤配置</li></ul>
      Ingress：<ul>
        <li>启用或禁用 ALB</li></ul>
    </td>
    <td><code>edit</code> 集群角色由 <code>ibm-edit</code> 角色绑定进行应用，在 <code>default</code> 名称空间中提供以下许可权：
      <ul><li>对缺省名称空间内部资源的读/写访问权</li></ul></td>
  </tr>
  <tr>
    <td>**操作员**</td>
    <td>此角色具有“查看者”角色中的所有许可权，另外还有以下许可权：</br></br>
      集群：<ul>
        <li>更新集群</li>
        <li>刷新 Kubernetes 主节点</li>
        <li>添加和除去工作程序节点</li>
        <li>重新引导、重新装入和更新工作程序节点</li>
        <li>创建和删除工作程序池</li>
        <li>向工作程序池添加专区和从工作程序池中除去专区</li>
        <li>更新工作程序池中给定专区的网络配置</li>
        <li>调整工作程序池大小并重新均衡工作程序池</li>
        <li>创建子网并将其添加到集群</li>
        <li>向集群添加用户管理的子网和从集群中除去用户管理的子网</li></ul>
    </td>
    <td><code>admin</code> 集群角色由 <code>ibm-operate</code> 集群角色绑定进行应用，提供以下许可权：<ul>
      <li>对名称空间内资源的读/写访问权，但对名称空间本身没有读/写访问权</li>
      <li>在名称空间内创建 RBAC 角色</li></ul></td>
  </tr>
  <tr>
    <td>**管理员**</td>
    <td>此角色具有此帐户中所有集群的“编辑者”、“操作员”和“查看者”角色中的所有许可权，另外还有以下许可权：</br></br>
      集群：<ul>
        <li>创建免费或标准集群</li>
        <li>删除集群</li>
        <li>使用 {{site.data.keyword.keymanagementservicefull}} 加密 Kubernetes 私钥</li>
        <li>为 {{site.data.keyword.Bluemix_notm}} 帐户设置 API 密钥以访问链接的 IBM Cloud Infrastructure (SoftLayer) 产品服务组合</li>
        <li>设置、查看和除去用于访问不同 IBM Cloud Infrastructure (SoftLayer) 产品服务组合的 {{site.data.keyword.Bluemix_notm}} 帐户的基础架构凭证</li>
        <li>为帐户中的其他现有用户分配和更改 {{site.data.keyword.Bluemix_notm}} IAM 平台角色</li>
        <li>为所有区域中的所有 {{site.data.keyword.containerlong_notm}} 实例（集群）设置时：列出帐户中的所有可用 VLAN</ul>
      日志记录：<ul>
        <li>针对 `kube-audit` 类型创建和更新日志转发配置</li>
        <li>在 {{site.data.keyword.cos_full_notm}} 存储区中收集 API 服务器日志的快照</li>
        <li>启用和禁用 Fluentd 集群附加组件的自动更新</li></ul>
      Ingress：<ul>
        <li>列出集群中的所有 ALB 私钥或查看这些 ALB 私钥的详细信息</li>
        <li>将证书从 {{site.data.keyword.cloudcerts_long_notm}} 实例部署到 ALB</li>
        <li>更新集群中的 ALB 私钥或从集群中除去 ALB 私钥</li></ul>
      <p class="note">要创建资源（如机器、VLAN 和子网），管理员用户需要**超级用户**基础架构角色。</p>
    </td>
    <td><code>cluster-admin</code> 集群角色由 <code>ibm-admin</code> 集群角色绑定进行应用，提供以下许可权：
      <ul><li>对每个名称空间中资源的读/写访问权</li>
      <li>在名称空间内创建 RBAC 角色</li>
      <li>访问 Kubernetes 仪表板</li>
      <li>创建使应用程序公共可用的 Ingress 资源</li></ul>
    </td>
  </tr>
  </tbody>
</table>



## Cloud Foundry 角色
{: #cloud-foundry}

Cloud Foundry 角色会授予对帐户内组织和空间的访问权。要在 {{site.data.keyword.Bluemix_notm}} 中查看基于 Cloud Foundry 的服务的列表，请运行 `ibmcloud service list`。要了解更多信息，请参阅 {{site.data.keyword.Bluemix_notm}} IAM 文档中的所有可用[组织和空间角色](/docs/iam/cfaccess.html)或[管理 Cloud Foundry 访问权](/docs/iam/mngcf.html)的步骤。
{: shortdesc}

下表显示了集群操作许可权所需的 Cloud Foundry 角色。

<table summary="该表显示了 Cloud Foundry 的用户许可权。每行从左到右阅读，其中第一列是 Cloud Foundry 角色，第二列是集群许可权。">
  <caption>集群管理许可权（按 Cloud Foundry 角色）</caption>
  <thead>
    <th>Cloud Foundry 角色</th>
    <th>集群管理许可权</th>
  </thead>
  <tbody>
  <tr>
    <td>空间角色：管理员</td>
    <td>管理用户对 {{site.data.keyword.Bluemix_notm}} 空间的访问权</td>
  </tr>
  <tr>
    <td>空间角色：开发者</td>
    <td>
      <ul><li>创建 {{site.data.keyword.Bluemix_notm}} 服务实例</li>
      <li>将 {{site.data.keyword.Bluemix_notm}} 服务实例绑定到集群</li>
      <li>通过集群日志转发配置在空间级别查看日志</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## 基础架构角色
{: #infra}

具有**超级用户**基础架构访问角色的用户[为区域和资源组设置 API 密钥](cs_users.html#api_key)时，帐户中其他用户的基础架构许可权由 {{site.data.keyword.Bluemix_notm}} IAM 平台角色进行设置。您无需编辑其他用户的 IBM Cloud Infrastructure (SoftLayer) 许可权。仅当无法将**超级用户**分配给设置 API 密钥的用户时，才可以使用下表来定制用户的 IBM Cloud Infrastructure (SoftLayer) 许可权。有关更多信息，请参阅[定制基础架构许可权](cs_users.html#infra_access)。
{: shortdesc}

下表显示了完成常见任务组所需的基础架构许可权。

<table summary="常见 {{site.data.keyword.containerlong_notm}} 场景的基础架构许可权。">
     <caption>{{site.data.keyword.containerlong_notm}} 通常必需的基础架构许可权</caption>
 <thead>
  <th>{{site.data.keyword.containerlong_notm}} 中的常见任务</th>
  <th>必需的基础架构许可权（按选项卡）</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>最低许可权</strong>：<ul><li>创建集群。</li></ul></td>
     <td><strong>设备</strong>：<ul><li>查看虚拟服务器详细信息</li><li>重新引导服务器并查看 IPMI 系统信息</li><li>发出操作系统重装并启动急救内核</li></ul><strong>帐户</strong>：<ul><li>添加服务器</li></ul></td>
   </tr>
   <tr>
     <td><strong>集群管理</strong>：<ul><li>创建、更新和删除集群。</li><li>添加、重新装入和重新引导工作程序节点。</li><li>查看 VLAN。</li><li>创建子网。</li><li>部署 pod 和 LoadBalancer 服务。</li></ul></td>
     <td><strong>支持</strong>：<ul><li>查看凭单</li><li>添加凭单</li><li>编辑凭单</li></ul>
     <strong>设备</strong>：<ul><li>查看硬件详细信息</li><li>查看虚拟服务器详细信息</li><li>重新引导服务器并查看 IPMI 系统信息</li><li>发出操作系统重装并启动急救内核</li></ul>
     <strong>网络</strong>：<ul><li>使用公用网络端口添加计算</li></ul>
     <strong>帐户</strong>：<ul><li>取消服务器</li><li>添加服务器</li></ul></td>
   </tr>
   <tr>
     <td><strong>存储器</strong>：<ul><li>创建持久性卷申领以供应持久卷。</li><li>创建和管理存储器基础架构资源。</li></ul></td>
     <td><strong>服务</strong>：<ul><li>管理存储器</li></ul><strong>帐户</strong>：<ul><li>添加存储器</li></ul></td>
   </tr>
   <tr>
     <td><strong>专用联网</strong>：<ul><li>管理用于集群内联网的专用 VLAN。</li><li>设置与专用网络的 VPN 连接。</li></ul></td>
     <td><strong>网络</strong>：<ul><li>管理网络子网路径</li></ul></td>
   </tr>
   <tr>
     <td><strong>公用网络</strong>：<ul><li>设置公共负载均衡器或 Ingress 联网以公开应用程序。</li></ul></td>
     <td><strong>设备</strong>：<ul><li>编辑主机名/域</li><li>管理端口控制</li></ul>
     <strong>网络</strong>：<ul><li>使用公用网络端口添加计算</li><li>管理网络子网路径</li><li>添加 IP 地址</li></ul>
     <strong>服务</strong>：<ul><li>管理 DNS、逆向 DNS 和 WHOIS</li><li>查看证书 (SSL)</li><li>管理证书 (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
