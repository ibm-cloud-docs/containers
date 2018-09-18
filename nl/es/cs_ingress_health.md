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

# Registro y supervisión de Ingress
{: #ingress_health}

Personalice el registro y configure la supervisión para ayudarle a resolver los problemas y a mejorar el rendimiento de la configuración de Ingress.
{: shortdesc}

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
