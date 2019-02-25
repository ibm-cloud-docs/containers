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



# ロード・バランサーを使用してアプリを公開する
{: #loadbalancer}

ポートを公開し、レイヤー 4 のロード・バランサーのポータブル IP アドレスを使用してコンテナー化アプリにアクセスします。
{:shortdesc}

標準クラスターを作成すると、{{site.data.keyword.containerlong}} は、ポータブル・パブリック・サブネットとポータブル・プライベート・サブネットを自動的にプロビジョンします。

* ポータブル・パブリック・サブネットでは、5 つの IP アドレスを使用できます。 ポータブル・パブリック IP アドレスの 1 つは、デフォルトの[パブリック Ingress ALB](cs_ingress.html) に使用されます。 残りの 4 つのポータブル・パブリック IP アドレスは、パブリック・ロード・バランサー・サービスを作成して単一アプリをインターネットに公開するために使用できます。
* ポータブル・プライベート・サブネットでは、5 つの IP アドレスを使用できます。 ポータブル・プライベート IP アドレスの 1 つは、デフォルトの[プライベート Ingress ALB](cs_ingress.html#private_ingress) に使用されます。 残りの 4 つのポータブル・プライベート IP アドレスは、プライベート・ロード・バランサー・サービスを作成して単一アプリをプライベート・ネットワークに公開するために使用できます。

ポータブル・パブリック IP アドレスとポータブル・プライベート IP アドレスは静的浮動 IP であり、ワーカー・ノードが削除されても変わりません。 ロード・バランサー IP アドレスがオンになっているワーカー・ノードが削除されると、IP を常にモニターしている Keepalived デーモンが、IP を自動的に別のワーカー・ノードに移動します。 任意のポートをロード・バランサーに割り当て可能で、特定のポート範囲に縛られません。 ロード・バランサー・サービスは、アプリに対する着信要求のための外部エントリー・ポイントとして機能します。 インターネットからロード・バランサー・サービスにアクセスするには、ロード・バランサーのパブリック IP アドレスと割り当てられたポートを、`<IP_address>:<port>` という形式で使用します。

ロード・バランサー・サービスを使用してアプリを公開した場合、自動的にそのアプリはサービスの NodePort 経由でも使用できるようになります。 [NodePort](cs_nodeport.html) には、クラスター内のすべてのワーカー・ノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 ロード・バランサー・サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサーまたは NodePort サービスへのインバウンド・トラフィックの制御](cs_network_policy.html#block_ingress)を参照してください。

## ロード・バランサー 2.0 のコンポーネントとアーキテクチャー (ベータ)
{: #planning_ipvs}

ロード・バランサー 2.0 の機能はベータ版です。 バージョン 2.0 のロード・バランサーを使用するには、[クラスターのマスター・ノードとワーカー・ノードを更新](cs_cluster_update.html)して Kubernetes バージョン 1.12 以降にする必要があります。
{: note}

ロード・バランサー 2.0 はレイヤー 4 のロード・バランサーであり、Linux カーネルの IP Virtual Server (IPVS) を使用して実装されます。 ロード・バランサー 2.0 は TCP と UDP をサポートし、複数のワーカー・ノードの前で実行され、IP over IP (IPIP) トンネリングを使用して、単一のロード・バランサー IP アドレスに到着するトラフィックをそれらのワーカー・ノードに分散させます。

詳細については、ロード・バランサー 2.0 に関するこの[ブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/) で確認することもできます。

### バージョン 1.0 と 2.0 のロード・バランサーの類似点は何ですか?
{: #similarities}

バージョン 1.0 と 2.0 のロード・バランサーはどちらもレイヤー 4 のロード・バランサーであり、Linux カーネル・スペースでのみ動作します。 どちらのバージョンもクラスター内で実行され、ワーカー・ノードのリソースを使用します。 したがって、ロード・バランサーの対応能力は常にお客様のクラスターにのみ使用されます。 また、どちらのバージョンのロード・バランサーも接続を終了しません。 代わりに、アプリ・ポッドに接続を転送します。

### バージョン 1.0 と 2.0 のロード・バランサーの相違点は何ですか?
{: #differences}

クライアントがアプリに要求を送信すると、ロード・バランサーは、アプリ・ポッドが存在するワーカー・ノードの IP アドレスに要求パケットをルーティングします。 バージョン 1.0 のロード・バランサーは、ネットワーク・アドレス変換 (NAT) を使用して、要求パケットのソース IP アドレスを、ロード・バランサー・ポッドが存在するワーカー・ノードの IP に書き換えます。 ワーカー・ノードは、アプリの応答パケットを返すときに、そのロード・バランサーが存在するワーカー・ノードの IP を使用します。 そして、ロード・バランサーがクライアントに応答パケットを送信します。 IP アドレスの書き換えを回避するには、[ソース IP 保持を有効にします](#node_affinity_tolerations)。 ただし、ソース IP 保持を利用するには、要求を別のワーカーに転送しなくてもよいように、ロード・バランサー・ポッドとアプリ・ポッドを同じワーカー上で実行する必要があります。 ノードのアフィニティーと耐障害性をアプリ・ポッドに追加する必要があります。

バージョン 1.0 のロード・バランサーとは異なり、バージョン 2.0 のロード・バランサーは、他のワーカー上のアプリ・ポッドに要求を転送する際に NAT を使用しません。 ロード・バランサー 2.0 は、クライアント要求をルーティングするときに、IP over IP (IPIP) を使用して、元の要求パケットを別の新しいパケットに入れてカプセル化します。 このカプセル化された IPIP パケットには、ロード・バランサー・ポッドが存在するワーカー・ノードのソース IP が含まれているので、元の要求パケットはクライアント IP をそのソース IP アドレスとして保持できます。 そして、ワーカー・ノードは、直接サーバー・リターン (DSR) を使用して、アプリの応答パケットをクライアント IP に送信します。 応答パケットはロード・バランサーをスキップしてクライアントに直接送信されるので、ロード・バランサーが処理する必要のあるトラフィックの量が減少します。

### 単一ゾーン・クラスターでバージョン 2.0 のロード・バランサーを使用する場合、要求はどのようにアプリに到達するのですか?
{: #ipvs_single}

次の図は、ロード・バランサー 2.0 がインターネットから単一ゾーン・クラスターのアプリに通信を転送する方法を示しています。

<img src="images/cs_loadbalancer_ipvs_planning.png" width="550" alt="バージョン 2.0 のロード・バランサーを使用して {{site.data.keyword.containerlong_notm}} 内のアプリを公開する" style="width:550px; border-style: none"/>

1. アプリへのクライアント要求には、ロード・バランサーのパブリック IP アドレスと、ワーカー・ノードに割り当てられたポートが使用されます。 この例では、ロード・バランサーの仮想 IP アドレスは 169.61.23.130 であり、この仮想 IP アドレスは現在、ワーカー 10.73.14.25 上にあります。

2. ロード・バランサーが、クライアント要求パケット (図中の「CR」ラベルが付いたもの) を IPIP パケット (「IPIP」ラベルのもの) の中にカプセル化します。 クライアント要求パケットは、そのソース IP アドレスとしてクライアント IP を保持します。 IPIP カプセル化パケットは、そのソース IP アドレスとしてワーカーの 10.73.14.25 IP を使用します。

3. ロード・バランサーが、アプリ・ポッドがあるワーカー (10.73.14.26) に IPIP パケットをルーティングします。 複数のアプリ・インスタンスがクラスターにデプロイされている場合、ロード・バランサーはアプリ・ポッドがデプロイされているワーカー間で要求をルーティングします。

4. ワーカー 10.73.14.26 が、IPIP カプセル化パケットをアンパックしてから、クライアント要求パケットをアンパックします。 そのワーカー・ノード上のアプリ・ポッドにクライアント要求パケットが転送されます。

5. 次に、ワーカー 10.73.14.26 は、元の要求パケットのソース IP アドレス (クライアント IP) を使用して、アプリ・ポッドの応答パケットをクライアントに直接返します。

### 複数ゾーン・クラスターでバージョン 2.0 のロード・バランサーを使用する場合、要求はどのようにアプリに到達するのですか?
{: #ipvs_multi}

複数ゾーン・クラスター内のトラフィック・フローも、[単一ゾーン・クラスター内のトラフィック](#ipvs_single)と同じパスをたどります。 複数ゾーン・クラスターでは、ロード・バランサーは自身のゾーン内のアプリ・インスタンスと他のゾーン内のアプリ・インスタンスに要求をルーティングします。 次の図は、各ゾーンに存在するバージョン 2.0 のロード・バランサーが、インターネットから複数ゾーン・クラスターのアプリにトラフィックを転送する方法を示しています。

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="ロード・バランサー 2.0 を使用して {{site.data.keyword.containerlong_notm}} 内のアプリを公開する" style="width:500px; border-style: none"/>

デフォルトでは、バージョン 2.0 の各ロード・バランサーは、1 つのゾーンにのみセットアップされます。 アプリ・インスタンスが存在するすべてのゾーンにバージョン 2.0 ロード・バランサーをデプロイすることによって、可用性を高めることができます。

<br />


## ロード・バランサー 2.0 のスケジューリング・アルゴリズム
{: #scheduling}

バージョン 2.0 ロード・バランサーがネットワーク接続をアプリ・ポッドにどのように割り当てるかは、スケジューリング・アルゴリズムによって決まります。 クライアント要求がクラスターに到着すると、ロード・バランサーは、スケジューリング・アルゴリズムに基づいて要求パケットをワーカー・ノードにルーティングします。 スケジューリング・アルゴリズムを使用するには、ロード・バランサー・サービス構成ファイルのスケジューラー・アノテーションで、その Keepalived 短縮名を指定します (`service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`)。 以下のリストで、{{site.data.keyword.containerlong_notm}} でサポートされるスケジューリング・アルゴリズムを確認してください。 スケジューリング・アルゴリズムを指定しない場合は、デフォルトでラウンドロビン・アルゴリズムが使用されます。 詳しくは、[Keepalived の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://www.Keepalived.org/doc/scheduling_algorithms.html) を参照してください。

### サポートされるスケジューリング・アルゴリズム
{: #scheduling_supported}

<dl>
<dt>ラウンドロビン (<code>rr</code>)</dt>
<dd>ロード・バランサーは、アプリ・ポッドのリスト順に接続をワーカー・ノードにルーティングし、各アプリ・ポッドを均等に扱います。 ラウンドロビンは、バージョン 2.0 のロード・バランサーのデフォルトのスケジューリング・アルゴリズムです。</dd>
<dt>ソース・ハッシュ (<code>sh</code>)</dt>
<dd>ロード・バランサーは、クライアント要求パケットのソース IP アドレスに基づいてハッシュ・キーを生成します。 次にロード・バランサーは、静的に割り当てられたハッシュ・テーブルでそのハッシュ・キーを検索し、該当範囲のハッシュを処理するアプリ・ポッドに要求をルーティングします。 このアルゴリズムにより、特定のクライアントからの要求は常に同じアプリ・ポッドに送信されるようになります。</br>**注**: Kubernetes では Iptable 規則が使用されるので、ワーカー上のランダム・ポッドに要求が送信されます。 このスケジューリング・アルゴリズムを使用するには、ワーカー・ノード 1 つにつきアプリ・ポッドが 1 つのみデプロイされるようにする必要があります。 例えば、各ポッドのラベルが <code>run =&lt;app_name&gt;</code> であれば、アプリ・デプロイメントの <code>spec</code> セクションに以下のアンチアフィニティー・ルールを追加します。</br>
<pre class="codeblock">
<code>
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

[IBM Cloud デプロイメント・パターンに関するこのブログ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/) に完全な例があります。</dd>
</dl>

### サポートされないスケジューリング・アルゴリズム
{: #scheduling_unsupported}

<dl>
<dt>宛先ハッシュ (<code>dh</code>)</dt>
<dd>パケットの宛先 (ロード・バランサーの IP アドレスとポート) を使用して、着信要求を処理するワーカー・ノードが決定されます。 ただし、{{site.data.keyword.containerlong_notm}} 内のロード・バランサーの IP アドレスとポートは変わりません。 ロード・バランサーが存在するワーカー・ノードから要求が出ていかず、1 つのワーカー上のアプリ・ポッドのみがすべての着信要求を処理することになります。</dd>
<dt>動的接続カウント・アルゴリズム</dt>
<dd>以下のアルゴリズムは、クライアントとロード・バランサーの間の動的な接続数に基づくものです。 しかし、直接サービス・リターン (DSR) ではロード・バランサー 2.0 のポッドがパケットのリターン・パスに含まれないため、ロード・バランサーは確立された接続を追跡しません。<ul>
<li>最少接続 (<code>lc</code>)</li>
<li>局所的な最少接続 (<code>lblc</code>)</li>
<li>複製付きの局所的な最少接続 (<code>lblcr</code>)</li>
<li>キューなし (<code>nq</code>)</li>
<li>最短予期遅延 (<code>seq</code>)</li></ul></dd>
<dt>加重型ポッド・アルゴリズム</dt>
<dd>以下のアルゴリズムは、重みづけされたアプリ・ポッドに基づくものです。 しかし、{{site.data.keyword.containerlong_notm}} のロード・バランシングでは、すべてのアプリ・ポッドに等しい重みが割り当てられます。<ul>
<li>加重型最少接続 (<code>wlc</code>)</li>
<li>加重型ラウンドロビン (<code>wrr</code>)</li></ul></dd></dl>

<br />


## ロード・バランサー 2.0 の前提条件
{: #ipvs_provision}

既存のバージョン 1.0 のロード・バランサーを 2.0 に更新することはできません。 バージョン 2.0 のロード・バランサーを新規作成する必要があります。 クラスター内でバージョン 1.0 と 2.0 のロード・バランサーを同時に実行できます。

バージョン 2.0 のロード・バランサーを作成する前に、前提条件として次の手順を実行する必要があります。

1. [クラスターのマスター・ノードとワーカー・ノードを更新](cs_cluster_update.html)して Kubernetes バージョン 1.12 以降にします。

2. ロード・バランサー 2.0 が複数ゾーン内のアプリ・ポッドに要求を転送できるようにするために、サポート・ケースを開いて VLAN の構成設定を要求します。 **重要**: この構成をすべてのパブリック VLAN について要求する必要があります。 新しい VLAN の関連付けを要求する場合は、その VLAN の別のチケットを開く必要があります。
    1. [{{site.data.keyword.Bluemix_notm}} コンソール](https://console.bluemix.net/) にログインします。
    2. メニューで、**「インフラストラクチャー」**にナビゲートし、次に**「サポート」>「チケットの追加」**にナビゲートします。
    3. ケース・フィールドで、**「技術」**、**「インフラストラクチャー」**、**「パブリック・ネットワークの質問 (Public Network Question)」**を選択します。
    4. 「Please set up the network to allow capacity aggregation on the public VLANs associated with my account. The reference ticket for this request is: https://control.softlayer.com/support/tickets/63859145」という情報を説明に追加します。
    5. **「チケットの送信 (Submit Ticket)」**をクリックします。

3. VLAN にキャパシティー集約が構成されたら、IBM Cloud インフラストラクチャー (SoftLayer) アカウントの [VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にします。 VLAN スパンニングが有効になると、バージョン 2.0 のロード・バランサーは、アカウント内のさまざまなサブネットにパケットをルーティングできるようになります。

4. [Calico pre-DNAT ネットワーク・ポリシー](cs_network_policy.html#block_ingress)を使用してバージョン 2.0 のロード・バランサーの IP アドレスへのトラフィックを管理する場合は、ポリシーの `spec` セクションに `applyOnForward: true` フィールドと `doNotTrack: true` フィールドを追加する必要があります。 `applyOnForward: true` は、トラフィックがカプセル化されて転送されるときに Calico ポリシーが適用されるようにします。 `doNotTrack: true` は、ワーカー・ノードが DSR を使用して、接続を追跡する必要なしに応答パケットをクライアントに直接返せるようにします。 例えば、Calico ポリシーを使用して特定の IP アドレスからロード・バランサー IP アドレスへのトラフィックのみをホワイトリストに登録する場合、ポリシーは以下のようになります。
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

次は、[複数ゾーン・クラスターでのロード・バランサー 2.0 のセットアップ](#ipvs_multi_zone_config)または[単一ゾーン・クラスターでのロード・バランサー 2.0 のセットアップ](#ipvs_single_zone_config)の手順に従ってください。

<br />


## 複数ゾーン・クラスターでのロード・バランサー 2.0 のセットアップ
{: #ipvs_multi_zone_config}

ロード・バランサー・サービスは標準クラスターでのみ使用可能であり、TLS 終端をサポートしていません。 アプリで TLS 終端が必要な場合は、[Ingress](cs_ingress.html) を使用してアプリを公開するか、または TLS 終端を管理するようにアプリを構成することができます。
{: note}

**始める前に**:

  * **重要**: [ロード・バランサー 2.0 の前提条件](#ipvs_provision)を満たしてください。
  * パブリック・ロード・バランサーを複数のゾーンに作成するためには、ゾーンごとに 1 つ以上のパブリック VLAN にポータブル・サブネットを用意する必要があります。 プライベート・ロード・バランサーを複数のゾーンに作成するためには、ゾーンごとに 1 つ以上のプライベート VLAN にポータブル・サブネットを用意する必要があります。 サブネットを追加する方法については、[クラスターのサブネットの構成](cs_subnets.html)を参照してください。
  * ネットワーク・トラフィックをエッジ・ワーカー・ノードに制限する場合は、各ゾーンで 2 つ以上の[エッジ・ワーカー・ノード](cs_edge.html#edge)を有効にしてください。 エッジ・ワーカー・ノードが有効なゾーンと有効でないゾーンがある場合、ロード・バランサーが均一にデプロイされません。 一部のゾーンではロード・バランサーがエッジ・ノードにデプロイされても、他のゾーンでは通常のワーカー・ノードにデプロイされます。


複数ゾーン・クラスターでロード・バランサー 2.0 をセットアップするには、次の手順を実行します。
1.  [アプリをクラスターにデプロイします](cs_app.html#app_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドを識別してロード・バランシングに含めるために必要です。

2.  公開するアプリのロード・バランサー・サービスを作成します。 アプリを公共のインターネットまたはプライベート・ネットワーク上で利用可能にするには、アプリの Kubernetes サービスを作成します。 アプリを構成しているすべてのポッドをロード・バランシングに含めるようにサービスを構成します。
  1. `myloadbalancer.yaml` などの名前のサービス構成ファイルを作成します。
  2. 公開するアプリのロード・バランサー・サービスを定義します。 ゾーン、VLAN、および IP アドレスを指定できます。

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
      ```
      {: codeblock}

      <table>
      <caption>YAML ファイルの構成要素について</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>ロード・バランサーのタイプを指定するアノテーション。 指定可能な値は <code>private</code> と <code>public</code> です。 パブリック VLAN 上のクラスターにパブリック・ロード・バランサーを作成する場合には、このアノテーションは必要ありません。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>ロード・バランサー・サービスのデプロイ先のゾーンを指定するアノテーション。 ゾーンを表示するには、<code>ibmcloud ks zones</code> を実行します。</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>ロード・バランサー・サービスのデプロイ先の VLAN を指定するアノテーション。 VLAN を表示するには、<code>ibmcloud ks vlans --zone <zone></code> を実行します。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>バージョン 2.0 のロード・バランサーを指定するアノテーション。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>オプション: スケジューリング・アルゴリズムを指定するアノテーション。 指定可能な値は、<code>"rr"</code> (ラウンドロビン (デフォルト)) または <code>"sh"</code> (ソース・ハッシュ) です。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにしてサービス・ロード・バランシングに含めるには、<em>&lt;selectorkey&gt;</em> と <em>&lt;selectorvalue&gt;</em> の値を確認します。 これらが、デプロイメント yaml の <code>spec.template.metadata.labels</code> セクションで使用した<em>キーと値</em> のペアと同じであることを確認してください。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>サービスが listen するポート。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>オプション: プライベート・ロード・バランサーを作成するには、またはパブリック・ロード・バランサー用に特定のポータブル IP アドレスを使用するには、<em>&lt;IP_address&gt;</em> を、使用する IP アドレスに置き換えます。 VLAN またはゾーンを指定する場合は、その VLAN またはゾーン内の IP アドレスでなければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上でのみ使用可能な場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td><code>Local</code> に設定します。</td>
      </tr>
      </tbody></table>

      ラウンドロビン・スケジューリング・アルゴリズムを使用するロード・バランサー 2.0 サービスを `dal12` に作成するための構成ファイルの例:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. オプション: **spec** セクションに `loadBalancerSourceRanges` を指定してファイアウォールを構成します。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

  4. クラスター内にサービスを作成します。

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. ロード・バランサー・サービスが正常に作成されたことを確認します。 _&lt;myservice&gt;_ を、前のステップで作成したロード・バランサー・サービスの名前に置き換えます。 ロード・バランサー・サービスが適切に作成され、アプリが利用可能になるまでに数分かかることがあります。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 出力例:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP アドレスは、ロード・バランサー・サービスに割り当てられたポータブル・パブリック IP アドレスです。

4.  パブリック・ロード・バランサーを作成した場合、インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  ロード・バランサーのポータブル・パブリック IP アドレスとポートを入力します。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 高可用性を確保するために、上記の手順を繰り返して、アプリ・インスタンスが存在する各ゾーンにロード・バランサー 2.0 を追加します。

6. オプション: ロード・バランサー・サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](cs_nodeport.html) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 ロード・バランサー・サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサーまたは NodePort サービスへのインバウンド・トラフィックの制御](cs_network_policy.html#block_ingress)を参照してください。

## 単一ゾーン・クラスターでのロード・バランサー 2.0 のセットアップ
{: #ipvs_single_zone_config}

開始前に、以下のことを行います。

* このフィーチャーを使用できるのは、標準クラスターの場合に限られます。
* ロード・バランサー・サービスに割り当てることのできるポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスが必要です。
* **重要**: [ロード・バランサー 2.0 の前提条件](#ipvs_provision)を満たしてください。

単一ゾーン・クラスターでロード・バランサー 2.0 サービスを作成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](cs_app.html#app_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドをロード・バランシングに含めるためにそれらのポッドを識別する上で必要です。
2.  公開するアプリのロード・バランサー・サービスを作成します。 アプリを公共のインターネットまたはプライベート・ネットワーク上で利用可能にするには、アプリの Kubernetes サービスを作成します。 アプリを構成しているすべてのポッドをロード・バランシングに含めるようにサービスを構成します。
    1.  `myloadbalancer.yaml` などの名前のサービス構成ファイルを作成します。

    2.  公開するアプリのロード・バランサー 2.0 サービスを定義します。
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>YAML ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>ロード・バランサーのタイプを指定するアノテーション。 指定可能な値は `private` と `public` です。 パブリック VLAN 上のクラスターにパブリック・ロード・バランサーを作成する場合には、このアノテーションは必要ありません。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>ロード・バランサー・サービスのデプロイ先の VLAN を指定するアノテーション。 VLAN を表示するには、<code>ibmcloud ks vlans --zone <zone></code> を実行します。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>ロード・バランサー 2.0 を指定するアノテーション。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>スケジューリング・アルゴリズムを指定するアノテーション。 指定可能な値は、<code>"rr"</code> (ラウンドロビン (デフォルト)) または <code>"sh"</code> (ソース・ハッシュ) です。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにしてサービス・ロード・バランシングに含めるには、<em>&lt;selector_key&gt;</em> と <em>&lt;selector_value&gt;</em> の値を確認します。 これらが、デプロイメント yaml の <code>spec.template.metadata.labels</code> セクションで使用した<em>キーと値</em> のペアと同じであることを確認してください。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>サービスが listen するポート。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>オプション: プライベート・ロード・バランサーを作成するには、またはパブリック・ロード・バランサー用に特定のポータブル IP アドレスを使用するには、<em>&lt;IP_address&gt;</em> を、使用する IP アドレスに置き換えます。 VLAN を指定する場合、IP アドレスはその VLAN 上になければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上でのみ使用可能な場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td><code>Local</code> に設定します。</td>
        </tr>
        </tbody></table>

    3.  オプション: **spec** セクションに `loadBalancerSourceRanges` を指定してファイアウォールを構成します。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        ロード・バランサー・サービスが作成される際に、ロード・バランサーにポータブル IP アドレスが自動的に割り当てられます。 使用可能なポータブル IP アドレスがなければ、ロード・バランサー・サービスは作成できません。

3.  ロード・バランサー・サービスが正常に作成されたことを確認します。 ロード・バランサー・サービスが適切に作成され、アプリが利用可能になるまでに数分かかることがあります。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 出力例:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP アドレスは、ロード・バランサー・サービスに割り当てられたポータブル・パブリック IP アドレスです。

4.  パブリック・ロード・バランサーを作成した場合、インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  ロード・バランサーのポータブル・パブリック IP アドレスとポートを入力します。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. オプション: ロード・バランサー・サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](cs_nodeport.html) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 ロード・バランサー・サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサーまたは NodePort サービスへのインバウンド・トラフィックの制御](cs_network_policy.html#block_ingress)を参照してください。

<br />


## ロード・バランサー 1.0 のコンポーネントとアーキテクチャー
{: #planning}

TCP/UDP ロード・バランサー 1.0 は、Linux カーネルの機能である Iptables を使用して、アプリのポッド間で要求の負荷分散を行います。

**単一ゾーン・クラスターでバージョン 1.0 のロード・バランサーを使用する場合、要求はどのようにアプリに到達するのですか?**

次の図は、ロード・バランサー 1.0 がインターネットからアプリへの通信をどのように誘導するかを示しています。

<img src="images/cs_loadbalancer_planning.png" width="450" alt="ロード・バランサー 1.0 を使用して {{site.data.keyword.containerlong_notm}} 内のアプリを公開する" style="width:450px; border-style: none"/>

1. アプリに対する要求では、ロード・バランサーのパブリック IP アドレスとワーカー・ノードに割り当てられたポートを使用します。

2. 要求が、ロード・バランサー・サービスの内部のクラスター IP アドレスとポートに自動的に転送されます。 内部クラスター IP アドレスはクラスター内でのみアクセス可能です。

3. `kube-proxy` が、要求をアプリの Kubernetes ロード・バランサー・サービスにルーティングします。

4. 要求は、アプリ・ポッドのプライベート IP アドレスに転送されます。 要求パッケージのソース IP アドレスが、アプリ・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。 複数のアプリ・インスタンスがクラスターにデプロイされている場合、ロード・バランサーは、アプリ・ポッド間で要求をルーティングします。

**複数ゾーン・クラスターでバージョン 1.0 のロード・バランサーを使用する場合、要求はどのようにアプリに到達するのですか?**

複数ゾーン・クラスターがある場合、アプリ・インスタンスはさまざまなゾーンにまたがってワーカーのポッドにデプロイされます。 次の図は、ロード・バランサー 1.0 がインターネットから複数ゾーン・クラスターのアプリに通信を転送する方法を示しています。

<img src="images/cs_loadbalancer_planning_multizone.png" width="475" alt="ロード・バランサー 1.0 を使用して複数ゾーン・クラスター内のアプリのロード・バランスを取る" style="width:475px; border-style: none"/>

デフォルトでは、各ロード・バランサー 1.0 が 1 ゾーンにのみセットアップされます。 高可用性を確保するには、アプリ・インスタンスが存在するすべてのゾーンにロード・バランサー 1.0 をデプロイする必要があります。 ラウンドロビン・サイクルでさまざまなゾーンのロード・バランサーが要求を処理します。 また、各ロード・バランサーは、デプロイ先のゾーンのアプリ・インスタンスへの要求と、他のゾーンのアプリ・インスタンスへの要求を転送します。

<br />


## 複数ゾーン・クラスターでのロード・バランサー 1.0 のセットアップ
{: #multi_zone_config}

ロード・バランサー・サービスは標準クラスターでのみ使用可能であり、TLS 終端をサポートしていません。 アプリで TLS 終端が必要な場合は、[Ingress](cs_ingress.html) を使用してアプリを公開するか、または TLS 終端を管理するようにアプリを構成することができます。
{: note}

**始める前に**:
  * ロード・バランサーは各ゾーンにデプロイする必要があり、各ロード・バランサーにはそのゾーン内の独自の IP アドレスが割り当てられます。 パブリック・ロード・バランサーを作成するには、各ゾーンで使用できるポータブル・サブネットを含むパブリック VLAN が 1 つ以上必要です。 プライベート・ロード・バランサー・サービスを追加するには、各ゾーンで使用できるポータブル・サブネットを含むプライベート VLAN が 1 つ以上必要です。 サブネットを追加する方法については、[クラスターのサブネットの構成](cs_subnets.html)を参照してください。
  * ネットワーク・トラフィックをエッジ・ワーカー・ノードに制限する場合は、各ゾーンで 2 つ以上の[エッジ・ワーカー・ノード](cs_edge.html#edge)を有効にしてください。 エッジ・ワーカー・ノードが有効なゾーンと有効でないゾーンがある場合、ロード・バランサーが均一にデプロイされません。 一部のゾーンではロード・バランサーがエッジ・ノードにデプロイされても、他のゾーンでは通常のワーカー・ノードにデプロイされます。
  * IBM Cloud インフラストラクチャー (SoftLayer) アカウントに対して [VLAN スパンニング](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにします。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](cs_users.html#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)を使用します。


複数ゾーン・クラスターでロード・バランサー 1.0 サービスをセットアップするには、次の手順を実行します。
1.  [アプリをクラスターにデプロイします](cs_app.html#app_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドを識別してロード・バランシングに含めるために必要です。

2.  公開するアプリのロード・バランサー・サービスを作成します。 アプリを公共のインターネットまたはプライベート・ネットワーク上で利用可能にするには、アプリの Kubernetes サービスを作成します。 アプリを構成しているすべてのポッドをロード・バランシングに含めるようにサービスを構成します。
  1. `myloadbalancer.yaml` などの名前のサービス構成ファイルを作成します。
  2. 公開するアプリのロード・バランサー・サービスを定義します。 ゾーン、VLAN、および IP アドレスを指定できます。

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
      ```
      {: codeblock}

      <table>
      <caption>YAML ファイルの構成要素について</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>ロード・バランサーのタイプを指定するアノテーション。 指定可能な値は <code>private</code> と <code>public</code> です。 パブリック VLAN 上のクラスターにパブリック・ロード・バランサーを作成する場合には、このアノテーションは必要ありません。</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>ロード・バランサー・サービスのデプロイ先のゾーンを指定するアノテーション。 ゾーンを表示するには、<code>ibmcloud ks zones</code> を実行します。</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>ロード・バランサー・サービスのデプロイ先の VLAN を指定するアノテーション。 VLAN を表示するには、<code>ibmcloud ks vlans --zone <zone></code> を実行します。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにしてサービス・ロード・バランシングに含めるには、<em>&lt;selectorkey&gt;</em> と <em>&lt;selectorvalue&gt;</em> の値を確認します。 これらが、デプロイメント yaml の <code>spec.template.metadata.labels</code> セクションで使用した<em>キーと値</em> のペアと同じであることを確認してください。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>サービスが listen するポート。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>オプション: プライベート・ロード・バランサーを作成するには、またはパブリック・ロード・バランサー用に特定のポータブル IP アドレスを使用するには、<em>&lt;IP_address&gt;</em> を、使用する IP アドレスに置き換えます。 VLAN またはゾーンを指定する場合は、その VLAN またはゾーン内の IP アドレスでなければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上でのみ使用可能な場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
      </tr>
      </tbody></table>

      プライベート VLAN `2234945` 上の指定した IP アドレスを使用するプライベート・ロード・バランサー 1.0 サービスを `dal12` に作成するための構成ファイルの例:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. オプション: **spec** セクションに `loadBalancerSourceRanges` を指定してファイアウォールを構成します。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

  4. クラスター内にサービスを作成します。

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. ロード・バランサー・サービスが正常に作成されたことを確認します。 _&lt;myservice&gt;_ を、前のステップで作成したロード・バランサー・サービスの名前に置き換えます。 ロード・バランサー・サービスが適切に作成され、アプリが利用可能になるまでに数分かかることがあります。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 出力例:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP アドレスは、ロード・バランサー・サービスに割り当てられたポータブル・パブリック IP アドレスです。

4.  パブリック・ロード・バランサーを作成した場合、インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  ロード・バランサーのポータブル・パブリック IP アドレスとポートを入力します。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}        

5. [バージョン 1.0 ロード・バランサー・サービスのソース IP 保持を有効にする ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) 場合は必ず、[アプリ・ポッドにエッジ・ノード・アフィニティーを追加](cs_loadbalancer.html#edge_nodes)して、エッジ・ワーカー・ノードにアプリ・ポッドをスケジュールするようにしてください。 着信要求を受信するには、アプリ・ポッドをエッジ・ノードにスケジュールする必要があります。

6. 上記の手順を繰り返して、各ゾーンにバージョン 1.0 のロード・バランサーを追加します。

7. オプション: ロード・バランサー・サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](cs_nodeport.html) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 ロード・バランサー・サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサーまたは NodePort サービスへのインバウンド・トラフィックの制御](cs_network_policy.html#block_ingress)を参照してください。

## 単一ゾーン・クラスターでのロード・バランサー 1.0 のセットアップ
{: #config}

開始前に、以下のことを行います。

* このフィーチャーを使用できるのは、標準クラスターの場合に限られます。
* ロード・バランサー・サービスに割り当てることのできるポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスが必要です。

単一ゾーン・クラスターでロード・バランサー 1.0 サービスを作成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](cs_app.html#app_cli)。 アプリをクラスターにデプロイする際に、コンテナー内のアプリを実行するポッドが 1 つ以上自動的に作成されます。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドをロード・バランシングに含めるためにそれらのポッドを識別する上で必要です。
2.  公開するアプリのロード・バランサー・サービスを作成します。 アプリを公共のインターネットまたはプライベート・ネットワーク上で利用可能にするには、アプリの Kubernetes サービスを作成します。 アプリを構成しているすべてのポッドをロード・バランシングに含めるようにサービスを構成します。
    1.  `myloadbalancer.yaml` などの名前のサービス構成ファイルを作成します。

    2.  公開するアプリのロード・バランサー・サービスを定義します。
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>YAML ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>ロード・バランサーのタイプを指定するアノテーション。 指定可能な値は `private` と `public` です。 パブリック VLAN 上のクラスターにパブリック・ロード・バランサーを作成する場合には、このアノテーションは必要ありません。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>ロード・バランサー・サービスのデプロイ先の VLAN を指定するアノテーション。 VLAN を表示するには、<code>ibmcloud ks vlans --zone <zone></code> を実行します。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>アプリが実行されるポッドをターゲットにするために使用する、ラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>) のペアを入力します。 ポッドをターゲットにしてサービス・ロード・バランシングに含めるには、<em>&lt;selector_key&gt;</em> と <em>&lt;selector_value&gt;</em> の値を確認します。 これらが、デプロイメント yaml の <code>spec.template.metadata.labels</code> セクションで使用した<em>キーと値</em> のペアと同じであることを確認してください。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>サービスが listen するポート。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>オプション: プライベート・ロード・バランサーを作成するには、またはパブリック・ロード・バランサー用に特定のポータブル IP アドレスを使用するには、<em>&lt;IP_address&gt;</em> を、使用する IP アドレスに置き換えます。 VLAN を指定する場合、IP アドレスはその VLAN 上になければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上でのみ使用可能な場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
        </tr>
        </tbody></table>

        プライベート VLAN `2234945` 上の指定した IP アドレスを使用するプライベート・ロード・バランサー 1.0 サービスを作成するための構成ファイルの例:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3.  オプション: **spec** セクションに `loadBalancerSourceRanges` を指定してファイアウォールを構成します。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        ロード・バランサー・サービスが作成される際に、ロード・バランサーにポータブル IP アドレスが自動的に割り当てられます。 使用可能なポータブル IP アドレスがなければ、ロード・バランサー・サービスは作成できません。

3.  ロード・バランサー・サービスが正常に作成されたことを確認します。 ロード・バランサー・サービスが適切に作成され、アプリが利用可能になるまでに数分かかることがあります。

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI 出力例:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP アドレスは、ロード・バランサー・サービスに割り当てられたポータブル・パブリック IP アドレスです。

4.  パブリック・ロード・バランサーを作成した場合、インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  ロード・バランサーのポータブル・パブリック IP アドレスとポートを入力します。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. [ロード・バランサー 1.0 サービスのソース IP 保持を有効にする ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) 場合は必ず、[アプリ・ポッドにエッジ・ノード・アフィニティーを追加](cs_loadbalancer.html#edge_nodes)して、エッジ・ワーカー・ノードにアプリ・ポッドをスケジュールするようにしてください。 着信要求を受信するには、アプリ・ポッドをエッジ・ノードにスケジュールする必要があります。

6. オプション: ロード・バランサー・サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](cs_nodeport.html) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 ロード・バランサー・サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサーまたは NodePort サービスへのインバウンド・トラフィックの制御](cs_network_policy.html#block_ingress)を参照してください。

<br />


## バージョン 1.0 のロード・バランサーのソース IP 保持の有効化
{: #node_affinity_tolerations}

この機能は、バージョン 1.0 のロード・バランサーにのみあります。 バージョン 2.0 のロード・バランサーでは、クライアント要求のソース IP アドレスはデフォルトで保持されます。
{: note}

アプリへのクライアント要求がクラスターに送信されると、ロード・バランサー・サービス・ポッドがその要求を受け取ります。 ロード・バランサー・サービス・ポッドと同じワーカー・ノードにアプリ・ポッドが存在しない場合、ロード・バランサーは異なるワーカー・ノード上のアプリ・ポッドに要求を転送します。 パッケージのソース IP アドレスは、ロード・バランサー・サービス・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。

クライアント要求の元のソース IP アドレスを保持するには、ロード・バランサー・サービスの[ソース IP を有効化 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) します。 TCP の接続先はアプリ・ポッドになるので、アプリはイニシエーターの実際のソース IP アドレスを認識できます。 クライアントの IP を保持すると、例えば、アプリ・サーバーがセキュリティーやアクセス制御ポリシーを適用する必要がある場合などに役に立ちます。

ソース IP を有効にした場合は、ロード・バランサー・サービス・ポッドは、同じワーカー・ノードにデプロイされているアプリ・ポッドにのみ要求を転送しなければなりません。 通常、ロード・バランサー・サービス・ポッドも、アプリ・ポッドをデプロイしたワーカー・ノードにデプロイされます。 しかし、次のように、ロード・バランサー・ポッドとアプリ・ポッドが同じワーカー・ノードにスケジュールされない状況もあります。

* エッジ・ノードにテイントがあるため、これらのエッジ・ノードにデプロイできるのはロード・バランサー・サービス・ポッドのみです。 このようなノードにはアプリ・ポッドをデプロイできません。
* 複数のパブリック VLAN またはプライベート VLAN にクラスターが接続されている場合、1 つの VLAN のみに接続されているワーカー・ノードにアプリ・ポッドはデプロイされます。 ロード・バランサーの IP アドレスがワーカー・ノードとは別の VLAN に接続されているという理由で、このようなワーカー・ノードにはロード・バランサー・サービス・ポッドはデプロイされない可能性があります。

ロード・バランサー・サービス・ポッドもデプロイできる特定のワーカー・ノードに強制的にアプリをデプロイするには、アフィニティー・ルールと耐障害性をアプリのデプロイメントに追加する必要があります。

### エッジ・ノードのアフィニティー・ルールと耐障害性を追加する
{: #edge_nodes}

[ワーカー・ノードにエッジ・ノードのラベルを付け](cs_edge.html#edge_nodes)、さらに[エッジ・ノードにテイントを適用する](cs_edge.html#edge_workloads)場合、ロード・バランサー・サービス・ポッドはそれらのエッジ・ノードにのみデプロイされ、アプリ・ポッドはエッジ・ノードにデプロイできません。 ロード・バランサー・サービスでソース IP が有効になっている場合、エッジ・ノード上のロード・バランサー・ポッドは、着信要求を他のワーカー・ノード上のアプリ・ポッドに転送できません。
{:shortdesc}

アプリ・ポッドをエッジ・ノードに強制的にデプロイするには、エッジ・ノードの[アフィニティー・ルール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) と[耐障害性 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) をアプリのデプロイメントに追加します。

エッジ・ノード・アフィニティーとエッジ・ノード耐障害性を追加したデプロイメント YAML のサンプル

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
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

**affinity** と **tolerations** の両方のセクションで、`key` として `dedicated` が、`value` として `edge` が指定されています。

### 複数のパブリック VLAN またはプライベート VLAN にアフィニティー・ルールを追加する
{: #edge_nodes_multiple_vlans}

複数のパブリック VLAN またはプライベート VLAN にクラスターが接続されている場合は、1 つの VLAN のみに接続されているワーカー・ノードにアプリ・ポッドはデプロイされる可能性があります。 ロード・バランサーの IP アドレスが、そのようなワーカー・ノードとは別の VLAN に接続されていると、ロード・バランサー・サービス・ポッドはそのようなワーカー・ノードにデプロイされません。
{:shortdesc}

ソース IP を有効にした場合は、アフィニティー・ルールをアプリのデプロイメントに追加して、ロード・バランサーの IP アドレスと同じ VLAN にあるワーカー・ノードにアプリ・ポッドをスケジュールしてください。

開始前に、以下のことを行います。 [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。 クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

1. ロード・バランサー・サービスのパブリック IP アドレスを取得します。 **LoadBalancer Ingress** フィールドの IP アドレスを確認してください。
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. ロード・バランサー・サービスが接続する VLAN ID を取得します。

    1. クラスターのポータブル・パブリック VLAN をリストします。
        ```
        ibmcloud ks cluster-get <cluster_name_or_ID> --showResources
        ```
        {: pre}

        出力例:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. **Subnet VLANs** の下にある出力で、先ほど取得したロード・バランサーの IP アドレスと一致するサブネット CIDR を見つけ、その VLAN ID をメモします。

        例えば、ロード・バランサー・サービスの IP アドレスが `169.36.5.xxx` の場合、前のステップの出力例で一致するサブネットは `169.36.5.xxx/29` です。 そのサブネットが接続する VLAN ID は、`2234945` です。

3. アプリのデプロイメントに、前の手順でメモした VLAN ID に対する[アフィニティー・ルールを追加 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) します。

    例えば、複数の VLAN がある場合に、`2234945` のパブリック VLAN にあるワーカー・ノードにのみアプリ・ポッドをデプロイするには、以下のようにします。

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
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    サンプル YAML では、**affinity** セクションの `key` は `publicVLAN`、`value` は `"2234945"` です。

4. 更新したデプロイメント構成ファイルを適用します。
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. アプリ・ポッドが、指定した VLAN に接続されたワーカー・ノードにデプロイされたことを確認します。

    1. クラスター内のポッドをリストします。 `<selector>` を、アプリに使用したラベルに置き換えます。
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        出力例:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. 出力で、アプリのポッドを確認します。 ポッドがあるワーカー・ノードの **NODE** ID をメモします。

        前のステップの出力例では、アプリ・ポッド `cf-py-d7b7d94db-vp8pq` がワーカー・ノード `10.176.48.78` にあります。

    3. ワーカー・ノードの詳細情報をリストします。

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        出力例:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. 出力の **Labels** セクションのパブリック VLAN またはプライベート VLAN が、前の手順で指定した VLAN であることを確認します。
