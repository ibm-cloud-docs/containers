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


# Planificación de la configuración del clúster y del nodo trabajador
{: #plan_clusters}
Diseñe su clúster estándar de modo que obtenga la máxima disponibilidad y capacidad de su app con {{site.data.keyword.containerlong}}.

## Clústeres de alta disponibilidad
{: #ha_clusters}

Si distribuye sus apps entre varios nodos trabajadores, zonas y clústeres, es menos probable que los usuarios experimenten un tiempo de inactividad del sistema. Características incorporadas como, por ejemplo, el aislamiento y el equilibrio de carga, incrementan la resiliencia con relación a posibles anomalías con hosts, redes o apps.
{: shortdesc}

Revise estas configuraciones potenciales de clústeres que están ordenadas por grados de disponibilidad en orden ascendente.

![Alta disponibilidad para clústeres](images/cs_cluster_ha_roadmap_multizone.png)

1. Un [clúster de una sola zona](#single_zone) con varios nodos trabajadores en una agrupación de nodos trabajadores.
2. Un [clúster multizona](#multizone) que abarca varios nodos trabajadores en varias zonas dentro de una región.
3. [Varios clústeres](#multiple_clusters) configurados entre zonas o regiones conectadas mediante un equilibrador de carga global.

## Clúster de una sola zona
{: #single_zone}

Para mejorar la disponibilidad de la app y permitir la migración tras error en el caso de que un nodo trabajador no esté disponible en el clúster, añada nodos trabajadores adicionales al clúster de una sola zona.
{: shortdesc}

<img src="images/cs_cluster_singlezone.png" alt="Alta disponibilidad para clústeres en una sola zona" width="230" style="width:230px; border-style: none"/>

De forma predeterminada, un clúster de una sola zona se configura con una agrupación de nodos trabajadores denominada `default`. La agrupación de nodos trabajadores agrupa los nodos trabajadores con la misma configuración, como por ejemplo el tipo de máquina, que ha definido durante la creación del clúster. Puede añadir más nodos trabajadores a su clúster [cambiando el tamaño de una agrupación de nodos trabajadores existente](cs_clusters.html#resize_pool) o [añadiendo una nueva agrupación de nodos trabajadores](cs_clusters.html#add_pool).

Cuando se añaden nodos trabajadores, las instancias de la app se pueden distribuir entre varios nodos trabajadores. Si un nodo trabajador queda inactivo, las instancias de la app de los nodos trabajadores disponibles continúan ejecutándose. Kubernetes vuelve a planificar automáticamente los pods de los nodos trabajadores no disponibles para garantizar el rendimiento y la capacidad de la app. Para asegurarse de que los pods están uniformemente distribuidos entre los nodos trabajadores, implemente la [afinidad de pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature).

**¿Puedo convertir un clúster de una sola zona en un clúster multizona?**</br>
Si el clúster se encuentra en una de las [ciudades metropolitanas multizona soportadas](cs_regions.html#zones), sí. Consulte [Actualización de nodos trabajadores autónomos a agrupaciones de nodos trabajadores](cs_cluster_update.html#standalone_to_workerpool).


**¿Tengo que utilizar clústeres multizona?**</br>
No. Puede crear tantos clústeres de una sola zona como desee. De hecho, quizás prefiera clústeres de una sola zona para facilitar la gestión o si el clúster debe residir en una [ciudad de una sola zona](cs_regions.html#zones) específica.

**¿Puedo tener un maestro de alta disponibilidad en una sola zona?**</br>
Sí, con clústeres que ejecuten Kubernetes versión 1.10 o posterior. En una única zona, el maestro está altamente disponible e incluye réplicas en hosts físicos independientes para que el servidor de API de Kubernetes, etcd, el planificador y el gestor de controladores puedan protegerse frente a una interrupción como, por ejemplo, la actualización del maestro. Para protegerse frente a un error zonal, puede:
* [Crear un clúster en una zona con capacidad multizona](cs_clusters_planning.html#multizone), donde el maestro se disperse en zonas.
* [Crear varios clústeres](#multiple_clusters) y conectarlos con un equilibrador de carga global.

## Clúster multizona
{: #multizone}

Con {{site.data.keyword.containerlong}}, puede crear clústeres multizona. Si distribuye sus apps entre varios nodos trabajadores y zonas mediante una agrupación de nodos trabajadores, es menos probable que los usuarios experimenten un tiempo de inactividad del sistema. Características incorporadas como, por ejemplo, el equilibrio de carga, incrementan la resiliencia frente a posibles anomalías de zona con hosts, redes o apps. Si caen los recursos de una zona, las cargas de trabajo del clúster siguen funcionando en las otras zonas. **Nota**: solo están disponibles clústeres de una sola zona para las instancias de {{site.data.keyword.Bluemix_dedicated_notm}}.
{: shortdesc}

**¿Qué es una agrupación de nodos trabajadores?**</br>
Una agrupación de nodos trabajadores es una colección de nodos trabajadores que comparten alguna característica, como por ejemplo tipo de máquina, CPU y memoria. Cuando se crea un clúster, se crea automáticamente una agrupación de nodos trabajadores predeterminada. Para propagar los nodos trabajadores de la agrupación entre zonas, añadir nodos trabajadores a la agrupación o actualizar nodos trabajadores, puede utilizar los nuevos mandatos `ibmcloud ks worker-pool`.

**¿Puedo seguir utilizando nodos trabajadores autónomos?**</br>
La configuración de clúster anterior de nodos trabajadores estándares recibe soporte, pero ha quedado en desuso. Asegúrese de [añadir una agrupación de nodos trabajadores al clúster](cs_clusters.html#add_pool) y, a continuación,
[utilizar agrupaciones de trabajadores](cs_cluster_update.html#standalone_to_workerpool) para organizar los nodos trabajadores en lugar de los nodos trabajadores autónomos.

**¿Puedo convertir un clúster de una sola zona en un clúster multizona?**</br>
Si el clúster se encuentra en una de las [ciudades metropolitanas multizona soportadas](cs_regions.html#zones), sí. Consulte [Actualización de nodos trabajadores autónomos a agrupaciones de nodos trabajadores](cs_cluster_update.html#standalone_to_workerpool).


### Más información sobre la configuración del clúster multizona
{: #mz_setup}

<img src="images/cs_cluster_multizone-ha.png" alt="Alta disponibilidad para clústeres multizona" width="500" style="width:500px; border-style: none"/>

Puede añadir zonas adicionales al clúster para replicar los nodos trabajadores de las agrupaciones de nodos trabajadores entre varias zonas dentro de una región. Los clústeres multizona se han diseñado para planificar uniformemente los pods entre nodos trabajadores y zonas a fin de garantizar su disponibilidad y la recuperación de errores. Si los nodos trabajadores no se distribuyen uniformemente entre las zonas o si no hay suficiente capacidad en una de las zonas, es posible que el planificador de Kubernetes no planifique todos los pods solicitados. Como resultado, los pods podrían pasar a estar en estado **Pendiente** hasta que haya suficiente capacidad disponible. Si desea cambiar el comportamiento predeterminado para que el planificador de Kubernetes distribuya los pods entre zonas con una mejor distribución, utilice la [política de afinidad de pod](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature) `preferredDuringSchedulingIgnoredDuringExecution`.

**¿Por qué necesito nodos trabajadores en 3 zonas?** </br>
La distribución de la carga de trabajo entre 3 zonas garantiza una alta disponibilidad para la app en el caso de que una o dos zonas no estén disponibles, pero también hace que la configuración del clúster sea más rentable. ¿Por qué?, se preguntará. Este es un ejemplo.

Supongamos que necesita un nodo trabajador con 6 núcleos para manejar la carga de trabajo de su app. Para aumentar la disponibilidad del clúster, tiene las siguientes opciones:

- **Duplicar los recursos en otra zona: ** esta opción le deja con 2 nodos trabajadores, cada uno con 6 núcleos en cada zona, lo que suma un total de 12 núcleos. </br>
- **Distribuir los recursos en 3 zonas:** con esta opción, despliega 3 núcleos por zona, lo que le deja con una capacidad total de 9 núcleos. Para manejar la carga de trabajo, siempre debe haber dos zonas activas. Si una zona no está disponible, las otras dos zonas pueden gestionar la carga de trabajo. Si dos zonas no están disponibles, los 3 núcleos restantes están activos para gestionar la carga de trabajo. El hecho de desplegar 3 núcleos por zona significa máquinas más pequeñas y, por lo tanto, menor coste.</br>

**¿Cómo se configura mi nodo maestro de Kubernetes?** </br>
Un clúster multizona se configura con un nodo maestro de Kubernetes individual o de alta disponibilidad (en Kubernetes 1.10 o posterior) que se suministra en la misma área metropolitana que los nodos trabajadores. Además, si crea un clúster multizona, los maestros de alta disponibilidad se dispersarán en zonas. Por ejemplo, si el clúster está en las zonas `dal10`, `dal12` o `dal13`, el maestro se distribuye en cada zona de la ciudad metropolitana multizona de Dallas.

**¿Qué sucede si el nodo maestro de Kubernetes deja de estar disponible?** </br>
El [nodo maestro de Kubernetes](cs_tech.html#architecture) es el componente principal que mantiene el clúster en funcionamiento. El nodo maestro almacena los recursos de clúster y sus configuraciones en la base de datos etcd, que sirve como único punto fiable para el clúster. El servidor de API de Kubernetes es el punto de entrada principal para todas las solicitudes de gestión del clúster procedentes de los nodos trabajadores destinadas al nodo maestro, o cuando desea interactuar con los recursos de clúster.<br><br>Si se produce un fallo del nodo maestro, las cargas de trabajo siguen ejecutándose en los nodos trabajadores, pero no se pueden utilizar mandatos `kubectl` para trabajar con los recursos del clúster o ver el estado del clúster hasta que el servidor de API de Kubernetes del nodo maestro vuelve a estar activo. Si un pod cae durante la interrupción del nodo maestro, el pod no se puede volver a planificar hasta que el nodo trabajador pueda volver a acceder al servidor de API de Kubernetes.<br><br>Durante una interrupción del nodo maestro, todavía puede ejecutar mandatos `ibmcloud ks` en la API de {{site.data.keyword.containerlong_notm}} para trabajar con los recursos de la infraestructura, como nodos trabajadores o VLAN. Si cambia la configuración actual del clúster añadiendo o eliminando nodos trabajadores en el clúster, los cambios no se producen hasta que el nodo maestro vuelve a estar activo.

No reinicie o rearranque un nodo trabajador durante una interrupción del nodo maestro. Esta acción elimina los pods del nodo trabajador. Puesto que el servidor de API de Kubernetes no está disponible, los pods no se pueden volver a programar en otros nodos trabajadores del clúster.
{: important}


Para proteger el clúster frente a un error del nodo maestro de Kubernetes o en regiones en las que no hay clústeres multizona disponibles, puede [configurar varios clústeres y conectarlos con un equilibrador de carga global](#multiple_clusters).

**¿Tengo que hacer algo para que el nodo maestro se pueda comunicar con los trabajadores entre zonas?**</br>
Sí. Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de infraestructura de IBM Cloud (SoftLayer).

**¿Cómo puedo permitir que mis usuarios accedan a mi app desde Internet pública?**</br>
Puede exponer sus apps utilizando un equilibrador de carga de aplicación (ALB) de Ingress o un servicio equilibrador de carga.

- **Equilibrador de carga de aplicación (ALB) de Ingress** de forma predeterminada, los ALB públicos se crean y se habilitan automáticamente en cada zona del clúster. También se crea y se despliega automáticamente un equilibrador de carga multizona (MZLB) de Cloudflare para el clúster, de forma que exista 1 MZLB para cada región. El MZLB coloca las direcciones IP de los ALB detrás del mismo nombre de host y habilita las comprobaciones de estado en estas direcciones IP para determinar si están disponibles o no. Por ejemplo, si tiene nodos trabajadores en 3 zonas en la región EE.UU. este, el nombre de host `yourcluster.us-east.containers.appdomain.cloud` tiene 3 direcciones IP de ALB. El estado de MZLB comprueba la IP de ALB pública en cada zona de una región y mantiene actualizados los resultados de la búsqueda de DNS en función de estas comprobaciones de estado. Para obtener más información, consulte [Componentes y arquitectura de Ingress](cs_ingress.html#planning).

- **Servicios de equilibrador de carga:** los servicios del equilibrador de carga se configuran en una sola zona. Las solicitudes de entrada a la app se direccionan desde esa zona a todas las instancias de la app de otras zonas. Si esta zona deja de estar disponible, es posible que no se pueda acceder a la app desde Internet. Puede configurar servicios de equilibrador de carga adicionales en otras zonas como ayuda frente a un error de una sola zona. Para obtener más información, consulte [servicios del equilibrador de carga](cs_loadbalancer.html#multi_zone_config) de alta disponibilidad.

**¿Puedo configurar el almacenamiento persistente para mi clúster multizona?**</br>
Para el almacenamiento persistente de alta disponibilidad, utilice un servicio de nube, como por ejemplo [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) o [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).

El archivo NFS y el almacenamiento en bloque no se puede compartir entre zonas. Los volúmenes persistentes solo se pueden utilizar en la zona en la que se encuentra el dispositivo de almacenamiento real. Si tiene un archivo NFS o un almacenamiento en bloque existente en el clúster que desea seguir utilizando, debe aplicar las etiquetas de región y zona a los volúmenes persistentes existentes. Estas etiquetas ayudan a kube-scheduler a determinar dónde se debe planificar una app que utiliza un volumen persistente. Ejecute el mandato siguiente y sustituya `<mycluster>` con el nombre del clúster.

```
bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <mycluster>
```
{: pre}

**He creado mi clúster multizona. ¿Por qué sigue habiendo una sola zona? ¿Cómo se añaden zonas a mi clúster?**</br>
Si [crea el clúster multizona con la CLI](cs_clusters.html#clusters_cli), el clúster se crea, pero debe añadir zonas a la agrupación de nodos trabajadores para completar el proceso. Para abarcar varias zonas, el clúster debe estar en una [ciudad metropolitana multizona](cs_regions.html#zones). Para añadir una zona al clúster y distribuir los nodos trabajadores entre las zonas, consulte [Adición de una zona a un clúster](cs_clusters.html#add_zone).

### ¿Cómo va a cambiar la forma en la que gestiono actualmente mis clústeres?
{: #mz_new_ways}

Con la introducción de las agrupaciones de nodos trabajadores, puede utilizar un nuevo conjunto de API y mandatos para gestionar el clúster. Puede ver estos nuevos mandatos en la [página de documentación de la CLI](cs_cli_reference.html#cs_cli_reference) o en el terminal ejecutando `ibmcloud ks help`.

En la tabla siguiente se comparan los métodos antiguos y los nuevos para unas cuantas acciones comunes de gestión de clústeres.
<table summary="En la tabla se muestra la descripción de la nueva forma de ejecutar mandatos multizona. Las filas se leen de izquierda a derecha; la descripción está en la columna uno, el método antiguo en la dos y el nuevo método multizona en la tres.">
<caption>Nuevos métodos para mandatos de la agrupación de nodos trabajadores multizona.</caption>
  <thead>
  <th>Descripción</th>
  <th>Nodos trabajadores autónomos antiguos</th>
  <th>Nuevas agrupaciones de nodos trabajadores multizona</th>
  </thead>
  <tbody>
    <tr>
    <td>Añadir nodos trabajadores al clúster.</td>
    <td><p class="deprecated"><code>ibmcloud ks worker-add</code> para añadir nodos trabajadores autónomos.</p></td>
    <td><ul><li>Para tipos de máquina distintos de los de la agrupación existente, cree una nueva agrupación de nodos trabajadores: [mandato](cs_cli_reference.html#cs_worker_pool_create) <code>ibmcloud ks worker-pool-create</code>.</li>
    <li>Para añadir nodos trabajadores a una agrupación existente, cambie el número de nodos por zona en la agrupación: [mandato](cs_cli_reference.html#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Eliminar nodos trabajadores del clúster.</td>
    <td><code>ibmcloud ks worker-rm</code>, que aún se puede utilizar para suprimir del clúster un nodo trabajador problemático.</td>
    <td><ul><li>Si la agrupación de nodos trabajadores no está equilibrada, por ejemplo después de eliminar un nodo trabajador, vuélvala a equilibrar: [mandato](cs_cli_reference.html#cs_rebalance) <code>ibmcloud ks worker-pool-rebalance</code>.</li>
    <li>Para reducir el número de nodos trabajadores de una agrupación, cambie el número por zona (el valor mínimo es 1): [mandato](cs_cli_reference.html#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Utilizar una nueva VLAN para los nodos trabajadores.</td>
    <td><p class="deprecated">Añada un nuevo nodo trabajador que utilice la nueva VLAN privada o pública: <code>ibmcloud ks worker-add</code>.</p></td>
    <td>Establecer la agrupación de nodos trabajadores que modo que utilice una VLAN pública o privada distinta de la que se utilizaba anteriormente: [mandato](cs_cli_reference.html#cs_zone_network_set) <code>ibmcloud ks zone-network-set</code>.</td>
    </tr>
  </tbody>
  </table>

## Varios clústeres conectados con un equilibrador de carga global
{: #multiple_clusters}

Para proteger la app frente a un error del nodo maestro de Kubernetes y para las regiones en las que no están disponibles los clústeres multizona, puede crear varios clústeres en diferentes zonas de una región y conectarlos con un equilibrador de carga global.
{: shortdesc}

<img src="images/cs_multiple_cluster_zones.png" alt="Alta disponibilidad para varios clústeres" width="700" style="width:700px; border-style: none"/>

Para equilibrar la carga de trabajo entre varios clústeres, debe configurar un equilibrador de carga global y añadir las direcciones IP de los equilibradores de carga de aplicación (ALB) o los servicios del equilibrador de carga a su dominio. Al añadir estas direcciones IP, puede direccionar el tráfico de entrada entre los clústeres. Para que el equilibrador de carga global detecte si uno de los clústeres deja de estar disponible, tenga en cuenta la posibilidad de añadir una comprobación de estado basada en ping a cada dirección IP. Cuando se configura esta comprobación, el proveedor de DNS ejecuta ping de forma regular sobre las direcciones IP que ha añadido a su dominio. Si una dirección IP deja de estar disponible, el tráfico ya no se envía a esta dirección IP. Sin embargo, Kubernetes no reinicia automáticamente los pods del clúster no disponible en los nodos trabajadores de los clústeres disponibles. Si desea que Kubernetes reinicie automáticamente los pods en los clústeres disponibles, tenga en cuenta la posibilidad de configurar un [clúster multizona](#multizone).

**¿Por qué necesito 3 clústeres en 3 zonas?** </br>
De forma similar a cómo se utilizan [3 zonas en clústeres multizona](#multizone), puede proporcionar más disponibilidad a su app si configura 3 clústeres entre zonas. También puede reducir los costes ya que necesitará máquinas más pequeñas para gestionar la carga de trabajo.

**¿Qué pasa si deseo configurar varios clústeres entre regiones?** </br>
Puede configurar varios clústeres en distintas regiones de una geolocalización (como EE.UU. sur y EE.UU. este) o entre geolocalizaciones (como, por ejemplo, EE.UU. sur y UE central). Ambas configuraciones ofrecen el mismo nivel de disponibilidad para la app, pero también añaden complejidad cuando se trata de compartición de datos y replicación de datos. En la mayoría de los casos, resulta suficiente permanecer dentro de la misma geolocalización. Pero, si tiene usuarios en todo el mundo, es posible que sea mejor configurar un clúster donde se encuentren los usuarios, de forma que los usuarios no experimentan tiempos de espera largos cuando envían una solicitud a la app.

**Para configurar un equilibrador de carga global para varios clústeres:**

1. [Cree clústeres](cs_clusters.html#clusters) en varias zonas o regiones.
2. Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](cs_users.html#infra_access) **Red > Gestionar expansión de VLAN de la red**, o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Si utiliza {{site.data.keyword.BluDirectLink}}, en su lugar debe utilizar una [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Para habilitar la VRF, póngase en contacto con el representante de cuentas de infraestructura de IBM Cloud (SoftLayer).
3. En cada clúster, exponga la app utilizando un [equilibrador de carga de aplicación (ALB)](cs_ingress.html#ingress_expose_public) o un [servicio equilibrador de carga](cs_loadbalancer.html).
4. Para cada clúster, obtenga una lista de las direcciones IP públicas correspondientes a los ALB o a los servicios equilibradores de carga.
   - Para obtener una lista de la dirección IP de todos los ALB públicos habilitados en el clúster:
     ```
     ibmcloud ks albs --cluster <cluster_name_or_id>
     ```
     {: pre}

   - Para obtener una lista de las direcciones IP del servicio equilibrador de carga:
     ```
     kubectl describe service <myservice>
     ```
     {: pre}

     La dirección IP de **Load Balancer Ingress** es la dirección IP portátil asignada al servicio equilibrador de carga.

4.  Configure un equilibrador de carga global utilizando {{site.data.keyword.Bluemix_notm}} Internet Services (CIS) o configure su propio equilibrador de carga global.

    **Para utilizar un equilibrador de carga global de CIS**:
    1.  Configure el servicio siguiendo los pasos 1 - 4 del apartado [Iniciación a {{site.data.keyword.Bluemix_notm}} Internet Services (CIS)](/docs/infrastructure/cis/getting-started.html#getting-started-with-ibm-cloud-internet-services-cis-).
        *  Los pasos 1-3 le guían por el proceso de suministro de la instancia de servicio, de adición del dominio de la app y de configuración de los servidores de nombres.
        * El paso 4 le guía a través del proceso de creación de registros DNS. Cree un registro DNS para cada ALB o dirección IP del equilibrador de carga que haya recopilado. Estos registros DNS correlacionan el dominio de la app con todos los ALB del clúster o los equilibradores de carga y garantizan que las solicitudes destinadas al dominio de la app se reenvían a los clústeres en un ciclo en rueda.
    2. [Añada comprobaciones de estado](/docs/infrastructure/cis/glb-setup.html#add-a-health-check) para los ALB o equilibradores de carga. Puede utilizar la misma comprobación de estado para los ALB o los equilibradores de carga de todos los clústeres, o bien puede crear comprobaciones de estado específicas que se utilizarán para clústeres específicos.
    3. [Añada una agrupación de origen](/docs/infrastructure/cis/glb-setup.html#add-a-pool) para cada clúster añadiendo el ALB o las direcciones IP del equilibrador de carga del clúster. Por ejemplo, si tiene 3 clústeres y cada uno de ellos tiene 2 ALB, cree 3 agrupaciones de origen que tengan 2 direcciones IP de ALB. Añada una comprobación de estado a cada agrupación de origen que cree.
    4. [Añada un equilibrador de carga global](/docs/infrastructure/cis/glb-setup.html#set-up-and-configure-your-load-balancers).

    **Para utilizar su propio equilibrador de carga global**:
    1. Configure el dominio de modo que direccione el tráfico de entrada a los servicios ALB o de equilibrador de carga añadiendo las direcciones IP de todos los ALB públicos habilitados y de los servicios del equilibrador de carga a su dominio.
    2. Para cada dirección IP, habilite una comprobación de estado basada en ping para que el proveedor de DNS pueda detectar direcciones IP en mal estado. Si se detecta una dirección IP en mal estado, el tráfico deja de direccionarse a dicha dirección IP.

## Clústeres privados
{: #private_clusters}

De forma predeterminada, {{site.data.keyword.containerlong_notm}} configura el clúster con acceso a una VLAN privada y a una VLAN pública. La VLAN privada determina la dirección IP privada que se asigna a cada nodo trabajador, lo que proporciona a cada nodo trabajador una interfaz de red privada. La VLAN pública permite que los nodos trabajadores se conecten de forma automática y segura con el maestro.

Si desea bloquear el clúster para permitir el tráfico privado a través de la VLAN privada pero bloquear el tráfico público a través de la VLAN pública, puede [proteger el clúster del acceso público con las políticas de red Calico](cs_network_cluster.html#both_vlans_private_services). Estas políticas de red Calico no impiden que los nodos trabajadores se comuniquen con el nodo maestro. También puede limitar la superficie de vulnerabilidad del clúster sin bloquear el tráfico público mediante el [aislamiento de las cargas de trabajo de red en los nodos trabajadores de extremo](cs_edge.html).

Si desea crear un clúster que sólo tenga acceso a una VLAN privada, puede crear clúster privado multizona o de una sola zona. Sin embargo, cuando los nodos trabajadores están conectados únicamente a una VLAN privada, los nodos trabajadores no se pueden conectar automáticamente al nodo maestro. Debe configurar un dispositivo de pasarela para proporcionar conectividad de red entre los nodos trabajadores y el maestro.

No puede convertir un clúster que esté conectado a una VLAN pública y una VLAN privada en un clúster sólo privado. La eliminación de todas las VLAN públicas de un clúster hace que varios componentes del clúster dejen de funcionar. Debe crear un nuevo clúster utilizando los pasos siguientes.
{: note}

Si desea crear un clúster que sólo tenga acceso a una VLAN privada:

1.  Consulte [Planificación de redes de clúster solo privadas](cs_network_cluster.html#private_vlan).
2.  Configure el dispositivo de pasarela para la conectividad de red. Tenga en cuenta que debe [abrir las direcciones IP y los puertos necesarios](cs_firewall.html#firewall_outbound) en el cortafuegos y [habilitar la expansión de VLAN](cs_subnets.html#vra-routing) para las subredes.
3.  [Cree un clúster utilizando la CLI](cs_clusters.html#clusters_cli) incluyendo el distintivo `--private-only`.
4.  Si desea exponer una app a una red privada utilizando un servicio privado de NodePort, equilibrador de carga o Ingress, consulte [Planificación del sistema de red externo privado para una configuración solo de VLAN privada](cs_network_planning.html#private_vlan). Solo se puede acceder al servicio en la dirección IP privada y debe configurar los puertos en el cortafuegos para utilizar la dirección IP privada.


## Agrupaciones de nodos trabajadores y nodos trabajadores
{: #planning_worker_nodes}

Un clúster de Kubernetes está formado por nodos trabajadores agrupados en agrupaciones de nodos trabajadores y se supervisa y se gestiona de forma centralizada desde el nodo maestro de Kubernetes. Los administradores del clúster deciden cómo configurar el clúster de nodos trabajadores para garantizar que los usuarios del clúster disponen de todos los recursos para desplegar y ejecutar las apps en el clúster.
{:shortdesc}

Cuando se crea un clúster estándar, se solicitan los nodos trabajadores de las mismas especificaciones de memoria, CPU y espacio de disco (tipo) en la infraestructura de IBM Cloud (SoftLayer) en su nombre y se añaden a la agrupación predeterminada de nodos trabajadores del clúster. A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar después de haber creado el clúster. Puede elegir entre servidores virtuales o físicos (nativos). En función del nivel de aislamiento de hardware que elija, los nodos trabajadores virtuales se pueden configurar como nodos compartidos o dedicados. Para añadir distintos tipos al clúster, [cree otra agrupación de nodos trabajadores](cs_cli_reference.html#cs_worker_pool_create).

Kubernetes limita el número máximo de nodos trabajadores que puede tener en un clúster. Consulte el apartado sobre [nodo trabajador y cuotas de pod ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/setup/cluster-large/) para obtener más información.



## Hardware disponible para los nodos trabajadores
{: #shared_dedicated_node}

Cuando se crea un clúster estándar en {{site.data.keyword.Bluemix_notm}}, se selecciona si las agrupaciones de trabajadores constan de nodos trabajadores que son máquinas físicas (nativas) o máquinas virtuales que se ejecutan en hardware físico. También se selecciona el tipo de nodo de trabajador, la combinación de memoria, la CPU y otras especificaciones de la máquina, como el almacenamiento de disco.
{:shortdesc}

![Opciones de hardware para los nodos trabajadores en un clúster estándar](images/cs_clusters_hardware.png)

Si desea más de un tipo de nodo trabajador, debe crear una agrupación de trabajadores para cada tipo. Cuando se crea un clúster gratuito, el nodo trabajador se suministra automáticamente como nodo compartido virtual en la cuenta de infraestructura de IBM Cloud (SoftLayer). En clústeres estándares, puede elegir el tipo de máquina que funcione mejor para su carga de trabajo. A medida que lo planifique, tenga en cuenta las
[reservas de recursos de nodos trabajadores](#resource_limit_node) en la capacidad total de CPU y memoria.

Puede desplegar clústeres mediante la [interfaz de usuario de la consola](cs_clusters.html#clusters_ui) o la [CLI](cs_clusters.html#clusters_cli).

Seleccione una de las opciones siguientes para decidir el tipo de agrupación de trabajadores que desea.
* [Máquinas virtuales](#vm)
* [Máquinas físicas (nativas)](#bm)
* [Máquinas de almacenamiento definido por software (SDS)](#sds)

### Máquinas virtuales
{: #vm}

Las máquinas virtuales ofrecen una mayor flexibilidad, unos tiempos de suministro más reducidos y proporcionan más características automáticas de escalabilidad que las máquinas nativas, a un precio más reducido. Utilice máquinas virtuales en los casos de uso con un propósito más general como, por ejemplo, en entornos de desarrollo y pruebas, entornos de transferencia y producción, microservicios y apps empresariales. Sin embargo, deberá encontrar un compromiso con su rendimiento. Si necesita un alto rendimiento de cálculo con cargas de trabajo intensivas de RAM, datos o GPU, utilice [máquinas nativas](#bm).
{: shortdesc}

**¿Quiero utilizar hardware compartido o dedicado?**</br>
Cuando se crea un clúster virtual estándar, debe seleccionar si desea que el hardware subyacente se comparta entre varios clientes de {{site.data.keyword.IBM_notm}} (tenencia múltiple) o se le dedique a usted exclusivamente (tenencia única).

* **En una configuración de hardware compartido multiarrendatario**: los recursos físicos, como la CPU y la memoria, se comparten en todas las máquinas virtuales desplegadas en el mismo hardware físico. Para asegurarse de que cada máquina virtual se pueda ejecutar de forma independiente, un supervisor de máquina virtual, también conocido como hipervisor, segmenta los recursos físicos en entidades aisladas y los asigna como recursos dedicados a una máquina virtual (aislamiento de hipervisor).
* **En una configuración de hardware de único arrendatario**: todos los recursos físicos están dedicados únicamente a usted. Puede desplegar varios nodos trabajadores como máquinas virtuales en el mismo host físico. De forma similar a la configuración de tenencia múltiple,
el hipervisor asegura que cada nodo trabajador recibe su parte compartida de los recursos físicos disponibles.

Los nodos compartidos suelen resultar más económicos que los nodos dedicados porque los costes del hardware subyacente se comparten entre varios clientes. Sin embargo, cuando decida entre nodos compartidos y dedicados, debe ponerse en contacto con el departamento legal y ver el nivel de aislamiento y de conformidad de la infraestructura que necesita el entorno de app.

**¿Cuáles son las características generales de las máquinas virtuales?**</br>
Las máquinas virtuales utilizan el disco local en lugar de la red de área de almacenamiento (SAN) por motivos de fiabilidad. Entre las ventajas de fiabilidad se incluyen un mejor rendimiento al serializar bytes en el disco local y una reducción de la degradación del sistema de archivos debido a anomalías de la red. Todas las máquinas virtuales se suministran con velocidad de red de 1000 Mbps, 25 GB de almacenamiento en disco local primario para el sistema de archivos del sistema operativo y 100 GB de almacenamiento en disco local secundario para datos como, por ejemplo, el tiempo de ejecución de contenedor y `kubelet`. El almacenamiento local en el nodo trabajador solo es para el proceso a corto plazo y los discos primario y secundario se limpian cuando se actualiza o se vuelve a cargar el nodo trabajador. Para ver las soluciones de almacenamiento persistente, consulte [Planificación de almacenamiento persistente altamente disponible](cs_storage_planning.html#storage_planning).

**¿Qué hago si tengo tipos de máquina `u1c` o `b1c` en desuso?**</br>
Para empezar a utilizar los tipos de máquina `u2c` y `b2c`, [actualice los tipos de máquina añadiendo nodos trabajadores](cs_cluster_update.html#machine_type).

**¿Qué tipos de máquina virtual están disponibles?**</br>
Los tipos de máquina varían por zona. Para ver los tipos de máquinas disponibles en su zona, ejecute `ibmcloud ks machine-types <zone>`. También puede consultar los tipos de máquina [nativa](#bm) o [SDS](#sds) disponibles.

<table>
<caption>Tipos de máquina virtual disponibles en {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Nombre y caso de uso</th>
<th>Núcleos / Memoria</th>
<th>Disco primario / secundario</th>
<th>Velocidad de red</th>
</thead>
<tbody>
<tr>
<td><strong>Virtual, u2c.2x4</strong>: Utilice esta máquina virtual con el tamaño más reducido para realizar pruebas rápidas, pruebas de conceptos y ejecutar otras cargas ligeras.</td>
<td>2 / 4 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.4x16</strong>: Seleccione esta máquina virtual equilibrada para realizar pruebas y desarrollo, y para otras cargas de trabajo ligeras.</td>
<td>4 / 16 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.16x64</strong>: Seleccione esta máquina virtual equilibrada para cargas de trabajo de tamaño medio.</td></td>
<td>16 / 64 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.32x128</strong>: Seleccione esta máquina virtual equilibrada para cargas de trabajo de tamaño medio a grande, por ejemplo, como base de datos y sitio web dinámico con muchos usuarios simultáneos.</td></td>
<td>32 / 128 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>Virtual, b2c.56x242</strong>: Seleccione esta máquina virtual equilibrada para cargas de trabajo grandes, por ejemplo, como base de datos y para varias apps con muchos usuarios simultáneos.</td></td>
<td>56 / 242 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
<tr>
<td><strong>Virtual, c2c.16x16</strong>: utilice este tipo cuando desee un equilibrio uniforme de recursos de cálculo del nodo trabajador para cargas de trabajo ligeras.</td></td>
<td>16 / 16 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.16x32</strong>: utilice este tipo cuando desee una proporción de 1:2 entre recursos de CPU y de memoria del nodo trabajador para cargas de trabajo ligeras o de tamaño medio.</td></td>
<td>16 / 32 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.32x32</strong>: utilice este tipo cuando desee un equilibrio uniforme de recursos de cálculo del nodo trabajador para cargas de trabajo de tamaño medio.</td></td>
<td>32 / 32 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr><tr>
<td><strong>Virtual, c2c.32x64</strong>: utilice este tipo cuando desee una proporción de 1:2 entre recursos de CPU y de memoria del nodo trabajador para cargas de trabajo de tamaño medio.</td></td>
<td>32 / 64 GB</td>
<td>25 GB / 100 GB</td>
<td>1000 Mbps</td>
</tr>
</tbody>
</table>

### Máquinas físicas (nativas)
{: #bm}

Puede suministrar el nodo trabajador como un servidor físico de arrendatario único, también conocido como nativo.
{: shortdesc}

**¿En qué se diferencian las máquinas nativas de las máquinas virtuales?**</br>
Los servidores nativos ofrecen acceso directo a los recursos físicos en la máquina, como la memoria o la CPU. Esta configuración elimina el hipervisor de máquina virtual que asigna recursos físicos a máquinas virtuales que se ejecutan en el host. En su lugar, todos los recursos de una máquina nativa están dedicados exclusivamente al trabajador, por lo que no es necesario preocuparse por "vecinos ruidosos" que compartan recursos o ralenticen el rendimiento. Los tipos de máquina física tienen más almacenamiento local que virtual, y algunos tienen RAID para aumentar la disponibilidad de los datos. El almacenamiento local en el nodo trabajador solo es para el proceso a corto plazo y los discos primario y secundario se limpian cuando se actualiza o se vuelve a cargar el nodo trabajador. Para ver las soluciones de almacenamiento persistente, consulte [Planificación de almacenamiento persistente altamente disponible](cs_storage_planning.html#storage_planning).

**Además de mejores especificaciones para el rendimiento, ¿puedo conseguir algo con las máquinas nativas que no pueda con las máquinas virtuales?**</br>
Sí. Con las máquinas nativas, puede optar por habilitar Trusted Compute para verificar que los nodos trabajadores no se manipulan de forma indebida. Si no habilita la confianza durante la creación del clúster pero desea hacerlo posteriormente, puede utilizar el [mandato](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Una vez que habilita la confianza, no puede inhabilitarla posteriormente. Puede crear un nuevo clúster sin confianza. Para obtener más información sobre cómo funciona la confianza durante el proceso de inicio del nodo, consulte [{{site.data.keyword.containerlong_notm}} con Trusted Compute](cs_secure.html#trusted_compute). Trusted Compute está disponible para determinados tipos de máquinas nativas. Cuando ejecute el [mandato](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types <zone>`, en el campo **Trustable** puede ver qué máquinas dan soporte a la confianza. Por ejemplo, los distintos tipos de GPU `mgXc` no dan soporte a Trusted Compute.

**La opción nativa suena genial. ¿Qué me impide solicitarla en este momento? **</br>
Los servidores nativos son más caros que los servidores virtuales, y son más apropiados para apps de alto rendimiento que necesitan más recursos y control de host.

Los servidores nativos se facturan mensualmente. Si cancela un servidor nativo antes de fin de mes, se le facturará a finales de ese mes. La realización de pedidos de servidores nativos, y su cancelación, es un proceso manual que se realiza a través de su cuenta (SoftLayer) de la infraestructura de IBM Cloud. Puede ser necesario más de un día laborable para completar la tramitación.
{: important}

**¿Qué tipos de servidores nativos puedo solicitar?**</br>
Los tipos de máquina varían por zona. Para ver los tipos de máquinas disponibles en su zona, ejecute `ibmcloud ks machine-types <zone>`. También puede consultar los tipos de máquina [virtual](#vm) o [SDS](#sds).

Las máquinas nativas están optimizadas para distintos casos de uso como, por ejemplo, las cargas de trabajo intensivas de memoria RAM, datos o GPU.

Elija un tipo de máquina con la configuración de almacenamiento correcta para dar soporte a la carga de trabajo. Algunos tipos tienen una combinación de las siguientes configuraciones de disco y almacenamiento. Por ejemplo, algunos tipos tener un disco primario SATA con un disco secundario SSD sin formato.

* **SATA**: un dispositivo de almacenamiento en disco giratorio magnético que se suele utilizar para el disco primario del nodo trabajador que almacena el sistema de archivos del sistema operativo.
* **SSD**: un dispositivo de almacenamiento de unidad de estado sólido para los datos de alto rendimiento.
* **Sin formato**: el dispositivo de almacenamiento no está formateado, con la capacidad completa disponible para su uso.
* **RAID**: el dispositivo de almacenamiento tiene datos distribuidos para redundancia y rendimiento que varían en función del nivel de RAID. Como tal, la capacidad de disco que está disponible para su uso varía.


<table>
<caption>Tipos de máquina nativa disponibles en {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Nombre y caso de uso</th>
<th>Núcleos / Memoria</th>
<th>Disco primario / secundario</th>
<th>Velocidad de red</th>
</thead>
<tbody>
<tr>
<td><strong>Máquina nativa gran capacidad de memoria, mr1c.28x512</strong>: Maximice la RAM disponible para sus nodos trabajadores.</td>
<td>28 / 512 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Máquina nativas con GPU, mg1c.16x128</strong>: Elija este tipo para cargas de trabajo matemáticas intensivas, por ejemplo, para la computación de alto rendimiento, el aprendizaje máquina u otras aplicaciones 3D. Este tipo tiene una tarjeta física Tesla K80 con dos unidades de proceso gráfico (GPU) por tarjeta (2 GPU).</td>
<td>16 / 128 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Máquina nativas con GPU, mg1c.28x256</strong>: Elija este tipo para cargas de trabajo matemáticas intensivas, por ejemplo, para la computación de alto rendimiento, el aprendizaje máquina u otras aplicaciones 3D. Este tipo tiene 2 tarjetas físicas Tesla K80 con 2 GPU por tarjeta, para hacer un total de 4 GPU.</td>
<td>28 / 256 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Nativo con mucho uso de datos, md1c.16x64.4x4tb</strong>: utilice este tipo para una cantidad significativa de almacenamiento en disco local, incluido RAID para aumentar la disponibilidad de los datos, para cargas de trabajo como sistemas de archivos distribuidos, bases de datos grandes y analítica de big data.</td>
<td>16 / 64 GB</td>
<td>2x2 TB RAID1 / 4x4 TB SATA RAID10</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Nativo con mucho uso de datos, md1c.28x512.4x4tb</strong>: utilice este tipo para una cantidad significativa de almacenamiento en disco local, incluido RAID para aumentar la disponibilidad de los datos, para cargas de trabajo como sistemas de archivos distribuidos, bases de datos grandes y analítica de big data.</td>
<td>28 / 512 GB</td>
<td>2x2 TB RAID1 / 4x4 TB SATA RAID10</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Máquina nativa equilibrada, mb1c.4x32</strong>: Para cargas de trabajo equilibradas que requieren más recursos de computación que los ofrecidos por las máquinas virtuales.</td>
<td>4 / 32 GB</td>
<td>2 TB SATA / 2 TB SATA</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Máquina nativa equilibrada, mb1c.16x64</strong>: Para cargas de trabajo equilibradas que requieren más recursos de computación que los ofrecidos por las máquinas virtuales.</td>
<td>16 / 64 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
</tbody>
</table>

### Máquinas de almacenamiento definido por software (SDS)
{: #sds}

Los tipos de almacenamiento definido por software (SDS) son máquinas físicas que se suministran con discos adicionales sin formato para el almacenamiento local físico. A diferencia del disco local primario y secundario, estos discos sin formato no se limpian durante la actualización o la recarga de un nodo trabajador. Debido a que los datos se coubican con el nodo de cálculo, las máquinas SDS son adecuadas para cargas de trabajo de alto rendimiento.
{: shortdesc}

**¿Cuándo debo utilizar los tipos de SDS?**</br>
Normalmente, se utilizan máquinas SDS en los casos siguientes:
*  Si utiliza un complemento SDS para el clúster, utilice una máquina SDS.
*  Si la app es un [StatefulSet ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) que requiere almacenamiento local, puede utilizar máquinas SDS y suministrar [volúmenes persistentes locales de Kubernetes (beta) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/blog/2018/04/13/local-persistent-volumes-beta/).
*  Es posible que tenga apps personalizadas que requieran almacenamiento local adicional en bruto.

Para ver más soluciones de almacenamiento, consulte [Planificación de almacenamiento persistente altamente disponible](cs_storage_planning.html#storage_planning).

**¿Qué tipos de SDS puedo solicitar?**</br>
Los tipos de máquina varían por zona. Para ver los tipos de máquinas disponibles en su zona, ejecute `ibmcloud ks machine-types <zone>`. También puede consultar los tipos de máquina [nativa](#bm) o [virtual](#vm) disponibles.

Elija un tipo de máquina con la configuración de almacenamiento correcta para dar soporte a la carga de trabajo. Algunos tipos tienen una combinación de las siguientes configuraciones de disco y almacenamiento. Por ejemplo, algunos tipos tener un disco primario SATA con un disco secundario SSD sin formato.

* **SATA**: un dispositivo de almacenamiento en disco giratorio magnético que se suele utilizar para el disco primario del nodo trabajador que almacena el sistema de archivos del sistema operativo.
* **SSD**: un dispositivo de almacenamiento de unidad de estado sólido para los datos de alto rendimiento.
* **Sin formato**: el dispositivo de almacenamiento no está formateado, con la capacidad completa disponible para su uso.
* **RAID**: el dispositivo de almacenamiento tiene datos distribuidos para redundancia y rendimiento que varían en función del nivel de RAID. Como tal, la capacidad de disco que está disponible para su uso varía.


<table>
<caption>Tipos de máquina SDS disponibles en {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Nombre y caso de uso</th>
<th>Núcleos / Memoria</th>
<th>Disco primario / secundario</th>
<th>Discos sin formato adicionales</th>
<th>Velocidad de red</th>
</thead>
<tbody>
<tr>
<td><strong>Nativo con SDS, ms2c.4x32.1.9tb.ssd</strong>: si necesita almacenamiento local adicional para rendimiento, utilice este tipo con mucha actividad de disco que admite almacenamiento definido por software (SDS).</td>
<td>4 / 32 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>1,9 TB Raw SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Nativo con SDS, ms2c.16x64.1.9tb.ssd</strong>: si necesita almacenamiento local adicional para rendimiento, utilice este tipo con mucha actividad de disco que admite almacenamiento definido por software (SDS).</td>
<td>16 / 64 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>1,9 TB Raw SSD</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Nativo con SDS, ms2c.28x256.3.8tb.ssd</strong>: si necesita almacenamiento local adicional para rendimiento, utilice este tipo con mucha actividad de disco que admite almacenamiento definido por software (SDS).</td>
<td>28 / 256 GB</td>
<td>SATA de 2 TB / SSD de 1,9 TB</td>
<td>SSD de 3,8 TB en bruto</td>
<td>10000 Mbps</td>
</tr>
<tr>
<td><strong>Nativo con SDS, ms2c.28x512.4x3.8tb.ssd</strong>: si necesita almacenamiento local adicional para rendimiento, utilice este tipo con mucha actividad de disco que admite almacenamiento definido por software (SDS).</td>
<td>28 / 512 GB</td>
<td>SATA de 2 TB / SSD de 1,9 TB</td>
<td>4 discos, SSD de 3,8 TB en bruto</td>
<td>10000 Mbps</td>
</tr>
</tbody>
</table>

## Reservas de recursos del nodo trabajador
{: #resource_limit_node}

{{site.data.keyword.containerlong_notm}} establece reservas de recursos de cálculo que limitan los recursos de cálculo disponibles en cada nodo trabajador. Los recursos de memoria y de CPU reservados no los pueden utilizar los pods del nodo trabajador, y reducen los recursos asignables en cada nodo trabajador. Al desplegar inicialmente los pods, si el nodo trabajador no tiene suficientes recursos asignables, el despliegue falla. Además, si los pods superan el límite de recursos del nodo trabajador, se desalojan los pods. En Kubernetes, este límite se llama [umbral de desalojo de hardware ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Si hay menos CPU o memoria disponible que las reservas del nodo trabajador, Kubernetes comienza a desalojar pods para restaurar recursos de cálculo suficientes. Los pods se vuelven a planificar en otro nodo trabajador si hay uno disponible. Si los pods se desalojan con frecuencia, añada más nodos trabajadores al clúster o establezca [límites de recurso ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) a los pods.

Los recursos que se reservan en el nodo trabajador dependen de la cantidad de CPU y memoria con la que se suministra el nodo trabajador. {{site.data.keyword.containerlong_notm}} define niveles de memoria y CPU tal como se muestra en las tablas siguientes. Si el nodo trabajador viene con recursos de cálculo en varios niveles, se reserva un porcentaje de los recursos de CPU y memoria para cada nivel.

Para revisar cuántos recursos de cálculo se utilizan actualmente en el nodo trabajador, ejecute [`kubectl top node ` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/kubectl/overview/#top).
{: tip}

<table summary="Reservas de memoria de nodo trabajador por nivel.">
<caption>Reservas de memoria de nodo trabajador por nivel.</caption>
<thead>
<tr>
  <th>Nivel de memoria</th>
  <th>% o cantidad reservada</th>
  <th>Ejemplo de nodo trabajador `b2c.4x16` (16 GB)</th>
  <th>Ejemplo de nodo trabajador `mg1c.28x256` (256 GB)</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Primeros 16GB (0-16GB)</td>
  <td>10% de memoria</td>
  <td>1,6 GB</td>
  <td>1,6 GB</td>
</tr>
<tr>
  <td>Siguientes 112GB (17-128GB)</td>
  <td>6% de memoria</td>
  <td>N/D</td>
  <td>6,72 GB</td>
</tr>
<tr>
  <td>GB restantes (129GB+)</td>
  <td>2% de memoria</td>
  <td>N/D</td>
  <td>2,54 GB</td>
</tr>
<tr>
  <td>Reserva adicional para el [desalojo de `kubelet`
![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/)</td>
  <td>100MB</td>
  <td>100MB (cantidad fija)</td>
  <td>100MB (cantidad fija)</td>
</tr>
<tr>
  <td>**Total reservado**</td>
  <td>**(varía)**</td>
  <td>**1,7 GB de 16 GB totales**</td>
  <td>**10,96 GB de 256 GB totales**</td>
</tr>
</tbody>
</table>

<table summary="Reservas de CPU de nodo trabajador por nivel.">
<caption>Reservas de CPU de nodo trabajador por nivel.</caption>
<thead>
<tr>
  <th>Nivel de CPU</th>
  <th>% reservado</th>
  <th>Ejemplo de nodo trabajador `b2c.4x16` (4 núcleos)</th>
  <th>Ejemplo de nodo trabajador `mg1c.28x256` (28 núcleos)</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Primer núcleo (Núcleo 1)</td>
  <td>6% núcleos</td>
  <td>0,06 núcleos</td>
  <td>0,06 núcleos</td>
</tr>
<tr>
  <td>Siguientes 2 núcleos (Núcleos 2-3)</td>
  <td>1% núcleos</td>
  <td>0,02 núcleos</td>
  <td>0,02 núcleos</td>
</tr>
<tr>
  <td>Siguientes 2 núcleos (Núcleos 4-5)</td>
  <td>0,5% núcleos</td>
  <td>0,005 núcleos</td>
  <td>0,01 núcleos</td>
</tr>
<tr>
  <td>Núcleos restantes (Núcleos 6+)</td>
  <td>0,25% núcleos</td>
  <td>N/D</td>
  <td>0,0575 núcleos</td>
</tr>
<tr>
  <td>**Total reservado**</td>
  <td>**(varía)**</td>
  <td>**0,085 núcleos de 4 núcleos totales**</td>
  <td>**0,1475 núcleos de 28 núcleos totales**</td>
</tr>
</tbody>
</table>

## Recuperación automática para los nodos trabajadores
{: #autorecovery}

Los componentes críticos, como `containerd`, `kubelet`, `kube-proxy` y `calico`, deben ser funcionales para tener un nodo trabajador de Kubernetes en buen estado. Con el tiempo, estos componentes se pueden estropear dejando así el nodo trabajador en estado fuera de servicio. Los nodos trabajadores averiados reducen la capacidad total del clúster y pueden provocar tiempo de inactividad en la app.
{:shortdesc}

Puede [configurar comprobaciones de estado del nodo trabajador y habilitar la recuperación automática](cs_health.html#autorecovery). Si la recuperación automática detecta un nodo trabajador erróneo basado en las comprobaciones configuradas, desencadena una acción correctiva, como una recarga del sistema operativo, en el nodo trabajador. Para obtener más información sobre cómo funciona la recuperación automática, consulte el [blog sobre recuperación automática ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />

