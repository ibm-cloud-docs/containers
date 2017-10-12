---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-13"

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

Kubernetes の技法を利用して、アプリをデプロイし、アプリの常時稼働を確保することができます。例えば、ダウン時間なしでローリング更新とロールバックを実行できます。{:shortdesc}

アプリのデプロイには一般に次の手順が含まれます。

1.  [CLI をインストールします](cs_cli_install.html#cs_cli_install)。

2.  アプリの構成スクリプトを作成します。[Kubernetes のベスト・プラクティスを確認してください。![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  次のいずれかの方法でスクリプトを構成します。
    -   [Kubernetes CLI](#cs_apps_cli)
    -   Kubernetes ダッシュボード
        1.  [Kubernetes
ダッシュボードを起動します。](#cs_cli_dashboard)
        2.  [構成スクリプトを実行します。](#cs_apps_ui)


## Kubernetes ダッシュボードの起動
{: #cs_cli_dashboard}

ローカル・システムで Kubernetes ダッシュボードを開くと、クラスターとそのすべてのワーカー・ノードに関する情報が表示されます。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。このタスクには、[管理者アクセス・ポリシー](cs_cluster.html#access_ov)が必要です。現在の[アクセス・ポリシー](cs_cluster.html#view_access)を確認してください。

クラスターの Kubernetes ダッシュボードを起動するために、デフォルトのポートを使用するか、独自のポートを設定できます。
-   デフォルトのポート 8001 で Kubernetes ダッシュボードを起動します。
    1.  デフォルトのポート番号でプロキシーを設定します。

        ```
kubectl proxy```
        {: pre}

        CLI 出力は、以下のようになります。

        ```
Starting to serve on 127.0.0.1:8001```
        {: screen}

    2.  Web ブラウザーで以下の URL を開いて、Kubernetes ダッシュボードを表示します。


        ```
http://localhost:8001/ui```
        {: codeblock}

-   独自のポートで Kubernetes ダッシュボードを起動します。
    1.  独自のポート番号でプロキシーを設定します。

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  ブラウザーで以下の URL を開きます。

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


Kubernetes ダッシュボードでの作業が完了したら、`CTRL+C` を使用して `proxy` コマンドを終了します。


## アプリへのパブリック・アクセスを許可する方法
{: #cs_apps_public}

アプリをだれでも利用できるようにするには、アプリをクラスターにデプロイする前に、構成スクリプトを更新する必要があります。{:shortdesc}

ライト・クラスターを作成したか標準クラスターを作成したかに応じて、インターネットからアプリにアクセスできるようにする方法は複数あります。

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">NodePort タイプのサービス</a> (ライト・クラスターと標準クラスター)</dt>
<dd>すべてのワーカー・ノードのパブリック・ポートを公開し、ワーカー・ノードのパブリック IP アドレスを使用して、クラスター内のサービスにパブリック・アクセスを行います。
ワーカー・ノードのパブリック IP アドレスは永続的なアドレスではありません。
ワーカー・ノードが削除されたり再作成されたりすると、新しいパブリック IP アドレスがワーカー・ノードに割り当てられます。
NodePort タイプのサービスは、アプリのパブリック・アクセスをテストする場合や、パブリック・アクセスが短期間だけ必要な場合に使用できます。
安定的なパブリック IP アドレスとサービス・エンドポイントのさらなる可用性が必要な場合は、LoadBalancer タイプか Ingress タイプのサービスを使用してアプリを公開してください。
</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">LoadBalancer タイプのサービス</a> (標準クラスターのみ)</dt>
<dd>どの標準クラスターにも 4 つのポータブル・パブリック IP アドレスがプロビジョンされます。そのアドレスを使用して、アプリ用の外部 TCP/ UDP ロード・バランサーを作成できます。アプリで必要なすべてのポートを公開することによってロード・バランサーをカスタマイズすることも可能です。
ロード・バランサーに割り当てられるポータブル・パブリック IP アドレスは永続的なアドレスであり、クラスター内のワーカー・ノードが再作成されても変更されません。
</br>
アプリで HTTP または HTTPS のロード・バランシングが必要な状況で、1 つのパブリック・ルートを使用してクラスター内の複数のアプリをサービスとして公開する場合は、{{site.data.keyword.containershort_notm}} に組み込まれている Ingress サポートを使用してください。</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a> (標準クラスターのみ)</dt>
<dd>HTTP または HTTPS のいずれかで使用できる外部ロード・バランサーを 1 つ作成することによって、クラスターに複数のアプリを公開できます。このロード・バランサーを使用して、保護された固有のパブリック・エントリー・ポイントから着信要求を各アプリにルーティングします。Ingress は、Ingress リソースおよび Ingress コントローラーという 2 つの主要なコンポーネントで構成されています。Ingress リソースでは、アプリに対する着信要求のルーティングとロード・バランシングの方法に関するルールを定義します。
Ingress リソースはすべて Ingress コントローラーに登録する必要があります。Ingress コントローラーは、着信する HTTP または HTTPS のいずれかのサービス要求を listen し、Ingress リソースごとに定義されたルールに基づいて要求を転送します。カスタム・ルーティング・ルールを使用して独自のロード・バランサーを実装する場合、およびアプリに SSL 終端が必要な場合は、Ingress を使用してください。
</dd></dl>

### NodePort タイプのサービスを使用してアプリへのパブリック・アクセスを構成する方法
{: #cs_apps_public_nodeport}

クラスター内のいずれかのワーカー・ノードのパブリック IP アドレスを使用してノード・ポートを公開することによって、アプリをだれでも利用できるように公開します。
このオプションは、テストの場合や短期間のパブリック・アクセスを許可する場合に使用してください。
{:shortdesc}

ライト・クラスターでも標準クラスターでも、アプリは NodePort タイプの Kubernetes サービスとして公開できます。

{{site.data.keyword.Bluemix_notm}} Dedicated 環境の場合、パブリック IP アドレスはファイアウォールでブロックされます。アプリをだれでも利用できるようにするには、[LoadBalancer タイプのサービス](#cs_apps_public_load_balancer)または [Ingress タイプのサービス](#cs_apps_public_ingress)を代わりに使用してください。

**注:** ワーカー・ノードのパブリック IP アドレスは永続的なアドレスではありません。ワーカー・ノードを再作成しなければならない場合は、新しいパブリック IP アドレスがワーカー・ノードに割り当てられます。
安定的なパブリック IP アドレスとサービスのさらなる可用性が必要な場合は、[LoadBalancer タイプのサービス](#cs_apps_public_load_balancer)か [Ingress タイプのサービス](#cs_apps_public_ingress)を使用してアプリを公開してください。





1.  構成スクリプト内の [service ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/) セクションを定義します。
2.  サービスの `spec` セクションで NodePort タイプを追加します。

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  オプション: `ports` セクションで 30000 から 32767 の範囲の NodePort を追加します。別のサービスで既に使用されている NodePort は指定しないでください。
使用中の NodePort が不明な場合は、割り当てないでください。NodePort を割り当てなければ、ランダムに割り当てられます。


    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    NodePort を指定する時に使用中の NodePort を確認する場合は、以下のコマンドを実行できます。


    ```
kubectl get svc```
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
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
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

3.  ワーカー・ノードのパブリック IP アドレスの 1 つと NodePort を使用して URL を作成します。例: `http://192.0.2.23:30872`

### ロード・バランサー・タイプのサービスを使用してアプリへのパブリック・アクセスを構成する方法
{: #cs_apps_public_load_balancer}

ポートを公開し、ロード・バランサーのポータブル・パブリック IP アドレスを使用してアプリにアクセスします。NodePort サービスの場合とは異なり、ロード・バランサー・サービスのポータブル・パブリック IP アドレスは、アプリのデプロイ先のワーカー・ノードに依存していません。ロード・バランサーのポータブル・パブリック IP アドレスは自動的に割り当てられ、ワーカー・ノードを追加したり削除したりしても変わりません。したがって、NodePort サービスよりもロード・バランサー・サービスのほうが可用性が高いということになります。
ユーザーは、ロード・バランサーのポートとしてどのポートでも選択できます。NodePort の場合のポート範囲には限定されません。
ロード・バランサー・サービスは、TCP プロトコルと UDP プロトコルの場合に使用できます。


{{site.data.keyword.Bluemix_notm}} Dedicated アカウントが[クラスターで有効になっている](cs_ov.html#setup_dedicated)場合、ロード・バランサー IP アドレスに使用するパブリック・サブネットを要求できます。[サポート・チケットを開いて](/docs/support/index.html#contacting-support)サブネットを作成してから、[`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) コマンドを使用してサブネットをクラスターに追加します。

**注:** ロード・バランサー・サービスは TLS 終端をサポートしていません。アプリで TLS 終端が必要な場合は、[Ingress](#cs_apps_public_ingress) を介してアプリを公開するか、または TLS 終端を管理するようにアプリを構成することができます。

開始前に、以下のことを行います。

-   このフィーチャーを使用できるのは、標準クラスターの場合に限られます。
-   ロード・バランサー・サービスに割り当てることのできるポータブル・パブリック IP アドレスが必要です。

ロード・バランサー・サービスを作成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](#cs_apps_cli)。アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。
構成スクリプトの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。このラベルは、アプリが実行されるすべてのポッドをロード・バランシングに含めるためにそれらのポッドを識別する上で必要です。

2.  公開するアプリのロード・バランサー・サービスを作成します。アプリをパブリック・インターネット上で使用できるようにするためには、アプリの Kubernetes サービスを作成し、アプリを構成しているすべてのポッドをロード・バランシングに含めるようにサービスを構成する必要があります。

    1.  任意のエディターを開き、`myloadbalancer.yaml` などの名前のサービス構成スクリプトを作成します。
    2.  公開するアプリのロード・バランサー・サービスを定義します。

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

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em> をロード・バランサー・サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。
例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。
</td>
         </tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tbody></table>
    3.  オプション: クラスターで使用可能な特定のポータブル・パブリック IP アドレスをロード・バランサーに使用する場合は、spec セクションに `loadBalancerIP` を含めることによって、その IP アドレスを指定できます。詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/) を参照してください。
    4.  オプション: spec セクションに `loadBalancerSourceRanges` を指定してファイアウォールを構成することもできます。詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。
    5.  変更を保存します。
    6.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

ロード・バランサー・サービスが作成される際に、ロード・バランサーにポータブル・パブリック IP アドレスが自動的に割り当てられます。
使用可能なポータブル・パブリック IP アドレスがなければ、ロード・バランサー・サービスの作成は失敗します。3.  ロード・バランサー・サービスが正常に作成されたことを確認します。
_&lt;myservice&gt;_ を、前のステップで作成したロード・バランサー・サービスの名前に置き換えます。


    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **注:** ロード・バランサー・サービスが適切に作成され、公共のインターネット上でアプリが使用可能になるまでに数分かかることがあります。

    CLI 出力は、以下のようになります。



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
4.  インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  ロード・バランサーのポータブル・パブリック IP アドレスとポートを入力します。上記の例では、ポータブル・パブリック IP アドレス `192.168.10.38` が、ロード・バランサー・サービスに割り当てられていました。

        ```
http://192.168.10.38:8080```
        {: codeblock}


### Ingress コントローラーを使用してアプリへのパブリック・アクセスを構成する方法
{: #cs_apps_public_ingress}

IBM 提供の Ingress コントローラーにより管理される Ingress リソースを作成することによって、クラスター内の複数のアプリを公します。
Ingress コントローラーは、HTTP または HTTPS のいずれかの外部ロード・バランサーです。このロード・バランサーは、保護された固有のパブリック・エントリー・ポイントを使用して、着信要求をクラスター内外のアプリにルーティングします。

**注:** Ingress は標準クラスター専用で、高可用性を保証するにはクラスター内に 2 つ以上のワーカー・ノードが必要です。

標準クラスターを作成すると、Ingress コントローラーが自動的に作成され、1 つのポータブル・パブリック IP アドレスと 1 つのパブリック経路が割り当てられます。Ingress コントローラーを構成し、公開するアプリごとに個々のルーティング・ルールを定義することができます。
Ingress によって公開される各アプリに対して、パブリック経路に付加される固有のパスが割り当てられるため、クラスター内のアプリへの固有の URL を使用したパブリック・アクセスが可能となります。


{{site.data.keyword.Bluemix_notm}} Dedicated アカウントが[クラスターで有効になっている](cs_ov.html#setup_dedicated)場合、Ingress コントローラー IP アドレスに使用するパブリック・サブネットを要求できます。それから、Ingress コントローラーを作成してパブリック経路を割り当てます。[サポート・チケットを開いて](/docs/support/index.html#contacting-support)サブネットを作成してから、[`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) コマンドを使用してサブネットをクラスターに追加します。

以下のシナリオで Ingress コントローラーを構成できます。

-   [TLS 終端なしで IBM 提供ドメインを使用する](#ibm_domain)
-   [TLS 終端ありで IBM 提供ドメインを使用する](#ibm_domain_cert)
-   [TLS 終端を実行するためにカスタム・ドメインと TLS 証明書を使用する](#custom_domain_cert)
-   [クラスターの外部のアプリにアクセスするために、TLS 終端ありで IBM 提供ドメインまたはカスタム・ドメインを使用する](#external_endpoint)
-   [アノテーションを使用して Ingress コントローラーをカスタマイズする](#ingress_annotation)

#### TLS 終端なしで IBM 提供ドメインを使用する
{: #ibm_domain}

クラスター内のアプリ用の HTTP ロード・バランサーとして Ingress コントローラーを構成し、IBM 提供ドメインを使用してインターネットからアプリにアクセスします。

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。

Ingress コントローラーを構成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](#cs_apps_cli)。アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。
構成スクリプトの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。

2.  公開するアプリ用に、Kubernetes サービスを作成します。
Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。
    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成スクリプトを作成します。
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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em> をロード・バランサー・サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。
例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。
</td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tr>
         </tbody></table>
    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
kubectl apply -f myservice.yaml```
        {: pre}
    5.  公開するアプリごとに、上記のステップを繰り返します。
3.  クラスターの詳細を取得して、IBM 提供ドメインを表示します。_&lt;mycluster&gt;_ を、公開する対象のアプリがデプロイされているクラスターの名前に置き換えます。

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

IBM 提供ドメインは、**「Ingress サブドメイン (Ingress subdomain)」**フィールドに示されます。4.  Ingress リソースを作成します。Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。
すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。

    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成スクリプトを作成します。
    2.  IBM 提供ドメインを使用して着信ネットワーク・トラフィックを作成済みのサービスにルーティングするように、Ingress リソースを構成スクリプト内に定義します。

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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
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
        Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。
Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。


        </br></br>
多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。</br>
例:<ul><li><code>http://ingress_host_name/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://ingress_host_name/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        </br>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、<a href="#rewrite" target="_blank">再書き込みアノテーション</a>を使用してアプリへの適切なルーティングを設定します。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  クラスターの Ingress リソースを作成します。

        ```
kubectl apply -f myingress.yaml```
        {: pre}

5.  Ingress リソースが正常に作成されたことを確認します。_&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

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

1.  [アプリをクラスターにデプロイします](#cs_apps_cli)。構成スクリプトの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。このラベルにより、アプリが実行されるすべてのポッドが識別され、それらのポッドが Ingress ロード・バランシングに含められます。

2.  公開するアプリ用に、Kubernetes サービスを作成します。
Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。
    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成スクリプトを作成します。
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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice&gt;</em> を Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。
例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。
</td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tr>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
kubectl apply -f myservice.yaml```
        {: pre}

    5.  公開するアプリごとに、上記のステップを繰り返します。

3.  IBM 提供ドメインと TLS 証明書を表示します。_&lt;mycluster&gt;_ を、アプリがデプロイされているクラスターの名前に置き換えます。

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

4.  Ingress リソースを作成します。Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。
すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。

    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成スクリプトを作成します。
    2.  IBM 提供ドメインを使用して着信ネットワーク・トラフィックを対象サービスにルーティングし、IBM 提供の証明書を使用して TLS 終端を管理するように、Ingress リソースを構成スクリプト内に定義します。サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://ingress_domain/myapp`) を作成することができます。この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。
Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、さらに、アプリが実行されているポッドに送信します。


        **注:** Ingress リソースに定義されたパスでアプリが listen していなければなりません。そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。
この場合、ルート・パスを `/` として定義します。アプリ用の個別のパスは指定しないでください。

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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;ibmtlssecret&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress シークレット (Ingress secret)」</strong>の名前に置き換えます。
この証明書で TLS 終端を管理します。</tr>
        <tr>
        <td><code>ホスト </code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myservicepath1&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。


        </br>
        Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。
Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。


        </br>
多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br>
例:<ul><li><code>http://ingress_host_name/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>http://ingress_host_name/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、<a href="#rewrite" target="_blank">再書き込みアノテーション</a>を使用してアプリへの適切なルーティングを設定します。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  クラスターの Ingress リソースを作成します。

        ```
kubectl apply -f myingress.yaml```
        {: pre}

5.  Ingress リソースが正常に作成されたことを確認します。_&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

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

IBM 提供ドメインではなくカスタム・ドメインを使用する場合でも、着信ネットワーク・トラフィックをクラスター内のアプリに転送し、独自の TLS 証明書を使用して TLS 終端を管理するように、Ingress コントローラーを構成することができます。{:shortdesc}

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。

Ingress コントローラーを構成するには、以下のようにします。

1.  カスタム・ドメインを作成します。カスタム・ドメインを作成するには、ドメイン・ネーム・サービス (DNS) プロバイダーを使用してカスタム・ドメインを登録します。
2.  着信ネットワーク・トラフィックを IBM Ingress コントローラーにルーティングするようにドメインを構成します。以下の選択肢があります。
    -   IBM 提供ドメインを正規名レコード (CNAME) として指定することで、カスタム・ドメインの別名を定義します。
IBM 提供の Ingress ドメインを確認するには、`bx cs cluster-get <mycluster>` を実行し、**「Ingress サブドメイン (Ingress subdomain)」**フィールドを見つけます。
    -   カスタム・ドメインを IBM 提供の Ingress コントローラーのポータブル・パブリック IP アドレスにマップします。これは、IP アドレスをポインター・レコード (PTR) として追加して行います。Ingress コントローラーのポータブル・パブリック IP アドレスを確認するには、次のようにします。
        1.  `bx cs cluster-get <mycluster>` を実行し、**「Ingress サブドメイン (Ingress subdomain)」**フィールドを見つけます。
        2.  `nslookup <Ingress subdomain>` を実行します。
3.  base64 形式でエンコードされた TLS 証明書と鍵を、当該ドメインのために作成します。
4.  この TLS 証明書と鍵を Kubernetes シークレットに保管します。
    1.  任意のエディターを開き、`mysecret.yaml` などの名前の Kubernetes シークレット構成スクリプトを作成します。
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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
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

    3.  構成スクリプトを保存します。
    4.  クラスターの TLS シークレットを作成します。

        ```
kubectl apply -f mysecret.yaml```
        {: pre}

5.  [アプリをクラスターにデプロイします](#cs_apps_cli)。アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。
構成スクリプトの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。このラベルは、アプリが実行されるすべてのポッドを識別して、それらのポットが Ingress ロード・バランシングに含められるようにするために必要です。


6.  公開するアプリ用に、Kubernetes サービスを作成します。
Ingress コントローラーが Ingress ロード・バランシングにアプリを含めることができるのは、クラスター内の Kubernetes サービスによってアプリが公開されている場合のみです。

    1.  任意のエディターを開き、`myservice.yaml` などの名前のサービス構成スクリプトを作成します。
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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myservice1&gt;</em> を Kubernetes サービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selectorkey&gt;</em>) と値 (<em>&lt;selectorvalue&gt;</em>) のペアを入力します。
例えば、<code>app: code</code> というセレクターを使用した場合、メタデータにこのラベルがあるすべてのポッドが、ロード・バランシングに含められます。アプリをクラスターにデプロイするときに使用したものと同じラベルを入力してください。
</td>
         </tr>
         <td><code>port</code></td>
         <td>サービスが listen するポート。</td>
         </tbody></table>

    3.  変更を保存します。
    4.  クラスター内にサービスを作成します。

        ```
kubectl apply -f myservice.yaml```
        {: pre}

    5.  公開するアプリごとに、上記のステップを繰り返します。
7.  Ingress リソースを作成します。Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。
すべてのアプリがクラスター内の Kubernetes サービスによって公開されていれば、1 つの Ingress リソースを使用して複数のアプリのルーティング・ルールを定義できます。

    1.  任意のエディターを開き、`myingress.yaml` などの名前の Ingress 構成スクリプトを作成します。
    2.  カスタム・ドメインを使用して着信ネットワーク・トラフィックを対象サービスにルーティングし、カスタム証明書を使用して TLS 終端を管理するように、Ingress リソースを構成スクリプト内に定義します。サービスごとに、カスタム・ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://mydomain/myapp`) を作成することができます。この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。
Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、さらに、アプリが実行されているポッドに送信します。


        **注:** Ingress リソースに定義されたパスでアプリが listen していることが重要です。そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。
この場合、ルート・パスを `/` として定義します。アプリ用の個別のパスは指定しないでください。

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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
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
        <td><em>&lt;mytlssecret&gt;</em> を、先ほど作成したシークレットの名前に置き換えます。このシークレット内に、カスタム・ドメインの TLS 終端を管理するための TLS 証明書と鍵を保持します。</tr>
        <tr>
        <td><code>ホスト </code></td>
        <td><em>&lt;mycustomdomain&gt;</em> を、TLS 終端のために構成するカスタム・ドメインに置き換えます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myservicepath1&gt;</em> をスラッシュか、アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。


        </br>
        Kubernetes サービスごとに、IBM 提供ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば <code>ingress_domain/myservicepath1</code>) を作成できます。この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。
Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに送信し、アプリが実行されているポッドに送信します。着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。


        </br>
多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br></br>
例:<ul><li><code>https://mycustomdomain/</code> の場合、<code>/</code> をパスとして入力します。</li><li><code>https://mycustomdomain/myservicepath</code> の場合、<code>/myservicepath</code> をパスとして入力します。</li></ul>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、<a href="#rewrite" target="_blank">再書き込みアノテーション</a>を使用してアプリへの適切なルーティングを設定します。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td><em>&lt;myservice1&gt;</em> を、アプリ用に Kubernetes サービスを作成したときに使用したサービスの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>サービスが listen するポート。アプリ用に Kubernetes サービスを作成したときに定義したものと同じポートを使用します。</td>
        </tr>
        </tbody></table>

    3.  変更を保存します。
    4.  クラスターの Ingress リソースを作成します。

        ```
kubectl apply -f myingress.yaml```
        {: pre}

8.  Ingress リソースが正常に作成されたことを確認します。_&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

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

クラスターの外部に配置されたアプリをクラスター・ロード・バランシングに含めるように、Ingress コントローラーを構成することができます。
IBM 提供ドメインまたはカスタム・ドメインでの着信要求は、自動的に外部アプリに転送されます。

開始前に、以下のことを行います。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](cs_cluster.html#cs_cluster_ui)。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。
-   クラスター・ロード・バランシングに含めようとしている外部アプリに、パブリック IP アドレスを使用してアクセスできることを確認します。

IBM 提供ドメインへの着信ネットワーク・トラフィックを、クラスターの外部に配置されたアプリに転送するように Ingress コントローラーを構成することができます。代わりにカスタム・ドメインと TLS 証明書を使用する場合は、IBM 提供ドメインと TLS 証明書を[カスタムのドメインと TLS 証明書](#custom_domain_cert)に置き換えてください。

1.  クラスター・ロード・バランシングに含める外部のアプリの場所を定義する、Kubernetes エンドポイントを構成します。
    1.  任意のエディターを開き、`myexternalendpoint.yaml` などの名前のエンドポイント構成スクリプトを作成します。
    2.  外部エンドポイントを定義します。外部アプリにアクセスするために使用可能な、すべてのパブリック IP アドレスとポートを含めます。


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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
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
    1.  任意のエディターを開き、`myexternalservice.yaml` などの名前のサービス構成スクリプトを作成します。
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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
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

3.  IBM 提供ドメインと TLS 証明書を表示します。_&lt;mycluster&gt;_ を、アプリがデプロイされているクラスターの名前に置き換えます。

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

4.  Ingress リソースを作成します。Ingress リソースは、アプリ用に作成した Kubernetes サービスのルーティング・ルールを定義するもので、着信ネットワーク・トラフィックをサービスにルーティングするために Ingress コントローラーによって使用されます。
すべてのアプリがクラスター内の Kubernetes サービスによってアプリの外部エンドポイントとともに公開されていれば、1 つの Ingress リソースを使用して複数の外部アプリのルーティング・ルールを定義できます。

    1.  任意のエディターを開き、`myexternalingress.yaml` などの名前の Ingress 構成スクリプトを作成します。
    2.  IBM 提供ドメインと TLS 証明書を使用し、定義済みの外部エンドポイントを使用して着信ネットワーク・トラフィックを外部アプリにルーティングするように、Ingress リソースを構成スクリプト内に定義します。サービスごとに、カスタム・ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、`https://ingress_domain/myapp`) を作成することができます。この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。
Ingress コントローラーは、関連付けられたサービスを検索し、ネットワーク・トラフィックをそのサービスに、さらに外部アプリに送信します。


        **注:** Ingress リソースに定義されたパスでアプリが listen していることが重要です。そうでない場合、ネットワーク・トラフィックをそのアプリに転送できません。大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。
この場合、ルート・パスを / として定義します。アプリ用の個別のパスは指定しないでください。

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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td><em>&lt;myingressname&gt;</em> を Ingress リソースの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td><em>&lt;ibmtlssecret&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress シークレット (Ingress secret)」</strong>に置き換えます。この証明書で TLS 終端を管理します。</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td><em>&lt;ibmdomain&gt;</em> を、前述のステップにある IBM 提供の<strong>「Ingress サブドメイン (Ingress subdomain)」</strong>の名前に置き換えます。このドメインは TLS 終端用に構成されます。

        </br></br>
        <strong>注:</strong> Ingress 作成時の失敗を回避するため、ホストに &ast; を使用したり、ホスト・プロパティーを空のままにしたりしないでください。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td><em>&lt;myexternalservicepath&gt;</em> をスラッシュか、外部アプリが listen する固有のパスに置き換えて、ネットワーク・トラフィックをアプリに転送できるようにします。

        </br>
Kubernetes サービスごとに、ドメインに付加する個別のパスを定義して、アプリへの固有のパス (例えば、<code>https://ibmdomain/myservicepath1</code>) を作成することができます。この経路を Web ブラウザーに入力すると、ネットワーク・トラフィックが Ingress コントローラーにルーティングされます。
Ingress コントローラーは、同じパスを使用して、関連付けられたサービスを検索し、ネットワーク・トラフィックを外部アプリに送信します。着信ネットワーク・トラフィックを受け取るには、このパスを listen するようにアプリをセットアップする必要があります。


        </br></br>
多くのアプリは、特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。 この場合、ルート・パスを <code>/</code> として定義します。アプリ用の個別のパスは指定しないでください。

        </br></br>
        <strong>ヒント:</strong> アプリが listen するパスとは別のパスを listen するように Ingress を構成する場合は、<a href="#rewrite" target="_blank">再書き込みアノテーション</a>を使用してアプリへの適切なルーティングを設定します。</td>
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

5.  Ingress リソースが正常に作成されたことを確認します。_&lt;myingressname&gt;_ を、先ほど作成した Ingress リソースの名前に置き換えます。

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


#### サポートされる Ingress アノテーション
{: #ingress_annotation}

Ingress リソースのメタデータを指定することにより、Ingress コントローラーに機能を追加することができます。
{: shortdesc}

|サポートされるアノテーション|説明|
|--------------------|-----------|
|[再書き込み](#rewrite)|着信ネットワーク・トラフィックを、バックエンド・アプリが listen する別のパスにルーティングします。|
|[Cookie によるセッション・アフィニティー](#sticky_cookie)|スティッキー Cookie を使用して、着信ネットワーク・トラフィックを常に同じアップストリーム・サーバーにルーティングします。|
|[クライアント要求またはクライアント応答の追加ヘッダー](#add_header)|クライアント要求をバックエンド・アプリに転送する前に要求にヘッダー情報を追加します。または、クライアントに応答を送信する前に応答にヘッダー情報を追加します。|
|[クライアント応答ヘッダーの削除](#remove_response_headers)|クライアント応答をクライアントに転送する前に、応答からヘッダー情報を削除します。|
|[HTTPS への HTTP リダイレクト](#redirect_http_to_https)|ドメイン上の非セキュアな HTTP 要求を HTTPS にリダイレクトします。|
|[クライアント応答データのバッファリング](#response_buffer)|クライアントに応答を送信する間、Ingress コントローラーでのクライアント応答バッファリングを無効にします。|
|[接続タイムアウトおよび読み取りタイムアウトのカスタマイズ](#timeout)|バックエンド・アプリを使用不可と見なすまで、バックエンド・アプリへの接続およびバックエンド・アプリからの読み取りを Ingress コントローラーが待機する時間を調整します。|
|[クライアント要求本体の最大サイズのカスタマイズ](#client_max_body_size)|Ingress コントローラーに送信可能なクライアント要求本体のサイズを調整します。|

##### **再書き込みを使用して着信ネットワーク・トラフィックを別のパスにルーティングする**
{: #rewrite}

再書き込みアノテーションを使用して、Ingress コントローラー・ドメイン・パスへの着信ネットワーク・トラフィックを、バックエンド・アプリケーションが listen する別のパスにルーティングできます。{:shortdesc}

<dl>
<dt>説明</dt>
<dd>Ingress コントローラー・ドメインは、<code>mykubecluster.us-south.containers.mybluemix.net/beans</code> への着信ネットワーク・トラフィックをアプリにルーティングします。アプリは、<code>/beans</code> ではなく <code>/coffee</code> で listen します。着信ネットワーク・トラフィックをアプリに転送するには、<code>/beans</code> への着信ネットワーク・トラフィックが <code>/coffee</code> パスを使用してアプリに転送されるように、Ingress リソース構成ファイルに再書き込みアノテーションを追加します。複数のサービスを含める場合は、セミコロン (;) のみを使用して区切ってください。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;rewrite_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;rewrite_path2&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td><em>&lt;service_name&gt;</em> を、アプリ用に作成した Kubernetes サービスの名前に置き換えます。さらに、<em>&lt;rewrite-path&gt;</em> を、アプリが listen するパスに置き換えます。
Ingress コントローラー・ドメイン上の着信ネットワーク・トラフィックは、このパスを使用して Kubernetes サービスに転送されます。
大多数のアプリは特定のパスで listen するのではなく、ルート・パスと特定のポートを使用します。
この場合は、<code>/</code> をアプリの <em>&lt;rewrite-path&gt;</em> として定義します。
</td>
</tr>
<tr>
<td><code>path</code></td>
<td><em>&lt;domain_path&gt;</em> を、Ingress コントローラー・ドメインに付加するパスに置き換えます。このパス上の着信ネットワーク・トラフィックは、アノテーションで定義した再書き込みパスに転送されます。
上記の例では、ドメイン・パスを <code>/beans</code> に設定して、このパスを Ingress コントローラーのロード・バランシングに含めます。</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td><em>&lt;service_name&gt;</em> を、アプリ用に作成した Kubernetes サービスの名前に置き換えます。
ここで使用するサービス名は、アノテーションで定義したものと同じ名前でなければなりません。
</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td><em>&lt;service_port&gt;</em> を、サービスが listen するポートに置き換えます。</td>
</tr></tbody></table>

</dd></dl>


##### **スティッキー Cookie を使用して、着信ネットワーク・トラフィックを常に同じアップストリーム・サーバーにルーティングする**
{: #sticky_cookie}

スティッキー Cookie のアノテーションを使用して、セッション・アフィニティーを Ingress コントローラーに追加できます。{:shortdesc}

<dl>
<dt>説明</dt>
<dd>アプリのセットアップによっては、着信クライアント要求を処理する複数のアップストリーム・サーバーをデプロイして可用性を高める必要がある場合があります。一般には、クライアントがバックエンド・アプリに接続したら、セッションが継続している間は、またはタスクが完了するまでの間は、同じアップストリーム・サーバーがクライアントにサービスを提供することが有用です。着信ネットワーク・トラフィックを常に同じアップストリーム・サーバーにルーティングしてセッション・アフィニティーを保つように、Ingress コントローラーを構成することができます。</br>
バックエンド・アプリに接続した各クライアントは、Ingress コントローラーによって、使用可能なアップストリーム・サーバーのいずれかに割り当てられます。Ingress コントローラーが作成したセッション Cookie は、クライアントのアプリに格納され、Ingress コントローラーとクライアントの間でやり取りされるすべての要求のヘッダー情報に含められます。この Cookie の情報により、同一セッションのすべての要求を同じアップストリーム・サーバーで処理することができます。</br></br>
複数のサービスを含める場合は、セミコロン (;) を使用して区切ってください。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>表 12.  YAML ファイルの構成要素について</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul><li><code><em>&lt;service_name&gt;</em></code>: アプリ用に作成した Kubernetes サービスの名前。</li><li><code><em>&lt;cookie_name&gt;</em></code>: セッション中に作成されたスティッキー Cookie の名前を選択します。</li><li><code><em>&lt;expiration_time&gt;</em></code>: スティッキー Cookie の有効期間 (秒、分、または時間単位)。この時間は、ユーザー・アクティビティーとは無関係です。期限が切れた Cookie は、クライアント Web ブラウザーによって削除され、Ingress コントローラーに送信されなくなります。例えば、有効期間を 1 秒、1 分、または 1 時間に設定するには、<strong>1s</strong>、<strong>1m</strong>、または <strong>1h</strong> と入力します。</li><li><code><em>&lt;cookie_path&gt;</em></code>: Ingress サブドメインに付加されるパス。Cookie を Ingress コントローラーに送信するドメインとサブドメインを示します。例えば、Ingress ドメインが <code>www.myingress.com</code> である場合に、すべてのクライアント要求で Cookie を送信するには、<code>path=/</code> を設定する必要があります。<code>www.myingress.com/myapp</code> とそのすべてのサブドメインについてにのみ Cookie を送信するには、<code>path=/myapp</code> を設定する必要があります。</li><li><code><em>&lt;hash_algorithm&gt;</em></code>: Cookie の情報を保護するハッシュ・アルゴリズム。<code>sha1</code> のみサポートされます。SHA1 は、Cookie の情報に基づいてハッシュ合計を生成し、そのハッシュ合計を Cookie に付加します。サーバーは Cookie の情報を暗号化解除し、データ保全性を検証します。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **クライアント要求またはクライアント応答にカスタム HTTP ヘッダーを追加する**
{: #add_header}

このアノテーションを使用すると、クライアント要求をバックエンド・アプリに転送する前に要求にヘッダー情報を追加したり、クライアントに応答を送信する前に応答にヘッダー情報を追加したりできます。{:shortdesc}

<dl>
<dt>説明</dt>
<dd>Ingress コントローラーは、クライアント・アプリとバックエンド・アプリの間のプロキシーとして機能します。Ingress コントローラーに送信されたクライアント要求は、処理 (プロキシー処理) され、新しい要求に入れられた後に、Ingress コントローラーからバックエンド・アプリに送信されます。クライアントから最初に送信された HTTP ヘッダー情報 (ユーザー名など) は、要求のプロキシー処理で削除されます。そのような情報がバックエンド・アプリに必要な場合は、<strong>ingress.bluemix.net/proxy-add-headers</strong> アノテーションを使用して、Ingress コントローラーからバックエンド・アプリにクライアント要求を転送する前に、ヘッダー情報を要求に追加することができます。</br></br>
バックエンド・アプリが応答をクライアントに送信する場合は、応答が Ingress コントローラーによってプロキシー処理され、HTTP ヘッダーが応答から削除されます。クライアント Web アプリで応答を正常に処理するために、このヘッダー情報が必要になる場合があります。<strong>ingress.bluemix.net/response-add-headers</strong> アノテーションを使用すると、Ingress コントローラーからクライアント Web アプリにクライアント応答を転送する前に、ヘッダー情報を応答に追加することができます。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul><li><code><em>&lt;service_name&gt;</em></code>: アプリ用に作成した Kubernetes サービスの名前。</li><li><code><em>&lt;header&gt;</em></code>: クライアント要求またはクライアント応答に追加するヘッダー情報のキー。</li><li><code><em>&lt;value&gt;</em></code>: クライアント要求またはクライアント応答に追加するヘッダー情報の値。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **クライアントの応答から HTTP ヘッダー情報を削除する**
{: #remove_response_headers}

このアノテーションを使用すると、バックエンド・アプリからのクライアント応答に含まれているヘッダー情報を削除してから、クライアントに応答を送信できます。{:shortdesc}

<dl>
<dt>説明</dt>
<dd>Ingress コントローラーは、バックエンド・アプリとクライアント Web ブラウザーの間のプロキシーとして機能します。Ingress コントローラーに送信されたバックエンド・アプリからのクライアント応答は、処理 (プロキシー処理) され、新しい応答に入れられた後に、Ingress コントローラーからクライアント Web ブラウザーに送信されます。応答のプロキシー処理によって、バックエンド・アプリから最初に送信された HTTP ヘッダー情報は削除されますが、バックエンド・アプリに固有のヘッダーが削除されずに残る場合があります。このアノテーションを使用すると、Ingress コントローラーからクライアント Web ブラウザーにクライアント応答を転送する前に、応答からヘッダー情報を削除することができます。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
      }
      serviceName=&lt;service_name2&gt; {
      "&lt;header3&gt;";
      }
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul><li><code><em>&lt;service_name&gt;</em></code>: アプリ用に作成した Kubernetes サービスの名前。</li><li><code><em>&lt;header&gt;</em></code>: クライアント応答から削除するヘッダーのキー。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **非セキュアな HTTP クライアント要求を HTTPS にリダイレクトする**
{: #redirect_http_to_https}

リダイレクト・アノテーションを使用すると、非セキュアな HTTP クライアント要求を HTTPS に変換できます。{:shortdesc}

<dl>
<dt>説明</dt>
<dd>Ingress コントローラーは、IBM 提供の TLS 証明書またはカスタム TLS 証明書を使用してドメインを保護するようにセットアップされます。一部のユーザーが、Ingress コントローラー・ドメインへの非セキュアな HTTP 要求、例えば、<code>https</code> ではなく <code>http://www.myingress.com</code> を使用してアプリにアクセスしようとする可能性があります。リダイレクト・アノテーションを使用すると、非セキュアな HTTP 要求を常に HTTPS に変換できます。このアノテーションを使用しない場合、デフォルトでは非セキュアな HTTP 要求は HTTPS 要求に変換されないので、機密情報が暗号化されずに公開されるおそれがあります。</br></br>
HTTP 要求の HTTPS へのリダイレクトはデフォルトで無効です。</dd>
<dt>サンプル Ingress リソース YAML</dt>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/redirect-to-https: "True"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

##### **Ingress コントローラーでのバックエンド応答のバッファリングを無効にする**
{: #response_buffer}

バッファー・アノテーションを使用すると、クライアントにデータを送信する間、Ingress コントローラーでの応答データの保存を無効にできます。{:shortdesc}

<dl>
<dt>説明</dt>
<dd>Ingress コントローラーは、バックエンド・アプリとクライアント Web ブラウザーの間のプロキシーとして機能します。応答がバックエンド・アプリからクライアントに送信されると、デフォルトでは、応答データが Ingress コントローラーのバッファーに入れられます。Ingress コントローラーは、クライアント応答をプロキシー処理し、クライアントのペースでクライアントに応答を送信し始めます。バックエンド・アプリからのすべてのデータを Ingress コントローラーが受信すると、バックエンド・アプリへの接続は閉じられます。Ingress コントローラーからクライアントへの接続は、クライアントがすべてのデータを受信するまで開かれたままです。</br></br>
Ingress コントローラーでの応答データのバッファリングを無効にすると、データは即時に Ingress コントローラーからクライアントに送信されます。クライアントが、Ingress コントローラーのペースで着信データを処理できなければなりません。クライアントの処理速度が遅すぎる場合は、データが失われる可能性があります。</br></br>
Ingress コントローラーでの応答データのバッファリングは、デフォルトでは有効です。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-buffering: "False"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>


##### **Ingress コントローラーの接続タイムアウトおよび読み取りタイムアウトをカスタマイズする**
{: #timeout}

バックエンド・アプリを使用不可と見なすまでに、バックエンド・アプリへの接続およびバックエンド・アプリからの読み取りを Ingress コントローラーが待機する時間を調整します。{:shortdesc}

<dl>
<dt>説明</dt>
<dd>クライアント要求が Ingress コントローラーに送信されると、Ingress コントローラーはバックエンド・アプリへの接続を開きます。デフォルトでは、Ingress コントローラーはバックエンド・アプリからの応答を受信するまで 60 秒待機します。バックエンド・アプリが 60 秒以内に応答しない場合は、接続要求が中止され、バックエンド・アプリは使用不可と見なされます。</br></br>
バックエンド・アプリに接続した Ingress コントローラーは、バックエンド・アプリからの応答データを読み取ります。この読み取り操作では、Ingress コントローラーはバックエンド・アプリからのデータを受け取るために、2 回の読み取り操作の間に最大 60 秒間待機します。バックエンド・アプリが 60 秒以内にデータを送信しない場合、バックエンド・アプリへの接続が閉じられ、アプリは使用不可と見なされます。</br></br>
60 秒の接続タイムアウトと読み取りタイムアウトは、プロキシーのデフォルトのタイムアウトであり、変更しないのが理想的です。</br></br>
アプリの可用性が安定していない場合や、ワークロードが多いためにアプリの応答が遅い場合は、接続タイムアウトまたは読み取りタイムアウトを引き上げることもできます。タイムアウトを引き上げると、タイムアウトになるまでバックエンド・アプリへの接続を開いている必要があるため、Ingress コントローラーのパフォーマンスに影響が及ぶことに注意してください。</br></br>
一方、タイムアウトを下げると、Ingress コントローラーのパフォーマンスは向上します。ワークロードが多いときでも、指定したタイムアウト内でバックエンド・アプリが要求を処理できるようにしてください。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: バックエンド・アプリへの接続で待機する秒数を入力します (例: <strong>65s</strong>)。</br></br>
  <strong>注:</strong> 接続タイムアウトは、75 秒より長くできません。</li><li><code><em>&lt;read_timeout&gt;</em></code>: バックエンド・アプリからの読み取りで待機する秒数を入力します (例: <strong>65s</strong>)。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **クライアント要求本体の最大許容サイズを設定する**
{: #client_max_body_size}

このアノテーションを使用すると、クライアントが要求の一部として送信できる本体のサイズを調整できます。
{:shortdesc}

<dl>
<dt>説明</dt>
<dd>必要なパフォーマンスを維持するため、クライアント要求本体の最大サイズは 1 M バイトに設定されています。この制限を超える本体サイズのクライアント要求が Ingress コントローラーに送信された場合、データを複数のチャンクに分割することをクライアントが許可していなければ、Ingress コントローラーは http 応答 413 (要求エンティティーが大きすぎます (Request Entity Too Large)) をクライアントに戻します。要求本体のサイズが小さくなるまで、クライアントと Ingress コントローラーの間の接続は確立されません。データを複数のチャンクに分割することをクライアントが許可した場合は、データが 1 M バイトの複数のパッケージに分割されて、Ingress コントローラーに送信されます。</br></br>
本体サイズが 1 M バイトを超えるクライアント要求が想定されるために、最大本体サイズを引き上げたい場合があります。例えば、クライアントが大きなファイルをアップロードできるようにしたい場合があります。要求本体の最大サイズを引き上げると、要求を受信するまでクライアントへの接続を開いておかなければならないため、Ingress コントローラーのパフォーマンスに影響を及ぼす可能性があります。</br></br>
<strong>注:</strong> 一部のクライアント Web ブラウザーは、http 応答 413 のメッセージを正しく表示できません。</dd>
<dt>サンプル Ingress リソース YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
annotations:
    ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
spec:
tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>以下の値を置き換えます。<ul><li><code><em>&lt;size&gt;</em></code>: クライアント応答本体の最大サイズを入力します。例えば、200 M バイトに設定するには、<strong>200m</strong> と定義します。</br></br>
  <strong>注:</strong> サイズを 0 に設定すると、クライアント要求の本体サイズの検査を無効にすることができます。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


## IP アドレスとサブネットの管理
{: #cs_cluster_ip_subnet}

ポータブル・パブリック・サブネットと IP アドレスを使用して、クラスター内のアプリを公開し、インターネットからアクセスできるようにすることができます。{:shortdesc}

{{site.data.keyword.containershort_notm}} では、クラスターにネットワーク・サブネットを追加して、Kubernetes サービス用の安定したポータブル IP を追加できます。
標準クラスターを作成すると、{{site.data.keyword.containershort_notm}} は、ポータブル・パブリック・サブネット 1 つと IP アドレス 5 つを自動的にプロビジョンします。
ポータブル・パブリック IP アドレスは静的で、ワーカー・ノードまたはクラスターが削除されても変更されません。

1 つのポータブル・パブリック IP アドレスは、[Ingress コントローラー](#cs_apps_public_ingress)用に使用されます。このコントローラーは、パブリック経路を使用してクラスター内の複数のアプリを公開するために使用できます。残りの 4 つのポータブル・パブリック IP アドレスは、[ロード・バランサー・サービスを作成して](#cs_apps_public_load_balancer)単一アプリをパブリックに公開するために使用できます。

**注:** ポータブル IP アドレスは、月単位で課金されます。クラスターのプロビジョンの後にポータブル・パブリック IP アドレスを削除する場合、短時間しか使用しない場合でも月額課金を支払う必要があります。




1.  `myservice.yaml` という Kubernetes サービス構成スクリプトを作成します。このスクリプトでは、ダミーのロード・バランサー IP アドレスを使用して `LoadBalancer` タイプのサービスを定義します。以下の例では、ロード・バランサー IP アドレスとして IP アドレス 1.1.1.1 を使用します。



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
kubectl apply -f myservice.yaml```
    {: pre}

3.  サービスを検査します。

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **注:** Kubernetes マスターが、指定のロード・バランサー IP アドレスを Kubernetes config マップで見つけることができないため、このサービスの作成は失敗します。このコマンドを実行すると、エラー・メッセージと、クラスターで使用可能なパブリック IP アドレスのリストが表示されます。


    ```
Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

</staging>
  
  ### 使用されているパブリック IP アドレスの解放
{: #freeup_ip}

ポータブル・パブリック IP アドレスを使用しているロード・バランサー・サービスを削除することによって、使用されているポータブル・パブリック IP アドレスを解放できます。

[始めに、使用するクラスターのコンテキストを設定してください。
](cs_cli_install.html#cs_cli_configure)

1.  クラスターで使用可能なサービスをリスト表示します。

    ```
kubectl get services```
    {: pre}

2.  パブリック IP アドレスを使用しているロード・バランサー・サービスを削除します。

    ```
    kubectl delete service <myservice>
    ```
    {: pre}


## GUI でアプリをデプロイする方法
{: #cs_apps_ui}

Kubernetes ダッシュボードを使用してアプリをクラスターにデプロイすると、クラスター内でポッドを作成、更新、および管理するためのデプロイメントが自動的に作成されます。
{:shortdesc}

開始前に、以下のことを行います。

-   必要な [CLI](cs_cli_install.html#cs_cli_install) をインストールします。

-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。


アプリをデプロイするには、以下の手順で行います。

1.  [Kubernetes ダッシュボードを開きます](#cs_cli_dashboard)。
2.  Kubernetes ダッシュボードで**「+ 作成」**をクリックします。

3.  **「ここでアプリの詳細情報を指定する (Specify app details below)」**を選択してアプリの詳細情報を GUI で入力するか、**「YAML ファイルまたは JSON ファイルをアップロードする (Upload a YAML or JSON file)」**を選択してアプリの[構成ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) をアップロードします。[このサンプル YAML ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) を使用して米国南部地域の **ibmliberty** イメージからコンテナーをデプロイします。
4.  Kubernetes ダッシュボードで**「デプロイメント」**をクリックして、デプロイメントが作成されたことを確認します。

5.  ノード・ポート・サービス、ロード・バランサー・サービス、または Ingress を使用して、アプリをだれでも利用できるようにした場合は、[アプリにアクセスできることを確認します](#cs_apps_public)。

## CLI でアプリをデプロイする方法
{: #cs_apps_cli}

クラスターを作成したら、Kubernetes CLI を使用してそのクラスターにアプリをデプロイできます。{:shortdesc}

開始前に、以下のことを行います。

-   必要な [CLI](cs_cli_install.html#cs_cli_install) をインストールします。

-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。


アプリをデプロイするには、以下の手順で行います。

1.  [Kubernetes のベスト・プラクティス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/overview/) に基づいて構成スクリプトを作成します。基本的に、構成スクリプトには、Kubernetes で作成する各リソースの構成の詳細情報が格納されます。
スクリプトに以下のセクションを 1 つ以上追加できます。

    -   [Deployment ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): ポッドとレプリカ・セットの作成を定義します。1 つのポッドにコンテナー化アプリを 1 つ組み込み、レプリカ・セットによってポッドの複数インスタンスを制御します。


    -   [Service ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/): ワーカー・ノードまたはロード・バランサーのパブリック IP アドレス、あるいは Ingress のパブリック経路を使用して、ポッドへのフロントエンド・アクセスを提供します。

    -   [Ingress ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/ingress/): アプリをだれでも利用できるようにする経路を提供するロード・バランサーのタイプを指定します。

2.  クラスターのコンテキストで構成スクリプトを実行します。


    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  ノード・ポート・サービス、ロード・バランサー・サービス、または Ingress を使用して、アプリをだれでも利用できるようにした場合は、[アプリにアクセスできることを確認します](#cs_apps_public)。



## ローリング・デプロイメントの管理
{: #cs_apps_rolling}

変更のロールアウトを自動化され制御された方法で管理できます。ロールアウトがプランに従ったものでない場合、デプロイメントを以前のリビジョンにロールバックできます。
{:shortdesc}

開始する前に、[デプロイメント](#cs_apps_cli)を作成します。

1.  変更を[ロールアウト ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) します。例えば、初期デプロイメントで使用したイメージを変更することができます。

    1.  デプロイメント名を取得します。

        ```
kubectl get deployments```
        {: pre}

    2.  ポッド名を取得します。

        ```
kubectl get pods```
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

    2.  以前のバージョンにロールバックするか、またはリビジョンを指定します。以前のバージョンにロールバックするには、次のコマンドを使用します。


        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

## {{site.data.keyword.Bluemix_notm}} サービスの追加
{: #cs_apps_service}

暗号化した Kubernetes シークレットを使用して、{{site.data.keyword.Bluemix_notm}} サービスの詳細情報や資格情報を保管し、サービスとクラスターの間のセキュアな通信を確保します。
クラスター・ユーザーがそのシークレットにアクセスするには、そのシークレットをボリュームとしてポッドにマウントする必要があります。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。アプリで使用する {{site.data.keyword.Bluemix_notm}} サービスが、クラスター管理者によって[クラスターに追加されていること](cs_cluster.html#cs_cluster_service)を確認してください。


Kubernetes シークレットは、機密情報 (ユーザー名、パスワード、鍵など) を安全に保管するための手段です。
機密情報を環境変数として公開したり、Dockerfile に直接書き込んだりする代わりに、シークレットをシークレット・ボリュームとしてポッドにマウントする必要があります。
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

2.  **Opaque** タイプのシークレットを探して、そのシークレットの **NAME** を書き留めます。
複数のシークレットが存在する場合は、クラスター管理者に連絡して、サービスに対応する正しいシークレットを確認してください。


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
    <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>コンテナーにマウントするシークレット・ボリュームの名前。
</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>コンテナーにマウントするシークレット・ボリュームの名前を入力します。
</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>サービスのシークレットに対する読み取り専用アクセス権を設定します。
</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>先ほど書き留めたシークレットの名前を入力します。
</td>
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

{{site.data.keyword.Bluemix_notm}} サービスの詳細情報や資格情報にアクセスできるようになりました。
{{site.data.keyword.Bluemix_notm}} サービスを利用するために、マウント・ディレクトリーでサービスのシークレット・ファイルを見つけ、JSON コンテンツを解析してサービスの詳細情報を判別できるようにアプリを構成してください。


## 永続ストレージの作成
{: #cs_apps_volume_claim}

NFS ファイル・ストレージをクラスターにプロビジョンするために、永続ボリューム請求を作成します。この請求をポッドにマウントすることで、ポッドがクラッシュしたりシャットダウンしたりしてもデータを利用できるようにします。{:shortdesc}

永続ボリュームの基礎の NFS ファイル・ストレージは、データの高可用性を実現するために IBM がクラスター化しています。

1.  使用可能なストレージ・クラスを確認します。{{site.data.keyword.containerlong}} には事前定義のストレージ・クラスが 3 つ用意されているので、クラスター管理者がストレージ・クラスを作成する必要はありません。


    ```
kubectl get storageclasses```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  ストレージ・クラスの IOPS または使用可能なサイズを確認します。


    ```
kubectl describe storageclasses ibmc-file-silver```
    {: pre}

    **「Parameters」**フィールドで、ストレージ・クラスに関連した 1 GB あたりの IOPS と使用可能なサイズ (ギガバイト単位) を確認できます。


    ```
Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi```
    {: screen}

3.  任意のテキスト・エディターで、永続ボリューム請求を定義した構成スクリプトを作成し、`.yaml` ファイルとして構成を保存します。

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

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>永続ボリューム請求の名前を入力します。</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>永続ボリュームのホスト・ファイル共有の 1 GB あたりの IOPS を定義するストレージ・クラスを指定します。<ul><li>ibmc-file-bronze: 1 GB あたり 2 IOPS。</li><li>ibmc-file-silver: 1 GB あたり 4 IOPS。</li><li>ibmc-file-gold: 1 GB あたり 10 IOPS。</li>

    </li> ストレージ・クラスを指定しなかった場合は、ブロンズ・ストレージ・クラスを使用して永続ボリュームが作成されます。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td> リストされているもの以外のサイズを選択した場合、サイズは切り上げられます。最大サイズより大きいサイズを選択した場合、サイズは切り下げられます。
</td>
    </tr>
    </tbody></table>

4.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

5.  永続ボリューム請求が作成され、永続ボリュームにバインドされたことを確認します。この処理には数分かかる場合があります。


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

6.  {: #cs_apps_volume_mount}永続ボリューム請求をポッドにマウントするには、構成スクリプトを作成します。構成を `.yaml` ファイルとして保存します。


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
    <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>ポッドの名前。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>コンテナー内でボリュームがマウントされるディレクトリーの絶対パス。
</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>コンテナーにマウントするボリュームの名前。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>コンテナーにマウントするボリュームの名前。通常、この名前は <code>volumeMounts/name</code> と同じです。
</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>ボリュームとして使用する永続ボリューム請求の名前。ボリュームをポッドにマウントすると、Kubernetes は永続ボリューム請求にバインドされた永続ボリュームを識別して、その永続ボリュームでユーザーが読み取り/書き込みを行えるようにします。
</td>
    </tr>
    </tbody></table>

7.  ポッドを作成して、永続ボリューム請求をポッドにマウントします。


    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

8.  ボリュームがポッドに正常にマウントされたことを確認します。


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

## 永続ストレージに対する非 root ユーザーのアクセス権限の追加
{: #cs_apps_volumes_nonroot}

非 root ユーザーには、NFS ベースのストレージのボリューム・マウント・パスに対する書き込み権限がありません。書き込み権限を付与するには、イメージの Dockerfile を編集して、適切な権限を設定したディレクトリーをマウント・パス上に作成する必要があります。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

非 root ユーザーを使用するアプリを設計していて、そのユーザーにボリュームに対する書き込み権限が必要な場合は、Dockerfile とエントリー・ポイント・スクリプトに次の処理を追加する必要があります。

-   非 root ユーザーを作成する。
-   そのユーザーを一時的に root グループに追加する。
-   ボリューム・マウント・パスにディレクトリーを作成して、適切なユーザー権限を設定する。


{{site.data.keyword.containershort_notm}} の場合、ボリューム・マウント・パスのデフォルト所有者は、所有者 `nobody` です。NFS ストレージを使用する場合は、所有者がポッドのローカルに存在しなければ、`nobody` ユーザーが作成されます。ボリュームは、コンテナー内の root ユーザーを認識するようにセットアップされます。一部のアプリでは、このユーザーがコンテナー内の唯一のユーザーです。しかし、多くのアプリでは、コンテナー・マウント・パスへの書き込みを行う `nobody` 以外の非 root ユーザーを指定します。

1.  ローカル・ディレクトリーに Dockerfile を作成します。
この Dockerfile 例では、`myguest` という非 root ユーザーを作成します。


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

2.  Dockerfile と同じローカル・フォルダーに、エントリー・ポイント・スクリプトを作成します。
このエントリー・ポイント・スクリプト例では、ボリューム・マウント・パスとして `/mnt/myvol` を指定します。


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
tail -F /dev/null```
    {: codeblock}

3.  {{site.data.keyword.registryshort_notm}} にログインします。

    ```
bx cr login```
    {: pre}

4.  イメージをローカルにビルドします。_&lt;my_namespace&gt;_ を、プライベート・イメージ・レジストリーの名前空間に必ず置き換えてください。名前空間を調べる必要がある場合は、`bx cr namespace-get` を実行します。

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  {{site.data.keyword.registryshort_notm}} 内の名前空間にイメージをプッシュします。


    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  `.yaml` 構成ファイルを作成して、永続ボリューム請求を作成します。この例では、パフォーマンスがやや低いストレージ・クラスを使用しています。使用可能なストレージ・クラスを表示するには、`kubectl get storageclasses` を実行してください。

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

8.  ボリュームをマウントし、非 root イメージからポッドを実行するように構成スクリプトを作成します。
ボリューム・マウント・パス `/mnt/myvol` は、Dockerfile で指定されたマウント・パスと一致します。構成を `.yaml` ファイルとして保存します。


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
drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata```
    {: screen}

    この出力が示すように、root にはボリューム・マウント・パス `mnt/myvol/` に対する読み取り/書き込み/実行権限があり、非 root の myguest ユーザーには、`mnt/myvol/mydata` フォルダーに対する読み取り/書き込み権限があります。このように権限が更新されたことにより、非 root ユーザーは永続ボリュームにデータを書き込めるようになりました。



