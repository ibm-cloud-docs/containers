---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# 版本資訊及更新動作
{: #cs_versions}

## Kubernetes 版本類型
{: #version_types}

{{site.data.keyword.containerlong}} 同時支援多個 Kubernetes 版本。發行最新版本 (n) 時，最多支援到前 2 個 (n-2) 版本。超過最新版本前 2 個版本的版本 (n-3) 會先被淘汰，然後不受支援。
{:shortdesc}

**支援的 Kubernetes 版本**:

- 最新：1.11.2
- 預設：1.10.7
- 其他：1.9.10
- 已淘汰：1.8.15，自 2018 年 9 月 22 日起不受支援

</br>

**已淘汰的版本**：當叢集在已淘汰的 Kubernetes 版本上執行時，在版本變成不受支援之前，您有 30 天的時間可以檢閱並更新至受支援的 Kubernetes 版本。在淘汰期間，仍完全支援您的叢集。不過，您無法建立新的叢集來使用已淘汰的版本。

**不受支援的版本**：如果您在不受支援的 Kubernetes 版本上執行叢集，請針對更新[檢閱潛在影響](#version_types)，然後立即[更新叢集](cs_cluster_update.html#update)，以繼續接收重要的安全更新和支援。
*  **注意**：如果您等到叢集在支援的版本後有三個以上的次要版本，則必須強制更新，這可能導致非預期的結果或失敗。
*  不受支援的叢集無法新增或重新載入現有的工作者節點。
*  將叢集更新為支援的版本之後，您的叢集可以繼續正常作業並繼續接收支援。

</br>

若要檢查叢集的伺服器版本，請執行下列指令。

```
kubectl version  --short | grep -i server
```
{: pre}

輸出範例：

```
Server Version: v1.10.7+IKS
```
{: screen}


## 更新類型
{: #update_types}

您的 Kubernetes 叢集具有三種類型的更新：主要、次要及修補程式。
{:shortdesc}

|更新類型|版本標籤的範例|更新者|影響
|-----|-----|-----|-----|
|主要|1.x.x|您|叢集的作業變更，包括 Script 或部署。|
|次要|x.9.x|您|叢集的作業變更，包括 Script 或部署。|
|修補程式|x.x.4_1510|IBM 與您|Kubernetes 修補程式，以及其他 {{site.data.keyword.Bluemix_notm}} Provider 元件更新，例如安全及作業系統修補程式。IBM 會自動更新主節點，但由您將修補程式套用至工作者節點。|
{: caption="Kubernetes 更新的影響" caption-side="top"}

有可用的更新時，會在您檢視工作者節點的相關資訊時，使用如下指令通知您：`ibmcloud ks workers <cluster>` 或 `ibmcloud ks worker-get <cluster> <worker>`。
-  **主要及次要更新**：首先[更新您的主節點](cs_cluster_update.html#master)，然後[更新工作者節點](cs_cluster_update.html#worker_node)。
   - 依預設，Kibernetes 主節點無法往前更新三個以上的次要版本。例如，如果現行主節點是 1.5 版，而您要更新至 1.8，則必須先更新至 1.7。您可以強制更新繼續進行，但更新超過兩個次要版本可能會造成非預期的結果或失敗。
   - 如果您使用的 `kubectl` CLI 版本未至少符合叢集的 `major.minor` 版本，則您可能會看到非預期的結果。請確定 Kubernetes 叢集和 [CLI 版本](cs_cli_install.html#kubectl)保持最新。

-  **修補程式更新**：每月檢查以查看是否有可用的更新，並使用 `ibmcloud ks worker-update` [指令](cs_cli_reference.html#cs_worker_update)或 `ibmcloud ks worker-reload` [指令](cs_cli_reference.html#cs_worker_reload)來套用這些安全及作業系統修補程式。如需相關資訊，請參閱[版本變更日誌](cs_versions_changelog.html)。

<br/>

此資訊彙總當您將叢集從舊版更新為新版本時，可能會對已部署的應用程式造成影響的更新。
-  1.11 版[移轉動作](#cs_v111)。
-  1.10 版[移轉動作](#cs_v110)。
-  1.9 版[移轉動作](#cs_v19)。
-  已淘汰或不受支援版本的[保存檔](#k8s_version_archive)。

<br/>

如需完整的變更清單，請檢閱下列資訊：
* [Kubernetes 變更日誌 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)。
* [IBM 版本變更日誌](cs_versions_changelog.html)。

</br>

## 1.11 版
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.11 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.11 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.11 版時，您可能需要進行的變更。

### 在主節點之前更新
{: #111_before}

<table summary="1.11 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.11 之前要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>`containerd` 新的 Kubernetes 容器運行環境</td>
<td><strong>重要事項</strong>：`containerd` 會將 Docker 取代為 Kubernetes 的新容器運行環境。如需您必須採取的動作，請參閱[移轉至 `containerd` 作為容器運行環境](#containerd)。</td>
</tr>
<tr>
<td>Kubernetes 容器磁區裝載傳播</td>
<td>容器 `VolumeMount` 的 [`mountPropagation` 欄位 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) 預設值已從 `HostToContainer` 變更為 `None`。此變更會還原 Kubernetes 1.9 版及更早版本中存在的行為。如果您的 Pod 規格依賴 `HostToContainer` 作為預設值，請予以更新。</td>
</tr>
<tr>
<td>Kubernetes API 伺服器 JSON 解除序列化程式</td>
<td>Kubernetes API 伺服器 JSON 解除序列化程式現在區分大小寫。此變更會還原 Kubernetes 1.7 版及更早版本中存在的行為。如果您 JSON 資源定義使用的大小寫不正確，請予以更新。<br><br>**附註**：只會影響直接 Kubernetes API 伺服器要求。`kubectl` CLI 已在 Kubernetes 1.7 版及更新版本中繼續強制執行區分大小寫金鑰，因此，如果您使用 `kubectl` 嚴格管理資源，則不受影響。</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #111_after}

<table summary="1.11 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.11 之後要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>叢集記載配置</td>
<td>即使停用 `logging-autoupdate`，還是會使用 1.11 版自動更新 `fluentd` 叢集附加程式。<br><br>
容器日誌目錄已從 `/var/lib/docker/` 變更為 `/var/log/pods/`。如果您使用自己的記載解決方案來監視前一個目錄，則請相應地更新。</td>
</tr>
<tr>
<td>重新整理 Kubernetes 配置</td>
<td>已更新叢集 Kubernetes API 伺服器的 OpenID Connect 配置，以支援 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 存取群組。因此，您必須在主節點 Kubernetes 1.11 版更新之後，執行 `ibmcloud ks cluster-config --cluster <cluster_name_or_ID>` 來重新整理叢集的 Kubernetes 配置。<br><br>如果您未重新整理配置，則叢集動作會失敗，錯誤訊息如下：`You must be logged in to the server (Unauthorized).`</td>
</tr>
<tr>
<td>`kubectl` CLI</td>
<td>Kubernetes 1.11 版的 `kubectl` CLI 需要 `apps/v1` API。因此，1.11 版 `kubectl` CLI 不適用於執行 Kubernetes 1.8 版或更早版本的叢集。請使用與叢集之 Kubernetes API 伺服器版本相符的 `kubectl` CLI 版本。</td>
</tr>
<tr>
<td>`kubectl auth can-i`</td>
<td>現在，使用者未獲授權時，`kubectl auth can-i` 指令會失敗，並出現 `exit code 1`。如果您的 Script 依賴先前的行為，請予以更新。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>現在，依預設，使用選取準則（例如標籤）刪除資源時，`kubectl delete` 指令會忽略 `not found` 錯誤。如果您的 Script 依賴先前的行為，請予以更新。</td>
</tr>
<tr>
<td>Kubernetes `sysctls` 特性</td>
<td>現在已忽略 `security.alpha.kubernetes.io/sysctls` 註釋。相反地，Kubernetes 已將欄位新增至 `PodSecurityPolicy` 及 `Pod` 物件，以指定及控制 `sysctls`。如需相關資訊，請參閱[在 Kubernetes 中使用 sysctls ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/)。<br><br>在您更新叢集主節點及工作者節點之後，請更新 `PodSecurityPolicy` 及 `Pod` 物件，以使用新的 `sysctls` 欄位。</td>
</tr>
</tbody>
</table>

### 移轉至 `containerd` 作為容器運行環境
{: #containerd}

對於執行 Kubernetes 1.11 版或更新版本的叢集，`containerd` 會將 Docker 取代為 Kubernetes 的新容器運行環境來加強效能。如果您的 Pod 依賴 Docker 作為 Kubernetes 容器運行環境，則您必須更新它們以處理 `containerd` 作為容器運行環境。如需相關資訊，請參閱 [Kubernetes containerd 公告 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/)。
{: shortdesc}

**如何知道我的應用程式依賴 `docker` 而非 `containerd`？**<br>
您可能依賴 Docker 作為容器運行環境的情況範例：
*  如果您使用特許容器直接存取 Docker 引擎或 API，則請更新 Pod 以支援 `containerd` 作為運行環境。
*  您在叢集中安裝的部分協力廠商附加程式（例如記載及監視工具）可能依賴 Docker 引擎。請檢查您的提供者，確定工具與 `containerd` 相容。

<br>

**除了依賴運行環境之外，我是否還需要採取其他移轉動作？**<br>

**manifest 工具**：如果您的多平台映像檔是使用 Docker 18.06 版之前的實驗性 `docker manifest` [工具 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.docker.com/edge/engine/reference/commandline/manifest/) 所建置，則無法使用 `containerd` 從 DockerHub 取回映像檔。

當您檢查 Pod 事件時，可能會看到如下錯誤：
```
failed size validation
```
{: screen}

若要搭配使用利用 manifest 工具所建置的映像檔與 `containerd`，請從下列選項中選擇。

*  使用 [manifest 工具 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/estesp/manifest-tool) 來重建映像檔。
*  在您更新為 Docker 18.06 版或更新版本之後，請使用 `docker-manifest` 工具來重建映像檔。

<br>

**不受影響的項目為何？我需要變更容器的部署方式嗎？**<br>
一般而言，容器部署處理程序不會變更。您仍然可以使用 Dockerfile 來定義 Docker 映像檔，並為您的應用程式建置 Docker 容器。如果您使用 `docker` 指令來建置映像檔，並將其推送至登錄，則可以繼續使用 `docker`，或改為使用 `ibmcloud cr` 指令。

## 1.10 版
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.10 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.10 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.10 版時，您可能需要進行的變更。

**重要事項**：您必須遵循[準備更新至 Calico 第 3 版](#110_calicov3)中所列的步驟，才能順利更新至 Kubernetes 1.10。

<br/>

### 在主節點之前更新
{: #110_before}

<table summary="1.10 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.10 之前要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico 第 3 版</td>
<td>更新至 Kubernetes 1.10 版也會將 Calico 從 2.6.5 版更新至 3.1.1 版。<strong>重要事項</strong>：您必須遵循[準備更新至 Calico 第 3 版](#110_calicov3)中所列的步驟，才能順利更新至 Kubernetes 1.10 版。</td>
</tr>
<tr>
<td>Kubernetes 儀表板網路原則</td>
<td>在 Kubernetes 1.10 中，<code>kube-system</code> 名稱空間中的 <code>kubernetes-dashboard</code> 網路原則會封鎖所有 Pod，使其無法存取 Kubernetes 儀表板。不過，這<strong>不會</strong>影響從 {{site.data.keyword.Bluemix_notm}} 主控台或使用 <code>kubectl proxy</code> 存取儀表板的能力。如果 Pod 需要存取儀表板，您可以將 <code>kubernetes-dashboard-policy: allow</code> 標籤新增至名稱空間，然後將 Pod 部署至名稱空間。</td>
</tr>
<tr>
<td>Kubelet API 存取</td>
<td>Kubelet API 權限現在已委派給 <code>Kubernetes API 伺服器</code>。存取 Kubelet API 是根據 <code>ClusterRole</code>，它們會授與存取 <strong>node</strong> 子資源的許可權。依預設，Kubernetes Heapster 具有 <code>ClusterRole</code> 及 <code>ClusterRoleBinding</code>。不過，如果其他使用者或應用程式使用 Kubelet API，您必須將使用 API 的許可權授與他們/它們。請參閱 [Kubelet 授權 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/) 上的 Kubernetes 文件。</td>
</tr>
<tr>
<td>密碼組合</td>
<td><code>Kubernetes API 伺服器</code>及 Kubelet API 的受支援密碼組合現在限制為具有高強度加密（128 位元或以上）的子集。如果您的現有自動化或資源使用較低保護性的密碼，並根據與 <code>Kubernetes API 伺服器</code>或 Kubelet API 的通訊，則請先啟用較高保護性的密碼支援，再更新主節點。</td>
</tr>
<tr>
<td>strongSwan VPN
</td>
<td>如果您使用 [strongSwan](cs_vpn.html#vpn-setup) 進行 VPN 連線，則必須執行 `helm delete --purge <release_name>` 來移除圖表，然後再更新叢集。在叢集更新完成之後，請重新安裝 strongSwan Helm 圖表。</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #110_after}

<table summary="1.10 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.10 之後要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico 第 3 版</td>
<td>更新叢集時，會自動移轉套用至叢集的所有現有 Calico 資料，以使用 Calico 第 3 版語法。若要使用 Calico 第 3 版語法來檢視、新增或修改 Calico 資源，請更新 [Calico CLI 配置至 3.1.1 版](#110_calicov3)。</td>
</tr>
<tr>
<td>節點 <code>ExternalIP</code> 位址</td>
<td>節點的 <code>ExternalIP</code> 欄位現在設定為節點的公用 IP 位址值。請檢閱並更新依賴此值的任何資源。</td>
</tr>
<tr>
<td><code>kubectl port-forward</code></td>
<td>現在，當您使用 <code>kubectl port-forward</code> 指令時，不再支援 <code>-p</code> 旗標。如果您的 Script 依賴先前的行為，請更新它們，以將 <code>-p</code> 旗標取代為 Pod 名稱。</td>
</tr>
<tr>
<td>唯讀 API 資料磁區</td>
<td>現在，`secret`、`configMap`、`downwardAPI` 及預期的磁區是已裝載的唯讀磁區。
先前，容許應用程式可將資料寫入至這些磁區，而系統可能會自動回復這些磁區。修正安全漏洞 [CVE-2017-1002102![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) 需要這個移轉動作。
如果您的應用程式依賴先前不安全的行為，請相應地修改它們。</td>
</tr>
<tr>
<td>strongSwan VPN
</td>
<td>如果您使用 [strongSwan](cs_vpn.html#vpn-setup) 進行 VPN 連線，並在更新叢集之前已刪除圖表，則現在可以重新安裝 strongSwan Helm 圖表。</td>
</tr>
</tbody>
</table>

### 準備更新至 Calico 第 3 版
{: #110_calicov3}

開始之前，您的叢集主節點及所有工作者節點都必須執行 Kubernetes 1.8 版或更新版本，且必須至少有一個工作者節點。

**重要事項**：在更新主節點之前，請先準備進行 Calico 第 3 版更新。在主節點升級至 Kubernetes 1.10 版期間，不會排定新的 Pod 及新的 Kubernetes 或 Calico 網路原則。更新導致無法進行新排程的時間量會不同。小型叢集可能需要數分鐘的時間，而且每 10 個節點需要額外幾分鐘的時間。現有網路原則及 Pod 會繼續執行。

1.  驗證 Calico Pod 性能良好。
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  如果有任何 Pod 未處於 **Running** 狀況，則請刪除 Pod，並先等到它處於 **Running** 狀況，再繼續進行。

3.  如果您自動產生 Calico 原則或其他 Calico 資源，則請更新自動化工具，以使用 [Calico 第 3 版語法 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) 來產生這些資源。

4.  如果您將 [strongSwan](cs_vpn.html#vpn-setup) 用於 VPN 連線功能，則 strongSwan 2.0.0 Helm 圖表不會使用 Calico 第 3 版或 Kubernetes 1.10。[更新 strongSwan](cs_vpn.html#vpn_upgrade) 至 2.1.0 Helm 圖表，其與 Calico 2.6 及 Kubernetes 1.7、1.8 及 1.9 舊版相容。

5.  [將叢集主節點更新至 Kubernetes 1.10 版](cs_cluster_update.html#master)。

<br />


## 1.9 版
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.9 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.9 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.9 版時，您可能需要進行的變更。

<br/>

### 在主節點之前更新
{: #19_before}

<table summary="1.9 版的 Kubernetes 更新">
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
<td>在 API 伺服器呼叫許可控制 Webhook 時使用的許可 API，從 <code>admission.v1alpha1</code> 移至 <code>admission.v1beta1</code>。<em>在升級叢集之前您必須刪除任何現有的 Webhook</em>，並更新 Webhook 配置檔來使用最新 API。此變更與舊版不相容。</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #19_after}

<table summary="1.9 版的 Kubernetes 更新">
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
<td>現在，當您使用 `kubectl` 指令來指定 `-o custom-columns`，但在物件中找不到該直欄時，您會看到輸出 `<none>`。<br>
之前，作業會失敗，且您看到 `xxx is not found` 錯誤訊息。如果您的 Script 依賴先前的行為，請予以更新。</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>現在，當未對修補的資源進行任何變更時，`kubectl patch` 指令會失敗，並出現 `exit code 1`。如果您的 Script 依賴先前的行為，請予以更新。</td>
</tr>
<tr>
<td>Kubernetes 儀表板許可權</td>
<td>使用者必須使用其認證來登入 Kubernetes 儀表板，以檢視叢集資源。已移除預設 Kubernetes 儀表板 `ClusterRoleBinding` RBAC 授權。如需指示，請參閱[啟動 Kubernetes 儀表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>唯讀 API 資料磁區</td>
<td>現在，`secret`、`configMap`、`downwardAPI` 及預期的磁區是已裝載的唯讀磁區。
先前，容許應用程式可將資料寫入至這些磁區，而系統可能會自動回復這些磁區。修正安全漏洞 [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) 需要這個移轉動作。
如果您的應用程式依賴先前不安全的行為，請相應地修改它們。</td>
</tr>
<tr>
<td>污點及容忍</td>
<td>`node.alpha.kubernetes.io/notReady` 及 `node.alpha.kubernetes.io/unreachable` 污點已分別變更為 `node.kubernetes.io/not-ready` 及 `node.kubernetes.io/unreachable`。<br>
雖然會自動更新污點，但您必須手動更新這些污點的容忍。針對 `ibm-system` 及 `kube-system` 以外的每一個名稱空間，判斷您是否需要變更容忍：<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
如果傳回 `Action required`，請相應地修改 Pod 容忍。</td>
</tr>
<tr>
<td>Webhook 許可 API</td>
<td>如果您已在更新叢集之前刪除現有 Webhook，請建立新的 Webhook。</td>
</tr>
</tbody>
</table>

<br />



## 保存
{: #k8s_version_archive}

### 1.8 版（已淘汰，自 2018 年 9 月 22 日起不受支援）
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.8 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.8 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.8 版時，您可能需要進行的變更。

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
<td>無</td>
<td>更新主節點之前不需要任何變更</td>
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
<td>用於存取 1.8 版中的 Kubernetes 儀表板的 URL 已變更，且登入處理程序包含新的鑑別步驟。如需相關資訊，請參閱[存取 Kubernetes 儀表板](cs_app.html#cli_dashboard)。</td>
</tr>
<tr>
<td>Kubernetes 儀表板許可權</td>
<td>若要強制使用者利用其認證登入以檢視 1.8 版中的叢集資源，請移除 1.7 ClusterRoleBinding RBAC 授權。執行 `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`。</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>在刪除物件之前，`kubectl delete` 指令不再縮減工作負載 API 物件（如 Pod）。如果需要縮減物件，請在刪除物件之前，使用 [`kubectl scale ` ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/overview/#scale)。</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>`kubectl run` 指令必須對 `--env` 使用多個旗標，而非逗點區隔的引數。例如，執行 <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code>，而非 <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>。</td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>`kubectl stop` 指令無法再使用。</td>
</tr>
<tr>
<td>唯讀 API 資料磁區</td>
<td>現在，`secret`、`configMap`、`downwardAPI` 及預期的磁區是已裝載的唯讀磁區。
先前，容許應用程式可將資料寫入至這些磁區，而系統可能會自動回復這些磁區。修正安全漏洞 [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) 需要這個移轉動作。
如果您的應用程式依賴先前不安全的行為，請相應地修改它們。</td>
</tr>
</tbody>
</table>

<br />


### 1.7 版（不受支援）
{: #cs_v17}

自 2018 年 6 月 21 日起，不支援執行 [Kubernetes 1.7 版](cs_versions_changelog.html#changelog_archive)的 {{site.data.keyword.containerlong_notm}} 叢集。1.7 版叢集無法接收安全更新或支援，除非它們更新為下一個最新版本 ([Kubernetes 1.8](#cs_v18))。

針對每一個 Kubernetes 版本更新[檢閱潛在影響](cs_versions.html#cs_versions)，然後立即[將您的叢集更新](cs_cluster_update.html#update)為至少 1.8。

### 1.5 版（不受支援）
{: #cs_v1-5}

自 2018 年 4 月 4 日起，不支援執行 [Kubernetes 1.5 版](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md)的 {{site.data.keyword.containerlong_notm}} 叢集。1.5 版叢集無法接收安全更新或支援，除非它們更新為下一個最新版本 ([Kubernetes 1.8](#cs_v18))。

針對每一個 Kubernetes 版本更新[檢閱潛在影響](cs_versions.html#cs_versions)，然後立即[將您的叢集更新](cs_cluster_update.html#update)為至少 1.8。
