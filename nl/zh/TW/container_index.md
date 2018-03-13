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


# 開始使用 {{site.data.keyword.containerlong_notm}}
{: #container_index}

使用 {{site.data.keyword.Bluemix_notm}}，藉由在 Kubernetes 叢集執行的 Docker 容器中部署高可用性應用程式，立即行動起來。容器是包裝應用程式及其所有相依關係的標準方式，而此方式可讓您在環境之間無縫移動應用程式。容器與虛擬機器不同，容器不會搭載作業系統。只有應用程式碼、運行環境、系統工具、程式庫及設定才會包裝在容器中。容器比虛擬機器更輕量、可攜性更高且更有效率。
{:shortdesc}


按一下選項以開始使用：

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="按一下圖示，以快速開始使用 {{site.data.keyword.containershort_notm}}。透過 {{site.data.keyword.Bluemix_dedicated_notm}}，按一下此圖示以查看選項。" style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="在 {{site.data.keyword.Bluemix_notm}} 中開始使用 Kubernetes 叢集" title="在 {{site.data.keyword.Bluemix_notm}} 中開始使用 Kubernetes 叢集" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="安裝 CLI。" title="安裝 CLI。" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} 雲端環境" title="{{site.data.keyword.Bluemix_notm}} 雲端環境" shape="rect" coords="326, -10, 448, 218" />
</map>


## 開始使用叢集
{: #clusters}

您要在容器中部署應用程式嗎？等一等！首先，請建立 Kubbernetes 叢集。Kubbernetes 是容器的編排工具。使用 Kubernetes，開發人員可以使用叢集的強大功能和彈性，快速開發高可用性應用程式。
{:shortdesc}

何謂叢集？叢集是一組資源、工作者節點、網路及儲存裝置，可讓應用程式保持高可用性。在您具有叢集之後，即可在容器中部署您的應用程式。

[開始之前，您必須具有隨收隨付制或訂閱制的 {{site.data.keyword.Bluemix_notm}} 帳戶，才能建立免費叢集。](https://console.bluemix.net/registration/)


若要建立免費叢集，請執行下列動作：

1.  從[**型錄** ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/catalog/?category=containers) 中，按一下**容器**種類中的 **Kubernetes 叢集**。

2.  輸入**叢集名稱**。預設叢集類型為「免費」。下次，您可以建立標準叢集，並定義其他自訂項目，例如叢集中的工作者節點數目。

3.  按一下**建立叢集**。即會開啟叢集的詳細資料，但叢集中的工作者節點需要數分鐘的時間進行佈建。您可以在**工作者節點**標籤中查看工作者節點的狀態。當狀態達到 `Ready` 時，您的工作者節點即已備妥可供使用。

做得好！您已建立自己的第一個叢集！

*   免費叢集有一個工作者節點，它有 2 個 CPU 以及 4 GB 記憶體可供應用程式使用。
*   工作者節點是由專用及高可用性 {{site.data.keyword.IBM_notm}} 擁有的 Kubernetes 主節點集中進行監視及管理，這個主節點會控制及監視叢集中的所有 Kubernetes 資源。您可以著重在工作者節點以及工作者節點中所部署的應用程式，而不需要擔心這個主節點的管理。
*   執行叢集所需的資源（例如 VLAN 及 IP 位址）是使用 {{site.data.keyword.IBM_notm}} 擁有的 IBM Cloud 基礎架構 (SoftLayer) 帳戶進行管理。當您建立標準叢集時，會使用您自己的 IBM Cloud 基礎架構 (SoftLayer) 帳戶來管理這些資源。當您建立標準叢集時，可以進一步瞭解這些資源。


**下一步為何？**

叢集開始進行時，請處理您的叢集。

* [安裝 CLI 以開始使用您的叢集。](cs_cli_install.html#cs_cli_install)
* [在叢集中部署應用程式。](cs_app.html#app_cli)
* [建立含有多個節點的標準叢集，以提高可用性。](cs_clusters.html#clusters_ui)
* [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)
