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

# Registro y supervisión de Ingress
{: #ingress_health}

Personalice el registro y configure la supervisión para ayudarle a resolver los problemas y a mejorar el rendimiento de la configuración de Ingress.
{: shortdesc}

## Visualización de registros de Ingress
{: #ingress_logs}

Los registros se recopilan automáticamente para los ALB de Ingress. Para ver los registros de ALB, elija entre dos opciones.
* [Cree una configuración de registro para el servicio Ingress](cs_health.html#configuring) en el clúster.
* Consulte los registros desde la CLI.
    1. Obtenga el ID de un pod para un ALB.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Abra los registros correspondientes a dicho pod ALB. Verifique que los registros siguen el formato actualizado.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

</br>El contenido de registro de Ingress predeterminado se formatea en JSON y muestra los campos comunes que describen la sesión de conexión entre un cliente y la app. Un registro de ejemplo con los campos predeterminados tiene el aspecto siguiente:

```
{"time_date": "2018-08-21T17:33:19+00:00", "client": "108.162.248.42", "host": "albhealth.multizone.us-south.containers.appdomain.cloud", "scheme": "http", "request_method": "GET", "request_uri": "/", "request_id": "c2bcce90cf2a3853694da9f52f5b72e6", "status": 200, "upstream_addr": "192.168.1.1:80", "upstream_status": 200, "request_time": 0.005, "upstream_response_time": 0.005, "upstream_connect_time": 0.000, "upstream_header_time": 0.005}
```
{: screen}

<table>
<caption>Campos en el formato de registro de Ingress predeterminado</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icono de idea"/> Campos en el formato de registro de Ingress predeterminado</th>
</thead>
<tbody>
<tr>
<td><code>"time_date": "$time_iso8601"</code></td>
<td>La hora local en el formato estándar ISO 8601 cuando se graba el registro.</td>
</tr>
<tr>
<td><code>"client": "$remote_addr"</code></td>
<td>La dirección IP del paquete de la solicitud que el cliente ha enviado a la app. Esta dirección IP puede cambiar en función de las situaciones siguientes:<ul><li>Cuando una solicitud de cliente para su app se envía a su clúster, la solicitud se direcciona a un pod para el servicio de equilibrador de carga que expone el ALB. Si no existen pods de app en el mismo nodo trabajador que el pod del servicio equilibrador de carga, el equilibrador de carga reenvía las solicitudes a un pod de app en un nodo trabajador diferente. La dirección IP de origen del paquete de la solicitud se cambia por la dirección IP pública del nodo trabajador en el que se ejecuta el pod de la app.</li><li>Si [la conservación de IP de origen está habilitada](cs_ingress.html#preserve_source_ip), en su lugar se registra la dirección IP original de la solicitud de cliente a la app.</li></ul></td>
</tr>
<tr>
<td><code>"host": "$http_host"</code></td>
<td>El host, o subdominio, a través del que se puede acceder a las apps. Este host se configura en los archivos de recursos de Ingress de los ALB.</td>
</tr>
<tr>
<td><code>"scheme": "$scheme"</code></td>
<td>El tipo de solicitud: <code>HTTP</code> o <code>HTTPS</code>.</td>
</tr>
<tr>
<td><code>"request_method": "$request_method"</code></td>
<td>El método de la llamada de solicitud a la app de fondo, como por ejemplo <code>GET</code> o <code>POST</code>.</td>
</tr>
<tr>
<td><code>"request_uri": "$uri"</code></td>
<td>El URI de solicitud original a la vía de acceso de la app. Los ALB procesan las vías de acceso en las que escuchan las apps como prefijos. Cuando un ALB recibe una solicitud de un cliente a una app, el ALB comprueba el recurso de Ingress para una vía de acceso (como prefijo) que coincide con la vía de acceso del URI de solicitud.</td>
</tr>
<tr>
<td><code>"request_id": "$request_id"</code></td>
<td>Un identificador de solicitud exclusivo generado a partir de 16 bytes aleatorios.</td>
</tr>
<tr>
<td><code>"status": $status</code></td>
<td>El código de estado para la sesión de conexión.<ul>
<li><code>200</code>: la sesión se ha completado correctamente</li>
<li><code>400</code>: los datos de cliente no se pueden analizar</li>
<li><code>403</code>: acceso prohibido; por ejemplo, cuando el acceso está limitado para determinadas direcciones IP de cliente</li>
<li><code>500</code>: error de servidor interno</li>
<li><code>502</code>: pasarela errónea; por ejemplo, si un servidor en sentido ascendente no se puede seleccionar o alcanzar</li>
<li><code>503</code>: servicio no disponible; por ejemplo, cuando el acceso está limitado por el número de conexiones</li>
</ul></td>
</tr>
<tr>
<td><code>"upstream_addr": "$upstream_addr"</code></td>
<td>La dirección IP y el puerto o la vía de acceso al socket de dominio de UNIX del servidor en sentido ascendente. Si se contacta con varios servidores durante el proceso de solicitud, sus direcciones se separan mediante comas: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock"</code>. Si la solicitud se redirige internamente de un grupo de servidores a otro, las direcciones de servidor de distintos grupos se separan por dos puntos: <code>"192.168.1.1:80, 192.168.1.2:80, unix:/tmp/sock : 192.168.10.1:80, 192.168.10.2:80"</code>. Si el ALB no puede seleccionar un servidor, en su lugar se registra el nombre del grupo de servidores.</td>
</tr>
<tr>
<td><code>"upstream_status": $upstream_status</code></td>
<td>El código de estado de la respuesta que se obtiene del servidor en sentido ascendente para la app de fondo, como códigos de respuesta HTTP estándar. Los códigos de estado de varias respuestas se separan mediante comas y puntos, como las direcciones en la variable <code>$upstream_addr</code>. Si el ALB no puede seleccionar un servidor, se registra el código de estado 502 (Pasarela errónea).</td>
</tr>
<tr>
<td><code>"request_time": $request_time</code></td>
<td>El tiempo de proceso de la solicitud, medido en segundos con una resolución de milisegundos. Este tiempo empieza cuando el ALB lee los primeros bytes de la solicitud de cliente y se detiene cuando el ALB envía los últimos bytes de la respuesta al cliente. El registro se graba inmediatamente después de que se detenga el tiempo de proceso de la solicitud.</td>
</tr>
<tr>
<td><code>"upstream_response_time": $upstream_response_time</code></td>
<td>El tiempo que tarda el ALB en recibir la respuesta del servidor en sentido ascendente para la app de fondo, medido en segundos con una resolución de milisegundos. Los tiempos de varias respuestas se separan mediante comas y puntos, como las direcciones en la variable <code>$upstream_addr</code>.</td>
</tr>
<tr>
<td><code>"upstream_connect_time": $upstream_connect_time</code></td>
<td>El tiempo que tarda el ALB en establecer una conexión con el servidor en sentido ascendente para la app de fondo, medido en segundos con una resolución de milisegundos. Si TLS/SSL está habilitado en la configuración de recursos de Ingress, este tiempo incluye el tiempo empleado en el reconocimiento. Los tiempos de varias conexiones se separan mediante comas y puntos, como las direcciones en la variable <code>$upstream_addr</code>.</td>
</tr>
<tr>
<td><code>"upstream_header_time": $upstream_header_time</code></td>
<td>El tiempo que tarda el ALB en recibir la cabecera de respuesta del servidor en sentido ascendente para la app de fondo, medido en segundos con una resolución de milisegundos. Los tiempos de varias conexiones se separan mediante comas y puntos, como las direcciones en la variable <code>$upstream_addr</code>.</td>
</tr>
</tbody></table>

## Personalización del formato y el contenido del registro
{: #ingress_log_format}

Existe la posibilidad de personalizar el contenido y los formatos de los registros que se recopilan para el ALB de Ingress.
{:shortdesc}

De forma predeterminada, los registros de Ingress están en formato JSON y visualizan los campos más comunes del registro. Sin embargo, también puede crear un formato de registro personalizado. Siga estos pasos para elegir los componentes de registro que se reenviarán y su disposición en la salida del registro:

1. Cree y abra una versión local del archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Añada una sección <code>data</code>. Añada el campo `log-format` y, de forma opcional, el campo `log-format-escape-json`.

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
    <caption>Componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/>Descripción de la configuración del formato de registro</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>Sustituya <code>&lt;key&gt;</code> con el nombre del componente de registro y <code>&lt;log_variable&gt;</code> con una variable para el componente de registro del que desea recopilar entradas de registro. Puede incluir texto y puntuación que desea que contenga la entrada de registro como, por ejemplo, comillas alrededor de valores de serie y comas para separar los componentes de registro. Por ejemplo, la aplicación del formato de un componente como, por ejemplo, <code>request: "$request"</code>, generará la siguiente entrada en una entrada de registro: <code>request: "GET / HTTP/1.1",</code>. Para obtener una lista de todas las variables que se pueden utilizar, consulte <a href="http://nginx.org/en/docs/varindex.html">Índice de variables de Nginx</a>.<br><br>Para registrar una cabecera adicional como, por ejemplo, <em>x-custom-ID</em>, añada el siguiente par de clave/valor al contenido de registro personalizado: <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>Los guiones (<code>-</code>) se convierten en caracteres de subrayado (<code>_</code>). También se debe añadir <code>$http_</code> como prefijo al nombre de cabecera personalizado.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>Opcional: De forma predeterminada, los registros se generan en formato de texto. Para generar registros en formato JSON, añada el campo <code>log-format-escape-json</code> campo y utilice el valor <code>true</code>.</td>
    </tr>
    </tbody></table>

    Por ejemplo, su formato de registro podría contener las siguientes variables:
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

    Una entrada de registro de acuerdo con este formato sería similar al siguiente ejemplo:
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    Para crear un formato de registro personalizado que se base en el formato predeterminado para los registros del ALB, modifique la sección siguiente según sea necesario y añada a su configmap:
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

4. Guarde el archivo de configuración.

5. Verifique que se hayan aplicado los cambios del mapa de configuración.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

4. Para ver los registros del ALB de Ingress, elija entre dos opciones.
    * [Cree una configuración de registro para el servicio Ingress](cs_health.html#logging) en el clúster.
    * Consulte los registros desde la CLI.
        1. Obtenga el ID de un pod para un ALB.
            ```
            kubectl get pods -n kube-system | grep alb
            ```
            {: pre}

        2. Abra los registros correspondientes a dicho pod ALB. Verifique que los registros siguen el formato actualizado.
            ```
            kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
            ```
            {: pre}

<br />




## Aumento del tamaño de la zona de memoria compartida para la recopilación de métricas de Ingress
{: #vts_zone_size}

Las zonas de memoria compartida se definen de forma que los procesos de los nodos trabajadores puedan compartir información como, por ejemplo, la memoria caché, la persistencia de sesiones y los límites de velocidad. Se configura una zona de memoria compartida, denominada zona de estado de tráfico de host virtual, para que Ingress recopile datos de métricas para un ALB.
{:shortdesc}

En el mapa de configuración de Ingress `ibm-cloud-provider-ingress-cm`, el campo `vts-status-zone-size` define el tamaño de la zona de memoria compartida para la recopilación de datos de métricas. De forma predeterminada, `vts-status-zone-size` se
establece en `10m`. Si tiene un entorno grande que requiere más memoria para la recopilación de métricas, puede modificar el valor predeterminado para utilizar en su lugar un valor mayor siguiendo estos pasos.

1. Cree y abra una versión local del archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Cambie el valor de `vts-status-zone-size` de `10m` por un valor mayor.

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

3. Guarde el archivo de configuración.

4. Verifique que se hayan aplicado los cambios del mapa de configuración.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}
