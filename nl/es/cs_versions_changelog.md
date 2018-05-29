---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Registro de cambios de versiones
{: #changelog}

Visualice información de cambios de versiones de actualizaciones mayores, menores y parches de actualización que están disponibles para los clústeres {{site.data.keyword.containerlong}} Kubernetes. Los cambios incluyen actualizaciones a Kubernetes y a los componentes de Proveedores de {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

IBM aplica actualizaciones a nivel de parche de forma automática al maestro, sin embargo, debe [actualizar los nodos trabajadores](cs_cluster_update.html#worker_node). Compruebe de forma mensual las actualizaciones disponibles. A medida que las actualizaciones pasan a estar disponibles, se le notifica al visualizar información sobre los nodos trabajadores, por ejemplo, con los mandatos `bx cs workers <cluster>` o `bx cs worker-get <cluster> <worker>`.

Consulte las [versiones de Kubernetes](cs_versions.html) para obtener un resumen de las acciones de migración.
{: tip}

Para obtener información sobre los cambios desde la versión anterior, consulte los siguientes registros de cambios. 
-  [Registros de cambios](#18_changelog) de la versión 1.8. 
-  [Registros de cambios](#17_changelog) de la versión 1.7. 


## Registro de cambios de la versión 1.8
{: #18_changelog}

Revise los siguientes cambios. 

### Registros de cambios para la versión 1.8.11_1509
{: #1811_1509}

<table summary="Cambios desde la versión 1.8.8_1507">
<caption>Cambios desde la versión 1.8.8_1507</caption>
<thead>
<tr>
<th>Componente</th>
<th>Anterior</th>
<th>Actual</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11).
</td>
</tr>
<tr>
<td>Imagen de contenedor en pausa </td>
<td>3.0</td>
<td>3.1</td>
<td>Elimina procesos zombie huérfanos heredados. </td>
</tr>
<tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>Ahora los servicios `NodePort` y `LoadBalancer` dan soporte a la [conservación de la dirección IP de origen del cliente](cs_loadbalancer.html#node_affinity_tolerations) estableciendo `service.spec.externalTrafficPolicy` en `Local`. </td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregida la configuración de tolerancia del [nodo extremo](cs_edge.html#edge) en clústeres antiguos. </td>
</tr>
</tbody>
</table>

## Registro de cambios de la versión 1.7
{: #17_changelog}

Revise los siguientes cambios. 

### Registros de cambios para la versión 1.7.16_1511
{: #1716_1511}

<table summary="Cambios desde la versión 1.7.4_1509">
<caption>Cambios desde la versión 1.7.4_1509</caption>
<thead>
<tr>
<th>Componente</th>
<th>Anterior</th>
<th>Actual</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16).
</td>
</tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>Ahora los servicios `NodePort` y `LoadBalancer` dan soporte a la [conservación de la dirección IP de origen del cliente](cs_loadbalancer.html#node_affinity_tolerations) estableciendo `service.spec.externalTrafficPolicy` en `Local`. </td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregida la configuración de tolerancia del [nodo extremo](cs_edge.html#edge) en clústeres antiguos. </td>
</tr>
</tbody>
</table>

