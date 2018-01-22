---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-01"

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

有关 Ingress 服务以及有关如何开始使用这些服务的常规信息，请参阅[使用 Ingress 来配置对应用程序的公共访问权](cs_apps.html#cs_apps_public_ingress)。


|支持的注释|描述|
|--------------------|-----------|
|[额外的客户机请求或响应头](#proxy-add-headers)|向客户机请求添加头信息，然后将该请求转发到后端应用程序，或者向客户机响应添加头信息，然后将该响应发送到客户机。|
|[客户机响应数据缓冲](#proxy-buffering)|禁用在向客户机发送响应时应用程序负载均衡器上的客户机响应缓冲。|
|[除去客户机响应头](#response-remove-headers)|从客户机响应中除去头信息，然后将该响应转发到客户机。|
|[定制连接超时和读取超时](#proxy-connect-timeout)|调整应用程序负载均衡器等待连接到后端应用程序以及从后端应用程序进行读取的时间，超过该时间后，后端应用程序将视为不可用。|
|[定制 HTTP 和 HTTPS 端口](#custom-port)|更改 HTTP 和 HTTPS 网络流量的缺省端口。|
|[定制最大客户机请求主体大小](#client-max-body-size)|调整允许发送到应用程序负载均衡器的客户机请求主体的大小。|
|[外部服务](#proxy-external-service)|添加外部服务（例如，{{site.data.keyword.Bluemix_notm}} 中托管的服务）的路径定义。|
|[全局速率限制](#global-rate-limit)|对于所有服务，按定义的键限制请求处理速率和连接。|
|[HTTP 重定向到 HTTPS](#redirect-to-https)|将域上的不安全的 HTTP 请求重定向到 HTTPS。|
|[保持活动请求数](#keepalive-requests)|配置可通过一个保持活动连接处理的最大请求数。|
|[保持活动超时](#keepalive-timeout)|配置保持活动连接在服务器上保持打开状态的时间。|
|[相互认证](#mutual-auth)|为应用程序负载均衡器配置相互认证。|
|[专用应用程序负载均衡器路由](#alb-id)|将入局请求路由到具有专用应用程序负载均衡器的应用程序。|
|[代理缓冲区数](#proxy-buffers)|设置缓冲区的数目和大小，这些缓冲区用于读取来自通过代理传递的服务器的单个连接的响应。|
|[代理繁忙缓冲区大小](#proxy-busy-buffers-size)|限制在尚未完全读取响应期间，可忙于向客户机发送响应的缓冲区的总大小。|
|[代理缓冲区大小](#proxy-buffer-size)|设置缓冲区的大小，该缓冲区用于读取从通过代理传递的服务器收到的响应的第一部分。|
|[重写路径](#rewrite-path)|将入局网络流量路由到后端应用程序侦听的其他路径。|
|[使用 cookie 确保会话亲缘关系](#sticky-cookie-services)|使用粘性 cookie 始终将入局网络流量路由到同一个上游服务器。|
|[服务速率限制](#service-rate-limit)|对于特定服务，按定义的键限制请求处理速率和连接。|
|[SSL 服务支持](#ssl-services)|允许支持 SSL 服务以进行负载均衡。|
|[TCP 端口](#tcp-ports)|通过非标准 TCP 端口访问应用程序。|
|[上游保持活动连接数](#upstream-keepalive)|配置上游服务器的最大空闲保持活动连接数。|



## 额外的客户机请求或响应头 (proxy-add-headers)
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;service_name&gt;</em></code>：针对您应用程序创建的 Kubernetes 服务的名称。</li>
  <li><code><em>&lt;header&gt;</em></code>：要添加到客户机请求或客户机响应的头信息的键。</li>
  <li><code><em>&lt;value&gt;</em></code>：要添加到客户机请求或客户机响应的头信息的值。</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## 客户机响应数据缓冲 (proxy-buffering)
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


 ## 除去客户机响应头 (response-remove-headers)
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
   <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>替换以下值：<ul>
   <li><code><em>&lt;service_name&gt;</em></code>：针对您应用程序创建的 Kubernetes 服务的名称。</li>
   <li><code><em>&lt;header&gt;</em></code>：要从客户机响应中除去的头的键。</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## 定制连接超时和读取超时（proxy-connect-timeout 和 proxy-read-timeout）
{: #proxy-connect-timeout}

为应用程序负载均衡器设置定制连接超时和读取超时。调整应用程序负载均衡器等待连接到后端应用程序以及从后端应用程序进行读取的时间，在超过该时间后，后端应用程序将视为不可用。
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
 <td><code>annotations</code></td>
 <td>替换以下值：<ul><li><code><em>&lt;connect_timeout&gt;</em></code>：输入等待连接到后端应用程序的秒数，例如 <strong>65s</strong>。

  </br></br>
 <strong>注</strong>：连接超时不能超过 75 秒。</li><li><code><em>&lt;read_timeout&gt;</em></code>：输入读取后端应用程序前等待的秒数，例如 <strong>65s</strong>。</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## 定制 HTTP 和 HTTPS 端口 (custom-port)
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
 <td><code>annotations</code></td>
 <td>替换以下值：<ul>
 <li><code><em>&lt;protocol&gt;</em></code>：输入 <strong>http</strong> 或 <strong>https</strong> 以更改入局 HTTP 或 HTTPS 网络流量的缺省端口。</li>
 <li><code><em>&lt;port&gt;</em></code>：输入要用于入局 HTTP 或 HTTPS 网络流量的端口号。</li>
 </ul>
 <p><strong>注：</strong>当为 HTTP 或 HTTPS 指定定制端口时，缺省端口对于 HTTP 和 HTTPS 都不再有效。例如，要将 HTTPS 的缺省端口更改为 8443，而对 HTTP 使用缺省端口，那么必须为两者设置定制端口：<code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>。</p>
 </td>
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


## 定制最大客户机请求主体大小 (client-max-body-size)
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>替换以下值：<ul>
 <li><code><em>&lt;size&gt;</em></code>：输入客户机响应主体的最大大小。例如，要将其设置为 200 兆字节，请定义 <strong>200m</strong>。

  </br></br>
 <strong>注</strong>：可以将大小设置为 0 以禁止检查客户机请求主体大小。</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<返回到此处>

## 外部服务 (proxy-external-service)
{: #proxy-external-service}
添加外部服务（例如，{{site.data.keyword.Bluemix_notm}} 中托管的服务）的路径定义。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>添加外部服务的路径定义。此注释用于特殊情况，因为它对后端服务不起作用，只对外部服务有效。外部服务路径不支持除 client-max-body-size、proxy-read-timeout、proxy-connect-timeout 和 proxy-buffering 以外的其他注释。</dd>
<dt>样本 Ingress 资源 YAML</dt>
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
 <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>替换以下值：<ul>
 <li><code><em>&lt;external_service&gt;</em></code>：输入要调用的外部服务。例如，https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net。</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## 全局速率限制 (global-rate-limit)
{: #global-rate-limit}

对于所有服务，按定义的键限制来自 Ingress 映射中所有主机的单个 IP 地址的请求处理速率和连接数。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
为了设置限制，区域将由 `ngx_http_limit_conn_module` 和 `ngx_http_limit_req_module` 定义。这些区域将在与 Ingress 映射中的每个主机相对应的服务器块中应用。</dd>


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
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;key&gt;</em></code>：要基于位置或服务来设置入局请求的全局限制，请使用 `key=location`。要基于头来设置入局请求的全局限制，请使用 `X-USER-ID key==$http_x_user_id`。</li>
  <li><code><em>&lt;rate&gt;</em></code>：速率。</li>
  <li><code><em>&lt;conn&gt;</em></code>：连接数。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## HTTP 重定向到 HTTPS (redirect-to-https)
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




 <br />


 ## 保持活动请求数 (keepalive-requests)
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：将 <em>&lt;serviceName&gt;</em> 替换为您针对应用程序创建的 Kubernetes 服务的名称。此参数是可选的。除非指定了服务，否则配置将应用于 Ingress 主机中的所有服务。如果提供了此参数，那么将为给定的服务设置保持活动请求数。如果未提供此参数，那么将在 <code>nginx.conf</code> 的服务器级别为所有未配置保持活动请求数的服务设置保持活动请求数。</li>
  <li><code><em>&lt;requests&gt;</em></code>：将 <em>&lt;max_requests&gt;</em> 替换为可通过一个保持活动连接处理的最大请求数。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## 保持活动超时 (keepalive-timeout)
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
   <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>替换以下值：<ul>
   <li><code><em>&lt;serviceName&gt;</em></code>：将 <em>&lt;serviceName&gt;</em> 替换为您针对应用程序创建的 Kubernetes 服务的名称。此参数是可选的。如果提供了此参数，那么将为给定的服务设置保持活动超时。如果未提供此参数，那么将在 <code>nginx.conf</code> 的服务器级别为所有未配置保持活动超时的服务设置保持活动超时。</li>
   <li><code><em>&lt;timeout&gt;</em></code>：将 <em>&lt;time&gt;</em> 替换为时间长度（以秒为单位）。示例：<code><em>timeout=20s</em></code>。值为零将禁用保持活动客户机连接。</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## 相互认证 (mutual-auth)
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
 <li>[您必须具有包含所需认证中心 (CA) 的有效私钥](cs_apps.html#secrets)。此外，还需要 <code>client.key</code> 和 <code>client.crt</code> 才能通过相互认证进行认证。</li>
 <li>要在非 443 端口上启用相互认证，请[配置负载均衡器以打开有效端口](cs_apps.html#opening_ingress_ports)。</li>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：一个或多个 Ingress 资源的名称。此参数是可选的。</li>
  <li><code><em>&lt;secretName&gt;</em></code>：将 <em>&lt;secret_name&gt;</em> 替换为私钥资源的名称。</li>
  <li><code><em>&lt;port&gt;</em></code>：输入端口号。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


## 专用应用程序负载均衡器路由 (ALB-ID)
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
  <td><code>annotations</code></td>
  <td>将 <em>&lt;private_ALB_ID&gt;</em> 替换为专用应用程序负载均衡器的标识。运行 <code>bx cs albs --cluster <my_cluster></code> 以查找应用程序负载均衡器标识。</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


 ## 代理缓冲区 (proxy-buffers)
 {: #proxy-buffers}

 为应用程序负载均衡器配置代理缓冲区。
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;secretName&gt;</em></code>：将 <em>&lt;serviceName&gt;</em> 替换为要应用 proxy-buffers 的服务的名称。</li>
  <li><code><em>&lt;number_of_buffers&gt;</em></code>：将 <em>&lt;number_of_buffers&gt;</em> 替换为数字，例如 <em>2</em>。</li>
  <li><code><em>&lt;size&gt;</em></code>：输入每个缓冲区的大小（以千字节（k 或 K）为单位），例如 <em>1K</em>。</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## 代理繁忙缓冲区大小 (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 为应用程序负载均衡器配置代理繁忙缓冲区大小。
{:shortdesc}

 <dl>
 <dt>描述</dt>
 <dd>
对来自通过代理传递的服务器的响应启用了缓冲时，限制在尚未完全读取响应期间，可忙于向客户机发送响应的缓冲区的总大小。在此期间，其余的缓冲区可用于读取响应，并可以根据需要将响应的一部分缓冲到临时文件。除非指定了服务，否则配置将应用于 Ingress 主机中的所有服务。例如，如果指定如 <code>serviceName=SERVICE size=1k</code> 这样的配置，那么会对该服务应用 1k。如果指定如 <code>size=1k</code> 这样的配置，那么会对 Ingress 主机中的所有服务应用 1k。</dd>


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
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;secretName&gt;</em></code>：将 <em>&lt;serviceName&gt;</em> 替换为要应用 proxy-busy-buffers-size 的服务的名称。</li>
  <li><code><em>&lt;size&gt;</em></code>：输入每个缓冲区的大小（以千字节（k 或 K）为单位），例如 <em>1K</em>。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## 代理缓冲区大小 (proxy-buffer-size)
 {: #proxy-buffer-size}

 为应用程序负载均衡器配置代理缓冲区大小。
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;secretName&gt;</em></code>：将 <em>&lt;serviceName&gt;</em> 替换为要应用 proxy-busy-buffers-size 的服务的名称。</li>
  <li><code><em>&lt;size&gt;</em></code>：输入每个缓冲区的大小（以千字节（k 或 K）为单位），例如 <em>1K</em>。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## 重写路径 (rewrite-path)
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
<th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>将 <em>&lt;service_name&gt;</em> 替换为您针对应用程序创建的 Kubernetes 服务的名称，将 <em>&lt;target-path&gt;</em> 替换为应用程序侦听的路径。应用程序负载均衡器域上的入局网络流量会使用此路径转发到 Kubernetes 服务。大多数应用程序不会侦听特定路径，而是使用根路径和特定端口。在本例中，将 <code>/</code> 定义为应用程序的 <em>rewrite-path</em>。</td>
</tr>
<tr>
<td><code>path</code></td>
<td>将 <em>&lt;domain_path&gt;</em> 替换为要附加到应用程序负载均衡器域的路径。此路径上的入局网络流量会转发到在注释中定义的重写路径。在上述示例中，将域路径设置为 <code>/beans</code> 以在 Ingress 控制器的负载均衡中包含此路径。</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>将 <em>&lt;service_name&gt;</em> 替换为您针对应用程序创建的 Kubernetes 服务的名称。此处使用的服务名称必须与在注释中定义的名称相同。</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>将 <em>&lt;service_port&gt;</em> 替换为服务侦听的端口。</td>
</tr></tbody></table>

</dd></dl>

<br />


## 服务速率限制 (service-rate-limit)
{: #service-rate-limit}

对于特定服务，按定义的键限制来自所选后端中所有路径的单个 IP 地址的请求处理速率和连接数。
{:shortdesc}

<dl>
<dt>描述</dt>
<dd>
为了设置限制，将应用在对应于 Ingress 映射中注释内设定为目标的所有服务的所有位置块中，由 `ngx_http_limit_conn_module` 和 `ngx_http_limit_req_module` 定义的区域。</dd>


 <dt>样本 Ingress 资源 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>：Ingress 资源的名称。</li>
  <li><code><em>&lt;key&gt;</em></code>：要基于位置或服务来设置入局请求的全局限制，请使用 `key=location`。要基于头来设置入局请求的全局限制，请使用 `X-USER-ID key==$http_x_user_id`。</li>
  <li><code><em>&lt;rate&gt;</em></code>：速率。</li>
  <li><code><em>&lt;conn&gt;</em></code>：连接数。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## 使用 cookie 确保会话亲缘关系 (sticky-cookie-services)
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
  <caption>了解 YAML 文件的组成部分</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;service_name&gt;</em></code>：针对您应用程序创建的 Kubernetes 服务的名称。</li>
  <li><code><em>&lt;cookie_name&gt;</em></code>：选择在会话期间创建的粘性 cookie 的名称。</li>
  <li><code><em>&lt;expiration_time&gt;</em></code>：距离粘性 cookie 到期的时间（以秒、分钟或小时为单位）。此时间与用户活动无关。该 cookie 到期后，会被客户机 Web 浏览器删除，并且不会再发送到应用程序负载均衡器。例如，要将到期时间设置为 1 秒、1 分钟或 1 小时，请输入 <strong>1s</strong>、<strong>1m</strong> 或 <strong>1h</strong>。</li>
  <li><code><em>&lt;cookie_path&gt;</em></code>：附加到 Ingress 子域的路径，该路径指示将 cookie 发送到应用程序负载均衡器的哪些域和子域。例如，如果 Ingress 域为 <code>www.myingress.com</code>，并且您希望在每个客户机请求中都发送 cookie，那么必须设置 <code>path=/</code>。如果希望仅针对 <code>www.myingress.com/myapp</code> 及其所有子域发送 cookie，那么必须设置 <code>path=/myapp</code>。</li>
  <li><code><em>&lt;hash_algorithm&gt;</em></code>：用于保护 cookie 中信息的散列算法。仅支持 <code>sha1</code>。SHA1 基于 cookie 中的信息创建散列总和，并将此散列总和附加到 cookie。服务器可以解密 cookie 中的信息并验证数据完整性。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## SSL 服务支持 (ssl-services)
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>将 <em>&lt;myingressname&gt;</em> 替换为 Ingress 资源的名称。</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;myservice&gt;</em></code>：输入表示应用程序的服务的名称。将加密从应用程序负载均衡器流入此应用程序的流量。</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code>：输入服务的私钥。此参数是可选的。如果提供了该参数，那么值必须包含应用程序期望从客户机收到的密钥和证书。</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td>将 <em>&lt;ibmdomain&gt;</em> 替换为 IBM 提供的 <strong>Ingress 子域</strong>名称。
  <br><br>
  <strong>注：</strong>为了避免创建 Ingress 期间发生失败，不要使用 * 表示主机，也不要将主机属性保留为空。</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>将 <em>&lt;myservicepath&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

  </br>
        对于每个 Kubernetes 服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径，例如 <code>ingress_domain/myservicepath1</code>。在 Web 浏览器中输入此路径时，网络流量会路由到应用程序负载均衡器。应用程序负载均衡器会查找关联的服务，将网络流量发送到该服务，然后使用相同路径发送到运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。</br></br>
许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
        </br>
  示例：<ul><li>对于 <code>http://ingress_host_name/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://ingress_host_name/myservicepath</code>，请输入 <code>/myservicepath</code> 作为路径。</li></ul>
  </br>
  <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 <a href="#rewrite-path" target="_blank">rewrite 注释</a>来建立到应用程序的正确路由。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>将 <em>&lt;myservice&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### 使用认证的 SSL 服务支持
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>将 <em>&lt;myingressname&gt;</em> 替换为 Ingress 资源的名称。</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;service&gt;</em></code>：输入服务的名称。</li>
  <li><code><em>&lt;service-ssl-secret&gt;</em></code>：输入服务的私钥。</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td>将 <em>&lt;ibmdomain&gt;</em> 替换为 IBM 提供的 <strong>Ingress 子域</strong>名称。
  <br><br>
  <strong>注：</strong>为了避免创建 Ingress 期间发生失败，不要使用 * 表示主机，也不要将主机属性保留为空。</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td>将 <em>&lt;secret_name&gt;</em> 替换为用于保存证书和密钥（用于相互认证）的私钥的名称。
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>将 <em>&lt;myservicepath&gt;</em> 替换为斜杠或应用程序正在侦听的唯一路径，以便可以将网络流量转发到应用程序。

  </br>
        对于每个 Kubernetes 服务，可以定义附加到 IBM 提供的域的单独路径，以创建应用程序的唯一路径，例如 <code>ingress_domain/myservicepath1</code>。在 Web 浏览器中输入此路径时，网络流量会路由到应用程序负载均衡器。应用程序负载均衡器会查找关联的服务，将网络流量发送到该服务，然后使用相同路径发送到运行应用程序的 pod。应用程序必须设置为侦听此路径，才能接收入局网络流量。</br></br>
        许多应用程序不会侦听特定路径，而是使用根路径和特定端口。在这种情况下，请将根路径定义为 <code>/</code>，并且不要为应用程序指定单独的路径。
        </br>
  示例：<ul><li>对于 <code>http://ingress_host_name/</code>，请输入 <code>/</code> 作为路径。</li><li>对于 <code>http://ingress_host_name/myservicepath</code>，请输入 <code>/myservicepath</code> 作为路径。</li></ul>
  </br>
  <strong>提示</strong>：要将 Ingress 配置为侦听与应用程序所侦听的路径不同的路径，可以使用 <a href="#rewrite-path" target="_blank">rewrite 注释</a>来建立到应用程序的正确路由。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>将 <em>&lt;myservice&gt;</em> 替换为针对应用程序创建 Kubernetes 服务时使用的服务的名称。</td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>服务侦听的端口。使用针对应用程序创建 Kubernetes 服务时定义的端口。</td>
  </tr>
  </tbody></table>

  </dd>



<dt>单向认证的样本私钥 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>将 <em>&lt;secret_name&gt;</em> 替换为私钥资源的名称。</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>：输入可信证书的名称。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>相互认证的样本私钥 YAML</dt>
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>将 <em>&lt;secret_name&gt;</em> 替换为私钥资源的名称。</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>：输入可信证书的名称。</li>
  <li><code><em>&lt;client_certificate_name&gt;</em></code>：输入客户机证书的名称。</li>
  <li><code><em>&lt;certificate_key&gt;</em></code>：输入客户机证书的密钥。</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## 用于应用程序负载均衡器的 TCP 端口 (tcp-ports)
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
  <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>替换以下值：<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code>：要用于访问应用程序的 TCP 端口。</li>
  <li><code><em>&lt;serviceName&gt;</em></code>：要通过非标准 TCP 端口访问的 Kubernetes 服务的名称。</li>
  <li><code><em>&lt;servicePort&gt;</em></code>：此参数是可选的。如果提供了此参数，那么在将流量发送到后端应用程序之前，会将端口替换为此值。否则，该端口与 Ingress 端口保持相同。</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## 上游保持活动连接数 (upstream-keepalive)
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
    <th colspan=2><img src="images/idea.png" alt="“构想”图标"/> 了解 YAML 文件的组成部分</th>
    </thead>
    <tbody>
    <tr>
    <td><code>annotations</code></td>
    <td>替换以下值：<ul>
    <li><code><em>&lt;serviceName&gt;</em></code>：将 <em>&lt;serviceName&gt;</em> 替换为您针对应用程序创建的 Kubernetes 服务的名称。</li>
    <li><code><em>&lt;keepalive&gt;</em></code>：将 <em>&lt;max_connections&gt;</em> 替换为上游服务器的最大空闲保持活动连接数。缺省值为 64。值为零将禁用给定服务的上游保持活动连接。</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>
