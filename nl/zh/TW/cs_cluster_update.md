---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 更新叢集和工作者節點
{: #update}

## 更新 Kubernetes 主節點
{: #master}

Kubernetes 會定期發表更新。這可能是[主要、次要或修補程式更新](cs_versions.html#version_types)。視更新的類型而定，您可能要負責更新您的 Kubernetes 主節點。您一律要負責將工作者節點保持為最新。在更新時，Kubernetes 主節點會比工作者節點先更新。
{:shortdesc}

依預設，我們將您限制為不能將 Kibernetes 主節點更新超過您的現行版本兩個次要版本。例如，如果您的現行主節點是 1.5 版，而您要更新至 1.8，則必須先更新至 1.7。您可以強制發生更新，但更新超過兩個次要版本可能會造成非預期的結果。

下圖顯示您可以採取來更新主節點的處理程序。

![主節點更新最佳作法](/images/update-tree.png)

圖 1. 更新 Kubernetes 主節點程序圖

**注意**：更新程序發生之後，您便無法將叢集回復至舊版。請務必使用測試叢集，並遵循指示來解決可能的問題，然後才更新正式作業主節點。

對於_主要_ 或_次要_ 更新，請完成下列步驟：

1. 檢閱 [Kubernetes 變更](cs_versions.html)，並更新標示為_在主節點之前更新_ 的任何項目。
2. 使用 GUI 或執行 [CLI 指令](cs_cli_reference.html#cs_cluster_update)來更新 Kubernetes 主節點。當您更新 Kubernetes 主節點時，主節點會關閉大約 5 - 10 分鐘。在更新期間，您無法存取或變更叢集。不過，叢集使用者部署的工作者節點、應用程式和資源不會修改，並將繼續執行。
3. 確認更新已完成。在 {{site.data.keyword.Bluemix_notm}} 儀表板上檢閱 Kubernetes 版本，或執行 `bx cs clusters`。

當 Kubernetes 主節點更新完成時，您可以更新工作者節點。

<br />


## 更新工作者節點
{: #worker_node}

您收到了更新工作者節點的通知。這代表什麼意思？您的資料儲存在工作者節點內的 Pod 裡。Kubernetes 主節點的安全更新和修補程式就緒之後，您需要確定您的工作者節點保持同步。工作者節點主節點不得高過 Kubernetes 主節點。
{: shortdesc}

<ul>**注意**：</br>
<li>更新工作者節點可能會導致應用程式及服務關閉。</li>
<li>如果資料未儲存在 Pod 外，便會刪除資料。</li>
<li>在您的部署中，使用[抄本 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas)，在可用節點上重新排定 Pod。</li></ul>

但如果我不能有任何關閉時間怎麼辦？

在更新程序中，特定節點會關閉一段時間。要協助避免應用程式的關閉時間，您可以在配置對映定義唯一索引鍵，該配置對映指定在升級程序期間，特定節點類型的臨界值百分比。藉由根據標準 Kubernetes 標籤來定義規則，以及提供允許無法使用的最大節點量百分比，您可以確保您的應用程式維持啟動與執行。如果節點尚未完成部署程序，會將它視為無法使用。

索引鍵如何定義？

在配置對映中，有一個區段會包含資料資訊。您可以定義最多 10 個不同規則，以在任何給定時間執行。要讓工作者節點升級，節點必須通過對映中定義的每個規則。

索引鍵定義好了。現在該怎麼做？

定義規則之後，請執行 worker-upgrade 指令。如果傳回成功的回應，工作者節點會排入佇列以便升級。不過，在所有規則都滿足之前，節點不會經歷升級程序。排入佇列時，會依照間隔檢查規則，查看是否有任何節點能夠升級。

我選擇不要定義配置對映的話會怎樣？

未定義配置對映時，會使用預設值。依預設，在每個叢集中，您所有的工作者節點會有最多 20% 在更新程序期間無法使用。

若要更新您的工作者節點，請執行下列動作：

1. 安裝符合 Kubernetes 主節點之 Kubernetes 版本的 [`kibectl cli` ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 版本。

2. 進行 [Kubernetes 變更](cs_versions.html)中標示為_在主節點之後更新_ 的任何變更。

3. 選用項目：定義您的配置對映。
    範例：

    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 70,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
         "NodeSelectorValue": "dal13"
       }
     regioncheck.json: |
       {
         "MaxUnavailablePercentage": 80,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
         "NodeSelectorValue": "us-south"
       }
    ...
     defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 100
       }
    ```
    {:pre}
  <table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為參數，第二欄則為符合的說明。">
    <thead>
      <th colspan=2><img src="images/idea.png"/> 瞭解元件</th>
    </thead>
    <tbody>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td> 依預設，如果 ibm-cluster-update-configuration 對映未以有效的方式定義，則您的叢集在同一時間只能有 20% 無法使用。如果有一個以上的有效規則未定義廣域預設值，則新的預設值是允許在同一時間有 100% 的工作者節點無法使用。您可以建立預設百分比來控制此情況。</td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td> 您要為其設定規則的唯一索引鍵範例。索引鍵的名稱可以是您要的任何內容，索引鍵內的配置集會剖析資訊。針對您定義的每個索引鍵，您只能為 <code>NodeSelectorKey</code> 和 <code>NodeSelectorValue</code> 設定一個值。如果您想要為多個地區（或位置、資料中心）設定規則，請建立新的索引鍵項目。</td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td> 針對指定索引鍵，允許無法使用的節點量上限，以百分比的格式指定。當節點在部署、重新載入或佈建的程序中，便無法使用該節點。已排入佇列的工作者節點，如果超出任何已定義的可用百分比上限，便會被封鎖而無法升級。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td> 您要為指定索引鍵設定規則的標籤類型。您可以為 IBM 提供的預設標籤設定規則，也可以為您建立的標籤設定規則。</td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td> 指定索引鍵內，規則已設定要評估的節點子集。</td>
      </tr>
    </tbody>
  </table>

    **附註**：最多可以定義 10 個規則。如果您新增超過 10 個索引鍵到一個檔案裡，則只會剖析部分的資訊。

3. 從 GUI 或藉由執行 CLI 指令更新您的工作者節點。
  * 若要從 {{site.data.keyword.Bluemix_notm}} 儀表板更新，請導覽至叢集的`工作者節點`區段，然後按一下`更新工作者`。
  * 若要取得工作者節點 ID，請執行 `bx cs wokers<cluster_name_or_id>`。如果您選取多個工作者節點，則工作者節點會放入佇列以便進行更新評估。如果評估之後認為它們已就緒，則會根據配置中的規則來更新。

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. 選用項目：執行下列指令並查看 **Events** 以驗證配置對映所觸發的事件，以及發生的任何驗證錯誤。
    ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
    {: pre}

5. 確認更新已完成：
  * 在 {{site.data.keyword.Bluemix_notm}} 儀表板上檢閱 Kubernetes 版本，或執行 `bx cs workers<cluster_name_or_id>`。
  * 執行 `kudectl get nodes` 來檢閱工作者節點的 Kibernets 版本。
  * 在部分情況下，較舊的叢集可能在更新之後將重複的工作者節點列為 **NotReady** 狀態。若要移除重複項目，請參閱[疑難排解](cs_troubleshoot.html#cs_duplicate_nodes)。

後續步驟：
  - 對其他叢集重複更新程序。
  - 通知在叢集內工作的開發人員，將 `kubectl` CLI 更新至 Kubernetes 主節點的版本。
  - 如果 Kubernetes 儀表板未顯示使用率圖形，則會[刪除 `kudbe-dashboard` Pod](cs_troubleshoot.html#cs_dashboard_graphs)。
<br />

