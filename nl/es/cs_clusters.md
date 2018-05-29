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


# Configuración de clústeres
{: #clusters}

Diseñe la configuración del clúster de Kubernetes para maximizar la disponibilidad y la capacidad del contenedor con {{site.data.keyword.containerlong}}.
{:shortdesc}

## Planificación de configuración de clúster
{: #planning_clusters}

Utilice clústeres estándares para incrementar la disponibilidad de las apps.
{:shortdesc}

Si distribuye su configuración entre varios clústeres y nodos trabajadores, es menos probable que los usuarios experimenten un tiempo de inactividad del sistema. Características incorporadas como, por ejemplo, el aislamiento y el equilibrio de carga, incrementan la resiliencia con relación a posibles anomalías con hosts, redes o apps.

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
<code>bx cs cluster-create --location dal10 --workers 3 --public-vlan &lt;public_VLAN_ID&gt; --private-vlan &lt;private_VLAN_ID&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;cluster_name_or_ID&gt;</code>
</pre>
</dd>
<dt>Distribuya las apps entre clústeres</dt>
<dd>Cree varios clústeres, cada uno con varios nodos trabajadores. Si se produce una interrupción en un clúster, los usuarios pueden acceder a una app que también está desplegada en otro clúster.
<p>Clúster
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location dal10 --workers 3 --public-vlan &lt;public_VLAN_ID&gt; --private-vlan &lt;private_VLAN_ID&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;cluster_name_or_ID&gt;</code>
</pre>
<p>Clúster
2:</p>
<pre class="codeblock">
<code>bx cs ccluster-create --location dal12 --workers 3 --public-vlan &lt;public_VLAN_ID&gt; --private-vlan &lt;private_VLAN_ID&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;cluster_name_or_ID&gt;</code>
</pre>
</dd>
<dt>Distribuya las apps entre clústeres de distintas regiones</dt>
<dd>Si distribuye las apps entre clústeres de distintas regiones, permite que se equilibre la carga
en función de la región en la que se encuentra el usuario. Si el clúster, el hardware, o incluso toda la ubicación de una región pasa a estar inactivo, el tráfico se redirecciona al contenedor desplegado en otro centro de datos.
<p><strong>Importante:</strong> Después de configurar un dominio personalizado, puede utilizar estos mandatos para crear los clústeres.</p>
<p>Ubicación
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location dal10 --workers 3 --public-vlan &lt;public_VLAN_ID&gt; --private-vlan &lt;private_VLAN_ID&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;cluster_name_or_ID&gt;</code>
</pre>
<p>Ubicación 2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location ams03 --workers 3 --public-vlan &lt;public_VLAN_ID&gt; --private-vlan &lt;private_VLAN_ID&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;cluster_name_or_ID&gt;</code>
</pre>
</dd>
</dl>

<br />





## Planificación de la configuración de nodos trabajadores
{: #planning_worker_nodes}

Un clúster de Kubernetes está formado por nodos trabajadores y está supervisado y gestionado de forma centralizada desde el maestro de Kubernetes. Los administradores del clúster deciden cómo configurar el clúster de nodos trabajadores para garantizar que los usuarios del clúster disponen de todos los recursos para desplegar y ejecutar las apps en el clúster.
{:shortdesc}

Cuando se crea un clúster estándar, los nodos trabajadores se ordenan en la infraestructura de IBM Cloud (SoftLayer) en su nombre y se añaden a la agrupación predeterminada de nodos trabajadores del clúster. A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar después de haber creado el clúster.

Puede elegir entre servidores virtuales o físicos (nativos). En función del nivel de aislamiento de hardware que elija, los nodos trabajadores virtuales se pueden configurar como nodos compartidos o dedicados. También puede elegir si desea que los nodos trabajadores se conecten a una VLAN pública y a una VLAN privada, o sólo a una VLAN privada. Cada nodo trabajador se suministra con un tipo de máquina específico que determina el número de vCPU, la memoria y el espacio en disco que están disponibles para los contenedores que se despliegan en el nodo trabajador. Kubernetes limita el número máximo de nodos trabajadores que puede tener en un clúster. Consulte el apartado sobre [nodo trabajador y cuotas de pod ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/cluster-large/) para obtener más información.





### Hardware de los nodos trabajadores
{: #shared_dedicated_node}

Cuando se crea un clúster estándar en {{site.data.keyword.Bluemix_notm}}, se selecciona entre suministrar los nodos trabajadores como máquinas físicas (nativas) o como máquinas virtuales que se ejecutan en hardware físico. Cuando se crea un clúster gratuito, el nodo trabajador se suministra automáticamente como nodo compartido virtual en la cuenta de infraestructura de IBM Cloud (SoftLayer).
{:shortdesc}

![Opciones de hardware para los nodos trabajadores en un clúster estándar](images/cs_clusters_hardware.png)

<dl>
<dt>Máquinas físicas (nativas)</dt>
<dd>Puede suministrar el nodo trabajador como un servidor físico de arrendatario único, también conocido como nativo. Los servidores nativos ofrecen acceso directo a los recursos físicos en la máquina, como la memoria o la CPU. Esta configuración elimina el hipervisor de máquina virtual que asigna recursos físicos a máquinas virtuales que se ejecutan en el host. En su lugar, todos los recursos de una máquina nativa están dedicados exclusivamente al trabajador, por lo que no es necesario preocuparse por "vecinos ruidosos" que compartan recursos o ralenticen el rendimiento.
<p><strong>Facturación mensual</strong>: los servidores nativos son más caros que los servidores virtuales, y son más apropiados para apps de alto rendimiento que necesitan más recursos y control de host. Los servidores nativos se facturan de forma mensual. Si cancela un servidor nativo antes de fin de mes, se le facturará a finales de ese mes. La realización de pedidos de servidores nativos, y su cancelación, es un proceso manual que se realiza a través de su cuenta (SoftLayer) de la infraestructura de IBM Cloud. Puede ser necesario más de un día laborable para completar la tramitación. </p>
<p><strong>Opción para habilitar Trusted Compute</strong>: Habilite Trusted Compute para protegerse ante la manipulación indebida de nodos trabajadores. Si no habilita la confianza durante la creación del clúster pero desea hacerlo posteriormente, puede utilizar el [mandato](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable`. Una vez que habilita la confianza, no puede inhabilitarla posteriormente. Puede crear un nuevo clúster sin confianza. Para obtener más información sobre cómo funciona la confianza durante el proceso de inicio del nodo, consulte [{{site.data.keyword.containershort_notm}} con Trusted Compute](cs_secure.html#trusted_compute). Trusted Compute está disponible en los clústeres donde se ejecuta Kubernetes versión 1.9 o posterior y poseen determinados tipos de máquina nativos. Cuando ejecute el [mandato](cs_cli_reference.html#cs_machine_types) `bx cs machine-types <location>`, en el campo `Trustable` puede ver qué máquinas son compatibles con la confianza.</p>
<p><strong>Grupos de tipo de máquina nativa</strong>: Los tipos de máquina nativa vienen en grupos que tienen distintos recursos de cálculo que puede elegir para satisfacer las necesidades de la app.
Los tipos de máquina física tienen más almacenamiento local que virtual, y algunos tienen RAID para realizar copias de seguridad de datos locales. Para obtener más información sobre los distintos tipos de ofertas nativas, consulte el [mandato](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`.
<ul><li>`mb1c.4x32`: Si no necesita RAM, u otros recursos intensivos de datos, seleccione este tipo para obtener una configuración equilibrada de los recursos de la máquina física para los nodos trabajadores. Equilibrado con 4 núcleos, 32 GB de memoria, disco primario SATA de 1 TB, disco secundario SATA de 2 TB, red adherida de 10 Gbps.</li>
<li>`mb1c.16x64`: Si no necesita RAM, u otros recursos intensivos de datos, seleccione este tipo para obtener una configuración equilibrada de los recursos de la máquina física para los nodos trabajadores. Equilibrado con 16 núcleos, 64 GB de memoria, disco primario SATA de 1 TB, disco secundario SSD de 1,7 TB, red adherida de 10 Gbps.</li>
<li>`mr1c.28x512`: Seleccione este tipo para maximizar la RAM disponible para los nodos trabajadores. Uso intensivo de RAM con 28 núcleos, 512 GB de memoria, disco primario SATA de 1 TB, disco secundario SSD de 1,7 TB, red adherida de 10 Gbps.</li>
<li>`md1c.16x64.4x4tb`: Seleccione este tipo si los nodos trabajadores requieren una cantidad significativa de almacenamiento en disco local, incluido RAID para realizar copia de seguridad de los datos almacenados localmente en la máquina. Los discos de almacenamiento primario de 1 TB están configurados para RAID1, y los discos de almacenamiento secundario de 4TB están configurados para RAID10. Uso intensivo de datos con 28 núcleos, 512 GB de memoria, 2 discos primarios RAID1 de 1 TB, 4 discos secundarios SATA de RAID10 de 4 TB, red adherida de 10 Gbps.</li>
<li>`md1c.28x512.4x4tb`: Seleccione este tipo si los nodos trabajadores requieren una cantidad significativa de almacenamiento en disco local, incluido RAID para realizar copia de seguridad de los datos almacenados localmente en la máquina. Los discos de almacenamiento primario de 1 TB están configurados para RAID1, y los discos de almacenamiento secundario de 4TB están configurados para RAID10. Uso intensivo de datos con 16 núcleos, 64 GB de memoria, 2 discos primarios RAID1 de 1 TB, 4 discos secundarios SATA de RAID10 de 4 TB, red adherida de 10 Gbps.</li>

</ul></p></dd>
<dt>Máquinas virtuales</dt>
<dd>Cuando se crea un clúster virtual estándar, debe seleccionar si desea que el hardware subyacente se comparta entre varios clientes de {{site.data.keyword.IBM_notm}} (tenencia múltiple) o se le dedique a usted exclusivamente (tenencia única).
<p>En una configuración de tenencia múltiple, los recursos físicos, como CPU y memoria, se comparten entre todas las máquinas virtuales desplegadas en el mismo hardware físico. Para asegurarse de que cada máquina virtual se pueda ejecutar de forma independiente, un supervisor de máquina virtual, también conocido como hipervisor, segmenta los recursos físicos en entidades aisladas y los asigna como recursos dedicados a una máquina virtual (aislamiento de hipervisor).</p>
<p>En una configuración de tenencia única, se dedican al usuario todos los recursos físicos. Puede desplegar varios nodos trabajadores como máquinas virtuales en el mismo host físico. De forma similar a la configuración de tenencia múltiple,
el hipervisor asegura que cada nodo trabajador recibe su parte compartida de los recursos físicos disponibles.</p>
<p>Los nodos compartidos suelen resultar más económicos que los nodos dedicados porque los costes del hardware subyacente se comparten entre varios clientes. Sin embargo, cuando decida entre nodos compartidos y dedicados, debe ponerse en contacto con el departamento legal y ver el nivel de aislamiento y de conformidad de la infraestructura que necesita el entorno de app.</p>
<p><strong>Tipos de máquinas virtuales `u2c` o `b2c`</strong>: Estas máquinas utilizan el disco local en lugar de la red de área de almacenamiento (SAN) por motivos de fiabilidad. Entre las ventajas de fiabilidad se incluyen un mejor rendimiento al serializar bytes en el disco local y una reducción de la degradación del sistema de archivos debido a anomalías de la red. Este tipo de máquinas contienen 25 GB de almacenamiento en disco local primario para el sistema de archivos de SO y 100 GB de almacenamiento en disco local secundario para `/var/lib/docker`, el directorio en el que se graban todos los datos del contenedor.</p>
<p><strong>Tipos de máquina en desuso `u1c` o `b1c`</strong>: Para empezar a utilizar los tipos de máquina `u2c` y `b2c`, [actualice los tipos de máquina añadiendo nodos trabajadores](cs_cluster_update.html#machine_type).</p></dd>
</dl>


Los tipos de máquinas físicas y virtuales varían según la ubicación en la que se despliega el clúster. Para obtener más información, consulte el [mandato](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Puede desplegar clústeres mediante la [interfaz de usuario de la consola](#clusters_ui) o la [CLI](#clusters_cli).

### Conexión VLAN para nodos trabajadores
{: #worker_vlan_connection}

Cuando crea un clúster, cada clúster se conecta automáticamente a una VLAN de su cuenta de infraestructura de IBM Cloud (SoftLayer).
{:shortdesc}

Una VLAN configura un grupo de nodos trabajadores y pods como si estuvieran conectadas a la misma conexión física. La VLAN privada determina la dirección IP privada que se asigna a un nodo trabajador durante la creación del clúster, y la VLAN pública determina la dirección IP pública que se asigna a un nodo trabajador durante la creación del clúster.

Para los clústeres gratuitos, los nodos trabajadores del clúster se conectan de forma predeterminada a una VLAN pública y VLAN privada propiedad de IBM durante la creación del clúster. Para los clústeres estándares, debe conectar los nodos trabajadores a una VLAN privada. Puede conectar los nodos trabajadores tanto a una VLAN pública y a la VLAN privada, o solo a la VLAN privada. Si desea conectar los nodos trabajadores solo a una VLAN privada, puede designar el ID de la VLAN privada existente durante la creación del clúster o [crear una VLAN privada](/docs/cli/reference/softlayer/index.html#sl_vlan_create). Si los nodos trabajadores únicamente se configuran con una VLAN privada, debe configurar una solución alternativa para la conectividad de red. Para obtener más información, consulte [Conexión de VLAN para nodos trabajadores](cs_clusters.html#worker_vlan_connection). 

**Nota**: Si tiene varias VLAN para un clúster o varias subredes en la misma VLAN, debe activar la expansión de VLAN para que los nodos trabajadores puedan comunicarse entre sí en la red privada. Para obtener instrucciones, consulte [Habilitar o inhabilitar la expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).

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

Para revisar cuánta memoria se utiliza en el nodo trabajador, ejecute [kubectl top node ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top).

### Recuperación automática para los nodos trabajadores
`Docker`, `kubelet`, `kube-proxy` y `calico` con componentes críticos que deben ser funcionales para tener un nodo trabajador de Kubernetes en buen estado. Con el tiempo, estos componentes se pueden estropear dejando así el nodo trabajador en estado fuera de servicio. Los nodos trabajadores averiados reducen la capacidad total del clúster y pueden provocar tiempo de inactividad en la app.

Puede [configurar comprobaciones de estado del nodo de trabajador y habilitar la recuperación automática](cs_health.html#autorecovery). Si la recuperación automática detecta un nodo trabajador erróneo basado en las comprobaciones configuradas, desencadena una acción correctiva, como una recarga del sistema operativo, en el nodo trabajador. Para obtener más información sobre cómo funciona la recuperación automática, consulte el [blog sobre recuperación automática ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />



## Creación de clústeres con la GUI
{: #clusters_ui}

La finalidad del clúster de Kubernetes es definir un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantengan la alta disponibilidad de las apps. Para poder desplegar una app, debe crear un clúster y establecer las definiciones de los nodos trabajadores en dicho clúster.
{:shortdesc}

Antes de empezar, debe tener una [cuenta de {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) de pago según uso o de suscripción. Para probar algunas de las funcionalidades, puede crear un clúster gratuito que caducará después de 21 días. Puede disponer como máximo de un clúster gratuito de forma simultánea. 

Puede eliminar su clúster gratuito siempre que lo desee. Tenga en cuenta que después de 21 días los clústeres gratuitos y su contenido se suprimen sin la posibilidad de restaurarlos. Asegúrese de hacer una copia de seguridad de los datos.
{: tip}

Para personalizar completamente su clúster y añadir, entre otras características, la versión de API, la ubicación o el aislamiento de hardware, cree un clúster estándar. 

Para crear un clúster:

1. En el catálogo, seleccione **Clúster de Kubernetes**.

2. Seleccione una región en la que desea desplegar el clúster.

3. Seleccione un tipo de plan de clúster. Puede elegir **Gratuito** o **Estándar**. Con un clúster estándar, obtiene acceso a características como, por ejemplo, varios nodos trabajadores para obtener un entorno de alta disponibilidad.

4. Configure los detalles del clúster. Complete los pasos que se aplican al tipo de clúster que está creando.

    1. **Gratuito y Estándar**: Asigne un nombre al clúster. El nombre debe empezar por una letra, puede contener letras, números, guiones (-) y debe tener 35 caracteres como máximo. Tenga en cuenta que el nombre del clúster y la región en la que el clúster se despliega forman el nombre de dominio completo para el subdominio de Ingress. Para garantizar que el subdominio de Ingress es exclusivo dentro de una región, el nombre del clúster podría ser truncado y añadírsele un valor aleatorio dentro del nombre de dominio de Ingress. 

    2. **Estándar**: Seleccione una ubicación en la que desplegar su clúster. Para obtener el mejor rendimiento, seleccione la ubicación que esté físicamente más cercana. Tenga en cuenta que es posible que se requiera autorización legal para poder almacenar datos físicamente en un país extranjero si selecciona una ubicación que esté fuera del país.

    3. **Estándar**: Elija la versión del servidor de API de Kubernetes para el nodo maestro del clúster. 

    4. **Estándar**: Seleccione un tipo de aislamiento de hardware. La opción virtual se factura por hora, y la nativa se factura mensualmente.

        - **Virtual - Dedicado**: Los nodos trabajadores están alojados en una infraestructura que está dedicada a su cuenta. Sus recursos físicos están completamente aislados.

        - **Virtual - Compartido**: Los recursos de infraestructura, como por ejemplo el hipervisor y el hardware físico, están compartidos entre usted y otros clientes de IBM, pero cada nodo trabajador es accesible sólo por usted. Aunque esta opción es menos costosa y suficiente en la mayoría de los casos, es posible que desee verificar los requisitos de rendimiento e infraestructura con las políticas de la empresa.

        - **Nativo**: Los servidores nativos se facturan de forma mensual y su suministro se realiza mediante interacción manual con la infraestructura de IBM Cloud (SoftLayer), por lo que puede tardar más de un día laborable en realizarse. Los servidores nativos son más apropiados para aplicaciones de alto rendimiento que necesitan más recursos y control de host. 

        Asegúrese de que desea suministrar una máquina nativa. Puesto que se factura mensualmente, si cancela la operación inmediatamente tras realizar un pedido por error, se le cobrará el mes completo.
        {:tip}

    5.  **Estándar**: Seleccione un tipo de máquina. El tipo de máquina define la cantidad de memoria, espacio de disco y CPU virtual que se configura en cada nodo trabajador y que está disponible para todos los contenedores. Los tipos de máquinas nativas y virtuales varían según la ubicación en la que se despliega el clúster. Después de crear el clúster, puede añadir distintos tipos de máquina añadiendo un nodo al clúster.

    6. **Estándar**: Especifique el número de nodos trabajadores que necesita en el clúster. 

    7. **Estándar**: Seleccione una VLAN pública (opcional) y una VLAN privada (necesario) en la cuenta de infraestructura de IBM Cloud (SoftLayer). Ambas VLAN comunican entre nodos trabajadores, pero la VLAN pública también se comunica con el maestro de Kubernetes gestionado por IBM. Puede utilizar la misma VLAN para varios clústeres.
        **Nota**: Si los nodos trabajadores únicamente se configuran con una VLAN privada, debe configurar una solución alternativa para la conectividad de red. Para obtener más información, consulte [Conexión de VLAN para nodos trabajadores](cs_clusters.html#worker_vlan_connection). 

    8. De forma predeterminada, **Cifrar disco local** está seleccionado. Si elige desmarcar el recuadro de selección, no se cifran los datos de Docker del host. [Más información sobre el cifrado](cs_secure.html#encrypted_disks).

4. Pulse **Crear clúster**. Verá el progreso del despliegue del nodo trabajador en el separador **Nodos trabajadores**. Cuando finalice el despliegue, podrá ver que el clúster está listo en el separador **Visión general**.
    **Nota:** A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster. Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.

**¿Qué es lo siguiente?**

Cuando el clúster esté activo y en ejecución, puede realizar las siguientes tareas:


-   [Instalar las CLI para empezar a trabajar con el clúster.](cs_cli_install.html#cs_cli_install)
-   [Desplegar una app en el clúster.](cs_app.html#app_cli)
-   [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}} para almacenar y compartir imágenes de Docker con otros usuarios. ](/docs/services/Registry/index.html)
- Si tiene varias VLAN para un clúster o varias subredes en la misma VLAN, debe [activar la expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) para que los nodos trabajadores puedan comunicarse entre sí en la red privada.
- Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](cs_firewall.html#firewall) para utilizar los mandatos `bx`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.

<br />


## Creación de clústeres con la CLI
{: #clusters_cli}

La finalidad del clúster de Kubernetes es definir un conjunto de recursos, nodos, redes y dispositivos de almacenamiento que mantengan la alta disponibilidad de las apps. Para poder desplegar una app, debe crear un clúster y establecer las definiciones de los nodos trabajadores en dicho clúster.
{:shortdesc}

Antes de empezar:
- Debe tener una [cuenta de {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) de pago según uso o de suscripción. Puede crear un clúster gratuito para probar algunas de las funcionalidades durante 21 días, o crear clústeres estándares totalmente personalizables con el aislamiento de hardware que elija. 
- [Asegúrese de que tiene los permisos necesarios mínimos en la infraestructura de IBM Cloud (SoftLayer) para suministrar un clúster estándar](cs_users.html#infra_access).

Para crear un clúster:

1.  Instale la CLI de {{site.data.keyword.Bluemix_notm}} y el plug-in de [{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).

2.  Inicie la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Escriba sus credenciales de {{site.data.keyword.Bluemix_notm}} cuando se le solicite.

    ```
    bx login
    ```
    {: pre}

    **Nota:** Si tiene un ID federado, utilice `bx login --sso` para iniciar la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.

3. Si tiene varias cuentas de {{site.data.keyword.Bluemix_notm}}, seleccione la cuenta donde desea crear el clúster de Kubernetes.

4.  Si desea crear o acceder a clústeres de Kubernetes en una región distinta de la región de {{site.data.keyword.Bluemix_notm}} seleccionada anteriormente, ejecute `bx cs region-set`.

6.  Cree un clúster.

    1.  **Clústeres estándares**: Revise las ubicaciones que están disponibles. Las ubicaciones que se muestran dependen de la región de {{site.data.keyword.containershort_notm}} en la que ha iniciado la sesión.

        ```
        bx cs locations
        ```
        {: pre}

        La salida de la CLI coincide con las [ubicaciones correspondientes a la región del contenedor](cs_regions.html#locations).

    2.  **Clústeres estándares**: Elija una ubicación y revise los tipos de máquinas disponibles en dicha ubicación. El tipo de máquina especifica los hosts de cálculo físicos o virtuales que están disponibles para cada nodo trabajador.

        -  Consulte el campo **Tipo de servidor** para elegir máquinas virtuales o físicas (nativas).
        -  **Virtual**: Las máquinas virtuales se facturan por horas y se suministran en hardware compartido o dedicado.
        -  **Físico**: Los servidores nativos se facturan de forma mensual y su suministro se realiza mediante interacción manual con la infraestructura de IBM Cloud (SoftLayer), por lo que puede tardar más de un día laborable en realizarse. Los servidores nativos son más apropiados para aplicaciones de alto rendimiento que necesitan más recursos y control de host.
        - **Máquinas físicas con Trusted Compute**: Para clústeres nativos que ejecutan la versión 1.9 o posterior de Kubernetes, también puede optar por habilitar [Trusted Compute](cs_secure.html#trusted_compute) para verificar que los nodos trabajadores nativos no se manipulan de forma indebida. Si no habilita la confianza durante la creación del clúster pero desea hacerlo posteriormente, puede utilizar el [mandato](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable`. Una vez que habilita la confianza, no puede inhabilitarla posteriormente.
        -  **Tipos de máquina**: Para decidir qué tipo de máquina desplegar, revise las combinaciones de núcleo, memoria y almacenamiento o consulte la [documentación del mandato `bx cs machine-types`](cs_cli_reference.html#cs_machine_types). Después de crear el clúster, puede añadir distintos tipos de máquina física o virtual mediante el [mandato](cs_cli_reference.html#cs_worker_add) `bx cs worker-add`.

           Asegúrese de que desea suministrar una máquina nativa. Puesto que se factura mensualmente, si cancela la operación inmediatamente tras realizar un pedido por error, se le cobrará el mes completo.
           {:tip}

        ```
        bx cs machine-types <location>
        ```
        {: pre}

    3.  **Clústeres estándares**: Compruebe si ya existe una VLAN pública y privada en la infraestructura de IBM Cloud (SoftLayer) para esta cuenta.

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

        Si ya existen una VLAN pública y privada, anote los direccionadores correspondientes. Los direccionadores VLAN privados siempre
empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre
empiezan por <code>fcr</code> (direccionador frontal). Al crear un clúster especificando las VLAN privadas y públicas, deben coincidir el número y la combinación de letras después de dichos prefijos. En la salida de ejemplo, se puede utilizar cualquier VLAN privada con cualquier VLAN pública porque todos los direccionadores incluyen `02a.dal10`.

        Los nodos trabajadores los debe conectar a una VLAN privada y, opcionalmente, puede conectarlos a una VLAN pública. **Nota**: Si los nodos trabajadores únicamente se configuran con una VLAN privada, debe configurar una solución alternativa para la conectividad de red. Para obtener más información, consulte [Conexión de VLAN para nodos trabajadores](cs_clusters.html#worker_vlan_connection). 

    4.  **Clústeres estándares y gratuitos**: Ejecute el mandato `cluster-create`. Puede elegir un clúster gratuito, que incluye un nodo trabajador configurado con 2 vCPU y 4 GB de memoria que se suprime de forma automática después de 21 días. Cuando se crea un clúster estándar, de forma predeterminada, los discos del nodo trabajador están cifrados, su hardware se comparte entre varios clientes de IBM y se factura por horas de uso. </br>Ejemplo para un clúster estándar. Especifique las opciones del clúster:

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt] [--trusted]
        ```
        {: pre}

        Ejemplo para un clúster gratuito. Especifique el nombre del clúster:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
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
        <td>**Clústeres estándares**: Sustituya <em>&lt;location&gt;</em> por el ID de ubicación de {{site.data.keyword.Bluemix_notm}} donde desea crear el clúster. Las [ubicaciones disponibles](cs_regions.html#locations) dependen de la región de {{site.data.keyword.containershort_notm}} en la que ha iniciado la sesión.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**Clústeres estándares**: Elija un tipo de máquina. Puede desplegar los nodos trabajadores como máquinas virtuales en hardware dedicado o compartido, o como máquinas físicas en servidores nativos. Los tipos de máquinas físicas y virtuales varían según la ubicación en la que se despliega el clúster. Para obtener más información, consulte la documentación del [mandato](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Para los clústeres gratuitos, no tiene que definir el tipo de máquina.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**Clústeres estándares, sólo virtuales**: El nivel de aislamiento del hardware del nodo trabajador. Utilice el valor dedicated para tener recursos físicos disponibles dedicados solo a usted, o shared para permitir que los recursos físicos se compartan con otros clientes de IBM. El valor predeterminado es shared. Este valor es opcional para clústeres estándares y no está disponible para clústeres gratuitos.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**Clústeres gratuitos**: No tiene que definir una VLAN pública. El clúster gratuito se conecta automáticamente a una VLAN pública propiedad de IBM.</li>
          <li>**Clústeres estándares**: Si ya tiene una VLAN pública configurada en su cuenta de infraestructura de IBM Cloud (SoftLayer) para esta ubicación, escriba el ID de la VLAN pública. Si desea conectar los nodos trabajadores solo a una VLAN privada, no especifique esta opción. **Nota**: Si los nodos trabajadores únicamente se configuran con una VLAN privada, debe configurar una solución alternativa para la conectividad de red. Para obtener más información, consulte [Conexión de VLAN para nodos trabajadores](cs_clusters.html#worker_vlan_connection). <br/><br/>
          <strong>Nota</strong>: Los direccionadores VLAN privados siempre empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre empiezan por <code>fcr</code> (direccionador frontal). Al crear un clúster especificando las VLAN privadas y públicas, deben coincidir el número y la combinación de letras después de dichos prefijos. </li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Clústeres gratuitos**: No tiene que definir una VLAN privada. El clúster gratuito se conecta automáticamente a una VLAN privada propiedad de IBM.</li><li>**Clústeres estándares**: Si ya tiene una VLAN privada configurada en su cuenta de infraestructura de IBM Cloud (SoftLayer) para esta ubicación, escriba el ID de la VLAN privada. Si no tiene una VLAN privada en la ubicación, no especifique esta opción. {{site.data.keyword.containershort_notm}} crea automáticamente una VLAN privada.<br/><br/><strong>Nota</strong>: Los direccionadores VLAN privados siempre empiezan por <code>bcr</code> (back-end router, direccionador de fondo) y los direccionadores VLAN públicos siempre empiezan por <code>fcr</code> (direccionador frontal). Al crear un clúster especificando las VLAN privadas y públicas, deben coincidir el número y la combinación de letras después de dichos prefijos. </li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Clústeres estándares y gratuitos**: Sustituya <em>&lt;name&gt;</em> por el nombre del clúster. El nombre debe empezar por una letra, puede contener letras, números, guiones (-) y debe tener 35 caracteres como máximo. Tenga en cuenta que el nombre del clúster y la región en la que el clúster se despliega forman el nombre de dominio completo para el subdominio de Ingress. Para garantizar que el subdominio de Ingress es exclusivo dentro de una región, el nombre del clúster podría ser truncado y añadírsele un valor aleatorio dentro del nombre de dominio de Ingress. </td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**Clústeres estándares**: El número de nodos trabajadores que desea incluir en el clúster. Si no se especifica la opción <code>--workers</code>, se crea 1 nodo trabajador.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Clústeres estándares**: La versión de Kubernetes del nodo maestro del clúster. Este valor es opcional. Cuando no se especifica la versión, el clúster se crea con el valor predeterminado de las versiones de Kubernetes soportadas. Para ver todas las versiones disponibles, ejecute <code>bx cs kube-versions</code>. </td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Clústeres estándares y gratuitos**: Los nodos trabajadores tienen cifrado de disco de forma predeterminada; [más información](cs_secure.html#encrypted_disks). Si desea inhabilitar el cifrado, incluya esta opción.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Clústeres nativos estándares**: Habilite [Trusted Compute](cs_secure.html#trusted_compute) para verificar que los nodos trabajadores nativos no se manipulan de forma indebida. Si no habilita la confianza durante la creación del clúster pero desea hacerlo posteriormente, puede utilizar el [mandato](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable`. Una vez que habilita la confianza, no puede inhabilitarla posteriormente.</td>
        </tr>
        </tbody></table>

7.  Verifique que ha solicitado la creación del clúster.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** Para máquinas virtuales, se puede tardar varios minutos en pedir las máquinas de nodo trabajador y en configurar y suministrar el clúster en la cuenta. El suministro de las máquinas físicas nativas se realiza mediante interacción manual con la infraestructura de IBM Cloud (SoftLayer), por lo que puede tardar más de un día laborable en realizarse.

    Una vez completado el suministro del clúster, el estado del clúster pasa a ser **deployed**.

    ```
    Name         ID                                   State      Created          Workers   Location   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.8.11
    ```
    {: screen}

8.  Compruebe el estado de los nodos trabajadores.

    ```
    bx cs workers <cluster_name_or_ID>
    ```
    {: pre}

    Cuando los nodos trabajadores están listos, el estado pasa a **normal** y el estado es **Ready**. Cuando el estado del nodo sea **Preparado**, podrá acceder al clúster.

    **Nota:** A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster. Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Location   Version
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01      1.8.11
    ```
    {: screen}

9. Defina el clúster que ha creado como contexto para esta sesión. Siga estos pasos de configuración cada vez que de trabaje con el clúster.
    1.  Obtenga el mandato para establecer la variable de entorno y descargar los archivos de configuración de Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        Cuando termine la descarga de los archivos de configuración, se muestra un mandato que puede utilizar para establecer la vía de acceso al archivo de configuración de
Kubernetes como variable de entorno.

        Ejemplo para OS X:

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
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
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

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
- Si tiene varias VLAN para un clúster o varias subredes en la misma VLAN, debe [activar la expansión de VLAN](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning) para que los nodos trabajadores puedan comunicarse entre sí en la red privada.
- Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](cs_firewall.html#firewall) para utilizar los mandatos `bx`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.

<br />






## Visualización de estados de clúster
{: #states}

Revise el estado de un clúster de Kubernetes para obtener información sobre la disponibilidad y la capacidad del clúster, y posibles problemas que puedan haberse producido.
{:shortdesc}

Para ver información sobre un clúster específico, como su ubicación, el URL maestro, el subdominio de Ingress, la versión, los trabajadores, el propietario y el panel de control de supervisión, utilice el [mandato](cs_cli_reference.html#cs_cluster_get) `bx cs cluster-get <cluster_name_or_ID>`. Incluya el distintivo `--showResources` para ver más recursos de clúster, como complementos para pods de almacenamiento o VLAN de subred para IP públicas y privadas.

Puede ver el estado actual del clúster ejecutando el mandato `bx cs clusters` y localizando el campo **State**. Para resolver el clúster y los nodos de trabajador, consulte [Resolución de problemas de clústeres](cs_troubleshoot.html#debug_clusters).

<table summary="Cada fila de la tabla se debe leer de izquierda a derecha, con el estado del clúster en la columna uno y una descripción en la columna dos.">
   <thead>
   <th>Estado del clúster</th>
   <th>Descripción</th>
   </thead>
   <tbody>
<tr>
   <td>Terminado anormalmente</td>
   <td>El usuario ha solicitado la supresión del clúster antes de desplegar el maestro de Kubernetes. Una vez realizada la supresión del clúster, el clúster se elimina del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
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
     <td>El clúster se ha suprimido pero todavía no se ha eliminado del panel de control. Si el clúster está bloqueado en este estado durante mucho tiempo, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
   <tr>
   <td>Suprimiendo</td>
   <td>El clúster se está suprimiendo y la infraestructura del clúster se está desmontando. No puede acceder al clúster.  </td>
   </tr>
   <tr>
     <td>Error al desplegar</td>
     <td>El despliegue del maestro de Kubernetes no se ha podido realizar. No puede resolver este estado. Póngase en contacto con el soporte de IBM Cloud abriendo una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Despliegue</td>
       <td>El maestro de Kubernetes no está completamente desplegado. No puede acceder a su clúster. Espere hasta que el clúster se haya desplegado por completo para revisar el estado del clúster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Todos los nodos trabajadores de un clúster están activos y en ejecución. Puede acceder al clúster y desplegar apps en el clúster. Este estado se considera correcto y no requiere ninguna acción por su parte. **Nota**: Aunque los nodos trabajadores podrían poseer un estado normal, otros recursos de infraestructura como, por ejemplo la [red](cs_troubleshoot_network.html) y el [almacenamiento](cs_troubleshoot_storage.html), podrían requerir su atención. </td>
    </tr>
      <tr>
       <td>Pendiente</td>
       <td>El maestro de Kubernetes está desplegado. Los nodos trabajadores se están suministrando y aún no están disponibles en el clúster. Puede acceder al clúster, pero no puede desplegar apps en el clúster.  </td>
     </tr>
   <tr>
     <td>Solicitado</td>
     <td>Se ha enviado una solicitud para crear el clúster y pedir la infraestructura para el maestro de Kubernetes y los nodos trabajadores. Cuando se inicia el despliegue del clúster, el estado del clúster cambia a <code>Desplegando</code>. Si el clúster está bloqueado en el estado <code>Solicitado</code> durante mucho tiempo, abra una [incidencia de soporte de {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help). </td>
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


## Eliminación de clústeres
{: #remove}

Los clústeres gratuitos y estándares que se crean con una cuenta Pago según uso se deben eliminar de forma manual cuando dejan de necesitarse para que dejen de consumir recursos.
{:shortdesc}

**Aviso:**
  - No se crean copias de seguridad del clúster ni de los datos del almacén permanente. La supresión de un clúster o del almacenamiento permanente es irreversible y no se puede deshacer.
  - Cuando se elimina un clúster, también se eliminan todas las subredes suministradas de forma automática al crear el clúster con el mandato `bx cs cluster-subnet-create`. Sin embargo, si ha añadido de forma manual subredes existentes al clúster con el mandato `bx cs cluster-subnet-add`, estas subredes no se eliminan de su cuenta (SoftLayer) de la infraestructura IBM Cloud y podrá reutilizarlas en otros clústeres. 

Para eliminar un clúster:

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
        bx cs cluster-rm <cluster_name_or_ID>
        ```
        {: pre}

    3.  Siga las indicaciones y decidir si desea suprimir los recursos del clúster (contenedores, pods, servicios enlazados, almacenamiento o secretos). 
      - **Almacenamiento persistente**: El almacenamiento persistente proporciona alta disponibilidad a los datos. Si ha creado una reclamación de volumen persistente utilizando una [compartición de archivo existente](cs_storage.html#existing), no puede suprimir la compartición de archivo al suprimir el clúster. Suprima manualmente la compartición de archivo desde el portafolio de infraestructura de IBM Cloud (SoftLayer).

          **Nota**: Debido al ciclo de facturación mensual, una reclamación de volumen permanente no se puede suprimir el último día del mes. Si suprime la reclamación de volumen permanente el último día del mes, la supresión permanece pendiente hasta el principio del siguiente mes.

Pasos siguientes:
- Después de que deje de aparecer en la lista de clústeres disponibles, al ejecutar el mandato `bx cs clusters`, podrá reutilizar el nombre de un clúster eliminado. 
- Para mantener las subredes, puede [reutilizarlas en un nuevo clúster](cs_subnets.html#custom) o suprimirlas de forma manual más tarde de su portfolio (SoftLayer) de la infraestructura IBM Cloud. 
- Si conserva el almacenamiento persistente, puede suprimirlo más tarde a través el panel de control (SoftLayer) de la infraestructura IBM Cloud en la interfaz gráfica de usuario de {{site.data.keyword.Bluemix_notm}}. 

