---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# 為何要用 {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containerlong}} 藉由結合 Docker 容器、Kubernetes 技術、直覺式使用者體驗，以及內建安全和隔離來提供功能強大的工具，以在運算主機的叢集裡自動部署、操作、調整及監視容器化應用程式。如需憑證資訊，請參閱 [Compliance on the {{site.data.keyword.Bluemix_notm}} ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/compliance)。
{:shortdesc}


## 使用服務的優點
{: #benefits}

叢集部署於提供原生 Kubernetes 及 {{site.data.keyword.IBM_notm}} 特有功能的運算主機上。
{:shortdesc}

|優點|說明|
|-------|-----------|
|具有運算、網路及儲存空間基礎架構隔離的單一承租戶 Kubernetes 叢集|<ul><li>建立符合組織需求的專屬自訂基礎架構。</li><li>使用 IBM Cloud 基礎架構 (SoftLayer) 所提供的資源，來佈建專用且受保護的 Kubernetes 主節點、工作者節點、虛擬網路及儲存空間。</li><li>完全受管理的 Kubernetes 主節點，它持續由 {{site.data.keyword.IBM_notm}} 監視及更新，以保持叢集可供使用。</li><li>可以選擇使用「授信運算」將工作者節點佈建為裸機伺服器。</li><li>儲存持續性資料、在 Kubernetes Pod 之間共用資料，以及在需要時使用整合且安全的磁區服務來還原資料。</li><li>獲得所有原生 Kubernetes API 的完整支援的好處。</li></ul>|
|增加高可用性的多區域叢集 | <ul><li>使用工作者節點儲存區，輕鬆地管理相同機型（CPU、記憶體、虛擬或實體）的工作者節點。</li><li>保護區域免於失敗，方法為將節點平均地分佈在精選的多個區域，並對您的應用程式使用反親緣性 Pod 部署。</li><li>使用多區域叢集，而非複製個別叢集裡的資源來降低成本。</li><li>受益於使用多區域負載平衡器 (MZLB) 跨應用程式進行自動負載平衡，而此負載平衡器是在叢集的每一個區域中自動為您設定的。</li></ul>|
|高可用性主節點 | <ul>可在執行 Kubernetes 1.10 版或更新版本的叢集裡使用。<li>例如在主節點更新期間減少叢集關閉時間，而高可用性主節點會在您建立叢集時自動佈建。</li><li>將您的主節點分散在[多區域叢集](cs_clusters_planning.html#multizone)的各區域之中，以保護您的叢集免於發生區域失敗。</li></ul> |
|「漏洞警告器」的映像檔安全規範|<ul><li>在我們保護的 Docker 專用映像檔登錄中設定您自己的儲存庫，而組織中的所有使用者都會在這裡儲存及共用映像檔。</li><li>受益於自動掃描專用 {{site.data.keyword.Bluemix_notm}} 登錄中的映像檔。</li><li>檢閱映像檔中所用作業系統特有的建議，來修正潛在漏洞。</li></ul>|
|叢集性能的持續監視|<ul><li>使用叢集儀表板，快速查看及管理叢集、工作者節點及容器部署的性能。</li><li>使用 {{site.data.keyword.monitoringlong}} 來尋找詳細的耗用度量值，並快速擴展叢集以符合工作負載。</li><li>使用 {{site.data.keyword.loganalysislong}} 來檢閱記載資訊，以查看詳細的叢集活動。</li></ul>|
|安全地將應用程式公開給大眾使用|<ul><li>選擇公用 IP 位址、{{site.data.keyword.IBM_notm}} 所提供的路徑，或您自己的自訂網域，以從網際網路存取叢集裡的服務。</li></ul>|
|{{site.data.keyword.Bluemix_notm}} 服務整合|<ul><li>透過整合 {{site.data.keyword.Bluemix_notm}} 服務（例如 Watson API、Blockchain、資料服務或 Internet of Things），為應用程式增加額外的功能。</li></ul>|
{: caption="{{site.data.keyword.containerlong_notm}} 的優點" caption-side="top"}

準備好要開始了嗎？請試用[建立 Kubernetes 叢集指導教學](cs_tutorials.html#cs_cluster_tutorial)。

<br />


## 供應項目及其組合的比較
{: #differentiation}

您可以在 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated、在 {{site.data.keyword.Bluemix_notm}} Private，或在混合式設定中執行 {{site.data.keyword.containerlong_notm}}。
{:shortdesc}


<table>
<caption>{{site.data.keyword.containerlong_notm}} 設定之間的差異</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>{{site.data.keyword.containerlong_notm}} 設定</th>
 <th>說明</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Public
 </td>
 <td>利用[共用或專用硬體上或祼機機器上](cs_clusters_planning.html#shared_dedicated_node)的 {{site.data.keyword.Bluemix_notm}} Public，您可以使用 {{site.data.keyword.containerlong_notm}} 來管理雲端上叢集裡的應用程式。您也可以建立在多個區域中有工作者節點儲存區的叢集，以增加應用程式的高可用性。{{site.data.keyword.Bluemix_notm}} Public 上的 {{site.data.keyword.containerlong_notm}} 藉由結合 Docker 容器、Kubernetes 技術、直覺式使用者體驗，以及內建安全和隔離來提供功能強大的工具，以在運算主機的叢集裡自動部署、操作、調整及監視容器化應用程式。<br><br>如需相關資訊，請參閱 [{{site.data.keyword.containerlong_notm}} 技術](cs_tech.html)。</td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated 在雲端上提供與 {{site.data.keyword.Bluemix_notm}} Public 相同的 {{site.data.keyword.containerlong_notm}} 功能。不過，使用 {{site.data.keyword.Bluemix_notm}} Dedicated 帳戶時，可用的[實體資源只供您的叢集專用](cs_clusters_planning.html#shared_dedicated_node)，不會與其他 {{site.data.keyword.IBM_notm}} 客戶的叢集共用。當需要隔離您的叢集與您使用的其他 {{site.data.keyword.Bluemix_notm}} 服務時，您可能會選擇設定 {{site.data.keyword.Bluemix_notm}} Dedicated 環境。<br><br>如需相關資訊，請參閱[開始使用 {{site.data.keyword.Bluemix_notm}} Dedicated 中的叢集](cs_dedicated.html#dedicated)。
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Private
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Private 是可在您自己機器本端安裝的應用程式平台。當您需要在防火牆後面的專屬控制環境中，開發及管理內部部署的容器化應用程式時，您可能選擇使用 {{site.data.keyword.Bluemix_notm}} Private 中的 Kubernetes。<br><br>如需相關資訊，請參閱 [{{site.data.keyword.Bluemix_notm}} Private 產品說明文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html)。
 </td>
 </tr>
 <tr>
 <td>混合式設定
 </td>
 <td>混合式可結合使用 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 中執行的服務，以及在內部部署執行的其他服務（例如 {{site.data.keyword.Bluemix_notm}} Private 中的應用程式）。混合式設定的範例：<ul><li>使用 {{site.data.keyword.Bluemix_notm}} Public 中的 {{site.data.keyword.containerlong_notm}} 佈建叢集，但將該叢集連接至內部部署資料庫。</li><li>使用 {{site.data.keyword.Bluemix_notm}} Private 中的 {{site.data.keyword.containerlong_notm}} 佈建叢集，並將該應用程式部署至該叢集。不過，此應用程式可能使用 {{site.data.keyword.Bluemix_notm}} Public 中的 {{site.data.keyword.ibmwatson}} 服務，例如 {{site.data.keyword.toneanalyzershort}}。</li></ul><br>若要啟用在 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 執行的服務與執行內部部署的服務之間的通訊，您必須[設定 VPN 連線](cs_vpn.html)。
 如需相關資訊，請參閱[使用 {{site.data.keyword.containerlong_notm}} 與 {{site.data.keyword.Bluemix_notm}} Private 搭配](cs_hybrid.html)。
 </td>
 </tr>
 </tbody>
</table>

<br />


## 免費與標準叢集的比較
{: #cluster_types}

您可以建立一個免費叢集或任意數目的標準叢集。請試用免費叢集，以熟悉一些 Kubernetes 功能，或是建立標準叢集，以使用完整的 Kubernetes 功能來部署應用程式。在 30 天之後，會自動刪除免費叢集。
{:shortdesc}

如果您有免費叢集，並且想要升級至標準叢集，則可以[建立標準叢集](cs_clusters.html#clusters_ui)。然後，將您使用免費叢集所建立之 Kubernetes 資源的任何 YAML 部署至標準叢集。

|特徵|免費叢集|標準叢集|
|---------------|-------------|-----------------|
|[叢集內網路](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[NodePort 服務對於不穩定 IP 位址的公用網路應用程式存取](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[使用者存取管理](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[叢集和應用程式中的 {{site.data.keyword.Bluemix_notm}} 服務存取](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[工作者節點上用於非持續性儲存空間的磁碟空間](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
| [能夠在每個 {{site.data.keyword.containerlong_notm}} 地區中建立叢集](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" /> |
|[增加應用程式高可用性的多區域叢集](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
| 更高可用性的已抄寫主節點（Kubernetes 1.10 或更新版本）| | <img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" /> |
|[增加容量之工作者節點的可擴充數目](cs_app.html#app_scaling)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[含磁區的持續性 NFS 檔案型儲存空間](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[負載平衡器服務對於穩定 IP 位址的公用或專用網路應用程式存取](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[Ingress 服務對於穩定 IP 位址及可自訂 URL 的公用網路應用程式存取](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[可攜式公用 IP 位址](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[記載及監視](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[可以選擇在實體（裸機）伺服器上佈建工作者節點](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[可以使用授信運算佈建裸機工作者節點](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[在 {{site.data.keyword.Bluemix_dedicated_notm}} 中提供](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
{: caption="免費及標準叢集的性質" caption-side="top"}

<br />




## 定價與計費
{: #pricing}

檢閱 {{site.data.keyword.containerlong_notm}} 定價與計費的一些常見問題。對於帳戶層次問題，請參閱[管理計費及用量文件](/docs/billing-usage/how_charged.html#charges)。如需您帳戶合約的詳細資料，請參閱適當的 [{{site.data.keyword.Bluemix_notm}} 條款及注意事項](/docs/overview/terms-of-use/notices.html#terms)。
{: shortdesc}

### 如何檢視及組織用量？
{: #usage}

**如何檢查計費及用量？**<br>
若要檢查用量及預估總計，請參閱[檢視用量](/docs/billing-usage/viewing_usage.html#viewingusage)。

如果您鏈結 {{site.data.keyword.Bluemix_notm}} 及 IBM Cloud 基礎架構 (SoftLayer) 帳戶，則會收到合併帳單。如需相關資訊，請參閱[已鏈結帳戶的合併帳單](/docs/customer-portal/linking_accounts.html#unifybillaccounts)。

**基於計費用途，可以依團隊或部門將雲端資源分組嗎？**<br>
您可以[使用資源群組](/docs/resources/bestpractice_rgs.html#bp_resourcegroups)，將您的 {{site.data.keyword.Bluemix_notm}} 資源（包括叢集）組織成數個群組，以組織計費。

### 如何收費？按每小時或每月收費？
{: #monthly-charges}

您的費用取決於使用的資源類型，而且可能是固定、計量、分層或保留。如需相關資訊，請檢視[如何收費](/docs/billing-usage/how_charged.html#charges)。

在 {{site.data.keyword.containerlong_notm}} 中，可以按小時或按月收取 IBM Cloud 基礎架構 (SoftLayer) 資源的費用。
* 虛擬機器 (VM) 工作者節點是按小時計費。
* 在 {{site.data.keyword.containerlong_notm}} 中，實體（裸機）工作者節點為按月計費資源。
* 對於其他基礎架構資源（例如檔案或區塊儲存空間），您可以在建立資源時，選擇按小時或按月計費。

每月資源是根據該月的第一天收取前一個月用量的費用。如果您在月中訂購每月資源，則會向您收取該月份的按比例分配金額。不過，如果您在月中取消資源，則仍會向您收取每月資源的完整金額。

### 是否可以預估成本？
{: #estimate}

是，請參閱[預估成本](/docs/billing-usage/estimating_costs.html#cost)及[成本預估器 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/pricing/) 工具。請繼續閱讀成本預估器中未包含成本的相關資訊（例如出埠網路）。

### 使用 {{site.data.keyword.containerlong_notm}} 時，會向我收取哪些項目的費用？
{: #cluster-charges}

使用 {{site.data.keyword.containerlong_notm}} 叢集，您可以搭配使用 IBM Cloud 基礎架構 (SoftLayer) 運算、網路及儲存空間資源與平台服務（例如 Watson AI 或 Compose Database-as-a-Service）。每個資源都可能會有自己的費用。
* [工作者節點](#nodes)
* [出埠網路](#bandwidth)
* [子網路 IP 位址](#subnets)
* [儲存空間](#storage)
* [{{site.data.keyword.Bluemix_notm}} 服務](#services)

<dl>
<dt id="nodes">工作者節點</dt>
  <dd><p>叢集可以有兩種主要類型的工作者節點：虛擬或實體（裸機）機器。機型可用性及定價會因您部署叢集的區域而異。</p>
  <p><strong>虛擬機器</strong>具備比裸機更大的彈性、更快速的佈建時間，以及更多的自動可擴充性特性，而且價格比裸機更加划算。不過，與裸機規格（例如網路 Gbps、RAM 和記憶體臨界值，以及儲存空間選項）比較時，VM 會做出效能取捨。請記住下列影響 VM 成本的因素：</p>
  <ul><li><strong>共用與專用</strong>：如果您共用 VM 的基礎硬體，則成本會低於專用硬體，但實體資源並非專供您的 VM 使用。</li>
  <li><strong>僅限按小時計費</strong>：「按小時」提供更多的彈性來快速訂購及取消 VM。
  <li><strong>每個月的分層時數</strong>：將按小時計費分層。因為針對計費月份內的小時層級訂購您的 VM，所以向您收取的每小時費率會較低。小時的層級如下：0 - 150 小時、151 - 290 小時、291 - 540 小時及 541+ 小時。</li></ul>
  <p><strong>實體機器（裸機）</strong>會為資料、AI 及 GPU 等工作負載帶來高效能優點。此外，所有硬體資源都為您的工作負載專用，因此您沒有「吵雜的鄰居」。請記住下列影響裸機成本的因素：</p>
  <ul><li><strong>僅限按月計費</strong>：所有裸機都是按月計費。</li>
  <li><strong>較長的訂購處理程序</strong>：因為訂購及取消裸機伺服器是透過 IBM Cloud 基礎架構 (SoftLayer) 帳戶的手動處理程序，所以可能需要超過一個營業日才能完成。</li></ul>
  <p>如需機器規格的詳細資料，請參閱[工作者節點的可用硬體](/docs/containers/cs_clusters_planning.html#shared_dedicated_node)。</p></dd>

<dt id="bandwidth">公用頻寬</dt>
  <dd><p>頻寬指的是入埠及出埠網路資料流量的公用資料傳送，即進出全球資料中心之 {{site.data.keyword.Bluemix_notm}} 資源的網路資料流量。公用頻寬是按每 GB 收費。您可以檢閱現行頻寬摘要，方法是登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)，並從功能表 ![「功能表」圖示](../icons/icon_hamburger.svg "「功能表」圖示") 中選取**基礎架構**，然後選取**網路 > 頻寬 > 摘要**頁面。
  <p>檢閱下列影響公用頻寬費用的因素：</p>
  <ul><li><strong>位置</strong>：與使用工作者節點相同，費用會視資源部署所在的區域而不同。</li>
  <li><strong>已包括頻寬或隨收隨付制</strong>：您的工作者節點機器可能會隨附每個月出埠網路的特定配置（例如 250GB 用於 VM 或 500GB 用於裸機）。或者，根據 GB 用量，配置可能是「隨收隨付制」。</li>
  <li><strong>分層套件</strong>：在您超出任何已包括的頻寬之後，會根據依位置而異的分層用量方法向您收費。如果您超出層級分配，則也可能會向您收取標準資料傳送費用。</li></ul>
  <p>如需相關資訊，請參閱[頻寬套件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/bandwidth)。</p></dd>

<dt id="subnets">子網路 IP 位址</dt>
  <dd><p>當您建立標準叢集時，會訂購 1 個可攜式公用子網路（含 8 個公用 IP 位址），並每月向您的帳戶收費。</p><p>如果您的基礎架構帳戶中已有可用的子網路，則您可以改為使用這些子網路。使用 `--no-subnets` [旗標](cs_cli_reference.html#cs_cluster_create)建立叢集，然後[重複使用子網路](cs_subnets.html#custom)。</p>
  </dd>

<dt id="storage">儲存空間</dt>
  <dd>當您佈建儲存空間時，可以為您的使用案例選擇適合的儲存空間類型及儲存空間類別。費用會視儲存空間類型、位置及儲存空間實例規格而不同。若要選擇正確的儲存空間解決方案，請參閱[規劃高度可用的持續性儲存空間](cs_storage_planning.html#storage_planning)。如需相關資訊，請參閱：<ul><li>[NFS 檔案儲存空間定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[區塊儲存空間定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[物件儲存空間方案 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} 服務</dt>
  <dd>與您的叢集整合的每個服務都有自己的定價模型。如需相關資訊，請參閱每個產品說明文件及[成本預估器 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/pricing/)。</dd>

</dl>
