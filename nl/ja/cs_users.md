---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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

クラスターへのアクセス権限を組織内の他のユーザーに付与することができます。そのようにすると、許可ユーザーだけがクラスターの作業を行い、アプリをクラスターにデプロイすることができます。
{:shortdesc}


## クラスター・アクセス権限の管理
{: #managing}

{{site.data.keyword.containershort_notm}} で操作をするすべてのユーザーに、ユーザーが実行可能なアクションを指定するサービス固有のユーザー役割を組み合わせて割り当てる必要があります。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} アクセス・ポリシー</dt>
<dd>ID およびアクセス管理において、{{site.data.keyword.containershort_notm}} アクセス・ポリシーは、クラスターで実行できるクラスター管理アクション (クラスターの作成または削除、ワーカー・ノードの追加または削除など) を判別します。 これらのポリシーは、インフラストラクチャー・ポリシーとともに設定する必要があります。</dd>
<dt>インフラストラクチャー・アクセス・ポリシー</dt>
<dd>ID およびアクセス管理において、インフラストラクチャー・アクセス・ポリシーにより、{{site.data.keyword.containershort_notm}} ユーザー・インターフェースまたは CLI から要求されたアクションが IBM Cloud インフラストラクチャー (SoftLayer) 内で完了できるようになります。 これらのポリシーは、{{site.data.keyword.containershort_notm}} アクセス・ポリシーとともに設定する必要があります。 [インフラストラクチャーで選択可能な役割について詳しくは、こちらをご覧ください](/docs/iam/infrastructureaccess.html#infrapermission)。</dd>
<dt>リソース・グループ</dt>
<dd>リソース・グループは、各 {{site.data.keyword.Bluemix_notm}} サービスをいくつかのグループに編成したもので、これを使用すると、複数のリソースへのアクセス権限を各ユーザーに一度に素早く割り当てることができます。 [リソース・グループを使用してユーザーを管理する方法を参照してください](/docs/account/resourcegroups.html#rgs)。</dd>
<dt>Cloud Foundry の役割</dt>
<dd>Identity and Access Management では、すべてのユーザーに、Cloud Foundry ユーザー役割を割り当てる必要があります。 この役割は、ユーザーが {{site.data.keyword.Bluemix_notm}} アカウントで実行できるアクション (他のユーザーの招待や割り当て分の使用率の表示など) を決定します。 [Cloud Foundry で選択可能な役割について詳しくは、こちらをご覧ください](/docs/iam/cfaccess.html#cfaccess)。</dd>
<dt>Kubernetes RBAC の役割</dt>
<dd>{{site.data.keyword.containershort_notm}} アクセス・ポリシーが割り当てられているすべてのユーザーには、Kubernetes RBAC 役割が自動的に割り当てられます。 Kubernetes では、RBAC 役割によって、クラスター内の Kubernetes リソースに対して実行できるアクションが決まります。 RBAC 役割は、デフォルトの名前空間に関してのみセットアップされます。 クラスター管理者は、クラスター内の他の名前空間の RBAC 役割を追加できます。 詳しくは、Kubernetes 資料の [Using RBAC Authorization ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) を参照してください。</dd>
</dl>

<br />


## アクセス・ポリシーと許可
{: #access_policies}

{{site.data.keyword.Bluemix_notm}} アカウント内のユーザーに付与できるアクセス・ポリシーと許可について説明します。 オペレーターの役割とエディターの役割は別個のアクセス権です。 例えば、ワーカー・ノードを追加してサービスをバインドする操作をユーザーに実行させるには、そのユーザーにオペレーターとエディターの両方の役割を割り当てる必要があります。 ユーザーのアクセス・ポリシーを変更すると、クラスター内の変更に関連付けられている RBAC ポリシーが {{site.data.keyword.containershort_notm}} によって自動的にクリーンアップされます。

|{{site.data.keyword.containershort_notm}} アクセス・ポリシー|クラスター管理許可|Kubernetes リソース許可|
|-------------|------------------------------|-------------------------------|
|管理者|この役割は、対象アカウントのすべてのクラスターのエディター、オペレーター、およびビューアーの役割から許可を継承します。 <br/><br/>すべての現行サービス・インスタンスに設定された場合:<ul><li>フリー・クラスターまたは標準クラスターを作成する</li><li>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするための {{site.data.keyword.Bluemix_notm}} アカウントの資格情報を設定する</li><li>クラスターを削除する</li><li>対象アカウント内の他の既存ユーザーの {{site.data.keyword.containershort_notm}} アクセス・ポリシーの割り当てと変更。</li></ul><p>特定のクラスター ID に設定された場合:<ul><li>特定のクラスターを削除する</li></ul></p>対応するインフラストラクチャー・アクセス・ポリシー: スーパーユーザー<br/><br/><b>注</b>: マシン、VLAN、サブネットなどのリソースを作成するには、ユーザーにインフラストラクチャーの**スーパーユーザー**役割が必要です。|<ul><li>RBAC 役割: クラスター管理</li><li>すべての名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li><li>Kubernetes ダッシュボードにアクセスする</li><li>アプリをだれでも利用できるようにする Ingress リソースを作成する</li></ul>|
|オペレーター|<ul><li>クラスターにワーカー・ノードを追加する</li><li>クラスターからワーカー・ノードを削除する</li><li>ワーカー・ノードをリブートする</li><li>ワーカー・ノードを再ロードする</li><li>クラスターにサブネットを追加する</li></ul><p>対応するインフラストラクチャー・アクセス・ポリシー: 基本ユーザー</p>|<ul><li>RBAC 役割: 管理者</li><li>名前空間自体ではなく、デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li></ul>|
|エディター <br/><br/><b>ヒント</b>: アプリ開発者には、この役割を使用してください。|<ul><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにバインドします。</li><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにアンバインドします。</li><li>Web フックを作成します。</li></ul><p>対応するインフラストラクチャー・アクセス・ポリシー: 基本ユーザー|<ul><li>RBAC 役割: 編集</li><li>デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li></ul></p>|
|ビューアー|<ul><li>クラスターをリスト表示する</li><li>クラスターの詳細を表示する</li></ul><p>対応するインフラストラクチャー・アクセス・ポリシー: 表示のみ</p>|<ul><li>RBAC 役割: 表示</li><li>デフォルトの名前空間内にあるリソースに対する読み取りアクセス</li><li>Kubernetes シークレットに対する読み取りアクセス権限はなし</li></ul>|

|Cloud Foundry アクセス・ポリシー|アカウント管理許可|
|-------------|------------------------------|
|組織の役割: 管理者|<ul><li>{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加する</li></ul>| |
|スペースの役割: 開発者|<ul><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスを作成する</li><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターにバインドする</li></ul>| 

<br />


## {{site.data.keyword.Bluemix_notm}} アカウントへのユーザーの追加
{: #add_users}

{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加して、クラスターへのアクセス権限を付与できます。

始める前に、{{site.data.keyword.Bluemix_notm}} アカウントに対する Cloud Foundry の管理者役割が自分に割り当てられていることを確認してください。

1.  [ユーザーをアカウントに追加します](../iam/iamuserinv.html#iamuserinv)。
2.  **「アクセス」**セクションで**「サービス」**を展開します。
3.  {{site.data.keyword.containershort_notm}} アクセス権限の役割を割り当てます。 **「アクセス権限の割り当て先 (Assign access to)」**ドロップダウン・リストから、アクセス権限を {{site.data.keyword.containershort_notm}} アカウント (**リソース**) のみに付与するか、それともアカウント内のさまざまなリソースの集合 (**リソース・グループ**) に付与するかを決定します。
  -  **リソース**の場合:
      1. **「サービス」**ドロップダウン・リストで、**「{{site.data.keyword.containershort_notm}}」**を選択します。
      2. **「地域」**ドロップダウン・リストから、ユーザーを招待する地域を選択します。
      3. **「サービス・インスタンス」**ドロップダウン・リストから、ユーザーを招待するクラスターを選択します。 特定のクラスターの ID を確認するには、
`bx cs clusters` を実行します。
      4. **「役割の選択」**セクションで、役割を選択します。 役割別のサポート対象アクションの一覧については、[アクセス・ポリシーと許可](#access_policies)を参照してください。
  - **リソース・グループ**の場合:
      1. **「リソース・グループ」**ドロップダウン・リストから、自分のアカウントの {{site.data.keyword.containershort_notm}} リソースに対するアクセス権を付与されたリソース・グループを選択します。
      2. **「リソース・グループへのアクセス権限の割り当て (Assign access to a resource group)」**ドロップダウン・リストから、役割を選択します。 役割別のサポート対象アクションの一覧については、[アクセス・ポリシーと許可](#access_policies)を参照してください。
4. [オプション: インフラストラクチャーの役割を割り当てます](/docs/iam/mnginfra.html#managing-infrastructure-access)。
5. [オプション: Cloud Foundry の役割を割り当てます](/docs/iam/mngcf.html#mngcf)。
5. **「ユーザーの招待」**をクリックします。

<br />


## ユーザーのインフラストラクチャー許可のカスタマイズ
{: #infra_access}

ID およびアクセス管理でインフラストラクチャー・ポリシーを設定すると、ユーザーには役割に関連付けられた許可が付与されます。 それらの許可をカスタマイズするには、IBM Cloud インフラストラクチャー (SoftLayer) にログインし、そこで許可を調整する必要があります。
{: #view_access}

例えば、基本ユーザーはワーカー・ノードをリブートできますが、ワーカー・ノードを再ロードすることはできません。 そのユーザーにスーパーユーザー権限を付与しなくても、IBM Cloud インフラストラクチャー (SoftLayer) の許可を調整して、再ロード・コマンドを実行する許可を追加できます。

1.  IBM Cloud インフラストラクチャー (SoftLayer) アカウントにログインします。
2.  更新するユーザー・プロファイルを選択します。
3.  **「ポータルの許可」**で、ユーザーのアクセス権限をカスタマイズします。 例えば、再ロード許可を追加するには、**「デバイス」**タブで**「OS 再ロードの発行とレスキュー・カーネルの開始」**を選択します。
9.  変更を保存します。
