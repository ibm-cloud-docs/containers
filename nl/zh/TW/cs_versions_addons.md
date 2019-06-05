---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-16"

keywords: kubernetes, iks, nginx, ingress controller

subcollection: containers

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

更新 Ingress ALB 附加程式時，所有 ALB Pod 中的 `nginx-ingress` 和 `ingress-auth` 容器都會更新至最新的建置版本。依預設，會啟用自動更新附加程式，但您可以停用自動更新並手動更新附加程式。如需相關資訊，請參閱[更新 Ingress 應用程式負載平衡器](/docs/containers?topic=containers-update#alb)。

請參閱下列表格，以取得 Ingress ALB 附加程式之每一個建置的變更摘要。

<table summary="Ingress 應用程式負載平衡器附加程式的建置變更概觀">
<caption>Ingress 應用程式負載平衡器附加程式的變更日誌</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
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
<td>411 / 315</td>
<td>2019 年 4 月 15 日</td>
<td>更新 {{site.data.keyword.appid_full}} Cookie 有效期限的值，讓它符合存取記號有效期限的值。</td>
<td>-</td>
</tr>
<tr>
<td>411 / 306</td>
<td>2019 年 3 月 22 日</td>
<td>將 Go 版本更新為 1.12.1。</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>2019 年 3 月 18 日</td>
<td><ul>
<li>修正映像檔掃描的漏洞。</li>
<li>改善 {{site.data.keyword.appid_full_notm}} 的記載。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>2019 年 3 月 05 日</td>
<td>-</td>
<td>修正授權整合中與登出功能、記號有效期限，以及 `OAuth` 授權回呼相關的錯誤。只有當您使用 [`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth) 註釋來啟用 {{site.data.keyword.appid_full_notm}} 授權時，才會實作這些修正程式。若要實作這些修正程式，則會新增其他標頭，這會增加標頭大小總計。視您自己的標頭大小及回應大小總計而定，您可能需要調整所使用的任何 [Proxy 緩衝區註釋](/docs/containers?topic=containers-ingress_annotation#proxy-buffer)。</td>
</tr>
<tr>
<td>406 / 301</td>
<td>2019 年 2 月 19 日</td>
<td><ul>
<li>將 Go 版本更新為 1.11.5。</li>
<li>修正映像檔掃描的漏洞。</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404 / 300</td>
<td>2019 年 1 月 31 日</td>
<td>將 Go 版本更新為 1.11.4。</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>2019 年 1 月 23 日</td>
<td><ul>
<li>將 ALB 的 NGINX 版本更新為 1.15.2。</li>
<li>IBM 提供的 TLS 憑證現在會在到期前 37 天（而非 7 天）自動更新。</li>
<li>新增 {{site.data.keyword.appid_full_notm}} 登出功能：如果 {{site.data.keyword.appid_full_notm}} 路徑中有 `/logout` 字首，則會移除 Cookie，且會將使用者傳送回登入頁面。</li>
<li>將標頭新增至 {{site.data.keyword.appid_full_notm}} 要求，以進行內部追蹤。</li>
<li>更新 {{site.data.keyword.appid_short_notm}} 位置指引，以便 `app-id` 註釋可以與 `proxy-buffers`、`proxy-buffer-size` 及 `proxy-busy-buffer-size` 註釋一起使用。</li>
<li>修正錯誤，讓參考資訊日誌不會被標示為錯誤。</li>
</ul></td>
<td>依預設，停用 TLS 1.0 及 1.1。如果連接至應用程式的用戶端支援 TLS 1.2，則不需要執行任何動作。如果您仍然有需要 TLS 1.0 或 1.1 支援的舊版用戶端，請遵循[下列步驟](/docs/containers?topic=containers-ingress#ssl_protocols_ciphers)，手動啟用所需的 TLS 版本。如需如何查看您用戶端使用哪個 TLS 版本來存取您應用程式的相關資訊，請參閱此 [{{site.data.keyword.Bluemix_notm}} 部落格文章](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/)。</td>
</tr>
<tr>
<td>393 / 291</td>
<td>2019 年 1 月 09 日</td>
<td>新增多個 {{site.data.keyword.appid_full_notm}} 實例的支援。</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>2018 年 11 月 29 日</td>
<td>改善 {{site.data.keyword.appid_full_notm}} 的效能。</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>2018 年 11 月 14 日</td>
<td>改善 {{site.data.keyword.appid_full_notm}} 的記載和登出特性。</td>
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
