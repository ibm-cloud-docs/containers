---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

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

Kubernetes クラスターはそれぞれ、Calico と呼ばれるネットワーク・プラグインを使用してセットアップされます。 {{site.data.keyword.containerlong}} の各ワーカー・ノードのパブリック・ネットワーク・インターフェースを保護するために、デフォルトのネットワーク・ポリシーがセットアップされます。
{: shortdesc}

固有のセキュリティー要件がある場合、または VLAN スパンニングを有効にした複数ゾーン・クラスターがある場合は、Calico および Kubernetes を使用してクラスターのネットワーク・ポリシーを作成できます。 Kubernetes ネットワーク・ポリシーを使用して、クラスター内のポッドとの間で許可またはブロックするネットワーク・トラフィックを指定できます。 LoadBalancer サービスへのインバウンド (ingress) トラフィックのブロックなど、より高度なネットワーク・ポリシーを設定するには、Calico ネットワーク・ポリシーを使用します。

<ul>
  <li>
  [Kubernetes ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): これらのポリシーは、ポッドが他のポッドおよび外部エンドポイントと通信する方法を指定します。 Kubernetes バージョン 1.8 以降では、着信ネットワーク・トラフィックと発信ネットワーク・トラフィックの両方を、プロトコル、ポート、およびソースまたは宛先 IP アドレスに基づいて許可またはブロックできます。 トラフィックは、ポッドおよび名前空間ラベルに基づいてフィルタリングすることもできます。 Kubernetes ネットワーク・ポリシーは、`kubectl` コマンドまたは Kubernetes API を使用して適用されます。 これらのポリシーは、適用されると自動的に Calico ネットワーク・ポリシーに変換され、Calico によってこれらのポリシーが実施されます。
  </li>
  <li>
  Kubernetes バージョン [1.10 以降のクラスター ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) または [1.9 以前のクラスター ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) 用の Calico ネットワーク・ポリシー: これらのポリシーは Kubernetes ネットワーク・ポリシーのスーパーセットであり、`calicoctl` コマンドを使用して適用されます。 Calico ポリシーは、以下の機能を追加します。
    <ul>
    <li>Kubernetes ポッドのソースまたは宛先 IP アドレスや CIDR に関係なく、特定のネットワーク・インターフェース上のネットワーク・トラフィックを許可またはブロックします。</li>
    <li>複数の名前空間にまたがるポッドのネットワーク・トラフィックを許可またはブロックします。</li>
    <li>[LoadBalancer または NodePort Kubernetes サービスへのインバウンド (ingress) トラフィックをブロックします](#block_ingress)。</li>
    </ul>
  </li>
  </ul>

Calico は、Kubernetes ワーカー・ノードで Linux iptables 規則をセットアップすることにより、Calico ポリシーに自動的に変換される Kubernetes ネットワーク・ポリシーを含め、これらのポリシーを実施します。 iptables 規則はワーカー・ノードのファイアウォールとして機能し、ネットワーク・トラフィックがターゲット・リソースに転送されるために満たさなければならない特性を定義します。

Ingress および LoadBalancer サービスを使用するには、Calico および Kubernetes ポリシーを使用してクラスターの発信/着信ネットワーク・トラフィックを管理します。 IBM Cloud インフラストラクチャー (SoftLayer) の[セキュリティー・グループ](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups)は使用しないでください。 IBM Cloud インフラストラクチャー (SoftLayer) のセキュリティー・グループは、単一仮想サーバーのネットワーク・インターフェースに適用され、ハイパーバイザー・レベルでトラフィックをフィルタリングします。 しかし、セキュリティー・グループは、{{site.data.keyword.containerlong_notm}} が LoadBalancer の IP アドレスの管理に使用する VRRP プロトコルをサポートしていません。 LoadBalancer の IP を管理する VRRP プロトコルが存在しない場合、Ingress サービスおよび LoadBalancer サービスは正しく機能しません。
{: tip}

<br />


## デフォルトの Calico および Kubernetes ネットワーク・ポリシー
{: #default_policy}

パブリック VLAN を持つクラスターが作成されると、各ワーカー・ノードとそのパブリック・ネットワーク・インターフェースに対して、`ibm.role: worker_public` ラベルを持つ HostEndpoint リソースが自動的に作成されます。 ワーカー・ノードのパブリック・ネットワーク・インターフェースを保護するために、デフォルトの Calico ポリシーが `ibm.role: worker_public` ラベルを持つすべてのホスト・エンドポイントに適用されます。
{:shortdesc}

これらのデフォルトの Calico ポリシーは、すべてのアウトバウンド・ネットワーク・トラフィックを許可し、Kubernetes NodePort、LoadBalancer、Ingress サービスなどの特定のクラスター・コンポーネントへのインバウンド・トラフィックを許可します。 デフォルト・ポリシーで指定されていない、インターネットからワーカー・ノードへのその他のインバウンド・ネットワーク・トラフィックはすべてブロックされます。 デフォルト・ポリシーはポッド間トラフィックに影響しません。

クラスターに自動的に適用される、以下のデフォルトの Calico ネットワーク・ポリシーを確認します。

**重要:** ポリシーを完全に理解していない限り、ホスト・エンドポイントに適用されるポリシーは削除しないでください。 ポリシーによって許可されているトラフィックが不要であることを確認してください。

 <table summary="表の 1 行目は両方の列にまたがっています。残りの行は左から右に読みます。1 列目はサーバーのゾーン、2 列目は対応する IP アドレスです。">
 <caption>各クラスターのデフォルト Calico ポリシー</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> 各クラスターのデフォルト Calico ポリシー</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>すべてのアウトバウンド・トラフィックを許可します。</td>
    </tr>
    <tr>
      <td><code>allow-bigfix-port</code></td>
      <td>必要なワーカー・ノードの更新を許可するために、BigFix アプリへの着信トラフィックをポート 52311 で許可します。</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>すべての着信 ICMP パケット (ping) を許可します。</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>NodePort、LoadBalancer、および Ingress サービスが公開しているポッドへの、それらのサービスの着信トラフィックを許可します。 <strong>注</strong>: Kubernetes は宛先ネットワーク・アドレス変換 (DNAT) を使用してサービス要求を正しいポッドに転送するため、公開ポートを指定する必要はありません。 ホストのエンドポイント・ポリシーが iptables で適用される前に、その転送が実行されます。</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>ワーカー・ノードを管理するために使用される特定の IBM Cloud インフラストラクチャー (SoftLayer) システムの着信接続を許可します。</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>ワーカー・ノード間の仮想 IP アドレスのモニターと移動に使用される VRRP パケットを許可します。</td>
   </tr>
  </tbody>
</table>

Kubernetes バージョン 1.10 以降のクラスターでは、Kubernetes ダッシュボードへのアクセスを制限するデフォルトの Kubernetes ポリシーも作成されます。 Kubernetes ポリシーはホスト・エンドポイントには適用されませんが、代わりに `kube-dashboard` ポッドに適用されます。 このポリシーは、プライベート VLAN にのみ接続されたクラスターと、パブリック VLAN およびプライベート VLAN に接続されたクラスターに適用されます。

<table>
<caption>各クラスターのデフォルトの Kubernetes ポリシー</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> 各クラスターのデフォルトの Kubernetes ポリシー</th>
</thead>
<tbody>
 <tr>
  <td><code>kubernetes-dashboard</code></td>
  <td><b>Kubernetes v1.10 のみ</b>で、<code>kube-system</code> 名前空間で提供されます。すべてのポッドに対し、Kubernetes ダッシュボードへのアクセスをブロックします。 このポリシーは、ダッシュボードへの {{site.data.keyword.Bluemix_notm}} UI からのアクセス、または <code>kubectl proxy</code> を使用したアクセスには影響しません。 ダッシュボードへのアクセスを必要とするポッドの場合は、<code>kubernetes-dashboard-policy: allow</code> ラベルを持つ名前空間にそのポッドをデプロイします。</td>
 </tr>
</tbody>
</table>

<br />


## Calico CLI のインストールおよび構成
{: #cli_install}

Calico ポリシーを表示、管理、および追加するには、Calico CLI をインストールして構成します。
{:shortdesc}

CLI 構成およびポリシーに関する Calico バージョンの互換性は、クラスターの Kubernetes バージョンに応じて異なります。 Calico CLI をインストールして構成するには、クラスター・バージョンに応じて以下のいずれかのリンクをクリックします。

* [Kubernetes バージョン 1.10 以降のクラスター](#1.10_install)
* [Kubernetes バージョン 1.9 以前のクラスター](#1.9_install)

Kubernetes バージョン 1.9 以前からバージョン 1.10 以降にクラスターを更新する前に、[Calico v3 への更新の準備](cs_versions.html#110_calicov3)を確認してください。
{: tip}

### Kubernetes バージョン 1.10 以降を実行しているクラスター用のバージョン 3.1.1 の Calico CLI のインストールおよび構成
{: #1.10_install}

始めに、[Kubernetes CLI のターゲットをクラスターにします](cs_cli_install.html#cs_cli_configure)。 `ibmcloud ks cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。 このダウンロードには、インフラストラクチャー・ポートフォリオにアクセスし、ワーカー・ノードで Calico コマンドを実行するためのキーも含まれています。

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

3.1.1 Calico CLI をインストールして構成するには、以下のようにします。

1. [Calico CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/projectcalico/calicoctl/releases/tag/v3.1.1) をダウンロードします。

    OSX を使用している場合は、`-darwin-amd64` バージョンをダウンロードします。 Windows を使用している場合、Calico CLI を {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールします。 このようにセットアップすると、後でコマンドを実行するとき、ファイル・パスの変更を行う手間がいくらか少なくなります。 ファイルを必ず `calicoctl.exe` として保存してください。
    {: tip}

2. OSX と Linux のユーザーは、以下の手順を実行してください。
    1. 実行可能ファイルを _/usr/local/bin_ ディレクトリーに移動します。
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. ファイルを実行可能ファイルにします。

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Calico CLI クライアントのバージョンを調べて、`calico` コマンドが正常に実行されたことを確認します。

    ```
    calicoctl version
    ```
    {: pre}

4. 企業ネットワーク・ポリシーがプロキシーまたはファイアウォールを使用して、ローカル・システムからパブリック・エンドポイントへのアクセスを禁止している場合は、[Calico コマンドに対して TCP アクセスを許可](cs_firewall.html#firewall)します。

5. Linux および OS X の場合、`/etc/calico` ディレクトリーを作成します。 Windows の場合は、どのディレクトリーを使用しても構いません。

  ```
  sudo mkdir -p /etc/calico/
  ```
  {: pre}

6. `calicoctl.cfg` ファイルを作成します。
    - Linux および OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows の場合: テキスト・エディターでファイルを作成します。

7. <code>calicoctl.cfg</code> ファイルに次の情報を入力します。

    ```
    apiVersion: projectcalico.org/v3
    kind: CalicoAPIConfig
    metadata:
    spec:
        datastoreType: etcdv3
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. `<ETCD_URL>` を取得します。

      - Linux および OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

          出力例:

          ```
          https://169.xx.xxx.xxx:30000
          ```
          {: screen}

      - Windows:
        <ol>
        <li>構成マップから calico 構成値を取得します。 </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>`data` セクションで、etcd_endpoints 値を見つけます。 例: <code>https://169.xx.xxx.xxx:30000</code>
        </ol>

    2. `<CERTS_DIR>` (Kubernetes 証明書をダウンロードしたディレクトリー) を取得します。

        - Linux および OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          出力例:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

            出力例:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **注**: ディレクトリー・パスを取得するには、出力の最後からファイル名 `kube-config-prod-<zone>-<cluster_name>.yml` を除きます。

    3. `ca-*pem_file` を取得します。

        - Linux および OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>最後のステップで取得したディレクトリーを開きます。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> <code>ca-*pem_file</code> ファイルを見つけます。</ol>

8. ファイルを保存し、ファイルが置かれたディレクトリーが現行ディレクトリーであることを確認します。

9. Calico 構成が正常に動作していることを確認します。

    - Linux および OS X:

      ```
      calicoctl get nodes
      ```
      {: pre}

    - Windows:

      ```
      calicoctl get nodes --config=filepath/calicoctl.cfg
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


### Kubernetes バージョン 1.9 以前を実行しているクラスター用のバージョン 1.6.3 の Calico CLI のインストールおよび構成
{: #1.9_install}

始めに、[Kubernetes CLI のターゲットをクラスターにします](cs_cli_install.html#cs_cli_configure)。 `ibmcloud ks cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。 このダウンロードには、インフラストラクチャー・ポートフォリオにアクセスし、ワーカー・ノードで Calico コマンドを実行するためのキーも含まれています。

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

1.6.3 Calico CLI をインストールして構成するには、以下のようにします。

1. [Calico CLI ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3) をダウンロードします。

    OSX を使用している場合は、`-darwin-amd64` バージョンをダウンロードします。 Windows を使用している場合、Calico CLI を {{site.data.keyword.Bluemix_notm}} CLI と同じディレクトリーにインストールします。 このようにセットアップすると、後でコマンドを実行するとき、ファイル・パスの変更を行う手間がいくらか少なくなります。
    {: tip}

2. OSX と Linux のユーザーは、以下の手順を実行してください。
    1. 実行可能ファイルを _/usr/local/bin_ ディレクトリーに移動します。
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. ファイルを実行可能ファイルにします。

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

3. Calico CLI クライアントのバージョンを調べて、`calico` コマンドが正常に実行されたことを確認します。

    ```
    calicoctl version
    ```
    {: pre}

4. 企業ネットワーク・ポリシーがプロキシーまたはファイアウォールを使用して、ローカル・システムからパブリック・エンドポイントへのアクセスを禁止している場合は、Calico コマンドに対して TCP アクセスを許可する手順について、[ファイアウォール保護下での `calicoctl` コマンドの実行](cs_firewall.html#firewall)を参照してください。

5. Linux および OS X の場合、`/etc/calico` ディレクトリーを作成します。 Windows の場合は、どのディレクトリーを使用しても構いません。
    ```
    sudo mkdir -p /etc/calico/
    ```
    {: pre}

6. `calicoctl.cfg` ファイルを作成します。
    - Linux および OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows の場合: テキスト・エディターでファイルを作成します。

7. <code>calicoctl.cfg</code> ファイルに次の情報を入力します。

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

    1. `<ETCD_URL>` を取得します。

      - Linux および OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

      - 出力例:

          ```
          https://169.xx.xxx.xxx:30001
          ```
          {: screen}

      - Windows:
        <ol>
        <li>構成マップから calico 構成値を取得します。 </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>`data` セクションで、etcd_endpoints 値を見つけます。 例: <code>https://169.xx.xxx.xxx:30001</code>
        </ol>

    2. `<CERTS_DIR>` (Kubernetes 証明書をダウンロードしたディレクトリー) を取得します。

        - Linux および OS X:

          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          出力例:

          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:

          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

          出力例:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **注**: ディレクトリー・パスを取得するには、出力の最後からファイル名 `kube-config-prod-<zone>-<cluster_name>.yml` を除きます。

    3. `ca-*pem_file` を取得します。

        - Linux および OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>最後のステップで取得したディレクトリーを開きます。</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> <code>ca-*pem_file</code> ファイルを見つけます。</ol>

    4. Calico 構成が正常に動作していることを確認します。

        - Linux および OS X:

          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows:

          ```
          calicoctl get nodes --config=filepath/calicoctl.cfg
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

          **重要**: `calicoctl` コマンドを実行する際、Windows および OS X ユーザーは必ず `--config=filepath/calicoctl.cfg` フラグを含める必要があります。

<br />


## ネットワーク・ポリシーの表示
{: #view_policies}

クラスターに適用される、デフォルト・ネットワーク・ポリシーおよび追加されたすべてのネットワーク・ポリシーの詳細を表示します。
{:shortdesc}

開始前に、以下のことを行います。
1. [Calico CLI をインストールして構成します。](#cli_install)
2. [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。 `ibmcloud ks cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。 このダウンロードには、インフラストラクチャー・ポートフォリオにアクセスし、ワーカー・ノードで Calico コマンドを実行するためのキーも含まれています。
```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

CLI 構成およびポリシーに関する Calico バージョンの互換性は、クラスターの Kubernetes バージョンに応じて異なります。 Calico CLI をインストールして構成するには、クラスター・バージョンに応じて以下のいずれかのリンクをクリックします。

* [Kubernetes バージョン 1.10 以降のクラスター](#1.10_examine_policies)
* [Kubernetes バージョン 1.9 以前のクラスター](#1.9_examine_policies)

Kubernetes バージョン 1.9 以前からバージョン 1.10 以降にクラスターを更新する前に、[Calico v3 への更新の準備](cs_versions.html#110_calicov3)を確認してください。
{: tip}

### Kubernetes バージョン 1.10 以降を実行しているクラスター内のネットワーク・ポリシーの表示
{: #1.10_examine_policies}

Linux および Mac ユーザーは、`calicoctl` コマンドに `--config=filepath/calicoctl.cfg` フラグを含める必要はありません。
{: tip}

1. Calico ホスト・エンドポイントを表示します。

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. そのクラスター用に作成されたすべての Calico および Kubernetes ネットワーク・ポリシーを表示します。 このリストにはどのポッドやホストにもまだ適用されていない可能性のあるポリシーも含まれています。 ネットワーク・ポリシーを適用するには、Calico ネットワーク・ポリシーで定義されたセレクターと一致する Kubernetes リソースを見つける必要があります。

    [ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) は特定の名前空間にスコープ設定されます。
    ```
    calicoctl get NetworkPolicy --all-namespaces -o wide --config=filepath/calicoctl.cfg
    ```
    {:pre}

    [グローバル・ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) は特定の名前空間にスコープ設定されません。
    ```
    calicoctl get GlobalNetworkPolicy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. ネットワーク・ポリシーの詳細を表示します。

    ```
    calicoctl get NetworkPolicy -o yaml <policy_name> --namespace <policy_namespace> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. クラスターのすべてのグローバル・ネットワーク・ポリシーの詳細を表示します。

    ```
    calicoctl get GlobalNetworkPolicy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

### Kubernetes バージョン 1.9 以前を実行しているクラスター内のネットワーク・ポリシーの表示
{: #1.9_examine_policies}

Linux ユーザーは、`calicoctl` コマンドに `--config=filepath/calicoctl.cfg` フラグを含める必要はありません。
{: tip}

1. Calico ホスト・エンドポイントを表示します。

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. そのクラスター用に作成されたすべての Calico および Kubernetes ネットワーク・ポリシーを表示します。 このリストにはどのポッドやホストにもまだ適用されていない可能性のあるポリシーも含まれています。 ネットワーク・ポリシーを適用するには、Calico ネットワーク・ポリシーで定義されたセレクターと一致する Kubernetes リソースを見つける必要があります。

    ```
    calicoctl get policy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. ネットワーク・ポリシーの詳細を表示します。

    ```
    calicoctl get policy -o yaml <policy_name> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. そのクラスター用のすべてのネットワーク・ポリシーの詳細を表示します。

    ```
    calicoctl get policy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

<br />


## ネットワーク・ポリシーの追加
{: #adding_network_policies}

ほとんどの場合、デフォルト・ポリシーは変更する必要がありません。 拡張シナリオのみ、変更が必要な場合があります。 変更が必要であるとわかった場合は、独自のネットワーク・ポリシーを作成できます。
{:shortdesc}

Kubernetes ネットワーク・ポリシーを作成するには、[Kubernetes ネットワーク・ポリシーの資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/network-policies/) を参照してください。

Calico ポリシーを作成するには、以下の手順を実行します。

開始前に、以下のことを行います。
1. [Calico CLI をインストールして構成します。](#cli_install)
2. [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。 `ibmcloud ks cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。 このダウンロードには、インフラストラクチャー・ポートフォリオにアクセスし、ワーカー・ノードで Calico コマンドを実行するためのキーも含まれています。
```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

CLI 構成およびポリシーに関する Calico バージョンの互換性は、クラスターの Kubernetes バージョンに応じて異なります。 クラスターのバージョンに応じて、以下のいずれかのリンクをクリックします。

* [Kubernetes バージョン 1.10 以降のクラスター](#1.10_create_new)
* [Kubernetes バージョン 1.9 以前のクラスター](#1.9_create_new)

Kubernetes バージョン 1.9 以前からバージョン 1.10 以降にクラスターを更新する前に、[Calico v3 への更新の準備](cs_versions.html#110_calicov3)を確認してください。
{: tip}

### Kubernetes バージョン 1.10 以降を実行しているクラスターでの Calico ポリシーの追加
{: #1.10_create_new}

1. 構成スクリプト (`.yaml`) を作成して、Calico [ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) または[グローバル・ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) を定義します。 これらの構成ファイルにはどのポッド、名前空間、またはホストにこれらのポリシーを適用するかを説明するセレクターが含まれます。 独自のポリシーを作成するときには、こちらの[サンプル Calico ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) を参考にしてください。
    **注**: Kubernetes バージョン 1.10 以降のクラスターでは、Calico v3 ポリシー構文を使用する必要があります。

2. ポリシーをクラスターに適用します。
    - Linux および OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

### Kubernetes バージョン 1.9 以前を実行しているクラスターでの Calico ポリシーの追加
{: #1.9_create_new}

1. 構成スクリプト (`.yaml`) を作成して、独自の [Calico ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) を定義します。 これらの構成ファイルにはどのポッド、名前空間、またはホストにこれらのポリシーを適用するかを説明するセレクターが含まれます。 独自のポリシーを作成するときには、こちらの[サンプル Calico ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) を参考にしてください。
    **注**: Kubernetes バージョン 1.9 以前のクラスターでは、Calico v2 ポリシー構文を使用する必要があります。


2. ポリシーをクラスターに適用します。
    - Linux および OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

<br />


## LoadBalancer または NodePort サービスへのインバウンド・トラフィックの制御
{: #block_ingress}

[デフォルト](#default_policy)で、Kubernetes の NodePort サービスと LoadBalancer サービスは、パブリックとプライベートのすべてのクラスター・インターフェースでアプリを利用可能にするために設計されています。 ただし、Calico ポリシーを使用し、トラフィックのソースまたは宛先に基づいてサービスへの着信トラフィックをブロックすることができます。
{:shortdesc}

Kubernetes の LoadBalancer サービスは NodePort サービスでもあります。 LoadBalancer サービスにより、LoadBalancer の IP アドレスとポートを介してアプリが利用可能になり、サービスの NodePort を介してアプリが利用可能になります。 NodePort には、クラスター内のすべてのノードのすべての IP アドレス (パブリックおよびプライベート) でアクセス可能です。

クラスター管理者は、Calico `preDNAT` ネットワーク・ポリシーを使用して以下のものをブロックできます。

  - NodePort サービスへのトラフィック。 LoadBalancer サービスへのトラフィックは許可されます。
  - ソース・アドレスまたは CIDR に基づくトラフィック。

Calico `preDNAT` ネットワーク・ポリシーのいくつかの一般的な使用方法:

  - プライベート LoadBalancer サービスのパブリック NodePort へのトラフィックをブロックします。
  - [エッジ・ワーカー・ノード](cs_edge.html#edge)を実行しているクラスター上のパブリック NodePort へのトラフィックをブロックします。 NodePort をブロックすることにより、エッジ・ワーカー・ノードが着信トラフィックを処理する唯一のワーカー・ノードになります。

デフォルトの Kubernetes ポリシーと Calico ポリシーでは、保護する Kubernetes の NodePort サービスと LoadBalancer サービスに対して生成された DNAT iptables 規則があるために、それらのサービスに対してポリシーを適用するのは困難です。

Calico `preDNAT` ネットワーク・ポリシーは、Calico ネットワーク・ポリシー・リソースに基づいて iptables 規則を生成するので便利です。 Kubernetes バージョン 1.10 以降のクラスターは、[`calicoctl.cfg` v3 構文 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン") でネットワーク・ポリシー](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy)を使用します。 Kubernetes バージョン 1.9 以前のクラスターは、[`calicoctl.cfg` v2 構文 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン") でポリシー](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy)を使用します。

1. Kubernetes サービスへの ingress (インバウンド・トラフィック) アクセス用の Calico `preDNAT` ネットワーク・ポリシーを定義します。

    * Kubernetes バージョン 1.10 以降のクラスターでは、Calico v3 ポリシー構文を使用する必要があります。

        すべての NodePort をブロックするリソースの例:

        ```
        apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: deny-nodeports
    spec:
      applyOnForward: true
      ingress:
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: TCP
            source: {}
          - action: Deny
            destination:
              ports:
              - 30000:32767
        protocol: UDP
        source: {}
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 1100
      types:
          - Ingress
        ```
        {: codeblock}

    * Kubernetes バージョン 1.9 以前のクラスターでは、Calico v2 ポリシー構文を使用する必要があります。

        すべての NodePort をブロックするリソースの例:

        ```
        apiVersion: v1
        kind: policy
        metadata:
          name: deny-nodeports
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

2. Calico preDNAT ネットワーク・ポリシーを適用します。 ポリシーの変更内容がクラスター全体に適用されるまでには
約 1 分かかります。

  - Linux および OS X:

    ```
    calicoctl apply -f deny-nodeports.yaml
    ```
    {: pre}

  - Windows:

    ```
    calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. オプション: 複数ゾーン・クラスターでは、MZLB ヘルス・チェックにより、クラスターの各ゾーンの ALB が検査され、そのヘルス・チェックに基づいて DNS 参照の結果が最新の状態に保たれます。 preDNAT ポリシーを使用して Ingress サービスへのすべての着信トラフィックをブロックする場合は、ALB のヘルス・チェックに使用される [Cloudflare の IPv4 IP ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.cloudflare.com/ips/) をホワイトリストに登録する必要があります。 Calico preDNAT ポリシーを作成してこれらの IP をホワイトリストに登録する手順については、[Calico ネットワーク・ポリシー・チュートリアル](cs_tutorials_policies.html#lesson3)のレッスン 3 を参照してください。

ソース IP アドレスをホワイトリストまたはブラックリストに登録する方法については、[Calico ネットワーク・ポリシーを使用してトラフィックをブロックするチュートリアル](cs_tutorials_policies.html#policy_tutorial)をお試しください。 クラスターのトラフィックを制御する Calico ネットワーク・ポリシーの例については、、[Stars Policy Demo ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) と [Advanced Network Policy ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) を参照してください。
{: tip}

## プライベート・ネットワーク上のクラスターの分離
{: #isolate_workers}

複数ゾーン・クラスター、単一ゾーン・クラスター用の複数の VLAN、または同じ VLAN 上に複数のサブネットがある場合は、[VLAN スパンニングを有効](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)にして、ワーカー・ノードがプライベート・ネットワーク上で相互に通信できるようにする必要があります。ただし、VLAN スパンニングが有効になっている場合、同じ IBM Cloud アカウント内のいずれかのプライベート VLAN に接続されているすべてのシステムはワーカーと通信できます。

[Calico プライベート・ネットワーク・ポリシー ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation) を適用することにより、プライベート・ネットワーク上の他のシステムからクラスターを分離できます。この一連の Calico ポリシーおよびホスト・エンドポイントにより、アカウントのプライベート・ネットワーク内の他のリソースからクラスターのプライベート・ネットワーク・トラフィックが分離されます。

このポリシーは、クラスターのワーカー・ノードのプライベート・インターフェース (eth0) およびポッド・ネットワークを対象としています。

**ワーカー・ノード**

* プライベート・インターフェース egress は、ポッド IP、このクラスター内のワーカー、および DNS アクセスのための UPD/TCP ポート 53 に対してのみ許可されます。
* プライベート・インターフェース ingress は、クラスター内のワーカーから DNS、kubelet、ICMP、および VRRP にのみ許可されます。

**ポッド**

* ポッドへのすべての ingress は、クラスター内のワーカーから許可されます。
* ポッドからの egress は、クラスター内のパブリック IP、DNS、kubelet、および他のポッドのみに制限されます。

開始前に、以下のことを行います。
1. [Calico CLI をインストールして構成します。](#cli_install)
2. [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。 `ibmcloud ks cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。 このダウンロードには、インフラストラクチャー・ポートフォリオにアクセスし、ワーカー・ノードで Calico コマンドを実行するためのキーも含まれています。
```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

Calico ポリシーを使用して、プライベート・ネットワーク上のクラスターを分離するには、以下のようにします。

1. `IBM-Cloud/kube-samples` リポジトリーを複製します。
    ```
    git clone https://github.com/IBM-Cloud/kube-samples.git
    ```
    {: pre}

2. クラスター・バージョンと互換性がある Calico バージョンのプライベート・ポリシー・ディレクトリーにナビゲートします。
    * Kubernetes バージョン 1.10 以降のクラスター:
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v3
      ```
      {: pre}

    * Kubernetes バージョン 1.9 以前のクラスター:
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v2
      ```
      {: pre}

3. プライベート・ホスト・エンドポイント・ポリシーをセットアップします。
    1. `generic-privatehostendpoint.yaml` ポリシーを開きます。
    2. `<worker_name>` をワーカー・ノードの名前に置き換え、`<worker-node-private-ip>` をワーカー・ノードのプライベート IP アドレスに置き換えます。ワーカー・ノードのプライベート IP を確認するには、`ibmcloud ks workers --cluster <my_cluster>` を実行します。
    3. クラスター内の各ワーカー・ノードの新しいセクションでこのステップを繰り返します。
    **注**: ワーカー・ノードをクラスターに追加するたびに、新しいエントリーを使用してホスト・エンドポイント・ファイルを更新する必要があります。

4. すべてのポリシーをクラスターに適用します。
    - Linux および OS X:

      ```
      calicoctl apply -f allow-all-workers-private.yaml
      calicoctl apply -f allow-dns-10250.yaml
      calicoctl apply -f allow-egress-pods.yaml
      calicoctl apply -f allow-icmp-private.yaml
      calicoctl apply -f allow-vrrp-private.yaml
      calicoctl apply -f generic-privatehostendpoint.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f allow-all-workers-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-dns-10250.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-egress-pods.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-icmp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-vrrp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f generic-privatehostendpoint.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

## ポッド間のトラフィックの制御
{: #isolate_services}

Kubernetes ポリシーは、内部ネットワーク・トラフィックからポッドを保護します。 シンプルな Kubernetes ネットワーク・ポリシーを作成して、1 つの名前空間または複数の名前空間でアプリのマイクロサービスを互いから分離することができます。
{: shortdesc}

Kubernetes ネットワーク・ポリシーがポッド間のトラフィックを制御する方法、およびその他のポリシーの例について詳しくは、[Kubernetes の資料 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/services-networking/network-policies/) を参照してください。
{: tip}

### 1 つの名前空間でのアプリ・サービスの分離
{: #services_one_ns}

以下のシナリオでは、1 つの名前空間でアプリのマイクロサービス間のトラフィックを管理する方法を説明します。

Accounts チームは、1 つの名前空間に複数のアプリ・サービスをデプロイしますが、パブリック・ネットワークによるマイクロサービス間の通信を、必要なものだけに制限するために分離を必要としています。 アプリ Srv1 のために、チームはフロントエンド・サービス、バックエンド・サービス、データベース・サービスを作成しました。 それぞれのサービスに `app: Srv1` というラベルと `tier: frontend`、`tier: backend`、`tier: db` というラベルを付けています。

<img src="images/cs_network_policy_single_ns.png" width="200" alt="ネットワーク・ポリシーを使用して名前空間の間のトラフィックを管理する" style="width:200px; border-style: none"/>

Accounts チームは、フロントエンドからバックエンド、およびバックエンドからデータベースへのトラフィックを許可する必要があります。 そこで、ネットワーク・ポリシーでラベルを使用し、マイクロサービス間でどのトラフィック・フローを許可するかを指定することにしました。

まずは、フロントエンドからバックエンドへのトラフィックを許可する Kubernetes ネットワーク・ポリシーを作成します。

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: backend-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: frontend
```
{: codeblock}

`spec.podSelector.matchLabels` セクションに、Srv1 バックエンド・サービスのラベルをリストしているので、このポリシーはそれらのポッド_に_のみ適用されます。 `spec.ingress.from.podSelector.matchLabels` セクションに、Srv1 フロントエンド・サービスのラベルをリストしているので、それらのポッド_から_入ってくるもののみが許可されます。

次に、バックエンドからデータベースへのトラフィックを許可する同じような Kubernetes ネットワーク・ポリシーを作成します。

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: db-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: db
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: backend
  ```
  {: codeblock}

`spec.podSelector.matchLabels` セクションに、Srv1 データベース・サービスのラベルをリストしているので、このポリシーはそれらのポッド_に_のみ適用されます。 `spec.ingress.from.podSelector.matchLabels` セクションに、Srv1 バックエンド・サービスのラベルをリストしているので、それらのポッド_から_入ってくるもののみが許可されます。

これで、フロントエンドからバックエンドと、バックエンドからデータベースにトラフィックが流れるようになりました。 データベースはバックエンドに、バックエンドはフロントエンドに応答できますが、逆のトラフィック接続を確立することはできません。

### 複数の名前空間でのアプリ・サービスの分離
{: #services_across_ns}

以下のシナリオでは、複数の名前空間でアプリのマイクロサービス間のトラフィックを管理する方法を説明します。

別々のサブチームが所有するサービス間で通信を行う必要がありますが、それらのサービスは同じクラスターの別々の名前空間にデプロイされます。 Accounts チームは、アプリ Srv1 のフロントエンド・サービス、バックエンド・サービス、データベース・サービスを accounts 名前空間にデプロイします。 Finance チームは、アプリ Srv2 のフロントエンド・サービス、バックエンド・サービス、データベース・サービスを finance 名前空間にデプロイします。 両方のチームは、それぞれのサービスに `app: Srv1` または `app: Srv2` というラベルと `tier: frontend`、`tier: backend`、`tier: db` というラベルを付けます。 また、名前空間に `usage: accounts` または `usage: finance` というラベルを付けます。

<img src="images/cs_network_policy_multi_ns.png" width="475" alt="ネットワーク・ポリシーを使用して名前空間の間のトラフィックを管理する" style="width:475px; border-style: none"/>

Finance チームの Srv2 は、Accounts チームの Srv1 のバックエンドの情報を必要とします。 そのため、Accounts チームは、ラベルを使用して、finance 名前空間から accounts 名前空間の Srv1 バックエンドへのすべてのトラフィックを許可する Kubernetes ネットワーク・ポリシーを作成します。 また、ポート 3111 を指定して、そのポートを使用するアクセスのみを分離します。

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  Namespace: accounts
  name: accounts-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      Tier: backend
  ingress:
  - from:
    - NamespaceSelector:
        matchLabels:
          usage: finance
      ports:
        port: 3111
```
{: codeblock}

`spec.podSelector.matchLabels` セクションに、Srv1 バックエンド・サービスのラベルをリストしているので、このポリシーはそれらのポッド_に_のみ適用されます。 `spec.ingress.from.NamespaceSelector.matchLabels` セクションに、finance 名前空間のラベルをリストしているので、この名前空間のサービス_から_入ってくるもののみが許可されます。

これで、finance マイクロサービスから accounts の Srv1 バックエンドにトラフィックが流れるようになりました。 accounts の Srv1 バックエンドは、finance マイクロサービスに応答できますが、逆のトラフィック接続を確立することはできません。

**注**: `podSelector` と `namespaceSelector` を組み合わせることはできないため、別の名前空間の特定のアプリ・ポッドからのトラフィックを許可することはできません。 この例では、finance 名前空間のすべてのマイクロサービスからのトラフィックがすべて許可されます。

## 拒否されたトラフィックのロギング
{: #log_denied}

クラスター内の特定のポッドに対する拒否されたトラフィック要求をログに記録するには、Calico ログ・ネットワーク・ポリシーを作成します。
{: shortdesc}

トラフィックをアプリ・ポッドに制限するネットワーク・ポリシーをセットアップしている場合、このポリシーで許可されないトラフィック要求は拒否され、除去されます。一部のシナリオでは、拒否されたトラフィック要求の詳細情報が必要になる場合があります。例えば、ネットワーク・ポリシーの 1 つによって一部の異常なトラフィックが継続的に拒否されることに気付く場合があります。潜在的なセキュリティー脅威をモニターするには、指定されたアプリ・ポッドで試行されたアクションがポリシーで拒否されるたびに記録するようにロギングをセットアップします。

開始前に、以下のことを行います。
1. [Calico CLI をインストールして構成します。](#cli_install) **注**: これらのステップのポリシーは、Kubernetes バージョン 1.10 以降を実行するクラスターと互換性のある Calico v3 構文を使用します。Kubernetes バージョン 1.9 以前を実行するクラスターの場合は、[Calico v2 ポリシー構文 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) を使用する必要があります。
2. [クラスターを Kubernetes CLI のターゲットとして設定](cs_cli_install.html#cs_cli_configure)します。 `ibmcloud ks cluster-config` コマンドで `--admin` オプションを指定します。これは、証明書および許可ファイルのダウンロードに使用されます。 このダウンロードには、インフラストラクチャー・ポートフォリオにアクセスし、ワーカー・ノードで Calico コマンドを実行するためのキーも含まれています。
```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

拒否されたトラフィックをログに記録するための Calico ポリシーを作成するには、以下のようにします。

1. 着信トラフィックをブロックまたは制限する Kubernetes または Calico ネットワーク・ポリシーを作成するか、または既存のものを使用します。例えば、ポッド間のトラフィックを制御するには、NGINX アプリへのアクセスを制限する `access-nginx` という名前の以下のサンプル Kubernetes ポリシーを使用します。「run=nginx」というラベルが付いたポッドへの着信トラフィックは、「run=access」ラベルを持つポッドからのみ許可されます。「run=nginx」アプリ・ポッドへの他の着信トラフィックはすべてブロックされます。
    ```
    kind: NetworkPolicy
    apiVersion: extensions/v1beta1
    metadata:
      name: access-nginx
    spec:
      podSelector:
        matchLabels:
          run: nginx
      ingress:
        - from:
          - podSelector:
              matchLabels:
                run: access
    ```
    {: codeblock}

2. ポリシーを適用します。
    * Kubernetes ポリシーを適用するには、以下のようにします。
        ```
        kubectl apply -f <policy_name>.yaml
        ```
        {: pre}
        Kubernetes ポリシーは自動的に Calico NetworkPolicy に変換されるため、Calico はそれを iptables 規則として適用できます。

    * Calico ポリシーを適用するには、以下のようにします。
        ```
        calicoctl apply -f <policy_name>.yaml --config=<filepath>/calicoctl.cfg
        ```
        {: pre}

3. Kubernetes ポリシーを適用した場合は、自動的に作成された Calico ポリシーの構文を確認し、`spec.selector` フィールドの値をコピーします。
    ```
    calicoctl get policy -o yaml <policy_name> --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

    例えば、適用および変換した後の `access-nginx` ポリシーには、以下の Calico v3 構文が含まれます。`spec.selector` フィールドの値は、`projectcalico.org/orchestrator == 'k8s' & & run == 'nginx'` です。
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: access-nginx
    spec:
      ingress:
      - action: Allow
        destination: {}
        source:
          selector: projectcalico.org/orchestrator == 'k8s' && run == 'access'
      order: 1000
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      types:
      - Ingress
    ```
    {: screen}

4. 以前に作成した Calico ポリシーによって拒否されたトラフィックをすべてログに記録するために、`log-denied-packets` という名前の Calico NetworkPolicy を作成します。例えば、次のポリシーを使用して、ステップ 1 で定義したネットワーク・ポリシーによって拒否されたすべてのパケットをログに記録します。ログ・ポリシーはサンプル・ポリシー `access-nginx` と同じポッド・セレクターを使用し、これにより、このポリシーが Calico iptables 規則チェーンに追加されます。`3000` などの大きい順序番号を使用すると、この規則を確実に iptables 規則チェーンの最後に追加することができます。`access-nginx` ポリシー規則に一致する「run=access」ポッドからの要求パケットは、「run=nginx」ポッドに受け入れられます。ただし、他のソースからのパケットが下位の `access-nginx` ポリシー規則と照合しようとすると、これらのパケットは拒否されます。これらのパケットは、次に、上位の `log-denied-packets` ポリシー規則と照合しようとします。`log-denied-packets` は、これに到達したすべてのパケットをログに記録します。したがって、「run=nginx」ポッドによって拒否されたパケットだけがログに記録されます。パケットの試行がログに記録された後、パケットは除去されます。
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: log-denied-packets
    spec:
      types:
      - Ingress
      ingress:
      - action: Log
        destination: {}
        source: {}
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      order: 3000
    ```
    {: codeblock}

    <table>
    <caption>ログ・ポリシー YAML の構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> ログ・ポリシー YAML の構成要素について</th>
    </thead>
    <tbody>
    <tr>
     <td><code>types</code></td>
     <td>この <code>Ingress</code> ポリシーは、着信トラフィック要求に適用されます。<strong>注:</strong> 値 <code>Ingress</code> は、すべての着信トラフィックの一般用語であり、IBM Ingress ALB のみからのトラフィックを示しているわけではありません。</td>
    </tr>
     <tr>
      <td><code>ingress</code></td>
      <td><ul><li><code>action</code>: <code>Log</code> アクションは、このポリシーに一致するすべての要求のログ・エントリーを、ワーカー・ノードの `/var/log/syslog/` パスに書き込みます。</li><li><code>destination</code>: <code>selector</code> により特定のラベルを持つすべてのポッドにこのポリシーが適用されるため、宛先は指定されません。</li><li><code>source</code>: このポリシーは任意のソースからの要求に適用されます。</td>
     </tr>
     <tr>
      <td><code>selector</code></td>
      <td>&lt;selector&gt; は、ステップ 1 の Calico ポリシーで使用したか、ステップ 3 の Kubernetes ポリシーの Calico 構文で見つけた `spec.selector` フィールド内の同じセレクターに置き換えます。例えば、セレクター <code>selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'</code> を使用することで、このポリシーの規則が、ステップ 1 の <code>access-nginx</code> サンプル・ネットワーク・ポリシー規則と同じ iptables チェーンに追加されます。このポリシーは、同じポッド・セレクター・ラベルを使用するポッドへの着信ネットワーク・トラフィックにのみ適用されます。</td>
     </tr>
     <tr>
      <td><code>order</code></td>
      <td>Calico ポリシーには、着信要求パケットに適用されるタイミングを決定する順序があります。<code>1000</code> などの下位のポリシーが最初に適用されます。上位ポリシーは、下位ポリシーの後に適用されます。例えば、<code>3000</code> などの非常に高い順序のポリシーは、実際上すべての下位ポリシーが適用された後に適用されます。</br></br>着信要求パケットには iptables 規則チェーンが適用され、最初に下位ポリシーの規則との照合が試行されます。パケットが任意の規則に一致した場合、そのパケットは受け入れられます。ただし、パケットがどの規則にも一致しない場合、そのパケットは、最上位の iptables 規則チェーン内の最後のルールに到達します。これが確実にチェーン内の最後のポリシーになるように、ステップ 1 で作成したポリシーよりも大幅に高い順序 (<code>3000</code> など) を使用します。</td>
     </tr>
    </tbody>
    </table>

5. ポリシーを適用します。
    ```
    calicoctl apply -f log-denied-packets.yaml --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

6. `/var/log/syslog` から {{site.data.keyword.loganalysislong}} または外部の syslog サーバーに[ログを転送](cs_health.html#configuring)します。
