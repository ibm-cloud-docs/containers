---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# 版本變更日誌
{: #changelog}

檢視可供 {{site.data.keyword.containerlong}} Kubernetes 叢集使用之主要、次要及修補程式更新的版本變更資訊。變更包含 Kubernetes 及 {{site.data.keyword.Bluemix_notm}} Provider 元件的更新。
{:shortdesc}

IBM 會自動將修補程式層次的更新套用至您的主節點，但您必須[更新您的工作者節點](cs_cluster_update.html#worker_node)修補程式。對於主節點及工作者節點兩者，您必須套用[主要及次要](cs_versions.html#update_types)更新。每月檢查以取得可用的更新。有可用的更新時，會在您檢視 GUI 或 CLI 中主節點及工作者節點的相關資訊時，使用如下指令通知您：`ibmcloud ks clusters`、`cluster-get`、`workers` 或 `worker-get`。

如需移轉動作的摘要，請參閱[Kubernetes 版本](cs_versions.html)。
{: tip}

如需自舊版以來的變更相關資訊，請參閱下列變更日誌。
-  1.10 版[變更日誌](#110_changelog)。
-  1.9 版[變更日誌](#19_changelog)。
-  1.8 版[變更日誌](#18_changelog)。
-  已淘汰或不受支援版本之變更日誌的[保存檔](#changelog_archive)。

## 1.10 版變更日誌
{: #110_changelog}

檢閱下列變更。

### 1.10.5_1517（2018 年 7 月 27 日發行）的變更日誌
{: #1105_1517}

<table summary="自 1.10.3_1514 版以來進行的變更">
<caption>自 1.10.3_1514 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>3.1.1 版</td>
<td>3.1.3 版</td>
<td>請參閱 Calico [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.projectcalico.org/v3.1/releases/#v313)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.10.3-85 版</td>
<td>1.10.5-118 版</td>
<td>已更新為支援 Kubernetes 1.10.5 版。此外，LoadBalancer 服務 `create failure` 事件現在包括所有可攜式子網路錯誤。</td>
</tr>
<tr>
<td>IBM 檔案儲存空間外掛程式</td>
<td>320</td>
<td>334</td>
<td>已將持續性磁區建立的逾時從 15 分鐘增加至 30 分鐘。已將預設計費類型變更為 `hourly`。已將裝載選項新增至預先定義的儲存空間類別。在 IBM Cloud 基礎架構 (SoftLayer) 帳戶的 NFS 檔案儲存空間實例中，已將 **Notes** 欄位變更為 JSON 格式，並已新增 PV 部署至其中的 Kubernetes 名間空間。為了支援多區域叢集，已將區域及地區標籤新增至持續性磁區。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>1.10.3 版</td>
<td>1.10.5 版</td>
<td>請參閱 Kubernetes [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5)。</td>
</tr>
<tr>
<td>核心</td>
<td>N/A</td>
<td>N/A</td>
<td>對高效能網路工作負載的工作者節點網路設定做出少量改善。</td>
</tr>
<tr>
<td>OpenVPN 用戶端</td>
<td>N/A</td>
<td>N/A</td>
<td>在 `kube-system` 名稱空間中執行的 OpenVPN 用戶端 `vpn` 部署，現在是由 Kubernetes `addon-manager` 管理。</td>
</tr>
</tbody>
</table>

### 工作者節點修正套件 1.10.3_1514（2018 年 7 月 3 日發行）的變更日誌
{: #1103_1514}

<table summary="自 1.10.3_1513 版以來進行的變更">
<caption>自 1.10.3_1513 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>核心</td>
<td>N/A</td>
<td>N/A</td>
<td>已最佳化高效能網路工作負載的 `sysctl`。</td>
</tr>
</tbody>
</table>


### 工作者節點修正套件 1.10.3_1513（2018 年 6 月 21 日發行）的變更日誌
{: #1103_1513}

<table summary="自 1.10.3_1512 版以來進行的變更">
<caption>自 1.10.3_1512 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>對於非加密的機型，當重新載入或更新工作者節點時，會取得全新的檔案系統來清理次要磁碟。</td>
</tr>
</tbody>
</table>

### 1.10.3_1512（2018 年 6 月 12 日發行）的變更日誌
{: #1103_1512}

<table summary="自 1.10.3_1510 版以來進行的變更">
<caption>自 1.10.1_1510 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>1.10.1 版</td>
<td>1.10.3 版</td>
<td>請參閱 Kubernetes [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>N/A</td>
<td>N/A</td>
<td>已針對叢集的 Kubernetes API 伺服器將 `PodSecurityPolicy` 新增至 `--enable-admission-plugins` 選項，並已將叢集配置為支援 Pod 安全政策。如需相關資訊，請參閱[配置 Pod 安全原則](cs_psp.html)。</td>
</tr>
<tr>
<td>Kubelet 配置</td>
<td>N/A</td>
<td>N/A</td>
<td>啟用 `--authentication-token-webhook` 選項，支援 API 載送及服務帳戶記號，以對 `kubelet` HTTPS 端點進行鑑別。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.10.1-52 版</td>
<td>1.10.3-85 版</td>
<td>已更新為支援 Kubernetes 1.10.3 版。</td>
</tr>
<tr>
<td>OpenVPN 用戶端</td>
<td>N/A</td>
<td>N/A</td>
<td>已將 `livenessProbe` 新增至 `kube-system` 名稱空間中執行的 OpenVPN 用戶端 `vpn` 部署。</td>
</tr>
<tr>
<td>核心更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新的工作者節點映像檔與 [CVE-2018-3639 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的核心更新。</td>
</tr>
</tbody>
</table>



### 工作者節點修正套件 1.10.1_1510（2018 年 5 月 18 日發行）的變更日誌
{: #1101_1510}

<table summary="自 1.10.1_1509 版以來進行的變更">
<caption>自 1.10.1_1509 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>修正以處理您使用區塊儲存空間外掛程式時發生的錯誤。</td>
</tr>
</tbody>
</table>

### 工作者節點修正套件 1.10.1_1509（2018 年 5 月 16 日發行）的變更日誌
{: #1101_1509}

<table summary="自 1.10.1_1508 版以來進行的變更">
<caption>自 1.10.1_1508 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>您在 `kubelet` 根目錄中儲存的資料，現在儲存在工作者節點機器的較大次要磁碟上。</td>
</tr>
</tbody>
</table>

### 1.10.1_1508（2018 年 5 月 1 日發行）的變更日誌
{: #1101_1508}

<table summary="自 1.9.7_1510 版以來進行的變更">
<caption>自 1.9.7_1510 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>2.6.5 版</td>
<td>3.1.1 版</td>
<td>請參閱 Calico [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://docs.projectcalico.org/v3.1/releases/#v311)。</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>1.5.0 版</td>
<td>1.5.2 版</td>
<td>請參閱 Kubernetes Heapster [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2)。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>1.9.7 版</td>
<td>1.10.1 版</td>
<td>請參閱 Kubernetes [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>N/A</td>
<td>N/A</td>
<td>針對叢集的 Kubernetes API 伺服器，已將 <code>StorageObjectInUseProtection</code> 新增至 <code>--enable-admission-plugins</code> 選項。</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>請參閱 Kubernetes DNS [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/dns/releases/tag/1.14.10)。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.9.7-102 版</td>
<td>1.10.1-52 版</td>
<td>已更新成支援 Kubernetes 1.10 版。</td>
</tr>
<tr>
<td>GPU 支援</td>
<td>N/A</td>
<td>N/A</td>
<td>[圖形處理裝置 (GPU) 容器工作負載](cs_app.html#gpu_app)支援現在可用於排程及執行。如需可用的 GPU 機型清單，請參閱[工作者節點的硬體](cs_clusters.html#shared_dedicated_node)。如需相關資訊，請參閱 Kubernetes 文件來[排程 GPU ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/)。</td>
</tr>
</tbody>
</table>

## 1.9 版變更日誌
{: #19_changelog}

檢閱下列變更。

### 1.9.9_1520（2018 年 7 月 27 日發行）的變更日誌
{: #199_1520}

<table summary="自 1.9.8_1517 版以來進行的變更">
<caption>自 1.9.8_1517 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.9.8-141 版</td>
<td>1.9.9-167 版</td>
<td>已更新為支援 Kubernetes 1.9.9 版。此外，LoadBalancer 服務 `create failure` 事件現在包括所有可攜式子網路錯誤。</td>
</tr>
<tr>
<td>IBM 檔案儲存空間外掛程式</td>
<td>320</td>
<td>334</td>
<td>已將持續性磁區建立的逾時從 15 分鐘增加至 30 分鐘。已將預設計費類型變更為 `hourly`。已將裝載選項新增至預先定義的儲存空間類別。在 IBM Cloud 基礎架構 (SoftLayer) 帳戶的 NFS 檔案儲存空間實例中，已將 **Notes** 欄位變更為 JSON 格式，並已新增 PV 部署至其中的 Kubernetes 名間空間。為了支援多區域叢集，已將區域及地區標籤新增至持續性磁區。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>1.9.8 版</td>
<td>1.9.9 版</td>
<td>請參閱 Kubernetes [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9)。</td>
</tr>
<tr>
<td>核心</td>
<td>N/A</td>
<td>N/A</td>
<td>對高效能網路工作負載的工作者節點網路設定做出少量改善。</td>
</tr>
<tr>
<td>OpenVPN 用戶端</td>
<td>N/A</td>
<td>N/A</td>
<td>在 `kube-system` 名稱空間中執行的 OpenVPN 用戶端 `vpn` 部署，現在是由 Kubernetes `addon-manager` 管理。</td>
</tr>
</tbody>
</table>

### 工作者節點修正套件 1.9.8_1517（2018 年 7 月 3 日發行）的變更日誌
{: #198_1517}

<table summary="自 1.9.8_1516 版以來進行的變更">
<caption>自 1.9.8_1516 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>核心</td>
<td>N/A</td>
<td>N/A</td>
<td>已最佳化高效能網路工作負載的 `sysctl`。</td>
</tr>
</tbody>
</table>


### 工作者節點修正套件 1.9.8_1516（2018 年 6 月 21 日發行）的變更日誌
{: #198_1516}

<table summary="自 1.9.8_1515 版以來進行的變更">
<caption>自 1.9.8_1515 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>對於非加密的機型，當重新載入或更新工作者節點時，會取得全新的檔案系統來清理次要磁碟。</td>
</tr>
</tbody>
</table>

### 1.9.8_1515（2018 年 6 月 19 日發行）的變更日誌
{: #198_1515}

<table summary="自 1.9.7_1513 版以來進行的變更">
<caption>自 1.9.7_1513 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>1.9.7 版</td>
<td>1.9.8 版</td>
<td>請參閱 [Kubernetes 版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>N/A</td>
<td>N/A</td>
<td>已針對叢集的 Kubernetes API 伺服器將 PodSecurityPolicy 新增至 --admission-control 選項，並已將叢集配置為支援 Pod 安全政策。如需相關資訊，請參閱[配置 Pod 安全原則](cs_psp.html)。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>1.9.7-102 版</td>
<td>1.9.8-141 版</td>
<td>已更新為支援 Kubernetes 1.9.8 版。</td>
</tr>
<tr>
<td>OpenVPN 用戶端</td>
<td>N/A</td>
<td>N/A</td>
<td>已將 <code>livenessProbe</code> 新增至 <code>kube-system</code> 名稱空間中執行的 OpenVPN 用戶端 <code>vpn</code> 部署。</td>
</tr>
</tbody>
</table>


### 工作者節點修正套件 1.9.7_1513（2018 年 6 月 11 日發行）的變更日誌
{: #197_1513}

<table summary="自 1.9.7_1512 版以來進行的變更">
<caption>自 1.9.7_1512 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>核心更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新的工作者節點映像檔與 [CVE-2018-3639 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的核心更新。</td>
</tr>
</tbody>
</table>

### 工作者節點修正套件 1.9.7_1512（2018 年 5 月 18 日發行）的變更日誌
{: #197_1512}

<table summary="自 1.9.7_1511 版以來進行的變更">
<caption>自 1.9.7_1511 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>修正以處理您使用區塊儲存空間外掛程式時發生的錯誤。</td>
</tr>
</tbody>
</table>

### 工作者節點修正套件 1.9.7_1511（2018 年 5 月 16 日發行）的變更日誌
{: #197_1511}

<table summary="自 1.9.7_1510 版以來進行的變更">
<caption>自 1.9.7_1510 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>您在 `kubelet` 根目錄中儲存的資料，現在儲存在工作者節點機器的較大次要磁碟上。</td>
</tr>
</tbody>
</table>

### 1.9.7_1510（2018 年 4 月 30 日發行）的變更日誌
{: #197_1510}

<table summary="自 1.9.3_1506 版以來進行的變更">
<caption>自 1.9.3_1506 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>1.9.3 版</td>
<td>1.9.7 版</td>
<td><p>請參閱 [Kubernetes 版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7)。此版本處理 [CVE-2017-1002101 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 及 [CVE-2017-1002102 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>附註</strong>：現在，`secret`、`configMap`、`downwardAPI` 及預期的磁區已裝載為唯讀磁區。先前，應用程式可將資料寫入至系統可能自動回復的這些磁區。如果您的應用程式依賴先前不安全的行為，請相應地修改它們。</p></td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>N/A</td>
<td>N/A</td>
<td>針對叢集的 Kubernetes API 伺服器，已將 `admissionregistration.k8s.io/v1alpha1=true` 新增至 `--runtime-config` 選項。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.9.3-71 版</td>
<td>1.9.7-102 版</td>
<td>`NodePort` 及 `LoadBalancer` 服務現在支援[保留用戶端來源 IP](cs_loadbalancer.html#node_affinity_tolerations)，方法為將 `service.spec.externalTrafficPolicy` 設為 `Local`。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>針對較舊叢集，修正[邊緣節點](cs_edge.html#edge)容忍設定。</td>
</tr>
</tbody>
</table>

## 1.8 版變更日誌
{: #18_changelog}

檢閱下列變更。

### 1.8.15_1518（2018 年 7 月 27 日發行）的變更日誌
{: #1815_1518}

<table summary="自 1.8.13_1516 版以來進行的變更">
<caption>自 1.8.13_1516 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.8.13-176 版</td>
<td>1.8.15-204 版</td>
<td>已更新為支援 Kubernetes 1.8.15 版。此外，LoadBalancer 服務 `create failure` 事件現在包括所有可攜式子網路錯誤。</td>
</tr>
<tr>
<td>IBM 檔案儲存空間外掛程式</td>
<td>320</td>
<td>334</td>
<td>已將持續性磁區建立的逾時從 15 分鐘增加至 30 分鐘。已將預設計費類型變更為 `hourly`。已將裝載選項新增至預先定義的儲存空間類別。在 IBM Cloud 基礎架構 (SoftLayer) 帳戶的 NFS 檔案儲存空間實例中，已將 **Notes** 欄位變更為 JSON 格式，並已新增 PV 部署至其中的 Kubernetes 名間空間。為了支援多區域叢集，已將區域及地區標籤新增至持續性磁區。</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>1.8.13 版</td>
<td>1.8.15 版</td>
<td>請參閱 Kubernetes [版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15)。</td>
</tr>
<tr>
<td>核心</td>
<td>N/A</td>
<td>N/A</td>
<td>對高效能網路工作負載的工作者節點網路設定做出少量改善。</td>
</tr>
<tr>
<td>OpenVPN 用戶端</td>
<td>N/A</td>
<td>N/A</td>
<td>在 `kube-system` 名稱空間中執行的 OpenVPN 用戶端 `vpn` 部署，現在是由 Kubernetes `addon-manager` 管理。</td>
</tr>
</tbody>
</table>

### 工作者節點修正套件 1.8.13_1516（2018 年 7 月 3 日發行）的變更日誌
{: #1813_1516}

<table summary="自 1.8.13_1515 版以來進行的變更">
<caption>自 1.8.13_1515 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>核心</td>
<td>N/A</td>
<td>N/A</td>
<td>已最佳化高效能網路工作負載的 `sysctl`。</td>
</tr>
</tbody>
</table>


### 工作者節點修正套件 1.8.13_1515（2018 年 6 月 21 日發行）的變更日誌
{: #1813_1515}

<table summary="自 1.8.13_1514 版以來進行的變更">
<caption>自 1.8.13_1514 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>對於非加密的機型，當重新載入或更新工作者節點時，會取得全新的檔案系統來清理次要磁碟。</td>
</tr>
</tbody>
</table>

### 1.8.13_1514（2018 年 6 月 19 日發行）的變更日誌
{: #1813_1514}

<table summary="自 1.8.11_1512 版以來進行的變更">
<caption>自 1.8.11_1512 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>1.8.11	版</td>
<td>1.8.13 版</td>
<td>請參閱 [Kubernetes 版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13)。</td>
</tr>
<tr>
<td>Kubernetes 配置</td>
<td>N/A</td>
<td>N/A</td>
<td>已針對叢集的 Kubernetes API 伺服器將 PodSecurityPolicy 新增至 --admission-control 選項，並已將叢集配置為支援 Pod 安全政策。如需相關資訊，請參閱[配置 Pod 安全原則](cs_psp.html)。</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>1.8.11-126 版</td>
<td>1.8.13-176 版</td>
<td>已更新為支援 Kubernetes 1.8.13 版。</td>
</tr>
<tr>
<td>OpenVPN 用戶端</td>
<td>N/A</td>
<td>N/A</td>
<td>已將 <code>livenessProbe</code> 新增至 <code>kube-system</code> 名稱空間中執行的 OpenVPN 用戶端 <code>vpn</code> 部署。</td>
</tr>
</tbody>
</table>


### 工作者節點修正套件 1.8.11_1512（2018 年 6 月 11 日發行）的變更日誌
{: #1811_1512}

<table summary="自 1.8.11_1511 版以來進行的變更">
<caption>自 1.8.11_1511 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>核心更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新的工作者節點映像檔與 [CVE-2018-3639 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的核心更新。</td>
</tr>
</tbody>
</table>


### 工作者節點修正套件 1.8.11_1511（2018 年 5 月 18 日發行）的變更日誌
{: #1811_1511}

<table summary="自 1.8.11_1510 版以來進行的變更">
<caption>自 1.8.11_1510 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>修正以處理您使用區塊儲存空間外掛程式時發生的錯誤。</td>
</tr>
</tbody>
</table>

### 工作者節點修正套件 1.8.11_1510（2018 年 5 月 16 日發行）的變更日誌
{: #1811_1510}

<table summary="自 1.8.11_1509 版以來進行的變更">
<caption>自 1.8.11_1509 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>您在 `kubelet` 根目錄中儲存的資料，現在儲存在工作者節點機器的較大次要磁碟上。</td>
</tr>
</tbody>
</table>


### 1.8.11_1509（2018 年 4 月 19 日發行）的變更日誌
{: #1811_1509}

<table summary="自 1.8.8_1507 版以來進行的變更">
<caption>自 1.8.8_1507 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>1.8.8 版</td>
<td>1.8.11	版</td>
<td><p>請參閱 [Kubernetes 版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11)。此版本處理 [CVE-2017-1002101 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 及 [CVE-2017-1002102 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>附註</strong>：現在，`secret`、`configMap`、`downwardAPI` 及預期的磁區已裝載為唯讀磁區。先前，應用程式可將資料寫入至系統可能自動回復的這些磁區。如果您的應用程式依賴先前不安全的行為，請相應地修改它們。</p></td>
</tr>
<tr>
<td>暫停容器映像檔</td>
<td>3.0</td>
<td>3.1</td>
<td>移除已繼承的孤立已休眠處理程序。</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.8.8-86 版</td>
<td>1.8.11-126 版</td>
<td>`NodePort` 及 `LoadBalancer` 服務現在支援[保留用戶端來源 IP](cs_loadbalancer.html#node_affinity_tolerations)，方法為將 `service.spec.externalTrafficPolicy` 設為 `Local`。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>針對較舊叢集，修正[邊緣節點](cs_edge.html#edge)容忍設定。</td>
</tr>
</tbody>
</table>

## 保存
{: #changelog_archive}

### 1.7 版變更日誌（不受支援）
{: #17_changelog}

檢閱下列變更。

#### 工作者節點修正套件 1.7.16_1514（2018 年 6 月 11 日發行）的變更日誌
{: #1716_1514}

<table summary="自 1.7.16_1513 版以來進行的變更">
<caption>自 1.7.16_1513 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>核心更新</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>新的工作者節點映像檔與 [CVE-2018-3639 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639) 的核心更新。</td>
</tr>
</tbody>
</table>

#### 工作者節點修正套件 1.7.16_1513（2018 年 5 月 18 日發行）的變更日誌
{: #1716_1513}

<table summary="自 1.7.16_1512 版以來進行的變更">
<caption>自 1.7.16_1512 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>修正以處理您使用區塊儲存空間外掛程式時發生的錯誤。</td>
</tr>
</tbody>
</table>

#### 工作者節點修正套件 1.7.16_1512（2018 年 5 月 16 日發行）的變更日誌
{: #1716_1512}

<table summary="自 1.7.16_1511 版以來進行的變更">
<caption>自 1.7.16_1511 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>您在 `kubelet` 根目錄中儲存的資料，現在儲存在工作者節點機器的較大次要磁碟上。</td>
</tr>
</tbody>
</table>

#### 1.7.16_1511（2018 年 4 月 19 日發行）的變更日誌
{: #1716_1511}

<table summary="自 1.7.4_1509 版以來進行的變更">
<caption>自 1.7.4_1509 版以來的變更</caption>
<thead>
<tr>
<th>元件</th>
<th>舊版</th>
<th>現行版本</th>
<th>說明</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>1.7.4 版</td>
<td>1.7.16 版	</td>
<td><p>請參閱 [Kubernetes 版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16)。此版本處理 [CVE-2017-1002101 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) 及 [CVE-2017-1002102 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102) 漏洞。</p><p><strong>附註</strong>：現在，`secret`、`configMap`、`downwardAPI` 及預期的磁區已裝載為唯讀磁區。先前，應用程式可將資料寫入至系統可能自動回復的這些磁區。如果您的應用程式依賴先前不安全的行為，請相應地修改它們。</p></td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>1.7.4-133 版</td>
<td>1.7.16-17 版</td>
<td>`NodePort` 及 `LoadBalancer` 服務現在支援[保留用戶端來源 IP](cs_loadbalancer.html#node_affinity_tolerations)，方法為將 `service.spec.externalTrafficPolicy` 設為 `Local`。</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>針對較舊叢集，修正[邊緣節點](cs_edge.html#edge)容忍設定。</td>
</tr>
</tbody>
</table>
