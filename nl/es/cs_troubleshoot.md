---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Depuración de clústeres
{: #cs_troubleshoot}

A medida que utiliza {{site.data.keyword.containerlong}}, considere estas técnicas para la resolución de problemas generales y la depuración de los clústeres. También puede consultar el [estado del sistema {{site.data.keyword.Bluemix_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/support/#status).
{: shortdesc}

Puede seguir estos pasos generales para asegurarse de que los clústeres están actualizados:
- Comprobar mensualmente la disponibilidad de parches de seguridad y del sistema operativo para [actualizar los nodos trabajadores](/docs/containers?topic=containers-cs_cli_reference#cs_worker_update).
- [Actualizar el clúster](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_update) a la última [versión predeterminada de Kubernetes](/docs/containers?topic=containers-cs_versions) para {{site.data.keyword.containerlong_notm}}

## Ejecución de pruebas con la herramienta de diagnósticos y de depuración de {{site.data.keyword.containerlong_notm}}
{: #debug_utility}

Cuando resuelva problemas, puede utilizar la herramienta de diagnósticos y de depuración de {{site.data.keyword.containerlong_notm}} para ejecutar pruebas y recopilar información pertinente del clúster. Para utilizar la herramienta de depuración, instale el diagrama de Helm [`ibmcloud-iks-debug` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/containers-kubernetes/solutions/helm-charts/ibm/ibmcloud-iks-debug):
{: shortdesc}


1. [Configure Helm en el clúster, cree una cuenta de servicio para Tiller y añada el repositorio `ibm` a la instancia de Helm](/docs/containers?topic=containers-integrations#helm).

2. Instale el diagrama de Helm en el clúster.
  ```
  helm install ibm/ibmcloud-iks-debug --name debug-tool
  ```
  {: pre}


3. Inicie un servidor proxy para visualizar la interfaz de la herramienta de depuración.
  ```
  kubectl proxy --port 8080
  ```
  {: pre}

4. En un navegador web, abra el URL de la interfaz de la herramienta de depuración: http://localhost:8080/api/v1/namespaces/default/services/debug-tool-ibmcloud-iks-debug:8822/proxy/page

5. Seleccione pruebas individuales o un grupo de pruebas para ejecutarlas. Algunas pruebas comprueban si hay posibles avisos, errores o problemas, y algunas pruebas solo recopilan información que puede consultar mientras resuelve problemas. Para obtener más información acerca de la función de cada prueba, pulse el icono de información situado junto al nombre de la prueba.

6. Pulse **Ejecutar**.

7. Compruebe los resultados de cada prueba.
  * Si falla alguna prueba, pulse en el icono de información situado junto al nombre de la prueba en la columna de la izquierda para obtener información sobre cómo resolver el problema.
  * También puede utilizar los resultados de las pruebas para recopilar información, como por ejemplo archivos YAML completos, que pueden ayudarle a depurar el clúster en las secciones siguientes.

## Depuración de clústeres
{: #debug_clusters}

Revise las opciones para depurar sus clústeres y encontrar las causas raíz de los errores.

1.  Obtenga una lista con su clúster y busque el `Estado` del clúster.

  ```
  ibmcloud ks clusters
  ```
  {: pre}

2.  Revise el `Estado` de su clúster. Si el clúster está en estado **Crítico**, **Error al suprimir** o **Aviso**, o se ha bloqueado en el estado **Pendiente** durante mucho tiempo, inicie la [depuración de los nodos trabajadores](#debug_worker_nodes).

    <table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
<caption>Estados de clúster</caption>
   <thead>
   <th>Estado del clúster</th>
   <th>Descripción</th>
   </thead>
   <tbody>
<tr>
   <td>Terminado anormalmente</td>
   <td>El usuario ha solicitado la supresión del clúster antes de desplegar el maestro de Kubernetes. Una vez realizada la supresión del clúster, el clúster se elimina del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
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
     <td>El clúster se ha suprimido pero todavía no se ha eliminado del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Suprimiendo</td>
   <td>El clúster se está suprimiendo y la infraestructura del clúster se está desmontando. No puede acceder al clúster.  </td>
   </tr>
   <tr>
     <td>Error al desplegar</td>
     <td>El despliegue del maestro de Kubernetes no se ha podido realizar. No puede resolver este estado. Póngase en contacto con el equipo de soporte de IBM Cloud abriendo un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Despliegue</td>
       <td>El maestro de Kubernetes no está completamente desplegado. No puede acceder a su clúster. Espere hasta que el clúster se haya desplegado por completo para revisar el estado del clúster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster. Este estado se considera correcto y no requiere ninguna acción por su parte.<p class="note">Aunque los nodos trabajadores podrían poseer un estado normal, otros recursos de infraestructura como, por ejemplo la [red](/docs/containers?topic=containers-cs_troubleshoot_network) y el [almacenamiento](/docs/containers?topic=containers-cs_troubleshoot_storage), podrían requerir su atención.</p></td>
    </tr>
      <tr>
       <td>Pendiente</td>
       <td>El maestro de Kubernetes está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.  </td>
     </tr>
   <tr>
     <td>Solicitado</td>
     <td>Se ha enviado una solicitud para crear el clúster y pedir la infraestructura para el maestro de Kubernetes y los nodos trabajadores. Cuando se inicia el despliegue del clúster, el estado del clúster cambia a <code>Desplegando</code>. Si el clúster está bloqueado en el estado <code>Solicitado</code> durante mucho tiempo, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
     <td>Actualizando</td>
     <td>El servidor de API de Kubernetes que se ejecuta en el maestro de Kubernetes está siendo actualizado a una versión nueva de API de Kubernetes. Durante la actualización, no puede acceder ni cambiar el clúster. Los nodos trabajadores, apps y recursos que el usuario despliega no se modifican y continúan en ejecución. Espere a que la actualización se complete para revisar el estado del clúster. </td>
   </tr>
    <tr>
       <td>Aviso</td>
       <td>Al menos un nodo trabajador del clúster no está disponible, pero los otros nodos trabajadores están disponibles y pueden asumir la carga de trabajo. </td>
    </tr>
   </tbody>
 </table>


El [nodo maestro de Kubernetes](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture) es el componente principal que mantiene el clúster en funcionamiento. El nodo maestro almacena los recursos de clúster y sus configuraciones en la base de datos etcd, que sirve como único punto fiable para el clúster. El servidor de API de Kubernetes es el punto de entrada principal para todas las solicitudes de gestión del clúster procedentes de los nodos trabajadores destinadas al nodo maestro, o cuando desea interactuar con los recursos de clúster.<br><br>Si se produce un fallo del nodo maestro, las cargas de trabajo siguen ejecutándose en los nodos trabajadores, pero no se pueden utilizar mandatos `kubectl` para trabajar con los recursos del clúster o ver el estado del clúster hasta que el servidor de API de Kubernetes del nodo maestro vuelve a estar activo. Si un pod cae durante la interrupción del nodo maestro, el pod no se puede volver a planificar hasta que el nodo trabajador pueda volver a acceder al servidor de API de Kubernetes.<br><br>Durante una interrupción del nodo maestro, todavía puede ejecutar mandatos `ibmcloud ks` en la API de {{site.data.keyword.containerlong_notm}} para trabajar con los recursos de la infraestructura, como nodos trabajadores o VLAN. Si cambia la configuración actual del clúster añadiendo o eliminando nodos trabajadores en el clúster, los cambios no se producen hasta que el nodo maestro vuelve a estar activo.

No reinicie o rearranque un nodo trabajador durante una interrupción del nodo maestro. Esta acción elimina los pods del nodo trabajador. Puesto que el servidor de API de Kubernetes no está disponible, los pods no se pueden volver a programar en otros nodos trabajadores del clúster.
{: important}


<br />


## Depuración de nodos trabajadores
{: #debug_worker_nodes}

Revise las opciones para depurar sus nodos trabajadores y encontrar las causas raíz de los errores.


1.  Si el clúster está en estado **Crítico**, **Error al suprimir** o **Aviso**, o se ha bloqueado en el estado **Pendiente** durante mucho tiempo, revise el estado de los nodos trabajadores.

  ```
  ibmcloud ks workers --cluster <cluster_name_or_id>
  ```
  {: pre}

2.  Revise los campos `State` y `Status` de cada nodo trabajador en la salida de la CLI.

  <table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
  <caption>Estados de nodo trabajador</caption>
    <thead>
    <th>Estado del nodo trabajador</th>
    <th>Descripción</th>
    </thead>
    <tbody>
  <tr>
      <td>Crítico</td>
      <td>Un nodo trabajador puede entrar en estado Crítico por muchas razones: <ul><li>Rearrancar el nodo trabajador sin acordonarlo ni drenarlo. Rearrancar un nodo trabajador puede provocar que se corrompan los datos en <code>containerd</code>, <code>kubelet</code>, <code>kube-proxy</code> y <code>calico</code>. </li>
      <li>Los pods que se despliegan en el nodo trabajador no utilizan límites de recursos para [memoria ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) y [CPU ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Sin límites de recursos, los pods pueden consumir todos los recursos disponibles y no dejar recursos para que se ejecuten otros pods en este nodo trabajador. Esta sobrecarga de trabajo provoca que el nodo trabajador falle. </li>
      <li><code>containerd</code>, <code>kubelet</code> o <code>calico</code> entraron en un estado irrecuperable después de ejecutar cientos o miles de contenedores a lo largo del tiempo. </li>
      <li>Tener configurado un Virtual Router Appliance para el nodo trabajador que se quede inactivo y se interrumpa así la comunicación entre el nodo trabajador y el maestro de Kubernetes. </li><li> Problemas de red en {{site.data.keyword.containerlong_notm}} o en la infraestructura de IBM Cloud (SoftLayer) que provoquen que falle la comunicación entre el nodo trabajador y el maestro de Kubernetes.</li>
      <li>Que el nodo trabajador agote su capacidad. Compruebe el campo <strong>Status</strong> del nodo trabajador para ver si es <strong>Out of disk</strong> u <strong>Out of memory</strong>. Si el nodo trabajador se ha quedado sin capacidad, considere reducir la carga de trabajo del nodo trabajador o añadir un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</li>
      <li>El dispositivo se ha apagado desde la [lista de recursos de la consola de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/resources). Abra la lista de recursos y busque el ID de nodo trabajador en la lista **Dispositivos**. En el menú de acciones, pulse **Encender**.</li></ul>
      En muchos casos, el problema se resuelve al [recargar](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload) el nodo trabajador. Cuando recarga su nodo trabajador, se aplica la última [versión de parche](/docs/containers?topic=containers-cs_versions#version_types) al nodo trabajador. La versión mayor y la versión menor no cambian. Antes de recargar el nodo trabajador, acordone y drene el nodo trabajador para que los pods existentes finalicen correctamente y se vuelvan a programar en los demás nodos trabajadores. </br></br> Si la recarga del nodo trabajador no resuelve el problema, vaya al siguiente paso para continuar la resolución de problemas del nodo trabajador. </br></br><strong>Sugerencia:</strong> Puede [configurar comprobaciones de estado del nodo trabajador y habilitar la recuperación automática](/docs/containers?topic=containers-health#autorecovery). Si la recuperación automática detecta un nodo trabajador erróneo basado en las comprobaciones configuradas, desencadena una acción correctiva, como una recarga del sistema operativo, en el nodo trabajador. Para obtener más información sobre cómo funciona la recuperación automática, consulte el [blog sobre recuperación automática ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
      </td>
     </tr>
     <tr>
     <td>Desplegado</td>
     <td>Las actualizaciones se han desplegado correctamente en el nodo trabajador. Después de desplegar las actualizaciones, {{site.data.keyword.containerlong_notm}} inicia una comprobación de estado en el nodo trabajador. Después de que la comprobación de estado sea correcta, el nodo trabajador pasa a un estado <code>Normal</code>. Los nodos de trabajador con un estado <code>Desplegado</code> normalmente están preparados para recibir cargas de trabajo, lo que puede comprobar ejecutando <code>kubectl get nodes</code> y confirmando que el estado es <code>Normal</code>. </td>
     </tr>
      <tr>
        <td>Despliegue</td>
        <td>Cuando se actualiza la versión de Kubernetes del nodo trabajador, el nodo trabajador se vuelve a desplegar para instalar las actualizaciones. Si vuelve a cargar o rearrancar el nodo trabajador, el nodo trabajador se vuelve a desplegar para instalar automáticamente la última versión del parche. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo, continúe en el paso siguiente para ver si se ha producido un problema durante la recarga. </td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>El nodo trabajador se ha suministrado por completo y está listo para ser utilizado en el clúster. Este estado se considera correcto y no requiere ninguna acción por parte del usuario. **Nota**: Aunque los nodos trabajadores podrían poseer un estado normal, otros recursos de infraestructura como, por ejemplo la [red](/docs/containers?topic=containers-cs_troubleshoot_network) y el [almacenamiento](/docs/containers?topic=containers-cs_troubleshoot_storage), podrían requerir su atención.</td>
     </tr>
   <tr>
        <td>Suministro</td>
        <td>El nodo trabajador se está suministrando y aún no está disponible en el clúster. Puede supervisar el proceso de suministro en la columna <strong>Estado</strong> de la salida de la CLI. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo, continúe en el paso siguiente para ver si se ha producido un problema durante el suministro.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>El nodo trabajador no se ha podido suministrar. Continúe en el paso siguiente para ver los detalles del error.</td>
      </tr>
   <tr>
        <td>Recarga</td>
        <td>El nodo trabajador se está recargando y no está disponible en el clúster. Puede supervisar el proceso de recarga en la columna <strong>Estado</strong> de la salida de la CLI. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo, continúe en el paso siguiente para ver si se ha producido un problema durante la recarga.</td>
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
       <td>No se puede acceder al maestro de Kubernetes por uno de estos motivos:<ul><li>Ha solicitado una actualización del maestro de Kubernetes. El estado del nodo trabajador no se puede recuperar durante la actualización. Si el nodo trabajador sigue en este estado durante un periodo de tiempo prolongado incluso después de que se haya actualizado correctamente el maestro de Kubernetes, intente [recargar](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload) el nodo trabajador.</li><li>Es posible que tenga otro cortafuegos que está protegiendo sus nodos trabajadores o que haya modificado los valores del cortafuegos recientemente. {{site.data.keyword.containerlong_notm}} requiere que determinadas direcciones IP y puertos estén abiertos para permitir la comunicación entre el nodo trabajador y el maestro de Kubernetes y viceversa. Para obtener más información, consulte [El cortafuegos impide que los nodos trabajadores se conecten](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_firewall).</li><li>El maestro de Kubernetes está inactivo. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](#ts_getting_help).</li></ul></td>
  </tr>
     <tr>
        <td>Aviso</td>
        <td>El nodo trabajador está a punto de alcanzar el límite de memoria o de espacio de disco. Puede reducir la carga de trabajo del nodo trabajador o añadir un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</td>
  </tr>
    </tbody>
  </table>

5.  Obtener los detalles del nodo trabajador. Si en los detalles se incluye un mensaje de error, revise la lista de [mensajes de error comunes para nodos trabajadores](#common_worker_nodes_issues) para saber cómo resolver el problema.
  ```
  ibmcloud ks worker-get --cluster <cluster_name_or_id> --worker <worker_node_id>
  ```
  {: pre}

<br />


## Problemas comunes con los nodos trabajadores
{: #common_worker_nodes_issues}

Revise los mensajes de error comunes y busque cómo resolverlos.

  <table>
  <caption>Mensajes de error comunes</caption>
    <thead>
    <th>Mensaje de error</th>
    <th>Descripción y resolución
    </thead>
    <tbody>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: En este momento su cuenta no tiene permitido solicitar 'Instancias de cálculo'.</td>
        <td>Puede que su cuenta de infraestructura de IBM Cloud (SoftLayer) tenga restringida la solicitud de recursos de cálculo. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra un [caso de soporte de {{site.data.keyword.Bluemix_notm}}](#ts_getting_help).</td>
      </tr>
      <tr>
      <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: No se ha podido realizar el pedido.<br><br>
      Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: No se ha podido realizar el pedido. No hay suficientes recursos tras el direccionador 'router_name' para realizar la solicitud para los siguientes invitados: 'worker_id'.</td>
      <td>Es posible que la zona que ha seleccionado no tenga suficiente capacidad de infraestructura para suministrar los nodos trabajadores. O bien, es posible que haya excedido un límite en la cuenta de infraestructura de IBM Cloud (SoftLayer). Para resolverlo, intente una de las opciones siguientes:
      <ul><li>La disponibilidad de recursos de infraestructura en las zonas puede variar con frecuencia. Espere unos minutos y vuelva a intentarlo.</li>
      <li>Para un clúster de una sola zona, cree el clúster en otra zona. Para un clúster multizona, añada una zona al clúster.</li>
      <li>Especifique un par distinto de VLAN pública y privada para los nodos trabajadores en la cuenta de infraestructura de IBM Cloud (SoftLayer). Para los nodos trabajadores que están en una agrupación de trabajadores, puede utilizar el [mandato](/docs/containers?topic=containers-cs_cli_reference#cs_zone_network_set) <code>ibmcloud ks zone-network-set</code>.</li>
      <li>Póngase en contacto con el gestor de cuentas de infraestructura de IBM Cloud (SoftLayer) para verificar que no supera un límite de cuenta, como por ejemplo una cuota global.</li>
      <li>Abra un [caso de soporte de infraestructura de IBM Cloud (SoftLayer)](#ts_getting_help)</li></ul></td>
      </tr>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: No se ha podido obtener la VLAN de red con el ID: <code>&lt;vlan id&gt;</code>.</td>
        <td>El nodo trabajador no se ha podido suministrar porque no se ha encontrado el ID de VLAN por una de las siguientes razones:<ul><li>Puede que haya especificado el número de VLAN en lugar del ID de VLAN. El número de VLAN tiene 3 ó 4 dígitos, mientras que el ID de VLAN tiene 7 dígitos. Ejecute <code>ibmcloud ks vlans --zone &lt;zone&gt;</code> para recuperar el ID de VLAN.<li>Es posible que el ID de VLAN no esté asociado a la cuenta de infraestructura de IBM Cloud (SoftLayer) que está utilizando. Ejecute <code>ibmcloud ks vlans --zone &lt;zone&gt;</code> para ver una lista de los ID de VLAN disponibles para la cuenta. Para cambiar la cuenta de infraestructura de IBM Cloud (SoftLayer), consulte [`ibmcloud ks credential-set`](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: La ubicación suministrada para este pedido no es válida. (HTTP 500)</td>
        <td>Su cuenta de infraestructura de IBM Cloud (SoftLayer) no está configurada para solicitar recursos de cálculo en el centro de datos seleccionado. Póngase en contacto con el [equipo de soporte de {{site.data.keyword.Bluemix_notm}}](#ts_getting_help) para comprobar que la cuenta está correctamente configurada.</td>
       </tr>
       <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El usuario no tiene los permisos necesarios de la infraestructura de {{site.data.keyword.Bluemix_notm}} para añadir servidores
        </br></br>
        Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El elemento 'Item' se debe solicitar con permiso.
        </br></br>
        No se han podido validar las credenciales de infraestructura de {{site.data.keyword.Bluemix_notm}}.</td>
        <td>Es posible que no tenga los permisos necesarios para realizar la acción en el portafolio de infraestructura de IBM Cloud (SoftLayer) o que esté utilizando las credenciales de infraestructura erróneas. Consulte [Configuración de la clave de API para habilitar el acceso al portafolio de la infraestructura](/docs/containers?topic=containers-users#api_key).</td>
      </tr>
      <tr>
       <td>El trabajador no se puede comunicar con los servidores de {{site.data.keyword.containerlong_notm}}. Verifique que la configuración del cortafuegos permite el tráfico de este trabajador.
       <td><ul><li>Si tiene un cortafuegos, [configure los valores de cortafuegos para permitir el tráfico saliente a los puertos y direcciones IP adecuados](/docs/containers?topic=containers-firewall#firewall_outbound).</li>
       <li>Compruebe si el clúster no tiene una IP pública ejecutando `ibmcloud ks workers --cluster &lt;mycluster&gt;`. Si no se lista una IP pública, entonces su clúster solo tiene VLAN privadas.
       <ul><li>Si desea que el clúster sólo tenga VLAN privadas, configure la [conexión de VLAN](/docs/containers?topic=containers-plan_clusters#private_clusters) y el [cortafuegos](/docs/containers?topic=containers-firewall#firewall_outbound).</li>
       <li>Si desea que el clúster tenga una IP pública, [añada nuevos nodos trabajadores](/docs/containers?topic=containers-cs_cli_reference#cs_worker_add) con VLAN públicas y privadas.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>No se puede crear la señal de portal de IMS, ya que ninguna cuenta de IMS está enlazada con la cuenta de BSS seleccionada</br></br>El usuario proporcionado no se ha encontrado o está activo</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus: La cuenta del usuario está actualmente en estado cancel_pending.</br></br>Esperando que la máquina se haga visible para el usuario</td>
  <td>El propietario de la clave de API que se utiliza para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer) no tiene los permisos necesarios para realizar la acción o puede estar pendiente de supresión.</br></br><strong>Como usuario</strong>, siga estos pasos:
  <ol><li>Si tiene acceso a varias cuentas, asegúrese de que ha iniciado la sesión en la cuenta en la que desea trabajar con {{site.data.keyword.containerlong_notm}}. </li>
  <li>Ejecute <code>ibmcloud ks api-key-info</code> para ver el propietario de la clave de API actual que se utiliza para acceder al portafolio de infraestructura de IBM Cloud (SoftLayer) próximo. </li>
  <li>Ejecute <code>ibmcloud account list</code> para ver el propietario de la cuenta de {{site.data.keyword.Bluemix_notm}} que utiliza actualmente. </li>
  <li>Póngase en contacto con el propietario de la cuenta de {{site.data.keyword.Bluemix_notm}} e infórmele de que el propietario de la clave de API tiene permisos insuficientes en la infraestructura de IBM Cloud (SoftLayer) o puede estar pendiente de supresión. </li></ol>
  </br><strong>Como propietario de cuenta</strong>, siga estos pasos:
  <ol><li>Revise los [permisos necesarios en la infraestructura de IBM Cloud (SoftLayer)](/docs/containers?topic=containers-users#infra_access) para realizar la acción que ha fallado anteriormente. </li>
  <li>Corrija los permisos del propietario de la clave de API o cree una nueva clave de API mediante el mandato [<code>ibmcloud ks api-key-reset</code>](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_reset). </li>
  <li>Si usted u otro administrador de la cuenta define manualmente las credenciales de la infraestructura de IBM Cloud (SoftLayer) en la cuenta, ejecute [<code>ibmcloud ks credential-unset</code>](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_unset) para eliminar las credenciales de la cuenta.</li></ol></td>
  </tr>
    </tbody>
  </table>



<br />




## Depuración de despliegues de app
{: #debug_apps}

Revise las opciones que tiene para depurar sus despliegues de app y busque las causas raíz de los errores.

Antes de empezar, asegúrese de que tiene el [rol de **Escritor** o de **Gestor** del servicio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform) sobre el espacio de nombres en el que se ha desplegado la app.

1. Busque anomalías en el servicio o en los recursos de despliegue mediante el mandato `describe`.

 Ejemplo:
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [Compruebe si los contenedores están bloqueados en el estado `ContainerCreating`](/docs/containers?topic=containers-cs_troubleshoot_storage#stuck_creating_state).

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
   3. Ejecute curl sobre la dirección IP del clúster y el puerto del servicio. Si no se puede acceder a la dirección IP y al puerto, mire los puntos finales correspondientes al servicio. Si no se listan puntos finales, el selector del servicio no coincide con los pods. Si se listan puntos finales, mire el campo del puerto de destino en el servicio y asegúrese de que el puerto de destino es el mismo que el que se utiliza para los pods.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Para servicios Ingress, verifique que se puede acceder al servicio desde dentro del clúster.
   1. Obtenga el nombre de un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Inicie una sesión en un contenedor.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Ejecute curl sobre el URL especificado para el servicio Ingress. Si no se puede acceder al URL, compruebe si hay un problema de cortafuegos entre el clúster y el punto final externo. 
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />



## Obtención de ayuda y soporte
{: #ts_getting_help}

¿Sigue teniendo problemas con su clúster?
{: shortdesc}

-  En el terminal, se le notifica cuando están disponibles las actualizaciones de la CLI y los plugins de `ibmcloud`. Asegúrese de mantener actualizada la CLI para poder utilizar todos los mandatos y distintivos disponibles.
-   Para ver si {{site.data.keyword.Bluemix_notm}} está disponible, [consulte la página de estado de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/status?selected=status).
-   Publique una pregunta en [Slack de {{site.data.keyword.containerlong_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibm-container-service.slack.com).
    Si no utiliza un ID de IBM para la cuenta de {{site.data.keyword.Bluemix_notm}}, [solicite una invitación](https://bxcs-slack-invite.mybluemix.net/) a este Slack.
    {: tip}
-   Revise los foros para ver si otros usuarios se han encontrado con el mismo problema. Cuando utiliza los foros para formular una pregunta, etiquete la pregunta para que la puedan ver los equipos de desarrollo de {{site.data.keyword.Bluemix_notm}}.
    -   Si tiene preguntas técnicas sobre el desarrollo o despliegue de clústeres o apps con {{site.data.keyword.containerlong_notm}}, publique su pregunta en [Stack Overflow ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) y etiquete su pregunta con `ibm-cloud`, `kubernetes` y `containers`.
    -   Para formular preguntas sobre el servicio y obtener instrucciones de iniciación, utilice el foro [IBM Developer Answers ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluya las etiquetas `ibm-cloud` y `containers`.
    Consulte [Obtención de ayuda](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) para obtener más detalles sobre cómo utilizar los foros.
-   Póngase en contacto con el soporte de IBM abriendo un caso. Para obtener información sobre cómo abrir un caso de soporte de IBM, o sobre los niveles de soporte y las gravedades de los casos, consulte [Cómo contactar con el servicio de soporte](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support).
Al informar de un problema, incluya el ID de clúster. Para obtener el ID de clúster, ejecute `ibmcloud ks clusters`. También puede utilizar la [herramienta de diagnósticos y de depuración de {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) para recopilar y exportar la información pertinente del clúster que se va a compartir con el servicio de soporte de IBM.
{: tip}

