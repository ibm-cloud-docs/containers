---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# ユーザー・アクセス許可
{: #understanding}



[クラスター許可を割り当てる](cs_users.html)とき、ユーザーにどの役割を割り当てる必要があるか判断が難しい場合があります。以下のセクションの表を使用して、{{site.data.keyword.containerlong}} で一般的な作業を実行するために最低限必要な許可レベルを判別してください。
{: shortdesc}

## IAM プラットフォームと Kubernetes RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}} は、{{site.data.keyword.Bluemix_notm}} の IAM (ID およびアクセス管理) 役割を使用するように構成されています。IAM プラットフォーム役割によって、クラスターでユーザーが実行できるアクションが決まります。IAM プラットフォーム役割が割り当てられたユーザーには必ず、デフォルトの名前空間での対応する Kubernetes 役割ベース・アクセス制御 (RBAC) 役割も自動的に割り当てられます。さらに、IAM プラットフォーム役割により、ユーザーの基本的なインフラストラクチャー許可が自動的に設定されます。IAM ポリシーを設定するには、[IAM プラットフォーム許可の割り当て](cs_users.html#platform)を参照してください。RBAC 役割について詳しくは、[RBAC 許可の割り当て](cs_users.html#role-binding)を参照してください。

次の表は、各 IAM プラットフォーム役割によって付与されるクラスター管理許可と、対応する RBAC 役割での Kubernetes リソース許可を示しています。

<table>
  <tr>
    <th>IAM プラットフォーム役割</th>
    <th>クラスター管理許可</th>
    <th>対応する RBAC 役割とリソース許可</th>
  </tr>
  <tr>
    <td>**Viewer**</td>
    <td>
      クラスター:<ul>
        <li>リソース・グループおよび地域の IAM API キーの所有者の名前と E メール・アドレスの表示</li>
        <li>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするために {{site.data.keyword.Bluemix_notm}} アカウントで複数の異なる資格情報を使用する場合は、インフラストラクチャー・ユーザー名の表示</li>
        <li>すべてのクラスター、ワーカー・ノード、ワーカー・プール、クラスター内のサービス、Webhook のリスト表示または詳細の表示</li>
        <li>インフラストラクチャー・アカウントの VLAN スパンニング状況の表示</li>
        <li>インフラストラクチャー・アカウントで使用可能なサブネットのリスト表示</li>
        <li>1 つのクラスターに対して設定された場合: ゾーン内のクラスター接続先 VLAN のリスト表示</li>
        <li>このアカウントに属するすべてのクラスターに対して設定された場合: ゾーン内の使用可能なすべての VLAN のリスト表示</li></ul>
      ロギング:<ul>
        <li>ターゲット地域のデフォルトのロギング・エンドポイントの表示</li>
        <li>ログ転送構成とログ・フィルタリング構成のリスト表示または詳細の表示</li>
        <li>Fluentd アドオンの自動更新の状況の表示</li></ul>
      Ingress:<ul>
        <li>クラスター内のすべての ALB のリスト表示または詳細の表示</li>
        <li>この地域でサポートされている ALB のタイプを表示します</li></ul>
    </td>
    <td><code>ibm-view</code> 役割バインディングによって <code>view</code> クラスター役割が適用され、<code>default</code> 名前空間で以下の許可が付与されます。<ul>
      <li>デフォルトの名前空間内にあるリソースに対する読み取りアクセス</li>
      <li>Kubernetes シークレットに対する読み取りアクセス権限はなし</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Editor** <br/><br/><strong>ヒント</strong>: アプリ開発者にはこの役割を使用し、<a href="#cloud-foundry">Cloud Foundry</a> **Developer** 役割を割り当ててください。</td>
    <td>この役割には、ビューアー役割におけるすべての許可に加えて、以下が許可されます。</br></br>
      クラスター:<ul>
        <li>クラスターへの {{site.data.keyword.Bluemix_notm}} サービスのバインドとアンバインド</li></ul>
      ロギング:<ul>
        <li>API サーバー監査 Webhook の作成、更新、削除</li>
        <li>クラスター Webhook の作成</li>
        <li>`kube-audit` を除くすべてのタイプのログ転送構成の作成と削除</li>
        <li>ログ転送構成の更新とリフレッシュ</li>
        <li>ログ・フィルタリング構成の作成、更新、削除</li></ul>
      Ingress:<ul>
        <li>ALB の有効化または無効化</li></ul>
    </td>
    <td><code>ibm-edit</code> 役割バインディングによって <code>edit</code> クラスター役割が適用され、<code>default</code> 名前空間で以下の許可が付与されます。
      <ul><li>デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li></ul></td>
  </tr>
  <tr>
    <td>**Operator**</td>
    <td>この役割には、ビューアー役割におけるすべての許可に加えて、以下が許可されます。</br></br>
      クラスター:<ul>
        <li>クラスターの更新</li>
        <li>Kubernetes マスターのリフレッシュ</li>
        <li>ワーカー・ノードを追加および削除する</li>
        <li>ワーカー・ノードのリブート、再ロード、更新</li>
        <li>ワーカー・プールの作成と削除</li>
        <li>ワーカー・プール内のゾーンの追加と削除</li>
        <li>ワーカー・プール内のある特定のゾーンのネットワーク構成の更新</li>
        <li>ワーカー・プールのサイズ変更と再バランス</li>
        <li>クラスター内のサブネットの作成と追加</li>
        <li>クラスター内のユーザー管理サブネットの追加と削除</li></ul>
    </td>
    <td><code>ibm-operate</code> クラスター役割バインディングによって <code>admin</code> クラスター役割が適用され、以下の許可が付与されます。<ul>
      <li>名前空間自体ではなく、名前空間内にあるリソースに対する読み取り/書き込みアクセス</li>
      <li>名前空間内で RBAC 役割を作成する</li></ul></td>
  </tr>
  <tr>
    <td>**管理者**</td>
    <td>この役割には、このアカウントに属するすべてのクラスターに対するエディター、オペレーター、ビューアーの役割におけるすべての許可に加えて、以下が許可されます。</br></br>
      クラスター:<ul>
        <li>フリー・クラスターと標準クラスターの作成</li>
        <li>クラスターの削除</li>
        <li>{{site.data.keyword.keymanagementservicefull}} を使用した Kubernetes シークレットの暗号化</li>
        <li>リンクされた IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするための {{site.data.keyword.Bluemix_notm}} アカウントの API キーの設定</li>
        <li>別の IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするための {{site.data.keyword.Bluemix_notm}} アカウントのインフラストラクチャー資格情報の設定、表示、削除</li>
        <li>このアカウントに属する他の既存ユーザーの IAM プラットフォーム役割の割り当てと変更</li>
        <li>すべての地域のすべての {{site.data.keyword.containerlong_notm}} インスタンス (クラスター) に対して設定された場合: このアカウントに属する使用可能なすべての VLAN のリスト表示</ul>
      ロギング:<ul>
        <li>`kube-audit` タイプのログ転送構成の作成と更新</li>
        <li>{{site.data.keyword.cos_full_notm}} バケット内の API サーバー・ログのスナップショットの収集</li>
        <li>Fluentd クラスター・アドオンの自動更新の有効化と無効化</li></ul>
      Ingress:<ul>
        <li>クラスター内のすべての ALB シークレットのリスト表示または詳細の表示</li>
        <li>{{site.data.keyword.cloudcerts_long_notm}} インスタンスから ALB への証明書のデプロイ</li>
        <li>クラスター内の ALB シークレットの更新または削除</li></ul>
      <strong>注</strong>: マシン、VLAN、サブネットなどのリソースを作成するには、管理者ユーザーに**スーパーユーザー**・インフラストラクチャー役割が必要です。
    </td>
    <td><code>ibm-admin</code> クラスター役割バインディングによって <code>cluster-admin</code> クラスター役割が適用され、以下の許可が付与されます。
      <ul><li>すべての名前空間内にあるリソースに対する読み取り/書き込みアクセス</li>
      <li>名前空間内で RBAC 役割を作成する</li>
      <li>Kubernetes ダッシュボードにアクセスする</li>
      <li>アプリをだれでも利用できるようにする Ingress リソースを作成する</li></ul>
    </td>
  </tr>
</table>



## Cloud Foundry の役割
{: #cloud-foundry}

Cloud Foundry の役割は、このアカウントに属する組織およびスペースにアクセス権限を付与します。{{site.data.keyword.Bluemix_notm}} の Cloud Foundry ベースのサービスのリストを表示するには、`ibmcloud service list` を実行します。詳しくは、IAM 資料に記載されている、使用可能なすべての[組織およびスペース役割](/docs/iam/cfaccess.html)、または [Cloud Foundry アクセス権限を管理する](/docs/iam/mngcf.html)ためのステップを参照してください。

次の表は、クラスター・アクション許可に必要な Cloud Foundry 役割を示しています。

<table>
  <tr>
    <th>Cloud Foundry 役割</th>
    <th>クラスター管理許可</th>
  </tr>
  <tr>
    <td>スペースの役割: 管理者</td>
    <td>{{site.data.keyword.Bluemix_notm}} スペースに対するユーザー・アクセスを管理する</td>
  </tr>
  <tr>
    <td>スペースの役割: 開発者</td>
    <td>
      <ul><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスを作成する</li>
      <li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターにバインドする</li>
      <li>クラスターのログ転送構成からのログをスペース・レベルで表示する</li></ul>
    </td>
  </tr>
</table>

## インフラストラクチャー役割
{: #infra}

**注**: **スーパーユーザー**・インフラストラクチャー・アクセス役割を持つユーザーが[地域とリソース・グループの API キーを設定する](cs_users.html#api_key)と、このアカウントに属する他のユーザーのインフラストラクチャー許可が IAM プラットフォーム役割によって設定されます。他のユーザーの IBM Cloud インフラストラクチャー (SoftLayer) 許可を編集する必要はありません。API キーを設定するユーザーに**スーパーユーザー**を割り当てることができない場合のみ、次の表を使用して、ユーザーの IBM Cloud インフラストラクチャー (SoftLayer) 許可をカスタマイズしてください。詳しくは、[インフラストラクチャー許可のカスタマイズ](cs_users.html#infra_access)を参照してください。

次の表は、一般的な作業グループを完了するために必要なインフラストラクチャー許可を示しています。

<table summary="一般的な {{site.data.keyword.containerlong_notm}} シナリオに必要なインフラストラクチャー許可。">
 <caption>一般的に必要な {{site.data.keyword.containerlong_notm}} のインフラストラクチャー許可</caption>
 <thead>
  <th>{{site.data.keyword.containerlong_notm}} の一般的な作業</th>
  <th>必要なインフラストラクチャー許可 (タブ別)</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>最小許可</strong>: <ul><li>クラスターを作成します。</li></ul></td>
     <td><strong>デバイス</strong>:<ul><li>Virtual Server の詳細の表示</li><li>サーバーのリブートと IPMI システム情報の表示</li><li>OS 再ロードの発行とレスキュー・カーネルの開始</li></ul><strong>アカウント</strong>: <ul><li>サーバーの追加</li></ul></td>
   </tr>
   <tr>
     <td><strong>クラスター管理</strong>: <ul><li>クラスターを作成、更新、削除する。</li><li>ワーカー・ノードを追加、再ロード、リブートする。</li><li>VLAN を表示する。</li><li>サブネットを作成する。</li><li>ポッドとロード・バランサー・サービスをデプロイする。</li></ul></td>
     <td><strong>サポート</strong>:<ul><li>チケットの表示</li><li>チケットの追加</li><li>チケットの編集</li></ul>
     <strong>デバイス</strong>:<ul><li>ハードウェアの詳細の表示</li><li>Virtual Server の詳細の表示</li><li>サーバーのリブートと IPMI システム情報の表示</li><li>OS 再ロードの発行とレスキュー・カーネルの開始</li></ul>
     <strong>ネットワーク</strong>:<ul><li>パブリック・ネットワーク・ポートのコンピュートを追加</li></ul>
     <strong>アカウント</strong>:<ul><li>サーバーのキャンセル</li><li>サーバーの追加</li></ul></td>
   </tr>
   <tr>
     <td><strong>ストレージ</strong>: <ul><li>永続ボリューム請求を作成して永続ボリュームをプロビジョンする。</li><li>ストレージ・インフラストラクチャー・リソースを作成および管理する。</li></ul></td>
     <td><strong>サービス</strong>:<ul><li>ストレージの管理</li></ul><strong>アカウント</strong>:<ul><li>ストレージの追加</li></ul></td>
   </tr>
   <tr>
     <td><strong>プライベート・ネットワーキング</strong>: <ul><li>クラスター内ネットワーキング用プライベート VLAN を管理する。</li><li>プライベート・ネットワークへの VPN 接続をセットアップする。</li></ul></td>
     <td><strong>ネットワーク</strong>:<ul><li>ネットワーク・サブネット経路の管理</li></ul></td>
   </tr>
   <tr>
     <td><strong>パブリック・ネットワーキング</strong>:<ul><li>アプリを公開するためにパブリック・ロード・バランサーまたは Ingress ネットワーキングをセットアップする。</li></ul></td>
     <td><strong>デバイス</strong>:<ul><li>ホスト名/ドメインの編集</li><li>ポート・コントロールの管理</li></ul>
     <strong>ネットワーク</strong>:<ul><li>パブリック・ネットワーク・ポートのコンピュートを追加</li><li>ネットワーク・サブネット経路の管理</li><li>IP アドレスの追加</li></ul>
     <strong>サービス</strong>:<ul><li>DNS、リバース DNS、WHOIS の管理</li><li>証明書 (SSL) の表示</li><li>証明書 (SSL) の管理</li></ul></td>
   </tr>
 </tbody>
</table>
