---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# クラスターのセットアップ
{: #cs_cluster}

可用性と能力が最大になるようにクラスターのセットアップを設計します。
{:shortdesc}

次の図に、一般的なクラスター構成を、可用性が低いものから順に示します。

![クラスターの高可用性の段階](images/cs_cluster_ha_roadmap.png)

図に示すように、複数のワーカー・ノードにアプリをデプロイすると、アプリの可用性が向上します。複数のクラスターにアプリをデプロイすると、可用性をさらに高めることができます。最高度の可用性を得るには、アプリを別の地域のクラスターにデプロイします。詳しくは、[高可用性クラスター構成のオプション](cs_planning.html#cs_planning_cluster_config)を確認してください。

<br />


## GUI でのクラスターの作成
{: #cs_cluster_ui}

Kubernetes クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}
{{site.data.keyword.Bluemix_dedicated_notm}} ユーザーの場合は、代わりに [{{site.data.keyword.Bluemix_dedicated_notm}} (最終ベータ版) における GUI からの Kubernetes クラスターの作成](#creating_ui_dedicated)を参照してください。

クラスターを作成するには、以下のようにします。
1. カタログで、**「Kubernetes クラスター」**を選択します。
2. クラスター・プランのタイプを選択します。**「ライト」**または**「従量課金 (PAYG)」**のいずれかを選択できます。「従量課金 (PAYG)」プランの場合、可用性が高い環境に対応した複数のワーカー・ノードなどのフィーチャーを備えた標準クラスターをプロビジョンできます。
3. クラスターの詳細を構成します。
    1. クラスター名を指定し、Kubernetes のバージョンを選択し、デプロイ先のロケーションを選択します。最高のパフォーマンスを得るために、物理的に最も近いロケーションを選択してください。国外のロケーションを選択する場合は、その国にデータを物理的に保管する前に法的な許可を得なければならないことがあります。
    2. マシンのタイプを選択し、必要なワーカー・ノードの数を指定します。各ワーカー・ノードにセットアップされてコンテナーで使用可能になる仮想 CPU とメモリーの量は、マシン・タイプによって決まります。
        - 「マイクロ (micro)」のマシン・タイプは、最小のオプションを表しています。
        - 「分散型 (Balanced)」のマシンは、同じ容量のメモリーが各 CPU に割り当てられるので、パフォーマンスが最適化されます。
    3. パブリック VLAN とプライベート VLAN を IBM Cloud インフラストラクチャー (SoftLayer) アカウントから選択します。どちらの VLAN もワーカー・ノード間で通信を行いますが、パブリック VLAN は IBM 管理の Kubernetes マスターとも通信を行います。複数のクラスターで同じ VLAN を使用できます。
        **注**: パブリック VLAN を選択しないことにした場合、代替ソリューションを構成する必要があります。
    4. ハードウェアのタイプを選択します。ほとんどの状況では「共有」で十分間に合うはずです。
        - **専用**: お客様の物理リソースを完全に分離します。
        - **共有**: お客様の物理リソースを IBM の他のお客様と同じハードウェア上に保管することを許可します。
4. **「クラスターの作成」**をクリックします。**「ワーカー・ノード」**タブでワーカー・ノードのデプロイメントの進行状況を確認できます。デプロイが完了すると、クラスターが**「概要」**タブに準備されていることが分かります。
    **注:** ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはいけません。ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。


**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

-   [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
-   [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)


### {{site.data.keyword.Bluemix_dedicated_notm}} (最終ベータ版) における GUI によるクラスターの作成
{: #creating_ui_dedicated}

1.  IBMid を使用して {{site.data.keyword.Bluemix_notm}} Public コンソール ([https://console.bluemix.net ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net)) にログインします。
2.  アカウント・メニューから、{{site.data.keyword.Bluemix_dedicated_notm}} アカウントを選択します。コンソールが更新されて、ご使用の {{site.data.keyword.Bluemix_dedicated_notm}} インスタンスに関するサービスと情報が表示されます。
3.  カタログから**「コンテナー」**を選択して、**「Kubernetes クラスター」**をクリックします。

4.  **クラスター名**を入力します。
5.  **マシン・タイプ**を選択します。各ワーカー・ノードにセットアップされる (ノードにデプロイされるすべてのコンテナーで使用できる) 仮想 CPU とメモリーの量は、マシン・タイプによって決まります。
    -   「マイクロ (micro)」のマシン・タイプは、最小のオプションを表しています。
    -   「分散型 (Balanced)」のマシン・タイプは、同じ容量のメモリーが各 CPU に割り当てられるので、パフォーマンスが最適化されます。

6.  必要な**ワーカー・ノードの数**を選択します。`3` を選択して、クラスターの高可用性を確保します。

7.  **「クラスターの作成」**をクリックします。クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。**「ワーカー・ノード (Worker nodes)」**タブで、ワーカー・ノードのデプロイメントの進行状況を確認できます。ワーカー・ノードの準備が完了すると、状態が **Ready** に変わります。

**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

-   [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
-   [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)

<br />


## CLI でのクラスターの作成
{: #cs_cluster_cli}

クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}

{{site.data.keyword.Bluemix_dedicated_notm}} ユーザーの場合は、代わりに [{{site.data.keyword.Bluemix_dedicated_notm}} (最終ベータ版) における CLI からの Kubernetes クラスターの作成](#creating_cli_dedicated)を参照してください。

クラスターを作成するには、以下のようにします。
1.  {{site.data.keyword.Bluemix_notm}} CLI と [{{site.data.keyword.containershort_notm}} プラグイン](cs_cli_install.html#cs_cli_install)をインストールします。
2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。
{{site.data.keyword.Bluemix_notm}} 地域を指定するには、[API エンドポイントを含めます](cs_regions.html#bluemix_regions)。

    ```
bx login```
    {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

3. 複数の {{site.data.keyword.Bluemix_notm}} アカウントがある場合は、Kubernetes クラスターを作成するアカウントを選択します。

4.  前に選択した {{site.data.keyword.Bluemix_notm}} 地域以外の地域で Kubernetes クラスターを作成したり、そうしたクラスターにアクセスしたりする場合、[{{site.data.keyword.containershort_notm}} 地域の API エンドポイントを指定します](cs_regions.html#container_login_endpoints)。

    **注**: 米国東部でクラスターを作成する場合、`bx cs init --host https://us-east.containers.bluemix.net` コマンドを使用して、米国東部コンテナー地域の API エンドポイントを指定する必要があります。

6.  クラスターを作成します。
    1.  使用可能なロケーションを確認します。表示される場所は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。

        ```
  bx cs locations
  ```
        {: pre}

        CLI 出力が[コンテナー地域のロケーション](cs_regions.html#locations)に一致します。

    2.  ロケーションを選択して、そのロケーションで使用できるマシン・タイプを確認します。マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・リソースが決まります。


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

        パブリック VLAN およびプライベート VLAN が既に存在する場合、対応するルーターをメモに取ります。必ず、プライベート VLAN ルーターの先頭は `bcr` (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は `fcr` (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
このサンプル出力では、すべてのルーターに
`02a.dal10` が含まれているため、これらのプライベート VLAN とパブリック VLAN はどの組み合わせでも使用できます。

    4.  `cluster-create` コマンドを実行します。ライト・クラスター (vCPU 2 つとメモリー 4 GB でセットアップされたワーカー・ノード 1 つ) または標準クラスター (IBM Cloud インフラストラクチャー (SoftLayer) アカウントで選択した数のワーカー・ノード) のいずれかを選択できます。標準クラスターを作成する場合、デフォルトでは、ワーカー・ノードのハードウェアは IBM の複数のお客様によって共有され、使用時間に応じて課金されます。</br>標準クラスターの例:
  

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
        <caption>表 1. <code>bx cs cluster-create</code> コマンドの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>{{site.data.keyword.Bluemix_notm}} 組織内にクラスターを作成するためのコマンド。
</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td><em>&lt;location&gt;</em> を、クラスターを作成する {{site.data.keyword.Bluemix_notm}} 場所の ID に置き換えます。[使用可能なロケーション](cs_regions.html#locations)は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>標準クラスターを作成する場合、マシン・タイプを選択します。マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・リソースが決まります。
詳しくは、[{{site.data.keyword.containershort_notm}} のライト・クラスターと標準クラスターの比較](cs_planning.html#cs_planning_cluster_type)を参照してください。ライト・クラスターの場合、マシン・タイプを定義する必要はありません。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>ライト・クラスターの場合、パブリック VLAN を定義する必要がありません。ライト・クラスターは IBM 所有のパブリック VLAN に自動的に接続されます。</li>
          <li>標準クラスターの場合、IBM Cloud インフラストラクチャー (SoftLayer) アカウントでそのロケーション用にパブリック VLAN を既にセットアップしている場合には、そのパブリック VLAN の ID を入力します。ご使用のアカウントでパブリック VLAN もプライベート VLAN もない場合は、このオプションを指定しないでください。{{site.data.keyword.containershort_notm}} が自動的にパブリック VLAN を作成します。<br/><br/>
          <strong>注</strong>: プライベート VLAN ルーターは常に先頭が <code>bcr</code> (バックエンド・ルーター) となり、パブリック VLAN ルーターは常に先頭が <code>fcr</code> (フロントエンド・ルーター) となります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>ライト・クラスターの場合、プライベート VLAN を定義する必要はありません。ライト・クラスターは IBM 所有のプライベート VLAN に自動的に接続されます。</li><li>標準クラスターの場合、IBM Cloud インフラストラクチャー (SoftLayer) アカウントでそのロケーション用にプライベート VLAN を既にセットアップしている場合には、そのプライベート VLAN の ID を入力します。ご使用のアカウントでパブリック VLAN もプライベート VLAN もない場合は、このオプションを指定しないでください。{{site.data.keyword.containershort_notm}} が自動的にパブリック VLAN を作成します。<br/><br/><strong>注</strong>: プライベート VLAN ルーターは常に先頭が <code>bcr</code> (バックエンド・ルーター) となり、パブリック VLAN ルーターは常に先頭が <code>fcr</code> (フロントエンド・ルーター) となります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
</li></ul></td>
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
          <td>クラスター・マスター・ノードの Kubernetes のバージョン。この値はオプションです。

これを指定しなかった場合、クラスターは、サポートされている Kubernetes のバージョンのデフォルトを使用して作成されます。使用可能なバージョンを確認するには、<code>bx cs kube-versions</code> を実行します。</td>
        </tr>
        </tbody></table>

7.  クラスターの作成が要求されたことを確認します。

    ```
bx cs clusters```
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

    ワーカー・ノードの準備が完了すると、状態が **normal** に変わり、状況が **Ready** になります。ノードの状況が**「Ready」**になったら、クラスターにアクセスできます。


    **注:** ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはなりません。ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. 作成したクラスターを、このセッションのコンテキストとして設定します。次の構成手順は、クラスターの操作時に毎回行ってください。

    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。


        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        構成ファイルのダウンロードが完了すると、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。


        OS X の場合の例:


        ```
export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml```
        {: screen}

    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。

    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。


        OS X の場合の例:


        ```
echo $KUBECONFIG```
        {: pre}

        出力:


        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        
        ```
        {: screen}

10. デフォルトのポート `8001` で Kubernetes ダッシュボードを起動します。
    1.  デフォルトのポート番号でプロキシーを設定します。

        ```
kubectl proxy```
        {: pre}

        ```
Starting to serve on 127.0.0.1:8001```
        {: screen}

    2.  Web ブラウザーで以下の URL を開いて、Kubernetes ダッシュボードを表示します。


        ```
http://localhost:8001/ui```
        {: codeblock}


**次の作業**

-   [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
-   [`kubectl` コマンド・ラインを使用してクラスターを管理します。![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)

### {{site.data.keyword.Bluemix_dedicated_notm}} (最終ベータ版) における CLI によるクラスターの作成
{: #creating_cli_dedicated}

1.  {{site.data.keyword.Bluemix_notm}} CLI と [{{site.data.keyword.containershort_notm}} プラグイン](cs_cli_install.html#cs_cli_install)をインストールします。
2.  {{site.data.keyword.containershort_notm}} のパブリック・エンドポイントにログインします。{{site.data.keyword.Bluemix_notm}} 資格情報を入力し、プロンプトが出されたら、{{site.data.keyword.Bluemix_dedicated_notm}} アカウントを選択します。

    ```
    bx login -a api.<region>.bluemix.net
    ```
    {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

3.  `cluster-create` コマンドを使用してクラスターを作成します。標準クラスターを作成する場合、ワーカー・ノードのハードウェアは、使用時間に応じて課金されます。

    例:

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>表 2. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>{{site.data.keyword.Bluemix_notm}} 組織内にクラスターを作成するためのコマンド。
</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>&lt;location&gt; を、クラスターを作成する {{site.data.keyword.Bluemix_notm}} 場所の ID に置き換えます。[使用可能なロケーション](cs_regions.html#locations)は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>標準クラスターを作成する場合、マシン・タイプを選択します。マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・リソースが決まります。
詳しくは、[{{site.data.keyword.containershort_notm}} のライト・クラスターと標準クラスターの比較](cs_planning.html#cs_planning_cluster_type)を参照してください。ライト・クラスターの場合、マシン・タイプを定義する必要はありません。</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td><em>&lt;name&gt;</em> をクラスターの名前に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>クラスターに含めるワーカー・ノードの数。<code>--workers</code> オプションが指定されていない場合は、ワーカー・ノードが 1 つ作成されます。</td>
    </tr>
    </tbody></table>

4.  クラスターの作成が要求されたことを確認します。

    ```
bx cs clusters```
    {: pre}

    **注:** ワーカー・ノード・マシンが配列され、クラスターがセットアップされて自分のアカウントにプロビジョンされるまでに、最大 15 分かかります。

    クラスターのプロビジョニングが完了すると、クラスターの状態が **deployed** に変わります。

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1   
    ```
    {: screen}

5.  ワーカー・ノードの状況を確認します。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    ワーカー・ノードの準備が完了すると、状態が **normal** に変わり、状況が **Ready** になります。ノードの状況が**「Ready」**になったら、クラスターにアクセスできます。


    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  作成したクラスターを、このセッションのコンテキストとして設定します。次の構成手順は、クラスターの操作時に毎回行ってください。


    1.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。


        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        構成ファイルのダウンロードが完了すると、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。


        OS X の場合の例:


        ```
export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml```
        {: screen}

    2.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。

    3.  `KUBECONFIG` 環境変数が適切に設定されたことを確認します。


        OS X の場合の例:


        ```
echo $KUBECONFIG```
        {: pre}

        出力:


        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        
        ```
        {: screen}

7.  デフォルトのポート 8001 で Kubernetes ダッシュボードにアクセスします。

    1.  デフォルトのポート番号でプロキシーを設定します。

        ```
kubectl proxy```
        {: pre}

        ```
Starting to serve on 127.0.0.1:8001```
        {: screen}

    2.  Web ブラウザーで以下の URL を開いて、Kubernetes ダッシュボードを確認します。


        ```
http://localhost:8001/ui```
        {: codeblock}


**次の作業**

-   [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
-   [`kubectl` コマンド・ラインを使用してクラスターを管理します。![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)

<br />


## プライベートとパブリックのイメージ・レジストリーの使用
{: #cs_apps_images}

Docker イメージは、作成するすべてのコンテナーの基礎となるものです。イメージは、Dockerfile (イメージをビルドするための指示が入ったファイル) から作成されます。Dockerfile の別個に保管されている指示の中で、ビルド成果物 (アプリ、アプリの構成、その従属関係) が参照されることもあります。イメージは通常、レジストリーに保管されます。だれでもアクセスできるレジストリー (パブリック・レジストリー) を使用することも、小さなグループのユーザーだけにアクセスを限定したレジストリー (プライベート・レジストリー) をセットアップすることもできます。
{:shortdesc}

イメージ・レジストリーのセットアップ方法やレジストリー内のイメージの使用方法については、以下のオプションがあります。

-   [IBM 提供のイメージや独自のプライベート Docker イメージを処理するために {{site.data.keyword.registryshort_notm}} の名前空間にアクセスする](#bx_registry_default)
-   [Docker Hub 内のパブリック・イメージへのアクセス](#dockerhub).
-   [他のプライベート・レジストリー内に保管されているプライベート・イメージへのアクセス](#private_registry)

### IBM 提供のイメージや独自のプライベート Docker イメージを処理するために {{site.data.keyword.registryshort_notm}} の名前空間にアクセスする
{: #bx_registry_default}

{{site.data.keyword.registryshort_notm}} 内の名前空間に保管されている IBM 提供のパブリック・イメージやプライベート・イメージからクラスターにコンテナーをデプロイできます。

開始前に、以下のことを行います。

1. [{{site.data.keyword.Bluemix_notm}} Public または {{site.data.keyword.Bluemix_dedicated_notm}} の {{site.data.keyword.registryshort_notm}} に名前空間をセットアップし、その名前空間にイメージをプッシュします](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2. [クラスターを作成します](#cs_cluster_cli)。
3. [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

クラスターを作成すると、有効期限のないレジストリー・トークンがそのクラスターに対して自動的に作成されます。このトークンは、{{site.data.keyword.registryshort_notm}} 内にセットアップした名前空間への読み取り専用アクセスを許可するために使用されるもので、これにより、IBM 提供のパブリック・イメージや独自のプライベート Docker イメージの処理が可能になります。コンテナー化アプリのデプロイ時に Kubernetes クラスターがトークンにアクセスできるように、トークンは Kubernetes の `imagePullSecret` 内に保管されている必要があります。クラスターが作成されると、{{site.data.keyword.containershort_notm}} によりこのトークンが Kubernetes `imagePullSecret` 内に自動的に保管されます。 `imagePullSecret` は、デフォルトの Kubernetes 名前空間、その名前空間の ServiceAccount 内のシークレットのデフォルト・リスト、kube-system 名前空間に追加されます。

**注:** この初期セットアップを使用すると、{{site.data.keyword.Bluemix_notm}} アカウントの名前空間にある任意のイメージのコンテナーを、クラスターの **default** 名前空間にデプロイできます。クラスター内のその他の名前空間内にコンテナーをデプロイする場合や、別の {{site.data.keyword.Bluemix_notm}} 地域か別の {{site.data.keyword.Bluemix_notm}} アカウントに保管されているイメージを使用する場合は、その[クラスター用に独自の imagePullSecret を作成](#bx_registry_other)しなければなりません。

コンテナーをクラスターの **default** 名前空間にデプロイするために、構成ファイルを作成します。

1.  `mydeployment.yaml` という名前のデプロイメント構成ファイルを作成します。
2.  デプロイメントと、{{site.data.keyword.registryshort_notm}}内の名前空間にある、使用するイメージを定義します。

    {{site.data.keyword.registryshort_notm}}内の名前空間にあるプライベート・イメージを使用するには、次のようにします。


    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **ヒント:** 名前空間の情報を取得するには、`bx cr namespace-list` を実行します。

3.  クラスター内にデプロイメントを作成します。

    ```
kubectl apply -f mydeployment.yaml```
    {: pre}

    **ヒント:** IBM 提供のパブリック・イメージなど、既存の構成ファイルをデプロイすることもできます。この例では、米国南部地域の **ibmliberty** イメージを使用しています。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### 他の Kubernetes 名前空間へのイメージのデプロイまたは他の {{site.data.keyword.Bluemix_notm}} 地域やアカウント内のイメージへのアクセス
{: #bx_registry_other}

独自の imagePullSecret を作成すれば、他の Kubernetes 名前空間にコンテナーをデプロイしたり、他の {{site.data.keyword.Bluemix_notm}} 地域やアカウント内に保管されているイメージを使用したり、{{site.data.keyword.Bluemix_dedicated_notm}} 内に保管されているイメージを使用したりできます。

開始前に、以下のことを行います。

1.  [{{site.data.keyword.Bluemix_notm}} Public または {{site.data.keyword.Bluemix_dedicated_notm}} の {{site.data.keyword.registryshort_notm}} に名前空間をセットアップし、その名前空間にイメージをプッシュします](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
2.  [クラスターを作成します](#cs_cluster_cli)。
3.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

独自の imagePullSecret を作成するには、以下のようにします。

**注:** ImagePullSecrets は、それらが作成された Kubernetes 名前空間に対してのみ有効です。コンテナーをデプロイする名前空間ごとに、以下の手順を繰り返してください。[DockerHub](#dockerhub) のイメージの場合は ImagePullSecrets は必要ありません。

1.  トークンがない場合は、[アクセスするレジストリーのトークンを作成します。](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  {{site.data.keyword.Bluemix_notm}} アカウント内のトークンのリストを表示します。

    ```
bx cr token-list```
    {: pre}

3.  使用するトークン ID をメモします。
4.  トークンの値を取得します。<em>&lt;token_id&gt;</em> を、前のステップで取得したトークンの ID に置き換えます。


    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    CLI 出力の **Token** フィールドに、トークン値が表示されます。

5.  トークン情報を保管する Kubernetes シークレットを作成します。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表 3. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必須。シークレットを使用してコンテナーをデプロイする、クラスターの Kubernetes 名前空間。クラスター内の名前空間をすべてリストするには、<code>kubectl get namespaces</code> を実行します。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必須。imagePullSecret に使用する名前。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必須。名前空間をセットアップするイメージ・レジストリーの URL。<ul><li>米国南部と米国東部でセットアップした名前空間の場合: registry.ng.bluemix.net</li><li>英国南部でセットアップした名前空間の場合: registry.eu-gb.bluemix.net</li><li>中欧 (フランクフルト) でセットアップした名前空間の場合: registry.eu-de.bluemix.net</li><li>オーストラリア (シドニー) でセットアップした名前空間の場合: registry.au-syd.bluemix.net</li><li>{{site.data.keyword.Bluemix_dedicated_notm}} でセットアップした名前空間の場合: registry.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必須。プライベート・レジストリーにログインするためのユーザー名。{{site.data.keyword.registryshort_notm}} の場合、ユーザー名は <code>token</code> に設定されます。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必須。以前に取得したレジストリー・トークンの値。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必須。Docker E メール・アドレスがある場合は、その値を入力します。ない場合は、例えば a@b.c のような架空の E メール・アドレスを入力します。この E メールは、Kubernetes シークレットを作成する際には必須ですが、作成後は使用されません。</td>
    </tr>
    </tbody></table>

6.  シークレットが正常に作成されたことを確認します。<em>&lt;kubernetes_namespace&gt;</em> を、imagePullSecret を作成した名前空間の名前に置き換えます。


    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  imagePullSecret を参照するポッドを作成します。
    1.  `mypod.yaml` という名前のポッド構成ファイルを作成します。
    2.  ポッドと、プライベート
{{site.data.keyword.Bluemix_notm}} レジストリーへのアクセスに使用する imagePullSecret を定義します。

        名前空間のプライベート・イメージ:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        {{site.data.keyword.Bluemix_notm}} パブリック・イメージ:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表 4. YAML ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>クラスターにデプロイするコンテナーの名前。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>イメージが保管されている名前空間。使用可能な名前空間をリストするには、`bx cr namespace-list` を実行します。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>使用するイメージの名前。{{site.data.keyword.Bluemix_notm}} アカウント内の使用可能なイメージをリストするには、`bx cr image-list` を実行します。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>使用するイメージのバージョン。タグを指定しないと、デフォルトでは <strong>latest</strong> のタグが付いたイメージが使用されます。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>以前に作成した imagePullSecret の名前。</td>
        </tr>
        </tbody></table>

   3.  変更を保存します。
   4.  クラスター内にデプロイメントを作成します。

        ```
kubectl apply -f mypod.yaml```
        {: pre}


### Docker Hub 内のパブリック・イメージへのアクセス
{: #dockerhub}

Docker Hub 内に保管されているパブリック・イメージを使用すれば、追加の構成を行わずにコンテナーをクラスターにデプロイできます。

開始前に、以下のことを行います。

1.  [クラスターを作成します](#cs_cluster_cli)。
2.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

デプロイメント構成ファイルを作成します。

1.  `mydeployment.yaml` という名前の構成ファイルを作成します。
2.  デプロイメントと、Docker Hub 内の使用するパブリック・イメージを定義します。以下の構成ファイルでは、Docker Hub にある使用可能パブリック・イメージ NGINX が使用されています。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  クラスター内にデプロイメントを作成します。

    ```
kubectl apply -f mydeployment.yaml```
    {: pre}

    **ヒント:** 代わりに、既存の構成ファイルをデプロイすることもできます。以下の例では同じパブリック NGINX イメージを使用しますが、クラスターに直接適用しています。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### 他のプライベート・レジストリー内に保管されているプライベート・イメージへのアクセス
{: #private_registry}

既存のプライベート・レジストリーを使用する場合は、そのレジストリーの資格情報を Kubernetes imagePullSecret に保管し、構成ファイル内でこのシークレットを参照する必要があります。

開始前に、以下のことを行います。

1.  [クラスターを作成します](#cs_cluster_cli)。
2.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

imagePullSecret を作成するには、以下のようにします。

**注:** ImagePullSecrets は、それらが作成された対象の Kubernetes 名前空間に対して有効となります。プライベート {{site.data.keyword.Bluemix_notm}} レジストリー内のイメージからコンテナーをデプロイする名前空間ごとに、以下の手順を繰り返してください。

1.  プライベート・レジストリーの資格情報を保管する Kubernetes シークレットを作成します。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>表 5. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>必須。シークレットを使用してコンテナーをデプロイする、クラスターの Kubernetes 名前空間。クラスター内の名前空間をすべてリストするには、<code>kubectl get namespaces</code> を実行します。</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>必須。imagePullSecret に使用する名前。</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>必須。プライベート・イメージが保管されているレジストリーの URL。</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>必須。プライベート・レジストリーにログインするためのユーザー名。</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>必須。以前に取得したレジストリー・トークンの値。</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>必須。Docker E メール・アドレスがある場合は、その値を入力します。ない場合は、例えば a@b.c のような架空の E メール・アドレスを入力します。この E メールは、Kubernetes シークレットを作成する際には必須ですが、作成後は使用されません。</td>
    </tr>
    </tbody></table>

2.  シークレットが正常に作成されたことを確認します。<em>&lt;kubernetes_namespace&gt;</em> を、imagePullSecret を作成した名前空間の名前に置き換えます。


    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  imagePullSecret を参照するポッドを作成します。
    1.  `mypod.yaml` という名前のポッド構成ファイルを作成します。
    2.  ポッドと、プライベート
{{site.data.keyword.Bluemix_notm}} レジストリーへのアクセスに使用する imagePullSecret を定義します。プライベート・レジストリー内のプライベート・イメージを使用するには、次のようにします。


        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>表 6. YAML ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>作成するポッドの名前。</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>クラスターにデプロイするコンテナーの名前。</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>プライベート・レジストリー内の使用するイメージへのフルパス。</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>使用するイメージのバージョン。タグを指定しないと、デフォルトでは <strong>latest</strong> のタグが付いたイメージが使用されます。</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>以前に作成した imagePullSecret の名前。</td>
        </tr>
        </tbody></table>

  3.  変更を保存します。
  4.  クラスター内にデプロイメントを作成します。

        ```
kubectl apply -f mypod.yaml```
        {: pre}

<br />


## {{site.data.keyword.Bluemix_notm}} サービスをクラスターに追加する
{: #cs_cluster_service}

既存の {{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターに追加すると、クラスターのユーザーがアプリをクラスターにデプロイする際にその {{site.data.keyword.Bluemix_notm}} サービスにアクセスして使用できるようになります。
{:shortdesc}

開始前に、以下のことを行います。

1. [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

2. [{{site.data.keyword.Bluemix_notm}} サービスのインスタンスを要求](/docs/manageapps/reqnsi.html#req_instance)します。
   **注:** ワシントン DC のロケーションでサービスのインスタンスを作成するには、CLI を使用する必要があります。
3. {{site.data.keyword.Bluemix_dedicated_notm}} ユーザーの場合は、代わりに [{{site.data.keyword.Bluemix_dedicated_notm}} (最終ベータ版) のクラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加する](#binding_dedicated)を参照してください。

**注:**
<ul><ul>
<li>サービス・キーをサポートする {{site.data.keyword.Bluemix_notm}} サービスだけを追加できます。このサービスでサービス・キーがサポートされていない場合は、[{{site.data.keyword.Bluemix_notm}} サービスを使用するための外部アプリの使用可能化](/docs/manageapps/reqnsi.html#req_instance)を参照してください。</li>
<li>サービスを追加するには、その前にクラスターとワーカー・ノードを完全にデプロイしておく必要があります。</li>
</ul></ul>


サービスを追加するには、以下のようにします。
2.  使用可能な {{site.data.keyword.Bluemix_notm}} サービスをリストします。

    ```
bx service list```
    {: pre}

    CLI 出力例:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  クラスターに追加するサービス・インスタンスの**名前**をメモします。

4.  サービスを追加するために使用するクラスターの名前空間を識別します。次のいずれかのオプションを選択します。
    -   既存の名前空間をリストして、使用する名前空間を選択します。


        ```
kubectl get namespaces```
        {: pre}

    -   クラスターに新しい名前空間を作成します。

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  サービスをクラスターに追加します。

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    サービスがクラスターに正常に追加されると、サービス・インスタンスの資格情報を保持するクラスター・シークレットが作成されます。CLI 出力例:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  クラスターの名前空間内にシークレットが作成されたことを確認します。


    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


クラスターにデプロイされたポッドでサービスを使用するために、クラスター・ユーザーは、この [Kubernetes シークレットをシークレット・ボリュームとしてポッドにマウントすることで](cs_apps.html#cs_apps_service)、{{site.data.keyword.Bluemix_notm}} サービスのサービス資格情報にアクセスできます。

### {{site.data.keyword.Bluemix_dedicated_notm}} (最終ベータ版) のクラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加する
{: #binding_dedicated}

**注**: サービスを追加するには、その前にクラスターとワーカー・ノードを完全にデプロイしておく必要があります。

1.  ローカルの {{site.data.keyword.Bluemix_dedicated_notm}} 構成ファイルへのパスを `DEDICATED_BLUEMIX_CONFIG` 環境変数として設定します。

    ```
    export DEDICATED_BLUEMIX_CONFIG=<path_to_config_directory>
    ```
    {: pre}

2.  上記で定義したパスと同じパスを `BLUEMIX_HOME` 環境変数として設定します。

    ```
    export BLUEMIX_HOME=$DEDICATED_BLUEMIX_CONFIG
    ```
    {: pre}

3.  サービス・インスタンスを作成する {{site.data.keyword.Bluemix_dedicated_notm}} 環境にログインします。

    ```
    bx login -a api.<dedicated_domain> -u <user> -p <password> -o <org> -s <space>
    ```
    {: pre}

4.  {{site.data.keyword.Bluemix_notm}} カタログ内の使用可能なサービスをリスト表示します。

    ```
    bx service offerings
    ```
    {: pre}

5.  クラスターにバインドするサービスのインスタンスを作成します。

    ```
    bx service create <service_name> <service_plan> <service_instance_name>
    ```
    {: pre}

6.  使用可能な {{site.data.keyword.Bluemix_notm}} サービスをリストして、サービス・インスタンスが作成されていることを確認します。

    ```
bx service list```
    {: pre}

    CLI 出力例:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

7.  `BLUEMIX_HOME` 環境変数を設定解除して、{{site.data.keyword.Bluemix_notm}} Public を使用するように戻します。

    ```
    unset $BLUEMIX_HOME
    ```
    {: pre}

8.  {{site.data.keyword.containershort_notm}} のパブリック・エンドポイントにログインし、CLI のターゲットを {{site.data.keyword.Bluemix_dedicated_notm}} 環境内のクラスターにします。
    1.  {{site.data.keyword.containershort_notm}} のパブリック・エンドポイントを使用してアカウントにログインします。{{site.data.keyword.Bluemix_notm}} 資格情報を入力し、プロンプトが出されたら、{{site.data.keyword.Bluemix_dedicated_notm}} アカウントを選択します。

        ```
bx login -a api.ng.bluemix.net```
        {: pre}

        **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

    2.  使用可能なクラスターのリストを取得し、CLI でターゲットにするクラスターの名前を確認します。


        ```
bx cs clusters```
        {: pre}

    3.  環境変数を設定して Kubernetes 構成ファイルをダウンロードするためのコマンドを取得します。


        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        構成ファイルのダウンロードが完了すると、そのローカルの Kubernetes 構成ファイルのパスを環境変数として設定するために使用できるコマンドが表示されます。


        OS X の場合の例:


        ```
export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml```
        {: screen}

    4.  `KUBECONFIG` 環境変数を設定するためのコマンドとしてターミナルに表示されたものを、コピーして貼り付けます。


9.  サービスを追加するために使用するクラスターの名前空間を識別します。次のいずれかのオプションを選択します。
    * 既存の名前空間をリストして、使用する名前空間を選択します。

        ```
kubectl get namespaces```
        {: pre}

    * クラスターに新しい名前空間を作成します。
        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

10.  サービス・インスタンスをクラスターにバインドします。

      ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
      {: pre}

<br />


## クラスター・アクセス権限の管理
{: #cs_cluster_user}

クラスターへのアクセス権限を他のユーザーに付与することができます。そのようにすると、それらのユーザーがクラスターにアクセスして、クラスターを管理し、アプリをクラスターにデプロイすることができます。{:shortdesc}

{{site.data.keyword.containershort_notm}} で操作をするすべてのユーザーに、「ID およびアクセス管理」でサービス固有のユーザー役割を割り当てる必要があります。割り当てられるユーザー役割によって、そのユーザーが実行できるアクションが決まります。「ID およびアクセス管理」では、次のアクセス許可を区別します。


<dl>
<dt>{{site.data.keyword.containershort_notm}} アクセス・ポリシー</dt>
<dd>アクセス・ポリシーは、クラスターで実行できるクラスター管理アクション (クラスターの作成または削除、ワーカー・ノードの追加または削除など) を判別します。</dd>
<dt>リソース・グループ</dt>
<dd>リソース・グループは、各 {{site.data.keyword.Bluemix_notm}} サービスをいくつかのグループに編成したもので、これを使用すると、複数のリソースへのアクセス権限を各ユーザーに一度に素早く割り当てることができます。[リソース・グループを使用してユーザーを管理](/docs/admin/resourcegroups.html#rgs)する方法を参照してください。</dd>
<dt>RBAC 役割</dt>
<dd>{{site.data.keyword.containershort_notm}} アクセス・ポリシーが割り当てられているすべてのユーザーには、RBAC 役割が自動的に割り当てられます。RBAC 役割によって、クラスター内の Kubernetes リソースに対して実行できるアクションが決まります。RBAC 役割は、デフォルトの名前空間に関してのみセットアップされます。クラスター管理者は、クラスター内の他の名前空間の RBAC 役割を追加できます。詳しくは、Kubernetes 資料の [Using RBAC Authorization ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) を参照してください。
</dd>
<dt>Cloud Foundry の役割</dt>
<dd>すべてのユーザーに、Cloud Foundry ユーザー役割を割り当てる必要があります。この役割は、ユーザーが {{site.data.keyword.Bluemix_notm}} アカウントで実行できるアクション (他のユーザーの招待や割り当て分の使用率の表示など) を決定します。それぞれの役割の許可を確認するには、[Cloud Foundry の役割](/docs/iam/cfaccess.html#cfaccess)を参照してください。</dd>
</dl>

実行するアクションを次の中から選択します。

-   [クラスターで操作をするために必要なアクセス・ポリシーと許可を確認する](#access_ov)。
-   [現在のアクセス・ポリシーを表示する](#view_access)。
-   [既存のユーザーのアクセス・ポリシーを変更する](#change_access)。
-   [{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加する](#add_users)。

### 必要な {{site.data.keyword.containershort_notm}} アクセス・ポリシーと許可の概要
{: #access_ov}

{{site.data.keyword.Bluemix_notm}} アカウント内のユーザーに付与できるアクセス・ポリシーと許可について説明します。オペレーターの役割とエディターの役割は別個のアクセス権です。例えば、ワーカー・ノードを追加してサービスをバインドする操作をユーザーに実行させるには、そのユーザーにオペレーターとエディターの両方の役割を割り当てる必要があります。

|アクセス・ポリシー|クラスター管理許可|Kubernetes リソース許可|
|-------------|------------------------------|-------------------------------|
|<ul><li>役割: 管理者</li><li>サービス・インスタンス: すべての現行サービス・インスタンス</li></ul>|<ul><li>ライト・クラスターまたは標準クラスターを作成する</li><li>IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにアクセスするための {{site.data.keyword.Bluemix_notm}} アカウントの資格情報を設定する</li><li>クラスターを削除する</li><li>対象アカウント内の他の既存ユーザーの {{site.data.keyword.containershort_notm}} アクセス・ポリシーの割り当てと変更。</li></ul><br/>この役割は、対象アカウントのすべてのクラスターのエディター、オペレーター、およびビューアーの役割から許可を継承します。|<ul><li>RBAC 役割: クラスター管理</li><li>すべての名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li><li>Kubernetes ダッシュボードにアクセスする</li><li>アプリをだれでも利用できるようにする Ingress リソースを作成する</li></ul>|
|<ul><li>役割: 管理者</li><li>サービス・インスタンス: 特定のクラスター ID</li></ul>|<ul><li>特定のクラスターを削除する。</li></ul><br/>この役割は、選択したクラスターのエディター、オペレーター、およびビューアーの役割から許可を継承します。|<ul><li>RBAC 役割: クラスター管理</li><li>すべての名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li><li>Kubernetes ダッシュボードにアクセスする</li><li>アプリをだれでも利用できるようにする Ingress リソースを作成する</li></ul>|
|<ul><li>役割: オペレーター
</li><li>サービス・インスタンス: すべての現行サービス・インスタンス/特定のクラスター ID</li></ul>|<ul><li>クラスターにワーカー・ノードを追加する</li><li>クラスターからワーカー・ノードを削除する</li><li>ワーカー・ノードをリブートする</li><li>ワーカー・ノードを再ロードする</li><li>クラスターにサブネットを追加する</li></ul>|<ul><li>RBAC 役割: 管理者</li><li>名前空間自体ではなく、デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li></ul>|
|<ul><li>役割: エディター</li><li>サービス・インスタンス: すべての現行サービス・インスタンス/特定のクラスター ID</li></ul>|<ul><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにバインドします。</li><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにアンバインドします。</li><li>Web フックを作成します。</li></ul><br/>アプリ開発者には、この役割を使用してください。|<ul><li>RBAC 役割: 編集</li><li>デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li></ul>|
|<ul><li>役割: ビューアー</li><li>サービス・インスタンス: すべての現行サービス・インスタンス/特定のクラスター ID</li></ul>|<ul><li>クラスターをリスト表示する</li><li>クラスターの詳細を表示する</li></ul>|<ul><li>RBAC 役割: 表示</li><li>デフォルトの名前空間内にあるリソースに対する読み取りアクセス</li><li>Kubernetes シークレットに対する読み取りアクセス権限はなし</li></ul>|
|<ul><li>Cloud Foundry の組織の役割: 管理者</li></ul>|<ul><li>{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加する</li></ul>| |
|<ul><li>Cloud Foundry のスペースの役割: 開発者</li></ul>|<ul><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスを作成する><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターにバインドする</li></ul>| |
{: caption="表 7. 必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要" caption-side="top"}

### {{site.data.keyword.containershort_notm}} アクセス・ポリシーの検証
{: #view_access}

割り当てた {{site.data.keyword.containershort_notm}} のアクセス・ポリシーを確認および検証できます。アクセス・ポリシーによって、実行できるクラスター管理アクションが決まります。

1.  {{site.data.keyword.containershort_notm}} アクセス・ポリシーを検証する {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
2.  メニュー・バーから、**「管理」** > **「セキュリティー」** > **「ID およびアクセス」**の順にクリックします。**「ユーザー」**ウィンドウに、選択したアカウントのユーザーのリストが E メール・アドレスおよび現在の状況とともに表示されます。
3.  アクセス・ポリシーを検査するユーザーを選択します。
4.  **「アクセス・ポリシー」**セクションで、対象ユーザーのアクセス・ポリシーを確認します。この役割で実行できるアクションの詳細については、[必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要](#access_ov)を参照してください。
5.  オプション: [現在のアクセス・ポリシーを変更します](#change_access)。

    **注:** 既存のユーザーのアクセス・ポリシーを変更できるのは、{{site.data.keyword.containershort_notm}} 内のすべてのリソースに対する管理者サービス・ポリシーを割り当てられているユーザーのみです。{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加するには、対象アカウントに対する Cloud Foundry の管理者役割が必要です。{{site.data.keyword.Bluemix_notm}} アカウント所有者の ID を確認するには、`bx iam
accounts` を実行し、**「所有者ユーザー ID (Owner User ID)」**を探します。


### 既存のユーザーの {{site.data.keyword.containershort_notm}} アクセス・ポリシーの変更
{: #change_access}

既存のユーザーのアクセス・ポリシーを変更し、{{site.data.keyword.Bluemix_notm}} アカウント内のクラスターに対するクラスター管理許可を付与できます。

始める前に、{{site.data.keyword.containershort_notm}} 内のすべてのリソースに対する[管理者アクセス・ポリシーが自分に割り当てられていることを確認してください](#view_access)。

1.  既存のユーザーの {{site.data.keyword.containershort_notm}} アクセス・ポリシーを変更する {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
2.  メニュー・バーから、**「管理」** > **「セキュリティー」** > **「ID およびアクセス」**の順にクリックします。**「ユーザー」**ウィンドウに、選択したアカウントのユーザーのリストが E メール・アドレスおよび現在の状況とともに表示されます。
3.  アクセス・ポリシーを変更するユーザーを見つけます。探しているユーザーが見つからなければ、[このユーザーを {{site.data.keyword.Bluemix_notm}} アカウントに招待](#add_users)します。
4.  **「アクセス・ポリシー」**の**「役割」**行にある**「アクション」**列で、**「ポリシーの編集」**を展開してクリックします。
5.  **「サービス」**ドロップダウン・リストで、**「{{site.data.keyword.containershort_notm}}」**を選択します。
6.  **「地域」**ドロップダウン・リストから、ポリシー変更の対象地域を選択します。
7.  **「サービス・インスタンス」**ドロップダウン・リストから、ポリシー変更の対象クラスターを選択します。特定のクラスターの ID を確認するには、
`bx cs clusters` を実行します。
8.  **「役割の選択」**セクションで、ユーザーのアクセス権限の変更後に付与する役割をクリックします。役割別のサポート対象アクションの一覧については、[必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要](#access_ov)を参照してください。
9.  **「保存」**をクリックして、変更を保存します。

### {{site.data.keyword.Bluemix_notm}} アカウントへのユーザーの追加
{: #add_users}

{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加して、クラスターへのアクセス権限を付与できます。

始める前に、{{site.data.keyword.Bluemix_notm}} アカウントに対する Cloud Foundry の管理者役割が自分に割り当てられていることを確認してください。

1.  ユーザーを追加する {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
2.  メニュー・バーから、**「管理」** > **「セキュリティー」** > **「ID およびアクセス」**の順にクリックします。「ユーザー」ウィンドウに、選択したアカウントのユーザーのリストが E メール・アドレスおよび現在の状況とともに表示されます。
3.  **「ユーザーの招待」**をクリックします。
4.  **「E メール・アドレス」**に、{{site.data.keyword.Bluemix_notm}} アカウントに追加するユーザーの E メール・アドレスを入力します。
5.  **「アクセス」**セクションで**「サービス」**を展開します。
6.  **「アクセス権限の割り当て先 (Assign access to)」**ドロップダウン・リストから、アクセス権限を {{site.data.keyword.containershort_notm}} アカウント (**リソース**) のみに付与するか、それともアカウント内のさまざまなリソースの集合 (**リソース・グループ**) に付与するかを決定します。
7.  **リソース**の場合:
    1. **「サービス」**ドロップダウン・リストで、**「{{site.data.keyword.containershort_notm}}」**を選択します。
    2. **「地域」**ドロップダウン・リストから、ユーザーを招待する地域を選択します。
    3. **「サービス・インスタンス」**ドロップダウン・リストから、ユーザーを招待するクラスターを選択します。特定のクラスターの ID を確認するには、
`bx cs clusters` を実行します。
    4. **「役割の選択」**セクションで、ユーザーのアクセス権限の変更後に付与する役割をクリックします。役割別のサポート対象アクションの一覧については、[必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要](#access_ov)を参照してください。
8. **リソース・グループ**の場合:
    1. **「リソース・グループ」**ドロップダウン・リストから、自分のアカウントの {{site.data.keyword.containershort_notm}} リソースに対するアクセス権を付与されたリソース・グループを選択します。
    2. **「リソース・グループへのアクセス権限の割り当て (Assign access to a resource group)」**ドロップダウン・リストから、招待されたユーザーに付与する役割を選択します。役割別のサポート対象アクションの一覧については、[必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要](#access_ov)を参照してください。
9. オプション: このユーザーが他のユーザーを {{site.data.keyword.Bluemix_notm}} アカウントに追加できるようにするには、そのユーザーに Cloud Foundry の組織の役割を割り当てます。
    1. **「Cloud Foundry の役割」**セクションの**「組織」**ドロップダウン・リストから、ユーザーにアクセス権を付与する組織を選択します。
    2. **「組織の役割」**ドロップダウン・リストから、**「管理者」**を選択します。
    3. **「地域」**ドロップダウン・リストから、ユーザーにアクセス権を付与する対象地域を選択します。
    4. **「スペース」**ドロップダウン・リストから、ユーザーにアクセス権を付与する対象スペースを選択します。
    5. **「スペースの役割」**ドロップダウン・リストから、**「管理者」**を選択します。
10. **「ユーザーの招待」**をクリックします。

<br />


## Kubernetes マスターの更新
{: #cs_cluster_update}

Kubernetes は、クラスターに影響する[メジャー、マイナー、パッチのバージョン](cs_versions.html#version_types)を定期的に更新します。クラスターを更新する際、2 段階の手順を踏みます。まず、Kubernetes マスターを更新する必要があり、その後に各ワーカー・ノードを更新できます。

デフォルトでは、Kubernetes マスターを更新できるのは 2 つ先のマイナー・バージョンまでです。例えば、現在のマスターがバージョン 1.5 であり 1.8 に更新する計画の場合、まず 1.7 に更新する必要があります。続けて更新を強制実行することは可能ですが、2 つのマイナー・バージョンを超える更新は予期しない結果を生じることがあります。

**注意**: 更新中に発生する可能性のあるアプリの障害や中断に対処するため、更新の指示に従い、テスト・クラスターを使用してください。クラスターを以前のバージョンにロールバックすることはできません。

_メジャー_ または_マイナー_ の更新を行うには、以下の手順を実行します。

1. [Kubernetes の変更点](cs_versions.html)を確認し、『_マスターの前に行う更新_』というマークのある更新を実行します。
2. GUI を使用するか [CLI コマンド](cs_cli_reference.html#cs_cluster_update)を実行して、Kubernetes マスターを更新します。Kubernetes マスターを更新する際、マスターは 5 分から 10 分の間ダウンします。更新中、クラスターにアクセスすることも変更することもできません。ただし、クラスター・ユーザーがデプロイしたワーカー・ノード、アプリ、リソースは変更されず、引き続き実行されます。
3. 更新が完了したことを確認します。{{site.data.keyword.Bluemix_notm}} ダッシュボードで Kubernetes バージョンを確認するか、`bx cs clusters` を実行します。

Kubernetes マスターの更新が完了したら、ワーカー・ノードを更新することができます。

<br />


## ワーカー・ノードの更新
{: #cs_cluster_worker_update}

Kubernetes マスターには IBM が自動的にパッチを適用しますが、ワーカー・ノードのメジャー更新とマイナー更新については、お客様が明示的に更新する必要があります。ワーカー・ノードのバージョンを、Kubernetes マスターのバージョンより高くすることはできません。

**注意**: ワーカー・ノードを更新すると、アプリとサービスにダウン時間が発生する可能性があります。
- データは、ポッドの外部に保管されていない場合、削除されます。
- 使用可能なノードにポッドをスケジュール変更するには、デプロイメントで[レプリカ ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) を使用します。

実動レベルのクラスターを更新するには以下のようにします。
- アプリのダウン時間を回避できるように、更新処理中にはポッドはワーカー・ノードでスケジュールされません。詳しくは、[`kubectl drain` ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/user-guide/kubectl/v1.8/#drain) を参照してください。
- ワークロードやデリバリー・プロセスが更新の影響を受けないか検証するために、テスト・クラスターを使用します。ワーカー・ノードを以前のバージョンにロールバックすることはできません。
- 実動レベルのクラスターには、ワーカー・ノードの障害に対応できるだけのキャパシティーが必要です。ご使用のクラスターにそのキャパシティーがない場合、クラスターを更新する前にワーカー・ノードを追加してください。
- 複数のワーカー・ノードがアップグレードを要求されると、ローリング更新が実行されます。クラスター内のワーカー・ノードの合計量の最大 20 パーセントを同時にアップグレードできます。アップグレード・プロセスでは、1 つのワーカー・ノードのアップグレードが完了するのを待機してから、別のワーカーのアップグレードが開始されます。


1. Kubernetes マスターの Kubernetes バージョンと一致するバージョンの [`kubectl cli` ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) をインストールします。

2. [Kubernetes の変更](cs_versions.html)の『_マスターの後に行う更新_』に記載されている変更作業を行います。

3. ワーカー・ノードを更新します。
  * {{site.data.keyword.Bluemix_notm}} ダッシュボードから更新するには、クラスターの`「ワーカー・ノード (Worker Nodes)」`セクションにナビゲートし、`「ワーカーの更新 (Update Worker)」`をクリックします。
  * ワーカー・ノード ID を取得するには、`bx cs workers <cluster_name_or_id>` を実行します。複数のワーカー・ノードを選択する場合、ワーカー・ノードは 1 つずつ更新されます。

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. 更新が完了したことを確認します。
  * {{site.data.keyword.Bluemix_notm}} ダッシュボードで Kubernetes バージョンを確認するか、`bx cs workers<cluster_name_or_id>` を実行します。
  * `kubectl get nodes` を実行して、ワーカー・ノードの Kubernets のバージョンを確認します。
  * 場合によっては、更新後に古いクラスターで、**NotReady** 状況の重複したワーカー・ノードがリスト表示されることがあります。重複を削除するには、[トラブルシューティング](cs_troubleshoot.html#cs_duplicate_nodes)を参照してください。

更新が完了したら、以下を行います。
  - 他のクラスターで更新処理を繰り返します。
  - クラスターで作業を行う開発者に、`kubectl` CLI を Kubernetes マスターのバージョンに更新するように伝えます。
  - Kubernetes ダッシュボードに使用状況グラフが表示されない場合は、[`kube-dashboard` ポッドを削除](cs_troubleshoot.html#cs_dashboard_graphs)します。

<br />


## クラスターへのサブネットの追加
{: #cs_cluster_subnet}

クラスターにサブネットを追加して、使用可能なポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスのプールを変更します。
{:shortdesc}

{{site.data.keyword.containershort_notm}} では、クラスターにネットワーク・サブネットを追加して、Kubernetes サービス用の安定したポータブル IP を追加できます。
標準クラスターを作成すると、{{site.data.keyword.containershort_notm}} は、5 つのパブリック IP アドレスを持つポータブル・パブリック・サブネットと、5 つのプライベート IP アドレスを持つポータブル・プライベート・サブネットを自動的にプロビジョンします。ポータブル・パブリック IP アドレスおよびポータブル・プライベート IP アドレスは静的で、ワーカー・ノードまたはクラスターが削除されても変更されません。

ポータブル・パブリック IP アドレスのうち 1 つとポータブル・プライベート IP アドレスのうち 1 つは [Ingress コントローラー](cs_apps.html#cs_apps_public_ingress)用に使用され、これをクラスター内の複数のアプリを公開するために使用できます。残りの 4 つのポータブル・パブリック IP アドレスと 4 つのポータブル・プライベート IP アドレスは、[ロード・バランサー・サービスを作成して](cs_apps.html#cs_apps_public_load_balancer)単一アプリをパブリックに公開するために使用できます。

**注:** ポータブル IP アドレスは、月単位で課金されます。クラスターのプロビジョンの後にポータブル・パブリック IP アドレスを削除する場合、短時間しか使用しない場合でも月額課金を支払う必要があります。


### クラスターのその他のサブネットの要求
{: #add_subnet}

クラスターにサブネットを割り当て、安定したポータブル・パブリック IP またはポータブル・プライベート IP をクラスターに追加できます。

 {{site.data.keyword.Bluemix_dedicated_notm}} ユーザーは、このタスクを使用する代わりに、[サポート・チケットを開いて](/docs/support/index.html#contacting-support)サブネットを作成した後に、[`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) コマンドを使用してクラスターにサブネットを追加する必要があります。

始める前に、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオに {{site.data.keyword.Bluemix_notm}} GUI を使用してアクセスできることを確認してください。ポートフォリオにアクセスするには、{{site.data.keyword.Bluemix_notm}} 従量課金 (PAYG) アカウントをセットアップするか、既存の PAYG アカウントを使用する必要があります。

1.  カタログの「**インフラストラクチャー**」セクションで、
「**ネットワーク**」を選択します。
2.  **「サブネット/IP (Subnet/IPs)」**を選択し、
**「作成」**をクリックします。
3.  **「このアカウントに追加するサブネットのタイプの選択 (Select the type of subnet to add to this account)」**ドロップダウン・メニューから、**「ポータブル・パブリック」**または**「ポータブル・プライベート」**を選択します。
4.  ポータブル・サブネットから追加する IP アドレスの数を選択します。

    **注:** サブネットのポータブル IP アドレスを追加する場合、3 つの IP アドレスはクラスター内ネットワークの確立のために使用されるため、これらのアドレスは、Ingress コントローラーでは、あるいはロード・バランサー・サービスの作成には使用できません。例えば、8 個のポータブル・パブリック IP アドレスを要求する場合は、そのうちの 5 個を、アプリをパブリックに公開するために使用できます。

5.  ポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスのルーティング先となるパブリック VLAN またはプライベート VLAN を選択します。既存のワーカー・ノードが接続されているパブリック VLAN またはプライベート VLAN を選択する必要があります。ワーカー・ノードのパブリック VLAN またはプライベート VLAN を確認してください。

    ```
    bx cs worker-get <worker_id>
    ```
    {: pre}

6.  質問に対して入力し、**「注文する (Place order)」**をクリックします。

    **注:** ポータブル IP アドレスは、月単位で課金されます。ポータブル・パブリック IP アドレスを作成した後にそれを削除する場合、月の途中までしか使用していない場合であっても、月額課金を支払う必要があります。

7.  サブネットがプロビジョンされた後、Kubernetes クラスターでそのサブネットを利用できるようにします。
    1.  「インフラストラクチャー」ダッシュボードで、作成したサブネットを選択し、サブネットの ID をメモします。
    2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。{{site.data.keyword.Bluemix_notm}} 地域を指定するには、[API エンドポイントを含めます](cs_regions.html#bluemix_regions)。

        ```
bx login```
        {: pre}

        **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

    3.  アカウント内のすべてのクラスターをリスト表示し、サブネットを使用できるようにするクラスターの ID をメモします。

        ```
bx cs clusters```
        {: pre}

    4.  サブネットをクラスターに追加します。クラスターでサブネットを使用できるようにすると、使用できるすべての使用可能なポータブル・パブリック IP アドレスまたはポータブル・プライベート IP アドレスが含まれる Kubernetes config マップが作成されます。クラスターに Ingress コントローラーが存在しない場合は、パブリック Ingress コントローラーを作成するために 1 つのポータブル・パブリック IP アドレスが自動的に使用され、プライベート Ingress コントローラーを作成するために 1 つのポータブル・プライベート IP アドレスが自動的に使用されます。その他のすべてのポータブル・パブリック IP アドレスおよびポータブル・プライベート IP アドレスは、アプリのロード・バランサー・サービスの作成に使用できます。

        ```
        bx cs cluster-subnet-add <cluster name or id> <subnet id>
        ```
        {: pre}

8.  クラスターにサブネットが正常に追加されたことを確認します。サブネットの CIDR は **VLANs** セクションにリストされます。

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### Kubernetes クラスターへの既存のカスタム・サブネットの追加
{: #custom_subnet}

既存のポータブル・パブリック・サブネットまたはポータブル・プライベート・サブネットを Kubernetes クラスターに追加できます。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオにある、カスタム・ファイアウォール・ルールまたは使用可能な IP アドレスが設定された既存のサブネットを使用する場合は、サブネットなしでクラスターを作成し、クラスターをプロビジョンするときに既存のサブネットをクラスターで使用できるようにします。

1.  使用するサブネットを確認します。サブネットの ID と VLAN ID をメモしてください。この例では、サブネット ID は 807861、VLAN ID は 1901230 です。

    ```
bx cs subnets```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public      
    
    ```
    {: screen}

2.  VLAN のロケーションを確認します。この例では、ロケーションは dal10 です。

    ```
  bx cs vlans dal10
  ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10 
    ```
    {: screen}

3.  確認したロケーションと VLAN ID を使用して、クラスターを作成します。新しいポータブル・パブリック IP サブネットと新しいポータブル・プライベート IP サブネットが自動的に作成されないようにするため、`--no-subnet` フラグを指定します。

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  クラスターの作成が要求されたことを確認します。

    ```
bx cs clusters```
    {: pre}

    **注:** ワーカー・ノード・マシンが配列され、クラスターがセットアップされて自分のアカウントにプロビジョンされるまでに、最大 15 分かかります。

    クラスターのプロビジョニングが完了すると、クラスターの状況が **deployed** に変わります。


    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3   
    ```
    {: screen}

5.  ワーカー・ノードの状況を確認します。

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    ワーカー・ノードの準備が完了すると、状態が **normal** に変わり、状況が **Ready** になります。ノードの状況が**「Ready」**になったら、クラスターにアクセスできます。


    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  サブネット ID を指定してクラスターにサブネットを追加します。クラスターでサブネットを使用できるようにすると、使用できるすべての使用可能なポータブル・パブリックIP アドレスが含まれる Kubernetes config マップが作成されます。Ingress コントローラーがクラスターにまだ存在しない場合は、Ingress コントローラーの作成に 1 つのポータブル・パブリック IP アドレスが自動的に使用されます。
その他のすべてのポータブル・パブリック IP アドレスは、アプリのロード・バランサー・サービスの作成に使用できます。


    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### Kubernetes クラスターへのユーザー管理のサブネットと IP アドレスの追加
{: #user_subnet}

{{site.data.keyword.containershort_notm}} のアクセス先となるオンプレミス・ネットワークのユーザー独自のサブネットを指定します。その後、そのサブネットからのプライベート IP アドレスを、Kubernetes クラスターのロード・バランサー・サービスに追加できます。

要件:
- ユーザー管理のサブネットを追加できるのは、プライベート VLAN のみです。
- サブネットの接頭部の長さの限度は /24 から /30 です。例えば、`203.0.113.0/24` は 253 個の使用可能なプライベート IP アドレスを示し、`203.0.113.0/30` は 1 つの使用可能なプライベート IP アドレスを示します。
- サブネットの最初の IP アドレスは、サブネットのゲートウェイとして使用する必要があります。

始める前に、外部サブネットとのネットワーク・トラフィックの出入りのルーティングを構成してください。さらに、IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオ内のプライベート・ネットワーク Vyatta と、オンプレミス・データ・センター・ゲートウェイ・デバイスとの間に VPN 接続があることを確認してください。詳しくは、この[ブログ投稿 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/) を参照してください。

1. クラスターのプライベート VLAN の ID を表示します。**VLANs** セクションを見つけます。**User-managed** フィールドで、_false_ となっている VLAN ID を見つけます。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. プライベート VLAN に外部サブネットを追加します。ポータブル・プライベート IP アドレスがクラスターの構成マップに追加されます。

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    例:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. ユーザー提供のサブネットが追加されていることを確認します。**User-managed** フィールドは _true_ です。

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. プライベート・ネットワークを介してアプリにアクセスするために、プライベート・ロード・バランサーを追加します。追加したサブネットのプライベート IP アドレスを使用する場合は、プライベート・ロード・バランサーの作成時に IP アドレスを指定する必要があります。使用しない場合は、IP アドレスは IBM Cloud インフラストラクチャー (SoftLayer) サブネット、またはプライベート VLAN 上のユーザー提供のサブネットからランダムに選択されます。詳しくは、[アプリへのアクセスの構成](cs_apps.html#cs_apps_public_load_balancer)を参照してください。

    IP アドレスを指定したプライベート・ロード・バランサー・サービスの構成ファイルの例を以下に示します。

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <myservice>
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
    spec:
      type: LoadBalancer
      selector:
        <selectorkey>:<selectorvalue>
      ports:
       - protocol: TCP
         port: 8080
      loadBalancerIP: <private_ip_address>
    ```
    {: codeblock}

<br />


## クラスターでの既存の NFS ファイル共有の使用
{: #cs_cluster_volume_create}

IBM Cloud インフラストラクチャー (SoftLayer) アカウントにある既存の NFS ファイル共有を Kubernetes で使用するには、その既存の NFS ファイル共有上に永続ボリュームを作成します。永続ボリュームとは、Kubernetes クラスター・リソースとして機能する実際のハードウェアの一片であり、クラスター・ユーザーによって使用されます。
{:shortdesc}

Kubernetes は永続ボリューム (実際のハードウェアを表す) と、永続ボリューム請求 (ストレージの要求。通常はクラスター・ユーザーにより開始される) とを区別します。
次の図は、永続ボリュームと永続ボリューム請求の間の関係を示しています。

![永続ボリュームと永続ボリューム請求の作成](images/cs_cluster_pv_pvc.png)

 図に示すように、既存の NFS ファイル共有を Kubernetes で使用できるようにするには、特定のサイズとアクセス・モードを持つ永続ボリュームを作成し、その永続ボリュームの仕様と一致する永続ボリューム請求を作成する必要があります。永続ボリュームと永続ボリューム請求が一致すると、それらは相互にバインドされます。
クラスター・ユーザーがポッドへのボリュームのマウントに使用できるのは、バインドされた永続ボリューム請求だけです。
この処理は永続ストレージの静的プロビジョニングと呼ばれます。

始める前に、永続ボリュームの作成に使用できる既存の NFS ファイル共有があることを確認します。


**注:** 永続ストレージの静的プロビジョニングは既存の NFS ファイル共有にのみ適用されます。既存の NFS ファイル共有がない場合、クラスター・ユーザーは[動的プロビジョニング](cs_apps.html#cs_apps_volume_claim)処理を使用して永続ボリュームを追加できます。

永続ボリューム、およびそれと一致する永続ボリューム請求を作成するには、次の手順を実行します。

1.  IBM Cloud インフラストラクチャー (SoftLayer) アカウントで、永続ボリューム・オブジェクトを作成する NFS ファイル共有の ID とパスを検索します。
    1.  IBM Cloud インフラストラクチャー (SoftLayer) アカウントにログインします。
    2.  **「ストレージ」**をクリックします。
    3.  **「ファイル・ストレージ」**をクリックし、使用する NFS ファイル共有の ID とパスをメモします。

2.  任意のエディターを開きます。
3.  永続ボリュームのストレージ構成ファイルを作成します。

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.softlayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>表 8. YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>作成する永続ボリューム・オブジェクトの名前を入力します。</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>既存の NFS ファイル共有のストレージ・サイズを入力します。このストレージ・サイズはギガバイト単位 (例えば、20Gi (20 GB) や 1000Gi (1 TB) など) で入力する必要があり、そのサイズは既存のファイル共有のサイズと一致している必要があります。
</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>アクセス・モードは、永続ボリューム請求をワーカー・ノードにマウントする方法を定義します。<ul><li>ReadWriteOnce (RWO): 永続ボリュームは、単一のワーカー・ノードのポッドにのみマウントできます。
この永続ボリュームにマウントされているポッドは、当該ボリュームに対する読み取り/書き込みを行うことができます。
</li><li>ReadOnlyMany (ROX): 永続ボリュームは、複数のワーカー・ノードでホストされているポッドにマウントできます。
この永続ボリュームにマウントされているポッドは、当該ボリュームで読み取りだけを行うことができます。
</li><li>ReadWriteMany (RWX): この永続ボリュームは、複数のワーカー・ノードでホストされているポッドにマウントできます。
この永続ボリュームにマウントされているポッドは、当該ボリュームに対する読み取り/書き込みを行うことができます。
</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>NFS ファイル共有サーバーの ID を入力します。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>永続ボリューム・オブジェクトを作成する NFS ファイル共有のパスを入力します。</td>
    </tr>
    </tbody></table>

4.  クラスターに永続ボリューム・オブジェクトを作成します。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    例

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

5.  永続ボリュームが作成されたことを確認します。

    ```
kubectl get pv```
    {: pre}

6.  永続ボリューム請求を作成するために、別の構成ファイルを作成します。永続ボリューム請求が、前の手順で作成した永続ボリューム・オブジェクトと一致するようにするには、`storage` および
`accessMode` に同じ値を選択する必要があります。`storage-class` フィールドは空である必要があります。これらのいずれかのフィールドが永続ボリュームと一致しない場合、代わりに新しい永続ボリュームが自動的に作成されます。


    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

7.  永続ボリューム請求を作成します。

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

8.  永続ボリューム請求が作成され、永続ボリューム・オブジェクトにバインドされたことを確認します。この処理には数分かかる場合があります。


    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    出力は、以下のようになります。


    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


永続ボリューム・オブジェクトが正常に作成され、永続ボリューム請求にバインドされました。
これで、クラスター・ユーザーがポッドに[永続ボリューム請求をマウント](cs_apps.html#cs_apps_volume_mount)して、永続ボリューム・オブジェクトへの読み書きを開始できるようになりました。


<br />


## クラスター・ロギングの構成
{: #cs_logging}

ログは、クラスターやアプリの問題のトラブルシューティングに役立ちます。処理や長期保管のためにログを特定の場所に送信しなければならない場合があります。{{site.data.keyword.containershort_notm}} の Kubernetes クラスターで、クラスターのログ転送を有効にしたり、ログの転送先を選択したりすることができます。**注**: ログの転送は標準クラスターでのみサポートされています。
{:shortdesc}

### ログの表示
{: #cs_view_logs}

クラスターとコンテナーのログを表示するには、Kubernetes と Docker の標準的なロギング機能を使用します。
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

標準クラスターの場合、Kubernetes クラスターの作成時にログインした {{site.data.keyword.Bluemix_notm}} アカウントにログがあります。クラスターの作成時に {{site.data.keyword.Bluemix_notm}} スペースを指定した場合、ログはそのスペースに配置されます。コンテナーのログは、コンテナー外部からモニターされて転送されます。コンテナーのログには Kibana ダッシュボードを使用してアクセスできます。ロギングについて詳しくは、[{{site.data.keyword.containershort_notm}} のロギング](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)を参照してください。

**注**: クラスター作成時に指定したスペースにログがある場合、アカウント所有者がログを表示するには、そのスペースに対する管理者、開発者、または監査員の権限が必要です。{{site.data.keyword.containershort_notm}} のアクセス・ポリシーとアクセス権限の変更について詳しくは、[クラスター・アクセス権限の管理](cs_cluster.html#cs_cluster_user)を参照してください。権限を変更した後に、ログの表示が開始するまで最大で 24 時間かかります。

Kibana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターを作成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。
- 米国南部および米国東部: https://logging.ng.bluemix.net
- 英国南部および中欧: https://logging.eu-fra.bluemix.net

ログの表示について詳しくは、[Web ブラウザーから Kibana へのナビゲート](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)を参照してください。

#### Docker ログ
{: #cs_view_logs_docker}

組み込みの Docker ロギング機能を活用して、標準の STDOUT と STDERR 出力ストリームのアクティビティーを検討することができます。
詳しくは、[Kubernetes クラスターで実行されるコンテナーのコンテナー・ログの表示](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)を参照してください。

### Docker コンテナー名前空間のログ転送の構成
{: #cs_configure_namespace_logs}

デフォルトで、{{site.data.keyword.containershort_notm}} は Docker コンテナー名前空間ログを {{site.data.keyword.loganalysislong_notm}} に転送します。コンテナー名前空間ログは、新しいログ転送構成を作成することによって外部 syslog サーバーに転送することもできます。
{:shortdesc}

**注**: シドニーのロケーションにあるログを表示するには、ログを外部 syslog サーバーに転送する必要があります。

#### syslog へのログ転送の有効化
{: #cs_namespace_enable}

開始前に、以下のことを行います。

1. 次の 2 つの方法のいずれかで、syslog プロトコルを受け入れることができるサーバーをセットアップします。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。
  * コンテナーから syslog を実行します。例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、Kubernetes クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。

2. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、名前空間があるクラスターにします。

名前空間ログを syslog サーバーに転送するには、以下のようにします。

1. ロギング構成を作成します。

    ```
    bx cs logging-config-create <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>表 9. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>名前空間のログ転送構成を作成するコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--namespace <em>&lt;my_namespace&gt;</em></code></td>
    <td><em>&lt;my_namespace&gt;</em> を名前空間の名前に置き換えます。ログ転送は、Kubernetes 名前空間 <code>ibm-system</code> と <code>kube-system</code> ではサポートされていません。名前空間を指定しないと、コンテナー内のすべての名前空間でこの構成が使用されます。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td><em>&lt;log_server_hostname&gt;</em> をログ・コレクター・サーバーのホスト名または IP アドレスに置き換えます。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em> をログ・コレクター・サーバーのポートに置き換えます。ポートを指定しないと、標準ポート <code>514</code> が syslog で使用されます。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>syslog のログ・タイプ。</td>
    </tr>
    </tbody></table>

2. ログ転送構成が作成されたことを確認します。

    * クラスター内のすべてのロギング構成をリスト表示するには、以下のようにします。
      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      出力例:


      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Container Log Namespace configurations
      ---------------------------------------------
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

    * 名前空間のロギング構成のみをリスト表示するには、以下のようにします。
      ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
      {: pre}

      出力例:


      ```
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

#### syslog サーバー構成の更新
{: #cs_namespace_update}

現行の syslog サーバー構成の詳細を更新する場合、あるいは別の syslog サーバーに変更する場合は、ロギング転送構成を更新できます。
{:shortdesc}

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、名前空間があるクラスターに設定してください。

1. ログ転送構成を更新します。

    ```
    bx cs logging-config-update <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>表 10. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>名前空間のログ転送構成を更新するコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--namepsace <em>&lt;my_namespace&gt;</em></code></td>
    <td><em>&lt;my_namespace&gt;</em> を、ロギング構成がある名前空間の名前に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td><em>&lt;log_server_hostname&gt;</em> をログ・コレクター・サーバーのホスト名または IP アドレスに置き換えます。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em> をログ・コレクター・サーバーのポートに置き換えます。ポートを指定しないと、標準ポート <code>514</code> が使用されます。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td><code>syslog</code> のロギング・タイプ。</td>
    </tr>
    </tbody></table>

2. ログ転送構成が更新されたことを確認します。
    ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
    {: pre}

    出力例:


    ```
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
    {: screen}

#### syslog へのログ転送の停止
{: #cs_namespace_delete}

ロギング構成を削除すると、名前空間からのログの転送を停止できます。

**注**: この操作によって削除されるのは、syslog サーバーへのログ転送の構成のみです。名前空間のログは引き続き {{site.data.keyword.loganalysislong_notm}} に転送されます。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、名前空間があるクラスターに設定してください。

1. ロギング構成を削除します。

    ```
    bx cs logging-config-rm <my_cluster> --namespace <my_namespace>
    ```
    {: pre}
    <em>&lt;my_cluster&gt;</em> をロギング構成があるクラスターの名前に、<em>&lt;my_namespace&gt;</em> を名前空間の名前にそれぞれ置き換えます。


### アプリケーション、ワーカー・ノード、Kubernetes システム構成要素、Ingress コントローラーのログ転送の構成
{: #cs_configure_log_source_logs}

デフォルトで、{{site.data.keyword.containershort_notm}} は Docker コンテナー名前空間ログを {{site.data.keyword.loganalysislong_notm}} に転送します。また、アプリケーション、ワーカー・ノード、Kubernetes クラスター、Ingress コントローラーなどの他のログ・ソースのログ転送を構成することもできます。
{:shortdesc}

それぞれのログ・ソースについては、以下のオプションを確認してください。

|ログ・ソース|特性|ログ・パス|
|----------|---------------|-----|
|`application`|Kubernetes クラスターで実行される独自のアプリケーションのログ。|`/var/log/apps/**/*.log`、`/var/log/apps/**/*.err`
|`worker`|Kubernetes クラスター内の仮想マシン・ワーカー・ノードのログ。|`/var/log/syslog`、`/var/log/auth.log`
|`kubernetes`|Kubernetes システム構成要素のログ。|`/var/log/kubelet.log`、`/var/log/kube-proxy.log`
|`ingress`|Kubernetes クラスターに送信されるネットワーク・トラフィックを管理する Ingress コントローラーのログ。|`/var/log/alb/ids/*.log`、`/var/log/alb/ids/*.err`、`/var/log/alb/customerlogs/*.log`、`/var/log/alb/customerlogs/*.err`
{: caption="表 11. ログ・ソースの特性。" caption-side="top"}

#### アプリケーションのログ転送の有効化
{: #cs_apps_enable}

アプリケーションから取得されるログは、ホスト・ノード上の特定のディレクトリーに制約する必要があります。これを行うには、マウント・パスを使用してコンテナーにホスト・パス・ボリュームをマウントします。このマウント・パスは、アプリケーション・ログが送信されるコンテナーのディレクトリーとして機能します。事前定義されたホスト・パス・ディレクトリー `/var/log/apps` は、ボリューム・マウントを作成すると自動的に作成されます。

アプリケーション・ログ転送の次の側面を確認します。
* ログは /var/log/apps パスから再帰的に読み込まれます。つまり、/var/log/apps パスのサブディレクトリーにアプリケーション・ログを書き込むことができます。
* ファイル拡張子 `.log` または `.err` を持つアプリケーション・ログ・ファイルのみが転送されます。
* ログ転送を初めて有効にすると、アプリケーション・ログはヘッドから読み取られるのではなく、テールされます。つまり、アプリケーション・ロギングが有効になる前に既に存在していたログの内容は読み取られません。ログは、ロギングが有効になった時点から読み取られます。ただし、ログ転送の初回有効化時以降は、ログは常に最後に中止された場所から取得されます。
* `/var/log/apps` ホスト・パス・ボリュームをコンテナーにマウントすると、コンテナーはすべてをこの同じディレクトリーに書き込みます。つまり、コンテナーが同じファイル名に書き込みを行う場合は、ホスト上のまったく同じファイルに書き込みます。これが意図しない動作である場合は、各コンテナーから取得するログ・ファイルに異なる名前を付けて、コンテナーが同じログ・ファイルを上書きしないようにすることができます。
* すべてのコンテナーが同じファイル名に書き込みを行うため、この方法で ReplicaSets のアプリケーション・ログを転送しないでください。代わりに、アプリケーションから取得されるログを STDOUT と STDERR に書き込むことができます。これらのログはコンテナー・ログとして収集され、コンテナー・ログは自動的に {{site.data.keyword.loganalysisshort_notm}} に転送されます。STDOUT と STDERR に書き込まれたアプリケーション・ログを、外部の syslog サーバーに転送するには、[syslog へのログ転送の有効化](cs_cluster.html#cs_namespace_enable)の手順に従ってください。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターに設定してください。

1. アプリケーションのポッドの `.yaml` 構成ファイルを開きます。

2. 次の `volumeMounts` と `volumes` を構成ファイルに追加します。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. ポッドにボリュームをマウントします。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. ログ転送構成を作成するには、[ワーカー・ノード、Kubernetes システム構成要素、Ingress コントローラーのログ転送の有効化](cs_cluster.html#cs_log_sources_enable)の手順に従います。

#### ワーカー・ノード、Kubernetes システム構成要素、Ingress コントローラーのログ転送の有効化
{: #cs_log_sources_enable}

ログは {{site.data.keyword.loganalysislong_notm}} または外部の syslog サーバーに転送することができます。{{site.data.keyword.loganalysisshort_notm}} にログを転送すると、クラスターを作成したのと同じスペースに転送されます。あるログ・ソースから両方のログ・コレクター・サーバーにログを転送する場合は、2 つのロギング構成を作成する必要があります。
{:shortdesc}

開始前に、以下のことを行います。

1. ログを外部 syslog サーバーに転送する場合は、次の 2 つの方法で syslog プロトコルを受け入れるサーバーをセットアップできます。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。
  * コンテナーから syslog を実行します。例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、Kubernetes クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。**注**: シドニーのロケーションにあるログを表示するには、ログを外部 syslog サーバーに転送する必要があります。

2. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。

ワーカー・ノード、Kubernetes システム構成要素、または Ingress コントローラーのログ転送を有効にするには、以下のようにします。

1. ログ転送構成を作成します。

  * ログを {{site.data.keyword.loganalysisshort_notm}} に転送する場合には、以下のようにします。

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --type ibm
    ```
    {: pre}
<em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。<em>&lt;my_log_source&gt;</em> をログ・ソースに置き換えます。指定可能な値は `application`、`worker`、`kubernetes`、`ingress` です。  * ログを外部 syslog サーバーに転送する場合には、以下のようにします。

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>表 12. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>ログ・ソースの syslog ログ転送構成を作成するコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td><em>&lt;my_log_source&gt;</em> をログ・ソースに置き換えます。指定可能な値は <code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> です。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td><em>&lt;log_server_hostname&gt;</em> をログ・コレクター・サーバーのホスト名または IP アドレスに置き換えます。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em> をログ・コレクター・サーバーのポートに置き換えます。ポートを指定しないと、標準ポート <code>514</code> が syslog で使用されます。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>外部 syslog サーバーのログ・タイプ。</td>
    </tr>
    </tbody></table>

2. ログ転送構成が作成されたことを確認します。

    * クラスター内のすべてのロギング構成をリスト表示する場合には、以下のようにします。
      ```
    bx cs logging-config-get <my_cluster>
    ```
      {: pre}

      出力例:


      ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Container Log Namespace configurations
      ---------------------------------------------
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
      {: screen}

    * 1 つのタイプのログ・ソースのロギング構成をリストする場合には、以下のようにします。
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      出力例:


      ```
      Id                                    Source      Host        Port   Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker      localhost   5514   syslog     /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker      -           -      ibm        /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### ログ・コレクター・サーバーの更新
{: #cs_log_sources_update}

アプリケーション、ワーカー・ノード、Kubernetes システム構成要素、Ingress コントローラーのロギング構成を更新するには、ログ・コレクター・サーバーまたはログ・タイプを変更します。
{: shortdesc}

**注**: シドニーのロケーションにあるログを表示するには、ログを外部 syslog サーバーに転送する必要があります。

開始前に、以下のことを行います。

1. ログ・コレクター・サーバーを syslog に変更する場合は、次の 2 つの方法で syslog プロトコルを受け入れるサーバーをセットアップできます。
  * 独自のサーバーをセットアップして管理するか、プロバイダーが管理するサーバーを使用します。プロバイダーがサーバーを管理する場合は、ロギング・プロバイダーからロギング・エンドポイントを取得します。
  * コンテナーから syslog を実行します。例えば、この[デプロイメント .yaml ファイル ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) を使用して、Kubernetes クラスター内のコンテナーで実行されている Docker パブリック・イメージをフェッチできます。このイメージは、パブリック・クラスター IP アドレスのポート `514` を公開し、このパブリック・クラスター IP アドレスを使用して syslog ホストを構成します。

2. [CLI の宛先](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターにします。

ログ・ソースのログ・コレクター・サーバーを変更するには、以下のようにします。

1. ロギング構成を更新します。

    ```
    bx cs logging-config-update <my_cluster> --id <log_source_id> --logsource <my_log_source> --hostname <log_server_hostname> --port <log_server_port> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>表 13. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>ログ・ソースのログ転送構成を更新するコマンド。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td><em>&lt;my_cluster&gt;</em> をクラスターの名前または ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_source_id&gt;</em></code></td>
    <td><em>&lt;log_source_id&gt;</em> をログ・ソース構成の ID に置き換えます。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td><em>&lt;my_log_source&gt;</em> をログ・ソースに置き換えます。指定可能な値は <code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> です。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td><em>&lt;log_server_hostname&gt;</em> をログ・コレクター・サーバーのホスト名または IP アドレスに置き換えます。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td><em>&lt;log_server_port&gt;</em> をログ・コレクター・サーバーのポートに置き換えます。ポートを指定しないと、標準ポート <code>514</code> が syslog で使用されます。</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td><em>&lt;logging_type&gt;</em> を、使用する新しいログ転送プロトコルに置き換えます。現在、<code>syslog</code> と <code>ibm</code> がサポートされています。</td>
    </tr>
    </tbody></table>

2. ログ転送構成が更新されたことを確認します。

  * クラスター内のすべてのロギング構成をリスト表示する場合には、以下のようにします。
    ```
    bx cs logging-config-get <my_cluster>
    ```
    {: pre}

    出力例:


    ```
      Logging Configurations
      ---------------------------------------------
      Id                                    Source        Host             Port    Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes    172.30.162.138   5514    syslog     /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application   localhost        -       ibm        /var/log/apps/**/*.log,/var/log/apps/**/*.err

      Container Log Namespace configurations
      ---------------------------------------------
      Namespace         Host             Port    Protocol
      default           myhostname.com   5514    syslog
      my-namespace      localhost        5514    syslog
      ```
    {: screen}

  * 1 つのタイプのログ・ソースのロギング構成をリストする場合には、以下のようにします。
    ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
    {: pre}

    出力例:


    ```
      Id                                    Source      Host        Port   Protocol   Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker      localhost   5514   syslog     /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker      -           -      ibm        /var/log/syslog,/var/log/auth.log
      ```
    {: screen}

#### ログ転送の停止
{: #cs_log_sources_delete}

ロギング構成を削除すると、ログの転送を停止できます。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、ログ・ソースがあるクラスターに設定してください。

1. ロギング構成を削除します。

    ```
    bx cs logging-config-rm <my_cluster> --id <log_source_id>
    ```
    {: pre}
    <em>&lt;my_cluster&gt;</em> をロギング構成が含まれているクラスターの名前で置き換え、<em>&lt;log_source_id&gt;</em> をログ・ソース構成の ID で置き換えます。


## クラスター・モニタリングの構成
{: #cs_monitoring}

メトリックは、クラスターの正常性とパフォーマンスをモニターするのに役立ちます。機能低下状態または作動不可状態になったワーカー・ノードを自動的に検出して修正できるように、ワーカー・ノードの正常性モニタリングを構成できます。**注**: モニタリングは標準クラスターでのみサポートされています。
{:shortdesc}

### メトリックの表示
{: #cs_view_metrics}

Kubernetes と Docker の標準機能を使用して、クラスターとアプリの正常性をモニターできます。{:shortdesc}

<dl>
<dt>{{site.data.keyword.Bluemix_notm}} のクラスター詳細ページ</dt>
<dd>{{site.data.keyword.containershort_notm}} には、クラスターの正常性と能力、そしてクラスター・リソースの使用方法に関する情報が表示されます。
この GUI を使用して、クラスターのスケールアウト、永続ストレージの作業、{{site.data.keyword.Bluemix_notm}} サービス・バインディングによるクラスターへの機能の追加を行うことができます。クラスターの詳細ページを表示するには、**{{site.data.keyword.Bluemix_notm}} の「ダッシュボード」**に移動して、クラスターを選択します。</dd>
<dt>Kubernetes ダッシュボード</dt>
<dd>Kubernetes ダッシュボードは、ワーカー・ノードの正常性の検討、Kubernetes リソースの検索、コンテナー化アプリのデプロイ、ロギングとモニタリング情報を使用したアプリのトラブルシューティングを行うことができる、管理 Web インターフェースです。Kubernetes ダッシュボードにアクセスする方法について詳しくは、[{{site.data.keyword.containershort_notm}} での Kubernetes ダッシュボードの起動](cs_apps.html#cs_cli_dashboard)を参照してください。</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>標準クラスターのメトリックは、Kubernetes クラスターを作成したときにログインした {{site.data.keyword.Bluemix_notm}} アカウントにあります。クラスターの作成時に {{site.data.keyword.Bluemix_notm}} スペースを指定した場合、メトリックはそのスペースに配置されます。コンテナーのメトリックはクラスターにデプロイされたすべてのコンテナーについて自動的に収集されます。
これらのメトリックが送信され、 Grafana で使用できるようになります。メトリックについて詳しくは、[{{site.data.keyword.containershort_notm}} のモニター](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)を参照してください。<p>Grafana ダッシュボードにアクセスするには、以下のいずれかの URL にアクセスし、クラスターを作成した {{site.data.keyword.Bluemix_notm}} アカウントまたはスペースを選択します。<ul><li>米国南部と米国東部: https://metrics.ng.bluemix.net</li><li>英国南部: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### その他のヘルス・モニター・ツール
{: #cs_health_tools}

他のツールを構成してモニター機能を追加することができます。
<dl>
<dt>Prometheus</dt>
<dd>Prometheus は、Kubernetes のために設計されたモニタリング、ロギング、アラートのためのオープン・ソースのツールです。このツールは、Kubernetes のロギング情報に基づいてクラスター、ワーカー・ノード、デプロイメントの正常性に関する詳細情報を取得します。セットアップ方法について詳しくは、[{{site.data.keyword.containershort_notm}} とのサービスの統合](cs_planning.html#cs_planning_integrations)を参照してください。</dd>
</dl>

### Autorecovery を使用したワーカー・ノードの正常性モニタリングの構成
{: #cs_configure_worker_monitoring}

{{site.data.keyword.containerlong_notm}} Autorecovery システムは、Kubernetes バージョン 1.7 以降の既存のクラスターにデプロイできます。Autorecovery システムは、さまざまな検査機能を使用してワーカー・ノードの正常性状況を照会します。Autorecovery は、構成された検査に基づいて正常でないワーカー・ノードを検出すると、ワーカー・ノードの OS の再ロードのような修正アクションをトリガーします。修正アクションは、一度に 1 つのワーカー・ノードに対してのみ実行されます。1 つのワーカー・ノードの修正アクションが正常に完了してからでないと、別のワーカー・ノードの修正アクションは実行されません。
**注**: Autorecovery が正常に機能するためには、1 つ以上の正常なノードが必要です。Autorecovery でのアクティブな検査は、複数のワーカー・ノードが存在するクラスターでのみ構成します。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を、ワーカー・ノードの状況を検査するクラスターに設定してください。

1. 検査を JSON 形式で定義する構成マップ・ファイルを作成します。例えば、次の YAML ファイルでは、3 つの検査 (1 つの HTTP 検査と 2 つの Kubernetes API サーバー検査) を定義しています。

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>表 15.  YAML ファイルの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="アイデア・アイコン"/> YAML ファイルの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>構成名 <code>ibm-worker-recovery-checks</code> は定数であり、変更することはできません。</td>
    </tr>
    <tr>
    <td><code>namespace</code></td>
    <td><code>kube-system</code> 名前空間は定数であり、変更することはできません。</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>Autorecovery で使用する検査のタイプを入力します。<ul><li><code>HTTP</code>: Autorecovery は、各ノードで稼働する HTTP サーバーを呼び出して、ノードが正常に稼働しているかどうかを判別します。</li><li><code>KUBEAPI</code>: Autorecovery は、Kubernetes API サーバーを呼び出し、ワーカー・ノードによって報告された正常性状況データを読み取ります。</li></ul></td>
    </tr>
    <tr>
    <td><code>リソース</code></td>
    <td>検査タイプが <code>KUBEAPI</code> である場合は、Autorecovery で検査するリソースのタイプを入力します。受け入れられる値は <code>NODE</code> または <code>PODS</code> です。</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>検査の連続失敗数のしきい値を入力します。このしきい値に達すると、Autorecovery が、指定された修正アクションをトリガーします。例えば、値が 3 である場合に、Autorecovery で構成された検査が 3 回連続して失敗すると、Autorecovery は検査に関連付けられている修正アクションをトリガーします。</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>リソース・タイプが <code>PODS</code> である場合は、[NotReady ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 状態になることができるワーカー・ノード上のポッドのしきい値 (パーセンテージ) を入力します。このパーセンテージは、ワーカー・ノードにスケジュールされているポッドの合計数に基づきます。検査の結果、正常でないポッドのパーセンテージがしきい値を超えていることが判別されると、1 回の失敗としてカウントされます。</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>失敗しきい値に達したときに実行するアクションを入力します。修正アクションは、他のワーカーが修復されておらず、しかもこのワーカー・ノードが以前のアクション実行時のクールオフ期間にないときにのみ実行されます。<ul><li><code>REBOOT</code>: ワーカー・ノードをリブートします。</li><li><code>RELOAD</code>: ワーカー・ノードに必要な構成をすべて、クリーンな OS から再ロードします。</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>既に修正アクションが実行されたノードに対して別の修正アクションを実行するために Autorecovery が待機する必要がある秒数を入力します。クールオフ期間は、修正アクションが実行された時点から始まります。</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>連続する検査の間隔の秒数を入力します。例えば、値が 180 である場合、Autorecovery は 3 分ごとに各ノードで検査を実行します。</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>データベースに対する検査の呼び出しの最大秒数を入力します。この秒数が経過すると、Autorecovery は呼び出し動作を終了します。<code>TimeoutSeconds</code> の値は、<code>IntervalSeconds</code> の値より小さくする必要があります。</td>
    </tr>
    <tr>
    <td><code>ポート</code></td>
    <td>検査タイプが <code>HTTP</code> である場合は、HTTP サーバーがワーカー・ノードにバインドする必要があるポートを入力します。このポートは、クラスター内のすべてのワーカー・ノードの IP で公開されている必要があります。Autorecovery がサーバーを検査するためには、すべてのノードで一定のポート番号を使用する必要があります。カスタム・サーバーをクラスターにデプロイする場合は、[DaemonSets ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) を使用します。</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>検査タイプが <code>HTTP</code> である場合は、検査で返されることが予期される HTTP サーバー状況を入力します。例えば、値 200 は、サーバーからの応答として <code>OK</code> を予期していることを示します。</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>検査タイプが <code>HTTP</code> である場合は、HTTP サーバーから要求されたパスを入力します。この値は通常、すべてのワーカー・ノードで実行されているサーバーのメトリック・パスです。</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>検査を有効にするには <code>true</code>、検査を無効にするには <code>false</code> を入力します。</td>
    </tr>
    </tbody></table>

2. クラスター内に構成マップを作成します。

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 適切な検査を実行して、`kube-system` 名前空間内に `ibm-worker-recovery-checks` という名前の構成マップが作成されていることを確認します。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. `kube-system` 名前空間内に `international-registry-docker-secret` という名前の Docker プル・シークレットが作成されていることを確認します。Autorecovery は、{{site.data.keyword.registryshort_notm}} の Docker 国際レジストリーでホストされています。国際レジストリーの有効な資格情報を格納する Docker レジストリー・シークレットを作成していない場合は、Autorecovery システムを実行するためにそれを作成します。

    1. {{site.data.keyword.registryshort_notm}} プラグインをインストールします。


        ```
    bx plugin install container-registry -r Bluemix
    ```
        {: pre}

    2. ターゲットとして国際レジストリーを設定します。

        ```
        bx cr region-set international
        ```
        {: pre}

    3. 国際レジストリー・トークンを作成します。

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. `INTERNATIONAL_REGISTRY_TOKEN` 環境変数を、作成したトークンに設定します。

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. `DOCKER_EMAIL` 環境変数を現行ユーザーに設定します。E メール・アドレスは、次のステップで `kubectl` コマンドを実行する場合にのみ必要です。

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Docker プル・シークレットを作成します。

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. この YAML ファイルを適用することによって、Autorecovery をクラスターにデプロイします。

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. 数分後に、次のコマンドの出力にある `Events` セクションを確認して、Autorecovery のデプロイメントのアクティビティーを確認できます。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## Kubernetes クラスター・リソースの視覚化
{: #cs_weavescope}

Weave Scope は、Kubernetes クラスター内のリソース (サービス、ポッド、コンテナー、プロセス、ノードなど) のビジュアル図を表示します。Weave Scope は CPU とメモリーのインタラクティブ・メトリックを示し、コンテナーの中で追尾したり実行したりするツールも備えています。
{:shortdesc}

開始前に、以下のことを行います。

-   クラスター情報を公共のインターネットに公開しないようにしてください。安全に Weave Scope をデプロイして Web ブラウザーからローカル・アクセスするには、以下の手順を実行します。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](#cs_cluster_ui)。Weave Scope は、アプリでは特に、CPU の負荷が大きくなります。ライト・クラスターではなく、比較的大規模な標準クラスターで Weave Scope を実行してください。
-   対象のクラスターに対して `kubectl` コマンドを実行するように [CLI のターゲット設定を行います](cs_cli_install.html#cs_cli_configure)。


Weave Scope をクラスターで使用するには、以下のようにします。
2.  提供された RBAC 許可構成ファイルをクラスターにデプロイします。

    読み取り/書き込みアクセス権を有効にするには、以下のようにします。

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    読み取り専用アクセス権を有効にするには、以下のようにします。


    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    出力:


    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Weave Scope サービスをデプロイします。このサービスは、クラスター IP アドレスでのプライベート・アクセスが可能です。

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    出力:


    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  ポート転送コマンドを実行して、コンピューター上でサービスを開始します。これで、クラスターでの Weave Scope の構成は完了です。次回 Weave Scope にアクセスするときは、以下のポート転送コマンドを実行するだけでよく、上記の構成ステップを再度実行する必要はありません。

    ```
kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040```
    {: pre}

    出力:


    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Web ブラウザーで `http://localhost:4040` を開きます。
デフォルトのコンポーネントをデプロイしないと、次の図が表示されます。クラスター内の Kubernetes リソースのトポロジー・ダイアグラムまたはテーブルを表示するように選択できます。

     <img src="images/weave_scope.png" alt="Weave Scope のトポロジーの例" style="width:357px;" />


[Weave Scope の機能についての詳細 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.weave.works/docs/scope/latest/features/)。

<br />


## クラスターの削除
{: #cs_cluster_remove}

クラスターの使用を終了したとき、クラスターがリソースを消費しないように削除することができます。
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} ライト・アカウントまたは従量課金 (PAYG) アカウントで作成したライト・クラスターと標準クラスターが不要になった場合は、ユーザーが手動で削除する必要があります。

クラスターを削除すると、コンテナー、ポッド、バインド済みサービス、シークレットなど、クラスター上のリソースも削除されます。
クラスターを削除するときにストレージを削除しない場合は、{{site.data.keyword.Bluemix_notm}} GUI 内の IBM Cloud インフラストラクチャー (SoftLayer) ダッシュボードを使用してストレージを削除できます。毎月の課金サイクルの規定で、永続ボリューム請求を月の最終日に削除することはできません。
永続ボリューム請求を月の末日に削除した場合、削除は翌月初めまで保留状態になります。

**警告:** 永続ストレージ内のクラスターやデータのバックアップは作成されません。クラスターを削除すると永久に削除されます。元に戻すことはできません。

-   {{site.data.keyword.Bluemix_notm}} GUI から
    1.  クラスターを選択して、**「その他のアクション...」**メニューから**「削除」**をクリックします。

-   {{site.data.keyword.Bluemix_notm}} CLI から
    1.  使用可能なクラスターをリストします。


        ```
bx cs clusters```
        {: pre}

    2.  クラスターを削除します。

        ```
  bx cs cluster-rm my_cluster
  ```
        {: pre}

    3.  プロンプトに従って、クラスター・リソースを削除するかどうかを選択してください。

クラスターを削除するときに、ポータブル・サブネットとそれに関連付けられている永続ストレージを削除することができます。
- サブネットは、ポータブル・パブリック IP アドレスをロード・バランサー・サービスまたは Ingress コントローラーに割り当てるときに使用されます。これらのサブネットを保持していれば、新しいクラスターで再利用したり、後で IBM Cloud インフラストラクチャー (SoftLayer) のポートフォリオから手動で削除したりすることができます。
- 既存のファイル共有 [#cs_cluster_volume_create] を使用して永続ボリューム請求を作成した場合は、クラスターを削除するときにファイル共有を削除できません。このファイル共有は後で IBM Cloud インフラストラクチャー (SoftLayer) ポートフォリオから手動で削除する必要があります。
- 永続ストレージは、データの高可用性を提供します。これを削除した場合は、データをリカバリーできません。
