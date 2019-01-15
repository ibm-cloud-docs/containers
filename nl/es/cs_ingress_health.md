---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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

De forma predeterminada, los registros de Ingress están en formato JSON y visualizan los campos más comunes del registro. Sin embargo, también puede crear un formato de registro personalizado.



## Aumento del tamaño de la zona de memoria compartida para la recopilación de métricas de Ingress
{: #vts_zone_size}

Las zonas de memoria compartida se definen de forma que los procesos de los nodos trabajadores puedan compartir información como, por ejemplo, la memoria caché, la persistencia de sesiones y los límites de velocidad. Se configura una zona de memoria compartida, denominada zona de estado de tráfico de host virtual, para que Ingress recopile datos de métricas para un ALB.
{:shortdesc}

En el mapa de configuración de Ingress `ibm-cloud-provider-ingress-cm`, el campo `vts-status-zone-size` define el tamaño de la zona de memoria compartida para la recopilación de datos de métricas. De forma predeterminada, `vts-status-zone-size` se
establece en `10m`. Si tiene un entorno grande que requiere más memoria para la recopilación de métricas, puede modificar el valor predeterminado para utilizar en su lugar un valor mayor siguiendo estos pasos.

Antes de comenzar, asegúrese de tener el [rol de servicio de {{site.data.keyword.Bluemix_notm}} IAM
Escritor o Gestor](cs_users.html#platform) para el espacio de nombres kube-system.

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
