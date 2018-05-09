---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

VPN 接続を使用すると、{{site.data.keyword.containerlong}} 上の Kubernetes クラスター内のアプリをオンプレミス・ネットワークにセキュアに接続できます。クラスター外のアプリを、クラスター内で実行中のアプリに接続することもできます。
{:shortdesc}

ワーカー・ノードとアプリをオンプレミス・データ・センターに接続するには、strongSwan サービス、Vyatta Gateway Appliance、または Fortigate Appliance を使用して VPN IPSec エンドポイントを構成できます。

- **strongSwan IPSec VPN サービス**: Kubernetes クラスターをオンプレミス・ネットワークとセキュアに接続する [strongSwan IPSec VPN サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.strongswan.org/) をセットアップできます。 strongSwan IPSec VPN サービスは、業界標準の Internet Protocol Security (IPsec) プロトコル・スイートに基づき、インターネット上にセキュアなエンドツーエンドの通信チャネルを確立します。 クラスターとオンプレミス・ネットワークの間にセキュア接続をセットアップするには、オンプレミス・データ・センターに IPsec VPN ゲートウェイをインストールする必要があります。その後、Kubernetes ポッドで [strongSwan IPSec VPN サービスの構成とデプロイ](#vpn-setup)を行うことができます。

- **Vyatta Gateway Appliance または Fortigate Appliance**: クラスターが比較的大きい場合、VPN を使用して非 Kubernetes リソースにアクセスする場合、または 1 つの VPN で複数のクラスターにアクセスする場合は、Vyatta Gateway Appliance または Fortigate Appliance をセットアップして IPSec VPN エンドポイントを構成できます。詳しくは、この[オンプレミス・データ・センターへのクラスターの接続 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) に関するブログ投稿を参照してください。

## strongSwan IPSec VPN サービスの Helm Chart を使用した VPN 接続のセットアップ
{: #vpn-setup}

Helm チャートを使用して、Kubernetes ポッド内に strongSwan IPSec VPN サービスを構成してデプロイします。その後すべての VPN トラフィックはこのポッドを介してルーティングされます。
{:shortdesc}

strongSwan Chart のセットアップに使用する Helm コマンドについて詳しくは、<a href="https://docs.helm.sh/helm/" target="_blank">Helm の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。


### strongSwan Helm chart を構成します。
{: #vpn_configure}

開始前に、以下のことを行います。
* オンプレミス・データ・センターに IPsec VPN ゲートウェイをインストールする必要があります。
* [標準クラスターを作成する](cs_clusters.html#clusters_cli)か、または[既存のクラスターをバージョン 1.7.4 以降に更新します](cs_cluster_update.html#master)。
* クラスターに 1 つ以上の使用可能なパブリック・ロード・バランサー IP アドレスがなければなりません。 [使用可能なパブリック IP アドレスを確認](cs_subnets.html#manage)したり、[使用されている IP アドレスを解放](cs_subnets.html#free)したりすることができます。
* [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。

Helm chart を構成するには、以下のようにします。

1. [クラスター用の Helm をインストールし、Helm インスタンスに {{site.data.keyword.Bluemix_notm}} リポジトリーを追加します](cs_integrations.html#helm)。

2. ローカル YAML ファイル内に strongSwan Helm chart のデフォルトの構成設定を保存します。

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. `config.yaml` ファイルを開き、ご希望の VPN 構成に従ってデフォルト値に以下の変更を加えます。 この構成ファイルのコメントに、詳細設定についての説明があります。

    **重要**: プロパティーを変更する必要がない場合は、そのプロパティーの前に `#` を付けてコメント化してください。

    <table>
    <col width="22%">
    <col width="78%">
    <caption>YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>localSubnetNAT</code></td>
    <td>サブネットのネットワーク・アドレス変換 (NAT) は、ローカル・ネットワークとオンプレミス・ネットワークの間のサブネット競合の回避策になります。NAT を使用して、クラスターのプライベート・ローカル IP サブネット、ポッド・サブネット (172.30.0.0/16)、またはポッド・サービス・サブネット (172.21.0.0/16) を、異なるプライベート・サブネットに再マップすることができます。VPN トンネルでは、元のサブネットではなく、再マップされた IP サブネットが認識されます。再マッピングは、VPN トンネルを介してパケットが送信される前だけでなく、VPN トンネルからパケットが到着した後も行われます。再マップされたサブネットと再マップされていないサブネットの両方を同時に VPN を介して公開できます。<br><br>NAT を有効にするには、サブネット全体を追加するか、個々の IP アドレスを追加します。サブネット全体を追加する場合 (<code>10.171.42.0/24=10.10.10.0/24</code> の形式)、再マッピングは 1 対 1 になります。つまり、内部ネットワーク・サブネット内のすべての IP アドレスが外部ネットワーク・サブネットにマップされます。その逆も同様です。個々の IP アドレスを追加する場合 (<code>10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32</code> の形式)、それらの内部 IP アドレスのみが、指定した外部 IP アドレスにマップされます。<br><br>このオプションを使用した場合、VPN 接続を介して公開されるローカル・サブネットは、「内部」サブネットがマップされている「外部」サブネットになります。
</td>
    </tr>
    <tr>
    <td><code>loadBalancerIP</code></td>
    <td>このクラスターに割り当てられているサブネットにあるポータブル・パブリック IP アドレスで、strongSwan VPN サービスに使用するものを追加します。オンプレミス・ゲートウェイから VPN 接続を開始する (<code>ipsec.auto</code> を <code>add</code> に設定した) 場合は、このプロパティーを使用して、クラスターにオンプレミス・ゲートウェイの永続パブリック IP アドレスを構成できます。この値はオプションです。</td>
    </tr>
    <tr>
    <td><code>nodeSelector</code></td>
    <td>strongSwan VPN ポッドのデプロイ先のノードを制限する場合に、特定のワーカー・ノードの IP アドレスまたはワーカー・ノードのラベルを追加します。例えば、<code>kubernetes.io/hostname: 10.184.110.141</code> という値を指定すると、そのワーカー・ノードでのみ実行するように VPN ポッドを制限できます。<code>strongswan: vpn</code> という値を指定すると、そのラベルのワーカー・ノードで実行するように VPN ポッドを制限できます。任意のワーカー・ノード・ラベルを使用できますが、このチャートのデプロイメントごとに別のワーカー・ノードを使用できるように <code>strongswan: &lt;release_name&gt;</code> を使用することをお勧めします。<br><br>クラスターから VPN 接続を開始する (<code>ipsec.auto</code> を <code>start</code> に設定した) 場合は、このプロパティーを使用して、オンプレミス・ゲートウェイに公開される VPN 接続のソース IP アドレスを制限できます。この値はオプションです。</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>オンプレミスの VPN トンネル・エンドポイントが、接続を初期化する際のプロトコルとして <code>ikev2</code> をサポートしていない場合は、この値を <code>ikev1</code> または <code>ike</code> に変更します。</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>オンプレミスの VPN トンネル・エンドポイントで接続に使用される ESP 暗号化/認証アルゴリズムのリストを追加します。 この値はオプションです。 このフィールドをブランクにしておくと、デフォルトの strongSwan アルゴリズム <code>aes128-sha1,3des-sha1</code> が接続に使用されます。</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>オンプレミスの VPN トンネル・エンドポイントで接続に使用される IKE/ISAKMP SA 暗号化/認証アルゴリズムのリストを追加します。 この値はオプションです。 このフィールドをブランクにしておくと、デフォルトの strongSwan アルゴリズム <code>aes128-sha1-modp2048,3des-sha1-modp1536</code> が接続に使用されます。</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>クラスターに VPN 接続を開始させる場合は、この値を <code>start</code> に変更します。</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>この値を、VPN 接続を介してオンプレミス・ネットワークに公開するクラスター・サブネット CIDR のリストに変更します。 以下のサブネットをこのリストに含めることができます。 <ul><li>Kubernetes ポッドのサブネット CIDR: <code>172.30.0.0/16</code></li><li>Kubernetes サービスのサブネット CIDR: <code>172.21.0.0/16</code></li><li>アプリをプライベート・ネットワークで NodePort サービスを使用して公開する場合は、ワーカー・ノードのプライベート・サブネット CIDR。 この値を見つけるには、<code>bx cs subnets | grep <xxx.yyy.zzz></code> を実行します。<code>&lt;xxx.yyy.zzz&gt;</code> はワーカー・ノードのプライベート IP アドレスの最初の 3 つのオクテットです。</li><li>プライベート・ネットワーク上で LoadBalancer サービスによって公開されるアプリがある場合は、クラスターのプライベートまたはユーザー管理サブネット CIDR。 これらの値を見つけるには、<code>bx cs cluster-get <cluster name> --showResources</code> を実行します。 <b>VLANS</b> セクションで、<b>Public</b> 値が <code>false</code> の CIDR を見つけます。</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>この値を、VPN トンネル・エンドポイントで接続に使用される、ローカル Kubernetes クラスター側のストリング ID に変更します。</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>この値を、オンプレミス VPN ゲートウェイのパブリック IP アドレスに変更します。 <code>ipsec.auto</code> を <code>start</code> に設定する場合は、この値が必須です。</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>この値を、Kubernetes クラスターからアクセスできるオンプレミスのプライベート・サブネット CIDR のリストに変更します。</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>この値を、VPN トンネル・エンドポイントで接続に使用される、リモートのオンプレミス側のストリング ID に変更します。</td>
    </tr>
    <tr>
    <td><code>remote.privateIPtoPing</code></td>
    <td>Helm テスト検証プログラムで VPN ping 接続テストに使用するリモート・サブネット内のプライベート IP アドレスを追加します。この値はオプションです。</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>この値を、オンプレミスの VPN トンネル・エンドポイント・ゲートウェイで接続に使用される事前共有シークレットに変更します。 この値は <code>ipsec.secrets</code> に保管されます。</td>
    </tr>
    </tbody></table>

4. 更新した `config.yaml` ファイルを保存します。

5. 更新した `config.yaml` ファイルと共に Helm chart をクラスターにインストールします。 更新したプロパティーが、チャートの構成マップに保管されます。

    **注**: 単一のクラスター内に複数の VPN デプロイメントがある場合は、`vpn` よりもわかりやすいリリース名を選択して、名前の競合を回避し、デプロイメントを区別できます。切り捨てられないように、リリース名は 35 文字以下に制限してください。

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn ibm/strongswan
    ```
    {: pre}

6. Chart のデプロイメント状況を確認します。 Chart の準備ができている場合は、出力の先頭付近の **STATUS** フィールドに `DEPLOYED` の値があります。

    ```
    helm status vpn
    ```
    {: pre}

7. Chart をデプロイし終えたら、`config.yaml` ファイル内の更新済みの設定が使用されたことを確認します。

    ```
    helm get values vpn
    ```
    {: pre}


### VPN 接続のテストと検証
{: #vpn_test}

Helm チャートをデプロイしたら、VPN 接続をテストします。
{:shortdesc}

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
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
    ```
    {: screen}

    **注:**

    <ul>
    <li>strongSwan Helm チャートを使用して VPN 接続を確立しようとしても、最初は VPN の状況が `ESTABLISHED` にならない可能性があります。オンプレミスの VPN エンドポイント設定を確認して構成ファイルを何度か変更しないと、接続できない可能性があります。<ol><li>`helm delete --purge <release_name>` を実行します。</li><li>構成ファイル内の誤った値を修正します。</li><li>`helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan` を実行します。</li></ol>次の手順でさらに検査することもできます。</li>
    <li>VPN ポッドが `ERROR` 状態である場合や、クラッシュと再始動が繰り返される場合は、チャートの構成マップ内の `ipsec.conf` 設定のパラメーターの検証が原因である可能性があります。 <ol><li>`kubectl logs -n kube-system $STRONGSWAN_POD` を実行して、strongSwan ポッドのログに検証エラーがないか確認してください。</li><li>検証エラーがある場合は、`helm delete --purge <release_name>` を実行します。<li>構成ファイル内の誤った値を修正します。</li><li>`helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan` を実行します。</li></ol>クラスターに多数のワーカー・ノードがある場合は、`helm delete` と `helm install` を実行するより `helm upgrade` を使用する方が変更を迅速に適用できます。</li>
    </ul>

4. strongSwan チャートの定義に含まれている 5 つの Helm テストを実行して、VPN 接続をさらにテストできます。

    ```
    helm test vpn
    ```
    {: pre}

    * すべてのテストに合格したら、strongSwan VPN 接続は正常にセットアップされています。

    * いずれかのテストが失敗した場合は、次の手順に進みます。

5. テスト・ポッドのログを参照して、失敗したテストの出力を確認します。

    ```
    kubectl logs -n kube-system <test_program>
    ```
    {: pre}

    **注**: テストの中には、VPN 構成ではオプションの設定を必要とするテストがあります。一部のテストが失敗しても、そのようなオプションの設定を指定したかどうかによっては、失敗を許容できる場合があります。各テストと、テストが失敗する原因として想定される原因について詳しくは、次の表を参照してください。

    {: #vpn_tests_table}
    <table>
    <caption>Helm VPN 接続テストについて</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Helm VPN 接続テストについて</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td><code>config.yaml</code> ファイルから生成された <code>ipsec.conf</code> ファイルの構文を検証します。このテストは、<code>config.yaml</code> ファイル内に正しくない値があると失敗する可能性があります。</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>VPN 接続の状況が <code>ESTABLISHED</code> であることを確認します。 このテストは、以下の理由で失敗する可能性があります。<ul><li><code>config.yaml</code> ファイルの値とオンプレミス VPN エンドポイントの設定値が違っている。</li><li>クラスターが「listen」モードである (<code>ipsec.auto</code> を <code>add</code> に設定した) 場合、オンプレミス側では接続は確立されない。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td><code>config.yaml</code> ファイルに構成した <code>remote.gateway</code> パブリック IP アドレスを ping します。このテストは、以下の理由で失敗する可能性があります。<ul><li>オンプレミス VPN ゲートウェイの IP アドレスを指定していない。<code>ipsec.auto</code> を <code>start</code> に設定する場合は、<code>remote.gateway</code> IP アドレスが必要です。</li><li>VPN 接続の状況が <code>ESTABLISHED</code> ではない。詳しくは、<code>vpn-strongswan-check-state</code> を参照してください。</li><li>VPN 接続は <code>ESTABLISHED</code> であるが、ファイアウォールによって ICMP パケットがブロックされている。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>クラスター内の VPN ポッドから、オンプレミス VPN ゲートウェイの <code>remote.privateIPtoPing</code> プライベート IP アドレスを ping します。このテストは、以下の理由で失敗する可能性があります。<ul><li><code>remote.privateIPtoPing</code> IP アドレスを指定していない。意図的に IP アドレスを指定していないのであれば、この失敗は許容できます。</li><li><code>local.subnet</code> リストにクラスター・ポッドのサブネット CIDR の <code>172.30.0.0/16</code> を指定していない。</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>クラスター内のワーカー・ノードから、オンプレミス VPN ゲートウェイの <code>remote.privateIPtoPing</code> プライベート IP アドレスを ping します。このテストは、以下の理由で失敗する可能性があります。<ul><li><code>remote.privateIPtoPing</code> IP アドレスを指定していない。意図的に IP アドレスを指定していないのであれば、この失敗は許容できます。</li><li><code>local.subnet</code> リストにクラスター・ワーカー・ノードのプライベート・サブネット CIDR を指定していない。</li></ul></td>
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
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
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
    kubectl get pods -a -n kube-system -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -n kube-system -l app=strongswan-test
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
  helm upgrade -f config.yaml --namespace kube-system <release_name> ibm/strongswan
  ```
  {: pre}


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
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

さらに、1.0.0 でハードコーディングされていたいくつかの `ipsec.conf` タイムアウト設定は、これ以降のバージョンでは構成可能プロパティーとして公開されます。また、これらの構成可能な `ipsec.conf` タイムアウト設定の中には、strongSwan の標準との一貫性を高めるために名前やデフォルトが変更されたものもあります。Helm チャートを 1.0.0 からアップグレードする場合に、バージョン 1.0.0 でのタイムアウト設定のデフォルトを維持するには、元のデフォルト値を含むチャート構成ファイルに新しい設定を追加してください。

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

Helm チャートを削除して、VPN 接続を無効にすることができます。{:shortdesc}

  ```
  helm delete --purge <release_name>
  ```
  {: pre}
