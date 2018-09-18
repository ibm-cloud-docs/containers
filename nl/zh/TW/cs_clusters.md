---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 設定叢集
{: #clusters}

使用 {{site.data.keyword.containerlong}} 來設計 Kubernetes 叢集設定，以達到最大容器可用性及叢集容量。仍要開始使用嗎？請試用[建立 Kubernetes 叢集指導教學](cs_tutorials.html#cs_cluster_tutorial)。
　{:shortdesc}

## 在 {{site.data.keyword.containershort_notm}} 中建立多區域叢集
{: #multizone}

使用 {{site.data.keyword.containerlong}}，您可以建立多區域叢集。若使用工作者節點儲存區將應用程式分佈到多個工作者節點及區域，使用者遇到應用程式關閉的可能性就會越低。內建功能（例如負載平衡及隔離）可提高對於潛在主機、網路或應用程式區域失敗的備援。如果某個區域中的資源降低，則叢集工作負載仍然可以在其他區域中運作。
{: shortdesc}

### 等等，這裡討論的區域及儲存區是指什麼？有哪些變更？
{: #mz_changed}

**區域**（先前稱為「位置」）是可在其中建立 IBM Cloud 資源的資料中心。

叢集現在有一個稱為**工作者節點儲存區**的特性，其為具有相同特性（例如機型、CPU 及記憶體）的工作者節點集合。使用新的 `ibmcloud ks worker-pool` 命令來對叢集進行變更，例如新增區域、新增工作者節點，或更新工作者節點。

支援獨立式工作者節點的前一個叢集設定，但已遭淘汰。請務必[將工作者節點儲存區新增至叢集](cs_clusters.html#add_pool)，然後[移轉成使用工作者節點儲存區](cs_cluster_update.html#standalone_to_workerpool)來組織工作者節點，而非獨立式工作者節點。

### 我在開始之前需要知道什麼？
{: #general_reqs}

在更進一步之前，您需要注意一些管理項目，以確保多區域叢集已準備好用於工作負載。

<dl>
<dt>需要 VLAN</dt>
  <dd><p>當您將區域新增至工作者節點儲存區時，必須定義工作者節點所連接的專用及公用 VLAN。</p><ul><li>若要檢查您可以使用的區域中是否具有現有 VLAN，請執行 `ibmcloud ks vlans <zone>`。請記下 VLAN ID，並在將區域新增至工作者節點儲存區時使用這些 ID。</li>
  <li>如果該區域中沒有 VLAN，則會自動為您建立專用及公用 VLAN。您不需要指定專用及公用 VLAN。</li></ul>
  </dd>
<dt>啟用 VLAN Spanning 或 VRF</dt>
  <dd><p>您的工作者節點必須在各區域的專用網路上彼此通訊。您有兩個選項：</p>
  <ol><li>在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中[啟用 VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)。若要啟用 VLAN Spanning，您必須具有<strong>網路 > 管理網路 VLAN Spanning</strong> [基礎架構許可權](/docs/iam/infrastructureaccess.html#infrapermission)，或者您可以要求帳戶擁有者啓用它。</li>
  <li>或者，使用啟用「虛擬路由器功能 (VRF)」功能的 IBM Cloud 基礎架構 (SoftLayer) 帳戶。若要取得 VRF 帳戶，請聯絡 IBM Cloud 基礎架構 (SoftLayer) 支援。</li></ol></dd>
<dt>準備現有持續性磁區</dt>
  <dd><p>持續性磁區只能在實際儲存裝置所在的區域中使用。若要防止多區域叢集裡發生非預期的應用程式錯誤，您必須將地區及區域標籤套用至現有持續性磁區。這些標籤可協助 kube-scheduler 判斷在何處排定使用持續性磁區的應用程式。執行下列命令，並將 <code>&lt;mycluster&gt;</code> 取代為您的叢集名稱：</p>
  <pre class="pre"><code>bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster></code></pre></dd>
<dt>只有單一區域叢集可用於 {{site.data.keyword.Bluemix_dedicated_notm}} 實例。</dt>
    <dd>使用 {{site.data.keyword.Bluemix_dedicated_notm}}，您只能建立[單一區域叢集](cs_clusters.html#single_zone)。在設定 {{site.data.keyword.Bluemix_dedicated_notm}} 環境時，已預先定義可用區域。依預設，單一區域叢集已設定名為 `default` 的工作者節點儲存區。工作者節點儲存區會將具有您在建立叢集期間所定義之相同配置（例如機型）的工作者節點分組在一起。您可以藉由[調整現有工作者節點儲存區大小](cs_clusters.html#resize_pool)或[新增工作者節點儲存區](cs_clusters.html#add_pool)，來將更多工作者節點新增至叢集裡。當您新增工作者節點儲存區時，必須將可用區域新增至工作者節點儲存區，讓工作者節點可以部署至該區域。不過，您無法將其他區域新增至工作者節點儲存區。</dd>
</dl>

### 我已準備好建立多區域叢集。如何才能開始使用？
{: #mz_gs}

按一下**建立叢集**，以在 [{{site.data.keyword.containershort_notm}} 主控台](https://console.bluemix.net/containers-kubernetes/clusters)中立即開始。

您可以在其中一個[多區域城市](cs_regions.html#zones)中建立叢集：
* 美國南部地區的達拉斯：dal10、dal12、dal13
* 美國東部地區的華盛頓特區：wdc04、wdc06、wdc07
* 歐盟中部地區的法蘭克福：fra02、fra04、fra05
* 英國南部地區的倫敦：lon02、lon04、lon06

**將區域新增至現有叢集**：

如果多區域城市中具有叢集，您可以將工作者節點儲存區新增至叢集，然後使用 GUI 或 CLI 將區域新增至該工作者節點儲存區。如需完整步驟清單，請參閱[從獨立式工作者節點更新至工作者節點儲存區](cs_cluster_update.html#standalone_to_workerpool)。

### 接下來，目前管理叢集的方式有哪些變化？
{: #mz_new_ways}

透過引進工作者節點儲存區，您可以使用一組新的 API 及指令來管理叢集。您可以在 [CLI 文件頁面](cs_cli_reference.html#cs_cli_reference)中看到這些新指令，也可以透過執行 `ibmcloud ks help` 在終端中檢視這些新指令。

下表比較若干一般叢集管理動作的新舊方法。
<table summary="此表格顯示執行多區域指令之新方法的說明。列應該從左到右閱讀，第一欄為說明、第二欄為舊的方法，而第三欄為新的多區域方法。">
<caption>多區域工作者節點儲存區指令的新方法。</caption>
  <thead>
  <th>說明</th>
  <th>舊的獨立式工作者節點</th>
  <th>新的多區域工作者節點儲存區</th>
  </thead>
  <tbody>
    <tr>
    <td>將工作者節點新增至叢集。</td>
    <td><strong>已淘汰</strong>：<code>ibmcloud ks worker-add</code>，用來新增獨立式工作者節點。</td>
    <td><ul><li>若要新增與現有儲存區不同的機型，請建立新的工作者節點儲存區：<code>ibmcloud ks worker-pool-create</code> [指令](cs_cli_reference.html#cs_worker_pool_create)。</li>
    <li>若要將工作者節點新增至現有儲存區，請調整儲存區中每個區域的節點數：<code>ibmcloud ks worker-pool-resize</code> [指令](cs_cli_reference.html#cs_worker_pool_resize)。</li></ul></td>
    </tr>
    <tr>
    <td>從叢集裡移除工作者節點。</td>
    <td><code>ibmcloud ks worker-rm</code>，仍可用來刪除叢集裡麻煩的工作者節點。</td>
    <td><ul><li>如果您的工作者節點儲存區不平衡（例如，在移除工作者節點之後），請重新予以平衡：<code>ibmcloud ks worker-pool-rebalance</code> [指令](cs_cli_reference.html#cs_rebalance)。</li>
    <li>若要減少儲存區中的工作者節點數目，請調整每個區域的數目（最小值 1）：<code>ibmcloud ks worker-pool-resize</code> [指令](cs_cli_reference.html#cs_worker_pool_resize)。</li></ul></td>
    </tr>
    <tr>
    <td>針對工作者節點，使用新的 VLAN。</td>
    <td><strong>已淘汰</strong>：新增可使用新專用或公用 VLAN 的新工作者節點：<code>ibmcloud ks worker-add</code>。</td>
    <td>將工作者節點儲存區設定成使用與先前所使用不同的公用或專用 VLAN：<code>ibmcloud ks zone-network-set</code> [指令](cs_cli_reference.html#cs_zone_network_set)。</td>
    </tr>
  </tbody>
  </table>

### 如何才能進一步瞭解多區域叢集？
{: #learn_more}

已更新多區域的整份文件。具體而言，您可能會對下列各主題感興趣，而這些主題大幅變更多區域叢集的簡介：
* [設定高可用性叢集](#ha_clusters)
* [規劃高可用性應用程式部署](cs_app.html#highly_available_apps)
* [針對多區域叢集使用 LoadBalancer 公開應用程式](cs_loadbalancer.html#multi_zone_config)
* [使用 Ingress 公開應用程式](cs_ingress.html#ingress)
* 對於高可用性持續性儲存空間，請使用雲端服務（例如 [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) 或 [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage)）。

## 設定高可用性叢集
{: #ha_clusters}
使用 {{site.data.keyword.containerlong}} 設計標準叢集的應用程式最大可用性及容量。

若將應用程式分佈到多個工作者節點、區域及叢集，使用者遇到應用程式關閉的可能性就越低。內建功能（例如負載平衡及隔離）可提高對於潛在主機、網路或應用程式失敗的備援。


檢閱這些潛在的叢集設定，它們依遞增的可用性程度進行排序。

![叢集的高可用性](images/cs_cluster_ha_roadmap_multizone.png)

1. [單一區域叢集](#single_zone)，其在工作者節點儲存區中有多個工作者節點。
2. [多區域叢集](#multi_zone)，可將工作者節點分散到某個地區內的各區域。
3. [多個叢集](#multiple_clusters)，其已設定為跨各區域或地區，且已透過廣域負載平衡器進行連接。

### 單一區域叢集
{: #single_zone}

若要改善應用程式的可用性，以及容許無法在叢集裡使用某個工作者節點時失效接手，請將其他工作者節點新增至單一區域叢集。
{: shortdesc}

<img src="images/cs_cluster_singlezone.png" alt="單一區域中叢集的高可用性" width="230" style="width:230px; border-style: none"/>

依預設，單一區域叢集已設定名為 `default` 的工作者節點儲存區。工作者節點儲存區會將具有您在建立叢集期間所定義之相同配置（例如機型）的工作者節點分組在一起。您可以藉由[調整現有工作者節點儲存區大小](#resize_pool)或[新增工作者節點儲存區](#add_pool)，來將更多工作者節點新增至叢集裡。

當您新增更多工作者節點時，應用程式實例可以分佈到多個工作者節點。如果某個工作者節點關閉，則可用工作者節點上的應用程式實例會繼續執行。Kubernetes 會自動從無法使用的工作者節點重新排定 Pod，以確保應用程式的效能及容量。若要確定 Pod 平均分佈到工作者節點，請實作 [Pod 親緣性](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature)。

**可以將單一區域叢集轉換成多區域叢集嗎？**
有時可以。如果單一區域叢集位於[多區域都會城市](cs_regions.html#zones)中，您可以將單一區域叢集轉換成多區域叢集。若要轉換成多區域叢集，請[新增區域](#add_zone)至叢集的工作者節點儲存區。如果您有多個工作者節點儲存區，請將該區域新增至所有儲存區，讓工作者節點在叢集間保持平衡。

**必須使用多區域叢集嗎？**
不必。您可以建立所需數目的單一區域叢集。實際上，您可能偏好使用單一區域叢集來簡化管理，或者，如果您的叢集必須位於特定[單一區域城市](cs_regions.html#zones)中。

### 多區域叢集
{: #multi_zone}

若要保護叢集不受單一區域失敗影響，您可以將叢集分散到某個地區內的各區域。
{: shortdesc}

<img src="images/cs_cluster_multizone.png" alt="多區域叢集的高可用性" width="500" style="width:500px; border-style: none"/>

您可以將其他區域新增至叢集，以將工作者節點儲存區中的工作者節點抄寫到某個地區內的多個區域。多區域叢集的設計為將 Pod 平均排定到各工作者節點及區域，以確保可用性及失敗回復。如果工作者節點未平均分散到各區域，或其中一個區域中的容量不足，則 Kubernetes 排程器可能無法排定所有要求的 Pod。因此，除非有足夠的容量可用，否則 Pod 可能會進入**擱置中**狀況。如果您要變更預設行為，讓 Kubernetes 排程器以最佳效能分佈將 Pod 分佈到各區域，請使用 `preferredDuringSchedulingIgnoredDuringExecution` [Pod 親緣性原則](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature)。

**為什麼 3 個區域中需要有工作者節點？** </br>
將工作負載分佈到 3 個區域，可確保一個或兩個區域無法使用時的應用程式高可用性，但也讓您的叢集設定更具成本效益。但為什麼是這樣？請參考以下範例。

假設您需要具有 6 個核心的工作者節點來處理應用程式的工作負載。為了讓您的叢集更為可用，您具有下列選項：

- **在另一個區域中複製資源：**此選項可讓您具有 2 個工作者節點，而每一個區域中的每一個工作者節點都有 6 個核心，因此共有 12 個核心。</br>
- **將資源分佈到 3 個區域：**使用此選項，每個區域都會部署 3 個核心，因此總容量為 9 個核心。若要處理工作負載，必須同時啟動兩個區域。如果有一個區域無法使用，則其他兩個區域都可以處理工作負載。如果有兩個區域無法使用，則會啟動剩下的 3 個核心來處理工作負載。每個區域都部署 3 個核心，表示機器數目較少，因而可降低成本。</br>

**如何提高 Kubernetes 主節點的可用性？** </br>
多區域叢集已設定在相同都會區域中佈建為工作者節點的單一 Kubernetes 主節點。例如，如果工作者節點位於 `dal10`、`dal12` 或 `dal13` 中的其中一個或多個區域，則主節點位於達拉斯多區域都會城市中。

**如果 Kubernetes 主節點變成無法使用，會發生什麼情況？**</br>
Kubernetes 主節點無法使用時，您就無法存取或變更叢集。不過，您所部署的工作者節點、應用程式及資源不會遭到修改，並會繼續執行。若要保護叢集不發生 Kubernetes 主節點失敗，或在多區域叢集無法使用的地區中保護叢集，您可以[設定多個叢集，並使用廣域負載平衡器進行連接](#multiple_clusters)。

**如何讓使用者從公用網際網路存取我的應用程式？**</br>
您可以使用 Ingress 應用程式負載平衡器 (ALB) 或負載平衡器服務來公開應用程式。依預設，會在叢集的每一個區域中自動建立及啟用公用 ALB。同時會自動建立及啟用叢集的多區域負載平衡器 (MZLB)。MZLB 會對叢集之每一個區域中的 ALB 進行性能檢查，並根據這些性能檢查來持續更新 DNS 查閱結果。如需相關資訊，請參閱高可用性 [Ingress 服務](cs_ingress.html#planning)。

負載平衡器服務只會設定在某個區域中。您應用程式的送入要求會從該區域遞送至其他區域中的所有應用程式實例。如果此區域變成無法使用，則可能無法從網際網路存取您的應用程式。您可以在其他區域中設定其他負載平衡器服務來負責單一區域失敗。如需相關資訊，請參閱高可用性[負載平衡器服務](cs_loadbalancer.html#multi_zone_config)。

**我已建立多區域叢集。為什麼還是只有一個區域？如何將區域新增至我的叢集？**</br>
如果您[使用 CLI 建立多區域叢集](#clusters_cli)，會建立叢集，但必須將區域新增至工作者節點儲存區，才能完成該處理程序。若要跨越多個區域，您的叢集必須位在[多區域都會城市](cs_regions.html#zones)中。若要將區域新增至叢集，並將工作者節點分散到各區域，請參閱[將區域新增至叢集](#add_zone)。

### 多個使用廣域負載平衡器連接的叢集
{: #multiple_clusters}

若要保護應用程式不發生 Kubernetes 主節點失敗，以及在多區域叢集無法使用的地區中保護叢集，您可以在某個地區的不同區域中建立多個叢集，並使用廣域負載平衡器進行連接。
{: shortdesc}

<img src="images/cs_multiple_cluster_zones.png" alt="多個叢集的高可用性" width="700" style="width:700px; border-style: none"/>

若要平衡多個叢集間的工作負載，您必須設定廣域負載平衡器，並將應用程式負載平衡器 (ALB) 或負載平衡器服務的 IP 位址新增至網域。新增這些 IP 位址，即可在叢集之間遞送送入資料流量。若要讓廣域負載平衡器偵測是否有一個叢集無法使用，請考慮將以 Ping 為基礎的性能檢查新增至每個 IP 位址。當您設定此檢查時，DNS 提供者會定期對您新增至網域的 IP 位址執行連線測試。如果有一個 IP 位址變成無法使用，則不會再將資料流量傳送至此 IP 位址。不過，Kubernetes 不會自動從可用叢集之工作者節點的無法使用叢集裡重新啟動 Pod。如果您要 Kubernetes 自動重新啟動可用叢集裡的 Pod，請考慮設定[多區域叢集](#multi_zone)。

**為什麼 3 個區域中需要有 3 個叢集？** </br>
與[在多區域叢集裡使用 3 個區域](#multi_zone)類似，跨區域設定 3 個叢集，您可以提供應用程式的更多可用性。您也可以購買較少的機器來處理工作量，以降低成本。

**如果我要跨地區設定多個叢集，該怎麼辨？** </br>
您可以在一個地理位置（例如美國南部和美國東部）或跨地理位置（例如美國南部和歐盟中心）的不同地區中設定多個叢集。這兩個設定都為應用程式提供相同的可用性層次，但在共用資料及抄寫資料時也增加了複雜性。在大部分情況下，停留在相同地理位置就已足夠。但是，如果您的使用者位分佈在世界各地，則最好在使用者所在位置設定叢集，這樣您的使用者在將要求傳送給應用程式時就不需要長時間等待。

**若要設定多個叢集的廣域負載平衡器，請執行下列動作：**

1. 在多個區域或地區中[建立叢集](cs_clusters.html#clusters)。
2. 針對您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。作為 VLAN Spanning 的替代方案，如果您已在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中啟用「虛擬路由器功能 (VRF)」，則可以使用它。
3. 在每一個叢集中，使用[應用程式負載平衡器 (ALB)](cs_ingress.html#ingress_expose_public) 或[負載平衡器服務](cs_loadbalancer.html#config)來公開應用程式。
4. 針對每一個叢集，列出您 ALB 或負載平衡器服務的公用 IP 位址。
   - 若要列出叢集裡所有公用已啟用 ALB 的 IP 位址，請執行下列指令：
     ```
     ibmcloud ks albs --cluster <cluster_name_or_id>
     ```
     {: pre}

   - 若要列出負載平衡器服務的 IP 位址，請執行下列指令：
     ```
    kubectl describe service <myservice>
    ```
     {: pre}

     **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式 IP 位址。
4. 使用 {{site.data.keyword.Bluemix_notm}} Internet Services (CIS) 設定廣域負載平衡器，或設定您自己的廣域負載平衡器。
    * 若要使用 CIS 廣域負載平衡器，請執行下列動作：
        1. 遵循[開始使用 {{site.data.keyword.Bluemix_notm}} Internet Services (CIS)](/docs/infrastructure/cis/getting-started.html#getting-started-with-ibm-cloud-internet-services-cis-) 中的步驟 1 - 4，來設定服務。
            * 步驟 1 - 3 會引導您完成佈建服務實例、新增應用程式網域，以及配置名稱伺服器。
            * 步驟 4 會引導您完成建立 DNS 記錄。針對收集到的每一個 ALB 或負載平衡器 IP 位址，建立 DNS 記錄。這些 DNS 記錄會將應用程式網域對映至所有叢集 ALB 或負載平衡器，並確保以循環式週期將應用程式網域的要求轉遞至叢集。
        2. 針對 ALB 或負載平衡器，[新增性能檢查](/docs/infrastructure/cis/glb-setup.html#add-a-health-check)。您可以針對所有叢集裡的 ALB 或負載平衡器使用相同的性能檢查，或建立要用於特定叢集的特定性能檢查。
        3. 新增叢集的 ALB 或負載平衡器 IP，以針對每一個叢集[新增原始儲存區](/docs/infrastructure/cis/glb-setup.html#add-a-pool)。例如，如果您的 3 個叢集各有 2 個 ALB，則請建立 3 個各有 2 個 ALB IP 位址的原始儲存區。將性能檢查新增至您建立的每一個原始儲存區。
        4. [新增廣域負載平衡器](/docs/infrastructure/cis/glb-setup.html#set-up-and-configure-your-load-balancers)。
    * 若要使用您自己的廣域負載平衡器，請執行下列動作：
        1. 將所有公用已啟用 ALB 及負載平衡器服務的 IP 位址新增至網域，以配置網域將送入資料流量遞送至 ALB 或負載平衡器服務。
        2. 針對每一個 IP 位址，啟用以 Ping 為基礎的性能檢查，讓 DNS 提供者可以偵測到性能不佳的 IP 位址。如果偵測到性能不佳的 IP 位址，則不會再將資料流量遞送至此 IP 位址。

## 工作者節點配置規劃
{: #planning_worker_nodes}

Kubernetes 叢集包含可分組至工作者節點儲存區的工作者節點，並且由 Kubernetes 主節點集中進行監視及管理。叢集管理者可以決定如何設定工作者節點的叢集，以確保叢集使用者具有部署及執行叢集裡應用程式的所有資源。
{:shortdesc}

當您建立標準叢集時，會代表您在 IBM Cloud 基礎架構 (SoftLayer) 中訂購相同配置的工作者節點，並將它們新增至叢集裡的預設工作者節點儲存區。每個工作者節點都會獲指派建立叢集之後即不得變更的唯一工作者節點 ID 及網域名稱。

您可以選擇虛擬或實體（裸機）伺服器。視您選擇的硬體隔離層次而定，虛擬工作者節點可以設定為共用或專用節點。您也可以選擇想要工作者節點連接至公用 VLAN 及專用 VLAN，還是僅連接至專用 VLAN。每個工作者節點都會佈建特定機型，而此機型可決定部署至工作者節點的容器可用的 vCPU 數目、記憶體及磁碟空間。Kubernetes 會限制您在叢集裡可以有的工作者節點數目上限。如需相關資訊，請檢閱[工作者節點及 Pod 配額 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/setup/cluster-large/)。

### 工作者節點儲存區
{: #worker_pools}

每個叢集都已設定預設工作者節點儲存區，而預設工作者節點儲存區會將具有您在建立叢集期間所定義之相同配置（例如機型）的工作者節點分組在一起。如果您從使用者介面佈建叢集，則可以同時選取多個區域。從 CLI 建立的叢集一開始只會在一個區域中佈建一個工作者節點儲存區。佈建叢集之後，即可將更多區域新增至工作者節點儲存區，以將工作者節點平均地抄寫至各區域。例如，如果您將第二個區域新增至包含 3 個工作者節點的工作者節點儲存區，則會將這 3 個工作者節點佈建至第二個區域，讓您具備一個共有 6 個工作者節點儲存區的叢集。

若要在位於不同區域的工作者節點之間啟用專用網路的通訊，您必須啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)。若要將不同的機型特性新增至叢集，請[建立另一個工作者節點儲存區](cs_cli_reference.html#cs_worker_pool_create)。

### 工作者節點的硬體
{: #shared_dedicated_node}

當您在 {{site.data.keyword.Bluemix_notm}} 中建立標準叢集時，可以選擇將工作者節點佈建為實體機器（裸機），或佈建為在實體硬體上執行的虛擬機器。當您建立免費叢集時，工作者節點會自動佈建為 IBM Cloud 基礎架構 (SoftLayer) 帳戶中的虛擬共用節點。
{:shortdesc}

![標準叢集裡的工作者節點的硬體選項](images/cs_clusters_hardware.png)

請檢閱下列資訊，以決定您想要的工作者節點儲存區類型。計劃時，請考量[工作者節點最低臨界值](#resource_limit_node)，即總記憶體容量的 10%。

<dl>
<dt>為何要使用實體機器（裸機）？</dt>
<dd><p><strong>更多運算資源</strong>：您可以將工作者節點佈建為單一承租戶實體伺服器，也稱為裸機。裸機可讓您直接存取機器上的實體資源，例如記憶體或 CPU。此設定可免除虛擬機器 Hypervisor，該 Hypervisor 將實體資源配置給在主機上執行的虛擬機器。相反地，裸機的所有資源將由工作者節點專用，因此您不需要擔心「吵雜的鄰居」共用資源或降低效能。實體機型的本端儲存空間多於虛擬機型，有些實體機型具有 RAID 可用來備份本端資料。</p>
<p><strong>按月計費</strong>：裸機伺服器的成本高於虛擬伺服器，最適合需要更多資源及主機控制的高效能應用程式。裸機伺服器按月計費。如果您在月底之前取消裸機伺服器，則會向您收取該月整個月的費用。訂購及取消裸機伺服器是透過 IBM Cloud 基礎架構 (SoftLayer) 帳戶進行的手動程序。可能需要多個營業日才能完成。</p>
<p><strong>啟用授信運算的選項</strong>：啟用「授信運算」，以驗證工作者節點是否遭到竄改。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](cs_cli_reference.html#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。無需信任，即可建立新叢集。如需在節點啟動處理程序期間信任運作方式的相關資訊，請參閱[使用授信運算的 {{site.data.keyword.containershort_notm}}](cs_secure.html#trusted_compute)。「授信運算」適用於執行 Kubernets 1.9 版或更新版本，且具有特定裸機機型的叢集。當您執行 `ibmcloud ks machine-types <zone>` [指令](cs_cli_reference.html#cs_machine_types)時，可以檢閱 **Trustable** 欄位來查看哪些機器支援信任。例如，`mgXc` GPU 特性不支援「授信運算」。</p></dd>
<dt>為何要使用虛擬機器？</dt>
<dd><p>使用 VM，您可以取得更大的彈性、更快速的佈建時間，以及比裸機還要多的自動可擴充性功能，而且價格更加划算。您可以對大部分一般用途的使用案例使用 VM，例如測試與開發環境、暫置及 Prod 環境、微服務，以及商務應用程式。不過，會犧牲效能。對於 RAM、資料或 GPU 密集的工作負載，如果您需要高效能運算，請使用裸機。</p>
<p><strong>決定單一承租戶或多方承租戶</strong>：當您建立標準虛擬叢集時，必須選擇是要由多個 {{site.data.keyword.IBM_notm}} 客戶（多方承租戶）共用基礎硬體，還是只供您一人專用（單一承租戶）。</p>
<p>在多方承租戶設定中，會在所有部署至相同實體硬體的虛擬機器之間共用實體資源（例如 CPU 及記憶體）。為了確保每台虛擬機器都可以獨立執行，虛擬機器監視器（也稱為 Hypervisor）會將實體資源分段為隔離實體，並將它們當成專用資源配置至虛擬機器（Hypervisor 隔離）。</p>
<p>在單一承租戶設定中，所有實體資源都只供您專用。您可以將多個工作者節點部署為相同實體主機上的虛擬機器。與多方承租戶設定類似，Hypervisor 確保每個工作者節點都可以共用可用的實體資源。</p>
<p>因為基礎硬體的成本是由多個客戶分攤，所以共用節點成本通常會比專用節點成本低。不過，當您決定共用或專用節點時，可能會想要與法務部門討論應用程式環境所需的基礎架構隔離及法規遵循層次。</p>
<p><strong>虛擬 `u2c` 或 `b2c` 機器特性</strong>：這些機器使用本端磁碟而非儲存區域網路 (SAN) 來提供可靠性。可靠性優點包括將位元組序列化到本端磁碟時的更高傳輸量，以及減少檔案系統由於網路故障而造成的退化。這些機型包含 25GB 主要本端磁碟儲存空間以供 OS 檔案系統使用，以及包含 100GB 次要本端磁碟儲存空間以供容器運行環境及 kubelet 這類資料使用。</p>
<p><strong>如果我已淘汰 `u1c` 或 `b1c` 機型，怎麼辨？</strong>若要開始使用 `u2c` 及 `b2c` 機型，[請藉由新增工作者節點來更新機型](cs_cluster_update.html#machine_type)。</p></dd>
<dt>可以選擇哪些虛擬及實體機器特性？</dt>
<dd><p>許多！選取最適合您使用案例的機器類型。請記住，工作者節點儲存區是由特性相同的機器所組成。如果要在您的叢集裡混合各種機型，請對每一個特性建立個別的工作者節點儲存區。</p>
<p>機型因區域而異。若要查看您區域中可用的機型，請執行 `ibmcloud ks machine-types <zone_name>`。</p>
<p><table>
<caption>{{site.data.keyword.containershort_notm}} 中可用的實體（裸機）及虛擬機器類型。</caption>
<thead>
<th>名稱及使用案例</th>
<th>核心 / 記憶體</th>
<th>主要 / 次要磁碟</th>
<th>網路速度</th>
</thead>
<tbody>
<tr>
<td><strong>虛擬，u2c.2x4</strong>：針對快速測試、概念證明，以及其他輕型工作負載，使用這個大小最小的 VM。</td>
<td>2 / 4GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>虛擬，b2c.4x16</strong>：針對測試與開發，以及其他輕型工作負載，選取這個已平衡的 VM。</td>
<td>4 / 16GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>虛擬，b2c.16x64</strong>：針對中型工作負載，選取這個已平衡的 VM。</td></td>
<td>16 / 64GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>虛擬，b2c.32x128</strong>：針對中型或大型工作負載（例如一個資料庫及一個具有許多並行使用者的動態網站），選取這個已平衡的 VM。</td></td>
<td>32 / 128GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>虛擬，b2c.56x242</strong>：針對大型工作負載（例如一個資料庫及多個具有許多並行使用者的應用程式），選取這個已平衡的 VM。</td></td>
<td>56 / 242GB</td>
<td>25GB / 100GB</td>
<td>1000Mbps</td>
</tr>
<tr>
<td><strong>RAM 密集的裸機，mr1c.28x512</strong>：將工作者節點可用的 RAM 最大化。</td>
<td>28 / 512GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>GPU 裸機，mg1c.16x128</strong>：針對數學運算密集的工作負載（例如高效能運算、機器學習或 3D 應用程式）選擇這種類型。此特性有 1 張 Tesla K80 實體卡，而每張卡有 2 個圖形處理裝置 (GPU)，總計 2 個 GPU。</td>
<td>16 / 128GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>GPU 裸機，mg1c.28x256</strong>：針對數學運算密集的工作負載（例如高效能運算、機器學習或 3D 應用程式）選擇這種類型。此特性有 2 張 Tesla K80 實體卡，而每張卡有 2 個 GPU，總計 4 個 GPU。</td>
<td>28 / 256GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>資料密集的裸機，md1c.16x64.4x4tb</strong>：適用於大量的本端磁碟儲存空間，包括 RAID 來備份儲存在本端機器上的資料。用於分散式檔案系統、大型資料庫及海量資料分析工作負載之類的案例。</td>
<td>16 / 64GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>資料密集的裸機，md1c.28x512.4x4tb</strong>：適用於大量的本端磁碟儲存空間，包括 RAID 來備份儲存在本端機器上的資料。用於分散式檔案系統、大型資料庫及海量資料分析工作負載之類的案例。</td>
<td>28 / 512 GB</td>
<td>2x2TB RAID1 / 4x4TB SATA RAID10</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>平衡的裸機，mb1c.4x32</strong>：用於所需的運算資源比虛擬機器提供的還多的已平衡工作負載。</td>
<td>4 / 32GB</td>
<td>2TB SATA / 2TB SATA</td>
<td>10000Mbps</td>
</tr>
<tr>
<td><strong>平衡的裸機，mb1c.16x64</strong>：用於所需的運算資源比虛擬機器提供的還多的已平衡工作負載。</td>
<td>16 / 64GB</td>
<td>2TB SATA / 960GB SSD</td>
<td>10000Mbps</td>
</tr>
</tbody>
</table>
</p>
</dd>
</dl>


您可以使用[主控台使用者介面](#clusters_ui)或 [CLI](#clusters_cli) 來部署叢集。

### 工作者節點的 VLAN 連線
{: #worker_vlan_connection}

當您建立叢集時，工作者節點會自動從 IBM Cloud 基礎架構 (SoftLayer) 帳戶連接至 VLAN。
{:shortdesc}

VLAN 會配置一組工作者節點及 Pod，就像它們已連接至相同的實體佈線。
* 公用 VLAN 具有兩個可在其上自動佈建的子網路。主要公用子網路會判定在建立叢集期間指派給工作者節點的公用 IP 位址，而可攜式公用子網路會提供 Ingress 及負載平衡器網路服務的公用 IP 位址。
* 專用 VLAN 也有兩個可在其上自動佈建的子網路。主要專用子網路會判定在建立叢集期間指派給工作者節點的專用 IP 位址，而可攜式專用子網路會提供 Ingress 及負載平衡器網路服務的專用 IP 位址。

若為免費叢集，叢集的工作者節點會在建立叢集期間連接至 IBM 擁有的公用 VLAN 及專用 VLAN。

若為標準叢集，第一次在區域中建立叢集時，會自動為您佈建公用 VLAN 及專用 VLAN。針對您在該區域建立的每個後續叢集，您可以選擇要使用的 VLAN。您可以將工作者節點同時連接至公用 VLAN 及專用 VLAN，或僅連接至專用 VLAN。如果您只想要將工作者節點連接至專用 VLAN，則可以使用現有專用 VLAN 的 ID，或[建立專用 VLAN](/docs/cli/reference/softlayer/index.html#sl_vlan_create)，並在建立叢集期間使用該 ID。如果將工作者節點設定為僅具有專用 VLAN，則您必須配置替代方案以進行網路連線，例如 [Virtual Router Appliance](cs_vpn.html#vyatta)，讓工作者節點可以與主節點通訊。

**附註**：如果一個叢集具有多個 VLAN，或相同的 VLAN 上具有多個子網路，您必須開啟 VLAN Spanning，讓工作者節點可以在專用網路上彼此通訊。如需指示，請參閱[啟用或停用 VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)。

### 工作者節點記憶體限制
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} 會在每一個工作者節點上設定記憶體限制。當工作者節點上執行的 Pod 超出此記憶體限制時，就會移除這些 Pod。在 Kubernetes 中，此限制稱為[強制收回臨界值 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds)。
{:shortdesc}

如果經常移除 Pod，請將更多的工作者節點新增至叢集，或在 Pod 上設定[資源限制 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container)。

**每一部機器都有最低臨界值，等於其總記憶體容量的 10%**。如果工作者節點上可用的記憶體少於容許的最低臨界值，Kubernetes 會立即移除 Pod。如果有工作者節點可供使用，則 Pod 會重新排定至另一個工作者節點。例如，如果您有一台 `b2c.4x16` 虛擬機器，它的總記憶體容量是 16GB。如果可用記憶體少於 1600MB (10%)，則無法在這個工作者節點上排定新 Pod，而會在另一個工作者節點上排定。如果沒有其他工作者節點可用，則新 Pod 會保持未排定狀態。

若要檢閱工作者節點上使用的記憶體數量，請執行 [kubectltop node ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/overview/#top)。

### 工作者節點的自動回復
`Docker`、`kubelet`、`kube-proxy` 及 `calico` 是重要元件，它們必須發揮作用，才能有一個健全的 Kubernetes 工作者節點。經過一段時間後，這些元件可能會中斷，而讓工作者節點處於無功能的狀況。無功能工作者節點會降低叢集的總容量，並可能導致應用程式關閉。

您可以[為工作者節點配置性能檢查，並啟用自動回復](cs_health.html#autorecovery)。如果「自動回復」根據配置的檢查，偵測到性能不佳的工作者節點，則「自動回復」會觸發更正動作，如在工作者節點上重新載入 OS。如需自動回復運作方式的相關資訊，請參閱[自動回復部落格![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。

<br />




## 使用 GUI 建立叢集
{: #clusters_ui}

Kubernetes 叢集的用途是要定義一組資源、節點、網路及儲存裝置，讓應用程式保持高可用性。您必須先建立叢集並設定該叢集裡工作者節點的定義，才能部署應用程式。
{:shortdesc}

**開始之前**

您必須具有「試用」、「隨收隨付制」或「訂閱」的 [{{site.data.keyword.Bluemix_notm}} 帳戶](https://console.bluemix.net/registration/)。

若要完全自訂您的叢集，並選擇硬體隔離、區域、API 版本等等，請建立標準叢集。
{: tip}

**建立免費叢集**

您可以使用 1 個免費叢集來熟悉 {{site.data.keyword.containershort_notm}} 的運作方式。使用免費叢集，您可以先學習術語、完成指導教學以及瞭解您的方向，再跳至正式作業層級標準叢集。不要擔心，即使您有「隨收隨付制」或「訂閱」帳戶，還是可以取得免費叢集。**附註**：免費叢集的壽命為 21天。在該時間之後，叢集會到期，並刪除叢集和其資料。{{site.data.keyword.Bluemix_notm}} 不會備份刪除的資料，因此無法予以還原。請務必備份所有重要資料。

1. 在型錄中，選取 **{{site.data.keyword.containershort_notm}}**。

2. 選取要部署叢集的區域。

3. 選取**免費**叢集方案。

4. 提供叢集名稱。此名稱必須以字母開頭，可以包含字母、數字及連字號 (-)，且長度不得超過 35 個字元。叢集名稱和叢集部署所在的地區會形成 Ingress 子網域的完整網域名稱。為了確保 Ingress 子網域在地區內是唯一的，叢集名稱可能會被截斷，並在 Ingress 網域名稱內附加一個隨機值。


5. 按一下**建立叢集**。依預設，會建立具有一個工作者節點的工作者節點儲存區。您可以在**工作者節點**標籤中查看工作者節點部署的進度。部署完成時，您可以在**概觀**標籤中看到叢集已就緒。

    變更在建立期間指派的唯一 ID 或網域名稱會封鎖 Kubernetes 主節點，使其無法管理叢集。
    {: tip}

</br>

**建立標準叢集**

1. 在型錄中，選取 **{{site.data.keyword.containershort_notm}}**。

2. 選取要部署叢集的區域。如需最佳效能，請選取實際上與您最接近的地區。請謹記，如果您選取的區域不在您的國家/地區境內，您可能需要合法授權，才能儲存資料。

3. 選取**標準**叢集方案。使用標準叢集，您可以存取諸如多個工作者節點的特性，以達到高可用性環境。

4. 輸入區域詳細資料。

    1. 選取**單一區域**或**多區域**可用性。在多區域叢集中，主節點部署在具有多區域功能的區域中，而且您的叢集資源會分散到多個區域。您的選擇可能會受到地區的限制。

    2. 選取您要在其中管理叢集的特定區域。您必須至少選取 1 個區域，但可以選取所需數目的區域。如果您選取超過 1 個區域，則工作者節點會分散到您選擇的各區域，讓您具有更高的可用性。如果您只選取 1 個區域，則可以在建立叢集之後[將區域新增至叢集](#add_zone)。

    3. 從 IBM Cloud 基礎架構 (SoftLayer) 帳戶中，選取一個公用 VLAN（選用）及一個專用 VLAN（必要）。工作者節點使用專用 VLAN 來彼此通訊。若要與 Kubernetes 主節點通訊，您必須配置工作者節點的公用連線功能。如果您在此區域中沒有公用或專用 VLAN，則請將它保留為空白。會自動為您建立公用及專用 VLAN。如果您具有現有 VLAN，並且未指定公用 VLAN，則請考慮配置防火牆（例如 [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html#about)）。您可以將相同的 VLAN 用於多個叢集。若要在位於不同區域的工作者節點之間啟用專用網路的通訊，您必須啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)。**附註**：如果將工作者節點設定為僅具有專用 VLAN，則您必須配置替代方案以進行網路連線。

5. 配置預設工作者節點儲存區。工作者節點儲存區是共用相同配置的工作者節點群組。您一律可以稍後再將更多工作者節點儲存區新增至叢集。

    1. 選取硬體隔離的類型。虛擬伺服器是按小時計費，裸機伺服器是按月計費。

        - **虛擬 - 專用**：工作者節點是在您帳戶專用的基礎架構上進行管理。實體資源完全被隔離。

        - **虛擬 - 共用**：您與其他 IBM 客戶之間可以共用基礎架構資源（例如 Hypervisor 和實體硬體），但每一個工作者節點僅供您存取。雖然此選項的成本比較低，而且在大部分情況下已夠用，您可能要根據公司原則來驗證效能及基礎架構需求。

        - **裸機**：按月計費的裸機伺服器是透過與 IBM Cloud 基礎架構 (SoftLayer) 之間的手動互動來進行佈建，可能需要多個營業日才能完成。裸機伺服器最適合需要更多資源和主機控制的高效能應用程式。對於執行 Kubernetes 1.9 版或更新版本的叢集，您也可以選擇啟用[授信運算](cs_secure.html#trusted_compute)來驗證工作者節點是否遭到竄改。「授信運算」可用於選取裸機的機型。例如，`mgXc` GPU 特性不支援「授信運算」。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](cs_cli_reference.html#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。

        請確定您要佈建裸機機器。因為它是按月計費，如果您不慎下訂之後立即取消，仍會向您收取整個月的費用。
        {:tip}

    2. 選取機型。機型會定義設定於每一個工作者節點中，且可供容器使用的虛擬 CPU、記憶體及磁碟空間量。可用的裸機及虛擬機器類型會因您部署叢集所在的區域而不同。建立叢集之後，您可以藉由將工作者節點或儲存區新增至叢集來新增不同的機型。

    3. 指定您在叢集裡需要的工作者節點數目。您輸入的工作者節點數目會抄寫到您所選取數目的區域。這表示，如果您有 2 個區域並選取 3 個工作者節點，則會佈建 6 個節點，而且每一個區域中都有 3 個節點。

6. 為叢集提供唯一名稱。**附註**：變更在建立期間指派的唯一 ID 或網域名稱會封鎖 Kubernetes 主節點，使其無法管理叢集。

7. 選擇叢集主節點的 Kubernetes API 伺服器版本。

8. 按一下**建立叢集**。即會建立具有所指定工作者數目的工作者節點儲存區。您可以在**工作者節點**標籤中查看工作者節點部署的進度。部署完成時，您可以在**概觀**標籤中看到叢集已就緒。

**下一步為何？**

當叢集開始執行時，您可以查看下列作業：

-   [將區域新增至叢集](#add_zone)，以將工作者節點分散到多個區域。
-   [安裝 CLI 以開始使用您的叢集。](cs_cli_install.html#cs_cli_install)
-   [在叢集裡部署應用程式。](cs_app.html#app_cli)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)
- 如果一個叢集具有多個 VLAN，或相同的 VLAN 上具有多個子網路，您必須[開啟 VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓工作者節點可以在專用網路上彼此通訊。
- 如果您有防火牆，則可能需要[開啟必要埠](cs_firewall.html#firewall)，才能使用 `ibmcloud`、`kubectl` 或 `calicotl` 指令，以容許來自叢集的出埠資料流量，或容許網路服務的入埠資料流量。
-  具有 Kubernetes 1.10 版或更新版本的叢集：控制誰可以使用 [Pod 安全原則](cs_psp.html)在您的叢集裡建立 Pod。

<br />


## 使用 CLI 建立叢集
{: #clusters_cli}

Kubernetes 叢集的用途是要定義一組資源、節點、網路及儲存裝置，讓應用程式保持高可用性。您必須先建立叢集並設定該叢集裡工作者節點的定義，才能部署應用程式。
{:shortdesc}

開始之前：
- 您必須具有「隨收隨付制」或「訂閱」的 [{{site.data.keyword.Bluemix_notm}} 帳戶](https://console.bluemix.net/registration/)，其會配置為[存取 IBM Cloud 基礎架構 (SoftLayer) 組合](cs_troubleshoot_clusters.html#cs_credentials)。您可以建立 1 個免費叢集來試用部分功能 30 天，或建立完全可自訂的標準叢集，並選擇硬體隔離。
- [請確定您在 IBM Cloud 基礎架構 (SoftLayer) 中具有佈建標準叢集所需的最少許可權](cs_users.html#infra_access)。
- 安裝 {{site.data.keyword.Bluemix_notm}} CLI 及 [{{site.data.keyword.containershort_notm}} 外掛程式](cs_cli_install.html#cs_cli_install)。
- 如果一個叢集具有多個 VLAN，或相同的 VLAN 上具有多個子網路，您必須[開啟 VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓工作者節點可以在專用網路上彼此通訊。

若要建立叢集，請執行下列動作：

1.  登入 {{site.data.keyword.Bluemix_notm}} CLI。

    1.  系統提示時，請登入並輸入 {{site.data.keyword.Bluemix_notm}} 認證。

        ```
        ibmcloud login
        ```
        {: pre}

        **附註：**如果您具有聯合 ID，請使用 `ibmcloud login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

    2. 如果您有多個 {{site.data.keyword.Bluemix_notm}} 帳戶，請選取您要在其中建立 Kubernetes 叢集的帳戶。

    3.  如果您要在先前所選取 {{site.data.keyword.Bluemix_notm}} 地區以外的地區中建立或存取 Kubernetes 叢集，請執行 `ibmcloud ks region-set`。

3.  建立叢集。

    1.  **標準叢集**：檢閱可用的區域。顯示的區域取決於您所登入的 {{site.data.keyword.containershort_notm}} 地區。

        **附註**：若要跨越區域間的叢集，您必須在[具有多區域功能的區域](cs_regions.html#zones)中建立叢集。

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **標準叢集**：選擇區域，並檢閱該區域中可用的機型。機型指定每一個工作者節點可用的虛擬或實體運算主機。

        -  檢視**伺服器類型**欄位，以選擇虛擬或實體（裸機）機器。
        -  **虛擬**：按小時計費的虛擬機器是佈建在共用或專用硬體上。
        -  **實體**：按月計費的裸機伺服器透過與 IBM Cloud 基礎架構 (SoftLayer) 之間的手動互動來進行佈建，可能需要多個營業日才能完成。裸機伺服器最適合需要更多資源和主機控制的高效能應用程式。
        - **使用授信運算的實體機器**：對於執行 Kubernetes 1.9 版或更新版本的裸機叢集，您也可以選擇啟用[授信運算](cs_secure.html#trusted_compute)來驗證裸機工作者節點是否遭到竄改。「授信運算」可用於選取裸機的機型。例如，`mgXc` GPU 特性不支援「授信運算」。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](cs_cli_reference.html#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。
        -  **機型**：若要決定要部署的機型，請檢閱[可用工作者節點硬體](#shared_dedicated_node)的核心、記憶體及儲存空間組合。建立叢集之後，您可以藉由[新增工作者節點儲存區](#add_pool)來新增不同的實體或虛擬機器類型。

           請確定您要佈建裸機機器。因為它是按月計費，如果您不慎下訂之後立即取消，仍會向您收取整個月的費用。
        {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **標準叢集**：查看 IBM Cloud 基礎架構 (SoftLayer) 中是否已存在此帳戶的公用及專用 VLAN。

        ```
        ibmcloud ks vlans <zone>
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

        您必須將工作者節點連接至專用 VLAN，也可以選擇性地將工作者節點連接至公用 VLAN。**附註**：如果將工作者節點設定為僅具有專用 VLAN，則您必須配置替代方案以進行網路連線。

    4.  **免費及標準叢集**：執行 `cluster-create` 指令。您可以選擇免費叢集（包括一個已設定 2vCPU 及 4GB 記憶體的工作者節點），且會在 30 天後自動刪除。當您建立標準叢集時，依預設，會加密工作者節點磁碟，其硬體由多位 IBM 客戶所共用，並且按使用時數計費。</br>標準叢集的範例。指定叢集的選項：

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt][--trusted]
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
        <td>**標準叢集**：將 <em>&lt;zone&gt;</em> 取代為您要建立叢集的 {{site.data.keyword.Bluemix_notm}} 區域 ID。可用的區域取決於您所登入的 {{site.data.keyword.containershort_notm}} 地區。<br></br>**附註**：將叢集工作者節點部署至此區域。若要跨越區域間的叢集，您必須在[具有多區域功能的區域](cs_regions.html#zones)中建立叢集。建立叢集之後，您可以[將區域新增至叢集](#add_zone)。</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**標準叢集**：選擇機型。您可以將工作者節點部署為共用或專用硬體上的虛擬機器，或部署為裸機上的實體機器。可用的實體及虛擬機器類型會因您部署叢集所在的區域而不同。如需相關資訊，請參閱 `ibmcloud ks machine-type` [指令](cs_cli_reference.html#cs_machine_types)的文件。若為免費叢集，您不需要定義機型。</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**標準叢集，僅限虛擬**：您的工作者節點的硬體隔離層次。若要讓可用的實體資源只供您專用，請使用 dedicated，或者，若要容許與其他 IBM 客戶共用實體資源，請使用 shared。預設值為 shared。此值對於標準叢集是選用的，不適用於免費叢集。</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**免費叢集**：您不需要定義公用 VLAN。免費叢集會自動連接至 IBM 所擁有的公用 VLAN。</li>
          <li>**標準叢集**：如果您在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中已設定用於該區域的公用 VLAN，請輸入公用 VLAN 的 ID。如果您只要將工作者節點連接至專用 VLAN，請不要指定此選項。**附註**：如果將工作者節點設定為僅具有專用 VLAN，則您必須配置替代方案以進行網路連線。<br/><br/>
          <strong>附註</strong>：專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**免費叢集**：您不需要定義專用 VLAN。免費叢集會自動連接至 IBM 所擁有的專用 VLAN。</li><li>**標準叢集**：如果您在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中已設定用於該區域的專用 VLAN，請輸入專用 VLAN 的 ID。如果您的帳戶中沒有專用 VLAN，請不要指定此選項。{{site.data.keyword.containershort_notm}} 會自動為您建立一個專用 VLAN。<br/><br/><strong>附註</strong>：專用 VLAN 路由器的開頭一律為 <code>bcr</code>（後端路由器），而公用 VLAN 路由器的開頭一律為 <code>fcr</code>（前端路由器）。當建立叢集並指定公用和專用 VLAN 時，那些字首之後的數字和字母組合必須相符。</li></ul></td>
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
        <td><code>--disable-disk-encrypt</code></td>
        <td>**免費及標準叢集**：依預設，工作者節點的特色為磁碟加密；[進一步瞭解](cs_secure.html#encrypted_disk)。如果您要停用加密，請包括此選項。</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**標準裸機叢集**：啟用[授信運算](cs_secure.html#trusted_compute)，以驗證裸機工作者節點是否遭到竄改。「授信運算」可用於選取裸機的機型。例如，`mgXc` GPU 特性不支援「授信運算」。如果您未在建立叢集期間啟用信任，但後來想要啟用，則可以使用 `ibmcloud ks feature-enable` [指令](cs_cli_reference.html#cs_cluster_feature_enable)。啟用信任之後，以後您就無法再予以停用。</td>
        </tr>
        </tbody></table>

4.  驗證已要求建立叢集。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    **附註：**若為虛擬機器，要訂購工作者節點機器並且在您的帳戶中設定及佈建叢集，可能需要一些時間。裸機實體機器是透過與 IBM Cloud 基礎架構 (SoftLayer) 之間的手動互動來進行佈建，可能需要多個營業日才能完成。

    叢集佈建完成之後，叢集的狀態會變更為 **deployed**。

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.10.5
    ```
    {: screen}

5.  檢查工作者節點的狀態。

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    工作者節點就緒後，狀況會變更為 **Normal**，並且處於 **Ready** 狀態。當節點狀態為 **Ready** 時，您就可以存取叢集。

    **附註：**每個工作者節點都會獲指派唯一的工作者節點 ID 及網域名稱，在叢集建立之後即不得手動予以變更。變更 ID 或網域名稱會讓 Kubernetes 主節點無法管理叢集。

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone   Version
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01      1.10.5
    ```
    {: screen}

6.  將您建立的叢集設為此階段作業的環境定義。請在您每次使用叢集時，完成下列配置步驟。
    1.  取得指令來設定環境變數，並下載 Kubernetes 配置檔。

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        配置檔下載完成之後，會顯示一個指令，可讓您用來將本端 Kubernetes 配置檔的路徑設定為環境變數。

        OS X 的範例：

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  複製並貼上終端機中顯示的指令，以設定 `KUBECONFIG` 環境變數。
    3.  驗證 `KUBECONFIG` 環境變數已適當設定。

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

7.  使用預設埠 `8001` 來啟動 Kubernetes 儀表板。
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

-   [將區域新增至叢集](#add_zone)，以將工作者節點分散到多個區域。
-   [在叢集裡部署應用程式。](cs_app.html#app_cli)
-   [使用 `kubectl` 指令行管理叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")。](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [在 {{site.data.keyword.Bluemix_notm}} 中設定您自己的專用登錄，以儲存 Docker 映像檔，並將它與其他使用者共用。](/docs/services/Registry/index.html)
- 如果您有防火牆，則可能需要[開啟必要埠](cs_firewall.html#firewall)，才能使用 `ibmcloud`、`kubectl` 或 `calicotl` 指令，以容許來自叢集的出埠資料流量，或容許網路服務的入埠資料流量。
-  具有 Kubernetes 1.10 版或更新版本的叢集：控制誰可以使用 [Pod 安全原則](cs_psp.html)在您的叢集裡建立 Pod。

<br />



## 將工作者節點及區域新增至叢集
{: #add_workers}

若要增加應用程式的可用性，您可以將工作者節點新增至叢集裡的現有區域或多個現有區域。為了協助保護應用程式不發生區域失敗，您可以將區域新增至叢集。
{:shortdesc}

當您建立叢集時，會在工作者節點儲存區中佈建工作者節點。在建立叢集之後，您可以藉由調整其大小或新增更多工作者節點儲存區，來將更多工作者節點新增至儲存區。依預設，工作者節點儲存區存在於一個區域中。一個區域中只有一個工作者節點儲存區的叢集稱為單一區域叢集。當您將更多區域新增至叢集時，工作者節點儲存區會存在於多個區域。具有分散到多個區域之工作者節點儲存區的叢集稱為多區域叢集。

如果您有多區域叢集，請保持其工作者節點資源的平衡。請確定所有工作者節點儲存區都分散到相同區域，並藉由調整儲存區大小來新增或移除工作者節點，而不是新增個別節點。
{: tip}

下列各節顯示如何：
  * [調整叢集裡現有工作者節點儲存區的大小來新增工作者節點](#resize_pool)
  * [將工作者節點儲存區新增至叢集來新增工作者節點](#add_pool)
  * [將區域新增至叢集，並將工作者節點儲存區中的工作者節點抄寫到多個區域](#add_zone)
  * [已淘汰：將獨立式工作者節點新增至叢集](#standalone)


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
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    位於兩個區域（`dal10` 及 `dal12`）中且調整大小為每個區域有兩個工作者節點之工作者節點儲存區的輸出範例：
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### 建立新工作者節點儲存區來新增工作者節點
{: #add_pool}

您可以建立新的工作者節點儲存區，以將工作者節點新增至叢集。
{:shortdesc}

1. 列出可用的區域，並選擇要在工作者節點儲存區中部署工作者節點的區域。如果您計劃將工作者節點分散到多個區域，請選擇[具有多區域功能的區域](cs_regions.html#zones)。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 針對每一個區域，列出可用的專用及公用 VLAN。請記下您要使用的專用及公用 VLAN。如果您沒有專用或公用 VLAN，則會在將區域新增至工作者節點儲存區時自動為您建立 VLAN。
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. 建立工作者節點儲存區。如需機型選項，請檢閱 [`machine-types` 指令](cs_cli_reference.html#cs_machine_types)文件。
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

4. 驗證已建立工作者節點儲存區。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

5. 依預設，新增工作者節點儲存區會建立沒有區域的儲存區。若要在區域中部署工作者節點，您必須將區域新增至工作者節點儲存區。如果您要將工作者節點分散到多個區域，請使用不同的具有多區域功能的區域來重複此命令。  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

6. 驗證工作者節點佈建於您所新增的區域中。
   ```
   ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   輸出範例：
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### 將區域新增至工作者節點儲存區來新增工作者節點
{: #add_zone}

您可以跨越一個地區內跨多個區域的叢集，方法是將區域新增至現有工作者節點儲存區。
{:shortdesc}

當您將區域新增至工作者節點儲存區時，會在新的區域中佈建工作者節點儲存區中所定義的工作者節點，並考慮用於排定未來的工作負載。{{site.data.keyword.containerlong_notm}} 會自動將地區的 `failure-domain.beta.kubernetes.io/region` 標籤以及區域的 `failure-domain.beta.kubernetes.io/zone` 標籤新增至每一個工作者節點。Kubernetes 排程器使用這些標籤，以將 Pod 分散到相同地區內的區域。

**附註**：如果您的叢集裡有多個工作者節點儲存區，請將該區域新增至所有這些儲存區，以將工作者節點平均地分散到叢集。

開始之前：
*  若要將區域新增至工作者節點儲存區，該工作者節點儲存區必須位於[具有多區域功能的區域](cs_regions.html#zones)中。如果您的工作者節點儲存區不在具有多區域功能的區域中，請考慮[建立新工作者節點儲存區](#add_pool)。
*  針對您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。作為 VLAN Spanning 的替代方案，如果您已在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中啟用「虛擬路由器功能 (VRF)」，則可以使用它。

若要將具有工作者節點的區域新增至工作者節點儲存區，請執行下列動作：

1. 列出可用的區域，並挑選您要新增至工作者節點儲存區的區域。您選擇的區域必須是具有多區域功能的區域。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 列出該區域中的可用 VLAN。如果您沒有專用或公用 VLAN，則會在將區域新增至工作者節點儲存區時自動為您建立 VLAN。
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. 列出叢集裡的工作者節點儲存區，並記下其名稱。
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. 將區域新增至工作者節點儲存區。如果您有多個工作者節點儲存區，請將區域新增至所有工作者節點儲存區，以平衡所有區域中的叢集。請將 `<pool1_id_or_name,pool2_id_or_name,...>` 取代為所有工作者節點儲存區的名稱（以逗點區隔的清單）。</br>**附註：**必須要有專用及公用 VLAN，才能將區域新增至多個工作者節點儲存區。如果您在該區域中沒有專用及公用 VLAN，請先將該區域新增至一個工作者節點儲存區，以為您建立專用及公用 VLAN。然後，您可以指定為您所建立的專用及公用 VLAN，以將該區域新增至其他工作者節點儲存區。

   如果您要對不同的工作者節點儲存區使用不同的 VLAN，則請針對每一個 VLAN 及其對應工作者節點儲存區重複這個指令。任何新的工作者節點都會新增至您指定的 VLAN，但不會變更任何現有工作者節點的 VLAN。
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. 驗證已將區域新增至叢集。在輸出的**工作者節點區域**欄位中，尋找已新增的區域。請注意，隨著在已新增的區域中佈建新工作者節點，**工作者節點**欄位中的工作者節點總數會增加。
    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    輸出範例：
    ```
    Name:               mycluster
    ID:                 a20a637238aa471f8d4a8b881aaa4988
    State:              normal
    Created:            2018-04-19T01:49:22+0000
    Master zone:    us-south
    Worker zones:       dal10,dal12
    Master URL:         https://169.xx.xxx.xxx:21111
    Ingress subdomain:  ...
    Ingress secret:     ...
    Workers:            6
    Version:            1.8.6_1504
    ```
    {: screen}  

### 已淘汰：新增獨立式工作者節點
{: #standalone}

如果您的叢集是在引進工作者節點儲存區之前所建立，則可以使用已淘汰的指令來新增獨立式工作者節點。
{: shortdesc}

**附註：**如果您的叢集是在引進工作者節點儲存區之後所建立，則無法新增獨立式工作者節點。相反地，您可以[建立工作者節點儲存區](#add_pool)、[調整現有工作者節點儲存區的大小](#resize_pool)，或[將區域新增至工作者節點儲存區](#add_zone)，以將工作者節點新增至叢集。

1. 列出可用的區域，並挑選您要新增工作者節點的區域。
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. 列出該區域中的可用 VLAN，並記下其 ID。
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. 列出該區域中的可用機型。
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

4. 將獨立式工作者節點新增至叢集。
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. 驗證已建立工作者節點。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}



## 檢視叢集狀況
{: #states}

檢閱 Kubernetes 叢集的狀況，以取得叢集可用性及容量的相關資訊，以及可能已發生的潛在問題。
{:shortdesc}

若要檢視特定叢集的相關資訊（例如其區域、主要 URL、Ingress 子網域、版本、擁有者及監視儀表板），請使用 `ibmcloud ks cluster-get <cluster_name_or_ID>` [指令](cs_cli_reference.html#cs_cluster_get)。包括 `--showResources` 旗標，以檢視其他叢集資源，例如，儲存空間 Pod 的附加程式，或是公用及專用 IP 的子網路 VLAN。

您可以執行 `ibmcloud ks clusters` 指令並找出**狀況**欄位，以檢視現行叢集狀況。若要對叢集和工作者節點進行疑難排解，請參閱[叢集的疑難排解](cs_troubleshoot.html#debug_clusters)。

<table summary="每個表格列都應該從左到右閱讀，第一欄為叢集狀況，第二欄則為說明。">
    <caption>叢集狀況</caption>
   <thead>
   <th>叢集狀況</th>
   <th>說明</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>在部署 Kubernetes 主節點之前，使用者要求刪除叢集。叢集刪除完成之後，即會從儀表板移除該叢集。如果叢集停留在此狀況很長一段時間，請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](cs_troubleshoot.html#ts_getting_help)。</td>
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
     <td>叢集已刪除，但尚未從儀表板移除。如果叢集停留在此狀況很長一段時間，請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](cs_troubleshoot.html#ts_getting_help)。</td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>正在刪除叢集，且正在拆除叢集基礎架構。您無法存取該叢集。</td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>無法完成 Kubernetes 主節點的部署。您無法解決此狀況。請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](cs_troubleshoot.html#ts_getting_help)，與 IBM Cloud 支援中心聯絡。</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Kubernetes 主節點尚未完整部署。您無法存取叢集。請等到叢集完成部署後，再檢閱叢集的性能。</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>叢集裡的所有工作者節點都已開始執行。您可以存取叢集，並將應用程式部署至叢集。此狀況被視為健全，您不需要採取動作。**附註**：雖然工作者節點可能是正常的，但可能仍需注意其他的基礎架構資源（例如[網路](cs_troubleshoot_network.html)和[儲存空間](cs_troubleshoot_storage.html)）。</td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>已部署 Kubernetes 主節點。正在佈建工作者節點，因此還無法在叢集裡使用。您可以存取叢集，但無法將應用程式部署至叢集。</td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>已傳送要建立叢集和訂購 Kubernetes 主節點和工作者節點之基礎架構的要求。當開始部署叢集時，叢集狀況會變更為 <code>Deploying</code>。如果叢集停留在 <code>Requested</code> 狀況很長一段時間，請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](cs_troubleshoot.html#ts_getting_help)。</td>
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

不再需要使用「隨收隨付制」帳戶所建立的免費及標準叢集時，必須手動移除這些叢集，以便它們不再耗用資源。
{:shortdesc}

**警告：**
  - 不會在持續性儲存空間中建立叢集或資料的備份。刪除叢集或持續性儲存空間是永久性的，無法復原。
  - 移除叢集時，您也會移除在建立叢集時自動佈建的所有子網路，以及您使用 `ibmcloud ks cluster-subnet-create` 指令所建立的所有子網路。不過，如果您使用 `ibmcloud ks cluster-subnet-add` 指令手動將現有子網路新增至叢集，則不會從 IBM Cloud 基礎架構 (SoftLayer) 帳戶移除這些子網路，並且可以在其他叢集裡重複使用它們。

開始之前：
* 記下叢集 ID。您可能需要叢集 ID，才能調查及移除未隨著叢集自動刪除的相關 IBM Cloud 基礎架構 (SoftLayer) 資源。
* 如果您要刪除持續性儲存空間中的資料，請[瞭解 delete 選項](cs_storage_remove.html#cleanup)。

若要移除叢集，請執行下列動作：

-   從 {{site.data.keyword.Bluemix_notm}} GUI
    1.  選取叢集，然後按一下**其他動作...** 功能表中的**刪除**。

-   從 {{site.data.keyword.Bluemix_notm}} CLI
    1.  列出可用的叢集。

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  刪除叢集。

        ```
        ibmcloud ks cluster-rm <cluster_name_or_ID>
        ```
        {: pre}

    3.  遵循提示，然後選擇是否刪除叢集資源，其中包括容器、Pod、連結服務、持續性儲存空間及密碼。
      - **持續性儲存空間**：持續性儲存空間為您的資料提供高可用性。如果您使用[現有的檔案共用](cs_storage_file.html#existing_file)建立了持續性磁區要求，則在刪除叢集時，無法刪除檔案共用。您必須稍後從 IBM Cloud 基礎架構 (SoftLayer) 組合中手動刪除檔案共用。

          **附註**：由於每月計費週期，不能在月底最後一天刪除持續性磁區要求。如果您在該月份的最後一天刪除持續性磁區要求，則刪除會保持擱置，直到下個月開始為止。

後續步驟：
- 當您執行 `ibmcloud ks clusters` 指令時，在可用的叢集清單中不再列出已移除的叢集之後，您就可以重複使用該叢集的名稱。
- 如果保留子網路，則可以[在新的叢集裡重複使用它們](cs_subnets.html#custom)，或稍後從 IBM Cloud 基礎架構 (SoftLayer) 組合中手動刪除它們。
- 如果保留持續性儲存空間，則稍後可以透過 {{site.data.keyword.Bluemix_notm}} GUI 中的 IBM Cloud 基礎架構 (SoftLayer) 儀表板來[刪除儲存空間](cs_storage_remove.html#cleanup)。
