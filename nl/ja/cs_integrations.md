---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# サービスの統合
{: #integrations}

さまざまな外部サービスと {{site.data.keyword.Bluemix_notm}} カタログにあるサービスを {{site.data.keyword.containershort_notm}} の標準クラスターで使用できます。
{:shortdesc}

<table summary="アクセシビリティーについての要約">
<caption>表。 Kubernetes でのクラスターとアプリの統合オプション</caption>
<thead>
<tr>
<th>サービス</th>
<th>説明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Blockchain</td>
<td>{{site.data.keyword.containerlong_notm}} の Kubernetes クラスターに、だれでも利用できる IBM Blockchain 開発環境をデプロイします。 この環境を使用して、独自のブロックチェーン・ネットワークを開発してカスタマイズし、トランザクションの履歴を記録するために変更不可能な台帳を共有するアプリをデプロイできます。 詳しくは、<a href="https://ibm-blockchain.github.io" target="_blank">Develop in a cloud sandbox
IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>Continuous Delivery</td>
<td>アプリのビルドと Kubernetes クラスターへのコンテナーのデプロイメントを、ツールチェーンを使用して自動化します。 セットアップ情報については、<a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> というブログを参照してください。 </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh/" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> は Kubernetes パッケージ・マネージャーです。 Helm Charts を作成することによって、{{site.data.keyword.containerlong_notm}} クラスターで実行される複雑な Kubernetes アプリケーションの定義、インストール、アップグレードを行います。 詳しくは、<a href="https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/" target="_blank">Increase deployment velocity with Kubernetes Helm Charts <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。 </td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> は、アプリを自動的に検出してマップする GUI を使用して、インフラストラクチャーとアプリのパフォーマンス・モニターを提供します。 Istana はさらに、アプリに対するすべての要求をキャプチャーし、問題のトラブルシューティングと根本原因分析を行って、問題の再発を防ぎます。 詳しくは、<a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">{{site.data.keyword.containershort_notm}} での Istana のデプロイ <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> に関するブログ投稿を参照してください。</td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> は Kubernetes などのクラウド・オーケストレーション・プラットフォームでマイクロサービス・ネットワーク (サービス・メッシュともいう) の接続、保護、管理、モニターを行うための方法を開発者に提供するオープン・ソース・サービスです。 このオープン・ソース・プロジェクトの詳細については、<a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">IBM が Istio を共同創設して立ち上げた経過 <img src="../icons/launch-glyph.svg" alt=" 外部リンク・アイコン"></a> に関するブログ投稿を参照してください。 {{site.data.keyword.containershort_notm}} の Kubernetes クラスターに Istio をインストールしてサンプル・アプリの使用を開始するには、[Istio を使用したマイクロサービスの管理に関するチュートリアル](cs_tutorials_istio.html#istio_tutorial)を参照してください。</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus は、特に Kubernetes のために設計されたモニタリング、ロギング、およびアラートのためのオープン・ソースのツールで、Kubernetes のロギング情報に基づいてクラスター、ワーカー・ノード、およびデプロイメントの正常性に関する詳細情報を取得するために使用されます。 クラスター内で実行中のすべてのコンテナーの CPU、メモリー、I/O、およびネットワークのアクティビティーが収集されて、クラスターのパフォーマンスとワークロードをモニターするためにカスタム・クエリーやアラートで使用できます。
<p>Prometheus を使用するには次の手順を実行します。</p>
<ol>
<li><a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">CoreOS の説明 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> に従って Prometheus をインストールします。
<ol>
<li>export コマンドを実行するときには、kube-system 名前空間を使用します。 <p><code>export NAMESPACE=kube-system hack/cluster-monitoring/deploy</code></p></li>
</ol>
</li>
<li>Prometheus がクラスターにデプロイされた後に、<code>prometheus.kube-system:30900</code> を参照するように Grafana の Prometheus データ・ソースを編集します。</li>
</ol>
</td>
</tr>
<tr>
<td>{{site.data.keyword.bpshort}}</td>
<td>{{site.data.keyword.bplong}} は、Terraform を使用してインフラストラクチャーをコードとしてデプロイする自動化ツールです。 インフラストラクチャーを単一ユニットとしてデプロイしたら、そのインフラストラクチャーのクラウドのリソース定義を任意の数の環境で再利用できます。 {{site.data.keyword.bpshort}} を使用して Kubernetes クラスターをリソースとして定義するには、[container-cluster テンプレート](https://console.bluemix.net/schematics/templates/details/Cloud-Schematics%2Fcontainer-cluster)で環境の作成を試してください。 Schematics について詳しくは、[{{site.data.keyword.bplong_notm}} について](/docs/services/schematics/schematics_overview.html#about)を参照してください。</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope は、Kubernetes クラスター内のリソース (サービス、ポッド、コンテナー、プロセス、ノードなど) のビジュアル図を表示します。 Weave Scope は CPU とメモリーのインタラクティブ・メトリックを示し、コンテナーの中で追尾したり実行したりするツールも備えています。<p>詳しくは、[Weave Scope と {{site.data.keyword.containershort_notm}} での Kubernetes クラスター・リソースの視覚化](cs_integrations.html#weavescope)を参照してください。</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## サービスをクラスターに追加する
{: #adding_cluster}

既存の {{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターに追加すると、クラスターのユーザーがアプリをクラスターにデプロイする際にその {{site.data.keyword.Bluemix_notm}} サービスにアクセスして使用できるようになります。
{:shortdesc}

開始前に、以下のことを行います。

1. [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。
2. [{{site.data.keyword.Bluemix_notm}} サービスのインスタンスを要求](/docs/manageapps/reqnsi.html#req_instance)します。
   **注:** ワシントン DC のロケーションでサービスのインスタンスを作成するには、CLI を使用する必要があります。

**注:**
<ul><ul>
<li>サービス・キーをサポートする {{site.data.keyword.Bluemix_notm}} サービスだけを追加できます。 このサービスでサービス・キーがサポートされていない場合は、[{{site.data.keyword.Bluemix_notm}} サービスを使用するための外部アプリの使用可能化](/docs/manageapps/reqnsi.html#accser_external)を参照してください。</li>
<li>サービスを追加するには、その前にクラスターとワーカー・ノードを完全にデプロイしておく必要があります。</li>
</ul></ul>


サービスを追加するには、以下のようにします。
2.  使用可能な {{site.data.keyword.Bluemix_notm}} サービスをリストします。

    ```
    bx service list
    ```
    {: pre}

    CLI 出力例:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  クラスターに追加するサービス・インスタンスの**名前**をメモします。
4.  サービスを追加するために使用するクラスターの名前空間を識別します。 次のいずれかのオプションを選択します。
    -   既存の名前空間をリストして、使用する名前空間を選択します。

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   クラスターに新しい名前空間を作成します。

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  サービスをクラスターに追加します。

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    サービスがクラスターに正常に追加されると、サービス・インスタンスの資格情報を保持するクラスター・シークレットが作成されます。 CLI 出力例:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  クラスターの名前空間内にシークレットが作成されたことを確認します。

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


クラスターにデプロイされたポッドでサービスを使用するために、クラスター・ユーザーは、この [Kubernetes シークレットをシークレット・ボリュームとしてポッドにマウントすることで](cs_integrations.html#adding_app)、{{site.data.keyword.Bluemix_notm}} サービスのサービス資格情報にアクセスできます。

<br />



## サービスをアプリに追加する
{: #adding_app}

暗号化した Kubernetes シークレットを使用して、{{site.data.keyword.Bluemix_notm}} サービスの詳細情報や資格情報を保管し、サービスとクラスターの間のセキュアな通信を確保します。 クラスター・ユーザーがそのシークレットにアクセスするには、そのシークレットをボリュームとしてポッドにマウントする必要があります。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。 アプリで使用する {{site.data.keyword.Bluemix_notm}} サービスが、クラスター管理者によって[クラスターに追加されていること](cs_integrations.html#adding_cluster)を確認してください。

Kubernetes シークレットは、機密情報 (ユーザー名、パスワード、鍵など) を安全に保管するための手段です。 機密情報を環境変数として公開したり、Dockerfile に直接書き込んだりする代わりに、シークレットをシークレット・ボリュームとしてポッドにマウントする必要があります。
そうすれば、ポッドで稼働中のコンテナーからシークレットにアクセスできるようになります。

シークレット・ボリュームをポッドにマウントすると、binding という名前のファイルがボリューム・マウント・ディレクトリーに保管されます。そのファイルに、{{site.data.keyword.Bluemix_notm}} サービスにアクセスするのに必要なすべての情報や資格情報が格納されます。

1.  クラスターの名前空間で使用できるシークレットのリストを表示します。

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    出力例:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  **Opaque** タイプのシークレットを探して、そのシークレットの **NAME** を書き留めます。 複数のシークレットが存在する場合は、クラスター管理者に連絡して、サービスに対応する正しいシークレットを確認してください。

3.  任意のエディターを開きます。

4.  YAML ファイルを作成し、シークレット・ボリュームによってサービスの詳細情報にアクセスできるポッドを構成します。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>コンテナーにマウントするシークレット・ボリュームの名前。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>コンテナーにマウントするシークレット・ボリュームの名前を入力します。</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>サービスのシークレットに対する読み取り専用アクセス権を設定します。</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>先ほど書き留めたシークレットの名前を入力します。</td>
    </tr></tbody></table>

5.  ポッドを作成して、シークレット・ボリュームをマウントします。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  ポッドが作成されたことを確認します。

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    CLI 出力例:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  ポッドの **NAME** を書き留めます。
8.  ポッドの詳細情報を取得して、シークレットの名前を探します。

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    出力:

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  アプリを実装するときには、マウント・ディレクトリーで **binding** という名前のシークレット・ファイルを見つけ、その JSON コンテンツを解析して、{{site.data.keyword.Bluemix_notm}} サービスにアクセスするための URL とサービス資格情報を判別するようにアプリを構成します。

{{site.data.keyword.Bluemix_notm}} サービスの詳細情報や資格情報にアクセスできるようになりました。 {{site.data.keyword.Bluemix_notm}} サービスを利用するために、マウント・ディレクトリーでサービスのシークレット・ファイルを見つけ、JSON コンテンツを解析してサービスの詳細情報を判別できるようにアプリを構成してください。

<br />



## Kubernetes クラスター・リソースの視覚化
{: #weavescope}

Weave Scope は、Kubernetes クラスター内のリソース (サービス、ポッド、コンテナー、プロセス、ノードなど) のビジュアル図を表示します。 Weave Scope は CPU とメモリーのインタラクティブ・メトリックを示し、コンテナーの中で追尾したり実行したりするツールも備えています。
{:shortdesc}

開始前に、以下のことを行います。

-   クラスター情報を公共のインターネットに公開しないようにしてください。 安全に Weave Scope をデプロイして Web ブラウザーからローカル・アクセスするには、以下の手順を実行します。
-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_clusters.html#clusters_ui)。 Weave Scope は、アプリでは特に、CPU の負荷が大きくなります。 ライト・クラスターではなく、比較的大規模な標準クラスターで Weave Scope を実行してください。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。


Weave Scope をクラスターで使用するには、以下のようにします。
2.  提供された RBAC 許可構成ファイルをクラスターにデプロイします。

    読み取り/書き込みアクセス権を有効にするには、以下のようにします。

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    読み取り専用アクセス権を有効にするには、以下のようにします。

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    出力:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Weave Scope サービスをデプロイします。このサービスは、クラスター IP アドレスでのプライベート・アクセスが可能です。

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    出力:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  ポート転送コマンドを実行して、コンピューター上でサービスを開始します。 これで、クラスターでの Weave Scope の構成は完了です。次回 Weave Scope にアクセスするときは、以下のポート転送コマンドを実行するだけでよく、上記の構成ステップを再度実行する必要はありません。

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    出力:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Web ブラウザーで `http://localhost:4040` を開きます。 デフォルトのコンポーネントをデプロイしないと、次の図が表示されます。 クラスター内の Kubernetes リソースのトポロジー・ダイアグラムまたはテーブルを表示するように選択できます。

     <img src="images/weave_scope.png" alt="Weave Scope のトポロジーの例" style="width:357px;" />


[Weave Scope の機能についての詳細 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.weave.works/docs/scope/latest/features/)。

<br />

