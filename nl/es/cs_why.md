---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-30"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Por qué {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containershort}} combina Docker y
Kubernetes para ofrecer herramientas potentes, una interfaz intuitiva para el usuario y funciones integradas de seguridad e identificación para automatizar el despliegue, operación, escalado y supervisión de apps contenerizadas sobre un clúster de hosts de cálculo.
{:shortdesc}

## Ventajas de utilizar el servicio
{: #benefits}

Los clústeres se despliegan en hosts de cálculo que proporcionan funciones de Kubernetes nativas y específicas de {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Ventaja|Descripción|
|-------|-----------|
|Clústeres de Kubernetes de un solo arrendatario con funciones de aislamiento de la infraestructura de cálculo, red y almacenamiento|<ul><li>Cree su propia infraestructura personalizada que se ajuste a los requisitos de su empresa.</li><li>Suministre un maestro de Kubernetes dedicado y seguro, nodos trabajadores, redes virtuales y almacenamiento utilizando los recursos que proporciona la infraestructura de IBM Cloud (SoftLayer).</li><li>Maestro de Kubernetes completamente gestionado que {{site.data.keyword.IBM_notm}} supervisa y actualiza continuamente para mantener el clúster disponible.</li><li>Almacene datos permanentes, comparta datos entre pods de Kubernetes y restaure datos cuando lo necesite con el servicio de volúmenes seguro e integrado.</li><li>Aproveche el soporte de todas las API nativas de Kubernetes.</li></ul>|
|Conformidad de seguridad de imágenes con Vulnerability Advisor|<ul><li>Configure su propio registro seguro de imágenes privadas de Docker donde todas las imágenes se almacenan y se comparten entre todos los usuarios de la organización.</li><li>Aproveche la exploración automática de imágenes en su registro de {{site.data.keyword.Bluemix_notm}} privado.</li><li>Revise recomendaciones específicas del sistema operativo utilizado en la imagen para solucionar vulnerabilidades potenciales.</li></ul>|
|Supervisión continua del estado del clúster|<ul><li>Utilice el panel de control del clúster para ver y gestionar rápidamente el estado del clúster, de los nodos trabajadores y de los despliegues de contenedores.</li><li>Busque métricas detalladas sobre consumo mediante {{site.data.keyword.monitoringlong}}
y expanda rápidamente su clúster para ajustarlo a las cargas de trabajo.</li><li>Revise la información de registro mediante {{site.data.keyword.loganalysislong}} para ver las actividades detalladas del clúster.</li></ul>|
|Exposición segura de apps al público|<ul><li>Elija entre una dirección IP pública, una ruta proporcionada por {{site.data.keyword.IBM_notm}} o su propio dominio personalizado para acceder a servicios del clúster desde Internet.</li></ul>|
|Integración de servicios de {{site.data.keyword.Bluemix_notm}}|<ul><li>Añada funciones adicionales a la app a través de la integración de servicios de {{site.data.keyword.Bluemix_notm}}, como por ejemplo API de Watson, Blockchain, servicios de datos o Internet de las cosas.</li></ul>|



<br />


## Comparación entre clústeres gratuitos y estándares
{: #cluster_types}

Puede crear un clúster gratuito o cualquier número de clústeres estándar. Pruebe los clústeres gratuitos para familiarizarse y probar algunas prestaciones de Kubernetes o cree clústeres estándares para utilizar todas las capacidades de Kubernetes para desplegar apps.
{:shortdesc}

|Características|Clústeres gratuitos|Clústeres estándares|
|---------------|-------------|-----------------|
|[Redes en clúster](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Acceso a app de red pública por parte de un servicio NodePort](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Gestión de accesos de usuario](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|Acceso a los servicios de [{{site.data.keyword.Bluemix_notm}} desde el clúster y las apps](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Espacio de disco en nodo trabajador para almacenamiento](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Almacenamiento permanente basado en archivo NFS con volúmenes](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Acceso a app de red pública o privada por parte de un servicio de equilibrador de carga](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Acceso a app de red pública por parte de un servicio Ingress](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Direcciones IP públicas portables](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Registro y supervisión](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Disponible en {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|

<br />



## Responsabilidades de la gestión de clústeres
{: #responsibilities}

Revise las responsabilidades que comparte con IBM para gestionar sus clústeres.
{:shortdesc}

**IBM es responsable de:**

- Desplegar el maestro, los nodos trabajadores y los componentes de gestión dentro del clúster, como el controlador de Ingress, en el momento de la creación del clúster
- Gestionar las actualizaciones, supervisión y recuperación del maestro de Kubernetes para el clúster
- Supervisar la salud de los nodos trabajadores y proporcionar automatización para la actualización y recuperación de los nodos trabajadores
- Realizar tareas de automatización sobre su cuenta de la infraestructura, incluida la adición de nodos trabajadores, la eliminación de nodos trabajadores y la creación de una subred predeterminada
- Gestionar, actualizar y recuperar los componentes operativos dentro del clúster, como por ejemplo el controlador de Ingress y el plug-in de almacenamiento
- Suministrar volúmenes de almacenamiento cuando lo soliciten las reclamaciones de volumen permanente
- Proporcionar valores de seguridad en todos los nodos trabajadores

</br>
**El usuario es responsable de:**

- [Desplegar y gestionar los recursos de Kubernetes, como pods, servicios y despliegues, dentro del clúster](cs_app.html#app_cli)
- [Aprovechar la capacidad del servicio y de Kubernetes para garantizar la alta disponibilidad de las apps](cs_app.html#highly_available_apps)
- [Añadir o eliminar capacidad mediante la CLI para añadir o eliminar nodos trabajadores](cs_cli_reference.html#cs_worker_add)
- [Crear VLAN públicas y privadas en la infraestructura de IBM Cloud (SoftLayer) para el aislamiento de la red del clúster](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [Garantizar que todos los nodos trabajadores tienen conectividad de red con el URL maestro de Kubernetes](cs_firewall.html#firewall) <p>**Nota**: Si un trabajador tiene VLAN tanto públicas como privadas, se configura la conectividad de red. Si el nodo trabajador solo tiene una VLAN privada configurada, se necesita Vyatta para proporcionar conectividad de red.</p>
- [Determinar cuándo se deben actualizar los nodos kube-apiserver maestros y los nodos trabajadores si hay versiones principales y secundarias de Kubernetes disponibles](cs_cluster_update.html#master)
- [Recuperar nodos trabajadores con problemas ejecutando los mandatos `kubectl`, tales como `cordon` o `drain`, y ejecutando los mandatos `bx cs`, tales como `reboot`, `reload` o `delete`](cs_cli_reference.html#cs_worker_reboot)
- [Añadir o eliminar subredes en la infraestructura de IBM Cloud (SoftLayer) cuando sea necesario](cs_subnets.html#subnets)
- [Hacer copia de seguridad y restaurar datos en el almacenamiento permanente en la infraestructura de IBM Cloud (SoftLayer) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## Abuso en los contenedores
{: #terms}

Los clientes no puede utilizar {{site.data.keyword.containershort_notm}} de forma inapropiada.
{:shortdesc}

Entre los usos no apropiados se incluye:

*   Cualquier actividad ilegal
*   Distribuir o ejecutar malware
*   Provocar cualquier daño a {{site.data.keyword.containershort_notm}} o interferir a cualquier usuario con la utilización de {{site.data.keyword.containershort_notm}}
*   Provocar daños o interferir la utilización de otros usuarios con cualquier otro sistema o servicio
*   Acceder de forma no autorizada a los servicios o sistemas
*   Realizar modificaciones no autorizadas de los servicios o sistemas
*   Incumplir los derechos de terceros

Consulte [Términos de los servicios en la nube](/docs/navigation/notices.html#terms) para obtener una visión general de los términos uso.
