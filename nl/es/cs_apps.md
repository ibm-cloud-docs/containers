---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-13"

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

Puede utilizar las técnicas de Kubernetes para desplegar apps y asegurarse de que sus apps están siempre activas y en funcionamiento. Por ejemplo, puede realizar actualizaciones continuas y retrotracciones sin causar a los usuarios tiempos de inactividad. {:shortdesc}

El despliegue de una app suele implicar los pasos siguientes.

1.  [Instale las CLI](cs_cli_install.html#cs_cli_install).

2.  Cree un script de configuración para la app. [Revise las prácticas recomendadas de Kubernetes. ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  Ejecute el script de configuración siguiendo uno de estos métodos.
    -   [La CLI de Kubernetes](#cs_apps_cli)
    -   El panel de control de Kubernetes
        1.  [Inicie el panel de control de Kubernetes.](#cs_cli_dashboard)
        2.  [Ejecute el script de configuración.](#cs_apps_ui)


## Inicio del panel de control de Kubernetes
{: #cs_cli_dashboard}

Abra un panel de control de Kubernetes en el sistema local para ver información sobre un clúster y sus nodos trabajadores.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure). Esta tarea precisa de la [política de acceso de administrador](cs_cluster.html#access_ov). Verifique su [política de acceso](cs_cluster.html#view_access) actual.


Puede utilizar el puerto predeterminado o definir su propio puerto para iniciar el panel de control de Kubernetes para un clúster.
-   Inicie el panel de control de Kubernetes con el puerto predeterminado 8001.
    1.  Establezca el proxy con el número de puerto predeterminado.

        ```
        kubectl proxy
        ```
        {: pre}

        La salida de la CLI es parecida a la siguiente:


        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Abra el siguiente URL en un navegador web para ver el panel de control de Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

-   Inicie el panel de control de Kubernetes con su propio puerto.
    1.  Establezca el proxy con su propio número de puerto.

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  Abra el siguiente URL en un navegador.

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


Cuando termine de utilizar el panel de control de Kubernetes, utilice `CONTROL+C` para salir del mandato `proxy`.

## Cómo permitir el acceso público a apps
{: #cs_apps_public}

Para que una app esté disponible a nivel público, debe actualizar el script de configuración antes de desplegar la app en un clúster.{:shortdesc}

Dependiendo de si ha creado un clúster lite o estándar, existen diversas formas de permitir el acceso a su app desde Internet. 

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">Servicio de tipo NodePort</a> (clústeres de tipo lite y estándar)</dt>
<dd>Exponga un puerto público en cada nodo trabajador y utilice la dirección IP pública de cualquier nodo trabajador para acceder de forma pública al servicio en el clúster. La dirección IP pública del nodo trabajador no es permanente. Cuando un nodo trabajador se elimina o se vuelve a crear, se le asigna una nueva dirección IP pública. Puede utilizar el servicio de tipo NodePort para probar el acceso público para la app o cuando se necesita acceso público solo durante un breve periodo de tiempo. Si necesita una dirección IP pública estable y más disponibilidad para el servicio, exponga la app mediante un servicio de tipo LoadBalancer o Ingress.</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">Servicio de tipo LoadBalancer</a> (solo clústeres estándares)</dt>
<dd>Cada clúster estándar se suministra con 4 direcciones IP públicas portátiles que puede utilizar para crear un equilibrador de carga TCP/UDP externo para la app. Puede personalizar el equilibrador de carga exponiendo cualquier puerto que necesite la app. La dirección IP pública portátil asignada al equilibrador de carga es permanente y no cambia cuando un nodo trabajador se vuelve a crear en el clúster.

</br>
Si necesita equilibrio de carga HTTP o HTTPS para la app y desea utilizar una ruta pública para exponer varias apps en el clúster como servicios, utilice el soporte de Ingress integrado en {{site.data.keyword.containershort_notm}}.</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a> (solo clústeres estándares)</dt>
<dd>Exponga varias apps en el clúster creando un equilibrador de carga HTTP o HTTPS
externo que utilice un punto de entrada público seguro y exclusivo para direccionar las solicitudes entrantes a las apps. Ingress consta de dos componentes principales, el recurso de Ingress y el controlador de Ingress. El recurso de Ingress define las reglas sobre cómo direccionar y equilibrar la carga de las solicitudes de entrada para una app. Todos los recursos de Ingress deben estar registrados con el controlador de Ingress que escucha solicitudes de entrada de servicio HTTP o HTTPS y reenvía las solicitudes según las reglas definidas para cada recurso de Ingress. Utilice Ingress si desea implementar su propio equilibrador de carga con reglas de direccionamiento personalizadas y si necesita terminación SSL para sus apps.

</dd></dl>

### Configuración del acceso público a una app utilizando el tipo de servicio NodePort
{: #cs_apps_public_nodeport}

Puede poner la app a disponibilidad pública utilizando la dirección IP pública de cualquier nodo trabajador de un clúster y exponiendo un puerto de nodo. Utilice esta opción para pruebas y para acceso público de corto plazo.
{:shortdesc}

Puede exponer la app como servicio de Kubernetes de tipo NodePort para clústeres de tipo lite o estándares. 

Para entornos dedicados de {{site.data.keyword.Bluemix_notm}}, las direcciones IP están bloqueadas por un cortafuegos. Para hacer que una app esté disponible a nivel público, utilice un [servicio de tipo LoadBalancer](#cs_apps_public_load_balancer) o [Ingress](#cs_apps_public_ingress) en su lugar.

**Nota:** La dirección IP pública de un nodo trabajador no es permanente. Si el nodo trabajador se debe volver a crear, se le asigna una nueva dirección IP pública. Si necesita una dirección IP pública estable y más disponibilidad para el servicio, exponga la app utilizando un [servicio de tipo LoadBalancer](#cs_apps_public_load_balancer) o [Ingress](#cs_apps_public_ingress).




1.  Defina una sección de [servicio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/) en el script de configuración.
2.  En la sección `spec` del servicio, añada el tipo NodePort. 

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  Opcional: En la sección `ports`, añada un NodePort comprendido entre 30000 y 32767.No especifique un NodePort que ya estén siendo utilizado por otro servicio. Si no está seguro de qué NodePorts ya se están utilizando, no es asigne ninguno. Si no se asigna ningún NodePort, se asignará automáticamente uno aleatorio.

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
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
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

### Configuración del acceso público a una app utilizando el tipo de servicio LoadBalancer
{: #cs_apps_public_load_balancer}

Exponga un puerto y utilice la dirección IP pública portátil para que el equilibrador de carga acceda a la app. A diferencia del servicio NodePort, la dirección IP pública portátil del servicio equilibrador de carga no depende del nodo trabajador en el que se ha desplegado la app. La dirección IP pública portátil del equilibrador de carga se asigna automáticamente y no cambia cuando se añaden o eliminan nodos trabajadores, lo que significa que los servicios equilibradores de carga ofrecen una mayor disponibilidad que los servicios de NodePort. Los usuarios pueden seleccionar cualquier puerto para el equilibrador de carga y no están limitados al rango de puertos de NodePort. Puede utilizar los servicios equilibradores de carga para los protocolos TCP y UDP.

Cuando una cuenta dedicada de {{site.data.keyword.Bluemix_notm}} está [habilitada para clústeres](cs_ov.html#setup_dedicated), puede solicitar que se utilicen subredes públicas para las direcciones IP del equilibrador de carga. [Abra una incidencia de soporte](/docs/support/index.html#contacting-support) para crear la subred y luego utilice el mandato [`cs bx cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) para añadir la subred al clúster.

**Nota:** Los servicios equilibradores de carga no soportan la terminación TLS. Si la app necesita terminación TLS,
puede exponer la app mediante [Ingress](#cs_apps_public_ingress) o configurar la app de modo que gestione la terminación TLS.

Antes de empezar:

-   Esta característica solo está disponible para clústeres estándares.
-   Debe tener una dirección IP pública portátil disponible para asignarla al servicio equilibrador de carga.

Para crear un servicio equilibrador de carga:

1.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del script de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.
2.  Cree un servicio equilibrador de carga para la app que desee exponer. Para hacer que la app esté disponible en Internet público, debe crear un servicio Kubernetes para la app y configurar el servicio para que incluya todos los pods que forman la app en el equilibrio de carga.
    1.  Abra el editor que prefiera y cree un script de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.
    2.  Defina un servicio equilibrador de carga para la app que desea exponer al público.

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

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio equilibrador de carga.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor
(<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
         </tr>
         <td><code>port</code></td>
         <td>El puerto que en el que está a la escucha el servicio.</td>
         </tbody></table>
    3.  Opcional: Si desea utilizar una dirección IP pública portátil específica para el equilibrador de carga que esté disponible para el clúster, puede especificar dicha dirección IP incluyendo `loadBalancerIP` en la sección spec. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/).
    4.  Opcional: Puede optar por configurar un cortafuegos especificando `loadBalancerSourceRanges` en la sección spec. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).
    5.  Guarde los cambios.
    6.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Cuando se crea el servicio equilibrador de carga, se asigna automáticamente una dirección IP pública portátil al equilibrador de carga. Si no hay ninguna dirección IP pública portátil disponible, la creación del servicio equilibrador de carga falla.
3.  Verifique que el servicio de equilibrio de carga se haya creado correctamente. Sustituya _&lt;myservice&gt;_ por el nombre del servicio equilibrador de carga que ha creado en el paso anterior.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos minutos hasta que el servicio equilibrador de carga se cree correctamente y la app esté disponible en Internet público. 

    La salida de la CLI se parecerá a la siguiente:

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

    La dirección IP de **LoadBalancer Ingress** es la dirección IP pública portátil que asignada al servicio equilibrador de carga.
4.  Acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Especifique la dirección IP pública portátil del equilibrador de carga y el puerto. En el ejemplo anterior, se ha asignado la dirección IP pública portátil `192.168.10.38` al servicio equilibrador de carga.


        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}


### Configuración del acceso público a una app utilizando el controlador de Ingress
{: #cs_apps_public_ingress}

Exponga varias apps en el clúster creando recursos Ingress gestionados por el controlador de Ingress proporcionado por IBM. El controlador de Ingress es un equilibrador de carga HTTP o HTTPS externo que utiliza un punto de entrada público seguro y exclusivo para direccionar las solicitudes entrantes a las apps dentro o fuera del clúster. 

**Nota:** Ingress únicamente está disponible para los clústeres estándares y necesita de al menos dos nodos trabajadores en el clúster para asegurar la alta disponibilidad.


Cuando se crea un clúster estándar, se crea automáticamente un controlador de Ingress y se le asigna una dirección IP pública portátil y una ruta pública. Puede configurar el controlador de Ingress y definir reglas de direccionamiento individuales para cada app que exponga al público. A cada app que se exponen por medio de Ingress que se le asigna una vía de acceso exclusiva que se añade a la ruta pública, para que pueda utilizar un URL exclusivo para acceder a una app de forma pública en el clúster.

Cuando una cuenta dedicada de {{site.data.keyword.Bluemix_notm}} está [habilitada para clústeres](cs_ov.html#setup_dedicated), puede solicitar que se utilicen subredes públicas para las direcciones IP del controlador Ingress. A continuación, se crea el controlador de Ingress y se asigna una ruta pública. [Abra una incidencia de soporte](/docs/support/index.html#contacting-support) para crear la subred y luego utilice el mandato [`cs bx cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) para añadir la subred al clúster.

Puede configurar el controlador de Ingress para los siguientes casos.

-   [Se utiliza el dominio proporcionado por IBM sin terminación TLS](#ibm_domain)
-   [Se utiliza el dominio proporcionado por IBM con terminación TLS](#ibm_domain_cert)
-   [Se utiliza un dominio personalizado y un certificado TLS para realizar la terminación TLS](#custom_domain_cert)
-   [Se utiliza un dominio personalizado o proporcionado por IBM con terminación TLS para acceder a las apps fuera del clúster](#external_endpoint)
-   [Personalice su controlador Ingress con anotaciones](#ingress_annotation)

#### Utilización del dominio proporcionado por IBM sin terminación TLS
{: #ibm_domain}

Puede configurar el controlador de Ingress como un equilibrador de carga HTTP para las apps del clúster y utilizar el dominio proporcionado por IBM para acceder a las apps desde Internet.

Antes de empezar:

-   Si aún no tiene uno, [cree un clúster estándar](cs_cluster.html#cs_cluster_ui). 
-   [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure) para ejecutar mandatos `kubectl`.

Para configurar el controlador de Ingress:

1.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del script de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress.
2.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un script de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio equilibrador de carga.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor
(<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
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
    1.  Abra el editor que prefiera y cree un script de configuración de Ingress llamado, por ejemplo, `myingress.yaml`. 
    2.  Defina un recurso de Ingress en el script de configuración que utilice el dominio proporcionado por IBM para direccionar el tráfico de entrada de red al servicio que ha creado anteriormente.

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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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
Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>.
Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br></br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.
        </br>
        Ejemplos: <ul><li>Para <code>http://ingress_host_name/</code>, escriba <code>/</code> como vía de acceso. </li><li>Para <code>http://ingress_host_name/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso. </li></ul>
        </br>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la <a href="#rewrite" target="_blank">anotación de reescritura</a> para establecer la ruta adecuada para su app.
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

1.  [Despliegue la app en el clúster](#cs_apps_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del script de configuración. Esta etiqueta identifica todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress. 
2.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster.
    1.  Abra el editor que prefiera y cree un script de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice&gt;</em> por el nombre del servicio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor
(<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
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
    1.  Abra el editor que prefiera y cree un script de configuración de Ingress llamado, por ejemplo, `myingress.yaml`. 
    2.  Defina un recurso de Ingress en el script de configuración que utilice el dominio proporcionado por IBM para direccionar el tráfico de entrada de red a los servicios y el certificado proporcionado por IBM para gestionar automáticamente la terminación TLS. Para cada servicio puede definir una vía de acceso individual que se añade al dominio proporcionado por IBM para crear una vía de acceso exclusiva a la app, por ejemplo `https://ingress_domain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a los pods en los que se ejecuta la app.

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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sustituya <em>&lt;ibmtlssecret&gt;</em> por el nombre del <strong>secreto de Ingress</strong> proporcionado por IBM en el paso anterior. Este certificado gestiona la terminación de TLS.</tr>
        <tr>
        <td><code>host</code></td>
        <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM en el paso anterior. Este dominio está configurado para la terminación TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myservicepath1&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>.
Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br>
        Ejemplos: <ul><li>Para <code>http://ingress_host_name/</code>, escriba <code>/</code> como vía de acceso. </li><li>Para <code>http://ingress_host_name/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso. </li></ul>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la <a href="#rewrite" target="_blank">anotación de reescritura</a> para establecer la ruta adecuada para su app.
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

    **Nota:** Pueden transcurrir unos minutos hasta que el recurso de Ingress se cree correctamente y la app esté disponible en Internet público. 6.  En un navegador web, escriba el URL del servicio de la app al que va a acceder. 

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### Utilización del controlador de Ingress con un dominio personalizado y un certificado TLS
{: #custom_domain_cert}

Puede configurar el controlador de Ingress para que direccione el tráfico de red de entrada a las apps del clúster y utilice su propio certificado TLS para gestionar la terminación de TLS, utilizando el dominio personalizado en lugar del proporcionado por IBM. {:shortdesc}

Antes de empezar:

-   Si aún no tiene uno, [cree un clúster estándar](cs_cluster.html#cs_cluster_ui). 
-   [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure) para ejecutar mandatos `kubectl`.

Para configurar el controlador de Ingress:

1.  Cree un dominio personalizado. Para crear un dominio personalizado, póngase en contacto con el proveedor de DNS (Domain Name Service) y para que registre su dominio personalizado.
2.  Configure el dominio de modo que direccione el tráfico de red de entrada al controlador de Ingress de IBM. Puede elegir entre las siguientes opciones:
    -   Defina un alias para el dominio personalizado especificando el dominio proporcionado por IBM como CNAME (Registro de nombre canónico). Para encontrar el dominio de Ingress proporcionado por IBM, ejecute `bx cs cluster-get <mycluster>` y busque el campo **Subdominio de Ingress**. 
    -   Correlacione el dominio personalizado con la dirección IP pública portátil del controlador de Ingress proporcionado por IBM añadiendo la dirección IP como registro de puntero
(PTR). Para buscar la dirección IP pública portátil del controlador de Ingress:
        1.  Ejecute `bx cs cluster-get <mycluster>` y busque el campo **Subdominio de Ingress**. 
        2.  Ejecute `nslookup <Ingress subdomain>`.
3.  Cree un certificado TLS y una clave para el dominio que estén codificados en formato base64.
4.  Guarde el certificado TLS y la clave en un secreto de Kubernetes.
    1.  Abra el editor que prefiera y cree un script de configuración de secreto de Kubernetes llamado, por ejemplo, `mysecret.yaml`.
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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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

    3.  Guarde el script de configuración.
    4.  Cree el secreto de TLS para el clúster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Despliegue la app en el clúster](#cs_apps_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del script de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga de Ingress.

6.  Cree un servicio Kubernetes para poder exponer la app. El controlador de Ingress puede incluir la app en el equilibrio de carga de Ingress sólo si la app se expone mediante un servicio Kubernetes dentro del clúster.

    1.  Abra el editor que prefiera y cree un script de configuración de servicio llamado, por ejemplo, `myservice.yaml`.
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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myservice1&gt;</em> por el nombre del servicio Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selectorkey&gt;</em>) y valor
(<em>&lt;selectorvalue&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Por ejemplo, si utiliza el siguiente selector <code>app: code</code>, todos los pods que tengan esta etiqueta en sus metadatos se incluirán en el equilibrio de la carga. Especifique la misma etiqueta que ha utilizado al desplegar la app del clúster. </td>
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
    1.  Abra el editor que prefiera y cree un script de configuración de Ingress llamado, por ejemplo, `myingress.yaml`. 
    2.  Defina un recurso de Ingress en el script de configuración que utilice el dominio personalizado para direccionar el tráfico de entrada de red a los servicios y el certificado personalizado para gestionar la terminación TLS. Por cada servicio puede definir una vía de acceso individual que se añade a su dominio personalizado para crear una vía de acceso exclusiva para la app, como por ejemplo `https://mydomain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a los pods en los que se ejecuta la app.

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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sustituya <em>&lt;mytlssecret&gt;</em> por el nombre del secreto que ha creado anteriormente y que contiene el certificado TLS personalizado y la clave para gestionar la terminación TLS para el dominio personalizado.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Sustituya <em>&lt;mycustomdomain&gt;</em> por el dominio personalizado que desea configurar para la terminación de TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myservicepath1&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.

        </br>
Para cada servicio de Kubernetes, defina una vía de acceso individual que se añade al dominio que IBM proporciona para crear una vía de acceso exclusiva a su app como, por ejemplo, <code>ingress_domain/myservicepath1</code>.
Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red al servicio y a los pods en los que la app está en ejecución utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br></br>
        Ejemplos: <ul><li>Para <code>https://mycustomdomain/</code>, escriba <code>/</code> como vía de acceso. </li><li>Para <code>https://mycustomdomain/myservicepath</code>, escriba <code>/myservicepath</code> como vía de acceso. </li></ul>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la <a href="#rewrite" target="_blank">anotación de reescritura</a> para establecer la ruta adecuada para su app.
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
    1.  Abra el editor que prefiera y cree un script de configuración de punto final llamado, por ejemplo, `myexternalendpoint.yaml`.
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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sustituya <em>&lt;myendpointname&gt;</em> por el nombre del punto final de Kubernetes.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Sustituya <em>&lt;externalIP&gt;</em> por las direcciones IP públicas que desea conectar con la app externa. </td>
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
    1.  Abra el editor que prefiera y cree un script de configuración de servicio llamado, por ejemplo, `myexternalservice.yaml`.
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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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
    1.  Abra el editor que prefiera y cree un script de configuración de Ingress llamado, por ejemplo, `myexternalingress.yaml`. 
    2.  Defina un recurso de Ingress en el script de configuración que utilice el dominio proporcionado por IBM y el certificado TLS para direccionar el tráfico de entrada de red a la app externa utilizando el punto final externo que ha definido anteriormente. Para cada servicio puede definir una vía de acceso individual que se añade al dominio proporcionado por IBM o al dominio personalizado para crear una vía de acceso exclusiva a la app, por ejemplo `https://ingress_domain/myapp`. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress consulta el servicio asociado y envía el tráfico de red de entrada al servicio, y luego a la app externa.

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
        <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress. </td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Sustituya <em>&lt;ibmtlssecret&gt;</em> por el <strong>secreto de Ingress</strong> proporcionado por IBM en el paso anterior. Este certificado gestiona la terminación de TLS.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Sustituya <em>&lt;ibmdomain&gt;</em> por el nombre del <strong>Subdominio de Ingress</strong> proporcionado por IBM en el paso anterior. Este dominio está configurado para la terminación TLS.

        </br></br>
        <strong>Nota:</strong> No utilice &ast; para el host ni deje la propiedad host vacía para evitar errores durante la creación de Ingress. </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Sustituya <em>&lt;myexternalservicepath&gt;</em> con una única barra o con la vía de acceso exclusiva en la que su app externa está a la escucha, de forma que el tráfico de la red se pueda reenviar a la app.


        </br>
        Por cada servicio de Kubernetes, puede definir una vía de acceso individual que se añade a su dominio para crear una vía de acceso exclusiva a la app, por ejemplo <code>https://ibmdomain/myservicepath1</code>. Cuando especifica esta ruta en un navegador web, el tráfico de la red se direcciona al controlador de Ingress. El controlador de Ingress busca el servicio asociado y envía el tráfico de red a la app externa utilizando la misma vía de acceso. Se debe configurar a la app para que escuche en esta vía de servicio con el propósito de recibir el tráfico de red entrante.

        </br></br>
        Muchas apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina la vía de acceso raíz como <code>/</code> y no especifique una vía de acceso individual para la app.

        </br></br>
        <strong>Sugerencia:</strong> Si desea configurar su instancia de Ingress para que escuche en una vía de acceso que sea distinta de aquella en la que escuchan sus apps, utilice la <a href="#rewrite" target="_blank">anotación de reescritura</a> para establecer la ruta adecuada para su app.
</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Sustituya <em>&lt;myexternalservice&gt;</em> por el nombre del servicio que ha utilizado al crear el servicio de Kubernetes para la app externa. </td>
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


#### Anotaciones Ingress soportadas
{: #ingress_annotation}

Puede especificar los metadatos de los recursos Ingress para añadir prestaciones a su controlador de Ingress.
{: shortdesc}

|Anotación admitida|Descripción|
|--------------------|-----------|
|[Reescrituras](#rewrite)|Se direcciona el tráfico de red entrante a una vía de acceso distinta de aquella en la que escucha la app de fondo. |
|[Afinidad de sesión con cookies](#sticky_cookie)|El tráfico de red de entrada siempre se direcciona al mismo servidor en sentido ascendente mediante una "sticky cookie". |
|[Solicitud de cliente o cabecera de respuesta adicional](#add_header)|Añade información de cabecera adicional a una solicitud de cliente antes de reenviar la solicitud a la app de fondo, o añade una respuesta del cliente antes de enviar la respuesta al cliente.|
|[Eliminación de cabecera de respuesta del cliente](#remove_response_headers)|Elimina la información de cabecera de una respuesta del cliente antes de reenviar la respuesta al cliente.|
|[HTTP redirecciona a HTTPs](#redirect_http_to_https)|Redirige las solicitudes HTTP no seguras del dominio a HTTPs.|
|[Colocación en almacenamiento intermedio de datos de respuesta del cliente](#response_buffer)|Inhabilita la colocación en almacenamiento intermedio de una respuesta del cliente en el controlador Ingress al enviar la respuesta al cliente.|
|[tiempos de espera excedidos de conexión y tiempos de espera excedidos de lectura personalizados](#timeout)|Ajusta el tiempo que el controlador Ingress espera para conectarse a la app de fondo y para leer información de la misma antes de considerar que la app de fondo no está disponible. |
|[Tamaño máximo personalizado de cuerpo de solicitud del cliente](#client_max_body_size)|Ajusta el tamaño del cuerpo de la solicitud del cliente que se puede enviar al controlador Ingress. |

##### **Direccionamiento de tráfico de red entrante a una vía de acceso diferente utilizando anotaciones de reescritura**
{: #rewrite}

Utilice la anotación de reescritura para direccionar el tráfico de red de entrada en una vía de acceso de dominio de controlador de Ingress a una vía de acceso diferente que escuche su aplicación de fondo. {:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El dominio del controlador de Ingress direcciona el tráfico de entrada de la red de <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> a la app. La app escucha en <code>/coffee</code> en lugar de en <code>/beans</code>. Para reenviar tráfico de red de entrada a la app, añada la anotación de reescritura a su archivo de configuración de recursos Ingress, de modo que el tráfico de red de entrada <code>/beans</code> se reenvíe a la app mediante la vía de acceso <code>/coffee</code>. Si incluye varios servicios, utilice únicamente un punto y coma (;) para separarlos.
</dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;rewrite_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;rewrite_path2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
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
<th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>Sustituya <em>&lt;service_name&gt;</em> con el nombre del servicio Kubernetes que ha creado para la app, y <em>&lt;rewrite-path&gt;</em> con la vía de acceso que la app escucha. El tráfico de red de entrada del dominio de controlador de Ingress se reenvía al servicio Kubernetes mediante esta vía de acceso. La mayoría de las apps no escuchan en una vía de acceso específica, sino que utilizan la vía de acceso raíz y un puerto específico. En este caso, defina <code>/</code> como <em>&lt;rewrite-path&gt;</em> de la app.</td>
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


##### **El tráfico de red de entrada siempre se direcciona al mismo servidor en sentido ascendente mediante una "sticky cookie".** 
{: #sticky_cookie}

Utilice la anotación de la sticky cookie para añadir afinidad de sesión al controlador de Ingress.{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Es posible que la configuración de la app requiera que despliegue varios servidores en sentido ascendente para que gestionen las solicitudes entrantes del cliente y garanticen una mayor disponibilidad. Cuando un cliente se conecta a la app de fondo, podría ser útil que un cliente recibiera el servicio del mismo servidor en sentido ascendente mientras dure la sesión o durante el tiempo que se tarda en completar una tarea. Puede configurar el controlador de Ingress de modo que asegure la afinidad de sesión direccionando siempre el tráfico de red de entrada al mismo servidor en sentido ascendente. </br>
El controlador de Ingress asigna cada cliente que se conecta a la app de fondo a uno de los servidores en sentido ascendente disponibles. El controlador de Ingress crea una cookie de sesión que se almacena en la app del cliente y que se incluye en la información de cabecera de cada solicitud entre el controlador de Ingress y el cliente. La información de la cookie garantiza que todas las solicitudes se gestionan en el mismo servidor en sentido ascendente durante todo el periodo de la sesión. </br></br>
Si incluye varios servicios, utilice únicamente un punto y coma (;) para separarlos.
</dd>
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
  <caption>Tabla 12. Visión general de los componentes del archivo YAML</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes: <ul><li><code><em>&lt;service_name&gt;</em></code>: El nombre del servicio de Kubernetes que ha creado para la app. </li><li><code><em>&lt;cookie_name&gt;</em></code>: Elija un nombre de la "sticky cookie" que se ha creado durante una sesión. </li><li><code><em>&lt;expiration_time&gt;</em></code>: el tiempo, en segundos, minutos h horas, que transcurre antes de que caduque la "sticky cookie". Este tiempo depende de la actividad del usuario. Una vez caducada la cookie, el navegador web del cliente la suprime y se deja de enviar al controlador de Ingress. Por ejemplo, para establecer un tiempo de caducidad de 1 segundo, 1 minutos o 1 hora, escriba <strong>1s</strong>, <strong>1m</strong> o <strong>1h</strong>.</li><li><code><em>&lt;cookie_path&gt;</em></code>: La vía de acceso que se añade al subdominio de Ingress y que indica los dominios y subdominios para los que se envía la cookie al controlador de Ingress. Por ejemplo, si el dominio de Ingress es <code>www.myingress.com</code> y desea enviar la cookie en cada solicitud del cliente, debe establecer <code>path=/</code>. Si desea enviar la cookie solo para <code>www.myingress.com/myapp</code> y todos sus subdominios, establezca este valor en <code>path=/myapp</code>.</li><li><code><em>&lt;hash_algorithm&gt;</em></code>: El algoritmo hash que protege la información de la cookie. Solo se admite <code>sha1
</code>. SHA1 crea una suma de hash en función de la información de la cookie y añade esta suma de hash a la cookie. El servidor puede descifrar la información de la cookie y verificar la integridad de los datos. </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **Adición de cabeceras HTTP personalizadas a una solicitud del cliente o respuesta del cliente**
{: #add_header}

Utilice esta anotación para añadir información de cabecera adicional a una solicitud de cliente antes de enviar la solicitud a la app de fondo o para añadir una respuesta del cliente antes de enviar la respuesta al cliente.{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El controlador de Ingress actúa como un proxy entre la app del cliente y la app de fondo. Las solicitudes del cliente que se envían al controlador de Ingress se procesan (mediante proxy) y se colocan en una nueva solicitud que se envía del controlador de Ingress a la app de fondo. El proceso mediante proxy de una solicitud elimina la información de cabecera, como por ejemplo el nombre de usuario, que se envió inicialmente desde el cliente. Si la app de fondo necesita esta información, puede utilizar la anotación <strong>ingress.bluemix.net/proxy-add-headers</strong> para añadir información de cabecera a la solicitud del cliente antes que la solicitud se reenvíe del controlador de Ingress a la app de fondo.
</br></br>
Cuando una app de fondo envía una respuesta al cliente, el controlador de Ingress procesa mediante proxy la respuesta y las cabeceras http se eliminan de la respuesta. Es posible que la app web del cliente necesite esta información de cabecera para poder procesar la respuesta. Puede utilizar la anotación <strong>ingress.bluemix.net/response-add-headers</strong> para añadir información de cabecera a la respuesta del cliente antes de que la respuesta se reenvíe del controlador de Ingress a la app web del cliente. </dd>
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
  <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes: <ul><li><code><em>&lt;service_name&gt;</em></code>: El nombre del servicio de Kubernetes que ha creado para la app. </li><li><code><em>&lt;header&gt;</em></code>: La clave de la información de cabecera que se va a añadir a la solicitud del cliente o a la respuesta del cliente. </li><li><code><em>&lt;value&gt;</em></code>: El valor de la información de cabecera que se va a añadir a la solicitud del cliente o a la respuesta del cliente. </li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **Eliminación de la información de cabecera de la respuesta de un cliente**
{: #remove_response_headers}

Utilice esta anotación para eliminar la información de cabecera que se incluye en la respuesta del cliente de la app de fondo antes de que la respuesta se envíe al cliente. {:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El controlador de Ingress actúa como un proxy entre la app de fondo y el navegador web del cliente. Las respuestas del cliente procedentes de la app de fondo que se envían al controlador de Ingress se procesan (mediante proxy) y se colocan en una nueva respuesta que se envía del controlador de Ingress al navegador web del cliente. Aunque el proceso mediante proxy de una respuesta elimina la información de cabecera http que se envió inicialmente desde la app de fondo, es posible que este proceso no elimine todas las cabeceras específicas de la app de fondo. Utilice esta anotación para eliminar la información de cabecera de la respuesta del cliente antes de la respuesta se reenvíe del controlador de Ingress al navegador web del cliente.</dd>
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
  <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes: <ul><li><code><em>&lt;service_name&gt;</em></code>: El nombre del servicio de Kubernetes que ha creado para la app. </li><li><code><em>&lt;header&gt;</em></code>: La clave de la cabecera que se va a eliminar de la respuesta del cliente. </li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **Redirección de solicitudes de cliente http no seguras a https**
{: #redirect_http_to_https}

Utilice la anotación redirect para convertir solicitudes de cliente http no seguras en https.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Puede configurar el controlador de Ingress de modo que proteja el dominio con el certificado TLS proporcionado por IBM o por un certificado TLS personalizado. Es posible que algunos usuarios intenten acceder a sus apps mediante una solicitud http no segura al dominio del controlador de Ingress, por ejemplo <code>http://www.myingress.com</code>, en lugar hacerlo de mediante <code>https</code>. Puede utilizar la anotación redirect para convertir siempre las solicitudes http no seguras en https.
Si no utiliza esta anotación, las solicitudes http no seguras no se convertirán en solicitud https de forma predeterminada y se podría exponer información confidencial al público sin cifrado. </br></br>
La redirección de solicitudes http a https está inhabilitada de forma predeterminada. </dd>
<dt>YAML del recurso de Ingress de ejemplo</dt>

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

##### **Inhabilitación de la colocación en almacenamiento intermedio de respuestas de fondo en el controlador de Ingress**
{: #response_buffer}

Utilice la anotación buffer para inhabilitar el almacenamiento de datos de respuesta en el controlador de Ingress mientras los datos se envían al cliente.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>El controlador de Ingress actúa como un proxy entre la app de fondo y el navegador web del cliente. Cuando se envía una respuesta de la app de fondo al cliente, los datos de la respuesta se colocan en almacenamiento intermedio en el controlador de Ingress de forma predeterminada. El controlador de Ingress procesa mediante proxy la respuesta del cliente y empieza a enviar la respuesta al cliente al ritmo del cliente. Cuando el controlador de Ingress ha recibido todos los datos procedentes de la app de fondo, la conexión con la app de fondo se cierra. La conexión entre el controlador de Ingress y el cliente permanece abierta hasta que el cliente haya recibido todos los datos. </br></br>
Si se inhabilita la colocación en almacenamiento intermedio de los datos de la respuesta en el controlador de Ingress, los datos se envían inmediatamente del controlador de Ingress al cliente. El cliente debe ser capaz de manejar los datos de entrada al ritmo del controlador de Ingress. Si el cliente es demasiado lento, es posible que se pierdan datos.</br></br>
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


##### **Establecimiento de un tiempo de espera excedido de conexión y de un tiempo de espera excedido de lectura personalizados para el controlador de Ingress**
{: #timeout}

Ajusta el tiempo que el controlador de Ingress espera para conectarse a la app de fondo y para leer información de la misma antes de considerar que la app de fondo no está disponible. {:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Cuando se envía una solicitud del cliente al controlador de Ingress, este abre una conexión con la app de fondo. De forma predeterminada, el controlador de Ingress espera 60 segundos para recibir una respuesta de la app de fondo. Si la app de fondo no responde en un plazo de 60 segundos, la solicitud de conexión se cancela y se considera que la app de fondo no está disponible. </br></br>
Después de que el controlador de Ingress se conecte a la app de fondo, el controlador de Ingress lee los datos de la respuesta procedente de la app de fondo. Durante esta operación de lectura, el controlador de Ingress espera un máximo de 60 segundos entre dos operaciones de lectura para recibir datos de la app de fondo. Si la app de fondo no envía datos en un plazo de 60 segundos, la conexión con la app de fondo se cierra y se considera que la app no está disponible. </br></br>
60 segundos es el valor predeterminad para el tiempo de espera excedido de conexión (connect-timeout) y el tiempo de espera excedido de lectura (read-timeout) en un proxy y lo recomendable es no modificarlo.
</br></br>
Si la disponibilidad de la app no es estable o si la app es lenta en responder debido a cargas de trabajo elevadas, es posible que desee aumentar el valor de connect-timeout o de read-timeout. Tenga en cuenta que aumentar el tiempo de espera excedido afecta al rendimiento del controlador de Ingress ya que la conexión con la app de fondo debe permanecer abierta hasta que se alcanza el tiempo de espera excedido.</br></br>
Por otro lado, puede reducir el tiempo de espera para aumentar el rendimiento del controlador de Ingress. Asegúrese de que la app de fondo es capaz de manejar las solicitudes dentro del tiempo de espera especificado, incluso con cargas de trabajo altas. </dd>
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
  <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya los valores siguientes: <ul><li><code><em>&lt;connect_timeout&gt;</em></code>: Escriba el número de segundos que se debe esperar para conectar con la app de fondo, por ejemplo <strong>65s</strong>.

  </br></br>
  <strong>Nota:</strong> El valor de connect-timeout no puede superar los 75 segundos. </li><li><code><em>&lt;read_timeout&gt;</em></code>: Escriba el número de segundos que se debe esperar para leer la información de la app de fondo, por ejemplo <strong>65s</strong>.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **Establecimiento del tamaño máximo permitido del cuerpo de la solicitud del cliente**
{: #client_max_body_size}

Utilice esta anotación para ajustar el tamaño del cuerpo que puede enviar el cliente como parte de una solicitud.
{:shortdesc}

<dl>
<dt>Descripción</dt>
<dd>Para mantener el rendimiento esperado, el tamaño máximo del cuerpo de la solicitud del cliente se establece en 1 megabyte. Cuando se envía una solicitud del cliente con un tamaño de cuerpo que supera el límite al controlador de Ingress y el cliente no puede dividir los datos en varios bloques, el controlador de Ingress devuelve al cliente una respuesta http 413 (la entidad de la solicitud es demasiado grande). No se puede establecer una conexión entre el cliente y el controlador Ingress hasta que se reduce el tamaño del cuerpo de la solicitud. Si el cliente puede dividir los datos en varios bloques, los datos se dividen en paquetes de 1 megabyte y se envían al controlador de Ingress.

</br></br>
Es posible que desee aumentar el tamaño máximo del cuerpo porque espera solicitudes del cliente con un tamaño de cuerpo superior a 1 megabyte. Por ejemplo, si desea que el cliente pueda cargar archivos grandes. El hecho de aumentar el tamaño máximo del cuerpo de la solicitud puede afectar el rendimiento del controlador de Ingress ya que la conexión con el cliente debe permanecer abierta hasta que se recibe la solicitud.</br></br>
<strong>Nota:</strong> Algunos navegadores web de cliente no pueden mostrar correctamente el mensaje de respuesta de http 413. </dd>
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
  <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>Sustituya el siguiente valor: <ul><li><code><em>&lt;size&gt;</em></code>: Escriba el tamaño máximo del cuerpo de la respuesta del cliente. Por ejemplo, para establecerlo en 200 megabytes, defina <strong>200m</strong>.

  </br></br>
  <strong>Nota:</strong> Puede establecer el tamaño en 0 para inhabilitar la comprobación del tamaño del cuerpo de la solicitud del cliente.</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


## Gestión de direcciones IP y subredes
{: #cs_cluster_ip_subnet}

Puede utilizar subredes públicas portátiles y direcciones IP para exponer apps en el clúster y hacer que se pueda acceder a las mismas desde Internet.
{:shortdesc}

En {{site.data.keyword.containershort_notm}}, tiene la posibilidad de añadir direcciones IP portátiles y estables para los servicios de Kubernetes añadiendo subredes al clúster. Cuando se crea un clúster estándar, {{site.data.keyword.containershort_notm}} automáticamente suministran una subred pública portátil y 5 direcciones IP. Las direcciones IP públicas portátiles son estáticas y no cambian cuando se elimina un nodo trabajador o incluso el clúster.

Una de las direcciones IP públicas portátiles se utiliza para el [controlador de Ingress](#cs_apps_public_ingress), que puede utilizar para exponer varias apps en el clúster utilizando una ruta pública. Las 4 direcciones IP públicas portátiles restantes se pueden utilizar para exponer apps individuales al público mediante la [creación de un servicio equilibrador de carga](#cs_apps_public_load_balancer).

**Nota:** Las direcciones IP públicas portátiles se facturan mensualmente. Si decide retirar las direcciones IP públicas portátiles una vez suministrado el clúster, tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.



1.  Cree un script de configuración de servicio Kubernetes denominado `myservice.yaml` y defina un servicio de tipo `LoadBalancer` con una dirección IP de equilibrador de carga ficticia. En el ejemplo siguiente se utiliza la dirección IP 1.1.1.1 como dirección IP del equilibrador de carga.

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

### Liberación de direcciones IP públicas utilizadas
{: #freeup_ip}

Puede liberar una dirección IP pública portátil utilizada suprimiendo el servicio equilibrador de carga que está utilizando la dirección IP pública portátil.

[Antes de empezar, establezca el contexto para el clúster que desea utilizar.](cs_cli_install.html#cs_cli_configure)

1.  Obtenga una lista de los servicios disponibles en el clúster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Elimine el servicio equilibrador de carga que utiliza una dirección IP pública.

    ```
    kubectl delete service <myservice>
    ```
    {: pre}


## Despliegue de apps con la GUI
{: #cs_apps_ui}

Cuando despliega una app a un clúster utilizando el panel de control de Kubernetes, se crea automáticamente un despliegue que crea, actualiza y gestiona los pods del clúster.
{:shortdesc}

Antes de empezar:

-   Instale las [CLI](cs_cli_install.html#cs_cli_install) necesarias.
-   Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para desplegar la app:

1.  [Abra el panel de control de Kubernetes](#cs_cli_dashboard).
2.  En el panel de control de Kubernetes, pulse **+ Crear**.
3.  Seleccione **Especificar detalles de app a continuación** para especificar los detalles de la app en la GUI o bien **Cargar un archivo YAML o JSON** para cargar el [archivo de configuración![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) de la app. Utilice [este archivo YAML de ejemplo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) para desplegar un contenedor desde la imagen **ibmliberty** de la región US-Sur. 
4.  En el panel de control de Kubernetes, pulse **Despliegues** para verificar que el despliegue se ha creado.
5.  Si ha puesto la app a disponibilidad pública mediante un servicio de puerto de nodo, un servicio de equilibrador de carga o Ingress, [compruebe que puede acceder a la app](#cs_apps_public).

## Despliegue de apps con la CLI
{: #cs_apps_cli}

Después de crear un clúster, puede desplegar una app en dicho clúster mediante la CLI de Kubernetes.
{:shortdesc}

Antes de empezar:

-   Instale las [CLI](cs_cli_install.html#cs_cli_install) necesarias.
-   Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para desplegar la app:

1.  Cree un script de configuración basado en la [prácticas recomendadas de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/overview/). Generalmente, un script de configuración contiene detalles de configuración de cada uno de los recursos que está creando en Kubernetes. El script puede incluir una o varias de las siguientes secciones:


    -   [Despliegue ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/): Define la creación de pods y conjuntos de réplicas. Un pod incluye una app contenerizada individual y conjuntos de réplicas que controlan varias instancias de pods.

    -   [Servicio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/): Ofrece un acceso frontal a los pods mediante un nodo trabajador o una dirección IP pública de equilibrador de carga, o bien una ruta pública de Ingress. 

    -   [Ingress ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/ingress/): Especifica un tipo de equilibrador de carga que ofrece rutas para acceder a la app a nivel público. 

2.  Ejecute el script de configuración en el contexto de un clúster.

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  Si ha puesto la app a disponibilidad pública mediante un servicio de puerto de nodo, un servicio de equilibrador de carga o Ingress, [compruebe que puede acceder a la app](#cs_apps_public).



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
    <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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

## Creación de almacenamiento permanente
{: #cs_apps_volume_claim}

Cree una reclamación de volumen permanente para suministrar almacenamiento de archivos NFS al clúster. Monte esta reclamación en un pod para asegurarse de que los datos estén disponibles aunque el pod se cuelgue o se cierre.{:shortdesc}

IBM coloca el almacén de archivos NFS que contiene el volumen permanente en un clúster para ofrecer una alta disponibilidad de los datos. 

1.  Revise las clases de almacenamiento disponibles. {{site.data.keyword.containerlong}} ofrece tres clases de almacenamiento predefinidas para que el administrador del clúster no tenga que crear ninguna clase de almacenamiento.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  Revise el IOPS de una clase de almacenamiento o los tamaños disponibles.

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

3.  Con el editor de texto que desee, cree un script de configuración para definir su reclamación de volumen permanente y guarde la configuración como un archivo `.yaml`. 

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

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Escriba el nombre de la reclamación de volumen permanente.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>Especifique la clase de almacenamiento que define el IOPS por GB de la compartición de archivos de host para el volumen permanente: <ul><li>ibmc-file-bronze: 2 IOPS por GB.</li><li>ibmc-file-silver: 4 IOPS por GB.</li><li>ibmc-file-gold: 10 IOPS por GB.</li>

    </li> Si no especifica ninguna clase de almacenamiento, el volumen permanente se crea en la clase de almacenamiento "bronze".</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Si elige un tamaño distinto del que aparece en la lista, el tamaño se redondea al alza. Si selecciona un tamaño mayor que el tamaño más grande, el tamaño se redondea a la baja.</td>
    </tr>
    </tbody></table>

4.  Cree la reclamación de volumen permanente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

5.  Compruebe que la reclamación de volumen permanente se haya creado y vinculado al volumen permanente. Este proceso puede tardar unos minutos.

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

6.  {: #cs_apps_volume_mount}Para montar la reclamación de volumen permanente en el pod, cree un script de configuración. Guarde la configuración como archivo `.yaml`.

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
    <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
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

7.  Cree el pod y monte la reclamación de volumen permanente en el pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

8.  Verifique que el volumen se ha montado correctamente en el pod.

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

## Adición de acceso de usuario no root al almacenamiento permanente
{: #cs_apps_volumes_nonroot}

Los usuarios no root no tienen permiso de escritura sobre la vía de acceso de montaje del volumen para el almacenamiento respaldado por NFS. Para otorgar permiso de escritura, debe editar el Dockerfile de la imagen para crear un directorio en la vía de acceso de montaje con el permiso correcto.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure). 

Si está diseñando una app con un usuario no root que requiere permiso de escritura sobre el volumen, debe añadir los siguientes procesos al script de punto de entrada y al archivo Docker:

-   Cree un usuario no root.
-   Añada temporalmente el usuario al grupo raíz.
-   Cree un directorio en la vía de acceso de montaje con los permisos de usuario correctos.

Para {{site.data.keyword.containershort_notm}}, el propietario predeterminado de la vía de acceso de montaje del volumen es el propietario `nobody`. Con el almacenamiento NFS, si el propietario no existe localmente en el pod, se crea el usuario `nobody`. Los volúmenes están configurados para reconocer el usuario root en el contenedor, el cual, para algunas apps es el único usuario dentro de un contenedor. Sin embargo, muchas apps especifican un usuario no root que no es `nobody` que escribe en la vía de acceso de montaje del contenedor.

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

8.  Cree un script de configuración y monte el volumen y ejecute el pod desde la imagen nonroot. La vía de acceso de montaje del volumen `/mnt/myvol` coincide con la vía de acceso especificada en el Dockerfile. Guarde la configuración como archivo `.yaml`.

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


