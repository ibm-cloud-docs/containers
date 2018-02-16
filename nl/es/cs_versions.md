---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Versiones de Kubernetes para {{site.data.keyword.containerlong_notm}}
{: #cs_versions}

Revise las versiones de Kubernetes que están disponibles en {{site.data.keyword.containerlong}}.
{:shortdesc}

{{site.data.keyword.containershort_notm}} soporta varias versiones de Kubernetes. La versión predeterminada se utiliza al crear o actualizar un clúster, a menos que se especifica otra versión. Las versiones disponibles de Kubernetes son las siguientes:
- 1.8.6
- 1.7.4 (versión predeterminada)
- 1.5.6

Para comprobar la versión de la CLI de Kubernetes que ejecuta localmente o que el clúster ejecuta, ejecute el mandato siguiente y compruebe la versión.

```
kubectl version  --short
```
{: pre}

Salida de ejemplo:

```
Client Version: 1.7.4
Server Version: 1.7.4
```
{: screen}

## Tipos de actualización
{: #version_types}

Kubernetes proporciona estos tipos de actualización:
{:shortdesc}

|Tipo actualización|Ejemplos de etiquetas de versión|Actualizado por|Impacto
|-----|-----|-----|-----|
|Mayor|1.x.x|Puede|Operación de clústeres de cambios, incluyendo scripts o despliegues.|
|Menor|x.5.x|Puede|Operación de clústeres de cambios, incluyendo scripts o despliegues.|
|Parche|x.x.3|IBM y el usuario|No requiere cambios en scripts ni en despliegues. IBM actualiza los maestros automáticamente, pero el usuario debe aplicar los parches a los nodos trabajadores.|
{: caption="Consecuencias en las actualizaciones de Kubernetes" caption-side="top"}

De forma predeterminada, no se puede actualizar un maestro de Kubernetes con una antigüedad superior a dos versiones. Por ejemplo, si el maestro actual es de la versión 1.5 y desea actualizar a 1.8, primero se debe actualizar a la versión 1.7. Puede formar la actualización para continuar, pero actualizar a dos versiones anteriores puede provocar resultados imprevistos.
{: tip}

La siguiente información resume las actualizaciones que pueden tener un impacto probable sobre las apps desplegadas cuando se actualice un clúster a una nueva versión. Revise el [registro de cambios de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) para ver una lista completa de los cambios en las versiones Kubernetes.

Para obtener más información sobre el proceso de actualización, consulte [Actualización de clústeres](cs_cluster_update.html#master) y [Actualización de nodos trabajadores](cs_cluster_update.html#worker_node).

## Version 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="Este identificador indica la certificación de Kubernetes versión 1.8 para IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.8 bajo el programa CNCF de certificación de conformidad de software Kubernetes. _Kubernetes® es una marca registrada de The Linux Foundation en Estados Unidos y en otros países, y se utiliza de acuerdo con una licencia de The Linux Foundation._</p>

Revise los cambios que necesite hacer cuando actualice a Kubernetes versión 1.8.

<br/>

### Actualización antes de maestro
{: #18_before}

<table summary="Actualizaciones de Kubernetes para las versiones 1.8">
<caption>Cambios necesarios antes de actualizar el maestro a Kubernetes 1.8</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan='2'>No hay cambios necesarios antes de actualizar el maestro</td>
</tr>
</tbody>
</table>

### Actualización después de maestro
{: #18_after}

<table summary="Actualizaciones de Kubernetes para las versiones 1.8">
<caption>Cambios necesarios después de actualizar el maestro a Kubernetes 1.8</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Inicio de sesión en el panel de control de Kubernetes</td>
<td>El URL para acceder al panel de control de Kubernetes en la versión 1.8 ha cambiado y el proceso de inicio de sesión incluye un nuevo paso de autenticación. Consulte [acceso al panel de control de Kubernetes](cs_app.html#cli_dashboard) para obtener más información.</td>
</tr>
<tr>
<td>Permisos del panel de control de Kubernetes</td>
<td>Para forzar a los usuarios a que inicien sesión con sus credenciales para ver recursos de clúster en la versión 1.8, elimine la autorización 1.7 ClusterRoleBinding RBAC. Ejecute `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>El mandato `kubectl delete` ya no reduce los objetos de la API de carga de trabajo, como los pods, antes de suprimir el objeto. Si necesita reducir el objeto, utilice la [escala kubectl ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale) antes de suprimir el objeto. </td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>El mandato `kubectl run` debe utilizar varios distintivos para `--env` en lugar de argumentos separados por comas. Por ejemplo, ejecute <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code> y no <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>El mandato `kubectl stop` ya no está disponible.</td>
</tr>
</tbody>
</table>


## Versión 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="Este identificador indica la certificación de Kubernetes versión 1.7 para IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.7 bajo el programa CNCF de certificación de conformidad de software Kubernetes.</p>

Revise los cambios que necesite hacer cuando actualice a Kubernetes versión 1.7.

<br/>

### Actualización antes de maestro
{: #17_before}

<table summary="Actualizaciones de Kubernetes para las versiones 1.7 y 1.6">
<caption>Cambios necesarios antes de actualizar el maestro a Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Almacenamiento</td>
<td>Los scripts de configuración con `hostPath` y `mountPath` con referencias al directorio padre como `../to/dir` no están permitidos. Cambie las vías de acceso por vías de acceso absolutas simples, como por ejemplo `/path/to/dir`.
<ol>
  <li>Determine si necesita cambiar las vías de acceso:</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Si se devuelve `Action required`, modifique los pods para que hagan referencia a la vía de acceso absoluta antes de actualizar todos los nodos trabajadores. Si el pod es propiedad de otro recurso, como por ejemplo un despliegue, modifique el valor de [_PodSpec_ ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) dentro de dicho recurso.
</ol>
</td>
</tr>
</tbody>
</table>

### Actualización después de maestro
{: #17_after}

<table summary="Actualizaciones de Kubernetes para las versiones 1.7 y 1.6">
<caption>Cambios necesarios después de actualizar el maestro a Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>Después de actualizar la CLI `kubectl`, estos mandatos `kubectl create` deben utilizar varios distintivos en lugar de argumentos separados por comas:<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  Por ejemplo, ejecute `kubectl create role --resource-name <x> --resource-name <y>` y no `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Planificación de la afinidad de pod</td>
<td> La anotación `scheduler.alpha.kubernetes.io/affinity` ya no se utiliza.
<ol>
  <li>Para cada espacio de nombres excepto para `ibm-system` y `kube-system`, determine si necesita actualizar la Planificación de la afinidad de pod:</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br></li>
  <li>Si se devuelve `"Action required"`, utilice el campo de [_PodSpec_ ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ en lugar de la anotación `scheduler.alpha.kubernetes.io/affinity`.</li>
</ol>
</tr>
<tr>
<td>Política de red</td>
<td>La anotación `net.beta.kubernetes.io/network-policy` ya no está disponible.
<ol>
  <li>Determine si necesita cambiar las políticas:</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Si se devuelve `"Action required"`, añada la siguiente política de red a cada espacio de nombres de Kubernetes que aparezca en la lista:</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
  metadata:
    name: default-deny
    namespace: &lt;namespace&gt;
  spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> Una vez añadida la política de redes, elimine la anotación `net.beta.kubernetes.io/network-policy`:
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </li></ol>
</tr>
<tr>
<td>Tolerancias</td>
<td>La anotación `scheduler.alpha.kubernetes.io/tolerations` ya no está disponible.
<ol>
  <li>Para cada espacio de nombre excepto para `ibm-system` y `kube-system`, determine si necesita cambiar las tolerancias:</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Si se devuelve `"Action required"`, utilicen el campo de [_PodSpec_ ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ en lugar de la anotación `scheduler.alpha.kubernetes.io/tolerations`.
</ol>
</tr>
<tr>
<td>Corrupciones</td>
<td>La anotación `scheduler.alpha.kubernetes.io/taints` ya no está disponible.
<ol>
  <li>Determine si necesita cambiar las corrupciones:</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Si se devuelve `"Action required"`, elimine la anotación `scheduler.alpha.kubernetes.io/taints` para cada nodo:</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Añada una corrupción a cada nodo:</br>
  `kubectl taint node <node> <taint>`
  </li></ol>
</tr>
<tr>
<td>StatefulSet pod DNS</td>
<td>Los StatefulSet pods pierden las entradas Kubernetes DNS correspondientes después de haber actualizado el maestro. Para restaurar las entradas DNS, suprima los StatefulSet pods. Kubernetes vuelve a crear los pods y restaura automáticamente las entradas DNS. Para más información, consulte el [Tema sobre Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/issues/48327).
</tr>
</tbody>
</table>
