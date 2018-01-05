---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-13"

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
{: #cs_security}

標準装備のセキュリティー・フィーチャーをリスク分析とセキュリティー保護に使用できます。 これらのフィーチャーは、クラスター・インフラストラクチャーとネットワーク通信を保護し、コンピュート・リソースを分離し、インフラストラクチャー・コンポーネントとコンテナー・デプロイメントにおけるセキュリティー・コンプライアンスを確保するためのものです。
{: shortdesc}

## クラスター・コンポーネントによるセキュリティー
{: #cs_security_cluster}

各 {{site.data.keyword.containerlong_notm}} クラスターには、その[マスター](#cs_security_master)と[ワーカー・](#cs_security_worker)ノードに組み込まれたセキュリティー・フィーチャーがあります。ファイアウォールがある場合、クラスター外からロード・バランシングにアクセスする必要がある場合、または公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときにローカル・システムから `kubectl` コマンドを実行しようとしている場合は、[ファイアウォールでポートを開き](#opening_ports)ます。クラスター内のアプリをオンプレミス・ネットワークまたはクラスター外の他のアプリに接続しようとしている場合は、[VPN 接続をセットアップ](#vpn)します。
{: shortdesc}

次の図には、セキュリティー・フィーチャーが、Kubernetes マスター、ワーカー・ノード、コンテナー・イメージのグループ別に示されています。

<img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} クラスター・セキュリティー" style="width:400px; border-style: none"/>


  <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
  <caption>表 1. セキュリティー・フィーチャー</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> {{site.data.keyword.containershort_notm}} での組み込みのクラスター・セキュリティー設定</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes マスター</td>
      <td>各クラスターの Kubernetes マスターは IBM によって管理され、高い可用性を備えています。 マスターには、セキュリティー・コンプライアンスを確保し、ワーカー・ノードとの間の通信を保護するための {{site.data.keyword.containershort_notm}} セキュリティー設定が含まれています。 更新は IBM が必要に応じて行います。 専用 Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを一元的に制御してモニターします。 デプロイメント要件とクラスターの容量に基づき、Kubernetes マスターは、コンテナー化されたアプリが使用可能なワーカー・ノードにデプロイされるように自動的にスケジュール設定します。 詳しくは、[Kubernetes マスターのセキュリティー](#cs_security_master)を参照してください。</td>
    </tr>
    <tr>
      <td>ワーカー・ノード</td>
      <td>コンテナーはワーカー・ノードにデプロイされます。ワーカー・ノードは特定の 1 つのクラスターのために専用で使用されるので、IBM のお客様に提供されるコンピュート、ネットワーク、およびストレージがそれぞれ分離されます。 {{site.data.keyword.containershort_notm}} が備える組み込みセキュリティー機能により、プライベート・ネットワークとパブリック・ネットワークのワーカー・ノードのセキュリティーを維持し、ワーカー・ノードのセキュリティー・コンプライアンスを遵守できます。 詳しくは、[ワーカー・ノードのセキュリティー](#cs_security_worker)を参照してください。 さらに、[Calico ネットワーク・ポリシー](#cs_security_network_policies)を追加して、ワーカー・ノード上のポッドを出入りするネットワーク・トラフィックのどれを許可し、どれをブロックするかを指定することができます。 </td>
     </tr>
     <tr>
      <td>イメージ</td>
      <td>クラスター管理者は、保護された独自の Docker イメージ・リポジトリーを {{site.data.keyword.registryshort_notm}} にセットアップできます。このレジストリーに Docker イメージを保管してクラスター・ユーザー間で共有することができます。 安全にコンテナー・デプロイメントを行うために、プライベート・レジストリー内のすべてのイメージが Vulnerability Advisor によってスキャンされます。 Vulnerability Advisor は {{site.data.keyword.registryshort_notm}}のコンポーネントであり、潜在的な脆弱性がないかスキャンし、セキュリティーに関する推奨を行い、脆弱性を解決するための方法を提示します。 詳しくは、[{{site.data.keyword.containershort_notm}} のイメージ・セキュリティー](#cs_security_deployment) を参照してください。</td>
    </tr>
  </tbody>
</table>

### Kubernetes マスター
{: #cs_security_master}

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


### ワーカー・ノード
{: #cs_security_worker}

ワーカー・ノード環境を保護し、リソース、ネットワーク、ストレージの分離を保証する組み込みのワーカー・ノード・セキュリティー機能について説明します。
{: shortdesc}

<dl>
  <dt>コンピュート、ネットワーク、およびストレージ・インフラストラクチャーの分離</dt>
    <dd>クラスターを作成すると、お客様の IBM Cloud インフラストラクチャー (SoftLayer) アカウントまたは IBM 提供の IBM Cloud インフラストラクチャー (SoftLayer) 専用アカウントに、仮想マシンがワーカー・ノードとしてプロビジョンされます。 ワーカー・ノードは特定のクラスターの専用であり、他のクラスターのワークロードをホストすることはありません。</br> ワーカー・ノードのネットワーク・パフォーマンスと分離の品質を保証するために、すべての {{site.data.keyword.Bluemix_notm}} アカウントには、IBM Cloud インフラストラクチャー (SoftLayer) VLAN がセットアップされます。 </br>クラスターにデータを保持する場合は、IBM Cloud インフラストラクチャー (SoftLayer) の NFS ベースの専用ファイル・ストレージをプロビジョンし、このプラットフォームの組み込みデータ・セキュリティー機能を利用することができます。</dd>
  <dt>保護されたワーカー・ノードのセットアップ</dt>
    <dd>すべてのワーカー・ノードは Ubuntu オペレーティング・システムを使用してセットアップされ、ユーザーが変更することはできません。 ワーカー・ノードのオペレーティング・システムを潜在的な攻撃から保護するために、すべてのワーカー・ノードに、Linux iptable ルールによって適用されるエキスパート・ファイアウォール設定が構成されます。</br> Kubernetes 上で実行されるコンテナーはすべて、定義済みの Calico ネットワーク・ポリシー設定で保護されます。この設定は、クラスター作成時にワーカー・ノードごとに構成されます。 このようなセットアップにより、ワーカー・ノードとポッドの間のセキュア・ネットワーク通信が確保されます。 コンテナーがワーカー・ノード上で実行できるアクションをさらに制限するために、ユーザーは、ワーカー・ノードについて [AppArmor ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) を構成することを選択できます。</br> ワーカー・ノード上の SSH アクセスは無効になっています。ワーカー・ノードに追加機能をインストールする場合、すべてのワーカー・ノードで実行するすべてのアクションについて [Kubernetes デーモン・セット ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) を使用できます。また、1 回限りのアクションについては、[Kubernetes ジョブ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) を使用できます。</dd>
  <dt>Kubernetes ワーカー・ノードのセキュリティー・コンプライアンス</dt>
    <dd>IBM は、社内と社外のセキュリティー顧問チームと協力して、セキュリティー・コンプライアンスにおける潜在的な脆弱性と取り組んでいます。 オペレーティング・システムに更新プログラムやセキュリティー・パッチをデプロイするために、IBM はワーカー・ノードへのアクセスを維持しています。</br> <b>重要</b>: ワーカー・ノードを定期的にリブートして、オペレーティング・システムに自動的にデプロイされた更新プログラムとセキュリティー・パッチがインストールされるようにします。 ワーカー・ノードが IBM によってリブートされることはありません。</dd>
  <dt>暗号化ディスク</dt>
  <dd>{{site.data.keyword.containershort_notm}} は、ワーカー・ノードのプロビジョン時にデフォルトですべてのワーカー・ノード用に 2 つのローカル SSD 暗号化データ・パーティションを提供します。1 つ目のパーティションは暗号化されず、2 つ目のパーティションは _/var/lib/docker_ にマウントされ、LUKS 暗号鍵を使用してプロビジョンされる際にアンロックされます。各 Kubernetes クラスター内の各ワーカーには、独自の固有の LUKS 暗号キーがあり、{{site.data.keyword.containershort_notm}} によって管理されます。クラスターを作成する際やワーカー・ノードを既存のクラスターに追加する際に、この鍵は安全にプルされてから、暗号化ディスクのアンロック後に破棄されます。
  <p><b>注</b>: 暗号化はディスク入出力のパフォーマンスに影響します。高性能のディスク入出力が必要なワークロードの場合、暗号化を有効/無効にした両方のクラスターをテストし、暗号化をオフにするかどうかの決定に役立ててください。</p>
  </dd>
  <dt>IBM Cloud インフラストラクチャー (SoftLayer) ネットワーク・ファイアウォールのサポート</dt>
    <dd>{{site.data.keyword.containershort_notm}} は、すべての [ IBM Cloud インフラストラクチャー (SoftLayer) ファイアウォール・オファリング ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud-computing/bluemix/network-security) に対応しています。 {{site.data.keyword.Bluemix_notm}} Public では、カスタム・ネットワーク・ポリシーをファイアウォールにセットアップして、
クラスターのための専用ネットワーク・セキュリティーを設定し、ネットワーク侵入を検出して対処することができます。 例えば、ファイアウォールとして不要なトラフィックをブロックするように [Vyatta ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/vyatta-1) をセットアップすることを選択できます。 ファイアウォールをセットアップする場合は、マスター・ノードとワーカー・ノードが通信できるように、地域ごとに[必要なポートと IP アドレスを開く](#opening_ports)必要もあります。</dd>
  <dt>サービスをプライベートにしておくか、サービスとアプリを選択的に公共のインターネットに公開する</dt>
    <dd>サービスとアプリをプライベートにして、このトピックで説明した組み込みのセキュリティー機能を利用して、ワーカー・ノードとポッドの間のセキュアな通信を確保することができます。 サービスとアプリを公共のインターネットに公開する場合は、Ingress とロード・バランサーのサポートを活用してサービスを安全に公開することができます。</dd>
  <dt>ワーカー・ノードとアプリをオンプレミス・データ・センターにセキュアに接続する</dt>
  <dd>ワーカー・ノードとアプリをオンプレミス・データ・センターに接続するには、Strongswan サービス、Vyatta Gateway Appliance、または Fortigate Appliance を使用して VPN IPSec エンドポイントを構成できます。<br><ul><li><b>Strongswan IPSec VPN サービス</b>: Kubernetes クラスターをオンプレミス・ネットワークとセキュアに接続する [Strongswan IPSec VPN サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.strongswan.org/) をセットアップできます。Strongswan IPSec VPN サービスは、業界標準の Internet Protocol Security (IPsec) プロトコル・スイートに基づき、インターネット上にセキュアなエンドツーエンドの通信チャネルを確立します。 クラスターとオンプレミス・ネットワークの間にセキュアな接続をセットアップするためには、オンプレミスのデータ・センターに IPsec VPN ゲートウェイまたは IBM Cloud インフラストラクチャー (SoftLayer) サーバーを設置する必要があります。その後、Kubernetes ポッドで [Strongswan IPSec VPN サービスの構成とデプロイ](cs_security.html#vpn)を行うことができます。</li><li><b>Vyatta Gateway Appliance または Fortigate Appliance</b>: クラスターが大きい場合は、Vyatta Gateway Appliance または Fortigate Appliance をセットアップして IPSec VPN エンドポイントを構成することもできます。詳しくは、この[オンプレミス・データ・センターへのクラスターの接続 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) に関するブログ投稿を参照してください。</li></ul></dd>
  <dt>クラスター・アクティビティーの継続的なモニタリングとロギング</dt>
    <dd>標準クラスターの場合、ワーカー・ノードの追加、ローリング更新の進行状況、キャパシティー使用状況情報などのすべてのクラスター関連イベントを、{{site.data.keyword.containershort_notm}} によってログに記録してモニターし、{{site.data.keyword.loganalysislong_notm}} と {{site.data.keyword.monitoringlong_notm}} に送ることできます。ロギングとモニタリングのセットアップに関する情報については、[クラスター・ロギングの構成](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_logging)と[クラスター・モニタリングの構成](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_monitoring)を参照してください。</dd>
</dl>

### イメージ
{: #cs_security_deployment}

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


## ファイアウォールで必要なポートと IP アドレスを開く
{: #opening_ports}

ご使用のファイアウォールで特定のポートと IP アドレスを開く必要が生じる可能性のある、以下の状況を検討してください。
* [プロキシーまたはファイアウォール経由の公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときに、ローカル・システムから `bx` コマンドを実行します](#firewall_bx)。
* [プロキシーまたはファイアウォール経由の公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときに、ローカル・システムから `kubectl` コマンドを実行します](#firewall_kubectl)。
* [プロキシーまたはファイアウォール経由の公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときに、ローカル・システムから `calicoctl` コマンドを実行します](#firewall_calicoctl)。
* [ワーカー・ノードに対してファイアウォールがセットアップされているとき、またはファイアウォール設定が IBM Cloud インフラストラクチャー (SoftLayer) アカウント内でカスタマイズされたときに、Kubernetes マスターとワーカー・ノード間の通信を可能にします](#firewall_outbound)。
* [クラスター外から NodePort サービス、LoadBalancer サービス、または Ingress へアクセス](#firewall_inbound)します。

### ファイアウォール保護下での `bx cs` コマンドの実行
{: #firewall_bx}

ローカル・システムからプロキシーまたはファイアウォール経由での公共のエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されている場合、`bx cs` コマンドを実行するには、{{site.data.keyword.containerlong_notm}} における TCP アクセスを許可する必要があります。

1. ポート 443 での `containers.bluemix.net` へのアクセスを許可します。
2. 接続を確認します。アクセスが正しく構成されている場合は、出力に船が表示されます。
   ```
   curl https://containers.bluemix.net/v1/
   ```
   {: pre}

   出力例:
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

### ファイアウォール保護下での `kubectl` コマンドの実行
{: #firewall_kubectl}

ローカル・システムからプロキシーまたはファイアウォール経由での公共のエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されている場合、`kubectl` コマンドを実行するには、クラスターにおける TCP アクセスを許可する必要があります。

クラスターの作成時に、マスター URL 内のポートは 20000 から 32767 の間でランダムに割り当てられます。作成される可能性のあるすべてのクラスターを対象に 20000 から 32767 までの範囲のポートを開くか、または特定の既存のクラスターを対象にアクセスを許可するかを選択できます。

始めに、[`bx cs` コマンドを実行](#firewall_bx)するためのアクセスを許可します。

特定のクラスターを対象にアクセスを許可するには、以下のようにします。

1. {{site.data.keyword.Bluemix_notm}} CLI にログインします。 プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。 統合されたアカウントがある場合は、`--sso` オプションを含めます。

    ```
    bx login [--sso]
    ```
    {: pre}

2. クラスターが属する地域を選択します。

   ```
   bx cs region-set
   ```
   {: pre}

3. クラスターの名前を取得します。

   ```
   bx cs clusters
   ```
   {: pre}

4. クラスターの**マスター URL** を取得します。

   ```
   bx cs cluster-get <cluster_name_or_id>
   ```
   {: pre}

   出力例:
   ```
   ...
   Master URL:		https://169.46.7.238:31142
   ...
   ```
   {: screen}

5. ポート上での**マスター URL** へのアクセスを許可します。前の例ではポート `31142` です。

6. 接続を確認します。

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   コマンド例:
   ```
   curl --insecure https://169.46.7.238:31142/version
   ```
   {: pre}

   出力例:
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

7. オプション: 公開する必要のあるクラスターごとに、上記のステップを繰り返します。

### ファイアウォール保護下での `calicoctl` コマンドの実行
{: #firewall_calicoctl}

ローカル・システムからプロキシーまたはファイアウォール経由での公共のエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されている場合、`calicoctl` コマンドを実行するには、Calico コマンドにおける TCP アクセスを許可する必要があります。

始めに、[`bx` コマンド](#firewall_bx)と [`kubectl` コマンド](#firewall_kubectl)を実行するためのアクセスを許可します。

1. [`kubectl` コマンド](#firewall_kubectl)の許可に使用したマスター URL から IP アドレスを取得します。

2. ETCD のポートを取得します。

  ```
  kubectl get cm -n kube-system calico-config -o yaml | grep etcd_endpoints
  ```
  {: pre}

3. マスター URL の IP アドレスと ETCD ポート経由の Calico ポリシーにおけるアクセスを許可します。

### クラスターからインフラストラクチャー・リソースや他のサービスへのアクセスの許可
{: #firewall_outbound}

  1.  以下を実行して、クラスター内のすべてのワーカー・ノードのパブリック IP アドレスをメモします。

      ```
      bx cs workers <cluster_name_or_id>
      ```
      {: pre}

  2.  ソースの _<each_worker_node_publicIP>_ から、宛先の TCP/UDP ポート (20000 から 32767 までの範囲とポート 443) への発信ネットワーク・トラフィックと、以下の IP アドレスとネットワーク・グループへの発信ネットワーク・トラフィックを許可します。ローカル・マシンから公共のインターネットのエンドポイントへのアクセスが企業ファイアウォールによって禁止されている場合は、ソースのワーカー・ノードとローカル・マシンの両方で以下のステップを実行します。
      - **重要**: ブートストラッピング・プロセスの際にロードのバランスを取るため、地域内のすべてのロケーションのために、ポート 443 への発信トラフィックを許可する必要があります。 例えば、クラスターが米国南部にある場合、ポート 443 からすべてのロケーションの IP アドレス (dal10、dal12、dal13) へのトラフィックを許可する必要があります。
      <p>
  <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
      <thead>
      <th>地域</th>
      <th>ロケーション</th>
      <th>IP アドレス</th>
      </thead>
    <tbody>
      <tr>
        <td>北アジア太平洋地域</td>
        <td>hkg02<br>tok02</td>
        <td><code>169.56.132.234</code><br><code>161.202.126.210</code></td>
       </tr>
      <tr>
         <td>南アジア太平洋地域</td>
         <td>mel01<br>syd01<br>syd04</td>
         <td><code>168.1.97.67</code><br><code>168.1.8.195</code><br><code>130.198.64.19、130.198.66.34</code></td>
      </tr>
      <tr>
         <td>中欧</td>
         <td>ams03<br>fra02<br>mil01<br>par01</td>
         <td><code>169.50.169.106、169.50.154.194</code><br><code>169.50.56.170、169.50.56.174</code><br><code>159.122.190.98</code><br><code>159.8.86.149、159.8.98.170</code></td>
        </tr>
      <tr>
        <td>英国南部</td>
        <td>lon02<br>lon04</td>
        <td><code>159.122.242.78</code><br><code>158.175.65.170、158.175.74.170、158.175.76.2</code></td>
      </tr>
      <tr>
        <td>米国東部</td>
         <td>tor01<br>wdc06<br>wdc07</td>
         <td><code>169.53.167.50</code><br><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
      </tr>
      <tr>
        <td>米国南部</td>
        <td>dal10<br>dal12<br>dal13</td>
        <td><code>169.47.234.18、169.46.7.234</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code></td>
      </tr>
      </tbody>
    </table>
</p>

  3.  ワーカー・ノードから {{site.data.keyword.registrylong_notm}} への発信ネットワーク・トラフィックを許可します。
      - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
      - <em>&lt;registry_publicIP&gt;</em> は、トラフィックを許可するレジストリー地域のすべてのアドレスに置き換えます。
        <p>
<table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
      <thead>
        <th>コンテナー地域</th>
        <th>レジストリー・アドレス</th>
        <th>レジストリー IP アドレス</th>
      </thead>
      <tbody>
        <tr>
          <td>北アジア太平洋地域、南アジア太平洋地域</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>中欧</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></td>
         </tr>
         <tr>
          <td>英国南部</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></td>
         </tr>
         <tr>
          <td>米国東部、米国南部</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></td>
         </tr>
        </tbody>
      </table>
</p>

  4.  オプション: ワーカー・ノードから {{site.data.keyword.monitoringlong_notm}} サービスと {{site.data.keyword.loganalysislong_notm}} サービスへの発信ネットワーク・トラフィックを許可します。
      - `TCP port 443, port 9095 FROM <each_worker_node_publicIP> TO <monitoring_publicIP>`
      - <em>&lt;monitoring_publicIP&gt;</em> は、トラフィックを許可するモニタリング地域のすべてのアドレスに置き換えます。
        <p><table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
        <thead>
        <th>コンテナー地域</th>
        <th>モニタリング・アドレス</th>
        <th>モニタリング IP アドレス</th>
        </thead>
      <tbody>
        <tr>
         <td>中欧</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>159.122.78.136/29</code></td>
        </tr>
        <tr>
         <td>英国南部</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>米国東部、米国南部、北アジア太平洋地域</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
      - `TCP port 443, port 9091 FROM <each_worker_node_publicIP> TO <logging_publicIP>`
      - <em>&lt;logging_publicIP&gt;</em> は、トラフィックを許可するロギング地域のすべてのアドレスに置き換えます。
        <p><table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
        <thead>
        <th>コンテナー地域</th>
        <th>ロギング・アドレス</th>
        <th>ロギング IP アドレス</th>
        </thead>
        <tbody>
          <tr>
            <td>米国東部、米国南部</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
           </tr>
          <tr>
           <td>中欧、英国南部</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>南アジア太平洋地域、北アジア太平洋地域</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>

  5. プライベート・ファイアウォールでは、IBM Cloud インフラストラクチャー (SoftLayer) のプライベート IP のために適切な範囲を許可します。 [このリンク](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall)の **Backend (private) Network** で始まるセクションを参照してください。
      - 使用している[地域内のロケーション](cs_regions.html#locations)をすべて追加します。
      - dal01 のロケーション (データ・センター) を追加する必要があることに注意してください。
      - ポート 80 および 443 を開いて、クラスターのブートストラッピング処理を可能にします。

  6. データ・ストレージの永続ボリューム請求を作成するには、クラスターのあるロケーション (データ・センター) の [IBM Cloud インフラストラクチャー (SoftLayer) IP アドレス](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall)における、ファイアウォールを介する発信 (egress) アクセスを許可します。
      - クラスターのロケーション (データ・センター) を見つけるには、`bx cs clusters` を実行します。
      - **フロントエンド (パブリック) ネットワーク**と**バックエンド (プライベート) ネットワーク**の両方の IP 範囲へのアクセスを許可します。
      - **バックエンド (プライベート) ネットワーク**には、dal01 のロケーション (データ・センター) を追加する必要があることに注意してください。

### クラスター外から NodePort、ロード・バランサー、Ingress の各サービスへのアクセス
{: #firewall_inbound}

NodePort、ロード・バランサー、Ingress の各サービスへの着信アクセスを許可できます。

<dl>
  <dt>NodePort サービス</dt>
  <dd>トラフィックを許可するすべてのワーカー・ノードのパブリック IP アドレスへのサービスのデプロイ時に構成したポートを開きます。ポートを見つけるには、`kubectl get svc` を実行します。ポートの範囲は 20000 から 32000 までです。<dd>
  <dt>LoadBalancer サービス</dt>
  <dd>ロード・バランサー・サービスのパブリック IP アドレスへのサービスのデプロイ時に構成したポートを開きます。</dd>
  <dt>Ingress</dt>
  <dd>Ingress アプリケーション・ロード・バランサーの IP アドレスへのポート 80 (HTTP の場合) またはポート 443 (HTTPS の場合) を開きます。</dd>
</dl>

<br />


## Strongswan IPSec VPN サービスの Helm Chart を使用した VPN 接続のセットアップ
{: #vpn}

VPN 接続を使用すると、Kubernetes クラスター内のアプリをオンプレミス・ネットワークにセキュアに接続できます。クラスター外のアプリを、クラスター内で実行中のアプリに接続することもできます。VPN 接続をセットアップするには、Helm Chart を使用して、Kubernetes ポッド内で [Strongswan IPSec VPN サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.strongswan.org/) を構成してデプロイします。その後すべての VPN トラフィックはこのポッドを介してルーティングされます。Strongswan Chart のセットアップに使用する Helm コマンドについて詳しくは、[Helm の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.helm.sh/helm/) を参照してください。

開始前に、以下のことを行います。

- [標準クラスターを作成します。](cs_cluster.html#cs_cluster_cli)
- [既存のクラスターを使用している場合は、バージョン 1.7.4 以降に更新します。](cs_cluster.html#cs_cluster_update)
- クラスターに 1 つ以上の使用可能なパブリック・ロード・バランサー IP アドレスがなければなりません。
- [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。

Strongswan との VPN 接続をセットアップするには、以下のようにします。

1. クラスターで Helm がまだ有効になっていない場合は、インストールして初期化します。

    1. [Helm CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン") をインストールします](https://docs.helm.sh/using_helm/#installing-helm)。

    2. Helm を初期化して `tiller` をインストールします。

        ```
        helm init
        ```
        {: pre}

    3. クラスター内の `tiller-deploy` ポッドの状況が `Running` になっていることを確認します。

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        出力例:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. {{site.data.keyword.containershort_notm}} Helm リポジトリーを Helm インスタンスに追加します。

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Helm リポジトリー内に Strongswan Chart がリストされていることを確認します。

        ```
        helm search bluemix
        ```
        {: pre}

2. ローカル YAML ファイル内に Strongswan Helm Chart のデフォルトの構成設定を保存します。

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. `config.yaml` ファイルを開き、ご希望の VPN 構成に従ってデフォルト値に以下の変更を加えます。プロパティーに値の設定オプションがある場合は、このファイル内の各プロパティーの上のコメントにそれらの値がリストされます。**重要**: プロパティーを変更する必要がない場合は、そのプロパティーの前に `#` を付けてコメント化してください。

    <table>
    <caption>表 2. YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>既存の <code>ipsec.conf</code> ファイルを使用する場合は、中括弧 (<code>{}</code>) を削除し、このプロパティーの後にこのファイルの内容を追加します。ファイル内容は字下げする必要があります。**注:** 独自のファイルを使用する場合は、<code>ipsec</code>、<code>local</code>、<code>remote</code> セクションの値は使用しません。</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>既存の <code>ipsec.secrets</code> ファイルを使用する場合は、中括弧 (<code>{}</code>) を削除し、このプロパティーの後にこのファイルの内容を追加します。ファイル内容は字下げする必要があります。**注:** 独自のファイルを使用する場合は、<code>preshared</code> セクションの値は使用しません。</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>オンプレミスの VPN トンネル・エンドポイントが、接続を初期化する際のプロトコルとして <code>ikev2</code> をサポートしていない場合は、この値を <code>ikev1</code> に変更します。</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>この値を、オンプレミスの VPN トンネル・エンドポイントで接続に使用される ESP 暗号化/認証アルゴリズムのリストに変更します。</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>この値を、オンプレミスの VPN トンネル・エンドポイントで接続に使用される IKE/ISAKMP SA 暗号化/認証アルゴリズムのリストに変更します。</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>クラスターに VPN 接続を開始させる場合は、この値を <code>start</code> に変更します。</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>この値を、オンプレミス・ネットワークへの VPN 接続を介して公開する必要があるクラスター・サブネット CIDR のリストに変更します。以下のサブネットをこのリストに含めることができます。<ul><li>Kubernetes ポッドのサブネット CIDR: <code>172.30.0.0/16</code></li><li>Kubernetes サービスのサブネット CIDR: <code>172.21.0.0/16</code></li><li>プライベート・ネットワーク上で NodePort サービスによって公開されるアプリケーションがある場合は、ワーカー・ノードのプライベート・サブネット CIDR。この値を見つけるには、<code>bx cs subnets | grep <xxx.yyy.zzz></code> を実行します。&lt;xxx.yyy.zzz&gt; はワーカー・ノードのプライベート IP アドレスの最初の 3 つのオクテットです。</li><li>プライベート・ネットワーク上で LoadBalancer サービスによって公開されるアプリケーションがある場合は、クラスターのプライベートまたはユーザー管理サブネット CIDR。これらの値を見つけるには、<code>bx cs cluster-get <cluster name> --showResources</code> を実行します。<b>VLANS</b> セクションで、<b>Public</b> 値が <code>false</code> の CIDR を見つけます。</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>この値を、VPN トンネル・エンドポイントで接続に使用される、ローカル Kubernetes クラスター側のストリング ID に変更します。</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>この値を、オンプレミス VPN ゲートウェイのパブリック IP アドレスに変更します。</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>この値を、Kubernetes クラスターからアクセスできるオンプレミスのプライベート・サブネット CIDR のリストに変更します。</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>この値を、VPN トンネル・エンドポイントで接続に使用される、リモートのオンプレミス側のストリング ID に変更します。</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>この値を、オンプレミスの VPN トンネル・エンドポイント・ゲートウェイで接続に使用される事前共有シークレットに変更します。</td>
    </tr>
    </tbody></table>

4. 更新した `config.yaml` ファイルを保存します。

5. 更新した `config.yaml` ファイルと共に Helm Chart をクラスターにインストールします。更新したプロパティーが、Chart の構成マップに保管されます。

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. Chart のデプロイメント状況を確認します。Chart の準備ができている場合は、出力の先頭付近の **STATUS** フィールドに `DEPLOYED` の値があります。

    ```
    helm status vpn
    ```
    {: pre}

7. Chart をデプロイし終えたら、`config.yaml` ファイル内の更新済みの設定が使用されたことを確認します。

    ```
    helm get values vpn
    ```
    {: pre}

8. 新しい VPN 接続をテストします。
    1. オンプレミス・ゲートウェイ上の VPN がアクティブでない場合は、VPN を開始します。

    2. `STRONGSWAN_POD` 環境変数を設定します。

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. VPN の状況を確認します。 `ESTABLISHED` の状況は、VPN 接続が成功したことを意味します。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        出力例:
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **注:**
          - この Helm Chart を初めて使用する際には、ほとんどの場合、VPN の状況は `ESTABLISHED` ではありません。接続が成功するまでに、オンプレミス VPN エンドポイントの設定を確認し、ステップ 3 に戻って、`config.yaml` ファイルを複数回変更する必要が生じる可能性があります。
          - VPN ポッドが `ERROR` 状態か、クラッシュと再始動が続く場合は、Chart の構成マップ内の `ipsec.conf` 設定のパラメーター妥当性検査が原因の可能性があります。これが原因か調べるには、`kubectl logs -n kube-system $STRONGSWAN_POD` を実行して、Strongswan ポッドのログに妥当性検査エラーがあるかを確認してください。妥当性検査エラーがある場合、`helm delete --purge vpn` を実行し、ステップ 3 に戻って、`config.yaml` ファイル内の誤った値を修正し、ステップ 4 から 8 を繰り返します。クラスターに多数のワーカー・ノードがある場合は、`helm delete` と `helm install` を実行するより `helm upgrade` を使用する方が変更を迅速に適用できます。

    4. VPN の状況が `ESTABLISHED` になったら、`ping` を使用して接続をテストします。以下の例は、Kubernetes クラスター内の VPN ポッドからオンプレミス VPN ゲートウェイのプライベート IP アドレスに ping を送信します。構成ファイル内で正しい `remote.subnet` と `local.subnet` が指定されていることと、ローカル・サブネット・リストに ping の送信元のソース IP アドレスが含まれていることを確認します。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

Strongswan IPSec VPN サービスを無効にするには、以下のようにします。

1. Helm Chart を削除します。

    ```
    helm delete --purge vpn
    ```
    {: pre}

<br />


## ネットワーク・ポリシー
{: #cs_security_network_policies}

Kubernetes クラスターはそれぞれ、Calico と呼ばれるネットワーク・プラグインを使用してセットアップされます。 各ワーカー・ノードのパブリック・ネットワーク・インターフェースを保護するために、デフォルトのネットワーク・ポリシーがセットアップされます。 固有のセキュリティー要件があるときには、Calico および Kubernetes のネイティブ機能を使用してクラスター用のネットワーク・ポリシーをさらに構成できます。 これらのネットワーク・ポリシーは、クラスター内のポッドを出入りするネットワーク・トラフィックのどれを許可し、どれをブロックするかを指定します。
{: shortdesc}

Calico と Kubernetes のネイティブ機能のいずれかを選んで、ご使用のクラスター用のネットワーク・ポリシーを作成することができます。 手始めには Kubernetes のネットワーク・ポリシーを使用することができますが、より堅牢な機能が必要であれば Calico のネットワーク・ポリシーを使用してください。

<ul>
  <li>[Kubernetes ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): 相互通信できるポッドを指定するなど、いくつかの基本的なオプションが用意されています。 特定のプロトコルとポートにおいて、着信ネットワーク・トラフィックを許可またはブロックできます。 このトラフィックは、他のポッドに接続しようとしているポッドのラベルと Kubernetes 名前空間に基づいて、フィルターに掛けることができます。</br>これらのポリシーは
`kubectl` コマンドまたは Kubernetes API を使用して適用できます。 これらのポリシーが適用されると、Calico ネットワーク・ポリシーに変換され、Calico がこれらのポリシーを実施します。</li>
  <li>[Calico ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.4/getting-started/kubernetes/tutorials/advanced-policy): これらのポリシーは Kubernetes ネットワーク・ポリシーのスーパーセットであり、Kubernetes のネイティブ機能に以下の機能を追加して拡張したものです。</li>
    <ul><ul><li>Kubernetes ポッドのトラフィックだけではなく、特定のネットワーク・インターフェース上のネットワーク・トラフィックを許可またはブロックします。</li>
    <li>着信 (ingress) および発信 (egress) ネットワーク・トラフィックを許可またはブロックします。</li>
    <li>[LoadBalancer サービスまたは NodePort Kubernetes サービスへの着信 (ingress) トラフィックをブロックします](#cs_block_ingress)。</li>
    <li>送信元または宛先 IP アドレスまたは CIDR に基づき、トラフィックを許可またはブロックします。</li></ul></ul></br>

これらのポリシーは `calicoctl` コマンドを使用して適用されます。 Calico は Kubernetes ワーカー・ノード上に Linux iptables 規則をセットアップすることによって、これらのポリシーを実施しますが、これには Calico ポリシーに変換された Kubernetes ネットワーク・ポリシーも含まれます。 iptables 規則はワーカー・ノードのファイアウォールとして機能し、ネットワーク・トラフィックがターゲット・リソースに転送されるために満たさなければならない特性を定義します。</ul>


### デフォルト・ポリシーの構成
{: #concept_nq1_2rn_4z}

クラスターの作成時には、各ワーカー・ノードのパブリック・ネットワーク・インターフェース用のデフォルトのネットワーク・ポリシーが自動的にセットアップされ、パブリック・インターネットからのワーカー・ノードの着信トラフィックを制限します。 これらのポリシーはポッド間のトラフィックには影響せず、Kubernetes ノードポート、ロード・バランサー、入口サービスへのアクセスを許可するためにセットアップされます。

デフォルト・ポリシーはポッドに直接、適用されるわけではありません。Calico host エンドポイント を使用して、ワーカー・ノードのパブリック・ネットワーク・インターフェースに適用されます。 ホストのエンドポイントが Calico に作成されると、そのワーカー・ノードのネットワーク・インターフェースを出入りするトラフィックは、ポリシーによってそのトラフィックが許可されていない限り、すべてブロックされます。

**重要:** ポリシーを十分に理解していない限り、かつ、ポリシーにより許可されるトラフィックが必要ないと判断できるのでない限り、ホストのエンドポイントに適用されるポリシーを削除しないでください。


 <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
 <caption>表 3. 各クラスターのデフォルト・ポリシー</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> 各クラスターのデフォルト・ポリシー</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>すべてのアウトバウンド・トラフィックを許可します。</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>必要なワーカー・ノードの更新が可能になるように、bigfix アプリへの着信トラフィックをポート 52311 で許可します。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>すべての着信 icmp パケット (ping) を許可します。</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>着信ノードポート、ロード・バランサー、およびサービスが公開されるポッドへの入口サービス・トラフィックを許可します。 Kubernetes ではサービス要求を正しいポッドに転送するために宛先ネットワーク・アドレス変換 (DNAT) を使用するため、それらのサービスがパブリック・インターフェースで公開されるポートは指定する必要がないことに気を付けてください。 ホストのエンドポイント・ポリシーが iptables で適用される前に、その転送が実行されます。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>ワーカー・ノードを管理するために使用される特定の IBM Cloud インフラストラクチャー (SoftLayer) システムの着信接続を許可します。</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>ワーカー・ノード間の仮想 IP アドレスのモニターと移動に使用される vrrp パケットを許可します。</td>
   </tr>
  </tbody>
</table>


### ネットワーク・ポリシーの追加
{: #adding_network_policies}

ほとんどの場合、デフォルト・ポリシーは変更する必要がありません。 拡張シナリオのみ、変更が必要な場合があります。 変更が必要であるとわかった場合は、Calico CLI をインストールし、独自のネットワーク・ポリシーを作成します。

開始前に、以下のことを行います。

1.  [{{site.data.keyword.containershort_notm}} および Kubernetes CLI をインストールします。](cs_cli_install.html#cs_cli_install)
2.  [ライト・クラスターまたは標準クラスターを作成します。](cs_cluster.html#cs_cluster_ui)
3.  [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。 `bx cs cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。 このダウンロードには、Calico コマンドの実行に必要なスーパーユーザー役割の鍵も含まれています。

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **注**: Calico CLI バージョン 1.6.1 がサポートされています。

ネットワーク・ポリシーを追加するには、以下のようにします。
1.  Calico CLI をインストールします。
    1.  [Calico CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1) をダウンロードします。

        **ヒント:** Windows を使用している場合、Calico CLI を {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールします。 このようにセットアップすると、後でコマンドを実行するとき、ファイル・パスの変更を行う手間がいくらか少なくなります。

    2.  OSX と Linux のユーザーは、以下の手順を実行してください。
        1.  実行可能ファイルを /usr/local/bin ディレクトリーに移動します。
            -   Linux:

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS X:

              ```
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  ファイルを実行可能にします。

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Calico CLI クライアントのバージョンを調べて、`calico` コマンドが正常に実行されたことを確認します。

        ```
        calicoctl version
        ```
        {: pre}

2.  Calico CLI を構成します。

    1.  Linux および OS X の場合、`/etc/calico` ディレクトリーを作成します。 Windows の場合は、どのディレクトリーを使用しても構いません。

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  `calicoctl.cfg` ファイルを作成します。
        -   Linux および OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows の場合: テキスト・エディターでファイルを作成します。

    3.  <code>calicoctl.cfg</code> ファイルに次の情報を入力します。

        ```
        apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
        ```
        {: codeblock}

        1.  `<ETCD_URL>` を取得します。 このコマンドが `calico-config not found` エラーで失敗した場合は、この[トラブルシューティング・トピック](cs_troubleshoot.html#cs_calico_fails)を参照してください。

          -   Linux および OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   出力例:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>calico 構成値を構成マップから取得します。 </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>`data` セクションで、etcd_endpoints 値を見つけます。 例: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  `<CERTS_DIR>` (Kubernetes 証明書をダウンロードしたディレクトリー) を取得します。

            -   Linux および OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                出力例:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                出力例:

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **注**: ディレクトリー・パスを取得するには、出力の最後からファイル名 `kube-config-prod-<location>-<cluster_name>.yml` を除きます。

        3.  <code>ca-*pem_file<code> を取得します。

            -   Linux および OS X:

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>最後のステップで取得したディレクトリーを開きます。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> <code>ca-*pem_file</code> ファイルを見つけます。</ol>

        4.  Calico 構成が正常に動作していることを確認します。

            -   Linux および OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              出力:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  既存のネットワーク・ポリシーを調査します。

    -   Calico ホスト・エンドポイントを表示します。

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   そのクラスター用に作成されたすべての Calico および Kubernetes ネットワーク・ポリシーを表示します。 このリストにはどのポッドやホストにもまだ適用されていない可能性のあるポリシーも含まれています。 ネットワーク・ポリシーを実施するには、
Calico ネットワーク・ポリシーで定義されたセレクターに一致する Kubernetes リソースを見つける必要があります。

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   ネットワーク・ポリシーの詳細を表示します。

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   そのクラスター用のすべてのネットワーク・ポリシーの詳細を表示します。

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  トラフィックを許可またはブロックする Calico ネットワーク・ポリシーを作成します。

    1.  構成スクリプト (.yaml) を作成して、独自の [Calico ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy) を定義します。 これらの構成ファイルにはどのポッド、名前空間、またはホストにこれらのポリシーを適用するかを説明するセレクターが含まれます。 独自のポリシーを作成するときには、こちらの[サンプル Calico ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) を参考にしてください。

    2.  ポリシーをクラスターに適用します。
        -   Linux および OS X:

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}

### LoadBalancer サービスまたは NodePort サービスへの着信トラフィックをブロックします。
{: #cs_block_ingress}

デフォルトで、Kubernetes の `NodePort` サービスと `LoadBalancer` サービスは、パブリックとプライベートのすべてのクラスター・インターフェースでアプリを利用可能にするために設計されています。 ただし、トラフィックのソースや宛先に基づいて、サービスへの着信トラフィックをブロックすることもできます。 トラフィックをブロックするには、Calico `preDNAT` ネットワーク・ポリシーを作成します。

Kubernetes の LoadBalancer サービスは NodePort サービスでもあります。 LoadBalancer サービスにより、ロード・バランサーの IP アドレスとポート上でアプリが利用可能になり、サービスのノード・ポート上でアプリが利用可能になります。 ノード・ポートは、クラスター内のすべてのノードのすべての IP アドレス (パブリックとプライベート) でアクセス可能です。

クラスター管理者は、Calico `preDNAT` ネットワーク・ポリシーを使用して以下のものをブロックできます。

  - NodePort サービスへのトラフィック。 LoadBalancer サービスへのトラフィックは許可されます。
  - ソース・アドレスまたは CIDR に基づくトラフィック。

Calico `preDNAT` ネットワーク・ポリシーのいくつかの一般的な使用方法:

  - プライベート LoadBalancer サービスのパブリック・ノード・ポートへのトラフィックをブロックする。
  - [エッジ・ワーカー・ノード](#cs_edge)を実行しているクラスター上のパブリック・ノード・ポートへのトラフィックをブロックする。 ノード・ポートをブロックすることにより、エッジ・ワーカー・ノードだけが着信トラフィックを扱うワーカー・ノードとなります。

`preDNAT` ネットワーク・ポリシーは便利なポリシーです。なぜなら、デフォルトの Kubernetes ポリシーと Calico ポリシーでは、保護する Kubernetes の NodePort サービスと LoadBalancer サービスに対して生成された DNAT iptables 規則があるために、それらのサービスに対してポリシーを適用するのが困難であるためです。

Calico `preDNAT` ネットワーク・ポリシーは、[Calico ネットワーク・ポリシー・リソース ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v2.4/reference/calicoctl/resources/policy) に基づいて、iptables 規則を生成します。

1. Kubernetes サービスへの ingress アクセスのための、Calico `preDNAT` ネットワーク・ポリシーを定義します。

  すべてのノード・ポートをブロックする例:

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Calico preDNAT ネットワーク・ポリシーを適用します。 ポリシーの変更内容がクラスター全体に適用されるまでには約 1 分かかります。

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}

<br />



## ネットワーク・トラフィックをエッジ・ワーカー・ノードに制限する
{: #cs_edge}

クラスター内の複数のノードに `dedicated=edge` ラベルを追加して、Ingress とロード・バランサーがそれらのワーカー・ノードにのみデプロイされるようにします。

エッジ・ワーカー・ノードを使用すると、外部的にアクセスされるワーカー・ノードの数を減らし、ネットワーキングのワークロードを分離することができるので、クラスターのセキュリティーが改善されます。 これらのワーカー・ノードがネットワーキング専用としてマーク付けされると、他のワークロードはワーカー・ノードの CPU やメモリーを消費してネットワーキングに干渉することがなくなります。

開始前に、以下のことを行います。

- [標準クラスターを作成します。](cs_cluster.html#cs_cluster_cli)
- クラスターに 1 つ以上のパブリック VLAN があることを確認してください。 エッジ・ワーカー・ノードは、プライベート VLAN だけがあるクラスターには使用できません。
- [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。


1. クラスター内のすべてのワーカー・ノードをリストします。 **NAME** 列からプライベート IP アドレスを使用して、ノードを識別します。 エッジ・ワーカー・ノードとするワーカー・ノードを 2 つ以上選択します。 2 つ以上のワーカー・ノードを使用することにより、ネットワーキング・リソースの可用性が向上します。

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated
  ```
  {: pre}

2. `dedicated=edge` により、ワーカー・ノードにラベルを付けます。 `dedicated=edge` によりワーカー・ノードにマークが付けられると、すべての後続の Ingress とロード・バランサーは、エッジ・ワーカー・ノードにデプロイされます。

  ```
  kubectl label nodes <node_name> <node_name2> dedicated=edge
  ```
  {: pre}

3. クラスター内にあるすべての既存のロード・バランサー・サービスを検索します。

  ```
  kubectl get services --all-namespaces -o jsonpath='{range .items[*]}kubectl get service -n {.metadata.namespace} {.metadata.name} -o yaml | kubectl apply -f - :{.spec.type},{end}' | tr "," "\n" | grep "LoadBalancer" | cut -d':' -f1
  ```
  {: pre}

  出力:

  ```
  kubectl get service -n <namespace> <name> -o yaml | kubectl apply -f
  ```
  {: screen}

4. 直前のステップからの出力を使用して、それぞれの `kubectl get service` 行をコピーして貼り付けます。 このコマンドは、ロード・バランサーをエッジ・ワーカー・ノードに再デプロイします。 再デプロイする必要があるのは、パブリック・ロード・バランサーだけです。

  出力:

  ```
  service "<name>" configured
  ```
  {: screen}

`dedicated=edge` によりワーカー・ノードにラベルを付け、すべての既存のロード・バランサーと Ingress をエッジ・ワーカー・ノードに再デプロイしました。 次に、他の[ワークロードがエッジ・ワーカー・ノードで実行されないように](#cs_edge_workloads)、そして[ワーカー・ノード上のノード・ポートへのインバウンド・トラフィックをブロックするように](#cs_block_ingress)します。

### ワークロードがエッジ・ワーカー・ノード上で実行されないようにする
{: #cs_edge_workloads}

エッジ・ワーカー・ノードの利点の 1 つは、これらのワーカー・ノードが、ネットワーク・サービスだけを実行するように指定できることです。 `dedicated=edge` 耐障害性の使用は、すべてのロード・バランサーと Ingress サービスが、ラベルの付けられたワーカー・ノードにのみデプロイされることを意味します。 ただし、他のワークロードがエッジ・ワーカー・ノード上で実行されてワーカー・ノードのリソースを消費することがないようにするため、[Kubernetes テイント ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) を使用する必要があります。

1. `edge` ラベルのあるすべてのワーカー・ノードをリストします。

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. テイントを各ワーカー・ノードに適用します。このテイントは、ポッドがワーカー・ノード上で実行されるのを防ぎ、`edge` ラベルのないポッドをワーカー・ノードから削除します。 削除されるポッドは、容量のある他のワーカー・ノードに再デプロイされます。

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```

これで、`dedicated=edge` 耐障害性のあるポッドだけがエッジ・ワーカー・ノードにデプロイされます。
