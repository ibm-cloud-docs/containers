---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}}のセキュリティー
{: #security}

標準装備のセキュリティー・フィーチャーをリスク分析とセキュリティー保護に使用できます。 これらのフィーチャーは、クラスター・インフラストラクチャーとネットワーク通信を保護し、コンピュート・リソースを分離し、インフラストラクチャー・コンポーネントとコンテナー・デプロイメントにおけるセキュリティー・コンプライアンスを確保するためのものです。
{: shortdesc}

## クラスター・コンポーネントによるセキュリティー
{: #cluster}

各 {{site.data.keyword.containerlong_notm}} クラスターには、その[マスター](#master)と[ワーカー](#worker)・ノードに組み込まれたセキュリティー・フィーチャーがあります。ファイアウォールがある場合、クラスター外からロード・バランシングにアクセスする必要がある場合、または公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときにローカル・システムから `kubectl` コマンドを実行しようとしている場合は、[ファイアウォールでポートを開き](cs_firewall.html#firewall)ます。 クラスター内のアプリをオンプレミス・ネットワークまたはクラスター外の他のアプリに接続しようとしている場合は、[VPN 接続をセットアップ](cs_vpn.html#vpn)します。
{: shortdesc}

次の図には、セキュリティー・フィーチャーが、Kubernetes マスター、ワーカー・ノード、コンテナー・イメージのグループ別に示されています。

<img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} クラスター・セキュリティー" style="width:400px; border-style: none"/>


  <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> {{site.data.keyword.containershort_notm}} での組み込みのクラスター・セキュリティー設定</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes マスター</td>
      <td>各クラスターの Kubernetes マスターは IBM によって管理され、高い可用性を備えています。 マスターには、セキュリティー・コンプライアンスを確保し、ワーカー・ノードとの間の通信を保護するための {{site.data.keyword.containershort_notm}} セキュリティー設定が含まれています。 更新は IBM が必要に応じて行います。 専用 Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを一元的に制御してモニターします。 デプロイメント要件とクラスターの容量に基づき、Kubernetes マスターは、コンテナー化されたアプリが使用可能なワーカー・ノードにデプロイされるように自動的にスケジュール設定します。 詳しくは、[Kubernetes マスターのセキュリティー](#master)を参照してください。</td>
    </tr>
    <tr>
      <td>ワーカー・ノード</td>
      <td>コンテナーはワーカー・ノードにデプロイされます。ワーカー・ノードは特定の 1 つのクラスターのために専用で使用されるので、IBM のお客様に提供されるコンピュート、ネットワーク、およびストレージがそれぞれ分離されます。 {{site.data.keyword.containershort_notm}} が備える組み込みセキュリティー機能により、プライベート・ネットワークとパブリック・ネットワークのワーカー・ノードのセキュリティーを維持し、ワーカー・ノードのセキュリティー・コンプライアンスを遵守できます。 詳しくは、[ワーカー・ノードのセキュリティー](#worker)を参照してください。 さらに、[Calico ネットワーク・ポリシー](cs_network_policy.html#network_policies)を追加して、ワーカー・ノード上のポッドを出入りするネットワーク・トラフィックのどれを許可し、どれをブロックするかを指定することができます。 </td>
     </tr>
     <tr>
      <td>イメージ</td>
      <td>クラスター管理者は、保護された独自の Docker イメージ・リポジトリーを {{site.data.keyword.registryshort_notm}} にセットアップできます。このレジストリーに Docker イメージを保管してクラスター・ユーザー間で共有することができます。 安全にコンテナー・デプロイメントを行うために、プライベート・レジストリー内のすべてのイメージが Vulnerability Advisor によってスキャンされます。 Vulnerability Advisor は {{site.data.keyword.registryshort_notm}}のコンポーネントであり、潜在的な脆弱性がないかスキャンし、セキュリティーに関する推奨を行い、脆弱性を解決するための方法を提示します。 詳しくは、[{{site.data.keyword.containershort_notm}} のイメージ・セキュリティー](#images)を参照してください。</td>
    </tr>
  </tbody>
</table>

<br />


## Kubernetes マスター
{: #master}

Kubernetes マスターを保護し、クラスター・ネットワーク通信をセキュリティーで保護するための Kubernetes マスターの組み込みセキュリティー機能について説明します。
{: shortdesc}

<dl>
  <dt>完全に管理される専用 Kubernetes マスター</dt>
    <dd>{{site.data.keyword.containershort_notm}} に含まれる Kubernetes クラスターはすべて、IBM が所有する IBM Cloud インフラストラクチャー (SoftLayer) アカウントで、IBM が管理する専用 Kubernetes マスターにより制御されます。 Kubernetes マスターは、他の IBM のお客様とは共用されない、以下の専用コンポーネントを使用してセットアップされます。
    <ul><li>etcd データ・ストア: サービス、デプロイメント、ポッドなどのクラスターのすべての Kubernetes リソースを保管します。 Kubernetes ConfigMaps および Secrets は、ポッドで実行されるアプリで使用できるように、キー値ペアとして保管されるアプリ・データです。 etcd のデータは IBM によって管理される暗号化ディスクに保管され、ポッドに送信されるときには TLS で暗号化されるので、データの保護と完全性が確保されます。</li>
    <li>kube-apiserver: ワーカー・ノードから Kubernetes マスターへのすべての要求のメインエントリー・ポイントとなります。 kube-apiserver は要求を検証して処理し、etcd データ・ストアに対する読み取り/書き込みを行うことができます。</li>
    <li>kube-scheduler: ポッドをどこにデプロイするかを決定します。このとき、キャパシティーとパフォーマンスのニーズ、ハードウェアとソフトウェアのポリシー制約、アンチアフィニティー仕様、およびワークロード要件が考慮されます。 要件に合致するワーカー・ノードが見つからなければ、ポッドはクラスターにデプロイされません。</li>
    <li>kube-controller-manager: レプリカ・セットをモニターし、対応するポッドを作成して目的の状態を実現するためのコンポーネントです。</li>
    <li>OpenVPN: {{site.data.keyword.containershort_notm}} 固有のコンポーネントであり、Kubernetes マスターからワーカー・ノードへのすべての通信のためのセキュア・ネットワーク接続を提供します。</li></ul></dd>
  <dt>ワーカー・ノードから Kubernetes マスターへのすべての通信のための TLS セキュア・ネットワーク接続</dt>
    <dd>Kubernetes マスターへのネットワーク通信を保護するために、{{site.data.keyword.containershort_notm}} によって TLS 証明書がクラスターごとに生成されます。これを使って kube-apiserver コンポーネントおよび etcd データ・ストア・コンポーネントとの間でやり取りされる通信が暗号化されます。 これらの証明書は、クラスター間で共有されたり、Kubernetes マスター・コンポーネント間で共有されたりすることはありません。</dd>
  <dt>Kubernetes マスターからワーカー・ノードへのすべての通信のための OpenVPN セキュア・ネットワーク接続</dt>
    <dd>Kubernetes は、`https` プロトコルを使用して Kubernetes マスターとワーカー・ノードの間の通信を保護しますが、デフォルトでは、ワーカー・ノードで認証は行われません。 この通信を保護するために、{{site.data.keyword.containershort_notm}} は、クラスターの作成時に、Kubernetes マスターとワーカー・ノードの間の OpenVPN 接続を自動的にセットアップします。</dd>
  <dt>継続的な Kubernetes マスター・ネットワーク・モニタリング</dt>
    <dd>どの Kubernetes マスターも IBM によって継続的にモニターされ、処理レベルのサービス妨害 (DOS) 攻撃を制御して対処します。</dd>
  <dt>Kubernetes マスター・ノードのセキュリティー・コンプライアンス</dt>
    <dd>{{site.data.keyword.containershort_notm}} は、Kubernetes マスターがデプロイされたすべてのノードにおいて、マスター・ノードを確実に保護するために適用する必要がある Kubernetes と OS 固有のセキュリティー修正の対象となる脆弱性を自動的にスキャンします。 脆弱性が検出されると、{{site.data.keyword.containershort_notm}} はユーザーに代わって自動的に修正を適用し、脆弱性を解決します。</dd>
</dl>

<br />


## ワーカー・ノード
{: #worker}

ワーカー・ノード環境を保護し、リソース、ネットワーク、ストレージの分離を保証する組み込みのワーカー・ノード・セキュリティー機能について説明します。
{: shortdesc}

<dl>
  <dt>コンピュート、ネットワーク、およびストレージ・インフラストラクチャーの分離</dt>
    <dd>クラスターを作成すると、お客様の IBM Cloud インフラストラクチャー (SoftLayer) アカウントまたは IBM 提供の IBM Cloud インフラストラクチャー (SoftLayer) 専用アカウントに、仮想マシンがワーカー・ノードとしてプロビジョンされます。 ワーカー・ノードは特定のクラスターの専用であり、他のクラスターのワークロードをホストすることはありません。<p> ワーカー・ノードのネットワーク・パフォーマンスと分離の品質を保証するために、すべての {{site.data.keyword.Bluemix_notm}} アカウントには、IBM Cloud インフラストラクチャー (SoftLayer) VLAN がセットアップされます。</p> <p>クラスターにデータを保持する場合は、IBM Cloud インフラストラクチャー (SoftLayer) の NFS ベースの専用ファイル・ストレージをプロビジョンし、このプラットフォームの組み込みデータ・セキュリティー機能を利用することができます。</p></dd>
  <dt>保護されたワーカー・ノードのセットアップ</dt>
    <dd>すべてのワーカー・ノードは Ubuntu オペレーティング・システムを使用してセットアップされ、ユーザーが変更することはできません。 ワーカー・ノードのオペレーティング・システムを潜在的な攻撃から保護するために、すべてのワーカー・ノードに、Linux iptable ルールによって適用されるエキスパート・ファイアウォール設定が構成されます。<p> Kubernetes 上で実行されるコンテナーはすべて、定義済みの Calico ネットワーク・ポリシー設定で保護されます。この設定は、クラスター作成時にワーカー・ノードごとに構成されます。 このようなセットアップにより、ワーカー・ノードとポッドの間のセキュア・ネットワーク通信が確保されます。 コンテナーがワーカー・ノード上で実行できるアクションをさらに制限するために、ユーザーは、ワーカー・ノードについて [AppArmor ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) を構成することを選択できます。</p><p> ワーカー・ノード上の SSH アクセスは無効になっています。 ワーカー・ノードに追加機能をインストールする場合、すべてのワーカー・ノードで実行するすべてのアクションについて [Kubernetes デーモン・セット ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) を使用できます。また、1 回限りのアクションについては、[Kubernetes ジョブ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) を使用できます。</p></dd>
  <dt>Kubernetes ワーカー・ノードのセキュリティー・コンプライアンス</dt>
    <dd>IBM は、社内と社外のセキュリティー顧問チームと協力して、セキュリティー・コンプライアンスにおける潜在的な脆弱性と取り組んでいます。 オペレーティング・システムに更新プログラムやセキュリティー・パッチをデプロイするために、IBM はワーカー・ノードへのアクセスを維持しています。<p> <b>重要</b>: ワーカー・ノードを定期的にリブートして、オペレーティング・システムに自動的にデプロイされた更新プログラムとセキュリティー・パッチがインストールされるようにします。 ワーカー・ノードが IBM によってリブートされることはありません。</p></dd>
  <dt id="encrypted_disks">暗号化ディスク</dt>
  <dd>{{site.data.keyword.containershort_notm}} は、ワーカー・ノードのプロビジョン時にデフォルトですべてのワーカー・ノード用に 2 つのローカル SSD 暗号化データ・パーティションを提供します。1 つ目のパーティションは暗号化されず、2 つ目のパーティションは _/var/lib/docker_ にマウントされ、LUKS 暗号鍵を使用してアンロックされます。各 Kubernetes クラスター内の各ワーカーには、独自の固有の LUKS 暗号キーがあり、{{site.data.keyword.containershort_notm}} によって管理されます。 クラスターを作成する際やワーカー・ノードを既存のクラスターに追加する際に、この鍵は安全にプルされてから、暗号化ディスクのアンロック後に破棄されます。
  <p><b>注</b>: 暗号化はディスク入出力のパフォーマンスに影響します。 高性能のディスク入出力が必要なワークロードの場合、暗号化を有効/無効にした両方のクラスターをテストし、暗号化をオフにするかどうかの決定に役立ててください。</p>
  </dd>
  <dt>IBM Cloud インフラストラクチャー (SoftLayer) ネットワーク・ファイアウォールのサポート</dt>
    <dd>{{site.data.keyword.containershort_notm}} は、すべての [ IBM Cloud インフラストラクチャー (SoftLayer) ファイアウォール・オファリング ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud-computing/bluemix/network-security) に対応しています。 {{site.data.keyword.Bluemix_notm}} Public では、カスタム・ネットワーク・ポリシーをファイアウォールにセットアップして、
クラスターのための専用ネットワーク・セキュリティーを設定し、ネットワーク侵入を検出して対処することができます。 例えば、ファイアウォールとして不要なトラフィックをブロックするように [Vyatta ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/vyatta-1) をセットアップすることを選択できます。 ファイアウォールをセットアップする場合は、マスター・ノードとワーカー・ノードが通信できるように、地域ごとに[必要なポートと IP アドレスを開く](cs_firewall.html#firewall)必要もあります。</dd>
  <dt>サービスをプライベートにしておくか、サービスとアプリを選択的に公共のインターネットに公開する</dt>
    <dd>サービスとアプリをプライベートにして、このトピックで説明した組み込みのセキュリティー機能を利用して、ワーカー・ノードとポッドの間のセキュアな通信を確保することができます。 サービスとアプリを公共のインターネットに公開する場合は、Ingress とロード・バランサーのサポートを活用してサービスを安全に公開することができます。</dd>
  <dt>ワーカー・ノードとアプリをオンプレミス・データ・センターにセキュアに接続する</dt>
  <dd>ワーカー・ノードとアプリをオンプレミス・データ・センターに接続するには、Strongswan サービス、Vyatta Gateway Appliance、または Fortigate Appliance を使用して VPN IPSec エンドポイントを構成できます。<br><ul><li><b>Strongswan IPSec VPN サービス</b>: Kubernetes クラスターをオンプレミス・ネットワークとセキュアに接続する [Strongswan IPSec VPN サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.strongswan.org/) をセットアップできます。 Strongswan IPSec VPN サービスは、業界標準の Internet Protocol Security (IPsec) プロトコル・スイートに基づき、インターネット上にセキュアなエンドツーエンドの通信チャネルを確立します。 クラスターとオンプレミス・ネットワークの間にセキュアな接続をセットアップするためには、オンプレミスのデータ・センターに IPsec VPN ゲートウェイまたは IBM Cloud インフラストラクチャー (SoftLayer) サーバーを設置する必要があります。 その後、Kubernetes ポッドで [Strongswan IPSec VPN サービスの構成とデプロイ](cs_vpn.html#vpn)を行うことができます。</li><li><b>Vyatta Gateway Appliance または Fortigate Appliance</b>: クラスターが大きい場合は、Vyatta Gateway Appliance または Fortigate Appliance をセットアップして IPSec VPN エンドポイントを構成することもできます。 詳しくは、この[オンプレミス・データ・センターへのクラスターの接続 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) に関するブログ投稿を参照してください。</li></ul></dd>
  <dt>クラスター・アクティビティーの継続的なモニタリングとロギング</dt>
    <dd>標準クラスターの場合、ワーカー・ノードの追加、ローリング更新の進行状況、キャパシティー使用状況情報などのすべてのクラスター関連イベントを、{{site.data.keyword.containershort_notm}} によってログに記録してモニターし、{{site.data.keyword.loganalysislong_notm}} と {{site.data.keyword.monitoringlong_notm}} に送ることできます。 ロギングとモニタリングのセットアップに関する情報については、[クラスター・ロギングの構成](/docs/containers/cs_health.html#logging)と[クラスター・モニタリングの構成](/docs/containers/cs_health.html#monitoring)を参照してください。</dd>
</dl>

<br />


## イメージ
{: #images}

標準装備のセキュリティー・フィーチャーを使用して、イメージのセキュリティーと保全性を管理します。
{: shortdesc}

<dl>
<dt>{{site.data.keyword.registryshort_notm}} の保護された Docker プライベート・イメージ・リポジトリー</dt>
<dd>IBM がホストおよび管理するマルチテナントで可用性が高く拡張可能なプライベート・イメージ・レジストリー内に独自の Docker イメージ・リポジトリーをセットアップし、Docker イメージを作成して安全に保管し、クラスター・ユーザー間で共有することができます。</dd>

<dt>イメージのセキュリティー・コンプライアンス</dt>
<dd>{{site.data.keyword.registryshort_notm}}を使用する際、Vulnerability Advisor に標準装備のセキュリティー・スキャンを利用できます。 名前空間にプッシュされるどのイメージも、CentOS、Debian、Red Hat、および Ubuntu の既知の問題のデータベースに基づいて、脆弱性が自動的にスキャンされます。 脆弱性が検出されると、それらを解決してイメージの保全性とセキュリティーを確保する方法を Vulnerability Advisor が提示します。</dd>
</dl>

イメージの脆弱性評価を表示する方法については、[Vulnerability Advisor の文書を参照してください](/docs/services/va/va_index.html#va_registry_cli)。

<br />


## クラスター内ネットワーキング
{: #in_cluster_network}

ワーカー・ノードとポッド間の保護されたクラスター内ネットワーク通信は、プライベート仮想ローカル・エリア・ネットワーク (VLAN) で実現されます。 VLAN では、ワーカー・ノードとポッドをまとめたグループが同じ物理ワイヤーに接続されているかのように構成されます。
{:shortdesc}

クラスターを作成すると、すべてのクラスターはプライベート VLAN に自動的に接続されます。 ワーカー・ノードに割り当てられるプライベート IP アドレスは、クラスター作成時にプライベート VLAN によって決定されます。

|クラスター・タイプ|クラスターのプライベート VLAN の管理者|
|------------|-------------------------------------------|
|{{site.data.keyword.Bluemix_notm}} 内のライト・クラスター|{{site.data.keyword.IBM_notm}}|
|{{site.data.keyword.Bluemix_notm}} 内の標準クラスター|IBM Cloud インフラストラクチャー (SoftLayer) アカウントを使用するお客様 <p>**ヒント:** アカウント内のすべての VLAN にアクセスできるようにするには、[VLAN スパンニング ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/procedure/enable-or-disable-vlan-spanning) をオンにします。</p>|

ワーカー・ノードにデプロイされるすべてのポッドにも、プライベート IP アドレスが割り当てられます。ポッドには 172.30.0.0/16 のプライベート・アドレス範囲で IP が割り当てられ、ワーカー・ノード間でのみルーティングされます。 競合を避けるために、ご使用のワーカー・ノードと通信するノードにはこの IP 範囲を使用しないでください。 ワーカー・ノードとポッドは、プライベート IP アドレスを使用してプライベート・ネットワーク上で安全に通信できます。 しかし、ポッドが異常終了した場合やワーカー・ノードを再作成する必要がある場合は、新しいプライベート IP アドレスが割り当てられます。

高可用性が必要とされるアプリの変化するプライベート IP アドレスを追跡することは難しいため、組み込みの Kubernetes サービス・ディスカバリー機能を使用してクラスター内のプライベート・ネットワーク上のクラスター IP サービスとしてアプリを公開することができます。 Kubernetes サービスによってポッドのセットをグループ化し、クラスター内の他のサービスからそれらのポッドにアクセスするためのネットワーク接続を提供します。そうすれば、各ポッドの実際のプライベート IP アドレスを公開する必要はありません。 クラスター IP サービスを作成すると、10.10.10.0/24 のプライベート・アドレス範囲からそのサービスにプライベート IP アドレスが割り当てられます。 ポッドのプライベート・アドレス範囲と同様に、この IP 範囲はワーカー・ノードと通信するノードには使用しないでください。 この IP アドレスはクラスター内でのみアクセス可能です。 インターネットからこの IP アドレスにアクセスすることはできません。 同時に、サービスの DNS 参照エントリーが作成され、クラスターの kube-dns コンポーネントに保管されます。 DNS エントリーには、サービスの名前、サービスが作成された名前空間、割り当てられたプライベート・クラスター IP アドレスへのリンクが設定されます。

クラスター IP サービスの背後に属するポッドにクラスター内のアプリがアクセスする必要がある場合は、サービスに割り当てられたプライベート・クラスター IP アドレスを使用するか、サービスの名前を使用して要求を送信します。 サービスの名前を使用した場合、名前は kube-dns コンポーネント内で検索され、サービスのプライベート・クラスター IP アドレスにルーティングされます。 要求がサービスに到達すると、ポッドのプライベート IP アドレスやデプロイ先のワーカー・ノードに関係なく、すべての要求がサービスによってポッドに等しく転送されます。

クラスター IP タイプのサービスを作成する方法について詳しくは、[Kubernetes サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services---service-types) を参照してください。
