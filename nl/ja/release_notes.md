---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

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


# リリース・ノート
{: #iks-release}

リリース・ノートを使用して、月別にグループ化された {{site.data.keyword.containerlong}} の資料に対する最新の変更をご確認ください。
{:shortdesc}

以下のアイコンを使用して、リリース・ノートが特定のコンテナー・プラットフォームにのみ適用されるかどうかを示しています。アイコンが付いていないリリース・ノートはコミュニティー Kubernetes クラスターと OpenShift クラスターの両方に適用されます。<br>
<img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> コミュニティー Kubernetes クラスターにのみ適用されます。<br>
<img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> 2019 年 6 月 5 日にベータ版としてリリースされた OpenShift クラスターにのみ適用されます。
{: note}

## 2019 年 8 月
{: #aug19}

<table summary="この表は、リリース・ノートを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2019 年 8 月の資料の更新</caption>
<thead>
<th>日</th>
<th>説明</th>
</thead>
<tbody>
<tr>
  <td>2019 年 8 月 1 日</td>
  <td><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: 2019 年 8 月 1 日 0:00 UTC 現在、Red Hat OpenShift on IBM Cloud は一般出荷可能です。ベータ版のクラスターはすべて 30 日以内に有効期限が切れます。ベータ版クラスターを削除する前に、[GA クラスターを作成](/docs/openshift?topic=openshift-openshift_tutorial)し、ベータ版クラスターで使用しているアプリを再デプロイすることができます。<br><br>{{site.data.keyword.containerlong_notm}} のロジックと基礎となるクラウド・インフラストラクチャーは同じであるため、このリリース・ノートのトピックも含め多数のトピックが[コミュニティー Kubernetes](/docs/containers?topic=containers-getting-started) クラスターと [OpenShift](/docs/openshift?topic=openshift-getting-started) クラスターの資料で再利用されています。</td>
</tr>
</tbody></table>

## 2019 年 7 月
{: #jul19}

<table summary="この表は、リリース・ノートを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>{{site.data.keyword.containerlong_notm}} の資料の更新 (2019 年 7 月)</caption>
<thead>
<th>日</th>
<th>説明</th>
</thead>
<tbody>
<tr>
  <td>2019 年 7 月 30 日</td>
  <td><ul>
  <li><strong>CLI 変更ログ</strong>: [バージョン 0.3.95 のリリース](/docs/containers?topic=containers-cs_cli_changelog)の {{site.data.keyword.containerlong_notm}} CLI プラグイン変更ログ・ページを更新しました。</li>
  <li><strong>Ingress ALB 変更ログ</strong>: [ALB ポッドの準備状況検査](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog)に関連して、ALB `nginx-ingress` イメージをビルド 515 に更新しました。</li>
  <li><strong>クラスターからのサブネットの削除</strong>: [IBM Cloud インフラストラクチャー・アカウント内](/docs/containers?topic=containers-subnets#remove-sl-subnets)または[オンプレミス・ネットワーク内](/docs/containers?topic=containers-subnets#remove-user-subnets)のサブネットをクラスターから削除する手順を追加しました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 7 月 26 日</td>
  <td><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: [統合](/docs/openshift?topic=openshift-openshift_integrations)、[場所](/docs/openshift?topic=openshift-regions-and-zones)、および[セキュリティー・コンテキストの制約](/docs/openshift?topic=openshift-openshift_scc)に関するトピックを追加しました。`basic-users` クラスター役割と `self-provisioning` クラスター役割を、[IAM サービス役割と RBAC の同期](/docs/openshift?topic=openshift-access_reference#service)のトピックに追加しました。</td>
</tr>
<tr>
  <td>2019 年 7 月 23 日</td>
  <td><strong>Fluentd 変更ログ</strong>: [Alpine の脆弱性](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog)を修正。</td>
</tr>
<tr>
  <td>2019 年 7 月 22 日</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョン・ポリシー</strong>: [バージョンが非推奨になる](/docs/containers?topic=containers-cs_versions#version_types)期間を、30 日から 45 日に延長しました。</li>
      <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョンの変更ログ</strong>: ワーカー・ノード・パッチ更新 [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526_worker)、[1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529_worker)、および [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560_worker) の変更ログを更新しました。</li>
    <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョンの変更ログ</strong>: [バージョン 1.11](/docs/containers?topic=containers-changelog#111_changelog) はサポートされていません。</li></ul>
  </td>
</tr>
<tr>
  <td>2019 年 7 月 19 日</td>
  <td><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: [Red Hat OpenShift on IBM Cloud の資料を別のリポジトリーに](/docs/openshift?topic=openshift-getting-started)追加しました。{{site.data.keyword.containerlong_notm}} のロジックと基礎となるクラウド・インフラストラクチャーは同じであるため、このリリース・ノートのトピックも含め多数のトピックがコミュニティー Kubernetes クラスターと OpenShift クラスターの資料で再利用されています。
  </td>
</tr>
<tr>
  <td>2019 年 7 月 17 日</td>
  <td><strong>Ingress ALB 変更ログ</strong>: [`rbash` の脆弱性を修正](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog)。
  </td>
</tr>
<tr>
  <td>2019 年 7 月 15 日</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>クラスターとワーカー・ノードの ID</strong>: クラスターとワーカー・ノードの ID 形式を変更。既存のクラスターとワーカー・ノードは、既存の ID を保持します。以前の形式に依存する自動化がある場合は、新しいクラスター用に更新してください。<ul>
  <li>**クラスター ID**: regex 形式の `{a-v0-9}[7]{a-z0-9}[2]{a-v0-9}[11]`</li>
  <li>**ワーカー・ノード ID**: 形式 `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`</li></ul></li>
  <li><strong>Ingress ALB の変更ログ</strong>: [ALB `nginx-ingress` イメージがビルド 497 に](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog)更新されました。</li>
  <li><strong>クラスターのトラブルシューティング</strong>: アカウントで時刻ベースのワンタイム・パスコード (TOTP) オプションが有効になっているためにクラスターおよびワーカー・ノードを管理できない場合の[トラブルシューティング・ステップ](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_totp)を追加しました。</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョンの変更ログ</strong>: [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526)、[1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529)、および [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560) のマスター・フィックスパック更新の変更ログを更新しました。</li></ul>
  </td>
</tr>
<tr>
  <td>2019 年 7 月 8 日</td>
  <td><ul>
  <li><strong>アプリ・ネットワーク</strong>: 以下のページに、NLB および Ingress ALB を使用したアプリ・ネットワークに関する情報を追加しました。
    <ul><li>[ネットワーク・ロード・バランサー (NLB) を使用した基本ロード・バランシングと DSR ロード・バランシング](/docs/containers?topic=containers-cs_sitemap#sitemap-nlb)</li>
    <li>[Ingress アプリケーション・ロード・バランサー (ALB) を使用した HTTPS ロード・バランシング](/docs/containers?topic=containers-cs_sitemap#sitemap-ingress)</li></ul>
  </li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョンの変更ログ</strong>: ワーカー・ノード・パッチ更新 [1.14.3_1525](/docs/containers?topic=containers-changelog#1143_1525)、[1.13.7_1528](/docs/containers?topic=containers-changelog#1137_1528)、[1.12.9_1559](/docs/containers?topic=containers-changelog#1129_1559)、および [1.11.10_1564](/docs/containers?topic=containers-changelog#11110_1564) の変更ログを更新しました。</li></ul>
  </td>
</tr>
<tr>
  <td>2019 年 7 月 2 日</td>
  <td><strong>CLI 変更ログ</strong>: [バージョン 0.3.58 のリリース](/docs/containers?topic=containers-cs_cli_changelog)の {{site.data.keyword.containerlong_notm}} CLI プラグイン変更ログ・ページを更新しました。</td>
</tr>
<tr>
  <td>2019 年 7 月 1 日</td>
  <td><ul>
  <li><strong>インフラストラクチャー権限</strong>: 一般的なユース・ケースに必要な[クラシック・インフラストラクチャーの役割](/docs/containers?topic=containers-access_reference#infra)を更新しました。</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>OpenShift の FAQ</strong>: [FAQ](/docs/containers?topic=containers-faqs#container_platforms) を拡張し、OpenShift クラスターに関する情報を組み込みました。</li>
  <li><strong>{{site.data.keyword.appid_short_notm}}</strong> による Istio 管理対象アプリの保護: [アプリ ID とアクセス・アダプター](/docs/containers?topic=containers-istio#app-id)に関する情報を追加しました。</li>
  <li><strong>strongSwan VPN サービス</strong>: strongSwan を複数ゾーン・クラスターにインストールし、`enableSingleSourceIP=true` 設定を使用する場合、[`local.subnet` に `%zoneSubnet` 変数を設定し、`local.zoneSubnet` を使用してクラスターの各ゾーンの /32 サブネットとして IP アドレスを指定することができます。](/docs/containers?topic=containers-vpn#strongswan_4)</li>
  </ul></td>
</tr>
</tbody></table>


## 2019 年 6 月
{: #jun19}

<table summary="この表は、リリース・ノートを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>{{site.data.keyword.containerlong_notm}} の資料の更新 (2019 年 6 月)</caption>
<thead>
<th>日</th>
<th>説明</th>
</thead>
<tbody>
<tr>
  <td>2019 年 6 月 24 日</td>
  <td><ul>
  <li><strong>Calico ネットワーク・ポリシー</strong>: パブリック・ネットワークおよびプライベート・ネットワーク上のクラスターの保護のために、[パブリック Calico ポリシー](/docs/containers?topic=containers-network_policies#isolate_workers_public)のセットを追加し、[プライベート Calico ポリシー](/docs/containers?topic=containers-network_policies#isolate_workers)のセットを拡張しました。</li>
  <li><strong>Ingress ALB の変更ログ</strong>: [ALB `nginx-ingress` イメージがビルド 477 に](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog)更新されました。</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>サービスの制限</strong>: [ワーカー・ノードごとのポッドの最大数の制限](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits)を更新しました。Kubernetes 1.13.7_1527、1.14.3_1524 以降を実行し、11 個を超える CPU コアを持つワーカー・ノードの場合、ワーカー・ノードはコアあたり 10 個のポッド (ワーカー・ノードあたり最大 250 個のポッド) をサポートできます。</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョンの変更ログ</strong>: ワーカー・ノード・パッチ更新 [1.14.3_1524](/docs/containers?topic=containers-changelog#1143_1524)、[1.13.7_1527](/docs/containers?topic=containers-changelog#1137_1527)、[1.12.9_1558](/docs/containers?topic=containers-changelog#1129_1558)、および [1.11.10_1563](/docs/containers?topic=containers-changelog#11110_1563) の変更ログを追加しました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 6 月 21 日</td>
  <td><ul>
  <li><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>OpenShift クラスターへのアクセス</strong>: [OpenShift ログイン・トークンを使用した OpenShift クラスターへのアクセスの自動化](/docs/containers?topic=containers-cs_cli_install#openshift_cluster_login)のステップを追加しました。</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>プライベート・サービス・エンドポイントを介した Kubernetes マスターへのアクセス</strong>: パブリック・サービスとプライベート・サービスの両方のエンドポイントが有効になっているが、Kubernetes マスターにはプライベート・サービス・エンドポイント経由でのみアクセスしたい場合の[ローカル Kubernetes 構成ファイルの編集](/docs/containers?topic=containers-clusters#access_on_prem)のステップを追加しました。</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>OpenShift クラスターのトラブルシューティング</strong>:「Red Hat OpenShift on IBM Cloud クラスター (ベータ版) の作成」チュートリアルに[トラブルシューティング・セクション](/docs/openshift?topic=openshift-openshift_tutorial#openshift_troubleshoot)を追加しました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 6 月 18 日</td>
  <td><ul>
  <li><strong>CLI 変更ログ</strong>: [バージョン 0.3.47 および 0.3.49 のリリース](/docs/containers?topic=containers-cs_cli_changelog)の {{site.data.keyword.containerlong_notm}} CLI プラグインの変更ログのページを更新しました。</li>
  <li><strong>Ingress ALB 変更ログ</strong>: [ALB `nginx-ingress` イメージがビルド 473 に更新され、`ingress-auth` イメージがビルド 331](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog) に更新されました。</li>
  <li><strong>管理対象アドオンのバージョン</strong>: Istio 管理対象アドオンのバージョンが 1.1.7 に更新され、Knative 管理対象アドオンが 0.6.0 に更新されました。</li>
  <li><strong>永続ストレージの削除</strong>: [永続ストレージを削除](/docs/containers?topic=containers-cleanup)した場合の請求方法に関する情報を更新しました。</li>
  <li><strong>プライベート・エンドポイントでのサービス・バインディング</strong>: サービスをクラスターにバインドするときにプライベート・サービス・エンドポイントでサービス資格情報を手動で作成する方法に関する[ステップを追加しました](/docs/containers?topic=containers-service-binding)。</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョンの変更ログ</strong>: パッチ更新 [1.14.3_1523](/docs/containers?topic=containers-changelog#1143_1523)、[1.13.7_1526](/docs/containers?topic=containers-changelog#1137_1526)、[1.12.9_1557](/docs/containers?topic=containers-changelog#1129_1557)、および [1.11.10_1562](/docs/containers?topic=containers-changelog#11110_1562) の変更ログを更新しました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 6 月 14 日</td>
  <td><ul>
  <li><strong>`kubectl` トラブルシューティング</strong>: 使用している `kubectl` クライアントのバージョンが、`kubectl` のサーバー・バージョンまたは OpenShift バージョンと 2 バージョン以上離れている場合 (この場合、コミュニティー Kubernetes クラスターでは kubectl は機能しない) の [トラブルシューティング・トピック](/docs/containers?topic=containers-cs_troubleshoot_clusters#kubectl_fails)を追加しました。</li>
  <li><strong>チュートリアル・ランディング・ページ</strong>: {{site.data.keyword.containershort_notm}} に固有のすべてのチュートリアルで、関連リンク・ページを新しい[チュートリアル・ランディング・ページ](/docs/containers?topic=containers-tutorials-ov)に置き換えました。</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>クラスターの作成とアプリのデプロイのチュートリアル</strong>: クラスターの作成のチュートリアルとアプリのデプロイのチュートリアルを 1 つの包括的な[チュートリアル](/docs/containers?topic=containers-cs_cluster_tutorial)にまとめました。</li>
  <li><strong>既存のサブネットを使用したクラスターの作成</strong>: [新しいクラスターを作成する際に、不要なクラスターのサブネットを再利用するためには](/docs/containers?topic=containers-subnets#subnets_custom)、それらのサブネットが、オンプレミス・ネットワークから手動で追加されたユーザー管理サブネットでなければなりません。クラスターの作成時に自動的に注文されたサブネットはすべて、クラスターの削除後すぐに削除されるので、これらのサブネットを再利用して新規クラスターを作成することはできません。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 6 月 12 日</td>
  <td><strong>クラスター役割の集約</strong>: [クラスター役割を集約することによってユーザーの既存の許可を拡張する](/docs/containers?topic=containers-users#rbac_aggregate)ためのステップを追加しました。</td>
</tr>
<tr>
  <td>2019 年 6 月 7 日</td>
  <td><ul>
  <li><strong>プライベート・サービス・エンドポイントを介した Kubernetes マスターへのアクセス</strong>: プライベート・ロード・バランサーを介してプライベート・サービス・エンドポイントを公開するための[ステップ](/docs/containers?topic=containers-clusters#access_on_prem)を追加しました。これらのステップを完了すると、権限があるクラスター・ユーザーは、VPN または {{site.data.keyword.cloud_notm}} Direct Link 接続から Kubernetes マスターにアクセスできます。</li>
  <li><strong>{{site.data.keyword.BluDirectLink}}</strong>: パブリック・インターネット経由でルーティングせずに、リモート・ネットワーク環境と {{site.data.keyword.containerlong_notm}} の間の直接のプライベート接続を作成する手段として、{{site.data.keyword.cloud_notm}} Direct Link が [VPN 接続](/docs/containers?topic=containers-vpn)と[ハイブリッド・クラウド](/docs/containers?topic=containers-hybrid_iks_icp)のページに追加されました。</li>
  <li><strong>Ingress ALB の変更ログ</strong>: [ALB `ingress-auth` イメージがビルド 330 に](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog)更新されました。</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>OpenShift ベータ</strong>: アドオン {{site.data.keyword.la_full_notm}} および {{site.data.keyword.mon_full_notm}} の特権セキュリティー・コンテキスト制約のアプリ・デプロイメントを変更する方法に関する[レッスンを追加しました](/docs/openshift?topic=openshift-openshift_tutorial#openshift_logdna_sysdig)。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 6 月 6 日</td>
  <td><ul>
  <li><strong>Fluentd の変更ログ</strong>: [Fluentd バージョンの変更ログ](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog)が追加されました。</li>
  <li><strong>Ingress ALB の変更ログ</strong>: [ALB `nginx-ingress` イメージがビルド 470 に](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog)更新されました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 6 月 5 日</td>
  <td><ul>
  <li><strong>CLI リファレンス</strong>: {{site.data.keyword.containerlong_notm}} CLI プラグインの[バージョン 0.3.34 のリリース](/docs/containers?topic=containers-cs_cli_changelog)に対する複数の変更を反映するように [CLI リファレンス・ページ](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli)が更新されました。</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift アイコン" width="15" style="width:15px; border-style: none"/> <strong>新着情報! Red Hat OpenShift on IBM Cloud クラスター (ベータ)</strong>: Red Hat OpenShift on IBM Cloud ベータでは、OpenShift コンテナー・オーケストレーション・プラットフォーム・ソフトウェアとともにインストールされるワーカー・ノードを持つ {{site.data.keyword.containerlong_notm}} クラスターを作成できます。 クラスター・インフラストラクチャー環境用の管理対象 {{site.data.keyword.containerlong_notm}} のすべての利点は、アプリのデプロイメントのために Red Hat Enterprise Linux 上で実行される [OpenShift ツールおよびカタログ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.openshift.com/container-platform/3.11/welcome/index.html) とともに入手できます。 開始するには、[チュートリアル: Red Hat OpenShift on IBM Cloud クラスター (ベータ版) の作成](/docs/openshift?topic=openshift-openshift_tutorial)を参照してください。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 6 月 4 日</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes アイコン" width="15" style="width:15px; border-style: none"/> <strong>バージョンの変更ログ</strong>: パッチ・リリース [1.14.2_1521](/docs/containers?topic=containers-changelog#1142_1521)、[1.13.6_1524](/docs/containers?topic=containers-changelog#1136_1524)、[1.12.9_1555](/docs/containers?topic=containers-changelog#1129_1555)、および [1.11.10_1561](/docs/containers?topic=containers-changelog#11110_1561) の変更ログを更新しました。</li></ul>
  </td>
</tr>
<tr>
  <td>2019 年 6 月 3 日</td>
  <td><ul>
  <li><strong>独自の Ingress コントローラーの持ち込み</strong>: デフォルトのコミュニティー・コントローラーに対する変更を反映し、複数ゾーン・クラスター内のコントローラー IP アドレスのヘルス・チェックを必要とするように[ステップ](/docs/containers?topic=containers-ingress-user_managed)が更新されました。</li>
  <li><strong>{{site.data.keyword.cos_full_notm}}</strong>: Helm サーバー Tiller の有無にかかわらず {{site.data.keyword.cos_full_notm}} プラグインをインストールするように[ステップ](/docs/containers?topic=containers-object_storage#install_cos)が更新されました。</li>
  <li><strong>Ingress ALB の変更ログ</strong>: [ALB `nginx-ingress` イメージがビルド 467 に](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog)更新されました。</li>
  <li><strong>Kustomize</strong>: [Kustomize がある複数の環境で Kubernetes 構成ファイルを再利用する](/docs/containers?topic=containers-app#kustomize)例が追加されました。</li>
  <li><strong>Razee</strong>: クラスター内のデプロイメント情報を視覚化し、Kubernetes リソースのデプロイメントを自動化するために、[Razee ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/razee-io/Razee) がサポートされる統合に追加されました。 </li></ul>
  </td>
</tr>
</tbody></table>


## 2019 年 5 月
{: #may19}

<table summary="この表は、リリース・ノートを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>{{site.data.keyword.containerlong_notm}} の資料の更新 (2019 年 5 月)</caption>
<thead>
<th>日</th>
<th>説明</th>
</thead>
<tbody>
<tr>
  <td>2019 年 5 月 30 日</td>
  <td><ul>
  <li><strong>CLI リファレンス</strong>: {{site.data.keyword.containerlong_notm}} CLI プラグインの[バージョン 0.3.33 のリリース](/docs/containers?topic=containers-cs_cli_changelog)に対する複数の変更を反映するように [CLI リファレンス・ページ](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli)が更新されました。</li>
  <li><strong>ストレージのトラブルシューティング</strong>: <ul>
  <li>[PVC 保留状態](/docs/containers?topic=containers-cs_troubleshoot_storage#file_pvc_pending)に関するファイルおよびブロック・ストレージのトラブルシューティングのトピックが追加されました。</li>
  <li>[アプリが PVC にアクセスできない、または PVC に書き込むことができない](/docs/containers?topic=containers-cs_troubleshoot_storage#block_app_failures)場合のブロック・ストレージのトラブルシューティング・トピックが追加されました。</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 5 月 28 日</td>
  <td><ul>
  <li><strong>クラスター・アドオンの変更ログ</strong>: [ALB `nginx-ingress` イメージがビルド 462 に](/docs/containers?topic=containers-cluster-add-ons-changelog)更新されました。</li>
  <li><strong>レジストリーのトラブルシューティング</strong>: クラスター作成時にエラーが発生したためにクラスターが {{site.data.keyword.registryfull}} からイメージをプルできない場合の[トラブルシューティング・トピック](/docs/containers?topic=containers-cs_troubleshoot_clusters#ts_image_pull_create)が追加されました。
  </li>
  <li><strong>ストレージのトラブルシューティング</strong>: <ul>
  <li>[永続ストレージ障害のデバッグ](/docs/containers?topic=containers-cs_troubleshoot_storage#debug_storage)に関するトピックが追加されました。</li>
  <li>[許可の欠落による PVC 作成の失敗](/docs/containers?topic=containers-cs_troubleshoot_storage#missing_permissions)に関するトラブルシューティング・トピックが追加されました。</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 5 月 23 日</td>
  <td><ul>
  <li><strong>CLI リファレンス</strong>: {{site.data.keyword.containerlong_notm}} CLI プラグインの[バージョン 0.3.28 のリリース](/docs/containers?topic=containers-cs_cli_changelog)に対する複数の変更を反映するように [CLI リファレンス・ページ](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli)が更新されました。</li>
  <li><strong>クラスター・アドオンの変更ログ</strong>: [ALB `nginx-ingress` イメージがビルド 457 に](/docs/containers?topic=containers-cluster-add-ons-changelog)更新されました。</li>
  <li><strong>クラスターおよびワーカーの状態</strong>: [ロギングおよびモニタリングのページ](/docs/containers?topic=containers-health#states)が更新され、クラスターおよびワーカー・ノードの状態に関する参照表が追加されました。</li>
  <li><strong>クラスターの計画および作成</strong>: 以下のページで、クラスターの計画、作成、および削除とネットワークの計画に関する情報を見つけることができるようになりました。
    <ul><li>[クラスター・ネットワークのセットアップの計画](/docs/containers?topic=containers-plan_clusters)</li>
    <li>[高可用性のためのクラスターの計画](/docs/containers?topic=containers-ha_clusters)</li>
    <li>[ワーカー・ノードのセットアップの計画](/docs/containers?topic=containers-planning_worker_nodes)</li>
    <li>[クラスターの作成](/docs/containers?topic=containers-clusters)</li>
    <li>[クラスターへのワーカー・ノードとゾーンの追加](/docs/containers?topic=containers-add_workers)</li>
    <li>[クラスターの削除](/docs/containers?topic=containers-remove)</li>
    <li>[サービス・エンドポイントまたは VLAN 接続の変更](/docs/containers?topic=containers-cs_network_cluster)</li></ul>
  </li>
  <li><strong>クラスター・バージョンの更新</strong>: マスター・バージョンがサポートされる最も古いバージョンより 3 つ以上前のバージョンである場合はクラスターを更新できないことを示すように[サポートされないバージョンのポリシー](/docs/containers?topic=containers-cs_versions)が更新されました。 クラスターが**サポートされていない**かどうかを確認するには、クラスターをリストするときに**「状態」**フィールドを確認します。</li>
  <li><strong>Istio</strong>: [Istio ページ](/docs/containers?topic=containers-istio)が更新され、プライベート VLAN のみに接続されたクラスターでは Istio が機能しないという制限が削除されました。 Istio 管理対象アドオンの更新が完了した後に TLS セクションを使用する Istio ゲートウェイを再作成するためのステップが、[管理対象アドオンの更新に関するトピック](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons)に追加されました。</li>
  <li><strong>よく閲覧されたトピック</strong>: よく閲覧されたトピックは、{{site.data.keyword.containershort_notm}} に固有の新機能と更新に関するこのリリース・ノート・ページに置き換えられました。 {{site.data.keyword.cloud_notm}} 製品の最新情報については、[発表](https://www.ibm.com/cloud/blog/announcements)を確認してください。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 5 月 20 日</td>
  <td><ul>
  <li><strong>バージョンの変更ログ</strong>: [ワーカー・ノードのフィックスパックの変更ログ](/docs/containers?topic=containers-changelog)が追加されました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 5 月 16 日</td>
  <td><ul>
  <li><strong>CLI reference</strong>: [CLI リファレンス・ページ](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli)が更新されて、`logging-collect` コマンドの COS エンドポイントが追加され、`apiserver-refresh` によって Kubernetes マスター・コンポーネントが再始動されることが明記されました。</li>
  <li><strong>非サポート: Kubernetes バージョン 1.10</strong>: [Kubernetes バージョン 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) はサポートされなくなりました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 5 月 15 日</td>
  <td><ul>
  <li><strong>デフォルトの Kubernetes バージョン</strong>: デフォルトの Kubernetes バージョンは 1.13.6 になりました。</li>
  <li><strong>サービス制限</strong>: [サービス制限のトピック](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits)が追加されました。</li>
  </ul></td>
</tr>
<tr>
  <td>2019 年 5 月 13 日</td>
  <td><ul>
  <li><strong>バージョンの変更ログ</strong>: [1.14.1_1518](/docs/containers?topic=containers-changelog#1141_1518)、[1.13.6_1521](/docs/containers?topic=containers-changelog#1136_1521)、[1.12.8_1552](/docs/containers?topic=containers-changelog#1128_1552)、[1.11.10_1558](/docs/containers?topic=containers-changelog#11110_1558)、および [1.10.13_1558](/docs/containers?topic=containers-changelog#11013_1558) で新しいパッチ更新が使用可能になったことが追加されました。</li>
  <li><strong>ワーカー・ノード・フレーバー</strong>: [クラウド状況 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/status?component=containers-kubernetes&selected=status) ごとに 48 以上のコアであるすべての[仮想マシン・ワーカー・ノード・フレーバー](/docs/containers?topic=containers-planning_worker_nodes#vm)が削除されました。 引き続き、48 以上のコアを持つ[ベアメタル・ワーカー・ノード](/docs/containers?topic=containers-plan_clusters#bm)をプロビジョンできます。</li></ul></td>
</tr>
<tr>
  <td>2019 年 5 月 8 日</td>
  <td><ul>
  <li><strong>API</strong>: [グローバル API swagger の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://containers.cloud.ibm.com/global/swagger-global-api/#/) へのリンクが追加されました。</li>
  <li><strong>Cloud Object Storage</strong>: {{site.data.keyword.containerlong_notm}} クラスター内の [Cloud Object Storage に関するトラブルシューティング・ガイドが追加されました](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending)。</li>
  <li><strong>Kubernetes 戦略</strong>: [アプリを {{site.data.keyword.containerlong_notm}} に移動する前に持っていると好ましい知識および技術スキル](/docs/containers?topic=containers-strategy#knowledge)に関するトピックが追加されました。</li>
  <li><strong>Kubernetes バージョン 1.14</strong>: [Kubernetes 1.14 リリース](/docs/containers?topic=containers-cs_versions#cs_v114)が認定されたことが追加されました。</li>
  <li><strong>リファレンス・トピック</strong>: [ユーザー・アクセス](/docs/containers?topic=containers-access_reference)と [CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) のリファレンス・ページで、さまざまなサービス・バインディング、`logging`、および `nlb` 操作に関する情報が更新されました。</li></ul></td>
</tr>
<tr>
  <td>2019 年 5 月 7 日</td>
  <td><ul>
  <li><strong>クラスター DNS プロバイダー</strong>: Kubernetes 1.14 以降を実行するクラスターでは CoreDNS のみサポートされるようになったため、[CoreDNS の利点が説明されています](/docs/containers?topic=containers-cluster_dns)。</li>
  <li><strong>エッジ・ノード</strong>: [エッジ・ノード](/docs/containers?topic=containers-edge)に対するプライベート・ロード・バランサー・サポートが追加されました。</li>
  <li><strong>フリー・クラスター</strong>: [フリー・クラスター](/docs/containers?topic=containers-regions-and-zones#regions_free)がサポートされる場所が明記されました。</li>
  <li><strong>新着情報! 統合</strong>: [{{site.data.keyword.cloud_notm}} サービスとサード・パーティーの統合](/docs/containers?topic=containers-ibm-3rd-party-integrations)、[一般的な統合](/docs/containers?topic=containers-supported_integrations)、および[パートナーシップ](/docs/containers?topic=containers-service-partners)に関する情報が追加され、再編成されました。</li>
  <li><strong>新着情報! Kubernetes version 1.14</strong>: クラスターを作成するか、[Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114) に更新します。</li>
  <li><strong>非推奨 Kubernetes バージョン 1.11</strong>: [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) をサポートされなくなる前に実行していたクラスターを[更新](/docs/containers?topic=containers-update)します。</li>
  <li><strong>許可</strong>: FAQ、[クラスター・ユーザーには、どのようなアクセス・ポリシーを付与しますか?](/docs/containers?topic=containers-faqs#faq_access) が追加されました。</li>
  <li><strong>ワーカー・プール</strong>: [既存のワーカー・プールにラベルを適用](/docs/containers?topic=containers-add_workers#worker_pool_labels)する方法に関する説明が追加されました。</li>
  <li><strong>リファレンス・トピック</strong>: Kubernetes 1.14 などの新機能をサポートするために、[変更ログ](/docs/containers?topic=containers-changelog#changelog)の参照ページが更新されました。</li></ul></td>
</tr>
<tr>
  <td>2019 年 5 月 1 日</td>
  <td><strong>インフラストラクチャー・アクセスの割り当て</strong>: [サポート・ケースを開くための IAM 許可を割り当てるステップ](/docs/containers?topic=containers-users#infra_access)が修正されました。</td>
</tr>
</tbody></table>


