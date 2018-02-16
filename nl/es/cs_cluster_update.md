---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Actualización de clústeres y nodos trabajadores
{: #update}

## Actualización del Kubernetes maestro
{: #master}

Periódicamente, Kubernetes publica actualizaciones. Podría ser una [actualización mayor, menor o un parche](cs_versions.html#version_types). En función del tipo de actualización, podría ser responsable de actualizar su Kubernetes maestro. Usted siempre es el responsable de mantener actualizados los nodos trabajadores. Cuando se realizan actualizaciones, el Kubernetes maestro se actualiza antes que los nodos trabajadores.
{:shortdesc}

De forma predeterminada, limitamos la posibilidad de actualizar un maestro de Kubernetes con una antigüedad superior a dos versiones después de su versión actual. Por ejemplo, si el maestro actual es de la versión 1.5 y desea actualizar a 1.8, primero se debe actualizar a la versión 1.7. Puede forzar que se produzca, pero actualizar a dos versiones menores puede provocar resultados imprevistos.

El diagrama siguiente muestra el proceso que puede realizar para actualizar el maestro. 

![Práctica recomendada para actualizar el maestro](/images/update-tree.png)

Figura 1. Diagrama del proceso de actualización del Kubernetes maestro

**Atención**: No puede retrotraer un clúster a una versión anterior una vez se ha realizado el proceso de actualización. Asegúrese de utilizar un clúster de prueba y siga las instrucciones para abordar posibles problemas antes de actualizar el maestro de producción.

Para las actualizaciones _mayores_ o _menores_, siga estos pasos: 

1. Revise los [cambios de Kubernetes](cs_versions.html) y realice las actualizaciones marcadas como _Actualizar antes que maestro_.
2. Actualizar el Kubernetes maestro mediante la GUI o mediante la ejecución del [mandato de CLI](cs_cli_reference.html#cs_cluster_update). Cuando actualice el Kubernetes maestro, el maestro está inactivo durante unos 5 o 10 minutos. Durante la actualización, no puede acceder ni cambiar el clúster. Sin embargo, los nodos trabajadores, las apps y los recursos que los usuarios del clúster han desplegado no se modifican y continúan ejecutándose.
3. Confirme que la actualización se ha completado. Revise la versión de Kubernetes en el panel de control de {{site.data.keyword.Bluemix_notm}} o ejecutando `cs bx clusters`.

Cuando finalice la actualización del Kubernetes maestro, puede actualizar los nodos trabajadores.

<br />


## Actualización de nodos trabajadores
{: #worker_node}

Ha recibido una notificación para actualizar sus nodos trabajadores. ¿Qué significa esto? Sus datos se almacenan dentro de los pods de los nodos trabajadores. Como las actualizaciones y parches de seguridad se han aplicado para el Kubernetes maestro, debe asegurarse de que los nodos trabajadores permanecen sincronizados. El maestro del nodo trabajador no puede ser superior al Kubernetes maestro.
{: shortdesc}

<ul>**Atención:**:</br>
<li>Las actualizaciones de los nodos trabajadores pueden provocar que las apps y servicios estén un tiempo inactivos. </li>
<li>Los datos se suprimen si no están almacenados fuera del pod.</li>
<li>Utilice [réplicas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) si los despliegues permiten volver a planificar pods en nodos disponibles.</li></ul>

¿Qué ocurre si no puedo tener un tiempo de inactividad?

Como parte del proceso de actualización, algunos nodos específicos estarán inactivos durante un periodo de tiempo. Para evitar los tiempos de inactividad para su aplicación, puede definir claves exclusivas en un mapa de configuración que especifiquen porcentajes de umbral para determinados tipos de nodo durante el proceso de actualización. Definiendo reglas basadas en etiquetas estándar de Kubernetes y dando un porcentaje de la cantidad máxima de nodos que pueden estar disponibles, puede asegurarse de que su app siga activa y en ejecución. Se considera que un nodo está disponible si todavía tiene que completar el proceso de despliegue. 

¿Cómo se definen las claves?

En el mapa de configuración, hay una sección que contiene información de datos. Puede definir hasta 10 reglas separadas para ejecutarse en cualquier momento. Para que se actualice un nodo trabajador, los nodos deben pasar todas las reglas definidas en el mapa. 

Las claves están definidas. ¿Qué hago?

Una vez haya definido las reglas, ejecute el mandato de actualización de trabajador. Si se devuelve una respuesta satisfactoria, los nodos trabajadores se pondrán en cola para ser actualizados. Sin embargo, los nodos no pasan por el proceso de actualización hasta que se satisfacen todas las reglas. Mientras están en cola, las reglas se comprueban a intervalos para ver si alguno de los nodos puede ser actualizado. 

¿Qué ocurre si opto por no definir ningún mapa de configuración?

Si el mapa de configuración no está definido, se utiliza el valor predeterminado. De forma predeterminada, como máximo el 20% de todos los nodos trabajadores de cada clúster están disponibles durante el proceso de actualización.

Para actualizar los nodos trabajadores:

1. Instale la versión de [`kubectl cli` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) que coincida con la versión de Kubernetes del Kubernetes maestro.

2. Aplique los cambios que se marcan como _Actualizar después de maestro_ en [Cambios de Kubernetes](cs_versions.html).

3. Opcional: Defina el mapa de configuración.
    Ejemplo:

    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 70,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
         "NodeSelectorValue": "dal13"
       }
     regioncheck.json: |
       {
         "MaxUnavailablePercentage": 80,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
         "NodeSelectorValue": "us-south"
       }
    ...
     defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 100
       }
    ```
    {:pre}
  <table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha, con el parámetro en la columna uno y la descripción correspondiente en la columna dos. ">
    <thead>
      <th colspan=2><img src="images/idea.png"/> Visión general de los componentes </th>
    </thead>
    <tbody>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td> De forma predeterminada, si el mapa ibm-cluster-update-configuration no está definido de forma válida, sólo el 20% de los clústeres podrán estar no disponibles a la vez. Si se definen una o varias reglas válidas sin un valor predeterminado global, el nuevo valor predeterminado es permitir que el 100% de los trabajadores estén no disponibles simultáneamente. Puede controlarlo creando un porcentaje predeterminado. </td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td> Ejemplos de claves exclusivas para las que desea establecer reglas. Los nombres de las claves pueden ser los que desee; las configuraciones definidas en la clave analizan la información. Para cada clave que defina, sólo puede establecer un valor para <code>NodeSelectorKey</code> y <code>NodeSelectorValue</code>. Si desea establecer reglas para más de una región o ubicación (centro de datos), cree una nueva entrada de clave. </td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td> La cantidad máxima de nodos que pueden estar no disponibles para una clave especificada, indicada como porcentaje. Un nodo no está disponible cuando está en proceso de despliegue, recarga o suministro. Los nodos trabajadores en cola están bloqueados para actualizarse si se supera cualquier porcentaje disponible máximo definido. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td> El tipo de etiqueta para el que desea establecer una regla para una clave especificada. Puede establecer reglas para las etiquetas predeterminadas proporcionadas por IBM, así como para las etiquetas que haya creado. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td> El subconjunto de nodos en una clave especificada que la regla tiene establecido evaluar. </td>
      </tr>
    </tbody>
  </table>

    **Nota**: Se pueden definir 10 reglas como máximo. Si añade más de 10 claves a un archivo, sólo se analiza un subconjunto de la información. 

3. Actualice los nodos trabajadores de la GUI o ejecutando el mandato de CLI.
  * Para actualizar desde el panel de control de {{site.data.keyword.Bluemix_notm}}, vaya a la sección `Nodos trabajadores` del clúster y pulse `Actualizar trabajador`.
  * Para obtener los ID de los nodos trabajadores, ejecute `bx cs workers <cluster_name_or_id>`. Si selecciona varios nodos trabajadores, los nodos trabajadores se colocan en cola para la evaluación de la actualización. Si se considera que están listos tras la evaluación, se actualizarán según las reglas establecidas en las configuraciones. 

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. Opcional: Compruebe los sucesos que desencadena el mapa de configuración y los errores de validación que se produzcan ejecutando el mandato siguiente y observando los **Sucesos**.
    ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
    {: pre}

5. Confirme que la actualización se ha completado:
  * Revise la versión de Kubernetes en el panel de control de {{site.data.keyword.Bluemix_notm}} o ejecutando `cs bx workers <cluster_name_or_id>`.
  * Revise la versión de Kubernetes de los nodos trabajadores ejecutando `kubectl get nodes`.
  * En algunos casos, es posible que los clústeres antiguos muestren nodos trabajadores duplicados con el estado **NotReady** después de una actualización. Para eliminar los duplicados, consulte [resolución de problemas](cs_troubleshoot.html#cs_duplicate_nodes).

Pasos siguientes:
  - Repita el proceso de actualización con otros clústeres.
  - Informe a los desarrolladores que trabajan en el clúster para que actualicen su CLI de `kubectl` a la versión del Kubernetes maestro.
  - Si el panel de control de Kubernetes no muestra los gráficos de utilización, [suprima el pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).
<br />

