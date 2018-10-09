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


# 將資料儲存在 IBM Cloud Object Storage
{: #object_storage}

## 建立物件儲存空間服務實例
{: #create_cos_service}

您必須先在帳戶中佈建 {{site.data.keyword.cos_full_notm}} 服務實例，才能在叢集中開始使用 {{site.data.keyword.cos_full_notm}}。
{: shortdesc}

1. 部署 {{site.data.keyword.cos_full_notm}} 服務實例。
   1.  開啟 [{{site.data.keyword.cos_full_notm}} 型錄頁面](https://console.bluemix.net/catalog/services/cloud-object-storage)。
   2.  輸入服務實例的名稱（例如 `cos-backup`），然後選取 **default** 作為資源群組。
   3.  如需定價資訊，請檢閱[方案選項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)，然後選取方案。
   4.  按一下**建立**。即會開啟「服務詳細資料」頁面。
2. {: #service_credentials}擷取 {{site.data.keyword.cos_full_notm}} 服務認證。
   1.  在「服務詳細資料」頁面的導覽中，按一下**服務認證**。
   2.  按一下**新建認證**。即會顯示一個對話框。
   3.  輸入認證的名稱。
   4.  從**角色**下拉清單中，選取 `Writer` 或 `Manager`。選取 `Reader` 時，您無法使用認證在 {{site.data.keyword.cos_full_notm}} 中建立儲存區以及在其中寫入資料。
   5.  選用項目：在**新增線型配置參數（選用）**中，輸入 `{"HMAC":true}` 來建立 {{site.data.keyword.cos_full_notm}} 服務的其他 HMAC 認證。HMAC 鑑別透過防止誤用過期或隨機建立的 OAuth2 記號，以在預設 OAuth2 鑑別中新增額外的安全層。
   6.  按一下**新增**。您的新認證會列在**服務認證**表格中。
   7.  按一下**檢視認證**。
   8.  記下 **apikey** ，以使用 OAuth2 記號向 {{site.data.keyword.cos_full_notm}} 服務鑑別。對於 HMAC 鑑別，在 **cos_hmac_keys** 區段中，記下 **access_key_id** 及 **secret_access_key**。
3. [將服務認證儲存至叢集的 Kubernetes 密碼](#create_cos_secret)，以存取 {{site.data.keyword.cos_full_notm}} 服務實例。

## 建立物件儲存空間服務認證的密碼
{: #create_cos_secret}

若要存取 {{site.data.keyword.cos_full_notm}} 服務實例以讀取及寫入資料，您必須將服務認證安全地儲存至 Kubernetes 密碼。{{site.data.keyword.cos_full_notm}} 外掛程式使用這些認證進行儲存區的每次讀取或寫入作業。
{: shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為叢集。

1. 擷取 [{{site.data.keyword.cos_full_notm}} 服務認證](#service_credentials)的 **apikey** 或 **access_key_id** 及 **secret_access_key**。

2. 取得 {{site.data.keyword.cos_full_notm}} 服務實例的 **GUID**。
   ```
   ibmcloud resource service-instance <service_name>
   ```
   {: pre}

3. 將 {{site.data.keyword.cos_full_notm}} **GUID** 以及稍早擷取的 **apikey** 或 **access_key_id** 及 **secret_access_key** 編碼為 base64，並記下所有 base64 編碼值。對每個參數重複此指令，以擷取 base64 編碼值。
   ```
   echo -n "<key_value>" | base64
   ```
   {: pre}

4. 建立配置檔以定義 Kubernetes 密碼。

   **API 金鑰使用範例：**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     api-key: <base64_apikey>
     service-instance-id: <base64_guid>
   ```
   {: codeblock}

   **HMAC 鑑別使用範例：**
   ```
   apiVersion: v1
   kind: Secret
   type: ibm/ibmc-s3fs
   metadata:
     name: <secret_name>
     namespace: <namespace>
   data:
     access-key: <base64_access_key_id>
     secret-key: <base64_secret_access_key>
     service-instance-id: <base64_guid>
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
   <td>輸入 {{site.data.keyword.cos_full_notm}} 密碼的名稱。</td>
   </tr>
   <tr>
   <td><code>metadata/namespace</code></td>
   <td>指定您要在其中建立密碼的名稱空間。必須在您要建立 PVC 的相同名稱空間中以及存取 {{site.data.keyword.cos_full_notm}} 服務實例的 Pod 中建立密碼。</td>
   </tr>
   <tr>
   <td><code>data/api-key</code></td>
   <td>輸入您稍早從 {{site.data.keyword.cos_full_notm}} 服務認證中擷取的 API 金鑰。API 金鑰必須以 base64 編碼。如果您要使用 HMAC 鑑別，請改為指定 <code>data/access-key</code> 及 <code>data/secret-key</code>。</td>
   </tr>
   <tr>
   <td><code>data/access-key</code></td>
   <td>輸入您稍早從 {{site.data.keyword.cos_full_notm}} 服務認證中擷取的存取金鑰 ID。存取金鑰 ID 必須以 base64 編碼。如果您要使用 OAuth2 鑑別，請改為指定 <code>data/api-key</code>。</td>
   </tr>
   <tr>
   <td><code>data/secret-key</code></td>
   <td>輸入您稍早從 {{site.data.keyword.cos_full_notm}} 服務認證中擷取的秘密存取金鑰。秘密存取金鑰必須以 base64 編碼。如果您要使用 OAuth2 鑑別，請改為指定 <code>data/api-key</code>。</td>
   </tr>
   <tr>
   <td><code>data/service-instance-id</code></td>
   <td>輸入您稍早擷取的 {{site.data.keyword.cos_full_notm}} 服務實例 GUID。GUID 必須以 base64 編碼。</td>
   </tr>
   </tbody>
   </table>

5. 在叢集中建立密碼。
   ```
   kubectl apply -f filepath/secret.yaml
   ```
   {: pre}

6. 驗證已在名稱空間中建立密碼。
   ```
   kubectl get secret
   ```
   {: pre}

7. [安裝 {{site.data.keyword.cos_full_notm}} 外掛程式](#install_cos)，或者，如果您已安裝外掛程式，則請針對 {{site.data.keyword.cos_full_notm}} 儲存區[決定配置]( #configure_cos)。

## 安裝 IBM Cloud Object Storage 外掛程式
{: #install_cos}

安裝 {{site.data.keyword.cos_full_notm}} 外掛程式與 Helm 圖表，以設定 {{site.data.keyword.cos_full_notm}} 的預先定義儲存空間類別。您可以使用這些儲存空間類別來建立 PVC，以佈建應用程式的 {{site.data.keyword.cos_full_notm}}。
{: shortdesc}

尋找如何更新或移除 {{site.data.keyword.cos_full_notm}} 外掛程式的指示？請參閱[更新外掛程式](#update_cos_plugin)及[移除外掛程式](#remove_cos_plugin)。
{: tip}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要在其中安裝 {{site.data.keyword.cos_full_notm}} 外掛程式的叢集。

1. 遵循[指示](cs_integrations.html#helm)，將 Helm 用戶端安裝在您的本端機器上、將 Helm 伺服器 (tiller) 安裝在您的叢集中，並且將 {{site.data.keyword.Bluemix_notm}} Helm 圖表儲存庫新增至您要在其中使用 {{site.data.keyword.cos_full_notm}} 外掛程式的叢集中。

    **重要事項：**如果您使用 Helm 2.9 版或更高版本，請確定已使用[服務帳戶](cs_integrations.html#helm)來安裝 tiller。
2. 將 {{site.data.keyword.Bluemix_notm}} Helm 儲存庫新增至叢集。
   ```
helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
   {: pre}

3. 更新 Helm 報告，以擷取此儲存庫中所有 Helm 圖表的最新版本。
   ```
helm repo update
        ```
   {: pre}

4. 安裝 {{site.data.keyword.cos_full_notm}} Helm 外掛程式 `ibmc`。此外掛程式用來自動擷取您的叢集位置，以及在儲存空間類別中設定 {{site.data.keyword.cos_full_notm}} 儲存區的 API 端點。
   1. 下載 Helm 圖表，並解壓縮現行目錄中的圖表。    
      ```
      helm fetch --untar ibm/ibmcloud-object-storage-plugin
      ```
      {: pre}
   2. 安裝 Helm 外掛程式。
      ```
      helm plugin install ibmcloud-object-storage-plugin/helm-ibmc
      ```
      {: pre}

      輸出範例：
        ```
      Installed plugin: ibmc
      ```
      {: screen}

5. 驗證已順利安裝 `ibmc` 外掛程式。
   ```
   helm ibmc --help
   ```
   {: pre}

   輸出範例：
   ```
   Install or upgrade Helm charts in IBM K8S Service

   Available Commands:
    helm ibmc install [CHART] [flags]              Install a Helm chart
    helm ibmc upgrade [RELEASE] [CHART] [flags]    Upgrades the release to a new version of the Helm chart

   Available Flags:
    --verbos                      (Optional) Verbosity intensifies... ...
    -f, --values valueFiles       (Optional) specify values in a YAML file (can specify multiple) (default [])
    -h, --help                    (Optional) This text.
    -u, --update                  (Optional) Update this plugin to the latest version

   Example Usage:
    helm ibmc install ibm/ibmcloud-object-storage-plugin -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: screen}

6. 選用項目：限制 {{site.data.keyword.cos_full_notm}} 外掛程式只能存取保留您 {{site.data.keyword.cos_full_notm}} 服務認證的 Kubernetes 密碼。依預設，外掛程式有權存取叢集中的所有 Kubernetes 密碼。
   1. [建立 {{site.data.keyword.cos_full_notm}} 服務實例](#create_cos_service)。
   2. [將 {{site.data.keyword.cos_full_notm}} 服務認證儲存至 Kubernetes 密碼](#create_cos_secret)。
   3. 導覽至 `templates` 目錄，並列出可用的檔案。  
      ```
      cd ibmcloud-object-storage-plugin/templates && ls
      ```
      {: pre}

   4. 開啟 `provisioner-sa.yaml` 檔案，並尋找 `ibmcloud-object-storage-secret-reader` ClusterRole 定義。
   6. 將稍早建立的密碼名稱新增至 `resourceNames` 區段中外掛程式有權存取的密碼清單。
      ```
      kind: ClusterRole
      apiVersion: rbac.authorization.k8s.io/v1beta1
      metadata:
        name: ibmcloud-object-storage-secret-reader
      rules:
      - apiGroups: [""]
          resources: ["secrets"]
        resourceNames: ["<secret_name1>","<secret_name2>"]
        verbs: ["get"]
      ```
      {: codeblock}
   7. 儲存變更。

8. 安裝 {{site.data.keyword.cos_full_notm}} 外掛程式。安裝外掛程式時，會將預先定義的儲存空間類別新增至叢集。

   **安裝但不限制為特定 Kubernetes 密碼：**
   ```
   helm ibmc install ibm/ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

   **安裝但限制為特定 Kubernetes 密碼（如前一個步驟所述）：**
   ```
   helm ibmc install ./ibmcloud-object-storage-plugin -f ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

   輸出範例：
   ```
   Installing the Helm chart
   DC: dal10  Chart: ibm/ibmcloud-object-storage-plugin
   NAME:   mewing-duck
   LAST DEPLOYED: Mon Jul 30 13:12:59 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1/Pod(related)
   NAME                                             READY  STATUS             RESTARTS  AGE
   ibmcloud-object-storage-driver-hzqp9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-jtdb9             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-driver-tl42l             0/1    ContainerCreating  0         1s
   ibmcloud-object-storage-plugin-7d87fbcbcc-wgsn8  0/1    ContainerCreating  0         1s

   ==> v1beta1/StorageClass
   NAME                                  PROVISIONER       AGE
   ibmc-s3fs-cold-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-cold-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-cross-region           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-cross-region      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-perf-regional          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-flex-regional               ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-cross-region       ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-cross-region  ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-perf-regional      ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-standard-regional           ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-cross-region          ibm.io/ibmc-s3fs  1s
   ibmc-s3fs-vault-regional              ibm.io/ibmc-s3fs  1s

   ==> v1/ServiceAccount
   NAME                            SECRETS  AGE
   ibmcloud-object-storage-driver  1        1s
   ibmcloud-object-storage-plugin  1        1s

   ==> v1beta1/ClusterRole
   NAME                                   AGE
   ibmcloud-object-storage-secret-reader  1s
   ibmcloud-object-storage-plugin         1s

   ==> v1beta1/ClusterRoleBinding
   NAME                                   AGE
   ibmcloud-object-storage-plugin         1s
   ibmcloud-object-storage-secret-reader  1s

   ==> v1beta1/DaemonSet
   NAME                            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-object-storage-driver  3        3        0      3           0          <none>         1s

   ==> v1beta1/Deployment
   NAME                            DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-object-storage-plugin  1        1        1           0          1s

   NOTES:
   Thank you for installing: ibmcloud-object-storage-plugin.   Your release is named: mewing-duck

   Please refer Chart README.md file for creating a sample PVC.
   Please refer Chart RELEASE.md to see the release details/fixes.
   ```
   {: screen}

9. 驗證已正確安裝外掛程式。
   ```
   kubectl get pod -n kube-system -o wide | grep object
   ```
   {: pre}

   輸出範例：
   ```
   ibmcloud-object-storage-driver-9n8g8                              1/1       Running   0          2m
   ibmcloud-object-storage-plugin-7c774d484b-pcnnx                   1/1       Running   0          2m
   ```
   {: screen}

   當您看到一個 `ibmcloud-object-storage-plugin` Pod 及一個以上的 `ibmcloud-object-storage-driver` Pod 時，安裝即成功。`ibmcloud-object-storage-driver` Pod 的數目等於叢集中的工作者節點數目。所有 Pod 都必須處於 `Running` 狀態，外掛程式才能正常運作。如果 Pod 失敗，請執行 `kubectl describe pod -n kube-system <pod_name>`，以尋找失敗的主要原因。

10. 驗證已順利建立儲存空間類別。
   ```
   kubectl get storageclass | grep s3
   ```
   {: pre}

   輸出範例：
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}

11. 針對您要存取 {{site.data.keyword.cos_full_notm}} 儲存區的所有叢集，重複這些步驟。

### 更新 IBM Cloud Object Storage 外掛程式
{: #update_cos_plugin}

您可以將現有的 {{site.data.keyword.cos_full_notm}} 外掛程式升級至最新版本。
{: shortdesc}

1. 更新 Helm 報告，以擷取此儲存庫中所有 Helm 圖表的最新版本。
   ```
helm repo update
        ```
   {: pre}

2. 將最新 Helm 圖表下載至本端機器，並解壓縮套件以檢閱 `release.md` 檔案來尋找最新版本資訊。
   ```
   helm fetch --untar ibm/ibmcloud-object-storage-plugin
   ```

3. 尋找 Helm 圖表的安裝名稱。
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}

   輸出範例：
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}

4. 將 {{site.data.keyword.cos_full_notm}} 外掛程式升級至最新版本。
   ```   
   helm ibmc upgrade <helm_chart_name> ibm/ibmcloud-object-storage-plugin --force --recreate-pods -f ./ibmcloud-object-storage-plugin/ibm/values.yaml
   ```
   {: pre}

5. 驗證已順利升級 `ibmcloud-object-storage-plugin`。  
   ```
   kubectl rollout status deployment/ibmcloud-object-storage-plugin -n kube-system
   ```
   {: pre}

   當您在 CLI 輸出中看到 `deployment "ibmcloud-object-storage-plugin" successfully rolled out` 時，表示已順利升級外掛程式。

6. 驗證已順利升級 `ibmcloud-object-storage-driver`。
   ```
   kubectl rollout status ds/ibmcloud-object-storage-driver -n kube-system
   ```
   {: pre}

   當您在 CLI 輸出中看到 `daemon set "ibmcloud-object-storage-driver" successfully rolled out` 時，表示已順利升級。

7. 驗證 {{site.data.keyword.cos_full_notm}} Pod 處於 `Running` 狀態。
   ```
   kubectl get pods -n kube-system -o wide | grep object-storage
   ```
   {: pre}


### 移除 IBM Cloud Object Storage 外掛程式
{: #remove_cos_plugin}

如果您不要在叢集中佈建及使用 {{site.data.keyword.cos_full_notm}}，則可以解除安裝 Helm 圖表。

**附註：**移除外掛程式不會移除現有的 PVC、PV 或資料。移除外掛程式時，會從叢集裡移除所有相關的 Pod 及常駐程式集。除非您配置應用程式直接使用 {{site.data.keyword.cos_full_notm}} API，否則在移除外掛程式之後，無法針對叢集佈建新的 {{site.data.keyword.cos_full_notm}}，也無法使用現有的 PVC 及 PV。

開始之前：

- [將 CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。
- 確定叢集中沒有任何 PVC 或 PV 使用 {{site.data.keyword.cos_full_notm}}。若要列出所有可裝載特定 PVC 的 Pod，請執行 `kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.volumes[*]}{.persistentVolumeClaim.claimName}{" "}{end}{end}' | grep "<pvc_name>"`。

若要移除外掛程式，請執行下列動作：

1. 尋找 Helm 圖表的安裝名稱。
   ```
   helm ls | grep ibmcloud-object-storage-plugin
   ```
   {: pre}

   輸出範例：
   ```
   <helm_chart_name> 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-object-storage-plugin-1.0.0	default
   ```
   {: screen}

2. 移除 Helm 圖表，以刪除 {{site.data.keyword.cos_full_notm}} 外掛程式。
   ```
   helm delete --purge <helm_chart_name>
   ```
   {: pre}

3. 驗證已移除 {{site.data.keyword.cos_full_notm}} Pod。
   ```
   kubectl get pod -n kube-system | grep object-storage
   ```
   {: pre}

      如果 CLI 輸出中沒有顯示任何 Pod，則表示已順利移除 Pod。

4. 驗證已移除儲存空間類別。
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}

      如果 CLI 輸出中沒有顯示任何儲存空間類別，則表示已順利移除儲存空間類別。

5. 移除 `ibmc` Helm 外掛程式。
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

6. 驗證已移除 `ibmc` 外掛程式。
   ```
   helm plugin list
   ```
   {: pre}

   輸出範例：
   ```
   NAME	VERSION	DESCRIPTION
   ```
   {: screen}

   如果 CLI 輸出中未列出 `ibmc` 外掛程式，表示已順利移除 `ibmc` 外掛程式。


## 決定物件儲存空間配置
{: #configure_cos}

{{site.data.keyword.containerlong_notm}} 提供預先定義的儲存空間類別，您可以使用此類別搭配特定配置來建立儲存區。

1. 列出 {{site.data.keyword.containerlong_notm}} 中可用的儲存空間類別。
    
   ```
   kubectl get storageclasses | grep s3
   ```
   {: pre}

   輸出範例：
   ```
   ibmc-s3fs-cold-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-cold-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-cross-region            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-cross-region       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-perf-regional           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-flex-regional                ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-cross-region        ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-cross-region   ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-perf-regional       ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-standard-regional            ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-cross-region           ibm.io/ibmc-s3fs   8m
   ibmc-s3fs-vault-regional               ibm.io/ibmc-s3fs   8m
   ```
   {: screen}

2. 選擇符合資料存取需求的儲存空間類別。儲存空間類別決定儲存空間容量的[定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)、讀取和寫入作業，以及儲存區的出埠頻寬。適合您的選項，取決於在服務實例中讀取及寫入資料的頻率。
   - **標準**：此選項用於經常存取的熱資料。常見使用案例是 Web 或行動應用程式。
   - **加密配置檔**：此選項用於不常存取的工作負載或冷資料（例如一個月一次或更少）。常見使用案例是保存檔、短期資料保留、數位資產保留、磁帶更換及災難回復。
   - **冷**：此選項用於很少存取（每 90 天或更少）的冷資料或非作用中資料。常見使用案例是保存檔、長期備份、您針對法規遵循所保留的歷程資料，或很少存取的工作負載及應用程式。
   - **Flex**：此選項用於工作負載以及未遵循特定使用型樣的資料，或太大而無法決定或預測使用型樣的資料。**提示：**請查看此[部落格 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/03/interconnect-2017-changing-rules-storage/)，以瞭解 Flex 儲存空間類別與傳統儲存空間層級相較之下的運作方式。   

3. 決定儲存區中所儲存資料的備援層次。
   - **跨地區**：使用此選項時，您的資料會儲存在地理位置內的三個地區，以達到最高可用性。如果您的工作負載分散在多個地區，則會將要求遞送至最近的地區端點。根據您叢集所在的位置，稍早安裝的 `ibmc` Helm 外掛程式會自動設定地理位置的 API 端點。例如，如果您的叢集是在 `US South`，則會將您的儲存空間類別配置成使用您儲存區的 `US GEO` API 端點。如需相關資訊，請參閱[地區及端點](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints)。  
   - **地區**：使用此選項時，您的資料會抄寫至一個地區內的多個區域。如果您的工作負載位在相同的地區，則您會看到比跨地區設定還要低的延遲及更佳的效能。根據您叢集所在的位置，稍早安裝的 `ibm` Helm 外掛程式會自動設定地區端點。例如，如果您的叢集是在 `US South`，則已將您的儲存空間類別配置成使用 `US South` 作為儲存區的地區端點。如需相關資訊，請參閱[地區及端點](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints)。

4. 檢閱儲存空間類別的詳細 {{site.data.keyword.cos_full_notm}} 儲存區配置。
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   輸出範例：
   ```
   Name:                  ibmc-s3fs-standard-cross-region
   IsDefaultClass:        No
   Annotations:           <none>
   Provisioner:           ibm.io/ibmc-s3fs
   Parameters:            ibm.io/chunk-size-mb=16,ibm.io/curl-debug=false,ibm.io/debug-level=warn,ibm.io/iam-endpoint=https://iam.bluemix.net,ibm.io/kernel-cache=true,ibm.io/multireq-max=20,ibm.io/object-store-endpoint=https://s3-api.dal-us-geo.objectstorage.service.networklayer.com,ibm.io/object-store-storage-class=us-standard,ibm.io/parallel-count=2,ibm.io/s3fs-fuse-retry-count=5,ibm.io/stat-cache-size=100000,ibm.io/tls-cipher-suite=AESGCM
   AllowVolumeExpansion:  <unset>
   MountOptions:          <none>
   ReclaimPolicy:         Delete
   VolumeBindingMode:     Immediate
   Events:                <none>
   ```
   {: screen}

   <table>
   <caption>瞭解儲存空間類別詳細資料</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
   </thead>
   <tbody>
   <tr>
   <td><code>ibm.io/chunk-size-mb</code></td>
   <td>在 {{site.data.keyword.cos_full_notm}} 中讀取或寫入的資料區塊大小（以 MB 為單位）。名稱中包含 <code>perf</code> 的儲存空間類別設定為 52 MB。名稱中沒有 <code>perf</code> 的儲存空間類別使用 16 MB 的區塊。例如，如果您要讀取 1 GB 的檔案，則外掛程式會以多個 16 或 52 MB 區塊來讀取此檔案。</td>
   </tr>
   <tr>
   <td><code>ibm.io/curl-debug</code></td>
   <td>啟用記載傳送至 {{site.data.keyword.cos_full_notm}} 服務實例的要求。如果啟用，則會將日誌傳送至 `syslog`，而且您可以[將日誌轉遞至外部記載伺服器](cs_health.html#logging)。依預設，所有儲存空間類別都會設為 <strong>false</strong>，以停用此記載特性。</td>
   </tr>
   <tr>
   <td><code>ibm.io/debug-level</code></td>
   <td>{{site.data.keyword.cos_full_notm}} 外掛程式所設定的記載層次。所有儲存空間類別都已設定<strong>警告</strong>記載層次。</td>
   </tr>
   <tr>
   <td><code>ibm.io/iam-endpoint</code></td>
   <td>Identity and Access Management (IAM) 的 API 端點。</td>
   </tr>
   <tr>
   <td><code>ibm.io/kernel-cache</code></td>
   <td>啟用或停用磁區裝載點的核心緩衝區快取。如果啟用，從 {{site.data.keyword.cos_full_notm}} 讀取的資料會儲存在核心快取中，以確保對資料的快速讀取。如果停用，則不會快取資料，而且一律會從 {{site.data.keyword.cos_full_notm}} 進行讀取。已啟用 <code>standard</code> 及 <code>flex</code> 儲存空間類別的核心快取，並停用 <code>cold</code> 及 <code>vault</code> 儲存空間類別的核心快取。</td>
   </tr>
   <tr>
   <td><code>ibm.io/multireq-max</code></td>
   <td>可傳送至 {{site.data.keyword.cos_full_notm}} 服務實例以列出單一目錄中檔案的平行要求數目上限。所有儲存空間類別都已設定最多 20 個平行要求。</td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-endpoint</code></td>
   <td>用來存取 {{site.data.keyword.cos_full_notm}} 服務實例中儲存區的 API 端點。會根據您叢集的地區自動設定端點。</br></br><strong>附註：</strong>如果您要存取的現有儲存區位於與叢集所在地區不同的地區，則必須建立[自訂儲存空間類別](cs_storage_basics.html#customized_storageclass)，並使用您儲存區的 API 端點。</td>
   </tr>
   <tr>
   <td><code>ibm.io/object-store-storage-class</code></td>
   <td>儲存空間類別的名稱。</td>
   </tr>
   <tr>
   <td><code>ibm.io/parallel-count</code></td>
   <td>可傳送至 {{site.data.keyword.cos_full_notm}} 服務實例以進行單一讀取或寫入作業的平行要求數目上限。名稱中包含 <code>perf</code> 的儲存空間類別已設定最多 20 個平行要求。依預設，沒有 <code>perf</code> 的儲存空間類別已設定 2 個平行要求。</td>
   </tr>
   <tr>
   <td><code>ibm.io/s3fs-fuse-retry-count</code></td>
   <td>在作業視為不成功之前，讀取或寫入作業的重試次數上限。所有儲存空間類別都已設定最多 5 次重試。</td>
   </tr>
   <tr>
   <td><code>ibm.io/stat-cache-size</code></td>
   <td>保留在 {{site.data.keyword.cos_full_notm}} meta 資料快取中的記錄數目上限。每筆記錄最多可能需要 0.5 KB。依預設，所有儲存空間類別都會將記錄數目上限設為 100000。</td>
   </tr>
   <tr>
   <td><code>ibm.io/tls-cipher-suite</code></td>
   <td>透過 HTTPS 端點建立與 {{site.data.keyword.cos_full_notm}} 的連線時必須使用的 TLS 密碼組合。密碼組合的值必須遵循 [OpenSSL 格式 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html)。依預設，所有儲存空間類別都會使用 <strong>AESGCM</strong> 密碼組合。</td>
   </tr>
   </tbody>
   </table>

   如需每一個儲存空間類別的相關資訊，請參閱[儲存空間類別參照](#storageclass_reference)。如果您要變更任何預設值，請建立自己的[自訂儲存空間類別](cs_storage_basics.html#customized_storageclass)。
   {: tip}

5. 決定儲存區的名稱。儲存區的名稱在 {{site.data.keyword.cos_full_notm}} 中必須是唯一的。您也可以選擇由 {{site.data.keyword.cos_full_notm}} 外掛程式自動建立儲存區的名稱。若要在儲存區中組織資料，您可以建立子目錄。

   **附註：**您稍早選擇的儲存空間類別會決定整個儲存區的定價。您無法為子目錄定義不同的儲存空間類別。如果您要儲存具有不同存取需求的資料，請考量使用多個 PVC 建立多個儲存區。

6. 選擇是否要在刪除叢集或持續性磁區要求 (PVC) 之後保留您的資料及儲存區。當您刪除 PVC 時，一律會刪除 PV。當您刪除 PVC 時，可以選擇是否同時自動刪除資料及儲存區。您的 {{site.data.keyword.cos_full_notm}} 服務實例與您為資料選取的保留原則無關，因此當您刪除 PVC 時，永遠不會予以移除。

現在，您已決定想要的配置，即準備好[建立 PVC](#add_cos) 來佈建 {{site.data.keyword.cos_full_notm}}。

## 將物件儲存空間新增至應用程式
{: #add_cos}

建立持續性磁區要求 (PVC)，以為叢集佈建 {{site.data.keyword.cos_full_notm}}。
{: shortdesc}

根據您在 PVC 中選擇的設定，您可以使用下列方式來佈建 {{site.data.keyword.cos_full_notm}}：
- [動態佈建](cs_storage_basics.html#dynamic_provisioning)：當您建立 PVC 時，會自動建立相符的持續性磁區 (PV) 以及 {{site.data.keyword.cos_full_notm}} 服務實例中的儲存區。
- [靜態佈建](cs_storage_basics.html#static_provisioning)：您可以參照 PVC 之 {{site.data.keyword.cos_full_notm}} 服務實例中的現有儲存區。當您建立 PVC 時，只會自動建立相符的 PV，並將其鏈結至 {{site.data.keyword.cos_full_notm}} 中的現有儲存區。

開始之前：
- [建立及準備 {{site.data.keyword.cos_full_notm}} 服務實例](#create_cos_service)。
- [建立密碼來儲存 {{site.data.keyword.cos_full_notm}} 服務認證](#create_cos_secret)。
- [決定 {{site.data.keyword.cos_full_notm}} 的配置](#configure_cos)。

若要將 {{site.data.keyword.cos_full_notm}} 新增至叢集，請執行下列動作：

1. 建立配置檔以定義持續性磁區要求 (PVC)。
   ```
   kind: PersistentVolumeClaim
   apiVersion: v1
   metadata:
     name: <pvc_name>
     namespace: <namespace>
     annotations:
       volume.beta.kubernetes.io/storage-class: "<storage_class>"
       ibm.io/auto-create-bucket: "<true_or_false>"
       ibm.io/auto-delete-bucket: "<true_or_false>"
       ibm.io/bucket: "<bucket_name>"
       ibm.io/object-path: "<bucket_subdirectory>"
       ibm.io/secret-name: "<secret_name>"
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 8Gi # Enter a fictitious value
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
   <td><code>metadata/namespace</code></td>
   <td>輸入您要建立 PVC 的名稱空間。必須在您要建立 {{site.data.keyword.cos_full_notm}} 服務認證之 Kubernetes 密碼以及您要執行 Pod 的相同名稱空間中建立 PVC。</td>
   </tr>
   <tr>
   <td><code>volume.beta.kubernetes.io/storage-class</code></td>
   <td>請選擇下列選項：<ul><li>如果 <code>ibm.io/auto-create-bucket</code> 設為 <strong>true</strong>：請輸入要用於新儲存區的儲存空間類別。</li><li>如果 <code>ibm.io/auto-create-bucket</code> 設為 <strong>false</strong>：請輸入您用來建立現有儲存區的儲存空間類別。</br></br>如果您在 {{site.data.keyword.cos_full_notm}} 服務實例中手動建立儲存區，或記不住您使用的儲存空間類別，請在 {{site.data.keyword.Bluemix}} 儀表板中尋找服務實例，並檢閱現有儲存區的<strong>類別</strong>及<strong>位置</strong>。然後，使用適當的[儲存空間類別](#storageclass_reference)。</br></br><strong>附註：</strong>您儲存空間類別中所設定的 {{site.data.keyword.cos_full_notm}} API 端點，是根據您叢集所在的地區。如果您要存取的儲存區位於與叢集所在地區不同的地區，則必須建立[自訂儲存空間類別](cs_storage_basics.html#customized_storageclass)，並使用您儲存區的適當 API 端點。</li></ul>  </td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-create-bucket</code></td>
   <td>請選擇下列選項：<ul><li><strong>true</strong>：當您建立 PVC 時，會自動建立 PV 以及 {{site.data.keyword.cos_full_notm}} 服務實例中的儲存區。選擇此選項，以在 {{site.data.keyword.cos_full_notm}} 服務實例中建立新的儲存區。</li><li><strong>false</strong>：如果您要存取現有儲存區中的資料，請選擇此選項。當您建立 PVC 時，會自動建立 PV，並將其鏈結至您在 <code>ibm.io/bucket</code> 中指定的儲存區。</td>
   </tr>
   <tr>
   <td><code>ibm.io/auto-delete-bucket</code></td>
   <td>請選擇下列選項：<ul><li><strong>true</strong>：當您刪除 PVC 時，會自動移除您的資料、儲存區和 PV。您的 {{site.data.keyword.cos_full_notm}} 服務實例仍然存在，並未刪除。如果您選擇將此選項設為 <strong>true</strong>，則必須設定 <code>ibm.io/auto-create-bucket: true</code> 及 <code>ibm.io/bucket: ""</code>，以使用格式為 <code>tmp-s3fs-xxxx</code> 的名稱自動建立儲存區。</li><li><strong>false</strong>：當您刪除 PVC 時，會自動刪除 PV，但會保留您在 {{site.data.keyword.cos_full_notm}} 服務實例中的資料及儲存區。若要存取資料，您必須以現有儲存區的名稱建立新的 PVC。</li></ul>
   <tr>
   <td><code>ibm.io/bucket</code></td>
   <td>請選擇下列選項：<ul><li>如果 <code>ibm.io/auto-create-bucket</code> 設為 <strong>true</strong>：請輸入您要在 {{site.data.keyword.cos_full_notm}} 中建立的儲存區名稱。此外，如果 <code>ibm.io/auto-delete-bucket</code> 設為 <strong>true</strong>，則您必須將此欄位空白，以使用 <code>tmp-s3fs-xxxx</code> 格式的名稱自動指派儲存區。名稱在 {{site.data.keyword.cos_full_notm}} 中必須是唯一的。</li><li>如果 <code>ibm.io/auto-create-bucket</code> 設為 <strong>false</strong>：請輸入您要在叢集中存取的現有儲存區名稱。</li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/object-path</code></td>
   <td>選用項目：輸入儲存區中您要裝載的現有子目錄名稱。如果您只要裝載子目錄，而不是裝載整個儲存區，請使用此選項。若要裝載子目錄，您必須設定 <code>ibm.io/auto-create-bucket: "false"</code>，並提供 <code>ibm.io/bucket</code> 中儲存區的名稱。</li></ul> </td>
   </tr>
   <tr>
   <td><code>ibm.io/secret-name</code></td>
   <td>輸入保留您稍早建立之 {{site.data.keyword.cos_full_notm}} 認證的密碼名稱。</td>
   </tr>
   <tr>
   <td><code>resources/requests/storage</code></td>
   <td>您 {{site.data.keyword.cos_full_notm}} 儲存區的虛構大小（以 GB 為單位）。Kubernetes 需要大小，但 {{site.data.keyword.cos_full_notm}} 中不需要。您可以輸入任何想要的大小。您在 {{site.data.keyword.cos_full_notm}} 中使用的實際空間可能不同，並根據[定價表格 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api) 計費。</td>
   </tr>
   </tbody>
   </table>

2. 建立 PVC。
   ```
   kubectl apply -f filepath/pvc.yaml
   ```
   {: pre}

3. 驗證您的 PVC 已建立並已連結至 PV。
   ```
   kubectl get pvc
   ```
   {: pre}

   輸出範例：
   ```
   NAME                  STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                     AGE
   s3fs-test-pvc         Bound     pvc-b38b30f9-1234-11e8-ad2b-t910456jbe12   8Gi        RWO            ibmc-s3fs-standard-cross-region  1h
   ```
   {: screen}

4. 選用項目：如果您計劃使用非 root 使用者身分存取資料，或直接使用 GUI 或 API 將檔案新增至現有 {{site.data.keyword.cos_full_notm}} 儲存區，請確定已指派[檔案的正確許可權](cs_troubleshoot_storage.html#cos_nonroot_access)，讓您的應用程式可以根據需要順利讀取及更新檔案。

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
            securityContext:
              runAsUser: <non_root_user>
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
    <td><code>spec/containers/securityContext/runAsUser</code></td>
    <td>選用項目：若要使用非 root 使用者身分執行應用程式，請在未於部署 YAML 中設定 `fsGroup` 的情況下同時定義非 root 使用者，以指定 Pod 的[安全環境定義 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)。設定 `fsGroup`，即會在部署 Pod 時觸發 {{site.data.keyword.cos_full_notm}} 外掛程式更新儲存區中所有檔案的群組許可權。更新許可權是一項寫入作業，並影響效能。根據您的檔案數目，更新許可權可能會讓 Pod 無法啟動並進入 <code>Running</code> 狀態。</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>容器內裝載磁區之目錄的絕對路徑。</td>
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

7. 驗證您可以將資料寫入至 {{site.data.keyword.cos_full_notm}} 服務實例。
   1. 登入可裝載 PV 的 Pod。
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. 導覽至您在應用程式部署中定義的磁區裝載路徑。
   3. 建立文字檔。
      ```
      echo "This is a test" > test.txt
      ```
      {: pre}

   4. 從 {{site.data.keyword.Bluemix}} 儀表板中，導覽至您的 {{site.data.keyword.cos_full_notm}} 服務實例。
   5. 從功能表中，選取**儲存區**。
   6. 開啟儲存區，並驗證您可以看到所建立的 `test.txt`。


## 備份及還原資料
{: #backup_restore}

{{site.data.keyword.cos_full_notm}} 設定成提供您資料的高延續性，以保護您的資料不會遺失。您可以在 [{{site.data.keyword.cos_full_notm}} 服務條款 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-7857-03) 中找到 SLA。
{: shortdesc}

**重要事項：**{{site.data.keyword.cos_full_notm}} 不提供資料的版本歷程。如果您需要維護及存取舊版資料，則必須設定應用程式來管理資料的歷程，或實作替代備份解決方案。例如，您可能要將 {{site.data.keyword.cos_full_notm}} 資料儲存至內部部署資料庫，或使用磁帶來保存資料。

## 儲存空間類別參照
{: #storageclass_reference}

### 標準
{: #standard}

<table>
<caption>物件儲存空間類別：standard</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-s3fs-standard-cross-region</code></br><code>ibmc-s3fs-standard-perf-cross-region</code></br><code>ibmc-s3fs-standard-regional</code></br><code>ibmc-s3fs-standard-perf-regional</code></td>
</tr>
<tr>
<td>預設備援端點</td>
<td>根據您叢集所在的位置，自動設定備援端點。如需相關資訊，請參閱[地區及端點](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints)。</td>
</tr>
<tr>
<td>區塊大小</td>
<td>沒有 `perf` 的儲存空間類別：16 MB</br>具有 `perf` 的儲存空間類別：52 MB</td>
</tr>
<tr>
<td>核心快取</td>
<td>已啟用</td>
</tr>
<tr>
<td>計費</td>
<td>每月</td>
</tr>
<tr>
<td>定價</td>
<td>[定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### 加密配置檔
{: #Vault}

<table>
<caption>物件儲存空間類別：vault</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-s3fs-vault-cross-region</code></br><code>ibmc-s3fs-vault-regional</code></td>
</tr>
<tr>
<td>預設備援端點</td>
<td>根據您叢集所在的位置，自動設定備援端點。如需相關資訊，請參閱[地區及端點](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints)。</td>
</tr>
<tr>
<td>區塊大小</td>
<td>16 MB</td>
</tr>
<tr>
<td>核心快取</td>
<td>已停用</td>
</tr>
<tr>
<td>計費</td>
<td>每月</td>
</tr>
<tr>
<td>定價</td>
<td>[定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### 冷
{: #cold}

<table>
<caption>物件儲存空間類別：cold</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-s3fs-flex-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-flex-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>預設備援端點</td>
<td>根據您叢集所在的位置，自動設定備援端點。如需相關資訊，請參閱[地區及端點](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints)。</td>
</tr>
<tr>
<td>區塊大小</td>
<td>16 MB</td>
</tr>
<tr>
<td>核心快取</td>
<td>已停用</td>
</tr>
<tr>
<td>計費</td>
<td>每月</td>
</tr>
<tr>
<td>定價</td>
<td>[定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>

### Flex
{: #flex}

<table>
<caption>物件儲存空間類別：flex</caption>
<thead>
<th>特徵</th>
<th>設定</th>
</thead>
<tbody>
<tr>
<td>名稱</td>
<td><code>ibmc-s3fs-cold-cross-region</code></br><code>ibmc-s3fs-flex-perf-cross-region</code></br><code>ibmc-s3fs-cold-regional</code></br><code>ibmc-s3fs-flex-perf-regional</code></td>
</tr>
<tr>
<td>預設備援端點</td>
<td>根據您叢集所在的位置，自動設定備援端點。如需相關資訊，請參閱[地區及端點](/docs/services/cloud-object-storage/basics/endpoints.html#select-regions-and-endpoints)。</td>
</tr>
<tr>
<td>區塊大小</td>
<td>沒有 `perf` 的儲存空間類別：16 MB</br>具有 `perf` 的儲存空間類別：52 MB</td>
</tr>
<tr>
<td>核心快取</td>
<td>已啟用</td>
</tr>
<tr>
<td>計費</td>
<td>每月</td>
</tr>
<tr>
<td>定價</td>
<td>[定價 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</td>
</tr>
</tbody>
</table>
