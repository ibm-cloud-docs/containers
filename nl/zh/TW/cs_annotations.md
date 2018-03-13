---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Ingress 註釋
{: #ingress_annotation}

若要將功能新增至應用程式負載平衡器，您可以將註釋指定為 Ingress 資源中的 meta 資料。
{: shortdesc}

如需 Ingress 服務及如何開始使用它們的一般資訊，請參閱[使用 Ingress 來配置應用程式的公用存取](cs_ingress.html#config)。

<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>一般註釋</th>
 <th>名稱</th>
 <th>說明</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-external-service">外部服務</a></td>
 <td><code>proxy-external-service</code></td>
 <td>將路徑定義新增至外部服務，例如 {{site.data.keyword.Bluemix_notm}} 中管理的服務。</td>
 </tr>
 <tr>
 <td><a href="#alb-id">專用應用程式負載平衡器遞送</a></td>
 <td><code>ALB-ID</code></td>
 <td>使用專用應用程式負載平衡器，將送入的要求遞送至應用程式。</td>
 </tr>
 <tr>
 <td><a href="#rewrite-path">重寫路徑</a></td>
 <td><code>rewrite-path</code></td>
 <td>將送入的網路資料流量遞送至後端應用程式接聽的不同路徑。</td>
 </tr>
 <tr>
 <td><a href="#sticky-cookie-services">Cookie 的階段作業親緣性</a></td>
 <td><code>sticky-cookie-services</code></td>
 <td>使用 Sticky Cookie 一律將送入的網路資料流量遞送至相同的上游伺服器。</td>
 </tr>
 <tr>
 <td><a href="#tcp-ports">TCP 埠</a></td>
 <td><code>tcp-ports</code></td>
 <td>透過非標準 TCP 埠存取應用程式。</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>連線註釋</th>
 <th>名稱</th>
 <th>說明</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#proxy-connect-timeout">自訂連接逾時和讀取逾時</a></td>
  <td><code>proxy-connect-timeout</code></td>
  <td>調整應用程式負載平衡器等待以連接及讀取後端應用程式的時間，在此時間之後，後端應用程式將被視為無法使用。</td>
  </tr>
  <tr>
  <td><a href="#keepalive-requests">保留作用中要求</a></td>
  <td><code>keepalive-requests</code></td>
  <td>配置可以透過一個保留作用中連線提供的要求數目上限。</td>
  </tr>
  <tr>
  <td><a href="#keepalive-timeout">保留作用中逾時</a></td>
  <td><code>keepalive-timeout</code></td>
  <td>配置保留作用中連線在伺服器上保持開啟的時間。</td>
  </tr>
  <tr>
  <td><a href="#upstream-keepalive">上游保留作用中</a></td>
  <td><code>upstream-keepalive</code></td>
  <td>配置上游伺服器之閒置保留作用中連線的數目上限。</td>
  </tr>
  </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>Proxy 緩衝區註釋</th>
 <th>名稱</th>
 <th>說明</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-buffering">用戶端回應資料緩衝</a></td>
 <td><code>proxy-buffering</code></td>
 <td>將回應傳送至用戶端時，停用應用程式負載平衡器上的用戶端回應緩衝。</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffers">Proxy 緩衝區</a></td>
 <td><code>proxy-buffers</code></td>
 <td>針對來自 Proxy 伺服器的單一連線，設定讀取回應的緩衝區大小及數目。</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffer-size">Proxy 緩衝區大小</a></td>
 <td><code>proxy-buffer-size</code></td>
 <td>設定緩衝區大小，以讀取從 Proxy 伺服器收到之回應的第一部分。</td>
 </tr>
 <tr>
 <td><a href="#proxy-busy-buffers-size">Proxy 工作中緩衝區大小</a></td>
 <td><code>proxy-busy-buffers-size</code></td>
 <td>設定可以在忙碌中的 Proxy 緩衝區大小。</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>要求及回應註釋</th>
<th>名稱</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td><a href="#proxy-add-headers">額外的用戶端要求或回應標頭</a></td>
<td><code>proxy-add-headers</code></td>
<td>將標頭資訊新增至用戶端要求，然後再將要求轉遞至後端應用程式，或新增至用戶端回應，然後再將回應傳送至用戶端。</td>
</tr>
<tr>
<td><a href="#response-remove-headers">移除用戶端回應標頭</a></td>
<td><code>response-remove-headers</code></td>
<td>從用戶端回應移除標頭資訊，然後才將回應轉遞至用戶端。</td>
</tr>
<tr>
<td><a href="#client-max-body-size">自訂用戶端要求內文大小上限</a></td>
<td><code>client-max-body-size</code></td>
<td>調整容許傳送至應用程式負載平衡器的用戶端要求內文的大小。</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>服務限制註釋</th>
<th>名稱</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td><a href="#global-rate-limit">廣域速率限制</a></td>
<td><code>global-rate-limit</code></td>
<td>針對所有服務的已定義金鑰，限制要求處理速率及連線數。</td>
</tr>
<tr>
<td><a href="#service-rate-limit">服務速率限制</a></td>
<td><code>service-rate-limit</code></td>
<td>針對特定服務的已定義金鑰，限制要求處理速率及連線數。</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>HTTPS 及 TLS/SSL 鑑別註釋</th>
<th>名稱</th>
<th>說明</th>
</thead>
<tbody>
<tr>
<td><a href="#custom-port">自訂 HTTP 及 HTTPS 埠</a></td>
<td><code>custom-port</code></td>
<td>變更 HTTP 及 HTTPS 網路資料流量的預設埠，HTTP 為埠 80，HTTPS 為埠 443。
</td>
</tr>
<tr>
<td><a href="#redirect-to-https">HTTP 重新導向至 HTTPS</a></td>
<td><code>redirect-to-https</code></td>
<td>將您網域上不安全的 HTTP 要求重新導向 HTTPS。</td>
</tr>
<tr>
<td><a href="#mutual-auth">交互鑑別</a></td>
<td><code>mutual-auth</code></td>
<td>配置應用程式負載平衡器的交互鑑別。</td>
</tr>
<tr>
<td><a href="#ssl-services">SSL 服務支援</a></td>
<td><code>ssl-services</code></td>
<td>容許負載平衡的 SSL 服務支援。</td>
</tr>
</tbody></table>



## 一般註釋
{: #general}

### 外部服務 (proxy-external-service)
{: #proxy-external-service}

將路徑定義新增至外部服務，例如 {{site.data.keyword.Bluemix_notm}} 中管理的服務。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>將路徑定義新增至外部服務。只有在您的應用程式在外部服務上作業，而非在後端服務上作業時才使用此註釋。當您使用此註釋建立外部服務路徑時，只會一起支援 `client-max-body-size`、`proxy-read-timeout`、`proxy-connect-timeout` 及 `proxy-buffering` 註釋。任何其他註釋都不支援與 `proxy-external-service` 一起使用。
</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>
apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
  name: cafe-ingress
  annotations:
    ingress.bluemix.net/proxy-external-service: "path=&lt;mypath&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 80
</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
 </thead>
 <tbody>
 <tr>
 <td><code>path</code></td>
 <td>將 <code>&lt;<em>mypath</em>&gt;</code> 取代為外部服務接聽的路徑。</td>
 </tr>
 <tr>
 <td><code>external-svc</code></td>
 <td>將 <code>&lt;<em>external_service</em>&gt;</code> 取代為要呼叫的外部服務。例如 <code>https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net</code>。</td>
 </tr>
 <tr>
 <td><code>host</code></td>
 <td>將 <code>&lt;<em>mydomain</em>&gt;</code> 取代為外部服務的主機網域。</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### 專用應用程式負載平衡器遞送 (ALB-ID)
{: #alb-id}

使用專用應用程式負載平衡器，將送入的要求遞送至應用程式。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
選擇專用應用程式負載平衡器來遞送送入的要求，而非公用應用程式負載平衡器。</dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
name: myingress
annotations:
  ingress.bluemix.net/ALB-ID: "&lt;private_ALB_ID&gt;"
 spec:
tls:
- hosts:
  - mydomain
  secretName: mytlssecret
rules:
- host: mydomain
  http:
    paths:
    - path: /
      backend:
        serviceName: myservice
        servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code>&lt;private_ALB_ID&gt;</code></td>
<td>專用應用程式負載平衡器的 ID。執行 <code>bx cs albs --cluster <my_cluster></code> 以尋找專用應用程式負載平衡器 ID。
</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />



### 重寫路徑 (rewrite-path)
{: #rewrite-path}

將應用程式負載平衡器網域路徑上的送入網路資料流量，遞送至與後端應用程式所接聽路徑不同的路徑。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 應用程式負載平衡器網域會將 <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> 上的送入網路資料流量遞送至您的應用程式。您的應用程式會接聽 <code>/coffee</code>，而非 <code>/beans</code>。若要將送入的網路資料流量轉遞至您的應用程式，請將重寫註釋新增至您的 Ingress 資源配置檔。重寫註釋確保 <code>/beans</code> 上的送入網路資料流量會使用 <code>/coffee</code> 路徑轉遞至您的應用程式。包含多個服務時，只使用分號 (;) 來區隔它們。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;myservice1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;myservice2&gt; rewrite=&lt;target_path2&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /beans
        backend:
          serviceName: myservice1
          servicePort: 80
</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。</td>
</tr>
<tr>
<td><code>rewrite</code></td>
<td>將 <code>&lt;<em>target_path</em>&gt;</code> 取代為應用程式所接聽的路徑。應用程式負載平衡器網域上的送入網路資料流量即會使用此路徑轉遞至 Kubernetes 服務。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在上述範例中，重寫路徑定義為 <code>/coffee</code>。</td>
</tr>
</tbody></table>

</dd></dl>

<br />


### 使用 Cookie 的階段作業親緣性 (sticky-cookie-services)
{: #sticky-cookie-services}

使用 Sticky Cookie 註釋，可為您的應用程式負載平衡器增加階段作業親緣性，並一律將送入的網路資料流量遞送至相同的上游伺服器。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>針當用戶端連接至您的後端應用程式時，您可以使用階段作業親緣性，以在階段作業時間，或是在完成作業所需的時間內，由相同的上游伺服器服務某一用戶端。您可以配置應用程式負載平衡器，一律將送入的網路資料流量遞送至相同的上游伺服器，以確保階段作業親緣性。



</br></br>
連接至您的後端應用程式的每個用戶端，會由應用程式負載平衡器指派給其中一個可用的上游伺服器。應用程式負載平衡器會建立階段作業 Cookie，它儲存在用戶端應用程式中，而用戶端應用程式則內含在應用程式負載平衡器與用戶端之間每個要求的標頭資訊中。Cookie 中的資訊確保所有要求在整個階段作業中，都由相同的上游伺服器處理。



</br></br>
當您包含多個服務時，請使用分號 (;) 來區隔它們。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;myservice1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;myservice2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>瞭解 YAML 檔案元件</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。</td>
  </tr>
  <tr>
  <td><code>name</code></td>
  <td>將 <code>&lt;<em>cookie_name</em>&gt;</code> 取代為在階段作業期間建立的 Sticky Cookie 名稱。</td>
  </tr>
  <tr>
  <td><code>expires</code></td>
  <td>將 <code>&lt;<em>expiration_time</em>&gt;</code> 取代為 Sticky Cookie 到期之前的時間，以秒 (s)、分鐘 (m) 或小時 (h) 為單位。此時間與使用者活動無關。Cookie 到期之後，用戶端 Web 瀏覽器會刪除 Cookie，而且不再傳送到應用程式負載平衡器。例如，若要設定 1 秒、1 分鐘或 1 小時的有效期限，請輸入 <code>1s</code>、<code>1m</code> 或 <code>1h</code>。</td>
  </tr>
  <tr>
  <td><code>path</code></td>
  <td>將 <code>&lt;<em>cookie_path</em>&gt;</code> 取代為附加至 Ingress 子網域的路徑，且該路徑指出針對哪些網域和子網域傳送 Cookie 到應用程式負載平衡器。例如，如果您的 Ingress 網域是 <code>www.myingress.com</code> 且想要在每個用戶端要求中傳送 Cookie，您必須設定 <code>path=/</code>。如果您只想針對 <code>www.myingress.com/myapp</code> 及其所有子網域傳送 Cookie，則必須設定 <code>path=/myapp</code>。</td>
  </tr>
  <tr>
  <td><code>hash</code></td>
  <td>將 <code>&lt;<em>hash_algorithm</em>&gt;</code> 取代為保護 Cookie 中資訊的雜湊演算法。僅支援 <code>sha1</code>。SHA1 會根據 Cookie 中的資訊建立雜湊總和，並將此雜湊總和附加到 Cookie。伺服器可以解密 Cookie 中的資訊，然後驗證資料完整性。</td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />



### 應用程式負載平衡器的 TCP 埠 (tcp-ports)
{: #tcp-ports}

透過非標準 TCP 埠存取應用程式。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
對正在執行 TCP 串流工作負載的應用程式使用此註釋。



<p>**附註**：應用程式負載平衡器係以透通模式運作，並將資料流量傳遞至後端應用程式。在此情況下，不支援 SSL 終止。</p>
</dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
name: myingress
annotations:
  ingress.bluemix.net/tcp-ports: "serviceName=&lt;myservice&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為要透過非標準 TCP 埠存取之 Kubernetes 服務的名稱。</td>
  </tr>
  <tr>
  <td><code>ingressPort</code></td>
  <td>將 <code>&lt;<em>ingress_port</em>&gt;</code> 取代為您要在其上存取應用程式的 TCP 埠。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>這是選用參數。若已提供，埠會替換為此值，然後再將資料流量傳送至後端應用程式。否則，埠會保持與 Ingress 埠相同。</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## 連線註釋
{: #connection}

### 自訂連接逾時及讀取逾時（proxy-connect-timeout、proxy-read-timeout）
{: #proxy-connect-timeout}

設定應用程式負載平衡器的自訂連接逾時及讀取逾時。調整應用程式負載平衡器等待以連接及讀取後端應用程式的時間，在此時間之後，後端應用程式將被視為無法使用。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>當用戶端要求傳送至 Ingress 應用程式負載平衡器時，應用程式負載平衡器會開啟與後端應用程式的連線。依預設，應用程式負載平衡器會等待 60 秒，以便從後端應用程式收到回覆。如果後端應用程式未在 60 秒內回覆，則會中斷連線要求，且後端應用程式將被視為無法使用。



</br></br>
在應用程式負載平衡器連接至後端應用程式之後，應用程式負載平衡器會讀取來自後端應用程式的回應資料。在此讀取作業期間，應用程式負載平衡器在兩次讀取作業之間最多等待 60 秒，以接收來自後端應用程式的資料。如果後端應用程式未在 60 秒內傳送資料，則會關閉與後端應用程式的連線，且應用程式將被視為無法使用。
</br></br>
60 秒的連接逾時及讀取逾時是 Proxy 上的預設逾時，通常不應該加以變更。
</br></br>
如果應用程式的可用性不穩定，或是您的應用程式因為高工作負載而回應太慢，您或許會想增加連接逾時或讀取逾時。請記住，增加逾時會影響應用程式負載平衡器的效能，因為與後端應用程式的連線必須維持開啟，直到達到逾時為止。
</br></br>
另一方面，您可以減少逾時以提高應用程式負載平衡器的效能。請確保您的後端應用程式能夠在指定的逾時內處理要求，即使是在較高工作負載的時段。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
   name: myingress
   annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;connect_timeout&gt;</code></td>
 <td>要等待連接後端應用程式的秒數，例如 <code>65s</code>。<strong>附註：</strong>連接逾時不可超過 75 秒。</td>
 </tr>
 <tr>
 <td><code>&lt;read_timeout&gt;</code></td>
 <td>要在讀取後端應用程式之前等待的秒數，例如 <code>65s</code>。<strong>附註：</strong>read-timeout 不可超過 120 秒。</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### 保留作用中要求 (keepalive-requests)
{: #keepalive-requests}

配置可以透過一個保留作用中連線提供的要求數目上限。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
 設定可以透過一個保留作用中連線提供的要求數目上限。
 </dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
name: myingress
annotations:
  ingress.bluemix.net/keepalive-requests: "serviceName=&lt;myservice&gt; requests=&lt;max_requests&gt;"
 spec:
tls:
- hosts:
  - mydomain
  secretName: mytlssecret
rules:
- host: mydomain
  http:
    paths:
    - path: /
      backend:
        serviceName: &lt;myservice&gt;
        servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。這是選用參數。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。如果提供參數，則會針對給定的服務設定保留作用中要求。如果未提供參數，則會針對未配置保留作用中要求的所有服務，在 <code>nginx.conf</code> 的伺服器層次設定保留作用中要求。</td>
</tr>
<tr>
<td><code>requests</code></td>
<td>將 <code>&lt;<em>max_requests</em>&gt;</code> 取代為可以透過一個保留作用中連線提供的要求數目上限。</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### 保留作用中逾時（keepalive-timeout）
{: #keepalive-timeout}

配置保留作用中連線在伺服器端保持開啟的時間。
  {:shortdesc}

<dl>
<dt>說明</dt>
<dd>
設定保留作用中連線在伺服器上保持開啟的時間。
</dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
   name: myingress
   annotations:
   ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;myservice&gt; timeout=&lt;time&gt;s"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。這是選用參數。如果提供參數，則會針對給定的服務設定保留作用中逾時。如果未提供參數，則會針對未配置保留作用中逾時的所有服務，在 <code>nginx.conf</code> 的伺服器層次設定保留作用中逾時。</td>
 </tr>
 <tr>
 <td><code>timeout</code></td>
 <td>將 <code>&lt;<em>time</em>&gt;</code> 取代為時間量（以秒為單位）。範例：<code>timeout=20s</code>。零值會停用保留作用中用戶端連線。</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### 上游保留作用中 (upstream-keepalive)
{: #upstream-keepalive}

配置上游伺服器之閒置保留作用中連線的數目上限。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
變更給定服務的上游伺服器之閒置保留作用中連線的數目上限。依預設，上游伺服器具有 64 個閒置保留作用中連線。
</dd>


 <dt>Ingress 資源範例 YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;myservice&gt; keepalive=&lt;max_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。</td>
  </tr>
  <tr>
  <td><code>keepalive</code></td>
  <td>將 <code>&lt;<em>max_connections</em>&gt;</code> 取代為上游伺服器之閒置保留作用中連線的數目上限。預設值為 <code>64</code>。<code>0</code> 值會停用給定服務的上游保留作用中連線。</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Proxy 緩衝區註釋
{: #proxy-buffer}


### 用戶端回應資料緩衝 (proxy-buffering)
{: #proxy-buffering}

使用緩衝區註釋，可以在資料傳送至用戶端時，停用在應用程式負載平衡器上儲存回應資料的功能。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 應用程式負載平衡器會充當後端應用程式與用戶端 Web 瀏覽器之間的 Proxy。當回應從後端應用程式傳送至用戶端時，依預設會將回應資料緩衝在應用程式負載平衡器上。應用程式負載平衡器會代理用戶端回應，並開始按照用戶端的速度將回應傳送至用戶端。應用程式負載平衡器收到來自後端應用程式的所有資料之後，會關閉與後端應用程式的連線。從應用程式負載平衡器到用戶端的連線會維持開啟，直到用戶端收到所有資料為止。



</br></br>
如果停用在應用程式負載平衡器上緩衝回應資料的功能，資料會立即從應用程式負載平衡器傳送至用戶端。用戶端必須能夠按照應用程式負載平衡器的速度處理送入的資料。如果用戶端太慢，資料可能會遺失。
</br></br>
依預設，會啟用應用程式負載平衡器上的回應資料緩衝。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
   name: myingress
   annotations:
   ingress.bluemix.net/proxy-buffering: "False"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

<br />



### Proxy 緩衝區 (proxy-buffers)
{: #proxy-buffers}

配置應用程式負載平衡器的 Proxy 緩衝區數目及大小。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
針對來自 Proxy 伺服器的單一連線，設定讀取回應的緩衝區大小及數目。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。例如，如果指定 <code>serviceName=SERVICE number=2 size=1k</code> 之類的配置，則會將 1k 套用至服務。如果指定 <code>number=2 size=1k</code> 之類的配置，則會將 1k 套用至 Ingress 主機中的所有服務。
</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
 name: proxy-ingress
   annotations:
   ingress.bluemix.net/proxy-buffers: "serviceName=&lt;myservice&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為要套用 proxy-buffers 的服務名稱。</td>
 </tr>
 <tr>
 <td><code>number_of_buffers</code></td>
 <td>將 <code>&lt;<em>number_of_buffers</em>&gt;</code> 取代為數字，例如 <em>2</em>。</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>將 <code>&lt;<em>size</em>&gt;</code> 取代為每一個緩衝區的大小，並以千位元組（k 或 K）為單位，例如 <em>1K</em>。</td>
 </tr>
 </tbody>
 </table>
 </dd></dl>

<br />


### Proxy 緩衝區大小 (proxy-buffer-size)
{: #proxy-buffer-size}

配置從回應的第一部分讀取的 Proxy 緩衝區大小。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
設定緩衝區大小，以讀取從 Proxy 伺服器收到之回應的第一部分。此部分的回應通常包含小型回應標頭。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。例如，如果指定 <code>serviceName=SERVICE size=1k</code> 之類的配置，則會將 1k 套用至服務。如果指定 <code>size=1k</code> 之類的配置，則會將 1k 套用至 Ingress 主機中的所有服務。
 </dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
 name: proxy-ingress
   annotations:
   ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;myservice&gt; size=&lt;size&gt;"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
       backend:
         serviceName: myservice
         servicePort: 8080
</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為要套用 proxy-buffer-size 的服務名稱。</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>將 <code>&lt;<em>size</em>&gt;</code> 取代為每一個緩衝區的大小，並以千位元組（k 或 K）為單位，例如 <em>1K</em>。</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Proxy 工作中緩衝區大小 (proxy-busy-buffers-size)
{: #proxy-busy-buffers-size}

配置可以在忙碌中的 Proxy 緩衝區大小。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
限制在尚未完全讀取回應時，正在將回應傳送至用戶端的任何緩衝區大小。同時，其餘的緩衝區可讀取回應，並在必要時，將回應的一部分緩衝至暫存檔。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。例如，如果指定 <code>serviceName=SERVICE size=1k</code> 之類的配置，則會將 1k 套用至服務。如果指定 <code>size=1k</code> 之類的配置，則會將 1k 套用至 Ingress 主機中的所有服務。
 </dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
 name: proxy-ingress
   annotations:
   ingress.bluemix.net/proxy-busy-buffers-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
       backend:
         serviceName: myservice
         servicePort: 8080
         </code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為要套用 proxy-busy-buffers-size 的服務名稱。</td>
</tr>
<tr>
<td><code>size</code></td>
<td>將 <code>&lt;<em>size</em>&gt;</code> 取代為每一個緩衝區的大小，並以千位元組（k 或 K）為單位，例如 <em>1K</em>。</td>
</tr>
</tbody></table>

 </dd>
 </dl>

<br />



## 要求及回應註釋
{: #request-response}


### 其他用戶端要求或回應標頭 (proxy-add-headers)
{: #proxy-add-headers}

將額外的標頭資訊新增至用戶端要求，然後再將要求傳送至後端應用程式，或新增至用戶端回應，然後再將回應傳送至用戶端。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 應用程式負載平衡器會充當用戶端應用程式與後端應用程式之間的 Proxy。傳送至應用程式負載平衡器的用戶端要求會被處理（代理），然後放入新的要求，從應用程式負載平衡器傳送到您的後端應用程式。代理 (Proxy) 要求會移除一開始從用戶端傳送的 HTTP 標頭資訊，例如使用者名稱。如果您的後端應用程式需要此資訊，則可以使用 <strong>ingress.bluemix.net/proxy-add-headers</strong> 註釋，將標頭資訊新增至用戶端要求，之後才將要求從應用程式負載平衡器轉遞到您的後端應用程式。



</br></br>
當後端應用程式傳送回應給用戶端時，回應會由應用程式負載平衡器代理，並從回應移除 HTTP 標頭。用戶端 Web 應用程式可能需要此標頭資訊才能順利處理回應。您可以使用 <strong>ingress.bluemix.net/response-add-headers</strong> 註釋，將標頭資訊新增至用戶端回應，之後才將回應從應用程式負載平衡器轉遞到用戶端 Web 應用程式。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;myservice1&gt; {
      &lt;header1&gt; &lt;value1&gt;;
      &lt;header2&gt; &lt;value2&gt;;
      }
      serviceName=&lt;myservice2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;myservice1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;myservice2&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>service_name</code></td>
  <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。</td>
  </tr>
  <tr>
  <td><code>&lt;header&gt;</code></td>
  <td>要新增至用戶端要求或用戶端回應的標頭資訊索引鍵。</td>
  </tr>
  <tr>
  <td><code>&lt;value&gt;</code></td>
  <td>要新增至用戶端要求或用戶端回應的標頭資訊值。</td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />



### 移除用戶端回應標頭 (response-remove-headers)
{: #response-remove-headers}

移除來自後端應用程式之用戶端回應中內含的標頭資訊，再將回應傳送至用戶端。
{:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>Ingress 應用程式負載平衡器會充當後端應用程式與用戶端 Web 瀏覽器之間的 Proxy。從後端應用程式傳送到應用程式負載平衡器的用戶端回應會被處理（代理），然後放入新的回應，從應用程式負載平衡器傳送到用戶端 Web 瀏覽器。雖然代理回應會移除一開始從後端應用程式傳送的 HTTP 標頭資訊，但這個程序不一定會移除所有後端應用程式特有的標頭。從用戶端回應移除標頭資訊，然後再將回應從應用程式負載平衡器轉遞到用戶端 Web 瀏覽器。</dd>
 <dt>Ingress 資源範例 YAML</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
   name: myingress
   annotations:
     ingress.bluemix.net/response-remove-headers: |
       serviceName=&lt;myservice1&gt; {
       "&lt;header1&gt;";
       "&lt;header2&gt;";
       }
       serviceName=&lt;myservice2&gt; {
       "&lt;header3&gt;";
       }
 spec:
   tls:
   - hosts:
     - mydomain
     secretName: mytlssecret
   rules:
   - host: mydomain
     http:
       paths:
       - path: /
         backend:
           serviceName: &lt;myservice1&gt;
           servicePort: 8080
       - path: /myapp
         backend:
           serviceName: &lt;myservice2&gt;
           servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
   </thead>
   <tbody>
   <tr>
   <td><code>service_name</code></td>
   <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。</td>
   </tr>
   <tr>
   <td><code>&lt;header&gt;</code></td>
   <td>要從用戶端回應移除的標頭索引鍵。</td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


### 自訂用戶端要求內文大小上限 (client-max-body-size)
{: #client-max-body-size}

調整用戶端可以傳送作為要求一部分的內文大小上限。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>為了維護預期的效能，用戶端要求內文大小上限設為 1 MB。當內文大小超過限制的用戶端要求傳送至 Ingress 應用程式負載平衡器，而且用戶端不容許分割資料時，應用程式負載平衡器會傳回 413（要求的實體太大）的 HTTP 回應給用戶端。在要求內文的大小減少之前，用戶端與應用程式負載平衡器之間無法進行連線。當用戶端容許資料分割成多個片段時，資料會分成多個 1 MB 的套件，然後傳送至應用程式負載平衡器。



</br></br>
您可能會想要增加內文大小上限，因為您預期用戶端要求的內文大小會大於 1 MB。例如，您要讓用戶端能上傳大型檔案。增加要求內文大小上限可能會影響應用程式負載平衡器的效能，因為與用戶端的連線必須維持開啟，直到收到要求為止。
</br></br>
<strong>附註：</strong>部分用戶端 Web 瀏覽器無法適當地顯示 413 HTTP 回應訊息。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
   name: myingress
   annotations:
   ingress.bluemix.net/client-max-body-size: "size=&lt;size&gt;"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>用戶端回應內文的大小上限。例如，若要將它設為 200 MB，請定義 <code>200m</code>。<strong>附註：</strong>您可以將大小設為 0，以停用用戶端要求內文大小的檢查。</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



## 服務限制註釋
{: #service-limit}


### 廣域速率限制 (global-rate-limit)
{: #global-rate-limit}

針對所有服務的已定義金鑰，限制要求處理速率及連線數。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
針對所有服務，根據來自所選取後端的所有路徑之單一 IP 位址的已定義金鑰，限制要求處理速率及連線數目。
</dd>


 <dt>Ingress 資源範例 YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/global-rate-limit: "key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>key</code></td>
  <td>若要根據位置或服務來設定送入要求的廣域限制，請使用 `key=location`。若要根據標頭來設定送入要求的廣域限制，請使用 `X-USER-ID key==$http_x_user_id`。</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>將 <code>&lt;<em>rate</em>&gt;</code> 取代為處理速率。輸入值作為每秒速率 (r/s) 或每分鐘速率 (r/m)。範例：<code>50r/m</code>。</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>將 <code>&lt;<em>conn</em>&gt;</code> 取代為連線數目。</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

<br />



### 服務速率限制 (service-rate-limit)
{: #service-rate-limit}

針對特定服務，限制要求處理速率及連線數。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>針對特定服務，根據來自所選取後端的所有路徑之單一 IP 位址的已定義金鑰，限制要求處理速率及連線數目。</dd>


 <dt>Ingress 資源範例 YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
 kind: Ingress
 metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;myservice&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為您要建立處理速率的服務名稱。</li>
  </tr>
  <tr>
  <td><code>key</code></td>
  <td>若要根據位置或服務來設定送入要求的廣域限制，請使用 `key=location`。若要根據標頭來設定送入要求的廣域限制，請使用 `X-USER-ID key==$http_x_user_id`。</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>將 <code>&lt;<em>rate</em>&gt;</code> 取代為處理速率。若要定義每秒速率，請使用 r/s：<code>10r/s</code>。若要定義每分鐘速率，請使用 r/m：<code>50r/m</code>。</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>將 <code>&lt;<em>conn</em>&gt;</code> 取代為連線數目。</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />



## HTTPS 及 TLS/SSL 鑑別註釋
{: #https-auth}


### 自訂 HTTP 及 HTTPS 埠 (custom-port)
{: #custom-port}

變更 HTTP 及 HTTPS 網路資料流量的預設埠，HTTP 為埠 80，HTTPS 為埠 443。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>依預設，Ingress 應用程式負載平衡器配置為在埠 80 上接聽送入的 HTTP 網路資料流量，並在埠 443 上接聽送入的 HTTPS 網路資料流量。您可以變更預設埠來新增應用程式負載平衡器網域的安全，或是只啟用 HTTPS 埠。
</dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
   name: myingress
   annotations:
    ingress.bluemix.net/custom-port: "protocol=&lt;protocol1&gt; port=&lt;port1&gt;;protocol=&lt;protocol2&gt;port=&lt;port2&gt;"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
 <thead>
 <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;protocol&gt;</code></td>
 <td>輸入 <strong>http</strong> 或 <strong>https</strong> 來變更送入之 HTTP 或 HTTPS 網路資料流量的預設埠。</td>
 </tr>
 <tr>
 <td><code>&lt;port&gt;</code></td>
 <td>輸入要用於送入之 HTTP 或 HTTPS 網路資料流量的埠號。<p><strong>附註：</strong>當為 HTTP 或 HTTPS 指定自訂埠時，預設埠對於 HTTP 和 HTTPS 便不再有效。例如，若要將 HTTPS 的預設埠變更為 8443，但 HTTP 使用預設埠，您必須兩者都設定自訂埠：<code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>。</p></td>
 </tr>
 </tbody></table>

 </dd>
 <dt>用法</dt>
 <dd><ol><li>檢閱應用程式負載平衡器的開啟埠。
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 輸出會與下列內容類似：
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>開啟 Ingress 控制器配置對映。
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>將非預設的 HTTP 及 HTTPS 埠新增至配置對映。將 &lt;port&gt; 取代為您要開啟的 HTTP 或 HTTPS 埠。
<pre class="codeblock">
<code>apiVersion: v1
kind: ConfigMap
data:
  public-ports: &lt;port1&gt;;&lt;port2&gt;
 metadata:
  creationTimestamp: 2017-08-22T19:06:51Z
  name: ibm-cloud-provider-ingress-cm
  namespace: kube-system
  resourceVersion: "1320"
  selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
  uid: &lt;uid&gt;</code></pre></li>
 <li>驗證您的 Ingress 控制器已使用非預設埠重新配置。
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 輸出會與下列內容類似：
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>配置您的 Ingress，以在將送入的網路資料流量遞送至服務時使用非預設埠。請在此參照中使用範例 YAML。</li>
<li>更新 Ingress 控制器配置。
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>開啟偏好的 Web 瀏覽器以存取您的應用程式。範例：<code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>

<br />



### HTTP 重新導向至 HTTPS (redirect-to-https)
{: #redirect-to-https}

將不安全的 HTTP 用戶端要求轉換成 HTTPS。
 {:shortdesc}

<dl>
<dt>說明</dt>
<dd>請設定 Ingress 應用程式負載平衡器，以 IBM 提供的 TLS 憑證或您的自訂 TLS 憑證來保護網域。有些使用者可能會嘗試對應用程式負載平衡器網域使用不安全的 HTTP 要求（例如 <code>http://www.myingress.com</code>）來存取您的應用程式，而不是使用 <code>https</code>。您可以使用重新導向註釋，一律將不安全的 HTTP 用戶端要求重新導向至 HTTPS。如果您未使用此註釋，依預設，不安全的 HTTP 要求不會轉換成 HTTPS 要求，且可能會將未加密的機密資訊公開給大眾。



</br></br>
依預設，會停用將 HTTP 要求重新導向至 HTTPS。</dd>

<dt>Ingress 資源範例 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
   name: myingress
   annotations:
   ingress.bluemix.net/redirect-to-https: "True"
 spec:
   tls:
 - hosts:
   - mydomain
     secretName: mytlssecret
   rules:
 - host: mydomain
   http:
     paths:
     - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

<br />



### 交互鑑別 (mutual-auth)
{: #mutual-auth}

配置應用程式負載平衡器的交互鑑別。
 {:shortdesc}

<dl>
<dt>說明</dt>
<dd>
 配置 Ingress 應用程式負載平衡器的交互鑑別。用戶端會鑑別伺服器，而伺服器也會使用憑證來鑑別用戶端。交互鑑別也稱為憑證型鑑別或雙向鑑別。
 </dd>

<dt>必要條件</dt>
<dd>
<ul>
<li>[您必須具有包含必要憑證管理中心 (CA) 的有效 Secret](cs_app.html#secrets)。同時需要 <code>client.key</code> 和 <code>client.crt</code> 來進行交互鑑別。</li>
<li>若要在 443 以外的埠上啟用交互鑑別，請[配置負載平衡器以開啟有效的埠](cs_ingress.html#opening_ingress_ports)。</li>
</ul>
</dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
name: myingress
annotations:
  ingress.bluemix.net/mutual-auth: "secretName=&lt;mysecret&gt; port=&lt;port&gt; serviceName=&lt;servicename1&gt;,&lt;servicename2&gt;"
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080
          </code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code>secretName</code></td>
<td>將 <code>&lt;<em>mysecret</em>&gt;</code> 取代為 Secret 資源的名稱。</td>
</tr>
<tr>
<td><code>&lt;port&gt;</code></td>
<td>應用程式負載平衡器埠號。</td>
</tr>
<tr>
<td><code>&lt;serviceName&gt;</code></td>
<td>一個以上 Ingress 資源的名稱。這是選用參數。</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### SSL 服務支援 (ssl-services)
{: #ssl-services}

容許 HTTPS 要求並加密要送至上游應用程式的資料流量。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
使用應用程式負載平衡器加密要送至需要 HTTPS 之上游應用程式的資料流量。



**選用**：您可以將[單向鑑別或交互鑑別](#ssl-services-auth)新增至此註釋。
</dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: "ssl-service=&lt;myservice1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;myservice2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
 spec:
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice1
          servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為代表您應用程式的服務名稱。系統會加密從應用程式負載平衡器到此應用程式的資料流量。</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>將 <code>&lt;<em>service-ssl-secret</em>&gt;</code> 取代為服務的 Secret。這是選用參數。如果提供參數，則此值必須包含您的應用程式預期來自用戶端的金鑰及憑證。</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


#### SSL 服務支援與鑑別
{: #ssl-services-auth}

容許 HTTPS 要求，並使用單向或交互鑑別，加密要送至上游應用程式的資料流量，以取得額外的安全。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
使用 Ingress 控制器，針對需要 HTTPS 的負載平衡應用程式配置交互鑑別。



**附註**：開始之前，請[將憑證及金鑰轉換為 base-64 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.base64encode.org/)。

</dd>


<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
 metadata:
  name: &lt;myingressname&gt;
  annotations:
    ingress.bluemix.net/ssl-services: |
      ssl-service=&lt;myservice1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;myservice2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
 spec:
  tls:
  - hosts:
    - mydomain
    secretName: mysecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice1
          servicePort: 8443
      - path: /
        backend:
          serviceName: myservice2
          servicePort: 8444
          </code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>將 <code>&lt;<em>myservice</em>&gt;</code> 取代為代表您應用程式的服務名稱。系統會加密從應用程式負載平衡器到此應用程式的資料流量。</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>將 <code>&lt;<em>service-ssl-secret</em>&gt;</code> 取代為服務的 Secret。這是選用參數。如果提供參數，則此值必須包含您的應用程式預期來自用戶端的金鑰及憑證。</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>


<br />



