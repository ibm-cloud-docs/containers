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


# CLI 更改日志
{: #cs_cli_changelog}

在终端中，在 `ibmcloud` CLI 和插件更新可用时，会通知您。请确保保持 CLI 为最新，从而可使用所有可用命令和标志。
{:shortdesc}

要安装 CLI 插件，请参阅[安装 CLI](cs_cli_install.html#cs_cli_install_steps)。

请参阅下表以获取每个 CLI 插件版本的更改摘要。

<table summary="{{site.data.keyword.containerlong_notm}} CLI 插件的版本更改概述">
<caption>{{site.data.keyword.containerlong_notm}} CLI 插件的更改日志</caption>
<thead>
<tr>
<th>版本</th>
<th>发布日期</th>
<th>更改</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.654</td>
<td>2018 年 12 月 5 日</td>
<td>更新了文档和翻译。</td>
</tr>
<tr>
<td>0.1.638</td>
<td>2018 年 11 月 15 日</td>
<td>
<ul><li>添加了 [<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh) 命令。</li>
<li>向 <code>ibmcloud ks cluster-get</code> 和 <code>ibmcloud ks clusters</code> 的输出添加了资源组名称。</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>2018 年 11 月 6 日</td>
<td>添加了 [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable)、[<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable)、[<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get)、[<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback) 和 [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) 命令，用于管理 Ingress ALB 集群附加组件的自动更新。
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>2018 年 10 月 30 日</td>
<td><ul>
<li>添加了 [<code>ibmcloud ks credential-get</code> 命令](cs_cli_reference.html#cs_credential_get)。</li>
<li>添加了对 <code>storage</code> 日志源用于所有集群日志记录命令的支持。有关更多信息，请参阅<a href="cs_health.html#logging">了解集群和应用程序日志转发</a>。</li>
<li>向 [<code>ibmcloud ks cluster-config</code> 命令](cs_cli_reference.html#cs_cluster_config)添加了 `--network` 标志，用于下载 Calico 配置文件以运行所有 Calico 命令。</li>
<li>小幅错误修订和重构</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>2018 年 10 月 10 日</td>
<td><ul><li>向 <code>ibmcloud ks cluster-get</code> 的输出添加了资源组标识。</li>
<li>[启用 {{site.data.keyword.keymanagementserviceshort}}](cs_encrypt.html#keyprotect) 作为集群中的密钥管理服务 (KMS) 提供程序时，在 <code>ibmcloud ks cluster-get</code> 的输出中添加了“KMS 已启用”字段。</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2018 年 10 月 2 日</td>
<td>添加了对[资源组](cs_clusters.html#prepare_account_level)的支持。</td>
</tr>
<tr>
<td>0.1.590</td>
<td>2018 年 10 月 1 日</td>
<td><ul>
<li>添加了 [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) 和 [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) 命令，用于收集集群中的 API 服务器日志。</li>
<li>添加了 [<code>ibmcloud ks key-protect-enable</code> 命令](cs_cli_reference.html#cs_key_protect)，用于启用 {{site.data.keyword.keymanagementserviceshort}} 作为集群中的密钥管理服务 (KMS) 提供程序。</li>
<li>向 [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) 和 [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) 命令添加了 <code>--skip-master-health</code> 标志，用于跳过启动重新引导或重新装入之前的主节点运行状况检查。</li>
<li>将 <code>ibmcloud ks cluster-get</code> 输出中的 <code>Owner Email</code> 重命名为 <code>Owner</code>。</li></ul></td>
</tr>
</tbody>
</table>
