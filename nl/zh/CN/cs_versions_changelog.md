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



# 版本更改日志
{: #changelog}

查看可用于 {{site.data.keyword.containerlong}} Kubernetes 集群的主要更新、次要更新和补丁更新的版本更改信息。更改包括对 Kubernetes 和 {{site.data.keyword.Bluemix_notm}} Provider 组件的更新。
{:shortdesc}

IBM 会自动将补丁级别的更新应用于主节点，但您必须[更新工作程序节点](cs_cluster_update.html#worker_node)补丁。对于主节点和工作程序节点，必须应用[主要和次要](cs_versions.html#update_types)更新。每月会检查可用更新。更新可用时，您在 GUI 或 CLI 中查看有关主节点和工作程序节点的信息时（例如，使用 `ibmcloud ks clusters`、`cluster-get`、`workers` 或 `worker-get` 命令），会收到相关通知。

有关迁移操作的摘要，请参阅 [Kubernetes 版本](cs_versions.html)。
{: tip}

有关自上一个版本以来的更改的信息，请参阅以下更改日志。
-  V1.10 [更改日志](#110_changelog)。
-  V1.9 [更改日志](#19_changelog)。
-  V1.8 [更改日志](#18_changelog)。
-  对不推荐使用或不受支持的版本的更改日志[归档](#changelog_archive)。

## V1.10 更改日志
{: #110_changelog}

查看以下更改。

### 2018 年 7 月 27 日发布的 1.10.5_1517 的更改日志
{: #1105_1517}

<table summary="自 V1.10.3_1514 以来进行的更改">
<caption>自 V1.10.3_1514 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>V3.1.1</td>
<td>V3.1.3</td>
<td>请参阅 Calico [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/releases/#v313)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.10.3-85</td>
<td>V1.10.5-118</td>
<td>更新为支持 Kubernetes 1.10.5 发行版。此外，LoadBalancer 服务 `create failure` 事件现在包含任何可移植子网错误。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>320</td>
<td>334</td>
<td>将创建持久性卷的超时从 15 分钟增加到 30 分钟。将缺省计费类型更改为 `hourly`。向预定义存储类添加了安装选项。在 IBM Cloud Infrastructure (SoftLayer) 帐户的 NFS 文件存储器实例中，已将**注释**字段更改为 JSON 格式，并添加了 PV 部署到的 Kubernetes 名称空间。为了支持多专区集群，向持久性卷添加了专区和区域标签。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.10.3</td>
<td>V1.10.5</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5)。</td>
</tr>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载对工作程序节点网络设置进行了小幅改进。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署现在由 Kubernetes `addon-manager` 进行管理。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 3 日发布的工作程序节点 FP1.10.3_1514 的更改日志
{: #1103_1514}

<table summary="自 V1.10.3_1513 以来进行的更改">
<caption>自 V1.10.3_1513 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载优化了 `sysctl`。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 21 日发布的工作程序节点 FP1.10.3_1513 的更改日志
{: #1103_1513}

<table summary="自 V1.10.3_1512 以来进行的更改">
<caption>自 V1.10.3_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>对于未加密的机器类型，重新装入或更新工作程序节点时，将通过获取全新文件系统来清除辅助磁盘。</td>
</tr>
</tbody>
</table>

### 2018 年 6 月 12 日发布的 1.10.3_1512 的更改日志
{: #1103_1512}

<table summary="自 V1.10.1_1510 以来进行的更改">
<caption>自 V1.10.1_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.10.1</td>
<td>V1.10.3</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 `--enable-admission-plugins` 选项添加了 `PodSecurityPolicy`，并将集群配置为支持 pod 安全策略。有关更多信息，请参阅[配置 pod 安全策略](cs_psp.html)。</td>
</tr>
<tr>
<td>Kubelet 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>启用了 `--authentication-token-webhook` 选项以支持 API 不记名令牌和服务帐户令牌认证到 `kubelet` HTTPS 端点。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.10.1-52</td>
<td>V1.10.3-85</td>
<td>更新为支持 Kubernetes 1.10.3 发行版。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>向在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署添加了 `livenessProbe`。</td>
</tr>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>



### 2018 年 5 月 18 日发布的工作程序节点 FP1.10.1_1510 的更改日志
{: #1101_1510}

<table summary="自 V1.10.1_1509 以来进行的更改">
<caption>自 1.10.1_1509 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 16 日发布的工作程序节点 FP1.10.1_1509 的更改日志
{: #1101_1509}

<table summary="自 V1.10.1_1508 以来进行的更改">
<caption>自 V1.10.1_1508 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 1 日发布的 1.10.1_1508 的更改日志
{: #1101_1508}

<table summary="自 V1.9.7_1510 以来进行的更改">
<caption>自 V1.9.7_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>V2.6.5</td>
<td>V3.1.1</td>
<td>请参阅 Calico [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://docs.projectcalico.org/v3.1/releases/#v311)。</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>V1.5.0</td>
<td>V1.5.2</td>
<td>请参阅 Kubernetes Heapster [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2)。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.9.7</td>
<td>V1.10.1</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 <code>--enable-admission-plugins</code> 选项添加了 <code>StorageObjectInUseProtection</code>。</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>请参阅 Kubernetes DNS [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/dns/releases/tag/1.14.10)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.7-102</td>
<td>V1.10.1-52</td>
<td>更新为支持 Kubernetes 1.10 发行版。</td>
</tr>
<tr>
<td>GPU 支持</td>
<td>不适用</td>
<td>不适用</td>
<td>现在，可支持[图形处理单元 (GPU) 容器工作负载](cs_app.html#gpu_app)进行安排和执行。有关可用 GPU 机器类型的列表，请参阅[工作程序节点的硬件](cs_clusters.html#shared_dedicated_node)。有关更多信息，请参阅 Kubernetes 文档以[安排 GPU ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/)。</td>
</tr>
</tbody>
</table>

## V1.9 更改日志
{: #19_changelog}

查看以下更改。

### 2018 年 7 月 27 日发布的 1.9.9_1520 的更改日志
{: #199_1520}

<table summary="自 V1.9.8_1517 以来进行的更改">
<caption>自 V1.9.8_1517 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.8-141</td>
<td>V1.9.9-167</td>
<td>更新为支持 Kubernetes 1.9.9 发行版。此外，LoadBalancer 服务 `create failure` 事件现在包含任何可移植子网错误。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>320</td>
<td>334</td>
<td>将创建持久性卷的超时从 15 分钟增加到 30 分钟。将缺省计费类型更改为 `hourly`。向预定义存储类添加了安装选项。在 IBM Cloud Infrastructure (SoftLayer) 帐户的 NFS 文件存储器实例中，已将**注释**字段更改为 JSON 格式，并添加了 PV 部署到的 Kubernetes 名称空间。为了支持多专区集群，向持久性卷添加了专区和区域标签。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.9.8</td>
<td>V1.9.9</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9)。</td>
</tr>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载对工作程序节点网络设置进行了小幅改进。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署现在由 Kubernetes `addon-manager` 进行管理。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 3 日发布的工作程序节点 FP1.9.8_1517 的更改日志
{: #198_1517}

<table summary="自 V1.9.8_1516 以来进行的更改">
<caption>自 V1.9.8_1516 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载优化了 `sysctl`。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 21 日发布的工作程序节点 FP1.9.8_1516 的更改日志
{: #198_1516}

<table summary="自 V1.9.8_1515 以来进行的更改">
<caption>自 V1.9.8_1515 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>对于未加密的机器类型，重新装入或更新工作程序节点时，将通过获取全新文件系统来清除辅助磁盘。</td>
</tr>
</tbody>
</table>

### 2018 年 6 月 19 日发布的 1.9.8_1515 的更改日志
{: #198_1515}

<table summary="自 V1.9.7_1513 以来进行的更改">
<caption>自 V1.9.7_1513 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.9.7</td>
<td>V1.9.8</td>
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 --admission-control 选项添加了 PodSecurityPolicy，并将集群配置为支持 pod 安全策略。有关更多信息，请参阅[配置 pod 安全策略](cs_psp.html)。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>V1.9.7-102</td>
<td>V1.9.8-141</td>
<td>更新为支持 Kubernetes 1.9.8 发行版。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>向在 <code>kube-system</code> 名称空间中运行的 OpenVPN 客户机 <code>vpn</code> 部署添加了 <code>livenessProbe</code>。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 11 日发布的工作程序节点 FP1.9.7_1513 的更改日志
{: #197_1513}

<table summary="自 V1.9.7_1512 以来进行的更改">
<caption>自 V1.9.7_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 18 日发布的工作程序节点 FP1.9.7_1512 的更改日志
{: #197_1512}

<table summary="自 V1.9.7_1511 以来进行的更改">
<caption>自 V1.9.7_1511 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 16 日发布的工作程序节点 FP1.9.7_1511 的更改日志
{: #197_1511}

<table summary="自 V1.9.7_1510 以来进行的更改">
<caption>自 V1.9.7_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>

### 2018 年 4 月 30 日发布的 1.9.7_1510 的更改日志
{: #197_1510}

<table summary="自 V1.9.3_1506 以来进行的更改">
<caption>自 V1.9.3_1506 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.9.3</td>
<td>V1.9.7</td>
<td><p>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7)。此发行版解决了 [CVE-2017-1002101 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 和 [CVE-2017-1002102 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>注</strong>：现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，应用程序可以将数据写入系统可能会自动还原的这些卷。如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</p></td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 `--runtime-config` 选项添加了 `admissionregistration.k8s.io/v1alpha1=true`。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.9.3-71</td>
<td>V1.9.7-102</td>
<td>`NodePort` 和 `LoadBalancer` 服务现在通过将 `service.spec.externalTrafficPolicy` 设置为 `Local` 来支持[保留客户机源 IP](cs_loadbalancer.html#node_affinity_tolerations)。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>修正旧集群的[边缘节点](cs_edge.html#edge)容忍度设置。</td>
</tr>
</tbody>
</table>

## V1.8 更改日志
{: #18_changelog}

查看以下更改。

### 2018 年 7 月 27 日发布的 1.8.15_1518 的更改日志
{: #1815_1518}

<table summary="自 V1.8.13_1516 以来进行的更改">
<caption>自 V1.8.13_1516 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.8.13-176</td>
<td>V1.8.15-204</td>
<td>更新为支持 Kubernetes 1.8.15 发行版。此外，LoadBalancer 服务 `create failure` 事件现在包含任何可移植子网错误。</td>
</tr>
<tr>
<td>IBM File Storage 插件</td>
<td>320</td>
<td>334</td>
<td>将创建持久性卷的超时从 15 分钟增加到 30 分钟。将缺省计费类型更改为 `hourly`。向预定义存储类添加了安装选项。在 IBM Cloud Infrastructure (SoftLayer) 帐户的 NFS 文件存储器实例中，已将**注释**字段更改为 JSON 格式，并添加了 PV 部署到的 Kubernetes 名称空间。为了支持多专区集群，向持久性卷添加了专区和区域标签。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>V1.8.13</td>
<td>V1.8.15</td>
<td>请参阅 Kubernetes [发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15)。</td>
</tr>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载对工作程序节点网络设置进行了小幅改进。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>在 `kube-system` 名称空间中运行的 OpenVPN 客户机 `vpn` 部署现在由 Kubernetes `addon-manager` 进行管理。</td>
</tr>
</tbody>
</table>

### 2018 年 7 月 3 日发布的工作程序节点 FP1.8.13_1516 的更改日志
{: #1813_1516}

<table summary="自 V1.8.13_1515 以来进行的更改">
<caption>自 V1.8.13_1515 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核</td>
<td>不适用</td>
<td>不适用</td>
<td>针对高性能联网工作负载优化了 `sysctl`。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 21 日发布的工作程序节点 FP1.8.13_1515 的更改日志
{: #1813_1515}

<table summary="自 V1.8.13_1514 以来进行的更改">
<caption>自 V1.8.13_1514 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>不适用</td>
<td>不适用</td>
<td>对于未加密的机器类型，重新装入或更新工作程序节点时，将通过获取全新文件系统来清除辅助磁盘。</td>
</tr>
</tbody>
</table>

### 2018 年 6 月 19 日发布的 1.8.13_1514 的更改日志
{: #1813_1514}

<table summary="自 V1.8.11_1512 以来进行的更改">
<caption>自 V1.8.11_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.8.11</td>
<td>V1.8.13</td>
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>不适用</td>
<td>不适用</td>
<td>向集群的 Kubernetes API 服务器的 --admission-control 选项添加了 PodSecurityPolicy，并将集群配置为支持 pod 安全策略。有关更多信息，请参阅[配置 pod 安全策略](cs_psp.html)。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>V1.8.11-126</td>
<td>V1.8.13-176</td>
<td>更新为支持 Kubernetes 1.8.13 发行版。</td>
</tr>
<tr>
<td>OpenVPN 客户机</td>
<td>不适用</td>
<td>不适用</td>
<td>向在 <code>kube-system</code> 名称空间中运行的 OpenVPN 客户机 <code>vpn</code> 部署添加了 <code>livenessProbe</code>。</td>
</tr>
</tbody>
</table>


### 2018 年 6 月 11 日发布的工作程序节点 FP1.8.11_1512 的更改日志
{: #1811_1512}

<table summary="自 V1.8.11_1511 以来进行的更改">
<caption>自 V1.8.11_1511 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>


### 2018 年 5 月 18 日发布的工作程序节点 FP1.8.11_1511 的更改日志
{: #1811_1511}

<table summary="自 V1.8.11_1510 以来进行的更改">
<caption>自 V1.8.11_1510 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

### 2018 年 5 月 16 日发布的工作程序节点 FP1.8.11_1510 的更改日志
{: #1811_1510}

<table summary="自 V1.8.11_1509 以来进行的更改">
<caption>自 V1.8.11_1509 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>


### 2018 年 4 月 19 日发布的 1.8.11_1509 的更改日志
{: #1811_1509}

<table summary="自 V1.8.8_1507 以来进行的更改">
<caption>自 V1.8.8_1507 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.8.8</td>
<td>V1.8.11</td>
<td><p>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11)。此发行版解决了 [CVE-2017-1002101 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 和 [CVE-2017-1002102 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>注</strong>：现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，应用程序可以将数据写入系统可能会自动还原的这些卷。如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</p></td>
</tr>
<tr>
<td>暂停容器映像</td>
<td>3.0</td>
<td>3.1</td>
<td>除去继承的孤立 zombie 进程。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.8.8-86</td>
<td>V1.8.11-126</td>
<td>`NodePort` 和 `LoadBalancer` 服务现在通过将 `service.spec.externalTrafficPolicy` 设置为 `Local` 来支持[保留客户机源 IP](cs_loadbalancer.html#node_affinity_tolerations)。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>修正旧集群的[边缘节点](cs_edge.html#edge)容忍度设置。</td>
</tr>
</tbody>
</table>

## 归档
{: #changelog_archive}

### V1.7 更改日志（不受支持）
{: #17_changelog}

查看以下更改。

#### 2018 年 6 月 11 日发布的工作程序节点 FP1.7.16_1514 的更改日志
{: #1716_1514}

<table summary="自 V1.7.16_1513 以来进行的更改">
<caption>自 V1.7.16_1513 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>内核更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新工作程序映像具有 [CVE-2018-3639 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的内核更新。</td>
</tr>
</tbody>
</table>

#### 2018 年 5 月 18 日发布的工作程序节点 FP1.7.16_1513 的更改日志
{: #1716_1513}

<table summary="自 V1.7.16_1512 以来进行的更改">
<caption>自 V1.7.16_1512 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>修订解决了使用块存储器插件时发生的错误。</td>
</tr>
</tbody>
</table>

#### 2018 年 5 月 16 日发布的工作程序节点 FP1.7.16_1512 的更改日志
{: #1716_1512}

<table summary="自 V1.7.16_1511 以来进行的更改">
<caption>自 V1.7.16_1511 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>不适用</td>
<td>不适用</td>
<td>存储在 `kubelet` 根目录中的数据现在保存在工作程序节点机器中更大的辅助磁盘上。</td>
</tr>
</tbody>
</table>

#### 2018 年 4 月 19 日发布的 1.7.16_1511 的更改日志
{: #1716_1511}

<table summary="自 V1.7.4_1509 以来进行的更改">
<caption>自 V1.7.4_1509 以来的更改</caption>
<thead>
<tr>
<th>组件</th>
<th>上一个版本</th>
<th>当前版本</th>
<th>描述</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>V1.7.4</td>
<td>V1.7.16</td>
<td><p>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16)。此发行版解决了 [CVE-2017-1002101 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 和 [CVE-2017-1002102 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>注</strong>：现在，`secret`、`configMap`、`downwardAPI` 和投影卷均安装为只读。先前，应用程序可以将数据写入系统可能会自动还原的这些卷。如果应用程序依赖于先前的不安全行为，请相应地对其进行修改。</p></td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>V1.7.4-133</td>
<td>V1.7.16-17</td>
<td>`NodePort` 和 `LoadBalancer` 服务现在通过将 `service.spec.externalTrafficPolicy` 设置为 `Local` 来支持[保留客户机源 IP](cs_loadbalancer.html#node_affinity_tolerations)。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>修正旧集群的[边缘节点](cs_edge.html#edge)容忍度设置。</td>
</tr>
</tbody>
</table>
