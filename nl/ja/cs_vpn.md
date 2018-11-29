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


# VPN 接続のセットアップ
{: #vpn}

VPN 接続を使用すると、{{site.data.keyword.containerlong}} 上の Kubernetes クラスター内のアプリをオンプレミス・ネットワークにセキュアに接続できます。 クラスター外のアプリを、クラスター内で実行中のアプリに接続することもできます。
{:shortdesc}

ワーカー・ノードとアプリをオンプレミス・データ・センターに接続するには、以下のいずれかのオプションを構成します。

- **strongSwan IPSec VPN サービス**: Kubernetes クラスターをオンプレミス・ネットワークとセキュアに接続する [strongSwan IPSec VPN サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.strongswan.org/about.html) をセットアップできます。 strongSwan IPSec VPN サービスは、業界標準の Internet Protocol Security (IPSec) プロトコル・スイートに基づき、インターネット上にセキュアなエンドツーエンドの通信チャネルを確立します。 クラスターとオンプレミス・ネットワークの間にセキュアな接続をセットアップするためには、クラスター内のポッドに直接、[strongSwan IPSec VPN サービスを構成してデプロイします](#vpn-setup)。

- **Virtual Router Appliance (VRA) または Fortigate Security Appliance (FSA)**: [VRA](/docs/infrastructure/virtual-router-appliance/about.html) または [FSA](/docs/infrastructure/fortigate-10g/about.html) をセットアップして、IPSec VPN エンドポイントを構成することもできます。 このオプションは、クラスターが大きい場合、単一の VPN で複数のクラスターにアクセスする場合、ルート・ベース VPN が必要な場合に役立ちます。 VRA を構成するには、[Vyatta を使用した VRA 接続のセットアップ](#vyatta)を参照してください。

## strongSwan IPSec VPN サービスの Helm チャートの使用
{: #vpn-setup}

Helm チャートを使用して、Kubernetes ポッド内に strongSwan IPSec VPN サービスを構成してデプロイします。
{:shortdesc}

strongSwan はクラスターに組み込まれているので、外部ゲートウェイ・デバイスは必要ありません。 VPN 接続が確立されると、クラスター内のすべてのワーカー・ノードにルートが自動的に構成されます。 これらのルートにより、任意のワーカー・ノード上のポッドとリモート・システムの間で、VPN トンネルを介した両方向の接続が可能になります。 例えば、以下の図は、{{site.data.keyword.containerlong_notm}} 内のアプリがオンプレミス・サーバーと strongSwan VPN 接続を介して通信する方法を示しています。

<img src="images/cs_vpn_strongswan.png" width="700" alt="ロード・バランサーを使用して {{site.data.keyword.containerlong_notm}} のアプリを公開する" style="width:700px; border-style: none"/>

1. クラスター内のアプリ `myapp` は、Ingress または LoadBalancer サービスから要求を受け取ると、オンプレミス・ネットワーク内のデータにセキュアに接続する必要があります。

2. オンプレミス・データ・センターへの要求は、IPSec strongSwan VPN ポッドに転送されます。 宛先 IP アドレスを使用して、IPSec strongSwan VPN ポッドに送信するネットワーク・パケットが判別されます。

3. 要求は暗号化され、VPN トンネルを介してオンプレミス・データ・センターに送信されます。

4. 着信要求はオンプレミス・ファイアウォールを通過して、VPN トンネル・エンドポイント (ルーター) に送達され、そこで復号されます。

5. VPN トンネル・エンドポイント (ルーター) が、ステップ 2 で指定された宛先 IP アドレスに応じて、オンプレミスのサーバーまたはメインフレームに要求を転送します。同じプロセスにより、必要なデータが VPN 接続を介して `myapp` に送り返されます。

## strongSwan VPN サービスの考慮事項
{: strongswan_limitations}

strongSwan Helm チャートを使用する前に、以下の考慮事項や制限を確認してください。

* strongSwan Helm チャートでは、リモート VPN エンドポイントによって有効にされる NAT トラバーサルが必要です。 NAT トラバーサルでは、デフォルトの IPSec UDP ポート 500 に加えて、UDP ポート 4500 が必要です。 両方の UDP ポートは、構成されているすべてのファイアウォールの通過が許可される必要があります。
* strongSwan Helm チャートでは、ルート・ベース IPSec VPN はサポートされません。
* strongSwan Helm チャートでは、事前共有鍵を使用する IPSec VPN はサポートされますが、証明書を必要とする IPSec VPN はサポートされません。
* strongSwan Helm チャートでは、複数のクラスターとその他の IaaS リソースで単一の VPN 接続を共有することは許可されません。
* strongSwan Helm チャートは、クラスター内で Kubernetes ポッドとして実行されます。 VPN のパフォーマンスは、クラスター内で実行されている Kubernetes やその他のポッドのメモリーおよびネットワークの使用量の影響を受けます。 パフォーマンスが重要な環境の場合は、クラスター外部の専用ハードウェアで実行される VPN ソリューションを使用することを考慮してください。
* strongSwan Helm チャートでは、IPSec トンネル・エンドポイントとして単一の VPN ポッドが実行されます。 ポッドに障害が発生すると、クラスターはポッドを再始動します。 ただし、新しいポッドが開始され、VPN 接続が再確立されるまで、わずかなダウン時間が発生する場合があります。 より迅速なエラー・リカバリーやより精緻な高可用性ソリューションが必要な場合は、クラスター外部の専用ハードウェアで実行される VPN ソリューションを使用することを考慮してください。
* strongSwan Helm チャートでは、VPN 接続を介して流れるネットワーク・トラフィックのメトリックまたはモニターは提供されません。 サポートされるモニター・ツールのリストについては、[サービスのロギングとモニタリング](cs_integrations.html#health_services)を参照してください。

## strongSwan Helm チャートの構成
{: #vpn_configure}

開始前に、以下のことを行います。
* [オンプレミス・データ・センターに IPSec VPN ゲートウェイをインストールします](/docs/infrastructure/iaas-vpn/set-up-ipsec-vpn.html#setting-up-an-ipsec-connection)。
* [標準クラスターを作成します](cs_clusters.html#clusters_cli)。
* [アカウントにログインします。 該当する地域とリソース・グループ (該当する場合) をターゲットとして設定します。クラスターのコンテキストを設定します](cs_cli_install.html#cs_cli_configure)。

### ステップ 1: strongSwan Helm チャートの取得
{: #strongswan_1}

1. [クラスター用の Helm をインストールし、Helm インスタンスに {{site.data.keyword.Bluemix_notm}} リポジトリーを追加します](cs_integrations.html#helm)。

2. ローカル YAML ファイル内に strongSwan Helm chart のデフォルトの構成設定を保存します。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. `config.yaml` ファイルを開きます。

### ステップ 2: 基本 IPSec 設定の構成
{: #strongswan_2}

VPN 接続の確立を制御するには、以下の基本 IPSec 設定を変更します。

各設定の詳細については、Helm チャートの `config.yaml` ファイル内で提供される資料をお読みください。
{: tip}

1. オンプレミスの VPN トンネル・エンドポイントで、接続を初期化するためのプロトコルとして `ikev2` がサポートされていない場合は、`ipsec.keyexchange` の値を `ikev1` または `ike` に変更します。
2. オンプレミスの VPN トンネル・エンドポイントで接続に使用する ESP 暗号化と認証のアルゴリズムのリストに `ipsec.esp` を設定します。
    * `ipsec.keyexchange` が `ikev1` に設定されている場合、この設定値の指定は必須です。
    * `ipsec.keyexchange` が `ikev2` に設定されている場合、この設定値の指定は任意です。
    * この設定をブランクにしておくと、デフォルトの strongSwan アルゴリズム `aes128-sha1,3des-sha1` が接続に使用されます。
3. オンプレミスの VPN トンネル・エンドポイントで接続に使用する IKE/ISAKMP SA 暗号化と認証のアルゴリズムのリストに `ipsec.ike` を設定します。 アルゴリズムは、`encryption-integrity[-prf]-dhgroup` の形式で固有にする必要があります。
    * `ipsec.keyexchange` が `ikev1` に設定されている場合、この設定値の指定は必須です。
    * `ipsec.keyexchange` が `ikev2` に設定されている場合、この設定値の指定は任意です。
    * この設定をブランクにしておくと、デフォルトの strongSwan アルゴリズム `aes128-sha1-modp2048,3des-sha1-modp1536` が接続に使用されます。
4. `local.id` の値を VPN トンネル・エンドポイントで使用されるローカル Kubernetes クラスター側の識別に使用する任意のストリングに変更します。 デフォルトは `ibm-cloud` です。 一部の VPN 実装では、ローカル・エンドポイントのパブリック IP アドレスを使用する必要があります。
5. `remote.id` の値を VPN トンネル・エンドポイントで使用されるリモート・オンプレミス側の識別に使用する任意のストリングに変更します。 デフォルトは `on-prem` です。 一部の VPN 実装では、リモート・エンドポイントのパブリック IP アドレスを使用する必要があります。
6. `preshared.secret` の値を、オンプレミスの VPN トンネル・エンドポイント・ゲートウェイで接続に使用される事前共有シークレットに変更します。 この値は `ipsec.secrets` に保管されます。
7. オプション: `remote.privateIPtoPing` を Helm 接続検証テストの一部として ping するリモート・サブネット内の任意のプライベート IP アドレスに設定します。

### ステップ 3: インバウンドまたはアウトバウンド VPN 接続の選択
{: #strongswan_3}

strongSwan VPN 接続を構成する場合、VPN 接続をクラスターへのインバウンドにするか、またはクラスターからのアウトバウンドにするかを選択します。
{: shortdesc}

<dl>
<dt>インバウンド</dt>
<dd>リモート・ネットワークからのオンプレミス VPN エンドポイントが VPN 接続を開始し、クラスターが接続を listen します。</dd>
<dt>アウトバウンド</dt>
<dd>クラスターが VPN 接続を開始し、リモート・ネットワークからのオンプレミス VPN エンドポイントが接続を listen します。</dd>
</dl>

インバウンド VPN 接続を確立するには、以下の設定を変更します。
1. `ipsec.auto` が `add` に設定されていることを確認します。
2. オプション: `loadBalancerIP` を strongSwan VPN サービスのポータブル・パブリック IP アドレスに設定します。 IP アドレスを指定すると、オンプレミス・ファイアウォールの通過を許可する IP アドレスを指定する必要がある場合など、安定した IP アドレスが必要な場合に役立ちます。 クラスターに 1 つ以上の使用可能なパブリック・ロード・バランサー IP アドレスがなければなりません。 [使用可能なパブリック IP アドレスを確認](cs_subnets.html#review_ip)したり、[使用されている IP アドレスを解放](cs_subnets.html#free)したりすることができます。<br>**注:**
    * この設定をブランクのままにすると、使用可能なポータブル・パブリック IP アドレスの 1 つが使用されます。
    * オンプレミス VPN エンドポイントのクラスター VPN エンドポイントに対して選択したパブリック IP アドレス、または割り当てられたパブリック IP アドレスを構成する必要もあります。

アウトバウンド VPN 接続を確立するには、以下の設定を変更します。
1. `ipsec.auto` を `start` に変更します。
2. `remote.gateway` をリモート・ネットワーク内のオンプレミス VPN エンドポイントのパブリック IP アドレスに設定します。
3. クラスター VPN エンドポイントの IP アドレスについて、以下のいずれかのオプションを選択します。
    * **クラスターの専用ゲートウェイのパブリック IP アドレス**: ワーカー・ノードがプライベート VLAN にのみ接続されている場合、アウトバウンド VPN 要求は、インターネットに到達するために専用ゲートウェイを介してルーティングされます。 専用ゲートウェイのパブリック IP アドレスが VPN 接続に使用されます。
    * **strongSwan ポッドが実行されているワーカー・ノードのパブリック IP アドレス**: strongSwan ポッドが実行されているワーカー・ノードがパブリック VLAN に接続されている場合、ワーカー・ノードのパブリック IP アドレスが VPN 接続に使用されます。
        <br>**注:**
        * strongSwan ポッドが削除され、クラスター内の別のワーカー・ノードにスケジュール変更された場合は、VPN のパブリック IP アドレスは変更されます。 リモート・ネットワークのオンプレミス VPN エンドポイントは、いずれのクラスター・ワーカー・ノードのパブリック IP アドレスでも VPN 接続が確立されることを許可する必要があります。
        * リモート VPN エンドポイントが複数のパブリック IP アドレスからの VPN 接続を処理できない場合は、strongSwan VPN ポッドがデプロイされるノードを制限してください。 `nodeSelector` を特定のワーカー・ノードまたはワーカー・ノード・ラベルの IP アドレスに設定します。 例えば、`kubernetes.io/hostname: 10.232.xx.xx` という値を指定すると、そのワーカー・ノードにのみ VPN ポッドのデプロイが許可されます。 `strongswan: vpn` という値を指定すると、そのラベルのワーカー・ノードで実行するように VPN ポッドを制限できます。 任意のワーカー・ノード・ラベルを使用できます。 別の helm チャート・デプロイメントで別のワーカー・ノードが使用されること許可するには、`strongswan: <release_name>` を使用します。 高可用性のためには、少なくとも 2 つのワーカー・ノードを選択します。
    * **strongSwan サービスのパブリック IP アドレス**: strongSwan VPN サービスの IP アドレスを使用して接続を確立するには、`connectUsingLoadBalancerIP` を `true` に設定します。 strongSwan サービス IP アドレスは、`loadBalancerIP` 設定で指定できるポータブル・パブリック IP アドレスか、サービスに自動的に割り当てられる使用可能なポータブル・パブリック IP アドレスのいずれかです。
        <br>**注:**
        * `loadBalancerIP` 設定を使用して IP アドレスを選択する場合、クラスターに 1 つ以上の使用可能なパブリック・ロード・バランサー IP アドレスがなければなりません。 [使用可能なパブリック IP アドレスを確認](cs_subnets.html#review_ip)したり、[使用されている IP アドレスを解放](cs_subnets.html#free)したりすることができます。
        * すべてのクラスター・ワーカー・ノードが同じパブリック VLAN 上に存在する必要があります。 あるいは、`nodeSelector` 設定を使用して、VPN ポッドを `loadBalancerIP` と同じパブリック VLAN 上のワーカー・ノードにデプロイする必要があります。
        * `connectUsingLoadBalancerIP` が `true` に設定されていて、`ipsec.keyexchange` が `ikev1` に設定されている場合、`enableServiceSourceIP` を `true` に設定する必要があります。

### ステップ 4: VPN 接続を介したクラスター・リソースへのアクセス
{: #strongswan_4}

VPN 接続を介してリモート・ネットワークがアクセスできるクラスター・リソースを決定します。
{: shortdesc}

1. 1 つ以上のクラスター・サブネットの CIDR を `local.subnet` 設定に追加します。 オンプレミス VPN エンドポイントでローカル・サブネット CIDR を構成する必要があります。 以下のサブネットをこのリストに含めることができます。  
    * Kubernetes ポッドのサブネット CIDR: `172.30.0.0/16`。 すべてのクラスター・ポッドと、`remote.subnet` 設定でリストに入れたリモート・ネットワーク・サブネットのあらゆるホストの間で、双方向通信が使用可能になります。 セキュリティー上の理由から、`remote.subnet` ホストがクラスター・ポッドにアクセスできないようにする必要がある場合は、Kubernetes ポッドのサブネットを `local.subnet` 設定に追加しないでください。
    * Kubernetes サービスのサブネット CIDR: `172.21.0.0/16`。 サービス IP アドレスは、単一 IP の背後にある複数のワーカー・ノードにデプロイされている複数のアプリ・ポッドを公開する方法を提供します。
    * アプリがプライベート・ネットワークに NodePort サービスまたはプライベート Ingress ALB を使用して公開される場合は、ワーカー・ノードのプライベート・サブネット CIDR を追加します。 `ibmcloud ks worker <cluster_name>` を実行して、ワーカーのプライベート IP アドレスの先頭 3 オクテットを取得します。 例えば、それが `10.176.48.xx` の場合は `10.176.48` をメモします。 次に、`<xxx.yyy.zz>` を先ほど取得したオクテットに置き換えてコマンド `ibmcloud sl subnet list | grep <xxx.yyy.zzz>` を実行し、ワーカーのプライベート・サブネット CIDR を取得します。<br>**注**: ワーカー・ノードが新規プライベート・サブネットに追加された場合は、新規のプライベート・サブネット CIDR を `local.subnet` 設定およびオンプレミス VPN エンドポイントに追加する必要があります。 その後、VPN 接続を再始動する必要があります。
    * プライベート・ネットワークに LoadBalancer サービスによって公開されるアプリがある場合は、クラスターのプライベート・ユーザー管理サブネット CIDR を追加します。 これらの値を見つけるには、`ibmcloud ks cluster-get <cluster_name> --showResources` を実行します。 **VLANS** セクションで、**Public** 値が `false` の CIDR を見つけます。<br>
    **注**: `ipsec.keyexchange` が `ikev1` に設定されている場合、指定できるサブネットは 1 つだけです。 ただし、`localSubnetNAT` 設定を使用して、複数のクラスター・サブネットを単一のサブネットに結合することができます。

2. オプション: `localSubnetNAT` 設定を使用して、クラスター・サブネットを再マップします。 サブネットのネットワーク・アドレス変換 (NAT) は、クラスター・ネットワークとオンプレミス・リモート・ネットワークの間のサブネット競合の回避策になります。 NAT を使用して、クラスターのプライベート・ローカル IP サブネット、ポッド・サブネット (172.30.0.0/16)、またはポッド・サービス・サブネット (172.21.0.0/16) を、異なるプライベート・サブネットに再マップすることができます。 VPN トンネルでは、元のサブネットではなく、再マップされた IP サブネットが認識されます。 再マッピングは、VPN トンネルを介してパケットが送信される前だけでなく、VPN トンネルからパケットが到着した後も行われます。 再マップされたサブネットと再マップされていないサブネットの両方を同時に VPN を介して公開できます。 NAT を有効にするには、サブネット全体を追加するか、個々の IP アドレスを追加します。
    * サブネット全体を `10.171.42.0/24=10.10.10.0/24` の形式で追加する場合、再マッピングは 1 対 1 になります。つまり、内部ネットワーク・サブネット内のすべての IP アドレスが外部ネットワーク・サブネットにマップされます。その逆も同様です。
    * 個々の IP アドレスを `10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32` の形式で追加する場合、それらの内部 IP アドレスのみが、指定した外部 IP アドレスにマップされます。

3. バージョン 2.2.0 以降の strongSwan Helm チャートのオプション: `enableSingleSourceIP` を `true` に設定して、単一 IP アドレスの背後にあるすべてのクラスター IP アドレスを非表示にします。 このオプションによって、リモート・ネットワークからクラスターへのすべての接続が許可されなくなるため、非常に安全な VPN 接続の構成が提供されます。
    <br>**注:**
    * この設定では、VPN 接続を経由するすべてのデータ・フローは、VPN 接続がクラスターまたはリモート・ネットワークから確立されているかどうかに関係なく、アウトバウンドでなければなりません。
    * `local.subnet` は、1 つの /32 サブネットにのみ設定する必要があります。

4. バージョン 2.2.0 以降の strongSwan Helm チャートのオプション: `localNonClusterSubnet` 設定を使用して、strongSwan サービスで、リモート・ネットワークからの着信要求をクラスター外部にあるサービスに経路指定できるようにします。
    <br>**注:**
    * 非クラスター・サービスは、同じプライベート・ネットワークにあるか、またはワーカー・ノードから到達可能なプライベート・ネットワークに存在する必要があります。
    * 非クラスター・ワーカー・ノードは、VPN 接続を介するリモート・ネットワークへのトラフィックを開始することはできませんが、非クラスター・ノードは、リモート・ネットワークからの着信要求のターゲットになることはあります。
    * `local.subnet` 設定の非クラスター・サブネットの CIDR をリストする必要があります。

### ステップ 5: VPN 接続を介したリモート・ネットワーク・リソースへのアクセス
{: #strongswan_5}

VPN 接続を介してクラスターがアクセスできるリモート・ネットワーク・リソースを決定します。
{: shortdesc}

1. 1 つ以上のオンプレミス・プライベート・サブネットの CIDR を `remote.subnet` 設定に追加します。
    <br>**注**: `ipsec.keyexchange` が `ikev1` に設定されている場合、指定できるサブネットは 1 つだけです。
2. バージョン 2.2.0 以降の strongSwan Helm チャートのオプション: `remoteSubnetNAT` 設定を使用して、リモート・ネットワーク・サブネットを再マップします。 サブネットのネットワーク・アドレス変換 (NAT) は、クラスター・ネットワークとオンプレミス・リモート・ネットワークの間のサブネット競合の回避策になります。 NAT を使用して、リモート・ネットワークの IP サブネットを、異なるプライベート・サブネットに再マップすることができます。 VPN トンネルでは、元のサブネットではなく、再マップされた IP サブネットが認識されます。 再マッピングは、VPN トンネルを介してパケットが送信される前だけでなく、VPN トンネルからパケットが到着した後も行われます。 再マップされたサブネットと再マップされていないサブネットの両方を同時に VPN を介して公開できます。

### ステップ 6: Helm チャートのデプロイ
{: #strongswan_6}

1. 詳細設定を構成する必要がある場合は、Helm チャートの設定ごとに提供されている資料に従ってください。

2. **重要**: Helm チャートの設定の必要がない場合は、そのプロパティーの前に `#` を付けてコメント化してください。

3. 更新した `config.yaml` ファイルを保存します。

4. 更新した `config.yaml` ファイルと共に Helm chart をクラスターにインストールします。 更新したプロパティーが、チャートの構成マップに保管されます。

    **注**: 単一のクラスター内に複数の VPN デプロイメントがある場合は、`vpn` よりもわかりやすいリリース名を選択して、名前の競合を回避し、デプロイメントを区別できます。 切り捨てられないように、リリース名は 35 文字以下に制限してください。

    ```
    helm install -f config.yaml --name=vpn ibm/strongswan
    ```
    {: pre}

5. Chart のデプロイメント状況を確認します。 Chart の準備ができている場合は、出力の先頭付近の **STATUS** フィールドに `DEPLOYED` の値があります。

    ```
    helm status vpn
    ```
    {: pre}

6. Chart をデプロイし終えたら、`config.yaml` ファイル内の更新済みの設定が使用されたことを確認します。

    ```
    helm get values vpn
    ```
    {: pre}

## strongSwan VPN 接続のテストと検証
{: #vpn_test}

Helm チャートをデプロイしたら、VPN 接続をテストします。
{:shortdesc}

1. オンプレミス・ゲートウェイ上の VPN がアクティブでない場合は、VPN を開始します。

2. `STRONGSWAN_POD` 環境変数を設定します。

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

3. VPN の状況を確認します。 `ESTABLISHED` の状況は、VPN 接続が成功したことを意味します。

    ```
    kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    出力例:

    ```
    Security Associations (1 up, 0 connecting):
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.xxx.xxx[ibm-cloud]...192.xxx.xxx.xxx[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.xxx/26
    ```
    {: screen}

    **注:**

    <ul>
    <li>strongSwan Helm チャートを使用して VPN 接続を確立しようとしても、最初は VPN の状況が `ESTABLISHED` にならない可能性があります。 オンプレミスの VPN エンドポイント設定を確認して構成ファイルを何度か変更しないと、接続できない可能性があります。 <ol><li>`helm delete --purge <release_name> を実行します。`</li><li>構成ファイル内の誤った値を修正します。</li><li>`helm install -f config.yaml --name=<release_name> ibm/strongswan` を実行します。</li></ol>次の手順でさらに検査することもできます。</li>
    <li>VPN ポッドが `ERROR` 状態である場合や、クラッシュと再始動が繰り返される場合は、チャートの構成マップ内の `ipsec.conf` 設定のパラメーターの検証が原因である可能性があります。<ol><li>`kubectl logs -n $STRONGSWAN_POD` を実行して、strongSwan ポッドのログに検証エラーがないか確認してください。</li><li>検証エラーがある場合は、`helm delete --purge <release_name> を実行します。`<li>構成ファイル内の誤った値を修正します。</li><li>`helm install -f config.yaml --name=<release_name> ibm/strongswan` を実行します。</li></ol>クラスターに多数のワーカー・ノードがある場合は、`helm delete` と `helm install` を実行するより `helm upgrade` を使用する方が変更を迅速に適用できます。</li>
    </ul>

4. strongSwan チャートの定義に含まれている 5 つの Helm テストを実行して、VPN 接続をさらにテストできます。

    ```
    helm test vpn
    ```
    {: pre}

    * すべてのテストに合格したら、strongSwan VPN 接続は正常にセットアップされています。

    * いずれかのテストが失敗した場合は、次のステップに進みます。

5. テスト・ポッドのログを参照して、失敗したテストの出力を確認します。

    ```
    kubectl logs <test_program>
    ```
    {: pre}

    **注**: テストの中には、VPN 構成ではオプションの設定を必要とするテストがあります。 一部のテストが失敗しても、そのようなオプションの設定を指定したかどうかによっては、失敗を許容できる場合があります。 各テストと、テストが失敗する原因について詳しくは、以下の表を参照してください。

    {: #vpn_tests_table}
    <table>
    <caption>Helm VPN 接続テストについて</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> Helm VPN 接続テストについて</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td><code>config.yaml</code> ファイルから生成された <code>ipsec.conf</code> ファイルの構文を検証します。 このテストは、<code>config.yaml</code> ファイル内に正しくない値があると失敗する可能性があります。</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>VPN 接続の状況が <code>ESTABLISHED</code> であることを確認します。 このテストは、以下の理由で失敗する可能性があります。<ul><li><code>config.yaml</code> ファイルの値とオンプレミス VPN エンドポイントの設定値が違っている。</li><li>クラスターが「listen」モードである (<code>ipsec.auto</code> を <code>add</code> に設定した) 場合、オンプレミス側では接続は確立されない。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td><code>config.yaml</code> ファイルに構成した <code>remote.gateway</code> パブリック IP アドレスを ping します。 このテストは、以下の理由で失敗する可能性があります。<ul><li>オンプレミス VPN ゲートウェイの IP アドレスを指定していない。 <code>ipsec.auto</code> を <code>start</code> に設定する場合は、<code>remote.gateway</code> IP アドレスが必要です。</li><li>VPN 接続の状況が <code>ESTABLISHED</code> ではない。 詳しくは、<code>vpn-strongswan-check-state</code> を参照してください。</li><li>VPN 接続は <code>ESTABLISHED</code> であるが、ファイアウォールによって ICMP パケットがブロックされている。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>クラスター内の VPN ポッドから、オンプレミス VPN ゲートウェイの <code>remote.privateIPtoPing</code> プライベート IP アドレスを ping します。 このテストは、以下の理由で失敗する可能性があります。<ul><li><code>remote.privateIPtoPing</code> IP アドレスを指定していない。 意図的に IP アドレスを指定していないのであれば、この失敗は許容できます。</li><li><code>local.subnet</code> リストにクラスター・ポッドのサブネット CIDR の <code>172.30.0.0/16</code> を指定していない。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>クラスター内のワーカー・ノードから、オンプレミス VPN ゲートウェイの <code>remote.privateIPtoPing</code> プライベート IP アドレスを ping します。 このテストは、以下の理由で失敗する可能性があります。<ul><li><code>remote.privateIPtoPing</code> IP アドレスを指定していない。 意図的に IP アドレスを指定していないのであれば、この失敗は許容できます。</li><li><code>local.subnet</code> リストにクラスター・ワーカー・ノードのプライベート・サブネット CIDR を指定していない。</li></ul></td>
    </tr>
    </tbody></table>

6. 現在の Helm チャートを削除します。

    ```
    helm delete --purge vpn
    ```
    {: pre}

7. `config.yaml` ファイルを開き、誤った値を修正します。

8. 更新した `config.yaml` ファイルを保存します。

9. 更新した `config.yaml` ファイルと共に Helm chart をクラスターにインストールします。 更新したプロパティーが、チャートの構成マップに保管されます。

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

10. Chart のデプロイメント状況を確認します。 Chart の準備ができている場合は、出力の先頭付近の **STATUS** フィールドに `DEPLOYED` の値があります。

    ```
    helm status vpn
    ```
    {: pre}

11. Chart をデプロイし終えたら、`config.yaml` ファイル内の更新済みの設定が使用されたことを確認します。

    ```
    helm get values vpn
    ```
    {: pre}

12. 現在のテスト・ポッドをクリーンアップします。

    ```
    kubectl get pods -a -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -l app=strongswan-test
    ```
    {: pre}

13. テストを再度実行します。

    ```
    helm test vpn
    ```
    {: pre}

<br />


## strongSwan Helm チャートのアップグレード
{: #vpn_upgrade}

strongSwan Helm チャートをアップグレードして最新にします。
{:shortdesc}

strongSwan Helm チャートを最新バージョンにアップグレードするには、次のようにします。

  ```
  helm upgrade -f config.yaml <release_name> ibm/strongswan
  ```
  {: pre}

**重要**: strongSwan 2.0.0 Helm チャートは Calico v3 または Kubernetes 1.10 では機能しません。 [クラスターを 1.10 に更新する](cs_versions.html#cs_v110)前に、Calico 2.6 および Kubernetes 1.8 および 1.9 との後方互換性がある 2.2.0 Helm チャートに strongSwan を更新してください。

クラスターを Kubernetes 1.10 に更新していますか? 必ず strongSwan Helm チャートを最初に削除してください。 更新後に、それを再インストールします。
{:tip}

### バージョン 1.0.0 からのアップグレード
{: #vpn_upgrade_1.0.0}

バージョン 1.0.0 の Helm チャートで使用されている一部の設定のために、`helm upgrade` を使用して 1.0.0 から最新バージョンに更新することができません。
{:shortdesc}

バージョン 1.0.0 からアップグレードするには、以下のように、1.0.0 チャートを削除してから最新バージョンをインストールする必要があります。

1. 1.0.0 Helm chart を削除します。

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. 最新バージョンの strongSwan Helm チャートのデフォルトの構成設定をローカルの YAML ファイルに保存します。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. 構成ファイルを更新し、変更したファイルを保存します。

4. 更新した `config.yaml` ファイルと共に Helm chart をクラスターにインストールします。

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

さらに、1.0.0 でハードコーディングされていたいくつかの `ipsec.conf` タイムアウト設定は、これ以降のバージョンでは構成可能プロパティーとして公開されます。 また、これらの構成可能な `ipsec.conf` タイムアウト設定の中には、strongSwan の標準との一貫性を高めるために名前やデフォルトが変更されたものもあります。 Helm チャートを 1.0.0 からアップグレードする場合に、バージョン 1.0.0 でのタイムアウト設定のデフォルトを維持するには、元のデフォルト値を含むチャート構成ファイルに新しい設定を追加してください。



  <table>
  <caption>バージョン 1.0.0 と最新バージョンの ipsec.conf 設定の違い</caption>
  <thead>
  <th>1.0.0 での設定名</th>
  <th>1.0.0 でのデフォルト</th>
  <th>最新バージョンでの設定名</th>
  <th>最新バージョンでのデフォルト</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ikelifetime</code></td>
  <td>60m</td>
  <td><code>ikelifetime</code></td>
  <td>3h</td>
  </tr>
  <tr>
  <td><code>keylife</code></td>
  <td>20m</td>
  <td><code>lifetime</code></td>
  <td>1h</td>
  </tr>
  <tr>
  <td><code>rekeymargin</code></td>
  <td>3m</td>
  <td><code>margintime</code></td>
  <td>9m</td>
  </tr>
  </tbody></table>


## strongSwan IPSec VPN サービスの無効化
{: vpn_disable}

Helm チャートを削除して、VPN 接続を無効にすることができます。
{:shortdesc}

  ```
  helm delete --purge <release_name>
  ```
  {: pre}

<br />


## Virtual Router Appliance の使用
{: #vyatta}

[Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) は、x86 ベアメタル・サーバーに対応した最新の Vyatta 5600 オペレーティング・システムを提供します。 VRA を VPN ゲートウェイとして使用して、オンプレミス・ネットワークにセキュアに接続できます。
{:shortdesc}

クラスター VLAN に出入りするすべてのパブリックおよびプライベートのネットワーク・トラフィックは、VRA を介して転送されます。 VRA を VPN エンドポイントとして使用して、IBM Cloud インフラストラクチャー (SoftLayer) 内のサーバーとオンプレミス・リソースの間に暗号化された IPSec トンネルを作成できます。 例えば、以下の図は、{{site.data.keyword.containerlong_notm}} 内のプライベート専用ワーカー・ノードにあるアプリがオンプレミス・サーバーと VRA VPN 接続を介して通信する方法を示しています。

<img src="images/cs_vpn_vyatta.png" width="725" alt="ロード・バランサーを使用して {{site.data.keyword.containerlong_notm}} のアプリを公開する" style="width:725px; border-style: none"/>

1. クラスター内のアプリ `myapp2` は、Ingress または LoadBalancer サービスから要求を受け取ると、オンプレミス・ネットワーク内のデータにセキュアに接続する必要があります。

2. `myapp2` はプライベート VLAN にだけ接続したワーカー・ノード上に存在するため、VRA は、ワーカー・ノードとオンプレミス・ネットワークの間のセキュア接続として機能します。 VRA は、宛先 IP アドレスを使用して、オンプレミス・ネットワークに送信するネットワーク・パケットを判別します。

3. 要求は暗号化され、VPN トンネルを介してオンプレミス・データ・センターに送信されます。

4. 着信要求はオンプレミス・ファイアウォールを通過して、VPN トンネル・エンドポイント (ルーター) に送達され、そこで復号されます。

5. VPN トンネル・エンドポイント (ルーター) が、ステップ 2 で指定された宛先 IP アドレスに応じて、オンプレミスのサーバーまたはメインフレームに要求を転送します。同じプロセスにより、必要なデータが VPN 接続を介して `myapp2` に送り返されます。

Virtual Router Appliance をセットアップするには、以下のようにします。

1. [VRA を注文します](/docs/infrastructure/virtual-router-appliance/getting-started.html)。

2. [VRA 上でプライベート VLAN を構成します](/docs/infrastructure/virtual-router-appliance/manage-vlans.html)。

3. VRA を使用して VPN 接続を有効にするには、[VRA 上で VRRP を構成します](/docs/infrastructure/virtual-router-appliance/vrrp.html#high-availability-vpn-with-vrrp)。

**注**: 既存のルーター・アプライアンスがある場合にクラスターを追加すると、クラスター用に注文した新しいポータブル・サブネットは、ルーター・アプライアンス上に構成されません。 ネットワーク・サービスを使用するには、[VLAN スパンニングを有効にして](cs_subnets.html#subnet-routing)、同じ VLAN 上のサブネット間の転送を可能にする必要があります。 VLAN スパンニングが既に有効になっているかどうかを確認するには、`ibmcloud ks vlan-spanning-get` [コマンド](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)を使用します。
