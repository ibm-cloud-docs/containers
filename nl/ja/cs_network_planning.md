---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 外部ネットワークを使用してアプリを公開するための計画
{: #planning}

{{site.data.keyword.containerlong}} では、アプリをパブリックまたはプライベートでアクセス可能にして外部ネットワークを管理できます。
{: shortdesc}

## NodePort、LoadBalancer、または Ingress サービスの選択
{: #external}

パブリック・インターネットまたはプライベート・ネットワークを使用して外部からアプリにアクセスできるようにするために、{{site.data.keyword.containerlong_notm}} は 3 つのネットワーク・サービスをサポートしています。
{:shortdesc}

**[NodePort サービス](cs_nodeport.html)** (フリー・クラスターと標準クラスター)
* すべてのワーカー・ノードのポートを公開し、ワーカー・ノードのパブリック IP アドレスまたはプライベート IP アドレスを使用して、クラスター内のサービスにアクセスを行います。
* Iptables は、アプリのポッド間で要求のロード・バランスを取る Linux カーネル・フィーチャーで、パフォーマンスの高いネットワーク・ルーティングを実現し、ネットワーク・アクセス制御を行います。
* ワーカー・ノードのパブリックおよびプライベート IP アドレスは永続的ではありません。 ワーカー・ノードが削除されたり再作成されたりすると、新しいパブリック IP アドレスと新しいプライベート IP アドレスがワーカー・ノードに割り当てられます。
* NodePort サービスは、パブリック・アクセスまたはプライベート・アクセスのテスト用として優れています。 これはパブリック・アクセスまたはプライベート・アクセスを短時間だけ必要とする場合にも使用できます。

**[LoadBalancer サービス](cs_loadbalancer.html)** (標準クラスターのみ)
* どの標準クラスターにも 4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスがプロビジョンされます。そのアドレスを使用して、アプリ用の外部 TCP/UDP ロード・バランサーを作成できます。
* Iptables は、アプリのポッド間で要求のロード・バランスを取る Linux カーネル・フィーチャーで、パフォーマンスの高いネットワーク・ルーティングを実現し、ネットワーク・アクセス制御を行います。
* ロード・バランサーに割り当てられるポータブル・パブリック IP アドレスおよびプライベート IP アドレスは永続的なアドレスであり、クラスターでワーカー・ノードが再作成されても変更されません。
* アプリで必要なすべてのポートを公開することによってロード・バランサーをカスタマイズすることも可能です。

**[Ingress](cs_ingress.html)** (標準クラスターのみ)
* 1 つの外部 HTTP または HTTPS、TCP、または UDP アプリケーション・ロード・バランサー (ALB) を作成して、クラスター内の複数のアプリを公開します。 ALB は、保護された固有のパブリック・エントリー・ポイントまたはプライベート・エントリー・ポイントを使用して、着信要求をアプリにルーティングします。
* 1 つのルートを使用してクラスター内の複数のアプリをサービスとして公開できます。
* Ingress は、以下の 3 つのコンポーネントで構成されています。
  * Ingress リソースでは、アプリに対する着信要求のルーティングとロード・バランシングの方法に関するルールを定義します。
  * ALB は、着信 HTTP または HTTPS、TCP、または UDP サービス要求を listen します。 これは、Ingress リソースで定義したルールに基づいて、アプリのポッド間で要求を転送します。
  * 複数ゾーン・ロード・バランサー (MZLB) は、アプリへのすべての着信要求を処理し、さまざまなゾーンに存在する ALB の間で要求のロード・バランシングを行います。
* カスタム・ルーティング・ルールを使用して独自の ALB を実装する場合や、アプリに SSL 終端が必要な場合に Ingress を使用します。

アプリにとって最適なネットワーク・サービスを選ぶために、このデシジョン・ツリーをたどって、いずれかのオプションをクリックしてください。

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="このイメージは、アプリケーションに最適なネットワーキング・オプションを選択する手順を説明しています。このイメージが表示されない場合でも、文書内で情報を見つけることができます。" style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Nodeport サービス" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="LoadBalancer サービス" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Ingress サービス" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## パブリック外部ネットワーキングの計画
{: #public_access}

{{site.data.keyword.containerlong_notm}} で Kubernetes クラスターを作成した場合、そのクラスターはパブリック VLAN に接続できます。 パブリック VLAN により、各ワーカー・ノードに割り当てられるパブリック IP アドレスが決まり、ワーカー・ノードにパブリック・ネットワーク・インターフェースが提供されます。
{:shortdesc}

アプリをインターネットで公開するには、NodePort、LoadBalancer、または Ingress サービスを作成します。 各サービスを比較するには、[NodePort、LoadBalancer、または Ingress サービスの選択](#external)を参照してください。

次の図は、Kubernetes が {{site.data.keyword.containerlong_notm}} でパブリック・ネットワーク・トラフィックを転送する方法を示しています。

![{{site.data.keyword.containerlong_notm}} Kubernetes アーキテクチャー](images/networking.png)

*{{site.data.keyword.containerlong_notm}} での Kubernetes データ・プレーン*

フリー・クラスターと標準クラスターの両方とも、ワーカー・ノードのパブリック・ネットワーク・インターフェースは Calico ネットワーク・ポリシーによって保護されます。 デフォルトでは、これらのポリシーは大部分のインバウンド・トラフィックをブロックします。 ただし、Kubernetes が機能するために必要なインバウンド・トラフィックは、NodePort、LoadBalancer、Ingress の各サービスへの接続と同様に、許可されます。 ポリシーの変更方法を含め、これらのポリシーの詳細については、[ネットワーク・ポリシー](cs_network_policy.html#network_policies)を参照してください。

サブネット、ファイアウォール、および VPN の情報を含め、ネットワーク用のクラスターのセットアップについて詳しくは、[デフォルトのクラスター・ネットワークの計画](cs_network_cluster.html#both_vlans)を参照してください。

<br />


## パブリックおよびプライベート VLAN を使用するセットアップのためのプライベート外部ネットワーキングの計画
{: #private_both_vlans}

ワーカー・ノードがパブリック VLAN とプライベート VLAN の両方に接続されている場合は、プライベートの NodePort、LoadBalancer、または Ingress サービスを作成して、プライベート・ネットワークからのみ、アプリにアクセスできるようにできます。 次に、サービスへのパブリック・トラフィックをブロックする Calico ポリシーを作成できます。

**NodePort**
* [NodePort サービスを作成します](cs_nodeport.html)。 NodePort サービスは、パブリック IP アドレスに加えて、ワーカー・ノードのプライベート IP アドレスを介して利用可能です。
* NodePort サービスは、ワーカー・ノードのプライベート IP アドレスとパブリック IP アドレスの両方に対して、ワーカー・ノード上のポートを開きます。 [Calico preDNAT ネットワーク・ポリシー](cs_network_policy.html#block_ingress) を使用してパブリック NodePort をブロックする必要があります。

**LoadBalancer**
* [プライベート LoadBalancer サービスを作成します](cs_loadbalancer.html)。
* ポータブル・プライベート IP アドレスを使用するロード・バランサー・サービスでは、すべてのワーカー・ノードでパブリック・ノード・ポートも開いています。 [Calico preDNAT ネットワーク・ポリシー](cs_network_policy.html#block_ingress) を使用して、そのパブリック・ノード・ポートをブロックする必要があります。

**Ingress**
* クラスターを作成すると、Ingress アプリケーション・ロード・バランサー (ALB) がパブリック用とプライベート用に 1 つずつ自動的に作成されます。 デフォルトでは、パブリック ALB が有効に、プライベート ALB が無効になっているため、[パブリック ALB を無効](cs_cli_reference.html#cs_alb_configure)にし、[プライベート ALB を有効](cs_ingress.html#private_ingress)にする必要があります。
* それから、[プライベート Ingress サービスを作成します](cs_ingress.html#ingress_expose_private)。

例えば、プライベート・ロード・バランサー・サービスを作成したとします。 また、ロード・バランサーによって開かれたパブリック NodePort へのパブリック・トラフィックの到達をブロックする Calico preDNAT ポリシーを作成しました。 このプライベート・ロード・バランサーには、以下がアクセスできます。
* 同じクラスター内のポッド
* 同じ IBM Cloud アカウント内のクラスター内のポッド
* [VLAN スパンニングが有効になっている](cs_subnets.html#subnet-routing)場合、同じ IBM Cloud アカウント内のいずれかのプライベート VLAN に接続されているすべてのシステム
* IBM Cloud アカウントに含まれていないが、会社のファイアウォールの背後にある場合は、ロード・バランサー IP があるサブネットへの VPN 接続を介するすべてのシステム
* 異なる IBM Cloud アカウントに含まれている場合は、ロード・バランサー IP があるサブネットへの VPN 接続を介するすべてのシステム

サブネット、ファイアウォール、および VPN の情報を含め、ネットワーク用のクラスターのセットアップについて詳しくは、[デフォルトのクラスター・ネットワークの計画](cs_network_cluster.html#both_vlans)を参照してください。

<br />


## プライベート VLAN セットアップ専用のプライベート外部ネットワーキングの計画
{: #private_vlan}

ワーカー・ノードがプライベート VLAN のみに接続されている場合は、プライベートの NodePort、LoadBalancer、または Ingress サービスを作成して、プライベート・ネットワークからのみ、アプリにアクセスできるようにできます。 ワーカー・ノードはパブリック VLAN に接続されていないため、パブリック・トラフィックはこれらのサービスに転送されません。

**NodePort**:
* [プライベート NodePort サービスを作成します](cs_nodeport.html)。 このサービスは、ワーカー・ノードのプライベート IP アドレスを介して利用可能です。
* プライベート・ファイアウォールで、すべてのワーカー・ノードのプライベート IP アドレスにサービスをデプロイしたときに構成したポートを開き、トラフィックを許可します。 ポートを見つけるには、`kubectl get svc` を実行します。 ポートの範囲は 20000 から 32000 までです。

**LoadBalancer**
* [プライベート LoadBalancer サービスを作成します](cs_loadbalancer.html)。 クラスターがプライベート VLAN 上にしかない場合、使用可能な 4 つのポータブル・プライベート IP アドレスのいずれかが使用されます。
* プライベート・ファイアウォールで、ロード・バランサー・サービスのプライベート IP アドレスにサービスをデプロイしたときに構成したポートを開きます。

**Ingress**:
* [プライベート・ネットワークで使用可能な DNS サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) を構成する必要があります。
* クラスターを作成すると、プライベート Ingress アプリケーション・ロード・バランサー (ALB) が自動的に作成されますが、デフォルトでは有効にされていません。 [プライベート ALB を有効にする](cs_ingress.html#private_ingress)必要があります。
* それから、[プライベート Ingress サービスを作成します](cs_ingress.html#ingress_expose_private)。
* プライベート・ファイアウォールで、HTTP 用のポート 80 または HTTPS 用のポート 443 を、プライベート ALB の IP アドレスに対して開きます。

サブネット、ゲートウェイ・アプライアンスの情報を含め、ネットワーク用のクラスターのセットアップについて詳しくは、[プライベート VLAN セットアップ専用のネットワークの計画](cs_network_cluster.html#private_vlan)を参照してください。
