---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# {{site.data.keyword.containerlong_notm}} を使用する理由
{: #cs_ov}

{{site.data.keyword.containerlong}} では、Docker コンテナー、Kubernetes テクノロジー、直観的なユーザー・エクスペリエンス、標準装備のセキュリティーと分離機能を結合させることにより、コンピュート・ホストのクラスター内でコンテナー化アプリのデプロイメント、操作、スケーリング、モニタリングを自動化する強力なツールが提供されます。 認定情報については、[Compliance on the {{site.data.keyword.Bluemix_notm}} [外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")(https://www.ibm.com/cloud/compliance)] を参照してください。
{:shortdesc}


## サービスを使用する利点
{: #benefits}

クラスターは、ネイティブの Kubernetes と {{site.data.keyword.IBM_notm}} に固有の機能を提供するコンピュート・ホストにデプロイされます。
{:shortdesc}

|利点|説明|
|-------|-----------|
|コンピュート、ネットワーク、およびストレージそれぞれのインフラストラクチャーを分離する、単一テナントの Kubernetes クラスター|<ul><li>組織の要件に適合する、カスタマイズされた独自のインフラストラクチャーを作成できる。</li><li>IBM Cloud インフラストラクチャー (SoftLayer) によって提供されるリソースを使用して、機密保護機能のある専用の Kubernetes マスター、ワーカー・ノード、仮想ネットワーク、そしてストレージをプロビジョンできる。</li><li>クラスターを使用可能にしておくために {{site.data.keyword.IBM_notm}} によって継続的にモニターされて更新される、完全に管理された Kubernetes マスターを利用できる。</li><li>トラステッド・コンピューティングを使用するベア・メタル・サーバーとしてワーカー・ノードをプロビジョンできるオプションがある。</li><li>統合されたセキュアなボリューム・サービスによって、永続データを保管し、Kubernetes ポッド間でデータを共有し、必要に応じてデータを復元することができる。</li><li>すべてのネイティブ Kubernetes API をフルサポートすることによる利点。</li></ul>|
| 高可用性を高めるマルチゾーン・クラスター | <ul><li>ワーカー・プールを使用して、同じマシン・タイプ (CPU、メモリー、仮想または物理) のワーカー・ノードを容易に管理する。</li><li>選択したマルチゾーンにノードを均等に分散させ、アプリのアンチアフィニティー・ポッド・デプロイメントを使用して、ゾーン障害から保護する。</li><li>別のクラスターにリソースを重複させるのではなく、マルチゾーン・クラスターを使用して、コストを削減する。</li><li>クラスターの各ゾーンに自動的にセットアップされるマルチゾーン・ロード・バランサー (MZLB) を使用するアプリの自動ロード・バランシングによる利点。</li></ul>|
|Vulnerability Advisor によるイメージ・セキュリティー・コンプライアンス|<ul><li>保護された Docker プライベート・イメージ・レジストリーに独自のリポジトリーをセットアップでき、ここにイメージが格納され、組織内のすべてのユーザーによって共有される。</li><li>プライベート {{site.data.keyword.Bluemix_notm}} レジストリー内のイメージを自動スキャンすることによる利点。</li><li>イメージ内で使用されるオペレーティング・システムに固有の推奨を確認して、潜在的な脆弱性を修正できる。</li></ul>|
|クラスターの正常性に関する継続的なモニター|<ul><li>クラスター・ダッシュボードを使用して、クラスター、ワーカー・ノード、およびコンテナー・デプロイメントの正常性を素早く参照して管理できる。</li><li>{{site.data.keyword.monitoringlong}}を使用して詳細な使用量メトリックを確認し、ワークロードに合わせてクラスターを素早く拡張することができる。</li><li>{{site.data.keyword.loganalysislong}}を使用してロギング情報を参照して、クラスター・アクティビティーの詳細を確認できる。</li></ul>|
|アプリにパブリック・アクセスできるよう安全に公開する|<ul><li>インターネットからクラスター内のサービスにアクセスする方法を、パブリック IP アドレス、{{site.data.keyword.IBM_notm}} 提供の経路、独自のカスタム・ドメインの中から選択できる。</li></ul>|
|{{site.data.keyword.Bluemix_notm}} サービスの統合|<ul><li>Watson API、Blockchain、データ・サービス、モノのインターネットなどの {{site.data.keyword.Bluemix_notm}} サービスを統合してアプリに付加的な機能を追加する。</li></ul>|
{: caption="{{site.data.keyword.containerlong_notm}} の利点" caption-side="top"}

さあ始めましょう。 [Kubernetes クラスターを作成するチュートリアル](cs_tutorials.html#cs_cluster_tutorial)を参照してください。

<br />


## オファーとそれらの組み合わせの比較
{: #differentiation}

{{site.data.keyword.containerlong_notm}} は、{{site.data.keyword.Bluemix_notm}} Public、Dedicated、{{site.data.keyword.Bluemix_notm}} Private、またはハイブリッド構成で実行できます。
{:shortdesc}


<table>
<caption>{{site.data.keyword.containerlong_notm}} の各構成の相違点</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>{{site.data.keyword.containerlong_notm}} 構成</th>
 <th>説明</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Public
 </td>
 <td>[共有ハードウェアまたは専用ハードウェア、あるいはベア・メタル・マシン上の](cs_clusters_planning.html#shared_dedicated_node) {{site.data.keyword.Bluemix_notm}} Public では、{{site.data.keyword.containerlong_notm}} を使用してクラウド上のクラスターでアプリをホストできます。 また、複数のゾーンのワーカー・プールを使用するクラスターを作成して、アプリの高可用性を向上させることもできます。 {{site.data.keyword.Bluemix_notm}} Public の {{site.data.keyword.containerlong_notm}} では、Docker コンテナー、Kubernetes テクノロジー、直観的なユーザー・エクスペリエンス、標準装備のセキュリティーと分離機能を結合させることにより、コンピュート・ホストのクラスター内でコンテナー化アプリのデプロイメント、操作、スケーリング、モニタリングを自動化する強力なツールが提供されます。<br><br>詳しくは、[{{site.data.keyword.containerlong_notm}} テクノロジー](cs_tech.html)を参照してください。
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated は、クラウド上で {{site.data.keyword.Bluemix_notm}} Public と同じ {{site.data.keyword.containerlong_notm}} 機能を提供します。 ただし、{{site.data.keyword.Bluemix_notm}} Dedicated アカウントを使用する場合、使用可能な[物理リソースはお客様のクラスター専用であり](cs_clusters_planning.html#shared_dedicated_node)、{{site.data.keyword.IBM_notm}} の他のお客様のクラスターと共有されません。 クラスターや使用する他の {{site.data.keyword.Bluemix_notm}} サービスのために分離が必要な場合は、{{site.data.keyword.Bluemix_notm}} Dedicated 環境のセットアップを選ぶことができます。<br><br>詳しくは、[{{site.data.keyword.Bluemix_notm}} Dedicated でのクラスターの概説](cs_dedicated.html#dedicated)を参照してください。
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Private
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Private は、ユーザー自身のマシン上にローカルにインストールできるアプリケーション・プラットフォームです。 ファイアウォールの内側にあるユーザー独自の制御された環境で、オンプレミスのコンテナー化アプリを開発して管理する必要がある場合は、{{site.data.keyword.Bluemix_notm}} Private で Kubernetes を使用することを選択できます。<br><br>詳しくは、[{{site.data.keyword.Bluemix_notm}} Private の製品資料![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html)を参照してください。
 </td>
 </tr>
 <tr>
 <td>ハイブリッド構成
 </td>
 <td>ハイブリッドとは、{{site.data.keyword.Bluemix_notm}} Public または Dedicated で実行されるサービスと、{{site.data.keyword.Bluemix_notm}} Private 内のアプリなどのオンプレミスで実行される他のサービスを組み合わせて使用することです。 ハイブリッド構成の例を以下に示します。 <ul><li>{{site.data.keyword.Bluemix_notm}} Public で {{site.data.keyword.containerlong_notm}} を使用してクラスターをプロビジョンしながら、そのクラスターを社内データベースに接続する。</li><li>{{site.data.keyword.Bluemix_notm}} Private で {{site.data.keyword.containerlong_notm}} を使用してクラスターをプロビジョンしながら、アプリをそのクラスターにデプロイする。 ただし、そのアプリは {{site.data.keyword.Bluemix_notm}} Public の {{site.data.keyword.ibmwatson}} サービス ({{site.data.keyword.toneanalyzershort}} など) を使用する可能性がある。</li></ul><br>{{site.data.keyword.Bluemix_notm}} Public または Dedicated で実行しているサービスとオンプレミスで実行しているサービスの間の通信を有効にするには、[VPN 接続をセットアップする](cs_vpn.html)必要があります。 詳しくは、[{{site.data.keyword.Bluemix_notm}} Privateでの {{site.data.keyword.containerlong_notm}} の使用 ](cs_hybrid.html) を参照してください。
 </td>
 </tr>
 </tbody>
</table>

<br />


## フリー・クラスターと標準クラスターの比較
{: #cluster_types}

1 つのフリー・クラスターまたは任意の数の標準クラスターを作成できます。 フリー・クラスターを試して、いくつかの Kubernetes 機能を習得することもできますし、標準クラスターを作成して、Kubernetes の機能全体を使用してアプリをデプロイすることもできます。 フリー・クラスターは 30 日後に自動的に削除されます。
{:shortdesc}

フリー・クラスターを使用してから、標準クラスターにアップグレードする場合は、[標準クラスターを作成できます](cs_clusters.html#clusters_ui)。 その後、フリー・クラスターで作成した Kubernetes リソースの任意の YAML を標準クラスターにデプロイします。

|特性|フリー・クラスター|標準クラスター|
|---------------|-------------|-----------------|
|[クラスター内ネットワーキング](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[NodePort サービスによる安定 IP アドレス以外へのパブリック・ネットワーク・アプリ・アクセス](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ユーザー・アクセス管理](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[クラスターとアプリからの {{site.data.keyword.Bluemix_notm}} サービス・アクセス](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[非永続ストレージ用のワーカー・ノードのディスク・スペース](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
| [すべての {{site.data.keyword.containerlong_notm}} 地域でクラスターを作成する機能](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" /> |
|[アプリの高可用性を高めるマルチゾーン・クラスター](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[NFS ファイル・ベースの永続ストレージのボリューム](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ロード・バランサー・サービスによる安定 IP アドレスへのパブリック・ネットワークまたはプライベート・ネットワークのアプリ・アクセス](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[Ingress サービスによる安定 IP アドレスとカスタマイズ可能 URL へのパブリック・ネットワークのアプリ・アクセス](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ポータブル・パブリック IP アドレス](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[ロギングとモニタリング](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[物理 (ベア・メタル) サーバー上にワーカー・ノードをプロビジョンするためのオプション](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[トラステッド・コンピューティングを使用するベア・メタル・ワーカーをプロビジョンするためのオプション](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
|[{{site.data.keyword.Bluemix_dedicated_notm}} で使用可能](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="機能は使用可能" style="width:32px;" />|
{: caption="フリー・クラスターと標準クラスターの特性" caption-side="top"}

<br />


## 価格設定および請求
{: #pricing}

{{site.data.keyword.containerlong_notm}} の価格設定と請求についてよくあるご質問を確認してください。アカウント・レベルのご質問の場合、[請求および使用量の管理の資料](/docs/billing-usage/how_charged.html#charges)を確認してください。アカウントのご使用条件の詳細については、該当する [{{site.data.keyword.Bluemix_notm}} ご利用条件および特記事項](/docs/overview/terms-of-use/notices.html#terms)を参照してください。
{: shortdesc}

### 使用量を表示および編成するにはどうしたらよいですか?
{: #usage}

**請求および使用量を確認するにはどうしたらよいですか?**<br>
使用量および見積もり合計を確認するには、[使用量の表示](/docs/billing-usage/viewing_usage.html#viewingusage)を参照してください。

{{site.data.keyword.Bluemix_notm}} と IBM Cloud インフラストラクチャー (SoftLayer) のアカウントをリンクしている場合は、連結請求を受け取ります。詳しくは、[リンクされたアカウントの連結請求](/docs/billing-usage/linking_accounts.html#unifybillaccounts)を参照してください。

**請求目的でクラウド・リソースをチームまたは部門ごとにグループ化できますか?**<br>
請求を整理するために、[リソース・グループを使用して](/docs/resources/bestpractice_rgs.html#bp_resourcegroups)、クラスターを含む {{site.data.keyword.Bluemix_notm}} リソースをグループに編成できます。

### どのように課金されますか? 課金は時間単位または月単位ですか?
{: #monthly-charges}

課金は、使用するリソースのタイプに応じて異なり、定額制、従量制、段階制、予約制があります。詳しくは、[課金方法](/docs/billing-usage/how_charged.html#charges)を参照してください。

IBM Cloud インフラストラクチャー (SoftLayer) リソースは、{{site.data.keyword.containerlong_notm}} で時間単位または月単位で課金される場合があります。
* 仮想マシン (VM) ワーカー・ノードは、時間単位で課金されます。
* 物理 (ベアメタル) ワーカー・ノードは、{{site.data.keyword.containerlong_notm}} で月単位で課金されるリソースです。
* その他のインフラストラクチャー・リソース (ファイルまたはブロック・ストレージなど) では、リソース作成時に課金を時間単位または月単位のどちらにするかを選択できる場合があります。

月単位のリソースは、月初めをベースにして前月の使用量について課金されます。月の半ばに月単位のリソースを注文した場合、その月については日割り計算した金額が課金されます。ただし、月の半ばにリソースをキャンセルした場合でも、月単位のリソースの 1 カ月分全額が課金されます。

### コストの見積もりは可能ですか?
{: #estimate}

はい、可能です。[コストの見積もり](/docs/billing-usage/estimating_costs.html#cost)および[コスト見積もりツール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/pricing/) を参照してください。アウトバウンド・ネットワーキングなどの、コスト見積もりツールに含まれないコストに関する情報については、続きをお読みください。

### {{site.data.keyword.containerlong_notm}} 使用時の課金内容は?
{: #cluster-charges}

{{site.data.keyword.containerlong_notm}} クラスターを使用して、Watson AI や Compose Database-as-a-Service などのプラットフォーム・サービスで、IBM Cloud インフラストラクチャー (SoftLayer) のコンピュート・リソース、ネットワーキング・リソース、およびストレージ・リソースを使用できます。各リソースは、それぞれ独自に課金される場合があります。
* [ワーカー・ノード](#nodes)
* [アウトバウンド・ネットワーキング](#bandwidth)
* [サブネット IP アドレス](#subnets)
* [ストレージ](#storage)
* [{{site.data.keyword.Bluemix_notm}} サービス](#services)

<dl>
<dt id="nodes">ワーカー・ノード</dt>
  <dd><p>クラスターには、仮想マシンと物理 (ベアメタル) マシンという 2 つの主なワーカー・ノード・タイプがあります。マシン・タイプの可用性および価格設定は、クラスターのデプロイ先のゾーンによって異なります。</p>
  <p><strong>仮想マシン</strong>の特徴は、ベアメタルと比較して柔軟性が高く、プロビジョニング時間が短く、自動スケーラビリティー機能が多い点で、これらをベアメタルよりも高いコスト効率の価格で提供します。ただし、VM は、ベアメタルの仕様と比較して、ネットワーキング Gbps、RAM およびメモリーのしきい値、ストレージ・オプションなど、パフォーマンス上のトレードオフがあります。VM のコストに影響を与える以下のような要因に留意してください。</p>
  <ul><li><strong>共有と専用</strong>: VM の基礎となるハードウェアを共有する場合、専用ハードウェアよりコストは低くなりますが、物理リソースはご使用の VM 専用ではありません。</li>
  <li><strong>時間単位の課金のみ</strong>: 時間単位の場合、より柔軟に VM の迅速な注文やキャンセルを行うことができます。
  <li><strong>月ごとの段階制の時間</strong>: 時間単位の課金は段階制です。課金月内の時間階層に対して VM は注文されたままになるほど、時間単位の課金率が低下します。時間の階層には、0 - 150 時間、151 - 290 時間、291 - 540 時間、および 541 時間以上があります。</li></ul>
  <p><strong>物理マシン (ベアメタル)</strong> は、データ、AI、GPU などのワークロードで高性能を発揮します。また、すべてのハードウェア・リソースは独自のワークロード専用なので、「ノイジー・ネイバー」はありません。ベアメタルのコストに影響を与える以下のような要因に留意してください。</p>
  <ul><li><strong>月単位の課金のみ</strong>: すべてのベアメタルは月単位で課金されます。</li>
  <li><strong>注文処理に時間がかかる</strong>: ベアメタル・サーバーの注文およびキャンセルは、IBM Cloud インフラストラクチャー (SoftLayer) アカウントを使用した手動処理なので、完了までに複数営業日がかかることがあります。</li></ul>
  <p>マシンの仕様について詳しくは、[ワーカー・ノードに使用可能なハードウェア](/docs/containers/cs_clusters_planning.html#shared_dedicated_node)を参照してください。</p></dd>

<dt id="bandwidth">パブリック帯域幅</dt>
  <dd><p>帯域幅とは、世界中のデータ・センター内の {{site.data.keyword.Bluemix_notm}} リソース間で送受信される、インバウンドおよびアウトバウンドのネットワーク・トラフィックのパブリック・データ転送を指します。パブリック帯域幅は、GB 単位で課金されます。現行帯域幅のサマリーは、[{{site.data.keyword.Bluemix_notm}} コンソール](https://console.bluemix.net/)にログインして、メニューから**「インフラストラクチャー」**を選択して、**「ネットワーク」>「帯域幅」>「サマリー」**ページを選択すると確認できます。
  <p>パブリック帯域幅の課金に影響を与える以下のような要因を確認してください。</p>
  <ul><li><strong>場所</strong>: ワーカー・ノードと同様に、課金はリソースのデプロイ先のゾーンに応じて異なります。</li>
  <li><strong>組み込み帯域幅または従量課金</strong>: ワーカー・ノード・マシンは、1 カ月当たりのアウトバウンド・ネットワーキングの特定の割り振りが付属している場合があります (例えば、VM の 250 GB、ベアメタルの 500 GB)。または、割り振りは、GB 使用量に基づく従量課金の場合があります。</li>
  <li><strong>段階制パッケージ</strong>: 組み込み帯域幅を超過した後、場所によって異なる段階制使用量方式に従って課金されます。段階制割り振りを超過すると、標準データ転送料金も課金される場合があります。</li></ul>
  <p>詳しくは、[Bandwidth packages ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/bandwidth) を参照してください。</p></dd>

<dt id="subnets">サブネット IP アドレス</dt>
  <dd><p>標準クラスターを作成すると、8 つのパブリック IP アドレスを持つポータブル・パブリック・サブネットが注文され、月単位でアカウントに課金されます。</p><p>インフラストラクチャー・アカウントに使用可能なサブネットが既にある場合は、これらのサブネットを代わりに使用できます。クラスターを `--no-subnets` [フラグ](cs_cli_reference.html#cs_cluster_create)を使用して作成し、[それらのサブネットを再使用します](cs_subnets.html#custom)。</p>
  </dd>

<dt id="storage">ストレージ</dt>
  <dd>ストレージをプロビジョンする場合、ユース・ケースに適切なストレージ・タイプとストレージ・クラスを選択できます。課金は、ストレージ・タイプ、場所、およびストレージ・インスタンスの仕様に応じて異なります。適切なストレージ・ソリューションを選択するには、[可用性の高い永続ストレージの計画](cs_storage_planning.html#storage_planning)を参照してください。詳しくは、以下を参照してください。
  <ul><li>[NFS ファイル・ストレージの価格設定 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[ブロック・ストレージの価格設定 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[オブジェクト・ストレージ・プラン ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} サービス</dt>
  <dd>クラスターと統合する各サービスには、それぞれ独自の価格設定モデルがあります。詳しくは、各製品資料および[コスト見積もりツール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/pricing/) を参照してください。</dd>

</dl>
