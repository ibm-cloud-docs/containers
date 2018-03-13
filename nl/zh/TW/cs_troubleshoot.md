---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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


# 叢集的疑難排解
{: #cs_troubleshoot}

在您使用 {{site.data.keyword.containershort_notm}} 時，請考慮使用這些技術來進行疑難排解以及取得協助。您也可以檢查 [{{site.data.keyword.Bluemix_notm}} 系統的狀態 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/bluemix/support/#status)。

您可以採取一些一般步驟來確保叢集保持最新：
- 定期[重新啟動工作者節點](cs_cli_reference.html#cs_worker_reboot)，以確保安裝 IBM 自動部署至作業系統的更新項目及安全修補程式
- 將叢集更新為 {{site.data.keyword.containershort_notm}} 的[最新預設 Kubernetes 版本](cs_versions.html)

{: shortdesc}

<br />




## 叢集除錯
{: #debug_clusters}

請檢閱選項以進行叢集除錯，並找出失敗的主要原因。

1.  列出叢集，並尋找叢集的 `State`。

  ```
  bx cs clusters
  ```
  {: pre}

2.  檢閱叢集的 `State`。

  <table summary="每個表格列都應該從左到右閱讀，第一欄為叢集狀態，第二欄則為說明。">
    <thead>
    <th>叢集狀態</th>
    <th>說明</th>
    </thead>
    <tbody>
  
  <tr>
      <td>Critical</td>
      <td>無法呼叫到 Kubernetes 主節點，或叢集中的所有工作者節點都已關閉。</td>
     </tr>
  
      <tr>
        <td>Deploying</td>
        <td>Kubernetes 主節點尚未完整部署。您無法存取叢集。</td>
       </tr>
       <tr>
        <td>Normal</td>
        <td>叢集中的所有工作者節點都已開始執行。您可以存取叢集，並將應用程式部署至叢集。</td>
     </tr>
       <tr>
        <td>Pending</td>
        <td>已部署 Kubernetes 主節點。正在佈建工作者節點，因此還無法在叢集中使用。您可以存取叢集，但無法將應用程式部署至叢集。</td>
      </tr>
  
     <tr>
        <td>Warning</td>
        <td>叢集中至少有一個工作者節點無法使用，但有其他工作者節點可用，並且可以接管工作負載。</td>
     </tr>  
    </tbody>
  </table>

3.  如果叢集處於 **Warning**、**Critical** 或 **Delete failed** 狀態，或停留在 **Pending** 狀態很長一段時間，請檢閱工作者節點的狀態。如果叢集處於 **Deploying** 狀態，請等待叢集完整部署，以檢閱叢集的性能。處於 **Normal** 狀態的叢集目前不需要採取動作。 
<p>若要檢閱工作者節點的狀態，請執行下列動作：</p>

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

  <table summary="每個表格列都應該從左到右閱讀，第一欄為叢集狀態，第二欄則為說明。">
    <thead>
    <th>工作者節點狀態</th>
    <th>說明</th>
    </thead>
    <tbody>
      <tr>
       <td>Unknown</td>
       <td>因下列其中一個原因而無法呼叫到 Kubernetes 主節點：<ul><li>您已要求更新 Kubernetes 主節點。在更新期間，無法擷取工作者節點的狀態。</li><li>您可能有額外的防火牆保護工作者節點，或最近變更過防火牆設定。{{site.data.keyword.containershort_notm}} 需要開啟特定 IP 位址及埠，以容許從工作者節點到 Kubernetes 主節點的通訊，反之亦然。如需相關資訊，請參閱[防火牆阻止工作者節點連接](#cs_firewall)。</li><li>Kubernetes 主節點已關閉。請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](/docs/get-support/howtogetsupport.html#getting-customer-support)，以與 {{site.data.keyword.Bluemix_notm}} 支援中心聯絡。</li></ul></td>
      </tr>
      <tr>
        <td>Provisioning</td>
        <td>正在佈建工作者節點，因此還無法在叢集中使用。您可以在 CLI 輸出的 **Status** 直欄中監視佈建處理程序。如果您的工作者節點停留在這個狀態很長一段時間，因此在 **Status** 直欄中看不到任何進度，請繼續進行下一步，以查看佈建期間是否發生問題。</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>無法佈建工作者節點。請繼續進行下一步，以尋找失敗的詳細資料。</td>
      </tr>
      <tr>
        <td>Reloading</td>
        <td>正在重新載入工作者節點，因此無法在叢集中使用。您可以在 CLI 輸出的 **Status** 直欄中監視重新載入處理程序。如果您的工作者節點停留在這個狀態很長一段時間，因此在 **Status** 直欄中看不到任何進度，請繼續進行下一步，以查看重新載入期間是否發生問題。</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>無法重新載入工作者節點。請繼續進行下一步，以尋找失敗的詳細資料。</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>工作者節點已完整佈建，並已備妥可用於叢集。</td>
     </tr>
     <tr>
        <td>Warning</td>
        <td>工作者節點將達到記憶體或磁碟空間的限制。</td>
     </tr>
     <tr>
      <td>Critical</td>
      <td>工作者節點已耗盡磁碟空間。</td>
     </tr>
    </tbody>
  </table>

4.  列出工作者節點的詳細資料。

  ```
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

5.  檢閱一般錯誤訊息，並瞭解其解決方式。

  <table>
    <thead>
    <th>錯誤訊息</th>
    <th>說明及解決方式
    </thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：您的帳戶目前被禁止訂購「運算實例」。</td>
        <td>您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶可能無法訂購運算資源。請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](/docs/get-support/howtogetsupport.html#getting-customer-support)，以與 {{site.data.keyword.Bluemix_notm}} 支援中心聯絡。</td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：無法下單。路由器 'router_name' 的資源不足，無法滿足下列來賓的要求：'worker_id'。</td>
        <td>您選取的 VLAN 與空間不足無法佈建工作者節點之資料中心內的 Pod 相關聯。您可以選擇下列選項：<ul><li>使用不同的資料中心來佈建工作者節點。執行 <code>bx cs locations</code> 來列出可用的資料中心。<li>如果您的現有公用及專用 VLAN 配對與資料中心內的另一個 Pod 相關聯，請改用此 VLAN 配對。<li>請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](/docs/get-support/howtogetsupport.html#getting-customer-support)，以與 {{site.data.keyword.Bluemix_notm}} 支援中心聯絡。</ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：無法取得 ID 為 &lt;vlan id&gt; 的網路 VLAN。</td>
        <td>無法佈建工作者節點，因為因下列其中一個原因而找不到選取的 VLAN ID：<ul><li>您可能已指定 VLAN 號碼，而非 VLAN ID。VLAN 號碼的長度是 3 或 4 位數，而 VLAN ID 的長度是 7 位數。執行 <code>bx cs vlans &lt;location&gt;</code>，以擷取 VLAN ID。<li>VLAN ID 可能未與您使用的 IBM Cloud 基礎架構 (SoftLayer) 帳戶相關聯。執行 <code>bx cs vlans &lt;location&gt;</code>，以列出帳戶的可用 VLAN ID。若要變更 IBM Cloud 基礎架構 (SoftLayer) 帳戶，請參閱 [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)。</ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation：針對此訂單提供的位置無效。(HTTP 500)</td>
        <td>您的 IBM Cloud 基礎架構 (SoftLayer) 未設定成訂購所選取資料中心內的運算資源。請與 [{{site.data.keyword.Bluemix_notm}} 支援中心](/docs/get-support/howtogetsupport.html#getting-customer-support)聯絡，驗證已正確設定帳戶。</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：使用者沒有新增伺服器的必要 {{site.data.keyword.Bluemix_notm}} 基礎架構許可權


        </br></br>
        {{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：必須要有許可權才能訂購「項目」。</td>
        <td>您可能沒有從 IBM Cloud 基礎架構 (SoftLayer) 組合佈建工作者節點的必要許可權。請參閱[配置對 IBM Cloud 基礎架構 (SoftLayer) 組合的存取權以建立標準 Kubernetes 叢集](cs_infrastructure.html#unify_accounts)。</td>
      </tr>
    </tbody>
  </table>

<br />




## 應用程式部署除錯
{: #debug_apps}

請檢閱您既有的選項以進行應用程式部署除錯，並找出失敗的主要原因。

1. 執行 `describe` 指令，以尋找服務或部署資源中的異常狀況。

 範例：
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [檢查容器是否停留在 ContainerCreating 狀態](#stuck_creating_state)。

3. 檢查叢集是否處於 `Critical` 狀態。如果叢集處於 `Critical` 狀態中，請檢查防火牆規則，確認主節點可以與工作者節點通訊。

4. 驗證服務正在接聽正確的埠。
   1. 取得 Pod 的名稱。
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. 登入容器。
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. 從容器內 Curl 應用程式。如果無法存取埠，服務可能未接聽正確的埠，或是應用程式可能有問題。請使用正確的埠來更新服務的配置檔，並重新部署或調查應用程式的潛在問題。
     <pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. 驗證服務已正確鏈結至 Pod。
   1. 取得 Pod 的名稱。
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. 登入容器。
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Curl 服務的叢集 IP 位址及埠。如果無法存取 IP 位址及埠，請查看服務的端點。如果沒有端點，則服務的選取器與 Pod 不符。如果有端點，請查看服務上的目標埠欄位，並確定目標埠與用於 Pod 的埠相同。
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. 對於 Ingress 服務，驗證可以從叢集內存取服務。
   1. 取得 Pod 的名稱。
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. 登入容器。
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Curl 為 Ingress 服務指定的 URL。如果無法存取 URL，請檢查叢集與外部端點之間是否有防火牆問題。
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />


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
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b2c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b2c.4x16       deleted    -
  ```
  {: screen}

2.  安裝 [Calico CLI](cs_network_policy.html#adding_network_policies)。
3.  列出 Calico 中的可用工作者節點。請將 &lt;path_to_file> 取代為 Calico 配置檔的本端路徑。

  ```
  calicoctl get nodes --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2
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
  bx cs worker-add <cluster name or id> 1
  ```
  {: pre}

5.  如果您的 Pod 在工作者節點完整部署之後仍然保持 **pending** 狀態，請檢閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending)，以進一步對 Pod 的擱置中狀態進行疑難排解。

<br />




## Pod 停留在建立中狀態
{: #stuck_creating_state}

{: tsSymptoms}
當您執行 `kubectl get pods -o wide` 時，您會看到在同一個工作者節點上執行的多個位置停留在 `ContainerCreating` 狀態中。

{: tsCauses}
工作者節點上的檔案系統是唯讀的。

{: tsResolve}
1. 備份可能儲存在工作者節點或容器上的任何資料。
2. 執行下列指令，以重建工作者節點。

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

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




## 日誌未出現
{: #cs_no_logs}

{: tsSymptoms}
存取 Kibana 儀表板時，未顯示任何日誌。

{: tsResolve}
請檢閱下列原因，以了解日誌為何未出現以及對應的疑難排解步驟：

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>發生原因</th>
 <th>修正方式</th>
 </thead>
 <tbody>
 <tr>
 <td>未設定任何記載配置。</td>
 <td>若要傳送日誌，您必須先建立記載配置，以將日誌轉遞給 {{site.data.keyword.loganalysislong_notm}}。若要建立記載配置，請參閱<a href="cs_health.html#log_sources_enable">啟用日誌轉遞</a>。</td>
 </tr>
 <tr>
 <td>叢集未處於 <code>Normal</code> 狀態。</td>
 <td>若要檢查叢集的狀態，請參閱<a href="cs_troubleshoot.html#debug_clusters">叢集除錯</a>。</td>
 </tr>
 <tr>
 <td>已達到日誌儲存空間配額。</td>
 <td>若要增加日誌儲存空間限制，請參閱 <a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html">{{site.data.keyword.loganalysislong_notm}} 文件</a>。</td>
 </tr>
 <tr>
 <td>如果您在建立叢集時指定了空間，則帳戶擁有者對該空間沒有「管理員」、「開發人員」或「審核員」許可權。</td>
 <td>若要變更帳戶擁有者的存取權，請執行下列動作：<ol><li>若要找出叢集的帳戶擁有者是誰，請執行 <code>bx cs api-key-info &lt;cluster_name_or_ID&gt;</code>。</li><li>若要授與該帳戶擁有者對空間的「管理員」、「開發人員」或「審核員」等 {{site.data.keyword.containershort_notm}} 存取許可權，請參閱<a href="cs_users.html#managing">管理叢集存取</a>。</li><li>若要在許可權變更之後重新整理記載記號，請執行 <code>bx cs logging-config-refresh &lt;cluster_name_or_ID&gt;</code>。</li></ol></td>
 </tr>
 </tbody></table>

若要測試您在疑難排解期間所做的變更，您可以在叢集中的工作者節點上部署 Noisy，這是可以產生數個日誌事件的範例 Pod。

  1. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要在其中開始產生日誌的叢集。

  2. 建立 `deploy-noisy.yaml` 配置檔。

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: noisy
      spec:
        containers:
        - name: noisy
          image: ubuntu:16.04
          command: ["/bin/sh"]
          args: ["-c", "while true; do sleep 10; echo 'Hello world!'; done"]
          imagePullPolicy: "Always"
        ```
        {: codeblock}

  3. 在叢集的環境定義中執行配置檔。

        ```
        kubectl apply -f <filepath_to_noisy>
        ```
        {:pre}

  4. 幾分鐘之後，您可以在 Kibana 儀表板中檢視日誌。若要存取 Kibana 儀表板，請移至下列其中一個 URL，然後選取您建立叢集所在的 {{site.data.keyword.Bluemix_notm}} 帳戶。如果您在建立叢集時指定了空間，請改為移至該空間。
      - 美國南部及美國東部：https://logging.ng.bluemix.net
      - 英國南部：https://logging.eu-gb.bluemix.net
      - 歐盟中部：https://logging.eu-fra.bluemix.net
      - 亞太地區南部：https://logging.au-syd.bluemix.net

<br />




## Kubernetes 儀表板未顯示使用率圖形
{: #cs_dashboard_graphs}

{: tsSymptoms}
存取 Kubernetes 儀表板時，未顯示任何使用率圖形。

{: tsCauses}
有時，在叢集更新或工作者節點重新啟動之後，`kube-dashboard` Pod 並未更新。

{: tsResolve}
刪除 `kube-dashboard` Pod，以強制重新啟動。系統會以 RBAC 原則重建 Pod，存取 heapster 以取得使用率資訊。

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## 無法透過負載平衡器服務連接至應用程式
{: #cs_loadbalancer_fails}

{: tsSymptoms}
您已透過在叢集中建立負載平衡器服務，來公開應用程式。當您嘗試透過負載平衡器的公用 IP 位址連接至應用程式時，連線失敗或逾時。

{: tsCauses}
負載平衡器服務可能因下列其中一個原因而未正常運作：

-   叢集是免費叢集或只有一個工作者節點的標準叢集。
-   尚未完整部署叢集。
-   負載平衡器服務的配置 Script 包含錯誤。

{: tsResolve}
若要對負載平衡器服務進行疑難排解，請執行下列動作：

1.  確認您所設定的標準叢集已完整部署並且至少有兩個工作者節點，以確保負載平衡器服務的高可用性。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    在 CLI 輸出中，確定工作者節點的 **Status** 顯示 **Ready**，而且 **Machine Type** 顯示 **free** 以外的機型。

2.  檢查負載平衡器服務配置檔的正確性。

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myservice
  spec:
    type: LoadBalancer
    selector:
      <selectorkey>:<selectorvalue>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: pre}

    1.  確認您已將 **LoadBalancer** 定義為服務的類型。
    2.  確定您使用了與部署應用程式時在 **label/metadata** 區段中所使用的相同 **<selectorkey>** 及 **<selectorvalue>**。
    3.  確認您已使用應用程式所接聽的**埠**。

3.  檢查負載平衡器服務，並檢閱**事件**區段來尋找可能的錯誤。

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    尋找下列錯誤訊息：
    

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>若要使用負載平衡器服務，您必須有至少包含兩個工作者節點的標準叢集。
    </li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>此錯誤訊息指出未將可攜式公用 IP 位址配置給負載平衡器服務。請參閱<a href="cs_subnets.html#subnets">將子網路新增至叢集</a>，以尋找如何要求叢集之可攜式公用 IP 位址的相關資訊。叢集可以使用可攜式公用 IP 位址之後，會自動建立負載平衡器服務。
    </li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>您已使用 **loadBalancerIP** 區段定義負載平衡器服務的可攜式公用 IP 位址，但在可攜式公用子網路中無法使用此可攜式公用 IP 位址。請變更負載平衡器服務配置 Script，然後選擇其中一個可用的可攜式公用 IP 位址，或是移除 Script 中的 **loadBalancerIP** 區段，以便能自動配置可用的可攜式公用 IP 位址。
    </li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>您沒有足夠的工作者節點可部署負載平衡器服務。其中一個原因可能是您所部署的標準叢集有多個工作者節點，但佈建工作者節點失敗。
    </li>
    <ol><li>列出可用的工作者節點。</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>如果找到至少兩個可用的工作者節點，則會列出工作者節點詳細資料。</br><pre class="screen"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li>確定 <code>kubectl get nodes</code> 及 <code>bx cs [&lt;cluster_name_or_id&gt;] worker-get</code> 指令所傳回的工作者節點的公用及專用 VLAN ID 相符。</li></ol></li></ul>

4.  如果您要使用自訂網域連接至負載平衡器服務，請確定已將自訂網域對映至負載平衡器服務的公用 IP 位址。
    1.  尋找負載平衡器服務的公用 IP 位址。

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  確認在「指標記錄 (PTR)」中已將自訂網域對映至負載平衡器服務的可攜式公用 IP 位址。

<br />


## 無法透過 Ingress 連接至應用程式
{: #cs_ingress_fails}

{: tsSymptoms}
您已透過在叢集中建立應用程式的 Ingress 資源，來公開應用程式。當您嘗試透過 Ingress 應用程式負載平衡器的公用 IP 位址或子網域連接至應用程式時，連線失敗或逾時。

{: tsCauses}
Ingress 可能未正常運作，原因如下：
<ul><ul>
<li>尚未完整部署叢集。
<li>叢集已設定為免費叢集或只有一個工作者節點的標準叢集。
<li>Ingress 配置 Script 包含錯誤。
</ul></ul>

{: tsResolve}
若要對 Ingress 進行疑難排解，請執行下列動作：

1.  確認您所設定的標準叢集已完整部署並且至少有兩個工作者節點，以確保 Ingress 應用程式負載平衡器的高可用性。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    在 CLI 輸出中，確定工作者節點的 **Status** 顯示 **Ready**，而且 **Machine Type** 顯示 **free** 以外的機型。

2.  擷取 Ingress 應用程式負載平衡器子網域及公用 IP 位址，然後對其進行連線測試。

    1.  擷取 Ingress 控制器子網域。

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  對 Ingress 應用程式負載平衡器子網域進行連線測試。

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  擷取 Ingress 應用程式負載平衡器的公用 IP 位址。

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  對 Ingress 應用程式負載平衡器公用 IP 位址進行連線測試。

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    如果 CLI 傳回 Ingress 應用程式負載平衡器公用 IP 位址或子網域的逾時，並且已設定保護工作者節點的自訂防火牆，您可能需要開啟[防火牆](#cs_firewall)中的其他埠及網路群組。

3.  如果您要使用自訂網域，請確定使用「網域名稱服務 (DNS)」提供者將自訂網域對映至 IBM 所提供 Ingress 應用程式負載平衡器的公用 IP 位址或子網域。
    1.  如果您已使用 Ingress 應用程式負載平衡器子網域，請檢查「標準名稱記錄 (CNAME)」。
    2.  如果您已使用 Ingress 應用程式負載平衡器公用 IP 位址，請確認已在「指標記錄 (PTR)」中將自訂網域對映至可攜式公用 IP 位址。
4.  檢查 Ingress 資源配置檔。

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress_subdomain>
        secretName: <ingress_tlssecret>
      rules:
      - host: <ingress_subdomain>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  確認 Ingress 應用程式負載平衡器子網域及 TLS 憑證正確無誤。若要尋找 IBM 提供的子網域及 TLS 憑證，請執行 bx cs cluster-get <cluster_name_or_id>。
    2.  確定應用程式接聽與 Ingress 之 **path** 區段中配置相同的路徑。如果您的應用程式設定成接聽根路徑，請包含 **/** 作為路徑。
5.  檢查 Ingress 部署，並尋找可能的錯誤訊息。

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  檢查 Ingress 控制器的日誌。
    1.  擷取在叢集中執行的 Ingress Pod 的 ID。

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  擷取每一個 Ingress Pod 的日誌。

      ```
      kubectl logs <ingress_pod_id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  尋找 Ingress 控制器日誌中的錯誤訊息。

<br />



## Ingress 應用程式負載平衡器 Secret 問題
{: #cs_albsecret_fails}

{: tsSymptoms}
將 Ingress 應用程式負載平衡器 Secret 部署到叢集之後，當您在 {{site.data.keyword.cloudcerts_full_notm}} 檢視憑證時，`Description` 欄位不會更新 Secret 名稱。

當您列出應用程式負載平衡器 Secret 的相關資訊時，狀態指出 `*_failed`。例如，`create_failed`、`update_failed`、`delete_failed`。

{: tsResolve}
請檢閱下列原因，以了解應用程式負載平衡器 Secret 為何失敗以及對應的疑難排解步驟：

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>發生原因</th>
 <th>修正方式</th>
 </thead>
 <tbody>
 <tr>
 <td>您沒有必要的存取角色，無法下載及更新憑證資料。</td>
 <td>請洽詢帳戶管理者，指派您 {{site.data.keyword.cloudcerts_full_notm}} 實例的**操作員**和**編輯者**角色。如需詳細資料，請參閱 {{site.data.keyword.cloudcerts_short}} 的 <a href="/docs/services/certificate-manager/about.html#identity-access-management">Identity and Access Management</a>。</td>
 </tr>
 <tr>
 <td>建立、更新或移除時提供的憑證 CRN 與叢集不屬於相同的帳戶。</td>
 <td>請確定您提供的憑證 CRN 已匯入到部署在與叢集相同帳戶中的 {{site.data.keyword.cloudcerts_short}} 服務實例。</td>
 </tr>
 <tr>
 <td>建立時提供的憑證 CRN 不正確。</td>
 <td><ol><li>檢查您提供之憑證 CRN 字串的正確性。</li><li>如果發現憑證 CRN 正確，那麼請嘗試更新 Secret。<pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>如果這個指令導致 <code>update_failed</code> 狀態，則請移除 Secret。<pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>再次部署 Secret。<pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>更新時提供的憑證 CRN 不正確。</td>
 <td><ol><li>檢查您提供之憑證 CRN 字串的正確性。</li><li>如果發現憑證 CRN 正確，那麼請移除 Secret。<pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>再次部署 Secret。<pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>嘗試更新 Secret。<pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>{{site.data.keyword.cloudcerts_long_notm}} 服務遭遇關閉時間。</td>
 <td>確定您的 {{site.data.keyword.cloudcerts_short}} 服務已啟動並執行。</td>
 </tr>
 </tbody></table>

<br />



## 無法擷取 Calico CLI 配置的 ETCD URL
{: #cs_calico_fails}

{: tsSymptoms}
當您擷取 `<ETCD_URL>` 以[新增網路原則](cs_network_policy.html#adding_network_policies)時，得到 `calico-config not found` 錯誤訊息。

{: tsCauses}
您的叢集不是 [Kubernetes 1.7 版](cs_versions.html)或更新版本。

{: tsResolve}
請[更新叢集](cs_cluster_update.html#master)或使用與舊版 Kubernetes 相容的指令擷取 `<ETCD_URL>`。

若要擷取 `<ETCD_URL>`，請執行下列其中一個指令：

- Linux 及 OS X：

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows：<ol>
    <li> 取得 kube-system 名稱空間中的 Pod 清單，並找出 Calico 控制器 Pod。</br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>範例：</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> 檢視 Calico 控制器 Pod 的詳細資料。</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
    <li> 找出 ETCD 端點值。範例：<code>https://169.1.1.1:30001</code>
    </ol>

當您擷取 `<ETCD_URL>` 時，請繼續執行[新增網路原則](cs_network_policy.html#adding_network_policies)中所列的步驟。

<br />




## 取得協助及支援
{: #ts_getting_help}

從哪裡開始進行容器疑難排解？

-   若要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，請[檢查 {{site.data.keyword.Bluemix_notm}} 狀態頁面 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/bluemix/support/#status)。
-   將問題張貼到 [{{site.data.keyword.containershort_notm}} Slack ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://ibm-container-service.slack.com)。提示：如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶未使用 IBM ID，請[要求邀請](https://bxcs-slack-invite.mybluemix.net/)以加入此 Slack。
-   檢閱討論區，以查看其他使用者是否發生過相同的問題。使用討論區詢問問題時，請標記您的問題，讓 {{site.data.keyword.Bluemix_notm}} 開發團隊可以看到它。

    -   如果您在使用 {{site.data.keyword.containershort_notm}} 開發或部署叢集或應用程式時有技術方面的問題，請將問題張貼到 [Stack Overflow ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers)，並使用 `ibm-cloud`、`kubernetes` 及 `containers` 來標記問題。
    -   若為服務及開始使用指示的相關問題，請使用 [IBM developerWorks dW Answers ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 討論區。請包含 `ibm-cloud` 及 `containers` 標籤。如需使用討論區的詳細資料，請參閱[取得協助](/docs/get-support/howtogetsupport.html#using-avatar)。

-   與「IBM 支援中心」聯絡。如需開立 IBM 支援問題單或是支援層次與問題單嚴重性的相關資訊，請參閱[與支援中心聯絡](/docs/get-support/howtogetsupport.html#getting-customer-support)。

{:tip}
報告問題時，請包含您的叢集 ID。若要取得叢集 ID，請執行 `bx cs clusters`。
