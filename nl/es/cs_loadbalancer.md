---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Exposición de apps con LoadBalancers
{: #loadbalancer}

Exponga un puerto y utilice la dirección IP portátil para que el equilibrador de carga acceda a la app contenerizada.
{:shortdesc}

## Gestión de tráfico de red utilizando LoadBalancers
{: #planning}

Cuando se crea un clúster estándar, {{site.data.keyword.containershort_notm}} solicita automáticamente cinco direcciones IP públicas portátiles y cinco direcciones IP privadas portátiles y las suministra a la cuenta de infraestructura de IBM Cloud (SoftLayer) durante la creación de un clúster. Dos de las direcciones IP portátiles, una pública y una privada, se utilizan para los [equilibradores de carga de aplicación de Ingress](cs_ingress.html). Se pueden utilizar cuatro direcciones IP públicas portátiles y cuatro direcciones IP privadas portátiles para exponer apps al público mediante la creación de un servicio LoadBalancer.

Cuando se crea un servicio LoadBalancer de Kubernetes en un clúster en una VLAN pública, se crea un equilibrador de carga externo. Las opciones para las direcciones IP cuando se crea un servicio LoadBalancer son las siguientes:

- Si el clúster está en una VLAN pública, se utiliza una de las cuatro direcciones IP públicas portátiles disponibles.
- Si el clúster solo está disponible en una VLAN privada, se utiliza una de las cuatro direcciones IP privadas portátiles disponibles.
- Puede solicitar una dirección IP privada o pública portátil para un servicio LoadBalancer añadiendo una anotación al archivo de configuración: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.

La dirección IP pública portátil asignada al servicio LoadBalancer es permanente y no cambia cuando se elimina o se vuelve a crear un nodo trabajador. Por lo tanto, el servicio LoadBalancer está más disponible que el servicio NodePort. A diferencia de los servicios NodePort, puede asignar cualquier puerto al equilibrador de carga y no está vinculado a ningún rango de puertos determinado. Si utiliza un servicio LoadBalancer, también hay un puerto de nodo disponible en cada dirección IP de cualquier nodo trabajador. Para bloquear el acceso al puerto del nodo mientras está utilizando un servicio LoadBalancer, consulte [Bloqueo del tráfico de entrada](cs_network_policy.html#block_ingress).

El servicio LoadBalancer sirve como punto de entrada externo para las solicitudes entrantes para la app. Para acceder al servicio LoadBalancer desde Internet, utilice la dirección IP pública del equilibrador de carga y el puerto asignado en el formato `<IP_address>:<port>`. El siguiente diagrama muestra cómo se dirige la comunicación del equilibrador de carga desde Internet a una app:

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Exponer una app en {{site.data.keyword.containershort_notm}} utilizando un equilibrador de carga" style="width:550px; border-style: none"/>

1. Se envía una solicitud a la app mediante la dirección IP pública del equilibrador de carga y el puerto asignado en el nodo trabajador.

2. La solicitud se reenvía automáticamente al puerto y a la dirección IP del clúster interno del servicio del equilibrador de carga. Solo se puede acceder a la dirección IP del clúster interno dentro del clúster.

3. `kube-proxy` direcciona la solicitud al servicio del equilibrador de carga de Kubernetes para la app.

4. La solicitud se reenvía a la dirección IP privada del pod en el que se ha desplegado la app. Si se despliegan varias instancias de app en el clúster, el equilibrador de carga direcciona las solicitudes entre los pods de app.




<br />




## Habilitación de acceso público o privado a una app mediante un servicio LoadBalancer
{: #config}

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
          name: myloadbalancer
        spec:
          type: LoadBalancer
          selector:
            <selector_key>:<selector_value>
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
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>selector</code></td>
          <td>Especifique el par de clave de etiqueta (<em>&lt;selector_key&gt;</em>) y valor (<em>&lt;selector_value&gt;</em>) que desee utilizar para establecer como destino los pods en los que se ejecuta la app. Para especificar e incluir sus pods en el equilibrio de carga del servicio, asegúrese de que <em>&lt;selector_key&gt;</em> y <em>&lt;selector_value&gt;</em> coinciden con el par de clave/valor que utilizó en la sección <code>spec.template.metadata.labels</code> de su despliegue yaml. </td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>El puerto que en el que está a la escucha el servicio.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Anotación para especificar el tipo de LoadBalancer. Los valores aceptados son `private` y `public`. Si va a crear un LoadBalancer público en clústeres en VLAN públicas, esta anotación no es necesaria.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Para crear un LoadBalancer privado o utilizar una dirección IP portátil específica para un LoadBalancer público, sustituya <em>&lt;IP_address&gt;</em> por la dirección IP que desee utilizar. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

    3.  Opcional: Configure un cortafuegos especificando `loadBalancerSourceRanges` en la sección **spec**.  Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Cuando se crea el servicio equilibrador de carga, se asigna automáticamente una dirección IP portátil al equilibrador de carga. Si no hay ninguna dirección IP portátil disponible, no se puede crear el servicio equilibrador de carga.

3.  Verifique que el servicio de equilibrio de carga se haya creado correctamente.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **Nota:** Pueden transcurrir unos minutos hasta que el servicio equilibrador de carga se cree correctamente y la app esté disponible.

    Ejemplo de salida de CLI:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    La dirección IP de **LoadBalancer Ingress** es la dirección IP portátil que asignada al servicio equilibrador de carga.

4.  Si ha creado un equilibrador de carga público, acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Especifique la dirección IP pública portátil del equilibrador de carga y el puerto.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Si elige [ conservar la dirección IP de origen del paquete entrante ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) y tiene nodos extremos, nodos trabajadores únicamente privados o varias VLAN, asegúrese de incluir los pods de app en el equilibrio de carga [añadiendo tolerancia y afinidad de nodos a los pods de app](#node_affinity_tolerations). 

<br />


## Adición de tolerancias y afinidad de nodos a los pods de app para direcciones IP de origen
{: #node_affinity_tolerations}

Siempre que despliega pods de app, también se despliegan pods de servicio de equilibrio de carga en los nodos trabajadores donde se despliegan los pods de app. Sin embargo, existen algunas situaciones donde los pods de equilibrador de carga y los pods de app podrían no planificarse en los mismos nodos trabajadores:
{: shortdesc}

* Tiene nodos extremos con antagonismos en los que únicamente se pueden desplegar pods de servicio de equilibrio de carga. No se permite desplegar pods de app en dichos nodos. 
* El clúster está conectado a varias VLAN públicas o privadas, y sus pods de app podrían desplegarse en nodos trabajadores que están conectados únicamente a una VLAN. Pods de servicio de equilibrador de carga podrían no desplegarse en dichos nodos trabajadores porque la dirección de IP del equilibrador de carga estuviese conectado a VLAN distintas de las de los nodos trabajadores. 

Cuando una solicitud de cliente para su app se envía a su clúster, la solicitud se direcciona a un pod para el servicio de equilibrador de carga de Kubernetes que expone la app. Si un pod de app no existe en el mismo nodo trabajador que el pod de servicio de equilibrador de carga, el equilibrador de carga reenvía la solicitud a un nodo trabajador diferente donde esté desplegado el pod de app. La dirección IP de origen del paquete se cambia a la dirección IP pública del nodo trabajador donde el pod de app está en ejecución. 

Si desea conservar la dirección IP de origen original de la solicitud del cliente, puede [habilitar la dirección IP de origen ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer) para servicios de equilibrio de carga. Conservar la dirección IP del cliente es útil, por ejemplo, cuando los servidores de aplicaciones tienen que aplicar políticas de control de acceso y seguridad. Después de habilitar la dirección IP de origen, los pods de servicio de equilibrador de carga deben reenviar las solicitudes a los pods de app que se desplieguen únicamente en el mismo nodo trabajador. Para forzar el despliegue de una app en los nodos trabajadores específicos en los que también se puedan desplegar los pods de servicio de equilibrador de carga, debe añadir tolerancias y reglas de afinidad al despliegue de dichas app. 

### Adición de tolerancias y reglas de afinidad de nodo extremo
{: #edge_nodes}

Cuando [etiqueta nodos trabajadores como nodos extremos](cs_edge.html#edge_nodes), los pods de servicio de equilibrador de carga únicamente despliegan en dichos nodos de extremo. Si también añade [antagonismo a los nodos extremos](cs_edge.html#edge_workloads), los pods de aplicaciones no pueden desplegar en nodos extremos.
{:shortdesc}

Cuando habilita la dirección IP de origen, las solicitudes entrantes no se pueden reenviar desde el equilibrador de carga a su pod de app. Para forzar el despliegue de pods de app en nodos extremos, añada una [regla de afinidad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) de nodo extremo y una [tolerancia ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) a su despliegue de app. 

Ejemplo de yaml de despliegue con afinidad y tolerancia de nodo extremo: 

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

Observe que tanto la sección **affinity** como la sección **tolerations** tienen `dedicated` como `key` y `edge` como `value`. 

### Adición de reglas de afinidad para múltiples VLAN privadas o públicas
{: #edge_nodes}

Cuando el clúster está conectado a varias VLAN públicas o privadas, sus pods de app podrían desplegarse en nodos trabajadores que están conectados únicamente a una VLAN. Si la dirección de IP del equilibrador de carga está conectada a una VLAN diferente de la de estos nodos trabajadores, los pods de servicio de equilibrador de carga no se desplegarán en dichos nodos trabajadores.
{:shortdesc}

Cuando la dirección IP de origen esté habilitada, planifique pods de app en nodos trabajadores que estén en la misma VLAN que la dirección IP del equilibrador de carga añadiendo una regla de afinidad al despliegue de la app. 

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

1. Obtenga la dirección IP pública portátil del servicio equilibrador de carga que desee utilizar. Busque la dirección IP en el campo **LoadBalancer Ingress**. 
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Recupere el ID de VLAN al que se conecta el servicio de equilibrador. 

    1. Obtenga una lista de VLAN públicas portátiles para su clúster. 
        ```
        bx cs cluster-get <cluster_name_or_ID> --showResources
        ```
        {: pre}

        Salida de ejemplo:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. En la salida bajo **Subnet VLANs**, busque el CIDR de subred que coincida con la dirección IP del equilibrador de carga que recuperó con anterioridad y anote el ID de VLAN. 

        Por ejemplo, si la dirección IP del servicio de equilibrador de carga es `169.36.5.xxx`, la subred coincidente en la salida del ejemplo anterior es `169.36.5.xxx/29`. El ID de VLAN al que se conecta la subred es `2234945`.

3. [Añada una regla de afinidad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) para el despliegue de app para el ID de VLAN que anotó en el paso anterior. 

    Por ejemplo, si tiene varias VLAN pero desea que sus pods de app se desplieguen en nodos trabajadores únicamente en la VLAN pública `2234945`: 

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    En el yaml anterior, la sección **affinity** tiene `publicVLAN` como `key` y `"2234945"` como `value`.

4. Aplique el archivo de configuración de despliegue actualizado.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. Verifique que los pods de app desplegados en los nodos trabajadores se conectan a la VLAN designada.

    1. Obtenga una lista de pods en el clúster. Sustituya `<selector>` con la etiqueta que utilizó para la app. 
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        Salida de ejemplo:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. En la salida, identifique un pod para su app. Observe el ID **NODE** del nodo trabajador en el que se encuentra el pod. 

        En la salida de ejemplo, el pod de app `cf-py-d7b7d94db-vp8pq` se encuentra en el nodo trabajador `10.176.48.78`. 

    3. Obtener los detalles del nodo trabajador.

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        Salida de ejemplo:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. En la sección **Labels** de la salida, verifique que la VLAN privada o pública es la VLAN es que haya designado en los pasos anteriores. 

