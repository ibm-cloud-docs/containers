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



# Registro de cambios de CLI
{: #cs_cli_changelog}

En el terminal, se le notifica cuando están disponibles las actualizaciones de la CLI y los plugins de `ibmcloud`. Asegúrese de mantener actualizada la CLI para poder utilizar todos los mandatos y distintivos disponibles.
{:shortdesc}

Para instalar el plugin de CLI de {{site.data.keyword.containerlong}}, consulte [Instalación de la CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps).

Consulte la tabla siguiente para ver un resumen de los cambios para cada versión del plugin de CLI de {{site.data.keyword.containerlong_notm}}.

<table summary="Visión general de los cambios de versión del plugin de CLI de {{site.data.keyword.containerlong_notm}} ">
<caption>Registro de cambios para el plugin de CLI de {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<tr>
<th>Versión</th>
<th>Fecha de lanzamiento</th>
<th>Cambios</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.2.80</td>
<td>19 de marzo de 2019</td>
<td><ul>
<li>Incorpora soporte para habilitar la [comunicación entere maestro y trabajador con puntos finales de servicio](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master) en clústeres estándares que ejecutan Kubernetes versión 1.11 o posterior en [cuentas habilitadas para VRF](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started). Para obtener información sobre cómo utilizar los mandatos siguientes, consulte [Configuración del punto final de servicio privado](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se) y [Configuración del punto final de servicio público](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se).<ul>
<li>Incorpora los distintivos `--private-service-endpoint` y `--public-service-endpoint` al mandato [<code>ibmcloud ks cluster-create</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create).</li>
<li>Incorpora los campos **Public Service Endpoint URL** (URL de punto final de servicio público) y **Private Service Endpoint URL** (URL de punto final de servicio privado) a la salida de <code>ibmcloud ks cluster-get</code>.</li>
<li>Incorpora el mandato [<code>ibmcloud ks cluster-feature-enable private-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_private_service_endpoint).</li>
<li>Incorpora el mandato [<code>ibmcloud ks cluster-feature-enable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_public_service_endpoint).</li>
<li>Incorpora el mandato [<code>ibmcloud ks cluster-feature-disable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_disable_public_service_endpoint).</li>
<li>Incorpora el mandato [<code>ibmcloud ks cluster-feature-ls</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_ls).</li>
</ul></li>
<li>Actualiza la documentación y la traducción.</li>
<li>Actualiza la versión de Go a 1.11.6.</li>
<li>Resuelve problemas de red intermitentes para los usuarios de macOS.</li>
</ul></td>
</tr>
<tr>
<td>0.2.75</td>
<td>14 de marzo de 2019</td>
<td><ul><li>Oculta HTML sin formato de la información de salida de error.</li>
<li>Arregla errores tipográficos en el texto de ayuda.</li>
<li>Corrige la traducción del texto de ayuda.</li>
</ul></td>
</tr>
<tr>
<td>0.2.61</td>
<td>26 de febrero de 2019</td>
<td><ul>
<li>Incorpora el mandato `cluster-pull-secret-apply`, que crea un ID de servicio de IAM para el clúster, políticas, clave de API y secretos de extracción de imágenes para que los contenedores que se ejecutan en el espacio de nombres `default` de Kubernetes puedan extraer imágenes del registro de IBM Cloud Container. Para los clústeres nuevos, los secretos de extracción de imágenes que utilizan las credenciales de IAM se crean de forma predeterminada. Utilice este mandato para actualizar los clústeres existentes o si el clúster tiene un error secreto de obtención de imagen durante la creación. Para obtener más información, consulte [la documentación](https://test.cloud.ibm.com/docs/containers?topic=containers-images#cluster_registry_auth).</li>
<li>Arregla un error por el que las anomalías de `ibmcloud ks init` hacían que se imprimiese la salida de la ayuda.</li>
</ul></td>
</tr>
<tr>
<td>0.2.53</td>
<td>19 de febrero de 2019</td>
<td><ul><li>Soluciona un error en el que se pasaba por alto la región para `ibmcloud ks api-key-reset`, `ibmcloud ks credential-get/set` e `ibmcloud ks vlan-spanning-get`.</li>
<li>Mejora el rendimiento de `ibmcloud ks worker-update`.</li>
<li>Incorpora la versión del complemento en las solicitudes `ibmcloud ks cluster-addon-enable`.</li>
</ul></td>
</tr>
<tr>
<td>0.2.44</td>
<td>8 de febrero de 2019</td>
<td><ul>
<li>Incorpora la opción `--skip-rbac` al mandato `ibmcloud ks cluster-config` para omitir la adición de roles RBAC de usuario de Kubernetes en función de los roles de acceso al servicio de {{site.data.keyword.Bluemix_notm}} IAM sobre la configuración del clúster. Incluya esta opción solo si [gestiona sus propios roles RBAC de Kubernetes](/docs/containers?topic=containers-users#rbac). Si utiliza [Roles de acceso al servicio de {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-access_reference#service) para gestionar todos los usuarios de RBAC, no incluya esta opción.</li>
<li>Actualiza la versión de Go a 1.11.5.</li>
</ul></td>
</tr>
<tr>
<td>0.2.40</td>
<td>6 de febrero de 2019</td>
<td><ul>
<li>Incorpora los mandatos [<code>ibmcloud ks cluster-addons</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons), [<code>ibmcloud ks cluster-addon-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable) e [<code>ibmcloud ks cluster-addon-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable)
para trabajar con complementos de clúster gestionado, como los complementos gestionados [Istio](/docs/containers?topic=containers-istio) y [Knative](/docs/containers?topic=containers-knative_tutorial) para {{site.data.keyword.containerlong_notm}}.</li>
<li>Mejora el texto de la ayuda para usuarios de {{site.data.keyword.Bluemix_dedicated_notm}} del mandato <code>ibmcloud ks vlans</code>.</li></ul></td>
</tr>
<tr>
<td>0.2.30</td>
<td>31 de enero de 2019</td>
<td>Aumenta el valor de tiempo de espera predeterminado para `ibmcloud ks cluster-cluster-config` a `500s`.</td>
</tr>
<tr>
<td>0.2.19</td>
<td>16 de enero de 2019</td>
<td><ul><li>Incorpora la variable de entorno `IKS_BETA_VERSION` para habilitar la versión beta rediseñada de la CLI del plugin {{site.data.keyword.containerlong_notm}}. Para probar la versión rediseñada, consulte [Utilización de la estructura de mandatos beta](/docs/containers?topic=containers-cs_cli_reference#cs_beta).</li>
<li>Aumenta el valor de tiempo de espera predeterminado para `ibmcloud ks subnets` a `60s`.</li>
<li>Arreglos de errores menores y de traducción.</li></ul></td>
</tr>
<tr>
<td>0.1.668</td>
<td>18 de diciembre de 2018</td>
<td><ul><li>Cambia el punto final de API predeterminado <code>https://containers.bluemix.net</code> por <code>https://containers.cloud.ibm.com</code>.</li>
<li>Corrige un error para que las traducciones se muestren correctamente para la ayuda de mandatos y los mensajes de error.</li>
<li>Visualiza la ayuda del mandato más rápido.</li></ul></td>
</tr>
<tr>
<td>0.1.654</td>
<td>05 de diciembre de 2018</td>
<td>Actualiza la documentación y la traducción.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15 de noviembre de 2018</td>
<td>
<ul><li>Incorpora el mandato [<code>ibmcloud ks cluster-refresh</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh).</li>
<li>Incorpora el nombre de grupo de recursos a la salida de <code>ibmcloud ks cluster-get</code> e <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>06 de noviembre de 2018</td>
<td>Incorpora mandatos para gestionar actualizaciones automáticas del complemento de clúster de ALB de Ingress:<ul>
<li>[<code>ibmcloud ks alb-autoupdate-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-get</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</li>
<li>[<code>ibmcloud ks alb-rollback</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</li>
<li>[<code>ibmcloud ks alb-update</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</li>
</ul></td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 de octubre de 2018</td>
<td><ul>
<li>Incorpora el mandato [<code>ibmcloud ks credential-get</code>.](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get).</li>
<li>Incorpora soporte para el origen de registro <code>storage</code> a todos los mandatos de registro de clúster. Para obtener más información, consulte
<a href="/docs/containers?topic=containers-health#logging">Visión general del reenvío de registros de clúster y de app</a>.</li>
<li>Incorpora el distintivo `--network` al [mandato <code>ibmcloud ks cluster-config</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config), que descarga el archivo de configuración de Calico para ejecutar todos los mandatos de Calico.</li>
<li>Arreglos de errores menores y refactorización</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10 de octubre de 2018</td>
<td><ul><li>Incorpora el ID de grupo de recursos a la salida de <code>ibmcloud ks cluster-get</code>.</li>
<li>Cuando [{{site.data.keyword.keymanagementserviceshort}} está habilitado](/docs/containers?topic=containers-encryption#keyprotect) como proveedor de servicios de gestión de claves (KMS), añade el campo habilitado para KMS en la salida de <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2 de octubre de 2018</td>
<td>Incorpora soporte para [grupos de recursos](/docs/containers?topic=containers-clusters#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>1 de octubre de 2018</td>
<td><ul>
<li>Incorpora los mandatos [<code>ibmcloud ks logging-collect</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect) e [<code>ibmcloud ks logging-collect-status</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status) para recopilar registros del servidor de API en el clúster.</li>
<li>Incorpora el [mandato <code>ibmcloud ks key-protect-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_key_protect) para habilitar {{site.data.keyword.keymanagementserviceshort}} como un proveedor de servicios de gestión de claves (KMS) en el clúster.</li>
<li>Incorpora el distintivo <code>--skip-master-health</code> a los mandatos [ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) e [ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) para omitir la comprobación de estado del nodo maestro antes de realizar un reinicio o una recarga.</li>
<li>Cambia el nombre de <code>Owner Email</code> por <code>Owner</code> en la salida de <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
