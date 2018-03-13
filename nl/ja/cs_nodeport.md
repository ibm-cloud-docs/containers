---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# NodePort サービスのセットアップ
{: #nodeport}

クラスター内のいずれかのワーカー・ノードのパブリック IP アドレスを使用し、ノード・ポートを公開することによって、アプリをインターネットで利用できるようにします。 このオプションは、テストの場合や短期間のパブリック・アクセスを許可する場合に使用してください。
{:shortdesc}

## NodePort タイプのサービスを使用してアプリへのパブリック・アクセスを構成する方法
{: #config}

フリー・クラスターでも標準クラスターでも、アプリは Kubernetes NodePort サービスとして公開できます。
{:shortdesc}

**注:** ワーカー・ノードのパブリック IP アドレスは永続的なアドレスではありません。 ワーカー・ノードを再作成しなければならない場合は、新しいパブリック IP アドレスがワーカー・ノードに割り当てられます。 安定的なパブリック IP アドレスによってサービスの可用性を高める必要がある場合は、[LoadBalancer サービス](cs_loadbalancer.html)または [Ingress](cs_ingress.html) を使用してアプリを公開してください。

まだアプリの準備ができていない場合は、[Guestbook ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml) という名前の Kubernetes サンプル・アプリを使用できます。

1.  アプリの構成ファイルで、[service ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/) セクションを定義します。

    例:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <my-nodeport-service>
      labels:
        run: <my-demo>
    spec:
      selector:
        run: <my-demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>この YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> NodePort の service セクションの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td><code><em>&lt;my-nodeport-service&gt;</em></code> を NodePort サービスの名前に置き換えます。</td>
    </tr>
    <tr>
    <td><code>run</code></td>
    <td><code><em>&lt;my-demo&gt;</em></code> をデプロイメントの名前に置き換えます。</td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td><code><em>&lt;8081&gt;</em></code> を、サービスが listen するポートに置き換えます。 </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>オプション: <code><em>&lt;31514&gt;</em></code> を、30000 から 32767 の範囲の NodePort に置き換えます。 別のサービスで既に使用されている NodePort は指定しないでください。 NodePort を割り当てなければ、ランダムに割り当てられます。<br><br>NodePort を指定する時に使用中の NodePort を確認する場合は、以下のコマンドを実行できます。 <pre class="pre"><code>kubectl get svc</code></pre>使用中の NodePorts は、**Ports** フィールドの下に表示されます。</td>
     </tr>
     </tbody></table>


    Guestbook サンプルで、フロントエンド・サービス・セクションは構成ファイル内に既に存在しています。 Guestbook アプリを外部で使用できるようにするには、NodePort タイプと、30000 から 32767 の範囲の NodePort をフロントエンド・サービス・セクションに追加します。

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  更新された構成ファイルを保存します。

3.  インターネットに公開するアプリごとに、上記のステップを繰り返して NodePort サービスを作成します。

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
