---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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


# Planificación para exponer las apps con redes externas
{: #planning}

Con {{site.data.keyword.containerlong}}, puede gestionar redes externas haciendo que se pueda acceder a las apps de forma pública o privada.
{: shortdesc}

## Elección de un servicio NodePort, LoadBalancer o Ingress
{: #external}

Para permitir que se pueda acceder a las apps externamente desde internet público o desde una red privada, {{site.data.keyword.containerlong_notm}} da soporte a tres servicios de red.
{:shortdesc}

**[Servicio NodePort](cs_nodeport.html)** (clústeres gratuitos y estándares)
* Exponga un puerto en cada nodo trabajador y utilice la dirección IP pública o privada de cualquier nodo trabajador para acceder al servicio en el clúster.
* Iptables es una característica de kernel de Linux que equilibra la carga de las solicitudes en los pods de la app y proporciona un direccionamiento de red de alto rendimiento y control de acceso de red.
* Las direcciones IP públicas y privadas del nodo trabajador no son permanentes. Cuando un nodo trabajador se elimina o se vuelve a crear, se le asigna una nueva dirección IP pública.
* El servicio NodePort es una muy buena opción para probar el acceso público o privado. También se puede utilizar si se necesita acceso público o privado solo durante un breve periodo de tiempo.

**[Servicio LoadBalancer](cs_loadbalancer.html)** (solo clústeres estándares)
* Cada clúster estándar se suministra con cuatro direcciones IP públicas portátiles y cuatro direcciones IP privadas portátiles que puede utilizar para crear un equilibrador de carga TCP/UDP externo para la app.
* Iptables es una característica de kernel de Linux que equilibra la carga de las solicitudes en los pods de la app y proporciona un direccionamiento de red de alto rendimiento y control de acceso de red.
* Las direcciones IP públicas y privadas portátiles que están asignadas al equilibrador de carga son permanentes y no cambian cuando se vuelve a crear un nodo trabajador en el clúster.
* Puede personalizar el equilibrador de carga exponiendo cualquier puerto que necesite la app.

**[Ingress](cs_ingress.html)** (solo clústeres estándares)
* Exponga varias apps en un clúster creando un HTTP o HTTPS externo, TCP o un equilibrador de carga (ALB) UDP. El ALB utiliza un punto de entrada único público o privado protegido para direccionar las solicitudes entrantes a sus apps.
* Puede utilizar una ruta para exponer varias apps en el clúster como servicios.
* Ingress consta de tres componentes:
  * El recurso de Ingress define las reglas sobre cómo direccionar y equilibrar la carga de las solicitudes de entrada para una app.
  * El ALB está a la escucha de solicitudes entrantes de servicio HTTP o HTTPS, TCP o UDP. Reenvía las solicitudes a través de los pods de las apps con base a las reglas que se definen en el recurso Ingress.
  * El equilibrador de carga multizona (MZLB) gestiona todas las solicitudes de entrada a las apps y equilibra la carga de las solicitudes entre los ALB de diversas zonas.
* Utilice Ingress para implementar su propio ALB con reglas de direccionamiento personalizadas y con terminación SSL si es necesario para sus apps.

Para elegir el mejor servicio de red para la app, puede seguir este árbol de decisiones y pulsar una de las opciones para empezar.

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="Esta imagen le guía para elegir la mejor opción de red para la aplicación. Si esta imagen no se muestra, la información puede encontrarse en la documentación." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Servicio NodePort" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="servicio LoadBalancer" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Servicio Ingress" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## Planificación del sistema de red externo público
{: #public_access}

Cuando crea un clúster de Kubernetes en {{site.data.keyword.containerlong_notm}}, puede conectar el clúster a una VLAN pública. La VLAN pública determina la dirección IP pública que se asigna a cada nodo trabajador, lo que proporciona a cada nodo trabajador una interfaz de red pública.
{:shortdesc}

Para que una app esté disponible a nivel público en Internet, puede crear un servicio NodePort, LoadBalancer o Ingress. Para comparar cada servicio, consulte [Elección de un servicio NodePort, LoadBalancer o Ingress](#external).

En el diagrama se muestra cómo Kubernetes reenvía el tráfico de red pública en {{site.data.keyword.containerlong_notm}}.

![{{site.data.keyword.containerlong_notm}} Arquitectura de Kubernetes](images/networking.png)

*Plano de datos de Kubernetes en {{site.data.keyword.containerlong_notm}}*

La interfaz de red pública para los nodos trabajadores tanto en clústeres gratuitos como estándares está protegida por las políticas de red de Calico. Estas políticas bloquean la mayor parte del tráfico de entrada de forma predeterminada. Sin embargo, se permite el tráfico de entrada que se necesita para que Kubernetes funcione, así como las conexiones con los servicios NodePort, LoadBalancer e Ingress. Para obtener más información sobre estas políticas, incluido cómo modificarlas, consulte [Políticas de red](cs_network_policy.html#network_policies).

Para obtener más información sobre cómo configurar el clúster para las redes, incluida la información sobre subredes, cortafuegos y VPN, consulte [Planificación de redes de clúster predeterminadas](cs_network_cluster.html#both_vlans).

<br />


## Planificación del sistema de red externo privado para una configuración de VLAN pública y privada
{: #private_both_vlans}

Cuando los nodos trabajadores están conectados tanto a una VLAN pública como a una privada, puede hacer que solo se pueda acceder a la app desde una red privada, creando los servicios privados NodePort, LoadBalancer o Ingress. A continuación, puede crear políticas de Calico para bloquear el tráfico público a los servicios.

**NodePort**
* [Cree un servicio NodePort](cs_nodeport.html). Además de la dirección IP pública, está disponible un servicio NodePort en la dirección IP privada de un nodo trabajador.
* Un servicio NodePort abre un puerto en un nodo trabajador sobre la dirección IP privada y pública del nodo trabajador. Debe utilizar una [política de red de Calico](cs_network_policy.html#block_ingress) para bloquear los NodePorts públicos.

**LoadBalancer**
* [Cree un servicio LoadBalancer privado](cs_loadbalancer.html).
* Un servicio de equilibrador de carga con una dirección IP privada portátil sigue teniendo un nodo público abierto en cada nodo trabajador. Debe utilizar una [política de red preDNAT de Calico](cs_network_policy.html#block_ingress) para bloquear los puertos del nodo público que contiene.

**Ingress**
* Cuando se crea un clúster, se crea automáticamente un equilibrador de carga de aplicación (ALB) Ingress privado. Puesto que el ALB público está habilitado y el ALB privado está inhabilitado de forma predeterminada, debe [inhabilitar el ALB público](cs_cli_reference.html#cs_alb_configure) y [habilitar el ALB privado](cs_ingress.html#private_ingress).
* A continuación, [cree un servicio Ingress privado](cs_ingress.html#ingress_expose_private).

Como ejemplo, supongamos que ha creado un servicio de equilibrador de carga privado. También ha creado una política de preDNAT de Calico para evitar que el tráfico público llegue a los NodePorts públicos abiertos por el equilibrador de carga. A este equilibrador de carga privado se puede acceder mediante:
* Cualquier pod en ese mismo clúster
* Cualquier pod en cualquier clúster de la misma cuenta de IBM Cloud
* Si tiene la [expansión de VLAN habilitada](cs_subnets.html#subnet-routing), cualquier sistema que esté conectado a cualquiera de las VLAN privadas en la misma cuenta de IBM Cloud
* Si no está en la cuenta de IBM Cloud pero sí detrás del cortafuegos de la empresa, cualquier sistema a través de una conexión VPN con la subred en la que se encuentra la IP del equilibrador de carga
* Si está en una cuenta de IBM Cloud distinta, cualquier sistema a través de una conexión VPN con la subred en la que se encuentra la IP del equilibrador de carga

Para obtener más información sobre cómo configurar el clúster para las redes, incluida la información sobre subredes, cortafuegos y VPN, consulte [Planificación de redes de clúster predeterminadas](cs_network_cluster.html#both_vlans).

<br />


## Planificación del sistema de red externo privado para una configuración solo de VLAN privada
{: #private_vlan}

Cuando los nodos trabajadores están conectados solo a una VLAN privada, puede hacer que solo se pueda acceder a la app desde una red privada, creando los servicios privados NodePort, LoadBalancer o Ingress. Puesto que los nodos trabajadores no están conectados a una VLAN pública, no se direcciona ningún tráfico público a estos servicios.

**NodePort**:
* [Cree un servicio NodePort privado](cs_nodeport.html). El servicio está disponible sobre la dirección IP privada de un nodo trabajador.
* En el cortafuegos privado, abra el puerto que ha configurado cuando ha desplegado el servicio a las direcciones IP privadas para permitir el tráfico a todos los nodos trabajadores. Para encontrar el puerto, ejecute `kubectl get svc`. El puerto está en el rango 20000-32000.

**LoadBalancer**
* [Cree un servicio LoadBalancer privado](cs_loadbalancer.html). Si el clúster solo está disponible en una VLAN privada, se utiliza una de las cuatro direcciones IP privadas portátiles disponibles.
* En el cortafuegos privado, abra el puerto que ha configurado cuando ha desplegado el servicio a la dirección IP privada del servicio de equilibrador de carga.

**Ingress**:
* Debe configurar un [servicio DNS que esté disponible en la red privada ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
* Cuando crea un clúster, se crea automáticamente un equilibrador de carga de aplicación (ALB) Ingress privado, pero no se habilita de forma predeterminada. Debe [habilitar el ALB privado](cs_ingress.html#private_ingress).
* A continuación, [cree un servicio Ingress privado](cs_ingress.html#ingress_expose_private).
* En el cortafuegos privado, abra el puerto 80 para HTTP o el puerto 443 para HTTPS a la dirección IP correspondiente al ALB privado.

Para obtener más información sobre cómo configurar el clúster para las redes, incluida la información sobre subredes y dispositivos de pasarela, consulte [Planificación de red para una configuración solo de VLAN privada](cs_network_cluster.html#private_vlan).
