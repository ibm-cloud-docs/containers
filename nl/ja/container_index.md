---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-13"

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

Kubernetes クラスターで稼動する Docker コンテナーに可用性の高いアプリをデプロイすることによって、{{site.data.keyword.Bluemix_notm}} ですぐに作業を始めることができます。 コンテナーは、環境間でアプリをシームレスに移動できるようにアプリとそのすべての従属物をパッケージ化するための標準的な手段です。 仮想マシンとは異なり、コンテナーはオペレーティング・システムをバンドルしません。 アプリのコード、ランタイム、システム・ツール、ライブラリー、設定値のみがコンテナー内にパッケージされます。 コンテナーは、仮想マシンより軽量で移植しやすく、効率的です。
{:shortdesc}


開始するための以下のオプションをクリックしてください。

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="アイコンをクリックすると、すぐに {{site.data.keyword.containershort_notm}} を開始できます。{{site.data.keyword.Bluemix_dedicated_notm}} では、このアイコンをクリックするとオプションが表示されます。" style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="{{site.data.keyword.Bluemix_notm}} の Kubernetes クラスターの概説" title="{{site.data.keyword.Bluemix_notm}} の Kubernetes クラスターの概説" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="CLI をインストールします。" title="CLI をインストールします。" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} クラウド環境" title="{{site.data.keyword.Bluemix_notm}} クラウド環境" shape="rect" coords="326, -10, 448, 218" />
</map>


## クラスターの概説
{: #clusters}

コンテナーにアプリをデプロイするときには、 その前に、 まず Kubernetes クラスターを作成してください。 Kubernetes はコンテナー用のオーケストレーション・ツールです。 Kubernetes を使用すると、開発者はクラスターの高度な機能や柔軟性を活用して、可用性の高いアプリをすぐにデプロイできます。
{:shortdesc}

ところで、クラスターとは一体何でしょうか。 クラスターとは、アプリの高可用性を維持する一連のリソース、ワーカー・ノード、ネットワーク、ストレージ・デバイスのことです。 クラスターを作成したら、アプリをコンテナーにデプロイできます。

[開始する前に、ライト・クラスターを作成するための従量課金 (PAYG) またはサブスクリプション {{site.data.keyword.Bluemix_notm}} アカウントが必要です。](https://console.bluemix.net/registration/)


ライト・クラスターを作成するには、以下のようにします。

1.  [**「カタログ」**![外部リンク・アイコン](../icons/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/catalog/?category=containers) から、**「コンテナー」**カテゴリーの**「Kubernetes クラスター」**をクリックします。

2.  **クラスター名**を入力します。 デフォルトのクラスター・タイプはライトです。 次は、標準クラスターを作成し、クラスター内のワーカー・ノード数などの追加のカスタマイズを定義できます。

3.  **「クラスターの作成」**をクリックします。 クラスターの詳細情報が表示されますが、クラスター内のワーカー・ノードのプロビジョンには数分の時間がかかります。 **「ワーカー・ノード」**タブでワーカー・ノードの状況を確認できます。 状況が `Ready` になったら、ワーカー・ノードを使用できます。

おつかれさまでした。 これで、1 つ目のクラスターが作成されました。

*   ライト・クラスターでは、CPU 2 つとメモリー 4 GB を備えたワーカー・ノード 1 つを、アプリで使用できます。
*   ワーカー･ノードは、専用かつ可用性の高い {{site.data.keyword.IBM_notm}} 所有の Kubernetes マスターにより一元的にモニターされ、管理されます。Kubernetes マスターは、クラスター内のすべての Kubernetes リソースを制御および管理します。 作業担当者はこのマスターの管理のことは気にせずに、ワーカー・ノードとそのワーカー・ノードにデプロイされるアプリに集中できます。
*   VLANS や IP アドレスなどの、クラスターの実行に必要なリソースは、{{site.data.keyword.IBM_notm}} 所有の IBM Cloud インフラストラクチャー (SoftLayer) アカウントで管理されます。 標準クラスターの作成時は、独自の IBM Cloud インフラストラクチャー (SoftLayer) アカウントでこれらのリソースを管理します。 標準クラスターの作成時に、これらのリソースの詳細を確認できます。


**次の作業**

クラスターが稼働状態になったら、クラスターを使用した作業を開始してください。

* [CLI をインストールして、クラスターでの作業を開始します。](cs_cli_install.html#cs_cli_install)
* [クラスターにアプリをデプロイします。](cs_app.html#app_cli)
* [可用性を高めるために、複数のノードを使用する標準クラスターを作成します。](cs_clusters.html#clusters_ui)
* [独自のプライベート・レジストリーを {{site.data.keyword.Bluemix_notm}} でセットアップし、Docker イメージを保管して他のユーザーと共有します。](/docs/services/Registry/index.html)
