---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}


# Notas del release
{: #iks-release}

Utilice las notas del release para conocer los cambios más recientes en la documentación de {{site.data.keyword.containerlong}}, agrupados por mes.
{:shortdesc}

Los iconos siguientes se utilizan para indicar si una nota del release se aplica a una plataforma de contenedor determinada. Si no se utiliza ningún icono, la nota de release se aplica tanto a los clústeres de la comunidad Kubernetes como a los clústeres de OpenShift.<br>
<img src="images/logo_kubernetes.svg" alt="icono de Kubernetes" width="15" style="width:15px; border-style: none"/> Solo se aplica a los clústeres de la comunidad Kubernetes.<br>
<img src="images/logo_openshift.svg" alt="icono de OpenShift" width="15" style="width:15px; border-style: none"/> Solo se aplica a clústeres de OpenShift, con fecha de lanzamiento beta el 5 de junio del 2019.
{: note}

## Agosto de 2019
{: #aug19}

<table summary="La tabla muestra las notas del release. Las filas se leen de izquierda derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Actualizaciones de la documentación en agosto de 2019</caption>
<thead>
<th>Fecha</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
  <td>01 de agosto de 2019</td>
  <td><img src="images/logo_openshift.svg" alt="icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: Red Hat OpenShift on IBM Cloud tiene disponibilidad general a partir del 1 de agosto de 2019 a las 0:00 UTC. Cualquier clúster beta caduca en un plazo de 30 días. Puede [crear un clúster de GA](/docs/openshift?topic=openshift-openshift_tutorial) y, a continuación, volver a desplegar las apps que utilice en los clústeres beta antes de eliminar los clústeres beta.<br><br>Puesto que la lógica de {{site.data.keyword.containerlong_notm}} y la infraestructura de nube subyacente es la misma, muchos temas se reutilizan entre la documentación de los clústeres de [la comunidad Kubernetes](/docs/containers?topic=containers-getting-started) y de [OpenShift](/docs/openshift?topic=openshift-getting-started), como por ejemplo este tema de notas del release.</td>
</tr>
</tbody></table>

## Julio de 2019
{: #jul19}

<table summary="La tabla muestra las notas del release. Las filas se leen de izquierda derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Actualizaciones de la documentación de {{site.data.keyword.containerlong_notm}} en julio de 2019</caption>
<thead>
<th>Fecha</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
  <td>30 de julio de 2019</td>
  <td><ul>
  <li><strong>Registro de cambios de CLI</strong>: se ha actualizado la página de registro de cambios de plugin de CLI de {{site.data.keyword.containerlong_notm}} para el [release de la versión 0.3.95](/docs/containers?topic=containers-cs_cli_changelog).</li>
  <li><strong>Registro de cambios de Ingress ALB</strong>: se ha actualizado la imagen `nginx-ingress` de ALB para la compilación 515 para la [comprobación de preparación del pod de ALB](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Eliminación de subredes de un clúster</strong>: se han añadido pasos para eliminar las subredes [en una cuenta de infraestructura de IBM Cloud](/docs/containers?topic=containers-subnets#remove-sl-subnets) o [en una red local](/docs/containers?topic=containers-subnets#remove-user-subnets) desde un clúster. </li>
  </ul></td>
</tr>
<tr>
  <td>26 de julio de 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: Se han añadido temas sobre [integraciones](/docs/openshift?topic=openshift-openshift_integrations), [ubicaciones](/docs/openshift?topic=openshift-regions-and-zones) y [restricciones del contexto de seguridad](/docs/openshift?topic=openshift-openshift_scc). Se han añadido los roles de clúster `basic-users` y `self-provisioning` al tema [Rol de servicio IAM para sincronización RBAC](/docs/openshift?topic=openshift-access_reference#service).</td>
</tr>
<tr>
  <td>23 de julio de 2019</td>
  <td><strong>Registro de cambios de Fluentd</strong>: soluciona [vulnerabilidades de Alpine](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).</td>
</tr>
<tr>
  <td>22 de julio de 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Política de versiones</strong>: Se ha aumentado el periodo de [obsolescencia de versión](/docs/containers?topic=containers-cs_versions#version_types) de 30 a 45 días.</li>
      <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Registros de cambios de versión</strong>: Se han actualizado los registros de cambios para las actualizaciones de parches de nodo trabajador [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526_worker), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529_worker) y [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560_worker).</li>
    <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Registro de cambios de versión</strong>: no hay soporte para la [Versión 1.11](/docs/containers?topic=containers-changelog#111_changelog).</li></ul>
  </td>
</tr>
<tr>
  <td>19 de julio de 2019</td>
  <td><img src="images/logo_openshift.svg" alt="icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: se ha añadido documentación de [Red Hat OpenShift on IBM Cloud a un repositorio aparte](/docs/openshift?topic=openshift-getting-started). Puesto que la lógica de {{site.data.keyword.containerlong_notm}} y la infraestructura de la nube subyacente es la misma, muchos temas de la documentación se reutilizan para la documentación de clúster de Kubernetes y OpenShift de la comunidad, como por ejemplo este tema de notas del release.
  </td>
</tr>
<tr>
  <td>17 de julio de 2019</td>
  <td><strong>Registro de cambios de Ingress ALB</strong>: [Soluciona vulnerabilidades de `rbash`](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).
  </td>
</tr>
<tr>
  <td>15 de julio de 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>ID de nodo trabajador y clúster</strong>: El formato del ID para los clústeres y nodos trabajadores ha cambiado. Los clústeres y los nodos trabajadores existentes conservan sus ID existentes. Si tiene automatización que se basa en el formato anterior, actúela para los nuevos clústeres.<ul>
  <li>**ID de clúster**: en el formato de expresión regular `{a-v0-9}[7]{a-z0-9}[2]{a-v0-9}[11]`</li>
  <li>**ID de nodo trabajador**: en el formato `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`</li></ul></li>
  <li><strong>Registro de cambios de Ingress ALB</strong>: se ha actualizado la imagen [ALB `nginx-ingress` a la compilación 497](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Resolución de problemas de clústeres</strong>: se han añadido [pasos de resolución de problemas](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_totp) para cuando no puede gestionar clústeres y nodos trabajadores porque la opción de código de acceso puntual (TOTP) basada en el tiempo está habilitada para su cuenta.</li>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Registros de cambios de versión</strong>: Se han actualizado los registros de cambios para las actualizaciones del fixpack maestro de [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529) y [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560).</li></ul>
  </td>
</tr>
<tr>
  <td>08 de julio de 2019</td>
  <td><ul>
  <li><strong>Redes de apps</strong>: ahora puede encontrar información sobre las redes de apps con los NLB y los ALB de Ingress en las páginas siguientes:
    <ul><li>[Equilibrio de carga básico y de DSR con equilibradores de carga de red (NLB)](/docs/containers?topic=containers-cs_sitemap#sitemap-nlb)</li>
    <li>[Equilibrio de carga HTTPS con equilibradores de carga de aplicación (ALB) de Ingress](/docs/containers?topic=containers-cs_sitemap#sitemap-ingress)</li></ul>
  </li>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Registros de cambios de versión</strong>: Se han actualizado los registros de cambios para las actualizaciones de parches de nodo trabajador [1.14.3_1525](/docs/containers?topic=containers-changelog#1143_1525), [1.13.7_1528](/docs/containers?topic=containers-changelog#1137_1528), [1.12.9_1559](/docs/containers?topic=containers-changelog#1129_1559) y [1.11.10_1564](/docs/containers?topic=containers-changelog#11110_1564).</li></ul>
  </td>
</tr>
<tr>
  <td>02 de julio de 2019</td>
  <td><strong>Registro de cambios de CLI</strong>: se ha actualizado la página de registro de cambios de plugin de CLI de {{site.data.keyword.containerlong_notm}} para el [release de la versión 0.3.58](/docs/containers?topic=containers-cs_cli_changelog).</td>
</tr>
<tr>
  <td>01 de julio de 2019</td>
  <td><ul>
  <li><strong>Permisos de infraestructura</strong>: se han actualizado los [roles de infraestructura clásica](/docs/containers?topic=containers-access_reference#infra) necesarios para los casos de uso comunes.</li>
  <li><img src="images/logo_openshift.svg" alt="icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>OpenShift FAQ</strong>: Se han ampliado las [Preguntas más frecuentes-FAQ](/docs/containers?topic=containers-faqs#container_platforms) para incluir información sobre clústeres de OpenShift.</li>
  <li><strong>Protección de apps gestionadas por Istio con {{site.data.keyword.appid_short_notm}}</strong>: se ha añadido información sobre el [adaptador de identidad y acceso de app](/docs/containers?topic=containers-istio#app-id).</li>
  <li><strong>Servicio de VPN de strongSwan</strong>: si instala strongSwan en un clúster multizona y utiliza el valor `enableSingleSourceIP=true`, ahora puede [establecer `local.subnet` en la variable `%zoneSubnet` y utilizar `local.zoneSubnet` para especificar una dirección IP como una subred de /32 para cada zona del clúster](/docs/containers?topic=containers-vpn#strongswan_4).</li>
  </ul></td>
</tr>
</tbody></table>


## Junio de 2019
{: #jun19}

<table summary="La tabla muestra las notas del release. Las filas se leen de izquierda derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Actualizaciones en la documentación de {{site.data.keyword.containerlong_notm}} de junio de 2019</caption>
<thead>
<th>Fecha</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
  <td>24 de junio de 2019</td>
  <td><ul>
  <li><strong>Políticas de red de Calico</strong>: se ha añadido un conjunto de [políticas Calico públicas](/docs/containers?topic=containers-network_policies#isolate_workers_public) y se ha ampliado el conjunto de [políticas privadas de Calico](/docs/containers?topic=containers-network_policies#isolate_workers) para proteger el clúster en redes públicas y privadas.</li>
  <li><strong>Registro de cambios de Ingress ALB</strong>: se ha actualizado la imagen [ALB `nginx-ingress` a la compilación 477](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Limitaciones de servicio</strong>: se ha actualizado el [límite del número máximo de pods por nodo trabajador](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits). Para los nodos trabajadores que ejecutan Kubernetes 1.13.7_1527, 1.14.3_1524 o posterior y que tienen más de 11 núcleos de CPU, los nodos trabajadores pueden dar soporte a 10 pods por núcleo, hasta un límite de 250 pods por nodo trabajador.</li>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Registros de cambios de versión</strong>: se han añadido registros de cambios para actualizaciones de parches de nodo trabajador [1.14.3_1524](/docs/containers?topic=containers-changelog#1143_1524), [1.13.7_1527](/docs/containers?topic=containers-changelog#1137_1527), [1.12.9_1558](/docs/containers?topic=containers-changelog#1129_1558) y [1.11.10_1563](/docs/containers?topic=containers-changelog#11110_1563).</li>
  </ul></td>
</tr>
<tr>
  <td>21 de junio de 2019</td>
  <td><ul>
  <li><img src="images/logo_openshift.svg" alt="icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Acceso a clústeres de OpenShift</strong>: se han añadido pasos para [automatizar el acceso a un clúster de OpenShift utilizando una señal de inicio de sesión de OpenShift](/docs/containers?topic=containers-cs_cli_install#openshift_cluster_login).</li>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Acceso al maestro de Kubernetes a través del punto final de servicio privado</strong>: se han añadido pasos para [editar el archivo de configuración de Kubernetes local](/docs/containers?topic=containers-clusters#access_on_prem) cuando los puntos finales de servicio público y privado están habilitados, pero desea acceder al maestro de Kubernetes a través del punto final de servicio privado únicamente.</li>
  <li><img src="images/logo_openshift.svg" alt="icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Resolución de problemas de clústeres de OpenShift</strong>: se ha añadido una [sección de resolución de problemas](/docs/openshift?topic=openshift-openshift_tutorial#openshift_troubleshoot) a la guía de aprendizaje Creación de un clúster de Red Hat OpenShift on IBM Cloud (beta).</li>
  </ul></td>
</tr>
<tr>
  <td>18 de junio de 2019</td>
  <td><ul>
  <li><strong>Registro de cambios de CLI</strong>: se ha actualizado la página de registro de cambios de plugin de CLI de {{site.data.keyword.containerlong_notm}} para el [release de las versiones 0.3.47 y 0.3.49](/docs/containers?topic=containers-cs_cli_changelog).</li>
  <li><strong>Registro de cambios de Ingress ALB</strong>: se ha actualizado la imagen de [ALB `nginx-ingress` a la compilación 473 y la imagen `ingress-auth` a la compilación 331](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Versiones de complementos gestionados</strong>: se ha actualizado la versión del complemento del Istio gestionado a 1.1.7 y el complemento gestionado del Knative a 0.6.0.</li>
  <li><strong>Eliminación del almacenamiento persistente</strong>: se ha actualizado la información sobre cómo se factura cuando [suprime el almacenamiento persistente](/docs/containers?topic=containers-cleanup).</li>
  <li><strong>Enlaces de servicio con punto final privado</strong>: [Pasos añadidos](/docs/containers?topic=containers-service-binding) para crear manualmente las credenciales de servicio con el punto final de servicio privado al enlazar el servicio con el clúster.</li>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Registros de cambios de versión</strong>: Se han actualizado los registros de cambios para las actualizaciones de parches [1.14.3_1523](/docs/containers?topic=containers-changelog#1143_1523), [1.13.7_1526](/docs/containers?topic=containers-changelog#1137_1526), [1.12.9_1557](/docs/containers?topic=containers-changelog#1129_1557) y [1.11.10_1562](/docs/containers?topic=containers-changelog#11110_1562).</li>
  </ul></td>
</tr>
<tr>
  <td>14 de junio de 2019</td>
  <td><ul>
  <li><strong>Resolución de problemas de `kubectl`</strong>: se ha añadido un [tema de resolución de problemas](/docs/containers?topic=containers-cs_troubleshoot_clusters#kubectl_fails) para cuando se tenga una versión de cliente `kubectl` con dos o más versiones de distancia con la versión del servidor o con la versión OpenShift de `kubectl`, que no funciona con clústeres de la comunidad Kubernetes.</li>
  <li><strong>Página principal de las guías de aprendizaje</strong>: Se ha sustituido la página de enlaces relacionados por una nueva [página principal de las guías de aprendizaje](/docs/containers?topic=containers-tutorials-ov) para todas las guías de aprendizaje específicas de {{site.data.keyword.containershort_notm}}.</li>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Guía de aprendizaje para crear un clúster y desplegar una app</strong>: combina las guías de aprendizaje para crear clústeres y desplegar apps en una [guía de aprendizaje](/docs/containers?topic=containers-cs_cluster_tutorial) completa.</li>
  <li><strong>Uso de varias subredes existentes para crear un clúster</strong>: Para [reutilizar subredes de un clúster que no hace falta cuando cree un clúster nuevo](/docs/containers?topic=containers-subnets#subnets_custom), las subredes deben ser subredes gestionadas por el usuario y debe agregarlas manualmente desde una red local. Todas las subredes que se solicitaron automáticamente durante la creación del clúster se suprimen inmediatamente después de suprimir un clúster, y las subredes no se pueden reutilizar para crear un nuevo clúster.</li>
  </ul></td>
</tr>
<tr>
  <td>12 de junio de 2019</td>
  <td><strong>Agregación de roles de clúster</strong>: Se han añadido pasos para [ampliar los permisos existentes de los usuarios mediante la agregación de roles de clúster](/docs/containers?topic=containers-users#rbac_aggregate).</td>
</tr>
<tr>
  <td>7 de junio de 2019</td>
  <td><ul>
  <li><strong>Acceso al nodo maestro de Kubernetes a través del punto final de servicio privado</strong>: se han añadido [pasos](/docs/containers?topic=containers-clusters#access_on_prem) para exponer el punto final de servicio privado a través de un equilibrador de carga privado. Después de seguir estos pasos, los usuarios autorizados del clúster podrán acceder al nodo maestro de Kubernetes desde una conexión VPN o {{site.data.keyword.cloud_notm}} Direct Link.</li>
  <li><strong>{{site.data.keyword.BluDirectLink}}</strong>: se ha añadido {{site.data.keyword.cloud_notm}} Direct Link a las páginas [Conectividad VPN](/docs/containers?topic=containers-vpn) y [Nube híbrida](/docs/containers?topic=containers-hybrid_iks_icp) como método para crear una conexión directa y privada entre los entornos de red remotos y {{site.data.keyword.containerlong_notm}} sin direccionamiento a través de Internet público.</li>
  <li><strong>Registro de cambios de ALB de Ingress</strong>: se ha actualizado la imagen de [ALB `ingress-auth` al build 330](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_openshift.svg" alt="icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>OpenShift beta</strong>: [se ha añadido una lección](/docs/openshift?topic=openshift-openshift_tutorial#openshift_logdna_sysdig) sobre cómo modificar despliegues de app para restricciones de contexto de seguridad con privilegios para los complementos {{site.data.keyword.la_full_notm}} y {{site.data.keyword.mon_full_notm}}.</li>
  </ul></td>
</tr>
<tr>
  <td>6 de junio de 2019</td>
  <td><ul>
  <li><strong>Registro de cambios de Fluentd</strong>: se ha añadido un [registro de cambios de versión de Fluentd](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).</li>
  <li><strong>Registro de cambios de ALB de Ingress</strong>: se ha actualizado la imagen de [ALB `nginx-ingress` al build 470](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>05 de junio de 2019</td>
  <td><ul>
  <li><strong>Consulta de CLI</strong>: se ha actualizado la [página de consulta de CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para reflejar varios cambios correspondientes al [release de la versión 0.3.34](/docs/containers?topic=containers-cs_cli_changelog) del plugin de la CLI de {{site.data.keyword.containerlong_notm}}.</li>
  <li><img src="images/logo_openshift.svg" alt="icono OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Novedad. Clústeres de Red Hat OpenShift on IBM Cloud (beta)</strong>: con la versión beta de Red Hat OpenShift on IBM Cloud, puede crear clústeres de {{site.data.keyword.containerlong_notm}} con nodos trabajadores que vienen instalados con el software de la plataforma de orquestación de contenedores OpenShift. Se obtienen todas las ventajas de {{site.data.keyword.containerlong_notm}} gestionado para el entorno de la infraestructura de clúster, junto con las [herramientas OpenShift y el catálogo ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.openshift.com/container-platform/3.11/welcome/index.html) que se ejecuta en Red Hat Enterprise Linux para los despliegues de sus apps. Para empezar, consulte la [Guía de aprendizaje: Creación de un clúster de Red Hat OpenShift on IBM Cloud (beta)](/docs/openshift?topic=openshift-openshift_tutorial).</li>
  </ul></td>
</tr>
<tr>
  <td>04 de junio de 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="icono Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Registros de cambios de versión</strong>: se han actualizado los registros de cambios para los releases de parches [1.14.2_1521](/docs/containers?topic=containers-changelog#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-changelog#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-changelog#1129_1555) y [1.11.10_1561](/docs/containers?topic=containers-changelog#11110_1561).</li></ul>
  </td>
</tr>
<tr>
  <td>3 de junio de 2019</td>
  <td><ul>
  <li><strong>Traer su propio controlador Ingress</strong>: se han actualizado los [pasos](/docs/containers?topic=containers-ingress-user_managed) para reflejar los cambios en el controlador de la comunidad predeterminado y para requerir una comprobación de estado para las direcciones IP del controlador en clústeres multizona.</li>
  <li><strong>{{site.data.keyword.cos_full_notm}}</strong>: se han actualizado los [pasos](/docs/containers?topic=containers-object_storage#install_cos) para instalar el plugin de {{site.data.keyword.cos_full_notm}} con o sin el servidor Helm, Tiller.</li>
  <li><strong>Registro de cambios de ALB de Ingress</strong>: se ha actualizado la imagen de [ALB `nginx-ingress` al build 467](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Kustomize</strong>: se ha añadido un ejemplo de [reutilización de los archivos de configuración de Kubernetes entre varios entornos con Kustomize](/docs/containers?topic=containers-app#kustomize).</li>
  <li><strong>Razee</strong>: se ha añadido [Razee ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/razee-io/Razee) a las integraciones soportadas para visualizar información de despliegue en el clúster y para automatizar el despliegue de recursos de Kubernetes. </li></ul>
  </td>
</tr>
</tbody></table>


## Mayo de 2019
{: #may19}

<table summary="La tabla muestra las notas del release. Las filas se leen de izquierda derecha, con la fecha en la columna uno, el título de la característica en la columna dos y una descripción en la columna tres.">
<caption>Actualizaciones en la documentación de {{site.data.keyword.containerlong_notm}} de mayo de 2019</caption>
<thead>
<th>Fecha</th>
<th>Descripción</th>
</thead>
<tbody>
<tr>
  <td>30 de mayo de 2019</td>
  <td><ul>
  <li><strong>Consulta de CLI</strong>: se ha actualizado la [página de consulta de CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para reflejar varios cambios correspondientes al [release de la versión 0.3.33](/docs/containers?topic=containers-cs_cli_changelog) del plugin de la CLI de {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Resolución de problemas de almacenamiento</strong>: <ul>
  <li>Se ha añadido un archivo y un tema de resolución de problemas de almacenamiento en bloque para los [estados pendientes de PVC](/docs/containers?topic=containers-cs_troubleshoot_storage#file_pvc_pending).</li>
  <li>Se ha añadido un tema de resolución de problemas de almacenamiento en bloque para cuando [una app no puede acceder a PVC ni escribir en PVC](/docs/containers?topic=containers-cs_troubleshoot_storage#block_app_failures).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>28 de mayo de 2019</td>
  <td><ul>
  <li><strong>Registro de cambios de complementos de clúster</strong>: se ha actualizado la imagen de [ALB `nginx-ingress` al build 462](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Registro de resolución de problemas</strong>: se ha añadido un [tema de resolución de problemas](/docs/containers?topic=containers-cs_troubleshoot_clusters#ts_image_pull_create) para cuando el clúster no puede extraer imágenes de {{site.data.keyword.registryfull}} debido a un error durante la creación del clúster.
  </li>
  <li><strong>Resolución de problemas de almacenamiento</strong>: <ul>
  <li>Se ha añadido un tema correspondiente a la [depuración de anomalías de almacenamiento persistente](/docs/containers?topic=containers-cs_troubleshoot_storage#debug_storage).</li>
  <li>Se ha añadido un tema de resolución de problemas para las [anomalías de creación de PVC debido a que faltan permisos](/docs/containers?topic=containers-cs_troubleshoot_storage#missing_permissions).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>23 de mayo de 2019</td>
  <td><ul>
  <li><strong>Consulta de CLI</strong>: se ha actualizado la [página de consulta de CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para reflejar varios cambios correspondientes al [release de la versión 0.3.28](/docs/containers?topic=containers-cs_cli_changelog) del plugin de la CLI de {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Registro de cambios de complementos de clúster</strong>: se ha actualizado la imagen de [ALB `nginx-ingress` al build 457](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Estados de clúster y de nodos trabajadores</strong>: se ha actualizado la [página de registro y supervisión](/docs/containers?topic=containers-health#states) para añadir tablas de referencia sobre los estados del clúster y de los nodos trabajadores.</li>
  <li><strong>Planificación y creación de clústeres</strong>: ahora puede encontrar información sobre la planificación, la creación y la eliminación de clústeres y sobre la planificación de red en las páginas siguientes:
    <ul><li>[Planificación de la configuración de la red del clúster](/docs/containers?topic=containers-plan_clusters)</li>
    <li>[Planificación del clúster para obtener una alta disponibilidad](/docs/containers?topic=containers-ha_clusters)</li>
    <li>[Planificación de la configuración del nodo trabajador](/docs/containers?topic=containers-planning_worker_nodes)</li>
    <li>[Creación de clústeres](/docs/containers?topic=containers-clusters)</li>
    <li>[Adición de nodos trabajadores y de zonas a clústeres](/docs/containers?topic=containers-add_workers)</li>
    <li>[Eliminación de clústeres](/docs/containers?topic=containers-remove)</li>
    <li>[Cambio de puntos finales de servicio o de conexiones de VLAN](/docs/containers?topic=containers-cs_network_cluster)</li></ul>
  </li>
  <li><strong>Actualizaciones de la versión de clúster</strong>: se ha actualizado la [política de versiones no soportadas](/docs/containers?topic=containers-cs_versions) para indicar que no se pueden actualizar clústeres si la versión maestra está tres o más versiones por detrás de la versión soportada más antigua. Para ver si el clúster **no recibe soporte**, consulte el campo **Estado** cuando se listen los clústeres.</li>
  <li><strong>Istio</strong>: se ha actualizado la [página de Istio](/docs/containers?topic=containers-istio) para eliminar la limitación de que Istio no funciona en clústeres conectados únicamente a una VLAN privada. Se ha añadido un paso al [tema Actualización de complementos gestionados](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons) para volver a crear las pasarelas de Istio que utilizan secciones TLS después de que se haya completado la actualización del complemento gestionado de Istio.</li>
  <li><strong>Temas populares</strong>: se han sustituido los temas populares por esta página de notas de release para las nuevas características y actualizaciones que son específicas de {{site.data.keyword.containershort_notm}}. Para ver la información más reciente sobre los productos {{site.data.keyword.cloud_notm}}, consulte los [Anuncios](https://www.ibm.com/cloud/blog/announcements).</li>
  </ul></td>
</tr>
<tr>
  <td>20 de mayo de 2019</td>
  <td><ul>
  <li><strong>Registros de cambios de versión</strong>: se han añadido [registros de cambios de fix pack de nodo trabajador](/docs/containers?topic=containers-changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>16 de mayo de 2019</td>
  <td><ul>
  <li><strong>Consulta de CLI</strong>: se ha actualizado la [página de consulta de CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) para añadir puntos finales de COS para los mandatos `logging-collect` y para aclarar que `apiserver-refresh` reinicia los componentes del nodo maestro de Kubernetes.</li>
  <li><strong>No soportado: Kubernetes versión 1.10</strong>: [Kubernetes versión 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) ya no recibe soporte.</li>
  </ul></td>
</tr>
<tr>
  <td>15 de mayo de 2019</td>
  <td><ul>
  <li><strong>Versión de Kubernetes predeterminada</strong>: ahora la versión predeterminada de Kubernetes es la 1.13.6.</li>
  <li><strong>Límites de servicio</strong>: se ha añadido un [tema sobre limitaciones de servicio](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits).</li>
  </ul></td>
</tr>
<tr>
  <td>13 de mayo de 2019</td>
  <td><ul>
  <li><strong>Registro de cambios de versión</strong>: se ha añadido que hay nuevas actualizaciones de parches disponibles para [1.14.1_1518](/docs/containers?topic=containers-changelog#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-changelog#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-changelog#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-changelog#11110_1558) y [1.10.13_1558](/docs/containers?topic=containers-changelog#11013_1558).</li>
  <li><strong>Tipos de nodos trabajadores</strong>: se han eliminado todos los [tipos de nodos trabajadores de máquina virtual](/docs/containers?topic=containers-planning_worker_nodes#vm), que son 48 o más núcleos por [estado de nube ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/status?component=containers-kubernetes&selected=status). Puede seguir suministrando [nodos trabajadores nativos](/docs/containers?topic=containers-plan_clusters#bm) con 48 o más núcleos.</li></ul></td>
</tr>
<tr>
  <td>8 de mayo de 2019</td>
  <td><ul>
  <li><strong>API</strong>: se ha añadido un enlace a [documentación de swagger de API global ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://containers.cloud.ibm.com/global/swagger-global-api/#/).</li>
  <li><strong>Cloud Object Storage</strong>: [se ha añadido una guía de resolución de problemas de Cloud Object Storage](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending) en los clústeres de {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Estrategia de Kubernetes</strong>: se ha añadido un tema sobre [¿Qué conocimientos técnicos se recomienda tener antes de mover mis apps a {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-strategy#knowledge).</li>
  <li><strong>Kubernetes versión 1.14</strong>: se ha añadido que el [release 1.14 de Kubernetes](/docs/containers?topic=containers-cs_versions#cs_v114) está certificado.</li>
  <li><strong>Temas de consulta</strong>: se ha actualizado la información correspondiente a distintas operaciones de enlace de servicio, `registro` y `nlb` en las páginas de consulta de [acceso de usuario](/docs/containers?topic=containers-access_reference) y de la [CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli).</li></ul></td>
</tr>
<tr>
  <td>7 de mayo de 2019</td>
  <td><ul>
  <li><strong>Proveedor de DNS de clúster</strong>: [se explican las ventajas de CoreDNS](/docs/containers?topic=containers-cluster_dns), ahora que los clústeres que ejecutan Kubernetes 1.14 y posteriores solo dan soporte a CoreDNS.</li>
  <li><strong>Nodos de extremo</strong>: se ha añadido soporte de equilibrador de carga privado para [nodos de extremo](/docs/containers?topic=containers-edge).</li>
  <li><strong>Clústeres gratuitos</strong>: se clarifica dónde se da soporte a los [clústeres gratuitos](/docs/containers?topic=containers-regions-and-zones#regions_free).</li>
  <li><strong>Novedad: Integraciones</strong>: se ha añadido y se ha reestructurado la información sobre [integraciones entre servicios de {{site.data.keyword.cloud_notm}} y de terceros](/docs/containers?topic=containers-ibm-3rd-party-integrations), [integraciones populares](/docs/containers?topic=containers-supported_integrations) y [asociaciones](/docs/containers?topic=containers-service-partners).</li>
  <li><strong>Novedad: Kubernetes versión 1.14</strong>: cree o actualice sus clústeres a [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114).</li>
  <li><strong>Versión 1.11 de Kubernetes en desuso</strong>: [actualice](/docs/containers?topic=containers-update) los clústeres que ejecuten [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) antes de que dejen de recibir soporte.</li>
  <li><strong>Permisos</strong>: se ha añadido una pregunta frecuente: [¿Qué políticas de acceso debo dar a los usuarios de mi clúster?](/docs/containers?topic=containers-faqs#faq_access)</li>
  <li><strong>Agrupaciones de nodos trabajadores</strong>: se han añadido instrucciones sobre cómo [aplicar etiquetas a las agrupaciones de nodos trabajadores existentes](/docs/containers?topic=containers-add_workers#worker_pool_labels).</li>
  <li><strong>Temas de consulta</strong>: para dar soporte a nuevas características, como por ejemplo Kubernetes 1.14, se han actualizado las páginas de consulta de [changelog](/docs/containers?topic=containers-changelog#changelog).</li></ul></td>
</tr>
<tr>
  <td>1 de mayo de 2019</td>
  <td><strong>Asignación de acceso a la infraestructura</strong>: se han revisado los [pasos a seguir para asignar permisos de IAM para abrir casos de soporte](/docs/containers?topic=containers-users#infra_access).</td>
</tr>
</tbody></table>


