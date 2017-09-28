---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# Consulta de CLI para gestionar clústeres
{: #cs_cli_reference}

Consulte estos mandatos para crear y gestionar clústeres.
{:shortdesc}

**Sugerencia:** ¿Está buscando mandatos `bx cr`? Revise la guía de [consulta de la CLI de {{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html#containerregcli). ¿Está buscando mandatos `kubectl`? Consulte la [documentación de Kubernetes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).

 
<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Mandatos para crear clústeres en {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Mandatos para crear clústeres en {{site.data.keyword.Bluemix_notm}}</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_reference.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_reference.html#cs_cluster_create)</td> 
    <td>[bx cs cluster-get](cs_cli_reference.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_reference.html#cs_cluster_services)</td> 
    <td>[bx cs cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
   <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td> 
   <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
   <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td> 
    <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td> 
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
   <td></td>
  </tr>
 </tbody>
 </table> 
    
**Sugerencia:** Para ver la versión del plug-in de {{site.data.keyword.containershort_notm}}, consulte el siguiente mandato.

```
bx plugin list
```
{: pre}

## Mandatos bx cs
{: #cs_commands}

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

Después de iniciar una sesión, descargue certificados y datos de configuración de Kubernetes para conectar el clúster y para ejecutar mandatos `kubectl`. Los archivos se descargan en `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Opciones del mandato**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code>--admin</code></dt>
   <dd>(Opcional) Descargar los certificados y archivos de permisos para el rol rbac de administrador. Los usuarios con estos archivos pueden realizar acciones de administración en el clúster, como por ejemplo eliminar el clúster.</dd>
   </dl>

**Ejemplos**:

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN][--workers WORKER]
{: #cs_cluster_create}

Para crear un clúster en la organización.

<strong>Opciones del mandato</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>(Opcional para clústeres estándares. No disponible para clústeres de tipo lite.) La vía de acceso al archivo YAML para crear el clúster estándar. En lugar de definir las características de su clúster mediante las opciones que se proporcionan en este mandato, puede utilizar un archivo YAML. <p><strong>Nota:</strong> Si especifica la misma opción en el mandato y como parámetro en el archivo YAML, el valor en el mandato prevalece sobre el valor del archivo YAML. Por ejemplo, supongamos que define una ubicación en el archivo YAML y utiliza la opción <code>--location</code> en el mandato; el valor que especifique en la opción del mandato prevalece sobre el valor del archivo YAML.<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>


<table>
    <caption>Tabla 1. Visión general de los componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Sustituya <code><em>&lt;cluster_name&gt;</em></code> por el nombre del clúster. </td> 
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>Sustituya <code><em>&lt;location&gt;</em></code> por la ubicación en la que desea crear el clúster. Las ubicaciones disponibles dependen de la región en la que ha iniciado la sesión.
Para ver una lista de las ubicaciones disponibles, ejecute <code>cs bx ubicaciones</code>.</td> 
     </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Sustituya <code><em>&lt;machine_type&gt;</em></code> por el tipo de máquina que desea utilizar para los nodos trabajadores. Para ver una lista de los tipos de máquina disponibles para su ubicación, ejecute <code>bx cs machine-types <em>&lt;location&gt;</em></code>. </td> 
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Sustituya <code><em>&lt;private_vlan&gt;</em></code> por el ID de la VLAN privada que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code> y busque direccionadores de VLAN que empiecen por <code>bcr</code> ("back-end router", direccionador de fondo). </td> 
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Sustituya <code><em>&lt;public_vlan&gt;</em></code> por el ID de la VLAN pública que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code> y busque direccionadores de VLAN que empiecen por <code>fcr</code> ("front-end router", direccionador frontal). </td> 
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated si desea tener recursos físicos disponibles dedicados solo a usted, o el valor shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es <code>shared</code>.</td> 
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Sustituya <code><em>&lt;number_workers&gt;</em></code> por el número de nodos trabajadores que desea desplegar. </td> 
     </tr>
     </tbody></table>
    </p></dd>
    
<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>(Opcional para clústeres estándares. No disponible para clústeres de tipo lite.) El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated si desea tener recursos físicos disponibles dedicados solo a usted, o el valor shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared.</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>(Obligatorio para clústeres estándares. Opcional para clústeres de tipo lite.) La ubicación en la que desea crear el clúster. Las ubicaciones disponibles dependen de la región de {{site.data.keyword.Bluemix_notm}} en la que haya iniciado la sesión. Para obtener el mejor rendimiento, seleccione la región que esté físicamente más cercana a su ubicación.

<p>Las ubicaciones disponibles son las siguientes:<ul><li>EE.UU. Sur<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>UK-Sur<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>UE-Central<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>AP Sur<ul><li>syd01 [Sidney]</li><li>syd04 [Sidney]</li></ul></li></ul>
</p>

<p><strong>Nota:</strong> Si selecciona una ubicación que se encuentra fuera de su país, tenga en cuenta que es posible que se requiera autorización legal para poder almacenar datos físicamente en un país extranjero. </p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>(Obligatorio para clústeres estándares. No disponible para clústeres de tipo lite.) El tipo de máquina tipo que elija afecta a la cantidad de memoria y al espacio de disco que está disponible para los contenedores desplegados en el nodo trabajador. Para ver una lista de los tipos de máquina disponibles, ejecute [bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types). </dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>(Obligatorio) El nombre del clúster.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Incluir el distintivo para crear un clúster sin una subred portátil. El valor predeterminado es no utilizar el distintivo y para crear una subred en la cartera de {{site.data.keyword.BluSoftlayer_full}}.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>(No disponible para clústeres de tipo lite.) <ul>
<li>Si este es el primer clúster que crea en esta ubicación, no incluya este distintivo. Al crear clústeres se crea automáticamente una VLAN privada.</li>
<li>Si ha creado un clúster antes en esta ubicación o ha creado una VLAN privada en {{site.data.keyword.BluSoftlayer_notm}} antes, debe especificar la VLAN privada.

<p><strong>Nota:</strong> Las VLAN pública y privada que especifique con el mandato create deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></li>
</ul>

<p>Para saber si ya tiene una VLAN privada para una ubicación específica o para encontrar el nombre de una VLAN privada existente, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>(No disponible para clústeres de tipo lite.) <ul>
<li>Si este es el primer clúster que crea en esta ubicación, no utilice este distintivo. Al crear el clúster se crea automáticamente una VLAN pública.</li>
<li>Si ha creado un clúster antes en esta ubicación o ha creado una VLAN pública en {{site.data.keyword.BluSoftlayer_notm}} antes, debe especificar la VLAN pública.<p><strong>Nota:</strong> Las VLAN pública y privada que especifique con el mandato create deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></li>
</ul>

<p>Para saber si ya tiene una VLAN pública para una ubicación específica o para encontrar el nombre de una VLAN pública existente, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code>. </p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>(Opcional para clústeres estándares. No disponible para clústeres de tipo lite.) El número de nodos trabajadores que desea desplegar en el clúster. Si no especifica esta opción, se crea un clúster con 1 nodo trabajador.

<p><strong>Nota:</strong> A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster.
Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.</p></dd>
</dl>

**Ejemplos**:

  
  
  Ejemplo para un clúster estándar:   {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Ejemplo para un clúster lite: 

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  Ejemplo para el entorno {{site.data.keyword.Bluemix_notm}} dedicado:

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

Ver información sobre un clúster de la organización.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

Eliminar un clúster de la organización.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Opcional) Utilice esta opción para forzar la eliminación de un clúster sin solicitudes de usuario.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

Añadir un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.

**Sugerencia:** Para usuarios de {{site.data.keyword.Bluemix_notm}} dedicado, consulte [Adición de servicios de {{site.data.keyword.Bluemix_notm}} a clústeres en {{site.data.keyword.Bluemix_notm}} dedicado (Beta cerrada)](cs_cluster.html#binding_dedicated). 

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Obligatorio) El nombre del espacio de nombres de Kubernetes.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(Obligatorio) El ID de la instancia de servicio de {{site.data.keyword.Bluemix_notm}} que desea vincular.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

Eliminar un servicio de {{site.data.keyword.Bluemix_notm}} de un clúster.

**Nota:** Cuando se elimina un servicio de {{site.data.keyword.Bluemix_notm}}, las credenciales del servicio se eliminan del clúster.  Si un pod sigue utilizando el servicio, falla porque no encuentra las credenciales del servicio.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Obligatorio) El nombre del espacio de nombres de Kubernetes.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(Obligatorio) El ID de la instancia de servicio de {{site.data.keyword.Bluemix_notm}} que desea eliminar.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces]
{: #cs_cluster_services}

Crear una lista de los servicios que están vinculados a uno o a todos los espacios de nombres de Kubernetes de un clúster. Si no se especifica ninguna opción, se muestran los servicios correspondientes al espacio de nombres predeterminado.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Opcional) Incluye los servicios que están vinculados a un determinado espacio de nombres de un clúster.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>(Opcional) Incluye los servicios que están vinculados a todos los espacios de nombres de un clúster.</dd>
    </dl>

**Ejemplos**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

Poner la subred de la cuenta de {{site.data.keyword.BluSoftlayer_notm}}
a disponibilidad de un determinado clúster.

**Nota:** Cuando se pone una subred a disponibilidad de un clúster, las direcciones IP de esta subred se utilizan para la gestión de redes del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containershort_notm}} al mismo tiempo.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>(Obligatorio) El ID de la subred.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Ver una lista de los clústeres de la organización.

<strong>Opciones del mandato</strong>:

  Ninguno

**Ejemplos**:

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

Definir las credenciales de cuenta de {{site.data.keyword.BluSoftlayer_notm}} para su cuenta de {{site.data.keyword.Bluemix_notm}}. Estas credenciales le permiten acceder al portafolio de {{site.data.keyword.BluSoftlayer_notm}} a través de su cuenta de {{site.data.keyword.Bluemix_notm}}.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>(Obligatorio) Un nombre de usuario de cuenta de {{site.data.keyword.BluSoftlayer_notm}}.</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>(Obligatorio) Una clave de API de cuenta de {{site.data.keyword.BluSoftlayer_notm}}.
   
 <p>
  Para generar una clave de API:
    
  <ol>
  <li>Inicie una sesión en el portal de [{{site.data.keyword.BluSoftlayer_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://control.softlayer.com/).</li>
  <li>Seleccione <strong>Cuenta</strong> y, a continuación, <strong>Usuarios</strong>.</li>
  <li>Pulse <strong>Generar</strong> para generar una clave de API de {{site.data.keyword.BluSoftlayer_notm}} para su cuenta.</li>
  <li>Copie la clave de la API para utilizar en este mandato.</li>
  </ol>

  Para ver una clave de API existente:
  <ol>
  <li>Inicie una sesión en el portal de [{{site.data.keyword.BluSoftlayer_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://control.softlayer.com/).</li>
  <li>Seleccione <strong>Cuenta</strong> y, a continuación, <strong>Usuarios</strong>.</li>
  <li>Pulse <strong>Ver</strong> para ver la clave de API existente.</li>
  <li>Copie la clave de la API para utilizar en este mandato.</li>
  </ol></p></dd>
    
**Ejemplos**:

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Eliminar las credenciales de cuenta de {{site.data.keyword.BluSoftlayer_notm}} de su cuenta de {{site.data.keyword.Bluemix_notm}}. Después de eliminar las credenciales, ya no podrá acceder al portafolio de {{site.data.keyword.BluSoftlayer_notm}} a través de su cuenta de {{site.data.keyword.Bluemix_notm}}.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplos**:

  ```
  bx cs credentials-unset
  ```
  {: pre}


### bx cs locations
{: #cs_datacenters}

Ver una lista de las ubicaciones disponibles en las que puede crear un clúster.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplos**:

  ```
  bx cs locations
  ```
  {: pre}


### bx cs help
{: #cs_help}

Ver una lista de mandatos y parámetros admitidos.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplos**:

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

Inicialice el plug-in de {{site.data.keyword.containershort_notm}} o especifique la región donde desea crear o acceder a clústeres de Kubernetes.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>(Opcional) El punto final de API de {{site.data.keyword.containershort_notm}} que desea utilizar. Ejemplos:

    <ul>
    <li>EE.UU. Sur:

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>UK-Sur: 

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>UE-Central:

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>AP Sur:

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>


### bx cs machine-types LOCATION
{: #cs_machine_types}

Ver una lista de los tipos de máquinas disponibles para sus nodos trabajadores. Cada tipo de máquina incluye cantidad de CPU virtual, memoria y espacio de disco para cada nodo trabajador del clúster.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>(Obligatorio) Especifique la ubicación de la que desea ver una lista de tipos de máquina disponibles. Las ubicaciones disponibles son las siguientes: <ul><li>EE.UU. Sur<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>UK-Sur<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>UE-Central<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>AP Sur<ul><li>syd01 [Sidney]</li><li>syd04 [Sidney]</li></ul></li></ul></dd></dl>
   
**Ejemplos**:

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Ver una lista de subredes que están disponibles en una cuenta de {{site.data.keyword.BluSoftlayer_notm}}.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplos**:

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

Crear una lista de las VLAN públicas y privadas disponibles para una ubicación en la cuenta de {{site.data.keyword.BluSoftlayer_notm}}. Para ver una lista de las VLAN disponibles,
debe tener una cuenta de pago.



<strong>Opciones del mandato</strong>:

   <dl>
   <dt>LOCATION</dt>
   <dd>(Obligatorio) Escriba la ubicación donde desea listar sus VLAN públicas y privadas. Las ubicaciones disponibles son las siguientes: <ul><li>EE.UU. Sur<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>UK-Sur<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>UE-Central<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>AP Sur<ul><li>syd01 [Sidney]</li><li>syd04 [Sidney]</li></ul></li></ul></dd>
   </dl>
   
**Ejemplos**:

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

Crear webhooks.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>(Opcional) El nivel de notificación, como por ejemplo <code>Normal</code> o <code>Warning</code>. <code>Warning</code> es el valor predeterminado.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>(Obligatorio) El tipo de webhook, como por ejemplo slack. Solo se admite slack. </dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>(Obligatorio) El URL del webhook.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

Añadir nodos trabajadores al clúster estándar.

<strong>Opciones del mandato</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>(Obligatorio) El nombre o ID del clúster.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>La vía de acceso al archivo YAML para añadir nodos trabajadores a su clúster. En lugar de definir los nodos trabajadores adicionales mediante las opciones que se proporcionan en este mandato, puede utilizar un archivo YAML. <p><strong>Nota:</strong> Si especifica la misma opción en el mandato y como parámetro en el archivo YAML, el valor en el mandato prevalece sobre el valor del archivo YAML. Por ejemplo, supongamos que define un tipo de máquina en el archivo YAML y utiliza la opción --machine-type en el mandato; el valor que especifique en la opción del mandato prevalece sobre el valor del archivo YAML.<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_id&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>
        
<table>
<caption>Tabla 2. Visión general de los componentes del archivo YAML</caption>
<thead>
<th colspan=2><img src="images/idea.png"/>Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Sustituya <code><em>&lt;cluster_name_or_id&gt;</em></code> por el nombre o ID del clúster donde desea añadir nodos trabajadores.</td> 
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>Sustituya <code><em>&lt;location&gt;</em></code> por la ubicación en la que desea desplegar los nodos trabajadores. Las ubicaciones disponibles dependen de la región en la que ha iniciado la sesión.
Para ver una lista de las ubicaciones disponibles, ejecute <code>cs bx ubicaciones</code>.</td> 
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Sustituya <code><em>&lt;machine_type&gt;</em></code> por el tipo de máquina que desea utilizar para los nodos trabajadores. Para ver una lista de los tipos de máquina disponibles para su ubicación, ejecute <code>bx cs machine-types <em>&lt;location&gt;</em></code>. </td> 
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Sustituya <code><em>&lt;private_vlan&gt;</em></code> por el ID de la VLAN privada que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code> y busque direccionadores de VLAN que empiecen por <code>bcr</code> ("back-end router", direccionador de fondo). </td> 
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Sustituya <code>&lt;public_vlan&gt;</code> por el ID de la VLAN pública que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans&lt;location&gt;</code> y busque direccionadores de VLAN que empiecen por <code>fcr</code> ("front-end router", direccionador frontal). </td> 
</tr>
<tr>
<td><code>hardware</code></td>
<td>El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated si desea tener recursos físicos disponibles dedicados solo a usted, o el valor shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared.</td> 
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Sustituya <code><em>&lt;number_workers&gt;</em></code> por el número de nodos trabajadores que desea desplegar. </td> 
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>(Opcional) El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated si desea tener recursos físicos disponibles dedicados solo a usted, o el valor shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>(Obligatorio) El tipo de máquina tipo que elija afecta a la cantidad de memoria y al espacio de disco que está disponible para los contenedores desplegados en el nodo trabajador. Para ver una lista de los tipos de máquina disponibles, ejecute [bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types). </dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>(Obligatorio) Un entero que representa el número de nodos trabajadores que desea crear en el clúster.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>(Obligatorio) Si tiene una VLAN privada que pueda utilizar en la ubicación, debe especificar la VLAN. Si este es el primer clúster que crea en esta ubicación, no utilice este distintivo. Se crea automáticamente una VLAN privada.

<p><strong>Nota:</strong> Las VLAN pública y privada que especifique con el mandato create deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>(Obligatorio) Si tiene una VLAN pública que pueda utilizar en la ubicación, debe especificar la VLAN. Si este es el primer clúster que crea en esta ubicación, no utilice este distintivo. Se crea automáticamente una VLAN pública.

<p><strong>Nota:</strong> Las VLAN pública y privada que especifique con el mandato create deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></dd>
</dl>

**Ejemplos**:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  Ejemplo para {{site.data.keyword.Bluemix_notm}} dedicado: 

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

Ver detalles de un nodo trabajador.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><em>WORKER_NODE_ID</em></dt>
   <dd>El ID de un nodo trabajador. Ejecute <code>bx cs workers <em>CLUSTER</em></code> para ver los ID de los nodos
trabajadores de un clúster. </dd>
   </dl>

**Ejemplos**:

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

Rearrancar los nodos trabajadores de un clúster. Si existe un problema con un nodo trabajador, intente primero rearrancar el nodo trabajador, lo que hace que se reinicie. Si el rearranque no se resuelve el problema, intente el mandato `worker-reload`. El estado de los trabajadores no cambia durante el rearranque. El estado seguirá siendo `deployed`, pero el estado se actualiza.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Opcional) Utilice esta opción para forzar el reinicio de un nodo trabajador sin solicitudes de usuario.</dd>

   <dt><code>--hard</code></dt>
   <dd>(Opcional) Utilice esta opción para forzar un reinicio de un nodo trabajador, cortando el suministro eléctrico al nodo trabajador. Utilice esta opción si el nodo trabajador no responde o si tiene un bloqueo de Docker.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID de uno o varios nodos trabajadores. Utilice un espacio para ver una lista de varios nodos trabajadores.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

Volver a cargar los nodos trabajadores en un clúster. Si existe un problema con un nodo trabajador, intente primero rearrancar el nodo trabajador. Si el rearranque no se resuelve el problema, intente el mandato `worker-reload`, que vuelve a cargar todas las configuraciones necesarias para el nodo trabajador.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Opcional) Utilice esta opción para forzar que se vuelva a cargar un nodo trabajador sin solicitudes de usuario.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID de uno o varios nodos trabajadores. Utilice un espacio para ver una lista de varios nodos trabajadores.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

Eliminar uno o varios nodos trabajadores de un clúster.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID del clúster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Opcional) Utilice esta opción para forzar la eliminación de un nodo trabajador sin solicitudes de usuario.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obligatorio) El nombre o ID de uno o varios nodos trabajadores. Utilice un espacio para ver una lista de varios nodos trabajadores.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Ver una lista de los nodos trabajadores y el estado de cada uno de ellos en un clúster.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>(Obligatorio) El nombre o ID del clúster en el que se listan los nodos trabajadores disponibles.</dd>
   </dl>

**Ejemplos**:

  ```
  bx cs workers mycluster
  ```
  {: pre}

## Estados de un clúster
{: #cs_cluster_states}

Puede ver el estado actual del clúster ejecutando el mandato bx cs clusters y localizando el campo **State**. El estado del clúster proporciona información sobre la disponibilidad y la capacidad del clúster, y posibles problemas que puedan haberse producido.{:shortdesc}

|Estado del clúster|Motivo|
|-------------|------|
|Despliegue|El nodo Kubernetes maestro no está completamente desplegado. No puede acceder a su clúster.|
|Pendiente|El nodo Kubernetes maestro está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.|
|Normal|Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster.|
|Aviso|Al menos un nodo trabajador del clúster no está disponible, pero los otros nodos trabajadores están disponibles y pueden asumir la carga de trabajo.<ol><li>Obtenga una lista de los nodos trabajadores del clúster y anote el ID de los nodos trabajadores con el estado <strong>Aviso</strong>. <pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Obtenga los detalles de un nodo trabajador. <pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Revise los campos <strong>State</strong>, <strong>Status</strong> y <strong>Details</strong> para ver el problema raíz por el que el nodo trabajador está inactivo. </li><li>Si el nodo trabajador casi ha alcanzado el límite de memoria o de espacio de disco, reduzca la carga de trabajo del nodo trabajador o añada un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo. </li></ol>|
|Crítico |No se puede acceder al nodo Kubernetes maestro o todos los nodos trabajadores del clúster están inactivos. <ol><li>Obtenga una lista de los nodos trabajadores del clúster. <pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>Obtener los detalles de cada nodo trabajador.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Revise los campos <strong>State</strong>, <strong>Status</strong> y <strong>Details</strong> para ver el problema raíz por el que el nodo trabajador está inactivo. </li><li>Si el estado del nodo trabajador es <strong>Provision_failed</strong>, es posible que no tenga los permisos necesarios para suministrar un nodo trabajador desde el portafolio de {{site.data.keyword.BluSoftlayer_notm}}. Para ver los permisos necesarios, consulte [Configuración del acceso al portafolio de {{site.data.keyword.BluSoftlayer_notm}} para crear clústeres de Kubernetes estándares](cs_planning.html#cs_planning_unify_accounts). </li><li>Si el estado del nodo trabajador es <strong>Critical</strong> y el estado del nodo trabajador es <strong>Out of disk (Sin disco)</strong>, significa que el nodo trabajador ha agotado su capacidad. Puede reducir la carga de trabajo del nodo trabajador o añadir un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo. </li><li>Si el estado del nodo trabajador es <strong>Critical</strong> y el estado del nodo trabajador es <strong>Unknown (Desconocido)</strong>, significa que el nodo Kubernetes maestro no está disponible. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ol>|
{: caption="Tabla 3. Estados de un clúster" caption-side="top"}
