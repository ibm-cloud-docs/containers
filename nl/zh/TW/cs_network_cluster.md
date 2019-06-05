---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

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

# 設定叢集網路
{: #cs_network_cluster}

在 {{site.data.keyword.containerlong}} 叢集中設定網路配置。
{:shortdesc}

此頁面可協助您設定叢集的網路配置。不確定要選擇哪個設定？請參閱[規劃叢集網路](/docs/containers?topic=containers-cs_network_ov)。
{: tip}

## 設定具有公用和專用 VLAN 的叢集網路
{: #both_vlans}

設定叢集能夠存取[公用 VLAN 和專用 VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options)。
{: shortdesc}

此網路設定包含建立叢集期間的下列必要網路配置，以及建立叢集之後的選用網路配置。

1. 如果您在受防火牆保護的環境中建立叢集，請針對您計劃使用的 {{site.data.keyword.Bluemix_notm}} 服務，[容許公用和專用 IP 的出埠網路資料流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

2. 建立已連接至公用和專用 VLAN 的叢集。如果您建立多區域叢集，則可以為每個區域選擇 VLAN 配對。

3. 選擇 Kubernetes 主節點與工作者節點的通訊方式。
  * 如果已在 {{site.data.keyword.Bluemix_notm}} 帳戶中啟用 VRF，請啟用[僅限公用](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)、[公用和專用](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both)或[僅限專用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private)。
  * 如果您無法或不要啟用 VRF，請啟用[僅限公用服務端點](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public)及[啟用 VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning)。

4. 建立叢集之後，您可以配置下列網路選項：
  * 設定 [strongSwan VPN 連線服務](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_public)，以容許在叢集與內部部署網路或 {{site.data.keyword.icpfull_notm}} 之間進行通訊。
  * 建立 [Kubernetes Discovery Service](/docs/containers?topic=containers-cs_network_planning#in-cluster)，以容許在 Pod 之間進行叢集內通訊。
  * 建立[公用](/docs/containers?topic=containers-cs_network_planning#public_access)網路負載平衡器 (NLB)、Ingress 應用程式負載平衡器 (ALB) 或 NodePort 服務，以將應用程式公開至公用網路。
  * 建立[專用](/docs/containers?topic=containers-cs_network_planning#private_both_vlans)網路負載平衡器 (NLB)、Ingress 應用程式負載平衡器 (ALB) 或 NodePort 服務，以將應用程式公開至專用網路，並建立 Calico 網路原則來保護叢集不受公用存取。
  * 將網路工作負載隔離至[邊緣工作者節點](#both_vlans_private_edge)。
  * [在專用網路上隔離叢集](#isolate)。

<br />


## 設定具有僅限專用 VLAN 的叢集網路
{: #setup_private_vlan}

如果您具有特定安全需求，或需要建立自訂網路原則及遞送規則來提供專用網路安全，請設定叢集能夠存取[僅限專用 VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options)。
{: shortdesc}

此網路設定包含建立叢集期間的下列必要網路配置，以及建立叢集之後的選用網路配置。

1. 如果您在防火牆後面的環境中建立叢集，則針對您計劃使用的 {{site.data.keyword.Bluemix_notm}} 服務，[容許公用和專用 IP 的出埠網路資料流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

2. 建立已連接至[僅限專用 VLAN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options) 的叢集。如果您建立多區域叢集，則可以在每個區域中選擇專用 VLAN。

3. 選擇 Kubernetes 主節點與工作者節點的通訊方式。
  * 如果已在 {{site.data.keyword.Bluemix_notm}} 帳戶中啟用 VRF，則會[啟用專用服務端點](#set-up-private-se)。
  * 如果您無法或不要啟用 VRF，則 Kubernetes 主節點和工作者節點無法自動連接至主節點。您必須使用[閘道應用裝置](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private)來配置叢集。

4. 建立叢集之後，您可以配置下列網路選項：
  * [設定 VPN 閘道](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private)，以容許在叢集與內部部署網路或 {{site.data.keyword.icpfull_notm}} 之間進行通訊。如果您先前已設定 VRA (Vyatta) 或 FSA 以容許主節點與工作者節點之間進行通訊，則可以在 VRA 或 FSA 上配置 IPSec VPN 端點。
  * 建立 [Kubernetes Discovery Service](/docs/containers?topic=containers-cs_network_planning#in-cluster)，以容許在 Pod 之間進行叢集內通訊。
  * 建立[專用](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan)網路負載平衡器 (NLB)、Ingress 應用程式負載平衡器 (ALB) 或 NodePort 服務，以在專用網路上公開應用程式。
  * 將網路工作負載隔離至[邊緣工作者節點](#both_vlans_private_edge)。
  * [在專用網路上隔離叢集](#isolate)。

<br />


## 變更工作者節點 VLAN 連線
{: #change-vlans}

建立叢集時，您可以選擇要將工作者節點連接至專用和公用 VLAN，還是要連接至僅限專用 VLAN。工作者節點是儲存網路 meta 資料的工作者節點儲存區一部分，而網路 meta 資料包括用來佈建儲存區中未來工作者節點的 VLAN。建議您稍後變更叢集的 VLAN 連線功能設定，如下所示。
{: shortdesc}

* 區域中的工作者節點儲存區 VLAN 已耗盡容量，而且您需要針對要使用的叢集工作者節點佈建新的 VLAN。
* 您叢集的工作者節點同時位於公用和專用 VLAN，但您要變更為[僅限專用叢集](#setup_private_vlan)。
* 您具有僅限專用叢集，但想要一些工作者節點（例如公用 VLAN 上[邊緣節點](/docs/containers?topic=containers-edge#edge)的工作者節點儲存區），以在網際網路上公開應用程式。

嘗試改為變更服務端點以進行主節點與工作者節點的通訊嗎？請參閱[公用](#set-up-public-se)和[專用](#set-up-private-se)服務端點的設定主題。
{: tip}

開始之前：
* [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義。](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
* 如果工作者節點是獨立式（不屬於工作者節點儲存區的一部分），請[將它們更新為工作者節點儲存區](/docs/containers?topic=containers-update#standalone_to_workerpool)。

若要變更工作者節點儲存區用來佈建工作者節點的 VLAN，請執行下列動作：

1. 列出叢集中工作者節點儲存區的名稱。
  ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
  {: pre}

2. 判定其中一個工作者節點儲存區的區域。在輸出中，尋找**區域**欄位。
  ```
  ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

3. 針對您在前一個步驟中找到的每個區域，取得彼此相容的可用公用和專用 VLAN。

  1. 檢查輸出中**類型**下所列出的可用公用和專用 VLAN。
    ```
   ibmcloud ks vlans --zone <zone>
   ```
     {: pre}

  2. 確認區域中的公用和專用 VLAN 是相容的。為了能夠相容，**路由器**必須具有相同的 Pod ID。在此範例輸出中，**路由器** Pod ID 相符：`01a` 和 `01a`。如果有一個 Pod ID 是 `01a`，而另一個是 `02a`，則您無法對工作者節點儲存區設定這些公用及專用 VLAN ID。
    ```
    ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
    ```
     {: screen}

  3. 如果您需要訂購區域的新公用或專用 VLAN，則可以在 [{{site.data.keyword.Bluemix_notm}} 主控台](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans)中訂購，或使用下列指令。請記住，VLAN 必須與前一個步驟中的相符**路由器** Pod ID 相容。如果您建立一對新的公用和專用 VLAN，則它們必須彼此相容。
    ```
    ibmcloud sl vlan create -t [public|private] -d <zone> -r <compatible_router>
    ```
     {: pre}

  4. 記下相容 VLAN 的 ID。

4. 針對每個區域，使用新的 VLAN 網路 meta 資料來設定工作者節點儲存區。您可以建立新的工作者節點儲存區，或修改現有的工作者節點儲存區。

  * **建立新的工作者節點儲存區**：請參閱[建立新工作者節點儲存區來新增工作者節點](/docs/containers?topic=containers-clusters#add_pool).

  * **修改現有的工作者節點儲存區**：針對每個區域，設定工作者節點儲存區的網路 meta 資料以使用 VLAN。已在儲存區中建立的工作者節點會繼續使用前一個 VLAN，但儲存區中的新工作者節點會使用您設定的新 VLAN meta 資料。

    * 同時新增公用和專用 VLAN 的範例，例如，如果您從僅限專用變更為專用及公用：
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

    * 僅新增專用 VLAN 的範例，例如，如果您在具有[已啟用 VRF 且使用服務端點的帳戶](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)時從公用和專用 VLAN 變更為僅限專用：
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

5. 重新調整工作者節點儲存區大小，以將工作者節點新增至該儲存區。
   ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
   {: pre}

   如果您要移除使用前一個網路 meta 資料的工作者節點，請將每個區域的工作者節點數目變更為每個區域的先前工作者節點數量的兩倍。稍後，您可以在這些步驟中隔離、排除及移除先前的工作者節點。
  {: tip}

6. 驗證使用輸出中的適當**公用 IP** 和**專用 IP** 來建立新的工作者節點。例如，如果您將工作者節點儲存區從公用和專用 VLAN 變更為僅限專用，則新的工作者節點只有專用 IP。如果您將工作者節點儲存區從僅限專用變更為公用和專用 VLAN，則新的工作者節點同時具有公用和專用 IP。
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

7. 選用項目：從工作者節點儲存區中移除具有先前網路 meta 資料的工作者節點。
  1. 在前一個步驟的輸出中，記下您要從工作者節點儲存區中移除之工作者節點的 **ID** 和**專用 IP**。
  2. 在一個稱為隔離的處理程序中，將工作者節點標示為無法排程。當您隔離工作者節點時，會使它無法用於未來 Pod 排程。
    ```
    kubectl cordon <worker_private_ip>
    ```
     {: pre}
  3. 驗證已停用工作者節點的 Pod 排程。
    ```
    kubectl get nodes
    ```
     {: pre}
     如果狀態顯示 **`SchedulingDisabled`**，表示工作者節點已停用 Pod 排程。
  4. 強制從工作者節點移除 Pod，並將其重新排程至叢集裡的其餘工作者節點。
    ```
    kubectl drain <worker_private_ip>
    ```
     {: pre}
      此處理程序可能需要幾分鐘的時間。
  5. 移除工作者節點。使用您先前擷取的工作者節點 ID。
   ```
   ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
   ```
     {: pre}
  6. 驗證已移除工作者節點。
    ```
        ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
        ```
     {: pre}

8. 選用項目：您可以針對叢集中的每個工作者節點儲存區重複步驟 2 - 7。完成這些步驟之後，就會使用新的 VLAN 來設定叢集中的所有工作者節點。

<br />


## 設定專用服務端點
{: #set-up-private-se}

在執行 Kubernetes 1.11 版或更新版本的叢集中，啟用或停用叢集的專用服務端點。
{: shortdesc}

專用服務端點讓您的 Kubernetes 主節點可供專用存取。工作者節點和授權叢集使用者可以透過專用網路與 Kubernetes 主節點通訊。若要判斷是否可以啟用專用服務端點，請參閱[規劃主節點與工作者節點的通訊](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)。請注意，專用服務端點在啟用之後，就無法予以停用。

**要在建立叢集期間啟用的步驟**</br>
1. 在您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶中啟用 [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)。
2. [啟用 {{site.data.keyword.Bluemix_notm}} 帳戶以使用服務端點](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)。
3. 如果您在受防火牆保護的環境中建立叢集，請針對基礎架構資源以及您計劃使用的 {{site.data.keyword.Bluemix_notm}} 服務，[容許公用和專用 IP 的出埠網路資料流量](/docs/containers?topic=containers-firewall#firewall_outbound)。
4. 建立叢集：
  * [使用 CLI 建立叢集](/docs/containers?topic=containers-clusters#clusters_cli)，並且使用 `--private-service-endpoint` 旗標。如果您也要啟用公用服務端點，請同時使用 `--public-service-endpoint` 旗標。
  * [使用使用者介面建立叢集](/docs/containers?topic=containers-clusters#clusters_ui_standard)，並且選取**僅限專用端點**。如果您也要啟用公用服務端點，請選取**專用與公用端點**。
5. 如果您只針對受防火牆保護的環境中的叢集啟用專用服務端點，請執行下列動作：
  1. 驗證您位於 {{site.data.keyword.Bluemix_notm}} 專用網路，或透過 VPN 連線連接至專用網路。
  2. [容許授權叢集使用者執行 `kubectl` 指令](/docs/containers?topic=containers-firewall#firewall_kubectl)，以透過專用服務端點來存取主節點。叢集使用者必須位於 {{site.data.keyword.Bluemix_notm}} 專用網路，或透過 VPN 連線連接至專用網路，才能執行 `kubectl` 指令。
  3. 如果網路存取受到公司防火牆保護，則必須[在防火牆中容許存取 `ibmcloud` API 和 `ibmcloud ks` API 的公用端點](/docs/containers?topic=containers-firewall#firewall_bx)。雖然主節點的所有通訊都會經過專用網路，但 `ibmcloud` 和 `ibmcloud ks` 指令必須經過公用 API 端點。

  </br>

**要在叢集建立之後啟用的步驟**</br>
1. 在您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶中啟用 [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)。
2. [啟用 {{site.data.keyword.Bluemix_notm}} 帳戶以使用服務端點](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)。
3. 啟用專用服務端點。
   ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
   {: pre}
4. 重新整理 Kubernetes 主節點 API 伺服器，以使用專用服務端點。您可以遵循 CLI 中的提示，或手動執行下列指令。
   ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
   {: pre}

5. [建立 configmap](/docs/containers?topic=containers-update#worker-up-configmap)，以控制叢集中可能在某個時間無法使用的工作者節點數目上限。更新工作者節點時，ConfigMap 會協助避免應用程式的關閉，因為會依序將應用程式重新排定至可用的工作者節點。
6. 更新叢集中的所有工作者節點，以反映專用服務端點配置。

   <p class="important">透過發出 update 指令，會重新載入工作者節點，以反映服務端點配置。如果沒有工作者節點更新項目可供使用，則必須[手動重新載入工作者節點](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)。如果您重新載入，則務必隔離、排除及管理訂單，以控制在某個時間無法使用的工作者節點數目上限。</p>
   ```
ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
   {: pre}

8. 如果叢集位於受防火牆保護的環境，請執行下列動作：
  * [容許授權叢集使用者執行 `kubectl` 指令，以透過專用服務端點來存取主節點。](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * 針對基礎架構資源以及您計劃使用的 {{site.data.keyword.Bluemix_notm}} 服務，[容許專用 IP 的出埠網路資料流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

9. 選用項目：若只要使用專用服務端點，請停用公用服務端點。
   ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
   {: pre}
  </br>

**停用的步驟**</br>
無法停用專用服務端點。

## 設定公用服務端點
{: #set-up-public-se}

啟用或停用叢集的公用服務端點。
{: shortdesc}

公用服務端點讓您的 Kubernetes 主節點可供公然存取。工作者節點和授權叢集使用者可以透過公用網路與 Kubernetes 主節點安全地通訊。若要判斷是否可以啟用公用服務端點，請參閱[規劃工作者節點與 Kubernetes 主節點之間的通訊](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)。

**要在建立叢集期間啟用的步驟**</br>

1. 如果您在防火牆後面的環境中建立叢集，則針對您計劃使用的 {{site.data.keyword.Bluemix_notm}} 服務，[容許公用和專用 IP 的出埠網路資料流量](/docs/containers?topic=containers-firewall#firewall_outbound)。

2. 建立叢集：
  * [使用 CLI 建立叢集](/docs/containers?topic=containers-clusters#clusters_cli)，並且使用 `--public-service-endpoint` 旗標。如果您也要啟用專用服務端點，請同時使用 `--private-service-endpoint` 旗標。
  * [使用使用者介面建立叢集](/docs/containers?topic=containers-clusters#clusters_ui_standard)，並且選取**僅限公用端點**。如果您也要啟用專用服務端點，請選取**專用與公用端點**。

3. 如果您在受防火牆保護的環境中建立叢集，請[容許授權叢集使用者執行 `kubectl` 指令，以僅透過公用服務端點或透過公用和專用服務端點來存取主節點。](/docs/containers?topic=containers-firewall#firewall_kubectl)

  </br>

**在叢集建立之後啟用的步驟**</br>
如果您先前已停用公用端點，則可以重新予以啟用。
1. 啟用公用服務端點。
   ```
  ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
   {: pre}
2. 重新整理 Kubernetes 主節點 API 伺服器，以使用公用服務端點。您可以遵循 CLI 中的提示，或手動執行下列指令。
   ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
   {: pre}

   </br>

**停用的步驟**</br>
若要停用公用服務端點，您必須先啟用專用服務端點，讓工作者節點可以與 Kubernetes 主節點進行通訊。
1. 啟用專用服務端點。
   ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
   {: pre}
2. 遵循 CLI 提示，或手動執行下列指令，以重新整理 Kubernetes 主節點 API 伺服器以使用專用服務端點。
   ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
   {: pre}
3. [建立 configmap](/docs/containers?topic=containers-update#worker-up-configmap)，以控制叢集中可能在某個時間無法使用的工作者節點數目上限。更新工作者節點時，ConfigMap 會協助避免應用程式的關閉，因為會依序將應用程式重新排定至可用的工作者節點。

4. 更新叢集中的所有工作者節點，以反映專用服務端點配置。

   <p class="important">透過發出 update 指令，會重新載入工作者節點，以反映服務端點配置。如果沒有工作者節點更新項目可供使用，則必須[手動重新載入工作者節點](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)。如果您重新載入，則務必隔離、排除及管理訂單，以控制在某個時間無法使用的工作者節點數目上限。</p>
   ```
ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
  {: pre}
5. 停用公用服務端點。
   ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
   {: pre}

## 從公用服務端點切換至專用服務端點
{: #migrate-to-private-se}

在執行 Kubernetes 1.11 版或更新版本的叢集中，啟用工作者節點透過專用網路以與主節點通訊，而非啟用專用服務端點以透過公用網路與主節點通訊。
{: shortdesc}

依預設，所有連接至公用和專用 VLAN 的叢集都會使用公用服務端點。工作者節點和授權叢集使用者可以透過公用網路與 Kubernetes 主節點安全地通訊。若要啟用工作者節點透過專用網路來與 Kubernetes 主節點通訊，而非透過公用網路，則可以啟用專用服務端點。然後，您可以選擇性地停用公用服務端點。
* 如果您啟用專用服務端點，並一併保持公用服務端點的啟用狀態，則工作者節點一律會透過專用網路與主節點進行通訊，但使用者可以透過公用或專用網路與主節點進行通訊。
* 如果您啟用專用服務端點，但停用公用服務端點，則工作者節點和使用者必須透過專用網路與主節點進行通訊。

請注意，專用服務端點在啟用之後，就無法予以停用。

1. 在您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶中啟用 [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)。
2. [啟用 {{site.data.keyword.Bluemix_notm}} 帳戶以使用服務端點](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)。
3. 啟用專用服務端點。
   ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
   {: pre}
4. 遵循 CLI 提示，或手動執行下列指令，以重新整理 Kubernetes 主節點 API 伺服器以使用專用服務端點。
   ```
        ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
        ```
   {: pre}
5. [建立 configmap](/docs/containers?topic=containers-update#worker-up-configmap)，以控制叢集中可能在某個時間無法使用的工作者節點數目上限。更新工作者節點時，ConfigMap 會協助避免應用程式的關閉，因為會依序將應用程式重新排定至可用的工作者節點。

6.  更新叢集中的所有工作者節點，以反映專用服務端點配置。

    <p class="important">透過發出 update 指令，會重新載入工作者節點，以反映服務端點配置。如果沒有工作者節點更新項目可供使用，則必須[手動重新載入工作者節點](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference)。如果您重新載入，則務必隔離、排除及管理訂單，以控制在某個時間無法使用的工作者節點數目上限。</p>
    ```
    ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
    {: pre}

7. 選用項目：停用公用服務端點。
   ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
   {: pre}

<br />


## 選用項目：將網路工作負載隔離至邊緣工作者節點
{: #both_vlans_private_edge}

邊緣工作者節點可以藉由容許較少的工作者節點可在外部進行存取，以及隔離網路工作負載，來增進叢集的安全。若要確定只將網路負載平衡器 (NLB) 及 Ingress 應用程式負載平衡器 (ALB) Pod 部署至指定的工作者節點，請[將工作者節點標示為邊緣節點](/docs/containers?topic=containers-edge#edge_nodes)。若也要防止在邊緣節點上執行其他工作負載，請[污染邊緣節點](/docs/containers?topic=containers-edge#edge_workloads)。
{: shortdesc}

如果叢集連接至公用 VLAN，但您想要封鎖邊緣工作者節點上公用 NodePort 的資料流量，則也可以使用 [Calico preDNAT 網路原則](/docs/containers?topic=containers-network_policies#block_ingress)。封鎖節點埠可確保邊緣工作者節點是處理送入資料流量的唯一工作者節點。

## 選用項目：在專用網路上隔離叢集
{: #isolate}

如果您有多區域叢集、單一區域叢集的多個 VLAN，或相同 VLAN 上的多個子網路，則必須[啟用 VLAN Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) 或 [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)，讓工作者節點可以在專用網路上彼此通訊。不過，啟用 VLAN Spanning 或 VRF 時，連接至相同 IBM Cloud 帳戶中任何專用 VLAN 的任何系統都可以存取工作者節點。您可以使用 [Calico 網路原則](/docs/containers?topic=containers-network_policies#isolate_workers)，將多區域叢集與專用網路上的其他系統隔離。這些原則也容許您在專用防火牆中開啟的 IP 範圍和埠進行 ingress 和 egress。
{: shortdesc}
