---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.Bluemix_dedicated_notm}} でのクラスターの概説
{: #dedicated}

{{site.data.keyword.Bluemix_dedicated}} アカウントがある場合、クラスターを専用クラウド環境 (`https://<my-dedicated-cloud-instance>.bluemix.net`) にデプロイし、同じくそこで実行されている事前選択された {{site.data.keyword.Bluemix}} サービスに接続することができます。
{:shortdesc}

{{site.data.keyword.Bluemix_dedicated_notm}} アカウントがない場合、{{site.data.keyword.Bluemix_notm}} Public アカウントを使用して [{{site.data.keyword.containershort_notm}} を開始](container_index.html#container_index)できます。

## Dedicated クラウド環境について
{: #dedicated_environment}

{{site.data.keyword.Bluemix_dedicated_notm}} アカウントを使用するとき、使用可能な物理リソースはお客様のクラスター専用であり、{{site.data.keyword.IBM_notm}} の他のお客様のクラスターと共有されません。クラスターの分離が必要であり、使用する他の {{site.data.keyword.Bluemix_notm}} サービスにもそのような分離が必要な場合は、{{site.data.keyword.Bluemix_dedicated_notm}} 環境をセットアップすることができます。Dedicated アカウントがない場合は、{{site.data.keyword.Bluemix_notm}} Public で専用ハードウェアを使用してクラスターを作成できます。

{{site.data.keyword.Bluemix_dedicated_notm}} では、Dedicated コンソール内のカタログから、または {{site.data.keyword.containershort_notm}} CLI を使用することにより、クラスターを作成することができます。Dedicated コンソールを使用するときには、Dedicated と Public の両方のアカウントに IBM ID を使用して同時にログインします。この二重ログインにより、Dedicated コンソールを使用してパブリック・クラスターにアクセスすることが可能になります。CLI を使用するときには、Dedicated エンドポイント (`api.<my-dedicated-cloud-instance>.bluemix.net.`) を使用してログインし、Dedicated 環境に関連付けられたパブリック地域の {{site.data.keyword.containershort_notm}} API エンドポイントをターゲットにします。

{{site.data.keyword.Bluemix_notm}} Public と Dedicated の間の最も大きな違いは以下の点です。

*   ワーカー・ノード、VLAN、サブネットがデプロイされる IBM Cloud インフラストラクチャー (SoftLayer) アカウントは、お客様が所有するアカウントではなく、{{site.data.keyword.IBM_notm}} が所有して管理するアカウントです。
*   それらの VLAN とサブネットの仕様は、クラスターの作成時ではなく、Dedicated 環境が有効化されるときに決まります。

### クラウド環境間のクラスター管理の違い
{: #dedicated_env_differences}

|Area|{{site.data.keyword.Bluemix_notm}} Public|{{site.data.keyword.Bluemix_dedicated_notm}}|
|--|--------------|--------------------------------|
|クラスター作成|ライト・クラスターを作成したり、標準クラスターに関する以下の詳細を指定したりします。<ul><li>クラスター・タイプ</li><li>名前</li><li>ロケーション</li><li>マシン・タイプ</li><li>ワーカー・ノードの数</li><li>パブリック VLAN</li><li>プライベート VLAN</li><li>ハードウェア</li></ul>|標準クラスターに関する以下の詳細を指定します。<ul><li>名前</li><li>Kubernetes バージョン</li><li>マシン・タイプ</li><li>ワーカー・ノードの数</li></ul><p>**注:** VLAN とハードウェアの設定は、{{site.data.keyword.Bluemix_notm}} 環境の作成時に事前定義されます。</p>|
|クラスターのハードウェアと所有権|標準クラスターでは、ハードウェアは {{site.data.keyword.IBM_notm}} の他のお客様と共有することも、お客様専用にすることもできます。 パブリック VLAN とプライベート VLAN は、お客様の IBM Cloud インフラストラクチャー (SoftLayer) アカウントでお客様が所有して管理します。|{{site.data.keyword.Bluemix_dedicated_notm}} のクラスターでは、ハードウェアは常に専用です。 パブリック VLAN とプライベート VLAN は、お客様の代わりに IBM が所有して管理します。 {{site.data.keyword.Bluemix_notm}} 環境のロケーションは事前定義されます。|
|ロード・バランサーと Ingress ネットワーキング|標準クラスターのプロビジョニング時には、以下のアクションが自動的に行われます。<ul><li>1 つのポータブル・パブリック・サブネットと 1 つのポータブル・プライベート・サブネットがクラスターにバインドされて、IBM Cloud インフラストラクチャー (SoftLayer) アカウントに割り当てられます。</li><li>1 つのポータブル・パブリック IP アドレスが可用性の高いアプリケーション・ロード・バランサー用に使用され、固有のパブリック経路が &lt;cluster_name&gt;.containers.mybluemix.net の形式で割り当てられます。 この経路を使用して、複数のアプリをパブリックに公開できます。1 つのポータブル・プライベート IP アドレスが専用アプリケーション・ロード・バランサーのために使用されます。</li><li>ロード・バランサー・サービスを介してアプリを公開するために使用できる、4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスがクラスターに割り当てられます。IBM Cloud インフラストラクチャー (SoftLayer) アカウントを介して追加のサブネットを要求できます。</li></ul>|Dedicated アカウントを作成するときには、クラスター・サービスの公開方法とアクセス方法に関する接続の決定を行います。独自のエンタープライズ IP 範囲 (ユーザー管理の IP) を使用する場合は、それらを [{{site.data.keyword.Bluemix_dedicated_notm}} 環境のセットアップ](/docs/dedicated/index.html#setupdedicated)時に指定する必要があります。<ul><li>デフォルトでは、ポータブル・パブリック・サブネットは Dedicated アカウントに作成したクラスターにバインドされません。代わりに、エンタープライズに最適な接続モデルを柔軟に選択できます。</li><li>クラスターを作成した後に、バインドするサブネットのタイプを選択して、ロード・バランサーまたは Ingress 接続のためにクラスターで使用します。<ul><li>パブリック・ポータブル・サブネットまたはプライベート・ポータブル・サブネットでは、[サブネットをクラスターに追加](cs_cluster.html#cs_cluster_subnet)できます</li><li>Dedicated での開発時に IBM に提供したユーザー管理の IP アドレスでは、[ユーザー管理のサブネットをクラスターに追加](#dedicated_byoip_subnets)することができます。</li></ul></li><li>サブネットをクラスターにバインドした後に、Ingress コントローラーが作成されます。ポータブル・パブリック・サブネットを使用した場合にのみパブリック Ingress ルートが作成されます。</li></ul>|
|NodePort ネットワーキング|ワーカー・ノードのパブリック・ポートを公開し、ワーカー・ノードのパブリック IP アドレスを使用して、クラスター内のサービスにパブリック・アクセスを行います。|ワーカー・ノードのすべてのパブリック IP アドレスがファイアウォールによってブロックされます。 ただし、クラスターに追加された {{site.data.keyword.Bluemix_notm}} サービスでは、パブリック IP アドレスまたはプライベート IP アドレスを使用してノード・ポートにアクセスできます。|
|永続ストレージ|ボリュームの[動的プロビジョニング](cs_apps.html#cs_apps_volume_claim)または[静的プロビジョニング](cs_cluster.html#cs_cluster_volume_create)を使用します。|ボリュームの[動的プロビジョニング](cs_apps.html#cs_apps_volume_claim)を使用します。ボリュームのバックアップの要求、ボリュームからのリストアの要求、その他のストレージ機能の実行のためには、[サポート・チケットを開きます](/docs/support/index.html#contacting-support)。</li></ul>|
|{{site.data.keyword.registryshort_notm}} のイメージ・レジストリー URL|<ul><li>米国南部と米国東部: <code>registry.ng bluemix.net</code></li><li>英国南部: <code>registry.eu-gb.bluemix.net</code></li><li>中欧 (フランクフルト): <code>registry.eu-de.bluemix.net</code></li><li>オーストラリア (シドニー): <code>registry.au-syd.bluemix.net</code></li></ul>|<ul><li>新しい名前空間には、{{site.data.keyword.Bluemix_notm}} パブリックに対して定義されたものと同じ地域をベースとするレジストリーを使用してください。</li><li>{{site.data.keyword.Bluemix_dedicated_notm}} で単一コンテナーとスケーラブル・コンテナー用にセットアップされた名前空間の場合は、<code>registry.&lt;dedicated_domain&gt;</code> を使用します。</li></ul>|
|レジストリーへのアクセス|[{{site.data.keyword.containershort_notm}} でのプライベートとパブリックのイメージ・レジストリーの使用](cs_cluster.html#cs_apps_images)にあるオプションを参照してください。|<ul><li>新しい名前空間の場合は、[{{site.data.keyword.containershort_notm}} でのプライベートとパブリックのイメージ・レジストリーの使用](cs_cluster.html#cs_apps_images)にあるオプションを参照してください。</li><li>単一グループとスケーラブル・グループ用にセットアップされた名前空間の場合は、[トークンを使用し、Kubernetes シークレットを作成](cs_dedicated_tokens.html#cs_dedicated_tokens)して認証を受けます。</li></ul>|
{: caption="表 1. {{site.data.keyword.Bluemix_notm}} パブリックと {{site.data.keyword.Bluemix_dedicated_notm}} のフィーチャーの相違点" caption-side="top"}

<br />


### サービス・アーキテクチャー
{: #dedicated_ov_architecture}

各ワーカー・ノードのセットアップ時には、{{site.data.keyword.IBM_notm}} 管理の Docker エンジン、別個のコンピュート・リソース、ネットワーキング、ボリューム・サービスが用意されます。標準装備のセキュリティー機能は、分離機能、リソース管理機能、そしてワーカー・ノードのセキュリティー・コンプライアンスを提供します。ワーカー・ノードは、機密保護機能のある TLS 証明書と openVPN 接続を使用してマスターと通信します。
{:shortdesc}

*図 1. {{site.data.keyword.Bluemix_dedicated_notm}} での Kubernetes アーキテクチャーとネットワーキング*

![{{site.data.keyword.Bluemix_dedicated_notm}} 上の {{site.data.keyword.containershort_notm}} Kubernetes のアーキテクチャー](images/cs_dedicated_arch.png)

<br />


## Dedicated での {{site.data.keyword.containershort_notm}} のセットアップ
{: #dedicated_setup}

各 {{site.data.keyword.Bluemix_dedicated_notm}} 環境には、{{site.data.keyword.Bluemix_notm}} 内にパブリック、クライアント所有、そして企業のアカウントがあります。Dedicated 環境内のユーザーがクラスターを作成するためには、管理者が、ユーザーを Dedicated 環境内のこのパブリック企業アカウントに追加する必要があります。

開始前に、以下のことを行います。
  * [{{site.data.keyword.Bluemix_dedicated_notm}} 環境をセットアップします](/docs/dedicated/index.html#setupdedicated)。
  * ローカル・システムまたは企業ネットワークがプロキシーまたはファイアウォールを使用して公共のインターネットのエンドポイントを制御する場合、[ファイアウォールで必要なポートと IP アドレスを開く](cs_security.html#opening_ports)必要があります。

{{site.data.keyword.Bluemix_dedicated_notm}} ユーザーがクラスターにアクセスできるようにするには、以下のようにします。

1.  {{site.data.keyword.Bluemix_notm}} Public アカウントの所有者は API キーを生成する必要があります。
    1.  {{site.data.keyword.Bluemix_dedicated_notm}} インスタンス のパブリック・エンドポイントにログインします。 Public アカウント所有者の {{site.data.keyword.Bluemix_notm}} 資格情報を入力し、プロンプトが出されたらアカウントを選択します。

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **注:** フェデレーテッド ID がある場合は、`bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

    2.  ユーザーを Public アカウントに招待するための API キーを生成します。Dedicated アカウント管理者が次のステップで使用する API キーの値をメモします。

        ```
        bx iam api-key-create <key_name> -d "Key to invite users to <dedicated_account_name>"
        ```
        {: pre}

    3.  Dedicated アカウント管理者が次のステップで使用する、ユーザーの招待先となる Public アカウント組織の GUID をメモします。

        ```
        bx account orgs
        ```
        {: pre}

2.  {{site.data.keyword.Bluemix_dedicated_notm}} アカウントの所有者は、単一または複数のユーザーを Public アカウントに招待できます。
    1.  {{site.data.keyword.Bluemix_dedicated_notm}} インスタンス のパブリック・エンドポイントにログインします。 Dedicated アカウント所有者の {{site.data.keyword.Bluemix_notm}} 資格情報を入力し、プロンプトが出されたらアカウントを選択します。

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **注:** フェデレーテッド ID がある場合は、`bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

    2.  ユーザーを Public アカウントに招待します。
        * 単一のユーザーを招待するには、以下のようにします。

            ```
            bx cf bluemix-admin invite-users-to-public -userid=<user_email> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```
            {: pre}

            <em>&lt;user_IBMid&gt;</em> を招待するユーザーの E メールに、<em>&lt;public_api_key&gt;</em> を直前のステップで生成した API キーに、<em>&lt;public_org_id&gt;</em> を Public アカウント組織の GUID に置き換えます。

        * 現在 Dedicated アカウント組織に含まれているすべてのユーザーを招待するには、以下のようにします。

            ```
            bx cf bluemix-admin invite-users-to-public -organization=<dedicated_org_id> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```

            <em>&lt;dedicated_org_id&gt;</em> を Dedicated アカウント組織の ID に、<em>&lt;public_api_key&gt;</em> を直前のステップで生成した API キーに、<em>&lt;public_org_id&gt;</em> を Public アカウント組織の GUID に置き換えます。

    3.  ユーザーに IBM ID がある場合、そのユーザーは Public アカウント内の指定された組織に自動的に追加されます。ユーザーに IBM ID がまだ存在しない場合、ユーザーの E メール・アドレスに招待が送信されます。ユーザーが招待を受け入れると、そのユーザーの IBM ID が作成されて、そのユーザーは Public アカウント内の指定された組織に追加されます。

    4.  ユーザーがアカウントに追加されたことを確認します。

        ```
        bx cf bluemix-admin invite-users-status -apikey=<public_api_key>
        ```
        {: pre}

        既存の IBM ID を持つ招待されたユーザーは、状況が `ACTIVE` になります。既存の IBM ID を持たない招待されたユーザーは、アカウントへの招待を既に受け入れたかどうかに応じて、状況が `PENDING` または `ACTIVE` になります。

3.  ユーザーが Public アカウントに追加された後、クラスターを作成する必要のあるすべてのユーザーに管理者役割を付与する必要があります。管理者役割を付与する方法について詳しくは、[ユーザー・アクセスの管理](cs_cluster.html#cs_cluster_user)を参照してください。

4.  ユーザーは Dedicated アカウント・エンドポイントにログインしてクラスターの作成を開始できるようになりました。

    1.  {{site.data.keyword.Bluemix_dedicated_notm}} インスタンス のパブリック・エンドポイントにログインします。 プロンプトが出されたら、IBM ID を入力します。

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **注:** フェデレーテッド ID がある場合は、`bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

    2.  初めてログインする場合は、プロンプトが出されたら Dedicated ユーザー ID とパスワードを入力します。これにより Dedicated アカウントが認証され、Dedicated アカウントと Public アカウントが共にリンクされます。この最初のログインの後は、毎回のログインで IBM ID だけを使用します。

        **注**: クラスターを作成するには、Dedicated アカウントと Public アカウントの両方にログインする必要があります。Dedicated アカウントにログインするだけの場合は、Dedicated エンドポイントにログインする際に `--no-iam` フラグを使用します。

5.  アカウントをリンク解除する場合、IBM ID を Dedicated ユーザー ID から切断することができます。

    ```
    bx iam dedicated-id-disconnect
    ```
    {: pre}

<br />


## クラスターの作成
{: #dedicated_administering}

可用性と能力が最大になるように {{site.data.keyword.Bluemix_dedicated_notm}} クラスターのセットアップを設計します。
{:shortdesc}

### GUI でのクラスターの作成
{: #dedicated_creating_ui}

1.  Dedicated コンソールを開きます。これは `https://<my-dedicated-cloud-instance>.bluemix.net` にあります。
2. **「Bluemix Public にもログインする (Also log in to {{site.data.keyword.Bluemix_notm}} Public)」**チェック・ボックスを選択して、**「ログイン」**をクリックします。
3. プロンプトに従い、IBM ID を使用してログインします。Dedicated アカウントに初めてログインする場合は、プロンプトに従って {{site.data.keyword.Bluemix_dedicated_notm}} にログインします。
4.  カタログから**「コンテナー」**を選択して、**「Kubernetes クラスター」**をクリックします。
5.  **クラスター名**を入力します。
6.  **マシン・タイプ**を選択します。 各ワーカー・ノードにセットアップされる仮想 CPU とメモリーの量は、マシン・タイプによって決まります。この仮想 CPU とメモリーは、ノードにデプロイされるすべてのコンテナーで使用できます。
    -   「マイクロ (micro)」のマシン・タイプは、最小のオプションを表しています。
    -   「分散型 (Balanced)」のマシン・タイプは、同じ容量のメモリーが各 CPU に割り当てられるので、パフォーマンスが最適化されます。
7.  必要な**ワーカー・ノードの数**を選択します。 `3` を選択して、クラスターの高可用性を確保します。
8.  **「クラスターの作成」**をクリックします。 クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。 **「ワーカー・ノード (Worker nodes)」**タブで、ワーカー・ノードのデプロイメントの進行状況を確認できます。 ワーカー・ノードの準備が完了すると、状態が **Ready** に変わります。

### CLI でのクラスターの作成
{: #dedicated_creating_cli}

1.  {{site.data.keyword.Bluemix_notm}} CLI と [{{site.data.keyword.containershort_notm}} プラグイン](cs_cli_install.html#cs_cli_install)をインストールします。
2.  {{site.data.keyword.Bluemix_dedicated_notm}} インスタンス のパブリック・エンドポイントにログインします。 {{site.data.keyword.Bluemix_notm}} 資格情報を入力し、プロンプトが出されたらアカウントを選択します。

    ```
    bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
    ```
    {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

3.  ある地域をターゲットに設定するには、`bx cs region-set` を実行します。

4.  `cluster-create` コマンドを使用してクラスターを作成します。 標準クラスターを作成する場合、ワーカー・ノードのハードウェアは、使用時間に応じて課金されます。

    例:

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>表 2. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>{{site.data.keyword.Bluemix_notm}} 組織内にクラスターを作成するためのコマンド。</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>&lt;location&gt; を、Dedicated 環境を使用するように構成されている {{site.data.keyword.Bluemix_notm}} のロケーション ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>標準クラスターを作成する場合、マシン・タイプを選択します。 マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・リソースが決まります。 詳しくは、[{{site.data.keyword.containershort_notm}} のライト・クラスターと標準クラスターの比較](cs_planning.html#cs_planning_cluster_type)を参照してください。 ライト・クラスターの場合、マシン・タイプを定義する必要はありません。</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td><em>&lt;name&gt;</em> をクラスターの名前に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>クラスターに含めるワーカー・ノードの数。 <code>--workers</code> オプションが指定されていない場合は、ワーカー・ノードが 1 つ作成されます。</td>
    </tr>
    </tbody></table>

5.  クラスターの作成が要求されたことを確認します。

    ```
    bx cs clusters
    ```
    {: pre}

    **注:** ワーカー・ノード・マシンが配列され、クラスターがセットアップされて自分のアカウントにプロビジョンされるまでに、最大 15 分かかります。

    クラスターのプロビジョニングが完了すると、クラスターの状態が **deployed** に変わります。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

6.  ワーカー・ノードの状況を確認します。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    ワーカー・ノードの準備が完了すると、状態が **normal** に変わり、状況が **Ready** になります。 ノードの状況が**「Ready」**になったら、クラスターにアクセスできます。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

7.  作成したクラスターを、このセッションのコンテキストとして設定します。 次の構成手順は、クラスターの操作時に毎回行ってください。

    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        構成ファイルのダウンロードが完了すると、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。

        OS X の場合の例:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。
    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。

        OS X の場合の例:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        出力:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

8.  デフォルトのポート 8001 で Kubernetes ダッシュボードにアクセスします。
    1.  デフォルトのポート番号でプロキシーを設定します。

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Web ブラウザーで以下の URL を開いて、Kubernetes ダッシュボードを表示します。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

### プライベートとパブリックのイメージ・レジストリーの使用
{: #dedicated_images}

新しい名前空間の場合は、[{{site.data.keyword.containershort_notm}} でのプライベートとパブリックのイメージ・レジストリーの使用](cs_cluster.html#cs_apps_images)にあるオプションを参照してください。 単一グループとスケーラブル・グループ用にセットアップされた名前空間の場合は、[トークンを使用し、Kubernetes シークレットを作成](cs_dedicated_tokens.html#cs_dedicated_tokens)して認証を受けます。

### クラスターへのサブネットの追加
{: #dedicated_cluster_subnet}

クラスターにサブネットを追加して、使用可能なポータブル・パブリック IP アドレスのプールを変更します。 詳しくは、[クラスターへのサブネットの追加](cs_cluster.html#cs_cluster_subnet)を参照してください。 サブネットを Dedicated クラスターに追加する操作に関する以下の差異を検討してください。

#### ユーザー管理サブネットと IP アドレスを Kubernetes クラスターにさらに追加する
{: #dedicated_byoip_subnets}

{{site.data.keyword.containershort_notm}} にアクセスするために使用するオンプレミス・ネットワークに属するユーザー独自のサブネットをさらに指定します。それらのサブネットにあるプライベート IP アドレスを、Kubernetes クラスター内の Ingress サービスとロード・バランサー・サービスに追加できます。ユーザー管理のサブネットは、使用するサブネットのフォーマットに応じて、2 つの方法のいずれかにより構成されます。

要件:
- ユーザー管理のサブネットを追加できるのは、プライベート VLAN のみです。
- サブネットの接頭部の長さの限度は /24 から /30 です。 例えば、`203.0.113.0/24` は 253 個の使用可能なプライベート IP アドレスを示し、`203.0.113.0/30` は 1 つの使用可能なプライベート IP アドレスを示します。
- サブネットの最初の IP アドレスは、サブネットのゲートウェイとして使用する必要があります。

始める前に、ユーザー管理のサブネットを使用する {{site.data.keyword.Bluemix_dedicated_notm}} ネットワークとエンタープライズ・ネットワークとの間のネットワーク・トラフィックの出入りのルーティングを構成します。

1. 独自のサブネットを使用するには、[サポート・チケットを開き](/docs/support/index.html#contacting-support)、使用するサブネット CIDR のリストを指定します。
    **注**: オンプレミスと内部アカウント接続のために ALB とロード・バランサーを管理する方法は、サブネット CIDR のフォーマットによって異なります。構成の違いについては、最後のステップを参照してください。

2. {{site.data.keyword.IBM_notm}} がユーザー管理のサブネットをプロビジョンした後に、Kubernetes クラスターでそのサブネットを使用できるようにします。

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
    ```
    {: pre}
    <em>&lt;cluster_name&gt;</em> をクラスターの名前または ID に置き換え、<em>&lt;subnet_CIDR&&gt;</em> を、サポート・チケットに指定したいずれかのサブネット CIDR に置き換え、<em>&lt;private_VLAN&gt;</em> を使用可能なプライベート VLAN ID に置き換えます。使用可能なプライベート VLAN の ID は、`bx cs vlans` を実行することによって見つけることができます。

3. サブネットがクラスターに追加されたことを確認します。ユーザー提供のサブネットの **User-managed** フィールドは _true_ です。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. オンプレミスと内部アカウントの接続を構成するには、以下のオプションの間から選択します。
  - サブネットに 10.x.x.x プライベート IP アドレス範囲を使用した場合、その範囲にある有効な IP を使用して、Ingress とロード・バランサーによるオンプレミスと内部アカウントの接続を構成します。詳しくは、[アプリへのアクセスの構成](cs_apps.html#cs_apps_public)を参照してください。
  - サブネットに 10.x.x.x プライベート IP アドレス範囲を使用していない場合、その範囲にある有効な IP を使用して、Ingress とロード・バランサーによるオンプレミスの接続を構成します。詳しくは、[アプリへのアクセスの構成](cs_apps.html#cs_apps_public)を参照してください。 ただし、IBM Cloud インフラストラクチャー (SoftLayer) のポータブル・プライベート・サブネットを使用して、クラスターと他の Cloud Foundry ベースのサービスの間に内部アカウントの接続を構成する必要があります。ポータブル・プライベート・サブネットは、[`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) コマンドによって作成できます。このシナリオでは、クラスターに、オンプレミス接続のためのユーザー管理のサブネットと、内部アカウント接続のための IBM Cloud インフラストラクチャー (SoftLayer) のポータブル・プライベート・サブネットの両方があります。

### その他のクラスター構成
{: #dedicated_other}

その他のクラスター構成については、以下のオプションを検討してください。
  * [クラスター・アクセス権限の管理](cs_cluster.html#cs_cluster_user)
  * [Kubernetes マスターの更新](cs_cluster.html#cs_cluster_update)
  * [ワーカー・ノードの更新](cs_cluster.html#cs_cluster_worker_update)
  * [クラスター・ロギングの構成](cs_cluster.html#cs_logging)
  * [クラスター・モニタリングの構成](cs_cluster.html#cs_monitoring)
      * **注**: `ibm-monitoring` クラスターは各 {{site.data.keyword.Bluemix_dedicated_notm}} アカウント内にあります。このクラスターは、Dedicated 環境での {{site.data.keyword.containerlong_notm}} の正常性を継続的にモニターし、環境の安定度と接続性を検査します。このクラスターは環境から除去しないでください。
  * [Kubernetes クラスター・リソースの視覚化](cs_cluster.html#cs_weavescope)
  * [クラスターの削除](cs_cluster.html#cs_cluster_remove)

<br />


## アプリをクラスターにデプロイする
{: #dedicated_apps}

Kubernetes の技法を利用して、アプリを {{site.data.keyword.Bluemix_dedicated_notm}} クラスターにデプロイし、アプリを常に稼働状態にすることができます。
{:shortdesc}

アプリをクラスターにデプロイするには、[アプリを {{site.data.keyword.Bluemix_notm}} パブリック・クラスターにデプロイする](cs_apps.html#cs_apps)ための指示に従うことができます。{{site.data.keyword.Bluemix_dedicated_notm}} クラスターに関する以下の差異を検討してください。

### アプリへのパブリック・アクセスを許可する方法
{: #dedicated_apps_public}

{{site.data.keyword.Bluemix_dedicated_notm}} 環境の場合、パブリック・プライマリー IP アドレスはファイアウォールでブロックされます。アプリを誰でも利用できるようにするには、[LoadBalancer サービス](#dedicated_apps_public_load_balancer)または [Ingress](#dedicated_apps_public_ingress) を NodePort サービスの代わりに使用してください。ポータブル・パブリック IP がアドレス指定する LoadBalancer サービスまたは Ingress へのアクセス権限が必要な場合、サービスの開発時に企業ファイアウォール・ホワイトリストを IBM に提出してください。

#### ロード・バランサー・タイプのサービスを使用してアプリへのアクセスを構成する方法
{: #dedicated_apps_public_load_balancer}

ロード・バランサーにパブリック IP アドレスを使用する場合、企業ファイアウォール・ホワイトリストが IBM に提出されていることを確認するか、[サポート・チケットを開いて](/docs/support/index.html#contacting-support)ファイアウォール・ホワイトリストを構成します。その後、[ロード・バランサー・タイプのサービスを使用してアプリへのアクセスを構成する方法](cs_apps.html#cs_apps_public_load_balancer)の手順に従います。

#### Ingress を使用してアプリへのパブリック・アクセスを構成する方法
{: #dedicated_apps_public_ingress}

アプリケーション・ロード・バランサーにパブリック IP アドレスを使用する場合、企業ファイアウォール・ホワイトリストが IBM に提出されていることを確認するか、[サポート・チケットを開いて](/docs/support/index.html#contacting-support)ファイアウォール・ホワイトリストを構成します。その後、[Ingress を使用してアプリへのアクセスを構成する方法](cs_apps.html#cs_apps_public_ingress)の手順に従います。

### 永続ストレージの作成
{: #dedicated_apps_volume_claim}

永続ストレージを作成するためのオプションを確認するには、[永続データ・ストレージ](cs_planning.html#cs_planning_apps_storage)を参照してください。ボリュームのバックアップ、ボリュームからのリストア、その他のストレージ機能を要求するには、[サポート・チケットを開く](/docs/support/index.html#contacting-support)必要があります。
