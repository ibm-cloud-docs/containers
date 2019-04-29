---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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



# クラスター・アドオンの変更ログ

{{site.data.keyword.containerlong}} クラスターには、IBM によって自動的に更新されるアドオンが付属しています。 一部のアドオンの自動更新を無効にして、マスター・ノードやワーカー・ノードとは別に手動で更新することもできます。 各バージョンの変更の要約について、以下のセクションの表にまとめます。
{: shortdesc}

## Ingress ALB アドオンの変更ログ
{: #alb_changelog}

{{site.data.keyword.containerlong_notm}} クラスター内の Ingress アプリケーション・ロード・バランサー (ALB) アドオンのビルド・バージョンの変更内容を示します。
{:shortdesc}

Ingress ALB アドオンが更新されると、すべての ALB ポッド内の `nginx-ingress` と `ingress-auth` のコンテナーが最新のビルド・バージョンに更新されます。 デフォルトでは、このアドオンに対する自動更新は有効になっていますが、自動更新を無効にして手動で更新することもできます。 詳しくは、[Ingress アプリケーション・ロード・バランサーの更新](/docs/containers?topic=containers-update#alb)を参照してください。

Ingress ALB アドオンのビルドごとの変更の要約については、以下の表を参照してください。

<table summary="Ingress アプリケーション・ロード・バランサー・アドオンのビルドの変更の概要">
<caption>Ingress アプリケーション・ロード・バランサー・アドオンの変更ログ</caption>
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
<td>411 / 306</td>
<td>2019 年 3 月 21 日</td>
<td>Go バージョンが 1.12.1 に更新されました。</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>2019 年 3 月 18 日</td>
<td><ul>
<li>イメージ・スキャンの脆弱性が修正されました。</li>
<li>{{site.data.keyword.appid_full}} のロギングが改善されました。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>2019 年 3 月 5 日</td>
<td>-</td>
<td>ログアウト機能、トークンの有効期限、および `OAuth` 許可コールバックに関連する許可統合のバグが修正されました。これらの修正は、[`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth) アノテーションを使用して {{site.data.keyword.appid_full_notm}} 許可を有効にした場合にのみ実装されます。これらの修正を実装するために追加ヘッダーが導入されるので、合計ヘッダー・サイズが大きくなります。独自ヘッダーのサイズと応答の合計サイズによっては、使用する[プロキシー・バッファー・アノテーション](/docs/containers?topic=containers-ingress_annotation#proxy-buffer)の調整が必要になる可能性があります。</td>
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
<td>TLS 1.0 と 1.1 がデフォルトで無効になります。アプリに接続するクライアントが TLS 1.2 に対応していれば、何の対処も必要ありません。TLS 1.0 または 1.1 のサポートを必要とする既存のクライアントをまだ使用する場合は、[この手順](/docs/containers?topic=containers-ingress#ssl_protocols_ciphers)に従って必要な TLS バージョンを手動で有効にしてください。アプリへのアクセスにクライアントで使用している TLS バージョンを確認する方法について詳しくは、こちらの [{{site.data.keyword.Bluemix_notm}} のブログ投稿](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/)を参照してください。</td>
</tr>
<tr>
<td>393 / 291</td>
<td>2019 年 1 月 9 日</td>
<td>複数の {{site.data.keyword.appid_full_notm}} インスタンス用のサポートが追加されました。</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>2018 年 11 月 29 日</td>
<td>{{site.data.keyword.appid_full_notm}} のパフォーマンスが改善されました。</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018 年 11 月 14 日</td>
<td>{{site.data.keyword.appid_full_notm}} のロギング機能とログアウト機能が改善されました。</td>
<td>`*.containers.mybluemix.net` の自己署名証明書が、自動生成されてクラスターで自動使用される LetsEncrypt 署名付き証明書に置き換えられました。 `*.containers.mybluemix.net` 自己署名証明書は削除されます。</td>
</tr>
<tr>
<td>350 / 192</td>
<td>2018 年 11 月 5 日</td>
<td>Ingress ALB アドオンの自動更新を有効/無効にするサポートが追加されました。</td>
<td>-</td>
</tr>
</tbody>
</table>
