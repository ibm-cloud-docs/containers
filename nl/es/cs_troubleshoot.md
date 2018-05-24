---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Resolución de problemas de clústeres
{: #cs_troubleshoot}

Si utiliza {{site.data.keyword.containerlong}}, tenga en cuenta estas técnicas para solucionar problemas y obtener ayuda. También puede consultar el [estado del sistema {{site.data.keyword.Bluemix_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/support/#status).
{: shortdesc}

Puede seguir algunos pasos generales para asegurarse de que los clústeres están actualizados:
- [Rearranque los nodos trabajadores](cs_cli_reference.html#cs_worker_reboot) de forma regular para garantizar la instalación de actualizaciones y parches de seguridad que IBM despliega automáticamente en el sistema operativo
- Actualice el clúster para [la versión predeterminada más reciente de Kubernetes](cs_versions.html) para {{site.data.keyword.containershort_notm}}

<br />




## Depuración de clústeres
{: #debug_clusters}

Revise las opciones para depurar sus clústeres y encontrar las causas raíz de los errores.

1.  Obtenga una lista con su clúster y busque el `Estado` del clúster.

  ```
  bx cs clusters
  ```
  {: pre}

2.  Revise el `Estado` de su clúster. Si el clúster está en estado **Crítico**, **Error al suprimir** o **Aviso**, o se ha bloqueado en el estado **Pendiente** durante mucho tiempo, inicie la [depuración de los nodos trabajadores](#debug_worker_nodes).

    <table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
   <thead>
   <th>Estado del clúster</th>
   <th>Descripción</th>
   </thead>
   <tbody>
<tr>
   <td>Terminado anormalmente</td>
   <td>El usuario ha solicitado la supresión del clúster antes de desplegar el maestro de Kubernetes. Una vez realizada la supresión del clúster, el clúster se elimina del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
 <tr>
     <td>Crítico</td>
     <td>No se puede acceder al maestro de Kubernetes o todos los nodos trabajadores del clúster están inactivos. </td>
    </tr>
   <tr>
     <td>Error al suprimir</td>
     <td>No se puede suprimir el maestro de Kubernetes o al menos un nodo trabajador.  </td>
   </tr>
   <tr>
     <td>Suprimido</td>
     <td>El clúster se ha suprimido pero todavía no se ha eliminado del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
   <td>Suprimiendo</td>
   <td>El clúster se está suprimiendo y la infraestructura del clúster se está desmontando. No puede acceder al clúster.  </td>
   </tr>
   <tr>
     <td>Error al desplegar</td>
     <td>El despliegue del maestro de Kubernetes no se ha podido realizar. No puede resolver este estado. Póngase en contacto con el soporte de IBM Cloud abriendo una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
     <tr>
       <td>Despliegue</td>
       <td>El maestro de Kubernetes no está completamente desplegado. No puede acceder a su clúster. Espere hasta que el clúster se haya desplegado por completo para revisar el estado del clúster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster. Este estado se considera correcto y no requiere ninguna acción por su parte.</td>
    </tr>
      <tr>
       <td>Pendiente</td>
       <td>El maestro de Kubernetes está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.  </td>
     </tr>
   <tr>
     <td>Solicitado</td>
     <td>Se ha enviado una solicitud para crear el clúster y pedir la infraestructura para el maestro de Kubernetes y los nodos trabajadores. Cuando se inicia el despliegue del clúster, el estado del clúster cambia a <code>Desplegando</code>. Si el clúster está bloqueado en el estado <code>Solicitado</code> durante mucho tiempo, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
     <td>Actualizando</td>
     <td>El servidor de API de Kubernetes que se ejecuta en el maestro de Kubernetes está siendo actualizado a una versión nueva de API de Kubernetes. Durante la actualización, no puede acceder ni cambiar el clúster. Los nodos trabajadores, las apps y los recursos que los usuarios del clúster han desplegado no se modifican y continúan ejecutándose. Espere a que la actualización se complete para revisar el estado del clúster. </td>
   </tr>
    <tr>
       <td>Aviso</td>
       <td>Al menos un nodo trabajador del clúster no está disponible, pero los otros nodos trabajadores están disponibles y pueden asumir la carga de trabajo. </td>
    </tr>
   </tbody>
 </table>

<br />


## Depuración de nodos trabajadores
{: #debug_worker_nodes}

Revise las opciones para depurar sus nodos trabajadores y encontrar las causas raíz de los errores.


1.  Si el clúster está en estado **Crítico**, **Error al suprimir** o **Aviso**, o se ha bloqueado en el estado **Pendiente** durante mucho tiempo, revise el estado de los nodos trabajadores.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

2.  Revise los campos `State` y `Status` de cada nodo trabajador en la salida de la CLI.

  <table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
    <thead>
    <th>Estado del nodo trabajador</th>
    <th>Descripción</th>
    </thead>
    <tbody>
  <tr>
      <td>Crítico</td>
      <td>Un nodo trabajador puede entrar en estado Crítico por muchas razones. Las razones más comunes son los siguientes: <ul><li>Rearrancar el nodo trabajador sin acordonarlo ni drenarlo. Rearrancar un nodo trabajador puede provocar que se corrompan los datos en <code>docker</code>, <code>kubelet</code>, <code>kube-proxy</code> y <code>calico</code>. </li><li>Los pods que se despliegan en el nodo trabajador no utilizan límites de recursos para [memoria ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) y [CPU ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Sin límites de recursos, los pods pueden consumir todos los recursos disponibles y no dejar recursos para que se ejecuten otros pods en este nodo trabajador. Esta sobrecarga de trabajo provoca que el nodo trabajador falle. </li><li><code>Docker</code>, <code>kubelet</code> o <code>calico</code> pueden entrar en un estado irrecuperable después de ejecutar cientos o miles de contenedores a lo largo del tiempo. </li><li>Tener configurado un Vyatta para el nodo trabajador que se quede inactivo y se interrumpa así la comunicación entre el nodo trabajador y el maestro de Kubernetes. </li><li> Problemas de red en {{site.data.keyword.containershort_notm}} o en la infraestructura de IBM Cloud (SoftLayer) que provoquen que falle la comunicación entre el nodo trabajador y el maestro de Kubernetes.</li><li>Que el nodo trabajador agote su capacidad. Compruebe el campo <strong>Status</strong> del nodo trabajador para ver si es <strong>Out of disk</strong> u <strong>Out of memory</strong>. Si el nodo trabajador se ha quedado sin capacidad, considere reducir la carga de trabajo del nodo trabajador o añadir un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</li></ul> En muchos casos, el problema se resuelve al [recargar](cs_cli_reference.html#cs_worker_reload) el nodo trabajador. Antes de recargar el nodo trabajador, acordone y drene el nodo trabajador para que los pods existentes finalicen correctamente y se vuelvan a programar en los demás nodos trabajadores. </br></br> Si la recarga del nodo trabajador no resuelve el problema, vaya al siguiente paso para continuar la resolución de problemas del nodo trabajador. </br></br><strong>Sugerencia:</strong> Puede [configurar comprobaciones de estado del nodo trabajador y habilitar la recuperación automática](cs_health.html#autorecovery). Si la recuperación automática detecta un nodo trabajador erróneo basado en las comprobaciones configuradas, desencadena una acción correctiva, como una recarga del sistema operativo, en el nodo trabajador. Para obtener más información sobre cómo funciona la recuperación automática, consulte el [blog sobre recuperación automática ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
      </td>
     </tr>
      <tr>
        <td>Despliegue</td>
        <td>Cuando se actualiza la versión de Kubernetes del nodo trabajador, el nodo trabajador se vuelve a desplegar para instalar las actualizaciones. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo, continúe en el paso siguiente para ver si se ha producido un problema durante la recarga. </td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>El nodo trabajador se ha suministrado por completo y está listo para ser utilizado en el clúster. Este estado se considera correcto y no requiere ninguna acción por parte del usuario.</td>
     </tr>
   <tr>
        <td>Suministro</td>
        <td>El nodo trabajador se está suministrando y aún no está disponible en el clúster. Puede supervisar el proceso de suministro en la columna <strong>Estado</strong> de la salida de la CLI. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo y no ve ningún progreso en la columna <strong>Estado</strong>, continúe en el paso siguiente para ver si se ha producido un problema durante el suministro.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>El nodo trabajador no se ha podido suministrar. Continúe en el paso siguiente para ver los detalles del error.</td>
      </tr>
   <tr>
        <td>Recarga</td>
        <td>El nodo trabajador se está recargando y no está disponible en el clúster. Puede supervisar el proceso de recarga en la columna <strong>Estado</strong> de la salida de la CLI. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo y no ve ningún progreso en la columna <strong>Estado</strong>, continúe en el paso siguiente para ver si se ha producido un problema durante la recarga.</td>
       </tr>
       <tr>
        <td>Reloading_failed </td>
        <td>El nodo trabajador no se ha podido recargar. Continúe en el paso siguiente para ver los detalles del error.</td>
      </tr>
      <tr>
        <td>Reload_pending </td>
        <td>Se ha enviado una solicitud para recargar o actualizar la versión de Kubernetes del nodo trabajador. Cuando el nodo trabajador se está recargando, el estado cambia a <code>Recarga</code>. </td>
      </tr>
      <tr>
       <td>Desconocido</td>
       <td>No se puede acceder al maestro de Kubernetes por uno de estos motivos:<ul><li>Ha solicitado una actualización del maestro de Kubernetes. El estado del nodo trabajador no se puede recuperar durante la actualización.</li><li>Es posible que tenga un cortafuegos adicional que está protegiendo sus nodos trabajadores o que haya modificado los valores del cortafuegos recientemente. {{site.data.keyword.containershort_notm}} requiere que determinadas direcciones IP y puertos estén abiertos para permitir la comunicación entre el nodo trabajador y el maestro de Kubernetes y viceversa. Para obtener más información, consulte [El cortafuegos impide que los nodos trabajadores se conecten](#cs_firewall).</li><li>El maestro de Kubernetes está inactivo. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</li></ul></td>
  </tr>
     <tr>
        <td>Aviso</td>
        <td>El nodo trabajador está a punto de alcanzar el límite de memoria o de espacio de disco. Puede reducir la carga de trabajo del nodo trabajador o añadir un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</td>
  </tr>
    </tbody>
  </table>

5.  Obtener los detalles del nodo trabajador. Si en los detalles se incluye un mensaje de error, revise la lista de [mensajes de error comunes para nodos trabajadores](#common_worker_nodes_issues) para saber cómo resolver el problema.

   ```
   bx cs worker-get <worker_id>
   ```
   {: pre}

  ```
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

<br />


## Problemas comunes con los nodos trabajadores
{: #common_worker_nodes_issues}

Revise los mensajes de error comunes y busque cómo resolverlos.

  <table>
    <thead>
    <th>Mensaje de error</th>
    <th>Descripción y resolución
    </thead>
    <tbody>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: En este momento su cuenta no tiene permitido solicitar 'Instancias de cálculo'.</td>
        <td>Puede que su cuenta de infraestructura de IBM Cloud (SoftLayer) tenga restringida la solicitud de recursos de cálculo. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</td>
      </tr>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: No se ha podido realizar el pedido. No hay suficientes recursos tras el direccionador 'router_name' para realizar la solicitud para los siguientes invitados: 'worker_id'.</td>
        <td>La VLAN que ha seleccionado está asociada a un pod del centro de datos que no tiene suficiente espacio para suministrar el nodo trabajador. Puede elegir entre las opciones siguientes:<ul><li>Utilice otro centro de datos para suministrar el nodo trabajador. Ejecute <code>bx cs locations</code> para ver una lista de los centros de datos disponibles.<li>Si tiene un par existente de VLAN pública y privada asociado a otro pod del centro de datos, utilice este par de VLAN.<li>Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</ul></td>
      </tr>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: No se ha podido obtener la VLAN de red con el id: &lt;vlan id&gt;.</td>
        <td>El nodo trabajador no se ha podido suministrar porque no se ha encontrado el ID de VLAN por una de las siguientes razones:<ul><li>Puede que haya especificado el número de VLAN en lugar del ID de VLAN. El número de VLAN tiene 3 ó 4 dígitos, mientras que el ID de VLAN tiene 7 dígitos. Ejecute <code>bx cs vlans &lt;location&gt;</code> para recuperar el ID de VLAN.<li>Es posible que el ID de VLAN no esté asociado a la cuenta de infraestructura de IBM Cloud (SoftLayer) que está utilizando. Ejecute <code>bx cs vlans &lt;location&gt;</code> ver una lista de los ID de VLAN disponibles para su cuenta. Para cambiar la cuenta de infraestructura de IBM Cloud (SoftLayer), consulte [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: La ubicación suministrada para este pedido no es válida. (HTTP 500)</td>
        <td>Su cuenta de infraestructura de IBM Cloud (SoftLayer) no está configurada para solicitar recursos de cálculo en el centro de datos seleccionado. Póngase en contacto con el [equipo de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support) para comprobar que la cuenta está correctamente configurada.</td>
       </tr>
       <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El usuario no tiene los permisos necesarios de la infraestructura de {{site.data.keyword.Bluemix_notm}} para añadir servidores
        </br></br>
        Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El elemento 'Item' se debe solicitar con permiso.</td>
        <td>Es posible que no tenga los permisos necesarios para suministrar un nodo trabajador desde el portafolio de infraestructura de IBM Cloud (SoftLayer). Consulte [Configuración del acceso al portafolio de infraestructura de IBM Cloud (SoftLayer) para crear clústeres de Kubernetes estándares](cs_infrastructure.html#unify_accounts).</td>
      </tr>
      <tr>
       <td>El trabajador no se puede comunicar con los servidores de {{site.data.keyword.containershort_notm}}. Verifique que la configuración del cortafuegos permite el tráfico de este trabajador.
       <td><ul><li>Si tiene un cortafuegos, [configure los valores de cortafuegos para permitir el tráfico saliente a los puertos y direcciones IP adecuados](cs_firewall.html#firewall_outbound).</li><li>Compruebe si el clúster no tiene una IP pública ejecutando `bx cs workers <mycluster>`. Si no aparece ninguna IP pública en la lista, entonces el clúster sólo tiene VLAN privadas.<ul><li>Si desea que el clúster sólo tenga VLAN privadas, compruebe que ha configurado la [conexión de VLAN](cs_clusters.html#worker_vlan_connection) y el [cortafuegos](cs_firewall.html#firewall_outbound).</li><li>Si desea que el clúster tenga una IP pública, [añada nuevos nodos trabajadores](cs_cli_reference.html#cs_worker_add) con VLAN públicas y privadas.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>No se puede crear la señal de portal de IMS, ya que ninguna cuenta de IMS está enlazada con la cuenta de BSS seleccionada</br></br>El usuario proporcionado no se ha encontrado o está activo</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus: La cuenta del usuario está actualmente en estado cancel_pending.</td>
  <td>El propietario de la clave de API que se utiliza para acceder al portfolio de infraestructura de IBM Cloud (SoftLayer) no tiene los permisos necesarios para realizar la acción o puede estar pendiente de supresión.</br></br><strong>Como usuario</strong>, siga estos pasos: <ol><li>Si tiene acceso a varias cuentas, asegúrese de que ha iniciado la sesión en la cuenta en la que desea trabajar con {{site.data.keyword.containerlong_notm}}. </li><li>Ejecute <code>bx cs api-key-info</code> para ver el propietario de la clave de API actual que se utiliza para acceder al portfolio de infraestructura de IBM Cloud (SoftLayer) próximo. </li><li>Ejecute <code>bx account list</code> para ver el propietario de la cuenta de {{site.data.keyword.Bluemix_notm}} que utiliza actualmente. </li><li>Póngase en contacto con el propietario de la cuenta de {{site.data.keyword.Bluemix_notm}} e infórmele de que el propietario de la clave de API que ha recuperado anteriormente tiene permisos insuficientes en la infraestructura de IBM Cloud (SoftLayer) o puede estar pendiente de supresión. </li></ol></br><strong>Como propietario de cuenta</strong>, siga estos pasos: <ol><li>Revise los [permisos necesarios en la infraestructura de IBM Cloud (SoftLayer)](cs_users.html#managing) para realizar la acción que ha fallado anteriormente. </li><li>Corrija los permisos del propietario de la clave de API o cree una nueva clave de API mediante [el mandato <code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). </li><li>Si usted u otro administrador de la cuenta define manualmente las credenciales de la infraestructura de IBM Cloud (SoftLayer) en la cuenta, ejecute [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) para eliminar las credenciales de la cuenta.</li></ol></td>
  </tr>
    </tbody>
  </table>



<br />




## Depuración de despliegues de app
{: #debug_apps}

Revise las opciones que tiene para depurar sus despliegues de app y busque las causas raíz de los errores.

1. Busque anomalías en el servicio o en los recursos de despliegue mediante el mandato `describe`.

 Ejemplo:
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [Compruebe si los contenedores están bloqueados en el estado ContainerCreating](#stuck_creating_state).

3. Compruebe si el clúster está en el estado `Critical`. Si el clúster está en el estado `Critical`, compruebe las reglas de cortafuegos y verifique que el maestro se puede comunicar con los nodos trabajadores.

4. Verifique que el servicio está a la escucha en el puerto correcto.
   1. Obtenga el nombre de un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Inicie una sesión en un contenedor.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Ejecute curl sobre la app desde dentro del contenedor. Si no se puede acceder al puerto, es posible que el servicio no esté a la escucha en el puerto correcto o que la app tenga problemas. Actualice el archivo de configuración para el servicio con el puerto correcto y vuelva a desplegar o investigue posibles problemas con la app.
     <pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. Verifique que el servicio está enlazado correctamente a los pods.
   1. Obtenga el nombre de un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Inicie una sesión en un contenedor.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Ejecute curl sobre la dirección IP del clúster y el puerto del servicio. Si no se puede acceder a la dirección IP y al puerto, mire los puntos finales correspondientes al servicio. Si no hay puntos finales, el selector del servicio no coincide con los pods. Si hay puntos finales, mire el campo del puerto de destino en el servicio y asegúrese de que el puerto de destino es el mismo que el que se utiliza para los pods.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Para servicios Ingress, verifique que se puede acceder al servicio desde dentro del clúster.
   1. Obtenga el nombre de un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Inicie una sesión en un contenedor.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Ejecute curl sobre el URL especificado para el servicio Ingress. Si no se puede acceder al URL, compruebe si hay un problema de cortafuegos entre el clúster y el punto final externo. 
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />


## No se puede conectar con la cuenta de infraestructura
{: #cs_credentials}

{: tsSymptoms}
Cuando crea un nuevo clúster de Kubernetes, recibe el siguiente mensaje.

```
No se ha podido conectar con la cuenta de IBM infraestructura de Cloud (SoftLayer).
Para crear un clúster estándar, debe tener una cuenta de pago según uso enlazada a una cuenta de infraestructura de IBM Cloud (SoftLayer) o debe haber utilizado la CLI de {{site.data.keyword.Bluemix_notm}} Container Service para configurar las claves de API de la infraestructura de {{site.data.keyword.Bluemix_notm}}.
```
{: screen}

{: tsCauses}
Los usuarios con una cuenta de {{site.data.keyword.Bluemix_notm}} que no esté enlazada deben crear una nueva cuenta de pago según uso o deben añadir manualmente las claves de API de infraestructura de IBM Cloud (SoftLayer) utilizando la CLI de {{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Para añadir credenciales de la cuenta de {{site.data.keyword.Bluemix_notm}}:

1.  Póngase en contacto con el administrador de infraestructura de IBM Cloud (SoftLayer) para obtener el nombre de usuario y la clave de API de infraestructura de IBM Cloud (SoftLayer).

    **Nota:** La cuenta de infraestructura de IBM Cloud (SoftLayer) que utilice debe estar configurada con permisos de superusuario para poder crear correctamente clústeres estándares.

2.  Añada las credenciales.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Cree un clúster estándar.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## El cortafuegos impide ejecutar mandatos de CLI
{: #ts_firewall_clis}

{: tsSymptoms}
Cuando ejecuta los mandatos `bx`, `kubectl` o `calicoctl` desde la CLI, fallan.

{: tsCauses}
Puede que tenga políticas de red corporativas que impidan el acceso desde el sistema local a los puntos finales públicos mediante proxies o cortafuegos.

{: tsResolve}
[Permita el acceso TCP para que funciones los mandatos de CLI](cs_firewall.html#firewall). Esta tarea precisa de la [política de acceso de administrador](cs_users.html#access_policies). Verifique su [política de acceso](cs_users.html#infra_access) actual.


## El cortafuegos impide que el clúster se conecte a recursos
{: #cs_firewall}

{: tsSymptoms}
Cuando los nodos trabajadores no se pueden conectar, es posible que vea diversos síntomas. Puede ver uno de los siguientes mensajes cuando el proxy de kubectl falla o cuando intenta acceder a un servicio del clúster y la conexión falla.

  ```
  Conexión rechazada
  ```
  {: screen}

  ```
  La conexión ha excedido el tiempo de espera
  ```
  {: screen}

  ```
  No se puede conectar con el servidor: net/http: tiempo de espera excedido de reconocimiento de TLS
  ```
  {: screen}

Si ejecuta kubectl exec, attach o logs, puede ver el siguiente mensaje:

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Si el proxy kubectl se ejecuta correctamente pero el panel de control no está disponible, puede ver el siguiente mensaje.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Es posible que tenga un cortafuegos adicional configurado o que se hayan personalizado los valores existentes del cortafuegos en la cuenta de infraestructura de IBM Cloud (SoftLayer). {{site.data.keyword.containershort_notm}} requiere que determinadas direcciones IP y puertos estén abiertos para permitir la comunicación entre el nodo trabajador y el maestro de Kubernetes y viceversa. Otro motivo puede ser que los nodos trabajadores están bloqueados en un bucle de recarga.

{: tsResolve}
[Permita que el clúster acceda a los recursos de infraestructura y a otros servicios](cs_firewall.html#firewall_outbound). Esta tarea precisa de la [política de acceso de administrador](cs_users.html#access_policies). Verifique su [política de acceso](cs_users.html#infra_access) actual.

<br />



## El acceso al nodo trabajador con SSH falla
{: #cs_ssh_worker}

{: tsSymptoms}
No puede acceder a un nodo trabajador mediante una conexión SSH.

{: tsCauses}
SSH mediante contraseña está inhabilitado en los nodos trabajadores.

{: tsResolve}
Utilice [DaemonSets ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) para lo que tenga que ejecutar en cada nodo o para los trabajos correspondientes a acciones únicas que deba ejecutar.

<br />



## Al enlazar un servicio a un clúster se produce un error de nombre
{: #cs_duplicate_services}

{: tsSymptoms}
Cuando ejecute `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>` verá el siguiente mensaje.

```
Se han encontrado varios servicios con el mismo nombre.
Ejecute 'bx service list' para ver las instancias de servicio de Bluemix disponibles...
```
{: screen}

{: tsCauses}
Varias instancias de servicio pueden tener el mismo nombre en distintas regiones.

{: tsResolve}
Utilice el GUID de servicio en lugar del nombre de instancia de servicio en el mandato `bx cs cluster-service-bind`.

1. [Inicie sesión en la región que incluye la instancia de servicio que se debe enlazar.](cs_regions.html#bluemix_regions)

2. Obtenga el GUID de la instancia de servicio.
  ```
  bx service show <service_instance_name> --guid
  ```
  {: pre}

  Salida:
  ```
  Invocando 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. Vuelva a enlazar el servicio al clúster.
  ```
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## Después de actualizar o de volver cargar un nodo trabajador, aparecen nodos y pods duplicados
{: #cs_duplicate_nodes}

{: tsSymptoms}
Cuando ejecute `kubectl get nodes`, verá nodos trabajadores duplicados con el estado **NotReady**. Los nodos trabajadores con **NotReady** tienen direcciones IP públicas, mientras que los nodos trabajadores con **Ready** tienen direcciones IP privadas.

{: tsCauses}
Los nodos trabajadores de los clústeres antiguos aparecían listados por la dirección IP pública del clúster. Ahora los nodos trabajadores aparecen listados por la dirección IP privada del clúster. Cuando se vuelve a cargar o se actualiza un nodo, la dirección IP se modifica, pero la referencia a la dirección IP pública permanece.

{: tsResolve}
Estos duplicados no ocasionan interrupciones en el servicio, pero debe eliminar del servidor de API las referencias a nodos trabajadores antiguos.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />




## Los sistemas de archivos de los nodos trabajadores pasan a ser de sólo lectura
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Puede ver uno de los siguientes síntomas:
- Cuando ejecuta `kubectl get pods -o wide`, ve que varios pods que se están ejecutando en el mismo nodo trabajador quedan bloqueados en el estado `ContainerCreating`.
- Cuando se ejecuta un mandato `kubectl describe`, ve el siguiente error en la sección de sucesos: `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
El sistema de archivos del nodo trabajador es de sólo lectura.

{: tsResolve}
1. Haga una copia de seguridad de los datos que puedan estar almacenados en el nodo trabajador o en los contenedores.
2. Para un arreglo a corto plazo para el nodo trabajador existente, recargue el nodo trabajador.

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

Para un arreglo a largo plazo, [actualice el tipo de máquina añadiendo otro nodo trabajador](cs_cluster_update.html#machine_type).

<br />




## El acceso a un pod en un nodo trabajador nuevo falla con un tiempo de espera excedido
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Ha suprimido un nodo trabajador del clúster y luego ha añadido un nodo trabajador. Cuando se despliega un pod o un servicio de Kubernetes, el recurso no puede acceder al nodo trabajador recién creado y la conexión supera el tiempo de espera.

{: tsCauses}
Si suprime un nodo trabajador del clúster y luego añade un nodo trabajador, es posible que el nuevo nodo trabajador se asigne a la dirección IP privada del nodo trabajador suprimido. Calico utiliza esta dirección IP privada como código y sigue intentando acceder al nodo suprimido.

{: tsResolve}
Actualice manualmente la referencia a la dirección IP privada de modo que apunte al nodo correcto.

1.  Confirme que tiene dos nodos trabajadores con la misma dirección **IP privada**. Anote la **IP privada** y el **ID** del nodo trabajador suprimido.

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12    203.0.113.144    b2c.4x16       normal    Ready    dal10      1.8.8
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16    203.0.113.144    b2c.4x16       deleted    -       dal10      1.8.8
  ```
  {: screen}

2.  Instale la [CLI de Calico](cs_network_policy.html#adding_network_policies).
3.  Obtenga una lista de los nodos trabajadores disponibles en Calico. Sustituya <path_to_file> por la vía de acceso local al archivo de configuración de Calico.

  ```
  calicoctl get nodes --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Suprima el nodo trabajador duplicado en Calico. Sustituya NODE_ID por el ID del nodo trabajador.

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Rearranque el nodo trabajador que no se ha suprimido.

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


El nodo suprimido ya no aparece en Calico.

<br />


## El clúster permanece en un estado pendiente
{: #cs_cluster_pending}

{: tsSymptoms}
Al desplegar el clúster, se queda en estado pendiente y no se inicia.

{: tsCauses}
Si acaba de crear el clúster, es posible que los nodos trabajadores aún se estén configurando. Si ya ha esperado un rato, puede que tenga una VLAN no válida.

{: tsResolve}

Puede probar una de las siguientes soluciones:
  - Compruebe el estado del clúster ejecutando `bx cs clusters`. Luego, compruebe que los nodos trabajadores están desplegados ejecutando `bx cs workers <cluster_name>`.
  - Compruebe si la VLAN es válida. Para ser válida, una VLAN debe estar asociada con infraestructura que pueda alojar un trabajador con almacenamiento en disco local. Puede [ver una lista de las VLAN](/docs/containers/cs_cli_reference.html#cs_vlans) ejecutando `bx cs vlans LOCATION`; si la VLAN no se muestra en la lista, entonces no es válida. Elija una VLAN diferente.

<br />


## Los pods permanecen en estado pendiente
{: #cs_pods_pending}

{: tsSymptoms}
Cuando se ejecuta `kubectl get pods`, puede ver que los pods permanecen en el estado **Pending**.

{: tsCauses}
Si acaba de crear el clúster de Kubernetes, es posible que los nodos trabajadores aún se estén configurando. Si este clúster ya existe, es posible que no tenga suficiente capacidad en el clúster para desplegar el pod.

{: tsResolve}
Esta tarea precisa de la [política de acceso de administrador](cs_users.html#access_policies). Verifique su [política de acceso](cs_users.html#infra_access) actual.

Si acaba de crear el clúster de Kubernetes, ejecute el siguiente mandato y espere que se hayan inicializado los nodos trabajadores.

```
kubectl get nodes
```
{: pre}

Si este clúster ya existe, compruebe la capacidad del clúster.

1.  Establezca el proxy con el número de puerto predeterminado.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Abra el panel de control de Kubernetes.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Compruebe si tiene suficiente capacidad en el clúster para desplegar el pod.

4.  Si no tiene suficiente capacidad en el clúster, añada otro nodo trabajador al clúster.

  ```
  bx cs worker-add <nombre o id de clúster> 1
  ```
  {: pre}

5.  Si los pods continúan en estado **pending** después de que se despliegue por completo el nodo trabajador, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) para solucionar el estado pendiente del pod.

<br />




## Los contenedores no se inician
{: #containers_do_not_start}

{: tsSymptoms}
Los pods se despliegan correctamente en los clústeres, pero los contenedores no inician.

{: tsCauses}
Es posible que los contenedores no se inicien cuando se alcanza la cuota de registro.

{: tsResolve}
[Libere almacenamiento en {{site.data.keyword.registryshort_notm}}.](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />




## Los registros no aparecen
{: #cs_no_logs}

{: tsSymptoms}
Al acceder al panel de control de Kibana, los registros no se visualizan.

{: tsResolve}
Revise los siguientes motivos por los que no aparecen los registros y los pasos de resolución de problemas correspondientes:

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>Por qué está ocurriendo</th>
 <th>Cómo solucionarlo</th>
 </thead>
 <tbody>
 <tr>
 <td>No hay ninguna configuración de registro definida.</td>
 <td>Para que se envíen los registros, debe crear una configuración de registro para reenviar los registros a {{site.data.keyword.loganalysislong_notm}}. Para crear una configuración de registro, consulte <a href="cs_health.html#logging">Configuración del registro de clúster</a>.</td>
 </tr>
 <tr>
 <td>El clúster no se encuentra en estado <code>Normal</code>.</td>
 <td>Para comprobar el estado del clúster, consulte <a href="cs_troubleshoot.html#debug_clusters">Depuración de clústeres</a>.</td>
 </tr>
 <tr>
 <td>Se ha alcanzado el límite de almacenamiento de registro.</td>
 <td>Para aumentar los limites del almacenamiento de registros, consulte la documentación de <a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html">{{site.data.keyword.loganalysislong_notm}}</a>.</td>
 </tr>
 <tr>
 <td>Si ha especificado un espacio durante la creación del clúster, el propietario de la cuenta no tiene permisos de gestor, desarrollador o auditor para el espacio en cuestión.</td>
 <td>Para cambiar los permisos de acceso para el propietario de la cuenta:<ol><li>Para descubrir quién es el propietario de la cuenta del clúster, ejecute <code>bx cs api-key-info &lt;cluster_name_or_ID&gt;</code>.</li><li>Para otorgar a dicho propietario de cuenta permisos de acceso de {{site.data.keyword.containershort_notm}} de Gestor, Desarrollador o Auditor al espacio, consulte <a href="cs_users.html#managing">Gestión de acceso a clústeres</a>.</li><li>Para renovar la señal de registro tras cambiar los permisos, ejecute <code>bx cs logging-config-refresh &lt;cluster_name_or_ID&gt;</code>.</li></ol></td>
 </tr>
 </tbody></table>

Para probar los cambios que ha realizado durante la resolución de problemas, puede desplegar Noisy, un pod de muestra que produce varios sucesos de registro, en un nodo trabajador en el clúster.

  1. [Defina como objetivo de la CLI](cs_cli_install.html#cs_cli_configure) un clúster donde desee iniciar los registros de producción.

  2. Cree el archivo de configuración `deploy-noisy.yaml`.

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: noisy
      spec:
        containers:
        - name: noisy
          image: ubuntu:16.04
          command: ["/bin/sh"]
          args: ["-c", "while true; do sleep 10; echo 'Hello world!'; done"]
          imagePullPolicy: "Always"
        ```
        {: codeblock}

  3. Ejecute el archivo de configuración en el contexto del clúster.

        ```
        kubectl apply -f <filepath_to_noisy>
        ```
        {:pre}

  4. Después de unos minutos, verá los registros en el panel. Para acceder al panel de control de Kibana, vaya a uno de los siguientes URL y seleccione la cuenta de {{site.data.keyword.Bluemix_notm}} en la que ha creado el clúster. Si ha especificado un espacio durante la creación del clúster, vaya al espacio.
      - EE.UU. sur y EE.UU. este: https://logging.ng.bluemix.net
      - UK sur: https://logging.eu-gb.bluemix.net
      - UE central: https://logging.eu-fra.bluemix.net
      - AP Sur: https://logging.au-syd.bluemix.net

<br />




## El panel de control de Kubernetes no muestra los gráficos de utilización
{: #cs_dashboard_graphs}

{: tsSymptoms}
Al acceder al panel de control de Kubernetes, los gráficos de utilización no se visualizan.

{: tsCauses}
En ocasiones después de actualizar un clúster o reiniciar un nodo trabajador, el pod `kube-dashboard` no se actualiza.

{: tsResolve}
Suprima el pod `kube-dashboard` para forzar un reinicio. El pod se volverá a crear con políticas RBAC para acceder a Heapster para obtener información de utilización.

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## La adición de acceso de usuario no root al almacenamiento permanente no se realiza correctamente
{: #cs_storage_nonroot}

{: tsSymptoms}
Tras [añadir acceso de usuario no root al almacenamiento permanente](cs_storage.html#nonroot) o desplegar un diagrama de Helm con un ID de usuario no root especificado, el usuario no puede grabar en el almacenamiento montado.

{: tsCauses}
En la configuración del diagrama de Helm o el despliegue se especifica el [contexto de seguridad](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) para el ID de grupo (`fsGroup`) y el ID de usuario (`runAsUser`) del pod. Actualmente, {{site.data.keyword.containershort_notm}} no soporta la especificación de `fsGroup` y sólo soporta que `runAsUser` se establezca como `0` (permisos root).

{: tsResolve}
Elimine los campos `securityContext` de la configuración para `fsGroup` y `runAsUser` del archivo de configuración del diagrama de Helm, el despliegue o la imagen, y vuelva a desplegar. Si tiene que cambiar la propiedad de la vía de acceso de montaje de `nobody`, [añada acceso de usuario non-root](cs_storage.html#nonroot).

<br />


## No se puede conectar a una app mediante un servicio de equilibrador de carga.
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Ha expuesto a nivel público la app creando un servicio equilibrador de carga en el clúster. Cuando intenta conectar con la app a través de la dirección IP pública o equilibrador de carga, la conexión falla o supera el tiempo de espera.

{: tsCauses}
Posibles motivos por los que el servicio del equilibrador de carga no funciona correctamente:

-   El clúster es un clúster gratuito o un clúster estándar con un solo nodo trabajador.
-   El clúster todavía no se ha desplegado por completo.
-   El script de configuración correspondiente al servicio equilibrador de carga incluye errores.

{: tsResolve}
Para resolver el problema del servicio equilibrador de carga:

1.  Compruebe que ha configurado un clúster estándar que se ha desplegado por completo y que tiene al menos dos nodos trabajadores para garantizar la alta disponibilidad del servicio equilibrador de carga.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    En la salida de la CLI, asegúrese de que el **Estado** de los nodos trabajadores sea **Listo** y que el **Tipo de máquina** muestre un tipo de máquina que no sea **gratuito (free)**.

2.  Compruebe si el archivo de configuración correspondiente al servicio equilibrador de carga es preciso.

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myservice
  spec:
    type: LoadBalancer
    selector:
      <selectorkey>:<selectorvalue>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: pre}

    1.  Verifique que ha definido **LoadBalancer** como tipo de servicio.
    2.  Asegúrese de haber utilizado los mismos valores de **<selectorkey>** y **<selectorvalue>** que ha utilizado en la sección **label/metadata** cuando desplegó la app.
    3.  Compruebe que ha utilizado el **puerto** en el que escucha la app.

3.  Compruebe el servicio equilibrador de carga y revisar la sección de **Sucesos** para ver si hay errores.

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    Busque los siguientes mensajes de error:

    <ul><li><pre class="screen"><code>Los clústeres con un nodo deben utilizar servicios de tipo NodePort</code></pre></br>Para utilizar el servicio equilibrador de carga, debe tener un clúster estándar con al menos dos nodos trabajadores.</li>
    <li><pre class="screen"><code>No hay ninguna IP de proveedor de nube disponible para dar respuesta a la solicitud de servicio del equilibrador de carga. Añada una subred portátil al clúster y vuélvalo a intentar</code></pre></br>Este mensaje de error indica que no queda ninguna dirección IP pública portátil que se pueda asignar al servicio equilibrador de carga. Consulte la sección sobre <a href="cs_subnets.html#subnets">Adición de subredes a clústeres</a> para ver información sobre cómo solicitar direcciones IP públicas portátiles para el clúster. Cuando haya direcciones IP públicas portátiles disponibles para el clúster, el servicio equilibrador de carga se creará automáticamente.</li>
    <li><pre class="screen"><code>La IP de proveedor de nube solicitada <cloud-provider-ip> no está disponible. Están disponibles las siguientes IP de proveedor de nube: <available-cloud-provider-ips></code></pre></br>Ha definido una dirección IP pública portátil para el servicio equilibrador de carga mediante la sección **loadBalancerIP**, pero esta dirección IP pública portátil no está disponible en la subred pública portátil. Cambie el script de configuración del servicio equilibrador de carga y elija una de las direcciones IP públicas portátiles disponibles o elimine la sección **loadBalancerIP** del script para que la dirección IP pública portátil disponible se pueda asignar automáticamente.</li>
    <li><pre class="screen"><code>No hay nodos disponibles para el servicio equilibrador de carga</code></pre>No tiene suficientes nodos trabajadores para desplegar un servicio equilibrador de carga. Una razón posible es que ha desplegado un clúster estándar con más de un nodo trabajador, pero el suministro de los nodos trabajadores ha fallado.</li>
    <ol><li>Obtenga una lista de los nodos trabajadores disponibles.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>Si se encuentran al menos dos nodos trabajadores disponibles, obtenga una lista de los detalles de los nodos trabajadores.</br><pre class="codeblock"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li>Asegúrese de que los ID de las VLAN públicas y privadas correspondientes a los nodos trabajadores devueltos por los mandatos <code>kubectl get nodes</code> y <code>bx cs [&lt;cluster_name_or_id&gt;] worker-get</code> coinciden.</li></ol></li></ul>

4.  Si utiliza un dominio personalizado para conectar con el servicio equilibrador de carga, asegúrese de que el dominio personalizado está correlacionado con la dirección IP pública del servicio equilibrador de carga.
    1.  Busque la dirección IP pública del servicio equilibrador de carga.

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Compruebe que el dominio personalizado esté correlacionado con la dirección IP pública portátil del servicio equilibrador de carga en el registro de puntero
(PTR).

<br />


## No se puede conectar a una app mediante Ingress.
{: #cs_ingress_fails}

{: tsSymptoms}
Ha expuesto a nivel público la app creando un recurso de Ingress para la app en el clúster. Cuando intenta conectar con la app a través de la dirección IP pública o subdominio del equilibrador de carga de aplicación de Ingress, la conexión falla o supera el tiempo de espera.

{: tsCauses}
Posibles motivos por los que Ingress no funciona correctamente:
<ul><ul>
<li>El clúster todavía no se ha desplegado por completo.
<li>El clúster se ha configurado como un clúster gratuito o como un clúster estándar con un solo nodo trabajador.
<li>El script de configuración de Ingress incluye errores.
</ul></ul>

{: tsResolve}
Para resolver el problema de Ingress:

1.  Compruebe que ha configurado un clúster estándar que se ha desplegado por completo y que tiene al menos dos nodos trabajadores para garantizar la alta disponibilidad de su equilibrador de carga de aplicación de Ingress.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    En la salida de la CLI, asegúrese de que el **Estado** de los nodos trabajadores sea **Listo** y que el **Tipo de máquina** muestre un tipo de máquina que no sea **gratuito (free)**.

2.  Recupere el subdominio del equilibrador de carga de aplicación de Ingress y la dirección IP pública y luego ejecute ping sobre cada uno.

    1.  Recupere el subdominio del equilibrador de carga de aplicación.

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Ejecute ping sobre el subdominio del equilibrador de carga de aplicación de Ingress.

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Recupere la dirección IP pública del equilibrador de carga de aplicación de Ingress.

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Ejecute ping sobre la dirección IP pública del equilibrador de carga de aplicación de Ingress.

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Si la CLI devuelve un tiempo de espera para la dirección IP pública o subdominio del equilibrador de carga de aplicación de Ingress y ha configurado un cortafuegos personalizado que protege los nodos trabajadores, es posible que tenga que abrir puertos adicionales y grupos de redes en el [cortafuegos](#cs_firewall).

3.  Si utiliza un dominio personalizado, asegúrese de que el dominio personalizado está correlacionado con la dirección IP pública o subdominio del equilibrador de carga de aplicación de Ingress proporcionado por IBM con el proveedor del Servicio de nombres de dominio (DNS).
    1.  Si ha utilizado el subdominio del equilibrador de carga de aplicación de Ingress, compruebe el registro del nombre canónico (CNAME).
    2.  Si ha utilizado la dirección IP pública del equilibrador de carga de aplicación de Ingress, compruebe que el dominio personalizado esté correlacionado con la dirección IP pública portátil del registro de puntero
(PTR).
4.  Compruebe el archivo de configuración del recurso de Ingress.

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress_subdomain>
        secretName: <ingress_tlssecret>
      rules:
      - host: <ingress_subdomain>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  Compruebe que el subdominio del equilibrador de carga de aplicación de Ingress y el certificado TLS sean correctos. Para encontrar el subdominio proporcionado por IBM y el certificado TLS, ejecute `bx cs cluster-get <cluster_name_or_id>`.
    2.  Asegúrese de que su app está a la escucha en la misma vía de acceso que está configurada en la sección **path** de Ingress. Si la app se ha configurado para que escuche en la vía de acceso raíz, incluya **/** como vía de acceso.
5.  Compruebe el despliegue de Ingress y mire si hay algún mensaje de error o aviso.

    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    Por ejemplo, en la sección de **sucesos** de la salida, es posible que vea mensajes de aviso sobre valores no válidos en el recurso de Ingress o en determinadas anotaciones que haya utilizado.

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xx,169.xx.xxx.xx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  Compruebe los registros del equilibrador de carga de aplicación.
    1.  Recupere el ID de los pods de Ingress que se ejecutan en el clúster.

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Recuperar los registros correspondientes a cada pod de Ingress.

      ```
      kubectl logs <ingress_pod_id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  Mire si hay mensajes de error en los registros del equilibrador de carga de aplicación.

<br />



## Problemas con secretos del equilibrador de carga de aplicación de Ingress
{: #cs_albsecret_fails}

{: tsSymptoms}
Después de desplegar un secreto de equilibrador de carga de aplicación de Ingress al clúster, el campo `Descripción` no se actualiza con el nombre de secreto al visualizar el certificado en {{site.data.keyword.cloudcerts_full_notm}}.

Cuando lista información sobre el secreto del equilibrador de carga de aplicación, el estado indica `*_failed`. Por ejemplo, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Revise los motivos siguientes por los que puede fallar el secreto del equilibrador de carga de aplicación y los pasos de resolución de problemas correspondientes:

<table>
 <thead>
 <th>Por qué está ocurriendo</th>
 <th>Cómo solucionarlo</th>
 </thead>
 <tbody>
 <tr>
 <td>No dispone de los roles de acceso necesarios para descargar y actualizar los datos de certificado.</td>
 <td>Solicite al administrador de su cuenta que le asigne los roles de **Operador** y **Editor** para su instancia de {{site.data.keyword.cloudcerts_full_notm}}. Para obtener más detalles, consulte <a href="/docs/services/certificate-manager/about.html#identity-access-management">Identity and Access Management</a> para {{site.data.keyword.cloudcerts_short}}.</td>
 </tr>
 <tr>
 <td>El CRN de certificado proporcionado en el momento de la creación, actualización o eliminación no pertenece a la misma cuenta que el clúster.</td>
 <td>Compruebe que el CRN de certificado que ha proporcionado se haya importado a una instancia del servicio de {{site.data.keyword.cloudcerts_short}} en la misma cuenta que su clúster.</td>
 </tr>
 <tr>
 <td>El CRN de certificado proporcionado en el momento de la creación no es correcto.</td>
 <td><ol><li>Compruebe que la serie de CRN de certificado es correcta.</li><li>Si el CRN de certificado no es correcto, intente actualizar el secreto: <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Si el resultado de este mandato es <code>update_failed</code>, elimine el secreto: <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>Vuelva a desplegar el secreto: <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>El CRN de certificado proporcionado en el momento de la actualización no es correcto.</td>
 <td><ol><li>Compruebe que la serie de CRN de certificado es correcta.</li><li>Si el CRN de certificado no es correcto, elimine el secreto: <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>Vuelva a desplegar el secreto: <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Intente actualizar el secreto: <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>El servicio {{site.data.keyword.cloudcerts_long_notm}} está experimentando un tiempo de inactividad.</td>
 <td>Compruebe que el servicio {{site.data.keyword.cloudcerts_short}} esté activo y en ejecución.</td>
 </tr>
 </tbody></table>

<br />


## No se puede instalar un diagrama de Helm con valores de configuración actualizados
{: #cs_helm_install}

{: tsSymptoms}
Cuando intenta instalar un diagrama de Helm actualizado ejecutando `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>`, obtiene el mensaje de error `Error: failed to download "ibm/<chart_name>"`.

{: tsCauses}
El URL del repositorio de {{site.data.keyword.Bluemix_notm}} en la instancia de Helm podría ser incorrecto.

{: tsResolve}
Para resolver el problema del diagrama de Helm:

1. Obtenga una lista de los repositorios disponibles actualmente en la instancia de Helm.

    ```
    helm repo list
    ```
    {: pre}

2. En la salida, verifique que el URL del repositorio de {{site.data.keyword.Bluemix_notm}}, `ibm`, es `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Si el URL es incorrecto:

        1. Elimine el repositorio de {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Añada el repositorio de {{site.data.keyword.Bluemix_notm}} de nuevo.

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Si el URL es correcto, obtenga las últimas actualizaciones del repositorio.

        ```
        helm repo update
        ```
        {: pre}

3. Instale el diagrama de Helm con las actualizaciones.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## No se puede establecer la conectividad de VPN con el diagrama de Helm de strongSwan
{: #cs_vpn_fails}

{: tsSymptoms}
Cuando comprueba la conectividad de VPN ejecutando `kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status`, no ve el estado `ESTABLISHED`, o el pod de VPN está en estado `ERROR` o sigue bloqueándose y reiniciándose.

{: tsCauses}
El archivo de configuración del diagrama de Helm tiene valores incorrectos, errores de sintaxis o le faltan valores.

{: tsResolve}
Cuando intenta establecer la conectividad de VPN con el diagrama de Helm de strongSwan, es probable que el estado de VPN no sea `ESTABLISHED` la primera vez. Puede que necesite comprobar varios tipos de problema y cambiar el archivo de configuración en consonancia. Para resolver el problema de conectividad de VPN de strongSwan:

1. Compare los valores de punto final de VPN local con los valores del archivo de configuración. Si hay discrepancias:

    <ol>
    <li>Suprima el diagrama de Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija los valores incorrectos en el archivo <code>config.yaml</code> y guarde el archivo actualizado.</li>
    <li>Instale el nuevo diagrama de Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

2. Si el pod de VPN está en estado `ERROR` o sigue bloqueándose y reiniciándose, puede que se deba a la validación de parámetro de los valores de `ipsec.conf` en la correlación de configuración del diagrama.

    <ol>
    <li>Compruebe los errores de validación en los registros del pod de Strongswan.</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>Si hay errores de validación, suprima el diagrama de Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija los valores incorrectos en el archivo `config.yaml` y guarde el archivo actualizado.</li>
    <li>Instale el nuevo diagrama de Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

3. Ejecute las 5 pruebas de Helm incluidas en la definición del diagrama de strongSwan.

    <ol>
    <li>Ejecute las pruebas de Helm.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>Si falla alguna de las pruebas, consulte [Descripción de las pruebas de conectividad de VPN de Helm](cs_vpn.html#vpn_tests_table) para obtener información sobre cada prueba y por qué puede fallar. <b>Nota</b>: Algunas de las pruebas tienen requisitos que son valores opcionales en la configuración de VPN. Si alguna de las pruebas falla, los errores pueden ser aceptables en función de si ha especificado estos valores opcionales.</li>
    <li>Puede consultar la salida de una prueba que ha fallado en los registros del pod de prueba.<br><pre class="codeblock"><code>kubectl logs -n kube-system <test_program></code></pre></li>
    <li>Suprima el diagrama de Helm existente.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrija los valores incorrectos en el archivo <code>config.yaml</code> y guarde el archivo actualizado.</li>
    <li>Instale el nuevo diagrama de Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>Para comprobar los cambios:<ol><li>Obtenga los pods de prueba actuales.</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>Limpie los pods de prueba actuales.</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>Ejecute las pruebas de nuevo.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. Ejecute la herramienta de depuración de VPN incluida en el paquete de la imagen del pod de VPN.

    1. Establezca la variable de entorno `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Ejecute la herramienta de depuración.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        La herramienta genera varias páginas de información, ya que ejecuta varias pruebas para problemas comunes de red. Las líneas de la salida que empiezan por `ERROR`, `WARNING`, `VERIFY` o `CHECK` indican posibles errores con la conectividad de VPN.

    <br />


## La conectividad de VPN de strongSwan falla después de añadir o suprimir nodos trabajadores
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
Ha establecido previamente una conexión VPN activa utilizando el servicio VPN IPSec de strongSwan. Sin embargo, después de haber añadido o suprimido un nodo trabajador en el clúster, aparecen uno o varios de los siguientes síntomas:

* el estado de la VPN no es `ESTABLISHED`
* no se puede acceder a los nuevos nodos trabajadores desde la red local
* no se puede acceder a la red remota desde los pods que se ejecutan en los nuevos nodos trabajadores

{: tsCauses}
Si ha añadido un nodo trabajador:

* el nodo trabajador se ha suministrado en una nueva subred privada que no se expone a través de la conexión VPN existente mediante los valores `localSubnetNAT` o `local.subnet`
* Las rutas de VPN no pueden añadirse al nodo trabajador porque el trabajador tiene corrupciones o etiquetas que no están incluidas en los valores actuales de `tolerations` o `nodeSelector`
* el pod de VPN se ejecuta en el nodo trabajador nuevo, pero la dirección IP pública de dicho nodo trabajador no está permitida por el cortafuegos local

Si ha suprimido un nodo trabajador:

* ese nodo trabajador era el único nodo en el que se estaba ejecutando un pod de VPN, debido a las restricciones en algunas corrupciones o etiquetas en los valores existentes de `tolerations` o `nodeSelector`

{: tsResolve}
Actualice los valores de diagrama de Helm para reflejar los cambios del nodo trabajador:

1. Suprima el diagrama de Helm existente.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Abra el archivo de configuración para el servicio VPN de strongSwan.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Compruebe los valores siguientes y realice los cambios necesarios para reflejar los nodos añadidos o suprimidos.

    Si ha añadido un nodo trabajador:

    <table>
     <thead>
     <th>Valor</th>
     <th>Descripción</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>El nodo trabajador añadido puede estar desplegado en una subred privada nueva diferente a las demás subredes existentes en las que se encuentran otros nodos trabajadores. Si está utilizando NAT de subred para volver a correlacionar las direcciones IP locales privadas del clúster y el nodo trabajador se añade a una nueva subred, añada el CIDR de la nueva subred a este valor.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Si anteriormente ha limitado la ejecución del pod de VPN a los nodos trabajadores con una etiqueta específica y desea añadir rutas VPN al trabajador, asegúrese de que el nodo trabajador añadido tiene dicha etiqueta.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Si el nodo trabajador añadido tiene corrupciones, y desea añadir rutas de VPN al trabajador, cambie este valor para permitir que el pod de VPN se ejecute en todos los nodos trabajadores con corrupciones o en nodos trabajadores con corrupciones específicas.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>El nodo trabajador añadido puede estar desplegado en una subred privada nueva diferente a las demás subredes existentes en las que se encuentran otros nodos trabajadores. Si las apps están expuestas por los servicios NodePort o LoadBalancer en la red privada y están en un nodo trabajador nuevo que ha añadido, añada el CIDR de la nueva subred a este valor. **Nota**: Si añade valores a `local.subnet`, compruebe los valores de VPN para la subred local para ver si también deben actualizarse.</td>
     </tr>
     </tbody></table>

    Si ha suprimido un nodo trabajador:

    <table>
     <thead>
     <th>Valor</th>
     <th>Descripción</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Si está utilizando NAT de subred para volver a correlacionar direcciones IP locales privadas específicas, elimine las direcciones IP del nodo trabajador antiguo. Si está utilizando NAT de subred para volver a correlacionar subredes enteras y no quedan nodos trabajadores en una subred, elimine el CIDR de esa subred de este valor.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Si anteriormente ha limitado la ejecución del pod de VPN a un solo nodo trabajador y este ha sido suprimido, cambie este valor para permitir que el pod de VPN se ejecute en otros nodos trabajadores.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Si el nodo trabajador que ha suprimido no tenía corrupciones, pero los nodos que quedan sí tienen corrupciones, cambie este valor para permitir que el pod de VPN se ejecute en todos los nodos trabajadores con corrupciones o en nodos trabajadores con corrupciones específicas.
     </td>
     </tr>
     </tbody></table>

4. Instale el nuevo diagrama de Helm con los valores actualizados.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. Compruebe el estado de despliegue del diagrama. Cuando el diagrama está listo, el campo **STATUS**, situado cerca de la parte superior de la salida, tiene el valor `DEPLOYED`.

    ```
    helm status <release_name>
    ```
    {: pre}

6. En algunos casos, es posible que tenga que cambiar los valores locales y los valores del cortafuegos para que coincidan con los cambios realizados en el archivo de configuración de VPN.

7. Inicie la VPN.
    * Si el clúster inicia la conexión VPN (`ipsec.auto` se establece en `start`), inicie la VPN en la pasarela local y luego inicie la VPN en el clúster.
    * Si la pasarela local inicia la conexión VPN (`ipsec.auto` se establece en `auto`), inicie la VPN en el clúster y luego inicie la VPN en la pasarela local.

8. Establezca la variable de entorno `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Compruebe el estado de la VPN.

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Si la conexión VPN tiene el estado `ESTABLISHED`, la conexión VPN se ha realizado correctamente. No es necesario realizar ninguna otra acción.

    * Si sigue teniendo problemas de conexión, consulte [No se puede establecer la conectividad de VPN con el diagrama de Helm de strongSwan](#cs_vpn_fails) para solucionar más problemas de conexión VPN.

<br />


## No se puede recuperar el URL de ETCD para la configuración de la CLI de Calico.
{: #cs_calico_fails}

{: tsSymptoms}
Cuando recupere el `<ETCD_URL>` para [añadir políticas de red](cs_network_policy.html#adding_network_policies), obtiene un mensaje de error `calico-config not found`.

{: tsCauses}
El clúster no está en el nivel de [Kubernetes versión 1.7](cs_versions.html) o posterior.

{: tsResolve}
[Actualice el clúster](cs_cluster_update.html#master) o recupere el `<ETCD_URL>` con mandatos compatibles con versiones anteriores de Kubernetes.

Para recuperar el `<ETCD_URL>`, ejecute uno de los mandatos siguientes:

- Linux y OS X:

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows:
    <ol>
    <li> Obtenga una lista de los pods del espacio de nombres kube-system y localice el pod del controlador Calico. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Ejemplo:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> Consulte los detalles del pod del controlador Calico.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
    <li> Localice el valor de los puntos finales de ETCD. Ejemplo: <code>https://169.1.1.1:30001</code>
    </ol>

Cuando recupere el `<ETCD_URL>`, continúe con los pasos que figuran en (Adición de políticas de red) [cs_network_policy.html#adding_network_policies].

<br />




## Obtención de ayuda y soporte
{: #ts_getting_help}

¿Dónde comienzo a resolver problemas de un contenedor?
{: shortdesc}

-   Para ver si {{site.data.keyword.Bluemix_notm}} está disponible, [consulte la página de estado de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/support/#status).
-   Puede publicar una pregunta en [{{site.data.keyword.containershort_notm}} Slack. ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibm-container-service.slack.com) Consejo: si no utiliza un ID de IBM para la cuenta de {{site.data.keyword.Bluemix_notm}}, [solicite una invitación](https://bxcs-slack-invite.mybluemix.net/) a este Slack.
-   Revise los foros para ver si otros usuarios se han encontrado con el mismo problema. Cuando utiliza los foros para formular una pregunta, etiquete la pregunta para que la puedan ver los equipos de desarrollo de {{site.data.keyword.Bluemix_notm}}.

    -   Si tiene preguntas técnicas sobre el desarrollo o despliegue de clústeres o apps con {{site.data.keyword.containershort_notm}}, publique su pregunta en [Stack Overflow ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) y etiquete su pregunta con `ibm-cloud`, `kubernetes` y `containers`.
    -   Para las preguntas relativas a las instrucciones de inicio y el servicio, utilice el foro [IBM developerWorks dW Answers ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluya las etiquetas `ibm-cloud` y `containers`.
    Consulte [Obtención de ayuda](/docs/get-support/howtogetsupport.html#using-avatar) para obtener más detalles sobre cómo utilizar los foros.

-   Póngase en contacto con el servicio de soporte de IBM. Para obtener información sobre cómo abrir una incidencia de soporte de IBM, o sobre los niveles de soporte y las gravedades de las incidencias, consulte [Cómo contactar con el servicio de soporte](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Al informar de un problema, incluya el ID de clúster. Para obtener el ID de clúster, ejecute `bx cs clusters`.
