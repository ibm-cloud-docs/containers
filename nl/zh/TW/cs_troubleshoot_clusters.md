---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# 叢集和工作者節點的疑難排解
{: #cs_troubleshoot_clusters}

在您使用 {{site.data.keyword.containerlong}} 時，請考慮使用這些技術來進行叢集和工作者節點的疑難排解。
{: shortdesc}

如果您有更一般性的問題，請嘗試[叢集除錯](cs_troubleshoot.html)。
{: tip}

## 無法連接至基礎架構帳戶
{: #cs_credentials}

{: tsSymptoms}
當您建立新的 Kubernetes 叢集時，會收到下列訊息。

```
We were unable to connect to your IBM Cloud infrastructure (SoftLayer) account. Creating a standard cluster requires that you have either a Pay-As-You-Go account
that is linked to an IBM Cloud infrastructure (SoftLayer) account term or that you have used the {{site.data.keyword.Bluemix_notm}}
Container Service CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

{: tsCauses}
具有未鏈結 {{site.data.keyword.Bluemix_notm}} 帳戶的使用者必須建立新的「隨收隨付制」帳戶，或使用 {{site.data.keyword.Bluemix_notm}} CLI 手動新增 IBM Cloud 基礎架構 (SoftLayer) API 金鑰。

{: tsResolve}
若要新增 {{site.data.keyword.Bluemix_notm}} 帳戶的認證，請執行下列動作：

1.  與您的 IBM Cloud 基礎架構 (SoftLayer) 管理者聯絡，以取得 IBM Cloud 基礎架構 (SoftLayer) 使用者名稱及 API 金鑰。

    **附註：**您使用的 IBM Cloud 基礎架構 (SoftLayer) 帳戶必須已設定「超級使用者」許可權，才能順利建立標準叢集。

2.  新增認證。

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  建立標準叢集。

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## 防火牆阻止執行 CLI 指令
{: #ts_firewall_clis}

{: tsSymptoms}
當您從 CLI 執行 `bx`、`kubectl` 或 `calicoctl` 指令時，它們會失敗。

{: tsCauses}
您的組織網路原則可能會導致無法透過 Proxy 或防火牆從本端系統存取公用端點。

{: tsResolve}
[容許 TCP 存取以讓 CLI 指令運作](cs_firewall.html#firewall)。此作業需要[管理者存取原則](cs_users.html#access_policies)。請驗證您的現行[存取原則](cs_users.html#infra_access)。


## 防火牆阻止叢集連接至資源
{: #cs_firewall}

{: tsSymptoms}
當工作者節點無法連接時，您可能會看到各種不同的症狀。kubectl Proxy 失敗，或您嘗試存取叢集中的服務，但連線失敗時，您可能會看到下列其中一則訊息。

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

如果您執行 kubectl exec、attach 或 logs，可能會看到下列訊息。

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

如果 kubectl Proxy 成功，但儀表板無法使用，您可能會看到下列訊息。

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
您可能已在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中設定其他防火牆，或自訂其中的現有防火牆設定。{{site.data.keyword.containershort_notm}} 需要開啟特定 IP 位址及埠，以容許從工作者節點到 Kubernetes 主節點的通訊，反之亦然。另一個原因可能是工作者節點停留在重新載入的迴圈中。

{: tsResolve}
[容許叢集存取基礎架構資源及其他服務](cs_firewall.html#firewall_outbound)。此作業需要[管理者存取原則](cs_users.html#access_policies)。請驗證您的現行[存取原則](cs_users.html#infra_access)。

<br />



## 使用 SSH 存取工作者節點失敗
{: #cs_ssh_worker}

{: tsSymptoms}
您無法使用 SSH 連線來存取工作者節點。

{: tsCauses}
工作者節點上已停用透過密碼的 SSH。

{: tsResolve}
對於您必須在任何必須執行一次性動作的每個節點或工作上執行的所有動作，使用[常駐程式集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。

<br />



## 將服務連結至叢集導致相同名稱錯誤
{: #cs_duplicate_services}

{: tsSymptoms}
當您執行 `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 時，看到下列。

```
Multiple services with the same name were found.
Run 'bx service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
多個服務實例可能在不同的地區中具有相同的名稱。

{: tsResolve}
請在 `bx cs cluster-service-bind` 指令中使用服務 GUID 而不要使用服務實例名稱。

1. [登入包含要連結之服務實例的地區。](cs_regions.html#bluemix_regions)

2. 取得服務實例的 GUID。
  ```
  bx service show <service_instance_name> --guid
  ```
  {: pre}

  輸出：
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. 再次將服務連結至叢集。
  ```
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## 更新或重新載入工作者節點之後，出現重複的節點和 Pod
{: #cs_duplicate_nodes}

{: tsSymptoms}
當您執行 `kubectl get nodes` 時，您會看到重複的工作者節點，並顯示狀態 **NotReady**。具有 **NotReady** 的工作者節點具有公用 IP 位址，而具有 **Ready** 的工作者節點則具有專用 IP 位址。

{: tsCauses}
較舊的叢集會讓工作者節點依叢集的公用 IP 位址列出。現在，工作者節點會依叢集的專用 IP 位址列出。當您重新載入或更新節點時，IP 位址會變更，但對公用 IP 位址的參照則照舊。

{: tsResolve}
不會因為這些重複項目而中斷服務，但您應該從 API 伺服器移除舊的工作者節點參照。

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />


## 更新或重新載入工作者節點之後，應用程式收到 RBAC DENY 錯誤
{: #cs_rbac_deny}

{: tsSymptoms}
更新至 Kubernetes 1.7 版之後，應用程式收到 `RBAC DENY` 錯誤。

{: tsCauses}
自 [Kubernetes 1.7 版](cs_versions.html#cs_v17)起，在 `default` 名稱空間中執行的應用程式，對 Kubernetes API 不再具有叢集管理者專用權，以加強安全。

如果您的應用程式是在 `default` 名稱空間中執行、使用 `default ServiceAccount`，並且存取 Kubernetes API，則它會受到這項 Kubernetes 變更的影響。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/authorization/rbac/#upgrading-from-15)。

{: tsResolve}
開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

1.  **暫時動作**：當您更新應用程式 RBAC 原則時，建議您針對 `default` 名稱空間中的 `default ServiceAccount`，暫時回復到先前的 `ClusterRoleBinding`。

    1.  複製下列 `.yaml` 檔。

        ```yaml
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-nonResourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-nonResourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-resourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-resourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ```

    2.  將 `.yaml` 檔套用至您的叢集。

        ```
        kubectl apply -f FILENAME
        ```
        {: pre}

2.  [建立 RBAC 授權資源![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) 以更新 `ClusterRoleBinding` 管理存取。

3.  如果您已建立暫時叢集角色連結，請將其移除。

<br />


## 在新工作者節點上存取 Pod 因逾時而失敗
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
您已刪除叢集中的工作者節點，然後新增工作者節點。若您已部署 Pod 或 Kubernetes 服務，資源即無法存取新建立的工作者節點，且連線逾時。

{: tsCauses}
如果您從叢集中刪除工作者節點，然後新增工作者節點，則可能會將已刪除工作者節點的專用 IP 位址指派給新的工作者節點。Calico 使用此專用 IP 位址作為標籤，並繼續嘗試聯繫已刪除的節點。

{: tsResolve}
手動更新專用 IP 位址的參照，以指向正確的節點。

1.  確認您有兩個具有相同**專用 IP** 位址的工作者節點。請記下已刪除之工作者節點的**專用 IP** 及 **ID**。

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.8.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.8.11
  ```
  {: screen}

2.  安裝 [Calico CLI](cs_network_policy.html#adding_network_policies)。
3.  列出 Calico 中的可用工作者節點。請將 &lt;path_to_file> 取代為 Calico 配置檔的本端路徑。

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  刪除 Calico 中的重複工作者節點。請將 NODE_ID 取代為工作者節點 ID。

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  將未刪除的工作者節點重新開機。

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


已刪除的節點不再列於 Calico 中。

<br />


## 叢集保持在擱置狀態
{: #cs_cluster_pending}

{: tsSymptoms}
當您部署叢集時，它保持在擱置狀態，且未啟動。

{: tsCauses}
如果您才剛建立叢集，則可能仍在配置工作者節點。如果您已等待一段時間，則可能有一個無效的 VLAN。

{: tsResolve}

您可以嘗試下列其中一種解決方案：
  - 執行 `bx cs clusters`，來檢查叢集的狀態。然後，執行 `bx cs workers <cluster_name>`，來檢查並確定工作者節點已部署。
  - 查看您的 VLAN 是否有效。VLAN 若要有效，則必須與基礎架構相關聯，且該基礎架構可以管理具有本端磁碟儲存空間的工作者節點。您可以藉由執行 `bx cs vlans LOCATION` 來[列出 VLAN](/docs/containers/cs_cli_reference.html#cs_vlans)，如果 VLAN 未顯示在清單中，則它是無效的。請選擇其他 VLAN。

<br />


## Pod 保持擱置狀態
{: #cs_pods_pending}

{: tsSymptoms}
當您執行 `kubectl get pods` 時，可以看到保持 **Pending** 狀態的 Pod。

{: tsCauses}
如果您才剛剛建立 Kubernetes 叢集，則可能仍在配置工作者節點。如果此叢集是現有叢集，則您的叢集中可能沒有足夠的容量可部署 Pod。

{: tsResolve}
此作業需要[管理者存取原則](cs_users.html#access_policies)。請驗證您的現行[存取原則](cs_users.html#infra_access)。

如果您才剛剛建立 Kubernetes 叢集，請執行下列指令，並等待起始設定工作者節點。

```
kubectl get nodes
```
{: pre}

如果此叢集是現有叢集，請檢查叢集容量。

1.  使用預設埠號來設定 Proxy。

  ```
  kubectl proxy
  ```
   {: pre}

2.  開啟 Kubernetes 儀表板。

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  確認您的叢集中是否有足夠的容量可部署 Pod。

4.  如果您的叢集中沒有足夠的容量，請將另一個工作者節點新增至叢集。

  ```
  bx cs worker-add <cluster_name_or_ID> 1
  ```
  {: pre}

5.  如果您的 Pod 在工作者節點完整部署之後仍然保持 **pending** 狀態，請檢閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending)，以進一步對 Pod 的擱置中狀態進行疑難排解。

<br />




## 容器未啟動
{: #containers_do_not_start}

{: tsSymptoms}
Pod 順利部署至叢集，但容器未啟動。

{: tsCauses}
在達到登錄配額時，容器可能無法啟動。

{: tsResolve}
[請釋放 {{site.data.keyword.registryshort_notm}} 中的儲存空間。](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />



## 無法安裝具有已更新配置值的 Helm 圖表
{: #cs_helm_install}

{: tsSymptoms}
當您嘗試執行 `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>` 來安裝已更新的 Helm 圖表時，您看到 `Error: failed to download "ibm/<chart_name>"` 錯誤訊息。

{: tsCauses}
在 Helm 實例中，{{site.data.keyword.Bluemix_notm}} 儲存庫的 URL 可能不正確。

{: tsResolve}
若要對 Helm 圖表進行疑難排解，請執行下列動作：

1. 列出 Helm 實例中目前可用的儲存庫。

    ```
    helm repo list
    ```
    {: pre}

2. 在輸出中，驗證 {{site.data.keyword.Bluemix_notm}} 儲存庫 `ibm` 的 URL 為 `https://registry.bluemix.net/helm/ibm`。

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * 如果 URL 不正確，請執行下列動作：

        1. 移除 {{site.data.keyword.Bluemix_notm}} 儲存庫。

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. 再次新增 {{site.data.keyword.Bluemix_notm}} 儲存庫。

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * 如果 URL 正確無誤，則從儲存庫取得最新的更新。

        ```
        helm repo update
        ```
        {: pre}

3. 安裝含有更新的 Helm 圖表。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## 取得協助及支援
{: #ts_getting_help}

叢集仍有問題？
{: shortdesc}

-   若要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，請[檢查 {{site.data.keyword.Bluemix_notm}} 狀態頁面 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/bluemix/support/#status)。
-   將問題張貼到 [{{site.data.keyword.containershort_notm}} Slack ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://ibm-container-service.slack.com)。如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶未使用 IBM ID，請[要求邀請](https://bxcs-slack-invite.mybluemix.net/)以加入此 Slack。
    {: tip}
-   檢閱討論區，以查看其他使用者是否發生過相同的問題。使用討論區提問時，請標記您的問題，以便 {{site.data.keyword.Bluemix_notm}} 開發團隊能看到它。

    -   如果您在使用 {{site.data.keyword.containershort_notm}} 開發或部署叢集或應用程式時有技術方面的問題，請將問題張貼到 [Stack Overflow ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers)，並使用 `ibm-cloud`、`kubernetes` 及 `containers` 來標記問題。
    -   若為服務及開始使用指示的相關問題，請使用 [IBM developerWorks dW Answers ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 討論區。請包含 `ibm-cloud` 及 `containers` 標籤。如需使用討論區的詳細資料，請參閱[取得協助](/docs/get-support/howtogetsupport.html#using-avatar)。

-   開立問題單以與 IBM 支援中心聯絡。如需開立 IBM 支援問題單或是支援層次與問題單嚴重性的相關資訊，請參閱[與支援中心聯絡](/docs/get-support/howtogetsupport.html#getting-customer-support)。

{:tip}
報告問題時，請包含您的叢集 ID。若要取得叢集 ID，請執行 `bx cs clusters`。


