---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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



# 更新叢集、工作者節點及附加程式
{: #update}

您可以安裝更新，讓 Kubernetes 叢集在 {{site.data.keyword.containerlong}} 中保持最新。
{:shortdesc}

## 更新 Kubernetes 主節點
{: #master}

Kubernetes 會定期發行[主要、次要或修補程式更新](cs_versions.html#version_types)。更新會影響 Kubernetes API 伺服器版本或 Kubernetes 主節點的其他元件。IBM 會更新修補程式版本，但您必須更新主節點的主要及次要版本。
{:shortdesc}

**如何知道何時更新主節點？**</br>
在更新可用時，您會於 {{site.data.keyword.Bluemix_notm}} 主控台及 CLI 中收到通知，也可以檢查[支援的版本](cs_versions.html)頁面。

**主節點在最新版本後面可以有多少版本？**</br>
IBM 一般在給定時間會支援 3 個版本的 Kubernetes。您不能將 Kubernetes API 伺服器更新超過其現行版本的 2 個版本。

例如，如果現行 Kubernetes API 伺服器版本是 1.7，而您要更新至 1.10，則必須先更新至 1.9。您可以強制進行更新，但更新三個以上次要版本可能會造成非預期結果或失敗。

如果您的叢集是執行不受支援的 Kubernetes 版本，則可能需要強制更新。因此，請讓叢集保持最新狀態，以避免作業影響。

**工作者節點所執行的版本可以比主節點還要新嗎？**</br>
不可以。首先，請[更新主節點](#update_master)至最新的 Kubernetes 版本。然後，在叢集裡[更新工作者節點](#worker_node)。

**如何套用修補程式更新？**</br>
依預設，主節點的修補程式更新會在幾天內自動套用，因此，主節點修補程式版本可能會先顯示為可用，再將它套用至您的主節點。更新自動化也會跳過處於性能不佳狀態或目前正在進行作業的叢集。有時，IBM 可能會停用特定主節點修正套件的自動更新，例如只有在主節點從某個次要版本更新為另一個次要版本時才需要的修補程式。在其中任何情況下，您可以[檢查版本變更日誌](cs_versions_changelog.html)，以找出任何潛在的影響，並選擇自行安全地使用 `ibmcloud ks cluster-update` [指令](cs_cli_reference.html#cs_cluster_update)，而不需要等待套用更新自動化。

與主節點不同，您必須更新每個修補程式版本的工作者節點。

**在主節點更新期間會發生什麼情況？**</br>
在執行 Kubbernets 1.11 版或更新版本的叢集中，您的主節點可以高度地與三個抄本主節點 Pod 搭配使用。主節點 Pod 具有漸進式更新，在漸進式更新期間，一次僅有一個 Pod 無法使用。兩個實例會啟動並執行，讓您可在更新期間存取和變更叢集。您的工作者節點、應用程式及資源會繼續執行。

若為執行舊版 Kubernetes 的叢集，當您更新 Kubernetes API 伺服器時，API 伺服器會關閉大約 5-10 分鐘。在更新期間，您無法存取或變更叢集。不過，叢集使用者部署的工作者節點、應用程式和資源不會修改，並將繼續執行。

**是否可以回復更新？**</br>
不可以，在更新處理程序進行之後，您無法將叢集回復至舊版。請務必使用測試叢集，並遵循指示來解決可能的問題，然後才更新正式作業主節點。

**更新主節點時可遵循的處理程序為何？**</br>
下圖顯示您可以採取來更新主節點的處理程序。

![主節點更新最佳作法](/images/update-tree.png)

圖 1. 更新 Kubernetes 主節點程序圖

{: #update_master}
開始之前，請確定您具有[**操作員**或**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](cs_users.html#platform)。

若要更新 Kubernetes 主節點的_主要_ 或_次要_ 版本，請執行下列動作：

1.  檢閱 [Kubernetes 變更](cs_versions.html)，並更新標示為_在主節點之前更新_ 的任何項目。

2.  使用 {{site.data.keyword.Bluemix_notm}} 主控台或執行 CLI `ibmcloud ks cluster-update` [指令](cs_cli_reference.html#cs_cluster_update)，來更新 Kubernetes API 伺服器及關聯的 Kubernetes 主節點元件。

3.  等待幾分鐘，然後確認更新已完成。請檢閱「{{site.data.keyword.Bluemix_notm}} 儀表板」上的 Kubernetes API 伺服器版本，或執行 `ibmcloud ks clusters`。

4.  安裝符合在 Kubernetes 主節點中執行的 Kubernetes API 伺服器版本的 [`kibectl cli`](cs_cli_install.html#kubectl) 版本。

當 Kubernetes API 伺服器更新完成時，您可以更新工作者節點。

<br />


## 更新工作者節點
{: #worker_node}

您收到更新工作者節點的通知。這代表什麼意思？當 Kubernetes API 伺服器及其他 Kubernetes 主節點元件的安全更新和修補程式備妥之後，您必須確定工作者節點保持同步。
{: shortdesc}

**應用程式在更新期間會發生什麼情況？**</br>
如果您在更新的工作者節點上進行部署時執行應用程式，則會將應用程式重新排定至叢集裡的其他工作者節點。這些工作者節點可能位於不同的工作者節點儲存區中，或者，如果您有獨立式工作者節點，則可能會將應用程式排定至獨立式工作者節點。若要避免應用程式關閉，您必須確定叢集裡有足夠的容量可以執行工作負載。

**如何控制更新期間的給定時間有多少個工作者節點關閉？**
如果您需要啟動並執行所有工作者節點，請考慮[調整工作者節點儲存區大小](cs_cli_reference.html#cs_worker_pool_resize)或[新增獨立式工作者節點](cs_cli_reference.html#cs_worker_add)以新增更多工作者節點。更新完成之後，即可移除其他工作者節點。

此外，您可以建立 Kubernetes 配置對映，以指定在更新期間的某個時間可能無法使用的工作者節點數目上限。工作者節點是透過工作者節點標籤所識別。您可以使用已新增至工作者節點的 IBM 提供的標籤或自訂標籤。

**我選擇不要定義配置對映的話，會發生什麼情況？**</br>
未定義配置對映時，會使用預設值。依預設，在每個叢集中，您所有的工作者節點最多會有 20% 在更新處理程序期間無法使用。

**開始之前**：
- [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。
- [更新 Kubernetes 主節點](#master)。工作者節點 Kubernetes 版本不得高於在 Kubernetes 主節點中執行的 Kubernetes API 伺服器版本。
- 進行 [Kubernetes 變更](cs_versions.html)中標示為_在主節點之後更新_ 的所有變更。
- 如果您要套用修補程式更新，請檢閱 [Kubernetes 版本變更日誌](cs_versions_changelog.html#changelog)。
- 確定您具有[**操作員**或**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](cs_users.html#platform)。</br>

更新工作者節點可能會導致應用程式及服務關閉。您的工作者節點機器會重新安裝映像，而且如果資料不是[儲存在 Pod 之外](cs_storage_planning.html#persistent_storage_overview)即會被刪除。
{: important}

**若要建立配置對映以及更新工作者節點**，請執行下列動作：

1.  列出可用的工作者節點，並記下其專用 IP 位址。

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

2. 檢視工作者節點的標籤。您可以在 CLI 輸出的 **Labels** 區段中找到工作者節點標籤。每個標籤都包含 `NodeSelectorKey` 及 `NodeSelectorValue`。
   ```
   kubectl describe node <private_worker_IP>
   ```
   {: pre}

   輸出範例：
   ```
   Name:               10.184.58.3
   Roles:              <none>
   Labels:             arch=amd64
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    failure-domain.beta.kubernetes.io/region=us-south
                    failure-domain.beta.kubernetes.io/zone=dal12
                    ibm-cloud.kubernetes.io/encrypted-docker-data=true
                    ibm-cloud.kubernetes.io/iaas-provider=softlayer
                    ibm-cloud.kubernetes.io/machine-type=u2c.2x4.encrypted
                    kubernetes.io/hostname=10.123.45.3
                    privateVLAN=2299001
                    publicVLAN=2299012
   Annotations:        node.alpha.kubernetes.io/ttl=0
                    volumes.kubernetes.io/controller-managed-attach-detach=true
   CreationTimestamp:  Tue, 03 Apr 2018 15:26:17 -0400
   Taints:             <none>
   Unschedulable:      false
   ```
   {: screen}

3. 建立配置對映，並且定義工作者節點的無效性規則。下列範例顯示 4 項檢查：`zonecheck.json`、`regioncheck.json`、`defaultcheck.json` 及檢查範本。您可以使用這些範例檢查，以定義下列項目的規則：特定區域 (`zonecheck.json`) 或地區 (`regioncheck.json`) 中的工作者節點，或是不符合您已在配置對映 (`defaultcheck.json`) 中定義的任何檢查的所有工作者節點。使用檢查範本以建立自己的檢查。針對每項檢查，若要識別工作者節點，您必須選擇前一個步驟中所擷取的其中一個工作者節點標籤。  

   針對每項檢查，您只能為 <code>NodeSelectorKey</code> 及 <code>NodeSelectorValue</code> 設定一個值。如果您要為多個地區、區域或其他工作者節點標籤設定規則，請建立新的檢查。在配置對映中，最多定義 10 項檢查。如果您新增更多檢查，則會忽略它們。
   {: note}

   範例：
   ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     drain_timeout_seconds: "120"
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 30,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
        "NodeSelectorValue": "dal13"
      }
    regioncheck.json: |
       {
         "MaxUnavailablePercentage": 20,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
        "NodeSelectorValue": "us-south"
      }
    defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 20
      }
    <check_name>: |
      {
        "MaxUnavailablePercentage": <value_in_percentage>,
        "NodeSelectorKey": "<node_selector_key>",
        "NodeSelectorValue": "<node_selector_value>"
      }
   ```
   {: codeblock}

   <table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為參數，第二欄則為符合的說明。">
    <caption>ConfigMap 元件</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解元件</th>
    </thead>
    <tbody>
      <tr>
        <td><code>drain_timeout_seconds</code></td>
        <td> 選用項目：等待 [drain ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/) 完成的逾時（以秒為單位）。排除工作者節點可安全地移除工作者節點中的所有現有 Pod，以及將 Pod 重新排定至叢集裡的其他工作者節點。接受值是從 1 到 180 的整數。預設值為 30。</td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td>定義一組工作者節點的規則的兩項檢查，而您可以使用指定的 <code>NodeSelectorKey</code> 及 <code>NodeSelectorValue</code> 來識別這組工作者節點。<code>zonecheck.json</code> 可根據工作者節點的區域標籤來識別工作者節點，而 <code>regioncheck.json</code> 會使用在佈建期間新增至每個工作者節點的地區標籤。在此範例中，<code>dal13</code> 作為其區域標籤的所有工作者節點的 30% 以及 <code>us-south</code> 中所有工作者節點的 20% 在更新期間可能無法使用。</td>
      </tr>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td>如果您未建立配置對映，或對映的配置不正確，則會套用 Kubernetes 預設值。依預設，在給定時間，叢集裡的工作者節點只有 20% 無法使用。您可以新增配置對映的預設檢查，來置換預設值。在此範例中，於更新期間可能無法使用區域及地區檢查（<code>dal13</code> 或 <code>us-south</code>）中未指定的每個工作者節點。</td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td>針對指定的標籤索引鍵及值，容許無法使用的節點數量上限，以百分比格式指定。工作者節點處於部署、重新載入或佈建程序時，即無法使用。如果已排入佇列的工作者節點超出任何已定義的無法使用百分比上限，則會被封鎖而無法更新。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td>您要設定規則的工作者節點的標籤索引鍵。您可以為 IBM 提供的預設標籤設定規則，也可以在您建立的工作者節點標籤上設定規則。<ul><li>如果您要新增屬於某個工作者節點儲存區的工作者節點的規則，則可以使用 <code>ibm-cloud.kubernetes.io/machine-type</code> 標籤。</li><li> 如果您有多個工作者節點儲存區具有相同的機型，請使用自訂標籤。</li></ul></td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td>工作者節點必須具有以讓您定義的規則考量的標籤值。</td>
      </tr>
    </tbody>
   </table>

4. 在叢集裡建立配置對映。
   ```
   kubectl apply -f <filepath/configmap.yaml>
   ```
   {: pre}

5. 驗證已建立配置對映。
   ```
   kubectl get configmap --namespace kube-system
   ```
   {: pre}

6.  更新工作者節點。

    ```
    ibmcloud ks worker-update <cluster_name_or_ID> <worker_node1_ID> <worker_node2_ID>
    ```
    {: pre}

7. 選用項目：驗證配置對映所觸發的事件，以及發生的所有驗證錯誤。在 CLI 輸出的 **Events** 區段中，可以檢閱事件。
   ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
   {: pre}

8. 藉由檢閱工作者節點的 Kubernetes 版本，來確認更新已完成。  
   ```
   kubectl get nodes
   ```
   {: pre}

9. 驗證您沒有重複的工作者節點。在部分情況下，較舊的叢集可能在更新之後將重複的工作者節點列為 **NotReady** 狀態。若要移除重複項目，請參閱[疑難排解](cs_troubleshoot_clusters.html#cs_duplicate_nodes)。

後續步驟：
  - 對其他工作者節點儲存區重複更新處理程序。
  - 通知在叢集內工作的開發人員，將 `kubectl` CLI 更新至 Kubernetes 主節點的版本。
  - 如果 Kubernetes 儀表板未顯示使用率圖形，則會[刪除 `kudbe-dashboard` Pod](cs_troubleshoot_health.html#cs_dashboard_graphs)。

<br />



## 更新機型
{: #machine_type}

您可以藉由新增工作者節點及移除舊的工作者節點，來更新工作者節點的機型。例如，假設您在專用的機型上有虛擬工作者節點，且機型的名稱中有 `u1c` 或 `b1c`，請建立使用名稱中有 `u2c` 或 `b2c` 的機型的工作者節點。
{: shortdesc}

開始之前：
- [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。
- 如果您在工作者節點上儲存資料，則如果資料不是[儲存在工作者節點之外](cs_storage_planning.html#persistent_storage_overview)即會被刪除。
- 確定您具有[**操作員**或**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](cs_users.html#platform)。

1. 列出可用的工作者節點，並記下其專用 IP 位址。
   - **針對工作者節點儲存區中的工作者節點**：
     1. 列出叢集裡可用的工作者節點儲存區。
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

     2. 列出工作者節點儲存區中的工作者節點。
        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
        ```
        {: pre}

     3. 取得工作者節點的詳細資料，並記下區域、專用及公用 VLAN ID。
        ```
        ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>
        ```
        {: pre}

   - **已淘汰：針對獨立式工作者節點**：
     1. 列出可用的工作者節點。
        ```
        ibmcloud ks workers <cluster_name_or_ID>
        ```
        {: pre}

     2. 取得工作者節點的詳細資料，並記下區域、專用及公用 VLAN ID。
        ```
        ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>
        ```
        {: pre}

2. 列出區域中的可用機型。
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

3. 使用新機型建立工作者節點。
   - **針對工作者節點儲存區中的工作者節點**：
     1. 使用您要取代的工作者節點數目，建立工作者節點儲存區。
        ```
        ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
        ```
        {: pre}

     2. 驗證已建立工作者節點儲存區。
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

     3. 將區域新增至您先前擷取的工作者節點儲存區。當您新增區域時，會在區域中佈建工作者節點儲存區中所定義的工作者節點，並考慮用於排定未來的工作負載。如果您要將工作者節點分散到多個區域，請選擇[具有多區域功能的區域](cs_regions.html#zones)。
        ```
        ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
        ```
        {: pre}

   - **已淘汰：針對獨立式工作者節點**：
       ```
       ibmcloud ks worker-add --cluster <cluster_name> --machine-type <machine_type> --number <number_of_worker_nodes> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
       ```
       {: pre}

4. 等待部署工作者節點。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

   工作者節點狀況變更為**正常**時，部署已完成。

5. 移除舊的工作者節點。**附註**：如果您要移除按月計費的機型（例如裸機），則會向您收取整個月的費用。
   - **針對工作者節點儲存區中的工作者節點**：
     1. 移除具有舊機型的工作者節點儲存區。移除工作者節點儲存區，會移除所有區域的儲存區中的所有工作者節點。此處理程序可能需要幾分鐘的時間才能完成。
        ```
        ibmcloud ks worker-pool-rm --worker-pool <pool_name> --cluster <cluster_name_or_ID>
        ```
        {: pre}

     2. 驗證已移除工作者節點儲存區。
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

   - **已淘汰：針對獨立式工作者節點**：
       ```
      ibmcloud ks worker-rm <cluster_name> <worker_node>
      ```
      {: pre}

6. 驗證已從叢集裡移除工作者節點。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

7. 重複這些步驟，將其他工作者節點儲存區或獨立式工作者節點更新為不同機型。

## 更新叢集附加程式
{: #addons}

{{site.data.keyword.containerlong_notm}} 叢集會隨附佈建叢集時自動安裝的附加程式（例如 Fluentd 以進行記載）。依預設，IBM 會自動更新這些附加程式。不過，您可以停用部分附加程式的自動更新，並從主節點及工作者節點分別進行手動更新。
{: shortdesc}

**我可以從叢集個別更新哪些預設附加程式？**</br>
您可以選擇性地停用下列附加程式的自動更新：
* [Fluentd 以進行記載](#logging)
* [Ingress 應用程式負載平衡器](#alb)

**是否有我無法從叢集個別更新的附加程式？**</br>

是。您的叢集已部署下列受管理的附加程式，以及無法變更的關聯資源，但為了某些效能好處而調整 Pod 或編輯 Configmap 除外。如果您嘗試變更其中一個部署附加程式，則會定期還原其原始設定。

* `coredns`
* `coredns-autoscaler`
* `heapster`
* `ibm-file-plugin`
* `ibm-storage-watcher`
* `ibm-keepalived-watcher`
* `kube-dns-amd64`
* `kube-dns-autoscaler`
* `kubernetes-dashboard`
* `metrics-server`
* `vpn`

您可以使用 `addonmanager.kubernetes.io/mode: Reconcile` 標籤來檢視這些資源。例如：

```
kubectl get deployments --all-namespaces -l addonmanager.kubernetes.io/mode=Reconcile
```
{: pre}

**是否可以安裝預設值以外的其他附加程式？**</br>
是。{{site.data.keyword.containerlong_notm}} 提供可從中選擇的其他附加程式，以將功能新增至叢集。例如，您可能要[使用 Helm 圖表](cs_integrations.html#helm)來安裝[區塊儲存空間外掛程式](cs_storage_block.html#install_block)、[Istio](cs_tutorials_istio.html#istio_tutorial) 或 [strongSwan VPN](cs_vpn.html#vpn-setup)。您必須遵循 Helm 圖表的更新指示，分別更新每個附加程式。

### 管理用於記載附加程式之 Fluentd 的自動更新
{: #logging}

若要變更記載或過濾器配置，Fluentd 附加程式必須為最新版本。依預設，會啟用自動更新附加程式。
{: shortdesc}

您可以使用下列方式，管理 Fluentd 附加程式的自動更新。**附註**：若要執行下列指令，您必須具有叢集的[**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](cs_users.html#platform)。

* 執行 `ibmcloud ks logging-autoupdate-get --cluster <cluster_name_or_ID>` [指令](cs_cli_reference.html#cs_log_autoupdate_get)，檢查是否已啟用自動更新。
* 執行 `ibmcloud ks logging-autoupdate-disable` [指令](cs_cli_reference.html#cs_log_autoupdate_disable)，來停用自動更新。
* 如果自動更新已停用，但您需要變更配置，則有兩個選項：
    * 開啟 Fluentd Pod 的自動更新。
        ```
        ibmcloud ks logging-autoupdate-enable --cluster <cluster_name_or_ID>
        ```
        {: pre}
    * 在您使用包括 `--force-update` 選項的 logging 指令時，強制執行一次性更新。**附註**：您的 Pod 會更新為 Fluentd 附加程式的最新版本，但 Fluentd 之後不會自動更新。範例指令：

        ```
        ibmcloud ks logging-config-update --cluster <cluster_name_or_ID> --id <log_config_ID> --type <log_type> --force-update
        ```
        {: pre}

### 管理 Ingress ALB 附加程式的自動更新
{: #alb}

控制何時更新 Ingress 應用程式負載平衡器 (ALB) 附加程式。
{: shortdesc}

更新 ALB 附加程式時，所有 ALB Pod 中的 `nginx-ingress` 和 `ingress-auth` 容器都會更新至最新的建置版本。依預設，會啟用自動更新附加程式。以漸進方式執行更新，讓您的 Ingress ALB 不會經歷任何關閉時間。

如果您停用自動更新，則會負責更新附加程式。當更新項目變成可用時，如果您執行 `ibmcloud k albs` 或 `alb-autoupdate-get` 指令，則會在 CLI 中收到通知。

當您更新叢集的主要或次要 Kubernetes 版本時，IBM 會自動針對 Ingress 部署進行必要的變更，但是不會變更 Ingress ALB 附加程式的建置版本。您負責檢查最新 Kubernet 版本與 Ingress ALB 附加程式映像檔的相容性。
{: note}

開始之前：

1. 驗證您的 ALB 在執行中。
    ```
    ibmcloud ks albs
    ```
    {: pre}

2. 檢查 Ingress ALB 附加程式的自動更新狀態。
    ```
    ibmcloud ks alb-autoupdate-get --cluster <cluster_name_or_ID>
    ```
    {: pre}

    自動更新已啟用時的輸出範例：
    ```
    Retrieving automatic update status of application load balancer (ALB) pods in cluster mycluster...
    OK
    Automatic updates of the ALB pods are enabled in cluster mycluster
    ALBs are at the latest version in cluster mycluster
    ```
    {: screen}

    自動更新已停用時的輸出範例：
    ```
    Retrieving automatic update status of application load balancer (ALB) pods in cluster mycluster...
    OK
    Automatic updates of the ALB pods are disabled in cluster mycluster
    ALBs are not at the latest version in cluster mycluster. To view the current version, run 'ibmcloud ks albs'.
    ```
    {: screen}

3. 驗證 ALB Pod 的現行**建置**版本。
    ```
    ibmcloud ks albs --cluster <cluster_name_or_ID>
    ```
    {: pre}

    輸出範例：
    ```
    ALB ID                                            Status    Type      ALB IP         Zone    Build
    private-crb110acca09414e88a44227b87576ceea-alb1   enabled   private   10.130.5.78    mex01   ingress:350/ingress-auth:192*
    public-crb110acca09414e88a44227b87576ceea-alb1    enabled   public    169.57.1.110   mex01   ingress:350/ingress-auth:192*

    * 有 ALB Pod 的更新可供使用。在更新之前，請檢查最新版本的任何可能的非連續變更：https://console.bluemix.net/docs/containers/cs_cluster_update.html#alb
    ```
    {: screen}

您可以使用下列方式，管理 Ingress ALB 附加程式的自動更新。**附註**：若要執行下列指令，您必須具有叢集的[**編輯者**或**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](cs_users.html#platform)。
* 停用自動更新。
    ```
    ibmcloud ks alb-autoupdate-disable --cluster <cluster_name_or_ID>
    ```
    {: pre}
* 手動更新 Ingress ALB 附加程式。
    1. 如果有可用的更新項目，且您要更新附加程式，請先檢查[最新版 Ingress ALB 附加程式的變更日誌](cs_versions_addons.html#alb_changelog)，以驗證任何可能的非連續變更。
    2. 強制一次性更新 ALB Pod。叢集中的所有 ALB Pod 都會更新至最新的建置版本。您無法更新個別 ALB，也無法選擇要將附加程式更新至哪個建置。自動更新會保留停用狀態。
        ```
        ibmcloud ks alb-update --cluster <cluster_name_or_ID>
        ```
        {: pre}
* 如果您的 ALB Pod 最近已更新，但 ALB 自訂配置受到最新建置的影響，您可以將更新回復至您的 ALB Pod 先前執行的建置。**附註**：在回復更新之後，會停用 ALB Pod 的自動更新。
    ```
    ibmcloud ks alb-rollback --cluster <cluster_name_or_ID>
    ```
    {: pre}
* 重新啟用自動更新。每當下一個建置變成可用時，ALB Pod 就會自動更新至最新的建置。
        ```
        ibmcloud ks alb-autoupdate-enable --cluster <cluster_name_or_ID>
        ```
        {: pre}

<br />


## 從獨立式工作者節點更新至工作者節點儲存區
{: #standalone_to_workerpool}

引進多區域叢集時，在工作者節點儲存區中，具有相同配置（例如機型）的工作者節點會群組在一起。當您建立新的叢集時，會自動建立名為 `default` 的工作者節點儲存區。
{: shortdesc}

您可以使用工作者節點儲存區將工作者節點平均分散到各區域，以及建置平衡叢集。平衡叢集具備高可用性以及更大的失敗復原力。如果從區域移除工作者節點，則您可以重新平衡工作者節點儲存區，以及自動將新的工作者節點佈建至該區域。工作者節點儲存區也用來安裝所有工作者節點的 Kubernetes 版本更新。  

如果您已在多區域叢集變成可用之前建立叢集，則工作者節點仍然是獨立式的，並且不會自動群組到工作者節點儲存區。您必須更新這些叢集，才能使用工作者節點儲存區。如果未更新，則無法將單一區域叢集變更為多區域叢集。
{: important}

請檢閱下圖，以查看從獨立式工作者節點移至工作者節點儲存區時，叢集設定如何變更。

<img src="images/cs_cluster_migrate.png" alt="將叢集從獨立式工作者節點更新為工作者節點儲存區" width="600" style="width:600px; border-style: none"/>

開始之前：
- 確定您具有叢集的[**操作員**或**管理者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色](cs_users.html#platform)。
- [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

1. 列出叢集裡的現有獨立式工作者節點，並記下 **ID**、**機型**及**專用 IP**。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

2. 建立工作者節點儲存區，並決定您要新增至儲存區的機型及工作者節點數目。
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

3. 列出可用的區域，並決定要在哪裏佈建工作者節點儲存區中的工作者節點。若要檢視在其中佈建獨立式工作者節點的區域，請執行 `ibmcloud ks cluster-get <cluster_name_or_ID>`。如果您要將工作者節點分散到多個區域，請選擇[具有多區域功能的區域](cs_regions.html#zones)。
   ```
   ibmcloud ks zones
   ```
   {: pre}

4. 列出您在前一個步驟中選擇的區域的可用 VLAN。如果您在該區域中還沒有 VLAN，則會在將區域新增至工作者節點儲存區時自動為您建立 VLAN。
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

5. 將區域新增至工作者節點儲存區。當您將區域新增至工作者節點儲存區時，會在區域中佈建工作者節點儲存區中所定義的工作者節點，並考慮用於排定未來的工作負載。{{site.data.keyword.containerlong}} 會自動將地區的 `failure-domain.beta.kubernetes.io/region` 標籤以及區域的 `failure-domain.beta.kubernetes.io/zone` 標籤新增至每一個工作者節點。Kubernetes 排程器使用這些標籤，以將 Pod 分散到相同地區內的區域。
   1. **將區域新增至某個工作者節點儲存區**：將 `<pool_name>` 取代為工作者節點儲存區名稱，並使用您先前擷取到的資訊填入叢集 ID、區域及 VLAN。如果您在該區域中沒有專用及公用 VLAN，請不要指定此選項。會自動為您建立專用及公用 VLAN。

      如果您要對不同的工作者節點儲存區使用不同的 VLAN，則請針對每一個 VLAN 及其對應工作者節點儲存區重複這個指令。任何新的工作者節點都會新增至您指定的 VLAN，但不會變更任何現有工作者節點的 VLAN。
      ```
      ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   2. **將區域新增至多個工作者節點儲存區**：將多個工作者節點儲存區新增至 `ibmcloud ks zone-add` 指令。若要將多個工作者節點儲存區新增至區域，您在該區域中必須要有現有專用及公用 VLAN。如果您在該區域中沒有公用及專用 VLAN，請考慮先將該區域新增至一個工作者節點儲存區，以為您建立公用及專用 VLAN。然後，您可以將該區域新增至其他工作者節點儲存區。</br></br>請務必將所有工作者節點儲存區中的工作者節點佈建至所有區域，以確保您的叢集在各區域之間保持平衡。如果您要對不同的工作者節點儲存區使用不同的 VLAN，則請針對要用於工作者節點儲存區的 VLAN 重複這個指令。如果一個叢集具有多個 VLAN，相同的 VLAN 上具有多個子網路，或多個區域叢集，您必須針對 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓您的工作者節點可在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。若要檢查是否已啟用 VLAN Spanning，請使用 `ibmcloud ks vlan-spanning-get` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果您使用 {{site.data.keyword.BluDirectLink}}，則必須改用[虛擬路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。若要啟用 VRF，請聯絡 IBM Cloud 基礎架構 (SoftLayer) 客戶業務代表。
      ```
      ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name1,pool_name2,pool_name3> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   3. **將多個區域新增至工作者節點儲存區**：向不同的區域重複 `ibmcloud ks zone-add` 指令，並指定您要在該區域中佈建的工作者節點儲存區。將其他區域新增至叢集，即可將叢集從單一區域叢集變更為[多區域叢集](cs_clusters_planning.html#multizone)。

6. 等待在每個區域中部署工作者節點。
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}
   工作者節點狀況變更為**正常**時，部署已完成。

7. 移除獨立式工作者節點。如果您有多個獨立式工作者節點，請一次移除一個。
   1. 列出叢集裡的工作者節點，並比較這個指令中的專用 IP 位址與開始尋找獨立式工作者節點時所擷取的專用 IP 位址。
      ```
      kubectl get nodes
      ```
      {: pre}
   2. 在一個稱為隔離的處理程序中，將工作者節點標示為無法排程。當您隔離工作者節點時，會使它無法用於未來 Pod 排程。使用 `kubectl get nodes` 指令中傳回的 `name`。
      ```
      kubectl cordon <worker_name>
      ```
      {: pre}
   3. 驗證已停用工作者節點的 Pod 排程。
      ```
      kubectl get nodes
      ```
      {: pre}
      如果狀態顯示 **SchedulingDisabled**，表示工作者節點已停用 Pod 排程。
   4. 強制從獨立式工作者節點移除 Pod，並將其重新排定至其餘 uncordon 處理過的獨立式工作者節點以及工作者節點儲存區中的工作者節點。
      ```
      kubectl drain <worker_name> --ignore-daemonsets
      ```
      {: pre}
      此處理程序可能需要幾分鐘的時間。

   5. 移除獨立式工作者節點。使用利用 `ibmcloud ks workers <cluster_name_or_ID>` 指令擷取到的工作者節點 ID。
      ```
      ibmcloud ks worker-rm <cluster_name_or_ID> <worker_ID>
      ```
      {: pre}
   6. 重複這些步驟，直到移除所有獨立式工作者節點。


**下一步為何？**
</br>
既然您已將叢集更新成使用工作者節點儲存區，則可以藉由將其他區域新增至叢集來改善可用性。將其他區域新增至叢集，即可將叢集從單一區域叢集變更為[多區域叢集](cs_clusters_planning.html#ha_clusters)。當您將單一區域叢集變更為多區域叢集時，Ingress 網域會從 `<cluster_name>.<region>.containers.mybluemix.net` 變更為 `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`。現有 Ingress 網域仍然有效，而且可以用來將要求傳送至應用程式。

<br />


## 將叢集 DNS 提供者設為 CoreDNS
{: #dns}

叢集中的每個服務都會獲指派「網域名稱系統 (DNS)」名稱，而叢集 DNS 提供者會登錄此名稱，以解析 DNS 要求。預設叢集 DNS 提供者為 Kubernetes DNS (KubeDNS)。不過，對於執行 Kuberneges 1.12 版或更新版本的叢集，您可以改為選擇使用 [CoreDNS ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://coredns.io/)。您可能會使用 CoreDNS 作為早期採用者，或在 Kubernetes 專案移動，以將 KubeDNS 取代為 CoreDNS 時，測試出潛在的影響。如需服務和 Pod 之 DNS 的相關資訊，請參閱 [ Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)。
{: shortdesc}

開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

1.  判定現行叢集 DNS 提供者。在下列範例中，KubeDNS 是現行叢集 DNS 提供者。
    ```
    kubectl cluster-info
    ```
    {: pre}

輸出範例：
        ```
    ...
    KubeDNS is running at https://c2.us-south.containers.cloud.ibm.com:20190/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ...
    ```
    {: screen}
2.  將 CoreDNS 設為叢集 DNS 提供者。

    1.  **選用**：如果您已在 `koky-system` 名稱空間中自訂 `kuxed-dns` ConfigMap，請將任何自訂作業傳送至 `kube-system` 名稱空間中的 `coredfns` ConfigMap。請注意，語法不同於 `kube-dns` 和 `coredns` ConfigMap。如需範例，請參閱 CoreDNS 文件中的[透過 Kubeadm 安裝 CoreDNS ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://coredns.io/2018/05/21/migration-from-kube-dns-to-coredns/)。

    2.  縮減 KubeDNS autoscaler 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=0 kube-dns-autoscaler
        ```
        {: pre}

    3.  檢查並等待刪除 Pod。
        ```
        kubectl get pods -n kube-system -l k8s-app=kube-dns-autoscaler
        ```
        {: pre}

    4.  縮減 KubeDNS 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
        ```
        {: pre}

    5.  擴增 CoreDNS autoscaler 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
        ```
        {: pre}

    6.  標示並註釋 CoreDNS 的叢集 DNS 服務。
        ```
        kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=CoreDNS
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port=9153
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape=true
        ```
        {: pre}
3.  **選用**：反轉先前的步驟，以切換回 KebeDNS 作為叢集 DNS 提供者。

    1.  **選用**：如果您已在 `koky-system` 名稱空間中自訂 `coredns` ConfigMap，請將任何自訂作業傳送至 `kube-system` 名稱空間中的 `kube-dns` ConfigMap。請注意，語法不同於 `kube-dns` 和 `coredns` ConfigMap。如需範例，請參閱 CoreDNS 文件中的[透過 Kubeadm 安裝 CoreDNS ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://coredns.io/2018/05/21/migration-from-kube-dns-to-coredns/)。

    2.  縮減 CoreDNS autoscaler 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=0 coredns-autoscaler
        ```
        {: pre}

    3.  檢查並等待刪除 Pod。
        ```
        kubectl get pods -n kube-system -l k8s-app=coredns-autoscaler
        ```
        {: pre}

    4.  縮減 CoreDNS 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=0 coredns
        ```
        {: pre}

    5.  擴增 KubeDNS autoscaler 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
        ```
        {: pre}

    6.  標示並註釋 KubeDNS 的叢集 DNS 服務。
        ```
        kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=KubeDNS
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port-
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape-
        ```
        {: pre}
