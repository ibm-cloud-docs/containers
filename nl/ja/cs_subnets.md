---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# クラスター用のサブネットの構成
{: #subnets}

クラスターにサブネットを追加して、使用可能なポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスのプールを変更します。
{:shortdesc}

{{site.data.keyword.containershort_notm}} では、クラスターにネットワーク・サブネットを追加して、Kubernetes サービス用の安定したポータブル IP を追加できます。 このケースでは、1 つ以上のクラスター間に接続を作成するための、ネットマスキングを指定するサブネットは使用されません。 代わりに、サービスへのアクセスに使用できるクラスターからそのサービスの永続的な固定 IP を利用できるように、サブネットが使用されます。

標準クラスターを作成すると、{{site.data.keyword.containershort_notm}} は、5 つのパブリック IP アドレスを持つポータブル・パブリック・サブネットと、5 つのプライベート IP アドレスを持つポータブル・プライベート・サブネットを自動的にプロビジョンします。 ポータブル・パブリック IP アドレスおよびポータブル・プライベート IP アドレスは静的で、ワーカー・ノードまたはクラスターが削除されても変更されません。 サブネットごとに、ポータブル・パブリック IP アドレスのうち 1 つとポータブル・プライベート IP アドレスのうち 1 つは [アプリケーション・ロード・バランサー](cs_ingress.html)用に使用され、これをクラスター内の複数のアプリを公開するために使用できます。 残りの 4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスは、[ロード・バランサー・サービスを作成して](cs_loadbalancer.html)単一アプリをパブリックに公開するために使用できます。

**注:** ポータブル IP アドレスは、月単位で課金されます。 クラスターのプロビジョンの後にポータブル・パブリック IP アドレスを削除する場合、短時間しか使用しない場合でも月額課金を支払う必要があります。

## クラスターのその他のサブネットの要求
{: #request}

クラスターにサブネットを割り当て、安定したポータブル・パブリック IP またはポータブル・プライベート IP をクラスターに追加できます。

**注:** クラスターでサブネットを使用できるようにすると、このサブネットの IP アドレスは、クラスターのネットワーキングの目的で使用されるようになります。 IP アドレスの競合を回避するため、1 つのサブネットは必ず 1 つのクラスターでのみ使用してください。 あるサブネットを複数のクラスターで使用したり、同時に他の目的で {{site.data.keyword.containershort_notm}}の外部で使用したりしないでください。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

IBM Cloud インフラストラクチャー (SoftLayer) アカウントでサブネットを作成し、指定されたクラスターでそのサブネットを使用できるようにするには、以下のようにします。

1. 新しいサブネットをプロビジョンします。

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>クラスターのためにサブネットをプロビジョンするコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td><code>&gt;cluster_name_or_id&lt;</code> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td><code>&gt;subnet_size&lt;</code> を、ポータブル・サブネットから追加する IP アドレスの数に置き換えます。 受け入れられる値は 8、16、32、64 です。 <p>**注:** サブネットのポータブル IP アドレスを追加する場合、3 つの IP アドレスはクラスター内ネットワークの確立のために使用されるため、これらのアドレスは、アプリケーション・ロード・バランサーでは、あるいはロード・バランサー・サービスの作成には使用できません。 例えば、8 個のポータブル・パブリック IP アドレスを要求する場合は、そのうちの 5 個を、アプリをパブリックに公開するために使用できます。</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td><code>&gt;VLAN_ID&lt;</code> を、ポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスの割り振り先となるパブリック VLAN またはプライベート VLAN の ID に置き換えます。 既存のワーカー・ノードが接続されているパブリック VLAN またはプライベート VLAN を選択する必要があります。 ワーカー・ノードのパブリック VLAN またはプライベート VLAN を確認するには、<code>bx cs worker-get &gt;worker_id&lt;</code> コマンドを実行します。</td>
    </tr>
    </tbody></table>

2.  クラスターにサブネットが正常に作成されて追加されたことを確認します。 サブネットの CIDR は **VLANs** セクションにリストされます。

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

<br />


## Kubernetes クラスターへの既存のカスタム・サブネットの追加
{: #custom}

既存のポータブル・パブリック・サブネットまたはポータブル・プライベート・サブネットを Kubernetes クラスターに追加できます。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにある、カスタム・ファイアウォール・ルールまたは使用可能な IP アドレスが設定された既存のサブネットを使用する場合は、サブネットなしでクラスターを作成し、クラスターをプロビジョンするときに既存のサブネットをクラスターで使用できるようにします。

1.  使用するサブネットを確認します。 サブネットの ID と VLAN ID をメモしてください。この例では、サブネット ID は 807861、VLAN ID は 1901230 です。

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  VLAN のロケーションを確認します。 この例では、ロケーションは dal10 です。

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  確認したロケーションと VLAN ID を使用して、クラスターを作成します。 新しいポータブル・パブリック IP サブネットと新しいポータブル・プライベート IP サブネットが自動的に作成されないようにするため、`--no-subnet` フラグを指定します。

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  クラスターの作成が要求されたことを確認します。

    ```
    bx cs clusters
    ```
    {: pre}

    **注:** ワーカー・ノード・マシンが配列され、クラスターがセットアップされて自分のアカウントにプロビジョンされるまでに、最大 15 分かかります。

    クラスターのプロビジョニングが完了すると、クラスターの状況が **deployed** に変わります。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  ワーカー・ノードの状況を確認します。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    ワーカー・ノードの準備が完了すると、状態が **normal** に変わり、状況が **Ready** になります。 ノードの状況が**「Ready」**になったら、クラスターにアクセスできます。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  サブネット ID を指定してクラスターにサブネットを追加します。 クラスターでサブネットを使用できるようにすると、使用できるすべての使用可能なポータブル・パブリックIP アドレスが含まれる Kubernetes config マップが作成されます。 アプリケーション・ロード・バランサーがまだクラスターに存在しない場合は、パブリック・アプリケーション・ロード・バランサーとプライベート・アプリケーション・ロード・バランサーを作成するために、1 つのポータブル・パブリック IP アドレスと 1 つのポータブル・プライベート IP アドレスが自動的に使用されます。 その他のすべてのポータブル・パブリック IP アドレスおよびポータブル・プライベート IP アドレスは、アプリのロード・バランサー・サービスの作成に使用できます。

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

<br />


## Kubernetes クラスターへのユーザー管理のサブネットと IP アドレスの追加
{: #user_managed}

{{site.data.keyword.containershort_notm}} のアクセス先となるオンプレミス・ネットワークのユーザー独自のサブネットを指定します。 その後、そのサブネットからのプライベート IP アドレスを、Kubernetes クラスターのロード・バランサー・サービスに追加できます。

要件:
- ユーザー管理のサブネットを追加できるのは、プライベート VLAN のみです。
- サブネットの接頭部の長さの限度は /24 から /30 です。 例えば、`203.0.113.0/24` は 253 個の使用可能なプライベート IP アドレスを示し、`203.0.113.0/30` は 1 つの使用可能なプライベート IP アドレスを示します。
- サブネットの最初の IP アドレスは、サブネットのゲートウェイとして使用する必要があります。

開始前に、以下のことを行います。
- 外部サブネットとのネットワーク・トラフィックの出入りのルーティングを構成します。
- IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオ内のプライベート・ネットワーク Vyatta またはクラスター内で実行されている Strongswan VPN サービスと、オンプレミス・データ・センター・ゲートウェイ・デバイスとの間に VPN 接続があることを確認してください。Vyatta の使用方法については、この[ブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) を参照してください。Strongswan の使用方法については、[Strongswan IPSec VPN サービスを使用した VPN 接続のセットアップ](cs_vpn.html)を参照してください。

1. クラスターのプライベート VLAN の ID を表示します。 **VLANs** セクションを見つけます。 **User-managed** フィールドで、_false_ となっている VLAN ID を見つけます。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. プライベート VLAN に外部サブネットを追加します。 ポータブル・プライベート IP アドレスがクラスターの構成マップに追加されます。

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    例:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. ユーザー提供のサブネットが追加されていることを確認します。 **User-managed** フィールドは _true_ です。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. プライベート・ネットワークを介してアプリにアクセスするために、プライベート・ロード・バランサー・サービスまたはプライベート Ingress アプリケーション・ロード・バランサーを追加します。 プライベート・ロード・バランサーまたはプライベート Ingress アプリケーション・ロード・バランサーの作成時に追加したサブネットのプライベート IP アドレスを使用する場合は、IP アドレスを指定する必要があります。 使用しない場合は、IP アドレスは IBM Cloud インフラストラクチャー (SoftLayer) サブネット、またはプライベート VLAN 上のユーザー提供のサブネットからランダムに選択されます。 詳しくは、[ロード・バランサー・タイプのサービスを使用してアプリへのアクセスを構成する方法](cs_loadbalancer.html#config)または[プライベート・アプリケーションのロード・バランサーを有効にする](cs_ingress.html#private_ingress)を参照してください。

<br />


## IP アドレスとサブネットの管理
{: #manage}

ポータブル・パブリック・サブネット、ポータブル・プライベート・サブネット、ポータブル・パブリック IP アドレス、ポータブル・プライベート IP アドレスを使用してクラスター内のアプリを公開し、インターネットからまたはプライベート・ネットワーク上でアクセス可能にすることができます。
{:shortdesc}

{{site.data.keyword.containershort_notm}} では、クラスターにネットワーク・サブネットを追加して、Kubernetes サービス用の安定したポータブル IP を追加できます。 標準クラスターを作成すると、{{site.data.keyword.containershort_notm}} は、1 つのポータブル・パブリック・サブネットと 5 つのポータブル・パブリック IP アドレス、および 1 つのポータブル・プライベート・サブネットと 5 つのポータブル・プライベート IP アドレスを自動的にプロビジョンします。 ポータブル IP アドレスは静的で、ワーカー・ノードまたはクラスターが削除されても変更されません。

これらのポータブル IP アドレスのうち 2 つ (1 つはパブリック、1 つはプライベート) は、クラスター内の複数のアプリを公開するために使用できる [Ingress アプリケーション・ロード・バランサー](cs_ingress.html)に使用されます。 4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスは、[ロード・バランサー・サービスを作成して](cs_loadbalancer.html)アプリを公開するために使用できます。

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

<br />




## 使用されている IP アドレスの解放
{: #free}

ポータブル IP アドレスを使用しているロード・バランサー・サービスを削除することによって、使用されているポータブル IP アドレスを解放できます。

始めに、[使用するクラスターのコンテキストを設定してください。](cs_cli_install.html#cs_cli_configure)

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
