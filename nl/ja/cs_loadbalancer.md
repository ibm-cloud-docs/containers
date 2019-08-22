---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb1.0, nlb

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


# NLB 1.0 のセットアップ
{: #loadbalancer}

ポートを公開し、レイヤー 4 のネットワーク・ロード・バランサー (NLB) のポータブル IP アドレスを使用して、コンテナー化アプリを公開します。バージョン 1.0 の NLB については、[NLB 1.0 のコンポーネントおよびアーキテクチャー](/docs/containers?topic=containers-loadbalancer-about#v1_planning)を参照してください。
{:shortdesc}

素早く開始するには、以下のコマンドを実行して、ロード・バランサー 1.0 を作成します。
```
kubectl expose deploy my-app --port=80 --target-port=8080 --type=LoadBalancer --name my-lb-svc
```
{: pre}

## 複数ゾーン・クラスターでの NLB 1.0 のセットアップ
{: #multi_zone_config}

**始める前に**:
* パブリック・ネットワーク・ロード・バランサー (NLB) を複数のゾーンに作成するためには、ゾーンごとに 1 つ以上のパブリック VLAN にポータブル・サブネットを用意する必要があります。 プライベート NLB を複数のゾーンに作成するためには、ゾーンごとに 1 つ以上のプライベート VLAN にポータブル・サブネットを用意する必要があります。 [クラスター用のサブネットの構成](/docs/containers?topic=containers-subnets)に記載されているステップに従うことにより、サブネットを追加できます。
* ネットワーク・トラフィックをエッジ・ワーカー・ノードに制限する場合は、NLB が均等にデプロイされるように、各ゾーンで 2 つ以上の[エッジ・ワーカー・ノード](/docs/containers?topic=containers-edge#edge)を有効にしてください。
* IBM Cloud インフラストラクチャー・アカウントに対して [VLAN スパンニング](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)を有効にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにします。 この操作を実行するには、**「ネットワーク」>「ネットワーク VLAN スパンニングの管理」**で設定する[インフラストラクチャー権限](/docs/containers?topic=containers-users#infra_access)が必要です。ない場合は、アカウント所有者に対応を依頼してください。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get<region>` [コマンド](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get)を使用します。
* `default` 名前空間に対する[**ライター**または**管理者**の {{site.data.keyword.cloud_notm}} IAM サービス役割](/docs/containers?topic=containers-users#platform)があることを確認してください。


複数ゾーン・クラスターで NLB 1.0 サービスをセットアップするには、次の手順を実行します。
1.  [アプリをクラスターにデプロイします](/docs/containers?topic=containers-app#app_cli)。 デプロイメント構成ファイルの metadata セクションに、ラベルを追加しておく必要があります。このラベルは、アプリが実行されるすべてのポッドを識別してロード・バランシングに含めるために必要です。

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
        <td><code>selector</code></td>
        <td>アプリ・デプロイメント YAML の <code>spec.template.metadata.labels</code> セクションで使用したラベル・キー (<em>&lt;selector_key&gt;</em>) と値 (<em>&lt;selector_value&gt;</em>)。</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>サービスが listen するポート。</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>オプション: プライベート・ロード・バランサーを作成するには、またはパブリック・ロード・バランサー用に特定のポータブル IP アドレスを使用するには、使用する IP アドレスを指定します。 IP アドレスは、アノテーションで指定する VLAN とゾーンになければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上にのみ存在する場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
      </tr>
      </tbody></table>

      プライベート VLAN `2234945` 上の指定した IP アドレスを使用するプライベート NLB 1.0 サービスを `dal12` に作成するための構成ファイルの例:

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

  3. オプション: 制限範囲の IP アドレスでのみ NLB サービスを使用できるようにするには、`spec.loadBalancerSourceRanges` フィールドで IP を指定します。 `loadBalancerSourceRanges` は、ワーカー・ノード上の Iptables ルールを介してクラスター内の `kube-proxy` によって実装されます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

  4. クラスター内にサービスを作成します。

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. NLB サービスが正常に作成されたことを確認します。 サービスが作成され、アプリが利用可能になるまでに数分かかることがあります。

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

5. ステップ 2 から 4 を繰り返して、各ゾーンにバージョン 1.0 の NLB を追加します。    

6. [NLB 1.0 のソース IP 保持を有効にする](#node_affinity_tolerations)場合は必ず、[アプリ・ポッドにエッジ・ノード・アフィニティーを追加](#lb_edge_nodes)して、エッジ・ワーカー・ノードにアプリ・ポッドをスケジュールするようにしてください。 着信要求を受信するには、アプリ・ポッドをエッジ・ノードにスケジュールする必要があります。

7. オプション: ロード・バランサー・サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](/docs/containers?topic=containers-nodeport) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 NLB サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサー・サービスまたはノード・ポート・サービスへのインバウンド・トラフィックの制御](/docs/containers?topic=containers-network_policies#block_ingress)を参照してください。

次に、[NLB ホスト名を登録](/docs/containers?topic=containers-loadbalancer_hostname)できます。

<br />


## 単一ゾーン・クラスターでの NLB 1.0 のセットアップ
{: #lb_config}

**始める前に**:
* ネットワーク・ロード・バランサー (NLB) サービスに割り当てることのできるポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスが必要です。 詳しくは、[クラスター用のサブネットの構成](/docs/containers?topic=containers-subnets)を参照してください。
* `default` 名前空間に対する[**ライター**または**管理者**の {{site.data.keyword.cloud_notm}} IAM サービス役割](/docs/containers?topic=containers-users#platform)があることを確認してください。

単一ゾーン・クラスターで NLB 1.0 サービスを作成するには、以下のようにします。

1.  [アプリをクラスターにデプロイします](/docs/containers?topic=containers-app#app_cli)。 構成ファイルの metadata セクションで、デプロイメントにラベルを追加しておく必要があります。 このラベルは、アプリが実行されるすべてのポッドをロード・バランシングに含めるためにそれらのポッドを識別する上で必要です。
2.  パブリック・インターネットまたはプライベート・ネットワークに公開するアプリのロード・バランサー・サービスを作成します。
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
          <td><code>private</code> または <code>public</code> のロード・バランサーを指定するアノテーション。</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>ロード・バランサー・サービスのデプロイ先の VLAN を指定するアノテーション。 VLAN を表示するには、<code>ibmcloud ks vlans --zone <zone></code> を実行します。</td>
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
          <td>オプション: プライベート・ロード・バランサーを作成するには、またはパブリック・ロード・バランサー用に特定のポータブル IP アドレスを使用するには、使用する IP アドレスを指定します。 IP アドレスは、アノテーションで指定する VLAN 上になければなりません。 IP アドレスを指定しない場合、以下のようになります。<ul><li>クラスターがパブリック VLAN 上にある場合、ポータブル・パブリック IP アドレスが使用されます。 ほとんどのクラスターはパブリック VLAN 上にあります。</li><li>クラスターがプライベート VLAN 上にのみ存在する場合は、ポータブル・プライベート IP アドレスが使用されます。</li></ul></td>
        </tr>
        </tbody></table>

        プライベート VLAN `2234945` 上の指定した IP アドレスを使用するプライベート NLB 1.0 サービスを作成するための構成ファイルの例:

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

    3. オプション: 制限範囲の IP アドレスでのみ NLB サービスを使用できるようにするには、`spec.loadBalancerSourceRanges` フィールドで IP を指定します。 `loadBalancerSourceRanges` は、ワーカー・ノード上の Iptables ルールを介してクラスター内の `kube-proxy` によって実装されます。 詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/) を参照してください。

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

5. [NLB 1.0 のソース IP 保持を有効にする](#node_affinity_tolerations)場合は必ず、[アプリ・ポッドにエッジ・ノード・アフィニティーを追加](#lb_edge_nodes)して、エッジ・ワーカー・ノードにアプリ・ポッドをスケジュールするようにしてください。 着信要求を受信するには、アプリ・ポッドをエッジ・ノードにスケジュールする必要があります。

6. オプション: ロード・バランサー・サービスは、サービスの NodePort を介してアプリを使用できるようにします。 [NodePort](/docs/containers?topic=containers-nodeport) には、クラスター内のすべてのノードのすべてのパブリック IP アドレスおよびプライベート IP アドレスでアクセスできます。 NLB サービスを使用しつつ、NodePort へのトラフィックをブロックするには、[ロード・バランサー・サービスまたはノード・ポート・サービスへのインバウンド・トラフィックの制御](/docs/containers?topic=containers-network_policies#block_ingress)を参照してください。

次に、[NLB ホスト名を登録](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname)できます。

<br />


## ソース IP 保持の有効化
{: #node_affinity_tolerations}

この機能は、バージョン 1.0 のネットワーク・ロード・バランサー (NLB) にのみあります。 バージョン 2.0 の NLB では、クライアント要求のソース IP アドレスはデフォルトで保持されます。
{: note}

アプリへのクライアント要求がクラスターに送信されると、ロード・バランサー・サービス・ポッドがその要求を受け取ります。 ロード・バランサー・サービス・ポッドと同じワーカー・ノードにアプリ・ポッドが存在しない場合、NLB は異なるワーカー・ノード上のアプリ・ポッドに要求を転送します。 パッケージのソース IP アドレスは、ロード・バランサー・サービス・ポッドが実行されているワーカー・ノードのパブリック IP アドレスに変更されます。
{: shortdesc}

クライアント要求の元のソース IP アドレスを保持するには、ロード・バランサー・サービスの[ソース IP を有効化 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) します。 TCP の接続先はアプリ・ポッドになるので、アプリはイニシエーターの実際のソース IP アドレスを認識できます。 クライアントの IP を保持すると、例えば、アプリ・サーバーがセキュリティーやアクセス制御ポリシーを適用する必要がある場合などに役に立ちます。

ソース IP を有効にした場合は、ロード・バランサー・サービス・ポッドは、同じワーカー・ノードにデプロイされているアプリ・ポッドにのみ要求を転送しなければなりません。 通常、ロード・バランサー・サービス・ポッドも、アプリ・ポッドをデプロイしたワーカー・ノードにデプロイされます。 しかし、次のように、ロード・バランサー・ポッドとアプリ・ポッドが同じワーカー・ノードにスケジュールされない状況もあります。

* エッジ・ノードにテイントがあるため、これらのエッジ・ノードにデプロイできるのはロード・バランサー・サービス・ポッドのみです。 このようなノードにはアプリ・ポッドをデプロイできません。
* 複数のパブリック VLAN またはプライベート VLAN にクラスターが接続されている場合、1 つの VLAN のみに接続されているワーカー・ノードにアプリ・ポッドはデプロイされます。 NLB の IP アドレスがワーカー・ノードとは別の VLAN に接続されているという理由で、このようなワーカー・ノードにはロード・バランサー・サービス・ポッドはデプロイされない可能性があります。

ロード・バランサー・サービス・ポッドもデプロイできる特定のワーカー・ノードに強制的にアプリをデプロイするには、アフィニティー・ルールと耐障害性をアプリのデプロイメントに追加する必要があります。

### エッジ・ノードのアフィニティー・ルールと耐障害性を追加する
{: #lb_edge_nodes}

[ワーカー・ノードにエッジ・ノードのラベルを付け](/docs/containers?topic=containers-edge#edge_nodes)、さらに[エッジ・ノードにテイントを適用する](/docs/containers?topic=containers-edge#edge_workloads)場合、ロード・バランサー・サービス・ポッドはそれらのエッジ・ノードにのみデプロイされ、アプリ・ポッドはエッジ・ノードにデプロイできません。 NLB サービスでソース IP が有効になっている場合、エッジ・ノード上のロード・バランサー・ポッドは、着信要求を他のワーカー・ノード上のアプリ・ポッドに転送できません。
{:shortdesc}

アプリ・ポッドをエッジ・ノードに強制的にデプロイするには、エッジ・ノードの[アフィニティー・ルール ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) と[耐障害性 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) をアプリのデプロイメントに追加します。

エッジ・ノード・アフィニティーとエッジ・ノード耐障害性を追加したデプロイメント YAML のサンプル

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  selector:
    matchLabels:
      <label_name>: <label_value>
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

複数のパブリック VLAN またはプライベート VLAN にクラスターが接続されている場合は、1 つの VLAN のみに接続されているワーカー・ノードにアプリ・ポッドはデプロイされる可能性があります。 NLB の IP アドレスが、そのようなワーカー・ノードとは別の VLAN に接続されていると、ロード・バランサー・サービス・ポッドはそのようなワーカー・ノードにデプロイされません。
{:shortdesc}

ソース IP を有効にした場合は、アフィニティー・ルールをアプリのデプロイメントに追加して、NLB の IP アドレスと同じ VLAN にあるワーカー・ノードにアプリ・ポッドをスケジュールしてください。

開始前に、以下のことを行います。 [アカウントにログインします。 該当する場合は、適切なリソース・グループをターゲットにします。 クラスターのコンテキストを設定します。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. NLB サービスのパブリック IP アドレスを取得します。 **LoadBalancer Ingress** フィールドの IP アドレスを確認してください。
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. NLB サービスが接続する VLAN ID を取得します。

    1. クラスターのポータブル・パブリック VLAN をリストします。
        ```
        ibmcloud ks cluster-get --cluster <cluster_name_or_ID> --showResources
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

    2. **Subnet VLANs** の下にある出力で、先ほど取得した NLB の IP アドレスと一致するサブネット CIDR を見つけ、その VLAN ID をメモします。

        例えば、NLB サービスの IP アドレスが `169.36.5.xxx` の場合、前のステップの出力例で一致するサブネットは `169.36.5.xxx/29` です。 そのサブネットが接続する VLAN ID は、`2234945` です。

3. アプリのデプロイメントに、前の手順でメモした VLAN ID に対する[アフィニティー・ルールを追加 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) します。

    例えば、複数の VLAN がある場合に、`2234945` のパブリック VLAN にあるワーカー・ノードにのみアプリ・ポッドをデプロイするには、以下のようにします。

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      selector:
        matchLabels:
          <label_name>: <label_value>
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
