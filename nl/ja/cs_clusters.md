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


# クラスターのセットアップ
{: #clusters}

可用性と能力が最大になるようにクラスターのセットアップを設計します。
{:shortdesc}


## クラスター構成の計画
{: #planning_clusters}

標準クラスターを使用してアプリの可用性を向上させることができます。 セットアップを複数のワーカー・ノードとクラスターに分散させると、ユーザーがダウン時間を経験する可能性が低くなります。 負荷分散や負荷分離などの組み込み機能により、ホスト、ネットワーク、アプリで想定される障害に対する回復力を強化できます。
{:shortdesc}

クラスターのセットアップ方法を以下にまとめます。下に行くほど可用性が高くなります。

![クラスターの高可用性の段階](images/cs_cluster_ha_roadmap.png)

1.  複数のワーカー・ノードを配置した 1 つのクラスター
2.  同じ地域内の別々のロケーションで実行される 2 つのクラスター (ロケーションごとに複数のワーカー・ノードを配置)
3.  別々の地域で実行される 2 つのクラスター (地域ごとに複数のワーカー・ノードを配置)

以下の技法を利用すると、クラスターの可用性を高めることができます。

<dl>
<dt>複数のワーカー・ノードにアプリを分散させる</dt>
<dd>開発者が作業するときのために、クラスターごとに複数のワーカー・ノードにコンテナー内のアプリを分散できるようにしておきます。 3 つのワーカー・ノード内に 1 つずつアプリ・インスタンスがあれば、1 つのワーカー・ノードの故障時にも、アプリの使用が中断されることはありません。 [{{site.data.keyword.Bluemix_notm}} GUI](cs_clusters.html#clusters_ui) または [CLI](cs_clusters.html#clusters_cli) からクラスターを作成するときに、含めるワーカー・ノードの数を指定できます。 Kubernetes では、1 つのクラスター内に作成できるワーカー・ノードの最大数に制限があるので、[ワーカー・ノードとポッドの割り当て量 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/cluster-large/) に留意してください。
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>複数のクラスターにアプリを分散させる</dt>
<dd>それぞれに複数のワーカー・ノードを配置した複数のクラスターを作成します。 1 つのクラスターで障害が発生した場合でも、各ユーザーは別のクラスターにデプロイされているアプリにアクセスできます。
<p>クラスター 1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>クラスター 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>異なる地域にある複数のクラスターにアプリを分散させる</dt>
<dd>アプリをそれぞれ異なる地域にある複数のクラスターに分散させた場合は、ユーザーのいる地域に基づいてロード・バランシングを行うことができます。 ある地域でクラスター、ハードウェア、またはロケーション全体がダウンした場合は、別のロケーションにデプロイされているコンテナーにトラフィックが転送されます。
<p><strong>重要:</strong> カスタム・ドメインを構成した後、以下のコマンドを使用してクラスターを作成できます。</p>
<p>ロケーション 1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>ロケーション 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />


## ワーカー・ノード構成の計画
{: #planning_worker_nodes}

Kubernetes クラスターは、ワーカー・ノードで構成され、Kubernetes マスターによって一元的にモニターされて管理されます。 クラスター管理者は、ワーカー・ノードのクラスターをどのようにセットアップするかを決定して、クラスター内のアプリをデプロイして実行するためのすべてのリソースをクラスター・ユーザーのために用意します。
{:shortdesc}

標準クラスターを作成する時、ワーカー・ノードは IBM Cloud インフラストラクチャー (SoftLayer) 内で自動的に順番に配置されて {{site.data.keyword.Bluemix_notm}} にセットアップされます。 すべてのワーカー・ノードには、固有のワーカー・ノード ID とドメイン名が割り当てられます。それらをクラスターの作成後に変更してはいけません。 選択するハードウェア分離のレベルに応じて、ワーカー・ノードを共有ノードまたは専用ノードとしてセットアップできます。 それぞれのワーカー・ノードは特定のマシン・タイプでプロビジョンされ、ワーカー・ノードにデプロイされるコンテナーが使用できる vCPU の数、メモリー、ディスク・スペースがそのタイプによって決まります。 Kubernetes では、1 つのクラスター内に作成できるワーカー・ノードの最大数に制限があります。 詳しくは、[ワーカー・ノードとポッドの割り当て量 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/cluster-large/) を参照してください。


### ワーカー・ノード用のハードウェア
{: #shared_dedicated_node}

どのワーカー・ノードも、物理ハードウェア上の仮想マシンとしてセットアップされます。 {{site.data.keyword.Bluemix_notm}} で標準クラスターを作成する場合は、基礎ハードウェアを {{site.data.keyword.IBM_notm}} の複数のお客様で共有する (マルチテナンシー) か、自分専用にする (単一テナンシー) かを選択する必要があります。
{:shortdesc}

マルチテナント・セットアップの場合、CPU やメモリーなどの物理リソースは、同じ物理ハードウェアにデプロイされたすべての仮想マシン間で共有されます。 各仮想マシンが独立して実行できるようにするため、仮想マシン・モニター (ハイパーバイザーとも呼ばれる) が物理リソースを個別のエンティティーにセグメント化し、それらを専用リソースとして仮想マシンに割り振ります (ハイパーバイザー分離)。

単一テナント・セットアップの場合は、すべての物理リソースがユーザー専用になります。 同じ物理ホスト上に複数のワーカー・ノードを仮想マシンとしてデプロイできます。 マルチテナント・セットアップと同様、各ワーカー・ノードには、使用可能な物理リソースがハイパーバイザーによって割り振られます。

共有ノードは通常、専用ノードよりも安価です。基盤となるハードウェアのコストを複数のお客様が共同で分担するからです。 ただし、共有ノードにするか専用ノードにするかを決定する際は、社内の法務部門に相談して、アプリ環境で必要になるインフラストラクチャーの分離とコンプライアンスのレベルを検討することをお勧めします。

ライト・クラスターを作成する場合、ワーカー・ノードは IBM Cloud インフラストラクチャー (SoftLayer) アカウントに共有ノードとして自動的にプロビジョンされます。

### ワーカー・ノードのメモリー制限
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} は、各ワーカー・ノードにメモリー制限を設定します。 ワーカー・ノードで実行中のポッドがこのメモリー制限を超えると、ポッドは削除されます。 Kubernetes では、この制限を[ハード・エビクションしきい値![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds) と呼びます。
{:shortdesc}

ポッドが頻繁に削除される場合は、クラスターにさらにワーカー・ノードを追加するか、ポッドに[リソース制限![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) を設定します。

メモリー容量はマシン・タイプごとに異なります。 ワーカー・ノードで使用可能なメモリーが最小しきい値より少ない場合、Kubernetes はすぐにポッドを削除します。 別のワーカー・ノードが使用可能である場合、そのポッドはそのワーカー・ノードにスケジュール変更されます。

|ワーカー・ノードのメモリー容量|ワーカー・ノードの最小メモリーしきい値|
|---------------------------|------------|
|4 GB  | 256 MB |
|16 GB | 1024 MB |
|64 GB | 4096 MB |
|128 GB| 4096 MB |
|242 GB| 4096 MB |

ワーカー・ノードで使用されているメモリーの量を調べるには、[kubectl top node ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top) を実行します。



<br />



## GUI でのクラスターの作成
{: #clusters_ui}

Kubernetes クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。 クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。 アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}

クラスターを作成するには、以下のようにします。
1. カタログで、**「Kubernetes クラスター」**を選択します。
2. クラスター・プランのタイプを選択します。 **「ライト」**または**「従量課金 (PAYG)」**のいずれかを選択できます。 「従量課金 (PAYG)」プランの場合、可用性が高い環境に対応した複数のワーカー・ノードなどのフィーチャーを備えた標準クラスターをプロビジョンできます。
3. クラスターの詳細を構成します。
    1. クラスター名を指定し、Kubernetes のバージョンを選択し、デプロイ先のロケーションを選択します。 最高のパフォーマンスを得るために、物理的に最も近いロケーションを選択してください。 国外のロケーションを選択する場合は、その国にデータを物理的に保管する前に法的な許可を得なければならないことがあります。
    2. マシンのタイプを選択し、必要なワーカー・ノードの数を指定します。 各ワーカー・ノードにセットアップされてコンテナーで使用可能になる仮想 CPU とメモリーの量は、マシン・タイプによって決まります。
        - 「マイクロ (micro)」のマシン・タイプは、最小のオプションを表しています。
        - 「分散型 (Balanced)」のマシンは、同じ容量のメモリーが各 CPU に割り当てられるので、パフォーマンスが最適化されます。
        - デフォルトでは、ホストの Docker データはマシン・タイプで暗号化されます。すべてのコンテナー・データが格納される `/var/lib/docker` ディレクトリーは、LUKS 暗号化で暗号化されます。クラスターの作成時に `disable-disk-encrypt` オプションが指定された場合、ホストの Docker データは暗号化されません。[暗号化について詳しくは、こちらをご覧ください。](cs_secure.html#encrypted_disks)
    3. パブリック VLAN とプライベート VLAN を IBM Cloud インフラストラクチャー (SoftLayer) アカウントから選択します。 どちらの VLAN もワーカー・ノード間で通信を行いますが、パブリック VLAN は IBM 管理の Kubernetes マスターとも通信を行います。 複数のクラスターで同じ VLAN を使用できます。
        **注**: パブリック VLAN を選択しないことにした場合、代替ソリューションを構成する必要があります。
    4. ハードウェアのタイプを選択します。 ほとんどの状況では「共有」で十分間に合うはずです。
        - **専用**: お客様の物理リソースを完全に分離します。
        - **共有**: お客様の物理リソースを IBM の他のお客様と同じハードウェア上に保管することを許可します。
4. **「クラスターの作成」**をクリックします。 **「ワーカー・ノード」**タブでワーカー・ノードのデプロイメントの進行状況を確認できます。 デプロイが完了すると、クラスターが**「概要」**タブに準備されていることが分かります。
    **注:** ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはいけません。 ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。


**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

-   [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
-   [クラスターにアプリをデプロイします。](cs_app.html#app_cli)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)
- ファイアウォールがある場合、[必要なポートを開く](cs_firewall.html#firewall)必要が生じることがあります。例えば、コマンド `bx`、`kubectl`、または `calicotl` を使用する場合、クラスターからのアウトバウンド・トラフィックを許可する場合、ネットワーク・サービスのインバウンド・トラフィックを許可する場合などです。

<br />


## CLI でのクラスターの作成
{: #clusters_cli}

クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。 クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。 アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}

クラスターを作成するには、以下のようにします。
1.  {{site.data.keyword.Bluemix_notm}} CLI と [{{site.data.keyword.containershort_notm}} プラグイン](cs_cli_install.html#cs_cli_install)をインストールします。
2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。 プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。

    ```
    bx login
    ```
    {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。 ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。 `--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

3. 複数の {{site.data.keyword.Bluemix_notm}} アカウントがある場合は、Kubernetes クラスターを作成するアカウントを選択します。

4.  前に選択した {{site.data.keyword.Bluemix_notm}} 地域以外の地域で Kubernetes クラスターの作成とアクセスを行う場合は、`bx cs region-set` を実行します。

6.  クラスターを作成します。
    1.  使用可能なロケーションを確認します。 表示される場所は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。

        ```
        bx cs locations
        ```
        {: pre}

        CLI 出力が[コンテナー地域のロケーション](cs_regions.html#locations)に一致します。

    2.  ロケーションを選択して、そのロケーションで使用できるマシン・タイプを確認します。 マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・リソースが決まります。

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  このアカウントの IBM Cloud インフラストラクチャー (SoftLayer) にパブリック VLAN とプライベート VLAN が既に存在しているかどうかを確認します。

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        パブリック VLAN およびプライベート VLAN が既に存在する場合、対応するルーターをメモに取ります。必ず、プライベート VLAN ルーターの先頭は `bcr` (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は `fcr` (フロントエンド・ルーター) になります。 クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。 このサンプル出力では、すべてのルーターに
`02a.dal10` が含まれているため、これらのプライベート VLAN とパブリック VLAN はどの組み合わせでも使用できます。

    4.  `cluster-create` コマンドを実行します。 ライト・クラスター (vCPU 2 つとメモリー 4 GB でセットアップされたワーカー・ノード 1 つ) または標準クラスター (IBM Cloud インフラストラクチャー (SoftLayer) アカウントで選択した数のワーカー・ノード) のいずれかを選択できます。 標準クラスターを作成する場合、デフォルトでは、ワーカー・ノードのディスクは暗号化され、そのハードウェアは IBM の複数のお客様によって共有され、使用時間に応じて課金されます。 </br>標準クラスターの例:

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch> 
        ```
        {: pre}

        ライト・クラスターの例:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>表。 <code>bx cs cluster-create</code> コマンドの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>{{site.data.keyword.Bluemix_notm}} 組織内にクラスターを作成するためのコマンド。</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td><em>&lt;location&gt;</em> を、クラスターを作成する {{site.data.keyword.Bluemix_notm}} 場所の ID に置き換えます。 [使用可能なロケーション](cs_regions.html#locations)は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>標準クラスターを作成する場合、マシン・タイプを選択します。マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・リソースが決まります。 詳しくは、[{{site.data.keyword.containershort_notm}} のライト・クラスターと標準クラスターの比較](cs_why.html#cluster_types)を参照してください。 ライト・クラスターの場合、マシン・タイプを定義する必要はありません。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>ライト・クラスターの場合、パブリック VLAN を定義する必要がありません。 ライト・クラスターは IBM 所有のパブリック VLAN に自動的に接続されます。</li>
          <li>標準クラスターの場合、IBM Cloud インフラストラクチャー (SoftLayer) アカウントでそのロケーション用にパブリック VLAN を既にセットアップしている場合には、そのパブリック VLAN の ID を入力します。 ご使用のアカウントでパブリック VLAN もプライベート VLAN もない場合は、このオプションを指定しないでください。 {{site.data.keyword.containershort_notm}} が自動的にパブリック VLAN を作成します。<br/><br/>
          <strong>注</strong>: プライベート VLAN ルーターは常に先頭が <code>bcr</code> (バックエンド・ルーター) となり、パブリック VLAN ルーターは常に先頭が <code>fcr</code> (フロントエンド・ルーター) となります。 クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>ライト・クラスターの場合、プライベート VLAN を定義する必要はありません。 ライト・クラスターは IBM 所有のプライベート VLAN に自動的に接続されます。</li><li>標準クラスターの場合、IBM Cloud インフラストラクチャー (SoftLayer) アカウントでそのロケーション用にプライベート VLAN を既にセットアップしている場合には、そのプライベート VLAN の ID を入力します。 ご使用のアカウントでパブリック VLAN もプライベート VLAN もない場合は、このオプションを指定しないでください。 {{site.data.keyword.containershort_notm}} が自動的にパブリック VLAN を作成します。<br/><br/><strong>注</strong>: プライベート VLAN ルーターは常に先頭が <code>bcr</code> (バックエンド・ルーター) となり、パブリック VLAN ルーターは常に先頭が <code>fcr</code> (フロントエンド・ルーター) となります。 クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td><em>&lt;name&gt;</em> をクラスターの名前に置き換えます。</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>クラスターに含めるワーカー・ノードの数。<code>--workers</code> オプションが指定されていない場合は、ワーカー・ノードが 1 つ作成されます。</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>クラスター・マスター・ノードの Kubernetes のバージョン。 この値はオプションです。 これを指定しなかった場合、クラスターは、サポートされている Kubernetes のバージョンのデフォルトを使用して作成されます。 使用可能なバージョンを確認するには、<code>bx cs kube-versions</code> を実行します。</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>ワーカー・ノードには、デフォルトでディスク暗号化の機能があります。[詳しくはこちらを参照してください](cs_secure.html#encrypted_disks)。 暗号化を無効にする場合は、このオプションを組み込みます。</td>
        </tr>
        </tbody></table>

7.  クラスターの作成が要求されたことを確認します。

    ```
    bx cs clusters
    ```
    {: pre}

    **注:** ワーカー・ノード・マシンが配列され、クラスターがセットアップされて自分のアカウントにプロビジョンされるまでに、最大 15 分かかります。

    クラスターのプロビジョニングが完了すると、クラスターの状況が **deployed** に変わります。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

8.  ワーカー・ノードの状況を確認します。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    ワーカー・ノードの準備が完了すると、状態が **normal** に変わり、状況が **Ready** になります。 ノードの状況が**「Ready」**になったら、クラスターにアクセスできます。

    **注:** ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはなりません。 ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. 作成したクラスターを、このセッションのコンテキストとして設定します。 次の構成手順は、クラスターの操作時に毎回行ってください。
    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        構成ファイルのダウンロードが完了すると、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。

        OS X の場合の例:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。
    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。

        OS X の場合の例:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        出力:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

10. デフォルトのポート `8001` で Kubernetes ダッシュボードを起動します。
    1.  デフォルトのポート番号でプロキシーを設定します。

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Web ブラウザーで以下の URL を開いて、Kubernetes ダッシュボードを表示します。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**次の作業**

-   [クラスターにアプリをデプロイします。](cs_app.html#app_cli)
-   [`kubectl` コマンド・ラインを使用してクラスターを管理します。![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)
- ファイアウォールがある場合、[必要なポートを開く](cs_firewall.html#firewall)必要が生じることがあります。例えば、コマンド `bx`、`kubectl`、または `calicotl` を使用する場合、クラスターからのアウトバウンド・トラフィックを許可する場合、ネットワーク・サービスのインバウンド・トラフィックを許可する場合などです。

<br />


## クラスターの状態
{: #states}

現在のクラスターの状態を確認するには、`bx cs clusters` コマンドを実行して **State** フィールドを見つけます。クラスターの状態から、クラスターの可用性と容量、発生した可能性のある問題についての情報が得られます。
{:shortdesc}

|クラスターの状態|理由|
|-------------|------|
|Deploying|Kubernetes マスターがまだ完全にデプロイされていません。クラスターにアクセスできません。|
|Pending|Kubernetes マスターはデプロイされています。 ワーカー・ノードはプロビジョン中であるため、まだクラスターでは使用できません。 クラスターにはアクセスできますが、アプリをクラスターにデプロイすることはできません。|
|Normal|クラスター内のすべてのワーカー・ノードが稼働中です。 クラスターにアクセスし、アプリをクラスターにデプロイできます。|
|Warning|クラスター内の 1 つ以上のワーカー・ノードが使用不可です。ただし、他のワーカー・ノードが使用可能であるため、ワークロードを引き継ぐことができます。 <ol><li>クラスター内のワーカー・ノードをリストして、<strong>Warning</strong> 状態のワーカー・ノードの ID をメモします。<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>ワーカー・ノードの詳細を取得します。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li><strong>「State」</strong>、<strong>「Status」</strong>、<strong>「Details」</strong>フィールドを参照して、ワーカー・ノードがダウンした根本問題を調べます。</li><li>ワーカー・ノードのメモリーやディスク・スペースが上限に近付いている場合は、ワーカー・ノードのワークロードを減らすか、ワークロードを分散できるようにクラスターにワーカー・ノードを追加してください。</li></ol>|
|Critical|Kubernetes マスターにアクセスできないか、クラスター内のワーカー・ノードがすべてダウンしています。 <ol><li>クラスター内のワーカー・ノードをリストします。<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>各ワーカー・ノードの詳細を取得します。<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li><strong>「State」</strong>および<strong>「Status」</strong>フィールドを参照して、ワーカー・ノードがダウンした根本問題を調べます。<ul><li>ワーカー・ノードの状態が <strong>Provision_failed</strong> の場合は、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオからワーカー・ノードをプロビジョンするために必要なアクセス権限がない可能性があります。 必要なアクセス権限については、[IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオへのアクセス権限を構成して標準の Kubernetes クラスターを作成する](cs_infrastructure.html#unify_accounts)を参照してください。</li><li>ワーカー・ノードの状態が <strong>Critical</strong> で状況が <strong>Not Ready</strong> である場合、ワーカー・ノードが IBM Cloud インフラストラクチャー (SoftLayer) に接続できない可能性があります。 まず <code>bx cs worker-reboot --hard CLUSTER WORKER</code> を実行して、トラブルシューティングを開始してください。 そのコマンドが失敗する場合は、<code>bx cs worker reload CLUSTER WORKER</code> を実行してください。</li><li>状態が <strong>Critical</strong> で、ワーカー・ノードの状況が <strong>Out of disk</strong> である場合は、ワーカー・ノードの容量が使い尽くされています。 ワーカー・ノードのワークロードを減らすか、またはワークロードを分散できるようにクラスターにワーカー・ノードを追加してください。</li><li>状態が <strong>Critical</strong> で、ワーカー・ノードの状況が <strong>Unknown</strong> である場合、Kubernetes マスターは使用不可です。 [{{site.data.keyword.Bluemix_notm}} サポート・チケット](/docs/support/index.html#getting-help)を開いて、{{site.data.keyword.Bluemix_notm}} サポートに連絡してください。</li></ul></li></ol>|
{: caption="表。 クラスターの状態" caption-side="top"}

<br />


## クラスターの削除
{: #remove}

クラスターの使用を終了したとき、クラスターがリソースを消費しないように削除することができます。
{:shortdesc}

従量課金 (PAYG) アカウントで作成したライト・クラスターと標準クラスターが不要になった場合は、ユーザーが手動で削除する必要があります。

クラスターを削除すると、コンテナー、ポッド、バインド済みサービス、シークレットなど、クラスター上のリソースも削除されます。 クラスターを削除するときにストレージを削除しない場合は、{{site.data.keyword.Bluemix_notm}} GUI 内の IBM Cloud インフラストラクチャー (SoftLayer) ダッシュボードを使用してストレージを削除できます。 毎月の課金サイクルの規定で、永続ボリューム請求を月の最終日に削除することはできません。 永続ボリューム請求を月の末日に削除した場合、削除は翌月初めまで保留状態になります。

**警告:** 永続ストレージ内のクラスターやデータのバックアップは作成されません。 クラスターを削除すると永久に削除されます。元に戻すことはできません。

-   {{site.data.keyword.Bluemix_notm}} GUI から
    1.  クラスターを選択して、**「その他のアクション...」**メニューから**「削除」**をクリックします。
-   {{site.data.keyword.Bluemix_notm}} CLI から
    1.  使用可能なクラスターをリストします。

        ```
        bx cs clusters
        ```
        {: pre}

    2.  クラスターを削除します。

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  プロンプトに従って、クラスター・リソースを削除するかどうかを選択してください。

クラスターを削除するときに、ポータブル・サブネットとそれに関連付けられている永続ストレージを削除することができます。
- サブネットは、ポータブル・パブリック IP アドレスをロード・バランサー・サービスまたは Ingress コントローラーに割り当てるときに使用されます。 これらのサブネットを保持していれば、新しいクラスターで再利用したり、後で IBM Cloud インフラストラクチャー (SoftLayer) のポートフォリオから手動で削除したりすることができます。
- [既存のファイル共有](cs_storage.html#existing)を使用して永続ボリューム請求を作成した場合は、クラスターを削除するときにファイル共有を削除できません。このファイル共有は後で IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオから手動で削除する必要があります。
- 永続ストレージは、データの高可用性を提供します。 これを削除した場合は、データをリカバリーできません。
