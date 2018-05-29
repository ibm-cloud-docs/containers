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

# バージョンの変更ログ
{: #changelog}

{{site.data.keyword.containerlong}} Kubernetes クラスターに利用可能なメジャー、マイナー、パッチの更新に関するバージョン変更の情報を表示します。変更には、Kubernetes および {{site.data.keyword.Bluemix_notm}} Provider コンポーネントへの更新が含まれます。
{:shortdesc}

マスターには IBM がパッチ・レベルの更新を自動的に適用しますが、[ワーカー・ノードはお客様が更新する](cs_cluster_update.html#worker_node)必要があります。利用可能な更新がないか毎月確認してください。更新が利用可能になると、`bx cs workers <cluster>` や `bx cs worker-get <cluster> <worker>` コマンドなどを使用してワーカー・ノードの情報を表示したときに通知されます。

マイグレーション操作の要約については、[Kubernetes のバージョン](cs_versions.html)を参照してください。
{: tip}

前のバージョンからの変更点については、以下の変更ログを参照してください。
-  バージョン 1.8 [変更ログ](#18_changelog)。
-  バージョン 1.7 [変更ログ](#17_changelog)。


## バージョン 1.8 変更ログ
{: #18_changelog}

以下の変更点を確認します。

### 1.8.11_1509 の変更ログ
{: #1811_1509}

<table summary="バージョン 1.8.8_1507 からの変更点">
<caption>バージョン 1.8.8_1507 からの変更点</caption>
<thead>
<tr>
<th>コンポーネント</th>
<th>以前</th>
<th>現在</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11</td>
<td>[Kubernetes リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11) を参照してください。</td>
</tr>
<tr>
<td>一時停止コンテナーのイメージ</td>
<td>3.0</td>
<td>3.1</td>
<td>継承したオーファン・ゾンビ・プロセスを削除します。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>`NodePort` と `LoadBalancer` サービスは、`service.spec.externalTrafficPolicy` を `Local` に設定すると、[クライアント・ソース IP の保持](cs_loadbalancer.html#node_affinity_tolerations)をサポートするようになりました。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>以前のクラスターの[エッジ・ノード](cs_edge.html#edge)耐障害性セットアップを修正します。</td>
</tr>
</tbody>
</table>

## バージョン 1.7 変更ログ
{: #17_changelog}

以下の変更点を確認します。

### 1.7.16_1511 の変更ログ
{: #1716_1511}

<table summary="バージョン 1.7.4_1509 からの変更点">
<caption>バージョン 1.7.4_1509 からの変更点</caption>
<thead>
<tr>
<th>コンポーネント</th>
<th>以前</th>
<th>現在</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16</td>
<td>[Kubernetes リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16) を参照してください。</td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>`NodePort` と `LoadBalancer` サービスは、`service.spec.externalTrafficPolicy` を `Local` に設定すると、[クライアント・ソース IP の保持](cs_loadbalancer.html#node_affinity_tolerations)をサポートするようになりました。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>以前のクラスターの[エッジ・ノード](cs_edge.html#edge)耐障害性セットアップを修正します。</td>
</tr>
</tbody>
</table>

