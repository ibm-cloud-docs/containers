---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuración de clústeres
{: #cs_cluster}

Diseñe la configuración de su clúster para maximizar su disponibilidad y capacidad.
{:shortdesc}

El diagrama siguiente incluye configuraciones de clúster comunes con disponibilidad en aumento.

![Etapas de alta disponibilidad de un clúster](images/cs_cluster_ha_roadmap.png)

Tal como se muestra en el diagrama, el despliegue de apps en varios nodos trabajadores mejora la alta disponibilidad de las apps. El despliegue de las apps en varios clústeres mejora su alta disponibilidad. Para obtener la máxima disponibilidad, despliegue las apps en clústeres de distintas regiones. [Para obtener más información, revise las opciones correspondientes a las configuraciones de clústeres de alta disponibilidad.](cs_planning.html#cs_planning_cluster_config)

<br />


## Creación de clústeres con la GUI
{: #cs_cluster_ui}

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
        - Los tipos de máquinas que incluyen `cifrado` en el nombre cifran los datos de Docker del host. El directorio `/var/lib/docker`, donde están almacenados todos los datos de los contenedores, están cifrados mediante LUKS.
    3. Seleccione una VLAN pública y privada en la cuenta de infraestructura de IBM Cloud (SoftLayer). Ambas VLAN comunican entre nodos trabajadores, pero la VLAN pública también se comunica con el Kubernetes maestro gestionado por IBM. Puede utilizar la misma VLAN para varios clústeres.
        **Nota**: Si elige no seleccionar una VLAN pública, debe configurar una solución alternativa.
    4. Seleccione un tipo de hardware. El hardware compartido es una opción suficiente para la mayoría de las situaciones.
        - **Dedicado**: Garantiza el aislamiento completo de sus recursos físicos.
        - **Compartido**: Permite almacenar sus recursos físicos en el mismo hardware que otros clientes de IBM.
        - Los nodos de trabajador tienen cifrado de disco de forma predeterminada; [más información](cs_security.html#cs_security_worker). Si desea inhabilitar el cifrado, desmarque el recuadro de selección **Cifrar disco local**.
4. Pulse **Crear clúster**. Verá el progreso del despliegue del nodo trabajador en el separador **Nodos trabajadores**. Cuando finalice el despliegue, podrá ver que el clúster está listo en el separador **Visión general**.
    **Nota:** A cada nodo trabajador se la asigna un ID exclusivo y un nombre de dominio que no se debe cambiar de forma manual después de haber creado el clúster. Si se cambia el nombre de dominio o el ID se impide que el maestro de Kubernetes gestione el clúster.


**¿Qué es lo siguiente?**

Cuando el clúster esté activo y en ejecución, puede realizar las siguientes tareas:

-   [Instalar las CLI para empezar a trabajar con el clúster.](cs_cli_install.html#cs_cli_install)
-   [Desplegar una app en el clúster.](cs_apps.html#cs_apps_cli)
-   [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}} para almacenar y compartir imágenes de Docker con otros usuarios. ](/docs/services/Registry/index.html)
- Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](cs_security.html#opening_ports) para utilizar los mandatos `bx`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.

<br />


## Creación de clústeres con la CLI
{: #cs_cluster_cli}

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

    **Nota:** Si tiene un ID federado, utilice `bx login --sso` para iniciar la sesión en la CLI de {{site.data.keyword.Bluemix_notm}}. Especifique su nombre de usuario y utilice el URL proporcionado en la salida de la CLI para recuperar el código de acceso de un solo uso. Sabe tiene un ID federado cuando el inicio de sesión falla sin el `--sso` y se lleva a cabo correctamente con la opción `--sso`.

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
        <caption>Tabla 1. Visión general de los componentes del mandato <code>bx cs cluster-create</code></caption>
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
        <td>Si está creando un clúster estándar, elija un tipo de máquina. El tipo de máquina especifica los recursos de cálculo virtuales que están disponibles para cada nodo trabajador. Consulte el apartado sobre [Comparación entre los clústeres lite y estándar para {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type) para obtener más información. Para los clústeres de tipo lite, no tiene que definir el tipo de máquina.</td>
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
        <td>Los nodos de trabajador tienen cifrado de disco de forma predeterminada; [más información](cs_security.html#cs_security_worker). Si desea inhabilitar el cifrado, incluya esta opción.</td>
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

        Cuando termine la descarga de los archivos de configuración, se muestra un mandato que puede utilizar para establecer la vía de acceso al archivo de configuración de Kubernetes como variable de entorno.

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

-   [Desplegar una app en el clúster.](cs_apps.html#cs_apps_cli)
-   [Gestionar el clúster con la línea de mandatos de `kubectl`. ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configure su propio registro privado en {{site.data.keyword.Bluemix_notm}} para almacenar y compartir imágenes de Docker con otros usuarios. ](/docs/services/Registry/index.html)
- Si tiene un cortafuegos, es posible que tenga que [abrir los puertos necesarios](cs_security.html#opening_ports) para utilizar los mandatos `bx`, `kubectl` o `calicotl`, para permitir el tráfico de salida desde el clúster o para permitir el tráfico de entrada para los servicios de red.

<br />


## Utilización de registros de imagen privada y pública
{: #cs_apps_images}

Una imagen de Docker es la base para cada contenedor que pueda crear. Se crea una imagen a partir de Dockerfile, que es un archivo que contiene instrucciones para crear la imagen. Un Dockerfile puede hacer referencia a artefactos de compilación en sus instrucciones que se almacenan por separado, como por ejemplo una app, la configuración de la app y sus dependencias. Las imágenes normalmente se almacenan en un registro que puede ser tanto de acceso público (registro público) como estar configurado con acceso limitado para un pequeño grupo de usuarios (registro privado).
{:shortdesc}

Revise las opciones siguientes para encontrar información sobre cómo configurar un registro de imágenes y cómo utilizar una imagen del registro.

-   [Acceso a un espacio de nombres de {{site.data.keyword.registryshort_notm}} para trabajar con imágenes proporcionadas con IBM y con sus propias imágenes privadas de Docker](#bx_registry_default).
-   [Acceso a imágenes públicas desde Docker Hub](#dockerhub).
-   [Acceso a imágenes privadas almacenadas en otros registros privados](#private_registry).

### Acceso a un espacio de nombres de {{site.data.keyword.registryshort_notm}} para trabajar con imágenes proporcionadas con IBM y con sus propias imágenes privadas de Docker
{: #bx_registry_default}

Puede desplegar contenedores en su clúster desde una imagen pública proporcionada por IBM o desde una imagen privada almacenada en el espacio de nombres de {{site.data.keyword.registryshort_notm}}.

Antes de empezar:

1. [Configure un espacio de nombres en {{site.data.keyword.registryshort_notm}} en {{site.data.keyword.Bluemix_notm}} Público o {{site.data.keyword.Bluemix_dedicated_notm}} y envíe por push imágenes a este espacio de nombres](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Cree un clúster](#cs_cluster_cli).
3. [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure).

Cuando crea una agrupación, se crea automáticamente una señal de registro sin caducidad para el clúster. Esta señal se utiliza para autorizar el acceso de solo lectura a cualquier espacio de nombres que configure en {{site.data.keyword.registryshort_notm}}, de modo que pueda trabajar con imágenes públicas proporcionadas por IBM y con sus propias imágenes privadas de Docker. Las señales se deben guardar en `imagePullSecret` de Kubernetes para que resulten accesibles para un clúster de Kubernetes cuando se despliega una app contenerizada. Cuando se crea el clúster, {{site.data.keyword.containershort_notm}} almacena automáticamente esta señal en un `imagePullSecret` de Kubernetes. Este `imagePullSecret` se añade al espacio de nombres predeterminado de Kubernetes, a la lista predeterminada de secretos de ServiceAccount correspondiente a dicho espacio de nombres y al espacio de nombres kube-system.

**Nota:** Con esta configuración inicial, puede desplegar contenedores desde cualquier imagen disponible en un espacio de nombres de la cuenta de {{site.data.keyword.Bluemix_notm}} en el espacio de nombres **default** del clúster. Si desea desplegar un contenedor en otros espacios de nombres del clúster, o si desea utilizar una imagen almacenada en otra región de {{site.data.keyword.Bluemix_notm}} o en otra cuenta de {{site.data.keyword.Bluemix_notm}}, debe [crear su propio imagePullSecret para el clúster](#bx_registry_other).

Para desplegar un contenedor en el espacio de nombres **default** del clúster, cree un file de configuración.

1.  Cree un archivo de configuración de despliegue denominado `mydeployment.yaml`.
2.  Defina el despliegue y la imagen que desee utilizar del espacio de nombres de {{site.data.keyword.registryshort_notm}}.

    Para utilizar una imagen privada de un espacio de nombres de {{site.data.keyword.registryshort_notm}}:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **Sugerencia:** Para recuperar la información del espacio de nombres, ejecute `bx cr namespace-list`.

3.  Cree el despliegue en el clúster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Sugerencia:** También puede desplegar un archivo de configuración existente, como por ejemplo una de las imágenes públicas proporcionadas por IBM. En este ejemplo se utiliza la imagen **ibmliberty** de la región EE.UU.-Sur.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### Despliegue de imágenes en otros espacios de nombres de Kubernetes o acceso a imágenes de otras regiones y cuentas de {{site.data.keyword.Bluemix_notm}}
{: #bx_registry_other}

Puede desplegar contenedores en otros espacios de nombres de Kubernetes, utilizar imágenes almacenadas en otras regiones o cuentas de {{site.data.keyword.Bluemix_notm}} o utilizar imágenes almacenadas en {{site.data.keyword.Bluemix_dedicated_notm}} creando su propio imagePullSecret.

Antes de empezar:

1.  [Configure un espacio de nombres en {{site.data.keyword.registryshort_notm}} en {{site.data.keyword.Bluemix_notm}} Público o {{site.data.keyword.Bluemix_dedicated_notm}} y envíe por push imágenes a este espacio de nombres](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Cree un clúster](#cs_cluster_cli).
3.  [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para crear su propio imagePullSecret:

**Nota:** Los ImagePullSecrets solo son válidos para los espacios de nombres de Kubernetes para los que se han creado. Repita estos pasos para cada espacio de nombres en el que desee desplegar contenedores. Las imágenes de [DockerHub](#dockerhub) no necesitan ImagePullSecrets.

1.  Si no tiene una señal, [cree una señal para el registro al que desea acceder.](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  Obtenga una lista de las señales en la cuenta de {{site.data.keyword.Bluemix_notm}}.

    ```
    bx cr token-list
    ```
    {: pre}

3.  Anote el ID de la señal que desea utilizar.
4.  Recupere el valor de la señal. Sustituya <em>&lt;token_id&gt;</em> por el ID de la señal que ha recuperado en el paso anterior.

    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    El valor de la señal se muestra en el campo **Token** de la salida de la CLI.

5.  Cree el secreto de Kubernetes para almacenar la información de la señal.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabla 3. Visión general de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obligatorio. El espacio de nombres de Kubernetes del clúster en el que desea utilizar el secreto y desplegar los contenedores. Ejecute <code>kubectl get namespaces</code> para obtener una lista de todos los espacios de nombres del clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Obligatorio. El nombre que desea utilizar para su imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Obligatorio. El URL del registro de imágenes en el que está configurado el espacio de nombres.<ul><li>Para los espacios de nombres definidos en EE.UU. Sur y EE.UU. este en registry.ng.bluemix.net</li><li>Para los espacios definidos en UK-Sur registry.eu-gb.bluemix.net</li><li>Para los espacios de nombres definidos en UE-Central (Frankfurt) registry.eu-de.bluemix.net</li><li>Para los espacios de nombres definidos en Australia (Sidney) registry.au-syd.bluemix.net</li><li>Para los espacios definidos en {{site.data.keyword.Bluemix_dedicated_notm}} registry.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Obligatorio. El nombre de usuario para iniciar una sesión en su registro privado. Para {{site.data.keyword.registryshort_notm}}, el nombre de usuario se establece en <code>token</code>.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Obligatorio. El valor de la señal de registro que ha recuperado anteriormente.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Obligatorio. Si tiene una, especifique la dirección de correo electrónico de Docker. Si no tiene una, especifique una dirección de correo electrónico ficticia, como por ejemplo a@b.c. Este correo electrónico es obligatorio para crear un secreto de Kubernetes, pero no se utiliza después de la creación.</td>
    </tr>
    </tbody></table>

6.  Verifique que el secreto se haya creado correctamente. Sustituya <em>&lt;kubernetes_namespace&gt;</em> por el nombre del espacio de nombres en el que ha creado imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  Cree un pod que haga referencia a imagePullSecret.
    1.  Cree un archivo de configuración de pod denominado `mypod.yaml`.
    2.  Defina el pod y el imagePullSecret que desea utilizar para acceder al registro privado de {{site.data.keyword.Bluemix_notm}}.

        Una imagen privada de un espacio de nombres:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        Una imagen pública de {{site.data.keyword.Bluemix_notm}}:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tabla 4. Visión general de los componentes del archivo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>El nombre del contenedor que desea desplegar en el clúster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>El espacio de nombres donde se almacena la imagen. Para obtener una lista de los espacios de nombres disponibles, ejecute `bx cr namespace-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>El nombre del imagen que desea utilizar. Para ver una lista de las imágenes disponibles en una cuenta de {{site.data.keyword.Bluemix_notm}}, ejecute `bx cr image-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>La versión de la imagen que desea utilizar. Si no se especifica ninguna etiqueta, se utiliza la imagen etiquetada como <strong>la más reciente (latest)</strong>.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>El nombre del imagePullSecret que ha creado anteriormente.</td>
        </tr>
        </tbody></table>

   3.  Guarde los cambios.
   4.  Cree el despliegue en el clúster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


### Acceso a imágenes públicas desde Docker Hub
{: #dockerhub}

Puede utilizar cualquier imagen pública almacenada en Docker Hub para desplegar un contenedor en el clúster sin configuración adicional.

Antes de empezar:

1.  [Cree un clúster](#cs_cluster_cli).
2.  [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure).

Cree un archivo de configuración de despliegue.

1.  Cree un archivo de configuración denominado `mydeployment.yaml`.
2.  Defina el despliegue y la imagen pública de Docker Hub que desea utilizar. En el siguiente archivo de configuración se utiliza la imagen pública NGINX que está disponible en Docker Hub.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  Cree el despliegue en el clúster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Sugerencia:** Como alternativa, puede desplegar un archivo de configuración existente. En el ejemplo siguiente se utiliza la misa imagen NGINX pública, pero no se aplica directamente al clúster.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### Acceso a imágenes privadas almacenadas en otros registros privados
{: #private_registry}

Si ya tiene un registro privado que desea utilizar, debe almacenar las credenciales del registro en un imagePullSecret de Kubernetes y hacer referencia a dicho secreto en el archivo de configuración.

Antes de empezar:

1.  [Cree un clúster](#cs_cluster_cli).
2.  [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para crear un imagePullSecret:

**Nota:** Los ImagePullSecrets son válidos para los espacios de nombres de Kubernetes para los que se han creado. Repita estos pasos para cada espacio de nombres en el que desea desplegar contenedores desde una imagen de un registro privado de {{site.data.keyword.Bluemix_notm}}.

1.  Cree el secreto de Kubernetes para almacenar las credenciales del registro privado.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tabla 5. Visión general de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obligatorio. El espacio de nombres de Kubernetes del clúster en el que desea utilizar el secreto y desplegar los contenedores. Ejecute <code>kubectl get namespaces</code> para obtener una lista de todos los espacios de nombres del clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Obligatorio. El nombre que desea utilizar para su imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Obligatorio. El URL al registro en el que se están almacenadas sus imágenes privadas.</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Obligatorio. El nombre de usuario para iniciar una sesión en su registro privado.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Obligatorio. El valor de la señal de registro que ha recuperado anteriormente.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Obligatorio. Si tiene una, especifique la dirección de correo electrónico de Docker. Si no tiene una, especifique una dirección de correo electrónico ficticia, como por ejemplo a@b.c. Este correo electrónico es obligatorio para crear un secreto de Kubernetes, pero no se utiliza después de la creación.</td>
    </tr>
    </tbody></table>

2.  Verifique que el secreto se haya creado correctamente. Sustituya <em>&lt;kubernetes_namespace&gt;</em> por el nombre del espacio de nombres en el que ha creado imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  Cree un pod que haga referencia a imagePullSecret.
    1.  Cree un archivo de configuración de pod denominado `mypod.yaml`.
    2.  Defina el pod y el imagePullSecret que desea utilizar para acceder al registro privado de {{site.data.keyword.Bluemix_notm}}. Para utilizar una imagen privada de su registro privado:

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tabla 6. Visión general de los componentes del archivo YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>El nombre del pod que desea crear.</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>El nombre del contenedor que desea desplegar en el clúster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>La vía de acceso completa a la imagen del registro privado que desea utilizar.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>La versión de la imagen que desea utilizar. Si no se especifica ninguna etiqueta, se utiliza la imagen etiquetada como <strong>la más reciente (latest)</strong>.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>El nombre del imagePullSecret que ha creado anteriormente.</td>
        </tr>
        </tbody></table>

  3.  Guarde los cambios.
  4.  Cree el despliegue en el clúster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

<br />


## Adición de servicios de {{site.data.keyword.Bluemix_notm}} a clústeres
{: #cs_cluster_service}

Añada una instancia de servicio de {{site.data.keyword.Bluemix_notm}} existente a un clúster para permitir a los usuarios del clúster acceder y utilizar el servicio de {{site.data.keyword.Bluemix_notm}} cuando desplieguen una app en el clúster.
{:shortdesc}

Antes de empezar:

1. Defina su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).
2. [Solicite una instancia del servicio {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#req_instance).
   **Nota:** Para crear una instancia de un servicio en la ubicación de Washington DC, debe utilizar la CLI.

**Nota:**
<ul><ul>
<li>Sólo puede añadir servicios de {{site.data.keyword.Bluemix_notm}} que den soporte a claves de servicio. Si el servicio no soporta a las claves del servicio, consulte [Habilitación de apps externas para utilizar servicios de {{site.data.keyword.Bluemix_notm}}](/docs/manageapps/reqnsi.html#req_instance).</li>
<li>El clúster y los nodos trabajadores deben desplegarse por completo para poder añadir un servicio.</li>
</ul></ul>


Para añadir un servicio:
2.  Lista de servicios disponibles {{site.data.keyword.Bluemix_notm}}.

    ```
    bx service list
    ```
    {: pre}

    Ejemplo de salida de CLI:

    ```
    name                      service           plan    bound apps   last operation
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  Anote el **nombre** de la instancia de servicio que desea añadir al clúster.
4.  Identifique el espacio de nombres del clúster que desea utilizar para añadir el servicio. Puede elegir entre las siguientes opciones.
    -   Obtenga una lista de los espacios de nombres existentes y elija el espacio de nombres que desea utilizar.

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   Cree un espacio de nombres nuevo en el clúster.

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  Añada el servicio al clúster.

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    Cuando el servicio se haya añadido correctamente al clúster, se crea un secreto de clúster que contiene las credenciales de la instancia de servicio. Ejemplo de salida de CLI:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Verifique que el secreto se ha creado en el espacio de nombres del clúster.

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


Para utilizar el servicio en un pod desplegado en el clúster, los usuarios del clúster pueden acceder a las credenciales de servicio del servicio de {{site.data.keyword.Bluemix_notm}} mediante el [montaje del secreto de Kubernetes como volumen secreto en un pod](cs_apps.html#cs_apps_service).

<br />



## Gestión de acceso a clústeres
{: #cs_cluster_user}

Cada usuario que trabaje con {{site.data.keyword.containershort_notm}} debe tener asignada una combinación de roles de usuario específicos del servicio que determinan las acciones que el usuario puede realizar.
{:shortdesc}

<dl>
<dt>Políticas de acceso de {{site.data.keyword.containershort_notm}}</dt>
<dd>En Identity and Access Management, las políticas de acceso a {{site.data.keyword.containershort_notm}} determinan las acciones de gestión de clúster que puede llevar a cabo en un clúster, como por ejemplo crear o eliminar clústeres y añadir o eliminar nodos trabajadores adicionales. Estas políticas deben establecerse en conjunto con las políticas de infraestructura.</dd>
<dt>Políticas de acceso a infraestructura</dt>
<dd>En Identity and Access Management, las políticas de acceso a infraestructura permiten realizar las acciones solicitadas desde la CLI o la interfaz de usuario de {{site.data.keyword.containershort_notm}} en la infraestructura de IBM Cloud (SoftLayer). Estas políticas deben establecerse en conjunto con las políticas de acceso a {{site.data.keyword.containershort_notm}}. [Más información sobre los roles de infraestructura disponibles](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Grupos de recursos</dt>
<dd>Un grupo de recursos es una forma de organizar servicios de {{site.data.keyword.Bluemix_notm}} en agrupaciones de modo que se pueda asignar rápidamente el acceso a más de un recurso a usuarios a la vez. [Aprenda cómo gestionar usuarios utilizando grupos de recursos](/docs/admin/resourcegroups.html#rgs).</dd>
<dt>Roles de Cloud Foundry</dt>
<dd>En Identity and Access Management, cada usuario debe tener asignado un rol de usuario de Cloud Foundry. Este rol determina las acciones que el usuario puede llevar a cabo en la cuenta de {{site.data.keyword.Bluemix_notm}}, como por ejemplo invitar a otros usuarios o ver el uso de la cuota. [Más información sobre los roles de Cloud Foundry disponibles](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Roles de RBAC de Kubernetes</dt>
<dd>A cada usuario al que se asigne una política de acceso de {{site.data.keyword.containershort_notm}} se le asigna automáticamente un rol de RBAC de Kubernetes. En Kubernetes, los roles de RBAC determinan las acciones que puede realizar sobre los recursos de Kubernetes dentro del clúster. Los roles de RBAC se configuran solo para el espacio de nombres predeterminado. El administrador del clúster puede añadir roles de RBAC para otros espacios de nombres del clúster. Consulte [Utilización de la autorización RBAC ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) en la documentación de Kubernetes para obtener más información.</dd>
</dl>

En esta sección:

-   [Permisos y políticas de acceso](#access_ov)
-   [Adición de usuarios a la cuenta de {{site.data.keyword.Bluemix_notm}}](#add_users)
-   [Personalización de permisos de infraestructura para un usuario](#infrastructure_permissions)

### Permisos y políticas de acceso
{: #access_ov}

Revise las políticas de acceso y los permisos que puede otorgar a los usuarios de la cuenta de {{site.data.keyword.Bluemix_notm}}. El rol de operador y el de editor tienen permisos separados. Si desea que un usuario, por ejemplo, añada nodos de trabajador y servicios de enlace, debe asignar al usuario tanto el rol de operador como el de editor.

|Política de acceso de {{site.data.keyword.containershort_notm}}|Permisos de gestión de clústeres|Permisos de recursos de Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrador|Este rol hereda los permisos de los roles Editor, Operador y Visor para todos los clústeres de esta cuenta. <br/><br/>Cuando se establece para todas las instancias de servicio actuales:<ul><li>Crear un clúster lite o estándar</li><li>Establezca las credenciales para una cuenta de {{site.data.keyword.Bluemix_notm}} para acceder al portafolio de la infraestructura de IBM Cloud (SoftLayer)</li><li>Eliminar un clúster</li><li>Asignar y cambiar políticas de acceso de {{site.data.keyword.containershort_notm}} para otros usuarios existentes en esta cuenta.</li></ul><p>Cuando se establece para un ID de clúster específico:<ul><li>Eliminar un clúster específico</li></ul></p>Política de acceso a infraestructura correspondiente: Superusuario<br/><br/><b>Nota</b>: para crear recursos como máquinas, VLAN y subredes, los usuarios necesitan el rol de infraestructura **Superusuario**.|<ul><li>Rol de RBAC: cluster-admin</li><li>Acceso de lectura/escritura a los recursos en cada espacio de nombres</li><li>Crear roles dentro de un espacio de nombres</li><li>Acceso al panel de control de Kubernetes</li><li>Crear un recurso Ingress que ponga las apps a disponibilidad pública</li></ul>|
|Operador|<ul><li>Añadir nodos trabajadores adicionales a un clúster</li><li>Eliminar nodos trabajadores de un clúster</li><li>Rearrancar un nodo trabajador</li><li>Volver a cargar un nodo trabajador</li><li>Añadir una subred a un clúster</li></ul><p>Política de acceso a infraestructura correspondiente: Usuario básico</p>|<ul><li>Rol de RBAC: administrador</li><li>Acceso de lectura/escritura a recursos dentro del espacio de nombres predeterminado pero no para el espacio de nombres en sí</li><li>Crear roles dentro de un espacio de nombres</li></ul>|
|Editor <br/><br/><b>Consejo</b>: utilice este rol para los desarrolladores de apps.|<ul><li>Enlazar un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.</li><li>Desenlazar un servicio de {{site.data.keyword.Bluemix_notm}} a un clúster.</li><li>Crear un webhook.</li></ul><p>Política de acceso a infraestructura correspondiente: Usuario básico|<ul><li>Rol de RBAC: editar</li><li>Acceso de lectura/escritura a los recursos internos del espacio de nombres predeterminado</li></ul></p>|
|Visor|<ul><li>Listar un clúster</li><li>Ver los detalles de un clúster</li></ul><p>Política de acceso a infraestructura correspondiente: Solo visualización</p>|<ul><li>Rol de RBAC: ver</li><li>Acceso de lectura a los recursos internos del espacio de nombres predeterminado</li><li>Sin acceso de lectura a los secretos de Kubernetes</li></ul>|
{: caption="Tabla 7. Políticas de acceso y permisos necesarios de {{site.data.keyword.containershort_notm}}" caption-side="top"}

|Política de acceso de Cloud Foundry|Permisos de gestión de cuentas|
|-------------|------------------------------|
|Rol de la organización: Gestor|<ul><li>Añadir usuarios adicionales a una cuenta de {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Rol del espacio: Desarrollador|<ul><li>Crear instancias de servicio de {{site.data.keyword.Bluemix_notm}}</li><li>Vincular instancias de servicio de {{site.data.keyword.Bluemix_notm}} a clústeres</li></ul>| 
{: caption="Tabla 8. Políticas de acceso y permisos necesarios de Cloud Foundry" caption-side="top"}


### Adición de usuarios a una cuenta de {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Puede añadir usuarios adicionales a una cuenta de {{site.data.keyword.Bluemix_notm}} para otorgarles acceso a sus clústeres.

Antes de empezar, verifique que se le haya asignado el rol de Gestor de Cloud Foundry para una cuenta de {{site.data.keyword.Bluemix_notm}}.

1.  [Añada el usuario a la cuenta](../iam/iamuserinv.html#iamuserinv).
2.  En la sección **Acceso**, expanda **Servicios**.
3.  Asigne un rol de acceso de {{site.data.keyword.containershort_notm}}. Desde la lista desplegable **Asignar acceso a**, decida si desea conceder acceso solo a su cuenta de {{site.data.keyword.containershort_notm}} (**Recurso**) o a una colección de varios recursos dentro de la cuenta (**Grupo de recursos**).
  -  Para **Recurso**:
      1. En la lista desplegable **Servicios**, seleccione **{{site.data.keyword.containershort_notm}}**.
      2. En la lista desplegable **Región**, seleccione la zona a la que va a invitar al usuario.
      3. En la lista desplegable **Instancia de servicio**, seleccione el clúster al que va a invitar al usuario. Para encontrar el ID de un clúster específico, ejecute ` bx cs clusters`.
      4. En la sección **Seleccionar roles**, seleccione un rol. Para ver una lista de las acciones admitidas por rol, consulte [Permisos y políticas de acceso](#access_ov).
  - Para **Grupo de recursos**:
      1. Desde la lista desplegable **Grupo de recursos**, seleccione el grupo de recursos, seleccione el grupo de recursos que incluya permisos para el recurso {{site.data.keyword.containershort_notm}} de la cuenta.
      2. Desde la lista desplegable **Asignar acceso a un grupo de recursos**, seleccione un rol. Para ver una lista de las acciones admitidas por rol, consulte [Permisos y políticas de acceso](#access_ov).
4. [Opcional: asigne un rol de infraestructura](/docs/iam/mnginfra.html#managing-infrastructure-access).
5. [Opcional: asigne un rol de Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. Pulse **Invitar a usuarios**.



### Personalización de permisos de infraestructura para un usuario
{: #infrastructure_permissions}

Cuando se establecen las políticas de infraestructura en Identity and Access Management, se otorgan permisos a un usuario asociados con un rol. Para personalizar esos permisos, debe iniciar sesión en la infraestructura de IBM Cloud (SoftLayer) y ajustar los permisos allí.
{: #view_access}

Por ejemplo, los usuarios básicos pueden reiniciar un nodo de trabajador, pero no pueden recargarlo. Sin dar a esa persona permisos de superusuario, puede ajustar los permisos de la infraestructura de IBM Cloud (SoftLayer) y añadir el permiso para ejecutar un mandato de recarga.

1.  Inicie sesión en la cuenta de infraestructura de IBM Cloud (SoftLayer).
2.  Seleccione un perfil de usuario que desee actualizar.
3.  En **Permisos de portal**, personalice el acceso del usuario. Por ejemplo, para añadir un permiso de recarga, en el separador **Dispositivos**, seleccione **Emitir recargas de SO e iniciar el kernel de rescate**.
9.  Guarde los cambios.

<br />



## Actualización del Kubernetes maestro
{: #cs_cluster_update}

Kubernetes actualiza periódicamente las [versiones principales, menores y las revisiones](cs_versions.html#version_types), que afectan a los clústeres. La actualización de un clúster es un proceso de dos pasos. Primero, debe actualizar el Kubernetes maestro y luego puede actualizar cada uno de los nodos trabajadores.

De forma predeterminada, no se puede actualizar un maestro de Kubernetes con una antigüedad superior a dos versiones. Por ejemplo, si el maestro actual es de la versión 1.5 y desea actualizar a 1.8, primero se debe actualizar a la versión 1.7. Puede formar la actualización para continuar, pero actualizar a dos versiones anteriores puede provocar resultados imprevistos.

**Atención**: siga las instrucciones de actualización y utilice un clúster de prueba para abordar posibles interrupciones de la app y durante la actualización. No puede retrotraer un clúster a una versión anterior.

Cuando realice una actualización _mayor_ o _menor_, siga estos pasos.

1. Revise los [cambios de Kubernetes](cs_versions.html) y realice las actualizaciones marcadas como _Actualizar antes que maestro_.
2. Actualizar el Kubernetes maestro mediante la GUI o mediante la ejecución del [mandato de CLI](cs_cli_reference.html#cs_cluster_update). Cuando actualice el Kubernetes maestro, el maestro está inactivo durante unos 5 o 10 minutos. Durante la actualización, no puede acceder ni cambiar el clúster. Sin embargo, los nodos trabajadores, las apps y los recursos que los usuarios del clúster han desplegado no se modifican y continúan ejecutándose.
3. Confirme que la actualización se ha completado. Revise la versión de Kubernetes en el panel de control de {{site.data.keyword.Bluemix_notm}} o ejecutando `cs bx clusters`.

Cuando finalice la actualización del Kubernetes maestro, puede actualizar los nodos trabajadores.

<br />


## Actualización de nodos trabajadores
{: #cs_cluster_worker_update}

Mientras que IBM aplica automáticamente parches al Kubernetes maestro, es necesario actualizar explícitamente los nodos trabajadores para actualizaciones principales y secundarias. La versión del nodo trabajador puede ser superior al Kubernetes maestro.

**Atención**: las actualizaciones a los nodos trabajadores pueden hacer que las apps y servicios estén un tiempo inactivos:
- Los datos se suprimen si no están almacenados fuera del pod.
- Utilice [réplicas ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) si los despliegues permiten volver a planificar pods en nodos disponibles.

Actualización de clústeres a nivel de producción:
- Para ayudar a evitar el tiempo de inactividad en las apps, el proceso de actualización impide que los pods se planifiquen en el nodo trabajador durante la actualización. Consulte [`kubectl drain` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain) para obtener más información.
- Utilice un clúster de prueba para validar que las cargas de trabajo y el proceso de entrega no se vean afectados por la actualización. No puede retrotraer los nodos trabajadores a una versión anterior.
- Los clústeres de nivel de producción deberían tener capacidad para sobrevivir a un error en el nodo trabajador. Si el clúster no lo hace, añada un nodo trabajador antes de actualizar el clúster.
- Las actualizaciones continuas se realizan cuando se solicita la actualización de varios nodos trabajadores. Se puede actualizar un máximo de 20 nodos trabajadores en total en un clúster simultáneamente. El proceso de actualización esperará a que finalice la actualización de un nodo trabajador antes de iniciar la actualización de otro trabajador.


1. Instale la versión de [`kubectl cli` ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) que coincida con la versión de Kubernetes del Kubernetes maestro.

2. Aplique los cambios que se marcan como _Actualizar después de maestro_ en [Cambios de Kubernetes](cs_versions.html).

3. Actualice los nodos trabajadores:
  * Para actualizar desde el panel de control de {{site.data.keyword.Bluemix_notm}}, vaya a la sección `Nodos trabajadores` del clúster y pulse `Actualizar trabajador`.
  * Para obtener los ID de los nodos trabajadores, ejecute `bx cs workers <cluster_name_or_id>`. Si selecciona varios nodos trabajadores, los nodos trabajadores se actualizan de uno en uno.

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. Confirme que la actualización se ha completado:
  * Revise la versión de Kubernetes en el panel de control de {{site.data.keyword.Bluemix_notm}} o ejecutando `cs bx workers <cluster_name_or_id>`.
  * Revise la versión de Kubernetes de los nodos trabajadores ejecutando `kubectl get nodes`.
  * En algunos casos, es posible que los clústeres antiguos muestren nodos trabajadores duplicados con el estado **NotReady** después de una actualización. Para eliminar los duplicados, consulte [resolución de problemas](cs_troubleshoot.html#cs_duplicate_nodes).

Después de completar la actualización:
  - Repita el proceso de actualización con otros clústeres.
  - Informe a los desarrolladores que trabajan en el clúster para que actualicen su CLI de `kubectl` a la versión del Kubernetes maestro.
  - Si el panel de control de Kubernetes no muestra los gráficos de utilización, [suprima el pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).

<br />


## Adición de subredes a clústeres
{: #cs_cluster_subnet}

Cambie la agrupación de las direcciones IP públicas o privadas portátiles disponibles añadiendo subredes a su clúster.
{:shortdesc}

En {{site.data.keyword.containershort_notm}}, tiene la posibilidad de añadir direcciones IP portátiles y estables para los servicios de Kubernetes añadiendo subredes al clúster. En este caso, las subredes no se utilizan con máscara de red para crear conectividad entre uno o varios clústeres. En su lugar, las subredes se utilizan para proporcionar IP fijas permanentes para un servicio de un clúster que puede utilizarse para acceder a ese servicio.

Cuando se crea un clúster estándar, {{site.data.keyword.containershort_notm}} automáticamente suministra una subred pública portátil con 5 direcciones IP públicas portátiles y una subred privada portátil con 5 direcciones IP privadas. Las direcciones IP públicas y privadas portátiles son estáticas y no cambian cuando se elimina un nodo trabajador o incluso el clúster. Para cada subred, una de las direcciones públicas portátiles y una de las direcciones IP privadas portátiles se utilizan para los [equilibradores de carga de aplicación](cs_apps.html#cs_apps_public_ingress), que puede utilizar para exponer varias apps en el clúster. Las 4 direcciones IP públicas portátiles y las 4 direcciones IP privadas portátiles restantes se pueden utilizar para exponer apps individuales al público mediante la [creación de un servicio equilibrador de carga](cs_apps.html#cs_apps_public_load_balancer).

**Nota:** Las direcciones IP públicas portátiles se facturan mensualmente. Si decide retirar las direcciones IP públicas portátiles una vez suministrado el clúster, tendrá que pagar el cargo mensual, aunque solo las haya utilizado un breve periodo de tiempo.

### Solicitud de subredes adicionales para el clúster
{: #add_subnet}

Puede añadir direcciones IP públicas o privadas portátiles estables al clúster asignándole subredes.

**Nota:** Cuando se pone una subred a disponibilidad de un clúster, las direcciones IP de esta subred se utilizan para la gestión de redes del clúster. Para evitar conflictos de direcciones IP, asegúrese de utilizar una subred con un solo clúster. No utilice una subred para varios clústeres o para otros fines externos a {{site.data.keyword.containershort_notm}} al mismo tiempo.

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Para crear una subred en una cuenta de infraestructura de IBM Cloud (SoftLayer) y ponerla a disponibilidad de un determinado clúster:

1. Suministre una subred nueva.

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>Tabla 8. Visión general de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>El mandato para suministrar una subred para el clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td>Sustituya <code>&gt;cluster_name_or_id&lt;</code> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>Sustituya <code>&gt;subnet_size&lt;</code> por el número de direcciones IP que desea añadir desde la subred portátil. Los valores aceptados son 8, 16, 32 o 64. <p>**Nota:** Cuando añade direcciones IP portátiles para la subred, se utilizan tres direcciones IP para establecer conexión por red clúster-interna, de modo que no puede utilizarlas para el equilibrador de carga de aplicación o para crear un servicio equilibrador de carga. Por ejemplo, si solicita ocho direcciones IP públicas portátiles, puede utilizar cinco de ellas para exponer sus apps al público.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Sustituya <code>&gt;VLAN_ID&lt;</code> con el ID de la VLAN pública o privada a la que desea asignar las direcciones IP públicas o privadas portátiles. Debe seleccionar la VLAN pública o privada a la que está conectado el nodo trabajador existente. Para revisar la VLAN pública o privada para los nodos trabajadores, ejecute el mandato <code>bx cs worker-get &gt;worker_id&lt;</code>.</td>
    </tr>
    </tbody></table>

2.  Compruebe que la subred se haya creado y añadido correctamente al clúster. El CIDR de subred se muestra en la sección **VLAN**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### Adición de subredes existentes y personalizadas a clústeres de Kubernetes
{: #custom_subnet}

Existe la posibilidad de añadir subredes públicas o privadas portátiles existentes a su clúster de Kubernetes.

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Si tiene una subred existente en su portafolio de infraestructura de IBM Cloud (SoftLayer) con reglas de cortafuegos personalizadas o con direcciones IP disponibles que desea utilizar, cree un clúster sin subredes y haga que su subred existente esté disponible para el clúster al suministrar dicho clúster.

1.  Identifique la subred que desea utilizar. Anote el ID de la subred y el ID de la VLAN. En este ejemplo, el ID de subred es 807861 y el ID de la VLAN es 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Confirme la ubicación en la que se encuentra la VLAN. En este ejemplo, la ubicación es dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router
    1900403   vlan                    1391     private   bcr01a.dal10
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Cree un clúster utilizando el ID de VLAN y la ubicación que ha identificado. Incluya el distintivo `--no-subnet` para evitar que de forma automática se creen una nueva subred IP pública y privada portátiles.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Verifique que ha solicitado la creación del clúster.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** Puede llevar hasta 15 minutos la ordenación de las máquinas del nodo trabajador y la configuración y suministro del clúster
en su cuenta.

    Una vez completado el suministro del clúster, el estado del clúster pasa a ser **deployed**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Compruebe el estado de los nodos trabajadores.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Cuando los nodos trabajadores están listos, el estado pasa a **normal** y el estado es **Ready**. Cuando el estado del nodo sea **Preparado**, podrá acceder al clúster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Añada la subred al clúster especificando el ID de subred. Cuando pone una subred a disponibilidad de un clúster, se crea automáticamente una correlación de configuración de Kubernetes que incluye todas las direcciones IP públicas portátiles disponibles que puede utilizar. Si no existen equilibradores de carga de aplicación para el clúster, se utilizan automáticamente una dirección IP pública portátil y una dirección IP privada portátil para crear los equilibradores de carga de aplicación público y privado. El resto de las direcciones IP públicas y privadas portátiles se pueden utilizar para crear servicios equilibradores de carga para las apps.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### Adición de subredes y direcciones IP gestionadas por el usuario a clústeres de Kubernetes
{: #user_subnet}

Especifique su propia subred desde una red local a la que desea que acceda {{site.data.keyword.containershort_notm}}. A continuación, puede añadir direcciones IP privadas desde dicha subred a los servicios del equilibrador de carga del clúster de Kubernetes.

Requisitos:
- Las subredes gestionadas por el usuario solo se pueden añadir a VLAN privadas.
- El límite de longitud del prefijo de subred es de /24 a /30. Por ejemplo, `203.0.113.0/24` especifica 253 direcciones IP privadas que se pueden utilizar, mientras que `203.0.113.0/30` especifica 1 dirección IP privada que se puede utilizar.
- La primera dirección IP de la subred se debe utilizar como pasarela para la subred.

Antes de empezar: Configure el direccionamiento del tráfico de red de entrada y de salida de la subred externa. Además, confirme que tiene conectividad VPN entre el dispositivo de pasarela del centro de datos local y Vyatta de la red privada en el portafolio de infraestructura de IBM Cloud (SoftLayer). Para obtener más información, consulte esta [publicación del blog ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).

1. Consulte el ID de la VLAN privada del clúster. Localice la sección **VLAN**. En el campo **User-managed**, identifique el ID de VLAN con _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Añada la subred externa a la VLAN privada. Las direcciones IP privadas portátiles se añaden al mapa de configuración del clúster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Ejemplo:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Verifique que se ha añadido la subred proporcionada por el usuario. El campo **User-managed** es _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Añada un servicio de equilibrador de carga privado o un equilibrador de carga de aplicación de Ingress privado para acceder a la app sobre la red privada. Si desea utilizar una dirección IP privada de la subred que ha añadido al crear un equilibrador de carga privado o un equilibrador de carga de aplicación de Ingress privado, debe especificar una dirección IP. De lo contrario, se elige una dirección IP aleatoria de las subredes de infraestructura de IBM Cloud (SoftLayer) o las subredes proporcionadas por el usuario en la VLAN privada. Para obtener más información, consulte [Configuración del acceso a una app utilizando el tipo de servicio LoadBalancer](cs_apps.html#cs_apps_public_load_balancer) o [Habilitación del equilibrador de carga de aplicación privado](cs_apps.html#private_ingress).

<br />


## Utilización de recursos compartidos de archivos de NFS existentes en clústeres
{: #cs_cluster_volume_create}

Si ya tiene recursos compartidos de archivos NFS existentes en su cuenta de infraestructura de IBM Cloud (SoftLayer) que desea utilizar con Kubernetes, puede hacerlo creando volúmenes permanentes en el recurso compartido existente de archivos NFS. Un volumen permanente es una parte del hardware real que sirve como recurso de clúster de Kubernetes y que puede ser consumido por el usuario del clúster.
{:shortdesc}

Kubernetes diferencia entre volúmenes permanentes, que representan el hardware real, y reclamaciones de volumen permanente, que son solicitudes de almacenamiento, generalmente iniciadas por el usuario del clúster. En el siguiente diagrama se ilustra la relación entre los volúmenes persistentes y las reclamaciones de volumen persistente.

![Cree volúmenes permanentes y reclamaciones de volúmenes permanentes](images/cs_cluster_pv_pvc.png)

 Tal como se muestra en el diagrama, para habilitar los recursos compartidos de archivos NFS existentes para utilizarlos con Kubernetes, debe crear persistentes volúmenes permanentes con un determinado tamaño y modalidad de acceso y crear una reclamación de volumen permanente que coincida con la especificación de volumen permanente. Si el volumen permanente y la reclamación de volumen permanente coinciden, se enlazan. El usuario del clúster solo puede utilizar reclamaciones de volumen permanente enlazadas para montar el volumen en un despliegue. Este proceso se conoce como suministro estático de almacenamiento permanente.

Antes de empezar, asegúrese de que tiene un recurso compartido de archivos NFS existentes que puede utilizar para crear el volumen permanente.

**Nota:** El suministro estático de almacenamiento permanente sólo se aplica a recursos compartidos de archivos NFS existentes. Si no tiene recursos compartidos de archivos NFS existentes, los usuarios del clúster puedan utilizar el proceso de [suministro dinámico](cs_apps.html#cs_apps_volume_claim) para añadir volúmenes permanente.

Para crear un volumen permanente y una reclamación de volumen permanente coincidente, siga estos pasos:

1.  En la cuenta de infraestructura de IBM Cloud (SoftLayer), busque el ID y la vía de acceso del recurso compartido de archivos NFS en el que desea crear el objeto de volumen permanente. Además, autorice el almacenamiento de archivos para las subredes del clúster. Esta autorización proporciona al clúster acceso al almacenamiento.
    1.  Inicie sesión en la cuenta de infraestructura de IBM Cloud (SoftLayer).
    2.  Pulse **Almacenamiento**.
    3.  Pulse **Almacenamiento de archivos** y, en el menú **Acciones**, seleccione **Autorizar host**.
    4.  Pulse **Subredes**. Una vez realizada la autorización, todos los nodos de trabajador de la subred tendrán acceso al almacenamiento de archivos.
    5.  Seleccione la subred de VLAN pública del clúster desde el menú y pulse **Enviar**. If Si necesita encontrar la subred, ejecute `bx cs cluster-get <cluster_name> --showResources`.
    6.  Pulse el nombre del almacenamiento de archivos.
    7.  Anote el campo **Punto de montaje**. El campo se muestra como `<server>:/<path>`.
2.  Cree un archivo de configuración de almacenamiento para el volumen permanente. Incluya el servidor y la vía de acceso del campo **Punto de montaje** del almacenamiento de archivos.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>Tabla 9. Visión general de los componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Especifique el nombre del objeto de volumen permanente que crear.</td>
    </tr>
    <tr>
    <td><code>storage</code></td>
    <td>Especifique el tamaño de almacenamiento del recurso compartido de archivos NFS existente. El tamaño de almacenamiento se debe especificar en gigabytes, por ejemplo, 20Gi (20 GB) o 1000Gi (1 TB), y el tamaño debe coincidir con el tamaño del recurso compartido de archivos existente.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Las modalidades de acceso definen el modo de montar la reclamación de volumen permanente en un nodo trabajador.<ul><li>ReadWriteOnce (RWO): el volumen permanente se puede montar en despliegues únicamente en un solo nodo trabajador. Los contenedores en despliegues que se montan en este volumen permanente pueden leer el volumen y grabar en el mismo.</li><li>ReadOnlyMany (ROX): el volumen permanente se puede montar en despliegues albergados en varios nodos trabajadores. Los despliegues que se montan en este volumen permanente solo pueden leer el volumen.</li><li>ReadWriteMany (RWX): el volumen permanente se puede montar en despliegues albergados en varios nodos trabajadores. Los despliegues que se montan en este volumen permanente pueden leer el volumen y grabar en el mismo.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Escriba el ID del servidor de recursos compartidos de archivos NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Especifique la vía de acceso al recurso compartido de archivos NFS en el que desea crear el objeto de volumen permanente.</td>
    </tr>
    </tbody></table>

3.  Cree el objeto de volumen permanente en el clúster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Ejemplo

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  Compruebe que el volumen permanente se haya creado.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Cree otro archivo de configuración para crear la reclamación de volumen permanente. Para que la reclamación de volumen permanente coincida con el objeto de volumen permanente que ha creado anteriormente, debe elegir el mismo valor para `storage` y `accessMode`. El campo `storage-class` debe estar vacío. Si alguno de estos campos no coincide con el volumen permanente, se crea automáticamente un nuevo volumen permanente.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  Cree la reclamación de volumen permanente.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Compruebe que la reclamación de volumen permanente se haya creado y vinculado al objeto de volumen permanente. Este proceso puede tardar unos minutos.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    La salida es parecida a la siguiente.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Ha creado correctamente un objeto de volumen permanente y lo ha enlazado a una reclamación de volumen permanente. Ahora los usuarios del clúster pueden [montar la reclamación de volumen permanente](cs_apps.html#cs_apps_volume_mount) en sus despliegues y empezar a leer el objeto de volumen permanente y a grabar en el mismo.

<br />


## Configuración del registro de clúster
{: #cs_logging}

Los registros le ayudan a resolver problemas con los clústeres y apps. En ocasiones, es posible que desee enviar registros a una ubicación específica para su procesamiento o almacenamiento a largo plazo. En un clúster de Kubernetes en {{site.data.keyword.containershort_notm}}, puede habilitar el reenvío de registros a varios orígenes de registro de clúster y elegir dónde se reenvían los registros. **Nota**: el reenvío de registros solo se soporta para los clústeres estándar.
{:shortdesc}

Puede reenviar registros para orígenes de registro, como aplicaciones, nodos trabajadores, clústeres de Kubernetes y controladores de Ingress. Revise la tabla siguiente para obtener información sobre cada origen de registro.

|Origen de registro|Características|Vías de acceso de registro|
|----------|---------------|-----|
|`contenedor`|Registra el contenedor que se ejecuta en un clúster de Kubernetes.|-|
|`aplicación`|Registra la aplicación que se ejecuta en un clúster de Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`worker`|Registra nodos trabajadores de máquinas virtuales dentro de un clúster de Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Registra el componente del sistema de Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Registra un equilibrador de carga de aplicación, gestionado por el controlador de Ingress, que gestiona el tráfico de red entrante en un clúster de Kubernetes.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Tabla 9. Características de los orígenes de registro." caption-side="top"}

### Habilitación del reenvío de registros
{: #cs_log_sources_enable}

Puede reenviar registros a {{site.data.keyword.loganalysislong_notm}} o a un servidor syslog externo. Si desea reenviar los registros de un origen de registro a ambos servidores del recopilador de registro, debe crear dos configuraciones de registro. **Nota**: Para reenviar registros para aplicaciones, consulte [Habilitación del reenvío de registros para aplicaciones](#cs_apps_enable).
{:shortdesc}

Antes de empezar:

1. Si desea reenviar los registros a un servidor syslog externo, puede configurar un servidor que acepte un protocolo syslog de dos maneras:
  * Puede configurar y gestionar su propio servidor o dejar que lo gestione un proveedor. Si un proveedor gestiona el servidor, obtenga el punto final de registro del proveedor de registro.
  * Puede ejecutar syslog desde un contenedor. Por ejemplo, puede utilizar este archivo [deployment .yaml ![Icono de archivo externo](../icons/launch-glyph.svg "Icono de archivo externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para obtener una imagen pública de Docker que ejecute un contenedor en un clúster de Kubernetes. La imagen publica el puerto `514` en la dirección IP del clúster público y utiliza esta dirección IP del clúster público para configurar el host de syslog.

2. Elija como [destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster en el que se encuentra el origen de registro.

Para habilitar el reenvío de registros para un contenedor, nodo de trabajador, componente del sistema Kubernetes, aplicación o equilibrador de carga de aplicación de Ingress:

1. Cree una configuración de reenvío de registro.

  * Para reenviar registros a {{site.data.keyword.loganalysislong_notm}}:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --spaceName <cluster_space> --orgName <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>Tabla 10. Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>El mandato para crear una configuración de reenvío de registro de {{site.data.keyword.loganalysislong_notm}}.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_log_source&gt;</em> por el origen de registro. Los valores aceptados son <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Sustituya <em>&lt;kubernetes_namespace&gt;</em> con el espacio de nombres de contenedor de Docker desde el que desea reenviar los registros. El reenvío de registros no recibe soporte para los espacios de nombres de Kubernetes <code>ibm-system</code> y <code>kube-system</code>. Este valor sólo es válido para el origen de registro de contenedor y es opcional. Si no especifica un espacio de nombres, todos los espacios de nombres del contenedor utilizarán esta configuración.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>Sustituya <em>&lt;ingestion_URL&gt;</em> con el URL de ingestión de {{site.data.keyword.loganalysisshort_notm}}. Puede encontrar la lista de URL de ingestión disponible [aquí](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Si no especifica un URL de ingestión, se utiliza el punto final de la región en la que se ha creado el clúster.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>Sustituya <em>&lt;ingestion_port&gt;</em> con el puerto ingestión. Si no especifica un puerto, se utiliza el puerto estándar, <code>9091</code>.</td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_space&gt;</em> con el nombre del espacio al que desea enviar registros. Si no especifica un espacio, los registros se envían al nivel de cuenta.</td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_org&gt;</em> con el nombre de la organización en la que está el espacio. Este valor es necesario si ha especificado un espacio.</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>El tipo de registro para enviar registros a {{site.data.keyword.loganalysisshort_notm}}.</td>
    </tr>
    </tbody></table>

  * Para reenviar registros a un servidor syslog externo:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tabla 11. Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>El mandato para crear una configuración de reenvío de registro de syslog.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_log_source&gt;</em> por el origen de registro. Los valores aceptados son <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Sustituya <em>&lt;kubernetes_namespace&gt;</em> con el espacio de nombres de contenedor de Docker desde el que desea reenviar los registros. El reenvío de registros no recibe soporte para los espacios de nombres de Kubernetes <code>ibm-system</code> y <code>kube-system</code>. Este valor sólo es válido para el origen de registro de contenedor y es opcional. Si no especifica un espacio de nombres, todos los espacios de nombres del contenedor utilizarán esta configuración.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_server_hostname&gt;</em> por el nombre de host o dirección IP del servicio del recopilador de registro.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_server_port&gt;</em> por el puerto del servidor del recopilador de registro. Si no especifica un puerto, se utiliza el puerto estándar, <code>514</code>.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>El tipo de registro para enviar registros a un servidor syslog externo.</td>
    </tr>
    </tbody></table>

2. Verifique que la configuración de reenvío de registros se ha creado.

    * Para obtener una lista de todas las configuraciones de registro del clúster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Para obtener una lista de las configuraciones de registro para un tipo de origen de registro:
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### Habilitación del reenvío de registros para aplicaciones
{: #cs_apps_enable}

Los registros desde aplicaciones se deben limitar a un directorio específico del nodo principal. Para hacerlo, monte un volumen de vía de acceso de host a los contenedores con una vía de acceso de montaje. Esta vía de acceso de montaje sirve de directorio en los contenedores donde se envían los registros de aplicación. El directorio de la vía de acceso del host predefinido, `/var/log/apps`, se crea automáticamente al crear el montaje de volumen.

Revise los siguientes aspectos del reenvío de registro de aplicación:
* Los registros se leen recursivamente desde la vía de acceso /var/log/apps. Esto significa que puede colocar registros de aplicación en subdirectorios de la vía de acceso /var/log/apps.
* Solo se reenvía los archivos de registro de aplicación con las extensiones de archivo `.log` o `.err`.
* Cuando se habilita el reenvío de registro por primera vez, los registros de aplicación no se leen desde el principio. Es decir, el contenido de los registros que ya existían antes de la habilitación del registro de aplicación no se leen. Los registros se leen a partir del momento en que se habilita el registro. Sin embargo, a partir de la primera vez en que se habilita el reenvío de registro, los registros se recogen desde donde se dejaron.
* Cuando monte el volumen de la vía de acceso de host `/var/log/apps` en los contenedores, grabe todos los contenedores en este directorio. Esto significa que si los contenedores están grabando en el mismo nombre de archivo, los contenedores grabarán exactamente en el mismo archivo del host. Si esta no es su intención, puede evitar que los contenedores sobrescriban los mismos archivos de registro asignando otro nombre a los archivos de registro de cada contenedor.
* Puesto que todos los contenedores graban en el mismo nombre de archivo, no se debe utilizar este método para reenviar registros de aplicaciones de ReplicaSets. En su lugar, puede escribir los registros desde la aplicación a STDOUT y STDERR, que se seleccionan como registros de contenedor. Para reenviar registros de aplicaciones grabadas en STDOUT y STDERR, siga los pasos de [Habilitación del reenvío de registro](cs_cluster.html#cs_log_sources_enable).

Antes de empezar, [destino su CLI](cs_cli_install.html#cs_cli_configure) para el clúster donde se encuentra el origen de registro.

1. Abra el archivo de configuración `.yaml` del pod de la aplicación.

2. Añada `volumeMounts` y `volúmenes` al archivo de configuración:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Monte el volumen en el pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Para crear una configuración de reenvío de registros, siga los pasos de [Habilitación del reenvío de registro](cs_cluster.html#cs_log_sources_enable).

### Actualización de la configuración de reenvío de registros
{: #cs_log_sources_update}

Puede actualizar una configuración de registro para un contenedor, aplicación, nodo de trabajador, componente del sistema Kubernetes o equilibrador de carga de aplicación de Ingress.
{: shortdesc}

Antes de empezar:

1. Si está cambiando el servidor del recopilador de registros a syslog, puede configurar un servidor que acepte un protocolo syslog de dos maneras:
  * Puede configurar y gestionar su propio servidor o dejar que lo gestione un proveedor. Si un proveedor gestiona el servidor, obtenga el punto final de registro del proveedor de registro.
  * Puede ejecutar syslog desde un contenedor. Por ejemplo, puede utilizar este archivo [deployment .yaml ![Icono de archivo externo](../icons/launch-glyph.svg "Icono de archivo externo")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) para obtener una imagen pública de Docker que ejecute un contenedor en un clúster de Kubernetes. La imagen publica el puerto `514` en la dirección IP del clúster público y utiliza esta dirección IP del clúster público para configurar el host de syslog.

2. Elija como [destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster en el que se encuentra el origen de registro.

Para cambiar los detalles de una configuración de registro:

1. Actualice la configuración de registro.

    ```
    bx cs logging-config-update <my_cluster> <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --spaceName <cluster_space> --orgName <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Tabla 12. Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Descripción de los componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>El mandato para actualizar la configuración del reenvío de registros para el origen de registro.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;log_config_id&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_config_id&gt;</em> por el ID de la configuración del origen de registro.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_log_source&gt;</em> por el origen de registro. Los valores aceptados son <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Cuando el tipo de registro es <code>syslog</code>, sustituya <em>&lt;log_server_hostname_or_IP&gt;</em> con el nombre de host o dirección IP del servicio del recopilador de registro. Cuando el tipo de registro es <code>ibm</code>, sustituya <em>&lt;log_server_hostname&gt;</em> con el URL de ingestión de {{site.data.keyword.loganalysislong_notm}}. Puede encontrar la lista de URL de ingestión disponible [aquí](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Si no especifica un URL de ingestión, se utiliza el punto final de la región en la que se ha creado el clúster.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Sustituya <em>&lt;log_server_port&gt;</em> por el puerto del servidor del recopilador de registro. Si no especifica un puerto, se utiliza el puerto estándar <code>514</code> para <code>syslog</code> y el <code>9091</code> para <code>ibm</code>.</td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_space&gt;</em> con el nombre del espacio al que desea enviar registros. Este valor sólo es válido para el registro de tipo <code>ibm</code> y es opcional. Si no especifica un espacio, los registros se envían al nivel de cuenta.</td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td>Sustituya <em>&lt;cluster_org&gt;</em> con el nombre de la organización en la que está el espacio. Este valor sólo es válido para el registro de tipo <code>ibm</code> y es necesario si ha especificado un espacio.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Sustituya <em>&lt;logging_type&gt;</em> por protocolo de reenvío de registros que desea utilizar. Actualmente se da soporte a <code>syslog</code> e <code>ibm</code>.</td>
    </tr>
    </tbody></table>

2. Verifique que la configuración de reenvío de registros se ha actualizado.

    * Para obtener una lista de todas las configuraciones de registro del clúster:

      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Para obtener una lista de las configuraciones de registro para un tipo de origen de registro:

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Salida de ejemplo:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

### Detención del reenvío de registros
{: #cs_log_sources_delete}

Puede detener el reenvío de registros mediante la supresión de la configuración de registro.

Antes de empezar, [destino su CLI](cs_cli_install.html#cs_cli_configure) para el clúster donde se encuentra el origen de registro.

1. Suprima la configuración de registro.

    ```
    bx cs logging-config-rm <my_cluster> <log_config_id>
    ```
    {: pre}
    Sustituya <em>&lt;my_cluster&gt;</em> por el nombre del clúster en el que está la configuración de registro y <em>&lt;log_config_id&gt;</em> por el ID de la configuración del origen de registro.

### Configuración de reenvío de registros para registros de auditoría de API de Kubernetes
{: #cs_configure_api_audit_logs}

Los registros de auditoría de API de Kubernetes capturan las llamadas al servidor de API de Kubernetes desde el clúster. Para empezar a recopilar registros de auditoría de API de Kubernetes, puede configurar el servidor de API de Kubernetes para establecer un programa de fondo de webhook para el clúster. Este programa de fondo de webhook permite enviar registros a un servidor remoto. Para obtener más información sobre los registros de auditoría de Kubernetes, consulte el <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">tema sobre auditoría <img src="../icons/launch-glyph.svg" alt="Icono de enlace externo"></a> en la documentación de Kubernetes.

**Nota**:
* El reenvío de registros de auditoría de API de Kubernetes sólo está admitido en la versión 1.7 de Kubernetes y posterior.
* Actualmente, se utiliza una política de auditoría predeterminada para todos los clústeres con esta configuración de registro.

#### Habilitación del reenvío de registros de auditoría de API de Kubernetes
{: #cs_audit_enable}

Antes de empezar, seleccione [como destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster del que desea recopilar los registros de auditoría del servidor de API.

1. Establecer el programa de fondo del webhook para la configuración del servidor de API. Se crea una configuración de webhook basándose en la información que proporciona en los distintivos de este mandato. Si no proporciona ninguna información en los distintivos, se utiliza una configuración de webhook predeterminada.

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>Tabla 13. Descripción de los componentes de este mandato</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Componentes de este mandato</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>El mandato para establecer una opción para la configuración de servidor de API de Kubernetes del clúster.</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>El submandato para establecer la configuración del webhook de auditoría del servidor de API de Kubernetes del clúster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sustituya <em>&lt;my_cluster&gt;</em> por el nombre o el ID del clúster.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>Sustituya <em>&lt;server_URL&gt;</em> con la dirección IP o el URL del servicio de registro remoto al que desea enviar registros. Si proporciona un URL de servidor no seguro, se ignoran los certificados. Si no especifica una dirección IP o un URL del servidor remoto, se utiliza una configuración predeterminada de QRadar y los registros se envían a la instancia de QRadar de la región en la que se encuentra el clúster.</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Sustituya <em>&lt;CA_cert_path&gt;</em> con la vía de acceso de archivo del certificado de CA que se utiliza para verificar el servicio de registro remoto.</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>Sustituya <em>&lt;client_cert_path&gt;</em> con la vía de acceso de archivo del certificado de cliente que se utiliza para autenticarse en el servicio de registro remoto.</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>Sustituya <em>&lt;client_key_path&gt;</em> con la vía de acceso de archivo de la clave de cliente correspondiente que se utiliza para conectarse al servicio de registro remoto.</td>
    </tr>
    </tbody></table>

2. Verifique que el reenvío de registros se ha habilitado consultando el URL del servicio de registro remoto.

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    Salida de ejemplo:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Aplique la actualización de configuración reiniciando el Kubernetes maestro.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

#### Detención del reenvío de registros de auditoría de API de Kubernetes
{: #cs_audit_delete}

Puede detener el reenvío de registros de auditoría inhabilitando la configuración del programa de fondo del webhook para el servidor de API del clúster.

Antes de empezar, seleccione [como destino de la CLI](cs_cli_install.html#cs_cli_configure) el clúster del que desea dejar de recopilar los registros de auditoría del servidor de API.

1. Inhabilitar la configuración del programa de fondo del webhook para el servidor de API del clúster.

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Aplique la actualización de configuración reiniciando el Kubernetes maestro.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Visualización de registros
{: #cs_view_logs}

Para ver los registros de clústeres y contenedores, puede utilizar las características estándares de registro de Kubernetes y Docker.
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

Para clústeres estándares, los registros se encuentran en la cuenta de {{site.data.keyword.Bluemix_notm}} en el que ha iniciado la sesión al crear el clúster de Kubernetes. Si ha especificado un espacio de {{site.data.keyword.Bluemix_notm}} al crear el clúster o al crear la configuración de registro, entonces los registros están ubicados en el espacio en cuestión. Los registros se supervisan y se reenvían fuera del contenedor. Puede acceder a los registros de un contenedor mediante el panel de control de Kibana. Para obtener más información sobre el registro, consulte [Registro para el {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Nota**: si ha especificado un espacio al crear el clúster o la configuración de registro, el propietario de la cuenta necesita permisos de gestor, desarrollador o auditor para dicho espacio para ver registros. Para obtener más información sobre cómo cambiar políticas de acceso y permisos de {{site.data.keyword.containershort_notm}}, consulte [Gestión de acceso a clústeres](cs_cluster.html#cs_cluster_user). Cuando se cambian los permisos, los registros pueden tardar hasta 24 horas en aparecer.

Para acceder al panel de control de Kibana, vaya a uno de los siguientes URL y seleccione la cuenta o espacio de {{site.data.keyword.Bluemix_notm}} en la que ha creado el clúster.
- EE.UU. Sur y EE.UU. este: https://logging.ng.bluemix.net
- UK-Sur y UE-Central: https://logging.eu-fra.bluemix.net
- AP Sur: https://logging.au-syd.bluemix.net

Para obtener más información sobre la visualización de registros, consulte [Navegación a Kibana desde un navegador web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

#### Registros de Docker
{: #cs_view_logs_docker}

Puede aprovechar las funciones incorporadas de registro de Docker para revisar las actividades de las secuencias de salida estándar STDOUT y STDERR. Para obtener más información, consulte [Visualización de registros de contenedor para un contenedor que se ejecute en un clúster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Configuración de la supervisión del clúster
{: #cs_monitoring}

Las métricas le ayudan a supervisar el estado y el rendimiento de sus clústeres. Puede configurar la supervisión del estado de los nodos trabajadores para detectar de forma automática los trabajadores que pasen a un estado degradado o no operativo. **Nota**: La supervisión se soporta solo para los clústeres estándar.
{:shortdesc}

### Visualización de métricas
{: #cs_view_metrics}

Puede utilizar las funciones estándares de Kubernetes y Docker para supervisar el estado de sus clústeres y apps.
{:shortdesc}

<dl>
<dt>Página de detalles del clúster en {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} proporciona información sobre el estado y la capacidad del clúster y sobre el uso de los recursos del clúster. Puede utilizar esta
GUI para escalar los clústeres, trabajar con el almacenamiento permanente y añadir funciones adicionales al clúster mediante la vinculación de servicios de {{site.data.keyword.Bluemix_notm}}. Para ver la página de detalles de un clúster, vaya al **Panel de control de {{site.data.keyword.Bluemix_notm}}** y seleccione un clúster.</dd>
<dt>Panel de control de Kubernetes</dt>
<dd>El panel de control de Kubernetes es una interfaz web administrativa que puede utilizar para revisar el estado de los nodos trabajadores, buscar recursos de Kubernetes, desplegar apps contenerizadas y resolver problemas de apps en función de la información de registro y supervisión. Para obtener más información sobre cómo acceder al panel de control de Kubernetes, consulte [Inicio del panel de control de Kubernetes para {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>En el caso de los clústeres estándares, las métricas se encuentran en el espacio de {{site.data.keyword.Bluemix_notm}} al que se inició sesión cuando se creó el clúster de Kubernetes. Si ha especificado un espacio de {{site.data.keyword.Bluemix_notm}} al crear el clúster, entonces las métricas están ubicados en el espacio en cuestión. Las métricas de contenedor se recopilan automáticamente para todos los contenedores desplegados en un clúster. Estas métricas se envían y se ponen a disponibilidad mediante Grafana. Para obtener más información sobre las métricas, consulte el tema sobre [Supervisión de {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Para acceder al panel de control de Grafana, vaya a uno de los siguientes URL y seleccione la cuenta o espacio de {{site.data.keyword.Bluemix_notm}} en la que ha creado el clúster.<ul><li>EE.UU. Sur y EE.UU. este: https://metrics.ng.bluemix.net</li><li>UK-Sur: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### Otras herramientas de supervisión de estado
{: #cs_health_tools}

Puede configurar otras herramientas para disponer de funciones adicionales.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus es una herramienta de supervisión, registro y generación de alertas diseñada para Kubernetes. La herramienta recupera información detallada acerca del clúster, los nodos trabajadores y el estado de despliegue basado en la información de registro de Kubernetes. Para obtener información sobre la configuración, consulte [Integración de servicios con {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_integrations).</dd>
</dl>

### Configuración de la supervisión de estado de los nodos trabajadores con recuperación automática
{: #cs_configure_worker_monitoring}

El sistema de recuperación automática de {{site.data.keyword.containerlong_notm}} se puede desplegar en clústeres existentes de Kubernetes versión 1.7 o posterior. El sistema de recuperación automática utiliza varias comprobaciones para consultar el estado de salud del nodo trabajador de la consulta. Si la recuperación automática detecta un nodo trabajador erróneo basado en las comprobaciones configuradas, desencadena una acción correctiva, como una recarga del SI, en el nodo trabajador. Solo se aplica una acción correctiva por nodo trabajador cada vez. El nodo trabajador debe completar correctamente la acción correctiva antes de otro nodo trabajador empiece otra acción correctiva. Para obtener más información, consulte esta [publicación del blog sobre recuperación automática ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**NOTA**: La recuperación automática requiere que al menos haya un nodo en buen estado que funcione correctamente. Configure la recuperación automática solo con las comprobaciones activas en los clústeres con dos o varios nodos trabajadores.

Antes de empezar, seleccione el clúster cuyos estados de nodos trabajadores desea comprobar como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

1. Cree un archivo de mapa de configuración que defina las comprobaciones en formato JSON. Por ejemplo, el siguiente archivo YAML define tres comprobaciones: una comprobación HTTP y dos comprobaciones de servidor API de Kubernetes.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>Tabla 14. Visión general de los componentes del archivo YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>El nombre de configuración <code>ibm-worker-recovery-checks</code> es una constante y no se puede cambiar.</td>
    </tr>
    <tr>
    <td><code>namespace</code></td>
    <td>El espacio de nombre <code>kube-system</code> es una constante y no se puede cambiar.</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>Introduzca el tipo de comprobación que desee que utilice la recuperación automática. <ul><li><code>HTTP</code>: La recuperación automática llama a los servidores HTTP que se ejecutan en cada nodo para determinar si los nodos se están ejecutando correctamente.</li><li><code>KUBEAPI</code>: La recuperación automática llama al servidor de AP de Kubernetes y lee los datos del estado de salud notificado por los nodos trabajadores.</li></ul></td>
    </tr>
    <tr>
    <td><code>Resource</code></td>
    <td>Cuando el tipo de comprobación es <code>KUBEAPI</code>, especifique el tipo de recurso que desee que compruebe la recuperación automática. Los valores aceptados son <code>NODE</code> o <code>PODS</code>.</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>Especifique el umbral para el número de comprobaciones consecutivas fallidas. Cuando se alcance el umbral, la recuperación automática desencadenará la acción correctiva especificada. Por ejemplo, si el valor es 3 y la recuperación automática falla una comprobación configurada tres veces consecutivas, la recuperación automática desencadena la acción correctiva asociada con la comprobación.</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>Cuando el tipo de recurso sea <code>PODS</code>, especifique el umbral del porcentaje de pods en un nodo trabajador que puede encontrarse en estado [NotReady ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Este porcentaje se basa en el número total de pods que están programados para un nodo trabajador. Cuando una comprobación determina que el porcentaje de pods erróneos es superior al umbral, cuenta un error.</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>Especifique que se ejecute la acción cuando se alcance el umbral de errores. Una acción correctiva solo se ejecuta cuando no se repara ningún otro trabajador y cuando el nodo trabajador no está en un período de calma tras una acción anterior. <ul><li><code>REBOOT</code>: Reinicia el nodo trabajador.</li><li><code>RELOAD</code>: Vuelve a cargar las configuraciones necesarias del nodo trabajador desde un SO limpio.</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>Especifique el número de segundos que debe esperar la recuperación automática para un nodo que ya ha emitido una acción correctiva. El período de calma empieza a la hora en que se emite la acción correctiva.</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>Especifique el número de segundos entre comprobaciones consecutivas. Por ejemplo, si el valor es 180, la recuperación automática ejecuta la comprobación en cada nodo cada 3 minutos.</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>Especifique el número máximo de segundos que tarda una llamada de comprobación a la base de datos antes de que la recuperación automática finalice la operación de llamada. El valor <code>TimeoutSeconds</code> debe ser inferior al valor de <code>IntervalSeconds</code>.</td>
    </tr>
    <tr>
    <td><code>Port</code></td>
    <td>Cuando el tipo de comprobación sea <code>HTTP</code>, especifique el puerto con el que se debe vincular el servidor HTTP en los nodos trabajadores. Este puerto debe estar expuesto a la IP de cada nodo trabajador en el clúster. La recuperación automática requiere un número de puerto en todos los nodos para la comprobación de servidores. Utilice [DaemonSets ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)cuando despliegue un servidor personalizado en un clúster.</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>Cuando el tipo de comprobación sea <code>HTTP</code>, especifique el estado del servidor HTTP que espera que se devuelva desde la comprobación. Por ejemplo, un valor de 200 indica que espera una respuesta <code>OK</code> del servidor.</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>Cuando el tipo de comprobación es <code>HTTP</code>, especifique la vía de acceso solicitada desde el servidor HTTP. Este valor suele ser la vía de acceso de las métricas del servidor que se ejecuta en todos los nodos trabajadores.</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>Especifique <code>true</code> para habilitar la comprobación o <code>false</code> para inhabilitar la comprobación.</td>
    </tr>
    </tbody></table>

2. Cree el mapa de configuración en el clúster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Verifique haber creado el mapa de configuración con el nombre `ibm-worker-recovery-checks` en el espacio de nombre `kube-system` con las comprobaciones adecuadas.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Asegúrese de haber creado un secreto de extracción Docker con el nombre `international-registry-docker-secret` en el espacio de nombre `kube-system`. La recuperación automática se aloja en el registro de Docker internacional de {{site.data.keyword.registryshort_notm}}. Si no ha creado un secreto de registro de Docker que contenga credenciales válidas para el registro internacional, cree uno en el sistema de recuperación automática.

    1. Instale el plug-in de {{site.data.keyword.registryshort_notm}}.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Establezca el registro internacional como destino.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Cree una señal de registro internacional.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Establezca la variable de entorno `INTERNATIONAL_REGISTRY_TOKEN` en la señal que ha creado.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Establezca la variable de entorno `DOCKER_EMAIL` en el usuario actual. La dirección de correo electrónico solo se necesita para ejecutar el mandato `kubectl` en el siguiente paso.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Cree el secreto de extracción de Docker.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Despliegue la recuperación automática en el clúster aplicando este archivo YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. Pasados unos minutos, podrá comprobar la sección `Sucesos` en la salida del siguiente mandato para ver la actividad en el despliegue de la recuperación automática.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

<br />


## Visualización de recursos de un clúster de Kubernetes
{: #cs_weavescope}

Weave Scope proporciona un diagrama visual de los recursos de un clúster de Kubernetes, incluidos servicios, pods, contenedores, procesos, nodos, etc. Weave Scope ofrece métricas interactivas correspondientes a CPU y memoria y también herramientas para realizar seguimientos y ejecuciones en un contenedor.
{:shortdesc}

Antes de empezar:

-   Recuerde no exponer la información del clúster en Internet público. Siga estos pasos para desplegar de forma segura Weave Scope y para acceder al mismo localmente desde un navegador web.
-   Si aún no tiene uno, [cree un clúster estándar](#cs_cluster_ui). Weave Scope puede consumir mucha CPU, especialmente la app. Ejecute Weave Scope con clústeres de pago grandes, no con clústeres de tipo lite.
-   [Defina su clúster como destino de la CLI](cs_cli_install.html#cs_cli_configure) para ejecutar mandatos `kubectl`.


Para utilizar Weave Scope con una clúster:
2.  Despliegue una de los archivos de configuración de permisos RBAC del clúster.

    Para habilitar los permisos de lectura/escritura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Para habilitar los permisos de solo lectura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Salida:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Despliegue el servicio Weave Acope, al que puede acceder de forma privada con la dirección IP del clúster.

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Salida:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Ejecute un mandato de reenvío de puerto para que aparezca el servicio en el sistema. Ahora que Weave Scope se ha configurado con el clúster, para acceder a él la próxima vez puede ejecutar este mandato de reenvío de puerto sin realizar de nuevo los pasos de configuración anteriores.

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Salida:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Abra el navegador web en `http://localhost:4040`. Sin los componentes predeterminados desplegados, verá el siguiente diagrama. Seleccione la vista de diagramas o tablas de topología de los recursos de Kubernetes en el clúster.

     <img src="images/weave_scope.png" alt="Ejemplo de topología de Weave Scope" style="width:357px;" />


[Más información sobre las características de Weave Scope ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.weave.works/docs/scope/latest/features/).

<br />


## Eliminación de clústeres
{: #cs_cluster_remove}

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
- Si ha creado una reclamación de volumen persistente utilizando una (compartición de archivo existente)[#cs_cluster_volume_create], no puede suprimir la compartición de archivo al suprimir el clúster. Suprima manualmente la compartición de archivo desde el portafolio de infraestructura de IBM Cloud (SoftLayer).
- El almacenamiento persistente proporciona alta disponibilidad a los datos. Si lo suprime, no podrá recuperar los datos.
