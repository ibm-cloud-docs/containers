---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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

**Sugerencia:** ¿Está buscando mandatos `bx cr`? Revise la guía de [consulta de la CLI de {{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html). ¿Está buscando mandatos `kubectl`? Consulte la [documentación de Kubernetes![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Mandatos para crear clústeres en {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Mandatos para crear clústeres en {{site.data.keyword.Bluemix_notm}}</th>
 </thead>
 <tbody>
  <tr>
    <td>[bx cs albs](#cs_albs)</td>
    <td>[bx cs alb-configure](#cs_alb_configure)</td>
    <td>[bx cs alb-get](#cs_alb_get)</td>
    <td>[bx cs alb-types](#cs_alb_types)</td>
    <td>[bx cs cluster-config](#cs_cluster_config)</td>
  </tr>
 <tr>
    <td>[bx cs cluster-create](#cs_cluster_create)</td>
    <td>[bx cs cluster-get](#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[bx cs cluster-service-unbind](#cs_cluster_service_unbind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-services](#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[bx cs cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[bx cs cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[bx cs cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-update](#cs_cluster_update)</td>
    <td>[      bx cs clusters
      ](#cs_clusters)</td>
    <td>[bx cs credentials-set](#cs_credentials_set)</td>
    <td>[  bx cs credentials-unset
  ](#cs_credentials_unset)</td>
    <td>[  bx cs help
  ](#cs_help)</td>
 </tr>
 <tr>
    <td>[        bx cs init
        ](#cs_init)</td>
    <td>[bx cs kube-versions](#cs_kube_versions)</td>
    <td>[        bx cs locations
        ](#cs_datacenters)</td>
    <td>[bx cs logging-config-create](#cs_logging_create)</td>
    <td>[bx cs logging-config-get](#cs_logging_get)</td>
 </tr>
 <tr>
    <td>[bx cs logging-config-rm](#cs_logging_rm)</td>
    <td>[bx cs logging-config-update](#cs_logging_update)</td>
    <td>[bx cs machine-types](#cs_machine_types)</td>
    <td>[    bx cs subnets
    ](#cs_subnets)</td>
    <td>[bx cs vlans](#cs_vlans)</td>
 </tr>
 <tr>
    <td>[bx cs webhook-create](#cs_webhook_create)</td>
    <td>[bx cs worker-add](#cs_worker_add)</td>
    <td>[bx cs worker-get](#cs_worker_get)</td>
    <td>[bx cs worker-rm](#cs_worker_rm)</td>
    <td>[bx cs worker-update](#cs_worker_update)</td>
 </tr>
 <tr>
    <td>[bx cs worker-reboot](#cs_worker_reboot)</td>
    <td>[bx cs worker-reload](#cs_worker_reload)</td>
    <td>[bx cs workers](#cs_workers)</td>
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


### bx cs albs --cluster CLUSTER
{: #cs_albs}

Visualice el estado de todos los equilibradores de carga de aplicación (ALB) de un clúster. Los ALB también se denominan controladores de Ingress. Si no se devuelve ningún ID de ALB, significa que el clúster no tiene subred portátil. Puede [crear](#cs_cluster_subnet_create) o [añadir](#cs_cluster_subnet_add) subredes a un clúster.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>El nombre o ID del clúster en el que se listan los equilibradores de carga de las aplicaciones. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs albs --cluster mycluster
  ```
  {: pre}

### bx cs alb-configure --albID ALB_ID [--enable][--disable][--user-ip USERIP]
{: #cs_alb_configure}

Habilite o inhabilite un equilibrador de carga de aplicación (ALB), también denominado controlador de Ingress, en el clúster estándar.El equilibrador de carga aplicación pública está habilitado de forma predeterminada.

**Opciones del mandato**:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>El ID de un alb. Ejecute <code>bx cs albs <em>--cluster </em>CLUSTER</code> para ver los ID para los ALB de un clúster. Este valor es obligatorio.</dd>

   <dt><code>--enable</code></dt>
   <dd>Incluya este distintivo para habilitar un ALB en un clúster.</dd>

   <dt><code>--disable</code></dt>
   <dd>Incluya este distintivo para inhabilitar un ALB en un clúster.</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>Este parámetro está disponible solo para un alb privado.</li>
    <li>El ALB privado se despliega con una dirección IP de una subred privada proporcionada por un usuario. Si no se proporciona la dirección IP, ALB se despliega con una dirección IP aleatoria de una subred privada en la infraestructura de IBM Cloud (SoftLayer).</li>
   </ul>
   </dd>
   </dl>

**Ejemplos**:

  Ejemplo para habilitar un ALB:

  ```
  bx cs alb-configure --albID my_alb_id --enable
  ```
  {: pre}

  Ejemplo para inhabilitar un ALB:

  ```
  bx cs alb-configure --albID my_alb_id --disable
  ```
  {: pre}

  Ejemplo para habilitar un ALB con una dirección IP proporcionada por un usuario:

  ```
  bx cs alb-configure --albID my_private_alb_id --enable --user-ip user_ip
  ```
  {: pre}

### bx cs alb-get --albID ALB_ID
{: #cs_alb_get}

Visualice los detalles de un equilibrador de carga aplicación (ALB).

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>El ID de un ALB. Ejecute <code>bx cs albs --cluster <em>CLUSTER</em></code> para ver los ID de los albs en un clúster. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs alb-get --albID ALB_ID
  ```
  {: pre}

### bx cs alb-types
{: #cs_alb_types}

Visualice los tipos de equilibrador de carga de aplicaciones que están soportados en la región.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplo**:

  ```
  bx cs alb-types
  ```
  {: pre}

### bx cs cluster-config CLUSTER [--admin][--export]
{: #cs_cluster_config}

Después de iniciar una sesión, descargue certificados y datos de configuración de Kubernetes para conectar el clúster y para ejecutar mandatos `kubectl`. Los archivos se descargan en `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Opciones del mandato**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code>--admin</code></dt>
   <dd>Descargar los certificados TLS y archivos de permisos para el rol de superusuario. Puede utilizar los certificados para automatizar las tareas de un clúster sin tener que volverse a autenticar. Los archivos se descargan en `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`. Este valor es opcional.</dd>

   <dt><code>--export</code></dt>
   <dd>Descargar los datos de configuración y certificados de Kubernetes sin ningún mensaje aparte del mandato de exportación. Como no se muestran mensajes, puede utilizar este distintivo cuando cree scripts automatizados. Este valor es opcional.</dd>
   </dl>

**Ejemplo**:

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER]
{: #cs_cluster_create}

Para crear un clúster en la organización.

<strong>Opciones del mandato</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>La vía de acceso al archivo YAML para crear el clúster estándar. En lugar de definir las características de su clúster mediante las opciones que se proporcionan en este mandato, puede utilizar un archivo YAML.  Este valor es opcional para clústeres estándar y no está disponible para clústeres lite.

<p><strong>Nota:</strong> Si especifica la misma opción en el mandato y como parámetro en el archivo YAML, el valor en el mandato prevalece sobre el valor del archivo YAML. Por ejemplo, supongamos que define una ubicación en el archivo YAML y utiliza la opción <code>--location</code> en el mandato; el valor que especifique en la opción del mandato prevalece sobre el valor del archivo YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
</code></pre>


<table>
    <caption>Tabla 1. Visión general de los componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Sustituya <code><em>&lt;cluster_name&gt;</em></code> por el nombre del clúster.</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>Sustituya <code><em>&lt;location&gt;</em></code> por la ubicación en la que desea crear el clúster. Las ubicaciones disponibles dependen de la región en la que ha iniciado la sesión. Para ver una lista de las ubicaciones disponibles, ejecute <code>cs bx ubicaciones</code>. </td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>De forma predeterminada, se crean tanto una subred pública portátil como una privada en la VLAN asociada con el clúster. Sustituya <code><em>&lt;no-subnet&gt;</em></code> por <code><em>true</em></code> para evitar crear subredes con el clúster. Puede [crear](#cs_cluster_subnet_create) o [añadir](#cs_cluster_subnet_add) subredes a un clúster más adelante.</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Sustituya <code><em>&lt;machine_type&gt;</em></code> por el tipo de máquina que desea utilizar para los nodos trabajadores. Para ver una lista de los tipos de máquina disponibles para su ubicación, ejecute <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Sustituya <code><em>&lt;private_vlan&gt;</em></code> por el ID de la VLAN privada que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code> y busque direccionadores de VLAN que empiecen por <code>bcr</code> ("back-end router", direccionador de fondo).</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Sustituya <code><em>&lt;public_vlan&gt;</em></code> por el ID de la VLAN pública que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code> y busque direccionadores de VLAN que empiecen por <code>fcr</code> ("front-end router", direccionador frontal).</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated si desea tener recursos físicos disponibles dedicados solo a usted, o el valor shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es <code>shared</code>.</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Sustituya <code><em>&lt;number_workers&gt;</em></code> por el número de nodos trabajadores que desea desplegar.</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>La versión Kubernetes del nodo maestro del clúster. Este valor es opcional. Si no se especifica, el clúster se crea con el valor predeterminado de las versiones de Kubernetes soportadas. Para ver todas las versiones disponibles, ejecute <code>bx cs kube-versions</code>.</td>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated para tener recursos físicos disponibles dedicados solo a usted, o shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared.  Este valor es opcional para clústeres estándar y no está disponible para clústeres lite.</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>La ubicación en la que desea crear el clúster. Las ubicaciones disponibles dependen de la región de {{site.data.keyword.Bluemix_notm}} en la que haya iniciado la sesión. Para obtener el mejor rendimiento, seleccione la región que esté físicamente más cercana a su ubicación.  Este valor es obligatorio para clústeres estándar y opcional para clústeres lite.

<p>Consulte [ubicaciones disponibles](cs_regions.html#locations).
</p>

<p><strong>Nota:</strong> Si selecciona una ubicación que se encuentra fuera de su país, tenga en cuenta que es posible que se requiera autorización legal para poder almacenar datos físicamente en un país extranjero.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>El tipo de máquina tipo que elija afecta a la cantidad de memoria y al espacio de disco que está disponible para los contenedores desplegados en el nodo trabajador. Para ver una lista de los tipos de máquina disponibles, ejecute [bx cs machine-types <em>LOCATION</em>](#cs_machine_types).  Este valor es obligatorio para clústeres estándar y no está disponible para clústeres lite.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>El nombre del clúster.  Este valor es obligatorio.</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>La versión Kubernetes del nodo maestro del clúster. Este valor es opcional. Si no se especifica, el clúster se crea con el valor predeterminado de las versiones de Kubernetes soportadas. Para ver todas las versiones disponibles, ejecute <code>bx cs kube-versions</code>.</dd>

<dt><code>--no-subnet</code></dt>
<dd>De forma predeterminada, se crean tanto una subred pública portátil como una privada en la VLAN asociada con el clúster. Incluya el distintivo <code>--no-subnet</code> para evitar crear subredes con el clúster. Puede [crear](#cs_cluster_subnet_create) o [añadir](#cs_cluster_subnet_add) subredes a un clúster más adelante.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>Este parámetro no está disponible para clústeres lite.</li>
<li>Si este es el primer clúster estándar que crea en esta ubicación, no incluya este distintivo. Al crear clústeres se crea automáticamente una VLAN privada.</li>
<li>Si previamente ha creado un clúster estándar en esta ubicación o una VLAN privada en la infraestructura de IBM Cloud (SoftLayer), debe especificar la VLAN privada. <p><strong>Nota:</strong> Las VLAN pública y privada que especifique con el mandato create deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></li>
</ul>

<p>Para saber si ya tiene una VLAN privada para una ubicación específica o para encontrar el nombre de una VLAN privada existente, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>Este parámetro no está disponible para clústeres lite.</li>
<li>Si este es el primer clúster estándar que crea en esta ubicación, no utilice este distintivo. Al crear el clúster se crea automáticamente una VLAN pública.</li>
<li>Si previamente ha creado un clúster estándar en esta ubicación o una VLAN pública en la infraestructura de IBM Cloud (SoftLayer), debe especificar la VLAN pública. <p><strong>Nota:</strong> Las VLAN pública y privada que especifique con el mandato create deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></li>
</ul>

<p>Para saber si ya tiene una VLAN pública para una ubicación específica o para encontrar el nombre de una VLAN pública existente, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>El número de nodos trabajadores que desea desplegar en el clúster. Si no especifica esta opción, se crea un clúster con 1 nodo trabajador. Este valor es opcional para clústeres estándar y no está disponible para clústeres lite.

<p><strong>Nota:</strong> A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster. Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.</p></dd>
</dl>

**Ejemplos**:

  

  Ejemplo para un clúster estándar:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Ejemplo para un clúster lite:

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  Ejemplo para un entorno {{site.data.keyword.Bluemix_dedicated_notm}}:


  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER [--showResources]
{: #cs_cluster_get}

Ver información sobre un clúster de la organización.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>Muestra la VLAN y subredes correspondientes a un clúster.</dd>
   </dl>

**Ejemplo**:

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
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilice esta opción para forzar la eliminación de un clúster sin solicitudes de usuario. Este valor es opcional.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

Añadir un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.

**Sugerencia:** Para usuarios de {{site.data.keyword.Bluemix_dedicated_notm}}, consulte [Adición de servicios de {{site.data.keyword.Bluemix_notm}} a clústeres en {{site.data.keyword.Bluemix_dedicated_notm}} (Beta cerrada)](cs_cluster.html#binding_dedicated).

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>El nombre del espacio de Kubernetes. Este valor es obligatorio.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>El ID de la instancia de servicio de {{site.data.keyword.Bluemix_notm}} que desea vincular. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

Eliminar un servicio de {{site.data.keyword.Bluemix_notm}} de un clúster.

**Nota:** Cuando se elimina un servicio de {{site.data.keyword.Bluemix_notm}}, las credenciales del servicio se eliminan del clúster. Si un pod sigue utilizando el servicio, falla porque no encuentra las credenciales del servicio.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>El nombre del espacio de Kubernetes. Este valor es obligatorio.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>El ID de la instancia de servicio de {{site.data.keyword.Bluemix_notm}} que desea eliminar. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

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
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Incluya los servicios que están vinculados a un determinado espacio de nombres de un clúster. Este valor es opcional.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>Incluya los servicios que están vinculados a todos los espacios de nombres de un clúster. Este valor es opcional.</dd>
    </dl>

**Ejemplo**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

Poner la subred de la cuenta de una infraestructura de IBM Cloud (SoftLayer)
a disponibilidad de un determinado clúster.

**Nota:** Cuando se pone una subred a disponibilidad de un clúster, las direcciones IP de esta subred se utilizan para la gestión de redes del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containershort_notm}} al mismo tiempo.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>El ID de la subred. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs cluster-subnet-create CLUSTER SIZE VLAN_ID
{: #cs_cluster_subnet_create}

Crear una subred en una cuenta de infraestructura de IBM Cloud (SoftLayer) y ponerla a disponibilidad de un determinado clúster en {{site.data.keyword.containershort_notm}}.


**Nota:** Cuando se pone una subred a disponibilidad de un clúster, las direcciones IP de esta subred se utilizan para la gestión de redes del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containershort_notm}} al mismo tiempo.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio. Para obtener una lista de los clústeres, utilice el [mandato](#cs_clusters) `cs bx clusters`.</dd>

   <dt><code><em>SIZE</em></code></dt>
   <dd>El número de direcciones IP de la subred. Este valor es obligatorio. Los valores posibles son 8, 16, 32 o 64.</dd>

   <dt><code><em>VLAN_ID</em></code></dt>
   <dd>La VLAN en el que se va a crear la subred. Este valor es obligatorio. Para ver una lista de las VLAN disponibles, utilice el [mandato](#cs_vlans) `bx cs vlans <location>`.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs cluster-subnet-create my_cluster 8 1764905
  ```
  {: pre}

### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

Traer su propia subred privada a sus clústeres de {{site.data.keyword.containershort_notm}}.

Esta subred privada no es la que proporciona la infraestructura de IBM Cloud (SoftLayer). Por lo tanto, debe configurar el direccionamiento del tráfico de la red de entrada y de salida para la subred. Para añadir una subred de infraestructura de IBM Cloud (SoftLayer), utilice el [mandato](#cs_cluster_subnet_add) `bx cs cluster-subnet-add`.

**Nota:** Cuando añade una subred de usuario privada a un clúster, las direcciones IP de esta subred se utilizan para los equilibradores de carga privados del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containershort_notm}} al mismo tiempo.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>El Classless InterDomain Routing (CIDR) de la subred. Este valor es obligatorio y no debe estar en conflicto con ninguna subred que utilice la infraestructura de IBM Cloud (SoftLayer).    Los prefijos válidos son los comprendidos entre `/30` (1 dirección IP) y `/24` (253 direcciones IP). Si establece el valor de CIDR en una longitud de prefijo y luego lo tiene que modificar, añada primero un nuevo CIDR y luego [elimine el CIDR antiguo](#cs_cluster_user_subnet_rm).</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>El ID de la VLAN privada. Este valor es obligatorio. Debe coincidir con el ID de VLAN privada de uno o varios nodos trabajadores del clúster.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

Elimine su propia subred privada de un clúster especificado.

**Nota:** Cualquier servicio que se haya desplegado en una dirección IP desde su propia subred privada permanece activo después de que se elimine la subred.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>El Classless InterDomain Routing (CIDR) de la subred. Este valor es obligatorio y debe coincidir con el CIDR especificado mediante en [mandato](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add`.</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>El ID de la VLAN privada. Este valor es obligatorio y debe coincidir con el ID de VLAN especificado mediante en [mandato](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add`.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update]
{: #cs_cluster_update}

Actualice el Kubernetes maestro a la versión predeterminada de la API. Durante la actualización, no puede acceder ni cambiar el clúster. Los nodos trabajadores, las apps y los recursos que los usuarios del clúster han desplegado no se modifican y continúan ejecutándose.

Es posible que tenga que modificar los archivos YAML para futuros despliegues. Revise esta [nota del release](cs_versions.html) para ver detalles.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>
   
   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>La versión de Kubernetes del clúster. Si no se especifica este distintivo, el Kubernetes maestro se actualiza a la versión de la API predeterminada. Para ver todas las versiones disponibles, ejecute [bx cs kube-versions](#cs_kube_versions).Este valor es opcional.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilice esta opción para forzar la actualización del maestro sin solicitudes de usuario. Este valor es opcional.</dd>
   
   <dt><code>--force-update</code></dt>
   <dd>Intente la actualización incluso si el cambio es superior a dos versiones anteriores. Este valor es opcional.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Ver una lista de los clústeres de la organización.

<strong>Opciones del mandato</strong>:

  Ninguno

**Ejemplo**:

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

Defina las credenciales de cuenta de la infraestructura de IBM Cloud (SoftLayer) para su cuenta de {{site.data.keyword.Bluemix_notm}}. Estas credenciales permiten acceder a la cartera de infraestructura de IBM Cloud (SoftLayer) mediante su cuenta de {{site.data.keyword.Bluemix_notm}}.

**Nota:** No establezca varias credenciales para una cuenta de {{site.data.keyword.Bluemix_notm}}. Cada cuenta de {{site.data.keyword.Bluemix_notm}} está vinculada a un portafolio de la infraestructura de IBM Cloud (SoftLayer). 

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>Nombre usuario de la cuenta de infraestructura de IBM Cloud (SoftLayer). Este valor es obligatorio.</dd>
   

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>Clave de API de la cuenta de infraestructura de IBM Cloud (SoftLayer). Este valor es obligatorio.

 <p>
  Para generar una clave de API:

  <ol>
  <li>Inicie sesión en el [portal de la infraestructura de IBM Cloud (SoftLayer) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://control.softlayer.com/).</li>
  <li>Seleccione <strong>Cuenta</strong> y, a continuación, <strong>Usuarios</strong>.</li>
  <li>Pulse <strong>Generar</strong> para generar una clave de API de la infraestructura de IBM Cloud (SoftLayer) para su cuenta. </li>
  <li>Copie la clave de la API para utilizar en este mandato.</li>
  </ol>

  Para ver una clave de API existente:
  <ol>
  <li>Inicie sesión en el [portal de la infraestructura de IBM Cloud (SoftLayer) ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://control.softlayer.com/).</li>
  <li>Seleccione <strong>Cuenta</strong> y, a continuación, <strong>Usuarios</strong>.</li>
  <li>Pulse <strong>Ver</strong> para ver la clave de API existente.</li>
  <li>Copie la clave de la API para utilizar en este mandato.</li>
  </ol>
  </p></dd>
  </dl>

**Ejemplo**:

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Elimine las credenciales de cuenta de la infraestructura de IBM Cloud (SoftLayer) de su cuenta de {{site.data.keyword.Bluemix_notm}}. Después de eliminar las credenciales, ya no podrá acceder al portafolio de la infraestructura de IBM Cloud (SoftLayer) a través de su cuenta de {{site.data.keyword.Bluemix_notm}}.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplo**:

  ```
  bx cs credentials-unset
  ```
  {: pre}



### bx cs help
{: #cs_help}

Ver una lista de mandatos y parámetros admitidos.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplo**:

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
   <dd>El punto final de API de {{site.data.keyword.containershort_notm}} que desea utilizar.  Este valor es opcional. Ejemplos:

    <ul>
    <li>EE. UU. Sur:

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>EE.UU. Este:

    <pre class="codeblock">
    <code>bx cs init --host https://us-east.containers.bluemix.net</code>
    </pre>
    <p><strong>Nota</strong>: EE.UU.este solo se puede utilizar con mandatos de CLI.</p></li>

    <li>UK Sur:

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>UE Central:

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>AP Sur:

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>



### bx cs kube-versions
{: #cs_kube_versions}

Visualice una lista de las versiones de Kubernetes soportadas en {{site.data.keyword.containershort_notm}}. Actualice su [clúster maestro](#cs_cluster_update) y [nodos trabajadores](#cs_worker_update) a la versión predeterminada para obtener las prestaciones más estables y recientes.

**Opciones del mandato**:

  Ninguno

**Ejemplo**:

  ```
  bx cs kube-versions
  ```
  {: pre}

### bx cs locations
{: #cs_datacenters}

Ver una lista de las ubicaciones disponibles en las que puede crear un clúster.

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplo**:

  ```
  bx cs locations
  ```
  {: pre}

### bx cs logging-config-create CLUSTER --logsource LOG_SOURCE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME] [--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_create}

Crear una configuración de registro. De forma predeterminada, los registros de espacios de nombres se reenvían a {{site.data.keyword.loganalysislong_notm}}. Puede utilizar este mandato para reenviar los registros de espacios de nombres a un servidor syslog externo. También puede utilizar este mandato para reenviar los registros correspondientes a aplicaciones, nodos trabajadores, clústeres de Kubernetes y controladores Ingress a {{site.data.keyword.loganalysisshort_notm}} o a un servidor syslog externo.

<strong>Opciones del mandato</strong>:

<dl>
<dt><code><em>CLUSTER</em></code></dt>
<dd>El nombre o ID del clúster.</dd>
<dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
<dd>El origen de registro para el que desea habilitar el reenvío de registros. Los valores aceptados son <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>. Este valor es obligatorio.</dd>
<dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
<dd>El espacio de nombres del contenedor Docker desde el que desea reenviar registros a syslog. El reenvío de registros no recibe soporte para los espacios de nombres de Kubernetes <code>ibm-system</code> y <code>kube-system</code>. Este valor es obligatorio para los espacios de nombres. Si no especifica un espacio de nombres, todos los espacios de nombres del contenedor utilizarán esta configuración.</dd>
<dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
<dd>El nombre de host o dirección IP del servidor del recopilador de registro. Este valor es obligatorio cuando el tipo de registro es <code>syslog</code>.</dd>
<dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
<dd>El puerto del servidor del recopilador de registro. Este valor es opcional cuando el tipo de registro es <code>syslog</code>. Si no especifica un puerto, se utiliza el puerto estándar <code>514</code> para <code>syslog</code>.</dd>
<dt><code>--type <em>LOG_TYPE</em></code></dt>
<dd>El protocolo de reenvío de registros que desea utilizar. Actualmente se da soporte a <code>syslog</code> e <code>ibm</code>. Este valor es obligatorio.</dd>
</dl>

**Ejemplos**:

Ejemplo para el origen de registro `namespace`:

  ```
  bx cs logging-config-create my_cluster --logsource namespaces --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}

Ejemplo para el origen de registro `ingress`:

  ```
  bx cs logging-config-create my_cluster --logsource ingress --type ibm
  ```
  {: pre}

### bx cs logging-config-get CLUSTER [--logsource LOG_SOURCE]
{: #cs_logging_get}

Vea todas las configuraciones de reenvío de registro para un clúster, o filtre las configuraciones de registro en función del origen del registro.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>
   <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
   <dd>El tipo de origen de registro que desea filtrar. Sólo se devolverán las configuraciones de registro de este origen de registro en el clúster. Los valores aceptados son <code>namespaces</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>. Este valor es opcional.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs logging-config-get my_cluster --logsource worker
  ```
  {: pre}


### bx cs logging-config-rm CLUSTER --id LOG_CONFIG_ID
{: #cs_logging_rm}

Suprime una configuración de reenvío de registro. Para un espacio de contenedores Docker, puede detener el reenvío de registros a un servidor syslog. El espacio de nombres sigue reenviando registros a {{site.data.keyword.loganalysislong_notm}}. Por un origen de registro que no sea un espacio de contenedores Docker, puede detener el reenvío de registros a un servidor syslog o a {{site.data.keyword.loganalysisshort_notm}}.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>El ID de configuración de registro que desea eliminar del origen de registro. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs logging-config-rm my_cluster --id my_log_config_id
  ```
  {: pre}


### bx cs logging-config-update CLUSTER [--namespace NAMESPACE][--id LOG_CONFIG_ID] [--hostname LOG_SERVER_HOSTNAME][--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_update}

Actualice el reenvío de registro al servidor de registro que desea utilizar. Para un espacio de nombres del contenedor Docker, puede utilizar este mandato para actualizar los detalles del servidor syslog actual o para cambiar a otro servidor syslog. Para un origen de registro que no sea un espacio de nombres de contenedores Docker, puede utilizar este mandato para cambiar el tipo de servidor del recolector de registros. Actualmente, 'syslog' e 'ibm' son los tipos de registro soportados.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>
   <dt><code>--namespace <em>NAMESPACE</em></code></dt>
   <dd>El espacio de nombres del contenedor Docker desde el que desea reenviar registros a syslog. El reenvío de registros no recibe soporte para los espacios de nombres de Kubernetes <code>ibm-system</code> y <code>kube-system</code>. Este valor es obligatorio para los espacios de nombres.</dd>
   <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>El ID de configuración de registro que desea actualizar. Este valor es obligatorio para los orígenes de registro que no sean espacios de nombres de contenedores Docker.</dd>
   <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>El nombre de host o dirección IP del servidor del recopilador de registro. Este valor es obligatorio cuando el tipo de registro es <code>syslog</code>.</dd>
   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>El puerto del servidor del recopilador de registro. Este valor es opcional cuando el tipo de registro es <code>syslog</code>. Si no especifica un puerto, se utiliza el puerto estándar 514 para <code>syslog</code>.</dd>
   <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>El protocolo de reenvío de registros que desea utilizar. Actualmente se da soporte a <code>syslog</code> e <code>ibm</code>. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo de registro de tipo `ibm`**:

  ```
  bx cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Ejemplo de registro de tipo `syslog`**:

  ```
  bx cs logging-config-update my_cluster --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### bx cs machine-types LOCATION
{: #cs_machine_types}

Ver una lista de los tipos de máquinas disponibles para sus nodos trabajadores. Cada tipo de máquina incluye cantidad de CPU virtual, memoria y espacio de disco para cada nodo trabajador del clúster. 
- Los tipos de máquina con `u2c` o `b2c` en el nombre utilizan el disco local en lugar de la SAN por motivos de fiabilidad. Entre las ventajas de fiabilidad se incluyen un mejor rendimiento al serializar bytes en el disco local y una reducción de la degradación del sistema de archivos debido a anomalías de la red. Este tipo de máquinas contienen 25 GB de almacenamiento en disco local para el sistema de archivos de SO y 100 GB de almacenamiento en disco local para `/var/lib/docker`, el directorio en el que se graban todos los datos del contenedor. 
- Los tipos de máquinas que incluyen `cifrado` en el nombre cifran los datos de docker del host. El directorio `/var/lib/docker`, donde están almacenados todos los datos de los contenedores, están cifrados mediante LUKS.
- Los tipos de máquinas con `u1c` o `b1c` en el nombre están en desuso, como, por ejemplo,`u1c.2x4`. Para empezar a utilizar los tipos de máquinas `u2c` y `b2c`, utilice el mandato `bx cs worker-add` para añadir nodos trabajadores con el tipo de máquina actualizado. A continuación, elimine los nodos trabajadores que utilizan los tipos de máquinas en desuso mediante el mandato `bx cs worker-rm`.
</p>


<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>Especifique la ubicación de la que desea ver una lista de tipos de máquina disponibles. Este valor es obligatorio. Consulte [ubicaciones disponibles](cs_regions.html#locations).</dd></dl>

**Ejemplo**:

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Ver una lista de subredes que están disponibles en una cuenta de infraestructura de IBM Cloud (SoftLayer). 

<strong>Opciones del mandato</strong>:

   Ninguno

**Ejemplo**:

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

Crear una lista de las VLAN públicas y privadas disponibles para una ubicación en la cuenta de infraestructura de IBM Cloud (SoftLayer). Para ver una lista de las VLAN disponibles,
debe tener una cuenta de pago.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>Escriba la ubicación donde desea listar sus VLAN públicas y privadas. Este valor es obligatorio. Consulte [ubicaciones disponibles](cs_regions.html#locations).</dd>
   </dl>

**Ejemplo**:

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
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>El nivel de notificación, como por ejemplo <code>Normal</code> o <code>Warning</code>. <code>Warning</code> es el valor predeterminado. Este valor es opcional.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>El tipo de webhook, como por ejemplo slack. Solo se admite slack. Este valor es obligatorio.</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>El URL del webhook. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

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
<dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>La vía de acceso al archivo YAML para añadir nodos trabajadores a su clúster. En lugar de definir los nodos trabajadores adicionales mediante las opciones que se proporcionan en este mandato, puede utilizar un archivo YAML. Este valor es opcional.

<p><strong>Nota:</strong> Si especifica la misma opción en el mandato y como parámetro en el archivo YAML, el valor en el mandato prevalece sobre el valor del archivo YAML. Por ejemplo, supongamos que define un tipo de máquina en el archivo YAML y utiliza la opción --machine-type en el mandato; el valor que especifique en la opción del mandato prevalece sobre el valor del archivo YAML.

<pre class="codeblock">
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
<th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Sustituya <code><em>&lt;cluster_name_or_id&gt;</em></code> por el nombre o ID del clúster donde desea añadir nodos trabajadores.</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>Sustituya <code><em>&lt;location&gt;</em></code> por la ubicación en la que desea desplegar los nodos trabajadores. Las ubicaciones disponibles dependen de la región en la que ha iniciado la sesión. Para ver una lista de las ubicaciones disponibles, ejecute <code>cs bx ubicaciones</code>.</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Sustituya <code><em>&lt;machine_type&gt;</em></code> por el tipo de máquina que desea utilizar para los nodos trabajadores. Para ver una lista de los tipos de máquina disponibles para su ubicación, ejecute <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Sustituya <code><em>&lt;private_vlan&gt;</em></code> por el ID de la VLAN privada que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans <em>&lt;location&gt;</em></code> y busque direccionadores de VLAN que empiecen por <code>bcr</code> ("back-end router", direccionador de fondo).</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Sustituya <code>&lt;public_vlan&gt;</code> por el ID de la VLAN pública que desea utilizar para sus nodos trabajadores. Para ver una lista de las VLAN disponibles, ejecute <code>bx cs vlans&lt;location&gt;</code> y busque direccionadores de VLAN que empiecen por <code>fcr</code> ("front-end router", direccionador frontal).</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated si desea tener recursos físicos disponibles dedicados solo a usted, o el valor shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Sustituya <code><em>&lt;number_workers&gt;</em></code> por el número de nodos trabajadores que desea desplegar.</td>
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated si desea tener recursos físicos disponibles dedicados solo a usted, o el valor shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared. Este valor es opcional.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>El tipo de máquina tipo que elija afecta a la cantidad de memoria y al espacio de disco que está disponible para los contenedores desplegados en el nodo trabajador. Este valor es obligatorio. Para ver una lista de los tipos de máquina disponibles, ejecute [bx cs machine-types LOCATION](#cs_machine_types).</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>Un entero que representa el número de nodos trabajadores que desea crear en el clúster. El valor predeterminado es 1. Este valor es opcional.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>La VLAN privada que se ha especificado al crear el clúster. Este valor es obligatorio.

<p><strong>Nota:</strong> Las VLAN pública y privada que especifique deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>La VLAN pública que se ha especificado al crear el clúster. Este valor es opcional.

<p><strong>Nota:</strong> Las VLAN pública y privada que especifique deben coincidir. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. No utilice VLAN públicas y privadas que no coincidan para crear un clúster.</p></dd>
</dl>

**Ejemplos**:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --hardware shared
  ```
  {: pre}

  Ejemplo para {{site.data.keyword.Bluemix_dedicated_notm}}:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u2c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

Ver detalles de un nodo trabajador.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><code><em>WORKER_NODE_ID</em></code></dt>
   <dd>El ID de un nodo trabajador. Ejecute <code>bx cs workers <em>CLUSTER</em></code> para ver los ID de los nodos
trabajadores de un clúster. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

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
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilice esta opción para forzar el reinicio de un nodo trabajador sin solicitudes de usuario. Este valor es opcional.</dd>

   <dt><code>--hard</code></dt>
   <dd>Utilice esta opción para forzar un reinicio de un nodo trabajador, cortando el suministro eléctrico al nodo trabajador. Utilice esta opción si el nodo trabajador no responde o si tiene un bloqueo de Docker. Este valor es opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>El nombre o ID de uno o varios nodos trabajadores. Utilice un espacio para ver una lista de varios nodos trabajadores. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

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
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilice esta opción para forzar que se vuelva a cargar un nodo trabajador sin solicitudes de usuario. Este valor es opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>El nombre o ID de uno o varios nodos trabajadores. Utilice un espacio para ver una lista de varios nodos trabajadores. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

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
   <dd>El nombre o ID del clúster. Este valor es obligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilice esta opción para forzar la eliminación de un nodo trabajador sin solicitudes de usuario. Este valor es opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>El nombre o ID de uno o varios nodos trabajadores. Utilice un espacio para ver una lista de varios nodos trabajadores. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update]
{: #cs_worker_update}

Actualizar nodos trabajadores a la última versión Kubernetes. La ejecución de `bx cs worker-update` puede causar un tiempo de inactividad para sus apps y servicios. Durante la actualización, todos los pods se vuelven a planificar en otros nodos trabajadores y los datos se suprimen si no se guardan fuera del pod. Para evitar el tiempo de inactividad, asegúrese de tener suficientes nodos trabajadores para manejar la carga de trabajo mientras se estén actualizando los nodos trabajador seleccionados.

Es posible que tenga que modificar los archivos YAML para futuros despliegues antes de la actualización. Revise esta [nota del release](cs_versions.html) para ver detalles.

<strong>Opciones del mandato</strong>:

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>El nombre o ID del clúster en el que se listan los nodos trabajadores disponibles. Este valor es obligatorio.</dd>
   
   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>La versión de Kubernetes del clúster. Si no se especifica este distintivo, el nodo maestro se actualiza a la versión predeterminada. Para ver todas las versiones disponibles, ejecute [bx cs kube-versions](#cs_kube_versions).Este valor es opcional.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilice esta opción para forzar la actualización del maestro sin solicitudes de usuario. Este valor es opcional.</dd>
   
   <dt><code>--force-update</code></dt>
   <dd> Intente la actualización incluso si el cambio es superior a dos versiones anteriores. Este valor es opcional.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>El ID de uno o varios nodos trabajadores. Utilice un espacio para ver una lista de varios nodos trabajadores. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs worker-update my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Ver una lista de los nodos trabajadores y el estado de cada uno de ellos en un clúster.

<strong>Opciones del mandato</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>El nombre o ID del clúster en el que se listan los nodos trabajadores disponibles. Este valor es obligatorio.</dd>
   </dl>

**Ejemplo**:

  ```
  bx cs workers mycluster
  ```
  {: pre}

<br />


## Estados de un clúster
{: #cs_cluster_states}

Puede ver el estado actual del clúster ejecutando el mandato bx cs clusters y localizando el campo **State**. El estado del clúster proporciona información sobre la disponibilidad y la capacidad del clúster, y posibles problemas que puedan haberse producido.
{:shortdesc}

|Estado del clúster|Motivo|
|-------------|------|
|Despliegue|El nodo Kubernetes maestro no está completamente desplegado. No puede acceder a su clúster.|
|Pendiente|El nodo Kubernetes maestro está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.|
|Normal|Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster.|
|Aviso|Al menos un nodo trabajador del clúster no está disponible, pero los otros nodos trabajadores están disponibles y pueden asumir la carga de trabajo. <ol><li>Obtenga una lista de los nodos trabajadores del clúster y anote el ID de los nodos trabajadores con el estado <strong>Aviso</strong>.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Obtenga los detalles de un nodo trabajador.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Revise los campos <strong>State</strong>, <strong>Status</strong> y <strong>Details</strong> para ver el problema raíz por el que el nodo trabajador está inactivo.</li><li>Si el nodo trabajador casi ha alcanzado el límite de memoria o de espacio de disco, reduzca la carga de trabajo del nodo trabajador o añada un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</li></ol>|
|Crítico|No se puede acceder al nodo Kubernetes maestro o todos los nodos trabajadores del clúster están inactivos. <ol><li>Obtenga una lista de los nodos trabajadores del clúster.<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>Obtener los detalles de cada nodo trabajador.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Revise los campos <strong>State</strong>, <strong>Status</strong> y <strong>Details</strong> para ver el problema raíz por el que el nodo trabajador está inactivo.</li><li>Si el estado del nodo trabajador es <strong>Provision_failed</strong>, es posible que no tenga los permisos necesarios para suministrar un nodo trabajador desde el portafolio de infraestructura de IBM Cloud (SoftLayer). Para ver los permisos necesarios, consulte [Configuración del acceso al portafolio de infraestructura de IBM Cloud (SoftLayer) para crear clústeres de Kubernetes estándares](cs_planning.html#cs_planning_unify_accounts). </li><li>Si el estado del nodo trabajador es <strong>Critical</strong> y el estado del nodo trabajador es <strong>Out of disk (Sin disco)</strong>, significa que el nodo trabajador ha agotado su capacidad. Puede reducir la carga de trabajo del nodo trabajador o añadir un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</li><li>Si el estado del nodo trabajador es <strong>Critical</strong> y el estado del nodo trabajador es <strong>Unknown (Desconocido)</strong>, significa que el nodo Kubernetes maestro no está disponible. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ol>|
{: caption="Tabla 3. Estados de un clúster" caption-side="top"}
