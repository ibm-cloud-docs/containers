---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# クラスター・アクセス権限の割り当て
{: #users}

クラスター管理者は、Kubernetes クラスターのアクセス・ポリシーを定義して、さまざまなユーザーに対してさまざまなレベルのアクセス権限を作成することができます。 例えば、特定のユーザーにはクラスター・リソースを使用する権限を与える一方で、他のユーザーにはコンテナーをデプロイする権限だけを与えることができます。
{: shortdesc}


## アクセス・ポリシーと許可について
{: #access_policies}

<dl>
  <dt>アクセス・ポリシーを設定する必要がありますか?</dt>
    <dd>{{site.data.keyword.containerlong_notm}} を使用するすべてのユーザー用にアクセス・ポリシーを定義する必要があります。 アクセス・ポリシーの適用範囲は、実行を許可する操作を定義するためのユーザー定義役割に基づきます。 事前定義されているポリシーもあれば、カスタマイズ可能なポリシーもあります。 ユーザーが要求の実行に {{site.data.keyword.containerlong_notm}} GUI を使用しようと CLI を使用しようと、また、IBM Cloud インフラストラクチャー (SoftLayer) で操作を実行しようと、同じポリシーが適用されます。</dd>

  <dt>許可のタイプは?</dt>
    <dd><p><strong>プラットフォーム</strong>: {{site.data.keyword.containerlong_notm}} は、クラスターで個々のユーザーが実行できる操作を決定するために {{site.data.keyword.Bluemix_notm}} プラットフォームの役割を使用するように構成されています。 役割の権限は、互いの権限を基に構築されています。つまり、`Editor` 役割には、`Viewer` 役割と同じ権限すべてに加えて、エディターに付与される権限があります。 これらのポリシーは地域ごとに設定できます。 これらのポリシーは、インフラストラクチャー・ポリシーと一緒に設定する必要があり、デフォルトの名前空間に自動的に割り当てられる対応 RBAC 役割を持っていなければなりません。 操作の例として、クラスターの作成や削除、ワーカー・ノードの追加などがあります。</p> <p><strong>インフラストラクチャー</strong>: クラスター・ノード・マシン、ネットワーキング、ストレージ・リソースなどのインフラストラクチャーに対するアクセス・レベルを定義できます。 このタイプのポリシーは、{{site.data.keyword.containerlong_notm}} プラットフォーム・アクセス・ポリシーと一緒に設定する必要があります。 選択可能な役割について詳しくは、[インフラストラクチャーの許可](/docs/iam/infrastructureaccess.html#infrapermission)を参照してください。 特定のインフラストラクチャーの役割を付与することに加え、インフラストラクチャーを操作するユーザーにデバイス・アクセス権限を付与する必要もあります。 役割の割り当てを開始するには、[ユーザーのインフラストラクチャー許可のカスタマイズ](#infra_access)の手順に従ってください。 <strong>注</strong>: 権限のあるユーザーが、割り当てられている権限に基づいて IBM Cloud インフラストラクチャー (SoftLayer) アカウントでアクションを実行できるようにするために、ご使用の {{site.data.keyword.Bluemix_notm}} アカウントに [IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセス権限がセットアップされている](cs_troubleshoot_clusters.html#cs_credentials)ことを確認してください。</p> <p><strong>RBAC</strong>: 役割ベース・アクセス制御 (RBAC) は、クラスター内部のリソースを保護し、どのユーザーがどの Kubernetes 操作を実行できるかを決めるための方法です。プラットフォームのアクセス・ポリシーが割り当てられているすべてのユーザーに、Kubernetes 役割が自動的に割り当てられます。 Kubernetes では、[Role Based Access Control (RBAC) ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) によって、ユーザーがクラスター内部のリソースに対して実行できる操作が決まります。 <strong>注</strong>: RBAC 役割は、デフォルト名前空間のプラットフォーム役割とともに自動的に設定されます。 クラスター管理者は、他の名前空間に対して[役割の更新や割り当て](#rbac)を行うことができます。</p> <p><strong>Cloud Foundry</strong>: すべてのサービスを Cloud IAM で管理できるわけではありません。 管理できないサービスを使用している場合は、今後も [Cloud Foundry ユーザー役割](/docs/iam/cfaccess.html#cfaccess)を使用してサービスへのアクセス権限を管理できます。 アクションの例として、サービスのバインドや新規サービス・インスタンスの作成があります。</p></dd>

  <dt>許可の設定方法は?</dt>
    <dd><p>プラットフォームの許可を設定すると、特定のユーザー、ユーザーのグループ、またはデフォルトのリソース・グループにアクセス権限を割り当てることができます。 プラットフォームの許可を設定すると、RBAC 役割が、デフォルトの名前空間に対して自動的に構成され、RoleBinding が作成されます。</p>
    <p><strong>ユーザー</strong>: チームの他のユーザーとは異なる許可を必要とする特定のユーザーがいる場合があります。 各人がそれぞれのタスクを完了するために必要な適切な許可を持つように、個人レベルで許可をカスタマイズできます。</p>
    <p><strong>アクセス・グループ</strong>: ユーザーのグループを作成して、特定のグループに許可を割り当てることができます。 例えば、チーム・リーダー全員をグループ化して、そのグループに管理者権限を与えることができます。 一方、開発者のグループには書き込み権限しかありません。</p>
    <p><strong>リソース・グループ</strong>: IAM を使用すると、リソース・グループのアクセス・ポリシーを作成し、ユーザーにこのグループへのアクセス権限を付与することができます。 これらのリソースは、1 つの {{site.data.keyword.Bluemix_notm}} サービスの一部にすることも、{{site.data.keyword.containerlong_notm}} クラスターや CF アプリなどのサービス・インスタンスにわたってリソースをグループ化することもできます。</p> <p>**重要**: {{site.data.keyword.containerlong_notm}} は、<code>default</code> リソース・グループのみをサポートします。 すべてのクラスター関連リソースは、自動的に <code>default</code> リソース・グループで使用可能になります。 クラスターで使用する {{site.data.keyword.Bluemix_notm}} アカウントの他のサービスがある場合は、それらのサービスも <code>default</code> リソース・グループに含まれている必要があります。</p></dd>
</dl>


難しく感じますか? [ユーザー、チーム、アプリケーションを編成するためのベスト・プラクティス](/docs/tutorials/users-teams-applications.html)に関するこのチュートリアルを試してみてください。
{: tip}

<br />


## IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセス
{: #api_key}

<dl>
  <dt>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスする必要があるのはなぜですか?</dt>
    <dd>アカウントでクラスターを正常にプロビジョンして使用するには、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスできるようにアカウントを正しくセットアップしておく必要があります。 アカウントのセットアップに応じて、IAM API キーまたはインフラストラクチャー資格情報 (`ibmcloud ks credentials-set` コマンドを使用して手動で設定) のいずれかを使用します。</dd>

  <dt>IAM API キーと {{site.data.keyword.containerlong_notm}} はどのように連携していますか?</dt>
    <dd><p>IAM (ID およびアクセス管理) の API キーは、{{site.data.keyword.containerlong_notm}} 管理アクセス・ポリシーを必要とする最初のアクションを実行したときに、地域に対して自動的に設定されます。 例えば、管理ユーザーの 1 人が <code>us-south</code> 地域に最初のクラスターを作成したとします。 これにより、その地域に対してこのユーザーの IAM API キーがアカウントに保管されます。 新しいワーカー・ノードや VLAN などの IBM Cloud インフラストラクチャー (SoftLayer) を注文する際には、この API キーが使用されます。</p> <p>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオとのやりとりが必要なアクション (例えば、新規クラスターの作成やワーカー・ノードの再ロードなど) を別のユーザーがこの地域で実行すると、保管されている API キーを基に、そのアクションを実行できるだけの権限があるかどうかが判断されます。 インフラストラクチャー関連のアクションをクラスター内で正常に実行するためには、{{site.data.keyword.containerlong_notm}} 管理ユーザーにインフラストラクチャー・アクセス・ポリシーの<strong>スーパーユーザー</strong>を割り当ててください。</p> <p>現在の API キー所有者を調べるには、[<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info) を実行します。地域に対して保管されている API キーを更新する必要があることがわかった場合は、[<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) コマンドを実行して更新できます。 このコマンドには {{site.data.keyword.containerlong_notm}} 管理アクセス・ポリシーが必要です。このコマンドを実行すると、実行したユーザーの API キーがアカウントに保管されます。 <code>ibmcloud ks credentials-set</code> コマンドを使用して手動で IBM Cloud インフラストラクチャー (SoftLayer) 資格情報を設定した場合、地域に対して保管されている API キーは使用されない可能性があります。</p> <p><strong>注:</strong> キーをリセットする場合、アプリへの影響を確認してください。 キーは、複数の異なる場所で使用されるので、不必要に変更されると破壊的変更が発生する可能性があります。</p></dd>

  <dt><code>ibmcloud ks credentials-set</code> コマンドの機能は?</dt>
    <dd><p>{{site.data.keyword.Bluemix_notm}} 従量制課金アカウントがあれば、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにデフォルトでアクセスできます。 ただし、既に所有している別の IBM Cloud インフラストラクチャー (SoftLayer) アカウントを使用して、地域内のクラスター用のインフラストラクチャーを注文することがあります。[<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set) コマンドを使用すると、そのようなインフラストラクチャー・アカウントを {{site.data.keyword.Bluemix_notm}} アカウントにリンクできます。</p> <p>手動で設定した IBM Cloud インフラストラクチャー (SoftLayer) の資格情報を削除するには、[<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) コマンドを使用します。 資格情報が削除されると、IAM API キーがインフラストラクチャーの注文に使用されます。</p></dd>

  <dt>インフラストラクチャー資格情報と API キーの間に違いはありますか?</dt>
    <dd>API キーと <code>ibmcloud ks credentials-set</code> コマンドの両方とも同じタスクを達成します。 <code>ibmcloud ks credentials-set</code> コマンドを使用して手動で資格情報を設定すると、API キーにより付与されているアクセス権限は、設定した資格情報によりオーバーライドされます。 ただし、資格情報が保管されているユーザーにインフラストラクチャーを注文するために必要な権限がない場合、クラスターを作成したりワーカー・ノードを再ロードしたりするインフラストラクチャー関連のアクションは失敗する可能性があります。</dd>
    
  <dt>インフラストラクチャー・アカウントの資格情報が異なるアカウントを使用するように設定されているかどうかを確認するには、どうすればよいですか?</dt>
    <dd>[{{site.data.keyword.containerlong_notm}} GUI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/containers-kubernetes/clusters) を開き、クラスターを選択します。**「概要」**タブで、**「インフラストラクチャー・ユーザー (Infrastructure User)」**フィールドを探します。このフィールドが表示されている場合は、この地域の従量課金 (PAYG) アカウントに付属しているデフォルトのインフラストラクチャー資格情報を使用していません。代わりに、地域は、異なるインフラストラクチャー・アカウントの資格情報を使用するように設定されています。</dd>

  <dt>IBM Cloud インフラストラクチャー (SoftLayer) の許可をより簡単に割り当てる方法がありますか?</dt>
    <dd><p>ユーザーは通常、特定の IBM Cloud インフラストラクチャー (SoftLayer) の許可を必要としません。代わりに、正しいインフラストラクチャー許可を持つ API キーをセットアップし、クラスターを必要とする各地域でその API キーを使用します。API キーは、管理および監査の容易さに応じて、アカウント所有者 (機能 ID) またはユーザーに属することができます。</p> <p>新しい地域内にクラスターを作成する場合は、適切なインフラストラクチャー資格情報を使用してセットアップした API キーの所有者によって最初のクラスターが作成されていることを確認します。その後、個々のユーザー、IAM グループ、またはサービス・アカウントのユーザーをその地域に招待できます。アカウント内のユーザーは、ワーカー・ノードの追加などのインフラストラクチャーのアクションを実行するために API キーの資格情報を共有します。ユーザーが実行できるインフラストラクチャーのアクションを制御するには、IAM で適切な {{site.data.keyword.containerlong_notm}} 役割を割り当てます。</p><p>例えば、IAM 役割 `Viewer` を持つユーザーは、ワーカー・ノードの追加を許可されていません。したがって、API キーに正しいインフラストラクチャー許可があっても、`worker-add` アクションは失敗します。IAM でユーザー役割を `Operator` に変更すると、ユーザーはワーカー・ノードを追加することを許可されます。ユーザー役割が許可され、API キーが正しく設定されるため、`worker-add` アクションは成功します。ユーザーの IBM Cloud インフラストラクチャー (SoftLayer) の許可を編集する必要はありません。</p> <p>権限の設定について詳しくは、[ユーザーのインフラストラクチャー許可のカスタマイズ](#infra_access)を確認してください。</p></dd>
</dl>


<br />



## 役割の関係について
{: #user-roles}

各アクションをどの役割が実行できるのかを理解する前に、役割がどのように連携しているかを理解することが重要です。
{: shortdesc}

以下の図は、組織内の各タイプの担当者が必要とする役割を示しています。 ただし、組織ごとに内容は異なります。 一部のユーザーには、インフラストラクチャーのカスタム許可が必要な場合があります。必ず [IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセス](#api_key)に目を通し、IBM Cloud インフラストラクチャー (SoftLayer) の許可の内容と、どのユーザーにどの権限が必要かについて学習してください。 

![{{site.data.keyword.containerlong_notm}} アクセス役割](/images/user-policies.png)

図. 役割のタイプごとの {{site.data.keyword.containerlong_notm}} アクセス許可

<br />



## GUI を使用した役割の割り当て
{: #add_users}

GUI を使用して、{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加し、クラスターへのアクセス権限を付与できます。
{: shortdesc}

**始める前に**

- ユーザーがアカウントに追加されていることを確認します。 そうでなければ、[それら](../iam/iamuserinv.html#iamuserinv)を追加します。
- 作業をしている {{site.data.keyword.Bluemix_notm}} アカウントに対する [Cloud Foundry 役割](/docs/iam/mngcf.html#mngcf)の`管理者`が自分に割り当てられていることを確認します。

**ユーザーにアクセス権限を割り当てるには**

1. **「管理」>「ユーザー」**にナビゲートします。 アカウントにアクセスできるユーザーのリストが表示されます。

2. 許可を設定するユーザーの名前をクリックします。 ユーザーが表示されていない場合は、**「ユーザーの招待」**をクリックして、アカウントにユーザーを追加します。

3. ポリシーを割り当てます。
  * リソース・グループの場合:
    1. **デフォルト**のリソース・グループを選択します。 {{site.data.keyword.containerlong_notm}} のアクセスは、デフォルトのリソース・グループに対してのみ構成できます。
  * 特定のリソースの場合:
    1. **「サービス」**リストで、**「{{site.data.keyword.containerlong_notm}}」**を選択します。
    2. **「地域」**リストから、地域を選択します。
    3. **「サービス・インスタンス」**リストから、ユーザーを招待するクラスターを選択します。 特定のクラスターの ID を確認するには、`ibmcloud ks clusters` を実行します。

4. **「役割の選択」**セクションで、役割を選択します。 

5. **「割り当て」**をクリックします。

6. [Cloud Foundry の役割](/docs/iam/mngcf.html#mngcf)を割り当てます。

7. オプション: [インフラストラクチャーの役割](/docs/iam/infrastructureaccess.html#infrapermission)を割り当てます。

</br>

**グループにアクセス権限を割り当てるには**

1. **「管理」>「アクセス・グループ」**にナビゲートします。

2. アクセス・グループを作成します。
  1. **「作成」**をクリックして、グループに**「名前」**と**「説明」**を指定します。 **「作成」**をクリックします。
  2. **「ユーザーの追加」**をクリックして、ユーザーをアクセス・グループに追加します。 アカウントにアクセスできるユーザーのリストが表示されます。
  3. グループに追加するユーザーの横のボックスにチェック・マークを付けます。 ダイアログ・ボックスが表示されます。
  4. **「グループに追加」**をクリックします。

3. 特定のサービスにアクセス権限を割り当てるには、サービス ID を追加します。
  1. **「サービス ID の追加」**をクリックします。
  2. グループに追加するユーザーの横のボックスにチェック・マークを付けます。 ポップアップが表示されます。
  3. **「グループに追加」**をクリックします。

4. アクセス・ポリシーを割り当てます。 グループに追加するユーザーの再確認を忘れないでください。 グループ内のすべてのユーザーには、同じレベルのアクセス権限が付与されます。
    * リソース・グループの場合:
        1. **デフォルト**のリソース・グループを選択します。 {{site.data.keyword.containerlong_notm}} のアクセスは、デフォルトのリソース・グループに対してのみ構成できます。
    * 特定のリソースの場合:
        1. **「サービス」**リストで、**「{{site.data.keyword.containerlong_notm}}」**を選択します。
        2. **「地域」**リストから、地域を選択します。
        3. **「サービス・インスタンス」**リストから、ユーザーを招待するクラスターを選択します。 特定のクラスターの ID を確認するには、`ibmcloud ks clusters` を実行します。

5. **「役割の選択」**セクションで、役割を選択します。 

6. **「割り当て」**をクリックします。

7. [Cloud Foundry の役割](/docs/iam/mngcf.html#mngcf)を割り当てます。

8. オプション: [インフラストラクチャーの役割](/docs/iam/infrastructureaccess.html#infrapermission)を割り当てます。

<br />



## CLI を使用した役割の割り当て
{: #add_users_cli}

CLI を使用して、{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加し、クラスターへのアクセス権限を付与できます。
{: shortdesc}

**始める前に**

作業をしている {{site.data.keyword.Bluemix_notm}} アカウントに対する [Cloud Foundry 役割](/docs/iam/mngcf.html#mngcf)の`管理者`が自分に割り当てられていることを確認します。

**特定のユーザーにアクセス権限を割り当てるには**

1. 自分のアカウントにユーザーを招待します。
  ```
  ibmcloud account user-invite <user@email.com>
  ```
  {: pre}
2. {{site.data.keyword.containerlong_notm}} の権限を設定するための IAM アクセス・ポリシーを作成します。役割には、「Viewer」、「Editor」、「Operator」、および「Administrator」のいずれかを選択できます。
  ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

**グループにアクセス権限を割り当てるには**

1. ユーザーがまだアカウントの一部になっていない場合は、招待します。
  ```
  ibmcloud account user-invite <user_email>
  ```
  {: pre}

2. グループを作成します。
  ```
  ibmcloud iam access-group-create <team_name>
  ```
  {: pre}

3. ユーザーをグループに追加します。
  ```
  ibmcloud iam access-group-user-add <team_name> <user_email>
  ```
  {: pre}

4. ユーザーをグループに追加します。 役割には、「Viewer」、「Editor」、「Operator」、および「Administrator」のいずれかを選択できます。
  ```
  ibmcloud iam access-group-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

5. クラスター構成を更新して、RoleBinding を生成します。
  ```
  ibmcloud ks cluster-config
  ```
  {: pre}

  RoleBinding:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: <binding>
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: <role>
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: <group_name>
    namespace: default
  ```
  {: screen}

前の説明では、すべての {{site.data.keyword.containerlong_notm}} リソースに対するアクセス権をユーザーのグループに付与する方法を示しています。管理者は、地域レベルまたはクラスター・インスタンス・レベルでサービスへのアクセスを制限することもできます。
{: tip}

<br />


## RBAC 役割バインディングによるユーザーの許可
{: #role-binding}

各クラスターは、クラスターのデフォルトの名前空間に構成された事前定義の RBAC 役割を使用してセットアップされます。デフォルトの名前空間からクラスターの他の名前空間に RBAC 役割をコピーして、同じレベルのユーザー・アクセスを強制できます。

**RBAC RoleBinding とは何ですか?**

役割バインディングは、Kubernetes リソース固有のアクセス・ポリシーです。役割バインディングを使用して、名前空間、ポッド、またはクラスター内の他のリソースに固有のポリシーを設定できます。{{site.data.keyword.containerlong_notm}} は、IAM 内のプラットフォーム役割に対応する事前定義の RBAC 役割を提供します。ユーザーに IAM プラットフォーム役割を割り当てると、RBAC 役割バインディングは、クラスターのデフォルトの名前空間内のユーザーに対して自動的に作成されます。

**RBAC クラスター役割バインディングとは何ですか?**

RBAC 役割バインディングは名前空間やポッドなどの 1 つのリソースに固有のものですが、RBAC クラスター役割バインディングを使用すると、すべての名前空間を含むクラスター・レベルでアクセス権を設定することができます。プラットフォーム役割が設定されている場合、クラスター役割バインディングは、デフォルトの名前空間に自動的に作成されます。その役割バインディングを他の名前空間にコピーできます。


<table>
  <tr>
    <th>プラットフォームの役割</th>
    <th>RBAC 役割</th>
    <th>役割バインディング</th>
  </tr>
  <tr>
    <td>Viewer</td>
    <td>View</td>
    <td><code>ibm-view</code></td>
  </tr>
  <tr>
    <td>Editor</td>
    <td>Edit</td>
    <td><code>ibm-edit</code></td>
  </tr>
  <tr>
    <td>Operator</td>
    <td>Admin</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>管理者</td>
    <td>Cluster-admin</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

**RoleBinding の使用時には、特定の要件がありますか?**

IBM Helm チャートを使用するには、`kube-system` 名前空間に Tiller をインストールする必要があります。Tiller をインストールするには、`kube-system` 名前空間内に [`cluster-admin` 役割](cs_users.html#access_policies)が必要です。その他の Helm チャートの場合は、別の名前空間を選択できます。ただし、`helm` コマンドを実行する場合は、`tiller-namespace <namespace>` フラグを使用して、Tiller がインストールされている名前空間を指定する必要があります。


### RBAC RoleBinding のコピー

プラットフォーム・ポリシーを構成すると、デフォルトの名前空間に対してクラスター役割バインディングが自動的に生成されます。ポリシーを設定する名前空間でバインディングを更新することにより、バインディングを他の名前空間にコピーできます。例えば、サービス全体の `view` アクセス権を持つ `team-a` という開発者のグループがあり、そのグループには `teama` 名前空間への `edit` アクセス権が必要であるとします。自動的に生成された RoleBinding を編集して、リソース・レベルで必要なアクセス権を与えることができます。

1. [プラットフォーム役割を使用してアクセス権を割り当てる](#add_users_cli)ことによって、デフォルトの名前空間に対して RBAC 役割バインディングを作成します。
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}
  出力例:
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-view
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: View
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: default
  ```
  {: screen}
2. その構成を別の名前空間にコピーします。
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role> --namespace <namespace>
  ```
  {: pre}
  前のシナリオでは、別の名前空間になるように構成を変更しました。更新された構成は、以下のようになります。
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-edit
    namespace: teama
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: teama
  ```
  {: screen}

<br />




### カスタム Kubernetes RBAC 役割の作成
{: #rbac}

対応するプラットフォーム・アクセス・ポリシーとは異なる他の Kubernetes 役割を許可するには、RBAC 役割をカスタマイズしたものを個人またはユーザー・グループに割り当てます。
{: shortdesc}

IAM ポリシーで許可されるよりも粒度の高いクラスター・アクセス・ポリシーが必要ですか? 問題ありません。 特定の Kubernetes リソースのアクセス・ポリシーをユーザー、ユーザーのグループ (Kubernetes v1.11 以降を実行するクラスター内) またはサービス・アカウントに割り当てることができます。役割を作成し、その役割を特定のユーザーまたはグループにバインドすることができます。 詳しくは、Kubernetes 資料の [Using RBAC Authorization ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) を参照してください。

グループに対してバインディングが作成されると、そのグループに追加またはそのグループから削除されるすべてのユーザーに影響を与えます。 グループにユーザーを追加した場合、ユーザーにはアクセス権限が追加されます。 ユーザーを削除した場合、アクセス権限は取り消されます。
{: tip}

継続的デリバリー・ツールチェーンなどのサービスにアクセス権限を割り当てる場合、[Kubernetes サービス・アカウント ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/) を使用できます。

**始める前に**

- クラスターを [Kubernetes CLI](cs_cli_install.html#cs_cli_configure) のターゲットとして設定します。
- ユーザーまたはグループにサービス・レベルで最小限の `Viewer` アクセス権限があることを確認します。


**RBAC 役割をカスタマイズするには**

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
        <caption>この YAML の構成要素について</caption>
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
              <td><ul><li>Kubernetes 1.8 以降を実行するクラスターの場合は、`rbac.authorization.k8s.io/v1` を使用します。 </li><li>それより前のバージョンの場合は、`apiVersion: rbac.authorization.k8s.io/v1beta1` を使用します。</li></ul></td>
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
              <td><ul><li>ユーザーに対話を許可する Kubernetes API グループ (`"apps"`、`"batch"`、`"extensions"` など) を指定します。 </li><li>REST パス `api/v1` にあるコア API グループに対するアクセス権限については、`[""]` のようにグループをブランクにします。</li><li>詳しくは、Kubernetes 資料の [API groups ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) を参照してください。</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>アクセス権限を付与する Kubernetes リソース (`"daemonsets"`、`"deployments"`、`"events"`、`"ingresses"` など) を指定します。</li><li>`"nodes"` を指定する場合、役割の kind は `ClusterRole` でなければなりません。</li><li>リソースのリストについては、Kubernetes チートシート [Resource types ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) にある表を参照してください。</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>ユーザーに実行を許可するアクションのタイプ (`"get"`、`"list"`、`"describe"`、`"create"`、`"delete"` など) を指定します。 </li><li>verb の完全なリストについては、[`kubectl` 資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/kubectl/overview/) を参照してください。</li></ul></td>
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

    1. ユーザーを役割にバインドするための `.yaml` ファイルを作成します。 各件名 (subject) の name に使用している固有の URL に注目してください。

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>この YAML の構成要素について</caption>
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
              <td><ul><li>Kubernetes 1.8 以降を実行するクラスターの場合は、`rbac.authorization.k8s.io/v1` を使用します。 </li><li>それより前のバージョンの場合は、`apiVersion: rbac.authorization.k8s.io/v1beta1` を使用します。</li></ul></td>
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
              <td>次のいずれかの種類を指定します。
              <ul><li>`User`: RBAC 役割をアカウント内の個々のユーザーにバインドします。</li>
              <li>`Group`: Kubernetes 1.11 以降を実行するクラスターの場合、RBAC 役割をアカウント内の [IAM グループ](/docs/iam/groups.html#groups)にバインドします。</li>
              <li>`ServiceAccount`: RBAC 役割をクラスター内の名前空間のサービス・アカウントにバインドします。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**`User` の場合**: 個々のユーザーの E メール・アドレスを URL `https://iam.ng.bluemix.net/kubernetes#` に追加します。例えば、`https://iam.ng.bluemix.net/kubernetes#user1@example.com` のようにします。</li>
              <li>**`Group` の場合**: Kubernetes 1.11 以降を実行するクラスターの場合、アカウント内の [IAM グループ](/docs/iam/groups.html#groups)の名前を指定します。</li>
              <li>**`ServiceAccount` の場合**: サービス・アカウント名を指定します。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td><ul><li>**`User` または `Group` の場合**: `rbac.authorization.k8s.io` を使用します。</li>
              <li>**`ServiceAccount` の場合**: このフィールドを含めないでください。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/namespace</code></td>
              <td>**`ServiceAccount` の場合のみ**: サービス・アカウントがデプロイされる Kubernetes 名前空間の名前を指定します。</td>
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
        kubectl apply -f filepath/my_role_binding.yaml
        ```
        {: pre}

    3.  バインディングが作成されたことを確認します。

        ```
        kubectl get rolebinding
        ```
        {: pre}

カスタム Kubernetes RBAC 役割を作成してバインドしたので、ユーザーをフォローアップします。 役割を介して実行許可を持っているアクション (ポッドを削除するなど) をテストするようにユーザーに依頼してください。


<br />



## ユーザーのインフラストラクチャー許可のカスタマイズ
{: #infra_access}

ID およびアクセス管理でインフラストラクチャー・ポリシーを設定すると、ユーザーには役割に関連付けられた許可が付与されます。 事前定義されているポリシーもあれば、カスタマイズ可能なポリシーもあります。 それらの許可をカスタマイズするには、IBM Cloud インフラストラクチャー (SoftLayer) にログインし、そこで許可を調整する必要があります。
{: #view_access}

例えば、**基本ユーザー**はワーカー・ノードをリブートできますが、ワーカー・ノードを再ロードすることはできません。 そのユーザーに**スーパーユーザー**権限を付与しなくても、IBM Cloud インフラストラクチャー (SoftLayer) の許可を調整して、再ロード・コマンドを実行する許可を追加できます。

マルチゾーン・クラスターがある場合、IBM Cloud インフラストラクチャー (SoftLayer) アカウント所有者は、クラスター内で異なるゾーンのノードが通信できるように、VLAN スパンニングをオンにする必要があります。 アカウント所有者は、ユーザーが VLAN スパンニングを有効にできるように、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理 (Manage Network VLAN Spanning)」**許可をユーザーに割り当てることもできます。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](cs_cli_reference.html#cs_vlan_spanning_get)を使用します。
{: tip}


1.  [{{site.data.keyword.Bluemix_notm}} アカウント](https://console.bluemix.net/)にログインし、メニューから**「インフラストラクチャー」**を選択します。

2.  **「アカウント」** > **「ユーザー」** > **「ユーザー・リスト」**と進みます。

3.  許可を変更するには、ユーザー・プロファイルの名前または**「デバイス・アクセス」**列を選択します。

4.  **「ポータルの許可」**タブで、ユーザーのアクセス権限をカスタマイズします。 ユーザーが必要とする許可は、ユーザーが使用する必要があるインフラストラクチャー・リソースによって異なります。

    * **「クイック許可」**ドロップダウン・リストを使用して、**「スーパーユーザー」**役割を割り当てます。これにより、すべての許可がユーザーに付与されます。
    * **「クイック許可」**ドロップダウン・リストを使用して、**「基本ユーザー」**役割を割り当てます。これにより、すべての許可ではなくいくつかの必要な許可がユーザーに付与されます。
    * **「スーパーユーザー」**役割を指定してすべての許可を付与したくない場合や、**「基本ユーザー」**役割を超える許可を追加する必要がある場合は、次の表を参照してください。この表は、{{site.data.keyword.containerlong_notm}} で一般的な作業を行うために必要な許可を示しています。

    <table summary="一般的な {{site.data.keyword.containerlong_notm}} シナリオに必要なインフラストラクチャー許可。">
     <caption>一般的に必要な {{site.data.keyword.containerlong_notm}} のインフラストラクチャー許可</caption>
     <thead>
      <th>{{site.data.keyword.containerlong_notm}} の一般的な作業</th>
      <th>必要なインフラストラクチャー許可 (タブ別)</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>最小許可</strong>: <ul><li>クラスターを作成します。</li></ul></td>
         <td><strong>デバイス</strong>:<ul><li>Virtual Server の詳細の表示</li><li>サーバーのリブートと IPMI システム情報の表示</li><li>OS 再ロードの発行とレスキュー・カーネルの開始</li></ul><strong>アカウント</strong>: <ul><li>クラウド・インスタンスの追加/アップグレード</li><li>サーバーの追加</li></ul></td>
       </tr>
       <tr>
         <td><strong>クラスター管理</strong>: <ul><li>クラスターを作成、更新、削除する。</li><li>ワーカー・ノードを追加、再ロード、リブートする。</li><li>VLAN を表示する。</li><li>サブネットを作成する。</li><li>ポッドとロード・バランサー・サービスをデプロイする。</li></ul></td>
         <td><strong>サポート</strong>:<ul><li>チケットの表示</li><li>チケットの追加</li><li>チケットの編集</li></ul>
         <strong>デバイス</strong>:<ul><li>Virtual Server の詳細の表示</li><li>サーバーのリブートと IPMI システム情報の表示</li><li>サーバーのアップグレード</li><li>OS 再ロードの発行とレスキュー・カーネルの開始</li></ul>
         <strong>サービス</strong>:<ul><li>SSH 鍵の管理</li></ul>
         <strong>アカウント</strong>:<ul><li>アカウント要約の表示</li><li>クラウド・インスタンスの追加/アップグレード</li><li>サーバーのキャンセル</li><li>サーバーの追加</li></ul></td>
       </tr>
       <tr>
         <td><strong>ストレージ</strong>: <ul><li>永続ボリューム請求を作成して永続ボリュームをプロビジョンする。</li><li>ストレージ・インフラストラクチャー・リソースを作成および管理する。</li></ul></td>
         <td><strong>サービス</strong>:<ul><li>ストレージの管理</li></ul><strong>アカウント</strong>:<ul><li>ストレージの追加</li></ul></td>
       </tr>
       <tr>
         <td><strong>プライベート・ネットワーキング</strong>: <ul><li>クラスター内ネットワーキング用プライベート VLAN を管理する。</li><li>プライベート・ネットワークへの VPN 接続をセットアップする。</li></ul></td>
         <td><strong>ネットワーク</strong>:<ul><li>ネットワーク・サブネット経路の管理</li><li>IPSEC ネットワーク・トンネルの管理</li><li>ネットワーク・ゲートウェイの管理</li><li>VPN 管理</li></ul></td>
       </tr>
       <tr>
         <td><strong>パブリック・ネットワーキング</strong>:<ul><li>アプリを公開するためにパブリック・ロード・バランサーまたは Ingress ネットワーキングをセットアップする。</li></ul></td>
         <td><strong>デバイス</strong>:<ul><li>Load Balancers の管理</li><li>ホスト名/ドメインの編集</li><li>ポート・コントロールの管理</li></ul>
         <strong>ネットワーク</strong>:<ul><li>パブリック・ネットワーク・ポートのコンピュートを追加</li><li>ネットワーク・サブネット経路の管理</li><li>IP アドレスの追加</li></ul>
         <strong>サービス</strong>:<ul><li>DNS、リバース DNS、WHOIS の管理</li><li>証明書 (SSL) の表示</li><li>証明書 (SSL) の管理</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  変更を保存するには、**「ポータル許可の編集」**をクリックします。

6.  **「デバイス・アクセス」**タブで、アクセス権限を付与するデバイスを選択します。

    * **「デバイス・タイプ」**ドロップダウン・リストで、**「すべての仮想サーバー」**に対するアクセス権限を付与できます。
    * 作成される新しいデバイスへのアクセスをユーザーに許可するには、**「新規デバイスが追加されたときに自動的にアクセス権限を付与します」**を選択します。
    * 変更を保存するには、**「デバイスへのアクセス権限の更新」**をクリックします。

アクセス権をダウングレードしていますか? 処理が完了するまで、数分かかることがあります。
{: tip}

<br />

