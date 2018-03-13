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


# Ingress 注释
{: #ingress_annotation}

要向应用程序负载均衡器添加功能，您可以将注释指定为 Ingress 资源中的元数据。
{: shortdesc}

有关 Ingress 服务以及有关如何开始使用这些服务的常规信息，请参阅[使用 Ingress 来配置对应用程序的公共访问权](cs_ingress.html#config)。

<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>一般注释</th>
 <th>名称</th>
 <th>描述</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-external-service">外部服务</a></td>
 <td><code>proxy-external-service</code></td>
 <td>添加外部服务（例如，{{site.data.keyword.Bluemix_notm}} 中托管的服务）的路径定义。
</td>
 </tr>
 <tr>
 <td><a href="#alb-id">专用应用程序负载均衡器路由</a></td>
 <td><code>ALB-ID</code></td>
 <td>将入局请求路由到具有专用应用程序负载均衡器的应用程序。</td>
 </tr>
 <tr>
 <td><a href="#rewrite-path">重写路径</a></td>
 <td><code>rewrite-path</code></td>
 <td>将入局网络流量路由到后端应用程序侦听的其他路径。</td>
 </tr>
 <tr>
 <td><a href="#sticky-cookie-services">使用 cookie 确保会话亲缘关系</a></td>
 <td><code>sticky-cookie-services</code></td>
 <td>使用粘性 cookie 始终将入局网络流量路由到同一个上游服务器。</td>
 </tr>
 <tr>
 <td><a href="#tcp-ports">TCP 端口</a></td>
 <td><code>tcp-ports</code></td>
 <td>通过非标准 TCP 端口访问应用程序。</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>连接注释</th>
 <th>名称</th>
 <th>描述</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#proxy-connect-timeout">定制连接超时和读取超时</a></td>
  <td><code>proxy-connect-timeout</code></td>
  <td>调整应用程序负载均衡器等待连接到后端应用程序以及从后端应用程序进行读取的时间，超过该时间后，后端应用程序将视为不可用。</td>
  </tr>
  <tr>
  <td><a href="#keepalive-requests">保持活动请求数</a></td>
  <td><code>keepalive-requests</code></td>
  <td>配置可通过一个保持活动连接处理的最大请求数。</td>
  </tr>
  <tr>
  <td><a href="#keepalive-timeout">保持活动超时</a></td>
  <td><code>keepalive-timeout</code></td>
  <td>配置保持活动连接在服务器上保持打开状态的时间。</td>
  </tr>
  <tr>
  <td><a href="#upstream-keepalive">上游保持活动连接数</a></td>
  <td><code>upstream-keepalive</code></td>
  <td>配置上游服务器的最大空闲保持活动连接数。</td>
  </tr>
  </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th>代理缓冲区注释</th>
 <th>名称</th>
 <th>描述</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-buffering">客户机响应数据缓冲</a></td>
 <td><code>proxy-buffering</code></td>
 <td>禁用在向客户机发送响应时应用程序负载均衡器上的客户机响应缓冲。</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffers">代理缓冲区数</a></td>
 <td><code>proxy-buffers</code></td>
 <td>设置缓冲区的数目和大小，这些缓冲区用于读取来自通过代理传递的服务器的单个连接的响应。</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffer-size">代理缓冲区大小</a></td>
 <td><code>proxy-buffer-size</code></td>
 <td>设置缓冲区的大小，该缓冲区用于读取从通过代理传递的服务器收到的响应的第一部分。</td>
 </tr>
 <tr>
 <td><a href="#proxy-busy-buffers-size">代理繁忙缓冲区大小</a></td>
 <td><code>proxy-busy-buffers-size</code></td>
 <td>设置可以处于繁忙状态的代理缓冲区的大小。</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>请求和响应注释</th>
<th>名称</th>
<th>描述</th>
</thead>
<tbody>
<tr>
<td><a href="#proxy-add-headers">额外的客户机请求或响应头</a></td>
<td><code>proxy-add-headers</code></td>
<td>向客户机请求添加头信息，然后将该请求转发到后端应用程序，或者向客户机响应添加头信息，然后将该响应发送到客户机。</td>
</tr>
<tr>
<td><a href="#response-remove-headers">除去客户机响应头</a></td>
<td><code>response-remove-headers</code></td>
<td>从客户机响应中除去头信息，然后将该响应转发到客户机。</td>
</tr>
<tr>
<td><a href="#client-max-body-size">定制最大客户机请求主体大小</a></td>
<td><code>client-max-body-size</code></td>
<td>调整允许发送到应用程序负载均衡器的客户机请求主体的大小。</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>服务限制注释</th>
<th>名称</th>
<th>描述</th>
</thead>
<tbody>
<tr>
<td><a href="#global-rate-limit">全局速率限制</a></td>
<td><code>global-rate-limit</code></td>
<td>对于所有服务，按定义的键限制请求处理速率和连接数。</td>
</tr>
<tr>
<td><a href="#service-rate-limit">服务速率限制</a></td>
<td><code>service-rate-limit</code></td>
<td>对于特定服务，按定义的键限制请求处理速率和连接数。</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th>HTTPS 和 TLS/SSL 认证注释</th>
<th>名称</th>
<th>描述</th>
</thead>
<tbody>
<tr>
<td><a href="#custom-port">定制 HTTP 和 HTTPS 端口</a></td>
<td><code>custom-port</code></td>
<td>更改 HTTP（端口 80）和 HTTPS（端口 443）网络流量的缺省端口。
</td>
</tr>
<tr>
<td><a href="#redirect-to-https">HTTP 重定向到 HTTPS</a></td>
<td><code>redirect-to-https</code></td>
<td>将域上的不安全的 HTTP 请求重定向到 HTTPS。</td>
</tr>
<tr>
<td><a href="#mutual-auth">相互认证</a></td>
<td><code>mutual-auth</code></td>
<td>为应用程序负载均衡器配置相互认证。</td>
</tr>
<tr>
<td><a href="#ssl-services">SSL 服务支持</a></td>
<td><code>ssl-services</code></td>
<td>允许支持 SSL 服务以进行负载均衡。</td>
</tr>
</tbody></table>



## 一般注释
{: #general}

### 外部服务 (proxy-external-service)
{: #proxy-external-service}

添加外部服务（例如，{{site.data.keyword.Bluemix_notm}} 中托管的服务）的路径定义。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>添加外部服务的路径定义。仅当应用程序在外部服务（而不是后端服务）上运行时，才可使用此注释。使用此注释来创建外部服务路径时，仅支持 `client-max-body-size`、`proxy-read-timeout`、`proxy-connect-timeout` 和 `proxy-buffering` 注释一起使用。不支持其他任何注释与 `proxy-external-service` 一起使用。
</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>path</code></td>
 <td>将 <code>&lt;<em>mypath</em>&gt;</code> 替换为外部服务侦听的路径。</td>
 </tr>
 <tr>
 <td><code>external-svc</code></td>
 <td>将 <code>&lt;<em>external_service</em>&gt;</code> 替换为要调用的外部服务。例如，<code>https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net</code>。</td>
 </tr>
 <tr>
 <td><code>host</code></td>
 <td>将 <code>&lt;<em>mydomain</em>&gt;</code> 替换为外部服务的主机域。</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### 专用应用程序负载均衡器路由 (ALB-ID)
{: #alb-id}

将入局请求路由到具有专用应用程序负载均衡器的应用程序。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
选择专用应用程序负载均衡器以路由入局请求，而不是选择公共应用程序负载均衡器。</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>&lt;private_ALB_ID&gt;</code></td>
<td>专用应用程序负载均衡器的标识。运行 <code>bx cs albs --cluster <my_cluster></code> 以查找专用应用程序负载均衡器标识。</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />



### 重写路径 (rewrite-path)
{: #rewrite-path}

将应用程序负载均衡器域路径上的入局网络流量路由到后端应用程序侦听的其他路径。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>Ingress 应用程序负载均衡器域将 <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> 上的入局网络流量路由到应用程序。应用程序侦听的是 <code>/coffee</code>，而不是 <code>/beans</code>。要将入局网络流量转发到应用程序，请将 rewrite 注释添加到 Ingress 资源配置文件。rewrite 注释可确保使用 <code>/coffee</code> 路径将 <code>/beans</code> 上的入局网络流量转发到应用程序。当包含多个服务时，请仅使用分号 (;) 来分隔这些服务。</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为您针对应用程序创建的 Kubernetes 服务的名称。</td>
</tr>
<tr>
<td><code>rewrite</code></td>
<td>将 <code>&lt;<em>target_path</em>&gt;</code> 替换为应用程序侦听的路径。应用程序负载均衡器域上的入局网络流量会使用此路径转发到 Kubernetes 服务。大多数应用程序不会侦听特定路径，而是使用根路径和特定端口。在上例中，rewrite 路径定义为 <code>/coffee</code>。</td>
</tr>
</tbody></table>

</dd></dl>

<br />


### 使用 cookie 确保会话亲缘关系 (sticky-cookie-services)
{: #sticky-cookie-services}

使用粘性 cookie 注释向应用程序负载均衡器添加会话亲缘关系，并始终将入局网络流量路由到同一个上游服务器。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>为了实现高可用性，某些应用程序设置要求您部署多个上游服务器来处理入局客户机请求。客户机连接到后端应用程序后，可以使用会话亲缘关系，使得在会话期间或完成任务所需的时间内，客户机由同一个上游服务器处理。您可以将应用程序负载均衡器配置为始终将入局网络流量路由到同一个上游服务器来确保会话亲缘关系。


</br></br>
连接到后端应用程序的每个客户机都会由应用程序负载均衡器分配其中一个可用的上游服务器。应用程序负载均衡器会创建会话 cookie，该会话 cookie 存储在客户机的应用程序中，并且包含在应用程序负载均衡器和客户机之间每个请求的头信息中。该 cookie 中的信息将确保在整个会话中的所有请求都由同一个上游服务器进行处理。


</br></br>
当包含多个服务时，请使用分号 (;) 来分隔这些服务。</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
  <caption>了解 YAML 文件的组成部分</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为您针对应用程序创建的 Kubernetes 服务的名称。</td>
  </tr>
  <tr>
  <td><code>name</code></td>
  <td>将 <code><em>&lt;cookie_name&gt;</em></code> 替换为在会话期间创建的粘性 cookie 的名称。</td>
  </tr>
  <tr>
  <td><code>expires</code></td>
  <td>将 <code>&lt;<em>expiration_time</em>&gt;</code> 替换为时间，以秒 (s)、分钟 (m) 或小时 (h) 为单位；超过该时间后，粘性 cookie 到期。此时间与用户活动无关。该 cookie 到期后，会被客户机 Web 浏览器删除，并且不会再发送到应用程序负载均衡器。例如，要将到期时间设置为 1 秒、1 分钟或 1 小时，请输入 <code>1s</code>、<code>1m</code> 或 <code>1h</code>。</td>
  </tr>
  <tr>
  <td><code>path</code></td>
  <td>将 <code><em>&lt;cookie_path&gt;</em></code> 替换为附加到 Ingress 子域的路径，该路径指示针对哪些域和子域将 cookie 发送到应用程序负载均衡器。例如，如果 Ingress 域为 <code>www.myingress.com</code>，并且您希望在每个客户机请求中都发送 cookie，那么必须设置 <code>path=/</code>。如果希望仅针对 <code>www.myingress.com/myapp</code> 及其所有子域发送 cookie，那么必须设置 <code>path=/myapp</code>。</td>
  </tr>
  <tr>
  <td><code>hash</code></td>
  <td>将 <code><em>&lt;hash_algorithm&gt;</em></code> 替换为用于保护 cookie 中信息的散列算法。仅支持 <code>sha1</code>。SHA1 基于 cookie 中的信息创建散列总和，并将此散列总和附加到 cookie。服务器可以解密 cookie 中的信息并验证数据完整性。</td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />



### 用于应用程序负载均衡器的 TCP 端口 (tcp-ports)
{: #tcp-ports}

通过非标准 TCP 端口访问应用程序。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
将此注释用于在运行 TCP 流工作负载的应用程序。



<p>**注**：应用程序负载均衡器以通过方式运行，并将流量转发到后端应用程序。在此情况下，不支持 SSL 终止。</p>
</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为要通过非标准 TCP 端口访问的 Kubernetes 服务的名称。</td>
  </tr>
  <tr>
  <td><code>ingressPort</code></td>
  <td>将 <code><em>&lt;ingress_port&gt;</em></code> 替换为要用于访问应用程序的 TCP 端口。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>此参数是可选的。如果提供了此参数，那么在将流量发送到后端应用程序之前，会将端口替换为此值。否则，该端口与 Ingress 端口保持相同。</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## 连接注释
{: #connection}

### 定制连接超时和读取超时（proxy-connect-timeout 和 proxy-read-timeout）
{: #proxy-connect-timeout}

为应用程序负载均衡器设置定制连接超时和读取超时。调整应用程序负载均衡器等待连接到后端应用程序以及从后端应用程序进行读取的时间，超过该时间后，后端应用程序将视为不可用。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>将客户机请求发送到 Ingress 应用程序负载均衡器时，应用程序负载均衡器会打开与后端应用程序的连接。缺省情况下，应用程序负载均衡器会等待 60 秒以接收来自后端应用程序的应答。如果后端应用程序在 60 秒内未应答，那么连接请求将异常中止，并且后端应用程序将视为不可用。



</br></br>
应用程序负载均衡器连接到后端应用程序后，应用程序负载均衡器会从后端应用程序读取响应数据。在此读操作期间，应用程序负载均衡器在两次读操作之间等待接收来自后端应用程序的数据的最长时间为 60 秒。如果后端应用程序在 60 秒内未发送数据，那么与后端应用程序的连接请求将关闭，并且后端应用程序将视为不可用。
</br></br>
60 秒连接超时和读取超时是代理上的缺省超时，通常不应进行更改。
</br></br>
如果由于工作负载过高而导致应用程序的可用性不稳定或应用程序响应速度缓慢，那么您可能会希望增大连接超时或读取超时。请记住，增大超时会影响应用程序负载均衡器的性能，因为与后端应用程序的连接必须保持打开状态，直至达到超时为止。
</br></br>
另一方面，您可以减小超时以提高应用程序负载均衡器的性能。确保后端应用程序能够在指定的超时内处理请求，即使在更高的工作负载期间。</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;connect_timeout&gt;</code></td>
 <td>等待连接到后端应用程序的秒数，例如 <code>65s</code>。<strong>注</strong>：连接超时不能超过 75 秒。</td>
 </tr>
 <tr>
 <td><code>&lt;read_timeout&gt;</code></td>
 <td>等待读取后端应用程序的秒数，例如 <code>65s</code>。<strong>注</strong>：读取超时不能超过 120 秒。</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### 保持活动请求数 (keepalive-requests)
{: #keepalive-requests}

配置可通过一个保持活动连接处理的最大请求数。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
 设置可通过一个保持活动连接处理的最大请求数。
 </dd>


<dt>样本 Ingress 资源 YAML</dt>
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
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为您针对应用程序创建的 Kubernetes 服务的名称。此参数是可选的。除非指定了服务，否则配置将应用于 Ingress 主机中的所有服务。如果提供了此参数，那么将为给定的服务设置保持活动请求数。如果未提供此参数，那么将在 <code>nginx.conf</code> 的服务器级别为所有未配置保持活动请求数的服务设置保持活动请求数。</td>
</tr>
<tr>
<td><code>requests</code></td>
<td>将 <code>&lt;<em>max_requests</em>&gt;</code> 替换为可通过一个保持活动连接处理的最大请求数。</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### 保持活动超时 (keepalive-timeout)
{: #keepalive-timeout}

配置保持活动连接在服务器端保持打开状态的时间。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
  设置保持活动连接在服务器上保持打开状态的时间。
  </dd>


<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为您针对应用程序创建的 Kubernetes 服务的名称。此参数是可选的。如果提供了此参数，那么将为给定的服务设置保持活动超时。如果未提供此参数，那么将在 <code>nginx.conf</code> 的服务器级别为所有未配置保持活动超时的服务设置保持活动超时。</td>
 </tr>
 <tr>
 <td><code>timeout</code></td>
 <td>将 <code>&lt;<em>time</em>&gt;</code> 替换为时间长度（以秒为单位）。示例：<code>timeout=20s</code>。值为零将禁用保持活动客户机连接。</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### 上游保持活动连接数 (upstream-keepalive)
{: #upstream-keepalive}

配置上游服务器的最大空闲保持活动连接数。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
 更改给定服务的上游服务器的最大空闲保持活动连接数。缺省情况下，上游服务器具有 64 个空闲保持活动连接。
  </dd>


 <dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为您针对应用程序创建的 Kubernetes 服务的名称。</td>
  </tr>
  <tr>
  <td><code>keepalive</code></td>
  <td>将 <code>&lt;<em>max_connections</em>&gt;</code> 替换为上游服务器的最大空闲保持活动连接数。缺省值为 <code>64</code>。值为 <code>0</code> 将禁用给定服务的上游保持活动连接。</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## 代理缓冲区注释
{: #proxy-buffer}


### 客户机响应数据缓冲 (proxy-buffering)
{: #proxy-buffering}

使用缓冲注释可禁止在将数据发送到客户机期间，在应用程序负载均衡器上存储响应数据。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>Ingress 应用程序负载均衡器充当后端应用程序和客户机 Web 浏览器之间的代理。当响应从后端应用程序发送到客户机时，缺省情况下会在应用程序负载均衡器上对响应数据进行缓冲。应用程序负载均衡器作为代理传递客户机响应，并开始按客户机的速度将响应发送到客户机。应用程序负载均衡器接收到来自后端应用程序的所有数据后，会关闭与后端应用程序的连接。应用程序负载均衡器与客户机的连接会保持打开状态，直到客户机接收完所有数据为止。

 

</br></br>
如果在应用程序负载均衡器上禁用响应数据缓冲，那么数据会立即从应用程序负载均衡器发送到客户机。客户机必须能够按应用程序负载均衡器的速度来处理入局数据。如果客户机速度太慢，数据可能会丢失。
</br></br>
缺省情况下，应用程序负载均衡器上启用了响应数据缓冲。</dd>
<dt>样本 Ingress 资源 YAML</dt>
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



### 代理缓冲区 (proxy-buffers)
{: #proxy-buffers}

为应用程序负载均衡器配置代理缓冲区的数目和大小。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
设置缓冲区的数目和大小，这些缓冲区用于读取来自通过代理传递的服务器的单个连接的响应。除非指定了服务，否则配置将应用于 Ingress 主机中的所有服务。例如，如果指定如 <code>serviceName=SERVICE number=2 size=1k</code> 这样的配置，那么会对该服务应用 1k。如果指定如 <code>number=2 size=1k</code> 这样的配置，那么会对 Ingress 主机中的所有服务应用 1k。</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为要应用 proxy-buffers 的服务的名称。</td>
 </tr>
 <tr>
 <td><code>number_of_buffers</code></td>
 <td>将 <code>&lt;<em>number_of_buffers</em>&gt;</code> 替换为数字，例如 <em>2</em>。</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>将 <code>&lt;<em>size</em>&gt;</code> 替换为每个缓冲区的大小（以千字节（k 或 K）为单位），例如 <em>1K</em>。</td>
 </tr>
 </tbody>
 </table>
 </dd></dl>

<br />


### 代理缓冲区大小 (proxy-buffer-size)
{: #proxy-buffer-size}

配置代理缓冲区的大小，该缓冲区用于读取响应的第一部分。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
设置缓冲区的大小，该缓冲区用于读取从通过代理传递的服务器收到的响应的第一部分。响应的这一部分通常包含小型响应头。除非指定了服务，否则配置将应用于 Ingress 主机中的所有服务。例如，如果指定如 <code>serviceName=SERVICE size=1k</code> 这样的配置，那么会对该服务应用 1k。如果指定如 <code>size=1k</code> 这样的配置，那么会对 Ingress 主机中的所有服务应用 1k。</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为要应用 proxy-buffers-size 的服务的名称。</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>将 <code>&lt;<em>size</em>&gt;</code> 替换为每个缓冲区的大小（以千字节（k 或 K）为单位），例如 <em>1K</em>。</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### 代理繁忙缓冲区大小 (proxy-busy-buffers-size)
{: #proxy-busy-buffers-size}

配置可以处于繁忙状态的代理缓冲区的大小。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
限制在尚未完全读取响应期间，向客户机发送响应的任何缓冲区的大小。在此期间，其余缓冲区可用于读取响应，并可以根据需要将响应的一部分缓冲到临时文件。除非指定了服务，否则配置将应用于 Ingress 主机中的所有服务。例如，如果指定如 <code>serviceName=SERVICE size=1k</code> 这样的配置，那么会对该服务应用 1k。如果指定如 <code>size=1k</code> 这样的配置，那么会对 Ingress 主机中的所有服务应用 1k。</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为要应用 proxy-busy-buffers-size 的服务的名称。</td>
</tr>
<tr>
<td><code>size</code></td>
<td>将 <code>&lt;<em>size</em>&gt;</code> 替换为每个缓冲区的大小（以千字节（k 或 K）为单位），例如 <em>1K</em>。</td>
</tr>
</tbody></table>

 </dd>
 </dl>

<br />



## 请求和响应注释
{: #request-response}


### 额外的客户机请求或响应头 (proxy-add-headers)
{: #proxy-add-headers}

向客户机请求添加额外的头信息，然后将该请求发送到后端应用程序，或者向客户机响应添加额外的头信息，然后将该响应发送到客户机。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>Ingress 应用程序负载均衡器充当客户机应用程序和后端应用程序之间的代理。发送到应用程序负载均衡器的客户机请求经过处理（通过代理传递）后放入新的请求中，然后将该新请求从应用程序负载均衡器发送到后端应用程序。通过代理传递请求会除去初始从客户机发送的 HTTP 头信息，例如用户名。如果后端应用程序需要这些信息，那么可以使用 <strong>ingress.bluemix.net/proxy-add-headers</strong> 注释向客户机请求添加头信息，然后将该请求从应用程序负载均衡器转发到后端应用程序。


</br></br>
后端应用程序向客户机发送响应时，将由应用程序负载均衡器作为代理传递响应，并且会从响应中除去 HTTP 头。客户机 Web 应用程序可能需要此头信息才能成功处理响应。可以使用 <strong>ingress.bluemix.net/response-add-headers</strong> 注释向客户机响应添加头信息，然后将该响应从应用程序负载均衡器转发到客户机 Web 应用程序。
</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>service_name</code></td>
  <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为您针对应用程序创建的 Kubernetes 服务的名称。</td>
  </tr>
  <tr>
  <td><code>&lt;header&gt;</code></td>
  <td>要添加到客户机请求或客户机响应的头信息的键。</td>
  </tr>
  <tr>
  <td><code>&lt;value&gt;</code></td>
  <td>要添加到客户机请求或客户机响应的头信息的值。</td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />



### 除去客户机响应头 (response-remove-headers)
{: #response-remove-headers}

除去后端应用程序的客户机响应中包含的头信息，然后将该响应发送到客户机。
{:shortdesc}

 <dl>
 <dt>描述</dt>
 <dd>Ingress 应用程序负载均衡器充当后端应用程序和客户机 Web 浏览器之间的代理。发送到应用程序负载均衡器的来自后端应用程序的客户机响应经过处理（通过代理传递）后放入新的响应中，然后将该新响应从应用程序负载均衡器发送到客户机 Web 浏览器。尽管通过代理传递响应会除去初始从后端应用程序发送的 HTTP 头信息，但此过程可能不会除去所有特定于后端应用程序的头。从客户机响应中除去头信息，然后将该响应从应用程序负载均衡器转发到客户机 Web 浏览器。</dd>
 <dt>样本 Ingress 资源 YAML</dt>
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
   <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
   </thead>
   <tbody>
   <tr>
   <td><code>service_name</code></td>
   <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为您针对应用程序创建的 Kubernetes 服务的名称。</td>
   </tr>
   <tr>
   <td><code>&lt;header&gt;</code></td>
   <td>要从客户机响应中除去的头的键。</td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


### 定制最大客户机请求主体大小 (client-max-body-size)
{: #client-max-body-size}

调整客户机可以作为请求一部分发送的主体的最大大小。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>为了保持期望的性能，最大客户机请求主体大小设置为 1 兆字节。将主体大小超出此限制的客户机请求发送到 Ingress 应用程序负载均衡器，并且客户机不允许拆分数据时，应用程序负载均衡器会向客户机返回 413（请求实体太大）HTTP 响应。除非减小请求主体的大小，否则无法在客户机和应用程序负载均衡器之间建立连接。当客户机允许数据拆分为多个区块时，数据将分成 1 兆字节的包并发送到应用程序负载均衡器。


</br></br>
您可能希望增大最大主体大小，因为您预期客户机请求的主体大小大于 1 兆字节。例如，您希望客户机能够上传大型文件。增大最大请求主体大小可能会影响应用程序负载均衡器的性能，因为与客户机的连接必须保持打开状态，直到接收完请求为止。
</br></br>
<strong>注</strong>：某些客户机 Web 浏览器无法正确显示 413 HTTP 响应消息。</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>客户机响应主体的最大大小。例如，要将其设置为 200 兆字节，请定义 <code>200m</code>。

  <strong>注</strong>：可以将大小设置为 0 以禁止检查客户机请求主体大小。</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



## 服务限制注释
{: #service-limit}


### 全局速率限制 (global-rate-limit)
{: #global-rate-limit}

对于所有服务，按定义的键限制请求处理速率和连接数。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
对于所有服务，按定义的键限制来自所选后端中所有路径的单个 IP 地址的请求处理速率和连接数。
</dd>


 <dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>key</code></td>
  <td>要基于位置或服务来设置入局请求的全局限制，请使用 `key=location`。要基于头来设置入局请求的全局限制，请使用 `X-USER-ID key==$http_x_user_id`。</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>将 <code>&lt;<em>rate</em>&gt;</code> 替换为处理速率。输入以每秒速率 (r/s) 或每分钟速率 (r/m) 为单位的值。示例：<code>50r/m</code>。</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>将 <code>&lt;<em>conn</em>&gt;</code> 替换为连接数。</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

<br />



### 服务速率限制 (service-rate-limit)
{: #service-rate-limit}

限制特定服务的请求处理速率和连接数。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>对于特定服务，按定义的键限制来自所选后端中所有路径的单个 IP 地址的请求处理速率和连接数。
</dd>


 <dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为要限制其处理速率的服务的名称。</li>
  </tr>
  <tr>
  <td><code>key</code></td>
  <td>要基于位置或服务来设置入局请求的全局限制，请使用 `key=location`。要基于头来设置入局请求的全局限制，请使用 `X-USER-ID key==$http_x_user_id`。</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>将 <code>&lt;<em>rate</em>&gt;</code> 替换为处理速率。要定义每秒速率，请使用 r/s：<code>10r/s</code>。要定义每分钟速率，请使用 r/m：<code>50r/m</code>。</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>将 <code>&lt;<em>conn</em>&gt;</code> 替换为连接数。</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />



## HTTPS 和 TLS/SSL 认证注释
{: #https-auth}


### 定制 HTTP 和 HTTPS 端口 (custom-port)
{: #custom-port}

更改 HTTP（端口 80）和 HTTPS（端口 443）网络流量的缺省端口。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>缺省情况下，Ingress 应用程序负载均衡器配置为在端口 80 上侦听入局 HTTP 网络流量，在端口 443 上侦听入局 HTTPS 网络流量。您可以更改缺省端口以向应用程序负载均衡器域添加安全性，或仅启用 HTTPS 端口。
</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;protocol&gt;</code></td>
 <td>输入 <strong>http</strong> 或 <strong>https</strong> 以更改入局 HTTP 或 HTTPS 网络流量的缺省端口。</td>
 </tr>
 <tr>
 <td><code>&lt;port&gt;</code></td>
 <td>输入要用于入局 HTTP 或 HTTPS 网络流量的端口号。<p><strong>注：</strong>当为 HTTP 或 HTTPS 指定定制端口时，缺省端口对于 HTTP 和 HTTPS 都不再有效。例如，要将 HTTPS 的缺省端口更改为 8443，而对 HTTP 使用缺省端口，那么必须为两者设置定制端口：<code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>。</p></td>
 </tr>
 </tbody></table>

 </dd>
 <dt>用法</dt>
 <dd><ol><li>查看应用程序负载均衡器的打开端口。
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 输出类似于以下内容：
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>打开 Ingress 控制器配置映射。
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>将非缺省 HTTP 和 HTTPS 端口添加到配置映射。将 &lt;port&gt; 替换为要打开的 HTTP 或 HTTPS 端口。
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
 <li>验证是否使用非缺省端口重新配置了您的 Ingress 控制器。
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
CLI 输出类似于以下内容：
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>配置 Ingress 以在将入局网络流量路由到服务时使用非缺省端口。在此引用中使用样本 YAML 文件。</li>
<li>更新 Ingress 控制器配置。
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>打开首选 Web 浏览器以访问您的应用程序。示例：<code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>

<br />



### HTTP 重定向到 HTTPS (redirect-to-https)
{: #redirect-to-https}

将不安全的 HTTP 客户机请求转换为 HTTPS。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>将 Ingress 应用程序负载均衡器设置为通过 IBM 提供的 TLS 证书或您的定制 TLS 证书来保护域。某些用户可能会尝试向您的应用程序负载均衡器域发出不安全的 HTTP 请求（例如 <code>http://www.myingress.com</code>，而不是使用 <code>https</code>）来访问您的应用程序。可以使用重定向注释始终将不安全的 HTTP 请求转换为 HTTPS。如果不使用此注释，缺省情况下，不安全的 HTTP 请求不会转换为 HTTPS 请求，并且可能会向公众公开未加密的保密信息。

 

</br></br>
缺省情况下，HTTP 请求到 HTTPS 的重定向是禁用的。</dd>

<dt>样本 Ingress 资源 YAML</dt>
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



### 相互认证 (mutual-auth)
{: #mutual-auth}

为应用程序负载均衡器配置相互认证。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
为 Ingress 应用程序负载均衡器配置相互认证。
客户机会认证服务器，而服务器也会使用证书来认证客户机。相互认证也称为基于证书的认证或双向认证。
 </dd>

<dt>先决条件</dt>
<dd>
<ul>
<li>[您必须具有包含所需认证中心 (CA) 的有效私钥](cs_app.html#secrets)。此外，还需要 <code>client.key</code> 和 <code>client.crt</code> 才能通过相互认证进行认证。</li>
<li>要在非 443 端口上启用相互认证，请[配置负载均衡器以打开有效端口](cs_ingress.html#opening_ingress_ports)。</li>
</ul>
</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
          servicePort: 8080</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>secretName</code></td>
<td>将 <code>&lt;<em>mysecret</em>&gt;</code> 替换为私钥资源的名称。</td>
</tr>
<tr>
<td><code>&lt;port&gt;</code></td>
<td>应用程序负载均衡器端口号。</td>
</tr>
<tr>
<td><code>&lt;serviceName&gt;</code></td>
<td>一个或多个 Ingress 资源的名称。此参数是可选的。</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### SSL 服务支持 (ssl-services)
{: #ssl-services}

允许对上游应用程序进行 HTTPS 请求，并对流入上游应用程序的流量加密。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
使用应用程序负载均衡器来加密流入需要 HTTPS 的上游应用程序的流量。



**可选**：可以向此注释添加[单向认证或相互认证](#ssl-services-auth)。
</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为表示应用程序的服务的名称。将加密从应用程序负载均衡器流入此应用程序的流量。</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>将 <code>&lt;<em>service-ssl-secret</em>&gt;</code> 替换为服务的私钥。此参数是可选的。如果提供了该参数，那么值必须包含应用程序期望从客户机收到的密钥和证书。</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


#### 使用认证的 SSL 服务支持
{: #ssl-services-auth}

允许向上游应用程序发出 HTTPS 请求，以及使用单向认证或相互认证加密流入上游应用程序的流量，以实现额外的安全性。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
配置相互认证，以使用 Ingress 控制器对需要 HTTPS 的应用程序进行负载均衡。



**注**：开始之前，请[将证书和密钥转换为 base-64 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://www.base64encode.org/)。

</dd>


<dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>将 <code>&lt;<em>myservice</em>&gt;</code> 替换为表示应用程序的服务的名称。将加密从应用程序负载均衡器流入此应用程序的流量。</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>将 <code>&lt;<em>service-ssl-secret</em>&gt;</code> 替换为服务的私钥。此参数是可选的。如果提供了该参数，那么值必须包含应用程序期望从客户机收到的密钥和证书。</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>


<br />



