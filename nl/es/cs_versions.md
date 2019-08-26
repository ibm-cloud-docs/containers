---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-30"

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
{:note: .note}


# Información de versión y acciones de actualización
{: #cs_versions}

## Tipos de versión de Kubernetes
{: #version_types}

{{site.data.keyword.containerlong}} da soporte a varias versiones de Kubernetes simultáneamente. Cuando se publica una versión más reciente (n), se da soporte a hasta 2 versiones anteriores (n-2). Las versiones anteriores a 2 versiones anteriores a la versión más reciente (n-3) son las primeras que quedan en desuso y a las que se deja de dar soporte.
{:shortdesc}


**Versiones soportadas de Kubernetes**:
*   Más reciente: 1.14.4
*   Predeterminada: 1.13.8
*   Otra: 1.12.10

**Versiones en desuso y no soportadas de Kubernetes**:
*   En desuso: N/D
*   Sin soporte: 1.5, 1.7, 1.8, 1.9, 1.10, 1.11  

</br>

**Versiones en desuso**: cuando los clústeres se ejecutan en una versión en desuso de Kubernetes, tiene un mínimo de 45 días para revisar y actualizar a una versión soportada de Kubernetes antes de que la versión deje de estar soportada. Durante el periodo de desuso, el clúster sigue siendo funcional, pero es posible que necesite actualizaciones a un release con soporte para arreglar vulnerabilidades de seguridad. Por ejemplo, puede añadir y volver a cargar nodos trabajadores, pero no puede crear nuevos clústeres que utilicen la versión en desuso si para la fecha en que se deja de dar soporte faltan 45 días o menos.

**Versiones no soportadas**: si los clústeres ejecutan una versión de Kubernetes que no está soportada, revise los siguientes impactos potenciales de la actualización y, a continuación, [actualice inmediatamente el clúster](/docs/containers?topic=containers-update#update) para seguir recibiendo actualizaciones importantes de seguridad y soporte. Los clústeres no soportados no pueden añadir ni volver a cargar nodos trabajadores existentes. Para saber si su clúster **no recibe soporte**, examine el campo **State** (Estado) de la salida del mandato `ibmcloud ks clusters` o en la [consola de {{site.data.keyword.containerlong_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/kubernetes/clusters).

Si espera hasta que el clúster esté tres o más versiones menores por detrás de la versión soportada más antigua, no puede actualizar el clúster. En ese caso, debe [crear un nuevo clúster](/docs/containers?topic=containers-clusters#clusters), [desplegar las apps](/docs/containers?topic=containers-app#app) en el nuevo clúster y [suprimir](/docs/containers?topic=containers-remove) el clúster no soportado.<br><br>Para evitar este problema, actualice los clústeres en desuso a una versión soportada que esté menos de tres versiones por delante de la versión actual, como por ejemplo de la 1.11 a la 1.12 y, a continuación, actualice a la versión más reciente, 1.14. Si los nodos trabajadores ejecutan una versión que está tres o más por detrás del nodo maestro, es posible que los pods fallen y entren en un estado como `MatchNodeSelector`, `CrashLoopBackOff` o `ContainerCreating` hasta que actualice los nodos trabajadores a la misma versión que el nodo maestro. Después de actualizar de una versión en desuso a una soportada, el clúster puede reanudar las operaciones normales y seguir recibiendo soporte.
{: important}

</br>

Para comprobar la versión del servidor de un clúster, ejecute el mandato siguiente.
```
kubectl version  --short | grep -i server
```
{: pre}

Salida de ejemplo:
```
Versión del servidor: v1.13.8+IKS
```
{: screen}


## Tipos de actualización
{: #update_types}

El clúster de Kubernetes tiene tres tipos de actualizaciones: mayores, menores y parches.
{:shortdesc}

|Tipo actualización|Ejemplos de etiquetas de versión|Actualizado por|Impacto
|-----|-----|-----|-----|
|Mayor|1.x.x|Usuario|Operación de clústeres de cambios, incluyendo scripts o despliegues.|
|Menor|x.9.x|Usuario|Operación de clústeres de cambios, incluyendo scripts o despliegues.|
|Parche|x.x.4_1510|IBM y el usuario|Parches de Kubernetes, así como otras actualizaciones de componentes de Proveedor de {{site.data.keyword.cloud_notm}} como, por ejemplo, parches de seguridad y del sistema operativo. IBM actualiza los maestros automáticamente, pero el usuario debe aplicar los parches a los nodos trabajadores. Consulte más información sobre los parches en la sección siguiente.|
{: caption="Consecuencias en las actualizaciones de Kubernetes" caption-side="top"}

A medida que las actualizaciones pasan a estar disponibles, se le notifica cuando visualiza información sobre los nodos trabajadores, por ejemplo con los mandatos `ibmcloud ks workers --cluster <cluster>` o `ibmcloud ks worker-get --cluster <cluster> --worker <worker>`.
-  **Actualizaciones menores y mayores (1.x)**: En primer lugar, [actualice el nodo maestro](/docs/containers?topic=containers-update#master) y, a continuación, [actualice los nodos trabajadores](/docs/containers?topic=containers-update#worker_node). Los nodos trabajadores no pueden ejecutar una versión mayor o menor de Kubernetes que sea posterior a la de los nodos maestros.
   - No se puede actualizar un nodo maestro de Kubernetes tres o más versiones menores al mismo tiempo. Por ejemplo, si el nodo maestro actual tiene la versión 1.11 y desea actualizar a la versión 1.14, primero debe actualizar a la versión 1.12.
   - Si utiliza una versión de CLI `kubectl` que coincide al menos con la versión `major.minor` de los clústeres, puede experimentar resultados inesperados. Mantenga actualizadas las [versiones de la CLI](/docs/containers?topic=containers-cs_cli_install#kubectl) y el clúster de Kubernetes.
-  **Actualizaciones de parches (x.x.4_1510)**: Los cambios entre parches están documentados en el [Registro de cambios de versión](/docs/containers?topic=containers-changelog). Los parches maestros se aplican automáticamente, pero el usuario debe iniciar las actualizaciones de parches de los nodos trabajadores. Los nodos maestros también puede ejecutar versiones de parches que sean posteriores a las de los nodos maestros. A medida que las actualizaciones estén disponibles, se le notificará cuando visualice información sobre los nodos trabajadores y maestro en la CLI o consola de {{site.data.keyword.cloud_notm}}, como por ejemplo con los siguientes mandatos: `ibmcloud ks clusters`, `cluster-get`, `workers` o `worker-get`.
   - **Parches de nodo trabajador**: compruebe cada mes si hay una actualización disponible y utilice el [mandato](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) `ibmcloud ks worker-update` o el [mandato](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) `ibmcloud ks worker-reload` para aplicar estos parches de seguridad y de sistema operativo. Durante una actualización o recarga, se creará de nuevo la imagen de la máquina del nodo trabajador y se suprimirán los datos si no se [almacenan fuera del nodo trabajador](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).
   - **Parches maestros**: los parches maestros se aplican automáticamente durante el curso de varios días, por lo que una versión de parche maestro podría aparecer como disponible antes de que se aplique a su nodo maestro. La automatización de actualizaciones también pasa por alto los clústeres que están en un estado no saludable o que tienen operaciones actualmente en curso. Ocasionalmente, IBM podría inhabilitar las actualizaciones automáticas para un fixpack maestro específico, tal como se indica en el registro de cambios, como un parche que solo sea necesario si se actualiza un nodo maestro de una versión menor a otra. En cualquiera de estos casos, puede utilizar el [mandato](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update) `ibmcloud ks cluster-update` de forma seguro por su cuenta sin esperar a que se aplique una automatización de actualización.

</br>

{: #prep-up}
Esta información resume las actualizaciones que pueden tener un probable impacto sobre las apps desplegadas al actualizar un clúster a una nueva versión desde la versión anterior.

-  [Acciones de preparación](#cs_v114) de la versión 1.14.
-  [Acciones de preparación](#cs_v113) de la versión 1.13.
-  [Acciones de preparación](#cs_v112) de la versión 1.12.
-  [Archivo](#k8s_version_archive) de versiones no soportadas.

<br/>

Para ver una lista completa de cambios, revise la siguiente información:
* [Registro de cambios de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Registro de cambios de versión de IBM](/docs/containers?topic=containers-changelog).

</br>

## Historial de releases
{: #release-history}

En la tabla siguiente se registra el historial de releases de versiones de {{site.data.keyword.containerlong_notm}}. Puede utilizar esta información con fines de planificación, como por ejemplo para calcular cuándo un determinado release puede dejar de recibir soporte. Después de que la comunidad de Kubernetes publica una actualización de una versión, el equipo de IBM inicia un proceso de prueba del release para entornos de {{site.data.keyword.containerlong_notm}}. La fecha de disponibilidad y la fecha en que se deja de dar soporte a un release dependen de los resultados de estas pruebas, de las actualizaciones de la comunidad, de los parches de seguridad y de los cambios tecnológicos entre las versiones. Planifique para mantener actualizada la versión del nodo maestro y trabajador del clúster según la política de soporte de versión `n-2`.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} pasó a estar disponible a nivel general por primera vez con Kubernetes versión 1.5. Las fechas planificadas de lanzamiento de un release y las fechas en que se deja de dar soporte a un release están sujetas a cambios. Para ver los pasos de preparación de actualización de versión, pulse el número de versión.

Las fechas que están marcadas con el símbolo `†` son provisionales y están sujetas a cambios.
{: important}

<table summary="Esta tabla muestra el historial de releases de {{site.data.keyword.containerlong_notm}}.">
<caption>Historial de releases de {{site.data.keyword.containerlong_notm}}.</caption>
<col width="20%" align="center">
<col width="20%">
<col width="30%">
<col width="30%">
<thead>
<tr>
<th>¿Recibe soporte?</th>
<th>Versión</th>
<th>{{site.data.keyword.containerlong_notm}}<br>Fecha de lanzamiento</th>
<th>{{site.data.keyword.containerlong_notm}}<br>Fecha en que deja de recibir soporte</th>
</tr>
</thead>
<tbody>  
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión recibe soporte."/></td>
  <td>[1.14](#cs_v114)</td>
  <td>7 de mayo de 2019</td>
  <td>Abril de 2020 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión recibe soporte."/></td>
  <td>[1.13](#cs_v113)</td>
  <td>5 de febrero de 2019</td>
  <td>Enero de 2020 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión recibe soporte."/></td>
  <td>[1.12](#cs_v112)</td>
  <td>7 de noviembre de 2018</td>
  <td>Octubre de 2019 `†`</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión no recibe soporte."/></td>
  <td>[1.11](#cs_v111)</td>
  <td>14 de agosto de 2018</td>
  <td>20 de julio de 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión no recibe soporte."/></td>
  <td>[1.10](#cs_v110)</td>
  <td>1 de mayo de 2018</td>
  <td>16 de mayo de 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión no recibe soporte."/></td>
  <td>[1.9](#cs_v19)</td>
  <td>8 de febrero de 2018</td>
  <td>27 de diciembre de 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión no recibe soporte."/></td>
  <td>[1.8](#cs_v18)</td>
  <td>8 de noviembre de 2017</td>
  <td>22 de septiembre de 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión no recibe soporte."/></td>
  <td>[1.7](#cs_v17)</td>
  <td>19 de septiembre de 2017</td>
  <td>21 de junio de 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión no recibe soporte."/></td>
  <td>1.6</td>
  <td>N/D</td>
  <td>N/D</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Esta versión no recibe soporte."/></td>
  <td>[1.5](#cs_v1-5)</td>
  <td>23 de mayo de 2017</td>
  <td>4 de abril de 2018</td>
</tr>
</tbody>
</table>

<br />


## Versión 1.14
{: #cs_v114}

<p><img src="images/certified_kubernetes_1x14.png" style="padding-right: 10px;" align="left" alt="Este distintivo indica la certificación de Kubernetes versión 1.14 para {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.14 bajo el programa CNCF Kubernetes Software Conformance Certification. _Kubernetes® es una marca registrada de The Linux Foundation en Estados Unidos y en otros países, y se utiliza de acuerdo con una licencia de The Linux Foundation._</p>

Revise los cambios que puede necesitar hacer cuando actualice la versión anterior de Kubernetes a 1.14.
{: shortdesc}

Kubernetes 1.14 incorpora nuevas prestaciones que puede explorar. Pruebe el nuevo proyecto [`kustomize` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes-sigs/kustomize) que puede utilizar como ayuda para escribir, personalizar y reutilizar configuraciones YAML de recursos de Kubernetes. También puede echar un vistazo a la documentación de la nueva CLI de [`kubectl` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubectl.docs.kubernetes.io/).
{: tip}

### Antes de actualizar el nodo maestro
{: #114_before}

En la tabla siguiente se muestran las acciones que debe llevar a cabo antes de actualizar el maestro de Kubernetes.
{: shortdesc}

<table summary="Actualizaciones de Kubernetes para la versión 1.14">
<caption>Cambios necesarios antes de actualizar el nodo maestro a Kubernetes 1.14</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cambio en la estructura de directorios de registro de pod de CRI</td>
<td>La interfaz de tiempo de ejecución de contenedor (CRI) ha cambiado la estructura de directorios de registro de pod de `/var/log/pods/<UID>` a `/var/log/pods/<NAMESPACE_NAME_UID>`. Si las apps omiten Kubernetes y CRI para acceder a los registros de pod directamente en los nodos trabajadores, actualícelas para que manejen ambas estructuras de directorios. El acceso a los registros de pod a través de Kubernetes, por ejemplo ejecutando `kubectl logs`, no se ve afectado por este cambio.</td>
</tr>
<tr>
<td>Las comprobaciones de estado ya no siguen redirecciones</td>
<td>Los sondeos de actividad y preparación de la comprobación de estado que utilizan `HTTPGetAction` ya no siguen redirecciones a los nombres de host distintos de los de la solicitud de sondeo original. En su lugar, estas redirecciones no locales devuelven una respuesta `Success` y se genera un suceso con la razón `ProbeWarning` que indica que se ha pasado por alto la redirección. Si anteriormente se basaba en la redirección para ejecutar comprobaciones de estado con distintos puntos finales de nombre de host, debe ejecutar la lógica de comprobación de estado fuera de `kubelet`. Por ejemplo, puede enviar por proxy al punto final externo en lugar de redireccionar la solicitud de sondeo.</td>
</tr>
<tr>
<td>No soportado: proveedor de DNS de clúster KubeDNS</td>
<td>Ahora CoreDNS es el único proveedor de DNS de clúster soportado para los clústeres que ejecutan Kubernetes versión 1.14 y posteriores. Si actualiza un clúster existente que utiliza KubeDNS como proveedor de DNS de clúster a la versión 1.14, KubeDNS se migra automáticamente a CoreDNS durante la actualización. Por lo tanto, antes de actualizar el clúster, considere la posibilidad de [configurar CoreDNS como proveedor de DNS de clúster](/docs/containers?topic=containers-cluster_dns#set_coredns) y de probarlo. Por ejemplo, si la app se basa en un cliente DNS
antiguo, es posible que tenga que [actualizar la app o personalizar CoreDNS](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_issues).<br><br>CoreDNS da soporte a la [especificación DNS de clúster ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/dns/blob/master/docs/specification.md#25---records-for-external-name-services) para especificar un nombre de dominio como campo `ExternalName` del servicio Kubernetes. El proveedor de DNS de clúster anterior, KubeDNS, no sigue la especificación DNS de clúster, y, por lo tanto, permite direcciones IP para `ExternalName`. Si algún servicio de Kubernetes utiliza direcciones IP en lugar de DNS, debe actualizar el valor de `ExternalName` a DNS para que siga funcionando.</td>
</tr>
<tr>
<td>No soportado: característica alfa `Initializers` de Kubernetes</td>
<td>La característica alfa `Initializers` de Kubernetes, la versión de API `admissionregistration.k8s.io/v1alpha1`, el plugin del controlador de admisiones `Initializers` y el uso del campo de API `metadata.initializers` se han eliminado. Si utiliza `Initializers`, pase a utilizar [webhooks de admisiones de Kubernetes webhooks ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) y suprima cualquier objeto de API `InitializerConfiguration` existente antes de actualizar el clúster.</td>
</tr>
<tr>
<td>No soportado: antagonismos alfa de Node</td>
<td>El uso de los antagonismos `node.alpha.kubernetes.io/notReady` y `node.alpha.kubernetes.io/unreachable` ya no recibe soporte. Si utiliza dichos antagonismos, actualice sus apps para que utilicen en su lugar los antagonismos `node.kubernetes.io/not-ready` y `node.kubernetes.io/unreachable`.</td>
</tr>
<tr>
<td>No soportado: documentos de swagger de API de Kubernetes</td>
<td>Los documentos de la API de esquema `swagger/*`, `/swagger.json` y `/swagger-2.0.0.pb-v1` se han eliminado en favor de los documentos de la API de esquema `/openapi/v2`. La documentación de swagger quedó en desuso cuando la documentación de OpenAPI estuvo disponible en Kubernetes versión 1.10. Además, ahora el servidor de API de Kubernetes solo agrega esquemas OpenAPI desde los puntos finales `/openapi/v2` de los servidores de API agregados. Se ha eliminado la posibilidad de realizar la agregación desde `/swagger.json`. Si ha instalado apps que proporcionan extensiones de API de Kubernetes, asegúrese de que las apps dan soporte a la documentación de API de esquema `/openapi/v2`.</td>
</tr>
<tr>
<td>No soportadas y en desuso: determinadas métricas</td>
<td>Revise el apartado sobre [métricas de Kubernetes eliminadas y en desuso ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#removed-and-deprecated-metrics). Si utiliza alguna de estas métricas en desuso, cámbiela por la métrica sustitutiva disponible.</td>
</tr>
</tbody>
</table>

### Después de actualizar el nodo maestro
{: #114_after}

En la tabla siguiente se muestran las acciones que debe llevar a cabo después de actualizar el maestro de Kubernetes.
{: shortdesc}

<table summary="Actualizaciones de Kubernetes para la versión 1.14">
<caption>Cambios necesarios después de actualizar el nodo maestro a Kubernetes 1.14</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>No soportado: `kubectl --show-all`</td>
<td>Los distintivos `--show-all` y el abreviado `-a` ya n o reciben soporte. Si sus scripts utilizan estos distintivos, actualícelos.</td>
</tr>
<tr>
<td>Políticas de RBAC predeterminadas de Kubernetes para usuarios no autenticados</td>
<td>Las políticas de control de acceso basado en rol (RBAC) predeterminadas de Kubernetes ya no otorgan acceso a las [API de descubrimiento y de comprobación de permisos para usuarios autenticados ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles). Este cambio solo se aplica a los nuevos clústeres de la versión 1.14. Si actualiza un clúster desde una versión anterior, los usuarios no autenticados siguen teniendo acceso a las API de descubrimiento y comprobación de permisos. Si desea actualizar a un valor predeterminado más seguro para los usuarios no autenticados, elimine el grupo `system:unauthenticated` de los enlaces de rol de clúster `system:basic-user` y `system:discovery`.</td>
</tr>
<tr>
<td>En desuso: consultas de Prometheus que utilizan las etiquetas `pod_name` y `container_name`</td>
<td>Actualice las consultas de Prometheus que utilizan las etiquetas `pod_name` o `container_name` para que utilicen en su lugar las etiquetas `pod` o `container`. Entre las consultas que pueden utilizar estas etiquetas en desuso se encuentran las métricas de sondeo de kubelet. Las etiquetas `pod_name` y `container_name` en desuso se convierten en no soportadas en el siguiente release de Kubernetes.</td>
</tr>
</tbody>
</table>

<br />


## Versión 1.13
{: #cs_v113}

<p><img src="images/certified_kubernetes_1x13.png" style="padding-right: 10px;" align="left" alt="Este distintivo indica certificación de Kubernetes versión 1.13 para {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.13 bajo el programa CNCF Kubernetes Software Conformance Certification. _Kubernetes® es una marca registrada de The Linux Foundation en Estados Unidos y en otros países, y se utiliza de acuerdo con una licencia de The Linux Foundation._</p>

Revise los cambios que puede necesitar hacer cuando actualice la versión anterior de Kubernetes a 1.13.
{: shortdesc}

### Antes de actualizar el nodo maestro
{: #113_before}

En la tabla siguiente se muestran las acciones que debe llevar a cabo antes de actualizar el maestro de Kubernetes.
{: shortdesc}

<table summary="Actualizaciones de Kubernetes para la versión 1.13">
<caption>Cambios necesarios antes de actualizar el maestro a Kubernetes 1.13</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>N/D</td>
<td></td>
</tr>
</tbody>
</table>

### Después de actualizar el nodo maestro
{: #113_after}

En la tabla siguiente se muestran las acciones que debe llevar a cabo después de actualizar el maestro de Kubernetes.
{: shortdesc}

<table summary="Actualizaciones de Kubernetes para la versión 1.13">
<caption>Cambios necesarios después de actualizar el nodo maestro a Kubernetes 1.13</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoreDNS disponible como el nuevo proveedor DNS de clúster predeterminado</td>
<td>CoreDNS es ahora el proveedor de DNS de clúster predeterminado para los nuevos clústeres en Kubernetes 1.13 y posteriores. Si actualiza un clúster existente a 1.13 que utiliza KubeDNS como proveedor de DNS de clúster, KubeDNS continúa siendo el proveedor de DNS de clúster. Sin embargo, puede optar por [utilizar CoreDNS en su lugar](/docs/containers?topic=containers-cluster_dns#dns_set). Por ejemplo, puede probar sus apps en CoreDNS en preparación para la próxima actualización de la versión de Kubernetes para asegurarse de que no es necesario [actualizar la app o personalizar CoreDNS](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_issues).
<br><br>CoreDNS da soporte a la [especificación DNS de clúster ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/dns/blob/master/docs/specification.md#25---records-for-external-name-services) para especificar un nombre de dominio como campo `ExternalName` del servicio Kubernetes. El proveedor de DNS de clúster anterior, KubeDNS, no sigue la especificación DNS de clúster, y, por lo tanto, permite direcciones IP para `ExternalName`. Si algún servicio de Kubernetes utiliza direcciones IP en lugar de DNS, debe actualizar el valor de `ExternalName` a DNS para que siga funcionando.</td>
</tr>
<tr>
<td>Salida de `kubectl` para `Deployment` y `StatefulSet`</td>
<td>La salida de `kubectl` para `Deployment` y `StatefulSet` ahora incluye una columna `Ready` y resulta más fácil de leer para el usuario. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>Salida de `kubectl` para `PriorityClass`</td>
<td>La salida de `kubectl` para `PriorityClass` ahora incluye una columna `Value`. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>`kubectl get componentstatuses`</td>
<td>El mandato `kubectl get componentstatuses` no notifica correctamente el estado de algunos componentes maestros de Kubernetes porque ya no se puede acceder a estos componentes desde el servidor de API de Kubernetes ahora que los puertos de `localhost` e inseguros (HTTP) están inhabilitados. Después de incorporar nodos maestros de alta disponibilidad (HA) en Kubernetes versión 1.10, cada nodo maestro de Kubernetes se configura con varias instancias de `apiserver`, `controller-manager`, `scheduler` y `etcd`. Debe consultar el estado del clúster desde la [consola de {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/kubernetes/landing) o mediante el [mandato](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
</tr>
<tr>
<tr>
<td>No soportado: `kubectl run-container`</td>
<td>El mandato `kubectl run-container` se ha eliminado. Utilice en su lugar el mandato `kubectl run`.</td>
</tr>
<tr>
<td>`kubectl rollout undo`</td>
<td>Cuando se ejecuta `kubectl rollout undo` para una revisión que no existe, se devuelve un error. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>En desuso: Anotación `scheduler.alpha.kubernetes.io/critical-pod`</td>
<td>La anotación `scheduler.alpha.kubernetes.io/critical-pod` ya no se utiliza. Cambie los pods que se basan en esta anotación para que utilicen en su lugar la [prioridad de pod](/docs/containers?topic=containers-pod_priority#pod_priority).</td>
</tr>
</tbody>
</table>

### Después de actualizar los nodos trabajadores
{: #113_after_workers}

En la tabla siguiente se muestran las acciones que debe llevar a cabo después de actualizar los nodos trabajadores.
{: shortdesc}

<table summary="Actualizaciones de Kubernetes para la versión 1.13">
<caption>Cambios necesarios después de actualizar los nodos trabajadores a Kubernetes 1.13</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Servidor dedicado `cri` de contenedor</td>
<td>En la versión 1.2 de contenedor, el servidor dedicado del plugin `cri` ahora da servicio en un puerto aleatorio, `http://localhost:0`. Este cambio da soporte al proxy dedicado `kubelet` y ofrece una interfaz dedicada más segura para las operaciones `exec` y `logs` de contenedor. Antes, el servidor dedicado `cri` escuchaba en la interfaz de red privada del nodo trabajador mediante el puerto 10010. Si las apps utilizan el plugin `cri` de contenedor y siguen el comportamiento anterior, actualícelas.</td>
</tr>
</tbody>
</table>

<br />



## Versión 1.12
{: #cs_v112}

<p><img src="images/certified_kubernetes_1x12.png" style="padding-right: 10px;" align="left" alt="Este identificador indica la certificación de Kubernetes versión 1.12 para el servicio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.12 bajo el programa CNCF de certificación de conformidad de software Kubernetes. _Kubernetes® es una marca registrada de The Linux Foundation en Estados Unidos y en otros países, y se utiliza de acuerdo con una licencia de The Linux Foundation._</p>

Revise los cambios que puede necesitar hacer cuando actualice la versión anterior de Kubernetes a 1.12.
{: shortdesc}

### Antes de actualizar el nodo maestro
{: #112_before}

En la tabla siguiente se muestran las acciones que debe llevar a cabo antes de actualizar el maestro de Kubernetes.
{: shortdesc}

<table summary="Actualizaciones de Kubernetes para la versión 1.12">
<caption>Cambios necesarios antes de actualizar el maestro a Kubernetes 1.12</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Servidor de métricas de Kubernetes</td>
<td>Si actualmente tiene el `metric-server` de Kubernetes desplegado en el clúster, debe eliminar el `metric-server` antes de actualizar el clúster a Kubernetes 1.12. Esta eliminación evita conflictos con el `metric-server` que se despliega durante la actualización.</td>
</tr>
<tr>
<td>Enlaces de rol para la cuenta de servicio `default` de `kube-system`</td>
<td>La cuenta de servicio `default` de `kube-system` ya no tiene acceso **cluster-admin** a la API de Kubernetes. Si despliega características o complementos como [Helm](/docs/containers?topic=containers-helm#public_helm_install) que requieran acceso a los procesos del clúster, configure una [cuenta de servicio ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/). Si necesita tiempo para crear y configurar cuentas de servicio individuales con los permisos adecuados, puede otorgar temporalmente el rol **cluster-admin** con el enlace de rol de clúster siguiente: `kubectl create clusterrolebinding kube-system:default --clusterrole=cluster-admin --serviceaccount=kube-system:default`</td>
</tr>
</tbody>
</table>

### Después de actualizar el nodo maestro
{: #112_after}

En la tabla siguiente se muestran las acciones que debe llevar a cabo después de actualizar el maestro de Kubernetes.
{: shortdesc}

<table summary="Actualizaciones de Kubernetes para la versión 1.12">
<caption>Cambios necesarios después de actualizar el nodo maestro a Kubernetes 1.12</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>API para Kubernetes</td>
<td>La API de Kubernetes sustituye a las API en desuso de la forma siguiente:
<ul><li><strong>apps/v1</strong>: La API de Kubernetes `apps/v1`
sustituye a las API `apps/v1beta1` y `apps/v1alpha`. La API `apps/v1` también sustituye a la API `extensions/v1beta1` para los recursos `daemonset`, `deployment`, `replicaset` y `statefulset`. El proyecto Kubernetes está poniendo en desuso y eliminando gradualmente el soporte para las API anteriores del `apiserver` de Kubernetes y el cliente `kubectl`.</li>
<li><strong>networking.k8s.io/v1</strong>: La API `networking.k8s.io/v1` sustituye a la API `extensions/v1beta1` para recursos NetworkPolicy.</li>
<li><strong>policy/v1beta1</strong>: La API `policy/v1beta1` sustituye a la API `extensions/v1beta1` para recursos `podsecuritypolicy`.</li></ul>
<br><br>Actualice todos los campos del archivo YAML `apiVersion` para que utilicen la API de Kubernetes adecuada antes de que las API en desuso se conviertas en no soportadas. Además, revise los [Documentos de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) para ver si existen cambios relacionados con `apps/v1`, como el siguiente.
<ul><li>Después de crear un despliegue, el campo `.spec.selector` es inmutable.</li>
<li>El campo `.spec.rollbackTo` está en desuso. En su lugar, utilice el mandato `kubectl rollout undo`.</li></ul></td>
</tr>
<tr>
<td>CoreDNS disponible como proveedor DNS de clúster</td>
<td>El proyecto Kubernetes está en proceso de transición para dar soporte a CoreDNS en lugar de hacerlo al DNS de Kubernetes actual (KubeDNS). En la versión 1.12, el DNS de clúster predeterminado sigue siendo KubeDNS, pero puede [optar por utilizar CoreDNS](/docs/containers?topic=containers-cluster_dns#dns_set).</td>
</tr>
<tr>
<td>`kubectl apply --force`</td>
<td>Ahora, al forzar una acción de aplicación (`kubectl apply --force`) sobre recursos que no se pueden actualizar, como campos inmutables en archivos YAML, los recursos se vuelven a crear en su lugar. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>`kubectl get componentstatuses`</td>
<td>El mandato `kubectl get componentstatuses` no notifica correctamente el estado de algunos componentes maestros de Kubernetes porque ya no se puede acceder a estos componentes desde el servidor de API de Kubernetes ahora que los puertos de `localhost` e inseguros (HTTP) están inhabilitados. Después de incorporar nodos maestros de alta disponibilidad (HA) en Kubernetes versión 1.10, cada nodo maestro de Kubernetes se configura con varias instancias de `apiserver`, `controller-manager`, `scheduler` y `etcd`. Debe consultar el estado del clúster desde la [consola de {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/kubernetes/landing) o mediante el [mandato](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
</tr>
<tr>
<td>`kubectl logs --interactive`</td>
<td>Ya no hay soporte para el distintivo `--interactive` en `kubectl logs`. Actualice cualquier automatización que utilice este distintivo.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Si el mandato `patch` no tiene ningún cambio como resultado (parche redundante), el mandato ya no sale con un código de retorno de `1`. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>`kubectl version -c`</td>
<td>Ya no hay soporte para el distintivo de sintaxis abreviada `-c`. En su lugar, utilice el distintivo completo `--client`. Actualice cualquier automatización que utilice este distintivo.</td>
</tr>
<tr>
<td>`kubectl wait`</td>
<td>Si no se encuentra ningún selector coincidente, ahora el mandato imprime un mensaje de error y sale con un código de retorno de `1`. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>kubelet cAdvisor port</td>
<td>La interfaz de usuario web de [Container Advisor (cAdvisor) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/google/cadvisor) que utilizaba Kubelet al iniciar el `--cadvisor-port` se ha eliminado de Kubernetes 1.12. Si aún tiene la necesidad de ejecutar cAdvisor, [despliegue cAdvisor como un conjunto de daemons ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/google/cadvisor/tree/master/deploy/kubernetes).<br><br>En el conjunto de daemons, especifique la sección de puertos para que se pueda acceder a cAdvisor a través de
`http://node-ip:4194`, según se indica a continuación. Los pods de cAdvisor fallarán hasta que los nodos trabajadores se actualicen a 1.12, debido a que las versiones anteriores de Kubelet utilizan el puerto de host 4194 para cAdvisor.
<pre class="screen"><code>ports:
          - name: http
            containerPort: 8080
            hostPort: 4194
            protocol: TCP</code></pre></td>
</tr>
<tr>
<td>Panel de control de Kubernetes</td>
<td>Si accede al panel de control a través de `kubectl proxy`, se elimina el botón **OMITIR** de la página de inicio de sesión. En su lugar, [utilice una **Señal** para iniciar una sesión](/docs/containers?topic=containers-app#cli_dashboard).</td>
</tr>
<tr>
<td id="metrics-server">Servidor de métricas de Kubernetes</td>
<td>El servidor de métricas de Kubernetes sustituye a Kubernetes Heapster (en desuso desde la versión 1.8 de Kubernetes) como proveedor de métricas de clúster. Si ejecuta más de 30 pods por nodo trabajador en el clúster, [ajuste la configuración de `metrics-server` por motivos de rendimiento](/docs/containers?topic=containers-kernel#metrics).
<p>El panel de control de Kubernetes no funciona con el `metrics-server`. Si desea mostrar métricas en un panel de control, elija una de las opciones siguientes.</p>
<ul><li>[Configure Grafana para analizar métricas](/docs/services/cloud-monitoring/tutorials?topic=cloud-monitoring-container_service_metrics#container_service_metrics) utilizando el Panel de control de supervisión del clúster.</li>
<li>Despliegue [Heapster ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/heapster) en el clúster.
<ol><li>Copie los archivos [YAML ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/heapster-rbac.yaml) `heapster-rbac`, [YAML ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml) `heapster-service` y [YAML ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml) `heapster-controller`.</li>
<li>Edite el archivo YAML `heapster-controller` sustituyendo las series siguientes.
<ul><li>Sustituya `{{ nanny_memory }}` por `90Mi`</li>
<li>Sustituya `{{ base_metrics_cpu }}` por `80m`</li>
<li>Sustituya `{{ metrics_cpu_per_node }}` por `0.5m`</li>
<li>Sustituya `{{ base_metrics_memory }}` por `140Mi`</li>
<li>Sustituya `{{ metrics_memory_per_node }}` por `4Mi`</li>
<li>Sustituya `{{ heapster_min_cluster_size }}` por `16`</li></ul></li>
<li>Aplique los archivos YAML `heapster-rbac`, `heapster-service` y `heapster-controller` al clúster ejecutando el mandato `kubectl apply -f`.</li></ol></li></ul></td>
</tr>
<tr>
<td>API de Kubernetes `rbac.authorization.k8s.io/v1`</td>
<td>La API de Kubernetes `rbac.authorization.k8s.io/v1` (soportada desde Kubernetes 1.8) va a sustituir a las API `rbac.authorization.k8s.io/v1alpha1` y `rbac.authorization.k8s.io/v1beta1`. Ya no puede crear objetos RBAC como roles o enlaces de rol con la API `v1alpha` no soportada. Los objetos RBAC existentes se convierten a la API `v1`.</td>
</tr>
</tbody>
</table>

<br />


## Archivo
{: #k8s_version_archive}

Obtenga una visión general de las versiones de Kubernetes que no se admiten en {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

### Versión 1.11 (sin soporte)
{: #cs_v111}

A partir del 20 de julio de 2019, los {{site.data.keyword.containerlong_notm}} clústeres que ejecutan [Kubernetes versión 1.11](/docs/containers?topic=containers-changelog#changelog_archive) no están soportados. Los clústeres de la versión 1.11 no pueden recibir actualizaciones de seguridad ni soporte a menos que se actualicen a la siguiente versión más reciente.
{: shortdesc}

[Revise el impacto potencial](/docs/containers?topic=containers-cs_versions#cs_versions) de cada actualización de versión de Kubernetes y luego [actualice los clústeres](/docs/containers?topic=containers-update#update) inmediatamente al menos a la versión 1.12.

### Versión 1.10 (sin soporte)
{: #cs_v110}

A partir del 16 de mayo de 2019, se deja de dar soporte a los clústeres de {{site.data.keyword.containerlong_notm}} que ejecutan [la versión 1.10 de Kubernetes](/docs/containers?topic=containers-changelog#changelog_archive). Los clústeres de la versión 1.10 no pueden recibir actualizaciones de seguridad ni soporte a menos que se actualicen a la siguiente versión más reciente.
{: shortdesc}

[Revise el impacto potencial](/docs/containers?topic=containers-cs_versions#cs_versions) de cada actualización de la versión de Kubernetes y, a continuación, [actualice los clústeres](/docs/containers?topic=containers-update#update) a [Kubernetes 1.12](#cs_v112).

### Versión 1.9 (sin soporte)
{: #cs_v19}

A partir del 27 de diciembre de 2018, se deja de dar soporte a los clústeres de {{site.data.keyword.containerlong_notm}} que ejecutan [la versión 1.9 de Kubernetes](/docs/containers?topic=containers-changelog#changelog_archive). Los clústeres de la versión 1.9 no pueden recibir actualizaciones de seguridad ni soporte a menos que se actualicen a la siguiente versión más reciente.
{: shortdesc}

Para seguir ejecutando sus apps en {{site.data.keyword.containerlong_notm}}, [cree un clúster nuevo](/docs/containers?topic=containers-clusters#clusters) y [despliegue sus apps](/docs/containers?topic=containers-app#app) en el nuevo clúster.

### Versión 1.8 (sin soporte)
{: #cs_v18}

A partir del 22 de septiembre de 2018, se deja de dar soporte a los clústeres de {{site.data.keyword.containerlong_notm}} que ejecutan [la versión 1.8 de Kubernetes](/docs/containers?topic=containers-changelog#changelog_archive). Los clústeres de la versión 1.8 no pueden recibir actualizaciones de seguridad ni soporte.
{: shortdesc}

Para seguir ejecutando sus apps en {{site.data.keyword.containerlong_notm}}, [cree un clúster nuevo](/docs/containers?topic=containers-clusters#clusters) y [despliegue sus apps](/docs/containers?topic=containers-app#app) en el nuevo clúster.

### Versión 1.7 (sin soporte)
{: #cs_v17}

A partir del 21 de junio de 2018, se deja de dar soporte a los clústeres de {{site.data.keyword.containerlong_notm}} que ejecutan [la versión 1.7 de Kubernetes](/docs/containers?topic=containers-changelog#changelog_archive). Los clústeres de la versión 1.7 no pueden recibir actualizaciones de seguridad ni soporte.
{: shortdesc}

Para seguir ejecutando sus apps en {{site.data.keyword.containerlong_notm}}, [cree un clúster nuevo](/docs/containers?topic=containers-clusters#clusters) y [despliegue sus apps](/docs/containers?topic=containers-app#app) en el nuevo clúster.

### Versión 1.5 (sin soporte)
{: #cs_v1-5}

A partir del 4 de abril de 2018, se deja de dar soporte a los clústeres de {{site.data.keyword.containerlong_notm}} que ejecutan [la versión 1.5 de Kubernetes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md). Los clústeres de la versión 1.5 no pueden recibir actualizaciones de seguridad ni soporte.
{: shortdesc}

Para seguir ejecutando sus apps en {{site.data.keyword.containerlong_notm}}, [cree un clúster nuevo](/docs/containers?topic=containers-clusters#clusters) y [despliegue sus apps](/docs/containers?topic=containers-app#app) en el nuevo clúster.
