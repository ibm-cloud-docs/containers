---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:gif: data-image-type='gif'}


# 設定叢集及工作者節點
{: #clusters}
建立叢集並新增工作者節點，以增加 {{site.data.keyword.containerlong}} 中的叢集容量。仍要開始使用嗎？請試用[建立 Kubernetes 叢集指導教學](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial)。
{: shortdesc}

## 準備建立叢集
{: #cluster_prepare}

使用 {{site.data.keyword.containerlong_notm}}，您可以為應用程式建立高度可用及安全的環境，並提供許多內建或可配置的其他功能。您具有多個搭配叢集的可能性，也表示您有多個要在建立叢集時做出的決策。下列步驟概述設定您的帳戶、許可權、資源群組、VLAN Spanning、針對區域及硬體的叢集設定，以及計費資訊時必須考量的事項。
{: shortdesc}

此清單分成兩個部分：
*  **帳戶層次**：這些是帳戶管理者所做的準備工作，您不需要在每次建立叢集時變更它們。不過，每次您建立叢集時，仍然想要驗證現行帳戶層次狀態為您需要其處於的狀態。
*  **叢集層次**：這些是您每次建立叢集時會影響叢集的準備工作。

### 帳戶層次
{: #prepare_account_level}

請遵循步驟，為 {{site.data.keyword.containerlong_notm}} 準備好您的 {{site.data.keyword.Bluemix_notm}} 帳戶。
{: shortdesc}

1.  [建立或將您的帳戶升級至計費帳戶（{{site.data.keyword.Bluemix_notm}}隨收隨付制或訂閱](https://cloud.ibm.com/registration/)）。
2.  [在您要建立叢集的地區中設定 {{site.data.keyword.containerlong_notm}}API 金鑰](/docs/containers?topic=containers-users#api_key)。指派具有適當許可權的 API 金鑰來建立叢集：
    *  IBM Cloud 基礎架構 (SoftLayer) 的**超級使用者**角色。
    *  帳戶層次中 {{site.data.keyword.containerlong_notm}} 的**管理者**平台管理角色。
    *  帳戶層次中 {{site.data.keyword.registrylong_notm}} 的**管理者**平台管理角色。如果您帳戶的日期是在 2018 年 10 月 4 日之前，您需要[啟用 {{site.data.keyword.registryshort_notm}} 的 {{site.data.keyword.Bluemix_notm}} IAM 原則](/docs/services/Registry?topic=registry-user#existing_users)。有了 IAM 原則，您就可以控制對資源（例如登錄名稱空間）的存取。

    您是帳戶擁有者嗎？您已具有必要的許可權！建立叢集時，會使用您的認證設定該地區及資源群組的 API 金鑰。
    {: tip}

3.  如果您的帳戶使用多個資源群組，請瞭解您帳戶的[管理資源群組](/docs/containers?topic=containers-users#resource_groups)策略。 
    *  在您登入 {{site.data.keyword.Bluemix_notm}} 時，會在您設為目標的資源群組中建立叢集。如果您未將目標設為資源群組，則會自動將目標設為 default 資源群組。
    *  如果您要在非 default 資源群組中建立叢集，則至少需要是資源群組的**檢視者**角色。如果您沒有任何資源群組角色，但仍是資源群組內服務的**管理者**，則會在 default 資源群組中建立您的叢集。
    *  您無法變更叢集的資源群組。此外，如果您需要使用 `ibmcloud ks cluster-service-bind` [指令](/docs/containers-cli-plugin?topic=containers-cli-plugin-cs_cli_reference#cs_cluster_service_bind)來進行[與 {{site.data.keyword.Bluemix_notm}} 服務的整合](/docs/containers?topic=containers-service-binding#bind-services)，則該服務必須與叢集位於相同的資源群組中。未使用 {{site.data.keyword.registrylong_notm}} 這類資源群組或不需要 {{site.data.keyword.la_full_notm}} 這類服務連結的服務都會運作，即使叢集位於不同的資源群組中。
    *  如果您計劃使用 [{{site.data.keyword.monitoringlong_notm}} 進行度量](/docs/containers?topic=containers-health#view_metrics)，請計劃提供一個叢集名稱，該名稱在帳戶的所有資源群組和地區中必須是唯一的，以避免發生度量命名衝突。

4.  設定 IBM Cloud 基礎架構 (SoftLayer) 網路。有下列選項可選擇：
    *  **已啟用 VRF**：透過虛擬遞送和轉遞 (VRF) 及其多重隔離分隔技術，您可以使用公用和專用服務端點，與執行 Kubernetes 1.11 或更新版本的叢集中的 Kubernetes 主節點進行通訊。利用[專用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)，Kubernetes 主節點與工作者節點之間的通訊可維持在專用 VLAN 上進行。如果您要從本端機器上對叢集執行 `kubectl` 指令，則必須連接至 Kubernetes 主節點所在的相同專用 VLAN。若要在網際網路上公開您的應用程式，您的工作者節點必須連接至公用 VLAN，這樣送入的網路資料流量才能轉遞至您的應用程式。如果要透過網際網路對叢集執行 `kubectl` 指令，您可以使用公用服務端點。透過公用服務端點，網路資料流量會透過公用 VLAN 遞送，並使用 OpenVPN 通道保護其安全。若要使用專用服務端點，您必須針對 VRF 及服務端點啟用您的帳戶，它需要開立 IBM Cloud 基礎架構 (SoftLayer) 支援案例。如需相關資訊，請參閱 [{{site.data.keyword.Bluemix_notm}} 上的 VRF 概觀](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)及[針對服務端點啟用帳戶](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)。
    *  **非 VRF**：如果您不要或無法啟用帳戶的 VRF，則工作者節點可以透過[公用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)，自動透過公用網路連接至 Kubernetes 主節點。為了保護此通訊，{{site.data.keyword.containerlong_notm}} 會在建立叢集時自動設定 Kubernetes 主節點與工作者節點之間的 OpenVPN 連線。如果您的叢集具有多個 VLAN，同一個 VLAN 上有多個子網路，或者有多個區域叢集，則必須為您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)，讓工作者節點可以在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](/docs/containers?topic=containers-users#infra_access)，或者您可以要求帳戶擁有者啟用它。若要確認是否已啟用 VLAN Spanning，請使用 `ibmcloud ks vlan-spanning-get` [指令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。


### 叢集層次
{: #prepare_cluster_level}

請遵循步驟來準備叢集的設定。
{: shortdesc}

1.  驗證您具有 {{site.data.keyword.containerlong_notm}} 的**管理者**平台角色。若要容許叢集從專用登錄取回映像檔，您還需要 {{site.data.keyword.registrylong_notm}} 的**管理者**平台角色。
    1.  從 [{{site.data.keyword.Bluemix_notm}} 主控台 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/) 功能表列中，按一下**管理 > 存取權 (IAM)**。
    2.  按一下**使用者**頁面，然後從表格中選取您自己。
    3.  從**存取原則**標籤中，確認您的**角色**為**管理者**。您可以是帳戶中所有資源的**管理者**，或至少是 {{site.data.keyword.containershort_notm}} 的管理者。**附註**：如果您只在一個資源群組或地區（而非整個帳戶）中，具有 {{site.data.keyword.containershort_notm}} 的**管理者**角色，則必須在帳戶層次至少具有**檢視者**角色，才能看到帳戶的 VLAN。<p class="tip">請確定您的帳戶管理者未同時將**管理者**平台角色與服務角色指派給您。您必須個別指派平台角色及服務角色。</p>
2.  決定[免費或標準叢集](/docs/containers?topic=containers-cs_ov#cluster_types)。您可以建立 1 個免費叢集來試用部分功能 30 天，或建立完全可自訂的標準叢集，並選擇硬體隔離。請建立標準叢集，以獲得更多好處及對您叢集效能的控制。
3.  [計劃您的叢集設定](/docs/containers?topic=containers-plan_clusters#plan_clusters)。
    *  判定是要建立[單一區域](/docs/containers?topic=containers-plan_clusters#single_zone)還是[多區域](/docs/containers?topic=containers-plan_clusters#multizone)叢集。請注意，多區域叢集僅適用於選取位置。
    *  如果您要建立無法公開存取的叢集，請檢閱其他[專用叢集步驟](/docs/containers?topic=containers-plan_clusters#private_clusters)。
    *  為叢集的工作者節點選擇您想要哪種類型的[硬體及隔離](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)，包括虛擬機器與祼機機器之間的決策。
4.  如果是標準叢集，您可以在 {{site.data.keyword.Bluemix_notm}} 主控台中[預估成本](/docs/billing-usage?topic=billing-usage-cost#cost)。如需可能未內含在預估器中的費用相關資訊，請參閱[定價及計費](/docs/containers?topic=containers-faqs#charges)。
5.  如果您在防火牆後面的環境中建立叢集，則針對您計劃使用的 {{site.data.keyword.Bluemix_notm}} 服務，[容許公用和專用 IP 的出埠網路資料流量](/docs/containers?topic=containers-firewall#firewall_outbound)。
<br>
<br>

**下一步為何？**
* [使用 {{site.data.keyword.Bluemix_notm}} 主控台建立叢集](#clusters_ui)
* [使用 {{site.data.keyword.Bluemix_notm}} CLI 建立叢集](#clusters_cli)

## 使用 {{site.data.keyword.Bluemix_notm}} 主控台建立叢集
{: #clusters_ui}

Kubernetes 叢集的用途是要定義一組資源、節點、網路及儲存裝置，讓應用程式保持高可用性。您必須先建立叢集並設定該叢集裡工作者節點的定義，才能部署應用程式。
{:shortdesc}

想要建立使用[服務端點](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)的叢集來進行[主節點到工作者節點的通訊](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)？您必須[使用 CLI](#clusters_cli) 來建立該叢集。
{: note}

### 建立免費叢集
{: #clusters_ui_free}

您可以使用 1 個免費叢集來熟悉 {{site.data.keyword.containerlong_notm}} 的運作方式。使用免費叢集，您可以先學習術語、完成指導教學以及瞭解您的方向，再跳至正式作業層級標準叢集。不要擔心，即使您有計費帳戶，還是可以取得免費叢集。
{: shortdesc}

免費叢集的有效期限是 30 天。在該時間之後，叢集會到期，並刪除叢集和其資料。{{site.data.keyword.Bluemix_notm}} 不會備份刪除的資料，因此無法予以還原。請務必備份所有重要資料。
{: note}

1. [準備建立叢集](#cluster_prepare)，以確保您具有正確的 {{site.data.keyword.Bluemix_notm}} 帳戶設定及使用者許可權，並決定要使用的叢集設定及資源群組。
2. 在[型錄 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/catalog?category=containers) 中，選取 **{{site.data.keyword.containershort_notm}}** 來建立叢集。
3. 選取要部署叢集的地理位置。您的叢集建立在這個地理位置的某個區域中。
4. 選取**免費**叢集方案。
5. 提供叢集名稱。此名稱必須以字母開頭，可以包含字母、數字及連字號 (-)，且長度不得超過 35 個字元。叢集名稱和叢集部署所在的地區會形成 Ingress 子網域的完整網域名稱。為了確保 Ingress 子網域在地區內是唯一的，叢集名稱可能會被截斷，並在 Ingress 網域名稱內附加一個隨機值。

6. 按一下**建立叢集**。依預設，會建立具有一個工作者節點的工作者節點儲存區。您可以在**工作者節點**標籤中查看工作者節點部署的進度。部署完成時，您可以在**概觀**標籤中看到叢集已備妥。請注意，即使叢集已備妥，其他服務所使用的一些叢集部分（例如 Ingress 密碼或登錄映像檔取回密碼）可能還是在處理中。

    變更在建立期間指派的唯一 ID 或網域名稱會封鎖 Kubernetes 主節點，使其無法管理叢集。
    {: note}

</br>

### 建立標準叢集
{: #clusters_ui_standard}

1. [準備建立叢集](#cluster_prepare)，以確保您具有正確的 {{site.data.keyword.Bluemix_notm}} 帳戶設定及使用者許可權，並決定要使用的叢集設定及資源群組。
2. 在[型錄 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/catalog?category=containers) 中，選取 **{{site.data.keyword.containershort_notm}}** 來建立叢集。
3. 選取要在其中建立叢集的資源群組。
  **附註**：
    * 一個叢集只能在一個資源群組中建立，而且在建立叢集之後，您無法變更其資源群組。
    * 在 default 資源群組中會自動建立免費叢集。
    * 若要在非 default 資源群組中建立叢集，您必須至少具有該資源群組的[**檢視者**角色](/docs/containers?topic=containers-users#platform)。
4. 選取要在其中部署叢集的 [{{site.data.keyword.Bluemix_notm}} 位置](/docs/containers?topic=containers-regions-and-zones#regions-and-zones)。如需最佳效能，請選取實際上與您最接近的位置。請謹記，如果您選取的區域不在您的國家/地區境內，您可能需要合法授權，才能儲存資料。
5. 選取**標準**叢集方案。使用標準叢集，您可以存取諸如多個工作者節點的特性，以達到高可用性環境。
6. 輸入區域詳細資料。
    1. 選取**單一區域**或**多區域**可用性。在多區域叢集裡，主節點部署在具有多區域功能的區域中，而且您的叢集資源會分散到多個區域。您的選擇可能會受到地區的限制。
    2. 選取您要在其中管理叢集的特定區域。您必須至少選取 1 個區域，但可以選取所需數目的區域。如果您選取超過 1 個區域，則工作者節點會分散到您選擇的各區域，讓您具有更高的可用性。如果您只選取 1 個區域，則可以在建立叢集之後[將區域新增至叢集](#add_zone)。
    3. 從 IBM Cloud 基礎架構 (SoftLayer) 帳戶中，選取一個公用 VLAN（選用）及一個專用 VLAN（必要）。工作者節點使用專用 VLAN 來彼此通訊。若要與 Kubernetes 主節點通訊，您必須配置工作者節點的公用連線功能。如果您在此區域中沒有公用或專用 VLAN，則請將它保留為空白。會自動為您建立公用及專用 VLAN。如果您具有現有 VLAN，並且未指定公用 VLAN，則請考慮配置防火牆（例如 [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra)）。您可以將相同的 VLAN 用於多個叢集。如果工作者節點是設定為僅限專用 VLAN，則您必須容許工作者節點及主要叢集透過[啟用專用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置閘道裝置](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)來進行通訊。
        {: note}

7. 配置預設工作者節點儲存區。工作者節點儲存區是共用相同配置的工作者節點群組。您一律可以稍後再將更多工作者節點儲存區新增至叢集。

    1. 選取硬體隔離的類型。虛擬伺服器是按小時計費，裸機伺服器是按月計費。

        - **虛擬 - 專用**：工作者節點是在您帳戶專用的基礎架構上進行管理。實體資源完全被隔離。

        - **虛擬 - 共用**：您與其他 IBM 客戶之間可以共用基礎架構資源（例如 Hypervisor 和實體硬體），但每一個工作者節點僅供您存取。雖然此選項的成本比較低，而且在大部分情況下已夠用，您可能要根據公司原則來驗證效能及基礎架構需求。

        - **裸機**：當您訂購之後，按月計費的裸機伺服器將由 IBM Cloud 基礎架構 (SoftLayer) 進行手動佈建，這可能需要多個營業日才能完成。裸機伺服器最適合需要更多資源和主機控制的高效能應用程式。您也可以選擇啟用[授信運算](/docs/containers?topic=containers-security#trusted_compute)，來驗證工作者節點是否遭到竄改。「授信運算」可用於選取裸機的機型。例如，`mgXc` GPU 特性不支援「授信運算」。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。

        請確定您要佈建裸機機器。因為它是按月計費，如果您不慎下訂之後立即取消，仍會向您收取整個月的費用。
        {:tip}

    2. 選取機型。機型會定義設定於每一個工作者節點中，且可供容器使用的虛擬 CPU、記憶體及磁碟空間量。可用的裸機及虛擬機器類型會因您部署叢集所在的區域而不同。建立叢集之後，您可以藉由將工作者節點或儲存區新增至叢集來新增不同的機型。

    3. 指定您在叢集裡需要的工作者節點數目。您輸入的工作者節點數目會抄寫到您所選取數目的區域。這表示，如果您有 2 個區域並選取 3 個工作者節點，則會佈建 6 個節點，而且每一個區域中都有 3 個節點。

8. 為叢集提供唯一名稱。**附註**：變更在建立期間指派的唯一 ID 或網域名稱會封鎖 Kubernetes 主節點，使其無法管理叢集。
9. 選擇叢集主節點的 Kubernetes API 伺服器版本。
10. 按一下**建立叢集**。即會建立具有所指定工作者數目的工作者節點儲存區。您可以在**工作者節點**標籤中查看工作者節點部署的進度。部署完成時，您可以在**概觀**標籤中看到叢集已備妥。請注意，即使叢集已備妥，其他服務所使用的一些叢集部分（例如 Ingress 密碼或登錄映像檔取回密碼）可能還是在處理中。

**下一步為何？**

當叢集開始執行時，您可以查看下列作業：

-   如果您已在具有多區域功能的區域中建立叢集，請藉由[將區域新增至叢集](#add_zone)來展開工作者節點。
-   [安裝 CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_install) 或[啟動 Kubernetes Terminal 以在 Web 瀏覽器中直接使用 CLI](/docs/containers?topic=containers-cs_cli_install#cli_web)，以開始使用叢集。
-   [在叢集裡部署應用程式。](/docs/containers?topic=containers-app#app_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry?topic=registry-getting-started)
-   如果您有防火牆，則可能需要[開啟必要埠](/docs/containers?topic=containers-firewall#firewall)，才能使用 `ibmcloud`、`kubectl` 或 `calicotl` 指令，以容許來自叢集的出埠資料流量，或容許網路服務的入埠資料流量。
-   [設定叢集 autoscaler](/docs/containers?topic=containers-ca#ca)，以根據工作負載資源要求來自動新增或移除工作者節點儲存區中的工作者節點。
-   控制誰可以使用 [Pod 安全原則](/docs/containers?topic=containers-psp)在您的叢集中建立 Pod。

<br />


## 使用 {{site.data.keyword.Bluemix_notm}} CLI 建立叢集
{: #clusters_cli}

Kubernetes 叢集的用途是要定義一組資源、節點、網路及儲存裝置，讓應用程式保持高可用性。您必須先建立叢集並設定該叢集裡工作者節點的定義，才能部署應用程式。
{:shortdesc}

### 範例 CLI `ibmcloud ks cluster-create` 指令
{: #clusters_cli_samples}

您之前是否已建立叢集，只是想要尋找快速範例指令？可試試這些範例。
*  **免費叢集**：
   ```
   ibmcloud ks cluster-create --name my_cluster
   ```
   {: pre}
*  **標準叢集、共用虛擬機器**：
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **標準叢集、裸機伺服器**：
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **標準叢集、具有[公用及專用服務端點](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)的虛擬機器，使用已啟用 VRF 的帳戶**：
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-service-endpoint --private-service-endpoint --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*   **標準叢集、僅限專用 VLAN 及僅限專用服務端點**。如需配置專用叢集網路的相關資訊，請參閱[設定具有僅限專用 VLAN 的叢集網路](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan)。
    ```
    ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --private-service-endpoint --private-vlan <private_VLAN_ID> --private-only
    ```
    {: pre}

### 在 CLI 中建立叢集的步驟
{: #clusters_cli_steps}

開始之前，請安裝 {{site.data.keyword.Bluemix_notm}} CLI 及 [{{site.data.keyword.containerlong_notm}} 外掛程式](/docs/containers?topic=containers-cs_cli_install#cs_cli_install)。

若要建立叢集，請執行下列動作：

1. [準備建立叢集](#cluster_prepare)，以確保您具有正確的 {{site.data.keyword.Bluemix_notm}} 帳戶設定及使用者許可權，並決定要使用的叢集設定及資源群組。

2.  登入 {{site.data.keyword.Bluemix_notm}} CLI。

    1.  系統提示時，請登入並輸入 {{site.data.keyword.Bluemix_notm}} 認證。

        ```
        ibmcloud login
        ```
        {: pre}

        如果您具有聯合 ID，請使用 `ibmcloud login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。
    {: tip}

    2. 如果您有多個 {{site.data.keyword.Bluemix_notm}} 帳戶，請選取您要在其中建立 Kubernetes 叢集的帳戶。

    3.  若要在非 default 資源群組中建立叢集，請將目標設為該資源群組。
      **附註**：
        * 一個叢集只能在一個資源群組中建立，而且在建立叢集之後，您無法變更其資源群組。
        * 您必須至少具有資源群組的[**檢視者**角色](/docs/containers?topic=containers-users#platform)。
        * 在 default 資源群組中會自動建立免費叢集。
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4. **免費叢集**：如果您要在特定地區中建立免費叢集，則必須執行 `ibmcloud ks region-set` 以將該地區設為目標。

4.  建立叢集。可以在任何地區及可用區域中建立標準叢集。可以在您使用 `ibmcloud ks region-set` 指令設為目標的地區中建立免費叢集，但無法選取區域。

    1.  **標準叢集**：檢閱可用的區域。顯示的區域取決於您所登入的 {{site.data.keyword.containerlong_notm}} 地區。若要跨越區域間的叢集，您必須在[具有多區域功能的區域](/docs/containers?topic=containers-regions-and-zones#zones)中建立叢集。
        ```
        ibmcloud ks zones
        ```
        {: pre}
        若您選取的區域不在您的國家/地區境內，請謹記，您可能需要合法授權，才能實際將資料儲存在其他國家/地區。
        {: note}

    2.  **標準叢集**：選擇區域，並檢閱該區域中可用的機型。機型指定每一個工作者節點可用的虛擬或實體運算主機。

        -  檢視**伺服器類型**欄位，以選擇虛擬或實體（裸機）機器。
        -  **虛擬**：按小時計費的虛擬機器是佈建在共用或專用硬體上。
        -  **實體**：當您訂購之後，按月計費的裸機伺服器將由 IBM Cloud 基礎架構 (SoftLayer) 進行手動佈建，這可能需要多個營業日才能完成。裸機伺服器最適合需要更多資源和主機控制的高效能應用程式。
        - **使用授信運算的實體機器**：您也可以選擇啟用[授信運算](/docs/containers?topic=containers-security#trusted_compute)，來驗證裸機工作者節點是否遭到竄改。「授信運算」可用於選取裸機的機型。例如，`mgXc` GPU 特性不支援「授信運算」。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。
        -  **機型**：若要決定要部署的機型，請檢閱[可用工作者節點硬體](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)的核心、記憶體及儲存空間組合。建立叢集之後，您可以藉由[新增工作者節點儲存區](#add_pool)來新增不同的實體或虛擬機器類型。

           請確定您要佈建裸機機器。因為它是按月計費，如果您不慎下訂之後立即取消，仍會向您收取整個月的費用。
        {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **標準叢集**：查看 IBM Cloud 基礎架構 (SoftLayer) 中是否已存在此帳戶的公用及專用 VLAN。

        ```
        ibmcloud ks vlans --zone <zone>
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

        如果公用及專用 VLAN 已存在，請記下相符的路由器。專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。在範例輸出中，任何專用 VLAN 都可以與任何公用 VLAN 搭配使用，因為路由器都會包括 `02a.dal10`。

        您必須將工作者節點連接至專用 VLAN，也可以選擇性地將工作者節點連接至公用 VLAN。**附註**：如果工作者節點是設定為僅限專用 VLAN，則您必須容許工作者節點及主要叢集透過[啟用專用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置閘道裝置](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)來進行通訊。

    4.  **免費及標準叢集**：執行 `cluster-create` 指令。您可以選擇免費叢集（包括一個已設定 2vCPU 及 4GB 記憶體的工作者節點），且會在 30 天後自動刪除。當您建立標準叢集時，依預設，工作者節點磁碟為 AES 256 位元加密，其硬體由多個 IBM 客戶共用，並依使用時數計費。</br>標準叢集的範例。指定叢集的選項：

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b3c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--private-service-endpoint][--public-service-endpoint] [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        免費叢集的範例。指定叢集名稱：

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>cluster-create 元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解這個指令的元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>在 {{site.data.keyword.Bluemix_notm}} 組織中建立叢集的指令。</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**標準叢集**：將 <em>&lt;zone&gt;</em> 取代為您要建立叢集的 {{site.data.keyword.Bluemix_notm}} 區域 ID。可用的區域取決於您所登入的 {{site.data.keyword.containerlong_notm}} 地區。<p class="note">將叢集工作者節點部署至此區域。若要跨越區域間的叢集，您必須在[具有多區域功能的區域](/docs/containers?topic=containers-regions-and-zones#zones)中建立叢集。建立叢集之後，您可以[將區域新增至叢集](#add_zone)。</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**標準叢集**：選擇機型。您可以將工作者節點部署為共用或專用硬體上的虛擬機器，或部署為裸機上的實體機器。可用的實體及虛擬機器類型會因您部署叢集所在的區域而不同。如需相關資訊，請參閱 `ibmcloud ks machine-type` [指令](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)的文件。若為免費叢集，您不需要定義機型。</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**標準叢集**：工作者節點的硬體隔離層次。若要讓可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。對於 VM 標準叢集而言，此值是選用的，不適用於免費叢集。若為裸機機型，請指定 `dedicated`。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**免費叢集**：您不需要定義公用 VLAN。免費叢集會自動連接至 IBM 所擁有的公用 VLAN。</li>
          <li>**標準叢集**：如果您在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中已設定用於該區域的公用 VLAN，請輸入公用 VLAN 的 ID。如果您只要將工作者節點連接至專用 VLAN，請不要指定此選項。<p>專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</p>
          <p class="note">如果工作者節點是設定為僅限專用 VLAN，則您必須容許工作者節點及主要叢集透過[啟用專用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置閘道裝置](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)來進行通訊。</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**免費叢集**：您不需要定義專用 VLAN。免費叢集會自動連接至 IBM 所擁有的專用 VLAN。</li><li>**標準叢集**：如果您在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中已設定用於該區域的專用 VLAN，請輸入專用 VLAN 的 ID。如果您的帳戶中沒有專用 VLAN，請不要指定此選項。{{site.data.keyword.containerlong_notm}} 會自動為您建立一個專用 VLAN。<p>專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</p></li>
        <li>若要建立[僅限專用 VLAN 叢集](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan)，請包括此 `--private-vlan` 旗標及 `--private-only` 旗標來確認您的選擇。**不要**包括 `--public-vlan` 及 `--public-service-endpoint` 旗標。請注意，若要啟用主節點與工作者節點之間的連線，您必須包括 `--private-service-endpoint` 旗標，或設定自己的閘道應用裝置。</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**免費及標準叢集**：將 <em>&lt;name&gt;</em> 取代為您的叢集名稱。此名稱必須以字母開頭，可以包含字母、數字及連字號 (-)，且長度不得超過 35 個字元。叢集名稱和叢集部署所在的地區會形成 Ingress 子網域的完整網域名稱。為了確保 Ingress 子網域在地區內是唯一的，叢集名稱可能會被截斷，並在 Ingress 網域名稱內附加一個隨機值。
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**標準叢集**：要內含在叢集裡的工作者節點數目。如果未指定 <code>--workers</code> 選項，會建立 1 個工作者節點。</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**標準叢集**：叢集主節點的 Kubernetes 版本。這是選用值。未指定版本時，會使用支援的 Kubernetes 版本的預設值來建立叢集。若要查看可用的版本，請執行 <code>ibmcloud ks kube-versions</code>。
</td>
        </tr>
        <tr>
        <td><code>--private-service-endpoint</code></td>
        <td>**在[已啟用 VRF 的帳戶](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)中的標準叢集**：啟用[專用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)，讓您的 Kubernetes 主節點和工作者節點能透過專用 VLAN 進行通訊。此外，您可以選擇使用 `--public-service-endpoint` 旗標來啟用公用服務端點，以透過網際網路存取您的叢集。如果您只啟用專用服務端點，則必須連接至專用 VLAN，才能與 Kubernetes 主節點進行通訊。一旦啟用了專用服務端點，之後您將無法停用它。<br><br>建立叢集之後，您可以透過執行 `ibmcloud ks cluster-get <cluster_name_or_ID>` 來取得端點。</td>
        </tr>
        <tr>
        <td><code>--public-service-endpoint</code></td>
        <td>**標準叢集**：啟用[公用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)，以便透過公用網路存取您的 Kubernetes 主節點，例如，從終端機執行 `kubectl` 指令。如果您也包含 `--private-service-endpoint` 旗標，則[主節點-工作者節點通訊](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both)是在專用網路上進行，而且使用已啟用 VRF 的帳戶。如果您想要僅限專用叢集，可以稍後再停用公用服務端點。<br><br>建立叢集之後，您可以透過執行 `ibmcloud ks cluster-get <cluster_name_or_ID>` 來取得端點。</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**免費及標準叢集**：依預設，工作者節點具有 AES 256 位元[磁碟加密](/docs/containers?topic=containers-security#encrypted_disk)功能。如果您要停用加密，請包括此選項。</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**標準裸機叢集**：啟用[授信運算](/docs/containers?topic=containers-security#trusted_compute)，以驗證裸機工作者節點是否遭到竄改。「授信運算」可用於選取裸機的機型。例如，`mgXc` GPU 特性不支援「授信運算」。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。</td>
        </tr>
        </tbody></table>

5.  驗證已要求建立叢集。若為虛擬機器，要訂購工作者節點機器並且在您的帳戶中設定及佈建叢集，可能需要一些時間。裸機實體機器是透過與 IBM Cloud 基礎架構 (SoftLayer) 之間的手動互動來進行佈建，可能需要多個營業日才能完成。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    叢集佈建完成之後，叢集的狀態會變更為 **deployed**。

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.12.7      Default
    ```
    {: screen}

6.  檢查工作者節點的狀態。

    ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
    {: pre}

    工作者節點就緒後，狀況會變更為 **Normal**，並且處於 **Ready** 狀態。當節點狀態為 **Ready** 時，您就可以存取叢集。請注意，即使叢集已備妥，其他服務所使用的一些叢集部分（例如 Ingress 密碼或登錄映像檔取回密碼）可能還是在處理中。

    每個工作者節點都會獲指派唯一的工作者節點 ID 及網域名稱，而在建立叢集之後不得手動變更。變更 ID 或網域名稱會讓 Kubernetes 主節點無法管理叢集。
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.12.7      Default
    ```
    {: screen}

7.  將您建立的叢集設為此階段作業的環境定義。請在您每次使用叢集時，完成下列配置步驟。
    1.  讓指令設定環境變數，並下載 Kubernetes 配置檔。

        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        配置檔下載完成之後，會顯示一個指令，可讓您用來將本端 Kubernetes 配置檔的路徑設定為環境變數。

        OS X 的範例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  複製並貼上終端機中顯示的指令，以設定 `KUBECONFIG` 環境變數。
    3.  驗證已適當地設定 `KUBECONFIG` 環境變數。

        OS X 的範例：

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        輸出：

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

8.  使用預設埠 `8001` 來啟動 Kubernetes 儀表板。
    1.  使用預設埠號來設定 Proxy。

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  在 Web 瀏覽器中開啟下列 URL，以查看 Kubernetes 儀表板。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**下一步為何？**

-   如果您已在具有多區域功能的區域中建立叢集，請藉由[將區域新增至叢集](#add_zone)來展開工作者節點。
-   [在叢集裡部署應用程式。](/docs/containers?topic=containers-app#app_cli)
-   [使用 `kubectl` 指令行管理叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")。](https://kubectl.docs.kubernetes.io/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry?topic=registry-getting-started)
- 如果您有防火牆，則可能需要[開啟必要埠](/docs/containers?topic=containers-firewall#firewall)，才能使用 `ibmcloud`、`kubectl` 或 `calicotl` 指令，以容許來自叢集的出埠資料流量，或容許網路服務的入埠資料流量。
-   [設定叢集 autoscaler](/docs/containers?topic=containers-ca#ca)，以根據工作負載資源要求來自動新增或移除工作者節點儲存區中的工作者節點。
-  控制誰可以使用 [Pod 安全原則](/docs/containers?topic=containers-psp)在您的叢集中建立 Pod。

<br />



## 將工作者節點及區域新增至叢集
{: #add_workers}

若要增加應用程式的可用性，您可以將工作者節點新增至叢集裡的現有區域或多個現有區域。為了協助保護應用程式使其免受區域故障影響，您可以將區域新增至叢集。
{:shortdesc}

當您建立叢集時，會在工作者節點儲存區中佈建工作者節點。在建立叢集之後，您可以藉由調整其大小或新增更多工作者節點儲存區，來將更多工作者節點新增至儲存區。依預設，工作者節點儲存區存在於一個區域中。一個區域中只有一個工作者節點儲存區的叢集稱為單一區域叢集。當您將更多區域新增至叢集時，工作者節點儲存區會存在於多個區域。具有分散到多個區域之工作者節點儲存區的叢集稱為多區域叢集。

如果您有多區域叢集，請保持其工作者節點資源的平衡。請確定所有工作者節點儲存區都分散到相同區域，並藉由調整儲存區大小來新增或移除工作者節點，而不是新增個別節點。
{: tip}

開始之前，請確定您具有[**操作員**或**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](/docs/containers?topic=containers-users#platform)。然後，選擇下列其中一個區段：
  * [調整叢集裡現有工作者節點儲存區的大小來新增工作者節點](#resize_pool)
  * [將工作者節點儲存區新增至叢集來新增工作者節點](#add_pool)
  * [將區域新增至叢集，並將工作者節點儲存區中的工作者節點抄寫到多個區域](#add_zone)
  * [已淘汰：將獨立式工作者節點新增至叢集](#standalone)

設定工作者節點儲存區之後，您可以[設定叢集 autoscaler](/docs/containers?topic=containers-ca#ca)，以根據工作負載資源要求來自動新增或移除工作者節點儲存區中的工作者節點。
{:tip}

### 調整現有工作者節點儲存區的大小來新增工作者節點
{: #resize_pool}

不論工作者節點儲存區是在一個區域還是分散到多個區域，您都可以藉由調整現有工作者節點儲存區的大小來新增或減少叢集裡的工作者節點數目。
{: shortdesc}

例如，請考慮使用一個工作者節點儲存區的每個區域有三個工作者節點的叢集。
* 如果叢集是單一區域，並且存在於 `dal10` 中，則工作者節點儲存區在 `dal10` 中有三個工作者節點。叢集共有三個工作者節點。
* 如果叢集是多區域，並且存在於 `dal10` 及 `dal12` 中，則工作者節點儲存區在 `dal10` 中有三個工作者節點，而且三個工作者節點都在 `dal12` 中。叢集共有六個工作者節點。

針對裸機工作者節點儲存區，請謹記是按月計費。如果您向上或向下調整大小，則它會影響該月的成本。
{: tip}

若要調整工作者節點儲存區的大小，請變更工作者節點儲存區在每一個區域中部署的工作者節點數目：

1. 取得您要調整大小的工作者節點儲存區的名稱。
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. 指定您要在每一個區域中部署的工作者節點數目，以調整工作者節點儲存區的大小。最小值為 1。
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. 驗證已調整工作者節點儲存區的大小。
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    位於兩個區域（`dal10` 及 `dal12`）中且調整大小為每個區域有兩個工作者節點之工作者節點儲存區的輸出範例：
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### 建立新工作者節點儲存區來新增工作者節點
{: #add_pool}

您可以建立新的工作者節點儲存區，以將工作者節點新增至叢集。
{:shortdesc}

1. 擷取叢集的**工作者節點區域**，並選擇要在工作者節點儲存區中部署工作者節點的區域。如果您具有單一區域叢集，則必須使用您在**工作者節點區域**欄位中看到的區域。對於多區域叢集，您可以選擇叢集的任何現有**工作者節點區域**，或為叢集所在的地區新增其中一個[多區域都會位置](/docs/containers?topic=containers-regions-and-zones#zones)。您可以藉由執行 `ibmcloud s zones` 來列出可用的區域。
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   輸出範例：
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. 針對每一個區域，列出可用的專用及公用 VLAN。請記下您要使用的專用及公用 VLAN。如果您沒有專用或公用 VLAN，則會在將區域新增至工作者節點儲存區時自動為您建立 VLAN。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3.  針對每一個區域，檢閱[工作者節點的可用機型](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node)。

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. 建立工作者節點儲存區。如果您佈建祼機工作者節點儲存區，請指定 `--hardware dedicated`。
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. 驗證已建立工作者節點儲存區。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. 依預設，新增工作者節點儲存區會建立沒有區域的儲存區。若要在區域中部署工作者節點，您必須將先前擷取的區域新增至工作者節點儲存區。如果您要將工作者節點分散到多個區域，請對每一個區域重複這個指令。  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

7. 驗證工作者節點佈建於您所新增的區域中。當狀態從 **provision_pending** 變更為 **normal** 時，表示您的工作者節點已備妥。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   輸出範例：
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### 將區域新增至工作者節點儲存區來新增工作者節點
{: #add_zone}

您可以跨越一個地區內跨多個區域的叢集，方法是將區域新增至現有工作者節點儲存區。
{:shortdesc}

當您將區域新增至工作者節點儲存區時，會在新的區域中佈建工作者節點儲存區中所定義的工作者節點，並考慮用於排定未來的工作負載。{{site.data.keyword.containerlong_notm}} 會自動將地區的 `failure-domain.beta.kubernetes.io/region` 標籤以及區域的 `failure-domain.beta.kubernetes.io/zone` 標籤新增至每一個工作者節點。Kubernetes 排程器使用這些標籤，以將 Pod 分散到相同地區內的區域。

如果您的叢集裡有多個工作者節點儲存區，請將該區域新增至所有這些儲存區，以將工作者節點平均地分散到叢集。

開始之前：
*  若要將區域新增至工作者節點儲存區，該工作者節點儲存區必須位於[具有多區域功能的區域](/docs/containers?topic=containers-regions-and-zones#zones)中。如果您的工作者節點儲存區不在具有多區域功能的區域中，請考慮[建立新工作者節點儲存區](#add_pool)。
*  如果您的叢集具有多個 VLAN，同一個 VLAN 上有多個子網路，或者有多個區域叢集，則必須為您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用[虛擬路由器功能 (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)，讓工作者節點可以在專用網路上彼此通訊。若要啟用 VRF，[請與 IBM Cloud 基礎架構 (SoftLayer) 帳戶業務代表聯絡](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion)。如果您無法或不想要啟用 VRF，請啟用 [VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](/docs/containers?topic=containers-users#infra_access)，或者您可以要求帳戶擁有者啟用它。若要確認是否已啟用 VLAN Spanning，請使用 `ibmcloud ks vlan-spanning-get` [指令](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)。


若要將具有工作者節點的區域新增至工作者節點儲存區，請執行下列動作：

1. 列出可用的區域，並挑選您要新增至工作者節點儲存區的區域。您選擇的區域必須是具有多區域功能的區域。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 列出該區域中的可用 VLAN。如果您沒有專用或公用 VLAN，則會在將區域新增至工作者節點儲存區時自動為您建立 VLAN。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. 列出叢集裡的工作者節點儲存區，並記下其名稱。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. 將區域新增至工作者節點儲存區。如果您有多個工作者節點儲存區，請將區域新增至所有工作者節點儲存區，以平衡所有區域中的叢集。請將 `<pool1_id_or_name,pool2_id_or_name,...>` 取代為所有工作者節點儲存區的名稱（以逗點區隔的清單）。

    必須要有專用及公用 VLAN，才能將區域新增至多個工作者節點儲存區。如果您在該區域中沒有專用及公用 VLAN，請先將該區域新增至一個工作者節點儲存區，以為您建立專用及公用 VLAN。然後，您可以指定為您所建立的專用及公用 VLAN，以將該區域新增至其他工作者節點儲存區。
    {: note}

   如果您要對不同的工作者節點儲存區使用不同的 VLAN，則請針對每一個 VLAN 及其對應工作者節點儲存區重複這個指令。任何新的工作者節點都會新增至您指定的 VLAN，但不會變更任何現有工作者節點的 VLAN。
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. 驗證已將區域新增至叢集。在輸出的**工作者節點區域**欄位中，尋找已新增的區域。請注意，隨著在已新增的區域中佈建新工作者節點，**工作者節點**欄位中的工作者節點總數會增加。
  ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
  {: pre}

  輸出範例：
  ```
  Name:                           mycluster
  ID:                             df253b6025d64944ab99ed63bb4567b6
  State:                          normal
  Created:                        2018-09-28T15:43:15+0000
  Location:                       dal10
  Master URL:                     https://c3.<region>.containers.cloud.ibm.com:30426
  Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
  Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
  Master Location:                Dallas
  Master Status:                  Ready (21 hours ago)
  Ingress Subdomain:              mycluster.us-south.containers.appdomain.cloud
  Ingress Secret:                 mycluster
  Workers:                        6
  Worker Zones:                   dal10, dal12
  Version:                        1.11.3_1524
  Owner:                          owner@email.com
  Monitoring Dashboard:           ...
  Resource Group ID:              a8a12accd63b437bbd6d58fb6a462ca7
  Resource Group Name:            Default
  ```
  {: screen}  

### 已淘汰：新增獨立式工作者節點
{: #standalone}

如果您的叢集是在引進工作者節點儲存區之前所建立，則可以使用已淘汰的指令來新增獨立式工作者節點。
{: deprecated}

如果您的叢集是在引進工作者節點儲存區之後所建立，則無法新增獨立式工作者節點。相反地，您可以[建立工作者節點儲存區](#add_pool)、[調整現有工作者節點儲存區的大小](#resize_pool)，或[將區域新增至工作者節點儲存區](#add_zone)，以將工作者節點新增至叢集。
{: note}

1. 列出可用的區域，並挑選您要新增工作者節點的區域。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 列出該區域中的可用 VLAN，並記下其 ID。
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. 列出該區域中的可用機型。
   ```
   ibmcloud ks machine-types --zone <zone>
   ```
   {: pre}

4. 將獨立式工作者節點新增至叢集。若為裸機機型，請指定 `dedicated`。
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. 驗證已建立工作者節點。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## 檢視叢集狀況
{: #states}

檢閱 Kubernetes 叢集的狀況，以取得叢集可用性及容量的相關資訊，以及可能已發生的潛在問題。
{:shortdesc}

若要檢視特定叢集的相關資訊，例如其區域、服務端點 URL、Ingress 子網域、版本、擁有者及監視儀表板，請使用 `ibmcloud ks cluster-get <cluster_name_or_ID>` [指令](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get)。包括 `--showResources` 旗標，以檢視其他叢集資源，例如，儲存空間 Pod 的附加程式，或是公用及專用 IP 的子網路 VLAN。

您可以執行 `ibmcloud ks clusters` 指令並找出**狀況**欄位，以檢視現行叢集狀況。若要對叢集和工作者節點進行疑難排解，請參閱[叢集的疑難排解](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters)。

<table summary="每個表格列都應該從左到右閱讀，第一欄為叢集狀態，第二欄則為說明。">
    <caption>叢集狀況</caption>
   <thead>
   <th>叢集狀況</th>
   <th>說明</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>在部署 Kubernetes 主節點之前，使用者要求刪除叢集。叢集刪除完成之後，即會從儀表板移除該叢集。如果叢集停留在此狀況很長一段時間，請開立 [{{site.data.keyword.Bluemix_notm}} 支援案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)。</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>無法聯繫 Kubernetes 主節點，或叢集裡的所有工作者節點都已關閉。</td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>無法刪除 Kubernetes 主節點或至少一個工作者節點。</td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>叢集已刪除，但尚未從儀表板移除。如果叢集停留在此狀況很長一段時間，請開立 [{{site.data.keyword.Bluemix_notm}} 支援案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)。</td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>正在刪除叢集，且正在拆除叢集基礎架構。您無法存取該叢集。</td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>無法完成 Kubernetes 主節點的部署。您無法解決此狀況。請開立 [{{site.data.keyword.Bluemix_notm}} 支援案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)，以與 IBM Cloud 支援中心聯絡。</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Kubernetes 主節點尚未完整部署。您無法存取叢集。請等到叢集完成部署後，再檢閱叢集的性能。</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>叢集裡的所有工作者節點都已開始執行。您可以存取叢集，並將應用程式部署至叢集。此狀態被視為健全，您不需要採取動作。<p class="note">雖然工作者節點可能是正常的，但也可能需要注意其他的基礎架構資源（例如[網路](/docs/containers?topic=containers-cs_troubleshoot_network)和[儲存空間](/docs/containers?topic=containers-cs_troubleshoot_storage)）。如果您才剛建立叢集，則其他服務所使用的一些叢集部分（例如 Ingress 密碼或登錄映像檔取回密碼）可能還在處理中。。</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>已部署 Kubernetes 主節點。正在佈建工作者節點，因此還無法在叢集裡使用。您可以存取叢集，但無法將應用程式部署至叢集。</td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>已傳送要建立叢集和訂購 Kubernetes 主節點和工作者節點之基礎架構的要求。當開始部署叢集時，叢集狀況會變更為 <code>Deploying</code>。如果叢集停留在 <code>Requested</code> 狀況很長一段時間，請開立 [{{site.data.keyword.Bluemix_notm}} 支援案例](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help)。</td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>在 Kubernetes 主節點中執行的 Kubernetes API 伺服器正更新為新的 Kubernetes API 版本。在更新期間，您無法存取或變更叢集。使用者所部署的工作者節點、應用程式及資源不會遭到修改，並會繼續執行。請等到更新完成後，再檢閱叢集的性能。</td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>叢集裡至少有一個工作者節點無法使用，但有其他工作者節點可用，並且可以接管工作負載。</td>
    </tr>
   </tbody>
 </table>


<br />


## 移除叢集
{: #remove}

不再需要使用計費帳戶所建立的免費及標準叢集時，必須手動移除這些叢集，讓它們不再耗用資源。
{:shortdesc}

<p class="important">
不會在持續性儲存空間中建立叢集或資料的備份。當您刪除叢集時，您可以選擇刪除持續性儲存空間。如果您選擇刪除持續性儲存空間，則在 IBM Cloud 基礎架構 (SoftLayer) 中，會永久刪除您使用 `delete` 儲存空間類別所佈建的持續性儲存空間。如果您是使用 `retain` 儲存空間類別來佈建持續性儲存空間，且您選擇要刪除該儲存空間，則也會刪除叢集、PV 及 PVC，但是 IBM Cloud 基礎架構 (SoftLayer) 帳戶中的持續性儲存空間實例會保留下來。</br>
</br>移除叢集時，您也會移除在建立叢集時自動佈建的所有子網路，以及您使用 `ibmcloud ks cluster-subnet-create` 指令所建立的所有子網路。不過，如果您使用 `ibmcloud ks cluster-subnet-add` 指令手動將現有子網路新增至叢集，則不會從 IBM Cloud 基礎架構 (SoftLayer) 帳戶移除這些子網路，並且可以在其他叢集裡重複使用它們。</p>

開始之前：
* 記下叢集 ID。您可能需要叢集 ID，才能調查及移除未隨著叢集自動刪除的相關 IBM Cloud 基礎架構 (SoftLayer) 資源。
* 如果您要刪除持續性儲存空間中的資料，請[瞭解 delete 選項](/docs/containers?topic=containers-cleanup#cleanup)。
* 確定您具有[**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](/docs/containers?topic=containers-users#platform)。

若要移除叢集，請執行下列動作：

-   從 {{site.data.keyword.Bluemix_notm}} 主控台
    1.  選取叢集，然後按一下**其他動作...** 功能表中的**刪除**。

-   從 {{site.data.keyword.Bluemix_notm}} CLI
    1.  列出可用的叢集。

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  刪除叢集。

        ```
        ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
        ```
        {: pre}

    3.  遵循提示，然後選擇是否刪除叢集資源，其中包括容器、Pod、連結服務、持續性儲存空間及密碼。
      - **持續性儲存空間**：持續性儲存空間為您的資料提供高可用性。如果您使用[現有的檔案共用](/docs/containers?topic=containers-file_storage#existing_file)建立了持續性磁區要求，則在刪除叢集時，無法刪除檔案共用。您必須稍後從 IBM Cloud 基礎架構 (SoftLayer) 組合中手動刪除檔案共用。

          基於每月計費週期，不能在月底最後一天刪除持續性磁區宣告。如果您在該月份的最後一天刪除持續性磁區要求，則刪除會保持擱置，直到下個月開始為止。
          {: note}

後續步驟：
- 當您執行 `ibmcloud ks clusters` 指令時，在可用的叢集清單中不再列出已移除的叢集之後，您就可以重複使用該叢集的名稱。
- 如果保留子網路，則可以[在新的叢集裡重複使用它們](/docs/containers?topic=containers-subnets#subnets_custom)，或稍後從 IBM Cloud 基礎架構 (SoftLayer) 組合中手動刪除它們。
- 如果保留持續性儲存空間，則稍後可以透過 {{site.data.keyword.Bluemix_notm}} 主控台中的 IBM Cloud 基礎架構 (SoftLayer) 儀表板來[刪除儲存空間](/docs/containers?topic=containers-cleanup#cleanup)。
