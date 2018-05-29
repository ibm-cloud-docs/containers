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

# Versiones de Kubernetes
{: #cs_versions}

{{site.data.keyword.containerlong}} da soporte a varias versiones de Kubernetes simultáneamente. Cuando se publica una versión más reciente (n), se da soporte a hasta 2 versiones anteriores (n-2). Las versiones anteriores a 2 versiones anteriores a la versión más reciente (n-3) son las primeras que quedan en desuso y a las que se deja de dar soporte.
{:shortdesc}

Las versiones de Kubernetes actualmente soportadas son:

- Más reciente: 1.9.3
- Predeterminada: 1.8.11
- Soportada: 1.7.16

**Versiones en desuso**: Cuando los clústeres se ejecutan en Kubernetes en desuso, tiene 30 días para revisar y actualizar a una versión soportada de Kubernetes antes de que la versión deje de estar soportada. Durante el período en desuso, puede ejecutar mandatos limitados en los clústeres para añadir trabajadores, recargar trabajadores y actualizar el clúster. No puede crear clústeres nuevos en la versión en desuso.

**Versiones no soportadas**: Si está ejecutando clústeres en una versión de Kubernetes que no esté soportada, [revise las posibles repercusiones](#version_types) de las actualizaciones y, a continuación, [actualice su clúster](cs_cluster_update.html#update) inmediatamente para continuar recibiendo importantes actualizaciones de seguridad y soporte.

Para comprobar la versión del servidor de un clúster, ejecute el mandato siguiente.

```
kubectl version  --short | grep -i server
```
{: pre}

Salida de ejemplo:

```
Server Version: v1.8.11+9d6e0610086578
```
{: screen}


## Tipos de actualización
{: #version_types}

El clúster Kubernetes tiene tres tipos de actualizaciones: mayores, menores y parches.
{:shortdesc}

|Tipo actualización|Ejemplos de etiquetas de versión|Actualizado por|Impacto
|-----|-----|-----|-----|
|Mayor|1.x.x|Puede|Operación de clústeres de cambios, incluyendo scripts o despliegues.|
|Menor|x.9.x|Puede|Operación de clústeres de cambios, incluyendo scripts o despliegues.|
|Parche|x.x.4_1510|IBM y el usuario|Parches de Kubernetes, así como otras actualizaciones de componentes de Proveedor de {{site.data.keyword.Bluemix_notm}} como, por ejemplo, parches de seguridad y del sistema operativo. IBM actualiza los maestros automáticamente, pero el usuario debe aplicar los parches a los nodos trabajadores.|
{: caption="Consecuencias en las actualizaciones de Kubernetes" caption-side="top"}

A medida que las actualizaciones pasan a estar disponibles, se le notifica al visualizar información sobre los nodos trabajadores, por ejemplo, con los mandatos `bx cs workers <cluster>` o `bx cs worker-get <cluster> <worker>`.
-  **Actualizaciones mayores y menores**: Primero [actualice su nodo maestro](cs_cluster_update.html#master) y, a continuación, [actualice los nodos trabajadores](cs_cluster_update.html#worker_node).  
   - De forma predeterminada, no se puede actualizar un maestro de Kubernetes con una antigüedad superior a dos versiones. Por ejemplo, si el maestro actual es de la versión 1.5 y desea actualizar a 1.8, primero se debe actualizar a la versión 1.7. Puede formar la actualización para continuar, pero actualizar a dos versiones anteriores puede provocar resultados imprevistos.
   - Si utiliza una versión de CLI `kubectl` que coincide al menos con la versión `major.minor` de los clústeres, puede experimentar resultados inesperados. Mantenga actualizadas las [versiones de la CLI](cs_cli_install.html#kubectl) y el clúster de Kubernetes.
-  **Actualizaciones de parches**: Compruebe mensualmente si hay actualizaciones disponibles, y utilice el [mandato](cs_cli_reference.html#cs_worker_update) `bx cs worker-update` para aplicar estos parches del sistema operativo. Para obtener más detalles, consulte el [registro de cambio de versiones](cs_versions_changelog.html). 

<br/>

La información de esta página resume las actualizaciones que pueden tener un probable impacto sobre las apps desplegadas al actualizar un clúster a una nueva versión desde la versión anterior. 
-  [Acciones de migración](#cs_v19) de la versión 1.9. 
-  [Acciones de migración](#cs_v18) de la versión 1.8. 
-  [Acciones de migración](#cs_v17) de la versión 1.7. 
-  [Archivo](#k8s_version_archive) de versiones no soportadas o en desuso. 

<br/>

Revise lo siguiente para obtener una lista completa de cambios: 
* [Registro de cambios de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Registro de cambios de versión de IBM](cs_versions_changelog.html).

## Versión 1.9
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="Este identificador indica la certificación de Kubernetes versión 1.9 para IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.9 bajo el programa CNCF de certificación de conformidad de software Kubernetes. _Kubernetes® es una marca registrada de The Linux Foundation en Estados Unidos y en otros países, y se utiliza de acuerdo con una licencia de The Linux Foundation._</p>

Revise los cambios que puede necesitar hacer cuando vaya a actualizar de la versión anterior de Kubernetes a 1.9.

<br/>

### Actualización antes de maestro
{: #19_before}

<table summary="Actualizaciones de Kubernetes para la versión 1.9">
<caption>Cambios necesarios antes de actualizar el maestro a Kubernetes 1.9</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>API de admisión de Webhook</td>
<td>La API de admisión, que se utiliza cuando el servidor de API llama a webhooks de control de admisión, se desplaza de <code>admission.v1alpha1</code> a <code>admission.v1beta1</code>. <em>Debe suprimir cualquier webhook existente antes de actualizar el clúster</em>, así como actualizar los archivos de configuración de webhook para utilizar la API más reciente. Este cambio no es compatible con versiones anteriores.</td>
</tr>
</tbody>
</table>

### Actualización después de maestro
{: #19_after}

<table summary="Actualizaciones de Kubernetes para la versión 1.9">
<caption>Cambios necesarios después de actualizar el maestro a Kubernetes 1.9</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descripción</th>
</tr>
</thead>
<tbody>
<tr>
<td>Salida `kubectl`</td>
<td>Ahora, cuando se utiliza el mandato `kubectl` para especificar `-o custom-columns` y no se encuentra la columna en el objeto, verá una salida de `<none>`.<br>
Antes, la operación fallaba y se mostraba el mensaje de error `No se ha encontrado xxx`. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Ahora, si no se realizan cambios en el recurso al que se aplican parches, el mandato `kubectl patch` falla con `exit code 1`. Si sus scripts se basan en el comportamiento anterior, actualícelos.</td>
</tr>
<tr>
<td>Permisos del panel de control de Kubernetes</td>
<td>Los usuarios tienen que iniciar sesión en el panel de control de Kubernetes con sus credenciales para ver los recursos del clúster. La autorización RBAC del panel de control de Kubernetes `ClusterRoleBinding` predeterminado se ha eliminado. Para obtener instrucciones, consulte [Inicio del panel de control de Kubernetes](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>Antagonismos y tolerancias</td>
<td>Los antagonismos `node.alpha.kubernetes.io/notReady` y `node.alpha.kubernetes.io/unreachable` se han cambiado a `node.kubernetes.io/not-ready` y `node.kubernetes.io/unreachable` respectivamente.<br>
A pesar de que los antagonismos se actualizan automáticamente, deberá actualizar manualmente las tolerancias para dichos antagonismos. Para cada espacio de nombre excepto para `ibm-system` y `kube-system`, determine si necesita cambiar las tolerancias:<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
Si se devuelve `Action required`, modifique las tolerancias de pod en consonancia.</td>
</tr>
<tr>
<td>API de admisión de Webhook</td>
<td>Si ha suprimido los webhooks existentes antes de actualizar el clúster, cree nuevos webhooks.</td>
</tr>
</tbody>
</table>

<br />


## Versión 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="padding-right: 10px;" align="left" alt="Este identificador indica la certificación de Kubernetes versión 1.8 para IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.8 bajo el programa CNCF de certificación de conformidad de software Kubernetes. _Kubernetes® es una marca registrada de The Linux Foundation en Estados Unidos y en otros países, y se utiliza de acuerdo con una licencia de The Linux Foundation._</p>

Revise los cambios que puede necesitar hacer cuando vaya a actualizar de la versión anterior de Kubernetes a 1.8.

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
<td>Ninguno</td>
<td>No hay cambios necesarios antes de actualizar el maestro</td>
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
<td>El mandato `kubectl delete` ya no reduce los objetos de la API de carga de trabajo, como los pods, antes de suprimir el objeto. Si necesita reducir el objeto, utilice la [`escala kubectl ` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale) antes de suprimir el objeto.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>El mandato `kubectl run` debe utilizar varios distintivos para `--env` en lugar de argumentos separados por comas. Por ejemplo, ejecute <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code> y no <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>El mandato `kubectl stop` ya no está disponible.</td>
</tr>
<tr>
<td>Volúmenes de datos de API de solo lectura</td>
<td>Ahora se montan como de solo lectura los volúmenes proyectados, `secret`, `configMap` y `downwardAPI`. Con anterioridad, las apps podían escribir datos en estos volúmenes que el sistema podía revertir de forma automática. Esta acción de migración es necesaria para corregir la vulnerabilidad de seguridad [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Si sus apps se basaban en este comportamiento inseguro anterior, modifíquelas en consecuencia. </td>
</tr>
</tbody>
</table>

<br />


## Versión 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" style="padding-right: 10px;" align="left" alt="Este identificador indica la certificación de Kubernetes versión 1.7 para IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} es un producto Kubernetes certificado para la versión 1.7 bajo el programa CNCF de certificación de conformidad de software Kubernetes.</p>

Revise los cambios que puede necesitar hacer cuando vaya a actualizar de la versión anterior de Kubernetes a 1.7.

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
<td>`apiVersion` de despliegue</td>
<td>Después de actualizar el clúster de Kubernetes 1.5, utilice `apps/v1beta1` para el campo `apiVersion` en los nuevos archivos YAML de `despliegue`. Continúe utilizando `extensions/v1beta1` para otros recursos, como `Ingress`.</td>
</tr>
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
</td></tr>
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
</td></tr>
<tr>
<td>RBAC para `default` `ServiceAccount`</td>
<td><p>Se ha eliminado el administrador `ClusterRoleBinding` para `default` `ServiceAccount` en el espacio de nombres `default` para mejorar la seguridad del clúster. Las aplicaciones que se ejecutan en el espacio de nombres `default` ya no tienen privilegios de administrador de clúster en la API de Kubernetes, y se pueden producir errores de permisos `RBAC DENY`. Compruebe su app y su archivo `.yaml` para ver si se ejecuta en el espacio de nombres `default`, utiliza `default ServiceAccount` y accede a la API de Kubernetes. </p>
<p>Si las aplicaciones dependen de estos privilegios, [cree recursos de autorización RBAC ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) para sus apps. </p>
  <p>A medida que actualice las políticas de RBAC de las apps, es posible que desee volver temporalmente al valor `default` anterior. Copie, guarde y aplique los archivos siguientes con el mandato `kubectl apply -f FILENAME`. <strong>Nota</strong>: Realice esta reversión para darse tiempo a actualizar todos los recursos de aplicación y no como una solución a largo plazo.</p>

<p><pre class="codeblock">
<code>
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
 name: admin-binding-nonResourceURLSs-default
subjects:
  - kind: ServiceAccount
    name: default
    namespace: default
roleRef:
 kind: ClusterRole
 name: admin-role-nonResourceURLSs
 apiGroup: rbac.authorization.k8s.io
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
 name: admin-binding-resourceURLSs-default
subjects:
  - kind: ServiceAccount
      name: default
      namespace: default
  roleRef:
   kind: ClusterRole
   name: admin-role-resourceURLSs
   apiGroup: rbac.authorization.k8s.io
</code>
</pre></p>
</td>
</tr>
<tr>
<td>Volúmenes de datos de API de solo lectura</td>
<td>Ahora se montan como de solo lectura los volúmenes proyectados, `secret`, `configMap` y `downwardAPI`. Con anterioridad, las apps podían escribir datos en estos volúmenes que el sistema podía revertir de forma automática. Esta acción de migración es necesaria para corregir la vulnerabilidad de seguridad [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Si sus apps se basaban en este comportamiento inseguro anterior, modifíquelas en consecuencia. </td>
</tr>
<tr>
<td>StatefulSet pod DNS</td>
<td>Los pods StatefulSet pierden las entradas Kubernetes DNS correspondientes después de haber actualizado el maestro. Para restaurar las entradas DNS, suprima los pods StatefulSet. Kubernetes vuelve a crear los pods y restaura automáticamente las entradas DNS. Para más información, consulte el [Tema sobre Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://github.com/kubernetes/kubernetes/issues/48327).</td>
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
</td></tr>
<tr>
<td>Antagonismos</td>
<td>La anotación `scheduler.alpha.kubernetes.io/taints` ya no está disponible.
<ol>
  <li>Determine si necesita cambiar los antagonismos: </br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Si se devuelve `"Action required"`, elimine la anotación `scheduler.alpha.kubernetes.io/taints` para cada nodo:</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Añada un antagonismo a cada nodo:</br>
  `kubectl taint node <node> <taint>`
  </li></ol>
</td></tr>
</tbody>
</table>

<br />


## Archivo
{: #k8s_version_archive}

### Versión 1.5 (no soportada)
{: #cs_v1-5}

A partir del 4 de abril de 2018, se deja de dar soporte a los clústeres de {{site.data.keyword.containershort_notm}} que ejecutan [la versión 1.5 de Kubernetes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md). Los clústeres de la versión 1.5 no pueden recibir actualizaciones de seguridad ni soporte a menos que se actualicen a la siguiente versión más reciente ([Kubernetes 1.7](#cs_v17)).

[Revise el impacto potencial](cs_versions.html#cs_versions) de cada actualización de versión de Kubernetes y luego [actualice los clústeres](cs_cluster_update.html#update) inmediatamente. Tenga en cuenta que debe actualizar de una versión a la siguiente más reciente, como por ejemplo de la 1.5 y a la 1.7 o de la 1.8 a la 1.9.

