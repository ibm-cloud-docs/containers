---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

subcollection: containers

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
{:preview: .preview}



# Modificación del comportamiento de Ingress predeterminado
{: #ingress-settings}

Después de exponer las apps creando un recurso Ingress, puede configurar los ALB de Ingress en el clúster mediante la configuración de las opciones siguientes.
{: shortdesc}

## Apertura de puertos en el ALB de Ingress
{: #opening_ingress_ports}

De forma predeterminada, sólo los puertos 80 y 443 están expuestos en el ALB de Ingress. Para exponer otros puertos, puede editar el recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.
{: shortdesc}

1. Edite el archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Añada una sección <code>data</code> y especifique los puertos públicos `80`, `443`, y cualquier otro puerto que desee exponer de forma separada mediante un punto y coma (;).

    De forma predeterminada, los puertos 80 y 443 están abiertos. Si desea mantener los puertos 80 y 443 abiertos, también debe incluirlos, además de cualquier otro puerto que especifique en el campo `public-ports`. Los puertos que no se especifiquen, permanecerán cerrados. Si ha habilitado un ALB privado, también debe especificar los puertos que desea mantener abiertos en el campo `private-ports`.
    {: important}

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    Ejemplo que mantiene abiertos los puertos `80`, `443` y `9443`:
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Guarde el archivo de configuración.

4. Verifique que se hayan aplicado los cambios del mapa de configuración.
  ```
  kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
  ```
  {: pre}

5. Opcional:
  * Acceda a una app mediante un puerto TCP no estándar que ha abierto mediante la anotación [`tcp-ports`](/docs/containers?topic=containers-ingress_annotation#tcp-ports).
  * Cambie los puertos predeterminados para el tráfico de red HTTP (puerto 80) y HTTPS (puerto 443) por un puerto que ha abierto mediante la anotación [`custom-port`](/docs/containers?topic=containers-ingress_annotation#custom-port).

Para obtener más información sobre los recursos configmap, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).

<br />


## Conservación de la dirección IP de origen
{: #preserve_source_ip}

De forma predeterminada, la dirección IP de origen de la solicitud de cliente no se conserva. Cuando una solicitud de cliente para su app se envía a su clúster, la solicitud se direcciona a un pod para el servicio de equilibrador de carga que expone el ALB. Si no existen pods de app en el mismo nodo trabajador que el pod del servicio equilibrador de carga, el equilibrador de carga reenvía las solicitudes a un pod de app en un nodo trabajador diferente. La dirección IP de origen del paquete se cambia a la dirección IP pública del nodo trabajador donde el pod de app está en ejecución.
{: shortdesc}

Para conservar la dirección IP de origen original de la solicitud de cliente, puede habilitar la [conservación de IP de origen ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer). Conservar la dirección IP del cliente es útil, por ejemplo, cuando los servidores de apps tienen que aplicar políticas de control de acceso y seguridad.

Si [inhabilita un ALB](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure), cualquier cambio de IP de origen que realice en el servicio del equilibrador de carga que exponga el ALB se perderá. Cuando vuelva a habilitar el ALB, debe volver a habilitar la IP de origen.
{: note}

Para habilitar la conservación de IP de origen, edite el servicio del equilibrador de carga que expone un ALB de Ingress:

1. Habilite la conservación de IP de origen para un único ALB o para todos los ALB del clúster.
    * Para configurar la conservación de IP de origen para un solo ALB:
        1. Obtenga el ID del ALB para el que desea habilitar la IP de origen. Los servicios de ALB tienen un formato parecido a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` para ALB público o a `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` para ALB privado.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Abra el archivo YAML para el servicio de equilibrador de carga que expone el ALB.
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. En **`spec`**, cambie el valor de **`externalTrafficPolicy`**, `Cluster`, por `Local`.

        4. Guarde y cierre el archivo de configuración. La salida se parece a la siguiente:

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * Para configurar la conservación de IP para todos los ALB públicos del clúster, ejecute el siguiente mandato:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Salida de ejemplo:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * Para configurar la conservación de IP para todos los ALB privados del clúster, ejecute el siguiente mandato:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Salida de ejemplo:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Verifique que la IP de origen se conserva en los registros de los pods del ALB.
    1. Obtenga el ID de un pod correspondiente al ALB que ha modificado.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Abra los registros correspondientes a dicho pod ALB. Verifique que la dirección IP correspondiente al campo `client` es la dirección IP de la solicitud del cliente en lugar de la dirección IP del servicio del equilibrador de carga.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. Ahora, cuando busque las cabeceras de las solicitudes que se envían a la app de programa de fondo, puede ver la dirección IP del cliente en la cabecera `x-forwarded-for`.

4. Si ya no desea conservar la IP de origen, puede revertir los cambios que ha realizado en el servicio.
    * Para revertir la conservación de IP de origen para los ALB públicos:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * Para revertir la conservación de IP de origen para los ALB privados:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## Configuración de protocolos SSL y cifrados SSL a nivel HTTP
{: #ssl_protocols_ciphers}

Habilite los protocolos SSL y cifrados a nivel HTTP global editando el mapa de configuración `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

Para cumplir con la directriz del Consejo de Estándares de Seguridad de PCI, el servicio de Ingress inhabilita TLS 1.0 y 1.1 de forma predeterminada con la siguiente actualización de versión de los pods de Ingress ALB del 23 de enero de 2019. La actualización despliega automáticamente todos los clústeres {{site.data.keyword.containerlong_notm}} que no han optado por ejecutar las actualizaciones automáticas de ALB. Si los clientes que se conectan a las apps dan soporte a TLS 1.2, no se requiere ninguna acción. Si aún tiene clientes anteriores que necesitan soporte de TLS 1.0 o 1.1, debe habilitar manualmente las versiones de TLS necesarias. Siga los pasos de esta sección para cambiar el valor predeterminado a fin de utilizar en los protocolos TLS 1.1 o 1.0. Para obtener más información sobre cómo ver las versiones de TLS que utilizan los clientes para acceder a las apps, consulte esta [publicación del blog de {{site.data.keyword.cloud_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).
{: important}

Cuando se especifican los protocolos habilitados para todos los hosts, los parámetros TLSv1.1 y TLSv1.2 (1.1.13, 1.0.12) solo funcionan cuando se utiliza OpenSSL 1.0.1 o superior. El parámetro TLSv1.3 (1.13.0) sólo funciona cuando se utiliza OpenSSL 1.1.1 creado con soporte de TLSv1.3.
{: note}

Para editar el mapa de configuración para habilitar los cifrados y los protocolos SSL:

1. Edite el archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Añada los cifrados y los protocolos SSL. Dé formato a los cifrados de acuerdo con [el formato de lista de cifrado de la biblioteca de OpenSSL ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
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

<br />


## Aumentar el tiempo de comprobación de disponibilidad de reinicio para pods de ALB
{: #readiness-check}

Aumente la cantidad de tiempo que los pods de ALB tienen que analizar los archivos de recursos Ingress de gran tamaño cuando se reinician los pods de ALB.
{: shortdesc}

Cuando se reinicia un pod de ALB, como después de haber aplicado una actualización, una comprobación de disponibilidad impide que el pod de ALB intente dirigir las solicitudes de tráfico hasta que se analicen todos los
archivos de recurso de Ingress. Esta comprobación de preparación evita la pérdida de solicitudes cuando se reinician los pods de ALB. De forma predeterminada, la comprobación de preparación espera 15 segundos tras el reinicio del
pod antes de empezar a comprobar si se han analizado todos los archivos de Ingress. Si todos los archivos se analizan 15 segundos después de que se reinicia el pod, el pod ALB comienza a direccionar las solicitudes de tráfico de nuevo. Si no se analizan todos los archivos 15 segundos después de que se reinicie el pod, el pod no direcciona el tráfico, y la comprobación de preparación continúa comprobando cada 15 segundos, durante un máximo de 5 minutos. Después de 5 minutos, el pod de ALB comienza a direccionar el tráfico.

Si tiene archivos de recursos de Ingress muy grandes, puede tardar más de 5 minutos en que todos los archivos se analicen. Puede cambiar los valores predeterminados para la frecuencia del intervalo de comprobación de disponibilidad y para el tiempo total de espera de comprobación de disponibilidad añadiendo los valores `ingress-resource-creation-rate` e `ingress-resource-timeout` al configmap `ibm-cloud-provider-ingress-cm`.

1. Edite el archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. En la sección **data**, añada los valores `ingress-resource-creation-rate` e `ingress-resource-timeout`. Los valores se pueden formatear como segundos (`s`) y minutos (`m`). Ejemplo:
   ```
   apiVersion: v1
   data:
     ingress-resource-creation-rate: 1m
     ingress-resource-timeout: 6m
     keep-alive: 8s
     private-ports: 80;443
     public-ports: 80;443
   ```
   {: codeblock}

3. Guarde el archivo de configuración.

4. Verifique que se hayan aplicado los cambios del mapa de configuración.
   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Ajuste del rendimiento de ALB
{: #perf_tuning}

Para optimizar el rendimiento de los ALB de Ingress, puede cambiar los valores predeterminados de acuerdo con sus necesidades.
{: shortdesc}

### Adición de escuchas de socket ALB a cada nodo trabajador
{: #reuse-port}

Aumente el número de escuchas de socket de ALB de uno por clúster a uno por nodo trabajador utilizando la directiva Ingress `reuse-port`.
{: shortdesc}

Cuando la opción `reuse-port` está inhabilitada, un solo socket de escucha notifica a los trabajadores sobre las conexiones entrantes y todos los nodos trabajadores intentan asumir la conexión. Pero cuando `reuse-port` está habilitado, hay una escucha de socket por cada nodo trabajador para cada combinación de dirección IP y puerto ALB. En lugar de que cada nodo trabajador que intenta asumir la conexión, el kernel de Linux determina qué escucha de socket disponible es la que obtiene la conexión. La contención de bloqueo entre los trabajadores se reduce, lo que puede mejorar el rendimiento. Para obtener más información sobre las
ventajas y desventajas de la directiva `reuse-port`, consulte [este blog de NGINX ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.nginx.com/blog/socket-sharding-nginx-release-1-9-1/).

Puede escalar los escuchas editando el configmap (mapa de configuración) de Ingress `ibm-cloud-provider-ingress-cm`.

1. Edite el archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. En la sección `metadata`, añada `reuse-port: "true"`. Ejemplo:
   ```
   apiVersion: v1
   data:
     private-ports: 80;443;9443
     public-ports: 80;443
   kind: ConfigMap
   metadata:
     creationTimestamp: "2018-09-28T15:53:59Z"
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
     resourceVersion: "24648820"
     selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
     uid: b6ca0c36-c336-11e8-bf8c-bee252897df5
     reuse-port: "true"
   ```
   {: codeblock}

3. Guarde el archivo de configuración.

4. Verifique que se hayan aplicado los cambios del mapa de configuración.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Habilitación del almacenamiento intermedio de registro y el tiempo de espera excedido de vaciado
{: #access-log}

De forma predeterminada, el ALB de Ingress registra cada solicitud a medida que llega. Si tiene un entorno que se utiliza mucho, registrar cada solicitud a medida que llega puede aumentar enormemente la utilización de E/S de disco. Para evitar la E/S de disco continua, puede habilitar el almacenamiento intermedio de registro y el tiempo de espera de vaciado para el ALB editando el mapa de configuración `ibm-cloud-provider-ingress-cm` de Ingress. Cuando se habilita el almacenamiento intermedio, en lugar de llevar a cabo una operación de escritura independiente para cada entrada de registro, el ALB almacena una serie de entradas en el almacenamiento intermedio y las escribe en el archivo de forma conjunta en una sola operación.
{: shortdesc}

1. Cree y edite el archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Edite el mapa de configuración.
    1. Habilite el almacenamiento intermedio de registro añadiendo el campo `access-log-buffering` y configurándolo en `"true"`.

    2. Establezca el umbral en el que el ALB debe escribir el contenido del almacenamiento intermedio en el registro.
        * Intervalo de tiempo: añada el campo `flush-interval` y defínalo en la frecuencia con la que el ALB debe escribir en el registro. Por ejemplo, si se utiliza el valor predeterminado de `5m`, el ALB escribe el contenido del almacenamiento intermedio en el registro una vez cada 5 minutos.
        * Tamaño de almacenamiento intermedio: añada el campo `buffer-size` y establézcalo en la cantidad de memoria de registro que se puede retener en el almacenamiento intermedio antes de que el ALB escriba el contenido del almacenamiento intermedio en el registro. Por ejemplo, si se utiliza el valor predeterminado de `100KB`, el ALB escribe el contenido del almacenamiento intermedio en el registro cada vez que el almacenamiento intermedio alcanza 100 kb de contenido de registro.
        * Intervalo de tiempo o tamaño de almacenamiento intermedio: cuando se establecen los valores tanto de `flush-interval` como de `buffer-size`, el ALB escribe el contenido del almacenamiento intermedio en el registro basándose en el parámetro de umbral que se cumpla primero.

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. Guarde el archivo de configuración.

4. Verifique que el ALB está configurado con los cambios de registro de acceso.

   ```
   kubectl logs -n kube-system <ALB_ID> -c nginx-ingress
   ```
   {: pre}

### Cambio del número o la duración de las conexiones de estado activo
{: #keepalive_time}

Las conexiones de estado activo pueden tener un gran impacto en el rendimiento al reducir el uso de CPU y de red necesario para abrir y cerrar conexiones. Para optimizar el rendimiento de los ALB, puede cambiar el número máximo de conexiones de estado activo entre el ALB y el cliente y el tiempo que pueden durar las conexiones de estado activo.
{: shortdesc}

1. Edite el archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Cambie los valores de `keep-alive-requests` y `keep-alive`.
    * `keep-alive-requests`: el número de conexiones de cliente de estado activo que pueden permanecer abiertas en el ALB de Ingress. El valor predeterminado es `4096`.
    * `keep-alive`: el tiempo de espera, en segundos, durante el cual la conexión del cliente en estado activo permanece abierta para el ALB de Ingress. El valor predeterminado es `8s`.
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
     keep-alive: "8s"
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

### Cambio del proceso de conexiones pendientes
{: #backlog}

Puede reducir el valor de proceso predeterminado para el número de conexiones pendientes que pueden esperar en la cola del servidor.
{: shortdesc}

En el mapa de configuración de Ingress `ibm-cloud-provider-ingress-cm`, el campo `backlog` establece el número máximo de conexiones pendientes que pueden esperar en la cola del servidor. De forma predeterminada, `backlog` se establece en `32768`. Puede modificar el valor predeterminado editando el mapa de configuración de Ingress.

1. Edite el archivo de configuración del recurso del mapa de configuración `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Cambie el valor de `backlog` de `32768` por un valor menor. El valor debe ser igual o inferior a 32768.

   ```
   apiVersion: v1
   data:
     backlog: "32768"
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

### Ajuste del rendimiento de kernel
{: #ingress_kernel}

Para optimizar el rendimiento de los ALB de Ingress, también puede [cambiar los parámetros `sysctl` del kernel de Linux en los nodos trabajadores](/docs/containers?topic=containers-kernel). Los nodos trabajadores se suministran automáticamente con un ajuste de kernel optimizado, por lo que sólo cambian estos valores si tiene requisitos de optimización de rendimiento específicos.
{: shortdesc}

<br />

