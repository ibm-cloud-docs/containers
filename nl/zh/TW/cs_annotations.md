---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-14"

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

若要將功能新增至 Ingress 控制器，您可以將註釋指定為 Ingress 資源中的 meta 資料。
{: shortdesc}

如需關於 Ingress 服務及如何開始使用它們的一般資訊，請參閱[使用 Ingress 控制器來配置應用程式的公用存取](cs_apps.html#cs_apps_public_ingress)。


|支援的註釋|說明|
|--------------------|-----------|
|[額外的用戶端要求或回應標頭](#proxy-add-headers)|將標頭資訊新增至用戶端要求，然後再將要求轉遞至後端應用程式，或新增至用戶端回應，然後再將回應傳送至用戶端。|
|[用戶端回應資料緩衝](#proxy-buffering)|將回應傳送至用戶端時，停用 Ingress 控制器上的用戶端回應緩衝。|
|[移除用戶端回應標頭](#response-remove-headers)|從用戶端回應移除標頭資訊，然後才將回應轉遞至用戶端。|
|[自訂連接逾時和讀取逾時](#proxy-connect-timeout)|調整 Ingress 控制器等待以連接及讀取後端應用程式的時間，在此時間之後，後端應用程式將被視為無法使用。|
|[自訂 HTTP 及 HTTPS 埠](#custom-port)|變更 HTTP 及 HTTPS 網路資料流量的預設埠。|
|[自訂用戶端要求內文大小上限](#client-max-body-size)|調整容許傳送至 Ingress 控制器的用戶端要求內文大小。|
|[外部服務](#proxy-external-service)|將路徑定義新增至外部服務，例如 {{site.data.keyword.Bluemix_notm}} 中管理的服務。|
|[廣域速率限制](#global-rate-limit)|對於所有服務，根據定義的金鑰，限制要求處理速率及連線數。|
|[HTTP 重新導向至 HTTPS](#redirect-to-https)|將您網域上不安全的 HTTP 要求重新導向 HTTPS。|
|[保留作用中要求](#keepalive-requests)|配置可以透過一個保留作用中連線提供的要求數目上限。|
|[保留作用中逾時](#keepalive-timeout)|配置保留作用中連線在伺服器上保持開啟的時間。|
|[交互鑑別](#mutual-auth)|配置 Ingress 控制器的交互鑑別。|
|[Proxy 緩衝區](#proxy-buffers)|針對來自 Proxy 伺服器的單一連線，設定用來讀取回應的緩衝區大小及數目。|
|[Proxy 工作中緩衝區大小](#proxy-busy-buffers-size)|限制在尚未完全讀取回應時，可忙於將回應傳送至用戶端的緩衝區大小總計。|
|[Proxy 緩衝區大小](#proxy-buffer-size)|設定緩衝區大小，用來讀取從 Proxy 伺服器收到之回應的第一部分。|
|[重新編寫路徑](#rewrite-path)|將送入的網路資料流量遞送至後端應用程式接聽的不同路徑。|
|[Cookie 的階段作業親緣性](#sticky-cookie-services)|使用 Sticky Cookie 一律將送入的網路資料流量遞送至相同的上游伺服器。|
|[服務速率限制](#service-rate-limit)|對於特定服務，根據定義的金鑰，限制要求處理速率及連線數。|
|[SSL 服務支援](#ssl-services)|容許負載平衡的 SSL 服務支援。|
|[TCP 埠](#tcp-ports)|透過非標準 TCP 埠存取應用程式。|
|[上游保留作用中](#upstream-keepalive)|配置上游伺服器之閒置保留作用中連線的數目上限。|






## 其他用戶端要求或回應標頭 (proxy-add-headers)
{: #proxy-add-headers}

將額外的標頭資訊新增至用戶端要求，然後再將要求傳送至後端應用程式，或新增至用戶端回應，然後再將回應傳送至用戶端。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 控制器充當用戶端應用程式與後端應用程式之間的 Proxy。傳送至 Ingress 控制器的用戶端要求會被處理（代理），然後放入新的要求，從 Ingress 控制器傳送到您的後端應用程式。代理 (Proxy) 要求會移除一開始從用戶端傳送的 HTTP 標頭資訊，例如使用者名稱。如果您的後端應用程式需要此資訊，可以使用 <strong>ingress.bluemix.net/proxy-add-headers</strong> 註釋，將標頭資訊新增至用戶端要求，之後才將要求從 Ingress 控制器轉遞到您的後端應用程式。

</br></br>
當後端應用程式傳送回應給用戶端時，回應會由 Ingress 控制器代理，並從回應移除 HTTP 標頭。用戶端 Web 應用程式可能需要此標頭資訊才能順利處理回應。您可以使用 <strong>ingress.bluemix.net/response-add-headers</strong> 註釋，將標頭資訊新增至用戶端回應，之後才將回應從 Ingress 控制器轉遞到用戶端 Web 應用程式。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
  metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
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
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;service_name&gt;</em></code>：您為應用程式所建立之 Kubernetes 服務的名稱。</li>
  <li><code><em>&lt;header&gt;</em></code>：要新增至用戶端要求或用戶端回應的標頭資訊索引鍵。</li>
  <li><code><em>&lt;value&gt;</em></code>：要新增至用戶端要求或用戶端回應的標頭資訊值。</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## 用戶端回應資料緩衝 (proxy-buffering)
 {: #proxy-buffering}

 使用緩衝區註釋，可以停用在資料傳送至用戶端時，在 Ingress 控制器上儲存回應資料。
{:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>Ingress 控制器充當後端應用程式與用戶端 Web 瀏覽器之間的 Proxy。回應從後端應用程式傳送至用戶端時，依預設會將回應資料緩衝在 Ingress 控制器上。Ingress 控制器會代理用戶端回應，並開始按照用戶端的速度將回應傳送至用戶端。Ingress 控制器收到來自後端應用程式的所有資料之後，會關閉後端連線。從 Ingress 控制器到用戶端的連線會維持開啟，直到用戶端收到所有資料為止。

 </br></br>
如果停用在 Ingress 控制器上緩衝回應資料，資料立即從 Ingress 控制器傳送至用戶端。用戶端必須能夠按照 Ingress 控制器的速度處理送入的資料。如果用戶端太慢，資料可能會遺失。
</br></br>
依預設會啟用 Ingress 控制器上的回應資料緩衝。</dd>
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


 ## 移除用戶端回應標頭 (response-remove-headers)
 {: #response-remove-headers}

移除來自後端應用程式之用戶端回應中內含的標頭資訊，再將回應傳送至用戶端。
 {:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>Ingress 控制器充當後端應用程式與用戶端 Web 瀏覽器之間的 Proxy。從後端應用程式傳送到 Ingress 控制器的用戶端回應會被處理（代理），然後放入新的回應，從 Ingress 控制器傳送到用戶端 Web 瀏覽器。雖然代理回應會移除一開始從後端應用程式傳送的 HTTP 標頭資訊，但這個程序不一定會移除所有後端應用程式特有的標頭。從用戶端回應移除標頭資訊，然後再將回應從 Ingress 控制器轉遞到用戶端 Web 應用程式。</dd>
 <dt>Ingress 資源範例 YAML</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
  metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
       }
      serviceName=&lt;service_name2&gt; {
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
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
       - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>請取代下列值：<ul>
   <li><code><em>&lt;service_name&gt;</em></code>：您為應用程式所建立之 Kubernetes 服務的名稱。</li>
   <li><code><em>&lt;header&gt;</em></code>：要從用戶端回應移除的標頭索引鍵。</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## 自訂連接逾時及讀取逾時（proxy-connect-timeout、proxy-read-timeout）
{: #proxy-connect-timeout}

設定 Ingress 控制器的自訂連接逾時及讀取逾時。調整 Ingress 控制器連接及讀取後端應用程式時等候的時間，在此時間之後，後端應用程式將被視為無法使用。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>用戶端要求傳送至 Ingress 控制器時，Ingress 控制器會開啟與後端應用程式的連線。依預設，Ingress 控制器會等待 60 秒，以便從後端應用程式收到回覆。如果後端應用程式未在 60 秒內回覆，則會中斷連線要求，且後端應用程式將被視為無法使用。

</br></br>
在 Ingress 控制器連接至後端應用程式之後，Ingress 控制器會讀取來自後端應用程式的回應資料。在此讀取作業期間，Ingress 控制器在兩次讀取作業之間最多等待 60 秒，以接收來自後端應用程式的資料。如果後端應用程式未在 60 秒內傳送資料，則會關閉與後端應用程式的連線，且應用程式將被視為無法使用。
</br></br>
60 秒的連接逾時及讀取逾時是 Proxy 上的預設逾時，通常不應該加以變更。
</br></br>
如果應用程式的可用性不穩定，或是您的應用程式因為高工作負載而回應太慢，您或許會想增加連接逾時或讀取逾時。請記住，增加逾時會影響 Ingress 控制器的效能，因為與後端應用程式的連線必須維持開啟，直到達到逾時為止。
</br></br>
另一方面，您可以減少逾時以提高 Ingress 控制器的效能。請確保您的後端應用程式能夠在指定的逾時內處理要求，即使是在較高工作負載的時段。</dd>
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
 <td><code>annotations</code></td>
 <td>請取代下列值：<ul><li><code><em>&lt;connect_timeout&gt;</em></code>：輸入要等待連接後端應用程式的秒數，例如 <strong>65s</strong>。

  </br></br>
 <strong>附註：</strong>連接逾時不可超過 75 秒。</li><li><code><em>&lt;read_timeout&gt;</em></code>：輸入要在讀取後端應用程式之前等待的秒數，例如 <strong>65s</strong>。</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## 自訂 HTTP 及 HTTPS 埠 (custom-port)
{: #custom-port}

變更 HTTP 及 HTTPS 網路資料流量的預設埠，HTTP 為埠 80，HTTPS 為埠 443。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>依預設，Ingress 控制器配置為在埠 80 上接聽送入的 HTTP 網路資料流量，並在埠 443 上接聽送入的 HTTPS 網路資料流量。您可以變更預設埠來新增 Ingress 控制器網域的安全，或是只啟用 HTTPS 埠。
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
 <td><code>annotations</code></td>
 <td>請取代下列值：<ul>
 <li><code><em>&lt;protocol&gt;</em></code>：輸入 <strong>http</strong> 或 <strong>https</strong> 來變更送入之 HTTP 或 HTTPS 網路資料流量的預設埠。</li>
 <li><code><em>&lt;port&gt;</em></code>：輸入要用於送入之 HTTP 或 HTTPS 網路資料流量的埠號。</li>
 </ul>
 <p><strong>附註：</strong>當為 HTTP 或 HTTPS 指定自訂埠時，預設埠對於 HTTP 和 HTTPS 便不再有效。例如，若要將 HTTPS 的預設埠變更為 8443，但 HTTP 使用預設埠，您必須兩者都設定自訂埠：<code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>。</p>
 </td>
 </tr>
 </tbody></table>

 </dd>
 <dt>用法</dt>
 <dd><ol><li>檢閱 Ingress 控制器的開啟埠。
**附註：IP 位址需要是一般文件 IP 位址。也需要鏈結至目標 kubectl cli 嗎？可能不需要。**
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


## 自訂用戶端要求內文大小上限 (client-max-body-size)
{: #client-max-body-size}

調整用戶端可以傳送作為要求一部分的內文大小上限。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>為了維護預期的效能，用戶端要求內文大小上限設為 1 MB。當內文大小超過限制的用戶端要求傳送至 Ingress 控制器，而且用戶端不容許分割資料時，Ingress 控制器會傳回 413（要求的實體太大）的 HTTP 回應給用戶端。在要求內文的大小減少之前，用戶端及 Ingress 控制器之間無法進行連線。當用戶端容許資料分割成多個片段時，資料會分成多個 1 MB 的套件，然後傳送至 Ingress 控制器。

</br></br>
您可能會想要增加內文大小上限，因為您預期用戶端要求的內文大小會大於 1 MB。例如，您要讓用戶端能上傳大型檔案。增加要求內文大小上限可能會影響 Ingress 控制器的效能，因為對用戶端的連線必須維持開啟，直到收到要求為止。
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
    ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
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
 <td><code>annotations</code></td>
 <td>請取代下列值：<ul>
 <li><code><em>&lt;size&gt;</em></code>：輸入用戶端回應內文的大小上限。例如，若要將它設為 200 MB，請定義 <strong>200m</strong>。

  </br></br>
 <strong>附註：</strong>您可以將大小設為 0，以停用用戶端要求內文大小的檢查。</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<回到這裡>

## 外部服務 (proxy-external-service)
{: #proxy-external-service}
將路徑定義新增至外部服務，例如 {{site.data.keyword.Bluemix_notm}} 中管理的服務。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>將路徑定義新增至外部服務。此註釋適用於特殊情況，因為它不會在後端服務上運作，但可在外部服務上作用。外部服務路徑不支援 client-max-body-size、proxy-read-timeout、proxy-connect-timeout、proxy-buffering 以外的註釋。
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
    ingress.bluemix.net/proxy-external-service: "path=&lt;path&gt; external-svc=https:&lt;external_service&gt; host=&lt;mydomain&gt;"
  spec:
  tls:
  - hosts:
    - &lt;mydomain&gt;
    secretName: mysecret
  rules:
  - host: &lt;mydomain&gt;
    http:
      paths:
      - path: &lt;path&gt;
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
 <td><code>annotations</code></td>
 <td>請取代下列值：<ul>
 <li><code><em>&lt;external_service&gt;</em></code>：輸入要呼叫的外部服務。例如，https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net。</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## 廣域速率限制 (global-rate-limit)
{: #global-rate-limit}

對於所有服務，根據來自 Ingress 對映中所有主機之單一 IP 位址的已定義金鑰，限制要求處理速率及連線數目。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
若要設定限制，區域會由 `ngx_http_limit_conn_module` 及 `ngx_http_limit_req_module` 定義。在對應於 Ingress 對映中每一個主機的伺服器區塊中，會套用那些區域。
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
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;key&gt;</em></code>：若要根據位置或服務來設定送入要求的廣域限制，請使用 `key=location`。若要根據標頭來設定送入要求的廣域限制，請使用 `X-USER-ID key==$http_x_user_id`。</li>
  <li><code><em>&lt;rate&gt;</em></code>：速率。</li>
  <li><code><em>&lt;conn&gt;</em></code>：連線數目。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## HTTP 重新導向至 HTTPS (redirect-to-https)
 {: #redirect-to-https}

 將不安全的 HTTP 用戶端要求轉換成 HTTPS。
 {:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>您設定 Ingress 控制器，以 IBM 提供的 TLS 憑證或您的自訂 TLS 憑證來保護網域。有些使用者可能會嘗試對 Ingress 控制器網域使用不安全的 HTTP 要求存取您的應用程式，例如 <code>http://www.myingress.com</code>，而不是使用 <code>https</code>。您可以使用重新導向註釋，一律將不安全的 HTTP 用戶端要求重新導向至 HTTPS。如果您未使用此註釋，依預設，不安全的 HTTP 要求不會轉換成 HTTPS 要求，且可能會將未加密的機密資訊公開給大眾。

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




 <br />

 
 ## 保留作用中要求 (keepalive-requests)
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
    ingress.bluemix.net/keepalive-requests: "serviceName=&lt;service_name&gt; requests=&lt;max_requests&gt;"
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
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：將 <em>&lt;service_name&gt;</em> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。這是選用參數。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。如果提供參數，則會針對給定的服務設定保留作用中要求。如果未提供參數，則會針對未配置保留作用中要求的所有服務，在 <code>nginx.conf</code> 的伺服器層次設定保留作用中要求。</li>
  <li><code><em>&lt;requests&gt;</em></code>：將 <em>&lt;max_requests&gt;</em> 取代為可以透過一個保留作用中連線提供的要求數目上限。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## 保留作用中逾時（keepalive-timeout）
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
     ingress.bluemix.net/keepalive-timeout: "serviceName=&lt;service_name&gt; timeout=&lt;time&gt;s"
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
   <td><code>annotations</code></td>
   <td>請取代下列值：<ul>
   <li><code><em>&lt;serviceName&gt;</em></code>：將 <em>&lt;service_name&gt;</em> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。這是選用參數。如果提供參數，則會針對給定的服務設定保留作用中逾時。如果未提供參數，則會針對未配置保留作用中逾時的所有服務，在 <code>nginx.conf</code> 的伺服器層次設定保留作用中逾時。</li>
   <li><code><em>&lt;timeout&gt;</em></code>：將 <em>&lt;time&gt;</em> 取代為時間量（以秒為單位）。範例：<code><em>timeout=20s</em></code>。零值會停用保留作用中用戶端連線。</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## 交互鑑別 (mutual-auth)
 {: #mutual-auth}

 配置 Ingress 控制器的交互鑑別。
 {:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>
 配置 Ingress 控制器的交互鑑別。用戶端會鑑別伺服器，而伺服器也會使用憑證來鑑別用戶端。交互鑑別也稱為憑證型鑑別或雙向鑑別。
 </dd>

 <dt>必要條件</dt>
 <dd>
 <ul>
 <li>[您必須具有包含必要憑證管理中心 (CA) 的有效 Secret](cs_apps.html#secrets)。同時需要 <code>client.key</code> 和 <code>client.crt</code> 來進行交互鑑別。</li>
 <li>若要在 443 以外的埠上啟用交互鑑別，請[配置負載平衡器以開啟有效的埠](cs_apps.html#opening_ingress_ports)。</li>
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
    ingress.bluemix.net/mutual-auth: "port=&lt;port&gt; secretName=&lt;secretName&gt; serviceName=&lt;service1&gt;,&lt;service2&gt;"
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
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：一個以上 Ingress 資源的名稱。這是選用參數。</li>
  <li><code><em>&lt;secretName&gt;</em></code>：將 <em>&lt;secret_name&gt;</em> 取代為 Secret 資源的名稱。</li>
  <li><code><em>&lt;port&gt;</em></code>：輸入埠號。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Proxy 緩衝區 (proxy-buffers)
 {: #proxy-buffers}
 
 配置 Ingress 控制器的 Proxy 緩衝區。
 {:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>
 針對來自 Proxy 伺服器的單一連線，設定用來讀取回應的緩衝區大小及數目。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。例如，如果指定 <code>serviceName=SERVICE number=2 size=1k</code> 之類的配置，則會將 1k 套用至服務。如果指定 <code>number=2 size=1k</code> 之類的配置，則會將 1k 套用至 Ingress 主機中的所有服務。
 </dd>
 <dt>Ingress 資源範例 YAML</dt>
 <dd>
 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
  metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffers: "serviceName=&lt;service_name&gt; number=&lt;number_of_buffers&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：將 <em>&lt;serviceName&gt;</em> 取代為要套用 proxy-buffers 之服務的名稱。</li>
  <li><code><em>&lt;number_of_buffers&gt;</em></code>：將 <em>&lt;number_of_buffers&gt;</em> 取代為數字，例如 <em>2</em>。</li>
  <li><code><em>&lt;size&gt;</em></code>：以千位元組（k 或 K）為單位輸入每一個緩衝區的大小，例如 <em>1K</em>。</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## Proxy 工作中緩衝區大小 (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 配置 Ingress 控制器的 Proxy 工作中緩衝區大小。
 {:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>
 若已啟用來自 Proxy 伺服器的回應緩衝，限制在尚未完全讀取回應時，可以忙於將回應傳送至用戶端的緩衝區大小總計。同時，其餘的緩衝區可用於讀取回應，並在必要時，將回應的一部分緩衝至暫存檔。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。例如，如果指定 <code>serviceName=SERVICE size=1k</code> 之類的配置，則會將 1k 套用至服務。如果指定 <code>size=1k</code> 之類的配置，則會將 1k 套用至 Ingress 主機中的所有服務。
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
          servicePort: 8080</code></pre>
 <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：將 <em>&lt;serviceName&gt;</em> 取代為要套用 proxy-busy-buffers-size 之服務的名稱。</li>
  <li><code><em>&lt;size&gt;</em></code>：以千位元組（k 或 K）為單位輸入每一個緩衝區的大小，例如 <em>1K</em>。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Proxy 緩衝區大小 (proxy-buffer-size)
 {: #proxy-buffer-size}

 配置 Ingress 控制器的 Proxy 緩衝區大小。
 {:shortdesc}

 <dl>
 <dt>說明</dt>
 <dd>
 設定緩衝區大小，用來讀取從 Proxy 伺服器收到之回應的第一部分。此部分的回應通常包含小型回應標頭。除非已指定服務，否則配置會套用至 Ingress 主機中的所有服務。例如，如果指定 <code>serviceName=SERVICE size=1k</code> 之類的配置，則會將 1k 套用至服務。如果指定 <code>size=1k</code> 之類的配置，則會將 1k 套用至 Ingress 主機中的所有服務。
 </dd>


 <dt>Ingress 資源範例 YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
  metadata:
  name: proxy-ingress
  annotations:
    ingress.bluemix.net/proxy-buffer-size: "serviceName=&lt;serviceName&gt; size=&lt;size&gt;"
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
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：將 <em>&lt;serviceName&gt;</em> 取代為要套用 proxy-busy-buffers-size 之服務的名稱。</li>
  <li><code><em>&lt;size&gt;</em></code>：以千位元組（k 或 K）為單位輸入每一個緩衝區的大小，例如 <em>1K</em>。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## 重新編寫路徑 (rewrite-path)
{: #rewrite-path}

將 Ingress 控制器網域路徑上的送入網路資料流量遞送至與後端應用程式所接聽的不同路徑。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 控制器網域會將 <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> 上的送入網路資料流量遞送至您的應用程式。您的應用程式會接聽 <code>/coffee</code>，而非 <code>/beans</code>。若要將送入的網路資料流量轉遞至您的應用程式，請將重新編寫註釋新增至您的 Ingress 資源配置檔。重新編寫註釋確保 <code>/beans</code> 上的送入網路資料流量會使用 <code>/coffee</code> 路徑轉遞至您的應用程式。包含多個服務時，只使用分號 (;) 來區隔它們。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
  metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;target_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;target_path2&gt;"
  spec:
  tls:
  - hosts:
    - mydomain
    secretName: &lt;mytlssecret&gt;
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>將 <em>&lt;service_name&gt;</em> 取代為您為應用程式所建立之 Kubernetes 服務的名稱，並將 <em>&lt;target-path&gt;</em> 取代為您的應用程式所接聽的路徑。Ingress 控制器網域上的送入網路資料流量即會使用此路徑轉遞至 Kubernetes 服務。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在此情況下，將 <code>/</code> 定義為您應用程式的 <em>rewrite-path</em>。</td>
</tr>
<tr>
<td><code>path</code></td>
<td>將 <em>&lt;domain_path&gt;</em> 取代為您要附加至 Ingress 控制器網域的路徑。這個路徑上的送入網路資料流量即會轉遞至您在註釋中所定義的重新編寫路徑。在上述範例中，請將網域路徑設定為 <code>/beans</code>，以將此路徑包含在 Ingress 控制器的負載平衡中。</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>將 <em>&lt;service_name&gt;</em> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。您在這裡使用的服務名稱，必須與在註釋中定義的名稱相同。</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>將 <em>&lt;service_port&gt;</em> 取代為服務所接聽的埠。</td>
</tr></tbody></table>

</dd></dl>

<br />


## 服務速率限制 (service-rate-limit)
{: #service-rate-limit}

對於特定服務，根據來自所選取後端的所有路徑之單一 IP 位址的已定義金鑰，限制要求處理速率及連線數目。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
若要設定限制，會套用 `ngx_http_limit_conn_module` 及 `ngx_http_limit_req_module` 定義在所有位置區塊中的區域，而這些位置區塊對應於 Ingress 對映中作為註釋目標的所有服務。</dd>


 <dt>Ingress 資源範例 YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
  metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/service-rate-limit: "serviceName=&lt;service_name&gt; key=&lt;key&gt; rate=&lt;rate&gt; conn=&lt;number_of_connections&gt;"
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
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：Ingress 資源的名稱。</li>
  <li><code><em>&lt;key&gt;</em></code>：若要根據位置或服務來設定送入要求的廣域限制，請使用 `key=location`。若要根據標頭來設定送入要求的廣域限制，請使用 `X-USER-ID key==$http_x_user_id`。</li>
  <li><code><em>&lt;rate&gt;</em></code>：速率。</li>
  <li><code><em>&lt;conn&gt;</em></code>：連線數目。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## 使用 Cookie 的階段作業親緣性 (sticky-cookie-services)
{: #sticky-cookie-services}

使用 Sticky Cookie 註釋，可將階段作業親緣性新增至您的 Ingress 控制器，並一律將送入的網路資料流量遞送至相同的上游伺服器。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>對於高可用性，部分應用程式設定需要您部署多個上游伺服器，用來處理送入的用戶端要求。當用戶端連接至您的後端應用程式時，您可以使用階段作業親緣性，以在階段作業時間，或是在完成作業所需的時間內，由相同的上游伺服器服務某一用戶端。您可以配置 Ingress 控制器，一律將送入的網路資料流量遞送至相同的上游伺服器，以確保階段作業親緣性。

</br></br>
連接至您的後端應用程式的每個用戶端，會由 Ingress 控制器指派給其中一個可用的上游伺服器。Ingress 控制器會建立階段作業 Cookie，它儲存在用戶端應用程式中，而用戶端應用程式則內含在 Ingress 控制器與用戶端之間每個要求的標頭資訊中。Cookie 中的資訊確保所有要求在整個階段作業中，都由相同的上游伺服器處理。

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
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
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
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>瞭解 YAML 檔案元件</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;service_name&gt;</em></code>：您為應用程式所建立之 Kubernetes 服務的名稱。</li>
  <li><code><em>&lt;cookie_name&gt;</em></code>：選擇在階段作業期間建立的 Sticky Cookie。</li>
  <li><code><em>&lt;expiration_time&gt;</em></code>：Sticky Cookie 到期之前的時間量，以秒、分鐘或小時為單位。此時間與使用者活動無關。Cookie 到期之後，用戶端 Web 瀏覽器會刪除 Cookie，而且不再傳送到 Ingress 控制器。例如，若要設定 1 秒、1 分鐘或 1 小時的有效期限，請輸入 <strong>1s</strong>、<strong>1m</strong> 或 <strong>1h</strong>。</li>
  <li><code><em>&lt;cookie_path&gt;</em></code>：附加至 Ingress 子網域的路徑，且該路徑指出針對哪些網域和子網域傳送 Cookie 到 Ingress 控制器。例如，如果您的 Ingress 網域是 <code>www.myingress.com</code> 且想要在每個用戶端要求中傳送 Cookie，您必須設定 <code>path=/</code>。如果您只想針對 <code>www.myingress.com/myapp</code> 及其所有子網域傳送 Cookie，則必須設定 <code>path=/myapp</code>。</li>
  <li><code><em>&lt;hash_algorithm&gt;</em></code>：保護 Cookie 中資訊的雜湊演算法。僅支援 <code>sha1</code>。SHA1 會根據 Cookie 中的資訊建立雜湊總和，並將此雜湊總和附加到 Cookie。伺服器可以解密 Cookie 中的資訊，然後驗證資料完整性。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## SSL 服務支援 (ssl-services)
{: #ssl-services}

容許 HTTPS 要求並加密要送至上游應用程式的資料流量。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
使用 Ingress 控制器加密要送至需要 HTTPS 之上游應用程式的資料流量。

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
    ingress.bluemix.net/ssl-services: ssl-service=&lt;service1&gt; [ssl-secret=&lt;service1-ssl-secret&gt;];ssl-service=&lt;service2&gt; [ssl-secret=&lt;service2-ssl-secret&gt;]
  spec:
rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;myservice&gt;</em></code>：輸入代表您應用程式的服務名稱。系統會加密從 Ingress 控制器到此應用程式的資料流量。</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code>：輸入服務的 Secret。這是選用參數。如果提供參數，則此值必須包含您的應用程式預期來自用戶端的金鑰及憑證。</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td>將 <em>&lt;ibmdomain&gt;</em> 取代為 IBM 提供的 <strong>Ingress 子網域</strong>名稱。
  <br><br>
  <strong>附註：</strong>若要避免在建立 Ingress 期間發生失敗，請不要使用 * 作為您的主機，也不要讓主機內容保留空白。</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>將 <em>&lt;myservicepath&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

  </br>
        針對每個 Kubernetes 服務，您可以定義附加至 IBM 所提供之網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>ingress_domain/myservicepath1</code>。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱相關聯的服務，然後將網路資料流量傳送至服務，並使用相同路徑傳送至執行應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。</br></br>
  許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。</br>
  範例：<ul><li>針對 <code>http://ingress_host_name/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>http://ingress_host_name/myservicepath</code>，輸入 <code>/myservicepath</code> 作為路徑。</li></ul>
  </br>
  <strong>提示：</strong>若要將 Ingress 配置為接聽與應用程式所接聽路徑不同的路徑，您可以使用<a href="#rewrite-path" target="_blank">重新編寫註釋</a>來建立應用程式的正確遞送。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>將 <em>&lt;myservice&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### SSL 服務支援與鑑別
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
      ssl-service=&lt;service1&gt; ssl-secret=&lt;service1-ssl-secret&gt;;
      ssl-service=&lt;service2&gt; ssl-secret=&lt;service2-ssl-secret&gt;
  spec:
  tls:
  - hosts:
    - &lt;ibmdomain&gt;
    secretName: &lt;secret_name&gt;
  rules:
  - host: &lt;ibmdomain&gt;
    http:
      paths:
      - path: /&lt;myservicepath1&gt;
        backend:
          serviceName: &lt;myservice1&gt;
          servicePort: 8443
      - path: /&lt;myservicepath2&gt;
        backend:
          serviceName: &lt;myservice2&gt;
          servicePort: 8444</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;service&gt;</em></code>：輸入服務的名稱。</li>
  <li><code><em>&lt;service-ssl-secret&gt;</em></code>：輸入服務的 Secret。</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td>將 <em>&lt;ibmdomain&gt;</em> 取代為 IBM 提供的 <strong>Ingress 子網域</strong>名稱。
  <br><br>
  <strong>附註：</strong>若要避免在建立 Ingress 期間發生失敗，請不要使用 * 作為您的主機，也不要讓主機內容保留空白。</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td>將 <em>&lt;secret_name&gt;</em> 取代為保留您的憑證及金鑰（進行交互鑑別）的 Secret 名稱。
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>將 <em>&lt;myservicepath&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

  </br>
        針對每個 Kubernetes 服務，您可以定義附加至 IBM 所提供之網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>ingress_domain/myservicepath1</code>。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱相關聯的服務，然後將網路資料流量傳送至服務，並使用相同路徑傳送至執行應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。</br></br>
許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。</br>
  範例：<ul><li>針對 <code>http://ingress_host_name/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>http://ingress_host_name/myservicepath</code>，輸入 <code>/myservicepath</code> 作為路徑。</li></ul>
  </br>
  <strong>提示：</strong>若要將 Ingress 配置為接聽與應用程式所接聽路徑不同的路徑，您可以使用<a href="#rewrite-path" target="_blank">重新編寫註釋</a>來建立應用程式的正確遞送。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>將 <em>&lt;myservice&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
  </tr>
  </tbody></table>

  </dd>



<dt>用於單向鑑別的範例 Secret YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
  metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt: &lt;certificate_name&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>將 <em>&lt;secret_name&gt;</em> 取代為 Secret 資源的名稱。</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>：輸入授信憑證的名稱。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>用於交互鑑別的範例 Secret YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: v1
kind: Secret
  metadata:
  name: &lt;secret_name&gt;
type: Opaque
data:
  trusted.crt : &lt;certificate_name&gt;
    client.crt : &lt;client_certificate_name&gt;
    client.key : &lt;certificate_key&gt;
</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>將 <em>&lt;secret_name&gt;</em> 取代為 Secret 資源的名稱。</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>：輸入授信憑證的名稱。</li>
  <li><code><em>&lt;client_certificate_name&gt;</em></code>：輸入用戶端憑證的名稱。</li>
  <li><code><em>&lt;certificate_key&gt;</em></code>：輸入用戶端憑證的金鑰。</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## Ingress 控制器的 TCP 埠 (tcp-ports)
{: #tcp-ports}

透過非標準 TCP 埠存取應用程式。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>
對正在執行 TCP 串流工作負載的應用程式使用此註釋。

<p>**附註**：Ingress 控制器係以透通模式運作，並將資料流量傳遞至後端應用程式。在此情況下，不支援 SSL 終止。</p>
</dd>


 <dt>Ingress 資源範例 YAML</dt>
 <dd>

 <pre class="codeblock">
 <code>apiVersion: extensions/v1beta1
kind: Ingress
  metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/tcp-ports: "serviceName=&lt;service_name&gt; ingressPort=&lt;ingress_port&gt; [servicePort=&lt;service_port&gt;]"
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
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code>：您要在其上存取應用程式的 TCP 埠。</li>
  <li><code><em>&lt;serviceName&gt;</em></code>：透過非標準 TCP 埠存取之 Kubernetes 服務的名稱。</li>
  <li><code><em>&lt;servicePort&gt;</em></code>：這是選用參數。若已提供，埠會替換為此值，然後再將資料流量傳送至後端應用程式。否則，埠會保持與 Ingress 埠相同。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## 上游保留作用中 (upstream-keepalive)
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
      ingress.bluemix.net/upstream-keepalive: "serviceName=&lt;service_name&gt; keepalive=&lt;max_connections&gt;"
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
    <td><code>annotations</code></td>
    <td>請取代下列值：<ul>
    <li><code><em>&lt;serviceName&gt;</em></code>：將 <em>&lt;service_name&gt;</em> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。</li>
    <li><code><em>&lt;keepalive&gt;</em></code>：將 <em>&lt;max_connections&gt;</em> 取代為上游伺服器之閒置保留作用中連線的數目上限。預設值是 64。 零值會停用給定服務的上游保留作用中連線。</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>


