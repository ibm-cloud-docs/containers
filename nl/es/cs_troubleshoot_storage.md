---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-05"

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


# Resolución de problemas del almacenamiento del clúster
{: #cs_troubleshoot_storage}

Si utiliza {{site.data.keyword.containerlong}}, tenga en cuenta estas técnicas para solucionar problemas relacionados con el almacenamiento del clúster.
{: shortdesc}

Si tiene un problema más general, pruebe la [depuración del clúster](/docs/containers?topic=containers-cs_troubleshoot).
{: tip}

## En un clúster multizona, un volumen persistente no se puede montar en un pod
{: #mz_pv_mount}

{: tsSymptoms}
El clúster era anteriormente un clúster de una sola zona con nodos trabajadores autónomos que no estaban en agrupaciones de nodos trabajadores. Ha montado correctamente una reclamación de volumen persistente (PVC) que describía el volumen persistente (PV) que se utilizará para el despliegue del pod de la app. Sin embargo, ahora que tiene agrupaciones de nodos trabajadores y que ha añadido zonas al clúster, el PV no se puede montar en un pod.

{: tsCauses}
Para los clústeres multizona, los PV deben tener las siguientes etiquetas para que los pods no intenten montar volúmenes en otra zona.
* `failure-domain.beta.kubernetes.io/region`
* `failure-domain.beta.kubernetes.io/zone`

Los nuevos clústeres con agrupaciones de nodos trabajadores que pueden abarcar varias zonas etiquetan los PV de forma predeterminada. Si ha creado clústeres antes de que se hayan incorporado las agrupaciones de nodos trabajadores, debe añadir las etiquetas manualmente.

{: tsResolve}
[Actualice los PV en el clúster con las etiquetas de región y de zona](/docs/containers?topic=containers-kube_concepts#storage_multizone).

<br />


## Almacenamiento de archivos: los sistemas de archivos de los nodos trabajadores cambian a solo lectura
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Puede ver uno de los siguientes síntomas:
- Cuando ejecuta `kubectl get pods -o wide`, ve que varios pods que se están ejecutando en el mismo nodo trabajador quedan bloqueados en el estado `ContainerCreating`.
- Cuando se ejecuta un mandato `kubectl describe`, ve el siguiente error en la sección **Events**: `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
El sistema de archivos del nodo trabajador es de sólo lectura.

{: tsResolve}
1.  Haga una copia de seguridad de los datos que puedan estar almacenados en el nodo trabajador o en los contenedores.
2.  Para un arreglo a corto plazo para el nodo trabajador existente, recargue el nodo trabajador.
    <pre class="pre"><code>ibmcloud ks worker-reload --cluster &lt;cluster_name&gt; --worker &lt;worker_ID&gt;</code></pre>

Para un arreglo a largo plazo, [actualice el tipo de máquina de la agrupación de nodos trabajadores](/docs/containers?topic=containers-update#machine_type).

<br />



## Almacenamiento de archivos: la app falla cuando un usuario no root es propietario de la vía de acceso de montaje del almacenamiento de archivos NFS
{: #nonroot}

{: tsSymptoms}
Después de [añadir almacenamiento NFS](/docs/containers?topic=containers-file_storage#file_app_volume_mount) a su despliegue, el despliegue de su contenedor falla. Al recuperar los registros del contenedor, podría ver errores como los siguientes. El pod falla y queda atascado en un ciclo de recarga.

```
write-permission
```
{: screen}

```
no tiene el permiso necesario
```
{: screen}

```
no se puede crear el directorio '/bitnami/mariadb/data': Permiso denegado
```
{: screen}

{: tsCauses}
De forma predeterminada, los usuarios no root no tienen permiso de escritura sobre la vía de acceso de montaje del volumen para el almacenamiento respaldado por NFS. Algunas imágenes comunes de app, como por ejemplo Jenkins y Nexus3, especifican un usuario no root que posee la vía de acceso de montaje en Dockerfile. Cuando se crea un contenedor desde este Dockerfile, la creación del contenedor falla debido a permisos insuficientes del usuario no root en la vía de acceso de montaje. Para otorgar permiso de escritura, puede modificar el Dockerfile para añadir temporalmente el usuario no root al grupo de usuarios root antes de cambiar los permisos de la vía de acceso de montaje, o utilizar un contenedor de inicialización.

Si utiliza un diagrama de Helm para desplegar la imagen, edite el despliegue de Helm para utilizar un contenedor de inicialización.
{:tip}



{: tsResolve}
Cuando se incluye un [contenedor de inicialización ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) en el despliegue, puede dar a un usuario no root especificado en el Dockerfile permisos de escritura para la vía de acceso de montaje del volumen dentro del contenedor. El contenedor de inicialización de inicia antes que el contenedor de la app. El contenedor de inicialización crea la vía de acceso de montaje del volumen dentro del contenedor, cambia la propiedad de la vía de acceso de montaje al usuario (no root) correcto y se cierra. A continuación, se inicia el contenedor de la app con el usuario no root que debe escribir en la vía de acceso de montaje. Dado que la vía de acceso ya es propiedad del usuario no root, la escritura en la vía de acceso de montaje se realiza correctamente. Si no desea utilizar un contenedor de inicialización, puede modificar el Dockerfile para añadir acceso de usuario no root al almacenamiento de archivos NFS.


Antes de empezar: [Inicie la sesión en su cuenta. Elija como destino la región adecuada y, si procede, el grupo de recursos. Establezca el contexto para el clúster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Abra el Dockerfile para la app y obtenga el ID de usuario (UID) y el ID de grupo (GID) del usuario al que desea dar permiso de escritura en la vía de acceso de montaje del volumen. En el ejemplo de un Dockerfile de Jenkins, la información es la siguiente:
    - UID: `1000`
    - GID: `1000`

    **Ejemplo**:

    ```
    FROM openjdk:8-jdk

    RUN apt-get update &&apt-get install -y git curl &&rm -rf /var/lib/apt/lists/*

    ARG user=jenkins
    ARG group=jenkins
    ARG uid=1000
    ARG gid=1000
    ARG http_port=8080
    ARG agent_port=50000

    ENV JENKINS_HOME /var/jenkins_home
    ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
    ...
    ```
    {:screen}

2.  Añade almacenamiento persistente a la app creando una reclamación de volumen persistente (PVC). En este ejemplo se utiliza la clase de almacenamiento `ibmc-file-bronze`. Para revisar las clases de almacenamiento disponibles, ejecute `kubectl get storageclasses`.

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

3.  Cree la PVC.

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  En el archivo `.yaml` de despliegue, añada el contenedor de inicialización. Incluya el UID y el GID que ha recuperado anteriormente.

    ```
    initContainers:
    - name: initcontainer # Or replace the name
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Replace UID and GID with values from the Dockerfile
      volumeMounts:
      - name: volume # Or you can replace with any name
        mountPath: /mount # Must match the mount path in the args line
    ```
    {: codeblock}

    **Ejemplo** para un despliegue de Jenkins:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my_pod
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: jenkins      
      template:
        metadata:
          labels:
            app: jenkins
        spec:
          containers:
          - name: jenkins
            image: jenkins
            volumeMounts:
            - mountPath: /var/jenkins_home
              name: volume
          volumes:
          - name: volume
            persistentVolumeClaim:
              claimName: mypvc
          initContainers:
          - name: permissionsfix
            image: alpine:latest
            command: ["/bin/sh", "-c"]
            args:
              - chown 1000:1000 /mount;
            volumeMounts:
            - name: volume
              mountPath: /mount
    ```
    {: codeblock}

5.  Cree el pod y monte la PVC en el pod.

    ```
    kubectl apply -f my_pod.yaml
    ```
    {: pre}

6. Verifique que el volumen se ha montado correctamente en el pod. Anote el nombre de pod y la vía de acceso de **Containers/Mounts**.

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **Salida de ejemplo**:

    ```
    Name:		    mypod-123456789
    Namespace:	default
    ...
    Init Containers:
    ...
    Mounts:
      /mount from volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Containers:
      jenkins:
        Container ID:
        Image:		jenkins
        Image ID:
        Port:		  <none>
        State:		Waiting
          Reason:		PodInitializing
        Ready:		False
        Restart Count:	0
        Environment:	<none>
        Mounts:
          /var/jenkins_home from volume (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

7.  Inicie la sesión en el pod utilizando el nombre de pod que ha anotado anteriormente.

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. Verifique los permisos de la vía de acceso de montaje del contenedor. En el ejemplo, la vía de acceso de montaje es `/var/jenkins_home`.

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **Salida de ejemplo**:

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    Esta salida muestra que el GID y el UID del Dockerfile (en este ejemplo, `1000` y `1000`) poseen la vía de acceso de montaje dentro del contenedor.

<br />


## Almacenamiento de archivos: la adición de acceso de usuario no root al almacenamiento persistente no se realiza correctamente
{: #cs_storage_nonroot}

{: tsSymptoms}
Después de [añadir acceso de usuario no root al almacenamiento persistente](#nonroot) o de desplegar un diagrama de Helm con un ID de usuario no root especificado, el usuario no puede grabar en el almacenamiento montado.

{: tsCauses}
En la configuración del diagrama de Helm o el despliegue se especifica el [contexto de seguridad](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) para el ID de grupo (`fsGroup`) y el ID de usuario (`runAsUser`) del pod. Actualmente, {{site.data.keyword.containerlong_notm}} no soporta la especificación de `fsGroup` y sólo soporta que `runAsUser` se establezca como `0` (permisos root).

{: tsResolve}
Elimine los campos `securityContext` de la configuración para `fsGroup` y `runAsUser` de la imagen, despliegue o archivo de configuración de diagrama de Helm y vuelva a desplegar. Si tiene que cambiar la propiedad de la vía de acceso de montaje de `nobody`, [añada acceso de usuario non-root](#nonroot). Después de añadir [non-root `initContainer`](#nonroot), establezca `runAsUser` al nivel del contenedor, no a nivel de pod.

<br />




## Almacenamiento en bloque: cambio del almacenamiento en bloque a solo lectura
{: #readonly_block}

{: tsSymptoms}
Es posible que
note los siguientes síntomas:
- Cuando ejecuta `kubectl get pods -o wide`, ve que varios pods del mismo nodo trabajador quedan bloqueados en el estado `ContainerCreating` o `CrashLoopBackOff`. Todos estos pods utilizan la misma instancia de almacenamiento en bloque.
- Cuando ejecuta un mandato `kubectl describe pod`, ve el siguiente error en la sección **Events**: `MountVolume.SetUp failed for volume ... read-only`.

{: tsCauses}
Si se produce un error de red mientras un pod escribe en un volumen, la infraestructura de IBM Cloud (SoftLayer) protege los datos del volumen para que no resulten dañados cambiando el volumen a una modalidad de solo lectura. Los pods que utilizan este volumen no pueden seguir grabando en el volumen y dan un error.

{: tsResolve}
1. Compruebe la versión del plugin {{site.data.keyword.Bluemix_notm}} Block Storage que está instalado en el clúster.
   ```
   helm ls
   ```
   {: pre}

2. Compruebe que utiliza la [versión más reciente del plugin {{site.data.keyword.Bluemix_notm}} Block Storage](https://cloud.ibm.com/kubernetes/solutions/helm-charts/ibm/ibmcloud-block-storage-plugin). Si no es así, [actualice el plugin](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in).
3. Si ha utilizado un despliegue de Kubernetes para el pod, reinicie el pod que está fallando eliminando el pod y dejando que Kubernetes lo vuelva a crear. Si no ha utilizado un despliegue, recupere el archivo YAML que se ha utilizado para crear el pod con el mandato `kubectl get pod <pod_name> -o yaml >pod.yaml`. A continuación, suprima y vuelva a crear manualmente el pod.
    ```
    kubectl delete pod <pod_name>
    ```
    {: pre}

4. Compruebe si volver a crear el pod ha resuelto el problema. Si no es así, vuelva a cargar el nodo trabajador.
   1. Busque el nodo trabajador en el que se ejecuta el pod y anote la dirección IP privada asignada al nodo trabajador.
      ```
      kubectl describe pod <pod_name> | grep Node
      ```
      {: pre}

      Salida de ejemplo:
      ```
      Node:               10.75.XX.XXX/10.75.XX.XXX
      Node-Selectors:  <none>
      ```
      {: screen}

   2. Recupere el **ID** del nodo trabajador utilizando la dirección IP privada del paso anterior.
      ```
      ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
      {: pre}

   3. [Vuelva a cargar el nodo trabajador](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload).


<br />


## Almacenamiento en bloque: el montaje del almacenamiento en bloques existente en un pod falla debido al sistema de archivos incorrecto
{: #block_filesystem}

{: tsSymptoms}
Cuando ejecuta `kubectl describe pod <pod_name>`, ve el siguiente error:
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
Puede tener un dispositivo de almacenamiento en bloques configurado con un sistema de archivos `XFS`. Para montar este dispositivo en el pod, [creó un PV](/docs/containers?topic=containers-block_storage#existing_block) que especificaba `ext4` como su sistema de archivos o bien no se especificaba ningún sistema de archivos en la sección `spec/flexVolume/fsType`. Si no se define un sistema de archivos, el valor predeterminado para el PV es `ext4`.
El PV se creó satisfactoriamente y se enlazó a la instancia de almacenamiento en bloques existente. Sin embargo, cuando se intentó montar el PV a su clúster mediante una PVC coincidente, el volumen no se pudo montar. No se puede montar una instancia de almacenamiento en bloques `XFS` con un sistema de archivos `ext4` en el pod.

{: tsResolve}
Actualice el sistema de archivos en el PV existente de `ext4` a `XFS`.

1. Liste los PV existentes en el clúster y anote el nombre del VF que ha utilizado para la instancia de almacenamiento en bloques existente.
   ```
   kubectl get pv
   ```
   {: pre}

2. Guarde el archivo YAML del PV en la máquina local.
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. Abra el archivo YAML y cambie el `fsType` de `ext4` a `xfs`.
4. Sustituya el PV en el clúster.
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. Inicie una sesión en el pod en el que ha montado el PV.
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. Verifique el sistema de archivos ha cambiado a `XFS`.
   ```
   df -Th
   ```
   {: pre}

   Salida de ejemplo:
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## Almacenamiento de objetos: la instalación del plugin `ibmc` Helm de {{site.data.keyword.cos_full_notm}} falla
{: #cos_helm_fails}

{: tsSymptoms}
Cuando instala el plugin `ibmc` Helm de {{site.data.keyword.cos_full_notm}}, la instalación falla con el error siguiente:
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
Cuando se instala el plugin `ibmc` Helm, se crea un enlace simbólico desde el directorio `./helm/plugins/helm-ibmc` al directorio donde se encuentra el plugin `ibmc` Helm en el sistema local, que normalmente se encuentra en `./ibmcloud-object-storage-plugin/helm-ibmc`. Cuando se elimina el plugin `ibmc` Helm del sistema local o se mueve el directorio del plugin `ibmc` a una ubicación distinta, el enlace simbólico no se elimina.

{: tsResolve}
1. Elimine el plugin Helm de {{site.data.keyword.cos_full_notm}}.
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

2. [Instale {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-object_storage#install_cos).

<br />


## Almacenamiento de objetos: la creación de PVC o pod falla debido a que no encuentra el secreto de Kubernetes
{: #cos_secret_access_fails}

{: tsSymptoms}
Cuando se crea la PVC o se despliega un pod que monta la PVC, la creación o el despliegue fallan.

- Mensaje de error de ejemplo para un error de creación de PVC:
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- Mensaje de error de ejemplo para un error de creación de pod:
  ```
  persistentvolumeclaim "pvc-3" not found (repeated 3 times)
  ```
  {: screen}

{: tsCauses}
El secreto de Kubernetes donde se almacenan las credenciales de servicio de {{site.data.keyword.cos_full_notm}}, la PVC y el pod no están en el mismo espacio de nombres de Kubernetes. Cuando se despliega el secreto en un espacio de nombres distinto que la PVC o el pod, no se puede acceder al secreto.

{: tsResolve}
Esta tarea requiere el [rol de servicio de {{site.data.keyword.Bluemix_notm}} IAM de **Escritor** o de **Gestor**](/docs/containers?topic=containers-users#platform) sobre todos los espacios de nombres.

1. Liste los secretos del clúster y revise el espacio de nombres de Kubernetes en el que se ha creado el secreto de Kubernetes para la instancia de servicio de {{site.data.keyword.cos_full_notm}}. El secreto debe mostrar `ibm/ibmc-s3fs` como **Tipo**.
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}

2. Compruebe el archivo de configuración YAML para la PVC y el pod para verificar que ha utilizado el mismo espacio de nombres. Si desea desplegar un pod en un espacio de nombres distinto al del secreto, [cree otro secreto](/docs/containers?topic=containers-object_storage#create_cos_secret) en dicho espacio de nombres.

3. Cree la PVC o despliegue el pod en el espacio de nombres adecuado.

<br />


## Almacenamiento de objetos: la creación de la PVC falla debido a credenciales erróneas o acceso denegado
{: #cred_failure}

{: tsSymptoms}
Cuando crea la PVC, ve un mensaje de error similar a uno de los siguientes:

```
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```
AccessDenied: Access Denied status code: 403
```
{: screen}

```
CredentialsEndpointError: failed to load credentials
```
{: screen}

{: tsCauses}
Las credenciales de servicio de {{site.data.keyword.cos_full_notm}} que utiliza para acceder a la instancia de servicio pueden ser erróneas, o permitir solo el acceso de lectura al grupo.

{: tsResolve}
1. En la navegación de la página de detalles de servicio, pulse **Credenciales de servicio**.
2. Busque las credenciales y, a continuación, pulse **Ver credenciales**.
3. Verifique que utiliza el valor correcto de **access_key_id** y **secret_access_key** en el secreto de Kubernetes. Si no es así, actualice el secreto de Kubernetes.
   1. Obtenga el YAML que ha utilizado para crear el secreto.
      ```
      kubectl get secret <secret_name> -o yaml
      ```
      {: pre}

   2. Actualice los valores de **access_key_id** y **secret_access_key**.
   3. Actualice el secreto.
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

4. En la sección **iam_role_crn**, verifique que tiene el rol de `Escritor` o `Gestor`. Si no tiene el rol correcto, debe [crear nuevas credenciales de servicio de {{site.data.keyword.cos_full_notm}} con el permiso correcto](/docs/containers?topic=containers-object_storage#create_cos_service). A continuación, actualice el secreto existente o [cree un nuevo secreto](/docs/containers?topic=containers-object_storage#create_cos_secret) con las nuevas credenciales de servicio.

<br />


## Almacenamiento de objetos: no se puede acceder a un grupo existente

{: tsSymptoms}
Cuando se crea la PVC, no se puede acceder al grupo de {{site.data.keyword.cos_full_notm}}. Aparece un mensaje de error similar al siguiente:

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
Es posible que haya utilizado la clase de almacenamiento errónea para acceder al grupo, o que haya intentado acceder a un grupo que no ha creado.

{: tsResolve}
1. Desde el [panel de control de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../icons/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/), seleccione la instancia de servicio de {{site.data.keyword.cos_full_notm}}.
2. Seleccione **Grupos**.
3. Revise la información de **Clase** y **Ubicación** para el grupo existente.
4. Elija la [clase de almacenamiento](/docs/containers?topic=containers-object_storage#cos_storageclass_reference) adecuada.

<br />


## Almacenamiento de objetos: falla el acceso a los archivos con un usuario no root
{: #cos_nonroot_access}

{: tsSymptoms}
Ha subido archivos a la instancia de servicio de {{site.data.keyword.cos_full_notm}} utilizando la consola o la API REST. Cuando intenta acceder a estos archivos con un usuario no root que ha definido con `runAsUser` en el despliegue de la app, se deniega el acceso a los archivos.

{: tsCauses}
En Linux, un archivo o un directorio tienen 3 grupos de acceso: `Owner`, `Group` y `Other`. Cuando sube un archivo a {{site.data.keyword.cos_full_notm}} mediante la consola o la API REST, se eliminan los permisos de `Owner`, `Group` y `Other`. El permiso de cada archivo tiene el aspecto siguiente:

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

Cuando carga un archivo utilizando el plugin de {{site.data.keyword.cos_full_notm}}, los permisos para el archivo se conservan y no se modifican.

{: tsResolve}
Para acceder al archivo con un usuario no root, el usuario no root debe tener permisos de lectura y escritura en el archivo. Para cambiar el permiso de un archivo como parte del despliegue del pod, es necesaria una operación de escritura. {{site.data.keyword.cos_full_notm}} no está diseñado para cargas de trabajo de escritura. La actualización de permisos durante el despliegue de pod puede impedir que el pod pase a un estado `En ejecución`.

Para resolver este problema, antes de montar la PVC en el pod de la app, cree otro pod para establecer el permiso correcto para el usuario no root.

1. Compruebe los permisos de los archivos en el grupo.
   1. Cree un archivo de configuración para el pod `test-permission` y nombre el archivo `test-permission.yaml`.
      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: test-permission
      spec:
        containers:
        - name: test-permission
          image: nginx
          volumeMounts:
          - name: cos-vol
            mountPath: /test
        volumes:
        - name: cos-vol
          persistentVolumeClaim:
            claimName: <pvc_name>
      ```
      {: codeblock}

   2. Cree el pod `test-permission`.
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}

   3. Inicie una sesión en el pod.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   4. Vaya a la vía de acceso de montaje y liste los permisos de los archivos.
      ```
      cd test && ls -al
      ```
      {: pre}

      Salida de ejemplo:
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}

2. Suprima el pod.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

3. Cree un archivo de configuración para el pod que utilice para corregir los permisos de los archivos y denomínelo `fix-permission.yaml`.
   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: fix-permission 
     namespace: <namespace>
   spec:
     containers:
     - name: fix-permission
       image: busybox
       command: ['sh', '-c']
       args: ['chown -R <nonroot_userID> <mount_path>/*; find <mount_path>/ -type d -print -exec chmod u=+rwx,g=+rx {} \;']
       volumeMounts:
       - mountPath: "<mount_path>"
         name: cos-volume
     volumes:
     - name: cos-volume
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

3. Cree el pod `fix-permission`.
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}

4. Espere a que el pod pase al estado `Completed`.  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. Suprima el pod `fix-permission`.
   ```
   kubectl delete pod fix-permission
   ```
   {: pre}

5. Vuelva a crear el pod `test-permission` que ha utilizado anteriormente para comprobar los permisos.
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}

5. Verifique que los permisos de los archivos se han actualizado.
   1. Inicie una sesión en el pod.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   2. Vaya a la vía de acceso de montaje y liste los permisos de los archivos.
      ```
      cd test && ls -al
      ```
      {: pre}

      Salida de ejemplo:
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}

6. Suprima el pod `test-permission`.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

7. Monte la PVC en la app con el usuario no root.

   Defina el usuario no root como `runAsUser` sin establecer `fsGroup` en el YAML de despliegue al mismo tiempo. Al establecer `fsGroup`, se provoca que el plugin de {{site.data.keyword.cos_full_notm}} actualice los permisos de grupo para todos los archivos de un grupo cuando se despliega el pod. La actualización de los permisos es una operación de escritura y puede impedir que el pod pase a un estado `En ejecución`.
   {: important}

Después de establecer los permisos de archivo correctos en la instancia de servicio de {{site.data.keyword.cos_full_notm}}, no cargue archivos utilizando la consola ni la API REST. Utilice el plugin de {{site.data.keyword.cos_full_notm}} para añadir archivos a la instancia de servicio.
{: tip}

<br />




## Obtención de ayuda y soporte
{: #storage_getting_help}

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

