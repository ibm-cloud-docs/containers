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


# クラスター・アドオンの変更ログ

{{site.data.keyword.containerlong}} クラスターには、IBM によって自動的に更新されるアドオンが付属しています。 一部のアドオンの自動更新を無効にして、マスター・ノードやワーカー・ノードとは別に手動で更新することもできます。 各バージョンの変更の要約について、以下のセクションの表にまとめます。
{: shortdesc}

## Ingress ALB アドオンの変更ログ
{: #alb_changelog}

{{site.data.keyword.containerlong_notm}} クラスター内の Ingress アプリケーション・ロード・バランサー (ALB) アドオンのビルド・バージョンの変更内容を示します。
{:shortdesc}

Ingress ALB アドオンが更新されると、すべての ALB ポッド内の `nginx-ingress` と `ingress-auth` のコンテナーが最新のビルド・バージョンに更新されます。 デフォルトでは、このアドオンに対する自動更新は有効になっていますが、自動更新を無効にして手動で更新することもできます。 詳しくは、[Ingress アプリケーション・ロード・バランサーの更新](cs_cluster_update.html#alb)を参照してください。

Ingress ALB アドオンのビルドごとの変更の要約については、以下の表を参照してください。

<table summary="Ingress アプリケーション・ロード・バランサー・アドオンのビルドの変更の概要">
<caption>Ingress アプリケーション・ロード・バランサー・アドオンの変更ログ</caption>
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
<td>393 / 282</td>
<td>2018 年 11 月 29 日</td>
<td>{{site.data.keyword.appid_full}} のパフォーマンスが改善されました。</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018 年 11 月 14 日</td>
<td>{{site.data.keyword.appid_full}} のロギング機能とログアウト機能が改善されました。</td>
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
