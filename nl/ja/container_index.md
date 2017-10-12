---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-014"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# {{site.data.keyword.containerlong_notm}} 概説
{: #container_index}

{{site.data.keyword.IBM}} クラウドの Docker コンテナーと Kubernetes クラスターの中で可用性の高いアプリを管理します。コンテナーとは、アプリとそのすべての従属物をパッケージ化して、アプリを変更せずに環境間で移動して実行できるようにするための標準的な手段です。仮想マシンとは異なり、コンテナーはオペレーティング・システムをバンドルしません。 コンテナー内には、アプリ・コード、ランタイム、システム・ツール、ライブラリー、そして設定値のみパッケージされます。
そのためコンテナーは、仮想マシンよりも軽量、ポータブル、効率的です。


開始するための以下のオプションをクリックしてください。

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Bluemix Public を使用すると、Kubernetes クラスターを作成したり、単一コンテナーまたはスケーラブル・コンテナー・グループをクラスターにマイグレーションしたりできます。Bluemix Dedicated を使用する場合については、このアイコンをクリックして、選択可能なオプションを参照してください。" style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Bluemix の Kubernetes クラスターの概説" title="Bluemix の Kubernetes クラスターの概説" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_classic.html#cs_classic" alt="IBM Bluemix Container Service での単一コンテナーとスケーラブル・コンテナーの実行" title="IBM Bluemix Container Service での単一コンテナーとスケーラブル・コンテナーの実行" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_ov.html#dedicated_environment" alt="Bluemix Dedicated クラウド環境" title="Bluemix Dedicated クラウド環境" shape="rect" coords="326, -10, 448, 218" />
</map>


## {{site.data.keyword.Bluemix_notm}} のクラスターの概説
{: #clusters}

Kubernetes は、コンピュート・マシン・クラスターのアプリ・コンテナーのスケジュールを管理するためのオーケストレーション・ツールです。Kubernetes を使用すると、開発者はコンテナーの高度な機能や柔軟性を活用して、可用性の高いアプリケーションを短時間で開発できます。
{:shortdesc}

Kubernetes を使用してアプリをデプロイするには、最初にクラスターを作成します。クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。

ライト・クラスターを作成するには、以下のようにします。

1.  [**「カタログ」**![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/catalog/?category=containers) から、**「コンテナー」**カテゴリーの**「Kubernetes クラスター」**をクリックします。

2.  クラスターの詳細情報を入力します。デフォルトのクラスター・タイプはライトなので、カスタマイズするフィールドはわずかしかありません。次は、標準クラスターを作成し、クラスター内のワーカー・ノード数などの追加のカスタマイズを定義できます。
    1.  **クラスター名**を入力します。
    2.  クラスターをデプロイする**場所**を選択します。選択可能な場所は、ログインしている地域によって異なります。最高のパフォーマンスを得るために、物理的に最も近い地域を選択してください。


    使用可能な場所は、次のとおりです。

    <ul><li>米国南部<ul><li>dal10 [Dallas (ダラス)]</li><li>dal12 [Dallas (ダラス)]</li></ul></li><li>英国南部<ul><li>lon02 [London (ロンドン)]</li><li>lon04 [London (ロンドン)]</li></ul></li><li>中欧<ul><li>ams03 [Amsterdam (アムステルダム)]</li><li>ra02 [Frankfurt (フランクフルト)]</li></ul></li><li>南アジア太平洋地域<ul><li>syd01 [Sydney (シドニー)]</li><li>syd04 [Sydney (シドニー)]</li></ul></li></ul>
        
3.  **「クラスターの作成」**をクリックします。クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。**「ワーカー・ノード」**タブでワーカー・ノードの状況を確認できます。状況が `Ready` になったら、ワーカー・ノードを使用できます。

おつかれさまでした。これで、1 つ目のクラスターが作成されました。


*   ライト・クラスターでは、CPU 2 つとメモリー 4 GB を備えたワーカー・ノード 1 つを、アプリで使用できます。
*   ワーカー･ノードは、専用かつ可用性の高い {{site.data.keyword.IBM_notm}} 所有の Kubernetes マスターにより一元的にモニターされ、管理されます。Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを制御および管理します。作業担当者はこのマスターの管理のことは気にせずに、ワーカー・ノードとそのワーカー・ノードにデプロイされるアプリに集中できます。
*   VLANS や IP アドレスなどの、クラスターの実行に必要なリソースは、{{site.data.keyword.IBM_notm}} 所有の {{site.data.keyword.BluSoftlayer_full}} アカウントで管理されます。標準クラスターの作成時は、独自の {{site.data.keyword.BluSoftlayer_notm}} アカウントでこれらのリソースを管理します。標準クラスターの作成時に、これらのリソースの詳細を確認できます。
*   **ヒント:** {{site.data.keyword.Bluemix_notm}} 無料試用アカウントを使用して作成したライト・クラスターは、[{{site.data.keyword.Bluemix_notm}} 従量制課金 (PAYG) アカウントにアップグレード](/docs/pricing/billable.html#upgradetopayg)しないと、無料試用期間の終了後に自動的に削除されます。


**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

* [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
* [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
* [可用性を高めるために、複数のノードを使用する標準クラスターを作成します。](cs_cluster.html#cs_cluster_ui)
* [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)


## {{site.data.keyword.Bluemix_notm}} Dedicated (最終ベータ版) のクラスターの概説
{: #dedicated}

Kubernetes は、コンピュート・マシン・クラスターのアプリ・コンテナーのスケジュールを管理するためのオーケストレーション・ツールです。Kubernetes を使用すると、開発者は {{site.data.keyword.Bluemix_notm}} Dedicated インスタンスのコンテナーの高度な機能や柔軟性を活用して、可用性の高いアプリケーションを短時間で開発できます。{:shortdesc}

始める前に、 [{{site.data.keyword.Bluemix_notm}} Dedicated 環境をセットアップします。](cs_ov.html#setup_dedicated)その後、クラスターを作成できます。クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。クラスターを作成したら、そのクラスターにアプリをデプロイできます。

**ヒント:** 組織にまだ {{site.data.keyword.Bluemix_notm}} Dedicated 環境がない場合は、この環境が不要な可能性があります。[まず {{site.data.keyword.Bluemix_notm}} Public 環境で専用の標準クラスターを試してください。](cs_cluster.html#cs_cluster_ui)

{{site.data.keyword.Bluemix_notm}} Dedicated でクラスターをデプロイするには、以下の手順を実行します。

1.  IBMID を使用して {{site.data.keyword.Bluemix_notm}} Public コンソール ([https://console.bluemix.net ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/catalog/?category=containers)) にログインします。クラスターは {{site.data.keyword.Bluemix_notm}} Public から要求する必要がありますが、クラスターがデプロイされるのは {{site.data.keyword.Bluemix_notm}} Dedicated アカウントです。
2.  複数のアカウントがある場合は、アカウント・メニューで {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
3.  「カタログ」から、**「コンテナー」**カテゴリーの**「Kubernetes クラスター」**をクリックします。
4.  クラスターの詳細情報を入力します。
    1.  **クラスター名**を入力します。
    2.  ワーカー・ノードで使用する **Kubernetes バージョン**を選択します。
 
    3.  **マシン・タイプ**を選択します。
各ワーカー・ノードにセットアップされる (ノードにデプロイされるすべてのコンテナーで使用できる) 仮想 CPU とメモリーの量は、マシン・タイプによって決まります。

    4.  必要な**ワーカー・ノードの数**を選択します。
クラスターの可用性を高くするためには 3 を選択します。
    
{{site.data.keyword.Bluemix_notm}} Dedicated アカウントの作成プロセス中にクラスター・タイプ、場所、パブリック VLAN、プライベート VLAN、ハードウェアのフィールドが定義されるので、これらの値を調整する必要はありません。5.  **「クラスターの作成」**をクリックします。クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。
**「ワーカー・ノード」**タブで、ワーカー・ノードの状況を確認できます。状況が `Ready` になったら、ワーカー・ノードを使用できます。

    ワーカー･ノードは、専用かつ可用性の高い {{site.data.keyword.IBM_notm}} 所有の Kubernetes マスターにより一元的にモニターされ、管理されます。Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを制御および管理します。お客様は、このマスターの管理についても気にすることなく、ワーカー・ノードとそのワーカー・ノードにデプロイしたアプリに集中できます。

おつかれさまでした。これで、1 つ目のクラスターが作成されました。



**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

* [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
* [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
* [クラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加します。](cs_cluster.html#binding_dedicated)
* [{{site.data.keyword.Bluemix_notm}} Dedicated と Public のクラスターの相違点について理解します。](cs_ov.html#env_differences)

