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

# 記載及監視 Ingress
{: #ingress_health}

自訂記載以及設定監視，以協助對問題進行疑難排解，以及改善 Ingress 配置的效能。
{: shortdesc}

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
