---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-16"

keywords: kubernetes, iks, nginx, ingress controller

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



# 集群附加组件更改日志

{{site.data.keyword.containerlong}} 集群随附由 IBM 自动更新的附加组件。您还可以禁用某些附加组件的自动更新，而单独从主节点和工作程序节点手动更新这些附加组件。请参阅以下各部分中的表以获取每个版本的更改摘要。
{: shortdesc}

## Ingress ALB 附加组件更改日志
{: #alb_changelog}

在 {{site.data.keyword.containerlong_notm}} 集群中查看 Ingress 应用程序负载均衡器 (ALB) 附加组件的构建版本更改。
{:shortdesc}

更新 Ingress ALB 附加组件时，所有 ALB pod 中的 `nginx-ingress` 和 `ingress-auth` 容器都会更新为最新的构建版本。缺省情况下，会启用附加组件的自动更新，但您可以禁用自动更新，而手动更新附加组件。有关更多信息，请参阅[更新 Ingress 应用程序负载均衡器](/docs/containers?topic=containers-update#alb)。

请参阅下表以了解 Ingress ALB 附加组件的每个构建的更改摘要。

<table summary="Ingress 应用程序负载均衡器附加组件的构建更改概述">
<caption>Ingress 应用程序负载均衡器附加组件的更改日志</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
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
<td>411 / 315</td>
<td>2019 年 4 月 15 日</td>
<td>更新了 {{site.data.keyword.appid_full}} cookie 到期时间的值，使其与访问令牌到期时间的值相匹配。</td>
<td>-</td>
</tr>
<tr>
<td>411 / 306</td>
<td>2019 年 3 月 22 日</td>
<td>将 Go 版本更新为 1.12.1。</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>2019 年 3 月 18 日</td>
<td><ul>
<li>修复了映像扫描的漏洞。</li>
<li>改进了 {{site.data.keyword.appid_full_notm}} 的日志记录功能。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>2019 年 3 月 5 日</td>
<td>-</td>
<td>修复了与注销功能、令牌到期和 `OAuth` 授权回调相关的授权集成中的错误。仅当使用 [`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth) 注释启用了 {{site.data.keyword.appid_full_notm}} 授权时，才会实现这些修订。要实现这些修订，将添加其他头，这会增加头的总大小。根据您自己的头大小以及响应的总大小，可能需要调整使用的任何[代理缓冲区注释](/docs/containers?topic=containers-ingress_annotation#proxy-buffer)。</td>
</tr>
<tr>
<td>406 / 301</td>
<td>2019 年 2 月 19 日</td>
<td><ul>
<li>将 Go 版本更新为 1.11.5。</li>
<li>修复了映像扫描的漏洞。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404 / 300</td>
<td>2019 年 1 月 31 日</td>
<td>将 Go 版本更新为 1.11.4。</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>2019 年 1 月 23 日</td>
<td><ul>
<li>将 NGINX 版本的 ALB 更新为 1.15.2。</li>
<li>现在，IBM 提供的 TLS 证书在到期前 37 天（而不是 7 天）会自动更新。</li>
<li>添加了 {{site.data.keyword.appid_full_notm}} 注销功能：如果 {{site.data.keyword.appid_full_notm}} 路径中存在 `/logout` 前缀，那么将除去 cookie 并将用户发送回登录页面。</li>
<li>向 {{site.data.keyword.appid_full_notm}} 请求添加了一个头，以用于内部跟踪。</li>
<li>更新了 {{site.data.keyword.appid_short_notm}} 位置伪指令，以便 `app-id` 注释可与 `proxy-buffers`、`proxy-buffer-size` 和 `proxy-busy-buffer-size` 注释一起使用。</li>
<li>修复了错误，使得参考日志不会标记为错误。</li>
</ul></td>
<td>缺省情况下已禁用 TLS 1.0 和 1.1。如果连接到应用程序的客户机支持 TLS 1.2，那么无需任何操作。如果仍然有需要 TLS 1.0 或 1.1 支持的旧客户机，那么必须通过执行[这些步骤](/docs/containers?topic=containers-ingress#ssl_protocols_ciphers)来启用所需的 TLS 版本。有关如何查看客户机用于访问应用程序的 TLS 版本的更多信息，请参阅此 [{{site.data.keyword.Bluemix_notm}} 博客帖子](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/)。</td>
</tr>
<tr>
<td>393 / 291</td>
<td>2019 年 1 月 9 日</td>
<td>添加对多个 {{site.data.keyword.appid_full_notm}} 实例的支持。</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>2018 年 11 月 29 日</td>
<td>提高了 {{site.data.keyword.appid_full_notm}} 的性能。</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018 年 11 月 14 日</td>
<td>改进了 {{site.data.keyword.appid_full_notm}} 的登录和注销功能。</td>
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
