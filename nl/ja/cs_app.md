---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# アプリをクラスターにデプロイする
{: #app}

{{site.data.keyword.containerlong}} で Kubernetes の技法を利用して、アプリをコンテナーにデプロイし、それらのアプリを常に稼働させることができます。 例えば、ダウン時間なしでローリング更新とロールバックを実行できます。
{: shortdesc}

次のイメージの領域をクリックして、アプリをデプロイするための一般的な手順を確認してください。 基礎を最初に学びますか? [アプリのデプロイ・チュートリアル](cs_tutorials_apps.html#cs_apps_tutorial)をお試しください。

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="基本デプロイメント・プロセス"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="CLI をインストールします。" title="CLI をインストールします。" shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="アプリの構成ファイルを作成します。Kubernetes のベスト・プラクティスを確認します。" title="アプリの構成ファイルを作成します。Kubernetes のベスト・プラクティスを確認します。" shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="オプション 1: Kubernetes CLI から構成ファイルを実行します。" title="オプション 1: Kubernetes CLI から構成ファイルを実行します。" shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="オプション 2: Kubernetes ダッシュボードをローカルで開始し、構成ファイルを実行します。" title="オプション 2: Kubernetes ダッシュボードをローカルで開始し、構成ファイルを実行します。" shape="rect" coords="544, 141, 728, 204" />
</map>

<br />




## 可用性の高いデプロイメントの計画
{: #highly_available_apps}

セットアップ時に複数のワーカー・ノードとクラスターを分散させる範囲を広くすればするほど、各ユーザーがアプリのダウン時間を経験する可能性は低くなります。
{: shortdesc}

アプリのセットアップ方法を以下にまとめます。下に行くほど可用性が高くなります。

![アプリの高可用性の段階](images/cs_app_ha_roadmap-mz.png)

1.  n+2 個のポッドを、単一のゾーン・クラスターの単一のノード内でレプリカ・セットによって管理するデプロイメント。
2.  n+2 個のポッドをレプリカ・セットによって管理し、単一のゾーン・クラスター内の複数のノードに分散させる (アンチアフィニティー) デプロイメント。
3.  n+2 個のポッドをレプリカ・セットによって管理し、複数のゾーンにまたがる複数ゾーン・クラスター内の複数のノードに分散させる (アンチアフィニティー) デプロイメント。

また、[グローバル・ロード・バランサーを使用して異なる地域にある複数のクラスターを接続](cs_clusters_planning.html#multiple_clusters)して、高可用性を向上させることもできます。

### アプリの可用性の向上
{: #increase_availability}

<dl>
  <dt>デプロイメントとレプリカ・セットを使用してアプリとその依存項目をデプロイする</dt>
    <dd><p>デプロイメントとは、アプリのすべてのコンポーネントとその依存項目を宣言するために使用できる Kubernetes リソースのことです。 デプロイメントでは、すべての手順を記述する必要はなく、アプリに集中できます。</p>
    <p>複数のポッドをデプロイすると、デプロイメントのレプリカ・セットが自動的に作成されます。そのレプリカ・セットによってポッドがモニターされ、いつでも望ましい数のポッドが稼働状態になります。 ポッドがダウンすると、応答しなくなったポッドがレプリカ・セットによって新しいポッドに置き換えられます。</p>
    <p>デプロイメントを使用して、ローリング更新中に追加するポッドの数や、1 度に使用不可にできるポッドの数など、アプリの更新戦略を定義できます。 ローリング更新の実行時には、デプロイメントによって、リビジョンが動作しているかどうかが確認され、障害が検出されるとロールアウトが停止されます。</p>
    <p>デプロイメントでは、異なるフラグを使用して同時に複数のリビジョンをデプロイできます。 例えば、実稼働環境にプッシュする前に、デプロイメントをテストすることができます。</p>
    <p>デプロイメントでは、デプロイしたリビジョンを追跡できます。 更新が期待どおりに機能しない場合に、この履歴を使用して以前のバージョンにロールバックすることができます。</p></dd>
  <dt>アプリのワークロードに十分なレプリカ数、プラス 2 を組み込む</dt>
    <dd>アプリの可用性と耐障害性を高めるために、予想されるワークロードを処理する最低限の数のレプリカに加えて予備のレプリカを組み込むことを検討してください。 ポッドがクラッシュし、そのポッドがレプリカ・セットによってまだリカバリーされていない状況でも、予備のレプリカでワークロードを処理できます。 2 つが同時に障害を発生した場合に対応できるようにするには、2 つ余分にレプリカを組み込みます。 この構成は N+2 パターンです。N は着信ワークロードを処理するレプリカの数、+2 は追加の 2 つのインスタンスです。 クラスターに十分なスペースがある限り、必要な数のポッドを作成できます。</dd>
  <dt>複数のノードにポッドを分散させる (アンチアフィニティー)</dt>
    <dd><p>デプロイメントを作成するときに、各ポッドを同じワーカー・ノードにデプロイすることもできます。 これは、アフィニティーまたはコロケーションとして知られています。 ワーカー・ノードの障害からアプリを保護するには、標準クラスターで <em>podAntiAffinity</em> オプションを使用して、複数のワーカー・ノードにポッドを分散させるようにデプロイメントを構成します。 「優先」と「必須」という 2 つのタイプのポッド・アンチアフィニティーを定義できます。 詳しくは、Kubernetes の資料 <a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(新しいタブまたはウィンドウで開く)">Assigning Pods to Nodes</a> を参照してください。</p>
    <p><strong>注</strong>: 「必須」のアンチアフィニティーでは、ワーカー・ノードの数しかレプリカをデプロイできません。 例えば、クラスターに 3 つのワーカー・ノードがある場合は、YAML ファイルに 5 つのレプリカを定義しても、3 つのレプリカしかデプロイされません。 各レプリカは異なるワーカー・ノード上に存在します。 残りの 2 つのレプリカは保留中のままです。 別のワーカー・ノードをクラスターに追加すると、残りのレプリカのうち 1 つが新しいワーカー・ノードに自動的にデプロイされます。<p>
    <p><strong>デプロイメント YAML ファイルのサンプル</strong>:<ul>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml" rel="external" target="_blank" title="(新しいタブまたはウィンドウで開く)">優先のポッド・アンチアフィニティーを使用する Nginx アプリ。</a></li>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="(新しいタブまたはウィンドウで開く)">必須のポッド・アンチアフィニティーを使用する IBM® WebSphere® Application Server Liberty アプリ。</a></li></ul></p>
    
    </dd>
<dt>複数のゾーンまたは領域にポッドを分散させる</dt>
  <dd><p>ゾーン障害からアプリを保護するには、別々のゾーンに複数のクラスターを作成するか、または複数ゾーン・クラスター内のワーカー・プールにゾーンを追加することができます。 複数ゾーン・クラスターは、[特定のメトロ領域](cs_regions.html#zones) (ダラスなど) でのみ使用可能です。 複数のクラスターを別々のゾーンに作成する場合は、[グローバル・ロード・バランサーをセットアップする](cs_clusters_planning.html#multiple_clusters)必要があります。</p>
  <p>レプリカ・セットを使用し、ポッドのアンチアフィニティーを指定すると、Kubernetes はアプリ・ポッドをノード間で分散させます。 複数のゾーンにノードがある場合、ポッドはゾーン間で分散され、アプリの可用性が向上します。 アプリを 1 つのゾーンのみで実行するように制限する場合は、ポッドのアフィニティーを構成するか、または 1 つのゾーン内にワーカー・プールを作成してラベル付けすることができます。 詳しくは、[複数ゾーン・クラスターの高可用性](cs_clusters_planning.html#ha_clusters)を参照してください。</p>
  <p><strong>複数ゾーン・クラスター・デプロイメントでは、アプリ・ポッドはノード間で均等に分散されますか?</strong></p>
  <p>ポッドはゾーン間で均等に分散されますが、ノード間では必ずしも均等になるとは限りません。 例えば、3 つの各ゾーンにノードが 1 つずつあるクラスターがある場合、6 つのポッドからなるレプリカ・セットをデプロイすると、ポッドは各ノードに 2 つずつ配分されます。 しかし、3 つの各ゾーンにノードが 2 つずつあるクラスターの場合は、6 つのポッドからなるレプリカ・セットをデプロイすると、各ゾーンに 2 つのポッドがスケジュールされますが、必ずしもノードごとに 1 つのポッドがスケジュールされるとは限りません。 スケジューリングをより細かく制御するには、[ポッドのアフィニティーを設定 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node) することができます。</p>
  <p><strong>あるゾーンがダウンした場合、ポッドは他のゾーンにある残りのノードにどのようにスケジュール変更されますか?</strong></br>それはデプロイメントに使用されているスケジューリング・ポリシーによって異なります。 [ノード固有のポッド・アフィニティー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) を組み込んだ場合、ポッドはスケジュール変更されません。 そうしていない場合、ポッドは他のゾーンの使用可能なワーカー・ノード上に作成されますが、バランスが取れていない可能性があります。 例えば、2 つのポッドが使用可能な 2 つのノードに分散される場合もあれば、使用可能な容量がある 1 つのノードに両方のポッドがスケジュールされる場合もあります。 同様に、使用不可になっていたゾーンが回復した場合も、ポッドが自動的に削除されて、ノード間でリバランスされるわけではありません。 ゾーンが回復した後に、ゾーン間でポッドをリバランスする場合は、[Kubernetes デスケジューラー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes-incubator/descheduler) の使用を検討してください。</p>
  <p><strong>ヒント</strong>: 複数ゾーン・クラスターでは、ワーカー・ノードの容量をゾーン当たり 50% に保ち、ゾーン障害時にクラスターを保護するために十分な容量を確保するようにしてください。</p>
  <p><strong>アプリを複数の地域に分散させるにはどうすればよいですか?</strong></br>地域の障害からアプリを保護するには、別の地域に 2 番目のクラスターを作成し、[グローバル・ロード・バランサーをセットアップ](cs_clusters_planning.html#multiple_clusters)してクラスター同士を接続し、デプロイメント YAML を使用して、アプリ用に[ポッドのアンチアフィニティー ![外部リンク・リンク](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) を設定した複製レプリカ・セットをデプロイします。</p>
  <p><strong>アプリに永続ストレージが必要な場合はどうすればよいですか?</strong></p>
  <p>[{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) や [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage)などのクラウド・サービスを使用します。</p></dd>
</dl>



### 最小限のアプリのデプロイメント
{: #minimal_app_deployment}

フリー・クラスターまたは標準クラスターへの基本的なアプリのデプロイメントには、一般には以下の構成要素が含まれます。
{: shortdesc}

![デプロイメントのセットアップ](images/cs_app_tutorial_components1.png)

図に示すように、最小限のアプリ用にコンポーネントをデプロイするには、次の例のような構成ファイルを使用します。
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.bluemix.net/ibmliberty:latest
        ports:
        - containerPort: 9080        
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    app: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

**注:** サービスを公開するには、サービスの `spec.selector` セクションで使用するキー/値のペアが、デプロイメント YAML の `spec.template.metadata.labels` セクションで使用したキー/値のペアと同じであることを確認してください。
各コンポーネントについて詳しくは、[Kubernetes の基本](cs_tech.html#kubernetes_basics)を参照してください。

<br />






## Kubernetes ダッシュボードの起動
{: #cli_dashboard}

ローカル・システムで Kubernetes ダッシュボードを開くと、クラスターとそのすべてのワーカー・ノードに関する情報が表示されます。 [GUI では](#db_gui)、便利なワンクリック・ボタンでダッシュボードにアクセスできます。 [CLI を使用すると](#db_cli)、ダッシュボードにアクセスしたり、CI/CD パイプラインなどの自動化プロセスのステップを使用したりできます。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

クラスターの Kubernetes ダッシュボードを起動するために、デフォルトのポートを使用するか、独自のポートを設定できます。

**GUI からの Kubernetes ダッシュボードの起動**
{: #db_gui}

1.  [{{site.data.keyword.Bluemix_notm}} GUI](https://console.bluemix.net/) にログインします。
2.  メニュー・バーのプロファイルから、使用するアカウントを選択します。
3.  メニューから、**「コンテナー」**をクリックします。
4.  **「クラスター」**ページで、アクセスするクラスターをクリックします。
5.  クラスターの詳細ページで、**「Kubernetes Dashboard」**ボタンをクリックします。

</br>
</br>

**CLI からの Kubernetes ダッシュボードの起動**
{: #db_cli}

1.  Kubernetes の資格情報を取得します。

    ```
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
    ```
    {: pre}

2.  出力に示された **id-token** 値をコピーします。

3.  デフォルトのポート番号でプロキシーを設定します。

    ```
    kubectl proxy
    ```
    {: pre}

    出力例:

    ```
    Starting to serve on 127.0.0.1:8001
    ```
    {: screen}

4.  ダッシュボードにサインインします。

  1.  ブラウザーで、次の URL に移動します。

      ```
      http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
      ```
      {: codeblock}

  2.  サインオン・ページで、**トークン**認証方式を選択します。

  3.  次に、先ほどコピーした **id-token** 値を **Token** フィールドに貼り付けて、**「SIGN IN」**をクリックします。

Kubernetes ダッシュボードでの作業が完了したら、`CTRL+C` を使用して `proxy` コマンドを終了します。 終了した後は、Kubernetes ダッシュボードを使用できなくなります。 Kubernetes ダッシュボードを再始動するには、`proxy` コマンドを実行します。

[次に、ダッシュボードから構成ファイルを実行できます。](#app_ui)

<br />


## シークレットの作成
{: #secrets}

Kubernetes シークレットは、機密情報 (ユーザー名、パスワード、鍵など) を安全に保管するための手段です。
{:shortdesc}

シークレットを必要とする以下のタスクを確認してください。 シークレットに保管できるものについて詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/secret/) を参照してください。

### クラスターへのサービスの追加
{: #secrets_service}

サービスをクラスターにバインドする場合は、シークレットを作成する必要はありません。 シークレットは自動的に作成されます。 詳しくは、[クラスターへの Cloud Foundry サービスの追加](cs_integrations.html#adding_cluster)を参照してください。

### TLS を使用するように Ingress ALB を構成する
{: #secrets_tls}

ALB は、HTTP ネットワーク・トラフィックをクラスター内のアプリに振り分けてロード・バランシングを行います。 着信 HTTPS 接続のロード・バランシングも行う場合は ALB でその機能を構成できます。つまり、ネットワーク・トラフィックを復号し、復号した要求をクラスター内で公開されているアプリに転送するように構成します。

IBM 提供の Ingress サブドメインを使用する場合は、[IBM 提供の TLS 証明書を使用](cs_ingress.html#public_inside_2)できます。 IBM 提供の TLS シークレットを表示するには、次のコマンドを実行します。
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep "Ingress secret"
```
{: pre}

カスタム・ドメインを使用する場合は、独自の証明書を使用して TLS 終端を管理できます。 独自の TLS シークレットを作成するには、次のようにします。
1. 次のいずれかの方法で鍵と証明書を生成します。
    * 証明書プロバイダーから認証局 (CA) の証明書と鍵を生成します。 独自のドメインがある場合は、ご使用のドメインの正式な TLS 証明書を購入してください。
      **重要**: 証明書ごとに異なる [CN ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://support.dnsimple.com/articles/what-is-common-name/) を使用してください。
    * テストのために、OpenSSL を使用して自己署名証明書を作成することができます。 詳しくは、この[自己署名 SSL 証明書 チュートリアル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.akadia.com/services/ssh_test_certificate.html) を参照してください。
        1. `tls.key` を作成します。
            ```
            openssl genrsa -out tls.key 2048
            ```
            {: pre}
        2. この鍵を使用して、`tls.crt` を作成します。
            ```
            openssl req -new -x509 -key tls.key -out tls.crt
            ```
            {: pre}
2. [証明書と鍵を base-64 に変換します ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.base64encode.org/)。
3. 証明書と鍵を使用して、シークレット YAML ファイルを作成します。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. 証明書を Kubernetes シークレットとして作成します。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### SSL サービス注釈を使用した Ingress ALB のカスタマイズ
{: #secrets_ssl_services}

[`ingress.bluemix.net/ssl-services` 注釈](cs_annotations.html#ssl-services)を使用して、Ingress ALB からアップストリーム・アプリへのトラフィックを暗号化することができます。 シークレットを作成するには、次のようにします。

1. 認証局 (CA) 鍵と証明書をアップストリーム・サーバーから入手します。
2. [証明書を base-64 に変換します ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.base64encode.org/)。
3. 証明書を使用して、シークレット YAML ファイルを作成します。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       trusted.crt: <ca_certificate>
     ```
     {: codeblock}
     **注**: アップストリーム・トラフィックの相互認証も実施する場合は、データ・セクションに `trusted.crt` に加えて `client.crt` と `client.key` を指定できます。
4. 証明書を Kubernetes シークレットとして作成します。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### 相互認証注釈を使用した Ingress ALB のカスタマイズ
{: #secrets_mutual_auth}

[`ingress.bluemix.net/mutual-auth` 注釈](cs_annotations.html#mutual-auth)を使用して、Ingress ALB のダウンストリーム・トラフィックの相互認証を構成できます。 相互認証シークレットを作成するには、次のようにします。

1. 次のいずれかの方法で鍵と証明書を生成します。
    * 証明書プロバイダーから認証局 (CA) の証明書と鍵を生成します。 独自のドメインがある場合は、ご使用のドメインの正式な TLS 証明書を購入してください。
      **重要**: 証明書ごとに異なる [CN ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://support.dnsimple.com/articles/what-is-common-name/) を使用してください。
    * テストのために、OpenSSL を使用して自己署名証明書を作成することができます。 詳しくは、この[自己署名 SSL 証明書 チュートリアル![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.akadia.com/services/ssh_test_certificate.html)を参照してください。
        1. `ca.key` を作成します。
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. 鍵を使用して、`ca.crt` を作成します。
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. `ca.crt` を使用して、自己署名証明書を作成します。
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [証明書を base-64 に変換します ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.base64encode.org/)。
3. 証明書を使用して、シークレット YAML ファイルを作成します。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. 証明書を Kubernetes シークレットとして作成します。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />


## GUI でアプリをデプロイする方法
{: #app_ui}

Kubernetes ダッシュボードを使用してアプリをクラスターにデプロイすると、デプロイメント・リソースが、クラスター内にポッドを自動的に作成し、更新および管理します。
{:shortdesc}

開始前に、以下のことを行います。

-   必要な [CLI](cs_cli_install.html#cs_cli_install) をインストールします。
-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

アプリをデプロイするには、以下の手順で行います。

1.  Kubernetes [ダッシュボード](#cli_dashboard)を開き、**「+ 作成」**をクリックします。
2.  2 つの方法のいずれかでアプリの詳細を入力します。
  * **「以下にアプリの詳細を指定する (Specify app details below)」**を選択し、詳細を入力します。
  * **「YAML ファイルまたは JSON ファイルをアップロードする (Upload a YAML or JSON file)」**を選択して、アプリの[構成ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) をアップロードします。

  構成ファイルのヘルプが必要な場合は、 この [YAML ファイルのサンプル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) を確認してください。 この例では、コンテナーは米国南部地域の **ibmliberty** イメージからデプロイされます。 Kubernetes リソースを処理する際の[個人情報の保護](cs_secure.html#pi)の詳細を確認してください。
  {: tip}

3.  以下のいずれかの方法でアプリを正常にデプロイしたことを確認します。
  * Kubernetes ダッシュボードで、**「デプロイメント」**をクリックします。 正常なデプロイメントのリストが表示されます。
  * アプリが[公開](cs_network_planning.html#public_access)されている場合は、{{site.data.keyword.containerlong}} ダッシュボードのクラスター概要ページにナビゲートします。 クラスター概要セクションにあるサブドメインをコピーし、ブラウザーに貼り付けてアプリを表示します。

<br />


## CLI でアプリをデプロイする方法
{: #app_cli}

クラスターを作成したら、Kubernetes CLI を使用してそのクラスターにアプリをデプロイできます。
{:shortdesc}

開始前に、以下のことを行います。

-   必要な [CLI](cs_cli_install.html#cs_cli_install) をインストールします。
-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

アプリをデプロイするには、以下の手順で行います。

1.  [Kubernetes のベスト・プラクティス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/overview/) に基づいて構成ファイルを作成します。 基本的に、構成ファイルには、Kubernetes で作成する各リソースの構成の詳細情報が格納されます。 スクリプトに以下のセクションを 1 つ以上追加できます。

    -   [Deployment ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): ポッドとレプリカ・セットの作成を定義します。 1 つのポッドにコンテナー化アプリを 1 つ組み込み、レプリカ・セットによってポッドの複数インスタンスを制御します。

    -   [Service ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/): ワーカー・ノードまたはロード・バランサーのパブリック IP アドレス、あるいは Ingress のパブリック経路を使用して、ポッドへのフロントエンド・アクセスを提供します。

    -   [Ingress ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/ingress/): アプリをだれでも利用できるようにする経路を提供するロード・バランサーのタイプを指定します。

    Kubernetes リソースを処理する際の[個人情報の保護](cs_secure.html#pi)の詳細を確認してください。

2.  クラスターのコンテキストで構成ファイルを実行します。

    ```
    kubectl apply -f config.yaml
    ```
    {: pre}

3.  ノード・ポート・サービス、ロード・バランサー・サービス、または Ingress を使用して、アプリをだれでも利用できるようにした場合は、アプリにアクセスできることを確認します。

<br />


## ラベルを使用した特定のワーカー・ノードへのアプリのデプロイ
{: #node_affinity}

アプリをデプロイすると、アプリ・ポッドが、クラスター内のさまざまなワーカー・ノードに無差別にデプロイされます。 場合に応じて、アプリ・ポッドがデプロイされるワーカー・ノードを制限することもできます。 例えば、特定のワーカー・プールのワーカー・ノードがベア・メタル・マシン上にあるため、これらのワーカー・ノードにのみアプリ・ポッドがデプロイされるようにしたいとします。 アプリ・ポッドをデプロイするワーカー・ノードを指定するには、アプリのデプロイメントにアフィニティー・ルールを追加します。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

1. アプリ・ポッドをデプロイするワーカー・プールの名前を取得します。
    ```
    ibmcloud ks worker-pools <cluster_name_or_ID>
    ```
    {:pre}

    以下のステップでは、例としてワーカー・プール名を使用します。 別の要因に基づいて特定のワーカー・ノードにアプリ・ポッドをデプロイするには、代わりにその値を取得してください。 例えば、アプリ・ポッドを特定の VLAN 上のワーカー・ノードにのみデプロイするには、`ibmcloud ks vlans<zone>` を実行して VLAN ID を取得します。
    {: tip}

2. [ワーカー・プール名のアフィニティー・ルール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) をアプリのデプロイメントに追加します。

    yaml の例:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: workerPool
                    operator: In
                    values:
                    - <worker_pool_name>
    ...
    ```
    {: codeblock}

    yaml の例の **affinity** セクションでは、`workerPool` が `key`、`<worker_pool_name>` が `value` です。

3. 更新したデプロイメント構成ファイルを適用します。
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

4. アプリ・ポッドが、正しいワーカー・ノードにデプロイされたことを確認します。

    1. クラスター内のポッドをリストします。
        ```
        kubectl get pods -o wide
        ```
        {: pre}

        出力例:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. 出力で、アプリのポッドを確認します。 ポッドがあるワーカー・ノードの **NODE** プライベート IP アドレスをメモします。

        上記の出力例で、アプリ・ポッド `cf-py-d7b7d94db-vp8pq` は、IP アドレス `10.176.48.78` のワーカー・ノード上にあります。

    3. アプリのデプロイメントに指定したワーカー・プール内にあるワーカー・ノードをリストします。

        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool_name>
        ```
        {: pre}

        出力例:

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b2c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        別の要因に基づいてアプリのアフィニティー・ルールを作成した場合は、代わりにその値を取得してください。 例えば、特定の VLAN 上のワーカー・ノードにデプロイされたアプリ・ポッドを検証するには、`ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>` を実行して、ワーカー・ノードがオンになっている VLAN を表示します。
        {: tip}

    4. 出力で、前のステップで指定したプライベート IP アドレスを持つワーカー・ノードがこのワーカー・プールにデプロイされていることを確認します。

<br />


## GPU マシンへのアプリのデプロイ
{: #gpu_app}

[ベア・メタル・グラフィックス処理装置 (GPU) マシン・タイプ](cs_clusters_planning.html#shared_dedicated_node)がある場合は、数理計算主体のワークロードをワーカー・ノードにスケジュールできます。 例えば、Compute Unified Device Architecture (CUDA) プラットフォームを使用する 3D アプリを実行して GPU と CPU 間で処理負荷を分担し、パフォーマンスを向上させることができます。
{:shortdesc}

以下のステップは、GPU を必要とするワークロードをデプロイする方法を示しています。 GPU と CPU の両方にわたってワークロードを処理する必要はない[アプリをデプロイする](#app_ui)こともできます。 後で、[この Kubernetes デモ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/pachyderm/pachyderm/tree/master/doc/examples/ml/tensorflow) を使用して、[TensorFlow ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.tensorflow.org/) 機械学習フレームワークなどの数理計算主体のワークロードを試してみることをお勧めします。

開始前に、以下のことを行います。
* [ベア・メタル GPU マシン・タイプを作成します](cs_clusters.html#clusters_cli)。 このプロセスは、完了までに 1 営業日より長くかかる場合があることに注意してください。
* クラスター・マスターと GPU ワーカー・ノードは、Kubernetes バージョン 1.10 以降を実行する必要があります。

GPU マシンでワークロードを実行するには、以下のようにします。
1.  YAML ファイルを作成します。 この例では、`Job` YAML は、短期的なポッドを作成することによって、一種のバッチのようなワークロードを管理します。このポッドは、その完了がスケジュールされたコマンドが正常に終了するまで実行されます。

    **重要 **: GPU ワークロードの場合は、YAML 仕様で必ず `resources: limits: nvidia.com/gpu` フィールドを指定する必要があります。

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table>
    <caption>YAML コンポーネント</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td>メタデータとラベルの名前</td>
    <td>ジョブの名前とラベルを指定し、ファイルのメタデータと `spec template` メタデータの両方で同じ名前を使用します。 例えば、`nvidia-smi` と指定します。</td>
    </tr>
    <tr>
    <td><code>containers/image</code></td>
    <td>実行中インスタンスとなっているコンテナーが属するイメージを指定します。 この例では、DockerHub CUDA イメージ <code>nvidia/cuda:9.1-base-ubuntu16.04</code> を使用するように値が設定されています</td>
    </tr>
    <tr>
    <td><code>containers/command</code></td>
    <td>コンテナーで実行するコマンドを指定します。 この例では、<code>[ "/usr/test/nvidia-smi" ]</code> コマンドは GPU マシン上のバイナリーを参照するので、ボリューム・マウントもセットアップする必要があります。</td>
    </tr>
    <tr>
    <td><code>containers/imagePullPolicy</code></td>
    <td>イメージが現在ワーカー・ノード上にない場合にのみ新規イメージをプルする場合は、<code>IfNotPresent</code> を指定します。</td>
    </tr>
    <tr>
    <td><code>resources/limits</code></td>
    <td>GPU マシンの場合は、リソース制限を指定する必要があります。 Kubernetes [デバイス・プラグイン ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) は、制限に合うようにデフォルトのリソース要求を設定します。
    <ul><li>キーとして <code>nvidia.com/gpu</code> を指定する必要があります。</li>
    <li>要求する GPU の数を整数 (<code>2</code> など) で入力します。<strong>注</strong>: コンテナー・ポッドは GPU を共有しません。また、GPU をオーバーコミットすることはできません。 例えば、`mg1c.16x128` マシンが 1 台のみの場合、そのマシンには GPU が 2 つしかないため、指定できるのは最大で `2` つです。</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>コンテナーにマウントされるボリュームに <code>nvidia0</code> などの名前を付けます。 そのボリュームのコンテナーで <code>mountPath</code> を指定します。 この例では、パス <code>/usr/test</code> は、ジョブ・コンテナー・コマンドで使用されるパスと一致します。</td>
    </tr>
    <tr>
    <td><code>volumes</code></td>
    <td>ジョブ・ボリュームに <code>nvidia0</code> などの名前を付けます。 GPU ワーカー・ノードの <code>hostPath</code> で、ホスト上のボリュームの <code>path</code> (この例では <code>/usr/bin</code>) を指定します。 コンテナー <code>mountPath</code> はホスト・ボリューム <code>path</code> にマップされます。これにより、このジョブは、コンテナー・コマンドを実行するために、GPU ワーカー・ノード上の NVIDIA バイナリーにアクセスできます。</td>
    </tr>
    </tbody></table>

2.  YAML ファイルを適用します。 以下に例を示します。

    ```
    kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  `nvidia-sim` ラベルでポッドをフィルタリングして、ジョブ・ポッドを検査します。 **STATUS** が **Completed** であることを確認します。

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    出力例:
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  ポッドに describe を実行して、GPU デバイス・プラグインがポッドをどのようにスケジュールしたかを確認します。
    * `Limits` フィールドと `Requests` フィールドで、指定したリソース制限とデバイス・プラグインが自動的に設定した要求とが一致していることを確認します。
    * イベントで、ポッドが GPU ワーカー・ノードに割り当てられていることを確認します。

    ```
    kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    出力例:
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  ジョブが GPU を使用してそのワークロードの計算を実行したことを検証するには、ログを確認します。 ジョブからの `["/usr/test/nvidia-smi"]` コマンドが、GPU ワーカー・ノード上の GPU デバイス状態を照会しました。

    ```
    kubectl logs nvidia-sim-ppkd4
    ```
    {: pre}

    出力例:
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    この例では、両方の GPU がワーカー・ノードでスケジュールされたため、両方の GPU がジョブの実行に使用されたことが分かります。 制限を 1 に設定した場合は、GPU が 1 つだけ示されます。

## アプリのスケーリング
{: #app_scaling}

Kubernetes では、[ポッドの自動水平スケーリング ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) を有効にして、CPU に基づいてアプリのインスタンス数を自動的に増減できます。
{:shortdesc}

Cloud Foundry アプリケーションのスケーリングに関する情報をお探しですか? [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html) を参照してください。 
{: tip}

開始前に、以下のことを行います。
- [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。
- 自動スケーリングするクラスターに Heapster モニターをデプロイする必要があります。

手順:

1.  CLI を使用して、アプリをクラスターにデプロイします。 アプリをデプロイする時に、CPU を要求する必要があります。

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <caption>kubectl run のコマンド構成要素</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>デプロイするアプリケーション。</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>コンテナーで必要な CPU。ミリコア単位で指定します。 例えば、<code>--requests=200m</code> のように指定します。</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>外部サービスを作成する場合は、true にします。</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>外部からアプリを使用するためのポート。</td>
    </tr></tbody></table>

    デプロイメントがかなり複雑になる場合は、[構成ファイル](#app_cli)を作成する必要があります。
    {: tip}

2.  自動スケーリング機能を作成し、ポリシーを定義します。 `kubectl autoscale` コマンドの使い方について詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale) を参照してください。

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <caption>kubectl autoscale のコマンド構成要素</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>水平ポッド自動スケーリング機能で維持する CPU 使用率の平均値。パーセントで指定します。</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>指定した CPU 使用率を維持するために使用するデプロイ済みのポッドの最小数。</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>指定した CPU 使用率を維持するために使用するデプロイ済みのポッドの最大数。</td>
    </tr>
    </tbody></table>


<br />


## ローリング・デプロイメントの管理
{: #app_rolling}

変更のロールアウトを自動化され制御された方法で管理できます。 ロールアウトがプランに従ったものでない場合、デプロイメントを以前のリビジョンにロールバックできます。
{:shortdesc}

開始する前に、[デプロイメント](#app_cli)を作成します。

1.  変更を[ロールアウト ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) します。 例えば、初期デプロイメントで使用したイメージを変更することができます。

    1.  デプロイメント名を取得します。

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  ポッド名を取得します。

        ```
        kubectl get pods
        ```
        {: pre}

    3.  ポッドで実行しているコンテナーの名前を取得します。

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  使用するデプロイメントの新しいイメージを設定します。

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    コマンドを実行すると、変更がすぐに適用され、ロールアウトの履歴にログが記録されます。

2.  デプロイメントの状況を確認します。

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  変更をロールバックします。
    1.  デプロイメントのロールアウト履歴を参照し、最後のデプロイメントのリビジョン番号を確認します。

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **ヒント:** 特定のリビジョンの詳細を表示するには、リビジョン番号を指定します。

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  以前のバージョンにロールバックするか、またはリビジョンを指定します。 以前のバージョンにロールバックするには、次のコマンドを使用します。

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />

