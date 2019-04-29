---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

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



# 您使用 {{site.data.keyword.containerlong_notm}} 的責任
瞭解使用 {{site.data.keyword.containerlong}} 時，您所擁有的叢集管理責任及條款。
{:shortdesc}

## 叢集管理責任
{: #responsibilities}

檢閱您與 IBM 共同分擔的叢集管理責任。
{:shortdesc}

**IBM 負責：**

- 在建立叢集時，在叢集內部署主節點、工作者節點及管理元件，例如 Ingress 應用程式負載平衡器
- 提供叢集的 Kubernetes 主節點安全更新、監視、隔離及回復
- 讓版本更新項目及安全修補程式可供您套用至叢集工作者節點
- 監視工作者節點的性能，並為那些工作者節點提供自動化更新及回復
- 對基礎架構帳戶執行自動化作業，包括新增工作者節點、移除工作者節點及建立預設子網路
- 管理、更新及回復叢集內的作業元件，例如 Ingress 應用程式負載平衡器及儲存空間外掛程式
- 在持續性磁區要求要求時，佈建儲存磁區
- 在所有工作者節點上提供安全設定

</br>

**您負責：**

- [配置具有適當許可權的 {{site.data.keyword.containerlong_notm}} API 金鑰，以存取 IBM Cloud 基礎架構 (SoftLayer) 組合及其他 {{site.data.keyword.Bluemix_notm}} 服務](/docs/containers?topic=containers-users#api_key)
- [在叢集內部署及管理 Kubernetes 資源，例如 Pod、服務及部署](/docs/containers?topic=containers-app#app_cli)
- [利用服務及 Kubernetes 的功能以確保應用程式的高可用性](/docs/containers?topic=containers-app#highly_available_apps)
- [調整工作者節點儲存區的大小，以新增或移除叢集容量](/docs/containers?topic=containers-clusters#add_workers)
- [啟用 VLAN Spanning，讓多區域工作者節點儲存區在各區域之間保持平衡](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [在 IBM Cloud 基礎架構 (SoftLayer) 建立公用及專用 VLAN，以進行叢集的網路隔離](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [確保所有工作者節點都具有 Kubernetes 服務端點 URL 的網路連線功能](/docs/containers?topic=containers-firewall#firewall) <p class="note">如果工作者節點同時具有公用和專用 VLAN，則已配置網路連線功能。如果工作者節點設定為具有僅限專用 VLAN，則您必須[啟用專用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)或[配置閘道裝置](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway)，以容許工作者節點與叢集主節點通訊。如果您已設定防火牆，則必須管理及配置其設定，以容許存取與叢集搭配使用的 {{site.data.keyword.containerlong_notm}} 及其他 {{site.data.keyword.Bluemix_notm}} 服務。</p>
- [當 Kubernetes 版本更新可用時，更新主節點 kube-apiserver](/docs/containers?topic=containers-update#master)
- [讓工作者節點保持最新的主要、次要及修補程式版本](/docs/containers?topic=containers-update#worker_node) <p class="note">您無法變更工作者節點的作業系統，或登入工作者節點。IBM 會以包括最新安全修補程式的完整工作者節點映像檔形式提供工作者節點更新項目。若要套用更新項目，必須使用新的映像檔來重新映像化及重新載入工作者節點。重新載入工作者節點時，會自動替換 root 使用者的金鑰。</p>
- [設定叢集元件的日誌轉遞來監視叢集性能](/docs/containers?topic=containers-health#health)。   
- [回復出問題的工作者節點，方法為執行 `kubectl` 指令（例如 `cordon` 或 `drain`），以及執行 `ibmcloud ks` 指令（例如 `reboot`、`reload` 或 `delete`）](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [視需要新增或移除 IBM Cloud 基礎架構 (SoftLayer) 中的子網路](/docs/containers?topic=containers-subnets#subnets)
- [在 IBM Cloud 基礎架構 (SoftLayer) 備份及還原持續性儲存空間裡的資料 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- 設定[記載](/docs/containers?topic=containers-health#logging)及[監視](/docs/containers?topic=containers-health#view_metrics)服務，以支援叢集的性能及效能
- [針對具有自動回復的工作者節點配置性能監視](/docs/containers?topic=containers-health#autorecovery)
- 審核可變更叢集裡資源的事件，例如使用 [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) 檢視可變更 {{site.data.keyword.containerlong_notm}} 實例狀況的使用者起始活動

<br />


## {{site.data.keyword.containerlong_notm}} 濫用
{: #terms}

客戶不得誤用 {{site.data.keyword.containerlong_notm}}。
{:shortdesc}

誤用包括：

*   任何不合法的活動
*   散佈或執行惡意軟體
*   危害 {{site.data.keyword.containerlong_notm}} 或干擾任何人使用 {{site.data.keyword.containerlong_notm}}
*   危害或干擾任何人使用任何其他服務或系統
*   未經授權即存取任何服務或系統
*   未經授權即修改任何服務或系統
*   違反他人權利

如需整體使用條款，請參閱[雲端服務條款](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms)。
