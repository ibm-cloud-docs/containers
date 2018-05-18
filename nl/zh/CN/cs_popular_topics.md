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


# {{site.data.keyword.containershort_notm}} 的热门主题
{: #cs_popular_topics}

查看容器开发者有兴趣了解 {{site.data.keyword.containerlong}} 中的哪些内容。
{:shortdesc}

## 2018 年 3 月的热门主题
{: #mar18}

<table summary="此表显示热门主题。各行都应从左到右阅读，其中第一列是日期，第二列是功能标题，第三列是描述。">
<caption>2018 年 2 月容器和 Kubernetes 集群的热门主题</caption>
<thead>
<th>日期</th>
<th>标题</th>
<th>描述</th>
</thead>
<tbody>
<tr>
<td> 3 月 16 日</td>
<td>[供应具有可信计算的裸机集群](cs_clusters.html#shared_dedicated_node)</td>
<td>创建运行 [Kubernetes V1.9](cs_versions.html#cs_v19) 或更高版本的裸机集群，并启用“可信计算”来验证工作程序节点是否被篡改。</td>
</tr>
<tr>
<td>3 月 14 日</td>
<td>[使用 {{site.data.keyword.appid_full}} 安全登录](cs_integrations.html#appid)</td>
<td>通过要求用户登录，增强了在 {{site.data.keyword.containershort_notm}} 中运行的应用程序的功能。</td>
</tr>
<tr>
<td>3 月 13 日</td>
<td>[在圣保罗提供了位置](cs_regions.html)</td>
<td>欢迎将巴西圣保罗作为美国南部区域的一个新位置。如果您有防火墙，请确保[打开必需的防火墙端口](cs_firewall.html#firewall)以用于此位置以及您集群所在区域内的其他位置。</td>
</tr>
<tr>
<td>3 月 12 日</td>
<td>[刚刚使用试用帐户加入 {{site.data.keyword.Bluemix_notm}}？请试用免费 Kubernetes 集群！](container_index.html#clusters)</td>
<td>通过试用 [{{site.data.keyword.Bluemix_notm}} 帐户](https://console.bluemix.net/registration/)，您可以部署 1 个免费集群并使用 21 天，以测试 Kubernetes 功能。</td>
</tr>
</tbody></table>

## 2018 年 2 月的热门主题
{: #feb18}

<table summary="此表显示热门主题。各行都应从左到右阅读，其中第一列是日期，第二列是功能标题，第三列是描述。">
<caption>2018 年 2 月容器和 Kubernetes 集群的热门主题</caption>
<thead>
<th>日期</th>
<th>标题</th>
<th>描述</th>
</thead>
<tbody>
<tr>
<td>2 月 27 日</td>
<td>工作程序节点的硬件虚拟机 (HVM) 映像</td>
<td>通过 HVM 映像来提高工作负载的 I/O 性能。使用 `bx cs worker-reload` [命令](cs_cli_reference.html#cs_worker_reload)或 `bx cs worker-update` [命令](cs_cli_reference.html#cs_worker_update)在每个现有工作程序节点上进行激活。</td>
</tr>
<tr>
<td>2 月 26 日</td>
<td>[KubeDNS 自动扩展](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>现在，KubeDNS 可随着集群的增长而扩展。可以使用以下命令来调整扩展配额：`kubectl -n kube-system edit cm kube-dns-autoscaler`。</td>
</tr>
<tr>
<td>2 月 23 日</td>
<td>在 Web UI 中查看[日志记录](cs_health.html#view_logs)和[度量值](cs_health.html#view_metrics)</td>
<td>通过改进的 Web UI，轻松查看集群及其组件的日志和度量数据。有关访问权的信息，请参阅“集群详细信息”页面。</td>
</tr>
<tr>
<td>2 月 20 日</td>
<td>加密映像和[签名的可信内容](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>在 {{site.data.keyword.registryshort_notm}} 中，可以对映像进行签名和加密，以确保这些映像在注册表名称空间中存储时的完整性。仅使用可信内容来构建容器。</td>
</tr>
<tr>
<td>2 月 19 日</td>
<td>[设置 strongSwan IPSec VPN](cs_vpn.html#vpn-setup)</td>
<td>快速部署 strongSwan IPSec VPN Helm 图表，无需 Vyatta 就能将 {{site.data.keyword.containershort_notm}} 集群安全地连接到内部部署数据中心。</td>
</tr>
<tr>
<td>2 月 14 日</td>
<td>[在首尔提供了位置](cs_regions.html)</td>
<td>将 Kubernetes 集群部署到亚太地区北部区域的首尔，刚好赶上奥运会。如果您有防火墙，请确保[打开必需的防火墙端口](cs_firewall.html#firewall)以用于此位置以及您集群所在区域内的其他位置。</td>
</tr>
<tr>
<td>2 月 8 日</td>
<td>[更新 Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>在更新 Kubernetes 1.9 之前，请查看要对集群进行的更改。</td>
</tr>
</tbody></table>

## 2018 年 1 月的热门主题
{: #jan18}

<table summary="此表显示热门主题。各行都应从左到右阅读，其中第一列是日期，第二列是功能标题，第三列是描述。">
<caption>2018 年 1 月容器和 Kubernetes 集群的热门主题</caption>
<thead>
<th>日期</th>
<th>标题</th>
<th>描述</th>
</thead>
<tbody>
<td>1 月 25 日</td>
<td>[提供了全局注册表](../services/Registry/registry_overview.html#registry_regions)</td>
<td>通过 {{site.data.keyword.registryshort_notm}}，可以使用全局 `registry.bluemix.net` 来拉取 IBM 提供的公共映像。</td>
</tr>
<tr>
<td>1 月 23 日</td>
<td>[在新加坡和加拿大蒙特利尔提供了位置](cs_regions.html)</td>
<td>新加坡和蒙特利尔是 {{site.data.keyword.containershort_notm}} 亚太地区北部和美国东部区域中可用的位置。如果您有防火墙，请确保[打开必需的防火墙端口](cs_firewall.html#firewall)以用于这些位置以及您集群所在区域内的其他位置。</td>
</tr>
<tr>
<td>1 月 8 日</td>
<td>[提供了增强的机器类型](cs_cli_reference.html#cs_machine_types)</td>
<td>系列 2 机器类型包括本地 SSD 存储和磁盘加密。[迁移工作负载](cs_cluster_update.html#machine_type)至这些机器类型，以提高性能和稳定性。</td>
</tr>
</tbody></table>

## 在 Slack 上与志趣相投的开发人员交谈
{: #slack}

您可以在 [{{site.data.keyword.containershort_notm}} Slack ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://ibm-container-service.slack.com) 中查看其他人正在讨论的内容并提出自己的问题。
{:shortdesc}

提示：如果未将 IBM 标识用于 {{site.data.keyword.Bluemix_notm}} 帐户，请针对此 Slack [请求邀请](https://bxcs-slack-invite.mybluemix.net/)。
