---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# クラスターへのユーザー・アクセスの割り当て
{: #users}

許可されたユーザーだけが {{site.data.keyword.containerlong}} のクラスターを操作したりコンテナーをクラスターにデプロイしたりできるように、Kubernetes クラスターに対するアクセス権限を付与することができます。
{:shortdesc}


## コミュニケーション・プロセスの計画
クラスター管理者は、秩序が取れた状態を保つために、組織のメンバーが管理者にアクセス要求を伝えるためのコミュニケーション・プロセスの確立方法について検討する必要があります。
{:shortdesc}

クラスターに対するアクセス権限を要求する方法や、一般的な作業の支援をクラスター管理者に依頼する方法について、クラスター・ユーザーに指示してください。Kubernetes はこの種のコミュニケーションを促進していないので、チームごとに好みでさまざまなプロセスを選択できます。

以下の方法から選択することも、独自の方法を確立することもできます。
- チケット・システムを作成する
- フォーム・テンプレートを作成する
- Wiki ページを作成する
- E メールによる要求を義務付ける
- チームの日常業務を追跡するために既に使用している問題追跡方法を使用する


## クラスター・アクセス権限の管理
{: #managing}

{{site.data.keyword.containershort_notm}} で操作をするすべてのユーザーに、ユーザーが実行可能なアクションを指定するサービス固有のユーザー役割を組み合わせて割り当てる必要があります。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} アクセス・ポリシー</dt>
<dd>ID およびアクセス管理において、{{site.data.keyword.containershort_notm}} アクセス・ポリシーは、クラスターで実行できるクラスター管理アクション (クラスターの作成または削除、ワーカー・ノードの追加または削除など) を判別します。 これらのポリシーは、インフラストラクチャー・ポリシーとともに設定する必要があります。 クラスターに対するアクセス権限は地域単位で付与できます。</dd>
<dt>インフラストラクチャー・アクセス・ポリシー</dt>
<dd>ID およびアクセス管理において、インフラストラクチャー・アクセス・ポリシーにより、{{site.data.keyword.containershort_notm}} ユーザー・インターフェースまたは CLI から要求されたアクションが IBM Cloud インフラストラクチャー (SoftLayer) 内で完了できるようになります。 これらのポリシーは、{{site.data.keyword.containershort_notm}} アクセス・ポリシーとともに設定する必要があります。 [インフラストラクチャーで選択可能な役割について詳しくは、こちらをご覧ください](/docs/iam/infrastructureaccess.html#infrapermission)。</dd>
<dt>リソース・グループ</dt>
<dd>リソース・グループは、各 {{site.data.keyword.Bluemix_notm}} サービスをいくつかのグループに編成したもので、これを使用すると、複数のリソースへのアクセス権限を各ユーザーに一度に素早く割り当てることができます。 [リソース・グループを使用してユーザーを管理する方法を参照してください](/docs/account/resourcegroups.html#rgs)。</dd>
<dt>Cloud Foundry の役割</dt>
<dd>Identity and Access Management では、すべてのユーザーに、Cloud Foundry ユーザー役割を割り当てる必要があります。 この役割は、ユーザーが {{site.data.keyword.Bluemix_notm}} アカウントで実行できるアクション (他のユーザーの招待や割り当て分の使用率の表示など) を決定します。 [Cloud Foundry で選択可能な役割について詳しくは、こちらをご覧ください](/docs/iam/cfaccess.html#cfaccess)。</dd>
<dt>Kubernetes RBAC の役割</dt>
<dd>{{site.data.keyword.containershort_notm}} アクセス・ポリシーが割り当てられているすべてのユーザーには、Kubernetes RBAC 役割が自動的に割り当てられます。  Kubernetes では、RBAC 役割によって、クラスター内の Kubernetes リソースに対して実行できるアクションが決まります。 RBAC 役割は、デフォルトの名前空間に関してのみセットアップされます。 クラスター管理者は、クラスター内の他の名前空間の RBAC 役割を追加できます。 次の[アクセス・ポリシーと許可](#access_policies)のセクションにある表を参照して、どの RBAC 役割がどの {{site.data.keyword.containershort_notm}} アクセス・ポリシーに対応するかを確認してください。RBAC 役割の概要について詳しくは、Kubernetes 資料の [Using RBAC Authorization ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) を参照してください。</dd>
</dl>

<br />


## アクセス・ポリシーと許可
{: #access_policies}

{{site.data.keyword.Bluemix_notm}} アカウント内のユーザーに付与できるアクセス・ポリシーと許可について説明します。
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} ID およびアクセス管理 (IAM) のオペレーター役割とエディター役割には、それぞれ別の許可が設定されます。例えば、ワーカー・ノードを追加してサービスをバインドする操作をユーザーに実行させるには、そのユーザーにオペレーターとエディターの両方の役割を割り当てる必要があります。 対応するインフラストラクチャー・アクセス・ポリシーについて詳しくは、[ユーザーのインフラストラクチャー許可のカスタマイズ](#infra_access)を参照してください。<br/><br/>ユーザーのアクセス・ポリシーを変更すると、クラスター内のその変更に関連する RBAC ポリシーが自動的にクリーンアップされます。</br></br>**注:** 例えば、元クラスター管理者にビューアー権限を割り当てるなど、許可をダウングレードする場合は、ダウングレードが完了するまで数分待つ必要があります。

|{{site.data.keyword.containershort_notm}} アクセス・ポリシー|クラスター管理許可|Kubernetes リソース許可|
|-------------|------------------------------|-------------------------------|
|管理者|この役割は、対象アカウントのすべてのクラスターのエディター、オペレーター、およびビューアーの役割から許可を継承します。 <br/><br/>すべての現行サービス・インスタンスに設定された場合:<ul><li>フリー・クラスターまたは標準クラスターを作成する</li><li>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするための {{site.data.keyword.Bluemix_notm}} アカウントの資格情報を設定する</li><li>クラスターを削除する</li><li>対象アカウント内の他の既存ユーザーの {{site.data.keyword.containershort_notm}} アクセス・ポリシーの割り当てと変更。</li></ul><p>特定のクラスター ID に設定された場合:<ul><li>特定のクラスターを削除する</li></ul></p>対応するインフラストラクチャー・アクセス・ポリシー: スーパーユーザー<br/><br/><strong>注</strong>: マシン、VLAN、サブネットなどのリソースを作成するには、ユーザーにインフラストラクチャーの**スーパーユーザー**役割が必要です。|<ul><li>RBAC 役割: クラスター管理</li><li>すべての名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li><li>Kubernetes ダッシュボードにアクセスする</li><li>アプリをだれでも利用できるようにする Ingress リソースを作成する</li></ul>|
|オペレーター|<ul><li>クラスターにワーカー・ノードを追加する</li><li>クラスターからワーカー・ノードを削除する</li><li>ワーカー・ノードをリブートする</li><li>ワーカー・ノードを再ロードする</li><li>クラスターにサブネットを追加する</li></ul><p>対応するインフラストラクチャー・アクセス・ポリシー: [カスタム](#infra_access)</p>|<ul><li>RBAC 役割: 管理者</li><li>名前空間自体ではなく、デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li></ul>|
|エディター <br/><br/><strong>ヒント</strong>: アプリ開発者には、この役割を使用してください。|<ul><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにバインドします。</li><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにアンバインドします。</li><li>Web フックを作成します。</li></ul><p>対応するインフラストラクチャー・アクセス・ポリシー: [カスタム](#infra_access)|<ul><li>RBAC 役割: 編集</li><li>デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li></ul></p>|
|ビューアー|<ul><li>クラスターをリスト表示する</li><li>クラスターの詳細を表示する</li></ul><p>対応するインフラストラクチャー・アクセス・ポリシー: 表示のみ</p>|<ul><li>RBAC 役割: 表示</li><li>デフォルトの名前空間内にあるリソースに対する読み取りアクセス</li><li>Kubernetes シークレットに対する読み取りアクセス権限はなし</li></ul>|

|Cloud Foundry アクセス・ポリシー|アカウント管理許可|
|-------------|------------------------------|
|組織の役割: 管理者|<ul><li>{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加する</li></ul>| |
|スペースの役割: 開発者|<ul><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスを作成する</li><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターにバインドする</li></ul>| 

<br />



## IAM API キーと `bx cs credentials-set` コマンドについて
{: #api_key}

アカウントでクラスターを正常にプロビジョンして使用するには、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスできるようにアカウントを正しくセットアップしておく必要があります。アカウントのセットアップに応じて、IAM API キーまたはインフラストラクチャー資格情報 (`bx cs credentials-set` コマンドを使用して手動で設定) のいずれかを使用します。

<dl>
  <dt>IAM API キー</dt>
  <dd>IAM (ID およびアクセス管理) の API キーは、{{site.data.keyword.containershort_notm}} 管理アクセス・ポリシーを必要とする最初のアクションを実行したときに、地域に対して自動的に設定されます。例えば、管理ユーザーの 1 人が <code>us-south</code> 地域に最初のクラスターを作成したとします。これにより、その地域に対してこのユーザーの IAM API キーがアカウントに保管されます。新しいワーカー・ノードや VLAN などの IBM Cloud インフラストラクチャー (SoftLayer) を注文する際には、この API キーが使用されます。</br></br>
IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオとのやりとりが必要なアクション (例えば、新規クラスターの作成やワーカー・ノードの再ロードなど) を別のユーザーがこの地域で実行すると、保管されている API キーを基に、そのアクションを実行できるだけの権限があるかどうかが判断されます。インフラストラクチャー関連のアクションをクラスター内で正常に実行するためには、{{site.data.keyword.containershort_notm}} 管理ユーザーにインフラストラクチャー・アクセス・ポリシーの<strong>スーパーユーザー</strong>を割り当ててください。</br></br>現在の API キー所有者を調べるには、[<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info) を実行します。地域に対して保管されている API キーを更新する必要があることがわかった場合は、[<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) コマンドを実行して更新できます。このコマンドには {{site.data.keyword.containershort_notm}} 管理アクセス・ポリシーが必要です。このコマンドを実行すると、実行したユーザーの API キーがアカウントに保管されます。</br></br> <strong>注:</strong> <code>bx cs credentials-set</code> コマンドを使用して手動で IBM Cloud インフラストラクチャー (SoftLayer) 資格情報を設定した場合、地域に対して保管されている API キーは使用されない可能性があります。</dd>
<dt><code>bx cs credentials-set</code> による IBM Cloud インフラストラクチャー (SoftLayer) の資格情報</dt>
<dd>{{site.data.keyword.Bluemix_notm}} 従量制課金アカウントがあれば、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにデフォルトでアクセスできます。しかし、既に所有している別の IBM Cloud インフラストラクチャー (SoftLayer) アカウントを使用して、インフラストラクチャーを注文したい場合もあるでしょう。[<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set) コマンドを使用すると、そのようなインフラストラクチャー・アカウントを {{site.data.keyword.Bluemix_notm}} アカウントにリンクできます。</br></br>IBM Cloud インフラストラクチャー (SoftLayer) の資格情報を手動で設定した場合は、アカウントに既に IAM API キーが存在していても、それらの資格情報がインフラストラクチャーの注文に使用されます。資格情報が保管されているユーザーにインフラストラクチャーを注文するために必要な権限がない場合、クラスターを作成したりワーカー・ノードを再ロードしたりするインフラストラクチャー関連のアクションは失敗する可能性があります。</br></br> 手動で設定した IBM Cloud インフラストラクチャー (SoftLayer) の資格情報を削除するには、[<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) コマンドを使用します。資格情報が削除されると、IAM API キーがインフラストラクチャーの注文に使用されます。</dd>
</dl>

## {{site.data.keyword.Bluemix_notm}} アカウントへのユーザーの追加
{: #add_users}

{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加して、クラスターへのアクセス権限を付与できます。
{:shortdesc}

始める前に、{{site.data.keyword.Bluemix_notm}} アカウントに対する Cloud Foundry の管理者役割が自分に割り当てられていることを確認してください。

1.  [ユーザーをアカウントに追加します](../iam/iamuserinv.html#iamuserinv)。
2.  **「アクセス」**セクションで**「サービス」**を展開します。
3.  {{site.data.keyword.containershort_notm}} アクセス権限の役割を割り当てます。 **「アクセス権限の割り当て先 (Assign access to)」**ドロップダウン・リストから、アクセス権限を {{site.data.keyword.containershort_notm}} アカウント (**リソース**) のみに付与するか、それともアカウント内のさまざまなリソースの集合 (**リソース・グループ**) に付与するかを決定します。
  -  **リソース**の場合:
      1. **「サービス」**ドロップダウン・リストで、**「{{site.data.keyword.containershort_notm}}」**を選択します。
      2. **「地域」**ドロップダウン・リストから、ユーザーを招待する地域を選択します。 **注**: [北アジア太平洋地域](cs_regions.html#locations)のクラスターに対するアクセス権限については、[北アジア太平洋地域内のクラスターに対する IAM アクセス権限をユーザーに付与する](#iam_cluster_region)を参照してください。
      3. **「サービス・インスタンス」**ドロップダウン・リストから、ユーザーを招待するクラスターを選択します。 特定のクラスターの ID を確認するには、
`bx cs clusters` を実行します。
      4. **「役割の選択」**セクションで、役割を選択します。 役割別のサポート対象アクションの一覧については、[アクセス・ポリシーと許可](#access_policies)を参照してください。
  - **リソース・グループ**の場合:
      1. **「リソース・グループ」**ドロップダウン・リストから、自分のアカウントの {{site.data.keyword.containershort_notm}} リソースに対するアクセス権を付与されたリソース・グループを選択します。
      2. **「リソース・グループへのアクセス権限の割り当て (Assign access to a resource group)」**ドロップダウン・リストから、役割を選択します。 役割別のサポート対象アクションの一覧については、[アクセス・ポリシーと許可](#access_policies)を参照してください。
4. [オプション: Cloud Foundry の役割を割り当てます](/docs/iam/mngcf.html#mngcf)。
5. [オプション: インフラストラクチャーの役割を割り当てます](/docs/iam/infrastructureaccess.html#infrapermission)。
6. **「ユーザーの招待」**をクリックします。

<br />


### 北アジア太平洋地域内のクラスターに対する IAM アクセス権限をユーザーに付与する
{: #iam_cluster_region}

[{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加する](#add_users)ときに、ユーザーにアクセス権限を付与する地域を選択します。ただし、北アジア太平洋地域などの一部の地域は、コンソールで選択できない可能性があるため、CLI を使用して追加する必要があります。
{:shortdesc}

始めに、{{site.data.keyword.Bluemix_notm}} アカウントの管理者であることを確認してください。

1.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。 使用するアカウントを選択します。

    ```
    bx login [--sso]
    ```
    {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。 ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

2.  北アジア太平洋地域 (`jp-tok`) など、許可を付与する環境をターゲットにします。組織やスペースなどのコマンド・オプションについて詳しくは、[`bluemix target` コマンド](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target)を参照してください。

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  アクセス権限を付与する地域のクラスターの名前または ID を取得します。

    ```
    bx cs clusters
    ```
    {: pre}

4.  アクセス権限を付与するユーザー ID を取得します。

    ```
    bx account users
    ```
    {: pre}

5.  アクセス・ポリシーの役割を選択します。

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  適切な役割を指定して、クラスターに対するアクセス権限をユーザーに付与します。この例では、`user@example.com` に 3 つのクラスターの `Operator` 役割と `Editor` 役割を割り当てています。

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    地域の既存のクラスターと将来のクラスターに対するアクセス権限を付与する際は、`--service-instance` フラグを指定しないでください。詳しくは、[`bluemix iam user-policy-create` コマンド](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create)を参照してください
    {:tip}

## ユーザーのインフラストラクチャー許可のカスタマイズ
{: #infra_access}

ID およびアクセス管理でインフラストラクチャー・ポリシーを設定すると、ユーザーには役割に関連付けられた許可が付与されます。 それらの許可をカスタマイズするには、IBM Cloud インフラストラクチャー (SoftLayer) にログインし、そこで許可を調整する必要があります。
{: #view_access}

例えば、**基本ユーザー**はワーカー・ノードをリブートできますが、ワーカー・ノードを再ロードすることはできません。 そのユーザーに**スーパーユーザー**権限を付与しなくても、IBM Cloud インフラストラクチャー (SoftLayer) の許可を調整して、再ロード・コマンドを実行する許可を追加できます。

1.  [{{site.data.keyword.Bluemix_notm}} アカウント](https://console.bluemix.net/)にログインし、メニューから**「インフラストラクチャー」**を選択します。

2.  **「アカウント」** > **「ユーザー」** > **「ユーザー・リスト」**と進みます。

3.  許可を変更するには、ユーザー・プロファイルの名前または**「デバイス・アクセス」**列を選択します。

4.  **「ポータルの許可」**タブで、ユーザーのアクセス権限をカスタマイズします。 ユーザーが必要とする許可は、ユーザーが使用する必要があるインフラストラクチャー・リソースによって異なります。

    * **「クイック許可」**ドロップダウン・リストを使用して、**「スーパーユーザー」**役割を割り当てます。これにより、すべての許可がユーザーに付与されます。
    * **「クイック許可」**ドロップダウン・リストを使用して、 **「基本ユーザー」**役割を割り当てます。これにより、すべての許可ではなくいくつかの必要な許可がユーザーに付与されます。
    * **「スーパーユーザー」**役割を指定してすべての許可を付与したくない場合や、**「基本ユーザー」**役割を超える許可を追加する必要がある場合は、次の表を参照してください。この表は、{{site.data.keyword.containershort_notm}} で一般的な作業を行うために必要な許可を示しています。

    <table summary="一般的な {{site.data.keyword.containershort_notm}} シナリオに必要なインフラストラクチャー許可。">
     <caption>一般的に必要な {{site.data.keyword.containershort_notm}} のインフラストラクチャー許可</caption>
     <thead>
     <th>{{site.data.keyword.containershort_notm}} の一般的な作業</th>
     <th>必要なインフラストラクチャー許可 (タブ別)</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>最小許可</strong>: <ul><li>クラスターを作成します。</li></ul></td>
     <td><strong>デバイス</strong>:<ul><li>仮想サーバーの詳細の表示</li><li>サーバーのリブートと IPMI システム情報の表示</li><li>OS 再ロードの発行とレスキュー・カーネルの開始</li></ul><strong>アカウント</strong>: <ul><li>クラウド・インスタンスの追加/アップグレード</li><li>サーバーの追加</li></ul></td>
     </tr>
     <tr>
     <td><strong>クラスター管理</strong>: <ul><li>クラスターを作成、更新、削除する。</li><li>ワーカー・ノードを追加、再ロード、リブートする。</li><li>VLAN を表示する。</li><li>サブネットを作成する。</li><li>ポッドとロード・バランサー・サービスをデプロイする。</li></ul></td>
     <td><strong>サポート</strong>:<ul><li>チケットの表示</li><li>チケットの追加</li><li>チケットの編集</li></ul>
     <strong>デバイス</strong>:<ul><li>仮想サーバーの詳細の表示</li><li>サーバーのリブートと IPMI システム情報の表示</li><li>サーバーのアップグレード</li><li>OS 再ロードの発行とレスキュー・カーネルの開始</li></ul>
     <strong>サービス</strong>:<ul><li>SSH 鍵の管理</li></ul>
     <strong>アカウント</strong>: <ul><li>アカウント要約の表示</li><li>クラウド・インスタンスの追加/アップグレード</li><li>サーバーのキャンセル</li><li>サーバーの追加</li></ul></td>
     </tr>
     <tr>
     <td><strong>ストレージ</strong>: <ul><li>永続ボリューム請求を作成して永続ボリュームをプロビジョンする。</li><li>ストレージ・インフラストラクチャー・リソースを作成および管理する。</li></ul></td>
     <td><strong>サービス</strong>:<ul><li>ストレージの管理</li></ul><strong>アカウント</strong>: <ul><li>ストレージの追加</li></ul></td>
     </tr>
     <tr>
     <td><strong>プライベート・ネットワーキング</strong>: <ul><li>クラスター内ネットワーキング用プライベート VLAN を管理する。</li><li>プライベート・ネットワークへの VPN 接続をセットアップする。</li></ul></td>
     <td><strong>ネットワーク</strong>:<ul><li>ネットワーク・サブネット経路の管理</li><li>ネットワーク VLAN スパンニングの管理</li><li>IPSEC ネットワーク・トンネルの管理</li><li>ネットワーク・ゲートウェイの管理</li><li>VPN 管理</li></ul></td>
     </tr>
     <tr>
     <td><strong>パブリック・ネットワーキング</strong>:<ul><li>アプリを公開するためにパブリック・ロード・バランサーまたは Ingress ネットワーキングをセットアップする。</li></ul></td>
     <td><strong>デバイス</strong>:<ul><li>ロード・バランサーの管理</li><li>ホスト名/ドメインの編集</li><li>ポート・コントロールの管理</li></ul>
     <strong>ネットワーク</strong>:<ul><li>パブリック・ネットワーク・ポートのコンピュートを追加</li><li>ネットワーク・サブネット経路の管理</li><li>ネットワーク VLAN スパンニングの管理</li><li>IP アドレスの追加</li></ul>
     <strong>サービス</strong>:<ul><li>DNS、リバース DNS、WHOIS の管理</li><li>証明書 (SSL) の表示</li><li>証明書 (SSL) の管理</li></ul></td>
     </tr>
     </tbody></table>

5.  変更を保存するには、**「ポータル許可の編集」**をクリックします。

6.  **「デバイス・アクセス」**タブで、アクセス権限を付与するデバイスを選択します。

    * **「デバイス・タイプ」**ドロップダウンで、**「すべての仮想サーバー」**に対するアクセス権限を付与できます。
    * 作成される新しいデバイスへのアクセスをユーザーに許可するには、**「新規デバイスが追加されたときに自動的にアクセス権限を付与します」**にチェック・マークを付けます。
    * 変更を保存するには、**「デバイスへのアクセス権限の更新」**をクリックします。

7.  ユーザー・プロファイル・リストに戻り、**デバイス・アクセス権限**が付与されていることを確認します。

## カスタム Kubernetes RBAC 役割によるユーザーの許可
{: #rbac}

[アクセス・ポリシーと許可](#access_policies)で説明したように、{{site.data.keyword.containershort_notm}} アクセス・ポリシーは、Kubernetes の役割ベース・アクセス制御 (RBAC) の特定の役割に対応しています。対応するアクセス・ポリシーとは異なる他の Kubernetes 役割を許可するには、RBAC 役割をカスタマイズしたものを個人またはユーザー・グループに割り当てます。
{: shortdesc}

例えば、開発者チームに、特定の API グループを使用する許可や、クラスター全体ではなくクラスター内の特定の Kubernetes 名前空間内のリソースを使用する許可を付与したい場合があります。その場合は、役割を作成した後、{{site.data.keyword.containershort_notm}} に固有のユーザー名を使用して、ユーザーに役割をバインドします。詳しくは、Kubernetes 資料の [Using RBAC Authorization ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) を参照してください。

始めに、[Kubernetes CLI のターゲットをクラスターにします](cs_cli_install.html#cs_cli_configure)。

1.  割り当てるアクセス権限を含む役割を作成します。

    1. 割り当てるアクセス権限を含む役割を定義するための `.yaml` ファイルを作成します。

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>表。 この YAML の構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> この YAML の構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>単一の名前空間に含まれているリソースへのアクセス権限を付与する場合は `Role` を使用し、クラスター全体のリソースの場合は `ClusterRole` を使用します。</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Kubernetes 1.8 以降を実行するクラスターの場合は、`rbac.authorization.k8s.io/v1` を使用します。</li><li>それより前のバージョンの場合は、`apiVersion: rbac.authorization.k8s.io/v1beta1` を使用します。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>kind が `Role` の場合: アクセス権限を付与する Kubernetes 名前空間を指定します。</li><li>クラスター・レベルで適用される `ClusterRole` を作成する場合、`namespace` フィールドは使用しないでください。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>役割に名前を付けます。この名前を、後で役割をバインドするときに使用します。</td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>ユーザーに対話を許可する Kubernetes API グループ (`"apps"`、`"batch"`、`"extensions"` など) を指定します。</li><li>REST パス `api/v1` にあるコア API グループに対するアクセス権限については、`[""]` のようにグループをブランクにします。</li><li>詳しくは、Kubernetes 資料の [API groups ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/api-overview/#api-groups) を参照してください。</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>アクセス権限を付与する Kubernetes リソース (`"daemonsets"`、`"deployments"`、`"events"`、`"ingresses"` など) を指定します。</li><li>`"nodes"` を指定する場合、役割の kind は `ClusterRole` でなければなりません。</li><li>リソースのリストについては、Kubernetes チートシート [Resource types ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) にある表を参照してください。</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>ユーザーに実行を許可するアクションのタイプ (`"get"`、`"list"`、`"describe"`、`"create"`、`"delete"` など) を指定します。</li><li>verb の完全なリストについては、[`kubectl` 資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands) を参照してください。</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  クラスター内に役割を作成します。

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  役割が作成されたことを確認します。

        ```
        kubectl get roles
        ```
        {: pre}

2.  ユーザーを役割にバインドします。

    1. ユーザーを役割にバインドするための `.yaml` ファイルを作成します。各件名 (subject) の name に使用している固有の URL に注目してください。

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>表。 この YAML の構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> この YAML の構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>役割用の `.yaml` ファイルのタイプが `Role` (名前空間) でも `ClusterRole` (クラスター全体) でも、`kind` には `RoleBinding` を指定します。</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Kubernetes 1.8 以降を実行するクラスターの場合は、`rbac.authorization.k8s.io/v1` を使用します。</li><li>それより前のバージョンの場合は、`apiVersion: rbac.authorization.k8s.io/v1beta1` を使用します。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>kind が `Role` の場合: アクセス権限を付与する Kubernetes 名前空間を指定します。</li><li>クラスター・レベルで適用される `ClusterRole` を作成する場合、`namespace` フィールドは使用しないでください。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>この役割バインディングの名前を指定します。</td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>kind には `User` を指定します。</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>ユーザーの E メール・アドレスを URL `https://iam.ng.bluemix.net/kubernetes#` に付加します。</li><li>例えば、`https://iam.ng.bluemix.net/kubernetes#user1@example.com` のようにします。</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>`rbac.authorization.k8s.io` を使用します。</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>役割用の `.yaml` ファイルの `kind` と同じ値 (`Role` または `ClusterRole`) を入力します。</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>役割用の `.yaml` ファイルの名前を入力します。</td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>`rbac.authorization.k8s.io` を使用します。</td>
        </tr>
        </tbody>
        </table>

    2. クラスター内に役割バインディング・リソースを作成します。

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  バインディングが作成されたことを確認します。

        ```
        kubectl get rolebinding
        ```
        {: pre}

カスタム Kubernetes RBAC 役割を作成してバインドしたので、ユーザーをフォローアップします。役割を介して実行許可を持っているアクション (ポッドを削除するなど) をテストするようにユーザーに依頼してください。
