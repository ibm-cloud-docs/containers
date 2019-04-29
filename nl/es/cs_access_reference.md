---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="blank"}
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


# Permisos de acceso de usuario
{: #access_reference}

Cuando [asigna permisos de clúster](/docs/containers?topic=containers-users), puede resultar difícil saber qué rol tiene que asignar a un usuario. Utilice las tablas de las secciones siguientes para determinar el nivel mínimo de permisos necesarios para realizar tareas comunes en {{site.data.keyword.containerlong}}.
{: shortdesc}

A partir del 30 de enero de 2019, {{site.data.keyword.containerlong_notm}} tiene una nueva forma de autorizar a los usuarios con {{site.data.keyword.Bluemix_notm}} IAM: [roles de acceso al servicio](#service). Estos roles de servicio se utilizan para otorgar acceso a recursos dentro del clúster como, por ejemplo, espacios de nombres de Kubernetes. Para obtener más información, consulte el blog de [Introducción
de roles de servicio y de espacios de nombres en IAM para obtener un control más granular del acceso de clúster ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2019/02/introducing-service-roles-and-namespaces-in-iam-for-more-granular-control-of-cluster-access/).
{: note}

## Roles de plataforma de {{site.data.keyword.Bluemix_notm}} IAM
{: #iam_platform}

{{site.data.keyword.containerlong_notm}} está configurado para que utilice roles de Identity and Access Management (IAM) de {{site.data.keyword.Bluemix_notm}}. Los roles de plataforma de {{site.data.keyword.Bluemix_notm}} IAM determinan las acciones que pueden realizar los usuarios sobre recursos de {{site.data.keyword.Bluemix_notm}}, como clústeres, nodos trabajadores y equilibradores de carga de aplicación de Ingress. Los roles de plataforma de {{site.data.keyword.Bluemix_notm}} IAM también establecen automáticamente permisos básicos de infraestructura para usuarios. Para definir roles, consulte [Asignación de permisos de plataforma de {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform).
{: shortdesc}

En cada una de las secciones siguientes, las tablas muestran los permisos de gestión de clústeres, de registro y de Ingress otorgados por cada rol de plataforma de {{site.data.keyword.Bluemix_notm}} IAM. Las tablas están ordenadas alfabéticamente por nombre de mandato de CLI.

* [Acciones que no requieren ningún permiso](#none-actions)
* [Acciones de Visor](#view-actions)
* [Acciones de Editor](#editor-actions)
* [Acciones de Operador](#operator-actions)
* [Acciones de Administrador](#admin-actions)

### Acciones que no requieren ningún permiso
{: #none-actions}

Cualquier usuario de la cuenta que ejecute el mandato de CLI o que realice la llamada a la API para la acción de la siguiente tabla ve el resultado, aunque el usuario no tenga ningún permiso asignado.
{: shortdesc}

<table>
<caption>Visión general de mandatos de CLI y llamadas a API que no requieren ningún permiso en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="none-actions-action">Acción de gestión de clústeres</th>
<th id="none-actions-cli">Mandato de CLI</th>
<th id="none-actions-api">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Definir como destino o ver el punto final de API para {{site.data.keyword.containerlong_notm}}.</td>
<td><code>[ibmcloud ks api](/docs/containers?topic=containers-cs_cli_reference#cs_api)</code></td>
<td>-</td>
</tr>
<tr>
<td>Ver una lista de mandatos y parámetros admitidos.</td>
<td><code>[ibmcloud ks help](/docs/containers?topic=containers-cs_cli_reference#cs_help)</code></td>
<td>-</td>
</tr>
<tr>
<td>Inicializar el plugin de {{site.data.keyword.containerlong_notm}} o especifique la región donde desea crear o acceder a clústeres de Kubernetes.</td>
<td><code>[ibmcloud ks init](/docs/containers?topic=containers-cs_cli_reference#cs_init)</code></td>
<td>-</td>
</tr>
<tr>
<td>Visualizar una lista de las versiones de Kubernetes soportadas en {{site.data.keyword.containerlong_notm}}. </td><td><code>[ibmcloud ks kube-versions](/docs/containers?topic=containers-cs_cli_reference#cs_kube_versions)</code></td>
<td><code>[GET /v1/kube-versions](https://containers.cloud.ibm.com/swagger-api/#!/util/GetKubeVersions)</code></td>
</tr>
<tr>
<td>Ver una lista de los tipos de máquinas disponibles para sus nodos trabajadores.</td>
<td><code>[ibmcloud ks machine-types](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/machine-types](https://containers.cloud.ibm.com/swagger-api/#!/util/GetDatacenterMachineTypes)</code></td>
</tr>
<tr>
<td>Ver los mensajes actuales para el usuario IBMid.</td>
<td><code>[ibmcloud ks messages](/docs/containers?topic=containers-cs_cli_reference#cs_messages)</code></td>
<td><code>[GET /v1/messages](https://containers.cloud.ibm.com/swagger-api/#!/util/GetMessages)</code></td>
</tr>
<tr>
<td>Buscar la región de {{site.data.keyword.containerlong_notm}} en la que está actualmente.</td>
<td><code>[ibmcloud ks region](/docs/containers?topic=containers-cs_cli_reference#cs_region)</code></td>
<td>-</td>
</tr>
<tr>
<td>Establecer la región para {{site.data.keyword.containerlong_notm}}.</td>
<td><code>[ibmcloud ks region-set](/docs/containers?topic=containers-cs_cli_reference#cs_region-set)</code></td>
<td>-</td>
</tr>
<tr>
<td>Listar las regiones disponibles.</td>
<td><code>[ibmcloud ks regions](/docs/containers?topic=containers-cs_cli_reference#cs_regions)</code></td>
<td><code>[GET /v1/regions](https://containers.cloud.ibm.com/swagger-api/#!/util/GetRegions)</code></td>
</tr>
<tr>
<td>Ver una lista de las zonas disponibles en las que puede crear un clúster.</td>
<td><code>[ibmcloud ks zones](/docs/containers?topic=containers-cs_cli_reference#cs_datacenters)</code></td>
<td><code>[GET /v1/zones](https://containers.cloud.ibm.com/swagger-api/#!/util/GetZones)</code></td>
</tr>
</tbody>
</table>

### Acciones de Visor
{: #view-actions}

El rol de plataforma de **Visor** incluye las [acciones que no requieren ningún permiso](#none-actions), más los permisos que se muestran en la tabla siguiente.
{: shortdesc}

<table>
<caption>Visión general de los mandatos de CLI y llamadas a API de gestión de clústeres que requieren el rol de plataforma de Visor en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="view-actions-mngt">Acción de gestión de clústeres</th>
<th id="view-actions-cli">Mandato de CLI</th>
<th id="view-actions-api">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Ver el nombre y la dirección de correo electrónico del propietario de la clave de API de {{site.data.keyword.Bluemix_notm}} IAM para un grupo de recursos y una región.</td>
<td><code>[ibmcloud ks api-key-info](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_info)</code></td>
<td><code>[GET /v1/logging/{idOrName}/clusterkeyowner](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetClusterKeyOwner)</code></td>
</tr>
<tr>
<td>Descargar certificados y datos de configuración de Kubernetes para conectar el clúster y ejecutar mandatos `kubectl`.</td>
<td><code>[ibmcloud ks cluster-config](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/config](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterConfig)</code></td>
</tr>
<tr>
<td>Ver información sobre un clúster.</td>
<td><code>[ibmcloud ks cluster-get](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetCluster)</code></td>
</tr>
<tr>
<td>Listar todos los servicios de todos los espacios de nombres que están vinculados a un clúster.</td>
<td><code>[ibmcloud ks cluster-services](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_services)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ListServicesForAllNamespaces)</code></td>
</tr>
<tr>
<td>Listar todos los clústeres.</td>
<td><code>[ibmcloud ks clusters](/docs/containers?topic=containers-cs_cli_reference#cs_clusters)</code></td>
<td><code>[GET /v1/clusters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusters)</code></td>
</tr>
<tr>
<td>Obtener las credenciales de infraestructura que se han establecido para la cuenta de {{site.data.keyword.Bluemix_notm}} para acceder a otro portafolio de la infraestructura de IBM Cloud (SoftLayer).</td>
<td><code>[ibmcloud ks credential-get](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get)</code></td><td><code>[GET /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/accounts/GetUserCredentials)</code></td>
</tr>
<tr>
<td>Listar todos los servicios vinculados a un espacio de nombres específico.</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/services/{namespace}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ListServicesInNamespace)</code></td>
</tr>
<tr>
<td>Listar todas las subredes gestionadas por el usuario que están vinculadas a un clúster.</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Obtener una lista de las subredes de la cuenta de la infraestructura.</td>
<td><code>[ibmcloud ks subnets](/docs/containers?topic=containers-cs_cli_reference#cs_subnets)</code></td>
<td><code>[GET /v1/subnets](https://containers.cloud.ibm.com/swagger-api/#!/properties/ListSubnets)</code></td>
</tr>
<tr>
<td>Ver el estado de expansión de VLAN para la cuenta de infraestructura.</td>
<td><code>[ibmcloud ks vlan-spanning-get](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)</code></td>
<td><code>[GET /v1/subnets/vlan-spanning](https://containers.cloud.ibm.com/swagger-api/#!/accounts/GetVlanSpanning)</code></td>
</tr>
<tr>
<td>Cuando se establece para un clúster: Obtener una lista de las VLAN a las que está conectado el clúster en una zona.</br>Cuando se establece para todos los clústeres de la cuenta: Obtener una lista de todas las VLAN disponibles en una zona.</td>
<td><code>[ibmcloud ks vlans](/docs/containers?topic=containers-cs_cli_reference#cs_vlans)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/vlans](https://containers.cloud.ibm.com/swagger-api/#!/properties/GetDatacenterVLANs)</code></td>
</tr>
<tr>
<td>Listar todos los webhooks de un clúster.</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterWebhooks)</code></td>
</tr>
<tr>
<td>Ver información sobre un nodo trabajador.</td>
<td><code>[ibmcloud ks worker-get](/docs/containers?topic=containers-cs_cli_reference#cs_worker_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkers)</code></td>
</tr>
<tr>
<td>Ver información de una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks worker-pool-get](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkerPool)</code></td>
</tr>
<tr>
<td>Listar todas las agrupaciones de nodos trabajadores de un clúster.</td>
<td><code>[ibmcloud ks worker-pools](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pools)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkerPools)</code></td>
</tr>
<tr>
<td>Listar todos los nodos trabajadores de un clúster.</td>
<td><code>[ibmcloud ks workers](/docs/containers?topic=containers-cs_cli_reference#cs_workers)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterWorkers)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>Visión general de los mandatos de CLI de Ingress y de las llamadas a API que requieren el rol de plataforma de Visor en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="view-actions-ingress">Acción de Ingress</th>
<th id="view-actions-cli2">Mandato de CLI</th>
<th id="view-actions-api2">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Ver información de un ALB de Ingress.</td>
<td><code>[ibmcloud ks alb-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_get)</code></td>
<td><code>[GET /albs/{albId}](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetClusterALB)</code></td>
</tr>
<tr>
<td>Ver los tipos de ALB que reciben soporte en la región.</td>
<td><code>[ibmcloud ks alb-types](/docs/containers?topic=containers-cs_cli_reference#cs_alb_types)</code></td>
<td><code>[GET /albtypes](https://containers.cloud.ibm.com/swagger-alb-api/#!/util/GetAvailableALBTypes)</code></td>
</tr>
<tr>
<td>Listar todos los ALB de un clúster.</td>
<td><code>[ibmcloud ks albs](/docs/containers?topic=containers-cs_cli_reference#cs_albs)</code></td>
<td><code>[GET /clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetClusterALBs)</code></td>
</tr>
</tbody>
</table>


<table>
<caption>Visión general de los mandatos de CLI de registro y de las llamadas a API que requieren el rol de plataforma de Visor en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="view-actions-log">Acción de registro</th>
<th id="view-actions-cli3">Mandato de CLI</th>
<th id="view-actions-api3">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Ver el estado de las actualizaciones automáticas del complemento Fluentd.</td>
<td><code>[ibmcloud ks logging-autoupdate-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>Ver el punto final de registro predeterminado para la región de destino.</td>
<td>-</td>
<td><code>[GET /v1/logging/{idOrName}/default](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetDefaultLoggingEndpoint)</code></td>
</tr>
<tr>
<td>Listar todas las configuraciones de reenvío de registros del clúster o de un determinado origen de registro del clúster.</td>
<td><code>[ibmcloud ks logging-config-get](/docs/containers?topic=containers-cs_cli_reference#cs_logging_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/swagger-logging/#!/logging/FetchLoggingConfigs) and [GET /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/FetchLoggingConfigsForSource)</code></td>
</tr>
<tr>
<td>Ver información de una configuración de filtrado de registro.</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/FetchFilterConfig)</code></td>
</tr>
<tr>
<td>Listar todas las configuraciones de filtro de registro del clúster.</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/FetchFilterConfigs)</code></td>
</tr>
</tbody>
</table>

### Acciones de editor
{: #editor-actions}

El rol de plataforma de **Editor** incluye los permisos otorgados por **Visor**, más los siguientes. **Sugerencia**: Utilice este rol para desarrolladores de apps y asigne el rol de **Desarrollador** de <a href="#cloud-foundry">Cloud Foundry</a>.
{: shortdesc}

<table>
<caption>Visión general de los mandatos de CLI y llamadas a API de gestión de clústeres que requieren el rol de plataforma de Editor en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="editor-actions-mngt">Acción de gestión de clústeres</th>
<th id="editor-actions-cli">Mandato de CLI</th>
<th id="editor-actions-api">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Enlazar un servicio a un clúster. **Nota**: También se necesita el rol de Desarrollador de Cloud Foundry en el espacio en el que está el servicio.</td>
<td><code>[ibmcloud ks cluster-service-bind](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_service_bind)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/swagger-api/#!/clusters/BindServiceToNamespace)</code></td>
</tr>
<tr>
<td>Desenlazar un servicio de un clúster. **Nota**: También se necesita el rol de Desarrollador de Cloud Foundry en el espacio en el que está el servicio.</td>
<td><code>[ibmcloud ks cluster-service-unbind](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_service_unbind)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/services/{namespace}/{serviceInstanceId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UnbindServiceFromNamespace)</code></td>
</tr>
<tr>
<td>Cree un webhook en un clúster.</td>
<td><code>[ibmcloud ks webhook-create](/docs/containers?topic=containers-cs_cli_reference#cs_webhook_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterWebhooks)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>Visión general de los mandatos de CLI de Ingress y de las llamadas a API que requieren el rol de plataforma de Editor en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="editor-actions-ingress">Acción de Ingress</th>
<th id="editor-actions-cli2">Mandato de CLI</th>
<th id="editor-actions-api2">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Inhabilitar las actualizaciones automáticas para el complemento ALB de Ingress.</td>
<td><code>[ibmcloud ks alb-autoupdate-disable](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Habilitar las actualizaciones automáticas para el complemento ALB de Ingress.</td>
<td><code>[ibmcloud ks alb-autoupdate-enable](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Comprobar si están habilitadas las actualizaciones automáticas para el complemento ALB de Ingress.</td>
<td><code>[ibmcloud ks alb-autoupdate-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</code></td>
<td><code>[GET /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>Habilitar o inhabilitar un ALB de Ingress.</td>
<td><code>[ibmcloud ks alb-configure](/docs/containers?topic=containers-cs_cli_reference#cs_alb_configure)</code></td>
<td><code>[POST /albs](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/EnableALB) and [DELETE /albs/{albId}](https://containers.cloud.ibm.com/swagger-alb-api/#/)</code></td>
</tr>
<tr>
<td>Retrotraer la actualización del complemento ALB de Ingress a la compilación que ejecutaban anteriormente los pods de ALB.</td>
<td><code>[ibmcloud ks alb-rollback](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</code></td>
<td><code>[PUT /clusters/{idOrName}/updaterollback](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/RollbackUpdate)</code></td>
</tr>
<tr>
<td>Imponer una actualización de una sola vez de los pods de ALB mediante la actualización manual del complemento ALB de Ingress.</td>
<td><code>[ibmcloud ks alb-update](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</code></td>
<td><code>[PUT /clusters/{idOrName}/update](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/UpdateALBs)</code></td>
</tr>
</tbody>
</table>



<table>
<caption>Visión general de los mandatos de CLI de registro y de las llamadas a API que requieren el rol de plataforma de Editor en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="editor-log">Acción de registro</th>
<th id="editor-cli3">Mandato de CLI</th>
<th id="editor-api3">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Crear un webhook de auditoría de servidor de API.</td>
<td><code>[ibmcloud ks apiserver-config-set](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_config_set)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/swagger-api/#!/clusters/apiserverconfigs/UpdateAuditWebhook)</code></td>
</tr>
<tr>
<td>Suprimir un webhook de auditoría de servidor de API.</td>
<td><code>[ibmcloud ks apiserver-config-unset](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_config_unset)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/swagger-api/#!/apiserverconfigs/DeleteAuditWebhook)</code></td>
</tr>
<tr>
<td>Crear una configuración de reenvío de registros para todos los orígenes de registro excepto <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cs_cli_reference#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>Renovar una configuración de reenvío de registro.</td>
<td><code>[ibmcloud ks logging-config-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_logging_refresh)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/refresh](https://containers.cloud.ibm.com/swagger-logging/#!/logging/RefreshLoggingConfig)</code></td>
</tr>
<tr>
<td>Suprimir una configuración de reenvío de registros para todos los orígenes de registro excepto <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cs_cli_reference#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfig)</code></td>
</tr>
<tr>
<td>Suprima todas las configuraciones de reenvío de registros para un clúster.</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfigs)</code></td>
</tr>
<tr>
<td>Actualizar una configuración de reenvío de registros.</td>
<td><code>[ibmcloud ks logging-config-update](/docs/containers?topic=containers-cs_cli_reference#cs_logging_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/UpdateLoggingConfig)</code></td>
</tr>
<tr>
<td>Crear una configuración de filtrado de registros.</td>
<td><code>[ibmcloud ks logging-filter-create](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/CreateFilterConfig)</code></td>
</tr>
<tr>
<td>Suprimir una configuración de filtrado de registros.</td>
<td><code>[ibmcloud ks logging-filter-rm](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_delete)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/DeleteFilterConfig)</code></td>
</tr>
<tr>
<td>Suprimir todas las configuraciones de filtrado de registros para el clúster de Kubernetes.</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/DeleteFilterConfigs)</code></td>
</tr>
<tr>
<td>Actualizar una configuración de filtrado de registros.</td>
<td><code>[ibmcloud ks logging-filter-update](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/UpdateFilterConfig)</code></td>
</tr>
</tbody>
</table>

### Acciones de Operador
{: #operator-actions}

El rol de plataforma de **Operador** incluye los permisos otorgados por **Visor**, más los permisos que se muestran en la tabla siguiente.
{: shortdesc}

<table>
<caption>Visión general de los mandatos de CLI y llamadas a API de gestión de clústeres que requieren el rol de plataforma de Operador en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="operator-mgmt">Acción de gestión de clústeres</th>
<th id="operator-cli">Mandato de CLI</th>
<th id="operator-api">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Renovar el nodo maestro de Kubernetes.</td>
<td><code>[ibmcloud ks apiserver-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>Crear un ID de servicio de {{site.data.keyword.Bluemix_notm}} IAM para el clúster, crear una política para el ID de servicio que signa el rol de **Lector** de acceso al servicio en {{site.data.keyword.registrylong_notm}} y crear una clave de API para el ID de servicio.</td>
<td><code>[ibmcloud ks cluster-pull-secret-apply](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_pull_secret_apply)</code></td>
<td>-</td>
</tr>
<tr>
<td>Reiniciar los nodos maestros del clúster para aplicar los nuevos cambios en la configuración de API de Kubernetes.</td>
<td><code>[ibmcloud ks cluster-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>Añadir una subred a un clúster.</td>
<td><code>[ibmcloud ks cluster-subnet-add](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_subnet_add)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterSubnet)</code></td>
</tr>
<tr>
<td>Crear una subred.</td>
<td><code>[ibmcloud ks cluster-subnet-create](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_subnet_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/vlans/{vlanId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateClusterSubnet)</code></td>
</tr>
<tr>
<td>Actualizar un clúster.</td>
<td><code>[ibmcloud ks cluster-update](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateCluster)</code></td>
</tr>
<tr>
<td>Añadir una subred gestionada por el usuario a un clúster.</td>
<td><code>[ibmcloud ks cluster-user-subnet-add](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_user_subnet_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Eliminar una subred gestionada por el usuario de un clúster.</td>
<td><code>[ibmcloud ks cluster-user-subnet-rm](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_user_subnet_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/usersubnets/{subnetId}/vlans/{vlanId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Añadir nodos trabajadores.</td>
<td><code>[ibmcloud ks worker-add (deprecated)](/docs/containers?topic=containers-cs_cli_reference#cs_worker_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterWorkers)</code></td>
</tr>
<tr>
<td>Crear una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks worker-pool-create](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateWorkerPool)</code></td>
</tr>
<tr>
<td>Volver a equilibrar una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks worker-pool-rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>Redimensionar una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks worker-pool-resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>Suprimir una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks worker-pool-rm](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveWorkerPool)</code></td>
</tr>
<tr>
<td>Rearrancar un nodo trabajador.</td>
<td><code>[ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Volver a cargar un nodo trabajador.</td>
<td><code>[ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Eliminar un nodo trabajador.</td>
<td><code>[ibmcloud ks worker-rm](/docs/containers?topic=containers-cs_cli_reference#cs_worker_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveClusterWorker)</code></td>
</tr>
<tr>
<td>Actualizar un nodo trabajador.</td>
<td><code>[ibmcloud ks worker-update](/docs/containers?topic=containers-cs_cli_reference#cs_worker_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Añadir una zona a una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks zone-add](/docs/containers?topic=containers-cs_cli_reference#cs_zone_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddWorkerPoolZone)</code></td>
</tr>
<tr>
<td>Actualizar la configuración de red para una zona determinada de una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks zone-network-set](/docs/containers?topic=containers-cs_cli_reference#cs_zone_network_set)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddWorkerPoolZoneNetwork)</code></td>
</tr>
<tr>
<td>Eliminar una zona de una agrupación de nodos trabajadores.</td>
<td><code>[ibmcloud ks zone-rm](/docs/containers?topic=containers-cs_cli_reference#cs_zone_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveWorkerPoolZone)</code></td>
</tr>
</tbody>
</table>

### Acciones de Administrador
{: #admin-actions}

El rol de plataforma de **Administrador** incluye todos los permisos otorgados por los roles de **Visor**, **Editor** y **Operador**, más los siguientes. Para crear recursos como máquinas, VLAN y subredes, los usuarios administradores necesitan el rol de la infraestructura de **Superusuario**<a href="#infra"></a>.
{: shortdesc}

<table>
<caption>Visión general de los mandatos de CLI y llamadas a API de gestión de clústeres que requieren el rol de plataforma de Administrador en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="admin-mgmt">Acción de gestión de clústeres</th>
<th id="admin-cli">Mandato de CLI</th>
<th id="admin-api">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Definir la clave de API para la cuenta de {{site.data.keyword.Bluemix_notm}} para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer) enlazada.</td>
<td><code>[ibmcloud ks api-key-reset](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_reset)</code></td>
<td><code>[POST /v1/keys](https://containers.cloud.ibm.com/swagger-api/#!/accounts/ResetUserAPIKey)</code></td>
</tr>
<tr>
<td>Inhabilitar un complemento gestionado, como Istio o Knative, en un clúster.</td>
<td><code>[ibmcloud ks cluster-addon-disable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>Habilitar un complemento gestionado, como Istio o Knative, en un clúster.</td>
<td><code>[ibmcloud ks cluster-addon-enable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>Obtener una lista de los complementos gestionados, como Istio o Knative, que están habilitados en un clúster.</td>
<td><code>[ibmcloud ks cluster-addons](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterAddons)</code></td>
</tr>
<tr>
<td>Crear un clúster gratuito o estándar. **Nota**: También se necesita el rol de plataforma de Administrador para {{site.data.keyword.registrylong_notm}} y el rol de infraestructura de Superusuario.</td>
<td><code>[ibmcloud ks cluster-create](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create)</code></td>
<td><code>[POST /v1/clusters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateCluster)</code></td>
</tr>
<tr>
<td>Inhabilitar una característica especificada para un clúster como, por ejemplo, el punto final de servicio público para el nodo maestro del clúster.</td>
<td><code>[ibmcloud ks cluster-feature-disable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_disable)</code></td>
<td>-</td>
</tr>
<tr>
<td>Habilitar una característica especificada para un clúster como, por ejemplo, el punto final de servicio privado para el nodo maestro del clúster.</td>
<td><code>[ibmcloud ks cluster-feature-enable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)</code></td>
<td>-</td>
</tr>
<tr>
<td>Obtener una lista de las características habilitadas de un clúster.</td>
<td><code>[ibmcloud ks cluster-features](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_ls)</code></td>
<td>-</td>
</tr>
<tr>
<td>Suprimir un clúster.</td>
<td><code>[ibmcloud ks cluster-rm](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveCluster)</code></td>
</tr>
<tr>
<td>Definir las credenciales de infraestructura para la cuenta de {{site.data.keyword.Bluemix_notm}} para acceder a otro portafolio de la infraestructura de IBM Cloud (SoftLayer).</td>
<td><code>[ibmcloud ks credential-set](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_set)</code></td>
<td><code>[POST /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/clusters/accounts/StoreUserCredentials)</code></td>
</tr>
<tr>
<td>Eliminar las credenciales de infraestructura para la cuenta de {{site.data.keyword.Bluemix_notm}} para acceder a otro portafolio de la infraestructura de IBM Cloud (SoftLayer).</td>
<td><code>[ibmcloud ks credential-unset](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_unset)</code></td>
<td><code>[DELETE /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/clusters/accounts/RemoveUserCredentials)</code></td>
</tr>
<tr>
<td>Cifrar secretos de Kubernetes mediante {{site.data.keyword.keymanagementservicefull}}.</td>
<td><code>[ibmcloud ks key-protect-enable](/docs/containers?topic=containers-cs_cli_reference#cs_messages)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/kms](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateKMSConfig)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>Visión general de los mandatos de CLI de Ingress y de las llamadas a API que requieren el rol de plataforma de Administrador en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="admin-ingress">Acción de Ingress</th>
<th id="admin-cli2">Mandato de CLI</th>
<th id="admin-api2">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Desplegar o actualizar un certificado desde la instancia de {{site.data.keyword.cloudcerts_long_notm}} en un ALB.</td>
<td><code>[ibmcloud ks alb-cert-deploy](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_deploy)</code></td>
<td><code>[POST /albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/CreateALBSecret) or [PUT /albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/UpdateALBSecret)</code></td>
</tr>
<tr>
<td>Ver detalles de un secreto de ALB en un clúster.</td>
<td><code>[ibmcloud ks alb-cert-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_get)</code></td>
<td><code>[GET /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ViewClusterALBSecrets)</code></td>
</tr>
<tr>
<td>Eliminar un secreto de ALB de un clúster.</td>
<td><code>[ibmcloud ks alb-cert-rm](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_rm)</code></td>
<td><code>[DELETE /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/DeleteClusterALBSecrets)</code></td>
</tr>
<tr>
<td>Obtener una lista de todos los secretos de ALB de un clúster.</td>
<td><code>[ibmcloud ks alb-certs](/docs/containers?topic=containers-cs_cli_reference#cs_alb_certs)</code></td>
<td>-</td>
</tr>
</tbody>
</table>

<table>
<caption>Visión general de los mandatos de CLI de registro y de las llamadas a API que requieren el rol de plataforma de Administrador en {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="admin-log">Acción de registro</th>
<th id="admin-cli3">Mandato de CLI</th>
<th id="admin-api3">Llamada a la API</th>
</thead>
<tbody>
<tr>
<td>Inhabilitar las actualizaciones automáticas para el complemento de clúster Fluentd.</td>
<td><code>[ibmcloud ks logging-autoupdate-disable](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_disable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Habilitar las actualizaciones automáticas para el complemento de clúster Fluentd.</td>
<td><code>[ibmcloud ks logging-autoupdate-enable](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_enable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Recopilar una instantánea de registros del servidor de API en un grupo de {{site.data.keyword.cos_full_notm}}.</td>
<td><code>[ibmcloud ks logging-collect](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect)</code></td>
<td>-</td>
</tr>
<tr>
<td>Ver el estado de la solicitud de instantánea de registros del servidor de API.</td>
<td><code>[ibmcloud ks logging-collect-status](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status)</code></td>
<td>-</td>
</tr>
<tr>
<td>Crear una configuración de reenvío de registro para el origen de registro <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cs_cli_reference#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>Suprimir una configuración de reenvío de registro para el origen de registro <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cs_cli_reference#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfig)</code></td>
</tr>
</tbody>
</table>

<br />


## Roles de servicio de {{site.data.keyword.Bluemix_notm}} IAM
{: #service}

A cada usuario que tiene asignado un rol de acceso al servicio de {{site.data.keyword.Bluemix_notm}} IAM también se le asigna automáticamente un rol de control de acceso basado en rol (RBAC) de Kubernetes correspondiente en un espacio de nombres específico. Para obtener más información sobre los roles de acceso al servicio, consulte [Roles de servicio de {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform). Para obtener más información sobre los roles RBAC, consulte [Asignación de permisos RBAC](/docs/containers?topic=containers-users#role-binding).
{: shortdesc}

¿Está buscando qué acciones de Kubernetes otorga cada rol de servicio a través de RBAC? Consulte [Permisos de recursos de Kubernetes por rol de RBAC](#rbac).
{: tip}

En la tabla siguiente se muestran los permisos de recursos de Kubernetes que asigna cada rol de servicio y su rol de RBAC correspondiente.

<table>
<caption>Permisos de recursos de Kubernetes por servicio y roles de RBAC correspondientes</caption>
<thead>
    <th id="service-role">Rol de servicio</th>
    <th id="rbac-role">Rol de RBAC correspondiente, vinculación y ámbito</th>
    <th id="kube-perm">Permisos de recursos de Kubernetes</th>
</thead>
<tbody>
  <tr>
    <td id="service-role-reader" headers="service-role">Rol de Lector</td>
    <td headers="service-role-reader rbac-role">Cuando se limita a un espacio de nombres: Rol de clúster <strong><code>view</code></strong> aplicado por la vinculación de rol <strong><code>ibm-view</code></strong> en dicho espacio de nombres</br><br>Cuando se aplica a todos los espacios de nombres: Rol de clúster <strong><code>view</code></strong> aplicado por la vinculación de rol <strong><code>ibm-view</code></strong> en cada espacio de nombres del clúster</td>
    <td headers="service-role-reader kube-perm"><ul>
      <li>Acceso de lectura a los recursos de un espacio de nombres</li>
      <li>Sin acceso de lectura a los roles y vinculaciones de rol ni a secretos de Kubernetes</li>
      <li>Acceso al panel de control de Kubernetes para ver los recursos de un espacio de nombres</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-writer" headers="service-role">Rol de Escritor</td>
    <td headers="service-role-writer rbac-role">Cuando se limita a un espacio de nombres: Rol de clúster <strong><code>edit</code></strong> aplicado por la vinculación de rol <strong><code>ibm-edit</code></strong> en dicho espacio de nombres</br><br>Cuando se aplica a todos los espacios de nombres: Rol de clúster <strong><code>edit</code></strong> aplicado por la vinculación de rol <strong><code>ibm-edit</code></strong> en cada espacio de nombres del clúster</td>
    <td headers="service-role-writer kube-perm"><ul><li>Acceso de lectura/escritura a los recursos de un espacio de nombres</li>
    <li>Sin acceso de lectura/escritura a los roles y vinculaciones de rol</li>
    <li>Acceso al panel de control de Kubernetes para ver los recursos de un espacio de nombres</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-manager" headers="service-role">Rol de Gestor</td>
    <td headers="service-role-manager rbac-role">Cuando se limita a un espacio de nombres: Rol de clúster <strong><code>admin</code></strong> aplicado por la vinculación de rol <strong><code>ibm-operate</code></strong> en dicho espacio de nombres</br><br>Cuando se aplica a todos los espacios de nombres: Rol de clúster <strong><code>cluster-admin</code></strong> aplicado por la vinculación de rol de clúster <strong><code>ibm-admin</code></strong></td> que se aplica a todos los espacios de nombres
    <td headers="service-role-manager kube-perm">Cuando se limita a un espacio de nombres:
      <ul><li>Acceso de lectura/escritura a todos los recursos de un espacio de nombres, pero no a la cuota de recursos ni al propio espacio de nombres</li>
      <li>Crear roles de RBAC y vinculaciones de rol en un espacio de nombres</li>
      <li>Acceso al panel de control de Kubernetes para ver todos los recursos de un espacio de nombres</li></ul>
    </br>Cuando se aplica a todos los espacios de nombres:
        <ul><li>Acceso de lectura/escritura a todos los recursos de cada espacio de nombres</li>
        <li>Crear roles de RBAC y vinculaciones de rol en un espacio de nombres o en roles de clúster y vinculaciones de rol de clúster en todos los espacios de nombres</li>
        <li>Acceder al panel de control de Kubernetes</li>
        <li>Crear un recurso Ingress que ponga las apps a disponibilidad pública</li>
        <li>Revisar las métricas del clúster, como por ejemplo con los mandatos <code>kubectl top pods</code>, <code>kubectl top nodes</code> o <code>kubectl get nodes</code></li></ul>
    </td>
  </tr>
</tbody>
</table>

<br />


## Permisos de recursos de Kubernetes por rol de RBAC
{: #rbac}

A cada usuario que tiene asignado un rol de acceso al servicio de {{site.data.keyword.Bluemix_notm}} IAM también se le asigna automáticamente un rol de control de acceso basado en rol (RBAC) de Kubernetes predefinido correspondiente. Si tiene intención de gestionar sus propios roles personalizados de RBAC de Kubernetes, consulte el apartado sobre [Creación de permisos de RBAC personalizados para usuarios, grupos o cuentas de servicio](/docs/containers?topic=containers-users#rbac).
{: shortdesc}

¿Se pregunta si tiene los permisos correctos para ejecutar un determinado mandato `kubectl` en un recurso de un espacio de nombres? Pruebe el [mandato `kubectl auth can-i`![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-can-i-em-).
{: tip}

En la tabla siguiente se muestran los permisos que otorga cada rol de RBAC a recursos de Kubernetes individuales. Los permisos se muestran como verbos que un usuario con ese rol puede ejecutar sobre el recurso, como por ejemplo "get", "list", "describe", "create" o "delete".

<table>
 <caption>Permisos de recursos de Kubernetes otorgados por cada rol de RBAC predefinido</caption>
 <thead>
  <th>Recursos de Kubernetes</th>
  <th><code>view</code></th>
  <th><code>edit</code></th>
  <th><code>admin</code> y <code>cluster-admin</code></th>
 </thead>
<tbody>
<tr>
  <td>bindings</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>configmaps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>cronjobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.apps </td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>endpoints</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>events</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>horizontalpodautoscalers.autoscaling</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>ingresses.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>jobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>limitranges</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>localsubjectaccessreviews</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code></td>
</tr><tr>
  <td>namespaces</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></br>**cluster-admin only:** <code>create</code>, <code>delete</code></td>
</tr><tr>
  <td>namespaces/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>persistentvolumeclaims</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>poddisruptionbudgets.policy</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>top</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/attach</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/exec</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/log</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/portforward</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>rolebindings</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>roles</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>secretos</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>serviceaccounts</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
</tr><tr>
  <td>servicios</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>services/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr>
</tbody>
</table>

<br />


## Roles de Cloud Foundry
{: #cloud-foundry}

Los roles de Cloud Foundry otorgan acceso a las organizaciones y espacios dentro de la cuenta. Para ver la lista de servicios basados en Cloud Foundry de {{site.data.keyword.Bluemix_notm}}, ejecute `ibmcloud service list`. Para obtener más información, consulte todos los [roles de espacio y organización](/docs/iam?topic=iam-cfaccess) disponibles o los pasos para [gestionar el acceso a Cloud Foundry](/docs/iam?topic=iam-mngcf) en la documentación de {{site.data.keyword.Bluemix_notm}} IAM.
{: shortdesc}

En la tabla siguiente se muestran los roles de Cloud Foundry necesarios para los permisos de acción de clúster.

<table>
  <caption>Permisos de gestión de clúster por rol de Cloud Foundry</caption>
  <thead>
    <th>Rol de Cloud Foundry</th>
    <th>Permisos de gestión de clústeres</th>
  </thead>
  <tbody>
  <tr>
    <td>Rol de espacio: Gestor</td>
    <td>Gestionar el acceso de los usuarios a un espacio de {{site.data.keyword.Bluemix_notm}}</td>
  </tr>
  <tr>
    <td>Rol del espacio: Desarrollador</td>
    <td>
      <ul><li>Crear instancias de servicio de {{site.data.keyword.Bluemix_notm}}</li>
      <li>Enlazar instancias de servicio de {{site.data.keyword.Bluemix_notm}} a clústeres</li>
      <li>Ver registros de la configuración de reenvío de registros de un clúster a nivel de espacio</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## Roles de la infraestructura
{: #infra}

Cuando un usuario con el rol de acceso de la infraestructura de **Superusuario** [establece la clave de API para una región y un grupo de recursos](/docs/containers?topic=containers-users#api_key), los permisos de la infraestructura para otros usuarios de la cuenta se establecen mediante roles de la plataforma {{site.data.keyword.Bluemix_notm}} IAM. No es necesario que edite los permisos de la infraestructura de IBM Cloud (SoftLayer) de otros usuarios. Utilice la tabla siguiente únicamente para personalizar los permisos de la infraestructura de IBM Cloud (SoftLayer) de los usuarios cuando no pueda asignar el rol de **Superusuario** al usuario que establece la clave de API. Para obtener más información, consulte [Personalización de permisos de la infraestructura](/docs/containers?topic=containers-users#infra_access).
{: shortdesc}

En la tabla siguiente se muestran los permisos de la infraestructura necesarios para completar grupos de tareas comunes.

<table>
 <caption>Permisos de infraestructura necesarios habitualmente para {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Tareas comunes en {{site.data.keyword.containerlong_notm}}</th>
  <th>Permisos de infraestructura necesarios por categoría</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Permisos mínimos</strong>: <ul><li>Cree un clúster.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Ver detalles de servidores virtuales</li><li>Rearrancar servidor y ver información del sistema IPMI</li><li>Emitir recargas de SO e iniciar el kernel de rescate</li></ul><strong>Cuenta</strong>: <ul><li>Añadir servidor</li></ul></td>
   </tr>
   <tr>
     <td><strong>Administración de clúster</strong>: <ul><li>Crear, actualizar y suprimir clústeres.</li><li>Añadir, cargar y rearrancar nodos trabajadores.</li><li>Ver VLAN.</li><li>Crear subredes.</li><li>Desplegar pods y servicios del equilibrador de carga.</li></ul></td>
     <td><strong>Soporte</strong>:<ul><li>Ver incidencias</li><li>Añadir incidencias</li><li>Editar incidencias</li></ul>
     <strong>Dispositivos</strong>:<ul><li>Ver detalles de hardware</li><li>Ver detalles de servidores virtuales</li><li>Rearrancar servidor y ver información del sistema IPMI</li><li>Emitir recargas de SO e iniciar el kernel de rescate</li></ul>
     <strong>Red</strong>:<ul><li>Añadir sistema con puerto de red pública</li></ul>
     <strong>Cuenta</strong>:<ul><li>Cancelar servidor</li><li>Añadir servidor</li></ul></td>
   </tr>
   <tr>
     <td><strong>Almacenamiento</strong>: <ul><li>Crear reclamaciones de volumen persistente para suministrar volúmenes persistentes.</li><li>Crear y gestionar recursos de infraestructura de almacenamiento.</li></ul></td>
     <td><strong>Servicios</strong>:<ul><li>Gestionar almacenamiento</li></ul><strong>Cuenta</strong>:<ul><li>Añadir almacenamiento</li></ul></td>
   </tr>
   <tr>
     <td><strong>Gestión de redes privadas</strong>: <ul><li>Gestionar VLAN privadas para redes en clúster.</li><li>Configurar conectividad de VPN en redes privadas.</li></ul></td>
     <td><strong>Red</strong>:<ul><li>Gestionar rutas de subredes de la red</li></ul></td>
   </tr>
   <tr>
     <td><strong>Gestión de redes públicas</strong>:<ul><li>Configurar las redes públicas de Ingress y del equilibrador de carga para exponer apps.</li></ul></td>
     <td><strong>Dispositivos</strong>:<ul><li>Editar nombre de host/dominio</li><li>Gestionar control de puertos</li></ul>
     <strong>Red</strong>:<ul><li>Añadir sistema con puerto de red pública</li><li>Gestionar rutas de subredes de la red</li><li>Añadir direcciones IP</li></ul>
     <strong>Servicios</strong>:<ul><li>Gestionar DNS, DNS inverso y WHOIS</li><li>Ver certificados (SSL)</li><li>Gestionar certificados (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
