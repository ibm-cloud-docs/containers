---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# 將資料儲存在 IBM Block Storage for IBM Cloud
{: #block_storage}


## 在您的叢集裡安裝 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式
{: #install_block}

安裝 {{site.data.keyword.Bluemix_notm}}Block Storage 外掛程式與 Helm 圖表，以設定區塊儲存空間的預先定義儲存空間類別。您可以使用這些儲存空間類別來建立 PVC ，以佈建應用程式的區塊儲存空間。
{: shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要在其中安裝 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式的叢集。


1. 遵循[指示](cs_integrations.html#helm)，將 Helm 用戶端安裝在您的本端機器上、將 Helm 伺服器 (tiller) 安裝在您的叢集中，並且將 {{site.data.keyword.Bluemix_notm}} Helm 圖表儲存庫新增至您要在其中使用 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式的叢集中。

   **重要事項：**如果您使用的是 Helm 2.9 版或更新版本，請確定您已使用[服務帳戶](cs_integrations.html#helm)來安裝 tiller。

2. 更新 Helm 報告，以擷取此儲存庫中所有 Helm 圖表的最新版本。
   ```
   helm repo update
   ```
   {: pre}

3. 安裝 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式。安裝外掛程式時，會將預先定義的區塊儲存空間類別新增至叢集。
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   輸出範例：
   ```
   NAME:   bald-olm
   LAST DEPLOYED: Wed Apr 18 10:02:55 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1beta1/DaemonSet
   NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

   ==> v1beta1/Deployment
   NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-block-storage-plugin  1        0        0           0          0s

   ==> v1/StorageClass
   NAME                      PROVISIONER        AGE
   ibmc-block-bronze         ibm.io/ibmc-block  0s
   ibmc-block-custom         ibm.io/ibmc-block  0s
   ibmc-block-gold           ibm.io/ibmc-block  0s
   ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
   ibmc-block-retain-custom  ibm.io/ibmc-block  0s
   ibmc-block-retain-gold    ibm.io/ibmc-block  0s
   ibmc-block-retain-silver  ibm.io/ibmc-block  0s
   ibmc-block-silver         ibm.io/ibmc-block  0s

   ==> v1/ServiceAccount
   NAME                           SECRETS  AGE
   ibmcloud-block-storage-plugin  1        0s

   ==> v1beta1/ClusterRole
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   ==> v1beta1/ClusterRoleBinding
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   NOTES:
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. 驗證安裝是否成功。
   ```
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   輸出範例：
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   當您看到一個 `ibmcloud-block-storage-plugin` Pod 及一個以上 `ibmcloud-block-storage-driver` Pod 時，安裝即成功。`ibmcloud-block-storage-driver` Pod 的數目等於叢集裡的工作者節點數目。所有 Pod 都必須處於 **Running** 狀況。

5. 驗證區塊儲存空間的儲存空間類別是否已新增至叢集。
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   輸出範例：
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. 對於您要在其中佈建區塊儲存空間的每一個叢集重複這些步驟。

現在，您可以繼續[建立一個 PVC](#add_block)，佈建應用程式的區塊儲存空間。


### 更新 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式
您可以將現有的 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式升級至最新版本。
{: shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為叢集。

1. 更新 Helm 報告，以擷取此儲存庫中所有 Helm 圖表的最新版本。
   ```
   helm repo update
   ```
   {: pre}

2. 選用項目：將最新的 Helm 圖表下載至您的本端機器。然後，解壓縮套件並檢閱 `release.md` 檔案，以尋找最新版本資訊。
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. 尋找您已在叢集裡安裝之區塊儲存空間 Helm 圖表的名稱。
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   輸出範例：
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. 將 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式升級至最新版本。
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. 選用項目：更新外掛程式時，會取消設定 `default` 儲存空間類別。如果您要將預設儲存空間類別設為您選擇的儲存空間類別，請執行下列指令。
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### 移除 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式
如果您不想要在叢集裡佈建及使用 {{site.data.keyword.Bluemix_notm}} Block Storage，則可以解除安裝 Helm 圖表。
{: shortdesc}

**附註：**移除外掛程式不會移除現有的 PVC、PV 或資料。移除外掛程式時，會從叢集裡移除所有相關的 Pod 及常駐程式集。在移除外掛程式之後，您無法針對叢集佈建新的區塊儲存空間，也無法使用現有的區塊儲存空間 PVC 及 PV。

開始之前：
- [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集。
- 確定叢集裡沒有任何 PVC 或 PV 使用區塊儲存空間。

若要移除外掛程式，請執行下列動作：

1. 尋找您已在叢集裡安裝之區塊儲存空間 Helm 圖表的名稱。
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   輸出範例：
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. 刪除 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式。
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. 驗證是否已移除區塊儲存空間 Pod。
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   如果 CLI 輸出中沒有顯示任何 Pod，則表示已順利移除 Pod。

4. 驗證是否已移除區塊儲存空間的儲存空間類別。
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   如果 CLI 輸出中沒有顯示任何儲存空間類別，則表示已順利移除儲存空間類別。

<br />



## 決定區塊儲存空間配置
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} 為區塊儲存空間提供預先定義的儲存空間類別，您可以使用此類別搭配特定配置來佈建區塊儲存空間。
{: shortdesc}

每個儲存空間類別都會指定您佈建的區塊儲存空間類型，包括可用的大小、IOPS、檔案系統及保留原則。  

**重要事項：**請務必小心選擇您的儲存空間配置，使其具有足夠的容量來儲存您的資料。在使用儲存空間類別佈建特定類型的儲存空間之後，您就無法變更儲存裝置的大小、類型、IOPS 或保留原則。如果您需要更多儲存空間或具有不同配置的儲存空間，則必須[建立新的儲存空間實例，並將資料](cs_storage_basics.html#update_storageclass)從舊的儲存空間實例複製到新的儲存空間實例。

1. 列出 {{site.data.keyword.containerlong}} 中可用的儲存空間類別。
    ```
   kubectl get storageclasses | grep block
   ```
    {: pre}

    輸出範例：
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-block-custom            ibm.io/ibmc-block
    ibmc-block-bronze            ibm.io/ibmc-block
    ibmc-block-gold              ibm.io/ibmc-block
    ibmc-block-silver            ibm.io/ibmc-block
    ibmc-block-retain-bronze     ibm.io/ibmc-block
    ibmc-block-retain-silver     ibm.io/ibmc-block
    ibmc-block-retain-gold       ibm.io/ibmc-block
    ibmc-block-retain-custom     ibm.io/ibmc-block
    ```
    {: screen}

2. 檢閱儲存空間類別的配置。
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   如需每一個儲存空間類別的相關資訊，請參閱[儲存空間類別參照](#storageclass_reference)。如果您找不到要尋找的項目，請考慮建立自己的自訂儲存空間類別。若要開始使用，請參閱[自訂的儲存空間類別範例](#custom_storageclass)。
   {: tip}

3. 選擇您要佈建的區塊儲存空間的類型。
   - **銅級、銀級和金級儲存空間類別：**這些儲存空間類別會佈建[耐久性儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/endurance-storage)。耐久性儲存空間可讓您在預先定義的 IOPS 層級選擇儲存空間的大小（以 GB 為單位）。
   - **自訂儲存空間類別：**此儲存空間類別會佈建[效能儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/performance-storage)。使用效能儲存空間，您更能控制儲存空間大小及 IOPS。

4. 選擇區塊儲存空間的大小及 IOPS。大小及 IOPS 數目定義 IOPS（每秒的輸入/輸出作業數）總數，此 IOPS 可作為儲存空間有多快的指示器。您的儲存空間的 IOPS 總數越大，其處理讀取及寫入作業的速度就越快。
   - **銅級、銀級和金級儲存空間類別：**這些儲存空間類別隨附每 GB 固定數目的 IOPS，並佈建在 SSD 硬碟上。IOPS 總數取決於您選擇的儲存空間大小。您可以選取所容許大小範圍內的任何整數的 GB 大小，例如 20 Gi、256 Gi 或 11854 Gi。若要決定 IOPS 總數，您必須將 IOPS 乘以選取的大小。例如，如果您在隨附每 GB 4 個 IOPS 的銀級儲存空間類別中選取 1000Gi 區塊儲存空間大小，則您的儲存空間總共有 4000 個 IOPS。  
     <table>
         <caption>儲存空間類別大小範圍及每 GB IOPS 數目的表格</caption>
         <thead>
         <th>儲存空間類別</th>
         <th>每 GB 的 IOPS 數目</th>
         <th>大小範圍（以 GB 為單位）</th>
         </thead>
         <tbody>
         <tr>
         <td>銅級</td>
         <td>2 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>銀級</td>
         <td>4 IOPS/GB</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>金級</td>
         <td>10 IOPS/GB</td>
         <td>20-4000 Gi</td>
         </tr>
         </tbody></table>
   - **自訂儲存空間類別：**當您選擇此儲存空間類別時，更能控制您想要的大小及 IOPS。對於大小，您可以選取所容許大小範圍內的任何整數的 GB 大小。您選擇的大小決定了可供您使用的 IOPS 範圍。您可以選擇在指定範圍內的 100 的倍數的 IOPS。您選擇的 IOPS 是靜態的，不會隨著儲存空間大小一起調整。例如，如果您選擇具有 100 IOPS 的 40Gi，則 IOPS 總數會保留 100。</br></br>IOPS 與 GB 的比例也會決定為您佈建之硬碟的類型。例如，如果您有 100 IOPS 的 500Gi，則您的 IOPS 與 GB 的比例為 0.2。比例小於或等於 0.3 的儲存空間會佈建在 SATA 硬碟上。如果您的比例大於 0.3，則您的儲存空間會佈建在 SSD 硬碟上。
     <table>
         <caption>自訂儲存空間類別大小範圍及 IOPS 的表格</caption>
         <thead>
         <th>大小範圍（以 GB 為單位）</th>
         <th>IOPS 範圍（以 100 的倍數表示）</th>
         </thead>
         <tbody>
         <tr>
         <td>20-39 Gi</td>
         <td>100-1000 IOPS</td>
         </tr>
         <tr>
         <td>40-79 Gi</td>
         <td>100-2000 IOPS</td>
         </tr>
         <tr>
         <td>80-99 Gi</td>
         <td>100-4000 IOPS</td>
         </tr>
         <tr>
         <td>100-499 Gi</td>
         <td>100-6000 IOPS</td>
         </tr>
         <tr>
         <td>500-999 Gi</td>
         <td>100-10000 IOPS</td>
         </tr>
         <tr>
         <td>1000-1999 Gi</td>
         <td>100-20000 IOPS</td>
         </tr>
         <tr>
         <td>2000-2999 Gi</td>
         <td>200-40000 IOPS</td>
         </tr>
         <tr>
         <td>3000-3999 Gi</td>
         <td>200-48000 IOPS</td>
         </tr>
         <tr>
         <td>4000-7999 Gi</td>
         <td>300-48000 IOPS</td>
         </tr>
         <tr>
         <td>8000-9999 Gi</td>
         <td>500-48000 IOPS</td>
         </tr>
         <tr>
         <td>10000-12000 Gi</td>
         <td>1000-48000 IOPS</td>
         </tr>
         </tbody></table>

5. 選擇是否要在刪除叢集或持續性磁區要求 (PVC) 之後保留您的資料。
   - 如果要保留資料，則請選擇 `retain` 儲存空間類別。當您刪除 PVC 時，只會刪除 PVC。PV、IBM Cloud 基礎架構 (SoftLayer) 帳戶中的實體儲存裝置，以及您的資料仍然存在。若要收回儲存空間，並再次在您的叢集裡使用它，您必須移除 PV，並遵循[使用現有區塊儲存空間](#existing_block)的步驟。
   - 如果您想要在刪除 PVC 時一併刪除 PV、資料及實體區塊儲存裝置，請選擇沒有 `retain` 的儲存空間類別。

6. 選擇您要按小時還是按月計費。如需相關資訊，請檢查[定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/block-storage/pricing)。依預設，所有區塊儲存裝置都是搭配每小時計費類型進行佈建。

<br />



## 將區塊儲存空間新增至應用程式
{: #add_block}

建立持續性磁區要求 (PVC)，為叢集[動態佈建](cs_storage_basics.html#dynamic_provisioning)區塊儲存空間。動態佈建會自動建立相符的持續性磁區 (PV)，並以 IBM Cloud 基礎架構 (SoftLayer) 帳戶訂購實際的儲存裝置。
{:shortdesc}

**重要事項**：區塊儲存空間隨附一個 `ReadWriteOnce` 存取模式。您一次只能將它裝載到叢集裡一個工作者節點上的一個 Pod。

開始之前：
- 如果您有防火牆，請對叢集所在區域的 IBM Cloud 基礎架構 (SoftLayer) IP 範圍[容許進行 Egress 存取](cs_firewall.html#pvc)，這樣您才可以建立 PVC。
- 安裝 [{{site.data.keyword.Bluemix_notm}} 區塊儲存空間外掛程式](#install_block)。
- [決定預先定義的儲存空間類別](#predefined_storageclass)或建立[自訂的儲存空間類別](#custom_storageclass)。

若要新增區塊儲存空間，請執行下列動作：

1.  建立配置檔來定義持續性磁區要求 (PVC)，以及將配置儲存為 `.yaml` 檔案。

    -  **銅級、銀級、金級儲存空間類別的範例**：下列 `.yaml` 檔案會建立一個名為 `mypvc` 的要求，其儲存空間類別為 `"ibmc-block-silver"`，計費方式為 `"hourly"`，GB 大小為 `24Gi`。

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-silver"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **使用自訂儲存空間類別的範例**：下列 `.yaml` 檔案會建立一個名為 `mypvc` 的要求，其儲存空間類別為 `ibmc-block-retain-custom`，計費方式為 `"hourly"`，GB 大小為 `45Gi`，IOPS 為 `"300"`。

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-retain-custom"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 45Gi
             iops: "300"
        ```
        {: codeblock}

        <table>
        <caption>瞭解 YAML 檔案元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>輸入 PVC 名稱。</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>您要用來佈建區塊儲存空間之儲存空間類別的名稱。</br> 如果您未指定儲存空間類別，則會建立預設儲存空間類別為 <code>ibmc-file-bronze</code> 的 PV。<p>**提示：**如果您要變更預設儲存空間類別，請執行 <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code>，並將 <code>&lt;storageclass&gt;</code> 取代為儲存空間類別的名稱。</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>指定計算儲存空間費用的頻率為 "monthly" 或 "hourly"。預設值為 "hourly"。</td>
        </tr>
	<tr>
	<td><code>metadata/labels/region</code></td>
        <td>指定您要在其中佈建區塊儲存空間的地區。如果指定地區，則也須指定區域。如果未指定地區或找不到指定的地區，則會在與叢集相同的地區中建立儲存空間。</br><strong>附註：</strong>僅 IBM Cloud Block Storage 外掛程式 1.0.1 版或更新版本支援此選項。對於較舊的外掛程式版本，如果您有多區域叢集，則會根據循環式基準選取儲存空間佈建所在的區域，以在所有區域均勻地平衡磁區要求。如果要為您的儲存空間指定區域，請先建立[自訂的儲存空間類別](#multizone_yaml)。然後，使用自訂的儲存空間類別建立 PVC。</td>
	</tr>
	<tr>
	<td><code>metadata/labels/zone</code></td>
	<td>指定您要在其中佈建區塊儲存空間的區域。如果指定區域，則也須指定地區。如果未指定區域或找不到指定的區域，則會根據循環式基準選取區域。</br><strong>附註：</strong>僅 IBM Cloud Block Storage 外掛程式 1.0.1 版或更新版本支援此選項。對於較舊的外掛程式版本，如果您有多區域叢集，則會根據循環式基準選取儲存空間佈建所在的區域，以在所有區域均勻地平衡磁區要求。如果要為您的儲存空間指定區域，請先建立[自訂的儲存空間類別](#multizone_yaml)。然後，使用自訂的儲存空間類別建立 PVC。</td>
	</tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>輸入區塊儲存空間大小，以 GB 為單位 (Gi)。</br></br><strong>附註：</strong>在佈建儲存空間之後，您無法變更區塊儲存空間的大小。請確定指定符合您要儲存的資料量的大小。</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>此選項僅供自訂儲存空間類別使用 (`ibmc-block-custom / ibmc-block-retain-custom`)。選取容許範圍內的 100 的倍數，來指定儲存空間的 IOPS 總數。如果您選擇的 IOPS 不是所列出的 IOPS，則會將 IOPS 無條件進位。</td>
        </tr>
        </tbody></table>

    如果您要使用自訂的儲存空間類別，則請建立具有對應儲存空間類別名稱、有效 IOPS 及大小的 PVC。   
    {: tip}

2.  建立 PVC。

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  驗證您的 PVC 已建立並已連結至 PV。此處理程序可能需要幾分鐘的時間。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    輸出範例：

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     

    ```
    {: screen}

4.  {: #app_volume_mount}若要將 PV 裝載至部署，請建立配置 `.yaml` 檔，並指定連結 PV 的 PVC。

    ```
apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <caption>瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>部署的標籤。</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>應用程式的標籤。</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>部署的標籤。</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>您要使用的映像檔的名稱。若要列出 {{site.data.keyword.registryshort_notm}} 帳戶中的可用映像檔，請執行 `ibmcloud cr image-list`。</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>您要部署至叢集的容器的名稱。</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>容器內裝載磁區之目錄的絕對路徑。寫入裝載路徑的資料儲存在實體檔案儲存空間實例的根目錄下。若要在實體檔案儲存空間實例中建立目錄，您必須在裝載路徑中建立子目錄。</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>要裝載至 Pod 之磁區的名稱。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>要裝載至 Pod 之磁區的名稱。此名稱通常與 <code>volumeMounts/name</code> 相同。</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>連結您要使用之 PV 的 PVC 名稱。</td>
    </tr>
    </tbody></table>

5.  建立部署。
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  驗證已順利裝載 PV。

     ```
     kubectl describe deployment <deployment_name>
     ```
     {: pre}

     裝載點在 **Volume Mounts**（磁區裝載）欄位中，而磁區在 **Volumes**（磁區）欄位中。

     ```
      Volume Mounts:
           /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
           /volumemount from myvol (rw)
     ...
     Volumes:
       myvol:
         Type:	PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
         ClaimName:	mypvc
         ReadOnly:	false
     ```
     {: screen}

<br />




## 在叢集裡使用現有的區塊儲存空間
{: #existing_block}

如果您具有想要在叢集裡使用的現有實體儲存裝置，則可以手動建立 PV 及 PVC，以[靜態佈建](cs_storage_basics.html#static_provisioning)儲存空間。

在可以開始將現有儲存空間裝載至應用程式之前，您必須擷取所有適用於 PV 的必要資訊。  
{: shortdesc}

### 步驟 1：擷取現有區塊儲存空間的資訊

1.  擷取或產生 IBM Cloud 基礎架構 (SoftLayer) 帳戶的 API 金鑰。
    1. 登入 [IBM Cloud 基礎架構 (SoftLayer) 入口網站 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://control.bluemix.net/)。
    2. 依序選取**帳戶**、**使用者**、**使用者清單**。
    3. 尋找您的使用者 ID。
    4. 在**API 金鑰**直欄中，按一下**產生**以產生 API 金鑰，或按一下**檢視**以檢視現有的 API 金鑰。
2.  擷取 IBM Cloud 基礎架構 (SoftLayer) 帳戶的 API 使用者名稱。
    1. 從**使用者清單**功能表中，選取您的使用者 ID。
    2. 在 **API 存取資訊**區段中，尋找您的 **API 使用者名稱**。
3.  登入 IBM Cloud 基礎架構 CLI 外掛程式。
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  選擇使用 IBM Cloud 基礎架構 (SoftLayer) 帳戶的使用者名稱及 API 金鑰來進行鑑別。
5.  輸入您在先前步驟中擷取的使用者名稱及 API 金鑰。
6.  列出可用的區塊儲存裝置。
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    輸出範例：
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  記下您要裝載至叢集之區塊儲存裝置的 `id`、`ip_addr`、`capacity_gb`、`datacenter` 及 `lunId`。**附註：**若要將現有儲存空間裝載至叢集，您必須在與儲存空間相同的區域中具有工作者節點。若要驗證工作者節點的區域，請執行 `ibmcloud ks workers <cluster_name_or_ID>`。

### 步驟 2：建立持續性磁區 (PV) 及相符的持續性磁區要求 (PVC)

1.  選用項目：如果您具有已使用 `retain` 儲存空間類別佈建的儲存空間，則在移除 PVC 時，不會移除 PV 及實體儲存裝置。若要在叢集裡重複使用儲存空間，您必須先移除 PV。
    1. 列出現有 PV。
       ```
       kubectl get pv
       ```
       {: pre}

       尋找屬於持續性儲存空間的 PV。PV 處於 `released` 狀況。

    2. 移除 PV。
       ```
       kubectl delete pv <pv_name>
       ```
       {: pre}

    3. 驗證已移除 PV。
       ```
       kubectl get pv
       ```
       {: pre}

2.  建立 PV 的配置檔。包括您先前擷取的區塊儲存空間 `id`、`ip_addr`、`capacity_gb`、`datacenter` 及 `lunIdID`。

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region: <region>
         failure-domain.beta.kubernetes.io/zone: <zone>
    spec:
      capacity:
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
      ```
      {: codeblock}

    <table>
    <caption>瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>輸入您要建立的 PV 名稱。</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>輸入您先前擷取的地區及區域。您必須在與持續性儲存空間相同的地區及區域中至少具有一個工作者節點，才能在叢集裡裝載儲存空間。如果儲存空間的 PV 已存在，請[將區域及地區標籤新增](cs_storage_basics.html#multizone)至 PV。</tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>輸入針對現有區塊儲存空間所配置的檔案系統類型。請選擇 <code>ext4</code> 或 <code>xfs</code>。如果您未指定此選項，則 PV 預設為 <code>ext4</code>。定義錯誤的 fsType 時，PV 建立會成功，但將 PV 裝載到 Pod 失敗。</td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>輸入您在前一個步驟中所擷取之現有區塊儲存空間的儲存空間大小，作為 <code>capacity-gb</code>。必須以 GB 為單位寫入儲存空間大小，例如，20Gi (20 GB) 或 1000Gi (1 TB)。</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>輸入您先前擷取之區塊儲存空間的 LUN ID，作為 <code>lunId</code>。</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>輸入您先前擷取之區塊儲存空間的 IP 位址，作為 <code>ip_addr</code>。</td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>輸入您先前擷取之區塊儲存空間的 ID，作為 <code>id</code>。</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>輸入磁區的名稱。</td>
	    </tr>
    </tbody></table>

3.  在叢集裡建立 PV。
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4. 驗證已建立 PV。
    ```
    kubectl get pv
    ```
    {: pre}

5. 建立另一個配置檔來建立您的 PVC。為了讓 PVC 符合您先前建立的 PV，您必須對 `storage` 及 `accessMode` 選擇相同的值。`storage-class` 欄位必須是空的。如果其中有任何欄位不符合 PV，則會改為自動建立新的 PV。

     ```
     kind: PersistentVolumeClaim
     apiVersion: v1
     metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: ""
     spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: "<storage_size>"
     ```
     {: codeblock}

6.  建立您的 PVC。
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  驗證是否已建立您的 PVC，並將其連結至您先前建立的 PV。此處理程序可能需要幾分鐘的時間。
     ```
     kubectl describe pvc mypvc
     ```
     {: pre}

     輸出範例：

     ```
     Name: mypvc
     Namespace: default
     StorageClass:	""
     Status: Bound
     Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     Labels: <none>
     Capacity: 20Gi
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

您已順利建立 PV，並將它連結至 PVC。現在，叢集使用者可以[裝載 PVC](#app_volume_mount) 至其部署，並開始對 PV 進行讀寫。

<br />



## 備份及還原資料
{: #backup_restore}

區塊儲存空間會佈建至與叢集裡工作者節點相同的位置。儲存空間是在叢集化伺服器上由 IBM 管理，以在伺服器關閉時提供可用性。不過，如果整個位置失敗，則不會自動備份區塊儲存空間，且可能無法存取它們。若要避免資料遺失或損壞，您可以設定定期備份，以在需要時使用它們來還原您的資料。


檢閱區塊儲存空間的下列備份及還原選項：

<dl>
  <dt>設定定期 Snapshot</dt>
  <dd><p>您可以[針對區塊儲存空間設定定期 Snapshot](/docs/infrastructure/BlockStorage/snapshots.html#snapshots)，這是唯讀映像檔，會擷取實例在某個時間點的狀況。若要儲存 Snapshot，您必須在區塊儲存空間上要求 Snapshot 空間。Snapshot 儲存於相同區域內的現有儲存空間實例上。如果使用者不小心從磁區移除重要資料，您可以從 Snapshot 還原資料。<strong>附註</strong>：如果您有「專用」帳戶，則必須<a href="/docs/get-support/howtogetsupport.html#getting-customer-support">開立支援問題單</a>。</br></br> <strong>若要建立磁區的 Snapshot，請執行下列動作：</strong><ol><li>列出叢集裡的現有 PV。<pre class="pre"><code>kubectl get pv</code></pre></li><li>取得您要建立 Snapshot 空間之 PV 的詳細資料，並記下磁區 ID、大小及 IOPS。<pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> CLI 輸出的 <strong>Labels</strong> 區段中會顯示大小及 IOPS。若要尋找磁區 ID，請檢閱 CLI 輸出的 <code>ibm.io/network-storage-id</code> 註釋。</li><li>使用您在前一個步驟中擷取的參數，建立現有磁區的 Snapshot 大小。<pre class="pre"><code>slcli block snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>等待要建立的 Snapshot 大小。<pre class="pre">
<code>slcli block volume-detail &lt;volume_id&gt;</code></pre>CLI 輸出中的 <strong>Snapshot 容量 (GB)</strong> 從 0 變更為您訂購的大小時，即已順利佈建 Snapshot 大小。</li><li>為您的磁區建立 Snapshot，並記下為您建立的 Snapshot ID。<pre class="pre"><code>slcli block snapshot-create &lt;volume_id&gt;</code></pre></li><li>驗證已順利建立 Snapshot。<pre class="pre"><code>slcli block volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>若要將資料從 Snapshot 還原至現有磁區，請執行下列動作：</strong><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>將 Snapshot 抄寫至另一個區域</dt>
 <dd><p>若要在發生區域失敗時保護資料，您可以[將 Snapshot 抄寫](/docs/infrastructure/BlockStorage/replication.html#replicating-data)至另一個區域中設定的區塊儲存空間實例。資料只能從主要儲存空間抄寫至備份儲存空間。您無法將抄寫的區塊儲存空間實例裝載至叢集。當主要儲存空間失敗時，您可以手動將抄寫的備份儲存空間設為主要儲存空間。然後，您可以將它裝載至叢集。還原主要儲存空間之後，您可以從備份儲存空間中還原資料。<strong>附註</strong>：如果您有「專用」帳戶，則無法將 Snapshot 抄寫至另一個區域。</p></dd>
 <dt>複製儲存空間</dt>
 <dd><p>您可以在與原始儲存空間實例相同的區域中[複製區塊儲存空間實例](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume)。在建立複本的時間點，複本具有與原始儲存空間實例相同的資料。與抄本不同，請使用複本作為獨立於原始儲存空間實例外的儲存空間實例。若要複製，請先設定磁區的 Snapshot。<strong>附註</strong>：如果您有「專用」帳戶，則必須<a href="/docs/get-support/howtogetsupport.html#getting-customer-support">開立支援問題單</a>。</p></dd>
  <dt>將資料備份至 {{site.data.keyword.cos_full}}</dt>
  <dd><p>您可以使用 [**ibm-backup-restore image**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter)，在叢集裡啟動一個備份及還原 Pod。這個 Pod 包含一個 Script，它會針對叢集裡的任何持續性磁區要求 (PVC) 執行一次性或定期備份。資料會儲存在您於區域中設定的 {{site.data.keyword.cos_full}} 實例中。</p><strong>附註：</strong>區塊儲存空間是以 RWO 存取模式進行裝載。此存取容許一次僅將一個 Pod 裝載至區塊儲存空間。若要備份您的資料，您必須從儲存空間中卸載應用程式、將它裝載至備份 Pod、備份資料，並將儲存空間重新裝載至應用程式 Pod。</br></br>
若要讓資料有更高的可用性，並在發生區域失敗時保護應用程式，請設定第二個 {{site.data.keyword.cos_short}} 實例，並在區域之間抄寫資料。如果您需要從 {{site.data.keyword.cos_short}} 實例還原資料，請使用隨該映像檔所提供的還原 Script。</dd>
<dt>在 Pod 與容器之間複製資料</dt>
<dd><p>您可以使用 `kubectl cp` [指令 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/overview/#cp)，在叢集的 Pod 或特定容器之間複製檔案及目錄。</p>
<p>開始之前，請先將 [Kubernetes CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您想要使用的叢集。如果未使用 <code>-c</code> 來指定容器，則指令會使用 Pod 中第一個可用的容器。</p>
<p>您可以透過下列各種方式來使用指令：</p>
<ul>
<li>將資料從本端機器複製到叢集裡的 Pod：<pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>將資料從叢集裡的 Pod 複製到本端機器：<pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>將資料從本端機器複製到叢集裡的 Pod 中執行的特定容器：<pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## 儲存空間類別參照
{: #storageclass_reference}

### 銅級
{: #bronze}

<table>
<caption>區塊儲存空間類別：銅級</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>類型</td>
<td>[耐久性儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>檔案系統</td>
<td>ext4</td>
</tr>
<tr>
<td>每 GB 的 IOPS 數目</td>
<td>2</td>
</tr>
<tr>
<td>大小範圍（以 GB 為單位）</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>硬碟</td>
<td>SSD</td>
</tr>
<tr>
<td>計費</td>
<td>預設計費類型取決於 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式的版本：<ul><li> 1.0.1 版及更新版本：每小時</li><li>1.0.0 版及較舊版本：每月</li></ul></td>
</tr>
<tr>
<td>定價</td>
<td>[定價資訊 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### 銀級
{: #silver}

<table>
<caption>區塊儲存空間類別：銀級</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>類型</td>
<td>[耐久性儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>檔案系統</td>
<td>ext4</td>
</tr>
<tr>
<td>每 GB 的 IOPS 數目</td>
<td>4</td>
</tr>
<tr>
<td>大小範圍（以 GB 為單位）</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>硬碟</td>
<td>SSD</td>
</tr>
<tr>
<td>計費</td>
<td>預設計費類型取決於 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式的版本：<ul><li> 1.0.1 版及更新版本：每小時</li><li>1.0.0 版及較舊版本：每月</li></ul></td>
</tr>
<tr>
<td>定價</td>
<td>[定價資訊 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### 金級
{: #gold}

<table>
<caption>區塊儲存空間類別：金級</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>類型</td>
<td>[耐久性儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>檔案系統</td>
<td>ext4</td>
</tr>
<tr>
<td>每 GB 的 IOPS 數目</td>
<td>10</td>
</tr>
<tr>
<td>大小範圍（以 GB 為單位）</td>
<td>20-4000 Gi</td>
</tr>
<tr>
<td>硬碟</td>
<td>SSD</td>
</tr>
<tr>
<td>計費</td>
<td>預設計費類型取決於 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式的版本：<ul><li> 1.0.1 版及更新版本：每小時</li><li>1.0.0 版及較舊版本：每月</li></ul></td>
</tr>
<tr>
<td>定價</td>
<td>[定價資訊 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### 自訂
{: #custom}

<table>
<caption>區塊儲存空間類別：自訂</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>類型</td>
<td>[效能 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>檔案系統</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS 及大小</td>
<td><strong>大小範圍（以 GB 為單位）/ IOPS 範圍（以 100 的倍數表示）</strong><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>硬碟</td>
<td>IOPS 與 GB 的比例決定佈建之硬碟的類型。若要判定 IOPS 與 GB 的比例，您可將 IOPS 除以儲存空間的大小。</br></br>範例：
    </br>您選擇具有 100 IOPS 的 500Gi 儲存空間。您的比例為 0.2 (100 IOPS/500Gi)。</br></br><strong>每個比例之硬碟類型的概觀</strong><ul><li>小於或等於 0.3：SATA</li><li>大於 0.3：SSD</li></ul></td>
</tr>
<tr>
<td>計費</td>
<td>預設計費類型取決於 {{site.data.keyword.Bluemix_notm}} Block Storage 外掛程式的版本：<ul><li> 1.0.1 版及更新版本：每小時</li><li>1.0.0 版及較舊版本：每月</li></ul></td>
</tr>
<tr>
<td>定價</td>
<td>[定價資訊 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## 自訂的儲存空間類別範例
{: #custom_storageclass}

### 指定多區域叢集的區域
{: #multizone_yaml}

下列 `.yaml` 檔案自訂以 `ibm-block-silver` 非保留儲存空間類別為基礎的儲存空間類別：`type` 為 `"Endurance"`、`iopsPerGB` 為 `4`、`sizeRange` 為 `"[20-12000]Gi"`，而 `reclaimPolicy` 設為 `"Delete"`。區域指定為 `dal12`。您可以檢閱有關 `ibmc` 儲存空間類別的前述資訊，來協助您選擇這些項目可接受的值</br>

若要使用不同的儲存空間類別作為基礎，請參閱[儲存空間類別參照](#storageclass_reference)。

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### 使用 `XFS` 檔案系統裝載區塊儲存空間
{: #xfs}

下列範例建立一個名為 `ibmc-block-custom-xfs` 的儲存空間類別，其使用 `XFS` 檔案系統佈建效能區塊儲存空間。

```
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-block-custom-xfs
     labels:
       addonmanager.kubernetes.io/mode: Reconcile
   provisioner: ibm.io/ibmc-block
   parameters:
     type: "Performance"
     sizeIOPSRange: |-
       [20-39]Gi:[100-1000]
       [40-79]Gi:[100-2000]
       [80-99]Gi:[100-4000]
       [100-499]Gi:[100-6000]
       [500-999]Gi:[100-10000]
       [1000-1999]Gi:[100-20000]
       [2000-2999]Gi:[200-40000]
       [3000-3999]Gi:[200-48000]
       [4000-7999]Gi:[300-48000]
       [8000-9999]Gi:[500-48000]
       [10000-12000]Gi:[1000-48000]
     fsType: "xfs"
     reclaimPolicy: "Delete"
     classVersion: "2"
   ```
{: codeblock}

<br />

