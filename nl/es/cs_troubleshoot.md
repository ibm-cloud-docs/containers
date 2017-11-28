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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Resolución de problemas de clústeres
{: #cs_troubleshoot}

Si utiliza {{site.data.keyword.containershort_notm}}, tenga en cuenta estas técnicas para solucionar problemas y obtener ayuda. También puede consultar el [estado del sistema {{site.data.keyword.Bluemix_notm}}![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/support/#status).

Puede seguir algunos pasos generales para asegurarse de que los clústeres están actualizados:
- [Rearranque los nodos trabajadores](cs_cli_reference.html#cs_worker_reboot) de forma regular para garantizar la instalación de actualizaciones y parches de seguridad que IBM despliega automáticamente en el sistema operativo
- Actualice el clúster para [la versión predeterminada más reciente de Kubernetes](cs_versions.html) para {{site.data.keyword.containershort_notm}}

{: shortdesc}

<br />


## Depuración de clústeres
{: #debug_clusters}

Revise las opciones para depurar sus clústeres y encontrar las causas raíz de los errores.

1.  Obtenga una lista con su clúster y busque el `Estado` del clúster.

  ```
  bx cs clusters
  ```
  {: pre}

2.  Revise el `Estado` de su clúster.

  <table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
    <thead>
    <th>Estado del clúster</th>
    <th>Descripción</th>
    </thead>
    <tbody>
      <tr>
        <td>Despliegue</td>
        <td>El nodo Kubernetes maestro no está completamente desplegado. No puede acceder a su clúster.</td>
       </tr>
       <tr>
        <td>Pendiente</td>
        <td>El nodo Kubernetes maestro está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster.</td>
     </tr>
     <tr>
        <td>Aviso</td>
        <td>Al menos un nodo trabajador del clúster no está disponible, pero los otros nodos trabajadores están disponibles y pueden asumir la carga de trabajo.</td>
     </tr>
     <tr>
      <td>Crítico</td>
      <td>No se puede acceder al nodo Kubernetes maestro o todos los nodos trabajadores del clúster están inactivos.</td>
     </tr>
    </tbody>
  </table>

3.  Si el clúster está en estado **Aviso** o **Crítico**, o se ha bloqueado en el estado **Pendiente** durante mucho tiempo, revise el estado de los nodos trabajadores. Si el clúster está en estado **Despliegue**, espere hasta que el clúster se haya desplegado por completo para revisar el estado del clúster. Se considera que los clústeres en estado **Normal** están en buen estado y no requieren ninguna acción en este momento.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

  <table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
    <thead>
    <th>Estado del nodo trabajador</th>
    <th>Descripción</th>
    </thead>
    <tbody>
      <tr>
       <td>Desconocido</td>
       <td>No se puede acceder al nodo Kubernetes maestro por uno de estos motivos:<ul><li>Ha solicitado una actualización del nodo Kubernetes maestro. El estado del nodo trabajador no se puede recuperar durante la actualización.</li><li>Es posible que tenga un cortafuegos adicional que está protegiendo sus nodos trabajadores o que haya modificado los valores del cortafuegos recientemente. {{site.data.keyword.containershort_notm}} requiere que determinadas direcciones IP y puertos estén abiertos para permitir la comunicación entre el nodo trabajador y el nodo Kubernetes maestro y viceversa. Para obtener más información, consulte [Los nodos de trabajo están bloqueados en un bucle de recarga](#cs_firewall).</li><li>El nodo Kubernetes maestro está inactivo. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ul></td>
      </tr>
      <tr>
        <td>Suministro</td>
        <td>El nodo trabajador se está suministrando y aún no está disponible en el clúster. Puede supervisar el proceso de suministro en la columna **Estado** de la salida de la CLI. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo y no ve ningún progreso en la columna **Estado**, continúe en el paso siguiente para ver si se ha producido un problema durante el suministro.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>El nodo trabajador no se ha podido suministrar. Continúe en el paso siguiente para ver los detalles del error.</td>
      </tr>
      <tr>
        <td>Recarga</td>
        <td>El nodo trabajador se está recargando y no está disponible en el clúster. Puede supervisar el proceso de recarga en la columna **Estado** de la salida de la CLI. Si el nodo trabajador queda bloqueado en este estado durante mucho tiempo y no ve ningún progreso en la columna **Estado**, continúe en el paso siguiente para ver si se ha producido un problema durante la recarga.</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>El nodo trabajador no se ha podido recargar. Continúe en el paso siguiente para ver los detalles del error.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>El nodo trabajador se ha suministrado por completo y está listo para ser utilizado en el clúster.</td>
     </tr>
     <tr>
        <td>Aviso</td>
        <td>El nodo trabajador está a punto de alcanzar el límite de memoria o de espacio de disco.</td>
     </tr>
     <tr>
      <td>Crítico</td>
      <td>El nodo trabajador se ha quedado sin espacio de disco.</td>
     </tr>
    </tbody>
  </table>

4.  Obtener los detalles del nodo trabajador.

  ```
  bx cs worker-get <worker_node_id>
  ```
  {: pre}

5.  Revise los mensajes de error comunes y busque cómo resolverlos.

  <table>
    <thead>
    <th>Mensaje de error</th>
    <th>Descripción y resolución
    </thead>
    <tbody>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: En este momento su cuenta no tiene permitido solicitar 'Instancias de cálculo'.</td>
        <td>Puede que su cuenta de IBM Bluemix Infrastructure (SoftLayer) tenga restringida la solicitud de recursos de cálculo. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</td>
      </tr>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: No se ha podido realizar el pedido. No hay suficientes recursos tras el direccionador 'router_name' para realizar la solicitud para los siguientes invitados: 'worker_id'.</td>
        <td>La VLAN que ha seleccionado está asociada a un pod del centro de datos que no tiene suficiente espacio para suministrar el nodo trabajador. Puede elegir entre las opciones siguientes:<ul><li>Utilice otro centro de datos para suministrar el nodo trabajador. Ejecute <code>bx cs locations</code> para ver una lista de los centros de datos disponibles.<li>Si tiene un par existente de VLAN pública y privada asociado a otro pod del centro de datos, utilice este par de VLAN.<li>Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</ul></td>
      </tr>
      <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: No se ha podido obtener la VLAN de red con el id: &lt;vlan id&gt;.</td>
        <td>El nodo de trabajador no se ha podido suministrar porque no se ha encontrado el ID de VLAN por una de las siguientes razones:<ul><li>Puede que haya especificado el número de VLAN en lugar del ID de VLAN. El número de VLAN tiene 3 ó 4 dígitos, mientras que el ID de VLAN tiene 7 dígitos. Ejecute <code>bx cs vlans &lt;location&gt;</code> para recuperar el ID de VLAN.<li>Es posible que el ID de VLAN no esté asociado a la cuenta de IBM Bluemix Infrastructure (SoftLayer) que está utilizando. Ejecute <code>bx cs vlans &lt;location&gt;</code> ver una lista de los ID de VLAN disponibles para su cuenta. Para cambiar la cuenta de IBM Bluemix Infrastructure (SoftLayer), consulte [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: La ubicación suministrara para este pedido no es válida. (HTTP 500)</td>
        <td>Su cuenta de IBM Bluemix Infrastructure (SoftLayer) no está configurada para solicitar recursos de cálculo en el centro de datos seleccionado. Póngase en contacto con el [equipo de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support) para comprobar que la cuenta está correctamente configurada.</td>
       </tr>
       <tr>
        <td>Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El usuario no tiene los permisos necesarios de la infraestructura de {{site.data.keyword.Bluemix_notm}} para añadir servidores

        </br></br>
        Excepción de infraestructura de {{site.data.keyword.Bluemix_notm}}: El elemento 'Item' se debe solicitar con permiso.</td>
        <td>Es posible que no tenga los permisos necesarios para suministrar un nodo trabajador desde el portafolio de IBM Bluemix Infrastructure (SoftLayer). Consulte [Configuración del acceso al portafolio de IBM Bluemix Infrastructure (SoftLayer) para crear clústeres de Kubernetes estándares](cs_planning.html#cs_planning_unify_accounts).</td>
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


## Identificación de versiones de cliente y servidor local de kubectl

Para comprobar la versión de la CLI de Kubernetes que ejecuta localmente o que el clúster ejecuta, ejecute el mandato siguiente y compruebe la versión.

```
kubectl version  --short
```
{: pre}

Salida de ejemplo:

```
Client Version: v1.5.6
        Server Version: v1.5.6
```
{: screen}

<br />


## No se puede conectar con la cuenta de IBM Bluemix Infrastructure (SoftLayer) mientras se crea un clúster
{: #cs_credentials}

{: tsSymptoms}
Cuando crea un nuevo clúster de Kubernetes, recibe el siguiente mensaje.

```
No se ha podido conectar con la cuenta de IBM Bluemix Infrastructure (SoftLayer). Para crear un clúster estándar, debe tener una cuenta de pago según uso enlazada a una cuenta de IBM Bluemix Infrastructure (SoftLayer) o debe haber utilizado la CLI de IBM
{{site.data.keyword.Bluemix_notm}} Container Service para configurar las claves de API de la infraestructura de {{site.data.keyword.Bluemix_notm}}.
```
{: screen}

{: tsCauses}
Los usuarios con una cuenta de {{site.data.keyword.Bluemix_notm}} que no esté enlazada deben crear una nueva cuenta de pago según uso o deben añadir manualmente las claves de API de IBM Bluemix Infrastructure (SoftLayer) utilizando la CLI de {{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Para añadir credenciales de la cuenta de {{site.data.keyword.Bluemix_notm}}:

1.  Póngase en contacto con el administrador de IBM Bluemix Infrastructure (SoftLayer) para obtener el nombre de usuario y la clave de API de IBM Bluemix Infrastructure (SoftLayer).

    **Nota:** La cuenta de IBM Bluemix Infrastructure (SoftLayer) que utilice debe estar configurada con permisos de super usuario para poder crear correctamente clústeres estándares.

2.  Añada las credenciales.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Cree un clúster estándar.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

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


## Los pods permanecen en estado pendiente
{: #cs_pods_pending}

{: tsSymptoms}
Cuando se ejecuta `kubectl get pods`, puede ver que los pods permanecen en el estado **Pending**.

{: tsCauses}
Si acaba de crear el clúster de Kubernetes, es posible que los nodos trabajadores aún se estén configurando. Si este clúster ya existe, es posible que no tenga suficiente capacidad en el clúster para desplegar el pod.

{: tsResolve}
Esta tarea precisa de la [política de acceso de administrador](cs_cluster.html#access_ov). Verifique su [política de acceso](cs_cluster.html#view_access) actual.


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


## Los pods se quedan bloqueados en el estado Creating
{: #stuck_creating_state}

{: tsSymptoms}
Cuando ejecuta `kubectl get pods -o wide`, ve que varios pods que se están ejecutando en el mismo nodo trabajador quedan bloqueados en el estado `ContainerCreating`.

{: tsCauses}
El sistema de archivos del nodo trabajador es de sólo lectura.

{: tsResolve}
1. Haga una copia de seguridad de los datos que puedan estar almacenados en el nodo trabajador o en los contenedores.
2. Vuelva a crear el nodo trabajador ejecutando el mandato siguiente.

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

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


## El acceso a un pod en un nodo trabajador nuevo falla con un tiempo de espera excedido
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Ha suprimido un nodo trabajador del clúster y luego ha añadido un nodo trabajador. Cuando se despliega un pod o un servicio de Kubernetes, el recurso no puede acceder al nodo trabajador recién creado y la conexión supera el tiempo de espera.

{: tsCauses}
Si suprime un nodo trabajador del clúster y luego añade un nodo de trabajo, es posible que el nuevo nodo trabajador se asigne a la dirección IP privada del nodo trabajador suprimido. Calico utiliza esta dirección IP privada como código y sigue intentando acceder al nodo suprimido.

{: tsResolve}
Actualice manualmente la referencia a la dirección IP privada de modo que apunte al nodo correcto.

1.  Confirme que tiene dos nodos trabajadores con la misma dirección **IP privada**. Anote la **IP privada** y el **ID** del nodo trabajador suprimido.

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b1c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b1c.4x16       deleted    -
  ```
  {: screen}

2.  Instale la [CLI de Calico](cs_security.html#adding_network_policies).
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


## Los nodos trabajadores no se pueden conectar
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
Es posible que tenga un cortafuegos adicional configurado o que se hayan personalizado los valores existentes del cortafuegos en la cuenta de IBM Bluemix Infrastructure (SoftLayer). {{site.data.keyword.containershort_notm}} requiere que determinadas direcciones IP y puertos estén abiertos para permitir la comunicación entre el nodo trabajador y el nodo Kubernetes maestro y viceversa. Otro motivo puede ser que los nodos trabajadores están bloqueados en un bucle de recarga.

{: tsResolve}
Esta tarea precisa de la [política de acceso de administrador](cs_cluster.html#access_ov). Verifique su [política de acceso](cs_cluster.html#view_access) actual.


Abra los siguientes puertos y direcciones IP en su cortafuegos personalizado.

1.  Anote la dirección IP pública de todos los nodos trabajadores del clúster:

  ```
  bx cs workers '<cluster_name_or_id>'
  ```
  {: pre}

2.  En el cortafuegos correspondiente a la conectividad de SALIDA de los nodos trabajadores, permita el tráfico de red de salida desde el nodo trabajador de origen al rango de puertos TCP/UDP de destino 20000-32767 y el puerto 443 para `<each_worker_node_publicIP>`, y las siguientes direcciones IP y grupos de red.
    - **Importante**: También debe permitir el tráfico de salida al puerto 443 y a todas las ubicaciones entre una región y otra para equilibrar la carga durante el proceso de arranque. Por ejemplo, si el clúster está en el EE.UU. sur, debe permitir el tráfico procedente desde el de 443 a dal10 y dal12 y entre dal10 y dal12.
    <p>
  <table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
      <thead>
      <th>Región</th>
      <th>Ubicación</th>
      <th>dirección IP</th>
      </thead>
    <tbody>
      <tr>
         <td>AP Sur</td>
         <td>mel01<br>syd01</td>
         <td><code>168.1.97.67</code><br><code>168.1.8.195</code></td>
      </tr>
      <tr>
         <td>UE Central</td>
         <td>ams03<br>fra02</td>
         <td><code>169.50.169.110</code><br><code>169.50.56.174</code></td>
        </tr>
      <tr>
        <td>UK Sur</td>
        <td>lon02<br>lon04</td>
        <td><code>159.122.242.78</code><br><code>158.175.65.170</code></td>
      </tr>
      <tr>
        <td>EE.UU. este</td>
         <td>wdc06<br>wdc07</td>
         <td><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
      </tr>
      <tr>
        <td>EE.UU. Sur</td>
        <td>dal10<br>dal12<br>dal13</td>
        <td><code>169.46.7.238</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code></td>
      </tr>
      </tbody>
    </table>
</p>

3.  Permita el tráfico de red de salida de los nodos trabajadores a {{site.data.keyword.registrylong_notm}}:
    - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
    - Sustituya <em>&lt;registry_publicIP&gt;</em> por todas las direcciones de las regiones de registro a las que desea permitir el tráfico:
      <p>      
<table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
        <thead>
        <th colspan=2>Direcciones IP de registro de <img src="images/idea.png"/></th>
        </thead>
      <tbody>
        <tr>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></td>
         </tr>
         <tr>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></td>
         </tr>
         <tr>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></td>
         </tr>
        </tbody>
      </table>
</p>

4.  Opcional: Permita el tráfico de red de salida de los nodos trabajadores a {{site.data.keyword.monitoringlong_notm}} y a los servicios {{site.data.keyword.loganalysislong_notm}}:
    - `TCP port 443, port 9095 FROM <each_worker_node_publicIP> TO <monitoring_publicIP>`
    - Sustituya <em>&lt;monitoring_publicIP&gt;</em> por todas las direcciones de las regiones de supervisión a las que desea permitir el tráfico:
      <p><table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
        <thead>
        <th colspan=2>Direcciones IP públicas de supervisión de <img src="images/idea.png"/></th>
        </thead>
      <tbody>
        <tr>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>159.122.78.136/29</code></td>
        </tr>
        <tr>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
    - `TCP port 443, port 9091 FROM <each_worker_node_publicIP> TO <logging_publicIP>`
    - Sustituya <em>&lt;logging_publicIP&gt;</em> por todas las direcciones de las regiones de registro a las que desea permitir el tráfico:
      <p><table summary="La primera fila de la tabla abarca ambas columnas. El resto de las filas se deben leer de izquierda a derecha; la ubicación del servidor está en la columna uno y las direcciones IP correspondientes en la columna dos. ">
        <thead>
        <th colspan=2>Direcciones IP públicas de registro de <img src="images/idea.png"/></th>
        </thead>
      <tbody>
        <tr>
         <td>ingest.logging.eu-de.bluemix.net</td>
         <td><code>169.50.25.125</code></td>
        </tr>
        <tr>
         <td>ingest.logging.eu-gb.bluemix.net</td>
         <td><code>169.50.115.113</code></td>
        </tr>
        <tr>
          <td>ingest.logging.ng.bluemix.net</td>
          <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
         </tr>
        </tbody>
      </table>
</p>

5. Si tiene un cortafuegos privado, permita los rangos de direcciones IP privadas adecuadas de IBM Bluemix Infrastructure (SoftLayer). Consulte [este enlace](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) a partir de la sección **Red de fondo (privada)**.
    - Añada todas las [ubicaciones dentro de la región o regiones](cs_regions.html#locations) que está utilizando
    - Tenga en cuenta que debe añadir la ubicación dal01 (centro de datos)
    - Abra los puertos 80 y 443 para permitir el proceso de arranque del clúster

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


## La conexión con una app mediante Ingress falla
{: #cs_ingress_fails}

{: tsSymptoms}
Ha expuesto a nivel público la app creando un recurso de Ingress para la app en el clúster. Cuando intenta conectar con la app a través de la dirección IP pública o subdominio del controlador de Ingress, la conexión falla o supera el tiempo de espera.

{: tsCauses}
Posibles motivos por los que Ingress no funciona correctamente:
<ul><ul>
<li>El clúster todavía no se ha desplegado por completo.
<li>El clúster se ha configurado como un clúster lite o como un clúster estándar con un solo nodo trabajador.
<li>El script de configuración de Ingress incluye errores.
</ul></ul>

{: tsResolve}
Para resolver el problema de Ingress:

1.  Compruebe que ha configurado un clúster estándar que se ha desplegado por completo y que tiene al menos dos nodos trabajadores para garantizar la alta disponibilidad de su controlador de Ingress.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    En la salida de la CLI, asegúrese de que el **Estado** de los nodos trabajadores sea **Listo** y que el **Tipo de máquina** muestre un tipo de máquina que no sea **gratuito (free)**.

2.  Recupere el subdominio del controlador de Ingress y la dirección IP pública y luego ejecute ping sobre cada uno.

    1.  Recupere el subdominio del controlador de Ingress.

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Ejecute ping sobre el subdominio del controlador de Ingress.

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Recupere la dirección IP pública del controlador de Ingress.

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Ejecute ping sobre la dirección IP pública del controlador de Ingress.

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Si la CLI devuelve un tiempo de espera para la dirección IP pública o subdominio del controlador de Ingress y ha configurado un cortafuegos personalizado que protege los nodos trabajadores, es posible que tenga que abrir puertos adicionales y grupos de redes en el [cortafuegos](#cs_firewall).

3.  Si utiliza un dominio personalizado, asegúrese de que el dominio personalizado está correlacionado con la dirección IP pública o subdominio del controlador de Ingress proporcionado por IBM con el proveedor del Servicio de nombres de dominio (DNS).
    1.  Si ha utilizado el subdominio del controlador de Ingress, compruebe el registro del nombre canónico (CNAME).
    2.  Si ha utilizado la dirección IP pública del controlador de Ingress, compruebe que el dominio personalizado esté correlacionado con la dirección IP pública portátil del registro de puntero
(PTR).
4.  Compruebe el archivo de configuración de Ingress.

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

    1.  Compruebe que el subdominio del controlador de Ingress y el certificado TLS sean correctos. Para encontrar el subdominio proporcionado por IBM y el certificado TLS, ejecute bx cs cluster-get <cluster_name_or_id>.
    2.  Asegúrese de que su app está a la escucha en la misma vía de acceso que está configurada en la sección **path** de Ingress. Si la app se ha configurado para que escuche en la vía de acceso raíz, incluya **/** como vía de acceso.
5.  Compruebe el despliegue de Ingress y mire si hay algún mensaje de error.

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Compruebe los registros correspondientes al controlador de Ingress.
    1.  Recupere el ID de los pod de Ingress que se ejecutan en el clúster.

      ```
      kubectl get pods -n kube-system |grep ingress
      ```
      {: pre}

    2.  Recuperar los registros correspondientes a cada pod de Ingress.

      ```
      kubectl logs <ingress_pod_id> -n kube-system
      ```
      {: pre}

    3.  Mire si hay mensajes de error en los registros del controlador de Ingress.

<br />


## La conexión con una app mediante el servicio equilibrador de carga falla
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Ha expuesto a nivel público la app creando un servicio equilibrador de carga en el clúster. Cuando intenta conectar con la app a través de la dirección IP pública o equilibrador de carga, la conexión falla o supera el tiempo de espera.

{: tsCauses}
Posibles motivos por los que el servicio del equilibrador de carga no funciona correctamente:

-   El clúster es un clúster lite o un clúster estándar con un solo nodo trabajador.
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
    <ul><ul><li><pre class="screen"><code>Los clústeres con un nodo deben utilizar servicios de tipo NodePort</code></pre></br>Para utilizar el servicio equilibrador de carga, debe tener un clúster estándar con al menos dos nodos trabajadores.
    <li><pre class="screen"><code>No hay ninguna IP de proveedor de nube disponible para dar respuesta a la solicitud de servicio del equilibrador de carga. Añada una subred portátil al clúster y vuélvalo a intentar</code></pre></br>Este mensaje de error indica que no queda ninguna dirección IP pública portátil que se pueda asignar al servicio equilibrador de carga. Consulte la sección sobre [Adición de subredes a clústeres](cs_cluster.html#cs_cluster_subnet) para ver información sobre cómo solicitar direcciones IP públicas portátiles para el clúster. Cuando haya direcciones IP públicas portátiles disponibles para el clúster, el servicio equilibrador de carga se creará automáticamente.
    <li><pre class="screen"><code>La IP de proveedor de nube solicitada <cloud-provider-ip> no está disponible. Están disponibles las siguientes IP de proveedor de nube: <available-cloud-provider-ips</code></pre></br>Ha definido una dirección IP pública portátil para el servicio equilibrador de carga mediante la sección **loadBalancerIP**, pero esta dirección IP pública portátil no está disponible en la subred pública portátil. Cambie el script de configuración del servicio equilibrador de carga y elija una de las direcciones IP públicas portátiles disponibles o elimine la sección **loadBalancerIP** del script para que la dirección IP pública portátil disponible se pueda asignar automáticamente.
    <li><pre class="screen"><code>No hay nodos disponibles para el servicio equilibrador de carga</code></pre>No tiene suficientes nodos trabajadores para desplegar un servicio equilibrador de carga. Una razón posible es que ha desplegado un clúster estándar con más de un nodo trabajador, pero el suministro de los nodos trabajadores ha fallado.
    <ol><li>Obtenga una lista de los nodos trabajadores disponibles.</br><pre class="codeblock"><code>kubectl get nodes</code></pre>
    <li>Si se encuentran al menos dos nodos trabajadores disponibles, obtenga una lista de los detalles de los nodos trabajadores.</br><pre class="screen"><code>bx cs worker-get <worker_ID></code></pre>
    <li>Asegúrese de que los ID de las VLAN públicas y privadas correspondientes a los nodos trabajadores devueltos por los mandatos 'kubectl get nodes' y 'bx cs worker-get' coinciden.</ol></ul></ul>

4.  Si utiliza un dominio personalizado para conectar con el servicio equilibrador de carga, asegúrese de que el dominio personalizado está correlacionado con la dirección IP pública del servicio equilibrador de carga.
    1.  Busque la dirección IP pública del servicio equilibrador de carga.

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Compruebe que el dominio personalizado esté correlacionado con la dirección IP pública portátil del servicio equilibrador de carga en el registro de puntero
(PTR).

<br />


## La recuperación del url de ETCD para la configuración de la CLI de Calico falla
{: #cs_calico_fails}

{: tsSymptoms}
Cuando recupera el `<ETCD_URL>` para [añadir políticas de red](cs_security.html#adding_network_policies), obtiene un mensaje de error `calico-config not found`.

{: tsCauses}
El clúster no está al nivel de (Kubernetes versión 1.7) [cs_versions.html] o posterior.

{: tsResolve}
(Actualice el clúster)[cs_cluster.html#cs_cluster_update] o recupere el `<ETCD_URL>` con mandatos compatibles con versiones anteriores de Kubernetes.

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

Cuando recupere el `<ETCD_URL>`, continúe con los pasos que figuran en (Adición de políticas de red) [cs_security.html#adding_network_policies].

<br />


## Problemas conocidos
{: #cs_known_issues}

Información sobre los problemas conocidos.
{: shortdesc}

### Clústeres
{: #ki_clusters}

<dl>
  <dt>Las apps de Cloud Foundry del mismo espacio de {{site.data.keyword.Bluemix_notm}} no pueden acceder a un clúster</dt>
    <dd>Cuando se crea un clúster de Kubernetes, el clúster se crea a nivel de cuenta y no utiliza el espacio, excepto cuando se enlazan servicios de {{site.data.keyword.Bluemix_notm}}. Si tiene una app de Cloud Foundry a la que desea que el clúster acceda, debe poner la app de Cloud Foundry a disposición del público o debe poner la app en el clúster [a disposición del público](cs_planning.html#cs_planning_public_network).</dd>
  <dt>El servicio NodePort del panel de control de Kube se ha inhabilitado</dt>
    <dd>Por motivos de seguridad, el servicio NodePort del panel de control de Kubernetes se ha inhabilitado. Para acceder al panel de control de Kubernetes, ejecute el siguiente mandato.</br><pre class="codeblock"><code>kubectl proxy</code></pre></br>Luego puede acceder al panel de control de Kubernetes en `http://localhost:8001/ui`.</dd>
  <dt>Limitaciones con el tipo de servicio del equilibrador de carga</dt>
    <dd><ul><li>No puede utilizar el equilibrio de carga en VLAN privadas.<li>No puede utilizar las anotaciones de servicio service.beta.kubernetes.io/external-traffic y
service.beta.kubernetes.io/healthcheck-nodeport. Para obtener más información sobre estas anotaciones, consulte la [documentación de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tutorials/services/source-ip/).</ul></dd>
  <dt>El escalado automático horizontal no funciona en algunos clústeres</dt>
    <dd>Por razones de seguridad, se cierra el puerto estándar (10255) que utiliza Heapster en todos los nodos trabajadores de los clústeres antiguos. Puesto que este puerto está cerrado, Heapster no puede informar de métricas para los nodos trabajadores y el escalado automático horizontal no puede funcionar tal como se indica en [Escalado automático de pod horizontal![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) en la documentación de Kubernetes. Cree otro clúster para evitar este problema.</dd>
</dl>

### Almacén persistente
{: #persistent_storage}

El mandato `kubectl describe <pvc_name>` muestra **ProvisioningFailed** para una reclamación de volumen permanente:
<ul><ul>
<li>Cuando se crea una reclamación de volumen permanente, no hay ningún volumen permanente disponible, por lo que Kubernetes devuelve el mensaje **ProvisioningFailed**.
<li>Cuando el volumen permanente se crea y se enlaza a la reclamación, Kubernetes devuelve el mensaje **ProvisioningSucceeded**. Este proceso puede tardar unos minutos.
</ul></ul>

## Obtención de ayuda y soporte
{: #ts_getting_help}

¿Dónde comienzo a resolver problemas de un contenedor?

-   Para ver si {{site.data.keyword.Bluemix_notm}} está disponible, [consulte la página de estado de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/support/#status).
-   Puede publicar una pregunta en [{{site.data.keyword.containershort_notm}} Slack. ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://ibm-container-service.slack.com) Si no utiliza un ID de IBM para la cuenta de {{site.data.keyword.Bluemix_notm}}, póngase en contacto con [crosen@us.ibm.com](mailto:crosen@us.ibm.com) y solicite una invitación a este Slack.
-   Revise los foros para ver si otros usuarios se han encontrado con el mismo problema. Cuando utiliza los foros para formular una pregunta, etiquete la pregunta para que la puedan ver los equipos de desarrollo de {{site.data.keyword.Bluemix_notm}}.

    -   Si tiene preguntas técnicas sobre el desarrollo o despliegue de clústeres o apps con {{site.data.keyword.containershort_notm}}, publique su pregunta en [Stack Overflow ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](http://stackoverflow.com/search?q=bluemix+containers) y etiquete su pregunta con `ibm-bluemix`, `kubernetes` y `containers`.
    -   Para las preguntas relativas a las instrucciones de inicio y el servicio, utilice el foro [IBM developerWorks dW Answers![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluya las etiquetas `bluemix`
y `containers`.
    Consulte [Obtención de ayuda](/docs/support/index.html#getting-help) para obtener más detalles sobre cómo utilizar los foros.

-   Póngase en contacto con el servicio de soporte de IBM. Para obtener información sobre cómo abrir una incidencia de soporte de IBM, o sobre los niveles de soporte y las gravedades de las incidencias, consulte [Cómo contactar con el servicio de soporte](/docs/support/index.html#contacting-support).
