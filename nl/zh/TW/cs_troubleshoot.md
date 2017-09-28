---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

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

在您使用 {{site.data.keyword.containershort_notm}} 時，請考慮使用這些技術來進行疑難排解以及取得協助。

{: shortdesc}


## 叢集除錯
{: #debug_clusters}

請檢閱您既有的選項以進行叢集除錯，並找出失敗的主要原因。

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
        <td>部署中</td>
        <td>Kubernetes 主節點尚未完整部署。您無法存取叢集。</td>
       </tr>
       <tr>
        <td>擱置中</td>
        <td>已部署 Kubernetes 主節點。正在佈建工作者節點，因此還無法在叢集中使用。您可以存取叢集，但無法將應用程式部署至叢集。</td>
      </tr>
      <tr>
        <td>正常</td>
        <td>叢集中的所有工作者節點都已開始執行。您可以存取叢集，並將應用程式部署至叢集。</td>
     </tr>
     <tr>
        <td>警告</td>
        <td>叢集中至少有一個工作者節點無法使用，但有其他工作者節點可用，並且可以接管工作負載。</td>
     </tr>
     <tr>
      <td>嚴重</td>
      <td>無法聯繫 Kubernetes 主節點，或叢集中的所有工作者節點都已關閉。</td>
     </tr>
    </tbody>
  </table>

3.  如果叢集處於**警告**或**嚴重**狀態，或卡在**擱置中**狀態很長一段時間，請檢閱工作者節點的狀態。如果叢集處於**部署中**狀態，請等待叢集完整部署，以檢閱叢集的性能。處於**正常**狀態的叢集都會被視為性能良好，因此目前不需要採取動作。 

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
       <td>不明</td>
       <td>因下列其中一個原因而無法聯繫 Kubernetes 主節點：<ul><li>您已要求更新 Kubernetes 主節點。在更新期間，無法擷取工作者節點的狀態。</li><li>您可能有額外的防火牆保護工作者節點，或最近變更過防火牆設定。{{site.data.keyword.containershort_notm}} 需要開啟特定 IP 位址及埠，以容許從工作者節點到 Kubernetes 主節點的通訊，反之亦然。如需相關資訊，請參閱[工作者節點卡在重新載入迴圈](#cs_firewall)。</li><li>Kubernetes 主節點已關閉。請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](/docs/support/index.html#contacting-support)，以與 {{site.data.keyword.Bluemix_notm}} 支援中心聯絡。</li></ul></td>
      </tr>
      <tr>
        <td>佈建中</td>
        <td>正在佈建工作者節點，因此還無法在叢集中使用。您可以在 CLI 輸出的**狀態**直欄中監視佈建處理程序。如果您的工作者節點卡在這個狀態很長一段時間，因此在**狀態**直欄中看不到任何進度，請繼續進行下一步，以查看佈建期間是否發生問題。</td>
      </tr>
      <tr>
        <td>佈建失敗</td>
        <td>無法佈建工作者節點。請繼續進行下一步，以尋找失敗的詳細資料。</td>
      </tr>
      <tr>
        <td>重新載入中</td>
        <td>正在重新載入工作者節點，因此無法在叢集中使用。您可以在 CLI 輸出的**狀態**直欄中監視重新載入處理程序。如果您的工作者節點卡在這個狀態很長一段時間，因此在**狀態**直欄中看不到任何進度，請繼續進行下一步，以查看重新載入期間是否發生問題。</td>
       </tr>
       <tr>
        <td>重新載入失敗</td>
        <td>無法重新載入工作者節點。請繼續進行下一步，以尋找失敗的詳細資料。</td>
      </tr>
      <tr>
        <td>正常</td>
        <td>工作者節點已完整佈建，並已備妥可用於叢集。</td>
     </tr>
     <tr>
        <td>警告</td>
        <td>工作者節點將達到記憶體或磁碟空間的限制。</td>
     </tr>
     <tr>
      <td>嚴重</td>
      <td>工作者節點已耗盡磁碟空間。</td>
     </tr>
    </tbody>
  </table>

4.  列出工作者節點的詳細資料。

  ```
  bx cs worker-get <worker_node_id>
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
        <td>您的 {{site.data.keyword.BluSoftlayer_notm}} 帳戶可能無法訂購運算資源。請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](/docs/support/index.html#contacting-support)，以與 {{site.data.keyword.Bluemix_notm}} 支援中心聯絡。</td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：無法下單。路由器 'router_name' 的資源不足，無法滿足下列來賓的要求：'worker_id'。</td>
        <td>您選取的 VLAN 與空間不足無法佈建工作者節點之資料中心內的 Pod 相關聯。您可以選擇下列選項：<ul><li>使用不同的資料中心來佈建工作者節點。執行 <code>bx cs locations</code> 來列出可用的資料中心。<li>如果您的現有公用及專用 VLAN 配對與資料中心內的另一個 Pod 相關聯，請改用此 VLAN 配對。<li>請開立 [{{site.data.keyword.Bluemix_notm}} 支援問題單](/docs/support/index.html#contacting-support)，以與 {{site.data.keyword.Bluemix_notm}} 支援中心聯絡。</ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：無法取得 ID 為 &lt;vlan id&gt; 的網路 VLAN。</td>
        <td>無法佈建工作者節點，因為因下列其中一個原因而找不到選取的 VLAN ID：<ul><li>您可能已指定 VLAN 號碼，而非 VLAN ID。VLAN 號碼的長度是 3 或 4 位數，而 VLAN ID 的長度是 7 位數。執行 <code>bx cs vlans &lt;location&gt;</code>，以擷取 VLAN ID。<li>VLAN ID 可能未與您使用的 Bluemix 基礎架構 (SoftLayer) 帳戶相關聯。執行 <code>bx cs vlans &lt;location&gt;</code>，以列出帳戶的可用 VLAN ID。若要變更 {{site.data.keyword.BluSoftlayer_notm}} 帳戶，請參閱 [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)。</ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation：針對此訂單提供的位置無效。(HTTP 500)</td>
        <td>您的 {{site.data.keyword.BluSoftlayer_notm}} 未設定成訂購所選取資料中心內的運算資源。請與 [{{site.data.keyword.Bluemix_notm}} 支援中心](/docs/support/index.html#contacting-support)聯絡，驗證已正確設定帳戶。</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：使用者沒有新增伺服器的必要 {{site.data.keyword.Bluemix_notm}} 基礎架構許可權
        
        </br></br>
        {{site.data.keyword.Bluemix_notm}} 基礎架構異常狀況：必須要有許可權才能訂購「項目」。</td>
        <td>您可能沒有從 {{site.data.keyword.BluSoftlayer_notm}} 組合佈建工作者節點的必要許可權。若要尋找必要許可權，請參閱[配置對 {{site.data.keyword.BluSoftlayer_notm}} 組合的存取權以建立標準 Kubernetes 叢集](cs_planning.html#cs_planning_unify_accounts)。</td>
      </tr>
    </tbody>
  </table>

## 建立叢集時無法連接至 IBM {{site.data.keyword.BluSoftlayer_notm}} 帳戶
{: #cs_credentials}

{: tsSymptoms}
當您建立新的 Kubernetes 叢集時，會收到下列訊息。

```
We were unable to connect to your {{site.data.keyword.BluSoftlayer_notm}} account. Creating a standard cluster requires that you have either a Pay-As-You-Go account that is linked to an {{site.data.keyword.BluSoftlayer_notm}} account term or that you have used the IBM
{{site.data.keyword.Bluemix_notm}} Container Service CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

{: tsCauses}
具有未鏈結 {{site.data.keyword.Bluemix_notm}} 帳戶的使用者必須建立新的「隨收隨付制」帳戶，或使用 {{site.data.keyword.Bluemix_notm}} CLI 手動新增 {{site.data.keyword.BluSoftlayer_notm}} API 金鑰。

{: tsResolve}
若要新增 {{site.data.keyword.Bluemix_notm}} 帳戶的認證，請執行下列動作：

1.  與 {{site.data.keyword.BluSoftlayer_notm}} 管理者聯絡，以取得 {{site.data.keyword.BluSoftlayer_notm}} 使用者名稱及 API 金鑰。

    **附註：**您使用的 {{site.data.keyword.BluSoftlayer_notm}} 帳戶必須已設定 SuperUser 許可權，才能順利建立標準叢集。

2.  新增認證。

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  建立標準叢集。


  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}


## 使用 SSH 存取工作者節點失敗
{: #cs_ssh_worker}

{: tsSymptoms}
您無法使用 SSH 連線來存取工作者節點。

{: tsCauses}
工作者節點上已停用透過密碼的 SSH。

{: tsResolve}
對於您必須在任何必須執行一次性動作的每個節點或工作上執行的所有動作，使用[常駐程式集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。


## Pod 保持擱置中狀態
{: #cs_pods_pending}

{: tsSymptoms}
當您執行 `kubectl get pods` 時，可以看到保持**擱置**狀態的 Pod。

{: tsCauses}
如果您才剛剛建立 Kubernetes 叢集，則可能仍在配置工作者節點。
如果此叢集是現有叢集，則您的叢集中可能沒有足夠的容量可部署 Pod。

{: tsResolve}
此作業需要[管理者存取原則](cs_cluster.html#access_ov)。請驗證您的現行[存取原則](cs_cluster.html#view_access)。

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

5.  如果您的 Pod 在工作者節點完整部署之後仍然保持**擱置中**狀態，請檢閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending)，以進一步對 Pod 的擱置中狀態進行疑難排解。

## 工作者節點建立失敗，訊息為「佈建失敗」
{: #cs_pod_space}

{: tsSymptoms}
當您建立 Kubernetes 叢集或新增工作者節點時，會看到「佈建失敗」狀態。請執行下列指令。

```
bx cs worker-get <WORKER_NODE_ID>
```
{: pre}

即會顯示下列訊息。

```
SoftLayer_Exception_Virtual_Host_Pool_InsufficientResources: Could not place order. There are insufficient resources behind router bcr<router_ID> to fulfill the request for the following guests: kube-<location>-<worker_node_ID>-w1 (HTTP 500)
```
{: screen}

{: tsCauses}
{{site.data.keyword.BluSoftlayer_notm}} 目前可能沒有足夠的容量，無法佈建工作者節點。

{: tsResolve}
選項 1：在另一個位置建立叢集。

選項 2：開啟 {{site.data.keyword.BluSoftlayer_notm}} 的支援問題，並詢問位置中的可用容量。

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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b1c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b1c.4x16       deleted    -
  ```
  {: screen}

2.  安裝 [Calico CLI](cs_security.html#adding_network_policies)。
3.  列出 Calico 中的可用工作者節點。請將 <path_to_file> 取代為 Calico 配置檔的本端路徑。

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

## 工作者節點無法連接
{: #cs_firewall}

{: tsSymptoms}
kubectl proxy 失敗或您嘗試存取叢集中的服務時，連線會失敗，並顯示下列其中一則錯誤訊息：

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

或者，當您使用 kubectl exec、attach 或 logs，並且收到此錯誤：

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

或者，當 kubectl Proxy 成功，但儀表板無法使用，並且收到此錯誤：

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}

或者，工作者節點卡在重新載入迴圈時。

{: tsCauses}
您可能已在 {{site.data.keyword.BluSoftlayer_notm}} 帳戶中設定其他防火牆，或自訂其中的現有防火牆設定。{{site.data.keyword.containershort_notm}} 需要開啟特定 IP 位址及埠，以容許從工作者節點到 Kubernetes 主節點的通訊，反之亦然。

{: tsResolve}
此作業需要[管理者存取原則](cs_cluster.html#access_ov)。請驗證您的現行[存取原則](cs_cluster.html#view_access)。

在自訂防火牆中，開啟下列埠及 IP 位址。
```
TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
```
{: pre}


<!--Inbound left for existing clusters. Once existing worker nodes are reloaded, users only need the Outbound information, which is found in the regular docs.-->

1.  記下叢集中所有工作者節點的公用 IP 位址：

  ```
  bx cs workers '<cluster_name_or_id>'
  ```
  {: pre}

2.  在您的防火牆中，容許下列進出工作者節點的連線：

  ```
  TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
  ```
  {: pre}

    <ul><li>若為連接至工作者節點的 INBOUND 連線，容許從下列來源網路群組及 IP 位址到目的地 TCP/UDP 埠 10250 及 `<public_IP_of _each_worker_node>` 的送入網路資料流量：</br>
    
    <table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器位置，第二欄則為要符合的 IP 位址。">
  <thead>
      <th colspan=2><img src="images/idea.png"/> 入埠 IP 位址</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.144.128/28</code></br><code>169.50.169.104/29</code></br><code>169.50.185.32/27</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.232/29 </code></br><code>169.48.138.64/26</code></br><code>169.48.180.128/25</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.8/29</code></br><code>169.47.79.192/26</code></br><code>169.47.126.192/27</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.48.160/28</code></br><code>169.50.56.168/29</code></br><code>169.50.58.160/27</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.68.192/26</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.209.192/26</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.67.0/26</code></td>
      </tr>
    </table>

    <li>若為來自工作者節點的 OUTBOUND 連線，容許從來源工作者節點到 `<each_worker_node_publicIP>` 之目的地 TCP/UDP 埠範圍 20000-32767 及下列 IP 位址和網路群組的送出網路資料流量：</br>
    
    <table summary="表格中的第一列跨這兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器位置，第二欄則為要符合的 IP 位址。">
      <thead>
      <th colspan=2><img src="images/idea.png"/> 出埠 IP 位址</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>
    
    

## 透過 Ingress 連接至應用程式失敗
{: #cs_ingress_fails}

{: tsSymptoms}
您已透過在叢集中建立應用程式的 Ingress 資源，來公開應用程式。當您嘗試透過 Ingress 控制器的公用 IP 位址或子網域連接至應用程式時，連線失敗或逾時。

{: tsCauses}
Ingress 可能未正常運作，原因如下：
<ul><ul>
<li>尚未完整部署叢集。
<li>叢集已設定為精簡叢集或只有一個工作者節點的標準叢集。
<li>Ingress 配置 Script 包含錯誤。
</ul></ul>

{: tsResolve}
若要對 Ingress 進行疑難排解，請執行下列動作：

1.  確認您所設定的標準叢集已完整部署並且至少有兩個工作者節點，以確保 Ingress 控制器的高可用性。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    在 CLI 輸出中，確定工作者節點的**狀態**顯示**備妥**，而且**機型**顯示**可用**以外的機型。

2.  擷取 Ingress 控制器子網域及公用 IP 位址，然後對其進行連線測試。

    1.  擷取 Ingress 控制器子網域。

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  對 Ingress 控制器子網域進行連線測試。

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  擷取 Ingress 控制器的公用 IP 位址。

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  對 Ingress 控制器公用 IP 位址進行連線測試。

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    如果 CLI 傳回 Ingress 控制器公用 IP 位址或子網域的逾時，並且已設定保護工作者節點的自訂防火牆，您可能需要開啟[防火牆](#cs_firewall)中的其他埠及網路群組。

3.  如果您要使用自訂網域，請確定使用「網域名稱服務 (DNS)」提供者將自訂網域對映至 IBM 所提供 Ingress 控制器的公用 IP 位址或子網域。
    1.  如果您已使用 Ingress 控制器子網域，請檢查「標準名稱記錄 (CNAME)」。
    2.  如果您已使用 Ingress 控制器公用 IP 位址，請確認已在「指標記錄 (PTR)」中將自訂網域對映至可攜式公用 IP 位址。
4.  檢查 Ingress 配置檔。

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

    1.  確認 Ingress 控制器子網域及 TLS 憑證正確無誤。若要尋找 IBM 提供的子網域及 TLS 憑證，請執行 bx cs cluster-get <cluster_name_or_id>。
    2.  確定應用程式接聽與 Ingress 之 **path** 區段中配置相同的路徑。如果您的應用程式設定成接聽根路徑，請包含 **/** 作為路徑。
5.  檢查 Ingress 部署，並尋找可能的錯誤訊息。

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  檢查 Ingress 控制器的日誌。
    1.  擷取在叢集中執行的 Ingress Pod 的 ID。

      ```
      kubectl get pods -n kube-system |grep ingress
      ```
      {: pre}

    2.  擷取每一個 Ingress Pod 的日誌。

      ```
      kubectl logs <ingress_pod_id> -n kube-system
      ```
      {: pre}

    3.  尋找 Ingress 控制器日誌中的錯誤訊息。

## 透過負載平衡器服務連接至應用程式失敗
{: #cs_loadbalancer_fails}

{: tsSymptoms}
您已透過在叢集中建立負載平衡器服務，來公開應用程式。當您嘗試透過負載平衡器的公用 IP 位址連接至應用程式時，連線失敗或逾時。

{: tsCauses}
負載平衡器服務可能因下列其中一個原因而未正常運作：

-   叢集是精簡叢集或只有一個工作者節點的標準叢集。
-   尚未完整部署叢集。
-   負載平衡器服務的配置 Script 包含錯誤。

{: tsResolve}
若要對負載平衡器服務進行疑難排解，請執行下列動作：

1.  確認您所設定的標準叢集已完整部署並且至少有兩個工作者節點，以確保負載平衡器服務的高可用性。

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    在 CLI 輸出中，確定工作者節點的**狀態**顯示**備妥**，而且**機型**顯示**可用**以外的機型。

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

    1.  確認您已將 **LoadBlanacer** 定義為服務的類型。
    2.  確定您使用了與部署應用程式時在 **label/metadata** 區段中所使用的相同 **<selectorkey>** 及 **<selectorvalue>**。
    3.  確認您已使用應用程式所接聽的**埠**。

3.  檢查負載平衡器服務，並檢閱**事件**區段來尋找可能的錯誤。

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    尋找下列錯誤訊息：
    <ul><ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>若要使用負載平衡器服務，您必須有至少包含兩個工作者節點的標準叢集。
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>此錯誤訊息指出未將可攜式公用 IP 位址配置給負載平衡器服務。請參閱[將子網路新增至叢集](cs_cluster.html#cs_cluster_subnet)，以尋找如何要求叢集之可攜式公用 IP 位址的相關資訊。叢集可以使用可攜式公用 IP 位址之後，會自動建立負載平衡器服務。
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips</code></pre></br>您已使用 **loadBalancerIP** 區段定義負載平衡器服務的可攜式公用 IP 位址，但在可攜式公用子網路中無法使用此可攜式公用 IP 位址。請變更負載平衡器服務配置 Script，然後選擇其中一個可用的可攜式公用 IP 位址，或是移除 Script 中的 **loadBalancerIP** 區段，以便能自動配置可用的可攜式公用 IP 位址。
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>您沒有足夠的工作者節點可部署負載平衡器服務。其中一個原因可能是您所部署的標準叢集有多個工作者節點，但佈建工作者節點失敗。
    <ol><li>列出可用的工作者節點。</br><pre class="codeblock"><code>kubectl get nodes</code></pre>
    <li>如果找到至少兩個可用的工作者節點，則會列出工作者節點詳細資料。</br><pre class="screen"><code>bx cs worker-get <worker_ID></code></pre>
    <li>確定 'kubectl get nodes' 及 'bx cs worker-get' 指令所傳回的工作者節點的公用及專用 VLAN ID 相符。</ol></ul></ul>

4.  如果您要使用自訂網域連接至負載平衡器服務，請確定已將自訂網域對映至負載平衡器服務的公用 IP 位址。
    1.  尋找負載平衡器服務的公用 IP 位址。

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  確認在「指標記錄 (PTR)」中已將自訂網域對映至負載平衡器服務的可攜式公用 IP 位址。

## 已知的問題
{: #cs_known_issues}

瞭解已知問題。
{: shortdesc}

### 叢集
{: #ki_clusters}

<dl>
  <dt>相同 {{site.data.keyword.Bluemix_notm}} 空間中的 Cloud Foundry 應用程式無法存取叢集</dt>
    <dd>當您建立 Kubernetes 叢集時，會在帳戶層次建立叢集，而且叢集不會使用空間，但連結 {{site.data.keyword.Bluemix_notm}} 服務時除外。如果您有想要叢集存取的 Cloud Foundry 應用程式，則必須將 Cloud Foundry 應用程式設為可公開使用，或必須將應用程式設為可在叢集中[公開使用](cs_planning.html#cs_planning_public_network)。</dd>
  <dt>已停用 Kube 儀表板 NodePort 服務</dt>
    <dd>基於安全考量，已停用 Kubernetes 儀表板 NodePort 服務。若要存取 Kubernetes 儀表板，請執行下列指令。</br><pre class="codeblock"><code>kubectl proxy</code></pre></br>然後，您可以在 `http://localhost:8001/ui` 存取 Kubernetes 儀表板。</dd>
  <dt>負載平衡器的服務類型限制</dt>
    <dd><ul><li>您不可以在專用 VLAN 上使用負載平衡。<li>您無法使用 service.beta.kubernetes.io/external-traffic 及 service.beta.kubernetes.io/healthcheck-nodeport 服務註釋。如需這些註釋的相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tutorials/services/source-ip/)。</ul></dd>
  <dt>水平自動擴充未運作</dt>
    <dd>基於安全理由，會關閉所有工作者節點中 Heapster (10255) 所使用的標準埠。因為已關閉此埠，所以 Heapster 無法報告工作者節點的度量值，而且水平自動擴充無法運作（如 Kubernetes 文件的 [Horizontal Pod Autoscaling ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) 中所記載）。</dd>
</dl>

### 持續性儲存空間
{: #persistent_storage}

`kubectl describe <pvc_name>` 指令會顯示持續性磁區宣告的 **ProvisioningFailed**：
<ul><ul>
<li>當您建立持續性磁區宣告時，沒有可用的持續性磁區，因此 Kubernetes 會傳回 **ProvisioningFailed** 訊息。<li>建立持續性磁區並將其連結至宣告之後，Kubernetes 會傳回 **ProvisioningSucceeded** 訊息。此處理程序可能需要幾分鐘的時間。</ul></ul>

## 取得協助及支援
{: #ts_getting_help}

從哪裡開始進行容器疑難排解？

-   若要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，請[檢查 {{site.data.keyword.Bluemix_notm}} 狀態頁面 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/bluemix/support/#status)。
-   將問題張貼到 [{{site.data.keyword.containershort_notm}} Slack ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://ibm-container-service.slack.com)。如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶未使用 IBM ID，請與 [crosen@us.ibm.com](mailto:crosen@us.ibm.com) 聯絡，並要求對此 Slack 的邀請。
-   檢閱討論區，以查看其他使用者是否發生過相同的問題。使用討論區詢問問題時，請標記您的問題，讓 {{site.data.keyword.Bluemix_notm}} 開發團隊可以看到它。

    -   如果您在使用 {{site.data.keyword.containershort_notm}} 開發或部署叢集或應用程式時有技術方面的問題，請將問題張貼到 [Stack Overflow ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://stackoverflow.com/search?q=bluemix+containers)，並使用 `ibm-bluemix`、`kubernetes` 及 `containers` 來標記問題。
    -   若為服務及開始使用指示的相關問題，請使用 [IBM developerWorks dW Answers ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 討論區。請包含 `bluemix` 及 `containers` 標籤。如需使用討論區的詳細資料，請參閱[取得協助](/docs/support/index.html#getting-help)。

-   與「IBM 支援中心」聯絡。如需開立 IBM 支援問題單或是支援層次與問題單嚴重性的相關資訊，請參閱[與支援中心聯絡](/docs/support/index.html#contacting-support)。
