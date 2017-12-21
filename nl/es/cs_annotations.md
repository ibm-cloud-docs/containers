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


# Anotaciones de Ingress
{: #ingress_annotation}

Para añadir prestaciones al controlador Ingress, especifique anotaciones como metadatos en un recurso Ingress.
{: shortdesc}

Para obtener información general sobre los servicios de Ingress y cómo empezar a utilizarlos, consulte [Configuración de acceso público a una app utilizando el controlador de Ingress](cs_apps.html#cs_apps_public_ingress).


|Anotación admitida|Descripción|
|--------------------|-----------|
|[Solicitud de cliente o cabecera de respuesta adicional](#proxy-add-headers)|Añade información de cabecera a una solicitud de cliente antes de reenviar la solicitud a la app de fondo, o añade una respuesta del cliente antes de enviar la respuesta al cliente.|
|[Colocación en almacenamiento intermedio de datos de respuesta del cliente](#proxy-buffering)|Inhabilita la colocación en almacenamiento intermedio de una respuesta del cliente en el controlador Ingress al enviar la respuesta al cliente.|
|[Eliminación de cabecera de respuesta del cliente](#response-remove-headers)|Elimina la información de cabecera de una respuesta del cliente antes de reenviar la respuesta al cliente.|
|[tiempos de espera excedidos de conexión y tiempos de espera excedidos de lectura personalizados](#proxy-connect-timeout)|Ajusta el tiempo que el controlador Ingress espera para conectarse a la app de fondo y para leer información de la misma antes de considerar que la app de fondo no está disponible.|
|[Puertos HTTP y HTTPS personalizados](#custom-port)|Cambia los puertos predeterminados para el tráfico de red HTTP y HTTPS.|
|[Tamaño máximo personalizado de cuerpo de solicitud del cliente](#client-max-body-size)|Ajusta el tamaño del cuerpo de la solicitud del cliente que se puede enviar al controlador Ingress.|
|[Servicios externos](#proxy-external-service)|Añade la definición de vías de acceso a servicios externos, como un servicio alojado en {{site.data.keyword.Bluemix_notm}}.|
|[Límites de velocidad global](#global-rate-limit)|Para todos los servicios, limite la velocidad de procesamiento de solicitudes de proceso y conexiones por una clave definida.|
|[HTTP redirecciona a HTTPS](#redirect-to-https)|Redirige las solicitudes HTTP no seguras del dominio a HTTPS.|
|[Solicitudes de estado activo](#keepalive-requests)|Configure el número máximo de solicitudes que se pueden servir a través de una conexión en estado activo.|
|[Tiempo de espera en estado activo](#keepalive-timeout)|Configure el tiempo que se mantiene abierta una conexión en estado activo en el servidor.|
|[Autenticación mutua](#mutual-auth)|Configure la autenticación mutua para el controlador de Ingress.|
|[Almacenamientos intermedios de proxy](#proxy-buffers)|Establece el número y el tamaño de los almacenamientos intermedios que se utilizan para leer una respuesta de una única conexión desde el servidor mediante proxy.|
|[Tamaño de los almacenamientos intermedios ocupados del proxy](#proxy-busy-buffers-size)|Limita el tamaño total de los almacenamientos intermedios que pueden estar ocupados enviando una respuesta al cliente mientras la respuesta aún no está totalmente leída.|
|[Tamaño de almacenamiento intermedio de proxy](#proxy-buffer-size)|Establece el tamaño del almacenamiento intermedio que se utiliza para leer la primera parte de la respuesta que se recibe del servidor proxy. |
|[Vías de acceso de reescritura](#rewrite-path)|Se direcciona el tráfico de red entrante a una vía de acceso distinta de aquella en la que escucha la app de fondo.|
|[Afinidad de sesión con cookies](#sticky-cookie-services)|El tráfico de red de entrada siempre se direcciona al mismo servidor en sentido ascendente mediante una "sticky cookie".|
|[Límites de velocidad de servicio](#service-rate-limit)|Para servicios específicos, limite la velocidad de procesamiento de solicitudes de proceso y conexiones por una clave definida.|
|[Soporte de servicios SSL](#ssl-services)|Permita el soporte de servicios SSL para el equilibrio de carga. |
|[Puertos TCP](#tcp-ports)|Acceda a una app a través de un puerto TCP no estándar.|
|[Estado activo en sentido ascendente](#upstream-keepalive)|Configure el número máximo de conexiones de estado activo en sentido ascendente para un servidor en sentido ascendente.|






## Solicitud de cliente o cabecera de respuesta adicional (proxy-add-headers)
{: #proxy-add-headers}

Añada información de cabecera adicional a una solicitud de cliente antes de enviar la solicitud a la app de fondo o a una respuesta del cliente antes de enviar la respuesta al cliente.{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El controlador de Ingress actúa como un proxy entre la app del cliente y la app de fondo. Las solicitudes del cliente que se envían al controlador de Ingress se procesan (mediante proxy) y se colocan en una nueva solicitud que se envía del controlador de Ingress a la app de fondo. El proceso mediante proxy de una solicitud elimina la información de cabecera, como por ejemplo el nombre de usuario, que se envió inicialmente desde el cliente. Si la app de fondo necesita esta información, puede utilizar la anotación <strong>ingress.bluemix.net/proxy-add-headers</strong> para añadir información de cabecera a la solicitud del cliente antes que la solicitud se reenvíe del controlador de Ingress a la app de fondo.

</br></br>
Cuando una app de fondo envía una respuesta al cliente, el controlador de Ingress procesa mediante proxy la respuesta y las cabeceras http se eliminan de la respuesta. Es posible que la app web del cliente necesite esta información de cabecera para poder procesar la respuesta. Puede utilizar la anotación <strong>ingress.bluemix.net/response-add-headers</strong> para añadir información de cabecera a la respuesta del cliente antes de que la respuesta se reenvíe del controlador de Ingress a la app web del cliente.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: El nombre del servicio de Kubernetes que ha creado para la app.</li>
  <li><code><em>&lt;header&gt;</em></code>: La clave de la información de cabecera que se va a añadir a la solicitud del cliente o a la respuesta del cliente.</li>
  <li><code><em>&lt;value&gt;</em></code>: El valor de la información de cabecera que se va a añadir a la solicitud del cliente o a la respuesta del cliente.</li>
  </ul></td>
  </tr>
  </tbody></table>
 </dd></dl>

<br />


 ## Colocación en almacenamiento intermedio de datos de respuesta del cliente (proxy-buffering)
 {: #proxy-buffering}

 Utilice la anotación buffer para inhabilitar el almacenamiento de datos de respuesta en el controlador de Ingress mientras los datos se envían al cliente.
 {:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>El controlador de Ingress actúa como un proxy entre la app de fondo y el navegador web del cliente. Cuando se envía una respuesta de la app de fondo al cliente, los datos de la respuesta se colocan en almacenamiento intermedio en el controlador de Ingress de forma predeterminada. El controlador de Ingress procesa mediante proxy la respuesta del cliente y empieza a enviar la respuesta al cliente al ritmo del cliente. Cuando el controlador de Ingress ha recibido todos los datos procedentes de la app de fondo, la conexión con la app de fondo se cierra. La conexión entre el controlador de Ingress y el cliente permanece abierta hasta que el cliente haya recibido todos los datos.
</br></br>
 Si se inhabilita la colocación en almacenamiento intermedio de los datos de la respuesta en el controlador de Ingress, los datos se envían inmediatamente del controlador de Ingress al cliente. El cliente debe ser capaz de manejar los datos de entrada al ritmo del controlador de Ingress. Si el cliente es demasiado lento, es posible que se pierdan datos.
 </br></br>
 La colocación en almacenamiento intermedio de datos en el controlador de Ingress está habilitada de forma predeterminada.</dd>
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


 ## Eliminación de cabecera de respuesta de cliente (response-remove-headers)
 {: #response-remove-headers}

Elimine la información de cabecera que se incluye en la respuesta del cliente de la app de fondo antes de que la respuesta se envíe al cliente.
{:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>El controlador de Ingress actúa como un proxy entre la app de fondo y el navegador web del cliente. Las respuestas del cliente procedentes de la app de fondo que se envían al controlador de Ingress se procesan (mediante proxy) y se colocan en una nueva respuesta que se envía del controlador de Ingress al navegador web del cliente. Aunque el proceso mediante proxy de una respuesta elimina la información de cabecera http que se envió inicialmente desde la app de fondo, es posible que este proceso no elimine todas las cabeceras específicas de la app de fondo. Elimine la información de cabecera de la respuesta del cliente antes de la respuesta se reenvíe del controlador de Ingress al navegador web del cliente.</dd>
 <dt>Archivo YAML de recurso de Ingress de ejemplo</dt>
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
   <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>Sustituya los valores siguientes:<ul>
   <li><code><em>&lt;service_name&gt;</em></code>: El nombre del servicio de Kubernetes que ha creado para la app.</li>
   <li><code><em>&lt;header&gt;</em></code>: La clave de la cabecera que se va a eliminar de la respuesta del cliente.</li>
   </ul></td>
   </tr>
   </tbody></table>
   </dd></dl>

<br />


## Tiempos de espera excedidos de conexión y tiempos de espera excedidos de lectura personalizados (proxy-connect-timeout, proxy-read-timeout)
{: #proxy-connect-timeout}

Establecimiento de un tiempo de espera excedido de conexión y de un tiempo de espera excedido de lectura personalizados para el controlador de Ingress. Ajusta el tiempo que el controlador de Ingress espera para conectarse a la app de fondo y para leer información de la misma antes de considerar que la app de fondo no está disponible.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Cuando se envía una solicitud del cliente al controlador de Ingress, este abre una conexión con la app de fondo. De forma predeterminada, el controlador de Ingress espera 60 segundos para recibir una respuesta de la app de fondo. Si la app de fondo no responde en un plazo de 60 segundos, la solicitud de conexión se cancela y se considera que la app de fondo no está disponible.

</br></br>
Después de que el controlador de Ingress se conecte a la app de fondo, el controlador de Ingress lee los datos de la respuesta procedente de la app de fondo. Durante esta operación de lectura, el controlador de Ingress espera un máximo de 60 segundos entre dos operaciones de lectura para recibir datos de la app de fondo. Si la app de fondo no envía datos en un plazo de 60 segundos, la conexión con la app de fondo se cierra y se considera que la app no está disponible.
</br></br>
60 segundos es el valor predeterminad para el tiempo de espera excedido de conexión (connect-timeout) y el tiempo de espera excedido de lectura (read-timeout) en un proxy y lo recomendable es no modificarlo.
</br></br>
Si la disponibilidad de la app no es estable o si la app es lenta en responder debido a cargas de trabajo elevadas, es posible que desee aumentar el valor de connect-timeout o de read-timeout. Tenga en cuenta que aumentar el tiempo de espera excedido afecta al rendimiento del controlador de Ingress ya que la conexión con la app de fondo debe permanecer abierta hasta que se alcanza el tiempo de espera excedido.
</br></br>
Por otro lado, puede reducir el tiempo de espera para aumentar el rendimiento del controlador de Ingress. Asegúrese de que la app de fondo es capaz de manejar las solicitudes dentro del tiempo de espera especificado, incluso con cargas de trabajo altas.</dd>
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
 <td><code>annotations</code></td>
 <td>Sustituya los valores siguientes:<ul><li><code><em>&lt;connect_timeout&gt;</em></code>: Escriba el número de segundos que se debe esperar para conectar con la app de fondo, por ejemplo <strong>65s</strong>.

 </br></br>
 <strong>Nota:</strong> El valor de connect-timeout no puede superar los 75 segundos.</li><li><code><em>&lt;read_timeout&gt;</em></code>: Escriba el número de segundos que hay que esperar antes de que se lea la app de fondo, por ejemplo <strong>65s</strong>.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


## Puertos HTTP y HTTPS personalizados (custom-port)
{: #custom-port}

Cambie los puertos predeterminados para el tráfico de red HTTP (puerto 80) y HTTPS (puerto 443).{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>De forma predeterminada, el controlador Ingress está configurado para escuchar el tráfico de red de entrada HTTP en el puerto 80 y el tráfico de red de entrada HTTPS en el puerto 443. Puede cambiar los puertos predeterminados para añadir seguridad a su dominio del controlador Ingress o para habilitar solo un puerto HTTPS. </dd>


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
 <td><code>annotations</code></td>
 <td>Sustituya los valores siguientes:<ul>
 <li><code><em>&lt;protocol&gt;</em></code>: Escriba <strong>http</strong> o <strong>https</strong> para cambiar el puerto predeterminado para el tráfico de red de entrada HTTP o HTTPS.</li>
 <li><code><em>&lt;port&gt;</em></code>: Escriba el número de puerto que desea utilizar para el tráfico de red de entrada HTTP o HTTPS.</li>
 </ul>
 <p><strong>Nota:</strong> Cuando se especifica un puerto personalizado para HTTP o HTTPS, los puertos predeterminados dejan de ser válidos para HTTP y HTTPS. Por ejemplo, para cambiar el puerto predeterminado de HTTPS por 8443, pero utilizar el puerto predeterminado para HTTP, debe definir ciertos puertos personalizados para ambos: <code>custom-port: "protocol=http port=80; protocol=https port=8443"</code>.</p>
 </td>
 </tr>
 </tbody></table>

 </dd>
 <dt>Uso</dt>
 <dd><ol><li>Revise los puertos abiertos en el controlador de Ingress. **Nota: la dirección IP deben ser direcciones IP doc genéricas. ¿También deben enlazar al kubectl cli de destino? Posiblemente no.**
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


## Tamaño máximo personalizado de cuerpo de solicitud del cliente (client-max-body-size)
{: #client-max-body-size}

Ajuste el tamaño máximo del cuerpo que puede enviar el cliente como parte de una solicitud.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Para mantener el rendimiento esperado, el tamaño máximo del cuerpo de la solicitud del cliente se establece en 1 megabyte. Cuando se envía una solicitud del cliente con un tamaño de cuerpo que supera el límite al controlador de Ingress y el cliente no permite dividir los datos, el controlador de Ingress devuelve al cliente una respuesta http 413 (la entidad de la solicitud es demasiado grande). No se puede establecer una conexión entre el cliente y el controlador Ingress hasta que se reduce el tamaño del cuerpo de la solicitud. Si el cliente puede dividir los datos en varios bloques, los datos se dividen en paquetes de 1 megabyte y se envían al controlador de Ingress.

</br></br>
Es posible que desee aumentar el tamaño máximo del cuerpo porque espera solicitudes del cliente con un tamaño de cuerpo superior a 1 megabyte. Por ejemplo, si desea que el cliente pueda cargar archivos grandes. El hecho de aumentar el tamaño máximo del cuerpo de la solicitud puede afectar el rendimiento del controlador de Ingress ya que la conexión con el cliente debe permanecer abierta hasta que se recibe la solicitud.
</br></br>
<strong>Nota:</strong> Algunos navegadores web de cliente no pueden mostrar correctamente el mensaje de respuesta de http 413.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>Sustituya el siguiente valor:<ul>
 <li><code><em>&lt;size&gt;</em></code>: Escriba el tamaño máximo del cuerpo de la respuesta del cliente. Por ejemplo, para establecerlo en 200 megabytes, defina <strong>200m</strong>.

 </br></br>
 <strong>Nota:</strong> Puede establecer el tamaño en 0 para inhabilitar la comprobación del tamaño del cuerpo de la solicitud del cliente.</li></ul></td>
 </tr>
 </tbody></table>

 </dd></dl>

<br />


<volver aquí>

## Servicios externos (proxy-external-service)
{: #proxy-external-service}
Añada definiciones de vía de acceso a servicios externos, como servicios alojados en {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Añada definiciones de vía de acceso a servicios externos.
Esta anotación es para casos especiales porque no funciona en un servicio de fondo y funciona en un servicio externo. Las anotaciones distintas de client-max-body-size, proxy-read-timeout, proxy-connect-timeout, proxy-buffering no se soportan con una ruta de servicio externo.
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
 <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
 </thead>
 <tbody>
 <tr>
 <td><code>annotations</code></td>
 <td>Sustituya el siguiente valor:
 <ul>
 <li><code><em>&lt;external_service&gt;</em></code>: Especifique el nombre del servicio que se debe llamar. Por ejemplo, https://&lt;myservice&gt;.&lt;region&gt;.mybluemix.net.</li>
 </ul>
 </tr>
 </tbody></table>

 </dd></dl>


<br />


## Límites de velocidad global (global-rate-limit)
{: #global-rate-limit}

Para todos los servicios, limite la velocidad de procesamiento de solicitudes de proceso y el número de conexiones por una clave definida que provienen de una única dirección IP para todos los hosts de una correlación de Ingress.{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Para establecer el límite, las zonas están definidas por `ngx_http_limit_conn_module` y `ngx_http_limit_req_module`. Estas zonas se aplican a los bloques de servidores que corresponden a cada host de una correlación de Ingress.
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
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;key&gt;</em></code>: Para establecer un límite global para las solicitudes entrantes basado en la ubicación o servicio, utilice `key=location`. Para establecer un límite global para las solicitudes entrantes basado en la cabecera, utilice `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: La velocidad.</li>
  <li><code><em>&lt;conn&gt;</em></code>: El número de conexiones.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

  <br />


 ## HTTP redirecciona a HTTPS (redirect-to-https)
 {: #redirect-to-https}

 Convierte las solicitudes de cliente HTTP no seguras en HTTPS.
 {:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>Puede configurar el controlador de Ingress de modo que proteja el dominio con el certificado TLS proporcionado por IBM o por un certificado TLS personalizado. Es posible que algunos usuarios intenten acceder a sus apps mediante una solicitud http no segura al dominio del controlador de Ingress, por ejemplo <code>http://www.myingress.com</code>, en lugar hacerlo de mediante <code>https</code>. Puede utilizar la anotación redirect para convertir siempre las solicitudes http no seguras en https. Si no utiliza esta anotación, las solicitudes http no seguras no se convertirán en solicitud https de forma predeterminada y se podría exponer información confidencial sin cifrado al público.
</br></br>
 La redirección de solicitudes http a https está inhabilitada de forma predeterminada.</dd>
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




 <br />

 
 ## Solicitudes de estado activo (keepalive-requests)
 {: #keepalive-requests}

 Configure el número máximo de solicitudes que se pueden servir a través de una conexión en estado activo.{:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>
 Establece el número máximo de solicitudes que se pueden servir a través de una conexión en estado activo.</dd>


 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Sustituya <em>&lt;service_name&gt;</em> por el nombre del servicio de Kubernetes que ha creado para la app. Este parámetro
es opcional. La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Si se proporciona el parámetro, se establecen las solicitudes de estado activo para el servicio en cuestión. Si no se proporciona el parámetro, las solicitudes de estado activo se establecen a nivel de servidor de <code>nginx.conf</code> para todos los servicios que no tienen configuradas solicitudes de estado activo.</li>
  <li><code><em>&lt;requests&gt;</em></code>: Sustituya <em>&lt;max_requests&gt;</em> por el número máximo de solicitudes que se pueden servir a través de una conexión en estado activo.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Tiempo de espera de estado activo (keepalive-timeout)
 {: #keepalive-timeout}

  Configure el tiempo que se mantiene abierta una conexión en estado activo en el servidor.{:shortdesc}

  <dl>
  <dt>Descripción</dt>
  <dd>
 Establece el tiempo que se mantiene abierta una conexión en estado activo en el servidor.</dd>


  <dt>YAML del recurso de Ingress de ejemplo</dt>
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
   <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
   </thead>
   <tbody>
   <tr>
   <td><code>annotations</code></td>
   <td>Sustituya los valores siguientes:<ul>
   <li><code><em>&lt;serviceName&gt;</em></code>: Sustituya <em>&lt;service_name&gt;</em> por el nombre del servicio de Kubernetes que ha creado para la app. Este parámetro
es opcional. Si se proporciona el parámetro, se establece el tiempo de espera de estado activo para el servicio en cuestión. Si no se proporciona el parámetro, el tiempo de espera de estado activo se establece a nivel de servidor de <code>nginx.conf</code> para todos los servicios que no tienen configurado el tiempo de espera de estado activo.</li>
   <li><code><em>&lt;timeout&gt;</em></code>: Sustituya <em>&lt;time&gt;</em> por una cantidad de tiempo en segundos. Ejemplo:<code><em>timeout=20s</em></code>. Un valor de cero inhabilita las conexiones de cliente de estado activo.</li>
   </ul>
   </td>
   </tr>
   </tbody></table>

   </dd>
   </dl>

 <br />


 ## Autenticación mutual (mutual-auth)
 {: #mutual-auth}

 Configure la autenticación mutua para el controlador de Ingress.{:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>
Configure la autenticación mutua para el controlador de Ingress. El cliente autentica el servidor y el servidor también autentica el cliente mediante certificados. La autenticación mutua también se conoce como autenticación basada en certificado o autenticación bidireccional.  </dd>

 <dt>Requisitos previos</dt>
 <dd>
 <ul>
 <li>[Debe tener un secreto válido que contenga la autoridad de certificado necesaria (CA)](cs_apps.html#secrets). Para autenticarse con la autenticación mutua también son necesarios <code>client.key</code> y <code>client.crt</code>.</li>
 <li>Para habilitar la autenticación mutua en un puerto distinto de 443, [configure el equilibrador de carga para abrir el puerto válido](cs_apps.html#opening_ingress_ports).</li>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: El nombre de uno o varios recursos de Ingress. Este parámetro
es opcional. </li>
  <li><code><em>&lt;secretName&gt;</em></code>: Sustituya <em>&lt;secret_name&gt;</em> por el nombre del recurso de secreto.</li>
  <li><code><em>&lt;port&gt;</em></code>: Especifique el número de puerto.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Almacenamiento intermedio de proxy (proxy-buffers)
 {: #proxy-buffers}
 
 Configure el almacenamiento intermedio de proxy para el controlador de Ingress.{:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>
 Establece el número y el tamaño de los almacenamientos intermedios que se utilizan para leer una respuesta de una única conexión desde el servidor mediante proxy.La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Por ejemplo, si se especifica una configuración como <code>serviceName=SERVICE number=2 size=1k</code>, se aplica 1 k al servicio. Si se especifica una configuración como <code>number=2 size=1k</code>, se aplica 1 k a todos los servicios del host de Ingress.
</dd>
 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:
  <ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Sustituya <em>&lt;serviceName&gt;</em> por el nombre del servicio para aplicar proxy-buffers.</li>
  <li><code><em>&lt;number_of_buffers&gt;</em></code>: Sustituya <em>&lt;number_of_buffers&gt;</em> por un número, como <em>2</em>.</li>
  <li><code><em>&lt;size&gt;</em></code>: Especifique el tamaño de cada almacenamiento intermedio en kilobytes (k o K), como <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody>
  </table>
  </dd>
  </dl>

 <br />


 ## Tamaño de los almacenamientos intermedios ocupados del proxy (proxy-busy-buffers-size)
 {: #proxy-busy-buffers-size}

 Configure el tamaño de los almacenamientos intermedios ocupados del proxy para el controlador de Ingress.{:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>
Cuando la colocación en el almacenamiento intermedio de las respuestas del servidor proxy está habilitada, limite el tamaño total de los almacenamientos intermedios que pueden estar ocupados enviando una respuesta al cliente mientras la respuesta aún no está totalmente leída. Mientras tanto, el resto de almacenamientos intermedios se puede utilizar para leer la respuesta y, si es necesario, coloque parte de la respuesta en un archivo temporal. La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Por ejemplo, si se especifica una configuración como <code>serviceName=SERVICE size=1k</code>, se aplica 1 k al servicio. Si se especifica una configuración como <code>size=1k</code>, se aplica 1 k a todos los servicios del host de Ingress.
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
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Sustituya <em>&lt;serviceName&gt;</em> por el nombre del servicio para aplicar proxy-busy-buffers-size.</li>
  <li><code><em>&lt;size&gt;</em></code>: Especifique el tamaño de cada almacenamiento intermedio en kilobytes (k o K), como <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />


 ## Tamaño de almacenamiento intermedio de proxy (proxy-buffer-size)
 {: #proxy-buffer-size}

 Configure el tamaño del almacenamiento intermedio de proxy del controlador de Ingress.{:shortdesc}

 <dl>
 <dt>Descripción</dt>
 <dd>
 Establezca el tamaño del almacenamiento intermedio que se utiliza para leer la primera parte de la respuesta que se recibe del servidor proxy. Esta parte de la respuesta normalmente contiene una cabecera de respuesta pequeña. La configuración se aplica a todos los servicios del host de Ingress a menos que se especifique un servicio. Por ejemplo, si se especifica una configuración como <code>serviceName=SERVICE size=1k</code>, se aplica 1 k al servicio. Si se especifica una configuración como <code>size=1k</code>, se aplica 1 k a todos los servicios del host de Ingress.
</dd>


 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: Sustituya <em>&lt;serviceName&gt;</em> por el nombre del servicio para aplicar proxy-busy-buffers-size.</li>
  <li><code><em>&lt;size&gt;</em></code>: Especifique el tamaño de cada almacenamiento intermedio en kilobytes (k o K), como <em>1K</em>.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
  </dl>

 <br />



## Vías de acceso de reescritura (rewrite-path)
{: #rewrite-path}

Direccione el tráfico de red de entrada en una vía de acceso de dominio de controlador de Ingress a una vía de acceso diferente que escuche su aplicación de fondo.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El dominio del controlador de Ingress direcciona el tráfico de entrada de la red de <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> a la app. La app escucha en <code>/coffee</code> en lugar de en <code>/beans</code>. Para reenviar el tráfico de red entrante a la app, añada la anotación de reescritura al archivo de configuración del recurso. La anotación de reescritura garantiza que el tráfico de red entrante de <code>/beans</code> se reenvíe a la app utilizando la vía de acceso <code>/coffee</code>. Si incluye varios servicios, utilice únicamente un punto y coma (;) para separarlos.</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
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
<th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Sustituya <em>&lt;service_name&gt;</em> por el nombre del servicio Kubernetes que ha creado para la app, y <em>&lt;target-path&gt;</em> por la vía de acceso que la app escucha. El tráfico de red de entrada del dominio de controlador de Ingress se reenvía al servicio Kubernetes mediante esta vía de acceso. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina <code>/</code> como <em>rewrite-path</em> de la app.</td>
</tr>
<tr>
<td><code>path</code></td>
<td>Sustituya <em>&lt;domain_path&gt;</em> con la vía de acceso que desee agregar al dominio de su controlador de Ingress. El tráfico de red de entrada en esta vía de acceso se reenvía a la vía de acceso de escritura que ha definido en la anotación. En el ejemplo anterior, establezca la vía de acceso del dominio <code>/beans</code> para incluir esta vía de acceso en el equilibrio de carga del controlador de Ingress.</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>Sustituya <em>&lt;service_name&gt;</em> por el nombre del servicio de Kubernetes que ha creado para la app. El nombre de servicio que se utilice aquí debe ser el mismo que se haya definido en la anotación.</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>Sustituya <em>&lt;service_port&gt;</em> por el puerto en el que escucha el servicio.</td>
</tr></tbody></table>

</dd></dl>

<br />


## Límites de velocidad de servicio (service-rate-limit)
{: #service-rate-limit}

Para servicios específicos, limite la velocidad de servicio de solicitudes y el número de conexiones por una clave definida que provienen de una única dirección IP para todas las vías de acceso de los backends seleccionados.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Para establecer el límite, las zonas que se aplican se definen mediante `ngx_http_limit_conn_module` y `ngx_http_limit_req_module` en todos los bloques de ubicación que corresponden a todos los servicios definidos como objetivo en la anotación de la correlación de Ingress.</dd>


 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;serviceName&gt;</em></code>: El nombre del recurso de Ingress.</li>
  <li><code><em>&lt;key&gt;</em></code>: Para establecer un límite global para las solicitudes entrantes basado en la ubicación o servicio, utilice `key=location`. Para establecer un límite global para las solicitudes entrantes basado en la cabecera, utilice `X-USER-ID key==$http_x_user_id`.</li>
  <li><code><em>&lt;rate&gt;</em></code>: La velocidad.</li>
  <li><code><em>&lt;conn&gt;</em></code>: El número de conexiones.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


## Afinidad de sesión con cookies (sticky-cookie-services)
{: #sticky-cookie-services}

Utilice la anotación de cookie sticky para añadir afinidad de sesión al controlador de Ingress y direccionar siempre el tráfico de red entrante al mismo servidor en sentido ascendente.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Para la alta disponibilidad, es posible que la configuración de la app requiera que despliegue varios servidores en sentido ascendente para que gestionen las solicitudes entrantes del cliente y garanticen una mayor disponibilidad. Cuando un cliente se conecta a la app de fondo, podría ser útil que un cliente recibiera el servicio del mismo servidor en sentido ascendente mientras dure la sesión o durante el tiempo que se tarda en completar una tarea. Puede configurar el controlador de Ingress de modo que asegure la afinidad de sesión direccionando siempre el tráfico de red de entrada al mismo servidor en sentido ascendente.

</br></br>
El controlador de Ingress asigna cada cliente que se conecta a la app de fondo a uno de los servidores en sentido ascendente disponibles. El controlador de Ingress crea una cookie de sesión que se almacena en la app del cliente y que se incluye en la información de cabecera de cada solicitud entre el controlador de Ingress y el cliente. La información de la cookie garantiza que todas las solicitudes se gestionan en el mismo servidor en sentido ascendente durante todo el periodo de la sesión.

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
  <caption>Visión general de los componentes del archivo YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;service_name&gt;</em></code>: El nombre del servicio de Kubernetes que ha creado para la app.</li>
  <li><code><em>&lt;cookie_name&gt;</em></code>: Elija un nombre de la "sticky cookie" que se ha creado durante una sesión.</li>
  <li><code><em>&lt;expiration_time&gt;</em></code>: el tiempo, en segundos, minutos h horas, que transcurre antes de que caduque la "sticky cookie". Este tiempo depende de la actividad del usuario. Una vez caducada la cookie, el navegador web del cliente la suprime y se deja de enviar al controlador de Ingress. Por ejemplo, para establecer un tiempo de caducidad de 1 segundo, 1 minutos o 1 hora, escriba <strong>1s</strong>, <strong>1m</strong> o <strong>1h</strong>.</li>
  <li><code><em>&lt;cookie_path&gt;</em></code>: La vía de acceso que se añade al subdominio de Ingress y que indica los dominios y subdominios para los que se envía la cookie al controlador de Ingress. Por ejemplo, si el dominio de Ingress es <code>www.myingress.com</code> y desea enviar la cookie en cada solicitud del cliente, debe establecer <code>path=/</code>. Si desea enviar la cookie solo para <code>www.myingress.com/myapp</code> y todos sus subdominios, establezca este valor en <code>path=/myapp</code>.</li>
  <li><code><em>&lt;hash_algorithm&gt;</em></code>: El algoritmo hash que protege la información de la cookie. Solo se admite <code>sha1
</code>. SHA1 crea una suma de hash en función de la información de la cookie y añade esta suma de hash a la cookie. El servidor puede descifrar la información de la cookie y verificar la integridad de los datos.
  </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

<br />


## Soporte de servicios SSL (ssl-services)
{: #ssl-services}

Permite las solicitudes HTTPS y cifra el tráfico en las apps ascendentes.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Cifra el tráfico en las apps ascendentes y requieren HTTPS con controladores de Ingress.
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Sustituya <em>&lt;myingressname&gt;</em> por el nombre del recurso de Ingress.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;myservice&gt;</em></code>: Especifique el nombre del servicio que representa su app. El tráfico está cifrado desde el controlador de Ingress a la app.</li>
  <li><code><em>&lt;ssl-secret&gt;</em></code>: Especifique el secreto del servicio. Este parámetro
es opcional. Si se proporciona el parámetro, el valor debe contener la clave y el certificado que la app espera del cliente.</li></ul>
  </td>
  </tr>
  <tr>
  <td><code>rules/host</code></td>
  <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM.<br><br>
  <strong>Nota:</strong> No utilice * para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
  </tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Sustituya <em>&lt;myservicepath&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.
</br>
  Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

  </br></br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.
  </br>
  Ejemplos: <ul><li>Para <code>http://ingress_host_name/</code>, escriba <code>/</code> como vía de acceso.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso.</li></ul>
  </br>
  <strong>Sugerencia:</strong> Para configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la <a href="#rewrite-path" target="_blank">anotación de reescritura</a> para establecer la ruta adecuada para su app.
        </td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app. </td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />


### Soporte de servicios SSL con autenticación
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Sustituya <em>&lt;myingressname&gt;</em> por el nombre del recurso de Ingress.</td>
  </tr>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;service&gt;</em></code>: Especifique el nombre del servicio.</li>
  <li><code><em>&lt;service-ssl-secret&gt;</em></code>: Especifique el secreto del servicio. </li></ul>
  </td>
  </tr>
  <tr>
  <td><code>tls/host</code></td>
  <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM.<br><br>
  <strong>Nota:</strong> No utilice * para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
  </tr>
  <tr>
  <td><code>tls/secretName</code></td>
  <td>Sustituya <em>&lt;secret_name&gt;</em> por el nombre del clúster en el que está el certificado y, para la autenticación mutua, la clave.
</tr>
  <tr>
  <td><code>rules/path</code></td>
  <td>Sustituya <em>&lt;myservicepath&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.
</br>
  Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

  </br></br>
  Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.
  </br>
  Ejemplos: <ul><li>Para <code>http://ingress_host_name/</code>, escriba <code>/</code> como vía de acceso.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso.</li></ul>
  </br>
  <strong>Sugerencia:</strong> Para configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la <a href="#rewrite-path" target="_blank">anotación de reescritura</a> para establecer la ruta adecuada para su app.
        </td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app. </td>
  </tr>
  <tr>
  <td><code>servicePort</code></td>
  <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
  </tr>
  </tbody></table>

  </dd>



<dt>YAML de secreto de ejemplo para la autenticación unidireccional</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Sustituya <em>&lt;secret_name&gt;</em> por el nombre del recurso de secreto.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Sustituya el siguiente valor:<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>: Especifique el nombre del certificado de confianza.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>

  </dd>

<dt>YAML de secreto de ejemplo para la autenticación mutua</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>name</code></td>
  <td>Sustituya <em>&lt;secret_name&gt;</em> por el nombre del recurso de secreto.</td>
  </tr>
  <tr>
  <td><code>data</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;certificate_name&gt;</em></code>: Especifique el nombre del certificado de confianza.</li>
  <li><code><em>&lt;client_certificate_name&gt;</em></code>: Especifique el nombre del certificado de cliente.</li>
  <li><code><em>&lt;certificate_key&gt;</em></code>: Especifique la clave del certificado de cliente.</li></ul>
  </td>
  </tr>
  </tbody></table>

  </dd>
</dl>

<br />



## Puertos TCP para los controladores de Ingress (tcp-ports)
{: #tcp-ports}

Acceda a una app a través de un puerto TCP no estándar.{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>
Utilice esta anotación para una app que esté ejecutando una carga de trabajo con secuencias TCP. <p>**Nota**: El controlador de Ingress funciona en modalidad de paso y envía tráfico a las apps de fondo. En este caso, no se soporta la terminación SSL.</p>
</dd>


 <dt>YAML del recurso de Ingress de ejemplo</dt>
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
  <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes:<ul>
  <li><code><em>&lt;ingressPort&gt;</em></code>: El puerto TCP en el que desea acceder a la app.</li>
  <li><code><em>&lt;serviceName&gt;</em></code>: El nombre del servicio de Kubernetes para acceder a través de un puerto TCP no estándar.</li>
  <li><code><em>&lt;servicePort&gt;</em></code>: Este parámetro es opcional. Cuando se proporciona, el puerto se sustituye por este valor antes de que el tráfico se envíe a la app de backend. En caso contrario, el puerto permanece igual que el puerto de Ingress.</li>
  </ul>
  </td>
  </tr>
  </tbody></table>
  </dd>
  </dl>

  <br />


  ## Estado activo en sentido ascendente (upstream-keepalive)
  {: #upstream-keepalive}

  Configure el número máximo de conexiones de estado activo en sentido ascendente para un servidor en sentido ascendente.{:shortdesc}

  <dl>
  <dt>Descripción</dt>
  <dd>
 Cambia el número máximo de conexiones de estado activo desocupadas para el servidor en sentido ascendente de un servicio determinado. El servidor en sentido ascendente tiene 64 conexiones de estado activo desocupadas de forma predeterminada.</dd>


   <dt>YAML del recurso de Ingress de ejemplo</dt>
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
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>annotations</code></td>
    <td>Sustituya los valores siguientes:<ul>
    <li><code><em>&lt;serviceName&gt;</em></code>: Sustituya <em>&lt;service_name&gt;</em> por el nombre del servicio de Kubernetes que ha creado para la app. </li>
    <li><code><em>&lt;keepalive&gt;</em></code>: Sustituya <em>&lt;max_connections&gt;</em> por el número máximo de conexiones de estado activo desocupadas para el servidor en sentido ascendente. El valor predeterminado es 64. Un valor de cero inhabilita las conexiones de estado activo en sentido ascendente para el servicio determinado.</li>
    </ul>
    </td>
    </tr>
    </tbody></table>
    </dd>
    </dl>


