---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Anotaciones de Ingress
{: #ingress_annotation}

Para añadir prestaciones al equilibrador de carga de aplicación, especifique anotaciones como metadatos en un recurso Ingress.
{: shortdesc}

Para obtener información general sobre los servicios de Ingress y cómo empezar a utilizarlos, consulte [Configuración de acceso público a una app utilizando Ingress](cs_ingress.html#config).

<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th colspan=3>Anotaciones generales</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-external-service">Servicios externos</a></td>
 <td><code>proxy-external-service</code></td>
 <td>Añada definiciones de vía de acceso a servicios externos, como un servicio alojado en {{site.data.keyword.Bluemix_notm}}.</td>
 </tr>
 <tr>
 <td><a href="#alb-id">Direccionamiento del equilibrador de carga de aplicación privado</a></td>
 <td><code>ALB-ID</code></td>
 <td>Direccione las solicitudes entrantes a sus apps con un equilibrador de carga de aplicación privado.</td>
 </tr>
 <tr>
 <td><a href="#rewrite-path">Vías de acceso de reescritura</a></td>
 <td><code>rewrite-path</code></td>
 <td>Se direcciona el tráfico de red entrante a una vía de acceso distinta de aquella en la que escucha la app de fondo.</td>
 </tr>
 <tr>
 <td><a href="#sticky-cookie-services">Afinidad de sesión con cookies</a></td>
 <td><code>sticky-cookie-services</code></td>
 <td>El tráfico de red de entrada siempre se direcciona al mismo servidor en sentido ascendente mediante una "sticky cookie".</td>
 </tr>
 <tr>
 <td><a href="#tcp-ports">Puertos TCP</a></td>
 <td><code>tcp-ports</code></td>
 <td>Acceda a una app a través de un puerto TCP no estándar.</td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
  <th colspan=3>Anotaciones de conexión</th>
  </thead>
  <tbody>
  <tr>
  <td><a href="#proxy-connect-timeout">Tiempos de espera excedidos de conexión y tiempos de espera excedidos de lectura personalizados</a></td>
  <td><code>proxy-connect-timeout</code></td>
  <td>Ajusta el tiempo que el equilibrador de carga de aplicación espera para conectarse a la app de fondo y para leer información de la misma antes de considerar que la app de fondo no está disponible.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-requests">Solicitudes de estado activo</a></td>
  <td><code>keepalive-requests</code></td>
  <td>Configure el número máximo de solicitudes que se pueden servir a través de una conexión en estado activo.</td>
  </tr>
  <tr>
  <td><a href="#keepalive-timeout">Tiempo de espera en estado activo</a></td>
  <td><code>keepalive-timeout</code></td>
  <td>Configure el tiempo que se mantiene abierta una conexión en estado activo en el servidor.</td>
  </tr>
  <tr>
  <td><a href="#upstream-keepalive">Estado activo en sentido ascendente</a></td>
  <td><code>upstream-keepalive</code></td>
  <td>Configure el número máximo de conexiones de estado activo en sentido ascendente para un servidor en sentido ascendente.</td>
  </tr>
  </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
 <thead>
 <th colspan=3>Anotaciones de almacenamiento intermedio de proxy</th>
 </thead>
 <tbody>
 <tr>
 <td><a href="#proxy-buffering">Colocación en almacenamiento intermedio de datos de respuesta del cliente</a></td>
 <td><code>proxy-buffering</code></td>
 <td>Inhabilita la colocación en almacenamiento intermedio de una respuesta del cliente en el equilibrador de carga de aplicación al enviar la respuesta al cliente.</td>
 </tr>
 <tr>
 <td><a href="#proxy-buffers">Almacenamientos intermedios de proxy</a></td>
 <td><code>proxy-buffers</code></td>
 <td> Establece el número y el tamaño de los almacenamientos intermedios que leen una respuesta de una única conexión desde el servidor mediante proxy. </td>
 </tr>
 <tr>
 <td><a href="#proxy-buffer-size">Tamaño de almacenamiento intermedio de proxy</a></td>
 <td><code>proxy-buffer-size</code></td>
 <td>Establezca el tamaño del almacenamiento intermedio que lee la primera parte de la respuesta que se recibe del servidor proxy.</td>
 </tr>
 <tr>
 <td><a href="#proxy-busy-buffers-size">Tamaño de los almacenamientos intermedios ocupados del proxy</a></td>
 <td><code>proxy-busy-buffers-size</code></td>
 <td>Establezca el tamaño de los almacenamientos intermedios de proxy que puedan estar ocupados. </td>
 </tr>
 </tbody></table>


<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Anotaciones de solicitud y respuesta</th>
</thead>
<tbody>
<tr>
<td><a href="#proxy-add-headers">Solicitud de cliente o cabecera de respuesta adicional</a></td>
<td><code>proxy-add-headers</code></td>
<td>Añade información de cabecera a una solicitud de cliente antes de reenviar la solicitud a la app de fondo, o añade una respuesta del cliente antes de enviar la respuesta al cliente.</td>
</tr>
<tr>
<td><a href="#response-remove-headers">Eliminación de cabecera de respuesta del cliente</a></td>
<td><code>response-remove-headers</code></td>
<td>Elimina la información de cabecera de una respuesta del cliente antes de reenviar la respuesta al cliente.</td>
</tr>
<tr>
<td><a href="#client-max-body-size">Tamaño máximo personalizado de cuerpo de solicitud del cliente</a></td>
<td><code>client-max-body-size</code></td>
<td>Ajusta el tamaño del cuerpo de la solicitud del cliente que se puede enviar al equilibrador de carga de aplicación.</td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Anotaciones de límite de servicio</th>
</thead>
<tbody>
<tr>
<td><a href="#global-rate-limit">Límites de velocidad global</a></td>
<td><code>global-rate-limit</code></td>
<td>Limite la velocidad de procesamiento de solicitudes y el número de conexiones por una clave definida para todos los servicios. </td>
</tr>
<tr>
<td><a href="#service-rate-limit">Límites de velocidad de servicio</a></td>
<td><code>service-rate-limit</code></td>
<td>Limite la velocidad de procesamiento de solicitudes y el número de conexiones por una clave definida para servicios específicos. </td>
</tr>
</tbody></table>

<table>
<col width="20%">
<col width="20%">
<col width="60%">
<thead>
<th colspan=3>Anotaciones de autenticación TLS/SSL y HTTPS</th>
</thead>
<tbody>
<tr>
<td><a href="#custom-port">Puertos HTTP y HTTPS personalizados</a></td>
<td><code>custom-port</code></td>
<td>Cambie los puertos predeterminados para el tráfico de red HTTP (puerto 80) y HTTPS (puerto 443).</td>
</tr>
<tr>
<td><a href="#redirect-to-https">HTTP redirige a HTTPS</a></td>
<td><code>redirect-to-https</code></td>
<td>Redirige las solicitudes HTTP no seguras del dominio a HTTPS.</td>
</tr>
<tr>
<td><a href="#mutual-auth">Autenticación mutua</a></td>
<td><code>mutual-auth</code></td>
<td>Configure la autenticación mutua para el equilibrador de carga de aplicación.</td>
</tr>
<tr>
<td><a href="#ssl-services">Soporte de servicios SSL</a></td>
<td><code>ssl-services</code></td>
<td>Permita el soporte de servicios SSL para el equilibrio de carga.</td>
</tr>
</tbody></table>



## Anotaciones generales
{: #general}

### Servicios externos (proxy-external-service)
{: #proxy-external-service}

Añada definiciones de vía de acceso a servicios externos, como servicios alojados en {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Añada definiciones de vía de acceso a servicios externos. Utilice esta anotación sólo si su app opera en un servicio externo en lugar de un servicio de fondo. Cuando se utiliza esta anotación para crear una ruta de servicio externo, sólo las anotaciones `client-max-body-size`, `proxy-read-timeout`, `proxy-connect-timeout` y `proxy-buffering` están soportadas de forma conjunta. Las demás anotaciones no están soportadas de forma conjunta con `proxy-external-service`.
</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>path</code></td>
 <td>Sustituya <code>&lt;<em>mypath</em>&gt;</code> por la vía de acceso en la que escucha el servicio externo. </td>
 </tr>
 <tr>
 <td><code>external-svc</code></td>
 <td>Sustituya <code>&lt;<em>external_service</em>&gt;</code> por el servicio externo al que se debe llamar. Por ejemplo, <code>https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net</code>.</td>
 </tr>
 <tr>
 <td><code>host</code></td>
 <td>Sustituya <code>&lt;<em>mydomain</em>&gt;</code> por el dominio de host para el servicio externo.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Direccionamiento del equilibrador de carga de aplicación privado (ALB-ID)
{: #alb-id}

Direccione las solicitudes entrantes a sus apps con un equilibrador de carga de aplicación privado.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Elija un equilibrador de carga de aplicación privado para direccionar las solicitudes entrantes en lugar del equilibrador de carga de aplicación público.</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
<th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>&lt;private_ALB_ID&gt;</code></td>
<td>El ID de su equilibrador de carga de aplicación. Ejecute <code>bx cs albs --cluster <my_cluster></code> para encontrar el ID del equilibrador de carga de aplicación privado.
</td>
</tr>
</tbody></table>
</dd>
</dl>

<br />



### Vías de acceso de reescritura (rewrite-path)
{: #rewrite-path}

Direccione el tráfico de red de entrada en una vía de acceso de dominio de equilibrador de carga de aplicación a una vía de acceso diferente que escuche su aplicación de fondo.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El dominio del equilibrador de carga de aplicación de Ingress direcciona el tráfico de entrada de la red de <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> a la app. La app escucha en <code>/coffee</code> en lugar de en <code>/beans</code>. Para reenviar el tráfico de red entrante a la app, añada la anotación de reescritura al archivo de configuración del recurso. La anotación de reescritura garantiza que el tráfico de red entrante de <code>/beans</code> se reenvíe a la app utilizando la vía de acceso <code>/coffee</code>. Si incluye varios servicios, utilice únicamente un punto y coma (;) para separarlos.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
<th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio de Kubernetes que ha creado para la app. </td>
</tr>
<tr>
<td><code>rewrite</code></td>
<td>Sustituya <code>&lt;<em>target_path</em>&gt;</code> por la vía de acceso en la que escucha la app. El tráfico de red de entrada del dominio de equilibrador de carga de aplicación se reenvía al servicio Kubernetes mediante esta vía de acceso. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En el ejemplo anterior, la vía de acceso de reescritura se ha definido como <code>/coffee</code>.</td>
</tr>
</tbody></table>

</dd></dl>

<br />


### Afinidad de sesión con cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Utilice la anotación de cookie sticky para añadir afinidad de sesión al equilibrador de carga de aplicación y direccionar siempre el tráfico de red entrante al mismo servidor en sentido ascendente.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Para la alta disponibilidad, es posible que la configuración de la app requiera que despliegue varios servidores en sentido ascendente para que gestionen las solicitudes entrantes del cliente y garanticen una mayor disponibilidad. Cuando un cliente se conecta a la app de fondo, podría ser útil que un cliente recibiera el servicio del mismo servidor en sentido ascendente mientras dure la sesión o durante el tiempo que se tarda en completar una tarea. Puede configurar el equilibrador de carga de aplicación de modo que asegure la afinidad de sesión direccionando siempre el tráfico de red de entrada al mismo servidor en sentido ascendente.

</br></br>
El equilibrador de carga de aplicación asigna cada cliente que se conecta a la app de fondo a uno de los servidores en sentido ascendente disponibles. El equilibrador de carga de aplicación crea una cookie de sesión que se almacena en la app del cliente y que se incluye en la información de cabecera de cada solicitud entre el equilibrador de carga de aplicación y el cliente. La información de la cookie garantiza que todas las solicitudes se gestionan en el mismo servidor en sentido ascendente durante todo el periodo de la sesión.

</br></br>
Si incluye varios servicios, utilice únicamente un punto y coma (;) para separarlos.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <caption>Visión general de los componentes del archivo YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio de Kubernetes que ha creado para la app. </td>
  </tr>
  <tr>
  <td><code>name</code></td>
  <td>Sustituya <code>&lt;<em>cookie_name</em>&gt;</code> por el nombre de una "stickie cookie" que se crea durante una sesión. </td>
  </tr>
  <tr>
  <td><code>expires</code></td>
  <td>Sustituya <code>&lt;<em>expiration_time</em>&gt;</code> por el tiempo en segundos (s), minutos (m) u horas (h) antes de que caduque la "sticky cookie". Este tiempo depende de la actividad del usuario. Una vez caducada la cookie, el navegador web del cliente la suprime y se deja de enviar al equilibrador de carga de aplicación. Por ejemplo, para establecer un tiempo de caducidad de 1 segundo, 1 minutos o 1 hora, escriba <code>1s</code>, <code>1m</code> o <code>1h</code>.</td>
  </tr>
  <tr>
  <td><code>path</code></td>
  <td>Sustituya <code>&lt;<em>cookie_path</em>&gt;</code> por vía de acceso que se añade al subdominio de Ingress y que indica los dominios y subdominios para los que se envía la cookie al equilibrador de carga de aplicación. Por ejemplo, si el dominio de Ingress es <code>www.myingress.com</code> y desea enviar la cookie en cada solicitud del cliente, debe establecer <code>path=/</code>. Si desea enviar la cookie solo para <code>www.myingress.com/myapp</code> y todos sus subdominios, establezca este valor en <code>path=/myapp</code>.</td>
  </tr>
  <tr>
  <td><code>hash</code></td>
  <td>Sustituya <code>&lt;<em>hash_algorithm</em>&gt;</code> por el algoritmo hash que protege la información en la cookie. Solo se admite <code>sha1
</code>. SHA1 crea una suma de hash en función de la información de la cookie y añade esta suma de hash a la cookie. El servidor puede descifrar la información de la cookie y verificar la integridad de los datos.</td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />



### Puertos TCP para los equilibradores de carga de aplicación (tcp-ports)
{: #tcp-ports}

Acceda a una app a través de un puerto TCP no estándar.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Utilice esta anotación para una app que esté ejecutando una carga de trabajo con secuencias TCP.

<p>**Nota**: El equilibrador de carga de aplicación funciona en modalidad de paso y envía tráfico a las apps de fondo. En este caso, no se soporta la terminación SSL.</p>
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio Kubernetes para acceder a través del puerto TCP no estándar. </td>
  </tr>
  <tr>
  <td><code>ingressPort</code></td>
  <td>Sustituya <code>&lt;<em>ingress_port</em>&gt;</code> por el puerto TCP en el que desea acceder a la app. </td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>Sustituir <code>&lt;<em>service_port</em>&gt;</code> por este parámetro es opcional. Cuando se proporciona, el puerto se sustituye por este valor antes de que el tráfico se envíe a la app de backend. En caso contrario, el puerto permanece igual que el puerto de Ingress.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Anotaciones de conexión
{: #connection}

### Tiempos de espera excedidos de conexión y tiempos de espera excedidos de lectura personalizados (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Establecimiento de un tiempo de espera excedido de conexión y de un tiempo de espera excedido de lectura personalizados para el equilibrador de carga de aplicación. Ajusta el tiempo que el equilibrador de carga de aplicación espera para conectarse a la app de fondo y para leer información de la misma antes de considerar que la app de fondo no está disponible.{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Cuando se envía una solicitud del cliente al equilibrador de carga de aplicación de Ingress, el equilibrador de carga de aplicación abre una conexión con la app de fondo. De forma predeterminada, el equilibrador de carga de aplicación espera 60 segundos para recibir una respuesta de la app de fondo. Si la app de fondo no responde en un plazo de 60 segundos, la solicitud de conexión se cancela y se considera que la app de fondo no está disponible.

</br></br>
Después de que el equilibrador de carga de aplicación se conecte a la app de fondo, lee los datos de la respuesta procedente de la app de fondo. Durante esta operación de lectura, el equilibrador de carga de aplicación espera un máximo de 60 segundos entre dos operaciones de lectura para recibir datos de la app de fondo. Si la app de fondo no envía datos en un plazo de 60 segundos, la conexión con la app de fondo se cierra y se considera que la app no está disponible.
</br></br>
60 segundos es el valor predeterminad para el tiempo de espera excedido de conexión (connect-timeout) y el tiempo de espera excedido de lectura (read-timeout) en un proxy y lo recomendable es no modificarlo.
</br></br>
Si la disponibilidad de la app no es estable o si la app es lenta en responder debido a cargas de trabajo elevadas, es posible que desee aumentar el valor de connect-timeout o de read-timeout. Tenga en cuenta que aumentar el tiempo de espera excedido afecta al rendimiento del equilibrador de carga de aplicación, ya que la conexión con la app de fondo debe permanecer abierta hasta que se alcanza el tiempo de espera excedido.
</br></br>
Por otro lado, puede reducir el tiempo de espera para aumentar el rendimiento del equilibrador de carga de aplicación. Asegúrese de que la app de fondo es capaz de manejar las solicitudes dentro del tiempo de espera especificado, incluso con cargas de trabajo altas.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;connect_timeout&gt;</code></td>
 <td>El número de segundos que se debe esperar para conectar con la app de fondo, por ejemplo <code>65s</code>. <strong>Nota:</strong> El valor de connect-timeout no puede superar los 75 segundos.</td>
 </tr>
 <tr>
 <td><code>&lt;read_timeout&gt;</code></td>
 <td>El número de segundos que se debe esperar a que se lea la app de fondo, por ejemplo <code>65s</code>. </td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



### Solicitudes de estado activo (keepalive-requests)
{: #keepalive-requests}

Configure el número máximo de solicitudes que se pueden servir a través de una conexión en estado activo.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Establece el número máximo de solicitudes que se pueden servir a través de una conexión en estado activo.
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
<th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio de Kubernetes que ha creado para la app. Este parámetro
es opcional. La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Si se proporciona el parámetro, se establecen las solicitudes de estado activo para el servicio en cuestión. Si no se proporciona el parámetro, las solicitudes de estado activo se establecen a nivel de servidor de <code>nginx.conf</code> para todos los servicios que no tienen configuradas solicitudes de estado activo.</td>
</tr>
<tr>
<td><code>requests</code></td>
<td>Sustituya <code>&lt;<em>max_requests</em>&gt;</code> por el número máximo de solicitudes que se pueden servir a través de una conexión de estado activo.</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Tiempo de espera de estado activo (keepalive-timeout)
{: #keepalive-timeout}

Configure el tiempo que se mantiene abierta una conexión en estado activo en el servidor.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Establece el tiempo que se mantiene abierta una conexión en estado activo en el servidor.
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio de Kubernetes que ha creado para la app. Este parámetro
es opcional. Si se proporciona el parámetro, se establece el tiempo de espera de estado activo para el servicio en cuestión. Si no se proporciona el parámetro, el tiempo de espera de estado activo se establece a nivel de servidor de <code>nginx.conf</code> para todos los servicios que no tienen configurado el tiempo de espera de estado activo.</td>
 </tr>
 <tr>
 <td><code>timeout</code></td>
 <td>Sustituya <code>&lt;<em>time</em>&gt;</code> por una cantidad de tiempo en segundos. Ejemplo:<code>timeout=20s</code>. Un valor de cero inhabilita las conexiones de cliente de estado activo.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Estado activo en sentido ascendente (upstream-keepalive)
{: #upstream-keepalive}

Configure el número máximo de conexiones de estado activo en sentido ascendente para un servidor en sentido ascendente.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Cambia el número máximo de conexiones de estado activo desocupadas para el servidor en sentido ascendente de un servicio determinado. El servidor en sentido ascendente tiene 64 conexiones de estado activo desocupadas de forma predeterminada.
</dd>


 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio de Kubernetes que ha creado para la app. </td>
  </tr>
  <tr>
  <td><code>keepalive</code></td>
  <td>Sustituya <code>&lt;<em>max_connections</em>&gt;</code> por el número máximo de conexiones de estado activo desocupadas para el servidor en sentido ascendente. El valor predeterminado es <code>64</code>. Un valor de <code>0</code> inhabilita las conexiones de estado activo en sentido ascendente para el servicio determinado.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

<br />



## Anotaciones de almacenamiento intermedio de proxy
{: #proxy-buffer}


### Colocación en almacenamiento intermedio de datos de respuesta del cliente (proxy-buffering)
{: #proxy-buffering}

Utilice la anotación buffer para inhabilitar el almacenamiento de datos de respuesta en el equilibrador de carga de aplicación mientras los datos se envían al cliente.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El equilibrador de carga de aplicación de Ingress actúa como un proxy entre la app de fondo y el navegador web del cliente. Cuando se envía una respuesta de la app de fondo al cliente, los datos de la respuesta se colocan en almacenamiento intermedio en el equilibrador de carga de aplicación de forma predeterminada. El equilibrador de carga de aplicación procesa mediante proxy la respuesta del cliente y empieza a enviar la respuesta al cliente al ritmo del cliente. Cuando el equilibrador de carga de aplicación ha recibido todos los datos procedentes de la app de fondo, la conexión con la app de fondo se cierra. La conexión entre el equilibrador de carga de aplicación y el cliente permanece abierta hasta que el cliente haya recibido todos los datos.

</br></br>
Si se inhabilita la colocación en almacenamiento intermedio de los datos de la respuesta en el equilibrador de carga de aplicación, los datos se envían inmediatamente del equilibrador de carga de aplicación al cliente. El cliente debe ser capaz de manejar los datos de entrada al ritmo del equilibrador de carga de aplicación. Si el cliente es demasiado lento, es posible que se pierdan datos.
</br></br>
La colocación en almacenamiento intermedio de datos en el equilibrador de carga de aplicación está habilitada de forma predeterminada.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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



### Almacenamiento intermedio de proxy (proxy-buffers)
{: #proxy-buffers}

Configure el número y el tamaño de los almacenamientos intermedios de proxy para el equilibrador de carga de aplicación.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Establece el número y el tamaño de los almacenamientos intermedios que leen una respuesta de una única conexión desde el servidor mediante proxy. La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Por ejemplo, si se especifica una configuración como <code>serviceName=SERVICE number=2 size=1k</code>, se aplica 1 k al servicio. Si se especifica una configuración como <code>number=2 size=1k</code>, se aplica 1 k a todos los servicios del host de Ingress.
</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre de un servicio para aplicar almacenamientos intermedios de proxy. </td>
 </tr>
 <tr>
 <td><code>number_of_buffers</code></td>
 <td>Sustituya <code>&lt;<em>number_of_buffers</em>&gt;</code> por un número, como <em>2</em>.</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>Sustituya <code>&lt;<em>size</em>&gt;</code> por el tamaño de cada almacenamiento intermedio en kilobytes (k o K), como <em>1K</em>.</td>
 </tr>
 </tbody>
 </table>
 </dd></dl>

<br />


### Tamaño de almacenamiento intermedio de proxy (proxy-buffer-size)
{: #proxy-buffer-size}

Configure el tamaño del almacenamiento intermedio de proxy que lee la primera parte de la respuesta.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Establezca el tamaño del almacenamiento intermedio que lee la primera parte de la respuesta que se recibe del servidor proxy.Esta parte de la respuesta normalmente contiene una cabecera de respuesta pequeña. La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Por ejemplo, si se especifica una configuración como <code>serviceName=SERVICE size=1k</code>, se aplica 1 k al servicio. Si se especifica una configuración como <code>size=1k</code>, se aplica 1 k a todos los servicios del host de Ingress.
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>serviceName</code></td>
 <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre de un servicio para aplicar proxy-buffers-size.</td>
 </tr>
 <tr>
 <td><code>size</code></td>
 <td>Sustituya <code>&lt;<em>size</em>&gt;</code> por el tamaño de cada almacenamiento intermedio en kilobytes (k o K), como <em>1K</em>.</td>
 </tr>
 </tbody></table>

 </dd>
 </dl>

<br />



### Tamaño de los almacenamientos intermedios ocupados del proxy (proxy-busy-buffers-size)
{: #proxy-busy-buffers-size}

Configure el tamaño de los almacenamientos intermedios de proxy que puedan estar ocupados. {:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Limita el tamaño de los almacenamientos intermedios que están enviando una respuesta al cliente mientras la respuesta aún no está totalmente leída. Mientras tanto, el resto de los almacenamientos intermedios pueden leer la respuesta y, si es necesario, almacenar en el almacenamiento intermedio parte de la respuesta en un archivo temporal. La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Por ejemplo, si se especifica una configuración como <code>serviceName=SERVICE size=1k</code>, se aplica 1 k al servicio. Si se especifica una configuración como <code>size=1k</code>, se aplica 1 k a todos los servicios del host de Ingress.
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
<th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>serviceName</code></td>
<td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre de un servicio para aplicar proxy-busy-buffers-size.</td>
</tr>
<tr>
<td><code>size</code></td>
<td>Sustituya <code>&lt;<em>size</em>&gt;</code> por el tamaño de cada almacenamiento intermedio en kilobytes (k o K), como <em>1K</em>.</td>
</tr>
</tbody></table>

 </dd>
 </dl>

<br />



## Anotaciones de solicitud y respuesta
{: #request-response}


### Solicitud de cliente o cabecera de respuesta adicional (proxy-add-headers)
{: #proxy-add-headers}

Añada información de cabecera adicional a una solicitud de cliente antes de enviar la solicitud a la app de fondo o a una respuesta del cliente antes de enviar la respuesta al cliente.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El equilibrador de carga de aplicación de Ingress actúa como un proxy entre la app del cliente y la app de fondo. Las solicitudes del cliente que se envían al equilibrador de carga de aplicación se procesan (mediante proxy) y se colocan en una nueva solicitud que se envía del equilibrador de carga de aplicación a la app de fondo. El proceso mediante proxy de una solicitud elimina la información de cabecera, como por ejemplo el nombre de usuario, que se envió inicialmente desde el cliente. Si la app de fondo necesita esta información, puede utilizar la anotación <strong>ingress.bluemix.net/proxy-add-headers</strong> para añadir información de cabecera a la solicitud del cliente antes que la solicitud se reenvíe del equilibrador de carga de aplicación a la app de fondo.

</br></br>
Cuando una app de fondo envía una respuesta al cliente, el equilibrador de carga de aplicación procesa mediante proxy la respuesta y las cabeceras http se eliminan de la respuesta. Es posible que la app web del cliente necesite esta información de cabecera para poder procesar la respuesta. Puede utilizar la anotación <strong>ingress.bluemix.net/response-add-headers</strong> para añadir información de cabecera a la respuesta del cliente antes de que la respuesta se reenvíe del equilibrador de carga de aplicación a la app web del cliente.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>service_name</code></td>
  <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio de Kubernetes que ha creado para la app. </td>
  </tr>
  <tr>
  <td><code>&lt;header&gt;</code></td>
  <td>La clave de la información de cabecera que se va a añadir a la solicitud del cliente o a la respuesta del cliente.</td>
  </tr>
  <tr>
  <td><code>&lt;value&gt;</code></td>
  <td>El valor de la información de cabecera que se va a añadir a la solicitud del cliente o a la respuesta del cliente.</td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />



### Eliminación de cabecera de respuesta de cliente (response-remove-headers)
{: #response-remove-headers}

Elimine la información de cabecera que se incluye en la respuesta del cliente de la app de fondo antes de que la respuesta se envíe al cliente.
 {:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>El equilibrador de carga de aplicación de Ingress actúa como un proxy entre la app de fondo y el navegador web del cliente. Las respuestas del cliente procedentes de la app de fondo que se envían al equilibrador de carga de aplicación se procesan (mediante proxy) y se colocan en una nueva respuesta que se envía del equilibrador de carga de aplicación al navegador web del cliente. Aunque el proceso mediante proxy de una respuesta elimina la información de cabecera http que se envió inicialmente desde la app de fondo, es posible que este proceso no elimine todas las cabeceras específicas de la app de fondo. Elimine la información de cabecera de la respuesta del cliente antes de que la respuesta se reenvíe del equilibrador de carga de aplicación al navegador web del cliente.</dd>
 <dt>Archivo YAML de recurso de Ingress de ejemplo</dt>
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
   <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>service_name</code></td>
   <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio de Kubernetes que ha creado para la app. </td>
   </tr>
   <tr>
   <td><code>&lt;header&gt;</code></td>
   <td>La clave de la cabecera que se eliminará de la respuesta del cliente.</td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


### Tamaño máximo personalizado de cuerpo de solicitud del cliente (client-max-body-size)
{: #client-max-body-size}

Ajuste el tamaño máximo del cuerpo que puede enviar el cliente como parte de una solicitud.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Para mantener el rendimiento esperado, el tamaño máximo del cuerpo de la solicitud del cliente se establece en 1 megabyte. Cuando se envía una solicitud del cliente con un tamaño de cuerpo que supera el límite al equilibrador de carga de aplicación de Ingress y el cliente no permite dividir los datos, el equilibrador de carga de aplicación devuelve al cliente una respuesta HTTP 413 (la entidad de la solicitud es demasiado grande). No se puede establecer una conexión entre el cliente y el equilibrador de carga de aplicación hasta que se reduce el tamaño del cuerpo de la solicitud. Si el cliente puede dividir los datos en varios bloques, los datos se dividen en paquetes de 1 megabyte y se envían al equilibrador de carga de aplicación.

</br></br>
Es posible que desee aumentar el tamaño máximo del cuerpo porque espera solicitudes del cliente con un tamaño de cuerpo superior a 1 megabyte. Por ejemplo, si desea que el cliente pueda cargar archivos grandes. El hecho de aumentar el tamaño máximo del cuerpo de la solicitud puede afectar el rendimiento del equilibrador de carga de aplicación, ya que la conexión con el cliente debe permanecer abierta hasta que se recibe la solicitud.
</br></br>
<strong>Nota:</strong> Algunos navegadores web de cliente no pueden mostrar correctamente el mensaje de respuesta de HTTP 413.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;size&gt;</code></td>
 <td>El tamaño máximo del cuerpo de la respuesta del cliente. Por ejemplo, para establecerlo en 200 megabytes, defina <code>200m</code>.  <strong>Nota:</strong> Puede establecer el tamaño en 0 para inhabilitar la comprobación del tamaño del cuerpo de la solicitud del cliente.</td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />



## Anotaciones de límite de servicio
{: #service-limit}


### Límites de velocidad global (global-rate-limit)
{: #global-rate-limit}

Limite la velocidad de procesamiento de solicitudes y el número de conexiones por una clave definida para todos los servicios. {:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Para todos los servicios, limite la velocidad de servicio de solicitudes y el número de conexiones por una clave definida que provienen de una única dirección IP para todas las vías de acceso de los backends seleccionados.
</dd>


 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>key</code></td>
  <td>Para establecer un límite global para las solicitudes entrantes basado en la ubicación o servicio, utilice `key=location`. Para establecer un límite global para las solicitudes entrantes basado en la cabecera, utilice `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Sustituya <code>&lt;<em>rate</em>&gt;</code> por la velocidad de procesamiento. Especifique un valor como velocidad por segundo (r/s) o velocidad por minuto (r/m). Por ejemplo: <code>50r/m</code>.</td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Sustituya <code>&lt;<em>conn</em>&gt;</code> por el número de conexiones.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

<br />



### Límites de velocidad de servicio (service-rate-limit)
{: #service-rate-limit}

Limita la velocidad de procesamiento de solicitudes y el número de conexiones para servicios específicos. {:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Para servicios específicos, limite la velocidad de servicio de solicitudes y el número de conexiones por una clave definida que provienen de una única dirección IP para todas las vías de acceso de los backends seleccionados.
</dd>


 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio para el que desea limitar la velocidad de procesamiento.</li>
  </tr>
  <tr>
  <td><code>key</code></td>
  <td>Para establecer un límite global para las solicitudes entrantes basado en la ubicación o servicio, utilice `key=location`. Para establecer un límite global para las solicitudes entrantes basado en la cabecera, utilice `X-USER-ID key==$http_x_user_id`.</td>
  </tr>
  <tr>
  <td><code>rate</code></td>
  <td>Sustituya <code>&lt;<em>rate</em>&gt;</code> por la velocidad de procesamiento. Para definir una velocidad por segundo, utilice r/s: <code>10r/s</code>. Para definir una velocidad por minuto, utilice r/m: <code>50r/m</code>. </td>
  </tr>
  <tr>
  <td><code>number-of_connections</code></td>
  <td>Sustituya <code>&lt;<em>conn</em>&gt;</code> por el número de conexiones.</td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />



## Anotaciones de autenticación TLS/SSL y HTTPS
{: #https-auth}


### Puertos HTTP y HTTPS personalizados (custom-port)
{: #custom-port}

Cambie los puertos predeterminados para el tráfico de red HTTP (puerto 80) y HTTPS (puerto 443).
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>De forma predeterminada, el equilibrador de carga de aplicación de Ingress está configurado para escuchar el tráfico de red de entrada HTTP en el puerto 80 y el tráfico de red de entrada HTTPS en el puerto 443. Puede cambiar los puertos predeterminados para añadir seguridad a su dominio del equilibrador de carga de aplicación o para habilitar solo un puerto HTTPS.
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>&lt;protocol&gt;</code></td>
 <td>Especifique <strong>http</strong> o <strong>https</strong> para cambiar el puerto predeterminado para el tráfico de red de entrada HTTP o HTTPS.</td>
 </tr>
 <tr>
 <td><code>&lt;port&gt;</code></td>
 <td>Especifique el número de puerto que desea utilizar para el tráfico de red de entrada HTTP o HTTPS. <p><strong>Nota:</strong> Cuando se especifica un puerto personalizado para HTTP o HTTPS, los puertos predeterminados dejan de ser válidos para HTTP y HTTPS. Por ejemplo, para cambiar el puerto predeterminado de HTTPS por 8443, pero utilizar el puerto predeterminado para HTTP, debe definir ciertos puertos personalizados para ambos: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p></td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Uso</dt>
 <dd><ol><li>Revise los puertos abiertos en el equilibrador de carga de aplicación. 
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
La salida de la CLI se parecerá a la siguiente:
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   80:30776/TCP,443:30412/TCP   8d</code></pre></li>
<li>Abra el mapa de configuración del controlador Ingress.
<pre class="pre">
<code>kubectl edit configmap ibm-cloud-provider-ingress-cm -n kube-system</code></pre></li>
<li>Añada los puertos HTTP y HTTPS no predeterminados al mapa de configuración. Sustituya &lt;port&gt; por el puerto HTTP o HTTPS que desea abrir.
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
 <li>Verifique que el controlador Ingress se ha vuelto a configurar con puertos no predeterminados.
<pre class="pre">
<code>kubectl get service -n kube-system</code></pre>
La salida de la CLI se parecerá a la siguiente:
<pre class="screen">
<code>NAME                     CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
public-ingress-ctl-svc   10.10.10.149   169.60.16.246   &lt;port1&gt;:30776/TCP,&lt;port2&gt;:30412/TCP   8d</code></pre></li>
<li>Configure Ingress para que utilice los puertos no predeterminados cuando direccione el tráfico de entrada de la red a sus servicios. Utilice el archivo YAML de ejemplo de esta referencia. </li>
<li>Actualice la configuración del controlador Ingress.
<pre class="pre">
<code>kubectl apply -f &lt;yaml_file&gt;</code></pre>
</li>
<li>Abra el navegador web preferido para acceder a la app. Ejemplo: <code>https://&lt;ibmdomain&gt;:&lt;port&gt;/&lt;service_path&gt;/</code></li></ol></dd></dl>

<br />



### HTTP redirige a HTTPS (redirect-to-https)
{: #redirect-to-https}

Convierte las solicitudes de cliente HTTP no seguras en HTTPS.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Puede configurar el equilibrador de carga de aplicación de Ingress de modo que proteja el dominio con el certificado TLS proporcionado por IBM o por un certificado TLS personalizado. Es posible que algunos usuarios intenten acceder a sus apps mediante una solicitud http no segura al dominio del equilibrador de carga de aplicación, por ejemplo <code>http://www.myingress.com</code>, en lugar hacerlo de mediante <code>https</code>. Puede utilizar la anotación redirect para convertir siempre las solicitudes HTTP no seguras en HTTPS. Si no utiliza esta anotación, las solicitudes HTTP no seguras no se convertirán en solicitud HTTPS de forma predeterminada y se podría exponer información confidencial sin cifrado al público.

 </br></br>
La redirección de solicitudes HTTP a HTTPS está inhabilitada de forma predeterminada.</dd>

<dt>YAML del recurso de Ingress de ejemplo</dt>
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



### Autenticación mutual (mutual-auth)
{: #mutual-auth}

Configure la autenticación mutua para el equilibrador de carga de aplicación.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Configure la autenticación mutua para el equilibrador de carga de aplicación de Ingress. El cliente autentica el servidor y el servidor también autentica el cliente mediante certificados. La autenticación mutua también se conoce como autenticación basada en certificado o autenticación bidireccional.
</dd>

<dt>Requisitos previos</dt>
<dd>
<ul>
<li>[Debe tener un secreto válido que contenga la autoridad de certificado necesaria (CA)](cs_app.html#secrets). Para autenticarse con la autenticación mutua también son necesarios <code>client.key</code> y <code>client.crt</code>.</li>
<li>Para habilitar la autenticación mutua en un puerto distinto de 443, [configure el equilibrador de carga para abrir el puerto válido](cs_ingress.html#opening_ingress_ports).</li>
</ul>
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
<th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>secretName</code></td>
<td>Sustituya <code>&lt;<em>mysecret</em>&gt;</code> por el nombre del recurso de secreto.</td>
</tr>
<tr>
<td><code>&lt;port&gt;</code></td>
<td>El número de puerto del equilibrador de carga de aplicación.</td>
</tr>
<tr>
<td><code>&lt;serviceName&gt;</code></td>
<td>El nombre de uno o varios recursos de Ingress. Este parámetro
es opcional.</td>
</tr>
</tbody></table>

</dd>
</dl>

<br />



### Soporte de servicios SSL (ssl-services)
{: #ssl-services}

Permite las solicitudes HTTPS y cifra el tráfico en las apps ascendentes.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Cifra el tráfico en las apps ascendentes y requieren HTTPS con los equilibradores de carga de aplicación.

**Opcional**: Puede añadir [autenticación unidireccional o autenticación mutua](#ssl-services-auth) a esta anotación.
</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio que representa su app. El tráfico está cifrado desde el equilibrador de carga de aplicación a la app.</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Sustituya <code>&lt;<em>service-ssl-secret</em>&gt;</code> por el secreto para el servicio. Este parámetro
es opcional. Si se proporciona el parámetro, el valor debe contener la clave y el certificado que la app espera del cliente.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


#### Soporte de servicios SSL con autenticación
{: #ssl-services-auth}

Permita las solicitudes HTTPS y cifre el tráfico a las apps ascendentes con autenticación unidireccional o mutua para la seguridad adicional.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Configure la autenticación mutua para las apps de equilibrio de carga que requieren HTTPS con controladores de Ingress.

**Nota**: Antes de empezar, [convierta el certificado y la clave a base 64 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.base64encode.org/).

</dd>


<dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ssl-service</code></td>
  <td>Sustituya <code>&lt;<em>myservice</em>&gt;</code> por el nombre del servicio que representa su app. El tráfico está cifrado desde el equilibrador de carga de aplicación a la app.</td>
  </tr>
  <tr>
  <td><code>ssl-secret</code></td>
  <td>Sustituya <code>&lt;<em>service-ssl-secret</em>&gt;</code> por el secreto para el servicio. Este parámetro
es opcional. Si se proporciona el parámetro, el valor debe contener la clave y el certificado que la app espera del cliente.</td>
  </tr>
  </tbody></table>

  </dd>
  </dl>


<br />



