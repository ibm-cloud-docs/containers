---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}



# Configuración de un NLB 2.0 (beta)
{: #loadbalancer-v2}

Exponga un puerto y utilice una dirección IP portátil para que un equilibrador de carga de red (NLB) capa 4 ofrezca una app contenerizada. Para obtener más información sobre los NLB de la versión 2.0, consulte [Componentes y arquitectura de un NLB 2.0](/docs/containers?topic=containers-loadbalancer-about#planning_ipvs).
{:shortdesc}

## Requisitos previos
{: #ipvs_provision}

No puede actualizar un NLB existente de la versión 1.0 a la 2.0. Debe crear un NLB 2.0 nuevo. Tenga en cuenta que puede ejecutar NLB versión 1.0 y versión 2.0 simultáneamente en un clúster.
{: shortdesc}

Antes de crear un NLB 2.0, debe completar los pasos de requisito previo siguientes.

1. [Actualice los nodos maestro y trabajadores del clúster](/docs/containers?topic=containers-update) a Kubernetes versión 1.12 o posterior.

2. Para permitir que el NLB 2.0 pueda reenviar solicitudes a pods de app en varias zonas, abra un caso de soporte para solicitar más capacidad para sus VLAN. Este valor de configuración no causa interrupciones ni paradas en la red.
    1. Inicie una sesión en la [consola de {{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/).
    2. En la barra de menús, pulse **Soporte**, pulse el separador **Gestionar casos** y pulse **Crear un caso nuevo**.
    3. En los campos del caso, especifique lo siguiente:
       * Para el tipo de soporte, seleccione **Técnico**.
       * Para la categoría, seleccione **Distribución de VLAN**.
       * Para el asunto, escriba **Pregunta de red de VLAN pública y privada**
    4. Añada la información siguiente a la descripción: "Configurar la red para permitir la agregación de capacidad en las VLAN públicas y privadas asociadas con mi cuenta". La incidencia de referencia de esta solicitud es: https://control.softlayer.com/support/tickets/63859145". Tenga en cuenta que, si desea permitir el aumento de capacidad en determinadas VLAN, como por ejemplo las VLAN públicas solo de un clúster, puede especificar los ID de estas VLAN en la descripción.
    5. Pulse **Enviar**.

3. Habilite una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) para la cuenta de infraestructura de IBM Cloud. Para habilitar VRF, [póngase en contacto con el representante de su cuenta de la infraestructura de IBM Cloud](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Para comprobar si un VRF ya está habilitado, utilice el mandato `ibmcloud account show`. Si no puede o no desea habilitar VRF, habilite la [distribución de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Cuando hay una VRF o una distribución de VLAN habilitada, el NLB 2.0 puede direccionar paquetes a varias subredes de la cuenta.

4. Si utiliza [políticas de red pre-DNAT de Calico](/docs/containers?topic=containers-network_policies#block_ingress) para gestionar el tráfico con la dirección IP de un NLB 2.0, debe añadir los campos `applyOnForward: true` y `doNotTrack: true` y eliminar `preDNAT: true` de la sección `spec` en las políticas. `applyOnForward: true` garantiza que la política de Calico se aplica al tráfico cuando se encapsula y se reenvía. `doNotTrack: true` garantiza que los nodos trabajadores pueden utilizar DSR para devolver un paquete de respuesta directamente al cliente sin necesidad de que se realice el seguimiento de la conexión. Por ejemplo, si utiliza una política de Calico para incluir en una lista blanca el tráfico de únicamente algunas direcciones IP específicas con la dirección IP del NLB, la política tendrá un aspecto similar al siguiente:
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

A continuación, puede seguir los pasos de [Configuración de un NLB 2.0 en un clúster multizona](#ipvs_multi_zone_config) o [en un clúster de una sola zona](#ipvs_single_zone_config).

<br />


## Configuración de un NLB 2.0 en un clúster multizona
{: #ipvs_multi_zone_config}

**Antes de empezar**:

* **Importante**: complete los [requisitos previos de NLB 2.0](#ipvs_provision).
* Para crear NLB públicos en varias zonas, al menos una VLAN pública debe tener subredes portátiles disponibles en cada zona. Para crear NLB privados en varias zonas, al menos una VLAN privada debe tener subredes portátiles disponibles en cada zona. Puede añadir subredes siguiendo los pasos que se indican en [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Si restringe el tráfico de red a los nodos trabajadores de extremo, asegúrese de que haya al menos dos [nodos trabajadores de extremo](/docs/containers?topic=containers-edge#edge) habilitados en cada zona para que los NLB se desplieguen de forma uniforme.
* Asegúrese de que tiene el [rol de servicio **Escritor** o **Gestor** de {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.


Para configurar un NLB 2.0 en un clúster multizona:
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
        <td>Opcional: Para crear un NLB privado o para utilizar una dirección IP portátil específica para un NLB público, especifique la dirección IP que desea utilizar. La dirección IP debe estar en la zona y en la VLAN que especifique en las anotaciones. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está en una VLAN privada, se utiliza una dirección IP privada portátil.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Se establece en <code>Local</code>.</td>
      </tr>
      </tbody></table>

      Archivo de configuración de ejemplo para crear un servicio de NLB 2.0 en
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

  3. Opcional: Puede hacer que el servicio de NLB solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`.  `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
en el clúster a través de reglas de Iptables en los nodos trabajadores. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Cree el servicio en el clúster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifique que el servicio de NLB se haya creado correctamente. Pueden transcurrir unos minutos hasta que el servicio de NLB se cree correctamente y la app esté disponible.

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

    La dirección IP de **LoadBalancer Ingress** es la dirección IP portátil asignada al servicio de NLB.

4.  Si ha creado un NLB público, acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Especifique la dirección IP pública portátil y el puerto del NLB.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Para lograr una alta disponibilidad, repita los pasos del 2 al 4 para añadir un NLB 2.0 en cada una de las zonas donde tenga instancias de la app.

6. Opcional: un servicio de NLB también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de NLB, consulte [Control del tráfico de entrada a los servicios de equilibrador de carga de red (NLB) o de NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

A continuación, puede [registrar un nombre de host de NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Configuración de un NLB 2.0 en un clúster de una sola zona
{: #ipvs_single_zone_config}

**Antes de empezar**:

* **Importante**: complete los [requisitos previos de NLB 2.0](#ipvs_provision).
* Debe tener una dirección IP pública o privada portátil disponible para asignarla al servicio de NLB. Para obtener más información, consulte [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Asegúrese de que tiene el [rol de servicio **Escritor** o **Gestor** de {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.

Para crear un servicio de NLB 2.0 en un clúster de una sola zona:

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
          <td>Opcional: Para crear un NLB privado o para utilizar una dirección IP portátil específica para un NLB público, especifique la dirección IP que desea utilizar. La dirección IP debe estar en la VLAN que especifique en las anotaciones. Si no especifica ninguna dirección IP:<ul><li>Si el clúster está en una VLAN pública, se utiliza una dirección IP pública portátil. La mayoría de los clústeres están en una VLAN pública.</li><li>Si el clúster solo está en una VLAN privada, se utiliza una dirección IP privada portátil.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Se establece en <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Opcional: Puede hacer que el servicio de NLB solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
en el clúster a través de reglas de Iptables en los nodos trabajadores. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Cree el servicio en el clúster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Verifique que el servicio de NLB se haya creado correctamente. Pueden transcurrir unos minutos hasta que el servicio se cree correctamente y la app esté disponible.

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

    La dirección IP de **LoadBalancer Ingress** es la dirección IP portátil asignada al servicio de NLB.

4.  Si ha creado un NLB público, acceda a la app desde Internet.
    1.  Abra el navegador web preferido.
    2.  Especifique la dirección IP pública portátil y el puerto del NLB.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Opcional: un servicio de NLB también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de NLB, consulte [Control del tráfico de entrada a los servicios de equilibrador de carga de red (NLB) o de NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

A continuación, puede [registrar un nombre de host de NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Planificación de algoritmos
{: #scheduling}

Los algoritmos de planificación determinan el modo en que un NLB 2.0 asigna conexiones de red a los pods de app. A medida que llegan solicitudes de cliente al clúster, el NLB direcciona los paquetes de solicitud a los nodos trabajadores basándose en el algoritmo de planificación. Para utilizar un algoritmo de planificación, especifique su nombre abreviado de Keepalived en la anotación del planificador del archivo de configuración del servicio del NLB:
`service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. Compruebe las listas siguientes para ver qué algoritmos de planificación se admiten en {{site.data.keyword.containerlong_notm}}. Si no especifica ningún algoritmo de planificación, se utilizará el algoritmo de rotación (Round Robin) de forma predeterminada. Para obtener más información, consulte la [documentación de Keepalived ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://www.Keepalived.org/doc/scheduling_algorithms.html).
{: shortdesc}

### Algoritmos de planificación soportados
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>El NLB recorre de forma cíclica la lista de pods de app al direccionar conexiones a los nodos trabajadores, tratando cada pod de app de manera equitativa. Round Robin es el algoritmo de planificación predeterminado para los NLB versión 2.0.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>El NLB genera una clave hash basándose en la dirección IP de origen del paquete de solicitud de cliente. A continuación, el NLB busca la clave hash en una tabla hash asignada estáticamente y direcciona la solicitud al pod de app que gestiona los hashes de ese rango. Este algoritmo garantiza que las solicitudes de un cliente concreto se dirijan siempre al mismo pod de app.</br>**Nota**: Kubernetes utiliza reglas de Iptables, lo que hace que las solicitudes se envíen a un pod aleatorio en el trabajador. Para utilizar este algoritmo de planificación, debe asegurarse de que no hay más de un pod de la app desplegado por cada nodo trabajador. Por ejemplo, si cada pod tiene la etiqueta <code>run=&lt;app_name&gt;</code>, añada la regla antiafinidad siguiente a la sección <code>spec</code> del despliegue de la app:</br>
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
<dd>El destino del paquete, que es la dirección IP y el puerto del NLB, se utiliza para determinar qué nodo trabajador gestiona la solicitud de entrada. No obstante, la dirección IP y el puerto de los NLB de {{site.data.keyword.containerlong_notm}} no cambian. El NLB está obligado a mantener la solicitud dentro del mismo nodo trabajador en el que se encuentra, por lo que únicamente los pods de app de un trabajador gestionan todas las solicitudes entrantes.</dd>
<dt>Algoritmos de recuento de conexiones dinámico</dt>
<dd>Los algoritmos siguientes dependen del recuento dinámico de conexiones entre los clientes y los NLB. No obstante, debido a que el retorno directo de servicio (DSR) evita que los pods del NLB 2.0 se incluyan en la vía del paquete de retorno, los NLB no realizan el seguimiento de las conexiones establecidas.<ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Algoritmos de pod con ponderación</dt>
<dd>Los algoritmos siguientes dependen de pods de app ponderados. No obstante, en {{site.data.keyword.containerlong_notm}}, todos los pods de app tienen el mismo peso asignado para el equilibrio de carga.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>
