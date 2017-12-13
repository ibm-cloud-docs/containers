---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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

Kubernetes クラスターで稼動する Docker コンテナーに可用性の高いアプリをデプロイすることによって、{{site.data.keyword.Bluemix_notm}} ですぐに作業を始めることができます。コンテナーは、環境間でアプリをシームレスに移動できるようにアプリとそのすべての従属物をパッケージ化するための標準的な手段です。仮想マシンとは異なり、コンテナーはオペレーティング・システムをバンドルしません。 アプリのコード、ランタイム、システム・ツール、ライブラリー、設定値のみがコンテナー内にパッケージされます。コンテナーは、仮想マシンより軽量で移植しやすく、効率的です。
{:shortdesc}


開始するための以下のオプションをクリックしてください。

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="{{site.data.keyword.Bluemix_notm}} Public を使用すると、Kubernetes クラスターを作成したり、単一のスケーラブルなコンテナー・グループをクラスターにマイグレーションしたりすることができます。{{site.data.keyword.Bluemix_dedicated_notm}} でこのアイコンをクリックすると、オプションが表示されます。" style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="{{site.data.keyword.Bluemix_notm}} の Kubernetes クラスターの概説" title="{{site.data.keyword.Bluemix_notm}} の Kubernetes クラスターの概説" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_classic.html#cs_classic" alt="{{site.data.keyword.containershort_notm}} での単一コンテナーとスケーラブル・コンテナーの実行" title="{{site.data.keyword.containershort_notm}} での単一コンテナーとスケーラブル・コンテナーの実行" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_ov.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} クラウド環境" title="{{site.data.keyword.Bluemix_notm}} クラウド環境" shape="rect" coords="326, -10, 448, 218" />
</map>


## クラスターの概説
{: #clusters}

コンテナーにアプリをデプロイするときには、その前に、まず Kubernetes クラスターを作成してください。Kubernetes はコンテナー用のオーケストレーション・ツールです。Kubernetes を使用すると、開発者はクラスターの高度な機能や柔軟性を活用して、可用性の高いアプリをすぐにデプロイできます。
{:shortdesc}

ところで、クラスターとは一体何でしょうか。クラスターとは、アプリの高可用性を維持する一連のリソース、ワーカー・ノード、ネットワーク、ストレージ・デバイスのことです。クラスターを作成したら、アプリをコンテナーにデプロイできます。


ライト・クラスターを作成するには、以下のようにします。

1.  [**「カタログ」**![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/catalog/?category=containers) から、**「コンテナー」**カテゴリーの**「Kubernetes クラスター」**をクリックします。

2.  **クラスター名**を入力します。デフォルトのクラスター・タイプはライトです。次は、標準クラスターを作成し、クラスター内のワーカー・ノード数などの追加のカスタマイズを定義できます。

3.  **「クラスターの作成」**をクリックします。クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。**「ワーカー・ノード」**タブでワーカー・ノードの状況を確認できます。状況が `Ready` になったら、ワーカー・ノードを使用できます。

おつかれさまでした。これで、1 つ目のクラスターが作成されました。

*   ライト・クラスターでは、CPU 2 つとメモリー 4 GB を備えたワーカー・ノード 1 つを、アプリで使用できます。
*   ワーカー･ノードは、専用かつ可用性の高い {{site.data.keyword.IBM_notm}} 所有の Kubernetes マスターにより一元的にモニターされ、管理されます。Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを制御および管理します。作業担当者はこのマスターの管理のことは気にせずに、ワーカー・ノードとそのワーカー・ノードにデプロイされるアプリに集中できます。
*   VLANS や IP アドレスなどの、クラスターの実行に必要なリソースは、{{site.data.keyword.IBM_notm}} 所有の IBM Cloud インフラストラクチャー (SoftLayer) アカウントで管理されます。標準クラスターの作成時は、独自の IBM Cloud インフラストラクチャー (SoftLayer) アカウントでこれらのリソースを管理します。標準クラスターの作成時に、これらのリソースの詳細を確認できます。
*   **ヒント:** {{site.data.keyword.Bluemix_notm}} ライト・アカウントを使用すると、2 つの CPU と 4 GB の RAM を備えた 1 つのライト・クラスターを作成し、ライト・サービスと統合できます。より多くのクラスターを作成し、各種マシン・タイプを使用し、サービス全体を利用するには、[{{site.data.keyword.Bluemix_notm}} 従量課金 (PAYG) アカウントにアップグレード](/docs/pricing/billable.html#upgradetopayg)してください。


**次の作業**

クラスターが稼働状態になったら、クラスターを使用した作業を開始してください。

* [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
* [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
* [可用性を高めるために、複数のノードを使用する標準クラスターを作成します。](cs_cluster.html#cs_cluster_ui)
* [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)


## {{site.data.keyword.Bluemix_dedicated_notm}} (最終ベータ版) のクラスターの概説
{: #dedicated}

Kubernetes は、コンピュート・マシン・クラスターのアプリ・コンテナーのスケジュールを管理するためのオーケストレーション・ツールです。Kubernetes を使用すると、開発者は {{site.data.keyword.Bluemix_dedicated_notm}} インスタンスのコンテナーの高度な機能や柔軟性を活用して、可用性の高いアプリケーションを短時間で開発できます。
{:shortdesc}

始める前に、[クラスターを使用するように {{site.data.keyword.Bluemix_dedicated_notm}} 環境をセットアップします](cs_ov.html#setup_dedicated)。その後、クラスターを作成できます。クラスターとは、1 つのネットワークに編成されたワーカー・ノードの集合です。クラスターの目的は、アプリケーションの高い可用性を維持する一連のリソース、ノード、ネットワーク、およびストレージ・デバイスを定義することです。クラスターを作成したら、そのクラスターにアプリをデプロイできます。

**ヒント:** 組織にまだ {{site.data.keyword.Bluemix_dedicated_notm}} 環境がない場合は、この環境が不要な可能性があります。[まず {{site.data.keyword.Bluemix_notm}} Public 環境で専用の標準クラスターを試してください。](cs_cluster.html#cs_cluster_ui)

{{site.data.keyword.Bluemix_dedicated_notm}} でクラスターをデプロイするには、以下の手順を実行します。

1.  IBMid を使用して {{site.data.keyword.Bluemix_notm}} Public コンソール ([https://console.bluemix.net ![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/catalog/?category=containers)) にログインします。クラスターは {{site.data.keyword.Bluemix_notm}} Public から要求する必要がありますが、クラスターがデプロイされるのは {{site.data.keyword.Bluemix_dedicated_notm}} アカウントです。
2.  複数のアカウントがある場合は、アカウント・メニューで {{site.data.keyword.Bluemix_notm}} アカウントを選択します。
3.  「カタログ」から、**「コンテナー」**カテゴリーの**「Kubernetes クラスター」**をクリックします。
4.  クラスターの詳細情報を入力します。
    1.  **クラスター名**を入力します。
    2.  ワーカー・ノードで使用する **Kubernetes バージョン**を選択します。 
    3.  **マシン・タイプ**を選択します。各ワーカー・ノードにセットアップされる (ノードにデプロイされるすべてのコンテナーで使用できる) 仮想 CPU とメモリーの量は、マシン・タイプによって決まります。
    4.  必要な**ワーカー・ノードの数**を選択します。クラスターの可用性を高くするためには 3 を選択します。

    {{site.data.keyword.Bluemix_dedicated_notm}} アカウントの作成プロセス中にクラスター・タイプ、場所、パブリック VLAN、プライベート VLAN、ハードウェアのフィールドが定義されるので、これらの値を調整する必要はありません。
5.  **「クラスターの作成」**をクリックします。クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。**「ワーカー・ノード」**タブで、ワーカー・ノードの状況を確認できます。状況が `Ready` になったら、ワーカー・ノードを使用できます。

    ワーカー･ノードは、専用かつ可用性の高い {{site.data.keyword.IBM_notm}} 所有の Kubernetes マスターにより一元的にモニターされ、管理されます。Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを制御および管理します。お客様は、このマスターの管理についても気にすることなく、ワーカー・ノードとそのワーカー・ノードにデプロイしたアプリに集中できます。

おつかれさまでした。これで、1 つ目のクラスターが作成されました。


**次の作業**

クラスターが稼働状態になったら、以下の作業について検討できます。

* [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
* [クラスターにアプリをデプロイします。](cs_apps.html#cs_apps_cli)
* [クラスターに {{site.data.keyword.Bluemix_notm}} サービスを追加します。](cs_cluster.html#binding_dedicated)
* [{{site.data.keyword.Bluemix_dedicated_notm}} と Public のクラスターの相違点について理解します。](cs_ov.html#env_differences)

