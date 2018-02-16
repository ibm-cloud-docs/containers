---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 為何要用 {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containershort}} 藉由結合 Docker 和 Kubernetes 技術、直覺式使用者體驗以及內建安全和隔離來提供功能強大的工具，以在運算主機的叢集中自動部署、操作、擴充及監視容器化應用程式。
{:shortdesc}

## 使用叢集的優點
{: #benefits}

叢集部署於提供原生 Kubernetes 及 {{site.data.keyword.IBM_notm}} 所新增功能的運算主機上。
{:shortdesc}

|優點|說明|
|-------|-----------|
|具有運算、網路及儲存空間基礎架構隔離的單一承租戶 Kubernetes 叢集|<ul><li>建立符合組織需求的專屬自訂基礎架構。</li><li>使用 IBM Cloud 基礎架構 (SoftLayer) 所提供的資源，來佈建專用且受保護的 Kubernetes 主節點、工作者節點、虛擬網路及儲存空間。</li><li>儲存持續性資料、在 Kubernetes Pod 之間共用資料，以及在需要時使用整合及安全磁區服務來還原資料。</li><li>完整管理的 Kubernetes 主節點，持續由 {{site.data.keyword.IBM_notm}} 監視及更新，以保持叢集可供使用。</li><li>所有原生 Kubernetes API 的完整支援的優點。</li></ul>|
|「漏洞警告器」的映像檔安全相符性|<ul><li>設定您自己的安全 Docker 專用映像檔登錄，而組織中的所有使用者都會在這裡儲存及共用映像檔。</li><li>自動掃描專用 {{site.data.keyword.Bluemix_notm}} 登錄中映像檔的優點。</li><li>檢閱映像檔中所使用的作業系統特有的建議，來修正潛在漏洞。</li></ul>|
|自動擴充應用程式|<ul><li>定義自訂原則，以根據 CPU 及記憶體耗用量來擴增及縮減應用程式。</li></ul>|
|叢集性能的持續監視|<ul><li>使用叢集儀表板，快速查看及管理叢集、工作者節點及容器部署的性能。</li><li>使用 {{site.data.keyword.monitoringlong}} 來尋找詳細的耗用度量值，並快速擴充叢集以符合工作負載。</li><li>使用 {{site.data.keyword.loganalysislong}} 來檢閱記載資訊，以查看詳細的叢集活動。</li></ul>|
|自動回復性能不佳的容器|<ul><li>工作者節點上所部署容器的持續性能檢查。</li><li>在失敗時自動重建容器。</li></ul>|
|服務探索及服務管理|<ul><li>集中登錄應用程式服務，讓它們可供叢集中的其他應用程式使用，而不需要公開它們。</li><li>不需要持續追蹤變更中的 IP 位址或容器 ID 即可探索登錄的服務，並可獲得自動遞送至可用實例的優點。</li></ul>|
|安全地將服務公開給大眾使用|<ul><li>具有完整負載平衡器及 Ingress 支援的專用覆蓋網路，讓應用程式可公開使用，並平衡多個工作者節點之間的工作負載，而不需要追蹤叢集內不停變更的 IP 位址。</li><li>選擇公用 IP 位址、{{site.data.keyword.IBM_notm}} 所提供的路徑，或您自己的自訂網域，以從網際網路存取叢集中的服務。</li></ul>|
|{{site.data.keyword.Bluemix_notm}} 服務整合|<ul><li>透過整合 {{site.data.keyword.Bluemix_notm}} 服務（例如 Watson API、Blockchain、資料服務或 Internet of Things）來新增應用程式的額外功能，並協助叢集使用者簡化應用程式開發及容器管理程序。</li></ul>|

<br />


## 比較精簡與標準叢集
{: #cluster_types}

您可以建立精簡或標準叢集。請試用精簡叢集，以熟悉並測試一些 Kubernetes 功能，或建立標準叢集，以使用完整的 Kubernetes 功能來部署應用程式。
{:shortdesc}

|特徵|精簡叢集|標準叢集|
|---------------|-------------|-----------------|
|[{{site.data.keyword.Bluemix_notm}} 中可用](cs_why.html)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[叢集內網路](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[NodePort 服務的公用網路應用程式存取](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[使用者存取管理](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[叢集及應用程式中的 {{site.data.keyword.Bluemix_notm}} 服務存取](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[工作者節點上用於儲存的磁碟空間](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[含磁區的持續性 NFS 檔案型儲存空間](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[負載平衡器服務的公用或專用網路應用程式存取](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[Ingress 服務的公用網路應用程式存取](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[可攜式公用 IP 位址](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[記載及監視](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|
|[{{site.data.keyword.Bluemix_dedicated_notm}} 中可用](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="可用的特性" style="width:32px;" />|

<br />



## 叢集管理責任
{: #responsibilities}

檢閱您與 IBM 共同分擔的叢集管理責任。
{:shortdesc}

**IBM 負責：**

- 在叢集建立時間，在叢集內部署主節點、工作者節點及管理元件，例如 Ingress 控制器
- 管理叢集的 Kubernetes 主節點更新、監視及回復
- 監視工作者節點的性能，並為那些工作者節點提供自動化更新及回復
- 對基礎架構帳戶執行自動化作業，包括新增工作者節點、移除工作者節點及建立預設子網路
- 管理、更新及回復叢集內的作業元件，例如 Ingress 控制器及儲存空間外掛程式
- 在持續性磁區宣告要求時，佈建儲存磁區
- 在所有工作者節點上提供安全設定

</br>
**您負責：**

- [在叢集內部署及管理 Kubernetes 資源，例如 Pod、服務及部署](cs_app.html#app_cli)
- [利用服務及 Kubernetes 的功能以確保應用程式的高可用性](cs_app.html#highly_available_apps)
- [使用 CLI 新增或移除工作者節點，以新增或移除產能](cs_cli_reference.html#cs_worker_add)
- [在 IBM Cloud 基礎架構 (SoftLayer) 建立公用及專用 VLAN，以進行叢集的網路隔離](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [確保所有工作者節點都具有 Kubernetes 主節點 URL 的網路連線功能](cs_firewall.html#firewall) <p>**附註**：如果工作者節點同時具有公用和專用 VLAN，則已配置網路連線功能。如果工作者節點僅設定專用 VLAN，則需要 Vyatta 以提供網路連線功能。</p>
- [當有 Kubernetes 主要或次要版本更新時，更新主要 kube-apiserver 及工作者節點](cs_cluster_update.html#master)
- [採取動作來回復問題工作者節點，方法為執行 `kudectl` 指令，例如 `coron` 或 `drain`，以及執行 `bx cs` 指令，例如 `reboot`、`reload` 或 `delete`](cs_cli_reference.html#cs_worker_reboot)
- [視需要新增或移除 IBM Cloud 基礎架構 (SoftLayer) 中的其他子網路](cs_subnets.html#subnets)
- [在 IBM Cloud 基礎架構 (SoftLayer) 備份及還原持續性儲存空間裡的資料 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## 容器濫用
{: #terms}

客戶不得誤用 {{site.data.keyword.containershort_notm}}。
{:shortdesc}

誤用包括：

*   任何不合法的活動
*   散佈或執行惡意軟體
*   危害 {{site.data.keyword.containershort_notm}} 或干擾任何人使用 {{site.data.keyword.containershort_notm}}
*   危害或干擾任何人使用任何其他服務或系統
*   任何服務或系統的未獲授權存取
*   任何服務或系統的未獲授權修改
*   違反其他人權利

如需整體使用條款，請參閱[雲端服務條款](/docs/navigation/notices.html#terms)。
