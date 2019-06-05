---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-15"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

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
{:gif: data-image-type='gif'}


# Configuración de clústeres y nodos trabajadores
{: #clusters}
Cree clústeres y añada nodos trabajadores para aumentar la capacidad del clúster en {{site.data.keyword.containerlong}}. ¿Aún se está familiarizando? Pruebe la [guía de aprendizaje para la creación de un clúster de Kubernetes](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial).
{: shortdesc}

## Preparación para crear clústeres
{: #cluster_prepare}

Con {{site.data.keyword.containerlong_notm}}, puede crear un entorno seguro y de alta disponibilidad para sus apps, con muchas prestaciones adicionales integradas o que se puedan configurar. Las muchas posibilidades que le ofrecen los clústeres también significan que tiene que tomar muchas decisiones cuando crea un clúster. En los pasos siguientes se describe lo que debe tener en cuenta para configurar la cuenta, los permisos, los grupos de recursos, la expansión de VLAN, el clúster configurado para zona y hardware y la información de facturación.
{: shortdesc}

La lista se divide en dos partes:
*  **Nivel de cuenta**: son los preparativos que hace el administrador y que quizás no deba cambiar cada vez que cree un clúster. Sin embargo, cada vez que cree un clúster tiene que verificar que el estado actual de nivel de cuenta es el que necesita.
*  **Nivel de clúster**: son los preparativos que afectan al clúster cada vez que se crea un clúster.

### Nivel de cuenta
{: #prepare_account_level}

Siga estos pasos para preparar su cuenta de {{site.data.keyword.Bluemix_notm}} para {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

1.  [Cree o actualice su cuenta a una cuenta de pago (Pago según uso o Suscripción de {{site.data.keyword.Bluemix_notm}}](https://cloud.ibm.com/registration/)).
2.  [Configure una clave de API de {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-users#api_key) en las regiones en las que desea crear clústeres. Asigne la clave de API con los permisos adecuados para crear clústeres:
    *  Rol de **Superusuario** para la infraestructura de IBM Cloud (SoftLayer).
    *  Rol de gestión de la plataforma de **Administrador** para {{site.data.keyword.containerlong_notm}} a nivel de cuenta.
    *  Rol de gestión de la plataforma de **Administrador** para {{site.data.keyword.registrylong_notm}} a nivel de cuenta. Si la cuenta es anterior al 4 de octubre de 2018, tiene que [habilitar las políticas de {{site.data.keyword.Bluemix_notm}} IAM para {{site.data.keyword.registryshort_notm}}](/docs/services/Registry?topic=registry-user#existing_users). Con las políticas de IAM, puede controlar el acceso a los recursos, como por ejemplo los espacios de nombres de registro.

    ¿Es el propietario de la cuenta? Si es así, ya tiene los permisos necesarios. Cuando se crea un clúster, la clave de API correspondiente a esa región y grupo de recursos se establece con las credenciales.
    {: tip}

3.  Si la cuenta utiliza varios grupos de recursos, debe decidir la estrategia de su cuenta para [gestionar grupos de recursos](/docs/containers?topic=containers-users#resource_groups). 
    *  El clúster se crea en el grupo de recursos que ha elegido como destino al iniciar la sesión en {{site.data.keyword.Bluemix_notm}}. Si no elige como destino un grupo de recursos, se establece automáticamente el grupo de recursos predeterminado.
    *  Si desea crear un clúster en un grupo de recursos distinto del predeterminado, necesitará al menos el rol **Visor** para el grupo de recursos. Si no tiene ningún rol para el grupo de recursos pero es **Administrador** del servicio dentro del grupo de recursos, el clúster se crea en el grupo de recursos predeterminado.
    *  No se puede cambiar el grupo de recursos de un clúster. Además, si necesita utilizar el mandato `ibmcloud ks cluster-service-bind` [](/docs/containers-cli-plugin?topic=containers-cli-plugin-cs_cli_reference#cs_cluster_service_bind) para [integrar con un servicio de {{site.data.keyword.Bluemix_notm}} service](/docs/containers?topic=containers-service-binding#bind-services), este servicio debe estar en el mismo grupo de recursos que el clúster. Los servicios que no utilizan grupos de recursos, como {{site.data.keyword.registrylong_notm}}, o que no necesitan enlaces a servicios, como {{site.data.keyword.la_full_notm}}, funcionan aunque el clúster se encuentre en otro grupo de recursos distinto.
    *  Si tiene previsto utilizar [{{site.data.keyword.monitoringlong_notm}} para métricas](/docs/containers?topic=containers-health#view_metrics), asigne al clúster un nombre que sea exclusivo entre todos los grupos de recursos y regiones de la cuenta para evitar conflictos de nombres de métricas.

4.  Configure las redes de la infraestructura de IBM Cloud (SoftLayer). Puede elegir entre las siguientes opciones:
    *  **Habilitada para VR**: Con direccionamiento y reenvío virtuales (VRF) y su tecnología de separación de aislamiento múltiple, puede utilizar puntos finales de servicio públicos y privados para comunicarse con el nodo maestro de Kubernetes en clústeres que ejecuten Kubernetes versión 1.11 o posteriores. Mediante el [punto final de servicio privado](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private), la comunicación entre el nodo maestro de Kubernetes y los nodos trabajadores permanece en la VLAN privada. Si desea ejecutar mandatos `kubectl` desde la máquina local sobre el clúster, debe estar conectado a la misma VLAN privada en la que se encuentra el nodo maestro de Kubernetes. Para exponer las apps a Internet, los nodos trabajadores deben estar conectados a una VLAN pública para que el tráfico de red de entrada se pueda reenviar a las apps. Para ejecutar mandatos `kubectl` en el clúster a través de Internet, puede utilizar el punto final de servicio público. Con el punto final de servicio público, el tráfico de red se direcciona a través de la VLAN pública y se protege mediante un túnel OpenVPN. Para utilizar puntos finales de servicio privados, debe habilitar la cuenta para VRF y puntos finales de servicio, lo que requiere la apertura de un caso de soporte de infraestructura de IBM Cloud (SoftLayer). Para obtener más información, consulte [Visión
general de VRF en {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) y [Habilitación de la cuenta para puntos finales de servicio](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started).
    *  **Non-VRF**: Si no desea o no puede habilitar VRF para la cuenta, los nodos trabajadores se pueden conectar automáticamente al nodo maestro de Kubernetes sobre la red pública a través del [punto final de servicio público](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public). Para proteger esta comunicación, {{site.data.keyword.containerlong_notm}} configura automáticamente una conexión OpenVPN entre el maestro de Kubernetes y el nodo trabajador cuando se crea el clúster. Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](/docs/containers?topic=containers-users#infra_access) **Red > Gestionar expansión de VLAN de red** o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

### Nivel de clúster
{: #prepare_cluster_level}

Siga los pasos para preparar la configuración del clúster.
{: shortdesc}

1.  Verifique que tiene el rol de **Administrador** de la plataforma para {{site.data.keyword.containerlong_notm}}. Para permitir que el clúster extraiga imágenes del registro privado, también necesita el rol de plataforma de **Administrador** de {{site.data.keyword.registrylong_notm}}.
    1.  En la barra de menús de la [consola de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/), pulse **Gestionar > Acceso (IAM)**.
    2.  Pulse la página **Usuarios** y, a continuación, en la tabla, selecciónese a usted mismo.
    3.  En el separador **Políticas de acceso**, confirme que el **Rol** es **Administrador**. Puede ser el **Administrador** para todos los recursos de la cuenta, o al menos para {{site.data.keyword.containershort_notm}}. **Nota**: si tiene el rol de **Administrador** para {{site.data.keyword.containershort_notm}} en un solo grupo de recursos o región en lugar de en toda la cuenta, debe tener al menos el rol de **Visor** en el nivel de cuenta para ver las VLAN de la cuenta.
    <p class="tip">Asegúrese de que el administrador de la cuenta no le asigna el rol de plataforma **Administrador** al mismo tiempo que un rol de servicio. Los roles de plataforma y de servicio se deben asignar por separado.</p>
2.  Decida entre un [clúster gratuito o estándar](/docs/containers?topic=containers-cs_ov#cluster_types). Puede crear un clúster gratuito para probar algunas de las funcionalidades durante 30 días, o crear clústeres estándares totalmente personalizables con el aislamiento de hardware que elija. Cree un clúster estándar para obtener más ventajas y controlar el rendimiento del clúster.
3.  [Planifique la configuración del clúster](/docs/containers?topic=containers-plan_clusters#plan_clusters).
    *  Decida si desea crear un clúster de [una sola zona](/docs/containers?topic=containers-plan_clusters#single_zone) o [multizona](/docs/containers?topic=containers-plan_clusters#multizone). Tenga en cuenta que los clústeres multizona solo están disponibles en determinadas ubicaciones.
    *  Si desea crear un clúster que no sea accesible públicamente, revise los [pasos de clúster privado](/docs/containers?topic=containers-plan_clusters#private_clusters) adicionales.
    *  Elija el tipo de [hardware y aislamiento](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node) que desea para los nodos trabajadores del clúster, incluida la decisión entre máquinas virtuales o nativas.
4.  Para clústeres estándares, puede [estimar el coste](/docs/billing-usage?topic=billing-usage-cost#cost) en la consola de {{site.data.keyword.Bluemix_notm}}. Para obtener más información sobre los cargos que no incluye el estimador, consulte [Precios y facturación](/docs/containers?topic=containers-faqs#charges).
5.  Si crea el clúster en un entorno detrás de un cortafuegos, [permita el tráfico de red de salida a las IP públicas y privadas](/docs/containers?topic=containers-firewall#firewall_outbound) para los servicios de {{site.data.keyword.Bluemix_notm}} que tiene previsto utilizar.
<br>
<br>

**¿Qué es lo siguiente?**
* [Creación de clústeres con la consola de {{site.data.keyword.Bluemix_notm}}](#clusters_ui)
* [Creación de clústeres con la CLI de {{site.data.keyword.Bluemix_notm}}](#clusters_cli)

## Creación de clústeres con la consola de {{site.data.keyword.Bluemix_notm}}
{: #clusters_ui}

La finalidad del clúster de Kubernetes es definir un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantengan la alta disponibilidad de las apps. Para poder desplegar una app, debe crear un clúster y establecer las definiciones de los nodos trabajadores en dicho clúster.
{:shortdesc}

¿Desea crear un clúster que utilice [puntos finales de servicio](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started) para la [comunicación entre nodo maestro y trabajador](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master)? Debe crear el clúster [mediante la CLI](#clusters_cli).
{: note}

### Creación de un clúster gratuito
{: #clusters_ui_free}

Puede utilizar 1 clúster gratuito para familiarizarse con el funcionamiento de {{site.data.keyword.containerlong_notm}}. Con los clústeres gratuitos puede aprender la terminología, completar una guía de aprendizaje y familiarizarse con el sistema antes de dar el salto a los clústeres estándares de nivel de producción. No se preocupe, seguirá disponiendo de un clúster gratuito, aunque tenga una cuenta facturable.
{: shortdesc}

Los clústeres gratuitos tienen un período de vida de 30 días. Transcurrido este periodo, el clúster caduca y el clúster y sus datos se suprimen. {{site.data.keyword.Bluemix_notm}} no hace copia de seguridad de los datos suprimidos y no se pueden restaurar. Asegúrese de realizar una copia de seguridad de los datos importantes.
{: note}

1. [Prepare la creación de un clúster](#cluster_prepare) para asegurarse de que tiene los permisos de usuario correctos y la configuración adecuada de la cuenta de {{site.data.keyword.Bluemix_notm}}, así como para decidir qué configuración de clúster y grupo de recursos desea utilizar.
2. En el [catálogo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/catalog?category=containers), seleccione
**{{site.data.keyword.containershort_notm}}** para crear un clúster.
3. Seleccione una geografía en la que desplegar el clúster. El clúster se crea en una zona dentro de esta geografía.
4. Seleccione el plan de clúster **Gratuito**.
5. Asigne un nombre al clúster. El nombre debe empezar por una letra, puede contener letras, números, guiones (-) y debe tener 35 caracteres como máximo. El nombre del clúster y la región en la que el clúster se despliega forman el nombre de dominio completo para el subdominio de Ingress. Para garantizar que el subdominio de Ingress es exclusivo dentro de una región, el nombre del clúster se puede truncar y se le puede añadir un valor aleatorio al nombre de dominio de Ingress.

6. Pulse **Crear clúster**. De forma predeterminada, se crea una agrupación de nodos trabajadores con un nodo trabajador. Verá el progreso del despliegue del nodo trabajador en el separador **Nodos trabajadores**. Cuando finalice el despliegue, podrá ver que el clúster está listo en el separador **Visión general**. Tenga en cuenta que aunque el clúster esté listo, algunas partes del clúster que utilizan otros servicios como, por ejemplo, secretos de Ingress o secretos de obtención de imágenes de registro, podrían estar aún en proceso.

    Si se cambia el nombre de dominio o el ID exclusivo asignado durante la creación, se impide que el nodo maestro de Kubernetes gestione el clúster.
    {: note}

</br>

### Creación de un clúster estándar
{: #clusters_ui_standard}

1. [Prepare la creación de un clúster](#cluster_prepare) para asegurarse de que tiene los permisos de usuario correctos y la configuración adecuada de la cuenta de {{site.data.keyword.Bluemix_notm}}, así como para decidir qué configuración de clúster y grupo de recursos desea utilizar.
2. En el [catálogo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/catalog?category=containers), seleccione
**{{site.data.keyword.containershort_notm}}** para crear un clúster.
3. Seleccione el grupo de recursos en el que desea crear el clúster.
  **Nota**:
    * Un clúster solo se puede crear en un grupo de recursos y, después de crear el clúster, no puede cambiar su grupo de recursos.
    * En el grupo de recursos predeterminado se crean automáticamente clústeres gratuitos.
    * Para crear clústeres, que no sea el predeterminado, en un grupo de recursos, debe tener al menos el [rol de **Visor**](/docs/containers?topic=containers-users#platform) para el grupo de recursos.
4. Seleccione una [ubicación de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-regions-and-zones#regions-and-zones) en la que desea desplegar el clúster. Para obtener el mejor rendimiento, seleccione la ubicación físicamente más cercana. Tenga en cuenta que, si selecciona una zona que está fuera de su país, es posible que necesite autorización legal para que se puedan almacenar datos.
5. Seleccione el plan de clúster **Estándar**. Con un clúster estándar, obtiene acceso a características como, por ejemplo, varios nodos trabajadores para obtener un entorno de alta disponibilidad.
6. Especifique los detalles de la zona.
    1. Seleccione la disponibilidad **Una sola zona** o **Multizona**. En un clúster multizona, el nodo maestro se despliega en una zona con soporte multizona y los recursos del clúster se distribuyen entre varias zonas. Las opciones pueden verse limitadas por región.
    2. Seleccione las zonas específicas en las que desea alojar el clúster. Debe seleccionar al menos 1 zona, pero puede seleccionar tantas como desee. Si selecciona más de 1 zona, los nodos trabajadores se distribuyen entre las zonas que elija, lo que le proporciona una mayor disponibilidad. Si selecciona solo 1 zona, puede [añadir zonas a su clúster](#add_zone) después de crearlo.
    3. Seleccione una VLAN pública (opcional) y una VLAN privada (obligatorio) en la cuenta de infraestructura de IBM Cloud (SoftLayer). Los nodos trabajadores se comunican entre sí a través de la VLAN privada. Para comunicarse con el nodo maestro de Kubernetes, debe configurar la conectividad pública para el nodo trabajador.  Si no tiene una VLAN pública o privada en esta zona, déjelo en blanco. Se crea automáticamente una VLAN privada y una pública. Si ya tiene VLAN y no especifica una VLAN pública, tenga en cuenta la posibilidad de configurar un cortafuegos, como por ejemplo [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra). Puede utilizar la misma VLAN para varios clústeres.
        Si los nodos trabajadores se han configurado solo con una VLAN privada, debe permitir que los nodos trabajadores y el maestro del clúster se comuniquen mediante la [habilitación del punto final de servicio privado](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) o la [configuración de un dispositivo de pasarela](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway).
        {: note}

7. Configure la agrupación de nodos trabajadores predeterminada. Las agrupaciones de nodos trabajadores son grupos de nodos trabajadores que comparten la misma configuración. Siempre puede añadir más agrupaciones de nodos trabajadores a su clúster posteriormente.

    1. Seleccione un tipo de aislamiento de hardware. La opción virtual se factura por hora, y la nativa se factura mensualmente.

        - **Virtual - Dedicado**: Los nodos trabajadores están alojados en una infraestructura que está dedicada a su cuenta. Sus recursos físicos están completamente aislados.

        - **Virtual - Compartido**: Los recursos de infraestructura, como por ejemplo el hipervisor y el hardware físico, están compartidos entre usted y otros clientes de IBM, pero cada nodo trabajador es accesible sólo por usted. Aunque esta opción es menos costosa y suficiente en la mayoría de los casos, es posible que desee verificar los requisitos de rendimiento e infraestructura con las políticas de la empresa.

        - **Nativo**: Los servidores nativos se facturan de forma mensual y su suministro lo realiza manualmente la infraestructura de IBM Cloud (SoftLayer) después de que realice el pedido, por lo que puede tardar más de un día laborable en realizarse. Los servidores nativos son más apropiados para aplicaciones de alto rendimiento que necesitan más recursos y control de host. También puede optar por habilitar [Trusted Compute](/docs/containers?topic=containers-security#trusted_compute) para verificar que los nodos trabajadores no se manipulan de forma indebida. Trusted Compute está disponible para determinados tipos de máquinas nativas. Por ejemplo, los distintos tipos de GPU `mgXc` no dan soporte a Trusted Compute. Si no habilita la confianza durante la creación del clúster pero la desea posteriormente, puede utilizar el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Una vez que habilita la confianza, no puede inhabilitarla posteriormente.

        Asegúrese de que desea suministrar una máquina nativa. Puesto que se factura mensualmente, si cancela la operación inmediatamente tras realizar un pedido por error, se le cobrará el mes completo.
        {:tip}

    2. Seleccione un tipo de máquina. El tipo de máquina define la cantidad de memoria, espacio de disco y CPU virtual que se configura en cada nodo trabajador y que está disponible para todos los contenedores. Los tipos de máquinas nativas y virtuales varían según la zona en la que se despliega el clúster. Después de crear el clúster, puede añadir distintos tipos de máquina añadiendo un nodo trabajador o una agrupación al clúster.

    3. Especifique el número de nodos trabajadores que necesita en el clúster. El número de nodos trabajadores que especifique se replica entre el número de zonas que ha seleccionado. Esto significa que si tiene 2 zonas y selecciona 3 nodos trabajadores, se suministran 6 nodos y en cada zona residen 3 nodos.

8. Dele un nombre exclusivo al clúster. **Nota**: si se cambia el nombre de dominio o el ID exclusivo asignado durante la creación, se impide que el nodo maestro de Kubernetes gestione el clúster.
9. Elija la versión del servidor de API de Kubernetes para el nodo maestro del clúster.
10. Pulse **Crear clúster**. Se crea una agrupación de nodos trabajadores con el número de nodos trabajadores que ha especificado. Verá el progreso del despliegue del nodo trabajador en el separador **Nodos trabajadores**. Cuando finalice el despliegue, podrá ver que el clúster está listo en el separador **Visión general**. Tenga en cuenta que aunque el clúster esté listo, algunas partes del clúster que utilizan otros servicios como, por ejemplo, secretos de Ingress o secretos de obtención de imágenes de registro, podrían estar aún en proceso.

**¿Qué es lo siguiente?**

Cuando el clúster esté activo y en ejecución, puede realizar las siguientes tareas:

-   Si ha creado el clúster en una zona con capacidad de multizona, distribuya los nodos trabajadores [añadiendo una zona al clúster](#add_zone).
-   [Instale las CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_install) o [inicie el terminal de Kubernetes para utilizar las CLI directamente en el navegador web](/docs/containers?topic=containers-cs_cli_install#cli_web) para empezar a trabajar con el clúster.
-   [Desplegar una app en el clúster.](/docs/containers?topic=containers-app#app_cli)
-   [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}} para almacenar y compartir imágenes de Docker con otros usuarios.](/docs/services/Registry?topic=registry-getting-started)
-   Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](/docs/containers?topic=containers-firewall#firewall) para utilizar los mandatos `ibmcloud`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.
-   [Configure el programa de escalado automático de clústeres](/docs/containers?topic=containers-ca#ca) para añadir o eliminar automáticamente nodos trabajadores de las agrupaciones de nodos trabajadores en función de las solicitudes de recursos de la carga de trabajo.
-   Controle quién puede crear pods en el clúster con las [políticas de seguridad de pod](/docs/containers?topic=containers-psp).

<br />


## Creación de clústeres con la CLI de {{site.data.keyword.Bluemix_notm}}
{: #clusters_cli}

La finalidad del clúster de Kubernetes es definir un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantengan la alta disponibilidad de las apps. Para poder desplegar una app, debe crear un clúster y establecer las definiciones de los nodos trabajadores en dicho clúster.
{:shortdesc}

### Mandatos de ejemplo de CLI `ibmcloud ks clúster-create`
{: #clusters_cli_samples}

¿Ha creado un clúster antes y solo está buscando mandatos de ejemplo rápido? Pruebe estos ejemplos.
*  **Clúster gratuito**:
   ```
   ibmcloud ks cluster-create --name my_cluster
   ```
   {: pre}
*  **Clúster estándar, máquina virtual compartida**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **Clúster estándar, nativo**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*  **Clúster estándar, máquina virtual con [puntos finales de servicio público y privado](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started) en cuentas habilitadas para VRF**:
   ```
   ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-service-endpoint --private-service-endpoint --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID>
   ```
   {: pre}
*   **Clúster estándar, sólo VLAN privada y sólo punto final de servicio privado**. Para obtener más información sobre la configuración de la red de clúster privada, consulte [Configuración de red de clúster solo con una VLAN privada](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan).
    ```
    ibmcloud ks cluster-create --name my_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --private-service-endpoint --private-vlan <private_VLAN_ID> --private-only
    ```
    {: pre}

### Pasos para crear un clúster en la CLI
{: #clusters_cli_steps}

Antes de empezar, instale la CLI de {{site.data.keyword.Bluemix_notm}} y el [plugin {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).

Para crear un clúster:

1. [Prepare la creación de un clúster](#cluster_prepare) para asegurarse de que tiene los permisos de usuario correctos y la configuración adecuada de la cuenta de {{site.data.keyword.Bluemix_notm}}, así como para decidir qué configuración de clúster y grupo de recursos desea utilizar.

2.  Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}.

    1.  Inicie una sesión y escriba sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite.

        ```
        ibmcloud login
        ```
        {: pre}

        Si tiene un ID federado, utilice `ibmcloud login --sso` para iniciar la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.
        {: tip}

    2. Si tiene varias cuentas de {{site.data.keyword.Bluemix_notm}}, seleccione la cuenta donde desea crear el clúster de Kubernetes.

    3.  Para crear clústeres en un grupo de recursos que no sea el predeterminado, seleccione como destino dicho grupo de recursos.
      **Nota**:
        * Un clúster solo se puede crear en un grupo de recursos y, después de crear el clúster, no puede cambiar su grupo de recursos.
        * Debe tener al menos el [rol de **Visor**](/docs/containers?topic=containers-users#platform) para el grupo de recursos.
        * En el grupo de recursos predeterminado se crean automáticamente clústeres gratuitos.
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4. **Clústeres gratuitos**: si desea crear un clúster gratuito en una región específica, debe elegir dicha región como destino ejecutando `ibmcloud ks region-set`.

4.  Cree un clúster. Los clústeres estándar se pueden crear en cualquier región y zona disponible. Se pueden crear clústeres gratuitos en la región que se ha fijado como destino con el mandato `ibmcloud ks region-set`, pero no se puede seleccionar la zona.

    1.  **Clústeres estándares**: revise las zonas que están disponibles. Las zonas que se muestran dependen de la región de {{site.data.keyword.containerlong_notm}} en la que ha iniciado la sesión. Para distribuir el clúster entre zonas, debe crear el clúster en una [zona con soporte multizona](/docs/containers?topic=containers-regions-and-zones#zones).
        ```
        ibmcloud ks zones
        ```
        {: pre}
        Si selecciona una zona que se encuentra fuera de su país, tenga en cuenta que es posible que se requiera autorización legal para poder almacenar datos físicamente en un país extranjero.
        {: note}

    2.  **Clústeres estándares**: Elija una zona y revise los tipos de máquinas disponibles en dicha zona. El tipo de máquina especifica los hosts de cálculo físicos o virtuales que están disponibles para cada nodo trabajador.

        -  Consulte el campo **Tipo de servidor** para elegir máquinas virtuales o físicas (nativas).
        -  **Virtual**: Las máquinas virtuales se facturan por horas y se suministran en hardware compartido o dedicado.
        -  **Físico**: Los servidores nativos se facturan de forma mensual y su suministro lo realiza manualmente la infraestructura de IBM Cloud (SoftLayer) después de que realice el pedido, por lo que puede tardar más de un día laborable en realizarse. Los servidores nativos son más apropiados para aplicaciones de alto rendimiento que necesitan más recursos y control de host.
        - **Máquinas físicas con Trusted Compute**: También puede optar por habilitar [Trusted Compute](/docs/containers?topic=containers-security#trusted_compute) para verificar que los nodos trabajadores nativos no se manipulan de forma indebida. Trusted Compute está disponible para determinados tipos de máquinas nativas. Por ejemplo, los distintos tipos de GPU `mgXc` no dan soporte a Trusted Compute. Si no habilita la confianza durante la creación del clúster pero la desea posteriormente, puede utilizar el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Una vez que habilita la confianza, no puede inhabilitarla posteriormente.
        -  **Tipos de máquina**: para decidir qué tipo de máquina desplegar, revise el núcleo, la memoria y las combinaciones de almacenamiento del [hardware del nodo trabajador disponible](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node). Después de crear el clúster, puede añadir distintos tipos de máquina física o virtual mediante la [adición de una agrupación de nodos trabajadores](#add_pool).

           Asegúrese de que desea suministrar una máquina nativa. Puesto que se factura mensualmente, si cancela la operación inmediatamente tras realizar un pedido por error, se le cobrará el mes completo.
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **Clústeres estándares**: Compruebe si ya existe una VLAN pública y privada en la infraestructura de IBM Cloud (SoftLayer) para esta cuenta.

        ```
        ibmcloud ks vlans --zone <zone>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router
        1519999   vlan   1355     private   bcr02a.dal10
        1519898   vlan   1357     private   bcr02a.dal10
        1518787   vlan   1252     public   fcr02a.dal10
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        Si ya existen una VLAN pública y privada, anote los direccionadores correspondientes. Los direccionadores de VLAN privadas siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores de VLAN públicas siempre
empiezan por <code>fcr</code> (direccionador frontal). Al crear un clúster especificando las VLAN privadas y públicas, deben coincidir el número y la combinación de letras después de dichos prefijos. En la salida de ejemplo, se puede utilizar cualquier VLAN privada con cualquier VLAN pública porque todos los direccionadores incluyen `02a.dal10`.

        Los nodos trabajadores los debe conectar a una VLAN privada y, opcionalmente, puede conectarlos a una VLAN pública. **Nota**: Si los nodos trabajadores se han configurado solo con una VLAN privada, debe permitir que los nodos trabajadores y el maestro del clúster se comuniquen mediante la [habilitación del punto final de servicio privado](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) o la [configuración de un dispositivo de pasarela](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway).

    4.  **Clústeres estándares y gratuitos**: Ejecute el mandato `cluster-create`. Puede elegir un clúster gratuito, que incluye un nodo trabajador configurado con 2 vCPU y 4 GB de memoria que se suprime de forma automática después de 30 días. Cuando se crea un clúster estándar, de forma predeterminada, los discos del nodo trabajador están cifrados en AES de 256 bits, su hardware se comparte entre varios clientes de IBM y se factura por horas de uso. </br>Ejemplo para un clúster estándar. Especifique las opciones del clúster:

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b3c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--private-service-endpoint][--public-service-endpoint] [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        Ejemplo para un clúster gratuito. Especifique el nombre del clúster:

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Componentes de cluster-create</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>El mandato para crear un clúster en la organización de {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**Clústeres estándares**: Sustituya <em>&lt;zone&gt;</em> por el ID de zona de {{site.data.keyword.Bluemix_notm}} donde desea crear el clúster. Las zonas disponibles dependen de la región de {{site.data.keyword.containerlong_notm}} en la que ha iniciado la sesión.<p class="note">Los nodos trabajadores de clúster se despliegan en esta zona. Para distribuir el clúster entre zonas, debe crear el clúster en una [zona con soporte multizona](/docs/containers?topic=containers-regions-and-zones#zones). Después de que se haya creado el clúster, puede [añadir una zona al clúster](#add_zone).</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**Clústeres estándares**: Elija un tipo de máquina. Puede desplegar los nodos trabajadores como máquinas virtuales en hardware dedicado o compartido, o como máquinas físicas en servidores nativos. Los tipos de máquinas físicas y virtuales varían según la zona en la que se despliega el clúster. Para obtener más información, consulte la documentación correspondiente al [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)`ibmcloud ks machine-type`. Para los clústeres gratuitos, no tiene que definir el tipo de máquina.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**Clústeres estándares**: El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated para tener recursos físicos disponibles dedicados solo a usted, o shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared. Este valor es opcional para clústeres estándares VM y no está disponible para clústeres gratuitos. Para los tipos de máquina nativos, especifique `dedicated`.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**Clústeres gratuitos**: No tiene que definir una VLAN pública. El clúster gratuito se conecta automáticamente a una VLAN pública propiedad de IBM.</li>
          <li>**Clústeres estándares**: Si ya tiene una VLAN pública configurada en su cuenta de infraestructura de IBM Cloud (SoftLayer) para esta zona, escriba el ID de la VLAN pública. Si desea conectar los nodos trabajadores solo a una VLAN privada, no especifique esta opción.
          <p>Los direccionadores de VLAN privadas siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores de VLAN públicas siempre
empiezan por <code>fcr</code> (direccionador frontal). Al crear un clúster especificando las VLAN privadas y públicas, deben coincidir el número y la combinación de letras después de dichos prefijos.</p>
          <p class="note">Si los nodos trabajadores se han configurado solo con una VLAN privada, debe permitir que los nodos trabajadores y el maestro del clúster se comuniquen mediante la [habilitación del punto final de servicio privado](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) o la [configuración de un dispositivo de pasarela](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway).</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Clústeres gratuitos**: No tiene que definir una VLAN privada. El clúster gratuito se conecta automáticamente a una VLAN privada propiedad de IBM.</li><li>**Clústeres estándares**: Si ya tiene una VLAN privada configurada en su cuenta de infraestructura de IBM Cloud (SoftLayer) para esta zona, escriba el ID de la VLAN privada. Si no tiene una VLAN privada en la ubicación, no especifique esta opción. {{site.data.keyword.containerlong_notm}} crea automáticamente una VLAN privada.<p>Los direccionadores de VLAN privadas siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores de VLAN públicas siempre
empiezan por <code>fcr</code> (direccionador frontal). Al crear un clúster especificando las VLAN privadas y públicas, deben coincidir el número y la combinación de letras después de dichos prefijos.</p></li>
        <li>Para crear un [clúster de solo VLAN privada](/docs/containers?topic=containers-cs_network_cluster#setup_private_vlan), incluya el distintivo `--private-vlan` y también el distintivo `--private-only` para confirmar su elección. **No** incluya los distintivos `--public-vlan` y `--public-service-endpoint`. Tenga en cuenta que para habilitar la conexión entre los nodos maestro y de trabajo, debe incluir el distintivo `--privado-service-endpoint` o configurar su propio dispositivo de pasarela propio.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Clústeres estándares y gratuitos**: Sustituya <em>&lt;name&gt;</em> por el nombre del clúster. El nombre debe empezar por una letra, puede contener letras, números, guiones (-) y debe tener 35 caracteres como máximo. El nombre del clúster y la región en la que el clúster se despliega forman el nombre de dominio completo para el subdominio de Ingress. Para garantizar que el subdominio de Ingress es exclusivo dentro de una región, el nombre del clúster se puede truncar y se le puede añadir un valor aleatorio al nombre de dominio de Ingress.
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**Clústeres estándares**: El número de nodos trabajadores que desea incluir en el clúster. Si no se especifica la opción <code>--workers</code>, se crea 1 nodo trabajador.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Clústeres estándares**: La versión de Kubernetes del nodo maestro del clúster. Este valor es opcional. Cuando no se especifica la versión, el clúster se crea con el valor predeterminado de las versiones de Kubernetes soportadas. Para ver todas las versiones disponibles, ejecute <code>ibmcloud ks kube-versions</code>.
</td>
        </tr>
        <tr>
        <td><code>--private-service-endpoint</code></td>
        <td>**Clústeres estándares en [cuentas habilitadas para VRF](/docs/services/service-endpoint?topic=service-endpoint-getting-started#getting-started)**: Habilite el [punto final de servicio privado](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) para que el maestro de Kubernetes y los nodos trabajadores se comuniquen sobre la VLAN privada. Además, puede optar por habilitar el punto final de servicio público utilizando el distintivo `--public-service-endpoint` para acceder a su clúster a través de Internet. Si solo habilita el punto final de servicio privado, debe estar conectado a la VLAN privada para comunicarse con el maestro de Kubernetes. Después de habilitar un punto final de servicio privado, no podrá inhabilitarlo más tarde.<br><br>Después de crear el clúster, puede obtener el punto final con el mandato `ibmcloud ks cluster-get <cluster_name_or_ID>`.</td>
        </tr>
        <tr>
        <td><code>--public-service-endpoint</code></td>
        <td>**Clústeres estándares**: Habilite el [punto final de servicio público](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public) para que se pueda acceder al maestro de Kubernetes a través de la red pública, por ejemplo para ejecutar mandatos `kubectl` desde el terminal. Si también incluye el distintivo `--private-service-endpoint`, [la comunicación entre el maestro y el nodo trabajador](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both) se realiza en la red privada. Posteriormente puede inhabilitar el punto final de servicio público si desea un clúster solo privado.<br><br>Después de crear el clúster, puede obtener el punto final con el mandato `ibmcloud ks cluster-get <cluster_name_or_ID>`.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Clústeres gratuitos y estándares**: De forma predeterminada, los nodos trabajadores ofrecen un [cifrado de disco](/docs/containers?topic=containers-security#encrypted_disk) AES de 256 bits. Si desea inhabilitar el cifrado, incluya esta opción.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Clústeres nativos estándares**: Habilite [Trusted Compute](/docs/containers?topic=containers-security#trusted_compute) para verificar que los nodos trabajadores nativos no se manipulan de forma indebida. Trusted Compute está disponible para determinados tipos de máquinas nativas. Por ejemplo, los distintos tipos de GPU `mgXc` no dan soporte a Trusted Compute. Si no habilita la confianza durante la creación del clúster pero la desea posteriormente, puede utilizar el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Una vez que habilita la confianza, no puede inhabilitarla posteriormente.</td>
        </tr>
        </tbody></table>

5.  Verifique que ha solicitado la creación del clúster. Para máquinas virtuales, se puede tardar varios minutos en pedir las máquinas de nodo trabajador y en configurar y suministrar el clúster en la cuenta. El suministro de las máquinas físicas nativas se realiza mediante interacción manual con la infraestructura de IBM Cloud (SoftLayer), por lo que puede tardar más de un día laborable en realizarse.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Una vez completado el suministro del clúster, el estado del clúster pasa a ser **deployed**.

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.12.7      Default
    ```
    {: screen}

6.  Compruebe el estado de los nodos trabajadores.

    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Cuando los nodos trabajadores están listos, el estado pasa a **normal** y el estado es **Ready**. Cuando el estado del nodo sea **Preparado**, podrá acceder al clúster. Tenga en cuenta que aunque el clúster esté listo, algunas partes del clúster que utilizan otros servicios como, por ejemplo, secretos de Ingress o secretos de obtención de imágenes de registro, podrían estar aún en proceso.

    A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster. Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.12.7      Default
    ```
    {: screen}

7.  Defina el clúster que ha creado como contexto para esta sesión. Siga estos pasos de configuración cada vez que de trabaje con el clúster.
    1.  Obtenga el mandato para establecer la variable de entorno y descargar los archivos de configuración de Kubernetes.

        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Cuando termine la descarga de los archivos de configuración, se muestra un mandato que puede utilizar para establecer la vía de acceso al archivo de configuración de
Kubernetes como variable de entorno.

        Ejemplo para OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  Copie y pegue el mandato que se muestra en el terminal para definir la variable de entorno `KUBECONFIG`.
    3.  Compruebe que la variable de entorno `KUBECONFIG` se haya establecido correctamente.

        Ejemplo para OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Salida:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

8.  Inicie el panel de control de Kubernetes con el puerto predeterminado `8001`.
    1.  Establezca el proxy con el número de puerto predeterminado.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Abra el siguiente URL en un navegador web para ver el panel de control de Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**¿Qué es lo siguiente?**

-   Si ha creado el clúster en una zona con capacidad de multizona, distribuya los nodos trabajadores [añadiendo una zona al clúster](#add_zone).
-   [Desplegar una app en el clúster.](/docs/containers?topic=containers-app#app_cli)
-   [Gestionar el clúster con la línea de mandatos de `kubectl`. ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubectl.docs.kubernetes.io/)
-   [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}} para almacenar y compartir imágenes de Docker con otros usuarios.](/docs/services/Registry?topic=registry-getting-started)
- Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](/docs/containers?topic=containers-firewall#firewall) para utilizar los mandatos `ibmcloud`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.
-   [Configure el programa de escalado automático de clústeres](/docs/containers?topic=containers-ca#ca) para añadir o eliminar automáticamente nodos trabajadores de las agrupaciones de nodos trabajadores en función de las solicitudes de recursos de la carga de trabajo.
-  Controle quién puede crear pods en el clúster con las [políticas de seguridad de pod](/docs/containers?topic=containers-psp).

<br />



## Adición de nodos trabajadores y de zonas a clústeres
{: #add_workers}

Para aumentar la disponibilidad de las apps, puede añadir nodos trabajadores a una zona existente o a varias zonas existentes en el clúster. Para ayudar a proteger las apps frente a anomalías de zona, puede añadir zonas al clúster.
{:shortdesc}

Cuando se crea un clúster, los nodos trabajadores se suministran en una agrupación de nodos trabajadores. Después de la creación del clúster, puede añadir más nodos trabajadores a una agrupación cambiando el tamaño de la agrupación o añadiendo más agrupaciones de nodos trabajadores. De forma predeterminada, la agrupación de nodos trabajadores existe en una zona. Los clústeres que tienen una agrupación de nodos trabajadores en una sola zona se denominan clústeres de una sola zona. Cuando se añaden más zonas al clúster, la agrupación de nodos trabajadores existe entre las zonas. Los clústeres que tienen una agrupación de trabajadores distribuida entre más de una zona se denominan clústeres multizona.

Si tiene un clúster multizona, mantenga equilibrados los recursos de los nodos trabajadores. Asegúrese de que todas las agrupaciones de nodos trabajadores estén distribuidas entre las mismas zonas y añada o elimine nodos trabajadores cambiando el tamaño de las agrupaciones en lugar de añadir nodos individuales.
{: tip}

Antes de comenzar, asegúrese de tener el rol de [**Operador** o **Administrador** de la plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform). A continuación, elija una de las secciones siguientes:
  * [Añadir nodos trabajadores cambiando el tamaño de una agrupación de nodos trabajadores existente en el clúster](#resize_pool)
  * [Añadir nodos trabajadores añadiendo al clúster una agrupación de nodos trabajadores](#add_pool)
  * [Añadir una zona al clúster y replicar los nodos trabajadores de las agrupaciones de nodos trabajadores entre varias zonas](#add_zone)
  * [En desuso: añada al clúster un nodo trabajador autónomo](#standalone)

Después de configurar la agrupación de nodos trabajadores, puede [configurar el programa de escalado automático de clústeres](/docs/containers?topic=containers-ca#ca) para añadir o eliminar automáticamente nodos trabajadores de las agrupaciones de nodos trabajadores en función de las solicitudes de recursos de la carga de trabajo.
{:tip}

### Adición de nodos trabajadores mediante el redimensionando de una agrupación de nodos trabajadores existente
{: #resize_pool}

Puede añadir o reducir el número de nodos trabajadores del clúster redimensionando una agrupación de nodos trabajadores existente, independientemente de si la agrupación de nodos trabajadores está en una zona o está distribuida entre varias zonas.
{: shortdesc}

Por ejemplo, supongamos que tiene un clúster con una agrupación de nodos trabajadores que tiene tres nodos trabajadores por zona.
* Si el clúster está en una sola zona y existe en `dal10`, la agrupación de nodos trabajadores tiene tres nodos trabajadores en `dal10`. El clúster tiene un total de tres nodos trabajadores.
* Si el clúster es multizona y existe en `dal10` y en `dal12`, la agrupación de nodos trabajadores tiene tres nodos trabajadores en `dal10` y tres nodos trabajadores en `dal12`. El clúster tiene un total de seis nodos trabajadores.

Para las agrupaciones de nodos trabajadores nativas, tenga en cuenta que la facturación es mensual. El redimensionamiento de la agrupación afectará a sus costes mensuales.
{: tip}

Para redimensionar la agrupación de nodos trabajadores, cambie el número de nodos trabajadores que la agrupación de nodos trabajadores despliega en cada zona:

1. Obtenga el nombre de la agrupación de nodos trabajadores que desea redimensionar.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Redimensione la agrupación de nodos trabajadores designando el número de nodos trabajadores que desea desplegar en cada zona. El valor mínimo es 1.
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. Verifique que se ha cambiado el tamaño de la agrupación de nodos trabajadores.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Salida de ejemplo correspondiente a una agrupación de nodos trabajadores que está en dos zonas, `dal10` y `dal12`, y que se redimensiona a dos nodos trabajadores por zona:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Adición de nodos trabajadores mediante la creación de una nueva agrupación de nodos trabajadores
{: #add_pool}

Puede añadir nodos trabajadores a un clúster creando una nueva agrupación de nodos trabajadores.
{:shortdesc}

1. Recupere las **Worker Zones** (zonas de trabajo) del clúster y elija la zona donde desea desplegar los nodos trabajadores en la agrupación de nodos trabajadores. Si tiene un clúster de una sola zona, debe utilizar la zona que puede ver en el campo **Worker Zones**. Para clústeres multizona, puede elegir cualquiera de las
**Worker Zones** existentes del clúster, o añadir una de las [ubicaciones metropolitanas multizona](/docs/containers?topic=containers-regions-and-zones#zones) de la región en la que se encuentra el clúster. Para obtener una lista de las zonas disponibles, ejecute `ibmcloud ks zones`.
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. Para cada zona, obtenga una lista de las VLAN privadas y públicas disponibles. Anote las VLAN privadas y públicas que desea utilizar. Si no tiene una VLAN privada o pública, la VLAN se crea automáticamente cuando añade una zona a la agrupación de nodos trabajadores.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3.  Para cada zona, revise los [tipos de máquina disponibles para los nodos trabajadores](/docs/containers?topic=containers-plan_clusters#shared_dedicated_node).

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. Cree una agrupación de nodos trabajadores. Si suministra una agrupación de nodos trabajadores nativos, especifique `--hardware dedicated`.
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. Verifique que la agrupación de nodos trabajadores se ha creado.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. De forma predeterminada, la adición de una agrupación de nodos trabajadores crea una agrupación sin zonas. Para desplegar nodos trabajadores en una zona, debe añadir las zonas que ha recuperado anteriormente a la agrupación de nodos trabajadores. Si desea distribuir los nodos trabajadores en varias zonas, repita este mandato para cada zona.  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

7. Verifique que los nodos trabajadores se suministran en la zona que ha añadido. Los nodos trabajadores están listos cuando el estado cambia de **provision_pending** a **normal**.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   Salida de ejemplo:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Adición de nodos trabajadores mediante la adición de una zona a una agrupación de nodos trabajadores
{: #add_zone}

Puede distribuir el clúster entre varias zonas dentro de una región mediante la adición de una zona a su agrupación de nodos trabajadores existente.
{:shortdesc}

Cuando se añade una zona a una agrupación de nodos trabajadores, los nodos trabajadores definidos en la agrupación de nodos trabajadores se suministran en la nueva zona y se tienen en cuenta para la futura planificación de la carga de trabajo. {{site.data.keyword.containerlong_notm}} añade automáticamente a cada nodo trabajador la etiqueta `failure-domain.beta.kubernetes.io/region` correspondiente a la región y la etiqueta `failure-domain.beta.kubernetes.io/zone` correspondiente a la zona. El planificador de Kubernetes utiliza estas etiquetas para distribuir los pods entre zonas de la misma región.

Si tiene varias agrupaciones de nodos trabajadores en el clúster, añada la zona a todas ellas para que los nodos trabajadores se distribuya uniformemente en el clúster.

Antes de empezar:
*  Para añadir una zona a la agrupación de nodos trabajadores, la agrupación de nodos trabajadores debe estar en una [zona con soporte multizona](/docs/containers?topic=containers-regions-and-zones#zones). Si la agrupación de nodos trabajadores no está en una zona con soporte multizona, tenga en cuenta la posibilidad de [crear una nueva agrupación de nodos trabajadores](#add_pool).
*  Si tiene varias VLAN para un clúster, varias subredes en la misma VLAN o un clúster multizona, debe habilitar la [función de direccionador virtual (VRF)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) para la cuenta de infraestructura de IBM Cloud (SoftLayer) para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para habilitar VRF, [póngase en contacto con el representante de su cuenta de la infraestructura de IBM Cloud (SoftLayer)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Si no puede o no desea habilitar VRF, habilite la [expansión de VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Para llevar a cabo esta acción, necesita el [permiso de la infraestructura](/docs/containers?topic=containers-users#infra_access) **Red > Gestionar expansión de VLAN de red** o bien puede solicitar al propietario de la cuenta que lo habilite. Para comprobar si la expansión de VLAN ya está habilitada, utilice el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

Para añadir una zona con nodos trabajadores a la agrupación de nodos trabajadores:

1. Obtenga una lista de las zonas disponibles y elija la zona que desea añadir a la agrupación de nodos trabajadores. La zona que elija debe ser una zona con soporte multizona.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Obtenga una lista de las VLAN de dicha zona. Si no tiene una VLAN privada o pública, la VLAN se crea automáticamente cuando añade una zona a la agrupación de nodos trabajadores.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. Obtenga una lista de las agrupaciones de nodos trabajadores de su clúster y anote sus nombres.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. Añada la zona a la agrupación de nodos trabajadores. Si tiene varias agrupaciones de nodos trabajadores, añada la zona a todas las agrupaciones de nodos trabajadores de forma que el clúster quede equilibrado en todas las zonas. Sustituya `<pool1_id_or_name,pool2_id_or_name,...>` por los nombres de todas sus agrupaciones de nodos trabajadores en una lista separada por comas.

    Debe existir una VLAN privada y pública para que pueda añadir una zona a varias agrupaciones de nodos trabajadores. Si no tiene una VLAN privada y pública en dicha zona, añada primero la zona a una agrupación de nodos trabajadores para que se cree una VLAN privada y pública. A continuación, puede añadir la zona a otras agrupaciones de nodos trabajadores especificando la VLAN privada y pública que se ha creado automáticamente.
    {: note}

   Si desea utilizar distintas VLAN para distintas agrupaciones de nodos trabajadores, repita este mandato para cada VLAN y sus agrupaciones de nodos trabajadores correspondientes. Los nuevos nodos trabajadores se añaden a las VLAN que especifique, pero las VLAN de los nodos trabajadores existentes no se modifican.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. Verifique que la zona se ha añadido al clúster. Busque la zona añadidos en el campo **Worker zones** de la información de salida. Observe que el número total de nodos trabajadores del campo **Workers** ha aumentado ya que se han suministrado nuevos nodos trabajadores en la zona que se ha añadido.
  ```
  ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Salida de ejemplo:
  ```
  Name:                           mycluster
  ID:                             df253b6025d64944ab99ed63bb4567b6
  State:                          normal
  Created:                        2018-09-28T15:43:15+0000
  Location:                       dal10
  Master URL:                     https://c3.<region>.containers.cloud.ibm.com:30426
  Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
  Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
  Master Location:                Dallas
  Master Status:                  Ready (21 hours ago)
  Ingress Subdomain:              mycluster.us-south.containers.appdomain.cloud
  Ingress Secret:                 mycluster
  Workers:                        6
  Worker Zones:                   dal10, dal12
  Version:                        1.11.3_1524
  Owner:                          owner@email.com
  Monitoring Dashboard:           ...
  Resource Group ID:              a8a12accd63b437bbd6d58fb6a462ca7
  Resource Group Name:            Default
  ```
  {: screen}  

### En desuso: Adición de nodos trabajadores autónomos
{: #standalone}

Si tiene un clúster que se ha creado antes de la introducción de las agrupaciones de nodos trabajadores, puede utilizar los mandatos en desuso para añadir nodos trabajadores autónomos.
{: deprecated}

Si tiene un clúster que se ha creado después de que se hayan incorporado las agrupaciones de nodos trabajadores, no puede añadir nodos trabajadores autónomos. En su lugar, puede [crear una agrupación de nodos trabajadores](#add_pool), [redimensionar la agrupación de nodos trabajadores existente](#resize_pool) o [añadir una zona a una agrupación de nodos trabajadores](#add_zone) para añadir nodos trabajadores al clúster.
{: note}

1. Obtenga una lista de las zonas disponibles y elija la zona en la desea añadir nodos trabajadores.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Obtenga una lista de las VLAN disponibles en dicha zona y anote sus ID.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. Obtenga una lista de los tipos de máquina de dicha zona.
   ```
   ibmcloud ks machine-types --zone <zone>
   ```
   {: pre}

4. Añada nodos trabajadores autónomos al clúster. Para los tipos de máquina nativos, especifique `dedicated`.
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. Verifique que los nodos trabajadores se han creado.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
   {: pre}

<br />


## Visualización de estados de clúster
{: #states}

Revise el estado de un clúster de Kubernetes para obtener información sobre la disponibilidad y la capacidad del clúster, y posibles problemas que puedan haberse producido.
{:shortdesc}

Para ver información sobre un clúster específico, como sus zonas, los URL de punto final de servicio, el subdominio de Ingress, la versión, el propietario y el panel de control de supervisión, utilice el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get) `ibmcloud ks cluster-get <cluster_name_or_ID>`. Incluya el distintivo `--showResources` para ver más recursos de clúster, como complementos para pods de almacenamiento o VLAN de subred para IP públicas y privadas.

Puede ver el estado actual del clúster ejecutando el mandato `ibmcloud ks clusters` y localizando el campo **State**. Para resolver el clúster y los nodos trabajadores, consulte [Resolución de problemas de clústeres](/docs/containers?topic=containers-cs_troubleshoot#debug_clusters).

<table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
<caption>Estados de clúster</caption>
   <thead>
   <th>Estado del clúster</th>
   <th>Descripción</th>
   </thead>
   <tbody>
<tr>
   <td>Terminado anormalmente</td>
   <td>El usuario ha solicitado la supresión del clúster antes de desplegar el maestro de Kubernetes. Una vez realizada la supresión del clúster, el clúster se elimina del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
 <tr>
     <td>Crítico</td>
     <td>No se puede acceder al maestro de Kubernetes o todos los nodos trabajadores del clúster están inactivos. </td>
    </tr>
   <tr>
     <td>Error al suprimir</td>
     <td>No se puede suprimir el maestro de Kubernetes o al menos un nodo trabajador.  </td>
   </tr>
   <tr>
     <td>Suprimido</td>
     <td>El clúster se ha suprimido pero todavía no se ha eliminado del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Suprimiendo</td>
   <td>El clúster se está suprimiendo y la infraestructura del clúster se está desmontando. No puede acceder al clúster.  </td>
   </tr>
   <tr>
     <td>Error al desplegar</td>
     <td>El despliegue del maestro de Kubernetes no se ha podido realizar. No puede resolver este estado. Póngase en contacto con el equipo de soporte de IBM Cloud abriendo un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Despliegue</td>
       <td>El maestro de Kubernetes no está completamente desplegado. No puede acceder a su clúster. Espere hasta que el clúster se haya desplegado por completo para revisar el estado del clúster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster. Este estado se considera correcto y no requiere ninguna acción por su parte.<p class="note">Aunque los nodos trabajadores podrían poseer un estado normal, otros recursos de infraestructura como, por ejemplo la [red](/docs/containers?topic=containers-cs_troubleshoot_network) y el [almacenamiento](/docs/containers?topic=containers-cs_troubleshoot_storage), podrían requerir su atención. Si acaba de crear el clúster, algunas partes del clúster que utilizan otros servicios como, por ejemplo, secretos de Ingress o secretos de obtención de imágenes de registro, podrían estar aún en proceso.</p></td>
    </tr>
      <tr>
       <td>Pendiente</td>
       <td>El maestro de Kubernetes está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.  </td>
     </tr>
   <tr>
     <td>Solicitado</td>
     <td>Se ha enviado una solicitud para crear el clúster y pedir la infraestructura para el maestro de Kubernetes y los nodos trabajadores. Cuando se inicia el despliegue del clúster, el estado del clúster cambia a <code>Desplegando</code>. Si el clúster está bloqueado en el estado <code>Solicitado</code> durante mucho tiempo, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
     <td>Actualizando</td>
     <td>El servidor de API de Kubernetes que se ejecuta en el maestro de Kubernetes está siendo actualizado a una versión nueva de API de Kubernetes. Durante la actualización, no puede acceder ni cambiar el clúster. Los nodos trabajadores, apps y recursos que el usuario despliega no se modifican y continúan en ejecución. Espere a que la actualización se complete para revisar el estado del clúster. </td>
   </tr>
    <tr>
       <td>Aviso</td>
       <td>Al menos un nodo trabajador del clúster no está disponible, pero los otros nodos trabajadores están disponibles y pueden asumir la carga de trabajo. </td>
    </tr>
   </tbody>
 </table>


<br />


## Eliminación de clústeres
{: #remove}

Los clústeres gratuitos y estándares que se han creado con una cuenta facturable se deben eliminar manualmente cuando ya no sean necesarios, de manera que dichos clústeres ya no consuman recursos.
{:shortdesc}

<p class="important">
No se crean copias de seguridad del clúster ni de los datos del almacén persistente. Cuando se suprime un clúster, puede optar por suprimir el almacenamiento persistente. El almacenamiento persistente que se ha suministrado mediante una clase de almacenamiento `delete` se suprime de forma permanente en la infraestructura de IBM Cloud (SoftLayer) si elige suprimir el almacenamiento persistente. Si ha suministrado el almacenamiento persistente mediante una clase de almacenamiento `retain` y ha elegido suprimir el almacenamiento, se suprimen el clúster, el PV y la PVC, pero la instancia de almacenamiento persistente de la cuenta de infraestructura de IBM Cloud (SoftLayer) permanece.</br>
</br>Cuando se elimina un clúster, también se eliminan todas las subredes suministradas de forma automática al crear el clúster con el mandato `ibmcloud ks cluster-subnet-create`. Sin embargo, si ha añadido de forma manual subredes existentes al clúster con el mandato `ibmcloud ks cluster-subnet-add`, estas subredes no se eliminan de su cuenta (SoftLayer) de la infraestructura IBM Cloud y podrá reutilizarlas en otros clústeres.</p>

Antes de empezar:
* Anote el ID de clúster. Podría necesitar el ID de clúster para investigar y eliminar recursos (Softlayer) de la infraestructura IBM Cloud que no se suprimen de forma automática al suprimir su clúster.
* Si desea suprimir los datos en el almacenamiento persistente, [debe comprender las opciones de supresión](/docs/containers?topic=containers-cleanup#cleanup).
* Asegúrese de tener el rol de [**Administrador** de la plataforma {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform).

Para eliminar un clúster:

-   Desde la consola de {{site.data.keyword.Bluemix_notm}}
    1.  Seleccione el clúster y pulse **Suprimir** en el menú **Más acciones...**.

-   Desde la CLI de {{site.data.keyword.Bluemix_notm}}
    1.  Liste los clústeres disponibles.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  Suprima el clúster.

        ```
        ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
        ```
        {: pre}

    3.  Siga las indicaciones y decidir si desea suprimir los recursos del clúster (contenedores, pods, servicios enlazados, almacenamiento persistente y secretos).
      - **Almacenamiento persistente**: El almacenamiento persistente proporciona alta disponibilidad a los datos. Si ha creado una reclamación de volumen persistente utilizando una [compartición de archivo existente](/docs/containers?topic=containers-file_storage#existing_file), no puede suprimir la compartición de archivo al suprimir el clúster. Suprima manualmente la compartición de archivo desde el portafolio de infraestructura de IBM Cloud (SoftLayer).

          Debido al ciclo de facturación mensual, una reclamación de volumen persistente no se puede suprimir el último día del mes. Si suprime la reclamación de volumen persistente el último día del mes, la supresión permanece pendiente hasta el principio del siguiente mes.
          {: note}

Pasos siguientes:
- Después de que deje de aparecer en la lista de clústeres disponibles, al ejecutar el mandato `ibmcloud ks clusters`, podrá reutilizar el nombre de un clúster eliminado.
- Si ha conservado las subredes, puede [reutilizarlas en un nuevo clúster](/docs/containers?topic=containers-subnets#subnets_custom) o suprimirlas de forma manual más tarde de su portafolio de infraestructura de IBM Cloud (SoftLayer).
- Si ha conservado el almacenamiento persistente, puede [suprimir el almacenamiento](/docs/containers?topic=containers-cleanup#cleanup) más tarde a través el panel de control de infraestructura IBM Cloud (SoftLayer) en la consola de {{site.data.keyword.Bluemix_notm}}.
