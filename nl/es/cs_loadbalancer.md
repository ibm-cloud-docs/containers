---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Exposición de apps con equilibradores de carga
{: #loadbalancer}

Exponga un puerto y utilice una dirección IP portátil para que el equilibrador de carga de capa 4 acceda a la app contenerizada.
{:shortdesc}



## Componentes y arquitectura del equilibrador de carga
{: #planning}

Cuando se crea un clúster estándar, {{site.data.keyword.containerlong_notm}} suministra automáticamente una subred pública portátil y una subred privada portátil.

* La subred pública portátil proporciona 1 dirección IP pública portátil que utiliza el [ALB público de Ingress](cs_ingress.html) predeterminado. Las 4 direcciones IP públicas portátiles restantes se pueden utilizar para exponer apps individuales en internet mediante la creación de un servicio público de equilibrador de carga.
* La subred privada portátil proporciona 1 dirección IP privada portátil que utiliza el [ALB privado de Ingress](cs_ingress.html#private_ingress) predeterminado. Las 4 direcciones IP privadas portátiles restantes se pueden utilizar para exponer apps individuales en una red privada mediante la creación de un servicio privado de equilibrador de carga.

Las direcciones IP públicas y privadas portátiles son estáticas y no cambian cuando se elimina un nodo trabajador. Si se elimina el nodo trabajador en el que se encuentra la dirección IP del equilibrador de carga, un daemon Keepalived que supervisa constantemente la IP mueve automáticamente la IP a otro nodo trabajador. Puede asignar cualquier puerto al equilibrador de carga y no está vinculado a ningún rango de puertos determinado.

Un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](cs_nodeport.html) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](cs_network_policy.html#block_ingress).

El servicio equilibrador de carga sirve como punto de entrada externo para las solicitudes entrantes para la app. Para acceder al servicio equilibrador de carga desde Internet, utilice la dirección IP pública del equilibrador de carga y el puerto asignado en el formato `<IP_address>:<port>`. El siguiente diagrama muestra cómo se dirige la comunicación del equilibrador de carga desde Internet a una app.

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Exponer una app en {{site.data.keyword.containerlong_notm}} mediante un equilibrador de carga" style="width:550px; border-style: none"/>

1. Una solicitud enviada a la app utiliza la dirección IP pública del equilibrador de carga y el puerto asignado en el nodo trabajador.

2. La solicitud se reenvía automáticamente al puerto y a la dirección IP del clúster interno del servicio equilibrador de carga. Solo se puede acceder a la dirección IP del clúster interno dentro del clúster.

3. `kube-proxy` direcciona la solicitud al servicio equilibrador de carga de Kubernetes para la app.

4. La solicitud se reenvía a la dirección IP privada del pod de la app. La dirección IP de origen del paquete de la solicitud se cambia por la dirección IP pública del nodo trabajador en el que se ejecuta el pod de la app. Si se despliegan varias instancias de app en el clúster, el equilibrador de carga direcciona las solicitudes entre los pods de app.

**Clústeres multizona**:

Si tiene un clúster multizona, las instancias de la app se despliegan en pods en los trabajadores de distintas zonas. En el siguiente diagrama se muestra cómo un equilibrador de carga clásico dirige la comunicación procedente de internet a una app en un clúster multizona.

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Utilice un servicio equilibrador de carga para equilibrar la carga de apps en clústeres multizona" style="width:500px; border-style: none"/>

De forma predeterminada, cada equilibrador de carga se configura solo en una zona. Para conseguir una alta disponibilidad, debe desplegar un equilibrador de carga en cada zona en la que tenga instancias de la app. Los equilibradores de carga de las distintas zonas gestionan las solicitudes en un ciclo en rueda. Además, cada equilibrador de carga direcciona las solicitudes a las instancias de la app en su propia zona y a las instancias de la app en otras zonas.

<br />


## Habilitación del acceso público o privado a una app en un clúster multizona
{: #multi_zone_config}

Nota:
  * Esta característica solo está disponible para clústeres estándares.
  * Los servicios equilibradores de carga no soportan la terminación TLS. Si la app necesita la terminación TLS, puede exponer la app mediante [Ingress](cs_ingress.html) o puede configurar la app para que gestione la terminación TLS.

Antes de empezar:
  * Un servicio de equilibrador de carga con una dirección IP privada portátil sigue teniendo un NodePort público abierto en cada nodo trabajador. Para añadir una política de red para impedir el tráfico público, consulte [Bloqueo del tráfico de entrada](cs_network_policy.html#block_ingress).
  * Debe desplegar un equilibrador de carga en cada zona, y a cada equilibrador de carga se le asigna su propia dirección IP en esa zona. Para crear equilibradores de carga públicos, al menos una VLAN pública debe tener subredes portátiles disponibles en cada zona. Para añadir servicios de equilibrador de carga privado, al menos una VLAN privada debe tener subredes portátiles disponibles en cada zona. Para añadir subredes, consulte [Configuración de subredes para clústeres](cs_subnets.html).
  * Si restringe el tráfico de red a los nodos trabajadores de extremo, asegúrese de que haya al menos 2 [nodos trabajadores de extremo](cs_edge.html#edge) habilitados en cada zona. Si los nodos trabajadores de extremo están habilitados en algunas zonas pero no en otras, los equilibradores de carga no se desplegarán uniformemente. Los equilibradores de carga se desplegarán en nodos de extremo en algunas zonas, pero en nodos trabajadores normales en otras zonas.
  * Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de infraestructura de IBM Cloud (SoftLayer).


Para configurar un servicio equilibrador de carga en un clúster multizona:
1.  [Despliegue la app en el clúster](cs_app.html#app_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.

2.  Cree un servicio equilibrador de carga para la app que desee exponer. Para hacer que la app esté disponible en Internet público o en una red privada, debe crear un servicio Kubernetes para la app. Configure el servicio para que incluya todos los pods que forman la app en el equilibrio de carga.
  1. Cree un archivo de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.
  2. Defina un servicio equilibrador de carga para la app que desee exponer. Puede especificar una zona y una dirección IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
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
      <caption>Visión general de los componentes del archivo YAML</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Anotación para especificar el tipo de equilibrador de carga. Los valores aceptados son <code>private</code> y <code>public</code>. Si va a crear un equilibrador de carga público en clústeres en VLAN públicas, esta anotación no es necesaria.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Anotación para especificar la zona en la que se despliega el servicio de equilibrador de carga. Para ver las zonas, ejecute <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>Especifique el par de clave de etiqueta (<em>&lt;selector_key&gt;</em>) y valor (<em>&lt;selector_value&gt;</em>) para establecer como destino los pods en los que se ejecuta la app. Para especificar como destino sus pods e incluirlos en el equilibrador de carga del servicio, compruebe los valores de <em>&lt;selectorkey&gt;</em> y <em>&lt;selectorvalue&gt;</em>. Asegúrese de que son los mismos que el par <em>clave/valor</em> que utilizó en la sección <code>spec.template.metadata.labels</code> de su yaml de despliegue.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>El puerto que en el que está a la escucha el servicio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Opcional: para crear un equilibrador de carga privado o utilizar una dirección IP portátil específica para un equilibrador de carga público, sustituya <em>&lt;IP_address&gt;</em> por la dirección IP que desee utilizar. Si especifica una zona, la dirección IP debe estar en dicha VLAN o zona. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está disponible en una VLAN privada, se utiliza dirección IP privada portátil.</li></td>
      </tr>
      </tbody></table>

      Archivo de configuración de ejemplo para crear un servicio equilibrador de carga clásico privado que utiliza una dirección IP especificada en `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. Opcional: Configure un cortafuegos especificando `loadBalancerSourceRanges` en la sección **spec**. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Cree el servicio en el clúster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifique que el servicio equilibrador de carga se haya creado correctamente. Sustituya _&lt;myservice&gt;_ por el nombre del servicio equilibrador de carga que ha creado en el paso anterior.

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
    Zone:                   dal10
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

    La dirección IP de **LoadBalancer Ingress** es la dirección IP portátil asignada al servicio equilibrador de carga.

4.  Si ha creado un equilibrador de carga público, acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Especifique la dirección IP pública portátil del equilibrador de carga y el puerto.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}        

5. Si elige [habilitar la conservación de direcciones IP de origen para un servicio de equilibrio de carga ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), asegúrese de que los pods de apps están planificados en los nodos trabajadores de extremo [añadiendo afinidad de nodos de extremo a los pods de app](cs_loadbalancer.html#edge_nodes). Los pods de app se deben planificar en los nodos de extremo para recibir solicitudes entrantes.

6. Para manejar las solicitudes entrantes a su app desde otras zonas, repita los pasos anteriores para añadir un equilibrador de carga en cada zona.

7. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](cs_nodeport.html) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](cs_network_policy.html#block_ingress).

## Habilitación del acceso público o privado a una app en un clúster de una sola zona
{: #config}

Antes de empezar:

-   Esta característica solo está disponible para clústeres estándares.
-   Debe tener una dirección IP pública o privada portátil disponible para asignarla al servicio equilibrador de carga.
-   Un servicio de equilibrador de carga con una dirección IP privada portátil sigue teniendo un NodePort público abierto en cada nodo trabajador. Para añadir una política de red para impedir el tráfico público, consulte [Bloqueo del tráfico de entrada](cs_network_policy.html#block_ingress).

Para crear un servicio equilibrador de carga:

1.  [Despliegue la app en el clúster](cs_app.html#app_cli). Cuando despliegue la app en el clúster, se crean uno o más pods que ejecutan la app en un contenedor. Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.
2.  Cree un servicio equilibrador de carga para la app que desee exponer. Para hacer que la app esté disponible en Internet público o en una red privada, debe crear un servicio Kubernetes para la app. Configure el servicio para que incluya todos los pods que forman la app en el equilibrio de carga.
    1.  Cree un archivo de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.

    2.  Defina un servicio equilibrador de carga para la app que desee exponer.
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
        <caption>Visión general de los componentes del archivo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Anotación para especificar el tipo de equilibrador de carga. Los valores aceptados son `private` y `public`. Si va a crear un equilibrador de carga público en clústeres en VLAN públicas, esta anotación no es necesaria.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Especifique el par de clave de etiqueta (<em>&lt;selector_key&gt;</em>) y valor (<em>&lt;selector_value&gt;</em>) para establecer como destino los pods en los que se ejecuta la app. Para especificar como destino sus pods e incluirlos en el equilibrador de carga del servicio, compruebe los valores de <em>&lt;selector_key&gt;</em> y <em>&lt;selector_value&gt;</em>. Asegúrese de que son los mismos que el par <em>clave/valor</em> que utilizó en la sección <code>spec.template.metadata.labels</code> de su yaml de despliegue.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>El puerto que en el que está a la escucha el servicio.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Opcional: para crear un equilibrador de carga privado o utilizar una dirección IP portátil específica para un equilibrador de carga público, sustituya <em>&lt;IP_address&gt;</em> por la dirección IP que desee utilizar. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está disponible en una VLAN privada, se utiliza dirección IP privada portátil.</li></td>
        </tr>
        </tbody></table>

        Archivo de configuración de ejemplo para crear un servicio equilibrador de carga clásico privado que utiliza una dirección IP especificada:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3.  Opcional: Configure un cortafuegos especificando `loadBalancerSourceRanges` en la sección **spec**. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Cuando se crea el servicio equilibrador de carga, se asigna automáticamente una dirección IP portátil al equilibrador de carga. Si no hay ninguna dirección IP portátil disponible, no se puede crear el servicio equilibrador de carga.

3.  Verifique que el servicio equilibrador de carga se haya creado correctamente.

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

    La dirección IP de **LoadBalancer Ingress** es la dirección IP portátil asignada al servicio equilibrador de carga.

4.  Si ha creado un equilibrador de carga público, acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Especifique la dirección IP pública portátil del equilibrador de carga y el puerto.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Si elige [habilitar la conservación de direcciones IP de origen para un servicio de equilibrio de carga ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), asegúrese de que los pods de apps están planificados en los nodos trabajadores de extremo [añadiendo afinidad de nodos de extremo a los pods de app](cs_loadbalancer.html#edge_nodes). Los pods de app se deben planificar en los nodos de extremo para recibir solicitudes entrantes.

6. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](cs_nodeport.html) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](cs_network_policy.html#block_ingress).

<br />


## Adición de tolerancias y afinidad de nodos a los pods de app para direcciones IP de origen
{: #node_affinity_tolerations}

Cuando se envía al clúster una solicitud de cliente dirigida a la app, la solicitud se direcciona al pod del servicio equilibrador de carga que expone la app. Si no existen pods de app en el mismo nodo trabajador que el pod del servicio equilibrador de carga, el equilibrador de carga reenvía las solicitudes a un pod de app en un nodo trabajador diferente. La dirección IP de origen del paquete se cambia a la dirección IP pública del nodo trabajador donde el pod de app está en ejecución.

Para conservar la dirección IP de origen original de la solicitud del cliente, puede [habilitar la dirección IP de origen ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) para servicios de equilibrio de carga. La conexión TCP continúa hasta los pods de la app para que la app pueda ver la dirección IP de origen real del iniciador. Conservar la dirección IP del cliente es útil, por ejemplo, cuando los servidores de apps tienen que aplicar políticas de control de acceso y seguridad.

Después de habilitar la dirección IP de origen, los pods de servicio de equilibrador de carga deben reenviar las solicitudes a los pods de app que se desplieguen únicamente en el mismo nodo trabajador. Generalmente, los pods del servicio equilibrador de carga también se despliegan en los nodos trabajadores donde se despliegan los pods de app. Sin embargo, existen algunas situaciones donde los pods de equilibrador de carga y los pods de app podrían no planificarse en los mismos nodos trabajadores:

* Tiene nodos extremos antagónicos de forma que únicamente los pods de servicio equilibrador de carga se puedan desplegar en ellos. No se permite desplegar pods de app en dichos nodos.
* El clúster está conectado a varias VLAN públicas o privadas, y sus pods de app podrían desplegarse en nodos trabajadores que están conectados únicamente a una VLAN. Pods de servicio de equilibrador de carga podrían no desplegarse en dichos nodos trabajadores porque la dirección de IP del equilibrador de carga estuviese conectado a VLAN distintas de las de los nodos trabajadores.

Para forzar el despliegue de una app en los nodos trabajadores específicos en los que también se puedan desplegar los pods de servicio de equilibrador de carga, debe añadir tolerancias y reglas de afinidad al despliegue de dichas app.

### Adición de tolerancias y reglas de afinidad de nodo extremo
{: #edge_nodes}

Cuando [etiqueta nodos trabajadores como nodos extremos](cs_edge.html#edge_nodes) y también [define como antagónicos los nodos extremos](cs_edge.html#edge_workloads), los pods de servicio equilibrador de carga solo de desplegarán en aquellos nodos extremos, y los pods de app no se podrán desplegar en los nodos extremos. Cuando la dirección IP de origen está habilitada para el servicio equilibrador de carga, los pods del equilibrador de carga en los nodos extremos no podrán reenviar solicitudes entrantes a sus pods de app en otros nodos trabajadores.
{:shortdesc}

Para forzar el despliegue de pods de app en nodos extremos, añada una [regla de afinidad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) de nodo extremo y una [tolerancia ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) a su despliegue de app.

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

Tanto la sección **affinity** como la sección **tolerations** tienen `dedicated` como `key` y `edge` como `value`.

### Adición de reglas de afinidad para múltiples VLAN privadas o públicas
{: #edge_nodes_multiple_vlans}

Cuando el clúster está conectado a varias VLAN públicas o privadas, sus pods de app podrían desplegarse en nodos trabajadores que están conectados únicamente a una VLAN. Si la dirección de IP del equilibrador de carga está conectada a una VLAN diferente de la de estos nodos trabajadores, los pods de servicio de equilibrador de carga no se desplegarán en dichos nodos trabajadores.
{:shortdesc}

Cuando la dirección IP de origen esté habilitada, planifique pods de app en nodos trabajadores que estén en la misma VLAN que la dirección IP del equilibrador de carga añadiendo una regla de afinidad al despliegue de la app.

Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](cs_cli_install.html#cs_cli_configure).

1. Obtenga la dirección IP del servicio equilibrador de carga. Busque la dirección IP en el campo **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Recupere el ID de VLAN al que se conecta el servicio de equilibrador.

    1. Obtenga una lista de VLAN públicas portátiles para su clúster.
        ```
        ibmcloud ks cluster-get <cluster_name_or_ID> --showResources
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

        Por ejemplo, si la dirección IP del servicio equilibrador de carga es `169.36.5.xxx`, la subred coincidente en la salida del ejemplo del paso anterior es `169.36.5.xxx/29`. El ID de VLAN al que se conecta la subred es `2234945`.

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

    En el YAML de ejemplo, la sección **affinity** tiene `publicVLAN` como `key` y `"2234945"` como `value`.

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

        En la salida de ejemplo del paso anterior, el pod de app `cf-py-d7b7d94db-vp8pq` se encuentra en el nodo trabajador `10.176.48.78`.

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

