---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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
{: #cs_apps}

Kubernetes の技法を利用して、アプリをデプロイし、アプリの常時稼働を確保することができます。 例えば、ダウン時間なしでローリング更新とロールバックを実行できます。
{:shortdesc}

次のイメージの領域をクリックして、アプリをデプロイするための一般的な手順を確認してください。

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="CLI をインストールします。" title="CLI をインストールします。" shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="アプリの構成ファイルを作成します。Kubernetes のベスト・プラクティスを確認します。" title="アプリの構成ファイルを作成します。Kubernetes のベスト・プラクティスを確認します。" shape="rect" coords="254, 64, 486, 231" />
<area href="#cs_apps_cli" target="_blank" alt="オプション 1: Kubernetes CLI から構成ファイルを実行します。" title="オプション 1: Kubernetes CLI から構成ファイルを実行します。" shape="rect" coords="544, 67, 730, 124" />
<area href="#cs_cli_dashboard" target="_blank" alt="オプション 2: Kubernetes ダッシュボードをローカルで開始し、構成ファイルを実行します。" title="オプション 2: Kubernetes ダッシュボードをローカルで開始し、構成ファイルを実行します。" shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Kubernetes ダッシュボードの起動
{: #cs_cli_dashboard}

ローカル・システムで Kubernetes ダッシュボードを開くと、クラスターとそのすべてのワーカー・ノードに関する情報が表示されます。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。 このタスクには、[管理者アクセス・ポリシー](cs_cluster.html#access_ov)が必要です。 現在の[アクセス・ポリシー](cs_cluster.html#view_access)を確認してください。

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

    1.  資格情報をダウンロードします。

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: codeblock}

    2.  ダウンロードしたクラスター資格情報を表示します。 前のステップのエクスポートで指定したファイル・パスを使用します。

        macOS または Linux の場合は、以下のようにします。

        ```
        cat <filepath_to_cluster_credentials>
        ```
        {: codeblock}

        Windows の場合は、以下のようにします。

        ```
        type <filepath_to_cluster_credentials>
        ```
        {: codeblock}

    3.  **id-token** フィールドに示されているトークンをコピーします。

    4.  デフォルトのポート番号でプロキシーを設定します。

        ```
        kubectl proxy
        ```
        {: pre}

        CLI 出力は、以下のようになります。

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    6.  ダッシュボードにサインインします。

        1.  次の URL をブラウザーにコピーします。

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  サインオン・ページで、**トークン**認証方式を選択します。

        3.  次に、**id-token** 値を**「Token」**フィールドに貼り付けて、**「SIGN IN」**をクリックします。

[次に、ダッシュボードから構成ファイルを実行できます。](#cs_apps_ui)

Kubernetes ダッシュボードでの作業が完了したら、`CTRL+C` を使用して `proxy` コマンドを終了します。 終了した後は、Kubernetes ダッシュボードを使用できなくなります。 Kubernetes ダッシュボードを再始動するには、`proxy` コマンドを実行します。



<br />


## シークレットの作成
{: #secrets}

Kubernetes シークレットは、機密情報 (ユーザー名、パスワード、鍵など) を安全に保管するための手段です。


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



## アプリへのパブリック・アクセスを許可する方法
{: #cs_apps_public}

アプリをインターネットでだれでも利用できるようにするには、アプリをクラスターにデプロイする前に、構成ファイルを更新する必要があります。
{:shortdesc}

ライト・クラスターを作成したか標準クラスターを作成したかに応じて、インターネットからアプリにアクセスできるようにする方法は複数あります。

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">NodePort サービス</a> (ライト・クラスターと標準クラスター)</dt>
<dd>すべてのワーカー・ノードのパブリック・ポートを公開し、ワーカー・ノードのパブリック IP アドレスを使用して、クラスター内のサービスにパブリック・アクセスを行います。 ワーカー・ノードのパブリック IP アドレスは永続的なアドレスではありません。 ワーカー・ノードが削除されたり再作成されたりすると、新しいパブリック IP アドレスがワーカー・ノードに割り当てられます。 NodePort サービスは、アプリのパブリック・アクセスをテストする場合や、パブリック・アクセスが短期間だけ必要な場合に使用できます。 安定的なパブリック IP アドレスによってサービス・エンドポイントの可用性を高める必要がある場合は、LoadBalancer サービスまたは Ingress を使用してアプリを公開してください。</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">LoadBalancer サービス</a> (標準クラスターのみ)</dt>
<dd>どの標準クラスターにも 4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスがプロビジョンされます。そのアドレスを使用して、アプリ用の外部 TCP/ UDP ロード・バランサーを作成できます。 アプリで必要なすべてのポートを公開することによってロード・バランサーをカスタマイズすることも可能です。 ロード・バランサーに割り当てられるポータブル・パブリック IP アドレスは永続的なアドレスであり、クラスター内のワーカー・ノードが再作成されても変更されません。

</br>
アプリで HTTP または HTTPS のロード・バランシングが必要な状況で、1 つのパブリック・ルートを使用してクラスター内の複数のアプリをサービスとして公開する場合は、{{site.data.keyword.containershort_notm}} に組み込まれている Ingress サポートを使用してください。</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a> (標準クラスターのみ)</dt>
<dd>HTTP または HTTPS のいずれかで使用できる外部ロード・バランサーを 1 つ作成することによって、クラスターに複数のアプリを公開できます。このロード・バランサーを使用して、保護された固有のパブリック・エントリー・ポイントから着信要求を各アプリにルーティングします。 Ingress は、Ingress リソースおよび Ingress コントローラーという 2 つの主要なコンポーネントで構成されています。 Ingress リソースでは、アプリに対する着信要求のルーティングとロード・バランシングの方法に関するルールを定義します。 Ingress リソースはすべて Ingress コントローラーに登録する必要があります。Ingress コントローラーは、着信する HTTP または HTTPS のいずれかのサービス要求を listen し、Ingress リソースごとに定義されたルールに基づいて要求を転送します。 カスタム・ルーティング・ルールを使用して独自のロード・バランサーを実装する場合、およびアプリに SSL 終端が必要な場合は、Ingress を使用してください。

</dd></dl>

### NodePort タイプのサービスを使用してアプリへのパブリック・アクセスを構成する方法
{: #cs_apps_public_nodeport}

クラスター内のいずれかのワーカー・ノードのパブリック IP アドレスを使用し、ノード・ポートを公開することによって、アプリをインターネットで利用できるようにします。 このオプションは、テストの場合や短期間のパブリック・アクセスを許可する場合に使用してください。

{:shortdesc}

ライト・クラスターでも標準クラスターでも、アプリは Kubernetes NodePort サービスとして公開できます。

{{site.data.keyword.Bluemix_dedicated_notm}} 環境の場合、パブリック IP アドレスはファイアウォールでブロックされます。 アプリをだれでも利用できるようにするには、[LoadBalancer サービス](#cs_apps_public_load_balancer)または [Ingress](#cs_apps_public_ingress) を代わりに使用してください。

**注:** ワーカー・ノードのパブリック IP アドレスは永続的なアドレスではありません。 ワーカー・ノードを再作成しなければならない場合は、新しいパブリック IP アドレスがワーカー・ノードに割り当てられます。 安定的なパブリック IP アドレスによってサービスの可用性を高める必要がある場合は、[LoadBalancer サービス](#cs_apps_public_load_balancer)または [Ingress](#cs_apps_public_ingress) を使用してアプリを公開してください。




1.  構成ファイル内の [service ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/) セクションを定義します。
2.  サービスの `spec` セクションで NodePort タイプを追加します。

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  オプション: `ports` セクションで 30000 から 32767 の範囲の NodePort を追加します。 別のサービスで既に使用されている NodePort は指定しないでください。 使用中の NodePort が不明な場合は、割り当てないでください。 NodePort を割り当てなければ、ランダムに割り当てられます。

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    NodePort を指定する時に使用中の NodePort を確認する場合は、以下のコマンドを実行できます。

    ```
    kubectl get svc
    ```
    {: pre}

    出力:

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  変更を保存します。
5.  この手順を繰り返して、すべてのアプリのサービスを作成します。

    例:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**次の作業:**

アプリをデプロイする時に、いずれかのワーカー・ノードのパブリック IP アドレスと NodePort を使用して、ブラウザーでそのアプリにアクセスするためのパブリック URL を作成できます。

1.  クラスター内のワーカー・ノードのパブリック IP アドレスを取得します。

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    出力:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
    ```
    {: screen}

2.  ランダムな NodePort が割り当てられた場合は、その値を確認します。

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    出力:

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    この例では、NodePort は `30872` です。

3.  ワーカー・ノードのパブリック IP アドレスの 1 つと NodePort を使用して URL を作成します。 例: `http://192.0.2.23:30872`

### ロード・バランサー・タイプのサービスを使用してアプリへのアクセスを構成する方法
{: #cs_apps_public_load_balancer}

ポートを公開し、ロード・バランサーのポータブル IP アドレスを使用してアプリにアクセスします。 パブリック IP アドレスを使用してアプリをインターネットでアクセスできるようにするか、プライベート IP アドレスを使用して、アプリをプライベート・インフラストラクチャー・ネットワークでアクセスできるようにします。

NodePort サービスの場合とは異なり、ロード・バランサー・サービスのポータブル IP アドレスは、アプリのデプロイ先のワーカー・ノードに依存していません。 ただし、Kubernetes LoadBalancer サービスは NodePort サービスでもあります。 LoadBalancer サービスにより、ロード・バランサーの IP アドレスとポート上でアプリが利用可能になり、サービスのノード・ポート上でアプリが利用可能になります。

ロード・バランサーのポータブル・パブリック IP アドレスは自動的に割り当てられ、ワーカー・ノードを追加または削除しても変わりません。 そのため、NodePort サービスよりロード・バランサー・サービスのほうが可用性が高くなります。 ユーザーは、ロード・バランサーのポートとしてどのポートでも選択できます。NodePort の場合のポート範囲には限定されません。 ロード・バランサー・サービスは、TCP プロトコルと UDP プロトコルの場合に使用できます。

{{site.data.keyword.Bluemix_dedicated_notm}} アカウントが[クラスターで有効になっている](cs_ov.html#setup_dedicated)場合、ロード・バランサー IP アドレスに使用するパブリック・サブネットを要求できます。 [サポート・チケットを開いて](/docs/support/index.html#contacting-support)サブネットを作成してから、[`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) コマンドを使用してサブネットをクラスターに追加します。

**注:** ロード・バランサー・サービスは TLS 終端をサポートしていません。 アプリで TLS 終端が必要な場合は、[Ingress](#cs_apps_public_ingress) を使用してアプリを公開するか、または TLS 終端を管理するようにアプリを構成することができます。

開始前に、以下のことを行います。

-   このフィーチャーを使用できるのは、標準クラスターの場合に限られます。
-   ロード・バランサー・サービスに割り当てることのできるポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスが必要です。
-   ポータブル・プライベート IP アドレスを使用するロード・バランサー・サービスでは、すべてのワーカー・ノードでパブリック・ノード・ポートも開いています。 パブリック・トラフィックを回避するためのネットワーク・ポリシーを追加する方法については、[着信トラフィックのブロック](cs_security.html#cs_block_ingress)を参照してください。

ロード・バランサー・サービスを作成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](#cs_apps_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドをロード・バランシングに含めるためにそれらのポッドを識別する上で必要です。
2.  公開するアプリのロード・バランサー・サービスを作成します。 アプリを公共のインターネットまたはプライベート・ネットワーク上で利用可能にするには、アプリの Kubernetes サービスを作成します。 アプリを構成しているすべてのポッドをロード・バランシングに含めるようにサービスを構成します。
    1.  `myloadbalancer.yaml` などの名前のサービス構成ファイルを作成します。
    2.  公開するアプリのロード・バランサー・サービスを定義します。
        - クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。
        - クラスターがプライベート VLAN 上でのみ使用可能な場合は、ポータブル・プライベート IP アドレスが使用されます。
        - 構成ファイルにアノテーションを追加することにより、LoadBalancer サービス用にポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスを要求できます。

        デフォルトの IP アドレスを使用する LoadBalancer サービスの場合は次のようにします。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        アノテーションを使用してプライベート IP アドレスまたはパブリックの IP アドレスを指定する LoadBalancer サービスの場合は次のようにします。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations: 
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private> 
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td><em>&lt;myservice&gt;</em> をロード・バランサー・サービスの名前に置き換えます。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。 例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。 アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。 </td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>サービスが listen するポート。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>LoadBalancer のタイプを指定するアノテーション。 値は `private` と `public` です。 パブリック VLAN 上のクラスターにパブリック LoadBalancer を作成するときには、このアノテーションは必要ありません。</td>
        </tbody></table>
    3.  オプション: クラスターで使用可能な特定のポータブル IP アドレスをロード・バランサーに使用する場合は、spec セクションに `loadBalancerIP` を含めることによって、その IP アドレスを指定できます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/) を参照してください。
    4.  オプション: spec セクションに `loadBalancerSourceRanges` を指定してファイアウォールを構成します。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。
    5.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        ロード・バランサー・サービスが作成される際に、ロード・バランサーにポータブル IP アドレスが自動的に割り当てられます。 使用可能なポータブル IP アドレスがなければ、ロード・バランサー・サービスは作成できません。
3.  ロード・バランサー・サービスが正常に作成されたことを確認します。 _&lt;myservice&gt;_ を、前のステップで作成したロード・バランサー・サービスの名前に置き換えます。

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **注:** ロード・バランサー・サービスが適切に作成され、アプリが利用可能になるまでに数分かかることがあります。

    CLI 出力例:

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP アドレスは、ロード・バランサー・サービスに割り当てられたポータブル・パブリック IP アドレスです。
4.  パブリック・ロード・バランサーを作成した場合、インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  ロード・バランサーのポータブル・パブリック IP アドレスとポートを入力します。 上記の例では、ポータブル・パブリック IP アドレス `192.168.10.38` が、ロード・バランサー・サービスに割り当てられていました。

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}




### Ingress コントローラーを使用してアプリへのアクセスを構成する方法
{: #cs_apps_public_ingress}

IBM 提供の Ingress コントローラーにより管理される Ingress リソースを作成することによって、クラスター内の複数のアプリを公します。 Ingress コントローラーは、HTTP または HTTPS のいずれかの外部ロード・バランサーです。このロード・バランサーは、保護された固有のパブリック・エントリー・ポイントまたはプライベート・エントリー・ポイントを使用して、着信要求をクラスター内外のアプリにルーティングします。

**注:** Ingress は標準クラスター専用であり、高可用性を確保して定期的更新を適用するためにはクラスター内に 2 つ以上のワーカー・ノードを必要とします。 Ingress のセットアップには、[管理者アクセス・ポリシー](cs_cluster.html#access_ov)が必要です。 現在の[アクセス・ポリシー](cs_cluster.html#view_access)を確認してください。

標準クラスターを作成すると、ポータブル・パブリック IP アドレスとパブリック経路が割り当てられた Ingress コントローラーが自動的に作成されて有効になります。 ポータブル・プライベート IP アドレスとプライベート経路が割り当てられた Ingress コントローラーも自動的に作成されますが、自動的に有効になるわけではありません。 これらの Ingress コントローラーを構成し、パブリック・ネットワークまたはプライベート・ネットワークに公開するアプリごとに個々のルーティング・ルールを定義することができます。 Ingress によってパブリックに公開される各アプリに対して、パブリック経路に付加される固有のパスが割り当てられるので、固有の URL を使用して、クラスター内のアプリにパブリックにアクセスできるようになります。

{{site.data.keyword.Bluemix_dedicated_notm}} アカウントが[クラスターで有効になっている](cs_ov.html#setup_dedicated)場合、Ingress コントローラー IP アドレスに使用するパブリック・サブネットを要求できます。 それから、Ingress コントローラーを作成してパブリック経路を割り当てます。 [サポート・チケットを開いて](/docs/support/index.html#contacting-support)サブネットを作成してから、[`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) コマンドを使用してサブネットをクラスターに追加します。

パブリックにアプリを公開するために、以下のシナリオに応じてパブリック Ingress コントローラーを構成できます。

-   [TLS 終端なしで IBM 提供ドメインを使用する](#ibm_domain)
-   [TLS 終端ありで IBM 提供ドメインを使用する](#ibm_domain_cert)
-   [TLS 終端を実行するためにカスタム・ドメインと TLS 証明書を使用する](#custom_domain_cert)
-   [クラスターの外部のアプリにアクセスするために、TLS 終端ありで IBM 提供ドメインまたはカスタム・ドメインを使用する](#external_endpoint)
-   [Ingress ロード・バランサーでポートを開く](#opening_ingress_ports)
-   [HTTP レベルで SSL プロトコルと SSL 暗号を構成する](#ssl_protocols_ciphers)
-   [アノテーションを使用して Ingress コントローラーをカスタマイズする](cs_annotations.html)
{: #ingress_annotation}

プライベート・ネットワークにアプリを公開するには、まず[プライベート Ingress コントローラーを有効にします](#private_ingress)。 その後、以下のシナリオに応じてプライベート Ingress コントローラーを構成できます。

-   [TLS 終端なしでカスタム・ドメインを使用する](#private_ingress_no_tls)
-   [TLS 終端を実行するためにカスタム・ドメインと TLS 証明書を使用する](#private_ingress_tls)

#### TLS 終端なしで IBM 提供ドメインを使用する
{: #ibm_domain}

クラスター内のアプリ用の HTTP ロード・バランサーとして Ingress コントローラーを構成し、IBM 提供ドメインを使用してインターネットからアプリにアクセスします。

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。

Ingress コントローラーを構成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](#cs_apps_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。
2.  公開するアプリ用に、Kubernetes サービスを作成します。 Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。
    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  公開するアプリのサービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em> をロード・バランサー・サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。 例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。 アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。 </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tr>
         </tbody></table>
    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  公開するアプリごとに、上記のステップを繰り返します。
3.  クラスターの詳細を取得して、IBM 提供ドメインを表示します。 _&lt;mycluster&gt;_ を、公開する対象のアプリがデプロイされているクラスターの名前に置き換えます。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 出力は、以下のようになります。

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    IBM 提供ドメインは、**「Ingress サブドメイン (Ingress subdomain)」**フィールドに示されます。
4.  Ingress リソースを作成します。 Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。 すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。
    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成ファイルを作成します。
    2.  IBM 提供ドメインを使用して着信ネットワーク・トラフィックを作成済みのサービスにルーティングするように、Ingress リソースを構成ファイル内に定義します。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>ホスト </code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに * を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myservicepath1&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

        </br>
        Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

        </br></br>
        多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。
        </br>
        例: <ul><li><code>http://ingress_host_name/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://ingress_host_name/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        </br>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用してアプリへの適切なルーティングを設定します。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  クラスターの Ingress リソースを作成します。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Ingress リソースが正常に作成されたことを確認します。 _&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **注:** Ingress リソースが作成され、公共のインターネット上でアプリが使用可能になるまでに数分かかることがあります。
6.  Web ブラウザーに、アクセスするアプリ・サービスの URL を入力します。

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### TLS 終端ありで IBM 提供ドメインを使用する
{: #ibm_domain_cert}

アプリのために着信 TLS 接続を管理し、IBM 提供の TLS 証明書を使用してネットワーク・トラフィックを暗号化解除し、暗号化されていない要求をクラスター内の公開されたアプリに向けて転送するように、Ingress コントローラーを構成することができます。

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。

Ingress コントローラーを構成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](#cs_apps_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルにより、アプリが実行されるすべてのポッドが識別され、それらのポッドが Ingress ロード・バランシングに含められます。
2.  公開するアプリ用に、Kubernetes サービスを作成します。 Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。
    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  公開するアプリのサービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em> を Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。 例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。 アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。 </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tr>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  公開するアプリごとに、上記のステップを繰り返します。

3.  IBM 提供ドメインと TLS 証明書を表示します。 _&lt;mycluster&gt;_ を、アプリがデプロイされているクラスターの名前に置き換えます。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 出力は、以下のようになります。

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    IBM 提供ドメインが**「Ingress サブドメイン (Ingress subdomain)」**フィールドに示され、IBM 提供の証明書が**「Ingress シークレット (Ingress secret)」**フィールドに示されます。

4.  Ingress リソースを作成します。 Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。 すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。
    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成ファイルを作成します。
    2.  IBM 提供ドメインを使用して着信ネットワーク・トラフィックを対象サービスにルーティングし、IBM 提供の証明書を使用して TLS 終端を管理するように、Ingress リソースを構成ファイル内に定義します。 サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://ingress_domain/myapp`) を作成することができます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、さらに、アプリが実行されているポッドに送信します。

        **注:** Ingress リソースに定義されたパスでアプリが listen していなければなりません。 そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。 大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを `/` として定義します。アプリ用の個別のパスは指定しないでください。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。 このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;ibmtlssecret&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress シークレット (Ingress secret)」</strong>の名前に置き換えます。 この証明書で TLS 終端を管理します。
        </tr>
        <tr>
        <td><code>ホスト </code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。 このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myservicepath1&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

        </br>
        Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

        </br>
        多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br>
        例: <ul><li><code>http://ingress_host_name/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://ingress_host_name/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用してアプリへの適切なルーティングを設定します。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  クラスターの Ingress リソースを作成します。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Ingress リソースが正常に作成されたことを確認します。 _&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注:** Ingress リソースが適切に作成され、公共のインターネット上でアプリが使用可能になるまでに数分かかることがあります。
6.  Web ブラウザーに、アクセスするアプリ・サービスの URL を入力します。

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### カスタム・ドメインと TLS 証明書とともに Ingress コントローラーを使用する
{: #custom_domain_cert}

IBM 提供ドメインではなくカスタム・ドメインを使用する場合でも、着信ネットワーク・トラフィックをクラスター内のアプリに転送し、独自の TLS 証明書を使用して TLS 終端を管理するように、Ingress コントローラーを構成することができます。
{:shortdesc}

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。

Ingress コントローラーを構成するには、以下のようにします。

1.  カスタム・ドメインを作成します。 カスタム・ドメインを作成するには、ドメイン・ネーム・サービス (DNS) プロバイダーを使用してカスタム・ドメインを登録します。
2.  着信ネットワーク・トラフィックを IBM Ingress コントローラーにルーティングするようにドメインを構成します。 以下の選択肢があります。
    -   IBM 提供ドメインを正規名レコード (CNAME) として指定することで、カスタム・ドメインの別名を定義します。 IBM 提供の Ingress ドメインを確認するには、`bx cs cluster-get <mycluster>` を実行し、**「Ingress サブドメイン (Ingress subdomain)」**フィールドを見つけます。
    -   カスタム・ドメインを IBM 提供の Ingress コントローラーのポータブル・パブリック IP アドレスにマップします。これは、IP アドレスをレコードとして追加して行います。 Ingress コントローラーのポータブル・パブリック IP アドレスを確認するには、次のようにします。
        1.  `bx cs cluster-get <mycluster>` を実行し、**「Ingress サブドメイン (Ingress subdomain)」**フィールドを見つけます。
        2.  `nslookup <Ingress subdomain>` を実行します。
3.  PEM 形式でエンコードされた TLS 証明書と鍵を、当該ドメインのために作成します。
4.  この TLS 証明書と鍵を Kubernetes シークレットに保管します。
    1.  任意のエディターを開き、`mysecret.yaml` などの名前の Kubernetes シークレット構成ファイルを作成します。
    2.  TLS 証明書と鍵を使用するシークレットを定義します。

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;mytlssecret&gt;</em> を Kubernetes シークレットの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td><em>&lt;tlscert&gt;</em> を、base64 形式でエンコードされたカスタム TLS 証明書に置き換えます。</td>
         </tr>
         <td><code>tls.key</code></td>
         <td><em>&lt;tlskey&gt;</em> を、base64 形式でエンコードされたカスタム TLS 鍵に置き換えます。</td>
         </tbody></table>

    3.  構成ファイルを保存します。
    4.  クラスターの TLS シークレットを作成します。

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [アプリをクラスターにデプロイします](#cs_apps_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

6.  公開するアプリ用に、Kubernetes サービスを作成します。 Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。

    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  公開するアプリのサービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice1&gt;</em> を Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。 例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。 アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。 </td>
         </tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  公開するアプリごとに、上記のステップを繰り返します。
7.  Ingress リソースを作成します。 Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。 すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。
    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成ファイルを作成します。
    2.  カスタム・ドメインを使用して着信ネットワーク・トラフィックを対象サービスにルーティングし、カスタム証明書を使用して TLS 終端を管理するように、Ingress リソースを構成ファイル内に定義します。 サービスごとに、カスタム・ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://mydomain/myapp`) を作成することができます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、さらに、アプリが実行されているポッドに送信します。

        **注:** Ingress リソースに定義されたパスでアプリが listen していることが重要です。 そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。 大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを `/` として定義します。アプリ用の個別のパスは指定しないでください。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;mycustomdomain&gt;</em> を、TLS 終端のために構成するカスタム・ドメインに置き換えます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;mytlssecret&gt;</em> を、先ほど作成したシークレットの名前に置き換えます。このシークレット内に、カスタム・ドメインの TLS 終端を管理するための TLS 証明書と鍵を保持します。
        </tr>
        <tr>
        <td><code>ホスト </code></td>
        <td><em>&lt;mycustomdomain&gt;</em> を、TLS 終端のために構成するカスタム・ドメインに置き換えます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myservicepath1&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

        </br>
        Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

        </br>
        多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br></br>
        例: <ul><li><code>https://mycustomdomain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>https://mycustomdomain/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用してアプリへの適切なルーティングを設定します。
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Ingress リソースを作成します。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Ingress リソースが正常に作成されたことを確認します。 _&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注:** Ingress リソースが適切に作成され、公共のインターネット上でアプリが使用可能になるまでに数分かかることがあります。

9.  インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  アクセスするアプリ・サービスの URL を入力します。

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### クラスターの外部のアプリにネットワーク・トラフィックをルーティングするように Ingress コントローラーを構成する
{: #external_endpoint}

クラスターの外部に配置されたアプリをクラスター・ロード・バランシングに含めるように、Ingress コントローラーを構成することができます。 IBM 提供ドメインまたはカスタム・ドメインでの着信要求は、自動的に外部アプリに転送されます。

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。
-   クラスター・ロード・バランシングに含めようとしている外部アプリに、パブリック IP アドレスを使用してアクセスできることを確認します。

IBM 提供ドメインへの着信ネットワーク・トラフィックを、クラスターの外部に配置されたアプリに転送するように Ingress コントローラーを構成することができます。 代わりにカスタム・ドメインと TLS 証明書を使用する場合は、IBM 提供ドメインと TLS 証明書を[カスタムのドメインと TLS 証明書](#custom_domain_cert)に置き換えてください。

1.  クラスター・ロード・バランシングに含める外部のアプリの場所を定義する、Kubernetes エンドポイントを構成します。
    1.  任意のエディターを開き、`myexternalendpoint.yaml` などの名前のエンドポイント構成ファイルを作成します。
    2.  外部エンドポイントを定義します。 外部アプリにアクセスするために使用可能な、すべてのパブリック IP アドレスとポートを含めます。

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myendpointname&gt;</em> を Kubernetes エンドポイントの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td><em>&lt;externalIP&gt;</em> を、外部アプリに接続するためのパブリック IP アドレスに置き換えます。</td>
         </tr>
         <td><code>port</code></td>
         <td><em>&lt;externalport&gt;</em> を、外部アプリが listen するポートに置き換えます。</td>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Kubernetes エンドポイントを作成します。

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  クラスターのために Kubernetes サービスを作成します。そして、作成済みの外部エンドポイントに着信要求を転送するようにそのサービスを構成します。
    1.  任意のエディターを開き、`myexternalservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  サービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td><em>&lt;myexternalservice&gt;</em> を Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td><em>&lt;myendpointname&gt;</em> を、先ほど作成した Kubernetes エンドポイントの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>サービスが listen するポート。</td>
        </tr></tbody></table>

    3.  変更を保存します。
    4.  クラスターの Kubernetes サービスを作成します。

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}

3.  IBM 提供ドメインと TLS 証明書を表示します。 _&lt;mycluster&gt;_ を、アプリがデプロイされているクラスターの名前に置き換えます。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 出力は、以下のようになります。

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    IBM 提供ドメインが**「Ingress サブドメイン (Ingress subdomain)」**フィールドに示され、IBM 提供の証明書が**「Ingress シークレット (Ingress secret)」**フィールドに示されます。

4.  Ingress リソースを作成します。 Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。 すべてのアプリがクラスター内の Kubernetes サービスによってアプリの外部エンドポイントとともに公開されていれば、1 つの Ingress リソースを使用して複数の外部アプリのルーティング・ルールを定義できます。
    1.  任意のエディターを開き、`myexternalingress.yaml` などの名前の Ingress 構成ファイルを作成します。
    2.  IBM 提供ドメインと TLS 証明書を使用し、定義済みの外部エンドポイントを使用して着信ネットワーク・トラフィックを外部アプリにルーティングするように、Ingress リソースを構成ファイル内に定義します。 サービスごとに、カスタム・ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://ingress_domain/myapp`) を作成することができます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに、さらに外部アプリに送信します。

        **注:** Ingress リソースに定義されたパスでアプリが listen していることが重要です。 そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。 大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを / として定義します。アプリ用の個別のパスは指定しないでください。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。 このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;ibmtlssecret&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress シークレット (Ingress secret)」</strong>に置き換えます。 この証明書で TLS 終端を管理します。</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。 このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myexternalservicepath&gt;</em> をスラッシュか、外部アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

        </br>
        Kubernetes サービスごとに、ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、<code>https://ibmdomain/myservicepath1</code>) を作成することができます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックを外部アプリに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

        </br></br>
        多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br></br>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用してアプリへの適切なルーティングを設定します。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myexternalservice&gt;</em> を、外部アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。</td>
        </tr>
        </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Ingress リソースを作成します。

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}

5.  Ingress リソースが正常に作成されたことを確認します。 _&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注:** Ingress リソースが適切に作成され、公共のインターネット上でアプリが使用可能になるまでに数分かかることがあります。

6.  外部アプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  外部アプリにアクセスするための URL を入力します。

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}



#### Ingress ロード・バランサーでポートを開く
{: #opening_ingress_ports}

デフォルトでは、Ingress ロード・バランサーで公開されるのはポート 80 とポート 443 のみです。 他のポートを公開するときには、ibm-cloud-provider-ingress-cm 構成マップ・リソースを編集できます。

1.  ibm-cloud-provider-ingress-cm 構成マップ・リソースに対応するローカル・バージョンの構成ファイルを作成します。 <code>data</code> セクションを追加し、パブリック・ポート 80、443 と、構成マップ・ファイルに追加する他のポートを、セミコロン (;) で区切って指定します。

 注: ポートを指定する際、それらのポートを開いたままにしておくためには 80 と 443 も含める必要があります。 指定しないポートは閉じられます。

 ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

 例:
 ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```

2. 構成ファイルを適用します。

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. 構成ファイルが適用されたことを検査します。

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 出力:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

構成マップ・リソースについて詳しくは、[Kubernetes の資料](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/)を参照してください。



#### HTTP レベルで SSL プロトコルと SSL 暗号を構成する
{: #ssl_protocols_ciphers}

`ibm-cloud-provider-ingress-cm` 構成マップを編集して、グローバル HTTP レベルで SSL プロトコルと暗号を有効にします。

デフォルトでは、ssl-protocols と ssl-ciphers に次の値が使用されます。

```
ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
```
{: codeblock}

これらのパラメーターについて詳しくは、NGINX の資料で、[ssl-protocols ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols)、および [ssl-ciphers ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers) を参照してください。

デフォルト値を変更するには、以下のようにします。
1. ibm-cloud-provider-ingress-cm 構成マップ・リソースに対応するローカル・バージョンの構成ファイルを作成します。

 ```
 apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

2. 構成ファイルを適用します。

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. 構成ファイルが適用されていることを検査します。

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 出力:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
 ```
 {: screen}


#### プライベート Ingress コントローラーを有効にする
{: #private_ingress}

標準クラスターを作成すると、プライベート Ingress コントローラーが自動的に作成されますが、自動的に有効になるわけではありません。 これを使用するには、IBM 提供の事前割り当てポータブル・プライベート IP アドレスを使用するか、独自のポータブル・プライベート IP アドレスを使用して、プライベート Ingress コントローラーを有効にしておく必要があります。 **注**: クラスターを作成したときに `--no-subnet` フラグを使用した場合、プライベート Ingress コントローラーを有効にするには、その前にポータブル・プライベート・サブネットまたはユーザー管理サブネットを追加する必要があります。 詳しくは、[クラスターのその他のサブネットの要求](cs_cluster.html#add_subnet)を参照してください。

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

IBM 提供の事前割り当てポータブル・プライベート IP アドレスを使用してプライベート Ingress コントローラーを有効にするには、以下のようにします。

1. クラスター内で使用可能な Ingress コントローラーをリスト表示して、プライベート Ingress コントローラーの ALB ID を取得します。 <em>&lt;cluser_name&gt;</em> を、公開するアプリがデプロイされているクラスターの名前に置き換えます。

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    プライベート Ingress コントローラーの**「Status」**フィールドは_「disabled」_になっています。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. プライベート Ingress コントローラーを有効にします。 <em>&lt;private_ALB_ID&gt;</em> を、前のステップの出力にあるプライベート Ingress コントローラーの ALB ID に置き換えます。

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


独自のポータブル・プライベート IP アドレスを使用してプライベート Ingress コントローラーを有効にするには、以下のようにします。

1. ご使用のクラスターのプライベート VLAN 上でトラフィックをルーティングするように、選択した IP アドレスのユーザー管理サブネットを構成します。 <em>&lt;cluser_name&gt;</em> を、公開するアプリがデプロイされているクラスターの名前または ID に置き換えます。<em>&lt;subnet_CIDR&gt;</em> をユーザー管理サブネットの CIDR に置き換え、<em>&lt;private_VLAN&gt;</em> を使用可能プライベート VLAN ID に置き換えます。 使用可能なプライベート VLAN の ID は、`bx cs vlans` を実行することによって見つけることができます。

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. クラスター内で使用可能な Ingress コントローラーをリスト表示して、プライベート Ingress コントローラーの ALB ID を取得します。

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    プライベート Ingress コントローラーの**「Status」**フィールドは_「disabled」_になっています。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. プライベート Ingress コントローラーを有効にします。 <em>&lt;private_ALB_ID&gt;</em> を、前のステップの出力にあるプライベート Ingress コントローラーの ALB ID に置き換えます。<em>&lt;user_ip&gt;</em> を、使用するユーザー管理サブネットからの IP アドレスに置き換えます。

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

#### カスタム・ドメインとともにプライベート Ingress コントローラーを使用する
{: #private_ingress_no_tls}

カスタム・ドメインを使用して着信ネットワーク・トラフィックをクラスター内のアプリにルーティングするように、プライベート Ingress コントローラーを構成できます。
{:shortdesc}

始めに、[プライベート Ingress コントローラーを有効にします](#private_ingress)。

プライベート Ingress コントローラーを構成するには、以下のようにします。

1.  カスタム・ドメインを作成します。 カスタム・ドメインを作成するには、ドメイン・ネーム・サービス (DNS) プロバイダーを使用してカスタム・ドメインを登録します。

2.  カスタム・ドメインを IBM 提供のプライベート Ingress コントローラーのポータブル・プライベート IP アドレスにマップします。これは、IP アドレスをレコードとして追加して行います。 プライベート Ingress コントローラーのポータブル・プライベート IP アドレスを見つけるには、`bx cs albs --cluster<cluster_name>` を実行します。

3.  [アプリをクラスターにデプロイします](#cs_apps_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

4.  公開するアプリ用に、Kubernetes サービスを作成します。 プライベート Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。

    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  公開するアプリのサービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice1&gt;</em> を Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。 例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。 アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。 </td>
         </tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  プライベート・ネットワークに公開するアプリごとに、これらのステップを繰り返します。
7.  Ingress リソースを作成します。 Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。 すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。
    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成ファイルを作成します。
    2.  カスタム・ドメインを使用して着信ネットワーク・トラフィックをサービスにルーティングする Ingress リソースを構成ファイルで定義します。 サービスごとに、カスタム・ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://mydomain/myapp`) を作成することができます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、さらに、アプリが実行されているポッドに送信します。

        **注:** Ingress リソースに定義されたパスでアプリが listen していることが重要です。 そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。 大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを `/` として定義します。アプリ用の個別のパスは指定しないでください。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td><em>&lt;private_ALB_ID&gt;</em> を、プライベート Ingress コントローラーの ALB ID に置き換えます。 ALB ID を見つけるには、<code>bx cs albs --cluster <my_cluster></code> を実行します。</td>
        </tr>
        <td><code>ホスト </code></td>
        <td><em>&lt;mycustomdomain&gt;</em> をカスタム・ドメインに置き換えます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myservicepath1&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

        </br>
        Kubernetes サービスごとに、カスタム・ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>custom_domain/myservicepath1</code>) を作成できます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

        </br>
        多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br></br>
        例: <ul><li><code>https://mycustomdomain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>https://mycustomdomain/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用してアプリへの適切なルーティングを設定します。
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Ingress リソースを作成します。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Ingress リソースが正常に作成されたことを確認します。 <em>&lt;myingressname&gt;</em> を、前のステップで作成した Ingress リソースの名前に置き換えます。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注:** Ingress リソースが適切に作成され、アプリが使用可能になるまでに数秒かかることがあります。

9.  インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  アクセスするアプリ・サービスの URL を入力します。

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

#### カスタム・ドメインと TLS 証明書とともにプライベート Ingress コントローラーを使用する
{: #private_ingress_tls}

カスタム・ドメインを使用して、着信ネットワーク・トラフィックをクラスター内のアプリにルーティングし、独自の TLS 証明書を使用して TLS 終端を管理するように、プライベート Ingress コントローラーを構成できます。
{:shortdesc}

始めに、[プライベート Ingress コントローラーを有効にします](#private_ingress)。

Ingress コントローラーを構成するには、以下のようにします。

1.  カスタム・ドメインを作成します。 カスタム・ドメインを作成するには、ドメイン・ネーム・サービス (DNS) プロバイダーを使用してカスタム・ドメインを登録します。

2.  カスタム・ドメインを IBM 提供のプライベート Ingress コントローラーのポータブル・プライベート IP アドレスにマップします。これは、IP アドレスをレコードとして追加して行います。 プライベート Ingress コントローラーのポータブル・プライベート IP アドレスを見つけるには、`bx cs albs --cluster<cluster_name>` を実行します。

3.  PEM 形式でエンコードされた TLS 証明書と鍵を、当該ドメインのために作成します。

4.  この TLS 証明書と鍵を Kubernetes シークレットに保管します。
    1.  任意のエディターを開き、`mysecret.yaml` などの名前の Kubernetes シークレット構成ファイルを作成します。
    2.  TLS 証明書と鍵を使用するシークレットを定義します。

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;mytlssecret&gt;</em> を Kubernetes シークレットの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td><em>&lt;tlscert&gt;</em> を、base64 形式でエンコードされたカスタム TLS 証明書に置き換えます。</td>
         </tr>
         <td><code>tls.key</code></td>
         <td><em>&lt;tlskey&gt;</em> を、base64 形式でエンコードされたカスタム TLS 鍵に置き換えます。</td>
         </tbody></table>

    3.  構成ファイルを保存します。
    4.  クラスターの TLS シークレットを作成します。

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [アプリをクラスターにデプロイします](#cs_apps_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

6.  公開するアプリ用に、Kubernetes サービスを作成します。 プライベート Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。

    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成ファイルを作成します。
    2.  公開するアプリのサービスを定義します。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice1&gt;</em> を Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。 例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。 アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。 </td>
         </tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  プライベート・ネットワークで公開するアプリごとに、これらのステップを繰り返します。
7.  Ingress リソースを作成します。 Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。 すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。
    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成ファイルを作成します。
    2.  カスタム・ドメインを使用して着信ネットワーク・トラフィックを対象サービスにルーティングし、カスタム証明書を使用して TLS 終端を管理するように、Ingress リソースを構成ファイル内に定義します。 サービスごとに、カスタム・ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://mydomain/myapp`) を作成することができます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、さらに、アプリが実行されているポッドに送信します。

        **注:** Ingress リソースに定義されたパスでアプリが listen していることが重要です。 そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。 大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを `/` として定義します。アプリ用の個別のパスは指定しないでください。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td><em>&lt;private_ALB_ID&gt;</em> を、プライベート Ingress コントローラーの ALB ID に置き換えます。 ALB ID を見つけるには、<code>bx cs albs --cluster <my_cluster></code> を実行します。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;mycustomdomain&gt;</em> を、TLS 終端のために構成するカスタム・ドメインに置き換えます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;mytlssecret&gt;</em> を、先ほど作成したシークレットの名前に置き換えます。このシークレット内に、カスタム・ドメインの TLS 終端を管理するための TLS 証明書と鍵を保持します。
        </tr>
        <tr>
        <td><code>ホスト </code></td>
        <td><em>&lt;mycustomdomain&gt;</em> を、TLS 終端のために構成するカスタム・ドメインに置き換えます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myservicepath1&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

        </br>
        Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。 この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。 Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。 着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。

        </br>
        多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br></br>
        例: <ul><li><code>https://mycustomdomain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>https://mycustomdomain/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、[再書き込みアノテーション](cs_annotations.html#rewrite-path)を使用してアプリへの適切なルーティングを設定します。
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。 アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Ingress リソースを作成します。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Ingress リソースが正常に作成されたことを確認します。 <em>&lt;myingressname&gt;</em> を、先ほど作成した Ingress リソースの名前に置き換えます。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **注:** Ingress リソースが適切に作成され、アプリが使用可能になるまでに数秒かかることがあります。

9.  インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  アクセスするアプリ・サービスの URL を入力します。

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

## IP アドレスとサブネットの管理
{: #cs_cluster_ip_subnet}

ポータブル・パブリック・サブネット、ポータブル・プライベート・サブネット、ポータブル・パブリック IP アドレス、ポータブル・プライベート IP アドレスを使用してクラスター内のアプリを公開し、インターネットからまたはプライベート・ネットワーク上でアクセス可能にすることができます。
{:shortdesc}

{{site.data.keyword.containershort_notm}} では、クラスターにネットワーク・サブネットを追加して、Kubernetes サービス用の安定したポータブル IP を追加できます。 標準クラスターを作成すると、{{site.data.keyword.containershort_notm}} は、1 つのポータブル・パブリック・サブネットと 5 つのポータブル・パブリック IP アドレス、および 1 つのポータブル・プライベート・サブネットと 5 つのポータブル・プライベート IP アドレスを自動的にプロビジョンします。 ポータブル IP アドレスは静的で、ワーカー・ノードまたはクラスターが削除されても変更されません。

 これらのポータブル IP アドレスのうち 2 つ (1 つはパブリック、1 つはプライベート) は、クラスター内の複数のアプリを公開するために使用できる [Ingress コントローラー](#cs_apps_public_ingress)に使用されます。 4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスは、[ロード・バランサー・サービスを作成して](#cs_apps_public_load_balancer)アプリを公開するために使用できます。

**注:** ポータブル IP アドレスは、月単位で課金されます。 クラスターのプロビジョンの後にポータブル・パブリック IP アドレスを削除する場合、短時間しか使用しない場合でも月額課金を支払う必要があります。



1.  `myservice.yaml` という Kubernetes サービス構成ファイルを作成します。このファイルでは、ダミーのロード・バランサー IP アドレスを使用して `LoadBalancer` タイプのサービスを定義します。 以下の例では、ロード・バランサー IP アドレスとして IP アドレス 1.1.1.1 を使用します。

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  クラスター内にサービスを作成します。

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  サービスを検査します。

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **注:** Kubernetes マスターが、指定のロード・バランサー IP アドレスを Kubernetes config マップで見つけることができないため、このサービスの作成は失敗します。 このコマンドを実行すると、エラー・メッセージと、クラスターで使用可能なパブリック IP アドレスのリストが表示されます。

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}




1.  `myservice.yaml` という Kubernetes サービス構成ファイルを作成します。このファイルでは、ダミーのロード・バランサー IP アドレスを使用して `LoadBalancer` タイプのサービスを定義します。 以下の例では、ロード・バランサー IP アドレスとして IP アドレス 1.1.1.1 を使用します。

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  クラスター内にサービスを作成します。

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  サービスを検査します。

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **注:** Kubernetes マスターが、指定のロード・バランサー IP アドレスを Kubernetes config マップで見つけることができないため、このサービスの作成は失敗します。 このコマンドを実行すると、エラー・メッセージと、クラスターで使用可能なパブリック IP アドレスのリストが表示されます。

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### 使用されている IP アドレスの解放
{: #freeup_ip}

ポータブル IP アドレスを使用しているロード・バランサー・サービスを削除することによって、使用されているポータブル IP アドレスを解放できます。

[始めに、使用するクラスターのコンテキストを設定してください。
](cs_cli_install.html#cs_cli_configure)

1.  クラスターで使用可能なサービスをリスト表示します。

    ```
    kubectl get services
    ```
    {: pre}

2.  パブリック IP アドレスまたはプライベート IP アドレスを使用しているロード・バランサー・サービスを削除します。

    ```
    kubectl delete service <myservice>
    ```
    {: pre}

<br />


## GUI でアプリをデプロイする方法
{: #cs_apps_ui}

Kubernetes ダッシュボードを使用してアプリをクラスターにデプロイすると、クラスター内でポッドを作成、更新、管理するためのデプロイメント・リソースが自動的に作成されます。
{:shortdesc}

開始前に、以下のことを行います。

-   必要な [CLI](cs_cli_install.html#cs_cli_install) をインストールします。
-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

アプリをデプロイするには、以下の手順で行います。

1.  [Kubernetes ダッシュボードを開きます](#cs_cli_dashboard)。
2.  Kubernetes ダッシュボードで**「+ 作成」**をクリックします。
3.  **「ここでアプリの詳細情報を指定する (Specify app details below)」**を選択してアプリの詳細情報を GUI で入力するか、**「YAML ファイルまたは JSON ファイルをアップロードする (Upload a YAML or JSON file)」**を選択してアプリの[構成ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) をアップロードします。 [このサンプル YAML ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) を使用して米国南部地域の **ibmliberty** イメージからコンテナーをデプロイします。
4.  Kubernetes ダッシュボードで**「デプロイメント」**をクリックして、デプロイメントが作成されたことを確認します。
5.  ノード・ポート・サービス、ロード・バランサー・サービス、または Ingress を使用して、アプリをだれでも利用できるようにした場合は、アプリにアクセスできることを確認します。

<br />


## CLI でアプリをデプロイする方法
{: #cs_apps_cli}

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
{: #cs_apps_scaling}

<!--Horizontal auto-scaling is not working at the moment due to a port issue with heapster. The dev team is working on a fix. We pulled out this content from the public docs. It is only visible in staging right now.-->

アプリケーションの需要の変化に応じて必要な場合にのみリソースを使用するクラウド・アプリケーションをデプロイできます。 自動スケーリングを使用すれば、CPU に基づいてアプリのインスタンス数を自動的に増減できます。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

**注:** 自動スケーリング Cloud Foundry アプリケーションに関する情報をお探しですか? [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html) を参照してください。

Kubernetes では、[水平ポッド自動スケーリング ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) を有効にして CPU ベースでアプリをスケーリングできます。

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

    **注:** デプロイメントがかなり複雑になる場合は、[構成ファイル](#cs_apps_cli)を作成する必要があります。
2.  水平ポッド自動スケーリング機能を作成し、ポリシーを定義します。 `kubetcl autoscale` コマンドの使い方について詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#autoscale) を参照してください。

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
{: #cs_apps_rolling}

変更のロールアウトを自動化され制御された方法で管理できます。 ロールアウトがプランに従ったものでない場合、デプロイメントを以前のリビジョンにロールバックできます。
{:shortdesc}

開始する前に、[デプロイメント](#cs_apps_cli)を作成します。

1.  変更を[ロールアウト ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) します。 例えば、初期デプロイメントで使用したイメージを変更することができます。

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


## {{site.data.keyword.Bluemix_notm}} サービスの追加
{: #cs_apps_service}

暗号化した Kubernetes シークレットを使用して、{{site.data.keyword.Bluemix_notm}} サービスの詳細情報や資格情報を保管し、サービスとクラスターの間のセキュアな通信を確保します。 クラスター・ユーザーがそのシークレットにアクセスするには、そのシークレットをボリュームとしてポッドにマウントする必要があります。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。 アプリで使用する {{site.data.keyword.Bluemix_notm}} サービスが、クラスター管理者によって[クラスターに追加されていること](cs_cluster.html#cs_cluster_service)を確認してください。

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


## 永続ストレージの作成
{: #cs_apps_volume_claim}

NFS ファイル・ストレージをクラスターにプロビジョンするために、永続ボリューム請求 (pvc) を作成します。 その後、この請求をポッドにマウントすることで、ポッドがクラッシュしたりシャットダウンしたりしてもデータを利用できるようにします。
{:shortdesc}

永続ボリュームの基礎の NFS ファイル・ストレージは、データの高可用性を実現するために IBM がクラスター化しています。


{{site.data.keyword.Bluemix_dedicated_notm}} アカウントが[クラスターで有効になっている](cs_ov.html#setup_dedicated)場合は、このタスクを使用する代わりに、[サポート・チケットを開く](/docs/support/index.html#contacting-support)必要があります。 チケットを開くことにより、ボリュームのバックアップやボリュームからのリストアなどのストレージ機能を要求できます。


1.  使用可能なストレージ・クラスを確認します。 {{site.data.keyword.containerlong}} には事前定義のストレージ・クラスが 8 つ用意されているので、クラスター管理者がストレージ・クラスを作成する必要はありません。 `ibmc-file-bronze` ストレージ・クラスは `default` ストレージ・クラスと同じです。

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  pvc を削除した後にデータと NFS ファイル共有を保存するかどうかを決めます。 データを保持する場合、`retain` ストレージ・クラスを選択します。 pvc を削除するときにデータとファイル共有も削除する場合、`retain` のないストレージ・クラスを選択します。

3.  ストレージ・クラスの IOPS と使用可能なストレージ・サイズを確認します。
    - bronze、silver、gold の各ストレージ・クラスはエンデュランス・ストレージを使用し、各クラスには、定義された IOPS/GB が 1 つあります。 合計 IOPS は、ストレージのサイズに依存します。 例えば、4 IOPS/GB を 1000Gi pvc 使用すると、合計 4000 IOPS となります。

    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    **「Parameters」**フィールドで、ストレージ・クラスに関連した 1 GB あたりの IOPS と使用可能なサイズ (ギガバイト単位) を確認できます。

    ```
    Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

    - カスタム・ストレージ・クラスは、[パフォーマンス・ストレージ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/performance-storage) を使用し、合計 IOPS とサイズが個別に設定されたオプションがあります。

    ```
    kubectl describe storageclasses ibmc-file-retain-custom
    ```
    {: pre}

    **「Parameters」**フィールドで、ストレージ・クラスに関連した IOPS と使用可能なサイズ (ギガバイト単位) を指定します。 例えば、40Gi pvc では、IOPS として 100 から 2000 IOPS の範囲の 100 の倍数を選択できます。

    ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
    {: screen}

4.  永続ボリューム請求を定義した構成ファイルを作成し、`.yaml` ファイルとして構成を保存します。

    bronze、silver、gold の各クラスの場合の例は次のようになります。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    カスタム・クラスの場合の例は次のようになります。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>永続ボリューム請求の名前を入力します。</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>永続ボリュームのためのストレージ・クラスを指定します。
      <ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze: 2 IOPS/GB。</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS/GB。</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS/GB。</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom: 複数の IOPS の値を使用できます。

    </li> ストレージ・クラスを指定しなかった場合は、ブロンズ・ストレージ・クラスを使用して永続ボリュームが作成されます。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>リストされているもの以外のサイズを選択した場合、サイズは切り上げられます。 最大サイズより大きいサイズを選択した場合、サイズは切り下げられます。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>このオプションは、ibmc-file-custom / ibmc-file-retain-custom だけのためのものです。 ストレージのための合計 IOPS を指定します。 すべてのオプションを表示するには、`kubectl describe storageclasses ibmc-file-custom` を実行します。 リストされているもの以外の IOPS を選択した場合、その IOPS は切り上げられます。</td>
    </tr>
    </tbody></table>

5.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  永続ボリューム請求が作成され、永続ボリュームにバインドされたことを確認します。 この処理には数分かかる場合があります。

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    出力は、以下のようになります。

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}永続ボリューム請求をポッドにマウントするには、構成ファイルを作成します。 構成を `.yaml` ファイルとして保存します。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>ポッドの名前。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>コンテナー内でボリュームがマウントされるディレクトリーの絶対パス。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>コンテナーにマウントするボリュームの名前。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>コンテナーにマウントするボリュームの名前。 通常、この名前は <code>volumeMounts/name</code> と同じです。</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>ボリュームとして使用する永続ボリューム請求の名前。 ボリュームをポッドにマウントすると、Kubernetes は永続ボリューム請求にバインドされた永続ボリュームを識別して、その永続ボリュームでユーザーが読み取り/書き込みを行えるようにします。</td>
    </tr>
    </tbody></table>

8.  ポッドを作成して、永続ボリューム請求をポッドにマウントします。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  ボリュームがポッドに正常にマウントされたことを確認します。

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    マウント・ポイントは **Volume Mounts** フィールドにあり、ボリュームは **Volumes** フィールドにあります。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />


## 永続ストレージに対する非 root ユーザーのアクセス権限の追加
{: #cs_apps_volumes_nonroot}

非 root ユーザーには、NFS ベースのストレージのボリューム・マウント・パスに対する書き込み権限がありません。 書き込み権限を付与するには、イメージの Dockerfile を編集して、適切な権限を設定したディレクトリーをマウント・パス上に作成する必要があります。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

非 root ユーザーを使用するアプリを設計していて、そのユーザーにボリュームに対する書き込み権限が必要な場合は、Dockerfile とエントリー・ポイント・スクリプトに次の処理を追加する必要があります。

-   非 root ユーザーを作成する。
-   そのユーザーを一時的に root グループに追加する。
-   ボリューム・マウント・パスにディレクトリーを作成して、適切なユーザー権限を設定する。

{{site.data.keyword.containershort_notm}} の場合、ボリューム・マウント・パスのデフォルト所有者は、所有者 `nobody` です。 NFS ストレージを使用する場合は、所有者がポッドのローカルに存在しなければ、`nobody` ユーザーが作成されます。 ボリュームは、コンテナー内の root ユーザーを認識するようにセットアップされます。一部のアプリでは、このユーザーがコンテナー内の唯一のユーザーです。 しかし、多くのアプリでは、コンテナー・マウント・パスへの書き込みを行う `nobody` 以外の非 root ユーザーを指定します。 ボリュームは root ユーザーが所有しなければならないということを指定するアプリもあります。 アプリは通常、セキュリティー上の懸念から root ユーザーを使用しません。 それでもアプリが root ユーザーを必要とする場合は、[{{site.data.keyword.Bluemix_notm}} サポート](/docs/support/index.html#contacting-support)に連絡を取ることができます。


1.  ローカル・ディレクトリーに Dockerfile を作成します。 この Dockerfile 例では、`myguest` という非 root ユーザーを作成します。

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    # The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Dockerfile と同じローカル・フォルダーに、エントリー・ポイント・スクリプトを作成します。 このエントリー・ポイント・スクリプト例では、ボリューム・マウント・パスとして `/mnt/myvol` を指定します。

    ```
    #!/bin/bash
    set -e

    # This is the mount point for the shared volume.
    # By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      # Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      # For security, remove the non-root user from root user group.
      deluser $MY_USER root

      # Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    # This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  {{site.data.keyword.registryshort_notm}} にログインします。

    ```
    bx cr login
    ```
    {: pre}

4.  イメージをローカルにビルドします。 _&lt;my_namespace&gt;_ を、プライベート・イメージ・レジストリーの名前空間に必ず置き換えてください。 名前空間を調べる必要がある場合は、`bx cr namespace-get` を実行します。

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  {{site.data.keyword.registryshort_notm}} 内の名前空間にイメージをプッシュします。

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  `.yaml` 構成ファイルを作成して、永続ボリューム請求を作成します。 この例では、パフォーマンスがやや低いストレージ・クラスを使用しています。 使用可能なストレージ・クラスを表示するには、`kubectl get storageclasses` を実行してください。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  ボリュームをマウントし、非 root イメージからポッドを実行するように構成ファイルを作成します。 ボリューム・マウント・パス `/mnt/myvol` は、Dockerfile で指定されたマウント・パスと一致します。 構成を `.yaml` ファイルとして保存します。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  ポッドを作成して、永続ボリューム請求をポッドにマウントします。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. ボリュームがポッドに正常にマウントされたことを確認します。

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    マウント・ポイントは **Volume Mounts** フィールドにリストされ、ボリュームは **Volumes** フィールドにリストされます。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. ポッドが実行されたら、ポッドにログインします。

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. ボリューム・マウント・パスの許可を表示します。

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    この出力が示すように、root にはボリューム・マウント・パス `mnt/myvol/` に対する読み取り/書き込み/実行権限があり、非 root の myguest ユーザーには、`mnt/myvol/mydata` フォルダーに対する読み取り/書き込み権限があります。 このように権限が更新されたことにより、非 root ユーザーは永続ボリュームにデータを書き込めるようになりました。
