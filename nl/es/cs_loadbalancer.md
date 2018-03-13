---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuración de los servicios del equilibrador de carga
{: #loadbalancer}

Exponga un puerto y utilice la dirección IP portátil para que el equilibrador de carga acceda a la app. Utilice una dirección IP pública para hacer una app accesible en Internet o una dirección IP privada para hacer una app accesible en la red de infraestructura privada.
{:shortdesc}



## Configuración del acceso a una app utilizando el tipo de servicio LoadBalancer
{: #config}

A diferencia del servicio NodePort, la dirección IP portátil del servicio equilibrador de carga no depende del nodo trabajador en el que se ha desplegado la app. Sin embargo, un servicio LoadBalancer de Kubernetes es también un servicio NodePort. Un servicio LoadBalancer hace que la app está disponible en la dirección IP y puerto del equilibrador de carga y hace que la app está disponible en los puertos del nodo del servicio.
{:shortdesc}

La dirección IP portátil del equilibrador de carga se asigna automáticamente y no cambia cuando se añaden o eliminan nodos trabajadores. Por lo tanto, los servicios del equilibrador de carga están más disponibles que los servicios NodePort. Los usuarios pueden seleccionar cualquier puerto para el equilibrador de carga y no están limitados al rango de puertos de NodePort. Puede utilizar los servicios equilibradores de carga para los protocolos TCP y UDP.

**Nota:** Los servicios LoadBalancer no dan soporte a la terminación TLS. Si la app necesita terminación TLS, puede exponer la app mediante [Ingress](cs_ingress.html) o configurar la app de modo que gestione la terminación TLS.

Antes de empezar:

-   Esta característica solo está disponible para clústeres estándares.
-   Debe tener una dirección IP pública o privada portátil disponible para asignarla al servicio equilibrador de carga.
-   Un servicio de equilibrador de carga con una dirección IP privada portátil sigue teniendo un puerto de nodo público abierto en cada nodo trabajador. Para añadir una política de red para impedir el tráfico público, consulte [Bloqueo del tráfico de entrada](cs_network_policy.html#block_ingress).

Para crear un servicio equilibrador de carga:

1.  [Despliegue la app en el clúster](cs_app.html#app_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.
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
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>Visión general de los componentes de archivo del servicio LoadBalancer</caption>
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
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Al crear un LoadBalancer privado o utilizar una dirección IP portátil específica para un LoadBalancer público, sustituya <em>&lt;loadBalancerIP&gt;</em> por la dirección IP que desee utilizar. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

    3.  Opcional: Configure un cortafuegos especificando `loadBalancerSourceRanges` en la sección spec. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Cree el servicio en el clúster.

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
    Location:               dal10
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----			-------------	--------	------			-------
      10s		10s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
      10s		10s		1	{service-controller }			Normal		CreatedLoadBalancer	Created load balancer
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
