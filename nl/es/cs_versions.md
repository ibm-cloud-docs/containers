---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

La tabla contiene las actualizaciones que pueden tener un impacto probable sobre las apps desplegadas cuando se actualice un clúster a una nueva versión. Revise el [registro de cambios de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) para ver una lista completa de los cambios en las versiones Kubernetes.

Para obtener más información sobre el proceso de actualización, consulte [Actualización de clústeres](cs_cluster.html#cs_cluster_update) y [Actualización de nodos trabajadores](cs_cluster.html#cs_cluster_worker_update).



## Versión 1.7
{: #cs_v17}

### Actualización antes de maestro
{: #17_before}

<table summary="Actualizaciones de Kubernetes para las versiones 1.7 y 1.6">
<caption>Tabla 1. Cambios que realizar antes de actualizar el maestro a Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción
</tr>
</thead>
<tbody>
<tr>
<td>Almacenamiento</td>
<td>Los scripts de configuración con `hostPath` y `mountPath` con referencias al directorio padre como `../to/dir` no están permitidos. Cambie las vías de acceso por vías de acceso absolutas simples, como por ejemplo `/path/to/dir`.
<ol>
  <li>Ejecute este mandato para determinar si necesita actualizar las vías de acceso del almacenamiento.</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Si se devuelve `Action required`, modifique cada pod afectado para que haga referencia a la vía de acceso absoluta antes de actualizar todos los nodos trabajadores. Si el pod es propiedad de otro recurso, como por ejemplo un despliegue, modifique el valor de [_PodSpec_ ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) dentro de dicho recurso.
</ol>
</td>
</tr>
</tbody>
</table>

### Actualización después de maestro
{: #17_after}

<table summary="Actualizaciones de Kubernetes para las versiones 1.7 y 1.6">
<caption>Tabla 2. Cambios que realizar después de actualizar el maestro a Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción
</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>Después de actualizar la CLI `kubectl` a la versión de su clúster, estos mandatos `kubectl` deben utilizar varios distintivos en lugar de argumentos separados por comas. <ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  Por ejemplo, ejecute `kubectl create role --resource-name <x> --resource-name <y>` y no `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Planificación de la afinidad de pod</td>
<td> La anotación `scheduler.alpha.kubernetes.io/affinity` ya no se utiliza.
<ol>
  <li>Ejecute este mandato para cada espacio de nombres excepto para `ibm-system` y `kube-system` para determinar si necesita actualizar la planificación de afinidad de pods.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Si se devuelve `"Action required"`, modifique los pods afectados para que utilicen el campo de [_PodSpec_ ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ en lugar de la anotación `scheduler.alpha.kubernetes.io/affinity`.
</ol>
</tr>
<tr>
<td>Política de red</td>
<td>La anotación `net.beta.kubernetes.io/network-policy` ya no recibe soporte.
<ol>
  <li>Ejecute este mandato para determinar si necesita actualizar las políticas de red.</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Si se devuelve `Action required`, añada la siguiente política de red a cada espacio de nombres de Kubernetes que aparezca en la lista.</br>

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

  <li> Con la política de red especificada, elimine la anotación `net.beta.kubernetes.io/network-policy`.
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Tolerancias</td>
<td>La anotación `scheduler.alpha.kubernetes.io/tolerations` ya no recibe soporte.
<ol>
  <li>Ejecute este mandato para cada espacio de nombres excepto para `ibm-system` y `kube-system` para determinar si necesita actualizar las tolerancias.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Si se devuelve `"Action required"`, modifique los pods afectados para que utilicen el campo de [_PodSpec_ ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ en lugar de la anotación `scheduler.alpha.kubernetes.io/tolerations`.
</ol>
</tr>
<tr>
<td>Corrupciones</td>
<td>La anotación `scheduler.alpha.kubernetes.io/taints` ya no recibe soporte.
<ol>
  <li>Ejecute este mandato para determinar si necesita actualizar las corrupciones. </br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Si se devuelve `"Action required"`, elimine la anotación `scheduler.alpha.kubernetes.io/taints` para cada noto que tenga la anotación no soportada.</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Cuando se elimine la anotación no soportada, añada una corrupción a cada nodo. Debe tener la CLI de `kubectl` versión 1.6 o posterior.</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
