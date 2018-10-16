---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# 記載及監視 Ingress
{: #ingress_health}

自訂記載以及設定監視，以協助對問題進行疑難排解，以及改善 Ingress 配置的效能。
{: shortdesc}

## 檢視 Ingress 日誌
{: #ingress_logs}

系統會自動收集 Ingress ALB 的日誌。若要檢視 ALB 日誌，有兩個選項可供您選擇。
* 在叢集裡[建立 Ingress 服務的記載配置](cs_health.html#configuring)。
* 從 CLI 檢查日誌。
    1. 取得 ALB Pod 的 ID。
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. 開啟該 ALB Pod 的日誌。驗證日誌遵循已更新格式。
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>預設 Ingress 日誌內容會以 JSON 格式化，並顯示一般欄位來說明用戶端與應用程式之間的連線階段作業。具有預設欄位的範例日誌如下所示：

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>瞭解預設 Ingress 日誌格式的欄位</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/>瞭解預設 Ingress 日誌格式的欄位</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>寫入日誌時使用 ISO 8601 標準格式的當地時間。</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>用戶端傳至您應用程式的要求套件的 IP 位址。此 IP 可能因下列狀況而變更：<ul><li>將應用程式的用戶端要求傳送至叢集時，會將該要求遞送至可公開 ALB 之負載平衡器服務的 Pod。如果沒有應用程式 Pod 存在於與負載平衡器服務 Pod 相同的工作者節點上，則負載平衡器會將要求轉遞至不同工作者節點上的應用程式 Pod。要求套件的來源 IP 位址會變更為應用程式 Pod 執行所在之工作者節點的公用 IP 位址。</li><li>如果[已啟用來源 IP 保留](cs_ingress.html#preserve_source_ip)，則會改為記錄您應用程式之用戶端要求的原始 IP 位址。</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>可透過其存取您的應用程式的主機或子網域。此主機是配置在 ALB 的 Ingress 資源檔中。</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>要求的類型：<code>HTTP</code> 或 <code>HTTPS</code>。</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td>對後端應用程式的要求呼叫方法，例如 <code>GET</code> 或 <code>POST</code>。</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>應用程式路徑的原始要求 URI。ALB 會以字首來處理應用程式接聽的路徑。當 ALB 接收用戶端對應用程式的要求時，ALB 會檢查 Ingress 資源中的路徑（作為字首）是否有符合此要求 URI 中的路徑。</td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>從 16 個隨機位元組產生的唯一要求 ID。</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>連線階段作業的狀態碼。<ul>
<li><code>200</code>：階段作業順利完成</li>
<li><code>400</code>：無法剖析用戶端資料</li>
<li><code>403</code>：禁止存取；例如，當特定用戶端 IP 位址的存取受到限制時</li>
<li><code>500</code>：內部伺服器錯誤</li>
<li><code>502</code>：不當的閘道；例如，如果無法選取或呼叫到上游伺服器</li>
<li><code>503</code>：服務無法使用；例如，存取受到連線數目的限制</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>上游伺服器之 UNIX 網域 Socket 的 IP 位址及埠或路徑。如果在要求處理期間聯絡了數個伺服器，其位址會以逗點區隔：<code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>。如果該要求在內部就從一個伺服器群組重新導向至另一個伺服器群組，則不同群組中的伺服器位址會以冒號區隔：<code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>。如果 ALB 無法選取伺服器，則會改為記載伺服器群組的名稱。</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>從上游伺服器取得對後端應用程式的回應狀態碼，例如標準 HTTP 回應碼。數個回應的狀態碼以逗點和冒號區隔，例如 <code>$upstream_addr</code> 變數中的位址。如果 ALB 無法選取伺服器，則會記載 502（不當的閘道）狀態碼。</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>要求處理時間（以秒為測量單位），並以毫秒解析。此時間會在 ALB 讀取用戶端要求的第一個位元組時開始，並在 ALB 將回應的最後位元組傳送給用戶端時停止。在要求處理時間停止之後，會立即寫入日誌。</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>ALB 從上游伺服器接收對後端應用程式的回應所花費的時間（以秒為測量單位），並以毫秒解析。數個回應的時間以逗點和冒號區隔，例如 <code>$upstream_addr</code> 變數中的位址。</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>ALB 為了後端應用程式而與上游伺服器建立連線所花費的時間（以秒為測量單位），並以毫秒解析。如果 Ingress 資源配置中已啟用 TLS/SSL，則此時間包括花費在信號交換的時間。數個連線的時間以逗點和冒號區隔，例如 <code>$upstream_addr</code> 變數中的位址。</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>ALB 從上游伺服器接收對後端應用程式的回應標頭所花費的時間（以秒為測量單位），並以毫秒解析。數個連線的時間以逗點和冒號區隔，例如 <code>$upstream_addr</code> 變數中的位址。</td>
</tr>
</tbody></table>

## 自訂 Ingress 日誌內容及格式
{: #ingress_log_format}

您可以自訂針對 Ingress ALB 所收集日誌的內容及格式。
{:shortdesc}

依預設，Ingress 日誌會格式化為 JSON，並顯示一般的日誌欄位。不過，您也可以建立自訂日誌格式。若要選擇要轉遞的日誌元件及元件在日誌輸出中的排列方式，請執行下列動作：

1. 建立並開啟 `ibm-cloud-provider-ingress-cm` configmap 資源的配置檔的本端版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 新增 <code>data</code> 區段。新增 `log-format` 欄位，並選擇性地新增 `log-format-escape-json` 欄位。

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    <table>
    <caption>YAML 檔案元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 log-format 配置</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>將 <code>&lt;key&gt;</code> 取代為日誌元件的名稱，並將 <code>&lt;log_variable&gt;</code> 取代為您要在日誌項目中收集的日誌元件的變數。您可以包含想要日誌項目包含的文字和標點符號，例如括住字串值用的引號以及分隔日誌元件用的逗點。例如，格式化 <code>request: "$request"</code> 這類元件會在日誌項目中產生下列內容：<code>request: "GET / HTTP/1.1"</code>。如需您可以使用的所有變數清單，請參閱 <a href="http://nginx.org/en/docs/varindex.html">Nginx 變數索引</a>。<br><br>若要記載額外的標頭，例如 <em>x-custom-ID</em>，請將下列鍵值組新增至自訂日誌內容：<br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>連字號 (<code>-</code>) 會轉換為底線 (<code>_</code>)，且必須將 <code>$http_</code> 附加到自訂標頭名稱前面。</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>選用項目：依預設，會以文字格式產生日誌。如果要產生 JSON 格式的日誌，請新增 <code>log-format-escape-json</code> 欄位，並使用值 <code>true</code>。</td>
    </tr>
    </tbody></table>

    例如，您的日誌格式可能包含下列變數：
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    根據此格式的日誌項目類似下列範例：
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    若要建立以 ALB 日誌之預設格式為基礎的自訂日誌格式，請視需要修改下列區段，並將它新增至您的 configmap：
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. 儲存配置檔。

5. 驗證已套用 configmap 變更。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. 若要檢視 Ingress ALB 日誌，請選擇兩個選項。
    * 在叢集裡[建立 Ingress 服務的記載配置](cs_health.html#logging)。
    * 從 CLI 檢查日誌。
        1. 取得 ALB Pod 的 ID。
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. 開啟該 ALB Pod 的日誌。驗證日誌遵循已更新格式。
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## 增加 Ingress 度量值集合的共用記憶體區域大小
{: #vts_zone_size}

已定義共用記憶體區域，讓工作者處理程序可以共用快取、階段作業持續性及速率限制這類資訊。已設定共用記憶體區域（稱為虛擬主機資料流量狀態區域），讓 Ingress 可以收集 ALB 的度量值資料。
{:shortdesc}

在 `ibm-cloud-provider-ingress-cm` Ingress configmap 中，`vts-status-zone-size` 欄位會設定度量值資料集合的共用記憶體區域大小。依預設，`vts-status-zone-size` 設為 `10m`。如果您的大型環境需要更多記憶體來收集度量值，則可以遵循下列步驟來置換預設值，而非使用較大的值。

1. 建立並開啟 `ibm-cloud-provider-ingress-cm` configmap 資源的配置檔的本端版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 將 `vts-status-zone-size` 的值從 `10m` 變更為較大的值。

   ```
   apiVersion: v1
   data:
     vts-status-zone-size: "10m"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. 儲存配置檔。

4. 驗證已套用 configmap 變更。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
