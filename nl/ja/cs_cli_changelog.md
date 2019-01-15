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


# CLI の変更ログ
{: #cs_cli_changelog}

`ibmcloud` CLI およびプラグインの更新が使用可能になると、端末に通知が表示されます。 使用可能なすべてのコマンドおよびフラグを使用できるように、CLI を最新の状態に保つようにしてください。
{:shortdesc}

CLI プラグインをインストールするには、[CLI のインストール](cs_cli_install.html#cs_cli_install_steps)を参照してください。

CLI プラグインの各バージョンにおける変更の要約については、以下の表を参照してください。

<table summary="{{site.data.keyword.containerlong_notm}} CLI プラグインのバージョン変更の概要">
<caption>{{site.data.keyword.containerlong_notm}} CLI プラグインの変更ログ</caption>
<thead>
<tr>
<th>バージョン</th>
<th>リリース日付</th>
<th>変更内容</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.654</td>
<td>2018 年 12 月 5 日</td>
<td>資料および翻訳を更新。</td>
</tr>
<tr>
<td>0.1.638</td>
<td>2018 年 11 月 15 日</td>
<td>
<ul><li>[<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh) コマンドを追加します。</li>
<li><code>ibmcloud ks cluster-get</code> および <code>ibmcloud ks clusters</code> の出力にリソース・グループ名を追加。</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>2018 年 11 月 6 日</td>
<td>Ingress ALB クラスター・アドオンの自動更新を管理するための [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable)、[<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable)、[<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get)、[<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback)、および [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) コマンドを追加。</td>
</tr>
<tr>
<td>0.1.621</td>
<td>2018 年 10 月 30 日</td>
<td><ul>
<li>[<code>ibmcloud ks credential-get</code> コマンドを追加します](cs_cli_reference.html#cs_credential_get)。</li>
<li>すべてのクラスター・ロギング・コマンドに <code>storage</code> ログ・ソースのサポートを追加。詳しくは、<a href="cs_health.html#logging">クラスターおよびアプリのログ転送について</a>を参照してください。</li>
<li>[<code>ibmcloud ks cluster-config</code> コマンド](cs_cli_reference.html#cs_cluster_config)に `--network` フラグを追加。このフラグは、すべての Calico コマンドを実行するための Calico 構成ファイルをダウンロードします。</li>
<li>軽微な不具合の修正およびリファクタリング</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>2018 年 10 月 10 日</td>
<td><ul><li><code>ibmcloud ks cluster-get</code> の出力にリソース・グループ ID を追加。</li>
<li>クラスター内の鍵管理サービス (KMS) プロバイダーとして [{{site.data.keyword.keymanagementserviceshort}} が有効になる](cs_encrypt.html#keyprotect)と、<code>ibmcloud ks cluster-get</code> の出力に「KMS enabled」フィールドを追加。</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2018 年 10 月 2 日</td>
<td>[リソース・グループ](cs_clusters.html#prepare_account_level)のサポートを追加。</td>
</tr>
<tr>
<td>0.1.590</td>
<td>2018 年 10 月 1 日</td>
<td><ul>
<li>クラスター内の API サーバー・ログを収集するための [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) コマンドと [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) コマンドを追加。</li>
<li>{{site.data.keyword.keymanagementserviceshort}} をクラスター内の鍵管理サービス (KMS) プロバイダーとして有効にするための [<code>ibmcloud ks key-protect-enable</code> コマンド](cs_cli_reference.html#cs_key_protect)を追加。</li>
<li>リブートまたは再ロード開始前のマスター・ヘルス・チェックをスキップするための <code>--skip-master-health</code> フラグを [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) および [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) コマンドに追加。</li>
<li><code>ibmcloud ks cluster-get</code> の出力の中の <code>Owner Email</code> を <code>Owner</code> に名前変更。</li></ul></td>
</tr>
</tbody>
</table>
