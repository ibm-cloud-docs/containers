---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-28"

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

{{site.data.keyword.containerlong}} で Kubernetes の技法を利用して、アプリをコンテナーにデプロイし、それらのアプリを常に稼働させることができます。例えば、ダウン時間なしでローリング更新とロールバックを実行できます。
{:shortdesc}

次のイメージの領域をクリックして、アプリをデプロイするための一般的な手順を確認してください。

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
{:shortdesc}

アプリのセットアップ方法を以下にまとめます。下に行くほど可用性が高くなります。

![アプリの高可用性の段階](images/cs_app_ha_roadmap.png)

1.  n+2 個のポッドをレプリカ・セットで管理するデプロイメント。
2.  n+2 個のポッドをレプリカ・セットで管理し、同じ場所の複数のノードに分散させる (アンチアフィニティー) デプロイメント。
3.  n+2 個のポッドをレプリカ・セットで管理し、別々の場所に存在する複数のノードに分散させる (アンチアフィニティー) デプロイメント。
4.  n+2 個のポッドをレプリカ・セットで管理し、別々の地域に存在する複数のノードに分散させる (アンチアフィニティー) デプロイメント。

### アプリの可用性の向上

<dl>
<dt>デプロイメントとレプリカ・セットを使用してアプリとその依存項目をデプロイする</dt>
<dd>デプロイメントとは、アプリのすべてのコンポーネントや依存項目を宣言するために使用できる Kubernetes リソースです。 必要なすべての手順やコンポーネントの作成順序ではなくそれぞれの単一コンポーネントを記述することにより、
稼働中のアプリの動作に集中できます。
</br></br>
複数のポッドをデプロイすると、デプロイメントのレプリカ・セットが自動的に作成されます。そのレプリカ・セットによってポッドがモニターされ、いつでも望ましい数のポッドが稼働状態になります。 ポッドがダウンすると、応答しなくなったポッドがレプリカ・セットによって新しいポッドに置き換えられます。
</br></br>
デプロイメントを使用して、ローリング更新中に追加するポッドの数や、1 度に使用不可にできるポッドの数など、アプリの更新戦略を定義できます。 ローリング更新の実行時には、デプロイメントによって、リビジョンが動作しているかどうかが確認され、障害が検出されるとロールアウトが停止されます。
</br></br>
デプロイメントを使用すれば、異なるフラグを設定した複数のリビジョンを同時にデプロイすることもできるので、まずデプロイメントをテストしてから実稼働環境にプッシュするかどうかを決める、といったことが可能になります。
</br></br>
すべてのデプロイメントで、デプロイされたリビジョンが追跡されます。 こうしたリビジョンの履歴を使用して、更新が予期したとおりに機能しない場合に、以前のバージョンにロールバックできます。</dd>
<dt>アプリのワークロードに十分なレプリカ数、プラス 2 を組み込む</dt>
<dd>アプリの可用性と耐障害性を高めるために、予想されるワークロードを処理する最低限の数のレプリカに加えて予備のレプリカを組み込むことを検討してください。 ポッドがクラッシュし、そのポッドがレプリカ・セットによってまだリカバリーされていない状況でも、予備のレプリカでワークロードを処理できます。 2 つが同時に障害を発生した場合に対応できるようにするには、2 つ余分にレプリカを組み込みます。 このセットアップは N+2 パターンです。N は着信ワークロードを処理するレプリカの数、+2 は追加の 2 つのインスタンスです。 クラスターに十分なスペースがある限り、ポッドをいくつでもクラスターに含めることができます。</dd>
<dt>複数のノードにポッドを分散させる (アンチアフィニティー)</dt>
<dd>デプロイメントを作成する時に、各ポッドを同じワーカー・ノードにデプロイすることもできます。 複数のポッドが同じワーカー・ノード上に存在するセットアップは、アフィニティーまたはコロケーションといいます。 ワーカー・ノードの障害からアプリを保護するために、デプロイメントによって複数のワーカー・ノードにポッドを分散させることもできます。そのためには、<strong>podAntiAffinity</strong> オプションを使用します。 このオプションを使用できるのは標準クラスターの場合に限られます。

</br></br>
<strong>注:</strong> 以下の YAML ファイルでは、それぞれのポッドを異なるワーカー・ノードにデプロイします。 定義したレプリカの数がクラスター内の使用できるワーカー・ノードの数より多い場合は、アンチアフィニティーの要件を満たせる数のレプリカだけがデプロイされます。 それ以外のレプリカは、ワーカー・ノードがさらにクラスターに追加されるまで保留状態になります。

<pre class="codeblock">
<code>apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: wasliberty
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - wasliberty
              topologyKey: kubernetes.io/hostname
      containers:
      - name: wasliberty
        image: registry.&lt;region&gt;.bluemix.net/ibmliberty
        ports:
        - containerPort: 9080
---
apiVersion: v1
kind: Service
metadata:
  name: wasliberty
  labels:
    app: wasliberty
spec:
  ports:
    # the port that this service should serve on
  - port: 9080
  selector:
    app: wasliberty
  type: NodePort</code></pre>

</dd>
<dt>複数の場所にポッドを分散させる</dt>
<dd>ある場所や領域の障害からアプリを保護するために、別の場所の 2 つ目のクラスターを作成し、デプロイメントの YAML を使用してアプリの重複レプリカ・セットをデプロイできます。 クラスターの前に共有ルートとロード・バランサーを追加して、複数の場所や領域にワークロードを分散させることもできます。 クラスター間でルートを共有する方法について詳しくは、<a href="cs_clusters.html#clusters" target="_blank">クラスターの高可用性</a>を参照してください。

詳しくは、<a href="cs_clusters.html#planning_clusters" target="_blank">可用性の高いデプロイメント</a>のオプションを参照してください。</dd>
</dl>


### 最小限のアプリのデプロイメント
{: #minimal_app_deployment}

フリー・クラスターまたは標準クラスターへの基本的なアプリのデプロイメントには、一般には以下の構成要素が含まれます。
{:shortdesc}

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
        image: registry.<region>.bluemix.net/ibmliberty:latest
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    run: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

各コンポーネントについて詳しくは、[Kubernetes の基本](cs_tech.html#kubernetes_basics)を参照してください。

<br />




## Kubernetes ダッシュボードの起動
{: #cli_dashboard}

ローカル・システムで Kubernetes ダッシュボードを開くと、クラスターとそのすべてのワーカー・ノードに関する情報が表示されます。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。 このタスクには、[管理者アクセス・ポリシー](cs_users.html#access_policies)が必要です。 現在の[アクセス・ポリシー](cs_users.html#infra_access)を確認してください。

クラスターの Kubernetes ダッシュボードを起動するために、デフォルトのポートを使用するか、独自のポートを設定できます。

1.  バージョン 1.7.4 以前の Kubernetes マスターを使用するクラスターの場合は、以下のようにします。

    1.  デフォルトのポート番号でプロキシーを設定します。

        ```
        kubectl proxy
        ```
        {: pre}

        出力:

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Web ブラウザーで Kubernetes ダッシュボードを開きます。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  バージョン 1.8.2 以降の Kubernetes マスターを使用するクラスターの場合は、以下のようにします。

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

[次に、ダッシュボードから構成ファイルを実行できます。](#app_ui)

Kubernetes ダッシュボードでの作業が完了したら、`CTRL+C` を使用して `proxy` コマンドを終了します。 終了した後は、Kubernetes ダッシュボードを使用できなくなります。 Kubernetes ダッシュボードを再始動するには、`proxy` コマンドを実行します。



<br />




## シークレットの作成
{: #secrets}

Kubernetes シークレットは、機密情報 (ユーザー名、パスワード、鍵など) を安全に保管するための手段です。
{:shortdesc}

<table>
<caption>表。 シークレットに保管する必要があるファイル (タスク別)</caption>
<thead>
<th>タスク</th>
<th>シークレットに保管する必要があるファイル</th>
</thead>
<tbody>
<tr>
<td>クラスターにサービスを追加する</td>
<td>なし。 サービスをクラスターにバインドすると、シークレットが自動的に作成されます。</td>
</tr>
<tr>
<td>オプション: Ingress シークレットを使用しない場合は、Ingress サービスに TLS を構成します。 <p><b>注</b>: TLS はデフォルトで既に有効になっていて、TLS 接続用のシークレットが既に作成されています。

デフォルトの TLS シークレットを表示するには、次のようにします。
<pre>
bx cs cluster-get &gt;CLUSTER-NAME&lt; | grep "Ingress secret"
</pre>
</p>
代わりに独自のものを作成するには、このトピックの手順を実行してください。</td>
<td>サーバーの証明書と鍵: <code>server.crt</code> と <code>server.key</code></td>
<tr>
<td>相互認証アノテーションを作成します。</td>
<td>CA 証明書: <code>ca.crt</code></td>
</tr>
</tbody>
</table>

シークレットに保管できるものについて詳しくは、[Kubernetes の資料](https://kubernetes.io/docs/concepts/configuration/secret/)を参照してください。



証明書を含んだシークレットを作成するには、以下のようにします。

1. 証明書プロバイダーから認証局 (CA) の証明書と鍵を生成します。 独自のドメインがある場合は、ご使用のドメインの正式な TLS 証明書を購入してください。 テストが目的であれば、自己署名証明書を生成できます。

 重要: 証明書ごとに異なる [CN](https://support.dnsimple.com/articles/what-is-common-name/) を使用してください。

 クライアント証明書とクライアント鍵は、トラステッド・ルート証明書 (この場合は CA 証明書) まで検証する必要があります。次に例を示します。

 ```
 Client Certificate: issued by Intermediate Certificate
 Intermediate Certificate: issued by Root Certificate
 Root Certificate: issued by itself
 ```
 {: codeblock}

2. 証明書を Kubernetes シークレットとして作成します。

   ```
   kubectl create secret generic <secretName> --from-file=<cert_file>=<cert_file>
   ```
   {: pre}

   例:
   - TLS 接続:

     ```
     kubectl create secret tls <secretName> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
     ```
     {: pre}

   - 相互認証アノテーション:

     ```
     kubectl create secret generic <secretName> --from-file=ca.crt=ca.crt
     ```
     {: pre}

<br />





## GUI でアプリをデプロイする方法
{: #app_ui}

Kubernetes ダッシュボードを使用してアプリをクラスターにデプロイすると、デプロイメント・リソースが、クラスター内にポッドを自動的に作成し、更新および管理します。{:shortdesc}

開始前に、以下のことを行います。

-   必要な [CLI](cs_cli_install.html#cs_cli_install) をインストールします。
-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

アプリをデプロイするには、以下の手順で行います。

1.  [Kubernetes ダッシュボードを開きます](#cli_dashboard)。
2.  Kubernetes ダッシュボードで**「+ 作成」**をクリックします。
3.  **「ここでアプリの詳細情報を指定する (Specify app details below)」**を選択してアプリの詳細情報を GUI で入力するか、**「YAML ファイルまたは JSON ファイルをアップロードする (Upload a YAML or JSON file)」**を選択してアプリの[構成ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) をアップロードします。 [このサンプル YAML ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) を使用して米国南部地域の **ibmliberty** イメージからコンテナーをデプロイします。
4.  Kubernetes ダッシュボードで**「デプロイメント」**をクリックして、デプロイメントが作成されたことを確認します。
5.  ノード・ポート・サービス、ロード・バランサー・サービス、または Ingress を使用して、アプリをだれでも利用できるようにした場合は、アプリにアクセスできることを確認します。

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

2.  クラスターのコンテキストで構成ファイルを実行します。

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  ノード・ポート・サービス、ロード・バランサー・サービス、または Ingress を使用して、アプリをだれでも利用できるようにした場合は、アプリにアクセスできることを確認します。

<br />





## アプリのスケーリング
{: #app_scaling}

Kubernetes では、[ポッドの自動水平スケーリング ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) を有効にして、CPU に基づいてアプリのインスタンス数を自動的に増減できます。{:shortdesc}

Cloud Foundry アプリケーションのスケーリングに関する情報をお探しですか?
[IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html) を参照してください。 
{: tip}

開始前に、以下のことを行います。
- [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。
- 自動スケーリングするクラスターに Heapster モニターをデプロイする必要があります。

1.  CLI を使用して、アプリをクラスターにデプロイします。 アプリをデプロイする時に、CPU を要求する必要があります。

    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
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

2.  自動スケーリング機能を作成し、ポリシーを定義します。`kubetcl autoscale` コマンドの使い方について詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale) を参照してください。

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
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

1.  変更を[ロールアウト ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#rollout) します。 例えば、初期デプロイメントで使用したイメージを変更することができます。

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

