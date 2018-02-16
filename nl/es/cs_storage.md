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


# Guardado de datos con almacenamiento de volumen permanente
{: #planning}

Un contenedor es efímero por diseño. Sin embargo, tal como se muestra en el siguiente diagrama, puede elegir entre varias opciones para conservar los datos en caso de migración tras error de un contenedor y para compartir datos entre contenedores.
{:shortdesc}

**Nota**: si tiene un cortafuegos, [permita el acceso de salida](cs_firewall.html#pvc) para los rangos de IP de la infraestructura de IBM Cloud (SoftLayer) de las ubicaciones (centros de datos) en las que están en los clústeres, de modo que pueda crear reclamaciones de volumen permanente.

![Opciones de almacenamiento permanente para despliegues en clústeres de Kubernetes](images/cs_planning_apps_storage.png)

|Opción|Descripción|
|------|-----------|
|Opción 1: utilice `/emptyDir` para conservar los datos utilizando el espacio de disco disponible en el nodo trabajador<p>Esta característica está disponible para clústeres lite y estándares.</p>|Con esta opción, puede crear un volumen vacío en el espacio de disco del nodo trabajador asignado a un pod. El contenedor de dicho pod puede leer y grabar en ese volumen. Puesto que el volumen se asigna a un determinado pod, los datos no se pueden compartir con otros pods de un conjunto de réplicas.<p>Un volumen `/emptyDir` y sus datos se eliminan cuando el pod asignado se suprime de forma permanente del nodo trabajador.</p><p>**Nota:** Si el contenedor contenido en el pod se cuelga, los datos del volumen siguen estando disponibles en el nodo trabajador.</p><p>Para obtener más información, consulte [Volúmenes de Kubernetes ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/storage/volumes/).</p>|
|Opción 2: cree reclamaciones de volumen permanente para proporcionar almacenamiento permanente basado en NFS para el despliegue<p>Esta característica solo está disponible para clústeres estándares.</p>|<p>Con esta opción, tiene almacenamiento permanente de datos de la app y del contenedor mediante volúmenes permanentes. Los volúmenes se alojan en [almacenamiento de archivos basado en NFS de Resistencia y Rendimiento ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/file-storage/details). El almacenamiento de archivos se cifra en reposo, y puede crear réplicas de los datos almacenados.</p> <p>Puede crear una [reclamación de volumen permanente](cs_storage.html) para iniciar una solicitud de almacenamiento de archivos basado en NFS. {{site.data.keyword.containershort_notm}} proporciona clases de almacenamiento predefinidas que definen el rango de tamaños del almacenamiento, IOPS, la política de supresión y los permisos de lectura y escritura para el volumen. Puede elegir entre clases de almacenamiento cuando cree la reclamación de volumen permanente. Después de enviar una reclamación de volumen permanente, {{site.data.keyword.containershort_notm}} suministra de forma dinámica un volumen permanente alojado en almacenamiento de archivos basado en NFS. [Puede montar la reclamación de volumen permanente](cs_storage.html#create) como un volumen en su despliegue para permitir que los contenedores lean el volumen y graben en el mismo. Los volúmenes permanentes se pueden compartir en el mismo conjunto de réplicas o con otros despliegues del mismo clúster.</p><p>Cuando un contenedor se cuelga o un pod se retira de un nodo trabajador, los datos no se eliminan y pueden acceder a los mismos otros despliegues que monten el volumen. Las reclamaciones de volúmenes permanentes se guardan en almacén permanente pero no tienen copias de seguridad. Si requiere una copia de seguridad de los datos, debe crear una copia de seguridad manual.</p><p>**Nota:** El almacenamiento compartido de archivos NFS permanentes se factura mensualmente. Si suministra almacenamiento permanente para el clúster y lo retira de inmediato, paga igualmente el cargo mensual del almacenamiento permanente, aunque solo lo haya utilizado un breve periodo de tiempo.</p>|
|Opción 3: enlace un servicio de base de datos de {{site.data.keyword.Bluemix_notm}}
al pod<p>Esta característica está disponible para clústeres lite y estándares.</p>|Con esta opción, puede persistir y acceder a datos utilizando un servicio de la nube de base de datos de {{site.data.keyword.Bluemix_notm}}. Cuando enlaza el servicio {{site.data.keyword.Bluemix_notm}} a un espacio de nombres del clúster, se crea un secreto
de Kubernetes. El secreto de Kubernetes contiene información confidencial sobre el servicio, como por ejemplo el URL del servicio y su nombre de usuario y contraseña. Puede montar el secreto como un volumen secreto en el pod y acceder al servicio mediante las credenciales del secreto. Si monta el volumen secreto en otros pods, también puede compartir datos entre pods.<p>Cuando un contenedor se cuelga o un pod se retira de un nodo trabajador, los datos no se eliminan y pueden acceder a los mismos otros pods que monten el volumen secreto.</p><p>La mayoría de servicios de base de datos de {{site.data.keyword.Bluemix_notm}} proporcionan espacio en disco para una cantidad de datos pequeña sin coste, para así poder probar sus características.</p><p>Para obtener más información sobre cómo enlazar un servicio de {{site.data.keyword.Bluemix_notm}} a un pod, consulte [Adición de servicios de {{site.data.keyword.Bluemix_notm}} correspondientes a apps en {{site.data.keyword.containershort_notm}}](cs_integrations.html#adding_app).</p>|
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

IBM coloca el almacén de archivos NFS que contiene el volumen permanente en un clúster para ofrecer una alta disponibilidad de los datos.

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

2.  Decida si desea guardar los datos y la compartición de archivos NFS después de suprimir pvc. Si desea conservar los datos, seleccione la clase de almacenamiento `retain`. Si desea que los datos y la compartición de archivos se supriman cuando suprima el pvc, elija una clase de almacenamiento sin `retain`.

3.  Revise el IOPS de una clase de almacenamiento y los tamaños de almacenamiento disponibles.

    - Las clases de almacenamiento de bronce, plata y oro utilizan [Almacenamiento resistente ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/endurance-storage) y tienen un único IOPS definido por GB para cada clase. El IOPS total depende del tamaño del almacenamiento. Por ejemplo, 1000Gi pvc a 4 IOPS por GB tiene un total de 4000 IOPS.

      ```
      kubectl describe storageclasses ibmc-file-silver
      ```
      {: pre}

      El campo **parameters** proporciona el IOPS por GB asociado a la clase de almacenamiento y los
tamaños disponibles en gigabytes.

      ```
      Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
      ```
      {: screen}

    - Las clases de almacenamiento personalizado utilizan [Almacenamiento de rendimiento ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://knowledgelayer.softlayer.com/topic/performance-storage) y ofrecen distintas opciones en cuanto al IOPS y tamaño totales.

      ```
      kubectl describe storageclasses ibmc-file-retain-custom
      ```
      {: pre}

      El campo **parameters** proporciona el IOPS asociado a la clase de almacenamiento y los tamaños disponibles en gigabytes. Por ejemplo, un 40Gi pvc puede seleccionar un IOPS que sea múltiplo de 100 que esté comprendido entre 100 y 2000 IOPS.

      ```
      Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
      ```
      {: screen}

4.  Cree un archivo de configuración para definir su reclamación de volumen permanente y guarde la configuración como archivo `.yaml`.

    Ejemplo para las clases de bronce, plata y oro:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
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

    Ejemplo para clases personalizadas:

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
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
      <li>ibmc-file-custom / ibmc-file-retain-custom: Varios valores de IOPS disponibles.

    </li> Si no especifica ninguna clase de almacenamiento, el volumen permanente se crea en la clase de almacenamiento de bronce ("bronze").</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Si elige un tamaño distinto del que aparece en la lista, el tamaño se redondea al alza. Si selecciona un tamaño mayor que el tamaño más grande, el tamaño se redondea a la baja.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>Esta opción solo se aplica a ibmc-file-custom / ibmc-file-retain-custom. Especifique el IOPS total para el almacenamiento. Ejecute `kubectl describe storageclasses ibmc-file-custom` para ver todas las opciones. Si elige un IOPS distinto del que aparece en la lista, el IOPS se redondea.</td>
    </tr>
    </tbody></table>

5.  Cree la reclamación de volumen permanente.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  Compruebe que la reclamación de volumen permanente se haya creado y vinculado al volumen permanente. Este proceso puede tardar unos minutos.

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    La salida es parecida a la siguiente.

    ```
    Name:  <pvc_name>
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
    <td><code>volumeMounts/mountPath</code></td>
    <td>La vía de acceso absoluta del directorio en el que el que está montado el volumen dentro del despliegue.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>El nombre del volumen que va a montar en el despliegue.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>El nombre del volumen que va a montar en el despliegue. Normalmente, este nombre es el mismo que <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>El nombre de la reclamación de volumen permanente que desea utilizar como volumen. Cuando monta el volumen en el despliegue, Kubernetes identifica el volumen permanente enlazado a la reclamación de volumen permanente y permite al usuario realizar operaciones de lectura y escritura en el volumen permanente.</td>
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

Para {{site.data.keyword.containershort_notm}}, el propietario predeterminado de la vía de acceso de montaje del volumen es el propietario `nobody`. Con el almacenamiento NFS, si el propietario no existe localmente en el pod, se crea el usuario `nobody`. Los volúmenes están configurados para reconocer el usuario root en el contenedor, el cual, para algunas apps es el único usuario dentro de un contenedor. Sin embargo, muchas apps especifican un usuario no root que no es `nobody` que escribe en la vía de acceso de montaje del contenedor. Algunas apps especifican que el volumen debe ser propiedad del usuario root. Las apps no suelen utilizar el usuario root por motivos de seguridad. Con todo, si su app requiere un usuario root, póngase en contacto con el servicio de asistencia de [{{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).


1.  Cree un Dockerfile en un directorio local. Este Dockerfile de ejemplo está creando un usuario no root denominado `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

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


