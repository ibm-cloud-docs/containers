---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# よく閲覧された {{site.data.keyword.containerlong_notm}} のトピック
{: #cs_popular_topics}

{{site.data.keyword.containerlong}} の最新情報を確認しましょう。 知っておくべき新機能、試してみたい便利な方法、他の開発者が役に立つと感じている、よく閲覧されたトピックをご覧ください。
{:shortdesc}

## 2018 年 12 月によく閲覧されたトピック
{: #dec18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 12 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>12 月 6 日</td>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>Sysdig をサード・パーティー・サービスとしてワーカー・ノードにデプロイし、メトリックを {{site.data.keyword.monitoringlong}} に転送することで、アプリのパフォーマンスと正常性を可視化して運用することができます。 詳しくは、[Kubernetes クラスターにデプロイされたアプリのメトリックの分析方法](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster)を参照してください。 **注**: Kubernetes バージョン 1.11 以降を実行するクラスターで {{site.data.keyword.mon_full_notm}} を使用する場合、Sysdig は現在 `containerd` をサポートしていないため、すべてのコンテナー・メトリックが収集されるわけではありません。</td>
</tr>
</tbody></table>

## 2018 年 11 月によく閲覧されたトピック
{: #nov18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 11 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>11 月 29 日</td>
<td>[チェンナイのゾーンの提供開始](cs_regions.html)</td>
<td>北アジア太平洋地域のクラスターの新しいゾーンとして、インドのチェンナイが追加されました。 ファイアウォールを使用している場合は、このゾーンと、ご使用のクラスターがある地域内の他のゾーンに対し、必ず[ファイアウォール・ポートを開いてください](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>11 月 27 日</td>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>LogDNA をサード・パーティー・サービスとしてワーカー・ノードにデプロイし、ポッド・コンテナーのログを管理することで、ログ管理機能をクラスターに追加できます。 詳しくは、[{{site.data.keyword.loganalysisfull_notm}} with LogDNA による Kubernetes クラスター・ログの管理](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube) を参照してください。</td>
</tr>
<tr>
<td>11 月 7 日</td>
<td>ロード・バランサー 2.0 (ベータ)</td>
<td>クラスター・アプリをパブリックに安全に公開するために、[ロード・バランサー 1.0 と 2.0](cs_loadbalancer.html#planning_ipvs) の間で選択できるようになりました。</td>
</tr>
<tr>
<td>11 月 7 日</td>
<td>Kubernetes バージョン 1.12 の提供開始</td>
<td>[Kubernetes バージョン  1.12](cs_versions.html#cs_v112) を実行するクラスターに更新またはこれを作成できるようになりました。 1.12 クラスターの Kubernetes マスターは、デフォルトで高可用性です。</td>
</tr>
<tr>
<td>11 月 7 日</td>
<td>Kubernetes バージョン 1.10 を実行するクラスターの高可用性マスター</td>
<td>Kubernetes バージョン 1.10 を実行するクラスターで高可用性マスターを使用できます。 1.11 クラスターに関する過去の情報で説明されているすべてのメリットが 1.10 クラスターに適用されます。また、実行する必要がある[準備手順](cs_versions.html#110_ha-masters)も適用されます。</td>
</tr>
<tr>
<td>11 月 1 日</td>
<td>Kubernetes バージョン 1.11 を実行するクラスターの高可用性マスター</td>
<td>単一ゾーンのマスターは高可用性です。クラスター更新時などの停止を防ぐために、Kubernetes API サーバー、etcd、スケジューラー、およびコントローラー・マネージャー用に別々の物理ホスト上にレプリカが配置されます。 クラスターが複数ゾーン対応ゾーンにある場合は、高可用性マスターも複数ゾーンに分散されるので、ゾーン障害から保護されます。<br>実行する必要があるアクションについては、[高可用性クラスター・マスターへの更新](cs_versions.html#ha-masters)を参照してください。 これらの準備アクションは、以下の場合に適用されます。<ul>
<li>ファイアウォールまたはカスタム Calico ネットワーク・ポリシーがある場合。</li>
<li>ワーカー・ノードでホスト・ポート `2040` または `2041` を使用している場合。</li>
<li>マスターへのクラスター内アクセス用にクラスターのマスター IP アドレスを使用していた場合。</li>
<li>Calico ポリシーの作成などのために、Calico API または CLI (`calicoctl`) を呼び出す自動化機能がある場合。</li>
<li>Kubernetes または Calico ネットワーク・ポリシーを使用して、ポッドからマスターへの発信アクセスを制御している場合。</li></ul></td>
</tr>
</tbody></table>

## 2018 年 10 月によく閲覧されたトピック
{: #oct18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 10 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>10 月 25 日</td>
<td>[ミラノでゾーンが使用可能に](cs_regions.html)</td>
<td>中欧地域の有料クラスターの新しいゾーンとして、イタリアのミラノが加わりました。 これまでミラノは、無料クラスターでのみ使用可能でした。 ファイアウォールを使用している場合は、このゾーンと、ご使用のクラスターがある地域内の他のゾーンに対し、必ず[ファイアウォール・ポートを開いてください](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>10 月 22 日</td>
<td>[新しいロンドン複数ゾーン・ロケーション `lon05`](cs_regions.html#zones)</td>
<td>複数ゾーンの大都市ロンドンは、`lon02` ゾーンから、新しい `lon05` ゾーンに置き換えられました。これは、`lon02` より多くのインフラストラクチャー・リソースを備えています。 新しい複数ゾーン・クラスターを作成するときは、`lon05` を使用してください。 `lon02` を使用した既存のクラスターもサポートされますが、新しい複数ゾーン・クラスターでは代わりに `lon05` を使用する必要があります。</td>
</tr>
<tr>
<td>10 月 5 日</td>
<td>{{site.data.keyword.keymanagementservicefull}} との統合</td>
<td>[{{site.data.keyword.keymanagementserviceshort}} (ベータ) を有効にして](cs_encrypt.html#keyprotect)、クラスター内にある Kubernetes シークレットを暗号化できます。</td>
</tr>
<tr>
<td>10 月 4 日</td>
<td>[{{site.data.keyword.registrylong}} が {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM)](/docs/services/Registry/iam.html#iam) と統合される</td>
<td>{{site.data.keyword.Bluemix_notm}} IAM を使用して、レジストリー・リソースへのアクセス (イメージのプル、プッシュ、作成など) を制御できます。 クラスターを作成するときに、レジストリー・トークンも作成することによって、クラスターがレジストリーと連携できるようにします。 したがって、クラスターを作成するには、アカウント・レベルのレジストリーの**管理者**のプラットフォーム管理役割が必要です。 ご使用のレジストリー・アカウントで {{site.data.keyword.Bluemix_notm}} IAM を有効にするには、[Enabling policy enforcement for existing users](/docs/services/Registry/registry_users.html#existing_users) を参照してください。</td>
</tr>
<tr>
<td>10 月 1 日</td>
<td>[リソース・グループ](cs_users.html#resource_groups)</td>
<td>リソース・グループを使用すると、{{site.data.keyword.Bluemix_notm}} リソースをパイプライン、部門、その他のグループに分離して、アクセス権限の割り当てや使用量の課金に役立てることができます。 {{site.data.keyword.containerlong_notm}} は、`default` グループや、自分で作成した他のリソース・グループでのクラスターの作成をサポートするようになりました。</td>
</tr>
</tbody></table>

## 2018 年 9 月によく閲覧されたトピック
{: #sept18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 9 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>9 月 25 日</td>
<td>[新しいゾーンが使用可能に](cs_regions.html)</td>
<td>アプリのデプロイ先として選択できるオプションが増えました。
<ul><li>サンノゼが、米国南部地域の 2 つの新しいゾーン `sjc03` および `sjc04` として加わりました。 ファイアウォールを使用している場合は、このゾーンと、ご使用のクラスターがある地域内の他のロケーションに対し、必ず[ファイアウォール・ポートを開いてください](cs_firewall.html#firewall)。</li>
<li>北アジア太平洋地域の東京で、2 つの新しい `tok04` および `tok05` ゾーンを使用して、[複数ゾーン・クラスターを作成](cs_clusters_planning.html#multizone)できるようになりました。</li></ul></td>
</tr>
<tr>
<td>9 月 5 日</td>
<td>[オスロでゾーンが使用可能に](cs_regions.html)</td>
<td>中欧地域の新しいゾーンとして、ノルウェーのオスロが加わりました。 ファイアウォールを使用している場合は、このゾーンと、ご使用のクラスターがある地域内の他のロケーションに対し、必ず[ファイアウォール・ポートを開いてください](cs_firewall.html#firewall)。</td>
</tr>
</tbody></table>

## 2018 年 8 月によく閲覧されたトピック
{: #aug18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 8 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>8 月 31 日</td>
<td>{{site.data.keyword.cos_full_notm}} が {{site.data.keyword.containerlong}} と統合される</td>
<td>Kubernetes ネイティブの永続ボリューム請求 (PVC) を使用して、{{site.data.keyword.cos_full_notm}} をクラスターにプロビジョンします。 {{site.data.keyword.cos_full_notm}} は読み取り集中型ワークロードに最適です。また、複数ゾーン・クラスター内の複数のゾーンにデータを保管する場合に使用します。 まず、[{{site.data.keyword.cos_full_notm}} サービス・インスタンスを作成](cs_storage_cos.html#create_cos_service)し、クラスターに [{{site.data.keyword.cos_full_notm}} プラグインをインストール](cs_storage_cos.html#install_cos)します。 </br></br>どのストレージ・ソリューションが正しいかわからない場合: [ここ](cs_storage_planning.html#choose_storage_solution)から開始してデータを分析し、データに適したストレージ・ソリューションを選択します。 </td>
</tr>
<tr>
<td>8 月 14 日</td>
<td>ポッドの優先度を割り当てるためにクラスターを Kubernetes バージョン 1.11 に更新する</td>
<td>クラスターを [Kubernetes バージョン 1.11](cs_versions.html#cs_v111) に更新した後、`containerd` を使用したコンテナー・ランタイムのパフォーマンスの向上や[ポッドへの優先度の割り当て](cs_pod_priority.html#pod_priority)など、新しい機能を利用できます。</td>
</tr>
</tbody></table>

## 2018 年 7 月によく閲覧されたトピック
{: #july18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 7 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>7 月 30 日</td>
<td>[自分の Ingress コントローラーを持ち込む](cs_ingress.html#user_managed)</td>
<td>クラスターの Ingress コントローラーに関して非常に特殊なセキュリティー要件やその他のカスタム要件を持っていますか? そうであれば、デフォルトの代わりに、持ち込みの Ingress コントローラーを実行することができます。</td>
</tr>
<tr>
<td>7 月 10 日</td>
<td>複数ゾーン・クラスターの概要</td>
<td>クラスターの可用性を向上させる必要がありますか? 一部の大都市圏では、複数のゾーンにまたがるクラスターを作成できるようになりました。 詳しくは、[{{site.data.keyword.containerlong_notm}} でのマルチゾーン・クラスターの作成](cs_clusters_planning.html#multizone)を参照してください。</td>
</tr>
</tbody></table>

## 2018 年 6 月によく閲覧されたトピック
{: #june18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 6 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>6 月 13 日</td>
<td>`bx` CLI コマンド名が `ic` CLI に変更されています。</td>
<td>最新バージョンの {{site.data.keyword.Bluemix_notm}} CLI をダウンロードした後は、`bx` ではなく `ic` 接頭部を使用してコマンドを実行するようになります。 例えば、`ibmcloud ks clusters` を実行するとクラスターがリスト表示されます。</td>
</tr>
<tr>
<td>6 月 12 日</td>
<td>[ポッド・セキュリティー・ポリシー](cs_psp.html)</td>
<td>Kubernetes 1.10.3 以降を実行するクラスターでは、ポッド・セキュリティー・ポリシーを構成して、{{site.data.keyword.containerlong_notm}} のポッドの作成および更新をユーザーに許可することができます。</td>
</tr>
<tr>
<td>6 月 6 日</td>
<td>[IBM 提供の Ingress ワイルドカード・サブドメインに対する TLS サポート](cs_ingress.html#wildcard_tls)</td>
<td>2018 年 6 月 6 日以降に作成されたクラスターの場合、IBM 提供の Ingress サブドメインの TLS 証明書はワイルドカード証明書ですので、登録されているワイルドカード・サブドメインに使用できます。 2018 年 6 月 6 日より前に作成されたクラスターの場合、現在の TLS 証明書が更新されるときに、ワイルドカード証明書に更新されます。</td>
</tr>
</tbody></table>

## 2018 年 5 月によく閲覧されたトピック
{: #may18}


<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 5 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>5 月 24 日</td>
<td>[新しい Ingress サブドメイン形式](cs_ingress.html)</td>
<td>5 月 24 日より後に作成されたクラスターには、新しい形式の <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code> で Ingress サブドメインが割り当てられます。 Ingress を使用してアプリを公開する場合、新しいサブドメインを使用してインターネットからアプリにアクセスできます。</td>
</tr>
<tr>
<td>5 月 14 日</td>
<td>[更新: 世界中の GPU ベアメタルへのワークロードのデプロイ](cs_app.html#gpu_app)</td>
<td>クラスター内に[ベアメタルのグラフィックス・プロセッシング・ユニット (GPU) マシン・タイプ](cs_clusters_planning.html#shared_dedicated_node)がある場合、大量の数学的処理が行われるアプリをスケジュールできます。 GPU ワーカー・ノードは、CPU と GPU の両方にわたってアプリのワークロードを処理することで、パフォーマンスを向上させることができます。</td>
</tr>
<tr>
<td>5 月 3 日</td>
<td>[Container Image Security Enforcement (ベータ)](/docs/services/Registry/registry_security_enforce.html#security_enforce)</td>
<td>チームでは、アプリ・コンテナーでプルするイメージを決める際の支援が必要ではありませんか。 コンテナー・イメージを検証してからデプロイできる、Container Image Security Enforcement ベータをお試しください。 Kubernetes 1.9 以降を実行するクラスターで使用可能です。</td>
</tr>
<tr>
<td>5 月 1 日</td>
<td>[コンソールからの Kubernetes ダッシュボードのデプロイ](cs_app.html#cli_dashboard)</td>
<td>ワンクリックで Kubernetes ダッシュボードにアクセスしたいと思ったことはありませんか。 {{site.data.keyword.Bluemix_notm}} コンソールの**「Kubernetes ダッシュボード (Kubernetes Dashboard)」**ボタンをお試しください。</td>
</tr>
</tbody></table>




## 2018 年 4 月によく閲覧されたトピック
{: #apr18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 4 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>4 月 17 日</td>
<td>{{site.data.keyword.Bluemix_notm}} Block Storage</td>
<td>永続データをブロック・ストレージに保存するための {{site.data.keyword.Bluemix_notm}} Block Storage [プラグイン](cs_storage_block.html#install_block)をインストールします。 そして、クラスターのために[ブロック・ストレージを新規作成](cs_storage_block.html#add_block)するか、または[既存のブロック・ストレージを使用](cs_storage_block.html#existing_block)することができます。</td>
</tr>
<tr>
<td>4 月 13 日</td>
<td>[Cloud Foundry アプリをクラスターにマイグレーションするための新しいチュートリアル](cs_tutorials_cf.html#cf_tutorial)</td>
<td>Cloud Foundry アプリをお持ちですか? そのアプリの同じコードを、Kubernetes クラスターで実行されるコンテナーにデプロイする方法を示します。</td>
</tr>
<tr>
<td>4 月 5 日</td>
<td>[ログのフィルタリング](cs_health.html#filter-logs)</td>
<td>特定のログを転送対象から除外することができます。 特定の名前空間、コンテナー名、ログ・レベル、メッセージ・ストリングを基準にしてログを除外できます。</td>
</tr>
</tbody></table>

## 2018 年 3 月によく閲覧されたトピック
{: #mar18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 3 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>3 月 16 日</td>
<td>[トラステッド・コンピューティングを使用するベア・メタル・クラスターのプロビジョン](cs_clusters_planning.html#shared_dedicated_node)</td>
<td>[Kubernetes バージョン 1.9](cs_versions.html#cs_v19) 以降を実行するベア・メタル・クラスターを作成し、トラステッド・コンピューティングを有効にしてワーカー・ノードが改ざんされていないことを検証できます。</td>
</tr>
<tr>
<td>3 月 14 日</td>
<td>[{{site.data.keyword.appid_full}} による安全なサインイン](cs_integrations.html#appid)</td>
<td>ユーザーに対してサインインを要求することにより、{{site.data.keyword.containerlong_notm}} で実行されるアプリのセキュリティーを強化します。</td>
</tr>
<tr>
<td>3 月 13 日</td>
<td>[サンパウロで使用可能なゾーン](cs_regions.html)</td>
<td>米国南部地域の新しいゾーンとしてブラジルのサンパウロが追加されました。 ファイアウォールを使用している場合は、このゾーンと、ご使用のクラスターがある地域内の他のロケーションに対し、必ず[ファイアウォール・ポートを開いてください](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>3 月 12 日</td>
<td>トライアル・アカウントで [{{site.data.keyword.Bluemix_notm}} に参加したばかりですか? 無料の Kubernetes クラスターをお試しください。](container_index.html#clusters)</td>
<td>トライアルの [{{site.data.keyword.Bluemix_notm}} アカウント](https://console.bluemix.net/registration/)で、無料クラスターを 1 つデプロイして、30 日間 Kubernetes の機能をテストできます。</td>
</tr>
</tbody></table>

## 2018 年 2 月によく閲覧されたトピック
{: #feb18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 2 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<tr>
<td>2 月 27 日</td>
<td>ワーカー・ノード用のハードウェア仮想マシン (HVM) のイメージ</td>
<td>HVM イメージを使用して、ワークロードの入出力パフォーマンスを向上させます。 `ibmcloud ks worker-reload` [コマンド](cs_cli_reference.html#cs_worker_reload)または `ibmcloud ks worker-update` [コマンド](cs_cli_reference.html#cs_worker_update)を使用して、既存の各ワーカー・ノード上でアクティブ化します。</td>
</tr>
<tr>
<td>2 月 26 日</td>
<td>[KubeDNS 自動スケーリング](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS は、クラスターの拡大に合わせてスケーリングされるようになりました。 スケーリングの比率は、コマンド `kubectl -n kube-system edit cm kube-dns-autoscaler` を使用して調整できます。</td>
</tr>
<tr>
<td>2 月 23 日</td>
<td>Web コンソールでの[ロギング](cs_health.html#view_logs)および[メトリック](cs_health.html#view_metrics)の表示</td>
<td>改善された Web UI を使用して、クラスターとそのコンポーネントのログとメトリック・データを簡単に表示できます。 アクセス方法については、クラスターの詳細ページを参照してください。</td>
</tr>
<tr>
<td>2 月 20 日</td>
<td>暗号化されたイメージと[署名された信頼できるコンテンツ](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>{{site.data.keyword.registryshort_notm}} では、イメージをレジストリー名前空間に保管する際に、イメージに署名して暗号化することで、イメージの保全性を確保できます。 コンテナー・インスタンスは、信頼できるコンテンツのみを使用して実行してください。</td>
</tr>
<tr>
<td>2 月 19 日</td>
<td>[strongSwan IPSec VPN のセットアップ](cs_vpn.html#vpn-setup)</td>
<td>strongSwan IPSec VPN Helm チャートを素早くデプロイして、Virtual Router Appliance なしで {{site.data.keyword.containerlong_notm}} クラスターをオンプレミス・データ・センターに安全に接続します。</td>
</tr>
<tr>
<td>2 月 14 日</td>
<td>[ソウルで使用可能なゾーン](cs_regions.html)</td>
<td>オリンピックの時期に合わせて、Kubernetes クラスターを北アジア太平洋地域のソウルにデプロイします。 ファイアウォールを使用している場合は、このゾーンと、ご使用のクラスターがある地域内の他のロケーションに対し、必ず[ファイアウォール・ポートを開いてください](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>2 月 8 日</td>
<td>[Kubernetes 1.9 の更新](cs_versions.html#cs_v19)</td>
<td>Kubernetes 1.9 に更新する前に、クラスターに対して加える変更を確認してください。</td>
</tr>
</tbody></table>

## 2018 年 1 月によく閲覧されたトピック
{: #jan18}

<table summary="この表には、よく閲覧されたトピックを示しています。行は左から右に読みます。1 列目は日付、2 列目は機能のタイトル、3 列目は説明です。">
<caption>2018 年 1 月によく閲覧されたコンテナーと Kubernetes クラスターについてのトピック</caption>
<thead>
<th>日</th>
<th>タイトル</th>
<th>説明</th>
</thead>
<tbody>
<td>1 月 25 日</td>
<td>[グローバル・レジストリーの提供](../services/Registry/registry_overview.html#registry_regions)</td>
<td>{{site.data.keyword.registryshort_notm}} では、グローバル `registry.bluemix.net` を使用して、IBM 提供のパブリック・イメージをプルできます。</td>
</tr>
<tr>
<td>1 月 23 日</td>
<td>[シンガポールおよびカナダのモントリオールで使用可能なゾーン](cs_regions.html)</td>
<td>シンガポールおよびモントリオールは、{{site.data.keyword.containerlong_notm}} の北アジア太平洋地域と米国東部地域で使用可能なゾーンです。 ファイアウォールを使用している場合は、これらのゾーンと、ご使用のクラスターがある地域内の他のロケーションに対し、必ず[ファイアウォール・ポートを開いてください](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>1 月 8 日</td>
<td>[拡張されたフレーバーが使用可能](cs_cli_reference.html#cs_machine_types)</td>
<td>Series 2 仮想マシン・タイプには、ローカル SSD ストレージとディスク暗号化が含まれます。 パフォーマンスと安定性を向上させるために、これらのフレーバーに[ワークロードを移動](cs_cluster_update.html#machine_type)してください。</td>
</tr>
</tbody></table>

## 同じ関心を持つ開発者との Slack でのチャット
{: #slack}

[{{site.data.keyword.containerlong_notm}} Slack ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibm-container-service.slack.com) で、他の開発者の間で話題となっている内容を確認したり、質問をしたりすることができます。
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} アカウントに IBM ID を使用していない場合は、この Slack への[招待を要求](https://bxcs-slack-invite.mybluemix.net/)してください。
{: tip}
