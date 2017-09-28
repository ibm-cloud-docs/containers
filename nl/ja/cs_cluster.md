---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-21"

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

開始する前に、[可用性の高いクラスター構成](cs_planning.html#cs_planning_cluster_config)に関するオプションを確認してください。

![クラスターの高可用性の段階](images/cs_cluster_ha_roadmap.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_cluster_ha_roadmap.png)

## GUI でのクラスターの作成
{: #cs_cluster_ui}

Kubernetes クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} Dedicated ユーザーの場合は、代わりに [{{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) における GUI からの Kubernetes クラスターの作成](#creating_cli_dedicated)を参照してください。

クラスターを作成するには、以下のようにします。
1.  カタログから**「コンテナー」**を選択して、**「Kubernetes クラスター」**をクリックします。


2.  **「クラスター・タイプ (Cluster type)」**で**「標準」**を選択します。標準クラスターには複数のワーカー・ノードなどのフィーチャーがあり、可用性の高い環境を実現できます。
3.  **クラスター名**を入力します。
4.  ワーカー・ノードで使用する **Kubernetes バージョン**を選択します。
 
5.  クラスターをデプロイする{{site.data.keyword.Bluemix_notm}} **場所**を選択します。使用可能な場所は、ログインしている {{site.data.keyword.Bluemix_notm}} 地域によって異なります。最高のパフォーマンスを得るために、物理的に最も近い地域を選択してください。
国外の場所を選択する場合は、その国にデータを物理的に保管する前に法的な許可を得なければならないことがあります。
{{site.data.keyword.Bluemix_notm}} 地域によって、使用できるコンテナー・レジストリー、および使用できる {{site.data.keyword.Bluemix_notm}} サービスが決まります。

6.  **マシン・タイプ**を選択します。
各ワーカー・ノードにセットアップされる (ノードにデプロイされるすべてのコンテナーで使用できる) 仮想 CPU とメモリーの量は、マシン・タイプによって決まります。

    -   「マイクロ (micro)」のマシン・タイプは、最小のオプションを表しています。
    -   「分散型 (Balanced)」のマシン・タイプは、同じ容量のメモリーが各 CPU に割り当てられるので、パフォーマンスが最適化されます。
7.  必要な**ワーカー・ノードの数**を選択します。
クラスターの可用性を高くするためには 3 を選択します。
8.  {{site.data.keyword.BluSoftlayer_full}} アカウントから**プライベート VLAN** を選択します。
プライベート VLAN は、ワーカー・ノード間で通信するために使用されます。
複数のクラスターで同じプライベート VLAN を使用できます。

9. {{site.data.keyword.BluSoftlayer_notm}} アカウントから**パブリック VLAN** を選択します。
パブリック VLAN は、ワーカー・ノードと IBM 管理の Kubernetes マスターの間の通信に使用されます。複数のクラスターで同じパブリック VLAN を使用できます。
パブリック VLAN を選択しないことにした場合、代替ソリューションを構成する必要があります。

10. **「ハードウェア (Hardware)」**には、**「専用」**または**「共有」**を選択します。
ほとんどの状況では**「共有」**で十分間に合うはずです。

    -   **専用**: お客様の物理リソースを IBM の他のお客様とは完全に分離します。
    -   **共有**: IBM がお客様の物理リソースを IBM の他のお客様と同じハードウェア上に保管することを許可します。
11. **「クラスターの作成」**をクリックします。クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。
**「ワーカー・ノード (Worker nodes)」**タブで、ワーカー・ノードのデプロイメントの進行状況を確認できます。ワーカー・ノードの準備が完了すると、状態が **Ready** に変わります。

    **注:** ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはいけません。ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。


**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

-   [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
-   [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)

### {{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) における GUI によるクラスターの作成
{: #creating_ui_dedicated}

1.  IBMID を使用して {{site.data.keyword.Bluemix_notm}} Public コンソール ([https://console.bluemix.net ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net)) にログインします。
2.  アカウント・メニューから、{{site.data.keyword.Bluemix_notm}} Dedicated アカウントを選択します。コンソールが更新されて、ご使用の {{site.data.keyword.Bluemix_notm}} Dedicated インスタンスに関するサービスと情報が表示されます。
3.  カタログから**「コンテナー」**を選択して、**「Kubernetes クラスター」**をクリックします。

4.  **クラスター名**を入力します。
5.  ワーカー・ノードで使用する **Kubernetes バージョン**を選択します。
 
6.  **マシン・タイプ**を選択します。
各ワーカー・ノードにセットアップされる (ノードにデプロイされるすべてのコンテナーで使用できる) 仮想 CPU とメモリーの量は、マシン・タイプによって決まります。

    -   「マイクロ (micro)」のマシン・タイプは、最小のオプションを表しています。
    -   「分散型 (Balanced)」のマシン・タイプは、同じ容量のメモリーが各 CPU に割り当てられるので、パフォーマンスが最適化されます。

7.  必要な**ワーカー・ノードの数**を選択します。
3 を選択して、クラスターの高可用性を確保します。
8.  **「クラスターの作成」**をクリックします。クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。
**「ワーカー・ノード (Worker nodes)」**タブで、ワーカー・ノードのデプロイメントの進行状況を確認できます。ワーカー・ノードの準備が完了すると、状態が **Ready** に変わります。

**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

-   [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
-   [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
-   [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)

## CLI でのクラスターの作成
{: #cs_cluster_cli}

クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。アプリをデプロイするには、その前にクラスターを作成して、そのクラスター内にワーカー・ノードの定義を設定する必要があります。
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} Dedicated ユーザーの場合は、代わりに [{{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) における CLI からの Kubernetes クラスターの作成](#creating_cli_dedicated)を参照してください。

クラスターを作成するには、以下のようにします。
1.  {{site.data.keyword.Bluemix_notm}} CLI と [{{site.data.keyword.containershort_notm}} プラグイン](cs_cli_install.html#cs_cli_install)をインストールします。
2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} 資格情報を入力します。


    ```
bx login```
    {: pre}

      特定の {{site.data.keyword.Bluemix_notm}} 地域を指定するには、API エンドポイントを含めます。特定の
{{site.data.keyword.Bluemix_notm}} 地域のコンテナー・レジストリーに保管されているプライベート Dockerイメージがある場合、またはすでに作成した {{site.data.keyword.Bluemix_notm}} サービス・インスタンスがある場合、この地域にログインして、イメージと {{site.data.keyword.Bluemix_notm}} サービスにログインします。


      ログインする {{site.data.keyword.Bluemix_notm}} 地域により、使用可能なデータ・センターなど、Kubernetes クラスターを作成できる地域も決まります。地域を指定しない場合、最も近い地域に自動的にログインします。

       -  米国南部

           ```
bx login -a api.ng.bluemix.net```
           {: pre}
     
       -  シドニー

           ```
bx login -a api.au-syd.bluemix.net```
           {: pre}

       -  ドイツ


           ```
          bx login -a api.eu-de.bluemix.net
          ```
           {: pre}

       -  英国

           ```
bx login -a api.eu-gb.bluemix.net```
           {: pre}

      **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

3.  複数の {{site.data.keyword.Bluemix_notm}} のアカウント、組織、およびスペースが割り当てられているユーザーは、Kubernetes クラスターを作成するアカウントを選択します。
クラスターはアカウントと組織に固有のものですが、{{site.data.keyword.Bluemix_notm}} スペースからは独立しています。
そのため、組織内の複数のスペースに対するアクセス権限がある場合、リストからスペースを選択できます。

4.  オプション: 前に選択した {{site.data.keyword.Bluemix_notm}} 地域とは別の地域で Kubernetes クラスターを作成したり、別の地域のクラスターにアクセスしたりする場合は、その地域を指定します。例えば、次の理由で別の {{site.data.keyword.containershort_notm}} 地域にログインすることができます。

    -   ある地域で作成した {{site.data.keyword.Bluemix_notm}} サービスまたはプライベート Docker イメージを、別の地域の {{site.data.keyword.containershort_notm}} で使用したい。
    -   ログインしているデフォルトの {{site.data.keyword.Bluemix_notm}} 地域とは別の地域のクラスターにアクセスしたい。
    
    以下の API エンドポイントの中から選択します。

    -   米国南部:

        ```
bx cs init --host https://us-south.containers.bluemix.net```
        {: pre}

    -   英国南部:

        ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
        {: pre}

    -   中欧:

        ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
        {: pre}

    -   南アジア太平洋地域:

        ```
        bx cs init --host https://ap-south.containers.bluemix.net
        ```
        {: pre}
    
6.  クラスターを作成します。
    1.  使用可能なロケーションを確認します。表示される場所は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。

        ```
  bx cs locations
  ```
        {: pre}

        CLI 出力は、以下のようになります。



        -   米国南部:

            ```
            dal10
            dal12
            ```
            {: screen}

        -   英国南部:

            ```
            lon02
            lon04
            ```
            {: screen}

        -   中欧:

            ```
            ams03
            fra02
            ```
            {: screen}

        -   南アジア太平洋地域

            ```
            syd01
            syd02
            ```
            {: screen}

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
        u1c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual 
        ```
        {: screen}

    3.  このアカウントの {{site.data.keyword.BluSoftlayer_notm}} にパブリック VLAN およびプライベート VLAN が既に存在しているかどうかを確認します。

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

    4.  `cluster-create` コマンドを実行します。ライト・クラスター (vCPU 2 つとメモリー 4 GB でセットアップされたワーカー・ノード 1 つ) または標準クラスター ({{site.data.keyword.BluSoftlayer_notm}} アカウントで選択した数のワーカー・ノード) のいずれかを選択できます。標準クラスターを作成する場合、デフォルトでは、ワーカー・ノードのハードウェアは IBM の複数のお客様によって共有され、使用時間に応じて課金されます。</b>標準クラスターの例:

        ```
        bx cs cluster-create --location dal10; --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u1c.2x4 --workers 3 --name <cluster_name>
        ```
        {: pre}

        ライト・クラスターの例:

        ```
  bx cs cluster-create --name my_cluster
  ```
        {: pre}

        <table>
        <caption>表 1. このコマンドの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png"/> このコマンドの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>{{site.data.keyword.Bluemix_notm}} 組織内にクラスターを作成するためのコマンド。
</td> 
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td><em>&lt;location&gt;</em> を、クラスターを作成する {{site.data.keyword.Bluemix_notm}} 場所の ID に置き換えます。使用可能な場所は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。
使用可能な場所は、次のとおりです。<ul><li>米国南部<ul><li>dal10 [Dallas (ダラス)]</li><li>dal12 [Dallas (ダラス)]</li></ul></li><li>英国南部<ul><li>lon02 [London (ロンドン)]</li><li>lon04 [London (ロンドン)]</li></ul></li><li>中欧<ul><li>ams03 [Amsterdam (アムステルダム)]</li><li>ra02 [Frankfurt (フランクフルト)]</li></ul></li><li>南アジア太平洋地域<ul><li>syd01 [Sydney (シドニー)]</li><li>syd04 [Sydney (シドニー)]</li></ul></li></ul></td> 
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>標準クラスターを作成する場合、マシン・タイプを選択します。マシン・タイプの指定によって、各ワーカー・ノードで使用可能な仮想コンピュート・リソースが決まります。
詳しくは、[{{site.data.keyword.containershort_notm}} のライト・クラスターと標準クラスターの比較](cs_planning.html#cs_planning_cluster_type)を参照してください。ライト・クラスターの場合、マシン・タイプを定義する必要はありません。</td> 
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul><li>ライト・クラスターの場合、パブリック VLAN を定義する必要がありません。ライト・クラスターは IBM 所有のパブリック VLAN に自動的に接続されます。</li><li>標準クラスターの場合、{{site.data.keyword.BluSoftlayer_notm}} アカウントでその場所用にパブリック VLAN を既にセットアップしている場合には、そのパブリック VLAN の ID を入力します。そうでない場合は、{{site.data.keyword.containershort_notm}} によってパブリック VLAN が自動的に作成されるので、このオプションを指定する必要はありません。
<br/><br/><strong>注</strong>: create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
</li></ul></td> 
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>ライト・クラスターの場合、プライベート VLAN を定義する必要はありません。ライト・クラスターは IBM 所有のプライベート VLAN に自動的に接続されます。</li><li>標準クラスターに対して、対象ロケーションの {{site.data.keyword.BluSoftlayer_notm}} アカウントでプライベート VLAN を既にセットアップしている場合には、プライベート VLAN の ID を入力します。そうでない場合は、{{site.data.keyword.containershort_notm}} によってプライベート VLAN が自動的に作成されるので、このオプションを指定する必要はありません。
<br/><br/><strong>注</strong>: create コマンドで指定するパブリック VLAN とプライベート VLAN は、一致していなければなりません。必ず、プライベート VLAN ルーターの先頭は <code>bcr</code> (バックエンド・ルーター)、パブリック VLAN ルーターの先頭は <code>fcr</code> (フロントエンド・ルーター) になります。クラスターを作成するときにこれらの VLAN を使用するには、それらの接頭部の後に続く数値と文字の組み合わせが一致していなければなりません。
クラスターを作成するときに、一致していないパブリック VLAN とプライベート VLAN を使用しないでください。
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


    **注:** ワーカー・ノードごとに、固有のワーカー・ノード ID とドメイン名が割り当てられます。クラスターが作成された後にこれらを手動で変更してはいけません。ID またはドメイン名を変更すると、Kubernetes マスターがクラスターを管理できなくなります。

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

10. デフォルトのポート 8001 で Kubernetes ダッシュボードを起動します。
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

### {{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) における CLI によるクラスターの作成
{: #creating_cli_dedicated}

1.  {{site.data.keyword.Bluemix_notm}} CLI と [{{site.data.keyword.containershort_notm}} プラグイン](cs_cli_install.html#cs_cli_install)をインストールします。
2.  {{site.data.keyword.containershort_notm}} のパブリック・エンドポイントにログインします。{{site.data.keyword.Bluemix_notm}} 資格情報を入力し、プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} Dedicated アカウントを選択します。

    ```
    bx login -a api.<region>.bluemix.net
    ```
    {: pre}

    **注:** フェデレーテッド ID がある場合は、`bx login --sso` を使用して、{{site.data.keyword.Bluemix_notm}} CLI にログインします。ユーザー名を入力し、CLI 出力に示された URL を使用して、ワンタイム・パスコードを取得してください。
`--sso` なしではログインに失敗し、`--sso` オプションを指定すると成功する場合、フェデレーテッド ID があることがわかります。

3.  `cluster-create` コマンドを使用してクラスターを作成します。標準クラスターを作成する場合、ワーカー・ノードのハードウェアは、使用時間に応じて課金されます。

    例

    ```
    bx cs cluster-create --machine-type <machine-type> --workers <number> --name <cluster_name>
    ```
    {: pre}
    
    <table>
    <caption>表 2. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> このコマンドの構成要素について</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>{{site.data.keyword.Bluemix_notm}} 組織内にクラスターを作成するためのコマンド。
</td> 
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>&lt;location&gt; を、クラスターを作成する {{site.data.keyword.Bluemix_notm}} 場所の ID に置き換えます。使用可能な場所は、ログインしている {{site.data.keyword.containershort_notm}} 地域によって異なります。
使用可能な場所は、次のとおりです。<ul><li>米国南部<ul><li>dal10 [Dallas (ダラス)]</li><li>dal12 [Dallas (ダラス)]</li></ul></li><li>英国南部<ul><li>lon02 [London (ロンドン)]</li><li>lon04 [London (ロンドン)]</li></ul></li><li>中欧<ul><li>ams03 [Amsterdam (アムステルダム)]</li><li>ra02 [Frankfurt (フランクフルト)]</li></ul></li><li>南アジア太平洋地域<ul><li>syd01 [Sydney (シドニー)]</li><li>syd04 [Sydney (シドニー)]</li></ul></li></ul></td> 
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

    クラスターのプロビジョニングが完了すると、クラスターの状況が **deployed** に変わります。


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

-   [{{site.data.keyword.Bluemix_notm}} Public または {{site.data.keyword.Bluemix_notm}} Dedicated の {{site.data.keyword.registryshort_notm}} に名前空間をセットアップし、その名前空間にイメージをプッシュします](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)。
-   [クラスターを作成します](#cs_cluster_cli)。
-   [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

クラスターを作成すると、有効期限のないレジストリー・トークンがそのクラスターに対して自動的に作成されます。このトークンは、{{site.data.keyword.registryshort_notm}} 内にセットアップした名前空間への読み取り専用アクセスを許可するために使用されるもので、これにより、IBM 提供のパブリック・イメージや独自のプライベート Docker イメージの処理が可能になります。コンテナー化アプリのデプロイ時に Kubernetes クラスターがトークンにアクセスできるように、トークンは Kubernetes の `imagePullSecret` 内に保管されている必要があります。クラスターが作成されると、{{site.data.keyword.containershort_notm}} によりこのトークンが Kubernetes `imagePullSecret` 内に自動的に保管されます。 `imagePullSecret` は、デフォルトの Kubernetes 名前空間、その名前空間の ServiceAccount 内のシークレットのデフォルト・リスト、kube-system 名前空間に追加されます。

**注:** この初期セットアップを使用すると、{{site.data.keyword.Bluemix_notm}} アカウントの名前空間にある任意のイメージのコンテナーを、クラスターの **default** 名前空間にデプロイできます。クラスター内のその他の名前空間内にコンテナーをデプロイする場合や、別の {{site.data.keyword.Bluemix_notm}} 地域か別の {{site.data.keyword.Bluemix_notm}} アカウントに保管されているイメージを使用する場合は、その[クラスター用に独自の imagePullSecret を作成](#bx_registry_other)しなければなりません。

コンテナーをクラスターの **default** 名前空間にデプロイするために、デプロイメント構成スクリプトを作成します。

1.  任意のエディターを開き、<em>mydeployment.yaml</em> という名前のデプロイメント構成スクリプトを作成します。
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

    **ヒント:** IBM 提供のパブリック・イメージなど、既存の構成スクリプトをデプロイすることもできます。この例では、米国南部地域の **ibmliberty** イメージを使用しています。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### 他の Kubernetes 名前空間へのイメージのデプロイまたは他の {{site.data.keyword.Bluemix_notm}} 地域やアカウント内のイメージへのアクセス
{: #bx_registry_other}

独自の imagePullSecret を作成すれば、他の Kubernetes 名前空間にコンテナーをデプロイしたり、他の {{site.data.keyword.Bluemix_notm}} 地域やアカウント内に保管されているイメージを使用したり、{{site.data.keyword.Bluemix_notm}} Dedicated 内に保管されているイメージを使用したりできます。

開始前に、以下のことを行います。

1.  [{{site.data.keyword.Bluemix_notm}} Public または {{site.data.keyword.Bluemix_notm}} Dedicated の {{site.data.keyword.registryshort_notm}} に名前空間をセットアップし、その名前空間にイメージをプッシュします。](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add)
2.  [クラスターを作成します](#cs_cluster_cli)。
3.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

独自の imagePullSecret を作成するには、以下のようにします。

**注:** ImagePullSecrets は、それらが作成された Kubernetes 名前空間に対してのみ有効です。プライベート・イメージからコンテナーをデプロイする名前空間ごとに、以下の手順を繰り返してください。

1.  トークンがまだない場合は、[アクセスするレジストリーのトークンを作成します。](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  {{site.data.keyword.Bluemix_notm}} アカウント内の使用可能なトークンのリストを表示します。

    ```
bx cr token-list```
    {: pre}

3.  使用するトークン ID をメモします。
4.  トークンの値を取得します。<token_id> を、前のステップで取得したトークンの ID に置き換えます。


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
    <th colspan=2><img src="images/idea.png"/> このコマンドの構成要素について</th>
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
    <td>必須。名前空間をセットアップするイメージ・レジストリーの URL。<ul><li>米国南部でセットアップした名前空間の場合: registry.ng.bluemix.net</li><li>英国南部でセットアップした名前空間の場合: registry.eu-gb.bluemix.net</li><li>中欧 (フランクフルト) でセットアップした名前空間の場合: registry.eu-de.bluemix.net</li><li>オーストラリア (シドニー) でセットアップした名前空間の場合: registry.au-syd.bluemix.net</li><li>{{site.data.keyword.Bluemix_notm}} Dedicated でセットアップした名前空間の場合: registry.<em>&lt;dedicated_domain&gt;</em></li></ul></td> 
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

6.  シークレットが正常に作成されたことを確認します。<em>&lt;kubernetes_namespace&gt;</em> を、imagePullSecret を作成した名前空間の名前に置き換えます。


    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  imagePullSecret を参照するポッドを作成します。
    1.  任意のエディターを開き、mypod.yaml という名前のポッド構成スクリプトを作成します。
    2.  ポッドと、プライベート
{{site.data.keyword.Bluemix_notm}} レジストリーへのアクセスに使用する imagePullSecret を定義します。名前空間からプライベート・イメージを使用するには、次のようにします。


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

        <table>
        <caption>表 4. YAML ファイルの構成要素について</caption>
        <thead>
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>クラスターにデプロイするコンテナーの名前。</td> 
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>イメージが保管されている名前空間。使用可能な名前空間をリストするには、`bx cr namespace-list` を実行します。</td> 
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

Docker Hub 内に保管されているパブリック・イメージを使用すれば、追加の構成を行わずにコンテナーをクラスターにデプロイできます。デプロイメント構成スクリプト・ファイルを作成するか、既存のものをデプロイします。

開始前に、以下のことを行います。

1.  [クラスターを作成します](#cs_cluster_cli)。
2.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

デプロイメント構成スクリプトを作成します。

1.  任意のエディターを開き、mydeployment.yaml という名前のデプロイメント構成スクリプトを作成します。
2.  デプロイメントと、Docker Hub 内の使用するパブリック・イメージを定義します。以下の構成スクリプトでは、Docker Hub にある使用可能パブリック・イメージ NGINX が使用されています。

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

    **ヒント:** 代わりに、既存の構成スクリプトをデプロイすることもできます。以下の例では同じパブリック NGINX イメージを使用しますが、クラスターに直接適用しています。

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### 他のプライベート・レジストリー内に保管されているプライベート・イメージへのアクセス
{: #private_registry}

既存のプライベート・レジストリーを使用する場合は、そのレジストリーの資格情報を Kubernetes imagePullSecret に保管し、構成スクリプト内でこのシークレットを参照する必要があります。

開始前に、以下のことを行います。

1.  [クラスターを作成します](#cs_cluster_cli)。
2.  [CLI のターゲットを自分のクラスターに設定します](cs_cli_install.html#cs_cli_configure)。

imagePullSecret を作成するには、以下のステップを実行します。

**注:** ImagePullSecrets は、それらが作成された対象の Kubernetes 名前空間に対して有効となります。プライベート {{site.data.keyword.Bluemix_notm}} レジストリー内のイメージからコンテナーをデプロイする名前空間ごとに、以下の手順を繰り返してください。

1.  プライベート・レジストリーの資格情報を保管する Kubernetes シークレットを作成します。

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}
    
    <table>
    <caption>表 5. このコマンドの構成要素について</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> このコマンドの構成要素について</th>
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
    1.  任意のエディターを開き、mypod.yaml という名前のポッド構成スクリプトを作成します。
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
        <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
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


## {{site.data.keyword.Bluemix_notm}} サービスをクラスターに追加する
{: #cs_cluster_service}

既存の {{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターに追加すると、クラスターのユーザーがアプリをクラスターにデプロイする際にその {{site.data.keyword.Bluemix_notm}} サービスにアクセスして使用できるようになります。
{:shortdesc}

開始前に、以下のことを行います。

-   [CLI のターゲットを](cs_cli_install.html#cs_cli_configure)自分のクラスターに設定します。

-   使用するスペースで、クラスターに追加する[{{site.data.keyword.Bluemix_notm}} サービスのインスタンスを要求します](/docs/services/reqnsi.html#req_instance)。
-   {{site.data.keyword.Bluemix_notm}} Dedicated ユーザーの場合は、代わりに [{{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) のクラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加する](#binding_dedicated)を参照してください。

**注:** サービス・キーをサポートする {{site.data.keyword.Bluemix_notm}} サービスだけを追加できます ([外部アプリが {{site.data.keyword.Bluemix_notm}} サービスを使用できるようにする](/docs/services/reqnsi.html#req_instance)のセクションにスクロールしてください)。

サービスを追加するには、以下のようにします。
2.  {{site.data.keyword.Bluemix_notm}} スペース内の既存のサービスをすべてリストします。


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

### {{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) のクラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加する
{: #binding_dedicated}

開始する前に、使用するスペースで、クラスターに追加する [{{site.data.keyword.Bluemix_notm}} サービスのインスタンスを要求します](/docs/services/reqnsi.html#req_instance)。

1.  サービス・インスタンスが作成された {{site.data.keyword.Bluemix_notm}} Dedicated 環境にログインします。

    ```
    bx login -a api.<dedicated_domain>
    ```
    {: pre}

2.  {{site.data.keyword.Bluemix_notm}} スペース内の既存のサービスをすべてリストします。


    ```
bx service list```
    {: pre}

    CLI 出力例:

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  ユーザー名、パスワード、URL など、サービスに関する機密情報を含むサービス資格情報キーを作成します。


    ```
    bx service key-create <service_name> <service_key_name>
    ```
    {: pre}

4.  サービス資格情報キーを使用して、サービスに関する機密情報を含む JSON ファイルをコンピューター上に作成します。


    ```
    bx service key-show <service_name> <service_key_name>| sed -n '/{/,/}/'p >> /filepath/<dedicated-service-key>.json
    ```
    {: pre}

5.  {{site.data.keyword.containershort_notm}} のパブリック・エンドポイントにログインし、CLI のターゲットを {{site.data.keyword.Bluemix_notm}} Dedicated 環境内のクラスターにします。
    1.  {{site.data.keyword.containershort_notm}} のパブリック・エンドポイントを使用してアカウントにログインします。{{site.data.keyword.Bluemix_notm}} 資格情報を入力し、プロンプトが出されたら、{{site.data.keyword.Bluemix_notm}} Dedicated アカウントを選択します。

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

6.  サービス資格情報 JSON ファイルから Kubernetes シークレットを作成します。

    ```
    kubectl create secret generic <secret_name> --from-file=/filepath/<dedicated-service-key>.json
    ```
    {: pre}

7.  使用する {{site.data.keyword.Bluemix_notm}} サービスごとに、これらの手順を繰り返します。


 {{site.data.keyword.Bluemix_notm}} サービスがクラスターにバインドされ、そのクラスターにデプロイされたポッドで使用できるようになりました。
ポッドでサービスを使用するには、クラスター・ユーザーは、[
Kubernetes シークレットをシークレット・ボリュームとしてポッドにマウント](cs_apps.html#cs_apps_service)して、{{site.data.keyword.Bluemix_notm}} サービスのサービス資格情報にアクセスします。


## クラスター・アクセス権限の管理
{: #cs_cluster_user}

クラスターへのアクセス権限を他のユーザーに付与することができます。そのようにすると、それらのユーザーがクラスターにアクセスして、クラスターを管理し、アプリをクラスターにデプロイすることができます。{:shortdesc}

{{site.data.keyword.containershort_notm}} で操作をするすべてのユーザーに、「ID およびアクセス管理」でサービス固有のユーザー役割を割り当てる必要があります。割り当てられるユーザー役割によって、そのユーザーが実行できるアクションが決まります。「ID およびアクセス管理」では、次のアクセス許可を区別します。


-   {{site.data.keyword.containershort_notm}} アクセス・ポリシー

    アクセス・ポリシーは、クラスターで実行できるクラスター管理アクション (クラスターの作成または削除、ワーカー・ノードの追加または削除など) を判別します。

<!-- If you want to prevent a user from deploying apps to a cluster or creating other Kubernetes resources, you must create RBAC policies for the cluster. -->

-   Cloud Foundry の役割

    すべてのユーザーに、Cloud Foundry ユーザー役割を割り当てる必要があります。この役割は、ユーザーが {{site.data.keyword.Bluemix_notm}} アカウントで実行できるアクション (他のユーザーの招待や割り当て分の使用率の表示など) を決定します。それぞれの役割の許可を確認するには、[Cloud Foundry の役割](/docs/iam/users_roles.html#cfroles)を参照してください。

-   RBAC 役割

    {{site.data.keyword.containershort_notm}} アクセス・ポリシーが割り当てられているすべてのユーザーには、RBAC 役割が自動的に割り当てられます。RBAC 役割によって、クラスター内の Kubernetes リソースに対して実行できるアクションが決まります。RBAC 役割は、デフォルトの名前空間に関してのみセットアップされます。クラスター管理者は、クラスター内の他の名前空間の RBAC 役割を追加できます。詳しくは、Kubernetes 資料の [Using RBAC Authorization ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) を参照してください。



実行するアクションを次の中から選択してください。

-   [クラスターで操作をするために必要なアクセス・ポリシーと許可を確認する](#access_ov)。
-   [現在のアクセス・ポリシーを表示する](#view_access)。
-   [既存のユーザーのアクセス・ポリシーを変更する](#change_access)。
-   [{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加する](#add_users)。

### 必要な {{site.data.keyword.containershort_notm}} アクセス・ポリシーと許可の概要
{: #access_ov}

{{site.data.keyword.Bluemix_notm}} アカウント内のユーザーに付与できるアクセス・ポリシーと許可について説明します。

|アクセス・ポリシー|クラスター管理許可|Kubernetes リソース許可|
|-------------|------------------------------|-------------------------------|
|<ul><li>役割: 管理者</li><li>サービス・インスタンス: すべての現行サービス・インスタンス</li></ul>|<ul><li>ライト・クラスターまたは標準クラスターを作成する</li><li>{{site.data.keyword.BluSoftlayer_notm}} ポートフォリオにアクセスするための {{site.data.keyword.Bluemix_notm}} アカウントの資格情報を設定する</li><li>クラスターを削除する</li><li>対象アカウント内の他の既存ユーザーの {{site.data.keyword.containershort_notm}} アクセス・ポリシーの割り当てと変更。</li></ul><br/>この役割は、対象アカウントのすべてのクラスターのエディター、オペレーター、およびビューアーの役割から許可を継承します。|<ul><li>RBAC 役割: クラスター管理</li><li>すべての名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li></ul>|
|<ul><li>役割: 管理者</li><li>サービス・インスタンス: 特定のクラスター ID</li></ul>|<ul><li>特定のクラスターを削除する。</li></ul><br/>この役割は、選択したクラスターのエディター、オペレーター、およびビューアーの役割から許可を継承します。|<ul><li>RBAC 役割: クラスター管理</li><li>すべての名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li><li>Kubernetes ダッシュボードにアクセスする</li></ul>|
|<ul><li>役割: オペレーター
</li><li>サービス・インスタンス: すべての現行サービス・インスタンス/特定のクラスター ID</li></ul>|<ul><li>クラスターにワーカー・ノードを追加する</li><li>クラスターからワーカー・ノードを削除する</li><li>ワーカー・ノードをリブートする</li><li>ワーカー・ノードを再ロードする</li><li>クラスターにサブネットを追加する</li></ul>|<ul><li>RBAC 役割: 管理者</li><li>名前空間自体ではなく、デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li><li>名前空間内で役割を作成する</li></ul>|
|<ul><li>役割: エディター</li><li>サービス・インスタンス: すべての現行サービス・インスタンス/特定のクラスター ID</li></ul>|<ul><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにバインドします。</li><li>{{site.data.keyword.Bluemix_notm}} サービスをクラスターにアンバインドします。</li><li>Web フックを作成します。</li></ul><br/>アプリ開発者には、この役割を使用してください。|<ul><li>RBAC 役割: 編集</li><li>デフォルトの名前空間内にあるリソースに対する読み取り/書き込みアクセス</li></ul>|
|<ul><li>役割: ビューアー</li><li>サービス・インスタンス: すべての現行サービス・インスタンス/特定のクラスター ID</li></ul>|<ul><li>クラスターをリスト表示する</li><li>クラスターの詳細を表示する</li></ul>|<ul><li>RBAC 役割: 表示</li><li>デフォルトの名前空間内にあるリソースに対する読み取りアクセス</li><li>Kubernetes シークレットに対する読み取りアクセス権限はなし</li></ul>|
|<ul><li>Cloud Foundry の組織の役割: 管理者</li></ul>|<ul><li>{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加する</li></ul>||
|<ul><li>Cloud Foundry のスペースの役割: 開発者</li></ul>|<ul><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスを作成する><li>{{site.data.keyword.Bluemix_notm}} サービス・インスタンスをクラスターにバインドする</li></ul>||
{: caption="表 7. 必要な IBM Bluemix Container Service のアクセス・ポリシーと許可の概要" caption-side="top"}

### {{site.data.keyword.containershort_notm}} アクセス・ポリシーの検証
{: #view_access}

割り当てた {{site.data.keyword.containershort_notm}} のアクセス・ポリシーを確認および検証できます。アクセス・ポリシーによって、実行できるクラスター管理アクションが決まります。

1.  {{site.data.keyword.containershort_notm}} アクセス・ポリシーを検証する {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
2.  メニュー・バーから、**「管理」** > **「セキュリティー」** > **「ID およびアクセス」**の順にクリックします。**「ユーザー」**ウィンドウに、選択したアカウントのユーザーのリストが E メール・アドレスおよび現在の状況とともに表示されます。
3.  アクセス・ポリシーを検査するユーザーを選択します。
4.  「**サービス・ポリシー**」セクションで、対象ユーザーのアクセス・ポリシーを確認します。この役割で実行できるアクションの詳細については、[必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要](#access_ov)を参照してください。
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
4.  **「アクション」**タブで、**「ポリシーの割り当て」**をクリックします。
5.  **「サービス」**ドロップダウン・リストで、**「{{site.data.keyword.containershort_notm}}」**を選択します。
6.  **「役割」** ドロップダウン・リストから、割り当てるアクセス・ポリシーを選択します。特定の地域またはクラスターに限定せずに役割を選択すると、そのアカウントで作成されたすべてのクラスターにそのアクセス・ポリシーが自動的に適用されます。特定のクラスターまたは地域にアクセス権限を限定する場合は、**「サービス・インスタンス」**ドロップダウン・リストと**「地域」**ドロップダウン・リストから選択します。アクセス・ポリシー別のサポート対象アクションの一覧については、[必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要](#access_ov)を参照してください。特定のクラスターの ID を確認するには、
`bx cs clusters` を実行します。
7.  **「ポリシーの割り当て」**をクリックして変更を保存します。

### {{site.data.keyword.Bluemix_notm}} アカウントへのユーザーの追加
{: #add_users}

{{site.data.keyword.Bluemix_notm}} アカウントにユーザーを追加して、クラスターへのアクセス権限を付与できます。

始める前に、{{site.data.keyword.Bluemix_notm}} アカウントに対する Cloud Foundry の管理者役割が自分に割り当てられていることを確認してください。

1.  ユーザーを追加する {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
2.  メニュー・バーから、**「管理」** > **「セキュリティー」** > **「ID およびアクセス」**の順にクリックします。「ユーザー」ウィンドウに、選択したアカウントのユーザーのリストが E メール・アドレスおよび現在の状況とともに表示されます。
3.  **「ユーザーの招待」**をクリックします。
4.  **「E メール・アドレスまたは既存の IBMid」**に、{{site.data.keyword.Bluemix_notm}} アカウントに追加するユーザーの E メール・アドレスを入力します。
5.  **「アクセス」**セクションで、**「ID およびアクセス対応サービス」**を展開します。
6.  **「サービス」**ドロップダウン・リストで、**「{{site.data.keyword.containershort_notm}}」**を選択します。
7.  **「役割」**ドロップダウン・リストで、割り当てるアクセス・ポリシーを選択します。特定の地域またはクラスターに限定しないで役割を選択すると、対象アカウント内で作成されたすべてのクラスターにそのアクセス・ポリシーが自動的に適用されます。特定のクラスターまたは地域にアクセス権限を限定する場合は、**「サービス・インスタンス」**ドロップダウン・リストと**「地域」**ドロップダウン・リストから選択します。アクセス・ポリシー別のサポート対象アクションの一覧については、[必要な {{site.data.keyword.containershort_notm}} のアクセス・ポリシーと許可の概要](#access_ov)を参照してください。特定のクラスターの ID を確認するには、
`bx cs clusters` を実行します。
8.  「**Cloud Foundry アクセス権限**」セクションを展開し、ユーザーを追加する {{site.data.keyword.Bluemix_notm}} 組織を「**組織**」ドロップダウン・リストから選択します。
9.  **「スペースの役割」**ドロップダウン・リストから、任意の役割を選択します。Kubernetes クラスターは、{{site.data.keyword.Bluemix_notm}} のスペースからは独立しています。このユーザーが他のユーザーを {{site.data.keyword.Bluemix_notm}} アカウントに追加できるようにするには、そのユーザーに Cloud Foundry の**組織の役割**を割り当てる必要があります。ただし、Cloud Foundry の組織の役割は、この後の手順でのみ割り当てられます。
10. **「ユーザーの招待」**をクリックします。
11. オプション: **「ユーザー」**の概要の**「アクション」**タブで、**「ユーザーの管理」**を選択します。
12. オプション: **「Cloud Foundry の役割」**セクションで、前の手順で追加したユーザーに付与した
Cloud Foundry の組織の役割を見つけます。
13. オプション: **「アクション」**タブから、**「組織の役割の編集」**を選択します。
14. オプション: **「組織の役割」**ドロップダウン・リストから、**「管理者」**を選択します。
15. オプション: **「役割の保存」**をクリックします。

## クラスターへのサブネットの追加
{: #cs_cluster_subnet}

クラスターにサブネットを追加して、使用可能なポータブル・パブリック IP アドレスのプールを変更します。
{:shortdesc}

{{site.data.keyword.containershort_notm}} では、クラスターにネットワーク・サブネットを追加して、Kubernetes サービス用の安定したポータブル IP を追加できます。
標準クラスターを作成すると、{{site.data.keyword.containershort_notm}} は、ポータブル・パブリック・サブネット 1 つと IP アドレス 5 つを自動的にプロビジョンします。
ポータブル・パブリック IP アドレスは静的で、ワーカー・ノードまたはクラスターが削除されても変更されません。

1 つのポータブル・パブリック IP アドレスは、[Ingress コントローラー](cs_apps.html#cs_apps_public_ingress)用に使用されます。このコントローラーは、パブリック経路を使用してクラスター内の複数のアプリを公開するために使用できます。残りの 4 つのポータブル・パブリック IP アドレスは、[ロード・バランサー・サービスを作成して](cs_apps.html#cs_apps_public_load_balancer)単一アプリをパブリックに公開するために使用できます。

**注:** ポータブル IP アドレスは、月単位で課金されます。クラスターのプロビジョンの後にポータブル・パブリック IP アドレスを削除する場合、短時間しか使用しない場合でも月額課金を支払う必要があります。


### クラスターのその他のサブネットの要求
{: #add_subnet}

クラスターにサブネットを割り当て、安定したポータブル・パブリック IP をクラスターに追加できます。


 {{site.data.keyword.Bluemix_notm}} Dedicated ユーザーは、このタスクを使用する代わりに、[サポート・チケットを開いて](/docs/support/index.html#contacting-support)サブネットを作成した後に、[`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) コマンドを使用してクラスターにサブネットを追加する必要があります。

始める前に、{{site.data.keyword.BluSoftlayer_notm}} ポートフォリオに {{site.data.keyword.Bluemix_notm}} GUI を使用してアクセスできることを確認してください。ポートフォリオにアクセスするには、{{site.data.keyword.Bluemix_notm}} 従量課金 (PAYG) アカウントをセットアップするか、既存の PAYG アカウントを使用する必要があります。

1.  カタログの「**インフラストラクチャー**」セクションで、
「**ネットワーク**」を選択します。
2.  **「サブネット/IP (Subnet/IPs)」**を選択し、
**「作成」**をクリックします。
3.  **「このアカウントに追加するサブネットのタイプの選択 (Select the type of subnet to add to this account)」**ドロップダウン・メニューから、**「ポータブル・パブリック」**を選択します。
4.  ポータブル・サブネットから追加する IP アドレスの数を選択します。

    **注:** サブネットのポータブル・パブリック IP アドレスを追加する場合、3 つの IP アドレスはクラスター内ネットワークの確立のために使用されるため、これらのアドレスは、Ingress コントローラーでは、あるいはロード・バランサー・サービスの作成には使用できません。例えば、8 個のポータブル・パブリック IP アドレスを要求する場合は、そのうちの 5 個を、アプリをパブリックに公開するために使用できます。

5.  ポータブル・パブリック IP アドレスのルーティング先となるパブリック VLAN を選択します。既存のワーカー・ノードが接続されているパブリック VLAN を選択する必要があります。ワーカー・ノードのパブリック VLAN を確認してください。


    ```
    bx cs worker-get <worker_id>
    ```
    {: pre}

6.  質問に対して入力し、**「注文する (Place order)」**をクリックします。

    **注:** ポータブル・パブリック IP アドレスは月単位で課金されます。ポータブル・パブリック IP アドレスを作成した後にそれを削除する場合、月の途中までしか使用していない場合であっても、月額課金を支払う必要があります。<!-- removed conref to test bx login -->
7.  サブネットがプロビジョンされた後、Kubernetes クラスターでそのサブネットを利用できるようにします。
    1.  「インフラストラクチャー」ダッシュボードで、作成したサブネットを選択し、サブネットの ID をメモします。
    2.  {{site.data.keyword.Bluemix_notm}} CLI にログインします。

        ```
bx login```
        {: pre}

        特定の {{site.data.keyword.Bluemix_notm}} 地域を指定するには、次のいずれかの API エンドポイントを選択します。

       -  米国南部

           ```
bx login -a api.ng.bluemix.net```
           {: pre}
     
       -  シドニー

           ```
bx login -a api.au-syd.bluemix.net```
           {: pre}

       -  ドイツ


           ```
          bx login -a api.eu-de.bluemix.net
          ```
           {: pre}

       -  英国

           ```
bx login -a api.eu-gb.bluemix.net```
           {: pre}

    3.  アカウント内のすべてのクラスターをリスト表示し、サブネットを使用できるようにするクラスターの ID をメモします。

        ```
bx cs clusters```
        {: pre}

    4.  サブネットをクラスターに追加します。クラスターでサブネットを使用できるようにすると、使用できるすべての使用可能なポータブル・パブリックIP アドレスが含まれる Kubernetes config マップが作成されます。クラスター用の Ingress コントローラーが存在しない場合は、Ingress コントローラーの作成用に、ポータブル・パブリック IP アドレスの 1 つが自動的に使用されます。
その他のすべてのポータブル・パブリック IP アドレスは、アプリのロード・バランサー・サービスの作成に使用できます。


        ```
        bx cs cluster-subnet-add <cluster name or id> <subnet id>
        ```
        {: pre}

8.  クラスターにサブネットが正常に追加されたことを確認します。**Bound Cluster** 列にクラスター ID がリストされます。


    ```
bx cs subnets```
    {: pre}

### Kubernetes クラスターへの既存のカスタム・サブネットの追加
{: #custom_subnet}

既存のポータブル・パブリック・サブネットを Kubernetes クラスターに追加できます。

始めに、[CLI のターゲット](cs_cli_install.html#cs_cli_configure)を自分のクラスターに設定してください。

{{site.data.keyword.BluSoftlayer_notm}} ポートフォリオにある、カスタム・ファイアウォール・ルールまたは使用可能な IP アドレスが設定された既存のサブネットを使用する場合は、サブネットなしでクラスターを作成し、クラスターをプロビジョンするときに既存のサブネットをクラスターで使用できるようにします。


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

3.  確認したロケーションと VLAN ID を使用して、クラスターを作成します。新しいポータブル・パブリック IP サブネットが自動的に作成されないように、`--no-subnet` フラグを含めてください。


    ```
    bx cs cluster-create --location dal10 --machine-type u1c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster 
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


## クラスターでの既存の NFS ファイル共有の使用
{: #cs_cluster_volume_create}

{{site.data.keyword.BluSoftlayer_notm}} アカウントにある既存の NFS ファイル共有を Kubernetes で使用するには、その既存のファイル共有上に永続ボリュームを作成します。永続ボリュームとは、Kubernetes クラスター・リソースとして機能する実際のハードウェアの一片であり、クラスター・ユーザーによって使用されます。
{:shortdesc}

始める前に、永続ボリュームの作成に使用できる既存の NFS ファイル共有があることを確認します。


[![永続ボリュームと永続ボリューム請求の作成](images/cs_cluster_pv_pvc.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_cluster_pv_pvc.png)

Kubernetes は永続ボリューム (実際のハードウェアを表す) と、永続ボリューム請求 (ストレージの要求。通常はクラスター・ユーザーにより開始される) とを区別します。
既存の NFS ファイル共有を Kubernetes で使用できるようにする場合、特定のサイズとアクセス・モードを持つ永続ボリュームを作成し、その永続ボリュームの仕様と一致する永続ボリューム請求を作成する必要があります。
永続ボリュームと永続ボリューム請求が一致すると、それらは相互にバインドされます。
クラスター・ユーザーがポッドへのボリュームのマウントに使用できるのは、バインドされた永続ボリューム請求だけです。
この処理は永続ストレージの静的プロビジョニングと呼ばれます。

**注:** 永続ストレージの静的プロビジョニングは既存の NFS ファイル共有にのみ適用されます。既存の NFS ファイル共有がない場合、クラスター・ユーザーは[動的プロビジョニング](cs_apps.html#cs_apps_volume_claim)処理を使用して永続ボリュームを追加できます。

永続ボリューム、およびそれと一致する永続ボリューム請求を作成するには、次の手順を実行します。

1.  {{site.data.keyword.BluSoftlayer_notm}} アカウントで、永続ボリューム・オブジェクトを作成する NFS ファイル共有の ID とパスを検索します。
    1.  {{site.data.keyword.BluSoftlayer_notm}} アカウントにログインします。
    2.  **「ストレージ」**をクリックします。
    3.  **「ファイル・ストレージ」**をクリックし、使用する NFS ファイル共有の ID とパスをメモします。

2.  任意のエディターを開きます。
3.  永続ボリュームのストレージ構成スクリプトを作成します。

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
    <th colspan=2><img src="images/idea.png"/> YAML ファイルの構成要素について</th>
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

6.  永続ボリューム請求を作成するために、別の構成スクリプトを作成します。永続ボリューム請求が、前の手順で作成した永続ボリューム・オブジェクトと一致するようにするには、`storage` および
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


## Kubernetes クラスター・リソースの視覚化
{: #cs_weavescope}

Weave Scope は、Kubernetes クラスター内のリソース (サービス、ポッド、コンテナー、プロセス、ノードなど) のビジュアル図を表示します。Weave Scope は CPU とメモリーのインタラクティブ・メトリックを示し、コンテナーの中で追尾したり実行したりするツールも備えています。
{:shortdesc}

開始前に、以下のことを行います。

-   クラスター情報を公共のインターネットに公開しないようにしてください。安全に Weave Scope をデプロイして Web ブラウザーからローカル・アクセスするには、以下の手順を実行します。

-   標準クラスターがまだない場合は、[標準クラスターを作成します](#cs_cluster_ui)。Weave Scope は、アプリでは特に、CPU の負荷が大きくなります。
ライト・クラスターではなく、比較的大規模な標準クラスターで Weave Scope を実行してください。
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
トポロジー・ダイアグラムを表示するか、クラスター内の Kubernetes リソースの表を表示します。

     <img src="images/weave_scope.png" alt="Weave Scope のトポロジーの例" style="width:357px;" /> 


[Weave Scope の機能についての詳細 ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://www.weave.works/docs/scope/latest/features/)。

## クラスターの削除
{: #cs_cluster_remove}

クラスターの使用を終了したとき、クラスターがリソースを消費しないように削除することができます。
{:shortdesc}

標準アカウントまたは {{site.data.keyword.Bluemix_notm}} 従量制課金アカウントで作成したライト・クラスターおよび標準クラスターが不要になった場合は、ユーザーが手動で削除する必要があります。無料試用版のアカウントで作成したライト・クラスターは、無料試用期間が終了すると自動的に削除されます。


クラスターを削除すると、コンテナー、ポッド、バインド済みサービス、シークレットなど、クラスター上のリソースも削除されます。
クラスターを削除するときにストレージを削除しない場合は、{{site.data.keyword.Bluemix_notm}} GUI 内の {{site.data.keyword.BluSoftlayer_notm}} ダッシュボードを使用してストレージを削除できます。毎月の課金サイクルの規定で、永続ボリューム請求を月の最終日に削除することはできません。
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

クラスターを削除しても、ポータブル・パブリック・サブネットとプライベート・サブネットは自動的には削除されません。サブネットは、ポータブル・パブリック IP アドレスをロード・バランサー・サービスまたは Ingress コントローラーに割り当てるときに使用されます。サブネットは、手動で削除するか、新しいクラスターで再利用することができます。

