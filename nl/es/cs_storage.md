---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Guardado de datos en el clúster
{: #storage}
Puede conservar los datos en caso de que un componente del clúster falle y para compartir datos entre instancias de app.

## Planificación de almacenamiento altamente disponible
{: #planning}

En {{site.data.keyword.containerlong_notm}}, puede elegir entre varias opciones para almacenar los datos de la app y compartirlos entre los distintos pods de su clúster. Sin embargo, no todas las opciones de almacenamiento ofrecen el mismo nivel de persistencia y disponibilidad en caso de que falle un componente en el clúster o todo el sitio.
{: shortdesc}

### Opciones de almacenamiento de datos no persistente
{: #non_persistent}

Puede utilizar las opciones de almacenamiento no persistente si no es necesario que sus datos se almacenen permanentemente, de modo que pueda recuperarlos después de que un componente del clúster falle, o si los datos no tienen que compartirse entre distintas instancias de la app. Las opciones de almacenamiento no persistente también se pueden utilizar para realizar pruebas de unidad de los componentes de la app o probar nuevas características.
{: shortdesc}

La siguiente imagen muestra las opciones de datos no persistentes disponibles en {{site.data.keyword.containerlong_notm}}. Estas opciones están disponibles para clústeres gratuitos y estándares.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Opciones de almacenamiento de datos no persistente" width="450" style="width: 450px; border-style: none"/></p>

<table summary="La tabla muestra las opciones de almacenamiento no persistente. Las filas se leen de izquierda a derecha, con el número de la opción en la columna uno, el título de la opción en la columna dos y una descripción en la columna tres." style="width: 100%">
<colgroup>
       <col span="1" style="width: 5%;"/>
       <col span="1" style="width: 20%;"/>
       <col span="1" style="width: 75%;"/>
    </colgroup>
  <thead>
  <th>#</th>
  <th>Opción</th>
  <th>Descripción</th>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Dentro del contenedor o pod</td>
      <td>Los contenedores y pods son, por diseño, efímeros y pueden fallar inesperadamente. Sin embargo, puede escribir datos en el sistema de archivos local del contenedor para almacenar datos en todo el ciclo de vida del contenedor. Los datos dentro de un contenedor no se pueden compartir con otros contenedores o pods y se pierden cuando el contenedor se cuelga o se elimina. Para obtener más información, consulte [Almacenamiento de datos en un contenedor](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2</td>
    <td>En el nodo trabajador</td>
    <td>Cada nodo trabajador se configura con el almacenamiento primario y secundario determinado que está determinado por el tipo de máquina que seleccione para el nodo trabajador. El almacenamiento primario se utiliza para almacenar datos del sistema operativo y el usuario no puede acceder a él. El almacenamiento secundario se utiliza para almacenar datos en <code>/var/lib/docker</code>, el directorio en el que se escriben todos los datos del contenedor. <br/><br/>Para acceder al almacenamiento secundario del nodo trabajador, puede crear un volumen <code>/emptyDir</code>. Este volumen vacío se asigna a un pod del clúster, de manera que los contenedores de dicho pod puedan leer y escribir en ese volumen. Puesto que el volumen se asigna a un determinado pod, los datos no se pueden compartir con otros pods de un conjunto de réplicas.<br/><p>Un volumen <code>/emptyDir</code> y sus datos se eliminan cuando: <ul><li>El pod asignado se suprime de forma permanente del nodo trabajador.</li><li>El pod asignado se planifica en otro nodo trabajador.</li><li>El nodo trabajador se vuelve a cargar o actualizar.</li><li>El nodo trabajador se suprime.</li><li>El clúster se suprime.</li><li>La cuenta de {{site.data.keyword.Bluemix_notm}} alcanza un estado suspendido.</li></ul></p><p><strong>Nota:</strong> Si el contenedor contenido en el pod se cuelga, los datos del volumen siguen estando disponibles en el nodo trabajador.</p><p>Para obtener más información, consulte [Volúmenes de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/storage/volumes/).</p></td>
    </tr>
    </tbody>
    </table>

### Opciones de almacenamiento de datos persistentes de alta disponibilidad
{: persistent}

El principal desafío al crear apps de estado altamente disponible es conservar los datos en varias instancias de la app en múltiples ubicaciones, y mantener los datos sincronizados todo el tiempo. Para los datos de alta disponibilidad, quiere asegurarse de contar con una base de datos maestra con múltiples instancias distribuidas en varios centros de datos o incluso regiones, y que los datos en dicha base de datos maestra se repliquen continuamente. Todas las instancias en el clúster deben leer y escribir en esta base de datos maestra. En caso de que una instancia de la maestra esté inactiva, las otras instancias pueden asumir la carga de trabajo, para que no se produzca una parada en sus apps.
{: shortdesc}

La imagen siguiente muestra las opciones que tiene en {{site.data.keyword.containerlong_notm}} para hacer que sus datos estén altamente disponibles en un clúster estándar. La opción más adecuada depende de los siguientes factores:
  * **El tipo de app que tenga:** Por ejemplo, puede tener una app que deba almacenar los datos en archivos en lugar de en una base de datos. 
  * **Requisitos legales sobre dónde almacenar y direccionar los datos:** Por ejemplo, puede verse obligado a almacenar y direccionar los datos solo en los Estados Unidos y no poder utilizar un servicio ubicado en Europa.
  * **Opciones de copia de seguridad y restauración:** Todas las opciones de almacenamiento incluyen prestaciones de copia de seguridad y restauración de datos. Compruebe que las opciones disponibles de copia de seguridad y restauración cumplan los requisitos de su plan de recuperación tras desastre, como la frecuencia de las copias o la capacidad de almacenar datos fuera de su centro de datos primario.
  * **Réplica global:** Para alta disponibilidad, puede que quiera configurar múltiples instancias de almacenamiento que se distribuyan y repliquen en centros de datos de todo el mundo.

<br/>
<img src="images/cs_storage_ha.png" alt="Opciones de alta disponibilidad para almacén persistente"/>

<table summary="La tabla muestra las opciones de almacenamiento persistente. Las filas se leen de izquierda a derecha, con el número de la opción en la columna uno, el título de la opción en la columna dos y una descripción en la columna tres.">
  <thead>
  <th>#</th>
  <th>Opción</th>
  <th>Descripción</th>
  </thead>
  <tbody>
  <tr>
  <td width="5%">1</td>
  <td width="20%">Almacenamiento de archivos NFS</td>
  <td width="75%">Con esta opción, puede conservar datos de la app y contenedores utilizando volúmenes permanentes de Kubernetes. Los volúmenes se alojan en el [almacenamiento de archivos basados en NFS de Resistencia y Rendimiento ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/file-storage/details), que puede utilizarse para apps que almacenan datos en archivos en lugar de en una base de datos. El almacenamiento de archivos es cifrado en REST y agrupado en clústeres por IBM para proporcionar alta disponibilidad.<p>{{site.data.keyword.containershort_notm}} proporciona clases de almacenamiento predefinidas que definen el rango de tamaños del almacenamiento, IOPS, la política de supresión y los permisos de lectura y escritura para el volumen. Para iniciar una solicitud de almacenamiento de archivos basados en NFS, debe crear una [reclamación de volumen permanente](cs_storage.html#create). Después de enviar una reclamación de volumen permanente, {{site.data.keyword.containershort_notm}} suministra de forma dinámica un volumen permanente alojado en almacenamiento de archivos basado en NFS. [Puede montar la reclamación de volumen permanente](cs_storage.html#app_volume_mount) como un volumen en su despliegue para permitir que los contenedores lean el volumen y graben en el mismo. </p><p>Los volúmenes permanentes se suministran en el centro de datos donde esté ubicado el nodo trabajador. Puede compartir datos entre el mismo conjunto de réplicas o con otros despliegues en el mismo clúster. No puede compartir datos entre clústeres cuando están ubicados en distintos centros de datos o regiones. </p><p>De forma predeterminada, no se realiza copia de seguridad automática del almacenamiento NFS. Puede configurar una copia de seguridad periódica para el clúster utilizando los mecanismos de copia de seguridad y restauración establecidos. Cuando un contenedor se cuelga o un pod se retira de un nodo trabajador, los datos no se eliminan y pueden acceder a los mismos otros despliegues que monten el volumen. </p><p><strong>Nota:</strong> El almacenamiento compartido de archivos NFS permanentes se factura mensualmente. Si suministra almacenamiento permanente para el clúster y lo retira de inmediato, paga igualmente el cargo mensual del almacenamiento permanente, aunque solo lo haya utilizado un breve periodo de tiempo.</p></td>
  </tr>
  <tr>
    <td>2</td>
    <td>Servicio de base de datos en la nube</td>
    <td>Con esta opción, puede conservar datos utilizando un {{site.data.keyword.Bluemix_notm}} servicio en la nube de base de datos, como [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant). Se puede acceder a los datos que se almacenan con esta opción desde clústeres, ubicaciones y regiones. <p> Puede optar por configurar una sola instancia de base de datos a la que tengan acceso todas las apps, o [configurar varias instancias en varios centros de datos y réplica](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery) entre las instancias para aumentar la disponibilidad. En la base de datos IBM Cloudant NoSQL, la copia de seguridad de los datos no se realiza automáticamente. Puede utilizar los [mecanismos de copia de seguridad y restauración](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) para proteger los datos de un fallo del sitio.</p> <p> Para utilizar un servicio en el clúster, debe [enlazar el servicio de {{site.data.keyword.Bluemix_notm}}](cs_integrations.html#adding_app) a un espacio de nombre en el clúster. Cuando enlaza el servicio al clúster, se crea un secreto de Kubernetes. El secreto de Kubernetes contiene información confidencial sobre el servicio, como por ejemplo el URL del servicio y su nombre de usuario y contraseña. Puede montar el secreto como un volumen secreto en el pod y acceder al servicio mediante las credenciales del secreto. Si monta el volumen secreto en otros pods, también puede compartir datos entre pods. Cuando un contenedor se cuelga o un pod se retira de un nodo trabajador, los datos no se eliminan y pueden acceder a los mismos otros pods que monten el volumen secreto. <p>La mayoría de los servicios de base de datos de {{site.data.keyword.Bluemix_notm}} proporcionan espacio en disco para una cantidad de datos pequeña sin coste, para así poder probar sus características.</p></td>
  </tr>
  <tr>
    <td>3</td>
    <td>Base de datos local</td>
    <td>Si debe almacenar sus datos en local por motivos legales, puede [configurar una conexión de VPN](cs_vpn.html#vpn) a su base de datos local y utilizar los mecanismos existentes de almacenamiento, copia de seguridad y réplica en su centro de datos.</td>
  </tr>
  </tbody>
  </table>

{: caption="Tabla. Opciones de almacén permanente para despliegues en clústeres de Kubernetes" caption-side="top"}

<br />



## Utilización de recursos compartidos de archivos de NFS existentes en clústeres
{: #existing}

Si ya tiene recursos compartidos de archivos NFS existentes en su cuenta de infraestructura de IBM Cloud (SoftLayer) que desea utilizar con Kubernetes, puede hacerlo creando volúmenes permanentes en el recurso compartido existente de archivos NFS. Un volumen permanente es una parte del hardware real que sirve como recurso de clúster de Kubernetes y que puede ser consumido por el usuario del clúster.
{:shortdesc}

Kubernetes diferencia entre volúmenes permanentes, que representan el hardware real, y reclamaciones de volumen permanente, que son solicitudes de almacenamiento, generalmente iniciadas por el usuario del clúster. En el siguiente diagrama se ilustra la relación entre los volúmenes persistentes y las reclamaciones de volumen persistente.

![Cree volúmenes permanentes y reclamaciones de volúmenes permanentes](images/cs_cluster_pv_pvc.png)

 Tal como se muestra en el diagrama, para habilitar los recursos compartidos de archivos NFS existentes para utilizarlos con Kubernetes, debe crear persistentes volúmenes permanentes con un determinado tamaño y modalidad de acceso y crear una reclamación de volumen permanente que coincida con la especificación de volumen permanente. Si el volumen permanente y la reclamación de volumen permanente coinciden, se enlazan. El usuario del clúster solo puede utilizar reclamaciones de volumen permanente enlazadas para montar el volumen en un despliegue. Este proceso se conoce como suministro estático de almacenamiento permanente.

Antes de empezar, asegúrese de que tiene un recurso compartido de archivos NFS existentes que puede utilizar para crear el volumen permanente.

**Nota:** El suministro estático de almacenamiento permanente sólo se aplica a recursos compartidos de archivos NFS existentes. Si no tiene recursos compartidos de archivos NFS existentes, los usuarios del clúster puedan utilizar el proceso de [suministro dinámico](cs_storage.html#create) para añadir volúmenes permanente.

Para crear un volumen permanente y una reclamación de volumen permanente coincidente, siga estos pasos:

1.  En la cuenta de infraestructura de IBM Cloud (SoftLayer), busque el ID y la vía de acceso del recurso compartido de archivos NFS en el que desea crear el objeto de volumen permanente. Además, autorice el almacenamiento de archivos para las subredes del clúster. Esta autorización proporciona al clúster acceso al almacenamiento.
    1.  Inicie sesión en la cuenta de infraestructura de IBM Cloud (SoftLayer).
    2.  Pulse **Almacenamiento**.
    3.  Pulse **Almacenamiento de archivos** y, en el menú **Acciones**, seleccione **Autorizar host**.
    4.  Pulse **Subredes**. Una vez realizada la autorización, todos los nodos trabajadores de la subred tendrán acceso al almacenamiento de archivos.
    5.  Seleccione la subred de VLAN pública del clúster desde el menú y pulse **Enviar**. Si necesita encontrar la subred, ejecute `bx cs cluster-get <cluster_name> --showResources`.
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
    <caption>Tabla. Visión general de los componentes del archivo YAML</caption>
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


Ha creado correctamente un objeto de volumen permanente y lo ha enlazado a una reclamación de volumen permanente. Ahora los usuarios del clúster pueden [montar la reclamación de volumen permanente](#app_volume_mount) en sus despliegues y empezar a leer el objeto de volumen permanente y a grabar en el mismo.

<br />


## Creación de almacenamiento permanente para apps
{: #create}

Cree una reclamación de volumen permanente para suministrar almacenamiento de archivos NFS al clúster. Luego monte esta reclamación en un despliegue para asegurarse de que los datos estén disponibles aunque los pods se cuelguen o se cierren.
{:shortdesc}

IBM coloca el almacén de archivos NFS que contiene el volumen permanente en un clúster para ofrecer una alta disponibilidad de los datos. Las clases de almacenamiento describen los tipos de ofertas de almacenamiento disponibles y definen aspectos como la política de retención de datos, el tamaño en gigabytes e IOPS, cuando se crea el volumen permanente.

**Nota**: si tiene un cortafuegos, [permita el acceso de salida](cs_firewall.html#pvc) para los rangos de IP de la infraestructura de IBM Cloud (SoftLayer) de las ubicaciones (centros de datos) en las que están en los clústeres, de modo que pueda crear reclamaciones de volumen permanente.

1.  Revise las clases de almacenamiento disponibles. {{site.data.keyword.containerlong}} ofrece ocho clases de almacenamiento predefinidas para que el administrador del clúster no tenga que crear ninguna clase de almacenamiento. La clase de almacenamiento `ibmc-file-bronze` es la misma que la clase de almacenamiento `default`.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-retain-bronze      ibm.io/ibmc-file
    ibmc-file-retain-custom      ibm.io/ibmc-file
    ibmc-file-retain-gold        ibm.io/ibmc-file
    ibmc-file-retain-silver      ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  Decida si desea guardar los datos y la compartición de archivos NFS después de suprimir pvc, conocido como política de reclamación. Si desea conservar los datos, seleccione la clase de almacenamiento `retain`. Si desea que los datos y la compartición de archivos se supriman cuando suprima el pvc, elija una clase de almacenamiento sin `retain`.

3.  Obtener los detalles de una clase de almacenamiento. Revise el IOPS por gigabyte y el rango de tamaño en el campo **parameters** de su salida de CLI. 

    <ul>
      <li>Si utiliza las clases de almacenamiento bronce, plata y oro, obtendrá [Almacenamiento resistente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage), que define la IOPS por GB para cada clase. Sin embargo, puede determinar la IOPS total eligiendo un tamaño dentro del rango disponible. Por ejemplo, si selecciona un tamaño de compartición de archivos de 1000Gi en la clase de almacenamiento de plata de 4 IOPS por GB, el volumen tendrá un total de 4000 IOPS. Cuantos más IOPS tenga el volumen permanente, más rápido se procesarán las operaciones de entrada y salida. <p>**Mandato de ejemplo para describir la clase de almacenamiento**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-silver</pre>

       El campo **parameters** proporciona el IOPS por GB asociado a la clase de almacenamiento y los
tamaños disponibles en gigabytes.
       <pre class="pre">Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi</pre>
       
       </li>
      <li>Con clases de almacenamiento personalizadas, obtendrá [Almacenamiento de rendimiento ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/performance-storage) y tendrá más control sobre la elección de la combinación de IOPS y el tamaño.<p>**Mandato de ejemplo para describir una clase de almacenamiento personalizada**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-retain-custom</pre>

       El campo **parameters** proporciona el IOPS asociado a la clase de almacenamiento y los tamaños disponibles en gigabytes. Por ejemplo, un 40Gi pvc puede seleccionar un IOPS que sea múltiplo de 100 que esté comprendido entre 100 y 2000 IOPS.

       ```
       Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
       ```
       {: screen}
       </li></ul>
4. Cree un archivo de configuración para definir su reclamación de volumen permanente y guarde la configuración como archivo `.yaml`.

    -  **Ejemplo de clases de almacenamiento de bronce, plata y oro**:
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
        name: mypvc
        annotations:
          volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
          
       spec:
        accessModes:
          - ReadWriteMany
        resources:
          requests:
            storage: 20Gi
        ```
        {: codeblock}

    -  **Ejemplo de clases de almacenamiento personalizadas**:
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 40Gi
             iops: "500"
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Escriba el nombre de la reclamación de volumen permanente.</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>Especifique la clase de almacenamiento para el volumen permanente:
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS por GB.</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver: 4 IOPS por GB.</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold: 10 IOPS por GB.</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom: Varios valores de IOPS disponibles.</li>
          <p>Si no especifica ninguna clase de almacenamiento, el volumen permanente se crea en la clase de almacenamiento de bronce ("bronze").</p></td>
        </tr>
        
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
        <td>Si elige un tamaño distinto del que aparece en la lista, el tamaño se redondea al alza. Si selecciona un tamaño mayor que el tamaño más grande, el tamaño se redondea a la baja.</td>
        </tr>
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
        <td>Esta opción solo es para clases de almacenamiento personalizadas (`ibmc-file-custom / ibmc-file-retain-custom`). Especifique el IOPS total para el almacenamiento. Para ver todas las opciones, ejecute `kubectl describe storageclasses ibmc-file-custom`. Si elige un IOPS distinto del que aparece en la lista, el IOPS se redondea.</td>
        </tr>
        </tbody></table>

5.  Cree la reclamación de volumen permanente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  Compruebe que la reclamación de volumen permanente se haya creado y vinculado al volumen permanente. Este proceso puede tardar unos minutos.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Salida de ejemplo:

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #app_volume_mount}Para montar la reclamación de volumen permanente en el despliegue, cree un archivo de configuración. Guarde la configuración como archivo `.yaml`.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
     name: <deployment_name>
    replicas: 1
    template:
     metadata:
       labels:
         app: <app_name>
    spec:
     containers:
     - image: <image_name>
       name: <container_name>
       volumeMounts:
       - mountPath: /<file_path>
         name: <volume_name>
     volumes:
     - name: <volume_name>
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icono Idea"/> Visión general de los componentes del archivo YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Nombre del despliegue.</td>
    </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>Una etiqueta para el despliegue.</td>
    </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>El nombre del imagen que desea utilizar. Para ver una lista de todas las imágenes disponibles en su cuenta de {{site.data.keyword.registryshort_notm}}, ejecute `bx cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>El nombre del contenedor que desea desplegar en el clúster.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>La vía de acceso absoluta del directorio en el que el que está montado el volumen dentro del contenedor.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>El nombre del volumen que va a montar en el pod. </td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>El nombre del volumen que va a montar en el pod. Normalmente, este nombre es el mismo que <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>El nombre de la reclamación de volumen permanente que desea utilizar como volumen. Cuando monta el volumen en el pod, Kubernetes identifica el volumen permanente enlazado a la reclamación de volumen permanente y permite al usuario realizar operaciones de lectura y escritura en el volumen permanente.</td>
    </tr>
    </tbody></table>

8.  Cree el despliegue y monte la reclamación de volumen permanente.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  Verifique que el volumen se ha montado correctamente.

    ```
    kubectl describe deployment <deployment_name>
    ```
    {: pre}

    El punto de montaje se muestra en el campo **Volume Mounts** y el volumen se muestra en el campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />



## Adición de acceso de usuario no root al almacenamiento permanente
{: #nonroot}

Los usuarios no root no tienen permiso de escritura sobre la vía de acceso de montaje del volumen para el almacenamiento respaldado por NFS. Para otorgar permiso de escritura, debe editar el Dockerfile de la imagen para crear un directorio en la vía de acceso de montaje con el permiso correcto.
{:shortdesc}

Antes de empezar, seleccione su clúster como [destino de la CLI](cs_cli_install.html#cs_cli_configure).

Si está diseñando una app con un usuario no root que requiere permiso de escritura sobre el volumen, debe añadir los siguientes procesos al script de punto de entrada y al archivo Docker:

-   Cree un usuario no root.
-   Añada temporalmente el usuario al grupo raíz.
-   Cree un directorio en la vía de acceso de montaje con los permisos de usuario correctos.

Para {{site.data.keyword.containershort_notm}}, el propietario predeterminado de la vía de acceso de montaje del volumen es el propietario `nobody`. Con el almacenamiento NFS, si el propietario no existe localmente en el pod, se crea el usuario `nobody`. Los volúmenes están configurados para reconocer el usuario root en el contenedor, el cual, para algunas apps es el único usuario dentro de un contenedor. Sin embargo, muchas apps especifican un usuario no root que no es `nobody` que escribe en la vía de acceso de montaje del contenedor. Algunas apps especifican que el volumen debe ser propiedad del usuario root. Las apps no suelen utilizar el usuario root por motivos de seguridad. Con todo, si su app requiere un usuario root, póngase en contacto con el servicio de asistencia de [{{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).


1.  Cree un Dockerfile en un directorio local. Este Dockerfile de ejemplo está creando un usuario no root denominado `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmliberty:latest

    # Cree un grupo y un usuario con GID y UID 1010.
    # En este caso, está creando un grupo y usuario denominado myguest.
    # Es poco probable que el GUID y UID 1010 cree un conflicto con algún GUID o UID de usuario existente en la imagen.
    # El GUID y el UID deben estar entre 0 y 65536. De lo contrario, no se puede crear el contenedor.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Cree el script de punto de entrada en la misma carpeta local que Dockerfile. Este script de punto de entrada de ejemplo especifica
`/mnt/myvol` como vía de acceso de montaje de volumen.

    ```
    #!/bin/bash
    set -e

    #Este es el punto de montaje para el volumen compartido.
    #De forma predeterminada, el punto de montaje es propiedad del usuario root.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # Esta función crea un subdirectorio propiedad del
    # usuario no root bajo la vía de acceso de montaje del volumen compartido.
    create_data_dir() {
      #Añadir el usuario no root al grupo primario de usuario root.
      usermod -aG root $MY_USER

      #Proporcione permiso de lectura-escritura-ejecución para el grupo para la vía de acceso de montaje compartido.
      chmod 775 $MOUNTPATH

      # Cree un directorio bajo la vía de acceso compartida propiedad del usuario no roor myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      #Por motivos de seguridad, elimine el usuario no root del grupo de usuarios root.
      deluser $MY_USER root

      #Cambie la vía de acceso de montaje de volumen compartido por su permiso de lectura-escritura-ejecución original.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    #Este mandato crea un proceso de larga ejecución para la finalidad de este ejemplo.
    tail -F /dev/null
    ```
    {: codeblock}

3.  Inicie una sesión en {{site.data.keyword.registryshort_notm}}.

    ```
    bx cr login
    ```
    {: pre}

4.  Cree la imagen localmente. Recuerde sustituir _&lt;my_namespace&gt;_ por el espacio de nombres correspondiente al registro de imágenes privado. Ejecute `bx cr namespace-get` si tiene que buscar su espacio de nombres.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  Envíe la imagen por push al espacio de nombres de {{site.data.keyword.registryshort_notm}}.

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  Cree una reclamación de volumen permanente creando un archivo `.yaml` de configuración. En este ejemplo se utiliza una clase de almacenamiento de menor rendimiento. Ejecute `kubectl get storageclasses` para ver las clases de almacenamiento disponibles.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  Cree la reclamación de volumen permanente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  Cree un archivo de configuración y monte el volumen y ejecute el pod desde la imagen nonroot. La vía de acceso de montaje del volumen `/mnt/myvol` coincide con la vía de acceso especificada en el Dockerfile. Guarde la configuración como archivo `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  Cree el pod y monte la reclamación de volumen permanente en el pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. Verifique que el volumen se ha montado correctamente en el pod.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    El punto de montaje se muestra en el campo **Volume Mounts** y el volumen se muestra en el campo **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. Inicie la sesión en el pod después de que el pod esté en ejecución.

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. Vea permisos de la vía de acceso de montaje de volumen.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    Esta salida muestra que el usuario root tiene permisos de lectura, escritura y ejecución en la vía de acceso de montaje `mnt/myvol/`, pero el usuario no root myguest tiene permiso para leer y escribir en la carpeta `mnt/myvol/mydata`. Debido a estos permisos actualizados, el usuario no root ahora puede escribir datos en el volumen persistente.


