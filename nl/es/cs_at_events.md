---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Sucesos de {{site.data.keyword.cloudaccesstrailshort}}
{: #at_events}

Puede ver, gestionar y auditar las actividades que ha realizado el usuario en el clúster de {{site.data.keyword.containerlong_notm}} mediante el servicio {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

{{site.data.keyword.containershort_notm}} genera dos tipos de sucesos de {{site.data.keyword.cloudaccesstrailshort}}:

* **Sucesos de gestión de clústeres**:
    * Estos sucesos se generan automáticamente y se reenvían a {{site.data.keyword.cloudaccesstrailshort}}.
    * Puede ver estos sucesos a través del **dominio de cuenta** de {{site.data.keyword.cloudaccesstrailshort}}.

* **Sucesos de auditoría de servidor de API de Kubernetes**:
    * Estos sucesos se generan automáticamente, pero debe configurar el clúster para reenviar estos sucesos al servicio {{site.data.keyword.cloudaccesstrailshort}}.
    * Puede configurar el clúster para que envíe sucesos al **dominio de cuenta** de {{site.data.keyword.cloudaccesstrailshort}} o a un **dominio de espacio**. Para obtener más información, consulte [Envío de registros de auditoría](/docs/containers/cs_health.html#api_forward).

Para obtener más información sobre el funcionamiento del servicio, consulte la [documentación de {{site.data.keyword.cloudaccesstrailshort}}](/docs/services/cloud-activity-tracker/index.html). Para obtener más información sobre las acciones de Kubernetes de las que se realiza un seguimiento, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/home/).

## Búsqueda de información sobre sucesos
{: #kube-find}

Para supervisar la actividad administrativa:

1. Inicie sesión en su cuenta de {{site.data.keyword.Bluemix_notm}}.
2. Desde el catálogo, suministre una instancia del servicio {{site.data.keyword.cloudaccesstrailshort}} en la misma cuenta que la instancia de {{site.data.keyword.containerlong_notm}}.
3. En el separador **Gestión** del panel de control de {{site.data.keyword.cloudaccesstrailshort}}, seleccione la cuenta o el dominio de espacio.
  * **Registros de cuenta**: los sucesos de gestión de clúster y los sucesos de auditoría de servidor de API de Kubernetes están disponibles en el **dominio de cuenta** para la región de {{site.data.keyword.Bluemix_notm}} donde se generan los sucesos.
  * **Registros de espacio**: si ha especificado un espacio al configurar el clúster para reenviar sucesos de auditoría de servidor de API de Kubernetes, estos sucesos están disponibles en el **dominio de espacio** asociado al espacio de Cloud Foundry donde se ha suministrado el servicio {{site.data.keyword.cloudaccesstrailshort}}.
4. Pulse **Ver en Kibana**.
5. Establezca el intervalo de tiempo para el que desea ver los registros. El valor predeterminado es 24 horas.
6. Para reducir la búsqueda, puede pulsar el icono de edición correspondiente a `ActivityTracker_Account_Search_in_24h` y añadir campos en la columna **Campos disponibles**.

Para permitir que otros usuarios vean sucesos de cuenta y espacio, consulte [Concesión de permisos para ver sucesos de cuentas](/docs/services/cloud-activity-tracker/how-to/grant_permissions.html#grant_permissions).
{: tip}

## Seguimiento de sucesos de gestión de clústeres
{: #cluster-events}

Consulte la lista siguiente de sucesos de gestión de clústeres que se envían a {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

<table>
<tr>
<th>Acción</th>
<th>Descripción</th></tr><tr>
<td><code>containers-kubernetes.account-credentials.set</code></td>
<td>Se han establecido las credenciales de infraestructura en una región para un grupo de recursos.</td></tr><tr>
<td><code>containers-kubernetes.account-credentials.unset</code></td>
<td>No se han establecido las credenciales de infraestructura en una región para un grupo de recursos.</td></tr><tr>
<td><code>containers-kubernetes.alb.create</code></td>
<td>Se ha creado un ALB Ingress.</td></tr><tr>
<td><code>containers-kubernetes.alb.delete</code></td>
<td>Se ha suprimido un ALB Ingress.</td></tr><tr>
<td><code>containers-kubernetes.alb.get</code></td>
<td>Se ha visualizado la información de ALB Ingress.</td></tr><tr>
<td><code>containers-kubernetes.apikey.reset</code></td>
<td>Se ha restablecido una clave de API para una región y un grupo de recursos.</td></tr><tr>
<td><code>containers-kubernetes.cluster.create</code></td>
<td>Se ha creado un clúster.</td></tr><tr>
<td><code>containers-kubernetes.cluster.delete</code></td>
<td>Se ha suprimido un clúster.</td></tr><tr>
<td><code>containers-kubernetes.cluster-feature.enable</code></td>
<td>Se ha habilitado en un clúster una característica, como por ejemplo el cálculo de confianza para los nodos trabajadores nativos.</td></tr><tr>
<td><code>containers-kubernetes.cluster.get</code></td>
<td>Se ha visualizado información del clúster.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.create</code></td>
<td>Se ha creado una configuración de reenvío de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.delete</code></td>
<td>Se ha suprimido una configuración de reenvío de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.get</code></td>
<td>Se ha visualizado información de una configuración de reenvío de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.update</code></td>
<td>Se ha actualizado una configuración de reenvío de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-config.refresh</code></td>
<td>Se ha renovado una configuración de reenvío de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.create</code></td>
<td>Se ha creado un filtro de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.delete</code></td>
<td>Se ha suprimido un filtro de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.get</code></td>
<td>Se ha visualizado información de un filtro de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-filter.update</code></td>
<td>Se ha actualizado un filtro de registro.</td></tr><tr>
<td><code>containers-kubernetes.logging-autoupdate.changed</code></td>
<td>El actualizador automático del complemento de registro se ha habilitado o inhabilitado.</td></tr><tr>
<td><code>containers-kubernetes.mzlb.create</code></td>
<td>Se ha creado un equilibrador de carga multizona.</td></tr><tr>
<td><code>containers-kubernetes.mzlb.delete</code></td>
<td>Se ha suprimido un equilibrador de carga multizona.</td></tr><tr>
<td><code>containers-kubernetes.service.bind</code></td>
<td>Se ha enlazado un servicio a un clúster.</td></tr><tr>
<td><code>containers-kubernetes.service.unbind</code></td>
<td>Se ha desenlazado un servicio de un clúster.</td></tr><tr>
<td><code>containers-kubernetes.subnet.add</code></td>
<td>Se ha añadido a un clúster una subred de la infraestructura de IBM Cloud (SoftLayer) existente.</td></tr><tr>
<td><code>containers-kubernetes.subnet.create</code></td>
<td>Se ha creado una subred.</td></tr><tr>
<td><code>containers-kubernetes.usersubnet.add</code></td>
<td>Se ha añadido a un clúster una subred gestionada por el usuario.</td></tr><tr>
<td><code>containers-kubernetes.usersubnet.delete</code></td>
<td>Se ha eliminado de un clúster una subred gestionada por el usuario.</td></tr><tr>
<td><code>containers-kubernetes.version.update</code></td>
<td>Se ha actualizado la versión de Kubernetes de un nodo maestro de clúster.</td></tr><tr>
<td><code>containers-kubernetes.worker.create</code></td>
<td>Se ha creado un nodo trabajador.</td></tr><tr>
<td><code>containers-kubernetes.worker.delete</code></td>
<td>Se ha suprimido un nodo trabajador.</td></tr><tr>
<td><code>containers-kubernetes.worker.get</code></td>
<td>Se ha visualizado información de un nodo trabajador.</td></tr><tr>
<td><code>containers-kubernetes.worker.reboot</code></td>
<td>Se ha reiniciado un nodo trabajador.</td></tr><tr>
<td><code>containers-kubernetes.worker.reload</code></td>
<td>Se ha vuelto a cargar un nodo trabajador.</td></tr><tr>
<td><code>containers-kubernetes.worker.update</code></td>
<td>Se ha actualizado un nodo trabajador.</td></tr>
</table>

## Seguimiento de sucesos de auditoría de Kubernetes
{: #kube-events}

Consulte la tabla siguiente para ver una lista de los sucesos de auditoría del servidor de API de Kubernetes que se envían a {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

Antes de empezar: asegúrese de que el clúster está configurado para reenviar [Sucesos de auditoría de API de Kubernetes](cs_health.html#api_forward).

<table>
  <tr>
    <th>Acción</th>
    <th>Descripción</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>Se ha creado un enlace.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>Se ha creado una solicitud para firmar un certificado.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>Se ha suprimido una solicitud para firmar un certificado.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>Se ha aplicado un parche a una solicitud para firmar un certificado.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>Se ha actualizado una solicitud para firmar un certificado.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>Se ha creado un enlace de rol de clúster.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>Se ha suprimido un enlace de rol de clúster.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>Se ha aplicado un parche a un enlace de rol de clúster.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>Se ha actualizado un enlace de rol de clúster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>Se ha creado un rol de clúster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>Se ha suprimido un rol de clúster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>Se ha aplicado un parche a un rol de clúster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>Se ha actualizado un rol de clúster.</td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>Se ha creado un mapa de configuración.</td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>Se ha suprimido un mapa de configuración.</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>Se ha aplicado un parche a un mapa de configuración.</td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>Se ha actualizado un mapa de configuración.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>Se ha creado una revisión de controlador.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>Se ha suprimido una revisión de controlador.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>Se ha aplicado un parche a una revisión de controlador.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>Se ha actualizado una revisión de controlador.</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>Se ha creado un conjunto de daemons.</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>Se ha suprimido un conjunto de daemons.</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>Se ha aplicado un parche a un conjunto de daemons.</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>Se ha actualizado un conjunto de daemons.</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>Se ha creado un despliegue.</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>Se ha suprimido un despliegue.</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>Se ha aplicado un parche a un despliegue.</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>Se ha actualizado un despliegue.</td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>Se ha creado un suceso.</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>Se ha suprimido un suceso.</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>Se ha aplicado un parche a un suceso.</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>Se ha actualizado un suceso.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>En Kubernetes v1.8, se ha creado una configuración de hook de admisiones externo.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>En Kubernetes v1.8, se ha suprimido una configuración de hook de admisiones externo.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>En Kubernetes v1.8, se ha aplicado un parche a una configuración de hook de admisiones externo.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>En Kubernetes v1.8, se ha actualizado una configuración de hook de admisiones externo.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>Se ha creado una política de escalado automático de pod horizontal.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>Se ha suprimido una política de escalado automático de pod horizontal.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>Se ha aplicado un parche a una política de escalado automático de pod horizontal.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>Se ha actualizado una política de escalado automático de pod horizontal.</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>Se ha creado un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>Se ha suprimido un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>Se ha aplicado un parche a un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>Se ha actualizado un ALB Ingress.</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>Se ha creado un trabajo.</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>Se ha suprimido un trabajo.</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>Se ha aplicado un parche a un trabajo.</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>Se ha actualizado un trabajo.</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>Se ha creado una revisión de acceso de asunto local.</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>Se ha creado un límite de rango.</td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>Se ha suprimido un límite de rango.</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>Se ha aplicado un parche a un límite de rango.</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>Se ha actualizado un límite de rango.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha creado una configuración de webhook mutante.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha suprimido una configuración de webhook mutante.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha aplicado un parche a una configuración de webhook mutante.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha actualizado una configuración de webhook mutante.</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>Se ha creado un espacio de nombres.</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>Se ha suprimido un espacio de nombres.</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>Se ha aplicado un parche a un espacio de nombres.</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>Se ha actualizado un espacio de nombres.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>Se ha creado una política de red.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>Se ha suprimido una política de red.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>Se ha aplicado un parche a una política de red.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>Se ha actualizado una política de red.</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>Se ha creado un nodo.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>Se ha suprimido un nodo.</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>Se ha aplicado un parche a un nodo.</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>Se ha actualizado un nodo.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>Se ha creado una reclamación de volumen persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>Se ha suprimido una reclamación de volumen persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>Se ha aplicado un parche a una reclamación de volumen persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>Se ha actualizado una reclamación de volumen persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>Se ha creado un volumen persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>Se ha suprimido un volumen persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>Se ha aplicado un parche a un volumen persistente.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>Se ha actualizado un volumen persistente.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.create</code></td>
    <td>Se ha creado un presupuesto de interrupción de pod.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.delete</code></td>
    <td>Se ha suprimido un presupuesto de interrupción de pod.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.patch</code></td>
    <td>Se ha aplicado un parche a un presupuesto de interrupción de pod.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.update</code></td>
    <td>Se ha actualizado un presupuesto de interrupción de pod.</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>Se ha creado un pod preestablecido.</td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>Se ha suprimido un pod preestablecido.</td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>Se ha aplicado un parche a un pod preestablecido.</td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>Se ha actualizado un pod preestablecido.</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>Se ha creado un pod.</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>Se ha suprimido un pod.</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>Se ha aplicado un parche a un pod.</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>Se ha actualizado un pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>Para Kubernetes v1.10 y superior, se ha creado una política de seguridad de pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>Para Kubernetes v1.10 y superior, se ha suprimido una política de seguridad de pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>Para Kubernetes v1.10 y superior, se ha aplicado un parche a una política de seguridad de pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>Para Kubernetes v1.10 y superior, se ha actualizado una política de seguridad de pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>Se ha creado una plantilla de pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>Se ha suprimido una plantilla de pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>Se ha aplicado un parche a una plantilla de pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>Se ha actualizado una plantilla de pod.</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>Se ha creado un conjunto de réplicas.</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>Se ha suprimido un conjunto de réplicas.</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>Se ha aplicado un parche a un conjunto de réplicas.</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>Se ha actualizado un conjunto de réplicas.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>Se ha creado un controlador de réplicas.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>Se ha suprimido un controlador de réplicas.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>Se ha aplicado un parche a un controlador de réplicas.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>Se ha actualizado un controlador de réplicas.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>Se ha creado una cuota de recursos.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>Se ha suprimido una cuota de recursos.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>Se ha aplicado un parche a una cuota de recursos.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>Se ha actualizado una cuota de recursos.</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>Se ha creado un enlace de rol.</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>Se ha suprimido un enlace de rol.</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>Se ha aplicado un parche a un enlace de rol.</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>Se ha actualizado un enlace de rol.</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>Se ha creado un rol.</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>Se ha suprimido un rol.</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>Se ha aplicado un parche a un rol.</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>Se ha actualizado un rol.</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>Se ha creado un secreto.</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>Se ha suprimido un secreto.</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>Se ha visto un secreto.</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>Se ha aplicado un parche a un secreto.</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>Se ha actualizado un secreto.</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>Se ha creado una revisión de acceso de asunto propio.</td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>Se ha creado una revisión de reglas de asuntos propios.</td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>Se ha creado una revisión de acceso de asunto.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>Se ha creado una cuenta de servicio.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>Se ha suprimido una cuenta de servicio.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>Se ha aplicado un parche a una cuenta de servicio.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>Se ha actualizado una cuenta de servicio.</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>Se ha creado un servicio.</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>Se ha suprimido un servicio.</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>Se ha aplicado un parche a un servicio.</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>Se ha actualizado un servicio.</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>Se ha creado un conjunto con estado.</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>Se ha suprimido un conjunto con estado.</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>Se ha aplicado un parche a un conjunto con estado.</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>Se ha actualizado un conjunto con estado.</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>Se ha creado una revisión de señal.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha creado una validación de configuración de webhook.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha suprimido una validación de configuración de webhook.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha aplicado un parche a una validación de configuración de webhook.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>En Kubernetes v1.9 y posteriores, se ha actualizado una validación de configuración de webhook.</td>
  </tr>
</table>
