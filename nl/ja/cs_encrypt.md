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


# クラスターでの機密情報の保護
{: #encryption}

デフォルトでは、{{site.data.keyword.containerlong}} クラスターは暗号化ディスクを使用して、`etcd` 内の構成や、ワーカー・ノードの 2 次ディスク上で実行されているコンテナー・ファイル・システムなどの情報を保管します。アプリをデプロイする際に、YAML 構成ファイル、構成マップ、またはスクリプト内には資格情報や鍵などの機密情報を保管しないでください。代わりに、[Kubernetes シークレット ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/secret/) を使用します。Kubernetes シークレット内でデータを暗号化して、許可されていないユーザーがクラスターの機密情報にアクセスできないようにすることもできます。
{: shortdesc}

クラスターの保護について詳しくは、[{{site.data.keyword.containerlong_notm}} のセキュリティー](cs_secure.html#security)を参照してください。



## シークレットを使用するケースについて
{: #secrets}

Kubernetes シークレットは、機密情報 (ユーザー名、パスワード、鍵など) を安全に保管するための手段です。 機密情報を暗号化する必要がある場合は、[{{site.data.keyword.keymanagementserviceshort}} を有効化して](#keyprotect)シークレットを暗号化します。シークレットに保管できるものについて詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/secret/) を参照してください。
{:shortdesc}

シークレットを必要とする以下のタスクを確認してください。

### クラスターへのサービスの追加
{: #secrets_service}

サービスをクラスターにバインドする場合は、シークレットを作成してサービス資格情報を保管する必要はありません。シークレットは自動的に作成されます。 詳しくは、[クラスターへの Cloud Foundry サービスの追加](cs_integrations.html#adding_cluster)を参照してください。

### アプリへのトラフィックを TLS シークレットで暗号化する
{: #secrets_tls}

ALB は、HTTP ネットワーク・トラフィックをクラスター内のアプリに振り分けてロード・バランシングを行います。 着信 HTTPS 接続のロード・バランシングも行う場合は ALB でその機能を構成できます。つまり、ネットワーク・トラフィックを復号し、復号した要求をクラスター内で公開されているアプリに転送するように構成します。 詳しくは、[Ingress の構成の資料](cs_ingress.html#public_inside_3)を参照してください。

また、HTTPS プロトコルを必要とするアプリがあり、トラフィックの暗号化を維持する必要がある場合は、片方向認証または相互認証用シークレットと `ssl-services` アノテーションを併用できます。詳しくは、[Ingress のアノテーションの資料](cs_annotations.html#ssl-services)を参照してください。

### Kubernetes の `imagePullSecret` に保管された資格情報を使用したレジストリーへのアクセス
{: #imagepullsecret}

クラスターを作成すると、{{site.data.keyword.registrylong}} 資格情報用のシークレットが `default` Kubernetes 名前空間内に自動的に作成されます。しかし、以下の状況でコンテナーをデプロイしようとしている場合は、[クラスター用に独自の imagePullSecret を作成](cs_images.html#other)する必要があります。
* {{site.data.keyword.registryshort_notm}} レジストリー内のイメージから `default` 以外の Kubernetes 名前空間へ。
* 別の {{site.data.keyword.Bluemix_notm}} 地域または {{site.data.keyword.Bluemix_notm}} アカウントに保管されている、{{site.data.keyword.registryshort_notm}} レジストリー内のイメージから。
* {{site.data.keyword.Bluemix_notm}} 専用アカウントに保管されているイメージから。
* 外部のプライベート・レジストリーに保管されているイメージから。

<br />


## {{site.data.keyword.keymanagementserviceshort}} を使用した Kubernetes シークレットの暗号化
{: #keyprotect}

クラスター内で Kubernetes [鍵管理サービス (KMS) プロバイダー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) として [{{site.data.keyword.keymanagementservicefull}} ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](/docs/services/key-protect/index.html#getting-started-with-key-protect) を使用して、Kubernetes シークレットを暗号化できます。KMS プロバイダーは、Kubernetes のバージョン 1.10 と 1.11 のアルファ・フィーチャーです。
{: shortdesc}

デフォルトでは、Kubernetes シークレットは IBM 管理 Kubernetes マスターの `etcd` コンポーネント内の暗号化ディスク上に保管されます。ワーカー・ノードには 2 次ディスクもあり、これはクラスターにシークレットとして保管される IBM 管理の LUKS キーで暗号化されます。クラスター内の {{site.data.keyword.keymanagementserviceshort}} を有効にする際には、LUKS シークレットを含む Kubernetes シークレットの暗号化に独自のルート・キーが使用されます。このルート・キーを使用してシークレットを暗号化すると、機密データの制御を強化できます。独自の暗号化を使用すると、Kubernetes シークレットにセキュリティー層が追加され、クラスターの機密情報にだれがアクセスできるかについてさらに細かく制御することができます。シークレットに対するアクセス権限を取り消し不能な形で削除する必要が生じた場合は、ルート・キーを削除できます。

**重要**: {{site.data.keyword.keymanagementserviceshort}} インスタンス内でルート・キーを削除すると、その後はクラスター内でシークレットからデータにアクセスしたりデータを削除したりすることはできません。

開始前に、以下のことを行います。
* [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。
* `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` を実行して **Version** フィールドを確認し、クラスターで Kubernetes バージョン 1.10.8_1524 あるいは 1.11.3_1521 以降が実行されていることを確認します。
* これらの手順を完了するために、[**管理者**の許可](cs_users.html#access_policies)があることを確認します。
* クラスターが置かれている地域を対象に設定された API キーが、Key Protect の使用を許可されていることを確認します。その地域において資格情報が保管されている API キー所有者を調べるには、`ibmcloud ks api-key-info --cluster <cluster_name_or_ID>` を実行します。

{{site.data.keyword.keymanagementserviceshort}} を有効にしたり、クラスター内のシークレットを暗号化するインスタンスまたはルート・キーを更新したりするには、以下のようにします。

1.  [{{site.data.keyword.keymanagementserviceshort}} のインスタンスを作成します](/docs/services/key-protect/provision.html#provision)。

2.  サービス・インスタンス ID を取得します。

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [ルート・キーを作成します](/docs/services/key-protect/create-root-keys.html#create-root-keys)。デフォルトでは、ルート・キーは有効期限なしで作成されます。

    内部セキュリティー・ポリシーに準拠するように有効期限を設定する必要がありますか? [API を使用してルート・キーを作成し](/docs/services/key-protect/create-root-keys.html#api)、`expirationDate` パラメーターを組み込みます。**重要**: ルート・キーの有効期限が切れる前に、これらの手順を繰り返して、新しいルート・キーを使用するようにクラスターを更新する必要があります。更新しないと、シークレットを暗号化解除できません。
    {: tip}

4.  [ルート・キーの **ID**](/docs/services/key-protect/view-keys.html#gui) をメモします。

5.  インスタンスの [{{site.data.keyword.keymanagementserviceshort}} エンドポイント](/docs/services/key-protect/regions.html#endpoints)を取得します。

6.  {{site.data.keyword.keymanagementserviceshort}} を有効にするクラスターの名前を取得します。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  クラスター内で {{site.data.keyword.keymanagementserviceshort}} を有効にします。以前に取得した情報をフラグに記入します。

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

クラスター内で {{site.data.keyword.keymanagementserviceshort}} を有効にした後に、クラスター内の既存のシークレットと、新規作成されるシークレットは、{{site.data.keyword.keymanagementserviceshort}} ルート・キーを使用して自動的に暗号化されます。新しいルート・キー ID を使用してこれらの手順を繰り返すと、いつでも鍵を循環させることができます。
