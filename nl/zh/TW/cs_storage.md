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


# 使用持續性磁區儲存空間來儲存資料
{: #planning}

容器設計為短期容器。不過，如下圖所示，您可以選擇數個選項，以在容器發生失效接手時持續保存資料，以及在容器之間共用資料。
{:shortdesc}

**附註**：如果您有防火牆，則對叢集所在位置（資料中心）的 IBM Cloud 基礎架構 (SoftLayer) IP 範圍[容許進行 Egress 存取](cs_firewall.html#pvc)，讓您能夠建立持續性磁區宣告。


![Kubernetes 叢集中部署的持續性儲存空間選項](images/cs_planning_apps_storage.png)

|選項|說明|
|------|-----------|
|選項 1：使用 `/emptyDir`，以使用工作者節點上的可用磁碟空間來持續保存資料<p>此特性適用於精簡及標準叢集。</p>|使用此選項，您可以在已指派給 Pod 的工作者節點磁碟空間上建立空磁區。該 Pod 中的容器可以讀取及寫入該磁區。因為磁區已指派給一個特定 Pod，所以無法與抄本集中的其他 Pod 共用資料。
<p>從工作者節點永久刪除所指派的 Pod 時，會移除 `/emptyDir` 磁區及其資料。</p><p>**附註：**如果 Pod 內的容器損毀，則工作者節點上仍然會有磁區中的資料。</p><p>如需相關資訊，請參閱 [Kubernetes 磁區 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/storage/volumes/)。</p>|
|選項 2：建立持續性磁區宣告，以佈建部署的 NFS 型持續性儲存空間<p>只有標準叢集才能使用此特性。</p>|<p>使用此選項，您可以透過持續性磁區來持續儲存應用程式及容器資料。這些磁區是在 [耐久性及效能 NFS 型檔案儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/file-storage/details) 上進行管理。檔案儲存空間會在靜置時加密，而且您可以建立已儲存資料的抄本。</p> <p>您可以建立[持續性磁區宣告](cs_storage.html)來起始 NFS 型檔案儲存空間的要求。{{site.data.keyword.containershort_notm}} 提供預先定義的儲存空間類別，以定義儲存空間的大小範圍、IOPS、刪除原則，以及磁區的讀取及寫入權。當您建立持續性磁區宣告時，可以選擇這些儲存空間類別。提交持續性磁區宣告之後，{{site.data.keyword.containershort_notm}} 會動態佈建在 NFS 型檔案儲存空間上所管理的持續性磁區。[您可以將持續性磁區宣告以磁區形式裝載至部署](cs_storage.html#create)，以容許容器讀取及寫入磁區。持續性磁區可以在相同抄本集之間共用，或與相同叢集中的其他部署共用。</p><p>容器損毀或從工作者節點移除 Pod 時，資料不會被移除，而且仍然可以透過裝載磁區的其他部署進行存取。持續性磁區宣告是在持續性儲存空間上管理，但沒有備份。如果需要資料的備份，請建立手動備份。</p><p>**附註：**持續性 NFS 檔案共用儲存空間是按月收費。如果您佈建叢集的持續性儲存空間，並立即予以移除，則仍然需要支付一個月的持續性儲存空間費用，即使您只是短時間使用也是一樣。</p>|
|選項 3：將 {{site.data.keyword.Bluemix_notm}} 資料庫服務連結至 Pod<p>此特性適用於精簡及標準叢集。</p>|使用此選項，您可以使用 {{site.data.keyword.Bluemix_notm}} 資料庫雲端服務來持續保存及存取資料。當您將 {{site.data.keyword.Bluemix_notm}} 服務連結至叢集中的名稱空間時，會建立 Kubernetes Secret。Kubernetes Secret 會保留服務的機密資訊（例如服務的 URL、使用者名稱及密碼）。您可以將 Secret 以 Secret 磁區形式裝載至 Pod，並使用 Secret 中的認證來存取服務。
透過將 Secret 磁區裝載至其他 Pod，您也可以在 Pod 之間共用資料。<p>容器損毀或從工作者節點移除 Pod 時，資料不會被移除，而且仍然可以透過裝載 Secret 磁區的其他 Pod 進行存取。</p><p>大部分 {{site.data.keyword.Bluemix_notm}} 資料庫服務會免費提供少量資料的磁碟空間，讓您可以測試其特性。</p><p>如需如何將 {{site.data.keyword.Bluemix_notm}} 服務連結至 Pod 的相關資訊，請參閱[在 {{site.data.keyword.containershort_notm}} 中新增應用程式的 {{site.data.keyword.Bluemix_notm}} 服務](cs_integrations.html#adding_app)。</p>|
{: caption="表格。Kubernetes 叢集中部署的持續性資料儲存空間選項" caption-side="top"}

<br />



## 使用叢集中的現有 NFS 檔案共用
{: #existing}

如果您要使用 IBM Cloud 基礎架構 (SoftLayer) 帳戶中的現有 NFS 檔案共用與 Kubernetes 搭配使用，則可以藉由在現有 NFS 檔案共用上建立持續性磁區來進行。持續性磁區是實際硬體的一部分，可作為 Kubernetes 叢集資源，並可供叢集使用者使用。
{:shortdesc}

Kubernetes 會區分代表實際硬體的持續性磁區與通常由叢集使用者所起始之儲存要求的持續性磁區宣告。下圖說明持續性磁區與持續性磁區宣告之間的關係。

![建立持續性磁區及持續性磁區宣告](images/cs_cluster_pv_pvc.png)

 如圖所示，若要啟用與 Kubernetes 搭配使用的現有 NFS 檔案共用時，您必須建立具有特定大小及存取模式的持續性磁區，以及建立與持續性磁區規格相符的持續性磁區宣告。如果持續性磁區與持續性磁區宣告相符，它們會彼此連結。叢集使用者只能使用連結的持續性磁區宣告，將磁區裝載至部署。此處理程序稱為靜態佈建的持續性儲存空間。

開始之前，請確定您有可用來建立持續性磁區的現有 NFS 檔案共用。

**附註：**靜態佈建持續性儲存空間只適用於現有 NFS 檔案共用。如果您沒有現有 NFS 檔案共用，叢集使用者可以使用[動態佈建](cs_storage.html#create)處理程序來新增持續性磁區。

若要建立持續性磁區及相符的持續性磁區宣告，請遵循下列步驟。

1.  在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中，查閱您要建立持續性磁區物件的 NFS 檔案共用的 ID 及路徑。此外，將檔案儲存空間授權給叢集中的子網路。此授權會將儲存空間的存取權授與叢集。
    1.  登入您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶。
    2.  按一下**儲存空間**。
    3.  按一下**檔案儲存空間**，並從**動作**功能表中選取**授權主機**。
    4.  按一下**子網路**。在您授權之後，子網路上的每個工作者節點都可以存取檔案儲存空間。
    5.  從功能表中選取叢集公用 VLAN 的子網路，然後按一下**提交**。如果您需要尋找子網路，請執行 `bx cs cluster-get <cluster_name> --showResources`。
    6.  按一下檔案儲存空間的名稱。
    7.  記下**裝載點**欄位。此欄位會顯示為 `<server>:/<path>`。
2.  建立持續性磁區的儲存空間配置檔。包含來自檔案儲存空間**裝載點**欄位的伺服器及路徑。

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>表格。瞭解 YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>輸入您要建立的持續性磁區物件的名稱。</td>
    </tr>
    <tr>
    <td><code>儲存空間</code></td>
    <td>輸入現有 NFS 檔案共用的儲存空間大小。儲存空間大小必須以 GB 為單位寫入（例如，20Gi (20 GB) 或 1000Gi (1 TB)），而且大小必須符合現有檔案共用的大小。</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>存取模式可定義將持續性磁區宣告裝載至工作者節點的方式。<ul><li>ReadWriteOnce (RWO)：持續性磁區只能裝載至單一工作者節點中的部署。部署中裝載至此持續性磁區的容器可以讀取及寫入磁區。</li><li>ReadOnlyMany (ROX)：持續性磁區可以裝載至在多個工作者節點上管理的部署。裝載至此持續性磁區的部署只能讀取磁區。</li><li>ReadWriteMany (RWX)：此持續性磁區可以裝載至在多個工作者節點上管理的部署。裝載至此持續性磁區的部署可以讀取及寫入磁區。</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>輸入 NFS 檔案共用伺服器 ID。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>輸入您要建立持續性磁區物件的 NFS 檔案共用的路徑。</td>
    </tr>
    </tbody></table>

3.  在叢集中建立持續性磁區物件。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    範例

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  驗證已建立持續性磁區。

    ```
    kubectl get pv
    ```
    {: pre}

5.  建立另一個配置檔來建立持續性磁區宣告。為了讓持續性磁區宣告符合您先前建立的持續性磁區物件，您必須對 `storage` 及 `accessMode` 選擇相同的值。`storage-class` 欄位必須是空的。如果其中有任何欄位不符合持續性磁區，則會改為自動建立新的持續性磁區。

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  建立持續性磁區宣告。

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  驗證持續性磁區宣告已建立並連結至持續性磁區物件。此處理程序可能需要幾分鐘的時間。

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    您的輸出會與下列內容類似。

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


您已順利建立持續性磁區物件，並將其連結至持續性磁區宣告。叢集使用者現在可以[裝載持續性磁區宣告](#app_volume_mount)至其部署，並開始讀取及寫入持續性磁區物件。

<br />


## 建立應用程式的持續性儲存空間
{: #create}

建立持續性磁區宣告 (pvc)，以為叢集佈建 NFS 檔案儲存空間。然後，將此宣告裝載至部署，以確保即使 Pod 損毀或關閉，也能使用資料。
{:shortdesc}

IBM 已叢集化支援持續性磁區的 NFS 檔案儲存空間，可提供資料的高可用性。

1.  檢閱可用的儲存空間類別。{{site.data.keyword.containerlong}} 提供八個預先定義的儲存空間類別，因此叢集管理者不需要建立任何儲存空間類別。`ibmc-file-bronze` 儲存空間類別與 `default` 儲存空間類別相同。

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file 
    ```
    {: screen}

2.  決定在刪除 pvc 之後，是否要儲存資料及 NFS 檔案共用。如果要保留資料，則請選擇 `retain` 儲存空間類別。如果您要在刪除 pvc 時刪除資料及檔案共用，請選擇儲存空間類別而不使用 `retain`。

3.  檢閱儲存空間類別的 IOPS 和可用的儲存空間大小。

    - 銅級、銀級和金級儲存空間類別使用[耐久性儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/endurance-storage)，而每個類別的每個 GB 各有一個定義的 IOPS。IOPS 總計取決於儲存空間的大小。例如，每 GB 4 IOPS 的 1000Gi pvc 具有總計 4000 的 IOPS。

      ```
    kubectl describe storageclasses ibmc-file-silver
    ```
      {: pre}

      **parameters** 欄位提供每個與儲存空間類別相關聯的 GB 的 IOPS 以及可用大小（以 GB 為單位）。

      ```
    Parameters: iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
      {: screen}

    - 自訂儲存空間類別使用 [Performance 儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/performance-storage)，並且對總計 IOPS 和大小有不同的選項。

      ```
    kubectl describe storageclasses ibmc-file-retain-custom 
    ```
      {: pre}

      **parameters** 欄位提供每個與儲存空間類別相關聯的 IOPS 以及可用大小（以 GB 為單位）。例如，40Gi pvc 可以選取範圍 100 - 2000 IOPS 內，屬於 100 倍數的 IOPS。

      ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
      {: screen}

4.  建立配置檔來定義持續性磁區宣告，以及將配置儲存為 `.yaml` 檔案。

    銅級、銀級、金級類別的範例：

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    自訂類別的範例：

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>輸入持續性磁區宣告的名稱。</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>指定持續性磁區的儲存空間類別：
      <ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze：每個 GB 有 2 個 IOPS。</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver：每個 GB 有 4 個 IOPS。</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold：每個 GB 有 10 個 IOPS。</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom：可以使用 IOPS 的多個值。

    </li> 如果未指定任何儲存空間類別，則會建立具有 bronze（銅級）儲存空間類別的持續性磁區。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td> 如果您選擇的大小不是所列出的大小，則會將此大小四捨五入。如果您選取的大小大於最大大小，則會對此大小進行無條件捨去。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>這個選項只適用於 ibmc-file-custom / ibmc-file-retain-custom。請指定儲存空間的總計 IOPS。執行 `kubectl describe storageclasses ibmc-file-custom` 以查看所有選項。如果您選擇的 IOPS 不是所列出的 IOPS，則會將 IOPS 無條件進位。</td>
    </tr>
    </tbody></table>

5.  建立持續性磁區宣告。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  驗證持續性磁區宣告已建立並連結至持續性磁區。此處理程序可能需要幾分鐘的時間。

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    您的輸出會與下列內容類似。

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #app_volume_mount}若要將持續性磁區宣告裝載至部署，請建立配置檔。將配置儲存為 `.yaml` 檔案。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
     name: <deployment_name>
    replicas: 1
    template:
     metadata:
       labels:
         app: <app_name>
    spec:
     containers:
     - image: <image_name>
       name: <container_name>
       volumeMounts:
       - mountPath: /<file_path>
         name: <volume_name>
     volumes:
     - name: <volume_name>
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>部署的名稱。</td>
    </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>部署的標籤。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>在部署內部裝載磁區之目錄的絕對路徑。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>要裝載至部署之磁區的名稱。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>要裝載至部署之磁區的名稱。此名稱通常與 <code>volumeMounts/name</code> 相同。</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>您要用來作為磁區的持續性磁區宣告的名稱。當您將磁區裝載至部署時，Kubernetes 會識別連結至持續性磁區宣告的持續性磁區，並讓使用者讀取及寫入持續性磁區。</td>
    </tr>
    </tbody></table>

8.  建立部署，並裝載持續性磁區宣告。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  驗證已順利裝載磁區。

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
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />




## 新增非 root 使用者對持續性儲存空間的存取權
{: #nonroot}

非 root 使用者對 NFS 支援的儲存空間的磁區裝載路徑沒有寫入權。若要授與寫入權，您必須編輯映像檔的 Dockerfile，以使用正確許可權在裝載路徑上建立目錄。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

如果您是使用需要磁區寫入權的非 root 使用者來設計應用程式，則必須將下列處理程序新增至 Dockerfile 及進入點 Script：

-   建立非 root 使用者。
-   暫時將使用者新增至 root 群組。
-   使用正確的使用者許可權在磁區裝載路徑中建立目錄。

對於 {{site.data.keyword.containershort_notm}}，磁區裝載路徑的預設擁有者是擁有者 `nobody`。使用 NFS 儲存空間，如果擁有者不存在於 Pod 本端，則會建立 `nobody` 使用者。磁區設定成辨識容器中的 root 使用者，對部分應用程式而言，這是容器內唯一的使用者。不過，許多應用程式會指定寫入至容器裝載路徑且不是 `nobody` 的非 root 使用者。部分應用程式指定磁區必須由 root 使用者擁有。由於安全考量，通常應用程式不會使用 root 使用者。不過，如果您的應用程式需要 root 使用者，您可以聯絡 [{{site.data.keyword.Bluemix_notm}} 支援中心](/docs/support/index.html#contacting-support)以取得協助。


1.  在本端目錄中建立 Dockerfile。此範例 Dockerfile 會建立名為 `myguest` 的非 root 使用者。

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    # The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  在與 Dockerfile 相同的本端資料夾中，建立進入點 Script。此範例進入點 Script 會將 `/mnt/myvol` 指定為磁區裝載路徑。

    ```
    #!/bin/bash
    set -e

    # This is the mount point for the shared volume.
    # By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      # Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      # For security, remove the non-root user from root user group.
      deluser $MY_USER root

      # Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    # This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  登入 {{site.data.keyword.registryshort_notm}}。

    ```
    bx cr login
    ```
    {: pre}

4.  本端建置映像檔。請記得將 _&lt;my_namespace&gt;_ 取代為專用映像檔登錄的名稱空間。如果您需要尋找名稱空間，請執行 `bx cr namespace-get`。

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  將映像檔推送至 {{site.data.keyword.registryshort_notm}} 中的名稱空間。

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  建立配置 `.yaml` 檔案，以建立持續性磁區宣告。此範例使用較低效能的儲存空間類別。請執行 `kubectl get storageclasses`，以查看可用的儲存空間類別。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  建立持續性磁區宣告。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  建立配置檔，以裝載磁區然後從 nonroot 映像檔中執行 Pod。磁區裝載路徑 `/mnt/myvol` 符合 Dockerfile 中所指定的裝載路徑。將配置儲存為 `.yaml` 檔案。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  建立 Pod，並將持續性磁區宣告裝載至 Pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. 驗證磁區已順利裝載至 Pod。

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    裝載點會列在 **Volume Mounts**（磁區裝載）欄位中，而磁區會列在 **Volumes**（磁區）欄位中。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. 在 Pod 執行之後，登入 Pod。

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. 檢視磁區裝載路徑的許可權。

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    此輸出顯示 root 具有磁區裝載路徑 `mnt/myvol/` 的讀取、寫入及執行權，但非 root myguest 使用者則具有 `mnt/myvol/mydata` 資料夾的讀取及寫入權。因為這些更新過的許可權，所以非 root 使用者現在可以將資料寫入至持續性磁區。


