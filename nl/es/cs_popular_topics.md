---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# Temas populares sobre {{site.data.keyword.containerlong_notm}}
{: #cs_popular_topics}

Manténgase al día con lo que está pasando con {{site.data.keyword.containerlong}}. Explore las nuevas características, obtenga consejos o conozca temas populares que otros desarrolladores ahora mismo han encontrado útiles.
{:shortdesc}

## Temas populares en diciembre de 2018
{: #dec18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en diciembre de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>6 de diciembre</td>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>Obtenga visibilidad operativa en el rendimiento y estado de las apps mediante el despliegue de Sysdig como servicio de terceros en sus nodos trabajadores para reenviar métricas a {{site.data.keyword.monitoringlong}}. Para obtener más información, consulte
[Análisis de métricas para una app desplegada en un clúster de Kubernetes](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster). **Nota**: si utiliza {{site.data.keyword.mon_full_notm}} con clústeres que ejecutan Kubernetes versión 1.11 o posterior, no se recopilan todas las métricas de contenedor, ya que actualmente Sysdig no tiene soporte para `containerd`.</td>
</tr>
</tbody></table>

## Temas populares en noviembre de 2018
{: #nov18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en noviembre de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>29 de noviembre</td>
<td>[Zona disponible en Chennai](cs_regions.html)</td>
<td>Se da la bienvenida a Chennai, India, como una nueva zona para clústeres en la región AP norte. Si tiene un cortafuegos, [abra los puertos del cortafuegos](cs_firewall.html#firewall) para esta zona y para las otras dentro de la región en la que se encuentra el clúster.</td>
</tr>
<tr>
<td>27 de noviembre</td>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>Añada prestaciones de gestión de registros al clúster desplegando LogDNA como servicio de terceros en sus nodos trabajadores para gestionar registros de sus contenedores de pod. Para obtener más información, consulte
[Gestión de registros de clúster de Kubernetes con {{site.data.keyword.loganalysisfull_notm}} con LogDNA](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube).</td>
</tr>
<tr>
<td>7 de noviembre</td>
<td>Equilibrador de carga 2.0 (beta)</td>
<td>Ahora puede elegir entre el [equilibrador de carga 1.0 o 2.0](cs_loadbalancer.html#planning_ipvs) para exponer de forma segura sus apps de clúster al público.</td>
</tr>
<tr>
<td>7 de noviembre</td>
<td>Kubernetes versión 1.12 está disponible</td>
<td>Ahora, puede actualizar o crear clústeres que ejecuten [Kubernetes versión 1.12](cs_versions.html#cs_v112). Los clústeres de la versión 1.12 se suministran con maestros de Kubernetes de alta disponibilidad de forma predeterminada.</td>
</tr>
<tr>
<td>7 de noviembre</td>
<td>Maestros de alta disponibilidad en clústeres que ejecutan Kubernetes versión 1.10</td>
<td>Los maestros de alta disponibilidad están disponibles en clústeres que ejecutan Kubernetes versión 1.10. Todas las ventajas descritas en la entrada anterior para los clústeres 1.11 se aplican a los clústeres 1.10, así como los [pasos de preparación](cs_versions.html#110_ha-masters) que debe llevar a cabo.</td>
</tr>
<tr>
<td>1 de noviembre</td>
<td>Maestros de alta disponibilidad en clústeres que ejecutan Kubernetes versión 1.11</td>
<td>En una única zona, el maestro está altamente disponible e incluye réplicas en hosts físicos independientes para que el servidor de API de Kubernetes, etcd, el planificador y el gestor de controladores puedan protegerse frente a una interrupción como, por ejemplo, la actualización del clúster. Si el clúster está en una zona con capacidad multizona, el maestro de alta disponibilidad se distribuye también en zonas para ayudar a protegerse frente a un fallo zonal.<br>Para ver las acciones que debe realizar, consulte
[Actualización a maestros de clúster de alta disponibilidad](cs_versions.html#ha-masters). Estas acciones preparatorias se aplican:<ul>
<li>Si tiene un cortafuegos o políticas de red Calico personalizadas.</li>
<li>Si utiliza los puertos de host `2040` o `2041` en sus nodos trabajadores.</li>
<li>Si ha utilizado la dirección IP del maestro del clúster para el acceso al maestro dentro del clúster.</li>
<li>Si tiene una automatización que llama a la API o a la CLI de Calico (`calicoctl`), como para crear políticas de Calico.</li>
<li>Si utiliza políticas de red de Kubernetes o Calico para controlar el acceso de salida de pod al maestro.</li></ul></td>
</tr>
</tbody></table>

## Temas populares en octubre de 2018
{: #oct18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en octubre de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>25 de octubre</td>
<td>[Zona disponible en Milán](cs_regions.html)</td>
<td>Damos la bienvenida a Milán, Italia, como nueva zona para clústeres de pago en la región UE central. Antes Milán solo estaba disponible para clústeres gratuitos. Si tiene un cortafuegos, [abra los puertos del cortafuegos](cs_firewall.html#firewall) para esta zona y para las otras dentro de la región en la que se encuentra el clúster.</td>
</tr>
<tr>
<td>22 de octubre</td>
<td>[Nueva ubicación multizona en Londres, `lon05`](cs_regions.html#zones)</td>
<td>La ciudad metropolitana de Londres multizona sustituye la zona `lon02` por la nueva zona `lon05`, una zona con más recursos de infraestructura que `lon02`. Cree nuevos clústeres multizona con `lon05`. Los clústeres existentes con `lon02` reciben soporte, pero los nuevos clústeres multizona deben utilizar `lon05` en su lugar.</td>
</tr>
<tr>
<td>5 de octubre</td>
<td>Integración con {{site.data.keyword.keymanagementservicefull}}</td>
<td>Puede cifrar secretos de Kubernetes en el clúster mediante la [habilitación de {{site.data.keyword.keymanagementserviceshort}} (beta)](cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>4 de octubre</td>
<td>Ahora [ {{site.data.keyword.registrylong}} está integrado con {{site.data.keyword.Bluemix_notm}} Identity and Access Management](/docs/services/Registry/iam.html#iam)</td>
<td>Puede utilizar {{site.data.keyword.Bluemix_notm}} IAM para controlar el acceso a los recursos de registro, como la extracción, el envío y la creación de imágenes. Cuando se crea un clúster, también se crea una señal de registro para que el clúster pueda trabajar con el registro. Por lo tanto, necesita el rol de gestión de la plataforma de **Administrador** de registro a nivel de cuenta para crear un clúster. Para habilitar {{site.data.keyword.Bluemix_notm}} IAM para su cuenta de registro, consulte [Habilitación de la imposición de políticas para los usuarios existentes](/docs/services/Registry/registry_users.html#existing_users).</td>
</tr>
<tr>
<td>1 de octubre</td>
<td>[Grupos de recursos](cs_users.html#resource_groups)</td>
<td>Puede utilizar grupos de recursos para separar sus recursos de {{site.data.keyword.Bluemix_notm}} en conductos, departamentos u otras agrupaciones para ayudar a asignar el acceso y a calibrar el uso. Ahora, {{site.data.keyword.containerlong_notm}} da soporte a la creación de clústeres en el grupo `default` o en cualquier otro grupo de recursos que cree.</td>
</tr>
</tbody></table>

## Temas populares en septiembre de 2018
{: #sept18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en septiembre de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>25 de septiembre</td>
<td>[Nuevas zonas disponibles](cs_regions.html)</td>
<td>Ahora dispone de aún más opciones en las que desplegar sus apps.
<ul><li>Damos la bienvenida a San José como dos nuevas zonas en la región de EE.UU. sur, `sjc03` y `sjc04`. Si tiene un cortafuegos, [abra los puertos del cortafuegos](cs_firewall.html#firewall) para esta zona y para las otras dentro de la región en la que se encuentra el clúster.</li>
<li>Con las dos nuevas zonas `tok04` y `tok05`, ahora puede [crear clústeres multizona](cs_clusters_planning.html#multizone) en Tokio en la región AP norte.</li></ul></td>
</tr>
<tr>
<td>05 de septiembre</td>
<td>[Zona disponible en Oslo](cs_regions.html)</td>
<td>Damos la bienvenida a Oslo, Noruega, como nueva zona en la región UE central. Si tiene un cortafuegos, [abra los puertos del cortafuegos](cs_firewall.html#firewall) para esta zona y para las otras dentro de la región en la que se encuentra el clúster.</td>
</tr>
</tbody></table>

## Temas populares en agosto de 2018
{: #aug18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en agosto de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>31 de agosto</td>
<td>{{site.data.keyword.cos_full_notm}} ahora está integrado con {{site.data.keyword.containerlong}}</td>
<td>Utilice las reclamaciones de volumen persistente (PVC) nativas de Kubernetes para suministrar {{site.data.keyword.cos_full_notm}} en el clúster. {{site.data.keyword.cos_full_notm}} se utiliza mejor para cargas de trabajo de lectura intensiva y si desea almacenar datos en varias zonas de un clúster multizona. Empiece por [crear una instancia de servicio de {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#create_cos_service) e [instalar el plugin de {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#install_cos) en el clúster. </br></br>¿No está seguro de qué solución de almacenamiento podría ser la correcta para usted? Empiece [aquí](cs_storage_planning.html#choose_storage_solution) a analizar los datos y elija la solución de almacenamiento adecuada para los datos. </td>
</tr>
<tr>
<td>14 de agosto</td>
<td>Actualice los clústeres a las versiones 1.11 de Kubernetes para asignar la prioridad de pod</td>
<td>Después de actualizar el clúster a la [versión 1.11 de Kubernetes](cs_versions.html#cs_v111), puede aprovechar las nuevas funciones, como el aumento del rendimiento del tiempo de ejecución de contenedor con `containerd` o la [asignación de prioridad de pod](cs_pod_priority.html#pod_priority).</td>
</tr>
</tbody></table>

## Temas populares en julio de 2018
{: #july18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en julio de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>30 de julio</td>
<td>[Traiga su propio controlador Ingress](cs_ingress.html#user_managed)</td>
<td>¿Tiene requisitos de seguridad específicos u otros requisitos personalizados para el controlador Ingress del clúster? Si es así, es posible que desee ejecutar su propio controlador de Ingress en lugar de utilizar el controlador predeterminado.</td>
</tr>
<tr>
<td>10 de julio</td>
<td>Incorporación de clústeres multizona</td>
<td>¿Desea mejorar la disponibilidad del clúster? Ahora puede distribuir el clúster en varias zonas en determinadas áreas metropolitanas. Para obtener más información, consulte [Creación de clústeres multizona en {{site.data.keyword.containerlong_notm}}](cs_clusters_planning.html#multizone).</td>
</tr>
</tbody></table>

## Temas populares en junio de 2018
{: #june18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en junio de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>13 de junio</td>
<td>El nombre del mandato de CLI `bx` se ha cambiado por la CLI `ic`</td>
<td>Cuando descargue la versión más reciente de la CLI de {{site.data.keyword.Bluemix_notm}}, ahora ejecute mandatos utilizando el prefijo `ic` en lugar de `bx`. Por ejemplo, para obtener una lista de clústeres, ejecute `ibmcloud ks clusters`.</td>
</tr>
<tr>
<td>12 de junio</td>
<td>[Políticas de seguridad de pod](cs_psp.html)</td>
<td>Para los clústeres que ejecutan Kubernetes 1.10.3 o posterior, puede configurar políticas de seguridad de pod para definir quién puede crear y actualizar pods en {{site.data.keyword.containerlong_notm}}.</td>
</tr>
<tr>
<td>6 de junio</td>
<td>[Soporte de TLS para el subdominio comodín de Ingress suministrado por IBM](cs_ingress.html#wildcard_tls)</td>
<td>Para los clústeres creados a partir del 6 de junio de 2018, el certificado TLS del subdominio de Ingress proporcionado por IBM ahora es un certificado comodín y se puede utilizar para el subdominio comodín registrado. Para los clústeres creados antes del 6 de junio de 2018, el certificado TLS se actualizará a un certificado comodín cuando se renueve el certificado TLS actual.</td>
</tr>
</tbody></table>

## Temas populares en mayo de 2018
{: #may18}


<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en mayo de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>24 de mayo</td>
<td>[Nuevo formato subdominio de Ingress](cs_ingress.html)</td>
<td>Los clústeres creados después del 24 de mayo son asignados a un subdominio de Ingress en el nuevo formato: <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>. Cuando se utiliza Ingress para exponer sus apps, puede utilizar el nuevo subdominio para acceder a las apps desde Internet.</td>
</tr>
<tr>
<td>14 de mayo</td>
<td>[Actualización: Despliegue en todo el mundo de cargas de trabajo en máquinas nativas con GPU](cs_app.html#gpu_app)</td>
<td>Si tiene un [tipo de máquina con GPU (Graphics Processing Unit) nativa](cs_clusters_planning.html#shared_dedicated_node) en el clúster, puede planificar apps matemáticas intensivas. El nodo trabajador con GPU puede procesar la carga de trabajo de la app tanto con la CPU como con la GPU para incrementar el rendimiento.</td>
</tr>
<tr>
<td>3 de mayo</td>
<td>[Container Image Security Enforcement (beta)](/docs/services/Registry/registry_security_enforce.html#security_enforce)</td>
<td>¿Su equipo necesita un poco más ayuda para saber qué imagen tiene que extraer en sus contenedores de app? Pruebe Container Image Security Enforcement beta para verificar las imágenes de contenedor antes de desplegarlas. Disponible para clústeres que ejecutan Kubernetes 1.9 o posterior.</td>
</tr>
<tr>
<td>01 de mayo</td>
<td>[Despliegue del panel de control de Kubernetes desde la consola](cs_app.html#cli_dashboard)</td>
<td>¿Alguna vez ha deseado acceder al panel de control de Kubernetes con una sola pulsación? Pruebe el botón **Panel de control de Kubernetes** en la consola de {{site.data.keyword.Bluemix_notm}}.</td>
</tr>
</tbody></table>




## Temas populares en abril de 2018
{: #apr18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en abril de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>17 de abril</td>
<td>{{site.data.keyword.Bluemix_notm}} Block Storage</td>
<td>Instale el [plugin](cs_storage_block.html#install_block) {{site.data.keyword.Bluemix_notm}} Block Storage para guardar datos persistentes en el almacenamiento en bloque. A continuación, puede [crear nuevo almacenamiento en bloque](cs_storage_block.html#add_block) o [utilizar almacenamiento en bloque existente](cs_storage_block.html#existing_block) para su clúster.</td>
</tr>
<tr>
<td>13 de abril</td>
<td>[Nueva guía de aprendizaje para migrar apps de Cloud Foundry a clústeres ](cs_tutorials_cf.html#cf_tutorial)</td>
<td>¿Tiene una app de Cloud Foundry? Aprenda a desplegar el mismo código de la app en un contenedor que se ejecute en un clúster de Kubernetes.</td>
</tr>
<tr>
<td>5 de abril</td>
<td>[Filtrado de registros](cs_health.html#filter-logs)</td>
<td>Filtre registros específicos al reenviarlos. Los registros se pueden filtrar por una serie de mensaje, un nivel de registro, un nombre de contenedor o un espacio de nombres específico.</td>
</tr>
</tbody></table>

## Temas populares en marzo de 2018
{: #mar18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en marzo de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>16 de marzo</td>
<td>[Suministre un clúster nativo con Trusted Compute](cs_clusters_planning.html#shared_dedicated_node)</td>
<td>Cree un clúster nativo que ejecute la [versión 1.9 de Kubernetes](cs_versions.html#cs_v19) o posterior y habilitar Trusted Compute para verificar que los nodos trabajadores no se manipulan de forma indebida.</td>
</tr>
<tr>
<td>14 de marzo</td>
<td>[Inicio de sesión seguro con {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>Mejore las apps que se ejecutan en {{site.data.keyword.containerlong_notm}} requiriendo a los usuarios que inicien sesión.</td>
</tr>
<tr>
<td>13 de marzo</td>
<td>[Zona disponible en São Paulo](cs_regions.html)</td>
<td>Damos la bienvenida a São Paulo, Brasil, como nueva zona en la región EE.UU. sur. Si tiene un cortafuegos, [abra los puertos del cortafuegos](cs_firewall.html#firewall) para esta zona y para las otras dentro de la región en la que se encuentra el clúster.</td>
</tr>
<tr>
<td>12 de marzo</td>
<td>[¿Se acaba de unir a {{site.data.keyword.Bluemix_notm}} con una cuenta de prueba? Pruebe un clúster de Kubernetes gratuito.](container_index.html#clusters)</td>
<td>Con una [cuenta de {{site.data.keyword.Bluemix_notm}} de prueba](https://console.bluemix.net/registration/), puede desplegar un clúster gratuito durante 30 días para probar las funciones de Kubernetes.</td>
</tr>
</tbody></table>

## Temas populares en febrero de 2018
{: #feb18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en febrero de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
<td>27 de febrero</td>
<td>Imágenes de máquina virtual de hardware (HVM) para nodos trabajadores</td>
<td>Aumente el rendimiento de E/S de las cargas de trabajo con imágenes de HVM. Active la función en cada nodo trabajador existente mediante el [mandato](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` o el [mandato](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>26 de febrero</td>
<td>[Escalado automático de KubeDNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS ahora se amplía con el clúster a medida que crece. Puede ajustar los índices de escalado mediante el mandato siguiente: `kubectl -n kube-system edit cm kube-dns-autoscaler`.</td>
</tr>
<tr>
<td>23 de febrero</td>
<td>Vea la consola web para los [registros](cs_health.html#view_logs) y las [métricas](cs_health.html#view_metrics)</td>
<td>Vea fácilmente los datos de registros y métricas del clúster y sus componentes con una mejor interfaz de usuario web. Consulte la página de detalles de clúster para el acceso.</td>
</tr>
<tr>
<td>20 de febrero</td>
<td>Imágenes cifradas y [contenido firmado y de confianza](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>En {{site.data.keyword.registryshort_notm}}, puede firmar y cifrar imágenes para garantizar su integridad al almacenar en el espacio de nombres del registro. Ejecute las instancias de contenedor utilizando únicamente contenido fiable.</td>
</tr>
<tr>
<td>19 de febrero</td>
<td>[Configure la VPN IPSec de strongSwan](cs_vpn.html#vpn-setup)</td>
<td>Despliegue rápidamente el diagrama de Helm de la VPN IPSec de strongSwan Helm para conectar el clúster de {{site.data.keyword.containerlong_notm}} de forma segura al centro de datos local sin un Virtual Router Appliance.</td>
</tr>
<tr>
<td>14 de febrero</td>
<td>[Zona disponible en Seúl](cs_regions.html)</td>
<td>Justo a tiempo para los Juegos Olímpicos, despliegue un clúster de Kubernetes en Seúl en la región AP norte. Si tiene un cortafuegos, [abra los puertos del cortafuegos](cs_firewall.html#firewall) para esta zona y para las otras dentro de la región en la que se encuentra el clúster.</td>
</tr>
<tr>
<td>8 de febrero</td>
<td>[Actualice Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>Revise los cambios que debe realizar en los clústeres antes de actualizar Kubernetes 1.9.</td>
</tr>
</tbody></table>

## Temas populares en enero de 2018
{: #jan18}

<table summary="La tabla muestra los temas populares. Las filas se leen de izquierda a derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Temas populares para contenedores y clústeres de Kubernetes en enero de 2018</caption>
<thead>
<th>Fecha</th>
<th>Título</th>
<th>Descripción</th>
</thead>
<tbody>
<td>25 de enero</td>
<td>[Registro global disponible](../services/Registry/registry_overview.html#registry_regions)</td>
<td>Con {{site.data.keyword.registryshort_notm}}, puede utilizar `registry.bluemix.net` global para extraer imágenes públicas proporcionadas por IBM.</td>
</tr>
<tr>
<td>23 de enero</td>
<td>[Zonas disponibles en Singapur y Montreal, CA](cs_regions.html)</td>
<td>Singapur y Montreal son zonas disponibles en las regiones AP norte y EE.UU. este de {{site.data.keyword.containerlong_notm}}. Si tiene un cortafuegos, [abra los puertos del cortafuegos](cs_firewall.html#firewall) para estas zonas y para las otras dentro de la región en la que se encuentra el clúster.</td>
</tr>
<tr>
<td>8 de enero</td>
<td>[Disponibles tipos mejorados](cs_cli_reference.html#cs_machine_types)</td>
<td>Los tipos de máquina virtual de la serie 2 incluyen cifrado de disco y almacenamiento SSD. [Traspase sus cargas de trabajo](cs_cluster_update.html#machine_type) a estos tipos para una mayor estabilidad y rendimiento.</td>
</tr>
</tbody></table>

## Chat con desarrolladores de Slack
{: #slack}

Vea de qué están hablando otros desarrolladores y realice sus propias preguntas en [{{site.data.keyword.containerlong_notm}} Slack. ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibm-container-service.slack.com)
{:shortdesc}

Si no utiliza un ID de IBM para la cuenta de {{site.data.keyword.Bluemix_notm}}, [solicite una invitación](https://bxcs-slack-invite.mybluemix.net/) a este Slack.
{: tip}
