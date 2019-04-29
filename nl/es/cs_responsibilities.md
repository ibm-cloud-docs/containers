---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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



# Responsabilidades al utilizar {{site.data.keyword.containerlong_notm}}
Conozca las responsabilidades de gestión del clúster y los términos y las condiciones existentes para utilizar {{site.data.keyword.containerlong}}.
{:shortdesc}

## Responsabilidades de la gestión de clústeres
{: #responsibilities}

Revise las responsabilidades que comparte con IBM para gestionar sus clústeres.
{:shortdesc}

**IBM es responsable de:**

- Desplegar el maestro, los nodos trabajadores y los componentes de gestión dentro del clúster, como el equilibrador de carga de aplicación de Ingress, en el momento de la creación del clúster
- Proporcionar las actualizaciones de seguridad, la supervisión, el aislamiento y la recuperación del maestro de Kubernetes para el clúster
- Actualizar la versión y aplicar los parches de seguridad disponibles a los nodos trabajadores del clúster
- Supervisar la salud de los nodos trabajadores y proporcionar automatización para la actualización y recuperación de los nodos trabajadores
- Realizar tareas de automatización sobre su cuenta de infraestructura, incluida la adición de nodos trabajadores, la eliminación de nodos trabajadores y la creación de una subred predeterminada
- Gestionar, actualizar y recuperar los componentes operativos dentro del clúster, como por ejemplo el equilibrador de carga de aplicación de Ingress y el plugin de almacenamiento
- Suministrar volúmenes de almacenamiento cuando lo soliciten las reclamaciones de volumen persistente
- Proporcionar valores de seguridad en todos los nodos trabajadores

</br>

**El usuario es responsable de:**

- [Configuración de la clave de API de {{site.data.keyword.containerlong_notm}} con los permisos adecuados para acceder al portafolio de IBM Cloud Infrastructure (SoftLayer) y a otros servicios de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-users#api_key)
- [Desplegar y gestionar los recursos de Kubernetes, como pods, servicios y despliegues, dentro del clúster](/docs/containers?topic=containers-app#app_cli)
- [Aprovechar la capacidad del servicio y de Kubernetes para garantizar la alta disponibilidad de las apps](/docs/containers?topic=containers-app#highly_available_apps)
- [Adición o eliminación de capacidad de clúster mediante el redimensionamiento de las agrupaciones de nodos trabajadores](/docs/containers?topic=containers-clusters#add_workers)
- [Habilitación de la expansión de VLAN y mantenimiento del equilibrio de las agrupaciones de nodos trabajadores multizona entre zonas](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [Crear VLAN públicas y privadas en la infraestructura de IBM Cloud (SoftLayer) para el aislamiento de la red del clúster](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [Garantizar que todos los nodos trabajadores tienen conectividad de red con los URL de punto final del servicio Kubernetes](/docs/containers?topic=containers-firewall#firewall) <p class="note">Si un trabajador tiene VLAN tanto públicas como privadas, se configura la conectividad de red. Si los nodos trabajadores se han configurado solo con una VLAN privada, debe permitir que los nodos trabajadores y el maestro del clúster se comuniquen mediante la [habilitación del punto final de servicio privado](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) o la [configuración de un dispositivo de pasarela](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway). Si configura un cortafuegos, debe gestionar y configurar sus valores de modo que permitan el acceso a {{site.data.keyword.containerlong_notm}} y a otros servicios de {{site.data.keyword.Bluemix_notm}} que utilice con el clúster.</p>
- [La actualización del maestro kube-apiserver cuando haya disponibles actualizaciones de versión de Kubernetes](/docs/containers?topic=containers-update#master)
- [Mantenimiento actualizado de nodos trabajadores para versiones mayores, menores y parches](/docs/containers?topic=containers-update#worker_node) <p class="note">No puede cambiar el sistema operativo del nodo trabajador ni el registro en el nodo trabajador. IBM proporciona las actualizaciones de nodo trabajador como una imagen de nodo trabajador completo que incluye los parches de seguridad más recientes. Para aplicar las actualizaciones, se debe volver a crear una imagen del nodo trabajador y se debe volver a cargar con la nueva imagen. Las claves para el usuario root rotan automáticamente cuando se vuelve a cargar el nodo trabajador. </p>
- [Supervisión del estado del clúster mediante la configuración del reenvío de registros para los componentes del clúster](/docs/containers?topic=containers-health#health).   
- [Recuperar nodos trabajadores con problemas ejecutando los mandatos `kubectl`, tales como `cordon` o `drain`, y ejecutando los mandatos `ibmcloud ks`, tales como `reboot`, `reload` o `delete`](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [Añadir o eliminar subredes en la infraestructura de IBM Cloud (SoftLayer) cuando sea necesario](/docs/containers?topic=containers-subnets#subnets)
- [Hacer copia de seguridad y restaurar datos en el almacenamiento persistente en la infraestructura de IBM Cloud (SoftLayer) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- Configuración de los servicios de [registro](/docs/containers?topic=containers-health#logging) y de [supervisión](/docs/containers?topic=containers-health#view_metrics) para dar soporte al buen estado y al rendimiento del clúster
- [Configuración de la supervisión de estado de los nodos trabajadores con recuperación automática](/docs/containers?topic=containers-health#autorecovery)
- Auditoría de sucesos que cambian recursos en el clúster, por ejemplo mediante el uso de [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events), para ver las actividades iniciadas por el usuario que cambian el estado de la instancia de {{site.data.keyword.containerlong_notm}}

<br />


## Abuso en {{site.data.keyword.containerlong_notm}}
{: #terms}

Los clientes no pueden utilizar {{site.data.keyword.containerlong_notm}} de forma inapropiada.
{:shortdesc}

Entre los usos no apropiados se incluye:

*   Cualquier actividad ilegal
*   Distribuir o ejecutar malware
*   Provocar cualquier daño a {{site.data.keyword.containerlong_notm}} o interferir a cualquier usuario con la utilización de {{site.data.keyword.containerlong_notm}}
*   Provocar daños o interferir la utilización de otros usuarios con cualquier otro sistema o servicio
*   Acceder de forma no autorizada a los servicios o sistemas
*   Realizar modificaciones no autorizadas de los servicios o sistemas
*   Incumplir los derechos de terceros

Consulte [Términos de los servicios en la nube](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms) para obtener una visión general de los términos uso.
