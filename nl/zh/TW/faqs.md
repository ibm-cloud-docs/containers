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
{:download: .download}
{:faq: data-hd-content-type='faq'}

# 常見問題
{: #faqs}

## 何謂 Kubernetes？
{: #kubernetes}
{: faq}

Kubernetes 是一個開放程式碼平台，用於管理跨多個主機的容器化工作負載和服務，並提供管理工具來部署、自動執行、監視及調整容器化應用程式，只需最少或無需人為介入。構成微服務的所有容器都會分組成 Pod，這是一個可確保輕鬆管理及探索的邏輯單元。這些 Pod 會在 Kubernetes 叢集裡所管理的運算主機上執行，而此叢集是可攜式、可延伸，並且在失敗時可自我修復。
{: shortdesc}

如需 Kubernetes 的相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational)。 

## 「IBM Cloud Kubernetes 服務」如何運作？
{: #kubernetes_service}
{: faq}

使用 {{site.data.keyword.containerlong_notm}}，您可以建立自己的 Kubneges 叢集，以在 {{site.data.keyword.Bluemix_notm}} 上部署及管理容器化應用程式。您的容器化應用程式是在稱為工作者節點的 IBM Cloud 基礎架構 (SoftLayer) 運算主機上進行管理。您可以選擇將運算主機佈建為具有共用或專用資源的[虛擬機器](cs_clusters_planning.html#vm)，也可以佈建為[裸機機器](cs_clusters_planning.html#bm)，其可最佳化以供 GPU 與軟體定義的儲存空間 (SDS) 使用。您的工作者節點是由 IBM 配置、監視及管理的高可用性 Kubernetes 主節點來控制的。您可以使用 {{site.data.keyword.containerlong_notm}} API 或 CLI 來處理叢集基礎架構資源，以及使用 Kubernetes API 或 CLI 來管理您的部署與服務。 

如需如何設定叢集資源的相關資訊，請參閱[服務架構](cs_tech.html#architecture)。若要尋找功能和好處的清單，請參閱[為何要用 {{site.data.keyword.containerlong_notm}}](cs_why.html#cs_ov)。

## 為何應該使用 IBM Cloud Kubernetes Service？
{: #benefits}
{: faq}

{{site.data.keyword.containerlong_notm}} 是一個受管理的 Kubernetes 供應項目，可提供功能強大的工具、直覺式使用者體驗及內建安全，以快速遞送各種應用程式，您可以將其連結至與 IBM Watson®、AI、IoT、DevOps、安全及資料分析相關的雲端服務。作為認證的 Kibernees 提供者，{{site.data.keyword.containerlong_notm}} 提供智慧型排程、自我修復、水平調整、服務探索與負載平衡、自動化推出與回復，以及密碼與配置管理。該服務還具有依循簡化叢集管理、容器安全及隔離原則的進階功能、設計專屬叢集的能力，以及用於部署一致性的整合作業工具。

如需功能和好處的詳細概觀，請參閱[為何要用 {{site.data.keyword.containerlong_notm}}](cs_why.html#cs_ov)。 

## 服務是否隨附受管理的 Kubernetes 主節點和工作者節點？
{: #managed_master_worker}
{: faq}

{{site.data.keyword.containerlong_notm}} 中的每個 Kubernetes 叢集都是由 IBM 透過 IBM 擁有的 {{site.data.keyword.Bluemix_notm}} 基礎架構帳戶所管理的專用 Kubernetes 主節點予以控制。IBM Site Reliability Engineer (SRE) 會持續監視 Kubernetes 主節點（包括所有主節點元件、運算、網路及儲存空間資源）。SRE 會套用最新的安全標準、偵測並重新修補惡意活動，並且努力確保 {{site.data.keyword.containerlong_notm}} 的可靠性及可用性。當您佈建叢集時自動安裝的附加程式（例如 Fluentd 以進行記載）是由 IBM 自動更新。不過，您可以選擇停用部分附加程式的自動更新，並從主節點及工作者節點分別進行手動更新。如需相關資訊，請參閱[更新叢集附加程式](cs_cluster_update.html#addons)。 

Kubernetes 會定期發行[主要、次要或修補程式更新](cs_versions.html#version_types)。這些更新會影響 Kubernetes API 伺服器版本或 Kubernetes 主節點的其他元件。IBM 會自動更新修補程式版本，但您必須更新主節點的主要及次要版本。
如需相關資訊，請參閱[更新 Kubernetes 主節點](cs_cluster_update.html#master)。 

標準叢集裡的工作者節點會佈建至您的 {{site.data.keyword.Bluemix_notm}} 基礎架構帳戶。工作者節點為您的帳戶所專用，而且您負責向工作者節點要求及時更新，以確保工作者節點 OS 和 {{site.data.keyword.containerlong_notm}} 元件套用最新的安全更新及修補程式。IBM Site Reliability Engineer (SRE) 會提供安全更新項目與修補程式，也會持續監視工作者節點上所安裝的 Linux 映像檔，以偵測漏洞及安全規範問題。如需相關資訊，請參閱[更新工作者節點](cs_cluster_update.html#worker_node)。 

## Kubernetes 主節點與工作者節點具有高可用性嗎？
{: #ha}
{: faq}

{{site.data.keyword.containerlong_notm}} 架構及基礎架構的設計旨在確保可靠性、縮短處理延遲時間及服務執行時間最大化。依預設，{{site.data.keyword.containerlong_notm}} 中每個執行 Kibernetes 1.10 版或更新版本的叢集，都是使用多個 Kubernetes 主節點實例來設定，以確保叢集資源的可用性及可存取性，即使 Kubernetes 主節點的一個以上實例無法使用。 

您可以讓叢集具有更高可用性，並藉由將工作負載分散在某個地區的多個區域中的多個工作者節點之中，來保護應用程式免於關閉。此設定稱為[多區域叢集](cs_clusters_planning.html#multizone)，並確保您的應用程式可存取，即使工作者節點或整個區域無法使用。 

若要防範整個地區失敗，請建立[多個叢集，並將它們分散在各 {{site.data.keyword.containerlong_notm}} 地區](cs_clusters_planning.html#multiple_clusters)之中。藉由設定叢集的負載平衡器，您可以達到叢集的跨地區負載平衡及跨地區網路。 

如果您具有必須可供使用的資料，則即使運作中斷，也請務必將您的資料儲存在[持續性儲存空間](cs_storage_planning.html#storage_planning)中。 

如需如何達到叢集高可用性的相關資訊，請參閱 [{{site.data.keyword.containerlong_notm}} 的高可用性](cs_ha.html#ha)。 

## 我有哪些可用來保護叢集的選項？
{: #secure_cluster}
{: faq}

您可以使用 {{site.data.keyword.containerlong_notm}} 中的內建安全特性，來保護叢集裡的元件、資料及應用程式部署，以確保安全規範及資料完整性。請使用這些特性來保護 Kubernetes API 伺服器、etcd 資料儲存庫、工作者節點、儲存空間、映像檔及部署，免於惡意攻擊。您也可以運用內建的記載和監視工具，來偵測惡意攻擊和可疑的使用型樣。 

如需叢集元件以及如何保護每一個元件的相關資訊，請參閱 [{{site.data.keyword.containerlong_notm}} 的安全](cs_secure.html#security)。 

## 服務是否提供裸機和 GPU 的支援？ 
{: #bare_metal_gpu}
{: faq}

是，您可以將工作者節點佈建為單一承租戶實體裸機伺服器。裸機伺服器隨附工作負載的高效能好處，例如資料、AI 及 GPU。此外，所有硬體資源都為您的工作負載專用，因此您不必擔心「吵雜的鄰居」。

如需可用裸機特性以及裸機與虛擬機器有何不同的相關資訊，請參閱[實體機器（裸機）](cs_clusters_planning.html#bm)。

## 服務支援哪些 Kubernet 版本？ 
{: #supported_kube_versions}
{: faq}

{{site.data.keyword.containerlong_notm}} 同時支援多個 Kubernetes 版本。發行最新版本 (n) 時，最多支援到前 2 個 (n-2) 版本。超過最新版本前 2 個版本的版本 (n-3) 會先被淘汰，然後不受支援。
目前支援下列版本： 

- 最新：1.12.3
- 預設：1.10.11
- 其他：1.11.5

如需支援的版本，以及您必須採取以從某個版本移至另一個版本之更新動作的相關資訊，請參閱[版本資訊與更新動作](cs_versions.html#cs_versions)。

## 可在何處使用服務？
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} 可在全球使用。您可以在每個支援的 {{site.data.keyword.containerlong_notm}} 地區建立標準叢集。免費叢集僅適用於選取地區。

如需支援地區的相關資訊，請參閱[地區與區域](cs_regions.html#regions-and-zones)。

## 服務符合哪些標準？ 
{: #standards}
{: faq}

{{site.data.keyword.containerlong_notm}} 實作控制項與下列標準相稱： 
- HIPAA
- SOC1
- SOC2 類型 1
- ISAE 3402
- ISO 27001
- ISO 27017
- ISO 27018

## 我可以使用 IBM Cloud 及其他服務與叢集搭配嗎？
{: #integrations}
{: faq}

您可以將 {{site.data.keyword.Bluemix_notm}} 平台及基礎架構服務，以及來自協力廠商供應商的服務新增至 {{site.data.keyword.containerlong_notm}}叢集，以啟用自動化、提高安全，或加強叢集裡的監視和記載功能。

如需支援服務的清單，請參閱[整合服務](cs_integrations.html#integrations)。

## 我可以連接 IBM Cloud Public 中的叢集與在內部部署資料中心內執行的應用程式嗎？
{: #hybrid}
{: faq}

您可以連接 {{site.data.keyword.Bluemix_notm}} Public 中的服務與內部部署資料中心，以建立自己的混合式雲端設定。如何運用 {{site.data.keyword.Bluemix_notm}} Public 及 Private 與在內部部署資料中心內執行的應用程式搭配的範例包括： 
- 您在 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 中使用 {{site.data.keyword.containerlong_notm}} 來建立叢集，但想要連接叢集與內部部署資料庫。
- 您可以在自己的資料中心的 {{site.data.keyword.Bluemix_notm}} Private 中建立 Kubernets 叢集，並將應用程式部署至您的叢集。不過，您的應用程式可能會在 {{site.data.keyword.Bluemix_notm}} Public 中使用 {{site.data.keyword.ibmwatson_notm}} 服務，例如 Tone Analyzer。

若要啟用在 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 執行的服務與執行內部部署的服務之間的通訊，您必須[設定 VPN 連線](cs_vpn.html#vpn)。若要連接 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated 環境與 {{site.data.keyword.Bluemix_notm}} Private 環境，請參閱[使用 {{site.data.keyword.containerlong_notm}} 與 {{site.data.keyword.Bluemix_notm}} Private 搭配](cs_hybrid.html#hybrid_iks_icp)。

如需支援的 {{site.data.keyword.containerlong_notm}} 供應項目的概觀，請參閱[供應項目與其組合的比較](cs_why.html#differentiation)。

## 我可以在自己的資料中心內部署 IBM Cloud Kubernetes Service 嗎？
{: #private}
{: faq}

如果您不想要將應用程式移至 {{site.data.keyword.Bluemix_notm}} Public 或 Dedicated，但仍想要運用 {{site.data.keyword.containerlong_notm}} 的特性，則可以安裝 {{site.data.keyword.Bluemix_notm}} Private。{{site.data.keyword.Bluemix_notm}} Private 是可在您自己機器本端安裝的應用程式平台，而且您可以將其用於在防火牆後面的專屬控制環境中開發及管理內部部署的容器化應用程式。 

如需相關資訊，請參閱 [{{site.data.keyword.Bluemix_notm}} Private 產品說明文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html)。
  

## 使用 IBM Cloud Kubernetes Service 時，我要支付哪些項目的費用？
{: #charges}
{: faq}

使用 {{site.data.keyword.containerlong_notm}} 叢集，您可以搭配使用 IBM Cloud 基礎架構 (SoftLayer) 運算、網路及儲存空間資源與平台服務（例如 Watson AI 或 Compose Database-as-a-Service）。每個資源都可能會有自己的費用，其可以是[固定、計量、分層或保留](/docs/billing-usage/how_charged.html#charges)。 
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
  <dd>當您佈建儲存空間時，可以為您的使用案例選擇適合的儲存空間類型及儲存空間類別。費用會視儲存空間類型、位置及儲存空間實例規格而不同。部分儲存空間解決方案（例如檔案及區塊儲存空間）提供您可以從中選擇的每小時及每月方案。若要選擇正確的儲存空間解決方案，請參閱[規劃高度可用的持續性儲存空間](cs_storage_planning.html#storage_planning)。如需相關資訊，請參閱：<ul><li>[NFS 檔案儲存空間定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[區塊儲存空間定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[物件儲存空間方案 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">{{site.data.keyword.Bluemix_notm}} 服務</dt>
  <dd>與您的叢集整合的每個服務都有自己的定價模型。如需相關資訊，請參閱每個產品說明文件及[成本預估器 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/pricing/)。</dd>

</dl>

每月資源是根據該月的第一天收取前一個月用量的費用。如果您在月中訂購每月資源，則會向您收取該月份的按比例分配金額。不過，如果您在月中取消資源，則仍會向您收取每月資源的完整金額。
{: note}

## 我的平台和基礎架構資源是否合併在一個帳單中？
{: #bill}
{: faq}

使用 {{site.data.keyword.Bluemix_notm}} 計費帳戶時，會在一個帳單中彙總平台及基礎架構資源。如果您已鏈結 {{site.data.keyword.Bluemix_notm}} 及 IBM Cloud 基礎架構 (SoftLayer) 帳戶，則會收到 {{site.data.keyword.Bluemix_notm}} 平台與基礎架構資源的[合併帳單](/docs/customer-portal/linking_accounts.html#unifybillaccounts)。 

## 是否可以預估成本？
{: #cost_estimate}
{: faq}

是，如需相關資訊，請參閱[預估成本](/docs/billing-usage/estimating_costs.html#cost)及[成本預估器 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/pricing/) 工具。 

## 是否可以檢視現行用量？ 
{: #usage}
{: faq}

您可以檢查 {{site.data.keyword.Bluemix_notm}} 平台及基礎架構資源的現行用量及每月預估總計。如需相關資訊，請參閱[檢視用量](/docs/billing-usage/viewing_usage.html#viewingusage)。若要組織您的計費，您可以使用[資源群組](/docs/resources/bestpractice_rgs.html#bp_resourcegroups)將資源分組。 

