---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks

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

# Configuración de la red de clúster
{: #cs_network_cluster}

Configure un sistema de red en el clúster de {{site.data.keyword.containerlong}}.
{:shortdesc}

Esta página le ayuda a crear la configuración de red del clúster. ¿No está seguro de qué configuración elegir? Consulte el apartado sobre [Planificación de la red de clúster](/docs/containers?topic=containers-cs_network_ov).
{: tip}

## Configuración de la red de clúster con una VLAN pública y una privada
{: #both_vlans}

Configure el clúster con acceso a [una VLAN pública y a una VLAN privada](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options).
{: shortdesc}

Esta configuración de red se compone de las siguientes configuraciones de red necesarias durante la creación del clúster y las configuraciones de red opcionales después de la creación del clúster.

1. Si crea el clúster en un entorno detrás de un cortafuegos, [permita el tráfico de red de salida a las IP públicas y privadas](/docs/containers?topic=containers-firewall#firewall_outbound) para los servicios de {{site.data.keyword.Bluemix_notm}} que tiene previsto utilizar.

2. Cree un clúster que esté conectado a una VLAN pública y una VLAN privada. Si crea un clúster multizona, puede elegir los pares de VLAN para cada zona.

3. Elija cómo se comunican los nodos maestro y trabajador de Kubernetes.
  * Si VRF está habilitado en la cuenta de {{site.data.keyword.Bluemix_notm}}, habilite puntos finales de servicio [solo públicos](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public), [públicos y privados](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both) o [solo privados.](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private).
  * Si no puede o no desea habilitar VRF, habilite
[solo el punto final de servicio público](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public) y [habilite la expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

4. Después de crear el clúster, puede configurar las siguientes opciones de red:
  * Configure un [servicio de conexión VPN de strongSwan](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_public) para permitir la comunicación entre el clúster y una red local o {{site.data.keyword.icpfull_notm}}.
  * Cree [servicios de descubrimiento de Kubernetes](/docs/containers?topic=containers-cs_network_planning#in-cluster) para permitir la comunicación en el clúster entre los pods.
  * Cree servicios [públicos](/docs/containers?topic=containers-cs_network_planning#public_access) de equilibrador de carga de red (NLB), equilibrador de carga de aplicación (ALB) de Ingress o NodePort para exponer las app a las redes públicas.
  * Cree servicios [privados](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) de equilibrador de carga de red (NLB), equilibrador de carga de aplicación (ALB) de Ingress o NodePort para exponer las app a las redes privadas y crear políticas de red Calico para proteger el clúster del acceso público.
  * Aísle las cargas de trabajo de la red en [nodos trabajadores de extremo](#both_vlans_private_edge).
  * [Aísle el clúster en la red privada](#isolate).

<br />


## Configuración de la red de clúster con una VLAN solo privada
{: #setup_private_vlan}

Si tiene requisitos de seguridad específicos o tiene que crear políticas de red y reglas de direccionamiento personalizadas para proporcionar seguridad de red dedicada, configure el clúster con acceso [solo a una VLAN privada](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options).
{: shortdesc}

Esta configuración de red se compone de las siguientes configuraciones de red necesarias durante la creación del clúster y las configuraciones de red opcionales después de la creación del clúster.

1. Si crea el clúster en un entorno detrás de un cortafuegos, [permita el tráfico de red de salida a las IP públicas y privadas](/docs/containers?topic=containers-firewall#firewall_outbound) para los servicios de {{site.data.keyword.Bluemix_notm}} que tiene previsto utilizar.

2. Cree un clúster que esté conectado [solo a una VLAN privada](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). Si crea un clúster multizona, puede elegir una VLAN privada para cada zona.

3. Elija cómo se comunican los nodos maestro y trabajador de Kubernetes.
  * Si VRF está habilitado en la cuenta de {{site.data.keyword.Bluemix_notm}}, [habilite un punto final de servicio privado](#set-up-private-se).
  * Si no puede o no desea habilitar VRF, los nodos maestro y trabajador de Kubernetes no se pueden conectar automáticamente al maestro. Debe configurar el clúster con un [dispositivo de pasarela](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private).

4. Después de crear el clúster, puede configurar las siguientes opciones de red:
  * [Configure una pasarela VPN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private) para permitir la comunicación entre el clúster y una red local o {{site.data.keyword.icpfull_notm}}. Si ya ha configurado un VRA (Vyatta) o un FSA para permitir la comunicación entre los nodos maestro y trabajador, puede configurar un punto final VPN de IPSec en el VRA o FSA.
  * Cree [servicios de descubrimiento de Kubernetes](/docs/containers?topic=containers-cs_network_planning#in-cluster) para permitir la comunicación en el clúster entre los pods.
  * Cree servicios [privados](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan) de equilibrador de carga de red (NLB), equilibrador de carga de aplicación (ALB) de Ingress o NodePort para exponer las app a las redes privadas.
  * Aísle las cargas de trabajo de la red en [nodos trabajadores de extremo](#both_vlans_private_edge).
  * [Aísle el clúster en la red privada](#isolate).

<br />


## Cambio de las conexiones de VLAN de nodo trabajador
{: #change-vlans}

Cuando cree un clúster, debe elegir si desea conectar los nodos trabajadores a una VLAN privada y pública o solo a una VLAN privada. Los nodos trabajadores forman parte de agrupaciones de nodos trabajadores, que almacenan metadatos de red que incluyen las VLAN que se utilizarán para suministrar nodos trabajadores futuros en la agrupación. Es posible que desee cambiar posteriormente la configuración de la conectividad de VLAN del clúster, en casos como los siguientes.
{: shortdesc}

* Las VLAN de la agrupación de nodos trabajadores de una zona se han quedado sin capacidad y es necesario suministrar una nueva VLAN para que los nodos trabajadores de clúster la utilicen.
* Tiene un clúster con nodos trabajadores que están en VLAN públicas y privadas, pero desea cambiar a un [clúster solo privado](#setup_private_vlan).
* Tiene un clúster solo privado, pero desea que algunos nodos trabajadores, como por ejemplo una agrupación de nodos trabajadores de [nodos de extremo](/docs/containers?topic=containers-edge#edge) en la VLAN pública, expongan las apps en Internet.

¿Está intentando cambiar el punto final de servicio para la comunicación entre maestro y trabajador? Consulte los temas para configurar puntos finales de servicio [públicos](#set-up-public-se) y [privados](#set-up-private-se).
{: tip}

Antes de empezar:
* [Inicie una sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
* Si los nodos trabajadores son autónomos (no forman parte de una agrupación de nodos trabajadores), [actualícelos a agrupaciones de nodos trabajadores](/docs/containers?topic=containers-update#standalone_to_workerpool).

Para cambiar las VLAN que utiliza una agrupación de nodos trabajadores para suministrar nodos trabajadores:

1. Obtenga una lista de los nombres de las agrupaciones de nodos trabajadores del clúster.
  ```
  ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Determine las zonas para una de las agrupaciones de nodos trabajadores. En la salida, busque el campo **Zones**.
  ```
  ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

3. Para cada zona que haya encontrado en el paso anterior, obtenga una VLAN pública y una privada disponibles que sean compatibles entre sí.

  1. Examine las VLAN públicas y privadas disponibles que se muestran bajo **Type** en la salida.
     ```
     ibmcloud ks vlans --zone <zone>
     ```
     {: pre}

  2. Compruebe que las VLAN públicas y privadas de la zona son compatibles. Para que sean compatibles, el **Router** debe tener el mismo ID de pod. En esta salida de ejemplo, los ID de pod de **Router** coinciden: `01a` y `01a`. Si un ID de pod fuese `01a` y el otro fuese `02a`, no se podrían establecer estos ID de VLAN pública y privada para la agrupación de trabajadores.
     ```
     ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
     ```
     {: screen}

  3. Si necesita solicitar una nueva VLAN pública o privada para la zona, puede hacerlo en la [consola de {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans) o puede utilizar el mandato siguiente. Recuerde que las VLAN deben ser compatibles, con ID de pod de **Router** coincidentes como en el paso anterior. Si va a crear un par de nuevas VLAN pública y privada, estas deben ser compatibles entre sí.
     ```
     ibmcloud sl vlan create -t [public|private] -d <zone> -r <compatible_router>
     ```
     {: pre}

  4. Anote los ID de las VLAN compatibles.

4. Configure una agrupación de nodos trabajadores con los nuevos metadatos de red de VLAN para cada zona. Puede crear una nueva agrupación de nodos trabajadores o puede modificar una existente.

  * **Cree una nueva agrupación de trabajadores**: Consulte [adición de nodos trabajadores mediante la creación de una nueva agrupación de nodos trabajadores](/docs/containers?topic=containers-clusters#add_pool).

  * **Modifique una agrupación de nodos trabajadores existente**: Establezca los metadatos de red de la agrupación de nodos trabajadores de modo que utilicen la VLAN para cada zona. Los nodos trabajadores que ya se han creado en la agrupación siguen utilizando las VLAN anteriores, pero los nuevos nodos trabajadores de la agrupación utilizan los nuevos metadatos de VLAN que ha definido.

    * Ejemplo para añadir VLAN tanto pública como privada, como en el caso de que se pase de solo privada a privada y pública:
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

    * Ejemplo para añadir solo una VLAN privada, como en el caso de que se pase de VLAN pública y privada a solo privada cuando se dispone de una [cuenta habilitada para VRF que utiliza puntos finales de servicio](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started):
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

5. Añada nodos trabajadores a la agrupación de nodos trabajadores cambiando el tamaño de la agrupación.
   ```
   ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

   Si desea eliminar los nodos trabajadores que utilizan los metadatos de red anteriores, cambie el número de nodos trabajadores por zona para duplicar la cantidad anterior de nodos trabajadores por zona. Más adelante en estos pasos, puede delimitar, drenar y eliminar los nodos trabajadores anteriores.
  {: tip}

6. Verifique que los nuevos nodos trabajadores se crean con la **IP pública** y la **IP privada** adecua das en la salida. Por ejemplo, si cambia la agrupación de nodos trabajadores de una VLAN pública y privada a solo privada, los nuevos nodos trabajadores solo tendrán una IP privada. Si cambia la agrupación de nodos trabajadores de solo privada a VLAN pública y privada, los nuevos nodos trabajadores tienen IP tanto públicas como privadas.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

7. Opcional: Elimine los nodos trabajadores con los metadatos de red anteriores de la agrupación de nodos trabajadores.
  1. En la salida del paso anterior, anote el **ID** y la **IP privada** de los nodos trabajadores que desea eliminar de la agrupación de nodos trabajadores.
  2. Marque el nodo trabajador como no programable en un proceso que se conoce como acordonamiento. Cuando se acordona un nodo trabajador, deja de estar disponible para programar pods en el futuro.
     ```
     kubectl cordon <worker_private_ip>
     ```
     {: pre}
  3. Verifique que la planificación de pods está inhabilitada en el nodo trabajador.
     ```
     kubectl get nodes
     ```
     {: pre}
     La planificación de pods está inhabilitada en el nodo trabajador si el estado es **`SchedulingDisabled`**.
  4. Fuerce la eliminación de los pods del nodo trabajador y vuelva a programarlos en los demás nodos trabajadores del clúster.
     ```
     kubectl drain <worker_private_ip>
     ```
     {: pre}
     Este proceso puede tardar unos minutos.
  5. Elimine el nodo trabajador. Utilice el ID de nodo trabajador que ha recuperado anteriormente.
     ```
     ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
     ```
     {: pre}
  6. Verifique que se ha eliminado el nodo trabajador.
     ```
     ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
     ```
     {: pre}

8. Opcional: Puede repetir los pasos del 2 al 7 correspondientes a cada agrupación de nodos trabajadores del clúster. Después de completar estos pasos, todos los nodos trabajadores del clúster estarán configurados con las nuevas VLAN.

<br />


## Configuración del punto final de servicio privado
{: #set-up-private-se}

En los clústeres que ejecutan Kubernetes versión 1.11 o posteriores, habilite o inhabilite el punto final de servicio privado para el clúster.
{: shortdesc}

El punto final de servicio privado hace que el maestro de Kubernetes sea de acceso privado. Los nodos trabajadores y los usuarios autorizados del clúster se pueden comunicar con el maestro de Kubernetes a través de la red privada. Para determinar si puede habilitar el punto final de servicio privado, consulte [Planificación de la comunicación entre el maestro y el trabajador](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master). Tenga en cuenta que no puede inhabilitar el punto final de servicio privado después de habilitarlo.

**Pasos para habilitarlo durante la creación del clúster**</br>
1. Habilite [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) en la cuenta de la infraestructura de IBM Cloud (SoftLayer).
2. [Habilite la cuenta de {{site.data.keyword.Bluemix_notm}} para que utilice puntos finales de servicio](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
3. Si crea el clúster en un entorno detrás de un cortafuegos, [permita el tráfico de red de salida a las IP públicas y privadas](/docs/containers?topic=containers-firewall#firewall_outbound) para los recursos de la infraestructura y para los servicios de {{site.data.keyword.Bluemix_notm}} que tiene previsto utilizar.
4. Cree un clúster:
  * [Cree un clúster con la CLI](/docs/containers?topic=containers-clusters#clusters_cli) y utilice el distintivo `--private-service-endpoint`. Si también desea habilitar el punto final de servicio público, utilice también el distintivo `--public-service-endpoint`.
  * [Cree un clúster con la IU](/docs/containers?topic=containers-clusters#clusters_ui_standard) y seleccione **Solo punto final privado**. Si desea habilitar también el punto final de servicio público, seleccione **Puntos finales públicos y privados**.
5. Si habilita el solo punto final de servicio privado para un clúster en un entorno detrás de un cortafuegos:
  1. Verifique que están en la red privada de {{site.data.keyword.Bluemix_notm}} o que está conectado a la red privada a través de una conexión VPN.
  2. [Permita a los usuarios autorizados del clúster ejecutar mandatos `kubectl`](/docs/containers?topic=containers-firewall#firewall_kubectl) para acceder al maestro a través del punto final de servicio privado. Los usuarios del clúster deben estar en la red privada de {{site.data.keyword.Bluemix_notm}} o se deben conectar a la red privada mediante una conexión VPN para poder ejecutar mandatos `kubectl`.
  3. Si el acceso de red está protegido por un cortafuegos de la empresa, debe [permitir el acceso a los puntos finales públicos para la API `ibmcloud` y la API `ibmcloud ks` en el cortafuegos](/docs/containers?topic=containers-firewall#firewall_bx). Aunque toda la comunicación con el maestro pasa por la red privada, los mandatos `ibmcloud` e `ibmcloud ks` deben
pasar por los puntos finales de la API pública.

  </br>

**Pasos para habilitarlo después de la creación del clúster**</br>
1. Habilite [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) en la cuenta de la infraestructura de IBM Cloud (SoftLayer).
2. [Habilite la cuenta de {{site.data.keyword.Bluemix_notm}} para que utilice puntos finales de servicio](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
3. Habilite el punto final de servicio privado.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
4. Renueve el servidor de API del maestro de Kubernetes para que utilice el punto final de servicio privado. Puede seguir la indicación en la CLI o puede ejecutar manualmente el mandato siguiente.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}

5. [Cree un mapa de configuración](/docs/containers?topic=containers-update#worker-up-configmap) para controlar el número máximo de nodos trabajadores que pueden no estar disponibles a la vez en el clúster. Cuando actualiza los nodos trabajadores, el mapa de correlación ayuda a evitar tiempo de inactividad para las apps a medida que las apps se replanifican de forma ordenada en los nodos trabajadores disponibles.
6. Actualice todos los nodos trabajadores del clúster para que adopten la configuración de punto final de servicio privado.

   <p class="important">Con el siguiente mandato de actualización, los nodos trabajadores se vuelven a cargar para que adopten la configuración de punto final de servicio. Si no hay ninguna actualización de nodo trabajador disponible, debe [volver a cargar manualmente los nodos trabajadores](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Si los vuelve a cargar, asegúrese de delimitar, drenar y gestionar el orden para controlar el número máximo de nodos trabajadores que no están disponibles a la vez.</p>
   ```
   ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
   ```
   {: pre}

8. Si el clúster se encuentra en un entorno detrás de un cortafuegos:
  * [Permita a los usuarios autorizados del clúster ejecutar mandatos `kubectl` para acceder al maestro a través del punto final de servicio privado.](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * [Permita el tráfico de red de salida a las IP privadas](/docs/containers?topic=containers-firewall#firewall_outbound) para los recursos de la infraestructura y para los servicios de {{site.data.keyword.Bluemix_notm}} que tiene previsto utilizar.

9. Opcional: Para utilizar solo el punto final de servicio privado, inhabilite el punto final de servicio público.
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
  </br>

**Pasos para inhabilitar**</br>
El punto final de servicio privado no se puede inhabilitar.

## Configuración de punto final de servicio público
{: #set-up-public-se}

Habilite o inhabilite el punto final de servicio público para el clúster.
{: shortdesc}

El punto final de servicio público hace que el maestro de Kubernetes sea de acceso público. Los nodos trabajadores y los usuarios autorizados del clúster se pueden comunicar de forma segura con el maestro de Kubernetes a través de la red pública. Para determinar si puede habilitar el punto final de servicio público, consulte [Planificación de la comunicación entre nodos trabajadores y el maestro de Kubernetes](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master).

**Pasos para habilitarlo durante la creación del clúster**</br>

1. Si crea el clúster en un entorno detrás de un cortafuegos, [permita el tráfico de red de salida a las IP públicas y privadas](/docs/containers?topic=containers-firewall#firewall_outbound) para los servicios de {{site.data.keyword.Bluemix_notm}} que tiene previsto utilizar.

2. Cree un clúster:
  * [Cree un clúster con la CLI](/docs/containers?topic=containers-clusters#clusters_cli) y utilice el distintivo `--public-service-endpoint`. Si también desea habilitar el punto final de servicio privado, utilice también el distintivo `--private-service-endpoint`.
  * [Cree un clúster con la IU](/docs/containers?topic=containers-clusters#clusters_ui_standard) y seleccione **Solo punto final público**. Si desea habilitar también el punto final de servicio privado, seleccione **Puntos finales públicos y privados**.

3. Si crea el clúster en un entorno detrás de un cortafuegos, [permita que los usuarios autorizados del clúster ejecuten mandatos `kubectl` para acceder al maestro solo a través del punto final de servicio público o a través de los puntos finales de servicio público y privado.](/docs/containers?topic=containers-firewall#firewall_kubectl)

  </br>

**Pasos para habilitarlo después de la creación del clúster**</br>
Si ya ha inhabilitado el punto final público, puede volver a habilitarlo.
1. Habilite el punto final de servicio público.
   ```
   ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
2. Renueve el servidor de API del maestro de Kubernetes para que utilice el punto final de servicio público. Puede seguir la indicación en la CLI o puede ejecutar manualmente el mandato siguiente.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}

   </br>

**Pasos para inhabilitar**</br>
Para inhabilitar el punto final de servicio público, primero debe habilitar el punto final de servicio privado para que los nodos trabajadores se puedan comunicar con el maestro de Kubernetes.
1. Habilite el punto final de servicio privado.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
2. Renueve el servidor de API del maestro de Kubernetes para que utilice el punto final de servicio privado siguiendo la indicación de la CLI o ejecutando manualmente el mandato siguiente.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}
3. [Cree un mapa de configuración](/docs/containers?topic=containers-update#worker-up-configmap) para controlar el número máximo de nodos trabajadores que pueden no estar disponibles a la vez en el clúster. Cuando actualiza los nodos trabajadores, el mapa de correlación ayuda a evitar tiempo de inactividad para las apps a medida que las apps se replanifican de forma ordenada en los nodos trabajadores disponibles.

4. Actualice todos los nodos trabajadores del clúster para que adopten la configuración de punto final de servicio privado.

   <p class="important">Con el siguiente mandato de actualización, los nodos trabajadores se vuelven a cargar para que adopten la configuración de punto final de servicio. Si no hay ninguna actualización de nodo trabajador disponible, debe [volver a cargar manualmente los nodos trabajadores](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Si los vuelve a cargar, asegúrese de delimitar, drenar y gestionar el orden para controlar el número máximo de nodos trabajadores que no están disponibles a la vez.</p>
   ```
   ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
   ```
  {: pre}
5. Inhabilite el punto final de servicio público.
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}

## Cómo pasar de un punto final de servicio público a un punto final de servicio privado
{: #migrate-to-private-se}

En clústeres que ejecutan Kubernetes versión 1.11 o posteriores, habilite los nodos trabajadores para que se comuniquen con el maestro a través de la red privada en lugar de la red pública habilitando el punto final de servicio privado.
{: shortdesc}

Todos los clústeres que están conectados a una VLAN pública y a una privada utilizan de forma predeterminada el punto final de servicio público. Los nodos trabajadores y los usuarios autorizados del clúster se pueden comunicar de forma segura con el maestro de Kubernetes a través de la red pública. Para permitir que los nodos trabajadores se comuniquen con el maestro de Kubernetes a través de la red privada en lugar de hacerlo a través de la red pública, puede habilitar el punto final de servicio privado. A continuación, puede inhabilitar si lo desea el punto final de servicio público.
* Si habilita el punto final de servicio privado y mantiene el punto final de servicio público también habilitado, los nodos trabajadores siempre se comunican con el maestro a través de la red privada, pero los usuarios se pueden comunicar con el maestro a través de la red pública o privada.
* Si habilita el punto final de servicio privado pero inhabilita el punto final de servicio público, los nodos trabajadores y los usuarios deben comunicarse con el maestro a través de la red privada.

Tenga en cuenta que no puede inhabilitar el punto final de servicio privado después de habilitarlo.

1. Habilite [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) en la cuenta de la infraestructura de IBM Cloud (SoftLayer).
2. [Habilite la cuenta de {{site.data.keyword.Bluemix_notm}} para que utilice puntos finales de servicio](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
3. Habilite el punto final de servicio privado.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}
4. Renueve el servidor de API del maestro de Kubernetes para que utilice el punto final de servicio privado siguiendo la indicación de la CLI o ejecutando manualmente el mandato siguiente.
   ```
   ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
   ```
   {: pre}
5. [Cree un mapa de configuración](/docs/containers?topic=containers-update#worker-up-configmap) para controlar el número máximo de nodos trabajadores que pueden no estar disponibles a la vez en el clúster. Cuando actualiza los nodos trabajadores, el mapa de correlación ayuda a evitar tiempo de inactividad para las apps a medida que las apps se replanifican de forma ordenada en los nodos trabajadores disponibles.

6.  Actualice todos los nodos trabajadores del clúster para que adopten la configuración de punto final de servicio privado.

    <p class="important">Con el siguiente mandato de actualización, los nodos trabajadores se vuelven a cargar para que adopten la configuración de punto final de servicio. Si no hay ninguna actualización de nodo trabajador disponible, debe [volver a cargar manualmente los nodos trabajadores](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Si los vuelve a cargar, asegúrese de delimitar, drenar y gestionar el orden para controlar el número máximo de nodos trabajadores que no están disponibles a la vez.</p>
    ```
    ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
    {: pre}

7. Opcional: Inhabilite el punto final de servicio público.
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## Opcional: Aislamiento de las cargas de trabajo de red en nodos trabajadores de extremo
{: #both_vlans_private_edge}

Los nodos trabajadores de extremo pueden mejorar la seguridad de su clúster al permitir el acceso externo a un número inferior de nodos trabajadores y aislar la carga de trabajo en red. Para asegurarse de que los pod de equilibrador de carga de red (NLB) y de equilibrador de carga de aplicación (ALB) de Ingress se despliegan solo en los nodos trabajadores, [etiquete los nodos trabajadores como nodos extremos](/docs/containers?topic=containers-edge#edge_nodes). Para evitar también que se ejecuten otras cargas de trabajo en los nodos de extremo, [marque los nodos de extremo](/docs/containers?topic=containers-edge#edge_workloads).
{: shortdesc}

Si el clúster está conectado a una VLAN pública pero desea bloquear el tráfico a los NodePorts públicos en los nodos trabajadores de extremo, también puede utilizar una [política de red preDNAT de Calico](/docs/containers?topic=containers-network_policies#block_ingress). El bloqueo de los puertos de los nodos garantiza que los nodos trabajadores de extremo sean los únicos nodos trabajadores que manejen el tráfico entrante.

## Opcional: Aislamiento del clúster en la red privada
{: #isolate}

Si tiene un clúster multizona, varias VLAN para un clúster de una sola zona o varias subredes en la misma VLAN, debe [habilitar la expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) o [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud)
para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Sin embargo, cuando la expansión de VLAN o VRF están habilitados, cualquier sistema que esté conectado a cualquiera de las VLAN privadas en la misma cuenta de IBM Cloud puede acceder a los trabajadores. Puede aislar el clúster multizona de otros sistemas de la red privada utilizando [Políticas de red de Calico](/docs/containers?topic=containers-network_policies#isolate_workers). Estas políticas también permiten la entrada y la salida de los rangos de IP y puertos privados que ha abierto en el cortafuegos privado.
{: shortdesc}
