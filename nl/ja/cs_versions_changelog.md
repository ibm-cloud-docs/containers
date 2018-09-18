---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

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

{{site.data.keyword.containerlong}} Kubernetes クラスターに利用可能なメジャー、マイナー、パッチの更新に関するバージョン変更の情報を表示します。 変更には、Kubernetes および {{site.data.keyword.Bluemix_notm}} Provider コンポーネントへの更新が含まれます。
{:shortdesc}

マスターには IBM がパッチ・レベルの更新を自動的に適用しますが、[ワーカー・ノードのパッチはお客様が更新する](cs_cluster_update.html#worker_node)必要があります。マスター・ノードとワーカー・ノードの両方で、お客様が[メジャーとマイナー](cs_versions.html#update_types)の更新を適用する必要があります。利用可能な更新がないか毎月確認してください。 更新が利用可能になると、マスター・ノードやワーカー・ノードに関する情報を GUI または CLI で `ibmcloud ks clusters`、`cluster-get`、`workers`、`worker-get` などのコマンドを使用して表示したときに通知されます。

マイグレーション操作の要約については、[Kubernetes のバージョン](cs_versions.html)を参照してください。
{: tip}

前のバージョンからの変更点については、以下の変更ログを参照してください。
-  バージョン 1.10 [変更ログ](#110_changelog)。
-  バージョン 1.9 [変更ログ](#19_changelog)。
-  バージョン 1.8 [変更ログ](#18_changelog)。
-  非推奨または非サポートのバージョンの変更ログの[アーカイブ](#changelog_archive)。

## バージョン 1.10 変更ログ
{: #110_changelog}

以下の変更点を確認します。

### 1.10.5_1517 (2018 年 7 月 27 日リリース) の変更ログ
{: #1105_1517}

<table summary="バージョン 1.10.3_1514 からの変更点">
<caption>バージョン 1.10.3_1514 からの変更点</caption>
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
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>Calico [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/releases/#v313) を参照してください。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Kubernetes 1.10.5 リリースをサポートするように更新されました。 また、LoadBalancer サービス `create failure` イベントで、ポータブル・サブネット・エラーが含まれるようになりました。</td>
</tr>
<tr>
<td>IBM ファイル・ストレージ・プラグイン</td>
<td>320</td>
<td>334</td>
<td>永続ボリューム作成のタイムアウトが 15 分から 30 分に増やされました。デフォルトの請求タイプが `hourly` に変更されました。事前定義ストレージ・クラスにマウント・オプションが追加されました。IBM Cloud インフラストラクチャー (SoftLayer) アカウントの NFS ファイル・ストレージ・インスタンスで、**「メモ」**フィールドが JSON 形式に変更され、PV がデプロイされる Kubernetes 名前空間が追加されました。マルチゾーン・クラスターをサポートするため、永続ボリュームにゾーンと地域のラベルが追加されました。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>Kubernetes [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5) を参照してください。</td>
</tr>
<tr>
<td>カーネル</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ハイパフォーマンス・ネットワーキング・ワークロードのために、ワーカー・ノード・ネットワーク設定がわずかに改善されました。</td>
</tr>
<tr>
<td>OpenVPN クライアント</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kube-system` 名前空間で実行される OpenVPN クライアント `vpn` デプロイメントは、Kubernetes `addon-manager` によって管理されるようになりました。</td>
</tr>
</tbody>
</table>

### ワーカー・ノード・フィックスパック 1.10.3_1514 (2018 年 7 月 3 日リリース) の変更ログ
{: #1103_1514}

<table summary="バージョン 1.10.3_1513 からの変更点">
<caption>バージョン 1.10.3_1513 からの変更点</caption>
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
<td>カーネル</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ハイパフォーマンス・ネットワーキング・ワークロードのために、`sysctl` が最適化されました。</td>
</tr>
</tbody>
</table>


### ワーカー・ノード・フィックスパック 1.10.3_1513 (2018 年 6 月 21 日リリース) の変更ログ
{: #1103_1513}

<table summary="バージョン 1.10.3_1512 からの変更点">
<caption>バージョン 1.10.3_1512 からの変更点</caption>
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
<td>Docker</td>
<td>該当なし</td>
<td>該当なし</td>
<td>非暗号化マシン・タイプの場合、ワーカー・ノードを再ロードまたは更新するときに新しいファイル・システムを取得することによって、2 次ディスクがクリーンアップされるようになりました。</td>
</tr>
</tbody>
</table>

### 1.10.3_1512 (2018 年 6 月 12 日リリース) の変更ログ
{: #1103_1512}

<table summary="バージョン 1.10.1_1510 からの変更点">
<caption>バージョン 1.10.1_1510 からの変更点</caption>
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
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>Kubernetes [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3) を参照してください。</td>
</tr>
<tr>
<td>Kubernetes 構成</td>
<td>該当なし</td>
<td>該当なし</td>
<td>クラスターの Kubernetes API サーバーの `--enable-admission-plugins` オプションに `PodSecurityPolicy` が追加され、ポッドのセキュリティー・ポリシーをサポートするようにクラスターが構成されるようになりました。詳しくは、[ポッド・セキュリティー・ポリシーの構成](cs_psp.html) を参照してください。</td>
</tr>
<tr>
<td>Kubelet 構成</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kubelet` HTTPS エンドポイントを認証する API ベアラー・トークンとサービス・アカウント・トークンをサポートするため、`--authentication-token-webhook` オプションが使用可能になりました。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Kubernetes 1.10.3 リリースをサポートするように更新されました。</td>
</tr>
<tr>
<td>OpenVPN クライアント</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kube-system` 名前空間で実行される OpenVPN クライアント `vpn` デプロイメントに `livenessProbe` が追加されました。</td>
</tr>
<tr>
<td>カーネル更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) に対して、カーネル更新を使用して新規ワーカー・イメージが導入されました。</td>
</tr>
</tbody>
</table>



### ワーカー・ノード・フィックスパック 1.10.1_1510 (2018 年 5 月 18 日リリース) の変更ログ
{: #1101_1510}

<table summary="バージョン 1.10.1_1509 からの変更点">
<caption>バージョン 1.10.1_1509 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ブロック・ストレージ・プラグインを使用したときに発生するバグに対応するための修正です。</td>
</tr>
</tbody>
</table>

### ワーカー・ノード・フィックスパック 1.10.1_1509 (2018 年 5 月 16 日リリース) の変更ログ
{: #1101_1509}

<table summary="バージョン 1.10.1_1508 からの変更点">
<caption>バージョン 1.10.1_1508 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kubelet` ルート・ディレクトリーに保管したデータが、ワーカー・ノード・マシンのより大きい 2 次ディスクに保存されるようになりました。</td>
</tr>
</tbody>
</table>

### 1.10.1_1508 (2018 年 5 月 1 日リリース) の変更ログ
{: #1101_1508}

<table summary="バージョン 1.9.7_1510 からの変更点">
<caption>バージョン 1.9.7_1510 からの変更点</caption>
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
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>Calico [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/releases/#v311) を参照してください。</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>Kubernetes Heapster [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2) を参照してください。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>Kubernetes [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1) を参照してください。</td>
</tr>
<tr>
<td>Kubernetes 構成</td>
<td>該当なし</td>
<td>該当なし</td>
<td>クラスターの Kubernetes API サーバーの <code>--enable-admission-plugins</code> オプションに <code>StorageObjectInUseProtection</code> が追加されました。</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>Kubernetes DNS [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/dns/releases/tag/1.14.10) を参照してください。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Kubernetes 1.10 リリースをサポートするように更新されました。</td>
</tr>
<tr>
<td>GPU サポート</td>
<td>該当なし</td>
<td>該当なし</td>
<td>スケジューリングおよび実行で、[グラフィックス・プロセッシング・ユニット (GPU) コンテナー・ワークロード](cs_app.html#gpu_app)がサポートされるようになりました。 使用可能な GPU マシン・タイプのリストについては、[ワーカー・ノード用のハードウェア](cs_clusters.html#shared_dedicated_node)を参照してください。 詳しくは、[GPU のスケジュール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/) に関する Kubernetes の資料を参照してください。</td>
</tr>
</tbody>
</table>

## バージョン 1.9 変更ログ
{: #19_changelog}

以下の変更点を確認します。

### 1.9.9_1520 (2018 年 7 月 27 日リリース) の変更ログ
{: #199_1520}

<table summary="バージョン 1.9.8_1517 からの変更点">
<caption>バージョン 1.9.8_1517 からの変更点</caption>
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
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Kubernetes 1.9.9 リリースをサポートするように更新されました。 また、LoadBalancer サービス `create failure` イベントで、ポータブル・サブネット・エラーが含まれるようになりました。</td>
</tr>
<tr>
<td>IBM ファイル・ストレージ・プラグイン</td>
<td>320</td>
<td>334</td>
<td>永続ボリューム作成のタイムアウトが 15 分から 30 分に増やされました。デフォルトの請求タイプが `hourly` に変更されました。事前定義ストレージ・クラスにマウント・オプションが追加されました。IBM Cloud インフラストラクチャー (SoftLayer) アカウントの NFS ファイル・ストレージ・インスタンスで、**「メモ」**フィールドが JSON 形式に変更され、PV がデプロイされる Kubernetes 名前空間が追加されました。マルチゾーン・クラスターをサポートするため、永続ボリュームにゾーンと地域のラベルが追加されました。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>Kubernetes [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9) を参照してください。</td>
</tr>
<tr>
<td>カーネル</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ハイパフォーマンス・ネットワーキング・ワークロードのために、ワーカー・ノード・ネットワーク設定がわずかに改善されました。</td>
</tr>
<tr>
<td>OpenVPN クライアント</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kube-system` 名前空間で実行される OpenVPN クライアント `vpn` デプロイメントは、Kubernetes `addon-manager` によって管理されるようになりました。</td>
</tr>
</tbody>
</table>

### ワーカー・ノード・フィックスパック 1.9.8_1517 (2018 年 7 月 3 日リリース) の変更ログ
{: #198_1517}

<table summary="バージョン 1.9.8_1516 からの変更点">
<caption>バージョン 1.9.8_1516 からの変更点</caption>
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
<td>カーネル</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ハイパフォーマンス・ネットワーキング・ワークロードのために、`sysctl` が最適化されました。</td>
</tr>
</tbody>
</table>


### ワーカー・ノード・フィックスパック 1.9.8_1516 (2018 年 6 月 21 日リリース) の変更ログ
{: #198_1516}

<table summary="バージョン 1.9.8_1515 からの変更点">
<caption>バージョン 1.9.8_1515 からの変更点</caption>
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
<td>Docker</td>
<td>該当なし</td>
<td>該当なし</td>
<td>非暗号化マシン・タイプの場合、ワーカー・ノードを再ロードまたは更新するときに新しいファイル・システムを取得することによって、2 次ディスクがクリーンアップされるようになりました。</td>
</tr>
</tbody>
</table>

### 1.9.8_1515 (2018 年 6 月 19 日リリース) の変更ログ
{: #198_1515}

<table summary="バージョン 1.9.7_1513 からの変更点">
<caption>バージョン 1.9.7_1513 からの変更点</caption>
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
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>[Kubernetes リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8) を参照してください。</td>
</tr>
<tr>
<td>Kubernetes 構成</td>
<td>該当なし</td>
<td>該当なし</td>
<td>クラスターの Kubernetes API サーバーの --admission-control オプションに PodSecurityPolicy が追加され、ポッドのセキュリティー・ポリシーをサポートするようにクラスターが構成されるようになりました。詳しくは、[ポッド・セキュリティー・ポリシーの構成](cs_psp.html) を参照してください。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Kubernetes 1.9.8 リリースをサポートするように更新されました。</td>
</tr>
<tr>
<td>OpenVPN クライアント</td>
<td>該当なし</td>
<td>該当なし</td>
<td><code>kube-system</code> 名前空間で実行される OpenVPN クライアント <code>vpn</code> デプロイメントに <code>livenessProbe</code> が追加されました。</td>
</tr>
</tbody>
</table>


### ワーカー・ノード・フィックスパック 1.9.7_1513 (2018 年 6 月 11 日リリース) の変更ログ
{: #197_1513}

<table summary="バージョン 1.9.7_1512 からの変更点">
<caption>バージョン 1.9.7_1512 からの変更点</caption>
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
<td>カーネル更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) に対して、カーネル更新を使用して新規ワーカー・イメージが導入されました。</td>
</tr>
</tbody>
</table>

### ワーカー・ノード・フィックスパック 1.9.7_1512 (2018 年 5 月 18 日リリース) の変更ログ
{: #197_1512}

<table summary="バージョン 1.9.7_1511 からの変更点">
<caption>バージョン 1.9.7_1511 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ブロック・ストレージ・プラグインを使用したときに発生するバグに対応するための修正です。</td>
</tr>
</tbody>
</table>

### ワーカー・ノード・フィックスパック 1.9.7_1511 (2018 年 5 月 16 日リリース) の変更ログ
{: #197_1511}

<table summary="バージョン 1.9.7_1510 からの変更点">
<caption>バージョン 1.9.7_1510 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kubelet` ルート・ディレクトリーに保管したデータが、ワーカー・ノード・マシンのより大きい 2 次ディスクに保存されるようになりました。</td>
</tr>
</tbody>
</table>

### 1.9.7_1510 (2018 年 4 月 30 日リリース) の変更ログ
{: #197_1510}

<table summary="バージョン 1.9.3_1506 からの変更点">
<caption>バージョン 1.9.3_1506 からの変更点</caption>
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
<td>v1.9.3</td>
<td>v1.9.7	</td>
<td><p>[Kubernetes リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7) を参照してください。 このリリースで、[CVE-2017-1002101 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) および [CVE-2017-1002102 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) の脆弱性に対応しています。</p><p><strong>注</strong>: `secret`、`configMap`、`downwardAPI`、および投影ボリュームは、読み取り専用でマウントされるようになりました。これまでは、システムによって自動的に元の状態に戻されることがあるこれらのボリュームに、アプリがデータを書き込むことができました。アプリが以前の非セキュアな動作に依存している場合は、適切に変更してください。</p></td>
</tr>
<tr>
<td>Kubernetes 構成</td>
<td>該当なし</td>
<td>該当なし</td>
<td>クラスターの Kubernetes API サーバーの `--runtime-config` オプションに `admissionregistration.k8s.io/v1alpha1=true` が追加されました。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
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

## バージョン 1.8 変更ログ
{: #18_changelog}

以下の変更点を確認します。

### 1.8.15_1518 (2018 年 7 月 27 日リリース) の変更ログ
{: #1815_1518}

<table summary="バージョン 1.8.13_1516 からの変更点">
<caption>バージョン 1.8.13_1516 からの変更点</caption>
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
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Kubernetes 1.8.15 リリースをサポートするように更新されました。 また、LoadBalancer サービス `create failure` イベントで、ポータブル・サブネット・エラーが含まれるようになりました。</td>
</tr>
<tr>
<td>IBM ファイル・ストレージ・プラグイン</td>
<td>320</td>
<td>334</td>
<td>永続ボリューム作成のタイムアウトが 15 分から 30 分に増やされました。デフォルトの請求タイプが `hourly` に変更されました。事前定義ストレージ・クラスにマウント・オプションが追加されました。IBM Cloud インフラストラクチャー (SoftLayer) アカウントの NFS ファイル・ストレージ・インスタンスで、**「メモ」**フィールドが JSON 形式に変更され、PV がデプロイされる Kubernetes 名前空間が追加されました。マルチゾーン・クラスターをサポートするため、永続ボリュームにゾーンと地域のラベルが追加されました。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>Kubernetes [リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15) を参照してください。</td>
</tr>
<tr>
<td>カーネル</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ハイパフォーマンス・ネットワーキング・ワークロードのために、ワーカー・ノード・ネットワーク設定がわずかに改善されました。</td>
</tr>
<tr>
<td>OpenVPN クライアント</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kube-system` 名前空間で実行される OpenVPN クライアント `vpn` デプロイメントは、Kubernetes `addon-manager` によって管理されるようになりました。</td>
</tr>
</tbody>
</table>

### ワーカー・ノード・フィックスパック 1.8.13_1516 (2018 年 7 月 3 日リリース) の変更ログ
{: #1813_1516}

<table summary="バージョン 1.8.13_1515 からの変更点">
<caption>バージョン 1.8.13_1515 からの変更点</caption>
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
<td>カーネル</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ハイパフォーマンス・ネットワーキング・ワークロードのために、`sysctl` が最適化されました。</td>
</tr>
</tbody>
</table>


### ワーカー・ノード・フィックスパック 1.8.13_1515 (2018 年 6 月 21 日リリース) の変更ログ
{: #1813_1515}

<table summary="バージョン 1.8.13_1514 からの変更点">
<caption>バージョン 1.8.13_1514 からの変更点</caption>
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
<td>Docker</td>
<td>該当なし</td>
<td>該当なし</td>
<td>非暗号化マシン・タイプの場合、ワーカー・ノードを再ロードまたは更新するときに新しいファイル・システムを取得することによって、2 次ディスクがクリーンアップされるようになりました。</td>
</tr>
</tbody>
</table>

### 1.8.13_1514 (2018 年 6 月 19 日リリース) の変更ログ
{: #1813_1514}

<table summary="バージョン 1.8.11_1512 からの変更点">
<caption>バージョン 1.8.11_1512 からの変更点</caption>
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
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>[Kubernetes リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13) を参照してください。</td>
</tr>
<tr>
<td>Kubernetes 構成</td>
<td>該当なし</td>
<td>該当なし</td>
<td>クラスターの Kubernetes API サーバーの --admission-control オプションに PodSecurityPolicy が追加され、ポッドのセキュリティー・ポリシーをサポートするようにクラスターが構成されるようになりました。詳しくは、[ポッド・セキュリティー・ポリシーの構成](cs_psp.html) を参照してください。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Kubernetes 1.8.13 リリースをサポートするように更新されました。</td>
</tr>
<tr>
<td>OpenVPN クライアント</td>
<td>該当なし</td>
<td>該当なし</td>
<td><code>kube-system</code> 名前空間で実行される OpenVPN クライアント <code>vpn</code> デプロイメントに <code>livenessProbe</code> が追加されました。</td>
</tr>
</tbody>
</table>


### ワーカー・ノード・フィックスパック 1.8.11_1512 (2018 年 6 月 11 日リリース) の変更ログ
{: #1811_1512}

<table summary="バージョン 1.8.11_1511 からの変更点">
<caption>バージョン 1.8.11_1511 からの変更点</caption>
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
<td>カーネル更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) に対して、カーネル更新を使用して新規ワーカー・イメージが導入されました。</td>
</tr>
</tbody>
</table>


### ワーカー・ノード・フィックスパック 1.8.11_1511 (2018 年 5 月 18 日リリース) の変更ログ
{: #1811_1511}

<table summary="バージョン 1.8.11_1510 からの変更点">
<caption>バージョン 1.8.11_1510 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ブロック・ストレージ・プラグインを使用したときに発生するバグに対応するための修正です。</td>
</tr>
</tbody>
</table>

### ワーカー・ノード・フィックスパック 1.8.11_1510 (2018 年 5 月 16 日リリース) の変更ログ
{: #1811_1510}

<table summary="バージョン 1.8.11_1509 からの変更点">
<caption>バージョン 1.8.11_1509 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kubelet` ルート・ディレクトリーに保管したデータが、ワーカー・ノード・マシンのより大きい 2 次ディスクに保存されるようになりました。</td>
</tr>
</tbody>
</table>


### 1.8.11_1509 (2018 年 4 月 19 日リリース) の変更ログ
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
<td>v1.8.11	</td>
<td><p>[Kubernetes リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11) を参照してください。 このリリースで、[CVE-2017-1002101 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) および [CVE-2017-1002102 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) の脆弱性に対応しています。</p><p><strong>注</strong>: `secret`、`configMap`、`downwardAPI`、および投影ボリュームは、読み取り専用でマウントされるようになりました。これまでは、システムによって自動的に元の状態に戻されることがあるこれらのボリュームに、アプリがデータを書き込むことができました。アプリが以前の非セキュアな動作に依存している場合は、適切に変更してください。</p></td>
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

## アーカイブ
{: #changelog_archive}

### バージョン 1.7 変更ログ (サポート対象外)
{: #17_changelog}

以下の変更点を確認します。

#### ワーカー・ノード・フィックスパック 1.7.16_1514 (2018 年 6 月 11 日リリース) の変更ログ
{: #1716_1514}

<table summary="バージョン 1.7.16_1513 からの変更点">
<caption>バージョン 1.7.16_1513 からの変更点</caption>
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
<td>カーネル更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>[CVE-2018-3639 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) に対して、カーネル更新を使用して新規ワーカー・イメージが導入されました。</td>
</tr>
</tbody>
</table>

#### ワーカー・ノード・フィックスパック 1.7.16_1513 (2018 年 5 月 18 日リリース) の変更ログ
{: #1716_1513}

<table summary="バージョン 1.7.16_1512 からの変更点">
<caption>バージョン 1.7.16_1512 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>ブロック・ストレージ・プラグインを使用したときに発生するバグに対応するための修正です。</td>
</tr>
</tbody>
</table>

#### ワーカー・ノード・フィックスパック 1.7.16_1512 (2018 年 5 月 16 日リリース) の変更ログ
{: #1716_1512}

<table summary="バージョン 1.7.16_1511 からの変更点">
<caption>バージョン 1.7.16_1511 からの変更点</caption>
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
<td>Kubelet</td>
<td>該当なし</td>
<td>該当なし</td>
<td>`kubelet` ルート・ディレクトリーに保管したデータが、ワーカー・ノード・マシンのより大きい 2 次ディスクに保存されるようになりました。</td>
</tr>
</tbody>
</table>

#### 1.7.16_1511 (2018 年 4 月 19 日リリース) の変更ログ
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
<td>v1.7.16	</td>
<td><p>[Kubernetes リリース・ノート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16) を参照してください。 このリリースで、[CVE-2017-1002101 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) および [CVE-2017-1002102 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) の脆弱性に対応しています。</p><p><strong>注</strong>: `secret`、`configMap`、`downwardAPI`、および投影ボリュームは、読み取り専用でマウントされるようになりました。これまでは、システムによって自動的に元の状態に戻されることがあるこれらのボリュームに、アプリがデータを書き込むことができました。アプリが以前の非セキュアな動作に依存している場合は、適切に変更してください。</p></td>
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
