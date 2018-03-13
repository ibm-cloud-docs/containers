---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# ネットワーク・ポリシーによるトラフィックの制御
{: #network_policies}

Kubernetes クラスターはそれぞれ、Calico と呼ばれるネットワーク・プラグインを使用してセットアップされます。 各ワーカー・ノードのパブリック・ネットワーク・インターフェースを保護するために、デフォルトのネットワーク・ポリシーがセットアップされます。 固有のセキュリティー要件があるときには、Calico および Kubernetes のネイティブ機能を使用してクラスター用のネットワーク・ポリシーをさらに構成できます。 これらのネットワーク・ポリシーは、クラスター内のポッドを出入りするネットワーク・トラフィックのどれを許可し、どれをブロックするかを指定します。
{: shortdesc}

Calico と Kubernetes のネイティブ機能のいずれかを選んで、ご使用のクラスター用のネットワーク・ポリシーを作成することができます。 手始めには Kubernetes のネットワーク・ポリシーを使用することができますが、より堅牢な機能が必要であれば Calico のネットワーク・ポリシーを使用してください。

<ul>
  <li>[Kubernetes ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): 相互通信できるポッドを指定するなど、いくつかの基本的なオプションが用意されています。 特定のプロトコルとポートにおいて、着信ネットワーク・トラフィックを許可またはブロックできます。 このトラフィックは、他のポッドに接続しようとしているポッドのラベルと Kubernetes 名前空間に基づいて、フィルターに掛けることができます。</br>これらのポリシーは
`kubectl` コマンドまたは Kubernetes API を使用して適用できます。 これらのポリシーが適用されると、Calico ネットワーク・ポリシーに変換され、Calico がこれらのポリシーを実施します。</li>
  <li>[Calico ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): これらのポリシーは Kubernetes ネットワーク・ポリシーのスーパーセットであり、Kubernetes のネイティブ機能に以下の機能を追加して拡張したものです。</li>
    <ul><ul><li>Kubernetes ポッドのトラフィックだけではなく、特定のネットワーク・インターフェース上のネットワーク・トラフィックを許可またはブロックします。</li>
    <li>着信 (ingress) および発信 (egress) ネットワーク・トラフィックを許可またはブロックします。</li>
    <li>[LoadBalancer サービスまたは NodePort Kubernetes サービスへの着信 (ingress) トラフィックをブロックします](#block_ingress)。</li>
    <li>送信元または宛先 IP アドレスまたは CIDR に基づき、トラフィックを許可またはブロックします。</li></ul></ul></br>

これらのポリシーは `calicoctl` コマンドを使用して適用されます。 Calico は Kubernetes ワーカー・ノード上に Linux iptables 規則をセットアップすることによって、これらのポリシーを実施しますが、これには Calico ポリシーに変換された Kubernetes ネットワーク・ポリシーも含まれます。 iptables 規則はワーカー・ノードのファイアウォールとして機能し、ネットワーク・トラフィックがターゲット・リソースに転送されるために満たさなければならない特性を定義します。</ul>

<br />


## デフォルト・ポリシーの構成
{: #default_policy}

クラスターの作成時には、各ワーカー・ノードのパブリック・ネットワーク・インターフェース用のデフォルトのネットワーク・ポリシーが自動的にセットアップされ、パブリック・インターネットからのワーカー・ノードの着信トラフィックを制限します。 これらのポリシーはポッド間のトラフィックには影響せず、Kubernetes の NodePort サービス、LoadBalancer サービス、Ingress サービスへのアクセスを許可するためにセットアップされます。
{:shortdesc}

デフォルト・ポリシーはポッドに直接、適用されるわけではありません。Calico host エンドポイント を使用して、ワーカー・ノードのパブリック・ネットワーク・インターフェースに適用されます。 ホストのエンドポイントが Calico に作成されると、そのワーカー・ノードのネットワーク・インターフェースを出入りするトラフィックは、ポリシーによってそのトラフィックが許可されていない限り、すべてブロックされます。

**重要:** ポリシーを十分に理解していない限り、かつ、ポリシーにより許可されるトラフィックが必要ないと判断できるのでない限り、ホストのエンドポイントに適用されるポリシーを削除しないでください。


 <table summary="表の 1 行目は 2 列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーの場所、2 列目は対応する IP アドレスです。">
 <caption>各クラスターのデフォルト・ポリシー</caption>
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

<br />


## ネットワーク・ポリシーの追加
{: #adding_network_policies}

ほとんどの場合、デフォルト・ポリシーは変更する必要がありません。 拡張シナリオのみ、変更が必要な場合があります。 変更が必要であるとわかった場合は、Calico CLI をインストールし、独自のネットワーク・ポリシーを作成します。
{:shortdesc}

開始前に、以下のことを行います。

1.  [{{site.data.keyword.containershort_notm}} および Kubernetes CLI をインストールします。](cs_cli_install.html#cs_cli_install)
2.  [フリー・クラスターまたは標準クラスターを作成します。](cs_clusters.html#clusters_ui)
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

    4.  ローカル・システムからプロキシーまたはファイアウォールを経由してパブリックなエンドポイントにアクセスすることが企業ネットワーク・ポリシーで禁止されている場合は、[ファイアウォール保護下での `calicoctl` コマンドの実行](cs_firewall.html#firewall)を参照して、Calico コマンドに TCP アクセスを許可する方法を確認してください。

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

    1.  構成スクリプト (.yaml) を作成して、独自の [Calico ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) を定義します。 これらの構成ファイルにはどのポッド、名前空間、またはホストにこれらのポリシーを適用するかを説明するセレクターが含まれます。 独自のポリシーを作成するときには、こちらの[サンプル Calico ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) を参考にしてください。

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

<br />


## LoadBalancer サービスまたは NodePort サービスへの着信トラフィックをブロックします。
{: #block_ingress}

デフォルトで、Kubernetes の `NodePort` サービスと `LoadBalancer` サービスは、パブリックとプライベートのすべてのクラスター・インターフェースでアプリを利用可能にするために設計されています。 ただし、トラフィックのソースや宛先に基づいて、サービスへの着信トラフィックをブロックすることもできます。 トラフィックをブロックするには、Calico `preDNAT` ネットワーク・ポリシーを作成します。
{:shortdesc}

Kubernetes の LoadBalancer サービスは NodePort サービスでもあります。 LoadBalancer サービスにより、ロード・バランサーの IP アドレスとポート上でアプリが利用可能になり、サービスのノード・ポート上でアプリが利用可能になります。 ノード・ポートは、クラスター内のすべてのノードのすべての IP アドレス (パブリックとプライベート) でアクセス可能です。

クラスター管理者は、Calico `preDNAT` ネットワーク・ポリシーを使用して以下のものをブロックできます。

  - NodePort サービスへのトラフィック。 LoadBalancer サービスへのトラフィックは許可されます。
  - ソース・アドレスまたは CIDR に基づくトラフィック。

Calico `preDNAT` ネットワーク・ポリシーのいくつかの一般的な使用方法:

  - プライベート LoadBalancer サービスのパブリック・ノード・ポートへのトラフィックをブロックする。
  - [エッジ・ワーカー・ノード](cs_edge.html#edge)を実行しているクラスター上のパブリック・ノード・ポートへのトラフィックをブロックする。 ノード・ポートをブロックすることにより、エッジ・ワーカー・ノードだけが着信トラフィックを扱うワーカー・ノードとなります。

`preDNAT` ネットワーク・ポリシーは便利なポリシーです。なぜなら、デフォルトの Kubernetes ポリシーと Calico ポリシーでは、保護する Kubernetes の NodePort サービスと LoadBalancer サービスに対して生成された DNAT iptables 規則があるために、それらのサービスに対してポリシーを適用するのが困難であるためです。

Calico `preDNAT` ネットワーク・ポリシーは、[Calico ネットワーク・ポリシー・リソース ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) に基づいて、iptables 規則を生成します。

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
