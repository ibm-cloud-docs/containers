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

# VPN 接続のセットアップ
{: #vpn}

VPN 接続を使用すると、Kubernetes クラスター内のアプリをオンプレミス・ネットワークにセキュアに接続できます。 クラスター外のアプリを、クラスター内で実行中のアプリに接続することもできます。
{:shortdesc}

## Strongswan IPSec VPN サービスの Helm Chart を使用した VPN 接続のセットアップ
{: #vpn-setup}

VPN 接続をセットアップするには、Helm Chart を使用して、Kubernetes ポッド内で [Strongswan IPSec VPN サービス ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.strongswan.org/) を構成してデプロイします。 その後すべての VPN トラフィックはこのポッドを介してルーティングされます。 Strongswan Chart のセットアップに使用する Helm コマンドについて詳しくは、<a href="https://docs.helm.sh/helm/" target="_blank">Helm の資料 <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> を参照してください。
{:shortdesc}

開始前に、以下のことを行います。

- [標準クラスターを作成します。](cs_clusters.html#clusters_cli)
- [既存のクラスターを使用している場合は、バージョン 1.7.4 以降に更新します。](cs_cluster_update.html#master)
- クラスターに 1 つ以上の使用可能なパブリック・ロード・バランサー IP アドレスがなければなりません。
- [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。

Strongswan との VPN 接続をセットアップするには、以下のようにします。

1. クラスターで Helm がまだ有効になっていない場合は、インストールして初期化します。

    1. <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">Helm CLI <img src="../icons/launch-glyph.svg" alt="外部リンク・アイコン"></a> をインストールします。

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

3. `config.yaml` ファイルを開き、ご希望の VPN 構成に従ってデフォルト値に以下の変更を加えます。 プロパティーに選択可能な特定の値がある場合は、このファイル内の各プロパティーの上のコメントにそれらの値がリストされます。**重要**: プロパティーを変更する必要がない場合は、そのプロパティーの前に `#` を付けてコメント化してください。

    <table>
    <caption>YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>既存の <code>ipsec.conf</code> ファイルを使用する場合は、中括弧 (<code>{}</code>) を削除し、このプロパティーの後にこのファイルの内容を追加します。 ファイル内容は字下げする必要があります。 **注:** 独自のファイルを使用する場合は、<code>ipsec</code>、<code>local</code>、<code>remote</code> セクションの値は使用しません。</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>既存の <code>ipsec.secrets</code> ファイルを使用する場合は、中括弧 (<code>{}</code>) を削除し、このプロパティーの後にこのファイルの内容を追加します。 ファイル内容は字下げする必要があります。 **注:** 独自のファイルを使用する場合は、<code>preshared</code> セクションの値は使用しません。</td>
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
    <td>この値を、オンプレミス・ネットワークへの VPN 接続を介して公開する必要があるクラスター・サブネット CIDR のリストに変更します。 以下のサブネットをこのリストに含めることができます。 <ul><li>Kubernetes ポッドのサブネット CIDR: <code>172.30.0.0/16</code></li><li>Kubernetes サービスのサブネット CIDR: <code>172.21.0.0/16</code></li><li>プライベート・ネットワーク上で NodePort サービスによって公開されるアプリケーションがある場合は、ワーカー・ノードのプライベート・サブネット CIDR。 この値を見つけるには、<code>bx cs subnets | grep <xxx.yyy.zzz></code> を実行します。&lt;xxx.yyy.zzz&gt; はワーカー・ノードのプライベート IP アドレスの最初の 3 つのオクテットです。</li><li>プライベート・ネットワーク上で LoadBalancer サービスによって公開されるアプリケーションがある場合は、クラスターのプライベートまたはユーザー管理サブネット CIDR。 これらの値を見つけるには、<code>bx cs cluster-get <cluster name> --showResources</code> を実行します。 <b>VLANS</b> セクションで、<b>Public</b> 値が <code>false</code> の CIDR を見つけます。</li></ul></td>
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

5. 更新した `config.yaml` ファイルと共に Helm Chart をクラスターにインストールします。 更新したプロパティーが、Chart の構成マップに保管されます。

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
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
          - この Helm Chart を初めて使用する際には、ほとんどの場合、VPN の状況は `ESTABLISHED` ではありません。 接続が成功するまでに、オンプレミス VPN エンドポイントの設定を確認し、ステップ 3 に戻って、`config.yaml` ファイルを複数回変更する必要が生じる可能性があります。
          - VPN ポッドが `ERROR` 状態か、クラッシュと再始動が続く場合は、Chart の構成マップ内の `ipsec.conf` 設定のパラメーター妥当性検査が原因の可能性があります。 これが原因か調べるには、`kubectl logs -n kube-system $STRONGSWAN_POD` を実行して、Strongswan ポッドのログに妥当性検査エラーがあるかを確認してください。 妥当性検査エラーがある場合、`helm delete --purge vpn` を実行し、ステップ 3 に戻って、`config.yaml` ファイル内の誤った値を修正し、ステップ 4 から 8 を繰り返します。クラスターに多数のワーカー・ノードがある場合は、`helm delete` と `helm install` を実行するより `helm upgrade` を使用する方が変更を迅速に適用できます。

    4. VPN の状況が `ESTABLISHED` になったら、`ping` を使用して接続をテストします。 以下の例は、Kubernetes クラスター内の VPN ポッドからオンプレミス VPN ゲートウェイのプライベート IP アドレスに ping を送信します。 構成ファイル内で正しい `remote.subnet` と `local.subnet` が指定されていることと、ローカル・サブネット・リストに ping の送信元のソース IP アドレスが含まれていることを確認します。

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### Strongswan IPSec VPN サービスの無効化
{: vpn_disable}

1. Helm Chart を削除します。

    ```
    helm delete --purge vpn
    ```
    {: pre}
