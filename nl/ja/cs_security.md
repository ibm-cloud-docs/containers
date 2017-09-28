---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

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

標準装備のセキュリティー・フィーチャーをリスク分析とセキュリティー保護に使用できます。
これらのフィーチャーは、クラスター・インフラストラクチャーとネットワーク通信を保護し、コンピュート・リソースを分離し、インフラストラクチャー・コンポーネントとコンテナー・デプロイメントにおけるセキュリティー・コンプライアンスを確保するためのものです。
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png"><img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} クラスター・セキュリティー" style="width:400px;" /></a>

<table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
    <thead>
  <th colspan=2><img src="images/idea.png"/> {{site.data.keyword.containershort_notm}} での組み込みのクラスター・セキュリティー設定</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes マスター</td>
      <td>各クラスターの Kubernetes マスターは IBM によって管理され、高い可用性を備えています。マスターには、セキュリティー・コンプライアンスを確保し、ワーカー・ノードとの間の通信を保護するための {{site.data.keyword.containershort_notm}} セキュリティー設定が含まれています。
更新は IBM が必要に応じて行います。専用 Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを一元的に制御してモニターします。デプロイメント要件とクラスターの容量に基づき、Kubernetes マスターは、コンテナー化されたアプリが使用可能なワーカー・ノードにデプロイされるように自動的にスケジュール設定します。詳しくは、[Kubernetes マスターのセキュリティー](#cs_security_master)を参照してください。
</td>
    </tr>
    <tr>
      <td>ワーカー・ノード</td>
      <td>コンテナーはワーカー・ノードにデプロイされます。ワーカー・ノードは特定の 1 つのクラスターのために専用で使用されるので、IBM のお客様に提供されるコンピュート、ネットワーク、およびストレージがそれぞれ分離されます。
{{site.data.keyword.containershort_notm}} が備える組み込みセキュリティー機能により、プライベート・ネットワークとパブリック・ネットワークのワーカー・ノードのセキュリティーを維持し、ワーカー・ノードのセキュリティー・コンプライアンスを遵守できます。
詳しくは、[ワーカー・ノードのセキュリティー](#cs_security_worker)を参照してください。
</td>
     </tr>
     <tr>
      <td>イメージ</td>
      <td>クラスター管理者は、保護された独自の Docker イメージ・リポジトリーを {{site.data.keyword.registryshort_notm}} にセットアップできます。このレジストリーに Docker イメージを保管してクラスター・ユーザー間で共有することができます。安全にコンテナー・デプロイメントを行うために、プライベート・レジストリー内のすべてのイメージが Vulnerability Advisor によってスキャンされます。
Vulnerability Advisor は {{site.data.keyword.registryshort_notm}}のコンポーネントであり、潜在的な脆弱性がないかスキャンし、セキュリティーに関する推奨を行い、脆弱性を解決するための方法を提示します。詳しくは、[{{site.data.keyword.containershort_notm}} のイメージ・セキュリティー](#cs_security_deployment) を参照してください。</td>
    </tr>
  </tbody>
</table>

## Kubernetes マスター
{: #cs_security_master}

Kubernetes マスターを保護し、クラスター・ネットワーク通信をセキュリティーで保護するための Kubernetes マスターの組み込みセキュリティー機能について説明します。
{: shortdesc}

<dl>
  <dt>完全に管理される専用 Kubernetes マスター</dt>
    <dd>{{site.data.keyword.containershort_notm}}
に含まれる Kubernetes クラスターはすべて、IBM が所有する {{site.data.keyword.BluSoftlayer_full}} アカウントで、IBM が管理する専用 Kubernetes マスターにより制御されます。Kubernetes マスターは、他の IBM のお客様とは共用されない、以下の専用コンポーネントを使用してセットアップされます。
<ul><ul><li>etcd データ・ストア: サービス、デプロイメント、ポッドなどのクラスターのすべての Kubernetes リソースを保管します。
Kubernetes ConfigMaps および Secrets は、ポッドで実行されるアプリで使用できるように、キー値ペアとして保管されるアプリ・データです。
etcd のデータは IBM によって管理される暗号化ディスクに保管され、ポッドに送信されるときには TLS で暗号化されるので、データの保護と完全性が確保されます。
<li>kube-apiserver: ワーカー・ノードから Kubernetes マスターへのすべての要求のメインエントリー・ポイントとなります。
kube-apiserver は要求を検証して処理し、etcd データ・ストアに対する読み取り/書き込みを行うことができます。
<li><kube-scheduler: ポッドをどこにデプロイするかを決定します。このとき、キャパシティーとパフォーマンスのニーズ、ハードウェアとソフトウェアのポリシー制約、アンチアフィニティー仕様、およびワークロード要件が考慮されます。要件に合致するワーカー・ノードが見つからなければ、ポッドはクラスターにデプロイされません。
<li>kube-controller-manager: レプリカ・セットをモニターし、対応するポッドを作成して目的の状態を実現するためのコンポーネントです。
<li>OpenVPN: {{site.data.keyword.containershort_notm}} 固有のコンポーネントであり、Kubernetes マスターからワーカー・ノードへのすべての通信のためのセキュア・ネットワーク接続を提供します。
</ul></ul></dd>
  <dt>ワーカー・ノードから Kubernetes マスターへのすべての通信のための TLS セキュア・ネットワーク接続</dt>
    <dd>Kubernetes マスターへのネットワーク通信を保護するために、{{site.data.keyword.containershort_notm}} によって TLS 証明書がクラスターごとに生成されます。これを使って kube-apiserver コンポーネントおよび etcd データ・ストア・コンポーネントとの間でやり取りされる通信が暗号化されます。
これらの証明書は、クラスター間で共有されたり、Kubernetes マスター・コンポーネント間で共有されたりすることはありません。
</dd>
  <dt>Kubernetes マスターからワーカー・ノードへのすべての通信のための OpenVPN セキュア・ネットワーク接続</dt>
    <dd>Kubernetes は、`https` プロトコルを使用して Kubernetes マスターとワーカー・ノードの間の通信を保護しますが、デフォルトでは、ワーカー・ノードで認証は行われません。
この通信を保護するために、{{site.data.keyword.containershort_notm}} は、クラスターの作成時に、Kubernetes マスターとワーカー・ノードの間の OpenVPN 接続を自動的にセットアップします。
</dd>
  <dt>継続的な Kubernetes マスター・ネットワーク・モニタリング</dt>
    <dd>どの Kubernetes マスターも IBM によって継続的にモニターされ、処理レベルのサービス妨害 (DOS) 攻撃を制御して対処します。
</dd>
  <dt>Kubernetes マスター・ノードのセキュリティー・コンプライアンス</dt>
    <dd>{{site.data.keyword.containershort_notm}} は、Kubernetes マスターがデプロイされたすべてのノードにおいて、マスター・ノードを確実に保護するために適用する必要がある Kubernetes と OS 固有のセキュリティー修正の対象となる脆弱性を自動的にスキャンします。
脆弱性が検出されると、{{site.data.keyword.containershort_notm}} はユーザーに代わって自動的に修正を適用し、脆弱性を解決します。
</dd>
</dl>  

## ワーカー・ノード
{: #cs_security_worker}

ワーカー・ノード環境を保護し、リソース、ネットワーク、ストレージの分離を保証する組み込みのワーカー・ノード・セキュリティー機能について説明します。
{: shortdesc}

<dl>
  <dt>コンピュート、ネットワーク、およびストレージ・インフラストラクチャーの分離</dt>
    <dd>クラスターを作成すると、お客様の {{site.data.keyword.BluSoftlayer_notm}} アカウントまたは IBM 提供の {{site.data.keyword.BluSoftlayer_notm}} アカウントに、仮想マシンがワーカー・ノードとしてプロビジョンされます。ワーカー・ノードは特定のクラスターの専用であり、他のクラスターのワークロードをホストすることはありません。</br>
ワーカー・ノードのネットワーク・パフォーマンスと分離の品質を保証するために、すべての {{site.data.keyword.Bluemix_notm}} アカウントには、
{{site.data.keyword.BluSoftlayer_notm}} VLAN がセットアップされます。
</br>クラスターにデータを保存する場合は、{{site.data.keyword.BluSoftlayer_notm}} の NFS ベースの専用ファイル・ストレージをプロビジョンし、
このプラットフォームの組み込みデータ・セキュリティー機能を利用することができます。
</dd>
  <dt>保護されたワーカー・ノードのセットアップ</dt>
    <dd>すべてのワーカー・ノードは Ubuntu オペレーティング・システムを使用してセットアップされ、ユーザーが変更することはできません。
ワーカー・ノードのオペレーティング・システムを潜在的な攻撃から保護するために、すべてのワーカー・ノードに、Linux iptable ルールによって適用されるエキスパート・ファイアウォール設定が構成されます。
</br> Kubernetes 上で実行されるコンテナーはすべて、定義済みの Calico ネットワーク・ポリシー設定で保護されます。この設定は、クラスター作成時にワーカー・ノードごとに構成されます。このようなセットアップにより、ワーカー・ノードとポッドの間のセキュア・ネットワーク通信が確保されます。
コンテナーがワーカー・ノード上で実行できるアクションをさらに制限するために、ユーザーは、ワーカー・ノードについて [AppArmor ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) を構成することを選択できます。</br> デフォルトでは、ワーカー・ノード上の root ユーザーへの SSH アクセスは無効になっています。ワーカー・ノードに追加機能をインストールする場合、すべてのワーカー・ノードで実行するすべてのアクションについて [Kubernetes デーモン・セット ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) を使用できます。また、1 回限りのアクションについては、[Kubernetes ジョブ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) を使用できます。</dd>
  <dt>Kubernetes ワーカー・ノードのセキュリティー・コンプライアンス</dt>
    <dd>IBM は、ワーカー・ノードのセキュリティー・コンプライアンス上の潜在的な問題を見つけるために社内外のセキュリティー助言チームと連携しています。
そして、見つかった脆弱性に対処するためのコンプライアンス更新プログラムとセキュリティー・パッチを継続的にリリースしています。
更新プログラムとセキュリティー・パッチは、IBM が、ワーカー・ノードのオペレーティング・システムに自動的にデプロイしています。
そのために、IBM はワーカー・ノードへの SSH アクセスを保持しています。
</br> <b>注</b>: 一部の更新プログラムでは、ワーカー・ノードのリブートが必要になります。ただし、IBM は、更新プログラムやセキュリティー・パッチのインストール時にワーカー・ノードをリブートしません。
更新プログラムとセキュリティー・パッチのインストールを完了させるために、ユーザーには、ワーカー・ノードを定期的にリブートすることをお勧めします。
</dd>
  <dt>SoftLayer ネットワーク・ファイアウォールのサポート</dt>
    <dd>{{site.data.keyword.containershort_notm}} は、すべての [{{site.data.keyword.BluSoftlayer_notm}} ファイアウォール・オファリング ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud-computing/bluemix/network-security) に対応しています。{{site.data.keyword.Bluemix_notm}} Public では、カスタム・ネットワーク・ポリシーをファイアウォールにセットアップして、
クラスターのための専用ネットワーク・セキュリティーを設定し、ネットワーク侵入を検出して対処することができます。例えば、ファイアウォールとして不要なトラフィックをブロックするように [Vyatta ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://knowledgelayer.softlayer.com/topic/vyatta-1) をセットアップすることを選択できます。ファイアウォールをセットアップする場合は、マスター・ノードとワーカー・ノードが通信できるように、地域ごとに[必要なポートと IP アドレスを開く](#opening_ports)必要もあります。{{site.data.keyword.Bluemix_notm}} Dedicated では、ファイアウォール、DataPower、Fortigate、DNS が、標準の専用環境デプロイメントの一部として既に構成されています。</dd>
  <dt>サービスをプライベートにしておくか、サービスとアプリを選択的に公共のインターネットに公開する</dt>
    <dd>サービスとアプリをプライベートにして、このトピックで説明した組み込みのセキュリティー機能を利用して、ワーカー・ノードとポッドの間のセキュアな通信を確保することができます。
サービスとアプリを公共のインターネットに公開する場合は、Ingress とロード・バランサーのサポートを活用してサービスを安全に公開することができます。
</dd>
  <dt>ワーカー・ノードとアプリをオンプレミス・データ・センターにセキュアに接続する</dt>
    <dd>Vyatta Gateway Appliance または Fortigate Appliance をセットアップして、Kubernetes クラスターをオンプレミス・データ・センターに接続する IPSec VPN エンドポイントを構成できます。暗号化されたトンネルを介して、Kubernetes クラスターで実行されるすべてのサービスは、ユーザー・ディレクトリー、データベース、メインフレームなどのオンプレミス・アプリとセキュアに通信できます。詳しくは、[オンプレミス・データ・センターへのクラスターの接続 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) を参照してください。</dd>
  <dt>クラスター・アクティビティーの継続的なモニタリングとロギング</dt>
    <dd>標準クラスターの場合、ワーカー・ノードの追加、ローリング更新の進行状況、キャパシティー使用状況情報などのすべてのクラスター関連イベントは、{{site.data.keyword.containershort_notm}} によってログに記録されてモニターされ、IBM のモニタリング・サービスとロギング・サービスに送られます。</dd>
</dl>

### ファイアウォールで必要なポートと IP アドレスを開く
{: #opening_ports}

{{site.data.keyword.BluSoftlayer_notm}} アカウントでワーカー・ノード用にファイアウォールをセットアップするときやファイアウォール設定をカスタマイズするときは、ワーカー・ノードと Kubernetes マスターが通信できるように、特定のポートと IP アドレスを開く必要があります。

1.  以下を実行して、クラスター内のすべてのワーカー・ノードのパブリック IP アドレスをメモします。

    ```
    bx cs workers <cluster_name_or_id>
    ```
    {: pre}

2.  ファイアウォールで、ワーカー・ノードとの間の以下の接続を許可します。

  ```
  TCP port 443 FROM <each_worker_node_publicIP> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>ワーカー・ノードからのアウトバウンド接続として、ソース・ワーカー・ノードから、`<each_worker_node_publicIP>` の宛先 TCP/UDP ポート範囲 (20000 から 32767 まで) への発信ネットワーク・トラフィック、および以下の IP アドレスとネットワーク・グループへの発信ネットワーク・トラフィックを許可します。</br>
    

    <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
    <thead>
      <th colspan=2><img src="images/idea.png"/> アウトバウンド IP アドレス</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01
</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>


## ネットワーク・ポリシー
{: #cs_security_network_policies}

Kubernetes クラスターはそれぞれ、Calico と呼ばれるネットワーク・プラグインを使用してセットアップされます。各ワーカー・ノードのパブリック・ネットワーク・インターフェースを保護するために、デフォルトのネットワーク・ポリシーがセットアップされます。

固有のセキュリティー要件があるときには、Calico および Kubernetes のネイティブ機能を使用してクラスター用のネットワーク・ポリシーをさらに構成できます。
これらのネットワーク・ポリシーは、クラスター内のポッドを出入りするネットワーク・トラフィックのどれを許可し、どれをブロックするかを指定します。
{: shortdesc}

Calico と Kubernetes のネイティブ機能のいずれかを選んで、ご使用のクラスター用のネットワーク・ポリシーを作成することができます。
手始めには Kubernetes のネットワーク・ポリシーを使用することができますが、より堅牢な機能が必要であれば Calico のネットワーク・ポリシーを使用してください。

<ul><li>[Kubernetes ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): 相互通信できるポッドを指定するなど、いくつかの基本的なオプションが用意されています。ポッドの着信ネットワーク・トラフィックは、ラベル、および接続しようとしているポッドの Kubernetes 名前空間に基づき、プロトコルおよびポートについて許可またはブロックできます。
</br>これらのポリシーは
`kubectl` コマンドまたは Kubernetes API を使用して適用できます。これらのポリシーが適用されると、Calico ネットワーク・ポリシーに変換され、Calico がこれらのポリシーを実施します。<li>[Calico ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy): これらのポリシーは Kubernetes ネットワーク・ポリシーのスーパーセットであり、Kubernetes のネイティブ機能に以下の機能を追加して拡張したものです。
<ul><ul><li>Kubernetes ポッドのトラフィックだけではなく、特定のネットワーク・インターフェース上のネットワーク・トラフィックを許可またはブロックします。
<li>着信 (ingress) および発信 (egress) ネットワーク・トラフィックを許可またはブロックします。<li>送信元または宛先 IP アドレスまたは CIDR に基づき、トラフィックを許可またはブロックします。</ul></ul></br>
これらのポリシーは `calicoctl` コマンドを使用して適用されます。Calico は Kubernetes ワーカー・ノード上に Linux iptables 規則をセットアップすることによって、これらのポリシーを実施しますが、これには Calico ポリシーに変換された Kubernetes ネットワーク・ポリシーも含まれます。
iptables 規則はワーカー・ノードのファイアウォールとして機能し、ネットワーク・トラフィックがターゲット・リソースに転送されるために満たさなければならない特性を定義します。
</ul>


### デフォルト・ポリシーの構成
{: #concept_nq1_2rn_4z}

クラスターの作成時には、各ワーカー・ノードのパブリック・ネットワーク・インターフェース用のデフォルトのネットワーク・ポリシーが自動的にセットアップされ、パブリック・インターネットからのワーカー・ノードの着信トラフィックを制限します。
これらのポリシーはポッド間のトラフィックには影響せず、Kubernetes ノードポート、ロード・バランサー、入口サービスへのアクセスを許可するためにセットアップされます。

デフォルト・ポリシーはポッドに直接適用されるわけではありません。Calico の[ホスト・エンドポイント ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal) を使用して、ワーカー・ノードのパブリック・ネットワーク・インターフェースに適用されます。ホストのエンドポイントが Calico に作成されると、そのワーカー・ノードのネットワーク・インターフェースを出入りするトラフィックは、ポリシーによってそのトラフィックが許可されていない限り、すべてブロックされます。


SSH を許可するポリシーは存在せず、そのため、パブリック・ネットワーク・インターフェースによる SSH アクセスはブロックされることに気を付けてください。これはポートを開くためのポリシーを持たない、他のすべてのポートも同様です。
SSH アクセスと他のアクセスは、各ワーカー・ノードのプライベート・ネットワーク・インターフェースで使用可能です。


**重要:** ポリシーを十分に理解していない限り、かつ、ポリシーにより許可されるトラフィックが必要ないと判断できるのでない限り、ホストのエンドポイントに適用されるポリシーを削除しないでください。



  <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
    <thead>
  <th colspan=2><img src="images/idea.png"/> 各クラスターのデフォルト・ポリシー</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>すべてのアウトバウンド・トラフィックを許可します。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>すべての着信 icmp パケット (ping) を許可します。</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>ポート 10250 (kubelet により使用されるポート) へのすべての着信トラフィックを許可します。.
このポリシーは Kubernetes クラスターで `kubectl logs` と `kubectl exec` が正しく機能するようにします。
</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>着信ノードポート、ロード・バランサー、およびサービスが公開されるポッドへの入口サービス・トラフィックを許可します。
Kubernetes ではサービス要求を正しいポッドに転送するために宛先ネットワーク・アドレス変換 (DNAT) を使用するため、それらのサービスがパブリック・インターフェースで公開されるポートは指定する必要がないことに気を付けてください。
ホストのエンドポイント・ポリシーが iptables で適用される前に、その転送が実行されます。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>ワーカー・ノードを管理するために使用される特定の {{site.data.keyword.BluSoftlayer_notm}} システムの着信接続を許可します。
</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>ワーカー・ノード間の仮想 IP アドレスのモニターと移動に使用される vrrp パケットを許可します。
</td>
   </tr>
  </tbody>
</table>


### ネットワーク・ポリシーの追加
{: #adding_network_policies}

ほとんどの場合、デフォルト・ポリシーは変更する必要がありません。拡張シナリオのみ、変更が必要な場合があります。
変更が必要であるとわかった場合は、Calico CLI をインストールし、独自のネットワーク・ポリシーを作成します。


開始する前に、以下のステップを完了してください。 

1.  [{{site.data.keyword.containershort_notm}} および Kubernetes CLI をインストールします。](cs_cli_install.html#cs_cli_install)
2.  [ライト・クラスターまたは標準クラスターを作成します。](cs_cluster.html#cs_cluster_ui)
3.  [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。`bx cs cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。
このダウンロードには、Calico コマンドの実行に必要な管理者 rbac 役割の鍵も含まれています。

  ```
  bx cs cluster-config <cluster_name> 
  ```
  {: pre}


ネットワーク・ポリシーを追加するには、以下のようにします。
1.  Calico CLI をインストールします。
    1.  [Calico CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/projectcalico/calicoctl/releases/) をダウンロードします。

        **ヒント:** Windows を使用している場合、Calico CLI を {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールします。このようにセットアップすると、後でコマンドを実行するとき、ファイル・パスの変更を行う手間がいくらか少なくなります。


    2.  OSX と Linux のユーザーは、以下の手順を実行してください。

        1.  実行可能ファイルを /usr/local/bin ディレクトリーに移動します。
            -   Linux:


              ```
mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl```
              {: pre}

            -   OS X:

              ```
mv /<path_to_file>/calico-darwin-amd64 /usr/local/bin/calicoctl```
              {: pre}

        2.  バイナリー・ファイルを実行可能ファイルに変換します。


            ```
chmod +x /usr/local/bin/calicoctl```
            {: pre}

    3.  Calico CLI クライアントのバージョンを調べて、`calico` コマンドが正常に実行されたことを確認します。

        ```
calicoctl version```
        {: pre}

2.  Calico CLI を構成します。

    1.  Linux および OS X の場合、'/etc/calico' ディレクトリーを作成します。Windows の場合は、どのディレクトリーを使用しても構いません。

      ```
mkdir -p /etc/calico/```
      {: pre}

    2.  'calicoctl.cfg' ファイルを作成します。
        -   Linux および OS X:

          ```
sudo vi /etc/calico/calicoctl.cfg```
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
      {: pre}

        1.  `<ETCD_URL>` を取得します。

          -   Linux および OS X:

              ```
kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'```
              {: pre}

          -   出力例:

              ```
https://169.1.1.1:30001```
              {: screen}

          -   Windows:<ol>
            <li>kube-system 名前空間内のポッドのリストを取得し、Calico コントローラー・ポッドを見つけます。</br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>例:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>Calico コントローラー・ポッドの詳細を表示します。</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>ETCD エンドポイント値を見つけます。例: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  `<CERTS_DIR>` (Kubernetes 証明書をダウンロードしたディレクトリー) を取得します。

            -   Linux および OS X:

              ```
dirname $KUBECONFIG```
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

        3.  
<code>ca-*pem_file<code> を取得します。

            -   Linux および OS X:

              ```
ls `dirname $KUBECONFIG` | grep ca-.*pem```
              {: pre}

            -   Windows:<ol><li>最後のステップで取得したディレクトリーを開きます。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&#60;cluster_name&#62;-admin\</code></pre>
              <li> <code>ca-*pem_file</code> ファイルを見つけます。</ol>

        4.  Calico 構成が正常に動作していることを確認します。


            -   Linux および OS X:

              ```
calicoctl get nodes```
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
calicoctl get hostendpoint -o yaml```
      {: pre}

    -   そのクラスター用に作成されたすべての Calico および Kubernetes ネットワーク・ポリシーを表示します。
このリストにはどのポッドやホストにもまだ適用されていない可能性のあるポリシーも含まれています。ネットワーク・ポリシーを実施するには、
Calico ネットワーク・ポリシーで定義されたセレクターに一致する Kubernetes リソースを見つける必要があります。

      ```
calicoctl get policy -o wide```
      {: pre}

    -   ネットワーク・ポリシーの詳細を表示します。


      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   そのクラスター用のすべてのネットワーク・ポリシーの詳細を表示します。


      ```
calicoctl get policy -o yaml```
      {: pre}

4.  トラフィックを許可またはブロックする Calico ネットワーク・ポリシーを作成します。

    1.  構成スクリプト (.yaml) を作成して、独自の [Calico ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy) を定義します。これらの構成ファイルにはどのポッド、名前空間、またはホストにこれらのポリシーを適用するかを説明するセレクターが含まれます。独自のポリシーを作成するときには、こちらの[サンプル Calico ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) を参考にしてください。

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


## イメージ
{: #cs_security_deployment}

標準装備のセキュリティー・フィーチャーを使用して、イメージのセキュリティーと保全性を管理します。
{: shortdesc}

### {{site.data.keyword.registryshort_notm}} の保護された Docker プライベート・イメージ・リポジトリー:

 IBM がホストおよび管理するマルチテナントで可用性が高く拡張可能なプライベート・イメージ・レジストリー内に独自の Docker イメージ・リポジトリーをセットアップし、Docker イメージを作成して安全に保管し、クラスター・ユーザー間で共有することができます。

### イメージのセキュリティー・コンプライアンス:

{{site.data.keyword.registryshort_notm}}を使用する際、Vulnerability Advisor に標準装備のセキュリティー・スキャンを利用できます。名前空間にプッシュされるどのイメージも、CentOS、Debian、Red Hat、および Ubuntu の既知の問題のデータベースに基づいて、脆弱性が自動的にスキャンされます。脆弱性が検出されると、それらを解決してイメージの保全性とセキュリティーを確保する方法を Vulnerability Advisor が提示します。


イメージの脆弱性評価を表示するには、以下のようにします。


1.  **カタログ**から**「コンテナー」**を選択します。

2.  脆弱性評価を調べるイメージを選択します。

3.  **「脆弱性評価」**セクションで、**「レポートの表示」**をクリックします。

