---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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


# 集群附加组件更改日志

{{site.data.keyword.containerlong}} 集群随附由 IBM 自动更新的附加组件。您还可以禁用某些附加组件的自动更新，而单独从主节点和工作程序节点手动更新这些附加组件。请参阅以下各部分中的表以获取每个版本的更改摘要。
{: shortdesc}

## Ingress ALB 附加组件更改日志
{: #alb_changelog}

在 {{site.data.keyword.containerlong_notm}} 集群中查看 Ingress 应用程序负载均衡器 (ALB) 附加组件的构建版本更改。
{:shortdesc}

更新 Ingress ALB 附加组件时，所有 ALB pod 中的 `nginx-ingress` 和 `ingress-auth` 容器都会更新为最新的构建版本。缺省情况下，会启用附加组件的自动更新，但您可以禁用自动更新，而手动更新附加组件。有关更多信息，请参阅[更新 Ingress 应用程序负载均衡器](cs_cluster_update.html#alb)。

请参阅下表以了解 Ingress ALB 附加组件的每个构建的更改摘要。

<table summary="Ingress 应用程序负载均衡器附加组件的构建更改概述">
<caption>Ingress 应用程序负载均衡器附加组件的更改日志</caption>
<thead>
<tr>
<th>`nginx-ingress` / `ingress-auth` 构建</th>
<th>发布日期</th>
<th>非中断性更改</th>
<th>中断性更改</th>
</tr>
</thead>
<tbody>
<tr>
<td>393 / 282</td>
<td>2018 年 11 月 29 日</td>
<td>提高了 {{site.data.keyword.appid_full}} 的性能。</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018 年 11 月 14 日</td>
<td>改进了 {{site.data.keyword.appid_full}} 的登录和注销功能。</td>
<td>将 `*.containers.mybluemix.net` 的自签名证书替换为集群自动生成并由集群使用的 LetsEncrypt 签名证书。除去了 `*.containers.mybluemix.net` 自签名证书。</td>
</tr>
<tr>
<td>350 / 192</td>
<td>2018 年 11 月 5 日</td>
<td>添加了对启用和禁用 Ingress ALB 附加组件自动更新的支持。</td>
<td>-</td>
</tr>
</tbody>
</table>
