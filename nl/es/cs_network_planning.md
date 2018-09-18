---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Planificación del sistema de red del clúster
{: #planning}

Con {{site.data.keyword.containerlong}}, puede gestionar redes externas, haciendo que se pueda acceder a las apps de forma pública o privada, y redes internas en el clúster.
{: shortdesc}

## Elección de un servicio NodePort, LoadBalancer o Ingress
{: #external}

Para permitir que se pueda acceder a las apps externamente desde [internet público](#public_access) o desde una [red privada](#private_both_vlans), {{site.data.keyword.containershort_notm}} da soporte a tres servicios de red.
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

Cuando crea un clúster de Kubernetes en {{site.data.keyword.containershort_notm}}, puede conectar el clúster a una VLAN pública. La VLAN pública determina la dirección IP pública que se asigna a cada nodo trabajador, lo que proporciona a cada nodo trabajador una interfaz de red pública.
{:shortdesc}

Para que una app esté disponible a nivel público en Internet, puede crear un servicio NodePort, LoadBalancer o Ingress. Para comparar cada servicio, consulte [Elección de un servicio NodePort, LoadBalancer o Ingress](#external).

En el diagrama se muestra cómo Kubernetes reenvía el tráfico de red pública en {{site.data.keyword.containershort_notm}}.

![{{site.data.keyword.containershort_notm}} Arquitectura de Kubernetes](images/networking.png)

*Plano de datos de Kubernetes en {{site.data.keyword.containershort_notm}}*

La interfaz de red pública para los nodos trabajadores tanto en clústeres gratuitos como estándares está protegida por las políticas de red de Calico. Estas políticas bloquean la mayor parte del tráfico de entrada de forma predeterminada. Sin embargo, se permite el tráfico de entrada que se necesita para que Kubernetes funcione, así como las conexiones con los servicios NodePort, LoadBalancer e Ingress. Para obtener más información sobre estas políticas, incluido cómo modificarlas, consulte [Políticas de red](cs_network_policy.html#network_policies).

<br />


## Planificación del sistema de red externo privado para una configuración de VLAN pública y privada
{: #private_both_vlans}

Cuando crea un clúster de Kubernetes en {{site.data.keyword.containershort_notm}}, debe conectar el clúster a una VLAN privada. La VLAN privada determina la dirección IP privada que se asigna a cada nodo trabajador, lo que proporciona a cada nodo trabajador una interfaz de red privada.
{:shortdesc}

Cuando desee mantener las apps conectadas únicamente a una red privada, puede utilizar la interfaz de red privada para los nodos trabajadores en los clústeres estándares. Sin embargo, cuando los nodos trabajadores están conectados tanto a una VLAN pública como a una privada, también debe utilizar las políticas de red de Calico para proteger el clúster ante un acceso público no deseado.

En las secciones siguientes se describen las funciones de {{site.data.keyword.containershort_notm}} que puede utilizar para exponer sus apps a una red privada y proteger el clúster ante un acceso público no deseado. Si lo desea, también puede aislar las cargas de trabajo de la red y conectar el clúster a recursos de una red local.

### Exponga sus apps con servicios de red privados y proteja su clúster con las políticas de red de Calico
{: #private_both_vlans_calico}

La interfaz de red pública de los nodos trabajadores está protegida por [valores predefinidos de política de red de Calico](cs_network_policy.html#default_policy) que se configuran en cada nodo trabajador durante la creación del clúster. De forma predeterminada, todo el tráfico de red de salida está permitido para todos los nodos trabajadores. El tráfico de red de entrada se bloquea excepto en algunos puertos abiertos para que IBM pueda supervisar el tráfico de la red y pueda instalar automáticamente las actualizaciones de seguridad en el nodo maestro de Kubernetes. El acceso al kubelet del nodo trabajador está protegido por un túnel OpenVPN. Para obtener más información, consulte la [arquitectura {{site.data.keyword.containershort_notm}}](cs_tech.html).

Si expone sus apps con un servicio NodePort, un servicio LoadBalancer o un equilibrador de carga de aplicaciones de Ingress, las políticas de Calico predeterminadas también permiten el tráfico de red de entrada procedente de Internet en estos servicios. Para hacer que solo se pueda acceder a la aplicación desde una red privada, puede optar por utilizar solo los servicios privados NodePort, LoadBalancer o Ingress y bloquear todo el tráfico público destinado a los servicios.

**NodePort**
* [Cree un servicio NodePort](cs_nodeport.html). Además de la dirección IP pública, está disponible un servicio NodePort en la dirección IP privada de un nodo trabajador.
* Un servicio NodePort abre un puerto en un nodo trabajador sobre la dirección IP privada y pública del nodo trabajador. Debe utilizar una [política de red de Calico](cs_network_policy.html#block_ingress) para bloquear los NodePorts públicos.

**LoadBalancer**
* [Cree un servicio LoadBalancer privado](cs_loadbalancer.html).
* Un servicio de equilibrador de carga con una dirección IP privada portátil sigue teniendo un nodo público abierto en cada nodo trabajador. Debe utilizar una [política de red preDNAT de Calico](cs_network_policy.html#block_ingress) para bloquear los puertos del nodo público que contiene.

**Ingress**
* Cuando se crea un clúster, se crea automáticamente un equilibrador de carga de aplicación (ALB) Ingress privado. Puesto que el ALB público está habilitado y el ALB privado está inhabilitado de forma predeterminada, debe [inhabilitar el ALB público](cs_cli_reference.html#cs_alb_configure) y [habilitar el ALB privado](cs_ingress.html#private_ingress).
* A continuación, [cree un servicio Ingress privado](cs_ingress.html#ingress_expose_private).

Para obtener más información sobre cada servicio, consulte [Elección de un servicio de NodePort, LoadBalancer o Ingress](#external).

### Opcional: aísle las cargas de trabajo de red en nodos trabajadores de extremo
{: #private_both_vlans_edge}

Los nodos trabajadores de extremo pueden mejorar la seguridad de su clúster al permitir el acceso externo a un número inferior de nodos trabajadores y aislar la carga de trabajo en red. Para asegurarse de que Ingress y los pods de equilibrador de carga se despliegan solo en los nodos trabajadores especificados, [etiquete los nodos trabajadores como nodos de extremo](cs_edge.html#edge_nodes). Para evitar también que se ejecuten otras cargas de trabajo en los nodos de extremo, [marque los nodos de extremo](cs_edge.html#edge_workloads).

A continuación, utilice una [política de red preDNAT de Calico](cs_network_policy.html#block_ingress) para bloquear el tráfico a los puertos del nodo público de los clústeres que se ejecutan en los nodos trabajadores. El bloqueo de los puertos de los nodos garantiza que los nodos trabajadores de extremo sean los únicos nodos trabajadores que manejen el tráfico entrante.

### Opcional: conéctese a una base de datos local utilizando la VPN strongSwan
{: #private_both_vlans_vpn}

Para conectar de forma segura sus nodos trabajadores y apps a una red local, puede configurar un [servicio VPN strongSwan IPSec ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.strongswan.org/about.html). El servicio VPN IPSec de strongSwan proporciona un canal de comunicaciones de extremo a extremo seguro sobre Internet que está basado en la suite de protocolos
Internet Protocol Security (IPSec) estándar del sector. Para configurar una conexión segura entre el clúster y una red local, [configure y despliegue el servicio VPN IPSec strongSwan](cs_vpn.html#vpn-setup) directamente en un pod del clúster.

<br />


## Planificación del sistema de red externo privado solo para una configuración de VLAN privada
{: #private_vlan}

Cuando crea un clúster de Kubernetes en {{site.data.keyword.containershort_notm}}, debe conectar el clúster a una VLAN privada. La VLAN privada determina la dirección IP privada que se asigna a cada nodo trabajador, lo que proporciona a cada nodo trabajador una interfaz de red privada.
{:shortdesc}

Cuando los nodos trabajadores están conectados únicamente a una VLAN privada, puede utilizar la interfaz de red privada para que los nodos trabajadores mantengan las apps conectadas solo a la red privada. Luego puede utilizar un dispositivo de pasarela para proteger el clúster frente a un acceso público no deseado.

En las secciones siguientes se describen las funciones de {{site.data.keyword.containershort_notm}} que puede utilizar para proteger su clúster ante un acceso público no deseado, exponer sus apps a una red privada y conectar los recursos a una red local.

### Configure un dispositivo de pasarela
{: #private_vlan_gateway}

Si los nodos trabajadores únicamente se configuran con una VLAN privada, debe configurar una solución alternativa para la conectividad de red. Puede configurar un cortafuegos con políticas de red personalizadas para proporcionar seguridad de red dedicada para el clúster estándar y para detectar y solucionar problemas de intrusión en la red. Por ejemplo, puede configurar un [dispositivo direccionador virtual](/docs/infrastructure/virtual-router-appliance/about.html) o un [dispositivo de seguridad Fortigate](/docs/infrastructure/fortigate-10g/about.html) para que actúe como cortafuegos y bloquee el tráfico no deseado. Si configura un cortafuegos, [también debe abrir los puertos y direcciones IP necesarios](cs_firewall.html#firewall_outbound) para cada región para que los nodos maestro y trabajador se puedan comunicar. 

**Nota**: si tiene un dispositivo direccionador existente y luego añade un clúster, las nuevas subredes portátiles que se soliciten para el clúster no se configuran en el dispositivo direccionador. Para poder utilizar los servicios de red, debe habilitar el direccionamiento entre las subredes de la misma VLAN mediante la [habilitación de la expansión de VLAN](cs_subnets.html#vra-routing).

### Exponga sus apps con servicios de red privados
{: #private_vlan_services}

Para hacer que solo se pueda acceder a la app desde una red privada, puede utilizar los servicios privados NodePort, LoadBalancer o Ingress. Puesto que los nodos trabajadores no están conectados a una VLAN pública, no se direcciona ningún tráfico público a estos servicios.

**NodePort**:
* [Cree un servicio NodePort privado](cs_nodeport.html). El servicio está disponible sobre la dirección IP privada de un nodo trabajador.
* En el cortafuegos privado, abra el puerto que ha configurado cuando ha desplegado el servicio a las direcciones IP privadas para permitir el tráfico a todos los nodos trabajadores. Para encontrar el puerto, ejecute `kubectl get svc`. El puerto está en el rango 20000-32000.

**LoadBalancer**
* [Cree un servicio LoadBalancer privado](cs_loadbalancer.html). Si el clúster solo está disponible en una VLAN privada, se utiliza una de las cuatro direcciones IP privadas portátiles disponibles.
* En el cortafuegos privado, abra el puerto que ha configurado cuando ha desplegado el servicio a la dirección IP privada del servicio de equilibrador de carga.

**Ingress**:
* Cuando crea un clúster, se crea automáticamente un equilibrador de carga de aplicación (ALB) Ingress privado, pero no se habilita de forma predeterminada. Debe [habilitar el ALB privado](cs_ingress.html#private_ingress).
* A continuación, [cree un servicio Ingress privado](cs_ingress.html#ingress_expose_private).
* En el cortafuegos privado, abra el puerto 80 para HTTP o el puerto 443 para HTTPS a la dirección IP correspondiente al ALB privado.


Para obtener más información sobre cada servicio, consulte [Elección de un servicio de NodePort, LoadBalancer o Ingress](#external).

### Opcional: conéctese a una base de datos local utilizando el dispositivo de pasarela
{: #private_vlan_vpn}

Para conectar de forma segura sus nodos trabajadores y apps a una red local, puede configurar una pasarela VPN. Puede utilizar el [dispositivo direccionador virtual (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) o el [dispositivo de seguridad Fortigate (FSA)](/docs/infrastructure/fortigate-10g/about.html) que ha configurado como cortafuegos para configurar también un punto final IPSec VPN. Para configurar VRA, consulte [Configuración de la conectividad de VPN con VRA](cs_vpn.html#vyatta).

<br />


## Planificación del sistema de red interno del clúster
{: #in-cluster}

A todas las pods que se despliegan en un nodo trabajador se les asigna una dirección IP privada en el rango 172.30.0.0/16 y se direccionan únicamente entre nodos trabajadores. Para evitar conflictos, no utilice este rango de IP en ningún otro nodo que se vaya a comunicar con los nodos trabajadores. Los nodos trabajadores y los pods pueden comunicarse de forma segura a través de la red privada utilizando direcciones IP privadas. Sin embargo, cuando un pod se cuelga o cuando es necesario volver a crear un nodo trabajador, se signa una nueva dirección IP privada.

De forma predetermina, es difícil realizar un seguimiento de direcciones IP privadas que cambian para las apps que deben ofrecer una alta disponibilidad. En su lugar, puede utilizar las características incorporadas de descubrimiento de servicios de Kubernetes para exponer las apps como servicios IP del clúster en la red privada. Un servicio de Kubernetes agrupa un conjunto de pods y proporciona una conexión de red a estos pods para otros servicios del clúster sin exponer la dirección IP privada real de cada pod. A los servicios se les asigna una dirección IP interna del clúster a la que solo se puede acceder dentro del clúster.
* **Clústeres antiguos**: en los clústeres creados antes de febrero de 2018 en la zona dal13 o antes de octubre de 2017 en cualquier otra zona, se asigna a los servicios una IP de entre las 254 IP del rango 10.10.10.0/24. Si ha alcanzado el límite de 254 servicios y necesita más servicios, debe crear un nuevo clúster.
* **Clústeres nuevos**: en los clústeres creados después de febrero de 2018 en la zona dal13 o después de octubre de 2017 en cualquier otra zona, a los servicios se les asigna una IP de entre una de las 65.000 IP del rango 172.21.0.0/16.

Para evitar conflictos, no utilice este rango de IP en ningún otro nodo que se vaya a comunicar con los nodos trabajadores. También se crea una entrada de búsqueda de DNS para el servicio y se almacena en el componente `kube-dns` del clúster. La entrada DNS contiene el nombre del servicio, el espacio de nombres en el que se ha creado el servicio y el enlace a la dirección IP asignada interna del clúster.

Para acceder a un pod detrás de un servicio de IP de clúster, la app puede utilizar la dirección IP interna del clúster o puede enviar una solicitud utilizando el nombre del servicio. Cuando se utiliza el nombre del servicio, el nombre se busca en el componente `kube-dns`
y se direcciona a la dirección IP del clúster del servicio. Cuando llega una solicitud al servicio, este asegura que todas las solicitudes se envían a los pods, independientemente de sus direcciones IP internas y del nodo trabajador en el que estén desplegadas.
