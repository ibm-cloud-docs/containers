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



# Por qué {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containerlong}} combina contenedores Docker, la tecnología Kubernetes y una experiencia de usuario intuitiva para ofrecer herramientas potentes y funciones integradas de seguridad e identificación para automatizar el despliegue, operación, escalado y supervisión de apps contenerizadas sobre un clúster de hosts de cálculo. Para obtener información sobre certificación, consulte [Conformidad en {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/compliance).
{:shortdesc}


## Ventajas de utilizar el servicio
{: #benefits}

Los clústeres se despliegan en hosts de cálculo que proporcionan funciones de Kubernetes nativas y específicas de {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Ventaja|Descripción|
|-------|-----------|
|Clústeres de Kubernetes de un solo arrendatario con funciones de aislamiento de la infraestructura de cálculo, red y almacenamiento|<ul><li>Cree su propia infraestructura personalizada que se ajuste a los requisitos de su empresa.</li><li>Suministre un maestro de Kubernetes dedicado y seguro, nodos trabajadores, redes virtuales y almacenamiento utilizando los recursos que proporciona la infraestructura de IBM Cloud (SoftLayer).</li><li>Maestro de Kubernetes completamente gestionado que {{site.data.keyword.IBM_notm}} supervisa y actualiza continuamente para mantener el clúster disponible.</li><li>Opción para suministrar nodos trabajadores como servidores nativos con Trusted Compute.</li><li>Almacene datos persistentes, comparta datos entre pods de Kubernetes y restaure datos cuando lo necesite con el servicio de volúmenes seguro e integrado.</li><li>Aproveche el soporte de todas las API nativas de Kubernetes.</li></ul>|
| Clústeres multizona para aumentar la alta disponibilidad | <ul><li>Gestione fácilmente nodos trabajadores del mismo tipo de máquina (CPU, memoria, virtual o físico) con agrupaciones de nodos trabajadores.</li><li>Protección frente a errores de zona mediante la dispersión de nodos de forma uniforme entre varias zonas y mediante el uso de despliegues de pod de antiafinidad para sus apps.</li><li>Disminuya los costes utilizando clústeres multizona en lugar de duplicar los recursos en un clúster independiente.</li><li>Aproveche el equilibrio de carga automático entre las apps con el equilibrador de carga de varias zonas (MZLB) que se configura automáticamente en cada zona del clúster.</li></ul>|
| Maestros de alta disponibilidad | <ul>Disponibles en clústeres que ejecutan Kubernetes versión 1.10 o posterior.<li>Reduzca el tiempo de inactividad del clúster, por ejemplo, durante las actualizaciones del maestro, con maestros de alta disponibilidad que se suministran automáticamente al crear un clúster.</li><li>Disperse los maestros en zonas en un [clúster multizona](cs_clusters_planning.html#multizone) para proteger el clúster frente a errores zonales.</li></ul> |
|Conformidad de seguridad de imágenes con Vulnerability Advisor|<ul><li>Configure su propio repositorio en nuestro registro seguro de imágenes privadas de Docker donde todas las imágenes se almacenan y se comparten entre todos los usuarios de la organización.</li><li>Aproveche la exploración automática de imágenes en su registro de {{site.data.keyword.Bluemix_notm}} privado.</li><li>Revise recomendaciones específicas del sistema operativo utilizado en la imagen para solucionar vulnerabilidades potenciales.</li></ul>|
|Supervisión continua del estado del clúster|<ul><li>Utilice el panel de control del clúster para ver y gestionar rápidamente el estado del clúster, de los nodos trabajadores y de los despliegues de contenedores.</li><li>Busque métricas detalladas sobre consumo mediante {{site.data.keyword.monitoringlong}}
y expanda rápidamente su clúster para ajustarlo a las cargas de trabajo.</li><li>Revise la información de registro mediante {{site.data.keyword.loganalysislong}} para ver las actividades detalladas del clúster.</li></ul>|
|Exposición segura de apps al público|<ul><li>Elija entre una dirección IP pública, una ruta proporcionada por {{site.data.keyword.IBM_notm}} o su propio dominio personalizado para acceder a servicios del clúster desde Internet.</li></ul>|
|Integración de servicios de {{site.data.keyword.Bluemix_notm}}|<ul><li>Añada funciones adicionales a la app a través de la integración de servicios de {{site.data.keyword.Bluemix_notm}}, como por ejemplo API de Watson, Blockchain, servicios de datos o Internet de las cosas.</li></ul>|
{: caption="Ventajas de {{site.data.keyword.containerlong_notm}}" caption-side="top"}

¿Listo para empezar? Pruebe la [guía de aprendizaje para la creación de un clúster de Kubernetes](cs_tutorials.html#cs_cluster_tutorial).

<br />


## Comparación de ofertas y sus combinaciones
{: #differentiation}

{{site.data.keyword.containerlong_notm}} se puede ejecutar en {{site.data.keyword.Bluemix_notm}} Público o Dedicado, en {{site.data.keyword.Bluemix_notm}} Privado, o en una configuración híbrida.
{:shortdesc}


<table>
<caption>Diferencias entre configuraciones de {{site.data.keyword.containerlong_notm}}</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>Configuración de {{site.data.keyword.containerlong_notm}}</th>
 <th>Descripción</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Público
 </td>
 <td>Con {{site.data.keyword.Bluemix_notm}} Público en [máquinas nativas o en hardware dedicado o compartido](cs_clusters_planning.html#shared_dedicated_node), puede alojar sus apps en clústeres en la nube utilizando {{site.data.keyword.containerlong_notm}}. También puede crear un clúster con agrupaciones de nodos trabajadores en varias zonas para aumentar la alta disponibilidad de las apps. {{site.data.keyword.containerlong_notm}} en {{site.data.keyword.Bluemix_notm}} combina contenedores Docker, la tecnología
Kubernetes y una experiencia de usuario intuitiva para ofrecer herramientas potentes y funciones integradas de seguridad e identificación para automatizar el despliegue, operación, escalado y supervisión de apps contenerizadas sobre un clúster de hosts de cálculo.<br><br>Para obtener más información, consulte [Tecnología de {{site.data.keyword.containerlong_notm}}](cs_tech.html).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicado
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicado ofrece las mismas funcionalidades de {{site.data.keyword.containerlong_notm}} en la nube que {{site.data.keyword.Bluemix_notm}} Público. Sin embargo, con una cuenta de {{site.data.keyword.Bluemix_notm}} Dedicado, los [recursos físicos disponibles son dedicados únicamente a su clúster](cs_clusters_planning.html#shared_dedicated_node) y no se comparten con otros clústeres de otros clientes de {{site.data.keyword.IBM_notm}}. Es posible que elija configurar un entorno de {{site.data.keyword.Bluemix_notm}} Dedicado cuando necesite aislamiento para su clúster y otros servicios de {{site.data.keyword.Bluemix_notm}} que desee utilizar.<br><br>Para obtener más información, consulte [Iniciación a los clústeres en {{site.data.keyword.Bluemix_notm}} Dedicado](cs_dedicated.html#dedicated).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Privado
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Privado es una plataforma de aplicaciones que se puede instalar de forma local en sus propias máquinas. Utilice Kubernetes en {{site.data.keyword.Bluemix_notm}} Privado cuando necesite desarrollar y gestionar apps contenerizadas localmente en su propio entorno controlado detrás de un cortafuegos. <br><br>Para obtener más información, consulte la [documentación de producto de {{site.data.keyword.Bluemix_notm}} Privado ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).
 </td>
 </tr>
 <tr>
 <td>Configuración híbrida
 </td>
 <td>Híbrida es la utilización combinada de los servicios que se ejecutan en {{site.data.keyword.Bluemix_notm}} Público o Dedicado y otros servicios que se ejecutan de forma local como, por ejemplo, una app en {{site.data.keyword.Bluemix_notm}} Privado. Ejemplos de una configuración híbrida: <ul><li>Suministro de un clúster con {{site.data.keyword.containerlong_notm}} en {{site.data.keyword.Bluemix_notm}} Público conectando dicho clúster a una base de datos local.</li><li>Suministro de un clúster con {{site.data.keyword.containerlong_notm}} en {{site.data.keyword.Bluemix_notm}} Privado desplegando una app en dicho clúster. No obstante, esta app podría utilizar un servicio de {{site.data.keyword.ibmwatson}} como, por ejemplo, {{site.data.keyword.toneanalyzershort}}, en {{site.data.keyword.Bluemix_notm}} Público.</li></ul><br>Para habilitar la comunicación entre los servicios que se ejecutan en {{site.data.keyword.Bluemix_notm}} Público o Dedicado y los servicios que se ejecutan localmente, debe [configurar una conexión VPN](cs_vpn.html). Para obtener más información, consulte [Utilización de {{site.data.keyword.containerlong_notm}} con {{site.data.keyword.Bluemix_notm}} Privado](cs_hybrid.html).
 </td>
 </tr>
 </tbody>
</table>

<br />


## Comparación entre clústeres gratuitos y estándares
{: #cluster_types}

Puede crear un clúster gratuito o cualquier número de clústeres estándar. Pruebe los clústeres gratuitos para familiarizarse con las prestaciones de Kubernetes o cree clústeres estándares para utilizar todas las capacidades de Kubernetes para desplegar apps. Los clústeres gratuitos se suprimen automáticamente después de 30 días.
{:shortdesc}

Si tiene un clúster gratuito y desea actualizar a un clúster estándar, puede [crear un clúster estándar](cs_clusters.html#clusters_ui). A continuación, despliegue cualquier YAML para los recursos de Kubernetes que ha realizado con el clúster gratuito en el clúster estándar.

|Características|Clústeres gratuitos|Clústeres estándares|
|---------------|-------------|-----------------|
|[Redes en clúster](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Acceso a app de red pública por parte de un servicio NodePort a una dirección IP no estable](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Gestión de accesos de usuario](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Acceso al servicio {{site.data.keyword.Bluemix_notm}} desde el clúster y las apps](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Espacio de disco en nodo trabajador para almacenamiento no persistente](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
| [Posibilidad de crear un clúster en cada región de {{site.data.keyword.containerlong_notm}}](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" /> |
|[Clústeres multizona para aumentar la alta disponibilidad de las apps](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
| Maestros replicados para obtener una mayor disponibilidad (Kubernetes 1.10 o posterior) | | <img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" /> |
|[Número escalable de nodos trabajadores para aumentar la capacidad](cs_app.html#app_scaling)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Almacenamiento persistente basado en archivo NFS con volúmenes](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Acceso a app de red pública o privada por parte de un servicio de equilibrador de carga a una dirección IP estable](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Acceso a app de red pública por parte de un servicio Ingress a una dirección IP estable y un URL personalizable](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Direcciones IP públicas portátiles](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Registro y supervisión](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Opción para suministrar los nodos trabajadores en servidores físicos (nativos)](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Opción para suministrar trabajadores nativos con Trusted Compute](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
|[Disponible en {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Característica disponible" style="width:32px;" />|
{: caption="Características de los clústeres gratuitos y estándares" caption-side="top"}

<br />




## Precios y facturación
{: #pricing}

Revise algunas de las preguntas más frecuentes acerca de los precios y la facturación de {{site.data.keyword.containerlong_notm}}. Para las preguntas de nivel de cuenta, consulte la [documentación sobre gestión de facturación y uso](/docs/billing-usage/how_charged.html#charges). Para obtener detalles sobre los acuerdos de cuentas, consulte los [Términos y avisos de {{site.data.keyword.Bluemix_notm}} ](/docs/overview/terms-of-use/notices.html#terms) correspondientes.
{: shortdesc}

### ¿Cómo puedo ver y organizar mi uso?
{: #usage}

**¿Cómo puedo comprobar mi facturación y uso?**<br>
Para comprobar su uso y los totales estimados, consulte [Visualización de su uso](/docs/billing-usage/viewing_usage.html#viewingusage).

Si enlaza sus cuentas de {{site.data.keyword.Bluemix_notm}} y de la infraestructura IBM Cloud (SoftLayer), recibirá una factura consolidada. Para obtener más información, consulte [Consolidación de la facturación de cuentas enlazadas](/docs/customer-portal/linking_accounts.html#unifybillaccounts).

**¿Puedo agrupar mis recursos de nube por equipos o departamentos para fines de facturación?**<br>
Puede [utilizar grupos de recursos](/docs/resources/bestpractice_rgs.html#bp_resourcegroups) para organizar los recursos de {{site.data.keyword.Bluemix_notm}}, incluidos los clústeres, en grupos para organizar la facturación.

### ¿Cómo se me facturará? ¿Son cargos por hora o mensuales?
{: #monthly-charges}

Sus cargos dependen del tipo de recurso que utilice y pueden ser fijos, medidos, por niveles o reservados. Para obtener más información, consulte [Cómo se le carga](/docs/billing-usage/how_charged.html#charges).

Los recursos de la infraestructura IBM Cloud (SoftLayer) se pueden facturar por hora o al mes en {{site.data.keyword.containerlong_notm}}.
* Los nodos trabajadores de máquina virtual (VM) se facturan por hora.
* Los nodos trabajadores físicos (nativos) son recursos que se facturan al mes en {{site.data.keyword.containerlong_notm}}.
* Para otros recursos de la infraestructura, como por ejemplo almacenamiento de archivos o en bloque, puede elegir entre facturación por hora o al mes cuando cree el recurso.

Los recursos mensuales de un mes se facturarán el primero del mes siguiente. Si solicita un recurso mensual a mediados de mes, se le cargará una cantidad prorrateada correspondiente a ese mes. Sin embargo, si cancela un recurso a mediados de mes, se le cargará la totalidad correspondiente al recurso mensual.

### ¿Puedo calcular mis costes?
{: #estimate}

Sí, consulte [Estimación de sus costes](/docs/billing-usage/estimating_costs.html#cost) y la herramienta [estimador de costes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/pricing/). Continúe leyendo para obtener información sobre los costes que no están incluidos en el estimador de costes, como por ejemplo las redes de salida.

### ¿Qué se me facturará cuando utilice {{site.data.keyword.containerlong_notm}}?
{: #cluster-charges}

Con los clústeres de {{site.data.keyword.containerlong_notm}}, puede utilizar los recursos de cálculo, red y almacenamiento de la infraestructura IBM Cloud (SoftLayer) con servicios de plataforma como Watson AI o Componer Database-as-a-Service. Cada recurso puede implicar sus propios cargos.
* [Nodos trabajadores](#nodes)
* [Redes de salida](#bandwidth)
* [Direcciones IP de subred](#subnets)
* [Almacenamiento](#storage)
* [Servicios de {{site.data.keyword.Bluemix_notm}}](#services)

<dl>
<dt id="nodes">Nodos trabajadores</dt>
  <dd><p>Los clústeres pueden tener dos tipos principales de nodos trabajadores: máquinas virtuales o físicas (nativas). La disponibilidad y los precios de los tipos de máquina varían según la zona en la que se despliega el clúster.</p>
  <p>Las <strong>máquinas virtuales</strong> ofrecen una mayor flexibilidad, unos tiempos de suministro más reducidos y proporcionan más características automáticas de escalabilidad que las máquinas nativas. Sin embargo, las VM tienen compensaciones en cuanto a rendimiento en comparación con las especificaciones de las máquinas nativas, tales como los umbrales de Gbps de red, RAM y memoria, y las opciones de almacenamiento. Tenga en cuenta estos factores que afectan a los costes de la máquina virtual:</p>
  <ul><li><strong>Compartida frente a dedicada</strong>: si comparte el hardware subyacente de la máquina virtual, el coste es menor que el del hardware dedicado, pero los recursos físicos no están dedicados a la máquina virtual.</li>
  <li><strong>Solo facturación por hora</strong>: la facturación por hora ofrece más flexibilidad para solicitar y cancelar rápidamente máquinas virtuales.
  <li><strong>Niveles de horas al mes</strong>: la facturación por hora funciona por niveles. A medida que la VM permanezca solicitada durante un nivel de horas dentro del mes de facturación, la tasa por hora que se le factura baja. Los niveles de horas son los siguientes: 0 - 150 horas, 151 - 290 horas, 291 - 540 horas y más de 541 horas.</li></ul>
  <p>Las <strong>máquinas físicas (nativas)</strong> ofrecen grandes beneficios en cuanto a alto rendimiento para cargas de trabajo como datos, IA y GPU. Además, todos los recursos de hardware están dedicados a sus cargas de trabajo, así que no tiene "vecinos molestos". Tenga en cuenta estos factores que afectan a los costes de la máquina nativa:</p>
  <ul><li><strong>Solo facturación mensual</strong>: todas las máquinas nativas se facturan mensualmente.</li>
  <li><strong>Proceso de solicitud más largo</strong>: debido a que el pedido y la cancelación de servidores nativos son procesos manuales que se realizan a través de su cuenta de infraestructura IBM Cloud (SoftLayer), pueden tardar más de un día laborable en completarse.</li></ul>
  <p>Para obtener detalles sobre las especificaciones de la máquina, consulte [Hardware disponible para los nodos trabajadores](/docs/containers/cs_clusters_planning.html#shared_dedicated_node).</p></dd>

<dt id="bandwidth">Ancho de banda público</dt>
  <dd><p>Ancho de banda se refiere a la transferencia de datos públicos del tráfico de red de entrada y salida, tanto a como desde los recursos de {{site.data.keyword.Bluemix_notm}} de los centros de datos de todo el mundo. El ancho de banda público se carga por GB. Para revisar el resumen de ancho de banda actual, inicie una sesión en la [consola de {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), en el menú ![Icono de menú](../icons/icon_hamburger.svg "Icono de menú") seleccione **Infraestructura** y, a continuación, seleccione la página **Red > Ancho de banda > Resumen**.
  <p>Revise los factores siguientes que afectan a los cargos de ancho de banda público:</p>
  <ul><li><strong>Ubicación</strong>: al igual que sucede con los nodos trabajadores, los cargos varían en función de la zona en la que se despliegan los recursos.</li>
  <li><strong>Ancho de banda incluido o pago según uso</strong>: las máquinas de nodo trabajador pueden venir con una determinada asignación de red de salida al mes, como por ejemplo 250 GB para máquinas virtuales o 500 GB para las nativas. O bien, la asignación puede ser de tipo Pago según uso, que se basa en el uso de GB.</li>
  <li><strong>Paquetes por niveles</strong>: si sobrepasa el ancho de banda incluido, se le carga según un esquema de uso por niveles que varía según la ubicación. Si sobrepasa la asignación de un nivel, también se le puede facturar una tarifa de transferencia de datos estándar.</li></ul>
  <p>Para obtener más información, consulte [Paquetes de ancho de banda![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">Direcciones IP de subred</dt>
  <dd><p>Cuando se crea un clúster estándar, se solicita una subred pública portátil con 8 direcciones IP públicas y se carga a su cuenta mensualmente.</p><p>Si ya tiene subredes disponibles en su cuenta de infraestructura, puede utilizar estas subredes en su lugar. Cree el clúster con el [distintivo](cs_cli_reference.html#cs_cluster_create) `--no-subnets` y luego [reutilice sus subredes](cs_subnets.html#custom).</p>
  </dd>

<dt id="storage">Almacenamiento</dt>
  <dd>Cuando suministre almacenamiento, puede elegir el tipo de almacenamiento y la clase de almacenamiento adecuados para usted. Los cargos varían en función del tipo de almacenamiento, de la ubicación y de las especificaciones de la instancia de almacenamiento. Para elegir la solución de almacenamiento adecuada, consulte [Planificación del almacenamiento persistente de alta disponibilidad](cs_storage_planning.html#storage_planning). Para obtener más información, consulte:
  <ul><li>[Precios de almacenamiento de archivos NFS![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Precios de almacenamiento en bloque![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Planes de almacenamiento de objetos![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">Servicios de {{site.data.keyword.Bluemix_notm}}</dt>
  <dd>Cada servicio que integre en su clúster tiene su propio modelo de precios. Consulte la documentación de cada producto y el [estimador de costes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/pricing/) para obtener más información.</dd>

</dl>
