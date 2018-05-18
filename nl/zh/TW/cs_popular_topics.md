---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# {{site.data.keyword.containershort_notm}} 的熱門主題
{: #cs_popular_topics}

查看容器開發人員有興趣瞭解 {{site.data.keyword.containerlong}} 的哪些方面。
{:shortdesc}

## 2018 年 3 月的熱門主題
{: #mar18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 2 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td> 3 月 16 日</td>
<td>[使用授信運算佈建裸機叢集](cs_clusters.html#shared_dedicated_node)</td>
<td>建立執行 [Kubernetes 1.9 版](cs_versions.html#cs_v19)或更新版本的裸機叢集，並啟用「授信運算」來驗證工作者節點是否遭到竄改。</td>
</tr>
<tr>
<td>3 月 14 日</td>
<td>[安全登入 {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>要求使用者登入，以加強在 {{site.data.keyword.containershort_notm}} 中執行的應用程式。</td>
</tr>
<tr>
<td>3 月 13 日</td>
<td>[聖保羅現在為可用位置](cs_regions.html)</td>
<td>巴西聖保羅已成為美國南部地區的新位置。如果您有防火牆，請務必針對此位置以及您叢集所在地區內的其他位置[開啟必要的防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>3 月 12 日</td>
<td>[要使用「試用」帳戶加入 {{site.data.keyword.Bluemix_notm}} 嗎？歡迎試用免費的 Kubernetes 叢集！](container_index.html#clusters)</td>
<td>使用「試用」[{{site.data.keyword.Bluemix_notm}} 帳戶](https://console.bluemix.net/registration/)，您可以部署 1 個免費叢集，用來在 21 天內測試 Kubernetes 功能。</td>
</tr>
</tbody></table>

## 2018 年 2 月的熱門主題
{: #feb18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 2 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td>2 月 27 日</td>
<td>工作者節點的硬體虛擬機器 (HVM) 映像檔</td>
<td>增加 HVM 映像檔工作負載的 I/O 效能。使用 `bx cs worker-reload` [指令](cs_cli_reference.html#cs_worker_reload)或 `bx cs worker-update` [指令](cs_cli_reference.html#cs_worker_update)，在每一個現有的工作者節點上啟動。</td>
</tr>
<tr>
<td>2 月 26 日</td>
<td>[KubeDNS 自動擴充](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS 現在會隨著叢集成長而擴充。您可以使用下列指令來調整擴充量：`kubectl -n kube-system edit cm kube-dns-autoscaler`。</td>
</tr>
<tr>
<td>2 月 23 日</td>
<td>檢視 Web 使用者介面中的[記載](cs_health.html#view_logs)及[度量值](cs_health.html#view_metrics)</td>
<td>使用改良的 Web 使用者介面，輕鬆檢視叢集及其元件的日誌及度量值資料。請參閱叢集詳細資料頁面來進行存取。</td>
</tr>
<tr>
<td>2 月 20 日</td>
<td>已加密的映像檔及[已簽署的信任內容](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>在 {{site.data.keyword.registryshort_notm}} 中，您可以簽署及加密映像檔，以確保在登錄名稱空間中儲存的映像檔的完整性。只使用信任的內容來建置容器。</td>
</tr>
<tr>
<td>2 月 19 日</td>
<td>[設定 strongSwan IPSec VPN](cs_vpn.html#vpn-setup)</td>
<td>快速部署 strongSwan IPSec VPN Helm 圖表，以將 {{site.data.keyword.containershort_notm}} 叢集安全地連接到內部部署的資料中心，而不使用 Vyatta。</td>
</tr>
<tr>
<td>2 月 14 日</td>
<td>[首爾現在為可用位置](cs_regions.html)</td>
<td>剛好來得及趕上奧林匹克運動會，將 Kubernetes 叢集部署至位於亞太地區北部的首爾。如果您有防火牆，務必針對此位置以及您叢集所在地區內的其他位置[開啟必要的防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>2 月 8 日</td>
<td>[更新 Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>更新 Kubernetes 1.9 之前，請先檢閱對叢集所做的變更。</td>
</tr>
</tbody></table>

## 2018 年 1 月的熱門主題
{: #jan18}

<table summary="此表格顯示熱門主題。列應該從左到右閱讀，第一欄為日期，第二欄為特性的標題，第三欄為說明。">
<caption>2018 年 1 月關於容器及 Kubernetes 叢集的熱門主題</caption>
<thead>
<th>日期</th>
<th>標題</th>
<th>說明</th>
</thead>
<tbody>
<td>1 月 25 日</td>
<td>[現已推出廣域登錄](../services/Registry/registry_overview.html#registry_regions)</td>
<td>透過 {{site.data.keyword.registryshort_notm}}，您可以使用廣域 `registry.bluemix.net` 來取回 IBM 提供的公用映像檔。</td>
</tr>
<tr>
<td>1 月 23 日</td>
<td>[新加坡及加拿大蒙特婁現在為可用位置](cs_regions.html)</td>
<td>新加坡及蒙特婁是位於 {{site.data.keyword.containershort_notm}} 亞太地區北部及美國東部地區的可用位置。如果您有防火牆，務必針對這些位置以及您叢集所在地區內的其他位置[開啟必要的防火牆埠](cs_firewall.html#firewall)。</td>
</tr>
<tr>
<td>1 月 8 日</td>
<td>[現已推出加強機型](cs_cli_reference.html#cs_machine_types)</td>
<td>系列 2 機型包括本端 SSD 儲存空間及磁碟加密。[將工作負載移轉](cs_cluster_update.html#machine_type)至這些機型，以提高效能及穩定性。</td>
</tr>
</tbody></table>

## 與 Slack 上志同道合的開發人員會談
{: #slack}

您可以看到別人談論的內容，也可以在 [{{site.data.keyword.containershort_notm}} Slack ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://ibm-container-service.slack.com) 中提出自己的問題。
{:shortdesc}

提示：如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶未使用 IBM ID，請[要求邀請](https://bxcs-slack-invite.mybluemix.net/)以加入此 Slack。
