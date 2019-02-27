---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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
{:download: .download}


# 叢集附加程式變更日誌

您的 {{site.data.keyword.containerlong}} 叢集隨附 IBM 自動更新的附加程式。您也可以停用部分附加程式的自動更新，並從主節點及工作者節點分別進行手動更新。請參閱下列各節中的表格，以取得每一個版本的變更摘要。
{: shortdesc}

## Ingress ALB 附加程式變更日誌
{: #alb_changelog}

檢視 {{site.data.keyword.containerlong_notm}} 叢集裡 Ingress 應用程式負載平衡器 (ALB) 附加程式的建置版本變更。
{:shortdesc}

更新 Ingress ALB 附加程式時，所有 ALB Pod 中的 `nginx-ingress` 和 `ingress-auth` 容器都會更新至最新的建置版本。依預設，會啟用自動更新附加程式，但您可以停用自動更新並手動更新附加程式。如需相關資訊，請參閱[更新 Ingress 應用程式負載平衡器](cs_cluster_update.html#alb)。

請參閱下列表格，以取得 Ingress ALB 附加程式之每一個建置的變更摘要。

<table summary="Ingress 應用程式負載平衡器附加程式的建置變更概觀">
<caption>Ingress 應用程式負載平衡器附加程式的變更日誌</caption>
<thead>
<tr>
<th>`nginx-ingress` / `ingress-auth` 建置</th>
<th>發行日期</th>
<th>連續的變更</th>
<th>非連續的變更</th>
</tr>
</thead>
<tbody>
<tr>
<td>393 / 282</td>
<td>2018 年 11 月 29 日</td>
<td>改善 {{site.data.keyword.appid_full}} 的效能。</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018 年 11 月 14 日</td>
<td>改善 {{site.data.keyword.appid_full}} 的記載和登出特性。</td>
<td>將 `*.containers.mybluemix.net` 的自簽憑證取代為自動產生並供叢集使用的 LetsEncrypt 簽署憑證。`*.containers.mybluemix.net` 自簽憑證會被移除。</td>
</tr>
<tr>
<td>350 / 192</td>
<td>2018 年 11 月 5 日</td>
<td>新增啟用及停用 Ingress ALB 附加程式之自動更新的支援。</td>
<td>-</td>
</tr>
</tbody>
</table>
