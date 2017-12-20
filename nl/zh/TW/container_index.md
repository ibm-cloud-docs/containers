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


# 開始使用 {{site.data.keyword.containerlong_notm}}
{: #container_index}

使用 {{site.data.keyword.Bluemix_notm}}，藉由在 Kubernetes 叢集執行的 Docker 容器中部署高度可用的應用程式，立即行動起來。容器是包裝應用程式及其所有相依關係的標準方式，而此方式可讓您在環境之間無縫移動應用程式。容器與虛擬機器不同，容器不會搭載作業系統。只有應用程式碼、運行環境、系統工具、程式庫及設定才會包裝在容器中。容器比虛擬機器更輕量、可攜性更高且更有效率。
{:shortdesc}


按一下選項以開始使用：

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="使用「{{site.data.keyword.Bluemix_notm}} 公用」，您可以建立 Kubernetes 叢集，或將單一且可擴充容器群組移轉至叢集。使用「{{site.data.keyword.Bluemix_dedicated_notm}}」時，按一下此圖示，即可看到您的選項。" style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="在 {{site.data.keyword.Bluemix_notm}} 中開始使用 Kubernetes 叢集" title="在 {{site.data.keyword.Bluemix_notm}} 中開始使用 Kubernetes 叢集" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_classic.html#cs_classic" alt="在 {{site.data.keyword.containershort_notm}} 中執行單一及可擴充容器" title="在 {{site.data.keyword.containershort_notm}} 中執行單一及可擴充容器" shape="rect" coords="155, -1, 289, 210" />
<area href="cs_ov.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}}雲端環境" title="{{site.data.keyword.Bluemix_notm}}雲端環境" shape="rect" coords="326, -10, 448, 218" />
</map>


## 開始使用叢集
{: #clusters}

您要在容器中部署應用程式嗎？等一等！首先，請建立 Kubbernetes 叢集。Kubbernetes 是容器的編排工具。使用 Kubernetes，開發人員可以使用叢集的強大功能和彈性，快速開發高可用性應用程式。
{:shortdesc}

何謂叢集？叢集是一組資源、工作者節點、網路及儲存裝置，可讓應用程式保持高度可用。在您具有叢集之後，即可在容器中部署您的應用程式。


若要建立精簡叢集，請執行下列動作：

1.  從[**型錄** ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/catalog/?category=containers) 中，按一下**容器**種類中的 **Kubernetes 叢集**。

2.  輸入**叢集名稱**。預設叢集類型為「精簡」。下次，您可以建立標準叢集，並定義其他自訂項目，例如叢集中的工作者節點數目。

3.  按一下**建立叢集**。即會開啟叢集的詳細資料，但叢集中的工作者節點需要數分鐘的時間進行佈建。您可以在**工作者節點**標籤中查看工作者節點的狀態。當狀態達到 `Ready` 時，您的工作者節點即已備妥可供使用。

做得好！您已建立自己的第一個叢集！

*   精簡叢集有一個工作者節點，它有 2 個 CPU 以及 4 GB 記憶體可供應用程式使用。
*   工作者節點是由專用及高可用性 {{site.data.keyword.IBM_notm}} 擁有的 Kubernetes 主節點集中進行監視及管理，這個主節點會控制及監視叢集中的所有 Kubernetes 資源。您可以著重在工作者節點以及工作者節點中所部署的應用程式，而不需要擔心這個主節點的管理。
*   執行叢集所需的資源（例如 VLAN 及 IP 位址）是使用 {{site.data.keyword.IBM_notm}} 擁有的 IBM Cloud 基礎架構 (SoftLayer) 帳戶進行管理。當您建立標準叢集時，會使用您自己的 IBM Cloud 基礎架構 (SoftLayer) 帳戶來管理這些資源。當您建立標準叢集時，可以進一步瞭解這些資源。
*   **提示：**使用 {{site.data.keyword.Bluemix_notm}} 精簡帳戶，您可以建立 1 個精簡叢集（其中具有 2 個 CPU 及 4 GB RAM），並將其與精簡服務進行整合。若要建立其他叢集，請具有不同的機型，並使用完整服務（[升級至 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶](/docs/pricing/billable.html#upgradetopayg)）。


**下一步為何？**

叢集開始進行時，請處理您的叢集。

* [安裝 CLI 以開始使用您的叢集。](cs_cli_install.html#cs_cli_install)
* [在叢集中部署應用程式。](cs_apps.html#cs_apps_cli)
* [建立含有多個節點的標準叢集，以提高可用性。](cs_cluster.html#cs_cluster_ui)
* [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)


## 在 {{site.data.keyword.Bluemix_dedicated_notm}}中開始使用叢集（封閉測試版）
{: #dedicated}

Kubernetes 是一種編排工具，可將應用程式容器排定到運算機器叢集上。使用 Kubernetes，開發人員可以使用「{{site.data.keyword.Bluemix_dedicated_notm}}」實例中容器的強大功能和彈性，快速開發高可用性應用程式。
{:shortdesc}

開始之前，請[設定您的「{{site.data.keyword.Bluemix_dedicated_notm}}」環境以使用叢集](cs_ov.html#setup_dedicated)。然後，您可以建立叢集。叢集是一組組織成網路的工作者節點。叢集的用途是要定義一組資源、節點、網路及儲存裝置，以讓應用程式保持高度可用。在您具有叢集之後，則可以將應用程式部署至叢集。

**提示：**如果您的組織還沒有「{{site.data.keyword.Bluemix_dedicated_notm}}」環境，則可能不需要。[請先在「{{site.data.keyword.Bluemix_notm}} 公用」環境中嘗試專用的標準叢集。](cs_cluster.html#cs_cluster_ui)

若要在「{{site.data.keyword.Bluemix_dedicated_notm}}」中部署叢集，請執行下列動作：

1.  使用 IBM ID，登入「{{site.data.keyword.Bluemix_notm}} 公用」主控台 ([https://console.bluemix.net ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/catalog/?category=containers))。雖然您必須從「{{site.data.keyword.Bluemix_notm}} 公用」要求叢集，但是您會將它部署至「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶。
2.  如果您有多個帳戶，請從帳戶功能表中選取 {{site.data.keyword.Bluemix_notm}} 帳戶。
3.  從型錄中，按一下**容器**種類中的 **Kubernetes 叢集**。
4.  輸入叢集的詳細資料。
    1.  輸入**叢集名稱**。
    2.  選取要在工作者節點中使用的 **Kubernetes 版本**。 
    3.  選取**機型**。機型會定義設定於每一個工作者節點中，且可供節點中部署之所有容器使用的虛擬 CPU 及記憶體數量。
    4.  選擇您需要的**工作者節點數目**。選取 3，以獲得叢集的較高可用性。

    叢集類型、位置、公用 VLAN、專用 VLAN 及硬體欄位是在「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶的建立程序期間所定義，因此您無法調整這些值。
5.  按一下**建立叢集**。即會開啟叢集的詳細資料，但叢集中的工作者節點需要數分鐘的時間進行佈建。您可以在**工作者節點**標籤中查看工作者節點的狀態。當狀態達到 `Ready` 時，您的工作者節點即已備妥可供使用。

    工作者節點是由專用及高可用性 {{site.data.keyword.IBM_notm}} 擁有的 Kubernetes 主節點集中進行監視及管理，這個主節點會控制及監視叢集中的所有 Kubernetes 資源。您可以著重在工作者節點以及工作者節點中所部署的應用程式，而不需要擔心這個主節點的管理。

做得好！您已建立自己的第一個叢集！


**下一步為何？**

叢集開始進行時，您可以查看下列作業。

* [安裝 CLI 以開始使用您的叢集。](cs_cli_install.html#cs_cli_install)
* [將應用程式部署至叢集。](cs_apps.html#cs_apps_cli)
* [將 {{site.data.keyword.Bluemix_notm}} 服務新增至叢集。](cs_cluster.html#binding_dedicated)
* [瞭解 {{site.data.keyword.Bluemix_dedicated_notm}}及公用中叢集之間的差異。](cs_ov.html#env_differences)

