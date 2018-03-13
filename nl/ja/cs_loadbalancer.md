---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-06"

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

ポートを公開し、ロード・バランサーのポータブル IP アドレスを使用してアプリにアクセスします。 パブリック IP アドレスを使用してアプリをインターネットでアクセスできるようにするか、プライベート IP アドレスを使用して、アプリをプライベート・インフラストラクチャー・ネットワークでアクセスできるようにします。
{:shortdesc}



## ロード・バランサー・タイプのサービスを使用してアプリへのアクセスを構成する方法
{: #config}

NodePort サービスの場合とは異なり、ロード・バランサー・サービスのポータブル IP アドレスは、アプリのデプロイ先のワーカー・ノードに依存していません。 ただし、Kubernetes LoadBalancer サービスは NodePort サービスでもあります。 LoadBalancer サービスにより、ロード・バランサーの IP アドレスとポート上でアプリが利用可能になり、サービスのノード・ポート上でアプリが利用可能になります。
{:shortdesc}

ロード・バランサーのポータブル・パブリック IP アドレスは自動的に割り当てられ、ワーカー・ノードを追加または削除しても変わりません。 そのため、NodePort サービスよりロード・バランサー・サービスのほうが可用性が高くなります。 ユーザーは、ロード・バランサーのポートとしてどのポートでも選択できます。NodePort の場合のポート範囲には限定されません。 ロード・バランサー・サービスは、TCP プロトコルと UDP プロトコルの場合に使用できます。

**注:** LoadBalancer サービスは TLS 終端をサポートしていません。アプリで TLS 終端が必要な場合は、[Ingress](cs_ingress.html) を使用してアプリを公開するか、または TLS 終端を管理するようにアプリを構成することができます。

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
          <td>LoadBalancer のタイプを指定するアノテーション。 値は `private` と `public` です。 パブリック VLAN 上のクラスターにパブリック LoadBalancer を作成するときには、このアノテーションは必要ありません。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>プライベート LoadBalancer を作成するとき、またはパブリック LoadBalancer 用に特定のポータブル IP アドレスを使用するときには、<em>&lt;loadBalancerIP&gt;</em> を、使用する IP アドレスに置き換えます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer) を参照してください。</td>
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
