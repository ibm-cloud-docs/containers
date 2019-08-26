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



# Acerca de NLB
{: #loadbalancer-about}

Cuando se crea un clúster estándar, {{site.data.keyword.containerlong}} suministra automáticamente una subred pública portátil y una subred privada portátil.
{: shortdesc}

* La subred pública portable proporciona 5 direcciones IP utilizables. Una dirección IP pública portable la utiliza el [ALB de Ingress público](/docs/containers?topic=containers-ingress) predeterminado. Las 4 direcciones IP públicas portables restantes se pueden utilizar para exponer apps individuales en Internet mediante la creación de servicios de equilibrador de carga de red, o NLB, público.
* La subred privada portable proporciona 5 direcciones IP utilizables. Una dirección IP privada portable la utiliza el [ALB de Ingress privado](/docs/containers?topic=containers-ingress#private_ingress) predeterminado. Las 4 direcciones IP privadas portátiles restantes se pueden utilizar para exponer apps individuales en una red privada mediante la creación de servicios de equilibrador de carga, o NLB, privado.

Las direcciones IP públicas y privadas portátiles son IP flotantes estáticas y no cambian cuando se elimina un nodo trabajador. Si se elimina el nodo trabajador en el que se encuentra la dirección IP del NLB, un daemon Keepalived que supervisa constantemente la IP mueve automáticamente la IP a otro nodo trabajador. Puede asignar cualquier puerto al NLB. El NLB sirve como punto de entrada externo para las solicitudes entrantes para la app. Para acceder al NLB desde Internet, puede utilizar la dirección IP pública del equilibrador de carga y el puerto asignado con el formato `<IP_address>:<port>`. También puede crear entradas de DNS para los NLB registrando las direcciones IP de NLB con nombres de host.

Al exponer una app con un servicio de NLB, la app pasa también a estar disponible automáticamente a través de los NodePorts del servicio. Los [NodePorts](/docs/containers?topic=containers-nodeport) son accesibles en cada dirección IP pública y privada de cada nodo trabajador dentro del clúster. Para bloquear el tráfico a los NodePorts mientras utiliza un NLB, consulte [Control del tráfico de entrada a los servicios de equilibrador de carga de red (NLB) o de NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Comparación entre el equilibrio de carga básico y DSR en los NLB de la versión 1.0 y 2.0
{: #comparison}

Cuando crea un NLB, puede elegir un NLB de la versión 1.0, que realiza un equilibrio de carga básico, o la versión 2.0 NLB, que realiza un equilibrio de carga DSR (retorno directo al servidor). Tenga en cuenta que los NLB de la versión 2.0 están en fase beta.
{: shortdesc}

**¿En qué se parecen los NLB de la versión 1.0 y la versión 2.0?**

Los NLB de las versiones 1.0 y 2.0 son los dos equilibradores de carga de capa 4 que existen únicamente en el espacio del kernel de Linux. Ambas versiones se ejecutan dentro del clúster y utilizan recursos de nodos trabajadores. Por lo tanto, la capacidad disponible de los NLB siempre está dedicada a su clúster. Además, ninguna de las dos versiones de NLB finaliza la conexión. En su lugar, reenvían las conexiones a un pod de app.

**¿En qué se diferencian los NLB de la versión 1.0 y la versión 2.0?**

Cuando un cliente envía una solicitud a la app, el NLB direcciona los paquetes de solicitud a la dirección IP del nodo trabajador donde existe un pod de app. Los NLB de la versión 1.0 utilizan NAT (conversión de direcciones de red) para reescribir la dirección IP de origen del paquete de solicitud a la IP del nodo trabajador donde existe un pod de equilibrador de carga. Cuando el nodo trabajador devuelve el paquete de respuesta de app, utiliza dicha IP del nodo trabajador donde existe el NLB. A continuación, el NLB debe enviar el paquete de respuesta al cliente. Para evitar que se reescriba la dirección IP, puede [habilitar la conservación de IP de origen](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations). No obstante, la conservación de IP de origen requiere que los pods de equilibrador de carga y los pods de app se ejecuten en el mismo trabajador para que la solicitud no tenga que reenviarse a otro trabajador. Debe añadir tolerancias y afinidad de nodos a los pods de app. Para obtener más información sobre el equilibrio de carga básico con los NLB de la versión 1.0, consulte [v1.0: Componentes y arquitectura del equilibrio de carga básico](#v1_planning).

A diferencia de los NLB de la versión 1.0, los NLB de la versión 2.0 no utilizan NAT al reenviar solicitudes a pods de app en otros trabajadores. Cuando un NLB 2.0 direcciona una solicitud de cliente, utiliza IP sobre IP (IPIP) para encapsular el paquete de solicitud original en otro paquete. Este paquete IPIP de encapsulado tiene una IP de origen del nodo trabajador donde se encuentra el pod de equilibrador de carga, lo que permite que el paquete de solicitud original pueda conservar la IP de cliente como su dirección IP de origen. A continuación, el nodo trabajador utiliza el retorno directo de servidor (DSR) para enviar el paquete de respuesta de la app a la IP de cliente. El paquete de respuesta se salta el NLB y se envía directamente al cliente, disminuyendo la cantidad de tráfico que debe gestionar el NLB. Para obtener más información sobre el equilibrio de carga DSR con los NLB de la versión 2.0, consulte [v2.0: Componentes y arquitectura de equilibrio de carga DSR](#planning_ipvs).

<br />


## Componentes y arquitectura de un NLB 1.0
{: #v1_planning}

El equilibrador de carga de red (NLB) 1.0 de TCP/UDP utiliza Iptables, una característica del kernel de Linux, para equilibrar la carga de las solicitudes en los pods de una app.
{: shortdesc}

### Flujo del tráfico en un clúster de una sola zona
{: #v1_single}

En el siguiente diagrama se muestra cómo un NLB 1.0 dirige la comunicación procedente de internet a una app en un clúster de una sola zona.
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="Exponer una app en {{site.data.keyword.containerlong_notm}} utilizando un NLB 1.0" style="width:410px; border-style: none"/>

1. Una solicitud enviada a la app utiliza la dirección IP pública del NLB y el puerto asignado en el nodo trabajador.

2. La solicitud se reenvía automáticamente al puerto y a la dirección IP de clúster interna del servicio NLB. Solo se puede acceder a la dirección IP de clúster interna dentro del clúster.

3. `kube-proxy` direcciona la solicitud al servicio NLB de la app.

4. La solicitud se reenvía a la dirección IP privada del pod de la app. La dirección IP de origen del paquete de la solicitud se cambia por la dirección IP pública del nodo trabajador en el que se ejecuta el pod de la app. Si se despliegan varias instancias de app en el clúster, el NLB direcciona las solicitudes entre los pods de app.

### Flujo del tráfico en un clúster multizona
{: #v1_multi}

En el siguiente diagrama se muestra cómo un equilibrador de carga de red (NLB) 1.0 dirige la comunicación procedente de internet a una app en un clúster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Uso de un NLB 1.0 para equilibrar la carga de las apps en clústeres multizona" style="width:500px; border-style: none"/>

De forma predeterminada, cada NLB 1.0 se configura solo en una zona. Para conseguir una alta disponibilidad, debe desplegar un NLB 1.0 en cada una de las zonas donde tenga instancias de la app. Los NLB de las distintas zonas gestionan las solicitudes en un ciclo en rueda. Además, cada NLB direcciona las solicitudes a las instancias de la app en su propia zona y a las instancias de la app en otras zonas.

<br />


## Componentes y arquitectura de un NLB 2.0 (beta)
{: #planning_ipvs}

Las prestaciones del equilibrador de carga de red (NLB) 2.0 están en fase beta. Para utilizar un NLB 2.0, debe
[actualizar los nodos maestro y trabajadores del clúster](/docs/containers?topic=containers-update) a Kubernetes versión 1.12 o posterior.
{: note}

El NLB 2.0 es un equilibrador de carga de capa 4 que utiliza el servidor virtual IP (IPVS) del kernel de Linux. El NLB 2.0 admite TCP y UDP, se ejecuta delante de varios nodos trabajadores y utiliza el tunelado de IP sobre IP (IPIP) para distribuir el tráfico que llega a una dirección IP individual del equilibrador de carga en dichos nodos trabajadores.

¿Desea más información sobre los patrones de despliegue de equilibrio de carga disponibles en {{site.data.keyword.containerlong_notm}}? Consulte esta [publicación del blog ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/).
{: tip}

### Flujo del tráfico en un clúster de una sola zona
{: #ipvs_single}

En el siguiente diagrama se muestra cómo un NLB 2.0 dirige la comunicación procedente de internet a una app en un clúster de una sola zona.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="Exponer una app en {{site.data.keyword.containerlong_notm}} utilizando un NLB versión 2.0" style="width:600px; border-style: none"/>

1. Una solicitud de cliente enviada a la app utiliza la dirección IP pública del NLB y el puerto asignado en el nodo trabajador. En este ejemplo, el NLB tiene una dirección IP virtual de 169.61.23.130, que se encuentra actualmente en el trabajador 10.73.14.25.

2. El NLB encapsula el paquete de solicitud de cliente (etiquetado como "SC" en la imagen) dentro de un paquete IPIP (etiquetado como "IPIP"). El paquete de solicitud de cliente mantiene la IP de cliente como su dirección IP de origen. El paquete de encapsulado IPIP utiliza la IP 10.73.14.25 del trabajador como su dirección IP de origen.

3. El NLB direcciona el paquete IPIP a un trabajador en el que se encuentre un pod de app, 10.73.14.26. Si se despliegan varias instancias de app en el clúster, el NLB direcciona las solicitudes entre los trabajadores donde se hayan desplegado pods de app.

4. El trabajador 10.73.14.26 desempaqueta el paquete de encapsulado IPIP y, a continuación, desempaqueta el paquete de solicitud de cliente. El paquete de solicitud de cliente se reenvía al pod de app en ese nodo trabajador.

5. A continuación, el trabajador 10.73.14.26 utiliza la dirección IP de origen del paquete de solicitud original, la IP de cliente, para devolver el paquete de respuesta del pod de app directamente al cliente.

### Flujo del tráfico en un clúster multizona
{: #ipvs_multi}

El flujo de tráfico a través de un clúster multizona sigue el mismo camino que el
[tráfico a través de un clúster de una sola zona](#ipvs_single). En un clúster multizona, el NLB direcciona las solicitudes a las instancias de la app en su propia zona y a las instancias de la app en otras zonas. El diagrama siguiente muestra cómo los NLB versión 2.0 de cada zona dirigen el tráfico de Internet a una app en un clúster multizona.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Exponer una app en {{site.data.keyword.containerlong_notm}} utilizando un NLB 2.0" style="width:500px; border-style: none"/>

De forma predeterminada, cada NLB versión 2.0 se configura solo en una zona. Puede conseguir una mayor disponibilidad desplegando un NLB versión 2.0 en cada una de las zonas donde tenga instancias de la app.
