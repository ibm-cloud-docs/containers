---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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

IBM 会自动将补丁级别的更新应用于主节点，但您必须[更新工作程序节点](cs_cluster_update.html#worker_node)。每月会检查可用更新。更新可用时，您在查看有关工作程序节点的信息时（例如，使用 `bx cs workers <cluster>` 或 `bx cs worker-get <cluster> <worker>` 命令），会收到相应通知。

有关迁移操作的摘要，请参阅 [Kubernetes 版本](cs_versions.html)。
{: tip}

有关自上一个版本以来的更改的信息，请参阅以下更改日志。
-  V1.8 [更改日志](#18_changelog)。
-  V1.7 [更改日志](#17_changelog)。


## V1.8 更改日志
{: #18_changelog}

查看以下更改。

### 1.8.11_1509 的更改日志
{: #1811_1509}

<table summary="自 V1.8.8_1507 以来的更改">
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
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11)。</td>
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

## V1.7 更改日志
{: #17_changelog}

查看以下更改。

### 1.7.16_1511 的更改日志
{: #1716_1511}

<table summary="自 V1.7.4_1509 以来的更改">
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
<td>请参阅 [Kubernetes 发行说明 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16)。</td>
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

