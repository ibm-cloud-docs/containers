---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}



# Fluentd および Ingress ALB の変更ログ
{: #cluster-add-ons-changelog}

{{site.data.keyword.containerlong}} クラスターには、IBM によって自動的に更新される Fluentd や Ingress ALB などのコンポーネントが付属しています。 一部のコンポーネントは、自動更新を無効にして、マスター・ノードおよびワーカー・ノードとは別に手動で更新することもできます。 各バージョンの変更の要約について、以下のセクションの表にまとめます。
{: shortdesc}

Fluentd および Ingress ALB の更新の管理について詳しくは、[クラスター・コンポーネントの更新](/docs/containers?topic=containers-update#components)を参照してください。

## Ingress ALB の変更ログ
{: #alb_changelog}

{{site.data.keyword.containerlong_notm}} クラスター内の Ingress アプリケーション・ロード・バランサー (ALB) のビルド・バージョンの変更内容を示します。
{:shortdesc}

Ingress ALB コンポーネントが更新されると、すべての ALB ポッド内の `nginx-ingress` と `ingress-auth` のコンテナーが最新のビルド・バージョンに更新されます。 デフォルトでは、このコンポーネントに対する自動更新は有効になっていますが、自動更新を無効にして手動で更新することもできます。 詳しくは、[Ingress アプリケーション・ロード・バランサーの更新](/docs/containers?topic=containers-update#alb)を参照してください。

Ingress ALB コンポーネントのビルドごとの変更の要約については、以下の表を参照してください。

<table summary="Ingress アプリケーション・ロード・バランサー・コンポーネントのビルドの変更の概要">
<caption>Ingress アプリケーション・ロード・バランサー・コンポーネントの変更ログ</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
<thead>
<tr>
<th>`nginx-ingress` / `ingress-auth` ビルド</th>
<th>リリース日付</th>
<th>抜本的でない変更</th>
<th>抜本的な変更</th>
</tr>
</thead>
<tbody>
<tr>
<td>515 / 334</td>
<td>2019 年 7 月 30 日</td>
<td><ul>
<li>要求が失われることを防止するための、ALB ポッド再始動の準備状況検査を追加。ALB ポッドは、すべての Ingress リソース・ファイルが解析されるまで (デフォルトで最大 5 分)、トラフィック要求のルーティングを試行しません。デフォルトのタイムアウト値の変更手順などの詳細については、[ALB ポッドの再始動準備状況検査時間を増やす](/docs/containers?topic=containers-ingress-settings#readiness-check)を参照してください。</li>
<li>[CVE-2019-13636 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13636) および [CVE-2019-13638 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13638) の GNU `パッチ`の脆弱性を修正。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>512 / 334</td>
<td>2019 年 7 月 17 日</td>
<td><ul>
<li>[CVE-2016-3189![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9924) の `rbash` の脆弱性を修正。</li>
<li>apt パッケージ `curl`、`bash`、`vim`、`tcpdump`、および `ca-certificates` から、`nginx-ingress` イメージを削除。</li></ul></td>
<td>-</td>
</tr>
<tr>
<td>497 / 334</td>
<td>2019 年 7 月 14 日</td>
<td><ul>
<li>ALB プロキシー・サーバーとバックエンド・アプリのアップストリーム・サーバーとの間でキープアライブ接続が開いたままになる最大時間を設定するための [`upstream-keepalive-timeout`](/docs/containers?topic=containers-ingress_annotation#upstream-keepalive-timeout) を追加。</li>
<li>ALB ソケット・リスナーの数を「クラスターごとに 1 つ」から「ワーカー・ノードごとに 1 つ」に増やすための [`reuse-port`](/docs/containers?topic=containers-ingress-settings#reuse-port) ディレクティブのサポートを追加。</li>
<li>ポート番号が変更されたときに ALB を公開するロード・バランサーの冗長更新を削除。</li>
<li>[CVE-2016-3189 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-3189) および [CVE-2019-12900 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12900) の `bzip2` の脆弱性を修正。</li>
<li>[CVE-2018-20843 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20843) の Expat の脆弱性を修正。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>477 / 331</td>
<td>2019 年 6 月 24 日</td>
<td>[CVE-2016-6153 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-6153)、[CVE-2017-10989 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-10989)、[CVE-2017-13685 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-13685)、[CVE-2017-2518 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-2518)、[CVE-2017-2519 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-2519)、[CVE-2017-2520 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-2520)、[CVE-2018-20346 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20346)、[CVE-2018-20505 ![外部アイコン・リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20505)、[CVE-2018-20506 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20506)、[CVE-2019-8457 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457)、[CVE-2019-9936 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9936)、および [CVE-2019-9937 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9937) の SQLite の脆弱性を修正。

</td>
<td>-</td>
</tr>
<tr>
<td>473 / 331</td>
<td>2019 年 6 月 18 日</td>
<td><ul>
<li>[CVE-2019-5953 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5953) および [CVE-2019-12735 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12735) の Vim の脆弱性を修正。</li>
<li>ALB の NGINX バージョンが 1.15.12 に更新されました。</li></ul>
</td>
<td>-</td>
</tr>
<tr>
<td>470 / 330</td>
<td>2019 年 6 月 7 日</td>
<td>[CVE-2019-8457 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457) のバークレー DB の脆弱性が修正されました。
</td>
<td>-</td>
</tr>
<tr>
<td>470 / 329</td>
<td>2019 年 6 月 6 日</td>
<td>[CVE-2019-8457 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8457) のバークレー DB の脆弱性が修正されました。
</td>
<td>-</td>
</tr>
<tr>
<td>467 / 329</td>
<td>2019 年 6 月 3 日</td>
<td>[CVE-2019-3829 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3829)、[CVE-2019-3836 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3836)、[CVE-2019-3893 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3893)、[CVE-2018-10844 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10845)、[CVE-2018-10845 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10844)、および [CVE-2018-10846 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10846) の GnuTLS の脆弱性を修正。
</td>
<td>-</td>
</tr>
<tr>
<td>462 / 329</td>
<td>2019 年 5 月 28 日</td>
<td>[CVE-2019-5435 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5435) および [CVE-2019-5436 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5436) の cURL の脆弱性が修正されました。</td>
<td>-</td>
</tr>
<tr>
<td>457 / 329</td>
<td>2019 年 5 月 23 日</td>
<td>[CVE-2019-11841 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11841) の Go の脆弱性を修正。</td>
<td>-</td>
</tr>
<tr>
<td>423 / 329</td>
<td>2019 年 5 月 13 日</td>
<td>{{site.data.keyword.appid_full}} との統合のパフォーマンスが改善されました。</td>
<td>-</td>
</tr>
<tr>
<td>411 / 315</td>
<td>2019 年 4 月 15 日</td>
<td>{{site.data.keyword.appid_full_notm}} Cookie の有効期限の値が、アクセス・トークンの有効期限の値と一致するように更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>411 / 306</td>
<td>2019 年 3 月 22 日</td>
<td>Go バージョンが 1.12.1 に更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>2019 年 3 月 18 日</td>
<td><ul>
<li>イメージ・スキャンの脆弱性が修正されました。</li>
<li>{{site.data.keyword.appid_full_notm}} との統合のロギングが改善されました。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>2019 年 3 月 5 日</td>
<td>-</td>
<td>ログアウト機能、トークンの有効期限、および `OAuth` 許可コールバックに関連する許可統合のバグが修正されました。 これらの修正は、[`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth) アノテーションを使用して {{site.data.keyword.appid_full_notm}} 許可を有効にした場合にのみ実装されます。 これらの修正を実装するために追加ヘッダーが導入されるので、合計ヘッダー・サイズが大きくなります。 独自ヘッダーのサイズと応答の合計サイズによっては、使用する[プロキシー・バッファー・アノテーション](/docs/containers?topic=containers-ingress_annotation#proxy-buffer)の調整が必要になる可能性があります。</td>
</tr>
<tr>
<td>406 / 301</td>
<td>2019 年 2 月 19 日</td>
<td><ul>
<li>Go バージョンを 1.11.5 に更新しました。</li>
<li>イメージ・スキャンの脆弱性が修正されました。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404 / 300</td>
<td>2019 年 1 月 31 日</td>
<td>Go バージョンが 1.11.4 に更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>2019 年 1 月 23 日</td>
<td><ul>
<li>ALB の NGINX バージョンが 1.15.2 に更新されました。</li>
<li>IBM 提供の TLS 証明書が、有効期限が切れる 7 日前ではなく 37 日前に自動更新されるようになりました。</li>
<li>{{site.data.keyword.appid_full_notm}} ログアウト機能が追加されました。`/logout` 接頭部は {{site.data.keyword.appid_full_notm}} パスに存在する場合は、cookie が削除されるので、ユーザーがログイン・ページに送り戻されます。</li>
<li>内部追跡目的で {{site.data.keyword.appid_full_notm}} 要求にヘッダーが追加されました。</li>
<li>{{site.data.keyword.appid_short_notm}} の場所ディレクティブが更新され、`app-id` アノテーションを、`proxy-buffers`、`proxy-buffer-size`、および `proxy-busy-buffer-size` アノテーションと一緒に使用できるようになりました。</li>
<li>バグが修正され、情報ログにエラーのラベルが付かないようになりました。</li>
</ul></td>
<td>TLS 1.0 と 1.1 がデフォルトで無効になります。 アプリに接続するクライアントが TLS 1.2 に対応していれば、何の対処も必要ありません。 TLS 1.0 または 1.1 のサポートを必要とする既存のクライアントをまだ使用する場合は、[この手順](/docs/containers?topic=containers-ingress-settings#ssl_protocols_ciphers)に従って必要な TLS バージョンを手動で有効にしてください。 アプリへのアクセスにクライアントで使用している TLS バージョンを確認する方法について詳しくは、こちらの [{{site.data.keyword.cloud_notm}} のブログ投稿](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/)を参照してください。</td>
</tr>
<tr>
<td>393 / 291</td>
<td>2019 年 1 月 9 日</td>
<td>複数の {{site.data.keyword.appid_full_notm}} インスタンスとの統合のサポートが追加されました。</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>2018 年 11 月 29 日</td>
<td>{{site.data.keyword.appid_full_notm}} との統合のパフォーマンスが改善されました。</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018 年 11 月 14 日</td>
<td>{{site.data.keyword.appid_full_notm}} との統合のロギング機能とログアウト機能が改善されました。</td>
<td>`*.containers.mybluemix.net` の自己署名証明書が、自動生成されてクラスターで自動使用される LetsEncrypt 署名付き証明書に置き換えられました。 `*.containers.mybluemix.net` 自己署名証明書は削除されます。</td>
</tr>
<tr>
<td>350 / 192</td>
<td>2018 年 11 月 5 日</td>
<td>Ingress ALB コンポーネントの自動更新を有効/無効にするサポートが追加されました。</td>
<td>-</td>
</tr>
</tbody>
</table>

## ロギング用 Fluentd の変更ログ
{: #fluentd_changelog}

{{site.data.keyword.containerlong_notm}} クラスター内のロギング用 Fluentd コンポーネントのビルド・バージョンの変更内容を示します。
{:shortdesc}

デフォルトでは、このコンポーネントに対する自動更新は有効になっていますが、自動更新を無効にして手動で更新することもできます。 詳しくは、[Fluentd の自動更新の管理](/docs/containers?topic=containers-update#logging-up)を参照してください。

Fluentd コンポーネントのビルドごとの変更の要約については、以下の表を参照してください。

<table summary="Fluentd コンポーネントのビルドの変更の概要">
<caption>Fluentd コンポーネントの変更ログ</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
<thead>
<tr>
<th>Fluentd ビルド</th>
<th>リリース日付</th>
<th>抜本的でない変更</th>
<th>抜本的な変更</th>
</tr>
</thead>
<tr>
<td>96f399cdea1c86c63a4ca4e043180f81f3559676</td>
<td>2019 年 7 月 22 日</td>
<td>[CVE-2019-8905 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8905)、[CVE-2019-8906 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8906)、および [CVE-2019-8907 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8907) への対策として Alpine パッケージを更新。</td>
<td>-</td>
</tr>
<tr>
<td>e7c10d74350dc64d4d92ba7f72bb4ff9219315d2</td>
<td>2019 年 5 月 30 日</td>
<td>Kubernetes マスターが使用不可の場合でも、IBM 名前空間からのポッド・ログを常に無視するように Fluent 構成マップが更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>c16fe1602ab65db4af0a6ac008f99ca2a526e6f6</td>
<td>2019 年 5 月 21 日</td>
<td>ワーカー・ノードのメトリックが表示されないバグが修正されました。</td>
<td>-</td>
</tr>
<tr>
<td>60fc11f7bd39d9c6cfed923c598bf6457b3f2037</td>
<td>2019 年 5 月 10 日</td>
<td>[CVE-2019-8320 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320)、[CVE-2019-8321 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321)、[CVE-2019-8322 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322)、[CVE-2019-8323 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323)、[CVE-2019-8324 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324)、および [CVE-2019-8325 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325) への対策として Ruby パッケージが更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>91a737f68f7d9e81b5d2223c910aaa7d7f91b76d</td>
<td>2019 年 5 月 8 日</td>
<td>[CVE-2019-8320 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8320)、[CVE-2019-8321 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8321)、[CVE-2019-8322 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8322)、[CVE-2019-8323 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323)、[CVE-2019-8324 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8324)、および [CVE-2019-8325 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8325) への対策として Ruby パッケージが更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>d9af69e286986a05ed4a50469585b1cf978ddb1d</td>
<td>2019 年 4 月 11 日</td>
<td>TLS 1.2 を使用するように、cAdvisor プラグインが更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>3100ddb62580a9f46ffdff7bab2ebec40b164de6</td>
<td>2019 年 4 月 1 日</td>
<td>Fluentd サービス・アカウントが更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>c85567b75bd7ad1c9428794cd63a8e239c3fd8f5</td>
<td>2019 年 3 月 18 日</td>
<td>[CVE-2019-8323 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8323) への対策として cURL への依存が解除されました。</td>
<td>-</td>
</tr>
<tr>
<td>320ffdf87de068ee2f7f34c0e7a47a111e8d457b</td>
<td>2019 年 2 月 18 日</td>
<td><ul>
<li>Fluend がバージョン 1.3 に更新されました。</li>
<li>[CVE-2018-19486 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-19486) への対策として Fluentd イメージから Git が削除されました。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>972865196aefd3324105087878de12c518ed579f</td>
<td>2019 年 1 月 1 日</td>
<td><ul>
<li>Fluentd の `in_tail` プラグインの UTF-8 エンコードが有効になりました。</li>
<li>軽微なバグが修正されています。</li>
</ul></td>
<td>-</td>
</tr>
</tbody>
</table>
