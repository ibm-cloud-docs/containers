---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# ロード・バランサーのサービスのセットアップ
{: #loadbalancer}

ポートを公開し、ロード・バランサーのポータブル IP アドレスを使用してコンテナー化アプリにアクセスします。
{:shortdesc}

## LoadBalancer サービスを使用した外部ネットワーキングの計画
{: #planning}

標準クラスターを作成する時、{{site.data.keyword.containershort_notm}} は自動的に 5 つのポータブル・パブリック IP アドレスと 5 つのポータブル・プライベート IP アドレスを要求し、クラスター作成時にそれらをお客様の IBM Cloud インフラストラクチャー (SoftLayer) アカウントにプロビジョンします。 ポータブル IP アドレスのうちの 2 つ (パブリック 1 つとプライベート 1 つ) は、[Ingress アプリケーション・ロード・バランサー](cs_ingress.html#planning)用として使用されます。 4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスは、LoadBalancer サービスを作成してアプリを公開するために使用できます。

パブリック VLAN のクラスター内に Kubernetes LoadBalancer サービスを作成する時、外部ロード・バランサーが 1 つ作成されます。 LoadBalancer サービスを作成するときには、IP アドレスに関して以下のオプションがあります。

- クラスターがパブリック VLAN 上にある場合、使用可能な 4 つのポータブル・パブリック IP アドレスのいずれかが使用されます。
- クラスターがプライベート VLAN 上にしかない場合、使用可能な 4 つのポータブル・プライベート IP アドレスのいずれかが使用されます。
- 構成ファイルに次のアノテーションを追加することにより、LoadBalancer サービス用にポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスを要求できます: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.

LoadBalancer サービスに割り当てられるポータブル・パブリック IP アドレスは永続的なものであり、ワーカー・ノードが削除されたり再作成されたりしても変更されません。 したがって、LoadBalancer サービスの可用性は NodePort サービスより高くなります。 NodePort サービスの場合と異なり、任意のポートをロード・バランサーに割り当て可能で、特定のポート範囲に縛られません。 LoadBalancer サービスを使用する場合、あらゆるワーカー・ノードの各 IP アドレスでノード・ポートを使用することもできます。 LoadBalancer サービスを使用しているときにノード・ポートへのアクセスをブロックするには、[着信トラフィックのブロック](cs_network_policy.html#block_ingress)を参照してください。

LoadBalancer サービスは、アプリに対する着信要求のための外部エントリー・ポイントとして機能します。 インターネットから LoadBalancer サービスにアクセスするには、ロード・バランサーのパブリック IP アドレスと割り当てられたポートを、`<ip_address>:<port>` という形式で使用します。 次の図は、ロード・バランサーがインターネットからアプリへの通信をどのように誘導するかを示しています。

<img src="images/cs_loadbalancer_planning.png" width="550" alt="ロード・バランサーを使用した {{site.data.keyword.containershort_notm}} でのアプリの公開" style="width:550px; border-style: none"/>

1. ロード・バランサーのパブリック IP アドレスとワーカー・ノード上の割り当てられたポートを使用して、要求がアプリに送信されます。

2. 要求が、ロード・バランサー・サービスの内部クラスター IP アドレスとポートに自動的に転送されます。内部クラスター IP アドレスはクラスター内でのみアクセス可能です。

3. `kube-proxy` が、要求をアプリの Kubernetes ロード・バランサー・サービスにルーティングします。

4. 要求が、アプリがデプロイされたポッドのプライベート IP アドレスに転送されます。複数のアプリ・インスタンスがクラスターにデプロイされている場合、ロード・バランサーは、アプリ・ポッド間で要求をルーティングします。




<br />




## ロード・バランサーを使用したアプリへのアクセスの構成
{: #config}

開始前に、以下のことを行います。

-   このフィーチャーを使用できるのは、標準クラスターの場合に限られます。
-   ロード・バランサー・サービスに割り当てることのできるポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスが必要です。
-   ポータブル・プライベート IP アドレスを使用するロード・バランサー・サービスでは、すべてのワーカー・ノードでパブリック・ノード・ポートも開いています。 パブリック・トラフィックを回避するためのネットワーク・ポリシーを追加する方法については、[着信トラフィックのブロック](cs_network_policy.html#block_ingress)を参照してください。

ロード・バランサー・サービスを作成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](cs_app.html#app_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドをロード・バランシングに含めるためにそれらのポッドを識別する上で必要です。
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
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>LoadBalancer サービス・ファイルの構成要素について</caption>
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
          <td>LoadBalancer のタイプを指定するアノテーション。 値は `private` と `public` です。 パブリック VLAN 上のクラスターにパブリック LoadBalancer を作成する場合には、このアノテーションは必要ありません。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>プライベート LoadBalancer を作成するには、またはパブリック LoadBalancer 用に特定のポータブル IP アドレスを使用するには、<em>&lt;loadBalancerIP&gt;</em> を、使用する IP アドレスに置き換えます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer) を参照してください。</td>
        </tr>
        </tbody></table>

    3.  オプション: spec セクションに `loadBalancerSourceRanges` を指定してファイアウォールを構成します。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

    4.  クラスター内にサービスを作成します。

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
    Location:               dal10
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----			-------------	--------	------			-------
      10s		10s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
      10s		10s		1	{service-controller }			Normal		CreatedLoadBalancer	Created load balancer
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
