---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

subcollection: containers

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
{:preview: .preview}



# チュートリアル: Kubernetes クラスターの作成
{: #cs_cluster_tutorial}

このチュートリアルを使用すると、{{site.data.keyword.containerlong}} で Kubernetes クラスターをデプロイおよび管理することができます。 架空の PR 会社という設定を用いて、{{site.data.keyword.ibmwatson}} などの他のクラウド・サービスと統合するクラスターのコンテナー化アプリのデプロイメント、操作、スケーリング、およびモニタリングを自動化する方法について説明します。
{:shortdesc}

## 達成目標
{: #tutorials_objectives}

このチュートリアルでは、ある PR 会社の社員になったつもりで、カスタムの Kubernetes クラスター環境をセットアップして構成するための一連のレッスンを完了します。最初に、{{site.data.keyword.cloud_notm}} CLI をセットアップし、{{site.data.keyword.containershort_notm}} クラスターを作成し、PR 会社のイメージをプライベート {{site.data.keyword.registrylong}} に格納します。その後、{{site.data.keyword.toneanalyzerfull}} サービスをプロビジョンし、クラスターにバインドします。クラスターで Hello World アプリをデプロイおよびテストした後、より複雑で可用性の高いバージョンの {{site.data.keyword.watson}} アプリを段階的にデプロイし、PR 会社が最新の AI テクノロジーを使用してプレス・リリースを分析し、フィードバックを受け取れるようにします。
{:shortdesc}

以下の図は、このチュートリアルでセットアップする内容をまとめたものです。

<img src="images/tutorial_ov.png" width="500" alt="クラスターの作成と Watson アプリのデプロイの概要の図" style="width:500px; border-style: none"/>

## 所要時間
{: #tutorials_time}

60 分


## 対象読者
{: #tutorials_audience}

このチュートリアルは、初めて Kubernetes クラスターを作成してアプリをデプロイするソフトウェア開発者やシステム管理者を対象にしています。
{: shortdesc}

## 前提条件
{: #tutorials_prereqs}

-  [クラスター作成の準備](/docs/containers?topic=containers-clusters#cluster_prepare)に必要な手順を確認します。
-  以下のアクセス・ポリシーがあることを確認します。
    - {{site.data.keyword.containerlong_notm}} に対する[**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)
    - {{site.data.keyword.registrylong_notm}} に対する[**管理者**の {{site.data.keyword.Bluemix_notm}} IAM プラットフォーム役割](/docs/containers?topic=containers-users#platform)
    - {{site.data.keyword.containerlong_notm}} に対する[**ライター**または**管理者**の {{site.data.keyword.Bluemix_notm}} IAM サービス役割](/docs/containers?topic=containers-users#platform)

## レッスン 1: クラスター環境をセットアップする
{: #cs_cluster_tutorial_lesson1}

{{site.data.keyword.Bluemix_notm}} コンソールで Kubernetes クラスターを作成し、必要な CLI をインストールし、コンテナー・レジストリーをセットアップし、CLI で Kubernetes クラスターのコンテキストを設定します。
{: shortdesc}

プロビジョンには数分かかることがあるため、クラスターを作成してから、クラスター環境の残りの部分をセットアップします。

1.  [{{site.data.keyword.Bluemix_notm}} コンソール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン") で](https://cloud.ibm.com/kubernetes/catalog/cluster/create)、1 つのワーカー・ノードがある 1 つのワーカー・プールを持つフリー・クラスターまたは標準クラスターを作成します。

    [CLI でクラスター](/docs/containers?topic=containers-clusters#clusters_cli_steps)を作成することもできます。
    {: tip}
2.  クラスターをプロビジョンしている間に、[{{site.data.keyword.Bluemix_notm}} CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](/docs/cli?topic=cloud-cli-getting-started) をインストールします。このインストールには、以下が含まれます。
    -   基本 {{site.data.keyword.Bluemix_notm}} CLI (`ibmcloud`)。
    -   {{site.data.keyword.containerlong_notm}} プラグイン (`ibmcloud ks`)。このプラグインを使用して、追加したコンピュート容量のためのワーカー・プールのサイズ変更や、クラスターへの {{site.data.keyword.Bluemix_notm}} サービスのバインドなど、Kubernetes クラスターの管理を行います。
    -   {{site.data.keyword.registryshort_notm}} プラグイン (`ibmcloud cr`)。 このプラグインを使用して、{{site.data.keyword.registryshort_notm}} でプライベート・イメージ・リポジトリーをセットアップして管理します。
    -   Kubernetes CLI (`kubectl`)。この CLI を使用して、アプリのポッドやサービスなど Kubernetes リソースをデプロイおよび管理します。

    {{site.data.keyword.Bluemix_notm}} コンソールを代わりに使用する場合は、クラスターが作成された後、[Kubernetes Terminal](/docs/containers?topic=containers-cs_cli_install#cli_web) の Web ブラウザーから直接 CLI コマンドを実行できます。
    {: tip}
3.  端末で、{{site.data.keyword.Bluemix_notm}} アカウントにログインします。プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。 フェデレーテッド ID がある場合、`--sso` フラグを使用してログインします。 地域を選択し、該当する場合は、クラスターを作成したリソース・グループ (`-g`) をターゲットにします。
    ```
    ibmcloud login [-g <resource_group>] [--sso]
    ```
    {: pre}
5.  プラグインが正しくインストールされていることを確認します。
    ```
    ibmcloud plugin list
    ```
    {: pre}

    {{site.data.keyword.containerlong_notm}} プラグインは **kubernetes-service** として結果に表示され、{{site.data.keyword.registryshort_notm}} プラグインは **container-registry** として結果に表示されます。
6.  独自のプライベート・イメージ・リポジトリーを {{site.data.keyword.registryshort_notm}} にセットアップすることによって、Docker イメージを安全に保管し、すべてのクラスター・ユーザーと共有します。 {{site.data.keyword.Bluemix_notm}} 内のプライベート・イメージ・リポジトリーは、名前空間によって識別されます。 イメージ・リポジトリーの固有の URL を作成するために名前空間が使用されます。開発者はこれを使用してプライベート Dockerイメージにアクセスできます。
    コンテナー・イメージを使用する際の[個人情報の保護](/docs/containers?topic=containers-security#pi)の詳細を確認してください。

    この例で PR 会社はイメージ・リポジトリーを {{site.data.keyword.registryshort_notm}} に 1 つだけを作成するので、アカウント内のすべてのイメージをグループする名前空間として `pr_firm` を選択します。 `<namespace>` を、このチュートリアルに関係のない任意の名前空間に置き換えてください。

    ```
    ibmcloud cr namespace-add <namespace>
    ```
    {: pre}
7.  次のステップに進む前に、ワーカー・ノードのデプロイメントが完了したことを確認します。
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    ワーカー・ノードのプロビジョニングが終了すると、状況が **Ready** に変わり、{{site.data.keyword.Bluemix_notm}} サービスのバインドを開始できます。

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-pafe24f557f070463caf9e31ecf2d96625-w1   169.xx.xxx.xxx   10.xxx.xx.xxx   free           normal   Ready    mil01      1.13.8
    ```
    {: screen}
8.  CLI で Kubernetes クラスターのコンテキストを設定します。
    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。 クラスターの作業を行うために {{site.data.keyword.containerlong}} CLI にログインするたびに、これらのコマンドを実行して、クラスターの構成ファイルのパスをセッション変数として設定する必要があります。 Kubernetes CLI はこの変数を使用して、{{site.data.keyword.Bluemix_notm}} 内のクラスターと接続するために必要なローカル構成ファイルと証明書を検索します。<p class="tip">Windows PowerShell を使用していますか? Windows PowerShell 形式の環境変数を取得するには、`--powershell` フラグを含めます。</p>
        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        構成ファイルのダウンロードが完了すると、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。

        OS X の場合の例:
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/    pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}
    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。
    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。

        OS X の場合の例:
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        出力例:

        ```
        /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Kubernetes CLI サーバーのバージョンを調べて、クラスターで `kubectl` コマンドが正常に実行されることを確認します。
        ```
        kubectl version  --short
        ```
        {: pre}

        出力例:

        ```
        Client Version: v1.13.8
  Server Version: v1.13.8
        ```
        {: screen}

お疲れさまでした。 正常に CLI をインストールして、今後のレッスンで使用するクラスター・コンテキストをセットアップすることができました。次に、クラスター環境をセットアップして {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} サービスを追加します。

<br />


## レッスン 2: クラスターに IBM Cloud サービスを追加する
{: #cs_cluster_tutorial_lesson2}

{{site.data.keyword.Bluemix_notm}} サービスを使用すると、既に開発された機能をアプリで活用できます。 Kubernetes クラスターにバインドされているすべての {{site.data.keyword.Bluemix_notm}} サービスは、そのクラスターにデプロイされたアプリで使用できます。 アプリで使用する {{site.data.keyword.Bluemix_notm}} サービスごとに、以下の手順を繰り返してください。
{: shortdesc}

1.  {{site.data.keyword.toneanalyzershort}} サービスを、クラスターと同じ地域の {{site.data.keyword.Bluemix_notm}} アカウントに追加します。`<service_name>` をサービス・インスタンスの名前に、`<region>` をクラスターが配置されている地域にそれぞれ置き換えます。

    {{site.data.keyword.toneanalyzershort}} サービスをアカウントに追加すると、そのサービスが無料ではないことを示すメッセージが表示されます。 API 呼び出しを制限している場合には、このチュートリアルによって {{site.data.keyword.watson}} サービスからの課金は発生しません。 [{{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} サービスの料金情報を確認します ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/catalog/services/tone-analyzer)。
    {: note}

    ```
    ibmcloud resource service-instance-create <service_name> tone-analyzer standard <region>
    ```
    {: pre}
2.  {{site.data.keyword.toneanalyzershort}} インスタンスをクラスターの `default` の Kubernetes 名前空間にバインドします。 あとで独自の名前空間を作成して Kubernetes リソースへのユーザー・アクセスを管理できますが、現時点では `default` 名前空間を使用します。 Kubernetes 名前空間は、以前に作成したレジストリー名前空間とは異なります。
    ```
    ibmcloud ks cluster-service-bind --cluster <cluster_name> --namespace default --service <service_name>
    ```
    {: pre}

    出力例:
    ```
    ibmcloud ks cluster-service-bind pr_firm_cluster default mytoneanalyzer
    Binding service instance to namespace...
    OK
    Namespace:	default
    Secret name:	binding-mytoneanalyzer
    ```
    {: screen}
3.  クラスターの名前空間内に Kubernetes シークレットが作成されたことを確認します。 [{{site.data.keyword.Bluemix_notm}} サービスをクラスターにバインド](/docs/containers?topic=containers-service-binding)すると、JSON ファイルが生成されます。このファイルには、コンテナーがサービスに対するアクセス権を取得するために使用する {{site.data.keyword.Bluemix_notm}} の IAM (ID およびアクセス管理) API キーと URL などの機密情報が含まれます。この情報を安全に保管するため、JSON ファイルは Kubernetes シークレットに保管されます。

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    出力例:

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
おつかれさまでした。 クラスターが構成され、ローカル環境でアプリをクラスターにデプロイする準備が整いました。

次のレッスンに進む前に、これまでの理解のテストと[簡単なクイズ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php) に挑戦してみましょう。
{: note}

<br />


## レッスン 3: アプリの 1 つのインスタンスを Kubernetes クラスターにデプロイする
{: #cs_cluster_tutorial_lesson3}

前のレッスンでは、1 つのワーカー・ノードのあるクラスターをセットアップしました。このレッスンでは、デプロイメントを構成し、そのワーカー・ノード内の Kubernetes ポッドにアプリの単一インスタンスをデプロイします。
{:shortdesc}

次の図は、このレッスンを実行してデプロイするコンポーネントを示しています。

![デプロイメントのセットアップ](images/cs_app_tutorial_mz-components1.png)

アプリをデプロイするには、以下のようにします。

1.  [Hello World アプリ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM/container-service-getting-started-wt) のソース・コードをユーザー・ホーム・ディレクトリーに複製します。 このリポジトリーには、同じアプリのさまざまなバージョンが、`Lab` で始まる各フォルダーに入っています。 各バージョンに以下のファイルがあります。
    *   `Dockerfile`: イメージのビルド定義。
    *   `app.js`: Hello World アプリ。
    *   `package.json`: アプリに関するメタデータ。

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

2.  `Lab 1` ディレクトリーに移動します。
    ```
    cd 'container-service-getting-started-wt/Lab 1'
    ```
    {: pre}
3.  {{site.data.keyword.registryshort_notm}} CLI にログインします。
    ```
    ibmcloud cr login
    ```
    {: pre}

    {{site.data.keyword.registryshort_notm}} の名前空間を忘れた場合は、以下のコマンドを実行します。
    ```
    ibmcloud cr namespace-list
    ```
    {: pre}
4.  `Lab 1` ディレクトリーのアプリ・ファイルを組み込んだ Docker イメージをビルドし、以前のレッスンで作成した {{site.data.keyword.registryshort_notm}} 名前空間にイメージをプッシュします。 後日アプリを変更しなければならなくなった場合は、この手順を繰り返して別バージョンのイメージを作成します。 **注**: コンテナー・イメージを使用する際の[個人情報の保護](/docs/containers?topic=containers-security#pi)の詳細を確認してください。

    イメージ名には小文字の英数字または下線 (`_`) のみを使用してください。 コマンドの末尾にピリオド (`.`) をつけることを忘れないようにしてください。 このピリオドは、イメージをビルドするための Dockerfile とビルド成果物を、現行ディレクトリー内で探すよう Docker に指示するものです。 **注**: [レジストリー地域](/docs/services/Registry?topic=registry-registry_overview#registry_regions) (`us` など) を指定する必要があります。現在自分が属するレジストリーの地域を取得するには、`ibmcloud cr region` を実行します。

    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:1 .
    ```
    {: pre}

    ビルドが完了したら、次の正常終了のメッセージを確認してください。

    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
5.  デプロイメントを作成します。 ポッドはデプロイメントを使用して管理され、コンテナー化されたアプリ・インスタンスを格納するために使用されます。 以下のコマンドは、プライベート・レジストリー内にビルドしたイメージを参照することによって、1 つのポッド内にアプリをデプロイします。このチュートリアルのためにデプロイメントの名前は **hello-world-deployment** になっていますが、任意の名前を付けることができます。
    ```
    kubectl create deployment hello-world-deployment --image=<region>.icr.io/<namespace>/hello-world:1
    ```
    {: pre}

    出力例:
    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Kubernetes リソースを処理する際の[個人情報の保護](/docs/containers?topic=containers-security#pi)の詳細を確認してください。
6.  デプロイメントを NodePort サービスとして公開することによって、だれでもアプリにアクセスできるようにします。 Cloud Foundry アプリのポートを公開する場合と同じく、ここで公開する NodePort は、そのワーカー・ノードがトラフィックを listen するポートです。
    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    出力例:
    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table summary="公開コマンドのパラメーターに関する情報。">
    <caption>公開パラメーターに関する詳細</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> expose のパラメーターに関する詳細</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>リソースを Kubernetes サービスとして公開し、一般のユーザーが利用できるようにします。</td>
    </tr>
    <tr>
    <td><code>deployment/<em>&lt;hello-world-deployment&gt;</em></code></td>
    <td>このサービスを使用して公開するリソース・タイプとリソースの名前。</td>
    </tr>
    <tr>
    <td><code>--name=<em>&lt;hello-world-service&gt;</em></code></td>
    <td>サービスの名前。</td>
    </tr>
    <tr>
    <td><code>--port=<em>&lt;8080&gt;</em></code></td>
    <td>サービスが動作するポート。</td>
    </tr>
    <tr>
    <td><code>--type=NodePort</code></td>
    <td>作成するサービス・タイプ。</td>
    </tr>
    <tr>
    <td><code>--target-port=<em>&lt;8080&gt;</em></code></td>
    <td>サービスがトラフィックを転送する宛先ポート。 この例では、target-port が port と同じですが、作成する他のアプリでは異なる場合があります。</td>
    </tr>
    </tbody></table>
7. デプロイメントの作業がすべて完了したので、ブラウザーでアプリをテストできます。 URL を作成するための詳細情報を取得します。
    1.  サービスに関する情報を取得して、割り当てられた NodePort を確認します。
        ```
        kubectl describe service hello-world-service
        ```
        {: pre}

        出力例:
        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.xxx.xx.xxx
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.xxx.xxx:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        `expose` コマンドで NodePort を生成すると、30000 から 32767 の範囲でランダムに値が割り当てられます。 この例では、NodePort は 30872 です。
    2.  クラスター内のワーカー・ノードのパブリック IP アドレスを取得します。
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}

        出力例:
        ```
        ibmcloud ks workers --cluster pr_firm_cluster
        Listing cluster workers...
        OK
        ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
        kube-mil01-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    free           normal   Ready    mil01      1.13.8
        ```
        {: screen}
8. ブラウザーを開き、`http://<IP_address>:<NodePort>` という形式の URL でアプリを確認します。 この例の値を使用した場合、URL は `http://169.xx.xxx.xxx:30872` になります。 その URL をブラウザーに入力すると、以下のテキストが表示されます。
    ```
    Hello world! Your app is up and running in a cluster!
    ```
    {: screen}

    アプリが公開されていることを確認するには、これを携帯電話のブラウザーに入力してみてください。
    {: tip}
9. [Kubernetes ダッシュボードを起動](/docs/containers?topic=containers-app#cli_dashboard)します。

    [{{site.data.keyword.Bluemix_notm}} コンソール](https://cloud.ibm.com/) でクラスターを選択した場合は、**「Kubernetes ダッシュボード (Kubernetes Dashboard)」**ボタンを使用して、1 回のクリックでダッシュボードを起動できます。
    {: tip}
10. **「ワークロード」**タブで、作成したリソースを表示します。

お疲れさまでした。 最初のバージョンのアプリをデプロイできました。

このレッスンで実行したコマンドの数が多すぎると思うなら、一部の処理を自動化するために構成スクリプトを使用できます。 第 2 バージョンのアプリでは構成スクリプトを使用します。また、アプリのインスタンスを複数デプロイして可用性を高めます。その方法を学ぶために次のレッスンに進みましょう。

**クリーンアップ**<br>
次のレッスンに進む前に、このレッスンで作成したリソースを削除することもできます。デプロイメントには、その作成時に Kubernetes によって `app=hello-world-deployment` というラベル (またはデプロイメントの名前として指定したラベル) が割り当てられています。その後、デプロイメントを公開したときには、Kubernetes によって、作成されたサービスに同じ名前のラベルが適用されています。ラベルは、`get` や `delete` などの一括アクションを適用できるように Kubernetes リソースを整理するのに役立つツールです。

  `app=hello-world-deployment` というラベルを持つすべてのリソースを確認することができます。
  ```
  kubectl get all -l app=hello-world-deployment
  ```
  {: pre}

  その後、そのラベルを持つすべてのリソースを削除できます。
  ```
  kubectl delete all -l app=hello-world-deployment
  ```
  {: pre}

  出力例:
  ```
  pod "hello-world-deployment-5c78f9b898-b9klb" deleted
  service "hello-world-service" deleted
  deployment.apps "hello-world-deployment" deleted
  ```
  {: screen}

<br />


## レッスン 4: 可用性を高めたアプリをデプロイして更新する
{: #cs_cluster_tutorial_lesson4}

このレッスンでは、Hello World アプリの 3 つのインスタンスをクラスターにデプロイして、最初のバージョンのアプリよりも可用性を高めます。
{:shortdesc}

可用性が高くなることは、ユーザー・アクセスが 3 つのインスタンスに分割されることを意味します。 同じアプリ・インスタンスにアクセスするユーザーが多すぎると、応答時間が長くなる可能性があります。 複数のインスタンスをデプロイすれば、ユーザーにとって応答時間が短くなります。 このレッスンでは、Kubernetes でのヘルス・チェックとデプロイメント更新の処理についても取り上げます。 次の図には、このレッスンを完了することによりデプロイされるコンポーネントが含まれています。

![デプロイメントのセットアップ](images/cs_app_tutorial_mz-components2.png)

これまでのレッスンで、1 つのワーカー・ノードが含まれるクラスターを作成し、1 つのアプリ・インスタンスをデプロイしました。このレッスンでは、デプロイメントを構成して、Hello World アプリの 3 つのインスタンスをデプロイします。 各インスタンスは、ワーカー・ノード内のレプリカ・セットの一部として、Kubernetes ポッドにデプロイされます。 それをだれでも利用できるようにするために、Kubernetes サービスも作成します。

Kubernetes では、構成スクリプトで定義する可用性検査を使用して、ポッド内のコンテナーが稼働しているかどうかを確認できます。 例えば、その検査によってデッドロックをキャッチできます。デッドロックとは、アプリは稼働しているのに処理を進められない状況のことです。 そのような状態になったコンテナーを再始動すれば、バグはあってもアプリの可用性を高めることができます。 その後、Kubernetes で準備状況検査を使用して、コンテナーでトラフィックの受け入れを再開する準備が整っているかどうかを確認します。 コンテナーの準備が整っていれば、そのポッドの準備も整ったことになります。 ポッドの準備が整えば、ポッドが再び開始されます。 このバージョンのアプリでは、15 秒ごとにタイムアウトになります。 構成スクリプトでヘルス・チェックを構成しておけば、ヘルス・チェックでアプリの問題が検出された時点でコンテナーが再作成されます。

前回のレッスンを中断して、新しい端末を開始した場合は、必ずクラスターに再度ログインしてください。

1.  端末で、`Lab 2` ディレクトリーに移動します。
    ```
    cd 'container-service-getting-started-wt/Lab 2'
    ```
    {: pre}
2.  {{site.data.keyword.registryshort_notm}} の名前空間へのイメージとして、アプリをビルドして、タグを指定し、プッシュします。 コマンドの末尾にピリオド (`.`) をつけることを忘れないようにしてください。
    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:2 .
      ```
    {: pre}

    正常終了のメッセージを確認します。
    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
3.  `Lab 2` ディレクトリーで、`healthcheck.yml` ファイルをテキスト・エディターで開きます。この構成スクリプトでは、前のレッスンの手順をいくつか結合して、デプロイメントとサービスを同時に作成します。 この PR 会社のアプリ開発者は、更新の適用時や、ポッドを再作成して問題をトラブルシューティングする時に、そのスクリプトを使用できます。
    1.  プライベート・レジストリー名前空間内のイメージの詳細情報を更新します。
        ```
        image: "<region>.icr.io/<namespace>/hello-world:2"
        ```
        {: codeblock}
    2.  **Deployment** セクションにある `replicas` の値に注目します。 replicas の値は、アプリのインスタンスの数です。 3 つのインスタンスを実行すれば、インスタンスが 1 つだけの場合よりもアプリの可用性は高くなります。
        ```
        replicas: 3
        ```
        {: codeblock}
    3.  HTTP の Liveness Probe の値に注目します。5 秒ごとにコンテナーの正常性を検査することになっています。
        ```
        livenessProbe:
                    httpGet:
                      path: /healthz
                      port: 8080
                    initialDelaySeconds: 5
                    periodSeconds: 5
        ```
        {: codeblock}
    4.  **Service** セクションにある `NodePort` の値に注目します。 前のレッスンのようにランダムな NodePort を生成する代わりに、30000 から 32767 の範囲でポートを指定できます。 この例では 30072 を使用しています。
4.  クラスターのコンテキストの設定時に使用した CLI に切り替え、構成スクリプトを実行します。 デプロイメントとサービスを作成すると、PR 会社のユーザーがアプリを表示できるようになります。
    ```
    kubectl apply -f healthcheck.yml
    ```
    {: pre}

    出力例:
    ```
    deployment "hw-demo-deployment" created
  service "hw-demo-service" created
    ```
    {: screen}
5.  これで、デプロイメント作業は完了です。ブラウザーを開いてアプリを確認しましょう。前のレッスンで使用したのと同じワーカー・ノードのパブリック IP アドレスに、構成スクリプトで指定した NodePort を組み合わせて、URL を作成します。 ワーカー・ノードのパブリック IP アドレスを取得するには、以下のようにします。
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    この例の値を使用した場合、URL は `http://169.xx.xxx.xxx:30072` になります。 ブラウザーに以下のテキストが表示される可能性があります。 そのテキストが表示されなくても、心配は無用です。 このアプリは、稼働状態になったりダウン状態になったりする設計になっているからです。
    ```
    Hello world! Great job getting the second stage up and running!
    ```
    {: screen}

    `http://169.xx.xxx.xxx:30072/healthz` で状況を確認することもできます。

    最初の 10 秒から 15 秒で 200 というメッセージが返されます。アプリが正常に稼働しているという意味のメッセージです。 その 15 秒が経過すると、タイムアウト・メッセージが表示されます。 これは予期される動作です。
    ```
    {
      "error": "Timeout, Health check error!"
  }
    ```
    {: screen}
6.  ポッドの状況を確認して、Kubernetes のアプリの正常性をモニターします。 この状況は、CLI または Kubernetes ダッシュボードで確認できます。
    *   **CLI を使用する場合**: 状況が変更されるときに、ポッドに何が起こっているのかを確認します。
        ```
        kubectl get pods -o wide -w
        ```
        {: pre}
    *   **Kubernetes ダッシュボードを使用する場合**:
        1.  [Kubernetes ダッシュボードを起動](/docs/containers?topic=containers-app#cli_dashboard)します。
        2.  **「ワークロード」**タブで、作成したリソースを表示します。 このタブから、ヘルス・チェックの作動状況を継続的にリフレッシュして確認できます。 **「ポッド (Pods)」**セクションには、ポッド内のコンテナーの再作成時にポッドが再始動した回数が表示されます。 ダッシュボードで以下のエラー・メッセージがキャッチされた場合は、ヘルス・チェックで問題が検出されています。 数分待ってから再度リフレッシュしてみてください。 各ポッドの再始動回数が変わっているはずです。
        ```
        Liveness probe failed: HTTP probe failed with statuscode: 500
        Back-off restarting failed docker container
        Error syncing pod, skipping: failed to "StartContainer" for "hw-container" w      CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-d     deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
        ```
        {: screen}

2 つ目のバージョンのアプリをデプロイできました。使用するコマンドの数を減らし、ヘルス・チェックの動作を学び、デプロイメントを編集できました。 Hello World アプリは、PR 会社のテストに合格したといえます。 次の段階として、PR 会社がプレス・リリースの分析作業を開始するのに役立つアプリをデプロイしましょう。

**クリーンアップ**<br>
次のレッスンに進む前に、作成したものを削除してもかまいません。同じ構成スクリプトを使用して、作成した両方のリソースを削除できます。

  ```
  kubectl delete -f healthcheck.yml
  ```
  {: pre}

  出力例:

  ```
  deployment "hw-demo-deployment" deleted
  service "hw-demo-service" deleted
  ```
  {: screen}

<br />


## レッスン 5: Watson Tone Analyzer アプリをデプロイして更新する
{: #cs_cluster_tutorial_lesson5}

前の各レッスンでは、アプリを複数の単一コンポーネントとして 1 つのワーカー・ノードにデプロイしました。 このレッスンでは、{{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} サービスを利用するアプリの 2 つのコンポーネントをクラスターにデプロイします。
{:shortdesc}

各コンポーネントを異なるコンテナーに分離しておけば、1 つのコンポーネントの更新時に他のコンポーネントに影響が及ぶことを防止できます。 また、アプリを更新し、レプリカの追加でスケールを大きくして可用性をさらに高めるようにします。 次の図には、このレッスンを完了することによりデプロイされるコンポーネントが含まれています。

![デプロイメントのセットアップ](images/cs_app_tutorial_mz-components3.png)

直前のチュートリアルから引き継いで使用するアカウントと、1 つのワーカー・ノードを持つクラスターがあります。 このレッスンでは、{{site.data.keyword.Bluemix_notm}} アカウントに {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} サービスのインスタンスを作成し、2 つのデプロイメント (アプリのコンポーネントごとに 1 つのデプロイメント) を構成します。 各コンポーネントは、ワーカー・ノード内の Kubernetes ポッドにデプロイされます。 それら両方のコンポーネントをだれでも利用できるようにするために、コンポーネントごとに Kubernetes サービスも作成します。


### レッスン 5a: {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} アプリをデプロイする
{: #lesson5a}

{{site.data.keyword.watson}} アプリをデプロイし、パブリックからサービスにアクセスし、アプリで一部のテキストを分析します。
{: shortdesc}

前回のレッスンを中断して、新しい端末を開始した場合は、必ずクラスターに再度ログインしてください。

1.  CLI で `Lab 3` ディレクトリーに移動します。
    ```
    cd 'container-service-getting-started-wt/Lab 3'
    ```
    {: pre}

2.  最初の {{site.data.keyword.watson}} イメージをビルドします。
    1.  `watson` ディレクトリーに移動します。
        ```
        cd watson
        ```
        {: pre}
    2.  {{site.data.keyword.registryshort_notm}} の名前空間へのイメージとして、`watson` アプリをビルドして、タグを指定し、プッシュします。 この場合も、コマンドの末尾にピリオド (`.`) を付けることを忘れないようにしてください。
        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson .
        ```
        {: pre}

        正常終了のメッセージを確認します。
        ```
        Successfully built <image_id>
        ```
        {: screen}
    3.  これらのステップを繰り返して、2 つ目の `watson-talk` イメージをビルドします。
        ```
        cd 'container-service-getting-started-wt/Lab 3/watson-talk'
        ```
        {: pre}

        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson-talk .
        ```
        {: pre}
3.  それぞれのイメージがレジストリー名前空間に正常に追加されたことを確認します。
    ```
    ibmcloud cr images
    ```
    {: pre}

    出力例:

    ```
    Listing images...

    REPOSITORY                        NAMESPACE  TAG      DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    us.icr.io/namespace/watson        namespace  latest   fedbe587e174   3 minutes ago   274 MB   OK
    us.icr.io/namespace/watson-talk   namespace  latest   fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}
4.  `Lab 3` ディレクトリーで、`watson-deployment.yml` ファイルをテキスト・エディターで開きます。この構成スクリプトには、アプリの `watson` のコンポーネントと `watson-talk` のコンポーネントの両方のデプロイメントとサービスが含まれています。
    1.  レジストリー名前空間にある両方のデプロイメントのイメージの詳細情報を更新します。
        **watson**:
        ```
        image: "<region>.icr.io/<namespace>/watson"
        ```
        {: codeblock}

        **watson-talk**:
        ```
        image: "<region>.icr.io/<namespace>/watson-talk"
        ```
        {: codeblock}
    2.  `watson-pod` デプロイメントの volumes セクションで、[レッスン 2](#cs_cluster_tutorial_lesson2) で作成した {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} シークレットの名前を更新します。Kubernetes シークレットをボリュームとしてデプロイメントにマウントすることにより、ポッドで実行されているコンテナーが {{site.data.keyword.Bluemix_notm}} の IAM (ID およびアクセス管理) API キーを使用できるようにします。このチュートリアルの {{site.data.keyword.watson}} アプリ・コンポーネントは、ボリューム・マウント・パスを使用して API キーを検索するように構成されています。
        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-mytoneanalyzer
        ```
        {: codeblock}

        シークレットの名前を忘れた場合は、以下のコマンドを実行します。
        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}
    3.  watson-talk の service セクションで、`NodePort` の設定値に注目します。 この例では 30080 を使用しています。
5.  構成スクリプトを実行します。
    ```
    kubectl apply -f watson-deployment.yml
    ```
    {: pre}
6.  オプション: {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} のシークレットがポッドに対してボリュームとしてマウントされたことを確認します。
    1.  watson ポッドの名前を取得するには、以下のコマンドを実行します。
        ```
        kubectl get pods
        ```
        {: pre}

        出力例:
        ```
        NAME                                 READY     STATUS    RESTARTS  AGE
        watson-pod-4255222204-rdl2f          1/1       Running   0         13h
        watson-talk-pod-956939399-zlx5t      1/1       Running   0         13h
        ```
        {: screen}
    2.  ポッドの詳細情報を取得して、シークレットの名前を探します。
        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

        出力例:
        ```
        Volumes:
          service-bind-volume:
            Type:       Secret (a volume populated by a Secret)
            SecretName: binding-mytoneanalyzer
          default-token-j9mgd:
            Type:       Secret (a volume populated by a Secret)
            SecretName: default-token-j9mgd
        ```
        {: codeblock}
7.  ブラウザーを開いて、何かのテキストを分析します。 URL の形式は `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/"<text_to_analyze>"` です。
    例:
    ```
    http://169.xx.xxx.xxx:30080/analyze/"Today is a beautiful day"
    ```
    {: codeblock}

    入力したテキストに対する JSON 応答がブラウザーに表示されます。
    ```
    {
      "document_tone": {
        "tone_categories": [
          {
            "tones": [
              {
                "score": 0.011593,
                "tone_id": "anger",
                "tone_name": "Anger"
              },
              ...
            "category_id": "social_tone",
            "category_name": "Social Tone"
          }
        ]
      }
    }
    ```
    {: screen}
8. [Kubernetes ダッシュボードを起動](/docs/containers?topic=containers-app#cli_dashboard)します。
9. **「ワークロード」**タブで、作成したリソースを表示します。

### レッスン 5b: 稼働中の Watson Tone Analyzer デプロイメントを更新する
{: #lesson5b}

デプロイメントの稼働中に、デプロイメントを編集してポッド・テンプレートの値を変更することができます。 このレッスンでは、この PR 会社が、使用されているイメージを更新することによって、デプロイメントのアプリを変更しようとしている状況を想定しています。
{: shortdesc}

イメージの名前を変更します。

1.  稼働中のデプロイメントの構成の詳細情報を開きます。
    ```
    kubectl edit deployment/watson-talk-pod
    ```
    {: pre}

    オペレーティング・システムの種類に応じて、vi エディターかテキスト・エディターのいずれかが開きます。
2.  イメージの名前を `ibmliberty` イメージに変更します。
    ```
    spec:
          containers:
          - image: <region>.icr.io/ibmliberty:latest
    ```
    {: codeblock}
3.  変更内容を保存し、エディターを終了します。
4.  変更内容を稼働中のデプロイメントに適用します。
    ```
    kubectl rollout status deployment/watson-talk-pod
    ```
    {: pre}

    ロールアウトの完了を知らせる確認メッセージが表示されるのを待ちます。
    ```
    deployment "watson-talk-pod" successfully rolled out
    ```
    {: screen}
    変更をロールアウトすると、Kubernetes によって別のポッドが作成されてテストされます。 テストが正常に完了すると、元のポッドは削除されます。

お疲れさまでした。 {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} アプリをデプロイし、単純なアプリ更新の実行方法を学習することができました。PR 会社はこのデプロイメントを使用して、最新の AI テクノロジーを用いたプレス・リリースの分析を開始できます。

**クリーンアップ**<br>
{{site.data.keyword.containerlong_notm}} クラスターに作成した {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} アプリは、削除してもかまいません。構成スクリプトを使用して、作成したリソースを削除できます。

  ```
  kubectl delete -f watson-deployment.yml
  ```
  {: pre}

  出力例:

  ```
  deployment "watson-pod" deleted
  deployment "watson-talk-pod" deleted
  service "watson-service" deleted
  service "watson-talk-service" deleted
  ```
  {: screen}

  クラスターを保持する必要がない場合は、クラスターも削除できます。

  ```
  ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
  ```
  {: pre}

クイズの時間です。多くの点を扱いましたので、[すべて理解しているか確認しましょう ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://ibmcloud-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php)。累積型のクイズではないので、気楽に挑戦してください。
{: note}

<br />


## 次の作業
{: #tutorials_next}

基本を習得したので、さらに高度な作業に進むことができます。 以下のいずれかの資料を参照して、{{site.data.keyword.containerlong_notm}} でさらに多くのことを行ってみることを検討してください。
{: shortdesc}

*   リポジトリー内の[さらに複雑な Lab ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM/container-service-getting-started-wt#lab-overview) を行う。
*   複数ゾーン・クラスター、永続ストレージ、クラスター自動スケーリング、アプリの水平ポッド自動スケーリングなどの機能を使用して、[可用性の高いアプリ](/docs/containers?topic=containers-ha)を作成する方法を学ぶ。
*   [IBM Developer ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/technologies/containers/) でコンテナー・オーケストレーションのコード・パターンを探索する。
