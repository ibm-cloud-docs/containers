---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb

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



# NLB 2.0 (ベータ) のセットアップ
{: #loadbalancer-v2}

ポートを公開し、レイヤー 4 のネットワーク・ロード・バランサー (NLB) のポータブル IP アドレスを使用してコンテナー化アプリに公開します。バージョン 2.0 NLB について詳しくは、[NLB 2.0 のコンポーネントおよびアーキテクチャー](/docs/containers?topic=containers-loadbalancer-about#planning_ipvs)を参照してください。
{:shortdesc}

## 前提条件
{: #ipvs_provision}

既存のバージョン 1.0 の NLB を 2.0 に更新することはできません。 新規 NLB 2.0 を作成する必要があります。 クラスター内でバージョン 1.0 と 2.0 の NLB を同時に実行できます。
{: shortdesc}

NLB 2.0 を作成する前に、前提条件として次の手順を実行する必要があります。

1. [クラスターのマスター・ノードとワーカー・ノードを更新](/docs/containers?topic=containers-update)して Kubernetes バージョン 1.12 以降にします。

2. NLB 2.0 で複数ゾーン内のアプリ・ポッドに要求を転送できるようにするには、サポート・ケースを開いて VLAN の容量集約を要求します。 この構成設定によって、ネットワークの中断や障害が発生することはありません。
    1. [{{site.data.keyword.cloud_notm}} コンソール](https://cloud.ibm.com/) にログインします。
    2. メニュー・バーの**「サポート」**をクリックし、**「Case の管理」**タブをクリックして、**「新規 Case の作成 (Create new case)」**をクリックします。
    3. Case フィールドに、以下の情報を入力します。
       * サポートのタイプとして**「テクニカル (Technical)」**を選択します。
       * カテゴリーとして**「VLAN スパンニング」**を選択します。
       * 件名には、**Public and private VLAN network question** と入力します。
    4. 説明に次の情報を追加します。「Please set up the network to allow capacity aggregation on the public VLANs associated with my account. The reference ticket for this request is: https://control.softlayer.com/support/tickets/63859145.」特定の VLAN (1 つのクラスターのみに対するパブリック VLAN など) について容量集約を許可する場合は、説明でこれらの VLAN ID を指定できます。
    5. **「送信」**をクリックします。

3. IBM Cloud インフラストラクチャー・アカウントの[仮想ルーター機能 (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) を有効にする必要があります。 VRF を有効にするには、[IBM Cloud インフラストラクチャーのアカウント担当者に連絡してください](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion)。 VRF が既に有効になっているかどうかを確認するには、`ibmcloud account show` コマンドを使用します。 VRF の有効化が不可能または不要な場合は、[VLAN スパンニング](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)を有効にしてください。 VRF または VLAN スパンニングが有効になると、NLB 2.0 は、アカウント内のさまざまなサブネットにパケットをルーティングできるようになります。

4. [Calico pre-DNAT ネットワーク・ポリシー](/docs/containers?topic=containers-network_policies#block_ingress)を使用して NLB 2.0 の IP アドレスへのトラフィックを管理する場合は、ポリシーの `spec` セクションに `applyOnForward: true` フィールドと `doNotTrack: true` フィールドを追加し、`preDNAT: true` を削除する必要があります。 `applyOnForward: true` は、トラフィックがカプセル化されて転送されるときに Calico ポリシーが適用されるようにします。 `doNotTrack: true` は、ワーカー・ノードが DSR を使用して、接続を追跡する必要なしに応答パケットをクライアントに直接返せるようにします。 例えば、Calico ポリシーを使用して特定の IP アドレスから NLB IP アドレスへのトラフィックのみをホワイトリストに登録する場合、ポリシーは以下のようになります。
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
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

次は、[複数ゾーン・クラスターでの NLB 2.0 のセットアップ](#ipvs_multi_zone_config)または[単一ゾーン・クラスターでの NLB 2.0 のセットアップ](#ipvs_single_zone_config)の手順に従ってください。

<br />


## 複数ゾーン・クラスターでの NLB 2.0 のセットアップ
{: #ipvs_multi_zone_config}

**始める前に**:

* **重要**: [NLB 2.0 の前提条件](#ipvs_provision)を満たしてください。
* パブリック NLB を複数のゾーンに作成するためには、ゾーンごとに 1 つ以上のパブリック VLAN にポータブル・サブネットを用意する必要があります。 プライベート NLB を複数のゾーンに作成するためには、ゾーンごとに 1 つ以上のプライベート VLAN にポータブル・サブネットを用意する必要があります。 [クラスター用のサブネットの構成](/docs/containers?topic=containers-subnets)に記載されているステップに従うことにより、サブネットを追加できます。
* ネットワーク・トラフィックをエッジ・ワーカー・ノードに制限する場合は、NLB が均等にデプロイされるように、各ゾーンで 2 つ以上の[エッジ・ワーカー・ノード](/docs/containers?topic=containers-edge#edge)を有効にしてください。
* `default` 名前空間に対する[**ライター**または**管理者**の {{site.data.keyword.cloud_notm}} IAM サービス役割](/docs/containers?topic=containers-users#platform)があることを確認してください。


複数ゾーン・クラスターで NLB 2.0 をセットアップするには、次の手順を実行します。
1.  [アプリをクラスターにデプロイします](/docs/containers?topic=containers-app#app_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドを識別してロード・バランシングに含めるために必要です。

2.  パブリック・インターネットまたはプライベート・ネットワークに公開するアプリのロード・バランサー・サービスを作成します。
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
        <td><code>private</code> または <code>public</code> のロード・バランサーを指定するアノテーション。</td>
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
        <td>オプション: スケジューリング・アルゴリズムを指定するアノテーション。 指定可能な値は、<code>"rr"</code> (ラウンドロビン (デフォルト)) または <code>"sh"</code> (ソース・ハッシュ) です。 詳しくは、[2.0: スケジューリング・アルゴリズム](#scheduling)を参照してください。</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>アプリ・デプロイメント YAML の <code>spec.template.metadata.labels</code> セクションで使用したラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>)。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>サービスが listen するポート。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>オプション: プライベート NLB を作成するには、またはパブリック NLB 用に特定のポータブル IP アドレスを使用するには、使用する IP アドレスを指定します。 IP アドレスは、アノテーションで指定するゾーンと VLAN になければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上にのみ存在する場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td><code>Local</code> に設定します。</td>
      </tr>
      </tbody></table>

      ラウンドロビン・スケジューリング・アルゴリズムを使用する NLB 2.0 サービスを `dal12` に作成するための構成ファイルの例:

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

  3. オプション: 制限範囲の IP アドレスでのみ NLB サービスを使用できるようにするには、`spec.loadBalancerSourceRanges` フィールドで IP を指定します。  `loadBalancerSourceRanges` は、ワーカー・ノード上の Iptables ルールを介してクラスター内の `kube-proxy` によって実装されます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

  4. クラスター内にサービスを作成します。

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. NLB サービスが正常に作成されたことを確認します。 NLB サービスが適切に作成され、アプリが利用可能になるまでに数分かかることがあります。

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

    **LoadBalancer Ingress** IP アドレスは、NLB サービスに割り当てられたポータブル・パブリック IP アドレスです。

4.  パブリック NLB を作成した場合、インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  NLB のポータブル・パブリック IP アドレスとポートを入力します。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. 高可用性を確保するために、ステップ 2 から 4 を繰り返して、アプリ・インスタンスが存在する各ゾーンに NLB 2.0 を追加します。

6. オプション: NLB サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](/docs/containers?topic=containers-nodeport) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 NLB サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサー・サービスまたはノード・ポート・サービスへのインバウンド・トラフィックの制御](/docs/containers?topic=containers-network_policies#block_ingress)を参照してください。

次に、[NLB ホスト名を登録](/docs/containers?topic=containers-loadbalancer_hostname)できます。

<br />


## 単一ゾーン・クラスターでの NLB 2.0 のセットアップ
{: #ipvs_single_zone_config}

**始める前に**:

* **重要**: [NLB 2.0 の前提条件](#ipvs_provision)を満たしてください。
* NLB サービスに割り当てることのできるポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスが必要です。 詳しくは、[クラスター用のサブネットの構成](/docs/containers?topic=containers-subnets)を参照してください。
* `default` 名前空間に対する[**ライター**または**管理者**の {{site.data.keyword.cloud_notm}} IAM サービス役割](/docs/containers?topic=containers-users#platform)があることを確認してください。

単一ゾーン・クラスターで NLB 2.0 サービスを作成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](/docs/containers?topic=containers-app#app_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドをロード・バランシングに含めるためにそれらのポッドを識別する上で必要です。
2.  パブリック・インターネットまたはプライベート・ネットワークに公開するアプリのロード・バランサー・サービスを作成します。
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
          <td><code>private</code> または <code>public</code> のロード・バランサーを指定するアノテーション。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>オプション: ロード・バランサー・サービスのデプロイ先の VLAN を指定するアノテーション。 VLAN を表示するには、<code>ibmcloud ks vlans --zone <zone></code> を実行します。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>ロード・バランサー 2.0 を指定するアノテーション。</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>オプション: スケジューリング・アルゴリズムを指定するアノテーション。 指定可能な値は、<code>"rr"</code> (ラウンドロビン (デフォルト)) または <code>"sh"</code> (ソース・ハッシュ) です。 詳しくは、[2.0: スケジューリング・アルゴリズム](#scheduling)を参照してください。</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>アプリ・デプロイメント YAML の <code>spec.template.metadata.labels</code> セクションで使用したラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>)。</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>サービスが listen するポート。</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>オプション: プライベート NLB を作成するには、またはパブリック NLB 用に特定のポータブル IP アドレスを使用するには、使用する IP アドレスを指定します。 IP アドレスは、アノテーションで指定する VLAN 上になければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上にのみ存在する場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td><code>Local</code> に設定します。</td>
        </tr>
        </tbody></table>

    3.  オプション: 制限範囲の IP アドレスでのみ NLB サービスを使用できるようにするには、`spec.loadBalancerSourceRanges` フィールドで IP を指定します。 `loadBalancerSourceRanges` は、ワーカー・ノード上の Iptables ルールを介してクラスター内の `kube-proxy` によって実装されます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

    4.  クラスター内にサービスを作成します。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  NLB サービスが正常に作成されたことを確認します。 サービスが作成され、アプリが利用可能になるまでに数分かかることがあります。

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

    **LoadBalancer Ingress** IP アドレスは、NLB サービスに割り当てられたポータブル・パブリック IP アドレスです。

4.  パブリック NLB を作成した場合、インターネットからアプリにアクセスします。
    1.  任意の Web ブラウザーを開きます。
    2.  NLB のポータブル・パブリック IP アドレスとポートを入力します。

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. オプション: NLB サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](/docs/containers?topic=containers-nodeport) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 NLB サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサー・サービスまたはノード・ポート・サービスへのインバウンド・トラフィックの制御](/docs/containers?topic=containers-network_policies#block_ingress)を参照してください。

次に、[NLB ホスト名を登録](/docs/containers?topic=containers-loadbalancer_hostname)できます。

<br />


## スケジューリング・アルゴリズム
{: #scheduling}

NLB 2.0 がネットワーク接続をアプリ・ポッドにどのように割り当てるかは、スケジューリング・アルゴリズムによって決まります。 クライアント要求がクラスターに到着すると、NLB は、スケジューリング・アルゴリズムに基づいて要求パケットをワーカー・ノードにルーティングします。 スケジューリング・アルゴリズムを使用するには、NLB サービス構成ファイルのスケジューラー・アノテーションで、その Keepalived 短縮名を指定します (`service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`)。 以下のリストで、{{site.data.keyword.containerlong_notm}} でサポートされるスケジューリング・アルゴリズムを確認してください。 スケジューリング・アルゴリズムを指定しない場合は、デフォルトでラウンドロビン・アルゴリズムが使用されます。 詳しくは、[Keepalived の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://www.Keepalived.org/doc/scheduling_algorithms.html) を参照してください。
{: shortdesc}

### サポートされるスケジューリング・アルゴリズム
{: #scheduling_supported}

<dl>
<dt>ラウンドロビン (<code>rr</code>)</dt>
<dd>NLB は、アプリ・ポッドのリスト順に接続をワーカー・ノードにルーティングし、各アプリ・ポッドを均等に扱います。 ラウンドロビンは、バージョン 2.0 の NLB のデフォルトのスケジューリング・アルゴリズムです。</dd>
<dt>ソース・ハッシュ (<code>sh</code>)</dt>
<dd>NLB は、クライアント要求パケットのソース IP アドレスに基づいてハッシュ・キーを生成します。 次に NLB は、静的に割り当てられたハッシュ・テーブルでそのハッシュ・キーを検索し、該当範囲のハッシュを処理するアプリ・ポッドに要求をルーティングします。 このアルゴリズムにより、特定のクライアントからの要求は常に同じアプリ・ポッドに送信されるようになります。</br>**注**: Kubernetes では Iptable 規則が使用されるので、ワーカー上のランダム・ポッドに要求が送信されます。 このスケジューリング・アルゴリズムを使用するには、ワーカー・ノード 1 つにつきアプリ・ポッドが 1 つのみデプロイされるようにする必要があります。 例えば、各ポッドのラベルが <code>run =&lt;app_name&gt;</code> であれば、アプリ・デプロイメントの <code>spec</code> セクションに以下のアンチアフィニティー・ルールを追加します。</br>
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
<dd>パケットの宛先 (NLB の IP アドレスとポート) を使用して、着信要求を処理するワーカー・ノードが決定されます。 ただし、{{site.data.keyword.containerlong_notm}} 内の NLB の IP アドレスとポートは変わりません。 NLB が存在するワーカー・ノードから要求が出ていかず、1 つのワーカー上のアプリ・ポッドのみがすべての着信要求を処理することになります。</dd>
<dt>動的接続カウント・アルゴリズム</dt>
<dd>以下のアルゴリズムは、クライアントと NLB の間の動的な接続数に基づくものです。 しかし、直接サービス・リターン (DSR) では NLB 2.0 のポッドがパケットのリターン・パスに含まれないため、NLB は確立された接続を追跡しません。<ul>
<li>最少接続 (<code>lc</code>)</li>
<li>局所的な最少接続 (<code>lblc</code>)</li>
<li>複製付きの局所的な最少接続 (<code>lblcr</code>)</li>
<li>キューなし (<code>nq</code>)</li>
<li>最短予期遅延 (<code>seq</code>)</li></ul></dd>
<dt>加重型ポッド・アルゴリズム</dt>
<dd>以下のアルゴリズムは、重みづけされたアプリ・ポッドに基づくものです。 しかし、{{site.data.keyword.containerlong_notm}} のロード・バランシングでは、すべてのアプリ・ポッドに等しい重みが割り当てられます。<ul>
<li>加重型最少接続 (<code>wlc</code>)</li>
<li>加重型ラウンドロビン (<code>wrr</code>)</li></ul></dd></dl>
