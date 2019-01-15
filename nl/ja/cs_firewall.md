---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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




# ファイアウォールで必要なポートと IP アドレスを開く
{: #firewall}

{{site.data.keyword.containerlong}} のファイアウォールで特定のポートと IP アドレスを開く必要がある以下の状況について説明します。
{:shortdesc}

* [プロキシーまたはファイアウォール経由の公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときに、ローカル・システムから `ibmcloud` コマンドを実行します](#firewall_bx)。
* [プロキシーまたはファイアウォール経由の公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときに、ローカル・システムから `kubectl` コマンドを実行します](#firewall_kubectl)。
* [プロキシーまたはファイアウォール経由の公共のインターネットのエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されているときに、ローカル・システムから `calicoctl` コマンドを実行します](#firewall_calicoctl)。
* [ワーカー・ノードに対してファイアウォールがセットアップされているとき、またはファイアウォール設定が IBM Cloud インフラストラクチャー (SoftLayer) アカウント内でカスタマイズされたときに、Kubernetes マスターとワーカー・ノード間の通信を可能にします](#firewall_outbound)。
* [クラスターがプライベート・ネットワーク上のファイアウォールを介してリソースにアクセスすることを許可します](#firewall_private)。
* [クラスター外から NodePort サービス、ロード・バランサー・サービス、または Ingress へアクセス](#firewall_inbound)します。

<br />


## ファイアウォール保護下での `ibmcloud ks` コマンドの実行
{: #firewall_bx}

ローカル・システムからプロキシーまたはファイアウォール経由での公共のエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されている場合、`ibmcloud ks` コマンドを実行するには、{{site.data.keyword.containerlong_notm}} における TCP アクセスを許可する必要があります。
{:shortdesc}

1. ポート 443 での `containers.bluemix.net` へのアクセスを許可します。
2. 接続を確認します。 アクセスが正しく構成されている場合は、出力に船が表示されます。
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

<br />


## ファイアウォール保護下での `kubectl` コマンドの実行
{: #firewall_kubectl}

ローカル・システムからプロキシーまたはファイアウォール経由での公共のエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されている場合、`kubectl` コマンドを実行するには、クラスターにおける TCP アクセスを許可する必要があります。
{:shortdesc}

クラスターの作成時に、マスター URL 内のポートは 20000 から 32767 の間でランダムに割り当てられます。 作成される可能性のあるすべてのクラスターを対象に 20000 から 32767 までの範囲のポートを開くか、または特定の既存のクラスターを対象にアクセスを許可するかを選択できます。

始めに、[`ibmcloud ks` コマンドを実行](#firewall_bx)するためのアクセスを許可します。

特定のクラスターを対象にアクセスを許可するには、以下のようにします。

1. {{site.data.keyword.Bluemix_notm}} CLI にログインします。 プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。 統合されたアカウントがある場合は、`--sso` オプションを含めます。

   ```
   ibmcloud login [--sso]
   ```
   {: pre}

2. `default` 以外のリソース・グループ内にクラスターがある場合は、そのリソース・グループをターゲットとして設定します。 各クラスターが属するリソース・グループを表示するには、`ibmcloud ks clusters` を実行します。**注**: リソース・グループに対する[**ビューアー**以上の役割](cs_users.html#platform)が必要です。
   ```
   ibmcloud target -g <resource_group_name>
   ```
   {: pre}

2. クラスターが属する地域を選択します。

   ```
   ibmcloud ks region-set
   ```
   {: pre}

3. クラスターの名前を取得します。

   ```
   ibmcloud ks clusters
   ```
   {: pre}

4. クラスターの**マスター URL** を取得します。

   ```
   ibmcloud ks cluster-get <cluster_name_or_ID>
   ```
   {: pre}

   出力例:
   ```
   ...
   Master URL:		https://c3.<region>.containers.cloud.ibm.com
   ...
   ```
   {: screen}

5. ポート (例えば、前の例のポート `31142`) での**マスター URL** へのアクセスを許可します。

6. 接続を確認します。

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   コマンド例:
   ```
   curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
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

<br />


## ファイアウォール保護下での `calicoctl` コマンドの実行
{: #firewall_calicoctl}

ローカル・システムからプロキシーまたはファイアウォール経由での公共のエンドポイントへのアクセスが企業ネットワーク・ポリシーによって禁止されている場合、`calicoctl` コマンドを実行するには、Calico コマンドにおける TCP アクセスを許可する必要があります。
{:shortdesc}

始めに、[`ibmcloud` コマンド](#firewall_bx)と [`kubectl` コマンド](#firewall_kubectl)を実行するためのアクセスを許可します。

1. [`kubectl` コマンド](#firewall_kubectl)の許可に使用したマスター URL から IP アドレスを取得します。

2. ETCD のポートを取得します。

  ```
  kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
  ```
  {: pre}

3. マスター URL の IP アドレスと ETCD ポート経由の Calico ポリシーにおけるアクセスを許可します。

<br />


## クラスターからインフラストラクチャー・リソースや他のサービスへのアクセスの許可
{: #firewall_outbound}

{{site.data.keyword.containerlong_notm}} 地域、{{site.data.keyword.registrylong_notm}}、{{site.data.keyword.monitoringlong_notm}}、{{site.data.keyword.loganalysislong_notm}}、IBM Cloud インフラストラクチャー (SoftLayer) プライベート IP、永続ボリューム請求の発信 (egress) などのために、クラスターがインフラストラクチャーのリソースとサービスにファイアウォールの背後からアクセスできるようにします。
{:shortdesc}

1.  クラスター内のすべてのワーカー・ノードのパブリック IP アドレスをメモします。

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

2.  ソースの _<each_worker_node_publicIP>_ から、宛先の TCP/UDP ポート (20000 から 32767 までの範囲とポート 443) への発信ネットワーク・トラフィックと、以下の IP アドレスとネットワーク・グループへの発信ネットワーク・トラフィックを許可します。 ローカル・マシンから公共のインターネットのエンドポイントへのアクセスが企業ファイアウォールによって禁止されている場合は、ソースのワーカー・ノードとローカル・マシンの両方で以下のステップを実行します。

    ブートストラッピング・プロセスの際にロードのバランスを取るため、地域内のすべてのゾーンのために、ポート 443 への発信トラフィックを許可する必要があります。 例えば、クラスターが米国南部にある場合、各ワーカー・ノードのパブリック IP からすべてのゾーンの IP アドレスのポート 443 へのトラフィックを許可する必要があります。
    {: important}

    <table summary="表の 1 行目は両方の列にまたがっています。残りの行は左から右に読みます。1 列目はサーバー・ゾーン、2 列目は対応する IP アドレスです。">
    <caption>発信トラフィック用に開く IP アドレス</caption>
        <thead>
        <th>地域</th>
        <th>ゾーン</th>
        <th>IP アドレス</th>
        </thead>
      <tbody>
        <tr>
          <td>北アジア太平洋地域</td>
          <td>che01<br>hkg02<br>seo01<br>sng01<br>tok02、tok04、tok05</td>
          <td><code>169.38.70.10</code><br><code>169.56.132.234</code><br><code>169.56.69.242</code><br><code>161.202.186.226</code><br><code>161.202.126.210、128.168.71.117、165.192.69.69</code></td>
         </tr>
        <tr>
           <td>南アジア太平洋地域</td>
           <td>mel01<br>syd01、syd04</td>
           <td><code>168.1.97.67</code><br><code>168.1.8.195、130.198.66.26、168.1.12.98、130.198.64.19</code></td>
        </tr>
        <tr>
           <td>中欧</td>
           <td>ams03<br>mil01<br>osl01<br>par01<br>fra02、fra04、fra05</td>
           <td><code>169.50.169.110, 169.50.154.194</code><br><code>159.122.190.98, 159.122.141.69</code><br><code>169.51.73.50</code><br><code>159.8.86.149、159.8.98.170</code><br><code>169.50.56.174、161.156.65.42、149.81.78.114</code></td>
          </tr>
        <tr>
          <td>英国南部</td>
          <td>lon02、lon04、lon05、lon06</td>
          <td><code>159.122.242.78、158.175.111.42、158.176.94.26、159.122.224.242、158.175.65.170、158.176.95.146</code></td>
        </tr>
        <tr>
          <td>米国東部</td>
           <td>mon01<br>tor01<br>wdc04、wdc06、wdc07</td>
           <td><code>169.54.126.219</code><br><code>169.53.167.50</code><br><code>169.63.88.186、169.60.73.142、169.61.109.34、169.63.88.178、169.60.101.42、169.61.83.62</code></td>
        </tr>
        <tr>
          <td>米国南部</td>
          <td>hou02<br>sao01<br>sjc03<br>sjc04<br>dal10、dal12、dal13</td>
          <td><code>184.173.44.62</code><br><code>169.57.151.10</code><br><code>169.45.67.210</code><br><code>169.62.82.197</code><br><code>169.46.7.238、169.48.230.146、169.61.29.194、169.46.110.218、169.47.70.10、169.62.166.98、169.48.143.218、169.61.177.2、169.60.128.2</code></td>
        </tr>
        </tbody>
      </table>

3.  ワーカー・ノードから [{{site.data.keyword.registrylong_notm}} 地域](/docs/services/Registry/registry_overview.html#registry_regions)への発信ネットワーク・トラフィックを許可します。
    - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
    - <em>&lt;registry_publicIP&gt;</em> を、トラフィックを許可するレジストリー IP アドレスに置き換えます。 グローバル・レジストリーには IBM 提供のパブリック・イメージが保管され、地域レジストリーにはユーザー独自のプライベートまたはパブリック・イメージが保管されます。
      <p>
<table summary="表の 1 行目は両方の列にまたがっています。残りの行は左から右に読みます。1 列目はサーバー・ゾーン、2 列目は対応する IP アドレスです。">
  <caption>レジストリー・トラフィック用に開く IP アドレス</caption>
      <thead>
        <th>{{site.data.keyword.containerlong_notm}} 地域</th>
        <th>レジストリー・アドレス</th>
        <th>レジストリー IP アドレス</th>
      </thead>
      <tbody>
        <tr>
          <td>{{site.data.keyword.containerlong_notm}} 地域間のグローバル・レジストリー</td>
          <td>registry.bluemix.net</td>
          <td><code>169.60.72.144/28</code></br><code>169.61.76.176/28</code></br><code>169.62.37.240/29</code></br><code>169.60.98.80/29</code></br><code>169.63.104.232/29></code></td>
        </tr>
        <tr>
          <td>北アジア太平洋地域、南アジア太平洋地域</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></br><code>168.1.1.240/29</code></br><code>130.198.88.128/29</code></td>
        </tr>
        <tr>
          <td>中欧</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></br><code>169.50.58.104/29</code></br><code>161.156.93.16/29</code></br><code>149.81.79.152/29</code></td>
         </tr>
         <tr>
          <td>英国南部</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></br><code>158.175.97.184/29</code></br><code>158.176.105.64/29</code></br><code>141.125.71.136/29</code></td>
         </tr>
         <tr>
          <td>米国東部、米国南部</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></br><code>169.61.234.224/29</code></br><code>169.61.135.160/29</code></br><code>169.61.46.80/29</code></td>
         </tr>
        </tbody>
      </table>
</p>

4.  オプション: ワーカー・ノードから {{site.data.keyword.monitoringlong_notm}}、{{site.data.keyword.loganalysislong_notm}}、および LogDNA サービスへの発信ネットワーク・トラフィックを許可します。
    *   **{{site.data.keyword.monitoringlong_notm}}**:
        <pre class="screen">TCP port 443, port 9095 FROM &lt;each_worker_node_public_IP&gt; TO &lt;monitoring_public_IP&gt;</pre>
        <em>&lt;monitoring_public_IP&gt;</em> は、トラフィックを許可するモニタリング地域のすべてのアドレスに置き換えます。
        <p><table summary="表の 1 行目は両方の列にまたがっています。残りの行は左から右に読みます。1 列目はサーバー・ゾーン、2 列目は対応する IP アドレスです。">
  <caption>モニター・トラフィック用に開く IP アドレス</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}} 地域</th>
        <th>モニタリング・アドレス</th>
        <th>モニタリング IP アドレス</th>
        </thead>
      <tbody>
        <tr>
         <td>中欧</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>英国南部</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>米国東部、米国南部、北アジア太平洋地域、南アジア太平洋地域</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
    *   **{{site.data.keyword.loganalysislong_notm}}**:
        <pre class="screen">TCP port 443, port 9091 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logging_public_IP&gt;</pre>
        <em>&lt;logging_public_IP&gt;</em> は、トラフィックを許可するロギング地域のすべてのアドレスに置き換えます。
        <p><table summary="表の 1 行目は両方の列にまたがっています。残りの行は左から右に読みます。1 列目はサーバー・ゾーン、2 列目は対応する IP アドレスです。">
<caption>ロギング・トラフィック用に開く IP アドレス</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}} 地域</th>
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
           <td>英国南部</td>
           <td>ingest.logging.eu-gb.bluemix.net</td>
           <td><code>169.50.115.113</code></td>
          </tr>
          <tr>
           <td>中欧</td>
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
    *   **{{site.data.keyword.la_full_notm}}**:
        <pre class="screen">TCP port 443, port 80 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logDNA_public_IP&gt;</pre>
        `<logDNA_public_IP>` は [LogDNA IP アドレス](/docs/services/Log-Analysis-with-LogDNA/network.html#ips)に置き換えます。

5. ロード・バランサー・サービスを使用している場合は、VRRP プロトコルを使用するすべてのトラフィックが、パブリック・インターフェースおよびプライベート・インターフェースでのワーカー・ノード間で許可されることを確認します。 {{site.data.keyword.containerlong_notm}} では、パブリック・ロード・バランサーおよびプライベート・ロード・バランサーの IP アドレスを管理するために VRRP プロトコルが使用されます。

6. {: #pvc}データ・ストレージの永続ボリューム請求を作成するには、ファイアウォールを介した IBM Cloud インフラストラクチャー (SoftLayer) への発信アクセスを許可します。
    - プロビジョニング要求を開始できるように、IBM Cloud インフラストラクチャー (SoftLayer) API エンドポイントへのアクセスを許可します (`TCP port 443 FROM <each_worker_node_public_IP> TO 66.228.119.120`)。
    - [**フロントエンド (パブリック) ネットワーク**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#frontend-public-network)と[**バックエンド (プライベート) ネットワーク**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network)の両方について、クラスターがあるゾーンの IBM Cloud インフラストラクチャー (SoftLayer) IP 範囲へのアクセスを許可します。クラスターのゾーンを確認するには、`ibmcloud ks clusters` を実行します。

<br />


## クラスターからのプライベート・ファイアウォールを介したリソースへのアクセスの許可
{: #firewall_private}

プライベート・ネットワーク上のファイアウォールがある場合、ワーカー・ノード間の通信を許可し、クラスターがプライベート・ネットワークを介してインフラストラクチャー・リソースにアクセスできるようにします。
{:shortdesc}

1. ワーカー・ノード間のすべてのトラフィックを許可します。
    1. パブリック・インターフェースとプライベート・インターフェース上のワーカー・ノード間の TCP、UDP、VRRP、IPEncap トラフィックをすべて許可します。 {{site.data.keyword.containerlong_notm}} では、プライベート・ロード・バランサーの IP アドレスを管理するために VRRP プロトコルが使用され、サブネットをまたぐポッド間トラフィックを許可するために IPEncap プロトコルが使用されます。
    2. Calico ポリシーを使用している場合や、複数ゾーン・クラスターの各ゾーンにファイアウォールがある場合は、ファイアウォールによってワーカー・ノード間の通信がブロックされることがあります。 ワーカーのポート、ワーカーのプライベート IP アドレス、または Calico ワーカー・ノード・ラベルを使用して、クラスター内のすべてのワーカー・ノードを相互に開く必要があります。

2. IBM Cloud インフラストラクチャー (SoftLayer) のプライベート IP の範囲を許可して、クラスター内にワーカー・ノードを作成できるようにします。
    1. IBM Cloud インフラストラクチャー (SoftLayer) のプライベート IP のために適切な範囲を許可します。 [Backend (private) Network](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network) を参照してください。
    2. 使用しているすべての[ゾーン](cs_regions.html#zones)のために IBM Cloud インフラストラクチャー (SoftLayer) のプライベート IP の範囲を許可します。 `dal01` ゾーンおよび `wdc04` ゾーンの IP を追加する必要があることに注意してください。 [Service Network (on backend/private network)](/docs/infrastructure/hardware-firewall-dedicated/ips.html#service-network-on-backend-private-network-) を参照してください。

3. 以下のポートを開きます。
    - ワーカー・ノードの更新および再ロードを許可するために、ワーカーからポート 80 および 443 へのアウトバウンド TCP および UDP 接続を許可します。
    - ボリュームとしてファイル・ストレージのマウントを許可するために、ポート 2049 へのアウトバウンド TCP および UDP を許可します。
    - ブロック・ストレージに対する通信用に、ポート 3260 へのアウトバウンド TCP と UDP を許可します。
    - Kubernetes ダッシュボードおよび `kubectl logs` や `kubectl exec` などのコマンドのために、ポート 10250 へのインバウンド TCP および UDP 接続を許可します。
    - DNS アクセスのために、TCP および UDP のポート 53 へのインバウンドおよびアウトバウンドの接続を許可します。

4. パブリック・ネットワークにもファイアウォールがある場合、またはプライベート VLAN 専用クラスターがあり、ファイアウォールとしてゲートウェイ・アプライアンスを使用している場合、[クラスターからインフラストラクチャー・リソースや他のサービスへのアクセスの許可](#firewall_outbound)で指定した IP およびポートも許可する必要があります。

<br />


## クラスター外から NodePort、ロード・バランサー、Ingress の各サービスへのアクセス
{: #firewall_inbound}

NodePort、ロード・バランサー、Ingress の各サービスへの着信アクセスを許可できます。
{:shortdesc}

<dl>
  <dt>NodePort サービス</dt>
  <dd>トラフィックを許可するすべてのワーカー・ノードのパブリック IP アドレスへのサービスのデプロイ時に構成したポートを開きます。 ポートを見つけるには、`kubectl get svc` を実行します。 ポートの範囲は 20000 から 32000 までです。<dd>
  <dt>ロード・バランサー・サービス</dt>
  <dd>ロード・バランサー・サービスのパブリック IP アドレスへのサービスのデプロイ時に構成したポートを開きます。</dd>
  <dt>Ingress</dt>
  <dd>Ingress アプリケーション・ロード・バランサーの IP アドレスへのポート 80 (HTTP の場合) またはポート 443 (HTTPS の場合) を開きます。</dd>
</dl>
