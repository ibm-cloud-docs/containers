---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# {{site.data.keyword.containerlong_notm}} 的 Kubernetes 版本
{: #cs_versions}

{{site.data.keyword.containerlong}}同時支援多種版本的 Kubernetes：最新版本、預設版本，以及支援版本（一般是落後最新版本的兩個版本）。預設版本可能與最新版本相同，除非指定不同的版本，否則，建立或更新叢集時都會使用預設版本。
{:shortdesc}

現行支援的 Kubernetes 版本如下：

- 最新：1.9.2
- 預設：1.8.6
- 支援：1.7.4

如果您是在目前不支援的 Kubernetes  版本上執行叢集，請[檢閱潛在影響](#version_types)以取得更新項目，然後立即[更新您的叢集](cs_cluster_update.html#update)，以繼續接收重要的安全更新項目及支援。若要檢查伺服器版本，請執行下列指令。

```
kubectl version  --short | grep -i server
```
{: pre}

輸出範例：

```
Server Version: 1.8.6
```
{: screen}

## 更新類型
{: #version_types}

Kubernetes 提供下列版本更新類型：
{:shortdesc}

|更新類型|版本標籤的範例|更新者|影響
|-----|-----|-----|-----|
|主要|1.x.x|您|叢集的作業變更，包括 Script 或部署。|
|次要|x.5.x|您|叢集的作業變更，包括 Script 或部署。|
|修補程式|x.x.3|IBM 與您|沒有 Script 或部署的變更。IBM 會自動更新主節點，但由您將修補程式套用至工作者節點。|
{: caption="Kubernetes 更新的影響" caption-side="top"}

依預設，Kibernetes 主節點無法更新超過兩個次要版本。例如，如果現行主節點是 1.5 版，而您要更新至 1.8，則必須先更新至 1.7。您可以強制更新繼續進行，但更新超過兩個次要版本可能會造成非預期的結果。
{: tip}

下列資訊彙總當您將叢集從舊版更新為新版本時，可能會對已部署的應用程式造成影響的更新。請檢閱 [Kubernetes 變更日誌 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)，以取得 Kubernetes 版本變更的完整清單。

如需更新程序的相關資訊，請參閱[更新叢集](cs_cluster_update.html#master)及[更新工作者節點](cs_cluster_update.html#worker_node)。

## 1.9 版
{: #cs_v19}



從 Kubernets 舊版更新至 1.9 版時，請檢閱您可能需要進行的變更。

<br/>

### 在主節點之前更新
{: #19_before}

<table summary="1.9 版的 Kubernetes 更新項目">
<caption>在將主節點更新至 Kubernetes 1.9 之前要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Webhook 許可 API</td>
<td>在 API 伺服器呼叫許可控制 Webhook 時使用的許可 API，是從 <code>admission.v1alpha1</code> 移至 <code>admission.v1beta1</code>。<em>在升級叢集之前您必須刪除任何現有的 Webhook</em>，並更新 Webhook 配置檔來使用最新 API。此變更與舊版不相容。</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #19_after}

<table summary="1.9 版的 Kubernetes 更新項目">
<caption>在將主節點更新至 Kubernetes 1.9 之後要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>`kubectl` 輸出</td>
<td>現在，當您使用 `kubectl` 指令來指定 `-o custom-columns`，但在物件中找不到直欄時，您會看到輸出 `<none>`。<br>
之前，作業失敗，且您看到 `xxx is not found` 錯誤訊息。如果您的 Script 依賴先前的行為，請更新它們。</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>現在，當未對修補的資源進行任何變更時，`kubectl patch` 指令會失敗，並出現 `exit code 1`。如果您的 Script 依賴先前的行為，請更新它們。</td>
</tr>
<tr>
<td>Kubernetes 儀表板許可權</td>
<td>現在，使用者必須使用其認證來登入 Kubernetes 儀表板，以檢視叢集資源。已移除預設的 Kubernetes 儀表板 `ClusterRoleBinding` RBAC 授權。如需指示，請參閱[啟動 Kubernetes 儀表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>`default` `ServiceAccount` 的 RBAC</td>
<td>會移除 `default` 名稱空間中 `default` `ServiceAccount` 的管理者 `ClusterRoleBinding`。如果您的應用程式依賴此 RBAC 原則來存取 Kubernetes API，請[更新您的 RBAC 原則](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</td>
</tr>
<tr>
<td>污染及容錯</td>
<td>`node.alpha.kubernetes.io/notReady` 及 `node.alpha.kubernetes.io/unreachable` 污染已分別變更為 `node.kubernetes.io/not-ready` 和`node.kubernetes.io/unreachable`。<br>
雖然會自動更新污染，但您必須手動更新這些污染的容錯。針對 `ibm-system` 及 `kube-system` 以外的每一個名稱空間，判斷您是否需要變更容錯：<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
如果傳回 `Action required`，請相應地修改 Pod 容錯。</td>
</tr>
<tr>
<td>Webhook 許可 API</td>
<td>如果您已在更新叢集之前刪除現有 Webhook，請建立新的 Webhook。</td>
</tr>
</tbody>
</table>


## 1.8 版
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.8 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.8 版的認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

從 Kubernets 舊版更新至 1.8 版時，請檢閱您可能需要進行的變更。

<br/>

### 在主節點之前更新
{: #18_before}

<table summary="1.8 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.8 之前要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan='2'>更新主節點之前不需要任何變更</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #18_after}

<table summary="1.8 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.8 之後要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes 儀表板登入</td>
<td>用於存取 1.8 版中 Kubbernetes 儀表板的 URL 已變更，且登入處理程序包括新的鑑別步驟。如需相關資訊，請參閱[存取 Kubernetes 儀表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>Kubernetes 儀表板許可權</td>
<td>若要強制使用者利用其認證登入以檢視 1.8 版中的叢集資源，請移除 1.7 ClusterRoleBinding RBAC 授權。執行 `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>在刪除物件之前，`kubectl delete` 指令不再縮減工作負載 API 物件（如 Pod）。如果需要縮減物件，請在刪除物件之前，使用 [kubectl scale ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale)。</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` 指令必須對 `--env` 使用多個旗標，而非逗點區隔的引數。例如，執行 <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code>，而非 <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>。</td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` 指令無法再使用。</td>
</tr>
</tbody>
</table>


## 1.7 版
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.7 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.7 版的認證 Kubernetes 產品。</p>

從 Kubernets 舊版更新至 1.7 版時，請檢閱您可能需要進行的變更。

<br/>

### 在主節點之前更新
{: #17_before}

<table summary="1.7 及 1.6 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.7 之前要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>儲存空間</td>
<td>不容許使用具有 `hostPath` 及 `mountPath` 且具有類似 `../to/dir` 之上層目錄參照的配置 Script。請將路徑變更為簡單的絕對路徑，例如 `/path/to/dir`。
<ol>
  <li>判斷是否需要變更儲存路徑：</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>如果傳回 `Action required`，請變更 Pod 以參照絕對路徑，然後再更新所有工作者節點。如果 Pod 由另一個資源所擁有，例如部署，請變更該資源內的 [_PodSpec_ ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core)。</ol>
</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #17_after}

<table summary="1.7 及 1.6 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.7 之後要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>在 `kubectl` CLI 更新之後，這些 `kubectl create` 指令必須使用多個旗標，而非以逗點區隔的引數：<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  例如，執行 `kkbectl create role --resource-name<x> --resource-name <y>` 而非 `kubectl create role --resource-name <x>,<y>`。</td>
</tr>
<tr>
<td>Pod 親緣性排程</td>
<td> `scheduler.alpha.kubernetes.io/affinity` 註釋已淘汰。
<ol>
  <li>針對 `ibm-system` 及 `kube-system` 以外的每一個名稱空間，判斷您是否需要更新 Pod 親緣性排程：</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br></li>
  <li>如果傳回 `"Action required"`，請使用 [_PodSpec_ ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ 欄位，而非 `scheduler.alpha.kubernetes.io/affinity` 註釋。</li>
</ol>
</tr>
<tr>
<td>網路原則</td>
<td>`net.beta.kubernetes.io/network-policy` 註釋無法再使用。
<ol>
  <li>判斷是否需要變更原則：</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>如果傳回 `"Action required"`，請將下列網路原則新增至每一個列出的 Kubernetes 名稱空間：</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
  metadata:
    name: default-deny
    namespace: &lt;namespace&gt;
  spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> 在新增網路原則之後，請移除 `net.beta.kubernetes.io/network-policy` 註釋：
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </li></ol>
</tr>
<tr>
<td>容忍</td>
<td>`scheduler.alpha.kubernetes.io/tolerations` 註釋無法再使用。
<ol>
  <li>針對 `ibm-system` 及 `kube-system` 以外的每一個名稱空間，判斷您是否需要變更容錯：</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>如果傳回 `"Action required"`，請使用 [_PodSpec_ ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ 欄位，而非 `scheduler.alpha.kubernetes.io/tolerations` 註釋。
</ol>
</tr>
<tr>
<td>污染</td>
<td>`scheduler.alpha.kubernetes.io/taints` 註釋無法再使用。
<ol>
  <li>判斷是否需要變更污染：</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>如果傳回 `"Action required"`，請移除每一個節點的 `scheduler.alpha.kubernetes.io/taints` 註釋。</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>將污染新增至每一個節點：</br>
  `kubectl taint node <node> <taint>`
  </li></ol>
</tr>
<tr>
<td>StatefulSet Pod DNS</td>
<td>在更新主節點之後，StatefulSet Pod 會失去其 Kuberneges DNS 項目。若要還原 DNS 項目，請刪除 StatefulSet Pod。Kubbernetes 會重建 Pod，並自動還原 DNS 項目。如需相關資訊，請參閱 [Kubernetes 問題![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/issues/48327)。
</tr>
</tbody>
</table>
