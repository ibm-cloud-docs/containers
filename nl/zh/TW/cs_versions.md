---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

請檢閱提供於 {{site.data.keyword.containerlong}} 的 Kubernetes 版本。
{:shortdesc}

表格包含當您將叢集更新為新版本時，可能會對已部署的應用程式造成影響的更新。請檢閱 [Kubernetes 變更日誌 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)，以取得 Kubernetes 版本變更的完整清單。

如需更新程序的相關資訊，請參閱[更新叢集](cs_cluster.html#cs_cluster_update)及[更新工作者節點](cs_cluster.html#cs_cluster_worker_update)。



## 1.7 版
{: #cs_v17}

### 在主節點之前更新
{: #17_before}

<table summary="1.7 及 1.6 版的 Kubernetes 更新">
<caption>表 1. 將主節點更新為 Kubernetes 1.7 之前所做的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</tr>
</thead>
<tbody>
<tr>
<td>儲存空間</td>
<td>不容許使用具有 `hostPath` 及 `mountPath` 且具有類似 `../to/dir` 之上層目錄參照的配置 Script。請將路徑變更為簡單的絕對路徑，例如 `/path/to/dir`。
<ol>
  <li>執行下列指令以判斷是否需要更新儲存空間路徑。</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>如果傳回 `Action required`，請將每個受影響的 Pod 修改為參照絕對路徑，然後再更新所有工作者節點。如果 Pod 由另一個資源所擁有，例如部署，請修改該資源內的 [_PodSpec_ ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core)。</ol>
</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #17_after}

<table summary="1.7 及 1.6 版的 Kubernetes 更新">
<caption>表 2. 將主節點更新為 Kubernetes 1.7 之後所做的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>將 `kubbectl` CLI 更新為叢集的版本之後，這些 `kubectl` 指令必須使用多個旗標，而非以逗點區隔的引數。<ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  例如，執行 `kkbectl create role --resource-name<x> --resource-name <y>` 而非 `kubectl create role --resource-name <x>,<y>`。</td>
</tr>
<tr>
<td>Pod 親緣性排程</td>
<td> `scheduler.alpha.kubernetes.io/affinity` 註釋已淘汰。
<ol>
  <li>針對 `ibm-system` 及 `kube-system` 以外的每個名稱空間執行下列指令，判斷您是否需要更新 Pod 親緣性排程。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>如果傳回 `"Action required"`，請將受影響的 Pod 修改為使用 [_PodSpec_ ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ 欄位，而不是 `scheduler.alpha.kubernetes.io/affinity` 註釋。</ol>
</tr>
<tr>
<td>網路原則</td>
<td>不再支援 `net.beta.kubernetes.io/network-policy` 註釋。
<ol>
  <li>執行下列指令以判斷是否需要更新網路原則。</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>如果傳回 `Action required`，請將下列網路原則新增至所列出的每個 Kubernetes 名稱空間。</br>

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

  <li> 進行網路原則時，請移除 `net.beta.kubernetes.io/network-policy` 註釋。
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>容忍</td>
<td>不再支援 `scheduler.alpha.kubernetes.io/tolerations` 註釋。
<ol>
  <li>針對 `ibm-system` 及 `kube-system` 以外的每個名稱空間執行下列指令，判斷您是否需要更新容忍。</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>如果傳回 `"Action required"`，請將受影響的 Pod 修改為使用 [_PodSpec_ ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ 欄位，而不是 `scheduler.alpha.kubernetes.io/tolerations` 註釋。
</ol>
</tr>
<tr>
<td>污點</td>
<td>不再支援 `scheduler.alpha.kubernetes.io/taints` 註釋。
<ol>
  <li>執行下列指令以判斷是否需要更新污點</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>如果傳回 `"Action required"`，請針對具有不受支援之註釋的每個節點，移除 `scheduler.alpha.kubernetes.io/taints` 註釋。</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>移除不受支援的註釋時，將污點新增至每個節點。您必須具有 `kubectl` CLI 1.6 版或更新版本。</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
