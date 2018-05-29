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

# 版本變更日誌
{: #changelog}

檢視可供 {{site.data.keyword.containerlong}} Kubernetes 叢集使用之主要、次要及修補程式更新的版本變更資訊。變更包含 Kubernetes 及 {{site.data.keyword.Bluemix_notm}} Provider 元件的更新。
{:shortdesc}

IBM 會自動將修補程式層次的更新套用至您的主節點，但您必須[更新您的工作者節點](cs_cluster_update.html#worker_node)。每月檢查以取得可用的更新。當更新變成可用時，會在您檢視工作者節點的相關資訊時，利用如下指令通知您：`bx cs workers <cluster>` 或 `bx cs worker-get <cluster> <worker>`。

如需移轉動作的摘要，請參閱[Kubernetes 版本](cs_versions.html)。
{: tip}

如需自舊版以來的變更相關資訊，請參閱下列變更日誌。
-  1.8 版[變更日誌](#18_changelog).
-  1.7 版[變更日誌](#17_changelog).


## 1.8 版變更日誌
{: #18_changelog}

檢閱下列變更。

### 1.8.11_1509 的變更日誌
{: #1811_1509}

<table summary="自 1.8.8_1507 版以來的變更">
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
<td>請參閱 [Kubernetes 版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11)。</td>
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
<td>針對較舊叢集，修正[邊緣節點](cs_edge.html#edge)容錯設定。</td>
</tr>
</tbody>
</table>

## 1.7 版變更日誌
{: #17_changelog}

檢閱下列變更。

### 1.7.16_1511 的變更日誌
{: #1716_1511}

<table summary="自 1.7.4_1509 版以來的變更">
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
<td>請參閱 [Kubernetes 版本注意事項 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16)。</td>
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
<td>針對較舊叢集，修正[邊緣節點](cs_edge.html#edge)容錯設定。</td>
</tr>
</tbody>
</table>

