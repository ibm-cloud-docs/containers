---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

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

IBM aplica actualizaciones a nivel de parche de forma automática al nodo maestro; sin embargo, debe [actualizar el parche de los nodos trabajadores](cs_cluster_update.html#worker_node). Tanto para los nodos trabajadores como para el maestro, debe aplicar actualizaciones [principales y secundarias](cs_versions.html#update_types). Compruebe de forma mensual las actualizaciones disponibles. A medida que las actualizaciones estén disponibles, se le notificará cuando visualice información sobre los nodos trabajadores y maestro en la GUI o CLI, como por ejemplo con los siguientes mandatos: `ibmcloud ks clusters`, `cluster-get`, `workers` o `worker-get`.

Consulte las [versiones de Kubernetes](cs_versions.html) para obtener un resumen de las acciones de migración.
{: tip}

Para obtener información sobre los cambios desde la versión anterior, consulte los siguientes registros de cambios.
-  [Registros de cambios](#110_changelog) de la versión 1.10.
-  [Registros de cambios](#19_changelog) de la versión 1.9.
-  [Registros de cambios](#18_changelog) de la versión 1.8.
-  [Archivo](#changelog_archive) de registros de cambios para versiones no soportadas o en desuso.

## Registro de cambios de la versión 1.10
{: #110_changelog}

Revise los siguientes cambios.

### Registro de cambios para 1.10.5_1517, lanzado el 27 de julio de 2018
{: #1105_1517}

<table summary="Cambios realizados desde la versión 1.10.3_1514">
<caption>Cambios desde la versión 1.10.3_1514</caption>
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
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>Consulte las [notas del release de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/releases/#v313).</td>
</tr>
<tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Actualizado para dar soporte al release 1.10.5 de Kubernetes. Además, ahora los sucesos del servicio de LoadBalancer `create failure` incluyen cualquier error de subred portátil.</td>
</tr>
<tr>
<td>Plugin de almacenamiento de archivos de IBM</td>
<td>320</td>
<td>334</td>
<td>Se ha aumentado el tiempo de espera para la creación de un volumen persistente de 15 a 30 minutos. Se ha cambiado el tipo de facturación predeterminado a `por hora`. Se han añadido opciones de montaje a las clases de almacenamiento predefinidas. En la instancia de almacenamiento de archivos NFS de la cuenta de la infraestructura de IBM Cloud (SoftLayer), se ha cambiado el campo **Notas** por el formato JSON y se ha añadido el espacio de nombres de Kubernetes en el que se ha desplegado el PV. Para dar soporte a clústeres multizona, se han añadido etiquetas de zona y región a los volúmenes persistentes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Mejoras menores en los valores de red del nodo trabajador para las cargas de trabajo de red de alto rendimiento.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>El despliegue de cliente de OpenVPN `vpn` que se ejecuta en el espacio de nombres `kube-system` ahora se gestiona mediante `addon-manager` de Kubernetes.</td>
</tr>
</tbody>
</table>

### Registro de cambios para el fix pack de nodo trabajador 1.10.3_1514, lanzado el 3 de julio de 2018
{: #1103_1514}

<table summary="Cambios realizados desde la versión 1.10.3_1513">
<caption>Cambios desde la versión 1.10.3_1513</caption>
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
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha optimizado `sysctl` para las cargas de trabajo de red de alto rendimiento.</td>
</tr>
</tbody>
</table>


### Registro de cambios para el fix pack de nodo trabajador 1.10.3_1513, lanzado el 21 de junio de 2018
{: #1103_1513}

<table summary="Cambios realizados desde la versión 1.10.3_1512">
<caption>Cambios desde la versión 1.10.3_1512</caption>
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
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>Para los tipos de máquina no cifrados, el disco secundario se limpia obteniendo un sistema de archivos nuevo cuando se vuelve a cargar o se actualiza el nodo trabajador.</td>
</tr>
</tbody>
</table>

### Registro de cambios para 1.10.3_1512, lanzado el 12 de junio de 2018
{: #1103_1512}

<table summary="Cambios realizados desde la versión 1.10.1_1510">
<caption>Cambios desde la versión 1.10.1_1510</caption>
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
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3).</td>
</tr>
<tr>
<td>Configuración de Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha añadido `PodSecurityPolicy` a la opción `--enable-admission-plugins` para el servidor de API de Kubernetes del clúster y se ha configurado el clúster para que dé soporte a las políticas de seguridad de pod. Para obtener más información, consulte [Configuración de políticas de seguridad de pod](cs_psp.html).</td>
</tr>
<tr>
<td>Configuración de Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha habilitado la opción `--authentication-token-webhook` para dar soporte a las señales de portadora de API y de cuenta de servicio para la autenticación ante el punto final HTTPS de `kubelet`.</td>
</tr>
<tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Actualizado para dar soporte al release 1.10.3 de Kubernetes.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha añadido `livenessProbe` al despliegue de cliente de OpenVPN `vpn` que se ejecuta en el espacio de nombres `kube-system`.</td>
</tr>
<tr>
<td>Actualización del kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuevas imágenes de nodo trabajador con actualización del kernel para [CVE-2018-3639 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>



### Registro de cambios para el fix pack de nodo trabajador 1.10.1_1510, lanzado el 18 de mayo de 2018
{: #1101_1510}

<table summary="Cambios realizados desde la versión 1.10.1_1509">
<caption>Cambios desde la versión 1.10.1_1509</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Corregido un error que se producía al utilizar el plugin de almacenamiento en bloques.</td>
</tr>
</tbody>
</table>

### Registro de cambios para el fix pack de nodo trabajador 1.10.1_1509, lanzado el 16 de mayo de 2018
{: #1101_1509}

<table summary="Cambios realizados desde la versión 1.10.1_1508">
<caption>Cambios desde la versión 1.10.1_1508</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Los datos que se almacenan en el `kubelet` del directorio raíz se guardan ahora en el disco secundario más grande de la máquina del nodo trabajador.</td>
</tr>
</tbody>
</table>

### Registro de cambios para 1.10.1_1508, lanzado el 01 de mayo de 2018
{: #1101_1508}

<table summary="Cambios realizados desde la versión 1.9.7_1510">
<caption>Cambios desde la versión 1.9.7_1510</caption>
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
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>Consulte las [notas del release de Calico ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://docs.projectcalico.org/v3.1/releases/#v311).</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>Consulte las [notas del release de Kubernetes Heapster ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1).</td>
</tr>
<tr>
<td>Configuración de Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>Añadido <code>StorageObjectInUseProtection</code> a la opción <code>--enable-admission-plugins</code> para el servidor de API de Kubernetes del clúster.</td>
</tr>
<tr>
<td>DNS de Kubernetes</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>Consulte las [notas del release de DNS de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/dns/releases/tag/1.14.10).</td>
</tr>
<tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Actualizado para dar soporte al release 1.10 de Kubernetes.</td>
</tr>
<tr>
<td>Soporte de GPU</td>
<td>N/D</td>
<td>N/D</td>
<td>Ahora hay disponible soporte para [cargas de trabajo de contenedor con unidad de proceso de gráficos (GPU)](cs_app.html#gpu_app) para su planificación y ejecución. Para obtener una lista de los tipos de máquina con GPU que hay disponibles, consulte [Hardware para nodos de trabajador](cs_clusters.html#shared_dedicated_node). Para obtener más información, consulte la documentación de Kubernetes de [planificación de GPU ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

## Registro de cambios de la versión 1.9
{: #19_changelog}

Revise los siguientes cambios.

### Registro de cambios para 1.9.9_1520, lanzado el 27 de julio de 2018
{: #199_1520}

<table summary="Cambios realizados desde la versión 1.9.8_1517">
<caption>Cambios desde la versión 1.9.8_1517</caption>
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
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Actualizado para dar soporte al release 1.9.9 de Kubernetes. Además, ahora los sucesos del servicio de LoadBalancer `create failure` incluyen cualquier error de subred portátil.</td>
</tr>
<tr>
<td>Plugin de almacenamiento de archivos de IBM</td>
<td>320</td>
<td>334</td>
<td>Se ha aumentado el tiempo de espera para la creación de un volumen persistente de 15 a 30 minutos. Se ha cambiado el tipo de facturación predeterminado a `por hora`. Se han añadido opciones de montaje a las clases de almacenamiento predefinidas. En la instancia de almacenamiento de archivos NFS de la cuenta de la infraestructura de IBM Cloud (SoftLayer), se ha cambiado el campo **Notas** por el formato JSON y se ha añadido el espacio de nombres de Kubernetes en el que se ha desplegado el PV. Para dar soporte a clústeres multizona, se han añadido etiquetas de zona y región a los volúmenes persistentes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Mejoras menores en los valores de red del nodo trabajador para las cargas de trabajo de red de alto rendimiento.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>El despliegue de cliente de OpenVPN `vpn` que se ejecuta en el espacio de nombres `kube-system` ahora se gestiona mediante `addon-manager` de Kubernetes.</td>
</tr>
</tbody>
</table>

### Registro de cambios para el fix pack de nodo trabajador 1.9.8_1517, lanzado el 3 de julio de 2018
{: #198_1517}

<table summary="Cambios realizados desde la versión 1.9.8_1516">
<caption>Cambios desde la versión 1.9.8_1516</caption>
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
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha optimizado `sysctl` para las cargas de trabajo de red de alto rendimiento.</td>
</tr>
</tbody>
</table>


### Registro de cambios para el fix pack de nodo trabajador 1.9.8_1516, lanzado el 21 de junio de 2018
{: #198_1516}

<table summary="Cambios realizados desde la versión 1.9.8_1515">
<caption>Cambios desde la versión 1.9.8_1515</caption>
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
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>Para los tipos de máquina no cifrados, el disco secundario se limpia obteniendo un sistema de archivos nuevo cuando se vuelve a cargar o se actualiza el nodo trabajador.</td>
</tr>
</tbody>
</table>

### Registro de cambios para 1.9.8_1515, lanzado el 19 de junio de 2018
{: #198_1515}

<table summary="Cambios realizados desde la versión 1.9.7_1513">
<caption>Cambios desde la versión 1.9.7_1513</caption>
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
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8).</td>
</tr>
<tr>
<td>Configuración de Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha añadido PodSecurityPolicy a la opción --admiten-control para el servidor de API Kubernetes del clúster y ha configurado el clúster para dar soporte a políticas de seguridad de pod. Para obtener más información, consulte [Configuración de políticas de seguridad de pod](cs_psp.html).</td>
</tr>
<tr>
<td>Proveedor de IBM Cloud</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Actualizado para dar soporte al release 1.9.8 de Kubernetes.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha añadido <code>livenessProbe</code> al despliegue de cliente de OpenVPN <code>vpn</code> que se ejecuta en el espacio de nombres <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Registro de cambios para el fix pack de nodo trabajador 1.9.7_1513, lanzado el 11 de junio de 2018
{: #197_1513}

<table summary="Cambios realizados desde la versión 1.9.7_1512">
<caption>Cambios desde la versión 1.9.7_1512</caption>
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
<td>Actualización del kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuevas imágenes de nodo trabajador con actualización del kernel para [CVE-2018-3639 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

### Registro de cambios para el fix pack de nodo trabajador 1.9.7_1512, lanzado el 18 de mayo de 2018
{: #197_1512}

<table summary="Cambios realizados desde la versión 1.9.7_1511">
<caption>Cambios desde la versión 1.9.7_1511</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Corregido un error que se producía al utilizar el plugin de almacenamiento en bloques.</td>
</tr>
</tbody>
</table>

### Registro de cambios para el fix pack de nodo trabajador 1.9.7_1511, lanzado el 16 de mayo de 2018
{: #197_1511}

<table summary="Cambios realizados desde la versión 1.9.7_1510">
<caption>Cambios desde la versión 1.9.7_1510</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Los datos que se almacenan en el `kubelet` del directorio raíz se guardan ahora en el disco secundario más grande de la máquina del nodo trabajador.</td>
</tr>
</tbody>
</table>

### Registro de cambios para 1.9.7_1510, lanzado el 30 de abril de 2018
{: #197_1510}

<table summary="Cambios realizados desde la versión 1.9.3_1506">
<caption>Cambios desde la versión 1.9.3_1506</caption>
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
<td>v1.9.3</td>
<td>v1.9.7	</td>
<td><p>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). Este release corrige las vulnerabilidades [CVE-2017-1002101 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) y [CVE-2017-1002102 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ahora se montan como de solo lectura los volúmenes proyectados, `secret`, `configMap` y `downwardAPI`. Anteriormente, las apps podían escribir datos en estos volúmenes que el sistema podría revertir automáticamente. Si sus apps se basaban en este comportamiento inseguro anterior, modifíquelas en consecuencia.</p></td>
</tr>
<tr>
<td>Configuración de Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>Añadido `admissionregistration.k8s.io/v1alpha1=true` a la opción `--runtime-config` para el servidor de API de Kubernetes del clúster.</td>
</tr>
<tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td>Ahora los servicios `NodePort` y `LoadBalancer` dan soporte a la [conservación de la dirección IP de origen del cliente](cs_loadbalancer.html#node_affinity_tolerations) estableciendo `service.spec.externalTrafficPolicy` en `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregida la configuración de tolerancia del [nodo extremo](cs_edge.html#edge) en clústeres antiguos.</td>
</tr>
</tbody>
</table>

## Registro de cambios de la versión 1.8
{: #18_changelog}

Revise los siguientes cambios.

### Registro de cambios para 1.8.15_1518, lanzado el 27 de julio de 2018
{: #1815_1518}

<table summary="Cambios realizados desde la versión 1.8.13_1516">
<caption>Cambios desde la versión 1.8.13_1516</caption>
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
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Actualizado para dar soporte al release 1.8.15 de Kubernetes. Además, ahora los sucesos del servicio de LoadBalancer `create failure` incluyen cualquier error de subred portátil.</td>
</tr>
<tr>
<td>Plugin de almacenamiento de archivos de IBM</td>
<td>320</td>
<td>334</td>
<td>Se ha aumentado el tiempo de espera para la creación de un volumen persistente de 15 a 30 minutos. Se ha cambiado el tipo de facturación predeterminado a `por hora`. Se han añadido opciones de montaje a las clases de almacenamiento predefinidas. En la instancia de almacenamiento de archivos NFS de la cuenta de la infraestructura de IBM Cloud (SoftLayer), se ha cambiado el campo **Notas** por el formato JSON y se ha añadido el espacio de nombres de Kubernetes en el que se ha desplegado el PV. Para dar soporte a clústeres multizona, se han añadido etiquetas de zona y región a los volúmenes persistentes.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Mejoras menores en los valores de red del nodo trabajador para las cargas de trabajo de red de alto rendimiento.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>El despliegue de cliente de OpenVPN `vpn` que se ejecuta en el espacio de nombres `kube-system` ahora se gestiona mediante `addon-manager` de Kubernetes.</td>
</tr>
</tbody>
</table>

### Registro de cambios para el fix pack de nodo trabajador 1.8.13_1516, lanzado el 3 de julio de 2018
{: #1813_1516}

<table summary="Cambios realizados desde la versión 1.8.13_1515">
<caption>Cambios desde la versión 1.8.13_1515</caption>
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
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha optimizado `sysctl` para las cargas de trabajo de red de alto rendimiento.</td>
</tr>
</tbody>
</table>


### Registro de cambios para el fix pack de nodo trabajador 1.8.13_1515, lanzado el 21 de junio de 2018
{: #1813_1515}

<table summary="Cambios realizados desde la versión 1.8.13_1514">
<caption>Cambios desde la versión 1.8.13_1514</caption>
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
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>Para los tipos de máquina no cifrados, el disco secundario se limpia obteniendo un sistema de archivos nuevo cuando se vuelve a cargar o se actualiza el nodo trabajador.</td>
</tr>
</tbody>
</table>

### Registro de cambios para 1.8.13_1514, lanzado el 19 de junio de 2018
{: #1813_1514}

<table summary="Cambios realizados desde la versión 1.8.11_1512">
<caption>Cambios desde la versión 1.8.11_1512</caption>
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
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13).</td>
</tr>
<tr>
<td>Configuración de Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha añadido PodSecurityPolicy a la opción --admiten-control para el servidor de API Kubernetes del clúster y ha configurado el clúster para dar soporte a políticas de seguridad de pod. Para obtener más información, consulte [Configuración de políticas de seguridad de pod](cs_psp.html).</td>
</tr>
<tr>
<td>Proveedor de IBM Cloud</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Actualizado para dar soporte al release 1.8.13 de Kubernetes.</td>
</tr>
<tr>
<td>Cliente OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>Se ha añadido <code>livenessProbe</code> al despliegue de cliente de OpenVPN <code>vpn</code> que se ejecuta en el espacio de nombres <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Registro de cambios para el fix pack de nodo trabajador 1.8.11_1512, lanzado el 11 de junio de 2018
{: #1811_1512}

<table summary="Cambios realizados desde la versión 1.8.11_1511">
<caption>Cambios desde la versión 1.8.11_1511</caption>
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
<td>Actualización del kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuevas imágenes de nodo trabajador con actualización del kernel para [CVE-2018-3639 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>


### Registro de cambios para el fix pack de nodo trabajador 1.8.11_1511, lanzado el 18 de mayo de 2018
{: #1811_1511}

<table summary="Cambios realizados desde la versión 1.8.11_1510">
<caption>Cambios desde la versión 1.8.11_1510</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Corregido un error que se producía al utilizar el plugin de almacenamiento en bloques.</td>
</tr>
</tbody>
</table>

### Registro de cambios para el fix pack de nodo trabajador 1.8.11_1510, lanzado el 16 de mayo de 2018
{: #1811_1510}

<table summary="Cambios realizados desde la versión 1.8.11_1509">
<caption>Cambios desde la versión 1.8.11_1509</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Los datos que se almacenan en el `kubelet` del directorio raíz se guardan ahora en el disco secundario más grande de la máquina del nodo trabajador.</td>
</tr>
</tbody>
</table>


### Registro de cambios para 1.8.11_1509, lanzado el 19 de abril de 2018
{: #1811_1509}

<table summary="Cambios realizados desde la versión 1.8.8_1507">
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
<td><p>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). Este release corrige las vulnerabilidades [CVE-2017-1002101 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) y [CVE-2017-1002102 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ahora se montan como de solo lectura los volúmenes proyectados, `secret`, `configMap` y `downwardAPI`. Anteriormente, las apps podían escribir datos en estos volúmenes que el sistema podría revertir automáticamente. Si sus apps se basaban en este comportamiento inseguro anterior, modifíquelas en consecuencia.</p></td>
</tr>
<tr>
<td>Imagen de contenedor en pausa</td>
<td>3.0</td>
<td>3.1</td>
<td>Elimina procesos zombie huérfanos heredados.</td>
</tr>
<tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>Ahora los servicios `NodePort` y `LoadBalancer` dan soporte a la [conservación de la dirección IP de origen del cliente](cs_loadbalancer.html#node_affinity_tolerations) estableciendo `service.spec.externalTrafficPolicy` en `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregida la configuración de tolerancia del [nodo extremo](cs_edge.html#edge) en clústeres antiguos.</td>
</tr>
</tbody>
</table>

## Archivo
{: #changelog_archive}

### Registros de cambios de la versión 1.7 (no soportada)
{: #17_changelog}

Revise los siguientes cambios.

#### Registro de cambios para el fix pack de nodo trabajador 1.7.16_1514, lanzado el 11 de junio de 2018
{: #1716_1514}

<table summary="Cambios realizados desde la versión 1.7.16_1513">
<caption>Cambios desde la versión 1.7.16_1513</caption>
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
<td>Actualización del kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuevas imágenes de nodo trabajador con actualización del kernel para [CVE-2018-3639 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Registro de cambios para el fix pack de nodo trabajador 1.7.16_1513, lanzado el 18 de mayo de 2018
{: #1716_1513}

<table summary="Cambios realizados desde la versión 1.7.16_1512">
<caption>Cambios desde la versión 1.7.16_1512</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Corregido un error que se producía al utilizar el plugin de almacenamiento en bloques.</td>
</tr>
</tbody>
</table>

#### Registro de cambios para el fix pack de nodo trabajador 1.7.16_1512, lanzado el 16 de mayo de 2018
{: #1716_1512}

<table summary="Cambios realizados desde la versión 1.7.16_1511">
<caption>Cambios desde la versión 1.7.16_1511</caption>
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
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Los datos que se almacenan en el `kubelet` del directorio raíz se guardan ahora en el disco secundario más grande de la máquina del nodo trabajador.</td>
</tr>
</tbody>
</table>

#### Registro de cambios para 1.7.16_1511, lanzado el 19 de abril de 2018
{: #1716_1511}

<table summary="Cambios realizados desde la versión 1.7.4_1509">
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
<td><p>Consulte las [notas del release de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). Este release corrige las vulnerabilidades [CVE-2017-1002101 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) y [CVE-2017-1002102 ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ahora se montan como de solo lectura los volúmenes proyectados, `secret`, `configMap` y `downwardAPI`. Anteriormente, las apps podían escribir datos en estos volúmenes que el sistema podría revertir automáticamente. Si sus apps se basaban en este comportamiento inseguro anterior, modifíquelas en consecuencia.</p></td>
</tr>
<td>Proveedor de {{site.data.keyword.Bluemix_notm}}</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>Ahora los servicios `NodePort` y `LoadBalancer` dan soporte a la [conservación de la dirección IP de origen del cliente](cs_loadbalancer.html#node_affinity_tolerations) estableciendo `service.spec.externalTrafficPolicy` en `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregida la configuración de tolerancia del [nodo extremo](cs_edge.html#edge) en clústeres antiguos.</td>
</tr>
</tbody>
</table>
