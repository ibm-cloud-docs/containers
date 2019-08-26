---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb1.0, nlb

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


# Configuración de un NLB 1.0
{: #loadbalancer}

Exponga un puerto y utilice una dirección IP portátil para que un equilibrador de carga de red (NLB) capa 4 ofrezca una app contenerizada. Para obtener información sobre los NLB de la versión 1.0, consulte [Componentes y arquitectura de un NLB 1.0](/docs/containers?topic=containers-loadbalancer-about#v1_planning).
{:shortdesc}

Para empezar rápidamente, puede ejecutar el mandato siguiente para crear un equilibrador de carga 1.0:
```
kubectl expose deploy my-app --port=80 --target-port=8080 --type=LoadBalancer --name my-lb-svc
```
{: pre}

## Configuración de un NLB 1.0 en un clúster multizona
{: #multi_zone_config}

**Antes de empezar**:
* Para crear equilibradores de carga de red (NLB) públicos en varias zonas, al menos una VLAN pública debe tener subredes portátiles disponibles en cada zona. Para crear NLB privados en varias zonas, al menos una VLAN privada debe tener subredes portátiles disponibles en cada zona. Puede añadir subredes siguiendo los pasos que se indican en [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Si restringe el tráfico de red a los nodos trabajadores de extremo, asegúrese de que haya al menos 2 [nodos trabajadores de extremo](/docs/containers?topic=containers-edge#edge) habilitados en cada zona para que los NLB se desplieguen de forma uniforme.
* Habilite la [expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) para la cuenta de infraestructura de IBM Cloud para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](/docs/containers?topic=containers-users#infra_access) **Red > Gestionar distribución de VLAN de red** o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la distribución de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
* Asegúrese de que tiene el [rol de servicio **Escritor** o **Gestor** de {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.


Para configurar un servicio de NLB 1.0 en un clúster multizona:
1.  [Despliegue la app en el clúster](/docs/containers?topic=containers-app#app_cli). Asegúrese de añadir una etiqueta en la sección de metadatos del archivo de configuración de despliegue. Esta etiqueta es necesaria para identificar todos los pods en los que se está ejecutando la app, de modo que puedan incluirse en el equilibrio de carga.

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

      Archivo de configuración de ejemplo para crear un servicio de NLB privado 1.0 que utiliza una dirección IP especificada en la VLAN privada `2234945` en `dal12`:

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

  3. Opcional: Puede hacer que el servicio de NLB solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
en el clúster a través de reglas de Iptables en los nodos trabajadores. Para obtener más información, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Cree el servicio en el clúster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifique que el servicio de NLB se haya creado correctamente. Pueden transcurrir unos minutos hasta que el servicio se cree correctamente y la app esté disponible.

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

5. Repita los pasos del 2 al 4 para añadir un NLB de la versión 1.0 en cada zona.    

6. Si elige [habilitar la conservación de IP de origen para un NLB 1.0](#node_affinity_tolerations), asegúrese de que los pods de app estén planificados en los nodos trabajadores de extremo mediante la [adición de afinidad de nodo de extremo a los pods de app](#lb_edge_nodes). Los pods de app se deben planificar en los nodos de extremo para recibir solicitudes entrantes.

7. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de NLB, consulte [Control del tráfico de entrada a los servicios de equilibrador de carga de red (NLB) o de NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

A continuación, puede [registrar un nombre de host de NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Configuración de un NLB 1.0 en un clúster de zona única
{: #lb_config}

**Antes de empezar**:
* Debe tener una dirección IP pública o privada portátil disponible para asignarla al servicio equilibrador de carga de red (NLB). Para obtener más información, consulte [Configuración de subredes para clústeres](/docs/containers?topic=containers-subnets).
* Asegúrese de que tiene el [rol de servicio **Escritor** o **Gestor** de {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres `default`.

Para crear un servicio de NLB 1.0 en un clúster de una sola zona:

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

        Archivo de configuración de ejemplo para crear un servicio de NLB 1.0 privado que utiliza una dirección IP especificada en la VLAN privada `2234945`:

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

    3. Opcional: Puede hacer que el servicio de NLB solo esté disponible para un rango limitado de direcciones IP especificando las IP en el campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` se implementa mediante `kube-proxy`
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

5. Si elige [habilitar la conservación de IP de origen para un NLB 1.0](#node_affinity_tolerations), asegúrese de que los pods de app estén planificados en los nodos trabajadores de extremo mediante la [adición de afinidad de nodo de extremo a los pods de app](#lb_edge_nodes). Los pods de app se deben planificar en los nodos de extremo para recibir solicitudes entrantes.

6. Opcional: un servicio de equilibrador de carga también hace que la app esté disponible a través de los NodePorts del servicio. Se puede acceder a los [NodePorts](/docs/containers?topic=containers-nodeport) en cada dirección IP pública o privada de cada nodo del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un servicio de NLB, consulte [Control del tráfico de entrada a los servicios de equilibrador de carga de red (NLB) o de NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

A continuación, puede [registrar un nombre de host de NLB](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname).

<br />


## Habilitación de la conservación de IP de origen
{: #node_affinity_tolerations}

Esta característica es únicamente para los equilibradores de carga de red (NLB) de la versión 1.0. La dirección IP de origen de las solicitudes de cliente se conserva de forma predeterminada en los NLB versión 2.0.
{: note}

Cuando se envía al clúster una solicitud de cliente para la app, un pod del servicio de equilibrador de carga recibe la solicitud. Si no existen pods de app en el mismo nodo trabajador que el pod del servicio equilibrador de carga, el NLB reenvía las solicitudes a un pod de app en un nodo trabajador diferente. La dirección IP de origen del paquete se cambia a la dirección IP pública del nodo trabajador donde el servicio equilibrador de carga está en ejecución.
{: shortdesc}

Para conservar la dirección IP de origen original de la solicitud del cliente, puede [habilitar la dirección IP de origen ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) para servicios de equilibrio de carga. La conexión TCP continúa hasta los pods de la app para que la app pueda ver la dirección IP de origen real del iniciador. Conservar la dirección IP del cliente es útil, por ejemplo, cuando los servidores de apps tienen que aplicar políticas de control de acceso y seguridad.

Después de habilitar la dirección IP de origen, los pods de servicio de equilibrador de carga deben reenviar las solicitudes a los pods de app que se desplieguen únicamente en el mismo nodo trabajador. Generalmente, los pods del servicio equilibrador de carga también se despliegan en los nodos trabajadores donde se despliegan los pods de app. Sin embargo, existen algunas situaciones donde los pods de equilibrador de carga y los pods de app podrían no planificarse en los mismos nodos trabajadores:

* Tiene nodos extremos antagónicos de forma que únicamente los pods de servicio equilibrador de carga se puedan desplegar en ellos. No se permite desplegar pods de app en dichos nodos.
* El clúster está conectado a varias VLAN públicas o privadas, y sus pods de app podrían desplegarse en nodos trabajadores que están conectados únicamente a una VLAN. Pods de servicio de equilibrador de carga podrían no desplegarse en dichos nodos trabajadores porque la dirección de IP del NLB estuviese conectado a VLAN distintas de las de los nodos trabajadores.

Para forzar el despliegue de una app en los nodos trabajadores específicos en los que también se puedan desplegar los pods de servicio de equilibrador de carga, debe añadir tolerancias y reglas de afinidad al despliegue de dichas app.

### Adición de tolerancias y reglas de afinidad de nodo extremo
{: #lb_edge_nodes}

Cuando [etiqueta nodos trabajadores como nodos extremos](/docs/containers?topic=containers-edge#edge_nodes) y también [define como antagónicos los nodos extremos](/docs/containers?topic=containers-edge#edge_workloads), los pods de servicio equilibrador de carga solo de desplegarán en aquellos nodos extremos, y los pods de app no se podrán desplegar en los nodos extremos. Cuando la dirección IP de origen está habilitada para el servicio de NLB, los pods del equilibrador de carga en los nodos extremos no podrán reenviar solicitudes entrantes a sus pods de app en otros nodos trabajadores.
{:shortdesc}

Para forzar el despliegue de pods de app en nodos extremos, añada una [regla de afinidad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) de nodo extremo y una [tolerancia ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) a su despliegue de app.

Ejemplo de YAML de despliegue con afinidad y tolerancia de nodo extremo:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  selector:
    matchLabels:
      <label_name>: <label_value>
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

Cuando el clúster está conectado a varias VLAN públicas o privadas, sus pods de app podrían desplegarse en nodos trabajadores que están conectados únicamente a una VLAN. Si la dirección de IP del NLB está conectada a una VLAN diferente de la de estos nodos trabajadores, los pods de servicio de equilibrador de carga no se desplegarán en dichos nodos trabajadores.
{:shortdesc}

Cuando la dirección IP de origen esté habilitada, planifique pods de app en nodos trabajadores que estén en la misma VLAN que la dirección IP del NLB añadiendo una regla de afinidad al despliegue de la app.

Antes de empezar: [Inicie la sesión en su cuenta. Si procede, apunte al grupo de recursos adecuado. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. Obtenga la dirección IP del servicio de NLB. Busque la dirección IP en el campo **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Recupere el ID de VLAN al que se conecta el servicio de NLB.

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

    2. En la salida bajo **Subnet VLANs**, busque el CIDR de subred que coincida con la dirección IP del NLB que recuperó con anterioridad y anote el ID de VLAN.

        Por ejemplo, si la dirección IP del servicio de NLB es `169.36.5.xxx`, la subred coincidente en la salida del ejemplo del paso anterior es `169.36.5.xxx/29`. El ID de VLAN al que se conecta la subred es `2234945`.

3. [Añada una regla de afinidad ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) para el despliegue de app para el ID de VLAN que anotó en el paso anterior.

    Por ejemplo, si tiene varias VLAN pero desea que sus pods de app se desplieguen en nodos trabajadores únicamente en la VLAN pública `2234945`:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      selector:
        matchLabels:
          <label_name>: <label_value>
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
