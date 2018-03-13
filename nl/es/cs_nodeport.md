---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuración de servicios NodePort
{: #nodeport}

Puede poner la app a disponibilidad pública en Internet utilizando la dirección IP pública de cualquier nodo trabajador de un clúster y exponiendo un puerto de nodo. Utilice esta opción para pruebas y para acceso público de corto plazo.
{:shortdesc}

## Configuración del acceso público a una app utilizando el tipo de servicio NodePort
{: #config}

Puede exponer la app como servicio de Kubernetes de tipo NodePort para clústeres gratuitos o estándares.
{:shortdesc}

**Nota:** La dirección IP pública de un nodo trabajador no es permanente. Si el nodo trabajador se debe volver a crear, se le asigna una nueva dirección IP pública. Si necesita una dirección IP pública estable y más disponibilidad para el servicio, exponga la app utilizando un [servicio LoadBalancer](cs_loadbalancer.html) o [Ingress](cs_ingress.html).

Si todavía no tiene una app lista, puede utilizar una app de ejemplo de Kubernetes denominada [Guestbook ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml).

1.  En el archivo de configuración de la app, defina una sección de [servicio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/services-networking/service/).

    Ejemplo:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <my-nodeport-service>
      labels:
        run: <my-demo>
    spec:
      selector:
        run: <my-demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>Descripción de los componentes de este archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de la sección del servicio NodePort</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Sustituya <code><em>&lt;my-nodeport-service&gt;</em></code> por el nombre del servicio NodePort.</td>
    </tr>
    <tr>
    <td><code> run</code></td>
    <td>Sustituya <code><em>&lt;my-demo&gt;</em></code> por el nombre de su despliegue.</td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td>Sustituya <code><em>&lt;8081&gt;</em></code> por el puerto en el que escucha el servicio. </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>Opcional: Sustituya <code><em>&lt;31514 &gt;</em></code> por un NodePort comprendido entre 30000 y 32767. No especifique un NodePort que ya estén siendo utilizado por otro servicio. Si no se asigna ningún NodePort, se asignará automáticamente uno aleatorio.<br><br>Si desea especificar un NodePort y desea ver qué NodePorts ya se están utilizando, ejecute el siguiente mandato: <pre class="pre"><code>kubectl get svc</code></pre>Los NodePorts en uso aparecerán bajo el campo **Puertos**.</td>
     </tr>
     </tbody></table>


    Para el ejemplo Guestbook, ya existe una sección de servicio frontal en el archivo de configuración. Para que la app Guestbook esté disponible externamente, añada el tipo de NodePort y un NodePort comprendido entre 30000 y 32767 a la sección de servicio frontal.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  Guarde el archivo de configuración actualizado.

3.  Repita estos pasos para crear un servicio NodePort para cada app que desea exponer a Internet.

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
