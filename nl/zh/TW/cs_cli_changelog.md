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


# CLI 變更日誌
{: #cs_cli_changelog}

在終端機中，有 `ibmcloud` CLI 及外掛程式的更新可用時，就會通知您。請務必保持最新的 CLI，讓您可以使用所有可用的指令及旗標。
{:shortdesc}

若要安裝 CLI 外掛程式，請參閱[安裝 CLI](cs_cli_install.html#cs_cli_install_steps)。

如需每一個 CLI 外掛程式版本的變更摘要，請參閱下表。

<table summary="{{site.data.keyword.containerlong_notm}} CLI 外掛程式的版本變更概觀">
<caption>{{site.data.keyword.containerlong_notm}} CLI 外掛程式的變更日誌</caption>
<thead>
<tr>
<th>版本</th>
<th>發行日期</th>
<th>變更</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.654</td>
<td>2018 年 12 月 5 日</td>
<td>更新文件和翻譯。</td>
</tr>
<tr>
<td>0.1.638</td>
<td>2018 年 11 月 15 日</td>
<td>
<ul><li>新增 [<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh) 指令。</li>
<li>將資源群組名稱新增至 <code>ibmcloud ks cluster-get</code> 和 <code>ibmcloud ks clusters</code> 的輸出。</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>2018 年 11 月 6 日</td>
<td>新增 [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable)、[<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable)、[<code>ibmcloudks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get)、[<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback) 和 [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) 指令，用於管理 Ingress ALB 叢集附加程式的自動更新。
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>2018 年 10 月 30 日</td>
<td><ul>
<li>新增 [<code>ibmcloud ks credential-get</code> 指令](cs_cli_reference.html#cs_credential_get)。</li>
<li>將 <code>storage</code> 日誌來源的支援新增至所有叢集記載指令。如需相關資訊，請參閱<a href="cs_health.html#logging">瞭解叢集和應用程式日誌轉遞</a>。</li>
<li>將 `--network` 旗標新增至 [<code>ibmcloud k cluster-config</code> 指令](cs_cli_reference.html#cs_cluster_config)，其會下載 Calico 配置檔以執行所有 Calico 指令。</li>
<li>次要錯誤修正程式及重構</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>2018 年 10 月 10 日</td>
<td><ul><li>將資源群組 ID 新增至 <code>ibmcloud s cluster-get</code> 的輸出。</li>
<li>[已啟用 {{site.data.keyword.keymanagementserviceshort}}](cs_encrypt.html#keyprotect) 作為叢集中的金鑰管理服務 (KMS) 提供者時，會在 <code>ibmcloud s cluster-get</code> 的輸出中新增已啟用 KMS 的欄位。</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2018 年 10 月 2 日</td>
<td>新增[資源群組的支援](cs_clusters.html#prepare_account_level)。</td>
</tr>
<tr>
<td>0.1.590</td>
<td>2018 年 10 月 1 日</td>
<td><ul>
<li>新增 [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) 及 [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) 指令，用於收集叢集中的 API 伺服器日誌。</li>
<li>新增 [<code>ibmcloud ks key-protect-enable</code> 指令](cs_cli_reference.html#cs_key_protect)，以啟用 {{site.data.keyword.keymanagementserviceshort}} 作為叢集中的金鑰管理服務 (KMS) 提供者。</li>
<li>在起始重新開機或重新載入之前，將 <code>--skip-master-health</code> 旗標新增至 [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) 及 [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) 指令，以跳過主節點性能檢查。</li>
<li>在 <code>ibmcloud ks cluster-get</code> 的輸出中，將 <code>Owner Email</code> 重新命名為 <code>Owner</code>。</li></ul></td>
</tr>
</tbody>
</table>
