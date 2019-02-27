---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# 版本資訊及更新動作
{: #cs_versions}

## Kubernetes 版本類型
{: #version_types}

{{site.data.keyword.containerlong}} 同時支援多個 Kubernetes 版本。發行最新版本 (n) 時，最多支援到前 2 個 (n-2) 版本。超過最新版本前 2 個版本的版本 (n-3) 會先被淘汰，然後不受支援。
{:shortdesc}

**支援的 Kubernetes 版本**:
- 最新：1.12.3
- 預設：1.10.11
- 其他：1.11.5

</br>

**已淘汰的版本**：當叢集在已淘汰的 Kubernetes 版本上執行時，在版本變成不受支援之前，您有 30 天的時間可以檢閱並更新至受支援的 Kubernetes 版本。在淘汰期間，您的叢集仍可運作，但可能需要更新為支援的版本，以修正安全漏洞。您無法建立使用已淘汰版本的新叢集。

**不受支援的版本**：如果您在不受支援的 Kubernetes 版本上執行叢集，請檢閱下列更新的潛在影響，然後立即[更新叢集](cs_cluster_update.html#update)，以繼續接收重要的安全更新及支援。
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
Server Version: v1.10.11+IKS
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
|修補程式|x.x.4_1510|IBM 與您|Kubernetes 修補程式，以及其他 {{site.data.keyword.Bluemix_notm}} Provider 元件更新，例如安全及作業系統修補程式。IBM 會自動更新主節點，但由您將修補程式套用至工作者節點。如需修補程式的相關資訊，請參閱下節。|
{: caption="Kubernetes 更新的影響" caption-side="top"}

有可用的更新時，會在您檢視工作者節點的相關資訊時，使用如下指令通知您：`ibmcloud ks workers <cluster>` 或 `ibmcloud ks worker-get <cluster> <worker>`。
-  **主要及次要更新**：首先[更新您的主節點](cs_cluster_update.html#master)，然後[更新工作者節點](cs_cluster_update.html#worker_node)。
   - 依預設，Kibernetes 主節點無法往前更新三個以上的次要版本。例如，如果現行主節點是 1.9 版，而您要更新至 1.12，則必須先更新至 1.10。您可以強制更新繼續進行，但更新超過兩個次要版本可能會造成非預期的結果或失敗。
   - 如果您使用的 `kubectl` CLI 版本未至少符合叢集的 `major.minor` 版本，則您可能會看到非預期的結果。請確定 Kubernetes 叢集和 [CLI 版本](cs_cli_install.html#kubectl)保持最新。

-  **修補程式更新**：各種修補程式的變更記載於[版本變更日誌](cs_versions_changelog.html)。有可用的更新時，會在您檢視 {{site.data.keyword.Bluemix_notm}} 主控台或 CLI 中主節點及工作者節點的相關資訊時，使用如下指令通知您：`ibmcloud ks clusters`、`cluster-get`、`workers` 或 `worker-get`。
   - **工作者節點修補程式**：每月檢查以查看是否有可用的更新，並使用 `ibmcloud ks worker-update` [指令](cs_cli_reference.html#cs_worker_update)或 `ibmcloud ks worker-reload` [指令](cs_cli_reference.html#cs_worker_reload)來套用這些安全及作業系統修補程式。請注意，在更新或重新載入期間，您的工作者節點機器會重新安裝映像，而且如果資料不是[儲存在工作者節點之外](cs_storage_planning.html#persistent_storage_overview)即會被刪除。
   - **主節點修補程式**：主節點修補程式會在數天的期間後自動套用，因此，主節點修補程式版本可能會先顯示為可用，再將它套用至您的主節點。更新自動化也會跳過處於性能不佳狀態或目前正在進行作業的叢集。有時，IBM 可能會停用特定主節點修正套件的自動更新（如變更日誌中所述），例如只有在主節點從某個次要版本更新為另一個次要版本時才需要的修補程式。在其中任何情況下，您可以選擇自行安全地使用 `ibmcloud ks cluster-update` [指令](cs_cli_reference.html#cs_cluster_update)，而不需要等待套用更新自動化。

</br>

此資訊彙總當您將叢集從舊版更新為新版本時，可能會對已部署的應用程式造成影響的更新。
-  1.12 版[準備動作](#cs_v112)。
-  1.11 版[準備動作](#cs_v111)。
-  1.10 版[準備動作](#cs_v110)。
-  已淘汰或不受支援版本的[保存檔](#k8s_version_archive)。

<br/>

如需完整的變更清單，請檢閱下列資訊：
* [Kubernetes 變更日誌 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md)。
* [IBM 版本變更日誌](cs_versions_changelog.html)。

</br>

## 1.12 版
{: #cs_v112}

<p><img src="images/certified_kubernetes_1x12.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.21 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.12 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.12 版時，您可能需要進行的變更。
{: shortdesc}

### 在主節點之前更新
{: #112_before}

下表顯示您在更新 Kubernetes 主節點之前必須採取的動作。
{: shortdesc}

<table summary="1.12 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.12 之前要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes Metrics Server</td>
<td>如果您目前在叢集裡已部署 Kubernetes `metric-server`，則必須先移除 `metric-server`，然後再將叢集更新至 Kubernet 1.12。此移除可防止與更新期間所部署的 `metric-server` 發生衝突。</td>
</tr>
<tr>
<td>`kube-system` `default` 服務帳戶的角色連結</td>
<td>`kube-system` `default` 服務帳戶不再具有 Kubernetes API 的 **cluster-admin** 存取權。如果您部署的特性或附加程式（例如 [Helm](cs_integrations.html#helm)）需要存取叢集裡的處理程序，請設定[服務帳戶 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)。如果您需要時間來建立及設定具有適當許可權的個別服務帳戶，則可以使用下列叢集角色連結來暫時授與 **cluster-admin** 角色：`kubectl create clusterrolebinding kube-system:default --clusterrole=cluster-admin --serviceaccount=kube-system:default`</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #112_after}

下表顯示您在更新 Kubernetes 主節點之後必須採取的動作。
{: shortdesc}

<table summary="1.12 版的 Kubernetes 更新">
<caption>在將主節點更新至 Kubernetes 1.12 之後要進行的變更</caption>
<thead>
<tr>
<th>類型</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>`apps/v1` Kubernetes API</td>
<td>`apps/v1` Kubernetes API 會取代 `extensions`、`apps/v1beta1` 及 `apps/v1alpha` API。Kubernetes 專案即將淘汰，並逐步淘汰支援來自 Kubernetes `apiserver` 及 `kubectl` 用戶端的前一個 API。<br><br>您必須將所有 YAML `apiVersion` 欄位更新為使用 `apps/v1`。另請檢閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)，以取得與 `apps/v1` 相關的變更，如下所示。
<ul><li>在建立部署之後，`.spec.selector` 欄位是不可變的。</li>
<li>`.spec.rollbackTo` 欄位已淘汰。請改用 `kubectl rollout undo` 指令。</li></ul></td>
</tr>
<tr>
<td>CoreDNS 可作為叢集 DNS 提供者</td>
<td>Kubernetes 專案正在進行轉移，以支援 CoreDNS 而非現行 Kbernetes DNS (KubeDNS)。在 1.12 版中，預設叢集 DNS 會保留 KubeDNS，但您可以[選擇使用 CoreDNS](cs_cluster_update.html#dns)。</td>
</tr>
<tr>
<td>`kubectl apply --force`</td>
<td>現在，當您在無法更新的資源（例如 YAML 檔案中不可變的欄位）上強制執行套用動作 (`kubbectl apply --force`) 時，即會改為重建資源。如果您的 Script 依賴先前的行為，請予以更新。</td>
</tr>
<tr>
<td>`kubectl logs --interactive`</td>
<td>`kibectl logs` 不再支援 `--interactive` 旗標。請更新任何使用此旗標的自動化。</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>如果 `patch` 指令導致沒有變更（冗餘修補程式），則這個指令不再以 `1` 回覆碼結束。如果您的 Script 依賴先前的行為，請予以更新。</td>
</tr>
<tr>
<td>`kubectl version -c`</td>
<td>不再支援 `-c` 速記旗標。請改用完整 `--client` 旗標。請更新任何使用此旗標的自動化。</td>
</tr>
<tr>
<td>`kubectl wait`</td>
<td>如果找不到任何相符的選取器，這個指令現在會列印錯誤訊息，並以 `1` 回覆碼結束。如果您的 Script 依賴先前的行為，請予以更新。</td>
</tr>
<tr>
<td>kubelet cAdvisor 埠</td>
<td>kubelet 藉由啟動 `--cadvisor-port` 而使用的[容器顧問 (cAdvisor) ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/google/cadvisor) Web 使用者介面會從 Kubernetes 1.12 移除。如果您仍需要執行 cAdvisor，請[將 cAdvisor 部署為常駐程式集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/google/cadvisor/tree/master/deploy/kubernetes)。<br><br>在常駐程式集中，指定埠區段，以透過 `http://node-ip:4194` 與 cAdvisor 聯繫，如下所示。請注意 cAdvisor Pod 會失敗，直到工作者節點已更新至 1.12，因為舊版 kellet 將主機埠 4194 用於 cAdvisor。<pre class="screen"><code>ports:
          - name: http
            containerPort: 8080
            hostPort: 4194
            protocol: TCP</code></pre></td>
</tr>
<tr>
<td>Kubernetes 儀表板</td>
<td>如果您透過 `kubectl proxy` 存取儀表板，則會移除登入頁面上的**跳過**按鈕。請改用**記號**來登入。</td>
</tr>
<tr>
<td id="metrics-server">Kubernetes Metrics Server</td>
<td>Kubernetes Metrics Server 取代 Kubernetes Heapster（自 Kubernetes 1.8 版後已淘汰）作為叢集度量值提供者。如果您對叢集裡的每個工作者節點執行超過 30 個 Pod，請[調整效能的 `metrics-server` 配置](cs_performance.html#metrics)。<p>Kubernetes 儀表板不會使用 `metrics-server`。如果您想要在儀表板中顯示度量，請從下列選項中選擇。</p>
<ul><li>使用「叢集監視儀表板」來[設定 Grafana 以分析度量值](/docs/services/cloud-monitoring/tutorials/container_service_metrics.html#container_service_metrics)。</li>
<li>將 [Heapster ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/heapster) 部署至您的叢集。
<ol><li>複製 `heapster-rbac` [YAML ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/heapster-rbac.yaml)、`heapster-service` [YAML ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml) 及 `heapster-controller` [YAML ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml) 檔案。</li>
<li>取代下列字串來編輯 `heapster-controller` YAML。
<ul><li>將 `{{ nanny_memory }}` 取代為 `90Mi`</li>
<li>將 `{{ base_metrics_cpu }}` 取代為 `80m`</li>
<li>將 `{{ metrics_cpu_per_node }}` 取代為 `0.5m`</li>
<li>將 `{{ base_metrics_memory }}` 取代為 `140Mi`</li>
<li>將 `{{ metrics_memory_per_node }}` 取代為 `4Mi`</li>
<li>將 `{{ heapster_min_cluster_size }}` 取代為 `16`</li></ul></li>
<li>執行 `kibectl apply -f` 指令，將 `heapster-rbac`、`heapster-service` 及 `heapster-controller` YAML 檔案套用至您的叢集。</li></ol></li></ul></td>
</tr>
<tr>
<td>`rbac.authorization.k8s.io/v1` Kubernetes API</td>
<td>`rbac.authorization.k8s.io/v1` Kubernetes API（自 Kubernetes 1.8 後支援它）即將取代 `rbac.authorization.k8s.io/v1alpha1` 及 `rbac.authorization.k8s.io/v1beta1` API。您無法再使用不受支援的 `v1alpha` API 來建立 RBAC 物件，例如角色或角色連結。現有的 RBAC 物件會轉換為 `v1` API。</td>
</tr>
</tbody>
</table>

## 1.11 版
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.11 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.11 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.11 版時，您可能需要進行的變更。
{: shortdesc}

您必須遵循[準備更新至 Calico 第 3 版](#111_calicov3)中所列的步驟，才能順利將叢集從 Kubernetes 1.9 版或更早版本更新至 1.11 版。
{: important}

### 在主節點之前更新
{: #111_before}

下表顯示您在更新 Kubernetes 主節點之前必須採取的動作。
{: shortdesc}

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
<td>叢集主節點高可用性 (HA) 配置</td>
<td>已更新叢集主節點配置來增加高可用性 (HA)。叢集現在具有三個 Kubernetes 主節點抄本，而設定這些抄本時，每一個主節點會部署在個別的實體主機上。此外，如果您的叢集是在具有多區域功能的區域中，則主節點會分散在各區域之中。<br><br>如需您必須採取的動作，請參閱[更新為高可用性叢集主節點](#ha-masters)。這些準備動作適用下列情況：<ul>
<li>如果您具有防火牆或自訂 Calico 網路原則。</li>
<li>如果您是在工作者節點上使用主機埠 `2040` 或 `2041`。</li>
<li>如果您已使用叢集主節點 IP 位址，對主節點進行叢集內存取。</li>
<li>如果您具有呼叫 Calico API 或 CLI (`calictl`) 的自動化，例如，建立 Calico 原則。</li>
<li>如果您使用 Kubernetes 或 Calico 網路原則，來控制對主節點的 Pod Egress 存取。</li></ul></td>
</tr>
<tr>
<td>`containerd` 新的 Kubernetes 容器運行環境</td>
<td><p class="important">`containerd` 會將 Docker 取代為 Kubernetes 的新容器運行環境。如需您必須採取的動作，請參閱[更新為 `containerd` 作為容器運行環境](#containerd)。</p></td>
</tr>
<tr>
<td>加密 etcd 中的資料</td>
<td>先前，etcd 資料是儲存在主節點的 NFS 檔案儲存空間實例上，而此實例是在靜止時加密。現在，etcd 資料是儲存在主節點的本端磁碟上，並備份至 {{site.data.keyword.cos_full_notm}}。資料是在傳送至 {{site.data.keyword.cos_full_notm}} 期間和靜止時加密。不過，主節點的本端磁碟上的 etcd 資料不會加密。如果您想要將主節點的本端 etcd 資料加密，請[在您的叢集裡啟用 {{site.data.keyword.keymanagementservicelong_notm}}](cs_encrypt.html#keyprotect)。</td>
</tr>
<tr>
<td>Kubernetes 容器磁區裝載傳播</td>
<td>容器 `VolumeMount` 的 [`mountPropagation` 欄位 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) 預設值已從 `HostToContainer` 變更為 `None`。此變更會還原 Kubernetes 1.9 版及更早版本中存在的行為。如果您的 Pod 規格依賴 `HostToContainer` 作為預設值，請予以更新。</td>
</tr>
<tr>
<td>Kubernetes API 伺服器 JSON 解除序列化程式</td>
<td>Kubernetes API 伺服器 JSON 解除序列化程式現在區分大小寫。此變更會還原 Kubernetes 1.7 版及更早版本中存在的行為。如果您 JSON 資源定義使用的大小寫不正確，請予以更新。<br><br>只會影響直接 Kubernetes API 伺服器要求。`kubectl` CLI 已在 Kubernetes 1.7 版及更新版本中繼續強制執行區分大小寫金鑰，因此，如果您使用 `kubectl` 嚴格管理資源，則不受影響。</td>
</tr>
</tbody>
</table>

### 在主節點之後更新
{: #111_after}

下表顯示您在更新 Kubernetes 主節點之後必須採取的動作。
{: shortdesc}

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

### 更新為 Kubernetes 1.11 中的高可用性叢集主節點
{: #ha-masters}

對於執行 Kubernetes [1.10.8_1530](#110_ha-masters) 版、1.11.3_1531 版或更新版本的叢集，會更新叢集主節點配置以增加高可用性 (HA)。叢集現在具有三個 Kubernetes 主節點抄本，而設定這些抄本時，每一個主節點會部署在個別的實體主機上。此外，如果您的叢集是在具有多區域功能的區域中，則主節點會分散在各區域之中。
{: shortdesc}

將叢集從 1.9 版或更舊的 1.10 或 1.11 修補程式更新至這個 Kubernetes 版本時，您需要採取這些準備步驟。為了讓您有時間，會暫時停用主節點的自動更新。如需相關資訊和時間表，請參閱 [HA 主節點部落格文章](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/)。
{: tip}

檢閱下列狀況，而您必須在其中進行變更，才能充分運用 HA 主節點配置：
* 如果您具有防火牆或自訂 Calico 網路原則。
* 如果您是在工作者節點上使用主機埠 `2040` 或 `2041`。
* 如果您已使用叢集主節點 IP 位址，對主節點進行叢集內存取。
* 如果您具有呼叫 Calico API 或 CLI (`calictl`) 的自動化，例如，建立 Calico 原則。
* 如果您使用 Kubernetes 或 Calico 網路原則，來控制對主節點的 Pod Egress 存取。

<br>
**針對 HA 主節點更新防火牆或自訂的 Calico 主機網路原則**：</br>
{: #ha-firewall}
如果您使用防火牆或自訂的 Calico 主機網路原則，控制來自工作者節點的 Egress，則容許將資料流量送出至叢集所在地區內所有區域的埠及 IP 位址。請參閱[容許叢集存取基礎架構資源及其他服務](cs_firewall.html#firewall_outbound)。

<br>
**保留工作者節點上的主機埠 `2040` 及 `2041`**：</br>
{: #ha-ports}
若要容許存取 HA 配置中的叢集主節點，您必須在所有工作者節點上將主機埠 `2040` 和 `2041` 保留為可用狀態。
* 更新任何 Pod，將 `hostPort` 設為 `2040` 或 `2041` 來使用不同的埠。
* 更新任何在埠 `2040` 或 `2041` 上接聽的 Pod，將 `hostNetwork` 設為 `true` 來使用不同的埠。

若要檢查您的 Pod 目前是否使用埠 `2040` 或 `2041`，請將目標設為您的叢集並執行下列指令。

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

<br>
**使用 `kubernetes` 服務叢集 IP 或網域，對主節點進行叢集內存取**：</br>
{: #ha-incluster}
若要從叢集內的 HA 配置中存取叢集主節點，請使用下列其中一項：
* `kubernetes` 服務叢集 IP 位址，預設為：`https://172.21.0.1`
* `kubernetes` 服務網域名稱，預設為：`https://kubernetes.default.svc.cluster.local`

如果您先前已使用叢集主節點 IP 位址，則此方法會繼續運作。不過，為了提高可用性，請更新為使用 `kubernetes` 服務叢集 IP 位址或網域名稱。

<br>
**配置 Calico 對具有 HA 配置的主節點進行叢集外存取**：</br>
{: #ha-outofcluster}
`kin-system` 名稱空間中 `calic-config` ConfigMap 所儲存的資料已變更為支援 HA 主節點配置。尤其，`etcd_endpoints` 值現在僅支援叢集內存取。使用此值來配置 Calico CLI 以從叢集外部進行存取，不再運作。

請改用 `kudo-system` 名稱空間中 `cluster-info` ConfigMap 所儲存的資料。尤其，使用 `etcd_host` 和 `etcd_port` 值來配置 [Calico CLI](cs_network_policy.html#cli_install) 的端點，從叢集外部存取具有 HA 配置的主節點。

<br>
**更新 Kubernetes 或 Calico 網路原則**：</br>
{: #ha-networkpolicies}
如果您使用 [Kubernetes 或 Calico 網路原則](cs_network_policy.html#network_policies)，來控制對叢集主節點的 Pod Egress 存取，而且您目前正在使用下列項目，則需要採取其他動作：
*  Kubernetes 服務叢集 IP，您可以藉由執行 `kubectl get service kubernetes -o yaml | grep clusterIP` 來取得此 IP。
*  Kubernetes 服務網域名稱，預設為 `https://kubernetes.default.svc.cluster.local`。
*  叢集主節點 IP，您可以藉由執行 `kubectl cluster-info | grep Kubernetes` 來取得此 IP。

下列步驟說明如何更新您的 Kubernet 網路原則。若要更新 Calico 網路原則，請重複這些步驟，搭配一些次要原則語法變更及 `calicoctl` 來搜尋原則找出影響。
{: note}

開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

1.  取得您的叢集主節點 IP 位址。
    ```
    kubectl cluster-info | grep Kubernetes
    ```
    {: pre}

2.  搜尋 Kubernetes 網路原則找出影響。如果未傳回任何 YAML，表示您的叢集未受到影響，因此您不需要進行其他變更。
    ```
    kubectl get networkpolicies --all-namespaces -o yaml | grep <cluster-master-ip>
    ```
    {: pre}

3.  檢閱 YAML。例如，如果您的叢集使用下列 Kubernetes 網路原則，容許 `default` 名稱空間中的 Pod，透過 `kubernetes` 服務叢集 IP 或叢集主節點 IP 存取叢集主節點，則您必須更新原則。
    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name or cluster master IP address.
      -   ports:

        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service
      # domain name.
      -   ports:

        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

4.  修訂 Kubernetes 網路原則，以容許對叢集內主節點 Proxy IP 位址 `172.20.0.1` 進行 Egress。目前，請保留叢集主節點 IP 位址。例如，前一個網路原則範例會變更為下列內容。

    如果您先前已將 Egress 原則設為僅針對單一 Kubernetes 主節點開啟單一 IP 位址及埠，則現在會使用叢集內主節點 Proxy IP 位址範圍 172.20.0.1/32 和埠 2040。
    {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name.
      -   ports:

        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service domain name.
      -   ports:

        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

5.  將修訂的網路原則套用至您的叢集。
    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

6.  在您完成所有[準備動作](#ha-masters)（包括這些步驟）之後，請[將叢集主節點更新為](cs_cluster_update.html#master) HA 主節點修正套件。

7.  在更新完成之後，請從網路原則移除叢集主節點 IP 位址。例如，從前一個網路原則移除下列這幾行，然後重新套用原則。

    ```
    - ipBlock:
        cidr: 161.202.126.210/32
    ```
    {: screen}

    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

### 更新為 `containerd` 作為容器運行環境
{: #containerd}

對於執行 Kubernetes 1.11 版或更新版本的叢集，`containerd` 會將 Docker 取代為 Kubernetes 的新容器運行環境來加強效能。如果您的 Pod 依賴 Docker 作為 Kubernetes 容器運行環境，則您必須更新它們以處理 `containerd` 作為容器運行環境。如需相關資訊，請參閱 [Kubernetes containerd 公告 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/)。
{: shortdesc}

**如何知道我的應用程式依賴 `docker` 而非 `containerd`？**<br>
您可能依賴 Docker 作為容器運行環境的情況範例：
*  如果您使用特許容器直接存取 Docker 引擎或 API，則請更新 Pod 以支援 `containerd` 作為運行環境。例如，您可以直接呼叫 Docker Socket，來啟動容器或執行其他 Docker 作業。Docker Socket 已從 `/var/run/docker.sock` 變更為 `/run/containerd/containerd.sock`。`containerd` Socket 中使用的通訊協定，與 Docker 中的通訊協定有些許不同。請嘗試將您的應用程式更新為 `containerd` Socket。如果您要繼續使用 Docker Socket，請使用 [Docker-inside-Docker (DinD) ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://hub.docker.com/_/docker/) 來查看。
*  您在叢集裡安裝的部分協力廠商附加程式（例如記載及監視工具）可能依賴 Docker 引擎。請洽詢提供者，以確定工具與 containerd 相容。可能的使用案例包括：
   - 您的記載工具可能使用容器 `stderr/stdout` 目錄 `/var/log/pods/<pod_uuid>/<container_name>/*.log`，來存取日誌。在 Docker 中，此目錄是 `/var/data/cripersistentstorage/containers/<container_uuid>/<container_uuid>-json.log` 的符號鏈結，而在 `containerd` 中，您會在沒有符號鏈結的情況下直接存取目錄。
   - 您的監視工具會直接存取 Docker Socket。Docker Socket 已從 `/var/run/docker.sock` 變更為 `/run/containerd/containerd.sock`。

<br>

**除了依賴運行環境之外，我是否還需要採取其他準備動作？**<br>

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

### 準備更新至 Calico 第 3 版
{: #111_calicov3}

如果您要將叢集從 Kubernetes 1.9 版或更早版本更新為 1.11 版，請先準備進行 Calico 第 3 版更新，再更新主節點。在主節點升級至 Kubernetes 1.11 版期間，不會排定新的 Pod 及新的 Kubernetes 或 Calico 網路原則。更新導致無法進行新排程的時間量會不同。小型叢集可能需要數分鐘的時間，而且每 10 個節點需要額外幾分鐘的時間。現有網路原則及 Pod 會繼續執行。
{: shortdesc}

如果您將叢集從 Kubernetes 1.10 版更新為 1.11 版，請跳過這些步驟，因為您在更新為 1.10 時已完成這些步驟。
{: note}

開始之前，您的叢集主節點及所有工作者節點都必須執行 Kubernetes 1.8 版或 1.9 版，且必須至少有一個工作者節點。

1.  驗證 Calico Pod 性能良好。
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  如果有任何 Pod 未處於 **Running** 狀況，則請刪除 Pod，並先等到它處於 **Running** 狀況，再繼續進行。如果 Pod 未回到**執行中**狀態，請執行下列動作：
    1.  檢查工作者節點的**狀況**及**狀態**。
        ```
      ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
        {: pre}
    2.  如果工作者節點狀況不是**正常**，請遵循[除錯工作者節點](cs_troubleshoot.html#debug_worker_nodes)步驟。例如，**嚴重**或**不明**狀況通常藉由[重新載入工作者節點](cs_cli_reference.html#cs_worker_reload)來解決。

3.  如果您自動產生 Calico 原則或其他 Calico 資源，則請更新自動化工具，以使用 [Calico 第 3 版語法 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) 來產生這些資源。

4.  如果您將 [strongSwan](cs_vpn.html#vpn-setup) 用於 VPN 連線功能，則 strongSwan 2.0.0 Helm 圖表不會使用 Calico 第 3 版或 Kubernetes 1.11。[更新 strongSwan](cs_vpn.html#vpn_upgrade) 至 2.1.0 Helm 圖表，其與 Calico 2.6 及 Kubernetes 1.7、1.8 及 1.9 舊版相容。

5.  [將叢集主節點更新至 Kubernetes 1.11 版](cs_cluster_update.html#master)。

<br />


## 1.10 版
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.10 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.10 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.10 版時，您可能需要進行的變更。
{: shortdesc}

您必須遵循[準備更新至 Calico 第 3 版](#110_calicov3)中所列的步驟，才能順利更新至 Kubernetes 1.10。
{: important}

<br/>

### 在主節點之前更新
{: #110_before}

下表顯示您在更新 Kubernetes 主節點之前必須採取的動作。
{: shortdesc}

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
<td>叢集主節點高可用性 (HA) 配置</td>
<td>已更新叢集主節點配置來增加高可用性 (HA)。叢集現在具有三個 Kubernetes 主節點抄本，而設定這些抄本時，每一個主節點會部署在個別的實體主機上。此外，如果您的叢集是在具有多區域功能的區域中，則主節點會分散在各區域之中。<br><br>如需您必須採取的動作，請參閱[更新為高可用性叢集主節點](#110_ha-masters)。這些準備動作適用下列情況：<ul>
<li>如果您具有防火牆或自訂 Calico 網路原則。</li>
<li>如果您是在工作者節點上使用主機埠 `2040` 或 `2041`。</li>
<li>如果您已使用叢集主節點 IP 位址，對主節點進行叢集內存取。</li>
<li>如果您具有呼叫 Calico API 或 CLI (`calictl`) 的自動化，例如，建立 Calico 原則。</li>
<li>如果您使用 Kubernetes 或 Calico 網路原則，來控制對主節點的 Pod Egress 存取。</li></ul></td>
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

下表顯示您在更新 Kubernetes 主節點之後必須採取的動作。
{: shortdesc}

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
<td>`kubectl --show-all, -a` 旗標</td>
<td>只適用於人類可讀取之 Pod 指令（不是 API 呼叫）的 `--show-all, -a` 旗標已被淘汰，且未來版本不再支援它。此旗標是用來顯示終端機狀況中的 Pod。若要追蹤已終止之應用程式及容器的相關資訊，請[在叢集裡設定日誌轉遞](cs_health.html#health)。</td>
</tr>
<tr>
<td>唯讀 API 資料磁區</td>
<td>現在，`secret`、`configMap`、`downwardAPI` 及預期的磁區是已裝載的唯讀磁區。
先前，容許應用程式可將資料寫入至這些磁區，而系統可能會自動回復這些磁區。修正安全漏洞 [CVE-2017-1002102![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) 需要這個變更。如果您的應用程式依賴先前不安全的行為，請相應地修改它們。</td>
</tr>
<tr>
<td>strongSwan VPN
</td>
<td>如果您使用 [strongSwan](cs_vpn.html#vpn-setup) 進行 VPN 連線，並在更新叢集之前已刪除圖表，則現在可以重新安裝 strongSwan Helm 圖表。</td>
</tr>
</tbody>
</table>

### 更新為 Kubernetes 1.10 中的高可用性叢集主節點
{: #110_ha-masters}

對於執行 Kubernetes 1.10.8_1530 版、[1.11.3_1531](#ha-masters) 版或更新版本的叢集，會更新叢集主節點配置以增加高可用性 (HA)。叢集現在具有三個 Kubernetes 主節點抄本，而設定這些抄本時，每一個主節點會部署在個別的實體主機上。此外，如果您的叢集是在具有多區域功能的區域中，則主節點會分散在各區域之中。
{: shortdesc}

將叢集從 1.9 版或更舊的 1.10 修補程式更新至這個 Kubernetes 版本時，您需要採取這些準備步驟。為了讓您有時間，會暫時停用主節點的自動更新。如需相關資訊和時間表，請參閱 [HA 主節點部落格文章](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/)。
{: tip}

檢閱下列狀況，而您必須在其中進行變更，才能充分運用 HA 主節點配置：
* 如果您具有防火牆或自訂 Calico 網路原則。
* 如果您是在工作者節點上使用主機埠 `2040` 或 `2041`。
* 如果您已使用叢集主節點 IP 位址，對主節點進行叢集內存取。
* 如果您具有呼叫 Calico API 或 CLI (`calictl`) 的自動化，例如，建立 Calico 原則。
* 如果您使用 Kubernetes 或 Calico 網路原則，來控制對主節點的 Pod Egress 存取。

<br>
**針對 HA 主節點更新防火牆或自訂的 Calico 主機網路原則**：</br>
{: #110_ha-firewall}
如果您使用防火牆或自訂的 Calico 主機網路原則，控制來自工作者節點的 Egress，則容許將資料流量送出至叢集所在地區內所有區域的埠及 IP 位址。請參閱[容許叢集存取基礎架構資源及其他服務](cs_firewall.html#firewall_outbound)。

<br>
**保留工作者節點上的主機埠 `2040` 及 `2041`**：</br>
{: #110_ha-ports}
若要容許存取 HA 配置中的叢集主節點，您必須在所有工作者節點上將主機埠 `2040` 和 `2041` 保留為可用狀態。
* 更新任何 Pod，將 `hostPort` 設為 `2040` 或 `2041` 來使用不同的埠。
* 更新任何在埠 `2040` 或 `2041` 上接聽的 Pod，將 `hostNetwork` 設為 `true` 來使用不同的埠。

若要檢查您的 Pod 目前是否使用埠 `2040` 或 `2041`，請將目標設為您的叢集並執行下列指令。

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

<br>
**使用 `kubernetes` 服務叢集 IP 或網域，對主節點進行叢集內存取**：</br>
{: #110_ha-incluster}
若要從叢集內的 HA 配置中存取叢集主節點，請使用下列其中一項：
* `kubernetes` 服務叢集 IP 位址，預設為：`https://172.21.0.1`
* `kubernetes` 服務網域名稱，預設為：`https://kubernetes.default.svc.cluster.local`

如果您先前已使用叢集主節點 IP 位址，則此方法會繼續運作。不過，為了提高可用性，請更新為使用 `kubernetes` 服務叢集 IP 位址或網域名稱。

<br>
**配置 Calico 對具有 HA 配置的主節點進行叢集外存取**：</br>
{: #110_ha-outofcluster}
`kin-system` 名稱空間中 `calic-config` ConfigMap 所儲存的資料已變更為支援 HA 主節點配置。尤其，`etcd_endpoints` 值現在僅支援叢集內存取。使用此值來配置 Calico CLI 以從叢集外部進行存取，不再運作。

請改用 `kudo-system` 名稱空間中 `cluster-info` ConfigMap 所儲存的資料。尤其，使用 `etcd_host` 和 `etcd_port` 值來配置 [Calico CLI](cs_network_policy.html#cli_install) 的端點，從叢集外部存取具有 HA 配置的主節點。

<br>
**更新 Kubernetes 或 Calico 網路原則**：</br>
{: #110_ha-networkpolicies}
如果您使用 [Kubernetes 或 Calico 網路原則](cs_network_policy.html#network_policies)，來控制對叢集主節點的 Pod Egress 存取，而且您目前正在使用下列項目，則需要採取其他動作：
*  Kubernetes 服務叢集 IP，您可以藉由執行 `kubectl get service kubernetes -o yaml | grep clusterIP` 來取得此 IP。
*  Kubernetes 服務網域名稱，預設為 `https://kubernetes.default.svc.cluster.local`。
*  叢集主節點 IP，您可以藉由執行 `kubectl cluster-info | grep Kubernetes` 來取得此 IP。

下列步驟說明如何更新您的 Kubernet 網路原則。若要更新 Calico 網路原則，請重複這些步驟，搭配一些次要原則語法變更及 `calicoctl` 來搜尋原則找出影響。
{: note}

開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

1.  取得您的叢集主節點 IP 位址。
    ```
    kubectl cluster-info | grep Kubernetes
    ```
    {: pre}

2.  搜尋 Kubernetes 網路原則找出影響。如果未傳回任何 YAML，表示您的叢集未受到影響，因此您不需要進行其他變更。
    ```
    kubectl get networkpolicies --all-namespaces -o yaml | grep <cluster-master-ip>
    ```
    {: pre}

3.  檢閱 YAML。例如，如果您的叢集使用下列 Kubernetes 網路原則，容許 `default` 名稱空間中的 Pod，透過 `kubernetes` 服務叢集 IP 或叢集主節點 IP 存取叢集主節點，則您必須更新原則。
    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name or cluster master IP address.
      -   ports:

        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service
      # domain name.
      -   ports:

        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

4.  修訂 Kubernetes 網路原則，以容許對叢集內主節點 Proxy IP 位址 `172.20.0.1` 進行 Egress。目前，請保留叢集主節點 IP 位址。例如，前一個網路原則範例會變更為下列內容。

    如果您先前已將 Egress 原則設為僅針對單一 Kubernetes 主節點開啟單一 IP 位址及埠，則現在會使用叢集內主節點 Proxy IP 位址範圍 172.20.0.1/32 和埠 2040。
    {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name.
      -   ports:

        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service domain name.
      -   ports:

        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

5.  將修訂的網路原則套用至您的叢集。
    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

6.  在您完成所有[準備動作](#ha-masters)（包括這些步驟）之後，請[將叢集主節點更新為](cs_cluster_update.html#master) HA 主節點修正套件。

7.  在更新完成之後，請從網路原則移除叢集主節點 IP 位址。例如，從前一個網路原則移除下列這幾行，然後重新套用原則。

    ```
    - ipBlock:
        cidr: 161.202.126.210/32
    ```
    {: screen}

    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

### 準備更新至 Calico 第 3 版
{: #110_calicov3}

開始之前，您的叢集主節點及所有工作者節點都必須執行 Kubernetes 1.8 版或更新版本，且必須至少有一個工作者節點。
{: shortdesc}

在更新主節點之前，請先準備進行 Calico 第 3 版更新。在主節點升級至 Kubernetes 1.10 版期間，不會排定新的 Pod 及新的 Kubernetes 或 Calico 網路原則。更新導致無法進行新排程的時間量會不同。小型叢集可能需要數分鐘的時間，而且每 10 個節點需要額外幾分鐘的時間。現有網路原則及 Pod 會繼續執行。
{: important}

1.  驗證 Calico Pod 性能良好。
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  如果有任何 Pod 未處於 **Running** 狀況，則請刪除 Pod，並先等到它處於 **Running** 狀況，再繼續進行。如果 Pod 未回到**執行中**狀態，請執行下列動作：
    1.  檢查工作者節點的**狀況**及**狀態**。
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}
    2.  如果工作者節點狀況不是**正常**，請遵循[除錯工作者節點](cs_troubleshoot.html#debug_worker_nodes)步驟。例如，**嚴重**或**不明**狀況通常藉由[重新載入工作者節點](cs_cli_reference.html#cs_worker_reload)來解決。

3.  如果您自動產生 Calico 原則或其他 Calico 資源，則請更新自動化工具，以使用 [Calico 第 3 版語法 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) 來產生這些資源。

4.  如果您將 [strongSwan](cs_vpn.html#vpn-setup) 用於 VPN 連線功能，則 strongSwan 2.0.0 Helm 圖表不會使用 Calico 第 3 版或 Kubernetes 1.10。[更新 strongSwan](cs_vpn.html#vpn_upgrade) 至 2.1.0 Helm 圖表，其與 Calico 2.6 及 Kubernetes 1.7、1.8 及 1.9 舊版相容。

5.  [將叢集主節點更新至 Kubernetes 1.10 版](cs_cluster_update.html#master)。

<br />


## 保存
{: #k8s_version_archive}

尋找 {{site.data.keyword.containerlong_notm}} 中不支援之 Kubernetes 版本的概觀。
{: shortdesc}

### 1.9 版（已淘汰，自 2018 年 12 月 27 日起不再支援）
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="此徽章指出 IBM Cloud Container Service 的 Kubernetes 1.9 版憑證。"/> {{site.data.keyword.containerlong_notm}} 是 CNCF Kubernetes Software Conformance Certification 計畫下 1.9 版的已認證 Kubernetes 產品。_Kubernetes® 是 The Linux Foundation 在美國及其他國家或地區的註冊商標，並且根據 The Linux Foundation 的授權予以使用。_</p>

請檢閱從舊版 Kubernetes 更新至 1.9 版時，您可能需要進行的變更。
{: shortdesc}

<br/>

### 在主節點之前更新
{: #19_before}

下表顯示您在更新 Kubernetes 主節點之前必須採取的動作。
{: shortdesc}

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

下表顯示您在更新 Kubernetes 主節點之後必須採取的動作。
{: shortdesc}

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
先前，容許應用程式可將資料寫入至這些磁區，而系統可能會自動回復這些磁區。修正安全漏洞 [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) 需要這個變更。
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

### 1.8 版（不受支援）
{: #cs_v18}

自 2018 年 9 月 22 日起，不支援執行 [Kubernetes 1.8 版](cs_versions_changelog.html#changelog_archive)的 {{site.data.keyword.containerlong_notm}} 叢集。1.8 版叢集無法接收安全更新或支援，除非它們更新為下一個最新版本 ([Kubernetes 1.9](#cs_v19))。
{: shortdesc}

針對每個 Kubernetes 版本更新[檢閱潛在影響](cs_versions.html#cs_versions)，然後立即[更新您的叢集](cs_cluster_update.html#update)為至少 1.9。

### 1.7 版（不受支援）
{: #cs_v17}

自 2018 年 6 月 21 日起，不支援執行 [Kubernetes 1.7 版](cs_versions_changelog.html#changelog_archive)的 {{site.data.keyword.containerlong_notm}} 叢集。1.7 版叢集無法接收安全更新或支援，除非它們更新為下一個最新支援的版本 ([Kubernetes 1.9](#cs_v19))。
{: shortdesc}

針對每個 Kubernetes 版本更新[檢閱潛在影響](cs_versions.html#cs_versions)，然後立即[更新您的叢集](cs_cluster_update.html#update)為至少 1.9。

### 1.5 版（不受支援）
{: #cs_v1-5}

自 2018 年 4 月 4 日起，不支援執行 [Kubernetes 1.5 版](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md)的 {{site.data.keyword.containerlong_notm}} 叢集。1.5 版叢集無法接收安全更新或支援。
{: shortdesc}

若要在 {{site.data.keyword.containerlong_notm}} 中繼續執行應用程式，請[建立新的叢集](cs_clusters.html#clusters)，並[部署應用程式](cs_app.html#app)至新的叢集。
