---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, lb2.0, nlb

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



# Exposición de apps con equilibradores de carga
{: #loadbalancer}

Exponga un puerto y utilice una dirección IP portátil para que el equilibrador de carga de capa 4 acceda a la app contenerizada.
{:shortdesc}

Los servicios del equilibrador de carga están disponibles para clústeres estándares únicamente y no admiten la terminación TLS. Si la app necesita la terminación TLS, puede exponer la app mediante [Ingress](/docs/containers?topic=containers-ingress) o puede configurar la app para que gestione la terminación TLS.
{: note}

Seleccione una de las opciones siguientes para empezar:


<img src="images/cs_loadbalancer_imagemap_1.png" usemap="#image-map-1" alt="Esta correlación de imágenes contiene enlaces rápidos con temas de configuración de esta página.">
<map name="image-map-1">
    <area target="" alt="Visión general" title="Visión general" href="#lb_overview" coords="35,44,175,72" shape="rect">
    <area target="" alt="Comparación entre equilibradores de carga de la versión 1.0 y de la versión 2.0" title="Comparación entre equilibradores de carga de la versión 1.0 y de la versión 2.0" href="#comparison" coords="34,83,173,108" shape="rect">
    <area target="" alt="v2.0: Componentes y arquitectura (Beta)" title="v2.0: Componentes y arquitectura (Beta)" href="#planning_ipvs" coords="273,45,420,72" shape="rect">
    <area target="" alt="v2.0: Requisitos previos" title="v2.0: Requisitos previos" href="#ipvs_provision" coords="277,85,417,108" shape="rect">
    <area target="" alt="v2.0: Configuración de un equilibrador de carga 2.0 en un clúster multizona" title="v2.0: Configuración de un equilibrador de carga 2.0 en un clúster multizona" href="#ipvs_multi_zone_config" coords="276,122,417,147" shape="rect">
    <area target="" alt="v2.0: Configuración de un equilibrador de carga 2.0 en un clúster de una sola zona" title="v2.0: Configuración de un equilibrador de carga 2.0 en un clúster de una sola zona" href="#ipvs_single_zone_config" coords="277,156,419,184" shape="rect">
    <area target="" alt="v2.0: Planificación de algoritmos" title="v2.0: Planificación de algoritmos" href="#scheduling" coords="276,196,419,220" shape="rect">
    <area target="" alt="v1.0: Componentes y arquitectura" title="v1.0: Componentes y arquitectura" href="#v1_planning" coords="519,47,668,74" shape="rect">
    <area target="" alt="v1.0: Configuración de un equilibrador de carga 1.0 en un clúster multizona" title="v1.0: Configuración de un equilibrador de carga 1.0 en un clúster multizona" href="#multi_zone_config" coords="520,85,667,110" shape="rect">
    <area target="" alt="v1.0: Configuración de un equilibrador de carga 1.0 en un clúster de una sola zona" title="v1.0: Configuración de un equilibrador de carga 1.0 en un clúster de una sola zona" href="#lb_config" coords="520,122,667,146" shape="rect">
    <area target="" alt="v1.0: Habilitación de la conservación de la IP de origen" title="v1.0: Habilitación de la conservación de la IP de origen" href="#node_affinity_tolerations" coords="519,157,667,194" shape="rect">
</map>


## Archivos YAML de ejemplo
{: #sample}

Revise los siguientes archivos YAML de ejemplo para comenzar a especificar rápidamente su servicio equilibrador de carga.
{: shortdesc}

**Equilibrador de carga 2.0**</br>

¿Ya cumple con los [requisitos previos para un equilibrador de carga 2.0](#ipvs_provision)? Puede utilizar el siguiente archivo YAML de despliegue para crear un equilibrador de carga 2.0:

```
apiVersion: v1
kind: Service
metadata:
  name: myloadbalancer
  annotations:
    service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
    service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
    service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
    service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
    service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
spec:
  type: LoadBalancer
  selector:
    <selector_key>: <selector_value>
  ports:
   - protocol: TCP
     port: 8080
  loadBalancerIP: <IP_address>
  externalTrafficPolicy: Local
```
{: codeblock}

**Equilibrador de carga 1.0**</br>

Utilice el siguiente archivo YAML de despliegue para crear un equilibrador de carga 1.0:

```
apiVersion: v1
kind: Service
metadata:
 name: myloadbalancer
 annotations:
   service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
   service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
   service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
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

<br />


## Visión general
{: #lb_overview}

Cuando se crea un clúster estándar, {{site.data.keyword.containerlong}} suministra automáticamente una subred pública portátil y una subred privada portátil.
{: shortdesc}

* La subred pública portable proporciona 5 direcciones IP utilizables. Una dirección IP pública portable la utiliza el [ALB de Ingress público](/docs/containers?topic=containers-ingress) predeterminado. Las 4 direcciones IP públicas portables restantes se pueden utilizar para exponer apps individuales en Internet mediante la creación de servicios públicos de equilibrador de carga.
* La subred privada portable proporciona 5 direcciones IP utilizables. Una dirección IP privada portable la utiliza el [ALB de Ingress privado](/docs/containers?topic=containers-ingress#private_ingress) predeterminado. Las 4 direcciones IP privadas portátiles restantes se pueden utilizar para exponer apps individuales en una red privada mediante la creación de servicios privados de equilibrador de carga.

Las direcciones IP públicas y privadas portátiles son IP flotantes estáticas y no cambian cuando se elimina un nodo trabajador. Si se elimina el nodo trabajador en el que se encuentra la dirección IP del equilibrador de carga, un daemon Keepalived que supervisa constantemente la IP mueve automáticamente la IP a otro nodo trabajador. Puede asignar cualquier puerto al equilibrador de carga. El servicio equilibrador de carga sirve como punto de entrada externo para las solicitudes entrantes para la app. Para acceder al servicio equilibrador de carga desde Internet, puede utilizar la dirección IP pública del equilibrador de carga y el puerto asignado en el formato `<IP_address>:<port>`.

Al exponer una app con un servicio de equilibrador de carga, la app pasa también a estar disponible automáticamente a través de los NodePorts del servicio. Los [NodePorts](/docs/containers?topic=containers-nodeport) son accesibles en cada dirección IP pública y privada de cada nodo trabajador dentro del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Comparación entre los equilibradores de carga de la versión 1.0 y de la versión 2.0
{: #comparison}

Cuando cree un equilibrador de carga, se puede elegir un equilibrador de carga de la versión 1.0 o de la versión 2.0. Tenga en cuenta que los equilibradores de carga de la versión 2.0 están en fase beta.
{: shortdesc}

**¿En qué se parecen los equilibradores de carga de la versión 1.0 y de la versión 2.0?**

Los equilibradores de carga de las versiones 1.0 y 2.0 son ambos equilibradores de carga de capa 4 que viven únicamente en el espacio del kernel de Linux. Ambas versiones se ejecutan dentro del clúster y utilizan recursos de nodos trabajadores. Por lo tanto, la capacidad disponible de los equilibradores de carga siempre está dedicada a su propio clúster. Además, ninguna de las dos versiones de equilibradores de carga finaliza la conexión. En su lugar, reenvían las conexiones a un pod de app.

**¿En qué se diferencian los equilibradores de carga de la versión 1.0 y de la versión 2.0?**

Cuando un cliente envía una solicitud a la app, el equilibrador de carga direcciona los paquetes de solicitud a la dirección IP del nodo trabajador donde existe un pod de app. Los equilibradores de carga de la versión 1.0 utilizan NAT (conversión de direcciones de red) para reescribir la dirección IP de origen del paquete de solicitud a la IP del nodo trabajador donde existe un pod de equilibrador de carga. Cuando el nodo trabajador devuelve el paquete de respuesta de app, utiliza dicha IP del nodo trabajador donde existe el equilibrador de carga. A continuación, el equilibrador de carga debe enviar el paquete de respuesta al cliente. Para evitar que se reescriba la dirección IP, puede [habilitar la conservación de IP de origen](#node_affinity_tolerations). No obstante, la conservación de IP de origen requiere que los pods de equilibrador de carga y los pods de app se ejecuten en el mismo trabajador para que la solicitud no tenga que reenviarse a otro trabajador. Debe añadir tolerancias y afinidad de nodos a los pods de app.

A diferencia de los equilibradores de carga de la versión 1.0, los equilibradores de carga de la versión 2.0 no utilizan NAT al reenviar solicitudes a pods de app en otros trabajadores. Cuando un equilibrador de carga 2.0 direcciona una solicitud de cliente, utiliza IP sobre IP (IPIP) para encapsular el paquete de solicitud original en otro paquete nuevo. Este paquete IPIP de encapsulado tiene una IP de origen del nodo trabajador donde se encuentra el pod de equilibrador de carga, lo que permite que el paquete de solicitud original pueda conservar la IP de cliente como su dirección IP de origen. A continuación, el nodo trabajador utiliza el retorno directo de servidor (DSR) para enviar el paquete de respuesta de la app a la IP de cliente. El paquete de respuesta se salta el equilibrador de carga y se envía directamente al cliente, disminuyendo la cantidad de tráfico que debe gestionar el equilibrador de carga.

<br />


## v2.0: Componentes y arquitectura (beta)
{: #planning_ipvs}

Las prestaciones del Equilibrador de carga 2.0 están en fase beta. Para utilizar un equilibrador de carga de la versión 2.0, debe
[actualizar los nodos maestro y trabajadores del clúster](/docs/containers?topic=containers-update) a Kubernetes versión 1.12 o posterior.
{: note}

El equilibrador de carga 2.0 es un equilibrador de carga de capa 4 que utiliza el servidor virtual IP (IPVS) del kernel de Linux. El equilibrador de carga 2.0 tiene soporte para TCP y UDP, se ejecuta delante de varios nodos trabajadores y utiliza el tunelado de IP sobre IP (IPIP) para distribuir el tráfico que llega a una dirección IP individual del equilibrador de carga en dichos nodos trabajadores.

¿Desea obtener más información sobre los patrones de despliegue de equilibrio de carga que están disponibles en {{site.data.keyword.containerlong_notm}}? Consulte esta [publicación del blog ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/).
{: tip}

### Flujo del tráfico en un clúster de una sola zona
{: #ipvs_single}

En el siguiente diagrama se muestra cómo un equilibrador de carga 2.0 dirige la comunicación procedente de internet a una app en un clúster de una sola zona.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="Exposición de una app en {{site.data.keyword.containerlong_notm}} con un equilibrador de carga versión 2.0" style="width:600px; border-style: none"/>

1. Una solicitud de cliente enviada a la app utiliza la dirección IP pública del equilibrador de carga y el puerto asignado en el nodo trabajador. En este ejemplo, el equilibrador de carga tiene una dirección IP virtual de 169.61.23.130, que se encuentra actualmente en el trabajador 10.73.14.25.

2. El equilibrador de carga encapsula el paquete de solicitud de cliente (etiquetado como "CR" en la imagen) dentro de un paquete IPIP (etiquetado como "IPIP"). El paquete de solicitud de cliente mantiene la IP de cliente como su dirección IP de origen. El paquete de encapsulado IPIP utiliza la IP 10.73.14.25 del trabajador como su dirección IP de origen.

3. El equilibrador de carga direcciona el paquete IPIP a un trabajador en el que se encuentre un pod de app, 10.73.14.26. Si se despliegan varias instancias de app en el clúster, el equilibrador de carga direcciona las solicitudes entre los trabajadores donde se hayan desplegado pods de app.

4. El trabajador 10.73.14.26 desempaqueta el paquete de encapsulado IPIP y, a continuación, desempaqueta el paquete de solicitud de cliente. El paquete de solicitud de cliente se reenvía al pod de app en ese nodo trabajador.

5. A continuación, el trabajador 10.73.14.26 utiliza la dirección IP de origen del paquete de solicitud original, la IP de cliente, para devolver el paquete de respuesta del pod de app directamente al cliente.

### Flujo del tráfico en un clúster multizona
{: #ipvs_multi}

El flujo de tráfico a través de un clúster multizona sigue el mismo camino que el
[tráfico a través de un clúster de una sola zona](#ipvs_single). En un clúster multizona, el equilibrador de carga direcciona las solicitudes a las instancias de la app en su propia zona y a las instancias de la app en otras zonas. El diagrama siguiente muestra cómo los equilibradores de carga de la versión 2.0 de cada zona dirigen el tráfico de Internet a una app en un clúster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Exponer una app en {{site.data.keyword.containerlong_notm}} mediante un equilibrador de carga 2.0" style="width:500px; border-style: none"/>

De forma predeterminada, cada equilibrador de carga de la versión 2.0 se configura solo en una zona. Puede conseguir una mayor disponibilidad desplegando un equilibrador de carga de la versión 2.0 en cada zona en la que tenga instancias de app.

<br />


## v2.0: Requisitos previos
{: #ipvs_provision}

No puede actualizar un equilibrador de carga existente de la versión 1.0 a la 2.0. Debe crear un nuevo equilibrador de carga de la versión 2.0. Tenga en cuenta que puede ejecutar equilibradores de carga de la versión 1.0 y de la versión 2.0 simultáneamente en un clúster.
{: shortdesc}

Antes de crear un equilibrador de carga de la versión 2.0, debe realizar los pasos de requisito previo siguientes.

1. [Actualice los nodos maestro y trabajadores del clúster](/docs/containers?topic=containers-update) a Kubernetes versión 1.12 o posterior.

2. Para permitir que el equilibrador de carga 2.0 pueda reenviar solicitudes a pods de app en varias zonas, abra un caso de soporte para solicitar un valor de configuración para las VLAN. **Importante**: debe solicitar esta configuración para todas las VLAN públicas. Si solicita una nueva VLAN asociada, debe abrir otra incidencia para dicha VLAN.
    1. Inicie una sesión en la [consola de {{site.data.keyword.Bluemix_notm}}](https://cloud.ibm.com/).
    2. En la barra de menús, pulse **Soporte**, pulse el separador **Gestionar casos** y pulse **Crear un caso nuevo**.
    3. En los campos del caso, especifique lo siguiente:
       * Para el tipo de soporte, seleccione **Técnico**.
       * Para la categoría, seleccione **Distribución de VLAN**.
       * Para el asunto, especifique **Pregunta de red de VLAN pública.**
    4. Añada la información siguiente a la descripción: "Configurar la red para permitir la agregación de capacidad en las VLAN públicas asociadas con mi cuenta". La incidencia de referencia de esta solicitud es: https://control.softlayer.com/support/tickets/63859145".
    5. Pulse **Enviar**.

3. Si la expansión de VLAN está inhabilitada, habilite la
[expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) para su cuenta de infraestructura de IBM Cloud (SoftLayer). Cuando se habilita la expansión de VLAN, el equilibrador de carga de la versión 2.0 puede direccionar paquetes a varias subredes de la cuenta. Puede ver si la expansión de VLAN está habilitada con el mandato `ibmcloud ks vlan-spanning-get`.

4. Si utiliza [políticas de red pre-DNAT de Calico](/docs/containers?topic=containers-network_policies#block_ingress) para gestionar el tráfico con la dirección IP de un equilibrador de carga de la versión 2.0, debe añadir los campos `applyOnForward: true` y `doNotTrack: true` y eliminar `preDNAT: true` de la sección `spec` en las políticas. `applyOnForward: true` garantiza que la política de Calico se aplica al tráfico cuando se encapsula y se reenvía. `doNotTrack: true` garantiza que los nodos trabajadores pueden utilizar DSR para devolver un paquete de respuesta directamente al cliente sin necesidad de que se realice el seguimiento de la conexión. Por ejemplo, si utiliza una política de Calico para incluir en una lista blanca el tráfico de únicamente algunas direcciones IP específicas con la dirección IP del equilibrador de carga, la política tendrá un aspecto similar al siguiente:
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

A continuación, puede seguir los pasos de [Configuración de un equilibrador de carga 2.0 en un clúster multizona](#ipvs_multi_zone_config) o [en un clúster de una sola zona](#ipvs_single_zone_config).

<br />


## v2.0: Configuración de un equilibrador de carga 2.0 en un clúster multizona
{: #ipvs_multi_zone_config}

**Antes de empezar**:

* **Importante**: complete los [requisitos previos del equilibrador de carga 2.0](#ipvs_provision).
* Para crear equilibradores de carga públicos en varias zonas, al menos una VLAN pública debe tener subredes portátiles disponibles en cada zona. Para crear equilibradores de carga privados en varias zonas, al menos una VLAN privada debe tener subredes portátiles disponibles en cada zona. Puede añadir subredes siguiendo los pasos que se indican en [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Si restringe el tráfico de red a los nodos trabajadores de extremo, asegúrese de que haya al menos 2 [nodos trabajadores de extremo](/docs/containers?topic=containers-edge#edge) habilitados en cada zona para que los equilibradores de carga se desplieguen de forma uniforme.
* Asegúrese de que tiene el [rol de **Escritor** o de **Gestor** del servicio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.


Para configurar un equilibrador de carga 2.0 en un clúster multizona:
1.  [Despliegue la app en el clúster](/docs/containers?topic=containers-app#app_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.

2.  Cree un servicio equilibrador de carga para la app que desea exponer en internet público o en una red privada.
  1. Cree un archivo de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.
  2. Defina un servicio equilibrador de carga para la app que desee exponer. Puede especificar una zona, una VLAN y una dirección IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
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
        <td>Anotación para especificar un equilibrador de carga <code>privado</code> o <code>público</code>.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Anotación para especificar la zona en la que se despliega el servicio de equilibrador de carga. Para ver las zonas, ejecute <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Anotación para especificar una VLAN en la que se despliega el servicio de equilibrador de carga. Para ver las VLAN, ejecute <code>ibmcloud ks --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>Anotación para especificar un equilibrador de carga de la versión 2.0.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>Opcional: Anotación para especificar el algoritmo de planificación. Los valores aceptados son <code>"rr"</code> para Round Robin (valor predeterminado) o <code>"sh"</code> para Source Hashing. Para obtener más información, consulte [2.0: Planificación de algoritmos](#scheduling).</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>La clave de etiqueta (<em>&lt;selector_key&gt;</em>) y el valor (<em>&lt;selector_value&gt;</em>) que ha utilizado en la sección <code>spec.template.metadata.labels</code> del archivo YAML de despliegue de apps.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>El puerto que en el que está a la escucha el servicio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Opcional: Para crear un equilibrador de carga privado o para utilizar una dirección IP portátil específica para un equilibrador de carga público, especifique la dirección IP que desea utilizar. La dirección IP debe estar en la zona y en la VLAN que especifique en las anotaciones. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está en una VLAN privada, se utiliza una dirección IP privada portátil.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Se establece en <code>Local</code>.</td>
      </tr>
      </tbody></table>

      Archivo de configuración de ejemplo para crear un servicio de equilibrador de carga 2.0 en
`dal12` que utiliza el algoritmo de planificación Round Robin:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. Opcional: Haga que el servicio de equilibrador de carga solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`.  `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
en el clúster a través de reglas de Iptables en los nodos trabajadores. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Cree el servicio en el clúster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifique que el servicio equilibrador de carga se haya creado correctamente. Pueden transcurrir unos minutos hasta que el servicio equilibrador de carga se cree correctamente y la app esté disponible.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

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

5. Para lograr una alta disponibilidad, repita los pasos del 2 al 4 para añadir un equilibrador de carga 2.0 en cada zona en la que tenga instancias de la app.

6. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).



## v2.0: Configuración de un equilibrador de carga 2.0 en un clúster de una sola zona
{: #ipvs_single_zone_config}

**Antes de empezar**:

* **Importante**: complete los [requisitos previos del equilibrador de carga 2.0](#ipvs_provision).
* Debe tener una dirección IP pública o privada portátil disponible para asignarla al servicio equilibrador de carga. Para obtener más información, consulte [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Asegúrese de que tiene el [rol de **Escritor** o de **Gestor** del servicio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.

Para crear un servicio de equilibrador de carga 2.0 en un clúster de una sola zona:

1.  [Despliegue la app en el clúster](/docs/containers?topic=containers-app#app_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.
2.  Cree un servicio equilibrador de carga para la app que desea exponer en internet público o en una red privada.
    1.  Cree un archivo de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.

    2.  Defina un servicio de equilibrador de carga 2.0 para la app que desee exponer.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
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
          <td>Anotación para especificar un equilibrador de carga <code>privado</code> o <code>público</code>.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Opcional: Anotación para especificar una VLAN en la que se despliega el servicio de equilibrador de carga. Para ver las VLAN, ejecute <code>ibmcloud ks --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>Anotación para especificar un equilibrador de carga 2.0.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>Opcional: anotación para especificar un algoritmo de planificación. Los valores aceptados son <code>"rr"</code> para Round Robin (valor predeterminado) o <code>"sh"</code> para Source Hashing. Para obtener más información, consulte [2.0: Planificación de algoritmos](#scheduling).</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>La clave de etiqueta (<em>&lt;selector_key&gt;</em>) y el valor (<em>&lt;selector_value&gt;</em>) que ha utilizado en la sección <code>spec.template.metadata.labels</code> del archivo YAML de despliegue de apps.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>El puerto que en el que está a la escucha el servicio.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Opcional: Para crear un equilibrador de carga privado o para utilizar una dirección IP portátil específica para un equilibrador de carga público, especifique la dirección IP que desea utilizar. La dirección IP debe estar en la VLAN que especifique en las anotaciones. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está en una VLAN privada, se utiliza una dirección IP privada portátil.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Se establece en <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Opcional: Haga que el servicio de equilibrador de carga solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
en el clúster a través de reglas de Iptables en los nodos trabajadores. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Verifique que el servicio equilibrador de carga se haya creado correctamente. Pueden transcurrir unos minutos hasta que el servicio se cree correctamente y la app esté disponible.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

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

5. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).



<br />


## v2.0: Algoritmos de planificación
{: #scheduling}

Los algoritmos de planificación determinan el modo en que un equilibrador de carga de la versión 2.0 asigna conexiones de red a los pods de app. A medida que llegan solicitudes de cliente al clúster, el equilibrador de carga direcciona los paquetes de solicitud a los nodos trabajadores basándose en el algoritmo de planificación. Para utilizar un algoritmo de planificación, especifique su nombre abreviado de Keepalived en la anotación del planificador del archivo de configuración del servicio del equilibrador de carga:
`service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. Compruebe las listas siguientes para ver qué algoritmos de planificación se admiten en {{site.data.keyword.containerlong_notm}}. Si no especifica ningún algoritmo de planificación, se utilizará el algoritmo de rotación (Round Robin) de forma predeterminada. Para obtener más información, consulte la [documentación de Keepalived ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://www.Keepalived.org/doc/scheduling_algorithms.html).
{: shortdesc}

### Algoritmos de planificación soportados
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>El equilibrador de carga recorre la lista de pods de app al direccionar conexiones a los nodos trabajadores, tratando cada pod de app de manera equitativa. Round Robin es el algoritmo de planificación predeterminado para los equilibradores de carga de la versión 2.0.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>El equilibrador de carga genera una clave hash basándose en la dirección IP de origen del paquete de solicitud de cliente. A continuación, el equilibrador de carga busca la clave hash en una tabla hash asignada estáticamente y direcciona la solicitud al pod de app que gestiona los hashes de ese rango. Este algoritmo garantiza que las solicitudes de un cliente concreto se dirijan siempre al mismo pod de app.</br>**Nota**: Kubernetes utiliza reglas de Iptables, lo que hace que las solicitudes se envíen a un pod aleatorio en el trabajador. Para utilizar este algoritmo de planificación, debe asegurarse de que no hay más de un pod de la app desplegado por cada nodo trabajador. Por ejemplo, si cada pod tiene la etiqueta <code>run=&lt;app_name&gt;</code>, añada la regla antiafinidad siguiente a la sección <code>spec</code> del despliegue de la app:</br>
<pre class="codeblock">
<code>
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

Puede encontrar el ejemplo completo en
[este blog de patrones de despliegue de IBM Cloud ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/).</dd>
</dl>

### Algoritmos de planificación sin soporte
{: #scheduling_unsupported}

<dl>
<dt>Destination Hashing (<code>dh</code>)</dt>
<dd>El destino del paquete, que es la dirección IP y el puerto del equilibrador de carga, se utiliza para determinar qué nodo trabajador gestiona la solicitud de entrada. No obstante, la dirección IP y el puerto de los equilibradores de carga de {{site.data.keyword.containerlong_notm}} no cambian. El equilibrador de carga está obligado a mantener la solicitud dentro del mismo nodo trabajador en el que se encuentra, por lo que únicamente los pods de app de un trabajador gestionan todas las solicitudes entrantes.</dd>
<dt>Algoritmos de recuento de conexiones dinámico</dt>
<dd>Los algoritmos siguientes dependen del recuento dinámico de conexiones entre clientes y equilibradores de carga. No obstante, debido a que el retorno directo de servicio (DSR) evita que los pods del equilibrador de carga 2.0 se incluyan en la vía del paquete de retorno, los equilibradores de carga no realizan el seguimiento de las conexiones establecidas.<ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Algoritmos de pod con ponderación</dt>
<dd>Los algoritmos siguientes dependen de pods de app ponderados. No obstante, en {{site.data.keyword.containerlong_notm}}, todos los pods de app tienen el mismo peso asignado para el equilibrio de carga.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>

<br />


## v1.0: Componentes y arquitectura
{: #v1_planning}

El equilibrador de carga 1.0 de TCP/UDP utiliza Iptables, una característica del kernel de Linux, para equilibrar la carga de las solicitudes en los pods de una app.
{: shortdesc}

### Flujo del tráfico en un clúster de una sola zona
{: #v1_single}

En el siguiente diagrama se muestra cómo un equilibrador de carga 1.0 dirige la comunicación procedente de internet a una app en un clúster de una sola zona.
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="Exposición de una app en {{site.data.keyword.containerlong_notm}} mediante un equilibrador de carga 1.0" style="width:410px; border-style: none"/>

1. Una solicitud enviada a la app utiliza la dirección IP pública del equilibrador de carga y el puerto asignado en el nodo trabajador.

2. La solicitud se reenvía automáticamente al puerto y a la dirección IP del clúster interno del servicio equilibrador de carga. Solo se puede acceder a la dirección IP del clúster interno dentro del clúster.

3. `kube-proxy` direcciona la solicitud al servicio equilibrador de carga de Kubernetes para la app.

4. La solicitud se reenvía a la dirección IP privada del pod de la app. La dirección IP de origen del paquete de la solicitud se cambia por la dirección IP pública del nodo trabajador en el que se ejecuta el pod de la app. Si se despliegan varias instancias de app en el clúster, el equilibrador de carga direcciona las solicitudes entre los pods de app.

### Flujo del tráfico en un clúster multizona
{: #v1_multi}

En el siguiente diagrama se muestra cómo un equilibrador de carga 1.0 dirige la comunicación procedente de internet a una app en un clúster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Uso de un equilibrador de carga 1.0 para equilibrar la carga de las apps en clústeres multizona" style="width:500px; border-style: none"/>

De forma predeterminada, cada equilibrador de carga 1.0 se configura solo en una zona. Para conseguir una alta disponibilidad, debe desplegar un equilibrador de carga 1.0 en cada zona en la que tenga instancias de la app. Los equilibradores de carga de las distintas zonas gestionan las solicitudes en un ciclo en rueda. Además, cada equilibrador de carga direcciona las solicitudes a las instancias de la app en su propia zona y a las instancias de la app en otras zonas.

<br />


## v1.0: Configuración de un equilibrador de carga 1.0 en un clúster multizona
{: #multi_zone_config}

**Antes de empezar**:
* Para crear equilibradores de carga públicos en varias zonas, al menos una VLAN pública debe tener subredes portátiles disponibles en cada zona. Para crear equilibradores de carga privados en varias zonas, al menos una VLAN privada debe tener subredes portátiles disponibles en cada zona. Puede añadir subredes siguiendo los pasos que se indican en [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Si restringe el tráfico de red a los nodos trabajadores de extremo, asegúrese de que haya al menos 2 [nodos trabajadores de extremo](/docs/containers?topic=containers-edge#edge) habilitados en cada zona para que los equilibradores de carga se desplieguen de forma uniforme.
* Habilite la [expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](/docs/containers?topic=containers-users#infra_access) **Red > Gestionar expansión de VLAN de red** o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
* Asegúrese de que tiene el [rol de **Escritor** o de **Gestor** del servicio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.


Para configurar un servicio equilibrador de carga 1.0 en un clúster multizona:
1.  [Despliegue la app en el clúster](/docs/containers?topic=containers-app#app_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.

2.  Cree un servicio equilibrador de carga para la app que desea exponer en internet público o en una red privada.
  1. Cree un archivo de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.
  2. Defina un servicio equilibrador de carga para la app que desee exponer. Puede especificar una zona, una VLAN y una dirección IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
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
        <td>Anotación para especificar un equilibrador de carga <code>privado</code> o <code>público</code>.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Anotación para especificar la zona en la que se despliega el servicio de equilibrador de carga. Para ver las zonas, ejecute <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Anotación para especificar una VLAN en la que se despliega el servicio de equilibrador de carga. Para ver las VLAN, ejecute <code>ibmcloud ks --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>La clave de etiqueta (<em>&lt;selector_key&gt;</em>) y el valor (<em>&lt;selector_value&gt;</em>) que ha utilizado en la sección <code>spec.template.metadata.labels</code> del archivo YAML de despliegue de apps.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>El puerto que en el que está a la escucha el servicio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Opcional: Para crear un equilibrador de carga privado o para utilizar una dirección IP portátil específica para un equilibrador de carga público, especifique la dirección IP que desea utilizar. La dirección IP debe estar en la VLAN y en la zona que especifique en las anotaciones. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está en una VLAN privada, se utiliza una dirección IP privada portátil.</li></ul></td>
      </tr>
      </tbody></table>

      Archivo de configuración de ejemplo para crear un servicio equilibrador de carga 1.0 privado que utiliza una dirección IP especificada en la VLAN privada `2234945` en `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
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

  3. Opcional: Haga que el servicio de equilibrador de carga solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
en el clúster a través de reglas de Iptables en los nodos trabajadores. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Cree el servicio en el clúster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifique que el servicio equilibrador de carga se haya creado correctamente. Pueden transcurrir unos minutos hasta que el servicio se cree correctamente y la app esté disponible.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

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

5. Repita los pasos del 2 al 4 para añadir un equilibrador de carga 1.0 en cada zona.    

6. Si elige [habilitar la conservación de IP de origen para un servicio de equilibrador de carga de la versión 1.0](#node_affinity_tolerations), asegúrese de que los pods de app estén planificados en los nodos trabajadores de extremo mediante la [adición de afinidad de nodo de extremo a los pods de app](#edge_nodes). Los pods de app se deben planificar en los nodos de extremo para recibir solicitudes entrantes.

7. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).



## v1.0: Configuración de un equilibrador de carga 1.0 en un clúster de una sola zona
{: #lb_config}

**Antes de empezar**:
* Debe tener una dirección IP pública o privada portátil disponible para asignarla al servicio equilibrador de carga. Para obtener más información, consulte [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Asegúrese de que tiene el [rol de **Escritor** o de **Gestor** del servicio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.

Para crear un servicio de equilibrador de carga 1.0 en un clúster de una sola zona:

1.  [Despliegue la app en el clúster](/docs/containers?topic=containers-app#app_cli). Asegúrese de añadir una etiqueta a su despliegue en la sección de metadatos del archivo de configuración. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.
2.  Cree un servicio equilibrador de carga para la app que desea exponer en internet público o en una red privada.
    1.  Cree un archivo de configuración de servicio llamado, por ejemplo, `myloadbalancer.yaml`.

    2.  Defina un servicio equilibrador de carga para la app que desee exponer.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
           port: 8080
        loadBalancerIP: <IP_address>
        externalTrafficPolicy: Local
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
          <td>Anotación para especificar un equilibrador de carga <code>privado</code> o <code>público</code>.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Anotación para especificar una VLAN en la que se despliega el servicio de equilibrador de carga. Para ver las VLAN, ejecute <code>ibmcloud ks --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>La clave de etiqueta (<em>&lt;selector_key&gt;</em>) y el valor (<em>&lt;selector_value&gt;</em>) que ha utilizado en la sección <code>spec.template.metadata.labels</code> del archivo YAML de despliegue de apps.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>El puerto que en el que está a la escucha el servicio.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Opcional: Para crear un equilibrador de carga privado o para utilizar una dirección IP portátil específica para un equilibrador de carga público, especifique la dirección IP que desea utilizar. La dirección IP debe estar en la VLAN que especifique en las anotaciones. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está en una VLAN privada, se utiliza una dirección IP privada portátil.</li></ul></td>
        </tr>
        </tbody></table>

        Archivo de configuración de ejemplo para crear un servicio equilibrador de carga 1.0 privado que utiliza una dirección IP especificada en la VLAN privada `2234945`:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
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

    3. Opcional: Haga que el servicio de equilibrador de carga solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
en el clúster a través de reglas de Iptables en los nodos trabajadores. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Verifique que el servicio equilibrador de carga se haya creado correctamente. Pueden transcurrir unos minutos hasta que el servicio se cree correctamente y la app esté disponible.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

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

5. Si elige [habilitar la conservación de IP de origen para un servicio de equilibrador de carga de la versión 1.0](#node_affinity_tolerations), asegúrese de que los pods de app estén planificados en los nodos trabajadores de extremo mediante la [adición de afinidad de nodo de extremo a los pods de app](#edge_nodes). Los pods de app se deben planificar en los nodos de extremo para recibir solicitudes entrantes.

6. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de equilibrador de carga, consulte [Control del tráfico de entrada a los servicios equilibrador de carga o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).



<br />


## v1.0: Habilitación de la conservación de IP de origen
{: #node_affinity_tolerations}

Esta característica es para los equilibradores de carga de la versión 1.0 únicamente. La dirección IP de origen de las solicitudes de cliente se conserva de forma predeterminada en los equilibradores de carga de la versión 2.0.
{: note}

Cuando se envía al clúster una solicitud de cliente para la app, un pod del servicio de equilibrador de carga recibe la solicitud. Si no existen pods de app en el mismo nodo trabajador que el pod del servicio equilibrador de carga, el equilibrador de carga reenvía las solicitudes a un pod de app en un nodo trabajador diferente. La dirección IP de origen del paquete se cambia a la dirección IP pública del nodo trabajador donde el servicio equilibrador de carga está en ejecución.
{: shortdesc}

Para conservar la dirección IP de origen original de la solicitud del cliente, puede [habilitar la dirección IP de origen ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) para servicios de equilibrio de carga. La conexión TCP continúa hasta los pods de la app para que la app pueda ver la dirección IP de origen real del iniciador. Conservar la dirección IP del cliente es útil, por ejemplo, cuando los servidores de apps tienen que aplicar políticas de control de acceso y seguridad.

Después de habilitar la dirección IP de origen, los pods de servicio de equilibrador de carga deben reenviar las solicitudes a los pods de app que se desplieguen únicamente en el mismo nodo trabajador. Generalmente, los pods del servicio equilibrador de carga también se despliegan en los nodos trabajadores donde se despliegan los pods de app. Sin embargo, existen algunas situaciones donde los pods de equilibrador de carga y los pods de app podrían no planificarse en los mismos nodos trabajadores:

* Tiene nodos extremos antagónicos de forma que únicamente los pods de servicio equilibrador de carga se puedan desplegar en ellos. No se permite desplegar pods de app en dichos nodos.
* El clúster está conectado a varias VLAN públicas o privadas, y sus pods de app podrían desplegarse en nodos trabajadores que están conectados únicamente a una VLAN. Pods de servicio de equilibrador de carga podrían no desplegarse en dichos nodos trabajadores porque la dirección de IP del equilibrador de carga estuviese conectado a VLAN distintas de las de los nodos trabajadores.

Para forzar el despliegue de una app en los nodos trabajadores específicos en los que también se puedan desplegar los pods de servicio de equilibrador de carga, debe añadir tolerancias y reglas de afinidad al despliegue de dichas app.

### Adición de tolerancias y reglas de afinidad de nodo extremo
{: #edge_nodes}

Cuando [etiqueta nodos trabajadores como nodos extremos](/docs/containers?topic=containers-edge#edge_nodes) y también [define como antagónicos los nodos extremos](/docs/containers?topic=containers-edge#edge_workloads), los pods de servicio equilibrador de carga solo de desplegarán en aquellos nodos extremos, y los pods de app no se podrán desplegar en los nodos extremos. Cuando la dirección IP de origen está habilitada para el servicio equilibrador de carga, los pods del equilibrador de carga en los nodos extremos no podrán reenviar solicitudes entrantes a sus pods de app en otros nodos trabajadores.
{:shortdesc}

Para forzar el despliegue de pods de app en nodos extremos, añada una [regla de afinidad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) de nodo extremo y una [tolerancia ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) a su despliegue de app.

Ejemplo de YAML de despliegue con afinidad y tolerancia de nodo extremo:

```
apiVersion: apps/v1
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

Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1. Obtenga la dirección IP del servicio equilibrador de carga. Busque la dirección IP en el campo **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Recupere el ID de VLAN al que se conecta el servicio de equilibrador.

    1. Obtenga una lista de VLAN públicas portátiles para su clúster.
        ```
        ibmcloud ks cluster-get --cluster <cluster_name_or_ID> --showResources
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
    apiVersion: apps/v1
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

    1. Obtenga una lista de pods en el clúster. Sustituya `<selector>` por la etiqueta que utilizó para la app.
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


