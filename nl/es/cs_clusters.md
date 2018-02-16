---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuración de clústeres
{: #clusters}

Diseñe la configuración de su clúster para maximizar su disponibilidad y capacidad.
{:shortdesc}


## Planificación de configuración de clúster
{: #planning_clusters}

Utilice clústeres estándares para incrementar la disponibilidad de las apps. Si distribuye su configuración entre varios clústeres y nodos trabajadores, es menos probable que los usuarios experimenten un tiempo de inactividad del sistema. Características incorporadas como, por ejemplo, el aislamiento y el equilibrio de carga, incrementan la resiliencia con relación a posibles anomalías con hosts, redes o apps.
{:shortdesc}

Revise estas configuraciones potenciales de clústeres que están ordenadas por grados de disponibilidad en orden ascendente:

![Etapas de alta disponibilidad de un clúster](images/cs_cluster_ha_roadmap.png)

1.  Un clúster con varios nodos trabajadores
2.  Dos clústeres que se ejecutan en distintas ubicaciones de la misma región, cada uno con varios nodos trabajadores
3.  Dos clústeres que se ejecutan en distintas regiones, cada uno con varios nodos trabajadores

Aumente la disponibilidad del clúster con estas técnicas:

<dl>
<dt>Distribuya las apps entre nodos trabajadores</dt>
<dd>Permita que los desarrolladores distribuyan sus apps en contenedores entre varios nodos trabajadores por clúster. Una instancia de app en cada uno de los tres nodos trabajadores permite que se produzca el tiempo de inactividad de un nodo trabajador sin que se interrumpa el uso de la app. Puede especificar el número de nodos trabajadores que desea incluir al crear un clúster desde la GUI de [{{site.data.keyword.Bluemix_notm}} o desde la ](cs_clusters.html#clusters_ui) [CLI](cs_clusters.html#clusters_cli). Kubernetes limita el número máximo de nodos trabajadores que puede tener en un clúster, así que debe tener en cuenta las [cuotas de pod y nodo trabajador ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/cluster-large/).
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>Distribuya las apps entre clústeres</dt>
<dd>Cree varios clústeres, cada uno con varios nodos trabajadores. Si se produce una interrupción en un clúster, los usuarios pueden acceder a una app que también está desplegada en otro clúster.
<p>Clúster
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Clúster
2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>Distribuya las apps entre clústeres de distintas regiones</dt>
<dd>Si distribuye las apps entre clústeres de distintas regiones, permite que se equilibre la carga
en función de la región en la que se encuentra el usuario. Si el clúster, el hardware, o incluso toda la ubicación de una región pasa a estar inactivo, el tráfico se redirecciona al contenedor desplegado en otro centro de datos.
<p><strong>Importante:</strong> Después de configurar un dominio personalizado, puede utilizar estos mandatos para crear los clústeres.</p>
<p>Ubicación
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Ubicación 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />


## Planificación de la configuración de nodos trabajadores
{: #planning_worker_nodes}

Un clúster de Kubernetes está formado por nodos trabajadores y está supervisado y gestionado de forma centralizada desde el maestro de Kubernetes. Los administradores del clúster deciden cómo configurar el clúster de nodos trabajadores para garantizar que los usuarios del clúster disponen de todos los recursos para desplegar y ejecutar las apps en el clúster.
{:shortdesc}

Cuando se crea un clúster estándar, los nodos trabajadores se ordenan en la infraestructura de IBM Cloud (SoftLayer) en su nombre y se configuran en {{site.data.keyword.Bluemix_notm}}. A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar después de haber creado el clúster. En función del nivel de aislamiento de hardware que elija, los nodos trabajadores se puede configurar como nodos compartidos o dedicados. Cada nodo trabajador se suministra con un tipo de máquina específico que determina el número de vCPU, la memoria y el espacio en disco que están disponibles para los contenedores que se despliegan en el nodo trabajador. Kubernetes limita el número máximo de nodos trabajadores que puede tener en un clúster. Consulte el apartado sobre [nodo trabajador y cuotas de pod ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/cluster-large/) para obtener más información.


### Hardware de los nodos trabajadores
{: #shared_dedicated_node}

Cada nodo trabajador se configura como una máquina virtual en el hardware físico. Cuando se crea un clúster estándar en {{site.data.keyword.Bluemix_notm}}, debe seleccionar si desea que el hardware subyacente se comparta entre varios clientes de {{site.data.keyword.IBM_notm}} (tenencia múltiple) o se le dedique a usted exclusivamente (tenencia única).
{:shortdesc}

En una configuración de tenencia múltiple, los recursos físicos, como CPU y memoria, se comparten entre todas las máquinas virtuales desplegadas en el mismo hardware físico. Para asegurarse de que cada máquina virtual se pueda ejecutar de forma independiente, un supervisor de máquina virtual, también conocido como hipervisor, segmenta los recursos físicos en entidades aisladas y los asigna como recursos dedicados a una máquina virtual (aislamiento de hipervisor).

En una configuración de tenencia única, se dedican al usuario todos los recursos físicos. Puede desplegar varios nodos trabajadores como máquinas virtuales en el mismo host físico. De forma similar a la configuración de tenencia múltiple,
el hipervisor asegura que cada nodo trabajador recibe su parte compartida de los recursos físicos disponibles.

Los nodos compartidos suelen resultar más económicos que los nodos dedicados porque los costes del hardware subyacente se comparten entre varios clientes. Sin embargo, cuando decida entre nodos compartidos y dedicados, debe ponerse en contacto con el departamento legal y ver el nivel de aislamiento y de conformidad de la infraestructura que necesita el entorno de app.

Cuando se crea un clúster lite, el nodo trabajador se suministra automáticamente como nodo compartido en la cuenta de infraestructura de IBM Cloud (SoftLayer).

### Límites de memoria de nodos trabajadores
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} establece un límite de memoria en cada nodo trabajador. Cuando los pods que se ejecutan en el nodo trabajador superan este límite de memoria, se eliminan los pods. En Kubernetes, este límite se llama [umbral de desalojo de hardware ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Si los pods se eliminan con frecuencia, añada más nodos trabajadores al clúster o establezca [límites de recurso ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) a los pods.

Cada tipo de máquina tiene una capacidad de memoria distinta. Cuando hay menos memoria disponible en el nodo trabajador que el umbral mínimo permitido, Kubernetes elimina inmediatamente el pod. El pod vuelve a planificar el nodo trabajador si hay uno disponible.

|Capacidad de la memoria del nodo trabajador|Umbral de memoria mínima de un nodo trabajador|
|---------------------------|------------|
|4 GB  | 256 MB |
|16 GB | 1024 MB |
|64 GB | 4096 MB |
|128 GB| 4096 MB |
|242 GB| 4096 MB |

Para revisar cuánta memoria se utiliza en el nodo de trabajador, ejecute [kubectl top node ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top).



<br />



## Creación de clústeres con la GUI
{: #clusters_ui}

Un clúster de Kubernetes es un conjunto de nodos trabajadores organizados en una red. La finalidad del clúster es definir un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantengan la alta disponibilidad de las aplicaciones. Para poder desplegar una app, debe crear un clúster y establecer las definiciones de los nodos trabajadores en dicho clúster.
{:shortdesc}

Para crear un clúster:
1. En el catálogo, seleccione **Clúster de Kubernetes**.
2. Seleccione un tipo de plan de clúster. Puede elegir **Lite** o **Pago según uso**. Con el plan Pago según uso, puede suministrar un clúster estándar con características como varios nodos trabajadores para obtener un entorno de alta disponibilidad.
3. Configure los detalles del clúster.
    1. Asigne un nombre al clúster, seleccione una versión de Kubernetes y seleccione una ubicación en la que desplegarlo. Seleccione la ubicación físicamente más cercana para obtener el mejor rendimiento. Tenga en cuenta que es posible que se requiera autorización legal para poder almacenar datos físicamente en un país extranjero si selecciona una ubicación fuera del país.
    2. Seleccione un tipo de máquina y especifique el número de nodos trabajadores que necesita. El tipo de máquina define la cantidad de memoria y CPU virtual que se configura en cada nodo trabajador y que está disponible para todos los contenedores.
        - El tipo de máquina micro indica la opción más pequeña.
        - La máquina equilibradas tiene la misma cantidad de memoria asignada a cada CPU, lo que optimiza el rendimiento.
        - De forma predeterminada, los datos de Docker del host están cifrados en los tipos de máquina. El directorio `/var/lib/docker`, donde están almacenados todos los datos de los contenedores, están cifrados mediante LUKS. Si la opción `disable-disk-encrypt` se incluye durante la creación de clústeres, los datos de Docker del host no se cifrarán. [Más información sobre el cifrado.](cs_secure.html#encrypted_disks)
    3. Seleccione una VLAN pública y privada en la cuenta de infraestructura de IBM Cloud (SoftLayer). Ambas VLAN comunican entre nodos trabajadores, pero la VLAN pública también se comunica con el Kubernetes maestro gestionado por IBM. Puede utilizar la misma VLAN para varios clústeres.
        **Nota**: Si elige no seleccionar una VLAN pública, debe configurar una solución alternativa.
    4. Seleccione un tipo de hardware. El hardware compartido es una opción suficiente para la mayoría de las situaciones.
        - **Dedicado**: Garantiza el aislamiento completo de sus recursos físicos.
        - **Compartido**: Permite almacenar sus recursos físicos en el mismo hardware que otros clientes de IBM.
4. Pulse **Crear clúster**. Verá el progreso del despliegue del nodo trabajador en el separador **Nodos trabajadores**. Cuando finalice el despliegue, podrá ver que el clúster está listo en el separador **Visión general**.
    **Nota:** A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster. Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.


**¿Qué es lo siguiente?**

Cuando el clúster esté activo y en ejecución, puede realizar las siguientes tareas:

-   [Instalar las CLI para empezar a trabajar con el clúster.](cs_cli_install.html#cs_cli_install)
-   [Desplegar una app en el clúster.](cs_app.html#app_cli)
-   [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}}
para almacenar y compartir imágenes de Docker con otros usuarios. ](/docs/services/Registry/index.html)
- Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](cs_firewall.html#firewall) para utilizar los mandatos `bx`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.

<br />


## Creación de clústeres con la CLI
{: #clusters_cli}

Un clúster es un conjunto de nodos trabajadores organizados en una red. La finalidad del clúster es definir un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantengan la alta disponibilidad de las aplicaciones. Para poder desplegar una app, debe crear un clúster y establecer las definiciones de los nodos trabajadores en dicho clúster.
{:shortdesc}

Para crear un clúster:
1.  Instale la CLI de {{site.data.keyword.Bluemix_notm}} y el plug-in de [{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Escriba
sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite.

    ```
    bx login
    ```
    {: pre}

    **Nota:** Si tiene un ID federado, utilice `bx login --sso` para iniciar
la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.

3. Si tiene varias cuentas de {{site.data.keyword.Bluemix_notm}}, seleccione la cuenta donde desea crear el clúster de Kubernetes.

4.  Si desea crear o acceder a clústeres de Kubernetes en una región distinta de la región de {{site.data.keyword.Bluemix_notm}} seleccionada anteriormente, ejecute `bx cs region-set`.

6.  Cree un clúster.
    1.  Revise las ubicaciones que están disponibles. Las ubicaciones que se muestran dependen de la región de {{site.data.keyword.containershort_notm}} en la que ha iniciado la sesión.

        ```
        bx cs locations
        ```
        {: pre}

        La salida de la CLI coincide con las [ubicaciones correspondientes a la región del contenedor](cs_regions.html#locations).

    2.  Elija una ubicación y revise los tipos de máquinas disponibles en dicha ubicación. El tipo de máquina especifica los recursos de cálculo virtuales que están disponibles para cada nodo trabajador.

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Compruebe si ya existe una VLAN pública y privada en la infraestructura de IBM Cloud (SoftLayer) para esta cuenta.

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router
        1519999   vlan   1355     private   bcr02a.dal10
        1519898   vlan   1357     private   bcr02a.dal10
        1518787   vlan   1252     public   fcr02a.dal10
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        Si ya existe una VLAN pública y privada, anote los direccionadores correspondientes. Los direccionadores VLAN privados siempre empiezan por `bcr` (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre empiezan por `fcr` (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster. En la salida de ejemplo, se puede utilizar cualquier VLAN privada con cualquier VLAN pública porque todos los direccionadores incluyen `02a.dal10`.

    4.  Ejecute el mandato `cluster-create`. Puede elegir entre un clúster lite, que incluye un nodo trabajador configurado con 2 vCPU y 4 GB de memoria, o un clúster estándar, que puede incluir tantos nodos trabajadores como desee en la cuenta de infraestructura de IBM Cloud (SoftLayer). Cuando se crea un clúster estándar, de forma predeterminada, los discos del nodo trabajador están cifrados, su hardware se comparte entre varios clientes de IBM y se factura por horas de uso. </br>Ejemplo para un clúster estándar:

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch> 
        ```
        {: pre}

        Ejemplo para un clúster lite:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Tabla. Visión general de los componentes del mandato <code>bx cs cluster-create</code></caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>El mandato para crear un clúster en la organización de {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>Sustituya <em>&lt;location&gt;</em> por el ID de ubicación de {{site.data.keyword.Bluemix_notm}} donde desea crear el clúster. Las [ubicaciones disponibles](cs_regions.html#locations) dependen de la región de {{site.data.keyword.containershort_notm}} en la que ha iniciado la sesión.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Si está creando un clúster estándar, elija un tipo de máquina. El tipo de máquina especifica los recursos de cálculo virtuales que están disponibles para cada nodo trabajador. Consulte el apartado sobre [Comparación entre los clústeres lite y estándar para {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types) para obtener más información. Para los clústeres de tipo lite, no tiene que definir el tipo de máquina.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Para los clústeres de tipo lite, no tiene que definir una VLAN pública. El clúster lite se conecta automáticamente a una VLAN pública propiedad de IBM.</li>
          <li>Para un clúster estándar, si ya tiene una VLAN pública configurada en su cuenta de infraestructura de IBM Cloud (SoftLayer) para esta ubicación, escriba el ID de la VLAN pública. Si aún no tiene una VLAN pública y privada en esta ubicación, no especifique esta opción. {{site.data.keyword.containershort_notm}} crea automáticamente una VLAN pública.<br/><br/>
          <strong>Nota</strong>: Los direccionadores VLAN privados siempre empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Para los clústeres de tipo lite, no tiene que definir una VLAN privada. El clúster lite se conecta automáticamente a una VLAN privada propiedad de IBM.</li><li>Para un clúster estándar, si ya tiene una VLAN privada configurada en su cuenta de infraestructura de IBM Cloud (SoftLayer) para esta ubicación, escriba el ID de la VLAN privada. Si aún no tiene una VLAN pública y privada en esta ubicación, no especifique esta opción. {{site.data.keyword.containershort_notm}} crea automáticamente una VLAN pública.<br/><br/><strong>Nota</strong>: Los direccionadores VLAN privados siempre empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre empiezan por <code>fcr</code> (direccionador frontal). La combinación de números y letras que hay tras estos prefijos debe coincidir para poder utilizar dichas VLAN al crear un clúster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Sustituya <em>&lt;name&gt;</em> por el nombre del clúster.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>El número de nodos trabajadores que desea incluir en el clúster. Si no se especifica la opción <code>--workers</code>, se crea 1 nodo trabajador.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>La versión Kubernetes del nodo maestro del clúster. Este valor es opcional. Si no se especifica, el clúster se crea con el valor predeterminado de las versiones de Kubernetes soportadas. Para ver todas las versiones disponibles, ejecute <code>bx cs kube-versions</code>.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>Los nodos de trabajador tienen cifrado de disco de forma predeterminada; [más información](cs_secure.html#encrypted_disks). Si desea inhabilitar el cifrado, incluya esta opción.</td>
        </tr>
        </tbody></table>

7.  Verifique que ha solicitado la creación del clúster.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** Puede llevar hasta 15 minutos la ordenación de las máquinas del nodo trabajador y la configuración y suministro del clúster
en su cuenta.

    Una vez completado el suministro del clúster, el estado del clúster pasa a ser **deployed**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

8.  Compruebe el estado de los nodos trabajadores.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Cuando los nodos trabajadores están listos, el estado pasa a **normal** y el estado es **Ready**. Cuando el estado del nodo sea **Preparado**, podrá acceder al clúster.

    **Nota:** A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster. Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. Defina el clúster que ha creado como contexto para esta sesión. Siga estos pasos de configuración cada vez que de trabaje con el clúster.
    1.  Obtenga el mandato para establecer la variable de entorno y descargar los archivos de configuración de Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Cuando termine la descarga de los archivos de configuración, se muestra un mandato que puede utilizar para establecer la vía de acceso al archivo de configuración de
Kubernetes como variable de entorno.

        Ejemplo para OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  Copie y pegue el mandato que se muestra en el terminal para definir la variable de entorno `KUBECONFIG`.
    3.  Compruebe que la variable de entorno `KUBECONFIG` se haya establecido correctamente.

        Ejemplo para OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Salida:

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

10. Inicie el panel de control de Kubernetes con el puerto predeterminado `8001`.
    1.  Establezca el proxy con el número de puerto predeterminado.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Abra el siguiente URL en un navegador web para ver el panel de control de Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**¿Qué es lo siguiente?**

-   [Desplegar una app en el clúster.](cs_app.html#app_cli)
-   [Gestionar el clúster con la línea de mandatos de `kubectl`. ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}}
para almacenar y compartir imágenes de Docker con otros usuarios. ](/docs/services/Registry/index.html)
- Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](cs_firewall.html#firewall) para utilizar los mandatos `bx`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.

<br />


## Estados de un clúster
{: #states}

Puede ver el estado actual del clúster ejecutando el mandato `bx cs clusters` y localizando el campo **State**. El estado del clúster proporciona información sobre la disponibilidad y la capacidad del clúster, y posibles problemas que puedan haberse producido.
{:shortdesc}

|Estado del clúster|Motivo|
|-------------|------|
|Despliegue|El nodo Kubernetes maestro no está completamente desplegado. No puede acceder a su clúster.|
|Pendiente|El nodo Kubernetes maestro está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.|
|Normal|Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster.|
|Aviso|Al menos un nodo trabajador del clúster no está disponible, pero los otros nodos trabajadores están disponibles y pueden asumir la carga de trabajo. <ol><li>Obtenga una lista de los nodos trabajadores del clúster y anote el ID de los nodos trabajadores con el estado <strong>Aviso</strong>.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Obtenga los detalles de un nodo trabajador.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Revise los campos <strong>State</strong>, <strong>Status</strong> y <strong>Details</strong> para ver el problema raíz por el que el nodo trabajador está inactivo.</li><li>Si el nodo trabajador casi ha alcanzado el límite de memoria o de espacio de disco, reduzca la carga de trabajo del nodo trabajador o añada un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</li></ol>|
|Crítico|No se puede acceder al nodo Kubernetes maestro o todos los nodos trabajadores del clúster están inactivos. <ol><li>Obtenga una lista de los nodos trabajadores del clúster.<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>Obtener los detalles de cada nodo trabajador.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Revise los campos <strong>State</strong> y <strong>Status</strong> para ver el problema raíz por el que el nodo trabajador está inactivo.<ul><li>Si el estado del nodo trabajador es <strong>Provision_failed</strong>, es posible que no tenga los permisos necesarios para suministrar un nodo trabajador desde el portafolio de infraestructura de IBM Cloud (SoftLayer). Para ver los permisos necesarios, consulte [Configuración del acceso al portafolio de infraestructura de IBM Cloud (SoftLayer) para crear clústeres de Kubernetes estándares](cs_infrastructure.html#unify_accounts).</li><li>Si el campo state del nodo trabajador es <strong>Critical</strong> y el campo status es <strong>Not Ready</strong>, significa que puede que el nodo trabajador no pueda conectarse a la infraestructura de IBM Cloud (SoftLayer). Para resolver el problema, empiece ejecutando <code>bx cs worker-reboot --hard CLUSTER WORKER</code>. Si el mandato no resuelve el problema, ejecute <code>bx cs worker reload CLUSTER WORKER</code>.</li><li>Si el campo state del nodo trabajador es <strong>Critical</strong> y el campo status es <strong>Out of disk</strong>, significa que el nodo trabajador ha agotado su capacidad. Puede reducir la carga de trabajo del nodo trabajador o añadir un nodo trabajador al clúster para ayudar a equilibrar la carga de trabajo.</li><li>Si el campo state del nodo trabajador es <strong>Critical</strong> y el campo status es <strong>Unknown</strong>, significa que el nodo Kubernetes maestro no está disponible. Para ponerse en contacto con el equipo de soporte de {{site.data.keyword.Bluemix_notm}}, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#getting-help).</li></ul></li></ol>|
{: caption="Tabla. Estados de un clúster" caption-side="top"}

<br />


## Eliminación de clústeres
{: #remove}

Cuando termine con un clúster, puede eliminarlo para que el clúster deje de consumir recursos.
{:shortdesc}

Los clústeres Lite y estándar creados con una cuenta de Pago según uso los deben eliminar los usuarios de forma manual cuando ya no sean necesarios.

Cuando suprime un clúster, también suprime los recursos del clúster, incluidos contenedores, pods, servicios vinculados y secretos. Si no suprime su almacenamiento cuando suprima el clúster, podrá hacerlo a través del panel de control de infraestructura de IBM Cloud (SoftLayer) en la interfaz gráfica de usuario de {{site.data.keyword.Bluemix_notm}}. Debido al ciclo de facturación mensual, una reclamación de volumen permanente no se puede suprimir el último día del mes. Si suprime la reclamación de volumen permanente el último día del mes, la supresión permanece pendiente hasta el principio del siguiente mes.

**Aviso** No se crean copias de seguridad del clúster ni de los datos del almacén permanente. La supresión de un clúster es permanente y no se puede deshacer.

-   Desde la interfaz gráfica de usuario de {{site.data.keyword.Bluemix_notm}}
    1.  Seleccione el clúster y pulse **Suprimir** en el menú **Más acciones...**.
-   Desde la CLI de {{site.data.keyword.Bluemix_notm}}
    1.  Liste los clústeres disponibles.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Suprima el clúster.

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  Siga las indicaciones y decidir si desea suprimir los recursos del clúster.

Cuando se elimina un clúster, puede optar por eliminar las subredes portátiles y el almacenamiento portátil asociado con el mismo:
- Las subredes se utilizan para asignar direcciones IP públicas portátiles a los servicios de equilibrio de carga o el controlador de Ingress. Si los conserva, puede reutilizarlos en un nuevo clúster o suprimirlos manualmente más adelante desde el portafolio de infraestructura de IBM Cloud (SoftLayer).
- Si ha creado una reclamación de volumen persistente utilizando una [compartición de archivo existente](cs_storage.html#existing), no puede suprimir la compartición de archivo al suprimir el clúster. Suprima manualmente la compartición de archivo desde el portafolio de infraestructura de IBM Cloud (SoftLayer).
- El almacenamiento persistente proporciona alta disponibilidad a los datos. Si lo suprime, no podrá recuperar los datos.
