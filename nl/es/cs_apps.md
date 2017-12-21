---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Despliegue de apps en clústeres
{: #cs_apps}

Puede utilizar las técnicas de Kubernetes para desplegar apps y asegurarse de que sus apps están siempre activas y en funcionamiento. Por ejemplo, puede realizar actualizaciones continuas y retrotracciones sin causar a los usuarios tiempos de inactividad.
{:shortdesc}

Conozca los pasos generales para desplegar apps pulsando en un área de la imagen siguiente.

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Instale las CLI." title="Instale las CLI." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Cree un archivo de configuración para la app. Revise las mejores prácticas desde Kubernetes." title="Cree un archivo de configuración para la app. Revise las mejores prácticas desde Kubernetes." shape="rect" coords="254, 64, 486, 231" />
<area href="#cs_apps_cli" target="_blank" alt="Opción 1: Ejecute los archivos de configuración desde la CLI de Kubernetes." title="Opción 1: Ejecute los archivos de configuración desde la CLI de Kubernetes." shape="rect" coords="544, 67, 730, 124" />
<area href="#cs_cli_dashboard" target="_blank" alt="Opción 2: Inicie el panel de control de Kubernetes localmente y ejecute los archivos de configuración." title="Opción 2: Inicie el panel de control de Kubernetes localmente y ejecute los archivos de configuración." shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Inicio del panel de control de Kubernetes
{: #cs_cli_dashboard}

Abra un panel de control de Kubernetes en el sistema local para ver información sobre un clúster y sus nodos trabajadores.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure). Esta tarea precisa de la [política de acceso de administrador](cs_cluster.html#access_ov). Verifique su [política de acceso](cs_cluster.html#view_access) actual.

Puede utilizar el puerto predeterminado o definir su propio puerto para iniciar el panel de control de Kubernetes para un clúster.

1.  Para clústeres con una versión maestra de Kubernetes 1.7.4 o anterior:

    1.  Establezca el proxy con el número de puerto predeterminado.

        ```
        kubectl proxy
        ```
        {: pre}

        Salida:

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Abra el panel de control de Kubernetes en un navegador web.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  Para clústeres con una versión maestra de Kubernetes 1.8.2 o posterior:

    1.  Descargue las credenciales.

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: codeblock}

    2.  Visualice las credenciales del clúster que ha descargado. Utilice la vía de acceso de archivo que se especifica en la exportación en el paso anterior.

        Para macOS o Linux:

        ```
        cat <filepath_to_cluster_credentials>
        ```
        {: codeblock}

        Para Windows:

        ```
        escriba <filepath_to_cluster_credentials>
        ```
        {: codeblock}

    3.  Copie la señal en el campo **id-token**.

    4.  Establezca el proxy con el número de puerto predeterminado.

        ```
        kubectl proxy
        ```
        {: pre}

        La salida de la CLI es parecida a la siguiente:

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    6.  Inicie sesión en el panel de control.

        1.  Copie el siguiente URL en el navegador.

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  En la página de inicio de sesión, seleccione el método de autenticación **Señal**.

        3.  A continuación, pegue el valor **id-token** en el campo **Señal** y pulse **INICIAR SESIÓN**.

[A continuación, puede ejecutar un archivo de configuración desde el panel de control.](#cs_apps_ui)

Cuando termine de utilizar el panel de control de Kubernetes, utilice `CONTROL+C` para salir del mandato `proxy`. Después de salir, el panel de control Kubernetes deja de estar disponible. Ejecute el mandato `proxy` para reiniciar el panel de control de Kubernetes. 



<br />


## Creación de secretos
{: #secrets}

Los secretos de Kubernetes constituyen una forma segura de almacenar información confidencial, como nombres de usuario, contraseñas o claves.


<table>
<caption>Tabla. Archivos necesarios para almacenarse en secretos por tarea</caption>
<thead>
<th>Tarea</th>
<th>Archivos necesarios para almacenar en secretos</th>
</thead>
<tbody>
<tr>
<td>Añadir un servicio a un clúster</td>
<td>Ninguno. Un secreto se crea automáticamente al enlazar un servicio a un clúster.</td>
</tr>
<tr>
<td>Opcional: Configure el servicio de Ingress con TLS, si no utiliza ingress-secret. <p><b>Nota</b>: TLS ya está habilitado de forma predeterminada y ya hay un secreto creado para la conexión TLS. Para ver el secreto de TLS predeterminado:
<pre>
bx cs cluster-get &gt;CLUSTER-NAME&lt; | grep "Ingress secret"
</pre>
</p>
Para crear su propio secreto, siga los pasos de este tema.</td>
<td>Certificado de servidor y clave: <code>server.crt</code> y <code>server.key</code></td>
<tr>
<td>Cree la anotación de autenticación mutua.</td>
<td>Certificado de CA: <code>ca.crt</code></td>
</tr>
</tbody>
</table>

Para obtener más información sobre lo que se puede almacenar en secretos, consulte la [Documentación de Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/).



Para crear un secreto con un certificado:

1. Genere el certificado de la autoridad de certificados (CA) y la clave de su proveedor de certificados. Si tiene su propio dominio, compre un certificado TLS oficial para el mismo. Para realizar pruebas, puede generar un certificado firmado de forma automática.

 Importante: asegúrese de que [CN](https://support.dnsimple.com/articles/what-is-common-name/) sea diferente para cada certificado.

 El certificado de cliente y la clave de cliente se deben verificar hasta el certificado raíz de confianza, que en este caso, es el certificado de CA. Ejemplo:

 ```
 Certificado de cliente: emitido por certificado intermedio
 Certificado intermedio: emitido por certificado raíz
 Certificado raíz: emitido por sí mismo
 ```
 {: codeblock}

2. Cree el certificado como un secreto de Kubernetes.

 ```
 kubectl create secret generic <secretName> --from-file=<cert_file>=<cert_file>
 ```
 {: pre}

 Ejemplos:
 - Conexión de TLS:

 ```
 kubectl create secret tls <secretName> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
 ```
 {: pre}

 - Anotación de autenticación mutua:

 ```
 kubectl create secret generic <secretName> --from-file=ca.crt=ca.crt
 ```
 {: pre}

<br />



## Cómo permitir el acceso público a apps
{: #cs_apps_public}

Para que una app esté disponible a nivel público en Internet, debe actualizar el archivo de configuración antes de desplegar la app en un clúster.{:shortdesc}

Dependiendo de si ha creado un clúster lite o estándar, existen diversas formas de permitir el acceso a su app desde Internet.

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">Servicio NodePort</a> (clústeres de tipo lite y estándar)</dt>
<dd>Exponga un puerto público en cada nodo trabajador y utilice la dirección IP pública de cualquier nodo trabajador para acceder de forma pública al servicio en el clúster. La dirección IP pública del nodo trabajador no es permanente. Cuando un nodo trabajador se elimina o se vuelve a crear, se le asigna una nueva dirección IP pública. Puede utilizar el servicio NodePort para probar el acceso público para la app o cuando se necesita acceso público solo durante un breve periodo de tiempo. Si necesita una dirección IP pública estable y más disponibilidad para el servicio, exponga la app mediante un servicio LoadBalancer o Ingress.</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">Servicio LoadBalancer</a> (solo clústeres estándares)</dt>
<dd>Cada clúster estándar se suministra con 4 direcciones IP públicas portátiles y 4 direcciones IP privadas portátiles que puede utilizar para crear un equilibrador de carga TCP/UDP externo para la app. Puede personalizar el equilibrador de carga exponiendo cualquier puerto que necesite la app. La dirección IP pública portátil asignada al equilibrador de carga es permanente y no cambia cuando un nodo trabajador se vuelve a crear en el clúster.

</br>
Si necesita equilibrio de carga HTTP o HTTPS para la app y desea utilizar una ruta pública para exponer varias apps en el clúster como servicios, utilice el soporte de Ingress integrado en {{site.data.keyword.containershort_notm}}.</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a> (solo clústeres estándares)</dt>
<dd>Exponga varias apps en el clúster creando un equilibrador de carga HTTP o HTTPS externo que utilice un punto de entrada público seguro y exclusivo para direccionar las solicitudes entrantes a las apps. Ingress consta de dos componentes principales, el recurso de Ingress y el controlador de Ingress. El recurso de Ingress define las reglas sobre cómo direccionar y equilibrar la carga de las solicitudes de entrada para una app. Todos los recursos de Ingress deben estar registrados con el controlador de Ingress que escucha solicitudes de entrada de servicio HTTP o HTTPS y reenvía las solicitudes según las reglas definidas para cada recurso de Ingress. Utilice Ingress si desea implementar su propio equilibrador de carga con reglas de direccionamiento personalizadas y si necesita terminación SSL para sus apps.

</dd></dl>

### Configuración del acceso público a una app utilizando el tipo de servicio NodePort
{: #cs_apps_public_nodeport}

Puede poner la app a disponibilidad pública en Internet utilizando la dirección IP pública de cualquier nodo trabajador de un clúster y exponiendo un puerto de nodo. Utilice esta opción para pruebas y para acceso público de corto plazo.

{:shortdesc}

Puede exponer la app como servicio de Kubernetes de tipo NodePort para clústeres de tipo lite o estándares.

Para entornos de {{site.data.keyword.Bluemix_dedicated_notm}}, las direcciones IP están bloqueadas por un cortafuegos. Para hacer que una app esté disponible a nivel público, utilice un [servicio LoadBalancer](#cs_apps_public_load_balancer) o [Ingress](#cs_apps_public_ingress) en su lugar.

**Nota:** La dirección IP pública de un nodo trabajador no es permanente. Si el nodo trabajador se debe volver a crear, se le asigna una nueva dirección IP pública. Si necesita una dirección IP pública estable y más disponibilidad para el servicio, exponga la app utilizando un [servicio LoadBalancer](#cs_apps_public_load_balancer) o [Ingress](#cs_apps_public_ingress).




1.  Defina una sección de [servicio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/) en el archivo de configuración.
2.  En la sección `spec` del servicio, añada el tipo NodePort.

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  Opcional: En la sección `ports`, añada un NodePort comprendido entre 30000 y 32767. No especifique un NodePort que ya estén siendo utilizado por otro servicio. Si no está seguro de qué NodePorts ya se están utilizando, no es asigne ninguno. Si no se asigna ningún NodePort, se asignará automáticamente uno aleatorio.

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    Si desea especificar un NodePort y desea ver qué NodePorts ya se están utilizando, ejecute el siguiente mandato:

    ```
    kubectl get svc
    ```
    {: pre}

    Salida:

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  Guarde los cambios.
5.  Repita este paso para crear un servicio para cada app.

    Ejemplo:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**Qué es lo siguiente:**

Cuando se despliegue la app, puede utilizar la dirección IP pública de cualquier nodo trabajador y el NodePort para formar el URL público para acceder a la app en un navegador.

1.  Obtener la dirección IP pública para un nodo trabajador del clúster.

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    Salida:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
    ```
    {: screen}

2.  Si se ha asignado un NodePort aleatorio, averigüe cuál se ha asignado.

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    Salida:

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    En este ejemplo, el NodePort es `30872`.

3.  Forme el URL con el NodePort y las direcciones IP públicas del nodo trabajador. Ejemplo: `http://192.0.2.23:30872`

### Configuración del acceso a una app utilizando el tipo de servicio LoadBalancer
{: #cs_apps_public_load_balancer}

Exponga un puerto y utilice la dirección IP portátil para que el equilibrador de carga acceda a la app. Utilice una dirección IP pública para hacer una app accesible en Internet o una dirección IP privada para hacer una app accesible en la red de infraestructura privada.

A diferencia del servicio NodePort, la dirección IP portátil del servicio equilibrador de carga no depende del nodo trabajador en el que se ha desplegado la app. Sin embargo, un servicio LoadBalancer de Kubernetes es también un servicio NodePort. Un servicio LoadBalancer hace que la app está disponible en la dirección IP y puerto del equilibrador de carga y hace que la app está disponible en los puertos del nodo del servicio.

La dirección IP portátil del equilibrador de carga se asigna automáticamente y no cambia cuando se añaden o eliminan nodos trabajadores. Por lo tanto, los servicios del equilibrador de carga están más disponibles que los servicios NodePort. Los usuarios pueden seleccionar cualquier puerto para el equilibrador de carga y no están limitados al rango de puertos de NodePort. Puede utilizar los servicios equilibradores de carga para los protocolos TCP y UDP.

Cuando una cuenta de {{site.data.keyword.Bluemix_dedicated_notm}} está [habilitada para clústeres](cs_ov.html#setup_dedicated), puede solicitar que se utilicen subredes públicas para las direcciones IP del equilibrador de carga. [Abra una incidencia de soporte](/docs/support/index.html#contacting-support) para crear la subred y luego utilice el mandato [`cs bx cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) para añadir la subred al clúster.

**Nota:** Los servicios equilibradores de carga no soportan la terminación TLS. Si la app necesita terminación TLS, puede exponer la app mediante [Ingress](#cs_apps_public_ingress) o configurar la app de modo que gestione la terminación TLS.

Antes de empezar:

-   Esta característica solo está disponible para clústeres estándares.
-   Debe tener una dirección IP pública o privada portátil disponible para asignarla al servicio equilibrador de carga.
-   Un servicio de equilibrador de carga con una dirección IP privada portátil sigue teniendo un puerto de nodo público abierto en cada nodo trabajador. Para añadir una política de red para impedir el tráfico público, consulte [Bloqueo del tráfico de entrada](cs_security.html#cs_block_ingress).

Para crear un servicio equilibrador de carga:

1.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.
2.  Cree un servicio equilibrador de carga para la app que desee exponer. Para hacer que la app esté disponible en Internet público o en una red privada, debe crear un servicio Kubernetes para la app. Configure el servicio para que incluya todos los pods que forman la app en el equilibrio de carga.
    1.  Cree un archivo de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.
    2.  Defina un servicio equilibrador de carga para la app que desee exponer.
        - Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.
        - Si el clúster solo está disponible en una VLAN privada, se utiliza dirección IP privada portátil.
        - Puede solicitar una dirección IP privada o pública portátil para un servicio LoadBalancer añadiendo una anotación al archivo de configuración.

        Servicio LoadBalancer que utiliza una dirección IP predeterminada:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        Servicio LoadBalancer que utiliza una anotación para especificar una dirección IP privada o pública:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio equilibrador de carga.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor (<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>El puerto que en el que está a la escucha el servicio.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Anotación para especificar el tipo de LoadBalancer. Los valores son `private` y `public`. Cuando se crea un LoadBalancer público en clústeres en VLAN públicas, esta anotación no es necesaria.</td>
        </tbody></table>
    3.  Opcional: Para utilizar una dirección IP portátil específica para el equilibrador de carga que esté disponible para el clúster, puede especificar dicha dirección IP incluyendo `loadBalancerIP` en la sección spec. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/).
    4.  Opcional: Configure un cortafuegos especificando `loadBalancerSourceRanges` en la sección spec. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).
    5.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Cuando se crea el servicio equilibrador de carga, se asigna automáticamente una dirección IP portátil al equilibrador de carga. Si no hay ninguna dirección IP portátil disponible, no se puede crear el servicio equilibrador de carga.
3.  Verifique que el servicio de equilibrio de carga se haya creado correctamente. Sustituya _&lt;myservice&gt;_ por el nombre del servicio equilibrador de carga que ha creado en el paso anterior.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos minutos hasta que el servicio equilibrador de carga se cree correctamente y la app esté disponible.

    Ejemplo de salida de CLI:

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    La dirección IP de **LoadBalancer Ingress** es la dirección IP portátil que asignada al servicio equilibrador de carga.
4.  Si ha creado un equilibrador de carga público, acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Especifique la dirección IP pública portátil del equilibrador de carga y el puerto. En el ejemplo anterior, se ha asignado la dirección IP pública portátil `192.168.10.38` al servicio equilibrador de carga.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}




### Configuración del acceso a una app utilizando el controlador de Ingress
{: #cs_apps_public_ingress}

Exponga varias apps en el clúster creando recursos Ingress gestionados por el controlador de Ingress proporcionado por IBM. El controlador de Ingress es un equilibrador de carga HTTP o HTTPS externo que utiliza un punto de entrada público o probado seguro y exclusivo para direccionar las solicitudes entrantes a las apps dentro o fuera del clúster.

**Nota:** Ingress únicamente está disponible para los clústeres estándares y necesita de al menos dos nodos trabajadores en el clúster para asegurar la alta disponibilidad. Para configurar un servicio Ingress se necesita una [política de acceso de administrador](cs_cluster.html#access_ov). Verifique su [política de acceso](cs_cluster.html#view_access) actual.

Cuando se crea un clúster estándar, se crea automáticamente un controlador de Ingress y se le asigna una dirección IP pública portátil y una ruta pública creada y habilitada para el usuario. Además se crea un controlador de Ingress con una dirección IP privada portátil asignada y una ruta privada, pero no se habilita de forma automática. Puede configurar los controladores de Ingress y definir reglas de direccionamiento individuales para cada app que exponga a las redes públicas o privadas. A cada app que se expone al público por medio de Ingress que se le asigna una vía de acceso exclusiva que se añade a la ruta pública, para que pueda utilizar un URL exclusivo para acceder a una app de forma pública en el clúster.

Cuando una cuenta de {{site.data.keyword.Bluemix_dedicated_notm}} está [habilitada para clústeres](cs_ov.html#setup_dedicated), puede solicitar que se utilicen subredes públicas para las direcciones IP del controlador de Ingress. A continuación, se crea el controlador de Ingress y se asigna una ruta pública. [Abra una incidencia de soporte](/docs/support/index.html#contacting-support) para crear la subred y luego utilice el mandato [`cs bx cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) para añadir la subred al clúster.

Para exponer la app al público, puede configurar el controlador de Ingress para los siguientes casos. 

-   [Se utiliza el dominio proporcionado por IBM sin terminación TLS](#ibm_domain)
-   [Se utiliza el dominio proporcionado por IBM con terminación TLS](#ibm_domain_cert)
-   [Se utiliza un dominio personalizado y un certificado TLS para realizar la terminación TLS](#custom_domain_cert)
-   [Se utiliza un dominio personalizado o proporcionado por IBM con terminación TLS para acceder a las apps fuera del clúster](#external_endpoint)
-   [Abra puertos en el equilibrador de carga de Ingress](#opening_ingress_ports)
-   [Configure protocolos SSL y cifrados SSL a nivel HTTP](#ssl_protocols_ciphers)
-   [Personalice su controlador Ingress con anotaciones](cs_annotations.html)
{: #ingress_annotation}

Para exponer la app a redes privadas, primero [habilite el controlador de Ingress privado](#private_ingress). A continuación, puede configurar el controlador de Ingress para los siguientes casos. 

-   [Se utiliza un dominio personalizado sin terminación TLS](#private_ingress_no_tls)
-   [Se utiliza un dominio personalizado y un certificado TLS para realizar la terminación TLS](#private_ingress_tls)

#### Utilización del dominio proporcionado por IBM sin terminación TLS
{: #ibm_domain}

Puede configurar el controlador de Ingress como un equilibrador de carga HTTP para las apps del clúster y utilizar el dominio proporcionado por IBM para acceder a las apps desde Internet.

Antes de empezar:

-   Si aún no tiene uno, [cree un clúster estándar](cs_cluster.html#cs_cluster_ui).
-   [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure) para ejecutar mandatos `kubectl`.

Para configurar el controlador de Ingress:

1.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress.
2.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
    2.  Defina un servicio para la app que desea exponer al público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio equilibrador de carga.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor (<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>El puerto que en el que está a la escucha el servicio.</td>
         </tr>
         </tbody></table>
    3.  Guarde los cambios.
    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  Repita estos pasos para cada app que desee exponer al público.
3.  Obtenga los detalles del clúster para ver el dominio proporcionado por IBM. Sustituya _&lt;mycluster&gt;_ por el nombre del clúster en el que está desplegada la app que desea exponer al público.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    La salida de la CLI se parecerá a la siguiente.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Puede ver el dominio proporcionado por IBM en el campo **Subdominio de Ingress**.
4.  Cree un recurso de Ingress. Los recursos de Ingress definen las reglas de direccionamiento para el servicio Kubernetes que ha creado para la app y el controlador de Ingress los utiliza para direccionar el tráfico de red de entrada al servicio. Puede utilizar un recurso de Ingress para definir las reglas de direccionamiento para varias apps siempre que cada app se exponga a través de un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myingress.yaml`.
    2.  Defina un recurso de Ingress en el archivo de configuración que utilice el dominio proporcionado por IBM para direccionar el tráfico de entrada de red al servicio que ha creado anteriormente.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

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
        <td><code>host</code></td>
        <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM en el paso anterior.

        </br></br>
        <strong>Nota:</strong> No utilice * para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myservicepath1&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
        Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br></br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.
        </br>
        Ejemplos: <ul><li>Para <code>http://ingress_host_name/</code>, escriba <code>/</code> como vía de acceso.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso.</li></ul>
        </br>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la [anotación de reescritura](cs_annotations.html#rewrite-path) para establecer la ruta adecuada para su app.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
        </tr>
        </tbody></table>

    3.  Cree el recurso de Ingress para el clúster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifique que el recurso de Ingress se haya creado correctamente. Sustituya _&lt;myingressname&gt;_ por el nombre del recurso de Ingress que ha creado anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **Nota:** Pueden transcurrir unos minutos hasta que el recurso de Ingress se cree y la app esté disponible en Internet público.
6.  En un navegador web, escriba el URL del servicio de la app al que va a acceder.

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### Utilización del dominio proporcionado por IBM con terminación TLS
{: #ibm_domain_cert}

Puede configurar el controlador de Ingress de modo que gestione las conexiones TLS de entrada para las apps, descifre el tráfico de red utilizando el certificado TLS proporcionado por IBM y reenvíe la solicitud descifrada a las apps expuestas en el clúster.

Antes de empezar:

-   Si aún no tiene uno, [cree un clúster estándar](cs_cluster.html#cs_cluster_ui).
-   [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure) para ejecutar mandatos `kubectl`.

Para configurar el controlador de Ingress:

1.  [Despliegue la app en el clúster](#cs_apps_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta identifica todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress.
2.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
    2.  Defina un servicio para la app que desea exponer al público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor (<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>El puerto que en el que está a la escucha el servicio.</td>
         </tr>
         </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Repita estos pasos para cada app que desee exponer al público.

3.  Visualice el dominio proporcionado por IBM y el certificado TLS. Sustituya _&lt;mycluster&gt;_ por el nombre del clúster en el que está desplegada la app.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    La salida de la CLI se parecerá a la siguiente.

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Puede ver el dominio proporcionado por IBM en el campo **Subdominio de Ingress** y el certificado proporcionado por IBM en el campo **Secreto de Ingress**.

4.  Cree un recurso de Ingress. Los recursos de Ingress definen las reglas de direccionamiento para el servicio Kubernetes que ha creado para la app y el controlador de Ingress los utiliza para direccionar el tráfico de red de entrada al servicio. Puede utilizar un recurso de Ingress para definir las reglas de direccionamiento para varias apps siempre que cada app se exponga a través de un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myingress.yaml`.
    2.  Defina un recurso de Ingress en el archivo de configuración que utilice el dominio proporcionado por IBM para direccionar el tráfico de entrada de red a los servicios y el certificado proporcionado por IBM para gestionar automáticamente la terminación TLS. Para cada servicio puede definir una vía de acceso individual que se añade al dominio proporcionado por IBM para crear una vía de acceso exclusiva a la app, por ejemplo `https://ingress_domain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a los pods en los que se ejecuta la app.

        **Nota:** La app debe estar a la escucha en la vía de acceso que ha definido en el recurso Ingress. De lo contrario, el tráfico de red no se puede reenviar a la app. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como `/` y no especifique una vía de acceso individual para la app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

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
        <td><code>tls/hosts</code></td>
        <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM en el paso anterior. Este dominio está configurado para la terminación TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sustituya <em>&lt;ibmtlssecret&gt;</em> por el nombre del <strong>secreto de Ingress</strong> proporcionado por IBM en el paso anterior. Este certificado gestiona la terminación de TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM en el paso anterior. Este dominio está configurado para la terminación TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myservicepath1&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
        Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br>
        Ejemplos: <ul><li>Para <code>http://ingress_host_name/</code>, escriba <code>/</code> como vía de acceso.</li><li>Para <code>http://ingress_host_name/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso.</li></ul>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la [anotación de reescritura](cs_annotations.html#rewrite-path) para establecer la ruta adecuada para su app.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
        </tr>
        </tbody></table>

    3.  Cree el recurso de Ingress para el clúster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Verifique que el recurso de Ingress se haya creado correctamente. Sustituya _&lt;myingressname&gt;_ por el nombre del recurso de Ingress que ha creado anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos minutos hasta que el recurso de Ingress se cree correctamente y la app esté disponible en Internet público.
6.  En un navegador web, escriba el URL del servicio de la app al que va a acceder.

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### Utilización del controlador de Ingress con un dominio personalizado y un certificado TLS
{: #custom_domain_cert}

Puede configurar el controlador de Ingress para que direccione el tráfico de red de entrada a las apps del clúster y utilice su propio certificado TLS para gestionar la terminación de TLS, utilizando el dominio personalizado en lugar del proporcionado por IBM.
{:shortdesc}

Antes de empezar:

-   Si aún no tiene uno, [cree un clúster estándar](cs_cluster.html#cs_cluster_ui).
-   [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure) para ejecutar mandatos `kubectl`.

Para configurar el controlador de Ingress:

1.  Cree un dominio personalizado. Para crear un dominio personalizado, póngase en contacto con el proveedor de DNS (Domain Name Service) y para que registre su dominio personalizado.
2.  Configure el dominio de modo que direccione el tráfico de red de entrada al controlador de Ingress de IBM. Puede elegir entre las siguientes opciones:
    -   Defina un alias para el dominio personalizado especificando el dominio proporcionado por IBM como CNAME (Registro de nombre canónico). Para encontrar el dominio de Ingress proporcionado por IBM, ejecute `bx cs cluster-get <mycluster>` y busque el campo **Subdominio de Ingress**.
    -   Correlacione el dominio personalizado con la dirección IP pública portátil del controlador de Ingress proporcionado por IBM añadiendo la dirección IP como registro. Para buscar la dirección IP pública portátil del controlador de Ingress:
        1.  Ejecute `bx cs cluster-get <mycluster>` y busque el campo **Subdominio de Ingress**.
        2.  Ejecute `nslookup <Ingress subdomain>`.
3.  Cree un certificado TLS y una clave para el dominio que estén codificados en formato PEM.
4.  Guarde el certificado TLS y la clave en un secreto de Kubernetes.
    1.  Abra el editor que prefiera y cree un archivo de configuración de secreto de Kubernetes llamado, por ejemplo, `mysecret.yaml`.
    2.  Defina un secreto que utilice su certificado TLS y clave.

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;mytlssecret&gt;</em> por el nombre del secreto de Kubernetes.</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>Sustituya <em>&lt;tlscert&gt;</em> por su certificado TLS personalizado codificado en formato base64.</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>Sustituya <em>&lt;tlskey&gt;</em> por su clave TLS personalizada codificada en formato base64.</td>
         </tbody></table>

    3.  Guarde el archivo de configuración.
    4.  Cree el secreto de TLS para el clúster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress.

6.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster.

    1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
    2.  Defina un servicio para la app que desea exponer al público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor (<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
         </tr>
         <td><code>port</code></td>
         <td>El puerto que en el que está a la escucha el servicio.</td>
         </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Repita estos pasos para cada app que desee exponer al público.
7.  Cree un recurso de Ingress. Los recursos de Ingress definen las reglas de direccionamiento para el servicio Kubernetes que ha creado para la app y el controlador de Ingress los utiliza para direccionar el tráfico de red de entrada al servicio. Puede utilizar un recurso de Ingress para definir las reglas de direccionamiento para varias apps siempre que cada app se exponga a través de un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myingress.yaml`.
    2.  Defina un recurso de Ingress en el archivo de configuración que utilice el dominio personalizado para direccionar el tráfico de entrada de red a los servicios y el certificado personalizado para gestionar la terminación TLS. Por cada servicio puede definir una vía de acceso individual que se añade a su dominio personalizado para crear una vía de acceso exclusiva para la app, como por ejemplo `https://mydomain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a los pods en los que se ejecuta la app.

        **Nota:** Es importante que la app esté a la escucha en la vía de acceso que ha definido en el recurso de Ingress. De lo contrario, el tráfico de red no se puede reenviar a la app. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como `/` y no especifique una vía de acceso individual para la app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

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
        <td><code>tls/hosts</code></td>
        <td>Sustituya <em>&lt;mycustomdomain&gt;</em> por el dominio personalizado que desea configurar para la terminación de TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sustituya <em>&lt;mytlssecret&gt;</em> por el nombre del secreto que ha creado anteriormente y que contiene el certificado TLS personalizado y la clave para gestionar la terminación TLS para el dominio personalizado.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sustituya <em>&lt;mycustomdomain&gt;</em> por el dominio personalizado que desea configurar para la terminación de TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myservicepath1&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
        Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br></br>
        Ejemplos: <ul><li>Para <code>https://mycustomdomain/</code>, escriba <code>/</code> como vía de acceso.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso.</li></ul>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la [anotación de reescritura](cs_annotations.html#rewrite-path) para establecer la ruta adecuada para su app.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
        </tr>
        </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el recurso de Ingress para el clúster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Verifique que el recurso de Ingress se haya creado correctamente. Sustituya _&lt;myingressname&gt;_ por el nombre del recurso de Ingress que ha creado anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos minutos hasta que el recurso de Ingress se cree correctamente y la app esté disponible en Internet público.

9.  Acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Escriba el URL del servicio de la app al que desea acceder.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### Configuración del controlador de Ingress para que direcciones el tráfico de la red a apps externas al clúster
{: #external_endpoint}

Puede configurar el controlador de Ingress para que se incluyan en el equilibrio de la carga del clúster apps situadas fuera del clúster. Las solicitudes entrantes en el dominio personalizado o proporcionado por IBM se reenvían automáticamente a la app externa.

Antes de empezar:

-   Si aún no tiene uno, [cree un clúster estándar](cs_cluster.html#cs_cluster_ui).
-   [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure) para ejecutar mandatos `kubectl`.
-   Asegúrese de que se pueda acceder a la app externa que desea incluir en el equilibrio de la carga del clúster mediante una dirección IP pública.

Puede configurar el controlador de Ingress para que direccione el tráfico de red de entrada del dominio proporcionado por IBM a apps situadas fuera del clúster. Si desea utilizar en su lugar un dominio personalizado y terminación de TLS, sustituya el dominio proporcionado por IBM y el certificado de TLS por su [dominio personalizado y certificado TLS](#custom_domain_cert)dominio personalizado y certificado TLS.

1.  Configure un punto final de Kubernetes que defina la ubicación externa de la app que desea incluir en el equilibrio de la carga del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de punto final llamado, por ejemplo, `myexternalendpoint.yaml`.
    2.  Defina el punto final externo. Incluya todas las direcciones IP públicas y puertos que puede utilizar para acceder a la app externa.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myendpointname&gt;</em> por el nombre del punto final de Kubernetes.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Sustituya <em>&lt;externalIP&gt;</em> por las direcciones IP públicas que desea conectar con la app externa.</td>
         </tr>
         <td><code>port</code></td>
         <td>Sustituya <em>&lt;externalport&gt;</em> por el puerto en el que escucha la app externa.</td>
         </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el punto final de Kubernetes para el clúster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  Cree un servicio de Kubernetes para el clúster y configúrelo de modo que reenvíe las solicitudes entrantes al punto final externo que ha creado anteriormente.
    1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myexternalservice.yaml`.
    2.  Defina el servicio.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Sustituya <em>&lt;myexternalservice&gt;</em> por el nombre del servicio de Kubernetes.</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td>Sustituya <em>&lt;myendpointname&gt;</em> por el nombre del punto final de Kubernetes que ha creado anteriormente.</td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>El puerto que en el que está a la escucha el servicio.</td>
        </tr></tbody></table>

    3.  Guarde los cambios.
    4.  Cree el servicio de Kubernetes para el clúster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}

3.  Visualice el dominio proporcionado por IBM y el certificado TLS. Sustituya _&lt;mycluster&gt;_ por el nombre del clúster en el que está desplegada la app.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    La salida de la CLI se parecerá a la siguiente.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Puede ver el dominio proporcionado por IBM en el campo **Subdominio de Ingress** y el certificado proporcionado por IBM en el campo **Secreto de Ingress**.

4.  Cree un recurso de Ingress. Los recursos de Ingress definen las reglas de direccionamiento para el servicio Kubernetes que ha creado para la app y el controlador de Ingress los utiliza para direccionar el tráfico de red de entrada al servicio. Puede utilizar un recurso de Ingress para definir las reglas de direccionamiento para varias apps externas siempre que cada app esté expuesta con su punto final externo mediante un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myexternalingress.yaml`.
    2.  Defina un recurso de Ingress en el archivo de configuración que utilice el dominio proporcionado por IBM y el certificado TLS para direccionar el tráfico de entrada de red a la app externa utilizando el punto final externo que ha definido anteriormente. Para cada servicio puede definir una vía de acceso individual que se añade al dominio proporcionado por IBM o al dominio personalizado para crear una vía de acceso exclusiva a la app, por ejemplo `https://ingress_domain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a la app externa.

        **Nota:** Es importante que la app esté a la escucha en la vía de acceso que ha definido en el recurso de Ingress. De lo contrario, el tráfico de red no se puede reenviar a la app. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como / y no especifique una vía de acceso individual para la app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

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
        <td><code>tls/hosts</code></td>
        <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM en el paso anterior. Este dominio está configurado para la terminación TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sustituya <em>&lt;ibmtlssecret&gt;</em> por el <strong>secreto de Ingress</strong> proporcionado por IBM en el paso anterior. Este certificado gestiona la terminación de TLS.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM en el paso anterior. Este dominio está configurado para la terminación TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myexternalservicepath&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app externa está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
        Por cada servicio de Kubernetes, puede definir una vía de acceso individual que se añade a su dominio para crear una vía de acceso exclusiva a la app, por ejemplo <code>https://ibmdomain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red a la app externa utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br></br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br></br>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la [anotación de reescritura](cs_annotations.html#rewrite-path) para establecer la ruta adecuada para su app.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sustituya <em>&lt;myexternalservice&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app externa.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>El puerto en el que el servicio está a la escucha.</td>
        </tr>
        </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el recurso de Ingress para el clúster.

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}

5.  Verifique que el recurso de Ingress se haya creado correctamente. Sustituya _&lt;myingressname&gt;_ por el nombre del recurso de Ingress que ha creado anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos minutos hasta que el recurso de Ingress se cree correctamente y la app esté disponible en Internet público.

6.  Acceda a la app externa.
    1.  Abra el navegador web preferido.
    2.  Escriba el URL para acceder a la app externa.

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}



#### Abra puertos en el equilibrador de carga de Ingress
{: #opening_ingress_ports}

De forma predeterminada, sólo los puertos 80 y 443 están expuestos en el equilibrador de carga de Ingress. Para exponer otros puertos, edite el recurso del mapa de configuración ibm-cloud-provider-ingress-cm.

1.  Cree una versión local del archivo de configuración del recurso del mapa de configuración ibm-cloud-provider-ingress-cm. Añada una sección <code>data</code> y especifique los puertos públicos 80, 443 y otros puertos que desee añadir al archivo del mapa de configuración separados por punto y coma (;).

 Nota: al especificar los puertos, 80 y 443 se deben incluir para conservarlos abiertos. Los puertos que no se especifiquen, permanecerán cerrados.

 ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
 {: codeblock}

 Ejemplo:
 ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```

2. Aplique el archivo de configuración.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. Verifique que el archivo de configuración se ha aplicado.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 Salida:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

Para obtener más información sobre los recursos del mapa de configuración, consulte la [documentación de Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).



#### Configure protocolos SSL y cifrados SSL a nivel HTTP
{: #ssl_protocols_ciphers}

Habilite los protocolos SSL y cifrados a nivel HTTP global editando el mapa de configuración `ibm-cloud-provider-ingress-cm`.

De forma predeterminada, se utilizan los siguientes valores para los protocolos y los cifrados ssl:

```
ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
```
{: codeblock}

Para obtener más información sobre estos parámetros, consulte la documentación de NGINX para [protocolos ssl![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols) y [cifrados ssl![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers).

Para cambiar los valores predeterminados:
1. Cree una versión local del archivo de configuración del recurso del mapa de configuración ibm-cloud-provider-ingress-cm. 

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

2. Aplique el archivo de configuración.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. Verifique que el archivo de configuración se ha aplicado.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
 ```
 {: pre}

 Salida:
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
 ```
 {: screen}


#### Habilitación del controlador de Ingress privado
{: #private_ingress}

Cuando se crea un clúster estándar, se crea automáticamente un controlador de Ingress privado, pero no se habilita de forma automática. Para poder utilizar el controlador de Ingress privado, se debe habilitar con la dirección IP privada portátil asignada previamente y proporcionada por IBM o con su propia dirección IP privada portátil. **Nota**: si ha utilizado el distintivo `--no-subnet` al crear el clúster, debe añadir una subred privada portátil o una subred gestionada por el usuario para poder habilitar el controlador de Ingress privado. Para obtener más información, consulte [Solicitud de subredes adicionales para el clúster](cs_cluster.html#add_subnet).

Antes de empezar:

-   Si aún no tiene uno, [cree un clúster estándar](cs_cluster.html#cs_cluster_ui).
-   Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para habilitar el controlador de Ingress privado utilizando la dirección IP privada portátil asignada previamente y proporcionada por IBM:

1. Obtenga una lista de los controladores de Ingress disponible en el clúster para obtener el ID de ALB del controlador de Ingress privado. Sustituya <em>&lt;cluser_name&gt;</em> por el nombre del clúster en el que está desplegada la app que desea exponer.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    El campo **Estado** del controlador de Ingress privado es _inhabilitado_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. Habilite el controlador de Ingress privado. Sustituya <em>&lt;private_ALB_ID&gt;</em> por el ID de ALB del controlador de Ingress privado de la salida del paso anterior.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Para habilitar el controlador de Ingress privado utilizando la dirección IP privada portátil:

1. Configure la subred gestionada por el usuario de la dirección IP seleccionada para direccionar el tráfico en la VLAN privada del clúster. Sustituya <em>&lt;cluster_name&gt;</em> por el nombre o ID del clúster en el que está desplegada la app que desea exponer, <em>&lt;subnet_CIDR&gt;</em> por el CIDR de la subred gestionada por el usuario y <em>&lt;private_VLAN&gt;</em> por el ID de la VLAN privada. Encontrará el ID de la VLAN privada disponible ejecutando `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. Obtenga una lista de los controladores de Ingress disponible en el clúster para obtener el ID de ALB del controlador de Ingress privado. 

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    El campo **Estado** del controlador de Ingress privado es _inhabilitado_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. Habilite el controlador de Ingress privado. Sustituya <em>&lt;private_ALB_ID&gt;</em> por el ID de ALB del controlador de Ingress privado de la salida del paso anterior y <em>&lt;user_ip&gt;</em> por la dirección IP de la subred gestionada por el usuario que desea utilizar.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

#### Utilización del controlador de Ingress privado con un dominio personalizado
{: #private_ingress_no_tls}

Puede configurar el controlador de Ingress privado para que direccione el tráfico de red entrante a las apps del clúster utilizando un dominio personalizado.{:shortdesc}

Antes de empezar, [habilite el controlador de Ingress privado](#private_ingress).

Para configurar el controlador de Ingress privado:

1.  Cree un dominio personalizado. Para crear un dominio personalizado, póngase en contacto con el proveedor de DNS (Domain Name Service) y para que registre su dominio personalizado.

2.  Correlacione el dominio personalizado con la dirección IP privada portátil del controlador de Ingress privado proporcionado por IBM añadiendo la dirección IP como registro. Para buscar la dirección IP privada portátil del controlador de Ingress privado, ejecute `bx cs albs --cluster <cluster_name>`.

3.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress.

4.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress privado puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster. 

    1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
    2.  Defina un servicio para la app que desea exponer al público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor (<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
         </tr>
         <td><code>port</code></td>
         <td>El puerto que en el que está a la escucha el servicio.</td>
         </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Repita estos pasos para cada app que desee exponer a la red privada.
7.  Cree un recurso de Ingress. Los recursos de Ingress definen las reglas de direccionamiento para el servicio Kubernetes que ha creado para la app y el controlador de Ingress los utiliza para direccionar el tráfico de red de entrada al servicio. Puede utilizar un recurso de Ingress para definir las reglas de direccionamiento para varias apps siempre que cada app se exponga a través de un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myingress.yaml`.
    2.  Defina un recurso de Ingress en el archivo de configuración que utilice el dominio personalizado para direccionar el tráfico de entrada de red a los servicios. Por cada servicio puede definir una vía de acceso individual que se añade a su dominio personalizado para crear una vía de acceso exclusiva para la app, como por ejemplo `https://mydomain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a los pods en los que se ejecuta la app.

        **Nota:** Es importante que la app esté a la escucha en la vía de acceso que ha definido en el recurso de Ingress. De lo contrario, el tráfico de red no se puede reenviar a la app. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como `/` y no especifique una vía de acceso individual para la app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

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
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Sustituya <em>&lt;private_ALB_ID&gt;</em> por el ID de ALB del controlador de Ingress privado. Ejecute <code>bx cs albs --cluster <my_cluster></code> para buscar el ID de ALB.</td>
        </tr>
        <td><code>host</code></td>
        <td>Sustituya <em>&lt;mycustomdomain&gt;</em> por dominio personalizado.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myservicepath1&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
        Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio personalizado para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>custom_domain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br></br>
        Ejemplos: <ul><li>Para <code>https://mycustomdomain/</code>, escriba <code>/</code> como vía de acceso.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso.</li></ul>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la [anotación de reescritura](cs_annotations.html#rewrite-path) para establecer la ruta adecuada para su app.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
        </tr>
        </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el recurso de Ingress para el clúster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Verifique que el recurso de Ingress se haya creado correctamente. Sustituya <em>&lt;myingressname&gt;</em> por el nombre del recurso de Ingress que ha creado en el paso anterior. 

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos segundos hasta que el recurso de Ingress se cree correctamente y la app esté disponible. 

9.  Acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Escriba el URL del servicio de la app al que desea acceder.

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

#### Utilización del controlador de Ingress privado con un dominio personalizado y un certificado TLS
{: #private_ingress_tls}

Puede configurar el controlador de Ingress privado para que direccione el tráfico de red de entrada a las apps del clúster y utilice su propio certificado TLS para gestionar la terminación de TLS, utilizando el dominio personalizado en lugar del proporcionado por IBM.
{:shortdesc}

Antes de empezar, [habilite el controlador de Ingress privado](#private_ingress).

Para configurar el controlador de Ingress:

1.  Cree un dominio personalizado. Para crear un dominio personalizado, póngase en contacto con el proveedor de DNS (Domain Name Service) y para que registre su dominio personalizado.

2.  Correlacione el dominio personalizado con la dirección IP privada portátil del controlador de Ingress privado proporcionado por IBM añadiendo la dirección IP como registro. Para buscar la dirección IP privada portátil del controlador de Ingress privado, ejecute `bx cs albs --cluster <cluster_name>`.

3.  Cree un certificado TLS y una clave para el dominio que estén codificados en formato PEM.

4.  Guarde el certificado TLS y la clave en un secreto de Kubernetes.
    1.  Abra el editor que prefiera y cree un archivo de configuración de secreto de Kubernetes llamado, por ejemplo, `mysecret.yaml`.
    2.  Defina un secreto que utilice su certificado TLS y clave.

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;mytlssecret&gt;</em> por el nombre del secreto de Kubernetes.</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>Sustituya <em>&lt;tlscert&gt;</em> por su certificado TLS personalizado codificado en formato base64.</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>Sustituya <em>&lt;tlskey&gt;</em> por su clave TLS personalizada codificada en formato base64.</td>
         </tbody></table>

    3.  Guarde el archivo de configuración.
    4.  Cree el secreto de TLS para el clúster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress.

6.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress privado puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster. 

    1.  Abra el editor que prefiera y cree un archivo de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
    2.  Defina un servicio para la app que desea exponer al público.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor (<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
         </tr>
         <td><code>port</code></td>
         <td>El puerto que en el que está a la escucha el servicio.</td>
         </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Repita estos pasos para cada app que desee exponer en la red privada.
7.  Cree un recurso de Ingress. Los recursos de Ingress definen las reglas de direccionamiento para el servicio Kubernetes que ha creado para la app y el controlador de Ingress los utiliza para direccionar el tráfico de red de entrada al servicio. Puede utilizar un recurso de Ingress para definir las reglas de direccionamiento para varias apps siempre que cada app se exponga a través de un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un archivo de configuración de Ingress llamado, por ejemplo, `myingress.yaml`.
    2.  Defina un recurso de Ingress en el archivo de configuración que utilice el dominio personalizado para direccionar el tráfico de entrada de red a los servicios y el certificado personalizado para gestionar la terminación TLS. Por cada servicio puede definir una vía de acceso individual que se añade a su dominio personalizado para crear una vía de acceso exclusiva para la app, como por ejemplo `https://mydomain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a los pods en los que se ejecuta la app.

        **Nota:** Es importante que la app esté a la escucha en la vía de acceso que ha definido en el recurso de Ingress. De lo contrario, el tráfico de red no se puede reenviar a la app. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como `/` y no especifique una vía de acceso individual para la app.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

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
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Sustituya <em>&lt;private_ALB_ID&gt;</em> por el ID de ALB del controlador de Ingress privado. Ejecute <code>bx cs albs --cluster <my_cluster></code> para buscar el ID de ALB.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Sustituya <em>&lt;mycustomdomain&gt;</em> por el dominio personalizado que desea configurar para la terminación de TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sustituya <em>&lt;mytlssecret&gt;</em> por el nombre del secreto que ha creado anteriormente y que contiene el certificado TLS personalizado y la clave para gestionar la terminación TLS para el dominio personalizado.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sustituya <em>&lt;mycustomdomain&gt;</em> por dominio personalizado que desee configurar para la terminación TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myservicepath1&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
        Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br></br>
        Ejemplos: <ul><li>Para <code>https://mycustomdomain/</code>, escriba <code>/</code> como vía de acceso.</li><li>Para <code>https://mycustomdomain/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso.</li></ul>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la [anotación de reescritura](cs_annotations.html#rewrite-path) para establecer la ruta adecuada para su app.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>El puerto en el que el servicio está a la escucha. Utilice el mismo puerto que ha definido al crear el servicio de Kubernetes para la app.</td>
        </tr>
        </tbody></table>

    3.  Guarde los cambios.
    4.  Cree el recurso de Ingress para el clúster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Verifique que el recurso de Ingress se haya creado correctamente. Sustituya <em>&lt;myingressname&gt;</em> por el nombre del recurso de Ingress que ha creado anteriormente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos segundos hasta que el recurso de Ingress se cree correctamente y la app esté disponible. 

9.  Acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Escriba el URL del servicio de la app al que desea acceder.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

## Gestión de direcciones IP y subredes
{: #cs_cluster_ip_subnet}

Puede utilizar subredes públicas y privadas portátiles y direcciones IP para exponer apps en el clúster y hacer que se pueda acceder a las mismas desde Internet o desde una red privada.
{:shortdesc}

En {{site.data.keyword.containershort_notm}}, tiene la posibilidad de añadir direcciones IP portátiles y estables para los servicios de Kubernetes añadiendo subredes al clúster. Cuando se crea un clúster estándar, {{site.data.keyword.containershort_notm}} automáticamente suministra una subred pública portátil con 5 direcciones IP públicas portátiles y una subred privada portátil con 5 direcciones IP privadas. Las direcciones IP portátiles son estáticas y no cambian cuando se elimina un nodo trabajador o incluso el clúster.

 Dos de las direcciones IP portátiles, una pública y una privada, se utilizan para los [controladores de Ingress](#cs_apps_public_ingress), que puede utilizar para exponer varias apps en el clúster. Se pueden utilizar 4 direcciones IP públicas portátiles y 4 direcciones IP privadas para exponer apps mediante la [creación de un servicio equilibrador de carga](#cs_apps_public_load_balancer).

**Nota:** Las direcciones IP públicas portátiles se facturan mensualmente. Si decide retirar las direcciones IP públicas portátiles una vez suministrado el clúster, tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.



1.  Cree un archivo de configuración de servicio Kubernetes denominado `myservice.yaml` y defina un servicio de tipo `LoadBalancer` con una dirección IP de equilibrador de carga ficticia. En el ejemplo siguiente se utiliza la dirección IP 1.1.1.1 como dirección IP del equilibrador de carga.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Cree el servicio en el clúster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Inspeccione el servicio.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Nota:** La creación de este servicio falla porque el nodo Kubernetes maestro no encuentra la dirección IP del equilibrador de carga especificada en la correlación de configuración de Kubernetes. Cuando se ejecuta este mandato, puede ver el mensaje de error y la lista de direcciones IP públicas disponibles para el clúster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}




1.  Cree un archivo de configuración de servicio Kubernetes denominado `myservice.yaml` y defina un servicio de tipo `LoadBalancer` con una dirección IP de equilibrador de carga ficticia. En el ejemplo siguiente se utiliza la dirección IP 1.1.1.1 como dirección IP del equilibrador de carga.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Cree el servicio en el clúster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Inspeccione el servicio.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Nota:** La creación de este servicio falla porque el nodo Kubernetes maestro no encuentra la dirección IP del equilibrador de carga especificada en la correlación de configuración de Kubernetes. Cuando se ejecuta este mandato, puede ver el mensaje de error y la lista de direcciones IP públicas disponibles para el clúster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### Liberación de direcciones IP utilizadas
{: #freeup_ip}

Puede liberar una dirección IP portátil utilizada suprimiendo el servicio equilibrador de carga que está utilizando la dirección IP pública portátil.

[Antes de empezar, establezca el contexto para el clúster que desea utilizar.](cs_cli_install.html#cs_cli_configure)

1.  Obtenga una lista de los servicios disponibles en el clúster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Elimine el servicio equilibrador de carga que utiliza una dirección IP pública o privada.

    ```
    kubectl delete service <myservice>
    ```
    {: pre}

<br />


## Despliegue de apps con la GUI
{: #cs_apps_ui}

Cuando despliega una app a un clúster utilizando el panel de control de Kubernetes, se crea automáticamente un recurso de despliegue que crea, actualiza y gestiona los pods del clúster.
{:shortdesc}

Antes de empezar:

-   Instale las [CLI](cs_cli_install.html#cs_cli_install) necesarias.
-   Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para desplegar la app:

1.  [Abra el panel de control de Kubernetes](#cs_cli_dashboard).
2.  En el panel de control de Kubernetes, pulse **+ Crear**.
3.  Seleccione **Especificar detalles de app a continuación** para especificar los detalles de la app en la GUI o bien **Cargar un archivo YAML o JSON** para cargar el [archivo de configuración![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) de la app. Utilice [este archivo YAML de ejemplo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) para desplegar un contenedor desde la imagen **ibmliberty** de la región US-Sur.
4.  En el panel de control de Kubernetes, pulse **Despliegues** para verificar que el despliegue se ha creado.
5.  Si ha puesto la app a disponibilidad pública mediante un servicio de puerto de nodo, un servicio de equilibrador de carga o Ingress, compruebe que puede acceder a la app.

<br />


## Despliegue de apps con la CLI
{: #cs_apps_cli}

Después de crear un clúster, puede desplegar una app en dicho clúster mediante la CLI de Kubernetes.
{:shortdesc}

Antes de empezar:

-   Instale las [CLI](cs_cli_install.html#cs_cli_install) necesarias.
-   Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para desplegar la app:

1.  Cree un archivo de configuración basado en la [prácticas recomendadas de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/overview/). Generalmente, un archivo de configuración contiene detalles de configuración de cada uno de los recursos que está creando en Kubernetes. El script puede incluir una o varias de las siguientes secciones:

    -   [Despliegue ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): Define la creación de pods y conjuntos de réplicas. Un pod incluye una app contenerizada individual y conjuntos de réplicas que controlan varias instancias de pods.

    -   [Servicio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/): Ofrece un acceso frontal a los pods mediante un nodo trabajador o una dirección IP pública de equilibrador de carga, o bien una ruta pública de Ingress.

    -   [Ingress ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/ingress/): Especifica un tipo de equilibrador de carga que ofrece rutas para acceder a la app a nivel público.

2.  Ejecute el archivo de configuración en el contexto de un clúster.

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  Si ha puesto la app a disponibilidad pública mediante un servicio de puerto de nodo, un servicio de equilibrador de carga o Ingress, compruebe que puede acceder a la app.

<br />





## Escalado de apps
{: #cs_apps_scaling}

<!--Horizontal auto-scaling is not working at the moment due to a port issue with heapster. The dev team is working on a fix. We pulled out this content from the public docs. It is only visible in staging right now.-->

Despliegue aplicaciones en la nube que respondan a cambios en la demanda para las aplicaciones y que utilicen los recursos solo cuando los necesiten. El escalado automático aumenta o reduce automáticamente el número de instancias de las apps en función de la CPU.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

**Nota:** ¿Está buscando información sobre las aplicaciones de escalado de Cloud Foundry? Consulte [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html).

Con Kubernetes, puede habilitar el [escalado automático de pod horizontal ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) para escalar las apps en función de la CPU.

1.  Despliegue la app en el clúster desde la CLI. Cuando despliegue la app, debe solicitar CPU.

    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>La aplicación que desea desplegar.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>La CPU necesaria para el contenedor, que se especifica en milinúcleos. Por ejemplo, <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>Si tiene el valor true, crea un servicio externo.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>El puerto en el que la app está disponible externamente.</td>
    </tr></tbody></table>

    **Nota:** Para despliegues más complejos, es posible que tenga que crear un [archivo de configuración](#cs_apps_cli).
2.  Cree Horizontal Pod Autoscaler y defina la política. Para obtener más información sobre cómo trabajar con el mandato `kubetcl autoscale`, consulte [la documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>Utilización media de CPU que mantiene el componente Horizontal Pod Autoscaler, que se especifica como un porcentaje.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>El número mínimo de pods desplegados que se utilizan para mantener el porcentaje especificado de utilización de CPU.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>El número máximo de pods desplegados que se utilizan para mantener el porcentaje especificado de utilización de CPU.</td>
    </tr>
    </tbody></table>

<br />


## Gestión de despliegues continuos
{: #cs_apps_rolling}

Puede gestionar la implantación de los cambios de una forma automatizada y controlada. Si el despliegue no va según lo planificado, puede retrotraerlo a la revisión anterior.
{:shortdesc}

Antes de empezar, cree un [despliegue](#cs_apps_cli).

1.  [Implante ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) un cambio. Por ejemplo, supongamos que desea cambiar la imagen que ha utilizado en el despliegue inicial.

    1.  Obtener el nombre del despliegue.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Obtener el nombre del pod.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Obtener el nombre del contenedor que se está ejecutando en el pod.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  Definir la imagen que utilizará el despliegue.

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    Al ejecutar estos mandatos, el cambio se aplica de inmediato y se registra en el historial de implantaciones.

2.  Comprobar el estado del despliegue.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  Retrotraer un cambio.
    1.  Ver el historial de implantaciones del despliegue e identificar el número de revisión del último despliegue.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **Sugerencia:** Para ver los detalles de una revisión concreta, incluya el número de revisión.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  Retrotraer a la versión anterior o especificar una revisión. Para retrotraer a la versión anterior, utilice el mandato siguiente.

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />


## Adición de servicios de {{site.data.keyword.Bluemix_notm}}
{: #cs_apps_service}

Se utilizan secretos cifrados de Kubernetes para almacenar detalles de servicios y credenciales de {{site.data.keyword.Bluemix_notm}} y permitir una comunicación segura entre el servicio y el clúster. Como usuario del clúster, puede acceder a este secreto montándolo como un volumen en un pod.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure). Asegúrese de que el administrador del clúster ha [añadido al clúster](cs_cluster.html#cs_cluster_service) el servicio de {{site.data.keyword.Bluemix_notm}} que desea utilizar en su app.

Los secretos de Kubernetes constituyen una forma segura de almacenar información confidencial, como nombres de usuario, contraseñas o claves. En lugar de exponer la información confidencial a través de variables de entorno o directamente en Dockerfile, los secretos se deben montar como un volumen secreto en un pod para que resulten accesibles para un contenedor en ejecución en un pod.

Cuando monta un volumen secreto en un pod, se almacena un archivo denominado binding en el directorio de montaje del volumen, que incluye toda la información y las credenciales que necesita para acceder al servicio de {{site.data.keyword.Bluemix_notm}}.

1.  Obtenga una lista de los secretos disponibles en el espacio de nombres del clúster.

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    Salida de ejemplo:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Busque un secreto de tipo **opaco** y tome nota del **nombre** del secreto. Si existen varios secretos, póngase en contacto con el administrador del clúster para identificar el secreto correcto del servicio.

3.  Abra el editor de texto que desee.

4.  Cree un archivo YAML para configurar un pod que pueda acceder a los detalles del servicio a través de un volumen secreto.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>El nombre del volumen secreto que desea montar en el contenedor.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Especifique un nombre para el volumen secreto que desea montar en el contenedor de montaje.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Establezca permisos de solo lectura para el secreto del servicio.</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Escriba el nombre del secreto que ha anotado anteriormente.</td>
    </tr></tbody></table>

5.  Cree el pod y monte el volumen secreto.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  Verifique que se ha creado el pod.

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    Ejemplo de salida de CLI:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  Anote el **NOMBRE** de su pod.
8.  Obtenga los detalles del pod y busque el nombre del secreto.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    Salida:

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}



9.  Cuando implemente la app, configúrela de modo que encuentre el archivo secreto denominado **binding** en el directorio de montaje, analice el contenido JSON y determine el URL y las credenciales del servicio para acceder al servicio de {{site.data.keyword.Bluemix_notm}}.

Ahora puede acceder a los detalles y credenciales del servicio de {{site.data.keyword.Bluemix_notm}}. Para poder trabajar con el servicio de {{site.data.keyword.Bluemix_notm}}, asegúrese de que la app se haya configurado de modo que busque el archivo secreto del servicio en el directorio de montaje, analice el contenido JSON y determine los detalles del servicio.

<br />


## Creación de almacenamiento permanente
{: #cs_apps_volume_claim}

Cree una reclamación de volumen permanente para suministrar almacenamiento de archivos NFS al clúster. Luego monte esta reclamación en un pod para asegurarse de que los datos estén disponibles aunque el pod se cuelgue o se cierre.
{:shortdesc}

IBM coloca el almacén de archivos NFS que contiene el volumen permanente en un clúster para ofrecer una alta disponibilidad de los datos.


Cuando una cuenta de {{site.data.keyword.Bluemix_dedicated_notm}} está [habilitada para clústeres](cs_ov.html#setup_dedicated), en lugar de utilizar esta tarea, se debe [abrir una incidencia de soporte](/docs/support/index.html#contacting-support). Al abrir una incidencia de soporte, puede solicitar una copia de seguridad de los volúmenes, una restauración y otras funciones de almacenamiento.


1.  Revise las clases de almacenamiento disponibles. {{site.data.keyword.containerlong}} ofrece ocho clases de almacenamiento predefinidas para que el administrador del clúster no tenga que crear ninguna clase de almacenamiento. La clase de almacenamiento `ibmc-file-bronze` es la misma que la clase de almacenamiento `default`.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-retain-bronze      ibm.io/ibmc-file
    ibmc-file-retain-custom      ibm.io/ibmc-file
    ibmc-file-retain-gold        ibm.io/ibmc-file
    ibmc-file-retain-silver      ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  Decida si desea guardar los datos y la compartición de archivos NFS después de suprimir pvc. Si desea conservar los datos, seleccione la clase de almacenamiento `retain`. Si desea que los datos y la compartición de archivos se supriman cuando suprima el pvc, elija una clase de almacenamiento sin `retain`.

3.  Revise el IOPS de una clase de almacenamiento y los tamaños de almacenamiento disponibles.
    - Las clases de almacenamiento de bronce, plata y oro utilizar almacenamiento Endurance y tienen un único IOPS definido por GB para cada clase. El IOPS total depende del tamaño del almacenamiento. Por ejemplo, 1000Gi pvc a 4 IOPS por GB tiene un total de 4000 IOPS.

    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    El campo **parameters** proporciona el IOPS por GB asociado a la clase de almacenamiento y los
tamaños disponibles en gigabytes.

    ```
    Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

    - Las clases de almacenamiento personalizado utilizan [Almacenamiento de rendimiento ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/performance-storage) y ofrecen distintas opciones en cuanto al IOPS y tamaño totales.

    ```
    kubectl describe storageclasses ibmc-file-retain-custom
    ```
    {: pre}

    El campo **parameters** proporciona el IOPS asociado a la clase de almacenamiento y los tamaños disponibles en gigabytes. Por ejemplo, un 40Gi pvc puede seleccionar un IOPS que sea múltiplo de 100 que esté comprendido entre 100 y 2000 IOPS.

    ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
    {: screen}

4.  Cree un archivo de configuración para definir su reclamación de volumen permanente y guarde la configuración como archivo `.yaml`.

    Ejemplo para las clases de bronce, plata y oro:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    Ejemplo para clases personalizadas:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Escriba el nombre de la reclamación de volumen permanente.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>Especifique la clase de almacenamiento para el volumen permanente:
      <ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS por GB.</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS por GB.</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS por GB.</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom: Varios valores de IOPS disponibles.

    </li> Si no especifica ninguna clase de almacenamiento, el volumen permanente se crea en la clase de almacenamiento de bronce ("bronze").</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Si elige un tamaño distinto del que aparece en la lista, el tamaño se redondea al alza. Si selecciona un tamaño mayor que el tamaño más grande, el tamaño se redondea a la baja.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>Esta opción solo se aplica a ibmc-file-custom / ibmc-file-retain-custom. Especifique el IOPS total para el almacenamiento. Ejecute `kubectl describe storageclasses ibmc-file-custom` para ver todas las opciones. Si elige un IOPS distinto del que aparece en la lista, el IOPS se redondea.</td>
    </tr>
    </tbody></table>

5.  Cree la reclamación de volumen permanente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  Compruebe que la reclamación de volumen permanente se haya creado y vinculado al volumen permanente. Este proceso puede tardar unos minutos.

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    La salida es parecida a la siguiente.

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}Para montar la reclamación de volumen permanente en el pod, cree un archivo de configuración. Guarde la configuración como archivo `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>El nombre del pod.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>La vía de acceso absoluta del directorio en el que el que está montado el volumen dentro del contenedor.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>El nombre del volumen que monta en el contenedor.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>El nombre del volumen que monta en el contenedor. Normalmente, este nombre es el mismo que <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>El nombre de la reclamación de volumen permanente que desea utilizar como volumen. Cuando monta el volumen en el pod, Kubernetes identifica el volumen permanente enlazado a la reclamación de volumen permanente y permite al usuario realizar operaciones de lectura y escritura en el volumen permanente.</td>
    </tr>
    </tbody></table>

8.  Cree el pod y monte la reclamación de volumen permanente en el pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  Verifique que el volumen se ha montado correctamente en el pod.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    El punto de montaje se muestra en el campo **Volume Mounts** y el volumen se muestra en el campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />


## Adición de acceso de usuario no root al almacenamiento permanente
{: #cs_apps_volumes_nonroot}

Los usuarios no root no tienen permiso de escritura sobre la vía de acceso de montaje del volumen para el almacenamiento respaldado por NFS. Para otorgar permiso de escritura, debe editar el Dockerfile de la imagen para crear un directorio en la vía de acceso de montaje con el permiso correcto.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Si está diseñando una app con un usuario no root que requiere permiso de escritura sobre el volumen, debe añadir los siguientes procesos al script de punto de entrada y al archivo Docker:

-   Cree un usuario no root.
-   Añada temporalmente el usuario al grupo raíz.
-   Cree un directorio en la vía de acceso de montaje con los permisos de usuario correctos.

Para {{site.data.keyword.containershort_notm}}, el propietario predeterminado de la vía de acceso de montaje del volumen es el propietario `nobody`. Con el almacenamiento NFS, si el propietario no existe localmente en el pod, se crea el usuario `nobody`. Los volúmenes están configurados para reconocer el usuario root en el contenedor, el cual, para algunas apps es el único usuario dentro de un contenedor. Sin embargo, muchas apps especifican un usuario no root que no es `nobody` que escribe en la vía de acceso de montaje del contenedor. Algunas apps especifican que el volumen debe ser propiedad del usuario root. Las apps no suelen utilizar el usuario root por motivos de seguridad. Con todo, si su app requiere un usuario root, póngase en contacto con el servicio de asistencia de [{{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support). 


1.  Cree un Dockerfile en un directorio local. Este Dockerfile de ejemplo está creando un usuario no root denominado `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Cree un grupo y un usuario con GID y UID 1010.
    # En este caso, está creando un grupo y usuario denominado myguest.
    # Es poco probable que el GUID y UID 1010 cree un conflicto con algún GUID o UID de usuario existente en la imagen.
    # El GUID y el UID deben estar entre 0 y 65536. De lo contrario, no se puede crear el contenedor.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Cree el script de punto de entrada en la misma carpeta local que Dockerfile. Este script de punto de entrada de ejemplo especifica
`/mnt/myvol` como vía de acceso de montaje de volumen.

    ```
    #!/bin/bash
    set -e

    #Este es el punto de montaje para el volumen compartido.
    #De forma predeterminada, el punto de montaje es propiedad del usuario root.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # Esta función crea un subdirectorio propiedad del
    # usuario no root bajo la vía de acceso de montaje del volumen compartido.
    create_data_dir() {
      #Añadir el usuario no root al grupo primario de usuario root.
      usermod -aG root $MY_USER

      #Proporcione permiso de lectura-escritura-ejecución para el grupo para la vía de acceso de montaje compartido.
      chmod 775 $MOUNTPATH

      # Cree un directorio bajo la vía de acceso compartida propiedad del usuario no roor myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #Por motivos de seguridad, elimine el usuario no root del grupo de usuarios root.
      deluser $MY_USER root

      #Cambie la vía de acceso de montaje de volumen compartido por su permiso de lectura-escritura-ejecución original.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    #Este mandato crea un proceso de larga ejecución para la finalidad de este ejemplo.
    tail -F /dev/null
    ```
    {: codeblock}

3.  Inicie una sesión en {{site.data.keyword.registryshort_notm}}.

    ```
    bx cr login
    ```
    {: pre}

4.  Cree la imagen localmente. Recuerde sustituir _&lt;my_namespace&gt;_ por el espacio de nombres correspondiente al registro de imágenes privado. Ejecute `bx cr namespace-get` si tiene que buscar su espacio de nombres.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  Envíe la imagen por push al espacio de nombres de {{site.data.keyword.registryshort_notm}}.

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  Cree una reclamación de volumen permanente creando un archivo `.yaml` de configuración. En este ejemplo se utiliza una clase de almacenamiento de menor rendimiento. Ejecute `kubectl get storageclasses` para ver las clases de almacenamiento disponibles.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  Cree la reclamación de volumen permanente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  Cree un archivo de configuración y monte el volumen y ejecute el pod desde la imagen nonroot. La vía de acceso de montaje del volumen `/mnt/myvol` coincide con la vía de acceso especificada en el Dockerfile. Guarde la configuración como archivo `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  Cree el pod y monte la reclamación de volumen permanente en el pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. Verifique que el volumen se ha montado correctamente en el pod.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    El punto de montaje se muestra en el campo **Volume Mounts** y el volumen se muestra en el campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. Inicie la sesión en el pod después de que el pod esté en ejecución.

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. Vea permisos de la vía de acceso de montaje de volumen.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    Esta salida muestra que el usuario root tiene permisos de lectura, escritura y ejecución en la vía de acceso de montaje `mnt/myvol/`, pero el usuario no root myguest tiene permiso para leer y escribir en la carpeta `mnt/myvol/mydata`. Debido a estos permisos actualizados, el usuario no root ahora puede escribir datos en el volumen persistente.
