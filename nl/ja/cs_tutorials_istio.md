---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# チュートリアル: {{site.data.keyword.containerlong_notm}} での Istio のインストール
{: #istio_tutorial}

[Istio ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/info/istio) は、{{site.data.keyword.containerlong}} での Kubernetes などのクラウド・プラットフォーム上のサービスを接続、保護、制御、および監視するためのオープン・プラットフォームです。 Istio を使用すると、ネットワーク・トラフィックの管理、マイクロサービス間のロード・バランシング、アクセス・ポリシーの実施、サービス ID の検証などを行うことができます。
{:shortdesc}

このチュートリアルでは、BookInfo と呼ばれる単純な演習用ブックストア・アプリ用に、Istio と一緒に 4 つのマイクロサービスをインストールする方法を確認できます。 このマイクロサービスには、製品 Web ページ、本の詳細情報、レビュー、評価が含まれます。 Istio をインストールする {{site.data.keyword.containerlong}} クラスターに BookInfo のマイクロサービスをデプロイする際には、各マイクロサービスのポッド内に Istio Envoy サイドカー・プロキシーを挿入します。

## 達成目標

-   Istio Helm チャートをクラスターにデプロイします
-   BookInfo サンプル・アプリをデプロイします
-   BookInfo アプリのデプロイメントを確認し、3 つのバージョンの評価サービス間でラウンドロビンします

## 所要時間

30 分

## 対象読者

このチュートリアルは、Istio を初めて使用するソフトウェア開発者やネットワーク管理者を対象にしています。

## 前提条件

-  [IBM Cloud CLI、{{site.data.keyword.containerlong_notm}} プラグイン、および Kubernetes CLI をインストールします](cs_cli_install.html#cs_cli_install_steps)。 必ず、ご使用のクラスターの Kubernetes バージョンに一致する `kubectl` CLI バージョンをインストールしてください。
-  [クラスターを作成します](cs_clusters.html#clusters_cli)。 
-  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

## レッスン 1: Istio をダウンロードしてインストールする
{: #istio_tutorial1}

クラスターに Istio をダウンロードしてインストールします。
{:shortdesc}

1. [IBM Istio Helm チャート ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm-charts/ibm-istio) を使用して、Istio をインストールします。
    1. [クラスターで Helm をセットアップし、Helm インスタンスに `ibm-charts` リポジトリーを追加します](cs_integrations.html#helm)。
    2.  **バージョン 2.9 以前の Helm の場合のみ**: Istio のカスタム・リソース定義をインストールします。
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. Helm チャートをクラスターにインストールします。
        ```
        helm install ibm-charts/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. 9 つの Istio サービス用のポッドと Prometheus 用のポッドが完全にデプロイされていることを確認してから、先に進みます。
    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

おつかれさまでした。 クラスターに Istio を正常にインストールしました。 次に、BookInfo サンプル・アプリをクラスター内にデプロイします。


## レッスン 2: BookInfo アプリをデプロイする
{: #istio_tutorial2}

BookInfo サンプル・アプリのマイクロサービスを Kubernetes クラスターにデプロイします。
{:shortdesc}

これらの 4 つのマイクロサービスには、製品 Web ページ、本の詳細情報、レビュー (レビューのマイクロサービスには複数のバージョンがあります)、評価が含まれます。 BookInfo をデプロイする際には、Envoy サイドカー・プロキシーがコンテナーとしてアプリのマイクロサービスのポッド内に挿入された後に、マイクロサービスのポッドがデプロイされます。 Istio は拡張バージョンの Envoy プロキシーを使用して、サービス・メッシュ内のすべてのマイクロサービスに関するすべてのインバウンド・トラフィックとアウトバウンド・トラフィックを仲介します。 Envoy について詳しくは、[Istio の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy) を参照してください。

1. 必要な BookInfo ファイルが含まれた Istio パッケージをダウンロードします。
    1. Istio を [https://github.com/istio/istio/releases ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/istio/istio/releases) から直接ダウンロードしてインストール・ファイルを抽出するか、以下のように cURL を使用して最新バージョンを取得します。
       ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. ディレクトリーを Istio ファイルの場所に切り替えます。
       ```
       cd <filepath>/istio-1.0
       ```
       {: pre}

    3. `istioctl` クライアントを PATH に追加します。 例えば、MacOS または Linux システムでは以下のコマンドを実行します。
        ```
        export PATH=$PWD/istio-1.0/bin:$PATH
        ```
        {: pre}

2. `default` 名前空間に `istio-injection=enabled` というラベルを付けます。
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. BookInfo アプリをデプロイします。 アプリのマイクロサービスをデプロイする際に、Envoy サイドカーも各マイクロサービス・ポッド内にデプロイされます。

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. マイクロサービスとその対応するポッドがデプロイされていることを確認します。
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
    kubectl get pods
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

5. アプリ・デプロイメントを確認するには、クラスターのパブリック・アドレスを取得します。
    * 標準クラスター:
        1. アプリをパブリック ingress IP で公開するには、BookInfo ゲートウェイをデプロイします。
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

        2. ingress ホストを設定します。
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        3. ingress ポートを設定します。
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        4. ingress のホストとポートを使用する `GATEWAY_URL` 環境変数を作成します。

           ```
           export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
           ```
           {: pre}

    * フリー・クラスター:
        1. クラスター内のいずれかのワーカー・ノードのパブリック IP アドレスを取得します。
            ```
            ibmcloud ks workers <cluster_name_or_ID>
            ```
            {: pre}

        2. そのワーカー・ノードのパブリック IP アドレスを使用する GATEWAY_URL 環境変数を作成します。
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. `GATEWAY_URL` 変数に対して curl を実行し、BookInfo アプリが稼働中であることを確認します。 応答 `200` は、Istio で BookInfo アプリが適切に稼働していることを意味します。
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  ブラウザーで BookInfo Web ページを表示します。

    Mac OS または Linux の場合は、以下のようにします。
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Windows の場合は、以下のようにします。
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

7. ページの最新表示を複数回試行します。 さまざまなバージョンのレビュー・セクションが、赤い星形、黒い星形、星形なしの間でラウンドロビンします。

おつかれさまでした。 BookInfo サンプル・アプリと Istio Envoy サイドカーを正常にデプロイしました。 次は、リソースをクリーンアップします。または、他のチュートリアルを引き続き試し、Istio についてさらに詳しく知ることもできます。

## クリーンアップ
{: #istio_tutorial_cleanup}

Istio での作業を終了し、[次の作業](#istio_tutorial_whatsnext)に進まない場合は、クラスター内の Istio リソースをクリーンアップできます。
{:shortdesc}

1. クラスター内の BookInfo サービス、ポッド、デプロイメントをすべて削除します。
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. Istio Helm デプロイメントをアンインストールします。
    ```
    helm del istio --purge
    ```
    {: pre}

3. Helm 2.9 以前を使用していた場合:
    1. 余分のジョブ・リソースを削除します。
      ```
      kubectl -n istio-system delete job --all
      ```
      {: pre}
    2. オプション: Istio のカスタム・リソース定義を削除します。
      ```
      kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
      ```
      {: pre}

## 次の作業
{: #istio_tutorial_whatsnext}

* {{site.data.keyword.containerlong_notm}} と Istio の両方でアプリを公開することを考えていますか? {{site.data.keyword.containerlong_notm}} Ingress ALB および Istio Gateway の接続方法について詳しくは、この [ブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2018/09/transitioning-your-service-mesh-from-ibm-cloud-kubernetes-service-ingress-to-istio-ingress/) を参照してください。
* Istio についてさらに詳しく知るには、[Istio の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://istio.io/) でその他のガイドを参照できます。
    * [Intelligent Routing ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://istio.io/docs/guides/intelligent-routing.html): この例では、Istio のトラフィック管理機能を使用して、特定のバージョンの BookInfo のレビューと評価のマイクロサービスにトラフィックをルーティングする方法を示しています。
    * [In-Depth Telemetry ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://istio.io/docs/guides/telemetry.html): この例では、Istio Mixer と Envoy プロキシーを使用して、BookInfo のマイクロサービス間で統一されたメトリック、ログ、トレースを取得する方法を示しています。
* [Cognitive Class: Getting started with Microservices with Istio and IBM Cloud Kubernetes Service ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/) を受講します。 **注**: このコースの Istio のインストールのセクションはスキップできます。
* [Vistio ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) の使用に関するこのブログ投稿を確認して、お客様の Istio サービス・メッシュを視覚化します。
